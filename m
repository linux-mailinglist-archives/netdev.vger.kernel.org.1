Return-Path: <netdev+bounces-203579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4BAF6774
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41EE1C44850
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A4230D14;
	Thu,  3 Jul 2025 01:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8CA22B586;
	Thu,  3 Jul 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507484; cv=none; b=QWSOkeSmQrFvIBp5/a3Zixnhd2aPPSSMRDuvotC0rbCaszvc5lPkOaSXFq+mH8lVc3kB2MRJJKpClk9KsmSb/34Gg9tNbQH9RSvQ29vIIp5JNTmPzTZlr8OBy7PwPaWOlsUV61yOvgDvcOOCEsrqJ0RQeBJCBryYZwSceqqf59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507484; c=relaxed/simple;
	bh=9g4GBw6m7mzqCB5Pyr6fGNrygVgMLUzguxIfCWh6rss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1sSyVvrZFnRZk8hf9g7T5Dj+6n0k0256oroVk2LsNrgKzm0pfvOLkDp2EZjoSqj7VtQezFMHj3bbEztH+oCAFvEc8roZh9idWpgJQzw8oII9Y+ZhSB98u51mi6zD9ciiNZc2itMnPAcJJLlRoGtao5uk+7aTBAhXrP9otEdVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507385t818e014a
X-QQ-Originating-IP: 7JeNi3AoQC3CFgZ0kdYBrgsn6pYpinF8HbBya7I4NxU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13769363806065482046
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
Subject: [PATCH 07/15] net: rnpgbe: Add get mac from hw
Date: Thu,  3 Jul 2025 09:48:51 +0800
Message-Id: <20250703014859.210110-8-dong100@mucse.com>
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
X-QQ-XMAILINFO: MIGBBOK2RQC4c3EnJqNhyc0JztNpSaKRIXZMkAyWlR47RR3/F5C+2NK9
	0fSYF+Se9er+GulS5kf65VHbFL7sk2qCqln6c8Fa0FgDfIq9i3kFbCwcujZFiUCcKk10Opd
	Fyk7s1VOoTMHX9Cx+OudQ6dyOfOMyD1jdBlVVgDCD7HE3+NoV/fzuA9hOcBuHE8WP1F+m4K
	f5B6+8Hiyj5DYlMQ0Edw4jnifZFyRMR/4paGJtP6HQHTor1lR2GQkIDbLk+jYQwSsTjE/ZF
	m+uIgmH9+gx/swedeeclZY8fEFuUb7Sn/erNv73uE0doXzaLSRFr65M7VqvFTCRZ26ZsHcA
	zI/YsL7qtR7i8W+3x1BVObA0PgHPhKNyCWNw4wt+lo8r6WSZJEVRvDDa/5Q+VgFEtr5Bjhs
	dYoG3x0W+j1E4EKmDtEW8/4j93rCCE9YaA4XKbY8FRxaFK5hDVzf8TRQg9nhLDDFk5Uyp2l
	fOjHaE55NTpAEm0IjxZAD1KKXJQF3iuK1EwkaBEloL3pdShu1GH5nkMESERsu4LF4QSyVoo
	3ZSQ46Uwhs4Yzwsqg0P1PRG+J627m5LdMTgpArp1EWh8KsgqmWxR8wMdUrvAw7GYlFJpBfj
	/v2Gs6pAkhg7AWeMYpIPOouOd3rCD7lFIAA7TR/HOLVcvTUZZyIow5jxO6FMP9ucEyZgXHm
	SMGUFUJQf6VB3aBO8fjo+KY0Wbpkg/iVMCJKwQA8nXxZM20hf57Jpu0x8WbiHPR2HASLo4H
	5EXaz3Xu1bmNPxgtsvJHrQ4rH8HoNhv8XpZZ0qL9F/VtqJlOy8dLLMjjgzWRYL5BKT0Fkwc
	Mf5g0btlWVGtIHNaHgeHUZ8QPO3gYQfKiR9A/lkfXhGgRnER+UJH0HPgNHVqYFT2dEZt+tV
	nvAI2CebyR3RVTMBwDTCob3nM/MJ+OBaJnIyHshXHF2CaofVcSr2sVt+1WokR1u0IKpUPdB
	v+SZo7otFhyfIDxg+DDZUACqNhr3Om3tcJXv9o6xN6BT53SWBEmn0aZ2ZgL1KQySUIqqj6/
	8NhEJF2A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Initialize gets mac function for driver use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  65 ++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 126 ++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   9 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  30 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  63 +++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  17 +++
 6 files changed, 306 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 17297f9ff9c1..93c3e8f50a80 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -33,8 +33,18 @@ struct mucse_dma_info {
 	u32 dma_version;
 };
 
