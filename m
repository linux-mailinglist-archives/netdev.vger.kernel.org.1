Return-Path: <netdev+bounces-109562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F30928DA8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C591C228D7
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E016C6B3;
	Fri,  5 Jul 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvu5gUDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46016DEA4;
	Fri,  5 Jul 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720205896; cv=none; b=JjHpic0oc+hPB1BzHdJE6c1YjRGMgSyehLQtKn/pyczDKImMGsk/dCchFtA6ctIFHS+Z9fHlRNuGvR3q7wFc2lmXF9SJCW2v7sFCoI5z1DlBg+gkgRs2CiJSL5/LBFTcFL6goudMq+txbaG2L+3UqvqyeJ0BoRm/VjG+ms3vyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720205896; c=relaxed/simple;
	bh=swYxmdjtHzDEh4zHd+0BiYFyXQfYOTZZXwBc9vmI60g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AnPXmgPx5EoHapRWNBnhwc7HHlT32Va0CZQUdEnF5Ie5mP67P3vr0qn7GEu31/1P7Ieuydckv4Zul7eHH4CD+1hKkbXlgx2ogftPUM0kjifpb4TozJ/q4jEkgIJcgsBjYGVUruOwVrx3uDerluOf769twER/TxPSMrC7WeB/cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvu5gUDg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so10033295ad.1;
        Fri, 05 Jul 2024 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720205893; x=1720810693; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/iCaEmk02w0xdRfavLM+J9aPFUPHRQ99swH5Mns/LI=;
        b=Xvu5gUDgJfXzeHe8tc9wfUwy44luFvpeETHoikW2WmKL7bmkeOOWCl+U6B3O9i9uDF
         avcnWotaf+QrXcABtX/ieQYapZXNxrdyUugzrcGIzWaL0+bPAh2Qz2pl2C3ulPvr62oz
         2Lq1M0EimujeQ/lw1i4nQVrfcgHeJ6slP7h9mVwreCJHy8gkwaaYajO5EuBa1E4OlZa9
         frm0Cip1NCAfNGBVNOgBYfx3BDKBc80pKJScKg3sihqkcEHkQBUdbWof0E/8nuM0tG6g
         NuHUainsfE7WJWP8THytODtZckgq6XWG+Mq++yF932ou+A98aka5t8Bb7+X1ArN2AHNT
         gTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720205893; x=1720810693;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/iCaEmk02w0xdRfavLM+J9aPFUPHRQ99swH5Mns/LI=;
        b=l6stwqa5L3PO2NNRbuip0prls1lBX6mTaUM+Cg5BlqWyOVnBgjvaSlUeYGiNU77okr
         1hInXVqEfTGJD3wuSsPwMnDqIXhzXJb0mxYYOh3UGdLu7Lp8Z8nSfzF/xYkSbxxrLNVi
         op/3oVthWjilnh6kdcQQqMDyz0c+hmoTKqPna7WpICzzK1xvvUWNvlxVXx6SkSB679O7
         T20g8H21q2ab7ETVUOMUgGiEC4sP8zZ6Wbjh1xlFBfTH9HMtWzGrpqRZX+zCGDibilTL
         hKsAe/N/1kO9IoxykpBHBwAzWF7nAu7c1VOATXRVzC4IWPYz7G8c3fbsF60EAdZeVrWP
         WWSw==
X-Forwarded-Encrypted: i=1; AJvYcCWC8VKRSfSwhAcgO4CuiYtsS/gaSeeSuBGLccpdz21lM5UnzSz59o7wg79gvAt3TGBpoyRWIMg+XQcdHvfPmpE57v2xKKXFUetCWpHSUymrt1uLeDUYKu95RFCFEdoooF9fLdkXX1PpU45KZNOdBaUwlpvzRSLCCYfZoHNyyr/68COxyebHrUHdQ3if
X-Gm-Message-State: AOJu0YxXLNa4qiCrxOwMkK4ju3EgAeoN0uqtKAl5n8b9zeruwacC1tmQ
	iC2lwQQ7MMzmgIDKwar5S0EHsCWrD1YH5ORVMfUNQcmxiiDaDpmM
