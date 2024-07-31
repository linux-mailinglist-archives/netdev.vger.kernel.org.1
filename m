Return-Path: <netdev+bounces-114486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC65942B2E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471051F21C84
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D621AD9DA;
	Wed, 31 Jul 2024 09:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC131AB53E;
	Wed, 31 Jul 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419309; cv=none; b=RbYGMgq31J2kZdyqpGSWiFQvceQGeWvkiSxLzScojB/Yb9CGl8Lt7UBgPPhozS9GP4cSAeIwHq+FN8zP67G8ZT9ObUObIDyPYTh85Qe2BH6nvaFTH9azjjd0C2fJx8SzBejUZPrsyPPXLGrVSBCCaNPfFXI5mOUnnGZF82yxf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419309; c=relaxed/simple;
	bh=0dDbV32YpY6ut3gSlLZd327zaFFuidHclUJg0Q97kTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIwnL5uF/q8m1U346Fe0Hl7a9/LmOTyIg9HTDL1lnGN2yTrdNCZlNC8lhbbOl1dHa4kfH2NFSMKVnf2CXNKOCN1pa9IXdN350LNw3Ak4JdkS1avfeRT+7Ij9vLjR5l1VwB8+gzdQjfemw1EoQ/BmGUlNDsp3wgleXxJWSU6Dikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYnLz5VN4zndJ0;
	Wed, 31 Jul 2024 17:47:23 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 26273140427;
	Wed, 31 Jul 2024 17:48:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:48:22 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next 06/10] net: hibmcge: Implement .ndo_start_xmit function
Date: Wed, 31 Jul 2024 17:42:41 +0800
Message-ID: <20240731094245.1967834-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731094245.1967834-1-shaojijie@huawei.com>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Implement .ndo_start_xmit function to fill the information of the packet
to be transmitted into the tx descriptor, and then the hardware will
transmit the packet using the information in the tx descriptor.
In addition, we also implemented the tx_handler function to enable the
tx descriptor to be reused, and .ndo_tx_timeout function to print some
information when the hardware is busy.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  46 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  18 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |  47 ++--
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  33 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.h |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   6 +
 .../hisilicon/hibmcge/hbg_reg_union.h         |  29 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 255 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  37 +++
 10 files changed, 456 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 22d5ce310a3f..760dcf88c0cf 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -15,8 +15,16 @@
 #define HBG_DEFAULT_MTU_SIZE		1500
 #define HBG_RX_SKIP1			0x00
 #define HBG_RX_SKIP2			0x01
+#define HBG_PCU_CACHE_LINE_SIZE		32
+
 #define HBG_LINK_DOWN	0
 #define HBG_LINK_UP	1
