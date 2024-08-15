Return-Path: <netdev+bounces-118949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC57953A19
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA5B1C256F8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D71547CF;
	Thu, 15 Aug 2024 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYT6Whnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4195B1FB;
	Thu, 15 Aug 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746587; cv=none; b=KtVtxj8jckJ2O5Pd7wEZdYEhZmamzXqG8WFHmLNedmzEVAy0MOzPQR9+BjbPUQjk/ze+pa2itOo2BJtZLGG3jMT1Mvpd6H2HO3iluHc2NVconereAiVkJxtAH/V7lUcgWlketG4WhEFIX5s/1EJMqPv6LEMrpOQBVajIfQ0GWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746587; c=relaxed/simple;
	bh=Dwr57pngHUSLhksrsKqWWibkSxtCwUUh0p6vmB6rYUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdpLyaTcagp208gRD9pW4eZCucUynDFWD5eFck68nPyuJvvFcffQ55h2ZkadnXxadCJn52dSjjJXncewCQ566BKYjp0O4K9yrFAznxrsSD49XbPfGyKL9QQN8lhUR4V5kEGxpQSiPy3a5oQExy8UXVO3pnn3DW2pDGHzkTD/IRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYT6Whnx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-712603f7ba5so987572b3a.3;
        Thu, 15 Aug 2024 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746585; x=1724351385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDmpFZN7V1g06/ZGYNIP4Pk8NE5ZqNFuGVyTota0SLk=;
        b=JYT6WhnxxNlbbh6BQuKj+eDMz8/7nClPHPwNtY48kprcQfcnFvHHGFnHOlaQukQNJV
         RJVx/ElVJPe1XIZFCw+LrMQUOix1Y9Olbqq3PcN+7UDngzg1KxJgQHKno1et6pIcxNv5
         kca8gwZOOQPtuQyNxyscjHs6lEHQ8qiz11EiHgg9MVm8u0saqJz6V7fq6f2u8b0Tn+eF
         SCC9aNedPPqUZqFS6Sw4Fj74Z/7+NX2RyUvRT/9Ssy/ePg3XLOb9hBpnwdZKrNXF3xwv
         b9iKm5lP47nLgw+ojTDO7KYmgZn2JhJCUr6v5jLqtMIn2ZhYUOx8cbQArRArwjdGYVmB
         vo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746585; x=1724351385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDmpFZN7V1g06/ZGYNIP4Pk8NE5ZqNFuGVyTota0SLk=;
        b=mDxux2hG12aOGjNFX1S3Qk//XBQEfcGCncnget345rZCdHOOnEvbn8n+WSqr4rcFkH
         vUIPlTf08a5jlQjdwxUF3SMKGkoapY8IAeGpi+XiE5D/K+Op2Q7HJ9ZjS8b9gFB5MDTj
         2SbVHR/BgZ8r8F12ZgeW8s3IXxQmHYaXr1XEVQ99J1k1ExRPCEp6KKOcYVB8LiA9Aqyq
         wsxpz8GyNNrGvEH3LNrbRsb2Std0M4g0cujcTqbbcbPIxGVHJEP1c0ObPVa3DStpIynr
         OUBBjKKUPfXlc4wjKLjkfLfC/ocqMr9BdSh1EykHkiap4A75xr+jZlIA+DqQ3ARGPSi/
         ij8g==
X-Forwarded-Encrypted: i=1; AJvYcCUM0LNHcxOlm3NeWQ3DOro+iJilpAaNm4rhD92F7Qi1KsAHlTgRNRPRVu01Jn7bikwokdfhoecp@vger.kernel.org, AJvYcCVchMor3sgDrQrrmiRsb6yISn4WVH3RAWyVIJJCMi7dE7Hxs7oRBabMbdij55IwCYTP2IpP7N32D4dJMz8=@vger.kernel.org, AJvYcCXT8z+2mIa9MSQNC2sUDxoS81ZWJohu6cDz+zYM/ejB7hL3rXBCdj1qTsbUVVn/YrwcAcEZRIVH1MYVbIgTgP8fy0wj3wml@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuoccu5I5sXwdl9u5vH37u65zNo20N3N2RD9DRkLRtHxLgxxBE
	66Zp+0vgWJWxEOb0ZkbIQeUUL4Y6hT0qc8CDULAGSrkUNJSw4Yiu