X-Google-Smtp-Source: AGHT+IEWV85v6ZmO+sevgyeE5yyUmrOw9l7pcETDGXzykIouJd+yd7S40YAOY8Ow6RbM4rqxlgH5Gg==
X-Received: by 2002:a17:902:ce82:b0:1fb:58b8:2fa2 with SMTP id d9443c01a7336-1fb58b8324cmr13444285ad.20.1720205892966;
        Fri, 05 Jul 2024 11:58:12 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1facec847a6sm136170125ad.291.2024.07.05.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 11:58:12 -0700 (PDT)
Date: Fri, 5 Jul 2024 12:58:10 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH 0/2] Landlock: Add abstract unix socket connect reastriction
Message-ID: <cover.1720203255.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="D8YHuzXxJg8U0Owe"
Content-Disposition: inline


--D8YHuzXxJg8U0Owe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series introduces the optional scoping of abstract unix
sockets. This feature aims to scope the connection of an abstract socket
from a sandbox process to other sockets outside of the sandbox domain.
(see [1, 2])

The following changes are included in this series:
  [PATCH 1/2]: Introduce the "scoped" field to the ruleset structure in
               the user space interface, and add the restriction
               mechanism to Landlock.
  [PATCH 2/2]: Add three comprehensive tests for the new feature.

Tahera Fahimi (2):
  Landlock: Add abstract unix socket connect restriction
  Landlock: Abstract unix socket restriction tests

 include/uapi/linux/landlock.h                 |  29 +
 security/landlock/limits.h                    |   3 +
 security/landlock/ruleset.c                   |   7 +-
 security/landlock/ruleset.h                   |  23 +-
 security/landlock/syscalls.c                  |  12 +-
 security/landlock/task.c                      |  62 ++
 .../testing/selftests/landlock/ptrace_test.c  | 786 ++++++++++++++++++
 7 files changed, 916 insertions(+), 6 deletions(-)

[1]: https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
[2]: https://lore.kernel.org/all/20231102.MaeWaepav8nu@digikod.net/
-- 
2.34.1


--D8YHuzXxJg8U0Owe
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-landlock-Add-abstract-unix-socket-connect-restrictio.patch"

From 2901842a561ee3d205f93f9ba543741f82edf65d Mon Sep 17 00:00:00 2001
Message-Id: <2901842a561ee3d205f93f9ba543741f82edf65d.1720203255.git.fahimitahera@gmail.com>
In-Reply-To: <cover.1720203255.git.fahimitahera@gmail.com>
References: <cover.1720203255.git.fahimitahera@gmail.com>
From: Tahera Fahimi <fahimitahera@gmail.com>
Date: Fri, 21 Jun 2024 15:23:17 -0600
Subject: [PATCH 1/2] Landlock: Add abstract unix socket connect restriction

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


--D8YHuzXxJg8U0Owe
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-landlock-Abstract-unix-socket-restriction-tests.patch"

From 314cc02a23cbf82bca140fe8a0f0ceb75c67ea77 Mon Sep 17 00:00:00 2001
Message-Id: <314cc02a23cbf82bca140fe8a0f0ceb75c67ea77.1720203255.git.fahimitahera@gmail.com>
In-Reply-To: <cover.1720203255.git.fahimitahera@gmail.com>
References: <cover.1720203255.git.fahimitahera@gmail.com>
From: Tahera Fahimi <fahimitahera@gmail.com>
Date: Wed, 26 Jun 2024 15:54:25 -0600
Subject: [PATCH 2/2] Landlock: Abstract unix socket restriction tests

