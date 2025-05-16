Return-Path: <netdev+bounces-190959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F0AB97BA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CF3A00D19
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE822DFBB;
	Fri, 16 May 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MkFIOiVY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1622CBD8;
	Fri, 16 May 2025 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384229; cv=none; b=UQOMaUkRYykSUe0mOieOl9P3KjXeTCcUhxN4sQdBFCaH6tuqvZhTdU0SRQbx+w7JFzegAQaLJh2M6PqyYgG7EvYpDrq2smrN3nF2KAazSAbPKHyliXe+lRhJ7I+NXAmoJBbH0vNaDltNmglM/q0GsHfJSNOYdrdoqinq7xjO9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384229; c=relaxed/simple;
	bh=ldZOGhtmx7WUb/eVybYY09LSeO494Ab8oT8AD/pa9aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJUomaeMvEfFFUHBBX9wsiZJgrZwUm41oLUrOrlVyrnY6/Qr25l6YWNt/P76ufdQazgP74ojcqZn9ejp76bkorJ0aQuKiA/DbpRSCfWX09HD/r4BN7HlA6+cUkO06bKlWvHZEYqmorNKXdkheYedSKlZiQvM00yUCS+oR2cwGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MkFIOiVY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3vnlmYkF5eL5zF22fjVEtExR7M5wVeYjulZM7+TVb9U=; b=MkFIOiVYCPPiCgm/L5jbqjC2eP
	wwevs8d5eTp3Eu8m5JQAE0coJ45o0Uh5dt7mU/LXcfF63nvwAJ1u18AeYdZyIU7MqAUzVv22tUdTx
	N6Hi7OE7NXikgwHMNTIQk82JBObxpQy5fC8vlb6PRrj5gx7XJ0cM1y5snCcfAOtuUAON4zSu8/RYw
	BocfbX388afHuYwLgWHol5fl1F6BBDih017o0EN60iKdrD3c99iEcOoFCnl7VSyJOJQSrIKpAZOBa
	6Ht1f4ZHC0bgnBNze1ERAT/0QVSEVd2oOTAA3PCa7NlaZ+4CmCxqjSGw+eD/AliHvnltTsody3voa
	CNFUprKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45458)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uFqSK-0001lH-0I;
	Fri, 16 May 2025 09:30:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uFqSG-00067T-1L;
	Fri, 16 May 2025 09:30:08 +0100
Date: Fri, 16 May 2025 09:30:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <aCb3kNniIhtmIhf1@shell.armlinux.org.uk>
References: <20250516024123.24910-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516024123.24910-1-Tristram.Ha@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

I think I gave comments on the previous version about this approach
but I don't see any change. Maybe I missed your response, I don't know,
I'm only occasionally dipping into the mass of emails I get.

