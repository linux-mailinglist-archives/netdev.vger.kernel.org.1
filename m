Return-Path: <netdev+bounces-260427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBnJHz1tnWkkQAQAu9opvQ
	(envelope-from <netdev+bounces-260427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:19:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA9018472C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7943F30B8E25
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15C36C0AF;
	Tue, 24 Feb 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2Fxk/buS"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA136AB54
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924749; cv=none; b=pT5wyRlT8MsqZTF1Nm3xHk58nXIkC6A7bUcVHXxyalJfElOxgce4dJO0ItJgWCnyPnEfqNENNJlotyxTrTD58yfAjW3iLwGpAtGyReJj5SSvL5M5wpj+eM2AbnPVzMJEXFx36yxM17yEP99i2MwCVSXUCesNRnMvv5skm3xUeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924749; c=relaxed/simple;
	bh=/TH6OMrqqZ1jV8028EOcyKNrfz8UZr9trQn1ZLHUUOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkwSRUKIOs71jzdDJtwMNGQmlNfQitnpzRsqU8nsXeJkLE/+ngVQ8bpfzVpK96gJCzfPSpqq07TQBarhA96goWuOw2MfMGr94Ts9MTs/CAcWpLSABt8CXF7BM2b5Q7ldKqfZt7UHU0RKErE1bK/pcQNsuoEnD3fSaEbEUi45r6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2Fxk/buS; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FC96A3F83;
	Tue, 24 Feb 2026 10:18:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771924739; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1LbnZ8+jHMKwKFJkgIlYWHn7GRj55hih3bD5VJdz9ek=;
	b=2Fxk/buSEeCgWFI90wWF/oemPsbz5Gyl4VDZrv0tg8jp/TZncjNJkkHWpC/S7gELIU3VPF
	lQmxKzW4Gt5eIe45IFWq3K+3iHrLQibKRRB7jjuexEY84X5ipipvS+ubCu2uUYoa1OpxmH
	Mg3rYaH9O3GSCVtwlD75+hHz33nT+vS7lj4dudQO8K9QU8YL6JyVhQ4Y2eVFgHMY5kaTyk
	oXXqr8uSpp9smEkm1KzRSjcd8dlHQa1/8EQ/AHN1lQKmMBPJn6tzjIwzCZ8PhCbk/Dp+Dh
	abN0xaoxbM4DH5+XzAb+Mw2W/mhUrHFcHbuYnr2GR9garcOiOIiFSAhJHzqoTw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 3/5] net: cadence: macb: implement EEE TX LPI support
Date: Tue, 24 Feb 2026 10:18:19 +0100
Message-Id: <20260224091821.47671-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260224091821.47671-1-nb@tipi-net.de>
References: <20260224091821.47671-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260427-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,tx_lpi_work.work:url]
X-Rspamd-Queue-Id: EAA9018472C
X-Rspamd-Action: no action

Implement Energy Efficient Ethernet TX Low Power Idle using phylink's
managed EEE framework. The Cadence GEM MAC has no built-in idle timer
- TXLPIEN (NCR bit 19) immediately blocks all TX when set and the MAC
does NOT auto-wake - so the driver uses a software delayed_work timer
for idle detection.

The TX LPI lifecycle:
  - phylink calls mac_enable_tx_lpi() after link-up with the negotiated
    timer value. The driver defers the first LPI entry by 1 second per
    IEEE 802.3az section 22.7a.
  - macb_tx_complete() reschedules the idle timer after each TX drain.
  - macb_start_xmit() wakes from LPI by clearing TXLPIEN, cancelling
    the pending work, and waiting 50us (conservative Tw_sys) before
    initiating the transmit.
  - phylink calls mac_disable_tx_lpi() before link-down, which cancels
    the work and clears TXLPIEN.

The phylink_config is populated with LPI capabilities (MII, GMII, RGMII
modes; 100FD and 1000FD speeds) and a 250ms default idle timer, gated
on MACB_CAPS_EEE.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h      |   6 ++
 drivers/net/ethernet/cadence/macb_main.c | 110 +++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index e3520e5aec67..a17e537cdeb6 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1372,6 +1372,12 @@ struct macb {
 
 	struct work_struct	hresp_err_bh_work;
 
+	/* EEE / LPI state */
+	bool			eee_active;
+	bool			tx_lpi_enabled;
+	struct delayed_work	tx_lpi_work;
+	u32			tx_lpi_timer;
+
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..fb64a97725b1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/crc32.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/firmware/xlnx-zynqmp.h>
@@ -589,6 +590,92 @@ static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
 	.pcs_config = macb_pcs_config,
 };
 
