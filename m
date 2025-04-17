Return-Path: <netdev+bounces-183555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E2A91027
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40151905D57
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58021922FB;
	Thu, 17 Apr 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ev6SCRPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF335972
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849220; cv=none; b=aT62ljZ56Yhm0jd4DOaGilLM/pzxZvqhInAGA1PioTO63zagKJQfckZ0NPTl3sas0J63z2qUwvt00gAHEvvLxYu1jTipMmLcOhxyDyN9DZP8CURpfGCaE62z75A/Q+1ko9eYfHhl3bHdTRJyFLe6LEXJZt17a28fZJMcXRwFmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849220; c=relaxed/simple;
	bh=Xn0fhZah7VNoPSuth3cgN/5HbXDJG8TMVcqhWqJBa5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSo+at2acycB8HHCQwm96/DoiQvKoJyf85uLIEeFzo8LYIesRrO5MX8DBhYcuoh2UuJXDSZ2qIj63OvAwdxZkbTWpRse/cYVVIJjDCgyhUgW91Atac8gqhk75GP/tFOwHHDDVNuc/s7+iw4jAOtQaACnHdNDPfYz+K0HizYUs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ev6SCRPW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-aee79a0f192so102716a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744849217; x=1745454017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p53AigewFBsQmQbaVqLDW/4G17Cug0mvmUxIn4ebZoc=;
        b=ev6SCRPW5IDRwKA3f4otld0MqAVnhpehg8ZRX/H/ecVikSm5TxsCSQpORlo4/3W5jJ
         nb36KCOPVV1w6DRDhDWIftZfNPNxLWgJ730iFXnMbpK3IpenbgXNeHIe7uN7NMCSojwU
         ploYl4Q2nbzHNtsYsdwvskVHDgNfj55FnlzDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849217; x=1745454017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p53AigewFBsQmQbaVqLDW/4G17Cug0mvmUxIn4ebZoc=;
        b=rXNyBmugXKQd1YR6woB3l1Ha5rHZOOhZlz4j9NUwhG1tbtZmYcGGP0Om1KnoFgpA98
         YQmGd4lVmK1cTuLAcQBFPEFzI1gSQqsotVtu2Wqx/gwqFvL8USd2ElGisEB5FKCsRSrq
         63Fu9m90CdFYlYyakfYVWHy0J3qGG07amhncBpjS7AV5efMPUYAmwM1DNcg4+1WksFsu
         Gqj1zwOGsbQnyAXUZh4lWMmV4mkL2VCmgZIruSoezZLDpNMWCWo9l6W8l/Xv9qPmZFnq
         C5iqM4Dzo+u21LJb2TXg9BqgFdw//i8VfyFMfV7e/YkMoSqoeqmSvMVJEtki2G1Mu7aP
         3B2w==
X-Forwarded-Encrypted: i=1; AJvYcCXxI1xOUbJKZJ3d1vvs3ZMURwRyeEQuq4F74k+82Yf1M96lq7ZekMqlgd7R4Hz88WZXssDqRF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYyqeqj02mnP4tTFJO+S3N95fpA28bPWLfewvEFfzHPPPONtu
	bBEajRQQOx9VOaSM2Idp40CnxoVqeTkix9BxB58LOzcXgE4a60ddfkLuDStbRg==
X-Gm-Gg: ASbGnctKD6Yv0y1OIf6zHpz0voNqFT4tiTBjeIIpTshtT9XYDHcjkzqm2zClkVF79Yb
	7lwh0VE6trvjzuf7B4sq9DnEabrHTpO5UhLjU9obDtvpkBWFuj06+6wWJcSHF2IDFEpRPzYOPyt
	wj97+yM6KrO2A4K+CdRkx36uKNXaHEyPBurY6+ic2jPT1ASjC5yR9rhPyuj1fTCh8JrtyUVKrAu
	+MKwYsXcK7llvIWLGuizWvxvjNUtYg8q1Qrh5urTTEwdTgBp+fEurPh4j1VUmpEaDYBrtF6+3ig
	M4e7p9cDPlNy+2Cn3C+1vUgtHBYsXAMgJhpcwWjdSaycDo7FE8/wj82awmvFSSKBg1kqr0DOcff
	q7cyQTwBPPey2B83JL2Es2AtcS8Y5faeg
