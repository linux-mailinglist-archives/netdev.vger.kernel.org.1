Return-Path: <netdev+bounces-125314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C396CB9E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572AE1F270E1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6E2564;
	Thu,  5 Sep 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JivoCiDG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BBCA937;
	Thu,  5 Sep 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495268; cv=none; b=RlK+GF6GB/Axi/Kro3Dg203AX0e1q+RkAnQmmKiiZaVkjRxj65r6RdUULge6mx1srzQhW9+VJwcnR0U10pqUYocVwg9vXsGKe6ZQIxPT0iVoLdRC/6Rd8t5S605Ns3X9fU13x4LaBE6aUdzvgrOgV20MVOv/gCN04bG2eL73rK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495268; c=relaxed/simple;
	bh=mX/XFwG5C0TWxDzQzjcUkx4xXAoOllG0ZWKYJVoEexw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awuKIn8Ll22rBLB3KND5EB0sqHEXGKGccf+yJp/KCT0dL5ZjTbIF6y961BK2Yxck9CfwwD01Z1vfUuTmw6Dvh4cPLrZeXjDfDIMIbPPRweUXeZ9ySUihdoroMP4ASd7+AK8pDLVAvmv7TqFZr7DJgGW4ss6wMQOf99j5gcJ8Hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JivoCiDG; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-277e6002b7dso159557fac.1;
        Wed, 04 Sep 2024 17:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725495265; x=1726100065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BI6zKDtG2HG0fCmXFOHBI+rStZOJcwEmwBnfw9wUHQ=;
        b=JivoCiDG9bpI5Vz+uFAsNHfg5Hw4rE5q7TlHcVftyMmwUefutTQgfGiRiHDFZaQznI
         KDe2JMZOJBRtV77nZgfHGzgkhcG4yVWyd6eORsjAAwxGL5gMu/T1X511KxNPU1Z+ZTwD
         HywGw6fvd1xTdh78ErABkfzcsLaeCuI1W6zkjwk25bmNoKoV/MVcFAW3W2UKUyZMTi2A
         bHyvUBxNXz6zJaPxOjEx2RkiUdzEZSXJ4Iu/jQIECF0PZaBQmQ5UqpzI8Hi3ntirfRIn
         jZuzvQ3c2ntu0RPJisXIZeG+esfMWX03pkowCWEoFp6V7YQ/mswxy08IFgfBF1X2CMQ/
         J0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725495265; x=1726100065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BI6zKDtG2HG0fCmXFOHBI+rStZOJcwEmwBnfw9wUHQ=;
        b=k0BttL4A12p458qUdE/hm3H/M7e0/9SSLySAHNobC2arfxY6XRGChcbPug8PjDNNo1
         xcURoFJpiD9X886CaycszKcigclH9Pw3XzxOGpi6hkqNK9RJZOTbQFszLoNYOTrgLDTe
         XiOtBwJct0r8WtkJznIgCKZ1VSavN/vL7Huux2XbC8WcEAXPxpCSf9gGrZhw4SWOssh7
         H+diB8ShKhGRRLLBmE2M5QuqBo12cJ/2pkCyKoPFmgLf0RBcC2FTrS7NSCKpOn6uRygo
         y24F3C1y8M992e/sRiYpTHaz6CF0GQtpcIOrWxo0c65MSnzm6418QibgmPbZh1+3Rvzy
         G9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVasPa24fFqLJW7lxF1kRY/2jbMFj5pMXWwry+9e1zbK8ntU3TaNgDChExDtUuqeYL35VmxqwlV@vger.kernel.org, AJvYcCWIUJHZpENVA3+NdTTgfYLpl/bp/H3OqUcrOV2TMGk+jJVs7s3hPVlsbG62bhVfGxxWZvtBHutsIUfuSuo=@vger.kernel.org, AJvYcCXyRc6uM2zmrOgip3uAX7SFzQSIfUvPRMRebbbnGiChh+yB9GQIE3hFiOGH8H29LeDAuhhuziVTjLsYrUa632uwpj9esT3G@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+idqkBkJisRrlX/QE8GL7gZTxosiJue7/ajTP35NozXg5lW2B
	OQ6lAvJcP96LbbfjYx2NZGVsGiCCm3qDE9hYc9B6qq1upWGOPspB
