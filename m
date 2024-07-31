Return-Path: <netdev+bounces-114481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C282C942B26
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BC6284F58
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A671AB505;
	Wed, 31 Jul 2024 09:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80616B395;
	Wed, 31 Jul 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419306; cv=none; b=YpaQsLhg0QkjMLqN9MHj//gyn4AOqRcup4BLlc+1XNVRrqe5O50Yz/AUbhbdJdUiFqOIV1BVXGWXqWu/5LImvaa7zGodO4kzB7o9yDB0ZivEnbWkUqBUoKwUTqSNDNBD2kpwFquspG0N+NN96YxQ4NjO4Mv5B74+JLaSWD3eEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419306; c=relaxed/simple;
	bh=3aDx/Y7LxrwtcqaM5UnEaPSGvKwNWMBHgsCYFTL5FpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaQ9Mm8Q8J2HZpAIoc3BPSMOw0YkkZnXl5cgLbWCVzkxGPWCDAoaOT8kdXM7pFYEj1Ke5g7dUqLJxYykuzmS4geFInYDMqqBfLjOaKcUKD2JeUutvBxU0d+KJh2e26Ow81ZIecR2sC6AtgJWrbyhh1Z7aR9K+Gm0sMxo3AUCMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WYnL32XRjz17MyP;
	Wed, 31 Jul 2024 17:46:35 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 79C511A0188;
	Wed, 31 Jul 2024 17:48:20 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:48:19 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next 01/10] net: hibmcge: Add pci table supported in this module
Date: Wed, 31 Jul 2024 17:42:36 +0800
Message-ID: <20240731094245.1967834-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731094245.1967834-1-shaojijie@huawei.com>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Add pci table supported in this module, and implement pci_driver function
to initialize this driver.

hibmcge is a passthrough network device. Its software runs
on the host side, and the MAC hardware runs on the BMC side
to reduce the host CPU area. The software interacts with the
MAC hardware through the PCIe.

  ┌─────────────────────────┐
  │ HOST CPU network device │
  │    ┌──────────────┐     │
  │    │hibmcge driver│     │
  │    └─────┬─┬──────┘     │
  │          │ │            │
  │HOST  ┌───┴─┴───┐        │
  │      │ PCIE RC │        │
  └──────┴───┬─┬───┴────────┘
             │ │
            PCIE
             │ │
  ┌──────┬───┴─┴───┬────────┐
  │      │ PCIE EP │        │
  │BMC   └───┬─┬───┘        │
  │          │ │            │
  │ ┌────────┴─┴──────────┐ │
  │ │        GE           │ │
  │ │ ┌─────┐    ┌─────┐  │ │
  │ │ │ MAC │    │ MAC │  │ │
  └─┴─┼─────┼────┼─────┼──┴─┘
      │ PHY │    │ PHY │
      └─────┘    └─────┘

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 16 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 83 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.h | 13 +++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
new file mode 100644
index 000000000000..e08e28f25f3c
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_COMMON_H
+#define __HBG_COMMON_H
+
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+
+struct hbg_priv {
+	struct net_device *netdev;
+	struct pci_dev *pdev;
+	u8 __iomem *io_base;
+};
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
new file mode 100644
index 000000000000..30cc19e71c54
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include "hbg_common.h"
+#include "hbg_main.h"
+
+static int hbg_pci_init(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct hbg_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable PCI device\n");
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set consistent PCI DMA\n");
+
+	ret = pcim_iomap_regions(pdev, BIT(HBG_MEM_BAR), HBG_DEV_NAME);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to map PCI bar space");
+
+	priv->io_base = pcim_iomap_table(pdev)[HBG_MEM_BAR];
+	pci_set_master(pdev);
+	return 0;
+}
+
+static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct net_device *netdev;
+	struct hbg_priv *priv;
+	int ret;
+
+	netdev = devm_alloc_etherdev_mqs(&pdev->dev,
+					 sizeof(struct hbg_priv), 1, 1);
+	if (!netdev)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, netdev);
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	priv->pdev = pdev;
+
+	ret = hbg_pci_init(pdev);
+	if (ret)
+		return ret;
+
+	ret = devm_register_netdev(&pdev->dev, netdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register netdev\n");
+
+	return 0;
+}
+
+static const struct pci_device_id hbg_pci_tbl[] = {
+	{PCI_VDEVICE(HUAWEI, 0x3730), 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, hbg_pci_tbl);
+
+static struct pci_driver hbg_driver = {
+	.name		= HBG_DEV_NAME,
+	.id_table	= hbg_pci_tbl,
+	.probe		= hbg_probe,
+};
+module_pci_driver(hbg_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
+MODULE_DESCRIPTION("hibmcge driver");
+MODULE_VERSION(HBG_MOD_VERSION);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h
new file mode 100644
index 000000000000..f9652e5c06b2
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_MAIN_H
+#define __HBG_MAIN_H
+
+#include <linux/io.h>
+
+#define HBG_DEV_NAME	"hibmcge"
+#define HBG_MEM_BAR	0
+#define HBG_MOD_VERSION	"1.0"
+
+#endif
-- 
2.33.0


