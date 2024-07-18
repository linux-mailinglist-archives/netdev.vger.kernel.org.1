Return-Path: <netdev+bounces-111995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A672934711
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F471F22538
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231348CCD;
	Thu, 18 Jul 2024 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR5q7KLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96E40C03;
	Thu, 18 Jul 2024 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276153; cv=none; b=SEwCvydMgeGwFoP8yDvUTZXq/fsqxfjmAgOt7ZcIirHOa27gyN2/N4o19IjsDJQIH9X/1SQ6mssr2cIAXlModGMJOOMV5y8XfNuJic0RxJjI1u3AtAQwxGF6ht6k8lLJQ5LcPTZ8mDPGPSZRmmqdu7E8JLWtfe425J0KnFQZ9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276153; c=relaxed/simple;
	bh=zpTIiq4Pd3CXcxbNiaiuVqSuXHu8A2JVd0vQeG/P4G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dchOvUimY5hpppV2Z+Z8Iy6rwWrTTRR6xet0G/EyARzQku1dxfxfgaHbeMUbaDcSQqq8IntpFrSdhpdSvo6GnWSsacjVVqLVbkGhok3gK6J8LE+6RTxwYud3dHN2gDfBWAGIM3zffX48nC1bIzosSUV30T27oJsqEcqGztSoofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR5q7KLO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb4fa1bb34so2745325ad.0;
        Wed, 17 Jul 2024 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721276150; x=1721880950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAXNK6oh1OvquTYa3iIIGyC/+Yv8FreGS29ljKxYu/o=;
        b=QR5q7KLOZ9Gj8l8i1hJZ3gpohUYPqzcjJJz3P7LLnLzBLFKUEEc0Kel9lXwI7ejCxE
         55uudry4rWW6trsKSBfdWRwRXVJ/1MRDa0crdBNXBg+PIkBi7vkRuWbKPR8+9RlKZmVL
         j/0B0FmvtA9Uw52k8b+pKv5XlRt37gwvmLvFZS4X/XcBcJs5JrDYbqZ/DUrgw8arA3ay
         Rf/gTpNcaT/viwDvihsrVyfDAue8oNe8mQ/qSORAS2ck0tqaHv/xEz89z+/QkqVt8x0e
         8s8IsFzj9o+MkVKqnuzmMfsYJpc9hoyKQe6nQ4mPNz9nGbmrqjNhxTv+Dvr5MaP9BTSu
         IDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721276150; x=1721880950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAXNK6oh1OvquTYa3iIIGyC/+Yv8FreGS29ljKxYu/o=;
        b=FyF0+Ds0DpzOu+dVu3U3FjBl3POcWsDniwQUS70pcKpwcW5xRsf0bYyB8YbBkHvGdr
         Ku9/5gvO752N1owP6ABMfQU3A4pcFRgBl1qWygi4q+wAHfpqu7XCGJJDI2Fk364mHcoX
         tFjgQrqH+BZf/a4rAV3Pl4P2fU6A3A1ukoLBTa3K+GOhKaTr0Xt/rNUAouzk6Vh+bASV
         kL67YZC6Yifo+SOc/GqHPmMclAZot1oOXgDQBn5bd9Y28/v58w3OMevxkh1jxFpR9tgG
         nDXVh/oYdK1x4zD12gVQs0BNyc/XjN5z25fegYMQw+D0ZJqFJ2s+NI3omkLyrU2yiqIA
         taIw==
X-Forwarded-Encrypted: i=1; AJvYcCUCE+zHeFkASfKUNkz0Ji/PCAIHKVyzC/u9a/4VsCnfcKnNgV2dZ+luvz8ldmTIE1uvRj+d5byWK1MvDpgJ+dI82AvnXWKWIxiqIs6MQGmFmo2IbZ6na4MfevOXJ2YUnOOuf7gTz+1XkHjUAPGAMFA0mpksu3w9w29cQ9a4jtxjaCVZ8+/5F57mN/81
X-Gm-Message-State: AOJu0YwnZ1//7WTW6Q8M3aEmEZxmb7WA/MF1cjqsI6jCC8U32lxl7B/N
	zrl5h3v3H+9SWVExtkJR7bpv/uEKED77t5A3yIlGLcJIg4UFSIOG
