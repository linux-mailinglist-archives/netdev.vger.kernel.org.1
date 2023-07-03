Return-Path: <netdev+bounces-15135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169BA745DAF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59E0280C21
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178ABF9E3;
	Mon,  3 Jul 2023 13:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB9F9DE
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 13:46:51 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC4B0
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iplbo/fEUAkJ/XfK3HphxdbFvftEWvNVFS2xUmXUXUg=; b=GAJOr9CAAn/cT15xi4azYlFStV
	i4qY9J2z1lBEOH0apYpCbH8sjG8iY9sOFXfkzgb6zXihJ2Lzn0h5JaAar/F1FMj59V4GHN9iDbIG9
	Ce6cgAxE0pA5y54TVOzsggTjpUVZalBv36V61XTaXgzJV9RQhaycetPtnNGE4domZoBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGJt7-000Tuw-3b; Mon, 03 Jul 2023 15:46:45 +0200
Date: Mon, 3 Jul 2023 15:46:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, francesco.dolcini@toradex.com
Subject: Re: [PATCH v1 2/2] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2110 PHY
Message-ID: <40260add-88a2-48a5-9409-ad16d9281f52@lunn.ch>
References: <20230703124440.391970-1-eichest@gmail.com>
 <20230703124440.391970-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703124440.391970-3-eichest@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> index 93b8efc792273..2913b145d5406 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -223,6 +223,12 @@ config MARVELL_88X2222_PHY
>  	  Support for the Marvell 88X2222 Dual-port Multi-speed Ethernet
>  	  Transceiver.
>  
> +config MARVELL_88Q2XXX_PHY
> +	tristate "Marvell 88Q2XXX PHY"
> +	help
> +	  Support for the Marvell Automotive 88Q2XXX 100/1000BASE-T1 Ethernet
> +	  PHYs.

I suggest you follow the pattern of the 88X2222.

	  Support for the Marvell 88Q2XXX 100/1000BASE-T1 Automotive Ethernet
	  PHYs.

These entries are sorted by these strings, so should be before the
88Q2XXX.


> +
>  config MAXLINEAR_GPHY
>  	tristate "Maxlinear Ethernet PHYs"
>  	select POLYNOMIAL if HWMON
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index f289ab16a1dab..15d1908fd5cb7 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_LXT_PHY)		+= lxt.o
>  obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
>  obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
>  obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
> +obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o

These are sorted by the CONFIG_*, so it should also be before the
88X2XXX

