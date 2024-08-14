Return-Path: <netdev+bounces-118330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C081B95146F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1628276C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B713B5AD;
	Wed, 14 Aug 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nym29ZBj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513461369B1;
	Wed, 14 Aug 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616583; cv=none; b=ZVAQznJqeKbOPGxpDXw9RPW2UPST3DjpFozDSilb8QwzvijEr/DIF+UMF51XL6iHGeno4jokbLKJNafprbIIdigKKivxrieT8gACSF/YHq7EpNgf7zhTxTrhm6MRwkQzYbfiztL1EPV9FAG5Tf4MijqgJwCDJxjRN//y0UbJXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616583; c=relaxed/simple;
	bh=89DkFMuOX5VKVTEv5xBTwDv+Q9EKCFnT5yQx+erqeHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqlmVNym0R9fE3Gbo3Srbdx39Wo74TwR9odkdG6Rv/ijGPwBnXBlT/kFpVYGi4uQkqNdTSCXbAOcRfEpy43IUD+N2+aJHGNy+XnQGjPCkYl8YbhTq48N3lycrhqj64o/mrMwS2qT3I5X11VbYCtw60qh1lko9BvGPc3Sli9ZumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nym29ZBj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d394313aceso1380651a91.3;
        Tue, 13 Aug 2024 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723616581; x=1724221381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czxjQqhaBsrqgxFsUs5VmZVf7YjX+H8MqWJfBggDvU8=;
        b=Nym29ZBjnReuMiQxN1YsiD+vA9Hjp8xBdbxzKJHJe27JyLXQCPh+seK5BjR+BAGn1C
         6FxdRhyB7adfMdoXHir67v3yUs/UQOR7dUlZ93WbMbfQvrNrDj7vkFHSgHDmKET+psYC
         mFDgoVUZ3a76NDtpzGrhF0U+TmOn+a3ym9T5ghlfHJHW93FdnF1xaGI2wwa7OQMFCSJ6
         B90znQ8fpuGOdT1SN5VegBks/j6W2tVz6yM7w+HN9v2WeDE8Wz5UKMJ/1bgOUUHyb/n6
         iqwf9PsCsgEgKmYZpTi6u1W8IICGaTf60fmtEcCQp0In2QdeSyxeDBUfBi42kcmHLmzJ
         Wwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723616581; x=1724221381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czxjQqhaBsrqgxFsUs5VmZVf7YjX+H8MqWJfBggDvU8=;
        b=oSOM7vP2CsZM/e+NfRwLbXG7TfST9Kl6+l6SNtGrAKDYQKr+NetKnoL35CvZNklqx+
         PDT+7fZbx5/affTt+qyL7ySm0ZVg+yao3CltLN/nOMsvWZHw/2sESzMI0IvFzDBNFltM
         oqXi6l60Ty9uosVdOvfjMO+PMSsG3TCpGdz/lBGCqipB1Az1Crd420dtlbAZ1sq6m01/
         zKf7R3Ofzb5DqsPt3rW/sogDVk8g7r1eqZ18H8v8HFAgDxOiG1Hdodsc0xmlZkQTYEag
         BE9S156tdA7mb8WT7R49vxeiC1SLqH/yF6jGMp4iMr1G9zXkwcYYSZHE/kXdBGrLhlM7
         Mf6g==
X-Forwarded-Encrypted: i=1; AJvYcCX5lncCSu9zVqloLhHp9ol7NAoriSHfstNg94b2qF6wKWviExuql1ddMY5DY77WL7ygPEZ5PkOwzOyFtTo0800x0P7jShlHyj6xd5VOuI0c3uG8YIoGB+BCYePZhFZCAU8Ianjm8eqwM4o8j3nUq0VFuwq9Ynkf/PY+fCLxdVSpcqZdojt3jvBf9/FO
X-Gm-Message-State: AOJu0YzR+6YOOqYCgO9sP5tWk3FgNKf4L88gFthLD76TzyN+IKqL1+8o
	/pqfTQnQilnRxyXTbcaKxGlxPn7T1/aARHqFX4xFi3tjnqR+xXW2
