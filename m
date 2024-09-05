Return-Path: <netdev+bounces-125315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300CD96CBA0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AAB21BFB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213210A3E;
	Thu,  5 Sep 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5ko+Q4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8972D515;
	Thu,  5 Sep 2024 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495268; cv=none; b=g5gYoC9Tk39eQ7Zr/+gfe5WSmmqsbgytukyzTX37y+5ovhl9VGWHiT4P2V/mjT3NHfe/EYyPd49C+xWN73IXk6SKRBl8TkFsvRVyEHfeRXeD+azqdBXrzqE82quPAyGiFjuIfFXykEsvlPNxYTWbiPfb3anNs3s2Xgh1JhcuzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495268; c=relaxed/simple;
	bh=6Mppb/IteTfIlLgsMNenC9CxdXvOR6R4inruYITVZ04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlPQhr8kR9gNjEHI7HJSafnHQwXpkZwtJjQmUWGSuz/+o+Uu0z/DZqrTm6IjrtvDDY+4ryXGWJwzvP/Vwk4NkYgDk3q6fa7YerD6z4I9GtN0KXFzB+gdTlZzsdr0IfMbvhXFclCBFMJB+eYnAPFsK2fau7ooNWYOYqYRviKWBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5ko+Q4H; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70f794cd240so118978a34.0;
        Wed, 04 Sep 2024 17:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725495266; x=1726100066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdUGGmo4EZXMWUsoOjFrOLVLRkPFoKDmP9VM6UY6JiY=;
        b=Q5ko+Q4HBf6FnWdFTB0eFo95aJT2R7grtGU6oO7pRGEZoxjhkmfWYsMW4g6NZLBiQK
         D5avr2wxlqpvgar0Mxkjsgc+0naUtrsmundkEAC+urNME43gB1bnwzNmBmIsZkbNuFgk
         B/DEUhuXTm6IAZPj68bNYVjIMhAAOx6+XcbyGAKdrS6bjWNVqxPoqOsw8nIIJl99zqo0
         MjfHOLGGHqHm0ihR+x7q3xRH76FTjBxBVR83Yg0QbpGKTTda1fftetapkMvYv74Vtjtu
         nOeOQNLb36BNKkX6b+EeD7Qfggq8fIhKN07T8oZO3zP+Hy2yLibp3qypY1SDPI2aXl+Q
         2jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725495266; x=1726100066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdUGGmo4EZXMWUsoOjFrOLVLRkPFoKDmP9VM6UY6JiY=;
        b=EeBQnNDzI15lcAJsGI07HSpKZe7bgfzyqKD1JvWghx7T6DiEDJ8SNcuLe00uJ0E+oU
         YVD9SSiubYeapXMxRK0uqIDQ9MiR8ZV5K1ACQANPt7EuHWYFPqHvvlz/APHA8uFeV9bf
         JstKOXUka3u7JhqcLmbQKN4NeBEsAINHmRo5M/+NpatX99FM7KUU+eJWLIrXx9MmFxEE
         d3UKd0YK9vhsLGOcHMjmWQR9lqei8okr2D0wAeWz6AquBecirv75kpdwGwRamTprdDp2
         wi49UX5koETCk2V5K6w4E3bvG7yjCA08ly+fQv/DFpjfMzfskhxMpPUfX7dRUPgEJ0ft
         Ce4w==
X-Forwarded-Encrypted: i=1; AJvYcCU8gxeW+73uzD86jSvANheBYTD8MdaK2BXUW1bzmM77XDZsH4a2QfOPMu7w5DGjQ9nWeSmdycqKqeYIGaA=@vger.kernel.org, AJvYcCUFGLU3sIhBqVypJs6GqpjuszVIU3iopajVBnBnrWSpiWE1WPPt8LxmFIFVLdrxnF82ngNZUp4Qu+jmlpGGcMp+MHfmRDEY@vger.kernel.org, AJvYcCVlEZYTOvAeIaHBGOQfPBPYTv7NrDieUC/MA9IjIpCzjn6iqCOoMrzFpWqcs9QLiBNGITWxLDrV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+pMtQV8+v7QL3kFFH8/l/q6OGAgW63eln9LWvw7+qJNOl8VKW
	lYRXsBXm7q7TuiewV9J1m0tBX2NvH+Rh44Avolxgtnv7cSZ1mCt5E0ZLHJlu
