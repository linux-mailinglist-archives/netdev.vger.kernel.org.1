Return-Path: <netdev+bounces-125579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474296DC08
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03F4289256
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEFE19EEBF;
	Thu,  5 Sep 2024 14:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5677F10;
	Thu,  5 Sep 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547045; cv=none; b=anQD+HlfAQpI8/aZtMtzPBsleLIV10BteK6yYeexc/HYeajHpfEqIjKM8xDtj/eQ7C+5edm7vbLFQqoU8DT3lCwtiHWz3HoLJBEAsklBQdV3wf/lEB++N0ynQQi8RUXKqN5UZ39gAwLCIQuMYQoLehxNVM0Z6jES92jiv+RA//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547045; c=relaxed/simple;
	bh=HXG6TB0vpDDMwf0Ij2NpFpKnGax4Lbnmrh32IWfuDII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGtnpY8aUfgSaECMj+1maEwqG+EBSqZhNXdx80DWmJqFekrcMru2eTsbviMX22JCtKcp6En9xsznBsSD2KbPgEU20Uc5NqkeGaycHE1rlzobMs1OyyhqQQ7bmY/fETZw9w06kb/TGQzcZ2Y2Gjc4z6OZCytRJXysAOq4ZKRqVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X024M6smxz1S9l5;
	Thu,  5 Sep 2024 22:36:51 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B4FF14037C;
	Thu,  5 Sep 2024 22:37:14 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 22:37:13 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <shaojijie@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <zhuyuan@huawei.com>, <forest.zhouchang@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V7 net-next 01/11] net: hibmcge: Add pci table supported in this module
Date: Thu, 5 Sep 2024 22:31:10 +0800
Message-ID: <20240905143120.1583460-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240905143120.1583460-1-shaojijie@huawei.com>
References: <20240905143120.1583460-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
ChangeLog:
v6 -> v7:
  - Add devm_netdev_alloc_pcpu_stats() to init netdev->tstats,
    suggested by Paolo.
  v6: https://lore.kernel.org/all/20240830121604.2250904-2-shaojijie@huawei.com/
RFC v1 -> RFC v2:
  - Add the null pointer check on the return value of pcim_iomap_table(),
    suggested by Jonathan.
  RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 16 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 88 +++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
new file mode 100644
index 000000000000..614650e9a71f
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_COMMON_H
+#define __HBG_COMMON_H
+
+#include <linux/netdevice.h>
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
index 000000000000..b3e55ea36d7c
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include "hbg_common.h"
+
+static int hbg_pci_init(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable PCI device\n");
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set PCI DMA mask\n");
+
+	ret = pcim_iomap_regions(pdev, BIT(0), dev_driver_string(dev));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to map PCI bar space\n");
+
+	priv->io_base = pcim_iomap_table(pdev)[0];
+	if (!priv->io_base)
+		return dev_err_probe(dev, -ENOMEM, "failed to get io base\n");
+
+	pci_set_master(pdev);
+	return 0;
+}
+
+static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct net_device *netdev;
+	struct hbg_priv *priv;
+	int ret;
+
+	netdev = devm_alloc_etherdev_mqs(dev, sizeof(struct hbg_priv), 1, 1);
+	if (!netdev)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, netdev);
+
+	SET_NETDEV_DEV(netdev, dev);
+
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	priv->pdev = pdev;
+
+	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
+						      struct pcpu_sw_netstats);
+	if (!netdev->tstats)
+		return -ENOMEM;
+
+	ret = hbg_pci_init(pdev);
+	if (ret)
+		return ret;
+
+	ret = devm_register_netdev(dev, netdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register netdev\n");
+
+	netif_carrier_off(netdev);
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
+	.name		= "hibmcge",
+	.id_table	= hbg_pci_tbl,
+	.probe		= hbg_probe,
+};
+module_pci_driver(hbg_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
+MODULE_DESCRIPTION("hibmcge driver");
+MODULE_VERSION("1.0");
-- 
2.33.0


