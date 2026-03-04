Return-Path: <netdev+bounces-263753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPAoLpAPqGk8ngAAu9opvQ
	(envelope-from <netdev+bounces-263753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:55:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 290901FE998
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C913041A60
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527533A8732;
	Wed,  4 Mar 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="5cSIvHdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6536BCEC
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621702; cv=none; b=g2wRAtQltm9KXncAX3ufs/yW/PJQ6Yi+oTfLSTxS3E78ORORjH+noDwpuMhG93DgX1uEG4+wlkLh3achzIzcipKBVbBI1LgcXtA3IiGcycCYnOmhgiKmqt1oBkrndbBoQgI8Gtka2Tf7w8+X4q6EvR11PqOYiHPxtBdwzJQmj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621702; c=relaxed/simple;
	bh=It3qdA/wuoIHZYyIMtg2pvy40TOGhpfdGZtFze3FTcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL6Drh2ALgcnDNQtahUt0/ef1jjD5KHX/ghqBn2CapOZmK9q1v0DTesw4sKHHrQ56qs0dhy/AkD5olhkfv2hFc7SK8z9XvjW0Yv8Brc2ecVVMPP6N20x9MMne3Tn7zSvbtAYkuzIfIj9/N/QVVb22ulLFLF+UZIdPNte+QSo+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=5cSIvHdj; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEA73A5607;
	Wed,  4 Mar 2026 11:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772621697; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nQ9OITr7zMhw8i7QdHC6ikqxZ2uiatvGQIpGZ0z3yDk=;
	b=5cSIvHdjMyWVfe76qt0Bf2UOjrTW4XvlrwdIridTYVBCxPoEvORqfZklx7MycCkbFuJ7aI
	6vncborcqrFU8T66qkKasGlxKdnGQWBpYEmPcyCPwzF3/moPJFq1qDIDtpkj+hw/LbxhO5
	q0jsCtn3IUkmFy+RY377vSesegSY8dAE8SoO4fQ7/20S9Y7lc9D5eLh0X3QR/Fqsm8/cm3
	GQ4LTdvHubTp8VHq6bjByfnGNA8OHWBjm+CutncVDXwhUjwyFyexw9x2mtYGwFgEorHVRS
	f/cWubThXZQindbWUMucYsAeTxwt7OX+Zaw/6Pr7+CtA5FQJ6P/k36IYqiHc+w==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 2/5] net: cadence: macb: implement EEE TX LPI support
Date: Wed,  4 Mar 2026 11:54:29 +0100
Message-ID: <20260304105432.631186-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304105432.631186-1-nb@tipi-net.de>
References: <20260304105432.631186-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 290901FE998
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263753-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tuxon.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The GEM MAC has hardware LPI registers (NCR bit 19: TXLPIEN) but no
built-in idle timer, so asserting TXLPIEN blocks all TX immediately
with no automatic wake. A software idle timer is required, as noted
in Microchip documentation (section 40.6.19): "It is best to use
firmware to control LPI."

Implement phylink managed EEE using the mac_enable_tx_lpi and
mac_disable_tx_lpi callbacks:

- macb_tx_lpi_set(): sets or clears TXLPIEN; requires bp->lock to be
  held by the caller (asserted with lockdep_assert_held). Returns bool
  indicating whether the register actually changed, avoiding redundant
  writes and unnecessary udelay on the xmit fast path.

- macb_tx_lpi_work_fn(): delayed_work handler that enters LPI if all
  TX queues are idle and EEE is still active. Takes bp->lock with
  irqsave before calling macb_tx_lpi_set().

- macb_tx_lpi_schedule(): arms the work timer using the LPI timer
  value provided by phylink (default 250 ms). Called from
  macb_tx_complete() after each TX drain so the idle countdown
  restarts whenever the ring goes quiet.

- macb_tx_lpi_wake(): called from macb_start_xmit() under bp->lock,
  immediately before TSTART. Returns early if eee_active is false to
  avoid a register read on the common path when EEE is disabled.
  Clears TXLPIEN and applies a 50 us udelay for PHY wake (IEEE
  802.3az Tw_sys_tx is 16.5 us for 1000BASE-T / 30 us for
  100BASE-TX; GEM has no hardware enforcement). Only delays when
  TXLPIEN was actually set. The delay is placed after tx_head is
  advanced so the work_fn's queue-idle check sees a non-empty ring
  and cannot race back into LPI before the frame is transmitted.

- mac_enable_tx_lpi: stores the timer and sets eee_active under
  bp->lock, then defers the first LPI entry by 1 second per IEEE
  802.3az section 22.7a.

- mac_disable_tx_lpi: cancels the work (sync, without the lock to
  avoid deadlock with the work_fn), then takes bp->lock to clear
  eee_active and deassert TXLPIEN.

