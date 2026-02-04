Return-Path: <netdev+bounces-256509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKlsFnymgmmVXQMAu9opvQ
	(envelope-from <netdev+bounces-256509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:53:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C392DE0920
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE33530B19FF
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED52405E1;
	Wed,  4 Feb 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fB56CNxs"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9F27F195
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169976; cv=none; b=lTqyJN/9huYttM9NOh3Cv8XT+md51fh3ItM1mYCHrh/lYEnMIoX2C9U65FxmdJYN9e4xcGcSD7YYJ+2AeQXeyk38H2JwXFRfleehFnxE+aX0DnFfQZunxM+qF8rclNCiT6IrFqPIqcN/U7TcBlaq86hYfZG+ECO1vp/+laH/lLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169976; c=relaxed/simple;
	bh=GW+rkP3IR3K1AU7LjbHX+pRx2H+WK7a1plhmBTQdTDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pwykb2rI04IJqkSwVM5VbWkwwqSxNM+6egpzy24VeGO5ubycvIQO0yXI6w0BldtmmZapcJxA2baAP7jll6uzHK2Ocd7EiFRR+XrOzHZeW14hkiBQyCQBqeGzRNN5pmi2lsLKvkWnPJTveb9uE0ny4NKV18HMPR84bZkMtF52qlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fB56CNxs; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42d51b94-f8de-41df-98ba-b074e02e5d00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770169970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPNLQv+LvdfTrQOFA82L/Rop36opehWTIAJVuHamoO8=;
	b=fB56CNxsNcFgthvEYJ6vA3lWj86dtBvdC5uTjqoJ5X7cUolzhBU6eVma9jJ07if000/Z89
	7pTuztqSOOi1QsKcKcTPrIccMwbWNOFaYg5q8N7LVlHvJRnTIB7KtVTvapxaIibf7a9dMZ
	gPeRegib9d/EqpwWDkdOjilXhXXib/0=
Date: Tue, 3 Feb 2026 17:52:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 11/16] bpf: Switch to bpf_selem_unlink_nofail
 in bpf_local_storage_{map_free, destroy}
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260201175050.468601-1-ameryhung@gmail.com>
 <20260201175050.468601-12-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260201175050.468601-12-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256509-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C392DE0920
X-Rspamd-Action: no action

On 2/1/26 9:50 AM, Amery Hung wrote:
> Take care of rqspinlock error in bpf_local_storage_{map_free, destroy}()
> properly by switching to bpf_selem_unlink_nofail().
> 
> Both functions iterate their own RCU-protected list of selems and call
> bpf_selem_unlink_nofail(). In map_free(), to prevent infinite loop when
> both map_free() and destroy() fail to remove a selem from b->list
> (extremely unlikely), switch to hlist_for_each_entry_rcu(). In destroy(),
> also switch to hlist_for_each_entry_rcu() since we no longer iterate
> local_storage->list under local_storage->lock. In addition, defer it to
> workqueue as sleep may not always be possible in destroy().
> 
> Since selem, SDATA(selem)->smap and selem->local_storage may be seen by
> map_free() and destroy() at the same time, protect them with RCU. This
> means passing reuse_now == false to bpf_selem_free() and

Amery and I discussed some details offline. Summarize here to sync up 
the mailing list.

If only map_free/destroy is using the selem/local_storage, reuse_now 
should be true. reuse_now == true will go through the regular rcu gp. 
The current map_free/destroy should be under rcu_read_lock().

fwiw, some history, iirc it used to always go through rcu gp only. 
Sleepable support was added later, so rcu_tasks_trace gp was added. 
After a regression report, reuse_now (the name may have been changed 
once) was added to signal that no bpf prog is using the selem and to 
avoid waiting for the rcu_tasks_trace gp.

