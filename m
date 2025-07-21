Return-Path: <netdev+bounces-208584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51871B0C35D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F3C7B2205
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DD2D5438;
	Mon, 21 Jul 2025 11:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D32C032C;
	Mon, 21 Jul 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097758; cv=none; b=bGplNkoAgjGW0FV7EfIHa7B2IEz27E6H+hewbYvdrm0/0bEN9Z2YJsi430a+opaeacCMNwCAphvJJqKEe36UUoaEHo52O+iAEqyV/4Dlj1PHTovI+TNNNQ7lIfe53VFTqZv9vZ649DdpO3++trBWvj9eQQMTRmkStEaPEhE6CQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097758; c=relaxed/simple;
	bh=NGkH8POWMCUvWCC9DCll509gIgZQUqK9dDOtfMu2Zbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnz6Y/ZQUD9YgrjvidT4jgekX77f2NZCcX9mFCXVMvNOUNL1qAidqHkvhdaquGHKrXYigUcdjaLBDCUgziqdcq9fUljzvld510fS/ZN5IaC87r65bPVfcDx0Tv4kb0WRSY6K+MN1A8OkhXL+kSIHml0PS+TdgoZXuQOCFByZkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097622tca2e3512
X-QQ-Originating-IP: eI9/Mm2GTAz7JMai5LpjBtPjDGhIZrqE87aX0mMU5RE=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13491831712532506601
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
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
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v2 12/15] net: rnpgbe: Add link up handler
Date: Mon, 21 Jul 2025 19:32:35 +0800
Message-Id: <20250721113238.18615-13-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
References: <20250721113238.18615-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NlEtBhRRrtWGOVUahyF4YvGewwCO2RmDbOMPYXn6g8MPfOq4XQgixhiQ
	P5M0aBeBq1ZWCNxPocSmvG6yMzjiiWpJIaR8NtLcFlvQvA/C4XVN+Tv7gfJVPN7oBe37K+J
	2Yh2/xGSq9Ep0FRB8+3Ztufv0HtWxLyyb8AvQK+QRKZYn1MJjyaf9d5olM8tFfvVWZNBVni
	Wa1/g1hM/SPNCt/j9aVS4zgBwTy8Iy0X9gG+tiuN3JH1AehI6JSv/sEFtzhQ4VlymNbbZEL
	fo6/lMStoCGgQverOJjAHnBm1v+vpQD2/IrCSj72hMPgCq5rkg1kQT/k8Ww64iJ55evXdYs
	ra6Fc3b+w9ZBSCbNLTCpADdg6Ow9dJMUB3TYMAM3TNseNAdwm32rRL5XdsZSSQ33N7E/5NZ
	pgQyzD8vGUWhib9lMaSkxx4XZqPbZVCP7sQy0qiZABz+2sg0VaamtBebWKQSWN6oHpX/OOU
	FieB5EMT7PopdJojYx/c4vakpS+LtDLg/nbyrm0vJ0zXyrE16rtheTMHOfvb6AalbPFaHN8
	/FPrvUCL+JZa7Mdb2YfDCZ/NkF3PAhadlLxoQTTYHORN6RmceIvH1wHlFHco71DJQBXIj2m
	LtXL0gAgYB4eeNNq2pxTBPSZKa0SfebqoZZLs1jGIR9WjWVpQY8f+9bm+EaprWvmPWR33pj
	YoErCLv6X0UX+hWqLPJ790szytEcEYO7pKaNpR6P97daMjRl2LHZBYinGukEe86xkaFX1su
	RJK/Okd7TMVuXAf/izRe1XEvSdChb2eaRAT6tCoKx2c6xcDGjJdwN6YKdFYwPwhCd7Rbgyf
	GAbFAN6UexKu4/dlwu3sTg4GlnBYBBMuZhlSx4wfmCD3eLaZTETTQDJ9miqtg2SmAZGVf9l
	078ETKaeoyb9fg7QFZebE+AHdWV6RwCKHm8o1X9nupk3x9SdczqvqbA77e6selH9J8glB6Q
	jvn7ZHeHBL17dt0r40/FROIBi5R8fh45gTLKhZ7+wz0vVEx6RrfOaFEryCTkSPKMsYnGFUb
	d2Yf/1OVk2WQKV2UOQUIlaEb0XPFU5b/krl3TtOFstudETjuGXiPsMIODaT1gay7tANBMjF
	O7DEE0U031L
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Initialize link status handler

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  53 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  26 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    |   7 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 139 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 187 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   7 +
 7 files changed, 420 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 624e0eec562a..b241740d9cc5 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -26,6 +26,15 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_unknow
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
@@ -121,6 +130,31 @@ struct mucse_mbx_operations {
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
@@ -186,6 +220,8 @@ struct mucse_hw_operations {
 	void (*set_irq_mode)(struct mucse_hw *hw, bool legacy);
 	void (*set_mbx_link_event)(struct mucse_hw *hw, int enable);
 	void (*set_mbx_ifup)(struct mucse_hw *hw, int enable);
+	void (*check_link)(struct mucse_hw *hw, u32 *speed, bool *link_up,
+			   bool *duplex);
 };
 
 enum {
@@ -224,6 +260,7 @@ struct mucse_hw {
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
 	struct mucse_mac_info mac;
+	struct mucse_fc_info fc;
 	struct mucse_mbx_info mbx;
 #define M_NET_FEATURE_SG BIT(0)
 #define M_NET_FEATURE_TX_CHECKSUM BIT(1)
@@ -254,6 +291,9 @@ struct mucse_hw {
 	u16 max_msix_vectors;
 	int nr_lane;
 	struct lldp_status lldp_status;
+	int speed;
+	u32 duplex;
+	u32 tp_mdx;
 	int link;
 	u8 addr[ETH_ALEN];
 	u8 perm_addr[ETH_ALEN];
@@ -261,6 +301,7 @@ struct mucse_hw {
 
 enum mucse_state_t {
 	__MUCSE_TESTING,
+	__MUCSE_RESETTING,
 	__MUCSE_DOWN,
 	__MUCSE_SERVICE_SCHED,
 	__MUCSE_PTP_TX_IN_PROGRESS,
@@ -544,6 +585,7 @@ struct mucse {
 	u32 priv_flags;
 #define M_PRIV_FLAG_TX_COALESCE BIT(25)
 #define M_PRIV_FLAG_RX_COALESCE BIT(26)
+#define M_PRIV_FLAG_LLDP BIT(27)
 	struct mucse_ring *tx_ring[MAX_TX_QUEUES] ____cacheline_aligned_in_smp;
 	int tx_ring_item_count;
 	int num_tx_queues;
@@ -562,6 +604,9 @@ struct mucse {
 	u16 rx_frames;
 	u16 tx_frames;
 	u16 tx_usecs;
+	bool link_up;
+	u32 link_speed;
+	bool duplex;
 	unsigned long state;
 	unsigned long link_check_timeout;
 	struct timer_list service_timer;
@@ -610,9 +655,17 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 #define M_PKT_TIMEOUT (30)
 #define M_RX_PKT_POLL_BUDGET (64)
 
+#define M_LINK_SPEED_UNKNOWN 0
+#define M_LINK_SPEED_10_FULL BIT(2)
+#define M_LINK_SPEED_100_FULL BIT(3)
+#define M_LINK_SPEED_1GB_FULL BIT(4)
+
+#define M_TRY_LINK_TIMEOUT (4 * HZ)
+
 #define m_rd_reg(reg) readl(reg)
 #define m_wr_reg(reg, val) writel((val), reg)
 #define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
+#define hw_rd32(hw, reg) m_rd_reg((hw)->hw_addr + (reg))
 #define dma_wr32(dma, reg, val) m_wr_reg((dma)->dma_base_addr + (reg), (val))
 #define dma_rd32(dma, reg) m_rd_reg((dma)->dma_base_addr + (reg))
 #define eth_wr32(eth, reg, val) m_wr_reg((eth)->eth_base_addr + (reg), (val))
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index b85d4d0e3dbc..16eebe59915e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -350,6 +350,31 @@ static void rnpgbe_set_mbx_ifup_hw_ops_n500(struct mucse_hw *hw,
 	mucse_mbx_ifup_down(hw, enable);
 }
 
+/**
+ * rnpgbe_check_link_hw_ops_n500 - Check link status from hw
+ * @hw: hw information structure
+ * @speed: store speed
+ * @link_up: store link status
+ * @duplex: store duplex status
+ **/
+static void rnpgbe_check_link_hw_ops_n500(struct mucse_hw *hw,
+					  u32 *speed,
+					  bool *link_up,
+					  bool *duplex)
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
@@ -361,6 +386,7 @@ static struct mucse_hw_operations hw_ops_n500 = {
 	.set_irq_mode = &rnpgbe_set_irq_mode_n500,
 	.set_mbx_link_event = &rnpgbe_set_mbx_link_event_hw_ops_n500,
 	.set_mbx_ifup = &rnpgbe_set_mbx_ifup_hw_ops_n500,
+	.check_link = &rnpgbe_check_link_hw_ops_n500,
 };
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 0686bfbf55bf..b646aba48348 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -6,6 +6,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_lib.h"
+#include "rnpgbe_mbx_fw.h"
 
 /**
  * rnpgbe_set_rss_queues - Allocate queues for RSS
@@ -1050,6 +1051,12 @@ static int rnpgbe_request_msix_irqs(struct mucse *mucse)
  **/
 static irqreturn_t rnpgbe_intr(int irq, void *data)
 {
+	struct mucse *mucse = (struct mucse *)data;
+
+	set_bit(__MUCSE_IN_IRQ, &mucse->state);
+	/* handle fw req and ack */
+	rnpgbe_fw_msg_handler(mucse);
+	clear_bit(__MUCSE_IN_IRQ, &mucse->state);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 27beb0e6e705..90b4858597c1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -76,12 +76,147 @@ static void rnpgbe_service_timer(struct timer_list *t)
 		rnpgbe_service_event_schedule(mucse);
 }
 
+/**
+ * rnpgbe_service_event_complete - Call when service_task end
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_service_event_complete(struct mucse *mucse)
+{
+	/* flush memory to make sure state is correct before next watchdog */
+	smp_mb__before_atomic();
+	clear_bit(__MUCSE_SERVICE_SCHED, &mucse->state);
+}
+
+/**
+ * rnpgbe_watchdog_update_link - update the link status
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_watchdog_update_link(struct mucse *mucse)
+{
+	bool flow_rx = true, flow_tx = true;
+	u32 link_speed = mucse->link_speed;
+	struct mucse_hw *hw = &mucse->hw;
+	bool link_up;
+	bool duplex;
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
+		duplex = true;
+	}
+
+	if (link_up || time_after(jiffies, (mucse->link_check_timeout +
+					    M_TRY_LINK_TIMEOUT))) {
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
+ * @mucse: pointer to the device private structure
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
+ * @mucse: pointer to the private structure
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
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_watchdog_subtask(struct mucse *mucse)
+{
+	/* if interface is down do nothing */
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
 
 /**
@@ -163,6 +298,8 @@ static int rnpgbe_open(struct net_device *netdev)
 	if (err)
 		goto err_set_queues;
 	rnpgbe_up_complete(mucse);
+
+	return 0;
 err_req_irq:
 	rnpgbe_free_txrx(mucse);
 err_set_queues:
@@ -311,6 +448,8 @@ static irqreturn_t rnpgbe_msix_other(int irq, void *data)
 	struct mucse *mucse = (struct mucse *)data;
 
 	set_bit(__MUCSE_IN_IRQ, &mucse->state);
+	/* handle fw req and ack */
+	rnpgbe_fw_msg_handler(mucse);
 	clear_bit(__MUCSE_IN_IRQ, &mucse->state);
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index 0b4183e53e61..0f554f3eff82 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -8,6 +8,7 @@
 
 /* 14 words */
 #define MUCSE_VFMAILBOX_SIZE 14
+#define MUCSE_FW_MAILBOX_SIZE MUCSE_VFMAILBOX_SIZE
 /* ================ PF <--> VF mailbox ================ */
 #define SHARE_MEM_BYTES 64
 static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 291cdfbd16f3..412d9d5da191 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -564,3 +564,190 @@ int mucse_mbx_ifup_down(struct mucse_hw *hw, int up)
 
 	return err;
 }
+
+/**
+ * rnpgbe_link_stat_mark - Mark driver link status in reg
+ * @hw: Pointer to the HW structure
+ * @up: true for link up, false for link down
+ *
+ * rnpgbe_link_stat_mark echo driver link status to hw by DMA_DUMY.
+ * Fw will echo true link status if mismatch it.
+ **/
+static void rnpgbe_link_stat_mark(struct mucse_hw *hw, int up)
+{
+	struct mucse *mucse = (struct mucse *)hw->back;
+	u32 v;
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
+/**
+ * rnpgbe_mbx_fw_reply_handler - handle fw reply
+ * @mucse: pointer to the device private structure
+ * @reply: pointer to reply data
+ *
+ * rnpgbe_mbx_fw_reply_handler handler fw reply, it copy reply data
+ * to cookie->priv if no err.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_mbx_fw_reply_handler(struct mucse *mucse,
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
+		cookie->errcode = -EIO;
+	else
+		cookie->errcode = 0;
+	wake_up_interruptible(&cookie->wait);
+	return 0;
+}
+
+/**
+ * rnpgbe_mbx_fw_req_handler - handle fw req
+ * @mucse: pointer to the device private structure
+ * @req: pointer to req data
+ *
+ * rnpgbe_mbx_fw_req_handler handler fw req, such as a link event req.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_mbx_fw_req_handler(struct mucse *mucse,
+				     struct mbx_fw_cmd_req *req)
+{
+	u32 magic = le32_to_cpu(req->link_stat.port_st_magic);
+	struct mucse_hw *hw = &mucse->hw;
+
+	switch (le16_to_cpu(req->opcode)) {
+	case LINK_STATUS_EVENT:
+		if (le16_to_cpu(req->link_stat.lane_status))
+			hw->link = 1;
+		else
+			hw->link = 0;
+		port_stat_update_host_endian(&req->link_stat.st[0]);
+		if (hw->hw_type == rnpgbe_hw_n500 ||
+		    hw->hw_type == rnpgbe_hw_n210 ||
+		    hw->hw_type == rnpgbe_hw_n210L) {
+			if (req->link_stat.st[0].v_host.lldp_status)
+				mucse->priv_flags |= M_PRIV_FLAG_LLDP;
+			else
+				mucse->priv_flags &= (~M_PRIV_FLAG_LLDP);
+		}
+		if (magic == SPEED_VALID_MAGIC) {
+			hw->speed = le16_to_cpu(req->link_stat.st[0].speed);
+			hw->duplex = req->link_stat.st[0].duplex;
+			if (hw->hw_type == rnpgbe_hw_n500 ||
+			    hw->hw_type == rnpgbe_hw_n210 ||
+			    hw->hw_type == rnpgbe_hw_n210L) {
+				hw->fc.current_mode =
+					req->link_stat.st[0].v_host.pause;
+				hw->tp_mdx = req->link_stat.st[0].v_host.tp_mdx;
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
+/**
+ * rnpgbe_rcv_msg_from_fw - Read msg from fw and handle it
+ * @mucse: pointer to the device private structure
+ *
+ * rnpgbe_rcv_msg_from_fw tries to read mbx from hw and check
+ * the mbx is req or reply.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_rcv_msg_from_fw(struct mucse *mucse)
+{
+	u32 msgbuf[MUCSE_FW_MAILBOX_SIZE];
+	struct mucse_hw *hw = &mucse->hw;
+	int retval;
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
+/**
+ * rnpgbe_fw_msg_handler - Irq handler for mbx irq
+ * @mucse: pointer to the device private structure
+ * @return: 0 always
+ **/
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
index 08f5e1950ae3..88c140832c5e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -232,6 +232,12 @@ struct port_stat {
 	};
 } __packed;
 
+static inline void port_stat_update_host_endian(struct port_stat *stat)
+{
+	u16 host_val = le16_to_cpu(stat->stat);
+
+	stat->v_host = *(typeof(stat->v_host) *)&host_val;
+}
 #define FLAGS_DD BIT(0) /* driver clear 0, FW must set 1 */
 /* driver clear 0, FW must set only if it reporting an error */
 #define FLAGS_ERR BIT(2)
@@ -685,4 +691,5 @@ int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			 u8 *mac_addr, int nr_lane);
 int mucse_mbx_link_event_enable(struct mucse_hw *hw, int enable);
 int mucse_mbx_ifup_down(struct mucse_hw *hw, int up);
+int rnpgbe_fw_msg_handler(struct mucse *mucse);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


