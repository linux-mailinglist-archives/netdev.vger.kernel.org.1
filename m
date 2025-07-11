Return-Path: <netdev+bounces-206242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC490B0244A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DB51C428EB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5D2F3C06;
	Fri, 11 Jul 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ML66RWZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18762F364E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261022; cv=none; b=PocCVVtV/1GPfvSroCOjunpJ0PUVqw+Wu4MEi1Bi7erb36CmrNvFmn0T+HCSxRYI7bFgrdB6I3l/WVAhtUNpdTnNDkZbdzO9R8Uoi0w8/vUioHap2TDZSsIVeSv+eCUGexDFV0OK1B12bkqO9skf91xbIYBrMN67l+ZJWIiUt1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261022; c=relaxed/simple;
	bh=0RePPyxd6CgVBU5QhO5s7TM2jekRUzvVj8Dkn1Zk95o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FYr4+0m8wYnlaVqNF396P4xH+bm9KZKKbDy/CWDIYjRvMG1ReLoYAeNIQ+ynVg28MpM46QMhbWLZffuX3I9+PeI9aUTIvjkVFsaXvoqn5AOjS0uRTJDvp9CUE7msmgKfhCgzWtyDce9gW6uZ8kuo9un02tOvg85v+4QRolNM1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ML66RWZ/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so2369311a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261020; x=1752865820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETGspppFhzKgFwop2RykbhE6KEOVYDeXOFB1SESG5iM=;
        b=ML66RWZ/HbrEVx8eMZfznPcclz51ut+VhtIZyK/GE3EaEVhBd/6BO4TbJHj87OqMwL
         O9UDcnBUUpH2VhcCNS15Fk8DyVm2YFoLrinVgy0dzJKG/aJUkZC8FKb3VfdcT1MaQ+TQ
         +1RMdAbBgBpnYm7qUwWk2p2KU8AqI3mlKm5cHbXE8Olx5+IFSPHeYcWrm9cmfTTwl59A
         xm+a872tSPSDcBk8ZK51rFo5oJFS7BdVHo5FH8vrq993mJ3epUEC9VVk0PPMsRDKQF27
         OrWwWRhw2dtSwi9SwsaoUlk+iZ4Y9mRgrpub9++0MoiTorOOcvVWar4rjw2yhvXVXh+D
         4sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261020; x=1752865820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETGspppFhzKgFwop2RykbhE6KEOVYDeXOFB1SESG5iM=;
        b=c1u/KIh92EoxnUEPUju4YIYRgDgaHGsbbvSsA7oMOK8tEiE3kaazF4/S9Hm8dko4N0
         xJHDQoawUUtigainKKtjY5a/q4q+TKUWKsCZUv7bG6EkIuWxpuFyeguwtswIt8BiZtoL
         AGlTW1PAo7FTcCFiCfL4otyxL1eX/JLAKJg2UaBdwmORELYIQh8XvizEfxO2YgDmtVGn
         MB8gnbVBf064/KujZ40Ud7FIeJ2Y0/MJhgNKVHB1nvpKpBHZ84NjRoMbDP9hBxt6wZDX
         sSj8Mlw/77W/tlimXgsjqjb1STtdKFYWrllp/wQMNf3rl6VDrL8FRUJNanKdBJLMp4D8
         LPvg==
X-Forwarded-Encrypted: i=1; AJvYcCWvt9Pis4quiMkUIdx3YeR8RciBN7KzLFleaw8jpJiM8bsDgHtiIjTXSG3THVlJJ6KDllzzXAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnk51/836DavGHZRX9EWuICsvUZJ5xi9qeX8lKMd45j5nHwGY
	gNUmj1Mvu4Ps8UkvWONWl2ukLiQ3rXt2qPJ6pNCqFm/GLBjSylRxWvWnM+R+swzTM9AF0NJ7FGL
	9iYTUjw==
X-Google-Smtp-Source: AGHT+IEhXr/p/UojodpKVae0aU+smLid8RwNo1YZ9YTxZ6aF3Ci2RSzVkfeHZNdT+NxhA5n2Qe4jaYA7PKI=
X-Received: from pjbsq7.prod.google.com ([2002:a17:90b:5307:b0:311:ea2a:3919])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17d1:b0:311:b5ac:6f6b
 with SMTP id 98e67ed59e1d1-31c4ccbbec2mr6763254a91.9.1752261020486; Fri, 11
 Jul 2025 12:10:20 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:11 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/14] neighbour: Free pneigh_entry after RCU
 grace period.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will convert RTM_GETNEIGH to RCU.

