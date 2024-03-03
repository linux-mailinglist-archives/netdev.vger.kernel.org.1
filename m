Return-Path: <netdev+bounces-76918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080786F683
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741FE1C209D7
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E476416;
	Sun,  3 Mar 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6bNE7rnA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC776415;
	Sun,  3 Mar 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709488314; cv=none; b=X2RA+KE5vrKEn2f8+dyAeEsp5y9ERTMcEp22OcDpCnNXLk9j57noKYFSdY3uyNpfcskR/NMGWUSrXq/m4po5aMWDkA3Me8kiM6O9r5V6gWacSde7qajbbWxCirpXhVfYrWLAfF6w8ba3yEKbjaQBh7zdYbspzuVeDoDutacJBn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709488314; c=relaxed/simple;
	bh=wboIMxMQE+RVFJ6PEzPpe+q7KTasSURe6mXLsQ7Toz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxqFsz4rBLZUhcw9Si2d38nt64VDVUHtPgx7mgCbcQUDKFsK8HUd4JJ7ME2SHa43xwbB1DECglTlt/Sxq9Bb1s9P6PKxkYlJRaiMPbLlxvvx9otD+wzg/Yzh+g780oU/G2879POY1IL/I3QnYYt34ortiynnn1cc9YAWjyFksg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6bNE7rnA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IjGJCSeONurj7PDmNjN0yS4ZGFr8/GiNUyaQ3Bs6l00=; b=6bNE7rnAiwA2lV7SQibMlTInKb
	6axOKfVlax2Viupd+nzjYWcF1b/jf36BnnTi1yo6NCL8WVW8Vjb2aSXz9oShwtZtHqdgf88WUFi3X
	JpjZjUU2OdV4UvBkHeU7G4AZL7N2n9mUwtdnWiHYSrvMWIdla16u48FlMW9xwrpDjmqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgq0A-009FAx-RP; Sun, 03 Mar 2024 18:51:54 +0100
Date: Sun, 3 Mar 2024 18:51:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302183835.136036-3-ericwouds@gmail.com>

> +static int en8811h_config_init(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	int ret, pollret, reg_value;
> +	u32 pbus_value;
> +
> +	if (!priv->firmware_version)
> +		ret = en8811h_load_firmware(phydev);

How long does this take for your hardware?

We have a phylib design issue with loading firmware. It would be
better if it happened during probe, but it might not be finished by
the time the MAC driver tries to attach to the PHY and so that fails.
This is the second PHY needing this, so maybe we need to think about
adding a thread kicked off in probe to download the firmware? But
probably later, not part of this patchset.

> +	else
> +		ret = en8811h_restart_host(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Because of mdio-lock, may have to wait for multiple loads */
> +	pollret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> +					    EN8811H_PHY_FW_STATUS, reg_value,
> +					    reg_value == EN8811H_PHY_READY,
> +					    20000, 7500000, true);
> +
> +	ret = air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION, &pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (pollret || !pbus_value) {
> +		phydev_err(phydev, "Firmware not ready: 0x%x\n", reg_value);
> +		return -ENODEV;
> +	}
> +
> +	if (!priv->firmware_version) {
> +		phydev_info(phydev, "MD32 firmware version: %08x\n", pbus_value);
> +		priv->firmware_version = pbus_value;
> +	}
> +
> +	/* Select mode 1, the only mode supported */

Maybe a comment about what mode 1 actually is?

> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_1,
> +			    AIR_PHY_HOST_CMD_1_MODE1);
> +	if (ret < 0)
> +		return ret;
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_2,
> +			    AIR_PHY_HOST_CMD_2_MODE1);
> +	if (ret < 0)
> +		return ret;
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_3,
> +			    AIR_PHY_HOST_CMD_3_MODE1);
> +	if (ret < 0)
> +		return ret;
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_4,
> +			    AIR_PHY_HOST_CMD_4_MODE1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Serdes polarity */
> +	pbus_value = 0;
> +	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
> +		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
> +	else
> +		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
> +	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
> +		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
> +	else
> +		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
> +				      EN8811H_POLARITY_RX_REVERSE |
> +				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
> +			    AIR_LED_MODE_USER_DEFINE);
> +	if (ret < 0) {
> +		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
> +				      EN8811H_GPIO_OUTPUT_345,
> +				      EN8811H_GPIO_OUTPUT_345);

What does this do? Configure them as inputs? Hopefully they are inputs
by default, or at least Hi-Z.

> +static int en8811h_get_features(struct phy_device *phydev)
> +{
> +	linkmode_set_bit_array(phy_basic_ports_array,
> +			       ARRAY_SIZE(phy_basic_ports_array),
> +			       phydev->supported);
> +
> +	return genphy_c45_pma_read_abilities(phydev);
> +}
> +

> +static int en8811h_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	int ret;
> +	u32 adv;
> +
> +	adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, adv);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	return __genphy_config_aneg(phydev, changed);

There was a comment that it does not support forced link mode, only
auto-neg? It would be good to test the configuration here and return
EOPNOTSUPP, or EINVAL if auto-neg is turned off.

> +}
> +
> +static int en8811h_read_status(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	u32 pbus_value;
> +	int ret, val;
> +
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	ret = genphy_read_master_slave(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_read_lpa(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Get link partner 2.5GBASE-T ability from vendor register */
> +	ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
> +	if (ret < 0)
> +		return ret;
> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->lp_advertising,
> +			 pbus_value & EN8811H_2P5G_LPA_2P5G);
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)

Is the first part of that expression needed? I thought you could not
turn auto-neg off?

> +
> +	/* Only supports full duplex */
> +	phydev->duplex = DUPLEX_FULL;

What does en8811h_get_features() indicate the PHY can do? Are any 1/2
duplex modes listed?

       Andrew

