Return-Path: <netdev+bounces-115209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200B9456CE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A3C285E44
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4A43ADE;
	Fri,  2 Aug 2024 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gskK9mk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7622626;
	Fri,  2 Aug 2024 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571394; cv=none; b=fYP0L6mAOhmOVlfGXvhf1EREkyuhgqo/+Hhv+bMFi6G7jrCqawlOQtQxVSRkVKOzYrKaadOi0GSDhEvUhvp7et1ZbJ9u/qFR9GkflVRAvax+NQHMcFTuUPrCzEgSOOnYdEhYomrUsm+nI5U6B1gvkzuXTqjchjHduyFpVORFNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571394; c=relaxed/simple;
	bh=a8jsZPOLtqarrXMyKfMHc8/25v/v3voyb69iFnpOiV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nE+t/7EZhuP0QcJ81PjAGMzkolmoqLYRoKXs3hU5gjFvkLxRjRMHlE/dE49TGAjR3l5U0HEgTUalCAOPZpc6+U2d7MGAxohbh4HpJJJy1KQ5yBkvIzwGoiie1Mc5E2D5t4eBT4yqP6jO4dozRaaxlcP0xNdb2rqnQ339M25UB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gskK9mk7; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2689f749649so83729fac.0;
        Thu, 01 Aug 2024 21:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571390; x=1723176190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiq5vvBea/0W6/FD0Gf50/Uwih34vYbv4fUJn5gIxeY=;
        b=gskK9mk7GrseNs8koWA8kZBbTa+xJXpTfL/OoFtCLjuQs8kP93Pf3VDlRHJm0/YT+1
         028m5VerufXnR07zjO5rp+SyEUa1BNmG3bNp9KkM659A9CmociFJrMDAP/u6sAtUM3tg
         xteKhT1FSMAFsMW53gUTd6rG9juHJHEGVZGGSQHwmF37oZGjOmCllMJt8nUGRcVwk+zX
         BsYL2DxwAOBK/StHkmNdYc8nzmGbJCpwRTdhITib2Ipcw+kriB7KBBoCPuS1PK+YBgx8
         MaD0ALAOa/SYNhE1sU0A8yy6RBDik4IM7pEQC9ZDyh8hVW0ryBs4WnqePDF+vNs687gD
         lpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571390; x=1723176190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiq5vvBea/0W6/FD0Gf50/Uwih34vYbv4fUJn5gIxeY=;
        b=fzTLaUki3SAjKv5ccBz7PS8Yun66BGz8KMpTjLbJDuwM7i30dOkDIcJaTi6/b7cvzq
         Os+DnDPfTCXQECV5hQ0lGixXtyy3baYGOHHmFHfV9b9ijXzxROgDQSYQbLDtbHHAuYwV
         2i/j8HjL68BrFAaxjVQfwzYQRNhKtYY6oPxm3UkEfSjOLCtB+ZkO+ol4uvS6ZHn6/w2o
         ei8S+ywy7Ko03PXxSgC9mD/3uDsn0lCA/88Am6uwL9+n+2s9ZGwuT09G+LtQRh6T2OAQ
         jecb+qCCGn2/L9IfdATYJqFPW3XUbpCmByaFxjM2PldHySan5P01/H5gX9bkxmhLVkuR
         S9vg==
X-Forwarded-Encrypted: i=1; AJvYcCV7RD+64wF3NzZxsZCEC4I7qSyGDh27pHexDF3fWUnXTrzFt1DOcE7Dkg8j0rik/dlm57W6oXmJ+ZQjSJEdqWskCDvZTRkdycaDgdbU0o194vikr5SgHhnOfauNSpXE6uMeMZqv76BdCQ7gRtEy4yAM7Y8mVhQvl5e5mJJsYPf3JoK0brtyqwYEhbzH
X-Gm-Message-State: AOJu0YzpWiBk/9rpHQn/cj4nn7Iy1V8VVnTYD+F70Ty04l6Wb9Bll/AT
	fNWbYkTyomY1eHDeV09yWHtzXEqxTPsOGG1QPWrCyejNv32inPt3
X-Google-Smtp-Source: AGHT+IFnPegTXtPGPS8OmCwhkDpNHF8wIYHl1mv9Vnc5H2krNXOcgoe0HhI54WW5IYq4pwq+ibSuNg==
X-Received: by 2002:a05:6870:3c07:b0:260:fdda:5068 with SMTP id 586e51a60fabf-26891ab181cmr2678160fac.4.1722571390054;
        Thu, 01 Aug 2024 21:03:10 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec41465sm542099b3a.60.2024.08.01.21.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:03:09 -0700 (PDT)
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
Subject: [PATCH v8 2/4] selftests/landlock: Abstract unix socket restriction tests
Date: Thu,  1 Aug 2024 22:02:34 -0600
Message-Id: <ea8c8734602145ded23b8ac205b6ba38f1b00e3f.1722570749.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722570749.git.fahimitahera@gmail.com>
References: <cover.1722570749.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch introduces Landlock ABI version 6 and has four types of tests:
1) unix_socket: base tests of the abstract socket scoping mechanism for a
   landlocked process, same as the ptrace test.
