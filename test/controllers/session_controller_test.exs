defmodule OpensourceChallengeWeb.SessionControllerTest do
  use OpensourceChallengeWeb.ConnCase

  alias OpensourceChallenge.User

  setup %{conn: conn} do
    Repo.insert(
      User.create_changeset(%User{}, %{
        name: "Damian",
        email: "damian.senn@example.com",
        password: "1234qwer",
        password_confirmation: "1234qwer"
      })
    )

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "session token", %{conn: conn} do
    conn =
      post(conn, login_path(conn, :create), %{
        grant_type: "password",
        username: "damian.senn@example.com",
        password: "1234qwer"
      })

    assert json_response(conn, 200)["access_token"]
  end
end
