Return-Path: <netdev+bounces-102396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7F4902C53
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6DD1F21738
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26C155CB7;
	Mon, 10 Jun 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kj72rHvX"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB836155C95
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061040; cv=none; b=HL0r9fRsDf+md4c7tciugqauyiMbLUlnS7zN5nln5DVa4Gl8QyepbnZXtxGJAsnlCjEEZfQ+5gYm9wLyHl42l1PvG2uUk0VR7O8jgN7Xe6pQWIYt0PRR8va1Md2Ro+L9YE19KE334gOhjKWtHqlla2tQiySbqWJw7WSOU9yJmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061040; c=relaxed/simple;
	bh=l17qFt/CPZnHMW53uOPRCNGX+ckhGy1phTMhuS9KhpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXld2xQ0ocEH5/I5316R1pgkD6A3ViZpeIl7whGT5FiZjtVrxWAf6POsawhg03t3opv8V7DcvrQUGI81P5Hfirr7AM79lU+9lUL8FiokxnDsI1od/Xu0nJmCcAbgqjLH8hCzQaG857YWT0cLtnAASoYv9yV5XmiIus4k5q3iPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kj72rHvX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718061035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0rd3nSSFEOjeW1hqTgcl23hkNVtYmFuOYgH2Rufxn8=;
	b=kj72rHvXFdAXAoRuCBVW9hnTgvrAaodfN+rsr80wIHuWyAdD6IZ4FsAk1MCkCQE1QQRkpo
	LEMtIhBEcKfIw2OMVPOq1bpINTWzRTxwvUyYg3EPS0wfF33LFoFOhpi+RYV8y0rVtPV1+u
	sWia276hz/WL8un8zrezPECnjcKkCqg=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
Date: Mon, 10 Jun 2024 19:10:22 -0400
Message-Id: <20240610231022.2460953-4-sean.anderson@linux.dev>
In-Reply-To: <20240610231022.2460953-1-sean.anderson@linux.dev>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for reading the statistics counters, if they are enabled.
The counters may be 64-bit, but we can't detect this as there's no
ability bit for it and the counters are read-only. Therefore, we assume
the counters are 32-bits. To ensure we don't miss an overflow, we need
to read all counters at regular intervals, configurable with
stats-block-usecs. This should be often enough to ensure the bytes
counters don't wrap at 2.5 Gbit/s.

Another complication is that the counters may be reset when the device
is reset (depending on configuration). To ensure the counters persist
across link up/down (including suspend/resume), we maintain our own
64-bit versions along with the last counter value we saw. Because we
might wait up to 100 ms for the reset to complete, we use a mutex to
protect writing hw_stats. We can't sleep in ndo_get_stats64, so we use a
u64_stats_sync to protect readers.

We can't use the byte counters for either get_stats64 or
get_eth_mac_stats. This is because the byte counters include everything
in the frame (destination address to FCS, inclusive). But
rtnl_link_stats64 wants bytes excluding the FCS, and
ethtool_eth_mac_stats wants to exclude the L2 overhead (addresses and
length/type).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  81 ++++++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 267 +++++++++++++++++-
 2 files changed, 345 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fa5500decc96..c121e9b1c41d 100644
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
 #define XAE_FEATURE_FULL_RX_CSUM	(1 << 2)
 #define XAE_FEATURE_FULL_TX_CSUM	(1 << 3)
 #define XAE_FEATURE_DMA_64BIT		(1 << 4)
