Return-Path: <netdev+bounces-203582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB876AF677E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329001C4541D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F880225A47;
	Thu,  3 Jul 2025 01:51:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825902248A4;
	Thu,  3 Jul 2025 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507500; cv=none; b=WvQXAffBxc8frtRQMC0wWcaz3S/Q8AUkeq2C9ulCghy9KVXvXGZPiXYA0jGwnldPWbwjE7Mohps2jZoCwRCPgpazApP56Ten/3hXuQRfbvXtXGFOJAJBi7iQ9oHcjgm3rxNCVcFROx1BhafSs4wYFHPS4rKTAl5LMcUXuud/6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507500; c=relaxed/simple;
	bh=F6A6W3DZygzS9mfL758gzynoQ02XyvHfV3PwPDKNATE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIpzg7tHLmUVZf9UVOKkCXZawTRcV/wOgfvmNGlx/dv/2br8sPau2wWwVwas9u0jrCAdmh+z0QGkkWCWpgeIVpeTQqog8tXGH83ftaab0g0GlNiNRdmEE6LpWaOZR2vfbLYewQSFpEYYHqqPyaCWeMh5dLmwUhWp+5scoZAaGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507367ted607381
X-QQ-Originating-IP: gmOFNm0kXs3InMfAirLbCmO88tJZmqesIzDah3Snyg8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13013126927958381173
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
Subject: [PATCH 02/15] net: rnpgbe: Add n500/n210 chip support
Date: Thu,  3 Jul 2025 09:48:46 +0800
Message-Id: <20250703014859.210110-3-dong100@mucse.com>
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
X-QQ-XMAILINFO: MRiFTjyIbtS1MnC1bVz/TJSMJhd6UAmfIrzhEx8NKY/RzI8GMbwsuagp
	xNxUiqBaRd59jONMnHOUbTe+e1aiG6YAqWSe6RRnCVO+8/CBp9tjzWE4gXytHt9ewieHeal
	qvBS3/htRS6YzlDdeED+E5Di4SEzBtwIpKpuMyuyVWlKXHCNZ4rAhpQl4fXWFgWsLy6GJmc
	5w4KlhqsUw4JX6d+sqmOINGNfScKg+GLydkxcSfKf/Ue4TiFDkSwqMSOKKWjdZzJSD+nphI
	ZDtHUEsJu6I1q6dVS4xXOv9ipjAXeG0zBdtSzhQnuf6o4xj5mMgx/kuxGdHJI6iMG1pjs2Z
	Py1k1ibrrejBbXrvYpEtlPRUn8xV8tziTPN40zNiR23qLG4YXgB8uX3x6Hq7gd3MEUsqdBo
	Ax1LOqI7GkRlJFFdS224d1ER3vriAsjjCp0WbZEshhvo1Jm5YmFN+fA5BzC2gHcArH2NOfR
	qsXN8/0EZx5XaOo4fqdJDafIDyfsWO921MVe6dvDp2d6RazcV6rQZcoNcka+MpI1v9OjZnG
	ZVf/PqrtK0mtSffOqpAzKVIGZXyFSnldkKkTu/byZXvzqgrLkRvTAfy2h9iPOcvEieZk7HC
	XfeTFTx5XUh3FQ1fR8EUBk3sOVjks3JrYtbUdE61ZH6QpJUi6qJ/B0P5D+gHMHloi6cNVqC
	KKY7SLs8VSWJrFfcvbEu3Acf+RSTifzne/kEqGvCMSKRUX1NAGhhQaipVgwWtOOVlbJYJWp
	aLBWNxBkumQP5dmA4u4butNH8wwwqPHuDVDoy+hG0msIERb0MbKPhXFxAMX1CqeoXEJkTmd
	C8EojdFX/QwCktgLcO6tRISy986yExSvqwMQijnfHqfPQCC6evtxGtSKAKP4sBXRh3drDAZ
	/lrOnYA5zslGVdbsB9QU8H25a+zAKXCGMaZMd/yL7rXmsjckZMucL2e16d80eqpluFvj0s7
	P/3p18nWPJdzCJ67xktWS7I/nvIXN1KDdrejPpE7SR6XsstGIjnVqENnx04o6Oxt4dzrWb+
	VJGr6xZgLxmsSmcw3WDvPF03QkYW5JZzQ3Uzx2n9bYSN72EABFWrNgVXkkZ7CnN+Z56Nn5a
	g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Initialize n500/n210 chip bar resource map and
