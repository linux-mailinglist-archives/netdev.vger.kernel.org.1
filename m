Return-Path: <netdev+bounces-101593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7683D8FF846
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871501C21E9B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4E13E404;
	Thu,  6 Jun 2024 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ9RRygR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77713DDA0;
	Thu,  6 Jun 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717491; cv=none; b=FYNhSfcE48diDXvyybmrxYx3f72m8CoAzK0Tf8u2sQKbi0iXnEPMf4OuobR2wlddjD2heAo9aKESnCP/iL2iY4AvmQ5jeDQ17eidFj+bolqAWSmPrrH6x3APLs5/mAUe2ChVpKnIlEMBZbbXP0Np3tXFU867NDS4pN1AOOOuQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717491; c=relaxed/simple;
	bh=iamb/rLFkUYOh3f2W+ds/fFDPpASdaMufVXcS3wVDaE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y2Tmc+YHHvwtK9lZoXilMuPi+KkZg0MFOsEMOuksnnR5f/Bbx7ZPB0qqGBeimj/YJSjh47xNmpKfeUoInKRElw5kXhippkSCKO4qSOvAwsvsBHlyGo51gNIUiulrwztGmWr0lMYr8AhurTxG36dbz4faTyC+3liTEInsDSp9T0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ9RRygR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c29c487a94so1096463a91.1;
        Thu, 06 Jun 2024 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717717489; x=1718322289; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jcgbh93vnYAHc6vnLN6+nek2BGC8VoPNOv53hEOb+aQ=;
        b=UZ9RRygRm+vIaSi3rx14zG2v2XLeQsN+AJ0jmX68dr4/tyBga6/gaI2fZD3189hflR
         zI1mSCIyuoHsznwfxiIK8prZkFpz9t8In6uArKLcN4Fy8Eq10COXRbCLYIgmUmPzfJGE
         ciMLGMt0Rox5OluzGrNIVIKPnZw6VtL/VaeRw6oztz5WLOMshsEsrxkkN9wIGcKLrTxI
         q2Rolj/sKD3ZowZV+dqo3Mrajyn9vbsN6zOXOBvoAs4kcPgsFgcUD3FH/qJAmdhAYJnu
         kcIN+sNsxVdF7xrixbVQ5YTzTd6gSPPuvnyY7OQeQfK1bjM6FYLzxAG71PE/HQMl2PxJ
         opMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717717489; x=1718322289;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcgbh93vnYAHc6vnLN6+nek2BGC8VoPNOv53hEOb+aQ=;
        b=TbBdQLbOt/w94CZdKRIwF6UU2RI0vcQzYGE+o+YT/1JD37gpQbC6rsmuvF6Yspp92l
         9XbGd2btfZsBsqL61LVAKUv2hIJDk2FbYg5RDERtTARQ3u7u54mfpVtVPuuFNI4vnWBX
         NTzWVxRD1J6/M6djx9AZLQIT7nzrYW+RqhHF4sUbMb2/HB2/uw4P1mmbtWBK6xkOlcBB
         GOe+lRG2rx9tt393Tk0oqMziIT05cuDNih/L8uT0TQl/Zvnm6JqtrPDp3r/M3TKhCCCJ
         UBCoKwb1JukI+cP8yuQxW7L/1A0aMe0AI13wVGBp6hFKhtcAjJgso1k5Da5IxBsbtznY
         OdlA==
X-Forwarded-Encrypted: i=1; AJvYcCVBUOS7qNhtXWubKy4KS17KVoUzmhGh77mSEaWIx3JZTCcHsltW8Odj3kNsP9KZWKJBaMcOP+1OK8RjR48QB20PolA/3kcDPjkn9r19Sxg7yy7U30AGImZTLAoDH82X1v7WxjwtksGGHHzv8apC6rI5IbSK2R0gaj6KDmgVRPvtin3p4Uh6YYtMe3nd
X-Gm-Message-State: AOJu0Yyl7G63k2xMoyCu7giCixT//v24WGqVEI6VL2KYr/eQh5GekiuO
	7h8ioxgI5bTxzXKx6IlG1w8cUWmlWQnqcuRR9G23M0OfLplG5acR
