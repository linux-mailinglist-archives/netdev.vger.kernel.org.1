Return-Path: <netdev+bounces-126746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D39725EB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06271F249CA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2711917FF;
	Mon,  9 Sep 2024 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P96N8hBC"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5B18FC81
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925948; cv=none; b=uvYjYTihiLhvAHQjWGIeBPva02L2jU0lDNXDvCdxRvXHcLAichUPHa7CS7ZZ7j83xL+eMWooXVDv0IWLTO1sToNcYyn/v1vJ4wB5ONVGYvcZOZTnMWRxwAg3pjsAgUMi9BQoUM8h61xlvpL2cvYKte0sHgQi3VzMBfpjX4FofnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925948; c=relaxed/simple;
	bh=OJs1JXSwoen/LWW8JMB7/K3ew8Y3ZuyVgG2yuAh9Ntc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDPlrHhcPnIMPMMlea5uVzBOBUR59WwtJ/sBMzPEaezUIxdlTg7GgEwH1VMfj+eGoZX2B8f6Z5NW084XK8Rwqd7nILYysPqgNR7crfWHHo9TFll/5o0s4vPX2x2FwBIMDlGRDSYlmJSNeS9ygFpyDIo5dLPCqbvm3orYxt53reQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P96N8hBC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725925944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HpjAZM+TWby3wVWVYyL+dHW5q5pMysAcY47I4DBh+M=;
	b=P96N8hBCxqP3urN/33qiWa8ilJEjwRtbz+bE31uxrSllHTpCkFG4nUIT91EgDjoqZ5WzD9
	CNES6j2VamHKzQ8MhejyZyBp+Zkbcq6XOxQKAm5+9NtZfYX+s3LvQSssNa3Z/Fw0oHzCWR
	8s7H7eXDkDlmyJ3xzP7lZU7qA00D7po=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: [RFC PATCH net-next v2 6/6] net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
Date: Mon,  9 Sep 2024 19:52:08 -0400
Message-Id: <20240909235208.1331065-7-sean.anderson@linux.dev>
In-Reply-To: <20240909235208.1331065-1-sean.anderson@linux.dev>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
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
43% to 9%.

[1] Who names this stuff?

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Heng, maybe you have some comments on DIM regarding the above?

Changes in v2:
- Don't take the RTNL in axienet_rx_dim_work to avoid deadlock. Instead,
  calculate a partial cr update that axienet_update_coalesce_rx can
  perform under a spin lock.
