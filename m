Return-Path: <netdev+bounces-137965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBB9AB43C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9356F281758
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF11BBBF7;
	Tue, 22 Oct 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qya/+fTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D581474C9;
	Tue, 22 Oct 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615220; cv=none; b=tl0vTYit0NabNu1Qg3ecmn/o1rad9QNKJj1C2BED9I3R/HX/Uf3bdqNp1KSjzAYshywl9Wi7wGRZPW908ipbrYwga/ObXYerrkj7eEsrksoeKvVj6xxok3VSs16Y1TuiTKSh9AfBbIgSDEglCZhJaLO1lebDlDGyvLahTGYGwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615220; c=relaxed/simple;
	bh=dzLcXD+156SYMA3WB6A3WMf+G11daZvhn9a/x7sleuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVbY4E1yTwea59b9omFgi52q29gO23SoxzQn86uVhh4HmE6783Tmj5+O8xj0qgvdt8baJwxNLROImSV/MhpfukWGSYlUjviEC5N/13ZRqX3RRZKS0Bq2hUt5RnqmLrOkc68oSGFvqg/fwNrfoEAMABkNnpUFnsmVyiX5tvD5n0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qya/+fTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4339C4CEE3;
	Tue, 22 Oct 2024 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615218;
	bh=dzLcXD+156SYMA3WB6A3WMf+G11daZvhn9a/x7sleuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qya/+fTRh7iRS0fsWNpvNM4fOZ9LEm97jSTasjbGio+K0xA9SHfTW2zGT+kMVIzUP
	 BdfIwCsJL54BhfdrJRzgB4j8pS1X/n/5alm850QyNO4HeMAhgJqSRcWqU0tkUQugzq
	 Clse6h50LyituelUmqyAjyyv5yIkPpegtIyXxd1piO1Ly3v2le//1T3MLllSir4d4n
	 /Wp3smiVKNdUUKIvjKz0q90TmEzjAoqa14PtnXHuBDb/FgO3Aoe4rRaqfQ4XCFwCrC
	 GLqERWKqEkTFNd6/39D57n2/i0Ow7P3LP4T+trFPvP7oYRLMt7XttHI15VYz3gN2F6
	 wN3bx7QpOcJtA==
Date: Tue, 22 Oct 2024 17:40:13 +0100
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, fanghaiqing@huawei.com,
	liuyonglong@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
Message-ID: <20241022164013.GI402847@kernel.org>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022032214.3915232-4-linyunsheng@huawei.com>

On Tue, Oct 22, 2024 at 11:22:13AM +0800, Yunsheng Lin wrote:
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
> 
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
> 
> Currently it seems there are at least two cases that the page
> is not released fast enough causing dma unmmapping done after
> driver has already unbound:
> 1. ipv4 packet defragmentation timeout: this seems to cause
>    delay up to 30 secs.
> 2. skb_defer_free_flush(): this may cause infinite delay if
>    there is no triggering for net_rx_action().
> 
> In order not to do the dma unmmapping after driver has already
> unbound and stall the unloading of the networking driver, add
> the pool->items array to record all the pages including the ones
> which are handed over to network stack, so the page_pool can
> do the dma unmmapping for those pages when page_pool_destroy()
> is called. As the pool->items need to be large enough to avoid
> performance degradation, add a 'item_full' stat to indicate the
> allocation failure due to unavailability of pool->items.
> 
> Note, the devmem patchset seems to make the bug harder to fix,
> and may make backporting harder too. As there is no actual user
> for the devmem and the fixing for devmem is unclear for now,
> this patch does not consider fixing the case for devmem yet.
> 
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> 
> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: IOMMU <iommu@lists.linux.dev>

...

> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index c022c410abe3..194006d2930f 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -102,6 +102,7 @@ struct page_pool_params {
>   * @refill:	an allocation which triggered a refill of the cache
>   * @waive:	pages obtained from the ptr ring that cannot be added to
>   *		the cache due to a NUMA mismatch
> + * @item_full	items array is full

No need to block progress because of this, but the correct syntax is:

  * @item_full: ...

Flagged by ./scripts/kernel-doc -none

...

