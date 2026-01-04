Return-Path: <netdev+bounces-246819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F4140CF151D
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD9683009ABE
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4427B50F;
	Sun,  4 Jan 2026 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gxUkyiNF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772921ABD7;
	Sun,  4 Jan 2026 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767561799; cv=none; b=QxiS5LHX5ztdz7TSUzGQe6DCtBIIyrpUOgXeL/GjZEA1JiZI4qcdGER2R0nb8oQYsArFy/pf7NTRLrFTIOfqsH9H79gkiyfThI6aUvm6kMafTfqSVjvHppk1mxkMX6cAcccCRzfcfVbeBzE7f402Qx2vLikveHPmGEG+2QOUOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767561799; c=relaxed/simple;
	bh=JvKLm7SxY/487LdlDUqir9gQ8vgtq+Nw3fZXhEywMqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go93EmAMGMD3KwMtGSYlEWdd+YvqV7pML4F7ShnEU8Qymci2+1BiKqD3UTJsumXJuivWt23RUqX/KBD77ZOw6xZc59N7NdGjwmOgXjykakDv153U5dn1uI58roHXDoZ/zcZ6vJvcOdIkqBh26GIJkb6gnzayYvQhZdLxydpPydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gxUkyiNF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JWXzWEM6DZS5/8F6y4udugQty6s+3ySoXgmatnxm7jc=; b=gxUkyiNF+fgSJTzVUKd/hWeFhS
	yYSPkNj2X3R/oDjzZwoC9d5juHom8fGQ/Y6xUkSJM1/CkmMOiBG08Sm3H7mzMe4iypN1j+Nf19r7d
	ub4fd0fWJMDTwn2+bP6te2JB9n0QQhgKoZ2GfRqfgoGEoy20d4ghUTukITYee4GQ0dtbBcyJQKRLF
	pZNwsYh3xT8swfApki7B7cC/caK3Mdc1RRSQ/JJmAi6jtBYMcJUeEqB9Zx3kVpqnYgO2v/kUuEM6P
	SSrASJa/oY/96o9U0nlnh6s2Hs46StYwg+AjycJSCaB70XwPkfr5xVF3d42kau/Au0B378oiLHXNk
	86ioQqPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vcVZ4-000000007LG-3dFo;
	Sun, 04 Jan 2026 21:23:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vcVYz-000000007Er-0HaI;
	Sun, 04 Jan 2026 21:23:01 +0000
Date: Sun, 4 Jan 2026 21:23:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
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
Message-ID: <aVraNHPA3IzsEF9R@shell.armlinux.org.uk>
References: <cover.1767531485.git.daniel@makrotopia.org>
 <d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 04, 2026 at 01:12:13PM +0000, Daniel Golle wrote:
> +static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
> +{
> +	int oldpage, ret, read_ret;
> +	u16 page;
> +
> +	/* Use Clause-45 bus access in case it is available */
> +	if (phydev->is_c45)
> +		return __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
> +					  devnum, mmdreg);
> +
> +	/* Use indirect access via MII_MMD_CTRL and MII_MMD_DATA for all
> +	 * MMDs except MDIO_MMD_VEND2
> +	 */
> +	if (devnum != MDIO_MMD_VEND2) {
> +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> +				MII_MMD_CTRL, devnum);
> +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> +				MII_MMD_DATA, mmdreg);
> +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> +				MII_MMD_CTRL, devnum | MII_MMD_CTRL_NOINCR);
> +
> +		return __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
> +				       MII_MMD_DATA);
> +	}

I think I'd prefer this structure:

	if (devnum != MDIO_MMD_VEND2)
		return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
				    phydev->is_c45, devnum, regad);

	if (phydev->is_c45)
		return __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
					  devnum, mmdreg);

rather than open-coding the indirect access, or the reverse order with
mmd_phy_read() called with is_c45 set to false.

Same for the write function.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

