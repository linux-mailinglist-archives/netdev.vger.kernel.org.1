Return-Path: <netdev+bounces-206369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE01CB02CE3
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA954A475C
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9D22A7EF;
	Sat, 12 Jul 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EN1mxJrp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF44229B0D
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352531; cv=none; b=ujQlKA+m8PaPhEPp+tsqF8Pm2maQ/eKJOXTh4AchC0kFkRzoo8wxsBzAwKCbk1C/nbLAqrnV8l2lfh+pf03jELUQfGFWAT50/olRsbdKKwd0MHYUqOERseA5Xm3LaKcqnD8CrInGAUaHKVN/Ys0o32y8Va/3A9N9DpowOVU6548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352531; c=relaxed/simple;
	bh=7d1xAuIt/BOiNdDSD5mtQ+pKSG6sjBROVxhuJcfRPEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QY3jRn2zFwgnGMR1yXt8Nb4rWR5JJTnKGUHJI/xNBrw4CfNjxfvgg16xArHiyk9bteSyVvdKUTucCo3uJIaNOec3Y3M1taNJiWA7fZ1wkBe2dEK+pxJyhoQc9/e7KkT7WzL6s2cKvAZdH08IMnaYa/WMQSQt+LKM7ld8h4ERzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EN1mxJrp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so2926910b3a.3
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352529; x=1752957329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVdgVGFpYukocCvg8fu29UH0NCdx3hbXLIMVpJhgPb8=;
        b=EN1mxJrpLVUfn2HMBcaeiD8xrHVwjsj9u8zxdDADxmasPXsc5RGN+oT+EHwl6td1QY
         k14XGx4f++C973WCMpD0bPhYB3z9B0Es2G+/O8SdiCTEYXCDHncSzQuznmuDrNEn7gxf
         BgDeS+9DWxmVsev9vG3Hf59E12dEImhkabACqvoXIwmdNLJItmGJlvKbabO1ifhK+2Nt
         1Neq/Ea0waylKDQfhOTXl5WCIX1a4xyGYG66n1dELzOnFKBWqkPg3Vuv0wK6i7C84U52
         gFYWx3eo+FPBGSnCFd6Wo3X+RHHC02k6e9ii3bPe5E4/GHTwsQda6BABbOPQazya++6O
         /hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352529; x=1752957329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVdgVGFpYukocCvg8fu29UH0NCdx3hbXLIMVpJhgPb8=;
        b=YWNszvTHRhNFJ4XZ8RTfVoYdLdz5Qn/XW91S+bcjbePmTwpHzHcSxtgDNWTK4C/pXr
         vJULvF+40fyiIvmcE+O1duMuXYdC0ef996IrPNQDyyqlO2loi9nfxgKUJB2mLSv8yCYz
         RDHgfleUCyYAjWvxms5/xjO0dt0E7dcen1lHMISZeHZmFwN/NLlrI0Sy4SvwNfKq/3Tb
         PDITF9I95I3yFdTviVvXN7BV/58daX4F6ueELvLEBAvElVeDWMrSMlRKpp5Mp5/uvOm7
         z01vseS8zJPVI3HfDTrjy5P04JSfrb4qkjH16Fp/V811Po42tL2DPo49q54L/T6fhAXZ
         AW7w==
X-Forwarded-Encrypted: i=1; AJvYcCUCp6CCqAF6YFHfi+w5f08zC0E31wq4W6moFZiAlIB+oDBa0nBjxsQt25gM3gMbsKabtwCB2kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHay/nIMhh4x8gea+Dx0Sncq1b+hCsCxt6Y0YSXBGw9XpyT+j
	5OUwOIu/FsWESBjXCUvdEuzCUPW7Hit+NTWlgYMQBYUrOiJ7lyxHrRWAeiq01Rd6Ewzcuc1tDRO
	6T7fHnw==
X-Google-Smtp-Source: AGHT+IHMgyCh0MkFzvzccx7qd9b4kywCR+TfoBYdoKAErenkWl1OJ2wu98BVvwysDUQ5ZAi7v4vdWilug3c=
X-Received: from pfbmy27.prod.google.com ([2002:a05:6a00:6d5b:b0:746:301b:10ca])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b44:b0:730:9946:5973
 with SMTP id d2e1a72fcca58-74ee0aa69bamr9238835b3a.5.1752352529069; Sat, 12
 Jul 2025 13:35:29 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:16 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/15] neighbour: Free pneigh_entry after RCU
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
 net/core/neighbour.c    | 45 +++++++++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 1ddc44a042000..6d7f9aa53a7a9 100644
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
index 4dd97dad7d7a4..6f688b643c82b 100644
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
@@ -810,6 +810,14 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
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
@@ -828,10 +836,11 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 		    net_eq(pneigh_net(n), net)) {
 			rcu_assign_pointer(*np, n->next);
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
@@ -839,11 +848,12 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 	return -ENOENT;
 }
 
-static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev,
-				    bool skip_perm)
+static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				     struct net_device *dev,
+				     bool skip_perm)
 {
-	struct pneigh_entry *n, __rcu **np, *freelist = NULL;
+	struct pneigh_entry *n, __rcu **np;
+	LIST_HEAD(head);
 	u32 h;
 
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
@@ -853,24 +863,25 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 				goto skip;
 			if (!dev || n->dev == dev) {
 				rcu_assign_pointer(*np, n->next);
-				rcu_assign_pointer(n->next, freelist);
-				freelist = n;
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
-		freelist = rcu_dereference_protected(n->next, 1);
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


