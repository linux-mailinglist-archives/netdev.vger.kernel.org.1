Return-Path: <netdev+bounces-118064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0107C950709
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54575B22F62
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBBA19D893;
	Tue, 13 Aug 2024 14:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30613CFBC;
	Tue, 13 Aug 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557763; cv=none; b=iwej9pQssL2b7+XxxGZ0lH94glgX7ch1f8Kh7KR63GcETaJj5y0Ww7MARJf0CR1IrHtpjDq2yYVa0GSSiCmjW5tlP3Gt0ycinnB1f7K0HTxQARIMe+MTeVX0/M4kO1I8Z9yx3zcLfKeb6NLBhNRrsQjk0EoLINJRiAI9e7q7V1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557763; c=relaxed/simple;
	bh=gcSjZLpuKEq4oPtEg5E0dwyU9Dy5DgUmJFvGbqguzj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rx/h75PEufc0+MbFlVF+53KBGD9BLqIyYvnNAzzs9L8w/ERBFIXS8C7nCrrLapg9TYxbK6G5DysE9svkrSaMw+7XGJqX/SgXjg8g1hIXB4+690eDCNWA5zD2+G2QAHqUf57lEGi7kxg/WVFu3Xr8F11VUe4HsKDaLm0tpV4tF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WjtHv2vsFz2CmNF;
	Tue, 13 Aug 2024 21:57:47 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 4877A140337;
	Tue, 13 Aug 2024 22:02:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:02:37 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH V2 net-next 04/11] net: hibmcge: Add interrupt supported in this module
Date: Tue, 13 Aug 2024 21:56:33 +0800
Message-ID: <20240813135640.1694993-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813135640.1694993-1-shaojijie@huawei.com>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
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

The driver supports four interrupts: TX interrupt, RX interrupt,
mdio interrupt, and error interrupt.

Actually, the driver does not use the mdio interrupt.
Therefore, the driver does not request the mdio interrupt.

The error interrupt distinguishes different error information
by using different masks. To distinguish different errors,
the statistics count is added for each error.

To ensure the consistency of the code process, masks are added for the
TX interrupt and RX interrupt.

This patch implements interrupt request and free, and provides a
unified entry for the interrupt handler function. However,
the specific interrupt handler function of each interrupt
is not implemented currently.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  27 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  54 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   8 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 168 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  13 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  34 ++++
 .../hisilicon/hibmcge/hbg_reg_union.h         |  60 +++++++
 8 files changed, 369 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index f796287c0868..f95080359f35 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -13,6 +13,16 @@
 #define HBG_DEFAULT_MTU_SIZE		1500
 #define HBG_RX_SKIP1			0x00
 #define HBG_RX_SKIP2			0x01
