Return-Path: <netdev+bounces-25215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A8773611
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2D1C20E19
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 01:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0858395;
	Tue,  8 Aug 2023 01:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9BA53
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 01:54:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51BBB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691459645; x=1722995645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmrmSDCYLGQJZ0EoP+7B2kArnjWdBRpOXJnmYFAFv1s=;
  b=kEBkek0sJeUeQmJATavK3w961qSQWALP1jAhTshmStrnv5mto9uXFBFj
   MzH7kVldZQjfCLXD4X7fI5yeA9sTG2oDg1z7PTSg25eP/B1udr1agTmyl
   NuRvfDpgsjetmW8b7NoMRWOJMcTW9t7ZYkMcYVLBjlebmOWSCyEdSwQxH
   EUFOW6KzOoc1jnOR+OJz2eyOg+Ty10NhmJzFUCN4oGwf1I2JjSsaMxHNu
   wwe5gdjenNWeKNJimelBXamq7azirIKPJMAO6uYdF5/mEFjGtUq/06hlI
   ZQNyZ0bYkskwmH1BBY6bZ7Tb11D4RGqHcM8yedaieOPBaft+8UQaDX4Se
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350997465"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="350997465"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 18:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801162757"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="801162757"
Received: from dpdk-wuwenjun-icelake-ii.sh.intel.com ([10.67.110.188])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2023 18:54:02 -0700
From: Wenjun Wu <wenjun1.wu@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: xuejun.zhang@intel.com,
	madhu.chittim@intel.com,
	qi.z.zhang@intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-next v2 3/5] iavf: Add devlink and devlink port support
Date: Tue,  8 Aug 2023 09:57:32 +0800
Message-Id: <20230808015734.1060525-4-wenjun1.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808015734.1060525-1-wenjun1.wu@intel.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230808015734.1060525-1-wenjun1.wu@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jun Zhang <xuejun.zhang@intel.com>

To allow user to configure queue bandwidth, devlink port support
is added to support devlink port rate API.

Add devlink framework registration/unregistration on iavf driver
initialization and remove, and devlink port of DEVLINK_PORT_FLAVOUR_VIRTUAL
is created to be associated iavf net device.

Signed-off-by: Jun Zhang <xuejun.zhang@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/iavf/Makefile      |  2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  6 ++
 .../net/ethernet/intel/iavf/iavf_devlink.c    | 93 +++++++++++++++++++
 .../net/ethernet/intel/iavf/iavf_devlink.h    | 17 ++++
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 14 +++
 6 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_devlink.h

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 9bc0a9519899..f916b8ef6acb 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -256,6 +256,7 @@ config I40EVF
 	tristate "Intel(R) Ethernet Adaptive Virtual Function support"
 	select IAVF
 	depends on PCI_MSI
+	select NET_DEVLINK
 	help
 	  This driver supports virtual functions for Intel XL710,
 	  X710, X722, XXV710, and all devices advertising support for
diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index 9c3e45c54d01..b5d7db97ab8b 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -12,5 +12,5 @@ subdir-ccflags-y += -I$(src)
 obj-$(CONFIG_IAVF) += iavf.o
 
 iavf-objs := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
-	     iavf_adv_rss.o \
+	     iavf_adv_rss.o iavf_devlink.o \
 	     iavf_txrx.o iavf_common.o iavf_adminq.o iavf_client.o
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 8cbdebc5b698..519aeaec793c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -33,9 +33,11 @@
 #include <net/udp.h>
 #include <net/tc_act/tc_gact.h>
 #include <net/tc_act/tc_mirred.h>
+#include <net/devlink.h>
 
 #include "iavf_type.h"
 #include <linux/avf/virtchnl.h>
+#include "iavf_devlink.h"
 #include "iavf_txrx.h"
 #include "iavf_fdir.h"
 #include "iavf_adv_rss.h"
