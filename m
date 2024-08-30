Return-Path: <netdev+bounces-123677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3296617D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE4CB27EEF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A171AD417;
	Fri, 30 Aug 2024 12:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3A199951;
	Fri, 30 Aug 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020531; cv=none; b=Gelx6AjPPjpwlcaeP7Im9I+VzPtYTAIhmbnv2uhCumomIyxPpQ/zVldAuEzlRqFZGymGvW2PEIEr8u22bLFC3YeOPey2wKZreiJXG80pEdGlxqzbUIAnIZePUukD4HYGcMr7UY1o9S32X+9pwVUamalFDfSIo4zT89j4ZR5A9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020531; c=relaxed/simple;
	bh=vq/JlxLTrmFQE/7H3Zx7sJv5vn3I+9Ex1xDzjbuQk3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqkh7GqSUClkvkTyObxcDL1IHGhwddKOEPEj9mWQoCGPezaWQYTMNzs/ebpNEh16o3w5qMLf6A9/EfNBjZzEYF9RfgA/TIgSJHyFm/hVQuqvcGdVyokml6R1EqfdXGOkcgURCUXU1u8yvPSlpmPHEFUW1yI7xBCs/4UsxcnnHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwHG16Vrtz20n36;
	Fri, 30 Aug 2024 20:17:13 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 86009180041;
	Fri, 30 Aug 2024 20:22:05 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 20:22:04 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <shaojijie@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V6 net-next 06/11] net: hibmcge: Implement .ndo_start_xmit function
Date: Fri, 30 Aug 2024 20:15:59 +0800
Message-ID: <20240830121604.2250904-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240830121604.2250904-1-shaojijie@huawei.com>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Implement .ndo_start_xmit function to fill the information of the packet
to be transmitted into the tx descriptor, and then the hardware will
transmit the packet using the information in the tx descriptor.
In addition, we also implemented the tx_handler function to enable the
tx descriptor to be reused, and .ndo_tx_timeout function to print some
information when the hardware is busy.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v5 -> v6:
  - Remove hbg_txrx_init() from probe path, alloc ring buffer in .ndo_open(),
    and release ring buffer in .ndo_stop(), suggested by Jakub and Andrew.
  v5: https://lore.kernel.org/all/20240827131455.2919051-1-shaojijie@huawei.com/
v4 -> v5:
  - Delete unnecessary semicolon, suggested by Jakub.
  v4: https://lore.kernel.org/all/20240826081258.1881385-1-shaojijie@huawei.com/
RFC v1 -> RFC v2:
  - Use napi_complete_done() to simplify the process, suggested by Joe Damato.
  RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  50 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  18 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |   8 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  54 +++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  19 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 259 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  37 +++
 8 files changed, 444 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index d11ef081f4da..ea72c8abea8d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -14,6 +14,19 @@
 #define HBG_RX_SKIP1			0x00
 #define HBG_RX_SKIP2			0x01
 #define HBG_VECTOR_NUM			4
+#define HBG_PCU_CACHE_LINE_SIZE		32
+#define HBG_TX_TIMEOUT_BUF_LEN		1024
+
+enum hbg_dir {
+	HBG_DIR_TX = 1 << 0,
+	HBG_DIR_RX = 1 << 1,
+	HBG_DIR_TX_RX = HBG_DIR_TX | HBG_DIR_RX,
+};
+
+enum hbg_tx_state {
+	HBG_TX_STATE_COMPLETE = 0, /* clear state, must fix to 0 */
+	HBG_TX_STATE_START,
+};
 
 enum hbg_nic_state {
 	HBG_NIC_STATE_EVENT_HANDLING = 0,
@@ -22,9 +35,45 @@ enum hbg_nic_state {
 
 #define hbg_nic_is_open(priv) test_bit(HBG_NIC_STATE_OPEN, &(priv)->state)
 
+struct hbg_priv;
+struct hbg_ring;
+struct hbg_buffer {
+	u32 state;
+	dma_addr_t state_dma;
+
+	struct sk_buff *skb;
+	dma_addr_t skb_dma;
+	u32 skb_len;
+
+	enum hbg_dir dir;
+	struct hbg_ring *ring;
+	struct hbg_priv *priv;
+};
+
+struct hbg_ring {
+	struct hbg_buffer *queue;
+	dma_addr_t queue_dma;
+
+	union {
+		u32 head;
+		u32 ntc;
+	};
+	union {
+		u32 tail;
+		u32 ntu;
+	};
+	u32 len;
+
+	enum hbg_dir dir;
+	struct hbg_priv *priv;
+	struct napi_struct napi;
+	char *tout_log_buf; /* tx timeout log buffer */
+};
+
 enum hbg_hw_event_type {
 	HBG_HW_EVENT_NONE = 0,
 	HBG_HW_EVENT_INIT, /* driver is loading */
+	HBG_HW_EVENT_RESET,
 };
 
 struct hbg_dev_specs {
@@ -77,6 +126,7 @@ struct hbg_priv {
 	unsigned long state;
 	struct hbg_mac mac;
 	struct hbg_vector vectors;
+	struct hbg_ring tx_ring;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 2154168d4598..a7a193df1ec0 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -67,6 +67,7 @@ static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	if (!is_valid_ether_addr((u8 *)dev_specs->mac_addr.sa_data))
 		return -EADDRNOTAVAIL;
 
+	dev_specs->max_frame_len = HBG_PCU_CACHE_LINE_SIZE + dev_specs->max_mtu;
 	return 0;
 }
 
@@ -165,6 +166,23 @@ void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
 			    HBG_REG_PORT_ENABLE_RX_B, enable);
 }
 
+u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	if (dir & HBG_DIR_TX)
+		return hbg_reg_read_field(priv, HBG_REG_CF_CFF_DATA_NUM_ADDR,
+					  HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M);
+
+	return 0;
+}
+
+void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc)
+{
+	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_0_ADDR, tx_desc->word0);
+	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_1_ADDR, tx_desc->word1);
+	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_2_ADDR, tx_desc->word2);
+	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_3_ADDR, tx_desc->word3);
+}
+
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
 	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 0ce500e907b3..508e41cce41e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -52,5 +52,7 @@ void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable);
 void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable);
 void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr);