X-Google-Smtp-Source: AGHT+IGafla7J4D8SbDeMtxKagI7bixG8s8JsXU2Yf/SswjKIDwe1QjnnKX67kGmkXlOFFijZ56qww==
X-Received: by 2002:a17:90a:8402:b0:2c2:5a29:9bb5 with SMTP id 98e67ed59e1d1-2c2bcacce7cmr964934a91.5.1717717489420;
        Thu, 06 Jun 2024 16:44:49 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067a208sm4161906a91.27.2024.06.06.16.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:44:48 -0700 (PDT)
Date: Thu, 6 Jun 2024 17:44:46 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, outreachy@lists.linux.dev,
	Jann Horn <jannh@google.com>, netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Abstract unix sockets are used for local inter-process communications
without on a filesystem. Currently a sandboxed process can connect to a
socket outside of the sandboxed environment, since landlock has no
restriction for connecting to a unix socket in the abstract namespace.
Access to such sockets for a sandboxed process should be scoped the same
way ptrace is limited.

Because of compatibility reasons and since landlock should be flexible,
we extend the user space interface by adding a new "scoped" field. This
field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
specify that the ruleset will deny any connection from within the
sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)

Closes: https://github.com/landlock-lsm/linux/issues/7
Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

-------
V3: Added "scoped" field to landlock_ruleset_attr
V2: Remove wrapper functions

-------
---
 include/uapi/linux/landlock.h | 28 +++++++++++++++++++++++
 security/landlock/limits.h    |  5 ++++
 security/landlock/ruleset.c   | 15 ++++++++----
 security/landlock/ruleset.h   | 28 +++++++++++++++++++++--
 security/landlock/syscalls.c  | 12 +++++++---
 security/landlock/task.c      | 43 +++++++++++++++++++++++++++++++++++
 6 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..d887e67dc0ed 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
 	 * rule explicitly allow them.
 	 */
 	__u64 handled_access_net;
+	/**
+	 * scoped: Bitmask of actions (cf. `Scope access flags`_)
+	 * that is handled by this ruleset and should be permitted
+	 * by default if no rule explicitly deny them.
+	 */
+	__u64 scoped;
 };
 
 /*
@@ -266,4 +272,26 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 /* clang-format on */
+
+/**
+ * DOC: scoped
+ *
+ * Scoped handles a set of restrictions on kernel IPCs.
+ *
+ * Scope access flags
+ * ~~~~~~~~~~~~~~~~~~~~
+ * 
+ * These flags enable to restrict a sandboxed process from a set of
+ * inter-process communications actions. Setting a flag in a landlock
+ * domain will isolate the Landlock domain to forbid connections
+ * to resources outside the domain.
+ *
+ * IPCs with scoped actions:
+ * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process to
+ *   connect to a process outside of the sandbox domain through abstract
+ *   unix sockets. 
+ */
+/* clang-format off */
+#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
+/* clang-format on*/
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 20fdb5ff3514..7b794b81ef05 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -28,6 +28,11 @@
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 #define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
 
+#define LANDLOCK_LAST_ACCESS_SCOPE       LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+#define LANDLOCK_MASK_ACCESS_SCOPE	((LANDLOCK_LAST_ACCESS_SCOPE << 1) - 1)
+#define LANDLOCK_NUM_ACCESS_SCOPE         __const_hweight64(LANDLOCK_MASK_ACCESS_SCOPE)
+#define LANDLOCK_SHIFT_ACCESS_SCOPE      LANDLOCK_SHIFT_ACCESS_NET
+
 /* clang-format on */
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index e0a5fbf9201a..635d0854be09 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -52,12 +52,13 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t fs_access_mask,
-			const access_mask_t net_access_mask)
+			const access_mask_t net_access_mask,
+			const access_mask_t scope_mask)
 {
 	struct landlock_ruleset *new_ruleset;
 
 	/* Informs about useless ruleset. */
-	if (!fs_access_mask && !net_access_mask)
+	if (!fs_access_mask && !net_access_mask && !scope_mask)
 		return ERR_PTR(-ENOMSG);
 	new_ruleset = create_ruleset(1);
 	if (IS_ERR(new_ruleset))
@@ -66,6 +67,8 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
 	if (net_access_mask)
 		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
+	if (scope_mask)
+		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
 	return new_ruleset;
 }
 
@@ -173,9 +176,11 @@ static void build_check_ruleset(void)
 
 	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
 	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