X-Google-Smtp-Source: AGHT+IG3Be9oGjUsd0OVWnkN6TyS+4rQC10fCrp1Jdh1/N06jf7z1t9oZkzBjdfnLH2UfwG7Y5jfFQ==
X-Received: by 2002:a17:902:650e:b0:1fc:5d0e:a214 with SMTP id d9443c01a7336-1fc5d0ea54fmr10842065ad.21.1721276150330;
        Wed, 17 Jul 2024 21:15:50 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38dc0sm83152785ad.215.2024.07.17.21.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 21:15:49 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v7 2/4] selftests/landlock: Abstract unix socket restriction tests
Date: Wed, 17 Jul 2024 22:15:20 -0600
Message-Id: <121e8df376327d8039266db19e53b8ff994b8d74.1721269836.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721269836.git.fahimitahera@gmail.com>
References: <cover.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch has three types of tests:
  1) unix_socket: base tests the scoping mechanism for a landlocked process,
     same as the ptrace test.
  2) optional_scoping: generates three processes with different domains and
     tests if a process with a non-scoped domain can connect to other processes.
  3) unix_sock_special_cases: since the socket's creator credentials are used
     for scoping datagram sockets, this test examines the cases where the
     socket's credentials are different from the process using it.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

Changes in versions:
V7:
 - Introducing landlock ABI version 6.
 - Adding some edge test cases to optional_scoping test.
 - Using `enum` for different domains in optional_scoping tests.
 - Extend unix_sock_special_cases test cases for connected(SOCK_STREAM) sockets.
 - Modifying inline comments.
V6:
 - Introducing optional_scoping test which ensures a sandboxed process with a
   non-scoped domain can still connect to another abstract unix socket(either
   sandboxed or non-sandboxed).
 - Introducing unix_sock_special_cases test which tests examines scenarios where
   the connecting sockets have different domain than the process using them.
