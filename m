Return-Path: <netdev+bounces-160566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB73A1A3C6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 13:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC43A61CC
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4B920E33F;
	Thu, 23 Jan 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGY9LtJS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2620E03C
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634010; cv=none; b=bjRf70EewKRf+ypujYtzu9JqL+mYzu1fgWN7etPSEzPlUW5CjHGkqDsC9RNRHjDs9Nbg2/bfhDYTbz7ZO5KUZS5VbvAw2Y5RokcC1F7/gEEqD8do6DyvkfxtBwVvrc6CBKZN4z+7FeCOCNiLxhhdVwFxe7/Nltm3GCaaWAOSL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634010; c=relaxed/simple;
	bh=dqo0LkKzNQcgJaOssBfuqioEqAFyLuBOYU/c6ewctMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgFWAAVWHC69TkcZtrkPQKG3QfPsKEP0fX29QG83wN5oxB58z3u/qvXLX6kmvOdaWNqXLK2WMf5/+aZoe40Rsesxbq8yQY7Sns/u/sbF035k/wdWyTbEnNe8nBpCjuY2O/eii/CbceUrVvFMa2/KXKb5pdOl7pzBx+UDTIIwiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGY9LtJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737634006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJZefteEnGy9E9wKair9Q+rBEB8q9z97j/hd4UdONsQ=;
	b=CGY9LtJS5CzypbyqRtIddedJf2JHroVT/NM0WJiQf+eLox3N5wsOeTaAp0TVAWmhrgLhi9
	Q4dM1brnZ+Bif5mCC5KSqrvHCyra4ANW1WrAOB8twNTdR+Wu+n4SfH7AAFRlcz/skyt6+E
	6i8k62rs7cw8cgDZ7ObCE6vybyh7/j8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-sBVxx_mcNRK9Y-AYPi1Clg-1; Thu, 23 Jan 2025 07:06:45 -0500
X-MC-Unique: sBVxx_mcNRK9Y-AYPi1Clg-1
X-Mimecast-MFC-AGG-ID: sBVxx_mcNRK9Y-AYPi1Clg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38bf4913659so639507f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 04:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737634004; x=1738238804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJZefteEnGy9E9wKair9Q+rBEB8q9z97j/hd4UdONsQ=;
        b=A1LAUPoSTsK1lI1X1Gapqb/hLSNh78L1bxW+Lsum0l6szUdqkcE8kOwsg+85Bi16AU
         j1qeUWESuxnLI1i1cVtedDbeIZbw7rBlukq3m1SdyPQGBdx75kxazJgwsKXs8L+ZwVnR
         0BHT0w1FNUDIIHrQd51Ev6ARWxS9Urt9F+/6+vvUTFzezGqpAekHD/c9nio1Uvx24loc
         Sn8BKAnCIopIE+wd/HoqDuKFNmowQOD5VxWAnR/NAO8m1DJWKTCjJ6eYFGygrdrtelkN
         +IFKwk3wAsifRZ4+syv02x8i30q/fmM/8vvbD4cgZ4pPCYtfyYDi1s4imygJyodTUEHI
         LuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfe9ig/739nMRGbIeoTlI3kVLkrFP+Yw2A/FEM82WlvFOSWsNTCOEJOEZgWFBGFftkxcF8Yvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBm2ccYBD0FoxJpnPFwu2UYkBaIdDFDcrg393el8giNoVr4YN
	APSGx5glRLqyQ9lM+yX4SfYoPlimvWZTodM3Ll63f5DupUY4b/UrUZjVZT+g/E7rKUr9RpdbMzy
	a3+g3kcWjXf8R4VQxGJfxCuLDKgY/mOEDITGtTaYGx6hJMP3z58mcCw==
X-Gm-Gg: ASbGnctDZIIbZNcQynUdMMkUss+SPwws/4ACsApkS3LOO4GMp2qyMOt6MJuicXlZb61
	Z+oU3ykOvk7zgAoZhV7fa0LW7IHncR8yMpDePA78TwLgCj92yxnQbIi6KNKB9kVsYpJy1bztv3Q
	cdmKCTJJtY2QX+CrBsGRhRskQVithAc1kgRm4ZgGNhE0TL9xdBl65g9d0E+d7SodYYXhwADhJLJ
	k41i9B/aKFnzy+ZHN9XCL3mP8kkowVTTqH0zlLdluY+fiKJYQHZmFAYzHqsJmcskF8+Y1Xm0oyx
	MmAHB2HFNFl5hAIYALL0AcRj
