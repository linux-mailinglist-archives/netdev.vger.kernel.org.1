Return-Path: <netdev+bounces-143691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD59C3A5B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E0282429
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C3145B10;
	Mon, 11 Nov 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PhSJJCFT"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E561FE9
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315676; cv=none; b=JJioZSr7LMVQnKCwN2O4doZVLevWrs8OyljKxwDYq1HoKwkvGSF8o8OgQ7vRXSD0m30+cw498aR3kzos/99kH2JG6+M8Ge5AUgmfkwemHx6gEBBdveU1DzQ3h+uIpLL27wcor5V++lrfsq9kKwiTNSd9375w1KG8QLYRQZyS4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315676; c=relaxed/simple;
	bh=cTFXAUwuh/VhzaRwiNDdzZ808AYo7IovtEWOjxk5WX8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jDTSrQ4EidqVX8UUf9FqIwHNlbS07U5OURPgLW00YYYLem51HRExjqF2XqPg8xkWTYbMucBGOJPMYgrfhSpFvI1/2QmN+YYw9oH8HR112iC/qpbhZYxJftW+pxf3lY7rzTK22nN4OiGIvvUzlEwQtto7Uhu6bCgQh3oKbNNOs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PhSJJCFT; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731315671; h=Message-ID:Subject:Date:From:To;
	bh=Eryedkw6hcOjMMlOLczVFWBrRC0yJcV2/lfhMT2r1Jw=;
	b=PhSJJCFTax2XuvxVB0+MmUnx8oAwA9wdtXNEr6J+buBYPvZYuCY8zX/nXMF7BZz8/0yJ8+KCRn6wXljpQMG5KYYYTUDEduYYkxd1+gKmAxsS2ur+rcuFRAw1xkeXTSitJ3iAp8TWEJgRUpNq8L21T+UoZZmt5H3MIxOsvz6Hc6U=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJ8SXHj_1731315670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 17:01:10 +0800
Message-ID: <1731315660.5605164-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] net: page_pool: do not count normal frag allocation in stats
Date: Mon, 11 Nov 2024 17:01:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 edumazet@google.com,
 pabeni@redhat.com,
 Jakub Kicinski <kuba@kernel.org>,
 hawk@kernel.org,
 ilias.apalodimas@linaro.org,
 lorenzo@kernel.org,
 wangjie125@huawei.com,
 huangguangbin2@huawei.com,
 davem@davemloft.net
References: <20241109023303.3366500-1-kuba@kernel.org>
In-Reply-To: <20241109023303.3366500-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri,  8 Nov 2024 18:33:03 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
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
>   $ ./page-pool
>     eth0[2]	page pools: 32 (zombies: 0)
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


Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: lorenzo@kernel.org
> CC: wangjie125@huawei.com
> CC: huangguangbin2@huawei.com
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a813d30d2135..f89cf93f6eb4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -950,6 +950,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
>  	if (netmem && *offset + size > max_size) {
>  		netmem = page_pool_drain_frag(pool, netmem);
>  		if (netmem) {
> +			recycle_stat_inc(pool, cached);
>  			alloc_stat_inc(pool, fast);
>  			goto frag_reset;
>  		}
> @@ -974,7 +975,6 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
>
>  	pool->frag_users++;
>  	pool->frag_offset = *offset + size;
> -	alloc_stat_inc(pool, fast);
>  	return netmem;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_frag_netmem);
> --
> 2.47.0
>
>

