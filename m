Return-Path: <netdev+bounces-119584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA5956475
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13945285D7E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6064915E5C1;
	Mon, 19 Aug 2024 07:19:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84734157476;
	Mon, 19 Aug 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051992; cv=none; b=IjK7IphIKp2XB6hO9IIHuTaYBXnaOeoDGUOkSYhTbXbBpFg96ejLWEjsPMXkyfLZN3SZYnk62VoJ8TqoYprn9bPKvoAgRKIYcAZTS9AeF+K/6WaX6pmvvn0ixKfmUdW8ku8pkPl5p75dDBnJ1F2VVSDgAv6T3jMuMQ3rVeLxlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051992; c=relaxed/simple;
	bh=P3fKF8v9aGr+J4zFtOm5ob5h+2zwWXEm33vU2w6xKAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+BJScZNuQ/JG85KUUaa6qJ4TpcaC18Swl7BZm9bYR1ILW0Ofs/+eT8dcAyOYrRAIx4BbJSO4Kt7SwUFHpMujH3HvzegxKb0MRuqh2MF3VJAQva+YQgKvwlPhoCtxC3ISpKt0K7heWfYixiaf7+WwO1Q30dcBvvFqw4uk2oqSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WnP952v0PzyQC2;
	Mon, 19 Aug 2024 15:19:05 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id C8A00140390;
	Mon, 19 Aug 2024 15:19:41 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 15:19:40 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 04/11] net: hibmcge: Add interrupt supported in this module
Date: Mon, 19 Aug 2024 15:12:22 +0800
Message-ID: <20240819071229.2489506-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240819071229.2489506-1-shaojijie@huawei.com>
References: <20240819071229.2489506-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  57 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   8 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 159 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  13 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  28 +++
 7 files changed, 297 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index f796287c0868..681dcb74993d 100644
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
+	u32 mask;
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
index 61769bad284c..f91de30507ea 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -70,6 +70,63 @@ static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	return 0;
 }
 
