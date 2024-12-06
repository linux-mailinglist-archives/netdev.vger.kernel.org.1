Return-Path: <netdev+bounces-149687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD79E6D50
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A7A165D7F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D9201014;
	Fri,  6 Dec 2024 11:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF31FF7A1;
	Fri,  6 Dec 2024 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484222; cv=none; b=tybppgzLkfTGGPyIrTd2c31q+lHC29XOtqcfVZE9phIbRvFI+SRK94mnRTbmmZpo/Ua6AwBqn3klfgtMzKJcVErB/y7E4ILbxJOeqLIYvSslrKt86j5CqGgF4ld5n/87qIfFXrw/1KpIyuGzthVtHJh9hNjlXUlgTgvJHDPQypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484222; c=relaxed/simple;
	bh=PPKKfTxBTqdJRLwcuCJrt1KEIX+k4Oyhb5LcJedZx/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grN8vUSEetPXxFux2tkdQptZaWg/3AwkG5vLjPR1YuESVaWuoA3mreROv4Ivtm94DZaltcm9+MPwFRrOE18zUZdpRbGHA50eZmBR/CQG0yICIpNxSvqONUReo4vB4pCegfbEQoO9NGpQl8fkduAs7GWg722l7lmTTKLCeSnoI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y4TP20k2bzRhwL;
	Fri,  6 Dec 2024 19:21:58 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C19A814035E;
	Fri,  6 Dec 2024 19:23:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 19:23:36 +0800
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
Subject: [PATCH V5 net-next 7/8] net: hibmcge: Add reset supported in this module
Date: Fri, 6 Dec 2024 19:16:28 +0800
Message-ID: <20241206111629.3521865-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241206111629.3521865-1-shaojijie@huawei.com>
References: <20241206111629.3521865-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Sometimes, if the port doesn't work, we can try to fix it by resetting it.

This patch supports reset triggered by ethtool or FLR of PCIe, For example:
 ethtool --reset eth0 dedicated
 echo 1 > /sys/bus/pci/devices/0000\:83\:00.1/reset

We hope that the reset can be performed only when the port is down,
and the port cannot be up during the reset.
Therefore, the entire reset process is protected by the rtnl lock.
But the ethtool command already holds the rtnl lock in the dev_ethtool().
So, in hbg_ethtool_reset(), we release the rtnl lock first, after reset done,
we re-hold the rtnl lock.

After the reset is complete, the hardware registers are restored
to their default values. Therefore, some rebuild operations are
required to rewrite the user configuration to the registers.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v4 -> v5:
  - Simplify reset logic by optimizing release and re-hold rtnl lock, suggested by Jakub.
  v4: https://lore.kernel.org/all/20241203150131.3139399-7-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   2 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  16 ++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  21 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 137 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 ++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  21 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  35 +++--
 8 files changed, 234 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/Makefile b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
index 1a0ec2fb8c24..7ea15f9ef849 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/Makefile
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_HIBMCGE) += hibmcge.o
 
 hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o \
