Return-Path: <netdev+bounces-206360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85103B02C4F
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB791AA2C2D
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D31BD9D0;
	Sat, 12 Jul 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpl38k/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185617A2EB
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752343700; cv=none; b=Oitk5m+2RyfyoBaBXKFegr7DnRzvLv0ldvDhmRj0pjTqVduooRtOwyjtwb3Q6mcZWSQ/gGzPQNhY6JWKwdGdR11Fen2K3pZWAQR0aZuGS4JVF3QbnufM1orW28cSgtlGsBVDiEBrG9DTXA1xQu7qkU5ZUV2tkszFvrMAcrGOQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752343700; c=relaxed/simple;
	bh=WaYIFRt7/gf0N84j8lsU3KMLw+q1xuDuFAKawmoeiOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Umm0Fk+1LhhwzW+unTTq2Ff2hn8HqJfCJlZUyOQEQjRfqcuPFFfkbS7CGRr6tQDsYAqLnHFasW69lCEy77kBcLiMMlI5Wnumz4h1xPXWfZPjAyORl2bBsVsUp94RYjTbs3lv3TTwgJybqx7j16IFFgK+o3q+CLLW6uaY1mJ7gFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpl38k/C; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so2939041a91.3
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752343698; x=1752948498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuQIiUEshJlQCk08i9VpczYDMeM9qRa4XVZGeG3gw2E=;
        b=mpl38k/Ceb5xuYp+Uu6eHrvNLwsUzDT8T4jIfah3ihuTh2UOxj5ZAxiqmcfSlvZB5o
         l1Pz7i3Ko7+NYKVC0MqOfCfLTzl1TQ3RzBjpNlTUqoOzYY5IKBrnIehwx99QWCpxWHAN
         Yjk3VaEoaKdkv5o25KHKC5PHwKdxwoad5lRitrOLDr8/CijSYXO2bUVarS/HpHVL+CgA
         asL+U/5nYU8qC1MsYUyjZ20bXWgWP5aDL061yxxv0e756JXunXdrZ40BHf8IoGCAG//b
         bkvHqbBzTwFRdf6bfAVrA39fORy/R8p3fdlwlZqYdOp/TZoOO5354PkLoIl0xaPyOGdW
         Hnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752343698; x=1752948498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuQIiUEshJlQCk08i9VpczYDMeM9qRa4XVZGeG3gw2E=;
        b=Lz9KpBe+xSBSMXnFDjOLvnJ6ONzGUuKOyNtMb5/uuO75mKAESnhsCcvP3uvV18kSgN
         t0CosZBimiq+CXNZfZxPWNw0Br8w82LujTIByIr0P7V5MSAxU2jhD8qli/rfq5Bfy9d7
         kMwixEty/IkoomLV6txbFp79g0sQowWo2ADdwNjYQ4vSOD4g+7ZteUPOj04tnKD0LXgv
         MpVulRp1tUlP5KSGU9IYEbG0HS5MQ5/jR8eypiem0/qJFSHOcDgz4xmOA3IH51m7qyIi
         XVeOsB7lDTE+D3a5T8UqDhK4ipVUGkltPjnacUsJ4vIGTZQFpID9+5HStIRmM/YdYY44
         tpSw==
X-Forwarded-Encrypted: i=1; AJvYcCV5KKpr/HxeragaIOcNuA3wPEmL1yVKcqjYnoPiO4M4Ajf2A0L0u/9FUHjnvAAiMH7jr/Gen+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaiNI6ZCyohTskuJ46YGHFDXRe7mCqhGoqk7IezUoEmU2d5/Ey
	7VRlsMkGYObwD75JHXqIDJutksXu5D4v7GxgTAboiWO7q2hhE4IGvm46g/kiU6uvxdtbiCo/A//
	/TadoRQ==
X-Google-Smtp-Source: AGHT+IE2DeJ8znvKkKjfBdUSxRF1aMCPot2zE8uRS+byhyn4M6yGXvOJdT/BNfgDTcahQANgBBhzEKvN3wQ=
X-Received: from pjq16.prod.google.com ([2002:a17:90b:5610:b0:314:29b4:453])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc5:b0:30e:9349:2da2
 with SMTP id 98e67ed59e1d1-31c50d5df81mr9677744a91.4.1752343698216; Sat, 12
 Jul 2025 11:08:18 -0700 (PDT)
Date: Sat, 12 Jul 2025 18:07:51 +0000
In-Reply-To: <20250712150159.GD721198@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712150159.GD721198@horms.kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712180816.3987876-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 06/14] neighbour: Free pneigh_entry after RCU
 grace period.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: horms@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Simon Horman <horms@kernel.org>
