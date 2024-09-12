Return-Path: <netdev+bounces-127664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984FE975F75
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F96628A340
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CFD187340;
	Thu, 12 Sep 2024 02:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885717837A;
	Thu, 12 Sep 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109857; cv=none; b=tZRwHy2GFUCnAIiRMzXhZYktWQ+gPrOS7FS4Ggw3B40bUPT2egm7TOWGNl+0n9PRjEE1+395+9r0xEiA/n+0BJu9GL+whZ2JPmxDf54t1bsq+DusHOt70MMFnxfZW8cwzvnOA/qieYAX9VzjKBjVMc0gAWXimDyOftHuEWl/cM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109857; c=relaxed/simple;
	bh=dgnZDk1QejmhiymrwdxzJuA2pjlDM+FDMD1CFKv51NE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFuMk8cVrGA/he/LuAF2ehqcSF2wfH8yNbiKkvj98bmZwoRvYU7W6QeGbGMBxf7ILJxvD0CCCi/GPph0T1xSB7NINBjtyMgOcfwkrGLro9ZNGkV60eNh05fpSmysdeS7xHDwEvJ/pfJIXiQT4O1gukz8TFJ/vC4+IrFvy5j5v4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X42Cc3wPjz1SBCf;
	Thu, 12 Sep 2024 10:57:00 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5278E1401F4;
	Thu, 12 Sep 2024 10:57:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 10:57:30 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V10 net-next 08/10] net: hibmcge: Implement some ethtool_ops functions
Date: Thu, 12 Sep 2024 10:51:25 +0800
Message-ID: <20240912025127.3912972-9-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240912025127.3912972-1-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
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

Implement the .get_drvinfo .get_link .get_link_ksettings to get
the basic information and working status of the driver.
Implement the .set_link_ksettings to modify the rate, duplex,
and auto-negotiation status.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
ChangeLog:
RFC v1 -> RFC v2:
  - Use ethtool_op_get_link(), phy_ethtool_get_link_ksettings(),
    and phy_ethtool_set_link_ksettings() to simplify the code, suggested by Andrew.
  - Delete workqueue for this patch set, suggested by Jonathan.
  RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c    | 17 +++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h    | 11 +++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c   |  2 ++
 3 files changed, 30 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
new file mode 100644
index 000000000000..c3370114aef3
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+#include "hbg_ethtool.h"
+
+static const struct ethtool_ops hbg_ethtool_ops = {
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
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
index d43c783f1800..a3603052f2e5 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
+#include "hbg_ethtool.h"
 #include "hbg_hw.h"
 #include "hbg_irq.h"
 #include "hbg_mdio.h"
@@ -238,6 +239,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->min_mtu = priv->dev_specs.min_mtu;
 	hbg_change_mtu(priv, ETH_DATA_LEN);
 	hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
+	hbg_ethtool_set_ops(netdev);
 	ret = devm_register_netdev(dev, netdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register netdev\n");
-- 
2.33.0


