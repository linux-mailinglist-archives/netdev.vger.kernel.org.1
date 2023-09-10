Return-Path: <netdev+bounces-32737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1069799F21
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEA0280C8A
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78F847F;
	Sun, 10 Sep 2023 17:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483E257F
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 17:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264C9C433C7;
	Sun, 10 Sep 2023 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694367900;
	bh=ya1knFSJ1r+Lvg/WLQ84AsNh2jega9+r17X6FyPGaIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enNghr0cMVrwnvt3uSL68ki153nWnkCuJFzgWaXyCyPr/m+eHoR9mFELEN+JjdJZT
	 e27E9n3yBSma/N1/hxODKfu2EBtkQl2qMNSLqJm8kTbxxuc4Kar/Ka+VroDfHasoUv
	 iZKL1Uo33krVbNg8CVnfZF9OU/qLyRMYejqqL0zGKDbcJgxKAnRq2baJDY7Cns9R+F
	 PEoMc72IOYzsJ51D2aEEcRho+PAGx4itR2z+0Jh1bHhj5k6FC5Woa48Zl1aiLuif1u
	 UdcIwSmdcPOUZfKdloxrLHrr2cSM52o0B1SHG2Gxmtb4dZxVrSpCCUdJiqOulMMo0p
	 EqjYAJXdkw+Jw==
Date: Sun, 10 Sep 2023 19:44:53 +0200
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	casper.casan@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <20230910174453.GK775887@kernel.org>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>

On Fri, Sep 08, 2023 at 07:59:18PM +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE‑T1x
> MAC‑PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
> 
> By default, the chunk data payload is 64 bytes in size. A smaller payload
> data size of 32 bytes is also supported and may be configured in the
> Chunk Payload Size (CPS) field of the Configuration 0 (OA_CONFIG0)
> register. Changing the chunk payload size requires the LAN8650/1 be reset
> and shall not be done during normal operation.
> 
> The Ethernet Media Access Controller (MAC) module implements a 10 Mbps
> half duplex Ethernet MAC, compatible with the IEEE 802.3 standard.
> 10BASE-T1S physical layer transceiver integrated into the LAN8650/1. The
> PHY and MAC are connected via an internal Media Independent Interface
> (MII).
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Hi Parthiban,

thanks for your patches.
Some minor feedback on this one follows.

...

> diff --git a/drivers/net/ethernet/microchip/lan865x.c b/drivers/net/ethernet/microchip/lan865x.c

...

> +static int lan865x_set_hw_macaddr(struct net_device *netdev)
> +{
> +	u32 regval;
> +	bool ret;
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	const u8 *mac = netdev->dev_addr;

Please arrange local variables in Networking code in reverse xmas tree
order - longest line to shortest.

This tool can be of assistance here:
https://github.com/ecree-solarflare/xmastree

...

> +static int lan865x_probe(struct spi_device *spi)
> +{
> +	struct net_device *netdev;
> +	struct lan865x_priv *priv;
> +	u32 regval;
> +	int ret;
> +
> +	netdev = alloc_etherdev(sizeof(struct lan865x_priv));
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	priv = netdev_priv(netdev);
> +	priv->netdev = netdev;
> +	priv->spi = spi;
> +	priv->msg_enable = 0;
> +	spi_set_drvdata(spi, priv);
> +	SET_NETDEV_DEV(netdev, &spi->dev);
> +
> +	ret = lan865x_get_dt_data(priv);
> +	if (ret)
> +		return ret;
> +
> +	spi->rt = true;
> +	spi_setup(spi);
> +
> +	priv->tc6 = oa_tc6_init(spi, netdev);
> +	if (!priv->tc6) {
> +		ret = -ENOMEM;
> +		goto error_oa_tc6_init;
> +	}
> +
> +	if (priv->cps == 32) {
> +		regval = CCS_Q0_TX_CFG_32;
> +		ret = oa_tc6_write_register(priv->tc6, CCS_Q0_TX_CFG, &regval, 1);
> +		if (ret)
> +			return ret;
> +
> +		regval = CCS_Q0_RX_CFG_32;
> +		ret = oa_tc6_write_register(priv->tc6, CCS_Q0_RX_CFG, &regval, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (oa_tc6_configure(priv->tc6, priv->cps, priv->protected, priv->txcte,
> +			     priv->rxcte))
> +		goto err_macphy_config;

Jumping to err_macphy_config will result in this function returning ret.
However, ret will be 0 at this point. Perhaps it should be set to an
error value.

Flagged by Smatch.

> +
> +	ret = lan865x_phy_init(priv);
> +	if (ret)
> +		goto error_phy;
> +
> +	if (device_get_ethdev_address(&spi->dev, netdev))
> +		eth_hw_addr_random(netdev);
> +
> +	ret = lan865x_set_hw_macaddr(netdev);
> +	if (ret) {
> +		if (netif_msg_probe(priv))
> +			dev_err(&spi->dev, "Failed to configure MAC");
> +		goto error_set_mac;
> +	}
> +
> +	netdev->if_port = IF_PORT_10BASET;
> +	netdev->irq = spi->irq;
> +	netdev->netdev_ops = &lan865x_netdev_ops;
> +	netdev->watchdog_timeo = TX_TIMEOUT;
> +	netdev->ethtool_ops = &lan865x_ethtool_ops;
> +	ret = register_netdev(netdev);
> +	if (ret) {
> +		if (netif_msg_probe(priv))
> +			dev_err(&spi->dev, "Register netdev failed (ret = %d)",
> +				ret);
> +		goto error_netdev_register;
> +	}
> +
> +	phy_start(priv->phydev);
> +	return 0;
> +
> +error_netdev_register:
> +error_set_mac:
> +	phy_disconnect(priv->phydev);
> +	mdiobus_unregister(priv->mdiobus);
> +	mdiobus_free(priv->mdiobus);
> +error_phy:
> +err_macphy_config:
> +	oa_tc6_deinit(priv->tc6);
> +error_oa_tc6_init:
> +	free_netdev(priv->netdev);
> +	return ret;
> +}


...

