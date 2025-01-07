Return-Path: <netdev+bounces-155817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB20A03E7C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DCB1884DF3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFA1E1A2D;
	Tue,  7 Jan 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7zn1jQP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098615854F;
	Tue,  7 Jan 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251429; cv=none; b=d2Q8bdf96IdSudRwd2Ke6oFeMappDtkRi01fjtdbhIB19lHrKBWUE/v7uRfEqUrNo3aLNxJp519i372pFx4DtCsXkPMCfcgYcdWNWJzaBxhw+q4SkWytOuSESpInVNXBdATj0QLNyfmuU8JEStQT0mEu/SKOZyJdpuK+ZM/NFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251429; c=relaxed/simple;
	bh=J0eCPKTYP1y5DsT6EQzv1gmap3gZVwEIFCm4OkLU5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4kwb7WXyYTJYeCKEBhJNmfFhMpjSVfUDDvtF3+RpHgpWPD8jay5UxrCuLpT8JICak5Y2urV2qHbZ+cKrScuvYhvlZFUQSp3Xx8VKsDRK3Ja4McWo1rYBTOoXaMc3zxbY7Npe2YsGk9Sb/QAG6JUbUFUSlzcoEWifQZKsGFPa7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7zn1jQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B37AC4CED6;
	Tue,  7 Jan 2025 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251429;
	bh=J0eCPKTYP1y5DsT6EQzv1gmap3gZVwEIFCm4OkLU5n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7zn1jQP5nv0x5Y1t054JWveffwiorng//typn5zofQeWlNY1e+icBkibSyql2F/3
	 QrhcAjZeAgzl069wIWVkFNMDyadmskdzHnXRu8Bfhqpws2e7RP/OPQ7bj4JxoMVoEY
	 eCcKxc/PPpSXboMKWhbJ8iJjb4Yr/1vLQ584xFXsurFZLt3fue4sWZY94+BM62AuB4
	 6vgPFlnngXnK2QieJfXh/icyt/ZJaIHsaO30fO5oi9XZTsxV03Qv/4dbK+w6oJSYbk
	 ebeZVC3yntBPRN1gtPvHE+vGPDZfDq7um0agMzt8nHi6YbRKPj3Qt/fJZ9l2Tv/lGs
	 SX8zN7hkqL+ig==
Date: Tue, 7 Jan 2025 12:03:44 +0000
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	liuyonglong@huawei.com, fanghaiqing@huawei.com,
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 8/8] page_pool: use list instead of array for
 alloc cache
Message-ID: <20250107120344.GI33144@kernel.org>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
 <20250106130116.457938-9-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106130116.457938-9-linyunsheng@huawei.com>

On Mon, Jan 06, 2025 at 09:01:16PM +0800, Yunsheng Lin wrote:
> As the alloc cache is always protected by NAPI context
> protection, use encoded_next as a pointer to a next item
> to avoid the using the array.
> 
> Testing shows there is about 3ns improvement for the
> performance of 'time_bench_page_pool01_fast_path' test
> case.
> 
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: IOMMU <iommu@lists.linux.dev>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

...

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c

...

> @@ -677,10 +698,12 @@ static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
>  
>  static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>  {
> -	struct page_pool_item *refill;
> +	struct page_pool_item *refill, *alloc, *curr;
>  	netmem_ref netmem;
>  	int pref_nid; /* preferred NUMA node */
>  
> +	DEBUG_NET_WARN_ON_ONCE(pool->alloc.count || pool->alloc.list);
> +
>  	/* Quicker fallback, avoid locks when ring is empty */
>  	refill = pool->alloc.refill;
>  	if (unlikely(!refill && !READ_ONCE(pool->ring.list))) {
> @@ -698,6 +721,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>  	pref_nid = numa_mem_id(); /* will be zero like page_to_nid() */
>  #endif
>  
> +	alloc = NULL;
>  	/* Refill alloc array, but only if NUMA match */
>  	do {
>  		if (unlikely(!refill)) {
> @@ -706,10 +730,13 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>  				break;
>  		}
>  
> +		curr = refill;
>  		netmem = refill->pp_netmem;
>  		refill = page_pool_item_get_next(refill);
>  		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
> -			pool->alloc.cache[pool->alloc.count++] = netmem;
> +			page_pool_item_set_next(curr, alloc);
> +			pool->alloc.count++;
> +			alloc = curr;
>  		} else {
>  			/* NUMA mismatch;
>  			 * (1) release 1 page to page-allocator and
> @@ -729,7 +756,8 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>  	/* Return last page */
>  	if (likely(pool->alloc.count > 0)) {
>  		atomic_sub(pool->alloc.count, &pool->ring.count);
> -		netmem = pool->alloc.cache[--pool->alloc.count];
> +		pool->alloc.list = page_pool_item_get_next(alloc);
> +		pool->alloc.count--;
>  		alloc_stat_inc(pool, refill);
>  	}
>  

Hi Yunsheng Lin,

The following line of the code looks like this:

	return netmem;

And, with this patch applied, Smatch warns that netmem may be used
uninitialised here. I assume this is because it is no longer conditionally
initialised above.

...

