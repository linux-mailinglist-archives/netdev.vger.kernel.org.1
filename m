Return-Path: <netdev+bounces-208580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9646BB0C33C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038401AA2686
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD622BD00E;
	Mon, 21 Jul 2025 11:35:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FC286428;
	Mon, 21 Jul 2025 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097727; cv=none; b=jDMRFvwfebO4ynsFN0AGxhMHwI+0AsgNTq65w3Akh1ZX3TT7aZWM9k1WXR1c5Jnjv+y8UE6MvQGbb3ePb9HDpZUL8GUh1C45gewR9ARkvfMwE147w/76XTu7SVwxN/3MuDuCup/+WwptpKc6HTjR6bC+2GEdoAOTl88tCMah23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097727; c=relaxed/simple;
	bh=3ppbU385kv4dMLin4tXAbzHF/eUk0BVL9kfaoRcEd90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vu+YapmywEeC8QDqjizoziF9MG+IM7HCdj/BWADX4p0jqQBybF0oymlyNYOBPGGdur46zzKGla5RUo9ohVa8ssJx7I+ktyJbkQJPECIoNAr2LF4pGiG0NkVS/JLltVRrYJGoFUiJxWpRP+IQkrgAp/hXHc+lejNV6jJgv0vWLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097613tee8949d2
X-QQ-Originating-IP: o2F7LuSDoKtCINTvrYFk/JlyXSGtMaZlaGzwQFNRPdI=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9302093029296525975
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
Subject: [PATCH v2 10/15] net: rnpgbe: Add netdev irq in open
Date: Mon, 21 Jul 2025 19:32:33 +0800
Message-Id: <20250721113238.18615-11-dong100@mucse.com>
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
X-QQ-XMAILINFO: NR3PJyWXADsZT4eMNHN8tADFwOpggqIoU3709z2lOc5DGQwKiVeFikUF
	6VgaaHcL02EMvoUkL29B0YOhe1UqxT26SVLZZWlFYQ/dTCJARnNdKw4GbtpbnmFm3ImP5Ai
	94NLWDhI05Yat5fH93AKxlhL/R+mZyVjYtY6f9iPYi9aeK7lP/ferpwwLQoU2U7ESiQbmOz
	peP38zR/VBWyLHzKHeUKqWZUgzC3BMyketPeUrLib/wc1l+BjRPeyNlPjB3zE4C9FyB4K4t
	5jsNrNGDTTbV+78zT7QJPRb14cScDSlhEyqNYk5LnlXm4atFa201tbYw7aASANAgPi5uJ4W
	jAhJE1NRtT1ICnq5MVfPMIUriflz3Rj9YSgEs0g8IueMJbkqJI9U7Cit4Hk2/B5QTQqRivD
	8vmGgWoABIh0PUGthpQWPVXytP3/iMa4CmI9Dcy9rNVbUOt0OlzAMjogchkX0oHOAilay2z
	EBMmk+c6U5ixNjzV58v7qDmP6NOaZHMlNkn3410cuLCz2RsdLoFtouaLt5uOZlsgwzjVdqh
	JBOPXQPH8aCLPMbnnc4xAxX/j+tNn6Rd1XRs4VsAWpRwuVZh5UqOcZdjVHo/uoev9bR/nRV
	dfuVHVx3rDu4flNGh+EAwil+cyw+YAF5AactGy6lFoI1MdW41E4ot+S+avfkp6qxSa02VTV
	8BbwZstnuLIu9aDIMlhDVMBacdigueQVPhyksvakVeR4tj52VJH04eN6DyDUlvy+h/YmcCG
	0JO3vnNTJfHnI3xmRAF6hjuf+AzwNji3KbNjXS24DQJ3K3HgrJ2Lh+MYEZjFXkYpcrKsSRw
	J30YNq1yoApVtUfgeH/ZgC4FFctLrILyQCPKlMNi/Cn01X12E7UfKII5f6PgUGY/96RzuDE
	IN7tM1THZ7dgW+yPzOxddd6W7SvxwRR4BSj2G4zGiVufIAV0rSBlRsF9MATH2OeehZPzHGf
	iHk7/eHWkueesdrDErQ8xYYYv9TFNSLi7+yLK2SL5sKn4LHSlUdWYvtx41Q2hNepcGEPSvx
	8J4uTWxCHUlmIuM5/DYoT81H5WHBFcSDpOGSB/i+EM0LzznIlJZyXC8AFmgHs=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Initialize irq for tx/rx in open func.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  14 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  81 +++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  11 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 280 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  30 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  36 ++-
 6 files changed, 450 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index cb0d73589687..23fb93157b98 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -67,7 +67,14 @@ struct mii_regs {
 	unsigned int clk_csr_mask;
 };
 