X-Google-Smtp-Source: AGHT+IGRPHDFPaOyrRiWUwZOdFRWwBx7Zh9NjqmLP05p400wI5Lohx/pu+ufexDnKiFQGtV4iDhQQQ==
X-Received: by 2002:a05:6871:4910:b0:277:d17b:50b4 with SMTP id 586e51a60fabf-277d17be466mr11597577fac.5.1725495264414;
        Wed, 04 Sep 2024 17:14:24 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778534921sm2159781b3a.76.2024.09.04.17.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 17:14:23 -0700 (PDT)
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
Subject: [PATCH v11 3/8] selftests/landlock: Add abstract UNIX socket restriction tests
Date: Wed,  4 Sep 2024 18:13:57 -0600
Message-Id: <9321c3d3bcd9212ceb4b50693e29349f8d625e16.1725494372.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725494372.git.fahimitahera@gmail.com>
References: <cover.1725494372.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch introduces Landlock ABI version 6 and adds three tests that
examines different scenarios for abstract UNIX socket:
1) unix_socket: base tests of the abstract socket scoping mechanism for
a landlocked process, same as the ptrace test.
2) scoped_vs_unscoped_sockets: generates three processes with different
   domains and tests if a process with a non-scoped domain can connect
   to other processes.
3) outside_socket: since the socket's creator credentials are used
   for scoping sockets, this test examines the cases where the socket's
   credentials are different from the process using it.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
Changes in versions:
v11:
- Adding a generalized domain creation function, "create_scoped_domain",
  for different types of scoped domains in "scoped_common.h" file.
- Rename "unix_socket" to "scoped_domain" and moving its variants to
  "scoped_base_variants.h" file (for future use in other IPC tests).
- Minor code improvement, and renaming variables.
- Rename "optional_scoping" to "scoped_vs_unscoped_sockets", and add
  support for datagram and stream sockets. Moving its variants to
  "scoped_multiple_domain_variants.h" file.
v10:
- Code improvements by changing fixture variables to local ones.
- Rename "unix_sock_special_cases" to "outside_socket"
v9:
- Move pathname_address_sockets to a different patch.
- Extend optional_scoping test scenarios.
- Removing hardcoded numbers and using "backlog" instead.
V8:
- Move tests to scoped_abstract_unix_test.c file.
- To avoid potential conflicts among Unix socket names in different
  tests, set_unix_address is added to common.h to set different sun_path
  for Unix sockets.
- protocol_variant and service_fixture structures are also moved to
  common.h
- Adding pathname_address_sockets to cover all types of address formats
  for unix sockets, and moving remove_path() to common.h to reuse in
  this test.
V7:
- Introducing landlock ABI version 6.
- Adding some edge test cases to optional_scoping test.
- Using `enum` for different domains in optional_scoping tests.
- Extend unix_sock_special_cases test cases for connected(SOCK_STREAM)
  sockets.
- Modifying inline comments.
V6:
- Introducing optional_scoping test which ensures a sandboxed process
  with a non-scoped domain can still connect to another abstract unix
  socket(either sandboxed or non-sandboxed).
- Introducing unix_sock_special_cases test which tests examines
  scenarios where the connecting sockets have different domain than the
  process using them.
V4:
- Introducing unix_socket to evaluate the basic scoping mechanism for
  abstract unix sockets.