@@ -369,6 +371,10 @@ struct iavf_adapter {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 
+	/* devlink & port data */
+	struct devlink *devlink;
+	struct devlink_port devlink_port;
+
 	struct iavf_hw hw; /* defined in iavf_type.h */
 
 	enum iavf_state_t state;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_devlink.c b/drivers/net/ethernet/intel/iavf/iavf_devlink.c
new file mode 100644
index 000000000000..991d041e5922
--- /dev/null
+++ b/drivers/net/ethernet/intel/iavf/iavf_devlink.c
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "iavf.h"
+#include "iavf_devlink.h"
+
+static const struct devlink_ops iavf_devlink_ops = {};
+
+/**
+ * iavf_devlink_register - Register allocated devlink instance for iavf adapter
+ * @adapter: the iavf adapter to register the devlink for.
+ *
+ * Register the devlink instance associated with this iavf adapter
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int iavf_devlink_register(struct iavf_adapter *adapter)
+{
+	struct device *dev = &adapter->pdev->dev;
+	struct iavf_devlink *ref;
+	struct devlink *devlink;
+
+	/* Allocate devlink instance */
+	devlink = devlink_alloc(&iavf_devlink_ops, sizeof(struct iavf_devlink),
+				dev);
+	if (!devlink)
+		return -ENOMEM;
+
+	/* Init iavf adapter devlink */
+	adapter->devlink = devlink;
+	ref = devlink_priv(devlink);
+	ref->devlink_ref = adapter;
+
+	devlink_register(devlink);
+
+	return 0;
+}
+
+/**
+ * iavf_devlink_unregister - Unregister devlink resources for iavf adapter.
+ * @adapter: the iavf adapter structure
+ *
+ * Releases resources used by devlink and cleans up associated memory.
+ */
+void iavf_devlink_unregister(struct iavf_adapter *adapter)
+{
+	devlink_unregister(adapter->devlink);
+	devlink_free(adapter->devlink);
+}
+
+/**
+ * iavf_devlink_port_register - Register devlink port for iavf adapter
+ * @adapter: the iavf adapter to register the devlink port for.
+ *
+ * Register the devlink port instance associated with this iavf adapter
+ * before iavf adapter registers with netdevice
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int iavf_devlink_port_register(struct iavf_adapter *adapter)
+{
+	struct device *dev = &adapter->pdev->dev;
+	struct devlink_port_attrs attrs = {};
+	int err;
+
+	/* Create devlink port: attr/port flavour, port index */
+	SET_NETDEV_DEVLINK_PORT(adapter->netdev, &adapter->devlink_port);
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
+	memset(&adapter->devlink_port, 0, sizeof(adapter->devlink_port));
+	devlink_port_attrs_set(&adapter->devlink_port, &attrs);
+
+	/* Register with driver specific index (device id) */
+	err = devlink_port_register(adapter->devlink, &adapter->devlink_port,
+				    adapter->hw.bus.device);
+	if (err)
+		dev_err(dev, "devlink port registration failed: %d\n", err);
+
+	return err;
+}
+
+/**
+ * iavf_devlink_port_unregister - Unregister devlink port for iavf adapter.
+ * @adapter: the iavf adapter structure
+ *
+ * Releases resources used by devlink port and registration with devlink.
+ */
+void iavf_devlink_port_unregister(struct iavf_adapter *adapter)
+{
+	if (!adapter->devlink_port.registered)
+		return;
+
+	devlink_port_unregister(&adapter->devlink_port);
+}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_devlink.h b/drivers/net/ethernet/intel/iavf/iavf_devlink.h
new file mode 100644
index 000000000000..5c122278611a
--- /dev/null
+++ b/drivers/net/ethernet/intel/iavf/iavf_devlink.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _IAVF_DEVLINK_H_
+#define _IAVF_DEVLINK_H_
+
+/* iavf devlink structure pointing to iavf adapter */
+struct iavf_devlink {
+	struct iavf_adapter *devlink_ref;	/* ref to iavf adapter */
+};
+
+int iavf_devlink_register(struct iavf_adapter *adapter);
+void iavf_devlink_unregister(struct iavf_adapter *adapter);
+int iavf_devlink_port_register(struct iavf_adapter *adapter);
+void iavf_devlink_port_unregister(struct iavf_adapter *adapter);
+
+#endif /* _IAVF_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7b300c86ceda..db010e68d5d2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2037,6 +2037,7 @@ static void iavf_finish_config(struct work_struct *work)
 				iavf_free_rss(adapter);
 				iavf_free_misc_irq(adapter);
 				iavf_reset_interrupt_capability(adapter);
+				iavf_devlink_port_unregister(adapter);
 				iavf_change_state(adapter,
 						  __IAVF_INIT_CONFIG_ADAPTER);
 				goto out;
@@ -2708,6 +2709,9 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	if (err)
 		goto err_sw_init;
 
+	if (!adapter->netdev_registered)
+		iavf_devlink_port_register(adapter);
+
 	netif_carrier_off(netdev);
 	adapter->link_up = false;
 	netif_tx_stop_all_queues(netdev);
@@ -2749,6 +2753,7 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 err_mem:
 	iavf_free_rss(adapter);
 	iavf_free_misc_irq(adapter);
+	iavf_devlink_port_unregister(adapter);
 err_sw_init:
 	iavf_reset_interrupt_capability(adapter);
 err:
@@ -4995,6 +5000,12 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
+	/* Register iavf adapter with devlink */
+	err = iavf_devlink_register(adapter);
+	if (err)
+		dev_err(&pdev->dev, "devlink registration failed: %d\n", err);
+
+	/* Keep driver interface even on devlink registration failure */
 	return 0;
 
 err_ioremap:
@@ -5139,6 +5150,9 @@ static void iavf_remove(struct pci_dev *pdev)
 				 err);
 	}
 
+	iavf_devlink_port_unregister(adapter);
+	iavf_devlink_unregister(adapter);
+
 	mutex_lock(&adapter->crit_lock);
 	dev_info(&adapter->pdev->dev, "Removing device\n");
 	iavf_change_state(adapter, __IAVF_REMOVE);
-- 
2.34.1


