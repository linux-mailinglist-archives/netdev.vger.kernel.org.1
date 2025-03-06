Return-Path: <netdev+bounces-172611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8576A5586B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531987A2764
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330B207E1C;
	Thu,  6 Mar 2025 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfJ8B+6I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E129CF0
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295535; cv=none; b=lWecQgk3+3VhWPwf+PzqyMNyPtd6jI6TJfPopJtehg5RQ2NrRiIN9MIRHbhMwqgAVd4ntrogJMTdfJa3qYB9puhZ0B7Fn10BidzGVdCWn6oPv3RNtd9T3UNJbO9RtXRWaUg7nzhbRz/ITrF3/e50fF6YHvEMLbkh2QOAGamHgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295535; c=relaxed/simple;
	bh=noFQI/+OKpviQdrTCdYtve+C4IwhM2qGT9hoSqN6Ct4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7TjunAg5ZcJP65mABWaBVhxFItT31Agy/08BG2ANxwhs0prcOqr9PZIlz8LOJsP4TT7CRxbYqOpsUuB5gWj9G063dJttFr7bhA94ERWv0CZiwS2Z84we2gMyYYw1Kd167DKCRkAU0qRbgqd/Zx+HVtTKxE6FNplMOXpCa6n2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfJ8B+6I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741295534; x=1772831534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=noFQI/+OKpviQdrTCdYtve+C4IwhM2qGT9hoSqN6Ct4=;
  b=JfJ8B+6IBVRmluHAASnYgjQ3/DsKc95g3fEhdtd+iAq7bYX35f2djXdq
   MfSkDlbaZnPe+RnoYO3C18Hx2ecpQsWv9ksF1yBas95oySdIL7hwsZNMd
   jzyRlu9tNtSXfxnLI9VrbSLS8VxfZGFqXtXt4bXk8+wVcC3wt0wLmmro0
   KQqcyGHBy4+Ge1w9fn8OGK0k1QtyfS5LjtcF/ISEA1jCs3EL/visdWdac
   H4UTykJP7NGTDK+g560n2cdZZhh8QHytUqmCj7bP5Zi4a3YVUfgBpOSZI
   bum1cbb8eLWQMQBaKx5ZY8pc8NKR0mbaDSOUMdBK057kXtCzCsGFW2u7e
   A==;
X-CSE-ConnectionGUID: BLQeHzWhQDel78ds+iKgAQ==
X-CSE-MsgGUID: fLbvxk99REe+Bj6uMR+gLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42216584"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42216584"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:12:13 -0800
X-CSE-ConnectionGUID: jZSwRtcrRz+PTJPfqc0PVQ==
X-CSE-MsgGUID: Dqu0o1ViRrGZHJXoyU6daA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="149932957"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 06 Mar 2025 13:12:10 -0800
Received: from pkitszel-desk.intel.com (unknown [10.245.246.184])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5845432ED3;
	Thu,  6 Mar 2025 21:12:07 +0000 (GMT)
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
Subject: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter index
Date: Thu,  6 Mar 2025 22:11:46 +0100
Message-ID: <20250306211159.3697-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
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
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 +--
 drivers/net/ethernet/intel/ice/ice_adapter.c | 29 +++-----------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index e233225848b3..1935163bd32f 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -42,7 +42,7 @@ struct ice_adapter {
 	struct ice_port_list ports;
 };
 
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
-void ice_adapter_put(const struct pci_dev *pdev);
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
+void ice_adapter_put(struct pci_dev *pdev);
 
 #endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 01a08cfd0090..b668339ed0ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -14,29 +13,9 @@
 static DEFINE_XARRAY(ice_adapters);
 static DEFINE_MUTEX(ice_adapters_mutex);
 
-/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
-#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
-#define INDEX_FIELD_DEV    GENMASK(31, 16)
-#define INDEX_FIELD_BUS    GENMASK(12, 5)
-#define INDEX_FIELD_SLOT   GENMASK(4, 0)
-
-static unsigned long ice_adapter_index(const struct pci_dev *pdev)
+static unsigned long ice_adapter_index(struct pci_dev *pdev)
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
+	return (unsigned long)pci_get_dsn(pdev);
 }
 
 static struct ice_adapter *ice_adapter_new(void)
@@ -77,7 +56,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  * Return:  Pointer to ice_adapter on success.
  *          ERR_PTR() on error. -ENOMEM is the only possible error.
  */
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
 	unsigned long index = ice_adapter_index(pdev);
 	struct ice_adapter *adapter;
@@ -110,7 +89,7 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
  *
  * Context: Process, may sleep.
  */
-void ice_adapter_put(const struct pci_dev *pdev)
+void ice_adapter_put(struct pci_dev *pdev)
 {
 	unsigned long index = ice_adapter_index(pdev);
 	struct ice_adapter *adapter;
-- 
2.46.0


