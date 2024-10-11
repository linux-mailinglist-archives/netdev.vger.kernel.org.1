Return-Path: <netdev+bounces-134439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D09998EE
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D642E1F232E4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5264A2D;
	Fri, 11 Oct 2024 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iBagaTPf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E21D268
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609391; cv=none; b=EduVQAEWtyi9GpJCcYnomo3r1105lDAGzMVhhnOufNUY26HvfwBMVWnv5GnQHpWTw8de/LX6Js8FdtnESaqLQI+p0KgGu181m0z8bCNSdNF/u+bqQA6RrgjVRDZVDP21jYqklgfpwnJBT6T9hCnsIWOp4wem4kVtLSGZCRPs+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609391; c=relaxed/simple;
	bh=VHCDawVIQogB19vP4csJDM2fltLgCNd9NRFyQDppRsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ukda7R1IoSvp8pO2I//X8qvPDMQFzuYfDdZHbm3PW8U73k5XumPe2N8XuWpyMBYSTYwoFRSe5Tu3L1nl+iI/H4O4V2OM0hszQZnJO88p+v7ck/6qaoRB3FA4Fv5+E23TjhvR5mniQUVRpZYdkDt49YwbavxldwZfPQbB40bYa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iBagaTPf; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728609389; x=1760145389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0Oj/1/zI1po3LtpMGCpXWva98hJSgwlT+vtyf8PMEs=;
  b=iBagaTPfPWWps5iXV/B0+BoEN1JrTfPfNmBM0J5xI2um51vNJzCSLD9j
   Ay9VX4Bz0p3xVnhQYbczNWnOTUVM/fkdezxbhulGzogITgo4fVvKY6oof
   PFcFXXxZn9unvN6kpKrY6XrqFiTjzT/KJO3tUGQCMPMlq/AeWK0TB6S37
   I=;
X-IronPort-AV: E=Sophos;i="6.11,194,1725321600"; 
   d="scan'208";a="765619867"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:16:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:19993]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 5403c65a-44a9-4220-b2ed-00e2985e8651; Fri, 11 Oct 2024 01:16:23 +0000 (UTC)
X-Farcaster-Flow-ID: 5403c65a-44a9-4220-b2ed-00e2985e8651
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 01:16:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.88.181.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 01:16:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gilad@naaman.io>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next v3 1/2] Convert neighbour-table to use hlist
Date: Thu, 10 Oct 2024 18:16:17 -0700
Message-ID: <20241011011617.16984-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241010120139.2856603-2-gnaaman@drivenets.com>
References: <20241010120139.2856603-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Thu, 10 Oct 2024 12:01:24 +0000
> @@ -304,9 +304,7 @@ static inline struct neighbour *___neigh_lookup_noref(
>  	u32 hash_val;
>  
>  	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
> -	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
> -	     n != NULL;
> -	     n = rcu_dereference(n->next)) {
> +	hlist_for_each_entry_rcu(n, &nht->hash_buckets[hash_val], list) {

Let's move macros in .h and use it here.


>  		if (n->dev == dev && key_eq(n, pkey))
>  			return n;
>  	}
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 77b819cd995b..bf7f69b585d6 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -37,6 +37,7 @@
>  #include <linux/string.h>
>  #include <linux/log2.h>
>  #include <linux/inetdevice.h>
> +#include <linux/rculist.h>
>  #include <net/addrconf.h>
>  
>  #include <trace/events/neigh.h>
> @@ -57,6 +58,26 @@ static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
>  static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
>  				    struct net_device *dev);
>  
> +#define neigh_hlist_entry(n) hlist_entry_safe(n, struct neighbour, list)
> +
> +#define neigh_for_each_rcu(pos, head, cond...) \

No cond here, and use this only under RCU.

For places under neigh table lock, let's define neigh_for_each()
with hlist_for_each_entry().

The current neigh_for_each() is only used in spectrum_router.c
and can be moved to mlxsw_sp_neigh_rif_made_sync_each() with
the new macro used.

Let's split this patch for ease of review.

  1. Add hlist_node and link/unlink by hlist_add() / hlist_del()
  2. Define neigh_for_each() macro and move the current
     neigh_for_each() to mlxsw_sp_neigh_rif_made_sync_each()
  3. Rewrite the seq_file part with macro
  4. Convert the rest of while()/for() with macro
  5. Remove ->next


> +	hlist_for_each_entry_rcu(pos, head, list, ##cond)
> +
> +#define neigh_for_each_safe_rcu_protected(pos, n, head, c)		\
> +	for (pos = neigh_first_rcu_protected(head, c);			\
> +	     pos && ({ n = neigh_next_rcu_protected(pos, c); 1; });	\
> +	     pos = n)

This should be hlist_for_each_entry_safe().

There is a reason why rculist.h does not have this version.
_safe means you are on the write side, which does not need RCU.


> +
> +#define neigh_first_rcu(bucket) \
> +	neigh_hlist_entry(rcu_dereference(hlist_first_rcu(bucket)))
> +#define neigh_next_rcu(n) \
> +	neigh_hlist_entry(rcu_dereference(hlist_next_rcu(&(n)->list)))
> +
> +#define neigh_first_rcu_protected(head, c) \
> +	neigh_hlist_entry(rcu_dereference_protected(hlist_first_rcu(head), c))
> +#define neigh_next_rcu_protected(n, c) \
> +	neigh_hlist_entry(rcu_dereference_protected(hlist_next_rcu(&(n)->list), c))
> +
>  #ifdef CONFIG_PROC_FS
>  static const struct seq_operations neigh_stat_seq_ops;
>  #endif
> @@ -205,18 +226,13 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
>  	}
>  }
>  
> -static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
> -		      struct neigh_table *tbl)
> +static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)

