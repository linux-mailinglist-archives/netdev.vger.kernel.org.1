Return-Path: <netdev+bounces-187708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A074AA901A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1483AA2DF
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DB194A44;
	Mon,  5 May 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4foXtcx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02966224CC
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438703; cv=none; b=ohtn1maMTiKiBO4jr+W38y7ayd4iPXKQzT2DGe1/oVFlIP+F9VWo88KOeK1Xc/FM1tTbw7zGONWmGHuzp7yWOrvc6u5U/uQZiozPf9GqsslJud385nP83rnxVuStUmRXWY0llxg8yPP7h7Ywe93/nxZqvnwd6FjWZUobS+U76Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438703; c=relaxed/simple;
	bh=CqqHSDFCxzgmmKzCI6Pn4TRPNNmvcfeLWriOzCSBWww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqCYnkQS0dv8yaaaTlbsYuQhr2iWEdQLRYD6eLaeSw0uho4xZTAv/wEbybUNjP+B132zHfycuTGcsU4t17foXqV4h74oBF+8mVFPpmFMw3PLqgfi1X1EnkrlS4PPWT9lwY2BtJb+Xl+z/9omvsFq/jH7x6UrOSYvX+BVrAOs4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4foXtcx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746438699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icFNvxptqndSs8QJvHWmCIN1jknmR3snQIsZhRdBFoM=;
	b=E4foXtcxGO4jB0DeTREmNOipuoXilHhdujqTg0miLnN/+sdQmUHBkEcsWy0BWWafYBIAnZ
	IxZcNiCkESgGpx1e4aHOiaIC8D2XSoNTtNTeGmt9wBBMuiRECcznbUnVd9QOST7F/C8MAP
	7vBvPjPWQ3uqbc3gDF6qKqHyo+1W6cM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-GstJFnX6PjajwCzbsmcm8w-1; Mon, 05 May 2025 05:51:38 -0400
X-MC-Unique: GstJFnX6PjajwCzbsmcm8w-1
X-Mimecast-MFC-AGG-ID: GstJFnX6PjajwCzbsmcm8w_1746438697
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so22231935e9.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 02:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746438697; x=1747043497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icFNvxptqndSs8QJvHWmCIN1jknmR3snQIsZhRdBFoM=;
        b=qFJa9BO1vGqsQ3R2itq8ubOcC/T1rbhTPi634GpAK9VFEu3NwlV0QwXaYAetwxZxH9
         ouNgoW9Yjvd4b6aqiG7B6RFP+TbofmL+tLWIABzKkA8Z5kd4WX8hRhH+UYLF8mOKfbeu
         Nb+6Su8lmidROh0VcLnYL25JolkejLU7anodRyEAgLhDOQwtFLrD8QUAUoTFcnntqCJs
         zxjCtk6lBJ3LnNA2jUo4O13s8Ly4DXDuw9YZuqbCBJKpIQIYXg61IGVYD3j3YjJuf6zW
         b6JWg7t9o9t2nlb9m35Lu4W4UADbhr3xBnQgkEa9G5wRFmQU8IoRLo5oXCoOcaaFSp0B
         2CHg==
X-Forwarded-Encrypted: i=1; AJvYcCU9yvRpxCIFCZqkCWXGweOYeDnB8EMK154Taazn+EhYgM1q4yXpW43rjorsLzYxcRvRqAKy6AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMq6civb/NFez+KKUipEgRimDcQ1j1Ol+szIRTLsQ3P7ovAKDR
	TjutCPBzjUiQNqj13yQpJLfxEz/41Xj5KWYjx/MoVqMCroPzvuWazodzy8sjwpBPYv4ZP10Tfnv
	XIVFhKn7oJ3PyHJ68LSYEx82yywQaNzvTngfPrYVW0TDqX68uAJoOhQ==
