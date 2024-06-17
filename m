Return-Path: <netdev+bounces-104062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6290B08E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77E728537E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27316EB74;
	Mon, 17 Jun 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeNG0Ln0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507416DC39
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630721; cv=none; b=NApWakMVrK907faho4140C9oqdWLbehnICmwic/3ncYsXq4BG0aCYQG1S0LSbIStrzcDM3yrFuKvU4ZJRtABqA6zoXgA6/KCzcbu98RmtKLWEd9MreQsrH3unUyhqwt9XRUUrrXBfSL4lU8dtNTo0dZEGxbevTWbNnqEmas41Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630721; c=relaxed/simple;
	bh=XpHPCsRoAdT6X6eunW6DKBI0v60GhrvSCGL4vzbBDvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJLcwTvXs26OH4Ehw02neHi8kKIY/E3Vh5GItEGEkYRwnb5dN3Kt/oUF8jJ0pB/oZndXyT5dRWxRzUlAMuP59F5ujacDyhGzt+bXX+02u+ikd8cjH3bfYG+0Wekiix8q78s35IVq15Y717GqatehN/k+ydLY2XEokHnWlf05Hxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeNG0Ln0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718630720; x=1750166720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XpHPCsRoAdT6X6eunW6DKBI0v60GhrvSCGL4vzbBDvA=;
  b=AeNG0Ln0hpoD/YkhxX/Ud+bryaGFdXhLJyZYsf2F40SP4QANS0Mbabh3
   7/vXTZFRCtg0XCB8Zizz9UM5u7FgFEx9rJBxAP/0F3Io5W/93BXPnCkDK
   Pdq2rhtiQxXk0aQHtCMQ3I/Z0NPoCfydb6qQi+Na7ge4u/ZfTcKG4so6n
   cMiveSQ6NJYHyf4HPaEElt0sXacdSxw/HvIsKJLTeZqFiGwssed3c/VOx
   +82iOTO7z4qA5EkoVfJ7EzYXimhLvN1CtxYdhqh2CXnRu+RvsPqRT2v3D
   qNlfNOm3NKqz6pzV8MCYUr88igqNpy89IknjenEsCEJdA4cKiPK9vR3/P
   w==;
X-CSE-ConnectionGUID: WU7+8INPQmObfxKBipUUgA==
X-CSE-MsgGUID: ofYf+FOxR5eWwUEx3Xcy0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15287103"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15287103"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 06:25:15 -0700
X-CSE-ConnectionGUID: fucocOo7Swu8yBFJeJlzqw==
X-CSE-MsgGUID: 2p5Z51AGRiGmjCT9DgRTzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="46121212"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 17 Jun 2024 06:25:12 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BFB73333DA;
	Mon, 17 Jun 2024 14:25:01 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-next v1] ice: do not init struct ice_adapter more times than needed
Date: Mon, 17 Jun 2024 15:24:07 +0200
Message-Id: <20240617132407.107292-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate and initialize struct ice_adapter object only once per physical
card instead of once per port. This is not a big deal by now, but we want
to extend this struct more and more in the near future. Our plans include
PTP stuff and a devlink instance representing whole-device/physical card.

Transactions requiring to be sleep-able (like those doing user (here ice)
memory allocation) must be performed with an additional (on top of xarray)
mutex. Adding it here removes need to xa_lock() manually.

Since this commit is a reimplementation of ice_adapter_get(), a rather new
scoped_guard() wrapper for locking is used to simplify the logic.

It's worth to mention that xa_insert() use gives us both slot reservation
and checks if it is already filled, what simplifies code a tiny	bit.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c | 60 +++++++++-----------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 52d15ef7f4b1..ad84d8ad49a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -11,6 +11,7 @@
 #include "ice_adapter.h"
 
 static DEFINE_XARRAY(ice_adapters);
+static DEFINE_MUTEX(ice_adapters_mutex);
 
 /* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
 #define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
@@ -47,8 +48,6 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	kfree(adapter);
 }
 
-DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_free(_T))
-
 /**
  * ice_adapter_get - Get a shared ice_adapter structure.
  * @pdev: Pointer to the pci_dev whose driver is getting the ice_adapter.
@@ -64,53 +63,50 @@ DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_free(_T))
  */
 struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
 {
-	struct ice_adapter *ret, __free(ice_adapter_free) *adapter = NULL;
 	unsigned long index = ice_adapter_index(pdev);
-
-	adapter = ice_adapter_new();
-	if (!adapter)
-		return ERR_PTR(-ENOMEM);
-
-	xa_lock(&ice_adapters);
-	ret = __xa_cmpxchg(&ice_adapters, index, NULL, adapter, GFP_KERNEL);
-	if (xa_is_err(ret)) {
-		ret = ERR_PTR(xa_err(ret));
-		goto unlock;
-	}
-	if (ret) {
-		refcount_inc(&ret->refcount);
-		goto unlock;
+	struct ice_adapter *adapter;
+	int err;
+
+	scoped_guard(mutex, &ice_adapters_mutex) {
+		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
+		if (err == -EBUSY) {
+			adapter = xa_load(&ice_adapters, index);
+			refcount_inc(&adapter->refcount);
+			return adapter;
+		}
+		if (err)
+			return ERR_PTR(err);
+
+		adapter = ice_adapter_new();
+		if (!adapter)
+			return ERR_PTR(-ENOMEM);
+		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
 	}
-	ret = no_free_ptr(adapter);
-unlock:
-	xa_unlock(&ice_adapters);
-	return ret;
+	return adapter;
 }
 
 /**
  * ice_adapter_put - Release a reference to the shared ice_adapter structure.
  * @pdev: Pointer to the pci_dev whose driver is releasing the ice_adapter.
  *
  * Releases the reference to ice_adapter previously obtained with
  * ice_adapter_get.
  *
- * Context: Any.
+ * Context: Process, may sleep.
  */
 void ice_adapter_put(const struct pci_dev *pdev)
 {
 	unsigned long index = ice_adapter_index(pdev);
 	struct ice_adapter *adapter;
 
-	xa_lock(&ice_adapters);
-	adapter = xa_load(&ice_adapters, index);
-	if (WARN_ON(!adapter))
-		goto unlock;
+	scoped_guard(mutex, &ice_adapters_mutex) {
+		adapter = xa_load(&ice_adapters, index);
+		if (WARN_ON(!adapter))
+			return;
+		if (!refcount_dec_and_test(&adapter->refcount))
+			return;
 
-	if (!refcount_dec_and_test(&adapter->refcount))
-		goto unlock;
-
-	WARN_ON(__xa_erase(&ice_adapters, index) != adapter);
+		WARN_ON(xa_erase(&ice_adapters, index) != adapter);
+	}
 	ice_adapter_free(adapter);
-unlock:
-	xa_unlock(&ice_adapters);
 }

base-commit: 37cf9b0b18612fcb52a819518074e4a0beabe29a
-- 
2.39.3


