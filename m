Return-Path: <netdev+bounces-50162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFED97F4BEF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05861C20863
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165BC2137E;
	Wed, 22 Nov 2023 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP0BPYIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B01CA8A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BD7C433C9;
	Wed, 22 Nov 2023 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700669202;
	bh=S2czQIoStot5EtSbbcNp4gj2Bz7Bi+9Yrgmw5vN4QYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EP0BPYIaG5Nk/F46CWVJw21Cc5IhIfpTW0cbNP26n7+dl59Xbb7RTnosc5c+3OzMs
	 +ySwOdmSZ6PHNra5k6gk8yXwCyHd7Gppk0qzdssvrH/lZ6irnOb0lBSiolu246x/IJ
	 CoSdLVROPbjWRQBSkVccT1ZdOnolblek8ju7gAeOSCUNPsoE1fbJPnD3xNycHlhgDy
	 knNwXHGuP5TxiuGGZO8ES8XXHIrA0Hn6kcYMSdOCMf7ZatquLDeX6QzT5HmIajlWLc
	 CFHzEnMXMwvNnxbqwSBqcj+TVuPAEwDog72pEbtlU8SQ+q6neThJHBjA4mpZxdUkwO
	 AiEe1z1vYQDSQ==
Message-ID: <a957c4ea-22eb-4180-8a48-08fb699ad74e@kernel.org>
Date: Wed, 22 Nov 2023 17:06:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/13] net: page_pool: mute the periodic
 warning for visible page pools
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-13-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-13-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Mute the periodic "stalled pool shutdown" warning if the page pool
> is visible to user space. Rolling out a driver using page pools
> to just a few hundred hosts at Meta surfaces applications which
> fail to reap their broken sockets. Obviously it's best if the
> applications are fixed, but we don't generally print warnings
> for application resource leaks. Admins can now depend on the
> netlink interface for getting page pool info to detect buggy
> apps.
> 

Looking at the production logs I can unfortunately see many occurrences
of these "page_pool_release_retry() stalled pool shutdown" warnings.

Digging into this it is likely a driver (bnxt_en) issue on these older
kernels. I'll check if there is a upstream fix.

My experience from the past is that this warning have helped catch
driver related bugs.
With SKB + sockets then it is obviously a lot easier to trigger this
warning, which is why it makes sense to "mute" this.


> While at it throw in the ID of the pool into the message,
> in rare cases (pools from destroyed netns) this will make
> finding the pool with a debugger easier.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/core/page_pool.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 3d0938a60646..c2e7c9a6efbe 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -897,18 +897,21 @@ static void page_pool_release_retry(struct work_struct *wq)
>   {
>   	struct delayed_work *dwq = to_delayed_work(wq);
>   	struct page_pool *pool = container_of(dwq, typeof(*pool), release_dw);
> +	void *netdev;
>   	int inflight;
>   
>   	inflight = page_pool_release(pool);
>   	if (!inflight)
>   		return;
>   
> -	/* Periodic warning */
> -	if (time_after_eq(jiffies, pool->defer_warn)) {
> +	/* Periodic warning for page pools the user can't see */
> +	netdev = READ_ONCE(pool->slow.netdev);
> +	if (time_after_eq(jiffies, pool->defer_warn) &&
> +	    (!netdev || netdev == NET_PTR_POISON)) {
>   		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
>   
> -		pr_warn("%s() stalled pool shutdown %d inflight %d sec\n",
> -			__func__, inflight, sec);
> +		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
> +			__func__, pool->user.id, inflight, sec);
>   		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
>   	}
>   

