Return-Path: <netdev+bounces-25191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E6773573
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60632815E7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EA8191;
	Tue,  8 Aug 2023 00:41:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22009391
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 00:41:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBAF1724
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691455259; x=1722991259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oMYRtGeshyiwMWWvb02GR2lc4CsTLX2pN/kcZdeNrc=;
  b=cwj4iRHKqGwVIwVTgWgd2X6wBmgYD30vTDHWTi+QI5SATLNKcK9FhRJ2
   4RVyNFElG7moZg2VvoJwF4m62q8PTj2CGOajj0sT40cPpp4LjNK2V7pv3
   fJicTy80DixAHs8CUonq4UOJguch/XtewZeTL4xl5sZPHzK9TnhYmHHlO
   5YtlJbr9v+Hm4WUtVPsI2kGtII8wcKDlWyP/UIGFngDLZVFoAi3+Pp8Hc
   pKaIAMoQ52dx5phZpuk+JlQ40Op0ueXezbNqnwpz7nmwu49Cnrxd0b4rW
   0vwLPbxH9oype3IstGNC080xalJLu6VGmF2NNbriLLAwgm7EgXgf5xN/T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360774036"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360774036"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 17:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061790168"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="1061790168"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2023 17:40:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Phani Burra <phani.r.burra@intel.com>,
	anthony.l.nguyen@intel.com,
	pavan.kumar.linga@intel.com,
	emil.s.tantilov@intel.com,
	jesse.brandeburg@intel.com,
	sridhar.samudrala@intel.com,
	shiraz.saleem@intel.com,
	sindhu.devale@intel.com,
	willemb@google.com,
	decot@google.com,
	andrew@lunn.ch,
	leon@kernel.org,
	mst@redhat.com,
	simon.horman@corigine.com,
	shannon.nelson@amd.com,
	stephen@networkplumber.org,
	Alan Brady <alan.brady@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>
Subject: [PATCH net-next v4 02/15] idpf: add module register and probe functionality
Date: Mon,  7 Aug 2023 17:34:03 -0700
Message-Id: <20230808003416.3805142-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
References: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Phani Burra <phani.r.burra@intel.com>

Add the required support to register IDPF PCI driver, as well as
probe and remove call backs. Enable the PCI device and request
the kernel to reserve the memory resources that will be used by the
driver. Finally map the BAR0 address space.

