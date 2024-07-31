Return-Path: <netdev+bounces-114484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63500942B2C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876FC1C21664
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482431AD404;
	Wed, 31 Jul 2024 09:48:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29911A7F9B;
	Wed, 31 Jul 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419308; cv=none; b=ZR1aj7lQKA+DWXZtUPGnsiOP37n8L9lQ6WBN2MGLpUHjgWvHnfnAd2n/4IvAtTmyr6LVUgw1oMsnXoaqbE1fheenGVQrUmk2i78dNpvpzlp5nZ2jYnXK4QLeX74vw+JzsXkFsWmOAlYn8/GKzGnxBo47ls2BZj3g0InkRKDpd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419308; c=relaxed/simple;
	bh=O2EnVPeOCmGDbpxAlnZkl8FE42b9+TkJUnLL0gV56oE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0HkbJLg40eMTx49lHPNjSZWaBVJnt0M/TdRhK3FFvY8+qxQGnL4i2leNLpveHXl2onVBKfJjf0MuQPWr33s3pxKUvlJVB1NwFe9aM5qIfgyjHKxkrQ2A8FFC+ZigPF/TmjVftzilGSFvIpjqvnXFzxOXu+N7kj3s8PeiIv1Uhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYnGr2T0bz1j6N7;
	Wed, 31 Jul 2024 17:43:48 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 134CF1400D4;
	Wed, 31 Jul 2024 17:48:22 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:48:21 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next 04/10] net: hibmcge: Add interrupt supported in this module
Date: Wed, 31 Jul 2024 17:42:39 +0800
Message-ID: <20240731094245.1967834-5-shaojijie@huawei.com>
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
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  20 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  59 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   8 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 189 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  13 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   9 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  34 ++++
 .../hisilicon/hibmcge/hbg_reg_union.h         |  60 ++++++
 8 files changed, 392 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 364aab4d61b9..6a3e647cd27c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -51,6 +51,25 @@ struct hbg_dev_specs {
 	u32 rx_buf_size;
 };
 
