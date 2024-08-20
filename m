Return-Path: <netdev+bounces-120267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB70958BD4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75152851B6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE32195FF1;
	Tue, 20 Aug 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="K1ZfXWR7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB77195FD1
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169612; cv=none; b=b98rczMdrq2DfwoncnGLFKKG1UPRhXvATzeM/QHy/6OdCppPiKTjn6rkWLbKmORa0jQ7vQxqn4FMiNogBuS/S3maoY6D8AGMll9r83ZQMEFMFbHI+eL5p9uu8TzC/3UGbGDnaFnsTN3HuYSuZX42bR2/U/7j/tWEHwDVoC3I29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169612; c=relaxed/simple;
	bh=VIZkHJTiLp4Um8y5Tef7NNB7T4BLZiVolZJNDnCDQw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKSO+e5t1mIMuOFXMpNy/gpMbT+2g9uEKr9r5JiMUMHYLqzPRQUtJ9uWFdolWE6FYJ8jJHk7IZ8bnUeTD3aM3h8w3yiYnlIy4o10wjbqAsoe6SGw7NCZXgcIkfeh/4pKlyyy6vP7hdNutZeJPRsqWn5DRQr3Vl5f/xlgb+Z0zdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=K1ZfXWR7; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WpDgq0rN2zJym;
	Tue, 20 Aug 2024 18:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724169607;
	bh=X1PpVl4miMY+kqBS68Wybhu1sp9QMPc8/mX4zUxjaaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1ZfXWR7KQr/+Ku/uTvjjUFFI3t/K/6apzexi+nn+aTofs/vq2wwf+OhnBrUopCaS
	 MPZRQhhJFr+j9nYWT1tdeXuCfHfvSNKzVrZ35k01A8bROpAsJlIGeVa0pAu8VT42uX
	 tnE5hvvJk/RiYjmSkR/YUzNwvia/72k2D+0Pp9X8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WpDgp3ynfzQCd;
	Tue, 20 Aug 2024 18:00:06 +0200 (CEST)
Date: Tue, 20 Aug 2024 18:00:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v10 3/6] selftests/Landlock: Abstract UNIX socket
 restriction tests
Message-ID: <20240820.Yohzeik9dei5@digikod.net>
References: <cover.1724125513.git.fahimitahera@gmail.com>
 <01efd9cd2243b96e784e116510f5fca674b815b6.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01efd9cd2243b96e784e116510f5fca674b815b6.1724125513.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 19, 2024 at 10:08:53PM -0600, Tahera Fahimi wrote:
> The patch introduces Landlock ABI version 6 and adds three types of tests
> that examines different scenarios for abstract unix socket:
> 1) unix_socket: base tests of the abstract socket scoping mechanism for a
>    landlocked process, same as the ptrace test.
> 2) optional_scoping: generates three processes with different domains and
>    tests if a process with a non-scoped domain can connect to other
>    processes.
> 3) outside_socket: since the socket's creator credentials are used
>    for scoping sockets, this test examines the cases where the socket's
>    credentials are different from the process using it.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> Changes in versions:
> v10:
> - Code improvements by changing fixture variables to local ones.
> - Rename "unix_sock_special_cases" to "outside_socket"
> v9:
> - Move pathname_address_sockets to a different patch.
> - Extend optional_scoping test scenarios.
> - Removing hardcoded numbers and using "backlog" instead.
> V8:
> - Move tests to scoped_abstract_unix_test.c file.
> - To avoid potential conflicts among Unix socket names in different tests,
>   set_unix_address is added to common.h to set different sun_path for Unix sockets.
> - protocol_variant and service_fixture structures are also moved to common.h
> - Adding pathname_address_sockets to cover all types of address formats
>   for unix sockets, and moving remove_path() to common.h to reuse in this test.
> V7:
> - Introducing landlock ABI version 6.
> - Adding some edge test cases to optional_scoping test.
> - Using `enum` for different domains in optional_scoping tests.
> - Extend unix_sock_special_cases test cases for connected(SOCK_STREAM) sockets.
> - Modifying inline comments.
> V6:
> - Introducing optional_scoping test which ensures a sandboxed process with a
>   non-scoped domain can still connect to another abstract unix socket(either
>   sandboxed or non-sandboxed).
> - Introducing unix_sock_special_cases test which tests examines scenarios where
>   the connecting sockets have different domain than the process using them.
> V4:
> - Introducing unix_socket to evaluate the basic scoping mechanism for abstract
>   unix sockets.
> ---
>  tools/testing/selftests/landlock/common.h     |  38 +
>  tools/testing/selftests/landlock/net_test.c   |  31 +-
>  .../landlock/scoped_abstract_unix_test.c      | 931 ++++++++++++++++++
>  3 files changed, 970 insertions(+), 30 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c

> diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> new file mode 100644
> index 000000000000..65c1ac2895a9
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> @@ -0,0 +1,931 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - Abstract Unix Socket
> + *
> + * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/landlock.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stddef.h>
> +#include <sys/prctl.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "common.h"
> +
> +/* Number pending connections queue to be hold. */
> +const short backlog = 10;
> +
> +static void create_fs_domain(struct __test_metadata *const _metadata)
> +{
> +	int ruleset_fd;
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
> +	};
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	EXPECT_LE(0, ruleset_fd)
> +	{
> +		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
> +	}
> +	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
> +static void create_unix_domain(struct __test_metadata *const _metadata)
> +{
> +	int ruleset_fd;
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
> +	};
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	EXPECT_LE(0, ruleset_fd)
> +	{
> +		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
> +	}
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
> +/* clang-format off */
> +FIXTURE(unix_socket) {};
> +/* clang-format on */
> +
> +FIXTURE_VARIANT(unix_socket)

These variant fixture should be renamed to
FIXTURE_VARIANT(scoped_domains) to be usable for all scoped tests (e.g.
abstract unix socket and signal).  You can define them in a
scoped_common.h file which will be included by
scoped_abstract_unix_test.c and scoped_signal_test.c

> +{
> +	bool domain_both;
> +	bool domain_parent;
> +	bool domain_child;
> +	bool connect_to_parent;

connect_to_parent should not be part of a variant.  In this case, we can
create two TEST_F(): a TEST_F(to_parent) like when connect_to_parent is
true, and a TEST_F(to_child) otherwise.

scoped_signal_test.c should have the same TEST_F names with slightly
different implementation but still testing the same semantic.

> +};
> +
> +FIXTURE_SETUP(unix_socket)

The self->stream_address and self->dgram_address initializations were
good.  The issue was about socket's file descriptors, but if we have raw
data common to all tests, it makes sense to initialize them here.

