Return-Path: <netdev+bounces-117799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523594F5F8
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5C6B21676
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A2189BB0;
	Mon, 12 Aug 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dAZDUsRH"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC6189532
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484506; cv=none; b=XTVtDdFD62kSOkT6ZdH89qzfSFfAZe5VmARENJ12ZIQQ6KpLwjU2NEHk9qJGJ7CmXX2uQQElWzbvdvNPzYOeravUqN7r174dRUCMMrKJdeFiO/BiSz5fREdzEX5VbuqQeFx8GNtcRgTTYqf9ZHqJ09TJiKC8vhVS9LfT0AtBhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484506; c=relaxed/simple;
	bh=agZGegt1h2CkFqH4WwswIpOiX2/9u4Opj8hZZmhqVbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqpNLfrf2/e8i8YgnmHkhnhfzWuLjvY5oicXRFBX75r6reGffpGyK3aFzb3eiZbTA+tj7i9rvnUJm0QafYCZmTbeij2qwny+unnOvXnaAF2hHoa7J4G8qdYKyGgP1loq0hymsAKaVOOw/0n/lwQ080CCaAwG5M/cUUM9CVpkEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dAZDUsRH; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723484501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaUJYkWncoFr7GysKMJI9O9dw9S4G3UXRvOWUe7VQag=;
	b=dAZDUsRH1ms9opAmGvSsRvMa6zNJouHYKxCs9pSQJ/VKwI2zFptcMeXlMV4i2CsJakB1ob
	fluALkHhHpXcONvrMozQQzFzC23uRKC7dom8wzth/1si9xlnGNG3rjzni6TA9J4wGstjG3
	bt1IzvgAqPMs86fkwFuftOrZXyYoCpQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2 2/2] net: xilinx: axienet: Add statistics support
Date: Mon, 12 Aug 2024 13:41:18 -0400
Message-Id: <20240812174118.3560730-3-sean.anderson@linux.dev>
In-Reply-To: <20240812174118.3560730-1-sean.anderson@linux.dev>
References: <20240812174118.3560730-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for reading the statistics counters, if they are enabled.
The counters may be 64-bit, but we can't detect this statically as
there's no ability bit for it and the counters are read-only. Therefore,
we assume the counters are 32-bits by default. To ensure we don't miss
an overflow, we read all counters at 13-second intervals. This should be
often enough to ensure the bytes counters don't wrap at 2.5 Gbit/s.

Another complication is that the counters may be reset when the device
is reset (depending on configuration). To ensure the counters persist
across link up/down (including suspend/resume), we maintain our own
versions along with the last counter value we saw. Because we might wait
up to 100 ms for the reset to complete, we use a mutex to protect
writing hw_stats. We can't sleep in ndo_get_stats64, so we use a seqlock
to protect readers.

We don't bother disabling the refresh work when we detect 64-bit
counters. This is because the reset issue requires us to read
hw_stat_base and reset_in_progress anyway, which would still require the
seqcount. And I don't think skipping the task is worth the extra
bookkeeping.

We can't use the byte counters for either get_stats64 or
get_eth_mac_stats. This is because the byte counters include everything
in the frame (destination address to FCS, inclusive). But
rtnl_link_stats64 wants bytes excluding the FCS, and
ethtool_eth_mac_stats wants to exclude the L2 overhead (addresses and
length/type). It might be possible to calculate the byte values Linux
expects based on the frame counters, but I think it is simpler to use
the existing software counters.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Switch to a seqlock-based implementation to allow fresher updates
  (rather than always using stale counter values from the previous
  refresh).
- Take stats_lock unconditionally in __axienet_device_reset
- Fix documentation mismatch

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  85 ++++++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 257 ++++++++++++++++++
 2 files changed, 342 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 0d5b300107e0..373c56080dde 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -156,6 +156,7 @@
 #define XAE_TPID0_OFFSET	0x00000028 /* VLAN TPID0 register */
 #define XAE_TPID1_OFFSET	0x0000002C /* VLAN TPID1 register */
 #define XAE_PPST_OFFSET		0x00000030 /* PCS PMA Soft Temac Status Reg */
