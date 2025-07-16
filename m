Return-Path: <netdev+bounces-207603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43918B07FE8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE964E5B4E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2302EF9C3;
	Wed, 16 Jul 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CgrFOili"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F82EF640;
	Wed, 16 Jul 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702496; cv=none; b=o3L50v2FmN1T6C3Co7H66gqY+Ashl+/KNYtbTWn4QMUWp/HVxH3Qlh07iPJSrHq3EQJ0tUvipw2aeDkzLWd4nGc63zuISwfAmAHOjp1YXa7+PRyAubFW39zJCZxpk6NK1qXjGMH7jZHPReLJqedNzJWyeyN2AZYJlhg1low8G6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702496; c=relaxed/simple;
	bh=qYrUTV1PAIwMwN1lu3fkh2ljgtXh4K9KHnazPmH8RuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbBm2ysRTR7/wlrSNuHyZpgamau4XN+A1VfyeoKq21RK8+dR9zjN/kL8AH6uqSLkm1PNrPO/etLUsxrgpcymkXbJGUFDU8d4i4rS48LTQayNDqr/+Dn0A1GuSk+bLqo8/4wmCxtNeP4I5NAyRdBoWEJ+lpV5LZcVd65qvrm3g5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CgrFOili; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 843A610397286;
	Wed, 16 Jul 2025 23:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752702492; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZOmMBoK3X07nEFOtWKDhWe0Ro+zUIJSYmtB47JYLT1M=;
	b=CgrFOiliiIugNTQbrClV+SbkO/w+tNQFNYb4quN1tKPDTdAekUbfJFK7cphJ8qQWZIfJtp
	8+1cmwacY1fV7Qph8AENtxL5IiXQtczMfmDLTojGoxwL8AdYVnZytGyddBhGRVu/IdyrKh
	v+7awHSddvDaK/P/fFNrm6xp2+l51oQsiAAxDj757vc25kJzrRn077zM/GsNWxl+xID755
	nD5dtVY8sZstxvCP4igQURzh1wo0Cl10pXBwr79SacsTgLnf5NWXXifUtD6PeA+8HOk7sB
	OWI+swEjilkyJ+ZTfdMZsJAzRnONDwgJcBQXKh39X5MUr0iL3cLDlqOMrWeMFA==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v15 07/12] net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
Date: Wed, 16 Jul 2025 23:47:26 +0200
Message-Id: <20250716214731.3384273-8-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250716214731.3384273-1-lukma@denx.de>
References: <20250716214731.3384273-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch provides mtip_switch_tx and mtip_switch_rx functions
code for MTIP L2 switch.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14:
- Rewrite RX error handling code
- Remove } else { from if (unlikely(!skb)) { condition in mtip_switch_rx()
- Remove locking from RX patch (done under NAPI API and similar to fec_main.c
  driver)
- Use net_prefetch() instead of prefetch()

Changes for v15:
- Use page_address() instead of __va()
- Remove the check if data is NOT null, as it cannot be (those values are
  assured to be allocated earlier for RX path).
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 238 +++++++++++++++++-
 1 file changed, 237 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 3ec76b06f1f1..01ada1ec7c3b 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -228,6 +228,39 @@ struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_private *fep)
 	return info;
 }
 
