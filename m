Return-Path: <netdev+bounces-212816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C73B22171
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9720D6E74EE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958E2EA149;
	Tue, 12 Aug 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JGjGVK53";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O8N17d+v"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F72E9EDD;
	Tue, 12 Aug 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987464; cv=none; b=jtTWK3+acUFMxg3nW/POmyBq4EXajC+yLyIpMLi1HrW9XWhjgvkMe+j8MzqoCWyk/z5J8ClehZOJyCe9+JW6qnbsXSfKkhj5fQWQN2+nwA5MtbcqIn6AQuc7u7OLKRwUYeV/EWIhgOoRlvdWG2BTYwvrFPdFwt7ZU3b/hncw7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987464; c=relaxed/simple;
	bh=OJz6lN+V61xEJqfgOsmES4WcqvVs74FDmXMTHHPLtJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kx8R5+A8rYDGT/zmpCCOkUpaXvibCl6BwyaQTNX5R3qY3ZtiRetKdPlkmDPk3zZzlh7iZ4XNeXmJw9TzvIZZv8lvIrFLRFwktf4zNbLm/2qXEL1CGUkdnz4Jvz5phPczjPILScOxXDCdcdgSXXlZxs5aI0XYAiiP+IqHToDd94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JGjGVK53; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O8N17d+v; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c1Pps1DtVz9tMl;
	Tue, 12 Aug 2025 10:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilZWkWyPDRea7xiLblZc8xLee68w9qKXSh43VHOczTQ=;
	b=JGjGVK53sqeE/tbBhVsNFANxIXKcJqqk76DK+sY2joFx52jHIiXdfm6w9YSzzpu/B/sO5z
	91bi2MnfhOL0tosx0DH+hyuKCZHLeqO89O8vElaZ9t5SLoIeLTb+2j0o/8gS6+OqmouQdK
	Lp0FN9uSlufjJY99E03EN0hRzWRSq6iETM8wwOCgzUpfrQH5yceEV4KxbMfHBUsXv5yjGi
	r0JXvfdx5gn5bXb7BMEJqeFfAh52P1uOLF9oh3MNvswAHpxx+qo4omiLBtarBLcYifmMqS
	BXY863hA/iWWLZeHJCAQdTkZznFWhHfKe3812t8QxZNQkftJ0vAYlVvdG2h+bw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=O8N17d+v;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilZWkWyPDRea7xiLblZc8xLee68w9qKXSh43VHOczTQ=;
	b=O8N17d+vNtNYVfEGy9bOb8S+1NVf9qku62uWNHWgFr1OxQxULTuAKQazi9WOiuBKS7Md2+
	u/8GaEVOy8qbvxfRoPmMtzA0Lk2piP13KO3flt0tWHDPF+y5SJoznr90prdGh4yE6Y1xx2
	WKtrtSA8M81Et+0/eCfufcwQHKfnqKAX4t0kKDJIWf/60uMuhTTamdIavfPBXaRQxqn6E+
	qu0VzUku2cX6tYKE9sOuFX/00WtokO8QSyO/Rgu7oZs7N0Og843AOdxXsqfJDeanW/Bft+
	kKeaMDTyY+Uk7fCdjCEZyCYFKlxnqbCyOkCFD1i/2VdQJeztMN5C6W+P2SI15Q==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next RESEND v17 09/12] net: mtip: Extend the L2 switch driver for imx287 with bridge operations
Date: Tue, 12 Aug 2025 10:29:36 +0200
Message-Id: <20250812082939.541733-10-lukasz.majewski@mailbox.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 722e5a25e1bb08c5af0
X-MBO-RS-META: 995u86tynbdjk9k8igx6brbwafiyn8o6
X-Rspamd-Queue-Id: 4c1Pps1DtVz9tMl

After this change the MTIP L2 switch can be configured as offloading
device for packet switching when bridge on their interfaces is created.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
---

Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14 - v15:
- None

Changes for v16:
- Enable MTIP ports to support bridge offloading

Changes for v17:
- None
---
 .../net/ethernet/freescale/mtipsw/Makefile    |   2 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  |   9 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |   2 +
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   | 132 ++++++++++++++++++
 4 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c

diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
index a99aaf6ddfb2..81e2b0e03e6c 100644
--- a/drivers/net/ethernet/freescale/mtipsw/Makefile
+++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_FEC_MTIP_L2SW) += nxp-mtipl2sw.o
-nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o
+nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o mtipl2sw_br.o
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 4c9776fc5382..a67fd1f5c807 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -1887,11 +1887,15 @@ static int mtip_sw_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Could not alloc IRQ\n");
 
+	ret = mtip_register_notifiers(fep);
+	if (ret)
+		return ret;
+
 	ret = mtip_switch_dma_init(fep);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: ethernet switch init fail (%d)!\n",
 			__func__, ret);
