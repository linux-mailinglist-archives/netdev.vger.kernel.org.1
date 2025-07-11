Return-Path: <netdev+bounces-206249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C20B02450
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EC6169E68
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500F2F4323;
	Fri, 11 Jul 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnSYS4TB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A92F2735
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261032; cv=none; b=BBXmCMWYWtsGde6O0bj2LqBLiacKgFwkAP8C1TMmbRwnjpCMAGMYbLjLug+C3sTv6WoqkrqxQrb7EjL3WpClqNA1Oi0hHEaTKotF1Nypye3apAs40P6DDEpAwRxxLGfKzhezpjkQxELrifw32TrnwFr4YNQZCxDV/fohhlG6voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261032; c=relaxed/simple;
	bh=FbJJ5yXKYlQlPw5ZJLxKvAhDEpert0aWQAgiRyl3QcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TPEiIxkx02Kg+a8l8XAhhPWH5giLB0NV8hbi62TWWdvNzr5pU3Ywibz8E4gw5dmg3pHZepD2aWHkCJdEqO0tUjhuwRdAHDje7JrEgDcK3Rft3aPzV69+CWIdGLC/8IJfurYMvsYhKYhNWOW45rZHzKxTk/xzi8RYx/vE04YGj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnSYS4TB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-312df02acf5so2887830a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261031; x=1752865831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvekHJH00BOj5TmhusCiqcQz/w3uNS9i0QXszFf2i4U=;
        b=fnSYS4TBag8O+SLo2lUU+3grNJWDWqN2+4d5A6UigxCZz2y9cXScu7L50nDmqLoBR0
         huZ3ZbIDbcg/dUF+3qf2lz3lfXVcu1L3TDoz5vvZd2jbGT6jYDKNHAL4u3jCk7o9V7/2
         G5eSc8AaoiJ3MhCLpVb3SfVMZZ1imq6QwFebKMS4w93Bv6PIkoXY1TZWObAjrmCY8Dmp
         MfPVSP0Nx4plOSYlCi/+ITT8q2M/510QSWV2I2zuc5fLgU/AXr4x5XwKNuBXyfWca9eE
         FnHPx5qKjTTfW1JzvidN80mHttHHrb5tD6lO8PFKAeUSaKN4e+zTPV+HF5puUuBtgheH
         3jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261031; x=1752865831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvekHJH00BOj5TmhusCiqcQz/w3uNS9i0QXszFf2i4U=;
        b=Ugm5sUSTKbyjXBUuFKIhNRq8AXeRcbhIUcw9OoYcMVAmpZGFkwitAWOLnmCIFb27E/
         hNECN9kKQrZS5pOOaA0t03tVDLDXr3FbQlSFA5P+Y++rtWs7XKye0oQsNvbp+2lv/Gn/
         ZeR4aNDPjX+VHc+hFaC8N3C4bsr0sMV3Kaz4VlOKQSnxc8ZQ6mvRuTDRVmADPnCdx4V2
         b08Qgb8fPn/u6iGVqQYFyKXnzlTEqWMOsu72+uSPAP6W2mPj8y01b+MKqRhXulPpWRuF
         kE6JCuR1tau0m9v57d5Tvx0P2MvhxmuPRV7NzkQoaa+mqNXJ3W8LyGVozDRY/ruNYYgA
         lt2g==
X-Forwarded-Encrypted: i=1; AJvYcCWmmPjObGk/jf0mEHF+F/xXRp955JojBkISolfrqqaEAWMeVo1sIUH9jvxnI0W2pycpdn8x60w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQtu51P/nOi2PSVvy9TgqmP5EWtY4bZ5PkdDzsdZ7zE8tJ+gJ
	GPNqCyRHvzJ1jbxDV6UZRTc380lSJuZU3EOFidlDe7LaSHEt+NrLziIUaXmqGf8eZxKiNzfiyeE
	YdpUCuQ==
X-Google-Smtp-Source: AGHT+IEezdTdhFlar7vfZOzh07e2kbiXrbko5pxnNsEKaD1F8vqU2mDhAmIRIAQQumjN2dRnS7nspmZBp24=
X-Received: from pjg13.prod.google.com ([2002:a17:90b:3f4d:b0:311:ff32:a85d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b8c:b0:310:c8ec:4192
 with SMTP id 98e67ed59e1d1-31c3cfb4b93mr11796449a91.10.1752261030701; Fri, 11
 Jul 2025 12:10:30 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:18 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-14-kuniyu@google.com>
Subject: [PATCH v1 net-next 13/14] neighbour: Protect tbl->phash_buckets[]
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

Even though RTNL is removed, the neigh table is per-protocol one, so this
locking granularity is fine until we make the table per-netns.

Note that updating pneigh_entry part in neigh_add() is still protected
by RTNL and will be moved to pneigh_create() in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  1 +
 net/core/neighbour.c    | 39 +++++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 1670e2a388556..af6fe50703041 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -240,6 +240,7 @@ struct neigh_table {
 	unsigned long		last_rand;
 	struct neigh_statistics	__percpu *stats;
 	struct neigh_hash_table __rcu *nht;
+	struct mutex		phash_lock;
 	struct pneigh_entry	**phash_buckets;
 };
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9d716852e0e7d..78f2457a101c4 100644
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
 
@@ -803,13 +801,15 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 	unsigned int key_len = tbl->key_len;
 	u32 hash_val = pneigh_hash(pkey, key_len);
 
-	write_lock_bh(&tbl->lock);
+	mutex_lock(&tbl->phash_lock);
+
 	for (np = &tbl->phash_buckets[hash_val]; (n = *np) != NULL;
 	     np = &n->next) {
 		if (!memcmp(n->key, pkey, key_len) && n->dev == dev &&
 		    net_eq(pneigh_net(n), net)) {
 			rcu_assign_pointer(*np, n->next);
-			write_unlock_bh(&tbl->lock);
+
+			mutex_unlock(&tbl->phash_lock);
 
 			if (tbl->pdestructor)
 				tbl->pdestructor(n);
@@ -818,18 +818,20 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
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
 	struct pneigh_entry *n, **np;
 	LIST_HEAD(head);
 	u32 h;
 
+	mutex_lock(&tbl->phash_lock);
+
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
 		np = &tbl->phash_buckets[h];
 		while ((n = *np) != NULL) {
@@ -845,7 +847,7 @@ static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 		}
 	}
 
-	write_unlock_bh(&tbl->lock);
+	mutex_unlock(&tbl->phash_lock);
 
 	while (!list_empty(&head)) {
 		n = list_first_entry(&head, typeof(*n), free_node);
@@ -1792,6 +1794,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
 
 	rwlock_init(&tbl->lock);
+	mutex_init(&tbl->phash_lock);
 
 	INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
 	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
-- 
2.50.0.727.gbf7dc18ff4-goog


