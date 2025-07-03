Return-Path: <netdev+bounces-203584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE4AF6783
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5454E2E39
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F007242D97;
	Thu,  3 Jul 2025 01:52:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA7226D00;
	Thu,  3 Jul 2025 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507520; cv=none; b=Ab/+qoqDphhcs0acbXZIv1hICnOHAdRmh0rJxAAEIm2EAQF3MCF9dYG/sRzN2xcfW2IZ2WpNyR9iprOY8YKyt38jnFG5KmBg+hzwcSR7FHPwkgs86sX2gGME8JY1KPY/pFclfYIiObXkZY43Ld+/H0uET8zxoiadgiy4mExTjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507520; c=relaxed/simple;
	bh=t7l1xHJ2NhriGtQRpiQZC6zLgc52a8TsjZ5vYLMEsxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQOlPf+6ChJjmdUlNx0Z8piZ2ccIeqWKt/2zfTmB3Zi92iqxyK46s2tAtLbBQVlvrQPUVCQp6F5amn3q8Jd8UtmqE2n0nNyPsT5B4sEZvrRUkmaupZYfFC9jlLyUZbLRRJxEHsrb6b3y6/tnbW7QFNShiqEqEmkZinGdmIGlrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507396tbee45c33
X-QQ-Originating-IP: xUSpMF06R0P0r4wNtjiCkARXJ8NrWwSZ5ZtplOE6EPo=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13682066848690000920
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
Subject: [PATCH 10/15] net: rnpgbe: Add netdev irq in open
Date: Thu,  3 Jul 2025 09:48:54 +0800
Message-Id: <20250703014859.210110-11-dong100@mucse.com>
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
X-QQ-XMAILINFO: M87FkSnslKhoTCsVDeCn5GQcQLDpJJUAqc0Ob+x4idRPLZqZhl161j6G
	/GrJSuh51hw3ULDxAbAGtC21uNfMHiQkNQXb/gvXsg/dPRe3dZc94gFfgs+yMFvHK6dkGas
	5MZSh1cgTYGihcD4WCPz2uXNN16MetsOGmKwaFWPHielLQPS08DVWpEQpfWXar4A8HxDPEb
	Vh+AQ1NmW0O8fXyNMly2ddvleREz+qIffnYsa6Nt72NkYW5klCT+ZT5l+oXBxZCtmf2SBoU
	Zk+oqGIWGLCjar35wI6vlKwf8SSDWR6PYQjnus1Yi6ZMcW8P1PKiq/oqk89i2ugAxLZhnkN
	w2cSzEQM/RcuSwmyYl2XtSH2R/37+EYePeBN8RmVZ5Cy/m1v51JEZEkqwJeQBWEg4wd6uT8
	D/u+PqCUupr8TKyUx98U1RIn8VxhsBrpe0A2iZ2nJNlepaYLndb6+blMgb6Q46OYw/Qe2z0
	YVt73fIJZ41ejvv6LoYdSjtDMlumAvO9N5lbsq0KX+a+0fDxocWyfd0sUvUL0qWkyD9xxQU
	RmoRU6PBiTOIvE5FI9++9R4qbdEpXLWBKppTxhjOORNaDCSu1EoHvswDepTPu6ZvKAMpZ7c
	hzmTQ22zF7POcjMNvpVocBbl0fQ7gVm/Q7qWXrhMwLCYAAowGOW2dY9s2CqDIZ0j2iJLdq+
	HzCZO4D5afTgwX9enxLDvlYwwNuJrsCOq4KS2gD+6DpCbkOBdwkjCR/0Vy6HlpoDIQLDLR3
	NZscFeQ1ZbHxj//RMea5OGMeQoodmc8Gm/LiVzwK1IHkCupb5PhoS9tSN53EeJ8UVs3ZhhY
	4unG/NkRKCykZX3taI7MHEBchPqmpl8jzb/LlSBKpBdKEfq6YF/3HQlWS0hMlmAO4lsjD4h
	T42KMWONOawuhJaVxbA19Zhu+fnUIuGgcJC6vKPnfnBC9NpCmL8/MYfXJLsLyJpWLLUC6aU
	QoT3dmNEEMoA48th2BgRdL/oFG2lQQRmgkxcA3AHOqeMzmZlXMG4B4KajzZRg4wt6VTs7BK
	QHAzvinCDbCNSnafkE1ir6Kt/j2Os=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Initialize irq for tx/rx in open func.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  14 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  81 +++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  11 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 307 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  30 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  30 +-
 6 files changed, 471 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index feb74048b9e0..d4e150c14582 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -66,7 +66,14 @@ struct mii_regs {
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
@@ -173,6 +180,9 @@ struct mucse_hw_operations {
 	void (*init_rx_addrs)(struct mucse_hw *hw);
 	/* ops to fw */
 	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+	void (*update_hw_info)(struct mucse_hw *hw);
+	void (*set_mac)(struct mucse_hw *hw, u8 *mac);
+	void (*set_irq_mode)(struct mucse_hw *hw, bool legacy);
 };
 
 enum {
@@ -606,6 +616,10 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
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
index e94a432dd7b6..5ad287e398a7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -71,6 +71,12 @@ static s32 rnpgbe_eth_clear_rar_n500(struct mucse_eth_info *eth,
 	return 0;
 }
 
+/**
+ * rnpgbe_eth_clr_mc_addr_n500 - Clear multicast register
+ * @eth: pointer to eth structure
+ *
+ * Clears all multicast address register.
+ **/
 static void rnpgbe_eth_clr_mc_addr_n500(struct mucse_eth_info *eth)
 {
 	int i;
@@ -85,6 +91,30 @@ static struct mucse_eth_operations eth_ops_n500 = {
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
 static int rnpgbe_init_hw_ops_n500(struct mucse_hw *hw)
 {
 	int status = 0;
@@ -211,12 +241,62 @@ static void rnpgbe_init_rx_addrs_hw_ops_n500(struct mucse_hw *hw)
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
@@ -252,6 +332,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
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
index 0dbb942eb4c7..26fdac7d52a9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -818,3 +818,310 @@ void rnpgbe_free_txrx(struct mucse *mucse)
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
+	int timeout = 0;
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
+	do {
+		status = ring_rd32(ring, DMA_TX_READY);
+		usleep_range(100, 200);
+		timeout++;
+	} while ((status != 1) && (timeout < 100));
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
+void rnpgbe_disable_rx_queue(struct mucse_ring *ring)
+{
+	ring_wr32(ring, DMA_RX_START, 0);
+}
+
+#if (PAGE_SIZE < 8192)
+static inline int rnpgbe_compute_pad(int rx_buf_len)
+{
+	int page_size, pad_size;
+
+	page_size = ALIGN(rx_buf_len, PAGE_SIZE / 2);
+	pad_size = SKB_WITH_OVERHEAD(page_size) - rx_buf_len;
+
+	return pad_size;
+}
+
+static inline int rnpgbe_sg_size(void)
+{
+	int sg_size = SKB_WITH_OVERHEAD(PAGE_SIZE / 2) - NET_SKB_PAD;
+
+	sg_size -= NET_IP_ALIGN;
+	sg_size = ALIGN_DOWN(sg_size, 4);
+
+	return sg_size;
+}
+
+#define SG_SIZE  rnpgbe_sg_size()
+static inline int rnpgbe_skb_pad(void)
+{
+	int rx_buf_len = SG_SIZE;
+
+	return rnpgbe_compute_pad(rx_buf_len);
+}
+
+#define RNP_SKB_PAD rnpgbe_skb_pad()
+static inline unsigned int rnpgbe_rx_offset(void)
+{
+	return RNP_SKB_PAD;
+}
+
+#else /* PAGE_SIZE < 8192 */
+#define RNP_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
+#endif
+
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
+#if (PAGE_SIZE < 8192)
+	split_size = SG_SIZE;
+	split_size = split_size >> 4;
+#else
+	/* we use fixed sg size */
+	split_size = 96;
+#endif
+	ring_wr32(ring, DMA_REG_RX_SCATTER_LENGTH, split_size);
+	ring_wr32(ring, DMA_REG_RX_DESC_FETCH_CTRL,
+		  0 | (RX_DEFAULT_LINE << 0) |
+		  (RX_DEFAULT_BURST << 16));
+	/* if ncsi card ,maybe should setup this */
+	/* drop packets if no rx-desc in 100000 clks, maybe os crash */
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
+ * rnpgbe_configure_rx - Configure 8259x Receive Unit after Reset
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
+	int err;
+	int i = 0;
+	int q_off = mucse->q_vector_off;
+	struct msix_entry *entry;
+
+	for (i = 0; i < mucse->num_q_vectors; i++) {
+		struct mucse_q_vector *q_vector = mucse->q_vector[i];
+
+		entry = &mucse->msix_entries[i + q_off];
+		if (q_vector->tx.ring && q_vector->rx.ring) {
+			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				 "%s-%s-%d-%d", netdev->name, "TxRx", i,
+				 q_vector->v_idx);
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
+	int err;
+	struct mucse_hw *hw = &mucse->hw;
+
+	if (mucse->flags & M_FLAG_MSIX_ENABLED) {
+		pr_info("msix mode is used\n");
+		err = rnpgbe_request_msix_irqs(mucse);
+		hw->ops.set_irq_mode(hw, 0);
+	} else if (mucse->flags & M_FLAG_MSI_ENABLED) {
+		/* in this case one for all */
+		pr_info("msi mode is used\n");
+		err = request_irq(mucse->pdev->irq, rnpgbe_intr, 0,
+				  mucse->netdev->name, mucse);
+		mucse->hw.mbx.irq_enabled = true;
+		hw->ops.set_irq_mode(hw, 0);
+	} else {
+		pr_info("legacy mode is used\n");
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
+ **/
+static int rnpgbe_free_msix_irqs(struct mucse *mucse)
+{
+	int i;
+	int q_off = mucse->q_vector_off;
+	struct msix_entry *entry;
+	struct mucse_q_vector *q_vector;
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
index 150d03f9ada9..818bd0cabe0c 100644
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
 
 #define mucse_for_each_ring(pos, head)  \
 	for (pos = (head).ring; pos; pos = pos->next)
@@ -24,5 +49,10 @@ int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
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
index 95a68b6d08a5..82acf45ad901 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -195,6 +195,16 @@ static int init_firmware_for_n210(struct mucse_hw *hw)
 	return err;
 }
 
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
@@ -215,7 +225,20 @@ static int rnpgbe_open(struct net_device *netdev)
 
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
 
@@ -232,6 +255,7 @@ static int rnpgbe_close(struct net_device *netdev)
 {
 	struct mucse *mucse = netdev_priv(netdev);
 
+	rnpgbe_free_irq(mucse);
 	rnpgbe_free_txrx(mucse);
 
 	return 0;
@@ -582,8 +606,10 @@ static void __rnpgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
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