+u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
+void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index 0a70853a4928..bf5bfedd8a8c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -13,6 +13,12 @@ static void hbg_irq_handle_err(struct hbg_priv *priv,
 			"receive error interrupt: %s\n", irq_info->name);
 }
 
+static void hbg_irq_handle_tx(struct hbg_priv *priv,
+			      struct hbg_irq_info *irq_info)
+{
+	napi_schedule(&priv->tx_ring.napi);
+}
+
 #define HBG_TXRX_IRQ_I(name, handle) \
 	{#name, HBG_INT_MSK_##name##_B, false, false, 0, handle}
 #define HBG_ERR_IRQ_I(name, need_print) \
@@ -20,7 +26,7 @@ static void hbg_irq_handle_err(struct hbg_priv *priv,
 
 static struct hbg_irq_info hbg_irqs[] = {
 	HBG_TXRX_IRQ_I(RX, NULL),
-	HBG_TXRX_IRQ_I(TX, NULL),
+	HBG_TXRX_IRQ_I(TX, hbg_irq_handle_tx),
 	HBG_ERR_IRQ_I(MAC_MII_FIFO_ERR, true),
 	HBG_ERR_IRQ_I(MAC_PCS_RX_FIFO_ERR, true),
 	HBG_ERR_IRQ_I(MAC_PCS_TX_FIFO_ERR, true),
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index f089ccf02747..49d9dce7e095 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -9,6 +9,9 @@
 #include "hbg_hw.h"
 #include "hbg_irq.h"
 #include "hbg_mdio.h"
+#include "hbg_txrx.h"
+
+static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu);
 
 static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 {
@@ -24,10 +27,15 @@ static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 static int hbg_net_open(struct net_device *dev)
 {
 	struct hbg_priv *priv = netdev_priv(dev);
+	int ret;
 
 	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
 		return 0;
 
+	ret = hbg_txrx_init(priv);
+	if (ret)
+		return ret;
+
 	hbg_all_irq_enable(priv, true);
 	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
 	netif_start_queue(dev);
@@ -36,6 +44,26 @@ static int hbg_net_open(struct net_device *dev)
 	return 0;
 }
 
+/* This function only can be called after hbg_txrx_uninit() */
+static int hbg_hw_txrx_clear(struct hbg_priv *priv)
+{
+	int ret;
+
+	/* After ring buffers have been released,
+	 * do a reset to release hw fifo rx ring buffer
+	 */
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
+	if (ret)
+		return ret;
+
+	/* After reset, regs need to be reconfigured */
+	hbg_hw_init(priv);
+	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(priv->netdev->dev_addr));
+	hbg_change_mtu(priv, priv->netdev->mtu);
+
+	return 0;
+}
+
 static int hbg_net_stop(struct net_device *dev)
 {
 	struct hbg_priv *priv = netdev_priv(dev);
@@ -49,8 +77,8 @@ static int hbg_net_stop(struct net_device *dev)
 	netif_stop_queue(dev);
 	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
 	hbg_all_irq_enable(priv, false);
-
-	return 0;
+	hbg_txrx_uninit(priv);
+	return hbg_hw_txrx_clear(priv);
 }
 
 static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
@@ -92,12 +120,33 @@ static int hbg_net_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+static void hbg_net_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+	struct hbg_ring *ring = &priv->tx_ring;
+	char *buf = ring->tout_log_buf;
+	u32 pos = 0;
+
+	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
+			 "ring used num: %u, fifo used num: %u\n",
+			 hbg_get_queue_used_num(ring),
+			 hbg_hw_get_fifo_used_num(priv, HBG_DIR_TX));
+	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
+			 "ntc: %u, ntu: %u, irq enabled: %u\n",
+			 ring->ntc, ring->ntu,
+			 hbg_hw_irq_is_enabled(priv, HBG_INT_MSK_TX_B));
+
+	netdev_info(dev, "%s", buf);
+}
+
 static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_open		= hbg_net_open,
 	.ndo_stop		= hbg_net_stop,
