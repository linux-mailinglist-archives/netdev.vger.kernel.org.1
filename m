Return-Path: <netdev+bounces-151189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C3E9ED45A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 19:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B856C1889D2C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37861DE2DF;
	Wed, 11 Dec 2024 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uv8eUPJd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C4246344
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940227; cv=none; b=s/svSI6MOLFBez5ONKPKAt5ybwabeVSHhHpla8nNj1D+PKH+CSR1oSKrJfkioUHKc1DevjWPX9c7ZI2f09/fdipJrIMcuj3pxc7qoZlZcU5me0uLiQryWyLB0D6ddrbQqXSVHrcnaZABzoF0oigrdA2n5pNTzDa1DvRLN1cI+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940227; c=relaxed/simple;
	bh=Urrx3fIHjgVDBub/W5ZfGb7hZp1qtolno2vy7Bvct2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJHRvcNnhXpjw7YCuf7TalnaI1cZbM+WCa3Ag1WEoO1ZHnfWtVyXXpFqkNBRxwgu/FqbpgKrmRQCGENvpP+S8dUyaHADmAx4o1tJ4vgWDcP7uqsPd+FMiRdwdJ60D6/Ngn3YfZ7dEcvSQKB1c9zXlUzqvR/yaVH9aehmgVjAQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uv8eUPJd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z1PpeSS2xeXJOyJX8mjBNS26bdbLj0jfa4E8290Z9O8=; b=Uv8eUPJdCK/xesNPcjx7g5dqwv
	bWv6elMTdFRMiLIwFx8JCbqrW22XqDqukLVxD09tLjTMqYLc9EVBKY12gw48hRbZjWRFHnxGrpAXu
	CqGG8L9R4odhu0eA9grY0wpHa2lZA+bkll98Z62qF0vZU8Hj21G7fefvuGn5ZlWUL4vRvquGPD6DP
	rnpr6vFD8j51d3121cASqm03XWYzj8HeYTvXePQfZj3FnWUJ/jhU6x4ahCcB/qiWFkt78m07dDMlT
	4N21JipUYQSJjP0AYD9uAMxfyVxoetcczA4M4+Lcv+ppsrGEQzHcVt/jHsJ3puoyGwEA4koumltft
	cmz510Cg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39676)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLR3k-0004Gg-0D;
	Wed, 11 Dec 2024 18:03:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLR3g-0004W2-2g;
	Wed, 11 Dec 2024 18:03:36 +0000
Date: Wed, 11 Dec 2024 18:03:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next] net: phylink: improve
 phylink_sfp_config_phy() error message with empty supported
Message-ID: <Z1nT-GlW24hgHkfx@shell.armlinux.org.uk>
References: <20241211172537.1245216-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211172537.1245216-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 11, 2024 at 07:25:36PM +0200, Vladimir Oltean wrote:
> It seems that phylink does not support driving PHYs in SFP modules using
> the Generic PHY or Generic Clause 45 PHY driver. I've come to this
> conclusion after analyzing these facts:
> 
> - sfp_sm_probe_phy(), who is our caller here, first calls
>   phy_device_register() and then sfp_add_phy() -> ... ->
>   phylink_sfp_connect_phy().
> 
> - phydev->supported is populated by phy_probe()
> 
> - phy_probe() is usually called synchronously from phy_device_register()
>   via phy_bus_match(), if a precise device driver is found for the PHY.
>   In that case, phydev->supported has a good chance of being set to a
>   non-zero mask.
> 
> - There is an exceptional case for the PHYs for which phy_bus_match()
>   didn't find a driver. Those devices sit for a while without a driver,
>   then phy_attach_direct() force-binds the genphy_c45_driver or
>   genphy_driver to them. Again, this triggers phy_probe() and renders
>   a good chance of phydev->supported being populated, assuming
>   compatibility with genphy_read_abilities() or
>   genphy_c45_pma_read_abilities().
> 
> - phylink_sfp_config_phy() does not support the exceptional case of
>   retrieving phydev->supported from the Generic PHY driver, due to its
>   code flow. It expects the phydev->supported mask to already be
>   non-empty, because it first calls phylink_validate() on it, and only
>   calls phylink_attach_phy() if that succeeds. Thus, phylink_attach_phy()
>   -> phy_attach_direct() has no chance of running.
> 
> It is not my wish to change the state of affairs by altering the code
> flow, but merely to document the limitation rather than have the current
> unspecific error:
> 
> [   61.800079] mv88e6085 d0032004.mdio-mii:12 sfp: validation with support 00,00000000,00000000,00000000 failed: -EINVAL
> [   61.820743] sfp sfp: sfp_add_phy failed: -EINVAL
> 
> On the premise that an empty phydev->supported is going to make
> phylink_validate() fail anyway, it would be more informative to single
> out that case, undercut the phylink_validate() call, and print a more
> specific message:
> 
> [   33.468000] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) supports no link modes. Maybe its specific PHY driver not loaded?
> [   33.488187] mv88e6085 d0032004.mdio-mii:12 sfp: Common drivers for PHYs on SFP modules are CONFIG_BCM84881_PHY and CONFIG_MARVELL_PHY.
> [   33.518621] sfp sfp: sfp_add_phy failed: -EINVAL
> 
> Of course, there may be other reasons due to which phydev->supported is
> empty, thus the use of the word "maybe", but I think the lack of a
> driver would be the most common.
> 
> Link: https://lore.kernel.org/netdev/20241113144229.3ff4bgsalvj7spb7@skbuf/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: add one more informational line containing common Kconfig
> options, as per review feedback.
> 
> Link to v1:
> https://lore.kernel.org/netdev/20241114165348.2445021-1-vladimir.oltean@nxp.com/
> 
>  drivers/net/phy/phylink.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 95fbc363f9a6..b9dee09f4cfc 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3436,6 +3436,12 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
>  	int ret;
>  
>  	linkmode_copy(support, phy->supported);
> +	if (linkmode_empty(support)) {
> +		phylink_err(pl, "PHY %s (id 0x%.8lx) supports no link modes. Maybe its specific PHY driver not loaded?\n",
> +			    phydev_name(phy), (unsigned long)phy->phy_id);
> +		phylink_err(pl, "Common drivers for PHYs on SFP modules are CONFIG_BCM84881_PHY and CONFIG_MARVELL_PHY.\n");
> +		return -EINVAL;
> +	}

Wouldn't checking phy->drv == NULL be a better to detect that there is
no PHY driver bound (and thus indicating that the specific driver is
not loaded?)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

