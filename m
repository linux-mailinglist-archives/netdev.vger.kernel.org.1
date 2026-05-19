Return-Path: <netdev+bounces-289621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAAJDr3dDGphpAUAu9opvQ
	(envelope-from <netdev+bounces-289621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:01:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95658562C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766C7307F2B0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9BE3E92AE;
	Tue, 19 May 2026 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KEjKzvut"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D93EBF35
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227951; cv=none; b=i7RliHQVbBonSXgGcJ2K67q6BObKdgA4BJW9ZqaRg0P/r8BiN4BaO4k6B3e4lElrmRTMawrz+2ha1+zeifYlitiN/8CgGJ2urpOJCmjYhVsk94msKzydfOchvs/kBaE/+ZjdBVvC7XtulEcWx50eVP3FcFlDjXCWYkGo10qihzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227951; c=relaxed/simple;
	bh=dEk75An2YkA3CBnlcplMbTnVw3keCaXWCpF9FHp6TqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inZr5l3i52WieMc7DMQNJ0fwT7NzloWkpTt8HZJ8o62TC1Ur2CGNM0I8TNA+R8LnG0i4mSXS0Y2NMLUlLDKVbP0sP57rWrr5HBv2YCXU8HAwz74ZEeWPiA12scjgp9BbdoPkuZFDVHlzCCXY9I/OuKFwCfpXbyjzmP7kbgx0oMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KEjKzvut; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOYHOKQDvpyW5zXK61LIUEiKW6F8YP2r9o8T71QFzlo=;
	b=KEjKzvutR2zokl38wIxK22byY4kPyfevWdzlE1c6aukMmHzvb29Kaxlqj+zeC+N8kEQm+b
	xuyDGspL1ZEL+3JAkowqDrlJSxstzXEcGonK0PDsrVq/rh/QsBVMuR63HcO1U1cf/9MOmw
	oyFzm+LYaek7oWSbrv+KRttt0ispm2A=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 02/12] bpf: Make struct_ops tasks_rcu grace period optional
Date: Tue, 19 May 2026 14:58:09 -0700
Message-ID: <20260519215841.2984970-3-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289621-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 9E95658562C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

bpf_struct_ops_map_free() currently waits for both a regular RCU grace
period and a tasks RCU grace period for every struct_ops map through
synchronize_rcu_mult(call_rcu, call_rcu_tasks).

A regular RCU grace period is still required for all struct_ops maps
because the struct_ops trampoline ksyms requires a rcu grace period
(take a look at the list_del_rcu in __bpf_ksym_del).
Add a map_free_pre_rcu() callback so the struct_ops map can remove
ksyms before bpf_map_put() wait for the regular rcu grace period.

The tasks RCU grace period is only needed by tcp_congestion_ops.
Add free_after_tasks_rcu_gp only to struct bpf_struct_ops instead
of the bpf_map.

When CONFIG_TASKS_RCU=n, synchronize_rcu_tasks() is the same as
synchronize_rcu(). Since all struct_ops maps now complete a regular RCU
grace period before bpf_struct_ops_map_free() runs, skip the extra
synchronize_rcu_tasks() call in this case.

