Return-Path: <netdev+bounces-115207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B49456CB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FEF1C21ACA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6822E83F;
	Fri,  2 Aug 2024 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA47UgUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B6219FC;
	Fri,  2 Aug 2024 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571392; cv=none; b=NZKgbcN+68B1njoQwk4veSMY1hk0Lp7hUC6/0sp6sGXxijO9J+hkPwGOFE6NiHIviIaw0AFSqdJ8n4gWQMCRL8FruSTkJH8dFhlHXV6AZhwv0tCBKSJhr8Wkp+I/uD3v5pLqYaxnVbEuX+qqIeuzWndTNuYb7hv52A3i5Yw0Ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571392; c=relaxed/simple;
	bh=YotXhV4uo9htrXG453qHjjxydfLffVK0+D5tGIeIJkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDcGzgsmqwfxs3+CowvYCca7GraKFqrWJyQuS0uVpRntKvoEuckBTI0Y67R704oeRFiRnjqhZEVYFkblcs8JgVjmeHpS7JrWCa510C0UHxLqYgh5L6hkaFUwE0BVojoxK+IEk1mVEuOvwETPurwb66TtNuxdRU+Q+T2xhvIWw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA47UgUl; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db22c02a42so4518039b6e.3;
        Thu, 01 Aug 2024 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571389; x=1723176189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImkKaH7WBzIdVWRbmn44o56X3eXOfBL1FlJFCdCwLH0=;
        b=ZA47UgUlkppmPW+1VJqiCaymmhuAmgIXr7NI8efgLkvK+Ulj3AygXIc19SkSARd7TN
         I3oJWYcmNKPPREGgkqgNysDYlvOHPsrg+namB7OTKimdKfN62EBU0MI4tq8EB/bc/0cP
         vdsQeayEJ3uMow3vX7h3UBSqFzhVb7xfUBZeOaG3grJ5mKBDfUwQb8Xo+NALiubM/EoJ
         qejQ6EoUzsCaprikrko+tum9r9sTDiDkDkKPT6nM2S6fdvlAz2QEBbZsGHTcD6ixLpiC
         36zZx1c2Un2gHWQ4Q18Dlcre4aGMM9wbbgXmm6Q6Xm8v2z9RXsgfqS4RAPkYYUB94/kc
         w2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571389; x=1723176189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImkKaH7WBzIdVWRbmn44o56X3eXOfBL1FlJFCdCwLH0=;
        b=SOpUXqxpMIRcPd7fJqAG33KzloEefnN5BDAGoV9DKXb9zz+0aT6OjKq9c/+eLzY+eM
         90g5ansVr2Cdxf2PPxuTOPlKtZdwc+tfNLySt4sUhAlXxc5/Ju1iZjp8eD52zK7JUxWQ
         dvHeZGzoI1aQzBINK69NieCSQbtJ2Ih1CKfZw3+/GsA+JhrioavG8QR3fpdsSZGsHiMX
         p7lT+e9vhhYu/H6nPCJZhCktBqPtm+bCT0wEcieOqCx7soO5pIp7/Mjc5n1dYV78aGgk
         KZ65qNZMPsoJvAEFAQhXCXyhb+ciQU2hKzpEEtNjTnkcoVbCGZqEwlrqn1v355A3C3LB
         20Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXYRKK+I4RH+FgWkCRyn0FhF8wrh9ZK43axtqoc9iAZkVH0+qXpbC8yCeaE034PXgYW8RSBvPEd6VoIRPy55T4P+GLvU1DDx2iXiS5K7l323KjelP4dZcW5g/6WS18w7pF3t/WHLrn37uejnzbNXxNXiafU1jGX0NhpN/xRNxuLvsLa4n/01QSC1TAH
X-Gm-Message-State: AOJu0YzdHQHtyP/Gwy8JWXMkNhdOA2c9WUoSJmwCeVukRLtb8ilxAWWr
	2F7Medv2AgvXkuuEvsOPZ1KbHxS4z78rWh+EJp/66YuXziptr831
