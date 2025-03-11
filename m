Return-Path: <netdev+bounces-173790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A9A5BB27
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D683B1896481
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A55D226D0B;
	Tue, 11 Mar 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P+gpc8Bz"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA2226865;
	Tue, 11 Mar 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683096; cv=none; b=ghg4T8Q+5JxBxH9R4Zd4ezO5T8XMz3OIasy1LBumqOc8w7m8ZiWiY2wDCasRzTtukmkIcAeXRBrHnexz8OuQmNBCjUWHOklFtNOQaWYw9b+7CzSfGYQMUgOTOPnKKg6qr5g6QR+pezVCDGPKnzrVXQGzC7Pvmlws4WL8j7sV8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683096; c=relaxed/simple;
	bh=YXP2RJ5SkqHF9QZZ7hHh/BRLjgxVNLw2DUDbJCVXiu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyxfLc92fYfI9nP0yzKyrV8ZNww1L4UuoDvKngLsH/0oRxitKdC2vSExqqGiP5bmO49Wa2EkPB/bipTOMwsi8CgmNpfUbxsFUEisuVtq9QIekhiFsyWOgyg30Vo8VAKsotqtK/CjH3hszCEzxg3XMdl1z/tFUy7r0/P3++aYXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P+gpc8Bz; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B8pBYU1141179
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 03:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741683071;
	bh=iwZ54kNHfdvvEjAMZoUWlnIMHfpRhgOK0x0eAv0wDF4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=P+gpc8Bz7K5gbQRu1Pxwy5gYtqq4zjK1NDWvr6fF4Sa0MNI5Ua/tB+AHdxPQRfOq7
	 iZebJU0EC5ColbKOZrBUAymAVhVm9xwMyD225HSNsVQXVXoD16cl5qwYXNTU7dD9V9
	 1nBRIrlnczfUAxbWF99TuV0srKdrNT8/n+w6bFF0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52B8pBwd023379
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 03:51:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 03:51:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 03:51:10 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B8p9dr037656;
	Tue, 11 Mar 2025 03:51:10 -0500
Date: Tue, 11 Mar 2025 14:21:09 +0530
From: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "jpanis@baylibre.com"
	<jpanis@baylibre.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srk@ti.com"
	<srk@ti.com>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix NAPI registration
 sequence
Message-ID: <20250311085109.q3g32v3ycoskhsko@uda0492258>
References: <20250311061214.4111634-1-s-vadapalli@ti.com>
 <421a4c67865215927897e16866814bd6eb68a89d.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <421a4c67865215927897e16866814bd6eb68a89d.camel@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 11, 2025 at 07:09:56AM +0000, Sverdlin, Alexander wrote:
> Hi Siddharth!

Hello Alexander,

> 
> On Tue, 2025-03-11 at 11:42 +0530, Siddharth Vadapalli wrote:
> > From: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > Registering the interrupts for TX or RX DMA Channels prior to registering
> > their respective NAPI callbacks can result in a NULL pointer dereference.
> > This is seen in practice as a random occurrence since it depends on the
> > randomness associated with the generation of traffic by Linux and the
> > reception of traffic from the wire.
> > 
> > Fixes: 681eb2beb3ef ("net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path")
> 
> The patch Vignesh mentions here...
> 
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on commit
> > 4d872d51bc9d Merge tag 'x86-urgent-2025-03-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > of Mainline Linux.
> > 
> > Regards,
> > Siddharth.
> > 
> >  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > index 2806238629f8..d5291281c781 100644
> > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > @@ -2314,6 +2314,9 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
> >  		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
> >  		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
> >  
> > +		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
> > +				  am65_cpsw_nuss_tx_poll);
> > +
> >  		ret = devm_request_irq(dev, tx_chn->irq,
> >  				       am65_cpsw_nuss_tx_irq,
> >  				       IRQF_TRIGGER_HIGH,
> > @@ -2323,9 +2326,6 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
> >  				tx_chn->id, tx_chn->irq, ret);
> >  			goto err;
> >  		}
> > -
> > -		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
> > -				  am65_cpsw_nuss_tx_poll);
> 
> ... has accounted for the fact ..._napi_add_... happens after [possibly unsuccessful] request_irq,
> please grep for "for (--i ;". Is it necessary to adjust both loops, in the below case too?

Yes! The order within the cleanup path has to be reversed too i.e.
release IRQ first followed by deleting the NAPI callback. I assume that
you are referring to the same. Please let me know otherwise. The diff
corresponding to it is:
---------------------------------------------------------------------------------------------------
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index d5291281c781..32c844816501 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2334,8 +2334,8 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
        for (--i ; i >= 0 ; i--) {
                struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];

-               netif_napi_del(&tx_chn->napi_tx);
                devm_free_irq(dev, tx_chn->irq, tx_chn);
+               netif_napi_del(&tx_chn->napi_tx);
        }

        return ret;
@@ -2592,8 +2592,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 err_flow:
        for (--i; i >= 0 ; i--) {
                flow = &rx_chn->flows[i];
-               netif_napi_del(&flow->napi_rx);
                devm_free_irq(dev, flow->irq, flow);
+               netif_napi_del(&flow->napi_rx);
        }

 err:
---------------------------------------------------------------------------------------------------
Based on your confirmation, I will implement the above and post the v2
patch. Thank you for reviewing this patch and providing feedback.

Regards,
Siddharth.

