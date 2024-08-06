Return-Path: <netdev+bounces-116203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E70B949753
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D494284C53
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A513AA38;
	Tue,  6 Aug 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb0T1u6X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153712C499;
	Tue,  6 Aug 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967880; cv=none; b=Gcc7x4LUOwTwK6WIHXJaXt0pYlFK3HW/orPR1WNrXGe3phj4JPITEIcHxofqa0mPYtmasr8b5DoGG9SthsOr6QcvL1dmnC7UvoQImGAoOOqs7n9p9t0NOIIl9hOtxydNdSawxCgW4VEe29NpoC3WunYOgPPcM3vFYFGhlCt6tvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967880; c=relaxed/simple;
	bh=Tgz4rG0gdNZOi7Ceze4G3izUyhOrU5qXIBDASb3Kk/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uww840kvyBcK18/bqOPxf70vQQxCyOox4/o9Frhr3rRdlamXlrOTnHjh+apu3MauZauqWPkLPoktYE+nacQrBFu8oG6W48107uMl7t8R49h5DCxjUSJXiQjCQDIGXpW9pUsvQkv0Rs0kUuihZm2eg7k5wtHHVKwGFI/SB4OnNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb0T1u6X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so639369a91.2;
        Tue, 06 Aug 2024 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967878; x=1723572678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhkqFYwnINAcfquZFJ6nqQu+rI21VoQBsZtsC0iWGgg=;
        b=Wb0T1u6Xpmi2LDX6FyLJFfVfV4jCR+9JUIusVT8ZiUObBefnKJVgFGxBRnPSPplJEC
         9nxPvr9Xp7xArbaWbQQyQrZ03ZYW4mxqK+oIfLGypvP/Rdm+E6DlZ7TochDf8OtRcf1S
         M57RnoXLaTfI6fNlDiapwcWVh+yeKL98ahrMkd+ds16yAJ6BcDO2HvY2llfELQis8BoB
         a5J9i+IN0QGw3HVF0OwktUKjvA1Elh514u7Z3WOC+8QoFXXRVwe6wQnrvzBerE29o2vD
         9XmFQx/ksqLzYNTnZHy34b8Ys3FBDzrEksSqmRRKj9VlRt2PEdR9DB6PVmuQT9IlYXGG
         ZpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967878; x=1723572678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhkqFYwnINAcfquZFJ6nqQu+rI21VoQBsZtsC0iWGgg=;
        b=GrmVgzEYIT1nqkuCMjlbAquCDsxbrgqRtTmNnTwv3pPh9zN/Fj0X9z+g4lnKhxbefP
         y6agWQcpQcRqPGgpGsX29QPSqgyMGQyiqrKfArE4WDJ23xVvcKX+3jcTXHSHUM4BTwwp
         f+mkHu4YnFUP1viB5eVRHUVDfBmH5Nmd0Z2h09FCmRmeokGQK6kCtjfwkUTjubsOaC4C
         +WqrJauVJo+SUW+8CpsL7/a0rk68YQxXCwxgeZnpIkZ2XlVpmpA2rKCCkOHKJLhrOaAm
         3brU9Im8WtjgyTlQHSQSRvG6rxyx5LyiDUKykr8X6EzY8QrKquRL0EMVuFvkQ8kOGVlP
         nj0g==
X-Forwarded-Encrypted: i=1; AJvYcCXRZuGFCVbXXsxBtlP3+cxwfXMHr0GEJ9UvlwfmXsAGsoBRrMIenNxfzjWc9WfIxih5XY7VLdnPbz4M8jcIYUVUTNSzd72vnMrKyPi4o17h1BSeJAOVqajJghpG6pAX6rTAAEgimg0TYg3ekWJsVlIvuS2sRLD4weGK6+LM3fJGUDysYEXhtwDzDu0V
X-Gm-Message-State: AOJu0Yz7vNgXHIK/ByKdks53TOJMM6xrjX2GRVMl5WbEYHr4sT9cmk5l
	Ny0ytNN4GeBZAb8HCsSyzUNu9LS9IC3cOpKwUeNbDeBh7hIEA8ST
