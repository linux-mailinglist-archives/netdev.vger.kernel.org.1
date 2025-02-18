Return-Path: <netdev+bounces-167471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B9A3A5EE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344A6175F2C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90FC1B87C9;
	Tue, 18 Feb 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mj6EDJEs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E421EB5C9
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904033; cv=none; b=QO2thKdaqsQPulUNYFy4bEemVF6gVo1AMw3MsGZrUDnhKRNMm1MpokJoYt+3jOliogeHinF411EataF7AoGq76s2hihoyCNlJ+jgOKVWZ7s8z/E12/vFG7VvKBO3uPGayNprxW97VhHxFvKwWbL/fgL3IP+m6gPNKb+qTHjE31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904033; c=relaxed/simple;
	bh=PwaCKqgxLGz7YfgwJmV+OduvT4OuX41BjkZqvoyg31c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsnVjF0ySQy0GRdzluatmCRgpO8hS6d0Pq02/LkdRJJBUtOrd75w9hPMWv8fajBJ76F2aI66znTeAv1CvBF9ZvIcOva0thIqaHe0+15d51OBV1kvg1v6jkANl2yyWBGMdXoNGtK5ULXzxw0puVnUPdmEZbafrlt10PLZ9ekGSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mj6EDJEs; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739904033; x=1771440033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LtWWf/ll5ZDzu6AkRWs91q8Zrxpo7f8gqY+xVoCfwAo=;
  b=mj6EDJEsoutTTkUGcQBgnOzf5xkADEMmae/BJdMCtaxGPiPDp9wawsyJ
   6JeFCXitBFctE7pHnm42xxBbyR5ylfmOS/okwF34kFNFtvvOTRseQ+2dQ
   JO2pgGp2QoVquWlAV87N4bHSMrzBUzyNZL5RUwkJK01oiKw6YCt5l4O6t
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,296,1732579200"; 
   d="scan'208";a="719855735"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 18:40:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:42661]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.141:2525] with esmtp (Farcaster)
 id ae0a4eba-ecd0-4006-94e4-80699fbdda2c; Tue, 18 Feb 2025 18:40:28 +0000 (UTC)
X-Farcaster-Flow-ID: ae0a4eba-ecd0-4006-94e4-80699fbdda2c
Received: from EX19D010UWB004.ant.amazon.com (10.13.138.37) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 18:40:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWB004.ant.amazon.com (10.13.138.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 18:40:24 +0000
Received: from email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 18 Feb 2025 18:40:24 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.176])
	by email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com (Postfix) with ESMTP id D02D4A0065;
	Tue, 18 Feb 2025 18:40:17 +0000 (UTC)
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH v7 net-next 3/5] net: ena: PHC enable through sysfs
Date: Tue, 18 Feb 2025 20:39:46 +0200
Message-ID: <20250218183948.757-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218183948.757-1-darinzon@amazon.com>
References: <20250218183948.757-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch allows controlling PHC feature enablement
through sysfs.

The PHC feature is disabled by default, although its
footprint is small, most customers do not require such
high-precision timestamping. Enabling PHC unnecessarily
in environments that do not need it might introduce a
minor but unnecessary overhead.

Customers who require PHC can enable it via the sysfs entry.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/Makefile     |  2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 20 +++--
 drivers/net/ethernet/amazon/ena/ena_netdev.h |  2 +
 drivers/net/ethernet/amazon/ena/ena_sysfs.c  | 83 ++++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_sysfs.h  | 28 +++++++
 5 files changed, 129 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.h

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


