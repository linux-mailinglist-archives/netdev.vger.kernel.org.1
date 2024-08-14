Return-Path: <netdev+bounces-118331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50254951471
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53B71F23245
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B4D13C827;
	Wed, 14 Aug 2024 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFI40pSm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71512524D7;
	Wed, 14 Aug 2024 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616584; cv=none; b=bcJw4JvAZEXoltDrCKuIpseE/IcgDpqbSBoLwcNn7nYjjRmPmYCt2+E8gVdc/Rs3MO4exvhaNbxoauETpr49blEOkZO/h9miu5pLc7FajxQsFYxZ9R9maHYVQdhWiqhS3oD1ase/aXK/tbneBPBbxhhdAUwGoCfeeu+g1qhzbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616584; c=relaxed/simple;
	bh=FVP7CF0hJpGhBsy2kovwduLfrHY4+icQEIMi1S4e900=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sSg5QahL/xNejsTBHUv+OFyHitkJRsludZxwkIsUKTg4IG66bSwBd1O/ZoE2HA/ExdKEzr35eozgT+aclukZ0/ZWFb4N9xMAVQu0fQwKPrS82SWKL63KqrvRMWXxA77i5HbZ+EU8I0D5OF6cM2ZV0bmgjzJ/cnlcWtX5birIlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFI40pSm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7bb75419123so4265144a12.3;
        Tue, 13 Aug 2024 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723616582; x=1724221382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLIwr+anKzbnApMctEd0QozqhgphMnOwuWjrqDoHkUU=;
        b=nFI40pSmgnV02/28hYj3ydBbOo8X8ITHY/wREPbJIxZtn/mEn1bLW+o5rSRUp9Ecqf
         K8iwObwK5yrdvTpPRlCmV/4zpZiEds5mz/fAlBb+qVWCeH8t5PnTrym84sGsvlbfT459
         8+BC0M9BcoJMWEUzBDOtqj9UNlbrCHfucKceyHlwNk/T58oWE69NHyh8YL+XoCxxq8hR
         Kko+vsWxqQ7BLl2t3LxGcmKShs14FsIJBvpxrBdHhnymm46NA3JE2B/zKN4Avx1y5y3C
         Huhkq6Pvz7rXJzZYy5To4/C3yyMBxqr/UoNzLPlIUcKlokkPixG2v/NZynC+8JyLKjam
         1WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723616582; x=1724221382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLIwr+anKzbnApMctEd0QozqhgphMnOwuWjrqDoHkUU=;
        b=Ng7cJZwPknYePH9HI5KN5pJruRZb9OH5i2J9DHC7rkXrICnFcML9+Uu187RlpcCVHY
         kzABKZmM959nWaFSSdu2n3HeNybRc+MT4E4ZpRuPnRYo6N6K+9cunXHFkKn8e7a2SqLM
         Bxobci23yAXdyYSoSYqsKtizTBbaJAUiFMe6s4kKDCKfFoiQoIDT4Hobdpb25Mf19JvY
         XKKmTub9tcEAcak3u1rrVbCkZPofkovMCr6I4TBwwIqYQBlRXh2QnNNmK3ZY2MWWtnaV
         aXYIngqiCkgZOnGh7ygPsn5y0zAhtEcDsBI4CgVebVQDYIXiMZrw2J7ftmIXxq6ZX3wq
         SF7g==
X-Forwarded-Encrypted: i=1; AJvYcCUVy4+sqTMwgsFBKg/yXpKd/fwhS0K6xf+e6My7HJDxopbdQioKuncnty0NXE6b1lLzOwc0edVpGLUpd1YQiiv1608NTOYEs9lJP+GWYrvMYqe9n6ZBtc3keNC9U35VghqN6Ok1CZxaYdT/JfsKZUfiA+0cJgwcxiFeLjaKyKtwGNWKTgStUJ4sXYVW
X-Gm-Message-State: AOJu0YzhhBPdknY/EP5Zao4RHg0+wH/voPoFBrCAcR95xKrXQ58cSTuO
	M60JCugqB18kfWJqLdx9fMcXh01ykmZ4bz0Z082BN1lzxmlVj7FN