X-Google-Smtp-Source: AGHT+IFUHVZGaAJdSoHKOAWujxHJjsI4Egi6h0piPVafcBQ2aa228X4CzWAN/Tv7siQ9XqpsZqQ7BQ==
X-Received: by 2002:a05:6358:7e50:b0:1b1:a8a6:1630 with SMTP id e5c5f4694b2df-1b7edbcc8bfmr2225984755d.20.1725495265851;
        Wed, 04 Sep 2024 17:14:25 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778534921sm2159781b3a.76.2024.09.04.17.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 17:14:25 -0700 (PDT)
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
Subject: [PATCH v11 4/8] selftests/landlock: Add tests for UNIX sockets with any address formats
Date: Wed,  4 Sep 2024 18:13:58 -0600
Message-Id: <a9e8016aaa5846252623b158c8f1ce0d666944f4.1725494372.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725494372.git.fahimitahera@gmail.com>
References: <cover.1725494372.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch expands abstract UNIX socket restriction tests by examining
different scenarios for UNIX sockets with pathname or unnamed address
formats connection with scoped domain.

The test "various_address_sockets" ensures that UNIX sockets bound to a
filesystem pathname and unnamed sockets created by socketpair can still
connect to a socket outside of their scoped domain, meaning that even if
the domain is scoped with LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET, the
socket can connect to a socket outside the scoped domain.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
changes in versions:
v11:
- Using generalized scoped domain creation, "create_scoped_domain"
- Rename pathname_address_sockets to various_address_sockets
- Using local variables.
- Commit improvement.
- Support test for unnamed datagram sockets(via socketpair(2)).
v10:
- Code improvements by changing fixture variables to local ones.
- Commit improvement.
v9:
- Moving remove_path() back to fs_test.c, and using unlink(2) and
  rmdir(2) instead.
- Removing hard-coded numbers and using "backlog" instead.
V8:
- Adding pathname_address_sockets to cover all types of address formats
  for unix sockets, and moving remove_path() to common.h to reuse in
  this test.
---
 .../landlock/scoped_abstract_unix_test.c      | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 00ea5151979f..8fc47e45d17e 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -617,4 +617,206 @@ TEST_F(outside_socket, socket_with_different_domain)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+static const char path1[] = TMP_DIR "/s1_variant1";
