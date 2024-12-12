Return-Path: <netdev+bounces-151392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53899EE8D5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD28282E1C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3543215777;
	Thu, 12 Dec 2024 14:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8442AA6;
	Thu, 12 Dec 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013830; cv=none; b=QAbjdBWG0DhXqjQsX4yFaz9eU4VNK1xhxCaOrQ2YeMokIxSEjQ6wp558QQSXhzPhEQcNzJ7b64G5lPc8torpqO66d26eVcHa+ZociOdkZ49sPeVH73FDF3/g/SqlOgrXsRySIOQbvooStLLO1yPto6xrMGEcHok9RkcBHikNuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013830; c=relaxed/simple;
	bh=5LwgWIIHonOp8bWxBhk5Ro0DEUzXb3/Ve6CKZenbTzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXJUbpgvHPVDUwBddawIufUTMyk5mCNHkA1oU6MtDOaY1RiBEUGEwNjWmaCiUTQioNaubFaEyUXL8dXSveZGJZOBcBXypIYk7tcKqrED1dDOIN8EI29bZqcPG48CltBivlgeXdYD+SLLZHqphGfQt7fxs7sg3pJZfypQYzglyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y8FDs2HprzhZW9;
	Thu, 12 Dec 2024 22:27:57 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FF3A180217;
	Thu, 12 Dec 2024 22:30:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 22:30:22 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V7 net-next 1/7] net: hibmcge: Add debugfs supported in this module
Date: Thu, 12 Dec 2024 22:23:28 +0800
Message-ID: <20241212142334.1024136-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241212142334.1024136-1-shaojijie@huawei.com>
References: <20241212142334.1024136-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch initializes debugfs and creates root directory
for each device. The tx_ring and rx_ring debugfs files
are implemented together.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v6 -> v7:
  - Optimize the wrapper name, suggested by Jakub.
  v6: https://lore.kernel.org/all/20241210134855.2864577-1-shaojijie@huawei.com/
v5 -> v6:
  - Drop debugfs_create_devm_dir() helper, suggested by Greg KH.
  v5: https://lore.kernel.org/all/20241206111629.3521865-1-shaojijie@huawei.com/
v4 -> v5:
  - Use debugfs_create_devm_dir() helper, suggested by Jakub.
  v4: https://lore.kernel.org/all/20241203150131.3139399-2-shaojijie@huawei.com/
v1 -> v2:
  - Remove debugfs file 'dev_specs' because the dump register
    does the same thing, suggested by Andrew.
  - Move 'tx timeout cnt' from debugfs to ethtool -S, suggested by Andrew.
  - Add a new patch for debugfs file 'irq_info', suggested by Andrew.
  - Ignore the error code of the debugfs initialization failure, suggested by Andrew.
  v1: https://lore.kernel.org/all/20241023134213.3359092-3-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hibmcge/Makefile   |  3 +-
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 95 +++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.h  | 12 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 29 +++++-
 4 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/Makefile b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
index ae58ac38c206..1a0ec2fb8c24 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/Makefile
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_HIBMCGE) += hibmcge.o
 
-hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o
+hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o \
+		hbg_debugfs.o
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
new file mode 100644
index 000000000000..4fd7d9b35dbc
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/etherdevice.h>
+#include <linux/seq_file.h>
+#include "hbg_common.h"
+#include "hbg_debugfs.h"
+#include "hbg_hw.h"
+#include "hbg_irq.h"
+#include "hbg_txrx.h"
+
+static struct dentry *hbg_dbgfs_root;
+
+struct hbg_dbg_info {
+	const char *name;
+	int (*read)(struct seq_file *seq, void *data);
+};
+
+#define str_true_false(state) ((state) ? "true" : "false")
+
+static void hbg_dbg_ring(struct hbg_priv *priv, struct hbg_ring *ring,
+			 struct seq_file *s)
+{
+	u32 irq_mask = ring->dir == HBG_DIR_TX ? HBG_INT_MSK_TX_B :
+						 HBG_INT_MSK_RX_B;
+
+	seq_printf(s, "ring used num: %u\n",
+		   hbg_get_queue_used_num(ring));
+	seq_printf(s, "ring max num: %u\n", ring->len);
+	seq_printf(s, "ring head: %u, tail: %u\n", ring->head, ring->tail);
+	seq_printf(s, "fifo used num: %u\n",
+		   hbg_hw_get_fifo_used_num(priv, ring->dir));
+	seq_printf(s, "fifo max num: %u\n",
+		   hbg_get_spec_fifo_max_num(priv, ring->dir));
+	seq_printf(s, "irq enabled: %s\n",
+		   str_true_false(hbg_hw_irq_is_enabled(priv, irq_mask)));
+}
+
+static int hbg_dbg_tx_ring(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	hbg_dbg_ring(priv, &priv->tx_ring, s);
+	return 0;
+}
+
+static int hbg_dbg_rx_ring(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	hbg_dbg_ring(priv, &priv->rx_ring, s);
+	return 0;
+}
+
+static const struct hbg_dbg_info hbg_dbg_infos[] = {
+	{ "tx_ring", hbg_dbg_tx_ring },
+	{ "rx_ring", hbg_dbg_rx_ring },
+};
+
+static void hbg_debugfs_uninit(void *data)
+{
+	debugfs_remove_recursive((struct dentry *)data);
+}
+
+void hbg_debugfs_init(struct hbg_priv *priv)
+{
+	const char *name = pci_name(priv->pdev);
+	struct device *dev = &priv->pdev->dev;
+	struct dentry *root;
+	u32 i;
+
+	root = debugfs_create_dir(name, hbg_dbgfs_root);
+
+	for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++)
+		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
+					    root, hbg_dbg_infos[i].read);
+
+	/* Ignore the failure because debugfs is not a key feature. */
+	devm_add_action_or_reset(dev, hbg_debugfs_uninit, root);
+}
+
+void hbg_debugfs_register(void)
+{
+	hbg_dbgfs_root = debugfs_create_dir("hibmcge", NULL);
+}
+
+void hbg_debugfs_unregister(void)
+{
+	debugfs_remove_recursive(hbg_dbgfs_root);
+	hbg_dbgfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
new file mode 100644
index 000000000000..80670d66bbeb
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_DEBUGFS_H
+#define __HBG_DEBUGFS_H
+
+void hbg_debugfs_register(void);
+void hbg_debugfs_unregister(void);
+
+void hbg_debugfs_init(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 75505fb5cc4a..7a03fdfa32a7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -11,6 +11,7 @@
 #include "hbg_irq.h"
 #include "hbg_mdio.h"
 #include "hbg_txrx.h"
+#include "hbg_debugfs.h"
 
 static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu);
 
@@ -160,7 +161,12 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
-	return hbg_mdio_init(priv);
+	ret = hbg_mdio_init(priv);
+	if (ret)
+		return ret;
+
+	hbg_debugfs_init(priv);
+	return 0;
 }
 
 static int hbg_pci_init(struct pci_dev *pdev)
@@ -245,7 +251,26 @@ static struct pci_driver hbg_driver = {
 	.id_table	= hbg_pci_tbl,
 	.probe		= hbg_probe,
 };
-module_pci_driver(hbg_driver);
+
+static int __init hbg_module_init(void)
+{
+	int ret;
+
+	hbg_debugfs_register();
+	ret = pci_register_driver(&hbg_driver);
+	if (ret)
+		hbg_debugfs_unregister();
+
+	return ret;
+}
+module_init(hbg_module_init);
+
+static void __exit hbg_module_exit(void)
+{
+	pci_unregister_driver(&hbg_driver);
+	hbg_debugfs_unregister();
+}
+module_exit(hbg_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
-- 
2.33.0