+static void macb_tx_lpi_set(struct macb *bp, bool enable)
+{
+	unsigned long flags;
+	u32 ncr;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	ncr = macb_readl(bp, NCR);
+	if (enable)
+		ncr |= GEM_BIT(TXLPIEN);
+	else
+		ncr &= ~GEM_BIT(TXLPIEN);
+	macb_writel(bp, NCR, ncr);
+	bp->tx_lpi_enabled = enable;
+	spin_unlock_irqrestore(&bp->lock, flags);
+}
+
+static bool macb_tx_all_queues_idle(struct macb *bp)
+{
+	unsigned int q;
+
+	for (q = 0; q < bp->num_queues; q++) {
+		struct macb_queue *queue = &bp->queues[q];
+
+		if (queue->tx_head != queue->tx_tail)
+			return false;
+	}
+	return true;
+}
+
+static void macb_tx_lpi_work_fn(struct work_struct *work)
+{
+	struct macb *bp = container_of(work, struct macb, tx_lpi_work.work);
+
+	if (bp->eee_active && macb_tx_all_queues_idle(bp))
+		macb_tx_lpi_set(bp, true);
+}
+
+static void macb_tx_lpi_schedule(struct macb *bp)
+{
+	if (bp->eee_active)
+		mod_delayed_work(system_wq, &bp->tx_lpi_work,
+				 usecs_to_jiffies(bp->tx_lpi_timer));
+}
+
+/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
+ * and wait for the PHY to exit LPI before any frame can be sent.
+ * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
+ * we use a conservative 50us.
+ */
+static void macb_tx_lpi_wake(struct macb *bp)
+{
+	if (!bp->tx_lpi_enabled)
+		return;
+
+	macb_tx_lpi_set(bp, false);
+	cancel_delayed_work(&bp->tx_lpi_work);
+	udelay(50);
+}
+
+static void macb_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(ndev);
+
+	bp->eee_active = false;
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
+	macb_tx_lpi_set(bp, false);
+}
+
+static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				  bool tx_clk_stop)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(ndev);
+
+	bp->tx_lpi_timer = timer;
+	bp->eee_active = true;
+
+	/* Defer initial LPI entry by 1 second after link-up per
+	 * IEEE 802.3az section 22.7a.
+	 */
+	mod_delayed_work(system_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000));
+
+	return 0;
+}
+
 static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 			    const struct phylink_link_state *state)
 {
@@ -753,6 +840,8 @@ static const struct phylink_mac_ops macb_phylink_ops = {
 	.mac_config = macb_mac_config,
 	.mac_link_down = macb_mac_link_down,
 	.mac_link_up = macb_mac_link_up,
+	.mac_disable_tx_lpi = macb_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = macb_mac_enable_tx_lpi,
 };
 
 static bool macb_phy_handle_exists(struct device_node *dn)
@@ -848,6 +937,18 @@ static int macb_mii_probe(struct net_device *dev)
 		}
 	}
 
+	/* Configure EEE LPI if supported */
+	if (bp->caps & MACB_CAPS_EEE) {
+		__set_bit(PHY_INTERFACE_MODE_MII,
+			  bp->phylink_config.lpi_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  bp->phylink_config.lpi_interfaces);
+		phy_interface_set_rgmii(bp->phylink_config.lpi_interfaces);
+		bp->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
+		bp->phylink_config.lpi_timer_default = 250000;
+		bp->phylink_config.eee_enabled_default = true;
+	}
+
 	bp->phylink = phylink_create(&bp->phylink_config, bp->pdev->dev.fwnode,
 				     bp->phy_interface, &macb_phylink_ops);
 	if (IS_ERR(bp->phylink)) {
@@ -1244,6 +1345,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		netif_wake_subqueue(bp->dev, queue_index);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
+	if (packets)
+		macb_tx_lpi_schedule(bp);
+
 	return packets;
 }
 
@@ -2349,6 +2453,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
 			     skb->len);
 
+	macb_tx_lpi_wake(bp);
+
 	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 	spin_unlock(&bp->lock);
@@ -3010,6 +3116,8 @@ static int macb_close(struct net_device *dev)
 		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
 	}
 
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
+
 	phylink_stop(bp->phylink);
 	phylink_disconnect_phy(bp->phylink);
 
@@ -5616,6 +5724,7 @@ static int macb_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
+	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
 
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
@@ -5659,6 +5768,7 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		device_set_wakeup_enable(&bp->pdev->dev, 0);
+		cancel_delayed_work_sync(&bp->tx_lpi_work);
 		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.51.0


