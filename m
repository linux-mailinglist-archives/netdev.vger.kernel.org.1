Return-Path: <netdev+bounces-111994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302293470F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D02FB21BF3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727441C7F;
	Thu, 18 Jul 2024 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfJdhaoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863161E520;
	Thu, 18 Jul 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276151; cv=none; b=CM79d97X8urIs58TlUi5ZGcnCr6WMN2JrqqtDfUJwcNwz1HTqGtVcLU+3YMapr8cSXNMRu+2Y3/YufowS64PIPkmWW+qbZxiQpMkr+BR41Y28zPMVh+OmsHjGxEvKrtoghLNtfF7Rgw3k3idpkv6dSqx9HeJJN1XzVMy94gpyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276151; c=relaxed/simple;
	bh=QZsBQu2+ZOULhLORd0HOsY1lkGTtwIs1aRgh5oxidJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqPeI8lUI9edt+tLUfifDcjXQQtaUNCf3vTicst4vNsl2pl+wlUuCf0shR2xwgfdnJrpjIHDSNoKCn5Z5OHushcBgdKLwNqD+x6tHoDIxdyqPrdDbLV86oa/7C3NQcR0qFwSmXrv0lnWZjyQfBuQb/h8sFEnELUNa3otq7dUgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfJdhaoJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fbfb7cdb54so3231095ad.2;
        Wed, 17 Jul 2024 21:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721276149; x=1721880949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Rvnx0iLLDz0SXxKhw8U6japHLNXczTiOeG//E2Ws8c=;
        b=RfJdhaoJE02s3v9v/Cq24sT4Dm3ygmrv3FV4PxMpzIFL61VyawgXWg0J/kiXTdzTCt
         Z7XsrblOeeErnOqT7kF7SmP5jJUyAjDlgRvAShu34qkmb7e+MsejJxEA9CB76t0EMQJD
         D7T2r3P7IYN56IMSF280fV/XnYzLRfzZC5fkF78dB/rzgEanB+yQx/J5Aqf1D2QyzwHD
         3jzYlJbf/Foa3cfJbcxhpDjU7ya1EEEktn05YxjvDGZJBxjLpZ0EnLibW86X/G+SHbQG
         h4V0FOlTOh/6FBQ5ednsrDqjxB4ccP7DEg9fTqajgEvV+lrNVJmq8VR7EcBefMFiBVdB
         csMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721276149; x=1721880949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Rvnx0iLLDz0SXxKhw8U6japHLNXczTiOeG//E2Ws8c=;
        b=c4F/lVcf9G5qhZyy010gcZEWKGhFpsNykpl6Q/VIQKr+ayaHbv0+6Kns8pDDUJajI9
         kY/DqiL7tBfVbDlYFmUlByG+Zws+OJiXnWA0IVVRBEOpGPUw42LpEmKxiVpKje0JTlgJ
         gQtrkX6kaLwhRBLhk/8GFZ9hGP9WtIWljqv7sexEajF2IanZ+jOmqkOJu29mO1vfwx21
         oxVlPGDb00ejTlEAvKY4E33Dd5/CIN/4N13LecjRN6SubuWeFPZlaK/Dpdctw06VkMfh
         2RdXZAbox6ox/68zlP0Jch49/zYinudlSiqxlVVUQR6G9/yLh657OlfjfqrvafUiAr4o
         LRsA==
X-Forwarded-Encrypted: i=1; AJvYcCUcus9VT/smp6b8folJABpC5eOp8K9CSNMZFgiif4x4X6Zin5Jagnj10ZkiSqlNsYt2v+hmOmOOskHGQ6VdiCkbIb9f48qvcnpY0SN62GqXNfH12PH4WQ5QOE+3zbaghMVgFGtxLHoqcV82NZBn2/RJe3/G874wQlDyPNeybHqs1YGEXgUAo8eb1rUl
X-Gm-Message-State: AOJu0Yx/byZbMFpCk19T5gPNafU94gbWDhHRqMz4h3wfQEpWGSgSirbU
	qgQttFh0Tr2AavAsMy8Xoze8KUWYVYZpp0IrimxFzO5K10qgoZJs