+#define XAE_FEATURE_STATS		(1 << 5)
 
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
@@ -434,6 +502,11 @@ struct skbuf_dma_descriptor {
  * @tx_packets: TX packet count for statistics
  * @tx_bytes:	TX byte count for statistics
  * @tx_stat_sync: Synchronization object for TX stats
+ * @hw_last_counter: Last-seen value of each statistic
+ * @hw_stats: Interface statistics periodically updated from hardware counters
+ * @hw_stats_sync: Synchronization object for @hw_stats
+ * @stats_lock: Lock for writing @hw_stats and @hw_last_counter
+ * @stats_work: Work for reading the hardware statistics counters
  * @dma_err_task: Work structure to process Axi DMA errors
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
@@ -452,6 +525,7 @@ struct skbuf_dma_descriptor {
  * @coalesce_usec_rx:	IRQ coalesce delay for RX
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
+ * @coalesce_usec_stats: Delay between hardware statistics refreshes
  * @use_dmaengine: flag to check dmaengine framework usage.
  * @tx_chan:	TX DMA channel.
  * @rx_chan:	RX DMA channel.
@@ -505,6 +579,12 @@ struct axienet_local {
 	u64_stats_t tx_bytes;
 	struct u64_stats_sync tx_stat_sync;
 
+	u32 hw_last_counter[STAT_COUNT];
+	u64_stats_t hw_stats[STAT_COUNT];
+	struct u64_stats_sync hw_stat_sync;
+	struct mutex stats_lock;
+	struct delayed_work stats_work;
+
 	struct work_struct dma_err_task;
 
 	int tx_irq;
@@ -525,6 +605,7 @@ struct axienet_local {
 	u32 coalesce_usec_rx;
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
+	u32 coalesce_usec_stats;
 	u8  use_dmaengine;
 	struct dma_chan *tx_chan;
 	struct dma_chan *rx_chan;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index cf8908794409..0ec1dc6dde3f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -518,11 +518,53 @@ static void axienet_setoptions(struct net_device *ndev, u32 options)
 	lp->options |= options;
 }
 
+static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
+{
+	return u64_stats_read(&lp->hw_stats[stat]);
+}
+
+static void axienet_stats_update(struct axienet_local *lp)
+{
+	enum temac_stat stat;
+
+	lockdep_assert_held(&lp->stats_lock);
+
+	u64_stats_update_begin(&lp->hw_stat_sync);
+	for (stat = 0; stat < STAT_COUNT; stat++) {
+		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
+
+		u64_stats_add(&lp->hw_stats[stat],
+			      counter - lp->hw_last_counter[stat]);
+		lp->hw_last_counter[stat] = counter;
+	}
+	u64_stats_update_end(&lp->hw_stat_sync);
+}
+
+static void axienet_refresh_stats(struct work_struct *work)
+{
+	struct axienet_local *lp = container_of(work, struct axienet_local,
+						stats_work.work);
+
+	mutex_lock(&lp->stats_lock);
+	axienet_stats_update(lp);
+	mutex_unlock(&lp->stats_lock);
+
+	if (lp->coalesce_usec_stats)
+		schedule_delayed_work(&lp->stats_work,
+				      usecs_to_jiffies(lp->coalesce_usec_stats));
+}
+
 static int __axienet_device_reset(struct axienet_local *lp)
 {
 	u32 value;
 	int ret;
 
+	/* Save statistics counters in case they will be reset */
+	if (lp->features & XAE_FEATURE_STATS) {
+		mutex_lock(&lp->stats_lock);
+		axienet_stats_update(lp);
+	}
+
 	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The reset
 	 * process of Axi DMA takes a while to complete as all pending
 	 * commands/transfers will be flushed or completed during this
@@ -537,7 +579,7 @@ static int __axienet_device_reset(struct axienet_local *lp)
 				XAXIDMA_TX_CR_OFFSET);
 	if (ret) {
 		dev_err(lp->dev, "%s: DMA reset timeout!\n", __func__);
-		return ret;
+		goto err;
 	}
 
 	/* Wait for PhyRstCmplt bit to be set, indicating the PHY reset has finished */
@@ -547,10 +589,25 @@ static int __axienet_device_reset(struct axienet_local *lp)
 				XAE_IS_OFFSET);
 	if (ret) {
 		dev_err(lp->dev, "%s: timeout waiting for PhyRstCmplt\n", __func__);
-		return ret;
+		goto err;
+	}
+
+	/* Update statistics counters with new values */
+	if (lp->features & XAE_FEATURE_STATS) {
+		enum temac_stat stat;
+
+		for (stat = 0; stat < STAT_COUNT; stat++)
+			lp->hw_last_counter[stat] =
+				axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
+		mutex_unlock(&lp->stats_lock);
 	}
 
 	return 0;
+
+err:
+	if (lp->features & XAE_FEATURE_STATS)
+		mutex_unlock(&lp->stats_lock);
+	return ret;
 }
 
 /**
@@ -1532,6 +1589,11 @@ static int axienet_open(struct net_device *ndev)
 
 	phylink_start(lp->phylink);
 
+	/* Start the statistics refresh work */
+	if (lp->coalesce_usec_stats)
+		schedule_delayed_work(&lp->stats_work,
+				      usecs_to_jiffies(lp->coalesce_usec_stats));
+
 	if (lp->use_dmaengine) {
 		/* Enable interrupts for Axi Ethernet core (if defined) */
 		if (lp->eth_irq > 0) {
@@ -1556,6 +1618,7 @@ static int axienet_open(struct net_device *ndev)
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
 err_phy:
+	cancel_delayed_work_sync(&lp->stats_work);
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
 	return ret;
@@ -1583,6 +1646,8 @@ static int axienet_stop(struct net_device *ndev)
 		napi_disable(&lp->napi_rx);
 	}
 
+	cancel_delayed_work_sync(&lp->stats_work);
+
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
 
@@ -1695,6 +1760,35 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		stats->tx_packets = u64_stats_read(&lp->tx_packets);
 		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
 	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	do {
+		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
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
+	} while (u64_stats_fetch_retry(&lp->hw_stat_sync, start));
 }
 
 static const struct net_device_ops axienet_netdev_ops = {
@@ -1920,6 +2014,7 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
 	ecoalesce->rx_coalesce_usecs = lp->coalesce_usec_rx;
 	ecoalesce->tx_max_coalesced_frames = lp->coalesce_count_tx;
 	ecoalesce->tx_coalesce_usecs = lp->coalesce_usec_tx;
+	ecoalesce->stats_block_coalesce_usecs = lp->coalesce_usec_stats;
 	return 0;
 }
 
@@ -1958,6 +2053,9 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		lp->coalesce_count_tx = ecoalesce->tx_max_coalesced_frames;
 	if (ecoalesce->tx_coalesce_usecs)
 		lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
+	/* Just less than 2^32 bytes at 2.5 GBit/s */
+	lp->coalesce_usec_stats = min(ecoalesce->stats_block_coalesce_usecs,
+				      13 * USEC_PER_SEC);
 
 	return 0;
 }
