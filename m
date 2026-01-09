Return-Path: <netdev+bounces-248306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97934D06BBE
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ADFD303D935
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27310224B05;
	Fri,  9 Jan 2026 01:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70B221282
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921976; cv=none; b=qmzVVhfmYQLcLjafgGcpz76cwLtn3zuZhuyiZU/KoKwUJvToBtKWorKDhuFdX3JUD8Ol8ihd+6HPeFeN4C5nEPmyAiorGiQdHUKKy0LNIenKbeqIToKNQtKCUW95F/RS7JHMAo8HTfPTEA3rUOa4MAVdn8fHFoICwBnKzNUmzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921976; c=relaxed/simple;
	bh=ngCJHs4Tkgj+8SqiZSKYoudkfAwAWhLY17nfHNKImJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+dWShpXO10ZGQ4+1hYMg1nsB/uWFCCW5Ruh8FFucevgmltXtQay5vSApI1jzFLI7UCUmTSA1IshGyszjKCYaTGhklFumeEORS1q8xtpAlHXzVppWVexYnGFTmuc6kQU/l8EEsBfadybuCsNmts+pO7G5GhxAzol2wtwU8sclQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1ve1GN-000000005Rl-2bex;
	Fri, 09 Jan 2026 01:26:03 +0000
Date: Fri, 9 Jan 2026 01:26:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
Message-ID: <aWBZKD32SEnZ-UUB@makrotopia.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <aWA2DswjBcFWi8eA@makrotopia.org>
 <aWA7tSjnH7Kr1GCk@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWA7tSjnH7Kr1GCk@google.com>

On Thu, Jan 08, 2026 at 11:20:21PM +0000, Fabio Baltieri wrote:
> On Thu, Jan 08, 2026 at 10:56:14PM +0000, Daniel Golle wrote:
> > > +static int rtlgen_sfp_read_status(struct phy_device *phydev)
> > > +{
> > > +	int val, err;
> > > +
> > > +	err = genphy_update_link(phydev);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (!phydev->link)
> > > +		return 0;
> > > +
> > > +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
> > 
> > This should be the same as
> > phy_read(phydev, MII_RESV2); /* on page 0 */
> > Please try.
> 
> Tried it on my setup, the two calls do indeed seem to return the same
> value.

Thank you for confirming that.

My understanding at this point is that only register 0x10 to 0x17 are
actually paged (ie. the 3 bits of freedom in the
RTL822X_VND2_TO_PAGE_REG apply to all pages), and that seems to apply for
all 1G, 2.5G and 5G (and 10G?) RealTek PHYs.

Hence we do not need to use paged register access for register 0x0...0xf
and 0x18..0x1e. And the paged operations we do have there right now can
all be described as registers on MDIO_MMD_VEND2. And maybe that's what
we should do then, implementing .read_mmd and .write_mmd similar to
rtl822xb_read_mmd and rtl822xb_write_mmd for all PHYs, with the only
difference that for older PHYs all MMDs other than MDIO_MMD_VEND2 have
to be emulated similar to rtlgen_read_mmd and rtl822x_read_mmd.

The current way we access MDIO_MMD_VEND2 on older PHYs also also fishy
as it depends on __mdiobus_c45_read as well as the PHY listening to the
broadcast address 0: Especially for 1GE PHYs not all MDIO controllers
are capable of Clause-45 access, and listening on address 0 works (at
best) if there is only one PHY in the bus doing that, and it can be
disabled via BIT(13) on PHYCR1. For internal PHYs of PCIe NICs this is
fine, of course, but for standalone PHYs not really.

tl;dr: drivers/net/phy/realtek/ has signed up for some serious
weight-loss program.