X-Google-Smtp-Source: AGHT+IGxrGiKC5iLzwOHg3WQZs/7RokoAxkkaqTtYZwRF7YAqlrYcMpW7adUXCg12TMGtDCbTrx7ZA==
X-Received: by 2002:a17:90b:17c2:b0:2ca:5a46:cbc8 with SMTP id 98e67ed59e1d1-2d3aab50abdmr2081648a91.26.1723616580290;
        Tue, 13 Aug 2024 23:23:00 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2120sm728811a91.31.2024.08.13.23.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:22:59 -0700 (PDT)
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
Subject: [PATCH v9 2/5] selftests/Landlock: Abstract unix socket restriction tests
Date: Wed, 14 Aug 2024 00:22:20 -0600
Message-Id: <2fb401d2ee04b56c693bba3ebac469f2a6785950.1723615689.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723615689.git.fahimitahera@gmail.com>
References: <cover.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch introduces Landlock ABI version 6 and has three types of tests
that examines different scenarios for abstract unix socket connection:
1) unix_socket: base tests of the abstract socket scoping mechanism for a
   landlocked process, same as the ptrace test.
2) optional_scoping: generates three processes with different domains and
   tests if a process with a non-scoped domain can connect to other
   processes.
3) unix_sock_special_cases: since the socket's creator credentials are used
   for scoping sockets, this test examines the cases where the socket's
   credentials are different from the process using it.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