X-Gm-Gg: ASbGncsCfX+G0c7ROW+Wjwxn9XRCWTN5el6KSgWYVXlMYYWsK+0KIDbJzUXbbpiSIqW
	Rj3gNtvH8ivuQMjhvIb3iM0iusKQxd+DXFqSmWDRlSuHSnAjRKunKRhZflXtImFfTAh+3DVFvN3
	5WnWdJLrEFzIQLjltdVWxLsNOezPqyj0qHc58RMAa+U6fWHPvFXQQ5yemdtj88OgoKuq3TSoOQA
	EcQPDX0q6ohcuHmI5/srnYfB5qUeAr+os4vV3qkhTsI7GY/jCUqaD4YLCIEJgVmN2GsXOEsvZwt
	LQt8BHFFaijY8A+Uy9RA8+NK2I4562dTmLEBwOSaojkUF5oNBTjsS4kx9cc=
X-Received: by 2002:a05:600c:cce:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-441c4937624mr50138385e9.25.1746438696982;
        Mon, 05 May 2025 02:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQdxLdIGKhBJMCMrQ2ObCwLOqLXDn2SEcQUB9lsYbUVZui664f+29yW8wgsjPZ+/fbpRxIdw==
X-Received: by 2002:a05:600c:cce:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-441c4937624mr50138075e9.25.1746438696507;
        Mon, 05 May 2025 02:51:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af32a0sm176148215e9.23.2025.05.05.02.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 02:51:36 -0700 (PDT)
Message-ID: <1d7a6230-5ece-48f8-9b7d-ec19d6189677@redhat.com>
Date: Mon, 5 May 2025 11:51:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 04/15] net: homa: create homa_pool.h and
 homa_pool.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-5-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-5-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
[...]
> +/**
> + * set_bpages_needed() - Set the bpages_needed field of @pool based
> + * on the length of the first RPC that's waiting for buffer space.
> + * The caller must own the lock for @pool->hsk.
> + * @pool: Pool to update.
> + */
> +static void set_bpages_needed(struct homa_pool *pool)
> +{
> +	struct homa_rpc *rpc = list_first_entry(&pool->hsk->waiting_for_bufs,
> +			struct homa_rpc, buf_links);

Minor nit: please insert an empty line between variable declaration and
code.

> +	pool->bpages_needed = (rpc->msgin.length + HOMA_BPAGE_SIZE - 1)
> +			>> HOMA_BPAGE_SHIFT;

Minor nit: please fix the indentation above

> +}
> +
> +/**
> + * homa_pool_new() - Allocate and initialize a new homa_pool (it will have
> + * no region associated with it until homa_pool_set_region is invoked).
> + * @hsk:          Socket the pool will be associated with.
> + * Return: A pointer to the new pool or a negative errno.
> + */
> +struct homa_pool *homa_pool_new(struct homa_sock *hsk)

The proferrend name includes for an allocator includes 'alloc', not 'new'.

