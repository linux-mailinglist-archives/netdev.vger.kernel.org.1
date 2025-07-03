Return-Path: <netdev+bounces-203583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BE8AF6785
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483FB7AAF43
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0C227581;
	Thu,  3 Jul 2025 01:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC47226533;
	Thu,  3 Jul 2025 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507518; cv=none; b=o4/pxWqd/MuHMFQsoZNnNW2cmYwN6C7h9QSKXry6xhCptYWWvaESni/HeOrMya0TML0oG6I4/r/P8cG6iD0zePYo3+MNqyInK/Ei2hKtwqSlIi+zLiyZ3Ia1oMkbWjTWY+X0ZRgq3DtOZffe2r19KCKtnbZk0BTz9f7HNAuTLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507518; c=relaxed/simple;
	bh=965q5vXFtWuP2DXkHm05coRtEPgFhuYFgYRgzq8yeAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQkRVVdX73dPHdMhZoWXDIUOp+LRh5SnZdKOV0I8yMa+So90kJ/Jkmf8EiiyZB+pS0iTwxUdusaJwoxkNfuabH6Q9ALIzdEUgLJ1xIRVpcI3TSnMidsG0qrJBWvbGiPdDhedoLqlw6JfX4f9e/CP7jADi7jfupC7isJW8Qyb9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507399t22dfacec
X-QQ-Originating-IP: 0XKdggV4wgrunhABTiF4S3HYclyofwQskYnEzqtSOEc=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12444229288644496651
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
Subject: [PATCH 11/15] net: rnpgbe: Add setup hw ring-vector, true up/down hw
Date: Thu,  3 Jul 2025 09:48:55 +0800
Message-Id: <20250703014859.210110-12-dong100@mucse.com>
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
X-QQ-XMAILINFO: NEuxXjgkfD8wo+5BQvI+TBpQBwcHyDasOd6by/PRaSeOfiGpafpBq5F+
	f0yR/NUgWXz+ToOEFnIZ9Xhd2NCi5BjL7DBGbQKl1T1x+W994tYwV/1a+0nbRvEVRkt2t0u
	OayYWLteLilElpf+nmh/DCXig/8IzSIWYhGZncIaQo/5AOpLMiNJHcf5P7r4X7J0y826lj6
	8yzH3etPADkVhNZPRP5nELSwWk3Sk567ZilLAtG8CzifLjkpONmJ5KtL97zYHR55xsyGx9q
	yoCr4dmhDFx8hz5QTIU9U1UYl05RlV4/JGt0X7+r12T8zD/N4MpkTQfNtktdLmXdY9opwJ6
	bl3xRG+2tw/PIWoC4zpGNtaP2C7QbC13otYCBZ3yeRqsKPRKW1mtVFqFlosjQ0BRJaI3rTH
	5IROd3Cmt2mNvrgXHjTKkawB9r22vm+CRugRzYUR9sOfGu388nRB2FUFFLFGmKqxK7xYDSw
	NsCjl5t/G5GGYxIZJoEY1q2mnxWNPdeIS6oulNQZP2TNFAc5dJc0vzsVkld/xZ52w1Sopaa
	+Uzrj2mlHm/Aan/XljNsZonmEHvgX79/qdLAXUCgvoSBC6ejqfuNCGSm52rYXceIbWaSDh8
	73HqF18zdHJ+EA+eXPRbFBerwOneNocEyvsAm/KfI/FfgfY/4vHTPyVCzw7KXRqPC3GpiBl
	Iz+rwH5QyAnJISpeQySkqhXkVD4azt8lkiYJzEwspsa2ZngKVIuNCSCrB4Q2jhVaxZ1Qfee
	I+bOZqA9rG6DrvXaaS0JM//+39veh1ZcSI9PSckbGMLJJSFXhUaJretIqsz+KQczMoI6ikL
	8aoS6ZFfgVpIg4sXUM5dA34crSsN6IyfHW32jv4k2x1ZnnmV/KplHVdPXv8jsUIE1JrNaxh
	eSk0CizI3PnTx1HRz3UNoh8sbDfEeFvOWNIiMnp9bbbN8hhjWbgsaJ+cg0SL17IzEXTkmbm
	+lQJvcqcj3FMLKV+1K/ZbdnvBAedwE3mdy2YyZOqlMJwgozVmf6vex1bOZAiHmZex+ZjBmD
	tbKzjzGWJ1m7Kh0aVaKW9ZDmLS+eTWZfsXlKwvefqB8Bsnb3S8la/NF2RD+Dk=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Initialize ring-vector setup up hw in open func.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  14 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 113 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  72 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  56 +++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  90 ++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  31 ++++-
 7 files changed, 379 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index d4e150c14582..c049952f41e8 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -183,6 +183,8 @@ struct mucse_hw_operations {
 	void (*update_hw_info)(struct mucse_hw *hw);
 	void (*set_mac)(struct mucse_hw *hw, u8 *mac);
 	void (*set_irq_mode)(struct mucse_hw *hw, bool legacy);
+	void (*set_mbx_link_event)(struct mucse_hw *hw, int enable);
+	void (*set_mbx_ifup)(struct mucse_hw *hw, int enable);
 };
 
 enum {
@@ -531,6 +533,7 @@ struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
+	u16 msg_enable;
 	/* board number */
 	u16 bd_number;
 	u16 tx_work_limit;
@@ -563,6 +566,7 @@ struct mucse {
 	u16 tx_frames;
 	u16 tx_usecs;
 	unsigned long state;
+	unsigned long link_check_timeout;
 	struct timer_list service_timer;
 	struct work_struct service_task;
 	char name[60];
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 5ad287e398a7..7cc9134952bf 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -288,6 +288,18 @@ static void rnpgbe_set_irq_mode_n500(struct mucse_hw *hw, bool legacy)
 	}
 }
 
