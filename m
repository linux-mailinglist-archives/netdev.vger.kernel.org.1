Return-Path: <netdev+bounces-173801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E02A5BB88
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7555617309C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587241DF979;
	Tue, 11 Mar 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VK/8XLPh"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDE21D595;
	Tue, 11 Mar 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683648; cv=none; b=Wn8eqgLAdbNfG2y1V8N7IxjLHN70QI1kUyYs6UiEKYGTINF5bOF+W1De/gxrZr14OFbNvzcOCWNqgd7fB+FB6xYtIEonWekZSvQ/ETpz22sNweDbdgAb37RW5xQ6fpoZIlOz55ou+RenZvgDf+mdG+HTn9MTSXbNcj2uG/Tym9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683648; c=relaxed/simple;
	bh=PC6eMeY8m3qoU5glu+neTti3tRrNxMUmAozC+Q6jhvE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiRmdaDuZ3hwnNwI71sE8A1DH8fglxiQE6EoCLyNep7SmXgUDLCShu9Td+yWqOXyHhQxbOKyp2hFR5rRmBM2Wkn7zzfQ4pT8xKcuL9bgeHDwmFiy1+Lle06sufJUBiW8trLmPQW1vqw86gIy/tlQJfdPwTwH1i77WelND6ciXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VK/8XLPh; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B90Rgt1142731
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 04:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741683627;
	bh=0cgf7pDS3ZEN7lDdy8FO07onfj2Tasy5sT842LonhZc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VK/8XLPhPLd6nIpV64hf9SX17OEGTVvGFN0aZ5lLYJGTHC653FMfU9koPJpa7zjY5
	 GiIDGOo8DayilpacV58I5eKRmOCgkhqY+vmsgsvZPILx15TqQMEUBMmL5hKEASoYqb
	 gtxQtbdyyBlihw3llcTpZyPNSSKORAVdmFF1YkyQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52B90RDv030844
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 04:00:27 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 04:00:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 04:00:26 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B90Pi9111975;
	Tue, 11 Mar 2025 04:00:26 -0500
Date: Tue, 11 Mar 2025 14:30:25 +0530
From: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jpanis@baylibre.com" <jpanis@baylibre.com>, "srk@ti.com" <srk@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "rogerq@kernel.org"
	<rogerq@kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix NAPI registration
 sequence
Message-ID: <20250311090025.kyc657febhgxrhoa@uda0492258>
References: <20250311061214.4111634-1-s-vadapalli@ti.com>
 <421a4c67865215927897e16866814bd6eb68a89d.camel@siemens.com>
 <20250311085109.q3g32v3ycoskhsko@uda0492258>
 <dbeb0d830c41eefe127d13af55fbaf6243164b0a.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbeb0d830c41eefe127d13af55fbaf6243164b0a.camel@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 11, 2025 at 08:56:49AM +0000, Sverdlin, Alexander wrote:
> Hi Siddharth!
> 
> On Tue, 2025-03-11 at 14:21 +0530, s-vadapalli@ti.com wrote:
> > > > Registering the interrupts for TX or RX DMA Channels prior to registering
> > > > their respective NAPI callbacks can result in a NULL pointer dereference.
> > > > This is seen in practice as a random occurrence since it depends on the
> > > > randomness associated with the generation of traffic by Linux and the
> > > > reception of traffic from the wire.
> > > > 
> > > > Fixes: 681eb2beb3ef ("net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path")
> > > 
> > > The patch Vignesh mentions here...
> > > 
> > > > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > > > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> ...
> 
> > > > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > > @@ -2314,6 +2314,9 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
> > > >  		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
> > > >  		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
> > > >  
> > > > +		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
> > > > +				  am65_cpsw_nuss_tx_poll);
> > > > +
> > > >  		ret = devm_request_irq(dev, tx_chn->irq,
> > > >  				       am65_cpsw_nuss_tx_irq,
> > > >  				       IRQF_TRIGGER_HIGH,
> > > > @@ -2323,9 +2326,6 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
> > > >  				tx_chn->id, tx_chn->irq, ret);
> > > >  			goto err;
> > > >  		}
> > > > -
> > > > -		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
> > > > -				  am65_cpsw_nuss_tx_poll);
> > > 
> > > ... has accounted for the fact ..._napi_add_... happens after [possibly unsuccessful] request_irq,
> > > please grep for "for (--i ;". Is it necessary to adjust both loops, in the below case too?
> > 
> > Yes! The order within the cleanup path has to be reversed too i.e.
> 
> Not only reverting the order...
> What I'm referring is: when requesting i-th IRQ fails there has been 
> i-th NAPI already added, but the cleanup loops start from [i-1]-th instance.
> It looks like a potential leak to me...

Thank you for clarifying. I will address this and the previous feedback in
the v2 patch.

Regards,
Siddharth.