+#define XAE_STATS_OFFSET	0x00000200 /* Statistics counters */
 #define XAE_RCW0_OFFSET		0x00000400 /* Rx Configuration Word 0 */
 #define XAE_RCW1_OFFSET		0x00000404 /* Rx Configuration Word 1 */
 #define XAE_TC_OFFSET		0x00000408 /* Tx Configuration */
@@ -163,6 +164,7 @@
 #define XAE_EMMC_OFFSET		0x00000410 /* EMAC mode configuration */
 #define XAE_PHYC_OFFSET		0x00000414 /* RGMII/SGMII configuration */
 #define XAE_ID_OFFSET		0x000004F8 /* Identification register */
+#define XAE_ABILITY_OFFSET	0x000004FC /* Ability Register offset */
 #define XAE_MDIO_MC_OFFSET	0x00000500 /* MII Management Config */
 #define XAE_MDIO_MCR_OFFSET	0x00000504 /* MII Management Control */
 #define XAE_MDIO_MWD_OFFSET	0x00000508 /* MII Management Write Data */
@@ -283,6 +285,16 @@
 #define XAE_PHYC_SGLINKSPD_100		0x40000000 /* SGMII link 100 Mbit */
 #define XAE_PHYC_SGLINKSPD_1000		0x80000000 /* SGMII link 1000 Mbit */
 
+/* Bit masks for Axi Ethernet ability register */
+#define XAE_ABILITY_PFC			BIT(16)
+#define XAE_ABILITY_FRAME_FILTER	BIT(10)
+#define XAE_ABILITY_HALF_DUPLEX		BIT(9)
+#define XAE_ABILITY_STATS		BIT(8)
+#define XAE_ABILITY_2_5G		BIT(3)
+#define XAE_ABILITY_1G			BIT(2)
+#define XAE_ABILITY_100M		BIT(1)
+#define XAE_ABILITY_10M			BIT(0)
+
 /* Bit masks for Axi Ethernet MDIO interface MC register */
 #define XAE_MDIO_MC_MDIOEN_MASK		0x00000040 /* MII management enable */
 #define XAE_MDIO_MC_CLOCK_DIVIDE_MAX	0x3F	   /* Maximum MDIO divisor */
@@ -331,6 +343,7 @@
 #define XAE_FEATURE_FULL_RX_CSUM	BIT(2)
 #define XAE_FEATURE_FULL_TX_CSUM	BIT(3)
 #define XAE_FEATURE_DMA_64BIT		BIT(4)
+#define XAE_FEATURE_STATS		BIT(5)
 
 #define XAE_NO_CSUM_OFFLOAD		0
 
@@ -344,6 +357,61 @@
 #define XLNX_MII_STD_SELECT_REG		0x11
 #define XLNX_MII_STD_SELECT_SGMII	BIT(0)
 
