Return-Path: <netdev+bounces-203580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 529CBAF6776
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53EB7A2ACC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA00233155;
	Thu,  3 Jul 2025 01:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775922CBC6;
	Thu,  3 Jul 2025 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507484; cv=none; b=hvXkzpMCjenyc7VgufdbxccYldHxPoIOJSJv64bIsfVQI8spnUv9ADayxomNfB58geBH3Fh9gQPOviftNauKp2iEG2xn9M9PxpZE/Sz4SJJHBiKbzjqFdtdpONc8A8elSWRL85u3iZuq34Qrr5n/KXdLkZoC8du5EKQ1XzZo/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507484; c=relaxed/simple;
	bh=vHopI+3vdmWvIlIfdJ0fD4kaUzUytHLGFx5YrKept3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgMkrzR8w7fLR6XTSenLWkSGIEczZqbKjuMrtLhltOB+qG78qdTChGlzvNgYN/Sk4XXjQ9q+tJsn2NbzQoZzOHAVPZajyVY70JnvTf60rrHfMTuH5yuTezN87FdbTyN5lZeRsTxkdc2BRb9JKbFmfidndOqwDjM63uDTWDBJ3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507371t3fc1a580
X-QQ-Originating-IP: VPb6hTKB8nKZGBv13sKuqW1skGno5GiMXeoDkm4OP5o=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2793561445784462735
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
Subject: [PATCH 03/15] net: rnpgbe: Add basic mbx ops support
Date: Thu,  3 Jul 2025 09:48:47 +0800
Message-Id: <20250703014859.210110-4-dong100@mucse.com>
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
X-QQ-XMAILINFO: NCjYbQ0FTrEVY33nszPOHbcJE68vfUSobTt33UEk+ZnDirT6kCunKIuH
	MoJxD2q+6majlhK5dXAYKNIaN8F5ibUK6ivJIxchT4PsSm6/0wbDZyVri1TSnkCJu842CPq
	vJGrIoi6qRPGYW/jWvNSjFl678VM0mHT3X/DzLjSzNfp79wwkXnD9Y47lbbq8IJJXFvYUoJ
	nupOIiy3RwV6ds8YFlmd1IbO1idQwxXKrra5Q2lARkDqIa9xy7fts4bwRJdBYLwEPGeKR8U
	fGDWhhG8AtpYx6W3PGW3BB2ij7KuodAiqCojyeK+KK4fP0xNF7yvN6B2i5g/wxtzTz992MA
	JgyLBVcYscTGYxP2GdgyhX42LoJOKu5cqQa5Cn3gHfUOUEc7eY/cdxHJu1X6H2c9IXB82ot
	OdEK1ISxtjErir1csAaW78fd2K04+NjfnKDBGUe8F9/7arkMSINgKDT9snRmVmhSLkCYtwe
	+OfRjHJSVXuvMhQpveHLryZ1USP19Pp4fQ6KSPQ9qEm7qYzz9BRvwF5stJjtKRDXGTiOQsv
	6r6mxpwnoHTDYkjFPe8cQbEW+VF90WPnzhvN4hgX4XoLN42sx0Q8+4qHQEEc+9VebZ69utm
	j8t9dKh0gkJBd3pnvaORnJ50unOCK99QaL5dsZWJITWo+S61e36x/j5P/VRNU1fl9ut3qiW
	x8FxjSN7GPI9ATmZGPHXtpGSfPmIm2pImS8Ed5zlObcvZ9YXJTlAtqFzXmADlHQHIEfwIAy
	ajLHS7ocNrdIeWjsuYBitXdiNjf5XOYrIJl5yE8fLX9iDYs1VSHe3+gPBTSxfYUnC36o4Xn
	pbFM7KpNrnAzjg9cp0Hhw5Ez8VqTL0V322kASxBlhZlbkYjtN0WHYEPOKIaTm3PQc/Q8WYt
	lFoGUrMWnPbLYZalcskOpNEJVERWKGPPib93OOOh8hI1xxnIbz6M99nMW1pt7tGWmyQTkx7
	YY20yGocHJJAagA57ADxKoCeykkzAbnDs8UqcUT9nasHs/Xxs3roB+mVGex/S8vAQwmV6HT
	l/fdGmGXS508W2kXnMhmgBZpSqlW02msp0l0SVsOBSsleus25y
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Initialize basic mbx function.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   5 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  64 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  25 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 622 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  48 ++
 7 files changed, 745 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 42c359f459d9..41177103b50c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -5,5 +5,6 @@
 #
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
-rnpgbe-objs := rnpgbe_main.o\
-	       rnpgbe_chip.o
+rnpgbe-objs := rnpgbe_main.o \
+	       rnpgbe_chip.o \
+	       rnpgbe_mbx.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 664b6c86819a..4cafab16f5bf 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -64,18 +64,60 @@ struct mucse_mac_info {
 	u8 perm_addr[ETH_ALEN];
 };
 
