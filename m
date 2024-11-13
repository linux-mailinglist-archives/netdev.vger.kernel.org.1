Return-Path: <netdev+bounces-144326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE569C691C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 07:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB31F238F0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2417CA1F;
	Wed, 13 Nov 2024 06:11:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123517B401
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478308; cv=none; b=pf9KP37SWJb59H1vcGNW39u3OBbFh2KpJdMVYbDNCdTbpWpyw6HjaZwzvcVkUG8dS77giWs/tjLMi1KcpxslkkWcUeIYEFSznpjKCyxOVmk7x+PEWMgkMoOAJh0atupPOHbYFRM6VRkEd3fRGfyQmUdqqToFFcHIn39xvpRwG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478308; c=relaxed/simple;
	bh=jRNcvWxlvhe50IJi34gf4SABmjEAeBAr8313daeVr44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ/muUDXAcLZlOn+H8TXLKlEMoIkbeLJ4dEYggBEu+K9jD80iC30rBEZpRR1kqOUeh9gz/ca5aWHCtiAYKRF7NDAgFGpIYBWofEuMGWnmihKdpe9ObJJYMgT2NuejS49zTrcL/H8CwjC9O+yv2qcZHLvGKMqvMxbt5Iw7IfJ16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tB6b9-0005VO-Dl; Wed, 13 Nov 2024 07:11:27 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tB6b7-000X5H-3B;
	Wed, 13 Nov 2024 07:11:25 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tB6b7-009bdi-2p;
	Wed, 13 Nov 2024 07:11:25 +0100
Date: Wed, 13 Nov 2024 07:11:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: ensure PHY momentary link-fails are
 handled
Message-ID: <ZzRDDbecGLMiRP0m@pengutronix.de>
References: <E1tAtcW-002RBS-LB@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1tAtcW-002RBS-LB@rmk-PC.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Nov 12, 2024 at 04:20:00PM +0000, Russell King (Oracle) wrote:
> Normally, phylib won't notify changes in quick succession. However, as
> a result of commit 3e43b903da04 ("net: phy: Immediately call
> adjust_link if only tx_lpi_enabled changes") this is no longer true -
> it is now possible that phy_link_down() and phy_link_up() will both
> complete before phylink's resolver has run, which means it'll miss that
> pl->phy_state.link momentarily became false.
> 
> Rename "mac_link_dropped" to be more generic "link_failed" since it will
> cover more than the MAC/PCS end of the link failing, and arrange to set
> this in phylink_phy_change() if we notice that the PHY reports that the
> link is down.
> 
> This will ensure that we capture an EEE reconfiguration event.
> 
> Fixes: 3e43b903da04 ("net: phy: Immediately call adjust_link if only tx_lpi_enabled changes")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
>  drivers/net/phy/phylink.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 4309317de3d1..3e9957b6aa14 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -78,7 +78,7 @@ struct phylink {
>  	unsigned int pcs_neg_mode;
>  	unsigned int pcs_state;
>  
> -	bool mac_link_dropped;
> +	bool link_failed;
>  	bool using_mac_select_pcs;
>  
>  	struct sfp_bus *sfp_bus;
> @@ -1475,9 +1475,9 @@ static void phylink_resolve(struct work_struct *w)
>  		cur_link_state = pl->old_link_state;
>  
>  	if (pl->phylink_disable_state) {
> -		pl->mac_link_dropped = false;
> +		pl->link_failed = false;
>  		link_state.link = false;
> -	} else if (pl->mac_link_dropped) {
> +	} else if (pl->link_failed) {
>  		link_state.link = false;
>  		retrigger = true;
>  	} else {
> @@ -1572,7 +1572,7 @@ static void phylink_resolve(struct work_struct *w)
>  			phylink_link_up(pl, link_state);
>  	}
>  	if (!link_state.link && retrigger) {
> -		pl->mac_link_dropped = false;
> +		pl->link_failed = false;
>  		queue_work(system_power_efficient_wq, &pl->resolve);
>  	}
>  	mutex_unlock(&pl->state_mutex);
> @@ -1835,6 +1835,8 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
>  		pl->phy_state.pause |= MLO_PAUSE_RX;
>  	pl->phy_state.interface = phydev->interface;
>  	pl->phy_state.link = up;
> +	if (!up)
> +		pl->link_failed = true;
>  	mutex_unlock(&pl->state_mutex);
>  
>  	phylink_run_resolve(pl);
> @@ -2158,7 +2160,7 @@ EXPORT_SYMBOL_GPL(phylink_disconnect_phy);
>  static void phylink_link_changed(struct phylink *pl, bool up, const char *what)
>  {
>  	if (!up)
> -		pl->mac_link_dropped = true;
> +		pl->link_failed = true;
>  	phylink_run_resolve(pl);
>  	phylink_dbg(pl, "%s link %s\n", what, up ? "up" : "down");
>  }
> @@ -2792,7 +2794,7 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
>  	 * link will cycle.
>  	 */
>  	if (manual_changed) {
> -		pl->mac_link_dropped = true;
> +		pl->link_failed = true;
>  		phylink_run_resolve(pl);
>  	}
>  
> -- 
> 2.30.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

