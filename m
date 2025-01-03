Return-Path: <netdev+bounces-154987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F013A0090B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908471883937
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7801F9A9F;
	Fri,  3 Jan 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o4RSHbrD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC081B4148
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906133; cv=none; b=YJH3bwGiOIHKxgxcn89HctNYwCvUbz3EPM8HWQ4GVxRXaipebgJ+nNd6p+Uwrs4a2weJBP1oOkkdcXcE+d9uLE2nfowAr4B1O5LWLfNoBdNMl3Jw6BvX8PB9Jq4MWNtD8RZrv/IrGxoVMyYCoEOLziRIP9CFqwm62DgeqctSibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906133; c=relaxed/simple;
	bh=pLlvf0yV7i7BTTXgwnpmluxd8zD3zKRP+NCSV6/gbzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfUoLaatJJiD/2mnYwulF5RtwyiUj9Rzpwk85co6Ke5jJ4Z88JDGRQ7hzXClOkWs0bmEnKLhy1aJcbYCdYQ7kIkh1cgIjJnhdArSo6VHmyF5HUOKsc7u17FRLIDwq2c+5jbiReyDpnGpjE35FIUZAGDf7Y+iQYp/Uox7smOZ9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o4RSHbrD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W7ubJJ5JdVcAnycSsSjaA9h1rXvZxH6KRRM03TJoJhc=; b=o4RSHbrDoOsU1g/HtIE7bD53zk
	Y/Q3rF3GMvXEUunaVYBnyFei8W6S45IgamoVSWPNlE+q7AotuA0MOV49aBh3wvNKjwuwhMI4m6A/C
	zb3H7i8Q1lBMV7ibe/ZyQFTk28FXwcoFmggrn3XzjqvypUkXaABzZ6iNmmbh+qO2/JXQVuGN9aV/i
	UxwITgx2hXLEa4sqjkkuERuJzwRsTzO11Y+UTkRnvW7mcfoqwr/iHx5YBzeeWOQt2rFHyh163ci5Y
	94AyLkkI0TbThQXTbMhIhFYJKuiCoJKuDafQVHSeEhyE0od3LN28qhmzoSknu37DKO+Kx4ryU81Xy
	DAUaxQpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTgTt-00034t-2E;
	Fri, 03 Jan 2025 12:08:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTgTr-0001IT-2f;
	Fri, 03 Jan 2025 12:08:43 +0000
Date: Fri, 3 Jan 2025 12:08:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Niklas Cassel <cassel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Francesco Valla <francesco@valla.it>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <Z3fTS5hOGawu18aH@shell.armlinux.org.uk>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
 <Z3fJQEVV4ACpvP3L@ryzen>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3fJQEVV4ACpvP3L@ryzen>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 03, 2025 at 12:25:52PM +0100, Niklas Cassel wrote:
> I'm trying to enable async probe for my PCIe controller (pcie-dw-rockchip),
> which on the radxa rock5b has a RTL8125 NIC connected to it.
> 
> By enabling async probe for the PCIe driver I get the same splat as Francesco.
> 
> Looking at the prints, it is trying to load a module for PHY ID: 0x1cc840
> This PHY ID is defined in: drivers/net/phy/realtek.c.
> 
> Looking at my .config I have:
> CONFIG_REALTEK_PHY=y
> 
> So this is not built as a module, so I am a bit surprised to see this
> splat (since the driver is built as built-in).
> 
> 
> I think it would be nice if the phylib core could be fixed so that
> it does not try to load modules for drivers which are built as built-in.
> 
> 
> Also see this old thread that tries to enable async probe by default on
> DT systems:
> https://lore.kernel.org/linux-kernel//d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com/T/#u
> 
> AFAICT, it seems that the phylib core is one of the biggest blockers from
> being able to enable async probe by default on DT systems.

Yes, we accept that phylib is incompatible with async probing. I don't
think that's going to change, because it's fundamentally baked in with
the way the whole fallback driver stuff works.

We *certainly* don't want to move the request_module() into
phy_attach*() (which is the point where we require the driver to be
bound or we fallback to the generic feature-reduced driver). First,
that *will* break SFP modules, no ifs or buts.

Second, moving it there would mean calling request_module() in many
cases with the RTNL held, which blocks things like new connections
network establishing while the module is requested (I've run into this
problem when the TI Wilink driver locks up holding the RTNL lock making
the platform impossible to remotely resolve if there isn't an already
open SSH connection.) We certainly don't want userspace to be doing
stuff while holding the "big" RTNL that affects much of networking.

Third, I suspect phylib already has a race between the PHY driver /
driver core binding the appropriate driver and phy_attach_direct()
attaching the fallback generic driver to the driverless PHY device,
and making this more "async" is going to open that race possibly to
the point where it becomes a problem. (At the moment, it doesn't
seem to cause any issue, so is theoretical right now - but if one
reads the code, it's obvious that there is no locking that prevents
a race there.)

What saves phylib right now is that by issueing the request_module(),
that will wait for the module to be loaded and initialised. The
initialisation function will register the PHY drivers in this module.
As this is synchronous, it will happen before request_module() returns,
and thus before phy_device_create() returns. Thus, if there is a module
available for the PHY, it will be loaded and available to be bound
to the PHY device by the time phy_device_register() is called. This
ensures that - in the case of an auto-loaded module, the race will
never happen.

Yes, it's weak. A scenario that could trigger this is loading PHY
driver modules in parallel with a call to the phy_attach*() functions,
e.g. when bringing up a network interface where the network driver
calls through to phy_attach*() from its .ndo_open() method. If we
simply make phylib's request_module() async, then this race will be
opened for auto-loaded modules as well.

Closing this race to give consistent results is impossible, even if
we add locking. If phy_attach*() were to complete first, the generic
driver would be used despite the PHY specific driver module being
loaded. Alternatively, if the PHY specific driver module finishes
being loaded before phy_attach*() is called, then the PHY specific
driver will be used for the device. So... it needs to be synchronous.

I also don't think "make a list of built-in drivers and omit the
request module" is an acceptable workaround - it's a sticky plaster
for the problem. If the PHY driver isn't built-in, then you have the
same problem with request_module() being issued. You could work around
that by ensuring that the PHY driver is built-in, but then we're
relying on multiple different things all being correct in diverse
areas, which is fragile.

All in all, I don't see at the moment any simple way to make phylib
async-probe compatible.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