-	BUILD_BUG_ON(access_masks <
-		     ((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
-		      (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET)));
+	BUILD_BUG_ON(
+		access_masks <
+		((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
+		 (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET) |
+		 (LANDLOCK_MASK_ACCESS_SCOPE << LANDLOCK_SHIFT_ACCESS_SCOPE)));
 }
 
 /**
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c7f1526784fd..b633d1b66452 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -35,6 +35,8 @@ typedef u16 access_mask_t;
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 /* Makes sure all network access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
+/* Makes sure all scoped rights can be stored*/
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_SCOPE);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
@@ -42,7 +44,8 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 typedef u32 access_masks_t;
 /* Makes sure all ruleset access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_masks_t) >=
-	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET);
+	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET +
+		      LANDLOCK_NUM_ACCESS_SCOPE);
 
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
@@ -233,7 +236,8 @@ struct landlock_ruleset {
 
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t access_mask_fs,
-			const access_mask_t access_mask_net);
+			const access_mask_t access_mask_net,
+			const access_mask_t scope_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
@@ -282,6 +286,17 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 		(net_mask << LANDLOCK_SHIFT_ACCESS_NET);
 }
 
+static inline void
+landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
+			const access_mask_t scope_mask, const u16 layer_level)
+{
+	access_mask_t scoped_mask = scope_mask & LANDLOCK_MASK_ACCESS_SCOPE;
+
+	WARN_ON_ONCE(scope_mask != scoped_mask);
+	ruleset->access_masks[layer_level] |=
+		(scoped_mask << LANDLOCK_SHIFT_ACCESS_SCOPE);
+}
+
 static inline access_mask_t
 landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
 				const u16 layer_level)
@@ -309,6 +324,15 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
 	       LANDLOCK_MASK_ACCESS_NET;
 }
 
+static inline access_mask_t
+landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
+			const u16 layer_level)
+{
+	return (ruleset->access_masks[layer_level] >>
+		LANDLOCK_SHIFT_ACCESS_SCOPE) &
+	       LANDLOCK_MASK_ACCESS_SCOPE;
+}
+
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 03b470f5a85a..e95e79752be0 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -97,8 +97,9 @@ static void build_check_abi(void)
 	 */
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
 	ruleset_size += sizeof(ruleset_attr.handled_access_net);
+	ruleset_size += sizeof(ruleset_attr.scoped);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
 
 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
@@ -170,7 +171,7 @@ static const struct file_operations ruleset_fops = {
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: unknown @flags, or unknown access, or too small @size;
+ * - %EINVAL: unknown @flags, or unknown access, or uknown scope, or too small @size;
  * - %E2BIG or %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
  */
@@ -212,10 +213,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if ((ruleset_attr.handled_access_net | LANDLOCK_MASK_ACCESS_NET) !=
 	    LANDLOCK_MASK_ACCESS_NET)
 		return -EINVAL;
+	/* Checks IPC scoping content (and 32-bits cast). */
+	if ((ruleset_attr.scoped | LANDLOCK_MASK_ACCESS_SCOPE) !=
+	    LANDLOCK_MASK_ACCESS_SCOPE)
+		return -EINVAL;
 
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
-					  ruleset_attr.handled_access_net);
+					  ruleset_attr.handled_access_net,
+					  ruleset_attr.scoped);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 849f5123610b..147c6545ef24 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -13,6 +13,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <net/sock.h>
+#include <net/af_unix.h>
 
 #include "common.h"
 #include "cred.h"
@@ -108,9 +110,50 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return task_ptrace(parent, current);
 }
 
+static bool sock_is_scoped(struct sock *const other)
+{
+	bool is_scoped = true;
+	const struct landlock_ruleset *dom_other;
+	const struct cred *cred_other;
+
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	if (!dom)
+		return true;
+
+	lockdep_assert_held(&unix_sk(other)->lock);
+	/* the credentials will not change */
+	cred_other = get_cred(other->sk_peer_cred);
+	dom_other = landlock_cred(cred_other)->domain;
+	is_scoped = domain_scope_le(dom, dom_other);
+	put_cred(cred_other);
+	return is_scoped;
+}
+
+static int hook_unix_stream_connect(struct sock *const sock,
+				    struct sock *const other,
+				    struct sock *const newsk)
+{
+	if (sock_is_scoped(other))
+		return 0;
+
+	return -EPERM;
+}
+
+static int hook_unix_may_send(struct socket *const sock,
+			      struct socket *const other)
+{
+	if (sock_is_scoped(other->sk))
+		return 0;
+
+	return -EPERM;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
+	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
+	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
 };
 
 __init void landlock_add_task_hooks(void)
-- 
2.34.1


