Return-Path: <netdev+bounces-119986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7094957C45
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD7D1C23CF2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67414A4DC;
	Tue, 20 Aug 2024 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5XtBSGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067513A86A;
	Tue, 20 Aug 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126955; cv=none; b=HuQdnsI5vZUPsDd1P/Oj+hFbS2N8deMfI41j14xwh9DzesBPGrZ3DofDV9+VRjRY5FSBoxAUf7VCAmZun0dk32M2wWeLxLNs2IF60bUb6m4QTjESp8vGlg2GBCDri6ilAmrc1rful7/9W3xfGk83+HuXvC5WvReibGQpegArDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126955; c=relaxed/simple;
	bh=AY2dHqn0gFye+gMRqVBT7KXbAEEc2sEdYhI9sSeiVcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxM9ZRQU3oWXTfnE9MUrmSCtXiWYhSFZ9at+s9xl9nBgZjvX/OTSkOHvNJzdKi43U953/eUw87397WIkU0BAQAMb30LC0cIhwC22vmB7j3Rg+NWfStPznhMDAsjeOPhyBV62luyHxhklYXluqHAMSwOACoSjH5DNpCbAXrwPex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5XtBSGQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso1189748a91.1;
        Mon, 19 Aug 2024 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724126952; x=1724731752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=348hC+qUJAN//OemUj/mXNXgLaL+OoMhTYQtuPxoWRI=;
        b=C5XtBSGQ4cMYZcnczs0wECYWSnaXQK9pGB/YFiALFy4OMcNQ80jrM4RBK85njY1m+w
         jF9K2XPJgqkbpMSgCVH/eF4TWu4Eg3VYzJfQAKd8PpYf258KSzQjIqfuF3bSjnqLrY8M
         mCZ1atLKi1Hp7jqDCprzqCMv3r2AyfVLXD91gGnLfLyoKMY/MrIoirCiTa+EYEMYJK66
         OSuAcuSGCReDNeyRbN7We969PnzT4KeACIJtNb6eC5+wF8pgiTaX/NVdvmnF3Gn0XaG2
         NkI1EYbIKHtra1ONJUNPJElLgs4J5Bu/xxSpKaVy6VFfpaLFrYpfT8Kn7vjPEHSwtPKB
         0iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126952; x=1724731752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=348hC+qUJAN//OemUj/mXNXgLaL+OoMhTYQtuPxoWRI=;
        b=auYbvMZTtZU73oOH2wigDvYlneCb4taXmanbCAdYD7WHkklN4330PVQv3W0oPhI4Va
         LhsGXjEeSKu8seXPa4JH4Wdp9+lk/Jee4jueqhs0eJpkDAWzVzAhKM3H0+2BeKtSLivc
         FmK6eismqSGqYorUcHPdD+jihO7MARsDXadcgTA4tNepKx02misXAjPeBDC9cimVJt7N
         J7bfliQ5m5bUt6Pl4D+X2FbspsNbWnFz0XDf42YInjnPaRsmzE3TpEPT6qxMELehFhB3
         DW1tIVKr6PQ/MdS4WYD654tNboYhLhx9ATS4DvDVci1P8ibvUuJa8lZLJFigzUJReiT5
         0USw==
X-Forwarded-Encrypted: i=1; AJvYcCVyzANL7dxGzNHE3xuEJyTpsPvJBj4ngkeJGg65LmIe5M0x7R4v0caC9IMrwMPqdcp4heVLaUXCvIpuGt4=@vger.kernel.org, AJvYcCX1xhyen2WQrrFe6RQQlq33hD0C+X2RISbsCshX4wkV972AQmfxWNvuW4YWL2ahNnbXOFyIpSJf@vger.kernel.org, AJvYcCXGjv8xPy7KmeMziiwjjttqcVlzQXcDZ2FZJfRy4vv1Pssf4GKmf8BXVGvzHOHRThdBq36R/g4kmJDqouunUg46emlCkNJe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9++dx7G3+zt1w/tyeRaZQHJer5Lpvkwwcty7padLQuUJh0sZY
	La5SjB7teeYs+gy5d8y1tOOJTrHOAGWUX6/WN+Fj250Etyd2cDwXvvnrGa3q
