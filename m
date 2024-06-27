Return-Path: <netdev+bounces-107489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033891B2BC
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E58283D2E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0A1A0B1F;
	Thu, 27 Jun 2024 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqKnxVps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F01A2C34;
	Thu, 27 Jun 2024 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531053; cv=none; b=KIWef2MLi7WH/xvWWqeNnEefrrwpt5KBA2R+34BYDRtQZLUet4pc8ZCqdfSEyhIVq93j0pUIlZedwdVzwGVEgCcUquBzHhPyfFfm7gZz50KDlVy+eK4dOfpaG0jxQ9eto6XOOmia7xR99sM9PFWYDH3TbvvVGJILf2rPbPbKPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531053; c=relaxed/simple;
	bh=LFpf/SNNPyTVTtQdIVavrIFZxlglD8cJsmDmFABPtoE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uUDii0v2h0Hly14K+nOdIkbR4tc6zYlKtHy5Ioi1DE3JbES7YVOvFxgTbboziQWJVfUDgMR8fR8TOq1FREdwqpOIYdK4lsQ3PMVNeHxDonAFe/3XMf5zU5odqqs4eRu9lj3AaggjXFDB2+RMBlxK+LeIdQb1OYh7pG1VWbPjCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqKnxVps; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso6393686a12.2;
        Thu, 27 Jun 2024 16:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719531051; x=1720135851; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HH/qDdHfgnYDFqo07kdktKc+wJeIBo+GTPiN5f39VuI=;
        b=bqKnxVpsR/lUNBgFzz/v1jRj74bw878UVY/nfgCfgtjZQtmIXLV52tW2kREke3uzGL
         uv3vc9IleYSh6/nIn0o2AFjiu+iEdf2XlYXfP1Zhv11yj2LR3+JqftZcSnLiBnH63BiI
         +mDQFWTgILLrkLlwhumgDe5sg9/u8yJYGr8JF5gISALQRo1flyIdj1f1Qxu1bRy+bViI
         xFJH3oYwuWxLvc676nEP0Sq3uMT/bTIGsT2vPcKfd5izH4QdFlWwVSQhz3bEHN3VdtV6
         ucaPQBc7PqlR/Bk3VBLR4T106BR91dECkhE0xiqAscVBTPlDORDbApsra/FU5kPon7kr
         uLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719531051; x=1720135851;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HH/qDdHfgnYDFqo07kdktKc+wJeIBo+GTPiN5f39VuI=;
        b=aH48qqjKdHSuz/mkYU574UdB+gTaBDFRoti+kpf+09/6SoeF85MaCBL6ouD9644AoA
         BsMBBnPBbILUty/DMp0pGzD4OkhY4h+zbohKj2AqjGteUtAWuFwL8exOIFc9uLgTHT8d
         fAnjTSghrLRJvni3bfElxhp6cV4WUtD/0l7uTAdAhlHkq7qfB2HFvOhqY23g3Sz7zz82
         IAc6uTP/GdjTjuKwEvyFkRGWaNkvSASQ0AxCkYkN5oCpz+v40Mkuz6/ognptw6OpP4ag
         rSpSa1CYOv9IUPzXmaWB64OSbw9WUrrNAsOV0x8QzbwYpXWGV3AGV5Hi+lZ/jOxhbOp6
         aMUg==
X-Forwarded-Encrypted: i=1; AJvYcCVA8xb2BdfyGi3xxn/nR31CA0PyVp2m8ahTTYr52jiHb4omvcDDxPoIh/KakdbK1XFwOmKlEy0pJSOTpInUEZWQTTakrvNHcjeCjGyNN6HzRcC8DI/8dXlQbntonbF5J/847WxKNzuDz4Ka2Yj9d96hIHvwGdDELBfOn6AuOWJdunAdvY1cjtIESlTR
X-Gm-Message-State: AOJu0Yxg82q3rziib3/CbU1NyfB5pDRWkiv7PFG+DsQ80HJGjDc9c3S0
	t5jTSjgg+3QBKsPg4AibLYCAZ0K7VF+uttr4aVdl34Dre6kPaINV
X-Google-Smtp-Source: AGHT+IFofh21FGB/K7FKoE3f+cNveO94qCBBD30n2bt4ALzE+kzt6O/TrfEEm2nkVUiC6zJCAOxwng==
X-Received: by 2002:a05:6a20:4307:b0:1be:e1e1:d5de with SMTP id adf61e73a8af0-1bee1e1d63dmr924259637.30.1719531050711;
        Thu, 27 Jun 2024 16:30:50 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d102b81sm240553a12.81.2024.06.27.16.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:30:50 -0700 (PDT)
Date: Thu, 27 Jun 2024 17:30:48 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v1] landlock: Abstract unix socket restriction tests
Message-ID: <Zn32KKIJrY7Zi51K@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Tests for scoping abstract unix sockets. The patch has three types of tests:
i) unix_socket: tests the scoping mechanism for a landlocked process, same as
ptrace test.
ii) optional_scoping: generates three processes with different domains and tests if
a process with a non-scoped domain can connect to other processes.
iii) unix_sock_special_cases: since the socket's creator credentials are used for
scoping datagram sockets, this test examine the cases where the socket's credentials
are different from the process who is using it.

