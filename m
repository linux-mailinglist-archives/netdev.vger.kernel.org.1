Return-Path: <netdev+bounces-179594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87FA7DC3F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4294C1891A46
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086A22B8BC;
	Mon,  7 Apr 2025 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4B+QEJz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691323A9B6
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025225; cv=none; b=jTY/c4B4V/GhzhepbXqhwaulf3rxuHrnRA5RO18OKoKmfBBdV+5E46zYVYBKjO51lgFadOleZCpoqwx2qAS8gDEdD3ZPJrwav5AkcjkDf0eIc90q2YL2/3BDqFpzrBmSuxx/ZM4B+x9Vl4r2fuzKC7jH1WXwFck0WomJXYie7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025225; c=relaxed/simple;
	bh=SUSl4c4Gl8Z51q9dI7XNp3Pt/ftgqXSIM2YqGVHgH+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZvjgrkNgii9xiU3T/h2YMTViEPcgIEq+a7qc+p2cRmtTVF3QPZYJq5hUvk/ln8RWNRJ3rr76JEt8dRDKNmK5zPKt70MXLqFNr1qu4U7uLOJtXe+vHrN455zOwD6ORULuODtTRRT6BtgJZIf5Ie6t+/2y8XXzg85wGM5wmfSThiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4B+QEJz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744025223; x=1775561223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SUSl4c4Gl8Z51q9dI7XNp3Pt/ftgqXSIM2YqGVHgH+Y=;
  b=J4B+QEJz27w6dZHA/bR8ZIfoYzAN+CDcE2cxzJ2jrPilh2P6EQxn9FpR
   flKQ7TuyF8klRnWLlkiLdxwDZmO95af03nLOhHnVQ26WungKP2nOeiQxu
   zsLFO5Fn19NEiaCysOEV0lkKU0q4CQhSrCVkJ4Hof3H/Kyg5GDY3BvYpK
   UN9wXpWqHdi120eSUo44AWBLkSpfJh2DUSmfv8e7ZZI8AyLtBZzLFuO/G
   wCXRn/PrgW9C0TTDy1E3ULFwP28+m3OwWfndgi+MuQpl9weZ5lUKss7r1
   83h33TysVUoC4jFL9K/8e/2pRJZ/ikY1giL6a9zPbVJDlKeYmFlLI5717
   A==;
X-CSE-ConnectionGUID: jn2OpyXQQhyjallY+thtKQ==
X-CSE-MsgGUID: 84yol2X4QLar3pDE2yzHjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49200614"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49200614"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 04:27:02 -0700
X-CSE-ConnectionGUID: D1eJWYa4RUiqguvK/G0XuQ==
X-CSE-MsgGUID: 1nacUgGiQJaL8+mhdboF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132900395"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2025 04:26:59 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id F1C9133EBD;
	Mon,  7 Apr 2025 12:26:57 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for ice_adapter index
Date: Mon,  7 Apr 2025 13:20:05 +0200
Message-Id: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use Device Serial Number instead of PCI bus/device/function for
index of struct ice_adapter.
Functions on the same physical device should point to the very same
ice_adapter instance.

This is not only simplification, but also fixes things up when PF
is passed to VM (and thus has a random BDF).

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Karol Kolacinski <karol.kolacinski@intel.com>
CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
CC: Michal Schmidt <mschmidt@redhat.com>
CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

v2:
 - target to -net (Jiri)
 - mix both halves of u64 DSN on 32bit systems (Jiri)
 - (no changes in terms of fallbacks for pre-prod HW)
 - warn when there is DSN collision after reducing to 32bit

v1:
https://lore.kernel.org/netdev/20250306211159.3697-2-przemyslaw.kitszel@intel.com
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++-
 drivers/net/ethernet/intel/ice/ice_adapter.c | 43 ++++++++------------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index e233225848b3..ac15c0d2bc1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -32,17 +32,19 @@ struct ice_port_list {
  * @refcount: Reference count. struct ice_pf objects hold the references.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
+ * @device_serial_number: DSN cached for collision detection on 32bit systems
  */
 struct ice_adapter {
 	refcount_t refcount;
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
+	u64 device_serial_number;
 };
 
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
-void ice_adapter_put(const struct pci_dev *pdev);
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
+void ice_adapter_put(struct pci_dev *pdev);
 
 #endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 01a08cfd0090..3df3fa6d5129 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -14,29 +13,13 @@
 static DEFINE_XARRAY(ice_adapters);
 static DEFINE_MUTEX(ice_adapters_mutex);
 
-/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
-#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
-#define INDEX_FIELD_DEV    GENMASK(31, 16)
-#define INDEX_FIELD_BUS    GENMASK(12, 5)
-#define INDEX_FIELD_SLOT   GENMASK(4, 0)
-
-static unsigned long ice_adapter_index(const struct pci_dev *pdev)
+static unsigned long ice_adapter_index(u64 dsn)
 {
-	unsigned int domain = pci_domain_nr(pdev->bus);
-
-	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
-
-	switch (pdev->device) {
-	case ICE_DEV_ID_E825C_BACKPLANE:
-	case ICE_DEV_ID_E825C_QSFP:
-	case ICE_DEV_ID_E825C_SFP:
-	case ICE_DEV_ID_E825C_SGMII:
-		return FIELD_PREP(INDEX_FIELD_DEV, pdev->device);
-	default:
-		return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
-		       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
-		       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
-	}
+#if BITS_PER_LONG == 64
+	return dsn;
+#else
+	return (u32)dsn ^ u32(dsn >> 32);
+#endif
 }
 
 static struct ice_adapter *ice_adapter_new(void)
@@ -77,25 +60,29 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  * Return:  Pointer to ice_adapter on success.
  *          ERR_PTR() on error. -ENOMEM is the only possible error.
  */
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
-	unsigned long index = ice_adapter_index(pdev);
+	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
+	unsigned long index;
 	int err;
 
+	index = ice_adapter_index(dsn);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
 		if (err == -EBUSY) {
 			adapter = xa_load(&ice_adapters, index);
 			refcount_inc(&adapter->refcount);
+			WARN_ON_ONCE(adapter->device_serial_number != dsn);
 			return adapter;
 		}
 		if (err)
 			return ERR_PTR(err);
 
 		adapter = ice_adapter_new();
 		if (!adapter)
 			return ERR_PTR(-ENOMEM);
+		adapter->device_serial_number = dsn;
 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
 	}
 	return adapter;
@@ -110,11 +97,13 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
  *
  * Context: Process, may sleep.
  */
-void ice_adapter_put(const struct pci_dev *pdev)
+void ice_adapter_put(struct pci_dev *pdev)
 {
-	unsigned long index = ice_adapter_index(pdev);
+	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
+	unsigned long index;
 
+	index = ice_adapter_index(dsn);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		adapter = xa_load(&ice_adapters, index);
 		if (WARN_ON(!adapter))
-- 
2.39.3


