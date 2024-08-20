Return-Path: <netdev+bounces-119985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49574957C43
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0081F284FEA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E914A4C0;
	Tue, 20 Aug 2024 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyTIn28Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5D148838;
	Tue, 20 Aug 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126955; cv=none; b=eBRsxHNmdg5LMdbZoX65SvKLvW338K6WzIYq9qsAKOJX5eitaxJpcw+6LYXyRyrZAplC7anLI8f9GN0QTqHk3vAZr7G5EMgC13wqPu2X473WopSLLDGIC5/+dx0INznPvdtf+CC6mHPd5Sr1QH+H28ui2cmF6Jqlk5MJnksrwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126955; c=relaxed/simple;
	bh=CiC7pp1EffA8PNh2ymlnUPPbAlFyrllsugMGSU+74yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBfAWp5BnCyLXlL8g3fz+YN0TlrpxGvIIY5XR4wVqjMylrrW8X3pKpFjirL1Gx+Sb88m+UaazmCdQKaIDl95Us+RWKriW120ZNwWxFhpded9k2k88RhYmhM2uHdqIkk/ootnYP5frZPPjG5JUqPKVVnyxDH5/QOhDxi06b/iwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyTIn28Y; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c098792bso3953803a91.1;
        Mon, 19 Aug 2024 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724126953; x=1724731753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6hxzy5zGxdlmpjwE+NLrlNJC4iqWNYhXUdyroOUOug=;
        b=TyTIn28Yf4f1YzSEL+HsEkaJ4sfMjxYH84qmca5VLxo+cbYnKPqwD48L9slBwD3/Ac
         SMPxxrryfBWZdXMUv8Xa+hgAI1vpZ2cq+dgq3K0cqdpR01UsSMCkjyabcK13K6F1geoF
         sm+4Isx1JfRDeUaV4fdgFwvzMR1GLoSDlNSxeBp2+NBJ2a2y8EeFhlC/C3kpdIcl816F
         E/dqmtlAJzUAe7WjVhx8khYyXEIjjOCGZC9ubcf506KEUKMncJ4UHFxseCX7G2U36B7d
         XdIXjpgwhubCwPeTuXgW8z3M8uKjXcrPWzcBYXJ4nOW78yWMARqGtZeqcxjceST0qFCJ
         gzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126953; x=1724731753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6hxzy5zGxdlmpjwE+NLrlNJC4iqWNYhXUdyroOUOug=;
        b=k2xx6LcSlrczIn+GbZLXUwd1DuQ2I1tajtM8usixNRezboWJ7FcUYXWZbSluotP+eA
         5hcsoD2sz4zZktTVVwVP9pwLTNeEnu71+O4a+//Wyb/+kFj1NBidwDELA1d5MMR4Vv57
         x5m5JSnACWPzV6LDimrQniWa0iVxgpyqw7XsVZ5/dQ8v8u5PpMKmA6RvHizNAeBdV4kn
         2Y/raAP2Dn9ZGIOKaNELDNnORL72gQm/ZI6JwVI+YMnhsUve91OmMBN38NvZQ5Tsz4nd
         gjgjp4wIYUMjkqyalbJ0TwZhrPg6Sv6sQ4eC239dY5drfLaVcCLXoG7tUPVIEKvgkqSO
         45Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVue7QiJLAh6GtcBw58Brl7IyP3t2R/vKV6x11TECXFaXyS2XTkHWPn0lC30Xior98kPchkfWo2G5ZW0vgDJjir6HVFVJN4FdJPyaeQqu/b1/ekaHymEt9Djycie6IMdquJ7T6fpXbHMXp4TMI17RStnSxqgls/8dNrZ60xRL2oECPM/M6Q9X4uH7Pb
X-Gm-Message-State: AOJu0YzwFTi4Wn82Y0Vhy0SKCgWlzuOehh5XNghxYS94TDgFdWVFrduW
	iBN/PCLNQCL1dPBv/zNgz0OBl3FQCa+KgPSCqTTucbBhp8F9pfD1