> bpf_local_storage_free(). The local storage map is already protected as
> bpf_local_storage_map_free() waits for an RCU grace period after
> iterating b->list and before freeing itself.
> 
> bpf_selem_unlink() now becomes dedicated to helpers and syscalls paths
> so reuse_now should always be false. Remove it from the argument and
> hardcode it.
> 
> Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   include/linux/bpf_local_storage.h |  5 +-
>   kernel/bpf/bpf_cgrp_storage.c     |  3 +-
>   kernel/bpf/bpf_inode_storage.c    |  3 +-
>   kernel/bpf/bpf_local_storage.c    | 96 +++++++++++++++++--------------
>   kernel/bpf/bpf_task_storage.c     |  3 +-
>   net/core/bpf_sk_storage.c         |  9 ++-
>   6 files changed, 69 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index cfa301ccc700..0d04f6babb2e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -101,6 +101,7 @@ struct bpf_local_storage {
>   	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
>   	u64 selems_size;	/* Total selem size. Protected by "lock" */
>   	refcount_t owner_refcnt;
> +	struct work_struct work;
>   	bool use_kmalloc_nolock;
>   };
>   
> @@ -168,7 +169,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
>   	return SDATA(selem);
>   }
>   
> -void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
> +u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
>   
>   void bpf_local_storage_map_free(struct bpf_map *map,
>   				struct bpf_local_storage_cache *cache);
> @@ -181,7 +182,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
>   void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
>   				   struct bpf_local_storage_elem *selem);
>   
> -int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
> +int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
>   
>   int bpf_selem_link_map(struct bpf_local_storage_map *smap,
>   		       struct bpf_local_storage *local_storage,
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index 853183eead2c..0bc3ab19c7b4 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -27,6 +27,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
>   	if (!local_storage)
>   		goto out;
>   
> +	RCU_INIT_POINTER(cgroup->bpf_cgrp_storage, NULL);
>   	bpf_local_storage_destroy(local_storage);
>   out:
>   	rcu_read_unlock();
> @@ -89,7 +90,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
>   	if (!sdata)
>   		return -ENOENT;
>   
> -	return bpf_selem_unlink(SELEM(sdata), false);
> +	return bpf_selem_unlink(SELEM(sdata));
>   }
>   
>   static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index 470f4b02c79e..eb607156ba35 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -68,6 +68,7 @@ void bpf_inode_storage_free(struct inode *inode)
>   	if (!local_storage)
>   		goto out;
>   
> +	RCU_INIT_POINTER(bsb->storage, NULL);
>   	bpf_local_storage_destroy(local_storage);
>   out:
>   	rcu_read_unlock_migrate();
> @@ -110,7 +111,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
>   	if (!sdata)
>   		return -ENOENT;
>   
> -	return bpf_selem_unlink(SELEM(sdata), false);
> +	return bpf_selem_unlink(SELEM(sdata));
>   }
>   
>   static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 1846067e6e7e..d02ad9052bd6 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -381,7 +381,11 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
>   	hlist_add_head_rcu(&selem->map_node, &b->list);
>   }
>   
> -int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
> +/*
> + * Unlink an selem from map and local storage with lock held.
> + * This is the common path used by local storages to delete an selem.
> + */
> +int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
>   {
>   	struct bpf_local_storage *local_storage;
>   	bool free_local_storage = false;
> @@ -415,10 +419,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>   out:
>   	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
>   
> -	bpf_selem_free_list(&selem_free_list, reuse_now);
> +	bpf_selem_free_list(&selem_free_list, false);
>   
>   	if (free_local_storage)
> -		bpf_local_storage_free(local_storage, reuse_now);
> +		bpf_local_storage_free(local_storage, false);

The false here is correct because bpf_selem_unlink is called by the bpf 
prog.

This is related to the next change. The bpf_selem_unlink (called by bpf 
prog, so a normal path) can free the local_storage after unlinking the 
last selem...

>   
>   	return err;
>   }
> @@ -648,7 +652,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   
>   	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
>   					      bpf_rcu_lock_held());
> -	if (!local_storage || hlist_empty(&local_storage->list)) {
> +	if (!local_storage) {
>   		/* Very first elem for the owner */
>   		err = check_flags(NULL, map_flags);
>   		if (err)
> @@ -696,17 +700,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   	if (err)
>   		goto free_selem;
>   
> -	/* Recheck local_storage->list under local_storage->lock */
> -	if (unlikely(hlist_empty(&local_storage->list))) {
> -		/* A parallel del is happening and local_storage is going
> -		 * away.  It has just been checked before, so very
> -		 * unlikely.  Return instead of retry to keep things
> -		 * simple.
> -		 */
> -		err = -EAGAIN;
> -		goto unlock;
> -	}
> -

... so skip checking hlist_empty(&local_storage->list) here before 
linking new selem could be UAF. The local_storage could have been freed 
in bpf_selem_unlink. If I am reading it correctly, this needs to be 
addressed.

>   	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
>   	err = check_flags(old_sdata, map_flags);
>   	if (err)
> @@ -810,13 +803,16 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
>   	return 0;
>   }
>   
> -void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
> +/*
> + * Deferred looping local_storage->list to workqueue since sleeping may not be
> + * allowed in bpf_local_storage_destroy()
> + */
> +static void bpf_local_storage_free_deferred(struct work_struct *work)
>   {
> +	struct bpf_local_storage *local_storage;
>   	struct bpf_local_storage_elem *selem;
> -	bool free_storage = false;
> -	HLIST_HEAD(free_selem_list);
> -	struct hlist_node *n;
> -	unsigned long flags;
> +
> +	local_storage = container_of(work, struct bpf_local_storage, work);
>   
>   	/* Neither the bpf_prog nor the bpf_map's syscall
>   	 * could be modifying the local_storage->list now.
> @@ -827,33 +823,44 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
>   	 * when unlinking elem from the local_storage->list and
>   	 * the map's bucket->list.
>   	 */
> -	raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> -	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> -		/* Always unlink from map before unlinking from
> -		 * local_storage.
> -		 */
> -		bpf_selem_unlink_map(selem);
> -		/* If local_storage list has only one element, the
> -		 * bpf_selem_unlink_storage_nolock() will return true.
> -		 * Otherwise, it will return false. The current loop iteration
> -		 * intends to remove all local storage. So the last iteration
> -		 * of the loop will set the free_cgroup_storage to true.
> -		 */
> -		free_storage = bpf_selem_unlink_storage_nolock(
> -			local_storage, selem, &free_selem_list);
> +	rcu_read_lock();
> +restart:
> +	hlist_for_each_entry_rcu(selem, &local_storage->list, snode) {
> +		bpf_selem_unlink_nofail(selem, NULL);
> +
> +		if (need_resched()) {
> +			cond_resched_rcu();

Unlike b->list, the local_storage->list should not be long. The current 
local_storage->list is also iterated under rcu_read_lock(). Can this 
iteration stay in bpf_local_storage_destroy and skip deferring to wq?

> +			goto restart;
> +		}
>   	}
> -	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags)
> +	rcu_read_unlock();
>   
> -	bpf_selem_free_list(&free_selem_list, true);
> +	bpf_local_storage_free(local_storage, false);

I think this can be bpf_local_storage_free(..., true)

> +}
> +
> +/*
> + * Destroy local storage when the owner is going away. Caller must clear owner->storage
> + * and uncharge memory if memory charging is used.
> + *
> + * Since smaps associated with selems may already be gone, mem_uncharge() or
> + * owner_storage() cannot be called in this function. Let the owner (i.e., the caller)
> + * do it instead.
> + */
> +u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
> +{
> +	INIT_WORK(&local_storage->work, bpf_local_storage_free_deferred);
>   
> -	if (free_storage)
> -		bpf_local_storage_free(local_storage, true);
> +	queue_work(system_dfl_wq, &local_storage->work);
>   
>   	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
>   		while (refcount_read(&local_storage->owner_refcnt))
>   			cpu_relax();
>   		smp_mb();  /* pair with refcount_dec in bpf_selem_unlink_nofail */

This puzzled me a bit when reading patch 10 alone without the following 
lines on local_storage->owner and local_storage->selems_size. :)

A nit. It will be useful to have more details here in patch 11. My 
understanding is to ensure the map_free() see the local_storage->owner 
and the destroy() here sees the correct local_storage->selems_size?

 > +
 > +	local_storage->owner = NULL;
 > +
 > +	return sizeof(*local_storage) + local_storage->selems_size;

