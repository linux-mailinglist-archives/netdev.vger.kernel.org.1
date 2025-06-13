Return-Path: <netdev+bounces-197509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CAAAD8F9C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F758177799
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F218DB24;
	Fri, 13 Jun 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wq70cfaT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4D2E11B7;
	Fri, 13 Jun 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825189; cv=none; b=cxD3aIo3TysAYZhPGtBn9Eq0+szIFM/aRLkMKFyBEvjMVvnWWYSP3obPAeuhhV/913z85GI+y0Ahv//TofATMkAkCROKY7F3J1oj3686c+EC3E/NIyY6Pxs02P4MDK8TVQf7GfVnwJ3sRdAxIwXc1Asj3VX71wQk0WIBujhAKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825189; c=relaxed/simple;
	bh=+tGBh2xEXyza6ldfEuLaYVOyjFoxkRAurInMANakuI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUHNz1xGQhu4GZ/DQJO+xxaT2vrJI3+gfmQBPuJI2iPYCBeR9oDEwB1d3VAvCdywK5YIErDBRDGwkc7G5BwF/O5guK3u8G0FwqJOEaX8xpppX1zJkWWQf+6c7TcspbVZgyOBm1NRswSORJm0APvF5auatSffiVaaVjaKCGSUhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wq70cfaT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OZdLTKOM+SyNN/BzmASFxjmQtXgHRiiVdbzYVC+5Q1U=; b=wq70cfaTCu0rFr5CfCeK/6sqUf
	WgaegOZzmKLcFM1WEOQYpf33BOoTBa+KbzzcS45bdON7r+WYo91rTTKikpVElQ+mV4HxedRKcij7E
	D4GIY5s+Mup6iPes52ehmNCDlHNH1zrkWE3UTbOnxepuSiFzgzehKulaKU8vqb6kix50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ5ST-00Fj6r-01; Fri, 13 Jun 2025 16:32:41 +0200
Date: Fri, 13 Jun 2025 16:32:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, Vivian Wang <uwu@dram.page>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: spacemit: Add K1 Ethernet MAC
Message-ID: <7dfcfb04-8a7f-4884-9c91-413a6fb2a56b@lunn.ch>
References: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
 <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>

> +static inline void emac_wr(struct emac_priv *priv, u32 reg, u32 val)
> +{
> +	writel(val, priv->iobase + reg);
> +}
> +
> +static inline int emac_rd(struct emac_priv *priv, u32 reg)
> +{
> +	return readl(priv->iobase + reg);
> +}

I only took a very quick look at the code. I'm sure there are more
issues....

Please do not user inline functions in a .c file. Let the compiler
decide.

> +static void emac_alloc_rx_desc_buffers(struct emac_priv *priv);
> +static int emac_phy_connect(struct net_device *dev);
> +static void emac_tx_timeout_task(struct work_struct *work);

No forward declarations. Move the code around so they are not needed.

> +static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	if (!netif_running(ndev))
> +		return -EINVAL;
> +
> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +	case SIOCGMIIREG:
> +	case SIOCSMIIREG:

There is no need to test for these values. Just call phy_mii_ioctl()
and it will only act on IOCTLs it knows.

> +		if (!ndev->phydev)
> +			return -EINVAL;
> +		ret = phy_mii_ioctl(ndev->phydev, rq, cmd);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +static int emac_up(struct emac_priv *priv)
> +{
> +	struct platform_device *pdev = priv->pdev;
> +	struct net_device *ndev = priv->ndev;
> +	int ret;
> +
> +#ifdef CONFIG_PM_SLEEP
> +	pm_runtime_get_sync(&pdev->dev);
> +#endif

You don't need this #ifdef, there is a stub function is PM_SLEEP is
not enabled.

> +
> +	ret = emac_phy_connect(ndev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "emac_phy_connect failed\n");
> +		goto err;
> +	}
> +
> +	emac_init_hw(priv);
> +
> +	emac_set_mac_addr(priv, ndev->dev_addr);
> +	emac_configure_tx(priv);
> +	emac_configure_rx(priv);
> +
> +	emac_alloc_rx_desc_buffers(priv);
> +
> +	if (ndev->phydev)
> +		phy_start(ndev->phydev);

Is it possible to not have a PHY? emac_phy_connect() seems to return
an error if it cannot find one.