+struct mucse_hw;
+
+enum MBX_ID {
+	MBX_VF0 = 0,
+	MBX_VF1,
+	MBX_VF2,
+	MBX_VF3,
+	MBX_VF4,
+	MBX_VF5,
+	MBX_VF6,
+	MBX_VF7,
+	MBX_CM3CPU,
+	MBX_FW = MBX_CM3CPU,
+	MBX_VFCNT
+};
+
+struct mucse_mbx_operations {
+	s32 (*init_params)(struct mucse_hw *hw);
+	s32 (*read)(struct mucse_hw *hw, u32 *msg,
+		    u16 size, enum MBX_ID id);
+	s32 (*write)(struct mucse_hw *hw, u32 *msg,
+		     u16 size, enum MBX_ID id);
+	s32 (*read_posted)(struct mucse_hw *hw, u32 *msg,
+			   u16 size, enum MBX_ID id);
+	s32 (*write_posted)(struct mucse_hw *hw, u32 *msg,
+			    u16 size, enum MBX_ID id);
+	s32 (*check_for_msg)(struct mucse_hw *hw, enum MBX_ID id);
+	s32 (*check_for_ack)(struct mucse_hw *hw, enum MBX_ID id);
+	s32 (*configure)(struct mucse_hw *hw, int num_vec,
+			 bool enable);
+};
+
+struct mucse_mbx_stats {
+	u32 msgs_tx;
+	u32 msgs_rx;
+	u32 acks;
+	u32 reqs;
+	u32 rsts;
+};
+
 #define MAX_VF_NUM (8)
 
 struct mucse_mbx_info {
+	struct mucse_mbx_operations ops;
+	struct mucse_mbx_stats stats;
 	u32 timeout;
 	u32 usec_delay;
 	u32 v2p_mailbox;
 	u16 size;
 	u16 vf_req[MAX_VF_NUM];
 	u16 vf_ack[MAX_VF_NUM];
-	u16 cpu_req;
-	u16 cpu_ack;
-	/* lock for only one user */
+	u16 fw_req;
+	u16 fw_ack;
+	/* lock for only one use mbx */
 	struct mutex lock;
 	bool other_irq_enabled;
 	int mbx_size;
@@ -84,11 +126,11 @@ struct mucse_mbx_info {
 #define MBX_FEATURE_WRITE_DELAY BIT(1)
 	u32 mbx_feature;
 	/* cm3 <-> pf mbx */
-	u32 cpu_pf_shm_base;
-	u32 pf2cpu_mbox_ctrl;
-	u32 pf2cpu_mbox_mask;
-	u32 cpu_pf_mbox_mask;
-	u32 cpu2pf_mbox_vec;
+	u32 fw_pf_shm_base;
+	u32 pf2fw_mbox_ctrl;
+	u32 pf2fw_mbox_mask;
+	u32 fw_pf_mbox_mask;
+	u32 fw2pf_mbox_vec;
 	/* pf <--> vf mbx */
 	u32 pf_vf_shm_base;
 	u32 pf2vf_mbox_ctrl_base;
@@ -96,10 +138,12 @@ struct mucse_mbx_info {
 	u32 pf_vf_mbox_mask_hi;
 	u32 pf2vf_mbox_vec_base;
 	u32 vf2pf_mbox_vec_base;
-	u32 cpu_vf_share_ram;
+	u32 fw_vf_share_ram;
 	int share_size;
 };
 
+#include "rnpgbe_mbx.h"
+
 struct mucse_hw {
 	void *back;
 	u8 pfvfnum;
@@ -111,6 +155,8 @@ struct mucse_hw {
 	u16 vendor_id;
 	u16 subsystem_device_id;
 	u16 subsystem_vendor_id;
+	int max_vfs;
+	int max_vfs_noari;
 	enum rnpgbe_hw_type hw_type;
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 5580298eabb6..08d082fa3066 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -6,6 +6,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
 
 /**
  * rnpgbe_get_invariants_n500 - setup for hw info
@@ -57,18 +58,18 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	mbx->mbx_feature |= MBX_FEATURE_NO_ZERO;
 	/* mbx offset */
 	mbx->vf2pf_mbox_vec_base = 0x28900;
-	mbx->cpu2pf_mbox_vec = 0x28b00;
+	mbx->fw2pf_mbox_vec = 0x28b00;
 	mbx->pf_vf_shm_base = 0x29000;
 	mbx->mbx_mem_size = 64;
 	mbx->pf2vf_mbox_ctrl_base = 0x2a100;
 	mbx->pf_vf_mbox_mask_lo = 0x2a200;
 	mbx->pf_vf_mbox_mask_hi = 0;
-	mbx->cpu_pf_shm_base = 0x2d000;
-	mbx->pf2cpu_mbox_ctrl = 0x2e000;
-	mbx->cpu_pf_mbox_mask = 0x2e200;
-	mbx->cpu_vf_share_ram = 0x2b000;
+	mbx->fw_pf_shm_base = 0x2d000;
+	mbx->pf2fw_mbox_ctrl = 0x2e000;
+	mbx->fw_pf_mbox_mask = 0x2e200;
+	mbx->fw_vf_share_ram = 0x2b000;
 	mbx->share_size = 512;
-
+	memcpy(&hw->mbx.ops, &mucse_mbx_ops_generic, sizeof(hw->mbx.ops));
 	/* setup net feature here */
 	hw->feature_flags |=
 		M_NET_FEATURE_SG | M_NET_FEATURE_TX_CHECKSUM |
@@ -79,6 +80,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 		M_NET_FEATURE_STAG_FILTER | M_NET_FEATURE_STAG_OFFLOAD;
 	/* start the default ahz, update later*/
 	hw->usecstocount = 125;
+	hw->max_vfs = 7;
 }
 
 static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
@@ -91,20 +93,21 @@ static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
 	hw->ring_msix_base = hw->hw_addr + 0x29000;
 	/* update mbx offset */
 	mbx->vf2pf_mbox_vec_base = 0x29200;
-	mbx->cpu2pf_mbox_vec = 0x29400;
+	mbx->fw2pf_mbox_vec = 0x29400;
 	mbx->pf_vf_shm_base = 0x29900;
 	mbx->mbx_mem_size = 64;
 	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
 	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
 	mbx->pf_vf_mbox_mask_hi = 0;
-	mbx->cpu_pf_shm_base = 0x2d900;
-	mbx->pf2cpu_mbox_ctrl = 0x2e900;
-	mbx->cpu_pf_mbox_mask = 0x2eb00;
-	mbx->cpu_vf_share_ram = 0x2b900;
+	mbx->fw_pf_shm_base = 0x2d900;
+	mbx->pf2fw_mbox_ctrl = 0x2e900;
+	mbx->fw_pf_mbox_mask = 0x2eb00;
+	mbx->fw_vf_share_ram = 0x2b900;
 	mbx->share_size = 512;
 	/* update hw feature */
 	hw->feature_flags |= M_HW_FEATURE_EEE;
 	hw->usecstocount = 62;
+	hw->max_vfs_noari = 7;
 }
 
 const struct rnpgbe_info rnpgbe_n500_info = {
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 2c7372a5e88d..ff7bd9b21550 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -14,6 +14,8 @@
 #define RNPGBE_RING_BASE (0x1000)
 #define RNPGBE_MAC_BASE (0x20000)
 #define RNPGBE_ETH_BASE (0x10000)
+
+#define RNPGBE_DMA_DUMY (0x000c)
 /* chip resourse */
 #define RNPGBE_MAX_QUEUES (8)
 /* multicast control table */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 30c5a4874929..e125b609ba09 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -135,6 +135,7 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	hw->hw_addr = hw_addr;
 	hw->dma.dma_version = dma_version;
 	ii->get_invariants(hw);
+	hw->mbx.ops.init_params(hw);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
new file mode 100644
index 000000000000..f4bfa69fdb41
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include "rnpgbe.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_hw.h"
+
+/**
+ * mucse_read_mbx - Reads a message from the mailbox
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to read
+ *
+ * returns 0 if it successfully read message or else
+ * MUCSE_ERR_MBX.
+ **/
+s32 mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		   enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	s32 ret_val = MUCSE_ERR_MBX;
+
+	/* limit read to size of mailbox */
+	if (size > mbx->size)
+		size = mbx->size;
+
+	if (mbx->ops.read)
+		ret_val = mbx->ops.read(hw, msg, size, mbx_id);
+
+	return ret_val;
+}
+
+/**
+ * mucse_write_mbx - Write a message to the mailbox
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to write
+ *
+ * returns 0 if it successfully write message or else
+ * MUCSE_ERR_MBX.
+ **/
+s32 mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		    enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	s32 ret_val = 0;
+
+	if (size > mbx->size)
+		ret_val = MUCSE_ERR_MBX;
+	else if (mbx->ops.write)
+		ret_val = mbx->ops.write(hw, msg, size, mbx_id);
+
+	return ret_val;
+}
+
+static inline u16 mucse_mbx_get_req(struct mucse_hw *hw, int reg)
+{
+	/* force memory barrier */
+	mb();
+	return ioread32(hw->hw_addr + reg) & 0xffff;
+}
+
+static inline u16 mucse_mbx_get_ack(struct mucse_hw *hw, int reg)
+{
+	/* force memory barrier */
+	mb();
+	return (mbx_rd32(hw, reg) >> 16);
+}
+
+static inline void mucse_mbx_inc_pf_req(struct mucse_hw *hw,
+					enum MBX_ID mbx_id)
+{
+	u16 req;
+	u32 reg;
+	u32 v;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
+				   PF2VF_COUNTER(mbx, mbx_id);
+	v = mbx_rd32(hw, reg);
+	req = (v & 0xffff);
+	req++;
+	v &= ~(0x0000ffff);
+	v |= req;
+	/* force before write to hw */
+	mb();
+	mbx_wr32(hw, reg, v);
+	/* update stats */
+	hw->mbx.stats.msgs_tx++;
+}
+
+static inline void mucse_mbx_inc_pf_ack(struct mucse_hw *hw,
+					enum MBX_ID mbx_id)
+{
+	u16 ack;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
+				       PF2VF_COUNTER(mbx, mbx_id);
+	u32 v;
+
+	v = mbx_rd32(hw, reg);
+	ack = (v >> 16) & 0xffff;
+	ack++;
+	v &= ~(0xffff0000);
+	v |= (ack << 16);
+	/* force before write to hw */
+	mb();
+	mbx_wr32(hw, reg, v);
+	/* update stats */
+	hw->mbx.stats.msgs_rx++;
+}
+
+/**
+ * mucse_check_for_msg - Checks to see if vf/fw sent us mail
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * returns SUCCESS if the Status bit was found or else
+ * MUCSE_ERR_MBX
+ **/
+s32 mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	s32 ret_val = MUCSE_ERR_MBX;
+
+	if (mbx->ops.check_for_msg)
+		ret_val = mbx->ops.check_for_msg(hw, mbx_id);
+
+	return ret_val;
+}
+
+/**
+ * mucse_check_for_ack - Checks to see if vf/fw sent us ACK
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * returns SUCCESS if the Status bit was found or
+ * else MUCSE_ERR_MBX
+ **/
+s32 mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	s32 ret_val = MUCSE_ERR_MBX;
+
+	if (mbx->ops.check_for_ack)
+		ret_val = mbx->ops.check_for_ack(hw, mbx_id);
+
+	return ret_val;
+}
+
+/**
+ * mucse_poll_for_msg - Wait for message notification
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to poll
+ *
+ * returns 0 if it successfully received a message notification
+ **/
+static s32 mucse_poll_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+
+	if (!countdown || !mbx->ops.check_for_msg)
+		goto out;
+
+	while (countdown && mbx->ops.check_for_msg(hw, mbx_id)) {
+		countdown--;
+		if (!countdown)
+			break;
+		udelay(mbx->usec_delay);
+	}
+out:
+	return countdown ? 0 : -ETIME;
+}
+
+/**
+ * mucse_poll_for_ack - Wait for message acknowledgment
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to poll
+ *
+ * returns 0 if it successfully received a message acknowledgment
+ **/
+static s32 mucse_poll_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+
+	if (!countdown || !mbx->ops.check_for_ack)
+		goto out;
+
+	while (countdown && mbx->ops.check_for_ack(hw, mbx_id)) {
+		countdown--;
+		if (!countdown)
+			break;
+		udelay(mbx->usec_delay);
+	}
+
+out:
+	return countdown ? 0 : MUCSE_ERR_MBX;
+}
+
+/**
+ * mucse_read_posted_mbx - Wait for message notification and receive message
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to read
+ *
+ * returns 0 if it successfully received a message notification and
+ * copied it into the receive buffer.
+ **/
+static s32 mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+				 enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	s32 ret_val = MUCSE_ERR_MBX;
+
+	if (!mbx->ops.read)
+		goto out;
+
+	ret_val = mucse_poll_for_msg(hw, mbx_id);
+
+	/* if ack received read message, otherwise we timed out */
+	if (!ret_val)
+		ret_val = mbx->ops.read(hw, msg, size, mbx_id);
+out:
+	return ret_val;
+}
+
+/**
+ * mucse_write_posted_mbx - Write a message to the mailbox, wait for ack
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to write
+ *
+ * returns 0 if it successfully copied message into the buffer and
+ * received an ack to that message within delay * timeout period
+ **/
+static s32 mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+				  enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	s32 ret_val = MUCSE_ERR_MBX;
+
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+
+	/* exit if either we can't write or there isn't a defined timeout */
+	if (!mbx->ops.write || !mbx->timeout)
+		goto out;
+
+	/* send msg and hold buffer lock */
+	ret_val = mbx->ops.write(hw, msg, size, mbx_id);
+
+	/* if msg sent wait until we receive an ack */
+	if (!ret_val)
+		ret_val = mucse_poll_for_ack(hw, mbx_id);
+
+out:
+	return ret_val;
+}
+
+/**
+ * mucse_check_for_msg_pf - checks to see if the vf/fw has sent mail
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * returns 0 if the vf/fw has set the Status bit or else
+ * MUCSE_ERR_MBX
+ **/
+static s32 mucse_check_for_msg_pf(struct mucse_hw *hw,
+				  enum MBX_ID mbx_id)
+{
+	s32 ret_val = MUCSE_ERR_MBX;
+	u16 hw_req_count = 0;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+
+	if (mbx_id == MBX_FW) {
+		hw_req_count = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
+		/* reg in hw should avoid 0 check */
+		if (mbx->mbx_feature & MBX_FEATURE_NO_ZERO) {
+			if (hw_req_count != 0 &&
+			    hw_req_count != hw->mbx.fw_req) {
+				ret_val = 0;
+				hw->mbx.stats.reqs++;
+			}
+		} else {
+			if (hw_req_count != hw->mbx.fw_req) {
+				ret_val = 0;
+				hw->mbx.stats.reqs++;
+			}
+		}
+	} else {
+		if (mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
+		    hw->mbx.vf_req[mbx_id]) {
+			ret_val = 0;
+			hw->mbx.stats.reqs++;
+		}
+	}
+
+	return ret_val;
+}
+
+/**
+ * mucse_check_for_ack_pf - checks to see if the VF has ACKed
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * returns SUCCESS if the vf/fw has set the Status bit or else
+ * MUCSE_ERR_MBX
+ **/
+static s32 mucse_check_for_ack_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	s32 ret_val = MUCSE_ERR_MBX;
+	u16 hw_fw_ack = 0;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+
+	if (mbx_id == MBX_FW) {
+		hw_fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
+		if (hw_fw_ack != 0 &&
+		    hw_fw_ack != hw->mbx.fw_ack) {
+			ret_val = 0;
+			hw->mbx.stats.acks++;
+		}
+	} else {
+		if (mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
+		    hw->mbx.vf_ack[mbx_id]) {
+			ret_val = 0;
+			hw->mbx.stats.acks++;
+		}
+	}
+
+	return ret_val;
+}
+
+/**
+ * mucse_obtain_mbx_lock_pf - obtain mailbox lock
+ * @hw: pointer to the HW structure
+ * @mbx_id: Id of vf/fw to obtain
+ *
+ * return 0 if we obtained the mailbox lock
+ **/
+static s32 mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	int try_cnt = 5000;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 CTRL_REG = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
+						PF2VF_MBOX_CTRL(mbx, mbx_id);
+
+	while (try_cnt-- > 0) {
+		/* Take ownership of the buffer */
+		mbx_wr32(hw, CTRL_REG, MBOX_CTRL_PF_HOLD_SHM);
+		/* force write back before check */
+		wmb();
+		/* reserve mailbox for fw use */
+		if (mbx_rd32(hw, CTRL_REG) & MBOX_CTRL_PF_HOLD_SHM)
+			return 0;
+		udelay(100);
+	}
+	return -EPERM;
+}
+
+/**
+ * mucse_write_mbx_pf - Places a message in the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to write
+ *
+ * returns 0 if it successfully copied message into the buffer
+ **/
+static s32 mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
+			      enum MBX_ID mbx_id)
+{
+	s32 ret_val = 0;
+	u16 i;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 DATA_REG = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
+					    PF_VF_SHM_DATA(mbx, mbx_id);
+	u32 CTRL_REG = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
+					    PF2VF_MBOX_CTRL(mbx, mbx_id);
+	/* if pcie is off, we cannot exchange with hw */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+
+	if (size > MUCSE_VFMAILBOX_SIZE)
+		return -EINVAL;
+
+	/* lock the mailbox to prevent pf/vf/fw race condition */
+	ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
+	if (ret_val)
+		goto out_no_write;
+
+	/* copy the caller specified message to the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		mbx_wr32(hw, DATA_REG + i * 4, msg[i]);
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	if (mbx_id == MBX_FW) {
+		hw->mbx.fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
+	} else {
+		hw->mbx.vf_ack[mbx_id] =
+			mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id));
+	}
+	mucse_mbx_inc_pf_req(hw, mbx_id);
+
+	/* Interrupt VF/FW to tell it a message
+	 * has been sent and release buffer
+	 */
+	if (mbx->mbx_feature & MBX_FEATURE_WRITE_DELAY)
+		udelay(300);
+	mbx_wr32(hw, CTRL_REG, MBOX_CTRL_REQ);
+
+out_no_write:
+	return ret_val;
+}
+
+/**
+ * mucse_read_mbx_pf - Read a message from the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to read
+ *
+ * This function copies a message from the mailbox buffer to the caller's
+ * memory buffer.  The presumption is that the caller knows that there was
+ * a message due to a vf/fw request so no polling for message is needed.
+ **/
+static s32 mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
+			     enum MBX_ID mbx_id)
+{
+	s32 ret_val = -EIO;
+	u32 i;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 BUF_REG = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
+					   PF_VF_SHM_DATA(mbx, mbx_id);
+	u32 CTRL_REG = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
+					    PF2VF_MBOX_CTRL(mbx, mbx_id);
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+	if (size > MUCSE_VFMAILBOX_SIZE)
+		return -EINVAL;
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
+	if (ret_val)
+		goto out_no_read;
+
+	/* we need this */
+	mb();
+	/* copy the message from the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		msg[i] = mbx_rd32(hw, BUF_REG + 4 * i);
+	mbx_wr32(hw, BUF_REG, 0);
+
+	/* update req. used by rnpvf_check_for_msg_vf  */
+	if (mbx_id == MBX_FW) {
+		hw->mbx.fw_req = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
+	} else {
+		hw->mbx.vf_req[mbx_id] =
+			mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id));
+	}
+	/* Acknowledge receipt and release mailbox, then we're done */
+	mucse_mbx_inc_pf_ack(hw, mbx_id);
+	/* free ownership of the buffer */
+	mbx_wr32(hw, CTRL_REG, 0);
+
+out_no_read:
+	return ret_val;
+}
+
+/**
+ * mucse_mbx_reset - reset mbx info, sync info from regs
+ * @hw: Pointer to the HW structure
+ *
+ * This function reset all mbx variables to default.
+ **/
+static void mucse_mbx_reset(struct mucse_hw *hw)
+{
+	int idx, v;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	for (idx = 0; idx < hw->max_vfs; idx++) {
+		v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
+		hw->mbx.vf_req[idx] = v & 0xffff;
+		hw->mbx.vf_ack[idx] = (v >> 16) & 0xffff;
+		mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
+	}
+	v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
+	hw->mbx.fw_req = v & 0xffff;
+	hw->mbx.fw_ack = (v >> 16) & 0xffff;
+
+	mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+
+	if (PF_VF_MBOX_MASK_LO(mbx))
+		mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
+	if (PF_VF_MBOX_MASK_HI(mbx))
+		mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
+
+	mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xffff0000);
+}
+
+/**
+ * mucse_mbx_configure_pf - configure mbx to use nr_vec interrupt
+ * @hw: Pointer to the HW structure
+ * @nr_vec: Vector number for mbx
+ * @enable: TRUE for enable, FALSE for disable
+ *
+ * This function configure mbx to use interrupt nr_vec.
+ **/
+static int mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
+				  bool enable)
+{
+	int idx = 0;
+	u32 v;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+	if (enable) {
+		for (idx = 0; idx < hw->max_vfs; idx++) {
+			v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
+			hw->mbx.vf_req[idx] = v & 0xffff;
+			hw->mbx.vf_ack[idx] = (v >> 16) & 0xffff;
+
+			mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
+		}
+		v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
+		hw->mbx.fw_req = v & 0xffff;
+		hw->mbx.fw_ack = (v >> 16) & 0xffff;
+		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+
+		for (idx = 0; idx < hw->max_vfs; idx++) {
+			mbx_wr32(hw, VF2PF_MBOX_VEC(mbx, idx),
+				 nr_vec);
+		/* vf to pf req interrupt */
+		}
+
+		if (PF_VF_MBOX_MASK_LO(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
+		/* allow vf to vectors */
+
+		if (PF_VF_MBOX_MASK_HI(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
+		/* enable irq */
+		/* bind fw mbx to irq */
+		mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
+		/* allow CM3FW to PF MBX IRQ */
+		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xffff0000);
+	} else {
+		if (PF_VF_MBOX_MASK_LO(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx),
+				 0xffffffff);
+		/* disable irq */
+		if (PF_VF_MBOX_MASK_HI(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx),
+				 0xffffffff);
+
+		/* disable CM3FW to PF MBX IRQ */
+		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
+
+		/* reset vf->pf status/ctrl */
+		for (idx = 0; idx < hw->max_vfs; idx++)
+			mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
+		/* reset pf->cm3 ctrl */
+		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+		/* used to sync link status */
+		mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
+	}
+	return 0;
+}
+
+/**
+ * mucse_init_mbx_params_pf - set initial values for pf mailbox
+ * @hw: pointer to the HW structure
+ *
+ * Initializes the hw->mbx struct to correct values for pf mailbox
+ */
+static s32 mucse_init_mbx_params_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->usec_delay = 100;
+	mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;
+	mbx->stats.msgs_tx = 0;
+	mbx->stats.msgs_rx = 0;
+	mbx->stats.reqs = 0;
+	mbx->stats.acks = 0;
+	mbx->stats.rsts = 0;
+	mbx->size = MUCSE_VFMAILBOX_SIZE;
+
+	mutex_init(&mbx->lock);
+	mucse_mbx_reset(hw);
+	return 0;
+}
+
+struct mucse_mbx_operations mucse_mbx_ops_generic = {
+	.init_params = mucse_init_mbx_params_pf,
+	.read = mucse_read_mbx_pf,
+	.write = mucse_write_mbx_pf,
+	.read_posted = mucse_read_posted_mbx,
+	.write_posted = mucse_write_posted_mbx,
+	.check_for_msg = mucse_check_for_msg_pf,
+	.check_for_ack = mucse_check_for_ack_pf,
+	.configure = mucse_mbx_configure_pf,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
new file mode 100644
index 000000000000..05231c76718e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_H
+#define _RNPGBE_MBX_H
+
+#include "rnpgbe.h"
+#define MUCSE_ERR_MBX -100
+/* 14 words */
+#define MUCSE_VFMAILBOX_SIZE 14
+/* ================ PF <--> VF mailbox ================ */
+#define SHARE_MEM_BYTES 64
+static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
+{
+	return mbx->pf_vf_shm_base + mbx->mbx_mem_size * vf;
+}
+
+#define PF2VF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 0)
+#define VF2PF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 4)
+#define PF_VF_SHM_DATA(mbx, vf) (PF_VF_SHM(mbx, vf) + 8)
+#define VF2PF_MBOX_VEC(mbx, vf) ((mbx)->vf2pf_mbox_vec_base + 4 * (vf))
+#define PF2VF_MBOX_CTRL(mbx, vf) ((mbx)->pf2vf_mbox_ctrl_base + 4 * (vf))
+#define PF_VF_MBOX_MASK_LO(mbx) ((mbx)->pf_vf_mbox_mask_lo)
+#define PF_VF_MBOX_MASK_HI(mbx) ((mbx)->pf_vf_mbox_mask_hi)
+/* ================ PF <--> FW mailbox ================ */
+#define FW_PF_SHM(mbx) ((mbx)->fw_pf_shm_base)
+#define FW2PF_COUNTER(mbx) (FW_PF_SHM(mbx) + 0)
+#define PF2FW_COUNTER(mbx) (FW_PF_SHM(mbx) + 4)
+#define FW_PF_SHM_DATA(mbx) (FW_PF_SHM(mbx) + 8)
+#define FW2PF_MBOX_VEC(mbx) ((mbx)->fw2pf_mbox_vec)
+#define PF2FW_MBOX_CTRL(mbx) ((mbx)->pf2fw_mbox_ctrl)
+#define FW_PF_MBOX_MASK(mbx) ((mbx)->fw_pf_mbox_mask)
+#define MBOX_CTRL_REQ BIT(0) /* WO */
+#define MBOX_CTRL_PF_HOLD_SHM (BIT(3)) /* VF:RO, PF:WR */
+#define MBOX_IRQ_EN 0
+#define MBOX_IRQ_DISABLE 1
+#define mbx_rd32(hw, reg) rnpgbe_rd_reg((hw)->hw_addr + (reg))
+#define mbx_wr32(hw, reg, val) rnpgbe_wr_reg((hw)->hw_addr + (reg), (val))
+
+extern struct mucse_mbx_operations mucse_mbx_ops_generic;
+
+s32 mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		   enum MBX_ID mbx_id);
+s32 mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		    enum MBX_ID mbx_id);
+s32 mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id);
+s32 mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id);
+#endif /* _RNPGBE_MBX_H */
-- 
2.25.1


