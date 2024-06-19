Return-Path: <netdev+bounces-105071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B590F8F8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221CA1C21ACC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C53915B543;
	Wed, 19 Jun 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITvcNCzX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7A15B14C;
	Wed, 19 Jun 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836249; cv=none; b=edDWGtE+yIEu8PaeZPc4bQVdviZ1qj1/OdpBpCu9A4Z+KNBNjRuAaQB6xh0RqtGCRFD1HH2hDGg0T4Y1pdlhhF2N7z6BMgtqXiggyxt7eCEFU5uReMBEMJtLoNqayDUjkxTWNsUIsEHRDnuhRDcOTT2ezD8p/Mo+xccPFks02Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836249; c=relaxed/simple;
	bh=9YIb5OS+BHYwjeZ2kz75aEiIqfxIjvjTWF70v22zDH0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tYkgWmZ1bMcuZplzfF50gD+aR98ZEZS270kA/CsSwBkU0hSMJ+KHY9omVwfQArb08oCh8hVKnP9RUl2wBl6hc8eigqQor3UFvsOhv/LgYGocNfqviW8OTqJXdo9Ut6csAQu+9lM+BYwHGo+brxFx3Y2eIJKayAjGWcwchrniIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITvcNCzX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-713fa1aea36so40097a12.1;
        Wed, 19 Jun 2024 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718836247; x=1719441047; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csI2H+Rs6bIctYJIqmJF7l1t4vY//7FkqN3R5aHNSgk=;
        b=ITvcNCzXRxh03aqHBDfnEby+u/5sWUmn7dN2xBaGWy+36C+IHM8h9zsH0BvpjIIo/D
         Dy/II2UpC2y6LnFVW/vWvVpW8qB+cRqgZbGnek5oo+enamqG0/QBtbTzN+YnM/uisZgz
         YrnUyLFezn1hjXDnCaGPvJWoODn4/xG043CBCFgHRpK1Y7tiiDWjYdjXA27JTlscOorv
         ww0yNizDmQ1D86+9/peGe7jhBcIFESxqioCf26llp8cciaOadVe1q+FIEWyxbuJRLQPu
         TVFepaPJ2LmWO5CFa0ihW44GTa8H9RIvXESLLrg+D9ZZ9ClEEoY+6Ul7tggdKOhTAxPV
         d+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718836247; x=1719441047;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csI2H+Rs6bIctYJIqmJF7l1t4vY//7FkqN3R5aHNSgk=;
        b=dHvIiuNBtiNoB/iZhjOfwsA5xKeNMMWmp8UGAJMOrw7exGHyKFBKLEfOOwPzkxbFEG
         WQfz3E9WRpPXJj81GJ0O2UslpbCdm5LI69IQNrwNFyp2MTrtNZe5uhw8vrT1wqRpO1HJ
         Nzyh8saUWzxnrlWUytMJZVkI7t8n8njTdMi8Rxgo6eW2y1KSJ7+spJF/4p/4fDUHLTJR
         Eu0fJQR+DOcZws5MJxKAfw4uIpx40V1Gwb+uKHkW1SVnzCmyEM+k8sigaMufCNzRtOfF
         nakMs24iVH+ucVShqupU2mLGEzcuAFCBhjh9NExkJRqu1XUwH0pQyDphC1191kUyZD0k
         LVSg==
X-Forwarded-Encrypted: i=1; AJvYcCUUiQUNI+zq6pg9xe852Y+5mCCi04KzQvvH+JEXe7jlxlF41u99awK7+HYNbK84v/Z4ANo94xW7eELhWmcwuDmLzeyTzX5QfvBCfEVBV+spc8L3h33e3AdY6DAIPTo8q7vXrP988JHvvgxHs1l1dWhKQW1o9RRcxzgY/ueP4DKkMlBhXFRQGd2LRvol
X-Gm-Message-State: AOJu0YwIsbIRemNna7hdv/rTbFlrqMp3/EYKHsgNasJZkHcQOIyhwDjk
	K1BAc/3aS82v22QtLy4moCtXZp9yb/xrw8hJhCGJ4ZtbNhc1NLgEpCfsxdDp