+struct mucse_eth_info;
+
+struct mucse_eth_operations {
+	s32 (*get_mac_addr)(struct mucse_eth_info *eth, u8 *addr);
+	s32 (*set_rar)(struct mucse_eth_info *eth, u32 index, u8 *addr);
+	s32 (*clear_rar)(struct mucse_eth_info *eth, u32 index);
+	void (*clr_mc_addr)(struct mucse_eth_info *eth);
+};
+
 #define RNPGBE_MAX_MTA 128
 struct mucse_eth_info {
+	struct mucse_eth_operations ops;
 	u8 __iomem *eth_base_addr;
 	void *back;
 	u32 mta_shadow[RNPGBE_MAX_MTA];
@@ -61,8 +71,13 @@ struct mucse_mac_info {
 	struct mii_regs mii;
 	int phy_addr;
 	int clk_csr;
-	u8 addr[ETH_ALEN];
-	u8 perm_addr[ETH_ALEN];
+};
+
+struct mucse_addr_filter_info {
+	u32 num_mc_addrs;
+	u32 rar_used_count;
+	u32 mta_in_use;
+	bool user_set_promisc;
 };
 
 struct mucse_hw;
@@ -154,6 +169,7 @@ struct mucse_hw_operations {
 	int (*init_hw)(struct mucse_hw *hw);
 	int (*reset_hw)(struct mucse_hw *hw);
 	void (*start_hw)(struct mucse_hw *hw);
+	void (*init_rx_addrs)(struct mucse_hw *hw);
 	/* ops to fw */
 	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
 };
@@ -177,6 +193,10 @@ struct mucse_hw {
 	u16 subsystem_vendor_id;
 	u32 wol;
 	u32 wol_en;
+	u16 min_len_cap;
+	u16 max_len_cap;
+	u16 min_len_cur;
+	u16 max_len_cur;
 	u32 fw_version;
 	u32 axi_mhz;
 	u32 bd_uid;
@@ -191,6 +211,7 @@ struct mucse_hw {
 	struct mucse_eth_info eth;
 	struct mucse_mac_info mac;
 	struct mucse_mbx_info mbx;
+	struct mucse_addr_filter_info addr_ctrl;
 #define M_NET_FEATURE_SG ((u32)(1 << 0))
 #define M_NET_FEATURE_TX_CHECKSUM ((u32)(1 << 1))
 #define M_NET_FEATURE_RX_CHECKSUM ((u32)(1 << 2))
@@ -211,11 +232,27 @@ struct mucse_hw {
 #define M_HW_FEATURE_EEE ((u32)(1 << 17))
 #define M_HW_SOFT_MASK_OTHER_IRQ ((u32)(1 << 18))
 	u32 feature_flags;
+	u32 flags;
+#define M_FLAGS_INIT_MAC_ADDRESS ((u32)(1 << 27))
 	u32 driver_version;
 	u16 usecstocount;
+	u16 max_msix_vectors;
 	int nr_lane;
 	struct lldp_status lldp_status;
 	int link;
+	u8 addr[ETH_ALEN];
+	u8 perm_addr[ETH_ALEN];
+};
+
+enum mucse_state_t {
+	__MUCSE_DOWN,
+	__MUCSE_SERVICE_SCHED,
+	__MUCSE_PTP_TX_IN_PROGRESS,
+	__MUCSE_USE_VFINFI,
+	__MUCSE_IN_IRQ,
+	__MUCSE_REMOVE,
+	__MUCSE_SERVICE_CHECK,
+	__MUCSE_EEE_REMOVE,
 };
 
 struct mucse {
@@ -224,9 +261,20 @@ struct mucse {
 	struct mucse_hw hw;
 	/* board number */
 	u16 bd_number;
+	u16 tx_work_limit;
 	u32 flags2;
 #define M_FLAG2_NO_NET_REG ((u32)(1 << 0))
-
+	u32 priv_flags;
+#define M_PRIV_FLAG_TX_COALESCE ((u32)(1 << 25))
+#define M_PRIV_FLAG_RX_COALESCE ((u32)(1 << 26))
+	int tx_ring_item_count;
+	int rx_ring_item_count;
+	int napi_budge;
+	u16 rx_usecs;
+	u16 rx_frames;
+	u16 tx_frames;
+	u16 tx_usecs;
+	unsigned long state;
 	char name[60];
 };
 
@@ -247,6 +295,15 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
 
+#define M_DEFAULT_TXD (512)
+#define M_DEFAULT_TX_WORK (128)
+#define M_PKT_TIMEOUT_TX (200)
+#define M_TX_PKT_POLL_BUDGET (0x30)
+
+#define M_DEFAULT_RXD (512)
+#define M_PKT_TIMEOUT (30)
+#define M_RX_PKT_POLL_BUDGET (64)
+
 #define m_rd_reg(reg) readl((void *)(reg))
 #define m_wr_reg(reg, val) writel((val), (void *)(reg))
 #define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
@@ -261,4 +318,6 @@ struct rnpgbe_info {
 #define mucse_dbg(mucse, fmt, arg...) \
 	dev_dbg(&(mucse)->pdev->dev, fmt, ##arg)
 
+/* error codes */
+#define MUCSE_ERR_INVALID_ARGUMENT (-1)
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index c495a6f79fd0..5b01ecd641f2 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -3,12 +3,88 @@
 
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
 #include "rnpgbe_mbx_fw.h"
 
+/**
+ * rnpgbe_eth_set_rar_n500 - Set Rx address register
+ * @eth: pointer to eth structure
+ * @index: Receive address register to write
+ * @addr: Address to put into receive address register
+ *
+ * Puts an ethernet address into a receive address register.
+ **/
+static s32 rnpgbe_eth_set_rar_n500(struct mucse_eth_info *eth,
+				   u32 index, u8 *addr)
+{
+	u32 mcstctrl;
+	u32 rar_low, rar_high = 0;
+	u32 rar_entries = eth->num_rar_entries;
+
+	/* Make sure we are using a valid rar index range */
+	if (index >= rar_entries)
+		return MUCSE_ERR_INVALID_ARGUMENT;
+
+	/*
+	 * HW expects these in big endian so we reverse the byte
+	 * order from network order (big endian) to little endian
+	 */
+	rar_low = ((u32)addr[5] | ((u32)addr[4] << 8) |
+		   ((u32)addr[3] << 16) |
+		   ((u32)addr[2] << 24));
+	rar_high |= ((u32)addr[1] | ((u32)addr[0] << 8));
+	rar_high |= RNPGBE_RAH_AV;
+
+	eth_wr32(eth, RNPGBE_ETH_RAR_RL(index), rar_low);
+	eth_wr32(eth, RNPGBE_ETH_RAR_RH(index), rar_high);
+	/* open unicast filter */
+	mcstctrl = eth_rd32(eth, RNPGBE_ETH_DMAC_MCSTCTRL);
+	mcstctrl |= RNPGBE_MCSTCTRL_UNICASE_TBL_EN;
+	eth_wr32(eth, RNPGBE_ETH_DMAC_MCSTCTRL, mcstctrl);
+
+	return 0;
+}
+
+/**
+ * rnpgbe_eth_clear_rar_n500 - Remove Rx address register
+ * @eth: pointer to eth structure
+ * @index: Receive address register to write
+ *
+ * Clears an ethernet address from a receive address register.
+ **/
+static s32 rnpgbe_eth_clear_rar_n500(struct mucse_eth_info *eth,
+				     u32 index)
+{
+	u32 rar_entries = eth->num_rar_entries;
+
+	/* Make sure we are using a valid rar index range */
+	if (index >= rar_entries)
+		return MUCSE_ERR_INVALID_ARGUMENT;
+
+	eth_wr32(eth, RNPGBE_ETH_RAR_RL(index), 0);
+	eth_wr32(eth, RNPGBE_ETH_RAR_RH(index), 0);
+
+	return 0;
+}
+
+static void rnpgbe_eth_clr_mc_addr_n500(struct mucse_eth_info *eth)
+{
+	int i;
+
+	for (i = 0; i < eth->mcft_size; i++)
+		eth_wr32(eth, RNPGBE_ETH_MUTICAST_HASH_TABLE(i), 0);
+}
+
+static struct mucse_eth_operations eth_ops_n500 = {
+	.set_rar = &rnpgbe_eth_set_rar_n500,
+	.clear_rar = &rnpgbe_eth_clear_rar_n500,
+	.clr_mc_addr = &rnpgbe_eth_clr_mc_addr_n500
+};
+
 static int rnpgbe_init_hw_ops_n500(struct mucse_hw *hw)
 {
 	int status = 0;
@@ -20,6 +96,19 @@ static int rnpgbe_init_hw_ops_n500(struct mucse_hw *hw)
 	return status;
 }
 
+static void rnpgbe_get_permtion_mac(struct mucse_hw *hw,
+				    u8 *mac_addr)
+{
+	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->nr_lane)) {
+		eth_random_addr(mac_addr);
+	} else {
+		if (!is_valid_ether_addr(mac_addr))
+			eth_random_addr(mac_addr);
+	}
+
+	hw->flags |= M_FLAGS_INIT_MAC_ADDRESS;
+}
+
 /**
  * rnpgbe_reset_hw_ops_n500 - Do a hardware reset
  * @hw: hw information structure
@@ -37,7 +126,13 @@ static int rnpgbe_reset_hw_ops_n500(struct mucse_hw *hw)
 	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
 	if (mucse_mbx_fw_reset_phy(hw))
 		return -EIO;
+	/* Store the permanent mac address */
+	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS)) {
+		rnpgbe_get_permtion_mac(hw, hw->perm_addr);
+		memcpy(hw->addr, hw->perm_addr, ETH_ALEN);
+	}
 
+	hw->ops.init_rx_addrs(hw);
 	eth_wr32(eth, RNPGBE_ETH_ERR_MASK_VECTOR,
 		 RNPGBE_PKT_LEN_ERR | RNPGBE_HDR_LEN_ERR);
 	dma_wr32(dma, RNPGBE_DMA_RX_PROG_FULL_THRESH, 0xa);
@@ -89,10 +184,38 @@ static void rnpgbe_driver_status_hw_ops_n500(struct mucse_hw *hw,
 	}
 }
 
+static void rnpgbe_init_rx_addrs_hw_ops_n500(struct mucse_hw *hw)
+{
+	struct mucse_eth_info *eth = &hw->eth;
+	u32 i;
+	u32 rar_entries = eth->num_rar_entries;
+	u32 v;
+
+	/* hw->addr maybe set by sw */
+	if (!is_valid_ether_addr(hw->addr))
+		memcpy(hw->addr, hw->perm_addr, ETH_ALEN);
+	else
+		eth->ops.set_rar(eth, 0, hw->addr);
+
+	hw->addr_ctrl.rar_used_count = 1;
+	/* Clear other rar addresses. */
+	for (i = 1; i < rar_entries; i++)
+		eth->ops.clear_rar(eth, i);
+
+	/* Clear the MTA */
+	hw->addr_ctrl.mta_in_use = 0;
+	v = eth_rd32(eth, RNPGBE_ETH_DMAC_MCSTCTRL);
+	v &= (~0x3);
+	v |= eth->mc_filter_type;
+	eth_wr32(eth, RNPGBE_ETH_DMAC_MCSTCTRL, v);
+	eth->ops.clr_mc_addr(eth);
+}
+
 static struct mucse_hw_operations hw_ops_n500 = {
 	.init_hw = &rnpgbe_init_hw_ops_n500,
 	.reset_hw = &rnpgbe_reset_hw_ops_n500,
 	.start_hw = &rnpgbe_start_hw_ops_n500,
+	.init_rx_addrs = &rnpgbe_init_rx_addrs_hw_ops_n500,
 	.driver_status = &rnpgbe_driver_status_hw_ops_n500,
 };
 
@@ -121,6 +244,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	dma->max_rx_queues = RNPGBE_MAX_QUEUES;
 	dma->back = hw;
 	/* setup eth info */
+	memcpy(&hw->eth.ops, &eth_ops_n500, sizeof(hw->eth.ops));
 	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
 	eth->back = hw;
 	eth->mc_filter_type = 0;
@@ -170,6 +294,8 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	hw->usecstocount = 125;
 	hw->max_vfs_noari = 1;
 	hw->max_vfs = 7;
+	hw->min_len_cap = RNPGBE_MIN_LEN;
+	hw->max_len_cap = RNPGBE_MAX_LEN;
 	memcpy(&hw->ops, &hw_ops_n500, sizeof(hw->ops));
 }
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 35e3cb77a38b..bcb4da45feac 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -29,6 +29,12 @@
 #define RNPGBE_ETH_DEFAULT_RX_RING (0x806c)
 #define RNPGBE_PKT_LEN_ERR (2)
 #define RNPGBE_HDR_LEN_ERR (1)
