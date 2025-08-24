Return-Path: <netdev+bounces-216340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC96B3331B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 00:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A51E3A81B4
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459A2E11CB;
	Sun, 24 Aug 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ONRxEPP/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xUruICQX"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135C2DF714;
	Sun, 24 Aug 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756073310; cv=none; b=mx2bShi4k4zs1GEtYIB5RFdcedJvisudTVxlJHOAqRBM1KD2rX0OITHJiCOfKlpgKcwRoXhtlH/lF5m/fCRtvbR//3RhBcCiAEFLJqiOUiqj6aS9tH0SQVCyx0B4fTAvfmthOhb+xZMIG/ZpmTu9ifWOI4/MBF7U7Z+KmPqIZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756073310; c=relaxed/simple;
	bh=t5pMQwMakNmJXM1CiAtYJ3/Ke47hPrSO2JwH68oOXLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HuUVfIfTEDCwX8R7M0TvIgfXSv5smXNJkuzTV8ytKqeuvGTXZztFdam+4xlaQhagB3SNIXv8+FnYhr45nkbEb2c/9MSnYL6kqBHUMtVGLcpYqDDNaU1N6oVWT5ISJAteHYh+9t9PMVO4hckZWZvov/Rrt0+WKvPD2h4Vh2oNWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ONRxEPP/; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xUruICQX; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c97NV2Lwmz9tm6;
	Mon, 25 Aug 2025 00:08:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756073306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Go2GKyIUexPDFTSU1bGtuieyu0vxQa/TrhHcmo5q6MQ=;
	b=ONRxEPP/BnSSJqxRzgDYfshMpp9ob7kwNx+D3/7X6imwsc/HtMlY+zM5wo/hYDeXNsPn9s
	fep/qfcOlHYphL3kaAyfEQcLBUW8z1ioBcN6hhBN3lN/IGFYRjBWoEb9yUWp32O/gnsU6E
	i0unAPNtW0iNMGR6il60RW7l4wWlBzE/Mc+a1dqwaqCZs6RaOXFJtTEoGUuO9wIhmdQl/N
	WfRJIe72ebm1Il/yRhZrcpTkJNw5ePwDWxDXBwcqroR5+RPtTJ1nukrau2mwnwUZxBWL0N
	j8Rnkzhpae1YPvZ/ObVyFZh4BkvPKYb8KlucU/BgWcOaa960AdAx8SN48OOeNg==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756073304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Go2GKyIUexPDFTSU1bGtuieyu0vxQa/TrhHcmo5q6MQ=;
	b=xUruICQXovWW3ovIYOzKEZF1FeGvE4K5OyaWo+Q2SAXTHwZB2VzimjVp3MJpj/GbrfkELV
	ifQUvJPS10yF5tqLLxzGRbGeGAUKiO11cp+wArzaCfThQU0HI4Uz2HwbKxm/8kDzXLHyOK
	GdslQZ9qlJngsDzGOan58SmnfWZ7fqflTNpSHvhZCIPsp5zJXDa9Evl/dEmXvsSGz/ISxm
	mlROSq1JeSq5fUq8lkyIXS5o/kACsfh2ST6IWeY+eOSV+Dph05c07XbVNSI6yKxvSeENMu
	OXcNcyzDixBU6aV7qAjPCJ8MFdE5VzV/2Ie7vksdQQ/ZqMQXoAkrdz0zfFn8Xg==
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
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v19 5/7] net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
Date: Mon, 25 Aug 2025 00:07:34 +0200
Message-Id: <20250824220736.1760482-6-lukasz.majewski@mailbox.org>
In-Reply-To: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tb977qu4r5d1zdzrs6pucw8cr4og4te8
X-MBO-RS-ID: a4e9b90bc8fa1d13922

This patch provides mtip_switch_tx and mtip_switch_rx functions
code for MTIP L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
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

Changes for v16:
- Disable RX interrupt when in switch RX function
- Set offload_fwd_mark when L2 offloading is enabled (fix broadcast flooding)
- Replace spin_{un}lock() with _bh variant

Changes for v17 - v18:
- None

Changes for v19:
- Pass the page with data to upper part of the network stack
- Use new page from page pool for new transfer
- Remove extra copy of the data
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 259 +++++++++++++++++-
 1 file changed, 258 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 70c624339cc9..0d97b33c4f2c 100644
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
@@ -810,11 +843,235 @@ static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
 
 static void mtip_switch_tx(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned short status;
+	struct sk_buff *skb;
+	struct cbd_t *bdp;
+
+	spin_lock_bh(&fep->hw_lock);
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
+	spin_unlock_bh(&fep->hw_lock);
 }
 
+static int mtip_update_cbd(struct switch_enet_private *fep, struct cbd_t *bdp,
+			   int index)
+{
+	struct page *new_page;
+
+	new_page = page_pool_dev_alloc_pages(fep->page_pool);
+	if (unlikely(!new_page))
+		return -ENOMEM;
+
+	fep->page[index] = new_page;
+	bdp->cbd_bufaddr = page_pool_get_dma_addr(new_page);
+
+	return 0;
+}
+
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
+	int index;
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
+		writel(MCF_ESW_IMR_RXF, fep->hwp + ESW_ISR);
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
+		index = bdp - fep->rx_bd_base;
+		page = fep->page[index];
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
+		if (mtip_update_cbd(fep, bdp, index)) {
+			pndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = build_skb(page_address(page), PAGE_SIZE);
+		if (unlikely(!skb)) {
+			page_pool_recycle_direct(fep->page_pool, page);
+			pndev->stats.rx_dropped++;
+
+			netdev_err_once(pndev, "build_skb failed!\n");
+			goto rx_processing_done;
+		}
+
+		skb_put(skb, pkt_len);      /* Make room */
+		skb_mark_for_recycle(skb);
+		skb->protocol = eth_type_trans(skb, pndev);
+		skb->offload_fwd_mark = fep->br_offload;
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


