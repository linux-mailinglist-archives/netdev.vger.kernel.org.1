Return-Path: <netdev+bounces-19480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C275AD94
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3E0281E2D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48018000;
	Thu, 20 Jul 2023 11:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAA17FF5
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:55:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557532D6D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:55:32 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6B0s146lzVjMD;
	Thu, 20 Jul 2023 19:53:49 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 19:55:14 +0800
Subject: Re: [PATCH net-next 1/4] eth: tsnep: let page recycling happen with
 skbs
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<gerhard@engleder-embedded.com>
References: <20230720010409.1967072-1-kuba@kernel.org>
 <20230720010409.1967072-2-kuba@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <18e080e3-7f0d-8283-f0ef-babfebfad1a4@huawei.com>
Date: Thu, 20 Jul 2023 19:55:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230720010409.1967072-2-kuba@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/20 9:04, Jakub Kicinski wrote:
> tsnep builds an skb with napi_build_skb() and then calls

nit: an -> a ?

Othewise, LGTM.

Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

> page_pool_release_page() for the page in which that skb's
> head sits. Use recycling instead, recycling of heads works
> just fine.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: gerhard@engleder-embedded.com
> ---
>  drivers/net/ethernet/engleder/tsnep_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
> index 84751bb303a6..079f9f6ae21a 100644
> --- a/drivers/net/ethernet/engleder/tsnep_main.c
> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> @@ -1333,7 +1333,7 @@ static void tsnep_rx_page(struct tsnep_rx *rx, struct napi_struct *napi,
>  
>  	skb = tsnep_build_skb(rx, page, length);
>  	if (skb) {
> -		page_pool_release_page(rx->page_pool, page);
> +		skb_mark_for_recycle(skb);
>  
>  		rx->packets++;
>  		rx->bytes += length;
> 