On Thu, May 15, 2025 at 07:41:23PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The KSZ9477 switch driver uses the XPCS driver to operate its SGMII
> port.  However there are some hardware bugs in the KSZ9477 SGMII
> module so workarounds are needed.  There was a proposal to update the
> XPCS driver to accommodate KSZ9477, but the new code is not generic
> enough to be used by other vendors.  It is better to do all these
> workarounds inside the KSZ9477 driver instead of modifying the XPCS
> driver.
> 
> There are 3 hardware issues.  The first is the MII_ADVERTISE register
> needs to be write once after reset for the correct code word to be
> sent.  The XPCS driver disables auto-negotiation first before
> configuring the SGMII/1000BASE-X mode and then enables it back.  The
> KSZ9477 driver then writes the MII_ADVERTISE register before enabling
> auto-negotiation.  In 1000BASE-X mode the MII_ADVERTISE register will
> be set, so KSZ9477 driver does not need to write it.
> 
> The second issue is the MII_BMCR register needs to set the exact speed
> and duplex mode when running in SGMII mode.  During link polling the
> KSZ9477 will check the speed and duplex mode are different from
> previous ones and update the MII_BMCR register accordingly.
> 
> The last issue is 1000BASE-X mode does not work with auto-negotiation
> on.  The cause is the local port hardware does not know the link is up
> and so network traffic is not forwarded.  The workaround is to write 2
> additional bits when 1000BASE-X mode is configured.
> 
> Note the SGMII interrupt in the port cannot be masked.  As that
> interrupt is not handled in the KSZ9477 driver the SGMII interrupt bit
> will not be set even when the XPCS driver sets it.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
> v4
>  - update for last ksz_common.c merge
> 
> v3
>  - rebase with latest commit
> 
> v2
>  - add Kconfig for required XPCS driver build
> 
>  drivers/net/dsa/microchip/Kconfig      |   1 +
>  drivers/net/dsa/microchip/ksz9477.c    | 191 ++++++++++++++++++++++++-
>  drivers/net/dsa/microchip/ksz9477.h    |   4 +-
>  drivers/net/dsa/microchip/ksz_common.c |  36 ++++-
>  drivers/net/dsa/microchip/ksz_common.h |  23 ++-
>  5 files changed, 248 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
> index 12a86585a77f..c71d3fd5dfeb 100644
> --- a/drivers/net/dsa/microchip/Kconfig
> +++ b/drivers/net/dsa/microchip/Kconfig
> @@ -6,6 +6,7 @@ menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
>  	select NET_DSA_TAG_NONE
>  	select NET_IEEE8021Q_HELPERS
>  	select DCB
> +	select PCS_XPCS
>  	help
>  	  This driver adds support for Microchip KSZ8, KSZ9 and
>  	  LAN937X series switch chips, being KSZ8863/8873,
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 29fe79ea74cd..825aa570eed9 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -2,7 +2,7 @@
>  /*
>   * Microchip KSZ9477 switch driver main logic
>   *
> - * Copyright (C) 2017-2024 Microchip Technology Inc.
> + * Copyright (C) 2017-2025 Microchip Technology Inc.
>   */
>  
>  #include <linux/kernel.h>
> @@ -161,6 +161,187 @@ static int ksz9477_wait_alu_sta_ready(struct ksz_device *dev)
>  					10, 1000);
>  }
>  
> +static void port_sgmii_s(struct ksz_device *dev, uint port, u16 devid, u16 reg)
> +{
> +	u32 data;
> +
> +	data = (devid & MII_MMD_CTRL_DEVAD_MASK) << 16;
> +	data |= reg;
> +	ksz_pwrite32(dev, port, REG_PORT_SGMII_ADDR__4, data);
> +}
> +
> +static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> +			 u16 *buf)
> +{
> +	port_sgmii_s(dev, port, devid, reg);
> +	ksz_pread16(dev, port, REG_PORT_SGMII_DATA__4 + 2, buf);
> +}
> +
> +static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> +			 u16 buf)
> +{
> +	port_sgmii_s(dev, port, devid, reg);
> +	ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, buf);
> +}
> +
> +static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
> +{
> +	struct ksz_device *dev = bus->priv;
> +	int port = ksz_get_sgmii_port(dev);
> +	u16 val;
> +
> +	port_sgmii_r(dev, port, mmd, reg, &val);
> +
> +	/* Simulate a value to activate special code in the XPCS driver if
> +	 * supported.
> +	 */
> +	if (mmd == MDIO_MMD_PMAPMD) {
> +		if (reg == MDIO_DEVID1)
> +			val = 0x9477;
> +		else if (reg == MDIO_DEVID2)
> +			val = 0x22 << 10;
> +	} else if (mmd == MDIO_MMD_VEND2) {
> +		struct ksz_port *p = &dev->ports[port];
> +
> +		/* Need to update MII_BMCR register with the exact speed and
> +		 * duplex mode when running in SGMII mode and this register is
> +		 * used to detect connected speed in that mode.
> +		 */
> +		if (reg == MMD_SR_MII_AUTO_NEG_STATUS) {
> +			int duplex, speed;
> +
> +			if (val & SR_MII_STAT_LINK_UP) {
> +				speed = (val >> SR_MII_STAT_S) & SR_MII_STAT_M;
> +				if (speed == SR_MII_STAT_1000_MBPS)
> +					speed = SPEED_1000;
> +				else if (speed == SR_MII_STAT_100_MBPS)
> +					speed = SPEED_100;
> +				else
> +					speed = SPEED_10;
> +
> +				if (val & SR_MII_STAT_FULL_DUPLEX)
> +					duplex = DUPLEX_FULL;
> +				else
> +					duplex = DUPLEX_HALF;
> +
> +				if (!p->phydev.link ||
> +				    p->phydev.speed != speed ||
> +				    p->phydev.duplex != duplex) {
> +					u16 ctrl;
> +
> +					p->phydev.link = 1;
> +					p->phydev.speed = speed;
> +					p->phydev.duplex = duplex;
> +					port_sgmii_r(dev, port, mmd, MII_BMCR,
> +						     &ctrl);
> +					ctrl &= BMCR_ANENABLE;
> +					ctrl |= mii_bmcr_encode_fixed(speed,
> +								      duplex);
> +					port_sgmii_w(dev, port, mmd, MII_BMCR,
> +						     ctrl);
> +				}
> +			} else {
> +				p->phydev.link = 0;
> +			}
> +		} else if (reg == MII_BMSR) {
> +			p->phydev.link = (val & BMSR_LSTATUS);
> +		}
> +	}
> +	return val;
> +}
> +
> +static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
> +			     u16 val)
> +{
> +	struct ksz_device *dev = bus->priv;
> +	int port = ksz_get_sgmii_port(dev);
> +
> +	if (mmd == MDIO_MMD_VEND2) {
> +		struct ksz_port *p = &dev->ports[port];
> +
> +		if (reg == MMD_SR_MII_AUTO_NEG_CTRL) {
> +			u16 sgmii_mode = SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
> +
> +			/* Need these bits for 1000BASE-X mode to work with
> +			 * AN on.
> +			 */
> +			if (!(val & sgmii_mode))
> +				val |= SR_MII_SGMII_LINK_UP |
> +				       SR_MII_TX_CFG_PHY_MASTER;
> +
> +			/* SGMII interrupt in the port cannot be masked, so
> +			 * make sure interrupt is not enabled as it is not
> +			 * handled.
> +			 */
> +			val &= ~SR_MII_AUTO_NEG_COMPLETE_INTR;
> +		} else if (reg == MII_BMCR) {
> +			/* The MII_ADVERTISE register needs to write once
> +			 * before doing auto-negotiation for the correct
> +			 * config_word to be sent out after reset.
> +			 */
> +			if ((val & BMCR_ANENABLE) && !p->sgmii_adv_write) {
> +				u16 adv;
> +
> +				/* The SGMII port cannot disable flow contrl
> +				 * so it is better to just advertise symmetric
> +				 * pause.
> +				 */
> +				port_sgmii_r(dev, port, mmd, MII_ADVERTISE,
> +					     &adv);
> +				adv |= ADVERTISE_1000XPAUSE;
> +				adv &= ~ADVERTISE_1000XPSE_ASYM;
> +				port_sgmii_w(dev, port, mmd, MII_ADVERTISE,
> +					     adv);
> +				p->sgmii_adv_write = 1;
> +			} else if (val & BMCR_RESET) {
> +				p->sgmii_adv_write = 0;
> +			}
> +		} else if (reg == MII_ADVERTISE) {
> +			/* XPCS driver writes to this register so there is no
> +			 * need to update it for the errata.
> +			 */
> +			p->sgmii_adv_write = 1;
> +		}
> +	}
> +	port_sgmii_w(dev, port, mmd, reg, val);
> +	return 0;
> +}
> +
> +int ksz9477_pcs_create(struct ksz_device *dev)
> +{
> +	/* This chip has a SGMII port. */
> +	if (ksz_has_sgmii_port(dev)) {
> +		int port = ksz_get_sgmii_port(dev);
> +		struct ksz_port *p = &dev->ports[port];
> +		struct phylink_pcs *pcs;
> +		struct mii_bus *bus;
> +		int ret;
> +
> +		bus = devm_mdiobus_alloc(dev->dev);
> +		if (!bus)
> +			return -ENOMEM;
> +
> +		bus->name = "ksz_pcs_mdio_bus";
> +		snprintf(bus->id, MII_BUS_ID_SIZE, "%s-pcs",
> +			 dev_name(dev->dev));
> +		bus->read_c45 = &ksz9477_pcs_read;
> +		bus->write_c45 = &ksz9477_pcs_write;
> +		bus->parent = dev->dev;
> +		bus->phy_mask = ~0;
> +		bus->priv = dev;
> +
> +		ret = devm_mdiobus_register(dev->dev, bus);
> +		if (ret)
> +			return ret;
> +
> +		pcs = xpcs_create_pcs_mdiodev(bus, 0);
> +		if (IS_ERR(pcs))
> +			return PTR_ERR(pcs);
> +		p->pcs = pcs;
> +	}
> +	return 0;
> +}
> +
>  int ksz9477_reset_switch(struct ksz_device *dev)
>  {
>  	u8 data8;
> @@ -978,6 +1159,14 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
>  
>  	if (dev->info->gbit_capable[port])
>  		config->mac_capabilities |= MAC_1000FD;
> +
> +	if (ksz_is_sgmii_port(dev, port)) {
> +		struct ksz_port *p = &dev->ports[port];
> +
> +		phy_interface_or(config->supported_interfaces,
> +				 config->supported_interfaces,
> +				 p->pcs->supported_interfaces);
> +	}
>  }
>  
>  int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
> diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
> index d2166b0d881e..0d1a6dfda23e 100644
> --- a/drivers/net/dsa/microchip/ksz9477.h
> +++ b/drivers/net/dsa/microchip/ksz9477.h
> @@ -2,7 +2,7 @@
>  /*
>   * Microchip KSZ9477 series Header file
>   *
> - * Copyright (C) 2017-2022 Microchip Technology Inc.
> + * Copyright (C) 2017-2025 Microchip Technology Inc.
>   */
>  
>  #ifndef __KSZ9477_H
> @@ -97,4 +97,6 @@ void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
>  				  u16 ethtype, u8 *src_mac, u8 *dst_mac,
>  				  unsigned long cookie, u32 prio);
>  
> +int ksz9477_pcs_create(struct ksz_device *dev);
> +
>  #endif
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index f492fa9f6dd4..248f8027e0cf 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2,7 +2,7 @@
>  /*
>   * Microchip switch driver main logic
>   *
> - * Copyright (C) 2017-2024 Microchip Technology Inc.
> + * Copyright (C) 2017-2025 Microchip Technology Inc.
>   */
>  
>  #include <linux/delay.h>
> @@ -408,12 +408,28 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
>  					int speed, int duplex, bool tx_pause,
>  					bool rx_pause);
>  
> +static struct phylink_pcs *
> +ksz_phylink_mac_select_pcs(struct phylink_config *config,
> +			   phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct ksz_device *dev = dp->ds->priv;
> +	struct ksz_port *p = &dev->ports[dp->index];
> +
> +	if (ksz_is_sgmii_port(dev, dp->index) &&
> +	    (interface == PHY_INTERFACE_MODE_SGMII ||
> +	    interface == PHY_INTERFACE_MODE_1000BASEX))
> +		return p->pcs;
> +	return NULL;
> +}
> +
>  static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
>  	.mac_config	= ksz_phylink_mac_config,
>  	.mac_link_down	= ksz_phylink_mac_link_down,
>  	.mac_link_up	= ksz9477_phylink_mac_link_up,
>  	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
>  	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
> +	.mac_select_pcs	= ksz_phylink_mac_select_pcs,
>  };
>  
>  static const struct ksz_dev_ops ksz9477_dev_ops = {
> @@ -451,6 +467,7 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
>  	.reset = ksz9477_reset_switch,
>  	.init = ksz9477_switch_init,
>  	.exit = ksz9477_switch_exit,
> +	.pcs_create = ksz9477_pcs_create,
>  };
>  
>  static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
> @@ -1093,8 +1110,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
>  	regmap_reg_range(0x701b, 0x701b),
>  	regmap_reg_range(0x701f, 0x7020),
>  	regmap_reg_range(0x7030, 0x7030),
> -	regmap_reg_range(0x7200, 0x7203),
> -	regmap_reg_range(0x7206, 0x7207),
> +	regmap_reg_range(0x7200, 0x7207),
>  	regmap_reg_range(0x7300, 0x7301),
>  	regmap_reg_range(0x7400, 0x7401),
>  	regmap_reg_range(0x7403, 0x7403),
> @@ -1610,6 +1626,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  				   true, false, false},
>  		.gbit_capable	= {true, true, true, true, true, true, true},
>  		.ptp_capable = true,
> +		.sgmii_port = 7,
>  		.wr_table = &ksz9477_register_set,
>  		.rd_table = &ksz9477_register_set,
>  	},
> @@ -2002,6 +2019,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.internal_phy	= {true, true, true, true,
>  				   true, false, false},
>  		.gbit_capable	= {true, true, true, true, true, true, true},
> +		.sgmii_port = 7,
>  		.wr_table = &ksz9477_register_set,
>  		.rd_table = &ksz9477_register_set,
>  	},
> @@ -2137,7 +2155,7 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
>  
>  	spin_unlock(&mib->stats64_lock);
>  
> -	if (dev->info->phy_errata_9477) {
> +	if (dev->info->phy_errata_9477 && !ksz_is_sgmii_port(dev, port)) {
>  		ret = ksz9477_errata_monitor(dev, port, raw->tx_late_col);
>  		if (ret)
>  			dev_err(dev->dev, "Failed to monitor transmission halt\n");
> @@ -2845,6 +2863,12 @@ static int ksz_setup(struct dsa_switch *ds)
>  	if (ret)
>  		return ret;
>  
> +	if (ksz_has_sgmii_port(dev) && dev->dev_ops->pcs_create) {
> +		ret = dev->dev_ops->pcs_create(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* set broadcast storm protection 10% rate */
>  	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
>  			   BROADCAST_STORM_RATE,
> @@ -3692,6 +3716,10 @@ static void ksz_phylink_mac_config(struct phylink_config *config,
>  	if (dev->info->internal_phy[port])
>  		return;
>  
> +	/* No need to configure XMII control register when using SGMII. */
> +	if (ksz_is_sgmii_port(dev, port))
> +		return;
> +
>  	if (phylink_autoneg_inband(mode)) {
>  		dev_err(dev->dev, "In-band AN not supported!\n");
>  		return;
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index a034017568cd..a08417df2ca4 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Microchip switch driver common header
>   *
> - * Copyright (C) 2017-2024 Microchip Technology Inc.
> + * Copyright (C) 2017-2025 Microchip Technology Inc.
>   */
>  
>  #ifndef __KSZ_COMMON_H
> @@ -10,6 +10,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
> +#include <linux/pcs/pcs-xpcs.h>
>  #include <linux/phy.h>
>  #include <linux/regmap.h>
>  #include <net/dsa.h>
> @@ -93,6 +94,7 @@ struct ksz_chip_data {
>  	bool internal_phy[KSZ_MAX_NUM_PORTS];
>  	bool gbit_capable[KSZ_MAX_NUM_PORTS];
>  	bool ptp_capable;
> +	u8 sgmii_port;
>  	const struct regmap_access_table *wr_table;
>  	const struct regmap_access_table *rd_table;
>  };
> @@ -132,6 +134,7 @@ struct ksz_port {
>  	u32 force:1;
>  	u32 read:1;			/* read MIB counters in background */
>  	u32 freeze:1;			/* MIB counter freeze is enabled */
> +	u32 sgmii_adv_write:1;
>  
>  	struct ksz_port_mib mib;
>  	phy_interface_t interface;
> @@ -141,6 +144,7 @@ struct ksz_port {
>  	void *acl_priv;
>  	struct ksz_irq pirq;
>  	u8 num;
> +	struct phylink_pcs *pcs;
>  #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
>  	struct kernel_hwtstamp_config tstamp_config;
>  	bool hwts_tx_en;
> @@ -440,6 +444,8 @@ struct ksz_dev_ops {
>  	int (*reset)(struct ksz_device *dev);
>  	int (*init)(struct ksz_device *dev);
>  	void (*exit)(struct ksz_device *dev);
> +
> +	int (*pcs_create)(struct ksz_device *dev);
>  };
>  
>  struct ksz_device *ksz_switch_alloc(struct device *base, void *priv);
> @@ -731,6 +737,21 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
>  		dev->chip_id == LAN9372_CHIP_ID) && port == KSZ_PORT_4;
>  }
>  
> +static inline int ksz_get_sgmii_port(struct ksz_device *dev)
> +{
> +	return dev->info->sgmii_port - 1;
> +}
> +
> +static inline bool ksz_has_sgmii_port(struct ksz_device *dev)
> +{
> +	return dev->info->sgmii_port > 0;
> +}
> +
> +static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
> +{
> +	return dev->info->sgmii_port == port + 1;
> +}
> +
>  /* STP State Defines */
>  #define PORT_TX_ENABLE			BIT(2)
>  #define PORT_RX_ENABLE			BIT(1)
> -- 
> 2.34.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