2) optional_scoping: generates three processes with different domains and
   tests if a process with a non-scoped domain can connect to other
   processes.
3) unix_sock_special_cases: since the socket's creator credentials are used
   for scoping sockets, this test examines the cases where the socket's
   credentials are different from the process using it.
4) pathname_address_sockets: ensures that Unix sockets bound to a
   null-terminated filesystem can still connect to a socket outside of
   their scoped domain. This means that even if the domain is scoped with
   LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET, the socket can connect to a socket
   outside the scoped domain.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
Changes in versions:
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
 tools/testing/selftests/landlock/base_test.c  |    2 +-
 tools/testing/selftests/landlock/common.h     |   72 ++
 tools/testing/selftests/landlock/fs_test.c    |   34 -
 tools/testing/selftests/landlock/net_test.c   |   31 +-
 .../landlock/scoped_abstract_unix_test.c      | 1136 +++++++++++++++++
 5 files changed, 1210 insertions(+), 65 deletions(-)
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
index 7e2b431b9f90..a0c8126d94b4 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -16,8 +16,11 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/un.h>
+#include <arpa/inet.h>
 
 #include "../kselftest_harness.h"
+#define TMP_DIR "tmp"
 
 #ifndef __maybe_unused
 #define __maybe_unused __attribute__((__unused__))
@@ -226,3 +229,72 @@ enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
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
+
+static int __maybe_unused remove_path(const char *const path)
+{
+	char *walker;
+	int i, ret, err = 0;
+
+	walker = strdup(path);
+	if (!walker) {
+		err = ENOMEM;
+		goto out;
+	}
+	if (unlink(path) && rmdir(path)) {
+		if (errno != ENOENT && errno != ENOTDIR)
+			err = errno;
+		goto out;
+	}
+	for (i = strlen(walker); i > 0; i--) {
+		if (walker[i] != '/')
+			continue;
+		walker[i] = '\0';
+		ret = rmdir(walker);
+		if (ret) {
+			if (errno != ENOTEMPTY && errno != EBUSY)
+				err = errno;
+			goto out;
+		}
+		if (strcmp(walker, TMP_DIR) == 0)
+			goto out;
+	}
+
+out:
+	free(walker);
+	return err;
+}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 7d063c652be1..fc74cab6dfb8 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -221,40 +221,6 @@ static void create_file(struct __test_metadata *const _metadata,
 	}
 }
 
