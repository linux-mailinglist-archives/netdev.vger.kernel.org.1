Return-Path: <netdev+bounces-124693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774ED96A751
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F4286366
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315B3DAC12;
	Tue,  3 Sep 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O9ZCCavW"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309511C9DC1
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391540; cv=none; b=nATEUrB3LXCeJdsBnJzKCENrpcQgq+MaApCXpPSm9pVWF4nJWMISyf17YfWHJxPPOi6IjWDAOUNm0VV2hx6UaC9hjlikVH9w2tKCYkal85pahWiFe1TgNqyBRAo6OW6RcPdfTkrvgEAHSAG3YC1iLaf8mwebc56Jq/3Q9zKXZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391540; c=relaxed/simple;
	bh=bDnHxdtJ7IHBsfJX9KRLzf2UYblXRT0P2Pp0gX6F8yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7tWyVEjnLTSx8YDLkRTIUFA99UqqvGF6vyyk1dDEdEe9XhyQJIYxk5oT5s0BNwpPINMGWHw5/VDcf40vqolt77ovUc/j7k/3rssDa5aW8297DV0lsyQmeCQMWhEshZtrlGtPUvzr5UzcLas4FTRvUI0ufPZIut6gXHRIE6bTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O9ZCCavW; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725391536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNZIT9eYhDrG20hdoMz93yYpa7NEh7zBa3Tl7htarHI=;
	b=O9ZCCavWSdN/NwUn3JZVAEIq4EEh4Fhr/xbgJPP7MgykeXhI17Olcj0rxCfX6otCdLTydW
	YWNlc43JQQ3cK80ulQRzYpnvG/YGgexzyc5M4l1RnpIBtjQhxRv+YY3bEvbAu9qDyJoOxJ
	Nt5ff7waYkco+lW1jO+zzr2aN1liVTI=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next 2/2] net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
Date: Tue,  3 Sep 2024 15:25:24 -0400
Message-Id: <20240903192524.4158713-3-sean.anderson@linux.dev>
In-Reply-To: <20240903192524.4158713-1-sean.anderson@linux.dev>
References: <20240903192524.4158713-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The default RX IRQ coalescing settings of one IRQ per packet can represent
a significant CPU load. However, increasing the coalescing unilaterally
can result in undesirable latency under low load. Adaptive IRQ
coalescing with DIM offers a way to adjust the coalescing settings based
on load.

This device only supports "CQE" mode [1], where each packet resets the
timer. Therefore, an interrupt is fired either when we receive
coalesce_count_rx packets or when the interface is idle for
coalesce_usec_rx. With this in mind, consider the following scenarios:

Link saturated
    Here we want to set coalesce_count_rx to a large value, in order to
    coalesce more packets and reduce CPU load. coalesce_usec_rx should
    be set to at least the time for one packet. Otherwise the link will
    be "idle" and we will get an interrupt for each packet anyway.

Bursts of packets
    Each burst should be coalesced into a single interrupt, although it
    may be prudent to reduce coalesce_count_rx for better latency.
    coalesce_usec_rx should be set to at least the time for one packet
    so bursts are coalesced. However, additional time beyond the packet
    time will just increase latency at the end of a burst.

Sporadic packets
    Due to low load, we can set coalesce_count_rx to 1 in order to
    reduce latency to the minimum. coalesce_usec_rx does not matter in
    this case.

Based on this analysis, I expected the CQE profiles to look something
like

	usec =  0, pkts = 1   // Low load
	usec = 16, pkts = 4
	usec = 16, pkts = 16
	usec = 16, pkts = 64
	usec = 16, pkts = 256 // High load

Where usec is set to 16 to be a few us greater than the 12.3 us packet
time of a 1500 MTU packet at 1 GBit/s. However, the CQE profile is
instead

	usec =  2, pkts = 256 // Low load
	usec =  8, pkts = 128
	usec = 16, pkts =  64
	usec = 32, pkts =  64
	usec = 64, pkts =  64 // High load

I found this very surprising. The number of coalesced packets
*decreases* as load increases. But as load increases we have more
opportunities to coalesce packets without affecting latency as much.
Additionally, the profile *increases* the usec as the load increases.
But as load increases, the gaps between packets will tend to become
smaller, making it possible to *decrease* usec for better latency at the
end of a "burst".

