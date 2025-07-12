Return-Path: <netdev+bounces-206376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAFEB02CEA
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9BE3A294B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827E322652D;
	Sat, 12 Jul 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTKQ9e3m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997B22F76E
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352541; cv=none; b=M3NcydGqpfN/+RVLYpknLEa/YJOqdh3q7xdKm+kW/+LQNoPzP94aWM/46r7e9nFlcPJk2Sl8TxJIeGAJ/PRkmQvmLOM+fkS51a45VXXNSrcF2RszSuNn3+Guoq1mH5ykc5pWAP2CfZtTvK93vFKVWSzo28llDqPVU9B+M5Lqnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352541; c=relaxed/simple;
	bh=7tshF0jSsdawG6LXQEWdD9Z+x947BNSvbQCVG9Tj+Zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eTxCHjzDQQ5vl52vZOi3VTxOHyFv1U+/bgulgsD+xfUv1vOl+GxzxACfrfcfn1kdbJLQtz0KpE/bVUhcSMAVvzkwN4cmt8bUbr0VkJO0JAVustonwBN0d/IcNag+57Jb17x6aKm8epZHDiIKU1otDdh5ftlpVNmbLaLs/ujNmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTKQ9e3m; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so2538660b3a.3
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352539; x=1752957339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3bR3c+OcvRTN+9kfeQEwJZ8z/TTvXsMcOgnC4tFC7Y=;
        b=DTKQ9e3mLAWnBoHGL+N/GjiB0gnpSntSsjg8F8xIhza3dCRxdC5GTuScmoa1HYuiDA
         I4jzEJsrLTgBy35ncQ4N4DAEFbwOqFihAvKp+k7/Bvs1O+RzvPUkDa4ace2K5H/SurAi
         T36z2F83+dkm4seyd8Xh+JrIZvFJBSIqJ+Di9yJKViF1vwEK7KlQp8hUjESdX0PukV7y
         nsCObhYX+PuU8DmfrQwIELPyZmnjfRTN3Sl/ogFjucC77tA7trI0nbFoLFV26owirtQh
         QfzwBApLOYY/xODMDOTq+vBtkWAkQu+Z1RkKKdwQPxlFMlwcK4troTwH5bMNVNL0M0/g
         S+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352539; x=1752957339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3bR3c+OcvRTN+9kfeQEwJZ8z/TTvXsMcOgnC4tFC7Y=;
        b=oS8ZZvuPvcJdMJpv6cUFnMoV5Z3r+J4Gl2OfOlt7kpTqqURtz4iqmr/DJPhbnpvhGj
         WPhtoU6+h+RaRTOlqASlRjfPLO7XQTeUnRWoGhWDzUhhXSotsrAWJIayzpEOmFFUHNXe
         t1zNNe/xRnU0LXQ/2jaw/HljzCVTg5Up1B6ZmMxP6RLhnRPJ6ACztIbwuUzkhHOh0yc7
         ikWs3uOKqdmJsxXurYpqQKPKU3hNlpdfGPLIDstrtoZ18Lw1dRW7fPGFOpFQv1pNovQk
         JUWEFQgRva5YqqDb0pgYD8/zTYLPlSwMdHOUKfQkrFiCrrEUhcFk9iyApa973qYW6Nw3
         ZBxw==
X-Forwarded-Encrypted: i=1; AJvYcCXdhmdb2sMjAYtlZIVxeDB/2zzDWo/s8W8CthXj+bBHS7T9ZJ2Ki3m9icbuzYT+hmIe43TsIuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUOv8204y0CWzbpAzYtDH5TReHk2D2qioZy7+FikNEAhOd//G
	/u1f6jG3NQ9vl86QaJXiPFzARcsOi+iWFBODznmKrGLTMuEM4YHagycLYEJDTEBfMPgn6wzAMVV
	xXGNpuQ==
