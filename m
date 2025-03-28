Return-Path: <netdev+bounces-178157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38051A750C9
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BABD188DA6C
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 19:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D41DF24F;
	Fri, 28 Mar 2025 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qg/RgZsH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39B126C02;
	Fri, 28 Mar 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190264; cv=none; b=CofCZ9h+DTkStQKK3tn5BQlu5IyMZbx8EYoqkmbJZwkP+Xptp9LFWQjQ5SrG3E2srLKtK9w83RugCwvIctjfl+3j/C1BDfzAwsy/HcEBAuJ/NJAE0dWWPy6fWwxOjuNCfengN8YT+udyRqaaSa2vO0r87iIynAkk5fJoHwYzyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190264; c=relaxed/simple;
	bh=5Vyke7PQtp35YSTCuyTIpzWCfCa5Ve46bWr/HsMvFQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHdHjpObZ3zJQJbcMKtOlQa4wNH9EouYsxBZtjC0j4UjR2d8UROPoIh4F+HFLc+66lhZLbpDx/CfO8vzbGcbwPpSFAV0hlfT8Zo3M9VYJ/CqGnx5OTTYWvvvPU8VJcECDEfWhe5pkUTvu6L8gmypW9C9l709SdcDERyBEGo/em4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qg/RgZsH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TFduLiTfomk9uJG1Kj9Vc20+YiO1goOrnmEnJTn6ZxQ=; b=Qg/RgZsHJ6n5TSHc9kOVCiY3q+
	jwDA83rcvHJ4eU0fyc6UKImuj4/1gn8A7Zj8trcIhavWYd/tLlc6Jwza6elEtnBv5D6hTLcXM6fNG
	SH0IBUg5HRH7abQVfr6lIEul5kl1EzkzXwVfUVZ+h+O1ZB4wWRw0BT9lxJCLAQbC/m4w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tyFPi-007O5S-8p; Fri, 28 Mar 2025 20:30:46 +0100
Date: Fri, 28 Mar 2025 20:30:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <3648e94f-93e6-4fb0-a432-f834fe755ee3@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
 <20250328133544.4149716-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328133544.4149716-5-lukma@denx.de>

> +static bool bridge_offload;
> +module_param(bridge_offload, bool, 0644); /* Allow setting by root on boot */
> +MODULE_PARM_DESC(bridge_offload, "L2 switch offload mode enable:1, disable:0");

Please drop. module parameters are not liked.

In Linux, ports of a switch always starting in isolated mode, and
userspace needs to add them to the same bridge.

> +
> +static netdev_tx_t mtip_start_xmit(struct sk_buff *skb,
> +				   struct net_device *dev);
> +static void mtip_switch_tx(struct net_device *dev);
> +static int mtip_switch_rx(struct net_device *dev, int budget, int *port);
> +static void mtip_set_multicast_list(struct net_device *dev);
> +static void mtip_switch_restart(struct net_device *dev, int duplex0,
> +				int duplex1);

Forwards references are not like. Put the functions in the correct
order so they are not needed.