X-Google-Smtp-Source: AGHT+IG76IuTNr6BsP8RmeCPZaai/4NOu4kgq/HwMYShzLvUbPgoG8kPSvG2wBDihpM3klD8MA89cQ==
X-Received: by 2002:a17:90a:8a18:b0:2cf:2bf6:b030 with SMTP id 98e67ed59e1d1-2cff952d1fcmr15848502a91.33.1722967878333;
        Tue, 06 Aug 2024 11:11:18 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45b51esm12829504a91.32.2024.08.06.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:11:17 -0700 (PDT)
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
Subject: [PATCH v2 1/4] Landlock: Add signal control
Date: Tue,  6 Aug 2024 12:10:40 -0600
Message-Id: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722966592.git.fahimitahera@gmail.com>
References: <cover.1722966592.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a sandbox process is not restricted to send a signal
(e.g. SIGKILL) to a process outside of the sandbox environment.
Ability to sending a signal for a sandboxed process should be
scoped the same way abstract unix sockets are scoped. Therefore,
we extend "scoped" field in a ruleset with
"LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
sending any signal from within a sandbox process to its
parent(i.e. any parent sandbox or non-sandboxed procsses).

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---

Chenges in versions:
V2:
* Remove signal_is_scoped function
* Applying reviews of V1
V1:
* Introducing LANDLOCK_SCOPE_SIGNAL
* Adding two hooks, hook_task_kill and hook_file_send_sigiotask
  for signal scoping.
---
 include/uapi/linux/landlock.h |  3 +++
 security/landlock/limits.h    |  2 +-
 security/landlock/task.c      | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index ab31e9f53e55..a65fdb507d39 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -292,8 +292,11 @@ struct landlock_net_port_attr {
  *   from connecting to an abstract unix socket created by a process
  *   outside the related Landlock domain (e.g. a parent domain or a
  *   non-sandboxed process).
+ * - %LANDLOCK_SCOPED_SIGNAL: Restrict a sandboxed process from sending a signal
+ *   to another process outside sandbox domain.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
+#define LANDLOCK_SCOPED_SIGNAL		                (1ULL << 1)
 /* clang-format on*/
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index eb01d0fb2165..fa28f9236407 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -26,7 +26,7 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
-#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_SIGNAL
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 /* clang-format on */
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 7e8579ebae83..a73cff27bb91 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -261,11 +261,54 @@ static int hook_unix_may_send(struct socket *const sock,
 	return -EPERM;
 }
 
+static int hook_task_kill(struct task_struct *const p,
+			  struct kernel_siginfo *const info, const int sig,
+			  const struct cred *const cred)
+{
+	bool is_scoped;
+	const struct landlock_ruleset *target_dom;
+
+	/* rcu is already locked */
+	target_dom = landlock_get_task_domain(p);
+	if (cred)
+		/* dealing with USB IO */
+		is_scoped = domain_IPC_scope(landlock_cred(cred)->domain,
+					     target_dom,
+					     LANDLOCK_SCOPED_SIGNAL);
+	else
+		is_scoped = domain_IPC_scope(landlock_get_current_domain(),
+					     target_dom,
+					     LANDLOCK_SCOPED_SIGNAL);
+	if (is_scoped)
+		return 0;
+
+	return -EPERM;
+}
+
+static int hook_file_send_sigiotask(struct task_struct *tsk,
+				    struct fown_struct *fown, int signum)
+{
+	bool is_scoped;
+	const struct landlock_ruleset *dom, *target_dom;
+	struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
+
+	/* rcu is already locked! */
+	dom = landlock_get_task_domain(result);
+	target_dom = landlock_get_task_domain(tsk);
+	is_scoped = domain_IPC_scope(dom, target_dom, LANDLOCK_SCOPED_SIGNAL);
+	put_task_struct(result);
+	if (is_scoped)
+		return 0;
+	return -EPERM;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
 	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
 	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
+	LSM_HOOK_INIT(task_kill, hook_task_kill),
+	LSM_HOOK_INIT(file_send_sigiotask, hook_file_send_sigiotask),
 };
 
 __init void landlock_add_task_hooks(void)
-- 
2.34.1


