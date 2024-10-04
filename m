Return-Path: <netdev+bounces-132167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC89909DC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0C6B25004
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C441D9A71;
	Fri,  4 Oct 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="daUGP8qd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA441D9A63;
	Fri,  4 Oct 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061370; cv=none; b=WLm+nTR+AOx4tR2xBgF4nyDVNemwvkt0ZDnPKEM+XnCKUGHfIk0t3h16Tv/VdfEwxzGTtjoUZnYC7j0gs/vRn38qFPetTmy0wdOgBM0neufOrLvp5ZwnZj2US/BQ/h4ppr+MYgV4TI1OH4q+89NHqO8fANRWGnNlhLwAoypsGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061370; c=relaxed/simple;
	bh=JI8YuQMaqBM0wtwdfwTzVoM+Mq7BIGqawvEHDXOhYFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1iTBL3ho4IfIAadmtMZV7f7touu12jZcnNzMRjdaskeeSZRqAur/6NpsPtF2/RrdsA1L4s0VnmMeFBuZXsTnC+LOblCh+qrppFRPOg66dM64gSx3LBIP0Y5aSUWlDOlggBTG52AD/jRvb2r7iGCpy4NqqNG6pQGxZ6nWiguK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=daUGP8qd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r7K5K/qZvjgIES+9JYIIHa7wXSVw+xS1RUWhZQdScQs=; b=daUGP8qdLRq371XdEShyVcnIgH
	Pf2bscR0Nb6nXVatopZRGBuDWqlPpqwDO9/Nb4kviP+OqEPYGIKYz/FgXrOqJ2s3y8dq4LYpK1qHc
	mNzujeLtirLaws3pks6IL9xlZ10Vq3OsN2LQD7ZQu9yn5cZNJsWlnZvzVdxQHJRxcNnGLvC+m37xQ
	g/E++jKdUytUTl8V7mH+rNcioumMiLaJDnLO/PYYiFnCe7njDPffwk3wOl6W+ds+OsxkAuHW0JUjV
	1GMZIyfw1oj4Ouw6Mrj7MpTIMJegnXLnbE0lII6gCqBoJ9p3jnFXIeWZlrM6Yss/F9V8wSzdHmqd8
	FuS/39jA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51482)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swlhK-0002K5-25;
	Fri, 04 Oct 2024 18:02:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swlhB-0001KJ-33;
	Fri, 04 Oct 2024 18:02:26 +0100
Date: Fri, 4 Oct 2024 18:02:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 0/9] Allow isolating PHY devices
Message-ID: <ZwAfoeHUGOnDz1Y1@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

I'm going to ask a very basic question concerning this.

Isolation was present in PHYs early on when speeds were low, and thus
electrical reflections weren't too much of a problem, and thus star
topologies didn't have too much of an effect. A star topology is
multi-drop. Even if the PCB tracks go from MAC to PHY1 and then onto
PHY2, if PHY2 is isolated, there are two paths that the signal will
take, one to MAC and the other to PHY2. If there's no impediance match
at PHY2 (e.g. because it's in high-impedance mode) then that
transmission line is unterminated, and thus will reflect back towards
the MAC.

As speeds get faster, then reflections from unterminated ends become
more of an issue.

I suspect the reason why e.g. 88x3310, 88E1111 etc do not support
isolate mode is because of this - especially when being used in
serdes mode, the topology is essentially point-to-point and any
side branches can end up causing data corruption.

So my questions would be, is adding support for isolation mode in
PHYs given todays network speeds something that is realistic, and
do we have actual hardware out there where there is more than one
PHY in the bus. If there is, it may be useful to include details
of that (such as PHY interface type) in the patch series description.

On Fri, Oct 04, 2024 at 06:15:50PM +0200, Maxime Chevallier wrote:
> Hello,
> 
> This is the V2 of a series to add isolation support for PHY devices.
> 
> As a remainder, this mode allows a PHY to set its MII lines in
> high-impedance mode to avoid interferences on this bus.
> 
> So far, I've identified that :
> 
>  - Marvell 88e1512 isolation works fine
>  - LXT973 claims to support isolation, but it's actually broken
>  - Marvell 88x3310 doesn't support isolation, by design
>  - Marvell 88e1111 claims to support isolation in GMII, RGMII, TBI
>    (untested) but doesn't in SGMII (tested).
> 
> Changes in V2 :
> 
>  - Removed the loopback mode that was included in the first iteration
>  - Added phy_shutdown, to make sure we de-isolate the PHY when rebooting
>  - Changes the "PHY_NO_ISOLATE" flag to a phy driver ops. Testing showed
>    that some PHYs may or may not support isolation based on the
>    interface that's being used.
>  - Added isolation support reporting for the Marvell 88e1111 PHY.
> 
> V1 : https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/
> 
> Maxime Chevallier (9):
>   net: phy: allow isolating PHY devices
>   net: phy: Introduce phy_shutdown for device quiescence.
>   net: phy: Allow PHY drivers to report isolation support
>   net: phy: lxt: Mark LXT973 PHYs as having a broken isolate mode
>   net: phy: marvell10g: 88x3310 and 88x3340 don't support isolate mode
>   net: phy: marvell: mv88e1111 doesn't support isolate in SGMII mode
>   net: phy: introduce ethtool_phy_ops to get and set phy configuration
>   net: ethtool: phy: allow reporting and setting the phy isolate status
>   netlink: specs: introduce phy-set command along with configurable
>     attributes
> 
>  Documentation/netlink/specs/ethtool.yaml     |  15 +++
>  Documentation/networking/ethtool-netlink.rst |   1 +
>  drivers/net/phy/lxt.c                        |   2 +
>  drivers/net/phy/marvell.c                    |   9 ++
>  drivers/net/phy/marvell10g.c                 |   2 +
>  drivers/net/phy/phy.c                        |  44 ++++++++
>  drivers/net/phy/phy_device.c                 | 101 +++++++++++++++++--
>  include/linux/ethtool.h                      |   8 ++
>  include/linux/phy.h                          |  42 ++++++++
>  include/uapi/linux/ethtool_netlink.h         |   2 +
>  net/ethtool/netlink.c                        |   8 ++
>  net/ethtool/netlink.h                        |   1 +
>  net/ethtool/phy.c                            |  68 +++++++++++++
>  13 files changed, 297 insertions(+), 6 deletions(-)
> 
> -- 
> 2.46.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

