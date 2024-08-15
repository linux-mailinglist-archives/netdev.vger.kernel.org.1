Return-Path: <netdev+bounces-118947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17F953A11
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB2C1F27F09
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3FB149E04;
	Thu, 15 Aug 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwNxk5CS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AAD6BB39;
	Thu, 15 Aug 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746585; cv=none; b=MHuU3CZeB/qpyYjBG9SjZ4VU1BrPR+o9ILrPpQYcHT25/eGxLb1BJLS7w/7szJtPNITWra5aIvw6QoU31x5PaK2HnarRP7vO/Drf+oxZ0srSCkSpCGRLG4nhBtqANbuRE0bQEyFiL9C7+1DvxHg9QRwm8axyM+dQv4Luyem0Wks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746585; c=relaxed/simple;
	bh=pyMDbJEkeHk8R9DbMoH1r7F2+FNdwN+iRME2gRIAoow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWg/kI3p3GzjE4Veaz+H/xgDlgXDSzJ/r/VgMHec/yqZMf/9oMJm9jtMVB/skvFQQGKvOATyWIIpMO9pSXiCIU6S2mQM3eXKwnNngfE7eZHENoHIBEe38VagYhmXPLN+hxO/nPXXMLV89UmyrLa1uaXBBWJ+bsPIW/hnzGq7cgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwNxk5CS; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-267b7ef154aso872156fac.0;
        Thu, 15 Aug 2024 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746582; x=1724351382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUX3KBZEFkw5RXQprlB2HPDzZGb1r+bt8dz2QI2bV6M=;
        b=mwNxk5CSnFAGXbCZ0tMss8ALLPPYhc+UFyJBMElwF/1MqTacxTX8Bphap/UmPGJ9YI
         PQAQ9o+XfMi3o628PTAh2keJESC7x3Deb1d6oADZ7+IkZnQKxSgu4nRM/HY+VxpX5mWV
         pBnl6XWM891Eevdbi8kB8YMmkI9fr4PlmBc/TDq4oE+Cc/D0Qv0+gJH8vlkG/u3aN00F
         52pwRPiaPR+UMXwEUA6CMhIrDH67OgiPlGkE52xAHqSZ6ubsMT8Cxj+MokaCbzOUki7R
         nSaO0P1GVKeDoZKFIaljniTVC5U45pXH2I38sbLST0ueQQmZHA1ZNivX2fasEBOKSxwi
         uOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746582; x=1724351382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUX3KBZEFkw5RXQprlB2HPDzZGb1r+bt8dz2QI2bV6M=;
        b=eVku1aYtYV+oRg9vxjqrNPo+v7WmXkcVUPAqooggHd4WBNGIqdl5RirIHpQHYrknxg
         6we8zQbBragJg+gEj4FRjCt9g1od+dkt2sYsuUlpTPjXxRfOQ6UNvOHFfSImtVBhsRzA
         GinOmbiJvns8wicvgMCFzx6WsD+zSLJTRLewR5k4BXZ4II/tCOo2VGR4BZQ9K5bFVQ81
         fHfVI8iUAG7cshNsq5bVMX6jmgMUcoz/IefaIt+7h7sOnAsWp+PaOkgqQn7KN0api+1S
         AvowI4+OX/RyfqmnVKriA0pNEz8kATjgQBL0Wu7zYEx/BFq9+ynv8wwd864xxeK9wX+r
         BPaA==
X-Forwarded-Encrypted: i=1; AJvYcCW98nXMtrcQ6re98o+s8Y++UccmtefddMu1JDjscO1HKRfo+0IdQFMMEkUJ2o39XyF1NGU2+vTfgWYyOzw=@vger.kernel.org, AJvYcCXD7/TKCcIw9ipO8uPrd76Ii2soG7hY2WeBgq5jceFUVJhyW6vG+AkSwCW+FkjCNULIsU0YH1EO@vger.kernel.org, AJvYcCXHgsKfRLa9LpuNVesJ+MOAG3jbbrnBNfFQq1MHzxCfT2tQ68FZdTFFfLQ6Au+LN0tFUTOF96ijXilFDjnJtiMRCUjVpxi0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BphBAh0r4gjeHoUppIeG3wcWwCfEMBC3MoezpyGNDkj38TsN
	tx/j25TyEo2UP6IaSXwbvHXKkzXcfxDx8V8uCqnroyW2gQfM2ppN
X-Google-Smtp-Source: AGHT+IFWKAv9Y1UB3KvWGlEprYvpy8wudpEmm7LfQhIiqE8T0gu8Qko7xbjvNFsp6hO+u5Cxy/Dnfg==
X-Received: by 2002:a05:6870:f14b:b0:270:1352:6c16 with SMTP id 586e51a60fabf-2701c54a2d2mr482561fac.34.1723746582540;
        Thu, 15 Aug 2024 11:29:42 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c76sm1431683a12.62.2024.08.15.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:29:42 -0700 (PDT)
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
Subject: [PATCH v3 1/6] Landlock: Add signal control
Date: Thu, 15 Aug 2024 12:29:20 -0600
Message-Id: <1d88b431c872f6513a6eafa866a4c9c896d6709d.1723680305.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723680305.git.fahimitahera@gmail.com>
References: <cover.1723680305.git.fahimitahera@gmail.com>
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
Changes in versions:
V3:
* Moving file_send_sigiotask to another patch.
* Minor code refactoring.
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
 security/landlock/task.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 057a4811ed06..46301b47f502 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -289,8 +289,11 @@ struct landlock_net_port_attr {
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
index a461923c0571..9de96a5005c4 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -235,11 +235,38 @@ static int hook_unix_may_send(struct socket *const sock,
 	return 0;
 }
 
+static int hook_task_kill(struct task_struct *const p,
+			  struct kernel_siginfo *const info, const int sig,
+			  const struct cred *const cred)
+{
+	bool is_scoped;
+	const struct landlock_ruleset *target_dom, *dom;
+
+	dom = landlock_get_current_domain();
+	rcu_read_lock();
+	target_dom = landlock_get_task_domain(p);
+	if (cred)
+		/* dealing with USB IO */
+		is_scoped = domain_is_scoped(landlock_cred(cred)->domain,
+					     target_dom,
+					     LANDLOCK_SCOPED_SIGNAL);
+	else
+		is_scoped = (!dom) ? false :
+				     domain_is_scoped(dom, target_dom,
+						      LANDLOCK_SCOPED_SIGNAL);
+	rcu_read_unlock();
+	if (is_scoped)
+		return -EPERM;
+
+	return 0;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
 	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
 	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
+	LSM_HOOK_INIT(task_kill, hook_task_kill),
 };
 
 __init void landlock_add_task_hooks(void)
-- 
2.34.1


