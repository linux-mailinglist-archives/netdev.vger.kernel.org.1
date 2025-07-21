Return-Path: <netdev+bounces-208574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31326B0C320
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7215417A5
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D082BDC14;
	Mon, 21 Jul 2025 11:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A92BDC08;
	Mon, 21 Jul 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097671; cv=none; b=Z/itLDFmrCLhCJcxyfPrz6enaunAn3I1a9+jn7HguQgOL868d+hiJzJDqqtS76FSNYYday8ShE3i3hAkJOi6cZdew8HcUEihj0sD+8fv2e2DJgT0w1ED02X5MjpFCT/KurczfCjZSgsiVExCtptBV+lxC0fZI5+BIhDwkGtUmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097671; c=relaxed/simple;
	bh=kuQzO4zbz5ZmXv8RDEeEJRQKrKDultQcgFVG/92CGQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neh2jCOsDYXXFCvV0EBZ4auch6fz9kBr5sZG6JbpCxbOL9vpseaGtIImfucJ6YbFHCk1ykl+p/yPzKPaDDji1qfYc7PeFjVOtkZnQlRgiSoCpBGaFn/0e3OM6NWPX8a5wGJHINL10IG7TfG+9S3jKuJtMw5mfW0h/BnUHXwcJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097599ta682fe7c
X-QQ-Originating-IP: a/TqDkBFbxG0PO4YmPxED5Chj4UlQylmnz/+/N3xPfE=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5680564977977561247
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
Subject: [PATCH v2 07/15] net: rnpgbe: Add get mac from hw
Date: Mon, 21 Jul 2025 19:32:30 +0800
Message-Id: <20250721113238.18615-8-dong100@mucse.com>
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
X-QQ-XMAILINFO: NxcSjIkI5TJUDMlT3BU4gEOs4H7VowG5Gp9hPe9cbtTlzYB0qMk2ofqY
	0IJMBWIACYnT0Jgpnw5m//ddJQCH/Cj2MY6nbwNuy/Qyk705huRi9c/24QNId1SBY2ijGj/
	bcSbqS9iL+4QsCsM1k8Xyz4+vLF4L/PLPaEhtmk+ouyk9RkF3P0hOqRmAtTzfTuxv3tuSVz
	pbcljfGUsHfQQmwAAXDNzzduQQOYQd1XP3dmq1LCycQHF3c67+08OC8GgnloK9wpQWFBN3p
	0iacu29l893xSZ/rC5mCKfyWfA6MNymHtpINybXDHSPXwJUrloLlYeVZr41Jrr4pOD/KxX+
	0yyQsfuIZHdo59l9nhXF5DlOXMAfiu3IL6w7fLNor5ieR6ttwSzfF9iAIjEGn1JXEtlF5xx
	jz6GAeclDgfatFxxITSXtVC5eTh+AMvuswz2pa8FvMJeiEQ9AjWiojpCYhD0RhS9QQq3JG1
	wdKN3sS+rF62efwM2IDTq20/UW5Tj8l073JpzZmlKwn5p4CIHMzE7z+1nN07iJolVbNJHIX
	jb1Tq6HOI/67IEYGCfv1CuOivOyy/DIw/p5J285LySEPC+lCiT1VMgA3Cez0Fm97rn+n6Es
	sFL3sCQFusvGp450YCCJx2vYb+h0f3OH1isCQsfiuz23BNrC7maQedYFg4/m7wC1Z61lTl3
	kS7wAHUiu86s+lu+PmoU4UjeJjk3DNVAvGT35RyLsY/r2jUKbaJBF1E0QtnD+lYc8gSuLWv
	4X5bwWV6Q1U+T6QoO51HuZ71oJgQtffZA+Cr3QQU7DBIWbbTHIEzlSY3YQ9uf9iLnCYHf7T
	S7xQoO9hRsDQWLh5zo15adjsM0jAXzKXT8yPpPDdCUQa71eFzJ4J49R/9etfuZrDI5aWgKT
	OTV0mSqDbD9XuiCD4jt+FtxmX11yOwqFq3GyOxWYWisZIKVBnHH6ps8veoN74u4uzuM7qsv
	d9HYoNMxav3WE39ptIWOfD7K3y/56FO243R6+g8qJ9mJ+jt4PXd+YCsQ4cA91sMQ/F0vUfl
	Zb5anGn3A7Vod0o8Sh4UE+o/t4VH0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Initialize gets mac function for driver use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  61 ++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 149 ++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   9 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  29 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  63 ++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  17 ++
 6 files changed, 326 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 527091e6a680..30b5400241c3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -34,8 +34,18 @@ struct mucse_dma_info {
 	u32 dma_version;
 };
 
