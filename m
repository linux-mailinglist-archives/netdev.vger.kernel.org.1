Return-Path: <netdev+bounces-253420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF+eEkhEd2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:39:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15A871DD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8917A3062CC6
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1DE3314A8;
	Mon, 26 Jan 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eLDRaImJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D7VJm0Ce"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DF331238;
	Mon, 26 Jan 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423723; cv=none; b=Pe86qSF/6YflqfmAfEDCwUi4uZ33F0XxCX27eG4ForpwOozD3pdQuScp9OClo+IA/XDtLc3DFxTyH8q0284tUnLdcnX+k9XQe0bJBe6rF5O1qfl36v+dtmmbMUM75pY0EOgXB/eTuvfRMxNwTz0ZnT181+MfHexUEHR1gjWf3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423723; c=relaxed/simple;
	bh=yajpJDLvTNB7KejSJhlJz/otyrPTs83r8iGgyoXUKiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=It/busPSs0N1juv91WfHNeCy3bX9yHtP50gRVNDWPX72k3R0ktX7bDVkY8Lke9Q5lI0M6LZpIMudSvnYdIFWEVmzBZyUGBTv0DCZ59etlOzt0A0I25LTyY10DOa2MX3bYMIluD9cshmugDX+TGNgGnVVr4Nw0RWM2thOFax+MHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eLDRaImJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D7VJm0Ce; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f04gD32G8z9tSM;
	Mon, 26 Jan 2026 11:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769423720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyGLw9J6FS2FnNBJ+d5/BGBr/NmMjp0G9zIOxMYgCsg=;
	b=eLDRaImJGj9B+oerrbNWWoKUX9WEJYf1RfgITqf4QARpDPxfWU2n0CgVrEspkPjTg7k/BS
	Am1BPYGq8WoAWimNMrN4hoZoPyllVujOADto4BaQICeWq35vIFG4O3Qyo8wuiIDwoAo7la
	YzQsXbEtYCv2/Dv9Um4BpXv3V7DRFP48Y9TXNul8gkxBpQno/BDbl1eInyNvOXIUd8C0U9
	WhaXLswqdIyfLyUFicSKiO8BxVGpBmUCmAzCnvqbFp0UN6lIwqd9iieLfEmxeFlcdK4Z4S
	eBv5263Roq8kqbRnEu1PTxCbmhY59lL4x9218jdkUzU9ZmSFnN746j0Cgts81w==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769423717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyGLw9J6FS2FnNBJ+d5/BGBr/NmMjp0G9zIOxMYgCsg=;
	b=D7VJm0CeN/7BXcEs6K3mRMYJcZJfFCI+f0I6/FeJL4A2IRMLgAe0OOtFBL0rGE/zuUcHhs
	cC9MKXzNsqj7gAK+B+rjWP4gKVzvQuy9tdxS5v2zhNWqSYgcwwY+4diYGBaLyjSpjl+Xvp
	NWccPR/wVtLAD5dI+HSt1f2YmWALa9Lzdypr5+9ufwNCiMkavJIUq3K0q+ABea3uIDgBYH
	v2wxTi9rV0d6mxPpbZ2eWdyIgZ5ySIEJNd+/9FtBsD8qDCyOxasksYz3h5t46Zz1IHxJ54
	kz4jOZZRXBOK70ZPT9EABqG/QSW5vKzXcPj41zYQR7HxHk6dLX6ho7PyOgtNFA==
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
Subject: [net-next v20 5/7] net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
Date: Mon, 26 Jan 2026 11:33:58 +0100
Message-Id: <20260126103400.1683125-6-lukasz.majewski@mailbox.org>
In-Reply-To: <20260126103400.1683125-1-lukasz.majewski@mailbox.org>
References: <20260126103400.1683125-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uum4eigkgg57ayxr8baota5mktcyxxum
X-MBO-RS-ID: 595e027daf11bfb7b3e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net,kernel.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-253420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:dkim,mailbox.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF15A871DD
X-Rspamd-Action: no action

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
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 257 +++++++++++++++++-
 1 file changed, 256 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index a6424ee1a9d9..6f98f2166af5 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -246,6 +246,39 @@ struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_private *fep)
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
@@ -826,11 +859,233 @@ static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
 
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
+}
+
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
 }
 
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


