Return-Path: <netdev+bounces-293695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JVaGVtsHWoTagkAu9opvQ
	(envelope-from <netdev+bounces-293695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:26:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B77BC61E4BE
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B8CC3009E2A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947073A48D5;
	Mon,  1 Jun 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CqWz+pId";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TS5l+9ma"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60443A3E74;
	Mon,  1 Jun 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313172; cv=none; b=YVKo36Tu0r8dNxWQBlduYcbTz3ZhRAj/joDR43UskeZNh0DwTkmd6gHwkPmyt3nyVh7H3gfNqBp+YrVDkylZ0hMFfnYoJK+ItDMeXpLk5bJV28sSTarYhFNeK3mJ5KxQUlAS9j42QtErBck+O/vG65y5U1I67B5Wb/htG8d1zbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313172; c=relaxed/simple;
	bh=sYKrKQtve4QRSpc+Iykf4Him0T4pn/csC0RDW8oD+cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL/QokKfFnp9uaVWIA7vz9KGmay81BH0RwdSy77Ffj9+T1PgGvt8/VrI76CKbKcANFpNyk/Ux38gpcwJFaabyR0Mvj2CkBhiFB6coLkM7VeccWKVw6167rwJNcAURwvP2y9IAp3pmJnd0fJWijiNfB7+ACbLbLpgFydMROVCvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CqWz+pId; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TS5l+9ma; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gTWqh66Smz9tX8;
	Mon,  1 Jun 2026 13:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYz/yXus9hC4cXfaVVaL0H2EQITCiNIrZ+xx1vJFpns=;
	b=CqWz+pIdL1xJElDW+o3H6J0Q7Tk1MXe6xmR5qYNtppAdUt1HtzMdnox4zNp4AaFRAeou1i
	lpYaptW8tSj+1qnDtsol/M1V3bXgYjLTQq6GvcEbCR9koJiRntd32Yb8begj8a/GmyMgGr
	IJsKgIopSx5gKHPCyAiZ55DTmtjTHV7Nwzsm+1x6lnNSGSNppEOdXmSicTx4NHW1AzF8V/
	trqeXWIwmYQbEu4/ivRCSGlkSlGp5/3cGPkjp3l+ykFwPc0cFvkND7xJIFuIjUVxmO4A7Y
	/wRGdebmaTrx7brt/sIP+kUFYRSBgRQlIO8Et5hetBQFk4kyk/f9BHj4o+qNyw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TS5l+9ma;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYz/yXus9hC4cXfaVVaL0H2EQITCiNIrZ+xx1vJFpns=;
	b=TS5l+9maE0hrl5mHieVxu7mixo+teSehrLu72kz+Rzj68MKJbRudh3nFTp44v/3ABto7TK
	rI6HddUbZGt0Dyu+Pe3uQaEnCeio+tNWLg5l9RIUS6BoP95Eg3hGZt9xbHY5z3VDM8CyKD
	rpD4yOJjJsfCrZ/uXcwXvoW0VP0LKdS5RSQkWWnvaSDoAjLL3yFFj/m/HU58x/zazJDgEn
	p99/qXfE8qrKgROAT0NwdXJ/X0PItWvt3fOQS0o5WrSyY46XasDxQZFTP95ygFT1QDmpbk
	q6fDn2qkJ2B1HKtHobJzEgn0YBAtB/c9K8D692VIdhlTaagPT7u3tWGMY7j3gw==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v24 5/7] net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
Date: Mon,  1 Jun 2026 13:24:34 +0200
Message-ID: <20260601112437.2216043-6-lukasz.majewski@mailbox.org>
In-Reply-To: <20260601112437.2216043-1-lukasz.majewski@mailbox.org>
References: <20260601112437.2216043-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qw8grr76kdzemrgyrppyarafdz9ny3tx
X-MBO-RS-ID: 249f864ac1cdcd1c365
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-293695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: B77BC61E4BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Changes for v20:
- Use dev_err_ratelimited() to not spam console
- Replace dev_consume_skb_irq() with dev_consume_skb_any()
- Use skb->dev to assign it to tx packet device (avoid assigning to
  napi->dev)
- Remove the need to export the port information
- Do not use fep->skb_dirty (calculate proper 'index' instead)
- Use information about stopped queues to determine if driver can accept
  further the packets for TX

Changes for v21 - v23:
- None

Changes for v24:
- Provide comment regarding atomicity when atable is read
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 261 +++++++++++++++++-
 1 file changed, 260 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 7dfeda230e3f..212207861e13 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -193,6 +193,10 @@ static void mtip_read_atable(struct switch_enet_private *fep, int index,
 	struct addr_table64b_entry __iomem *atable_base =
 		fep->hwentry->mtip_table64b_entry;
 
+	/* The switch HW guarantees that the read of 64bit atable value
+	 * is atomic when presented below order is used - i.e. first read
+	 * low 32 bits and then high 32 bits.
+	 */
 	*read_lo = readl(&atable_base[index].lo);
 	*read_hi = readl(&atable_base[index].hi);
 }
@@ -246,6 +250,39 @@ struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_private *fep)
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
@@ -836,11 +873,233 @@ static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
 
 static void mtip_switch_tx(struct switch_enet_private *fep)
 {
+	struct net_device *dev;
+	unsigned short status;
+	struct sk_buff *skb;
+	struct cbd_t *bdp;
+	int index;
+
+	spin_lock_bh(&fep->hw_lock);
+	bdp = fep->dirty_tx;
+
+	while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
+		if (bdp == fep->cur_tx &&
+		    !mtip_netif_queues_stopped(fep))
+			break;
+
+		index = bdp - fep->tx_bd_base;
+		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
+				 MTIP_SWITCH_TX_FRSIZE, DMA_TO_DEVICE);
+		bdp->cbd_bufaddr = 0;
+		skb = fep->tx_skbuff[index];
+		dev = skb->dev;
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
+			dev_err_ratelimited(&fep->pdev->dev,
+					    "xmit interrupt and TX_READY.\n");
+
+		/* Deferred means some collisions occurred during transmit,
+		 * but we eventually sent the packet OK.
+		 */
+		if (status & BD_ENET_TX_DEF)
+			dev->stats.collisions++;
+
+		/* Free the sk buffer associated with this last transmit */
+		dev_consume_skb_any(skb);
+		fep->tx_skbuff[index] = NULL;
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
+		if (fep->dirty_tx == fep->cur_tx &&
+		    mtip_netif_queues_stopped(fep))
+			mtip_netif_wake_queues(fep);
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
 static int mtip_switch_rx(struct net_device *dev, int budget)
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


