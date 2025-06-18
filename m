Return-Path: <netdev+bounces-199239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B461ADF895
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C971BC3939
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A12798FF;
	Wed, 18 Jun 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hpg2gypn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67227979F;
	Wed, 18 Jun 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281495; cv=none; b=irrP6yyiPoMtsknq5VbsmR7JdO9XdwVkTZibJMydjQpsJ87WKlShNPnN9E5h0GQs8R9UerrUyAD0E8USwKg01bOmKeQlUK4ELQkuGWYWM4+e/nz5WanQroljlafd8hPQV57Ds5BRpDylNSM2ltrMpwkO6U/yMv6CH+7fjjA6zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281495; c=relaxed/simple;
	bh=cmQ02WE1thnbt+FouBpjl05lTRtmfIAFPeNWTSd/KDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ+fm4XN1Ha5N7jn2bUIEznSJqx3bjDh1RXfoCj8S60ENWjz5i93cBNDwwPsBFn+bz0uXs1z+og3rXtvhuK5muxnnTfWdsnQDaGBcoe5p1TZbdF9kWPDUBKn+KxhpBHI7+vKOm5vFwUjBkG4XzMFWS8j1iG0us/EkUXcw5aCjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hpg2gypn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iYf/tNomgSGgOz7BCTF6vtkNgttRW7/vxsBrfT0uQsA=; b=hpg2gypn+kJFjDrCSZDUtil1Ba
	6pMf9kt6UtVYEtL93a9okv/tzvA3XIQ9sOuWURR+YsyExYPt/oEk7cg8Zr6pSnT4pchtnt3Q5e+jk
	AmvFCPd2dx3Rx2sepkzQzk/4rO2/K5tnJWedHXp5LA+ozr8KFyO1WitOnTimRiE3c7pk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uS0A5-00GL1Y-7J; Wed, 18 Jun 2025 23:17:37 +0200
Date: Wed, 18 Jun 2025 23:17:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: spacemit: Add K1 Ethernet MAC
Message-ID: <e55d8a16-5e2c-4a46-99fd-8ea485269843@lunn.ch>
References: <20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn>
 <20250618-net-k1-emac-v2-2-94f5f07227a8@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-net-k1-emac-v2-2-94f5f07227a8@iscas.ac.cn>

> +/* The sizes (in bytes) of a ethernet packet */
> +#define ETHERNET_HEADER_SIZE		14

Please replace with ETH_HLEN

> +#define MINIMUM_ETHERNET_FRAME_SIZE	64 /* Incl. FCS */

I assume this device supports VLANS? If so, the minimum should
actually be 68. You can then use ETH_MIN_MTU

> +#define ETHERNET_FCS_SIZE		4

ETH_FCS_LEN