+static const char path2[] = TMP_DIR "/s2_variant1";
+
+/* clang-format off */
+FIXTURE(various_address_sockets)
+{
+	struct service_fixture stream_address, dgram_address;
+};
+/* clang-format on */
+
+FIXTURE_VARIANT(various_address_sockets)
+{
+	const int domain;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(various_address_sockets, pathname_socket_scoped_domain) {
+	/* clang-format on */
+	.domain = SCOPE_SANDBOX,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(various_address_sockets, pathname_socket_other_domain) {
+	/* clang-format on */
+	.domain = OTHER_SANDBOX,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(various_address_sockets, pathname_socket_no_domain) {
+	/* clang-format on */
+	.domain = NO_SANDBOX,
+};
+
+FIXTURE_SETUP(various_address_sockets)
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
+	memset(&self->stream_address, 0, sizeof(self->stream_address));
+	set_unix_address(&self->stream_address, 0);
+	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
+	set_unix_address(&self->dgram_address, 1);
+}
+
+FIXTURE_TEARDOWN(various_address_sockets)
+{
+	ASSERT_EQ(0, unlink(path1) & rmdir(path1));
+	ASSERT_EQ(0, unlink(path2) & rmdir(path2));
+	ASSERT_EQ(0, unlink(TMP_DIR) & rmdir(TMP_DIR));
+}
+
+TEST_F(various_address_sockets, scoped_pathname_sockets)
+{
+	const char *const stream_path = path1;
+	const char *const dgram_path = path2;
+	socklen_t size, size_dg;
+	struct sockaddr_un stream_pathname_addr, dgram_pathname_addr;
+	int unnamed_sockets[2];
+	int stream_pathname_socket, dgram_pathname_socket,
+		stream_abstract_socket, dgram_abstract_socket;
+	int pipe_parent[2];
+	pid_t child;
+	int status;
+	char buf_child;
+	char data = 'S';
+	char buf[5];
+	int nbyte;
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_DGRAM, 0, unnamed_sockets));
+
+	stream_pathname_addr.sun_family = AF_UNIX;
+	snprintf(stream_pathname_addr.sun_path,
+		 sizeof(stream_pathname_addr.sun_path), "%s", stream_path);
+	size = offsetof(struct sockaddr_un, sun_path) +
+	       strlen(stream_pathname_addr.sun_path);
+
+	dgram_pathname_addr.sun_family = AF_UNIX;
+	snprintf(dgram_pathname_addr.sun_path,
+		 sizeof(dgram_pathname_addr.sun_path), "%s", dgram_path);
+	size_dg = offsetof(struct sockaddr_un, sun_path) +
+		  strlen(dgram_pathname_addr.sun_path);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int err, err_dg;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+
+		if (variant->domain == SCOPE_SANDBOX)
+			create_scoped_domain(
+				_metadata,
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+		else if (variant->domain == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
+
+		ASSERT_EQ(0, close(unnamed_sockets[1]));
+		ASSERT_NE(-1, write(unnamed_sockets[0], &data, sizeof(data)));
+		ASSERT_EQ(0, close(unnamed_sockets[0]));
+
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		/* Connect with pathname sockets. */
+		stream_pathname_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, stream_pathname_socket);
+		ASSERT_EQ(0, connect(stream_pathname_socket,
+				     &stream_pathname_addr, size));
+		dgram_pathname_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_LE(0, dgram_pathname_socket);
+		ASSERT_EQ(0, connect(dgram_pathname_socket,
+				     &dgram_pathname_addr, size_dg));
+
+		/* Connect with abstract sockets. */
+		stream_abstract_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		dgram_abstract_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+		ASSERT_NE(-1, stream_abstract_socket);
+		ASSERT_NE(-1, dgram_abstract_socket);
+
+		err = connect(stream_abstract_socket,
+			      &self->stream_address.unix_addr,
+			      self->stream_address.unix_addr_len);
+		err_dg = connect(dgram_abstract_socket,
+				 &self->dgram_address.unix_addr,
+				 self->dgram_address.unix_addr_len);
+		if (variant->domain == SCOPE_SANDBOX) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(-1, err_dg);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+			EXPECT_EQ(0, err_dg);
+		}
+		ASSERT_EQ(0, close(stream_abstract_socket));
+		ASSERT_EQ(0, close(dgram_abstract_socket));
+		ASSERT_EQ(0, close(stream_pathname_socket));
+		ASSERT_EQ(0, close(dgram_pathname_socket));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	ASSERT_EQ(0, close(unnamed_sockets[0]));
+	nbyte = read(unnamed_sockets[1], buf, sizeof(buf));
+	ASSERT_EQ(sizeof(data), nbyte);
+	buf[nbyte] = '\0';
+	ASSERT_EQ(0, strcmp(&data, buf));
+	ASSERT_LE(0, close(unnamed_sockets[1]));
+
+	/* Sets up pathname servers */
+	stream_pathname_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, stream_pathname_socket);
+	ASSERT_EQ(0, unlink(stream_path));
+	ASSERT_EQ(0, bind(stream_pathname_socket, &stream_pathname_addr, size));
+	ASSERT_EQ(0, listen(stream_pathname_socket, backlog));
+
+	ASSERT_EQ(0, unlink(dgram_path));
+	dgram_pathname_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_LE(0, dgram_pathname_socket);
+	ASSERT_EQ(0,
+		  bind(dgram_pathname_socket, &dgram_pathname_addr, size_dg));
+
+	/* Set up abstract servers */
+	stream_abstract_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+	dgram_abstract_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, stream_abstract_socket);
+	ASSERT_NE(-1, dgram_abstract_socket);
+	ASSERT_EQ(0,
+		  bind(stream_abstract_socket, &self->stream_address.unix_addr,
+		       self->stream_address.unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_abstract_socket, &self->dgram_address.unix_addr,
+			  self->dgram_address.unix_addr_len));
+	ASSERT_EQ(0, listen(stream_abstract_socket, backlog));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	ASSERT_EQ(0, close(stream_abstract_socket));
+	ASSERT_EQ(0, close(dgram_abstract_socket));
+	ASSERT_EQ(0, close(stream_pathname_socket));
+	ASSERT_EQ(0, close(dgram_pathname_socket));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