X-Google-Smtp-Source: AGHT+IGKHQRSU/XJaQBPgoO8B42KzvR4jty8iIRNXAOvs8/vkp70D0o0kd8E1n+5TgKjuMYprIJ/nyRqkX8=
X-Received: from pfbbk2.prod.google.com ([2002:aa7:8302:0:b0:748:e22c:600c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e04:b0:736:8c0f:7758
 with SMTP id d2e1a72fcca58-74ee177a388mr9817711b3a.10.1752352539124; Sat, 12
 Jul 2025 13:35:39 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:23 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-15-kuniyu@google.com>
Subject: [PATCH v2 net-next 14/15] neighbour: Protect tbl->phash_buckets[]
 with a dedicated mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tbl->phash_buckets[] is only modified in the slow path by pneigh_create()
and pneigh_delete() under the table lock.

Both of them are called under RTNL, so no extra lock is needed, but we
will remove RTNL from the paths.

pneigh_create() looks up a pneigh_entry, and this part can be lockless,
but it would complicate the logic like

  1. lookup
  2. allocate pengih_entry for GFP_KERNEL
  3. lookup again but under lock
  4. if found, return it after freeing the allocated memory
  5. else, return the new one

Instead, let's add a per-table mutex and run lookup and allocation
under it.

Note that updating pneigh_entry part in neigh_add() is still protected
by RTNL and will be moved to pneigh_create() in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  1 +
 net/core/neighbour.c    | 39 +++++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index f8c7261cd4ebb..f333f9ebc4259 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -240,6 +240,7 @@ struct neigh_table {
 	unsigned long		last_rand;
 	struct neigh_statistics	__percpu *stats;
 	struct neigh_hash_table __rcu *nht;
+	struct mutex		phash_lock;
 	struct pneigh_entry	__rcu **phash_buckets;
 };
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 95d18cab6d3da..bc9c2b749621d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -54,9 +54,8 @@ static void neigh_timer_handler(struct timer_list *t);
 static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
-static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				     struct net_device *dev,
-				     bool skip_perm);
+static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
+			  bool skip_perm);
 
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
@@ -437,7 +436,9 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, skip_perm);
-	pneigh_ifdown_and_unlock(tbl, dev, skip_perm);
+	write_unlock_bh(&tbl->lock);
+
+	pneigh_ifdown(tbl, dev, skip_perm);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
@@ -731,7 +732,7 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 	key_len = tbl->key_len;
 	hash_val = pneigh_hash(pkey, key_len);
 	n = rcu_dereference_check(tbl->phash_buckets[hash_val],
-				  lockdep_is_held(&tbl->lock));
+				  lockdep_is_held(&tbl->phash_lock));
 
 	while (n) {
 		if (!memcmp(n->key, pkey, key_len) &&
@@ -739,7 +740,7 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 		    (n->dev == dev || !n->dev))
 			return n;
 
-		n = rcu_dereference_check(n->next, lockdep_is_held(&tbl->lock));
+		n = rcu_dereference_check(n->next, lockdep_is_held(&tbl->phash_lock));
 	}
 
 	return NULL;
@@ -754,11 +755,9 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 	unsigned int key_len;
 	u32 hash_val;
 
-	ASSERT_RTNL();
+	mutex_lock(&tbl->phash_lock);
 
-	read_lock_bh(&tbl->lock);
 	n = pneigh_lookup(tbl, net, pkey, dev);
-	read_unlock_bh(&tbl->lock);
 	if (n)
 		goto out;
 
@@ -780,11 +779,10 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 	}
 
 	hash_val = pneigh_hash(pkey, key_len);
-	write_lock_bh(&tbl->lock);
 	n->next = tbl->phash_buckets[hash_val];
 	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
-	write_unlock_bh(&tbl->lock);
 out:
+	mutex_unlock(&tbl->phash_lock);
 	return n;
 }
 
@@ -806,14 +804,16 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 	key_len = tbl->key_len;
 	hash_val = pneigh_hash(pkey, key_len);
 
-	write_lock_bh(&tbl->lock);
+	mutex_lock(&tbl->phash_lock);
+
 	for (np = &tbl->phash_buckets[hash_val];
 	     (n = rcu_dereference_protected(*np, 1)) != NULL;
 	     np = &n->next) {
 		if (!memcmp(n->key, pkey, key_len) && n->dev == dev &&
 		    net_eq(pneigh_net(n), net)) {
 			rcu_assign_pointer(*np, n->next);
-			write_unlock_bh(&tbl->lock);
+
+			mutex_unlock(&tbl->phash_lock);
 
 			if (tbl->pdestructor)
 				tbl->pdestructor(n);
@@ -822,18 +822,20 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 			return 0;
 		}
 	}
-	write_unlock_bh(&tbl->lock);
+
+	mutex_unlock(&tbl->phash_lock);
 	return -ENOENT;
 }
 
-static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				     struct net_device *dev,
-				     bool skip_perm)
+static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
+			  bool skip_perm)
 {
 	struct pneigh_entry *n, __rcu **np;
 	LIST_HEAD(head);
 	u32 h;
 
+	mutex_lock(&tbl->phash_lock);
+
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
 		np = &tbl->phash_buckets[h];
 		while ((n = rcu_dereference_protected(*np, 1)) != NULL) {
@@ -849,7 +851,7 @@ static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 		}
 	}
 
-	write_unlock_bh(&tbl->lock);
+	mutex_unlock(&tbl->phash_lock);
 
 	while (!list_empty(&head)) {
 		n = list_first_entry(&head, typeof(*n), free_node);
@@ -1796,6 +1798,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
 
 	rwlock_init(&tbl->lock);
+	mutex_init(&tbl->phash_lock);
 
 	INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
 	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
-- 
2.50.0.727.gbf7dc18ff4-goog


