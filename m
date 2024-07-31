Return-Path: <netdev+bounces-114487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD00942B31
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733F01C20DC3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13461AD9F1;
	Wed, 31 Jul 2024 09:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB931AD3F3;
	Wed, 31 Jul 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419309; cv=none; b=tW9JjROTPsEkS3tqjzx0hH3NR3OjqBWBbyt81rWH05DulWitlH44IIjyaoCgITl0dCoFa3MV6o0V2L8tv1oYJ2ApltFS2V0/OSqdHiBIhQ2hsTqvCzMNtRuRvZsMXAIVPMY7qf6AL5oc8yYQvJkX9opJblI8YR9zjijqaqLCZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419309; c=relaxed/simple;
	bh=h4/HEZKJ6xdx37RdzKWxmUEEedNsoykD4GoGREyFZZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdAaHibkPUxJYyVqg5PFPN6cuGKNNWIvCefXuE4TUn2Sdy9fZkKcvc7A12g23Y50/imEEzfE1H+9iEdIV9+PDdv2Mxc+xSV06dVKipFNVtyExUmZAd+lqvXYjXok11/7ZarIZwpPyYtG3CsegXD14Q7qQInboO2epiMO2oCnVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYnJv2KyTz1HFlH;
	Wed, 31 Jul 2024 17:45:35 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 35F7114010C;
	Wed, 31 Jul 2024 17:48:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:48:23 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next 08/10] net: hibmcge: Implement workqueue and some ethtool_ops functions
Date: Wed, 31 Jul 2024 17:42:43 +0800
Message-ID: <20240731094245.1967834-9-shaojijie@huawei.com>
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

Implement a workqueue in this module, The workqueue is invoked
once every second to update link status.

Implement the .get_drvinfo .get_link .get_link_ksettings to get
the basic information and working status of the driver.
Implement the .set_link_ksettings to modify the rate, duplex,
and auto-negotiation status.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  1 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 56 +++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  | 11 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 96 ++++++++++++++++++-
 4 files changed, 161 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 25563af04897..45ec4b463e70 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -146,6 +146,7 @@ struct hbg_priv {
 	struct hbg_vector vectors;
 	struct hbg_ring tx_ring;
 	struct hbg_ring rx_ring;
+	struct delayed_work service_task;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
new file mode 100644
index 000000000000..3acd6eae189e
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+#include "hbg_common.h"
+#include "hbg_ethtool.h"
+#include "hbg_hw.h"
+#include "hbg_main.h"
+#include "hbg_mdio.h"
+
+static void hbg_ethtool_get_drvinfo(struct net_device *netdev,
+				    struct ethtool_drvinfo *drvinfo)
+{
+	strscpy(drvinfo->version, HBG_MOD_VERSION, sizeof(drvinfo->version));
+	drvinfo->version[sizeof(drvinfo->version) - 1] = '\0';
+}
+
+static u32 hbg_ethtool_get_link(struct net_device *netdev)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	return priv->mac.link_status;
+}
+
+static int hbg_ethtool_get_ksettings(struct net_device *netdev,
+				     struct ethtool_link_ksettings *ksettings)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	phy_ethtool_ksettings_get(priv->mac.phydev, ksettings);
+	return 0;
+}
+
+static int hbg_ethtool_set_ksettings(struct net_device *netdev,
+				     const struct ethtool_link_ksettings *cmd)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (cmd->base.speed == SPEED_1000 && cmd->base.duplex == DUPLEX_HALF)
+		return -EINVAL;
+
+	return phy_ethtool_ksettings_set(priv->mac.phydev, cmd);
+}
+
+static const struct ethtool_ops hbg_ethtool_ops = {
+	.get_drvinfo		= hbg_ethtool_get_drvinfo,
+	.get_link		= hbg_ethtool_get_link,
+	.get_link_ksettings	= hbg_ethtool_get_ksettings,
+	.set_link_ksettings	= hbg_ethtool_set_ksettings,
+};
+
+void hbg_ethtool_set_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &hbg_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
new file mode 100644
index 000000000000..628707ec2686
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_ETHTOOL_H
+#define __HBG_ETHTOOL_H
+
+#include <linux/netdevice.h>
+
+void hbg_ethtool_set_ops(struct net_device *netdev);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index bb5f8321da8a..bea596123c37 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,12 +6,15 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
+#include "hbg_ethtool.h"
 #include "hbg_hw.h"
 #include "hbg_irq.h"
 #include "hbg_main.h"
 #include "hbg_mdio.h"
 #include "hbg_txrx.h"
 
