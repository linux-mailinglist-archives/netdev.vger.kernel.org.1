Return-Path: <netdev+bounces-14503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E27420AC
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 08:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A18280D5D
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73715384;
	Thu, 29 Jun 2023 06:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFE46A5
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:53:24 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECA2187
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:53:20 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qs8KT0y1Sz1HC1Y;
	Thu, 29 Jun 2023 14:53:01 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 14:53:18 +0800
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool
 case
To: Liang Chen <liangchen.linux@gmail.com>, <ilias.apalodimas@linaro.org>,
	<hawk@kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5b81338a-f784-d73e-170c-d12af38692cb@huawei.com>
Date: Thu, 29 Jun 2023 14:53:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230628121150.47778-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/6/28 20:11, Liang Chen wrote:
> In order to address the issues encountered with commit 1effe8ca4e34
> ("skbuff: fix coalescing for page_pool fragment recycling"), the
> combination of the following condition was excluded from skb coalescing:
> 
> from->pp_recycle = 1
> from->cloned = 1
> to->pp_recycle = 1
> 
> However, with page pool environments, the aforementioned combination can
> be quite common. In scenarios with a higher number of small packets, it
> can significantly affect the success rate of coalescing. For example,
> when considering packets of 256 bytes size, our comparison of coalescing
> success rate is as follows:

As skb_try_coalesce() only allow coaleascing when 'to' skb is not cloned.

Could you give more detailed about the testing when we have a non-cloned
'to' skb and a cloned 'from' skb? As both of them should be belong to the
same flow.

I had the below patchset trying to do something similar as this patch does:
https://lore.kernel.org/all/20211009093724.10539-5-linyunsheng@huawei.com/

It seems this patch is only trying to optimize a specific case for skb
coalescing, So if skb coalescing between non-cloned and cloned skb is a
common case, then it might worth optimizing.


> 
> Without page pool: 70%
> With page pool: 13%
> 

...

> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 126f9e294389..05e5d8ead63b 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -399,4 +399,25 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
>  		page_pool_update_nid(pool, new_nid);
>  }
>  
> +static inline bool page_pool_is_pp_page(struct page *page)
> +{
> +	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
> +}
> +
> +static inline bool page_pool_is_pp_page_frag(struct page *page)> +{
> +	return !!(page->pp->p.flags & PP_FLAG_PAGE_FRAG);
> +}
> +
> +static inline void page_pool_page_ref(struct page *page)
> +{
> +	struct page *head_page = compound_head(page);

It seems we could avoid adding head_page here:
page = compound_head(page);

> +
> +	if (page_pool_is_pp_page(head_page) &&
> +			page_pool_is_pp_page_frag(head_page))
> +		atomic_long_inc(&head_page->pp_frag_count);
> +	else
> +		get_page(head_page);

page_ref_inc() should be enough here instead of get_page()
as compound_head() have been called.

> +}
> +
>  #endif /* _NET_PAGE_POOL_H */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6c5915efbc17..9806b091f0f6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5666,8 +5666,7 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  	 * !@to->pp_recycle but its tricky (due to potential race with
>  	 * the clone disappearing) and rare, so not worth dealing with.
>  	 */
> -	if (to->pp_recycle != from->pp_recycle ||
> -	    (from->pp_recycle && skb_cloned(from)))
> +	if (to->pp_recycle != from->pp_recycle)
>  		return false;
>  
>  	if (len <= skb_tailroom(to)) {
> @@ -5724,8 +5723,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  	/* if the skb is not cloned this does nothing
>  	 * since we set nr_frags to 0.
>  	 */
> -	for (i = 0; i < from_shinfo->nr_frags; i++)
> -		__skb_frag_ref(&from_shinfo->frags[i]);
> +	if (from->pp_recycle)
> +		for (i = 0; i < from_shinfo->nr_frags; i++)
> +			page_pool_page_ref(skb_frag_page(&from_shinfo->frags[i]));
> +	else
> +		for (i = 0; i < from_shinfo->nr_frags; i++)
> +			__skb_frag_ref(&from_shinfo->frags[i]);
>  
>  	to->truesize += delta;
>  	to->len += len;
> 

