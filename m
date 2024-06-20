Return-Path: <netdev+bounces-105466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69891140F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2451F1F2285F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E87577116;
	Thu, 20 Jun 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8plwu20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779C3A1CD;
	Thu, 20 Jun 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917541; cv=none; b=SavAnyth4Wq3VM2xutbkJQPAD6FDWmzIhoLt8WVBJEg1m2o6zm7uJ6KjOrByvxbY4WedpE3JnGjNB5dIYy9uzmpK9/jT7wWnt6QPxs/0XNcgrjWo5AKb5KQ5r5D4nd5c6rHTiGv63rQS8j4n9mwe/iwbcPW23O4mWFuWBbDIhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917541; c=relaxed/simple;
	bh=xm45bYqOQQOVNUKToopnMPsmqi45fgnJ2Vh9u3ZgX4I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yrrk/07lDWfHEB8cUvanr2eQ98tFPmg/Mnei4PQwB5/4+2ROawTjDQqtRfTp497Jf7/6QPOWXiXxgXqutnj7Zdlv/R3hPdMiViNKaz1bsxtKbXQvl66isosjcVGYfFbWSE3mr1P+/JBCJW2dpEW3WzijtJ3sULUf9q9j+be/mSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8plwu20; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f44b45d6abso11210705ad.0;
        Thu, 20 Jun 2024 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718917538; x=1719522338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2466Dce19cj2BQ3ZpJsopSXNqEq+bcueHyYljZ/i3A=;
        b=P8plwu20HwxUDyle09M+1VKT/FvZk05xTT62SeTmywbb6hPZzBntC7clJIx7cBORor
         h86AMi+gbGCDO5fc85GP5wgEezbcRnYMXJxoUtMGwp3nhoZNHiye1SXvUVi1NX2cxSUv
         T2YiPYx5fhkzPG/Jli5vyBnCENXEoZ9km1DOWpLP4ROqG6x9SfMrI1wcDhpCKkHFyHF7
         WsmUKWNP7pfckTY1AZQKHVAxCTOWetuzBkAhK9ePKVAJjoXJnipiTZjKBkBY1QAl6zu+
         oMc7rvnwnCwP4cNJh7USxR3/Af9leACzHk7qHYps4IDCjcRSTbDnTdSqQw9KZYh+9ZSf
         Xb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718917538; x=1719522338;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2466Dce19cj2BQ3ZpJsopSXNqEq+bcueHyYljZ/i3A=;
        b=ajcP3lY6ZqF2XyZbmIE4DkebEmKwtROxDQLUF0oLFNUIrfSziFPEyMGgUqNw9KNgix
         dntM6MXTwKKiiNwTMyRckEZkinJlhorzQi2QDnox/V1C+gtpd9wNYbBHXAEkXJUQSFWc
         GUEkRQBtHGBvzQ/wkKaJRXBCW7QZd4QOil0wy6hNm7bP8mEvLG7mnCfcMDS2VMgHH9BT
         WihA1g8vzT7bZ6LAJgUa9soaqRv2mlTJPc9JeO4ouk2ykfNKhOcwwb8kDdXTaF8Cwrf+
         e9LT5B8jjE7XzNNlz1WCJnuJ97HsLtKaaf5PNhwyHR8vSwhO6Dw+IqmqwszCyBfZbIQK
         c3hA==
X-Forwarded-Encrypted: i=1; AJvYcCVclGE6pl6G4M9tAppyj0kAZFHlrycNjrUCSWH8xueVKprK4nSLb4dIFYyGyQYxzdhXi+TPjtL4zvhFHhUVTb8w6EPyqhtp/j9cb+p/TBBKJP9o1YRuAXYoSLl7HqhKn59HyK5eU81j3JdJfzj+XREuihwTzOaoI1/wmfypRxXCMPLJfHEHPc2bJ7y1
X-Gm-Message-State: AOJu0Yx+Dfn+pWPQkp5cTCqJd8/rkmHKzrdaLlUvO/TWHc2VEUjo9HUD
	hW8p4CRJ9mbVvrMQdvAQA457e/6tCXKzmt+YhpFiuiw7Q2zPW8LA
X-Google-Smtp-Source: AGHT+IFq4lLdYW2Bs2UyXEWrzoqFVWFUUhHHWF6w7rCNHC+Mfi0UpE17wGNTme4jXIc3V1sonRT1rA==
X-Received: by 2002:a17:902:e544:b0:1f7:414:d67d with SMTP id d9443c01a7336-1f9aa466120mr76918275ad.63.1718917537247;
        Thu, 20 Jun 2024 14:05:37 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb8c8960sm533085ad.227.2024.06.20.14.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:05:36 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:05:34 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v5] landlock: Add abstract unix socket connect restriction