> +/* Calculate Galois Field Arithmetic CRC for Polynom x^8+x^2+x+1.
> + * It omits the final shift in of 8 zeroes a "normal" CRC would do
> + * (getting the remainder).
> + *
> + *  Examples (hexadecimal values):<br>
> + *   10-11-12-13-14-15  => CRC=0xc2
> + *   10-11-cc-dd-ee-00  => CRC=0xe6
> + *
> + *   param: pmacaddress
> + *          A 6-byte array with the MAC address.
> + *          The first byte is the first byte transmitted
> + *   return The 8-bit CRC in bits 7:0
> + */
> +static int crc8_calc(unsigned char *pmacaddress)
> +{
> +	/* byte index */
> +	int byt;
> +	/* bit index */
> +	int bit;
> +	int inval;
> +	int crc;

Reverse Christmas tree. Please look through the whole driver and fix
it up.

> +/* updates MAC address lookup table with a static entry
> + * Searches if the MAC address is already there in the block and replaces
> + * the older entry with new one. If MAC address is not there then puts a
> + * new entry in the first empty slot available in the block
> + *
> + * mac_addr Pointer to the array containing MAC address to
> + *          be put as static entry
> + * port     Port bitmask numbers to be added in static entry,
> + *          valid values are 1-7
> + * priority The priority for the static entry in table
> + *
> + * return 0 for a successful update else -1  when no slot available

It would be nice to turn this into proper kerneldoc. It is not too far
away at the moment.

Also, return a proper error code not -1. ENOSPC?

> +static int mtip_update_atable_dynamic1(unsigned long write_lo,
> +				       unsigned long write_hi, int block_index,
> +				       unsigned int port,
> +				       unsigned int curr_time,
> +				       struct switch_enet_private *fep)

It would be good to document the return value, because it is not the
usual 0 success or negative error code.

> +static const struct net_device_ops mtip_netdev_ops;

more forward declarations.

> +struct switch_enet_private *mtip_netdev_get_priv(const struct net_device *ndev)
> +{
> +	if (ndev->netdev_ops == &mtip_netdev_ops)
> +		return netdev_priv(ndev);
> +
> +	return NULL;
> +}

I _think_ the return value is not actually used. So maybe 0 or
-ENODEV?

> +static int esw_mac_addr_static(struct switch_enet_private *fep)
> +{
> +	int i;
> +
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		if (is_valid_ether_addr(fep->ndev[i]->dev_addr)) {

Is that possible? This is the interfaces own MAC address? If it is not
valid, the probe should of failed.

> +			mtip_update_atable_static((unsigned char *)
> +						  fep->ndev[i]->dev_addr,
> +						  7, 7, fep);
> +		} else {
> +			dev_err(&fep->pdev->dev,
> +				"Can not add mac address %pM to switch!\n",
> +				fep->ndev[i]->dev_addr);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtip_print_link_status(struct phy_device *phydev)
> +{
> +	if (phydev->link)
> +		netdev_info(phydev->attached_dev,
> +			    "Link is Up - %s/%s - flow control %s\n",
> +			    phy_speed_to_str(phydev->speed),
> +			    phy_duplex_to_str(phydev->duplex),
> +			    phydev->pause ? "rx/tx" : "off");
> +	else
> +		netdev_info(phydev->attached_dev, "Link is Down\n");
> +}

phy_print_status()

> +static void mtip_adjust_link(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct phy_device *phy_dev;
> +	int status_change = 0, idx;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fep->hw_lock, flags);
> +
> +	idx = priv->portnum - 1;
> +	phy_dev = fep->phy_dev[idx];
> +
> +	/* Prevent a state halted on mii error */
> +	if (fep->mii_timeout && phy_dev->state == PHY_HALTED) {
> +		phy_dev->state = PHY_UP;
> +		goto spin_unlock;
> +	}

A MAC driver should not be playing around with the internal state of
phylib.

> +static int mtip_mii_probe(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	int port_idx = priv->portnum - 1;
> +	struct phy_device *phy_dev = NULL;
> +
> +	if (fep->phy_np[port_idx]) {
> +		phy_dev = of_phy_connect(dev, fep->phy_np[port_idx],
> +					 &mtip_adjust_link, 0,
> +					 fep->phy_interface[port_idx]);
> +		if (!phy_dev) {
> +			netdev_err(dev, "Unable to connect to phy\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	phy_set_max_speed(phy_dev, 100);
> +	fep->phy_dev[port_idx] = phy_dev;
> +	fep->link[port_idx] = 0;
> +	fep->full_duplex[port_idx] = 0;
> +
> +	dev_info(&dev->dev,
> +		 "MTIP PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
> +		 fep->phy_dev[port_idx]->drv->name,
> +		 phydev_name(fep->phy_dev[port_idx]),
> +		 fep->phy_dev[port_idx]->irq);

phylib already prints something like that.

> +static int mtip_mdiobus_reset(struct mii_bus *bus)
> +{
> +	if (!bus || !bus->reset_gpiod) {
> +		dev_err(&bus->dev, "Reset GPIO pin not provided!\n");
> +		return -EINVAL;
> +	}
> +
> +	gpiod_set_value_cansleep(bus->reset_gpiod, 1);
> +
> +	/* Extra time to allow:
> +	 * 1. GPIO RESET pin go high to prevent situation where its value is
> +	 *    "LOW" as it is NOT configured.
> +	 * 2. The ENET CLK to stabilize before GPIO RESET is asserted
> +	 */
> +	usleep_range(200, 300);
> +
> +	gpiod_set_value_cansleep(bus->reset_gpiod, 0);
> +	usleep_range(bus->reset_delay_us, bus->reset_delay_us + 1000);
> +	gpiod_set_value_cansleep(bus->reset_gpiod, 1);
> +
> +	if (bus->reset_post_delay_us > 0)
> +		usleep_range(bus->reset_post_delay_us,
> +			     bus->reset_post_delay_us + 1000);
> +
> +	return 0;
> +}

What is wrong with the core code __mdiobus_register() which does the
bus reset.

> +static void mtip_get_drvinfo(struct net_device *dev,
> +			     struct ethtool_drvinfo *info)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +
> +	strscpy(info->driver, fep->pdev->dev.driver->name,
> +		sizeof(info->driver));
> +	strscpy(info->version, VERSION, sizeof(info->version));

Leave this empty, so you get the git hash of the kernel.

> +static void mtip_ndev_setup(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +
> +	ether_setup(dev);

That is pretty unusual

> +	dev->ethtool_ops = &mtip_ethtool_ops;
> +	dev->netdev_ops = &mtip_netdev_ops;
> +
> +	memset(priv, 0, sizeof(struct mtip_ndev_priv));

priv should already be zero....

> +static int mtip_ndev_init(struct switch_enet_private *fep)
> +{
> +	struct mtip_ndev_priv *priv;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		fep->ndev[i] = alloc_netdev(sizeof(struct mtip_ndev_priv),
> +					    fep->ndev_name[i], NET_NAME_USER,
> +					    mtip_ndev_setup);

This explains the ether_setup(). It would be more normal to pass
ether_setup() here, and set dev->ethtool_ops and dev->netdev_ops here.

> +		if (!fep->ndev[i]) {
> +			ret = -1;

-ENOMEM?

> +			break;
> +		}
> +
> +		priv = netdev_priv(fep->ndev[i]);
> +		priv->fep = fep;
> +		priv->portnum = i + 1;
> +		fep->ndev[i]->irq = fep->irq;
> +
> +		ret = mtip_setup_mac(fep->ndev[i]);
> +		if (ret) {
> +			dev_err(&fep->ndev[i]->dev,
> +				"%s: ndev %s MAC setup err: %d\n",
> +				__func__, fep->ndev[i]->name, ret);
> +			break;
> +		}
> +
> +		ret = register_netdev(fep->ndev[i]);
> +		if (ret) {
> +			dev_err(&fep->ndev[i]->dev,
> +				"%s: ndev %s register err: %d\n", __func__,
> +				fep->ndev[i]->name, ret);
> +			break;
> +		}
> +		dev_info(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
> +			 fep->ndev[i]->name, fep->ndev[i]->dev_addr);

I would drop this. A driver is normally silent unless things go wrong.

> +	}
> +
> +	if (ret)
> +		mtip_ndev_cleanup(fep);
> +
> +	return 0;

return ret?

> +static int mtip_ndev_port_link(struct net_device *ndev,
> +			       struct net_device *br_ndev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev);
> +	struct switch_enet_private *fep = priv->fep;
> +
> +	dev_dbg(&ndev->dev, "%s: ndev: %s br: %s fep: 0x%x\n",
> +		__func__, ndev->name,  br_ndev->name, (unsigned int)fep);
> +
> +	/* Check if MTIP switch is already enabled */
> +	if (!fep->br_offload) {
> +		if (!priv->master_dev)
> +			priv->master_dev = br_ndev;

It needs to be a little bit more complex than that, because the two
ports could be assigned to two different bridges. You should only
enable hardware bridging if they are a member of the same bridge.

	Andrew