Tests for scoping abstract unix sockets. The patch has three types of tests:
  i) unix_socket: base tests the scoping mechanism for a landlocked process,
     same as the ptrace test.
  ii) optional_scoping: generates three processes with different domains and
      tests if a process with a non-scoped domain can connect to other processes.
  iii) unix_sock_special_cases: since the socket's creator credentials are used
       for scoping datagram sockets, this test examines the cases where the 
       socket's credentials are different from the process using it.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 786 ++++++++++++++++++
 1 file changed, 786 insertions(+)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..b1923549108a 100644
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
@@ -436,4 +440,786 @@ TEST_F(hierarchy, trace)
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
+	int server, client, dgram_server, dgram_client;
+};
+
+/* clang-format on */
+FIXTURE_VARIANT(unix_socket)
+{
+	bool domain_both;
+	bool domain_parent;
+	bool domain_child;
+	bool connect_to_parent;
+};
+
+/*
+ *        No domain
+ *
+ *   P1-.               P1 -> P2 : allow
+ *       \              P2 -> P1 : allow
+ *        'P2
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_without_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_without_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *        Child domain
+ *
+ *   P1--.              P1 -> P2 : allow
+ *        \             P2 -> P1 : deny
+ *        .'-----.
+ *        |  P2  |
+ *        '------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_with_one_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_with_one_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = false,
+};
+
+/*
+ *        Parent domain
+ * .------.
+ * |  P1  --.           P1 -> P2 : deny
+ * '------'  \          P2 -> P1 : allow
+ *            '
+ *            P2
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_parent_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_parent_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *        Parent + child domain (siblings)
+ * .------.
+ * |  P1  ---.          P1 -> P2 : deny
+ * '------'   \         P2 -> P1 : deny
+ *         .---'--.
+ *         |  P2  |
+ *         '------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_sibling_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_sibling_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = true,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Same domain (inherited)
+ * .-------------.
+ * | P1----.     |      P1 -> P2 : allow
+ * |        \    |      P2 -> P1 : allow
+ * |         '   |
+ * |         P2  |
+ * '-------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_sibling_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_sibling_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Inherited + child domain
+ * .-----------------.
+ * |  P1----.        |  P1 -> P2 : allow
+ * |         \       |  P2 -> P1 : deny
+ * |        .-'----. |
+ * |        |  P2  | |
+ * |        '------' |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_nested_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, allow_nested_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Inherited + parent domain
+ * .-----------------.
+ * |.------.         |  P1 -> P2 : deny
+ * ||  P1  ----.     |  P2 -> P1 : allow
+ * |'------'    \    |
+ * |             '   |
+ * |             P2  |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_nested_and_parent_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_nested_and_parent_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+	.connect_to_parent = false,
+};
+
+/*
+ *         Inherited + parent and child domain (siblings)
+ * .-----------------.
+ * | .------.        |  P1 -> P2 : deny
+ * | |  P1  .        |  P2 -> P1 : deny
+ * | '------'\       |
+ * |          \      |
+ * |        .--'---. |
+ * |        |  P2  | |
+ * |        '------' |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_forked_domain_connect_to_parent) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+	.connect_to_parent = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, deny_with_forked_domain_connect_to_child) {
+	/* clang-format on */
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
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
+	close(self->dgram_server);
+	close(self->dgram_client);
+}
+
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and child,
+ * when they have scoped domain or no domain.
+ */
+TEST_F(unix_socket, abstract_unix_socket)
+{
+	int status;
+	pid_t child;
+	socklen_t addrlen;
+	int sock_len = 5;
+	struct sockaddr_un addr, dgram_addr = {
+		.sun_family = AF_UNIX,
+	};
+	const char sun_path[8] = "\0test";
+	const char sun_path_dgram[8] = "\0dgrm";
+	bool can_connect_to_parent, can_connect_to_child;
+	int err, err_dgram;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	/*
+	 * can_connect_to_child is true if a parent process can connect to its
+	 * child process. The parent process is not isolated from the child
+	 * with a dedicated Landlock domain.
+	 */
+	can_connect_to_child = !variant->domain_parent;
+	/*
+	 * can_connect_to_parent is true if a child process can connect to its
+	 * parent process. This depends on the child process is not isolated from
+	 * the parent with a dedicated Landlock domain.
+	 */
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
+	memcpy(&dgram_addr.sun_path, sun_path_dgram, sock_len);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
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
+			self->client = socket(AF_UNIX, SOCK_STREAM, 0);
+			self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+			ASSERT_NE(-1, self->client);
+			ASSERT_NE(-1, self->dgram_client);
+
+			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+			err = connect(self->client, (struct sockaddr *)&addr,
+				      addrlen);
+			err_dgram = connect(self->dgram_client,
+					    (struct sockaddr *)&dgram_addr,
+					    addrlen);
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, err);
+				EXPECT_EQ(0, err_dgram);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(-1, err_dgram);
+				EXPECT_EQ(EPERM, errno);
+			}
+		} else {
+			/* child process should create a listening socket */
+			self->server = socket(AF_UNIX, SOCK_STREAM, 0);
+			self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+			ASSERT_NE(-1, self->server);
+			ASSERT_NE(-1, self->dgram_server);
+
+			ASSERT_EQ(0, bind(self->server,
+					  (struct sockaddr *)&addr, addrlen));
+			ASSERT_EQ(0, bind(self->dgram_server,
+					  (struct sockaddr *)&dgram_addr,
+					  addrlen));
+			ASSERT_EQ(0, listen(self->server, 32));
+
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
+		self->client = socket(AF_UNIX, SOCK_STREAM, 0);
+		self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+		ASSERT_NE(-1, self->client);
+		ASSERT_NE(-1, self->dgram_client);
+
+		/* Waits for the child to listen */
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		err = connect(self->client, (struct sockaddr *)&addr, addrlen);
+		err_dgram = connect(self->dgram_client,
+				    (struct sockaddr *)&dgram_addr, addrlen);
+
+		if (can_connect_to_child) {
+			EXPECT_EQ(0, err);
+			EXPECT_EQ(0, err_dgram);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(-1, err_dgram);
+			EXPECT_EQ(EPERM, errno);
+		}
+		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	} else {
+		self->server = socket(AF_UNIX, SOCK_STREAM, 0);
+		self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, self->server);
+		ASSERT_NE(-1, self->dgram_server);
+		ASSERT_EQ(0, bind(self->server, (struct sockaddr *)&addr,
+				  addrlen));
+		ASSERT_EQ(0, bind(self->dgram_server,
+				  (struct sockaddr *)&dgram_addr, addrlen));
+		ASSERT_EQ(0, listen(self->server, 32));
+
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
+/* clang-format off */
+FIXTURE(optional_scoping)
+{
+	int parent_server, child_server, client;
+};
+
+/* clang-format on */
+/* Domain is defined as follows:
+ * 0 --> no domain
+ * 1 --> have domain
+ * 2 --> have domain and is scoped
+ **/
+FIXTURE_VARIANT(optional_scoping)
+{
+	int domain_all;
+	int domain_parent;
+	int domain_children;
+	int domain_child;
+	int domain_grand_child;
+	int type;
+};
+
+/*
+ * .-----------------.
+ * |         ####### |  P3 -> P2 : allow
+ * |   P1----# P2  # |  P3 -> P1 : deny
+ * |         #  |  # |
+ * |         # P3  # |
+ * |         ####### |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, deny_scoped) {
+	.domain_all = 1,
+	.domain_parent = 0,
+	.domain_children = 2,
+	.domain_child = 0,
+	.domain_grand_child = 0,
+	.type = SOCK_DGRAM,
+	/* clang-format on */
+};
+
+/*
+ * .-----------------.
+ * |         .-----. |  P3 -> P2 : allow
+ * |   P1----| P2  | |  P3 -> P1 : allow
+ * |         |     | |
+ * |         | P3  | |
+ * |         '-----' |
+ * '-----------------'
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(optional_scoping, allow_with_domain) {
+	.domain_all = 1,
+	.domain_parent = 0,
+	.domain_children = 1,
+	.domain_child = 0,
+	.domain_grand_child = 0,
+	.type = SOCK_DGRAM,
+	/* clang-format on */
+};
+
+FIXTURE_SETUP(optional_scoping)
+{
+}
+
+FIXTURE_TEARDOWN(optional_scoping)
+{
+}
+
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent, child
+ * and grand child processes when they can have scoped or non-scoped
+ * domains.
+ **/
+TEST_F(optional_scoping, unix_scoping)
+{
+	pid_t child;
+	socklen_t addrlen;
+	int sock_len = 5;
+	int status;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	const char sun_path[8] = "\0test";
+	bool can_connect_to_parent, can_connect_to_child;
+	int pipe_parent[2];
+
+	if (variant->domain_grand_child == 2)
+		can_connect_to_child = false;
+	else
+		can_connect_to_child = true;
+
+	if (!can_connect_to_child || variant->domain_children == 2)
+		can_connect_to_parent = false;
+	else
+		can_connect_to_parent = true;
+
+	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
+	memcpy(&addr.sun_path, sun_path, sock_len);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	if (variant->domain_all == 1)
+		create_domain(_metadata);
+	else if (variant->domain_all == 2)
+		create_unix_domain(_metadata);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int pipe_child[2];
+		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+		pid_t grand_child;
+		struct sockaddr_un child_addr = {
+			.sun_family = AF_UNIX,
+		};
+		const char child_sun_path[8] = "\0tsst";
+
+		memcpy(&child_addr.sun_path, child_sun_path, sock_len);
+
+		if (variant->domain_children == 1)
+			create_domain(_metadata);
+		else if (variant->domain_children == 2)
+			create_unix_domain(_metadata);
+
+		grand_child = fork();
+		ASSERT_LE(0, grand_child);
+		if (grand_child == 0) {
+			ASSERT_EQ(0, close(pipe_parent[1]));
+			ASSERT_EQ(0, close(pipe_child[1]));
+
+			char buf1, buf2;
+			int err;
+
+			if (variant->domain_child == 1)
+				create_domain(_metadata);
+			else if (variant->domain_child == 2)
+				create_unix_domain(_metadata);
+
+			self->client = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, self->client);
+
+			ASSERT_EQ(1, read(pipe_parent[0], &buf1, 1));
+			err = connect(self->client, (struct sockaddr *)&addr,
+				      addrlen);
+			if (can_connect_to_parent) {
+				EXPECT_EQ(0, err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(EPERM, errno);
+			}
+			EXPECT_EQ(0, close(self->client));
+
+			self->client = socket(AF_UNIX, variant->type, 0);
+			ASSERT_NE(-1, self->client);
+
+			ASSERT_EQ(1, read(pipe_child[0], &buf2, 1));
+			err = connect(self->client,
+				      (struct sockaddr *)&child_addr, addrlen);
+			if (can_connect_to_child) {
+				EXPECT_EQ(0, err);
+			} else {
+				EXPECT_EQ(-1, err);
+				EXPECT_EQ(EPERM, errno);
+			}
+
+			EXPECT_EQ(0, close(self->client));
+
+			_exit(_metadata->exit_code);
+			return;
+		}
+
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child == 1)
+			create_domain(_metadata);
+		else if (variant->domain_child == 2)
+			create_unix_domain(_metadata);
+
+		self->child_server = socket(AF_UNIX, variant->type, 0);
+		ASSERT_NE(-1, self->child_server);
+		ASSERT_EQ(0, bind(self->child_server,
+				  (struct sockaddr *)&child_addr, addrlen));
+		if (variant->type == SOCK_STREAM)
+			ASSERT_EQ(0, listen(self->child_server, 32));
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent == 1)
+		create_domain(_metadata);
+	else if (variant->domain_parent == 2)
+		create_unix_domain(_metadata);
+
+	self->parent_server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_NE(-1, self->parent_server);
+	ASSERT_EQ(0,
+		  bind(self->parent_server, (struct sockaddr *)&addr, addrlen));
+
+	if (variant->type == SOCK_STREAM)
+		ASSERT_EQ(0, listen(self->parent_server, 32));
+	/* signal to grand_child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/* The following test is only considered for dgram sockets.
+ * In all special cases, the client's domain is true.
+ */
+/* clang-format off */
+FIXTURE(unix_sock_special_cases) {
+	int server_socket, client;
+	int stream_server, stream_client;
+};
+
+/* clang-format on */
+FIXTURE_VARIANT(unix_sock_special_cases)
+{
+	const bool domain_server;
+	const bool domain_server_socket;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, allow_server_sock_domain) {
+	/* clang-format on */
+	.domain_server = false,
+	.domain_server_socket = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_sock_special_cases, deny_server_domain) {
+	/* clang-format off */
+	.domain_server = true,
+	.domain_server_socket = false,
+};
+
+FIXTURE_SETUP(unix_sock_special_cases)
+{
+}
+
+FIXTURE_TEARDOWN(unix_sock_special_cases)
+{
+	close(self->client);
+	close(self->server_socket);
+	close(self->stream_server);
+	close(self->stream_client);
+}
+
+/* Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and
+ * child processes when conecting socket has different domain
+ * than the process using it.
+ **/
+TEST_F(unix_sock_special_cases, dgram_cases)
+{
+	pid_t child;
+	socklen_t addrlen;
+	int sock_len = 5;
+	struct sockaddr_un addr, addr_stream = {
+		.sun_family = AF_UNIX,
+	};
+	const char sun_path[8] = "\0test";
+	const char sun_path_stream[8] = "\0strm";
+	int err, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	addrlen = offsetof(struct sockaddr_un, sun_path) + sock_len;
+	memcpy(&addr.sun_path, sun_path, sock_len);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+
+		/* client always has domain */
+		create_unix_domain(_metadata);
+
+		if (variant->domain_server_socket) {
+			int data_socket;
+			int fd_sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+			ASSERT_NE(-1, fd_sock);
+
+			self->stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
+
+			ASSERT_NE(-1, self->stream_server);
+			memcpy(&addr_stream.sun_path, sun_path_stream,
+			       sock_len);
+			ASSERT_EQ(0, bind(self->stream_server,
+					  (struct sockaddr *)&addr_stream,
+					  addrlen));
+			ASSERT_EQ(0, listen(self->stream_server, 32));
+
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+			data_socket = accept(self->stream_server, NULL, NULL);
+
+			ASSERT_EQ(0, send_fd(data_socket, fd_sock));
+			ASSERT_EQ(0, close(fd_sock));
+			TH_LOG("sending completed\n");
+		}
+
+		self->client = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, self->client);
+		/* wait for parent signal for connection */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		err = connect(self->client, (struct sockaddr *)&addr, addrlen);
+		if (!variant->domain_server_socket) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+		}
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+
+	if (!variant->domain_server_socket) {
+		self->server_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
+	} else {
+		int cli = socket(AF_UNIX, SOCK_STREAM, 0);
+
+		ASSERT_NE(-1, cli);
+		memcpy(&addr_stream.sun_path, sun_path_stream, sock_len);
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+		ASSERT_EQ(0, connect(cli, (struct sockaddr *)&addr_stream,
+				     addrlen));
+
+		self->server_socket = recv_fd(cli);
+		ASSERT_LE(0, self->server_socket);
+	}
+
+	ASSERT_NE(-1, self->server_socket);
+
+	if (variant->domain_server)
+		create_unix_domain(_metadata);
+
+	ASSERT_EQ(0,
+		  bind(self->server_socket, (struct sockaddr *)&addr, addrlen));
+	/* signal to child that parent is listening */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
 TEST_HARNESS_MAIN
-- 
2.34.1


--D8YHuzXxJg8U0Owe--

