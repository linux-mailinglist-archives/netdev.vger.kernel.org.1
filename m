Return-Path: <netdev+bounces-113060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAEE93C882
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA731C213F1
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560413BBC2;
	Thu, 25 Jul 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="t8trRPBj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67537700
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933616; cv=none; b=XYRFXl7v3xf1gzBnazug9C1AbqrmmGffChczpV16+K+KsS4Ya0LmWKkOQ3w1ZxdO8pSME2b1f+nq/ZBvY6rMMyeqcCymysr0Ny/sJZBxJdXoBBLAkfzh/Cute3qtmZbrm1XwADnCV/Rx5P2PvnnpDp2AuOOAwXlrwpyMxDdGMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933616; c=relaxed/simple;
	bh=2n3NvdW7ZZ5CBR3JsXIU8wAn+XVAnDi35Jo8wH4sgAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6SV++Go+qT52MMBNsANqo4vhOD4Z+juKpzOZ20ekkKiCVSYA0H7df7/HiQi/D+4etRJTu2WaV/qIw3lfVIYVbUacwCiZwjmjPCTAUE/oAHSfn8EmGclzquvvkL2uc6OKoeqBPmBqvR1/n1UaIg7WyWb/cXp5oXUSH7rcqve3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=t8trRPBj; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WVKll11K4zplT;
	Thu, 25 Jul 2024 20:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721933603;
	bh=1NTO2YHsR6j9yghcJaFm/X3h4wCtvkpFPVHqyckGJxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8trRPBjfUYxtF9dcB/8Dq+SrwY6mlwkEwX6LvHoX/fKPmfAeqT0uH9QwhefmYdW/
	 0dwNLYNitUeeH+ryNLiGT8zONMVX7YqxkSD9RB5hiE1y7/D9wEqLD8BoTTZs9XWYlE
	 TpHKP7s/uX0XuEu964VTljy25SVowmNX4+0K7NYI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WVKlj4yxxzTPV;
	Thu, 25 Jul 2024 20:53:21 +0200 (CEST)
Date: Thu, 25 Jul 2024 20:53:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 2/4] selftests/landlock: Abstract unix socket
 restriction tests
Message-ID: <20240725.uagai2jeiN4i@digikod.net>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <121e8df376327d8039266db19e53b8ff994b8d74.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <121e8df376327d8039266db19e53b8ff994b8d74.1721269836.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 10:15:20PM -0600, Tahera Fahimi wrote:
> The patch has three types of tests:
>   1) unix_socket: base tests the scoping mechanism for a landlocked process,
>      same as the ptrace test.
>   2) optional_scoping: generates three processes with different domains and
>      tests if a process with a non-scoped domain can connect to other processes.
>   3) unix_sock_special_cases: since the socket's creator credentials are used
>      for scoping datagram sockets, this test examines the cases where the
>      socket's credentials are different from the process using it.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

You need to add "---" here.  You can test the result by applying this
patch with `git am`: the comments after these three dashes will not be
inlcuded in the commit message.

> 
> Changes in versions:
> V7:
>  - Introducing landlock ABI version 6.
>  - Adding some edge test cases to optional_scoping test.
>  - Using `enum` for different domains in optional_scoping tests.
>  - Extend unix_sock_special_cases test cases for connected(SOCK_STREAM) sockets.
>  - Modifying inline comments.
> V6:
>  - Introducing optional_scoping test which ensures a sandboxed process with a
>    non-scoped domain can still connect to another abstract unix socket(either
>    sandboxed or non-sandboxed).
>  - Introducing unix_sock_special_cases test which tests examines scenarios where
>    the connecting sockets have different domain than the process using them.
> V4:
>  - Introducing unix_socket to evaluate the basic scoping mechanism for abstract
>    unix sockets.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  tools/testing/selftests/landlock/base_test.c  |   2 +-
>  .../testing/selftests/landlock/ptrace_test.c  | 867 ++++++++++++++++++
>  2 files changed, 868 insertions(+), 1 deletion(-)

Even if these tests are similar to the ptrace's ones, they don't share
code.  For maintainance reasons and test flexibility, we should have
these new tests in a "scoped_abstract_unix_test.c" file.

> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 3c1e9f35b531..52b00472a487 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(6, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index a19db4d0b3bd..e7dcefda8ce0 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c


> +/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent, child
> + * and grand child processes when they can have scoped or non-scoped
> + * domains.
> + **/
> +TEST_F(optional_scoping, unix_scoping)
> +{
> +	pid_t child;
> +	socklen_t addrlen;
> +	int sock_len = 5;
> +	int status;
> +	struct sockaddr_un addr = {
> +		.sun_family = AF_UNIX,
> +	};
> +	const char sun_path[8] = "\0test";
> +	bool can_connect_to_parent, can_connect_to_child;
> +	int pipe_parent[2];
> +
> +	if (variant->domain_grand_child == SCOPE_SANDBOX)
> +		can_connect_to_child = false;
> +	else
> +		can_connect_to_child = true;
> +
> +	if (!can_connect_to_child || variant->domain_children == SCOPE_SANDBOX)
> +		can_connect_to_parent = false;
> +	else
> +		can_connect_to_parent = true;
> +
> +	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
> +	memcpy(&addr.sun_path, sun_path, sock_len);
> +
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +
> +	if (variant->domain_all == OTHER_SANDBOX)
> +		create_domain(_metadata);
> +	else if (variant->domain_all == SCOPE_SANDBOX)
> +		create_unix_domain(_metadata);
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		int pipe_child[2];
> +		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +		pid_t grand_child;
> +		struct sockaddr_un child_addr = {
> +			.sun_family = AF_UNIX,
> +		};
> +		const char child_sun_path[8] = "\0tsst";

To avoid potential issues with conflicting names, we should use the same
sun_path as in net_test.c:set_service().  Same for all use of sun_path.

> +
> +		memcpy(&child_addr.sun_path, child_sun_path, sock_len);
> +
> +		if (variant->domain_children == OTHER_SANDBOX)
> +			create_domain(_metadata);
> +		else if (variant->domain_children == SCOPE_SANDBOX)
> +			create_unix_domain(_metadata);
> +
> +		grand_child = fork();
> +		ASSERT_LE(0, grand_child);
> +		if (grand_child == 0) {
> +			ASSERT_EQ(0, close(pipe_parent[1]));
> +			ASSERT_EQ(0, close(pipe_child[1]));
> +
> +			char buf1, buf2;
> +			int err;
> +
> +			if (variant->domain_grand_child == OTHER_SANDBOX)
> +				create_domain(_metadata);
> +			else if (variant->domain_grand_child == SCOPE_SANDBOX)
> +				create_unix_domain(_metadata);
> +
> +			self->client = socket(AF_UNIX, variant->type, 0);
> +			ASSERT_NE(-1, self->client);
> +
> +			ASSERT_EQ(1, read(pipe_child[0], &buf2, 1));
> +			err = connect(self->client,
> +				      (struct sockaddr *)&child_addr, addrlen);
> +			if (can_connect_to_child) {
> +				EXPECT_EQ(0, err);
> +			} else {
> +				EXPECT_EQ(-1, err);
> +				EXPECT_EQ(EPERM, errno);
> +			}
> +
> +			if (variant->type == SOCK_STREAM) {
> +				EXPECT_EQ(0, close(self->client));
> +				self->client =
> +					socket(AF_UNIX, variant->type, 0);
> +				ASSERT_NE(-1, self->client);
> +			}
> +
> +			ASSERT_EQ(1, read(pipe_parent[0], &buf1, 1));
> +			err = connect(self->client, (struct sockaddr *)&addr,
> +				      addrlen);
> +			if (can_connect_to_parent) {
> +				EXPECT_EQ(0, err);
> +			} else {
> +				EXPECT_EQ(-1, err);
> +				EXPECT_EQ(EPERM, errno);
> +			}
> +			EXPECT_EQ(0, close(self->client));
> +
> +			_exit(_metadata->exit_code);
> +			return;
> +		}
> +
> +		ASSERT_EQ(0, close(pipe_child[0]));
> +		if (variant->domain_child == OTHER_SANDBOX)
> +			create_domain(_metadata);
> +		else if (variant->domain_child == SCOPE_SANDBOX)
> +			create_unix_domain(_metadata);
> +
> +		self->child_server = socket(AF_UNIX, variant->type, 0);
> +		ASSERT_NE(-1, self->child_server);
> +		ASSERT_EQ(0, bind(self->child_server,
> +				  (struct sockaddr *)&child_addr, addrlen));
> +		if (variant->type == SOCK_STREAM)
> +			ASSERT_EQ(0, listen(self->child_server, 32));
> +
> +		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
> +		return;
> +	}
> +	ASSERT_EQ(0, close(pipe_parent[0]));
> +
> +	if (variant->domain_parent == OTHER_SANDBOX)
> +		create_domain(_metadata);
> +	else if (variant->domain_parent == SCOPE_SANDBOX)
> +		create_unix_domain(_metadata);
> +
> +	self->parent_server = socket(AF_UNIX, variant->type, 0);
> +	ASSERT_NE(-1, self->parent_server);
> +	ASSERT_EQ(0,
> +		  bind(self->parent_server, (struct sockaddr *)&addr, addrlen));
> +
> +	if (variant->type == SOCK_STREAM)
> +		ASSERT_EQ(0, listen(self->parent_server, 32));
> +
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +/*
> + * Since the special case of scoping only happens when the connecting socket
> + * is scoped, the client's domain is true for all the following test cases.
> + */
> +/* clang-format off */
> +FIXTURE(unix_sock_special_cases) {
> +	int server_socket, client;
> +	int stream_server, stream_client;
> +};
> +
> +/* clang-format on */
> +FIXTURE_VARIANT(unix_sock_special_cases)
> +{
> +	const bool domain_server;
> +	const bool domain_server_socket;
> +	const int type;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_dgram_server_sock_domain) {
> +	/* clang-format on */
> +	.domain_server = false,
> +	.domain_server_socket = true,
> +	.type = SOCK_DGRAM,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_dgram_server_domain) {
> +	/* clang-format off */
> +	.domain_server = true,
> +	.domain_server_socket = false,
> +	.type = SOCK_DGRAM,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_stream_server_sock_domain) {
> +	/* clang-format on */
> +	.domain_server = false,
> +	.domain_server_socket = true,
> +	.type = SOCK_STREAM,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_stream_server_domain) {
> +        /* clang-format off */
> +        .domain_server = true,
> +        .domain_server_socket = false,
> +        .type = SOCK_STREAM,
> +};
> +
> +FIXTURE_SETUP(unix_sock_special_cases)
> +{
> +}
> +
> +FIXTURE_TEARDOWN(unix_sock_special_cases)
> +{
> +	close(self->client);
> +	close(self->server_socket);
> +	close(self->stream_server);
> +	close(self->stream_client);
> +}
> +
> +/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and
> + * child processes when connecting socket has different domain
> + * than the process using it.
> + **/
> +TEST_F(unix_sock_special_cases, dgram_cases)
> +{
> +	pid_t child;
> +	socklen_t addrlen;
> +	int sock_len = 5;
> +	struct sockaddr_un addr, addr_stream = {
> +		.sun_family = AF_UNIX,
> +	};
> +	const char sun_path[8] = "\0test";
> +	const char sun_path_stream[8] = "\0strm";
> +	int err, status;
> +	int pipe_child[2], pipe_parent[2];
> +	char buf_parent;
> +
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +
> +	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
> +	memcpy(&addr.sun_path, sun_path, sock_len);
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		char buf_child;
> +
> +		ASSERT_EQ(0, close(pipe_parent[1]));
> +		ASSERT_EQ(0, close(pipe_child[0]));
> +
> +		/* client always has domain */
> +		create_unix_domain(_metadata);
> +
> +		if (variant->domain_server_socket) {
> +			int data_socket;
> +			int fd_sock = socket(AF_UNIX, variant->type, 0);
> +
> +			ASSERT_NE(-1, fd_sock);
> +
> +			self->stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
> +
> +			ASSERT_NE(-1, self->stream_server);
> +			memcpy(&addr_stream.sun_path, sun_path_stream,
> +			       sock_len);
> +			ASSERT_EQ(0, bind(self->stream_server,
> +					  (struct sockaddr *)&addr_stream,
> +					  addrlen));
> +			ASSERT_EQ(0, listen(self->stream_server, 32));
> +
> +			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +
> +			data_socket = accept(self->stream_server, NULL, NULL);
> +
> +			ASSERT_EQ(0, send_fd(data_socket, fd_sock));
> +			ASSERT_EQ(0, close(fd_sock));
> +			TH_LOG("sending completed\n");
> +		}
> +
> +		self->client = socket(AF_UNIX, variant->type, 0);
> +		ASSERT_NE(-1, self->client);
> +		/* wait for parent signal for connection */
> +		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> +
> +		err = connect(self->client, (struct sockaddr *)&addr, addrlen);
> +		if (!variant->domain_server_socket) {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(EPERM, errno);
> +		} else {
> +			EXPECT_EQ(0, err);
> +		}
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	ASSERT_EQ(0, close(pipe_child[1]));
> +	ASSERT_EQ(0, close(pipe_parent[0]));
> +
> +	if (!variant->domain_server_socket) {
> +		self->server_socket = socket(AF_UNIX, variant->type, 0);
> +	} else {
> +		int cli = socket(AF_UNIX, SOCK_STREAM, 0);
> +
> +		ASSERT_NE(-1, cli);
> +		memcpy(&addr_stream.sun_path, sun_path_stream, sock_len);
> +		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> +		ASSERT_EQ(0, connect(cli, (struct sockaddr *)&addr_stream,
> +				     addrlen));
> +
> +		self->server_socket = recv_fd(cli);
> +		ASSERT_LE(0, self->server_socket);
> +	}
> +
> +	ASSERT_NE(-1, self->server_socket);
> +
> +	if (variant->domain_server)
> +		create_unix_domain(_metadata);
> +
> +	ASSERT_EQ(0,
> +		  bind(self->server_socket, (struct sockaddr *)&addr, addrlen));
> +	if (variant->type == SOCK_STREAM)
> +		ASSERT_EQ(0, listen(self->server_socket, 32));
> +	/* signal to child that parent is listening */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 

