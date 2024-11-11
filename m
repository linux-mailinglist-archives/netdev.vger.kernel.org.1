Return-Path: <netdev+bounces-143685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE29C39FB
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02761C2161F
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFBA16DED5;
	Mon, 11 Nov 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxdYFOHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0A158520
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314837; cv=none; b=jsa0EoCJShApfGnCEfHubsCjb9A2nIvMVZ8otgmiEfGOyHgJ85iykW63hZy66+gySkvVoWmbCVPU0NZLVhI911vnuBlnJ8Z49WmRdnedTwTBWXT2SWner0YClrfOtXv6nnn94adHVtPORKw5ZBu/T7eiyboMOLN8GAhdm3FwuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314837; c=relaxed/simple;
	bh=xBSb+ugyYkiXUPsi0ACKcOJIVBHx3xuhzFECR3CzcSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5aIhSF1ruGEPqfSKIh2kC1pJjKttEecNFir7koc5SLiASbEjmxeAa1XPZu4SQwBoCBJblfWVxWFyLftIJfdkeK43z6OEZsV9BYioyU4AnWsSVuyndDn9VNRuRIBegj3SwW/WRCvApF9bkDk65qRHPLl/1cf/rWSaLnOk91wAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxdYFOHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C775C4CED4;
	Mon, 11 Nov 2024 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731314837;
	bh=xBSb+ugyYkiXUPsi0ACKcOJIVBHx3xuhzFECR3CzcSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxdYFOHsy4d8LpFH62evEzQJx4nhVijH8XwFiZIV7auSgZyGrqjQB35xIg1bItLWv
	 iz3UHWxbQRYxPVxLEMZgJnQ1a1jb3x/TMWIe4LongEoPDDHyHNAgjCKmJVPXwOzK/S
	 Yb7BX2GWJHYJj4DaYJABQMVH+5cCZebCaSlHFN5e/k6rngpPReezvXhSxzf5DwR3Ak
	 3oSnlnSFeXWI1dZViit4ZPWxzArqmv+CG3XUhXoRRDvWf4TnG9ASqbF98gFSlzi5Ny
	 WF7ehWJyDo+iQ30MHDIqwVXD1Wx7WJckyTX/5xiTjDQfrWv7B/b1HmZPP773zFxc0e
	 Y9ZvJ6L273n8w==
Message-ID: <9dd34b90-87e5-4044-8b5b-d019741f0796@kernel.org>
Date: Mon, 11 Nov 2024 09:47:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: do not count normal frag
 allocation in stats
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 ilias.apalodimas@linaro.org, lorenzo@kernel.org, wangjie125@huawei.com,
 huangguangbin2@huawei.com
References: <20241109023303.3366500-1-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20241109023303.3366500-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/11/2024 03.33, Jakub Kicinski wrote:
> Commit 0f6deac3a079 ("net: page_pool: add page allocation stats for
> two fast page allocate path") added increments for "fast path"
> allocation to page frag alloc. It mentions performance degradation
> analysis but the details are unclear. Could be that the author
> was simply surprised by the alloc stats not matching packet count.
> 
> In my experience the key metric for page pool is the recycling rate.
> Page return stats, however, count returned _pages_ not frags.
> This makes it impossible to calculate recycling rate for drivers
> using the frag API. Here is example output of the page-pool
> YNL sample for a driver allocating 1200B frags (4k pages)
> with nearly perfect recycling:
> 
>    $ ./page-pool
>      eth0[2]	page pools: 32 (zombies: 0)
> 		refs: 291648 bytes: 1194590208 (refs: 0 bytes: 0)
> 		recycling: 33.3% (alloc: 4557:2256365862 recycle: 200476245:551541893)
> 
> The recycling rate is reported as 33.3% because we give out
> 4096 // 1200 = 3 frags for every recycled page.
> 
> Effectively revert the aforementioned commit. This also aligns
> with the stats we would see for drivers which do the fragmentation
> themselves, although that's not a strong reason in itself.
> 
> On the (very unlikely) path where we can reuse the current page
> let's bump the "cached" stat. The fact that we don't put the page
> in the cache is just an optimization.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: lorenzo@kernel.org
> CC: wangjie125@huawei.com
> CC: huangguangbin2@huawei.com
> ---
>   net/core/page_pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a813d30d2135..f89cf93f6eb4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -950,6 +950,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
>   	if (netmem && *offset + size > max_size) {
>   		netmem = page_pool_drain_frag(pool, netmem);
>   		if (netmem) {
> +			recycle_stat_inc(pool, cached);
>   			alloc_stat_inc(pool, fast);
>   			goto frag_reset;
>   		}
> @@ -974,7 +975,6 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
>   
>   	pool->frag_users++;
>   	pool->frag_offset = *offset + size;
> -	alloc_stat_inc(pool, fast);
>   	return netmem;
>   }
>   EXPORT_SYMBOL(page_pool_alloc_frag_netmem);

