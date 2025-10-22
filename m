Return-Path: <netdev+bounces-231535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E9BFA157
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E159353F50
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AFC2ED161;
	Wed, 22 Oct 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4J26Vsz0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F792ECEBB
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111625; cv=none; b=CrtWTN87pVd8mAd8ER6RfY5RCCzo04f4Yt2Z+1Ig0e9AyTlE9X68ss0u7YnN2uyfcuZT2erMNxcxxosY1FT/Dnyv8rnQoXwvFBwHzFuJWh8FxZNCaziUm++pvzTKZJ90a81IdDf/snm60DyGcsaSWzFb1JYSjJyE6E40zMwo84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111625; c=relaxed/simple;
	bh=u70u4TDQeFuEhhnF6jFGHC1wABQCr7h6uxT9sTBo0SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pqWFR3rl9whNNDfjEDLVYyQ918cP03C/868paWHvy/79aUD/HNcGDJsp5QSmk4ozK7xIKQZ3895ajmFees4S5a1VG18Qb3CELtOhQ6udcIWaN31Q55+V3eWrLbc6FZ2B2knr05SCuYhktVoCyKBZYAYP7KLQC1xvEdSz4MkKLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4J26Vsz0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so5850194a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761111623; x=1761716423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBIMg0Ah6p/i8OT6Fjp8It0toWfCfot1R3jICbia4Fk=;
        b=4J26Vsz0bsWCL5ICqjCsCAp5TLKLreEW5WXdNKL6RcHK+v/NpYxtQ1wCwuczz/4A7C
         kfQ0G35PmN8uvy817FmVuL6nYeR87kTir03cEsVjle1QnlWDUkPD+Tm95crenVBnUC2/
         9Rxq0gzeFa9EJd73RnWraYoW0iYVohKCtPuVuwZnQqdefKb0/PexwwVx8ejb7jQWRwtL
         8VnvqElyJQIMlxu5kH24YYL+hfN2+VzTgTj1KEmoTJ6sf2mUIUp7nXhLkthjHANU9KaM
         fdPmOvYoegt8eb+Kn1xldcmakFBMeOLKMIjdQF4xRnfvv/psBh7dcvdg764bQlFj6IIE
         jFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111623; x=1761716423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBIMg0Ah6p/i8OT6Fjp8It0toWfCfot1R3jICbia4Fk=;
        b=wzAevclBwohhOqMuewHQWxi7flYam8Sz1tndMdpzQmYZkQxuVAm0478aGVQDMcTRpM
         +o8fL/6IoyFkBDSoeCOso+6VJv7oGr9+Xox7OJKnfGL9iMhgB/mXcUF8PpX7Q/Bwy4jL
         YYbnjJwCguz3kiTW7kWntyj59KjqwlsdRIYBlEEH1tkeD2O7AkIw2sre9Dw8U6CAS9r2
         hVtTvX5Jc3jtJNbXESl+pboJEe1tRAqf5yK8FnnfN9DycNjaQp/pWgdF1iQwnMgT+mhc
         kKlZ4HFl/3lugIStJC5xwGgOWj5tJ5zaHDXG5yZEbVW7GKGWcqcz+pdGGBzBsdd5ZSN0
         7Gmw==
X-Forwarded-Encrypted: i=1; AJvYcCWjNzePTaGDNemF+Qf7K+Lr06v+EQ2u68KeIrzyNI2RvRPKrRYTsqmGQPVXsZOYPLXpg4oISGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxeszUBDHqX7vqlNPB9RTvmyPQOck9w5gzdR+sb4cDdIAIHqj
	u/DYGORngOH4v6AuyA6gWu48RJTGVX+VAHKp2X6axxXMx8tmFjleLqY1sktAAKRBCW71kyd7Rjs
	atRkVhQ==
X-Google-Smtp-Source: AGHT+IFbX+wUJFJc69aHe5CZJrD5gU23gL8qcIBiw4plCy7ssGr3+2Z5rW3tr7aNdeCXqMRN1jsCwtgMpVI=
X-Received: from pjbpt2.prod.google.com ([2002:a17:90b:3d02:b0:329:e84e:1c50])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1343:b0:30a:4874:5397
 with SMTP id 98e67ed59e1d1-33bcf87f454mr25087920a91.9.1761111623010; Tue, 21
 Oct 2025 22:40:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:39:49 +0000
In-Reply-To: <20251022054004.2514876-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251022054004.2514876-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/5] neighbour: Convert rwlock of struct
 neigh_table to spinlock.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Only neigh_for_each() and neigh_seq_start/stop() are on the
reader side of neigh_table.lock.

