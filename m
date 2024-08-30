Return-Path: <netdev+bounces-123671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D498966172
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAD9B21D34
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F07199FA9;
	Fri, 30 Aug 2024 12:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA07192D79;
	Fri, 30 Aug 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020528; cv=none; b=tGw0qf+aRssGszxBq02hzW7ROMcXUamsw0b+yk7zPqK+hjtANZi2GKXPWQlUwMYRM1ygE2tTsZNYEIODepSKo/TSj2gN4q0zvz2T1MYl5xPNytSYsS1m3cvDDS+LYy9zovjZwu4pa45aF6lHY6UveBuAeOCQFB78+IG6Pkrw+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020528; c=relaxed/simple;
	bh=mBS2YNRV5/RscjktKST7r5cdMsQH2mzxzlvcvtXKq38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWr+wWPSjX7f3OYWxRBdmbvyUIFQ+YtLHLEWYsbkNTJxoB2bP2n6XLhlX8dFWEyOp66mbpzbCn2W2dhda70Y9gIHt5eY16uFdmYdI03fklV4BYc+ce9QPfwJaXjFE8JOiGhu19aasvF/z96Z97jMbgDTekQ1MWJLt9BheEH7Woo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwHLx1nfKzyRDC;
	Fri, 30 Aug 2024 20:21:29 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id D3C84140202;
	Fri, 30 Aug 2024 20:22:01 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 20:22:00 +0800
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
Subject: [PATCH V6 net-next 01/11] net: hibmcge: Add pci table supported in this module
Date: Fri, 30 Aug 2024 20:15:54 +0800
Message-ID: <20240830121604.2250904-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240830121604.2250904-1-shaojijie@huawei.com>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
RFC v1 -> RFC v2:
  - Add the null pointer check on the return value of pcim_iomap_table(),
    suggested by Jonathan.
RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 16 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 83 +++++++++++++++++++
 2 files changed, 99 insertions(+)
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
index 000000000000..65c03b352153
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