+static void mtip_atable_get_entry_port_number(struct switch_enet_private *fep,
+					      unsigned char *mac_addr, u8 *port)
+{
+	int block_index, block_index_end, entry;
+	u32 mac_addr_lo, mac_addr_hi;
+	u32 read_lo, read_hi;
+
+	mac_addr_lo = (u32)((mac_addr[3] << 24) | (mac_addr[2] << 16) |
+			    (mac_addr[1] << 8) | mac_addr[0]);
+	mac_addr_hi = (u32)((mac_addr[5] << 8) | (mac_addr[4]));
+
+	block_index = GET_BLOCK_PTR(crc8_calc(mac_addr));
+	block_index_end = block_index + ATABLE_ENTRY_PER_SLOT;
+
+	/* now search all the entries in the selected block */
+	for (entry = block_index; entry < block_index_end; entry++) {
+		mtip_read_atable(fep, entry, &read_lo, &read_hi);
+		*port = MTIP_PORT_FORWARDING_INIT;
+
+		if (read_lo == mac_addr_lo &&
+		    ((read_hi & 0x0000FFFF) ==
+		     (mac_addr_hi & 0x0000FFFF))) {
+			/* found the correct address */
+			if ((read_hi & (1 << 16)) && (!(read_hi & (1 << 17))))
+				*port = FIELD_GET(AT_PORT_MASK, read_hi);
+			break;
+		}
+	}
+
+	dev_dbg(&fep->pdev->dev, "%s: MAC: %pM PORT: 0x%x\n", __func__,
+		mac_addr, *port);
+}
+
 /* Clear complete MAC Look Up Table */
 void mtip_clear_atable(struct switch_enet_private *fep)
 {
@@ -824,11 +857,214 @@ static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
 
 static void mtip_switch_tx(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned short status;
+	struct sk_buff *skb;
+	struct cbd_t *bdp;
+
+	spin_lock(&fep->hw_lock);
+	bdp = fep->dirty_tx;
+
+	while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
+		if (bdp == fep->cur_tx && fep->tx_full == 0)
+			break;
+
+		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
+				 MTIP_SWITCH_TX_FRSIZE, DMA_TO_DEVICE);
+		bdp->cbd_bufaddr = 0;
+		skb = fep->tx_skbuff[fep->skb_dirty];
+		/* Check for errors */
+		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
+				   BD_ENET_TX_RL | BD_ENET_TX_UN |
+				   BD_ENET_TX_CSL)) {
+			dev->stats.tx_errors++;
+			if (status & BD_ENET_TX_HB)  /* No heartbeat */
+				dev->stats.tx_heartbeat_errors++;
+			if (status & BD_ENET_TX_LC)  /* Late collision */
+				dev->stats.tx_window_errors++;
+			if (status & BD_ENET_TX_RL)  /* Retrans limit */
+				dev->stats.tx_aborted_errors++;
+			if (status & BD_ENET_TX_UN)  /* Underrun */
+				dev->stats.tx_fifo_errors++;
+			if (status & BD_ENET_TX_CSL) /* Carrier lost */
+				dev->stats.tx_carrier_errors++;
+		} else {
+			dev->stats.tx_packets++;
+		}
+
+		if (status & BD_ENET_TX_READY)
+			dev_err(&fep->pdev->dev,
+				"Enet xmit interrupt and TX_READY.\n");
+
+		/* Deferred means some collisions occurred during transmit,
+		 * but we eventually sent the packet OK.
+		 */
+		if (status & BD_ENET_TX_DEF)
+			dev->stats.collisions++;
+
+		/* Free the sk buffer associated with this last transmit */
+		dev_consume_skb_irq(skb);
+		fep->tx_skbuff[fep->skb_dirty] = NULL;
+		fep->skb_dirty = (fep->skb_dirty + 1) & TX_RING_MOD_MASK;
+
+		/* Update pointer to next buffer descriptor to be transmitted */
+		if (status & BD_ENET_TX_WRAP)
+			bdp = fep->tx_bd_base;
+		else
+			bdp++;
+
+		/* Since we have freed up a buffer, the ring is no longer
+		 * full.
+		 */
+		if (fep->tx_full) {
+			fep->tx_full = 0;
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+		}
+	}
+	fep->dirty_tx = bdp;
+	spin_unlock(&fep->hw_lock);
 }
 
