Return-Path: <netdev+bounces-208581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4742B0C33B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99240169602
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3762BD5AE;
	Mon, 21 Jul 2025 11:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC42BE7A6;
	Mon, 21 Jul 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097735; cv=none; b=mNsNSUiWqKNyuRcEYHL+tCKhuBT9Bs6FyIMIES2/rBOvq2TikpJgrQz/KqW8+9rvcPKj62CafJt1NTMaKJHOc0ry6j5XH4ln5EeW4/Z/b2vueUJ7lpk5I2o+4OP9xfEQY3U56K2w/bjf9mokDynNOjZ7e0ZXzFcn1dVvjAzLZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097735; c=relaxed/simple;
	bh=b5qAP1Ee2xD+lSRxIfzVZh4fnqkqqdJhNFBtnMPaN94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SM4Z2O6Z3yn9+DjpdcZrMEp2WJ8LK7lfXeoVD2Ll/C8svgXkfzOskB1E9jTdoINj3gdCSGaovOFkSQdFx/5zHSV5ysCjlRu+LzNkllf8IpGbGyxmyMmbjyG8VP7XCdlc7V66rAIAvRbkpP8p4xib4aY5u/zeEoFC9EkiPOPRPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097617t32dbf071
X-QQ-Originating-IP: ejkiecLOyq06LkPdQT1SKDLJ17cPJMC5XdIiJHeOoYw=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15052698701912929417
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
Subject: [PATCH v2 11/15] net: rnpgbe: Add setup hw ring-vector, true up/down hw
Date: Mon, 21 Jul 2025 19:32:34 +0800
Message-Id: <20250721113238.18615-12-dong100@mucse.com>
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
X-QQ-XMAILINFO: NPdR9eBl+Ml9kv5GkNMkZG/6nmalFjykbo4WMu2vkV+a8JM0Qijr3bgW
	LZZXgUuPdeP7rRGviyFMfblahoC9MEk48qBzKNXb7HUWwmb0YDH+Nr7UmpvTjx8KA5f6/bM
	qR+8F+f6dcdr7K9ky9N3hUqLSPLEZNhm2wVX+Pp+IM9SVc4SPWeJGQL5Gp5Q4tg29jHZtRX
	+Hr6B8WOwz75I73KTZYlByP4xOPlAFxeiVbiigdtyiPuBukhtGSur6v8F4yvEHOPnC8Ux5g
	x4Huvj2K8SMUMykQgfejezcn9N1wiL79GJ6KFhLRH7rD+yeTEnxI/WDW/0fvIHKz7gpDsVb
	egX47h8WIa9pwSv2TslaYf2R0ntSj1f0Eh9DjOFkbkVtARDj8AgiqGtGBGEvcNaE5zW3Fz5
	2cwMZFMIxpi7G4+5THQMdFfKsRPDfg74PY2a/qOkqM03T+nKtv3uzhIU0RULPIR2mncb0+7
	KFIFqjd4lUJuGKknX78XpHp0iLUHJH+ECfXl1iuzOpDSLcfRcO65kqptU0WLUHuXDHAU8AB
	XxAjeHxYA+PM23F+RSrDQXdxYDc6GhIXbWQiPqE+y4TR/ZeLry3t8PdMEqnPGJY8xfX5Wd8
	M7Y2o6ZSCB2NzvDE/ltohQxieE4CcqoCGBjkE8pk109IvqaiS+T9Hw4ki5hf6yXIql/AnZK
	yrt4KiupTSqgFM4uDss2QGUXYNagL894IQFD76qLQyuRXPX7DW3ptJUfz1DBGudMB3O6juj
	47JYGAbHarT7XmwuGQmAAMKJDsC9auiBBx+ZN3lWGtoWrNyiFCwmrM2K2sGptWIR9zlE2YT
	/k5S+L83kudQB0czBppoiSIB6Y0xxhjq5QQ/M8Opu5Xtuv6SjdfZCiq4IacbgY7KUOaXoYJ
	JExufVxn6r1NbQI70NfYI93dM9ZZqBcVC/0hG/l05JVMZl1CbGIKMrN0urXF7SDwqdzIDbL
	cjze4FYErP19mwN/0/tn85mxO71XuCWqdPMbdMurGX5pZRh12ibbfXGpuKUYP6A1qD6hoZt
	l17LrxlC9xASB3h/vV/bUdaE6rmtmb1AggA0TOiGq46/30YO23
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Initialize ring-vector setup up hw in open func.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  24 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 111 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  72 +++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  56 +++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 108 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  31 ++++-
 7 files changed, 404 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 23fb93157b98..624e0eec562a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -184,6 +184,8 @@ struct mucse_hw_operations {
 	void (*update_hw_info)(struct mucse_hw *hw);
 	void (*set_mac)(struct mucse_hw *hw, u8 *mac);
 	void (*set_irq_mode)(struct mucse_hw *hw, bool legacy);
+	void (*set_mbx_link_event)(struct mucse_hw *hw, int enable);
+	void (*set_mbx_ifup)(struct mucse_hw *hw, int enable);
 };
 
 enum {
@@ -528,6 +530,7 @@ struct mucse {
 	struct pci_dev *pdev;
 	struct devlink *dl;
 	struct mucse_hw hw;
+	u16 msg_enable;
 	/* board number */
 	u16 bd_number;
 	u16 tx_work_limit;
@@ -560,6 +563,7 @@ struct mucse {
 	u16 tx_frames;
 	u16 tx_usecs;
 	unsigned long state;
+	unsigned long link_check_timeout;
 	struct timer_list service_timer;
 	struct work_struct service_task;
 	char name[60];
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 266dc95c4ff2..b85d4d0e3dbc 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -328,6 +328,28 @@ static void rnpgbe_set_irq_mode_n500(struct mucse_hw *hw, bool legacy)
 	}
 }
 
+/**
+ * rnpgbe_set_mbx_link_event_hw_ops_n500 - Request link event status to hw
+ * @hw: hw information structure
+ * @enable: true for event on
+ **/
+static void rnpgbe_set_mbx_link_event_hw_ops_n500(struct mucse_hw *hw,
+						  int enable)
+{
+	mucse_mbx_link_event_enable(hw, enable);
+}
+
+/**
+ * rnpgbe_set_mbx_ifup_hw_ops_n500 - Request phy status to hw
+ * @hw: hw information structure
+ * @enable: true for phy up
+ **/
+static void rnpgbe_set_mbx_ifup_hw_ops_n500(struct mucse_hw *hw,
+					    int enable)
+{
+	mucse_mbx_ifup_down(hw, enable);
+}
+
 static struct mucse_hw_operations hw_ops_n500 = {
 	.init_hw = &rnpgbe_init_hw_ops_n500,
 	.reset_hw = &rnpgbe_reset_hw_ops_n500,
@@ -337,6 +359,8 @@ static struct mucse_hw_operations hw_ops_n500 = {
 	.set_mac = &rnpgbe_set_mac_hw_ops_n500,
 	.update_hw_info = &rnpgbe_update_hw_info_hw_ops_n500,
 	.set_irq_mode = &rnpgbe_set_irq_mode_n500,
+	.set_mbx_link_event = &rnpgbe_set_mbx_link_event_hw_ops_n500,
+	.set_mbx_ifup = &rnpgbe_set_mbx_ifup_hw_ops_n500,
 };
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 2ba1f5f5aa6c..0686bfbf55bf 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -1133,3 +1133,114 @@ void rnpgbe_free_irq(struct mucse *mucse)
 		mucse->hw.mbx.irq_enabled = false;
 	}
 }
