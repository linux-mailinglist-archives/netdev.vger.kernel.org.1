Return-Path: <netdev+bounces-103870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E599909E71
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92883281487
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5411CAB;
	Sun, 16 Jun 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ibx6coRh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493FADDAB;
	Sun, 16 Jun 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554556; cv=none; b=BoAklj6TOZzJrGPilw8XynO82WGcW7z0ueDrLZ209mBZYSVKMrWClcZ7URviO0spMh1VgWargpMPIvuo7FufkjQIlef7D2yg5Lsf9+nM0FrTgOTpea0Qc7oWubLJC6SCA4/aIixHKkM8/dm8mAhqbpL7d1zBSs+tqPxsW+yUS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554556; c=relaxed/simple;
	bh=TUsATysmdrlJFnEcVyb09WxWXOukeW5xaFd/AodO77I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+QvQPq7a9XlWl+FfLp58Uxu1zKsnXxVtMkArZWDOLfHnopSAR3dzN9ylyHyVd011leEus+esYnijEMGXGxIBaMMOLPFPpvkBfqUOpgCzeGWaKr9qdAWNxdPelS70H6ZbFZG84ff2u3VYAmt5YvYN4MihSfxN7AkZ4oUHssZX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ibx6coRh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DI8ao85LkW0rGY8C34vKTHTfc1vvHRa0HNhrgN4f+Qs=; b=Ibx6coRhBdGtgLYoRkBMnNKLGC
	GbXU88eI/XDtIAVwIcgUb97faEjw0h113h7HrNpY7JgR6yHrS0YMzOxVRy/NDsQLQcjRbYCwcS2vW
	sqa5ny+e8ipXy8qRTwBteJo11z1h0Z9oqVQbtKyFLMnHffAlXBbQo6LQDHnxnPzuZIEFBrOp6Meuw
	7d2qG7pvj+3vIcOGglstX2XprraTZPHZcG+0DFc9L3ZoUGZGfhD3F0xWXAwM1LpZdLFbSEpSpSXR6
	yv2yMXt+flz4K7vKGH+sTF7qvg/M/QXPvl/MB+3ri2ZLmg3Poei/L3xuexFgoAKO0jMMhFcDICvhl
	GmESJctQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56890)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sIsXf-0004F3-0p;
	Sun, 16 Jun 2024 17:15:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sIsXg-00047j-Vn; Sun, 16 Jun 2024 17:15:45 +0100
Date: Sun, 16 Jun 2024 17:15:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <Zm8PsLcoccsezveh@shell.armlinux.org.uk>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
 <20240607071836.911403-6-maxime.chevallier@bootlin.com>
 <20240613182613.5a11fca5@kernel.org>
 <20240616180231.338c2e6c@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616180231.338c2e6c@fedora>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jun 16, 2024 at 06:02:31PM +0200, Maxime Chevallier wrote:
> Hello Jakub,
> 
> On Thu, 13 Jun 2024 18:26:13 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Fri,  7 Jun 2024 09:18:18 +0200 Maxime Chevallier wrote:
> > > +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> > > +			struct nlattr *phy_id;
> > > +
> > > +			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
> > > +			phydev = phy_link_topo_get_phy(dev,
> > > +						       nla_get_u32(phy_id));  
> > 
> > Sorry for potentially repeating question (please put the answer in the
> > commit message) - are phys guaranteed not to disappear, even if the
> > netdev gets closed? this has no rtnl protection
> 
> I'll answer here so that people can correct me if I'm wrong, but I'll
> also add it in the commit logs as well (and possibly with some fixes
> depending on how this discussion goes)
> 
> While a PHY can be attached to/detached from a netdevice at open/close,
> the phy_device itself will keep on living, as its lifetime is tied to
> the underlying mdio_device (however phy_attach/detach take a ref on the
> phy_device, preventing it from vanishing while it's attached to a
> netdev)
> 
> I think the worst that could happen is that phy_detach() gets
> called (at ndo_close() for example, but that's not the only possible
> call site for that), and right after we manually unbind the PHY, which
> will drop its last refcount, while we hold a pointer to it :
> 
> 			phydev = phy_link_topo_get_phy()
>  phy_detach(phydev)
>  unbind on phydev
> 			/* access phydev */
> 			
> PHY device lifetime is, from my understanding, not protected by
> rtnl() so should a lock be added, I don't think rtnl_lock() would be
> the one to use.

... and that will cause deadlocks. For example, ethernet drivers can
call phy_disconnect() from their .ndo_close method, which will be
called with the RTNL lock held. This calls phy_detach(), so
phy_detach() also gets called while the RTNL lock is held.

SFP will call all phylib methods while holding the RTNL lock as well
(because that's the only safe way to add or remove a PHY, as it stops
other changes to the config that may conflict, and also ensures that
e.g. paths in phylib will not be in-use when the PHY is being
destroyed.)

So, rather than thinking that phylib should add RTNL locking, it
would be much more sensible to do what phylink does, and enforce
that the RTNL will be held when netdev related methods are called,
but also require that paths that end up changing phylib's configuration
(e.g. removing a PHY driver) end up taking the RTNL lock - because
that is the only way to be sure that none of the phylib methods
that call into the driver are currently executing in another thread.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

