Return-Path: <netdev+bounces-169872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC590A46195
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA07F1887132
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5318DB27;
	Wed, 26 Feb 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eDzRA9aG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03448192D63;
	Wed, 26 Feb 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578532; cv=none; b=Dy41ZWtqhlDiJFl5GPOZEiG1H0yPZVm5JqAlCLCPVX/IzxhmHNXNfNCtOxC1Irt6omw8VNwWNFqncMGlEbwRtUZNQeAK77/ygpEVCWXLroe2Fpf+nGyKvL723Wi5rUAbLd4Y1Xfrj66OTJwbrWvhIudhldqgxsj9PhiVu6f0kYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578532; c=relaxed/simple;
	bh=fa/1P7ogjNcW9edAeSgAD7fMtt8lrWug2G/rwmhqosI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKJDG2pM9z0K0aP/Oye2+h1yLM+XjLUjwtfTfji+Umy58Y+t3Utb0QD3Q9TMNkcp++j2IHLmvc/UwwGq4sR1m70rOxyr0yozE3xGV/GMJrhpHuHnFJ7cnMX8fE1z0E3YxqQO30dCLTx5iSVWrLC9MYpvKg78mFVy8/QL2bp9KJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eDzRA9aG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y5HzTLv7sfh35EQ2e6vDNCEEGGk0nP1LY8agEPskJ2I=; b=eDzRA9aG3dT4rI9lZkaMzOrjmZ
	rv+C9d15o3IJ3+YtPHUnTHtWlK8hAESaVfGfspCo975JDCmV933K8L7yqpkpuIQGH2gWjQG9ewtPV
	YwtyJzU3OShw94RtyU2yApCNZ8C/kCh0AcduQYQP0CNK74cLRzN1uW2ebUwfOTChvcA102kfx7AkV
	zH64ql/uIcsoXQDW5Xs9n1hDWlUmHrnGSivSXOOMIsFQ8wDIcooZvfUgY3MlVMeq2m/XgchSRV8a1
	u2N5xutn/cXHlqVmuQkojsEy8VVnPTrkuSy7U8uE3eSRGSZi3c3GvwSts6+EDiRi/DIdtdbQmc87h
	4//QnB4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58138)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnHz6-0004Pb-13;
	Wed, 26 Feb 2025 14:02:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnHz3-00078s-0d;
	Wed, 26 Feb 2025 14:01:57 +0000
Date: Wed, 26 Feb 2025 14:01:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v2 09/13] net: phy: phylink: Use phy_caps_lookup
 for fixed-link configuration
Message-ID: <Z78e1dmEuQzMER5L@shell.armlinux.org.uk>
References: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
 <20250226100929.1646454-10-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226100929.1646454-10-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Please use a subject line of "net: phylink: " for phylink patches, not
"net: phy: " which is for phylib.

On Wed, Feb 26, 2025 at 11:09:24AM +0100, Maxime Chevallier wrote:
> When phylink creates a fixed-link configuration, it finds a matching
> linkmode to set as the advertised, lp_advertising and supported modes
> based on the speed and duplex of the fixed link.
> 
> Use the newly introduced phy_caps_lookup to get these modes instead of
> phy_lookup_settings(). This has the side effect that the matched
> settings and configured linkmodes may now contain several linkmodes (the
> intersection of supported linkmodes from the phylink settings and the
> linkmodes that match speed/duplex) instead of the one from
> phy_lookup_settings().
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V1 -> V2: - fixed pl->link_config.lp_advertising setting
> 
>  drivers/net/phy/phylink.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 6c67d5c9b787..63fbf3d8708a 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -805,9 +805,10 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
>  static int phylink_parse_fixedlink(struct phylink *pl,
>  				   const struct fwnode_handle *fwnode)
>  {
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(match) = { 0, };
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
> +	const struct link_capabilities *c;
>  	struct fwnode_handle *fixed_node;
> -	const struct phy_setting *s;
>  	struct gpio_desc *desc;
>  	u32 speed;
>  	int ret;
> @@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  	linkmode_copy(pl->link_config.advertising, pl->supported);
>  	phylink_validate(pl, pl->supported, &pl->link_config);
>  
> -	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
> -			       pl->supported, true);
> +	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> +			    pl->supported, true);
> +	if (c)
> +		linkmode_and(match, pl->supported, c->linkmodes);

What's this for? Surely phy_caps_lookup() should not return a link mode
that wasn't in phy_caps_lookup()'s 3rd argument.

Otherwise...

>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
> @@ -889,9 +892,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  
>  	phylink_set(pl->supported, MII);
>  
> -	if (s) {
> -		__set_bit(s->bit, pl->supported);
> -		__set_bit(s->bit, pl->link_config.lp_advertising);
> +	if (c) {
> +		linkmode_or(pl->supported, pl->supported, match);
> +		linkmode_or(pl->link_config.lp_advertising,
> +			    pl->link_config.lp_advertising, match);
>  	} else {
>  		phylink_warn(pl, "fixed link %s duplex %dMbps not recognised\n",
>  			     pl->link_config.duplex == DUPLEX_FULL ? "full" : "half",
> @@ -1879,21 +1883,21 @@ static int phylink_register_sfp(struct phylink *pl,
>  int phylink_set_fixed_link(struct phylink *pl,
>  			   const struct phylink_link_state *state)
>  {
> -	const struct phy_setting *s;
> +	const struct link_capabilities *c;
>  	unsigned long *adv;
>  
>  	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
>  	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
>  		return -EINVAL;
>  
> -	s = phy_lookup_setting(state->speed, state->duplex,
> -			       pl->supported, true);
> -	if (!s)
> +	c = phy_caps_lookup(state->speed, state->duplex,
> +			    pl->supported, true);
> +	if (!c)
>  		return -EINVAL;
>  
>  	adv = pl->link_config.advertising;
>  	linkmode_zero(adv);
> -	linkmode_set_bit(s->bit, adv);
> +	linkmode_and(adv, pl->supported, c->linkmodes);

... this is wrong since this is basically doing the same as the above
parsing.

I'm not sure why you're generating different code for what is
essentially the same thing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

