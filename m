Return-Path: <netdev+bounces-83785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6C894448
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C671F21EDA
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6C4D59E;
	Mon,  1 Apr 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ptoz102A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D94AEE4
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992270; cv=none; b=WooG3NyIzMkQaHfDNEkNkVSlCgdMWMt5Ocj/0xU0J8l4m7uCD03Bc0RNRuVVhV+ujwSBLkycB8ANIQ5Ina9TTX87sdxnND5o//FvSvZla1YmkeCiCBfa9NZWJcqx1xR20dqNlTp2hguvnFvVlFzZBAyoOfq3fNG/bXGV6YyhVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992270; c=relaxed/simple;
	bh=iE9rp00XY7mBCwawTQ/7ZAZe1A3H0TwzCKHLLG2Wqr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NadVamS1C2NgI1Fjvjk6aWRVrTXJs9zt2/w7DvvRSI5NoWdQbQ1Ib+D9pCmU3AiiFwwJ2yhCFeQ8PWlfD/CFHcsylo4pEHOcCNhN3RbMpFmly44DlLpZz3r8Oy1brQjEjbJh75Adlhm0wJPUc/0/FH+UzWoRfTFkz2QhrUVc8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ptoz102A; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992269; x=1743528269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iE9rp00XY7mBCwawTQ/7ZAZe1A3H0TwzCKHLLG2Wqr8=;
  b=Ptoz102AR1TM+GBIHTiL/wQgKy9XkiNhGGiTMFvKRc6ewP6M7okWuExM
   hIWX2XFi9j9aGpBhjvwmQLqORQCzhnBa2qXdVewsN0850pJMwjmGJbVaD
   02q8qNCnhaGPrGp0QgyyXzSL8oGD4PZPIdgVesqKEdvn9fVpCe2jMLbYj
   ZmcCVzu5CnqPBMjO+Xg72qN4YMaRdh484Aa/wmZx38OKNlNsOOi58Cx6a
   mx2QMsBlRX970ro5Eh5FieCN1N0xL2avoWaKCCoj7RdYnps+S1166dVJc
   Mk4KEcuZ2f4aKdHkzsmgJbnJkDlJbWcY474WSwFWFwgmj5dAJ0LvxgLjT
   w==;
X-CSE-ConnectionGUID: nAHlIJkNTDyuitbZkeT9kQ==
X-CSE-MsgGUID: 0noSUOp3Sias175mQ+UdMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606141"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606141"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235079"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/8] ice: add ice_adapter for shared data across PFs on the same NIC
Date: Mon,  1 Apr 2024 10:24:11 -0700
Message-ID: <20240401172421.1401696-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

There is a need for synchronization between ice PFs on the same physical
adapter.

Add a "struct ice_adapter" for holding data shared between PFs of the
same multifunction PCI device. The struct is refcounted - each ice_pf
holds a reference to it.

Its first use will be for PTP. I expect it will be useful also to
improve the ugliness that is ice_prot_id_tbl.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile      |   3 +-
 drivers/net/ethernet/intel/ice/ice.h         |   2 +
 drivers/net/ethernet/intel/ice/ice_adapter.c | 114 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 ++++
 drivers/net/ethernet/intel/ice/ice_main.c    |   8 ++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index cddd82d4ca0f..4fa09c321440 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -36,7 +36,8 @@ ice-y := ice_main.o	\
 	 ice_repr.o	\
 	 ice_tc_lib.o	\
 	 ice_fwlog.o	\
-	 ice_debugfs.o
+	 ice_debugfs.o  \
+	 ice_adapter.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
 	ice_virtchnl.o		\
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index c4127d5f2be3..a7e88d797d4c 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -77,6 +77,7 @@
 #include "ice_gnss.h"
 #include "ice_irq.h"
 #include "ice_dpll.h"
+#include "ice_adapter.h"
 
 #define ICE_BAR0		0
 #define ICE_REQ_DESC_MULTIPLE	32
