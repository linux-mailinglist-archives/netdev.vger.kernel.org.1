Return-Path: <netdev+bounces-43736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADD17D458A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 04:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACD11C20B8C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15C1FC2;
	Tue, 24 Oct 2023 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sv1DZlmj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C771172B;
	Tue, 24 Oct 2023 02:34:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9F10E;
	Mon, 23 Oct 2023 19:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uRBH5xj5OQGLHiQskLOllsNyGfVBzFgpBHyO/FBi0PE=; b=Sv1DZlmjlpXWZMobMer65I5DgG
	5ItL9ba2DyCOgt/qWmK+fK71kQrueOK/TyhNseWGggUVj/HYVy4yTqxtqHHQfPpUpN041XqfVRa+v
	FnTtGPgLRSn1vK/dJSba8olxs6rpC5y3u5eyFAYIv8VHsCF3crzBt0+krftN2e0RC5Wc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qv7Em-00026a-OZ; Tue, 24 Oct 2023 04:33:44 +0200
Date: Tue, 24 Oct 2023 04:33:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <eee6df3d-5e6b-4b4c-bfcc-55b31814fb82@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>

> +static int lan865x_set_hw_macaddr(struct net_device *netdev)
> +{
> +	u32 regval;
> +	bool ret;
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	const u8 *mac = netdev->dev_addr;
> +
> +	ret = oa_tc6_read_register(priv->tc6, LAN865X_MAC_NCR, &regval);
> +	if (ret)
> +		goto error_mac;
> +	if ((regval & LAN865X_TXEN) | (regval & LAN865X_RXEN)) {

Would testing netif_running(netdev) be enough? That is a more common
test you see. In fact, you already have that in
lan865x_set_mac_address(). And in lan865x_probe() why would the
hardware be enabled?


> +		if (netif_msg_drv(priv))
> +			netdev_warn(netdev, "Hardware must be disabled for MAC setting\n");
> +		return -EBUSY;
> +	}
> +	/* MAC address setting */
> +	regval = (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
> +	ret = oa_tc6_write_register(priv->tc6, LAN865X_MAC_SAB1, regval);
> +	if (ret)
> +		goto error_mac;
> +
> +	regval = (mac[5] << 8) | mac[4];
> +	ret = oa_tc6_write_register(priv->tc6, LAN865X_MAC_SAT1, regval);
> +	if (ret)
> +		goto error_mac;
> +
> +	return 0;
> +
> +error_mac:
> +	return -ENODEV;

oa_tc6_write_register() should return an error code, so return it.

> +static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
> +{
> +	struct sockaddr *address = addr;
> +
> +	if (netif_running(netdev))
> +		return -EBUSY;
> +
> +	eth_hw_addr_set(netdev, address->sa_data);
> +
> +	return lan865x_set_hw_macaddr(netdev);

You should ideally only update the netdev MAC address, if you managed
to change the value in the hardware.

> +static void lan865x_set_multicast_list(struct net_device *netdev)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	u32 regval = 0;
> +
> +	if (netdev->flags & IFF_PROMISC) {
> +		/* Enabling promiscuous mode */
> +		regval |= MAC_PROMISCUOUS_MODE;
> +		regval &= (~MAC_MULTICAST_MODE);
> +		regval &= (~MAC_UNICAST_MODE);
> +	} else if (netdev->flags & IFF_ALLMULTI) {
> +		/* Enabling all multicast mode */
> +		regval &= (~MAC_PROMISCUOUS_MODE);
> +		regval |= MAC_MULTICAST_MODE;
> +		regval &= (~MAC_UNICAST_MODE);
> +	} else if (!netdev_mc_empty(netdev)) {
> +		/* Enabling specific multicast addresses */
> +		struct netdev_hw_addr *ha;
> +		u32 hash_lo = 0;
> +		u32 hash_hi = 0;
> +
> +		netdev_for_each_mc_addr(ha, netdev) {
> +			u32 bit_num = lan865x_hash(ha->addr);
> +			u32 mask = 1 << (bit_num & 0x1f);
> +
> +			if (bit_num & 0x20)
> +				hash_hi |= mask;
> +			else
> +				hash_lo |= mask;
> +		}
> +		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRT, hash_hi)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashh");
> +			return;
> +		}
> +		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRB, hash_lo)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashl");
> +			return;
> +		}
> +		regval &= (~MAC_PROMISCUOUS_MODE);
> +		regval &= (~MAC_MULTICAST_MODE);
> +		regval |= MAC_UNICAST_MODE;
> +	} else {
> +		/* enabling local mac address only */
> +		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRT, regval)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashh");
> +			return;
> +		}
> +		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRB, regval)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashl");
> +			return;
> +		}
> +	}
> +	if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_NCFGR, regval)) {
> +		if (netif_msg_timer(priv))
> +			netdev_err(netdev, "Failed to enable promiscuous mode");
> +	}
> +}

Another of those big functions which could be lots of simple functions
each doing one thing.

> +/* Configures the number of bytes allocated to each buffer in the
> + * transmit/receive queue. LAN865x supports only 64 and 32 bytes cps and also 64
> + * is the default value. So it is enough to configure the queue buffer size only
> + * for 32 bytes. Generally cps can't be changed during run time and also it is
> + * configured in the device tree. The values for the Tx/Rx queue buffer size are
> + * taken from the LAN865x datasheet.
> + */

Its unclear why this needs to be a callback. Why not just set it after
oa_tc6_init() returns?

> +static void lan865x_remove(struct spi_device *spi)
> +{
> +	struct lan865x_priv *priv = spi_get_drvdata(spi);
> +
> +	oa_tc6_exit(priv->tc6);
> +	unregister_netdev(priv->netdev);

Is that the correct order? Seems like you should unregister the netdev
first.

> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id lan865x_acpi_ids[] = {
> +	{ .id = "LAN865X",
> +	},
> +	{},

Does this work? You don't have access to the device tree properties.

     Andrew