---
 tools/testing/selftests/landlock/common.h     |  38 ++
 tools/testing/selftests/landlock/net_test.c   |  31 +-
 .../landlock/scoped_abstract_unix_test.c      | 620 ++++++++++++++++++
 .../selftests/landlock/scoped_base_variants.h | 154 +++++
 .../selftests/landlock/scoped_common.h        |  28 +
 .../scoped_multiple_domain_variants.h         | 154 +++++
 6 files changed, 995 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
 create mode 100644 tools/testing/selftests/landlock/scoped_base_variants.h
 create mode 100644 tools/testing/selftests/landlock/scoped_common.h
 create mode 100644 tools/testing/selftests/landlock/scoped_multiple_domain_variants.h

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
index 000000000000..00ea5151979f
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -0,0 +1,620 @@
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
+#include "scoped_common.h"
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
+/* clang-format off */
+FIXTURE(scoped_domains)
+{
+	struct service_fixture stream_address, dgram_address;
+};
+
+#include "scoped_base_variants.h"
+
+/* clang-format on */
+FIXTURE_SETUP(scoped_domains)
+{
+	memset(&self->stream_address, 0, sizeof(self->stream_address));
+	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
+	set_unix_address(&self->stream_address, 0);
+	set_unix_address(&self->dgram_address, 1);
+}
+
+FIXTURE_TEARDOWN(scoped_domains)
+{
+}
+
+/*
+ * Test unix_stream_connect() and unix_may_send() for a child connecting to its parent,
+ * when they have scoped domain or no domain.
+ */
+TEST_F(scoped_domains, connect_to_parent)
+{
+	pid_t child;
+	bool can_connect_to_parent;
+	int err, err_dgram, status;
+	int pipe_parent[2];
+	int stream_socket, dgram_socket;
+
+	drop_caps(_metadata);
+	/*
+	 * can_connect_to_parent is true if a child process can connect to its
+	 * parent process. This depends on the child process is not isolated from
+	 * the parent with a dedicated Landlock domain.
+	 */
+	can_connect_to_parent = !variant->domain_child;
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	if (variant->domain_both) {
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
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
+		if (variant->domain_child)
+			create_scoped_domain(
+				_metadata,
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+		stream_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		dgram_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+		ASSERT_NE(-1, stream_socket);
+		ASSERT_NE(-1, dgram_socket);
+
+		/* wait for the server */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		err = connect(stream_socket, &self->stream_address.unix_addr,
+			      (self->stream_address).unix_addr_len);
+		err_dgram = connect(dgram_socket,
+				    &self->dgram_address.unix_addr,
+				    (self->dgram_address).unix_addr_len);
+		if (can_connect_to_parent) {
+			EXPECT_EQ(0, err);
+			EXPECT_EQ(0, err_dgram);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(-1, err_dgram);
+			EXPECT_EQ(EPERM, errno);
+		}
+		ASSERT_EQ(0, close(stream_socket));
+		ASSERT_EQ(0, close(dgram_socket));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+	stream_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+	dgram_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, stream_socket);
+	ASSERT_NE(-1, dgram_socket);
+	ASSERT_EQ(0, bind(stream_socket, &self->stream_address.unix_addr,
+			  (self->stream_address).unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_socket, &self->dgram_address.unix_addr,
+			  (self->dgram_address).unix_addr_len));
+	ASSERT_EQ(0, listen(stream_socket, backlog));
+
+	/* signal to child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(0, close(stream_socket));
+	ASSERT_EQ(0, close(dgram_socket));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * Test unix_stream_connect() and unix_may_send() for a parent connecting to its child,
+ * when they have scoped domain or no domain.
+ */
+TEST_F(scoped_domains, connect_to_child)
+{
+	pid_t child;
+	bool can_connect_to_child;
+	int err, err_dgram, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf;
+	int stream_socket, dgram_socket;
+
+	drop_caps(_metadata);
+	/*
+	 * can_connect_to_child is true if a parent process can connect to its
+	 * child process. The parent process is not isolated from the child
+	 * with a dedicated Landlock domain.
+	 */
+	can_connect_to_child = !variant->domain_parent;
+
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	if (variant->domain_both) {
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+		if (!__test_passed(_metadata))
+			return;
+	}
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child)
+			create_scoped_domain(
+				_metadata,
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		stream_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		dgram_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, stream_socket);
+		ASSERT_NE(-1, dgram_socket);
+		ASSERT_EQ(0,
+			  bind(stream_socket, &self->stream_address.unix_addr,
+			       (self->stream_address).unix_addr_len));
+		ASSERT_EQ(0, bind(dgram_socket, &self->dgram_address.unix_addr,
+				  (self->dgram_address).unix_addr_len));
+		ASSERT_EQ(0, listen(stream_socket, backlog));
+		/* signal to parent that child is listening */
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		/* wait to connect */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+		ASSERT_EQ(0, close(stream_socket));
+		ASSERT_EQ(0, close(dgram_socket));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	stream_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+	dgram_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, stream_socket);
+	ASSERT_NE(-1, dgram_socket);
+
+	/* Waits for the child to listen */
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+	err = connect(stream_socket, &self->stream_address.unix_addr,
+		      (self->stream_address).unix_addr_len);
+	err_dgram = connect(dgram_socket, &self->dgram_address.unix_addr,
+			    (self->dgram_address).unix_addr_len);
+	if (can_connect_to_child) {
+		EXPECT_EQ(0, err);
+		EXPECT_EQ(0, err_dgram);
+	} else {
+		EXPECT_EQ(-1, err);
+		EXPECT_EQ(-1, err_dgram);
+		EXPECT_EQ(EPERM, errno);
+	}
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(0, close(stream_socket));
+	ASSERT_EQ(0, close(dgram_socket));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/* clang-format off */
+FIXTURE(scoped_vs_unscoped_sockets)
+{
+	struct service_fixture parent_stream_address, parent_dgram_address,
+			       child_stream_address, child_dgram_address;
+};
+
+#include "scoped_multiple_domain_variants.h"
+/* clang-format on */
+
+FIXTURE_SETUP(scoped_vs_unscoped_sockets)
+{
+	memset(&self->parent_stream_address, 0,
+	       sizeof(self->parent_stream_address));
+	set_unix_address(&self->parent_stream_address, 0);
+	memset(&self->parent_dgram_address, 0,
+	       sizeof(self->parent_dgram_address));
+	set_unix_address(&self->parent_dgram_address, 1);
+	memset(&self->child_stream_address, 0,
+	       sizeof(self->child_stream_address));
+	set_unix_address(&self->child_stream_address, 2);
+	memset(&self->child_dgram_address, 0,
+	       sizeof(self->child_dgram_address));
+	set_unix_address(&self->child_dgram_address, 3);
+}
+
+FIXTURE_TEARDOWN(scoped_vs_unscoped_sockets)
+{
+}
+
+/*
+ * Test unix_stream_connect and unix_may_send for parent, child and
+ * grand child processes when they can have scoped or non-scoped domains.
+ */
+TEST_F(scoped_vs_unscoped_sockets, unix_scoping)
+{
+	pid_t child;
+	int status;
+	bool can_connect_to_parent, can_connect_to_child;
+	int pipe_parent[2];
+	int stream_server, dgram_server;
+
+	drop_caps(_metadata);
+	can_connect_to_child = (variant->domain_grand_child != SCOPE_SANDBOX);
+	can_connect_to_parent = (can_connect_to_child &&
+				 (variant->domain_children != SCOPE_SANDBOX));
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	if (variant->domain_all == OTHER_SANDBOX)
+		create_fs_domain(_metadata);
+	else if (variant->domain_all == SCOPE_SANDBOX)
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int pipe_child[2];
+		pid_t grand_child;
+
+		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+		if (variant->domain_children == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
+		else if (variant->domain_children == SCOPE_SANDBOX)
+			create_scoped_domain(
+				_metadata,
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+		grand_child = fork();
+		ASSERT_LE(0, grand_child);
+		if (grand_child == 0) {
+			char buf;
+			int err, dgram_err;
+			int stream_client, dgram_client;
+
+			ASSERT_EQ(0, close(pipe_parent[1]));
+			ASSERT_EQ(0, close(pipe_child[1]));
+
+			if (variant->domain_grand_child == OTHER_SANDBOX)
+				create_fs_domain(_metadata);
+			else if (variant->domain_grand_child == SCOPE_SANDBOX)
+				create_scoped_domain(
+					_metadata,
+					LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+			stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
+			ASSERT_NE(-1, stream_client);
+			dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+			ASSERT_NE(-1, dgram_client);
+
+			ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+			err = connect(stream_client,
+				      &self->child_stream_address.unix_addr,
+				      self->child_stream_address.unix_addr_len);
+			dgram_err = connect(
+				dgram_client,
+				&self->child_dgram_address.unix_addr,
+				self->child_dgram_address.unix_addr_len);
+			if (can_connect_to_child) {
+				EXPECT_EQ(0, err);
+				EXPECT_EQ(0, dgram_err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(-1, dgram_err);
+				EXPECT_EQ(EPERM, errno);
+			}
+
+			EXPECT_EQ(0, close(stream_client));
+			stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
+			ASSERT_NE(-1, stream_client);
+
+			ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+			err = connect(
+				stream_client,
+				&self->parent_stream_address.unix_addr,
+				self->parent_stream_address.unix_addr_len);
+			dgram_err = connect(
+				dgram_client,
+				&self->parent_dgram_address.unix_addr,
+				self->parent_dgram_address.unix_addr_len);
+
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, err);
+				EXPECT_EQ(0, dgram_err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(-1, dgram_err);
+				EXPECT_EQ(EPERM, errno);
+			}
+			EXPECT_EQ(0, close(stream_client));
+			EXPECT_EQ(0, close(dgram_client));
+
+			_exit(_metadata->exit_code);
+			return;
+		}
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child == OTHER_SANDBOX)
+			create_fs_domain(_metadata);
+		else if (variant->domain_child == SCOPE_SANDBOX)
+			create_scoped_domain(
+				_metadata,
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+		stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_NE(-1, stream_server);
+		dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, dgram_server);
+
+		ASSERT_EQ(0, bind(stream_server,
+				  &self->child_stream_address.unix_addr,
+				  self->child_stream_address.unix_addr_len));
+		ASSERT_EQ(0, bind(dgram_server,
+				  &self->child_dgram_address.unix_addr,
+				  self->child_dgram_address.unix_addr_len));
+		ASSERT_EQ(0, listen(stream_server, backlog));
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
+		ASSERT_EQ(0, close(stream_server))
+		ASSERT_EQ(0, close(dgram_server));
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent == OTHER_SANDBOX)
+		create_fs_domain(_metadata);
+	else if (variant->domain_parent == SCOPE_SANDBOX)
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+	stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_NE(-1, stream_server);
+	dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, dgram_server);
+	ASSERT_EQ(0, bind(stream_server, &self->parent_stream_address.unix_addr,
+			  self->parent_stream_address.unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_server, &self->parent_dgram_address.unix_addr,
+			  self->parent_dgram_address.unix_addr_len));
+
+	ASSERT_EQ(0, listen(stream_server, backlog));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(0, close(stream_server));
+	ASSERT_EQ(0, close(dgram_server));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/* clang-format off */
+FIXTURE(outside_socket)
+{
+	struct service_fixture address, transit_address;
+};
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
+	memset(&self->transit_address, 0, sizeof(self->transit_address));
+	set_unix_address(&self->transit_address, 0);
+	memset(&self->address, 0, sizeof(self->address));
+	set_unix_address(&self->address, 1);
+}
+
+FIXTURE_TEARDOWN(outside_socket)
+{
+}
+
+/*
+ * Test unix_stream_connect and unix_may_send for parent and child processes
+ * when connecting socket has different domain than the process using it.
+ */
+TEST_F(outside_socket, socket_with_different_domain)
+{
+	pid_t child;
+	int err, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+	int sock;
+
+	drop_caps(_metadata);
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
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+		if (variant->domain_server_socket) {
+			int data_socket, stream_server;
+			int fd_sock = socket(AF_UNIX, variant->type, 0);
+
+			ASSERT_NE(-1, fd_sock);
+
+			stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
+
+			ASSERT_NE(-1, stream_server);
+			ASSERT_EQ(0, bind(stream_server,
+					  &self->transit_address.unix_addr,
+					  self->transit_address.unix_addr_len));
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
+		sock = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, sock);
+		/* wait for parent signal for connection */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		err = connect(sock, &self->address.unix_addr,
+			      self->address.unix_addr_len);
+		if (!variant->domain_server_socket) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+		}
+		ASSERT_EQ(0, close(sock));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (!variant->domain_server_socket) {
+		sock = socket(AF_UNIX, variant->type, 0);
+	} else {
+		int cli = socket(AF_UNIX, SOCK_STREAM, 0);
+
+		ASSERT_NE(-1, cli);
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		ASSERT_EQ(0, connect(cli, &self->transit_address.unix_addr,
+				     self->transit_address.unix_addr_len));
+
+		sock = recv_fd(cli);
+		ASSERT_LE(0, sock);
+		ASSERT_EQ(0, close(cli));
+	}
+
+	ASSERT_NE(-1, sock);
+
+	if (variant->domain_server)
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+	ASSERT_EQ(0, bind(sock, &self->address.unix_addr,
+			  self->address.unix_addr_len));
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(sock, backlog));
+	/* signal to child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(0, close(sock));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/scoped_base_variants.h b/tools/testing/selftests/landlock/scoped_base_variants.h
new file mode 100644
index 000000000000..a070ad4693e6
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_base_variants.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock scoped_domains variants
+ *
+ * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
+ */
+
+#define _GNU_SOURCE
+
+/* clang-format on */
+FIXTURE_VARIANT(scoped_domains)
+{
+	bool domain_both;
+	bool domain_parent;
+	bool domain_child;
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
+FIXTURE_VARIANT_ADD(scoped_domains, without_domain) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = false,
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
+FIXTURE_VARIANT_ADD(scoped_domains, with_child_domain) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
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
+FIXTURE_VARIANT_ADD(scoped_domains, with_parent_domain) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
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
+FIXTURE_VARIANT_ADD(scoped_domains, with_sibling_domain) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = true,
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
+FIXTURE_VARIANT_ADD(scoped_domains, inherited_domain) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
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
+FIXTURE_VARIANT_ADD(scoped_domains, nested_domain) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
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
+FIXTURE_VARIANT_ADD(scoped_domains, with_nested_and_parent_domain) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
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
+FIXTURE_VARIANT_ADD(scoped_domains, with_forked_domains) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
diff --git a/tools/testing/selftests/landlock/scoped_common.h b/tools/testing/selftests/landlock/scoped_common.h
new file mode 100644
index 000000000000..a9a912d30c4d
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_common.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock scope test helpers
+ *
+ * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+
+static void create_scoped_domain(struct __test_metadata *const _metadata,
+				 const __u16 scope)
+{
+	int ruleset_fd;
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = scope,
+	};
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd)
+	{
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
diff --git a/tools/testing/selftests/landlock/scoped_multiple_domain_variants.h b/tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
new file mode 100644
index 000000000000..f035c9401a5f
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock variants for three processes with various domains.
+ *
+ * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
+ */
+
+#define _GNU_SOURCE
+
+enum sandbox_type {
+	NO_SANDBOX,
+	SCOPE_SANDBOX,
+	/* Any other type of sandboxing domain */
+	OTHER_SANDBOX,
+};
+
+/* clang-format on */
+FIXTURE_VARIANT(scoped_vs_unscoped_sockets)
+{
+	const int domain_all;
+	const int domain_parent;
+	const int domain_children;
+	const int domain_child;
+	const int domain_grand_child;
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
+FIXTURE_VARIANT_ADD(scoped_vs_unscoped_sockets, deny_scoped) {
+	.domain_all = OTHER_SANDBOX,
+	.domain_parent = NO_SANDBOX,
+	.domain_children = SCOPE_SANDBOX,
+	.domain_child = NO_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
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
+FIXTURE_VARIANT_ADD(scoped_vs_unscoped_sockets, all_scoped) {
+	.domain_all = SCOPE_SANDBOX,
+	.domain_parent = NO_SANDBOX,
+	.domain_children = SCOPE_SANDBOX,
+	.domain_child = NO_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
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
+FIXTURE_VARIANT_ADD(scoped_vs_unscoped_sockets, allow_with_other_domain) {
+	.domain_all = OTHER_SANDBOX,
+	.domain_parent = NO_SANDBOX,
+	.domain_children = OTHER_SANDBOX,
+	.domain_child = NO_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
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
+FIXTURE_VARIANT_ADD(scoped_vs_unscoped_sockets, allow_with_one_domain) {
+	.domain_all = NO_SANDBOX,
+	.domain_parent = OTHER_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = SCOPE_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
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
+FIXTURE_VARIANT_ADD(scoped_vs_unscoped_sockets, allow_with_grand_parent_scoped) {
+	.domain_all = NO_SANDBOX,
+	.domain_parent = SCOPE_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = OTHER_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
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
+FIXTURE_VARIANT_ADD(scoped_vs_unscoped_sockets, allow_with_parents_domain) {
+	.domain_all = NO_SANDBOX,
+	.domain_parent = SCOPE_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = SCOPE_SANDBOX,
+	.domain_grand_child = NO_SANDBOX,
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
+FIXTURE_VARIANT_ADD(scoped_vs_unscoped_sockets, deny_with_self_and_grandparent_domain) {
+	.domain_all = NO_SANDBOX,
+	.domain_parent = SCOPE_SANDBOX,
+	.domain_children = NO_SANDBOX,
+	.domain_child = NO_SANDBOX,
+	.domain_grand_child = SCOPE_SANDBOX,
+	/* clang-format on */
+};
-- 
2.34.1