-		hbg_debugfs.o
+		hbg_debugfs.o hbg_err.o
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 76b0b32bcb15..ad25fd8de80a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -4,6 +4,7 @@
 #ifndef __HBG_COMMON_H
 #define __HBG_COMMON_H
 
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_reg.h"
@@ -33,6 +34,14 @@ enum hbg_tx_state {
 
 enum hbg_nic_state {
 	HBG_NIC_STATE_EVENT_HANDLING = 0,
+	HBG_NIC_STATE_RESETTING,
+	HBG_NIC_STATE_RESET_FAIL,
+};
+
+enum hbg_reset_type {
+	HBG_RESET_TYPE_NONE = 0,
+	HBG_RESET_TYPE_FLR,
+	HBG_RESET_TYPE_FUNCTION,
 };
 
 struct hbg_buffer {
@@ -129,6 +138,11 @@ struct hbg_mac_filter {
 	bool enabled;
 };
 
+/* saved for restore after rest */
+struct hbg_user_def {
+	struct ethtool_pauseparam pause_param;
+};
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -140,6 +154,8 @@ struct hbg_priv {
 	struct hbg_ring tx_ring;
 	struct hbg_ring rx_ring;
 	struct hbg_mac_filter filter;
+	enum hbg_reset_type reset_type;
+	struct hbg_user_def user_def;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 22cc8c98cb11..1af103a54dbb 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -19,6 +19,7 @@ struct hbg_dbg_info {
 };
 
 #define hbg_get_bool_str(state) ((state) ? "true" : "false")
+#define hbg_get_state_str(p, s) hbg_get_bool_str(test_bit(s, &(p)->state))
 
 static void hbg_dbg_ring(struct hbg_priv *priv, struct hbg_ring *ring,
 			 struct seq_file *s)
@@ -101,11 +102,31 @@ static int hbg_dbg_mac_table(struct seq_file *s, void *unused)
 	return 0;
 }
 
+static const char * const reset_type_str[] = {"None", "FLR", "Function"};
+
+static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	seq_printf(s, "event handling state: %s\n",
+		   hbg_get_state_str(priv, HBG_NIC_STATE_EVENT_HANDLING));
+	seq_printf(s, "resetting state: %s\n",
+		   hbg_get_state_str(priv, HBG_NIC_STATE_RESETTING));
+	seq_printf(s, "reset fail state: %s\n",
+		   hbg_get_state_str(priv, HBG_NIC_STATE_RESET_FAIL));
+	seq_printf(s, "last reset type: %s\n",
+		   reset_type_str[priv->reset_type]);
+
+	return 0;
+}
+
 static const struct hbg_dbg_info hbg_dbg_infos[] = {
 	{ "tx_ring", hbg_dbg_tx_ring },
 	{ "rx_ring", hbg_dbg_rx_ring },
 	{ "irq_info", hbg_dbg_irq_info },
 	{ "mac_talbe", hbg_dbg_mac_table },
+	{ "nic_state", hbg_dbg_nic_state },
 };
 
 void hbg_debugfs_init(struct hbg_priv *priv)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
new file mode 100644
index 000000000000..39bd0f0ce647
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/rtnetlink.h>
+#include "hbg_common.h"
+#include "hbg_err.h"
+#include "hbg_hw.h"
+
+static void hbg_restore_mac_table(struct hbg_priv *priv)
+{
+	struct hbg_mac_filter *filter = &priv->filter;
+	u64 addr;
+	u32 i;
+
+	for (i = 0; i < filter->table_max_len; i++)
+		if (!is_zero_ether_addr(filter->mac_table[i].addr)) {
+			addr = ether_addr_to_u64(filter->mac_table[i].addr);
+			hbg_hw_set_uc_addr(priv, addr, i);
+		}
+
+	hbg_hw_set_mac_filter_enable(priv, priv->filter.enabled);
+}
+
+static void hbg_restore_user_def_settings(struct hbg_priv *priv)
+{
+	struct ethtool_pauseparam *pause_param = &priv->user_def.pause_param;
+
+	hbg_restore_mac_table(priv);
+	hbg_hw_set_mtu(priv, priv->netdev->mtu);
+	hbg_hw_set_pause_enable(priv, pause_param->tx_pause,
+				pause_param->rx_pause);
+}
+
+int hbg_rebuild(struct hbg_priv *priv)
+{
+	int ret;
+
+	ret = hbg_hw_init(priv);
+	if (ret)
+		return ret;
+
+	hbg_restore_user_def_settings(priv);
+	return 0;
+}
+
+static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
+{
+	int ret = -EBUSY;
+
+	rtnl_lock();
+
+	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
+
+	if (netif_running(priv->netdev)) {
+		dev_warn(&priv->pdev->dev,
+			 "failed to reset because port is up\n");
+		goto unlock;
+	}
+
+	priv->reset_type = type;
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
+	if (!ret)
+		return 0;
+
+	set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+
+unlock:
+	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
+	rtnl_unlock();
+	return ret;
+}
+
+static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
+{
+	int ret;
+
+	if (!test_bit(HBG_NIC_STATE_RESETTING, &priv->state) ||
+	    type != priv->reset_type)
+		return 0;
+
+	ASSERT_RTNL();
+
+	ret = hbg_rebuild(priv);
+	if (ret) {
+		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+		dev_err(&priv->pdev->dev, "failed to rebuild after reset\n");
+		goto unlock;
+	}
+
+	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+	dev_info(&priv->pdev->dev, "reset done\n");
+
+unlock:
+	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
+	rtnl_unlock();
+	return ret;
+}
+
+int hbg_reset(struct hbg_priv *priv)
+{
+	int ret;
+
+	ret = hbg_reset_prepare(priv, HBG_RESET_TYPE_FUNCTION);
+	if (ret)
+		return ret;
+
+	return hbg_reset_done(priv, HBG_RESET_TYPE_FUNCTION);
+}
+
+static void hbg_pci_err_reset_prepare(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	hbg_reset_prepare(priv, HBG_RESET_TYPE_FLR);
+}
+
+static void hbg_pci_err_reset_done(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	hbg_reset_done(priv, HBG_RESET_TYPE_FLR);
+}
+
+static const struct pci_error_handlers hbg_pci_err_handler = {
+	.reset_prepare = hbg_pci_err_reset_prepare,
+	.reset_done = hbg_pci_err_reset_done,
+};
+
+void hbg_set_pci_err_handler(struct pci_driver *pdrv)
+{
+	pdrv->err_handler = &hbg_pci_err_handler;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
new file mode 100644
index 000000000000..d7828e446308
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_ERR_H
+#define __HBG_ERR_H
+
+#include <linux/pci.h>
+
+void hbg_set_pci_err_handler(struct pci_driver *pdrv);
+int hbg_reset(struct hbg_priv *priv);
+int hbg_rebuild(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index a821a92db43d..c4de75892c99 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -3,7 +3,9 @@
 
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <linux/rtnetlink.h>
 #include "hbg_common.h"
+#include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
 
@@ -163,9 +165,27 @@ static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
 	if (!param->autoneg)
 		hbg_hw_set_pause_enable(priv, param->tx_pause, param->rx_pause);
 
+	priv->user_def.pause_param = *param;
 	return 0;
 }
 
+static int hbg_ethtool_reset(struct net_device *netdev, u32 *flags)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	if (*flags != ETH_RESET_DEDICATED)
+		return -EOPNOTSUPP;
+
+	/* in hbg_reset(), will get rtnl lock, so unlock first */
+	rtnl_unlock();
+	ret = hbg_reset(priv);
+	rtnl_lock();
+
+	*flags = 0;
+	return ret;
+}
+
 static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
@@ -174,6 +194,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_regs		= hbg_ethtool_get_regs,
 	.get_pauseparam         = hbg_ethtool_get_pauseparam,
 	.set_pauseparam         = hbg_ethtool_set_pauseparam,
+	.reset			= hbg_ethtool_reset,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 0cbe9f7229b3..e7798f213645 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -3,6 +3,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 #include <linux/iopoll.h>
 #include <linux/minmax.h>
 #include "hbg_common.h"
@@ -167,8 +168,13 @@ static void hbg_hw_set_mac_max_frame_len(struct hbg_priv *priv,
 
 void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
 {
-	hbg_hw_set_pcu_max_frame_len(priv, mtu);
-	hbg_hw_set_mac_max_frame_len(priv, mtu);
+	u32 frame_len;
+
+	frame_len = mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
+		    ETH_HLEN + ETH_FCS_LEN;
+
+	hbg_hw_set_pcu_max_frame_len(priv, frame_len);
+	hbg_hw_set_mac_max_frame_len(priv, frame_len);
 }
 
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index a45a63856e61..7454bf1c6213 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
+#include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
 #include "hbg_irq.h"
@@ -13,8 +14,6 @@
 #include "hbg_txrx.h"
 #include "hbg_debugfs.h"
 
-static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu);
-
 static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 {
 	struct hbg_irq_info *info;
@@ -56,11 +55,7 @@ static int hbg_hw_txrx_clear(struct hbg_priv *priv)
 		return ret;
 
 	/* After reset, regs need to be reconfigured */
-	hbg_hw_init(priv);
-	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(priv->netdev->dev_addr), 0);
-	hbg_change_mtu(priv, priv->netdev->mtu);
-
-	return 0;
+	return hbg_rebuild(priv);
 }
 
 static int hbg_net_stop(struct net_device *netdev)