Let's convert rwlock to the plain spinlock.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  2 +-
 net/atm/clip.c          |  4 +--
 net/core/neighbour.c    | 68 +++++++++++++++++++++--------------------
 net/ipv4/arp.c          |  4 +--
 4 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 998ff9eccebb7..2dfee6d4258af 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -238,7 +238,7 @@ struct neigh_table {
 	atomic_t		gc_entries;
 	struct list_head	gc_list;
 	struct list_head	managed_list;
-	rwlock_t		lock;
+	spinlock_t		lock;
 	unsigned long		last_rand;
 	struct neigh_statistics	__percpu *stats;
 	struct neigh_hash_table __rcu *nht;
diff --git a/net/atm/clip.c b/net/atm/clip.c
index f7a5565e794ef..8f152e5fa6594 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -168,10 +168,10 @@ static int neigh_check_cb(struct neighbour *n)
 
 static void idle_timer_check(struct timer_list *unused)
 {
-	write_lock(&arp_tbl.lock);
+	spin_lock(&arp_tbl.lock);
 	__neigh_for_each_release(&arp_tbl, neigh_check_cb);
 	mod_timer(&idle_timer, jiffies + CLIP_CHECK_INTERVAL * HZ);
-	write_unlock(&arp_tbl.lock);
+	spin_unlock(&arp_tbl.lock);
 }
 
 static int clip_arp_rcv(struct sk_buff *skb)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 807a0d2457728..bb2a35f6cfe44 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -81,7 +81,7 @@ static struct hlist_head *neigh_get_dev_table(struct net_device *dev, int family
 }
 
 /*
-   Neighbour hash table buckets are protected with rwlock tbl->lock.
+   Neighbour hash table buckets are protected with tbl->lock.
 
    - All the scans/updates to hash buckets MUST be made under this lock.
    - NOTHING clever should be made under this lock: no callbacks
@@ -149,7 +149,7 @@ static void neigh_update_gc_list(struct neighbour *n)
 {
 	bool on_gc_list, exempt_from_gc;
 
-	write_lock_bh(&n->tbl->lock);
+	spin_lock_bh(&n->tbl->lock);
 	write_lock(&n->lock);
 	if (n->dead)
 		goto out;
@@ -172,14 +172,14 @@ static void neigh_update_gc_list(struct neighbour *n)
 	}
 out:
 	write_unlock(&n->lock);
-	write_unlock_bh(&n->tbl->lock);
+	spin_unlock_bh(&n->tbl->lock);
 }
 
 static void neigh_update_managed_list(struct neighbour *n)
 {
 	bool on_managed_list, add_to_managed;
 
-	write_lock_bh(&n->tbl->lock);
+	spin_lock_bh(&n->tbl->lock);
 	write_lock(&n->lock);
 	if (n->dead)
 		goto out;
@@ -193,7 +193,7 @@ static void neigh_update_managed_list(struct neighbour *n)
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 out:
 	write_unlock(&n->lock);
-	write_unlock_bh(&n->tbl->lock);
+	spin_unlock_bh(&n->tbl->lock);
 }
 
 static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
@@ -263,7 +263,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 
 	list_for_each_entry_safe(n, tmp, &tbl->gc_list, gc_list) {
 		if (refcount_read(&n->refcnt) == 1) {
@@ -292,7 +292,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 
 	WRITE_ONCE(tbl->last_flush, jiffies);
 unlock:
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 
 	return shrunk;
 }
@@ -454,23 +454,23 @@ static void neigh_flush_table(struct neigh_table *tbl)
 
 void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev)
 {
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, false);
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 }
 EXPORT_SYMBOL(neigh_changeaddr);
 
 static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm)
 {
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 	if (likely(dev)) {
 		neigh_flush_dev(tbl, dev, skip_perm);
 	} else {
 		DEBUG_NET_WARN_ON_ONCE(skip_perm);
 		neigh_flush_table(tbl);
 	}
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 
 	pneigh_ifdown(tbl, dev, skip_perm);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
@@ -687,7 +687,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 
 	n->confirmed = jiffies - (NEIGH_VAR(n->parms, BASE_REACHABLE_TIME) << 1);
 
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 
@@ -722,13 +722,13 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	hlist_add_head_rcu(&n->dev_list,
 			   neigh_get_dev_table(dev, tbl->family));
 
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
 out:
 	return rc;
 out_tbl_unlock:
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 out_neigh_release:
 	if (!exempt_from_gc)
 		atomic_dec(&tbl->gc_entries);
@@ -982,7 +982,7 @@ static void neigh_periodic_work(struct work_struct *work)
 
 	NEIGH_CACHE_STAT_INC(tbl, periodic_gc_runs);
 
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 
@@ -1036,9 +1036,9 @@ static void neigh_periodic_work(struct work_struct *work)
 		 * It's fine to release lock here, even if hash table
 		 * grows while we are preempted.
 		 */
-		write_unlock_bh(&tbl->lock);
+		spin_unlock_bh(&tbl->lock);
 		cond_resched();
-		write_lock_bh(&tbl->lock);
+		spin_lock_bh(&tbl->lock);
 		nht = rcu_dereference_protected(tbl->nht,
 						lockdep_is_held(&tbl->lock));
 	}