X-Google-Smtp-Source: AGHT+IHJhE948QsbW9xUOB16ZM2ZPQFX1tqD/y6iMQ+Iis//WDOWDPLl5+oYY0+XUQjpoKVd9avNWA==
X-Received: by 2002:a17:90a:db86:b0:2c3:40b7:1f6d with SMTP id 98e67ed59e1d1-2d3dfab06f0mr14720451a91.0.1724126953111;
        Mon, 19 Aug 2024 21:09:13 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8149652a91.27.2024.08.19.21.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:09:12 -0700 (PDT)
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
Subject: [PATCH v10 4/6] selftests/Landlock: Add pathname UNIX socket tests
Date: Mon, 19 Aug 2024 22:08:54 -0600
Message-Id: <97fcd177f5c83b3ac88074cb9d52cb1ce684bbed.1724125513.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724125513.git.fahimitahera@gmail.com>
References: <cover.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch expands abstract UNIX socket restriction tests by
testing pathname sockets connection with scoped domain.

pathname_address_sockets ensures that UNIX sockets bound to
a filesystem path name can still connect to a socket outside
of their scoped domain. This means that even if the domain
is scoped with LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET, the
socket can connect to a socket outside the scoped domain.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
changes in versions:
v10:
- Code improvements by changing fixture variables to local ones.
- Commit improvement.
v9:
- Moving remove_path() back to fs_test.c, and using unlink(2)
  and rmdir(2) instead.
- Removing hard-coded numbers and using "backlog" instead.
V8:
- Adding pathname_address_sockets to cover all types of address
  formats for unix sockets, and moving remove_path() to
  common.h to reuse in this test.
---
 .../landlock/scoped_abstract_unix_test.c      | 199 ++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 65c1ac2895a9..401e0d2e7025 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -928,4 +928,203 @@ TEST_F(outside_socket, socket_with_different_domain)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+static const char path1[] = TMP_DIR "/s1_variant1";
+static const char path2[] = TMP_DIR "/s2_variant1";
+
+/* clang-format off */
+FIXTURE(pathname_address_sockets) {};
+/* clang-format on */
+
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
+	struct service_fixture stream_address, dgram_address;
+	const char *const stream_path = path1;
+	const char *const dgram_path = path2;
+	socklen_t size, size_dg;
+	struct sockaddr_un srv_un, srv_un_dg;
+	int pipe_parent[2];
+	pid_t child;
+	int status;
+	char buf_child;
+	int socket_fds_stream[2];
+
+	/* setup abstract addresses */
+	memset(&stream_address, 0, sizeof(stream_address));
+	set_unix_address(&stream_address, 0);
+	memset(&dgram_address, 0, sizeof(dgram_address));
+	set_unix_address(&dgram_address, 0);
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
+		int client, dgram_client;
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
+		ASSERT_EQ(0, connect(cli_fd, &srv_un, size));
+		ASSERT_EQ(0, close(cli_fd));
+
+		cli_fd_dg = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_LE(0, cli_fd_dg);
+		ASSERT_EQ(0, connect(cli_fd_dg, &srv_un_dg, size_dg));
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
+		err = connect(client, &stream_address.unix_addr,
+			      stream_address.unix_addr_len);
+		err_dg = connect(dgram_client, &dgram_address.unix_addr,
+				 dgram_address.unix_addr_len);
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
+	int srv_fd, srv_fd_dg, server, dgram_server;
+	int recv_data;
+
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	recv_data = recv_fd(socket_fds_stream[1]);
+	ASSERT_LE(0, recv_data);
+	ASSERT_LE(0, close(socket_fds_stream[1]));
+
+	/* Sets up a server */
+	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, srv_fd);
+	ASSERT_EQ(0, unlink(stream_path));
+	ASSERT_EQ(0, bind(srv_fd, &srv_un, size));
+	ASSERT_EQ(0, listen(srv_fd, backlog));
+
+	/* set up a datagram server */
+	ASSERT_EQ(0, unlink(dgram_path));
+	srv_fd_dg = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_LE(0, srv_fd_dg);
+	ASSERT_EQ(0, bind(srv_fd_dg, (struct sockaddr *)&srv_un_dg, size_dg));
+
+	/*set up abstract servers */
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, server);
+	ASSERT_NE(-1, dgram_server);
+	ASSERT_EQ(0, bind(server, &stream_address.unix_addr,
+			  stream_address.unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_server, &dgram_address.unix_addr,
+			  dgram_address.unix_addr_len));
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
+
 TEST_HARNESS_MAIN
-- 
2.34.1


