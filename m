Return-Path: <netdev+bounces-220402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D1B45CAD
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E471C83456
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DF32F7AA6;
	Fri,  5 Sep 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIOs0MwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6E288C0E;
	Fri,  5 Sep 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086508; cv=none; b=IO8s2wrfhJ4FUroP9q9wi0mmavS78sb7giqMVeoA3YmjdhBvH8ZIvHM0B2pzIgAzapiYaGwIox8rpKYELG48acz8/0equ2bDjt5m54WmTXNpUqhb/aPxpJ2BZ7/y5PYdQDFZfT6NOi32VMJKA1/3PLD+kpNduAZKkOtwHmRTURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086508; c=relaxed/simple;
	bh=Dd9GrN9GAAxETey0gekWGcwpoSTvYJkigJI730T+I/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPV0jWWAYr9jpmhgnB9aszkqsEnngwGaZ7f2t4d33UOgfhFDWlUSiv358ESGqHNesCp28HsMGhSBNTx4GT3NMbwcPbvjTnzlKPCtBJY5bnJb7ytfXyDMBi5AlxWn66zMVAX5DGVIVLCeeDg0qVt5XsNvJwyk8RIIlD8+ebOI1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIOs0MwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC64C4CEF1;
	Fri,  5 Sep 2025 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757086507;
	bh=Dd9GrN9GAAxETey0gekWGcwpoSTvYJkigJI730T+I/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIOs0MwUE2I3vXSEEPPTN+UByCEoKcgiRiHDw6TewSKVGn4/U8x5RRsuDen7Pv75K
	 K9i75Y8ZRfml3R3Q1JnpNWMYn34xSqNuDVLpxxgG5HxeJe23vnQtFVTNanWHk41xRo
	 dn94M2R3O7wAFnCVyCqxqFnWmwNKCJzlhT7uNvn71z5+bXgFxeBmpxwsnmVCJVGXJ0
	 M3vbD4qErghqHC6JQSa3SvMb/rVimU6/KS1ERkLxBMxnQBnuBxxCH6h500PlXA4ZX3
	 MIRmtSIRaFJ8WT6T5z5f1J/+8E/HTp/rn9O2xpmyUfu+VnWWNZE96DieKtFu5xkgXi
	 SRz6ymsmWx+Sw==
Date: Fri, 5 Sep 2025 16:35:00 +0100
From: Simon Horman <horms@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250905153500.GH553991@horms.kernel.org>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
 <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>

On Fri, Sep 05, 2025 at 07:09:31PM +0800, Vivian Wang wrote:
> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
> that only superficially resembles some other embedded MACs. SpacemiT
> refers to them as "EMAC", so let's just call the driver "k1_emac".
> 
> Supports RGMII and RMII interfaces. Includes support for MAC hardware
> statistics counters. PTP support is not implemented.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

...

> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c

...

> +static void emac_init_hw(struct emac_priv *priv)
> +{
> +	/* Destination address for 802.3x Ethernet flow control */
> +	u8 fc_dest_addr[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x01 };
> +
> +	u32 rxirq = 0, dma = 0;
> +
> +	regmap_set_bits(priv->regmap_apmu,
> +			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
> +			AXI_SINGLE_ID);
> +
> +	/* Disable transmit and receive units */
> +	emac_wr(priv, MAC_RECEIVE_CONTROL, 0x0);
> +	emac_wr(priv, MAC_TRANSMIT_CONTROL, 0x0);
> +
> +	/* Enable MAC address 1 filtering */
> +	emac_wr(priv, MAC_ADDRESS_CONTROL, MREGBIT_MAC_ADDRESS1_ENABLE);
> +
> +	/* Zero initialize the multicast hash table */
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0x0);
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0x0);
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0x0);
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0x0);
> +
> +	/* Configure thresholds */
> +	emac_wr(priv, MAC_TRANSMIT_FIFO_ALMOST_FULL, DEFAULT_TX_ALMOST_FULL);
> +	emac_wr(priv, MAC_TRANSMIT_PACKET_START_THRESHOLD,
> +		DEFAULT_TX_THRESHOLD);
> +	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
> +
> +	/* Configure flow control (enabled in emac_adjust_link() later) */
> +	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
> +	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
> +	emac_wr(priv, MAC_FC_HIGH_PAUSE_TIME, DEFAULT_FC_PAUSE_TIME);
> +	emac_wr(priv, MAC_FC_PAUSE_LOW_THRESHOLD, 0);
> +
> +	/* RX IRQ mitigation */
> +	rxirq = EMAC_RX_FRAMES & MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK;
> +	rxirq |= (EMAC_RX_COAL_TIMEOUT
> +		  << MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT) &
> +		 MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK;

