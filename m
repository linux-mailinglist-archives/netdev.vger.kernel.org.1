Return-Path: <netdev+bounces-192269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BDABF32F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1459D17B2EC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08A23C517;
	Wed, 21 May 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="d8NJ6K/d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94B239E79
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827857; cv=none; b=lZ80dzBhGL0u/ChRboLvNTinVwsVQRIh4OHlUunhYIa/iW5fZmOplJa8ei+QjdIuR+hiNNnerduNmFIBNQeqQkNIZYzRwIxPNrqNFA9n60Odurug7l3BT61JfaqXcxm97DW2etoeVIP6jOSiTps4Cx6Mkak2z47En7BFB6hOFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827857; c=relaxed/simple;
	bh=nmhXtQAyhoyOCaAwXo6Zgh1R/EQ4SFkwIGiNB0tBDEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwchwlsP/J6ip2bQwyywCz63u52xlBUrdMBPniNZu08+foMWqBnrx0Oas9Sj5nh7vMge2TA2txPAftxNkwK4oWH6SJJHmkzFDnqdQsP244F4KiF+fVwqThvTxkaXyxqw2JYURM69pDSpc+kkUlebC0W2PASB4hkdxBFkNckUicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=d8NJ6K/d; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747827855; x=1779363855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Fc5LTzNapXWQtdddbATOmf83lEcRMYgc0S20mn1+tA=;
  b=d8NJ6K/dd6mc1p/TERYmGuSipDAQX6oFSru8FX8Gbs95v5VeSE2Fnjp6
   OviDpFzXsATLfLIOm22TssHI0RaF9GpRsaWW+ujUjqscZtqMsjd2F8e/Q
   +JECo0bteq4KNjqDdJUDi+RGukYBZiyidUQBdc3d/8METhlx9UdT6l3Sn
   6nwQUFyAt5zZM+9ji+wxffrnLl0RZlWVFb8BH5hf0pv1R/yjmlzX1E1jV
   iUS2tu5274EAsipiexJw7Ka7l4ETu3dI6SwzVRe6zhOCuyCmv5EaZiLLh
   cRPP3ix2wtWXr8v8Z2ONwDQNgHfa937ngCsNrct8jSigcRGS92aBK/tQs
   g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="199296408"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:44:12 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:53535]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.53:2525] with esmtp (Farcaster)
 id 7f16fb6a-b49a-441a-8386-7f124eeca363; Wed, 21 May 2025 11:44:11 +0000 (UTC)
X-Farcaster-Flow-ID: 7f16fb6a-b49a-441a-8386-7f124eeca363
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:44:11 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:43:59 +0000
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
Subject: [PATCH v9 net-next 3/8] net: ena: Add device reload capability through devlink
Date: Wed, 21 May 2025 14:42:49 +0300
Message-ID: <20250521114254.369-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521114254.369-1-darinzon@amazon.com>
References: <20250521114254.369-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Adding basic devlink capability support of reloading the driver.
This capability is required to support driver init type
devlink params (DEVLINK_PARAM_CMODE_DRIVERINIT). Such params
require reloading of the driver (destroy/restore sequence).
The reloading is done by the devlink framework using the
hooks provided by the driver.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  21 ++++
 drivers/net/ethernet/amazon/Kconfig           |   1 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 116 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_devlink.h |  19 +++
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  30 ++++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   4 +
 7 files changed, 187 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.h

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 98dc6217..3cbf9854 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -57,6 +57,7 @@ ena_ethtool.c       ethtool callbacks.
 ena_xdp.[ch]        XDP files
 ena_pci_id_tbl.h    Supported device IDs.
 ena_phc.[ch]        PTP hardware clock infrastructure (see `PHC`_ for more info)
+ena_devlink.[ch]    devlink files.
 =================   ======================================================
 
 Management Interface:
@@ -269,6 +270,26 @@ RSS
 - The user can provide a hash key, hash function, and configure the
   indirection table through `ethtool(8)`.
 
+DEVLINK SUPPORT
+===============
+.. _`devlink`: https://www.kernel.org/doc/html/latest/networking/devlink/index.html
+
+`devlink`_ supports reloading the driver and initiating re-negotiation with the ENA device
+
+.. code-block:: shell
+
+  sudo devlink dev reload pci/<domain:bus:slot.function>
+  # for example:
+  sudo devlink dev reload pci/0000:00:06.0
+
+In order to use devlink, environment variable ``ENA_DEVLINK_INCLUDE`` needs to be set.
+
+.. code-block:: shell
+
+  ENA_DEVLINK_INCLUDE=1 make
+
+Note that `devlink`_ is supported in the driver from Linux Kernel v6.12 and on.
+
 DATA PATH
 =========
 