- Use READ/WRITE_ONCE when accessing/modifying rx_irqs

 drivers/net/ethernet/xilinx/Kconfig           |  1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  | 10 ++-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 80 +++++++++++++++++--
 3 files changed, 82 insertions(+), 9 deletions(-)

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
index 33d05e55567e..b6604e354de7 100644
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
@@ -566,6 +569,9 @@ struct axienet_local {
 	void __iomem *dma_regs;
 
 	struct napi_struct napi_rx;
+	struct dim rx_dim;
+	bool rx_dim_enabled;
+	u16 rx_irqs;
 	spinlock_t rx_cr_lock;
 	u32 rx_dma_cr;
 	bool rx_dma_started;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index eb9600417d81..194ae87f534a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1279,6 +1279,18 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 		axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
 
 	if (packets < budget && napi_complete_done(napi, packets)) {
+		if (READ_ONCE(lp->rx_dim_enabled)) {
+			struct dim_sample sample = {
+				.time = ktime_get(),
+				/* Safe because we are the only writer */
+				.pkt_ctr = u64_stats_read(&lp->rx_packets),
+				.byte_ctr = u64_stats_read(&lp->rx_bytes),
+				.event_ctr = READ_ONCE(lp->rx_irqs),
+			};
+
+			net_dim(&lp->rx_dim, sample);
+		}
+
 		/* Re-enable RX completion interrupts. This should
 		 * cause an immediate interrupt if any RX packets are
 		 * already pending.
@@ -1373,6 +1385,7 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
 		 */
 		u32 cr;
 
+		WRITE_ONCE(lp->rx_irqs, READ_ONCE(lp->rx_irqs) + 1);
 		spin_lock(&lp->rx_cr_lock);
 		cr = lp->rx_dma_cr;
 		cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
@@ -1670,6 +1683,7 @@ static int axienet_open(struct net_device *ndev)
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
 err_phy:
+	cancel_work_sync(&lp->rx_dim.work);
 	cancel_delayed_work_sync(&lp->stats_work);
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -1696,6 +1710,7 @@ static int axienet_stop(struct net_device *ndev)
 		napi_disable(&lp->napi_rx);
 	}
 
+	cancel_work_sync(&lp->rx_dim.work);
 	cancel_delayed_work_sync(&lp->stats_work);
 
 	phylink_stop(lp->phylink);
@@ -2068,6 +2083,31 @@ static void axienet_update_coalesce_rx(struct axienet_local *lp, u32 cr,
 	spin_unlock_irq(&lp->rx_cr_lock);
 }
 
+/**
+ * axienet_dim_coalesce_count_rx() - RX coalesce count for DIM
+ * @lp: Device private data
+ */
+static u32 axienet_dim_coalesce_count_rx(struct axienet_local *lp)
+{
+	return 1 << (lp->rx_dim.profile_ix << 1);
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
+	u32 cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp), 0);
+	u32 mask = XAXIDMA_COALESCE_MASK | XAXIDMA_IRQ_IOC_MASK |
+		   XAXIDMA_IRQ_ERROR_MASK;
+
+	axienet_update_coalesce_rx(lp, cr, mask);
+	lp->rx_dim.state = DIM_START_MEASURE;
+}
+
 /**
  * axienet_set_cr_tx() - Set TX CR
  * @lp: Device private data
@@ -2118,6 +2158,8 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
 	struct axienet_local *lp = netdev_priv(ndev);
 	u32 cr;
 
+	ecoalesce->use_adaptive_rx_coalesce = lp->rx_dim_enabled;
+
 	spin_lock_irq(&lp->rx_cr_lock);
 	cr = lp->rx_dma_cr;
 	spin_unlock_irq(&lp->rx_cr_lock);
@@ -2154,7 +2196,9 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 			      struct netlink_ext_ack *extack)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
-	u32 cr;
+	bool new_dim = ecoalesce->use_adaptive_rx_coalesce;
+	bool old_dim = lp->rx_dim_enabled;
+	u32 cr, mask = ~XAXIDMA_CR_RUNSTOP_MASK;
 
 	if (!ecoalesce->rx_max_coalesced_frames ||
 	    !ecoalesce->tx_max_coalesced_frames) {
@@ -2162,7 +2206,7 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	if ((ecoalesce->rx_max_coalesced_frames > 1 &&
+	if (((ecoalesce->rx_max_coalesced_frames > 1 || new_dim) &&
 	     !ecoalesce->rx_coalesce_usecs) ||
 	    (ecoalesce->tx_max_coalesced_frames > 1 &&
 	     !ecoalesce->tx_coalesce_usecs)) {
@@ -2171,9 +2215,27 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	cr = axienet_calc_cr(lp, ecoalesce->rx_max_coalesced_frames,
-			     ecoalesce->rx_coalesce_usecs);
-	axienet_update_coalesce_rx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
+	if (new_dim && !old_dim) {
+		cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
+				     ecoalesce->rx_coalesce_usecs);
+	} else if (!new_dim) {
+		if (old_dim) {
+			WRITE_ONCE(lp->rx_dim_enabled, false);
+			napi_synchronize(&lp->napi_rx);
+			flush_work(&lp->rx_dim.work);
+		}
+
+		cr = axienet_calc_cr(lp, ecoalesce->rx_max_coalesced_frames,
+				     ecoalesce->rx_coalesce_usecs);
+	} else {
+		/* Dummy value for count just to calculate timer */
+		cr = axienet_calc_cr(lp, 2, ecoalesce->rx_coalesce_usecs);
+		mask = XAXIDMA_DELAY_MASK | XAXIDMA_IRQ_DELAY_MASK;
+	}
+
+	axienet_update_coalesce_rx(lp, cr, mask);
+	if (new_dim && !old_dim)
+		WRITE_ONCE(lp->rx_dim_enabled, true);
 
 	cr = axienet_calc_cr(lp, ecoalesce->tx_max_coalesced_frames,
 			     ecoalesce->tx_coalesce_usecs);
@@ -2415,7 +2477,8 @@ axienet_ethtool_get_rmon_stats(struct net_device *dev,
 
 static const struct ethtool_ops axienet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-				     ETHTOOL_COALESCE_USECS,
+				     ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo    = axienet_ethtools_get_drvinfo,
 	.get_regs_len   = axienet_ethtools_get_regs_len,
 	.get_regs       = axienet_ethtools_get_regs,
@@ -2964,7 +3027,10 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
-	lp->rx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_RX_THRESHOLD,
+	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
+	lp->rx_dim_enabled = true;
+	lp->rx_dim.profile_ix = 1;
+	lp->rx_dma_cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
 					XAXIDMA_DFT_RX_USEC);
 	lp->tx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_TX_THRESHOLD,
 					XAXIDMA_DFT_TX_USEC);
-- 
2.35.1.1320.gc452695387.dirty