> +static int mv88q2xxx_soft_reset(struct phy_device *phydev)
> +{
> +	phy_write_mmd(phydev, 3, 0x0900, 0x8000);

Please use the #defines, e.g. MDIO_MMD_PCS.

0x900 is listed in IEEE 802.3 2022. It is a standard register. Please
add a #define for it next to all the others. You can also add BIT()
macros for PMA/PMD reset, and maybe Tx Disable, low power.

> +
> +	return 0;
> +}
> +
> +static void init_fast_ethernet(struct phy_device *phydev)
> +{
> +	u16 value = phy_read_mmd(phydev, 1, 0x0834);

2100 is also a standard register.

> +
> +	value = value & 0xFFF0;
> +
> +	phy_write_mmd(phydev, 1, 0x0834, value);
> +}
> +
> +static void init_gbit_ethernet(struct phy_device *phydev)
> +{
> +	u16 value = phy_read_mmd(phydev, 1, 0x0834);
> +
> +	value = (value & 0xFFF0) | 0x0001;
> +
> +	phy_write_mmd(phydev, 1, 0x0834, value);
> +}
> +
> +static int setup_master_slave(struct phy_device *phydev)
> +{
> +	u16 reg_data = phy_read_mmd(phydev, 1, 0x0834);
> +
> +	switch (phydev->master_slave_set) {
> +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> +		reg_data |= 0x4000;
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> +		reg_data &= ~0x4000;
> +		break;
> +	case MASTER_SLAVE_CFG_UNKNOWN:
> +	case MASTER_SLAVE_CFG_UNSUPPORTED:
> +		return 0;
> +	default:
> +		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	phy_write_mmd(phydev, 1, 0x0834, reg_data);
> +
> +	return 0;
> +}
> +
> +static int mv88q2xxx_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	if (phydev->speed == SPEED_100)
> +		init_fast_ethernet(phydev);
> +	else if (phydev->speed == SPEED_1000)
> +		init_gbit_ethernet(phydev);
> +
> +	ret = setup_master_slave(phydev);
> +	if (ret)
> +		return ret;
> +
> +	mv88q2xxx_soft_reset(phydev);
> +
> +	return 0;
> +}
> +
> +static int mv88q2xxx_config_init(struct phy_device *phydev)
> +{
> +	return mv88q2xxx_config_aneg(phydev);
> +}
> +
> +static int get_speed(struct phy_device *phydev)
> +{
> +	u16 value = 0;
> +
> +	if (phydev->autoneg)
> +		value = (phy_read_mmd(phydev, 7, 0x801a) & 0x4000) >> 14;
> +	else
> +		value = (phy_read_mmd(phydev, 1, 0x0834) & 0x1);
> +
> +	return value ? SPEED_1000 : SPEED_100;
> +}
> +
> +static int check_link(struct phy_device *phydev)
> +{
> +	u16 ret1, ret2;
> +
> +	if (phydev->speed == SPEED_1000) {
> +		ret1 = phy_read_mmd(phydev, 3, 0x0901);
> +		ret1 = phy_read_mmd(phydev, 3, 0x0901);
> +		ret2 = phy_read_mmd(phydev, 7, 0x8001);
> +	} else {
> +		ret1 = phy_read_mmd(phydev, 3, 0x8109);
> +		ret2 = phy_read_mmd(phydev, 3, 0x8108);
> +	}
> +
> +	return (0x0 != (ret1 & 0x0004)) && (0x0 != (ret2 & 0x3000)) ? 1 : 0;
> +}
> +
> +static int read_master_slave(struct phy_device *phydev)
> +{
> +	int reg;
> +
> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> +
> +	reg = phy_read_mmd(phydev, 7, 0x8001);
> +	if (reg & (1 << 14)) {
> +		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
> +		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
> +	} else {
> +		phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
> +		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mv88q2xxx_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->link = check_link(phydev);
> +	phydev->speed = get_speed(phydev);
> +
> +	ret = read_master_slave(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}


So all these functions can be placed in phy-c45.c, since they are
generic to any 1000BaseT1 PHY. Please look at the other functions in
there, and try the fit the patterns.

Please also look at genphy_c45_pma_read_abilities() and extend it to
detect the features of this PHY.

> +static int mv88q2xxx_probe(struct phy_device *phydev)
> +{
> +	if (!phydev->is_c45)
> +		return -ENODEV;

Why?

> +
> +	return 0;
> +}
> +
> +static int mv88q2xxxx_cable_test_start(struct phy_device *phydev)
> +{
> +	return 0;
> +}
> +
> +static int mv88q2xxxx_cable_test_get_status(struct phy_device *phydev,
> +					    bool *finished)
> +{
> +	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
> +				ETHTOOL_A_CABLE_RESULT_CODE_OK);
> +	return 0;
> +}

There is no need to implement them if you don't have anything useful
to return.

> +static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
> +{
> +	u16 value;
> +
> +	if (phydev->speed == SPEED_100)
> +		value = (phy_read_mmd(phydev, 3, 0x8230) >> 12) & 0x0F;
> +	else
> +		value = phy_read_mmd(phydev, 3, 0xfc88) & 0x0F;

This looks proprietary to this PHY. However the open alliance does
have some standards in this area. Please check to see if they define
registers.

	Andrew