diff --git a/drivers/net/ethernet/amazon/Kconfig b/drivers/net/ethernet/amazon/Kconfig
index 8d61bc62..95dcc396 100644
--- a/drivers/net/ethernet/amazon/Kconfig
+++ b/drivers/net/ethernet/amazon/Kconfig
@@ -21,6 +21,7 @@ config ENA_ETHERNET
 	depends on PCI_MSI && !CPU_BIG_ENDIAN
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select DIMLIB
+	select NET_DEVLINK
 	help
 	  This driver supports Elastic Network Adapter (ENA)"
 
diff --git a/drivers/net/ethernet/amazon/ena/Makefile b/drivers/net/ethernet/amazon/ena/Makefile
index 8c874177..4b6511db 100644
--- a/drivers/net/ethernet/amazon/ena/Makefile
+++ b/drivers/net/ethernet/amazon/ena/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_ENA_ETHERNET) += ena.o
 
-ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o ena_phc.o
+ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o ena_phc.o ena_devlink.o
diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c b/drivers/net/ethernet/amazon/ena/ena_devlink.c
new file mode 100644
index 00000000..e0294886
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) Amazon.com, Inc. or its affiliates.
+ * All rights reserved.
+ */
+
+#include "linux/pci.h"
+#include "ena_devlink.h"
+
+static int ena_devlink_reload_down(struct devlink *devlink,
+				   bool netns_change,
+				   enum devlink_reload_action action,
+				   enum devlink_reload_limit limit,
+				   struct netlink_ext_ack *extack)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+
+	if (netns_change) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Namespace change is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Action is not supported");
+		return -EOPNOTSUPP;
+	}
+	if (limit != DEVLINK_RELOAD_LIMIT_UNSPEC) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Driver reload doesn't support limitations");
+		return -EOPNOTSUPP;
+	}
+
+	rtnl_lock();
+	ena_destroy_device(adapter, false);
+	rtnl_unlock();
+
+	return 0;
+}
+
+static int ena_devlink_reload_up(struct devlink *devlink,
+				 enum devlink_reload_action action,
+				 enum devlink_reload_limit limit,
+				 u32 *actions_performed,
+				 struct netlink_ext_ack *extack)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+	int err = 0;
+
+	if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Action is not supported");
+		return -EOPNOTSUPP;
+	}
+	if (limit != DEVLINK_RELOAD_LIMIT_UNSPEC) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Driver reload doesn't support limitations");
+		return -EOPNOTSUPP;
+	}
+
+	rtnl_lock();
+	/* Check that no other routine initialized the device (e.g.
+	 * ena_fw_reset_device()). Also we're under devlink_mutex here,
+	 * so devlink isn't freed under our feet.
+	 */
+	if (!test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
+		err = ena_restore_device(adapter);
+
+	rtnl_unlock();
+
+	if (!err)
+		*actions_performed = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
+
+	return err;
+}
+
+static const struct devlink_ops ena_devlink_ops = {
+	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT),
+	.reload_down	= ena_devlink_reload_down,
+	.reload_up	= ena_devlink_reload_up,
+};
+
+struct devlink *ena_devlink_alloc(struct ena_adapter *adapter)
+{
+	struct device *dev = &adapter->pdev->dev;
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&ena_devlink_ops,
+				sizeof(struct ena_adapter *),
+				dev);
+	if (!devlink) {
+		netdev_err(adapter->netdev,
+			   "Failed to allocate devlink struct\n");
+		return NULL;
+	}
+
+	ENA_DEVLINK_PRIV(devlink) = adapter;
+	adapter->devlink = devlink;
+
+	return devlink;
+}
+
+void ena_devlink_free(struct devlink *devlink)
+{
+	devlink_free(devlink);
+}
+
+void ena_devlink_register(struct devlink *devlink, struct device *dev)
+{
+	devlink_register(devlink);
+}
+
+void ena_devlink_unregister(struct devlink *devlink)
+{
+	devlink_unregister(devlink);
+}
diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.h b/drivers/net/ethernet/amazon/ena/ena_devlink.h
new file mode 100644
index 00000000..cb1a5f21
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) Amazon.com, Inc. or its affiliates.
+ * All rights reserved.
+ */
+#ifndef DEVLINK_H
+#define DEVLINK_H
+
+#include "ena_netdev.h"
+#include <net/devlink.h>
+
+#define ENA_DEVLINK_PRIV(devlink) \
+	(*(struct ena_adapter **)devlink_priv(devlink))
+
+struct devlink *ena_devlink_alloc(struct ena_adapter *adapter);
+void ena_devlink_free(struct devlink *devlink);
+void ena_devlink_register(struct devlink *devlink, struct device *dev);
+void ena_devlink_unregister(struct devlink *devlink);
+
+#endif /* DEVLINK_H */
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 57fbc8a5..a4d35405 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -21,6 +21,8 @@
 
 #include "ena_phc.h"
 