Message-ID: <ZnSZnhGBiprI6FRk@tahera-OptiPlex-5000>
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
V4: Added abstract unix socket scoping tests
V3: Added "scoped" field to landlock_ruleset_attr
V2: Remove wrapper functions

-------

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 include/uapi/linux/landlock.h                 |  27 ++
 security/landlock/limits.h                    |   3 +
 security/landlock/ruleset.c                   |  12 +-
 security/landlock/ruleset.h                   |  27 +-
 security/landlock/syscalls.c                  |  13 +-
 security/landlock/task.c                      |  95 +++++++
 .../testing/selftests/landlock/ptrace_test.c  | 261 ++++++++++++++++++
 7 files changed, 430 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..1eb459afcb3b 100644
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
index 6ff232f58618..3b3844574326 100644
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
 
@@ -311,7 +314,7 @@ static void put_hierarchy(struct landlock_hierarchy *hierarchy)
 {
 	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
 		const struct landlock_hierarchy *const freeme = hierarchy;
-
+		
 		hierarchy = hierarchy->parent;
 		kfree(freeme);
 	}
@@ -472,6 +475,7 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 	}
 	get_hierarchy(parent->hierarchy);
 	child->hierarchy->parent = parent->hierarchy;
+	child->hierarchy->curr_ruleset = child;
 
 out_unlock:
 	mutex_unlock(&parent->lock);
@@ -571,7 +575,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	err = merge_ruleset(new_dom, ruleset);
 	if (err)
 		goto out_put_dom;
-
+	new_dom->hierarchy->curr_ruleset = new_dom;
 	return new_dom;
 
 out_put_dom:
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 0f1b5b4c8f6b..39cb313812dc 100644
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
@@ -150,6 +153,10 @@ struct landlock_hierarchy {
 	 * domain.
 	 */
 	refcount_t usage;
+	/**
+	 * @curr_ruleset: a pointer back to the current ruleset
+	 */
+	struct landlock_ruleset *curr_ruleset;
 };
 
 /**
@@ -233,7 +240,8 @@ struct landlock_ruleset {
 
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t access_mask_fs,
-			const access_mask_t access_mask_net);
+			const access_mask_t access_mask_net,
+			const access_mask_t scope_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
@@ -280,6 +288,16 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
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
@@ -303,6 +321,13 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
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
index 03b470f5a85a..6b5a97a199d9 100644
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
+	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) !=
+	    LANDLOCK_MASK_SCOPE)
+		return -EINVAL;
 
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
-					  ruleset_attr.handled_access_net);
+					  ruleset_attr.handled_access_net,
+					  ruleset_attr.scoped);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 849f5123610b..dfaeb5694181 100644
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
@@ -108,9 +110,102 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
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
+/**
+ * optional_domain_scope - Checks domain ordering for scoped unix sockets
+ *
+ * @client: client domain.
+ * @server: Potential child of @client.
+ *
+ * Checks if the @client domain is less or equal to (i.e. an ancestor, which
+ * means a subset of) the @server domain.
+ * Same as domain_scope_le, only for optional scoping unix sockets.
+ */
+static bool optional_domain_scope(const struct landlock_ruleset *const client,
+				  const struct landlock_ruleset *const server)
+{
+	const struct landlock_hierarchy *walker;
+	access_mask_t scoped;
+
+	if (!client)
+		return true;
+
+	/* quick return if server does not have domain */
+	if (!server)
+		return false;
+
+	for (walker = server->hierarchy; walker; walker = walker->parent) {
+		scoped = get_scoped_accesses(walker->curr_ruleset);
+		if (walker == client->hierarchy)
+			/* @client is in the scoped hierarchy of @server. */
+			return true;
+		if (scoped)
+			/* There is a node between client and server that is scoped */
+			return false;
+	}
+	/* There is no relationship between @parent and @child. */
+	return false;
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
+	if (other->sk_type != SOCK_DGRAM) {
+		dom_other = landlock_cred(other->sk_peer_cred)->domain;
+	} else {
+		dom_other =
+			landlock_cred(other->sk_socket->file->f_cred)->domain;
+	}
+	is_scoped = optional_domain_scope(dom, dom_other);
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