+struct mucse_eth_info;
+
+struct mucse_eth_operations {
+	int (*get_mac_addr)(struct mucse_eth_info *eth, u8 *addr);
+	int (*set_rar)(struct mucse_eth_info *eth, u32 index, u8 *addr);
+	int (*clear_rar)(struct mucse_eth_info *eth, u32 index);
+	void (*clr_mc_addr)(struct mucse_eth_info *eth);
+};
+
 #define RNPGBE_MAX_MTA 128
 struct mucse_eth_info {
+	struct mucse_eth_operations ops;
 	u8 __iomem *eth_base_addr;
 	void *back;
 	u32 mta_shadow[RNPGBE_MAX_MTA];
@@ -64,6 +74,13 @@ struct mucse_mac_info {
 	int clk_csr;
 };
 
+struct mucse_addr_filter_info {
+	u32 num_mc_addrs;
+	u32 rar_used_count;
+	u32 mta_in_use;
+	bool user_set_promisc;
+};
+
 struct mucse_hw;
 
 enum MBX_ID {
@@ -153,6 +170,7 @@ struct mucse_hw_operations {
 	int (*init_hw)(struct mucse_hw *hw);
 	int (*reset_hw)(struct mucse_hw *hw);
 	void (*start_hw)(struct mucse_hw *hw);
+	void (*init_rx_addrs)(struct mucse_hw *hw);
 	/* ops to fw */
 	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
 };
@@ -176,6 +194,10 @@ struct mucse_hw {
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
@@ -209,12 +231,29 @@ struct mucse_hw {
 #define M_VEB_VLAN_MASK_EN BIT(16)
 #define M_HW_FEATURE_EEE BIT(17)
 #define M_HW_SOFT_MASK_OTHER_IRQ BIT(18)
+	struct mucse_addr_filter_info addr_ctrl;
 	u32 feature_flags;
+	u32 flags;
+#define M_FLAGS_INIT_MAC_ADDRESS BIT(27)
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
@@ -224,9 +263,20 @@ struct mucse {
 	struct mucse_hw hw;
 	/* board number */
 	u16 bd_number;
+	u16 tx_work_limit;
 	u32 flags2;
 #define M_FLAG2_NO_NET_REG BIT(0)
-
+	u32 priv_flags;
+#define M_PRIV_FLAG_TX_COALESCE BIT(25)
+#define M_PRIV_FLAG_RX_COALESCE BIT(26)
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
 
@@ -247,6 +297,15 @@ struct rnpgbe_info {
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
 #define m_rd_reg(reg) readl(reg)
 #define m_wr_reg(reg, val) writel((val), reg)
 #define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 7a162b844fe4..fc179eb8c516 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -3,12 +3,94 @@
 
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
+ * rnpgbe_eth_set_rar_n500 puts an ethernet address
+ * into a receive address register.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_eth_set_rar_n500(struct mucse_eth_info *eth,
+				   u32 index, u8 *addr)
+{
+	u32 rar_entries = eth->num_rar_entries;
+	u32 rar_low, rar_high = 0;
+	u32 mcstctrl;
+
+	/* Make sure we are using a valid rar index range */
+	if (index >= rar_entries)
+		return -EINVAL;
+
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
+ * rnpgbe_eth_clear_rar_n500 clears an ethernet address
+ * from a receive address register.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_eth_clear_rar_n500(struct mucse_eth_info *eth,
+				     u32 index)
+{
+	u32 rar_entries = eth->num_rar_entries;
+
+	/* Make sure we are using a valid rar index range */
+	if (index >= rar_entries)
+		return -EINVAL;
+
+	eth_wr32(eth, RNPGBE_ETH_RAR_RL(index), 0);
+	eth_wr32(eth, RNPGBE_ETH_RAR_RH(index), 0);
+
+	return 0;
+}
+
+/**
+ * rnpgbe_eth_clr_mc_addr_n500 - clear all multicast table
+ * @eth: pointer to eth structure
+ **/
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
 /**
  * rnpgbe_init_hw_ops_n500 - Init hardware
  * @hw: hw information structure
@@ -29,6 +111,27 @@ static int rnpgbe_init_hw_ops_n500(struct mucse_hw *hw)
 	return status;
 }
 
+/**
+ * rnpgbe_get_permtion_mac - Get permition mac
+ * @hw: hw information structure
+ * @mac_addr: pointer to store mac
+ *
+ * rnpgbe_get_permtion_mac tries to get mac from hw.
+ * It use eth_random_addr if failed.
+ **/
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
@@ -49,6 +152,13 @@ static int rnpgbe_reset_hw_ops_n500(struct mucse_hw *hw)
 	err = mucse_mbx_fw_reset_phy(hw);
 	if (err)
 		return err;
+	/* Store the permanent mac address */
+	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS)) {
+		rnpgbe_get_permtion_mac(hw, hw->perm_addr);
+		memcpy(hw->addr, hw->perm_addr, ETH_ALEN);
+	}
+
+	hw->ops.init_rx_addrs(hw);
 	eth_wr32(eth, RNPGBE_ETH_ERR_MASK_VECTOR,
 		 RNPGBE_PKT_LEN_ERR | RNPGBE_HDR_LEN_ERR);
 	dma_wr32(dma, RNPGBE_DMA_RX_PROG_FULL_THRESH, 0xa);
@@ -106,10 +216,46 @@ static void rnpgbe_driver_status_hw_ops_n500(struct mucse_hw *hw,
 	}
 }
 
+/**
+ * rnpgbe_init_rx_addrs_hw_ops_n500 - Init rx addr setup to hw
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_rx_addrs_hw_ops_n500 setup hw->addr to hw, it
+ * reset to hw->perm_addr if hw->addr is invalid.
+ **/
+static void rnpgbe_init_rx_addrs_hw_ops_n500(struct mucse_hw *hw)
+{
+	struct mucse_eth_info *eth = &hw->eth;
+	u32 rar_entries;
+	int i;
+	u32 v;
+
+	rar_entries = eth->num_rar_entries;
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
 
@@ -137,6 +283,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	dma->max_rx_queues = RNPGBE_MAX_QUEUES;
 	dma->back = hw;
 	/* setup eth info */
+	memcpy(&hw->eth.ops, &eth_ops_n500, sizeof(hw->eth.ops));
 	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
 	eth->back = hw;
 	eth->mc_filter_type = 0;
@@ -191,6 +338,8 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
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
index ba21e3858c0e..1338ef01f545 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -46,6 +46,27 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_sw_init(struct mucse *mucse)
 {
+	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_hw *hw = &mucse->hw;
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
 
@@ -162,6 +183,14 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_free_net;
 	}
 
+	netdev->min_mtu = hw->min_len_cap;
+	netdev->max_mtu = hw->max_len_cap - (ETH_HLEN + 2 * ETH_FCS_LEN);
+	netdev->features |= NETIF_F_HIGHDMA;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);
+
 	return 0;
 
 err_free_net:
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 18f57ef8b1ad..37ef75121898 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -393,3 +393,66 @@ int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
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
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr,
+			 int nr_lane)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int err = 0;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+
+	if (!mac_addr)
+		return -EINVAL;
+
+	if (hw->mbx.irq_enabled) {
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
index 9e07858f2733..65a4f74c7090 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -632,11 +632,28 @@ static inline void build_reset_phy_req(struct mbx_fw_cmd_req *req,
 	req->cookie = cookie;
 }
 
+static inline void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
+					    int lane_mask, int pfvfnum,
+					    void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le32(GET_MAC_ADDRES);
+	req->datalen = cpu_to_le32(sizeof(req->get_mac_addr));
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	req->get_mac_addr.lane_mask = cpu_to_le32(lane_mask);
+	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
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


