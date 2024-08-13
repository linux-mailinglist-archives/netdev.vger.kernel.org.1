Return-Path: <netdev+bounces-118068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A1950717
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711CBB25BE8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF119E7E0;
	Tue, 13 Aug 2024 14:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F819D899;
	Tue, 13 Aug 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557766; cv=none; b=Ap2oUnNPWXKqj+Mkt+pZMQ9d2FKEx5aiFwDNEzBzteRESWreXOTWUQ8j81Y1oDUX4Xj1o/yYpKjPJcG4/ogcyB2CmCwwiYIVzSVjZQbZ4xVhfl5SEa4QFrHm+mlZZQkWPCpxDAH0Qz+qjGbbkRlgiWC/SfuQaTRXZ+WdMvHQcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557766; c=relaxed/simple;
	bh=8AewkJjGbzywTCxdh/HtGILLsEMGnf1OPqxOOMILjNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJecQ8GB03lGUvNgl/VJzsiweHpqZY7QJsKU3rPWSOtkPE6s4inn1EzWMLtrDFyZURC9Qjx9NiiAI3629mcqmgFiJLu+LCvIXBbNDe3FMgxgT9fH4l9EiWn995za1cDgimc3vRVp186SNrYO2CjinltoTiilW18gvddr+wrDQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WjtMJ0P1Nzfb7s;
	Tue, 13 Aug 2024 22:00:44 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id CE9CC18006C;
	Tue, 13 Aug 2024 22:02:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:02:40 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH V2 net-next 08/11] net: hibmcge: Implement some ethtool_ops functions
Date: Tue, 13 Aug 2024 21:56:37 +0800
Message-ID: <20240813135640.1694993-9-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813135640.1694993-1-shaojijie@huawei.com>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Implement the .get_drvinfo .get_link .get_link_ksettings to get
the basic information and working status of the driver.
Implement the .set_link_ksettings to modify the rate, duplex,
and auto-negotiation status.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
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
index 0024af404762..ccbced1a7a1c 100644
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
@@ -220,6 +221,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register netdev\n");
 
+	hbg_ethtool_set_ops(netdev);
 	set_bit(HBG_NIC_STATE_INITED, &priv->state);
 	return 0;
 }
-- 
2.33.0