dma, eth, mbx ... info for future use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 139 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 126 ++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  27 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  83 ++++++++++-
 5 files changed, 372 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 0942e27f5913..42c359f459d9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -5,5 +5,5 @@
 #
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
-
-rnpgbe-objs := rnpgbe_main.o
+rnpgbe-objs := rnpgbe_main.o\
+	       rnpgbe_chip.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index a44e6b6255d8..664b6c86819a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,7 +4,12 @@
 #ifndef _RNPGBE_H
 #define _RNPGBE_H
 
-#define RNPGBE_MAX_QUEUES (8)
+#include <linux/types.h>
+#include <linux/netdevice.h>
+
+extern const struct rnpgbe_info rnpgbe_n500_info;
+extern const struct rnpgbe_info rnpgbe_n210_info;
+extern const struct rnpgbe_info rnpgbe_n210L_info;
 
 enum rnpgbe_boards {
 	board_n500,
@@ -12,15 +17,144 @@ enum rnpgbe_boards {
 	board_n210L,
 };
 
+enum rnpgbe_hw_type {
+	rnpgbe_hw_n500 = 0,
+	rnpgbe_hw_n210,
+	rnpgbe_hw_n210L,
+};
+
+struct mucse_dma_info {
+	u8 __iomem *dma_base_addr;
+	u8 __iomem *dma_ring_addr;
+	void *back;
+	u32 max_tx_queues;
+	u32 max_rx_queues;
+	u32 dma_version;
+};
+
+#define RNPGBE_MAX_MTA 128
+struct mucse_eth_info {
+	u8 __iomem *eth_base_addr;
+	void *back;
+	u32 mta_shadow[RNPGBE_MAX_MTA];
+	s32 mc_filter_type;
+	u32 mcft_size;
+	u32 vft_size;
+	u32 num_rar_entries;
+};
+
+struct mii_regs {
+	unsigned int addr; /* MII Address */
+	unsigned int data; /* MII Data */
+	unsigned int addr_shift; /* MII address shift */
+	unsigned int reg_shift; /* MII reg shift */
+	unsigned int addr_mask; /* MII address mask */
+	unsigned int reg_mask; /* MII reg mask */
+	unsigned int clk_csr_shift;
+	unsigned int clk_csr_mask;
+};
+
+struct mucse_mac_info {
+	u8 __iomem *mac_addr;
+	void *back;
+	struct mii_regs mii;
+	int phy_addr;
+	int clk_csr;
+	u8 addr[ETH_ALEN];
+	u8 perm_addr[ETH_ALEN];
+};
+
+#define MAX_VF_NUM (8)
+
+struct mucse_mbx_info {
+	u32 timeout;
+	u32 usec_delay;
+	u32 v2p_mailbox;
+	u16 size;
+	u16 vf_req[MAX_VF_NUM];
+	u16 vf_ack[MAX_VF_NUM];
+	u16 cpu_req;
+	u16 cpu_ack;
+	/* lock for only one user */
+	struct mutex lock;
+	bool other_irq_enabled;
+	int mbx_size;
+	int mbx_mem_size;
+#define MBX_FEATURE_NO_ZERO BIT(0)
+#define MBX_FEATURE_WRITE_DELAY BIT(1)
+	u32 mbx_feature;
+	/* cm3 <-> pf mbx */
+	u32 cpu_pf_shm_base;
+	u32 pf2cpu_mbox_ctrl;
+	u32 pf2cpu_mbox_mask;
+	u32 cpu_pf_mbox_mask;
+	u32 cpu2pf_mbox_vec;
+	/* pf <--> vf mbx */
+	u32 pf_vf_shm_base;
+	u32 pf2vf_mbox_ctrl_base;
+	u32 pf_vf_mbox_mask_lo;
+	u32 pf_vf_mbox_mask_hi;
+	u32 pf2vf_mbox_vec_base;
+	u32 vf2pf_mbox_vec_base;
+	u32 cpu_vf_share_ram;
+	int share_size;
+};
+
+struct mucse_hw {
+	void *back;
+	u8 pfvfnum;
+	u8 pfvfnum_system;
+	u8 __iomem *hw_addr;
+	u8 __iomem *ring_msix_base;
+	struct pci_dev *pdev;
+	u16 device_id;
+	u16 vendor_id;
+	u16 subsystem_device_id;
+	u16 subsystem_vendor_id;
+	enum rnpgbe_hw_type hw_type;
+	struct mucse_dma_info dma;
+	struct mucse_eth_info eth;
+	struct mucse_mac_info mac;
+	struct mucse_mbx_info mbx;
+#define M_NET_FEATURE_SG ((u32)(1 << 0))
+#define M_NET_FEATURE_TX_CHECKSUM ((u32)(1 << 1))
+#define M_NET_FEATURE_RX_CHECKSUM ((u32)(1 << 2))
+#define M_NET_FEATURE_TSO ((u32)(1 << 3))
+#define M_NET_FEATURE_TX_UDP_TUNNEL ((u32)(1 << 4))
+#define M_NET_FEATURE_VLAN_FILTER ((u32)(1 << 5))
+#define M_NET_FEATURE_VLAN_OFFLOAD ((u32)(1 << 6))
+#define M_NET_FEATURE_RX_NTUPLE_FILTER ((u32)(1 << 7))
+#define M_NET_FEATURE_TCAM ((u32)(1 << 8))
+#define M_NET_FEATURE_RX_HASH ((u32)(1 << 9))
+#define M_NET_FEATURE_RX_FCS ((u32)(1 << 10))
+#define M_NET_FEATURE_HW_TC ((u32)(1 << 11))
+#define M_NET_FEATURE_USO ((u32)(1 << 12))
+#define M_NET_FEATURE_STAG_FILTER ((u32)(1 << 13))
+#define M_NET_FEATURE_STAG_OFFLOAD ((u32)(1 << 14))
+#define M_NET_FEATURE_VF_FIXED ((u32)(1 << 15))
+#define M_VEB_VLAN_MASK_EN ((u32)(1 << 16))
+#define M_HW_FEATURE_EEE ((u32)(1 << 17))
+#define M_HW_SOFT_MASK_OTHER_IRQ ((u32)(1 << 18))
+	u32 feature_flags;
+	u16 usecstocount;
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
+	struct mucse_hw hw;
 	/* board number */
 	u16 bd_number;
 
 	char name[60];
 };
 
+struct rnpgbe_info {
+	int total_queue_pair_cnts;
+	enum rnpgbe_hw_type hw_type;
+	void (*get_invariants)(struct mucse_hw *hw);
+};
+
 /* Device IDs */
 #ifndef PCI_VENDOR_ID_MUCSE
 #define PCI_VENDOR_ID_MUCSE 0x8848
@@ -32,4 +166,7 @@ struct mucse {
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
 
+#define rnpgbe_rd_reg(reg) readl((void *)(reg))
+#define rnpgbe_wr_reg(reg, val) writel((val), (void *)(reg))
+
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..5580298eabb6
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_hw.h"
+
+/**
+ * rnpgbe_get_invariants_n500 - setup for hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_get_invariants_n500 initializes all private
+ * structure, such as dma, eth, mac and mbx base on
+ * hw->addr
+ *
+ **/
+static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	struct mucse_eth_info *eth = &hw->eth;
+	struct mucse_mac_info *mac = &hw->mac;
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	/* setup msix base */
+	hw->ring_msix_base = hw->hw_addr + 0x28700;
+	/* setup dma info */
+	dma->dma_base_addr = hw->hw_addr;
+	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
+	dma->max_tx_queues = RNPGBE_MAX_QUEUES;
+	dma->max_rx_queues = RNPGBE_MAX_QUEUES;
+	dma->back = hw;
+	/* setup eth info */
+	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
+	eth->back = hw;
+	eth->mc_filter_type = 0;
+	eth->mcft_size = RNPGBE_MC_TBL_SIZE;
+	eth->vft_size = RNPGBE_VFT_TBL_SIZE;
+	eth->num_rar_entries = RNPGBE_RAR_ENTRIES;
+	/* setup mac info */
+	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
+	mac->back = hw;
+	/* set mac->mii */
+	mac->mii.addr = RNPGBE_MII_ADDR;
+	mac->mii.data = RNPGBE_MII_DATA;
+	mac->mii.addr_shift = 11;
+	mac->mii.addr_mask = 0x0000F800;
+	mac->mii.reg_shift = 6;
+	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.clk_csr_shift = 2;
+	mac->mii.clk_csr_mask = GENMASK(5, 2);
+	mac->clk_csr = 0x02; /* csr 25M */
+	/* hw fixed phy_addr */
+	mac->phy_addr = 0x11;
+
+	mbx->mbx_feature |= MBX_FEATURE_NO_ZERO;
+	/* mbx offset */
+	mbx->vf2pf_mbox_vec_base = 0x28900;
+	mbx->cpu2pf_mbox_vec = 0x28b00;
+	mbx->pf_vf_shm_base = 0x29000;
+	mbx->mbx_mem_size = 64;
+	mbx->pf2vf_mbox_ctrl_base = 0x2a100;
+	mbx->pf_vf_mbox_mask_lo = 0x2a200;
+	mbx->pf_vf_mbox_mask_hi = 0;
+	mbx->cpu_pf_shm_base = 0x2d000;
+	mbx->pf2cpu_mbox_ctrl = 0x2e000;
+	mbx->cpu_pf_mbox_mask = 0x2e200;
+	mbx->cpu_vf_share_ram = 0x2b000;
+	mbx->share_size = 512;
+
+	/* setup net feature here */
+	hw->feature_flags |=
+		M_NET_FEATURE_SG | M_NET_FEATURE_TX_CHECKSUM |
+		M_NET_FEATURE_RX_CHECKSUM | M_NET_FEATURE_TSO |
+		M_NET_FEATURE_VLAN_FILTER | M_NET_FEATURE_VLAN_OFFLOAD |
+		M_NET_FEATURE_RX_NTUPLE_FILTER | M_NET_FEATURE_RX_HASH |
+		M_NET_FEATURE_USO | M_NET_FEATURE_RX_FCS |
+		M_NET_FEATURE_STAG_FILTER | M_NET_FEATURE_STAG_OFFLOAD;
+	/* start the default ahz, update later*/
+	hw->usecstocount = 125;
+}
+
+static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	/* get invariants based from n500 */
+	rnpgbe_get_invariants_n500(hw);
+
+	/* update msix base */
+	hw->ring_msix_base = hw->hw_addr + 0x29000;
+	/* update mbx offset */
+	mbx->vf2pf_mbox_vec_base = 0x29200;
+	mbx->cpu2pf_mbox_vec = 0x29400;
+	mbx->pf_vf_shm_base = 0x29900;
+	mbx->mbx_mem_size = 64;
+	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
+	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
+	mbx->pf_vf_mbox_mask_hi = 0;
+	mbx->cpu_pf_shm_base = 0x2d900;
+	mbx->pf2cpu_mbox_ctrl = 0x2e900;
+	mbx->cpu_pf_mbox_mask = 0x2eb00;
+	mbx->cpu_vf_share_ram = 0x2b900;
+	mbx->share_size = 512;
+	/* update hw feature */
+	hw->feature_flags |= M_HW_FEATURE_EEE;
+	hw->usecstocount = 62;
+}
+
+const struct rnpgbe_info rnpgbe_n500_info = {
+	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
+	.hw_type = rnpgbe_hw_n500,
+	.get_invariants = &rnpgbe_get_invariants_n500,
+};
+
+const struct rnpgbe_info rnpgbe_n210_info = {
+	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
+	.hw_type = rnpgbe_hw_n210,
+	.get_invariants = &rnpgbe_get_invariants_n210,
+};
+
+const struct rnpgbe_info rnpgbe_n210L_info = {
+	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
+	.hw_type = rnpgbe_hw_n210L,
+	.get_invariants = &rnpgbe_get_invariants_n210,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
new file mode 100644
index 000000000000..2c7372a5e88d
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_HW_H
+#define _RNPGBE_HW_H
+/*                     BAR                   */
+/* ----------------------------------------- */
+/*      module  | size  |  start   |    end  */
+/*      DMA     | 32KB  | 0_0000H  | 0_7FFFH */
+/*      ETH     | 64KB  | 1_0000H  | 1_FFFFH */
+/*      MAC     | 32KB  | 2_0000H  | 2_7FFFH */
+/*      MSIX    | 32KB  | 2_8000H  | 2_FFFFH */
+
+#define RNPGBE_RING_BASE (0x1000)
+#define RNPGBE_MAC_BASE (0x20000)
+#define RNPGBE_ETH_BASE (0x10000)
+/* chip resourse */
+#define RNPGBE_MAX_QUEUES (8)
+/* multicast control table */
+#define RNPGBE_MC_TBL_SIZE (128)
+/* vlan filter table */
+#define RNPGBE_VFT_TBL_SIZE (128)
+#define RNPGBE_RAR_ENTRIES (32)
+
+#define RNPGBE_MII_ADDR 0x00000010 /* MII Address */
+#define RNPGBE_MII_DATA 0x00000014 /* MII Data */
+#endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index b32b70c98b46..30c5a4874929 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -17,6 +17,11 @@ static const char rnpgbe_driver_string[] =
 const char rnpgbe_driver_version[] = DRV_VERSION;
 static const char rnpgbe_copyright[] =
 	"Copyright (c) 2020-2025 mucse Corporation.";
+static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
+	[board_n500] = &rnpgbe_n500_info,
+	[board_n210] = &rnpgbe_n210_info,
+	[board_n210L] = &rnpgbe_n210L_info,
+};
 
 /* rnpgbe_pci_tbl - PCI Device ID Table
  *
@@ -36,9 +41,24 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * init_firmware_for_n210 - download firmware
+ * @hw: hardware structure
+ *
+ * init_firmware_for_n210 try to download firmware
+ * for n210, by bar0(hw->hw_addr).
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int init_firmware_for_n210(struct mucse_hw *hw)
+{
+	return 0;
+}
+
 /**
  * rnpgbe_add_adpater - add netdev for this pci_dev
  * @pdev: PCI device information structure
+ * @ii: chip info structure
  *
  * rnpgbe_add_adpater initializes a netdev for this pci_dev
  * structure. Initializes Bar map, private structure, and a
@@ -46,17 +66,24 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  *
  * Returns 0 on success, negative on failure
  **/
