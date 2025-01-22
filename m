Return-Path: <netdev+bounces-160245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69590A18F96
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1FE16956A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B920FA84;
	Wed, 22 Jan 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k4dkRnR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20595145FE0
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541286; cv=none; b=Q/ARmjIYO9h3lzgViA2f8dyeFZtdpCh/+ni4Y6lpuh2dO11BfHfjCzP19QeyVGDVSungl30JyazH3TJMi+6I7/VbywXvC0A4Utz5btPHsOlnv15PHcGSieUMhMJZaKa1JF0IpqQZOe7R3FLVgpgaWB7hvC6BgaSrZG0xdD1+VrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541286; c=relaxed/simple;
	bh=7i8Y44+/p7fUVNFBG0d6z/Vi32ANUIC/X85mfALNkwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daFy0O7E1APFf5zN0psEmFXeXt2UK80xPi8uC9tWTSp4wo+aOB05Qogt6uI3UiV62lsVY3UUQD4VGxalrj4kokE5OR2emmmVe8vgLJiAx1569gg0u/jnOF5TyfQknRrqZSymgXTOrjEP4IhtsC6cO+vPbsvNPr3RB0uJ1ZGokoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k4dkRnR/; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737541285; x=1769077285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J39HgrX/TRin+rw+6O/83e8/yek9FDryizOPWSrDcwc=;
  b=k4dkRnR/wn9tr9rZbSnmcEizLhtIPjxvTwYfP3UhCq9/V5K4GPmD59IK
   nrop8jWtoBKyzO8xhX+IKoVoZ4uA5qbtWVbBnhY6dcKQTXKnpDTCIc5b8
   qVbXhVGvsCZx+luymykHZ2iBWxllH4uf7OdzHCtekgZGwwifvIm87ToG3
   c=;
X-IronPort-AV: E=Sophos;i="6.13,224,1732579200"; 
   d="scan'208";a="402617359"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 10:21:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:55956]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.114:2525] with esmtp (Farcaster)
 id f7c8862f-68ad-4d5f-aea9-1fab6ba2f35a; Wed, 22 Jan 2025 10:21:23 +0000 (UTC)
X-Farcaster-Flow-ID: f7c8862f-68ad-4d5f-aea9-1fab6ba2f35a
Received: from EX19D009UWC001.ant.amazon.com (10.13.138.163) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D009UWC001.ant.amazon.com (10.13.138.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:23 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 22 Jan 2025 10:21:23 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.175])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTP id 4FF72404A2;
	Wed, 22 Jan 2025 10:21:17 +0000 (UTC)
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH v5 net-next 5/5] net: ena: PHC enable and error_bound through sysfs
Date: Wed, 22 Jan 2025 12:20:40 +0200
Message-ID: <20250122102040.752-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122102040.752-1-darinzon@amazon.com>
References: <20250122102040.752-1-darinzon@amazon.com>
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

In addition, customers are able to access the
`phc_error_bound` sysfs entry in order to get the
current error bound value.

Documentation is also updated.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  20 ++++
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  20 +++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   2 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     |   8 ++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |   1 +
 drivers/net/ethernet/amazon/ena/ena_sysfs.c   | 110 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_sysfs.h   |  28 +++++
 8 files changed, 185 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.h

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 19697f63..3b2744a7 100644
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
@@ -289,6 +301,14 @@ clock. The error bound (expressed in nanoseconds) is calculated by
 the device and is retrieved and cached by the driver upon every get PHC
 timestamp request.
 
+To retrieve the cached PHC error bound value, use the following:
+
+sysfs:
+
+.. code-block:: shell
+
+  cat /sys/bus/pci/devices/<domain:bus:slot.function>/phc_error_bound
+
 **PHC statistics**
 
 PHC can be monitored using :code:`ethtool -S` counters:
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
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 5ce9a32d..add51c8d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -229,3 +229,11 @@ int ena_phc_get_index(struct ena_adapter *adapter)
 
 	return -1;
 }
+
+int ena_phc_get_error_bound(struct ena_adapter *adapter, u32 *error_bound_nsec)
+{
+	if (!ena_phc_is_active(adapter))
+		return -EOPNOTSUPP;
+
+	return ena_com_phc_get_error_bound(adapter->ena_dev, error_bound_nsec);
+}
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.h b/drivers/net/ethernet/amazon/ena/ena_phc.h
index 7364fe71..9c47af84 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.h
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.h
@@ -33,5 +33,6 @@ int ena_phc_init(struct ena_adapter *adapter);
 void ena_phc_destroy(struct ena_adapter *adapter);
 int ena_phc_alloc(struct ena_adapter *adapter);
 void ena_phc_free(struct ena_adapter *adapter);
+int ena_phc_get_error_bound(struct ena_adapter *adapter, u32 *error_bound);
 
 #endif /* ENA_PHC_H */
diff --git a/drivers/net/ethernet/amazon/ena/ena_sysfs.c b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
new file mode 100644
index 00000000..dd604cc5
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
@@ -0,0 +1,110 @@
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
+/* Max PHC error bound string size takes into account max u32 value,
+ * null and new line characters.
+ */
+#define ENA_PHC_ERROR_BOUND_STR_MAX_LEN 12
+
+static ssize_t ena_show_phc_error_bound(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+	u32 error_bound_nsec = 0;
+	int rc;
+
+	rc = ena_phc_get_error_bound(adapter, &error_bound_nsec);
+	if (rc != 0)
+		return rc;
+
+	return snprintf(buf, ENA_PHC_ERROR_BOUND_STR_MAX_LEN, "%u\n",
+			error_bound_nsec);
+}
+
+static DEVICE_ATTR(phc_error_bound, S_IRUGO, ena_show_phc_error_bound, NULL);
+
+/******************************************************************************
+ *****************************************************************************/
+int ena_sysfs_init(struct device *dev)
+{
+	if (device_create_file(dev, &dev_attr_phc_enable))
+		dev_err(dev, "Failed to create phc_enable sysfs entry");
+
+	if (device_create_file(dev, &dev_attr_phc_error_bound))
+		dev_err(dev, "Failed to create phc_error_bound sysfs entry");
+
+	return 0;
+}
+
+/******************************************************************************
+ *****************************************************************************/
+void ena_sysfs_terminate(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_phc_enable);
+	device_remove_file(dev, &dev_attr_phc_error_bound);
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
2.40.1