+
+/**
+ * rnpgbe_napi_enable_all - enable all napi
+ * @mucse: pointer to private structure
+ *
+ * Enable all napi for this net.
+ **/
+void rnpgbe_napi_enable_all(struct mucse *mucse)
+{
+	int q_idx;
+
+	for (q_idx = 0; q_idx < mucse->num_q_vectors; q_idx++)
+		napi_enable(&mucse->q_vector[q_idx]->napi);
+}
+
+/**
+ * rnpgbe_napi_disable_all - disable all napi
+ * @mucse: pointer to private structure
+ *
+ * Disable all napi for this net.
+ **/
+void rnpgbe_napi_disable_all(struct mucse *mucse)
+{
+	int q_idx;
+
+	for (q_idx = 0; q_idx < mucse->num_q_vectors; q_idx++)
+		napi_disable(&mucse->q_vector[q_idx]->napi);
+}
+
+/**
+ * rnpgbe_set_ring_vector - set the ring_vector registers,
+ * mapping interrupt causes to vectors
+ * @mucse: pointer to private structure
+ * @queue: queue to map the corresponding interrupt to
+ * @msix_vector: the vector to map to the corresponding queue
+ *
+ */
+static void rnpgbe_set_ring_vector(struct mucse *mucse,
+				   u8 queue, u8 msix_vector)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 data = 0;
+
+	data = hw->pfvfnum << 24;
+	data |= (msix_vector << 8);
+	data |= (msix_vector << 0);
+	m_wr_reg(hw->ring_msix_base + RING_VECTOR(queue), data);
+}
+
+/**
+ * rnpgbe_configure_msix - Configure MSI-X hardware
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_configure_msix sets up the hardware to properly generate MSI-X
+ * interrupts.
+ **/
+void rnpgbe_configure_msix(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_q_vector *q_vector;
+	int i;
+
+	/* configure ring-msix Registers table */
+	for (i = 0; i < mucse->num_q_vectors; i++) {
+		struct mucse_ring *ring;
+
+		q_vector = mucse->q_vector[i];
+		mucse_for_each_ring(ring, q_vector->rx) {
+			rnpgbe_set_ring_vector(mucse, ring->rnpgbe_queue_idx,
+					       q_vector->v_idx);
+		}
+	}
+	/* n500 should mask other */
+	if (hw->hw_type == rnpgbe_hw_n500 ||
+	    hw->hw_type == rnpgbe_hw_n210 ||
+	    hw->hw_type == rnpgbe_hw_n210L) {
+		/*
+		 *  8  lpi | PMT
+		 *  9  BMC_RX_IRQ |
+		 *  10 PHY_IRQ | LPI_IRQ
+		 *  11 BMC_TX_IRQ |
+		 *  may DMAR error if set pf to vm
+		 */
+#define OTHER_VECTOR_START (8)
+#define OTHER_VECTOR_STOP (11)
+#define MSIX_UNUSED (0x0f0f)
+		for (i = OTHER_VECTOR_START; i <= OTHER_VECTOR_STOP; i++) {
+			if (hw->feature_flags & M_HW_SOFT_MASK_OTHER_IRQ) {
+				m_wr_reg(hw->ring_msix_base +
+					 RING_VECTOR(i),
+					 MSIX_UNUSED);
+			} else {
+				m_wr_reg(hw->ring_msix_base +
+					 RING_VECTOR(i), 0);
+			}
+		}
+		if (hw->feature_flags & M_HW_FEATURE_EEE) {
+#define LPI_IRQ (8)
+			/* only open lpi irq */
+			if (hw->feature_flags & M_HW_SOFT_MASK_OTHER_IRQ) {
+				m_wr_reg(hw->ring_msix_base +
+					 RING_VECTOR(LPI_IRQ),
+					 0x000f);
+			} else {
+				m_wr_reg(hw->ring_msix_base +
+					 RING_VECTOR(LPI_IRQ),
+					 0x0000);
+			}
+		}
+	}
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 24859649199f..bdb8a393dad8 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -7,6 +7,7 @@
 #include "rnpgbe.h"
 
 #define RING_OFFSET(n) (0x100 * (n))
+#define DMA_DUMY (0xc)
 #define DMA_RX_START (0x10)
 #define DMA_RX_READY (0x14)
 #define DMA_TX_START (0x18)
@@ -14,6 +15,8 @@
 #define DMA_INT_MASK (0x24)
 #define TX_INT_MASK (0x02)
 #define RX_INT_MASK (0x01)
+#define DMA_INT_TRIG (0x2c)
+#define INT_VALID (0x3 << 16)
 #define DMA_INT_CLR (0x28)
 #define DMA_INT_STAT (0x20)
 #define DMA_REG_RX_DESC_BUF_BASE_ADDR_HI (0x30)
@@ -41,11 +44,75 @@
 #define TX_DEFAULT_BURST (8)
 #define RX_DEFAULT_LINE (32)
 #define RX_DEFAULT_BURST (16)
-
+#define RING_VECTOR(n) (0x04 * (n))
 #define mucse_for_each_ring(pos, head)\
 	for (typeof((head).ring) __pos = (head).ring;\
 		__pos ? ({ pos = __pos; 1; }) : 0;\
 		__pos = __pos->next)
+#define e_info(msglvl, format, arg...)  \
+	netif_info(mucse, msglvl, mucse->netdev, format, ##arg)
+
+enum link_event_mask {
+	EVT_LINK_UP = 1,
+	EVT_NO_MEDIA = 2,
+	EVT_LINK_FAULT = 3,
+	EVT_PHY_TEMP_ALARM = 4,
+	EVT_EXCESSIVE_ERRORS = 5,
+	EVT_SIGNAL_DETECT = 6,
+	EVT_AUTO_NEGOTIATION_DONE = 7,
+	EVT_MODULE_QUALIFICATION_FAILD = 8,
+	EVT_PORT_TX_SUSPEND = 9,
+};
+
+static inline void rnpgbe_irq_enable_queues(struct mucse *mucse,
+					    struct mucse_q_vector *q_vector)
+{
+	struct mucse_ring *ring;
+
+	mucse_for_each_ring(ring, q_vector->rx) {
+		m_wr_reg(ring->dma_int_mask, ~(RX_INT_MASK | TX_INT_MASK));
+		ring_wr32(ring, DMA_INT_TRIG, INT_VALID | TX_INT_MASK |
+			  RX_INT_MASK);
+	}
+}
+
+static inline void rnpgbe_irq_enable(struct mucse *mucse)
+{
+	int i;
+
+	for (i = 0; i < mucse->num_q_vectors; i++)
+		rnpgbe_irq_enable_queues(mucse, mucse->q_vector[i]);
+}
+
+static inline void rnpgbe_irq_disable_queues(struct mucse_q_vector *q_vector)
+{
+	struct mucse_ring *ring;
+
+	mucse_for_each_ring(ring, q_vector->tx) {
+		ring_wr32(ring, DMA_INT_TRIG,
+			  (0x3 << 16) | (~(TX_INT_MASK | RX_INT_MASK)));
+		m_wr_reg(ring->dma_int_mask, (RX_INT_MASK | TX_INT_MASK));
+	}
+}
+
+/**
+ * rnpgbe_irq_disable - Mask off interrupt generation on the NIC
+ * @mucse: pointer to private structure
+ **/
+static inline void rnpgbe_irq_disable(struct mucse *mucse)
+{
+	int i, j;
+
+	for (i = 0; i < mucse->num_q_vectors; i++) {
+		rnpgbe_irq_disable_queues(mucse->q_vector[i]);
+		j = i + mucse->q_vector_off;
+
+		if (mucse->flags & M_FLAG_MSIX_ENABLED)
+			synchronize_irq(mucse->msix_entries[j].vector);
+		else
+			synchronize_irq(mucse->pdev->irq);
+	}
+}
 
 int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
@@ -56,5 +123,8 @@ void rnpgbe_disable_rx_queue(struct mucse_ring *ring);
 void rnpgbe_configure_rx(struct mucse *mucse);
 int rnpgbe_request_irq(struct mucse *mucse);
 void rnpgbe_free_irq(struct mucse *mucse);
+void rnpgbe_napi_enable_all(struct mucse *mucse);
+void rnpgbe_napi_disable_all(struct mucse *mucse);
+void rnpgbe_configure_msix(struct mucse *mucse);
 
 #endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index dc0990daf8b8..27beb0e6e705 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -100,6 +100,38 @@ static void rnpgbe_configure(struct mucse *mucse)
 	rnpgbe_configure_rx(mucse);
 }
 
+/**
+ * rnpgbe_up_complete - Final step for port up
+ * @mucse: pointer to private structure
+ **/
+static void rnpgbe_up_complete(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	int i;
+
+	rnpgbe_configure_msix(mucse);
+	/* we need this */
+	smp_mb__before_atomic();
+	clear_bit(__MUCSE_DOWN, &mucse->state);
+	rnpgbe_napi_enable_all(mucse);
+	/* clear any pending interrupts*/
+	rnpgbe_irq_enable(mucse);
+	/* enable transmits */
+	netif_tx_start_all_queues(mucse->netdev);
+	/* enable rx transmit */
+	for (i = 0; i < mucse->num_rx_queues; i++)
+		ring_wr32(mucse->rx_ring[i], DMA_RX_START, 1);
+
+	/* bring the link up in the watchdog */
+	mucse->flags |= M_FLAG_NEED_LINK_UPDATE;
+	mucse->link_check_timeout = jiffies;
+	mod_timer(&mucse->service_timer, jiffies);
+
+	hw->link = 0;
+	hw->ops.set_mbx_link_event(hw, 1);
+	hw->ops.set_mbx_ifup(hw, 1);
+}
+
 /**
  * rnpgbe_open - Called when a network interface is made active
  * @netdev: network interface device structure
@@ -130,6 +162,7 @@ static int rnpgbe_open(struct net_device *netdev)
 	err = netif_set_real_num_rx_queues(netdev, mucse->num_rx_queues);
 	if (err)
 		goto err_set_queues;
+	rnpgbe_up_complete(mucse);
 err_req_irq:
 	rnpgbe_free_txrx(mucse);
 err_set_queues:
@@ -137,6 +170,28 @@ static int rnpgbe_open(struct net_device *netdev)
 	return err;
 }
 
+/**
+ * rnpgbe_down - Down a network interface
+ * @mucse: pointer to private structure
+ **/
+static void rnpgbe_down(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	struct net_device *netdev = mucse->netdev;
+
+	set_bit(__MUCSE_DOWN, &mucse->state);
+	hw->ops.set_mbx_link_event(hw, 0);
+	hw->ops.set_mbx_ifup(hw, 0);
+	if (netif_carrier_ok(netdev))
+		e_info(drv, "NIC Link is Down\n");
+	netif_tx_stop_all_queues(netdev);
+	netif_carrier_off(netdev);
+	rnpgbe_irq_disable(mucse);
+	netif_tx_disable(netdev);
+	rnpgbe_napi_disable_all(mucse);
+	mucse->flags &= ~M_FLAG_NEED_LINK_UPDATE;
+}
+
 /**
  * rnpgbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -150,6 +205,7 @@ static int rnpgbe_close(struct net_device *netdev)
 {
 	struct mucse *mucse = netdev_priv(netdev);
 
+	rnpgbe_down(mucse);
 	rnpgbe_free_irq(mucse);
 	rnpgbe_free_txrx(mucse);
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 37ef75121898..291cdfbd16f3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -4,6 +4,7 @@
 #include <linux/pci.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_lib.h"
 #include "rnpgbe_mbx_fw.h"
 
 /**
@@ -221,6 +222,45 @@ static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
 	return err;
 }
 
+/**
+ * mucse_mbx_write_posted_locked - Posts a mbx req to firmware and
+ * polling until hw has read out.
+ * @hw: Pointer to the HW structure
+ * @req: Pointer to the cmd req structure
+ *
+ * mucse_mbx_write_posted_locked posts a mbx req to firmware and
+ * polling until hw has read out.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_mbx_write_posted_locked(struct mucse_hw *hw,
+					 struct mbx_fw_cmd_req *req)
+{
+	int len = le32_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
+	int retry = 3;
+	int err = 0;
+
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+try_again:
+	retry--;
+	if (retry < 0) {
+		mutex_unlock(&hw->mbx.lock);
+		return -EIO;
+	}
+
+	err = hw->mbx.ops.write_posted(hw, (u32 *)req,
+				       L_WD(len),
+				       MBX_FW);
+	if (err)
+		goto try_again;
+
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
 /**
  * rnpgbe_mbx_lldp_get - Get lldp status from hw
  * @hw: Pointer to the HW structure
@@ -456,3 +496,71 @@ int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 out:
 	return err;
 }
+
+/**
+ * mucse_mbx_link_event_enable - Echo link event status to hw
+ * @hw: Pointer to the HW structure
+ * @enable: true for event on, false for event off
+ *
+ * mucse_mbx_link_event_enable echo driver link event status to hw.
+ * The status is used to echo link status change to driver.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_link_event_enable(struct mucse_hw *hw, int enable)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+
+	if (enable)
+		hw_wr32(hw, DMA_DUMY, 0xa0000000);
+
+	build_link_set_event_mask(&req, BIT(EVT_LINK_UP),
+				  (enable & 1) << EVT_LINK_UP, &req);
+
+	err = mucse_mbx_write_posted_locked(hw, &req);
+	if (!enable)
+		hw_wr32(hw, DMA_DUMY, 0);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_ifup_down - Echo phy up/down status to hw
+ * @hw: Pointer to the HW structure
+ * @up: true for phy up, false for phy down
+ *
+ * mucse_mbx_ifup_down echo driver phy status to hw.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_ifup_down(struct mucse_hw *hw, int up)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int err;
+	int len;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+
+	build_ifup_down(&req, hw->nr_lane, up);
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+	len = le32_to_cpu(req.datalen) + MBX_REQ_HDR_LEN;
+	err = hw->mbx.ops.write_posted(hw,
+				       (u32 *)&req,
+				       L_WD(len),
+				       MBX_FW);
+
+	mutex_unlock(&hw->mbx.lock);
+	if (up)
+		hw_wr32(hw, DMA_DUMY, 0xa0000000);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index 65a4f74c7090..08f5e1950ae3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -647,6 +647,34 @@ static inline void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
 	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
 }
 
+static inline void build_link_set_event_mask(struct mbx_fw_cmd_req *req,
+					     unsigned short event_mask,
+					     unsigned short enable,
+					     void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le32(SET_EVENT_MASK);
+	req->datalen = cpu_to_le32(sizeof(req->stat_event_mask));
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->stat_event_mask.event_mask = cpu_to_le16(event_mask);
+	req->stat_event_mask.enable_stat = cpu_to_le16(enable);
+}
+
+static inline void build_ifup_down(struct mbx_fw_cmd_req *req,
+				   unsigned int nr_lane, int up)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le32(IFUP_DOWN);
+	req->datalen = cpu_to_le32(sizeof(req->ifup));
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifup.lane = cpu_to_le32(nr_lane);
+	req->ifup.up = cpu_to_le32(up);
+}
+
 int mucse_mbx_get_capability(struct mucse_hw *hw);
 int rnpgbe_mbx_lldp_get(struct mucse_hw *hw);
 int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status);
@@ -655,5 +683,6 @@ int mucse_mbx_ifforce_control_mac(struct mucse_hw *hw, int status);
 int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
 int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			 u8 *mac_addr, int nr_lane);
-
+int mucse_mbx_link_event_enable(struct mucse_hw *hw, int enable);
+int mucse_mbx_ifup_down(struct mucse_hw *hw, int up);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


