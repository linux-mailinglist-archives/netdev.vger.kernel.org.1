Return-Path: <netdev+bounces-24933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5E7722EC
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA62812D9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266EFC04;
	Mon,  7 Aug 2023 11:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE3FC00
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C6CC433C8;
	Mon,  7 Aug 2023 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691408567;
	bh=AfHKCCHhZb1Ttd6acKsJQdvcdE/x8UDfAqDOzRfAG7Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FlVQBjAA6IBjRu7Hd9XDv8AtdNq7nhOFQOYwdFUwEzx8xOzybee5SBoDRv2yD1OLz
	 YD2OaDdjXMq3WuMs+f2lbbKXEHJX8/FgDRNJ1UvEVQ2sYWbNbE+mlNNN7hbbL7Em/X
	 5/LI16sulGsPhyVJ5x+3i8O1B2kIiU8INQXWoSp80GUXVy86M7CkkB2SkWubldDjk6
	 rkLW9arD+QYHawH0hr35boGxmGNPvUnhvJGkF0qGB5sFoPr6gzoawSY/bbS50EHVOK
	 WnK6piLZjmdOk9NMTy4J4un5olcx0mXE5JjufR+l6r9BOCYvCx6TV0WcPVUbGTgh1b
	 N2BYLi92B0rcg==
Message-ID: <b8eb926e-cfc9-b082-5bb9-719be3937c5d@kernel.org>
Date: Mon, 7 Aug 2023 13:42:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next] page_pool: Clamp ring size to 32K
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230807034932.4000598-1-rkannoth@marvell.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230807034932.4000598-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/08/2023 05.49, Ratheesh Kannoth wrote:
> https://lore.kernel.org/netdev/20230804133512.4dbbbc16@kernel.org/T/
> Capping the recycle ring to 32k instead of returning the error.
> 

Page pool (PP) is just a cache of pages.  The driver octeontx2 (in link)
is creating an excessive large cache of pages.  The drivers RX
descriptor ring size should be independent of the PP ptr_ring size, as
it is just a cache that grows as a functions of the in-flight packet
workload, it functions as a "shock absorber".

32768 pages (4KiB) is approx 128 MiB, and this will be per RX-queue.

The RX-desc ring (obviously) pins down these pages (immediately), but PP
ring starts empty.  As the workload varies the "shock absorber" effect
will let more pages into the system, that will travel the PP ptr_ring.
As all pages originating from the same PP instance will get recycled,
the in-flight pages in the "system" (PP ptr_ring) will grow over time.

The PP design have the problem that it never releases or reduces pages
in this shock absorber "closed" system. (Cc. PP people/devel) we should
consider implementing a MM shrinker callback (include/linux/shrinker.h).

Are the systems using driver octeontx2 ready to handle 128MiB memory per
RX-queue getting pinned down overtime? (this could lead to some strange
do debug situation if the memory is not sufficient)

--Jesper

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>   net/core/page_pool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 5d615a169718..404f835a94be 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -182,9 +182,9 @@ static int page_pool_init(struct page_pool *pool,
>   	if (pool->p.pool_size)
>   		ring_qsize = pool->p.pool_size;
>   
> -	/* Sanity limit mem that can be pinned down */
> +	/* Clamp to 32K */
>   	if (ring_qsize > 32768)
> -		return -E2BIG;
> +		ring_qsize = 32768;
>   
>   	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
>   	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,