+/* During a receive, the cur_rx points to the current incoming buffer.
+ * When we update through the ring, if the next incoming buffer has
+ * not been given to the system, we just set the empty indicator,
+ * effectively tossing the packet.
+ */
 static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
 {
-	return -ENOMEM;
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	u8 *data, rx_port = MTIP_PORT_FORWARDING_INIT;
+	struct switch_enet_private *fep = priv->fep;
+	unsigned short status, pkt_len;
+	struct net_device *pndev;
+	struct ethhdr *eth_hdr;
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	struct cbd_t *bdp;
+	struct page *page;
+
+	/* First, grab all of the stats for the incoming packet.
+	 * These get messed up if we get called due to a busy condition.
+	 */
+	bdp = fep->cur_rx;
+
+	while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+
+		pkt_received++;
+
+		if (!fep->usage_count)
+			goto rx_processing_done;
+
+		status ^= BD_ENET_RX_LAST;
+		/* Check for errors. */
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+			      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+			      BD_ENET_RX_CL)) {
+			dev->stats.rx_errors++;
+			if (status & BD_ENET_RX_OV) {
+				/* FIFO overrun */
+				dev->stats.rx_fifo_errors++;
+				goto rx_processing_done;
+			}
+			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
+				      | BD_ENET_RX_LAST)) {
+				/* Frame too long or too short. */
+				dev->stats.rx_length_errors++;
+				if (status & BD_ENET_RX_LAST)
+					netdev_err(dev, "rcv is not +last\n");
+			}
+			if (status & BD_ENET_RX_CR)	/* CRC Error */
+				dev->stats.rx_crc_errors++;
+
+			/* Report late collisions as a frame error. */
+			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+				dev->stats.rx_frame_errors++;
+			goto rx_processing_done;
+		}
+
+		/* Get correct RX page */
+		page = fep->page[bdp - fep->rx_bd_base];
+		/* Process the incoming frame */
+		pkt_len = bdp->cbd_datlen;
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, bdp->cbd_bufaddr,
+					pkt_len, DMA_FROM_DEVICE);
+		net_prefetch(page_address(page));
+		data = page_address(page);
+
+		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+			swap_buffer(data, pkt_len);
+
+		eth_hdr = (struct ethhdr *)data;
+		mtip_atable_get_entry_port_number(fep, eth_hdr->h_source,
+						  &rx_port);
+		if (rx_port == MTIP_PORT_FORWARDING_INIT)
+			mtip_atable_dynamicms_learn_migration(fep,
+							      mtip_get_time(),
+							      eth_hdr->h_source,
+							      &rx_port);
+
+		if ((rx_port == 1 || rx_port == 2) && fep->ndev[rx_port - 1])
+			pndev = fep->ndev[rx_port - 1];
+		else
+			pndev = dev;
+
+		*port = rx_port;
+
+		/* This does 16 byte alignment, exactly what we need.
+		 * The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = netdev_alloc_skb(pndev, pkt_len + NET_IP_ALIGN);
+		if (unlikely(!skb)) {
+			dev_dbg(&fep->pdev->dev,
+				"%s: Memory squeeze, dropping packet.\n",
+				pndev->name);
+			page_pool_recycle_direct(fep->page_pool, page);
+			pndev->stats.rx_dropped++;
+			return -ENOMEM;
+		}
+
+		skb_reserve(skb, NET_IP_ALIGN);
+		skb_put(skb, pkt_len);      /* Make room */
+		skb_copy_to_linear_data(skb, data, pkt_len);
+		skb->protocol = eth_type_trans(skb, pndev);
+		napi_gro_receive(&fep->napi, skb);
+
+		pndev->stats.rx_packets++;
+		pndev->stats.rx_bytes += pkt_len;
+
+ rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+		/* Make sure that updates to the descriptor are performed */
+		wmb();
+		bdp->cbd_sc = status;
+
+		/* Update BD pointer to next entry */
+		if (status & BD_ENET_RX_WRAP)
+			bdp = fep->rx_bd_base;
+		else
+			bdp++;
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames.  On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(MCF_ESW_RDAR_R_DES_ACTIVE, fep->hwp + ESW_RDAR);
+	} /* while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) */
+
+	fep->cur_rx = bdp;
+
+	return pkt_received;
 }
 
 static void mtip_adjust_link(struct net_device *dev)
-- 
2.39.5