X-Google-Smtp-Source: AGHT+IEt5S/g03RjoK0xsLQMfvlYN3LkY1futPJ/lCk1riUHheR3qfePHawT9M8eGylDz9lgduYDkQ==
X-Received: by 2002:a17:90a:4dc1:b0:2cb:5455:8018 with SMTP id 98e67ed59e1d1-2d3aaaaeb63mr2034922a91.23.1723616581579;
        Tue, 13 Aug 2024 23:23:01 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2120sm728811a91.31.2024.08.13.23.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:23:00 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	netdev@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v9 3/5] selftests/Landlock: Adding pathname Unix socket tests
Date: Wed, 14 Aug 2024 00:22:21 -0600
Message-Id: <df1c54690beeab024534f6671ee9a3266270d9e1.1723615689.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723615689.git.fahimitahera@gmail.com>
References: <cover.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch expands abstract Unix socket restriction tests by
testing pathname sockets connection with scoped domain.

pathname_address_sockets ensures that Unix sockets bound to
a null-terminated filesystem can still connect to a socket
outside of their scoped domain. This means that even if the
domain is scoped with LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
the socket can connect to a socket outside the scoped domain.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
changes in versions:
v9:
- Moving remove_path() back to fs_test.c, and using unlink(2)
  and rmdir(2) instead.
- Removing hard-coded numbers and using "backlog" instead.
V8:
- Adding pathname_address_sockets to cover all types of address
  formats for unix sockets, and moving remove_path() to
  common.h to reuse in this test.
---
 .../landlock/scoped_abstract_unix_test.c      | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 232c3b767b8a..21285a7158b6 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -939,4 +939,208 @@ TEST_F(unix_sock_special_cases, socket_with_different_domain)
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
 }