+static struct workqueue_struct *hbg_workqueue;
+
 static void hbg_enable_intr(struct hbg_priv *priv, bool enabled)
 {
 	u32 i;
@@ -136,6 +139,52 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_tx_timeout		= hbg_net_tx_timeout,
 };
 
+static void hbg_update_link_status(struct hbg_priv *priv)
+{
+	u32 link;
+
+	link = hbg_get_link_status(priv);
+	if (link == priv->mac.link_status)
+		return;
+
+	priv->mac.link_status = link;
+	if (link == HBG_LINK_DOWN) {
+		netif_carrier_off(priv->netdev);
+		netif_tx_stop_all_queues(priv->netdev);
+		dev_info(&priv->pdev->dev, "link down!");
+	} else {
+		netif_tx_wake_all_queues(priv->netdev);
+		netif_carrier_on(priv->netdev);
+		dev_info(&priv->pdev->dev, "link up!");
+	}
+}
+
+static void hbg_service_task(struct work_struct *work)
+{
+	struct hbg_priv *priv =
+		container_of(work, struct hbg_priv, service_task.work);
+
+	hbg_update_link_status(priv);
+
+	mod_delayed_work(hbg_workqueue, &priv->service_task,
+			 round_jiffies_relative(HZ));
+}
+
+static void hbg_delaywork_init(struct hbg_priv *priv)
+{
+	INIT_DELAYED_WORK(&priv->service_task, hbg_service_task);
+	mod_delayed_work(hbg_workqueue, &priv->service_task,
+			 round_jiffies_relative(HZ));
+}
+
+static void hbg_delaywork_uninit(void *data)
+{
+	struct hbg_priv *priv = data;
+
+	if (priv->service_task.work.func)
+		cancel_delayed_work_sync(&priv->service_task);
+}
+
 static const u32 hbg_mode_ability[] = {
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
@@ -177,12 +226,17 @@ static int hbg_init(struct net_device *netdev)
 	ret = hbg_irq_init(priv);
 	if (ret)
 		return ret;
-
 	ret = devm_add_action_or_reset(&priv->pdev->dev, hbg_irq_uninit, priv);
 	if (ret)
 		return ret;
 
-	return hbg_mac_init(priv);
+	ret = hbg_mac_init(priv);
+	if (ret)
+		return ret;
+
+	hbg_delaywork_init(priv);
+	return devm_add_action_or_reset(&priv->pdev->dev,
+					hbg_delaywork_uninit, priv);
 }
 
 static int hbg_pci_init(struct pci_dev *pdev)
@@ -249,6 +303,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register netdev\n");
 
+	hbg_ethtool_set_ops(netdev);
 	set_bit(HBG_NIC_STATE_INITED, &priv->state);
 	return 0;
 }
@@ -264,7 +319,42 @@ static struct pci_driver hbg_driver = {
 	.id_table	= hbg_pci_tbl,
 	.probe		= hbg_probe,
 };
-module_pci_driver(hbg_driver);
+
+static int __init hbg_module_init(void)
+{
+	int ret;
+
+	hbg_workqueue = alloc_workqueue("%s", WQ_UNBOUND, 0, HBG_DEV_NAME);
+	if (!hbg_workqueue) {
+		pr_err("%s: failed to create workqueue\n", HBG_DEV_NAME);
+		return -ENOMEM;
+	}
+
+	ret = pci_register_driver(&hbg_driver);
+	if (ret) {
+		pr_err("%s: failed to register PCI driver, ret = %d\n",
+		       HBG_DEV_NAME, ret);
+		goto err_destroy_workqueue;
+	}
+
+	return 0;
+
+err_destroy_workqueue:
+	destroy_workqueue(hbg_workqueue);
+	hbg_workqueue = NULL;
+
+	return ret;
+}
+module_init(hbg_module_init);
+
+static void __exit hbg_module_exit(void)
+{
+	pci_unregister_driver(&hbg_driver);
+	flush_workqueue(hbg_workqueue);
+	destroy_workqueue(hbg_workqueue);
+	hbg_workqueue = NULL;
+}
+module_exit(hbg_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
-- 
2.33.0


