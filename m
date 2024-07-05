Return-Path: <netdev+bounces-109572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E830F928EC1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C9B1C21AE0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B413F42A;
	Fri,  5 Jul 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1qHhH0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B361C693;
	Fri,  5 Jul 2024 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214558; cv=none; b=eDzVPCXXdSjYIenbP9HsxoDFMe0b6vnH85SjlXbLq2dIvalFbTsqaomKwQnrPjcKhTPmZyy2AT6CLtWLMs62z3YG2ROBz0MTQ6VSbwWsXO1iH2BG4b6UqYKrRZaT/g8yffbuwzdC+XvBF/v6kvw5YSOEVoAAV/mQtvkTWF5ORvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214558; c=relaxed/simple;
	bh=LP9JoMyO4RZYpmRyEi7/n2mZtToGbzb3V52WgLGytew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qDYDeWepcT7GJ0BeG2qaGkll6ou6L6iSvSQJ3+zAEuxS28wkkjoXatl/+Uc6KqY5PE3SNTxgQn+FFpTdpNzbNMTsBBn+XS4nXG3CfDoa2j1tu1iiZ/RvTjB1JrtwBFIAmj7yShbRDpOmPbdZ58pQybweqU6uHKfxk6twtxUQ8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1qHhH0u; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e43dda1edso644470fac.0;
        Fri, 05 Jul 2024 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720214556; x=1720819356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IhT7MF8kH57E/SnoiAkldNxZCcRzmTR9RjNaE8Yyeo=;
        b=I1qHhH0uLKZ5F0k9bmajmlCV+v5Wi7S8+tx7cD8A8grJb/xnqs53YbPnrnnqdJCo6L
         RmlRSs/fkfzxHG0XrtwcKp2LYuEVQyz1pw0khkv9I4N2MlIzAMu7HQi+ggzSpo+20bOz
         1YKV0b7cA9sam0tri7U4ydbb5ZWQY3jAZNdglPZjrrUnOK+CJZT3/bV7tfyST/2ipCgC
         vtiEfuMCib0GNh4TVkku9NOUR/ptKOM5VOnawVsRLqICCeiiV+6egL8tHGZNjpwGRVbt
         KappanQjz/tTokntALxh2t2b4x/9cBucJZxMzfCk3QeokpteHYW5lB9epSW4nHsE6DAa
         /1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720214556; x=1720819356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IhT7MF8kH57E/SnoiAkldNxZCcRzmTR9RjNaE8Yyeo=;
        b=kcQnHQhgHjRotjN1JENCg6sXBYeIpUCPmo47nwXMmHE6gwUQsI/0FHRHmiPHArBVvI
         auUI0FZFUtUK5/CXWwOa61cHzhsBJulNlsuChsMiMUr2QFH8jIe4A+Ke+D8DASp3sA/N
         2Mue0yexDa/fZU0DgskfWv5aXIsYI9UbFWrpyLRAVESC0Ge3qKY44HCz0vs7UoAJvigj
         PvNuIakdj2kmblpjulNYynHIm4Gm8SS6MkrDigXgpKos2RZBosHyaW/kLN0ouQZ5qOLY
         LKXwRya5GROXyZ0PxgGmn11Xp6wZBaxOJKsfLkltUlmIQ+2MB4FY8o5vyyR4YUp8TNxl
         hh5w==
X-Forwarded-Encrypted: i=1; AJvYcCVKDCMuwE6KcyUne5ElmtWn0Kapa0fYIn8uuo5OByqU8WRnnz7Y1HvEhWjhSXqdvclzgtaU3heJvwwSvG0FTFH1jyp/oGmI5Jj1F5ypqLwAgy1Sj1/uedRMAtpxkcbfGqxeVHtIpk6QTjGEjMTW6+dGMKcrdL+byQXBj9SCBSJcjRGIL80gI5Io5Cqk
X-Gm-Message-State: AOJu0Ywlq+vea0gqPWKHthYO2mqMUCizPy39BkO2HWlw9sRQuLZMhRSJ
	1zGi5fTcuJRxPtKIZWrwQChjdtnlwKbUlC6OIlvosjD2UEUMOKXn
X-Google-Smtp-Source: AGHT+IEeLwgtXYb/uj8sDcO09wT71NkvpSBq/jo4Esw2OxgX+mlE6v9Dh2n5HNVFAIktMgSFbTyp7A==
X-Received: by 2002:a05:6870:63a6:b0:25e:1659:4ce9 with SMTP id 586e51a60fabf-25e2b5a06admr4612401fac.0.1720214555903;
        Fri, 05 Jul 2024 14:22:35 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802566511sm14507529b3a.75.2024.07.05.14.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:22:35 -0700 (PDT)
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
Subject: [PATCH v1 1/2] Landlock: Add signal control
Date: Fri,  5 Jul 2024 15:21:42 -0600
Message-Id: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
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
scoped the same way abstract unix sockets are scoped.

The same way as abstract unix socket, we extend "scoped" field
in a ruleset with "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset
will deny sending any signal from within a sandbox process to its
parent(i.e. any parent sandbox or non-sandboxed procsses).

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 include/uapi/linux/landlock.h |  3 +++
 security/landlock/limits.h    |  2 +-
 security/landlock/task.c      | 49 +++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 010aaca5b05a..878479a1b9dd 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -291,8 +291,11 @@ struct landlock_net_port_attr {
  *   from connecting to an abstract unix socket created by a process
  *   outside the related Landlock domain (e.g. a parent domain or a process
  *   which is not sandboxed).
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
index acc6e0fbc111..caee485b97b2 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -168,11 +168,60 @@ static int hook_unix_may_send(struct socket *const sock,
 	return -EPERM;
 }
 
+static bool signal_is_scoped(const struct landlock_ruleset *const sender_dom,
+			     struct task_struct *const target)
+{
+	const struct landlock_ruleset *target_dom =
+		landlock_get_task_domain(target);
+
+	/* quick return if there is no domain or .scoped is not set */
+	if (!sender_dom || !get_scoped_accesses(sender_dom))
+		return true;
+
+	if (!target_dom || !get_scoped_accesses(target_dom))
+		return false;
+
+	/* other is scoped, they connect if they are in the same domain */
+	return domain_scope_le(sender_dom, target_dom);
+}
+
+static int hook_task_kill(struct task_struct *const p,
+			  struct kernel_siginfo *const info, const int sig,
+			  const struct cred *const cred)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	bool ret = false;
+
+	if (!cred)
+		ret = signal_is_scoped(dom, p);
+	else
+		ret = signal_is_scoped(landlock_cred(cred)->domain, p);
+	if (ret)
+		return 0;
+	return EPERM;
+}
+
+static int hook_file_send_sigiotask(struct task_struct *tsk,
+				    struct fown_struct *fown, int signum)
+{
+	const struct task_struct *result =
+		get_pid_task(fown->pid, fown->pid_type);
+
+	const struct landlock_ruleset *const dom =
+		landlock_get_task_domain(result);
+	if (signal_is_scoped(dom, tsk))
+		return 0;
+	return EPERM;
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


