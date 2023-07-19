Return-Path: <netdev+bounces-19017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E9C7595CF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FB11C20FB3
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557E13AF6;
	Wed, 19 Jul 2023 12:44:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23614A86
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:44:00 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27742E0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:43:59 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5b8G1J1qzrRg0;
	Wed, 19 Jul 2023 20:43:10 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 19 Jul
 2023 20:43:54 +0800
Subject: Re: [RFC PATCH net-next 1/2] net: veth: Page pool creation error
 handling for existing pools only
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <netdev@vger.kernel.org>
References: <20230719072907.100948-1-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <dd01d05c-015f-708f-8357-1dd4db15d5de@huawei.com>
Date: Wed, 19 Jul 2023 20:43:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230719072907.100948-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/19 15:29, Liang Chen wrote:
> The failure handling procedure destroys page pools for all queues,
> including those that haven't had their page pool created yet. this patch
> introduces necessary adjustments to prevent potential risks and
> inconsistency with the error handling behavior.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/veth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 614f3e3efab0..509e901da41d 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1081,8 +1081,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
>  err_xdp_ring:
>  	for (i--; i >= start; i--)
>  		ptr_ring_cleanup(&priv->rq[i].xdp_ring, veth_ptr_free);
> +	i = end;
>  err_page_pool:
> -	for (i = start; i < end; i++) {
> +	for (i--; i >= start; i--) {
>  		page_pool_destroy(priv->rq[i].page_pool);
>  		priv->rq[i].page_pool = NULL;

There is NULL checking in page_pool_destroy(),
priv->rq[i].page_pool is set to NULL here, and the kcalloc()
in veth_alloc_queues() ensure it is NULL initially, maybe it
is fine as it is?

>  	}
> 

