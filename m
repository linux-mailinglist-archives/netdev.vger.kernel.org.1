Return-Path: <netdev+bounces-107487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A83C91B2B7
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A412E1F21848
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44621A2FA4;
	Thu, 27 Jun 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYkUzCgV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7561A2C05;
	Thu, 27 Jun 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531022; cv=none; b=X1AGSyVRURS24W2BTiDD72snXeN7cXfdk9O9Xr2C76NLeHHtQkTM3Zs/B1XHIbgH/yMcWAnCmV5pv4pi9j9vHT5+pRUUJMH0wK6PNcf45tx8aKLCoGfe3BQFROluUDXLM2DNqHOjewDLzWHyreCn4S0QmhRi38IyxT/WPf+Fc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531022; c=relaxed/simple;
	bh=JJ/ZoDuSy3o4rOeT+Eem/VuBkYdBc5Trt14VP6B8uS8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HqnlQaBIQtCwvXQsDwQiyR1U0EkxDlLZiFUfJMP2LdGspczECF743AVHJmtGXLYI3R8qp75FNLQqKj8xQ8Ori7POgQmmniP43EXul+1KXfaxZjEV8bXysOA5FDxoleTIQnzZfmm9PENFj6iE2zDgEmYDDxE3zWF7dKvHTJiGpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYkUzCgV; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d55db7863bso42290b6e.1;
        Thu, 27 Jun 2024 16:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719531020; x=1720135820; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNKrojDX5CsZI87yJ6lho8LHM4SYaPNMJxO7Q0SV3Nw=;
        b=HYkUzCgV7ffHXJiPtWlPTCw0hGVvZjsnIp5r1Nfq3fHq8+mYIzNVMtrXtzmEOY1uVR
         P6yeaJqrXtjdSF7PE5BnwFgBJdpO5ODpmvUtjP+IxkppgC1RfcCmLx8MM32HIDoLDeZt
         aJEvDXLp6a/81VSIwqcibDh1SqFjlAfYAt3HTUTQ0rDWZJ1P8vvlgZApdi7qw7rImb2s
         20c8N7ABHHC4tQKj/YwkBNz2pRD9Dk+bLA67JV9LpcP+AKYdziuUNVWBPKxEk6yScU6E
         oVUU9+8CHzGNEdgF2sVIQ1qWnC+5izY5PEK2A5tNGuKgSW3dtSP57KxXQ8M7RQ0MZ7sA
         92KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719531020; x=1720135820;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNKrojDX5CsZI87yJ6lho8LHM4SYaPNMJxO7Q0SV3Nw=;
        b=pg/Ixm+dyyFrnzwOcjg/ldv6lvMdubkYA0Ld94540zklTOnjHvZS+Ot9biXZZNvsoU
         xXEzlBqt1lXgs4QnrUFy1kCkTZOk28712lFqvYZ77HUgX6jBmNjshK16wOAgXBaC2a3+
         YHr0sHDaUd3LDSKwdkvLr/uPhbf9kfyi7f1wQ6+SZt7/NDRnUPFGWDLa6uXPsuRrGgCK
         J4eeAXoewO9CVr8LJr5qIc2l3Cpi/bYCww210D3zqtAQ8zg0QXkpN8Tnvarf6tDL4Uao
         RNZISbQbz8xuChfZBGmr9myP7gKajoEd5Zazvsq8vBXBxgkMiVyQ20EC6vkobTuQKEms
         Dguw==
X-Forwarded-Encrypted: i=1; AJvYcCW6D/l+1KKXNgtliW7hOoBIfE2eCIoVAh50Xid/r0m+hQeMmub0Ppic/sh4KJRexDQgjEYn8qwEQoPSsaiS12DH0a33dB7p4u05rBr+xc62xEZrVxCGQD1aICWQdBNSpS3JOFDgX6UHN4KuR1E0gr8h92juuS9ROqFlufLgntI/6QLsGbKfZynv9wjt
X-Gm-Message-State: AOJu0Yy/WNbRqQi1PHSIMQ+6Jcp30PhvAMHuh0n/khgG5bk8FslnDg4z
	+Gw+w+QyOFoN790LK2y3/DuSFz5hhkscx5w61rYnvJKNA0IGNUxnc9T3fW1p
X-Google-Smtp-Source: AGHT+IFKBg5noHKXAYehZ33Ug2aqfC4PR2z0q9ppr6KNww+sRdFv2QZeAG8jlm9IWvlLNaoips+qvA==
X-Received: by 2002:a05:6808:1992:b0:3d6:2fc8:2564 with SMTP id 5614622812f47-3d62fc82899mr1066025b6e.45.1719531019985;
        Thu, 27 Jun 2024 16:30:19 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b0c5csm271267b3a.167.2024.06.27.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:30:19 -0700 (PDT)
Date: Thu, 27 Jun 2024 17:30:17 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v6] landlock: Add abstract unix socket connect restriction
Message-ID: <Zn32CYZiu7pY+rdI@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Abstract unix sockets are used for local inter-process communications
without a filesystem. Currently a sandboxed process can connect to a
socket outside of the sandboxed environment, since Landlock has no
restriction for connecting to an abstract socket address. Access to
such sockets for a sandboxed process should be scoped the same way
ptrace is limited.

Because of compatibility reasons and since landlock should be flexible,
we extend the user space interface by adding a new "scoped" field to the
ruleset attribute structure. This field optionally contains a
"LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to specify that the ruleset will
deny any connection from within the sandbox to its parents(i.e. any
parent sandbox or non-sandbox processes)

