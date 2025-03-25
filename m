Return-Path: <netdev+bounces-177631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F81A70C33
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05167188E491
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A82641E2;
	Tue, 25 Mar 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1OQ2Bnfn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CE1D63C3;
	Tue, 25 Mar 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938621; cv=none; b=LQZ0EHBo6JjCxoUNX9gGddhYzqsW8X8n98bSFlqTst0LmTsdNjYGQDnmqkfk4hi3rSKHgKUCFY0aoNS1GYSiaP2kFpW6xgKTMBSHyiGioSdq2aJWPXNk727W4T1dLQ86cM+RXUb9+kvgb717UT4FfXn6IX0ACNT9GzcEUAwdBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938621; c=relaxed/simple;
	bh=2/1M932mU1A0AZHQ7vyHlBS2S3yOg/7oE9rkS/uRr0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcBc22QJXv87fGhgD8PsBjt4xbPR39qA2SfDs1IYra+8dqmUKybkQHxJntEzc7VSuoiOaxrYEq3u3nfevpIhxc1dNWFBLBqlSwbKjbZYLvV8NHBVMIiVOyzmmd/FHdjPEjYy7/8Oo1ZHJyVAEkhVQOpjMFJssAeZXqGysp6J7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1OQ2Bnfn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0QTN6QDlmYYgVLgvJxHB21xYBHnMylh4f403Qgri4zk=; b=1OQ2BnfnainpgtBvoNveaD8Gu0
	WkXDe3ptEF+K/hNyu5Gq7qatHvye0akJnQ8hXD2EIr2kUqsA2bdPIs8X9hPvyq/ns6My8wo/4PJ9/
	EucbjbYmqSDushfwBQwlN0/rDaguHbtq/esRk7AVgouybfaRykg9/ZjEXhnO3QSuOsZzgE4iqmcux
	bTyxmNNUEbjY6YWVGIh6ws8tTkmnotWzgi2vPmy2II7PvS/RnVW/AnjmKXn9gjYVFDTeQYoCsWaV7
	FRLoQmB/EYI1FhfSgU6c0RjmaFnjL+Yo2hbxMcF8ESLFMptfNXKueLYdi1W+JZM4y4GItoqthGliG
	Jo4DCP/A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54034)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txBx2-0005KJ-1G;
	Tue, 25 Mar 2025 21:36:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txBwz-0003f1-2Y;
	Tue, 25 Mar 2025 21:36:45 +0000
Date: Tue, 25 Mar 2025 21:36:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Message-ID: <Z-Mh7TlJgStma9ln@shell.armlinux.org.uk>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
 <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>
 <67e1692c.050a0220.2b4ad0.c073@mx.google.com>
 <a9abc0c6-91c2-4366-88dd-83e993791508@lunn.ch>
 <67e29bce.050a0220.15db86.84a4@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e29bce.050a0220.15db86.84a4@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 25, 2025 at 01:04:30PM +0100, Christian Marangi wrote:
> On Mon, Mar 24, 2025 at 04:16:09PM +0100, Andrew Lunn wrote:
> > On Mon, Mar 24, 2025 at 03:16:08PM +0100, Christian Marangi wrote:
> > > On Mon, Mar 24, 2025 at 03:03:51PM +0100, Andrew Lunn wrote:
> > > > > Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> > > > > AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> > > > > AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> > > > > before the firmware is loaded.
> > > > 
> > > > Does the value change after the firmware is loaded? Is the same
> > > > firmware used for all variants?
> > > >
> > > 
> > > Yes It does... Can PHY subsystem react on this? Like probe for the
> > > generic one and then use the OPs for the real PHY ID?
> > 
> > Multiple thoughts here....
> > 
> > If the firmware is in SPI, i assume by the time the MDIO bus is
> > probed, the PHY has its 'real' IDs. So you need entries for those as
> > well as the dummy ID.
> > 
> > I think this is the first PHY which changes its IDs at runtime. So we
> > don't have a generic solution to this. USB and PCI probably have
> > support for this, so maybe there is something we can copy. It could be
> > they support hotplug, so the device disappears and returns. That is
> > not really something we have in MDIO. So i don't know if we can reuse
> > ideas from there.
> > 
> > When the firmware is running, do the different variants all share the
> > same ID? Is there a way to tell them apart. We always have
> > phy_driver->match_phy_device(). It could look for 0x75007500, download
> > the firmware, and then match on the real IDs.
> 
> Ok update on this... The PHY report 7500 7500 but on enabling PTP clock,
> a more specific ""family"" ID is filled in MMD that is 0x7500 0x9410.
> 
> They all use the same firmware so matching for the family ID might not
> be a bad idea... The alternative is either load the firmware in
> match_phy_device or introduce some additional OPs to handle this
> correctly...
> 
> Considering how the thing are evolving with PHY I really feel it's time
> we start introducing specific OP for firmware loading and we might call
> this OP before PHY ID matching is done (or maybe do it again).

You're basically talking there about modifying the core driver model of
the kernel, which I think you're going to have an uphill battle with.

The match_phy_device() op is called by the core driver model when a new
device/driver is added to find a driver for an unbound device. It does
this calling the bus_type's .match() method for each unbound device
on the bus_type, and every device driver that is bound to the bus type.

In the case of a MDIO device, which phylib's PHYs are a sub-class of,
this is populated with mdio_bus_match(), which then goes on to call
the MDIO device's ->bus_match() method. For a PHY, that's
phy_bus_match(), which will either call the PHY driver's
.match_phy_device() method or will attempt to match the hardware ID
against what is given in the PHY driver structure.

So, the core driver model is responsible for trying each device driver
on the bus to find one that matches each device. This isn't a phylib
thing.

At the moment, I don't see how adding another PHY driver OP helps. We
still need to find the right PHY driver struct somehow. It seems to me
to be a chicken-and-egg problem.

That's why I suggested that maybe board firmware should be loading at
least _some_ kind of firmware to get the PHY to the point that the
kernel can properly identify it - the kernel can then read the
loaded firmware, compare it with the version that's locally available,
and if different, replace the firmware. The main thing is that board
firmware gets the PHY to the point that it can be properly identified.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