@@ -209,15 +204,6 @@ static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
 	return 0;
 }
 
-static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu)
-{
-	u32 frame_len;
-
-	frame_len = new_mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
-		    ETH_HLEN + ETH_FCS_LEN;
-	hbg_hw_set_mtu(priv, frame_len);
-}
-
 static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
@@ -225,7 +211,7 @@ static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev))
 		return -EBUSY;
 
-	hbg_change_mtu(priv, new_mtu);
+	hbg_hw_set_mtu(priv, new_mtu);
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	dev_dbg(&priv->pdev->dev,
@@ -283,6 +269,17 @@ static int hbg_mac_filter_init(struct hbg_priv *priv)
 	return 0;
 }
 
+static void hbg_init_user_def(struct hbg_priv *priv)
+{
+	struct ethtool_pauseparam *pause_param = &priv->user_def.pause_param;
+
+	priv->mac.pause_autoneg = HBG_STATUS_ENABLE;
+
+	pause_param->autoneg = priv->mac.pause_autoneg;
+	hbg_hw_get_pause_enable(priv, &pause_param->tx_pause,
+				&pause_param->rx_pause);
+}
+
 static int hbg_init(struct hbg_priv *priv)
 {
 	int ret;
@@ -308,6 +305,7 @@ static int hbg_init(struct hbg_priv *priv)
 		return ret;
 
 	hbg_debugfs_init(priv);
+	hbg_init_user_def(priv);
 	return 0;
 }
 
@@ -372,7 +370,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->netdev_ops = &hbg_netdev_ops;
 	netdev->watchdog_timeo = 5 * HZ;
 
-	hbg_change_mtu(priv, ETH_DATA_LEN);
+	hbg_hw_set_mtu(priv, ETH_DATA_LEN);
 	hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
 	hbg_ethtool_set_ops(netdev);
 
@@ -401,6 +399,7 @@ static int __init hbg_module_init(void)
 	int ret;
 
 	hbg_debugfs_register();
+	hbg_set_pci_err_handler(&hbg_driver);
 	ret = pci_register_driver(&hbg_driver);
 	if (ret)
 		hbg_debugfs_unregister();
-- 
2.33.0


