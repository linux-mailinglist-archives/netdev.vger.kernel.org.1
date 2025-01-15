Return-Path: <netdev+bounces-158676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF05BA12F07
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 00:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC331885126
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9631DC98D;
	Wed, 15 Jan 2025 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iQCD4vlT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02011DAC80
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983191; cv=none; b=Uls5b+Scm/07stonxFJgFdhJrFeoIfmdUGUBwtg401QeissUpZNE/4zMM/wFsE2sOk59iU4ELig2dEY4mmDgSBTbsZZBcrxQ8Je8ahlf2hNMu8zZyHhWPOWH5fHY2HYAxA99aiBTT36MZX66sbQ6IczKXt0H4jSNc6ObEU883Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983191; c=relaxed/simple;
	bh=p4+iNVc4G6TzBV0xvJ7xDGW8eidOgTRGOr01bfblgQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI3he6IRRskwz8s6Wbc1x/klIpPqjvegx3KFEgl6k2iS+DrA5KsGnQCCEaBg8UrXFjfv9Z9qGlKE1B09SDlXvv4+rpbt6fF/pC4cR2ollsolwiq2LWXLomBisj7bdgAaOY2WiNY/mElaxMyOk9FScM6f2bWy1E7yYJqee38FfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iQCD4vlT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wmvzwPx1yuP8Lb7DWotr78caC6TZyBaL7S0p3kNvAdI=; b=iQCD4vlT5083I8Vbbv2TqcujwN
	Sin9GYL0NFocFcqIIc9x+Gx4wf2cp/j9EVc+iyMJUgJ/BLe+HQqD2lWLuZSuIv1ygsvsvcEIa4qbH
	NrPU1jPZMlDxM9QHSwRRsVBzGP58E9Uduw47ykB3MEvo24+/PFd3oOapUy1GhGE4rmOfCZlPxZ7TJ
	UyApxSmBjX4w1cUr7ZujX5ge9A5sqDXqpVhMeJJ/PN82BEOqOFEyo1HCrnO6LoZ0Dku5unZQFOT+Z
	fUgdgZkpgskUmX4B/eE++aAjyZE7u/5V70mvRDgUBTKG3pTqUIER2Xziplvy6VQwB4CUgVzIeFI5a
	7TOruj9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tYCfm-0001sq-1J;
	Wed, 15 Jan 2025 23:19:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tYCfk-0006ay-03;
	Wed, 15 Jan 2025 23:19:40 +0000
Date: Wed, 15 Jan 2025 23:19:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phylink: always do a major config when
 attaching a SFP PHY
Message-ID: <Z4hCiwfLL2q2rIMM@shell.armlinux.org.uk>
References: <E1tXhIJ-000me6-SA@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tXhIJ-000me6-SA@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi Eric,

I'd like to get a tested-by from you before sending this for merging,
as this should fix your reported issue.

Thanks.

On Tue, Jan 14, 2025 at 01:49:23PM +0000, Russell King (Oracle) wrote:
> Background: https://lore.kernel.org/r/20250107123615.161095-1-ericwouds@gmail.com
> 
> Since adding negotiation of in-band capabilities, it is no longer
> sufficient to just look at the MLO_AN_xxx mode and PHY interface to
> decide whether to do a major configuration, since the result now
> depends on the capabilities of the attaching PHY.
> 
> Always trigger a major configuration in this case.
> 
> Reported-by: Eric Woudstra <ericwouds@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> This follows on from https://lore.kernel.org/r/Z4TbR93B-X8A8iHe@shell.armlinux.org.uk "net: phylink: fix PCS without autoneg"
> 
>  drivers/net/phy/phylink.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index ff0efb52189f..7d64182cf802 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3412,12 +3412,11 @@ static phy_interface_t phylink_choose_sfp_interface(struct phylink *pl,
>  	return interface;
>  }
>  
> -static void phylink_sfp_set_config(struct phylink *pl,
> -				   unsigned long *supported,
> -				   struct phylink_link_state *state)
> +static void phylink_sfp_set_config(struct phylink *pl, unsigned long *supported,
> +				   struct phylink_link_state *state,
> +				   bool changed)
>  {
>  	u8 mode = MLO_AN_INBAND;
> -	bool changed = false;
>  
>  	phylink_dbg(pl, "requesting link mode %s/%s with support %*pb\n",
>  		    phylink_an_mode_str(mode), phy_modes(state->interface),
> @@ -3494,7 +3493,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
>  
>  	pl->link_port = pl->sfp_port;
>  
> -	phylink_sfp_set_config(pl, support, &config);
> +	phylink_sfp_set_config(pl, support, &config, true);
>  
>  	return 0;
>  }
> @@ -3569,7 +3568,7 @@ static int phylink_sfp_config_optical(struct phylink *pl)
>  
>  	pl->link_port = pl->sfp_port;
>  
> -	phylink_sfp_set_config(pl, pl->sfp_support, &config);
> +	phylink_sfp_set_config(pl, pl->sfp_support, &config, false);
>  
>  	return 0;
>  }
> -- 
> 2.30.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

