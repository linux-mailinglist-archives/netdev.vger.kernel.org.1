Return-Path: <netdev+bounces-203586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C3AF678C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B2A525796
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93F248883;
	Thu,  3 Jul 2025 01:52:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB3248F73;
	Thu,  3 Jul 2025 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507531; cv=none; b=dNJRNi3B8xLJr+vYtIBN1BJ03G0L2TZxG75RkoaDbBywcbzJ02RUMFEffvc4bqbCnnspjHRcTR3ijqHIWIaPvR6afRyYkYbu6Vf0doqSzcP8ExHs+KaVMLWpCHNRdKwPCz1qRHNsrTAf+twAzKxl3p/bAohdsYPUkk+rZt++gLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507531; c=relaxed/simple;
	bh=ihO9YbPnP8iNCV5NmH2yfc9a4/oEZ7qLZ8fmKO09ye0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIUGsyp97UPUCBI1VW4EA/3Ad+ymB+PEHVqJN+T8iRv566SXJXoLjEhfCJhVDOjZPgYQ3Rqrqk9C6IjJ7fUB8F4P/X+J4PENE6X3rZaj4jHRN8UDbALriLnW7WYFH2f86nEImew+Jn9bQgU78R6zwMQ1OPBEE5xVDm2nyGOQ7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507403tc24b536c
X-QQ-Originating-IP: 6jaqYZdkiWt/CIy1mBUqH84phgg54kjOR8/S2ofXLdQ=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:50:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6159585008016695815
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 12/15] net: rnpgbe: Add link up handler
Date: Thu,  3 Jul 2025 09:48:56 +0800
Message-Id: <20250703014859.210110-13-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OHca88UHYcuYMzxNxwx0vPm0c2zQp/Fb/i9la4xbHs/PoHxcHN/AfJpY
	4bZ2wnh4vjBz4Uy8oLHNWvopZCFTiuot2IJib/yliBRvI9u9HDYZleqNmKiWmpRoryOMMUX
	ZBsw4AhMpAHPecNlNifVrpEXv0uErEqoRh7ywmXBLARWARiFRFF+I2WFznqaAXgiIx4XvhR
	ma1/WzOgt8kABOA+4unz00BWhGTWm6zn3hIF88iLD/Fum2ATKWcT0f9ji89QLmV4IL3IRpD
	ZHtiy5ZqYjHJT3U0dXLiZwnj1VMerRsQISeqD18L3fWZJvSvZknz2dlNZuyzFPQxfU6LuLX
	HWnYgKl/YGeMBnygijz7FS59DVoOcfwhCZBDdV3fpFPiZdWcxOIPzzTucJ3V6O4iaWnDjg+
	QBwu9PQS3LJbVWihh5pT9dmM2GwhU9HmtOnZNJM/7tKuzjKaW7aOd/lrkCATCbQR8beEwyk
	6RriAKCSHtQ5f3Dp+9Wi4rdWMidv6hnkWOZXKBieKcW+Dx+7bexGIsYZZ3u9FZrqsdIKFWv
	cstj8BG+78PekqdvyrGCEHZMZ0ZgNEDpeGONd0bnSTP+SjQmOMUu0rav+0FmPRtzb50qbpf
	B7hKxrYNzoXNUT+uw7he2M3+dBNFtY35PyixoMSZ72p2Gjz0lehYeeGQbgw2CBY2ySlojYq
	IkCZO2hYlb7snCWhD6MK8dC3hyS7WrmLY+W187dCyz0lwzL0c80aeZ2abVSEc7MJGGcYBbQ
	EXavXnLBsQVhWFwSj/rGd+o+KVzNeH7UN6iE4Xz1ZRXoQHeg7ADC+oyIe/WdcU4Ha0U126f
	MaLAHxJTj6xx35IhGQIu0CYcJVFgBXNCm9BdsGUUl2EdIy+b946dNm6mH3f9Tga24Db7JL0
	ThxhKft5syaHS82JDvjG8/AATTg6Jr4/k8ucG0LLPh9mmYfgN3nJk0vfAZpVmu3ReLY5/Ne
	3AVoWffdAfOrK7K14Bhz63WqFC8yQMQT7HsdLLd6pGaKyoIDO11f2/5DPNIsMpdiCk8ZcEI
	fHdoTS4X2kx9yjPNDtLsTVKSgEmY3oIAKsL/OobY54ra4uOiKhm13PXJqyXUS64hmzmKP17
	w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Initialize link status handler

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  55 ++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  19 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 138 +++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 147 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   1 +
 6 files changed, 359 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index c049952f41e8..5ca2ec73bbe7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -25,6 +25,15 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_unknow,
 };
 