Date: Sat, 12 Jul 2025 16:01:59 +0100
> On Fri, Jul 11, 2025 at 07:06:11PM +0000, Kuniyuki Iwashima wrote:
> > We will convert RTM_GETNEIGH to RCU.
> > 
> > neigh_get() looks up pneigh_entry by pneigh_lookup() and passes
> > it to pneigh_fill_info().
> > 
> > Then, we must ensure that the entry is alive till pneigh_fill_info()
> > completes, but read_lock_bh(&tbl->lock) in pneigh_lookup() does not
> > guarantee that.
> > 
> > Also, we will convert all readers of tbl->phash_buckets[] to RCU.
> > 
> > Let's use call_rcu() to free pneigh_entry and update phash_buckets[]
> > and ->next by rcu_assign_pointer().
> > 
> > pneigh_ifdown_and_unlock() uses list_head to avoid overwriting
> > ->next and moving RCU iterators to another list.
> > 
> > pndisc_destructor() (only IPv6 ndisc uses this) uses a mutex, so it
> > is not delayed to call_rcu(), where we cannot sleep.  This is fine
> > because the mcast code works with RCU and ipv6_dev_mc_dec() frees
> > mcast objects after RCU grace period.
> > 
> > While at it, we change the return type of pneigh_ifdown_and_unlock()
> > to void.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/neighbour.h |  4 ++++
> >  net/core/neighbour.c    | 51 +++++++++++++++++++++++++----------------
> >  2 files changed, 35 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> > index 7f3d57da5689a..a877e56210b22 100644
> > --- a/include/net/neighbour.h
> > +++ b/include/net/neighbour.h
> > @@ -180,6 +180,10 @@ struct pneigh_entry {
> >  	possible_net_t		net;
> >  	struct net_device	*dev;
> >  	netdevice_tracker	dev_tracker;
> > +	union {
> > +		struct list_head	free_node;
> > +		struct rcu_head		rcu;
> > +	};
> >  	u32			flags;
> >  	u8			protocol;
> >  	bool			permanent;
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 814a45fb1962e..6725a40b2db3a 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -54,9 +54,9 @@ static void neigh_timer_handler(struct timer_list *t);
> >  static void __neigh_notify(struct neighbour *n, int type, int flags,
> >  			   u32 pid);
> >  static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
> > -static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
> > -				    struct net_device *dev,
> > -				    bool skip_perm);
> > +static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
> > +				     struct net_device *dev,
> > +				     bool skip_perm);
> >  
> >  #ifdef CONFIG_PROC_FS
> >  static const struct seq_operations neigh_stat_seq_ops;
> > @@ -803,12 +803,20 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
> >  
> >  	write_lock_bh(&tbl->lock);
> >  	n->next = tbl->phash_buckets[hash_val];
> > -	tbl->phash_buckets[hash_val] = n;
> > +	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
> 
> Hi Iwashima-san,
> 
> A heads-up that unfortunately Sparse is unhappy about the __rcu annotations
> here, and elsewhere in this patch (set).
> 
> For this patch I see:
> 
>   .../neighbour.c:860:33: error: incompatible types in comparison expression (different address spaces):
>   .../neighbour.c:860:33:    struct pneigh_entry [noderef] __rcu *
>   .../neighbour.c:860:33:    struct pneigh_entry *
>   .../neighbour.c:806:9: error: incompatible types in comparison expression (different address spaces):
>   .../neighbour.c:806:9:    struct pneigh_entry [noderef] __rcu *
>   .../neighbour.c:806:9:    struct pneigh_entry *
>   .../neighbour.c:832:25: error: incompatible types in comparison expression (different address spaces):
>   .../neighbour.c:832:25:    struct pneigh_entry [noderef] __rcu *
>   .../neighbour.c:832:25:    struct pneigh_entry *

Thanks for heads-up, Simon!

This diff below was needed on top of the series, but as I gradually added
rcu_derefernece_check(), probably I need to churn this patch 6 more.

Anyway, I'll fix every annotation warning in v2.

---8<---
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 9bc5be41a6d09..f1fd15fbbb800 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -178,7 +178,7 @@ struct neigh_ops {
 };
 
 struct pneigh_entry {
-       struct pneigh_entry     *next;
+       struct pneigh_entry     __rcu *next;
        possible_net_t          net;
        struct net_device       *dev;
        netdevice_tracker       dev_tracker;
@@ -243,7 +243,7 @@ struct neigh_table {
        struct neigh_statistics __percpu *stats;
        struct neigh_hash_table __rcu *nht;
        struct mutex            phash_lock;
-       struct pneigh_entry     **phash_buckets;
+       struct pneigh_entry     __rcu **phash_buckets;
        struct srcu_struct      srcu;
 };
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9bbf6d514abe6..1e8832a3e0176 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -804,17 +804,18 @@ static void pneigh_destroy(struct rcu_head *rcu)
 int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
                  struct net_device *dev)
 {
-       struct pneigh_entry *n, **np;
+       struct pneigh_entry *n, __rcu **np;
        unsigned int key_len = tbl->key_len;
        u32 hash_val = pneigh_hash(pkey, key_len);
 
        mutex_lock(&tbl->phash_lock);
 
-       for (np = &tbl->phash_buckets[hash_val]; (n = *np) != NULL;
+       for (np = &tbl->phash_buckets[hash_val];
+            (n = rcu_dereference_protected(*np, 1)) != NULL;
             np = &n->next) {
                if (!memcmp(n->key, pkey, key_len) && n->dev == dev &&
                    net_eq(pneigh_net(n), net)) {
-                       rcu_assign_pointer(*np, n->next);
+                       rcu_assign_pointer(*np, rcu_dereference_protected(n->next, 1));
 
                        mutex_unlock(&tbl->phash_lock);
 
@@ -833,7 +834,7 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
                          bool skip_perm)
 {
-       struct pneigh_entry *n, **np;
+       struct pneigh_entry *n, __rcu **np;
        LIST_HEAD(head);
        u32 h;
 
@@ -841,7 +842,7 @@ static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 
        for (h = 0; h <= PNEIGH_HASHMASK; h++) {
                np = &tbl->phash_buckets[h];
-               while ((n = *np) != NULL) {
+               while ((n = rcu_dereference_protected(*np, 1)) != NULL) {
                        if (skip_perm && n->permanent)
                                goto skip;
                        if (!dev || n->dev == dev) {
---8<---

