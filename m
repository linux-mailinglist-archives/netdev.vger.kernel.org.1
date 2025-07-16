Return-Path: <netdev+bounces-207631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E26B08054
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C91581836
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D42EE61D;
	Wed, 16 Jul 2025 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQ8qjvgC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BEB2EF9D2
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703967; cv=none; b=PYgN09wPuSno65nDA3bDCXoKdCoW4ib/cX2ytR/UfrTcbJYCej+yzc+Zqz5wE+aj5HUVRZEUNCTK1H89/d04UTgrCeM8+ohOdLtkvjYH/5i5WRIKfHiuzX/9L9fHRFgRIfKgedrse+w/mr6eve40xjRoFN0MUNbVEQqIFOBMGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703967; c=relaxed/simple;
	bh=YrPYEnjFvkfdxw8uUUCze2Zh3oIorcIEjMmGx8hNFGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2gVqP2QRU17biQ6pLTf4QEOQHnanKpHU2nlF6f26RDiusHYuCSFZecJmrfpWV3788nxR06Suuz2N0Z7KCs0+p58e5cACoVMJP3rrfAmnpi1XGW7zmrA/rcPJSqd3sUgZ7BkDI82NYmMbNJSXY97xI6KhHylmO79gdXqOa/8ogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQ8qjvgC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31bd4c3359so129178a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703964; x=1753308764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGHFYH5Acvp+/P4Vbi/XosRe+Q/ub7EiR2HKvJqog9c=;
        b=vQ8qjvgCPzHzBnpBGU/kzfdot9OCpOGS0a77HASoLlPZ9x2X+vd7qXD7AmzEDwjvdn
         U/2PaHSlg4r+0KqJ79njA9TVA4853ciBGwDKZZE2vmoXmDDI0i7JY5oRvvGJo5f/axlH
         /C1xOoOGfkFaOJYihf/bL1DVgEPVpH1aPhesBIkCe4VoTcEQhr7/9BljwehGmpLu7Zwp
         6nXNAb90UAmfoqyDh/gaKDdUdUpkk67racY9Y3Yv8Bte10VDGhKF1l/byzhQwOCjhCwG
         3lQDNTLPEz8RhBhEilurFWaqYo4vFcbmJZlSYnvTEkSCSPX73ySDCBjeTWuugJeRGJUV
         5g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703964; x=1753308764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGHFYH5Acvp+/P4Vbi/XosRe+Q/ub7EiR2HKvJqog9c=;
        b=OKZyTlpwG2R68g0r2nBC8SgIe9rfiVRZ7cN86wKWGjZyJlSnrSOBPjiVWrOkNb8HKv
         H71tEVxhFuKLFQAOzTj0VzliIwQi8hf6rE/hv5E2m7EhdppLWX/d+s38KTM+dmgD44wT
         7rWbrf0s5YsTxd/24S6clO6T1p6YETehd3taC7Mo4Ernz3cfZt+PxwH31ulIAWtSPaC0
         uMLRl31JOU7gHqLDq2QxTuOmOQHIQL6W63feQ+IHdjLDCwqPgo9ToR5LNFlKa8FPMVfc
         m5FY6lGvF1u/ZrqvN0RqGYvwydmfPSgf+k5TpWcynOQ2VMmL1LFceTpnTkZNLiDgyJv9
         mhfg==
X-Forwarded-Encrypted: i=1; AJvYcCX4hs1IiO7+ond8Gl1Uh+9LmsBh2d8g6oK7qIbDrfR1lGvPeAWGYZaYMcoNObqx9gPuFbtNJNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjq0BT2uICngrhVjDERGTyxc5gZwNPT+lSLhCXX3hfJgxcwZLp
	+aM6EH8QRCeGN9OlpU8vRaRfVkU4SvqDNGh5doBdOlFGDoCpL8g9m2ARKg6duQCMFbDqA8q0xzP
	Vg5s4kw==
X-Google-Smtp-Source: AGHT+IFhCNhZVZxQKdUeSEDwJFIUzr7UmJmoORttZ8j54/2yhxfnRgtFzdQz9hQLiRPgAXVJ56KWqFjHF64=
X-Received: from pjbeu5.prod.google.com ([2002:a17:90a:f945:b0:312:1900:72e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2685:b0:311:df4b:4b7a
 with SMTP id 98e67ed59e1d1-31c9f4b50d3mr5643956a91.29.1752703964044; Wed, 16
 Jul 2025 15:12:44 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:19 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-15-kuniyu@google.com>
Subject: [PATCH v3 net-next 14/15] neighbour: Protect tbl->phash_buckets[]
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
index 6096c8d41fc95..7e8a672dad6d1 100644
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