neigh_get() looks up pneigh_entry by pneigh_lookup() and passes
it to pneigh_fill_info().

Then, we must ensure that the entry is alive till pneigh_fill_info()
completes, but read_lock_bh(&tbl->lock) in pneigh_lookup() does not
guarantee that.

Also, we will convert all readers of tbl->phash_buckets[] to RCU.

Let's use call_rcu() to free pneigh_entry and update phash_buckets[]
and ->next by rcu_assign_pointer().

pneigh_ifdown_and_unlock() uses list_head to avoid overwriting
->next and moving RCU iterators to another list.

pndisc_destructor() (only IPv6 ndisc uses this) uses a mutex, so it
is not delayed to call_rcu(), where we cannot sleep.  This is fine
because the mcast code works with RCU and ipv6_dev_mc_dec() frees
mcast objects after RCU grace period.

While at it, we change the return type of pneigh_ifdown_and_unlock()
to void.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  4 ++++
 net/core/neighbour.c    | 51 +++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 7f3d57da5689a..a877e56210b22 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -180,6 +180,10 @@ struct pneigh_entry {
 	possible_net_t		net;
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
+	union {
+		struct list_head	free_node;
+		struct rcu_head		rcu;
+	};
 	u32			flags;
 	u8			protocol;
 	bool			permanent;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 814a45fb1962e..6725a40b2db3a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -54,9 +54,9 @@ static void neigh_timer_handler(struct timer_list *t);
 static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
-static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev,
-				    bool skip_perm);
+static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				     struct net_device *dev,
+				     bool skip_perm);
 
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
@@ -803,12 +803,20 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 
 	write_lock_bh(&tbl->lock);
 	n->next = tbl->phash_buckets[hash_val];
-	tbl->phash_buckets[hash_val] = n;
+	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
 	write_unlock_bh(&tbl->lock);
 out:
 	return n;
 }
 
+static void pneigh_destroy(struct rcu_head *rcu)
+{
+	struct pneigh_entry *n = container_of(rcu, struct pneigh_entry, rcu);
+
+	netdev_put(n->dev, &n->dev_tracker);
+	kfree(n);
+}
+
 int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 		  struct net_device *dev)
 {
@@ -821,12 +829,13 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 	     np = &n->next) {
 		if (!memcmp(n->key, pkey, key_len) && n->dev == dev &&
 		    net_eq(pneigh_net(n), net)) {
-			*np = n->next;
+			rcu_assign_pointer(*np, n->next);
 			write_unlock_bh(&tbl->lock);
+
 			if (tbl->pdestructor)
 				tbl->pdestructor(n);
-			netdev_put(n->dev, &n->dev_tracker);
-			kfree(n);
+
+			call_rcu(&n->rcu, pneigh_destroy);
 			return 0;
 		}
 	}
@@ -834,11 +843,12 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 	return -ENOENT;
 }
 
-static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev,
-				    bool skip_perm)
+static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				     struct net_device *dev,
+				     bool skip_perm)
 {
-	struct pneigh_entry *n, **np, *freelist = NULL;
+	struct pneigh_entry *n, **np;
+	LIST_HEAD(head);
 	u32 h;
 
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
@@ -847,25 +857,26 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 			if (skip_perm && n->permanent)
 				goto skip;
 			if (!dev || n->dev == dev) {
-				*np = n->next;
-				n->next = freelist;
-				freelist = n;
+				rcu_assign_pointer(*np, n->next);
+				list_add(&n->free_node, &head);
 				continue;
 			}
 skip:
 			np = &n->next;
 		}
 	}
+
 	write_unlock_bh(&tbl->lock);
-	while ((n = freelist)) {
-		freelist = n->next;
-		n->next = NULL;
+
+	while (!list_empty(&head)) {
+		n = list_first_entry(&head, typeof(*n), free_node);
+		list_del(&n->free_node);
+
 		if (tbl->pdestructor)
 			tbl->pdestructor(n);
-		netdev_put(n->dev, &n->dev_tracker);
-		kfree(n);
+
+		call_rcu(&n->rcu, pneigh_destroy);
 	}
-	return -ENOENT;
 }
 
 static inline void neigh_parms_put(struct neigh_parms *parms)
-- 
2.50.0.727.gbf7dc18ff4-goog


