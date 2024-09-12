Return-Path: <netdev+bounces-127659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2427F975F6A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8291F240A0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64706155743;
	Thu, 12 Sep 2024 02:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766A13D278;
	Thu, 12 Sep 2024 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109854; cv=none; b=ePE4tZ9jDgNYz7qHoKC7k8Xx84M4OXEsqAhurez4yTa8KDm6HoCBS6UBWXyVOqksxqs7Z2ZoFnJ9soEoS+IAhDxhWV4/QXkzdjCZUlYqMMFl3sp72o/Ngdfsn/8c+Nn3ocgARkWPutSxeFs/LjowA8lwrcf8Pi01z8Siry2gK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109854; c=relaxed/simple;
	bh=aSo3q5kLLTtaa/IjqA+d6/3PDvRRZwwKe5eSxFcsbEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acWmZ9gRKZzW5YsZ6ywydUH9jRrrSEkVD3KRrSn9ooMzfM+4/zk6QHMwzUq8Y+PCr+sOvbRjpueS6njTFg9Ht0wb92dMAP1rYL+yR8sSKox7oK+5o8uT1oK+pn0uahFfjw8Gu5pQflfhtzwJZdQ9x3YYBSZspHUutM7cy3T+uII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X429m0jB9zmV6x;
	Thu, 12 Sep 2024 10:55:24 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D43B140132;
	Thu, 12 Sep 2024 10:57:28 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 10:57:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V10 net-next 04/10] net: hibmcge: Add interrupt supported in this module
Date: Thu, 12 Sep 2024 10:51:21 +0800
Message-ID: <20240912025127.3912972-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240912025127.3912972-1-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
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

This patch implements interrupt request, and provides a
unified entry for the interrupt handler function. However,
the specific interrupt handler function of each interrupt
is not implemented currently.

Because of pcim_enable_device(), the interrupt vector
is already device managed and does not need to be free actively.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
RFC v1 -> RFC v2:
  - Replace request_irq with devm_request_irq, suggested by Jonathan.
  - Replace BIT_MASK() with BIT(), suggested by Jonathan.
  - Introduce irq_handle in struct hbg_irq_info in advance to reduce code changes,
    suggested by Jonathan.
  RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  18 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  55 +++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   4 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 113 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  11 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  27 +++++
 7 files changed, 233 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index bb88a37518cb..ee4890d91ddd 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -12,6 +12,7 @@
 #define HBG_STATUS_ENABLE		0x1
 #define HBG_RX_SKIP1			0x00
 #define HBG_RX_SKIP2			0x01