+#define HBG_VECTOR_NUM			4
+
+enum hbg_dir {
+	HBG_DIR_TX = 1 << 0,
+	HBG_DIR_RX = 1 << 1,
+	HBG_DIR_TX_RX = HBG_DIR_TX | HBG_DIR_RX,
+};
+
+#define hbg_dir_has_tx(dir) ((dir) & HBG_DIR_TX)
+#define hbg_dir_has_rx(dir) ((dir) & HBG_DIR_RX)
 
 enum hbg_nic_state {
 	HBG_NIC_STATE_INITED = 0,
@@ -39,6 +49,22 @@ struct hbg_dev_specs {
 	u32 rx_buf_size;
 };
 
+struct hbg_irq_info {
+	const char *name;
+	enum hbg_irq_mask mask;
+	bool reenable;
+	bool need_print;
+	u64 count;
+
+	void (*irq_handle)(struct hbg_priv *priv, struct hbg_irq_info *irq_info);
+};
+
+struct hbg_vector {
+	char name[HBG_VECTOR_NUM][32];
+	struct hbg_irq_info *info_array;
+	u32 info_array_len;
+};
+
 struct hbg_mac {
 	struct mii_bus *mdio_bus;
 	struct phy_device *phydev;
@@ -58,6 +84,7 @@ struct hbg_priv {
 	struct hbg_dev_specs dev_specs;
 	unsigned long state;
 	struct hbg_mac mac;
+	struct hbg_vector vectors;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index e1294c60cd2d..170aa57ca790 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -69,6 +69,60 @@ int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	return 0;
 }
 
+void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status)
+{
+	status->bits = hbg_reg_read(priv, HBG_REG_CF_INTRPT_STAT_ADDR);
+}
+
+void hbg_hw_set_err_intr_clear(struct hbg_priv *priv, struct hbg_intr_status *status)
+{
+	hbg_reg_write(priv, HBG_REG_CF_INTRPT_CLR_ADDR, status->bits);
+}
+
+void hbg_hw_set_err_intr_mask(struct hbg_priv *priv, const struct hbg_intr_mask *msk)
+{
+	hbg_reg_write(priv, HBG_REG_CF_INTRPT_MSK_ADDR, msk->bits);
+}
+
+void hbg_hw_get_err_intr_mask(struct hbg_priv *priv, struct hbg_intr_mask *msk)
+{
+	msk->bits = hbg_reg_read(priv, HBG_REG_CF_INTRPT_MSK_ADDR);
+}
+
+void hbg_hw_set_txrx_intr_enable(struct hbg_priv *priv,
+				 enum hbg_dir dir, bool enabld)
+{
+	u32 addr = hbg_dir_has_tx(dir) ? HBG_REG_CF_IND_TXINT_MSK_ADDR :
+					 HBG_REG_CF_IND_RXINT_MSK_ADDR;
+
+	hbg_reg_write_field(priv, addr, HBG_REG_IND_INTR_MASK_B, enabld);
+}
+
+bool hbg_hw_txrx_intr_is_enabled(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	u32 addr = hbg_dir_has_tx(dir) ? HBG_REG_CF_IND_TXINT_MSK_ADDR :
+					 HBG_REG_CF_IND_RXINT_MSK_ADDR;
+
+	return hbg_reg_read_field(priv, addr, HBG_REG_IND_INTR_MASK_B);
+}
+
+void hbg_hw_set_txrx_intr_clear(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	u32 addr = hbg_dir_has_tx(dir) ? HBG_REG_CF_IND_TXINT_CLR_ADDR :
+					 HBG_REG_CF_IND_RXINT_CLR_ADDR;
+
+	hbg_reg_write_field(priv, addr, HBG_REG_IND_INTR_MASK_B, 0x1);
+}
+
+void hbg_hw_get_txrx_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status)
+{
+	status->tx = hbg_reg_read_field(priv, HBG_REG_CF_IND_TXINT_STAT_ADDR,
+					HBG_REG_IND_INTR_MASK_B);
+
+	status->rx = hbg_reg_read_field(priv, HBG_REG_CF_IND_RXINT_STAT_ADDR,
+					HBG_REG_IND_INTR_MASK_B);
+}
+
 int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
 	if (speed != HBG_PORT_MODE_SGMII_10M &&
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index c5a2dd49399b..06561c39c688 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -28,6 +28,14 @@
 
 int hbg_hw_event_notify(struct hbg_priv *priv, enum hbg_hw_event_type event_type);
 int hbg_hw_dev_specs_init(struct hbg_priv *priv);
+void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status);
+void hbg_hw_get_err_intr_mask(struct hbg_priv *priv, struct hbg_intr_mask *msk);
+void hbg_hw_set_err_intr_mask(struct hbg_priv *priv, const struct hbg_intr_mask *msk);
+void hbg_hw_set_err_intr_clear(struct hbg_priv *priv, struct hbg_intr_status *status);
+void hbg_hw_set_txrx_intr_enable(struct hbg_priv *priv, enum hbg_dir dir, bool enabld);
+bool hbg_hw_txrx_intr_is_enabled(struct hbg_priv *priv, enum hbg_dir dir);
+void hbg_hw_set_txrx_intr_clear(struct hbg_priv *priv, enum hbg_dir dir);
+void hbg_hw_get_txrx_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status);
 int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
 int hbg_hw_init(struct hbg_priv *pri);
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
new file mode 100644
index 000000000000..0c28e9c3fbc3
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/interrupt.h>
+#include "hbg_irq.h"
+#include "hbg_hw.h"
+
+static void hbg_irq_handle_err(struct hbg_priv *priv,
+			       struct hbg_irq_info *irq_info)
+{
+	if (irq_info->need_print)
+		dev_err(&priv->pdev->dev,
+			"receive abnormal interrupt: %s\n", irq_info->name);
+}
+
+static struct hbg_irq_info hbg_irqs[] = {
+	{ "TX", HBG_IRQ_TX, false, false, 0, NULL },
+	{ "RX", HBG_IRQ_RX, false, false, 0, NULL },
+	{ "RX_BUF_AVL", HBG_IRQ_BUF_AVL, true, false, 0, hbg_irq_handle_err },
+	{ "MAC_MII_FIFO_ERR", HBG_IRQ_MAC_MII_FIFO_ERR,
+	  true, true, 0, hbg_irq_handle_err },
+	{ "MAC_PCS_RX_FIFO_ERR", HBG_IRQ_MAC_PCS_RX_FIFO_ERR,
+	  true, true, 0, hbg_irq_handle_err },
+	{ "MAC_PCS_TX_FIFO_ERR", HBG_IRQ_MAC_PCS_TX_FIFO_ERR,
+	  true, true, 0, hbg_irq_handle_err },
+	{ "MAC_APP_RX_FIFO_ERR", HBG_IRQ_MAC_APP_RX_FIFO_ERR,
+	  true, true, 0, hbg_irq_handle_err },
+	{ "MAC_APP_TX_FIFO_ERR", HBG_IRQ_MAC_APP_TX_FIFO_ERR,
+	  true, true, 0, hbg_irq_handle_err },
+	{ "SRAM_PARITY_ERR", HBG_IRQ_SRAM_PARITY_ERR,
+	  true, true, 0, hbg_irq_handle_err },
+	{ "TX_AHB_ERR", HBG_IRQ_TX_AHB_ERR, true, true, 0, hbg_irq_handle_err },
+	{ "REL_BUF_ERR", HBG_IRQ_REL_BUF_ERR, true, true, 0, hbg_irq_handle_err },
+	{ "TXCFG_AVL", HBG_IRQ_TXCFG_AVL, true, false, 0, hbg_irq_handle_err },
+	{ "TX_DROP", HBG_IRQ_TX_DROP, true, false, 0, hbg_irq_handle_err },
+	{ "RX_DROP", HBG_IRQ_RX_DROP, true, false, 0, hbg_irq_handle_err },
+	{ "RX_AHB_ERR", HBG_IRQ_RX_AHB_ERR, true, true, 0, hbg_irq_handle_err },
+	{ "MAC_FIFO_ERR", HBG_IRQ_MAC_FIFO_ERR,
+	  true, true, 0, hbg_irq_handle_err },
+	{ "RBREQ_ERR", HBG_IRQ_RBREQ_ERR, true, true, 0, hbg_irq_handle_err },
+	{ "WE_ERR", HBG_IRQ_WE_ERR, true, true, 0, hbg_irq_handle_err },
+};
+
+void hbg_irq_enable(struct hbg_priv *priv, enum hbg_irq_mask mask, bool enable)
+{
+	struct hbg_intr_mask intr_mask;
+
+	if (mask == HBG_IRQ_TX)
+		return hbg_hw_set_txrx_intr_enable(priv, HBG_DIR_TX, enable);
+
+	if (mask == HBG_IRQ_RX)
+		return hbg_hw_set_txrx_intr_enable(priv, HBG_DIR_RX, enable);
+
+	hbg_hw_get_err_intr_mask(priv, &intr_mask);
+	if (enable)
+		intr_mask.bits = intr_mask.bits | mask;
+	else
+		intr_mask.bits = intr_mask.bits & (~mask);
+
+	hbg_hw_set_err_intr_mask(priv, &intr_mask);
+}
+
+bool hbg_irq_is_enabled(struct hbg_priv *priv, enum hbg_irq_mask mask)
+{
+	struct hbg_intr_mask intr_mask;
+
+	if (mask == HBG_IRQ_TX)
+		return hbg_hw_txrx_intr_is_enabled(priv, HBG_DIR_TX);
+
+	if (mask == HBG_IRQ_RX)
+		return hbg_hw_txrx_intr_is_enabled(priv, HBG_DIR_RX);
+
+	hbg_hw_get_err_intr_mask(priv, &intr_mask);
+	return intr_mask.bits & mask;
+}
+
+static void hbg_irq_clear_src(struct hbg_priv *priv, enum hbg_irq_mask mask)
+{
+	struct hbg_intr_status intr_clear;
+
+	if (mask == HBG_IRQ_TX)
+		return hbg_hw_set_txrx_intr_clear(priv, HBG_DIR_TX);
+
+	if (mask == HBG_IRQ_RX)
+		return hbg_hw_set_txrx_intr_clear(priv, HBG_DIR_RX);
+
+	intr_clear.bits = mask;
+	hbg_hw_set_err_intr_clear(priv, &intr_clear);
+}
+
+static void hbg_irq_info_handle(struct hbg_priv *priv,
+				struct hbg_irq_info *irq_info)
+{
+	if (!hbg_irq_is_enabled(priv, irq_info->mask))
+		return;
+
+	hbg_irq_enable(priv, irq_info->mask, false);
+	hbg_irq_clear_src(priv, irq_info->mask);
+
+	irq_info->count++;
+	if (irq_info->irq_handle)
+		irq_info->irq_handle(priv, irq_info);
+
+	if (irq_info->reenable)
+		hbg_irq_enable(priv, irq_info->mask, true);
+}
+
+static irqreturn_t hbg_irq_handle(int irq_num, void *p)
+{
+	struct hbg_intr_status intr_status;
+	struct hbg_irq_info *irq_info;
+	struct hbg_priv *priv = p;
+	u32 i;
+
+	hbg_hw_get_err_intr_status(priv, &intr_status);
+	hbg_hw_get_txrx_intr_status(priv, &intr_status);
+
+	for (i = 0; i < priv->vectors.info_array_len; i++) {
+		irq_info = &priv->vectors.info_array[i];
+		if (intr_status.bits & irq_info->mask)
+			hbg_irq_info_handle(priv, irq_info);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx", "err", "mdio" };
+
+int hbg_irq_init(struct hbg_priv *priv)
+{
+	struct hbg_vector *vectors = &priv->vectors;
+	struct device *dev = &priv->pdev->dev;
+	int ret, id;
+	u32 i;
+
+	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to allocate MSI vectors\n");
+
+	if (ret != HBG_VECTOR_NUM)
+		return dev_err_probe(dev, -EINVAL,
+				     "requested %u MSI, but allocated %d MSI\n",
+				     HBG_VECTOR_NUM, ret);
+
+	/* mdio irq not request, so the number of requested interrupts
+	 * is HBG_VECTOR_NUM - 1.
+	 */
+	for (i = 0; i < HBG_VECTOR_NUM - 1; i++) {
+		id = pci_irq_vector(priv->pdev, i);
+		if (id < 0)
+			return dev_err_probe(dev, id, "failed to get irq number\n");
+
+		snprintf(vectors->name[i], sizeof(vectors->name[i]), "%s-%s-%s",
+			 dev_driver_string(dev), pci_name(priv->pdev),
+			 irq_names_map[i]);
+
+		ret = devm_request_irq(dev, id, hbg_irq_handle, 0,
+				       vectors->name[i], priv);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to requset irq(%d)\n", id);
+	}
+
+	vectors->info_array = hbg_irqs;
+	vectors->info_array_len = ARRAY_SIZE(hbg_irqs);
+	return 0;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
new file mode 100644
index 000000000000..f332e7a958c1
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_IRQ_H
+#define __HBG_IRQ_H
+
+#include "hbg_common.h"
+
+void hbg_irq_enable(struct hbg_priv *priv, enum hbg_irq_mask mask, bool enable);
+bool hbg_irq_is_enabled(struct hbg_priv *priv, enum hbg_irq_mask mask);
+int hbg_irq_init(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index cba301e49b8e..f1663417d01f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
+#include "hbg_irq.h"
 #include "hbg_mdio.h"
 
 static const struct regmap_config hbg_regmap_config = {
@@ -31,6 +32,10 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	ret = hbg_irq_init(priv);
+	if (ret)
+		return ret;
+
 	return hbg_mdio_init(priv);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index a9885d705cc7..603bfc612fde 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -41,12 +41,21 @@
 #define HBG_REG_RECV_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x01E0)
 
 /* PCU */
+#define HBG_REG_CF_INTRPT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x042C)
+#define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
+#define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
 #define HBG_REG_BUS_CTRL_ENDIAN_M		GENMASK(2, 1)
 #define HBG_REG_RX_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04F0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
+#define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
+#define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
+#define HBG_REG_CF_IND_TXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x069C)
+#define HBG_REG_CF_IND_RXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x06a0)
+#define HBG_REG_CF_IND_RXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x06a4)
+#define HBG_REG_CF_IND_RXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x06a8)
 
 enum hbg_port_mode {
 	/* 0x0 ~ 0x5 are reserved */
@@ -55,4 +64,29 @@ enum hbg_port_mode {
 	HBG_PORT_MODE_SGMII_1000M = 0x8,
 };
 
+enum hbg_irq_mask {
+	HBG_IRQ_TX = BIT(0),
+	HBG_IRQ_RX = BIT(1),
+
+	/* others in err irq */
+	HBG_IRQ_TX_PKG = BIT(14),
+	HBG_IRQ_MAC_MII_FIFO_ERR = BIT(15),
+	HBG_IRQ_MAC_PCS_RX_FIFO_ERR = BIT(16),
+	HBG_IRQ_MAC_PCS_TX_FIFO_ERR = BIT(17),
+	HBG_IRQ_MAC_APP_RX_FIFO_ERR = BIT(18),
+	HBG_IRQ_MAC_APP_TX_FIFO_ERR = BIT(19),
+	HBG_IRQ_SRAM_PARITY_ERR = BIT(20),
+	HBG_IRQ_TX_AHB_ERR = BIT(21),
+	HBG_IRQ_BUF_AVL = BIT(22),
+	HBG_IRQ_REL_BUF_ERR = BIT(23),
+	HBG_IRQ_TXCFG_AVL = BIT(24),
+	HBG_IRQ_TX_DROP =  BIT(25),
+	HBG_IRQ_RX_DROP = BIT(26),
+	HBG_IRQ_RX_PKG = BIT(27),
+	HBG_IRQ_RX_AHB_ERR = BIT(28),
+	HBG_IRQ_MAC_FIFO_ERR = BIT(29),
+	HBG_IRQ_RBREQ_ERR = BIT(30),
+	HBG_IRQ_WE_ERR = BIT(31),
+};
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
index fc6cad15438d..406eac051c10 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
@@ -109,4 +109,64 @@ struct hbg_recv_control {
 	};
 };
 
+struct hbg_intr_status {
+	union {
+		struct {
+			u32 tx : 1;
+			u32 rx : 1;
+
+			/* others in err irq */
+			u32 rsv_0 : 12;
+			u32 tx_pkt_cpl : 1;
+			u32 mac_mii_ff_err : 1;
+			u32 mac_pcs_rxff_err : 1;
+			u32 mac_pcs_txff_err : 1;
+			u32 mac_app_rxff_err : 1;
+			u32 mac_app_txff_err : 1;
+			u32 sram_parity_err : 1;
+			u32 tx_ahb_err : 1;
+			u32 buf_avl : 1;
+			u32 rel_err : 1;
+			u32 txcfg_avl : 1;
+			u32 tx_drop : 1;
+			u32 rx_drop : 1;
+			u32 rx_frm : 1;
+			u32 ahb_err : 1;
+			u32 mac_fifo_err : 1;
+			u32 rbreq_err : 1;
+			u32 we_err : 1;
+		};
+		u32 bits;
+	};
+};
+
+struct hbg_intr_mask {
+	union {
+		struct {
+			u32 intr_time : 6;
+			u32 intr_pkt : 6;
+			u32 rsv0 : 2;
+			u32 tx_pkg_intr_msk : 1;
+			u32 mac_mii_ff_err_msk : 1;
+			u32 mac_pcs_rxff_err_msk : 1;
+			u32 mac_pcs_txff_err_msk : 1;
+			u32 mac_app_rxff_err_msk : 1;
+			u32 mac_app_txff_err_msk : 1;
+			u32 sram_parity_err_int_msk : 1;
+			u32 tx_ahb_err_int_msk : 1;
+			u32 buf_avl_msk : 1;
+			u32 rel_buf_msk : 1;
+			u32 txcfg_avl_msk : 1;
+			u32 tx_drop_int_msk : 1;
+			u32 rx_drop_int_msk : 1;
+			u32 rx_pkg_intr_msk : 1;
+			u32 ahb_err_int_msk : 1;
+			u32 mac_ff_err_int_msk : 1;
+			u32 rbreq_err_int_msk : 1;
+			u32 we_err_int_msk : 1;
+		};
+		u32 bits;
+	};
+};
+
 #endif
-- 
2.33.0