+struct mucse_mac_info;
+
+struct mucse_mac_operations {
+	void (*set_mac)(struct mucse_mac_info *mac, u8 *addr, int index);
+};
+
 struct mucse_mac_info {
+	struct mucse_mac_operations ops;
 	u8 __iomem *mac_addr;
 	void *back;
 	struct mii_regs mii;
@@ -174,6 +181,9 @@ struct mucse_hw_operations {
 	void (*init_rx_addrs)(struct mucse_hw *hw);
 	/* ops to fw */
 	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+	void (*update_hw_info)(struct mucse_hw *hw);
+	void (*set_mac)(struct mucse_hw *hw, u8 *mac);
+	void (*set_irq_mode)(struct mucse_hw *hw, bool legacy);
 };
 
 enum {
@@ -603,6 +613,10 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 #define dma_rd32(dma, reg) m_rd_reg((dma)->dma_base_addr + (reg))
 #define eth_wr32(eth, reg, val) m_wr_reg((eth)->eth_base_addr + (reg), (val))
 #define eth_rd32(eth, reg) m_rd_reg((eth)->eth_base_addr + (reg))
+#define mac_wr32(mac, reg, val) m_wr_reg((mac)->mac_addr + (reg), (val))
+#define mac_rd32(mac, reg) m_rd_reg((mac)->mac_addr + (reg))
+#define ring_wr32(eth, reg, val) m_wr_reg((eth)->ring_addr + (reg), (val))
+#define ring_rd32(eth, reg) m_rd_reg((eth)->ring_addr + (reg))
 
 #define mucse_err(mucse, fmt, arg...) \
 	dev_err(&(mucse)->pdev->dev, fmt, ##arg)
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index fa8317ae7642..266dc95c4ff2 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -91,6 +91,30 @@ static struct mucse_eth_operations eth_ops_n500 = {
 	.clr_mc_addr = &rnpgbe_eth_clr_mc_addr_n500
 };
 
+/**
+ * rnpgbe_mac_set_mac_n500 - Setup mac address to mac module in hw
+ * @mac: pointer to mac structure
+ * @addr: pointer to addr
+ * @index: Receive address register to write
+ *
+ * Setup a mac address to mac module.
+ **/
+static void rnpgbe_mac_set_mac_n500(struct mucse_mac_info *mac,
+				    u8 *addr, int index)
+{
+	u32 rar_low, rar_high = 0;
+
+	rar_low = ((u32)addr[0] | ((u32)addr[1] << 8) |
+		  ((u32)addr[2] << 16) | ((u32)addr[3] << 24));
+	rar_high = M_RAH_AV | ((u32)addr[4] | (u32)addr[5] << 8);
+	mac_wr32(mac, RNPGBE_MAC_UNICAST_HIGH(index), rar_high);
+	mac_wr32(mac, RNPGBE_MAC_UNICAST_LOW(index), rar_low);
+}
+
+static struct mucse_mac_operations mac_ops_n500 = {
+	.set_mac = &rnpgbe_mac_set_mac_n500,
+};
+
 /**
  * rnpgbe_init_hw_ops_n500 - Init hardware
  * @hw: hw information structure
@@ -251,12 +275,68 @@ static void rnpgbe_init_rx_addrs_hw_ops_n500(struct mucse_hw *hw)
 	eth->ops.clr_mc_addr(eth);
 }
 
+/**
+ * rnpgbe_set_mac_hw_ops_n500 - Setup mac address to hw
+ * @hw: pointer to hw structure
+ * @mac: pointer to mac addr
+ *
+ * Setup a mac address to hw.
+ **/
+static void rnpgbe_set_mac_hw_ops_n500(struct mucse_hw *hw, u8 *mac)
+{
+	struct mucse_eth_info *eth = &hw->eth;
+	struct mucse_mac_info *mac_info = &hw->mac;
+
+	/* use idx 0 */
+	eth->ops.set_rar(eth, 0, mac);
+	mac_info->ops.set_mac(mac_info, mac, 0);
+}
+
+/**
+ * rnpgbe_update_hw_info_hw_ops_n500 - Update status to hw
+ * @hw: pointer to hw structure
+ *
+ * Setup status info to hw, such as some fifo, en regs.
+ **/
+static void rnpgbe_update_hw_info_hw_ops_n500(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	struct mucse_eth_info *eth = &hw->eth;
+
+	/* 1 enable eth filter */
+	eth_wr32(eth, RNPGBE_HOST_FILTER_EN, 1);
+	/* 2 open redir en */
+	eth_wr32(eth, RNPGBE_REDIR_EN, 1);
+	/* 3 setup tso fifo */
+	dma_wr32(dma, DMA_PKT_FIFO_DATA_PROG_FULL_THRESH, 36);
+}
+
+/**
+ * rnpgbe_set_irq_mode_n500 - Setup hw irq mode
+ * @hw: pointer to hw structure
+ * @legacy: is legacy irq or not
+ *
+ * Setup irq mode to hw.
+ **/
+static void rnpgbe_set_irq_mode_n500(struct mucse_hw *hw, bool legacy)
+{
+	if (legacy) {
+		hw_wr32(hw, RNPGBE_LEGANCY_ENABLE, 1);
+		hw_wr32(hw, RNPGBE_LEGANCY_TIME, 0x200);
+	} else {
+		hw_wr32(hw, RNPGBE_LEGANCY_ENABLE, 1);
+	}
+}
+
 static struct mucse_hw_operations hw_ops_n500 = {
 	.init_hw = &rnpgbe_init_hw_ops_n500,
 	.reset_hw = &rnpgbe_reset_hw_ops_n500,
 	.start_hw = &rnpgbe_start_hw_ops_n500,
 	.init_rx_addrs = &rnpgbe_init_rx_addrs_hw_ops_n500,
 	.driver_status = &rnpgbe_driver_status_hw_ops_n500,
+	.set_mac = &rnpgbe_set_mac_hw_ops_n500,
+	.update_hw_info = &rnpgbe_update_hw_info_hw_ops_n500,
+	.set_irq_mode = &rnpgbe_set_irq_mode_n500,
 };
 
 /**
@@ -291,6 +371,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	eth->vft_size = RNPGBE_VFT_TBL_SIZE;
 	eth->num_rar_entries = RNPGBE_RAR_ENTRIES;
 	/* setup mac info */
+	memcpy(&hw->mac.ops, &mac_ops_n500, sizeof(hw->mac.ops));
 	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
 	mac->back = hw;
 	/* set mac->mii */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index bcb4da45feac..98031600801b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -22,9 +22,13 @@
 #define RX_AXI_RW_EN (0x03 << 0)
 #define TX_AXI_RW_EN (0x03 << 2)
 #define RNPGBE_DMA_RX_PROG_FULL_THRESH (0x00a0)
+#define DMA_PKT_FIFO_DATA_PROG_FULL_THRESH (0x0098)
 #define RING_VECTOR(n) (0x04 * (n))
+
 /* eth regs */
 #define RNPGBE_ETH_BYPASS (0x8000)
+#define RNPGBE_HOST_FILTER_EN (0x800c)
+#define RNPGBE_REDIR_EN (0x8030)
 #define RNPGBE_ETH_ERR_MASK_VECTOR (0x8060)
 #define RNPGBE_ETH_DEFAULT_RX_RING (0x806c)
 #define RNPGBE_PKT_LEN_ERR (2)
@@ -35,6 +39,13 @@
 #define RNPGBE_ETH_RAR_RL(n) (0xa000 + 0x04 * (n))
 #define RNPGBE_ETH_RAR_RH(n) (0xa400 + 0x04 * (n))
 #define RNPGBE_ETH_MUTICAST_HASH_TABLE(n) (0xac00 + 0x04 * (n))
+
+#define RNPGBE_LEGANCY_ENABLE (0xd004)
+#define RNPGBE_LEGANCY_TIME (0xd000)
+/* mac regs */
+#define M_RAH_AV 0x80000000
+#define RNPGBE_MAC_UNICAST_LOW(i) (0x44 + (i) * 0x08)
+#define RNPGBE_MAC_UNICAST_HIGH(i) (0x40 + (i) * 0x08)
 /* chip resourse */
 #define RNPGBE_MAX_QUEUES (8)
 /* multicast control table */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index abf3eef3291a..2ba1f5f5aa6c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
 #include <linux/vmalloc.h>
+#include <linux/iopoll.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_lib.h"
@@ -853,3 +854,282 @@ void rnpgbe_free_txrx(struct mucse *mucse)
 	rnpgbe_free_all_tx_resources(mucse);
 	rnpgbe_free_all_rx_resources(mucse);
 }
+
+/**
+ * rnpgbe_configure_tx_ring - Configure Tx ring after Reset
+ * @mucse: pointer to private structure
+ * @ring: structure containing ring specific data
+ *
+ * Configure the Tx descriptor ring after a reset.
+ **/
+static void rnpgbe_configure_tx_ring(struct mucse *mucse,
+				     struct mucse_ring *ring)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 status = 0;
+
+	ring_wr32(ring, DMA_TX_START, 0);
+	ring_wr32(ring, DMA_REG_TX_DESC_BUF_BASE_ADDR_LO, (u32)ring->dma);
+	ring_wr32(ring, DMA_REG_TX_DESC_BUF_BASE_ADDR_HI,
+		  (u32)(((u64)ring->dma) >> 32) | (hw->pfvfnum << 24));
+	ring_wr32(ring, DMA_REG_TX_DESC_BUF_LEN, ring->count);
+	ring->next_to_clean = ring_rd32(ring, DMA_REG_TX_DESC_BUF_HEAD);
+	ring->next_to_use = ring->next_to_clean;
+	ring->tail = ring->ring_addr + DMA_REG_TX_DESC_BUF_TAIL;
+	m_wr_reg(ring->tail, ring->next_to_use);
+	ring_wr32(ring, DMA_REG_TX_DESC_FETCH_CTRL,
+		  (8 << 0) | (TX_DEFAULT_BURST << 16));
+	ring_wr32(ring, DMA_REG_TX_INT_DELAY_TIMER,
+		  mucse->tx_usecs * hw->usecstocount);
+	ring_wr32(ring, DMA_REG_TX_INT_DELAY_PKTCNT, mucse->tx_frames);
+	read_poll_timeout(ring_rd32, status, status == 1,
+			  100, 20000, false, ring, DMA_TX_READY);
+	ring_wr32(ring, DMA_TX_START, 1);
+}
+
+/**
+ * rnpgbe_configure_tx - Configure Transmit Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Tx DMA after a reset.
+ **/
+void rnpgbe_configure_tx(struct mucse *mucse)
+{
+	u32 i;
+
+	/* Setup the HW Tx Head and Tail descriptor pointers */
+	for (i = 0; i < (mucse->num_tx_queues); i++)
+		rnpgbe_configure_tx_ring(mucse, mucse->tx_ring[i]);
+}
+
+/**
+ * rnpgbe_disable_rx_queue - Disable start for ring
+ * @ring: structure containing ring specific data
+ **/
+void rnpgbe_disable_rx_queue(struct mucse_ring *ring)
+{
+	ring_wr32(ring, DMA_RX_START, 0);
+}
+
+/**
+ * rnpgbe_configure_rx_ring - Configure Rx ring after Reset
+ * @mucse: pointer to private structure
+ * @ring: structure containing ring specific data
+ *
+ * Configure the Rx descriptor ring after a reset.
+ **/
+static void rnpgbe_configure_rx_ring(struct mucse *mucse,
+				     struct mucse_ring *ring)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u64 desc_phy = ring->dma;
+	int split_size;
+	/* disable queue to avoid issues while updating state */
+	rnpgbe_disable_rx_queue(ring);
+
+	/* set descripts registers*/
+	ring_wr32(ring, DMA_REG_RX_DESC_BUF_BASE_ADDR_LO, (u32)desc_phy);
+	ring_wr32(ring, DMA_REG_RX_DESC_BUF_BASE_ADDR_HI,
+		  ((u32)(desc_phy >> 32)) | (hw->pfvfnum << 24));
+	ring_wr32(ring, DMA_REG_RX_DESC_BUF_LEN, ring->count);
+	ring->tail = ring->ring_addr + DMA_REG_RX_DESC_BUF_TAIL;
+	ring->next_to_clean = ring_rd32(ring, DMA_REG_RX_DESC_BUF_HEAD);
+	ring->next_to_use = ring->next_to_clean;
+
+	/* we use fixed sg size */
+	split_size = 96;
+	ring_wr32(ring, DMA_REG_RX_SCATTER_LENGTH, split_size);
+	ring_wr32(ring, DMA_REG_RX_DESC_FETCH_CTRL,
+		  0 | (RX_DEFAULT_LINE << 0) |
+		  (RX_DEFAULT_BURST << 16));
+	/* if ncsi card, drop packets if no rx-desc in 100000 clks */
+	if (hw->ncsi_en)
+		ring_wr32(ring, DMA_REG_RX_DESC_TIMEOUT_TH, 100000);
+	else
+		ring_wr32(ring, DMA_REG_RX_DESC_TIMEOUT_TH, 0);
+	ring_wr32(ring, DMA_REG_RX_INT_DELAY_TIMER,
+		  mucse->rx_usecs * hw->usecstocount);
+	ring_wr32(ring, DMA_REG_RX_INT_DELAY_PKTCNT, mucse->rx_frames);
+}
+
+/**
+ * rnpgbe_configure_rx - Configure Receive Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Rx unit of the MAC after a reset.
+ **/
+void rnpgbe_configure_rx(struct mucse *mucse)
+{
+	int i;
+
+	for (i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_configure_rx_ring(mucse, mucse->rx_ring[i]);
+}
+
+/**
+ * rnpgbe_msix_clean_rings - msix irq handler for ring irq
+ * @irq: irq num
+ * @data: private data
+ *
+ * rnpgbe_msix_clean_rings handle irq from ring, start napi
+ **/
+static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
+{
+	return IRQ_HANDLED;
+}
+
+static void rnpgbe_irq_affinity_notify(struct irq_affinity_notify *notify,
+				       const cpumask_t *mask)
+{
+	struct mucse_q_vector *q_vector =
+		container_of(notify, struct mucse_q_vector, affinity_notify);
+
+	cpumask_copy(&q_vector->affinity_mask, mask);
+}
+
+static void rnpgbe_irq_affinity_release(struct kref *ref)
+{
+}
+
+/**
+ * rnpgbe_request_msix_irqs - Initialize MSI-X interrupts
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_request_msix_irqs allocates MSI-X vectors and requests
+ * interrupts from the kernel.
+ **/
+static int rnpgbe_request_msix_irqs(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+	int q_off = mucse->q_vector_off;
+	struct msix_entry *entry;
+	int i = 0;
+	int err;
+
+	for (i = 0; i < mucse->num_q_vectors; i++) {
+		struct mucse_q_vector *q_vector = mucse->q_vector[i];
+
+		entry = &mucse->msix_entries[i + q_off];
+		if (q_vector->tx.ring && q_vector->rx.ring) {
+			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				 "%s-%s-%d", netdev->name, "TxRx", i);
+		} else {
+			/* skip this unused q_vector */
+			continue;
+		}
+		err = request_irq(entry->vector, &rnpgbe_msix_clean_rings, 0,
+				  q_vector->name, q_vector);
+		if (err)
+			goto free_queue_irqs;
+		/* register for affinity change notifications */
+		q_vector->affinity_notify.notify = rnpgbe_irq_affinity_notify;
+		q_vector->affinity_notify.release = rnpgbe_irq_affinity_release;
+		irq_set_affinity_notifier(entry->vector,
+					  &q_vector->affinity_notify);
+		irq_set_affinity_hint(entry->vector, &q_vector->affinity_mask);
+	}
+
+	return 0;
+
+free_queue_irqs:
+	while (i) {
+		i--;
+		entry = &mucse->msix_entries[i + q_off];
+		irq_set_affinity_hint(entry->vector, NULL);
+		free_irq(entry->vector, mucse->q_vector[i]);
+		irq_set_affinity_notifier(entry->vector, NULL);
+		irq_set_affinity_hint(entry->vector, NULL);
+	}
+	return err;
+}
+
+/**
+ * rnpgbe_intr - msi/legacy irq handler
+ * @irq: irq num
+ * @data: private data
+ **/
+static irqreturn_t rnpgbe_intr(int irq, void *data)
+{
+	return IRQ_HANDLED;
+}
+
+/**
+ * rnpgbe_request_irq - initialize interrupts
+ * @mucse: pointer to private structure
+ *
+ * Attempts to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ **/
+int rnpgbe_request_irq(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	int err;
+
+	if (mucse->flags & M_FLAG_MSIX_ENABLED) {
+		err = rnpgbe_request_msix_irqs(mucse);
+		hw->ops.set_irq_mode(hw, 0);
+	} else if (mucse->flags & M_FLAG_MSI_ENABLED) {
+		/* in this case one for all */
+		err = request_irq(mucse->pdev->irq, rnpgbe_intr, 0,
+				  mucse->netdev->name, mucse);
+		mucse->hw.mbx.irq_enabled = true;
+		hw->ops.set_irq_mode(hw, 0);
+	} else {
+		err = request_irq(mucse->pdev->irq, rnpgbe_intr, IRQF_SHARED,
+				  mucse->netdev->name, mucse);
+		hw->ops.set_irq_mode(hw, 1);
+		mucse->hw.mbx.irq_enabled = true;
+	}
+	return err;
+}
+
+/**
+ * rnpgbe_free_msix_irqs - Free MSI-X interrupts
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_free_msix_irqs free MSI-X vectors and requests
+ * interrupts.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_free_msix_irqs(struct mucse *mucse)
+{
+	int q_off = mucse->q_vector_off;
+	struct mucse_q_vector *q_vector;
+	struct msix_entry *entry;
+	int i;
+
+	for (i = 0; i < mucse->num_q_vectors; i++) {
+		q_vector = mucse->q_vector[i];
+		entry = &mucse->msix_entries[i + q_off];
+		/* free only the irqs that were actually requested */
+		if (!q_vector->rx.ring && !q_vector->tx.ring)
+			continue;
+		/* clear the affinity notifier in the IRQ descriptor */
+		irq_set_affinity_notifier(entry->vector, NULL);
+		/* clear the affinity_mask in the IRQ descriptor */
+		irq_set_affinity_hint(entry->vector, NULL);
+		free_irq(entry->vector, q_vector);
+	}
+	return 0;
+}
+
+/**
+ * rnpgbe_free_irq - free interrupts
+ * @mucse: pointer to private structure
+ *
+ * Attempts to free interrupts according initialized type.
+ **/
+void rnpgbe_free_irq(struct mucse *mucse)
+{
+	if (mucse->flags & M_FLAG_MSIX_ENABLED) {
+		rnpgbe_free_msix_irqs(mucse);
+	} else if (mucse->flags & M_FLAG_MSI_ENABLED) {
+		/* in this case one for all */
+		free_irq(mucse->pdev->irq, mucse);
+		mucse->hw.mbx.irq_enabled = false;
+	} else {
+		free_irq(mucse->pdev->irq, mucse);
+		mucse->hw.mbx.irq_enabled = false;
+	}
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 6b2f68320c9e..24859649199f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -16,6 +16,31 @@
 #define RX_INT_MASK (0x01)
 #define DMA_INT_CLR (0x28)
 #define DMA_INT_STAT (0x20)
+#define DMA_REG_RX_DESC_BUF_BASE_ADDR_HI (0x30)
+#define DMA_REG_RX_DESC_BUF_BASE_ADDR_LO (0x34)
+#define DMA_REG_RX_DESC_BUF_LEN (0x38)
+#define DMA_REG_RX_DESC_BUF_HEAD (0x3c)
+#define DMA_REG_RX_DESC_BUF_TAIL (0x40)
+#define DMA_REG_RX_DESC_FETCH_CTRL (0x44)
+#define DMA_REG_RX_INT_DELAY_TIMER (0x48)
+#define DMA_REG_RX_INT_DELAY_PKTCNT (0x4c)
+#define DMA_REG_RX_ARB_DEF_LVL (0x50)
+#define DMA_REG_RX_DESC_TIMEOUT_TH (0x54)
+#define DMA_REG_RX_SCATTER_LENGTH (0x58)
+#define DMA_REG_TX_DESC_BUF_BASE_ADDR_HI (0x60)
+#define DMA_REG_TX_DESC_BUF_BASE_ADDR_LO (0x64)
+#define DMA_REG_TX_DESC_BUF_LEN (0x68)
+#define DMA_REG_TX_DESC_BUF_HEAD (0x6c)
+#define DMA_REG_TX_DESC_BUF_TAIL (0x70)
+#define DMA_REG_TX_DESC_FETCH_CTRL (0x74)
+#define DMA_REG_TX_INT_DELAY_TIMER (0x78)
+#define DMA_REG_TX_INT_DELAY_PKTCNT (0x7c)
+#define DMA_REG_TX_ARB_DEF_LVL (0x80)
+#define DMA_REG_TX_FLOW_CTRL_TH (0x84)
+#define DMA_REG_TX_FLOW_CTRL_TM (0x88)
+#define TX_DEFAULT_BURST (8)
+#define RX_DEFAULT_LINE (32)
+#define RX_DEFAULT_BURST (16)
 
 #define mucse_for_each_ring(pos, head)\
 	for (typeof((head).ring) __pos = (head).ring;\
@@ -26,5 +51,10 @@ int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
 int rnpgbe_setup_txrx(struct mucse *mucse);
 void rnpgbe_free_txrx(struct mucse *mucse);
+void rnpgbe_configure_tx(struct mucse *mucse);
+void rnpgbe_disable_rx_queue(struct mucse_ring *ring);
+void rnpgbe_configure_rx(struct mucse *mucse);
+int rnpgbe_request_irq(struct mucse *mucse);
+void rnpgbe_free_irq(struct mucse *mucse);
 
 #endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 16a111a10862..dc0990daf8b8 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -84,6 +84,22 @@ static void rnpgbe_service_task(struct work_struct *work)
 {
 }
 
+/**
+ * rnpgbe_configure - Configure info to hw
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_configure configure mac, tx, rx regs to hw
+ **/
+static void rnpgbe_configure(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+
+	hw->ops.set_mac(hw, hw->addr);
+	hw->ops.update_hw_info(hw);
+	rnpgbe_configure_tx(mucse);
+	rnpgbe_configure_rx(mucse);
+}
+
 /**
  * rnpgbe_open - Called when a network interface is made active
  * @netdev: network interface device structure
@@ -104,7 +120,20 @@ static int rnpgbe_open(struct net_device *netdev)
 
 	netif_carrier_off(netdev);
 	err = rnpgbe_setup_txrx(mucse);
-
+	rnpgbe_configure(mucse);
+	err = rnpgbe_request_irq(mucse);
+	if (err)
+		goto err_req_irq;
+	err = netif_set_real_num_tx_queues(netdev, mucse->num_tx_queues);
+	if (err)
+		goto err_set_queues;
+	err = netif_set_real_num_rx_queues(netdev, mucse->num_rx_queues);
+	if (err)
+		goto err_set_queues;
+err_req_irq:
+	rnpgbe_free_txrx(mucse);
+err_set_queues:
+	rnpgbe_free_irq(mucse);
 	return err;
 }
 
@@ -121,6 +150,7 @@ static int rnpgbe_close(struct net_device *netdev)
 {
 	struct mucse *mucse = netdev_priv(netdev);
 
+	rnpgbe_free_irq(mucse);
 	rnpgbe_free_txrx(mucse);
 
 	return 0;
@@ -519,8 +549,10 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev,
 	*enable_wake = false;
 	netif_device_detach(netdev);
 	rtnl_lock();
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
+		rnpgbe_free_irq(mucse);
 		rnpgbe_free_txrx(mucse);
+	}
 	rtnl_unlock();
 	remove_mbx_irq(mucse);
 	rnpgbe_clear_interrupt_scheme(mucse);
-- 
2.25.1