+/* enum temac_stat - TEMAC statistics counters
+ *
+ * Index of statistics counters within the TEMAC. This must match the
+ * order/offset of hardware registers exactly.
+ */
+enum temac_stat {
+	STAT_RX_BYTES = 0,
+	STAT_TX_BYTES,
+	STAT_UNDERSIZE_FRAMES,
+	STAT_FRAGMENT_FRAMES,
+	STAT_RX_64_BYTE_FRAMES,
+	STAT_RX_65_127_BYTE_FRAMES,
+	STAT_RX_128_255_BYTE_FRAMES,
+	STAT_RX_256_511_BYTE_FRAMES,
+	STAT_RX_512_1023_BYTE_FRAMES,
+	STAT_RX_1024_MAX_BYTE_FRAMES,
+	STAT_RX_OVERSIZE_FRAMES,
+	STAT_TX_64_BYTE_FRAMES,
+	STAT_TX_65_127_BYTE_FRAMES,
+	STAT_TX_128_255_BYTE_FRAMES,
+	STAT_TX_256_511_BYTE_FRAMES,
+	STAT_TX_512_1023_BYTE_FRAMES,
+	STAT_TX_1024_MAX_BYTE_FRAMES,
+	STAT_TX_OVERSIZE_FRAMES,
+	STAT_RX_GOOD_FRAMES,
+	STAT_RX_FCS_ERRORS,
+	STAT_RX_BROADCAST_FRAMES,
+	STAT_RX_MULTICAST_FRAMES,
+	STAT_RX_CONTROL_FRAMES,
+	STAT_RX_LENGTH_ERRORS,
+	STAT_RX_VLAN_FRAMES,
+	STAT_RX_PAUSE_FRAMES,
+	STAT_RX_CONTROL_OPCODE_ERRORS,
+	STAT_TX_GOOD_FRAMES,
+	STAT_TX_BROADCAST_FRAMES,
+	STAT_TX_MULTICAST_FRAMES,
+	STAT_TX_UNDERRUN_ERRORS,
+	STAT_TX_CONTROL_FRAMES,
+	STAT_TX_VLAN_FRAMES,
+	STAT_TX_PAUSE_FRAMES,
+	STAT_TX_SINGLE_COLLISION_FRAMES,
+	STAT_TX_MULTIPLE_COLLISION_FRAMES,
+	STAT_TX_DEFERRED_FRAMES,
+	STAT_TX_LATE_COLLISIONS,
+	STAT_TX_EXCESS_COLLISIONS,
+	STAT_TX_EXCESS_DEFERRAL,
+	STAT_RX_ALIGNMENT_ERRORS,
+	STAT_TX_PFC_FRAMES,
+	STAT_RX_PFC_FRAMES,
+	STAT_USER_DEFINED0,
+	STAT_USER_DEFINED1,
+	STAT_USER_DEFINED2,
+	STAT_COUNT,
+};
+
 /**
  * struct axidma_bd - Axi Dma buffer descriptor layout
  * @next:         MM2S/S2MM Next Descriptor Pointer
@@ -434,6 +502,16 @@ struct skbuf_dma_descriptor {
  * @tx_packets: TX packet count for statistics
  * @tx_bytes:	TX byte count for statistics
  * @tx_stat_sync: Synchronization object for TX stats
+ * @hw_stat_base: Base offset for statistics counters. This may be nonzero if
+ *                the statistics counteres were reset or wrapped around.
+ * @hw_last_counter: Last-seen value of each statistic counter
+ * @reset_in_progress: Set while we are performing a reset and statistics
+ *                     counters may be invalid
+ * @hw_stats_seqcount: Sequence counter for @hw_stat_base, @hw_last_counter,
+ *                     and @reset_in_progress.
+ * @stats_lock: Lock for @hw_stats_seqcount
+ * @stats_work: Work for reading the hardware statistics counters often enough
+ *              to catch overflows.
  * @dma_err_task: Work structure to process Axi DMA errors
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
@@ -505,6 +583,13 @@ struct axienet_local {
 	u64_stats_t tx_bytes;
 	struct u64_stats_sync tx_stat_sync;
 
+	u64 hw_stat_base[STAT_COUNT];
+	u64 hw_last_counter[STAT_COUNT];
+	seqcount_mutex_t hw_stats_seqcount;
+	struct mutex stats_lock;
+	struct delayed_work stats_work;
+	bool reset_in_progress;
+
 	struct work_struct dma_err_task;
 
 	int tx_irq;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index b2d7c396e2e3..7bb25a171710 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -519,11 +519,55 @@ static void axienet_setoptions(struct net_device *ndev, u32 options)
 	lp->options |= options;
 }
 
+static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
+{
+	u32 counter;
+
+	if (lp->reset_in_progress)
+		return lp->hw_stat_base[stat];
+
+	counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
+	return lp->hw_stat_base[stat] + (counter - lp->hw_last_counter[stat]);
+}
+
+static void axienet_stats_update(struct axienet_local *lp, bool reset)
+{
+	enum temac_stat stat;
+
+	write_seqcount_begin(&lp->hw_stats_seqcount);
+	lp->reset_in_progress = reset;
+	for (stat = 0; stat < STAT_COUNT; stat++) {
+		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
+
+		lp->hw_stat_base[stat] += counter - lp->hw_last_counter[stat];
+		lp->hw_last_counter[stat] = counter;
+	}
+	write_seqcount_end(&lp->hw_stats_seqcount);
+}
+
+static void axienet_refresh_stats(struct work_struct *work)
+{
+	struct axienet_local *lp = container_of(work, struct axienet_local,
+						stats_work.work);
+
+	mutex_lock(&lp->stats_lock);
+	axienet_stats_update(lp, false);
+	mutex_unlock(&lp->stats_lock);
+
+	/* Just less than 2^32 bytes at 2.5 GBit/s */
+	schedule_delayed_work(&lp->stats_work, 13 * HZ);
+}
+
 static int __axienet_device_reset(struct axienet_local *lp)
 {
 	u32 value;
 	int ret;
 
+	/* Save statistics counters in case they will be reset */
+	guard(mutex)(&lp->stats_lock);
+	if (lp->features & XAE_FEATURE_STATS)
+		axienet_stats_update(lp, true);
+
 	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The reset
 	 * process of Axi DMA takes a while to complete as all pending
 	 * commands/transfers will be flushed or completed during this
@@ -551,6 +595,23 @@ static int __axienet_device_reset(struct axienet_local *lp)
 		return ret;
 	}
 