+#include "ena_devlink.h"
+
 MODULE_AUTHOR("Amazon.com, Inc. or its affiliates");
 MODULE_DESCRIPTION(DEVICE_NAME);
 MODULE_LICENSE("GPL");
@@ -41,8 +43,6 @@ MODULE_DEVICE_TABLE(pci, ena_pci_tbl);
 
 static int ena_rss_init_default(struct ena_adapter *adapter);
 static void check_for_admin_com_state(struct ena_adapter *adapter);
-static int ena_destroy_device(struct ena_adapter *adapter, bool graceful);
-static int ena_restore_device(struct ena_adapter *adapter);
 
 static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -3240,7 +3240,7 @@ err_disable_msix:
 	return rc;
 }
 
-static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
+int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -3291,7 +3291,7 @@ static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 	return rc;
 }
 
-static int ena_restore_device(struct ena_adapter *adapter)
+int ena_restore_device(struct ena_adapter *adapter)
 {
 	struct ena_com_dev_get_features_ctx get_feat_ctx;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -3876,6 +3876,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ena_adapter *adapter;
 	struct net_device *netdev;
 	static int adapters_found;
+	struct devlink *devlink;
 	u32 max_num_io_queues;
 	bool wd_state;
 	int bars, rc;
@@ -3959,12 +3960,20 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_metrics_destroy;
 	}
 
+	/* Need to do this before ena_device_init */
+	devlink = ena_devlink_alloc(adapter);
+	if (!devlink) {
+		netdev_err(netdev, "ena_devlink_alloc failed\n");
+		rc = -ENOMEM;
+		goto err_metrics_destroy;
+	}
+
 	rc = ena_device_init(adapter, pdev, &get_feat_ctx, &wd_state);
 	if (rc) {
 		dev_err(&pdev->dev, "ENA device init failed\n");
 		if (rc == -ETIME)
 			rc = -EPROBE_DEFER;
-		goto err_metrics_destroy;
+		goto ena_devlink_destroy;
 	}
 
 	/* Initial TX and RX interrupt delay. Assumes 1 usec granularity.
@@ -4069,6 +4078,12 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	adapters_found++;
 
+	/* From this point, the devlink device is visible to users.
+	 * Perform the registration last to ensure that all the resources
+	 * are available and that the netdevice is registered.
+	 */
+	ena_devlink_register(devlink, &pdev->dev);
+
 	return 0;
 
 err_rss:
@@ -4085,6 +4100,8 @@ err_worker_destroy:
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+ena_devlink_destroy:
+	ena_devlink_free(devlink);
 err_metrics_destroy:
 	ena_com_delete_customer_metrics_buffer(ena_dev);
 err_free_phc:
@@ -4131,6 +4148,9 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 
 	ena_phc_free(adapter);
 
+	ena_devlink_unregister(adapter->devlink);
+	ena_devlink_free(adapter->devlink);
+
 	if (shutdown) {
 		netif_device_detach(netdev);
 		dev_close(netdev);
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 7867cd7f..f48b12ff 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -387,6 +387,8 @@ struct ena_adapter {
 	struct bpf_prog *xdp_bpf_prog;
 	u32 xdp_first_ring;
 	u32 xdp_num_queues;
+
+	struct devlink *devlink;
 };
 
 void ena_set_ethtool_ops(struct net_device *netdev);
@@ -416,6 +418,8 @@ static inline void ena_reset_device(struct ena_adapter *adapter,
 	set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
 }
 
+int ena_destroy_device(struct ena_adapter *adapter, bool graceful);
+int ena_restore_device(struct ena_adapter *adapter);
 int handle_invalid_req_id(struct ena_ring *ring, u16 req_id,
 			  struct ena_tx_buffer *tx_info, bool is_xdp);
 
-- 
2.47.1