V4:
 - Introducing unix_socket to evaluate the basic scoping mechanism for abstract
   unix sockets.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 .../testing/selftests/landlock/ptrace_test.c  | 867 ++++++++++++++++++
 2 files changed, 868 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 3c1e9f35b531..52b00472a487 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(6, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..e7dcefda8ce0 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -17,6 +17,10 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stddef.h>
+
 #include "common.h"
 
 /* Copied from security/yama/yama_lsm.c */
@@ -436,4 +440,867 @@ TEST_F(hierarchy, trace)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+static void create_unix_domain(struct __test_metadata *const _metadata)
+{
+	int ruleset_fd;
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
+	};
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	EXPECT_LE(0, ruleset_fd)
+	{
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+/* clang-format off */
+FIXTURE(unix_socket)
+{
+	int server, client, dgram_server, dgram_client;
+};
+
+/* clang-format on */
+FIXTURE_VARIANT(unix_socket)
+{
+	bool domain_both;
+	bool domain_parent;
+	bool domain_child;
+	bool connect_to_parent;
+};
+
+/*
+ *        No domain
+ *
+ *   P1-.               P1 -> P2 : allow
+ *       \              P2 -> P1 : allow
+ *        'P2
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_without_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_without_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *        Child domain
+ *
+ *   P1--.              P1 -> P2 : allow
+ *        \             P2 -> P1 : deny
+ *        .'-----.
+ *        |  P2  |
+ *        '------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_one_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_with_one_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = false,
+};
+
+/*
+ *        Parent domain
+ * .------.
+ * |  P1  --.           P1 -> P2 : deny
+ * '------'  \          P2 -> P1 : allow
+ *            '
+ *            P2
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_with_parent_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_parent_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *        Parent + child domain (siblings)
+ * .------.
+ * |  P1  ---.          P1 -> P2 : deny
+ * '------'   \         P2 -> P1 : deny
+ *         .---'--.
+ *         |  P2  |
+ *         '------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_sibling_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_sibling_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = true,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Same domain (inherited)
+ * .-------------.
+ * | P1----.     |      P1 -> P2 : allow
+ * |        \    |      P2 -> P1 : allow
+ * |         '   |
+ * |         P2  |
+ * '-------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_inherited_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_inherited_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Inherited + child domain
+ * .-----------------.
+ * |  P1----.        |  P1 -> P2 : allow
+ * |         \       |  P2 -> P1 : deny
+ * |        .-'----. |
+ * |        |  P2  | |
+ * |        '------' |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_nested_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_nested_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Inherited + parent domain
+ * .-----------------.
+ * |.------.         |  P1 -> P2 : deny
+ * ||  P1  ----.     |  P2 -> P1 : allow
+ * |'------'    \    |
+ * |             '   |
+ * |             P2  |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_with_nested_and_parent_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_nested_and_parent_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Inherited + parent and child domain (siblings)
+ * .-----------------.
+ * | .------.        |  P1 -> P2 : deny
+ * | |  P1  .        |  P2 -> P1 : deny
+ * | '------'\       |
+ * |          \      |
+ * |        .--'---. |
+ * |        |  P2  | |
+ * |        '------' |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_forked_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_forked_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+	.connect_to_parent = false,
+};
+
+FIXTURE_SETUP(unix_socket)
+{
+}
+
+FIXTURE_TEARDOWN(unix_socket)
+{
+	close(self->server);
+	close(self->client);
+	close(self->dgram_server);
+	close(self->dgram_client);
+}
+
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and child,
+ * when they have scoped domain or no domain.
+ */
+TEST_F(unix_socket, abstract_unix_socket)
+{
+	int status;
+	pid_t child;
+	socklen_t addrlen;
+	int sock_len = 5;
+	struct sockaddr_un addr, dgram_addr = {
+		.sun_family = AF_UNIX,
+	};
+	const char sun_path[8] = "\0test";
+	const char sun_path_dgram[8] = "\0dgrm";
+	bool can_connect_to_parent, can_connect_to_child;
+	int err, err_dgram;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	/*
+	 * can_connect_to_child is true if a parent process can connect to its
+	 * child process. The parent process is not isolated from the child
+	 * with a dedicated Landlock domain.
+	 */
+	can_connect_to_child = !variant->domain_parent;
+	/*
+	 * can_connect_to_parent is true if a child process can connect to its
+	 * parent process. This depends on the child process is not isolated from
+	 * the parent with a dedicated Landlock domain.
+	 */
+	can_connect_to_parent = !variant->domain_child;
+
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	if (variant->domain_both) {
+		create_unix_domain(_metadata);
+		if (!__test_passed(_metadata))
+			return;
+	}
+
+	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
+	memcpy(&addr.sun_path, sun_path, sock_len);
+	memcpy(&dgram_addr.sun_path, sun_path_dgram, sock_len);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child)
+			create_unix_domain(_metadata);
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		if (variant->connect_to_parent) {
+			self->client = socket(AF_UNIX, SOCK_STREAM, 0);
+			self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+			ASSERT_NE(-1, self->client);
+			ASSERT_NE(-1, self->dgram_client);
+			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+			err = connect(self->client, (struct sockaddr *)&addr,
+				      addrlen);
+			err_dgram = connect(self->dgram_client,
+					    (struct sockaddr *)&dgram_addr,
+					    addrlen);
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, err);
+				EXPECT_EQ(0, err_dgram);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(-1, err_dgram);
+				EXPECT_EQ(EPERM, errno);
+			}
+		} else {
+			self->server = socket(AF_UNIX, SOCK_STREAM, 0);
+			self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+			ASSERT_NE(-1, self->server);
+			ASSERT_NE(-1, self->dgram_server);
+
+			ASSERT_EQ(0, bind(self->server,
+					  (struct sockaddr *)&addr, addrlen));
+			ASSERT_EQ(0, bind(self->dgram_server,
+					  (struct sockaddr *)&dgram_addr,
+					  addrlen));
+			ASSERT_EQ(0, listen(self->server, 32));
+
+			/* signal to parent that child is listening */
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+			/* wait to connect */
+			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+		}
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent)
+		create_unix_domain(_metadata);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	if (!variant->connect_to_parent) {
+		self->client = socket(AF_UNIX, SOCK_STREAM, 0);
+		self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+		ASSERT_NE(-1, self->client);
+		ASSERT_NE(-1, self->dgram_client);
+
+		/* Waits for the child to listen */
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		err = connect(self->client, (struct sockaddr *)&addr, addrlen);
+		err_dgram = connect(self->dgram_client,
+				    (struct sockaddr *)&dgram_addr, addrlen);
+
+		if (can_connect_to_child) {
+			EXPECT_EQ(0, err);
+			EXPECT_EQ(0, err_dgram);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(-1, err_dgram);
+			EXPECT_EQ(EPERM, errno);
+		}
+		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	} else {
+		self->server = socket(AF_UNIX, SOCK_STREAM, 0);
+		self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, self->server);
+		ASSERT_NE(-1, self->dgram_server);
+		ASSERT_EQ(0, bind(self->server, (struct sockaddr *)&addr,
+				  addrlen));
+		ASSERT_EQ(0, bind(self->dgram_server,
+				  (struct sockaddr *)&dgram_addr, addrlen));
+		ASSERT_EQ(0, listen(self->server, 32));
+
+		/* signal to child that parent is listening */
+		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+enum sandbox_type {
+	NO_SANDBOX,
+	SCOPE_SANDBOX,
+	/* Any other type of sandboxing domain */
+	OTHER_SANDBOX,
+};
+
+/* clang-format off */
+FIXTURE(optional_scoping)
+{
+	int parent_server, child_server, client;
+};
+
+/* clang-format on */
+FIXTURE_VARIANT(optional_scoping)
+{
+	const int domain_all;
+	const int domain_parent;
+	const int domain_children;
+	const int domain_child;
+	const int domain_grand_child;
+	const int type;
+};
+
+/*
+ * .-----------------.
+ * |         ####### |  P3 -> P2 : allow
+ * |   P1----# P2  # |  P3 -> P1 : deny
+ * |         #  |  # |
+ * |         # P3  # |
+ * |         ####### |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, deny_scoped) {
+	.domain_all = OTHER_SANDBOX,
+	.domain_parent = NO_SANDBOX,
+	.domain_children = SCOPE_SANDBOX,
+	.domain_child = NO_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
+	.type = SOCK_DGRAM,
+	/* clang-format on */
+};
+
+/*
+ * .-----------------.
+ * |         .-----. |  P3 -> P2 : allow
+ * |   P1----| P2  | |  P3 -> P1 : allow
+ * |         |     | |
+ * |         | P3  | |
+ * |         '-----' |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, allow_with_other_domain) {
+	.domain_all = OTHER_SANDBOX,
+	.domain_parent = NO_SANDBOX,
+	.domain_children = OTHER_SANDBOX,
+	.domain_child = NO_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
+	.type = SOCK_DGRAM,
+	/* clang-format on */
+};
+
+/*
+ *  .----.    ######   P3 -> P2 : allow
+ *  | P1 |----# P2 #   P3 -> P1 : allow
+ *  '----'    ######
+ *              |
+ *              P3
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, allow_with_one_domain) {
+        .domain_all = NO_SANDBOX,
+        .domain_parent = OTHER_SANDBOX,
+        .domain_children = NO_SANDBOX,
+        .domain_child = SCOPE_SANDBOX,
+        .domain_grand_child = NO_SANDBOX,
+        .type = SOCK_DGRAM,
+	/* clang-format on */
+};
+
+/*
+ *  ######    .-----.   P3 -> P2 : allow
+ *  # P1 #----| P2  |   P3 -> P1 : allow
+ *  ######    '-----'
+ *              |
+ *              P3    
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, allow_with_grand_parent_scoped) {
+        .domain_all = NO_SANDBOX,
+        .domain_parent = SCOPE_SANDBOX,
+        .domain_children = NO_SANDBOX,
+        .domain_child = OTHER_SANDBOX,
+        .domain_grand_child = NO_SANDBOX,
+        .type = SOCK_STREAM,
+	/* clang-format on */
+};
+
+/*
+ *  ######    ######   P3 -> P2 : allow
+ *  # P1 #----# P2 #   P3 -> P1 : allow
+ *  ######    ######
+ *               |
+ *             .----.
+ *             | P3 |
+ *             '----'  
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, allow_with_parents_domain) {
+        .domain_all = NO_SANDBOX,
+        .domain_parent = SCOPE_SANDBOX,
+        .domain_children = NO_SANDBOX,
+        .domain_child = SCOPE_SANDBOX,
+        .domain_grand_child = NO_SANDBOX,
+        .type = SOCK_STREAM,
+	/* clang-format on */
+};
+
+FIXTURE_SETUP(optional_scoping)
+{
+}
+
+FIXTURE_TEARDOWN(optional_scoping)
+{
+	close(self->parent_server);
+	close(self->child_server);
+	close(self->client);
+}
+
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent, child
+ * and grand child processes when they can have scoped or non-scoped
+ * domains.
+ **/
+TEST_F(optional_scoping, unix_scoping)
+{
+	pid_t child;
+	socklen_t addrlen;
+	int sock_len = 5;
+	int status;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	const char sun_path[8] = "\0test";
+	bool can_connect_to_parent, can_connect_to_child;
+	int pipe_parent[2];
+
+	if (variant->domain_grand_child == SCOPE_SANDBOX)
+		can_connect_to_child = false;
+	else
+		can_connect_to_child = true;
+
+	if (!can_connect_to_child || variant->domain_children == SCOPE_SANDBOX)
+		can_connect_to_parent = false;
+	else
+		can_connect_to_parent = true;
+
+	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
+	memcpy(&addr.sun_path, sun_path, sock_len);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	if (variant->domain_all == OTHER_SANDBOX)
+		create_domain(_metadata);
+	else if (variant->domain_all == SCOPE_SANDBOX)
+		create_unix_domain(_metadata);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int pipe_child[2];
+		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+		pid_t grand_child;
+		struct sockaddr_un child_addr = {
+			.sun_family = AF_UNIX,
+		};
+		const char child_sun_path[8] = "\0tsst";
+
+		memcpy(&child_addr.sun_path, child_sun_path, sock_len);
+
+		if (variant->domain_children == OTHER_SANDBOX)
+			create_domain(_metadata);
+		else if (variant->domain_children == SCOPE_SANDBOX)
+			create_unix_domain(_metadata);
+
+		grand_child = fork();
+		ASSERT_LE(0, grand_child);
+		if (grand_child == 0) {
+			ASSERT_EQ(0, close(pipe_parent[1]));
+			ASSERT_EQ(0, close(pipe_child[1]));
+
+			char buf1, buf2;
+			int err;
+
+			if (variant->domain_grand_child == OTHER_SANDBOX)
+				create_domain(_metadata);
+			else if (variant->domain_grand_child == SCOPE_SANDBOX)
+				create_unix_domain(_metadata);
+
+			self->client = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, self->client);
+
+			ASSERT_EQ(1, read(pipe_child[0], &buf2, 1));
+			err = connect(self->client,
+				      (struct sockaddr *)&child_addr, addrlen);
+			if (can_connect_to_child) {
+				EXPECT_EQ(0, err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(EPERM, errno);
+			}
+
+			if (variant->type == SOCK_STREAM) {
+				EXPECT_EQ(0, close(self->client));
+				self->client =
+					socket(AF_UNIX, variant->type, 0);
+				ASSERT_NE(-1, self->client);
+			}
+
+			ASSERT_EQ(1, read(pipe_parent[0], &buf1, 1));
+			err = connect(self->client, (struct sockaddr *)&addr,
+				      addrlen);
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(EPERM, errno);
+			}
+			EXPECT_EQ(0, close(self->client));
+
+			_exit(_metadata->exit_code);
+			return;
+		}
+
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child == OTHER_SANDBOX)
+			create_domain(_metadata);
+		else if (variant->domain_child == SCOPE_SANDBOX)
+			create_unix_domain(_metadata);
+
+		self->child_server = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, self->child_server);
+		ASSERT_EQ(0, bind(self->child_server,
+				  (struct sockaddr *)&child_addr, addrlen));
+		if (variant->type == SOCK_STREAM)
+			ASSERT_EQ(0, listen(self->child_server, 32));
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent == OTHER_SANDBOX)
+		create_domain(_metadata);
+	else if (variant->domain_parent == SCOPE_SANDBOX)
+		create_unix_domain(_metadata);
+
+	self->parent_server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_NE(-1, self->parent_server);
+	ASSERT_EQ(0,
+		  bind(self->parent_server, (struct sockaddr *)&addr, addrlen));
+
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(self->parent_server, 32));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * Since the special case of scoping only happens when the connecting socket
+ * is scoped, the client's domain is true for all the following test cases.
+ */
+/* clang-format off */
+FIXTURE(unix_sock_special_cases) {
+	int server_socket, client;
+	int stream_server, stream_client;
+};
+
+/* clang-format on */
+FIXTURE_VARIANT(unix_sock_special_cases)
+{
+	const bool domain_server;
+	const bool domain_server_socket;
+	const int type;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_dgram_server_sock_domain) {
+	/* clang-format on */
+	.domain_server = false,
+	.domain_server_socket = true,
+	.type = SOCK_DGRAM,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_dgram_server_domain) {
+	/* clang-format off */
+	.domain_server = true,
+	.domain_server_socket = false,
+	.type = SOCK_DGRAM,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_stream_server_sock_domain) {
+	/* clang-format on */
+	.domain_server = false,
+	.domain_server_socket = true,
+	.type = SOCK_STREAM,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_stream_server_domain) {
+        /* clang-format off */
+        .domain_server = true,
+        .domain_server_socket = false,
+        .type = SOCK_STREAM,
+};
+
+FIXTURE_SETUP(unix_sock_special_cases)
+{
+}
+
+FIXTURE_TEARDOWN(unix_sock_special_cases)
+{
+	close(self->client);
+	close(self->server_socket);
+	close(self->stream_server);
+	close(self->stream_client);
+}
+
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and
+ * child processes when connecting socket has different domain
+ * than the process using it.
+ **/
+TEST_F(unix_sock_special_cases, dgram_cases)
+{
+	pid_t child;
+	socklen_t addrlen;
+	int sock_len = 5;
+	struct sockaddr_un addr, addr_stream = {
+		.sun_family = AF_UNIX,
+	};
+	const char sun_path[8] = "\0test";
+	const char sun_path_stream[8] = "\0strm";
+	int err, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
+	memcpy(&addr.sun_path, sun_path, sock_len);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+
+		/* client always has domain */
+		create_unix_domain(_metadata);
+
+		if (variant->domain_server_socket) {
+			int data_socket;
+			int fd_sock = socket(AF_UNIX, variant->type, 0);
+
+			ASSERT_NE(-1, fd_sock);
+
+			self->stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
+
+			ASSERT_NE(-1, self->stream_server);
+			memcpy(&addr_stream.sun_path, sun_path_stream,
+			       sock_len);
+			ASSERT_EQ(0, bind(self->stream_server,
+					  (struct sockaddr *)&addr_stream,
+					  addrlen));
+			ASSERT_EQ(0, listen(self->stream_server, 32));
+
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+			data_socket = accept(self->stream_server, NULL, NULL);
+
+			ASSERT_EQ(0, send_fd(data_socket, fd_sock));
+			ASSERT_EQ(0, close(fd_sock));
+			TH_LOG("sending completed\n");
+		}
+
+		self->client = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, self->client);
+		/* wait for parent signal for connection */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		err = connect(self->client, (struct sockaddr *)&addr, addrlen);
+		if (!variant->domain_server_socket) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+		}
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (!variant->domain_server_socket) {
+		self->server_socket = socket(AF_UNIX, variant->type, 0);
+	} else {
+		int cli = socket(AF_UNIX, SOCK_STREAM, 0);
+
+		ASSERT_NE(-1, cli);
+		memcpy(&addr_stream.sun_path, sun_path_stream, sock_len);
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		ASSERT_EQ(0, connect(cli, (struct sockaddr *)&addr_stream,
+				     addrlen));
+
+		self->server_socket = recv_fd(cli);
+		ASSERT_LE(0, self->server_socket);
+	}
+
+	ASSERT_NE(-1, self->server_socket);
+
+	if (variant->domain_server)
+		create_unix_domain(_metadata);
+
+	ASSERT_EQ(0,
+		  bind(self->server_socket, (struct sockaddr *)&addr, addrlen));
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(self->server_socket, 32));
+	/* signal to child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
 TEST_HARNESS_MAIN
-- 
2.34.1