X-Google-Smtp-Source: AGHT+IH6E2m5ZoPkwXRWVOBYWCPtfdGUunmu7zknVsYvv0UmpbNSe33P/eX4dYoKoZDA4SMm6lidZQ==
X-Received: by 2002:a17:90b:1c04:b0:2c9:6188:f3e with SMTP id 98e67ed59e1d1-2d4733ff428mr2596797a91.16.1724126952162;
        Mon, 19 Aug 2024 21:09:12 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8149652a91.27.2024.08.19.21.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:09:11 -0700 (PDT)
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
Subject: [PATCH v10 3/6] selftests/Landlock: Abstract UNIX socket restriction tests
Date: Mon, 19 Aug 2024 22:08:53 -0600
Message-Id: <01efd9cd2243b96e784e116510f5fca674b815b6.1724125513.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724125513.git.fahimitahera@gmail.com>
References: <cover.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch introduces Landlock ABI version 6 and adds three types of tests
that examines different scenarios for abstract unix socket:
1) unix_socket: base tests of the abstract socket scoping mechanism for a
   landlocked process, same as the ptrace test.
2) optional_scoping: generates three processes with different domains and
   tests if a process with a non-scoped domain can connect to other
   processes.
3) outside_socket: since the socket's creator credentials are used
   for scoping sockets, this test examines the cases where the socket's
   credentials are different from the process using it.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
Changes in versions:
v10:
- Code improvements by changing fixture variables to local ones.
- Rename "unix_sock_special_cases" to "outside_socket"
v9:
- Move pathname_address_sockets to a different patch.
- Extend optional_scoping test scenarios.
- Removing hardcoded numbers and using "backlog" instead.
V8:
- Move tests to scoped_abstract_unix_test.c file.
- To avoid potential conflicts among Unix socket names in different tests,
  set_unix_address is added to common.h to set different sun_path for Unix sockets.
- protocol_variant and service_fixture structures are also moved to common.h
- Adding pathname_address_sockets to cover all types of address formats
  for unix sockets, and moving remove_path() to common.h to reuse in this test.
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
---
 tools/testing/selftests/landlock/common.h     |  38 +
 tools/testing/selftests/landlock/net_test.c   |  31 +-
 .../landlock/scoped_abstract_unix_test.c      | 931 ++++++++++++++++++
 3 files changed, 970 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 7e2b431b9f90..cca387df86c2 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -7,6 +7,7 @@
  * Copyright © 2021 Microsoft Corporation
  */
 
+#include <arpa/inet.h>
 #include <errno.h>
 #include <linux/landlock.h>
 #include <linux/securebits.h>
@@ -14,10 +15,12 @@
 #include <sys/socket.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
+#include <sys/un.h>
 #include <sys/wait.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#define TMP_DIR "tmp"
 
 #ifndef __maybe_unused
 #define __maybe_unused __attribute__((__unused__))
@@ -226,3 +229,38 @@ enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
 		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
 	}
 }
+
+struct protocol_variant {
+	int domain;
+	int type;
+};
+
+struct service_fixture {
+	struct protocol_variant protocol;
+	/* port is also stored in ipv4_addr.sin_port or ipv6_addr.sin6_port */
+	unsigned short port;
+	union {
+		struct sockaddr_in ipv4_addr;
+		struct sockaddr_in6 ipv6_addr;
+		struct {
+			struct sockaddr_un unix_addr;
+			socklen_t unix_addr_len;
+		};
+	};
+};
+
+static pid_t __maybe_unused sys_gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
+static void __maybe_unused set_unix_address(struct service_fixture *const srv,
+					    const unsigned short index)
+{
+	srv->unix_addr.sun_family = AF_UNIX;
+	sprintf(srv->unix_addr.sun_path,
+		"_selftests-landlock-abstract-unix-tid%d-index%d", sys_gettid(),
+		index);
+	srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
+	srv->unix_addr.sun_path[0] = '\0';
+}
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index f21cfbbc3638..4e0aeb53b225 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -36,30 +36,6 @@ enum sandbox_type {
 	TCP_SANDBOX,
 };
 
-struct protocol_variant {
-	int domain;
-	int type;
-};
-
-struct service_fixture {
-	struct protocol_variant protocol;
-	/* port is also stored in ipv4_addr.sin_port or ipv6_addr.sin6_port */
-	unsigned short port;
-	union {
-		struct sockaddr_in ipv4_addr;
-		struct sockaddr_in6 ipv6_addr;
-		struct {
-			struct sockaddr_un unix_addr;
-			socklen_t unix_addr_len;
-		};
-	};
-};
-
-static pid_t sys_gettid(void)
-{
-	return syscall(__NR_gettid);
-}
-
 static int set_service(struct service_fixture *const srv,
 		       const struct protocol_variant prot,
 		       const unsigned short index)
