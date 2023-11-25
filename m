Return-Path: <netdev+bounces-51024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9C7F8AA5
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 13:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E731C20BD1
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD473F9EF;
	Sat, 25 Nov 2023 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8395ED6
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 04:16:32 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ScrM10vbCzSgwg;
	Sat, 25 Nov 2023 20:12:13 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 25 Nov
 2023 20:16:29 +0800
Subject: Re: [PATCH net-next v3 3/3] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
 <20231124073439.52626-4-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d26decd3-7235-c4ce-f083-16a52d15ff1c@huawei.com>
Date: Sat, 25 Nov 2023 20:16:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231124073439.52626-4-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/24 15:34, Liang Chen wrote:

...

> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -402,4 +402,26 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
>  		page_pool_update_nid(pool, new_nid);
>  }
>
> +static inline bool page_pool_is_pp_page(struct page *page)
> +{

We have a page->pp_magic checking in napi_pp_put_page() in skbuff.c already,
it seems better to move it to skbuff.c or skbuff.h and use it for
napi_pp_put_page() too, as we seem to have chosen to demux the page_pool
owned page and non-page_pool owned page handling in the skbuff core.

If we move it to skbuff.c or skbuff.h, we might need a better prefix than
page_pool_* too.