-static int rnpgbe_add_adpater(struct pci_dev *pdev)
+static int rnpgbe_add_adpater(struct pci_dev *pdev,
+			      const struct rnpgbe_info *ii)
 {
+	int err = 0;
 	struct mucse *mucse = NULL;
 	struct net_device *netdev;
+	struct mucse_hw *hw = NULL;
+	u8 __iomem *hw_addr = NULL;
+	u32 dma_version = 0;
 	static int bd_number;
+	u32 queues = ii->total_queue_pair_cnts;
 
-	pr_info("====  add rnpgbe queues:%d ====", RNPGBE_MAX_QUEUES);
-	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
+	pr_info("====  add rnpgbe queues:%d ====", queues);
+	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
 	if (!netdev)
 		return -ENOMEM;
 
+	SET_NETDEV_DEV(netdev, &pdev->dev);
 	mucse = netdev_priv(netdev);
 	memset((char *)mucse, 0x00, sizeof(struct mucse));
 	mucse->netdev = netdev;
@@ -66,7 +93,54 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev)
 		 rnpgbe_driver_name, mucse->bd_number);
 	pci_set_drvdata(pdev, mucse);
 
+	hw = &mucse->hw;
+	hw->back = mucse;
+	hw->hw_type = ii->hw_type;
+
+	switch (hw->hw_type) {
+	case rnpgbe_hw_n500:
+		/* n500 use bar2 */
+		hw_addr = devm_ioremap(&pdev->dev,
+				       pci_resource_start(pdev, 2),
+				       pci_resource_len(pdev, 2));
+		if (!hw_addr) {
+			dev_err(&pdev->dev, "map bar2 failed!\n");
+			return -EIO;
+		}
+
+		/* get dma version */
+		dma_version = rnpgbe_rd_reg(hw_addr);
+		break;
+	case rnpgbe_hw_n210:
+	case rnpgbe_hw_n210L:
+		/* check bar0 to load firmware */
+		if (pci_resource_len(pdev, 0) == 0x100000)
+			return init_firmware_for_n210(hw);
+		/* n210 use bar2 */
+		hw_addr = devm_ioremap(&pdev->dev,
+				       pci_resource_start(pdev, 2),
+				       pci_resource_len(pdev, 2));
+		if (!hw_addr) {
+			dev_err(&pdev->dev, "map bar2 failed!\n");
+			return -EIO;
+		}
+
+		/* get dma version */
+		dma_version = rnpgbe_rd_reg(hw_addr);
+		break;
+	default:
+		err = -EIO;
+		goto err_free_net;
+	}
+	hw->hw_addr = hw_addr;
+	hw->dma.dma_version = dma_version;
+	ii->get_invariants(hw);
+
 	return 0;
+
+err_free_net:
+	free_netdev(netdev);
+	return err;
 }
 
 /**
@@ -83,6 +157,7 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev)
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int err;
+	const struct rnpgbe_info *ii = rnpgbe_info_tbl[id->driver_data];
 
 	err = pci_enable_device_mem(pdev);
 	if (err)
@@ -105,7 +180,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 	pci_save_state(pdev);
-	err = rnpgbe_add_adpater(pdev);
+	err = rnpgbe_add_adpater(pdev, ii);
 	if (err)
 		goto err_regions;
 
-- 
2.25.1