> +static int emac_down(struct emac_priv *priv)
> +{
> +	struct platform_device *pdev = priv->pdev;
> +	struct net_device *ndev = priv->ndev;
> +
> +	netif_stop_queue(ndev);
> +
> +	if (ndev->phydev) {
> +		phy_stop(ndev->phydev);
> +		phy_disconnect(ndev->phydev);
> +	}
> +
> +	priv->link = false;
> +	priv->duplex = DUPLEX_UNKNOWN;
> +	priv->speed = SPEED_UNKNOWN;
> +
> +	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
> +	emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
> +
> +	free_irq(priv->irq, ndev);
> +
> +	napi_disable(&priv->napi);
> +
> +	emac_reset_hw(priv);
> +	netif_carrier_off(ndev);

phylib will of done this when phy_stop() is called. Let phylib manage
the carrier. The only thing you probably need is netif_carrier_off()
in probe().

> +static int emac_change_mtu(struct net_device *ndev, int mtu)
> +{
> +	struct emac_priv *priv = netdev_priv(ndev);
> +	u32 frame_len;
> +
> +	if (netif_running(ndev)) {
> +		netdev_err(ndev, "must be stopped to change MTU\n");
> +		return -EBUSY;
> +	}
> +
> +	frame_len = mtu + ETHERNET_HEADER_SIZE + ETHERNET_FCS_SIZE;
> +
> +	if (frame_len < MINIMUM_ETHERNET_FRAME_SIZE ||
> +	    frame_len > EMAC_RX_BUF_4K) {
> +		netdev_err(ndev, "Invalid MTU setting\n");
> +		return -EINVAL;
> +	}

If you set ndev->mtu_max and ndev->mtu_min, the core will check this
for you.

> +static void emac_reset(struct emac_priv *priv)
> +{
> +	if (!test_and_clear_bit(EMAC_RESET_REQUESTED, &priv->state))
> +		return;
> +	if (test_bit(EMAC_DOWN, &priv->state))
> +		return;
> +
> +	netdev_err(priv->ndev, "Reset controller\n");
> +
> +	rtnl_lock();
> +	netif_trans_update(priv->ndev);
> +	while (test_and_set_bit(EMAC_RESETING, &priv->state))
> +		usleep_range(1000, 2000);

Don't do endless loops waiting for the hardware. It may never
happen. Please use something from iopoll.h

> +static int emac_mii_read(struct mii_bus *bus, int phy_addr, int regnum)
> +{
> +	struct emac_priv *priv = bus->priv;
> +	u32 cmd = 0;
> +	u32 val;
> +
> +	cmd |= phy_addr & 0x1F;
> +	cmd |= (regnum & 0x1F) << 5;
> +	cmd |= MREGBIT_START_MDIO_TRANS | MREGBIT_MDIO_READ_WRITE;
> +
> +	emac_wr(priv, MAC_MDIO_DATA, 0x0);
> +	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
> +
> +	if (readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
> +			       !((val >> 15) & 0x1), 100, 10000))
> +		return -EBUSY;

readl_poll_timeout() returns an error code. Don't replace it.

> +static void emac_adjust_link(struct net_device *dev)
> +{
> +	struct emac_priv *priv = netdev_priv(dev);
> +	struct phy_device *phydev = dev->phydev;
> +	bool link_changed = false;
> +	u32 ctrl;
> +
> +	if (!phydev)
> +		return;

How does that happen?

> +	if (phydev->link) {
> +		ctrl = emac_rd(priv, MAC_GLOBAL_CONTROL);
> +
> +		/* Update duplex and speed from PHY */
> +
> +		if (phydev->duplex != priv->duplex) {
> +			link_changed = true;
> +
> +			if (!phydev->duplex)
> +				ctrl &= ~MREGBIT_FULL_DUPLEX_MODE;
> +			else
> +				ctrl |= MREGBIT_FULL_DUPLEX_MODE;
> +			priv->duplex = phydev->duplex;
> +		}
> +
> +		if (phydev->speed != priv->speed) {
> +			link_changed = true;
> +
> +			ctrl &= ~MREGBIT_SPEED;
> +
> +			switch (phydev->speed) {
> +			case SPEED_1000:
> +				ctrl |= MREGBIT_SPEED_1000M;
> +				break;
> +			case SPEED_100:
> +				ctrl |= MREGBIT_SPEED_100M;
> +				break;
> +			case SPEED_10:
> +				ctrl |= MREGBIT_SPEED_10M;
> +				break;
> +			default:
> +				netdev_err(dev, "Unknown speed: %d\n",
> +					   phydev->speed);
> +				phydev->speed = SPEED_UNKNOWN;
> +				break;
> +			}
> +
> +			if (phydev->speed != SPEED_UNKNOWN)
> +				priv->speed = phydev->speed;
> +		}
> +
> +		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
> +
> +		if (!priv->link) {
> +			priv->link = true;
> +			link_changed = true;
> +		}
> +	} else if (priv->link) {
> +		priv->link = false;
> +		link_changed = true;
> +		priv->duplex = DUPLEX_UNKNOWN;
> +		priv->speed = SPEED_UNKNOWN;
> +	}
> +
> +	if (link_changed)
> +		phy_print_status(phydev);

Can this ever be false?

> +static int emac_phy_connect(struct net_device *ndev)
> +{
> +	struct emac_priv *priv = netdev_priv(ndev);
> +	struct device *dev = &priv->pdev->dev;
> +	struct phy_device *phydev;
> +	struct device_node *np;
> +	int ret;
> +
> +	ret = of_get_phy_mode(dev->of_node, &priv->phy_interface);
> +	if (ret) {
> +		dev_err(dev, "No phy-mode found");
> +		return ret;
> +	}
> +
> +	np = of_parse_phandle(dev->of_node, "phy-handle", 0);
> +	if (!np && of_phy_is_fixed_link(dev->of_node))
> +		np = of_node_get(dev->of_node);
> +	if (!np) {
> +		dev_err(dev, "No PHY specified");
> +		return -ENODEV;
> +	}
> +
> +	ret = emac_phy_interface_config(priv);
> +	if (ret)
> +		goto err_node_put;
> +
> +	phydev = of_phy_connect(ndev, np, &emac_adjust_link, 0,
> +				priv->phy_interface);
> +	if (IS_ERR_OR_NULL(phydev)) {
> +		dev_err(dev, "Could not attach to PHY\n");
> +		ret = phydev ? PTR_ERR(phydev) : -ENODEV;
> +		goto err_node_put;
> +	}
> +
> +	dev_info(dev, "%s: attached to PHY (UID 0x%x) Link = %d\n", ndev->name,
> +		 phydev->phy_id, phydev->link);

Don't spam the log. Only output something if something unexpected
happens, an error etc.

> +static int emac_mdio_init(struct emac_priv *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct device_node *mii_np;
> +	struct mii_bus *mii;
> +	int ret;
> +
> +	mii_np = of_get_child_by_name(dev->of_node, "mdio-bus");
> +	if (!mii_np) {
> +		if (of_phy_is_fixed_link(dev->of_node)) {
> +			if ((of_phy_register_fixed_link(dev->of_node) < 0))
> +				return -ENODEV;
> +
> +			return 0;
> +		}
> +
> +		dev_err(dev, "no %s child node found", "mdio-bus");

Why is that an error?

> +		return -ENODEV;
> +	}
> +
> +	if (!of_device_is_available(mii_np)) {
> +		ret = -ENODEV;
> +		goto err_put_node;
> +	}
> +
> +	mii = devm_mdiobus_alloc(dev);
> +	priv->mii = mii;
> +
> +	if (!mii) {
> +		ret = -ENOMEM;
> +		goto err_put_node;
> +	}
> +	mii->priv = priv;
> +	mii->name = "emac mii";
> +	mii->read = emac_mii_read;
> +	mii->write = emac_mii_write;
> +	mii->parent = dev;
> +	mii->phy_mask = 0xffffffff;
> +	snprintf(mii->id, MII_BUS_ID_SIZE, "%s", priv->pdev->name);
> +
> +	ret = devm_of_mdiobus_register(dev, mii, mii_np);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register mdio bus.\n");
> +		goto err_put_node;
> +	}
> +
> +	priv->phy = phy_find_first(mii);
> +	if (!priv->phy) {
> +		dev_err(dev, "no PHY found\n");
> +		ret = -ENODEV;

Please don't use phy_find_first(). Use phy-handle to point to the phy.

> +static void emac_ethtool_get_regs(struct net_device *dev,
> +				  struct ethtool_regs *regs, void *space)
> +{
> +	struct emac_priv *priv = netdev_priv(dev);
> +	u32 *reg_space = space;
> +	int i;
> +
> +	regs->version = 1;
> +
> +	memset(reg_space, 0x0, EMAC_REG_SPACE_SIZE);

Is that needed?

> +static int emac_get_link_ksettings(struct net_device *ndev,
> +				   struct ethtool_link_ksettings *cmd)
> +{
> +	if (!ndev->phydev)
> +		return -ENODEV;
> +
> +	phy_ethtool_ksettings_get(ndev->phydev, cmd);

phy_ethtool_get_link_ksettings().

> +	if (priv->tx_delay > EMAC_MAX_DELAY_PS) {
> +		dev_err(&pdev->dev, "tx-internal-delay-ps delay too large, clamped");

Please return -EINVAL;

> +		priv->tx_delay = EMAC_MAX_DELAY_PS;
> +	}
> +
> +	if (priv->rx_delay > EMAC_MAX_DELAY_PS) {
> +		dev_err(&pdev->dev, "rx-internal-delay-ps delay too large, clamped");

and here. The device tree is broken, and we want the developer to
notice and fix it. The easiest way to do that is to refuse to load the
driver.

> +		priv->rx_delay = EMAC_MAX_DELAY_PS;
> +	}
> +
> +	if (priv->tx_delay || priv->rx_delay) {

Why the if () ?

> +		priv->tx_delay = delay_ps_to_unit(priv->tx_delay);
> +		priv->rx_delay = delay_ps_to_unit(priv->rx_delay);
> +
> +		/* Show rounded result here for convenience */
> +		dev_info(&pdev->dev,
> +			 "MAC internal delay: TX: %u ps, RX: %u ps",
> +			 delay_unit_to_ps(priv->tx_delay),
> +			 delay_unit_to_ps(priv->rx_delay));

Please don't. 

> +static void emac_shutdown(struct platform_device *pdev)
> +{
> +}

Since it is empty, is it needed?

	Andrew

