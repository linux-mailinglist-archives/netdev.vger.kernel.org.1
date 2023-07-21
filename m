Return-Path: <netdev+bounces-19806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B81A75C61B
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C93D1C21644
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A71DDDA;
	Fri, 21 Jul 2023 11:53:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5917758
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:53:34 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE162D4D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:53:33 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6nx83MSqz18Lt7;
	Fri, 21 Jul 2023 19:52:44 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 19:53:30 +0800
Subject: Re: [PATCH net-next] page_pool: add a lockdep check for recycling in
 hardirq
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>, <hawk@kernel.org>,
	<ilias.apalodimas@linaro.org>
References: <20230720173752.2038136-1-kuba@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <382d00e5-87af-6a6b-17e2-6640fdd01db5@huawei.com>
Date: Fri, 21 Jul 2023 19:53:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230720173752.2038136-1-kuba@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/21 1:37, Jakub Kicinski wrote:

...

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a3e12a61d456..3ac760fcdc22 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -536,6 +536,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
>  static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
>  {
>  	int ret;
> +
> +	lockdep_assert_no_hardirq();

Is there any reason not to put it in page_pool_put_defragged_page() to
catch the case with allow_direct being true when page_pool_recycle_in_ring()
may not be called?


>  	/* BH protection not needed if current is softirq */
>  	if (in_softirq())
>  		ret = ptr_ring_produce(&pool->ring, page);
> @@ -642,6 +644,8 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>  	int i, bulk_len = 0;
>  	bool in_softirq;
>  
> +	lockdep_assert_no_hardirq();
> +
>  	for (i = 0; i < count; i++) {
>  		struct page *page = virt_to_head_page(data[i]);
>  
> 