Probably this driver can benefit from using FIELD_PREP and FIELD_GET
in a number of places. In this case I think it would mean that
MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT can be removed entirely.

> +
> +	rxirq |= MREGBIT_RECEIVE_IRQ_MITIGATION_ENABLE;
> +	emac_wr(priv, DMA_RECEIVE_IRQ_MITIGATION_CTRL, rxirq);

...

> +/* Returns number of packets received */
> +static int emac_rx_clean_desc(struct emac_priv *priv, int budget)
> +{
> +	struct net_device *ndev = priv->ndev;
> +	struct emac_rx_desc_buffer *rx_buf;
> +	struct emac_desc_ring *rx_ring;
> +	struct sk_buff *skb = NULL;
> +	struct emac_desc *rx_desc;
> +	u32 got = 0, skb_len, i;
> +	int status;
> +
> +	rx_ring = &priv->rx_ring;
> +
> +	i = rx_ring->tail;
> +
> +	while (budget--) {
> +		rx_desc = &((struct emac_desc *)rx_ring->desc_addr)[i];
> +
> +		/* Stop checking if rx_desc still owned by DMA */
> +		if (READ_ONCE(rx_desc->desc0) & RX_DESC_0_OWN)
> +			break;
> +
> +		dma_rmb();
> +
> +		rx_buf = &rx_ring->rx_desc_buf[i];
> +
> +		if (!rx_buf->skb)
> +			break;
> +
> +		got++;
> +
> +		dma_unmap_single(&priv->pdev->dev, rx_buf->dma_addr,
> +				 rx_buf->dma_len, DMA_FROM_DEVICE);
> +
> +		status = emac_rx_frame_status(priv, rx_desc);
> +		if (unlikely(status == RX_FRAME_DISCARD)) {
> +			ndev->stats.rx_dropped++;

As per the comment in struct net-device,
ndev->stats should not be used in modern drivers.

Probably you want to implement NETDEV_PCPU_STAT_TSTATS.

Sorry for not mentioning this in an earlier review of
stats in this driver.

> +			dev_kfree_skb_irq(rx_buf->skb);
> +			rx_buf->skb = NULL;
> +		} else {
> +			skb = rx_buf->skb;
> +			skb_len = rx_frame_len(rx_desc) - ETH_FCS_LEN;
> +			skb_put(skb, skb_len);
> +			skb->dev = ndev;
> +			ndev->hard_header_len = ETH_HLEN;
> +
> +			skb->protocol = eth_type_trans(skb, ndev);
> +
> +			skb->ip_summed = CHECKSUM_NONE;
> +
> +			napi_gro_receive(&priv->napi, skb);
> +
> +			ndev->stats.rx_packets++;
> +			ndev->stats.rx_bytes += skb_len;
> +
> +			memset(rx_desc, 0, sizeof(struct emac_desc));
> +			rx_buf->skb = NULL;
> +		}
> +
> +		if (++i == rx_ring->total_cnt)
> +			i = 0;
> +	}
> +
> +	rx_ring->tail = i;
> +
> +	emac_alloc_rx_desc_buffers(priv);
> +
> +	return got;
> +}

...