X-Google-Smtp-Source: AGHT+IFMyO1WrArghfmYPlJfxtrXHBx0wmu9FCeMWeocrfk9zIdfJsumAlzR2ySq9yVAse54KGZdCA==
X-Received: by 2002:a17:902:fa0c:b0:1f7:1528:7b8a with SMTP id d9443c01a7336-1fc4e6887d3mr25270485ad.41.1721276148759;
        Wed, 17 Jul 2024 21:15:48 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38dc0sm83152785ad.215.2024.07.17.21.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 21:15:47 -0700 (PDT)
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
Subject: [PATCH v7 1/4] Landlock: Add abstract unix socket connect restriction
Date: Wed, 17 Jul 2024 22:15:19 -0600
Message-Id: <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721269836.git.fahimitahera@gmail.com>
References: <cover.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch introduces a new "scoped" attribute to the
landlock_ruleset_attr that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET"
to scope abstract unix sockets from connecting to a process outside of
the same landlock domain.

This patch implement two hooks, "unix_stream_connect" and "unix_may_send" to
enforce this restriction.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

-------
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
 - Using file's FD credentials instead of credentials stored in peer_cred
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

[1]https://lore.kernel.org/outreachy/Zmi8Ydz4Z6tYtpY1@tahera-OptiPlex-5000/T/#m8cdf33180d86c7ec22932e2eb4ef7dd4fc94c792
-------

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 include/uapi/linux/landlock.h |  29 +++++++++
 security/landlock/limits.h    |   3 +
 security/landlock/ruleset.c   |   7 ++-
 security/landlock/ruleset.h   |  23 ++++++-
 security/landlock/syscalls.c  |  14 +++--
 security/landlock/task.c      | 112 ++++++++++++++++++++++++++++++++++
 6 files changed, 181 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..9cd881673434 100644
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
index 03b470f5a85a..799a50f11d79 100644
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
index 849f5123610b..597d89e54aae 100644
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
@@ -108,9 +110,119 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return task_ptrace(parent, current);
 }
 
+static int walk_and_check(const struct landlock_ruleset *const child,
+			  struct landlock_hierarchy **walker, int i, int j,
+			  bool check)
+{
+	if (!child || i < 0)
+		return -1;
+
+	while (i < j && *walker) {
+		if (check && landlock_get_scope_mask(child, j))
+			return -1;
+		*walker = (*walker)->parent;
+		j--;
+	}
+	if (!*walker)
+		pr_warn_once("inconsistency in landlock hierarchy and layers");
+	return j;
+}
+
+/**
+ * domain_sock_scope - Checks if client domain is scoped in the same
+ *			domain as server.
+ *
+ * @client: Connecting socket domain.
+ * @server: Listening socket domain.
+ *
+ * Checks if the @client domain is scoped, then the server should be
+ * in the same domain to connect. If not, @client can connect to @server.
+ */
+static bool domain_sock_scope(const struct landlock_ruleset *const client,
+			      const struct landlock_ruleset *const server)
+{
+	size_t l1, l2;
+	int scope_layer;
+	struct landlock_hierarchy *cli_walker, *srv_walker;
+
+	if (!client)
+		return true;
+
+	l1 = client->num_layers - 1;
+	cli_walker = client->hierarchy;
+	if (server) {
+		l2 = server->num_layers - 1;
+		srv_walker = server->hierarchy;
+	} else
+		l2 = 0;
+
+	if (l1 > l2)
+		scope_layer = walk_and_check(client, &cli_walker, l2, l1, true);
+	else if (l2 > l1)
+		scope_layer =
+			walk_and_check(server, &srv_walker, l1, l2, false);
+	else
+		scope_layer = l1;
+
+	if (scope_layer == -1)
+		return false;
+
+	while (scope_layer >= 0 && cli_walker) {
+		if (landlock_get_scope_mask(client, scope_layer) &
+		    LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET) {
+			if (!server)
+				return false;
+
+			if (srv_walker == cli_walker)
+				return true;
+
+			return false;
+		}
+		cli_walker = cli_walker->parent;
+		srv_walker = srv_walker->parent;
+		scope_layer--;
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
+
+	/* other is scoped, they connect if they are in the same domain */
+	return domain_sock_scope(dom, dom_other);
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