Closes: https://github.com/landlock-lsm/linux/issues/7
Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 774 ++++++++++++++++++
 1 file changed, 774 insertions(+)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..7f1e73788869 100644
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
@@ -436,4 +440,774 @@ TEST_F(hierarchy, trace)
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
+FIXTURE_VARIANT_ADD(unix_socket, allow_with_one_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
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
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_parent_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
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
+FIXTURE_VARIANT_ADD(unix_socket, allow_sibling_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_sibling_domain_connect_to_child) {
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
+FIXTURE_VARIANT_ADD(unix_socket, allow_nested_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
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
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_nested_and_parent_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_nested_and_parent_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
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
+ * when they have scoped domain or no domain. */
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
+	/*
+         * can_connect_to_child is true if a parent process can connect to its
+         * child process. The parent process is not isolated from the child
+	 * with a dedicated Landlock domain.
+         */
+	can_connect_to_child = !variant->domain_parent;
+	/*
+         * can_connect_to_parent is true if a child process can connect to its parent
+         * process. This depends on the child process is not isolated from
+	 * the parent with a dedicated Landlock domain.
+         */
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
+		/* create a socket for child process */
+		if (variant->connect_to_parent) {
+			self->client = socket(AF_UNIX, SOCK_STREAM, 0);
+			self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+			ASSERT_NE(-1, self->client);
+			ASSERT_NE(-1, self->dgram_client);
+
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
+			/* child process should create a listening socket */
+			self->server = socket(AF_UNIX, SOCK_STREAM, 0);
+			self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+
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
+/* clang-format off */
+FIXTURE(optional_scoping)
+{
+	int parent_server, child_server, client;
+};
+/* clang-format on */
+
+/* Domain is defined as follows:
+ * 0 --> no domain
+ * 1 --> have domain
+ * 2 --> have domain and is scoped
+ **/
+FIXTURE_VARIANT(optional_scoping)
+{
+	int domain_all;
+	int domain_parent;
+	int domain_children;
+	int domain_child;
+	int domain_grand_child;
+	int type;
+};
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
+	.domain_all = 1,
+	.domain_parent = 0,
+	.domain_children = 2,
+	.domain_child = 0,
+	.domain_grand_child = 0,
+	.type = SOCK_DGRAM,
+	/* clang-format on */
+};
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
+FIXTURE_VARIANT_ADD(optional_scoping, allow_with_domain) {
+	.domain_all = 1,
+	.domain_parent = 0,
+	.domain_children = 1,
+	.domain_child = 0,
+	.domain_grand_child = 0,
+	.type = SOCK_DGRAM,
+	/* clang-format on */
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
+	if (variant->domain_grand_child == 2)
+		can_connect_to_child = false;
+	else
+		can_connect_to_child = true;
+
+	if (!can_connect_to_child || variant->domain_children == 2)
+		can_connect_to_parent = false;
+	else
+		can_connect_to_parent = true;
+
+	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
+	memcpy(&addr.sun_path, sun_path, sock_len);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	if (variant->domain_all == 1) {
+		create_domain(_metadata);
+	} else if (variant->domain_all == 2) {
+		create_unix_domain(_metadata);
+	}
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
+		if (variant->domain_children == 1) {
+			create_domain(_metadata);
+		} else if (variant->domain_children == 2) {
+			create_unix_domain(_metadata);
+		}
+		grand_child = fork();
+		ASSERT_LE(0, grand_child);
+		if (grand_child == 0) {
+			ASSERT_EQ(0, close(pipe_parent[1]));
+			ASSERT_EQ(0, close(pipe_child[1]));
+
+			char buf1, buf2;
+			int err;
+			if (variant->domain_child == 1) {
+				create_domain(_metadata);
+			} else if (variant->domain_child == 2) {
+				create_unix_domain(_metadata);
+			}
+
+			self->client = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, self->client);
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
+			EXPECT_EQ(0, close(self->client));
+
+			_exit(_metadata->exit_code);
+			return;
+		}
+
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child == 1) {
+			create_domain(_metadata);
+		} else if (variant->domain_child == 2) {
+			create_unix_domain(_metadata);
+		}
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
+	if (variant->domain_parent == 1) {
+		create_domain(_metadata);
+	} else if (variant->domain_parent == 2) {
+		create_unix_domain(_metadata);
+	}
+
+	self->parent_server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_NE(-1, self->parent_server);
+	ASSERT_EQ(0,
+		  bind(self->parent_server, (struct sockaddr *)&addr, addrlen));
+
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(self->parent_server, 32));
+	/* signal to grand_child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/* The following test is only considered for dgram sockets.
+ * In all special cases, the client's domain is true.
+ */
+/* clang-format off */
+FIXTURE(unix_sock_special_cases) {
+	int server_socket, client;
+	int stream_server, stream_client;
+};
+/* clang-format on */
+
+FIXTURE_VARIANT(unix_sock_special_cases)
+{
+	const bool domain_server;
+	const bool domain_server_socket;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_server_sock_domain){
+	/* clang-format on */
+	.domain_server = false,
+	.domain_server_socket = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_server_domain){
+	/* clang-format off */
+	.domain_server = true,
+	.domain_server_socket = false,
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
+ * child processes when conecting socket has different domain
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
+			int fd_sock = socket(AF_UNIX, SOCK_DGRAM, 0);
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
+		self->client = socket(AF_UNIX, SOCK_DGRAM, 0);
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
+		self->server_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+	} else {
+		int cli = socket(AF_UNIX, SOCK_STREAM, 0);
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


