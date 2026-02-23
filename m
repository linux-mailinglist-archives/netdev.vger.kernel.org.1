Return-Path: <netdev+bounces-259948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cILAHxgZnGmq/gMAu9opvQ
	(envelope-from <netdev+bounces-259948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C1173879
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB8A304DE9B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A434EF0C;
	Mon, 23 Feb 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cYZfPCxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B6191F91
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837526; cv=none; b=UuubiTHx23kSOK9RffutLlnBKiPetyhTWlP1PNyovvJgbY/rkbPdoeoYH/WbmfLdmbCenaKUZ8savqRpiz717ECfSYSVSnlzIfURpv2fWF/3HJGFd/FR5i0dENo3FUV2ptbna0dKepF7t3zBUWmy5lAIjFdyXsMGqds+914iMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837526; c=relaxed/simple;
	bh=5dIYF2PPcz1yHjgxNYTFDRdvcL6PuTAqdp1m+JqcdtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I98CIuiTUmnvA4DI1wA/ayqFYD9ac5wTT80HZFHouCVENMx9e4or73zeXGhvJfB9q9BfqLAKiZmM6pD/Km/j9z7BOaYaYJquJxVXpwMgR9QAJsQKNfcNCsmU5+2wyaIyJ0W+TPdcTG1lw2LccVV6xwxfZ+XU5KIEfuIzz3EHMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cYZfPCxJ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BB19A3DC0;
	Mon, 23 Feb 2026 10:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771837522; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3IhvWhX7I7J6rQTfNlbYX0wx4T7Z6yfa7goQ4MerNG8=;
	b=cYZfPCxJ0duuNA6Oe0YzewFD8tm9FDWZI1/Kga/e2cLUm/lekXqDLERHjZ4hWAknhJe3kk
	N4kbI1evMFefXSBnfC3B3m/8geyeBVArZ9ddfR0WSCekfloc94AXvkA4YFXaZVT4Sv09bJ
	G27ZKrePFMCX2dZhAv8UavVca0tFdHdhc/Ms1t9wKs4IgsHHRgSA7+Blv8QP8lH7e3tu9B
	TwE1EvlKXXn0KJ6AYwPgJWp3D5IP7cIg/hIkz2uwvGTW5F55wXy7cXsiM6ankYTqvhb/GR
	3P30keXM6oPVBcbMMQsSZGCzYaYQWqZz7Txupqe8/kGcas4ej+yFJ5cbhKVtsA==
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
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 3/5] net: cadence: macb: implement EEE TX LPI support
Date: Mon, 23 Feb 2026 10:04:10 +0100
Message-Id: <20260223090412.44070-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260223090412.44070-1-nb@tipi-net.de>
References: <20260223090412.44070-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-259948-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,tx_lpi_work.work:url]
X-Rspamd-Queue-Id: D63C1173879
X-Rspamd-Action: no action

Implement software-managed TX Low Power Idle (LPI) for the Cadence GEM
MAC as part of IEEE 802.3az Energy Efficient Ethernet support.

The GEM MAC has no built-in idle timer - the TXLPIEN bit (NCR bit 19)
immediately asserts LPI and blocks all TX while set. The MAC does not
auto-wake for transmit. Per Microchip GMAC documentation (section
40.6.19): "It is best to use firmware to control LPI."

This patch implements a software idle timer using delayed_work:
- On TX completion with an empty ring, schedule LPI entry after a
  configurable idle timeout (default 250ms). The work function
  verifies all TX queues are truly idle before entering LPI to
  prevent entering LPI while traffic is still active.
- On TX start, wake from LPI by clearing TXLPIEN, cancelling any
  pending re-entry, and waiting 50us for the PHY to exit LPI
  (conservative vs IEEE 802.3az Tw_sys of ~17us/~30us)
- On link up, check EEE negotiation via phy_init_eee() and defer
  first LPI entry by 1 second per IEEE 802.3az requirements
- On link down, immediately cancel pending work and clear TXLPIEN

The timer value is configurable at runtime via ethtool --set-eee
tx-timer.

The implementation is gated on MACB_CAPS_EEE so platforms must
explicitly opt in via their macb_config.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h      |   6 ++
 drivers/net/ethernet/cadence/macb_main.c | 120 ++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 95317965080c..d132ad95ee61 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1358,6 +1358,12 @@ struct macb {
 
 	struct macb_ptp_info	*ptp_info;	/* macb-ptp interface */
 
+	/* EEE / LPI state */
+	bool			eee_active;
+	bool			tx_lpi_enabled;
+	struct delayed_work	tx_lpi_work;
+	unsigned int		tx_lpi_timer_ms; /* idle timeout before LPI */
+
 	struct phy		*phy;
 
 	spinlock_t tsu_clk_lock; /* gem tsu clock locking */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..d4a81f3a7b9a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -589,6 +589,86 @@ static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
 	.pcs_config = macb_pcs_config,
 };
 