X-Received: by 2002:adf:a34e:0:b0:38b:669d:4dcf with SMTP id ffacd0b85a97d-38bf57945a7mr17847238f8f.27.1737634003564;
        Thu, 23 Jan 2025 04:06:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2qjCskhN0a1AUXNRU/6TLlmp0aa8wwlacIFpaDAbG3es41UrNgg2xMH9GvhEmqHpyS7g2+Q==
X-Received: by 2002:adf:a34e:0:b0:38b:669d:4dcf with SMTP id ffacd0b85a97d-38bf57945a7mr17847208f8f.27.1737634002975;
        Thu, 23 Jan 2025 04:06:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-27-215.dyn.eolo.it. [146.241.27.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221be1sm19276535f8f.31.2025.01.23.04.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 04:06:42 -0800 (PST)
Message-ID: <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com>
Date: Thu, 23 Jan 2025 13:06:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and
 homa_pool.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-5-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-5-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/25 7:59 PM, John Ousterhout wrote:
> These files implement Homa's mechanism for managing application-level
> buffer space for incoming messages This mechanism is needed to allow
> Homa to copy data out to user space in parallel with receiving packets;
> it was discussed in a talk at NetDev 0x17.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  net/homa/homa_pool.c | 453 +++++++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_pool.h | 154 +++++++++++++++
>  2 files changed, 607 insertions(+)
>  create mode 100644 net/homa/homa_pool.c
>  create mode 100644 net/homa/homa_pool.h
> 
> diff --git a/net/homa/homa_pool.c b/net/homa/homa_pool.c
> new file mode 100644
> index 000000000000..0b2ec83b6174
> --- /dev/null
> +++ b/net/homa/homa_pool.c
> @@ -0,0 +1,453 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +#include "homa_impl.h"
> +#include "homa_pool.h"
> +
> +/* This file contains functions that manage user-space buffer pools. */
> +
> +/* Pools must always have at least this many bpages (no particular
> + * reasoning behind this value).
> + */
> +#define MIN_POOL_SIZE 2
> +
> +/* Used when determining how many bpages to consider for allocation. */
> +#define MIN_EXTRA 4
> +
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
> +	pool->bpages_needed = (rpc->msgin.length + HOMA_BPAGE_SIZE - 1)
> +			>> HOMA_BPAGE_SHIFT;
> +}
> +
> +/**
> + * homa_pool_init() - Initialize a homa_pool; any previous contents are
> + * destroyed.
> + * @hsk:          Socket containing the pool to initialize.
> + * @region:       First byte of the memory region for the pool, allocated
> + *                by the application; must be page-aligned.
> + * @region_size:  Total number of bytes available at @buf_region.
> + * Return: Either zero (for success) or a negative errno for failure.
> + */
> +int homa_pool_init(struct homa_sock *hsk, void __user *region,
> +		   __u64 region_size)
> +{
> +	struct homa_pool *pool = hsk->buffer_pool;
> +	int i, result;
> +
> +	homa_pool_destroy(hsk->buffer_pool);
> +
> +	if (((uintptr_t)region) & ~PAGE_MASK)
> +		return -EINVAL;
> +	pool->hsk = hsk;
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
> +					  GFP_ATOMIC);

Possibly wort adding '| __GFP_ZERO' and avoid zeroing some fields later.

> +	if (!pool->descriptors) {
> +		result = -ENOMEM;
> +		goto error;
> +	}
> +	for (i = 0; i < pool->num_bpages; i++) {
> +		struct homa_bpage *bp = &pool->descriptors[i];
> +
> +		spin_lock_init(&bp->lock);
> +		atomic_set(&bp->refs, 0);
> +		bp->owner = -1;
> +		bp->expiration = 0;
> +	}
> +	atomic_set(&pool->free_bpages, pool->num_bpages);
> +	pool->bpages_needed = INT_MAX;
> +
> +	/* Allocate and initialize core-specific data. */
> +	pool->cores = kmalloc_array(nr_cpu_ids, sizeof(struct homa_pool_core),
> +				    GFP_ATOMIC);

Uhm... on large system this could be an order-3 allocation, which in
turn could fail quite easily under memory pressure, and it looks
contradictory with WRT the cover letter statement about reducing the
amount of per socket status.

Why don't you use alloc_percpu_gfp() here?


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
> +int homa_pool_get_pages(struct homa_pool *pool, int num_pages, __u32 *pages,
> +			int set_owner)
> +{
> +	int core_num = raw_smp_processor_id();

Why the 'raw' variant? If this code is pre-emptible it means another
process could be scheduled on the same core...


> +	struct homa_pool_core *core;
> +	__u64 now = sched_clock();
> +	int alloced = 0;
> +	int limit = 0;
> +
> +	core = &pool->cores[core_num];
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
> +		int cur, ref_count;
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
> +			extra = limit >> 2;
> +			limit += (extra < MIN_EXTRA) ? MIN_EXTRA : extra;
> +			if (limit > pool->num_bpages)
> +				limit = pool->num_bpages;
> +		}
> +
> +		cur = core->next_candidate;
> +		core->next_candidate++;

