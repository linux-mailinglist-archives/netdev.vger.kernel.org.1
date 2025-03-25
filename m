Return-Path: <netdev+bounces-177492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26924A70525
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA31F1885558
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238E19D071;
	Tue, 25 Mar 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tVuLplN5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFB18C903;
	Tue, 25 Mar 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916888; cv=none; b=lePHyCc5N8c6n2OO2RVwj4Tr3ZpkIwolY1CEcpNIvv0w214s3tc1f+GERK+fVeIErywqAMll7LspT6d39BcahVFSEDvoM/RxATJw6nBpgFqQqGBcKY7eq0ezc7onjA7oAuM7wDaAtWfplSMAtINHxKTn6WXDTtgH+g9igun2T44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916888; c=relaxed/simple;
	bh=8KfyOJBAZFmXTBDgsO0EBqDFDRKm4ygoD0e/Y33iedw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1ba8UuRAxphgJXBTib3Za0I98fwMT3/+6P4l0belG2sDasFLquYetth4pktAHOfwmiX23hNNtwxVX8/ev2C5w5NdoNufu6QI8sVnkp0zd56KydLJr3FdofIAKOdHDen1QveHuTZR2J6893nit6llvwc82UTs+nC+GdZtYvxA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tVuLplN5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UEb2Y00Ew1puHYL5oaOzdh6VZps8lUZ2BRTU7aqo884=; b=tVuLplN5WM4nKBrIbNca5mB2VL
	XKuL5B8epwLBxeRFpLYyDpPUaP3agKjFVURZ2qFL68dSs8UpHYUFfCxOVzJK6OQkv1LjafhA2CSnZ
	Tj/AFtGcuTk5o56Y7zIU5NOfRXY++dJA4S7kjstxekncmTK6cC9J0AuN/h9rSPirk+94=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tx6IX-0074Yt-MM; Tue, 25 Mar 2025 16:34:37 +0100
Date: Tue, 25 Mar 2025 16:34:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 5/5] net: mtip: The L2 switch driver for imx287
Message-ID: <0a908dc7-55eb-4e23-8452-7b7d2e0f4289@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
 <20250325115736.1732721-6-lukma@denx.de>
 <32d93a90-3601-4094-8054-2737a57acbc7@kernel.org>
 <20250325142810.0aa07912@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325142810.0aa07912@wsk>

> > > +config FEC_MTIP_L2SW
> > > +	tristate "MoreThanIP L2 switch support to FEC driver"
> > > +	depends on OF
> > > +	depends on NET_SWITCHDEV
> > > +	depends on BRIDGE
> > > +	depends on ARCH_MXS || ARCH_MXC  
> > 
> > Missing compile test
> 
> Could you be more specific?

config FEC
        tristate "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
        depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
                   ARCH_MXC || ARCH_S32 || SOC_IMX28 || COMPILE_TEST)

|| COMPILE_TEST

So that it also gets build on amd64, s390, powerpc etc. The code
should cleanly build on all architectures. It if does not, it probably
means the code is using the kernel abstractions wrong. Also, most
developers build test on amd64, not arm, so if they are making tree
wide changes, you want this driver to build on amd64 so such tree wide
changes get build tested.

> There have been attempts to upstream this driver since 2020...
> The original code is from - v4.4 for vf610 and 2.6.35 for imx287.
> 
> It has been then subsequently updated/rewritten for:
> 
> - 4.19-cip
> - 5.12 (two versions for switchdev and DSA)
> - 6.6 LTS
> - net-next.
> 
> The pr_err() were probably added by me as replacement for
> "printk(KERN_ERR". I can change them to dev_* or netdev_*. This shall
> not be a problem.

With Ethernet switches, you need to look at the context. Is it
something specific to one interface? The netdev_err(). If it is global
to the whole switch, then dev_err().

> > > +	pr_info("Ethernet Switch Version %s\n", VERSION);  
> > 
> > Drivers use dev, not pr. Anyway drop. Drivers do not have versions and
> > should be silent on success.
> 
> As I've written above - there are several "versions" on this particular
> driver. Hence the information.

There is only one version in mainline, this version (maybe). Mainline
does not care about other versions. Such version information is also
useless, because once it is merged, it never changes. What you
actually want to know is the kernel git hash, so you can find the
exact sources. ethtool -I will return that, assuming your ethtool code
is correct.

> > > +	pr_info("Ethernet Switch HW rev 0x%x:0x%x\n",
> > > +		MCF_MTIP_REVISION_CUSTOMER_REVISION(rev),
> > > +		MCF_MTIP_REVISION_CORE_REVISION(rev));  
> > 
> > Drop
> 
> Ok.

You can report this via ethtool -I. But i suggest you leave that for
later patches.

> > > +	fep->reg_phy = devm_regulator_get(&pdev->dev, "phy");
> > > +	if (!IS_ERR(fep->reg_phy)) {
> > > +		ret = regulator_enable(fep->reg_phy);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev,
> > > +				"Failed to enable phy regulator:
> > > %d\n", ret);
> > > +			goto failed_regulator;
> > > +		}
> > > +	} else {
> > > +		if (PTR_ERR(fep->reg_phy) == -EPROBE_DEFER) {
> > > +			ret = -EPROBE_DEFER;
> > > +			goto failed_regulator;
> > > +		}
> > > +		fep->reg_phy = NULL;  
> > 
> > I don't understand this code. Do you want to re-implement
> > get_optional? But why?
> 
> Here the get_optional() shall be used.

This is the problem with trying to use old code. It needs more work
than just making it compile. It needs to be brought up to HEAD of
mainline standard, which often nearly ends in a re-write.

> > > +	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > > +	if (IS_ERR(fep->clk_ipg))
> > > +		fep->clk_ipg = NULL;  
> > 
> > Why?
> 
> I will update the code.

FYI: NULL is a valid clock. But do you actually want _optional()?

This is the sort of thing a 10 year old codebase will be missing, and
you need to re-write. You might also be able to use the clk _bulk_
API?

	Andrew