+/* Default TX LPI idle timeout in milliseconds.
+ * The MAC will enter LPI after this period of TX inactivity.
+ */
+#define MACB_TX_LPI_TIMER_DEFAULT_MS	250
+
+/* PHY wake time from LPI in microseconds.
+ * IEEE 802.3az: Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX.
+ * Use a conservative value to ensure the PHY has fully exited LPI.
+ */
+#define MACB_TX_LPI_WAKE_TIME_US	50
+
+static void macb_tx_lpi_set(struct macb *bp, bool enable)
+{
+	unsigned long flags;
+	u32 ncr;
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	ncr = macb_readl(bp, NCR);
+	if (enable)
+		ncr |= GEM_BIT(TXLPIEN);
+	else
+		ncr &= ~GEM_BIT(TXLPIEN);
+	macb_writel(bp, NCR, ncr);
+
+	bp->tx_lpi_enabled = enable;
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	netdev_dbg(bp->dev, "EEE TX LPI %s\n",
+		   enable ? "enabled" : "disabled");
+}
+
+/* Schedule LPI re-entry after TX idle timeout */
+static inline void macb_tx_lpi_schedule(struct macb *bp)
+{
+	if (!bp->eee_active)
+		return;
+
+	mod_delayed_work(system_wq, &bp->tx_lpi_work,
+			 msecs_to_jiffies(bp->tx_lpi_timer_ms));
+}
+
+static void macb_tx_lpi_work_fn(struct work_struct *work)
+{
+	struct macb *bp = container_of(work, struct macb, tx_lpi_work.work);
+	unsigned int q;
+
+	if (!bp->eee_active)
+		return;
+
+	/* Only enter LPI if all TX queues are truly idle. The timer may
+	 * have been scheduled when one queue drained but traffic resumed
+	 * before the timer fired.
+	 */
+	for (q = 0; q < bp->num_queues; q++) {
+		if (bp->queues[q].tx_head != bp->queues[q].tx_tail) {
+			/* TX still active, reschedule and check again later */
+			macb_tx_lpi_schedule(bp);
+			return;
+		}
+	}
+
+	macb_tx_lpi_set(bp, true);
+}
+
+/* Called from TX path to wake from LPI before transmitting */
+static inline void macb_tx_lpi_wake(struct macb *bp)
+{
+	if (!bp->tx_lpi_enabled)
+		return;
+
+	macb_tx_lpi_set(bp, false);
+	/* Cancel any pending re-entry */
+	cancel_delayed_work(&bp->tx_lpi_work);
+
+	/* Wait for PHY to exit LPI before transmitting */
+	udelay(MACB_TX_LPI_WAKE_TIME_US);
+}
+
 static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 			    const struct phylink_link_state *state)
 {
@@ -661,10 +741,16 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 			queue_writel(queue, IDR,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 
-	/* Disable Rx and Tx */
-	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
+	/* Cancel any pending LPI entry */
+	cancel_delayed_work(&bp->tx_lpi_work);
+
+	/* Disable TX LPI, Rx, and Tx */
+	ctrl = macb_readl(bp, NCR) & ~(GEM_BIT(TXLPIEN) | MACB_BIT(RE) | MACB_BIT(TE));
 	macb_writel(bp, NCR, ctrl);
 
+	bp->eee_active = false;
+	bp->tx_lpi_enabled = false;
+
 	netif_tx_stop_all_queues(ndev);
 }
 
@@ -732,6 +818,19 @@ static void macb_mac_link_up(struct phylink_config *config,
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
 
 	netif_tx_wake_all_queues(ndev);
+
+	/* EEE: check if link partner negotiated EEE.
+	 * Per IEEE 802.3az / Microchip GMAC docs: LPI must not be
+	 * requested until the link has been up for at least 1 second.
+	 */
+	if (phy && (bp->caps & MACB_CAPS_EEE)) {
+		bp->eee_active = phy_init_eee(phy, false) >= 0 &&
+				 phy->enable_tx_lpi;
+		netdev_dbg(ndev, "EEE: active=%d\n", bp->eee_active);
+		if (bp->eee_active)
+			schedule_delayed_work(&bp->tx_lpi_work,
+					      msecs_to_jiffies(1000));
+	}
 }
 
 static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
@@ -1242,6 +1341,11 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->dev, queue_index);
+
+	/* Schedule LPI re-entry when TX ring is drained */
+	if (queue->tx_head == queue->tx_tail)
+		macb_tx_lpi_schedule(bp);
+
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return packets;
@@ -2270,6 +2374,10 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool is_lso;
 	netdev_tx_t ret = NETDEV_TX_OK;
 
+	/* Wake from LPI before transmitting */
+	if (unlikely(bp->tx_lpi_enabled))
+		macb_tx_lpi_wake(bp);
+
 	if (macb_clear_csum(skb)) {
 		dev_kfree_skb_any(skb);
 		return ret;
@@ -2973,6 +3081,9 @@ static int macb_open(struct net_device *dev)
 	if (err)
 		goto phy_off;
 
+	if ((bp->caps & MACB_CAPS_EEE) && dev->phydev)
+		phy_support_eee(dev->phydev);
+
 	netif_tx_start_all_queues(dev);
 
 	if (bp->ptp_info)
@@ -3004,6 +3115,8 @@ static int macb_close(struct net_device *dev)
 
 	netif_tx_stop_all_queues(dev);
 
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
@@ -5616,6 +5729,8 @@ static int macb_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
+	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
+	bp->tx_lpi_timer_ms = MACB_TX_LPI_TIMER_DEFAULT_MS;
 
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
@@ -5659,6 +5774,7 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		device_set_wakeup_enable(&bp->pdev->dev, 0);
+		cancel_delayed_work_sync(&bp->tx_lpi_work);
 		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.39.5


