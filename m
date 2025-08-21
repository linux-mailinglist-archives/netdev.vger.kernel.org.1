Return-Path: <netdev+bounces-215845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91AB309E6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D661D00526
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BEA2E1F0B;
	Thu, 21 Aug 2025 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZpOV3X7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236F286D50;
	Thu, 21 Aug 2025 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818063; cv=none; b=GDJwxfcNwoYhz8lagLXrRuVaJqYvcO2yo66UQx3sAIqWboKEVv4WiZKIkekjS8rLN+G4qdbsFP1uwzn18KuwvO8Uaze44wbIfiudKh9+YRfWlJPovfGywRNLrXlNDdFk1lxyYQUjyI6j2SoSsz4qpMn0C7nA0wa2zM5FHsbv4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818063; c=relaxed/simple;
	bh=zkvshjcFzWG50O/pScvDURQ9fCVL6bGdtUAFxbZxmO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STtt97YgxxdVLoel2rBlY7mEPsHxKfYlvTH9q54Df1mNyKpdj+2cxYU+LEaDl6JeAfO4U7qPefn80vpN3JqCzw3i2IRGs98SslNVFSp9qPlGkee8Ccx9IJ5s7ZRhPBYLG25Ox5MqkCf/qZgpGLmXgqK87cvVJvoDQTDTMKKWz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZpOV3X7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8524C4CEEB;
	Thu, 21 Aug 2025 23:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755818062;
	bh=zkvshjcFzWG50O/pScvDURQ9fCVL6bGdtUAFxbZxmO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rZpOV3X7vM/+xZhBzFZx9X4PJUC7Lr4N8ayg2H5IRAnzb9rBcCe33yEmcE8UQbyNR
	 yK3CrjDjZA8YSwDMRNS+VM9MmFqoUQ+zb36GYNwHGV3El/BnPxvTQQTAgFnJh0xrQd
	 AFTOzvJcQV5HENN6MBxREzPkYmIGdo2f3EhgqNh+gYgPh6xRDC6xl57jcnv/uhspwQ
	 kDXaZJCY/3kQesywbz2PefI9iyzCPD+qEcrDCUkcqL5lSv09FrENYoXvM1NWsk99CR
	 1RzS12EYK0IajEC0spl1xGT4isw8GPlI57gwytl1Uov/fcRK34IiUOOlPtABl++lfV
	 eDw1xuNuLXy9Q==
Date: Thu, 21 Aug 2025 16:14:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang
 <uwu@dram.page>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Junhui Liu
 <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250821161420.7c9804f7@kernel.org>
In-Reply-To: <20250820-net-k1-emac-v6-2-c1e28f2b8be5@iscas.ac.cn>
References: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
	<20250820-net-k1-emac-v6-2-c1e28f2b8be5@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 14:47:51 +0800 Vivian Wang wrote:
