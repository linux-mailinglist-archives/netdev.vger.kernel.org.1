Return-Path: <netdev+bounces-168513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC91A3F351
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFD93B7941
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170D209F5C;
	Fri, 21 Feb 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OpZXhP+e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F7209F38;
	Fri, 21 Feb 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138605; cv=none; b=VP9iPZJjcMRwiaXNsbJou1dFzZb/IbgwMYbn/6K+M0SkZJBFk3OXOpWdKaJ7i1/E8RKbQZOhT2r0vjyJKS3tUApAlEfUuhcaSs/vXozu9ZGUBF1Vzzugb3ck9SqOC0nEQFgsFcc9YHp8YXXLvmeCIGDPfjshFiCl9baqOzgTdeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138605; c=relaxed/simple;
	bh=QOHOUMoYx7AP3FUv13h2VGye5dFWxoDX2wdAsEH3cjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsVVo4ZqzaVqXk6TNPOdvHK0d/WdwJmOav6Jrs37y+S0p8rLst3twiUZccpyZAs74S1tLteERjDdnSeZUUApUz7Ql2tktH2VufYTwAlmRg37sAfdb1QfEvWhciPnVpzY5tUkbAFQVYdaDHyVGFVnfGrzEuo9vyMdVYWkhf0cFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OpZXhP+e; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YRbeIpTW2o5n4pIxMblvC9/4iZSat+Ow4QvCwIGQR6Y=; b=OpZXhP+eI/cOxTTuMaXQ9z6OVz
	JMKExuezMP4gafNgpnHPFVzPcyqwJed97diGCdUBcXtsWEHgOxetVJCALAa/MC54RZcoFdU3FAQ0M
	JxL6IZBDXrJc1YmoqiqrniqtamHB6Hplg/sAnFApgzQkaKdVTBxj9+oSbzk26GADU8j6V8RJw2OZV
	xBdaeFggqZ7gsbrd3ESk+/EfPlGHKcU3xGwx/hVwQ3SmrkbGULa3jzpzq1fSTm9r6ptPTonMxLYcf
	quhZVVFxk6WuYYhQUvBjOohO3cwj6c+W3f4BP3sUBiaqe894rC9RhS6c0cVWo2Zw5Z0B5shn+TT35
	PZMi3Ebw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45184)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tlRXR-0004SP-2d;
	Fri, 21 Feb 2025 11:49:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tlRXM-0001yQ-2s;
	Fri, 21 Feb 2025 11:49:44 +0000
Date: Fri, 21 Feb 2025 11:49:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
Message-ID: <Z7hoWHfMCMEABJlp@shell.armlinux.org.uk>
References: <20250220043712.31966-1-swathi.ks@samsung.com>
 <CGME20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790@epcas5p3.samsung.com>
 <20250220043712.31966-3-swathi.ks@samsung.com>
 <Z7cimPBdZ3W9GKmI@shell.armlinux.org.uk>
 <02b701db844c$36b7aeb0$a4270c10$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b701db844c$36b7aeb0$a4270c10$@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 21, 2025 at 04:04:25PM +0530, Swathi K S wrote:
> 
> 
> > -----Original Message-----
> > From: Russell King (Oracle) <linux@armlinux.org.uk>
> > Sent: 20 February 2025 18:10
> > To: Swathi K S <swathi.ks@samsung.com>
> > Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> > mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> > netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-stm32@st-md-
> > mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; pankaj.dubey@samsung.com;
> > ravi.patel@samsung.com; gost.dev@samsung.com
> > Subject: Re: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
> > 
> > On Thu, Feb 20, 2025 at 10:07:12AM +0530, Swathi K S wrote:
> > > +static int fsd_eqos_probe(struct platform_device *pdev,
> > > +			  struct plat_stmmacenet_data *data,
> > > +			  struct stmmac_resources *res)
> > > +{
> > > +	struct clk *clk_rx1 = NULL;
> > > +	struct clk *clk_rx2 = NULL;
> > > +
> > > +	for (int i = 0; i < data->num_clks; i++) {
> > > +		if (strcmp(data->clks[i].id, "slave_bus") == 0)
> > > +			data->stmmac_clk = data->clks[i].clk;
> > > +		else if (strcmp(data->clks[i].id, "eqos_rxclk_mux") == 0)
> > > +			clk_rx1 = data->clks[i].clk;
> > > +		else if (strcmp(data->clks[i].id, "eqos_phyrxclk") == 0)
> > > +			clk_rx2 = data->clks[i].clk;
> > > +	}
> > > +
> > > +	/* Eth0 RX clock doesn't support MUX */
> > > +	if (clk_rx1)
> > > +		clk_set_parent(clk_rx1, clk_rx2);
> > 
> > Isn't there support in DT for automatically setting the clock tree?
> > See
> > https://protect2.fireeye.com/v1/url?k=f0089f78-90ea0225-f0091437-
> > 000babd9f1ba-cf835b8b94ccd94a&q=1&e=4ae794ec-f443-4d77-aee4-
> > 449f53a3a1a4&u=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-
> > schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fclock%2Fclock.yaml
> > %23L24
> > 
> > Also, I think a cleanup like the below (sorry, it's on top of other
> patches I'm
> > working on at the moment but could be rebased) would make sense.
> > 
> > With both of these, this should mean that your changes amount to:
> > 
> > 1. making data->probe optional
> > 2. providing a dwc_eth_dwmac_data structure that has .stmmac_clk_name
> >    filled in
> > 3. adding your compatible to the match data with a pointer to the
> >    above structure.
> 
> Hi Russell, 
> Thanks for your input.
> Will implement this in v8.
> But I could not find your patch 'net: stmmac: clean up clock initialisation'
> in mailing list
> Could you point me to that?
> Or do you want me to integrate the below changes into my patch series and
> post?
> 
> Please let me know

Please have patience - I'm a volunteer here, and I included the patch in
the email for you. You're not the only one whom I'm addressing issues in
the stmmac driver for. Since Sunday, I have a total of 16 new stmmac
patches plus been debugging a regression someone has reported.

Coincidentally, I just sent out the patch as a stand-alone patch, it
should be quicker to get it into net-next rather than trying to get all
the other patches I'd *already* had queued up in first.

https://lore.kernel.org/r/E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk

However, I'm expecting someone to say that dwc_eth_find_clk() should be
moved into the stmmac platform code, and the other platforms need to be
converted to use it... so it may be some time before we're at a stage
where you can proceed.

Please be patient.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