Signed-off-by: Phani Burra <phani.r.burra@intel.com>
Co-developed-by: Alan Brady <alan.brady@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
Co-developed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
Co-developed-by: Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>
Signed-off-by: Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |   9 ++
 drivers/net/ethernet/intel/idpf/idpf.h        |  28 ++++
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  14 ++
 drivers/net/ethernet/intel/idpf/idpf_devids.h |  10 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 136 ++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/idpf/Makefile
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devids.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_main.c

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
new file mode 100644
index 000000000000..73173bde98b1
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2023 Intel Corporation
+
+# Makefile for Intel(R) Infrastructure Data Path Function Linux Driver
+
+obj-$(CONFIG_IDPF) += idpf.o
+
+idpf-y := \
+	idpf_main.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
new file mode 100644
index 000000000000..0f494396d68f
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _IDPF_H_
+#define _IDPF_H_
+
+#include <linux/aer.h>
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+
+#include "idpf_controlq.h"
+
+/* available message levels */
+#define IDPF_AVAIL_NETIF_M (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
+
+/**
+ * struct idpf_adapter - Device data struct generated on probe
+ * @pdev: PCI device struct given on probe
+ * @msg_enable: Debug message level enabled
+ * @hw: Device access data
+ */
+struct idpf_adapter {
+	struct pci_dev *pdev;
+	u32 msg_enable;
+	struct idpf_hw hw;
+};
+
+#endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.h b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
new file mode 100644
index 000000000000..11388834cf64
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _IDPF_CONTROLQ_H_
+#define _IDPF_CONTROLQ_H_
+
+struct idpf_hw {
+	void __iomem *hw_addr;
+	resource_size_t hw_addr_len;
+
+	struct idpf_adapter *back;
+};
+
+#endif /* _IDPF_CONTROLQ_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_devids.h b/drivers/net/ethernet/intel/idpf/idpf_devids.h
new file mode 100644
index 000000000000..5154a52ae61c
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_devids.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _IDPF_DEVIDS_H_
+#define _IDPF_DEVIDS_H_
+
+#define IDPF_DEV_ID_PF			0x1452
+#define IDPF_DEV_ID_VF			0x145C
+
+#endif /* _IDPF_DEVIDS_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
new file mode 100644
index 000000000000..43ae6d8c13b7
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "idpf.h"
+#include "idpf_devids.h"
+
+#define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
+
+MODULE_DESCRIPTION(DRV_SUMMARY);
+MODULE_LICENSE("GPL");
+
+/**
+ * idpf_remove - Device removal routine
+ * @pdev: PCI device information struct
+ */
+static void idpf_remove(struct pci_dev *pdev)
+{
+	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
+
+	pci_disable_pcie_error_reporting(pdev);
+	pci_set_drvdata(pdev, NULL);
+	kfree(adapter);
+}
+
+/**
+ * idpf_shutdown - PCI callback for shutting down device
+ * @pdev: PCI device information struct
+ */
+static void idpf_shutdown(struct pci_dev *pdev)
+{
+	idpf_remove(pdev);
+
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+}
+
+/**
+ * idpf_cfg_hw - Initialize HW struct
+ * @adapter: adapter to setup hw struct for
+ *
+ * Returns 0 on success, negative on failure
+ */
+static int idpf_cfg_hw(struct idpf_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct idpf_hw *hw = &adapter->hw;
+
+	hw->hw_addr = pcim_iomap_table(pdev)[0];
+	if (!hw->hw_addr) {
+		pci_err(pdev, "failed to allocate PCI iomap table\n");
+
+		return -ENOMEM;
+	}
+
+	hw->back = adapter;
+
+	return 0;
+}
+
+/**
+ * idpf_probe - Device initialization routine
+ * @pdev: PCI device information struct
+ * @ent: entry in idpf_pci_tbl
+ *
+ * Returns 0 on success, negative on failure
+ */
+static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct idpf_adapter *adapter;
+	int err;
+
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+	adapter->pdev = pdev;
+
+	err = pcim_enable_device(pdev);
+	if (err)
+		goto err_free;
+
+	err = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (err) {
+		pci_err(pdev, "pcim_iomap_regions failed %pe\n", ERR_PTR(err));
+
+		goto err_free;
+	}
+
+	/* set up for high or low dma */
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (err) {
+		pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(err));
+
+		goto err_free;
+	}
+
+	pci_enable_pcie_error_reporting(pdev);
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, adapter);
+
+	/* setup msglvl */
+	adapter->msg_enable = netif_msg_init(-1, IDPF_AVAIL_NETIF_M);
+
+	err = idpf_cfg_hw(adapter);
+	if (err) {
+		dev_err(dev, "Failed to configure HW structure for adapter: %d\n",
+			err);
+		goto err_cfg_hw;
+	}
+
+	return 0;
+
+err_cfg_hw:
+	pci_disable_pcie_error_reporting(pdev);
+err_free:
+	kfree(adapter);
+	return err;
+}
+
+/* idpf_pci_tbl - PCI Dev idpf ID Table
+ */
+static const struct pci_device_id idpf_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, IDPF_DEV_ID_PF)},
+	{ PCI_VDEVICE(INTEL, IDPF_DEV_ID_VF)},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(pci, idpf_pci_tbl);
+
+static struct pci_driver idpf_driver = {
+	.name			= KBUILD_MODNAME,
+	.id_table		= idpf_pci_tbl,
+	.probe			= idpf_probe,
+	.remove			= idpf_remove,
+	.shutdown		= idpf_shutdown,
+};
+module_pci_driver(idpf_driver);
-- 
2.38.1