+#define HBG_TX_TIMEOUT_BUF_LEN	1024
+
+enum hbg_tx_state {
+	HBG_TX_STATE_COMPLETE = 0, /* clear state, must fix to 0 */
+	HBG_TX_STATE_START,
+};
 
 enum hbg_dir {
 	HBG_DIR_TX = 1 << 0,
@@ -36,6 +44,41 @@ enum hbg_nic_state {
 #define hbg_nic_is_open(priv) test_bit(HBG_NIC_STATE_OPEN, &(priv)->state)
 #define hbg_nic_is_inited(priv) test_bit(HBG_NIC_STATE_INITED, &(priv)->state)
 
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
@@ -59,6 +102,8 @@ struct hbg_irq_info {
 	const char *name;
 	enum hbg_irq_mask mask;
 	u64 count;
+
+	void (*irq_handle)(struct hbg_priv *priv, struct hbg_irq_info *irq_info);
 };
 
 struct hbg_irq {
@@ -95,6 +140,7 @@ struct hbg_priv {
 	unsigned long state;
 	struct hbg_mac mac;
 	struct hbg_vector vectors;
+	struct hbg_ring tx_ring;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index f06c74d59c02..683ad03f47d7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -68,6 +68,7 @@ int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	if (!is_valid_ether_addr((u8 *)dev_specs->mac_addr.sa_data))
 		return -EADDRNOTAVAIL;
 
+	dev_specs->max_frame_len = HBG_PCU_CACHE_LINE_SIZE + dev_specs->max_mtu;
 	return 0;
 }
 
@@ -111,6 +112,23 @@ void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
 			  HBG_REG_PORT_ENABLE_RX_B, enable);
 }
 
+u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	if (hbg_dir_has_tx(dir))
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
+	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_2_ADDR, tx_desc->pkt_addr);
+	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_3_ADDR, tx_desc->clear_addr);
+}
+
 void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status)
 {
 	status->bits = hbg_reg_read(priv, HBG_REG_CF_INTRPT_STAT_ADDR);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 556f479bc094..cb23b239f42a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -71,5 +71,7 @@ int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
 int hbg_hw_sgmii_autoneg(struct hbg_priv *priv);
 void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
 int hbg_hw_init(struct hbg_priv *pri);
+u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
+void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index 5e90e72d7f24..ed51b4f5d5ec 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -7,25 +7,30 @@
 
 #define HBG_VECTOR_NUM		4
 
+static void hbg_irq_handle_tx(struct hbg_priv *priv, struct hbg_irq_info *irq_info)
+{
+	napi_schedule(&priv->tx_ring.napi);
+}
+
 static struct hbg_irq_info hbg_irqs[] = {
-	{ "TX", HBG_IRQ_TX, 0 },
-	{ "RX", HBG_IRQ_RX, 0 },
-	{ "RX_BUF_AVL", HBG_IRQ_BUF_AVL, 0 },
-	{ "MAC_MII_FIFO_ERR", HBG_IRQ_MAC_MII_FIFO_ERR, 0 },
-	{ "MAC_PCS_RX_FIFO_ERR", HBG_IRQ_MAC_PCS_RX_FIFO_ERR, 0 },
-	{ "MAC_PCS_TX_FIFO_ERR", HBG_IRQ_MAC_PCS_TX_FIFO_ERR, 0 },
-	{ "MAC_APP_RX_FIFO_ERR", HBG_IRQ_MAC_APP_RX_FIFO_ERR, 0 },
-	{ "MAC_APP_TX_FIFO_ERR", HBG_IRQ_MAC_APP_TX_FIFO_ERR, 0 },
-	{ "SRAM_PARITY_ERR", HBG_IRQ_SRAM_PARITY_ERR, 0 },
-	{ "TX_AHB_ERR", HBG_IRQ_TX_AHB_ERR, 0 },
-	{ "REL_BUF_ERR", HBG_IRQ_REL_BUF_ERR, 0 },
-	{ "TXCFG_AVL", HBG_IRQ_TXCFG_AVL, 0 },
-	{ "TX_DROP", HBG_IRQ_TX_DROP, 0 },
-	{ "RX_DROP", HBG_IRQ_RX_DROP, 0 },
-	{ "RX_AHB_ERR", HBG_IRQ_RX_AHB_ERR, 0 },
-	{ "MAC_FIFO_ERR", HBG_IRQ_MAC_FIFO_ERR, 0 },
-	{ "RBREQ_ERR", HBG_IRQ_RBREQ_ERR, 0 },
-	{ "WE_ERR", HBG_IRQ_WE_ERR, 0 },
+	{ "TX", HBG_IRQ_TX, 0, hbg_irq_handle_tx },
+	{ "RX", HBG_IRQ_RX, 0, NULL },
+	{ "RX_BUF_AVL", HBG_IRQ_BUF_AVL, 0, NULL },
+	{ "MAC_MII_FIFO_ERR", HBG_IRQ_MAC_MII_FIFO_ERR, 0, NULL },
+	{ "MAC_PCS_RX_FIFO_ERR", HBG_IRQ_MAC_PCS_RX_FIFO_ERR, 0, NULL },
+	{ "MAC_PCS_TX_FIFO_ERR", HBG_IRQ_MAC_PCS_TX_FIFO_ERR, 0, NULL },
+	{ "MAC_APP_RX_FIFO_ERR", HBG_IRQ_MAC_APP_RX_FIFO_ERR, 0, NULL },
+	{ "MAC_APP_TX_FIFO_ERR", HBG_IRQ_MAC_APP_TX_FIFO_ERR, 0, NULL },
+	{ "SRAM_PARITY_ERR", HBG_IRQ_SRAM_PARITY_ERR, 0, NULL },
+	{ "TX_AHB_ERR", HBG_IRQ_TX_AHB_ERR, 0, NULL },
+	{ "REL_BUF_ERR", HBG_IRQ_REL_BUF_ERR, 0, NULL },
+	{ "TXCFG_AVL", HBG_IRQ_TXCFG_AVL, 0, NULL },
+	{ "TX_DROP", HBG_IRQ_TX_DROP, 0, NULL },
+	{ "RX_DROP", HBG_IRQ_RX_DROP, 0, NULL },
+	{ "RX_AHB_ERR", HBG_IRQ_RX_AHB_ERR, 0, NULL },
+	{ "MAC_FIFO_ERR", HBG_IRQ_MAC_FIFO_ERR, 0, NULL },
+	{ "RBREQ_ERR", HBG_IRQ_RBREQ_ERR, 0, NULL },
+	{ "WE_ERR", HBG_IRQ_WE_ERR, 0, NULL },
 };
 
 void hbg_irq_enable(struct hbg_priv *priv, enum hbg_irq_mask mask, bool enable)
@@ -85,6 +90,12 @@ static void hbg_irq_info_handle(struct hbg_priv *priv,
 	hbg_irq_clear_src(priv, irq_info->mask);
 
 	irq_info->count++;
+	if (irq_info->irq_handle)
+		irq_info->irq_handle(priv, irq_info);
+
+	if (irq_info->mask == HBG_IRQ_TX)
+		return;
+
 	hbg_irq_enable(priv, irq_info->mask, true);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 0184ea5d563e..8efeea9b0c26 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -10,6 +10,7 @@
 #include "hbg_irq.h"
 #include "hbg_main.h"
 #include "hbg_mdio.h"
+#include "hbg_txrx.h"
 
 static void hbg_enable_intr(struct hbg_priv *priv, bool enabled)
 {
@@ -35,6 +36,7 @@ static int hbg_net_open(struct net_device *dev)
 		return 0;
 
 	netif_carrier_off(dev);
+	napi_enable(&priv->tx_ring.napi);
 	hbg_enable_intr(priv, true);
 	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
 	netif_start_queue(dev);
@@ -54,6 +56,7 @@ static int hbg_net_stop(struct net_device *dev)
 	netif_stop_queue(dev);
 	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
 	hbg_enable_intr(priv, false);
+	napi_disable(&priv->tx_ring.napi);
 	hbg_phy_stop(priv);
 	return 0;
 }
@@ -102,12 +105,33 @@ static int hbg_net_change_mtu(struct net_device *dev, int new_mtu)
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
+			 hbg_irq_is_enabled(priv, HBG_IRQ_TX));
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
 
 static const u32 hbg_mode_ability[] = {
@@ -140,6 +164,14 @@ static int hbg_init(struct net_device *netdev)
 	if (ret)
 		return ret;
 
+	ret = hbg_txrx_init(priv);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&priv->pdev->dev, hbg_txrx_uninit, priv);
+	if (ret)
+		return ret;
+
 	ret = hbg_irq_init(priv);
 	if (ret)
 		return ret;
@@ -205,6 +237,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	netdev->watchdog_timeo = HBG_TX_TIMEOUT;
 	netdev->max_mtu = priv->dev_specs.max_mtu;
 	netdev->min_mtu = priv->dev_specs.min_mtu;
 	hbg_net_change_mtu(netdev, HBG_DEFAULT_MTU_SIZE);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h
index f9652e5c06b2..05be9ef5f2fc 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h
@@ -9,5 +9,6 @@
 #define HBG_DEV_NAME	"hibmcge"
 #define HBG_MEM_BAR	0
 #define HBG_MOD_VERSION	"1.0"
+#define HBG_TX_TIMEOUT	(5 * HZ)
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 86f1157a2af2..b5a78ea8927a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -48,6 +48,11 @@
 #define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
 #define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
 #define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
+#define HBG_REG_CF_CFF_DATA_NUM_ADDR		(HBG_REG_SGMII_BASE + 0x045C)
+#define HBG_REG_TX_CFF_ADDR_0_ADDR		(HBG_REG_SGMII_BASE + 0x0488)
+#define HBG_REG_TX_CFF_ADDR_1_ADDR		(HBG_REG_SGMII_BASE + 0x048C)
+#define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
+#define HBG_REG_TX_CFF_ADDR_3_ADDR		(HBG_REG_SGMII_BASE + 0x0494)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
 #define HBG_REG_RX_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04F0)
@@ -71,6 +76,7 @@
 #define HBG_REG_IND_INTR_MASK_B			BIT(0)
 #define HBG_REG_PORT_ENABLE_RX_B		BIT(1)
 #define HBG_REG_PORT_ENABLE_TX_B		BIT(2)
+#define HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M	GENMASK(8, 0)
 
 enum hbg_port_mode {
 	/* 0x0 ~ 0x5 are reserved */
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
index 406eac051c10..6a2a585451d7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
@@ -169,4 +169,33 @@ struct hbg_intr_mask {
 	};
 };
 
+struct hbg_tx_desc {
+	union {
+		struct {
+			u32 l4_cs : 1;
+			u32 wb : 1;
+			u32 l3_cs : 1;
+			u32 rsv0 : 16;
+			u32 ds : 6;
+			u32 sd : 1;
+			u32 ipoff : 5;
+			u32 rsv1 : 1;
+		};
+		u32 word0;
+	};
+	union {
+		struct {
+			u32 rsv2 : 4;
+			u32 len : 16;
+			u32 back : 6;
+			u32 fm : 1;
+			u32 l2cache : 1;
+			u32 rsv3 : 4;
+		};
+		u32 word1;
+	};
+	u32 pkt_addr; /* word2 */
+	u32 clear_addr; /* word3 */
+};
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
new file mode 100644
index 000000000000..00b4d5951c1e
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -0,0 +1,255 @@
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
+	tx_desc->word0 = 0;
+	tx_desc->word1 = 0;
+
+	tx_desc->wb = HBG_STATUS_ENABLE;
+	tx_desc->len = buffer->skb->len;
+	tx_desc->clear_addr = buffer->state_dma;
+	tx_desc->pkt_addr = buffer->skb_dma;
+	tx_desc->ipoff = buffer->skb->network_header - buffer->skb->mac_header;
+
+	if (likely(buffer->skb->ip_summed == CHECKSUM_PARTIAL)) {
+		tx_desc->l3_cs = 1;
+		tx_desc->l4_cs = 1;
+	}
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
+	if (unlikely(!skb->len || skb->len > hbg_spec_max_frame_len(priv, HBG_DIR_TX))) {
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
+	struct hbg_priv *priv = ring->priv;
+	/* This smp_load_acquire() pairs with smp_store_release() in
+	 * hbg_start_xmit() called in xmit process.
+	 */
+	u32 ntu = smp_load_acquire(&ring->ntu);
+	struct hbg_buffer *buffer;
+	u32 ntc = ring->ntc;
+	int packet_done = 0;
+
+	while (!hbg_queue_is_empty(ntc, ntu)) {
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
+	};
+
+	/* This smp_store_release() pairs with smp_load_acquire() in
+	 * hbg_start_xmit() called in xmit process.
+	 */
+	smp_store_release(&ring->ntc, ntc);
+	netif_wake_queue(priv->netdev);
+	napi_complete(napi);
+	hbg_irq_enable(priv, HBG_IRQ_TX, true);
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
+			  ring->len * sizeof(struct hbg_buffer),
+			  ring->queue, ring->queue_dma);
+	ring->queue = NULL;
+	ring->queue_dma = 0;
+	ring->len = 0;
+	ring->priv = NULL;
+}
+
+static int hbg_ring_init(struct hbg_priv *priv, struct hbg_ring *ring,
+			 enum hbg_dir dir)
+{
+	struct hbg_buffer *buffer;
+	u32 i, len;
+
+	len = hbg_get_spec_fifo_max_num(priv, dir) + 1;
+	ring->queue = dma_alloc_coherent(&priv->pdev->dev,
+					 len * sizeof(struct hbg_buffer),
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
+	return 0;
+}
+
+static int hbg_tx_ring_init(struct hbg_priv *priv)
+{
+	struct hbg_ring *tx_ring = &priv->tx_ring;
+	int ret;
+
+	if (!tx_ring->tout_log_buf)
+		tx_ring->tout_log_buf = devm_kzalloc(&priv->pdev->dev,
+						     HBG_TX_TIMEOUT_BUF_LEN,
+						     GFP_KERNEL);
+
+	if (!tx_ring->tout_log_buf)
+		return -ENOMEM;
+
+	ret = hbg_ring_init(priv, tx_ring, HBG_DIR_TX);
+	if (ret)
+		return ret;
+
+	netif_napi_add_tx(priv->netdev, &tx_ring->napi, hbg_napi_tx_recycle);
+	return 0;
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
+void hbg_txrx_uninit(void *data)
+{
+	struct hbg_priv *priv = data;
+
+	hbg_ring_uninit(&priv->tx_ring);
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
new file mode 100644
index 000000000000..fa00a74a451a
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
+void hbg_txrx_uninit(void *data);
+
+#endif
-- 
2.33.0