+enum speed_enum {
+	speed_10,
+	speed_100,
+	speed_1000,
+	speed_10000,
+	speed_25000,
+	speed_40000,
+};
+
 struct mucse_dma_info {
 	u8 __iomem *dma_base_addr;
 	u8 __iomem *dma_ring_addr;
@@ -120,6 +129,31 @@ struct mucse_mbx_operations {
 			 bool enable);
 };
 
+/* Flow Control Settings */
+enum mucse_fc_mode {
+	mucse_fc_none = 0,
+	mucse_fc_rx_pause,
+	mucse_fc_tx_pause,
+	mucse_fc_full,
+	mucse_fc_default
+};
+
+#define PAUSE_TX (0x1)
+#define PAUSE_RX (0x2)
+#define PAUSE_AUTO (0x10)
+#define ASYM_PAUSE BIT(11)
+#define SYM_PAUSE BIT(10)
+
+#define M_MAX_TRAFFIC_CLASS (4)
+/* Flow control parameters */
+struct mucse_fc_info {
+	u32 high_water[M_MAX_TRAFFIC_CLASS];
+	u32 low_water[M_MAX_TRAFFIC_CLASS];
+	u16 pause_time;
+	enum mucse_fc_mode current_mode;
+	enum mucse_fc_mode requested_mode;
+};
+
 struct mucse_mbx_stats {
 	u32 msgs_tx;
 	u32 msgs_rx;
@@ -185,6 +219,8 @@ struct mucse_hw_operations {
 	void (*set_irq_mode)(struct mucse_hw *hw, bool legacy);
 	void (*set_mbx_link_event)(struct mucse_hw *hw, int enable);
 	void (*set_mbx_ifup)(struct mucse_hw *hw, int enable);
+	void (*check_link)(struct mucse_hw *hw, u32 *speed, bool *link_up,
+			   bool *duplex);
 };
 
 enum {
@@ -223,6 +259,7 @@ struct mucse_hw {
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
 	struct mucse_mac_info mac;
+	struct mucse_fc_info fc;
 	struct mucse_mbx_info mbx;
 	struct mucse_addr_filter_info addr_ctrl;
 #define M_NET_FEATURE_SG ((u32)(1 << 0))
@@ -253,13 +290,17 @@ struct mucse_hw {
 	u16 max_msix_vectors;
 	int nr_lane;
 	struct lldp_status lldp_status;
+	int speed;
+	u32 duplex;
+	u32 tp_mdx;
 	int link;
 	u8 addr[ETH_ALEN];
 	u8 perm_addr[ETH_ALEN];
 };
 
 enum mucse_state_t {
-	__MMUCSE_TESTING,
+	__MUCSE_TESTING,
+	__MUCSE_RESETTING,
 	__MUCSE_DOWN,
 	__MUCSE_SERVICE_SCHED,
 	__MUCSE_PTP_TX_IN_PROGRESS,
@@ -547,6 +588,7 @@ struct mucse {
 	u32 priv_flags;
 #define M_PRIV_FLAG_TX_COALESCE ((u32)(1 << 25))
 #define M_PRIV_FLAG_RX_COALESCE ((u32)(1 << 26))
+#define M_PRIV_FLAG_LLDP ((u32)(1 << 27))
 	struct mucse_ring *tx_ring[MAX_TX_QUEUES] ____cacheline_aligned_in_smp;
 	int tx_ring_item_count;
 	int num_tx_queues;
@@ -565,6 +607,9 @@ struct mucse {
 	u16 rx_frames;
 	u16 tx_frames;
 	u16 tx_usecs;
+	bool link_up;
+	u32 link_speed;
+	bool duplex;
 	unsigned long state;
 	unsigned long link_check_timeout;
 	struct timer_list service_timer;
@@ -613,9 +658,17 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 #define M_PKT_TIMEOUT (30)
 #define M_RX_PKT_POLL_BUDGET (64)
 
+#define M_LINK_SPEED_UNKNOWN 0
+#define M_LINK_SPEED_10_FULL BIT(2)
+#define M_LINK_SPEED_100_FULL BIT(3)
+#define M_LINK_SPEED_1GB_FULL BIT(4)
+
+#define M_TRY_LINK_TIMEOUT (4 * HZ)
+
 #define m_rd_reg(reg) readl((void *)(reg))
 #define m_wr_reg(reg, val) writel((val), (void *)(reg))
 #define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
+#define hw_rd32(hw, reg) m_rd_reg((hw)->hw_addr + (reg))
 #define dma_wr32(dma, reg, val) m_wr_reg((dma)->dma_base_addr + (reg), (val))
 #define dma_rd32(dma, reg) m_rd_reg((dma)->dma_base_addr + (reg))
 #define eth_wr32(eth, reg, val) m_wr_reg((eth)->eth_base_addr + (reg), (val))
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 7cc9134952bf..cb2448f497fe 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -300,6 +300,24 @@ static void rnpgbe_set_mbx_ifup_hw_ops_n500(struct mucse_hw *hw,
 	mucse_mbx_ifup_down(hw, enable);
 }
 
+static void rnpgbe_check_mac_link_hw_ops_n500(struct mucse_hw *hw,
+					      u32 *speed,
+					      bool *link_up,
+					      bool *duplex)
+{
+	if (hw->speed == 10)
+		*speed = M_LINK_SPEED_10_FULL;
+	else if (hw->speed == 100)
+		*speed = M_LINK_SPEED_100_FULL;
+	else if (hw->speed == 1000)
+		*speed = M_LINK_SPEED_1GB_FULL;
+	else
+		*speed = M_LINK_SPEED_UNKNOWN;
+
+	*link_up = !!hw->link;
+	*duplex = !!hw->duplex;
+}
+
 static struct mucse_hw_operations hw_ops_n500 = {
 	.init_hw = &rnpgbe_init_hw_ops_n500,
 	.reset_hw = &rnpgbe_reset_hw_ops_n500,
@@ -311,6 +329,7 @@ static struct mucse_hw_operations hw_ops_n500 = {
 	.set_irq_mode = &rnpgbe_set_irq_mode_n500,
 	.set_mbx_link_event = &rnpgbe_set_mbx_link_event_hw_ops_n500,
 	.set_mbx_ifup = &rnpgbe_set_mbx_ifup_hw_ops_n500,
+	.check_link = &rnpgbe_check_mac_link_hw_ops_n500,
 };
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 01cff0a780ff..c2f53af3de09 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -84,12 +84,144 @@ static void rnpgbe_service_timer(struct timer_list *t)
 		rnpgbe_service_event_schedule(mucse);
 }
 
+static void rnpgbe_service_event_complete(struct mucse *mucse)
+{
+	/* flush memory to make sure state is correct before next watchdog */
+	smp_mb__before_atomic();
+	clear_bit(__MUCSE_SERVICE_SCHED, &mucse->state);
+}
+
+/**
+ * rnpgbe_watchdog_update_link - update the link status
+ * @mucse: pointer to the device adapter structure
+ **/
+static void rnpgbe_watchdog_update_link(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 link_speed = mucse->link_speed;
+	bool link_up;
+	bool duplex;
+	bool flow_rx = true, flow_tx = true;
+
+	if (!(mucse->flags & M_FLAG_NEED_LINK_UPDATE))
+		return;
+
+	if (hw->ops.check_link) {
+		hw->ops.check_link(hw, &link_speed, &link_up, &duplex);
+	} else {
+		/* always assume link is up, if no check link function */
+		link_speed = M_LINK_SPEED_1GB_FULL;
+		link_up = true;
+	}
+
+	if (link_up || time_after(jiffies, (mucse->link_check_timeout +
+					M_TRY_LINK_TIMEOUT))) {
+		mucse->flags &= ~M_FLAG_NEED_LINK_UPDATE;
+	}
+	mucse->link_up = link_up;
+	mucse->link_speed = link_speed;
+	mucse->duplex = duplex;
+
+	switch (hw->fc.current_mode) {
+	case mucse_fc_none:
+		flow_rx = false;
+		flow_tx = false;
+		break;
+	case mucse_fc_tx_pause:
+		flow_rx = false;
+		flow_tx = true;
+
+		break;
+	case mucse_fc_rx_pause:
+		flow_rx = true;
+		flow_tx = false;
+		break;
+
+	case mucse_fc_full:
+		flow_rx = true;
+		flow_tx = true;
+		break;
+	default:
+		flow_rx = false;
+		flow_tx = false;
+	}
+
+	if (mucse->link_up) {
+		e_info(drv, "NIC Link is Up %s, %s Duplex, Flow Control: %s\n",
+		       (link_speed == M_LINK_SPEED_1GB_FULL ? "1000 Mbps" :
+			(link_speed == M_LINK_SPEED_100_FULL ? "100 Mbps" :
+			 (link_speed == M_LINK_SPEED_10_FULL ? "10 Mbps" :
+			  "unknown speed"))),
+		       ((duplex) ? "Full" : "Half"),
+		       ((flow_rx && flow_tx) ? "RX/TX" :
+			(flow_rx ? "RX" : (flow_tx ? "TX" : "None"))));
+	}
+}
+
+/**
+ * rnpgbe_watchdog_link_is_up - update netif_carrier status and
+ * print link up message
+ * @mucse: pointer to the device adapter structure
+ **/
+static void rnpgbe_watchdog_link_is_up(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+
+	/* only continue if link was previously down */
+	if (netif_carrier_ok(netdev))
+		return;
+	netif_carrier_on(netdev);
+	netif_tx_wake_all_queues(netdev);
+}
+
+/**
+ * rnpgbe_watchdog_link_is_down - update netif_carrier status and
+ * print link down message
+ * @mucse: pointer to the adapter structure
+ **/
+static void rnpgbe_watchdog_link_is_down(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+
+	mucse->link_up = false;
+	mucse->link_speed = 0;
+	/* only continue if link was up previously */
+	if (!netif_carrier_ok(netdev))
+		return;
+	e_info(drv, "NIC Link is Down\n");
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+}
+
+/**
+ * rnpgbe_watchdog_subtask - check and bring link up
+ * @mucse: pointer to the device adapter structure
+ **/
+static void rnpgbe_watchdog_subtask(struct mucse *mucse)
+{
+	/* if interface is down do nothing */
+	/* should do link status if in sriov */
+	if (test_bit(__MUCSE_DOWN, &mucse->state) ||
+	    test_bit(__MUCSE_RESETTING, &mucse->state))
+		return;
+
+	rnpgbe_watchdog_update_link(mucse);
+	if (mucse->link_up)
+		rnpgbe_watchdog_link_is_up(mucse);
+	else
+		rnpgbe_watchdog_link_is_down(mucse);
+}
+
 /**
  * rnpgbe_service_task - manages and runs subtasks
  * @work: pointer to work_struct containing our data
  **/
 static void rnpgbe_service_task(struct work_struct *work)
 {
+	struct mucse *mucse = container_of(work, struct mucse, service_task);
+
+	rnpgbe_watchdog_subtask(mucse);
+	rnpgbe_service_event_complete(mucse);
 }
 
 int rnpgbe_poll(struct napi_struct *napi, int budget)
@@ -255,7 +387,7 @@ static int rnpgbe_open(struct net_device *netdev)
 	int err;
 
 	/* disallow open during test */
-	if (test_bit(__MMUCSE_TESTING, &mucse->state))
+	if (test_bit(__MUCSE_TESTING, &mucse->state))
 		return -EBUSY;
 
 	netif_carrier_off(netdev);
@@ -271,6 +403,8 @@ static int rnpgbe_open(struct net_device *netdev)
 	if (err)
 		goto err_set_queues;
 	rnpgbe_up_complete(mucse);
+
+	return 0;
 err_req_irq:
 	rnpgbe_free_txrx(mucse);
 err_set_queues:
@@ -387,6 +521,8 @@ static irqreturn_t rnpgbe_msix_other(int irq, void *data)
 	struct mucse *mucse = (struct mucse *)data;
 
 	set_bit(__MUCSE_IN_IRQ, &mucse->state);
+	/* handle fw req and ack */
+	rnpgbe_fw_msg_handler(mucse);
 	clear_bit(__MUCSE_IN_IRQ, &mucse->state);
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index fbb154051313..666896de1f9f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -8,6 +8,7 @@
 #define MUCSE_ERR_MBX -100
 /* 14 words */
 #define MUCSE_VFMAILBOX_SIZE 14
+#define MUCSE_FW_MAILBOX_SIZE MUCSE_VFMAILBOX_SIZE
 /* ================ PF <--> VF mailbox ================ */
 #define SHARE_MEM_BYTES 64
 static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index fc6c0dbfff84..066bf450cf59 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -501,3 +501,150 @@ int mucse_mbx_ifup_down(struct mucse_hw *hw, int up)
 
 	return err;
 }
+
+static void rnpgbe_link_stat_mark(struct mucse_hw *hw, int up)
+{
+	u32 v;
+	struct mucse *mucse = (struct mucse *)hw->back;
+
+	v = hw_rd32(hw, DMA_DUMY);
+	v &= ~(0x0f000f11);
+	v |= 0xa0000000;
+	if (up) {
+		v |= BIT(0);
+		switch (hw->speed) {
+		case 10:
+			v |= (speed_10 << 8);
+			break;
+		case 100:
+			v |= (speed_100 << 8);
+			break;
+		case 1000:
+			v |= (speed_1000 << 8);
+			break;
+		case 10000:
+			v |= (speed_10000 << 8);
+			break;
+		case 25000:
+			v |= (speed_25000 << 8);
+			break;
+		case 40000:
+			v |= (speed_40000 << 8);
+			break;
+		}
+		v |= (hw->duplex << 4);
+		v |= (hw->fc.current_mode << 24);
+	} else {
+		v &= ~BIT(0);
+	}
+	/* we should update lldp_status */
+	if (hw->fw_version >= 0x00010500) {
+		if (mucse->priv_flags & M_PRIV_FLAG_LLDP)
+			v |= BIT(6);
+		else
+			v &= (~BIT(6));
+	}
+	hw_wr32(hw, DMA_DUMY, v);
+}
+
+static int rnpgbe_mbx_fw_reply_handler(struct mucse *adapter,
+				       struct mbx_fw_cmd_reply *reply)
+{
+	struct mbx_req_cookie *cookie;
+
+	cookie = reply->cookie;
+	if (!cookie || cookie->magic != COOKIE_MAGIC)
+		return -EIO;
+
+	if (cookie->priv_len > 0)
+		memcpy(cookie->priv, reply->data, cookie->priv_len);
+
+	cookie->done = 1;
+
+	if (reply->flags & FLAGS_ERR)
+		cookie->errcode = reply->error_code;
+	else
+		cookie->errcode = 0;
+	wake_up_interruptible(&cookie->wait);
+	return 0;
+}
+
+static int rnpgbe_mbx_fw_req_handler(struct mucse *mucse,
+				     struct mbx_fw_cmd_req *req)
+{
+	struct mucse_hw *hw = &mucse->hw;
+
+	switch (req->opcode) {
+	case LINK_STATUS_EVENT:
+		if (req->link_stat.lane_status)
+			hw->link = 1;
+		else
+			hw->link = 0;
+		if (hw->hw_type == rnpgbe_hw_n500 ||
+		    hw->hw_type == rnpgbe_hw_n210 ||
+		    hw->hw_type == rnpgbe_hw_n210L) {
+			/* fw_version more than 0.1.5.0 can up lldp_status */
+			if (hw->fw_version >= 0x00010500) {
+				if (req->link_stat.st[0].lldp_status)
+					mucse->priv_flags |= M_PRIV_FLAG_LLDP;
+				else
+					mucse->priv_flags &= (~M_PRIV_FLAG_LLDP);
+			}
+		}
+		if (req->link_stat.port_st_magic == SPEED_VALID_MAGIC) {
+			hw->speed = req->link_stat.st[0].speed;
+			hw->duplex = req->link_stat.st[0].duplex;
+			if (hw->hw_type == rnpgbe_hw_n500 ||
+			    hw->hw_type == rnpgbe_hw_n210 ||
+			    hw->hw_type == rnpgbe_hw_n210L) {
+				hw->fc.current_mode =
+					req->link_stat.st[0].pause;
+				hw->tp_mdx = req->link_stat.st[0].tp_mdx;
+			}
+		}
+		if (req->link_stat.lane_status)
+			rnpgbe_link_stat_mark(hw, 1);
+		else
+			rnpgbe_link_stat_mark(hw, 0);
+
+		mucse->flags |= M_FLAG_NEED_LINK_UPDATE;
+		break;
+	}
+	return 0;
+}
+
+static int rnpgbe_rcv_msg_from_fw(struct mucse *mucse)
+{
+	u32 msgbuf[MUCSE_FW_MAILBOX_SIZE];
+	struct mucse_hw *hw = &mucse->hw;
+	s32 retval;
+
+	retval = mucse_read_mbx(hw, msgbuf, MUCSE_FW_MAILBOX_SIZE, MBX_FW);
+	if (retval)
+		return retval;
+	/* this is a message we already processed, do nothing */
+	if (((unsigned short *)msgbuf)[0] & FLAGS_DD) {
+		return rnpgbe_mbx_fw_reply_handler(mucse,
+				(struct mbx_fw_cmd_reply *)msgbuf);
+	} else {
+		return rnpgbe_mbx_fw_req_handler(mucse,
+				(struct mbx_fw_cmd_req *)msgbuf);
+	}
+}
+
+static void rnpgbe_rcv_ack_from_fw(struct mucse *mucse)
+{
+	/* do-nothing */
+}
+
+int rnpgbe_fw_msg_handler(struct mucse *mucse)
+{
+	/* check fw-req */
+	if (!mucse_check_for_msg(&mucse->hw, MBX_FW))
+		rnpgbe_rcv_msg_from_fw(mucse);
+	/* process any acks */
+	if (!mucse_check_for_ack(&mucse->hw, MBX_FW))
+		rnpgbe_rcv_ack_from_fw(mucse);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index cd5a98acd983..2700eebf5873 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -647,4 +647,5 @@ int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			 u8 *mac_addr, int nr_lane);
 int mucse_mbx_link_event_enable(struct mucse_hw *hw, int enable);
 int mucse_mbx_ifup_down(struct mucse_hw *hw, int up);
+int rnpgbe_fw_msg_handler(struct mucse *mucse);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