+#define HBG_VECTOR_NUM			4
 
 enum hbg_nic_state {
 	HBG_NIC_STATE_EVENT_HANDLING = 0,
@@ -37,6 +38,22 @@ struct hbg_dev_specs {
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
@@ -55,6 +72,7 @@ struct hbg_priv {
 	struct hbg_dev_specs dev_specs;
 	unsigned long state;
 	struct hbg_mac mac;
+	struct hbg_vector vectors;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index b1281b206f2f..8e971e9f62a0 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -74,6 +74,61 @@ static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	return 0;
 }
 
+u32 hbg_hw_get_irq_status(struct hbg_priv *priv)
+{
+	u32 status;
+
+	status = hbg_reg_read(priv, HBG_REG_CF_INTRPT_STAT_ADDR);
+
+	status |= FIELD_PREP(HBG_INT_MSK_TX_B,
+			     hbg_reg_read(priv, HBG_REG_CF_IND_TXINT_STAT_ADDR));
+	status |= FIELD_PREP(HBG_INT_MSK_RX_B,
+			     hbg_reg_read(priv, HBG_REG_CF_IND_RXINT_STAT_ADDR));
+
+	return status;
+}
+
+void hbg_hw_irq_clear(struct hbg_priv *priv, u32 mask)
+{
+	if (FIELD_GET(HBG_INT_MSK_TX_B, mask))
+		return hbg_reg_write(priv, HBG_REG_CF_IND_TXINT_CLR_ADDR, 0x1);
+
+	if (FIELD_GET(HBG_INT_MSK_RX_B, mask))
+		return hbg_reg_write(priv, HBG_REG_CF_IND_RXINT_CLR_ADDR, 0x1);
+
+	return hbg_reg_write(priv, HBG_REG_CF_INTRPT_CLR_ADDR, mask);
+}
+
+bool hbg_hw_irq_is_enabled(struct hbg_priv *priv, u32 mask)
+{
+	if (FIELD_GET(HBG_INT_MSK_TX_B, mask))
+		return hbg_reg_read(priv, HBG_REG_CF_IND_TXINT_MSK_ADDR);
+
+	if (FIELD_GET(HBG_INT_MSK_RX_B, mask))
+		return hbg_reg_read(priv, HBG_REG_CF_IND_RXINT_MSK_ADDR);
+
+	return hbg_reg_read(priv, HBG_REG_CF_INTRPT_MSK_ADDR) & mask;
+}
+
+void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable)
+{
+	u32 value;
+
+	if (FIELD_GET(HBG_INT_MSK_TX_B, mask))
+		return hbg_reg_write(priv, HBG_REG_CF_IND_TXINT_MSK_ADDR, enable);
+
+	if (FIELD_GET(HBG_INT_MSK_RX_B, mask))
+		return hbg_reg_write(priv, HBG_REG_CF_IND_RXINT_MSK_ADDR, enable);
+
+	value = hbg_reg_read(priv, HBG_REG_CF_INTRPT_MSK_ADDR);
+	if (enable)
+		value |= mask;
+	else
+		value &= ~mask;
+
+	hbg_reg_write(priv, HBG_REG_CF_INTRPT_MSK_ADDR, value);
+}
+
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
 	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 47df597b885f..4d09bdd41c76 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -45,5 +45,9 @@ int hbg_hw_event_notify(struct hbg_priv *priv,
 			enum hbg_hw_event_type event_type);
 int hbg_hw_init(struct hbg_priv *priv);
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
+u32 hbg_hw_get_irq_status(struct hbg_priv *priv);
+void hbg_hw_irq_clear(struct hbg_priv *priv, u32 mask);
+bool hbg_hw_irq_is_enabled(struct hbg_priv *priv, u32 mask);
+void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
new file mode 100644
index 000000000000..0a70853a4928
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -0,0 +1,113 @@
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
+			"receive error interrupt: %s\n", irq_info->name);
+}
+
+#define HBG_TXRX_IRQ_I(name, handle) \
+	{#name, HBG_INT_MSK_##name##_B, false, false, 0, handle}
+#define HBG_ERR_IRQ_I(name, need_print) \
+	{#name, HBG_INT_MSK_##name##_B, true, need_print, 0, hbg_irq_handle_err}
+
+static struct hbg_irq_info hbg_irqs[] = {
+	HBG_TXRX_IRQ_I(RX, NULL),
+	HBG_TXRX_IRQ_I(TX, NULL),
+	HBG_ERR_IRQ_I(MAC_MII_FIFO_ERR, true),
+	HBG_ERR_IRQ_I(MAC_PCS_RX_FIFO_ERR, true),
+	HBG_ERR_IRQ_I(MAC_PCS_TX_FIFO_ERR, true),
+	HBG_ERR_IRQ_I(MAC_APP_RX_FIFO_ERR, true),
+	HBG_ERR_IRQ_I(MAC_APP_TX_FIFO_ERR, true),
+	HBG_ERR_IRQ_I(SRAM_PARITY_ERR, true),
+	HBG_ERR_IRQ_I(TX_AHB_ERR, true),
+	HBG_ERR_IRQ_I(RX_BUF_AVL, false),
+	HBG_ERR_IRQ_I(REL_BUF_ERR, true),
+	HBG_ERR_IRQ_I(TXCFG_AVL, false),
+	HBG_ERR_IRQ_I(TX_DROP, false),
+	HBG_ERR_IRQ_I(RX_DROP, false),
+	HBG_ERR_IRQ_I(RX_AHB_ERR, true),
+	HBG_ERR_IRQ_I(MAC_FIFO_ERR, false),
+	HBG_ERR_IRQ_I(RBREQ_ERR, false),
+	HBG_ERR_IRQ_I(WE_ERR, false),
+};
+
+static irqreturn_t hbg_irq_handle(int irq_num, void *p)
+{
+	struct hbg_irq_info *info;
+	struct hbg_priv *priv = p;
+	u32 status;
+	u32 i;
+
+	status = hbg_hw_get_irq_status(priv);
+	for (i = 0; i < priv->vectors.info_array_len; i++) {
+		info = &priv->vectors.info_array[i];
+		if (status & info->mask) {
+			if (!hbg_hw_irq_is_enabled(priv, info->mask))
+				continue;
+
+			hbg_hw_irq_enable(priv, info->mask, false);
+			hbg_hw_irq_clear(priv, info->mask);
+
+			info->count++;
+			if (info->irq_handle)
+				info->irq_handle(priv, info);
+
+			if (info->reenable)
+				hbg_hw_irq_enable(priv, info->mask, true);
+		}
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
+	/* used pcim_enable_device(),  so the vectors become device managed */
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
index 000000000000..5c5323cfc751
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_IRQ_H
+#define __HBG_IRQ_H
+
+#include "hbg_common.h"
+
+int hbg_irq_init(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 22b6557247c4..29e0513fa836 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
+#include "hbg_irq.h"
 #include "hbg_mdio.h"
 
 static int hbg_init(struct hbg_priv *priv)
@@ -20,6 +21,10 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	ret = hbg_irq_init(priv);
+	if (ret)
+		return ret;
+
 	return hbg_mdio_init(priv);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 81e6d6e9a429..b0991063ccba 100644
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
+#define HBG_INT_MSK_REL_BUF_ERR_B		BIT(23)
+#define HBG_INT_MSK_RX_BUF_AVL_B		BIT(22)
+#define HBG_INT_MSK_TX_AHB_ERR_B		BIT(21)
+#define HBG_INT_MSK_SRAM_PARITY_ERR_B		BIT(20)
+#define HBG_INT_MSK_MAC_APP_TX_FIFO_ERR_B	BIT(19)
+#define HBG_INT_MSK_MAC_APP_RX_FIFO_ERR_B	BIT(18)
+#define HBG_INT_MSK_MAC_PCS_TX_FIFO_ERR_B	BIT(17)
+#define HBG_INT_MSK_MAC_PCS_RX_FIFO_ERR_B	BIT(16)
+#define HBG_INT_MSK_MAC_MII_FIFO_ERR_B		BIT(15)
+#define HBG_INT_MSK_TX_B			BIT(1) /* just used in driver */
+#define HBG_INT_MSK_RX_B			BIT(0) /* just used in driver */
+#define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
+#define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
@@ -64,6 +85,12 @@
 #define HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M	GENMASK(3, 0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
 #define HBG_REG_RX_PKT_MODE_PARSE_MODE_M	GENMASK(22, 21)
+#define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
+#define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
+#define HBG_REG_CF_IND_TXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x069C)
+#define HBG_REG_CF_IND_RXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x06a0)
+#define HBG_REG_CF_IND_RXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x06a4)
+#define HBG_REG_CF_IND_RXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x06a8)
 
 enum hbg_port_mode {
 	/* 0x0 ~ 0x5 are reserved */
-- 
2.33.0