@@ -537,6 +538,7 @@ struct ice_agg_node {
 
 struct ice_pf {
 	struct pci_dev *pdev;
+	struct ice_adapter *adapter;
 
 	struct devlink_region *nvm_region;
 	struct devlink_region *sram_region;
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
new file mode 100644
index 000000000000..f00ab998e853
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright Red Hat
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include "ice_adapter.h"
+
+static DEFINE_XARRAY(ice_adapters);
+
+/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
+#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
+#define INDEX_FIELD_BUS    GENMASK(12, 5)
+#define INDEX_FIELD_SLOT   GENMASK(4, 0)
+
+static unsigned long ice_adapter_index(const struct pci_dev *pdev)
+{
+	unsigned int domain = pci_domain_nr(pdev->bus);
+
+	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
+
+	return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
+	       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
+	       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
+}
+
+static struct ice_adapter *ice_adapter_new(void)
+{
+	struct ice_adapter *adapter;
+
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return NULL;
+
+	refcount_set(&adapter->refcount, 1);
+
+	return adapter;
+}
+
+static void ice_adapter_free(struct ice_adapter *adapter)
+{
+	kfree(adapter);
+}
+
+DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_free(_T))
+
+/**
+ * ice_adapter_get - Get a shared ice_adapter structure.
+ * @pdev: Pointer to the pci_dev whose driver is getting the ice_adapter.
+ *
+ * Gets a pointer to a shared ice_adapter structure. Physical functions (PFs)
+ * of the same multi-function PCI device share one ice_adapter structure.
+ * The ice_adapter is reference-counted. The PF driver must use ice_adapter_put
+ * to release its reference.
+ *
+ * Context: Process, may sleep.
+ * Return:  Pointer to ice_adapter on success.
+ *          ERR_PTR() on error. -ENOMEM is the only possible error.
+ */
+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
+{
+	struct ice_adapter *ret, __free(ice_adapter_free) *adapter = NULL;
+	unsigned long index = ice_adapter_index(pdev);
+
+	adapter = ice_adapter_new();
+	if (!adapter)
+		return ERR_PTR(-ENOMEM);
+
+	xa_lock(&ice_adapters);
+	ret = __xa_cmpxchg(&ice_adapters, index, NULL, adapter, GFP_KERNEL);
+	if (xa_is_err(ret)) {
+		ret = ERR_PTR(xa_err(ret));
+		goto unlock;
+	}
+	if (ret) {
+		refcount_inc(&ret->refcount);
+		goto unlock;
+	}
+	ret = no_free_ptr(adapter);
+unlock:
+	xa_unlock(&ice_adapters);
+	return ret;
+}
+
+/**
+ * ice_adapter_put - Release a reference to the shared ice_adapter structure.
+ * @pdev: Pointer to the pci_dev whose driver is releasing the ice_adapter.
+ *
+ * Releases the reference to ice_adapter previously obtained with
+ * ice_adapter_get.
+ *
+ * Context: Any.
+ */
+void ice_adapter_put(const struct pci_dev *pdev)
+{
+	unsigned long index = ice_adapter_index(pdev);
+	struct ice_adapter *adapter;
+
+	xa_lock(&ice_adapters);
+	adapter = xa_load(&ice_adapters, index);
+	if (WARN_ON(!adapter))
+		goto unlock;
+
+	if (!refcount_dec_and_test(&adapter->refcount))
+		goto unlock;
+
+	WARN_ON(__xa_erase(&ice_adapters, index) != adapter);
+	ice_adapter_free(adapter);
+unlock:
+	xa_unlock(&ice_adapters);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
new file mode 100644
index 000000000000..cb5a02eb24c1
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-FileCopyrightText: Copyright Red Hat */
+
+#ifndef _ICE_ADAPTER_H_
+#define _ICE_ADAPTER_H_
+
+#include <linux/refcount_types.h>
+
+struct pci_dev;
+
+/**
+ * struct ice_adapter - PCI adapter resources shared across PFs
+ * @refcount: Reference count. struct ice_pf objects hold the references.
+ */
+struct ice_adapter {
+	refcount_t refcount;
+};
+
+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
+void ice_adapter_put(const struct pci_dev *pdev);
+
+#endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 618570f23580..d85736f700dd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5093,6 +5093,7 @@ static int
 ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 {
 	struct device *dev = &pdev->dev;
+	struct ice_adapter *adapter;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int err;
@@ -5145,7 +5146,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	pci_set_master(pdev);
 
+	adapter = ice_adapter_get(pdev);
+	if (IS_ERR(adapter))
+		return PTR_ERR(adapter);
+
 	pf->pdev = pdev;
+	pf->adapter = adapter;
 	pci_set_drvdata(pdev, pf);
 	set_bit(ICE_DOWN, pf->state);
 	/* Disable service task until DOWN bit is cleared */
@@ -5196,6 +5202,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 err_load:
 	ice_deinit(pf);
 err_init:
+	ice_adapter_put(pdev);
 	pci_disable_device(pdev);
 	return err;
 }
@@ -5302,6 +5309,7 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
+	ice_adapter_put(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.41.0


