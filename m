Return-Path: <netdev+bounces-109573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C1928EC3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C02D1C22CC6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE114A60C;
	Fri,  5 Jul 2024 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgYWxWAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5813C9DE;
	Fri,  5 Jul 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214559; cv=none; b=T5l2ocLlZQMyme/vtz+I/XW5S5hvZ5dmyVI53wNoHaNrkIzuXgRk5Qyag+vTa3EYXfYX0nU91ge5+r7simlZNYkuZNjteRJk6Dv1QUC/ZJR2DlQ0jCFTGUj98esH/dY7isDc0o5ddoPqQLyMLiuBVQeBgHGMR1dLMS78jO2PjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214559; c=relaxed/simple;
	bh=L0pa+ASgYRvONHqMPgOIaKPjkxUMXzz5JmdhJ3C+zZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guc8ob4BC4lqcYqL7zes+VbXGWX7Os9MDk6gVyYAZmq2PspXAoqHhcQULsQvmmzneNFbDF4UDgG3SDt2O8tgfaFR29MkGggr8QTYayedNNKTCoj6Lro0WOdghzs4xRYCSY8YPUzCf033qM4MTH1M3EDd5hu8o9xDfoRL9wYOhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgYWxWAb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b04cb28acso1310391b3a.0;
        Fri, 05 Jul 2024 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720214557; x=1720819357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwAF8+6oQayFkR41Q8MjfYalt/kzwwy3b6NOpJMFL58=;
        b=WgYWxWAbQzt0yLD/+ZOl3oOIQS87ZwBoFZGKjP2iYTyrkDh+uJblgl/5D+1bEVJhgA
         /54l4/AWoOVcK3RqHDzONTjRSFTkAt+Eme+h8jD/G2yqz2bVc3Bd/d8eQXlOJQ0E87U9
         nBCoVvJZVT9E+J4x1RdYXP1aJkJeo3ym770tMUVSQrGUozAXUTfy8ew1hEboF6OLPAV3
         xb6he1vQMG2dgAYmqRYqjV+QiFHPyBz+t9zOtn8AUiXSsvV8NYSUI9PFqsr76l0vHhZM
         /CjqEDb4xp/RmJEahMpzjCys+7FseWXcCKPAAeTMhE++PuWy1/fMVDdH3xG/XaOullxo
         P33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720214557; x=1720819357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwAF8+6oQayFkR41Q8MjfYalt/kzwwy3b6NOpJMFL58=;
        b=Ui45qXqedjDbZFIIyelm1VU/m770Bv1yPs1MutQyuuOBDEqX91337tiTs+5JYdncyK
         tuABtCI6qz5OiM8Fx3fPZal1YzggYXBFNvTkP2ESELvudozbs/sYwngmZOKC7ZiNkFTD
         Mn1hXMhiorZbt1M4zvsehjqgsg2T7LLor6xIiwEe2lzPXaQ7FJ4szQOEWa3dC94ZQW1/
         3a8dT9tT7hd3ZqG6jADcdNd12VLiW+FdxlVLMqxsDo/x2jXDBAfj6egsFJcjJJRyaFTO
         KwEY6gojumdqxN3Dcf/W4Bolk8aM9bVSe4FJv7v5bcoqJUwx68YZd1A9BoO79G9T6E1h
         zOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVtjKXNQ/JtFnkgKfpNI8WJHipILpsmNc+o9NCzGcgsoU6emxoVZMOljiKB/lIGfOo/y5AjENgeSBHAe2ur63KZ0WnjUU81fGN0TJZ6zPvzpIKEjs9LYfFtj+EZbHO1e5M9Nv+l4PNHafbFluvCwUPF2EqkLD2Ebf33/oJ0BBVQErKbXChII6neLxO
X-Gm-Message-State: AOJu0Ywrwy4gxeIy/ImgzGYE0C0FAHjpg5yeWawEPCz3aCR8rUCePAj0
	9DzJkd4q2ufQCaZJA6gUoE8yNiPGJGTWIWXJXHRO1xSXqZy3jefN
X-Google-Smtp-Source: AGHT+IEHKBP4ZHXvKMfTXUMD/6/Pg/HUUZBKKhSdKnbKczuLUardtiIMYvOIQoszQuegJ1s3C9JAEQ==
X-Received: by 2002:a05:6a00:2d8a:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-70b01b320a5mr7013983b3a.9.1720214556886;
        Fri, 05 Jul 2024 14:22:36 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802566511sm14507529b3a.75.2024.07.05.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:22:36 -0700 (PDT)
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
Subject: [PATCH v1 2/2] Landlock: Signal scoping tests
Date: Fri,  5 Jul 2024 15:21:43 -0600
Message-Id: <70756a7b4ed5bd32f2d881aa1a0d1e7760ce4215.1720213293.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
References: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 216 ++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..e092b67f8b67 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -17,6 +17,8 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include <signal.h>
+
 #include "common.h"
 
 /* Copied from security/yama/yama_lsm.c */
@@ -25,6 +27,8 @@
 #define YAMA_SCOPE_CAPABILITY 2
 #define YAMA_SCOPE_NO_ATTACH 3
 
+static sig_atomic_t signaled;
+
 static void create_domain(struct __test_metadata *const _metadata)
 {
 	int ruleset_fd;
@@ -436,4 +440,216 @@ TEST_F(hierarchy, trace)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+static void create_sig_domain(struct __test_metadata *const _metadata)
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
+	if (sig == SIGHUP || sig == SIGURG || sig == SIGTSTP || sig == SIGTRAP)
+		signaled = 1;
+
+	// signal process group
+	//kill(-(t->pid), SIGKILL);
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
+/* Default Action: Terminate*/
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain) {
+	/* clang-format on */
+	.sig = SIGHUP,
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain) {
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
+	int pipe_child[2], pipe_parent[2];
+	//char buf_parent;
+
+	struct sigaction action = {
+		.sa_sigaction = scope_signal_handler,
+		.sa_flags = SA_SIGINFO,
+
+	};
+
+	can_signal = !variant->domain_child;
+
+	//sigemptyset(&act.sa_mask);
+
+	ASSERT_LE(0, sigaction(variant->sig, &action, NULL))
+	{
+		TH_LOG("ERROR in sigaction %s", strerror(errno));
+	}
+
+	if (variant->domain_both) {
+		create_sig_domain(_metadata);
+		if (!__test_passed(_metadata))
+			/* Aborts before forking. */
+			return;
+	}
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+		int err;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+
+		if (variant->domain_child)
+			create_sig_domain(_metadata);
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		//err = raise(SIGHUP);
+		err = kill(parent, variant->sig);
+		if (can_signal) {
+			ASSERT_EQ(0, err);
+		} else {
+			ASSERT_EQ(EPERM, errno)
+			{
+				TH_LOG("Invalid error cached: %s",
+				       strerror(errno));
+			}
+		}
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+	if (variant->domain_parent)
+		create_sig_domain(_metadata);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	if (can_signal) {
+		ASSERT_EQ(-1, pause());
+		ASSERT_EQ(EINTR, errno);
+		ASSERT_EQ(1, signaled);
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFEXITED(status)) {
+		TH_LOG("Exited with code %d:", WEXITSTATUS(status));
+		if (!can_signal)
+			ASSERT_NE(1, signaled);
+	}
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