> +static int emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb,
> +			   u32 max_tx_len, u32 frag_num)
> +{
> +	struct emac_desc tx_desc, *tx_desc_addr;
> +	u32 skb_linear_len = skb_headlen(skb);
> +	struct emac_tx_desc_buffer *tx_buf;
> +	u32 len, i, f, first, buf_idx = 0;
> +	struct emac_desc_ring *tx_ring;
> +	phys_addr_t addr;
> +
> +	tx_ring = &priv->tx_ring;
> +
> +	i = tx_ring->head;
> +	first = i;
> +
> +	if (++i == tx_ring->total_cnt)
> +		i = 0;
> +
> +	/* If the data is fragmented */
> +	for (f = 0; f < frag_num; f++) {
> +		const skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
> +
> +		len = skb_frag_size(frag);
> +
> +		buf_idx = (f + 1) % 2;
> +
> +		/* First frag fill into second buffer of first descriptor */
> +		if (f == 0) {
> +			tx_buf = &tx_ring->tx_desc_buf[first];
> +			tx_desc_addr = &((struct emac_desc *)
> +						 tx_ring->desc_addr)[first];
> +			memset(&tx_desc, 0, sizeof(tx_desc));
> +		} else {
> +			/*
> +			 * From second frags to more frags,
> +			 * we only get new descriptor when frag num is odd.
> +			 */
> +			if (!buf_idx) {
> +				tx_buf = &tx_ring->tx_desc_buf[i];
> +				tx_desc_addr = &((struct emac_desc *)
> +							 tx_ring->desc_addr)[i];
> +				memset(&tx_desc, 0, sizeof(tx_desc));
> +			}
> +		}
> +		tx_buf->buf[buf_idx].dma_len = len;
> +
> +		addr = skb_frag_dma_map(&priv->pdev->dev, frag, 0,
> +					skb_frag_size(frag), DMA_TO_DEVICE);
> +
> +		if (dma_mapping_error(&priv->pdev->dev, addr)) {
> +			netdev_err(priv->ndev, "fail to map dma page: %d\n", f);
> +			goto dma_map_err;
> +		}
> +		tx_buf->buf[buf_idx].dma_addr = addr;
> +
> +		tx_buf->buf[buf_idx].map_as_page = true;
> +
> +		/* Every desc has two buffers for packet */
> +		if (buf_idx) {
> +			tx_desc.buffer_addr_2 = addr;
> +			tx_desc.desc1 |= make_buf_size_2(len);
> +		} else {
> +			tx_desc.buffer_addr_1 = addr;
> +			tx_desc.desc1 = make_buf_size_1(len);
> +
> +			if (++i == tx_ring->total_cnt) {
> +				tx_desc.desc1 |= TX_DESC_1_END_RING;
> +				i = 0;
> +			}
> +		}
> +
> +		if (f == 0) {
> +			*tx_desc_addr = tx_desc;
> +			continue;
> +		}
> +
> +		if (f == frag_num - 1) {
> +			tx_desc.desc1 |= TX_DESC_1_LAST_SEGMENT;
> +			tx_buf->skb = skb;
> +			if (emac_tx_should_interrupt(priv, frag_num + 1))
> +				tx_desc.desc1 |=
> +					TX_DESC_1_INTERRUPT_ON_COMPLETION;
> +		}
> +
> +		*tx_desc_addr = tx_desc;
> +		dma_wmb();
> +		WRITE_ONCE(tx_desc_addr->desc0, tx_desc.desc0 | TX_DESC_0_OWN);
> +	}
> +
> +	/* fill out first descriptor for skb linear data */
> +	tx_buf = &tx_ring->tx_desc_buf[first];
> +
> +	tx_buf->buf[0].dma_len = skb_linear_len;
> +
> +	addr = dma_map_single(&priv->pdev->dev, skb->data, skb_linear_len,
> +			      DMA_TO_DEVICE);
> +	if (dma_mapping_error(&priv->pdev->dev, addr)) {
> +		netdev_err(priv->ndev, "dma_map_single failed\n");
> +		goto dma_map_err;
> +	}
> +
> +	tx_buf->buf[0].dma_addr = addr;
> +
> +	tx_buf->buf[0].buff_addr = skb->data;
> +	tx_buf->buf[0].map_as_page = false;
> +
> +	/* Fill TX descriptor */
> +	tx_desc_addr = &((struct emac_desc *)tx_ring->desc_addr)[first];
> +
> +	tx_desc = *tx_desc_addr;
> +
> +	tx_desc.buffer_addr_1 = addr;
> +	tx_desc.desc1 |= make_buf_size_1(skb_linear_len);
> +	tx_desc.desc1 |= TX_DESC_1_FIRST_SEGMENT;
> +
> +	/* If last desc for ring, set end ring flag */
> +	if (first == tx_ring->total_cnt - 1)
> +		tx_desc.desc1 |= TX_DESC_1_END_RING;
> +
> +	/*
> +	 * If frag_num is more than 1, data need another desc, so current
> +	 * descriptor isn't last piece of packet data.
> +	 */
> +	tx_desc.desc1 |= frag_num > 1 ? 0 : TX_DESC_1_LAST_SEGMENT;
> +
> +	if (frag_num <= 1 && emac_tx_should_interrupt(priv, 1))
> +		tx_desc.desc1 |= TX_DESC_1_INTERRUPT_ON_COMPLETION;
> +
> +	/* Only last descriptor has skb pointer */
> +	if (tx_desc.desc1 & TX_DESC_1_LAST_SEGMENT)
> +		tx_buf->skb = skb;
> +
> +	*tx_desc_addr = tx_desc;
> +	dma_wmb();
> +	WRITE_ONCE(tx_desc_addr->desc0, tx_desc.desc0 | TX_DESC_0_OWN);
> +
> +	emac_dma_start_transmit(priv);
> +
> +	tx_ring->head = i;
> +
> +	return 0;
> +
> +dma_map_err:
> +	dev_kfree_skb_any(skb);
> +	priv->ndev->stats.tx_dropped++;
> +	return 0;
> +}