I consider the default CQE profile unsuitable for this NIC. Therefore,
we use the first profile outlined in this commit instead.
coalesce_usec_rx is set to 16 by default, but the user can customize it.
This may be necessary if they are using jumbo frames. I think adjusting
the profile times based on the link speed/mtu would be good improvement
for generic DIM.

In addition to the above profile problems, I noticed the following
additional issues with DIM while testing:

- DIM tends to "wander" when at low load, since the performance gradient
  is pretty flat. If you only have 10p/ms anyway then adjusting the
  coalescing settings will not affect throughput very much.
- DIM takes a long time to adjust back to low indices when load is
  decreased following a period of high load. This is because it only
  re-evaluates its settings once every 64 interrupts. However, at low
  load 64 interrupts can be several seconds.

Finally: performance. This patch increases receive throughput with
iperf3 from 840 Mbits/sec to 938 Mbits/sec, decreases interrupts from
69920/sec to 316/sec, and decreases CPU utilization (4x Cortex-A53) from
43% to 9%. I did not notice an increase in latency with this patch
applied.

[1] Who names this stuff?

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Heng, maybe you have some comments on DIM regarding the above?

 drivers/net/ethernet/xilinx/Kconfig           |  1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  | 10 ++-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 71 +++++++++++++++++--
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 35d96c633a33..7502214cc7d5 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -28,6 +28,7 @@ config XILINX_AXI_EMAC
 	depends on HAS_IOMEM
 	depends on XILINX_DMA
 	select PHYLINK
+	select DIMLIB
 	help
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
 	  AXI bus interface used in Xilinx Virtex FPGAs and Soc's.
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 66cb8aa5b716..68303ece8285 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -9,6 +9,7 @@
 #ifndef XILINX_AXIENET_H
 #define XILINX_AXIENET_H
 
+#include <linux/dim.h>
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -123,8 +124,7 @@
 /* Default TX/RX Threshold and delay timer values for SGDMA mode */
 #define XAXIDMA_DFT_TX_THRESHOLD	24
 #define XAXIDMA_DFT_TX_USEC		50
-#define XAXIDMA_DFT_RX_THRESHOLD	1
-#define XAXIDMA_DFT_RX_USEC		50
+#define XAXIDMA_DFT_RX_USEC		16
 
 #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
