Return-Path: <netdev+bounces-179080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC1A7A809
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30C51899959
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291A197A67;
	Thu,  3 Apr 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pYznLQ/z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEE1514F6
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698070; cv=none; b=kU2e8cnPpfM5ToWtsV2J3RtNO8uDR6b/JXpBX2r1xLIlVUUMEVsQDAXnEpxqjoAnzYLehQQ3vWGVGSbfa1hg9A0AnrFluLisTiGzx5CDiLenoe6MkuPAV7+bq72kNQXN+g7HSjPVK+2SgONaHVbRKSaUUr8eRuZO8/Itr5nfrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698070; c=relaxed/simple;
	bh=/JKkF/4tlsH3YpoGhj4dX0fQXSnm2JrK4AAa3GFcMCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKYN6Pcxb7sS/5NWjuXc/dLuq6geb2Yyw6ykBZ6HBfV68EtDBmNo3lpUULhu4ymfmdANqWdPT+NKFdTDxrAjcCiIsRAijT2oqBGaoblz4doAyxIWr32c4CXKF5AgIVUraGCMMTvu6OJrVnFp4pIY26seA/KbNz0k9VVrmjXt4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pYznLQ/z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bo8hBvzPUgGvYg48Gq2T3eVlxBQnNZO9FF+Xr9jomQ0=; b=pYznLQ/zfvUbzkPe4p5ZXG1/ll
	JnhRrFHhfJDkQOrX1ZxG4L4S7roA8mvuCQeIonKYVqhYUI8xT1kS01ux7kxs2Cc6gQGb7ZW7JX8E/
	Hf9+78GYuqEeUfO5etH6ZBhy3/jTcjigDbil7qW8RurDuRQ/J4lsXIbRr+qGMuSL2+08=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u0NWG-007yk4-MM; Thu, 03 Apr 2025 18:34:20 +0200
Date: Thu, 3 Apr 2025 18:34:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403172953.5da50762@fedora.home>

