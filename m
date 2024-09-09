Return-Path: <netdev+bounces-126489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D14F97155E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41381C2216F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7D1B0104;
	Mon,  9 Sep 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0u6d7mzk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544195733A
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877988; cv=none; b=NAr90BaF7VnGZk7EI82owPCSF6O6wC9xAa0SenlOO+pQ2zu++BlRhgOZ/ER5Od1zGmYkhmvspGwMhtlXF9XU4t15PNyZwVhaJtdEq0jPzuEk9M623oaslm+3tjXU+OXZtTunUwz1wB5PZur5mpDu61D1yH4h+eRgHvZ7THIOaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877988; c=relaxed/simple;
	bh=hw8yQ0VolwvnBmKSF3LNIg7oRvWDO7NrzgXIKv0VxmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJdH7Sfz41+PXG04zSF7HDPUhQyh9C47Y3Ly3j5Ts3FXHHLXLUyk2vC63DDTrcyKucY4Cukf7Yg1EIorTKaUStnjmsNbxTPGqZYOTolM1jUm6WvRbdaMLXyLm1rVE+J7wEQHHAOXIrp07oMO3NJeIQNH25cCzMln+4Yh4/jj5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0u6d7mzk; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X2NT75smbz105G;
	Mon,  9 Sep 2024 12:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1725877979;
	bh=USLrcmWGFqTUBjA2tdW0YzQ39cdQX5h4S2o2tNzyS+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0u6d7mzkBO6aFeKEMuu2IYY0PL7osWBo2Z3PHskcQo/HMlMZmWYjCAGLF0I7wVc/j
	 fdo33Rz5+78d5pFRDkYqx76o5FSEsDIH5jWr7nV4xkkfOnnLBWIemB41drtOyzw6+O
	 QKHJF0tm4DVWbCLSWKgSOdo55lYImi8mC4rJtsZQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X2NT63tfBzxy;
	Mon,  9 Sep 2024 12:32:58 +0200 (CEST)
Date: Mon, 9 Sep 2024 12:32:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 4/6] selftest/landlock: Test file_send_sigiotask by
 sending out-of-bound message
Message-ID: <20240909.aekeexooNo8i@digikod.net>
References: <cover.1725657727.git.fahimitahera@gmail.com>
 <50daeed4d4f60d71e9564d0f24004a373fc5f7d5.1725657728.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50daeed4d4f60d71e9564d0f24004a373fc5f7d5.1725657728.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

This test does not cover hook_file_send_sigiotask(): the is_scoped
variable is never set to true.

On Fri, Sep 06, 2024 at 03:30:06PM -0600, Tahera Fahimi wrote:
> This patch adds a test to verify handling the signal scoping mechanism
> in file_send_sigiotask by triggering SIGURG through receiving an
> out-of-bound message in UNIX sockets.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> V4:
> * Using pipe instead of Poll for synchronization.
> ---
>  .../selftests/landlock/scoped_signal_test.c   | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> index c71fb83b7147..630f3a515731 100644
> --- a/tools/testing/selftests/landlock/scoped_signal_test.c
> +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> @@ -269,4 +269,103 @@ TEST(signal_scoping_threads)
>  	EXPECT_EQ(0, close(thread_pipe[1]));
>  }
>  
> +#define SOCKET_PATH "/tmp/unix_sock_test"

We must not create file on absolute paths because concurrent executions
or previous ones could interfer with the tests.  Why not use an abstract
unix socket created with set_unix_address()?

> +
> +const short backlog = 10;
> +
> +static volatile sig_atomic_t signal_received;
> +
> +static void handle_sigurg(int sig)
> +{
> +	if (sig == SIGURG)
> +		signal_received = 1;
> +	else
> +		signal_received = -1;
> +}
> +
> +static int setup_signal_handler(int signal)
> +{
> +	struct sigaction sa;
> +
> +	sa.sa_handler = handle_sigurg;
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_flags = SA_SIGINFO | SA_RESTART;
> +	return sigaction(SIGURG, &sa, NULL);
> +}
> +
> +/*
> + * Sending an out of bound message will trigger the SIGURG signal
> + * through file_send_sigiotask.
> + */
> +TEST(test_sigurg_socket)
> +{
> +	int sock_fd, recv_sock;
> +	struct sockaddr_un addr, paddr;
> +	socklen_t size;
> +	char oob_buf, buffer;
> +	int status;
> +	int pipe_parent[2], pipe_child[2];
> +	pid_t child;
> +
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +	snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", SOCKET_PATH);
> +	unlink(SOCKET_PATH);
> +	size = sizeof(addr);
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		oob_buf = '.';
> +
> +		ASSERT_EQ(0, close(pipe_parent[1]));
> +		ASSERT_EQ(0, close(pipe_child[0]));
> +
> +		sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +		ASSERT_NE(-1, sock_fd);
> +
> +		ASSERT_EQ(1, read(pipe_parent[0], &buffer, 1));
> +		ASSERT_EQ(0, connect(sock_fd, &addr, sizeof(addr)));
> +
> +		ASSERT_EQ(1, read(pipe_parent[0], &buffer, 1));
> +		ASSERT_NE(-1, send(sock_fd, &oob_buf, 1, MSG_OOB));
> +		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +
> +		EXPECT_EQ(0, close(sock_fd));
> +
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +	ASSERT_EQ(0, close(pipe_parent[0]));
> +	ASSERT_EQ(0, close(pipe_child[1]));
> +
> +	sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +	ASSERT_NE(-1, sock_fd);
> +	ASSERT_EQ(0, bind(sock_fd, &addr, size));
> +	ASSERT_EQ(0, listen(sock_fd, backlog));
> +
> +	ASSERT_NE(-1, setup_signal_handler(SIGURG));
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	recv_sock = accept(sock_fd, &paddr, &size);
> +	ASSERT_NE(-1, recv_sock);
> +
> +	create_scoped_domain(_metadata, LANDLOCK_SCOPED_SIGNAL);
> +
> +	ASSERT_NE(-1, fcntl(recv_sock, F_SETOWN, getpid()));
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
> +	ASSERT_EQ(1, recv(recv_sock, &oob_buf, 1, MSG_OOB));
> +
> +	ASSERT_EQ(1, signal_received);
> +	EXPECT_EQ(0, close(sock_fd));
> +	EXPECT_EQ(0, close(recv_sock));
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 