+	/* Update statistics counters with new values */
+	if (lp->features & XAE_FEATURE_STATS) {
+		enum temac_stat stat;
+
+		write_seqcount_begin(&lp->hw_stats_seqcount);
+		lp->reset_in_progress = false;
+		for (stat = 0; stat < STAT_COUNT; stat++) {
+			u32 counter =
+				axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
+
+			lp->hw_stat_base[stat] +=
+				lp->hw_last_counter[stat] - counter;
+			lp->hw_last_counter[stat] = counter;
+		}
+		write_seqcount_end(&lp->hw_stats_seqcount);
+	}
+
 	return 0;
 }
 
@@ -1530,6 +1591,9 @@ static int axienet_open(struct net_device *ndev)
 
 	phylink_start(lp->phylink);
 
+	/* Start the statistics refresh work */
+	schedule_delayed_work(&lp->stats_work, 0);
+
 	if (lp->use_dmaengine) {
 		/* Enable interrupts for Axi Ethernet core (if defined) */
 		if (lp->eth_irq > 0) {
@@ -1554,6 +1618,7 @@ static int axienet_open(struct net_device *ndev)
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
 err_phy:
+	cancel_delayed_work_sync(&lp->stats_work);
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
 	return ret;
@@ -1579,6 +1644,8 @@ static int axienet_stop(struct net_device *ndev)
 		napi_disable(&lp->napi_rx);
 	}
 
+	cancel_delayed_work_sync(&lp->stats_work);
+
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
 
@@ -1692,6 +1759,35 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		stats->tx_packets = u64_stats_read(&lp->tx_packets);
 		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
 	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		stats->rx_length_errors =
+			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);
+		stats->rx_crc_errors = axienet_stat(lp, STAT_RX_FCS_ERRORS);
+		stats->rx_frame_errors =
+			axienet_stat(lp, STAT_RX_ALIGNMENT_ERRORS);
+		stats->rx_errors = axienet_stat(lp, STAT_UNDERSIZE_FRAMES) +
+				   axienet_stat(lp, STAT_FRAGMENT_FRAMES) +
+				   stats->rx_length_errors +
+				   stats->rx_crc_errors +
+				   stats->rx_frame_errors;
+		stats->multicast = axienet_stat(lp, STAT_RX_MULTICAST_FRAMES);
+
+		stats->tx_aborted_errors =
+			axienet_stat(lp, STAT_TX_EXCESS_COLLISIONS);
+		stats->tx_fifo_errors =
+			axienet_stat(lp, STAT_TX_UNDERRUN_ERRORS);
+		stats->tx_window_errors =
+			axienet_stat(lp, STAT_TX_LATE_COLLISIONS);
+		stats->tx_errors = axienet_stat(lp, STAT_TX_EXCESS_DEFERRAL) +
+				   stats->tx_aborted_errors +
+				   stats->tx_fifo_errors +
+				   stats->tx_window_errors;
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
 }
 
 static const struct net_device_ops axienet_netdev_ops = {
@@ -1984,6 +2080,156 @@ static int axienet_ethtools_nway_reset(struct net_device *dev)
 	return phylink_ethtool_nway_reset(lp->phylink);
 }
 
