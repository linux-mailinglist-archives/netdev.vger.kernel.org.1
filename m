Return-Path: <netdev+bounces-163555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CEA2AAF4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D2018893F5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ED9226871;
	Thu,  6 Feb 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hh1eMoiK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A221CA07
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851389; cv=none; b=RlDDdeSs+Qp+cxh58FK8XxqmqFOqsETMN19/YLQCpCUBETzl3Et6lI0aMrUQb48NLAFkcveGC8roVTK9lwbHhe6bdAn+ug8D5LUOsUXUXIN4AfSJdoYYkiIZ2AmMUT+GG9PgPyi4L2/tfdhWvCbkAQUVPgp2dQRcZ72aUSgfF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851389; c=relaxed/simple;
	bh=/+p/tmBGO9gHO/674CD6vYGS76D7m+vgcmrjaoD7JLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPdMS/UbW+2MnYfbvzFY6VVahm8mYrdtsB6cj0uFF+CIRB1T2IGfFKUp3j/LdEcG+YYpcZEl1X15ocfxuZWbv5t+G2mD1xYc7S7guFCrLgV+40wKNnsdAenC7J/sGe3IXIq621Jki0UaSkfQMTORcRRK0qnDZLe+K9EMLE979nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hh1eMoiK; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738851388; x=1770387388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iy3YjQQ9QsiK3ZKds+ejLzRmFV222XLMlD+5EmFQEBM=;
  b=hh1eMoiKV0uVC+gPB/278q2ADxKTX8uUw2arhGzrjJ/e4zywMCJbFpAU
   Eg/5MKRlLh2WKxZqH4YQOGoyDPUVnscIQ5x4TPgCumaU2/giNtzTB9sTk
   uAUl6S5IYTVki7UcPrBcP9iDs8dPHf+42mBrkDHiDygYUdVOKWZbXVOEp
   w=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="375039399"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 14:16:26 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:22848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id 83278530-0f33-496b-b99d-038a16e5c20e; Thu, 6 Feb 2025 14:16:25 +0000 (UTC)
X-Farcaster-Flow-ID: 83278530-0f33-496b-b99d-038a16e5c20e
Received: from EX19D010UWB004.ant.amazon.com (10.13.138.37) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 14:16:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWB004.ant.amazon.com (10.13.138.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 14:16:22 +0000
Received: from email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Thu, 6 Feb 2025 14:16:22 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.172])
	by email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com (Postfix) with ESMTP id 26C7E40533;
	Thu,  6 Feb 2025 14:16:17 +0000 (UTC)
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
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH v6 net-next 4/4] net: ena: PHC enable through sysfs
Date: Thu, 6 Feb 2025 16:15:38 +0200
Message-ID: <20250206141538.549-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206141538.549-1-darinzon@amazon.com>
References: <20250206141538.549-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch allows controlling PHC feature enablement
through sysfs. The feature is disabled by default,
and customers can use the `phc_enable` sysfs entry
in order to enable it.

Documentation is also updated.

Signed-off-by: David Arinzon <darinzon@amazon.com>

---
 .../device_drivers/ethernet/amazon/ena.rst    | 12 +++
 drivers/net/ethernet/amazon/ena/Makefile      |  2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 20 +++--
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  2 +
 drivers/net/ethernet/amazon/ena/ena_sysfs.c   | 83 +++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_sysfs.h   | 28 +++++++
 6 files changed, 141 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.h

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 12b13da0..0b016a5e 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -53,6 +53,7 @@ ena_eth_io_defs.h   Definition of ENA data path interface.
 ena_common_defs.h   Common definitions for ena_com layer.
 ena_regs_defs.h     Definition of ENA PCI memory-mapped (MMIO) registers.
 ena_netdev.[ch]     Main Linux kernel driver.
+ena_sysfs.[ch]      Sysfs files.
 ena_ethtool.c       ethtool callbacks.
 ena_xdp.[ch]        XDP files
 ena_pci_id_tbl.h    Supported device IDs.
@@ -253,6 +254,17 @@ Load PTP module:
 
   sudo modprobe ptp
 
+**PHC activation**
+
+The feature is turned off by default, in order to turn the feature on,
+please use the following:
+
+- sysfs (during runtime):
+
+.. code-block:: shell
+
+  echo 1 > /sys/bus/pci/devices/<domain:bus:slot.function>/phc_enable
+
 All available PTP clock sources can be tracked here:
 
 .. code-block:: shell
diff --git a/drivers/net/ethernet/amazon/ena/Makefile b/drivers/net/ethernet/amazon/ena/Makefile
index 8c874177..d950ade6 100644
--- a/drivers/net/ethernet/amazon/ena/Makefile
+++ b/drivers/net/ethernet/amazon/ena/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_ENA_ETHERNET) += ena.o
 
-ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o ena_phc.o
+ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o ena_phc.o ena_sysfs.o
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 13c9d93e..db1d9d44 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -20,6 +20,7 @@
 
 #include "ena_netdev.h"
 #include "ena_pci_id_tbl.h"
+#include "ena_sysfs.h"
 #include "ena_xdp.h"
 
 #include "ena_phc.h"
@@ -44,8 +45,6 @@ MODULE_DEVICE_TABLE(pci, ena_pci_tbl);
 
 static int ena_rss_init_default(struct ena_adapter *adapter);
 static void check_for_admin_com_state(struct ena_adapter *adapter);
