Return-Path: <netdev+bounces-119338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614679553A5
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DBEB22D0C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F6145B01;
	Fri, 16 Aug 2024 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYfveQ/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C591422BF;
	Fri, 16 Aug 2024 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849712; cv=none; b=idEHLrWz1ozAxvpztwYcrqXG4vneUcafUO6omGuclTDMnVJSAJW+BR/4EbYO/tIN9V7y/W0B4H3owaQDImgMNRpKaGnY5Bi9DEg1Qv3c8zDR92ALCy1MEQHW8Oncx3eUJlS1MGzmiEIco2CGZmN9NXIrTcAMuOvj5gmn6seVeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849712; c=relaxed/simple;
	bh=SFYfsKMAjW5ZiDw2wNIR3ts5WPYgH+HxVFl/A6DaE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9IJMCCJKtRk3PKzClKJKNTYNg9p3yys7qzbGmDLhphRyO6QD73u9JVLwKjNMMbbi4QSeKDOUqY76dB928DodDGeUt7qMg+TQnggQK4aOhPsukO8nwU0X3dsEH0FIlN0dmoBWGoq8hBpg2Klrt92Em8m6zWN/NY9sTv8L8aVUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYfveQ/C; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7b8884631c4so1094854a12.2;
        Fri, 16 Aug 2024 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723849709; x=1724454509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mWXASlEAwZzRXhDe50t9vrCjSryW9vg9nmCi9XlgV0c=;
        b=fYfveQ/Cya2ZFdz2yEb//rWOodAbm2kayegkB2pBWixrt2q5V0Ko2bLj3lq7xO3pi1
         ZuVnfUpa1nRkWEn/KckyrNetxXTrYC0AnYMgfKqbKOlzYxVHYTYfzBkDN6bExWdsMs1h
         oYfgYMF3UxAITysg4xHgcBOpJyeynPgmjejtwtqXUgxgj5yZuRwroC1M2p/ENDMlncCy
         bidMUyGe3GAGA8tYZ7SavohgCjf8Cz9IqYCXoZY7Kvza4SXYOiShS4qgUmONnMoYwM0n
         nBS6flsUHCnibXwc1q99/g8/WzCst1qEdoopuMakSZhcvCd6sudtwId1zE2s0sYwP8gz
         sMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723849709; x=1724454509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWXASlEAwZzRXhDe50t9vrCjSryW9vg9nmCi9XlgV0c=;
        b=e2VqHbOjk2aHdgFuz7A6Ker4g7jZ4iMY/ULx2gtWU0svHB+8uUoW41tRkMGMTxqMa6
         bZsqYfdE3/IfQ5in/eeHKQo2ImPxORPWK2efutgdhbVdLCeywJn1O5fkENl8igyUdW4m
         gpMOhZtlHtnnwnLsHrH/O3Po1Q5q9Z9kSi4UT1fKYoZtz7bBqyZ/4HsYgsU/zN64XJZk
         0rwGnCAt+L+oE/0YQ+KzjqejusF40IYPkQjRLn3iuhK8vTByFJtb5xtwE3EoFGrp0mLv
         sElTX8nUv8JYgxwdzsCR7j+RNvY3BdCMldemfTjDDrvUr4nAaomPmTWNQKlAHP5a0Cad
         WdBA==
X-Forwarded-Encrypted: i=1; AJvYcCWXbZSzx4YOUhnov2XZV09jPT689usFfVoa3wNaI/50PgrPsb/eReKlgNbzFaE+OKCFyGVx4sTD8TLTioTh5BiYYQsAAOM+GjzgvpPW/hyP1IDE/H7kHPDGghdIx4DI6AGhoHaFs67XJ8zvvDiTPyk1PDIPsnmZ38zKZem32znkoKAWPu1mGMqYVe98
X-Gm-Message-State: AOJu0YwaTK92D/Y71+B7mkpg1Rp41oS5Av4y6bKfXVc+5Hm9eFUwr6k6
	+5f6KFrdSdZDI06DfFy54IYAsAM3YF6CDtLe22zWdJudD/qwDMhW5U3bEyxI
