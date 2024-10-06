Return-Path: <netdev+bounces-132506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD257991F80
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957322821FB
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68316189507;
	Sun,  6 Oct 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mlRddJpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F4188CBE
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728229954; cv=none; b=AIktz0TEscwjH6Rz1jP3ZfItFSoyWbPjZQYILRFLYzymzJmlUa/T746w0hdhXiy8xov3i/0my0lTStnpjJ3yoNh1g3aM6hMTIu/BSKWryUj8XBZ0xkqll/xV13MBo4X4nL08lv+NuVXL7j4ypgKP/H9JIPC87+L4w3YMtGuDafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728229954; c=relaxed/simple;
	bh=FbrcRrYfU63yXAlT1kk/abKoP+4ssNGtv8CVoqTKpZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSEyYxTKJjrKjimWduHPY2RvuqhXQ1WBzkMdl724zH3jYz1eh2gA0dr0z5M0t61EMY37ISSraVKt4UfgyQkJAyP+uRSpiELcd41nqP9bq6W1YiIF+42sFj+GonI6Ro51j3TopeY3Ko7ml9D1q4hTcI3PqtIaD+JYmMURhvJu9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mlRddJpc; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728229953; x=1759765953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szFpUUr8CGv0GHWZQ2a3udAQrsDhTsa7I9ZCngXgDY0=;
  b=mlRddJpcRSmggbIuK0h19tdsF9G42LOqrY2kmsd2BA/NFcgxIG3yUngf
   wJriYQo8HXdMVO4BEEXk6wUbk6NpFDcCLcTmZuIZDbxV2rZ2iIM7eAC3F
   gbDdKjGmcW9qAYxoGs/6RFIb453mWoHmxG8T/U/Y8GsOunif7a/vUM3Nt
   g=;
X-IronPort-AV: E=Sophos;i="6.11,182,1725321600"; 
   d="scan'208";a="340311625"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 15:52:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:9730]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.158:2525] with esmtp (Farcaster)
 id e708e365-02fc-4696-85fb-a605e187df6d; Sun, 6 Oct 2024 15:52:29 +0000 (UTC)