-static int ena_destroy_device(struct ena_adapter *adapter, bool graceful);
-static int ena_restore_device(struct ena_adapter *adapter);
 
 static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -3270,7 +3269,7 @@ err_disable_msix:
 	return rc;
 }
 
-static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
+int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -3321,7 +3320,7 @@ static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 	return rc;
 }
 
-static int ena_restore_device(struct ena_adapter *adapter)
+int ena_restore_device(struct ena_adapter *adapter)
 {
 	struct ena_com_dev_get_features_ctx get_feat_ctx;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -4056,10 +4055,17 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			"Failed to enable and set the admin interrupts\n");
 		goto err_worker_destroy;
 	}
+
+	rc = ena_sysfs_init(&adapter->pdev->dev);
+	if (rc) {
+		dev_err(&pdev->dev, "Cannot init sysfs\n");
+		goto err_free_msix;
+	}
+
 	rc = ena_rss_init_default(adapter);
 	if (rc && (rc != -EOPNOTSUPP)) {
 		dev_err(&pdev->dev, "Cannot init RSS rc: %d\n", rc);
-		goto err_free_msix;
+		goto err_terminate_sysfs;
 	}
 
 	ena_config_debug_area(adapter);
@@ -4104,6 +4110,8 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_rss:
 	ena_com_delete_debug_area(ena_dev);
 	ena_com_rss_destroy(ena_dev);
+err_terminate_sysfs:
+	ena_sysfs_terminate(&pdev->dev);
 err_free_msix:
 	ena_com_dev_reset(ena_dev, ENA_REGS_RESET_INIT_ERR);
 	/* stop submitting admin commands on a device that was reset */
@@ -4156,6 +4164,8 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 	}
 
 #endif /* CONFIG_RFS_ACCEL */
+	ena_sysfs_terminate(&adapter->pdev->dev);
+
 	/* Make sure timer and reset routine won't be called after
 	 * freeing device resources.
 	 */
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 7867cd7f..e3c7ed9c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -416,6 +416,8 @@ static inline void ena_reset_device(struct ena_adapter *adapter,
 	set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
 }
 
+int ena_destroy_device(struct ena_adapter *adapter, bool graceful);
+int ena_restore_device(struct ena_adapter *adapter);
 int handle_invalid_req_id(struct ena_ring *ring, u16 req_id,
 			  struct ena_tx_buffer *tx_info, bool is_xdp);
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_sysfs.c b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
new file mode 100644
index 00000000..d0ded92d
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright 2015-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/stat.h>
+#include <linux/sysfs.h>
+
+#include "ena_com.h"
+#include "ena_netdev.h"
+#include "ena_phc.h"
+#include "ena_sysfs.h"
+
+static ssize_t ena_phc_enable_set(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+	unsigned long phc_enable_val;
+	int rc;
+
+	if (!ena_com_phc_supported(adapter->ena_dev)) {
+		netif_info(adapter, drv, adapter->netdev,
+			   "Device doesn't support PHC");
+		return -EOPNOTSUPP;
+	}
+
+	rc = kstrtoul(buf, 10, &phc_enable_val);
+	if (rc < 0)
+		return rc;
+
+	if (phc_enable_val != 0 && phc_enable_val != 1)
+		return -EINVAL;
+
+	rtnl_lock();
+
+	/* No change in state */
+	if ((bool)phc_enable_val == ena_phc_is_enabled(adapter))
+		goto out;
+
+	ena_phc_enable(adapter, phc_enable_val);
+
+	ena_destroy_device(adapter, false);
+	rc = ena_restore_device(adapter);
+
+out:
+	rtnl_unlock();
+	return rc ? rc : len;
+}
+
+#define ENA_PHC_ENABLE_STR_MAX_LEN 3
+
+static ssize_t ena_phc_enable_get(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+
+	return snprintf(buf, ENA_PHC_ENABLE_STR_MAX_LEN, "%u\n",
+			ena_phc_is_enabled(adapter));
+}
+
+static DEVICE_ATTR(phc_enable, S_IRUGO | S_IWUSR, ena_phc_enable_get,
+		   ena_phc_enable_set);
+
+/******************************************************************************
+ *****************************************************************************/
+int ena_sysfs_init(struct device *dev)
+{
+	if (device_create_file(dev, &dev_attr_phc_enable))
+		dev_err(dev, "Failed to create phc_enable sysfs entry");
+
+	return 0;
+}
+
+/******************************************************************************
+ *****************************************************************************/
+void ena_sysfs_terminate(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_phc_enable);
+}
diff --git a/drivers/net/ethernet/amazon/ena/ena_sysfs.h b/drivers/net/ethernet/amazon/ena/ena_sysfs.h
new file mode 100644
index 00000000..8c572eee
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_sysfs.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright 2015-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef __ENA_SYSFS_H__
+#define __ENA_SYSFS_H__
+
+#ifdef CONFIG_SYSFS
+
+int ena_sysfs_init(struct device *dev);
+
+void ena_sysfs_terminate(struct device *dev);
+
+#else /* CONFIG_SYSFS */
+
+static inline int ena_sysfs_init(struct device *dev)
+{
+	return 0;
+}
+
+static inline void ena_sysfs_terminate(struct device *dev)
+{
+}
+
+#endif /* CONFIG_SYSFS */
+
+#endif /* __ENA_SYSFS_H__ */
-- 
2.47.1


