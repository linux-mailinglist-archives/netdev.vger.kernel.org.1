Return-Path: <netdev+bounces-40741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212BB7C8915
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CDA28264A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F71BDEB;
	Fri, 13 Oct 2023 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkWOrR98"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3C1BDEA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC20AC433C7;
	Fri, 13 Oct 2023 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697212085;
	bh=U1YKFSXY08tJibk9UQhz6q54OPcpF6fXz3U2EjQSuK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkWOrR9826ylpMuzJMiAyn0/eOUE38ZcixBepBRBTMBoE4e//5ma1fRX1ha14UIn8
	 eIbMe3RrWdLUTkTZMkvbIxyPP4mLU1ZoZl8JAxgJxjOdoZ4bvs/07wm8IZs6VO9w9F
	 ZJO9o+pEAt9L2/xWfMnGh4f/6mGQ6vGdzJkd+k6WW/hBRHrmJtzKyi1wfer+Z3HERu
	 ahy3e7eJweHhEFcp8Nw4U9c2MYhZWnaKciOlsZaZb75zi0G64SXKXgQGdo4xB9C2DA
	 NMpFStVO1OJr3Li5xce9AFLJfjNSXwib9wFtroWGY7fY+ACSXvlmGIT74wfzAVSiMD
	 5qTlH4hR+0vhg==
Date: Fri, 13 Oct 2023 17:48:00 +0200
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/3] net: phy: micrel: Fix forced link mode
 for KSZ886X switches
Message-ID: <20231013154800.GQ29570@kernel.org>
References: <20231011123856.1443308-1-o.rempel@pengutronix.de>
 <20231011123856.1443308-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011123856.1443308-3-o.rempel@pengutronix.de>

On Wed, Oct 11, 2023 at 02:38:56PM +0200, Oleksij Rempel wrote:
> Address a link speed detection issue in KSZ886X PHY driver when in
> forced link mode. Previously, link partners like "ASIX AX88772B"
> with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.
> 
> The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
> even with autonegotiation off, misleading link partners in autoneg mode,
> leading to incorrect link speed detection.
> 
> Now, when autonegotiation is disabled, the driver sets the link state
> forcefully using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just
> disabling autonegotiation, makes the PHY state more reliably detected by
> link partners using parallel detection, thus fixing the link speed
> misconfiguration.
> 
> With autonegotiation enabled, link state is not forced, allowing proper
> autonegotiation process participation.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/micrel.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 927d3d54658e..12f093aed4ff 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1729,9 +1729,35 @@ static int ksz886x_config_aneg(struct phy_device *phydev)
>  {
>  	int ret;
>  
> -	ret = genphy_config_aneg(phydev);
> -	if (ret)
> -		return ret;
> +	if (phydev->autoneg != AUTONEG_ENABLE) {
> +		ret = genphy_setup_forced(phydev);
> +		if (ret)
> +			return ret;
> +
> +		/* When autonegotation is disabled, we need to manually force

nit: autonegotiation

> +		 * the link state. If we don't do this, the PHY will keep
> +		 * sending Fast Link Pulses (FLPs) which are part of the
> +		 * autonegotiation process. This is not desired when
> +		 * autonegotiation is off.
> +		 */

...

