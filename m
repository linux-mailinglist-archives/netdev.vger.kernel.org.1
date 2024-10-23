Return-Path: <netdev+bounces-138256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128CD9ACB8D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344161C2139D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095181BCA07;
	Wed, 23 Oct 2024 13:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184C1AB6CB;
	Wed, 23 Oct 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691346; cv=none; b=BdPQ3nw6zedgY1FDgqwqCMQObbVIMvT4hW3X5/bDWOtwpxQ8pVwY2wZn3dTwhRTZS+nzrDxl39Dzri4r02+GRDNRbAh/ptTXwF4zp4zpcEUVEw03m2/HJkxZdzyWOa2LxDn0A7Own9kY7VzRHi64yDIH+07k+p72A7ruzOJdVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691346; c=relaxed/simple;
	bh=1sjVT7O9mYWfp4HRs2vQsVSW57SlEf68auN6Afqya68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwZANM9c+RmHKauaUy1F53pds6ALk29V4Ezna0RKfKakGSa3BitAv3A5TExPoaf6lsMNj9t9K1rW0vUbtEykNxOluy20Vl8GMI1GtGHiLNHPiLaH24H8BUTrzfbyTupcwcWqqKEh1sSTzTzJtU5/ERtgMzyMnTfGK5KZglDrUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XYVk03Bz4zQs28;
	Wed, 23 Oct 2024 21:48:08 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 86B6D1800D9;
	Wed, 23 Oct 2024 21:49:00 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 21:48:59 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 2/7] net: hibmcge: Add debugfs supported in this module
Date: Wed, 23 Oct 2024 21:42:08 +0800
Message-ID: <20241023134213.3359092-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241023134213.3359092-1-shaojijie@huawei.com>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

This patch supports querying the detailed status of the port
through debugfs, including the TX/RX ring, specifications,
interrupt and port status.

This driver supports four interrupts. the abnormal interrupt has
multiple interrupt sources. To locate the exception cause in detail,
the debugfs displays the status and count of each interrupt source.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   3 +-
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 150 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.h  |  12 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  26 ++-
 4 files changed, 189 insertions(+), 2 deletions(-)
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
index 000000000000..e65e1d498d2b
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -0,0 +1,150 @@
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
+#define hbg_get_bool_str(state) ((state) ? "true" : "false")
+
+static int hbg_dbg_dev_spec(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_dev_specs *specs;
+
+	specs = &priv->dev_specs;
+	seq_printf(s, "mac id: %u\n", specs->mac_id);
+	seq_printf(s, "phy addr: %u\n", specs->phy_addr);
+	seq_printf(s, "mac addr: %pM\n", specs->mac_addr.sa_data);
+	seq_printf(s, "vlan layers: %u\n", specs->vlan_layers);
+	seq_printf(s, "max frame len: %u\n", specs->max_frame_len);
+	seq_printf(s, "min mtu: %u, max mtu: %u\n",
+		   specs->min_mtu, specs->max_mtu);
+	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);
+
+	return 0;
+}
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
+		   hbg_get_bool_str(hbg_hw_irq_is_enabled(priv, irq_mask)));
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
+static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_irq_info *info;
+	u32 i;
+
+	for (i = 0; i < priv->vectors.info_array_len; i++) {
+		info = &priv->vectors.info_array[i];
+		seq_printf(s,
+			   "%-20s: is enabled: %s, print: %s, count: %llu\n",
+			   info->name,
+			   hbg_get_bool_str(hbg_hw_irq_is_enabled(priv,
+								  info->mask)),
+			   hbg_get_bool_str(info->need_print),
+			   info->count);
+	}
+
+	return 0;
+}
+
+static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	seq_printf(s, "event handling state: %s\n",
+		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_EVENT_HANDLING,
+					     &priv->state)));
+
+	seq_printf(s, "tx timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);
+	return 0;
+}
+
+static const struct hbg_dbg_info hbg_dbg_infos[] = {
+	{ "dev_spec", hbg_dbg_dev_spec },
+	{ "tx_ring", hbg_dbg_tx_ring },
+	{ "rx_ring", hbg_dbg_rx_ring },
+	{ "irq_info", hbg_dbg_irq_info },
+	{ "nic_state", hbg_dbg_nic_state },
+};
+
+static void hbg_debugfs_uninit(void *data)
+{
+	debugfs_remove_recursive((struct dentry *)data);
+}
+
+int hbg_debugfs_init(struct hbg_priv *priv)
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
+	return devm_add_action_or_reset(dev, hbg_debugfs_uninit, root);
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
index 000000000000..678651ec710b
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
+int hbg_debugfs_init(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 33fe92104e90..30576483a938 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -11,6 +11,7 @@
 #include "hbg_irq.h"
 #include "hbg_mdio.h"
 #include "hbg_txrx.h"
+#include "hbg_debugfs.h"
 
 static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu);
 
@@ -209,6 +210,10 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	ret = hbg_debugfs_init(priv);
+	if (ret)
+		return ret;
+
 	hbg_delaywork_init(priv);
 	return devm_add_action_or_reset(&priv->pdev->dev, hbg_delaywork_uninit,
 					&priv->service_task);
@@ -296,7 +301,26 @@ static struct pci_driver hbg_driver = {
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