Now this can be renamed to neigh_remove_one() without static.


>  {
>  	bool retval = false;
>  
>  	write_lock(&n->lock);
>  	if (refcount_read(&n->refcnt) == 1) {
> -		struct neighbour *neigh;
> -
> -		neigh = rcu_dereference_protected(n->next,
> -						  lockdep_is_held(&tbl->lock));
> -		rcu_assign_pointer(*np, neigh);
> +		hlist_del_rcu(&n->list);
>  		neigh_mark_dead(n);
>  		retval = true;
>  	}
> @@ -228,25 +244,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
>  
>  bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
>  {
> -	struct neigh_hash_table *nht;
> -	void *pkey = ndel->primary_key;
> -	u32 hash_val;
> -	struct neighbour *n;
> -	struct neighbour __rcu **np;
> -
> -	nht = rcu_dereference_protected(tbl->nht,
> -					lockdep_is_held(&tbl->lock));
> -	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
> -	hash_val = hash_val >> (32 - nht->hash_shift);
> -
> -	np = &nht->hash_buckets[hash_val];
> -	while ((n = rcu_dereference_protected(*np,
> -					      lockdep_is_held(&tbl->lock)))) {
> -		if (n == ndel)
> -			return neigh_del(n, np, tbl);
> -		np = &n->next;
> -	}
> -	return false;
> +	return neigh_del(ndel, tbl);
>  }
>  
>  static int neigh_forced_gc(struct neigh_table *tbl)
> @@ -387,22 +385,18 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
>  					lockdep_is_held(&tbl->lock));
>  
>  	for (i = 0; i < (1 << nht->hash_shift); i++) {
> -		struct neighbour *n;
> -		struct neighbour __rcu **np = &nht->hash_buckets[i];
> +		struct neighbour *n, *next;
>  
> -		while ((n = rcu_dereference_protected(*np,
> -					lockdep_is_held(&tbl->lock))) != NULL) {
> +		neigh_for_each_safe_rcu_protected(n, next,
> +						  &nht->hash_buckets[i],
> +						  lockdep_is_held(&tbl->lock)) {

tbl->nht is already fetched with lockdep_is_held(),
soneigh_for_each_safe() is enough.


>  			if (dev && n->dev != dev) {
> -				np = &n->next;
>  				continue;
>  			}

{} is no longer needed.


>  			if (skip_perm && n->nud_state & NUD_PERMANENT) {
> -				np = &n->next;
>  				continue;
>  			}

Same here.


[...]
> @@ -591,7 +585,7 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
>  	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
>  		struct neighbour *n, *next;
>  
> -		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
> +		for (n = neigh_first_rcu_protected(&old_nht->hash_buckets[i],
>  						   lockdep_is_held(&tbl->lock));

_safe version can be used,


>  		     n != NULL;
>  		     n = next) {
> @@ -599,14 +593,9 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
>  					 new_nht->hash_rnd);
>  
>  			hash >>= (32 - new_nht->hash_shift);
> -			next = rcu_dereference_protected(n->next,
> -						lockdep_is_held(&tbl->lock));
> -
> -			rcu_assign_pointer(n->next,
> -					   rcu_dereference_protected(
> -						new_nht->hash_buckets[hash],
> -						lockdep_is_held(&tbl->lock)));
> -			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
> +			next = neigh_next_rcu_protected(n, lockdep_is_held(&tbl->lock));

then, this will be unnecessary.


> +			hlist_del_rcu(&n->list);
> +			hlist_add_head_rcu(&n->list, &new_nht->hash_buckets[hash]);
>  		}
>  	}
>  
> @@ -693,11 +682,9 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
>  		goto out_tbl_unlock;
>  	}
>  
> -	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
> -					    lockdep_is_held(&tbl->lock));
> -	     n1 != NULL;
> -	     n1 = rcu_dereference_protected(n1->next,
> -			lockdep_is_held(&tbl->lock))) {
> +	neigh_for_each_rcu(n1,
> +			   &nht->hash_buckets[hash_val],
> +			   lockdep_is_held(&tbl->lock)) {

lockdep_is_held() is used above.

Let's use neigh_for_each().


[...]
> @@ -3242,7 +3208,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
>  		if (v)
>  			return n;
>  	}
> -	n = rcu_dereference(n->next);
> +
> +	n = neigh_next_rcu(n);

I guess neigh_get_next() can be simplified with
hlist_for_each_entry_continue_rcu() ?

Then, neigh_first_rcu() and neigh_next_rcu() would be unnecessary ?

>  
>  	while (1) {
>  		while (n) {
> @@ -3260,7 +3227,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
>  			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
>  				break;
>  next:
> -			n = rcu_dereference(n->next);
> +
> +			n = neigh_next_rcu(n);
>  		}
>  
>  		if (n)
> @@ -3269,7 +3237,7 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
>  		if (++state->bucket >= (1 << nht->hash_shift))
>  			break;
>  
> -		n = rcu_dereference(nht->hash_buckets[state->bucket]);
> +		n = neigh_first_rcu(&nht->hash_buckets[state->bucket]);
>  	}
>  
>  	if (n && pos)
> -- 
> 2.46.0
> 

