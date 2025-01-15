Return-Path: <netdev+bounces-158388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8652A118DB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 06:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A8F1685E9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 05:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9A157472;
	Wed, 15 Jan 2025 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ynRYaGH4"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94C801;
	Wed, 15 Jan 2025 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918336; cv=none; b=FF4ZIfxb0r4chLi/QPdWDykpDCvkkIXyBN5udtxl8aKT4K23fJmvZOASP/0F5n2/78iKqxNIyyNLHNLX/zKcpvxVHP7bT9JR/fNk3/vcTM+3p1ad1Tv+/Ek0+nsKO85ZjnIDCWFbrHzC7nYYBF0z2gXHpZ8f4VKwo1powihV0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918336; c=relaxed/simple;
	bh=JcXvKzIH+p1oggldabJBriZLR/hDNCfyLBSyTQmwAKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtBLLFHEtbhp+eFlZJwNpmx+bUkYsNkWRg0LP3HxRAzaxeHI67j2J4ex5eSMmzt6ErtT9pfOtWa8KbvLx11CE4VdGIjIwpAtJ9qGHXYklG+9vRl2uaKGWkoUNFchGhsT9o4X9z9MS/im/2eKMwfaapEGQOaaTl41zZpOz5qxVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ynRYaGH4; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50F5IT5W4093185
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Jan 2025 23:18:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736918309;
	bh=zwzM98V9qnooH7NVSiXPmmN6N+1zDFByxSTKmHUzOYY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ynRYaGH4oiCOvaOmfQfNu+dBKeIipmpXBWKINaHU8nhW7Xhn8Xd5gFfkI9jU3gK6W
	 L6YEagrnDlw0kE+GDZLtTl/w0pMt53lzeVFsrP6j/NSqHf4eo6DAQtoBW36qNzyeca
	 qseaBKgw5Mt0XnOiZEx75dTg8zQA/w+iuhl6oBZ0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50F5ITBf073779;
	Tue, 14 Jan 2025 23:18:29 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Jan 2025 23:18:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Jan 2025 23:18:29 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50F5ISiG042784;
	Tue, 14 Jan 2025 23:18:29 -0600
Date: Wed, 15 Jan 2025 10:48:28 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, <srk@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
Message-ID: <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:

Hello Roger,

> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns

You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:

		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);

Additionally, following the above section we have:

		if (tx_chn->irq < 0) {
			dev_err(dev, "Failed to get tx dma irq %d\n",
				tx_chn->irq);
			ret = tx_chn->irq;
			goto err;
		}

Could you please provide details on the code-path which will lead to a
negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?

There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
1. am65_cpsw_nuss_update_tx_rx_chns()
2. am65_cpsw_nuss_suspend()
Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
appears to me that "tx_chn->irq" will never be negative within
am65_cpsw_nuss_remove_tx_chns()

Please let me know if I have overlooked something.

Regards,
Siddharth.

> negative error value on error. So not NULL check is not sufficient
> to deteremine if IRQ is valid. Check that IRQ is greater then zero
> to ensure it is valid.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 5465bf872734..e1de45fb18ae 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2248,7 +2248,7 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
>  	for (i = 0; i < common->tx_ch_num; i++) {
>  		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
>  
> -		if (tx_chn->irq)
> +		if (tx_chn->irq > 0)
>  			devm_free_irq(dev, tx_chn->irq, tx_chn);
>  
>  		netif_napi_del(&tx_chn->napi_tx);
> 
> ---
> base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
> change-id: 20250114-am65-cpsw-fix-tx-irq-free-846ac55ee6e1
> 
> Best regards,
> -- 
> Roger Quadros <rogerq@kernel.org>
> 

