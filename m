Return-Path: <netdev+bounces-22726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9F768F70
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED251C20B72
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB288485;
	Mon, 31 Jul 2023 08:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710162569
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:02:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D643E41;
	Mon, 31 Jul 2023 01:02:39 -0700 (PDT)
Received: from dggpemm500008.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDrH409JdzNmWN;
	Mon, 31 Jul 2023 15:59:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:02:36 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:02:36 +0800
Subject: Re: [PATCH net] net: ll_temac: fix error checking of
 irq_of_parse_and_map()
To: Dan Carpenter <dan.carpenter@linaro.org>, Esben Haabendal
	<esben@geanix.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Harini Katakam
	<harini.katakam@amd.com>, Haoyue Xu <xuhaoyue1@hisilicon.com>, huangjunxian
	<huangjunxian6@hisilicon.com>, Rob Herring <robh@kernel.org>,
	<netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <014b3bb1-4962-2e63-8211-1fdb0b4cfbf6@huawei.com>
Date: Mon, 31 Jul 2023 16:02:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>

On 2023/7/31 15:42, Dan Carpenter wrote:
> Most kernel functions return negative error codes but some irq functions
> return zero on error.  In this code irq_of_parse_and_map(), returns zero
> and platform_get_irq() returns negative error codes.  We need to handle
> both cases appropriately.
>
> Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/ethernet/xilinx/ll_temac_main.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index e0ac1bcd9925..49f303353ecb 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -1567,12 +1567,16 @@ static int temac_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Error handle returned DMA RX and TX interrupts */
> -	if (lp->rx_irq < 0)
> -		return dev_err_probe(&pdev->dev, lp->rx_irq,
> +	if (lp->rx_irq <= 0) {
> +		rc = lp->rx_irq ?: -EINVAL;
> +		return dev_err_probe(&pdev->dev, rc,
>   				     "could not get DMA RX irq\n");
> -	if (lp->tx_irq < 0)
> -		return dev_err_probe(&pdev->dev, lp->tx_irq,
> +	}
> +	if (lp->tx_irq <= 0) {
> +		rc = lp->tx_irq ?: -EINVAL;
> +		return dev_err_probe(&pdev->dev, rc,
>   				     "could not get DMA TX irq\n");
> +	}
>   
>   	if (temac_np) {
>   		/* Retrieve the MAC address */