Changes in versions:
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
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/common.h     |  38 +
 tools/testing/selftests/landlock/net_test.c   |  31 +-
 .../landlock/scoped_abstract_unix_test.c      | 942 ++++++++++++++++++
 4 files changed, 982 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c

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
index 000000000000..232c3b767b8a
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -0,0 +1,942 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Abstract Unix Socket
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
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
+FIXTURE(unix_socket)
+{
+	struct service_fixture stream_address, dgram_address;
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
+FIXTURE_SETUP(unix_socket)
+{
+	memset(&self->stream_address, 0, sizeof(self->stream_address));
+	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
+
+	set_unix_address(&self->stream_address, 0);
+	set_unix_address(&self->dgram_address, 1);
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
+ * Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and child,
+ * when they have scoped domain or no domain.
+ */
+TEST_F(unix_socket, abstract_unix_socket)
+{
+	int status;
+	pid_t child;
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
+			err = connect(self->client,
+				      &self->stream_address.unix_addr,
+				      (self->stream_address).unix_addr_len);
+			err_dgram =
+				connect(self->dgram_client,
+					&self->dgram_address.unix_addr,
+					(self->dgram_address).unix_addr_len);
+
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
+			ASSERT_EQ(0,
+				  bind(self->server,
+				       &self->stream_address.unix_addr,
+				       (self->stream_address).unix_addr_len));
+			ASSERT_EQ(0, bind(self->dgram_server,
+					  &self->dgram_address.unix_addr,
+					  (self->dgram_address).unix_addr_len));
+			ASSERT_EQ(0, listen(self->server, backlog));
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
+		err = connect(self->client, &self->stream_address.unix_addr,
+			      (self->stream_address).unix_addr_len);
+		err_dgram = connect(self->dgram_client,
+				    &self->dgram_address.unix_addr,
+				    (self->dgram_address).unix_addr_len);
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
+		ASSERT_EQ(0, bind(self->server, &self->stream_address.unix_addr,
+				  (self->stream_address).unix_addr_len));
+		ASSERT_EQ(0, bind(self->dgram_server,
+				  &self->dgram_address.unix_addr,
+				  (self->dgram_address).unix_addr_len));
+		ASSERT_EQ(0, listen(self->server, backlog));
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
+	struct service_fixture parent_address, child_address;
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
+FIXTURE_SETUP(optional_scoping)
+{
+	memset(&self->parent_address, 0, sizeof(self->parent_address));
+	memset(&self->child_address, 0, sizeof(self->child_address));
+
+	set_unix_address(&self->parent_address, 0);
+	set_unix_address(&self->child_address, 1);
+}
+
+FIXTURE_TEARDOWN(optional_scoping)
+{
+	close(self->parent_server);
+	close(self->child_server);
+	close(self->client);
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
+        .domain_all = SCOPE_SANDBOX,
+        .domain_parent = NO_SANDBOX,
+        .domain_children = SCOPE_SANDBOX,
+        .domain_child = NO_SANDBOX,
+        .domain_grand_child = NO_SANDBOX,
+        .type = SOCK_DGRAM,
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
+        .domain_all = NO_SANDBOX,
+        .domain_parent = SCOPE_SANDBOX,
+        .domain_children = NO_SANDBOX,
+        .domain_child = NO_SANDBOX,
+        .domain_grand_child = SCOPE_SANDBOX,
+        .type = SOCK_STREAM,
+	/* clang-format on */
+};
+
+/* 
+ * Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent, child
+ * and grand child processes when they can have scoped or non-scoped
+ * domains.
+ **/
+TEST_F(optional_scoping, unix_scoping)
+{
+	pid_t child;
+	int status;
+	bool can_connect_to_parent, can_connect_to_child;
+	int pipe_parent[2];
+
+	can_connect_to_child =
+		(variant->domain_grand_child == SCOPE_SANDBOX) ? false : true;
+
+	can_connect_to_parent = (!can_connect_to_child ||
+				 variant->domain_children == SCOPE_SANDBOX) ?
+					false :
+					true;
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
+
+		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+		pid_t grand_child;
+
+		if (variant->domain_children == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
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
+				create_fs_domain(_metadata);
+			else if (variant->domain_grand_child == SCOPE_SANDBOX)
+				create_unix_domain(_metadata);
+
+			self->client = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, self->client);
+
+			ASSERT_EQ(1, read(pipe_child[0], &buf2, 1));
+			err = connect(self->client,
+				      &self->child_address.unix_addr,
+				      (self->child_address).unix_addr_len);
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
+			err = connect(self->client,
+				      &self->parent_address.unix_addr,
+				      (self->parent_address).unix_addr_len);
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
+			create_fs_domain(_metadata);
+		else if (variant->domain_child == SCOPE_SANDBOX)
+			create_unix_domain(_metadata);
+
+		self->child_server = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, self->child_server);
+		ASSERT_EQ(0, bind(self->child_server,
+				  &self->child_address.unix_addr,
+				  (self->child_address).unix_addr_len));
+		if (variant->type == SOCK_STREAM)
+			ASSERT_EQ(0, listen(self->child_server, backlog));
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent == OTHER_SANDBOX)
+		create_fs_domain(_metadata);
+	else if (variant->domain_parent == SCOPE_SANDBOX)
+		create_unix_domain(_metadata);
+
+	self->parent_server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_NE(-1, self->parent_server);
+	ASSERT_EQ(0, bind(self->parent_server, &self->parent_address.unix_addr,
+			  (self->parent_address).unix_addr_len));
+
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(self->parent_server, backlog));
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
+	struct service_fixture address, transit_address;
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
+	/* clang-format on */
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
+	/* clang-format on */
+	.domain_server = true,
+	.domain_server_socket = false,
+	.type = SOCK_STREAM,
+};
+
+FIXTURE_SETUP(unix_sock_special_cases)
+{
+	memset(&self->transit_address, 0, sizeof(self->transit_address));
+	memset(&self->address, 0, sizeof(self->address));
+	set_unix_address(&self->transit_address, 0);
+	set_unix_address(&self->address, 1);
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
+TEST_F(unix_sock_special_cases, socket_with_different_domain)
+{
+	pid_t child;
+	int err, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
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
+			ASSERT_EQ(0,
+				  bind(self->stream_server,
+				       &self->transit_address.unix_addr,
+				       (self->transit_address).unix_addr_len));
+			ASSERT_EQ(0, listen(self->stream_server, backlog));
+
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+			data_socket = accept(self->stream_server, NULL, NULL);
+
+			ASSERT_EQ(0, send_fd(data_socket, fd_sock));
+			ASSERT_EQ(0, close(fd_sock));
+		}
+
+		self->client = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, self->client);
+		/* wait for parent signal for connection */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		err = connect(self->client, &self->address.unix_addr,
+			      (self->address).unix_addr_len);
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
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		ASSERT_EQ(0, connect(cli, &self->transit_address.unix_addr,
+				     (self->transit_address).unix_addr_len));
+
+		self->server_socket = recv_fd(cli);
+		ASSERT_LE(0, self->server_socket);
+		ASSERT_EQ(0, close(cli));
+	}
+
+	ASSERT_NE(-1, self->server_socket);
+
+	if (variant->domain_server)
+		create_unix_domain(_metadata);
+
+	ASSERT_EQ(0, bind(self->server_socket, &self->address.unix_addr,
+			  (self->address).unix_addr_len));
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(self->server_socket, backlog));
+	/* signal to child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+TEST_HARNESS_MAIN
-- 
2.34.1


