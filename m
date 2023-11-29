Return-Path: <netdev+bounces-51990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C417FCDAC
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704DBB20E76
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211E613C;
	Wed, 29 Nov 2023 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14EA12C
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:56:42 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sg53n5Ll5zMnQP;
	Wed, 29 Nov 2023 11:51:49 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 11:56:40 +0800
Subject: Re: [PATCH net-next v4 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
 <20231129031201.32014-5-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <664e753b-23ba-56b7-a2b7-a2bd83260887@huawei.com>
Date: Wed, 29 Nov 2023 11:56:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231129031201.32014-5-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/29 11:12, Liang Chen wrote:
>  
> +/**
> + * skb_pp_get_frag_ref() - Increase fragment reference count of a page
> + * @page:	page of the fragment on which to increase a reference
> + *
> + * Increase fragment reference count (pp_ref_count) on a page, but if it is
> + * not a page pool page, fallback to increase a reference(_refcount) on a
> + * normal page.
> + */
> +static inline void skb_pp_get_frag_ref(struct page *page)

Simiar comment for 'inline ' too.

Also, Is skb_pp_frag_ref() a better name than skb_pp_get_frag_ref()
mirroring skb_frag_ref()?

> +{
> +	struct page *head_page = compound_head(page);
> +
> +	if (likely(skb_frag_is_pp_page(head_page)))
> +		atomic_long_inc(&head_page->pp_ref_count);

As pp_ref_count is supposed to be a internal field to page_pool,
I am not sure if it matters that much to manipulate pp_ref_count
directly in skbuff core.

Maybe we can provide a helper for that if it really matter in the
future.


> +	else
> +		get_page(head_page);

I suppose we can use page_ref_inc() as we have a compound_head()
calling in the above.

Other than the above nits, LGTM.

Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