> +{
> +}
> +
> +FIXTURE_TEARDOWN(unix_socket)
> +{
> +}
> +
> +/*
> + *        No domain
> + *
> + *   P1-.               P1 -> P2 : allow
> + *       \              P2 -> P1 : allow
> + *        'P2
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_without_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = false,
> +	.domain_child = false,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_without_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = false,
> +	.domain_child = false,
> +	.connect_to_parent = false,

We can see that the picture describing the domains is the same for both
of these variants, which means something is wrong.  connect_to_parent
should not be part of the variant definitions.

> +};
> +
> +/*
> + *        Child domain
> + *
> + *   P1--.              P1 -> P2 : allow
> + *        \             P2 -> P1 : deny
> + *        .'-----.
> + *        |  P2  |
> + *        '------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_with_one_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = false,
> +	.domain_child = true,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_with_one_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = false,
> +	.domain_child = true,
> +	.connect_to_parent = false,
> +};
> +
> +/*
> + *        Parent domain
> + * .------.
> + * |  P1  --.           P1 -> P2 : deny
> + * '------'  \          P2 -> P1 : allow
> + *            '
> + *            P2
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_with_parent_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = false,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_with_parent_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = false,
> +	.connect_to_parent = false,
> +};
> +
> +/*
> + *        Parent + child domain (siblings)
> + * .------.
> + * |  P1  ---.          P1 -> P2 : deny
> + * '------'   \         P2 -> P1 : deny
> + *         .---'--.
> + *         |  P2  |
> + *         '------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_with_sibling_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = true,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_with_sibling_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = true,
> +	.connect_to_parent = false,
> +};
> +
> +/*
> + *         Same domain (inherited)
> + * .-------------.
> + * | P1----.     |      P1 -> P2 : allow
> + * |        \    |      P2 -> P1 : allow
> + * |         '   |
> + * |         P2  |
> + * '-------------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_inherited_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = false,
> +	.domain_child = false,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_inherited_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = false,
> +	.domain_child = false,
> +	.connect_to_parent = false,
> +};
> +
> +/*
> + *         Inherited + child domain
> + * .-----------------.
> + * |  P1----.        |  P1 -> P2 : allow
> + * |         \       |  P2 -> P1 : deny
> + * |        .-'----. |
> + * |        |  P2  | |
> + * |        '------' |
> + * '-----------------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_nested_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = false,
> +	.domain_child = true,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_nested_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = false,
> +	.domain_child = true,
> +	.connect_to_parent = false,
> +};
> +
> +/*
> + *         Inherited + parent domain
> + * .-----------------.
> + * |.------.         |  P1 -> P2 : deny
> + * ||  P1  ----.     |  P2 -> P1 : allow
> + * |'------'    \    |
> + * |             '   |
> + * |             P2  |
> + * '-----------------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, allow_with_nested_and_parent_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = false,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_with_nested_and_parent_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = false,
> +	.connect_to_parent = false,
> +};
> +
> +/*
> + *         Inherited + parent and child domain (siblings)
> + * .-----------------.
> + * | .------.        |  P1 -> P2 : deny
> + * | |  P1  .        |  P2 -> P1 : deny
> + * | '------'\       |
> + * |          \      |
> + * |        .--'---. |
> + * |        |  P2  | |
> + * |        '------' |
> + * '-----------------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_with_forked_domain_connect_to_parent) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +	.connect_to_parent = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, deny_with_forked_domain_connect_to_child) {
> +	/* clang-format on */
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +	.connect_to_parent = false,
> +};
> +
> +/*
> + * Test unix_stream_connect()  and unix_may_send() for parent and child,
> + * when they have scoped domain or no domain.
> + */
> +TEST_F(unix_socket, abstract_unix_socket)
> +{
> +	struct service_fixture stream_address, dgram_address;
> +	pid_t child;
> +	bool can_connect_to_parent, can_connect_to_child;
> +	int err, err_dgram, status;
> +	int pipe_child[2], pipe_parent[2];
> +	char buf_parent;

For all TEST() and TEST_F(), in this patch series and the signal one, we
need to first drop capabilities:

drop_caps(_metadata);

> +
> +	memset(&stream_address, 0, sizeof(stream_address));
> +	memset(&dgram_address, 0, sizeof(dgram_address));
> +	set_unix_address(&stream_address, 0);
> +	set_unix_address(&dgram_address, 1);
> +	/*
> +	 * can_connect_to_child is true if a parent process can connect to its
> +	 * child process. The parent process is not isolated from the child
> +	 * with a dedicated Landlock domain.
> +	 */
> +	can_connect_to_child = !variant->domain_parent;
> +	/*
> +	 * can_connect_to_parent is true if a child process can connect to its
> +	 * parent process. This depends on the child process is not isolated from
> +	 * the parent with a dedicated Landlock domain.
> +	 */
> +	can_connect_to_parent = !variant->domain_child;
> +
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +	if (variant->domain_both) {
> +		create_unix_domain(_metadata);
> +		if (!__test_passed(_metadata))
> +			return;
> +	}
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		char buf_child;
> +
> +		ASSERT_EQ(0, close(pipe_parent[1]));
> +		ASSERT_EQ(0, close(pipe_child[0]));
> +		if (variant->domain_child)
> +			create_unix_domain(_metadata);
> +
> +		/* Waits for the parent to be in a domain, if any. */
> +		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> +
> +		if (variant->connect_to_parent) {
> +			int client, dgram_client;

It looks like you missed some of my previous reviews (e.g. variable
names).  Please read back again *all* my reviews/emails for at least the
last two versions.

> +
> +			client = socket(AF_UNIX, SOCK_STREAM, 0);
> +			dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
> +

> +TEST_F(outside_socket, socket_with_different_domain)
> +{
> +	pid_t child;
> +	int err, status;
> +	int pipe_child[2], pipe_parent[2];
> +	char buf_parent;
> +	struct service_fixture address, transit_address;
> +
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +
> +	memset(&transit_address, 0, sizeof(transit_address));
> +	memset(&address, 0, sizeof(address));
> +	set_unix_address(&transit_address, 0);
> +	set_unix_address(&address, 1);
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		char buf_child;
> +		int stream_server, client;
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
> +			stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
> +
> +			ASSERT_NE(-1, stream_server);
> +			ASSERT_EQ(0, bind(stream_server,
> +					  &transit_address.unix_addr,
> +					  transit_address.unix_addr_len));
> +			ASSERT_EQ(0, listen(stream_server, backlog));
> +
> +			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +
> +			data_socket = accept(stream_server, NULL, NULL);
> +
> +			ASSERT_EQ(0, send_fd(data_socket, fd_sock));
> +			ASSERT_EQ(0, close(fd_sock));
> +			ASSERT_EQ(0, close(stream_server));
> +		}
> +
> +		client = socket(AF_UNIX, variant->type, 0);
> +		ASSERT_NE(-1, client);
> +		/* wait for parent signal for connection */
> +		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> +
> +		err = connect(client, &address.unix_addr,
> +			      address.unix_addr_len);
> +		if (!variant->domain_server_socket) {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(EPERM, errno);
> +		} else {
> +			EXPECT_EQ(0, err);
> +		}
> +		ASSERT_EQ(0, close(client));
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +	int server_socket;

Variable declarations go at the top of the scope where other variable
are declared.

> +
> +	ASSERT_EQ(0, close(pipe_child[1]));
> +	ASSERT_EQ(0, close(pipe_parent[0]));
> +
> +	if (!variant->domain_server_socket) {
> +		server_socket = socket(AF_UNIX, variant->type, 0);
> +	} else {
> +		int cli = socket(AF_UNIX, SOCK_STREAM, 0);
> +
> +		ASSERT_NE(-1, cli);
> +		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> +		ASSERT_EQ(0, connect(cli, &transit_address.unix_addr,
> +				     transit_address.unix_addr_len));
> +
> +		server_socket = recv_fd(cli);
> +		ASSERT_LE(0, server_socket);
> +		ASSERT_EQ(0, close(cli));
> +	}
> +
> +	ASSERT_NE(-1, server_socket);
> +
> +	if (variant->domain_server)
> +		create_unix_domain(_metadata);
> +
> +	ASSERT_EQ(0, bind(server_socket, &address.unix_addr,
> +			  address.unix_addr_len));
> +	if (variant->type == SOCK_STREAM)
> +		ASSERT_EQ(0, listen(server_socket, backlog));
> +	/* signal to child that parent is listening */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(0, close(server_socket));
> +
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 