-static int remove_path(const char *const path)
-{
-	char *walker;
-	int i, ret, err = 0;
-
-	walker = strdup(path);
-	if (!walker) {
-		err = ENOMEM;
-		goto out;
-	}
-	if (unlink(path) && rmdir(path)) {
-		if (errno != ENOENT && errno != ENOTDIR)
-			err = errno;
-		goto out;
-	}
-	for (i = strlen(walker); i > 0; i--) {
-		if (walker[i] != '/')
-			continue;
-		walker[i] = '\0';
-		ret = rmdir(walker);
-		if (ret) {
-			if (errno != ENOTEMPTY && errno != EBUSY)
-				err = errno;
-			goto out;
-		}
-		if (strcmp(walker, TMP_DIR) == 0)
-			goto out;
-	}
-
-out:
-	free(walker);
-	return err;
-}
-
 struct mnt_opt {
 	const char *const source;
 	const char *const type;
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
index 000000000000..ffa1f01dbbce
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -0,0 +1,1136 @@
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
+#include <signal.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stddef.h>
+#include <sys/stat.h>
+#include <sched.h>
+
+#include "common.h"
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
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and child,
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
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent, child
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
+			ASSERT_EQ(0, listen(self->child_server, 32));
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
+			ASSERT_EQ(0, listen(self->stream_server, 32));
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
+
+static const char path1_variant1[] = TMP_DIR "/s1_variant1";
+static const char path2_variant1[] = TMP_DIR "/s2_variant1";
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
+	const char *stream_path;
+	const char *dgram_path;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(pathname_address_sockets, pathname_socket_scoped_domain) {
+	/* clang-format on */
+	.domain = SCOPE_SANDBOX,
+	.stream_path = path1_variant1,
+	.dgram_path = path2_variant1,
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
+	const char *s_path = variant->stream_path;
+	const char *dg_path = variant->dgram_path;
+
+	disable_caps(_metadata);
+	umask(0077);
+	ASSERT_EQ(0, mkdir(TMP_DIR, 0700));
+
+	ASSERT_EQ(0, mknod(s_path, S_IFREG | 0700, 0))
+	{
+		TH_LOG("Failed to create file \"%s\": %s", s_path,
+		       strerror(errno));
+		remove_path(TMP_DIR);
+	}
+	ASSERT_EQ(0, mknod(dg_path, S_IFREG | 0700, 0))
+	{
+		TH_LOG("Failed to create file \"%s\": %s", dg_path,
+		       strerror(errno));
+		remove_path(TMP_DIR);
+	}
+}
+
+FIXTURE_TEARDOWN(pathname_address_sockets)
+{
+	const char *s_path = variant->stream_path;
+	const char *dg_path = variant->dgram_path;
+
+	ASSERT_EQ(0, remove_path(dg_path));
+	ASSERT_EQ(0, remove_path(s_path));
+	ASSERT_EQ(0, remove_path(TMP_DIR));
+}
+
+TEST_F(pathname_address_sockets, scoped_pathname_sockets)
+{
+	const char *const stream_path = variant->stream_path;
+	const char *const dgram_path = variant->dgram_path;
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
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		struct sockaddr_un cli_un, cli_un_dg;
+		int cli_fd, cli_fd_dg;
+		socklen_t size, size_dg;
+		int sample = socket(AF_UNIX, SOCK_STREAM, 0);
+		int err, err_dg;
+
+		ASSERT_LE(0, sample);
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+
+		/* scope the domain */
+		if (variant->domain == SCOPE_SANDBOX)
+			create_unix_domain(_metadata);
+		else if (variant->domain == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
+		ASSERT_EQ(0, close(socket_fds_stream[1]));
+		ASSERT_EQ(0, send_fd(socket_fds_stream[0], sample));
+		ASSERT_EQ(0, close(sample));
+		ASSERT_EQ(0, close(socket_fds_stream[0]));
+
+		/* wait for server to listen */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		cli_un.sun_family = AF_UNIX;
+		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, cli_fd);
+
+		size = offsetof(struct sockaddr_un, sun_path) +
+		       strlen(cli_un.sun_path);
+		ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
+
+		bzero(&cli_un, sizeof(cli_un));
+		cli_un.sun_family = AF_UNIX;
+		snprintf(cli_un.sun_path, sizeof(cli_un.sun_path), "%s",
+			 stream_path);
+		size = offsetof(struct sockaddr_un, sun_path) +
+		       strlen(cli_un.sun_path);
+
+		ASSERT_EQ(0, connect(cli_fd, (struct sockaddr *)&cli_un, size));
+
+		ASSERT_EQ(0, close(cli_fd));
+
+		cli_un_dg.sun_family = AF_UNIX;
+		cli_fd_dg = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_LE(0, cli_fd_dg);
+
+		size_dg = offsetof(struct sockaddr_un, sun_path) +
+			  strlen(cli_un_dg.sun_path);
+		ASSERT_EQ(0, bind(cli_fd_dg, (struct sockaddr *)&cli_un_dg,
+				  size_dg));
+
+		bzero(&cli_un_dg, sizeof(cli_un_dg));
+		cli_un_dg.sun_family = AF_UNIX;
+		snprintf(cli_un_dg.sun_path, sizeof(cli_un_dg.sun_path), "%s",
+			 dgram_path);
+		size_dg = offsetof(struct sockaddr_un, sun_path) +
+			  strlen(cli_un_dg.sun_path);
+
+		ASSERT_EQ(0, connect(cli_fd_dg, (struct sockaddr *)&cli_un_dg,
+				     size_dg));
+
+		ASSERT_EQ(0, close(cli_fd_dg));
+
+		/* check connection with abstract sockets */
+
+		client = socket(AF_UNIX, SOCK_STREAM, 0);
+		dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+		ASSERT_NE(-1, client);
+		ASSERT_NE(-1, dgram_client);
+
+		err = connect(client, &(self->stream_address).unix_addr,
+			      (self->stream_address).unix_addr_len);
+		err_dg = connect(dgram_client, &(self->dgram_address).unix_addr,
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
+	srv_un.sun_family = AF_UNIX;
+	snprintf(srv_un.sun_path, sizeof(srv_un.sun_path), "%s", stream_path);
+
+	ASSERT_EQ(0, unlink(stream_path));
+	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, srv_fd);
+
+	size = offsetof(struct sockaddr_un, sun_path) + strlen(srv_un.sun_path);
+	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, size));
+	ASSERT_EQ(0, listen(srv_fd, 10));
+
+	/* set up a datagram server */
+	srv_un_dg.sun_family = AF_UNIX;
+	snprintf(srv_un_dg.sun_path, sizeof(srv_un_dg.sun_path), "%s",
+		 dgram_path);
+
+	ASSERT_EQ(0, unlink(dgram_path));
+	srv_fd_dg = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_LE(0, srv_fd_dg);
+
+	size_dg = offsetof(struct sockaddr_un, sun_path) +
+		  strlen(srv_un_dg.sun_path);
+	ASSERT_EQ(0, bind(srv_fd_dg, (struct sockaddr *)&srv_un_dg, size_dg));
+
+	/*set up abstract servers */
+
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, server);
+	ASSERT_NE(-1, dgram_server);
+
+	ASSERT_EQ(0, bind(server, &(self->stream_address).unix_addr,
+			  self->stream_address.unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_server, &(self->dgram_address).unix_addr,
+			  self->dgram_address.unix_addr_len));
+	ASSERT_EQ(0, listen(server, 32));
+
+	/* signal to child! */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
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
+TEST_HARNESS_MAIN
-- 
2.34.1


