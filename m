Return-Path: <netdev+bounces-119983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E2957C3D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332FD1F2420C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833D131BAF;
	Tue, 20 Aug 2024 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8h5X/Kh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352F4501E;
	Tue, 20 Aug 2024 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126952; cv=none; b=BwExNCqCujzlgZL5P4Fx4b/HvbHYcKaOG7qOfMB5BH/QfGMzrHZFyQxBp3ZIEdgxlHTsKmo6yaJ14ovFNMOawhCnlxf+mFxquKtHZ/M5WYaWA1E840ZBPOUI9JtXNr0EY8vQGODreMwQEzpDfcIJ2yPUzmZK0aRixECc42BodsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126952; c=relaxed/simple;
	bh=DJPQjIKvZ6zeRAPZ6vhdcN6NcRH6ngBpkYxzyaoM+ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlBsVu8uz/8aRuvsAHtK0Qf9sOJlWCwUExbzD7tiiCigycxYVTPCmnS5wDWq/qX2FlZLCOnUHhBAQrAZMol5XOE7NcofWpuR5sXcnScHBu7LBi6O29etPqN60O8PKqTDFSW7VeeTADP0/tPGm2kxbfTmzne2wEJyMXu0ED1lMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8h5X/Kh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c0d587e4so3473072a91.2;
        Mon, 19 Aug 2024 21:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724126950; x=1724731750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6njNv/4rXqWzlwtITZx6WVRsOW/7XujU2crzbRymBY=;
        b=G8h5X/Khx4qun/Zt+awO7iWKc9eLQjhxShmtvcPXu568WqB7oHnGwDS4kcz37iHZcd
         q0TZuRBZwnLd48M6U1Hwg3oorAHNz4+rbnd74XVD/M5XlHsu824gfPUlBUByGFc9EQmA
         JMFkCALdxM/BTjhC7X++Xovpd+lgwiyxT32OjPKrpdIEn/Tv6TEvcTgispDTi3tnnUxR
         Hfj2c+PRARs5e5GwWobLV8ve2N6/DqWTbnvJjPE7ggsmNWyoUJSp3gQ+gN+nB98Wuo2N
         CaFQy3cEhlFW0TjpFyucue8k6FsyN+JUWOPYVaSk2AdAksBGd7dU9T0Kji33IUwiBpLz
         VRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126950; x=1724731750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6njNv/4rXqWzlwtITZx6WVRsOW/7XujU2crzbRymBY=;
        b=iVEDv5aRSCrcKj4BnjrPHTBiiQcz8VGH6AXPR8ejlwpj3+iP7GtQvI7wl65bYP0KRj
         RbyWpvvMmAKrJvw5sj0Z+h03bpd0GjrSTtWgQBhVRjOrN3gJyDvIW3ByyQaP57IWsohb
         pvPPK/E4J7AKyzSrzE6uzHnC0GYwnVsk1MAqkFIvu99mOCzbzXQM/c5io9dvkwrmTyWx
         H/dGzRdwYMnvoW8hivLJLScUR/c/NAGrvTU9iH4dP6gfXTi4/tDQsKNIh+vgddvvq0Tk
         Lgef1eNgzUp3RIUXErHZXlmHDQWolaGvZ7i+VlIbV+d6qwg758d0L2ZwXQyQmWIaosM1
         Hu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9bXNpFYj6E8WICdcdLHc1t/RgU+lRTph+rlMz/rfvHQtq5vRbqahZ04zLAM0C3XvAa5N0BPwET5+Wz4EpzzTxAYK5Hc/wRDEXQWq9+VizmJUs89uQYdpUog0OCVgQPOjaQ0XUDhZT2IzbpTC1hrzoflyYmz3yPHS2xWNoqae0MrVuw81w/ftNjNgb
X-Gm-Message-State: AOJu0YyvtHYymTKiUlH4dk5KX+aXn8FlqX37gwlY4Mx5an92d3j3HkNt
	ayTg1SwiXy1axhfwxjzQ/CHCeNttonCEk+7Amdqu7kfu7ibNzWgF
X-Google-Smtp-Source: AGHT+IFqLE9TduCvGJ2ws69BAa2XjfZQon1GLxk76XlN2dkeMLUt8jRo+oNPGWL25xivTlokF0RXFw==
X-Received: by 2002:a17:90b:4d8f:b0:2d3:da82:28e0 with SMTP id 98e67ed59e1d1-2d3dfc37993mr10953009a91.9.1724126949903;
        Mon, 19 Aug 2024 21:09:09 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8149652a91.27.2024.08.19.21.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:09:09 -0700 (PDT)
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
Subject: [PATCH v10 1/6] Landlock: Add abstract UNIX socket connect restriction
Date: Mon, 19 Aug 2024 22:08:51 -0600
Message-Id: <9a365e0c8effb68a891f9dde3ef231d592a06f61.1724125513.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724125513.git.fahimitahera@gmail.com>
References: <cover.1724125513.git.fahimitahera@gmail.com>
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
abstract UNIX sockets from connecting to a process outside of
the same Landlock domain. It implements two hooks, unix_stream_connect
and unix_may_send to enforce this restriction.

Closes: https://github.com/landlock-lsm/linux/issues/7
Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