+#define RNPGBE_MCSTCTRL_UNICASE_TBL_EN BIT(3)
+#define RNPGBE_ETH_DMAC_MCSTCTRL (0x9114)
+#define RNPGBE_RAH_AV (0x80000000)
+#define RNPGBE_ETH_RAR_RL(n) (0xa000 + 0x04 * (n))
+#define RNPGBE_ETH_RAR_RH(n) (0xa400 + 0x04 * (n))
+#define RNPGBE_ETH_MUTICAST_HASH_TABLE(n) (0xac00 + 0x04 * (n))
 /* chip resourse */
 #define RNPGBE_MAX_QUEUES (8)
 /* multicast control table */
@@ -36,7 +42,8 @@
 /* vlan filter table */
 #define RNPGBE_VFT_TBL_SIZE (128)
 #define RNPGBE_RAR_ENTRIES (32)
-
+#define RNPGBE_MIN_LEN (68)
+#define RNPGBE_MAX_LEN (9722)
 #define RNPGBE_MII_ADDR 0x00000010 /* MII Address */
 #define RNPGBE_MII_DATA 0x00000014 /* MII Data */
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index e811e9624ead..d99da9838e27 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -150,6 +150,27 @@ static int init_firmware_for_n210(struct mucse_hw *hw)
 
 static int rnpgbe_sw_init(struct mucse *mucse)
 {
+	struct mucse_hw *hw = &mucse->hw;
+	struct pci_dev *pdev = mucse->pdev;
+
+	hw->vendor_id = pdev->vendor;
+	hw->device_id = pdev->device;
+	hw->subsystem_vendor_id = pdev->subsystem_vendor;
+	hw->subsystem_device_id = pdev->subsystem_device;
+	mucse->napi_budge = 64;
+	/* set default work limits */
+	mucse->tx_work_limit = M_DEFAULT_TX_WORK;
+	mucse->tx_usecs = M_PKT_TIMEOUT_TX;
+	mucse->tx_frames = M_TX_PKT_POLL_BUDGET;
+	mucse->rx_usecs = M_PKT_TIMEOUT;
+	mucse->rx_frames = M_RX_PKT_POLL_BUDGET;
+	mucse->priv_flags &= ~M_PRIV_FLAG_RX_COALESCE;
+	mucse->priv_flags &= ~M_PRIV_FLAG_TX_COALESCE;
+	/* set default ring sizes */
+	mucse->tx_ring_item_count = M_DEFAULT_TXD;
+	mucse->rx_ring_item_count = M_DEFAULT_RXD;
+	set_bit(__MUCSE_DOWN, &mucse->state);
+
 	return 0;
 }
 