+	.ndo_start_xmit		= hbg_net_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= hbg_net_set_mac_address,
 	.ndo_change_mtu		= hbg_net_change_mtu,
+	.ndo_tx_timeout		= hbg_net_tx_timeout,
 };
 
 static int hbg_init(struct hbg_priv *priv)
@@ -174,6 +223,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	netdev->watchdog_timeo = 5 * HZ;
 	netdev->max_mtu = priv->dev_specs.max_mtu;
 	netdev->min_mtu = priv->dev_specs.min_mtu;
 	hbg_change_mtu(priv, HBG_DEFAULT_MTU_SIZE);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 63bb1bead8c0..0abfcd84e56b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -80,6 +80,12 @@
 #define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
 #define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
 #define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
+#define HBG_REG_CF_CFF_DATA_NUM_ADDR		(HBG_REG_SGMII_BASE + 0x045C)
+#define HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M	GENMASK(8, 0)
+#define HBG_REG_TX_CFF_ADDR_0_ADDR		(HBG_REG_SGMII_BASE + 0x0488)
+#define HBG_REG_TX_CFF_ADDR_1_ADDR		(HBG_REG_SGMII_BASE + 0x048C)
+#define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
+#define HBG_REG_TX_CFF_ADDR_3_ADDR		(HBG_REG_SGMII_BASE + 0x0494)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
@@ -108,4 +114,17 @@ enum hbg_port_mode {
 	HBG_PORT_MODE_SGMII_1000M = 0x8,
 };
 
