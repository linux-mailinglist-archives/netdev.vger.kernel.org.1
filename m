Return-Path: <netdev+bounces-171817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B0A4ED41
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37E18A184C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE57253B75;
	Tue,  4 Mar 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KEcyYel2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC025FA0E
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115143; cv=none; b=Pp2k04TMEQdyKq5C+p5yKqKUy0UCOh4a59gUjUI5bMgmVMRqZYXCbn6WgTyl1fAfdIek4UArtH5JGE4V/EzxP+R9v1TOSBwATxZpxXx/scXxgS4TMmC+kyaIA+0Jf9hwXXAyAUsTpJrNrevFFKd7REBPAnxT2+/EVQ5AQ2GK+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115143; c=relaxed/simple;
	bh=3ncXg+RHpn6V1oPdh9MqpZNUimcsKHh3TMYUbe/iR4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL5L4RIHsuBfAavdn0UxYQJi+sLNozKMxonbEYczHgcFk6N4J94SyCxSGMN4UsleEvPcnJFzgRwsGrZL7gQ2BLRzpjXwJWToGtZL+m0rcjuPxDVqMgmuOwescUp6wDAHJ8P3ErvA5MExTqTRT3F44M3ftkLF12kAO0dM6g9XTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KEcyYel2; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741115141; x=1772651141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q8KH7lXOzwbGFNDC1/LZLoJz4qLdBJtZr2CrRnupNLw=;
  b=KEcyYel20gyjHobCNUMW1nsgjR5eB0bFob6ttBP+1dpBQvaX15xoqMnh
   3I3Be5fK9L03Diwm+k0dFIf2SSvo3V4Vf/K6nK3ulUJ5CEtP4fP+7h5/J
   OIzU+zlfcr3CI5xA/H11ROQlMj0R+XS6/TPUCDLuJB2uf2UadFKRcvusR
   M=;
X-IronPort-AV: E=Sophos;i="6.14,220,1736812800"; 
   d="scan'208";a="467900772"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:05:38 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.0.204:30174]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.50.41:2525] with esmtp (Farcaster)
 id f5dd4c16-0d4d-4b3c-a3d1-460f4f1fce5c; Tue, 4 Mar 2025 19:05:38 +0000 (UTC)
X-Farcaster-Flow-ID: f5dd4c16-0d4d-4b3c-a3d1-460f4f1fce5c
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:37 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:37 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:05:37 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.178])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 5B2C4A07BE;
	Tue,  4 Mar 2025 19:05:30 +0000 (UTC)
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
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v8 net-next 3/5] net: ena: PHC enable through sysfs
Date: Tue, 4 Mar 2025 21:05:02 +0200
Message-ID: <20250304190504.3743-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304190504.3743-1-darinzon@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
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
index 9cecb011..b565eab1 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -17,6 +17,7 @@
 
 #include "ena_netdev.h"
 #include "ena_pci_id_tbl.h"
+#include "ena_sysfs.h"
 #include "ena_xdp.h"
 
 #include "ena_phc.h"
@@ -41,8 +42,6 @@ MODULE_DEVICE_TABLE(pci, ena_pci_tbl);
 
 static int ena_rss_init_default(struct ena_adapter *adapter);
 static void check_for_admin_com_state(struct ena_adapter *adapter);
-static int ena_destroy_device(struct ena_adapter *adapter, bool graceful);
-static int ena_restore_device(struct ena_adapter *adapter);
 
 static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -3236,7 +3235,7 @@ err_disable_msix:
 	return rc;
 }
 
-static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
+int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -3287,7 +3286,7 @@ static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 	return rc;
 }
 
-static int ena_restore_device(struct ena_adapter *adapter)
+int ena_restore_device(struct ena_adapter *adapter)
 {
 	struct ena_com_dev_get_features_ctx get_feat_ctx;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -4022,10 +4021,17 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -4070,6 +4076,8 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_rss:
 	ena_com_delete_debug_area(ena_dev);
 	ena_com_rss_destroy(ena_dev);
+err_terminate_sysfs:
+	ena_sysfs_terminate(&pdev->dev);
 err_free_msix:
 	ena_com_dev_reset(ena_dev, ENA_REGS_RESET_INIT_ERR);
 	/* stop submitting admin commands on a device that was reset */
@@ -4115,6 +4123,8 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 	ena_dev = adapter->ena_dev;
 	netdev = adapter->netdev;
 
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


