Return-Path: <netdev+bounces-81854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2787788B530
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 00:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92021F3FBA4
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB583A07;
	Mon, 25 Mar 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhxskEwk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8882D92
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408884; cv=none; b=IGVUoIV6XGCWPdg92SKyA4OQASEA567lZWG7GgitQz/RJOBzxqptXD6YxlmQbVGdmYk4QOMh5PCDnGUVYhIne1x3NPdMsE+fUzjCcYr6zdL36M99WKl7TLw/BAbl2HttQW2JZnrxGNweB10kYsaXqgLDFXNj1dnhpY/0MfI25d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408884; c=relaxed/simple;
	bh=4Zp+WETcEzdDXi5BixXxKEvWkQfZ00kG/xwNVVUybEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj6GqaJpBQSTU+O/XtE0qmhnUugdpV0EfVAjSJAYieeBbIQQxhNyKnivZ5Lx7OI3QaCBI/BVf5fmX/uA3z+tRQulDovQJVuWK4tseAhN55+moKMgyNVEq+Qo6pZeJxSyDrwysovyEC2SpgnHWhup/NC3UtqO/GyR14N7mC4LD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhxskEwk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711408881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GA9jfdZmg1MKTJItQLfJ7DKPHEpZe6NAQbPLt3+j67s=;
	b=QhxskEwkgTj0d6GFiVlC+R23zL5BwOrhFnkwia1s98lzx9qz5/wEgLpbBChjFxo2f/6i39
	VTmjtXrYshwQEOrIRWkfsqRUKccVWeHSBVS8jNt9lF9hIADov9/AWtktIpl53GjyKKruCP
	bqqp6RjOZVNyV4O6+5lnIcmJl1zOQqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-cT1RDj2-MkCIJR6H8DhGzg-1; Mon, 25 Mar 2024 19:21:18 -0400
X-MC-Unique: cT1RDj2-MkCIJR6H8DhGzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8E5E800262;
	Mon, 25 Mar 2024 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 741B41C060A4;
	Mon, 25 Mar 2024 23:21:14 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
Subject: [PATCH net-next v4 1/3] ice: add ice_adapter for shared data across PFs on the same NIC
Date: Tue, 26 Mar 2024 00:20:37 +0100
Message-ID: <20240325232039.76836-2-mschmidt@redhat.com>
In-Reply-To: <20240325232039.76836-1-mschmidt@redhat.com>
References: <20240325232039.76836-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

There is a need for synchronization between ice PFs on the same physical
adapter.

Add a "struct ice_adapter" for holding data shared between PFs of the
same multifunction PCI device. The struct is refcounted - each ice_pf
holds a reference to it.

Its first use will be for PTP. I expect it will be useful also to
improve the ugliness that is ice_prot_id_tbl.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
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
index 365c03d1c462..1ffecbdd361a 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -77,6 +77,7 @@
 #include "ice_gnss.h"
 #include "ice_irq.h"
 #include "ice_dpll.h"
+#include "ice_adapter.h"
 
 #define ICE_BAR0		0
 #define ICE_REQ_DESC_MULTIPLE	32
@@ -544,6 +545,7 @@ struct ice_agg_node {
 
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
index 33a164fa325a..7a75d14d8e9d 100644
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
2.43.2


