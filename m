Return-Path: <netdev+bounces-216673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE7B34E6A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243203BD2EF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A312BD01A;
	Mon, 25 Aug 2025 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pf5FztqX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86129C325
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158629; cv=none; b=t4iCspdnPbWpL+nsOXRsjJL5JUwRYOzTP8lI6dqp4Z2IAun0NWxEL6VGTO0ErKy0JHZsTBVFAyKhUz7XFpep5ZtJM4kmY4o6tBrrzfx5ra9gpt3h7vlZ8p1ns8TYDAedi/wxzVqJZQIgnADTzJ1hdboCDb/QaiT0yaibs0YhaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158629; c=relaxed/simple;
	bh=dyp3cs8UAhpAVMm6SycCjQWepP2x2USeG1bdOlKMNpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0ai29xFpzTEKAMmOnkIVE9WBS1rTnS1Jju0eQo8nD54NCW5inwMQybQ8MaHovSgL4HW4YwTy6nFbtg/ZYBUTvUIuKI3A3E4M0veL4h2QnsVUIXrDCX8C39IznrTjCpewiQGS4Hd8bniujEeACdrYbMi0SNnBAHymGurQSrhtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pf5FztqX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158628; x=1787694628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyp3cs8UAhpAVMm6SycCjQWepP2x2USeG1bdOlKMNpk=;
  b=Pf5FztqXu/n+EUwoWzwvHfH/CMWDSCYpOLWl61k18gpAL4XpKinNNY3E
   +smM9fNhLXZozy17gFS0dxnYpBils8zgXrgrOIHoIt5hZrhF+qN4xEf6J
   dVWSNjSDwX5DQ2Rn3boBYY4SVIpdCLFwSG87rAGuKRZ43Xr0Ak/JldBTE
   Fj/JNHRTA8hFwYzwyMQhQ50qpaxz8C+EJKuWp2b39i8G/AIE80ZWJbG5Y
   OpOYqrVFDSua2GOJu3+vDt1vXrznXxuSShgNj/ZnhqCAzQTL7PP2odhUo
   POBm//OtkDSBT/K6jG/w1fiEHitceASiucL5CU5F0Z+4s2QHf2w4ogbMO
   Q==;