X-Google-Smtp-Source: AGHT+IEAx3eAq13eKvyQi76A8rHmXhmvNa2y+UtFzSmr+VF8ucB8ZCth/llQ5TrkB5fficwGiAOAxQ==
X-Received: by 2002:a05:6a21:2d86:b0:1c4:9100:6a1b with SMTP id adf61e73a8af0-1c904fca42bmr648447637.30.1723746584960;
        Thu, 15 Aug 2024 11:29:44 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c76sm1431683a12.62.2024.08.15.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:29:44 -0700 (PDT)
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
Subject: [PATCH v3 3/6] selftest/Landlock: Signal restriction tests
Date: Thu, 15 Aug 2024 12:29:22 -0600
Message-Id: <82b0d2103013397d8b46de9fc7c8c78456055299.1723680305.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723680305.git.fahimitahera@gmail.com>
References: <cover.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch expands Landlock ABI version 6 by providing tests for
signal scoping mechanism. Base on kill(2), if the signal is 0,
no signal will be sent, but the permission of a process to send
a signal will be checked. Likewise, this test consider one signal
for each signal category.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
Chnages in versions:
V2:
* Moving tests from ptrace_test.c to scoped_signal_test.c
* Remove debugging statements.
* Covering all basic restriction scenarios by sending 0 as signal
V1:
* Expanding Landlock ABI version 6 by providing basic tests for
  four signals to test signal scoping mechanism.
---
 .../selftests/landlock/scoped_signal_test.c   | 302 ++++++++++++++++++
 1 file changed, 302 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
new file mode 100644
index 000000000000..92958c6266ca
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Signal Scoping
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
+#include <unistd.h>
+
+#include "common.h"
+
+static sig_atomic_t signaled;
+
+static void create_signal_domain(struct __test_metadata *const _metadata)
+{
+	int ruleset_fd;
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPED_SIGNAL,
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
+static void scope_signal_handler(int sig, siginfo_t *info, void *ucontext)
+{
+	if (sig == SIGHUP || sig == SIGURG || sig == SIGTSTP ||
+	    sig == SIGTRAP || sig == SIGUSR1) {
+		signaled = 1;
+	}
+}
+
+/* clang-format off */
+FIXTURE(signal_scoping) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(signal_scoping)
+{
+	const int sig;
+	const bool domain_both;
+	const bool domain_parent;
+	const bool domain_child;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_without_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_child_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_with_parent_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_sibling_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_sibling_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_nested_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_with_nested_and_parent_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain) {
+	/* clang-format on */
+	.sig = 0,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+/* Default Action: Terminate*/
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGHUP) {
+	/* clang-format on */
+	.sig = SIGHUP,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGHUP) {
+	/* clang-format on */
+	.sig = SIGHUP,
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+};
+
+/* Default Action: Ignore*/
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGURG) {
+	/* clang-format on */
+	.sig = SIGURG,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGURG) {
+	/* clang-format on */
+	.sig = SIGURG,
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+};
+
+/* Default Action: Stop*/
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGTSTP) {
+	/* clang-format on */
+	.sig = SIGTSTP,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGTSTP) {
+	/* clang-format on */
+	.sig = SIGTSTP,
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+};
+
+/* Default Action: Coredump*/
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGTRAP) {
+	/* clang-format on */
+	.sig = SIGTRAP,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGTRAP) {
+	/* clang-format on */
+	.sig = SIGTRAP,
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGUSR1) {
+	/* clang-format on */
+	.sig = SIGUSR1,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+FIXTURE_SETUP(signal_scoping)
+{
+}
+
+FIXTURE_TEARDOWN(signal_scoping)
+{
+}
+
+TEST_F(signal_scoping, test_signal)
+{
+	pid_t child;
+	pid_t parent = getpid();
+	int status;
+	bool can_signal;
+	int pipe_parent[2];
+	struct sigaction action = {
+		.sa_sigaction = scope_signal_handler,
+		.sa_flags = SA_SIGINFO,
+
+	};
+
+	can_signal = !variant->domain_child;
+
+	if (variant->sig > 0)
+		ASSERT_LE(0, sigaction(variant->sig, &action, NULL));
+
+	if (variant->domain_both) {
+		create_signal_domain(_metadata);
+		if (!__test_passed(_metadata))
+			/* Aborts before forking. */
+			return;
+	}
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+		int err;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		if (variant->domain_child)
+			create_signal_domain(_metadata);
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		err = kill(parent, variant->sig);
+		if (can_signal) {
+			ASSERT_EQ(0, err);
+		} else {
+			ASSERT_EQ(-1, err);
+			ASSERT_EQ(EPERM, errno);
+		}
+		/* no matter of the domain, a process should be able to send
+		 * a signal to itself.
+		 */
+		ASSERT_EQ(0, raise(variant->sig));
+		if (variant->sig > 0)
+			ASSERT_EQ(1, signaled);
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+	if (variant->domain_parent)
+		create_signal_domain(_metadata);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	if (can_signal && variant->sig > 0) {
+		ASSERT_EQ(-1, pause());
+		ASSERT_EQ(EINTR, errno);
+		ASSERT_EQ(1, signaled);
+	} else {
+		ASSERT_EQ(0, signaled);
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


