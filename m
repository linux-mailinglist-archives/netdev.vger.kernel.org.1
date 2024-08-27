Return-Path: <netdev+bounces-122330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8FC960BD1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CA0286AA0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A461C2DD6;
	Tue, 27 Aug 2024 13:22:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3D1BDA93;
	Tue, 27 Aug 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764942; cv=none; b=R6XnCo/jZwGfXMip/arTtJtKxJm+S5GSosagxeAaqWhL6LtRr8+4iEassLt2heH+m8TPn1xbDbzJAKVUwJzwj13Ajjuy89LytR3hyt7puxR3P4nuHfSJAAHjSD6f2m1PFGBkfhwNkZUn8kU/J+EiSFQsrj/xifJa7wjkhzlfRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764942; c=relaxed/simple;
	bh=UB5faQ62U6sw1C88heFP06iDMQHgvY1ml+UcwPySxIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHLl1VlHAR42pCj46alJXdjhqkrUWMuGig3bu0AcAeokryQbr46BJA8XBRZk9hu+PIVk/JdiUQ/kHUs4+MaI4uEK1E6rpC1J7QJxYB13oBa+8k2ZfEmaWPm5SEhjvq71P5qf6/hIK/Z96dfvi47NYUnHj8KchYJB3YvGKJicIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtSmf1h5Xz1HHGm;
	Tue, 27 Aug 2024 21:18:58 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 00DE618002B;
	Tue, 27 Aug 2024 21:22:17 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 21:22:16 +0800
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
Subject: [PATCH V5 net-next 02/11] net: hibmcge: Add read/write registers supported through the bar space
Date: Tue, 27 Aug 2024 21:14:46 +0800
Message-ID: <20240827131455.2919051-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240827131455.2919051-1-shaojijie@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
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
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 26 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 82 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   | 32 ++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 10 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 20 +++++
 5 files changed, 170 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 614650e9a71f..6fbc24803942 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -7,10 +7,36 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 
+enum hbg_nic_state {
+	HBG_NIC_STATE_EVENT_HANDLING = 0,
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
+	u32 mdio_frequency;
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
index 000000000000..677f81022411
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/iopoll.h>
+#include <linux/minmax.h>
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
+static int hbg_hw_event_notify(struct hbg_priv *priv,
+			       enum hbg_hw_event_type event_type)
+{
+#define HBG_HW_EVENT_WAIT_TIMEOUT_US	(2 * 1000 * 1000)
+#define HBG_HW_EVENT_WAIT_INTERVAL_US	(10 * 1000)
+
+	bool is_valid;
+	int ret;
+
+	if (test_and_set_bit(HBG_NIC_STATE_EVENT_HANDLING, &priv->state))
+		return -EBUSY;
+
+	/* notify */
+	hbg_reg_write(priv, HBG_REG_EVENT_REQ_ADDR, event_type);
+
+	ret = read_poll_timeout(hbg_hw_spec_is_valid, is_valid, is_valid,
+				HBG_HW_EVENT_WAIT_INTERVAL_US,
+				HBG_HW_EVENT_WAIT_TIMEOUT_US,
+				HBG_HW_EVENT_WAIT_INTERVAL_US, priv);
+
+	clear_bit(HBG_NIC_STATE_EVENT_HANDLING, &priv->state);
+
+	if (ret)
+		dev_err(&priv->pdev->dev, "event %d wait timeout\n", event_type);
+
+	return ret;
+}
+
+static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
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
+	dev_specs->mdio_frequency = hbg_reg_read(priv, HBG_REG_MDIO_FREQ_ADDR);
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
+
+int hbg_hw_init(struct hbg_priv *priv)
+{
+	int ret;
+
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
+	if (ret)
+		return ret;
+
+	return hbg_hw_dev_specs_init(priv);
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
new file mode 100644
index 000000000000..7460701412a1
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_HW_H
+#define __HBG_HW_H
+
+#include <linux/bitfield.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+static inline u32 hbg_reg_read(struct hbg_priv *priv, u32 addr)
+{
+	return readl(priv->io_base + addr);
+}
+
+static inline void hbg_reg_write(struct hbg_priv *priv, u32 addr, u32 value)
+{
+	writel(value, priv->io_base + addr);
+}
+
+static inline u64 hbg_reg_read64(struct hbg_priv *priv, u32 addr)
+{
+	return lo_hi_readq(priv->io_base + addr);
+}
+
+static inline void hbg_reg_write64(struct hbg_priv *priv, u32 addr, u64 value)
+{
+	lo_hi_writeq(value, priv->io_base + addr);
+}
+
+int hbg_hw_init(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 9195c7fb13e3..a5c12c4b7d89 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -5,6 +5,12 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
+#include "hbg_hw.h"
+
+static int hbg_init(struct hbg_priv *priv)
+{
+	return hbg_hw_init(priv);
+}
 
 static int hbg_pci_init(struct pci_dev *pdev)
 {
@@ -56,6 +62,10 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	ret = hbg_init(priv);
+	if (ret)
+		return ret;
+
 	ret = devm_register_netdev(dev, netdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register netdev\n");
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
new file mode 100644
index 000000000000..77153f1132fd
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -0,0 +1,20 @@
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
+#define HBG_REG_MDIO_FREQ_ADDR			0x0024
+#define HBG_REG_MAX_MTU_ADDR			0x0028
+#define HBG_REG_MIN_MTU_ADDR			0x002C
+#define HBG_REG_TX_FIFO_NUM_ADDR		0x0030
+#define HBG_REG_RX_FIFO_NUM_ADDR		0x0034
+#define HBG_REG_VLAN_LAYERS_ADDR		0x0038
+
+#endif
-- 
2.33.0


