Return-Path: <netdev+bounces-207624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FACB0804D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3401C286A0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7DE2EE605;
	Wed, 16 Jul 2025 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GWEOyqM8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925B2EF28D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703956; cv=none; b=bmwdV15RQnLk1/9NQZODqoKPqbuLEI+eu26DrQCVxw4GGeAxOCAouvsBC5oevnwPh+3sTvLBpDPEEBZ4kMAYbbZTqhW9zwSI/FiG8mmWsEho9FBpaJHqpqGuBhvWYQQNeBi0SFS03rjLJxJKd7HlDs87xXGuhVRSnJqYYesEPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703956; c=relaxed/simple;
	bh=xpZbdONWVOSxZz/zymyKiVGgFr8a1hjoXvfgryUSBuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFNloOeGaa4nj2JPCgViHhuXxv+IycqrPYszRXqwHeasBc9ShKMr+dYywyWYXFlgS0ZwVKRIMlHsDzY4iD7HQn2RCibzLgF1Y3SdDRlOkIGy9R2L14xisj8iiJczH85lU52dvAI3cN99BsiB/02CzAY9XgHXwvj3yDYNH+RKhEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GWEOyqM8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748e1e474f8so415307b3a.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703954; x=1753308754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzWKGab6HbuXR32ActInuQgjIU4BgI50Ek+yIIhzoqk=;
        b=GWEOyqM8lDIcSG/r68J6davx0sf2JXWFAuwGWGug64XR5p/lVv5IQZiUfy4vsQNw0E
         83qBAyDd5tBxN6bryc4+KHdPrG4bYTdgL2txdogmZEF2kK6TDKOQNikluGPN45mwd7er
         RgTCGsp8aJmy9sDkeyjHmyly+Mb6a6YW3uUiYZODf5/OIc4KX7XT//0mJgNpqezkr0jM
         c1bW3oBbrO5HPhDN4JyfFacGFhIoUEmtPrr/iut45FKHY+W//ivoOpYsXAdHYZSa8fUu
         zSNvWsHnEqH9b9Rqt6rjaVK2ovt8aYhzG6zUCrthYFlaBkoB4VPhI2tS2rfkfgA8rj4s
         ogWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703954; x=1753308754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzWKGab6HbuXR32ActInuQgjIU4BgI50Ek+yIIhzoqk=;
        b=t7M5q5iCohOIGNIsN9Y/8xDRIzcJ3fXN9/feJyEOAoJHeMKaPuAIEBUTjiogc4Wztq
         XTWbffgVglUs5oijW2ybUdDFl5pvECSWgJ/wc3H4ssoYFbAUWjWrUWxnL3ra/NIckz0l
         HQt80hCFVRztoZA1qVVjZY/Ov7lEjFnI54wkgH01CZR14r2ljCtZgbGrnhc7NSNmLoEy
         N0e3k9pp0y7zlsDfNMRA6FlDJYkSgrcXSo1zr72riF/24LxLuPrKc9ODr8VywdGERQXD
         Nvwhbzh5cswO4oqhP9baVjx/Rxqc+11Lu7CmD5olyM2awEoc3Fqgf7aLhseXeuEBFZIZ
         ZK6w==
X-Forwarded-Encrypted: i=1; AJvYcCXXpJ9Tskiq9ik1qEsRVYmfRJqQuMuP4Q4c6fOSw6FkwaXZHUIvcf41kN3OVE+WHTGLKdfKaMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9IUsIJUuXsA3CmEtcmofm1YqxZyVs+QOYFx2tbWb6A8hcDzI
	Z/uQ3rCRgY2m/JKmdsVCktl7bmiUvj+RqJHYIR+bhITjARcMovYa9YpIgSvmtqqSkEgXygX7PY0
	vxUa0aQ==
X-Google-Smtp-Source: AGHT+IE2FLMoU65XwlulN1vKIzPE7mF91CNEeo9xSqY9q/BQVXZElXuweSaif6TZ+eG0QTlFEAyIrH2i1/s=
X-Received: from pfbhd3.prod.google.com ([2002:a05:6a00:6583:b0:748:dfd8:3949])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431f:b0:230:f020:ddf2
 with SMTP id adf61e73a8af0-23812947eedmr6205057637.19.1752703953873; Wed, 16
 Jul 2025 15:12:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:12 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 07/15] neighbour: Free pneigh_entry after RCU
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
index 8bbf3ec592906..f5690e5904cba 100644
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