+static void
+axienet_ethtools_get_pause_stats(struct net_device *dev,
+				 struct ethtool_pause_stats *pause_stats)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+	unsigned int start;
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		pause_stats->tx_pause_frames =
+			axienet_stat(lp, STAT_TX_PAUSE_FRAMES);
+		pause_stats->rx_pause_frames =
+			axienet_stat(lp, STAT_RX_PAUSE_FRAMES);
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+}
+
+static void
+axienet_ethtool_get_eth_mac_stats(struct net_device *dev,
+				  struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+	unsigned int start;
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		mac_stats->FramesTransmittedOK =
+			axienet_stat(lp, STAT_TX_GOOD_FRAMES);
+		mac_stats->SingleCollisionFrames =
+			axienet_stat(lp, STAT_TX_SINGLE_COLLISION_FRAMES);
+		mac_stats->MultipleCollisionFrames =
+			axienet_stat(lp, STAT_TX_MULTIPLE_COLLISION_FRAMES);
+		mac_stats->FramesReceivedOK =
+			axienet_stat(lp, STAT_RX_GOOD_FRAMES);
+		mac_stats->FrameCheckSequenceErrors =
+			axienet_stat(lp, STAT_RX_FCS_ERRORS);
+		mac_stats->AlignmentErrors =
+			axienet_stat(lp, STAT_RX_ALIGNMENT_ERRORS);
+		mac_stats->FramesWithDeferredXmissions =
+			axienet_stat(lp, STAT_TX_DEFERRED_FRAMES);
+		mac_stats->LateCollisions =
+			axienet_stat(lp, STAT_TX_LATE_COLLISIONS);
+		mac_stats->FramesAbortedDueToXSColls =
+			axienet_stat(lp, STAT_TX_EXCESS_COLLISIONS);
+		mac_stats->MulticastFramesXmittedOK =
+			axienet_stat(lp, STAT_TX_MULTICAST_FRAMES);
+		mac_stats->BroadcastFramesXmittedOK =
+			axienet_stat(lp, STAT_TX_BROADCAST_FRAMES);
+		mac_stats->FramesWithExcessiveDeferral =
+			axienet_stat(lp, STAT_TX_EXCESS_DEFERRAL);
+		mac_stats->MulticastFramesReceivedOK =
+			axienet_stat(lp, STAT_RX_MULTICAST_FRAMES);
+		mac_stats->BroadcastFramesReceivedOK =
+			axienet_stat(lp, STAT_RX_BROADCAST_FRAMES);
+		mac_stats->InRangeLengthErrors =
+			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+}
+
+static void
+axienet_ethtool_get_eth_ctrl_stats(struct net_device *dev,
+				   struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+	unsigned int start;
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		ctrl_stats->MACControlFramesTransmitted =
+			axienet_stat(lp, STAT_TX_CONTROL_FRAMES);
+		ctrl_stats->MACControlFramesReceived =
+			axienet_stat(lp, STAT_RX_CONTROL_FRAMES);
+		ctrl_stats->UnsupportedOpcodesReceived =
+			axienet_stat(lp, STAT_RX_CONTROL_OPCODE_ERRORS);
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+}
+
+static const struct ethtool_rmon_hist_range axienet_rmon_ranges[] = {
+	{   64,    64 },
+	{   65,   127 },
+	{  128,   255 },
+	{  256,   511 },
+	{  512,  1023 },
+	{ 1024,  1518 },
+	{ 1519, 16384 },
+	{ },
+};
+
+static void
+axienet_ethtool_get_rmon_stats(struct net_device *dev,
+			       struct ethtool_rmon_stats *rmon_stats,
+			       const struct ethtool_rmon_hist_range **ranges)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+	unsigned int start;
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		rmon_stats->undersize_pkts =
+			axienet_stat(lp, STAT_UNDERSIZE_FRAMES);
+		rmon_stats->oversize_pkts =
+			axienet_stat(lp, STAT_RX_OVERSIZE_FRAMES);
+		rmon_stats->fragments =
+			axienet_stat(lp, STAT_FRAGMENT_FRAMES);
+
+		rmon_stats->hist[0] =
+			axienet_stat(lp, STAT_RX_64_BYTE_FRAMES);
+		rmon_stats->hist[1] =
+			axienet_stat(lp, STAT_RX_65_127_BYTE_FRAMES);
+		rmon_stats->hist[2] =
+			axienet_stat(lp, STAT_RX_128_255_BYTE_FRAMES);
+		rmon_stats->hist[3] =
+			axienet_stat(lp, STAT_RX_256_511_BYTE_FRAMES);
+		rmon_stats->hist[4] =
+			axienet_stat(lp, STAT_RX_512_1023_BYTE_FRAMES);
+		rmon_stats->hist[5] =
+			axienet_stat(lp, STAT_RX_1024_MAX_BYTE_FRAMES);
+		rmon_stats->hist[6] =
+			rmon_stats->oversize_pkts;
+
+		rmon_stats->hist_tx[0] =
+			axienet_stat(lp, STAT_TX_64_BYTE_FRAMES);
+		rmon_stats->hist_tx[1] =
+			axienet_stat(lp, STAT_TX_65_127_BYTE_FRAMES);
+		rmon_stats->hist_tx[2] =
+			axienet_stat(lp, STAT_TX_128_255_BYTE_FRAMES);
+		rmon_stats->hist_tx[3] =
+			axienet_stat(lp, STAT_TX_256_511_BYTE_FRAMES);
+		rmon_stats->hist_tx[4] =
+			axienet_stat(lp, STAT_TX_512_1023_BYTE_FRAMES);
+		rmon_stats->hist_tx[5] =
+			axienet_stat(lp, STAT_TX_1024_MAX_BYTE_FRAMES);
+		rmon_stats->hist_tx[6] =
+			axienet_stat(lp, STAT_TX_OVERSIZE_FRAMES);
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+
+	*ranges = axienet_rmon_ranges;
+}
+
 static const struct ethtool_ops axienet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS,