X-Google-Smtp-Source: AGHT+IGNOO4PihoQLJC4VWdU+RdzRjOAKlmBvKQqMIYr7rV7iQC39qD2+3dZngycgcfs6Xuy7d4Cjg==
X-Received: by 2002:a17:902:f686:b0:223:42ca:10ef with SMTP id d9443c01a7336-22c35984391mr59251915ad.43.1744849217023;
        Wed, 16 Apr 2025 17:20:17 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd87sm20719205ad.73.2025.04.16.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:20:16 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH RESEND v17 1/3] lsm, selinux: Add setup_report permission to binder
Date: Wed, 16 Apr 2025 17:20:02 -0700
Message-ID: <20250417002005.2306284-2-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250417002005.2306284-1-dualli@chromium.org>
References: <20250417002005.2306284-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thiébaud Weksteen <tweek@google.com>

Introduce a new permission "setup_report" to the "binder" class.
This persmission controls the ability to set up the binder generic
netlink driver to report certain binder transactions.

Signed-off-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: Li Li <dualli@google.com>
---
 include/linux/lsm_hook_defs.h       |  1 +
 include/linux/security.h            |  6 ++++++
 security/security.c                 | 13 +++++++++++++
 security/selinux/hooks.c            |  7 +++++++
 security/selinux/include/classmap.h |  3 ++-
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..795a507db537 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -33,6 +33,7 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 	 const struct cred *to, const struct file *file)
+LSM_HOOK(int, 0, binder_setup_report, const struct cred *to)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..fe600fb37c98 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,7 @@ int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file);
+int security_binder_setup_report(const struct cred *to);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(const struct task_struct *target,
@@ -657,6 +658,11 @@ static inline int security_binder_transfer_file(const struct cred *from,
 	return 0;
 }
 
+static inline int security_binder_setup_report(const struct cred *to)
+{
+	return 0;
+}
+
 static inline int security_ptrace_access_check(struct task_struct *child,
 					     unsigned int mode)
 {
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..5acf364e610f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1043,6 +1043,19 @@ int security_binder_transfer_file(const struct cred *from,
 	return call_int_hook(binder_transfer_file, from, to, file);
 }
 
+/**
+ * security_binder_setup_report() - Check if binder report is allowed
+ * @to: receiving process
+ *
+ * Check whether @to is allowed to set up binder reports.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_binder_setup_report(const struct cred *to)
+{
+	return call_int_hook(binder_setup_report, to);
+}
+
 /**
  * security_ptrace_access_check() - Check if tracing is allowed
  * @child: target process
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..f02249345c4b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2103,6 +2103,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
 			    &ad);
 }
 
+static int selinux_binder_setup_report(const struct cred *to)
+{
+	return avc_has_perm(current_sid(), cred_sid(to), SECCLASS_BINDER,
+			    BINDER__SETUP_REPORT, NULL);
+}
+
 static int selinux_ptrace_access_check(struct task_struct *child,
 				       unsigned int mode)
 {
@@ -7295,6 +7301,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
 	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
+	LSM_HOOK_INIT(binder_setup_report, selinux_binder_setup_report),
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 5665aa5e7853..de7e28572fda 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -133,7 +133,8 @@ const struct security_class_mapping secclass_map[] = {
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket", { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder",
-	  { "impersonate", "call", "set_context_mgr", "transfer", NULL } },
+	  { "impersonate", "call", "set_context_mgr", "transfer",
+	    "setup_report", NULL } },
 	{ "cap_userns", { COMMON_CAP_PERMS, NULL } },
 	{ "cap2_userns", { COMMON_CAP2_PERMS, NULL } },
 	{ "sctp_socket",
-- 
2.49.0.805.g082f7c87e0-goog


