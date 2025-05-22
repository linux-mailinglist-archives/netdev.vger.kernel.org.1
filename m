Return-Path: <netdev+bounces-192690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172A9AC0D43
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0804E66F8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5C28C032;
	Thu, 22 May 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lZcGYyOL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6728C01E
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921839; cv=none; b=D06MmO3ZeC/rF5J3od736bH2qUjuq+kuS6ErKs3lgVbWZFeiglkAAUDLf8wZWsyxGFEqr715hEH6kyGr7vPTrjNYUUhvW4UMegkiWtP3hHIUhs1eWGyzr140NEbIBOyidoiYI9sBWmon9U5NouphG9MxuuygNWZcSZ0mbpo2AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921839; c=relaxed/simple;
	bh=laNjRCbUzPrxvB5uB46Sw3GTX3DEidIzVks5cR6ub+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okxUISQe3wlgs7wtOoPDBGLSD5elkamQQuhk2fcAdsFsn4X1PmPCfgV8Rj5ZuR3r5AEphxQ8b6S9xG0fg360QTJvka4JrBQEicxB9IdpCvbfoVEF4mZx1vjgG8yBOlIfgafPhLM27R9BVdHsTQDG4RVb2eT7DKaGsZijruqGhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lZcGYyOL; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747921837; x=1779457837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r0kqXzNukQBdi6oihU8aiXtj9Rpih3nGNxBy8ykQpk0=;
  b=lZcGYyOLRDMFPkdgPfPCh3SanYIkE8zG7tT0udtteMaNbSByICvAal5k
   yeW8H1t6S7y5vs30XH2ReXNbHSzf9s9za++AidYE5/iO5Crc81no3Wuqx
   tECqdKnAvrOIxzueoq3yiN8VTrzsFcbFGIdoJaBIWhFSbiDErjCOUL3jL
   aDh9zjjVhPxq9aVUrKZVkCOojgO6KafuxitfjGisPB5au9upM/ybBhUyd
   9Isy+9DW5Hi+urbGzC5TdMuNL5WWhcn/causCoxqX1LQSZ4dF8AsopH9x
   qTWzl5n2nFKl/vBNhljWwnK0bnniFdafW9LchrHAKr3drriYf5A7EupEF
   A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="300703677"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:50:33 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:44662]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.17:2525] with esmtp (Farcaster)
 id e779d370-f5c2-49d5-969e-fba198497649; Thu, 22 May 2025 13:50:32 +0000 (UTC)
X-Farcaster-Flow-ID: e779d370-f5c2-49d5-969e-fba198497649
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:50:31 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:50:20 +0000
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
	<leon@kernel.org>
Subject: [PATCH v10 net-next 5/8] net: ena: Add debugfs support to the ENA driver
Date: Thu, 22 May 2025 16:48:36 +0300
Message-ID: <20250522134839.1336-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522134839.1336-1-darinzon@amazon.com>
References: <20250522134839.1336-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
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
index f48b12ff..41c8e5f0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -389,6 +389,10 @@ struct ena_adapter {
 	u32 xdp_num_queues;
 
 	struct devlink *devlink;
+#ifdef CONFIG_DEBUG_FS
+
+	struct dentry *debugfs_base;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 void ena_set_ethtool_ops(struct net_device *netdev);
-- 
2.47.1