@@ -257,6 +278,15 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 		goto err_free_net;
 	}
 
+	netdev->min_mtu = hw->min_len_cap;
+	netdev->max_mtu = hw->max_len_cap - (ETH_HLEN + 2 * ETH_FCS_LEN);
+	netdev->features |= NETIF_F_HIGHDMA;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
+	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);
+
 	return 0;
 
 err_free_net:
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 8e26ffcabfda..a9c5caa764a0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -348,3 +348,66 @@ int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
 		return mucse_fw_send_cmd_wait(hw, &req, &reply);
 	}
 }
+
+/**
+ * mucse_fw_get_macaddr - Posts a mbx req to request macaddr
+ * @hw: Pointer to the HW structure
+ * @pfvfnum: Index of pf/vf num
+ * @mac_addr: Pointer to store mac_addr
+ * @nr_lane: Lane index
+ *
+ * mucse_fw_get_macaddr posts a mbx req to firmware to get mac_addr.
+ * It uses mucse_fw_send_cmd_wait if no irq, and mucse_mbx_fw_post_req
+ * if other irq is registered.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr,
+			 int nr_lane)
+{
+	int err = 0;
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+
+	if (!mac_addr)
+		return -EINVAL;
+
+	if (hw->mbx.other_irq_enabled) {
+		struct mbx_req_cookie *cookie =
+			mbx_cookie_zalloc(sizeof(reply.mac_addr));
+		struct mac_addr *mac = (struct mac_addr *)cookie->priv;
+
+		if (!cookie)
+			return -ENOMEM;
+
+		build_get_macaddress_req(&req, 1 << nr_lane, pfvfnum, cookie);
+		err = mucse_mbx_fw_post_req(hw, &req, cookie);
+		if (err) {
+			kfree(cookie);
+			goto out;
+		}
+
+		if ((1 << nr_lane) & mac->lanes)
+			memcpy(mac_addr, mac->addrs[nr_lane].mac, ETH_ALEN);
+		else
+			err = -ENODATA;
+
+		kfree(cookie);
+	} else {
+		build_get_macaddress_req(&req, 1 << nr_lane, pfvfnum, &req);
+		err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+		if (err)
+			goto out;
+
+		if ((1 << nr_lane) & reply.mac_addr.lanes)
+			memcpy(mac_addr, reply.mac_addr.addrs[nr_lane].mac, 6);
+		else
+			err = -ENODATA;
+	}
+out:
+	return err;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index 66d8cd02bc0e..babdfc1f56f1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -594,11 +594,28 @@ static inline void build_reset_phy_req(struct mbx_fw_cmd_req *req,
 	req->cookie = cookie;
 }
 
+static inline void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
+					    int lane_mask, int pfvfnum,
+					    void *cookie)
+{
+	req->flags = 0;
+	req->opcode = GET_MAC_ADDRES;
+	req->datalen = sizeof(req->get_mac_addr);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	req->get_mac_addr.lane_mask = lane_mask;
+	req->get_mac_addr.pfvf_num = pfvfnum;
+}
+
 int mucse_mbx_get_capability(struct mucse_hw *hw);
 int rnpgbe_mbx_lldp_get(struct mucse_hw *hw);
 int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status);
 int mucse_mbx_ifsuspuse(struct mucse_hw *hw, int status);
 int mucse_mbx_ifforce_control_mac(struct mucse_hw *hw, int status);
 int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr, int nr_lane);
 
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


