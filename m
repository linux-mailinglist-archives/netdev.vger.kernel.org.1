Return-Path: <netdev+bounces-57993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EB814C04
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE7E2840DD
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F6374C4;
	Fri, 15 Dec 2023 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wI3ZB31k"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51232DF67;
	Fri, 15 Dec 2023 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WTZEU8lgYKwjH1B8Xlk6CEYwtbKUxcW+W9XW4pXoCsk=; b=wI3ZB31khOI2xk2bLZFZ3+oqnf
	Po+GYnQ+11zp+6J1yLgxtOGj0r7VkDjBnsKzCn4J3t6Oel1WdFN+0AaetIPS/unKPhUPauTtkycAT
	NEPAaO8oWxPqDMs7z15nfUlWwJ7PmjSr4qKdRAq7DFGMkhoDPczDRA0Li7WJT3rAo2WgrCw1+Vtpr
	h3TPFUVyVA9nmfIVtyBlDhROyPX68lEfHElgVsOVvCBmpVZw7D/xJD1g4UEwOlz/8MUd+GsAIAjbt
	4UomB0LJ/23I1wpxXjdLjQU78d4EOoHeIZCeZa3a+Ju5TvG5SoWMMYi+cwqy6A5y3X6KyxEyCfDfo
	0S0BJ+vw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53300)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEAMx-0002rP-2F;
	Fri, 15 Dec 2023 15:44:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEAMz-0003jY-7y; Fri, 15 Dec 2023 15:44:57 +0000
Date: Fri, 15 Dec 2023 15:44:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, kabel@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: phy: marvell10g: Fix power-up when
 strapped to start powered down
Message-ID: <ZXx0eVzJ3I1PwOa0@shell.armlinux.org.uk>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214201442.660447-3-tobias@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 09:14:40PM +0100, Tobias Waldekranz wrote:
> On devices which are hardware strapped to start powered down (PDSTATE
> == 1), make sure that we clear the power-down bit on all units
> affected by this setting.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/net/phy/marvell10g.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 83233b30d7b0..1c1333d867fb 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -344,11 +344,22 @@ static int mv3310_power_down(struct phy_device *phydev)
>  
>  static int mv3310_power_up(struct phy_device *phydev)
>  {
> +	static const u16 resets[][2] = {
> +		{ MDIO_MMD_PCS,    MV_PCS_BASE_R    + MDIO_CTRL1 },
> +		{ MDIO_MMD_PCS,    MV_PCS_1000BASEX + MDIO_CTRL1 },

This is not necessary. The documentation states that the power down
bit found at each of these is the same physical bit appearing in two
different locations. So only one is necessary.

> +		{ MDIO_MMD_PCS,    MV_PCS_BASE_T    + MDIO_CTRL1 },
> +		{ MDIO_MMD_PMAPMD, MDIO_CTRL1 },
> +		{ MDIO_MMD_VEND2,  MV_V2_PORT_CTRL },
> +	};
>  	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
> -	int ret;
> +	int i, ret;
>  
> -	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
> -				 MV_V2_PORT_CTRL_PWRDOWN);
> +	for (i = 0; i < ARRAY_SIZE(resets); i++) {
> +		ret = phy_clear_bits_mmd(phydev, resets[i][0], resets[i][1],
> +					 MV_V2_PORT_CTRL_PWRDOWN);

While MV_V2_PORT_CTRL_PWRDOWN may correspond with the correct bit for
the MDIO CTRL1 register, we have MDIO_CTRL1_LPOWER which describes
this bit. Probably the simplest solution would be to leave the
existing phy_clear_bits_mmd(), remove the vendor 2 entry from the
table, and run through that table first.

Lastly, how does this impact a device which has firmware, and the
firmware manages the power-down state (the manual states that unused
blocks will be powered down - I assume by the firmware.) If this
causes blocks which had been powered down by the firmware because
they're not being used to then be powered up, that is a regression.
Please check that this is not the case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