> +static void emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb)
> +{
> +	struct emac_desc_ring *tx_ring = &priv->tx_ring;
> +	struct emac_desc tx_desc, *tx_desc_addr;
> +	struct device *dev = &priv->pdev->dev;
> +	struct emac_tx_desc_buffer *tx_buf;
> +	u32 head, old_head, frag_num, f;
> +	bool buf_idx;
> +
> +	frag_num = skb_shinfo(skb)->nr_frags;
> +	head = tx_ring->head;
> +	old_head = head;
> +
> +	for (f = 0; f < frag_num + 1; f++) {
> +		buf_idx = f % 2;
> +
> +		/*
> +		 * If using buffer 1, initialize a new desc. Otherwise, use
> +		 * buffer 2 of previous fragment's desc.
> +		 */
> +		if (!buf_idx) {
> +			tx_buf = &tx_ring->tx_desc_buf[head];
> +			tx_desc_addr =
> +				&((struct emac_desc *)tx_ring->desc_addr)[head];
> +			memset(&tx_desc, 0, sizeof(tx_desc));
> +
> +			/*
> +			 * Give ownership for all but first desc initially. For
> +			 * first desc, give at the end so DMA cannot start
> +			 * reading uninitialized descs.
> +			 */
> +			if (head != old_head)
> +				tx_desc.desc0 |= TX_DESC_0_OWN;
> +
> +			if (++head == tx_ring->total_cnt) {
> +				/* Just used last desc in ring */
> +				tx_desc.desc1 |= TX_DESC_1_END_RING;
> +				head = 0;
> +			}
> +		}
> +
> +		if (emac_tx_map_frag(dev, &tx_desc, tx_buf, skb, f)) {
> +			netdev_err(priv->ndev, "Map TX frag %d failed", f);
> +			goto dma_map_err;
> +		}
> +
> +		if (f == 0)
> +			tx_desc.desc1 |= TX_DESC_1_FIRST_SEGMENT;
> +
> +		if (f == frag_num) {
> +			tx_desc.desc1 |= TX_DESC_1_LAST_SEGMENT;
> +			tx_buf->skb = skb;
> +			if (emac_tx_should_interrupt(priv, frag_num + 1))
> +				tx_desc.desc1 |=
> +					TX_DESC_1_INTERRUPT_ON_COMPLETION;
> +		}
> +
> +		*tx_desc_addr = tx_desc;
> +	}
> +
> +	/* All descriptors are ready, give ownership for first desc */
> +	tx_desc_addr = &((struct emac_desc *)tx_ring->desc_addr)[old_head];
> +	dma_wmb();
> +	WRITE_ONCE(tx_desc_addr->desc0, tx_desc_addr->desc0 | TX_DESC_0_OWN);
> +
> +	emac_dma_start_transmit(priv);
> +
> +	tx_ring->head = head;
> +
> +	return;
> +
> +dma_map_err:
> +	dev_kfree_skb_any(skb);

You free the skb here.. 

> +	priv->ndev->stats.tx_dropped++;
> +}
> +
> +static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct emac_priv *priv = netdev_priv(ndev);
> +	int nfrags = skb_shinfo(skb)->nr_frags;
> +	struct device *dev = &priv->pdev->dev;
> +
> +	if (unlikely(emac_tx_avail(priv) < nfrags + 1)) {
> +		if (!netif_queue_stopped(ndev)) {
> +			netif_stop_queue(ndev);
> +			dev_err_ratelimited(dev, "TX ring full, stop TX queue\n");
> +		}
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	emac_tx_mem_map(priv, skb);
> +
> +	ndev->stats.tx_packets++;
> +	ndev->stats.tx_bytes += skb->len;

.. and then you use skb here.

> +	/* Make sure there is space in the ring for the next TX. */
> +	if (unlikely(emac_tx_avail(priv) <= MAX_SKB_FRAGS + 2))
> +		netif_stop_queue(ndev);
> +
> +	return NETDEV_TX_OK;
> +}

> +static void emac_get_ethtool_stats(struct net_device *dev,
> +				   struct ethtool_stats *stats, u64 *data)
> +{
> +	struct emac_priv *priv = netdev_priv(dev);
> +	u64 *rx_stats = (u64 *)&priv->rx_stats;
> +	int i;
> +
> +	scoped_guard(spinlock_irqsave, &priv->stats_lock) {

Why is this spin lock taken in irqsave mode?
Please convert the code not to use scoped_guard()
There's not a single flow control (return) in any of them.
It's just hiding the information that you're unnecessarily masking irqs.
See
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

> +		emac_stats_update(priv);
> +
> +		for (i = 0; i < ARRAY_SIZE(emac_ethtool_rx_stats); i++)
> +			data[i] = rx_stats[emac_ethtool_rx_stats[i].offset];
> +	}

> +static void emac_tx_timeout_task(struct work_struct *work)
> +{
> +	struct net_device *ndev;
> +	struct emac_priv *priv;
> +
> +	priv = container_of(work, struct emac_priv, tx_timeout_task);
> +	ndev = priv->ndev;

I don't see this work ever being canceled.
What prevents ndev from being freed before it gets to run?

> +/* Called when net interface is brought up. */
> +static int emac_open(struct net_device *ndev)
> +{
> +	struct emac_priv *priv = netdev_priv(ndev);
> +	struct device *dev = &priv->pdev->dev;
> +	int ret;
> +
> +	ret = emac_alloc_tx_resources(priv);
> +	if (ret) {
> +		dev_err(dev, "Error when setting up the Tx resources\n");
> +		goto emac_alloc_tx_resource_fail;
> +	}
> +
> +	ret = emac_alloc_rx_resources(priv);
> +	if (ret) {
> +		dev_err(dev, "Error when setting up the Rx resources\n");
> +		goto emac_alloc_rx_resource_fail;
> +	}
> +
> +	ret = emac_up(priv);
> +	if (ret) {
> +		dev_err(dev, "Error when bringing interface up\n");
> +		goto emac_up_fail;
> +	}
> +	return 0;
> +
> +emac_up_fail:

please name the jump labels after the destination not the source.
Please fix everywhere in the driver.
This is covered in the kernel coding style docs.

> +	emac_free_rx_resources(priv);
> +emac_alloc_rx_resource_fail:
> +	emac_free_tx_resources(priv);
> +emac_alloc_tx_resource_fail:
> +	return ret;
> +}