@@ -92,12 +68,7 @@ static int set_service(struct service_fixture *const srv,
 		return 0;
 
 	case AF_UNIX:
-		srv->unix_addr.sun_family = prot.domain;
-		sprintf(srv->unix_addr.sun_path,
-			"_selftests-landlock-net-tid%d-index%d", sys_gettid(),
-			index);
-		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
-		srv->unix_addr.sun_path[0] = '\0';
+		set_unix_address(srv, index);
 		return 0;
 	}
 	return 1;
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
new file mode 100644
index 000000000000..65c1ac2895a9
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Abstract Unix Socket
+ *
+ * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <sched.h>
+#include <signal.h>
+#include <stddef.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "common.h"
+
+/* Number pending connections queue to be hold. */
+const short backlog = 10;
+
+static void create_fs_domain(struct __test_metadata *const _metadata)
+{
+	int ruleset_fd;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	EXPECT_LE(0, ruleset_fd)
+	{
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
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
+FIXTURE(unix_socket) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(unix_socket)
+{
+	bool domain_both;
+	bool domain_parent;
+	bool domain_child;
+	bool connect_to_parent;
+};
+
+FIXTURE_SETUP(unix_socket)
+{
+}
+
+FIXTURE_TEARDOWN(unix_socket)
+{
+}
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
+/*
+ * Test unix_stream_connect()  and unix_may_send() for parent and child,
+ * when they have scoped domain or no domain.
+ */
+TEST_F(unix_socket, abstract_unix_socket)
+{
+	struct service_fixture stream_address, dgram_address;
+	pid_t child;
+	bool can_connect_to_parent, can_connect_to_child;
+	int err, err_dgram, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	memset(&stream_address, 0, sizeof(stream_address));
+	memset(&dgram_address, 0, sizeof(dgram_address));
+	set_unix_address(&stream_address, 0);
+	set_unix_address(&dgram_address, 1);
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
+			int client, dgram_client;
+
+			client = socket(AF_UNIX, SOCK_STREAM, 0);
+			dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+			ASSERT_NE(-1, client);
+			ASSERT_NE(-1, dgram_client);
+			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+			err = connect(client, &stream_address.unix_addr,
+				      stream_address.unix_addr_len);
+			err_dgram = connect(dgram_client,
+					    &dgram_address.unix_addr,
+					    dgram_address.unix_addr_len);
+
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, err);
+				EXPECT_EQ(0, err_dgram);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(-1, err_dgram);
+				EXPECT_EQ(EPERM, errno);
+			}
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+			ASSERT_EQ(0, close(client));
+			ASSERT_EQ(0, close(dgram_client));
+		} else {
+			int server, dgram_server;
+
+			server = socket(AF_UNIX, SOCK_STREAM, 0);
+			dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+			ASSERT_NE(-1, server);
+			ASSERT_NE(-1, dgram_server);
+
+			ASSERT_EQ(0, bind(server, &stream_address.unix_addr,
+					  stream_address.unix_addr_len));
+			ASSERT_EQ(0,
+				  bind(dgram_server, &dgram_address.unix_addr,
+				       dgram_address.unix_addr_len));
+			ASSERT_EQ(0, listen(server, backlog));
+
+			/* signal to parent that child is listening */
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+			/* wait to connect */
+			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+			ASSERT_EQ(0, close(server));
+			ASSERT_EQ(0, close(dgram_server));
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
+		int client, dgram_client;
+
+		client = socket(AF_UNIX, SOCK_STREAM, 0);
+		dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, client);
+		ASSERT_NE(-1, dgram_client);
+
+		/* Waits for the child to listen */
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		err = connect(client, &stream_address.unix_addr,
+			      stream_address.unix_addr_len);
+		err_dgram = connect(dgram_client, &dgram_address.unix_addr,
+				    dgram_address.unix_addr_len);
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
+		ASSERT_EQ(0, close(client));
+		ASSERT_EQ(0, close(dgram_client));
+	} else {
+		int server, dgram_server;
+
+		server = socket(AF_UNIX, SOCK_STREAM, 0);
+		dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, server);
+		ASSERT_NE(-1, dgram_server);
+		ASSERT_EQ(0, bind(server, &stream_address.unix_addr,
+				  stream_address.unix_addr_len));
+		ASSERT_EQ(0, bind(dgram_server, &dgram_address.unix_addr,
+				  dgram_address.unix_addr_len));
+		ASSERT_EQ(0, listen(server, backlog));
+
+		/* signal to child that parent is listening */
+		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+
+		ASSERT_EQ(0, close(server));
+		ASSERT_EQ(0, close(dgram_server));
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
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
+FIXTURE(optional_scoping) {};
+/* clang-format on */
+
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
+FIXTURE_SETUP(optional_scoping)
+{
+}
+
+FIXTURE_TEARDOWN(optional_scoping)
+{
+}
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
+ * ###################
+ * #         ####### #  P3 -> P2 : allow
+ * #   P1----# P2  # #  P3 -> P1 : deny
+ * #         #  |  # #
+ * #         # P3  # #
+ * #         ####### #
+ * ###################
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, all_scoped) {
+	.domain_all = SCOPE_SANDBOX,
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
+	.domain_all = NO_SANDBOX,
+	.domain_parent = OTHER_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = SCOPE_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
+	.type = SOCK_DGRAM,
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
+	.domain_all = NO_SANDBOX,
+	.domain_parent = SCOPE_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = OTHER_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
+	.type = SOCK_STREAM,
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
+	.domain_all = NO_SANDBOX,
+	.domain_parent = SCOPE_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = SCOPE_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
+	.type = SOCK_STREAM,
+	/* clang-format on */
+};
+
+/*
+ *  ######		P3 -> P2 : deny
+ *  # P1 #----P2	P3 -> P1 : deny
+ *  ######     |
+ *	       |
+ *	     ######
+ *           # P3 #
+ *           ######
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, deny_with_self_and_parents_domain) {
+	.domain_all = NO_SANDBOX,
+	.domain_parent = SCOPE_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = NO_SANDBOX,
+	.domain_grand_child = SCOPE_SANDBOX,
+	.type = SOCK_STREAM,
+	/* clang-format on */
+};
+
+/*
+ * Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent, child
+ * and grand child processes when they can have scoped or non-scoped
+ * domains.
+ */
+TEST_F(optional_scoping, unix_scoping)
+{
+	struct service_fixture parent_address;
+	pid_t child;
+	int status;
+	bool can_connect_to_parent, can_connect_to_child;
+	int pipe_parent[2];
+
+	memset(&parent_address, 0, sizeof(parent_address));
+	set_unix_address(&parent_address, 0);
+
+	can_connect_to_child = (variant->domain_grand_child != SCOPE_SANDBOX);
+	can_connect_to_parent = (can_connect_to_child &&
+				 (variant->domain_children != SCOPE_SANDBOX));
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	if (variant->domain_all == OTHER_SANDBOX)
+		create_fs_domain(_metadata);
+	else if (variant->domain_all == SCOPE_SANDBOX)
+		create_unix_domain(_metadata);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int pipe_child[2];
+		pid_t grand_child;
+		struct service_fixture child_address;
+
+		memset(&child_address, 0, sizeof(child_address));
+		set_unix_address(&child_address, 1);
+
+		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+		if (variant->domain_children == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
+		else if (variant->domain_children == SCOPE_SANDBOX)
+			create_unix_domain(_metadata);
+
+		grand_child = fork();
+		ASSERT_LE(0, grand_child);
+		if (grand_child == 0) {
+			char buf1, buf2;
+			int err, client;
+
+			ASSERT_EQ(0, close(pipe_parent[1]));
+			ASSERT_EQ(0, close(pipe_child[1]));
+
+			if (variant->domain_grand_child == OTHER_SANDBOX)
+				create_fs_domain(_metadata);
+			else if (variant->domain_grand_child == SCOPE_SANDBOX)
+				create_unix_domain(_metadata);
+
+			client = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, client);
+
+			ASSERT_EQ(1, read(pipe_child[0], &buf2, 1));
+			err = connect(client, &child_address.unix_addr,
+				      child_address.unix_addr_len);
+			if (can_connect_to_child) {
+				EXPECT_EQ(0, err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(EPERM, errno);
+			}
+
+			if (variant->type == SOCK_STREAM) {
+				EXPECT_EQ(0, close(client));
+				client = socket(AF_UNIX, variant->type, 0);
+				ASSERT_NE(-1, client);
+			}
+			ASSERT_EQ(1, read(pipe_parent[0], &buf1, 1));
+			err = connect(client, &parent_address.unix_addr,
+				      parent_address.unix_addr_len);
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(EPERM, errno);
+			}
+			EXPECT_EQ(0, close(client));
+
+			_exit(_metadata->exit_code);
+			return;
+		}
+		int child_server;
+
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
+		else if (variant->domain_child == SCOPE_SANDBOX)
+			create_unix_domain(_metadata);
+
+		child_server = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, child_server);
+		ASSERT_EQ(0, bind(child_server, &child_address.unix_addr,
+				  child_address.unix_addr_len));
+		if (variant->type == SOCK_STREAM)
+			ASSERT_EQ(0, listen(child_server, backlog));
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
+		ASSERT_EQ(0, close(child_server));
+		return;
+	}
+	int parent_server;
+
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent == OTHER_SANDBOX)
+		create_fs_domain(_metadata);
+	else if (variant->domain_parent == SCOPE_SANDBOX)
+		create_unix_domain(_metadata);
+
+	parent_server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_NE(-1, parent_server);
+	ASSERT_EQ(0, bind(parent_server, &parent_address.unix_addr,
+			  parent_address.unix_addr_len));
+
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(parent_server, backlog));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(0, close(parent_server));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/* clang-format off */
+FIXTURE(outside_socket) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(outside_socket)
+{
+	const bool domain_server;
+	const bool domain_server_socket;
+	const int type;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, allow_dgram_server_sock_domain) {
+	/* clang-format on */
+	.domain_server = false,
+	.domain_server_socket = true,
+	.type = SOCK_DGRAM,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, deny_dgram_server_domain) {
+	/* clang-format on */
+	.domain_server = true,
+	.domain_server_socket = false,
+	.type = SOCK_DGRAM,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, allow_stream_server_sock_domain) {
+	/* clang-format on */
+	.domain_server = false,
+	.domain_server_socket = true,
+	.type = SOCK_STREAM,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, deny_stream_server_domain) {
+	/* clang-format on */
+	.domain_server = true,
+	.domain_server_socket = false,
+	.type = SOCK_STREAM,
+};
+
+FIXTURE_SETUP(outside_socket)
+{
+}
+
+FIXTURE_TEARDOWN(outside_socket)
+{
+}
+
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and
+ * child processes when connecting socket has different domain
+ * than the process using it.
+ **/
+TEST_F(outside_socket, socket_with_different_domain)
+{
+	pid_t child;
+	int err, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+	struct service_fixture address, transit_address;
+
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	memset(&transit_address, 0, sizeof(transit_address));
+	memset(&address, 0, sizeof(address));
+	set_unix_address(&transit_address, 0);
+	set_unix_address(&address, 1);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+		int stream_server, client;
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
+			stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
+
+			ASSERT_NE(-1, stream_server);
+			ASSERT_EQ(0, bind(stream_server,
+					  &transit_address.unix_addr,
+					  transit_address.unix_addr_len));
+			ASSERT_EQ(0, listen(stream_server, backlog));
+
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+			data_socket = accept(stream_server, NULL, NULL);
+
+			ASSERT_EQ(0, send_fd(data_socket, fd_sock));
+			ASSERT_EQ(0, close(fd_sock));
+			ASSERT_EQ(0, close(stream_server));
+		}
+
+		client = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, client);
+		/* wait for parent signal for connection */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		err = connect(client, &address.unix_addr,
+			      address.unix_addr_len);
+		if (!variant->domain_server_socket) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+		}
+		ASSERT_EQ(0, close(client));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	int server_socket;
+
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (!variant->domain_server_socket) {
+		server_socket = socket(AF_UNIX, variant->type, 0);
+	} else {
+		int cli = socket(AF_UNIX, SOCK_STREAM, 0);
+
+		ASSERT_NE(-1, cli);
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		ASSERT_EQ(0, connect(cli, &transit_address.unix_addr,
+				     transit_address.unix_addr_len));
+
+		server_socket = recv_fd(cli);
+		ASSERT_LE(0, server_socket);
+		ASSERT_EQ(0, close(cli));
+	}
+
+	ASSERT_NE(-1, server_socket);
+
+	if (variant->domain_server)
+		create_unix_domain(_metadata);
+
+	ASSERT_EQ(0, bind(server_socket, &address.unix_addr,
+			  address.unix_addr_len));
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(server_socket, backlog));
+	/* signal to child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(0, close(server_socket));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