X-Google-Smtp-Source: AGHT+IFsx0FI/S5AkoRdVDrjyUsGVQ7lVBP7G3kthNgbWkWiX4OPsm0vL8MNuf62qFLAWiHCC+hepQ==
X-Received: by 2002:a05:6a20:c11a:b0:1b5:4c70:d688 with SMTP id adf61e73a8af0-1bcbb3dcb94mr3732697637.3.1718836246544;
        Wed, 19 Jun 2024 15:30:46 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf3a34ddsm8729111a12.48.2024.06.19.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 15:30:46 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:30:43 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v4] landlock: Add abstract unix socket connect restriction
Message-ID: <ZnNcE3ph2SWi1qmd@tahera-OptiPlex-5000>
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

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 include/uapi/linux/landlock.h                 |  27 ++
 security/landlock/limits.h                    |   3 +
 security/landlock/ruleset.c                   |   7 +-
 security/landlock/ruleset.h                   |  29 +-
 security/landlock/syscalls.c                  |  13 +-
 security/landlock/task.c                      |  58 ++++
 .../testing/selftests/landlock/ptrace_test.c  | 261 ++++++++++++++++++
 7 files changed, 392 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..3ea370c52aaa 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -37,6 +37,11 @@ struct landlock_ruleset_attr {
 	 * rule explicitly allow them.
 	 */
 	__u64 handled_access_net;
+	/**
+	 * scoped: Bitmask of actions (cf. `Scope access flags`_)
+	 * which are confined to only affect the current Landlock domain.
+	 */
+	__u64 scoped;
 };
 
 /*
@@ -266,4 +271,26 @@ struct landlock_net_port_attr {
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
+ * Scope access flags
+ * ~~~~~~~~~~~~~~~~~~~~
+ * 
+ * These flags enable to restrict a sandboxed process from a set of IPC 
+ * actions. Setting a flag in a landlock domain will isolate the Landlock
+ *  domain to forbid connections to resources outside the domain.
+ *
+ * IPCs with allowed actions:
+ * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process to
+ *   connect to a process outside of the sandbox domain through abstract
+ *   unix sockets. 
+ */
+/* clang-format off */
+#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
+/* clang-format on*/
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 4eb643077a2a..93d5fa8495b2 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -26,6 +26,9 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
+#define LANDLOCK_LAST_ACCESS_SCOPE       LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+#define LANDLOCK_MASK_ACCESS_SCOPE	((LANDLOCK_LAST_ACCESS_SCOPE << 1) - 1)
+#define LANDLOCK_NUM_ACCESS_SCOPE         __const_hweight64(LANDLOCK_MASK_ACCESS_SCOPE)
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
index 0f1b5b4c8f6b..2d3f41613bdc 100644
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
 
@@ -42,8 +44,15 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 struct access_masks {
 	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
 	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
+	access_mask_t scoped : LANDLOCK_NUM_ACCESS_SCOPE;
 };
 
+typedef u32 access_masks_t;
+/* Makes sure all ruleset access rights can be stored. */
+static_assert(BITS_PER_TYPE(access_masks_t) >=
+	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET +
+		      LANDLOCK_NUM_ACCESS_SCOPE);
+
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
 static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
@@ -233,7 +242,8 @@ struct landlock_ruleset {
 
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t access_mask_fs,
-			const access_mask_t access_mask_net);
+			const access_mask_t access_mask_net,
+			const access_mask_t scope_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
@@ -280,6 +290,16 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 	ruleset->access_masks[layer_level].net |= net_mask;
 }
 
+static inline void
+landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
+			const access_mask_t scope_mask, const u16 layer_level)
+{
+	access_mask_t scoped_mask = scope_mask & LANDLOCK_MASK_ACCESS_SCOPE;
+
+	WARN_ON_ONCE(scope_mask != scoped_mask);
+	ruleset->access_masks[layer_level].scoped |= scoped_mask;
+}
+
 static inline access_mask_t
 landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
 				const u16 layer_level)
@@ -303,6 +323,13 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
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
index 03b470f5a85a..15ad79ac022b 100644
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
@@ -212,10 +213,16 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if ((ruleset_attr.handled_access_net | LANDLOCK_MASK_ACCESS_NET) !=
 	    LANDLOCK_MASK_ACCESS_NET)
 		return -EINVAL;