@@ -1049,7 +1049,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	 */
 	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
 			      NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1);
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 }
 
 static __inline__ int neigh_max_probes(struct neighbour *n)
@@ -1641,12 +1641,12 @@ static void neigh_managed_work(struct work_struct *work)
 					       managed_work.work);
 	struct neighbour *neigh;
 
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 	list_for_each_entry(neigh, &tbl->managed_list, managed_list)
 		neigh_event_send_probe(neigh, NULL, false);
 	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
 			   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 }
 
 static void neigh_proxy_process(struct timer_list *t)
@@ -1761,9 +1761,9 @@ struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
 			return NULL;
 		}
 
-		write_lock_bh(&tbl->lock);
+		spin_lock_bh(&tbl->lock);
 		list_add_rcu(&p->list, &tbl->parms.list);
-		write_unlock_bh(&tbl->lock);
+		spin_unlock_bh(&tbl->lock);
 
 		neigh_parms_data_state_cleanall(p);
 	}
@@ -1783,10 +1783,12 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 {
 	if (!parms || parms == &tbl->parms)
 		return;
-	write_lock_bh(&tbl->lock);
+
+	spin_lock_bh(&tbl->lock);
 	list_del_rcu(&parms->list);
 	parms->dead = 1;
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
+
 	netdev_put(parms->dev, &parms->dev_tracker);
 	call_rcu(&parms->rcu_head, neigh_rcu_free_parms);
 }
@@ -1835,7 +1837,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 	else
 		WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
 
-	rwlock_init(&tbl->lock);
+	spin_lock_init(&tbl->lock);
 	mutex_init(&tbl->phash_lock);
 
 	INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
@@ -1978,10 +1980,10 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = __neigh_update(neigh, NULL, NUD_FAILED,
 			     NEIGH_UPDATE_F_OVERRIDE | NEIGH_UPDATE_F_ADMIN,
 			     NETLINK_CB(skb).portid, extack);
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 	neigh_release(neigh);
 	neigh_remove_one(neigh);
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 
 out:
 	return err;
@@ -2406,7 +2408,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 	 * We acquire tbl->lock to be nice to the periodic timers and
 	 * make sure they always see a consistent set of values.
 	 */
-	write_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 
 	if (tb[NDTA_PARMS]) {
 		struct nlattr *tbp[NDTPA_MAX+1];
@@ -2525,7 +2527,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = 0;
 
 errout_tbl_lock:
-	write_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 	rcu_read_unlock();
 errout:
 	return err;
@@ -3125,14 +3127,14 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	rcu_read_lock();
 	nht = rcu_dereference(tbl->nht);
 
-	read_lock_bh(&tbl->lock); /* avoid resizes */
+	spin_lock_bh(&tbl->lock); /* avoid resizes */
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
 		neigh_for_each_in_bucket(n, &nht->hash_heads[chain])
 			cb(n, cookie);
 	}
-	read_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(neigh_for_each);
@@ -3402,7 +3404,7 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 
 	rcu_read_lock();
 	state->nht = rcu_dereference(tbl->nht);
-	read_lock_bh(&tbl->lock);
+	spin_lock_bh(&tbl->lock);
 
 	return *pos ? neigh_get_idx_any(seq, pos) : SEQ_START_TOKEN;
 }
@@ -3442,7 +3444,7 @@ void neigh_seq_stop(struct seq_file *seq, void *v)
 	struct neigh_seq_state *state = seq->private;
 	struct neigh_table *tbl = state->tbl;
 
-	read_unlock_bh(&tbl->lock);
+	spin_unlock_bh(&tbl->lock);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(neigh_seq_stop);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 833f2cf97178e..f3bfecf8a2341 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1217,10 +1217,10 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 			err = neigh_update(neigh, NULL, NUD_FAILED,
 					   NEIGH_UPDATE_F_OVERRIDE|
 					   NEIGH_UPDATE_F_ADMIN, 0);
-		write_lock_bh(&tbl->lock);
+		spin_lock_bh(&tbl->lock);
 		neigh_release(neigh);
 		neigh_remove_one(neigh);
-		write_unlock_bh(&tbl->lock);
+		spin_unlock_bh(&tbl->lock);
 	}
 
 	return err;
-- 
2.51.0.915.g61a8936c21-goog


