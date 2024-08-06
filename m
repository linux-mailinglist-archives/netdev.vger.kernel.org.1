Return-Path: <netdev+bounces-116204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CE949757
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394C01F22920
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D778C75;
	Tue,  6 Aug 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Guc0ThCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4483CC7;
	Tue,  6 Aug 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967882; cv=none; b=IQ/WUhK/zXBoMvOMQNOtSLG3snEmFqtacIUXAYh4xECF9Ryu3k84vFqaPiHdHYlgxsKNfb2kkXxYXg7FAdnYdJCTloXS6BAmmjDa7Wd0h7Djiyqp4eCRoS0sSQqR/UKt46f9HtVEb9hBRiBZnvQu/9O1e6FpHfacDf5O/DAzWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967882; c=relaxed/simple;
	bh=OL8YDt9ckh5mt14xDgUvpKYnO8xoVA5eiX3ktYKrBwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfRAwds+p5t1PVCtdXQ4Ig9/OoFq9q6JW+C0HykZRIvm5pVPWcxRSn9Ap0j62SYcqZ0Qum9kpdt9DKgw/2yfp+wxyFKWUFVV8+Zd5IYNGW5okGsp/fLay0pd/oJqDZry69i3B+1V4/sWH6SiUqjSNz0ZYa9qlKE+AYmqNrxc9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Guc0ThCb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so690357a91.3;
        Tue, 06 Aug 2024 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967880; x=1723572680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m33RcWxdO0nPOjLkO6+czI4OXLdEbwvOpCuSkjhK1I=;
        b=Guc0ThCbdip7TmBxw6EhQbBGCo2GHd+LD4UQJ7Eb1dzHCQdUYARwl++TuiuhnkyEWv
         yNWgSJQqeXehPI5paeSn1DVXmK+F5/jMKZclL+vVNXoiBcCRvZOKwUFT8X9XmpvELWt+
         KZrAF15sKlq/Cex5LHvZUaOsS6Inh1TqEhRj85oKVlaV/5qOODvISwGVTb7RpcWHDjeS
         +jBl4jcGwIrW30T+3EDVK9m8A0yT/Vz88kaba4qkxQkwzWkd8YMUnRqJNlP7rkH7zzsS
         k/V9TQwej8O7/ZbvRm6vjBgDb1bTQPrh4Ubl4n51ZwvBqApQSoY5UNJHDBcTXdubEpXo
         1Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967880; x=1723572680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m33RcWxdO0nPOjLkO6+czI4OXLdEbwvOpCuSkjhK1I=;
        b=PGVQlH94G6q3bnF5MXWK5+f+aH42R6L8EJLOQSbqpiYA7T4G4eRjOhMFqXeqBr7BSO
         61bF2gC86tOs8Oj1+UCSSKWG8JUB/SnZCygcwBp8y0uMKZ8Hb91pAO8J+VLCQjj1NiAj
         3xdDG1K8JdiP4SagCfnfLe+8tbxl7iUHH37SpZqEy7tiqwigWHsbfiwOcmJN6voIH9yH
         g00Zj8xy95ckZ1QdtV/44Fw9V+9KleQJ77ZtmMghAeEJZKFeRAcQ4OuonBz5Mu7Mcj7w
         TBosD7Nt/ZPhl7P7/ft1L7B5tEVDKkWaE52URXOMSHrPJs2sOpsok3h/+6z7NuS5O/ki
         7HMA==
X-Forwarded-Encrypted: i=1; AJvYcCU/6QyFviLt+NQLa4rG5aJ8b6cSCmiZI171sszmMVOOOMJrAOULBuP/zJRjzsv0yf+Ga0X5u6coQGoa5Qsz2vJrV+49tG3Q8TvzAn4Xf45AKSKenrQewLwKTTUbTX2WT0deLX0B0ENyISsflD6JR2DXChLufWQnefE5kKmuSKORpI1hhyt0YDoo4aXV
X-Gm-Message-State: AOJu0Yw6UwTxXXF4W618AuCrBbbWwr47lae2BYALZ2DfDMLCAI9ktX+S
	YH3L79bVjMWjMQbr0Yg/3HeObLMK3fl239MRcRlVONJPdp6rkUas
X-Google-Smtp-Source: AGHT+IEGenzYlt3InIG6GjJXqL6gzeoVJJlv0EHbALzZdfiNd16vaiBKs7i7E7zW2R/WfazNUE5HQA==
X-Received: by 2002:a17:90b:50cf:b0:2cf:cc0d:96cc with SMTP id 98e67ed59e1d1-2cff9413dcemr18564083a91.9.1722967879444;
        Tue, 06 Aug 2024 11:11:19 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45b51esm12829504a91.32.2024.08.06.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:11:18 -0700 (PDT)
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
Subject: [PATCH v2 2/4] selftest/Landlock: Signal restriction tests
Date: Tue,  6 Aug 2024 12:10:41 -0600
Message-Id: <d8fdf745f0f624cae57312e7f5f06ee64b96b33d.1722966592.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722966592.git.fahimitahera@gmail.com>
References: <cover.1722966592.git.fahimitahera@gmail.com>
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
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 .../selftests/landlock/scoped_signal_test.c   | 303 ++++++++++++++++++
 2 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c

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
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
new file mode 100644
index 000000000000..133b1c8edf49
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -0,0 +1,303 @@
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
+#include <signal.h>
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