+struct hbg_tx_desc {
+	u32 word0;
+	u32 word1;
+	u32 word2; /* pkt_addr */
+	u32 word3; /* clear_addr */
+};
+
+#define HBG_TX_DESC_W0_IP_OFF_M		GENMASK(30, 26)
+#define HBG_TX_DESC_W0_l3_CS_B		BIT(2)
+#define HBG_TX_DESC_W0_WB_B		BIT(1)
+#define HBG_TX_DESC_W0_l4_CS_B		BIT(0)
+#define HBG_TX_DESC_W1_SEND_LEN_M	GENMASK(19, 4)
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
new file mode 100644
index 000000000000..4605bd7201de
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include "hbg_common.h"
+#include "hbg_irq.h"
+#include "hbg_reg.h"
+#include "hbg_txrx.h"
+
+#define netdev_get_tx_ring(netdev)  (&(((struct hbg_priv *)netdev_priv(netdev))->tx_ring))
+
+#define buffer_to_dma_dir(buffer) (((buffer)->dir == HBG_DIR_RX) ? \
+				   DMA_FROM_DEVICE : DMA_TO_DEVICE)
+
+#define hbg_queue_is_full(head, tail, ring) ((head) == ((tail) + 1) % (ring)->len)
+#define hbg_queue_is_empty(head, tail) ((head) == (tail))
+#define hbg_queue_next_prt(p, ring) (((p) + 1) % (ring)->len)
+
+static int hbg_dma_map(struct hbg_buffer *buffer)
+{
+	struct hbg_priv *priv = buffer->priv;
+
+	buffer->skb_dma = dma_map_single(&priv->pdev->dev,
+					 buffer->skb->data, buffer->skb_len,
+					 buffer_to_dma_dir(buffer));
+	if (unlikely(dma_mapping_error(&priv->pdev->dev, buffer->skb_dma)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void hbg_dma_unmap(struct hbg_buffer *buffer)
+{
+	struct hbg_priv *priv = buffer->priv;
+
+	if (unlikely(!buffer->skb_dma))
+		return;
+
+	dma_unmap_single(&priv->pdev->dev, buffer->skb_dma, buffer->skb_len,
+			 buffer_to_dma_dir(buffer));
+	buffer->skb_dma = 0;
+}
+
+static void hbg_init_tx_desc(struct hbg_buffer *buffer,
+			     struct hbg_tx_desc *tx_desc)
+{
+	u32 ip_offset = buffer->skb->network_header - buffer->skb->mac_header;
+	u32 word0 = 0;
+
+	word0 |= FIELD_PREP(HBG_TX_DESC_W0_WB_B, HBG_STATUS_ENABLE);
+	word0 |= FIELD_PREP(HBG_TX_DESC_W0_IP_OFF_M, ip_offset);
+	if (likely(buffer->skb->ip_summed == CHECKSUM_PARTIAL)) {
+		word0 |= FIELD_PREP(HBG_TX_DESC_W0_l3_CS_B, HBG_STATUS_ENABLE);
+		word0 |= FIELD_PREP(HBG_TX_DESC_W0_l4_CS_B, HBG_STATUS_ENABLE);
+	}
+
+	tx_desc->word0 = word0;
+	tx_desc->word1 = FIELD_PREP(HBG_TX_DESC_W1_SEND_LEN_M, buffer->skb->len);
+	tx_desc->word2 = buffer->skb_dma;
+	tx_desc->word3 = buffer->state_dma;
+}
+
+netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
+{
+	struct hbg_ring *ring = netdev_get_tx_ring(net_dev);
+	struct hbg_priv *priv = netdev_priv(net_dev);
+	/* This smp_load_acquire() pairs with smp_store_release() in
+	 * hbg_tx_buffer_recycle() called in tx interrupt handle process.
+	 */
+	u32 ntc = smp_load_acquire(&ring->ntc);
+	struct hbg_buffer *buffer;
+	struct hbg_tx_desc tx_desc;
+	u32 ntu = ring->ntu;
+
+	if (unlikely(!hbg_nic_is_open(priv))) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (unlikely(!skb->len ||
+		     skb->len > hbg_spec_max_frame_len(priv, HBG_DIR_TX))) {
+		dev_kfree_skb_any(skb);
+		net_dev->stats.tx_errors++;
+		return NETDEV_TX_OK;
+	}
+
+	if (unlikely(hbg_queue_is_full(ntc, ntu, ring) ||
+		     hbg_fifo_is_full(ring->priv, ring->dir))) {
+		netif_stop_queue(net_dev);
+		return NETDEV_TX_BUSY;
+	}
+
+	buffer = &ring->queue[ntu];
+	buffer->skb = skb;
+	buffer->skb_len = skb->len;
+	if (unlikely(hbg_dma_map(buffer))) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	buffer->state = HBG_TX_STATE_START;
+	hbg_init_tx_desc(buffer, &tx_desc);
+	hbg_hw_set_tx_desc(priv, &tx_desc);
+
+	/* This smp_store_release() pairs with smp_load_acquire() in
+	 * hbg_tx_buffer_recycle() called in tx interrupt handle process.
+	 */
+	smp_store_release(&ring->ntu, hbg_queue_next_prt(ntu, ring));
+	net_dev->stats.tx_bytes += skb->len;
+	net_dev->stats.tx_packets++;
+	return NETDEV_TX_OK;
+}
+
+static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
+{
+	if (unlikely(!buffer->skb))
+		return;
+
+	dev_kfree_skb_any(buffer->skb);
+	buffer->skb = NULL;
+}
+
+static void hbg_buffer_free(struct hbg_buffer *buffer)
+{
+	hbg_dma_unmap(buffer);
+	hbg_buffer_free_skb(buffer);
+}
+
+static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
+{
+	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
+	/* This smp_load_acquire() pairs with smp_store_release() in
+	 * hbg_start_xmit() called in xmit process.
+	 */
+	u32 ntu = smp_load_acquire(&ring->ntu);
+	struct hbg_priv *priv = ring->priv;
+	struct hbg_buffer *buffer;
+	u32 ntc = ring->ntc;
+	int packet_done = 0;
+
+	while (packet_done < budget) {
+		if (unlikely(hbg_queue_is_empty(ntc, ntu)))
+			break;
+
+		/* make sure HW write desc complete */
+		dma_rmb();
+
+		buffer = &ring->queue[ntc];
+		if (buffer->state != HBG_TX_STATE_COMPLETE)
+			break;
+
+		hbg_buffer_free(buffer);
+		ntc = hbg_queue_next_prt(ntc, ring);
+		packet_done++;
+	}
+
+	/* This smp_store_release() pairs with smp_load_acquire() in
+	 * hbg_start_xmit() called in xmit process.
+	 */
+	smp_store_release(&ring->ntc, ntc);
+	netif_wake_queue(priv->netdev);
+
+	if (likely(napi_complete_done(napi, packet_done)))
+		hbg_hw_irq_enable(priv, HBG_INT_MSK_TX_B, true);
+
+	return packet_done;
+}
+
+static void hbg_ring_uninit(struct hbg_ring *ring)
+{
+	struct hbg_buffer *buffer;
+	u32 i;
+
+	if (!ring->queue)
+		return;
+
+	napi_disable(&ring->napi);
+	netif_napi_del(&ring->napi);
+
+	for (i = 0; i < ring->len; i++) {
+		buffer = &ring->queue[i];
+		hbg_buffer_free(buffer);
+		buffer->ring = NULL;
+		buffer->priv = NULL;
+	}
+
+	dma_free_coherent(&ring->priv->pdev->dev,
+			  ring->len * sizeof(*ring->queue),
+			  ring->queue, ring->queue_dma);
+	ring->queue = NULL;
+	ring->queue_dma = 0;
+	ring->len = 0;
+	ring->priv = NULL;
+}
+
+static int hbg_ring_init(struct hbg_priv *priv, struct hbg_ring *ring,
+			 int (*napi_poll)(struct napi_struct *, int),
+			 enum hbg_dir dir)
+{
+	struct hbg_buffer *buffer;
+	u32 i, len;
+
+	len = hbg_get_spec_fifo_max_num(priv, dir) + 1;
+	ring->queue = dma_alloc_coherent(&priv->pdev->dev,
+					 len * sizeof(*ring->queue),
+					 &ring->queue_dma, GFP_KERNEL);
+	if (!ring->queue)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		buffer = &ring->queue[i];
+		buffer->skb_len = 0;
+		buffer->dir = dir;
+		buffer->ring = ring;
+		buffer->priv = priv;
+		buffer->state_dma = ring->queue_dma + (i * sizeof(*buffer));
+	}
+
+	ring->dir = dir;
+	ring->priv = priv;
+	ring->ntc = 0;
+	ring->ntu = 0;
+	ring->len = len;
+
+	netif_napi_add_tx(priv->netdev, &ring->napi, napi_poll);
+	napi_enable(&ring->napi);
+	return 0;
+}
+
+static int hbg_tx_ring_init(struct hbg_priv *priv)
+{
+	struct hbg_ring *tx_ring = &priv->tx_ring;
+
+	if (!tx_ring->tout_log_buf)
+		tx_ring->tout_log_buf = devm_kzalloc(&priv->pdev->dev,
+						     HBG_TX_TIMEOUT_BUF_LEN,
+						     GFP_KERNEL);
+
+	if (!tx_ring->tout_log_buf)
+		return -ENOMEM;
+
+	return hbg_ring_init(priv, tx_ring, hbg_napi_tx_recycle, HBG_DIR_TX);
+}
+
+int hbg_txrx_init(struct hbg_priv *priv)
+{
+	int ret;
+
+	ret = hbg_tx_ring_init(priv);
+	if (ret)
+		dev_err(&priv->pdev->dev,
+			"failed to init tx ring, ret = %d\n", ret);
+
+	return ret;
+}
+
+void hbg_txrx_uninit(struct hbg_priv *priv)
+{
+	hbg_ring_uninit(&priv->tx_ring);
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
new file mode 100644
index 000000000000..7a2e3e61f6a9
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_TXRX_H
+#define __HBG_TXRX_H
+
+#include <linux/etherdevice.h>
+#include "hbg_hw.h"
+
+static inline u32 hbg_spec_max_frame_len(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	return (dir == HBG_DIR_TX) ? priv->dev_specs.max_frame_len :
+		priv->dev_specs.rx_buf_size;
+}
+
+static inline u32 hbg_get_spec_fifo_max_num(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	return (dir == HBG_DIR_TX) ? priv->dev_specs.tx_fifo_num :
+		priv->dev_specs.rx_fifo_num;
+}
+
+static inline bool hbg_fifo_is_full(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	return hbg_hw_get_fifo_used_num(priv, dir) >=
+	       hbg_get_spec_fifo_max_num(priv, dir);
+}
+
+static inline u32 hbg_get_queue_used_num(struct hbg_ring *ring)
+{
+	return (ring->ntu + ring->len - ring->ntc) % ring->len;
+}
+
+netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct net_device *net_dev);
+int hbg_txrx_init(struct hbg_priv *priv);
+void hbg_txrx_uninit(struct hbg_priv *priv);
+
+#endif
-- 
2.33.0


