Return-Path: <netdev+bounces-121793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF9895EBAF
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C83281889
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44124140E37;
	Mon, 26 Aug 2024 08:19:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B213B593;
	Mon, 26 Aug 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660394; cv=none; b=mAnx+n+GTvN9f+cm+3gOUKhrSAOiydM2iP6Psq6pZHeF5S3Kt6m4Q3KJVmzlIMDeyaJjELRe9mmxLv2c28NOypAs1WjsR31NEza4quXe0cq0urbEVDyBuv01vWAaYkqIU8/fiUnGd9oGFJvhHBlxEd8t196/W5/1FKiDX6SuL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660394; c=relaxed/simple;
	bh=c6FJFslXpa5vPjHCBellGjFnIVvoZwv/nFRM3M7JLwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNd+4gNyvYgjkRb+4j13lbtcXe/BPf0d9vb2U701Fb3He0Xr48lHPxkfCxZXy0Jl3fD5N5gP0mgXeBcZ12CmlhWY82avET+28EPt0doQ+2unew95+ygSIonv6r1i5i3IZZ5J3lQl2HIzxC9O8s1y1sw7nKimu7q/qUOO1BiAxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wsk4Q1QF9z20mgl;
	Mon, 26 Aug 2024 16:15:02 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 37E57140135;
	Mon, 26 Aug 2024 16:19:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 16:19:48 +0800
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
Subject: [PATCH V4 net-next 04/11] net: hibmcge: Add interrupt supported in this module
Date: Mon, 26 Aug 2024 16:12:51 +0800
Message-ID: <20240826081258.1881385-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240826081258.1881385-1-shaojijie@huawei.com>
References: <20240826081258.1881385-1-shaojijie@huawei.com>
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
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  18 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  55 +++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   4 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 112 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  11 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  27 +++++
 7 files changed, 232 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index e047539a407a..e94ae2be5c4c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -13,6 +13,7 @@
 #define HBG_DEFAULT_MTU_SIZE		1500
 #define HBG_RX_SKIP1			0x00
 #define HBG_RX_SKIP2			0x01
+#define HBG_VECTOR_NUM			4
 
 enum hbg_nic_state {
 	HBG_NIC_STATE_EVENT_HANDLING = 0,
@@ -38,6 +39,22 @@ struct hbg_dev_specs {
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
@@ -56,6 +73,7 @@ struct hbg_priv {
 	struct hbg_dev_specs dev_specs;
 	unsigned long state;
 	struct hbg_mac mac;
+	struct hbg_vector vectors;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 61769bad284c..f7a7c8524546 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -70,6 +70,61 @@ static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
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
index 88fa378db757..09946c3966ff 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -43,5 +43,9 @@ static inline void hbg_reg_write64(struct hbg_priv *priv, u32 addr, u64 value)
 
 int hbg_hw_init(struct hbg_priv *pri);
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
+u32 hbg_hw_get_irq_status(struct hbg_priv *priv);
+void hbg_hw_irq_clear(struct hbg_priv *priv, u32 mask);
+bool hbg_hw_irq_is_enabled(struct hbg_priv *priv, u32 mask);
+void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
new file mode 100644
index 000000000000..82f40f2eba3f
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -0,0 +1,112 @@
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
index 132711554c1e..fb0e87c8fef7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
+#include "hbg_irq.h"
 #include "hbg_mdio.h"
 
 static int hbg_init(struct hbg_priv *priv)
@@ -16,6 +17,10 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	ret = hbg_irq_init(priv);
+	if (ret)
+		return ret;
+
 	return hbg_mdio_init(priv);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 81e6d6e9a429..cdc28549336e 100644
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
+#define HBG_INT_MSK_REL_BUF_ERR_B			BIT(23)
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