@@ -1987,9 +2085,160 @@ static int axienet_ethtools_nway_reset(struct net_device *dev)
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
+		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
+		pause_stats->tx_pause_frames =
+			axienet_stat(lp, STAT_TX_PAUSE_FRAMES);
+		pause_stats->rx_pause_frames =
+			axienet_stat(lp, STAT_RX_PAUSE_FRAMES);
+	} while (u64_stats_fetch_retry(&lp->hw_stat_sync, start));
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
+		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
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
+	} while (u64_stats_fetch_retry(&lp->hw_stat_sync, start));
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
+		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
+		ctrl_stats->MACControlFramesTransmitted =
+			axienet_stat(lp, STAT_TX_CONTROL_FRAMES);
+		ctrl_stats->MACControlFramesReceived =
+			axienet_stat(lp, STAT_RX_CONTROL_FRAMES);
+		ctrl_stats->UnsupportedOpcodesReceived =
+			axienet_stat(lp, STAT_RX_CONTROL_OPCODE_ERRORS);
+	} while (u64_stats_fetch_retry(&lp->hw_stat_sync, start));
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
+		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
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
+	} while (u64_stats_fetch_retry(&lp->hw_stat_sync, start));
+
+	*ranges = axienet_rmon_ranges;
+}
+
 static const struct ethtool_ops axienet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-				     ETHTOOL_COALESCE_USECS,
+				     ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_STATS_BLOCK_USECS,
 	.get_drvinfo    = axienet_ethtools_get_drvinfo,
 	.get_regs_len   = axienet_ethtools_get_regs_len,
 	.get_regs       = axienet_ethtools_get_regs,
@@ -2003,6 +2252,10 @@ static const struct ethtool_ops axienet_ethtool_ops = {
 	.get_link_ksettings = axienet_ethtools_get_link_ksettings,
 	.set_link_ksettings = axienet_ethtools_set_link_ksettings,
 	.nway_reset	= axienet_ethtools_nway_reset,
+	.get_pause_stats = axienet_ethtools_get_pause_stats,
+	.get_eth_mac_stats = axienet_ethtool_get_eth_mac_stats,
+	.get_eth_ctrl_stats = axienet_ethtool_get_eth_ctrl_stats,
+	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
 };
 
 static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
@@ -2271,6 +2524,10 @@ static int axienet_probe(struct platform_device *pdev)
 
 	u64_stats_init(&lp->rx_stat_sync);
 	u64_stats_init(&lp->tx_stat_sync);
+	u64_stats_init(&lp->hw_stat_sync);
+
+	mutex_init(&lp->stats_lock);
+	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
 
 	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
 	if (!lp->axi_clk) {
@@ -2312,6 +2569,9 @@ static int axienet_probe(struct platform_device *pdev)
 	/* Setup checksum offload, but default to off if not specified */
 	lp->features = 0;
 
+	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
+		lp->features |= XAE_FEATURE_STATS;
+
 	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum", &value);
 	if (!ret) {
 		switch (value) {
@@ -2527,6 +2787,7 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
+	lp->coalesce_usec_stats = USEC_PER_SEC;
 
 	ret = axienet_mdio_setup(lp);
 	if (ret)
-- 
2.35.1.1320.gc452695387.dirty