Populate phylink_config lpi_interfaces (MII, GMII, RGMII variants)
and lpi_capabilities (MAC_100FD | MAC_1000FD) so phylink can
negotiate EEE with the PHY and call the callbacks appropriately.
Set lpi_timer_default to 250000 us and eee_enabled_default to true.

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h      |   8 ++
 drivers/net/ethernet/cadence/macb_main.c | 124 +++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 19aa98d01c8c..c69828b27dae 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -309,6 +309,8 @@
 #define MACB_IRXFCS_SIZE	1
 
 /* GEM specific NCR bitfields. */
+#define GEM_TXLPIEN_OFFSET		19
+#define GEM_TXLPIEN_SIZE		1
 #define GEM_ENABLE_HS_MAC_OFFSET	31
 #define GEM_ENABLE_HS_MAC_SIZE		1
 
@@ -783,6 +785,7 @@
 #define MACB_CAPS_DMA_PTP			BIT(22)
 #define MACB_CAPS_RSC				BIT(23)
 #define MACB_CAPS_NO_LSO			BIT(24)
+#define MACB_CAPS_EEE				BIT(25)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1369,6 +1372,11 @@ struct macb {
 
 	struct work_struct	hresp_err_bh_work;
 
+	/* EEE / LPI state */
+	bool			eee_active;
+	struct delayed_work	tx_lpi_work;
+	u32			tx_lpi_timer;
+
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 17f0ad3d7a09..4e776c67f408 100644
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
@@ -621,6 +622,107 @@ static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
 	.pcs_config = macb_pcs_config,
 };
 
+static bool macb_tx_lpi_set(struct macb *bp, bool enable)
+{
+	u32 old, ncr;
+
+	lockdep_assert_held(&bp->lock);
+
+	ncr = macb_readl(bp, NCR);
+	old = ncr;
+	if (enable)
+		ncr |= GEM_BIT(TXLPIEN);
+	else
+		ncr &= ~GEM_BIT(TXLPIEN);
+	if (old != ncr)
+		macb_writel(bp, NCR, ncr);
+
+	return old != ncr;
+}
+
+static bool macb_tx_all_queues_idle(struct macb *bp)
+{
+	struct macb_queue *queue;
+	unsigned int q;
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		if (READ_ONCE(queue->tx_head) != READ_ONCE(queue->tx_tail))
+			return false;
+	}
+	return true;
+}
+
+static void macb_tx_lpi_work_fn(struct work_struct *work)
+{
+	struct macb *bp = container_of(work, struct macb, tx_lpi_work.work);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	if (bp->eee_active && macb_tx_all_queues_idle(bp))
+		macb_tx_lpi_set(bp, true);
+	spin_unlock_irqrestore(&bp->lock, flags);
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
+	lockdep_assert_held(&bp->lock);
+
+	if (!bp->eee_active)
+		return;
+
+	if (!macb_tx_lpi_set(bp, false))
+		return;
+
+	cancel_delayed_work(&bp->tx_lpi_work);
+	udelay(50);
+}
+
+static void macb_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(ndev);
+	unsigned long flags;
+
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
+
+	spin_lock_irqsave(&bp->lock, flags);
+	bp->eee_active = false;
+	macb_tx_lpi_set(bp, false);
+	spin_unlock_irqrestore(&bp->lock, flags);
+}
+
+static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				  bool tx_clk_stop)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(ndev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	bp->tx_lpi_timer = timer;
+	bp->eee_active = true;
+	spin_unlock_irqrestore(&bp->lock, flags);
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
@@ -769,6 +871,8 @@ static const struct phylink_mac_ops macb_phylink_ops = {
 	.mac_config = macb_mac_config,
 	.mac_link_down = macb_mac_link_down,
 	.mac_link_up = macb_mac_link_up,
+	.mac_disable_tx_lpi = macb_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = macb_mac_enable_tx_lpi,
 };
 
 static bool macb_phy_handle_exists(struct device_node *dn)
@@ -864,6 +968,18 @@ static int macb_mii_probe(struct net_device *dev)
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
@@ -1260,6 +1376,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		netif_wake_subqueue(bp->dev, queue_index);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
+	if (packets)
+		macb_tx_lpi_schedule(bp);
+
 	return packets;
 }
 
@@ -2366,6 +2485,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			     skb->len);
 
 	spin_lock(&bp->lock);
+	macb_tx_lpi_wake(bp);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 	spin_unlock(&bp->lock);
 
@@ -3026,6 +3146,8 @@ static int macb_close(struct net_device *dev)
 		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
 	}
 
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
+
 	phylink_stop(bp->phylink);
 	phylink_disconnect_phy(bp->phylink);
 
@@ -5629,6 +5751,7 @@ static int macb_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
+	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
 
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
@@ -5672,6 +5795,7 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		device_set_wakeup_enable(&bp->pdev->dev, 0);
+		cancel_delayed_work_sync(&bp->tx_lpi_work);
 		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.51.0