Closes: https://github.com/landlock-lsm/linux/issues/7
Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

-------
v6: Removing tests. Removing curr_ruleset.
v5: Added curr_ruleset to hierarachy_ruleset structure for optional
    scoping purpose.
V4: Added tests and changes in task.c to scope different sockets
    differently.
V3: Added "scoped" field to landlock_ruleset_attr
V2: Remove wrapper functions
-------

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 include/uapi/linux/landlock.h | 29 ++++++++++++++++
 security/landlock/limits.h    |  3 ++
 security/landlock/ruleset.c   |  7 ++--
 security/landlock/ruleset.h   | 23 ++++++++++++-
 security/landlock/syscalls.c  | 12 +++++--
 security/landlock/task.c      | 62 +++++++++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..010aaca5b05a 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
 	 * rule explicitly allow them.
 	 */
 	__u64 handled_access_net;
+	/**
+	 * @scoped: Bitmask of scopes (cf. `Scope flags`_)
+	 * restricting a Landlock domain from accessing outside
+	 * resources(e.g. IPCs).
+	 */
+	__u64 scoped;
 };
 
 /*
@@ -266,4 +272,27 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 /* clang-format on */
+
+/**
+ * DOC: scope
+ *
+ * .scoped attribute handles a set of restrictions on kernel IPCs through
+ * the following flags.
+ *
+ * Scope flags
+ * ~~~~~~~~~~~
+ *
+ * These flags enable to restrict a sandboxed process from a set of IPC
+ * actions. Setting a flag for a ruleset will isolate the Landlock domain
+ * to forbid connections to resources outside the domain.
+ *
+ * IPCs with scoped actions:
+ * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandboxed process
+ *   from connecting to an abstract unix socket created by a process
+ *   outside the related Landlock domain (e.g. a parent domain or a process
+ *   which is not sandboxed).
+ */
+/* clang-format off */
+#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
+/* clang-format on*/
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 4eb643077a2a..eb01d0fb2165 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -26,6 +26,9 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+#define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
+#define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 /* clang-format on */
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 6ff232f58618..a93bdbf52fff 100644
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
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 0f1b5b4c8f6b..c749fa0b3ecd 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -35,6 +35,8 @@ typedef u16 access_mask_t;
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 /* Makes sure all network access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
+/* Makes sure all scoped rights can be stored*/
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
@@ -42,6 +44,7 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 struct access_masks {
 	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
 	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
+	access_mask_t scoped : LANDLOCK_NUM_SCOPE;
 };
 
 typedef u16 layer_mask_t;
@@ -233,7 +236,8 @@ struct landlock_ruleset {
 
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t access_mask_fs,
-			const access_mask_t access_mask_net);
+			const access_mask_t access_mask_net,
+			const access_mask_t scope_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
@@ -280,6 +284,16 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 	ruleset->access_masks[layer_level].net |= net_mask;
 }
 
+static inline void
+landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
+			const access_mask_t scope_mask, const u16 layer_level)
+{
+	access_mask_t scoped_mask = scope_mask & LANDLOCK_MASK_SCOPE;
+
+	WARN_ON_ONCE(scope_mask != scoped_mask);
+	ruleset->access_masks[layer_level].scoped |= scoped_mask;
+}
+
 static inline access_mask_t
 landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
 				const u16 layer_level)
@@ -303,6 +317,13 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].net;
 }
 
+static inline access_mask_t
+landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
+			const u16 layer_level)
+{
+	return ruleset->access_masks[layer_level].scoped;
+}
+
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 03b470f5a85a..8ea0a13bee83 100644
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
@@ -213,9 +214,14 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	    LANDLOCK_MASK_ACCESS_NET)
 		return -EINVAL;
 
+	/* Checks IPC scoping content (and 32-bits cast). */
+	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
+		return -EINVAL;
+
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
-					  ruleset_attr.handled_access_net);
+					  ruleset_attr.handled_access_net,
+					  ruleset_attr.scoped);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 849f5123610b..acc6e0fbc111 100644
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
@@ -108,9 +110,69 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return task_ptrace(parent, current);
 }
 
+static access_mask_t
+get_scoped_accesses(const struct landlock_ruleset *const domain)
+{
+	access_mask_t access_dom = 0;
+	size_t layer_level;
+
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
+		access_dom |= landlock_get_scope_mask(domain, layer_level);
+	return access_dom;
+}
+
+static bool sock_is_scoped(struct sock *const other)
+{
+	const struct landlock_ruleset *dom_other;
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	/* quick return if there is no domain or .scoped is not set */
+	if (!dom || !get_scoped_accesses(dom))
+		return true;
+
+	/* the credentials will not change */
+	lockdep_assert_held(&unix_sk(other)->lock);
+	if (other->sk_type != SOCK_DGRAM) {
+		dom_other = landlock_cred(other->sk_peer_cred)->domain;
+	} else {
+		dom_other =
+			landlock_cred(other->sk_socket->file->f_cred)->domain;
+	}
+
+	if (!dom_other || !get_scoped_accesses(dom_other))
+		return false;
+
+	/* other is scoped, they connect if they are in the same domain */
+	return domain_scope_le(dom, dom_other);
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
+	pr_warn("XXX %s:%d sock->file:%p other->file:%p\n", __func__, __LINE__,
+		sock->file, other->file);
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


