Return-Path: <netdev+bounces-246823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B25F0CF1646
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 23:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C7F630038DC
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3D24A066;
	Sun,  4 Jan 2026 22:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162F1C3BF7;
	Sun,  4 Jan 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767564166; cv=none; b=hDk1IqjoRrj8GuancqGCoK0ATA3uLe59zEoD3lh5kU9Pj/gfAzG7pCGylILf1/2fkpoJIsdai3AtiwezoMfxHKuDRGQnwHq0478LuQFiGN3PwNwnUmTVOtpuUjSjXEYxs568HLr9hOLsjPOkJ5oOXFIw9A3Vf9JZIXZoABbWbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767564166; c=relaxed/simple;
	bh=fDC11VwRkJLjbzxzLUsRls35EIJUuv2cAmOSyL0IOMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYpgnlIKr+nFkeoN7S04m7ZMOJGHWETI7fPdhykEaeWtCH945FCrFrZ4/WM4bJ/VK6ndaXr85mWju2BAeTCwZ6h4DHekUAeYcKezKl54JG2AApyxuMpAR2vFfWh3zM8QB5dYwfXxozyM/7j2SHhGHZXs/DXntJl2dyU41k5u2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcWBD-0000000054B-1xz7;
	Sun, 04 Jan 2026 22:02:31 +0000
Date: Sun, 4 Jan 2026 22:02:28 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: realtek: use paged access for
 MDIO_MMD_VEND2 in C22 mode
Message-ID: <aVrjdEVYCag4yKxg@makrotopia.org>
References: <cover.1767531485.git.daniel@makrotopia.org>
 <d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel@makrotopia.org>
 <aVraNHPA3IzsEF9R@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVraNHPA3IzsEF9R@shell.armlinux.org.uk>

On Sun, Jan 04, 2026 at 09:23:00PM +0000, Russell King (Oracle) wrote:
> On Sun, Jan 04, 2026 at 01:12:13PM +0000, Daniel Golle wrote:
> > +static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
> > +{
> > +	int oldpage, ret, read_ret;
> > +	u16 page;
> > +
> > +	/* Use Clause-45 bus access in case it is available */
> > +	if (phydev->is_c45)
> > +		return __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
> > +					  devnum, mmdreg);
> > +
> > +	/* Use indirect access via MII_MMD_CTRL and MII_MMD_DATA for all
> > +	 * MMDs except MDIO_MMD_VEND2
> > +	 */
> > +	if (devnum != MDIO_MMD_VEND2) {
> > +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> > +				MII_MMD_CTRL, devnum);
> > +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> > +				MII_MMD_DATA, mmdreg);
> > +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> > +				MII_MMD_CTRL, devnum | MII_MMD_CTRL_NOINCR);
> > +
> > +		return __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
> > +				       MII_MMD_DATA);
> > +	}
> 
> I think I'd prefer this structure:
> 
> 	if (devnum != MDIO_MMD_VEND2)
> 		return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
> 				    phydev->is_c45, devnum, regad);
> 
> 	if (phydev->is_c45)
> 		return __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
> 					  devnum, mmdreg);

Even this would be possible then:
	if (devnum != MDIO_MMD_VEND2 || phydev->is_c45)
		return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
				    phydev->is_c45, devnum, regad);

> 
> rather than open-coding the indirect access, or the reverse order with
> mmd_phy_read() called with is_c45 set to false.
> 
> Same for the write function.

I also thought it'd be good to do that, but that would require moving
the function prototypes from drivers/net/phy/phylib-internal.h to a
public header which the PHY driver may include, eg. phylib.h. (I suppose
that 'phylib-internal.h' should not be included in PHY drivers).

Needless to say that I also don't fancy open-coding unlocked variants
of phy_{read,write}_paged, but that's on a other story...

