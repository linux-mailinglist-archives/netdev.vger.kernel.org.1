Return-Path: <netdev+bounces-285184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAs1DAFM/GmZNwAAu9opvQ
	(envelope-from <netdev+bounces-285184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:23:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952E4E4B41
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7E8303E487
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03576346FB0;
	Thu,  7 May 2026 08:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F3131F98C;
	Thu,  7 May 2026 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141884; cv=none; b=ZOuzGy2B4KfhLQpVLzvq9cNQB65e74FggmG8/8yFuY+vNeMmRF9d11roQVHSGvE4LPn6xnZbY335k8u0goNxj0MzW/AvV3EQW9Q8Ck8wCqOmmKl5HZSQP1sA++87+6k31CZEyMda6DlJquZqgGZRH6EmJe6lLyG5THnNGhh8E+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141884; c=relaxed/simple;
	bh=rnRzdajYYgELE/VC8J4riDgFXgvbim3fPaqACjlt6p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cY6PsYOkJh+XLz+kydLPdBdR+Xt8GkjbK2KlziK/lYT4YeZTH2vmkDcHJjvDlsJLid7bJX3HX2QOCKgsBmAkZnprReot2eU7RqQQVUiE4mxdZKP6Jxh1AP1Ccq3XQzSWMgS5WvYoj+th6GeBzTO1uYGSPG4BBExP4mLFRdMZV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1778141754tccc089f5
X-QQ-Originating-IP: KGKrH6iU1dCDahWRzLHfaq9ZOnoG+d4INv0GvP5+Ovs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 16:15:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18135606303494472943
EX-QQ-RecipientCnt: 12
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v3 1/4] net: rnpgbe: Add interrupt handling
Date: Thu,  7 May 2026 16:15:36 +0800
Message-Id: <20260507081539.171844-2-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260507081539.171844-1-dong100@mucse.com>
References: <20260507081539.171844-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NV9lVvsB36Op5BAGR0jMkp+JzYda3os9t1udq0t6aTpzqZ1zxoZ5hKTN
	p1eEb9gPCPjMQqqf3EcmpKgiT9tiyEukiETPYb3h5vK4S2pvgwe7J/qG5DbJlk3ONRn5Fbc
	ATTvm8+pr1BkTjnovZcdqJJ+LGOlqlymcCPlbixn4pkWp2oIFLdlpzym4kg+OO5tKRGjtO1
	6vNc9xf/rSOrfhWj5JlLt3NJG8JWkvd+Q4D5pvI3yK2bps07flXQ5kpCXjcFmHq4naAWho9
	xQbBA+xSK/WoU4NVfO6ZK+hmDm6c2Ooc5wLKaUyH9S/NWmtjZfp4hOwQt0ahSj80l/0R8Tk
	LMDDCCDZGUjmhGNFuWlgEU6F5WQlnBjz5vIWSnYJBflp5EuSmWi7D9cO00xL8rhaOIDjTEV
	ZbLc2Yj9jrE3+3OFa6lyUM6lKrggrRhrjcOALqBs6iZCwretkEd1jveO4dhkJJ+rzS2zJLF
	RosOnHi6b7wFsbYB+kUM9xR4/IMY8yjto1bZtHYnZi9XPdqHUeQG2IHXjQ8TC63lPu9NxqF
	IbH3CU7F6iYoLTcocDB8HFeeNYkLQZHT0+uxP5F2jv6sH1Za5LNxTJ5Sc0MQuwfPsVlvGSa
	k87imsGqTLaRYBLk/wCMhqzO4vGYDfAc48sEWg5Y5k7NF9LZpEY1O4xeMjVb4Wesl+nX5LB
	1wBFrsvTM/TJF/K93ylCpEQKN0rrC4k06AyhzT8ZzJ+wiPgoU2Zfd3QjgjYtcLTp4C9dOgY
	kgaGEElD1L92CfJ6oAvZc73AXmynKbgOSQZbkbCcNuzhNaseUyOZV0SnG04FI4/zXyZDqqg
	A3DyH9gTGRmT2N6GRJDAiLnJ7Hn8a1IhR+kP7gZHB1XsqDAoTU2AOnWB/UEAbaLOOwr8Il3
	3+vH3gFM4MIfISmod+qUQalRp1nuTw3cA79qQXZxtYAdV8x4J2/X5jUuuWy0TWm9LffldZ/
	33gVgI4D9YMqtF7MBrxld7GUajM6ATHl/hOD+G0hWr1DgqteP/voiMhyMxOq7wMzIZ4Cwpo
	E4uv8LZVFERZ0Bn0Gc4qn5lU42Jr6cl/cp10sbN23LttxVUscVdzLF2FnwJsM=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 8952E4E4B41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285184-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add comprehensive interrupt handling for the RNPGBE driver:
- Implement msi-x/msi interrupt configuration and management
- Create library functions for interrupt registration and cleanup

This infrastructure enables proper interrupt handling for the
RNPGBE driver.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  48 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   4 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 603 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  34 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  46 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |   8 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   1 +
 9 files changed, 746 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index de8bcb7772ab..17574cad392a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o\
 	       rnpgbe_chip.o\
 	       rnpgbe_mbx.o\
-	       rnpgbe_mbx_fw.o
+	       rnpgbe_mbx_fw.o\
+	       rnpgbe_lib.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 5b024f9f7e17..cbe60f168346 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,10 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/if.h>
+
+#include "rnpgbe_hw.h"
 
 enum rnpgbe_boards {
 	board_n500,
@@ -35,21 +39,63 @@ enum {
 
 struct mucse_hw {
 	void __iomem *hw_addr;
+	void __iomem *ring_msix_base;
 	struct pci_dev *pdev;
 	struct mucse_mbx_info mbx;
 	int port;
 	u8 pfvfnum;
 };
 
+struct mucse_ring {
+	struct mucse_ring *next;
+	struct mucse_q_vector *q_vector;
+	void __iomem *ring_addr;
+	void __iomem *irq_mask;
+	void __iomem *trig;
+	u8 queue_index;
+	/* hw ring idx */
+	u8 rnpgbe_queue_idx;
+} ____cacheline_internodealigned_in_smp;
+
+struct mucse_ring_container {
+	struct mucse_ring *ring;
+	u16 count;
+};
+
+struct mucse_q_vector {
+	struct mucse *mucse;
+	int v_idx;
+	struct mucse_ring_container rx, tx;
+	struct napi_struct napi;
+	char name[IFNAMSIZ + 18];
+	/* for dynamic allocation of rings associated with this q_vector */
+	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
+};
+
 struct mucse_stats {
 	u64 tx_dropped;
 };
 
+#define MAX_Q_VECTORS 8
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
 	struct mucse_stats stats;
+#define M_FLAG_MSI_EN              BIT(0)
+#define M_FLAG_MSIX_SINGLE_EN      BIT(1)
+#define M_FLAG_MSIX_EN             BIT(2)
+	u32 flags;
+	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
+		____cacheline_aligned_in_smp;
+	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
+		____cacheline_aligned_in_smp;
+	struct mucse_q_vector *q_vector[MAX_Q_VECTORS];
+	int num_tx_queues;
+	int num_q_vectors;
+	int num_rx_queues;
+	char mbx_name[32];
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
@@ -68,4 +114,6 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 
 #define mucse_hw_wr32(hw, reg, val) \
 	writel((val), (hw)->hw_addr + (reg))
+#define mucse_hw_rd32(hw, reg) \
+	readl((hw)->hw_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index ebc7b3750157..921cc325a991 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -89,6 +89,8 @@ static void rnpgbe_init_n500(struct mucse_hw *hw)
 {
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	hw->ring_msix_base = hw->hw_addr + MUCSE_N500_RING_MSIX_BASE;
+
 	mbx->fwpf_ctrl_base = MUCSE_N500_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N500_FWPF_SHM_BASE;
 }
@@ -104,6 +106,8 @@ static void rnpgbe_init_n210(struct mucse_hw *hw)
 {
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	hw->ring_msix_base = hw->hw_addr + MUCSE_N210_RING_MSIX_BASE;
+
 	mbx->fwpf_ctrl_base = MUCSE_N210_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N210_FWPF_SHM_BASE;
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index e77e6bc3d3e3..0dce78e4a91b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -6,10 +6,12 @@
 
 #define MUCSE_N500_FWPF_CTRL_BASE      0x28b00
 #define MUCSE_N500_FWPF_SHM_BASE       0x2d000
+#define MUCSE_N500_RING_MSIX_BASE      0x28700
 #define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
 #define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
 #define MUCSE_N210_FWPF_CTRL_BASE      0x29400
 #define MUCSE_N210_FWPF_SHM_BASE       0x2d900
+#define MUCSE_N210_RING_MSIX_BASE      0x29000
 
 #define RNPGBE_DMA_AXI_EN              0x0010
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
new file mode 100644
index 000000000000..329c8ea0dcbe
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+
+#include "rnpgbe_lib.h"
+#include "rnpgbe.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * rnpgbe_msix_other - Other irq handler
+ * @irq: irq num
+ * @data: private data
+ *
+ * @return: IRQ_HANDLED
+ **/
+static irqreturn_t rnpgbe_msix_other(int irq, void *data)
+{
+	struct mucse *mucse = (struct mucse *)data;
+
+	mucse_fw_irq_handler(&mucse->hw);
+
+	return IRQ_HANDLED;
+}
+
+static void rnpgbe_irq_disable_queues(struct mucse_q_vector *q_vector)
+{
+	struct mucse_ring *ring;
+
+	/* tx/rx use one register, different bit */
+	mucse_for_each_ring(ring, q_vector->tx) {
+		writel(INT_VALID, ring->trig);
+		writel((RX_INT_MASK | TX_INT_MASK), ring->irq_mask);
+	}
+}
+
+static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
+{
+	struct mucse_ring *ring;
+
+	/* tx/rx use one register, different bit */
+	mucse_for_each_ring(ring, q_vector->tx) {
+		writel(0, ring->irq_mask);
+		writel(INT_VALID | TX_INT_MASK | RX_INT_MASK, ring->trig);
+	}
+}
+
+/**
+ * rnpgbe_poll - NAPI Rx polling callback
+ * @napi: structure for representing this polling device
+ * @budget: how many packets driver is allowed to clean
+ *
+ * @return: work done in this call
+ * This function is used for legacy and MSI, NAPI mode
+ **/
+static int rnpgbe_poll(struct napi_struct *napi, int budget)
+{
+	struct mucse_q_vector *q_vector =
+		container_of(napi, struct mucse_q_vector, napi);
+	int work_done = 0;
+
+	/* Exit if we are called by netpoll */
+	if (unlikely(!budget))
+		return 0;
+
+	if (likely(napi_complete_done(napi, work_done)))
+		rnpgbe_irq_enable_queues(q_vector);
+
+	return work_done;
+}
+
+/**
+ * register_mbx_irq - Register mbx routine
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int register_mbx_irq(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+	int err = 0;
+
+	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
+		 "rnpgbe-mbx:%s", pci_name(pdev));
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		err = request_irq(pci_irq_vector(pdev, 0),
+				  rnpgbe_msix_other, 0, mucse->mbx_name,
+				  mucse);
+	}
+
+	return err;
+}
+
+/**
+ * remove_mbx_irq - Remove mbx routine
+ * @mucse: pointer to private structure
+ **/
+void remove_mbx_irq(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+
+	if (mucse->flags & M_FLAG_MSIX_EN)
+		free_irq(pci_irq_vector(pdev, 0), mucse);
+}
+
+/**
+ * rnpgbe_set_num_queues - Allocate queues for device, feature dependent
+ * @mucse: pointer to private structure
+ *
+ * Determine tx/rx queue nums
+ **/
+static void rnpgbe_set_num_queues(struct mucse *mucse)
+{
+	/* start from 1 queue */
+	mucse->num_tx_queues = 1;
+	mucse->num_rx_queues = 1;
+}
+
+/**
+ * rnpgbe_set_interrupt_capability - Set MSI-X or MSI if supported
+ * @mucse: pointer to private structure
+ *
+ * Attempt to configure the interrupts using the best available
+ * capabilities of the hardware.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
+{
+	int v_budget;
+
+	v_budget = min_t(int, mucse->num_tx_queues, mucse->num_rx_queues);
+	v_budget = min_t(int, v_budget, MAX_Q_VECTORS);
+	v_budget = min_t(int, v_budget, num_online_cpus());
+	/* add one vector for mbx */
+	v_budget += 1;
+	v_budget = pci_alloc_irq_vectors(mucse->pdev, 1, v_budget,
+					 PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (v_budget < 0)
+		return v_budget;
+
+	if (mucse->pdev->msix_enabled) {
+		/* q_vector not include mbx */
+		if (v_budget > 1) {
+			mucse->flags |= M_FLAG_MSIX_EN;
+			mucse->num_q_vectors = v_budget - 1;
+		} else {
+			mucse->flags |= M_FLAG_MSIX_SINGLE_EN;
+			mucse->num_q_vectors = 1;
+		}
+	} else {
+		/* msi use only 1 irq */
+		mucse->num_q_vectors = 1;
+		mucse->flags |= M_FLAG_MSI_EN;
+	}
+
+	return 0;
+}
+
+/**
+ * mucse_add_ring - Add ring to ring container
+ * @ring: ring to be added
+ * @head: ring container
+ **/
+static void mucse_add_ring(struct mucse_ring *ring,
+			   struct mucse_ring_container *head)
+{
+	ring->next = head->ring;
+	head->ring = ring;
+	head->count++;
+}
+
+/**
+ * rnpgbe_alloc_q_vector - Allocate memory for a single interrupt vector
+ * @mucse: pointer to private structure
+ * @eth_queue_idx: queue_index idx for this q_vector
+ * @v_idx: index of vector used for this q_vector
+ * @r_idx: total number of rings to allocate
+ * @r_count: ring count
+ * @step: ring step
+ *
+ * @return: 0 on success. If allocation fails we return -ENOMEM.
+ **/
+static int rnpgbe_alloc_q_vector(struct mucse *mucse,
+				 int eth_queue_idx, int v_idx, int r_idx,
+				 int r_count, int step)
+{
+	int rxr_idx = r_idx, txr_idx = r_idx;
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_q_vector *q_vector;
+	int txr_count, rxr_count, idx;
+	struct mucse_ring *ring;
+	int ring_count;
+
+	txr_count = r_count;
+	rxr_count = r_count;
+	ring_count = txr_count + rxr_count;
+
+	q_vector = kzalloc_flex(*q_vector, ring, ring_count);
+	if (!q_vector)
+		return -ENOMEM;
+
+	netif_napi_add(mucse->netdev, &q_vector->napi, rnpgbe_poll);
+	/* tie q_vector and mucse together */
+	mucse->q_vector[v_idx] = q_vector;
+	q_vector->mucse = mucse;
+	q_vector->v_idx = v_idx;
+	/* if mbx use separate irq, we should add 1 */
+	if (mucse->flags & M_FLAG_MSIX_EN)
+		q_vector->v_idx++;
+
+	ring = q_vector->ring;
+
+	for (idx = 0; idx < txr_count; idx++) {
+		mucse_add_ring(ring, &q_vector->tx);
+		ring->queue_index = eth_queue_idx + idx;
+		ring->rnpgbe_queue_idx = txr_idx;
+		ring->ring_addr = hw->hw_addr + RING_OFFSET(txr_idx);
+		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
+		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
+		mucse->tx_ring[ring->queue_index] = ring;
+		txr_idx += step;
+		ring++;
+	}
+
+	for (idx = 0; idx < rxr_count; idx++) {
+		mucse_add_ring(ring, &q_vector->rx);
+		ring->queue_index = eth_queue_idx + idx;
+		ring->rnpgbe_queue_idx = rxr_idx;
+		ring->ring_addr = hw->hw_addr + RING_OFFSET(rxr_idx);
+		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
+		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
+		mucse->rx_ring[ring->queue_index] = ring;
+		rxr_idx += step;
+		ring++;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_free_q_vector - Free memory allocated for specific interrupt vector
+ * @mucse: pointer to private structure
+ * @v_idx: index of vector to be freed
+ *
+ * This function frees the memory allocated to the q_vector.  In addition if
+ * NAPI is enabled it will delete any references to the NAPI struct prior
+ * to freeing the q_vector.
+ **/
+static void rnpgbe_free_q_vector(struct mucse *mucse, int v_idx)
+{
+	struct mucse_q_vector *q_vector = mucse->q_vector[v_idx];
+	struct mucse_ring *ring;
+
+	mucse_for_each_ring(ring, q_vector->tx)
+		mucse->tx_ring[ring->queue_index] = NULL;
+	mucse_for_each_ring(ring, q_vector->rx)
+		mucse->rx_ring[ring->queue_index] = NULL;
+	mucse->q_vector[v_idx] = NULL;
+	netif_napi_del(&q_vector->napi);
+	kfree(q_vector);
+}
+
+/**
+ * rnpgbe_alloc_q_vectors - Allocate memory for interrupt vectors
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 if success. if allocation fails we return -ENOMEM.
+ **/
+static int rnpgbe_alloc_q_vectors(struct mucse *mucse)
+{
+	int err, ring_cnt, v_remaing = mucse->num_q_vectors;
+	int r_remaing = min_t(int, mucse->num_tx_queues,
+			      mucse->num_rx_queues);
+	int q_vector_nums = 0;
+	int eth_queue_idx = 0;
+	int ring_step = 1;
+	int ring_idx = 0;
+	int v_idx = 0;
+
+	for (; r_remaing > 0 && v_remaing > 0; v_remaing--) {
+		ring_cnt = DIV_ROUND_UP(r_remaing, v_remaing);
+		err = rnpgbe_alloc_q_vector(mucse, eth_queue_idx,
+					    v_idx, ring_idx, ring_cnt,
+					    ring_step);
+		if (err)
+			goto err_free_q_vector;
+		ring_idx += ring_step * ring_cnt;
+		eth_queue_idx += ring_cnt;
+		r_remaing -= ring_cnt;
+		q_vector_nums++;
+		v_idx++;
+	}
+	/* Fix the real used q_vectors_nums */
+	mucse->num_q_vectors = q_vector_nums;
+
+	return 0;
+
+err_free_q_vector:
+	mucse->num_tx_queues = 0;
+	mucse->num_rx_queues = 0;
+	mucse->num_q_vectors = 0;
+
+	while (v_idx--)
+		rnpgbe_free_q_vector(mucse, v_idx);
+
+	return err;
+}
+
+/**
+ * rnpgbe_reset_interrupt_capability - Reset irq capability setup
+ * @mucse: pointer to private structure
+ **/
+static void rnpgbe_reset_interrupt_capability(struct mucse *mucse)
+{
+	pci_free_irq_vectors(mucse->pdev);
+	mucse->flags &= ~(M_FLAG_MSIX_EN |
+			M_FLAG_MSIX_SINGLE_EN |
+			M_FLAG_MSI_EN);
+}
+
+/**
+ * rnpgbe_init_interrupt_scheme - Determine proper interrupt scheme
+ * @mucse: pointer to private structure
+ *
+ * We determine which interrupt scheme to use based on...
+ * - Hardware queue count
+ * - cpu numbers
+ * - irq mode (msi/legacy force 1)
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int rnpgbe_init_interrupt_scheme(struct mucse *mucse)
+{
+	int err;
+
+	rnpgbe_set_num_queues(mucse);
+
+	err = rnpgbe_set_interrupt_capability(mucse);
+	if (err)
+		return err;
+
+	err = rnpgbe_alloc_q_vectors(mucse);
+	if (err) {
+		rnpgbe_reset_interrupt_capability(mucse);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_free_q_vectors - Free memory allocated for interrupt vectors
+ * @mucse: pointer to private structure
+ *
+ * This function frees the memory allocated to the q_vectors.  In addition if
+ * NAPI is enabled it will delete any references to the NAPI struct prior
+ * to freeing the q_vector.
+ **/
+static void rnpgbe_free_q_vectors(struct mucse *mucse)
+{
+	int v_idx = mucse->num_q_vectors;
+
+	mucse->num_rx_queues = 0;
+	mucse->num_tx_queues = 0;
+	mucse->num_q_vectors = 0;
+
+	while (v_idx--)
+		rnpgbe_free_q_vector(mucse, v_idx);
+}
+
+/**
+ * rnpgbe_clear_interrupt_scheme - Clear the current interrupt scheme settings
+ * @mucse: pointer to private structure
+ *
+ * Clear interrupt specific resources and reset the structure
+ **/
+void rnpgbe_clear_interrupt_scheme(struct mucse *mucse)
+{
+	mucse->num_tx_queues = 0;
+	mucse->num_rx_queues = 0;
+	rnpgbe_free_q_vectors(mucse);
+	rnpgbe_reset_interrupt_capability(mucse);
+}
+
+/**
+ * rnpgbe_msix_clean_rings - Msix irq handler for ring irq
+ * @irq: irq num
+ * @data: private data
+ *
+ * rnpgbe_msix_clean_rings handle irq from ring, start napi
+ * @return: IRQ_HANDLED
+ **/
+static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
+{
+	struct mucse_q_vector *q_vector = (struct mucse_q_vector *)data;
+
+	rnpgbe_irq_disable_queues(q_vector);
+	if (q_vector->rx.ring || q_vector->tx.ring)
+		napi_schedule_irqoff(&q_vector->napi);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * rnpgbe_int_single - Msix-signle/msi irq handler
+ * @irq: irq num
+ * @data: private data
+ * @return: IRQ_HANDLED
+ **/
+static irqreturn_t rnpgbe_int_single(int irq, void *data)
+{
+	struct mucse *mucse = (struct mucse *)data;
+	struct mucse_q_vector *q_vector;
+
+	mucse_fw_irq_handler(&mucse->hw);
+
+	q_vector = mucse->q_vector[0];
+	rnpgbe_irq_disable_queues(q_vector);
+	if (q_vector->rx.ring || q_vector->tx.ring)
+		napi_schedule_irqoff(&q_vector->napi);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * rnpgbe_request_irq - Initialize interrupts
+ * @mucse: pointer to private structure
+ *
+ * Attempts to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ *
+ * @return: 0 on success, negative value on failure
+ **/
+int rnpgbe_request_irq(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_q_vector *q_vector;
+	int err, i;
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		for (i = 0; i < mucse->num_q_vectors; i++) {
+			q_vector = mucse->q_vector[i];
+
+			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				 "%s-%s-%d", netdev->name, "TxRx", i);
+
+			err = request_irq(pci_irq_vector(pdev, i + 1),
+					  rnpgbe_msix_clean_rings, 0,
+					  q_vector->name,
+					  q_vector);
+			if (err) {
+				dev_err(&pdev->dev, "MSI-X req err %d: %d\n",
+					i + 1, err);
+				goto err_free_irqs;
+			}
+		}
+	} else {
+		/* msi/msix_single */
+		err = request_irq(pci_irq_vector(pdev, 0),
+				  rnpgbe_int_single, 0, netdev->name,
+				  mucse);
+		if (err)
+			return err;
+	}
+
+	return 0;
+err_free_irqs:
+	while (i--) {
+		q_vector = mucse->q_vector[i];
+		synchronize_irq(pci_irq_vector(pdev, i + 1));
+		free_irq(pci_irq_vector(pdev, i + 1), q_vector);
+	}
+
+	return err;
+}
+
+/**
+ * rnpgbe_free_irq - Free interrupts
+ * @mucse: pointer to private structure
+ *
+ * Attempts to free interrupts according initialized type.
+ **/
+void rnpgbe_free_irq(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_q_vector *q_vector;
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		for (int i = 0; i < mucse->num_q_vectors; i++) {
+			q_vector = mucse->q_vector[i];
+			if (!q_vector)
+				continue;
+
+			free_irq(pci_irq_vector(pdev, i + 1), q_vector);
+		}
+	} else {
+		free_irq(pci_irq_vector(pdev, 0), mucse);
+	}
+}
+
+/**
+ * rnpgbe_set_ring_vector - Set the ring_vector registers,
+ * mapping interrupt causes to vectors
+ * @mucse: pointer to private structure
+ * @queue: queue to map the corresponding interrupt to
+ * @msix_vector: the vector num to map to the corresponding queue
+ *
+ */
+static void rnpgbe_set_ring_vector(struct mucse *mucse,
+				   u8 queue, u8 msix_vector)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 data;
+
+	data = hw->pfvfnum << 24;
+	data |= (msix_vector << 8);
+	data |= msix_vector;
+	writel(data, hw->ring_msix_base + RING_VECTOR(queue));
+}
+
+/**
+ * rnpgbe_configure_msix - Configure MSI-X hardware
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_configure_msix sets up the hardware to properly generate MSI-X
+ * interrupts.
+ **/
+static void rnpgbe_configure_msix(struct mucse *mucse)
+{
+	struct mucse_q_vector *q_vector;
+
+	if (!(mucse->flags & (M_FLAG_MSIX_EN | M_FLAG_MSIX_SINGLE_EN)))
+		return;
+
+	for (int i = 0; i < mucse->num_q_vectors; i++) {
+		struct mucse_ring *ring;
+
+		q_vector = mucse->q_vector[i];
+		/* tx/rx use one register, different bit */
+		mucse_for_each_ring(ring, q_vector->tx) {
+			rnpgbe_set_ring_vector(mucse, ring->rnpgbe_queue_idx,
+					       q_vector->v_idx);
+		}
+	}
+}
+
+static void rnpgbe_irq_enable(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_q_vectors; i++)
+		rnpgbe_irq_enable_queues(mucse->q_vector[i]);
+}
+
+/**
+ * rnpgbe_irq_disable - Mask off interrupt generation on the NIC
+ * @mucse: board private structure
+ **/
+void rnpgbe_irq_disable(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		for (int i = 0; i < mucse->num_q_vectors; i++) {
+			rnpgbe_irq_disable_queues(mucse->q_vector[i]);
+			synchronize_irq(pci_irq_vector(pdev, i + 1));
+		}
+	} else {
+		rnpgbe_irq_disable_queues(mucse->q_vector[0]);
+		synchronize_irq(pci_irq_vector(pdev, 0));
+	}
+}
+
+static void rnpgbe_napi_enable_all(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_q_vectors; i++)
+		napi_enable(&mucse->q_vector[i]->napi);
+}
+
+static void rnpgbe_napi_disable_all(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_q_vectors; i++)
+		napi_disable(&mucse->q_vector[i]->napi);
+}
+
+void rnpgbe_down(struct mucse *mucse)
+{
+	rnpgbe_napi_disable_all(mucse);
+	rnpgbe_irq_disable(mucse);
+}
+
+/**
+ * rnpgbe_up_complete - Final step for port up
+ * @mucse: pointer to private structure
+ **/
+void rnpgbe_up_complete(struct mucse *mucse)
+{
+	rnpgbe_configure_msix(mucse);
+	rnpgbe_napi_enable_all(mucse);
+	rnpgbe_irq_enable(mucse);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
new file mode 100644
index 000000000000..baee4430a3a9
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_LIB_H
+#define _RNPGBE_LIB_H
+
+struct mucse;
+struct mucse_hw;
+
+#define RING_OFFSET(n)            (0x1000 + 0x100 * (n))
+#define RNPGBE_DMA_INT_MASK       0x24
+#define TX_INT_MASK               BIT(1)
+#define RX_INT_MASK               BIT(0)
+#define INT_VALID                 (BIT(16) | BIT(17))
+#define RNPGBE_DMA_INT_TRIG       0x2c
+/* |  31:24   | .... |    15:8   |    7:0    | */
+/* |  pfvfnum |      | tx vector | rx vector | */
+#define RING_VECTOR(n)            (0x04 * (n))
+
+#define mucse_for_each_ring(pos, head)\
+	for (typeof((head).ring) __pos = (head).ring;\
+	     __pos ? ({ pos = __pos; 1; }) : 0;\
+	     __pos = __pos->next)
+
+int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
+void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
+int register_mbx_irq(struct mucse *mucse);
+void remove_mbx_irq(struct mucse *mucse);
+int rnpgbe_request_irq(struct mucse *mucse);
+void rnpgbe_free_irq(struct mucse *mucse);
+void rnpgbe_irq_disable(struct mucse *mucse);
+void rnpgbe_down(struct mucse *mucse);
+void rnpgbe_up_complete(struct mucse *mucse);
+#endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 316f941629d4..d2530aa4b7ba 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,6 +7,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_lib.h"
 #include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
@@ -32,11 +33,28 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  * The open entry point is called when a network interface is made
  * active by the system (IFF_UP).
  *
- * Return: 0
+ * Return: 0 on success, negative value on failure
  **/
 static int rnpgbe_open(struct net_device *netdev)
 {
+	struct mucse *mucse = netdev_priv(netdev);
+	int err;
+
+	err = rnpgbe_request_irq(mucse);
+	if (err)
+		return err;
+
+	err = netif_set_real_num_queues(netdev, mucse->num_tx_queues,
+					mucse->num_rx_queues);
+	if (err)
+		goto err_free_irqs;
+
+	rnpgbe_up_complete(mucse);
+
 	return 0;
+err_free_irqs:
+	rnpgbe_free_irq(mucse);
+	return err;
 }
 
 /**
@@ -50,6 +68,11 @@ static int rnpgbe_open(struct net_device *netdev)
  **/
 static int rnpgbe_close(struct net_device *netdev)
 {
+	struct mucse *mucse = netdev_priv(netdev);
+
+	rnpgbe_down(mucse);
+	rnpgbe_free_irq(mucse);
+
 	return 0;
 }
 
@@ -166,11 +189,28 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	err = rnpgbe_init_interrupt_scheme(mucse);
+	if (err) {
+		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
+		goto err_powerdown;
+	}
+
+	err = register_mbx_irq(mucse);
+	if (err) {
+		dev_err(&pdev->dev, "register mbx irq failed %d\n", err);
+		goto err_clear_interrupt;
+	}
+
 	err = register_netdev(netdev);
 	if (err)
-		goto err_powerdown;
+		goto err_remove_mbx;
 
 	return 0;
+
+err_remove_mbx:
+	remove_mbx_irq(mucse);
+err_clear_interrupt:
+	rnpgbe_clear_interrupt_scheme(mucse);
 err_powerdown:
 	/* notify powerdown only powerup ok */
 	if (!err_notify) {
@@ -252,10 +292,12 @@ static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
+	remove_mbx_irq(mucse);
 	unregister_netdev(netdev);
 	err = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
 	if (err)
 		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	free_netdev(netdev);
 }
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 8c8bd5e8e1db..05684d716792 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -189,3 +189,11 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 
 	return 0;
 }
+
+/**
+ * mucse_fw_irq_handler - Try to handle a req from hw
+ * @hw: pointer to the HW structure
+ **/
+void mucse_fw_irq_handler(struct mucse_hw *hw)
+{
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index fb24fc12b613..aa26c729588c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -85,4 +85,5 @@ int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup);
 int mucse_mbx_reset_hw(struct mucse_hw *hw);
 int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			  u8 *mac_addr, int port);
+void mucse_fw_irq_handler(struct mucse_hw *hw);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