... here, making this increment racy.

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
> +		ref_count = atomic_read(&bpage->refs);
> +		if (ref_count >= 2 || (ref_count == 1 && (bpage->owner < 0 ||
> +				bpage->expiration > now)))

The above conditions could be place in separate helper, making the code
more easy to follow and avoiding some duplications.

> +			continue;
> +		if (!spin_trylock_bh(&bpage->lock))
> +			continue;
> +		ref_count = atomic_read(&bpage->refs);
> +		if (ref_count >= 2 || (ref_count == 1 && (bpage->owner < 0 ||
> +				bpage->expiration > now))) {
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
> +{
> +	struct homa_pool *pool = rpc->hsk->buffer_pool;
> +	int full_pages, partial, i, core_id;
> +	__u32 pages[HOMA_MAX_BPAGES];
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

full_pages must be less than HOMA_MAX_BPAGES, but I don't see any check
on incoming message length to be somewhat limited ?!?

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
> +	core_id = raw_smp_processor_id();
> +	core = &pool->cores[core_id];
> +	bpage = &pool->descriptors[core->page_hint];
> +	if (!spin_trylock_bh(&bpage->lock))
> +		spin_lock_bh(&bpage->lock);
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
> +	 */
> +out_of_space:
> +	homa_sock_lock(pool->hsk, "homa_pool_allocate");

There is some chicken-egg issue, with homa_sock_lock() being defined
only later in the series, but it looks like the string argument is never
used.

> +	list_for_each_entry(other, &pool->hsk->waiting_for_bufs, buf_links) {
> +		if (other->msgin.length > rpc->msgin.length) {
> +			list_add_tail(&rpc->buf_links, &other->buf_links);
> +			goto queued;
> +		}
> +	}
> +	list_add_tail_rcu(&rpc->buf_links, &pool->hsk->waiting_for_bufs);
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
> +			      __u32 *buffers)
> +{
> +	int result = 0;
> +	int i;
> +
> +	if (!pool->region)
> +		return result;
> +	for (i = 0; i < num_buffers; i++) {
> +		__u32 bpage_index = buffers[i] >> HOMA_BPAGE_SHIFT;
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
> +		homa_sock_lock(pool->hsk, "buffer pool");
> +		if (list_empty(&pool->hsk->waiting_for_bufs)) {
> +			pool->bpages_needed = INT_MAX;
> +			homa_sock_unlock(pool->hsk);
> +			break;
> +		}
> +		rpc = list_first_entry(&pool->hsk->waiting_for_bufs,
> +				       struct homa_rpc, buf_links);
> +		if (!homa_rpc_try_lock(rpc, "homa_pool_check_waiting")) {
> +			/* Can't just spin on the RPC lock because we're
> +			 * holding the socket lock (see sync.txt). Instead,

Stray reference to sync.txt. It would be nice to have the locking schema
described somewhere start to finish in this series.

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
> +		if (rpc->msgin.num_bpages > 0)
> +			/* Allocation succeeded; "wake up" the RPC. */
> +			rpc->msgin.resend_all = 1;
> +		homa_rpc_unlock(rpc);
> +	}
> +}
> diff --git a/net/homa/homa_pool.h b/net/homa/homa_pool.h
> new file mode 100644
> index 000000000000..6dbe7d77dd07
> --- /dev/null
> +++ b/net/homa/homa_pool.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +
> +/* This file contains definitions used to manage user-space buffer pools.
> + */
> +
> +#ifndef _HOMA_POOL_H
> +#define _HOMA_POOL_H
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
> +		struct {
> +			/** @lock: to synchronize shared access. */
> +			spinlock_t lock;
> +
> +			/**
> +			 * @refs: Counts number of distinct uses of this
> +			 * bpage (1 tick for each message that is using
> +			 * this page, plus an additional tick if the @owner
> +			 * field is set).
> +			 */
> +			atomic_t refs;
> +
> +			/**
> +			 * @owner: kernel core that currently owns this page
> +			 * (< 0 if none).
> +			 */
> +			int owner;
> +
> +			/**
> +			 * @expiration: time (in sched_clock() units) after
> +			 * which it's OK to steal this page from its current
> +			 * owner (if @refs is 1).
> +			 */
> +			__u64 expiration;
> +		};

____cacheline_aligned instead of inserting the struct into an union
should suffice.

/P