+	
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
index 849f5123610b..b8bde74ff684 100644
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
@@ -108,9 +110,65 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
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
+	bool is_scoped = true;
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
+	if (other->sk_type != SOCK_DGRAM){
+		dom_other = landlock_cred(other->sk_peer_cred)->domain;
+	} else {
+		dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
+	}
+	is_scoped = domain_scope_le(dom, dom_other);
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
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..73eddf08907e 100644
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
@@ -436,4 +440,261 @@ TEST_F(hierarchy, trace)
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
+	int server, client;
+};
+/* clang-format on */
+
+FIXTURE_VARIANT(unix_socket)
+{
+	int type;
+	bool domain_both;
+	bool domain_parent;
+	bool domain_child;
+	bool connect_to_parent;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_without_domain) {
+	/* clang-format on */
+	.type = SOCK_STREAM,	   .domain_both = false,
+	.domain_parent = false,	   .domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_child_connection_with_domain) {
+	/* clang-format on */
+	.type = SOCK_STREAM,  .domain_both = false,	 .domain_parent = false,
+	.domain_child = true, .connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_child_connection_and_parent_domain) {
+	/* clang-format on */
+	.type = SOCK_STREAM,   .domain_both = false,	  .domain_parent = true,
+	.domain_child = false, .connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_parent_connection_with_domain) {
+	/* clang-format on */
+	.type = SOCK_STREAM,	    .domain_both = false,
+	.domain_parent = true,	    .domain_child = false,
+	.connect_to_parent = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_parent_connection_without_domain) {
+	/* clang-format on */
+	.type = SOCK_STREAM,	    .domain_both = false,
+	.domain_parent = false,	    .domain_child = false,
+	.connect_to_parent = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_parent_connection_with_sibling_domain) {
+	/* clang-format on */
+	.type = SOCK_STREAM,	    .domain_both = true,
+	.domain_parent = false,	    .domain_child = false,
+	.connect_to_parent = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgrm_allow_without_domain) {
+	/* clang-format on */
+	.type = SOCK_DGRAM,	   .domain_both = false,
+	.domain_parent = false,	   .domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgrm_deny_child_connection_with_domain) {
+	/* clang-format on */
+	.type = SOCK_DGRAM,   .domain_both = false,	 .domain_parent = false,
+	.domain_child = true, .connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgrm_allow_child_with_sibling_domain) {
+	/* clang-format on */
+	.type = SOCK_DGRAM,	   .domain_both = true,
+	.domain_parent = false,	   .domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgrm_deny_parent_connection_with_domain) {
+	/* clang-format on */
+	.type = SOCK_DGRAM,	    .domain_both = false,
+	.domain_parent = true,	    .domain_child = false,
+	.connect_to_parent = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgrm_allow_parent_connection_with_child_domain) {
+	/* clang-format on */
+	.type = SOCK_DGRAM,	    .domain_both = false,
+	.domain_parent = false,	    .domain_child = true,
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
+}
+
+/* Test UNIX_STREAM_CONNECT for parent and child. */
+TEST_F(unix_socket, abstract_unix_socket)
+{
+	int status;
+	pid_t child;
+	socklen_t addrlen;
+	int sock_len = 5;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	const char sun_path[8] = "\0test";
+	bool can_connect_to_parent, can_connect_to_child;
+	int err;
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
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int child_ret;
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
+			self->client = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, self->client);
+
+			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+			child_ret = connect(self->client,
+					    (struct sockaddr *)&addr, addrlen);
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, child_ret);
+			} else {
+				EXPECT_EQ(-1, child_ret);
+				EXPECT_EQ(EPERM, errno);
+			}
+		} else {
+			/* child process should create a listening socket */
+			self->server = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, self->server);
+
+			ASSERT_EQ(0, bind(self->server,
+					  (struct sockaddr *)&addr, addrlen));
+			if (variant->type == SOCK_STREAM) {
+				err = listen(self->server, 32);
+				ASSERT_EQ(0, err);
+			}
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
+		self->client = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, self->client);
+		/* Waits for the child to listen */
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		err = connect(self->client, (struct sockaddr *)&addr, addrlen);
+		if (can_connect_to_child) {
+			EXPECT_EQ(0, err);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		}
+		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	} else {
+		self->server = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, self->server);
+		ASSERT_EQ(0, bind(self->server, (struct sockaddr *)&addr,
+				  addrlen));
+		if (variant->type == SOCK_STREAM) {
+			err = listen(self->server, 32);
+			ASSERT_EQ(0, err);
+		}
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
+
 TEST_HARNESS_MAIN
-- 
2.34.1


