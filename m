Return-Path: <netdev+bounces-114483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A25942B28
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C49E1F24B7E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D441AC429;
	Wed, 31 Jul 2024 09:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F71A7F7B;
	Wed, 31 Jul 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419306; cv=none; b=QNojjorFBt+pUsKjIEvlceoRo90xUqu71PHiHrRCgnHTHcUI0QhCZr8xvkmj3o8VRfg1WT4EwPh9dqE0ySInjQSM0a4thexD4Cax+rpdYLTdHC2+qdi4rLjwhVwYYg653iaLRuuZA6a3U309NyGOujxog76+6RXPgw5MZh8rX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419306; c=relaxed/simple;
	bh=xSps3YoAiy8TmFJBzT7Uryd8Y+0+ESxAfr1i7nUb3Nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ethmrR1+Xg0tCvGFUe1Lsd2dkaXRWRHZk/+Qp2L5S4HGUC+ixDcz/Fqkg82rmQIn43jOh9rHDAqD3TUPqiaiuHNFpxuhGsvOggR+M8LUnlj9kzMmZ3htP8FiNwyST3R9oLIqq/wDX+XshrNq0jiXLgkKfN0l0ezEPABtGTf/Gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYnJr0lBrz1HFlB;
	Wed, 31 Jul 2024 17:45:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 0066F1A016C;
	Wed, 31 Jul 2024 17:48:21 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:48:20 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next 02/10] net: hibmcge: Add read/write registers supported through the bar space
Date: Wed, 31 Jul 2024 17:42:37 +0800
Message-ID: <20240731094245.1967834-3-shaojijie@huawei.com>
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

Add support for to read and write registers through the pic bar space.

Some driver parameters, such as mac_id, are determined by the
board form. Therefore, these parameters are initialized
from the register as device specifications.

the device specifications register are initialized and writed by bmc.
driver will read these registers when loading.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 26 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 72 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   | 61 ++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 18 +++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 19 +++++
 5 files changed, 196 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index e08e28f25f3c..b56b5179f735 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -7,10 +7,36 @@
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
 