> +{
> +	struct homa_pool *pool;
> +
> +	pool = kzalloc(sizeof(*pool), GFP_ATOMIC);

You should try to use GFP_KERNEL allocation as much as you can, and use
GFP_ATOMIC only in atomic context. If needed, try to move the function
outside the atomic scope doing the allocation before acquiring the
lock/rcu.

> +	if (!pool)
> +		return ERR_PTR(-ENOMEM);
> +	pool->hsk = hsk;
> +	return pool;
> +}
> +
> +/**
> + * homa_pool_set_region() - Associate a region of memory with a pool.
> + * @pool:         Pool the region will be associated with. Must not currently
> + *                have a region associated with it.
> + * @region:       First byte of the memory region for the pool, allocated
> + *                by the application; must be page-aligned.
> + * @region_size:  Total number of bytes available at @buf_region.
> + * Return: Either zero (for success) or a negative errno for failure.
> + */
> +int homa_pool_set_region(struct homa_pool *pool, void __user *region,
> +		   u64 region_size)
> +{
> +	int i, result;
> +
> +	if (pool->region)
> +		return -EINVAL;
> +
> +	if (((uintptr_t)region) & ~PAGE_MASK)
> +		return -EINVAL;
> +	pool->region = (char __user *)region;
> +	pool->num_bpages = region_size >> HOMA_BPAGE_SHIFT;
> +	pool->descriptors = NULL;
> +	pool->cores = NULL;
> +	if (pool->num_bpages < MIN_POOL_SIZE) {
> +		result = -EINVAL;
> +		goto error;
> +	}
> +	pool->descriptors = kmalloc_array(pool->num_bpages,
> +					  sizeof(struct homa_bpage),
> +					  GFP_ATOMIC | __GFP_ZERO);
> +	if (!pool->descriptors) {
> +		result = -ENOMEM;
> +		goto error;
> +	}
> +	for (i = 0; i < pool->num_bpages; i++) {
> +		struct homa_bpage *bp = &pool->descriptors[i];
> +
> +		spin_lock_init(&bp->lock);
> +		bp->owner = -1;
> +	}
> +	atomic_set(&pool->free_bpages, pool->num_bpages);
> +	pool->bpages_needed = INT_MAX;
> +
> +	/* Allocate and initialize core-specific data. */
> +	pool->cores = alloc_percpu_gfp(struct homa_pool_core,
> +				       GFP_ATOMIC | __GFP_ZERO);
> +	if (!pool->cores) {
> +		result = -ENOMEM;
> +		goto error;
> +	}
> +	pool->num_cores = nr_cpu_ids;

The 'num_cores' field is likely not needed, and it's never used in this
series.

> +	pool->check_waiting_invoked = 0;
> +
> +	return 0;
> +
> +error:
> +	kfree(pool->descriptors);
> +	free_percpu(pool->cores);

The above assumes that 'pool' will be zeroed at allocation time, but the
allocator does not do that. You should probably add the __GFP_ZERO flag
to the pool allocator.

> +	pool->region = NULL;
> +	return result;
> +}
> +
> +/**
> + * homa_pool_destroy() - Destructor for homa_pool. After this method
> + * returns, the object should not be used (it will be freed here).
> + * @pool: Pool to destroy.
> + */
> +void homa_pool_destroy(struct homa_pool *pool)
> +{
> +	if (pool->region) {
> +		kfree(pool->descriptors);
> +		free_percpu(pool->cores);
> +		pool->region = NULL;
> +	}
> +	kfree(pool);
> +}
> +
> +/**
> + * homa_pool_get_rcvbuf() - Return information needed to handle getsockopt
> + * for HOMA_SO_RCVBUF.
> + * @pool:         Pool for which information is needed.
> + * @args:         Store info here.
> + */
> +void homa_pool_get_rcvbuf(struct homa_pool *pool,
> +			  struct homa_rcvbuf_args *args)
> +{
> +	args->start = (uintptr_t)pool->region;
> +	args->length = pool->num_bpages << HOMA_BPAGE_SHIFT;
> +}
> +
> +/**
> + * homa_bpage_available() - Check whether a bpage is available for use.
> + * @bpage:      Bpage to check
> + * @now:        Current time (sched_clock() units)
> + * Return:      True if the bpage is free or if it can be stolen, otherwise
> + *              false.
> + */
> +bool homa_bpage_available(struct homa_bpage *bpage, u64 now)
> +{
> +	int ref_count = atomic_read(&bpage->refs);
> +
> +	return ref_count == 0 || (ref_count == 1 && bpage->owner >= 0 &&
> +			bpage->expiration <= now);

Minor nit: please fix the indentation above. Other cases below. Please
validate your patch with the checkpatch.pl script.

> +}
> +
> +/**
> + * homa_pool_get_pages() - Allocate one or more full pages from the pool.
> + * @pool:         Pool from which to allocate pages
> + * @num_pages:    Number of pages needed
> + * @pages:        The indices of the allocated pages are stored here; caller
> + *                must ensure this array is big enough. Reference counts have
> + *                been set to 1 on all of these pages (or 2 if set_owner
> + *                was specified).
> + * @set_owner:    If nonzero, the current core is marked as owner of all
> + *                of the allocated pages (and the expiration time is also
> + *                set). Otherwise the pages are left unowned.
> + * Return: 0 for success, -1 if there wasn't enough free space in the pool.
> + */
> +int homa_pool_get_pages(struct homa_pool *pool, int num_pages, u32 *pages,
> +			int set_owner)
> +{
> +	int core_num = smp_processor_id();
> +	struct homa_pool_core *core;
> +	u64 now = sched_clock();

From sched_clock() documentation:

sched_clock() has no promise of monotonicity or bounded drift between
CPUs, use (which you should not) requires disabling IRQs.

Can't be used for an expiration time. You could use 'jiffies' instead,

> +	int alloced = 0;
> +	int limit = 0;
> +
> +	core = this_cpu_ptr(pool->cores);
> +	if (atomic_sub_return(num_pages, &pool->free_bpages) < 0) {
> +		atomic_add(num_pages, &pool->free_bpages);
> +		return -1;
> +	}
> +
> +	/* Once we get to this point we know we will be able to find
> +	 * enough free pages; now we just have to find them.
> +	 */
> +	while (alloced != num_pages) {
> +		struct homa_bpage *bpage;
> +		int cur;
> +
> +		/* If we don't need to use all of the bpages in the pool,
> +		 * then try to use only the ones with low indexes. This
> +		 * will reduce the cache footprint for the pool by reusing
> +		 * a few bpages over and over. Specifically this code will
> +		 * not consider any candidate page whose index is >= limit.
> +		 * Limit is chosen to make sure there are a reasonable
> +		 * number of free pages in the range, so we won't have to
> +		 * check a huge number of pages.
> +		 */
> +		if (limit == 0) {
> +			int extra;
> +
> +			limit = pool->num_bpages
> +					- atomic_read(&pool->free_bpages);

Nit: indentation above, the operator should stay on the first line.

> +			extra = limit >> 2;
> +			limit += (extra < MIN_EXTRA) ? MIN_EXTRA : extra;
> +			if (limit > pool->num_bpages)
> +				limit = pool->num_bpages;
> +		}
> +
> +		cur = core->next_candidate;
> +		core->next_candidate++;
> +		if (cur >= limit) {
> +			core->next_candidate = 0;
> +
> +			/* Must recompute the limit for each new loop through
> +			 * the bpage array: we may need to consider a larger
> +			 * range of pages because of concurrent allocations.
> +			 */
> +			limit = 0;
> +			continue;
> +		}
> +		bpage = &pool->descriptors[cur];
> +
> +		/* Figure out whether this candidate is free (or can be
> +		 * stolen). Do a quick check without locking the page, and
> +		 * if the page looks promising, then lock it and check again
> +		 * (must check again in case someone else snuck in and
> +		 * grabbed the page).
> +		 */
> +		if (!homa_bpage_available(bpage, now))
> +			continue;

homa_bpage_available() accesses bpage without lock, so needs READ_ONCE()
annotations on the relevant fields and you needed to add paied
WRITE_ONCE() when updating them.

> +		if (!spin_trylock_bh(&bpage->lock))

Why only trylock? I have a vague memory on some discussion on this point
in a previous revision. You should at least add a comment here on in the
commit message explaning why a plain spin_lock does not fit.

> +			continue;
> +		if (!homa_bpage_available(bpage, now)) {
> +			spin_unlock_bh(&bpage->lock);
> +			continue;
> +		}
> +		if (bpage->owner >= 0)
> +			atomic_inc(&pool->free_bpages);
> +		if (set_owner) {
> +			atomic_set(&bpage->refs, 2);
> +			bpage->owner = core_num;
> +			bpage->expiration = now + 1000 *
> +					pool->hsk->homa->bpage_lease_usecs;
> +		} else {
> +			atomic_set(&bpage->refs, 1);
> +			bpage->owner = -1;
> +		}
> +		spin_unlock_bh(&bpage->lock);
> +		pages[alloced] = cur;
> +		alloced++;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * homa_pool_allocate() - Allocate buffer space for an RPC.
> + * @rpc:  RPC that needs space allocated for its incoming message (space must
> + *        not already have been allocated). The fields @msgin->num_buffers
> + *        and @msgin->buffers are filled in. Must be locked by caller.
> + * Return: The return value is normally 0, which means either buffer space
> + * was allocated or the @rpc was queued on @hsk->waiting. If a fatal error
> + * occurred, such as no buffer pool present, then a negative errno is
> + * returned.
> + */
> +int homa_pool_allocate(struct homa_rpc *rpc)
> +	__must_hold(&rpc->bucket->lock)
> +{
> +	struct homa_pool *pool = rpc->hsk->buffer_pool;
> +	int full_pages, partial, i, core_id;
> +	u32 pages[HOMA_MAX_BPAGES];
> +	struct homa_pool_core *core;
> +	struct homa_bpage *bpage;
> +	struct homa_rpc *other;
> +
> +	if (!pool->region)
> +		return -ENOMEM;
> +
> +	/* First allocate any full bpages that are needed. */
> +	full_pages = rpc->msgin.length >> HOMA_BPAGE_SHIFT;
> +	if (unlikely(full_pages)) {
> +		if (homa_pool_get_pages(pool, full_pages, pages, 0) != 0)
> +			goto out_of_space;
> +		for (i = 0; i < full_pages; i++)
> +			rpc->msgin.bpage_offsets[i] = pages[i] <<
> +					HOMA_BPAGE_SHIFT;
> +	}
> +	rpc->msgin.num_bpages = full_pages;
> +
> +	/* The last chunk may be less than a full bpage; for this we use
> +	 * the bpage that we own (and reuse it for multiple messages).
> +	 */
> +	partial = rpc->msgin.length & (HOMA_BPAGE_SIZE - 1);
> +	if (unlikely(partial == 0))
> +		goto success;
> +	core_id = smp_processor_id();

Is this code running in non-preemptible scope? otherwise you need to use
get_cpu() here and put_cpu() when you are done with 'core_id'.

> +	core = this_cpu_ptr(pool->cores);
> +	bpage = &pool->descriptors[core->page_hint];
> +	if (!spin_trylock_bh(&bpage->lock))
> +		spin_lock_bh(&bpage->lock);

I think I already commented on this pattern. Please don't use it.

> +	if (bpage->owner != core_id) {
> +		spin_unlock_bh(&bpage->lock);
> +		goto new_page;
> +	}
> +	if ((core->allocated + partial) > HOMA_BPAGE_SIZE) {
> +		if (atomic_read(&bpage->refs) == 1) {
> +			/* Bpage is totally free, so we can reuse it. */
> +			core->allocated = 0;
> +		} else {
> +			bpage->owner = -1;
> +
> +			/* We know the reference count can't reach zero here
> +			 * because of check above, so we won't have to decrement
> +			 * pool->free_bpages.
> +			 */
> +			atomic_dec_return(&bpage->refs);
> +			spin_unlock_bh(&bpage->lock);
> +			goto new_page;
> +		}
> +	}
> +	bpage->expiration = sched_clock() +
> +			1000 * pool->hsk->homa->bpage_lease_usecs;
> +	atomic_inc(&bpage->refs);
> +	spin_unlock_bh(&bpage->lock);
> +	goto allocate_partial;
> +
> +	/* Can't use the current page; get another one. */
> +new_page:
> +	if (homa_pool_get_pages(pool, 1, pages, 1) != 0) {
> +		homa_pool_release_buffers(pool, rpc->msgin.num_bpages,
> +					  rpc->msgin.bpage_offsets);
> +		rpc->msgin.num_bpages = 0;
> +		goto out_of_space;
> +	}
> +	core->page_hint = pages[0];
> +	core->allocated = 0;
> +
> +allocate_partial:
> +	rpc->msgin.bpage_offsets[rpc->msgin.num_bpages] = core->allocated
> +			+ (core->page_hint << HOMA_BPAGE_SHIFT);
> +	rpc->msgin.num_bpages++;
> +	core->allocated += partial;
> +
> +success:
> +	return 0;
> +
> +	/* We get here if there wasn't enough buffer space for this
> +	 * message; add the RPC to hsk->waiting_for_bufs.

Please also add a comment describing why waiting RPCs are sorted by
message size.

> +	 */
> +out_of_space:
> +	homa_sock_lock(pool->hsk);
> +	list_for_each_entry(other, &pool->hsk->waiting_for_bufs, buf_links) {
> +		if (other->msgin.length > rpc->msgin.length) {
> +			list_add_tail(&rpc->buf_links, &other->buf_links);
> +			goto queued;
> +		}
> +	}
> +	list_add_tail(&rpc->buf_links, &pool->hsk->waiting_for_bufs);
> +
> +queued:
> +	set_bpages_needed(pool);
> +	homa_sock_unlock(pool->hsk);
> +	return 0;
> +}
> +
> +/**
> + * homa_pool_get_buffer() - Given an RPC, figure out where to store incoming
> + * message data.
> + * @rpc:        RPC for which incoming message data is being processed; its
> + *              msgin must be properly initialized and buffer space must have
> + *              been allocated for the message.
> + * @offset:     Offset within @rpc's incoming message.
> + * @available:  Will be filled in with the number of bytes of space available
> + *              at the returned address (could be zero if offset is
> + *              (erroneously) past the end of the message).
> + * Return:      The application's virtual address for buffer space corresponding
> + *              to @offset in the incoming message for @rpc.
> + */
> +void __user *homa_pool_get_buffer(struct homa_rpc *rpc, int offset,
> +				  int *available)
> +{
> +	int bpage_index, bpage_offset;
> +
> +	bpage_index = offset >> HOMA_BPAGE_SHIFT;
> +	if (offset >= rpc->msgin.length) {
> +		WARN_ONCE(true, "%s got offset %d >= message length %d\n",
> +			  __func__, offset, rpc->msgin.length);
> +		*available = 0;
> +		return NULL;
> +	}
> +	bpage_offset = offset & (HOMA_BPAGE_SIZE - 1);
> +	*available = (bpage_index < (rpc->msgin.num_bpages - 1))
> +			? HOMA_BPAGE_SIZE - bpage_offset
> +			: rpc->msgin.length - offset;
> +	return rpc->hsk->buffer_pool->region +
> +			rpc->msgin.bpage_offsets[bpage_index] + bpage_offset;
> +}
> +
> +/**
> + * homa_pool_release_buffers() - Release buffer space so that it can be
> + * reused.
> + * @pool:         Pool that the buffer space belongs to. Doesn't need to
> + *                be locked.
> + * @num_buffers:  How many buffers to release.
> + * @buffers:      Points to @num_buffers values, each of which is an offset
> + *                from the start of the pool to the buffer to be released.
> + * Return:        0 for success, otherwise a negative errno.
> + */
> +int homa_pool_release_buffers(struct homa_pool *pool, int num_buffers,
> +			      u32 *buffers)
> +{
> +	int result = 0;
> +	int i;
> +
> +	if (!pool->region)
> +		return result;
> +	for (i = 0; i < num_buffers; i++) {
> +		u32 bpage_index = buffers[i] >> HOMA_BPAGE_SHIFT;
> +		struct homa_bpage *bpage = &pool->descriptors[bpage_index];
> +
> +		if (bpage_index < pool->num_bpages) {
> +			if (atomic_dec_return(&bpage->refs) == 0)
> +				atomic_inc(&pool->free_bpages);
> +		} else {
> +			result = -EINVAL;
> +		}
> +	}
> +	return result;
> +}
> +
> +/**
> + * homa_pool_check_waiting() - Checks to see if there are enough free
> + * bpages to wake up any RPCs that were blocked. Whenever
> + * homa_pool_release_buffers is invoked, this function must be invoked later,
> + * at a point when the caller holds no locks (homa_pool_release_buffers may
> + * be invoked with locks held, so it can't safely invoke this function).
> + * This is regrettably tricky, but I can't think of a better solution.
> + * @pool:         Information about the buffer pool.
> + */
> +void homa_pool_check_waiting(struct homa_pool *pool)
> +{
> +	if (!pool->region)
> +		return;
> +	while (atomic_read(&pool->free_bpages) >= pool->bpages_needed) {
> +		struct homa_rpc *rpc;
> +
> +		homa_sock_lock(pool->hsk);
> +		if (list_empty(&pool->hsk->waiting_for_bufs)) {
> +			pool->bpages_needed = INT_MAX;
> +			homa_sock_unlock(pool->hsk);
> +			break;
> +		}
> +		rpc = list_first_entry(&pool->hsk->waiting_for_bufs,
> +				       struct homa_rpc, buf_links);
> +		if (!homa_rpc_try_lock(rpc)) {
> +			/* Can't just spin on the RPC lock because we're
> +			 * holding the socket lock (see sync.txt). Instead,

The documenation should live under:

Documentation/networking/

likely in its own subdir, and must be in restructured format.

Here you should just mention that the lock acquiring order is rpc ->
home sock lock.

> +			 * release the socket lock and try the entire
> +			 * operation again.
> +			 */
> +			homa_sock_unlock(pool->hsk);
> +			continue;
> +		}
> +		list_del_init(&rpc->buf_links);
> +		if (list_empty(&pool->hsk->waiting_for_bufs))
> +			pool->bpages_needed = INT_MAX;
> +		else
> +			set_bpages_needed(pool);
> +		homa_sock_unlock(pool->hsk);
> +		homa_pool_allocate(rpc);

Why you don't need to check the allocation return value here?

> +		homa_rpc_unlock(rpc);
> +	}
> +}
> diff --git a/net/homa/homa_pool.h b/net/homa/homa_pool.h
> new file mode 100644
> index 000000000000..d52d61afa557
> --- /dev/null
> +++ b/net/homa/homa_pool.h
> @@ -0,0 +1,149 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +
> +/* This file contains definitions used to manage user-space buffer pools.
> + */
> +
> +#ifndef _HOMA_POOL_H
> +#define _HOMA_POOL_H
> +
> +#include <linux/percpu.h>
> +
> +#include "homa_rpc.h"
> +
> +/**
> + * struct homa_bpage - Contains information about a single page in
> + * a buffer pool.
> + */
> +struct homa_bpage {
> +	union {
> +		/**
> +		 * @cache_line: Ensures that each homa_bpage object
> +		 * is exactly one cache line long.
> +		 */
> +		char cache_line[L1_CACHE_BYTES];

Instead of the struct/union nesting just use ____cacheline_aligned

[...]
> +* Homa's approach means that socket shutdown and deletion can potentially
> +  occur while operations are underway that hold RPC locks but not the socket
> +  lock. This creates several potential problems:
> +  * A socket might be deleted and its memory reclaimed while an RPC still
> +    has access to it. Homa assumes that Linux will prevent socket deletion
> +    while the kernel call is executing. 

This last sentence is not clear to me. Do you mean that the kernel
ensures that the socket is freed after the close() syscall?

/P