@@ -2000,6 +2246,10 @@ static const struct ethtool_ops axienet_ethtool_ops = {
 	.get_link_ksettings = axienet_ethtools_get_link_ksettings,
 	.set_link_ksettings = axienet_ethtools_set_link_ksettings,
 	.nway_reset	= axienet_ethtools_nway_reset,
+	.get_pause_stats = axienet_ethtools_get_pause_stats,
+	.get_eth_mac_stats = axienet_ethtool_get_eth_mac_stats,
+	.get_eth_ctrl_stats = axienet_ethtool_get_eth_ctrl_stats,
+	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
 };
 
 static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
@@ -2268,6 +2518,10 @@ static int axienet_probe(struct platform_device *pdev)
 	u64_stats_init(&lp->rx_stat_sync);
 	u64_stats_init(&lp->tx_stat_sync);
 
+	mutex_init(&lp->stats_lock);
+	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
+	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
+
 	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
 	if (!lp->axi_clk) {
 		/* For backward compatibility, if named AXI clock is not present,
@@ -2308,6 +2562,9 @@ static int axienet_probe(struct platform_device *pdev)
 	/* Setup checksum offload, but default to off if not specified */
 	lp->features = 0;
 
+	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
+		lp->features |= XAE_FEATURE_STATS;
+
 	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum", &value);
 	if (!ret) {
 		switch (value) {
-- 
2.35.1.1320.gc452695387.dirty