X-Google-Smtp-Source: AGHT+IFqGNAFP1O/mPeNYB/IUi6tMPwn2CrRVhKvQrMK86On7F00F8bSZDEEd16XhF27lJHjA5ig7A==
X-Received: by 2002:a05:6a20:cf8b:b0:1c2:8bf8:e7ab with SMTP id adf61e73a8af0-1c904f7ec24mr5146742637.9.1723849708738;
        Fri, 16 Aug 2024 16:08:28 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375921sm30059595ad.140.2024.08.16.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 16:08:28 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:08:26 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/5] selftests/Landlock: Abstract unix socket
 restriction tests
Message-ID: <Zr/b6j5V2IS4jpe8@tahera-OptiPlex-5000>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <2fb401d2ee04b56c693bba3ebac469f2a6785950.1723615689.git.fahimitahera@gmail.com>
 <20240816.His9oihaigei@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816.His9oihaigei@digikod.net>

On Fri, Aug 16, 2024 at 11:23:05PM +0200, Mickaël Salaün wrote:
> Please make sure all subject's prefixes have "landlock", not "Landlock"
> for consistency with current commits.
> 
> On Wed, Aug 14, 2024 at 12:22:20AM -0600, Tahera Fahimi wrote:
> > The patch introduces Landlock ABI version 6 and has three types of tests
> > that examines different scenarios for abstract unix socket connection:
> > 1) unix_socket: base tests of the abstract socket scoping mechanism for a
> >    landlocked process, same as the ptrace test.
> > 2) optional_scoping: generates three processes with different domains and
> >    tests if a process with a non-scoped domain can connect to other
> >    processes.
> > 3) unix_sock_special_cases: since the socket's creator credentials are used
> >    for scoping sockets, this test examines the cases where the socket's
> >    credentials are different from the process using it.
> > 
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > ---
> > Changes in versions:
> > v9:
> > - Move pathname_address_sockets to a different patch.
> > - Extend optional_scoping test scenarios.
> > - Removing hardcoded numbers and using "backlog" instead.
> 
> You may have missed some parts of my previous review (e.g. local
> variables).
Hi Mickaël,
Thanks for the feedback. I actually did not apply the local variable for
the reason below.
> > V8:
> > - Move tests to scoped_abstract_unix_test.c file.
> > - To avoid potential conflicts among Unix socket names in different tests,
> >   set_unix_address is added to common.h to set different sun_path for Unix sockets.
> > - protocol_variant and service_fixture structures are also moved to common.h
> > - Adding pathname_address_sockets to cover all types of address formats
> >   for unix sockets, and moving remove_path() to common.h to reuse in this test.
> > V7:
> > - Introducing landlock ABI version 6.
> > - Adding some edge test cases to optional_scoping test.
> > - Using `enum` for different domains in optional_scoping tests.
> > - Extend unix_sock_special_cases test cases for connected(SOCK_STREAM) sockets.
> > - Modifying inline comments.
> > V6:
> > - Introducing optional_scoping test which ensures a sandboxed process with a
> >   non-scoped domain can still connect to another abstract unix socket(either
> >   sandboxed or non-sandboxed).
> > - Introducing unix_sock_special_cases test which tests examines scenarios where
> >   the connecting sockets have different domain than the process using them.
> > V4:
> > - Introducing unix_socket to evaluate the basic scoping mechanism for abstract
> >   unix sockets.
> > ---
> >  tools/testing/selftests/landlock/base_test.c  |   2 +-
> >  tools/testing/selftests/landlock/common.h     |  38 +
> >  tools/testing/selftests/landlock/net_test.c   |  31 +-
> >  .../landlock/scoped_abstract_unix_test.c      | 942 ++++++++++++++++++
> >  4 files changed, 982 insertions(+), 31 deletions(-)
> >  create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> > 
> 
> > +static void create_unix_domain(struct __test_metadata *const _metadata)
> > +{
> > +	int ruleset_fd;
> > +	const struct landlock_ruleset_attr ruleset_attr = {
> > +		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
> > +	};
> > +
> > +	ruleset_fd =
> > +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> > +	EXPECT_LE(0, ruleset_fd)
> > +	{
> > +		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
> > +	}
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	EXPECT_EQ(0, close(ruleset_fd));
> > +}
> > +
> > +/* clang-format off */
> 
> It should not be required to add this clang-format comment here nor in
> most places, except variant declarations (that might change if we remove
> variables though).
> 
> > +FIXTURE(unix_socket)
> > +{
> > +	struct service_fixture stream_address, dgram_address;
> > +	int server, client, dgram_server, dgram_client;
> 
> These variables don't need to be in the fixture but they should be local
> instead (and scoped to the if/else condition where they are used).
> 
> > +};
> > +
> > +/* clang-format on */
> > +FIXTURE_VARIANT(unix_socket)
> > +{
> > +	bool domain_both;
> > +	bool domain_parent;
> > +	bool domain_child;
> > +	bool connect_to_parent;
> > +};
> 
> > +/* 
> > + * Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and child,
> > + * when they have scoped domain or no domain.
> > + */
> > +TEST_F(unix_socket, abstract_unix_socket)
> > +{
> > +	int status;
> > +	pid_t child;
> > +	bool can_connect_to_parent, can_connect_to_child;
> > +	int err, err_dgram;
> > +	int pipe_child[2], pipe_parent[2];
> > +	char buf_parent;
> > +
> > +	/*
> > +	 * can_connect_to_child is true if a parent process can connect to its
> > +	 * child process. The parent process is not isolated from the child
> > +	 * with a dedicated Landlock domain.
> > +	 */
> > +	can_connect_to_child = !variant->domain_parent;
> > +	/*
> > +	 * can_connect_to_parent is true if a child process can connect to its
> > +	 * parent process. This depends on the child process is not isolated from
> > +	 * the parent with a dedicated Landlock domain.
> > +	 */
> > +	can_connect_to_parent = !variant->domain_child;
> > +
> > +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> > +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> > +	if (variant->domain_both) {
> > +		create_unix_domain(_metadata);
> > +		if (!__test_passed(_metadata))
> > +			return;
> > +	}
> > +
> > +	child = fork();
> > +	ASSERT_LE(0, child);
> > +	if (child == 0) {
> > +		char buf_child;
> > +
> > +		ASSERT_EQ(0, close(pipe_parent[1]));
> > +		ASSERT_EQ(0, close(pipe_child[0]));
> > +		if (variant->domain_child)
> > +			create_unix_domain(_metadata);
> > +
> > +		/* Waits for the parent to be in a domain, if any. */
> > +		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> > +
> > +		if (variant->connect_to_parent) {
> > +			self->client = socket(AF_UNIX, SOCK_STREAM, 0);
> 
> int stream_client;
> 
> stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
> 
> ditto for dgram_client
> 
> > +			self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
> > +
> > +			ASSERT_NE(-1, self->client);
> > +			ASSERT_NE(-1, self->dgram_client);
> > +			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> > +
> > +			err = connect(self->client,
> > +				      &self->stream_address.unix_addr,
> > +				      (self->stream_address).unix_addr_len);
> > +			err_dgram =
> > +				connect(self->dgram_client,
> > +					&self->dgram_address.unix_addr,
> > +					(self->dgram_address).unix_addr_len);
> > +
> > +			if (can_connect_to_parent) {
> > +				EXPECT_EQ(0, err);
> > +				EXPECT_EQ(0, err_dgram);
> > +			} else {
> > +				EXPECT_EQ(-1, err);
> > +				EXPECT_EQ(-1, err_dgram);
> > +				EXPECT_EQ(EPERM, errno);
> > +			}
> 
> EXPECT_EQ(0, close(stream_client));
> EXPECT_EQ(0, close(dgram_client));
> 
> > +		} else {
> > +			self->server = socket(AF_UNIX, SOCK_STREAM, 0);
> 
> int stream_server;
> 
> server = socket(AF_UNIX, SOCK_STREAM, 0);
> 
> ditto for dgram_server
> 
> > +			self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
> > +			ASSERT_NE(-1, self->server);
> > +			ASSERT_NE(-1, self->dgram_server);
> > +
> > +			ASSERT_EQ(0,
> > +				  bind(self->server,
> > +				       &self->stream_address.unix_addr,
> > +				       (self->stream_address).unix_addr_len));
> > +			ASSERT_EQ(0, bind(self->dgram_server,
> > +					  &self->dgram_address.unix_addr,
> > +					  (self->dgram_address).unix_addr_len));
> > +			ASSERT_EQ(0, listen(self->server, backlog));
> > +
> > +			/* signal to parent that child is listening */
> > +			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> > +			/* wait to connect */
> > +			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> 
> ditto
> 
> > +		}
> > +		_exit(_metadata->exit_code);
> > +		return;
> > +	}
> > +
> > +	ASSERT_EQ(0, close(pipe_child[1]));
> > +	ASSERT_EQ(0, close(pipe_parent[0]));
> > +
> > +	if (variant->domain_parent)
> > +		create_unix_domain(_metadata);
> > +
> > +	/* Signals that the parent is in a domain, if any. */
> > +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> > +
> > +	if (!variant->connect_to_parent) {
> > +		self->client = socket(AF_UNIX, SOCK_STREAM, 0);
> > +		self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
> 
> ditto
> 
> > +
> > +		ASSERT_NE(-1, self->client);
> > +		ASSERT_NE(-1, self->dgram_client);
> > +
> > +		/* Waits for the child to listen */
> > +		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> > +		err = connect(self->client, &self->stream_address.unix_addr,
> > +			      (self->stream_address).unix_addr_len);
> > +		err_dgram = connect(self->dgram_client,
> > +				    &self->dgram_address.unix_addr,
> > +				    (self->dgram_address).unix_addr_len);
> > +
> > +		if (can_connect_to_child) {
> > +			EXPECT_EQ(0, err);
> > +			EXPECT_EQ(0, err_dgram);
> > +		} else {
> > +			EXPECT_EQ(-1, err);
> > +			EXPECT_EQ(-1, err_dgram);
> > +			EXPECT_EQ(EPERM, errno);
> > +		}
> > +		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> 
> ditto
> 
> > +	} else {
> > +		self->server = socket(AF_UNIX, SOCK_STREAM, 0);
> > +		self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
> 
> ditto
> 
> > +		ASSERT_NE(-1, self->server);
> > +		ASSERT_NE(-1, self->dgram_server);
> > +		ASSERT_EQ(0, bind(self->server, &self->stream_address.unix_addr,
> > +				  (self->stream_address).unix_addr_len));
> > +		ASSERT_EQ(0, bind(self->dgram_server,
> > +				  &self->dgram_address.unix_addr,
> > +				  (self->dgram_address).unix_addr_len));
> > +		ASSERT_EQ(0, listen(self->server, backlog));
> > +
> > +		/* signal to child that parent is listening */
> > +		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> 
> ditto
I think if I define "server" and "dgram_server" as local variables, then
in here, we should ensure that the clients connections are finished and
then close the server sockets. The client can write on the pipe after the
connection test is finished and then servers can close the sockets, but
the current version is much easier. Simply when the test is finished,
the FIXTURE_TEARDOWN closes all the sockets. What do you think about this?
> > +	}
> > +
> > +	ASSERT_EQ(child, waitpid(child, &status, 0));
> > +
> > +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> > +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> > +		_metadata->exit_code = KSFT_FAIL;
> > +}
> > +
> 
> > +/*
> > + * ###################
> > + * #         ####### #  P3 -> P2 : allow
> > + * #   P1----# P2  # #  P3 -> P1 : deny
> > + * #         #  |  # #
> > + * #         # P3  # #
> > + * #         ####### #
> > + * ###################
> > + */
> > +/* clang-format off */
> > +FIXTURE_VARIANT_ADD(optional_scoping, all_scoped) {
> > +        .domain_all = SCOPE_SANDBOX,
> > +        .domain_parent = NO_SANDBOX,
> > +        .domain_children = SCOPE_SANDBOX,
> > +        .domain_child = NO_SANDBOX,
> > +        .domain_grand_child = NO_SANDBOX,
> > +        .type = SOCK_DGRAM,
> 
> There are spaces instead of tabs here.
> 
> > +	/* clang-format on */
> > +};
> 
> > +/*
> > + *  ######		P3 -> P2 : deny
> > + *  # P1 #----P2	P3 -> P1 : deny
> > + *  ######     |
> > + *	       |
> > + *	     ######
> > + *           # P3 #
> > + *           ######
> > + */
> > +/* clang-format off */
> > +FIXTURE_VARIANT_ADD(optional_scoping, deny_with_self_and_parents_domain) {
> > +        .domain_all = NO_SANDBOX,
> > +        .domain_parent = SCOPE_SANDBOX,
> > +        .domain_children = NO_SANDBOX,
> > +        .domain_child = NO_SANDBOX,
> > +        .domain_grand_child = SCOPE_SANDBOX,
> > +        .type = SOCK_STREAM,
> 
> ditto
> 
> > +	/* clang-format on */
> > +};
> > +
> > +/* 
> 
> Extra space
> 
> > + * Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent, child
> > + * and grand child processes when they can have scoped or non-scoped
> > + * domains.
> > + **/
> 
> Extra '*'
> 
> > +TEST_F(optional_scoping, unix_scoping)
> > +{
> > +	pid_t child;
> > +	int status;
> > +	bool can_connect_to_parent, can_connect_to_child;
> > +	int pipe_parent[2];
> > +
> > +	can_connect_to_child =
> > +		(variant->domain_grand_child == SCOPE_SANDBOX) ? false : true;
> 
> No need for `? false : true`, just use comparison result:
> can_connect_to_child = (variant->domain_grand_child != SCOPE_SANDBOX);
sorry,my bad.
> 
> > +
> > +	can_connect_to_parent = (!can_connect_to_child ||
> > +				 variant->domain_children == SCOPE_SANDBOX) ?
> > +					false :
> > +					true;
> 
> ditto
> 
> > +
> > +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> > +
> > +	if (variant->domain_all == OTHER_SANDBOX)
> > +		create_fs_domain(_metadata);
> > +	else if (variant->domain_all == SCOPE_SANDBOX)
> > +		create_unix_domain(_metadata);
> > +
> > +	child = fork();
> > +	ASSERT_LE(0, child);
> > +	if (child == 0) {
> > +		int pipe_child[2];
> > +
> > +		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> > +		pid_t grand_child;
> > +
> > +		if (variant->domain_children == OTHER_SANDBOX)
> > +			create_fs_domain(_metadata);
> > +		else if (variant->domain_children == SCOPE_SANDBOX)
> > +			create_unix_domain(_metadata);
> > +
> > +		grand_child = fork();
> > +		ASSERT_LE(0, grand_child);
> > +		if (grand_child == 0) {
> > +			ASSERT_EQ(0, close(pipe_parent[1]));
> > +			ASSERT_EQ(0, close(pipe_child[1]));
> > +
> > +			char buf1, buf2;
> > +			int err;
> > +
> > +			if (variant->domain_grand_child == OTHER_SANDBOX)
> > +				create_fs_domain(_metadata);
> > +			else if (variant->domain_grand_child == SCOPE_SANDBOX)
> > +				create_unix_domain(_metadata);
> > +
> > +			self->client = socket(AF_UNIX, variant->type, 0);
> 
> ditto
> 
> > +			ASSERT_NE(-1, self->client);
> > +
> > +			ASSERT_EQ(1, read(pipe_child[0], &buf2, 1));
> > +			err = connect(self->client,
> > +				      &self->child_address.unix_addr,
> > +				      (self->child_address).unix_addr_len);
> > +			if (can_connect_to_child) {
> > +				EXPECT_EQ(0, err);
> > +			} else {
> > +				EXPECT_EQ(-1, err);
> > +				EXPECT_EQ(EPERM, errno);
> > +			}
> > +
> > +			if (variant->type == SOCK_STREAM) {
> > +				EXPECT_EQ(0, close(self->client));
> > +				self->client =
> > +					socket(AF_UNIX, variant->type, 0);
> > +				ASSERT_NE(-1, self->client);
> > +			}
> > +
> > +			ASSERT_EQ(1, read(pipe_parent[0], &buf1, 1));
> > +			err = connect(self->client,
> > +				      &self->parent_address.unix_addr,
> > +				      (self->parent_address).unix_addr_len);
> > +			if (can_connect_to_parent) {
> > +				EXPECT_EQ(0, err);
> > +			} else {
> > +				EXPECT_EQ(-1, err);
> > +				EXPECT_EQ(EPERM, errno);
> > +			}
> > +			EXPECT_EQ(0, close(self->client));
> > +
> > +			_exit(_metadata->exit_code);
> > +			return;
> > +		}
> > +
> > +		ASSERT_EQ(0, close(pipe_child[0]));
> > +		if (variant->domain_child == OTHER_SANDBOX)
> > +			create_fs_domain(_metadata);
> > +		else if (variant->domain_child == SCOPE_SANDBOX)
> > +			create_unix_domain(_metadata);
> > +
> > +		self->child_server = socket(AF_UNIX, variant->type, 0);
> > +		ASSERT_NE(-1, self->child_server);
> > +		ASSERT_EQ(0, bind(self->child_server,
> > +				  &self->child_address.unix_addr,
> > +				  (self->child_address).unix_addr_len));
> > +		if (variant->type == SOCK_STREAM)
> > +			ASSERT_EQ(0, listen(self->child_server, backlog));
> > +
> > +		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> > +		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
> > +		return;
> > +	}
> > +	ASSERT_EQ(0, close(pipe_parent[0]));
> > +
> > +	if (variant->domain_parent == OTHER_SANDBOX)
> > +		create_fs_domain(_metadata);
> > +	else if (variant->domain_parent == SCOPE_SANDBOX)
> > +		create_unix_domain(_metadata);
> > +
> > +	self->parent_server = socket(AF_UNIX, variant->type, 0);
> > +	ASSERT_NE(-1, self->parent_server);
> > +	ASSERT_EQ(0, bind(self->parent_server, &self->parent_address.unix_addr,
> > +			  (self->parent_address).unix_addr_len));
> > +
> > +	if (variant->type == SOCK_STREAM)
> > +		ASSERT_EQ(0, listen(self->parent_server, backlog));
> > +
> > +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> > +	ASSERT_EQ(child, waitpid(child, &status, 0));
> > +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> > +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> > +		_metadata->exit_code = KSFT_FAIL;
> > +}
> > +
> > +/*
> > + * Since the special case of scoping only happens when the connecting socket
> > + * is scoped, the client's domain is true for all the following test cases.
> > + */
> > +/* clang-format off */
> > +FIXTURE(unix_sock_special_cases) {
> > +	int server_socket, client;
> > +	int stream_server, stream_client;
> 
> Same here, these variables should be local.
> 
> > +	struct service_fixture address, transit_address;
> > +};
> > +
> > +/* clang-format on */
> > +FIXTURE_VARIANT(unix_sock_special_cases)
> > +{
> > +	const bool domain_server;
> > +	const bool domain_server_socket;
> > +	const int type;
> > +};
> > +
> > +/* clang-format off */
> > +FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_dgram_server_sock_domain) {
> > +	/* clang-format on */
> > +	.domain_server = false,
> > +	.domain_server_socket = true,
> > +	.type = SOCK_DGRAM,
> > +};
> > +
> > +/* clang-format off */
> > +FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_dgram_server_domain) {
> > +	/* clang-format on */
> > +	.domain_server = true,
> > +	.domain_server_socket = false,
> > +	.type = SOCK_DGRAM,
> > +};
> > +
> > +/* clang-format off */
> > +FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_stream_server_sock_domain) {
> > +	/* clang-format on */
> > +	.domain_server = false,
> > +	.domain_server_socket = true,
> > +	.type = SOCK_STREAM,
> > +};
> > +
> > +/* clang-format off */
> > +FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_stream_server_domain) {
> > +	/* clang-format on */
> > +	.domain_server = true,
> > +	.domain_server_socket = false,
> > +	.type = SOCK_STREAM,
> > +};
> > +
> > +FIXTURE_SETUP(unix_sock_special_cases)
> > +{
> > +	memset(&self->transit_address, 0, sizeof(self->transit_address));
> > +	memset(&self->address, 0, sizeof(self->address));
> > +	set_unix_address(&self->transit_address, 0);
> > +	set_unix_address(&self->address, 1);
> > +}
> > +
> > +FIXTURE_TEARDOWN(unix_sock_special_cases)
> > +{
> > +	close(self->client);
> > +	close(self->server_socket);
> > +	close(self->stream_server);
> > +	close(self->stream_client);
> 
> These EXPECT_EQ(0, close()) calls should be local too.