X-CSE-ConnectionGUID: 1IIl9xKHQqq1Ii9b9XoLSQ==
X-CSE-MsgGUID: 5NzzOsluSRWtOsP1eZ6clg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68651375"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68651375"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:50:26 -0700
X-CSE-ConnectionGUID: +9ez6sEcSKuAW/RYNGV7CA==
X-CSE-MsgGUID: F5/ql49PQXObKf742+ANnQ==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 14:50:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	sergey.temerkhanov@intel.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/5] ice: use fixed adapter index for E825C embedded devices
Date: Mon, 25 Aug 2025 14:50:14 -0700
Message-ID: <20250825215019.3442873-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
References: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_adapter structure is used by the ice driver to connect multiple
physical functions of a device in software. It was introduced by
commit 0e2bddf9e5f9 ("ice: add ice_adapter for shared data across PFs on
the same NIC") and is primarily used for PTP support, as well as for
handling certain cross-PF synchronization.

The original design of ice_adapter used PCI address information to
determine which devices should be connected. This was extended to support
E825C devices by commit fdb7f54700b1 ("ice: Initial support for E825C
hardware in ice_adapter"), which used the device ID for E825C devices
instead of the PCI address.

Later, commit 0093cb194a75 ("ice: use DSN instead of PCI BDF for
ice_adapter index") replaced the use of Bus/Device/Function addressing with
use of the device serial number.

E825C devices may appear in "Dual NAC" configuration which has multiple
physical devices tied to the same clock source and which need to use the
same ice_adapter. Unfortunately, each "NAC" has its own NVM which has its
own unique Device Serial Number. Thus, use of the DSN for connecting
ice_adapter does not work properly. It "worked" in the pre-production
systems because the DSN was not initialized on the test NVMs and all the
NACs had the same zero'd serial number.

Since we cannot rely on the DSN, lets fall back to the logic in the
original E825C support which used the device ID. This is safe for E825C
only because of the embedded nature of the device. It isn't a discreet
adapter that can be plugged into an arbitrary system. All E825C devices on
a given system are connected to the same clock source and need to be
configured through the same PTP clock.

To make this separation clear, reserve bit 63 of the 64-bit index values as
a "fixed index" indicator. Always clear this bit when using the device
serial number as an index.

For E825C, use a fixed value defined as the 0x579C E825C backplane device
ID bitwise ORed with the fixed index indicator. This is slightly different
than the original logic of just using the device ID directly. Doing so
prevents a potential issue with systems where only one of the NACs is
connected with an external PHY over SGMII. In that case, one NAC would
have the E825C_SGMII device ID, but the other would not.

Separate the determination of the full 64-bit index from the 32-bit
reduction logic. Provide both ice_adapter_index() and a wrapping
ice_adapter_xa_index() which handles reducing the index to a long on 32-bit
systems. As before, cache the full index value in the adapter structure to
warn about collisions.

This fixes issues with E825C not initializing PTP on both NACs, due to
failure to connect the appropriate devices to the same ice_adapter.

Fixes: 0093cb194a75 ("ice: use DSN instead of PCI BDF for ice_adapter index")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
It turns out that using the device serial number does not work for E825C
boards. I spoke with the team involved in the NVM image generation, and its
not feasible at this point to change the process for generating the NVMs
for E825C. We're stuck with the case that E825C Dual-NAC boards will have
independent DSN for each NAC.

As far as I can tell, the only suitable fallback is to rely on the embedded
nature of the E825C device. We know that all current systems with E825C
need to have their ice_adapter connected. There are no plans to build
platforms with multiple E825C devices. The E825C variant is not a discreet
board, so customers can't simply plug an extra in. Thus, this change
reverts back to using the device ID for E825C systems, instead of the
serial number.

 drivers/net/ethernet/intel/ice/ice_adapter.c | 49 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 +-
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 9e4adc43e474..b53561c34708 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -13,16 +13,45 @@
 static DEFINE_XARRAY(ice_adapters);
 static DEFINE_MUTEX(ice_adapters_mutex);
 
-static unsigned long ice_adapter_index(u64 dsn)
+#define ICE_ADAPTER_FIXED_INDEX	BIT_ULL(63)
+
+#define ICE_ADAPTER_INDEX_E825C	\
+	(ICE_DEV_ID_E825C_BACKPLANE | ICE_ADAPTER_FIXED_INDEX)
+
+static u64 ice_adapter_index(struct pci_dev *pdev)
 {
+	switch (pdev->device) {
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		/* E825C devices have multiple NACs which are connected to the
+		 * same clock source, and which must share the same
+		 * ice_adapter structure. We can't use the serial number since
+		 * each NAC has its own NVM generated with its own unique
+		 * Device Serial Number. Instead, rely on the embedded nature
+		 * of the E825C devices, and use a fixed index. This relies on
+		 * the fact that all E825C physical functions in a given
+		 * system are part of the same overall device.
+		 */
+		return ICE_ADAPTER_INDEX_E825C;
+	default:
+		return pci_get_dsn(pdev) & ~ICE_ADAPTER_FIXED_INDEX;
+	}
+}
+
+static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+{
+	u64 index = ice_adapter_index(pdev);
+
 #if BITS_PER_LONG == 64
-	return dsn;
+	return index;
 #else
-	return (u32)dsn ^ (u32)(dsn >> 32);
+	return (u32)index ^ (u32)(index >> 32);
 #endif
 }
 
-static struct ice_adapter *ice_adapter_new(u64 dsn)
+static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
 
@@ -30,7 +59,7 @@ static struct ice_adapter *ice_adapter_new(u64 dsn)
 	if (!adapter)
 		return NULL;
 
-	adapter->device_serial_number = dsn;
+	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
 	refcount_set(&adapter->refcount, 1);
@@ -64,24 +93,23 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  */
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
-	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
 	unsigned long index;
 	int err;
 
-	index = ice_adapter_index(dsn);
+	index = ice_adapter_xa_index(pdev);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
 		if (err == -EBUSY) {
 			adapter = xa_load(&ice_adapters, index);
 			refcount_inc(&adapter->refcount);
-			WARN_ON_ONCE(adapter->device_serial_number != dsn);
+			WARN_ON_ONCE(adapter->index != ice_adapter_index(pdev));
 			return adapter;
 		}
 		if (err)
 			return ERR_PTR(err);
 
-		adapter = ice_adapter_new(dsn);
+		adapter = ice_adapter_new(pdev);
 		if (!adapter)
 			return ERR_PTR(-ENOMEM);
 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
@@ -100,11 +128,10 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
  */
 void ice_adapter_put(struct pci_dev *pdev)
 {
-	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
 	unsigned long index;
 
-	index = ice_adapter_index(dsn);
+	index = ice_adapter_xa_index(pdev);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		adapter = xa_load(&ice_adapters, index);
 		if (WARN_ON(!adapter))
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index db66d03c9f96..e95266c7f20b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -33,7 +33,7 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
- * @device_serial_number: DSN cached for collision detection on 32bit systems
+ * @index: 64-bit index cached for collision detection on 32bit systems
  */
 struct ice_adapter {
 	refcount_t refcount;
@@ -44,7 +44,7 @@ struct ice_adapter {
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
-	u64 device_serial_number;
+	u64 index;
 };
 
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
-- 
2.47.1


