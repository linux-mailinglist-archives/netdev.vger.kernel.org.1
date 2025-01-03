Return-Path: <netdev+bounces-154994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AFA0097A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F123A4090
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1481ACA;
	Fri,  3 Jan 2025 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoXJRa+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B117FE
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908574; cv=none; b=NmBtNyQqOazMqwi8mcikEypqBG3C+mB272oeNkmivk3SdROQyvIb43BCCskpU1Dxp2IeusObps2TsfX7NpDv/Kja0x55FOyePuBQYpkuaZ4J+Rn0o+8Va9mAu2EUIayiOksPnxsNQo4typxV+xbHvq3BBDAhPOxj9czZVzjBrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908574; c=relaxed/simple;
	bh=7MRQJGBiUBCzLqnvCFabIBG8fZhV46yIYuerOdSsBuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDncOZrKzRbEn0Pl6cuxMd6KD8Rw8cdoTHrYkGJLEX5ARkObRxVrX9np3AAe1zK18O+IfF9NZCLhz4FAUR+vwMHURh+sbOYbL72IhTi8z6bBDcDZWCQ6PfN4LWwd+IwlTU4TbumMgTSb+VbP4fr8d6ulxPNBTT2fNn1CzkmOeQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoXJRa+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BB3C4CEDD;
	Fri,  3 Jan 2025 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735908574;
	bh=7MRQJGBiUBCzLqnvCFabIBG8fZhV46yIYuerOdSsBuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoXJRa+pU6CHt2lK8th/jEIOoCYCm7wYTRLN7Isp5pDmCWLNnwPbsMBZPcmzm4Q97
	 4QGTYV5FiA89ZqRdPJUiOGgXf5e3LSdDBCjVNmKx07fDP/BZiKxzU0KjvR6OfrgL3q
	 zeALEj10hSgxqiFaae5aUKrfmKgArm5SL+YxBawU0qUzlQKlZbvavGM53+bkPgvb26
	 Cf/eK8PGkkWOS7tfnq5OZl/VOoRaAWyTKVbur8r1fPbjj3r5yjA5GgMKX4SKDoNdm+
	 lsdJbecDvo762SrObd6KijNACdEPVxeRnP1yRKMreXRJ2IXE/FXhy/hS+6XL6entrd
	 kSzAA2vBD495Q==
Date: Fri, 3 Jan 2025 13:49:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Francesco Valla <francesco@valla.it>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <Z3fc2jiJJDzbCHLu@ryzen>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
 <Z3fJQEVV4ACpvP3L@ryzen>
 <Z3fTS5hOGawu18aH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3fTS5hOGawu18aH@shell.armlinux.org.uk>

On Fri, Jan 03, 2025 at 12:08:43PM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 03, 2025 at 12:25:52PM +0100, Niklas Cassel wrote:
> > I'm trying to enable async probe for my PCIe controller (pcie-dw-rockchip),
> > which on the radxa rock5b has a RTL8125 NIC connected to it.
> > 
> > By enabling async probe for the PCIe driver I get the same splat as Francesco.
> > 
> > Looking at the prints, it is trying to load a module for PHY ID: 0x1cc840
> > This PHY ID is defined in: drivers/net/phy/realtek.c.
> > 
> > Looking at my .config I have:
> > CONFIG_REALTEK_PHY=y
> > 
> > So this is not built as a module, so I am a bit surprised to see this
> > splat (since the driver is built as built-in).
> > 
> > 
> > I think it would be nice if the phylib core could be fixed so that
> > it does not try to load modules for drivers which are built as built-in.
> > 
> > 
> > Also see this old thread that tries to enable async probe by default on
> > DT systems:
> > https://lore.kernel.org/linux-kernel//d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com/T/#u
> > 
> > AFAICT, it seems that the phylib core is one of the biggest blockers from
> > being able to enable async probe by default on DT systems.
> 
> Yes, we accept that phylib is incompatible with async probing. I don't
> think that's going to change, because it's fundamentally baked in with
> the way the whole fallback driver stuff works.
> 
> We *certainly* don't want to move the request_module() into
> phy_attach*() (which is the point where we require the driver to be
> bound or we fallback to the generic feature-reduced driver). First,
> that *will* break SFP modules, no ifs or buts.
> 
> Second, moving it there would mean calling request_module() in many
> cases with the RTNL held, which blocks things like new connections
> network establishing while the module is requested (I've run into this
> problem when the TI Wilink driver locks up holding the RTNL lock making
> the platform impossible to remotely resolve if there isn't an already
> open SSH connection.) We certainly don't want userspace to be doing
> stuff while holding the "big" RTNL that affects much of networking.
> 
> Third, I suspect phylib already has a race between the PHY driver /
> driver core binding the appropriate driver and phy_attach_direct()
> attaching the fallback generic driver to the driverless PHY device,
> and making this more "async" is going to open that race possibly to
> the point where it becomes a problem. (At the moment, it doesn't
> seem to cause any issue, so is theoretical right now - but if one
> reads the code, it's obvious that there is no locking that prevents
> a race there.)
> 
> What saves phylib right now is that by issueing the request_module(),
> that will wait for the module to be loaded and initialised. The
> initialisation function will register the PHY drivers in this module.
> As this is synchronous, it will happen before request_module() returns,
> and thus before phy_device_create() returns. Thus, if there is a module
> available for the PHY, it will be loaded and available to be bound
> to the PHY device by the time phy_device_register() is called. This
> ensures that - in the case of an auto-loaded module, the race will
> never happen.
> 
> Yes, it's weak. A scenario that could trigger this is loading PHY
> driver modules in parallel with a call to the phy_attach*() functions,
> e.g. when bringing up a network interface where the network driver
> calls through to phy_attach*() from its .ndo_open() method. If we
> simply make phylib's request_module() async, then this race will be
> opened for auto-loaded modules as well.
> 
> Closing this race to give consistent results is impossible, even if
> we add locking. If phy_attach*() were to complete first, the generic
> driver would be used despite the PHY specific driver module being
> loaded. Alternatively, if the PHY specific driver module finishes
> being loaded before phy_attach*() is called, then the PHY specific
> driver will be used for the device. So... it needs to be synchronous.
> 
> I also don't think "make a list of built-in drivers and omit the
> request module" is an acceptable workaround - it's a sticky plaster
> for the problem. If the PHY driver isn't built-in, then you have the
> same problem with request_module() being issued. You could work around
> that by ensuring that the PHY driver is built-in, but then we're
> relying on multiple different things all being correct in diverse
> areas, which is fragile.

FWIW, the patch in $subject does make the splat go away for me.
(I have the PHY driver built as built-in).

The patch in $subject does "Add a list of registered drivers and check
if one is already available before resorting to call request_module();
in this way, if the PHY driver is already there, the MDIO bus can perform
the async probe."

Personally, I think this solution is better than keeping the status-quo.

If we take a buildroot kernel config for a specific board as an example,
they are very careful to always mark the NIC driver for the specific board
as built-in, such that the board can use nfsroot.
(Same logic can be applied to phylib driver.)

Having a solution similar to what is suggested in $subject would certainly
improve things for DT based systems.

Also note that arch/arm64/configs/defconfig marks a bunch of phylib drivers
as built-in.


Kind regards,
Niklas