+struct hbg_irq_info {
+	const char *name;
+	enum hbg_irq_mask mask;
+	u64 count;
+};
+
+struct hbg_irq {
+	u32 id;
+	char name[32];
+};
+
+struct hbg_vector {
+	struct hbg_irq *irqs;
+	u32 irq_count;
+
+	struct hbg_irq_info *info_array;
+	u32 info_array_len;
+};
+
 struct hbg_mac {
 	struct mii_bus *mdio_bus;
 	struct phy_device *phydev;
@@ -71,6 +90,7 @@ struct hbg_priv {
 	struct hbg_dev_specs dev_specs;
 	unsigned long state;
 	struct hbg_mac mac;
+	struct hbg_vector vectors;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index b2465ba06cee..d9bed7cc7790 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -71,6 +71,65 @@ int hbg_hw_dev_specs_init(struct hbg_priv *priv)
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
+	u32 addr = (dir == HBG_DIR_TX) ? HBG_REG_CF_IND_TXINT_MSK_ADDR :
+					 HBG_REG_CF_IND_RXINT_MSK_ADDR;
+
+	hbg_reg_write_bit(priv, addr, HBG_REG_IND_INTR_MASK_B, enabld);
+}
+
+bool hbg_hw_txrx_intr_is_enabled(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	u32 addr = (dir == HBG_DIR_TX) ? HBG_REG_CF_IND_TXINT_MSK_ADDR :
+					 HBG_REG_CF_IND_RXINT_MSK_ADDR;
+
+	return hbg_reg_read_bit(priv, addr, HBG_REG_IND_INTR_MASK_B);
+}
+
+void hbg_hw_set_txrx_intr_clear(struct hbg_priv *priv, enum hbg_dir dir)
+{
+	u32 addr = (dir == HBG_DIR_TX) ? HBG_REG_CF_IND_TXINT_CLR_ADDR :
+					 HBG_REG_CF_IND_RXINT_CLR_ADDR;
+
+	hbg_reg_write_bit(priv, addr, HBG_REG_IND_INTR_MASK_B, 0x1);
+}
+
+void hbg_hw_get_txrx_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status)
+{
+	status->tx = hbg_reg_read_bit(priv, HBG_REG_CF_IND_TXINT_STAT_ADDR,
+				      HBG_REG_IND_INTR_MASK_B);
+
+	status->rx = hbg_reg_read_bit(priv, HBG_REG_CF_IND_RXINT_STAT_ADDR,
+				      HBG_REG_IND_INTR_MASK_B);
+}
+
+void hbg_hw_get_auto_neg_state(struct hbg_priv *priv, struct hbg_an_state *state)
+{
+	state->bits = hbg_reg_read(priv, HBG_REG_AN_NEG_STATE_ADDR);
+}
+
 int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
 	if (speed != HBG_PORT_MODE_SGMII_10M &&
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 79a529d7212b..e2a08dc5d883 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -57,6 +57,14 @@ static inline void hbg_reg_write64(struct hbg_priv *priv, u32 reg_addr,
 
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
 int hbg_hw_sgmii_autoneg(struct hbg_priv *priv);
 int hbg_hw_init(struct hbg_priv *pri);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
new file mode 100644
index 000000000000..5e90e72d7f24
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include "hbg_irq.h"
+#include "hbg_hw.h"
+#include "hbg_main.h"
+
+#define HBG_VECTOR_NUM		4
+
+static struct hbg_irq_info hbg_irqs[] = {
+	{ "TX", HBG_IRQ_TX, 0 },
+	{ "RX", HBG_IRQ_RX, 0 },
+	{ "RX_BUF_AVL", HBG_IRQ_BUF_AVL, 0 },
+	{ "MAC_MII_FIFO_ERR", HBG_IRQ_MAC_MII_FIFO_ERR, 0 },
+	{ "MAC_PCS_RX_FIFO_ERR", HBG_IRQ_MAC_PCS_RX_FIFO_ERR, 0 },
+	{ "MAC_PCS_TX_FIFO_ERR", HBG_IRQ_MAC_PCS_TX_FIFO_ERR, 0 },
+	{ "MAC_APP_RX_FIFO_ERR", HBG_IRQ_MAC_APP_RX_FIFO_ERR, 0 },
+	{ "MAC_APP_TX_FIFO_ERR", HBG_IRQ_MAC_APP_TX_FIFO_ERR, 0 },
+	{ "SRAM_PARITY_ERR", HBG_IRQ_SRAM_PARITY_ERR, 0 },
+	{ "TX_AHB_ERR", HBG_IRQ_TX_AHB_ERR, 0 },
+	{ "REL_BUF_ERR", HBG_IRQ_REL_BUF_ERR, 0 },
+	{ "TXCFG_AVL", HBG_IRQ_TXCFG_AVL, 0 },
+	{ "TX_DROP", HBG_IRQ_TX_DROP, 0 },
+	{ "RX_DROP", HBG_IRQ_RX_DROP, 0 },
+	{ "RX_AHB_ERR", HBG_IRQ_RX_AHB_ERR, 0 },
+	{ "MAC_FIFO_ERR", HBG_IRQ_MAC_FIFO_ERR, 0 },
+	{ "RBREQ_ERR", HBG_IRQ_RBREQ_ERR, 0 },
+	{ "WE_ERR", HBG_IRQ_WE_ERR, 0 },
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
+	hbg_irq_enable(priv, irq_info->mask, true);
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
+	struct hbg_irq *irq;
+	int ret;
+	int i;
+
+	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
+				    PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_err(&priv->pdev->dev,
+			"failed to allocate MSI vectors, vectors = %d\n", ret);
+		return ret;
+	}
+
+	if (ret != HBG_VECTOR_NUM) {
+		dev_err(&priv->pdev->dev,
+			"requested %u MSI, but allocated %d MSI\n",
+			HBG_VECTOR_NUM, ret);
+		ret = -EINVAL;
+		goto free_vectors;
+	}
+
+	vectors->irqs = devm_kcalloc(&priv->pdev->dev, HBG_VECTOR_NUM,
+				     sizeof(struct hbg_irq), GFP_KERNEL);
+	if (!vectors->irqs) {
+		ret = -ENOMEM;
+		goto free_vectors;
+	}
+
+	/* mdio irq not request */
+	vectors->irq_count = HBG_VECTOR_NUM - 1;
+	for (i = 0; i < vectors->irq_count; i++) {
+		irq = &vectors->irqs[i];
+		snprintf(irq->name, sizeof(irq->name) - 1, "%s-%s-%s",
+			 HBG_DEV_NAME, pci_name(priv->pdev), irq_names_map[i]);
+
+		irq->id = pci_irq_vector(priv->pdev, i);
+		irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
+		ret = request_irq(irq->id, hbg_irq_handle,
+				  0, irq->name, priv);
+		if (ret) {
+			dev_err(&priv->pdev->dev,
+				"failed to requset irq(%d), ret = %d\n",
+				irq->id, ret);
+			goto free_vectors;
+		}
+	}
+
+	vectors->info_array = hbg_irqs;
+	vectors->info_array_len = ARRAY_SIZE(hbg_irqs);
+	return 0;
+
+free_vectors:
+	hbg_irq_uninit(priv);
+	return ret;
+}
+
+void hbg_irq_uninit(void *data)
+{
+	struct hbg_priv *priv = data;
+	struct hbg_vector *vectors;
+	struct hbg_irq *irq;
+	int i;
+
+	vectors = &priv->vectors;
+	for (i = 0; i < vectors->irq_count; i++) {
+		irq = &vectors->irqs[i];
+		if (irq->id > 0) {
+			free_irq(irq->id, priv);
+			irq->id = 0;
+		}
+	}
+
+	pci_free_irq_vectors(priv->pdev);
+	vectors->irqs = NULL;
+	vectors->irq_count = 0;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
new file mode 100644
index 000000000000..27c5e2eca99f
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_IRQ_H
+#define __HBG_IRQ_H
+#include "hbg_common.h"
+
+void hbg_irq_enable(struct hbg_priv *priv, enum hbg_irq_mask mask, bool enable);
+bool hbg_irq_is_enabled(struct hbg_priv *priv, enum hbg_irq_mask mask);
+int hbg_irq_init(struct hbg_priv *priv);
+void hbg_irq_uninit(void *data);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 940e1eef70a4..059ea155572f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
+#include "hbg_irq.h"
 #include "hbg_main.h"
 #include "hbg_mdio.h"
 
@@ -39,6 +40,14 @@ static int hbg_init(struct net_device *netdev)
 	if (ret)
 		return ret;
 
+	ret = hbg_irq_init(priv);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&priv->pdev->dev, hbg_irq_uninit, priv);
+	if (ret)
+		return ret;
+
 	return hbg_mac_init(priv);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index f56893424da2..b422fa990270 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -40,10 +40,19 @@
 #define HBG_REG_RECV_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x01E0)
 
 /* PCU */
+#define HBG_REG_CF_INTRPT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x042C)
+#define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
+#define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
 #define HBG_REG_RX_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04F0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
+#define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
+#define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
+#define HBG_REG_CF_IND_TXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x069C)
+#define HBG_REG_CF_IND_RXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x06a0)
+#define HBG_REG_CF_IND_RXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x06a4)
+#define HBG_REG_CF_IND_RXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x06a8)
 
 /* mask */
 #define HBG_REG_PORT_MODE_M			GENMASK(3, 0)
@@ -62,4 +71,29 @@ enum hbg_port_mode {
 	HBG_PORT_MODE_SGMII_1000M = 0x8,
 };
 
+enum hbg_irq_mask {
+	HBG_IRQ_TX = BIT_MASK(0),
+	HBG_IRQ_RX = BIT_MASK(1),
+
+	/* others in err irq */
+	HBG_IRQ_TX_PKG = BIT_MASK(14),
+	HBG_IRQ_MAC_MII_FIFO_ERR = BIT_MASK(15),
+	HBG_IRQ_MAC_PCS_RX_FIFO_ERR = BIT_MASK(16),
+	HBG_IRQ_MAC_PCS_TX_FIFO_ERR = BIT_MASK(17),
+	HBG_IRQ_MAC_APP_RX_FIFO_ERR = BIT_MASK(18),
+	HBG_IRQ_MAC_APP_TX_FIFO_ERR = BIT_MASK(19),
+	HBG_IRQ_SRAM_PARITY_ERR = BIT_MASK(20),
+	HBG_IRQ_TX_AHB_ERR = BIT_MASK(21),
+	HBG_IRQ_BUF_AVL = BIT_MASK(22),
+	HBG_IRQ_REL_BUF_ERR =  BIT_MASK(23),
+	HBG_IRQ_TXCFG_AVL = BIT_MASK(24),
+	HBG_IRQ_TX_DROP =  BIT_MASK(25),
+	HBG_IRQ_RX_DROP = BIT_MASK(26),
+	HBG_IRQ_RX_PKG =  BIT_MASK(27),
+	HBG_IRQ_RX_AHB_ERR =  BIT_MASK(28),
+	HBG_IRQ_MAC_FIFO_ERR = BIT_MASK(29),
+	HBG_IRQ_RBREQ_ERR = BIT_MASK(30),
+	HBG_IRQ_WE_ERR = BIT_MASK(31),
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