@@ -484,6 +484,9 @@ struct skbuf_dma_descriptor {
  * @regs:	Base address for the axienet_local device address space
  * @dma_regs:	Base address for the axidma device address space
  * @napi_rx:	NAPI RX control structure
+ * @rx_dim:     DIM state for the receive queue
+ * @rx_irqs:    Number of interrupts
+ * @rx_dim_enabled: Whether DIM is enabled or not
  * @rx_cr_lock: Lock protecting @rx_dma_cr, its register, and @rx_dma_started
  * @rx_dma_cr:  Nominal content of RX DMA control register
  * @rx_dma_started: Set when RX DMA is started
@@ -570,6 +573,9 @@ struct axienet_local {
 	void __iomem *dma_regs;
 
 	struct napi_struct napi_rx;
+	struct dim rx_dim;
+	bool rx_dim_enabled;
+	u16 rx_irqs;
 	spinlock_t rx_cr_lock;
 	u32 rx_dma_cr;
 	bool rx_dma_started;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 7bd109b77afc..24d434f99bce 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1262,6 +1262,18 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 	if (packets < budget && napi_complete_done(napi, packets)) {
 		unsigned long flags;
 
+		if (READ_ONCE(lp->rx_dim_enabled)) {
+			struct dim_sample sample = {
+				.time = ktime_get(),
+				/* Safe because we are the only writer */
+				.pkt_ctr = u64_stats_read(&lp->rx_packets),
+				.byte_ctr = u64_stats_read(&lp->rx_bytes),
+				.event_ctr = lp->rx_irqs,
+			};
+
+			net_dim(&lp->rx_dim, sample);
+		}
+
 		/* Re-enable RX completion interrupts. This should
 		 * cause an immediate interrupt if any RX packets are
 		 * already pending.
@@ -1364,6 +1376,7 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
 		spin_unlock_irqrestore(&lp->rx_cr_lock, flags);
 
 		napi_schedule(&lp->napi_rx);
+		lp->rx_irqs++;
 	}
 
 	return IRQ_HANDLED;
@@ -1588,6 +1601,7 @@ static int axienet_init_legacy_dma(struct net_device *ndev)
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
 	cancel_work_sync(&lp->dma_err_task);
+	cancel_work_sync(&lp->rx_dim.work);
 	dev_err(lp->dev, "request_irq() failed\n");
 	return ret;
 }
@@ -1679,6 +1693,7 @@ static int axienet_stop(struct net_device *ndev)
 		napi_disable(&lp->napi_rx);
 	}
 
+	cancel_work_sync(&lp->rx_dim.work);
 	cancel_delayed_work_sync(&lp->stats_work);
 
 	phylink_stop(lp->phylink);
@@ -2051,6 +2066,32 @@ static void axienet_update_coalesce_rx(struct axienet_local *lp)
 	spin_unlock_irq(&lp->rx_cr_lock);
 }
 
+/**
+ * axienet_dim_coalesce_rx() - Update RX coalesce settings from DIM
+ * @lp: Device private data
+ */
+static void axienet_dim_coalesce_rx(struct axienet_local *lp)
+{
+	lp->coalesce_count_rx = 1 << (lp->rx_dim.profile_ix << 1);
+}
+
+/**
+ * axienet_rx_dim_work() - Adjust RX DIM settings
+ * @work: The work struct
+ */
+static void axienet_rx_dim_work(struct work_struct *work)
+{
+	struct axienet_local *lp =
+		container_of(work, struct axienet_local, rx_dim.work);
+
+	rtnl_lock();
+	axienet_dim_coalesce_rx(lp);
+	axienet_update_coalesce_rx(lp);
+	rtnl_unlock();
+
+	lp->rx_dim.state = DIM_START_MEASURE;
+}
+
 /**
  * axienet_update_coalesce_tx() - Update TX coalesce settings
  * @lp: Device private data
@@ -2100,6 +2141,7 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
 {
 	struct axienet_local *lp = netdev_priv(ndev);
 
+	ecoalesce->use_adaptive_rx_coalesce = lp->rx_dim_enabled;
 	ecoalesce->rx_max_coalesced_frames = lp->coalesce_count_rx;
 	ecoalesce->rx_coalesce_usecs = lp->coalesce_usec_rx;
 	ecoalesce->tx_max_coalesced_frames = lp->coalesce_count_tx;
@@ -2127,9 +2169,21 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 			      struct netlink_ext_ack *extack)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+	bool new_dim = ecoalesce->use_adaptive_rx_coalesce;
+	bool old_dim = lp->rx_dim_enabled;
+
+	if (!new_dim) {
+		if (old_dim) {
+			WRITE_ONCE(lp->rx_dim_enabled, false);
+			napi_synchronize(&lp->napi_rx);
+			flush_work(&lp->rx_dim.work);
+		}
+
+		if (ecoalesce->rx_max_coalesced_frames)
+			lp->coalesce_count_rx =
+				ecoalesce->rx_max_coalesced_frames;
+	}
 
-	if (ecoalesce->rx_max_coalesced_frames)
-		lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
 	if (ecoalesce->rx_coalesce_usecs)
 		lp->coalesce_usec_rx = ecoalesce->rx_coalesce_usecs;
 	if (ecoalesce->tx_max_coalesced_frames)
@@ -2137,6 +2191,11 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 	if (ecoalesce->tx_coalesce_usecs)
 		lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
 
+	if (new_dim && !old_dim) {
+		axienet_dim_coalesce_rx(lp);
+		WRITE_ONCE(lp->rx_dim_enabled, true);
+	}
+
 	axienet_update_coalesce_rx(lp);
 	axienet_update_coalesce_tx(lp);
 	return 0;
@@ -2376,7 +2435,8 @@ axienet_ethtool_get_rmon_stats(struct net_device *dev,
 
 static const struct ethtool_ops axienet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-				     ETHTOOL_COALESCE_USECS,
+				     ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo    = axienet_ethtools_get_drvinfo,
 	.get_regs_len   = axienet_ethtools_get_regs_len,
 	.get_regs       = axienet_ethtools_get_regs,
@@ -2925,7 +2985,10 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
-	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
+	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
+	lp->rx_dim_enabled = true;
+	lp->rx_dim.profile_ix = 1;
+	axienet_dim_coalesce_rx(lp);
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
-- 
2.35.1.1320.gc452695387.dirty


