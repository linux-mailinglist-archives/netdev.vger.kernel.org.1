Return-Path: <netdev+bounces-19483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E475ADDE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8515281CF8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5A818008;
	Thu, 20 Jul 2023 12:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075D18000
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:09:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646D2690
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:08:59 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6BGg3PKcztR8q;
	Thu, 20 Jul 2023 20:05:47 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 20:08:55 +0800
Subject: Re: [PATCH net-next 3/4] net: page_pool: hide
 page_pool_release_page()
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
References: <20230720010409.1967072-1-kuba@kernel.org>
 <20230720010409.1967072-4-kuba@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <31ae2905-2da4-af6d-493a-55429a39e8a5@huawei.com>
Date: Thu, 20 Jul 2023 20:08:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230720010409.1967072-4-kuba@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/20 9:04, Jakub Kicinski wrote:

>  Documentation/networking/page_pool.rst | 11 ++++-------
>  include/net/page_pool.h                | 10 ++--------
>  net/core/page_pool.c                   |  3 +--
>  3 files changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
> index 873efd97f822..0aa850cf4447 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -13,9 +13,9 @@ replacing dev_alloc_pages().
>  
>  API keeps track of in-flight pages, in order to let API user know
>  when it is safe to free a page_pool object.  Thus, API users
> -must run page_pool_release_page() when a page is leaving the page_pool or
> -call page_pool_put_page() where appropriate in order to maintain correct
> -accounting.
> +must call page_pool_put_page() to free the page, or attach
> +the page to a page_pool-aware objects like skbs marked with
> +skb_mark_for_recycle().
>  
>  API user must call page_pool_put_page() once on a page, as it
>  will either recycle the page, or in case of refcnt > 1, it will

...

> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 126f9e294389..f1d5cc1fa13b 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -18,9 +18,8 @@
>   *
>   * API keeps track of in-flight pages, in-order to let API user know
>   * when it is safe to dealloactor page_pool object.  Thus, API users
> - * must make sure to call page_pool_release_page() when a page is
> - * "leaving" the page_pool.  Or call page_pool_put_page() where
> - * appropiate.  For maintaining correct accounting.
> + * must call page_pool_put_page() where appropriate and only attach
> + * the page to a page_pool-aware objects, like skbs marked for recycling.
>   *
>   * API user must only call page_pool_put_page() once on a page, as it
>   * will either recycle the page, or in case of elevated refcnt, it

It seems the above comment is almost the same as the one in page_pool.rst,
Is there a reason not removing the above to remove the duplicatation?