-		return ret;
+		goto unregister_notifiers;
 	}
 
 	ret = mtip_mii_init(fep, pdev);
@@ -1922,6 +1926,8 @@ static int mtip_sw_probe(struct platform_device *pdev)
 			  fep->bd_dma);
 	fep->rx_bd_base = NULL;
 	fep->tx_bd_base = NULL;
+ unregister_notifiers:
+	mtip_unregister_notifiers(fep);
 
 	return ret;
 }
@@ -1930,6 +1936,7 @@ static void mtip_sw_remove(struct platform_device *pdev)
 {
 	struct switch_enet_private *fep = platform_get_drvdata(pdev);
 
+	mtip_unregister_notifiers(fep);
 	mtip_ndev_cleanup(fep);
 
 	mtip_mii_remove(fep);
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
index 7e5373823d43..3dae94048917 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
@@ -643,6 +643,8 @@ int mtip_port_learning_config(struct switch_enet_private *fep, int port,
 int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
 			      bool enable);
 bool mtip_is_switch_netdev_port(const struct net_device *ndev);
+int mtip_register_notifiers(struct switch_enet_private *fep);
+void mtip_unregister_notifiers(struct switch_enet_private *fep);
 int mtip_port_enable_config(struct switch_enet_private *fep, int port,
 			    bool tx_en, bool rx_en);
 void mtip_clear_atable(struct switch_enet_private *fep);
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
new file mode 100644
index 000000000000..f961b9cc4e6a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller driver for MTIP block - bridge network interface
+ *
+ *  Copyright (C) 2025 DENX Software Engineering GmbH
+ *  Lukasz Majewski <lukma@denx.de>
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <net/switchdev.h>
+
+#include "mtipl2sw.h"
+
+static int mtip_ndev_port_link(struct net_device *ndev,
+			       struct net_device *br_ndev,
+			       struct netlink_ext_ack *extack)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev), *other_priv;
+	struct switch_enet_private *fep = priv->fep;
+	struct net_device *other_ndev;
+	int err;
+
+	/* Check if one port of MTIP switch is already bridged */
+	if (fep->br_members && !fep->br_offload) {
+		/* Get the second bridge ndev */
+		other_ndev = fep->ndev[fep->br_members - 1];
+		other_priv = netdev_priv(other_ndev);
+		if (other_priv->master_dev != br_ndev) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "L2 offloading only possible for the same bridge!");
+			return notifier_from_errno(-EOPNOTSUPP);
+		}
+
+		fep->br_offload = 1;
+		mtip_switch_dis_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+
+	if (!priv->master_dev)
+		priv->master_dev = br_ndev;
+
+	fep->br_members |= BIT(priv->portnum - 1);
+
+	err = switchdev_bridge_port_offload(ndev, ndev, NULL, NULL, NULL,
+					    false, extack);
+	if (err) {
+		dev_err(&ndev->dev, "can't offload bridge port %s [err: %d]\n",
+			ndev->name, err);
+		return err;
+	}
+
+	dev_dbg(&ndev->dev,
+		"%s: ndev: %s br: %s fep: %p members: 0x%x offload: %d\n",
+		__func__, ndev->name,  br_ndev->name, fep, fep->br_members,
+		fep->br_offload);
+
+	return NOTIFY_DONE;
+}
+
+static void mtip_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev);
+	struct switch_enet_private *fep = priv->fep;
+
+	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n", __func__,
+		ndev->name, fep->br_members);
+
+	switchdev_bridge_port_unoffload(ndev, NULL, NULL, NULL);
+
+	fep->br_members &= ~BIT(priv->portnum - 1);
+	priv->master_dev = NULL;
+
+	if (fep->br_members && fep->br_offload) {
+		fep->br_offload = 0;
+		mtip_switch_en_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+}
+
+/* netdev notifier */
+static int mtip_netdevice_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info = ptr;
+	struct netlink_ext_ack *extack;
+	int ret = NOTIFY_DONE;
+
+	if (!mtip_is_switch_netdev_port(ndev))
+		return NOTIFY_DONE;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		if (!netif_is_bridge_master(info->upper_dev))
+			break;
+
+		if (info->linking)
+			ret = mtip_ndev_port_link(ndev, info->upper_dev,
+						  extack);
+		else
+			mtip_netdevice_port_unlink(ndev);
+
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block mtip_netdevice_nb __read_mostly = {
+	.notifier_call = mtip_netdevice_event,
+};
+
+int mtip_register_notifiers(struct switch_enet_private *fep)
+{
+	int ret = register_netdevice_notifier(&mtip_netdevice_nb);
+
+	if (ret)
+		dev_err(&fep->pdev->dev, "can't register netdevice notifier\n");
+
+	return ret;
+}
+
+void mtip_unregister_notifiers(struct switch_enet_private *fep)
+{
+	unregister_netdevice_notifier(&mtip_netdevice_nb);
+}
-- 
2.39.5


