Return-Path: <netdev+bounces-178644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6DA78046
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B14616E39A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ABB20D509;
	Tue,  1 Apr 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CWCcwtsc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750A1C860D;
	Tue,  1 Apr 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524074; cv=none; b=VoSgphLgbOJm6hnNY6K/psfZoaGFJJ1+f7n9IN/gfesLwK/IP0UVmsOCCplKwMQ12wK+tF5EkVHQaEl3t4Dn3obSVBpbc+3Xs2BmOwXe7J/Ny6tYZSy7r/cWL4iGYaKnvqARwt5ZP2bBsmTHipRGlmIHPn/WjIQbt4HGVdvONZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524074; c=relaxed/simple;
	bh=DDKt5Tf8tyOSWwo8RoxYUYaD1o7YgZ6YMlCzfiwEp4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJaGClV/hBSarx/dIBNHOf8W8KbV6dNkQaffkt2MlEgl+GtE1CWAmhRTxbLN4j5zCM2I+vjQ2N8BOoI0ccsdmM1zOamYqirCNoByveTG+9Tc0akczBk4FHcukJliZp2zzAeWqAAlzpFfVQUZuRy1AwNPjBKLtYMFmiKY5URss/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CWCcwtsc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DI/uIgABP4Y3ZOODtItV+UJ8AlzzvTWEXR4AkcopqNk=; b=CWCcwtscKHyCA2hRf538Qcm+I8
	QVyW0WYPTllm9WtlHc8zbFGk8laKuMFvGZYsXkYpHUhDFu720OkZjsyc2HTpJHVJLIbFA3+SF601V
	zQiuAaCWE1dW/WYu3tZTl9UACvLp8+TNU2gNlPY6boPIpHHgYyJPKsHVGFmO0A1Bm+P+QHKCgDjru
	NQZ++2IBzT8OE1ud0m22At/E4yhLg0sI2THUOYWRT1kz/GJ4hUjdfRe2DoD8AK/6v4mIZhmUiBsAZ
	9IWGfl9oNSVQs+1Bg32FRxcotQHx8v8lWboVrucTFSJKV9/1/8UexfP7KKh79CRMR+7QIX9WoXe8N
	c3jocreA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54120)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzeFk-0006b5-1R;
	Tue, 01 Apr 2025 17:14:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzeFg-0002pe-2a;
	Tue, 01 Apr 2025 17:14:12 +0100
Date: Tue, 1 Apr 2025 17:14:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <Z-wQ1Ml_9xNz0XtV@shell.armlinux.org.uk>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com>
 <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
 <20250328090621.2d0b3665@fedora-2.home>
 <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
 <20250331091449.155e14a4@fedora-2.home>
 <3517cb7b3b10c29a6bf407f2e35fdebaf7a271e3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3517cb7b3b10c29a6bf407f2e35fdebaf7a271e3.camel@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 01, 2025 at 08:28:29AM -0700, Alexander H Duyck wrote:
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 16a1f31f0091..380e51c5bdaa 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -713,17 +713,24 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>                 phylink_warn(pl, "fixed link specifies half duplex for %dMbps link?\n",
>                              pl->link_config.speed);
>  
> -       linkmode_zero(pl->supported);
> -       phylink_fill_fixedlink_supported(pl->supported);
> -
> +       linkmode_fill(pl->supported);
>         linkmode_copy(pl->link_config.advertising, pl->supported);
>         phylink_validate(pl, pl->supported, &pl->link_config);
>  
>         c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
>                             pl->supported, true);
> -       if (c)
> +       if (c) {
>                 linkmode_and(match, pl->supported, c->linkmodes);
>  
> +               /* Compatbility with the legacy behaviour:
> +                * Report one single BaseT mode.
> +                */
> +               phylink_fill_fixedlink_supported(mask);
> +               if (linkmode_intersects(match, mask))
> +                       linkmode_and(match, match, mask);
> +               linkmode_zero(mask);
> +       }
> +
>         linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
>         linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
>         linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);
> 
> Basically we still need the value to be screened by the pl->supported.
> The one change is that we have to run the extra screening on the
> intersect instead of skipping the screening, or doing it before we even
> start providing bits.
> 
> With this approach we will even allow people to use non twisted pair
> setups regardless of speed as long as they don't provide any twisted
> pair modes in the standard set.
> 
> I will try to get this tested today and if it works out I will submit
> it for net. I just need to test this and an SFP ksettings_set issue I
> found when we aren't using autoneg.

This code used to be so simple... and that makes me wonder whether
Maxime's work is really the best approach. It seems that the old way
was better precisely because it was more simple.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

