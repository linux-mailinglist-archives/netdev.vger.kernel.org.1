Return-Path: <netdev+bounces-51022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583187F8A5B
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5186B21082
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80CADF56;
	Sat, 25 Nov 2023 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051C210E7
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 03:53:16 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Scqs03j6szsRNM;
	Sat, 25 Nov 2023 19:49:40 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 25 Nov
 2023 19:53:13 +0800
Subject: Re: [PATCH net-next v3 1/3] page_pool: Rename pp_frag_count to
 pp_ref_count
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
 <20231124073439.52626-2-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a45e4183-3ac3-2853-810a-63c7277d6318@huawei.com>
Date: Sat, 25 Nov 2023 19:53:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231124073439.52626-2-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/24 15:34, Liang Chen wrote:

>  static inline void page_pool_fragment_page(struct page *page, long nr)

It seems page_pool_fragment_page() might not be a appropriate name too?

Perhaps it might be better to grep defrag/frag to see if there is other
function name might need changing.

>  {
> -	atomic_long_set(&page->pp_frag_count, nr);
> +	atomic_long_set(&page->pp_ref_count, nr);
>  }
>  
> -static inline long page_pool_defrag_page(struct page *page, long nr)
> +static inline long page_pool_deref_page(struct page *page, long nr)

page_pool_defrag_page() related function is called by mlx5 driver directly,
we need to change it to use the new function too.

I assume that deref is short for dereference? According to:

https://stackoverflow.com/questions/4955198/what-does-dereferencing-a-pointer-mean-in-c-c

'dereferencing means accessing the value from a certain memory location
against which that pointer is pointing'.

So I am not sure if 'deref' is the right word here as I am not a native
english speaker, But it seems 'unref' is more appropriate here if we mirror
the napi_frag_unref() function name?

