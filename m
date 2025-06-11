Return-Path: <netdev+bounces-196487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D720AD4FAE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1D1891BFE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AE25EF9F;
	Wed, 11 Jun 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="p71Ejq4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF525C83E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633923; cv=none; b=Gk+9GTCszGpbpz1cG+gEkWx8u/t2H4juijF6jhrz3Ig0k8BbvrhUO7Q4en1q1S91qJlhyRWI7Zul9n0fvhDBJiJl85esi734urI8aCJ/pnj8lgCI3DkWtGW2fofiU1ecpg0lEFEzLpmv0h9ftTreAJYxhz/THIMKUsreOw6TH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633923; c=relaxed/simple;
	bh=eNv3DJ1+/Ak8VwKkpteVFbtVgvNZJ1+ks7eFTkidafg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3YmrkcFGmm4iIN3vl9akxD0+SPIsLeuxZcKDVIofjzWHks0j3qphs7yIOXpQ/U9KC6P1tJwJqpHQRS240w5BOsu7yaVtt7h6FopLB6lhMPUsP2/bOMt4jis2+sysIt2OrNyF44ybH/uhl1Bkr8gamjMrHKW+4SVqPXxM5Ocd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=p71Ejq4w; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749633921; x=1781169921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ltFA6uGpCXBG1TqO3QzomJ4OI6HED2+EP9f2s4ur7Q=;
  b=p71Ejq4wX3TDNKvG6rY0CNNxvVR1PxLffsH2N0LvloqJc8wMCzmODz+x
   ISlz953h6uudtB3JWkmFdpIwwKq3M2FQ/MOmX8tkBLKNBrywtHMfhRRfN
   yS0vdcwe2Z4gybxsBtS32MrkC7xlp3KnS1vT5lk5o19CaPut52BBiMlD1
   sYOimKmoe0iCd/L5Pps50HVGZAMyJ6NZs/XKJtQP0p37OMJD/UJqCoM3w
   tIR7bXikb21QfKtxw+d7zYY2Dde9uojb8jrfi6wHa6e9uRfVqT0mxoMO0
   TgEJJMi3OBgheqdxFv+8flIhztXDykie/r/cnW2dweHVAzsI4LHVXdqjz
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="206181604"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:25:20 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:58482]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.3.39:2525] with esmtp (Farcaster)
 id 57cdbf02-446f-4d9f-a2d9-d78054b6cb6b; Wed, 11 Jun 2025 09:25:19 +0000 (UTC)
X-Farcaster-Flow-ID: 57cdbf02-446f-4d9f-a2d9-d78054b6cb6b
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:25:18 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.176) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:25:06 +0000
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
Subject: [PATCH v12 net-next 7/9] net: ena: Add debugfs support to the ENA driver
Date: Wed, 11 Jun 2025 12:22:36 +0300
Message-ID: <20250611092238.2651-8-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611092238.2651-1-darinzon@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
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
index 3cbf9854..347aec34 100644
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
index 28878a42..5b09f511 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -23,6 +23,8 @@
 
 #include "ena_devlink.h"
 
+#include "ena_debugfs.h"
+
 MODULE_AUTHOR("Amazon.com, Inc. or its affiliates");
 MODULE_DESCRIPTION(DEVICE_NAME);
 MODULE_LICENSE("GPL");
@@ -4059,6 +4061,8 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_rss;
 	}
 
+	ena_debugfs_init(netdev);
+
 	INIT_WORK(&adapter->reset_task, ena_fw_reset_device);
 
 	adapter->last_keep_alive_jiffies = jiffies;
@@ -4138,6 +4142,8 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
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