+
+static const char path1[] = TMP_DIR "/s1_variant1";
+static const char path2[] = TMP_DIR "/s2_variant1";
+
+/* clang-format off */
+FIXTURE(pathname_address_sockets) {
+	struct service_fixture stream_address, dgram_address;
+};
+
+/* clang-format on */
+FIXTURE_VARIANT(pathname_address_sockets)
+{
+	const int domain;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(pathname_address_sockets, pathname_socket_scoped_domain) {
+	/* clang-format on */
+	.domain = SCOPE_SANDBOX,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(pathname_address_sockets, pathname_socket_other_domain) {
+	/* clang-format on */
+	.domain = OTHER_SANDBOX,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(pathname_address_sockets, pathname_socket_no_domain) {
+	/* clang-format on */
+	.domain = NO_SANDBOX,
+};
+
+FIXTURE_SETUP(pathname_address_sockets)
+{
+	/* setup abstract addresses */
+	memset(&self->stream_address, 0, sizeof(self->stream_address));
+	set_unix_address(&self->stream_address, 0);
+
+	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
+	set_unix_address(&self->dgram_address, 0);
+
+	disable_caps(_metadata);
+	umask(0077);
+	ASSERT_EQ(0, mkdir(TMP_DIR, 0700));
+
+	ASSERT_EQ(0, mknod(path1, S_IFREG | 0700, 0))
+	{
+		TH_LOG("Failed to create file \"%s\": %s", path1,
+		       strerror(errno));
+		ASSERT_EQ(0, unlink(TMP_DIR) & rmdir(TMP_DIR));
+	}
+	ASSERT_EQ(0, mknod(path2, S_IFREG | 0700, 0))
+	{
+		TH_LOG("Failed to create file \"%s\": %s", path2,
+		       strerror(errno));
+		ASSERT_EQ(0, unlink(TMP_DIR) & rmdir(TMP_DIR));
+	}
+}
+
+FIXTURE_TEARDOWN(pathname_address_sockets)
+{
+	ASSERT_EQ(0, unlink(path1) & rmdir(path1));
+	ASSERT_EQ(0, unlink(path2) & rmdir(path2));
+	ASSERT_EQ(0, unlink(TMP_DIR) & rmdir(TMP_DIR));
+}
+
+TEST_F(pathname_address_sockets, scoped_pathname_sockets)
+{
+	const char *const stream_path = path1;
+	const char *const dgram_path = path2;
+	int srv_fd, srv_fd_dg;
+	socklen_t size, size_dg;
+	struct sockaddr_un srv_un, srv_un_dg;
+	int pipe_parent[2];
+	pid_t child;
+	int status;
+	char buf_child;
+	int socket_fds_stream[2];
+	int server, client, dgram_server, dgram_client;
+	int recv_data;
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
+				socket_fds_stream));
+
+	srv_un.sun_family = AF_UNIX;
+	snprintf(srv_un.sun_path, sizeof(srv_un.sun_path), "%s", stream_path);
+	size = offsetof(struct sockaddr_un, sun_path) + strlen(srv_un.sun_path);
+
+	srv_un_dg.sun_family = AF_UNIX;
+	snprintf(srv_un_dg.sun_path, sizeof(srv_un_dg.sun_path), "%s",
+		 dgram_path);
+	size_dg = offsetof(struct sockaddr_un, sun_path) +
+		  strlen(srv_un_dg.sun_path);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int cli_fd, cli_fd_dg;
+		int err, err_dg;
+		int sample = socket(AF_UNIX, SOCK_STREAM, 0);
+
+		ASSERT_LE(0, sample);
+		ASSERT_EQ(0, close(pipe_parent[1]));
+
+		/* scope the domain */
+		if (variant->domain == SCOPE_SANDBOX)
+			create_unix_domain(_metadata);
+		else if (variant->domain == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
+
+		ASSERT_EQ(0, close(socket_fds_stream[1]));
+		ASSERT_EQ(0, send_fd(socket_fds_stream[0], sample));
+		ASSERT_EQ(0, close(sample));
+		ASSERT_EQ(0, close(socket_fds_stream[0]));
+
+		/* wait for server to listen */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		/* connect with pathname sockets */
+		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, cli_fd);
+		ASSERT_EQ(0, connect(cli_fd, (struct sockaddr *)&srv_un, size));
+		ASSERT_EQ(0, close(cli_fd));
+
+		cli_fd_dg = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_LE(0, cli_fd_dg);
+		ASSERT_EQ(0, connect(cli_fd_dg, (struct sockaddr *)&srv_un_dg,
+				     size_dg));
+
+		ASSERT_EQ(0, close(cli_fd_dg));
+
+		/* check connection with abstract sockets */
+		client = socket(AF_UNIX, SOCK_STREAM, 0);
+		dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+		ASSERT_NE(-1, client);
+		ASSERT_NE(-1, dgram_client);
+
+		err = connect(client, &self->stream_address.unix_addr,
+			      (self->stream_address).unix_addr_len);
+		err_dg = connect(dgram_client, &self->dgram_address.unix_addr,
+				 (self->dgram_address).unix_addr_len);
+		if (variant->domain == SCOPE_SANDBOX) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(-1, err_dg);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+			EXPECT_EQ(0, err_dg);
+		}
+		ASSERT_EQ(0, close(client));
+		ASSERT_EQ(0, close(dgram_client));
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	recv_data = recv_fd(socket_fds_stream[1]);
+	ASSERT_LE(0, recv_data);
+	ASSERT_LE(0, close(socket_fds_stream[1]));
+
+	/* Sets up a server */
+	ASSERT_EQ(0, unlink(stream_path));
+	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, srv_fd);
+	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, size));
+	ASSERT_EQ(0, listen(srv_fd, 10));
+
+	/* set up a datagram server */
+	ASSERT_EQ(0, unlink(dgram_path));
+	srv_fd_dg = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_LE(0, srv_fd_dg);
+	size_dg = offsetof(struct sockaddr_un, sun_path) +
+		  strlen(srv_un_dg.sun_path);
+	ASSERT_EQ(0, bind(srv_fd_dg, (struct sockaddr *)&srv_un_dg, size_dg));
+
+	/*set up abstract servers */
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, server);
+	ASSERT_NE(-1, dgram_server);
+	ASSERT_EQ(0, bind(server, &self->stream_address.unix_addr,
+			  self->stream_address.unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_server, &self->dgram_address.unix_addr,
+			  self->dgram_address.unix_addr_len));
+	ASSERT_EQ(0, listen(server, backlog));
+
+	/* servers are listening, signal to child */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(0, close(srv_fd));
+	ASSERT_EQ(0, close(srv_fd_dg));
+	ASSERT_EQ(0, close(server));
+	ASSERT_EQ(0, close(dgram_server));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
 TEST_HARNESS_MAIN
-- 
2.34.1