---
v10:
- Minor code improvement based on reviews on v9.
v9:
- Editting inline comments.
- Major refactoring in domain_is_scoped() and is_abstract_socket
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
---
 include/uapi/linux/landlock.h                |  27 ++++
 security/landlock/limits.h                   |   3 +
 security/landlock/ruleset.c                  |   7 +-
 security/landlock/ruleset.h                  |  24 +++-
 security/landlock/syscalls.c                 |  17 ++-
 security/landlock/task.c                     | 127 +++++++++++++++++++
 tools/testing/selftests/landlock/base_test.c |   2 +-
 7 files changed, 198 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 2c8dbc74b955..da8ee1bd4bee 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -44,6 +44,12 @@ struct landlock_ruleset_attr {
 	 * flags`_).
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
@@ -274,4 +280,25 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 /* clang-format on */
+
+/**
+ * DOC: scope
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
index 0f1b5b4c8f6b..a9ac2a0487d1 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -35,6 +35,8 @@ typedef u16 access_mask_t;
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 /* Makes sure all network access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
+/* Makes sure all scoped rights can be stored. */
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
@@ -280,6 +284,17 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 	ruleset->access_masks[layer_level].net |= net_mask;
 }
 
+static inline void
+landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
+			const access_mask_t scope_mask, const u16 layer_level)
+{
+	access_mask_t scoped_mask = scope_mask & LANDLOCK_MASK_SCOPE;
+
+	/* Should already be checked in sys_landlock_create_ruleset(). */
+	WARN_ON_ONCE(scope_mask != scoped_mask);
+	ruleset->access_masks[layer_level].scoped |= scoped_mask;
+}
+
 static inline access_mask_t
 landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
 				const u16 layer_level)
@@ -303,6 +318,13 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
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
index ccc8bc6c1584..c67836841e46 100644
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
@@ -170,8 +171,9 @@ static const struct file_operations ruleset_fops = {
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: unknown @flags, or unknown access, or too small @size;
- * - %E2BIG or %EFAULT: @attr or @size inconsistencies;
+ * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
+ * - %E2BIG: @attr or @size inconsistencies;
+ * - %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
  */
 SYSCALL_DEFINE3(landlock_create_ruleset,
@@ -213,9 +215,14 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
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
index 849f5123610b..aaa490cb3d88 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -13,6 +13,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <net/af_unix.h>
+#include <net/sock.h>
 
 #include "common.h"
 #include "cred.h"
@@ -108,9 +110,134 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return task_ptrace(parent, current);
 }
 
+/**
+ * domain_is_scoped - Checks if the client domain is scoped in the same
+ *			domain as the server.
+ *
+ * @client: IPC sender domain.
+ * @server: IPC receiver domain.
+ *
+ * Return true if the @client domain is scoped to access the @server,
+ * unless the @server is also scoped in the same domain as @client.
+ */
+static bool domain_is_scoped(const struct landlock_ruleset *const client,
+			     const struct landlock_ruleset *const server,
+			     access_mask_t scope)
+{
+	int client_layer, server_layer;
+	struct landlock_hierarchy *client_walker, *server_walker;
+
+	/* Quick return if client has no domain */
+	if (WARN_ON_ONCE(!client))
+		return false;
+
+	client_layer = client->num_layers - 1;
+	client_walker = client->hierarchy;
+	/*
+	 * client_layer must be a signed integer with greater capacity
+	 * than client->num_layers to ensure the following loop stops.
+	 */
+	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+
+	server_layer = server ? (server->num_layers - 1) : -1;
+	server_walker = server ? server->hierarchy : NULL;
+
+	/*
+	 * Walks client's parent domains down to the same hierarchy level
+	 * as the server's domain, and checks that none of these client's
+	 * parent domains are scoped.
+	 */
+	for (; client_layer > server_layer; client_layer--) {
+		if (landlock_get_scope_mask(client, client_layer) & scope)
+			return true;
+		client_walker = client_walker->parent;
+	}
+	/*
+	 * Walks server's parent domains down to the same hierarchy level as
+	 * the client's domain.
+	 */
+	for (; server_layer > client_layer; server_layer--)
+		server_walker = server_walker->parent;
+
+	for (; client_layer >= 0; client_layer--) {
+		if (landlock_get_scope_mask(client, client_layer) & scope) {
+			/*
+			 * Client and server are at the same level in the
+			 * hierarchy. If the client is scoped, the request is
+			 * only allowed if this domain is also a server's
+			 * ancestor.
+			 */
+			return server_walker != client_walker;
+		}
+		client_walker = client_walker->parent;
+		server_walker = server_walker->parent;
+	}
+	return false;
+}
+
+static bool sock_is_scoped(struct sock *const other,
+			   const struct landlock_ruleset *const domain)
+{
+	const struct landlock_ruleset *dom_other;
+
+	/* the credentials will not change */
+	lockdep_assert_held(&unix_sk(other)->lock);
+	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
+	return domain_is_scoped(domain, dom_other,
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+}
+
+static bool is_abstract_socket(struct sock *const sock)
+{
+	struct unix_address *addr = unix_sk(sock)->addr;
+
+	if (!addr)
+		return false;
+
+	if (addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
+	    addr->name[0].sun_path[0] == '\0')
+		return true;
+
+	return false;
+}
+
+static int hook_unix_stream_connect(struct sock *const sock,
+				    struct sock *const other,
+				    struct sock *const newsk)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	/* quick return for non-sandboxed processes */
+	if (!dom)
+		return 0;
+
+	if (is_abstract_socket(other) && sock_is_scoped(other, dom))
+		return -EPERM;
+
+	return 0;
+}
+
+static int hook_unix_may_send(struct socket *const sock,
+			      struct socket *const other)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	if (!dom)
+		return 0;
+
+	if (is_abstract_socket(other->sk) && sock_is_scoped(other->sk, dom))
+		return -EPERM;
+
+	return 0;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
+	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
+	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
 };
 
 __init void landlock_add_task_hooks(void)
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 3b26bf3cf5b9..1bc16fde2e8a 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(6, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.34.1


