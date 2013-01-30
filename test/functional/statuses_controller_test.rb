require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
  	sign_in users(:jon)
  	get :new
  	assert_response :success
  end

  test "should be logged in to post a status" do
  	post :create, status: { content: "Hello" }
  	assert_response :redirect
  	assert_redirected_to new_user_session_path
  end

  test "should create status when logged in" do
  	sign_in users(:jon)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status for current user when logged in" do
  	sign_in users(:jon)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:brooke) }
    end

    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:jon).id
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get edit when logged in" do
  	sign_in users(:jon)
    get :edit, id: @status
    assert_response :success
  end

  test "should redirect status update when not logged in" do
    put :update, id: @status, status: { content: @status.content }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update status when logged in" do
  	sign_in users(:jon)
    put :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should update status for current user when logged in" do
  	sign_in users(:jon)
    put :update, id: @status, status: { content: @status.content, user_id: users(:brooke) }
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:jon).id
  end

  test "should not update the status if nothing has changed" do
  	sign_in users(:jon)
    put :update, id: @status
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:jon).id
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
