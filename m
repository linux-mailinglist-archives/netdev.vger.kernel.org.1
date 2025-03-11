Return-Path: <netdev+bounces-173943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D21A5C624
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28020188661A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372B25E81D;
	Tue, 11 Mar 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KpjTR1Il"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50825E815;
	Tue, 11 Mar 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706336; cv=none; b=lUaUU3jgXiYD3LtceanEvQ6G1o7J2SVvTMyx18JzzvRuWFpexFLW3tbzPB5qxTXLnMDW+3GQ5R0Rw8UA8slisNKDpwo9RgXf38abJVax8Jr/feU98SC4fxpyzDmydcrA+8ndm1eT9QqSyo3p2V01KU7l3AMX+p2Y5WxS8sO2kR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706336; c=relaxed/simple;
	bh=2uz5FpXW4xqboxTQTQsq1V0u2v7iTR+GUQfREdOaDRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr3HiJNm7LI+F6uxZtCfexCgCOOybKftuO72VLcvvqJ35+curr89w+2FZF+GDC7xyc0rr00o4/LOXzzI7vI/JrRUUovMVvovqMwP2amAjSccJhyPAII4eMwVX+7sUaFM/tpyMpinaeD8uQm7YDjbQjW5qVogbVrljQfIvfN5t04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KpjTR1Il; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFIZVO1325000
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 10:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741706315;
	bh=qFnSX2KTr0k/JpY3eMOlcXYP3G68WqDAGo3AvBQ3g7E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KpjTR1Il84Ht/Nz19XHRYNAX0ZPVuAQe/qi7rRJN7Qt0lF3EmKQzT434dTg5XzHsZ
	 vLpe2ZZ9vx74v+wSoEUMEMonRAoVYcyiorUYjgENBpfuU8irJ8lZAYa5N0/Ly5e9UP
	 1wB81AnIfHlM5D+N0n/9WCDk5DTTm5VypVIDklw0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFIZgZ073265
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 10:18:35 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 10:18:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 10:18:34 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52BFIXYx002158;
	Tue, 11 Mar 2025 10:18:34 -0500
Date: Tue, 11 Mar 2025 20:48:33 +0530
From: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "jpanis@baylibre.com"
	<jpanis@baylibre.com>,
        "c-vankar@ti.com" <c-vankar@ti.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srk@ti.com"
	<srk@ti.com>
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Message-ID: <20250311151833.v3gymfqao4y2zls7@uda0492258>
References: <20250311130103.68971-1-s-vadapalli@ti.com>
 <02d685e2aa8721a119f528bde2f4ec9533101663.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02d685e2aa8721a119f528bde2f4ec9533101663.camel@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 11, 2025 at 01:53:10PM +0000, Sverdlin, Alexander wrote:
> Hi Siddharth!
> 
> On Tue, 2025-03-11 at 18:31 +0530, Siddharth Vadapalli wrote:
> > From: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > Registering the interrupts for TX or RX DMA Channels prior to registering
> > their respective NAPI callbacks can result in a NULL pointer dereference.
> > This is seen in practice as a random occurrence since it depends on the
> > randomness associated with the generation of traffic by Linux and the
> > reception of traffic from the wire.
> > 
> > Fixes: 681eb2beb3ef ("net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path")
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> ...
> 
> > v1 of this patch is at:
> > https://lore.kernel.org/all/20250311061214.4111634-1-s-vadapalli@ti.com/
> > Changes since v1:
> > - Based on the feedback provided by Alexander Sverdlin <alexander.sverdlin@siemens.com>
> >   the patch has been updated to account for the cleanup path in terms of an imbalance
> >   between the number of successful netif_napi_add_tx/netif_napi_add calls and the
> >   number of successful devm_request_irq() calls. In the event of an error, we will
> >   always have one extra successful netif_napi_add_tx/netif_napi_add that needs to be
> >   cleaned up before we clean an equal number of netif_napi_add_tx/netif_napi_add and
> >   devm_request_irq.
> 
> ...
> 
> > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > @@ -2569,6 +2570,9 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
> >  			     HRTIMER_MODE_REL_PINNED);
> >  		flow->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
> >  
> > +		netif_napi_add(common->dma_ndev, &flow->napi_rx,
> > +			       am65_cpsw_nuss_rx_poll);
> > +
> >  		ret = devm_request_irq(dev, flow->irq,
> >  				       am65_cpsw_nuss_rx_irq,
> >  				       IRQF_TRIGGER_HIGH,
> > @@ -2579,9 +2583,6 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
> >  			flow->irq = -EINVAL;
> >  			goto err_flow;
> >  		}
> > -
> > -		netif_napi_add(common->dma_ndev, &flow->napi_rx,
> > -			       am65_cpsw_nuss_rx_poll);
> >  	}
> >  
> >  	/* setup classifier to route priorities to flows */
> > @@ -2590,10 +2591,11 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
> >  	return 0;
> >  
> >  err_flow:
> > -	for (--i; i >= 0 ; i--) {
> > +	netif_napi_del(&flow->napi_rx);
> 
> There are totally 3 "goto err_flow;" instances, so if k3_udma_glue_rx_flow_init() or
> k3_udma_glue_rx_get_irq() would fail on the first iteration, we would come here without
> a single call to netif_napi_add().

The following should address this right?
------------------------------------------------------------------------------------------------
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index b88edf2dd8f4..bef734c6e5c2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2581,7 +2581,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
                        dev_err(dev, "failure requesting rx %d irq %u, %d\n",
                                i, flow->irq, ret);
                        flow->irq = -EINVAL;
-                       goto err_flow;
+                       goto err_request_irq;
                }
        }

@@ -2590,8 +2590,10 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)

        return 0;

-err_flow:
+err_request_irq:
        netif_napi_del(&flow->napi_rx);
+
+err_flow:
        for (--i; i >= 0; i--) {
                flow = &rx_chn->flows[i];
                devm_free_irq(dev, flow->irq, flow);
------------------------------------------------------------------------------------------------

err_request_irq => We have an extra netif_napi_add() which needs to be
cleaned up.
err_flow => Equal count of netif_napi_add() and devm_request_irq() that
should be cleaned up.

Regards,
Siddharth.