+static void rnpgbe_set_mbx_link_event_hw_ops_n500(struct mucse_hw *hw,
+						  int enable)
+{
+	mucse_mbx_link_event_enable(hw, enable);
+}
+
+static void rnpgbe_set_mbx_ifup_hw_ops_n500(struct mucse_hw *hw,
+					    int enable)
+{
+	mucse_mbx_ifup_down(hw, enable);
+}
+
 static struct mucse_hw_operations hw_ops_n500 = {
 	.init_hw = &rnpgbe_init_hw_ops_n500,
 	.reset_hw = &rnpgbe_reset_hw_ops_n500,
@@ -297,6 +309,8 @@ static struct mucse_hw_operations hw_ops_n500 = {
 	.set_mac = &rnpgbe_set_mac_hw_ops_n500,
 	.update_hw_info = &rnpgbe_update_hw_info_hw_ops_n500,
 	.set_irq_mode = &rnpgbe_set_irq_mode_n500,
+	.set_mbx_link_event = &rnpgbe_set_mbx_link_event_hw_ops_n500,
+	.set_mbx_ifup = &rnpgbe_set_mbx_ifup_hw_ops_n500,
 };
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 26fdac7d52a9..fec084e20513 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -1125,3 +1125,116 @@ void rnpgbe_free_irq(struct mucse *mucse)
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
+ * @mucse: pointer to adapter struct
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
+	struct mucse_q_vector *q_vector;
+	int i;
+	struct mucse_hw *hw = &mucse->hw;
+
+	/*
+	 * configure ring-msix Registers table
+	 */
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
index 818bd0cabe0c..65bd97c26eaf 100644
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
@@ -42,9 +45,75 @@
 #define RX_DEFAULT_LINE (32)
 #define RX_DEFAULT_BURST (16)
 
+#define RING_VECTOR(n) (0x04 * (n))
 #define mucse_for_each_ring(pos, head)  \
 	for (pos = (head).ring; pos; pos = pos->next)
 
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
+ * @adapter: board private structure
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
+
 int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
 int rnpgbe_setup_txrx(struct mucse *mucse);
@@ -54,5 +123,8 @@ void rnpgbe_disable_rx_queue(struct mucse_ring *ring);
 void rnpgbe_configure_rx(struct mucse *mucse);
 int rnpgbe_request_irq(struct mucse *mucse);
 void rnpgbe_free_irq(struct mucse *mucse);
+void rnpgbe_napi_enable_all(struct mucse *mucse);
+void rnpgbe_napi_disable_all(struct mucse *mucse);
+void rnpgbe_configure_msix(struct mucse *mucse);
 
 #endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 82acf45ad901..01cff0a780ff 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -47,6 +47,11 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
+static int debug = -1;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
+
 static struct workqueue_struct *rnpgbe_wq;
 
 void rnpgbe_service_event_schedule(struct mucse *mucse)
@@ -205,6 +210,36 @@ static void rnpgbe_configure(struct mucse *mucse)
 	rnpgbe_configure_rx(mucse);
 }
 
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
+	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
+	/* maybe differ in n500 */
+	hw->link = 0;
+	hw->ops.set_mbx_link_event(hw, 1);
+	hw->ops.set_mbx_ifup(hw, 1);
+}
+
 /**
  * rnpgbe_open - Called when a network interface is made active
  * @netdev: network interface device structure
@@ -235,6 +270,7 @@ static int rnpgbe_open(struct net_device *netdev)
 	err = netif_set_real_num_rx_queues(netdev, mucse->num_rx_queues);
 	if (err)
 		goto err_set_queues;
+	rnpgbe_up_complete(mucse);
 err_req_irq:
 	rnpgbe_free_txrx(mucse);
 err_set_queues:
@@ -242,6 +278,24 @@ static int rnpgbe_open(struct net_device *netdev)
 	return err;
 }
 
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
@@ -255,6 +309,7 @@ static int rnpgbe_close(struct net_device *netdev)
 {
 	struct mucse *mucse = netdev_priv(netdev);
 
+	rnpgbe_down(mucse);
 	rnpgbe_free_irq(mucse);
 	rnpgbe_free_txrx(mucse);
 
@@ -443,6 +498,7 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	hw->hw_addr = hw_addr;
 	hw->dma.dma_version = dma_version;
 	hw->driver_version = driver_version;
+	mucse->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 	hw->nr_lane = 0;
 	ii->get_invariants(hw);
 	hw->mbx.ops.init_params(hw);
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index f86fb81f4db4..fc6c0dbfff84 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -4,6 +4,7 @@
 #include <linux/pci.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_lib.h"
 #include "rnpgbe_mbx_fw.h"
 
 /**
@@ -215,6 +216,47 @@ static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
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
+ * Returns 0 on success, negative on failure
+ **/
+static int mucse_mbx_write_posted_locked(struct mucse_hw *hw,
+					 struct mbx_fw_cmd_req *req)
+{
+	int err = 0;
+	int retry = 3;
+
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+
+	if (mutex_lock_interruptible(&hw->mbx.lock))
+		return -EAGAIN;
+try_again:
+	retry--;
+	if (retry < 0) {
+		mutex_unlock(&hw->mbx.lock);
+		return -EIO;
+	}
+
+	err = hw->mbx.ops.write_posted(hw, (u32 *)req,
+				       L_WD(req->datalen + MBX_REQ_HDR_LEN),
+				       MBX_FW);
+	if (err)
+		goto try_again;
+
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
 int rnpgbe_mbx_lldp_get(struct mucse_hw *hw)
 {
 	int err;
@@ -411,3 +453,51 @@ int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 out:
 	return err;
 }
+
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
+int mucse_mbx_ifup_down(struct mucse_hw *hw, int up)
+{
+	int err;
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+
+	build_ifup_down(&req, hw->nr_lane, up);
+
+	if (mutex_lock_interruptible(&hw->mbx.lock))
+		return -EAGAIN;
+
+	err = hw->mbx.ops.write_posted(hw,
+				       (u32 *)&req,
+				       L_WD(req.datalen + MBX_REQ_HDR_LEN),
+				       MBX_FW);
+
+	mutex_unlock(&hw->mbx.lock);
+	if (up)
+		hw_wr32(hw, DMA_DUMY, 0xa0000000);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index babdfc1f56f1..cd5a98acd983 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -609,6 +609,34 @@ static inline void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
 	req->get_mac_addr.pfvf_num = pfvfnum;
 }
 
+static inline void build_link_set_event_mask(struct mbx_fw_cmd_req *req,
+					     unsigned short event_mask,
+					     unsigned short enable,
+					     void *cookie)
+{
+	req->flags = 0;
+	req->opcode = SET_EVENT_MASK;
+	req->datalen = sizeof(req->stat_event_mask);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->stat_event_mask.event_mask = event_mask;
+	req->stat_event_mask.enable_stat = enable;
+}
+
+static inline void build_ifup_down(struct mbx_fw_cmd_req *req,
+				   unsigned int nr_lane, int up)
+{
+	req->flags = 0;
+	req->opcode = IFUP_DOWN;
+	req->datalen = sizeof(req->ifup);
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifup.lane = nr_lane;
+	req->ifup.up = up;
+}
+
 int mucse_mbx_get_capability(struct mucse_hw *hw);
 int rnpgbe_mbx_lldp_get(struct mucse_hw *hw);
 int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status);
@@ -617,5 +645,6 @@ int mucse_mbx_ifforce_control_mac(struct mucse_hw *hw, int status);
 int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
 int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			 u8 *mac_addr, int nr_lane);
-
+int mucse_mbx_link_event_enable(struct mucse_hw *hw, int enable);
+int mucse_mbx_ifup_down(struct mucse_hw *hw, int up);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