X-Google-Smtp-Source: AGHT+IFVoZPochyOfuDQ+SlstEbMIoO1KxFIxh7A1gCZ0HELnXmlpRbHjIqEFQp2l1KO0DZPRNgxTQ==
X-Received: by 2002:a05:6871:23c1:b0:268:9d6b:672 with SMTP id 586e51a60fabf-2689d6b4e84mr556145fac.42.1722571388699;
        Thu, 01 Aug 2024 21:03:08 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec41465sm542099b3a.60.2024.08.01.21.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:03:07 -0700 (PDT)
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
Subject: [PATCH v8 1/4] Landlock: Add abstract unix socket connect restriction
Date: Thu,  1 Aug 2024 22:02:33 -0600
Message-Id: <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722570749.git.fahimitahera@gmail.com>
References: <cover.1722570749.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch introduces a new "scoped" attribute to the landlock_ruleset_attr
that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
abstract Unix sockets from connecting to a process outside of
the same landlock domain. It implements two hooks, unix_stream_connect
and unix_may_send to enforce this restriction.

Closes: https://github.com/landlock-lsm/linux/issues/7
Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

---
v8:
- Code refactoring (improve code readability, renaming variable, etc.) based
  on reviews by Mickaël Salaün on version 7.
- Adding warn_on_once to check (impossible) inconsistencies.
- Adding inline comments.
- Adding check_unix_address_format to check if the scoping socket is an abstract
  unix sockets.
v7:
 - Using socket's file credentials for both connected(STREAM) and
   non-connected(DGRAM) sockets.
 - Adding "domain_sock_scope" instead of the domain scoping mechanism used in
   ptrace ensures that if a server's domain is accessible from the client's
   domain (where the client is more privileged than the server), the client
   can connect to the server in all edge cases.
 - Removing debug codes.
v6:
 - Removing curr_ruleset from landlock_hierarchy, and switching back to use
   the same domain scoping as ptrace.
 - code clean up.
v5:
 - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
 - Adding curr_ruleset to hierarachy_ruleset structure to have access from
   landlock_hierarchy to its respective landlock_ruleset.
 - Using curr_ruleset to check if a domain is scoped while walking in the
   hierarchy of domains.
 - Modifying inline comments.
V4:
 - Rebased on Günther's Patch:
   https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
   so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is removed.
 - Adding get_scope_accesses function to check all scoped access masks in a ruleset.
 - Using socket's file credentials instead of credentials stored in peer_cred
   for datagram sockets. (see discussion in [1])
 - Modifying inline comments.
V3:
 - Improving commit description.
 - Introducing "scoped" attribute to landlock_ruleset_attr for IPC scoping
   purpose, and adding related functions.
 - Changing structure of ruleset based on "scoped".
 - Removing rcu lock and using unix_sk lock instead.
 - Introducing scoping for datagram sockets in unix_may_send.
V2:
 - Removing wrapper functions