This is a rather large function. Can parts of it be pulled out into
helpers? The Coding style document says:

  Functions should be short and sweet, and do just one thing. They
  should fit on one or two screenfuls of text (the ISO/ANSI screen
  size is 80x24, as we all know), and do one thing and do that well.

> +static int emac_mdio_init(struct emac_priv *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct device_node *mii_np;
> +	struct mii_bus *mii;
> +	int ret;
> +
> +	mii_np = of_get_available_child_by_name(dev->of_node, "mdio-bus");
> +	if (!mii_np) {
> +		if (of_phy_is_fixed_link(dev->of_node)) {
> +			if ((of_phy_register_fixed_link(dev->of_node) < 0))
> +				return -ENODEV;
> +
> +			return 0;
> +		}
> +
> +		dev_info(dev, "No mdio-bus child node found");
> +		return 0;
> +	}

An mdio-bus node is normally optional. You can pass NULL to
devm_of_mdiobus_register() and it will do the correct thing, register
the bus, and scan it for devices.

An MDIO bus and fixed link are also not mutually exclusive. When the
MAC is connected to an Ethernet switch, you often see an fixed-link,
and have an MDIO bus, with the switches management interface being
MDIO.

> +static int emac_ethtool_get_regs_len(struct net_device *dev)
> +{
> +	return EMAC_REG_SPACE_SIZE;
> +}
> +
> +static void emac_ethtool_get_regs(struct net_device *dev,
> +				  struct ethtool_regs *regs, void *space)
> +{
> +	struct emac_priv *priv = netdev_priv(dev);
> +	u32 *reg_space = space;
> +	int i;
> +
> +	regs->version = 1;
> +
> +	for (i = 0; i < EMAC_DMA_REG_CNT; i++)
> +		reg_space[i] = emac_rd(priv, DMA_CONFIGURATION + i * 4);
> +
> +	for (i = 0; i < EMAC_MAC_REG_CNT; i++)
> +		reg_space[i + EMAC_DMA_REG_CNT] =
> +			emac_rd(priv, MAC_GLOBAL_CONTROL + i * 4);
> +}

Given this implementation, it would be more readable, and less future
extension error prone, if emac_ethtool_get_regs_len() returned

EMAC_DMA_REG_CNT + EMAC_MAC_REG_CNT

> +static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
> +{
> +	if (!netif_running(ndev))
> +		return -EINVAL;
> +
> +	return phy_mii_ioctl(ndev->phydev, rq, cmd);
> +}

phy_do_ioctl_running().

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

The documentation for of_phy_connect() says:

 * If successful, returns a pointer to the phy_device with the embedded
 * struct device refcount incremented by one, or NULL on failure. The
 * refcount must be dropped by calling phy_disconnect() or phy_detach().

An error code is not possible. So you can simply this.
	
    Andrew

---
pw-bot: cr