On Thu, Apr 03, 2025 at 05:29:53PM +0200, Maxime Chevallier wrote:
> On Thu, 3 Apr 2025 15:55:45 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Tue, Apr 01, 2025 at 02:30:06PM -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexanderduyck@fb.com>
> > > 
> > > The blamed commit introduced an issue where it was limiting the link
> > > configuration so that we couldn't use fixed-link mode for any settings
> > > other than twisted pair modes 10G or less. As a result this was causing the
> > > driver to lose any advertised/lp_advertised/supported modes when setup as a
> > > fixed link.
> > > 
> > > To correct this we can add a check to identify if the user is in fact
> > > enabling a TP mode and then apply the mask to select only 1 of each speed
> > > for twisted pair instead of applying this before we know the number of bits
> > > set.
> > > 
> > > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> > > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > > ---
> > >  drivers/net/phy/phylink.c |   15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > > index 16a1f31f0091..380e51c5bdaa 100644
> > > --- a/drivers/net/phy/phylink.c
> > > +++ b/drivers/net/phy/phylink.c
> > > @@ -713,17 +713,24 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> > >  		phylink_warn(pl, "fixed link specifies half duplex for %dMbps link?\n",
> > >  			     pl->link_config.speed);
> > >  
> > > -	linkmode_zero(pl->supported);
> > > -	phylink_fill_fixedlink_supported(pl->supported);
> > > -
> > > +	linkmode_fill(pl->supported);
> > >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> > >  	phylink_validate(pl, pl->supported, &pl->link_config);
> > >  
> > >  	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> > >  			    pl->supported, true);
> > > -	if (c)
> > > +	if (c) {
> > >  		linkmode_and(match, pl->supported, c->linkmodes);
> > >  
> > > +		/* Compatbility with the legacy behaviour:
> > > +		 * Report one single BaseT mode.
> > > +		 */
> > > +		phylink_fill_fixedlink_supported(mask);
> > > +		if (linkmode_intersects(match, mask))
> > > +			linkmode_and(match, match, mask);
> > > +		linkmode_zero(mask);
> > > +	}
> > > +  
> > 
> > I'm still wondering about the wiseness of exposing more than one link
> > mode for something that's supposed to be fixed-link.
> > 
> > For gigabit fixed links, even if we have:
> > 
> > 	phy-mode = "1000base-x";
> > 	speed = <1000>;
> > 	full-duplex;
> > 
> > in DT, we still state to ethtool:
> > 
> >         Supported link modes:   1000baseT/Full
> >         Advertised link modes:  1000baseT/Full
> >         Link partner advertised link modes:  1000baseT/Full
> >         Link partner advertised auto-negotiation: No
> >         Speed: 1000Mb/s
> >         Duplex: Full
> >         Auto-negotiation: on
> > 
> > despite it being a 1000base-X link. This is perfectly reasonable,
> > because of the origins of fixed-links - these existed as a software
> > emulated baseT PHY no matter what the underlying link was.
> > 
> > So, is getting the right link mode for the underlying link important
> > for fixed-links? I don't think it is. Does it make sense to publish
> > multiple link modes for a fixed-link? I don't think it does, because
> > if multiple link modes are published, it means that it isn't fixed.
> 
> That's a good point. The way I saw that was :
> 
>   "we report all the modes because, being fixed-link, it can be
>   any of these modes."
> 
> But I agree with you in that this doesn't show that "this is fixed,
> don't try to change that, this won't work". So, I do agree with you now.
> 
> > As for arguments about the number of lanes, that's a property of the
> > PHY_INTERFACE_MODE_xxx. There's a long history of this, e.g. MII/RMII
> > is effectively a very early illustration of reducing the number of
> > lanes, yet we don't have separate link modes for these.
> > 
> > So, I'm still uneasy about this approach.
> 
> So, how about extending the compat list of "first link of each speed"
> to all the modes, then once the "mediums" addition from the phy_port
> lands, we simplify it down the following way :
> 
> Looking at the current list of elegible fixed-link linkmodes, we have
> (I'm taking this from one of your mails) :
> 
> speed	duplex	linkmode
> 10M	Half	10baseT_Half
> 10M	Full	10baseT_Full
> 100M	Half	100baseT_Half
> 100M	Full	100baseT_Full
> 1G	Half	1000baseT_Half
> 1G	Full	1000baseT_Full (this changed over time)
> 2.5G	Full	2500baseT_Full
> 5G	Full	5000baseT_Full
> 10G	Full	10000baseCR_Full (used to be 10000baseKR_Full)
> 20G	Full	20000baseKR2_Full => there's no 20GBaseCR*
> 25G	Full	25000baseCR_Full
> 40G	Full	40000baseCR4_Full
> 50G	Full	50000baseCR2_Full
> 56G	Full	56000baseCR4_Full
> 100G	Full	100000baseCR4_Full
> 
> To avoid maintaining a hardcoded list, we could clearly specifying
> what we report in fixed-link :
> 
>  1 : Any BaseT mode for the given speed duplex (BaseT and not BaseT1)
>  2 : If there's none, Any BaseK mode for that speed/duplex
>  3 : If there's none, Any BaseC mode for that speed/duplex
> 
> That's totally arbitrary of course, and if one day someone adds, say,
> 25GBaseT, fixed-link linkmode will change. Another issue us 10G,
> 10GBaseT exists, but wasn't the first choice.

Maybe go back to why fixed-link exists? It is basically a hack to make
MAC configuration easier. It was originally used for MAC to MAC
connections, e.g. a NIC connected to a switch, without PHYs in the
middle. By faking a PHY, there was no need to add any special
configuration API to the MAC, the phylib adjust_link callback would be
sufficient to tell the MAC to speed and duplex to use. For {R}{G}MII,
or SGMII, that is all you need to know. The phy-mode told you to
configure the MAC to MII, GMII, SGMII.

But things evolved since then. We started having PHYs which change
their host side depending on their media side. SGMII for <= 1G,
2500BaseX, 5GBaseX, 10GBaseX. It became necessary for the adjust_link
callback to look at more than just the speed/duplex, it also needed to
look at the phy_interface_t. phy-mode looses its meaning, it might be
considered the default until we know better.

But consider the use case, a hack to allow configuration of a MAC to
MAC connection. The link mode does not change depending on the media,
there is no media. The switch will not be changing its port
configuration. The link really is fixed. phy-mode tells you the basic
configuration, and then adjust_link/mac_link_up tells you the
speed/dupex if there are multiple speeds/duplex supported,
e.g. RGMII/SGMII.

What Alex is trying to do is abuse fixed link for something which is
not a MAC-MAC connection, something which is not fixed. Do we want to
support that?

	Andrew

