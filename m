Return-Path: <netdev+bounces-55826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65E080C61C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE91F202CD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969C22321;
	Mon, 11 Dec 2023 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntcoumax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B511715
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E2DC433C7;
	Mon, 11 Dec 2023 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702289527;
	bh=7ZXmd5rh4Rqq/IAxc7eaZo+Bf3FwdWSw0W4uYwdYPqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ntcoumaxavZrdA6pD8HO9I8uUIV8ziJTPWMNGRdwJjYSchwfy9H3CNL2ebURgN+3B
	 R0hm53oQ01uvFLYMR8UUxe2p+tdRc8kFvfQn2MM8crnkyHeMKJuQo2gzWiw7BM3jck
	 ke2parp67vwgAdLXklisge+oUonDNQJ05JtAxeK3rbrrxRl835/3eDCCgvtrQpN1dN
	 Sezx3LN/WrHm1hyH8h1plqEnMHvQisygz1TIktV2Qg3mfo2QjRAW0E2rcIVy6x7E82
	 iOfm6FluXlUeI/74HWL+xiFzLO1XRUKn/fYxJUJ5oOerHDynszMbzXxOwebxcHLGl1
	 XSMI0dwCT41+Q==
Message-ID: <6f7f7724-12a0-45d5-80dc-a811b58783c8@kernel.org>
Date: Mon, 11 Dec 2023 11:12:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/4] page_pool: halve BIAS_MAX for multiple
 user references of a fragment
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, kuba@kernel.org,
 ilias.apalodimas@linaro.org, jasowang@redhat.com, linyunsheng@huawei.com,
 Liang Chen <liangchen.linux@gmail.com>, edumazet@google.com,
 davem@davemloft.net, almasrymina@google.com, pabeni@redhat.com
References: <20231211035243.15774-1-liangchen.linux@gmail.com>
 <20231211035243.15774-3-liangchen.linux@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231211035243.15774-3-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

For page_pool BIAS stuff I would really appreciate your review please.
-Jesper


On 11/12/2023 04.52, Liang Chen wrote:
> Referring to patch [1], in order to support multiple users referencing the
> same fragment and prevent overflow from pp_ref_count growing, the initial
> value of pp_ref_count is halved, leaving room for pp_ref_count to increment
> before the page is drained.
> 
> [1]
> https://lore.kernel.org/all/20211009093724.10539-3-linyunsheng@huawei.com/
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   net/core/page_pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 106220b1f89c..436f7ffea7b4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -26,7 +26,7 @@
>   #define DEFER_TIME (msecs_to_jiffies(1000))
>   #define DEFER_WARN_INTERVAL (60 * HZ)
>   
> -#define BIAS_MAX	LONG_MAX
> +#define BIAS_MAX	(LONG_MAX >> 1)
>   
>   #ifdef CONFIG_PAGE_POOL_STATS
>   /* alloc_stat_inc is intended to be used in softirq context */