+enum hbg_nic_state {
+	HBG_NIC_STATE_INITED = 0,
+	HBG_NIC_STATE_EVENT_HANDLING,
+};
+
+enum hbg_hw_event_type {
+	HBG_HW_EVENT_NONE = 0,
+	HBG_HW_EVENT_INIT, /* driver is loading */
+};
+
+struct hbg_dev_specs {
+	u32 mac_id;
+	struct sockaddr mac_addr;
+	u32 phy_addr;
+	u32 rx_fifo_num;
+	u32 tx_fifo_num;
+	u32 vlan_layers;
+	u32 max_mtu;
+	u32 min_mtu;
+
+	u32 max_frame_len;
+	u32 rx_buf_size;
+};
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	u8 __iomem *io_base;
+	struct hbg_dev_specs dev_specs;
+	unsigned long state;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
new file mode 100644
index 000000000000..ca1cb09c90ff
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/minmax.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include "hbg_common.h"
+#include "hbg_hw.h"
+#include "hbg_reg.h"
+
+static bool hbg_hw_spec_is_valid(struct hbg_priv *priv)
+{
+	return hbg_reg_read(priv, HBG_REG_SPEC_VALID_ADDR) &&
+	       !hbg_reg_read(priv, HBG_REG_EVENT_REQ_ADDR);
+}
+
+int hbg_hw_event_notify(struct hbg_priv *priv, enum hbg_hw_event_type event_type)
+{
+#define HBG_HW_EVENT_WAIT_TIMEOUT_MS	(2 * 1000)
+#define HBG_HW_EVENT_WAIT_INTERVAL_MS	100
+
+	u32 timeout = 0;
+
+	if (test_and_set_bit(HBG_NIC_STATE_EVENT_HANDLING, &priv->state))
+		return -EBUSY;
+
+	/* notify */
+	hbg_reg_write(priv, HBG_REG_EVENT_REQ_ADDR, event_type);
+
+	do {
+		msleep(HBG_HW_EVENT_WAIT_INTERVAL_MS);
+		timeout += HBG_HW_EVENT_WAIT_INTERVAL_MS;
+
+		if (hbg_hw_spec_is_valid(priv))
+			break;
+	} while (timeout <= HBG_HW_EVENT_WAIT_TIMEOUT_MS);
+
+	clear_bit(HBG_NIC_STATE_EVENT_HANDLING, &priv->state);
+
+	if (!hbg_hw_spec_is_valid(priv)) {
+		dev_err(&priv->pdev->dev, "event %d wait timeout\n", event_type);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+int hbg_hw_dev_specs_init(struct hbg_priv *priv)
+{
+	struct hbg_dev_specs *dev_specs = &priv->dev_specs;
+	u64 mac_addr;
+
+	if (!hbg_hw_spec_is_valid(priv)) {
+		dev_err(&priv->pdev->dev, "dev_specs not init\n");
+		return -EINVAL;
+	}
+
+	dev_specs->mac_id = hbg_reg_read(priv, HBG_REG_MAC_ID_ADDR);
+	dev_specs->phy_addr = hbg_reg_read(priv, HBG_REG_PHY_ID_ADDR);
+	dev_specs->max_mtu = hbg_reg_read(priv, HBG_REG_MAX_MTU_ADDR);
+	dev_specs->min_mtu = hbg_reg_read(priv, HBG_REG_MIN_MTU_ADDR);
+	dev_specs->vlan_layers = hbg_reg_read(priv, HBG_REG_VLAN_LAYERS_ADDR);
+	dev_specs->rx_fifo_num = hbg_reg_read(priv, HBG_REG_RX_FIFO_NUM_ADDR);
+	dev_specs->tx_fifo_num = hbg_reg_read(priv, HBG_REG_TX_FIFO_NUM_ADDR);
+	mac_addr = hbg_reg_read64(priv, HBG_REG_MAC_ADDR_ADDR);
+	u64_to_ether_addr(mac_addr, (u8 *)dev_specs->mac_addr.sa_data);
+
+	if (!is_valid_ether_addr((u8 *)dev_specs->mac_addr.sa_data))
+		return -EADDRNOTAVAIL;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
new file mode 100644
index 000000000000..61c6db948364
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_HW_H
+#define __HBG_HW_H
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+static inline u32 hbg_reg_read(struct hbg_priv *priv, u32 reg_addr)
+{
+	return readl(priv->io_base + reg_addr);
+}
+
+static inline void hbg_reg_write(struct hbg_priv *priv, u32 reg_addr, u32 value)
+{
+	writel(value, priv->io_base + reg_addr);
+}
+
+static inline u32 hbg_reg_read_field(struct hbg_priv *priv, u32 reg_addr,
+				     u32 mask)
+{
+	return FIELD_GET(mask, hbg_reg_read(priv, reg_addr));
+}
+
+static inline void hbg_reg_write_field(struct hbg_priv *priv,  u32 reg_addr,
+				       u32 mask, u32 val)
+{
+	u32 reg_value = hbg_reg_read(priv, reg_addr);
+
+	reg_value &= ~mask;
+	reg_value |= FIELD_PREP(mask, val);
+	hbg_reg_write(priv, reg_addr, reg_value);
+}
+
+static inline u32 hbg_reg_read_bit(struct hbg_priv *priv,  u32 reg_addr,
+				   u32 mask)
+{
+	return hbg_reg_read_field(priv, reg_addr, mask);
+}
+
+static inline void hbg_reg_write_bit(struct hbg_priv *priv, u32 reg_addr,
+				     u32 mask, u32 val)
+{
+	hbg_reg_write_field(priv, reg_addr, mask, val);
+}
+
+static inline u64 hbg_reg_read64(struct hbg_priv *priv, u32 reg_addr)
+{
+	return lo_hi_readq(priv->io_base + reg_addr);
+}
+
+static inline void hbg_reg_write64(struct hbg_priv *priv, u32 reg_addr,
+				   u64 value)
+{
+	lo_hi_writeq(value, priv->io_base + reg_addr);
+}
+
+int hbg_hw_event_notify(struct hbg_priv *priv, enum hbg_hw_event_type event_type);
+int hbg_hw_dev_specs_init(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 30cc19e71c54..df0fc6a1059b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -5,8 +5,21 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
+#include "hbg_hw.h"
 #include "hbg_main.h"
 
+static int hbg_init(struct net_device *netdev)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
+	if (ret)
+		return ret;
+
+	return hbg_hw_dev_specs_init(priv);
+}
+
 static int hbg_pci_init(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -56,11 +69,16 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	ret = hbg_init(netdev);
+	if (ret)
+		return ret;
+
 	ret = devm_register_netdev(&pdev->dev, netdev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register netdev\n");
 
+	set_bit(HBG_NIC_STATE_INITED, &priv->state);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
new file mode 100644
index 000000000000..4c34516e0c89
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_REG_H
+#define __HBG_REG_H
+
+/* DEV SPEC */
+#define HBG_REG_SPEC_VALID_ADDR			0x0000
+#define HBG_REG_EVENT_REQ_ADDR			0x0004
+#define HBG_REG_MAC_ID_ADDR			0x0008
+#define HBG_REG_PHY_ID_ADDR			0x000C
+#define HBG_REG_MAC_ADDR_ADDR			0x0010
+#define HBG_REG_MAX_MTU_ADDR			0x0028
+#define HBG_REG_MIN_MTU_ADDR			0x002C
+#define HBG_REG_TX_FIFO_NUM_ADDR		0x0030
+#define HBG_REG_RX_FIFO_NUM_ADDR		0x0034
+#define HBG_REG_VLAN_LAYERS_ADDR		0x0038
+
+#endif
-- 
2.33.0


