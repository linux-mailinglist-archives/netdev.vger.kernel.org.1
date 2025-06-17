Return-Path: <netdev+bounces-198530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCAADC916
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD6189A5FC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F52D9EC2;
	Tue, 17 Jun 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lV+rhUlS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4703290BA2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158500; cv=none; b=RoL4HeFjr++L8pBF+O0RzKAJjPf0YS2cGrAq7+brEC48ckWJDbxiSwgezTPwdpgr2Szv/Pb9yQ7WFyhNtzlnVJakkI4SYF9ynBO7Om9ziIWxtEVYcHDIUWau5tjmlBFiyrc0dTIr4+pSgS1DaghVu0Woj+I3GOMDOPTjJZEJ1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158500; c=relaxed/simple;
	bh=VBFZNbYiYkRi6VJdraTRfkgZcDjGe3uvx2JArszzQjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYr1C5oqDD0aEns7UYn2iWlHv9SzQ0eFQrlvC6R92sW4DWbtGpfZo0quodNZb5b1u+zDLsH2/0vvEugIYKhQcp/mv9Fb0SAVJBe6ZYJYW4y3/tz8Z8tRK7HL/mVO/xjWJqUvpKew1xMPcuSm4ZOuQfLX6xs9+NijZ3QiOktruuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lV+rhUlS; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750158499; x=1781694499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kg1kg0IbdKw79vdLj9xpjaHecjBShNvrKd//3swAhQ=;
  b=lV+rhUlScUDQJ2UAUVMmht7bGkpxZSjIJ5dlpFYSl3sT7xI8AcLnO7np
   Nuvt70pMJ4kcw0KZdHw9LCYUj3lJ58Ub8YyqXaTOrdRiHXcz/XBDTdyd+
   vFcQK+vEYuHO1Vm7CQ6tNDQJeTHtbo1xA8ftYct2QcdJADqpWQycuFIXJ
   ttrX82hAOvSHLAHq4bFXu0K77NpzrEx+xfBgIsdFplPqJgITbRcCxqdzQ
   Kc1W7w4AR86S2EuSzWqsKOn91T6qLckj8fhq+D637H+QNlkiLa2JxQnQk
   VDO0xtXi/YqXb+qEjF79MsKaQTat9BH7m0E/yMO0DOzh4+oY8zOzJZ8Yq
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,243,1744070400"; 
   d="scan'208";a="836351482"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:08:13 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:29150]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.15.192:2525] with esmtp (Farcaster)
 id 233d1d69-4bf0-4bf5-9658-b2d052c3b145; Tue, 17 Jun 2025 11:08:11 +0000 (UTC)
X-Farcaster-Flow-ID: 233d1d69-4bf0-4bf5-9658-b2d052c3b145
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:08:09 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:07:58 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v13 net-next 7/9] net: ena: Add debugfs support to the ENA driver
Date: Tue, 17 Jun 2025 14:05:43 +0300
Message-ID: <20250617110545.5659-8-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617110545.5659-1-darinzon@amazon.com>
References: <20250617110545.5659-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Adding the base directory of debugfs to the driver.
In order for the folder to be unique per driver instantiation,
the chosen name is the device name.

This commit contains the initialization and the
base folder.

The creation of the base folder may fail, but is considered
non-fatal.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  1 +
 drivers/net/ethernet/amazon/ena/Makefile      |  2 +-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c | 27 +++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_debugfs.h | 27 +++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  6 +++++
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  4 +++
 6 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.h

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 112a3994..7b7b8891 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -58,6 +58,7 @@ ena_xdp.[ch]        XDP files
 ena_pci_id_tbl.h    Supported device IDs.
 ena_phc.[ch]        PTP hardware clock infrastructure (see `PHC`_ for more info)
 ena_devlink.[ch]    devlink files.
+ena_debugfs.[ch]    debugfs files.
 =================   ======================================================
 
 Management Interface:
diff --git a/drivers/net/ethernet/amazon/ena/Makefile b/drivers/net/ethernet/amazon/ena/Makefile
index 4b6511db..6d8036bc 100644
--- a/drivers/net/ethernet/amazon/ena/Makefile
+++ b/drivers/net/ethernet/amazon/ena/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_ENA_ETHERNET) += ena.o
 
-ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o ena_phc.o ena_devlink.o
+ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o ena_phc.o ena_devlink.o ena_debugfs.o
diff --git a/drivers/net/ethernet/amazon/ena/ena_debugfs.c b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
new file mode 100644
index 00000000..d9327cd8
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) Amazon.com, Inc. or its affiliates.
+ * All rights reserved.
+ */
+
+#ifdef CONFIG_DEBUG_FS
+
+#include <linux/seq_file.h>
+#include <linux/pci.h>
+#include "ena_debugfs.h"
+
+void ena_debugfs_init(struct net_device *dev)
+{
+	struct ena_adapter *adapter = netdev_priv(dev);
+
+	adapter->debugfs_base =
+		debugfs_create_dir(dev_name(&adapter->pdev->dev), NULL);
+}
+
+void ena_debugfs_terminate(struct net_device *dev)
+{
+	struct ena_adapter *adapter = netdev_priv(dev);
+
+	debugfs_remove_recursive(adapter->debugfs_base);
+}
+
+#endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/net/ethernet/amazon/ena/ena_debugfs.h b/drivers/net/ethernet/amazon/ena/ena_debugfs.h
new file mode 100644
index 00000000..dc61dd99
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_debugfs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) Amazon.com, Inc. or its affiliates.
+ * All rights reserved.
+ */
+
+#ifndef __ENA_DEBUGFS_H__
+#define __ENA_DEBUGFS_H__
+
+#include <linux/debugfs.h>
+#include <linux/netdevice.h>
+#include "ena_netdev.h"
+
+#ifdef CONFIG_DEBUG_FS
+
+void ena_debugfs_init(struct net_device *dev);
+
+void ena_debugfs_terminate(struct net_device *dev);
+
+#else /* CONFIG_DEBUG_FS */
+
+static inline void ena_debugfs_init(struct net_device *dev) {}
+
+static inline void ena_debugfs_terminate(struct net_device *dev) {}
+
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* __ENA_DEBUGFS_H__ */
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index cf1b817b..92d149d4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -23,6 +23,8 @@
 
 #include "ena_devlink.h"
 
+#include "ena_debugfs.h"
+
 MODULE_AUTHOR("Amazon.com, Inc. or its affiliates");
 MODULE_DESCRIPTION(DEVICE_NAME);
 MODULE_LICENSE("GPL");
@@ -4060,6 +4062,8 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_rss;
 	}
 
+	ena_debugfs_init(netdev);
+
 	INIT_WORK(&adapter->reset_task, ena_fw_reset_device);
 
 	adapter->last_keep_alive_jiffies = jiffies;
@@ -4139,6 +4143,8 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 	ena_dev = adapter->ena_dev;
 	netdev = adapter->netdev;
 
+	ena_debugfs_terminate(netdev);
+
 	/* Make sure timer and reset routine won't be called after
 	 * freeing device resources.
 	 */
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index cba67867..006f9a3a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -391,6 +391,10 @@ struct ena_adapter {
 
 	struct devlink *devlink;
 	struct devlink_port devlink_port;
+#ifdef CONFIG_DEBUG_FS
+
+	struct dentry *debugfs_base;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 void ena_set_ethtool_ops(struct net_device *netdev);
-- 
2.47.1