X-Farcaster-Flow-ID: e708e365-02fc-4696-85fb-a605e187df6d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 6 Oct 2024 15:52:28 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 6 Oct 2024 15:52:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] Convert neighbour-table to use hlist
Date: Sun, 6 Oct 2024 08:52:18 -0700
Message-ID: <20241006155218.58158-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241006064747.201773-2-gnaaman@drivenets.com>
References: <20241006064747.201773-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Sun,  6 Oct 2024 06:47:42 +0000
> Use doubly-linked instead of singly-linked list when linking neighbours,
> so that it is possible to remove neighbours without traversing the
> entire table.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  include/net/neighbour.h |   8 +--
>  net/core/neighbour.c    | 124 ++++++++++++++--------------------------
>  2 files changed, 46 insertions(+), 86 deletions(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index a44f262a7384..5dde118323e3 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -135,7 +135,7 @@ struct neigh_statistics {
>  #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
>  
>  struct neighbour {
> -	struct neighbour __rcu	*next;
> +	struct hlist_node	list;
>  	struct neigh_table	*tbl;
>  	struct neigh_parms	*parms;
>  	unsigned long		confirmed;
> @@ -190,7 +190,7 @@ struct pneigh_entry {
>  #define NEIGH_NUM_HASH_RND	4
>  
>  struct neigh_hash_table {
> -	struct neighbour __rcu	**hash_buckets;
> +	struct hlist_head	*hash_buckets;
>  	unsigned int		hash_shift;
>  	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
>  	struct rcu_head		rcu;
> @@ -304,9 +304,9 @@ static inline struct neighbour *___neigh_lookup_noref(
>  	u32 hash_val;
>  
>  	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
> -	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
> +	for (n = (struct neighbour *)rcu_dereference(hlist_first_rcu(&nht->hash_buckets[hash_val]));

This for loop and hlist_first_rcu(&nht->hash_buckets[hash_val])
can also be written with a macro and an inline function.


>  	     n != NULL;
> -	     n = rcu_dereference(n->next)) {
> +	     n = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list))) {

This part is also reused multiple times so should be an inline function.

I have similar patches for struct in_ifaddr.ifa_next (not upstreamed yet),
and this will be a good example for you.
https://github.com/q2ven/linux/commit/a51fdf7ccc14bf6edba58bacf7faaeebe811d41b


>  		if (n->dev == dev && key_eq(n, pkey))
>  			return n;
>  	}
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 77b819cd995b..86b174baae27 100644
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
> @@ -205,18 +206,13 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
>  	}
>  }
>  
> -static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
> -		      struct neigh_table *tbl)
> +static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)
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
> @@ -228,25 +224,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
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
> @@ -388,21 +366,20 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
>  
>  	for (i = 0; i < (1 << nht->hash_shift); i++) {
>  		struct neighbour *n;
> -		struct neighbour __rcu **np = &nht->hash_buckets[i];
> +		struct neighbour __rcu **np =
> +			(struct neighbour __rcu **)&nht->hash_buckets[i].first;

This will be no longer needed for doubly linked list,


>  
>  		while ((n = rcu_dereference_protected(*np,
>  					lockdep_is_held(&tbl->lock))) != NULL) {

and this while can be converted to the for-loop macro.


>  			if (dev && n->dev != dev) {
> -				np = &n->next;
> +				np = (struct neighbour __rcu **)&n->list.next;
>  				continue;
>  			}
>  			if (skip_perm && n->nud_state & NUD_PERMANENT) {
> -				np = &n->next;
> +				np = (struct neighbour __rcu **)&n->list.next;
>  				continue;
>  			}
> -			rcu_assign_pointer(*np,
> -				   rcu_dereference_protected(n->next,
> -						lockdep_is_held(&tbl->lock)));
> +			hlist_del_rcu(&n->list);
>  			write_lock(&n->lock);
>  			neigh_del_timer(n);
>  			neigh_mark_dead(n);
> @@ -530,9 +507,9 @@ static void neigh_get_hash_rnd(u32 *x)
>  
>  static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  {
> -	size_t size = (1 << shift) * sizeof(struct neighbour *);
> +	size_t size = (1 << shift) * sizeof(struct hlist_head);
>  	struct neigh_hash_table *ret;
> -	struct neighbour __rcu **buckets;
> +	struct hlist_head *buckets;
>  	int i;
>  
>  	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
> @@ -541,7 +518,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  	if (size <= PAGE_SIZE) {
>  		buckets = kzalloc(size, GFP_ATOMIC);
>  	} else {
> -		buckets = (struct neighbour __rcu **)
> +		buckets = (struct hlist_head *)
>  			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
>  					   get_order(size));
>  		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
> @@ -562,8 +539,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
>  	struct neigh_hash_table *nht = container_of(head,
>  						    struct neigh_hash_table,
>  						    rcu);
> -	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
> -	struct neighbour __rcu **buckets = nht->hash_buckets;
> +	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
> +	struct hlist_head *buckets = nht->hash_buckets;
>  
>  	if (size <= PAGE_SIZE) {
>  		kfree(buckets);
> @@ -591,22 +568,18 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
>  	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
>  		struct neighbour *n, *next;
>  
> -		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
> -						   lockdep_is_held(&tbl->lock));
> +		for (n = (struct neighbour *)
> +			rcu_dereference_protected(hlist_first_rcu(&old_nht->hash_buckets[i]),
> +						  lockdep_is_held(&tbl->lock));

This can be macro.


>  		     n != NULL;
>  		     n = next) {
>  			hash = tbl->hash(n->primary_key, n->dev,
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
> +			next = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list));

This can be static inline function and reused for for-loop macro.


> +			hlist_del_rcu(&n->list);
> +			hlist_add_head_rcu(&n->list, &new_nht->hash_buckets[hash]);
>  		}
>  	}
>  
> @@ -693,11 +666,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
>  		goto out_tbl_unlock;
>  	}
>  
> -	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
> -					    lockdep_is_held(&tbl->lock));
> -	     n1 != NULL;
> -	     n1 = rcu_dereference_protected(n1->next,
> -			lockdep_is_held(&tbl->lock))) {
> +	hlist_for_each_entry_rcu(n1,
> +				 &nht->hash_buckets[hash_val],
> +				 list,
> +				 lockdep_is_held(&tbl->lock)) {

Let's define hlist_for_each_entry_rcu() as neigh-specific macro.


>  		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
>  			if (want_ref)
>  				neigh_hold(n1);
> @@ -713,10 +685,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
>  		list_add_tail(&n->managed_list, &n->tbl->managed_list);
>  	if (want_ref)
>  		neigh_hold(n);
> -	rcu_assign_pointer(n->next,
> -			   rcu_dereference_protected(nht->hash_buckets[hash_val],
> -						     lockdep_is_held(&tbl->lock)));
> -	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
> +	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
>  	write_unlock_bh(&tbl->lock);
>  	neigh_dbg(2, "neigh %p is created\n", n);
>  	rc = n;
> @@ -976,7 +945,7 @@ static void neigh_periodic_work(struct work_struct *work)
>  		goto out;
>  
>  	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
> -		np = &nht->hash_buckets[i];
> +		np = (struct neighbour __rcu **)&nht->hash_buckets[i].first;

No np here too,

>  
>  		while ((n = rcu_dereference_protected(*np,
>  				lockdep_is_held(&tbl->lock))) != NULL) {

and for-loop macro here.


> @@ -999,9 +968,7 @@ static void neigh_periodic_work(struct work_struct *work)
>  			    (state == NUD_FAILED ||
>  			     !time_in_range_open(jiffies, n->used,
>  						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
> -				rcu_assign_pointer(*np,
> -					rcu_dereference_protected(n->next,
> -						lockdep_is_held(&tbl->lock)));
> +				hlist_del_rcu(&n->list);
>  				neigh_mark_dead(n);
>  				write_unlock(&n->lock);
>  				neigh_cleanup_and_release(n);
> @@ -1010,7 +977,7 @@ static void neigh_periodic_work(struct work_struct *work)
>  			write_unlock(&n->lock);
>  
>  next_elt:
> -			np = &n->next;
> +			np = (struct neighbour __rcu **)&n->list.next;
>  		}
>  		/*
>  		 * It's fine to release lock here, even if hash table
> @@ -2728,9 +2695,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
>  	for (h = s_h; h < (1 << nht->hash_shift); h++) {
>  		if (h > s_h)
>  			s_idx = 0;
> -		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
> -		     n != NULL;
> -		     n = rcu_dereference(n->next)) {
> +		hlist_for_each_entry_rcu(n, &nht->hash_buckets[h], list) {
>  			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
>  				goto next;
>  			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
> @@ -3097,9 +3062,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
>  	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
>  		struct neighbour *n;
>  
> -		for (n = rcu_dereference(nht->hash_buckets[chain]);
> -		     n != NULL;
> -		     n = rcu_dereference(n->next))
> +		hlist_for_each_entry_rcu(n, &nht->hash_buckets[chain], list)
>  			cb(n, cookie);
>  	}
>  	read_unlock_bh(&tbl->lock);
> @@ -3120,7 +3083,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
>  		struct neighbour *n;
>  		struct neighbour __rcu **np;
>  
> -		np = &nht->hash_buckets[chain];
> +		np = (struct neighbour __rcu **)&nht->hash_buckets[chain].first;
>  		while ((n = rcu_dereference_protected(*np,
>  					lockdep_is_held(&tbl->lock))) != NULL) {

Same here.


>  			int release;
> @@ -3128,12 +3091,10 @@ void __neigh_for_each_release(struct neigh_table *tbl,
>  			write_lock(&n->lock);
>  			release = cb(n);
>  			if (release) {
> -				rcu_assign_pointer(*np,
> -					rcu_dereference_protected(n->next,
> -						lockdep_is_held(&tbl->lock)));
> +				hlist_del_rcu(&n->list);
>  				neigh_mark_dead(n);
>  			} else
> -				np = &n->next;
> +				np = (struct neighbour __rcu **)&n->list.next;
>  			write_unlock(&n->lock);
>  			if (release)
>  				neigh_cleanup_and_release(n);
> @@ -3200,25 +3161,21 @@ static struct neighbour *neigh_get_first(struct seq_file *seq)
>  
>  	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
>  	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
> -		n = rcu_dereference(nht->hash_buckets[bucket]);
> -
> -		while (n) {
> +		hlist_for_each_entry_rcu(n, &nht->hash_buckets[bucket], list) {
>  			if (!net_eq(dev_net(n->dev), net))
> -				goto next;
> +				continue;
>  			if (state->neigh_sub_iter) {
>  				loff_t fakep = 0;
>  				void *v;
>  
>  				v = state->neigh_sub_iter(state, n, &fakep);
>  				if (!v)
> -					goto next;
> +					continue;
>  			}
>  			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
>  				break;
>  			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
>  				break;
> -next:
> -			n = rcu_dereference(n->next);
>  		}
>  
>  		if (n)
> @@ -3242,7 +3199,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
>  		if (v)
>  			return n;
>  	}
> -	n = rcu_dereference(n->next);
> +
> +	n = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list));

inline helper should be used,


>  
>  	while (1) {
>  		while (n) {
> @@ -3260,7 +3218,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
>  			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
>  				break;
>  next:
> -			n = rcu_dereference(n->next);
> +
> +			n = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list));

same here,


>  		}
>  
>  		if (n)
> @@ -3269,7 +3228,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
>  		if (++state->bucket >= (1 << nht->hash_shift))
>  			break;
>  
> -		n = rcu_dereference(nht->hash_buckets[state->bucket]);
> +		n = (struct neighbour *)
> +		    rcu_dereference(hlist_first_rcu(&nht->hash_buckets[state->bucket]));

and here.


>  	}
>  
>  	if (n && pos)
> -- 
> 2.46.0

