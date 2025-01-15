Return-Path: <netdev+bounces-158482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075DA11FD4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B163A698C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2617248BB6;
	Wed, 15 Jan 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eMN1r21d"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE1248BA4;
	Wed, 15 Jan 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937510; cv=none; b=hkDbJwvqvlB6Mw2k4N6gRzFm+kETB+AgN16uB0bRsv9iqlG+sowlh8Ss78wts9ZpLoqhR8gsfnJpdHNelcwZKkBFetg6dD2jcYstjXZWEXGkbq0u/QFE2YFMplxKIHaldtsvlokgWaDGYSUXTW3p4UiDwpSahGkeodv1UcUcIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937510; c=relaxed/simple;
	bh=Jbeu6FtJK3uXjY3ab59hFF2zcGilCnkpp7k8ZEZzW6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olz5zU7xi96OKfwWMT5lEjWK1LnsAAtD1dtn4cPTFEoEaUVK9uf5JYs7otQFCnYqHs3uQ9IViSM+0VRbOakm4NDH/To/s1rwlb0f0WHisYz83Sly0CBaQrd5QU5qOYJ/iSwwxlfBulJ4J4tTZMKwBKyt6dArdSgr0zIFjbRFe/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eMN1r21d; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50FAcGiZ4009895
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 04:38:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736937496;
	bh=mL3Dnt9U/zSbR2BfUwFnOQJR5th32xjWapBTFPm3cg4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=eMN1r21dKCHWAB5iTisUM+56lZIl/O6BhLqtg5vtrBna1Me/AR339l1BqeQ1my+OD
	 046m8sIS7AGBL4MwkbzcJ/cQpVr5tENP2TcZZAN/MbmwUcwp7ROC4UEMRjLXjkKQKB
	 mQuQgCO33vFYIK3dUr2dc+jxI2gkg+1G4ez9I2Hk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50FAcGmF024847
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jan 2025 04:38:16 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Jan 2025 04:38:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Jan 2025 04:38:16 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50FAcE1W035356;
	Wed, 15 Jan 2025 04:38:15 -0600
Date: Wed, 15 Jan 2025 16:08:14 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>, <srk@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
Message-ID: <m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy>
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
 <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
 <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Jan 15, 2025 at 12:04:17PM +0200, Roger Quadros wrote:
> Hi Siddharth,
> 
> On 15/01/2025 07:18, Siddharth Vadapalli wrote:
> > On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
> > 
> > Hello Roger,
> > 
> >> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
> > 
> > You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
> > assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:
> 
> Yes I meant tx instead of rx.
> 
> > 
> > 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
> > 
> > Additionally, following the above section we have:
> > 
> > 		if (tx_chn->irq < 0) {
> > 			dev_err(dev, "Failed to get tx dma irq %d\n",
> > 				tx_chn->irq);
> > 			ret = tx_chn->irq;
> > 			goto err;
> > 		}
> > 
> > Could you please provide details on the code-path which will lead to a
> > negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
> > 
> > There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
> > 1. am65_cpsw_nuss_update_tx_rx_chns()
> > 2. am65_cpsw_nuss_suspend()
> > Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
> > in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
> > appears to me that "tx_chn->irq" will never be negative within
> > am65_cpsw_nuss_remove_tx_chns()
> > 
> > Please let me know if I have overlooked something.
> 
> The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
> repeatedly (by user changing number of TX queues) even if previous call
> to am65_cpsw_nuss_init_tx_chns() failed.

Thank you for clarifying. So the issue/bug was discovered since the
implementation of am65_cpsw_nuss_update_tx_rx_chns(). The "Fixes" tag
misled me. Maybe the "Fixes" tag should be updated? Though we should
code to future-proof it as done in this patch, the "Fixes" tag pointing
to the very first commit of the driver might not be accurate as the
code-path associated with the bug cannot be exercised at that commit.

Independent of the above change suggested for the "Fixes" tag,

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

There seems to be a different bug in am65_cpsw_nuss_update_tx_rx_chns()
which I have described below.

> 
> Please try the below patch to simulate the error condition.
> 
> Then do the following
> - bring down all network interfaces
> - change num TX queues to 2. IRQ for 2nd channel fails.
> - change num TX queues to 3. Now we try to free an invalid IRQ and we see warning.
> 
> Also I think it is good practice to code for set value than to code
> for existing code paths as they can change in the future.
> 
> --test patch starts--
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 36c29d3db329..c22cadaaf3d3 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -155,7 +155,7 @@
>  			 NETIF_MSG_IFUP	| NETIF_MSG_PROBE | NETIF_MSG_IFDOWN | \
>  			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
>  
> -#define AM65_CPSW_DEFAULT_TX_CHNS	8
> +#define AM65_CPSW_DEFAULT_TX_CHNS	1
>  #define AM65_CPSW_DEFAULT_RX_CHN_FLOWS	1
>  
>  /* CPPI streaming packet interface */
> @@ -2346,7 +2348,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
>  		tx_chn->dsize_log2 = __fls(hdesc_size_out);
>  		WARN_ON(hdesc_size_out != (1 << tx_chn->dsize_log2));
>  
> -		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
> +		if (i == 1)
> +			tx_chn->irq = -ENODEV;
> +		else
> +			tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);

The pair - am65_cpsw_nuss_init_tx_chns()/am65_cpsw_nuss_remove_tx_chns()
seem to be written under the assumption that failure will result in the
driver's probe failing.

With am65_cpsw_nuss_update_tx_rx_chns(), that assumption no longer holds
true. Please consider the following sequence:

1.
am65_cpsw_nuss_probe()
  am65_cpsw_nuss_register_ndevs()
    am65_cpsw_nuss_init_tx_chns() => Succeeds

2.
Probe is successful

3.
am65_cpsw_nuss_update_tx_rx_chns() => Invoked by user
  am65_cpsw_nuss_remove_tx_chns() => Succeeds
    am65_cpsw_nuss_init_tx_chns() => Partially fails
      devm_add_action(dev, am65_cpsw_nuss_free_tx_chns, common);
      ^ DEVM Action is added, but since the driver isn't removed,
      the cleanup via am65_cpsw_nuss_free_tx_chns() will not run.

Only when the user re-invokes am65_cpsw_nuss_update_tx_rx_chns(),
the cleanup will be performed. This might have to be fixed in the
following manner:

@@ -3416,10 +3416,17 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
        common->tx_ch_num = num_tx;
        common->rx_ch_num_flows = num_rx;
        ret = am65_cpsw_nuss_init_tx_chns(common);
-       if (ret)
+       if (ret) {
+               devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
+               am65_cpsw_nuss_free_tx_chns(common);
                return ret;
+       }

        ret = am65_cpsw_nuss_init_rx_chns(common);
+       if (ret) {
+               devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
+               am65_cpsw_nuss_free_rx_chns(common);
+       }

        return ret;
 }

 Please let me know what you think.


Regards,
Siddharth.

