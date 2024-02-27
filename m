Return-Path: <netdev+bounces-75257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB768868DB0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D631C22EFF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C71386BD;
	Tue, 27 Feb 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TvDsl4i1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD81386AE
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030188; cv=none; b=NygJixgmSYGtWN0ze03zKOvPbA5/lhJovgidyQB6VD2Qa8JwTRMP19T4vRMsOXCN2sqAMy9sD2oX6/gIr5HG2G7Ld/aX9X5sC77WpdOfex/zBtHpokqDYJIqw993HCB342AhCfISXWQZLXobO7l9RwZEdApCOScQwxbRva1Afeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030188; c=relaxed/simple;
	bh=6UQ+nHWIPfEE9NQa2VYtsPLOVQfkwqHRwBtdDrQ2zEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAHTasq4rAcz1GtLszVOKK5zVYeXn1Jrl3gjl9TibyNd5ZU9ZsZuTlgflIa2skSMSi3+q1qPqQJGZHfXCbjGIn07ATRIO5GbliM7S7O8ZWTyM8bXKRpTemIqf4jHxh6D6sUS6b9Enm0E4X8tkvv+13XGQjqbEckgavzkovuz/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TvDsl4i1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lp7iz+fZroHS+nWK1K+MIyIPHAOC4rdCQohr/mO0hyw=; b=TvDsl4i1sTj+k7GzrePyxs7KMX
	rhV6G9vJfnTS0H3hR/WaIt79tu/RIEwwWFxvcrffq3Fl1Cz28Ds+F5r45OVc20kJbZDkctmMi1sd5
	976EAZImEUesgdFBMqRSzwU8eqt1aBIowYA9+0nB2hdYz9PxMdZYnTOnlcJ2tdzndmQSQ97hvg2eJ
	PoJ1psMS06ckAPa7u2wx3QknqfXCg+6w6eYSyU1TsQX3A+mreeM5veBic+nqIlweB9mT92aHBkaub
	0JNrKKHmiQ3QmznDIthmXVjKloUpSjZhcJdOBuzcnrfCRqj7r0qQixCX9K/C6l5ugBzPRV91wdyoy
	Tbs2SYMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39566)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reuok-0007nO-13;
	Tue, 27 Feb 2024 10:36:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reuog-0007JY-1P; Tue, 27 Feb 2024 10:36:06 +0000
Date: Tue, 27 Feb 2024 10:36:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH RFC net-next 1/6] net: phy: realtek: configure SerDes
 mode for rtl822x/8251b PHYs
Message-ID: <Zd27FaFlVqaQVV9B@shell.armlinux.org.uk>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227075151.793496-2-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 08:51:46AM +0100, Eric Woudstra wrote:
> From: Alexander Couzens <lynxis@fe80.eu>
> 
> The rtl822x series and rtl8251b support switching SerDes mode between
> 2500base-x and sgmii based on the negotiated copper speed.
> 
> Configure this switching mode according to SerDes modes supported by
> host.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> [ refactored, dropped HiSGMII mode and changed commit message ]
> Signed-off-by: Marek Behún <kabel@kernel.org>
> [ changed rtl822x_update_interface() to use vendor register ]
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 96 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 1fa70427b2a2..67cffe9b7d5d 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -54,6 +54,16 @@
>  						 RTL8201F_ISR_LINK)
>  #define RTL8201F_IER				0x13
>  
> +#define RTL822X_VND1_SERDES_OPTION			0x697a
> +#define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
> +#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
> +#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX		2
> +
> +#define RTL822X_VND1_SERDES_CTRL3			0x7580
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_MASK		GENMASK(5, 0)
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
> +
>  #define RTL8366RB_POWER_SAVE			0x15
>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
>  
> @@ -659,6 +669,60 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
>  	return ret;
>  }
>  
> +static int rtl822x_config_init(struct phy_device *phydev)
> +{
> +	bool has_2500, has_sgmii;
> +	u16 mode;
> +	int ret;
> +
> +	has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			    phydev->host_interfaces) ||
> +		   phydev->interface == PHY_INTERFACE_MODE_2500BASEX;
> +
> +	has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
> +			     phydev->host_interfaces) ||
> +		    phydev->interface == PHY_INTERFACE_MODE_SGMII;
> +
> +	if (!has_2500 && !has_sgmii)
> +		return 0;
> +
> +	/* fill in possible interfaces */
> +	__assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
> +		     has_2500);
> +	__assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
> +		     has_sgmii);

It would be nice to fill phydev->possible_interfaces even if
phydev->host_interfaces has not been populated. That means that the
"newer" paths in phylink can be always used during validation.

In other words, move the if() test just above this to below it.

> +
> +	/* determine SerDes option mode */
> +	if (has_2500 && !has_sgmii)
> +		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
> +	else
> +		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
> +	if (ret < 0)
> +		return ret;

It would be nice to know what this is doing.
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
> +				     RTL822X_VND1_SERDES_OPTION,
> +				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
> +				     mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* the following 3 writes into SerDes control are needed for 2500base-x
> +	 * mode to work properly
> +	 */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f10, 0xd455);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);

Also for these. "to work properly" is too vague - is it to do with the
inband signalling?

> +}
> +
>  static int rtl822x_get_features(struct phy_device *phydev)
>  {
>  	int val;
> @@ -695,6 +759,25 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>  	return __genphy_config_aneg(phydev, ret);
>  }
>  
> +static void rtl822x_update_interface(struct phy_device *phydev)
> +{
> +	int val;
> +
> +	/* Change interface according to serdes mode */
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CTRL3);
> +	if (val < 0)
> +		return;
> +
> +	switch (val & RTL822X_VND1_SERDES_CTRL3_MODE_MASK) {
> +	case RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX:
> +		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
> +		break;
> +	case RTL822X_VND1_SERDES_CTRL3_MODE_SGMII:
> +		phydev->interface = PHY_INTERFACE_MODE_SGMII;
> +		break;
> +	}

Just to confirm that this doesn't change existing device behaviour?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