This cleanup prepares for a later patch that needs to support
free_after_mult_rcu_gp.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h         |  7 +++++++
 kernel/bpf/bpf_struct_ops.c | 31 +++++++++++++------------------
 kernel/bpf/syscall.c        |  3 +++
 net/ipv4/bpf_tcp_ca.c       | 16 ++++++++++++++++
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b28cacc3075..a276eada19c4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -86,6 +86,7 @@ struct bpf_map_ops {
 	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
 	void (*map_release)(struct bpf_map *map, struct file *map_file);
 	void (*map_free)(struct bpf_map *map);
+	void (*map_free_pre_rcu)(struct bpf_map *map);
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
 	void (*map_release_uref)(struct bpf_map *map);
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
@@ -1992,6 +1993,11 @@ struct btf_member;
  *	   unloaded while in use.
  * @name: The name of the struct bpf_struct_ops object.
  * @func_models: Func models
+ * @free_after_tasks_rcu_gp: Set to true if it needs the bpf core to wait for
+ *                           a tasks_rcu gp before freeing the struct_ops map
+ *                           and its progs. It is unnecessary if the @unreg
+ *                           has waited for the correct rcu gp or the @unreg
+ *                           has ensured all struct_ops prog has finished running.
  */
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
@@ -2010,6 +2016,7 @@ struct bpf_struct_ops {
 	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
+	bool free_after_tasks_rcu_gp;
 };
 
 /* Every member of a struct_ops type has an instance even a member is not
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 08791180d71d..28eab24ef0ed 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -983,9 +983,18 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 	bpf_map_area_free(st_map);
 }
 
+static void bpf_struct_ops_map_free_pre_rcu(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
+	bpf_struct_ops_map_del_ksyms(st_map);
+}
+
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	struct bpf_struct_ops *st_ops = st_map->st_ops_desc->st_ops;
+	bool tasks_rcu = st_ops->free_after_tasks_rcu_gp;
 
 	/* st_ops->owner was acquired during map_alloc to implicitly holds
 	 * the btf's refcnt. The acquire was only done when btf_is_module()
@@ -996,24 +1005,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 
 	bpf_struct_ops_map_dissoc_progs(st_map);
 
-	bpf_struct_ops_map_del_ksyms(st_map);
-
-	/* The struct_ops's function may switch to another struct_ops.
-	 *
-	 * For example, bpf_tcp_cc_x->init() may switch to
-	 * another tcp_cc_y by calling
-	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
-	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
-	 * and its refcount may reach 0 which then free its
-	 * trampoline image while tcp_cc_x is still running.
-	 *
-	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
-	 * to finish. bpf-tcp-cc prog is non sleepable.
-	 * A rcu_tasks gp is to wait for the last few insn
-	 * in the tramopline image to finish before releasing
-	 * the trampoline image.
-	 */
-	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
+	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
+		synchronize_rcu_tasks();
 
 	__bpf_struct_ops_map_free(map);
 }
@@ -1122,6 +1115,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
+	map->free_after_rcu_gp = true;
 
 	return map;
 
@@ -1154,6 +1148,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
 	.map_alloc_check = bpf_struct_ops_map_alloc_check,
 	.map_alloc = bpf_struct_ops_map_alloc,
 	.map_free = bpf_struct_ops_map_free,
+	.map_free_pre_rcu = bpf_struct_ops_map_free_pre_rcu,
 	.map_get_next_key = bpf_struct_ops_map_get_next_key,
 	.map_lookup_elem = bpf_struct_ops_map_lookup_elem,
 	.map_delete_elem = bpf_struct_ops_map_delete_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6600e126fbfb..d0e8e9c8c888 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -950,6 +950,9 @@ void bpf_map_put(struct bpf_map *map)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
 
+		if (map->ops->map_free_pre_rcu)
+			map->ops->map_free_pre_rcu(map);
+
 		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
 		/* RCU tasks trace grace period implies RCU grace period. */
 		if (READ_ONCE(map->free_after_mult_rcu_gp))
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..e224ecafbd69 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -339,6 +339,22 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.validate = bpf_tcp_ca_validate,
 	.name = "tcp_congestion_ops",
 	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
+	/* The struct_ops's function may switch to another struct_ops.
+	 *
+	 * For example, bpf_tcp_cc_x->init() may switch to
+	 * another tcp_cc_y by calling
+	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
+	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
+	 * and its refcount may reach 0 which then free its
+	 * trampoline image while tcp_cc_x is still running.
+	 *
+	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
+	 * to finish. bpf-tcp-cc prog is non sleepable.
+	 * A rcu_tasks gp is to wait for the last few insn
+	 * in the tramopline image to finish before releasing
+	 * the trampoline image.
+	 */
+	.free_after_tasks_rcu_gp = true,
 	.owner = THIS_MODULE,
 };
 
-- 
2.53.0-Meta


