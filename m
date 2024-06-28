Return-Path: <netdev+bounces-107824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCD91C732
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51825287AEE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E486D13D516;
	Fri, 28 Jun 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCeJmbuO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550EF13A868
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605627; cv=none; b=kveyCn943a5ZBLmp+AG5H3jo7WRXB1yCxASL6e4B6mYSnjeKECpRzr8aITQEL+saDpqp2I8hxptm2Wm6yeo1f2nz1nwjiiD9oyRORGEN9MYQTqPEXc2MvXBEYdWQmCxpUNKbcaz8BP/gV+q45HJ52EX63QVRs9WxURMMj80Pypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605627; c=relaxed/simple;
	bh=HXeKVbWfDIPfbkUWpNVYGDzMwcSp6n6eO1Gec6CByjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9oJCktvcPPfBQ3Zuy2+mH6yLZfgquhjHMLGBAnJg7dXgGI9A27Kmsh8szL0LuJGCt+UV0c6rnbqHjlfkQPUGYYkl6Vq9AoEmsmhdHPYkd2iVZknIjH9fqjpMLNmfB1KXBXG1UY5gTGp3m9hrYw7EH8Umk68oZvA5zGAUHDj8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCeJmbuO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605626; x=1751141626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXeKVbWfDIPfbkUWpNVYGDzMwcSp6n6eO1Gec6CByjE=;
  b=DCeJmbuOuwAIvlwzxg0moc835WrXWDOJHO5kefHII8RhgEvVnLF/yWo7
   k2adEkroOsXGWfawiu9vEFMhb8mFKy1qONiQYa8EhwN3WEXcnK9nQyUYX
   b4hN29Ds6pjFu7Rqs2Bto7Tfkz3qja/v3f3UiEQvJlV5A9+RLMU71gYAx
   LYlaKv/FCoHmw2wtQ7nJNM4auPm1ha5OQWi8uQwZVRutSbMFDTVOq+o1m
   /0EM8yPZHs3yusvVL4AtnPu3S4Urn6KqITQmeqFc8kNoccXX+lR5dvXse
   yAWshTpZk5XLWA7WNIOD04bBuSnRDgUR00H64ojqLL8ZimVW/qs28Wvjw
   A==;
X-CSE-ConnectionGUID: YOLenDY7TAqxpqxwUafmOA==
X-CSE-MsgGUID: ayBI9IVYSXeKu54qKMWqjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20674931"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20674931"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:42 -0700
X-CSE-ConnectionGUID: IwvujCFdTd+Kr08PiLuj7w==
X-CSE-MsgGUID: NEgK95v6R8WGocSJF7rMLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49735538"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2024 13:13:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 6/6] ice: do not init struct ice_adapter more times than needed
Date: Fri, 28 Jun 2024 13:13:24 -0700
Message-ID: <20240628201328.2738672-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
References: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

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
and checks if it is already filled, what simplifies code a tiny bit.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
@@ -64,27 +63,26 @@ DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_free(_T))
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
@@ -94,23 +92,21 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
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
-- 
2.41.0


