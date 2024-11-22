Return-Path: <netdev+bounces-146792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB819D5E00
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D00FB23FA1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4C1DED76;
	Fri, 22 Nov 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eZ69rsf8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3A1DE8B2
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274602; cv=none; b=RzAvG7VEXhT1qSNkpoX6e44iq/gAQ9cP8cgbWNNnNXeBAGp3W5X1iM4Q9FEpFjegUmMLFBlGdRhDlga5YY3MS7QJURjS5AeYTqncOmhlboym1CV5xWjJJpAmpVpffI67hl0YHzeGOXDLfwGlRFKGi80SFcSy4SYdiryXxFbWBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274602; c=relaxed/simple;
	bh=A3DBD5piyy1qV3Wai+gifKhvtHbb/eZsZywUEKlMjLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWWwOB8gmfCzrv+/xJx90XKvnJ9yk2voIOQ4Cxvgg4USTuIF4nvcHye74+p/M7ypXAK1JbavEXnP7k7tSCNuyQqvuOb0Rz7cMO7YzmHrNoF036B7L5ZeExYTn1PWBzVjEYzsiDJYbHrBD8mKo0bG2rONF+XAke34pxHEsaIPJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eZ69rsf8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rjdi9+qjaOFYefiQqH3JO1E6if83YhddPLQXbliTMGA=; b=eZ69rsf8xYbIFtkbK5uichDi4S
	homMAlDY++RWY6NhPlZwsT19kQH4wH0diiLn3SjVQAKVTf5G/r0LnptJEN/DQFDyC+G6n3XdRUg4u
	eNVP7/gqTO6VN5Xgl1MxszlzBkIbchQr8nDn23L6p2jL7iMSsFMmaiTzARIZCPtXyO+kUBMd980gw
	ftVZBqi14AWJmjgw40vETK82416jRUSBqg+REt2slMKD9Y7VRE1vTPpRXnTHAbpjLcU6RY3l5ho0p
	hZxPYslEUPlD7rbxk3JSPrYgronAMKY2A1KWChLRch/Rcm1KWwIk6/xLFmZrj4QyHXzbnSBD+FwyN
	++yypUgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41850)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tERkp-0000Py-03;
	Fri, 22 Nov 2024 11:23:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tERkm-0000ZU-34;
	Fri, 22 Nov 2024 11:23:12 +0000
Date: Fri, 22 Nov 2024 11:23:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
Message-ID: <Z0BpoCMcCQxTpbEb@shell.armlinux.org.uk>
References: <E1tERjL-004Wax-En@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tERjL-004Wax-En@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 22, 2024 at 11:21:43AM +0000, Russell King (Oracle) wrote:
> When phy_ethtool_set_eee_noneg() detects a change in the LPI
> parameters, it attempts to update phylib state and trigger the link
> to cycle so the MAC sees the updated parameters.
> 
> However, in doing so, it sets phydev->enable_tx_lpi depending on
> whether the EEE configuration allows the MAC to generate LPI without
> taking into account the result of negotiation.
> 
> This can be demonstrated with a 1000base-T FD interface by:
> 
>  # ethtool --set-eee eno0 advertise 8	# cause EEE to be not negotiated
>  # ethtool --set-eee eno0 tx-lpi off
>  # ethtool --set-eee eno0 tx-lpi on
> 
> This results in being true, despite EEE not having been negotiated and:
>  # ethtool --show-eee eno0
> 	EEE status: enabled - inactive
> 	Tx LPI: 250 (us)
> 	Supported EEE link modes:  100baseT/Full
> 	                           1000baseT/Full
> 	Advertised EEE link modes:  100baseT/Full
> 	Link partner advertised EEE link modes:  100baseT/Full
> 	                                         1000baseT/Full
> 
> Fix this by keeping track of whether EEE was negotiated via a new
> eee_active member in struct phy_device, and include this state in
> the decision whether phydev->enable_tx_lpi should be set.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phy-c45.c |  2 +-
>  drivers/net/phy/phy.c     | 32 ++++++++++++++++++--------------
>  include/linux/phy.h       |  1 +
>  3 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 96d0b3a5a9d3..944ae98ad110 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -1530,7 +1530,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
>  		return ret;
>  
>  	data->eee_enabled = is_enabled;
> -	data->eee_active = ret;
> +	data->eee_active = phydev->eee_active;
>  	linkmode_copy(data->supported, phydev->supported_eee);
>  
>  	return 0;
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 4f3e742907cb..d03fe59cf1f3 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -990,14 +990,14 @@ static int phy_check_link_status(struct phy_device *phydev)
>  		phydev->state = PHY_RUNNING;
>  		err = genphy_c45_eee_is_active(phydev,
>  					       NULL, NULL, NULL);
> -		if (err <= 0)
> -			phydev->enable_tx_lpi = false;
> -		else
> -			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
> +		phydev->eee_active = err <= 0;

Scrub that... this is inverted!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