[1]https://lore.kernel.org/all/20240610.Aifee5ingugh@digikod.net/
----
---
 include/uapi/linux/landlock.h |  30 +++++++
 security/landlock/limits.h    |   3 +
 security/landlock/ruleset.c   |   7 +-
 security/landlock/ruleset.h   |  23 ++++-
 security/landlock/syscalls.c  |  14 ++-
 security/landlock/task.c      | 155 ++++++++++++++++++++++++++++++++++
 6 files changed, 225 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..ab31e9f53e55 100644
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
@@ -266,4 +272,28 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 /* clang-format on */
+
+/**
+ * DOC: scope
+ *
+ * scoped attribute handles a set of restrictions on kernel IPCs through
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
+ *
+ * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandboxed process
+ *   from connecting to an abstract unix socket created by a process
+ *   outside the related Landlock domain (e.g. a parent domain or a
+ *   non-sandboxed process).
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
index 03b470f5a85a..f51b29521d6b 100644
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
@@ -149,7 +150,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 5
+#define LANDLOCK_ABI_VERSION 6
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -170,7 +171,7 @@ static const struct file_operations ruleset_fops = {
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: unknown @flags, or unknown access, or too small @size;
+ * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
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
index 849f5123610b..7e8579ebae83 100644
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
@@ -108,9 +110,162 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return task_ptrace(parent, current);
 }
 
+static bool walk_and_check(const struct landlock_ruleset *const child,
+			   struct landlock_hierarchy **walker,
+			   size_t base_layer, size_t deep_layer,
+			   access_mask_t check_scoping)
+{
+	if (!child || base_layer < 0 || !(*walker))
+		return false;
+
+	for (deep_layer; base_layer < deep_layer; deep_layer--) {
+		if (check_scoping & landlock_get_scope_mask(child, deep_layer))
+			return false;
+		*walker = (*walker)->parent;
+		if (WARN_ON_ONCE(!*walker))
+			/* there is an inconsistency between num_layers
+			 * and landlock_hierarchy in the ruleset
+			 */
+			return false;
+	}
+	return true;
+}
+
+/**
+ * domain_IPC_scope - Checks if the client domain is scoped in the same
+ *		      domain as the server.
+ *
+ * @client: IPC sender domain.
+ * @server: IPC receiver domain.
+ *
+ * Check if the @client domain is scoped to access the @server; the @server
+ * must be scoped in the same domain.
+ */
+static bool domain_IPC_scope(const struct landlock_ruleset *const client,
+			     const struct landlock_ruleset *const server,
+			     access_mask_t ipc_type)
+{
+	size_t client_layer, server_layer = 0;
+	int base_layer;
+	struct landlock_hierarchy *client_walker, *server_walker;
+	bool is_scoped;
+
+	/* Quick return if client has no domain */
+	if (!client)
+		return true;
+
+	client_layer = client->num_layers - 1;
+	client_walker = client->hierarchy;
+	if (server) {
+		server_layer = server->num_layers - 1;
+		server_walker = server->hierarchy;
+	}
+	base_layer = (client_layer > server_layer) ? server_layer :
+						     client_layer;
+
+	/* For client domain, walk_and_check ensures the client domain is
+	 * not scoped until gets to base_layer.
+	 * For server_domain, it only ensures that the server domain exist.
+	 */
+	if (client_layer != server_layer) {
+		if (client_layer > server_layer)
+			is_scoped = walk_and_check(client, &client_walker,
+						   server_layer, client_layer,
+						   ipc_type);
+		else
+			is_scoped = walk_and_check(server, &server_walker,
+						   client_layer, server_layer,
+						   ipc_type & 0);
+		if (!is_scoped)
+			return false;
+	}
+	/* client and server are at the same level in hierarchy. If client is
+	 * scoped, the server must be scoped in the same domain
+	 */
+	for (base_layer; base_layer >= 0; base_layer--) {
+		if (landlock_get_scope_mask(client, base_layer) & ipc_type) {
+			/* This check must be here since access would be denied only if
+			 * the client is scoped and the server has no domain, so
+			 * if the client has a domain but is not scoped and the server
+			 * has no domain, access is guaranteed.
+			 */
+			if (!server)
+				return false;
+
+			if (server_walker == client_walker)
+				return true;
+
+			return false;
+		}
+		client_walker = client_walker->parent;
+		server_walker = server_walker->parent;
+		/* Warn if there is an incosistenncy between num_layers and
+		 * landlock_hierarchy in each of rulesets
+		 */
+		if (WARN_ON_ONCE(base_layer > 0 &&
+				 (!server_walker || !client_walker)))
+			return false;
+	}
+	return true;
+}
+
+static bool sock_is_scoped(struct sock *const other)
+{
+	const struct landlock_ruleset *dom_other;
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	/* the credentials will not change */
+	lockdep_assert_held(&unix_sk(other)->lock);
+	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
+	return domain_IPC_scope(dom, dom_other,
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+}
+
+static bool check_unix_address_format(struct sock *const sock)
+{
+	struct unix_address *addr = unix_sk(sock)->addr;
+
+	if (!addr)
+		return true;
+
+	if (addr->len > sizeof(AF_UNIX)) {
+		/* handling unspec sockets */
+		if (!addr->name[0].sun_path)
+			return true;
+
+		if (addr->name[0].sun_path[0] == '\0')
+			if (!sock_is_scoped(sock))
+				return false;
+	}
+
+	return true;
+}
+
+static int hook_unix_stream_connect(struct sock *const sock,
+				    struct sock *const other,
+				    struct sock *const newsk)
+{
+	if (check_unix_address_format(other))
+		return 0;
+
+	return -EPERM;
+}
+
+static int hook_unix_may_send(struct socket *const sock,
+			      struct socket *const other)
+{
+	if (check_unix_address_format(other->sk))
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