+u32 hbg_hw_get_err_intr_status(struct hbg_priv *priv)
+{
+	return hbg_reg_read(priv, HBG_REG_CF_INTRPT_STAT_ADDR);
+}
+
+void hbg_hw_set_err_intr_clear(struct hbg_priv *priv, u32 status)
+{
+	hbg_reg_write(priv, HBG_REG_CF_INTRPT_CLR_ADDR, status);
+}
+
+void hbg_hw_set_err_intr_mask(struct hbg_priv *priv, u32 mask)
+{
+	hbg_reg_write(priv, HBG_REG_CF_INTRPT_MSK_ADDR, mask);
+}
+
+u32 hbg_hw_get_err_intr_mask(struct hbg_priv *priv)
+{
+	return hbg_reg_read(priv, HBG_REG_CF_INTRPT_MSK_ADDR);
+}
+
+void hbg_hw_set_txrx_intr_enable(struct hbg_priv *priv,
+				 enum hbg_dir dir, bool enabld)
+{
+	u32 addr = hbg_dir_has_tx(dir) ? HBG_REG_CF_IND_TXINT_MSK_ADDR :
+					 HBG_REG_CF_IND_RXINT_MSK_ADDR;
+
+	hbg_reg_write_field(priv, addr, HBG_REG_CF_IND_INT_STAT_CLR_MSK_B, enabld);
+}
+
+bool hbg_hw_txrx_intr_is_enabled(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	u32 addr = hbg_dir_has_tx(dir) ? HBG_REG_CF_IND_TXINT_MSK_ADDR :
+					 HBG_REG_CF_IND_RXINT_MSK_ADDR;
+
+	return hbg_reg_read_field(priv, addr, HBG_REG_CF_IND_INT_STAT_CLR_MSK_B);
+}
+
+void hbg_hw_set_txrx_intr_clear(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	u32 addr = hbg_dir_has_tx(dir) ? HBG_REG_CF_IND_TXINT_CLR_ADDR :
+					 HBG_REG_CF_IND_RXINT_CLR_ADDR;
+
+	hbg_reg_write_field(priv, addr, HBG_REG_CF_IND_INT_STAT_CLR_MSK_B, 0x1);
+}
+
+u32 hbg_hw_get_txrx_intr_status(struct hbg_priv *priv)
+{
+	u32 status = 0;
+
+	status |= FIELD_PREP(HBG_INT_MSK_TX_B,
+			     hbg_reg_read(priv, HBG_REG_CF_IND_TXINT_STAT_ADDR));
+	status |= FIELD_PREP(HBG_INT_MSK_RX_B,
+			     hbg_reg_read(priv, HBG_REG_CF_IND_RXINT_STAT_ADDR));
+
+	return status;
+}
+
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
 	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index bb8a5af5678d..fd8d8b5f6472 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -28,5 +28,13 @@
 
 int hbg_hw_init(struct hbg_priv *pri);
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
+u32 hbg_hw_get_err_intr_status(struct hbg_priv *priv);
+u32 hbg_hw_get_err_intr_mask(struct hbg_priv *priv);
+void hbg_hw_set_err_intr_mask(struct hbg_priv *priv, u32 mask);
+void hbg_hw_set_err_intr_clear(struct hbg_priv *priv, u32 status);
+void hbg_hw_set_txrx_intr_enable(struct hbg_priv *priv, enum hbg_dir dir, bool enabld);
+bool hbg_hw_txrx_intr_is_enabled(struct hbg_priv *priv, enum hbg_dir dir);
+void hbg_hw_set_txrx_intr_clear(struct hbg_priv *priv, enum hbg_dir dir);
+u32 hbg_hw_get_txrx_intr_status(struct hbg_priv *priv);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
new file mode 100644
index 000000000000..2d159b917d79
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -0,0 +1,159 @@
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
+#define HBG_TXRX_IRQ_I(name, mask, handle) {name, mask, false, false, 0, handle}
+#define HBG_ERR_IRQ_I(name, mask, need_print) \
+			{name, mask, true, need_print, 0, hbg_irq_handle_err}
+
+static struct hbg_irq_info hbg_irqs[] = {
+	HBG_TXRX_IRQ_I("RX", HBG_INT_MSK_RX_B, NULL),
+	HBG_TXRX_IRQ_I("TX", HBG_INT_MSK_TX_B, NULL),
+	HBG_ERR_IRQ_I("MAC_MII_FIFO_ERR", HBG_INT_MSK_MAC_MII_FF_ERR_B, true),
+	HBG_ERR_IRQ_I("MAC_PCS_RX_FIFO_ERR", HBG_INT_MSK_MAC_PCS_RXFF_ERR_B, true),
+	HBG_ERR_IRQ_I("MAC_PCS_TX_FIFO_ERR", HBG_INT_MSK_MAC_PCS_TXFF_ERR_B, true),
+	HBG_ERR_IRQ_I("MAC_APP_RX_FIFO_ERR", HBG_INT_MSK_MAC_APP_RXFF_ERR_B, true),
+	HBG_ERR_IRQ_I("MAC_APP_TX_FIFO_ERR", HBG_INT_MSK_MAC_APP_TXFF_ERR_B, true),
+	HBG_ERR_IRQ_I("SRAM_PARITY_ERR", HBG_INT_MSK_SRAM_PARITY_ERR_B, true),
+	HBG_ERR_IRQ_I("TX_AHB_ERR", HBG_INT_MSK_TX_AHB_ERR_B, true),
+	HBG_ERR_IRQ_I("RX_BUF_AVL", HBG_INT_MSK_BUF_AVL_B, false),
+	HBG_ERR_IRQ_I("REL_BUF_ERR", HBG_INT_MSK_REL_ERR_B, true),
+	HBG_ERR_IRQ_I("TXCFG_AVL", HBG_INT_MSK_TXCFG_AVL_B, false),
+	HBG_ERR_IRQ_I("TX_DROP", HBG_INT_MSK_TX_DROP_B, false),
+	HBG_ERR_IRQ_I("RX_DROP", HBG_INT_MSK_RX_DROP_B, false),
+	HBG_ERR_IRQ_I("RX_AHB_ERR", HBG_INT_MSK_RX_AHB_ERR_B, true),
+	HBG_ERR_IRQ_I("MAC_FIFO_ERR", HBG_INT_MSK_MAC_FIFO_ERR_B, false),
+	HBG_ERR_IRQ_I("RBREQ_ERR", HBG_INT_MSK_RBREQ_ERR_B, false),
+	HBG_ERR_IRQ_I("WE_ERR", HBG_INT_MSK_WE_ERR_B, false),
+};
+
+void hbg_irq_enable(struct hbg_priv *priv, u32 mask, bool enable)
+{
+	u32 irq_mask;
+
+	if (mask == HBG_INT_MSK_TX_B)
+		return hbg_hw_set_txrx_intr_enable(priv, HBG_DIR_TX, enable);
+
+	if (mask == HBG_INT_MSK_RX_B)
+		return hbg_hw_set_txrx_intr_enable(priv, HBG_DIR_RX, enable);
+
+	irq_mask = hbg_hw_get_err_intr_mask(priv);
+	if (enable)
+		irq_mask |= mask;
+	else
+		irq_mask &= ~mask;
+
+	hbg_hw_set_err_intr_mask(priv, irq_mask);
+}
+
+bool hbg_irq_is_enabled(struct hbg_priv *priv, u32 mask)
+{
+	if (mask == HBG_INT_MSK_TX_B)
+		return hbg_hw_txrx_intr_is_enabled(priv, HBG_DIR_TX);
+
+	if (mask == HBG_INT_MSK_RX_B)
+		return hbg_hw_txrx_intr_is_enabled(priv, HBG_DIR_RX);
+
+	return hbg_hw_get_err_intr_mask(priv) & mask;
+}
+
+static void hbg_irq_clear_src(struct hbg_priv *priv, u32 mask)
+{
+	if (mask == HBG_INT_MSK_TX_B)
+		return hbg_hw_set_txrx_intr_clear(priv, HBG_DIR_TX);
+
+	if (mask == HBG_INT_MSK_RX_B)
+		return hbg_hw_set_txrx_intr_clear(priv, HBG_DIR_RX);
+
+	hbg_hw_set_err_intr_clear(priv, mask);
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
+	u32 status;
+	struct hbg_irq_info *irq_info;
+	struct hbg_priv *priv = p;
+	u32 i;
+
+	status = hbg_hw_get_err_intr_status(priv);
+	status |= hbg_hw_get_txrx_intr_status(priv);
+
+	for (i = 0; i < priv->vectors.info_array_len; i++) {
+		irq_info = &priv->vectors.info_array[i];
+		if (status & irq_info->mask)
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
index 000000000000..a295075932eb
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
+void hbg_irq_enable(struct hbg_priv *priv, u32 mask, bool enable);
+bool hbg_irq_is_enabled(struct hbg_priv *priv, u32 mask);
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
index 81e6d6e9a429..52b2447bbd4e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -51,6 +51,27 @@
 #define HBG_REG_RECV_CONTROL_STRIP_PAD_EN_B	BIT(3)
 
 /* PCU */
+#define HBG_REG_CF_INTRPT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x042C)
+#define HBG_INT_MSK_WE_ERR_B			BIT(31)
+#define HBG_INT_MSK_RBREQ_ERR_B			BIT(30)
+#define HBG_INT_MSK_MAC_FIFO_ERR_B		BIT(29)
+#define HBG_INT_MSK_RX_AHB_ERR_B		BIT(28)
+#define HBG_INT_MSK_RX_DROP_B			BIT(26)
+#define HBG_INT_MSK_TX_DROP_B			BIT(25)
+#define HBG_INT_MSK_TXCFG_AVL_B			BIT(24)
+#define HBG_INT_MSK_REL_ERR_B			BIT(23)
+#define HBG_INT_MSK_BUF_AVL_B			BIT(22)
+#define HBG_INT_MSK_TX_AHB_ERR_B		BIT(21)
+#define HBG_INT_MSK_SRAM_PARITY_ERR_B		BIT(20)
+#define HBG_INT_MSK_MAC_APP_TXFF_ERR_B		BIT(19)
+#define HBG_INT_MSK_MAC_APP_RXFF_ERR_B		BIT(18)
+#define HBG_INT_MSK_MAC_PCS_TXFF_ERR_B		BIT(17)
+#define HBG_INT_MSK_MAC_PCS_RXFF_ERR_B		BIT(16)
+#define HBG_INT_MSK_MAC_MII_FF_ERR_B		BIT(15)
+#define HBG_INT_MSK_TX_B			BIT(1) /* just used in driver */
+#define HBG_INT_MSK_RX_B			BIT(0) /* just used in driver */
+#define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
+#define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
@@ -64,6 +85,13 @@
 #define HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M	GENMASK(3, 0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
 #define HBG_REG_RX_PKT_MODE_PARSE_MODE_M	GENMASK(22, 21)
+#define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
+#define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
+#define HBG_REG_CF_IND_TXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x069C)
+#define HBG_REG_CF_IND_RXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x06a0)
+#define HBG_REG_CF_IND_RXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x06a4)
+#define HBG_REG_CF_IND_RXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x06a8)
+#define HBG_REG_CF_IND_INT_STAT_CLR_MSK_B	BIT(0)
 
 enum hbg_port_mode {
 	/* 0x0 ~ 0x5 are reserved */
-- 
2.33.0


