Return-Path: <netdev+bounces-51988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72127FCD8D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B922D28324A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E45689;
	Wed, 29 Nov 2023 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C9B170B
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:40:54 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sg4pX5BXSzvRBc;
	Wed, 29 Nov 2023 11:40:20 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 11:40:51 +0800
Subject: Re: [PATCH net-next v4 3/4] skbuff: Add a function to check if a page
 belongs to page_pool
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
 <20231129031201.32014-4-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <844dc02a-3559-5a53-943d-28f772670879@huawei.com>
Date: Wed, 29 Nov 2023 11:40:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231129031201.32014-4-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/29 11:12, Liang Chen wrote:
> Wrap code for checking if a page is a page_pool page into a
> function for better readability and ease of reuse.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  net/core/skbuff.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b157efea5dea..310207389f51 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>  		skb_get(list);
>  }
>  
> +static inline bool skb_frag_is_pp_page(struct page *page)

I am not sure about the 'skb_frag' part, But I am not able to come
up with a better name too:)

Also, Generally, 'inline' is not really encouraged in c file in
the networking unless there is a clear justification as the compiler
can make better decision about whether inlining most of the time.

Other than the 'inlining' part, LGTM.
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

> +{
> +	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
> +}
> +
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
>  bool napi_pp_put_page(struct page *page, bool napi_safe)
>  {
> @@ -905,7 +910,7 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
>  	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
>  	 * to avoid recycling the pfmemalloc page.
>  	 */
> -	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
> +	if (unlikely(!skb_frag_is_pp_page(page)))
>  		return false;
>  
>  	pp = page->pp;
> 

