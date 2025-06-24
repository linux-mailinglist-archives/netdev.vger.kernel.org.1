Return-Path: <netdev+bounces-200689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00959AE68CF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152B16A3461
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036228ECE2;
	Tue, 24 Jun 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DteuzqlP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A8227B88
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775255; cv=none; b=huc65ffGTW/knuH/LZuX9mZ4Yo11E43vS9bsE4bZUhHIkTH8iJ5I+eLAt+BZ/LM93PI2vWMsnowmiZo/w3F+3w+pZ92U3OcERTWqJboLbHMMiNq8iMbx9FAQft1wnFlUs0RguuTdel8nXB1iX/FbaMuFUM4ZI8+8aOaZLfhHv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775255; c=relaxed/simple;
	bh=FPxmSS5suGCOzmue056ptlmwSoUwUYjdZafjsoTfq/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AmuP45qfkHtNppudIfrIPgP4qtj41pCGOKKwisISjvKVoNLEVlfbDTTLdY5HqJ6oafbLk/42hwl+MBJQvvmxvkJHFhsnS8rtuNvdxy0y2Wqr30CH8TkvLX9KOi9EO3arjlmVOG0RdJ57ZFNKPncNvpqR5aG0vaPLHqroOngjGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DteuzqlP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750775254; x=1782311254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FPxmSS5suGCOzmue056ptlmwSoUwUYjdZafjsoTfq/8=;
  b=DteuzqlPIPeTXkmZR2TpVVCBd4VVTPW9VUu05fyAhfJ3eD4Wdg7BFs60
   hGcTTKiduDHJph4ScmdNXjyjBMT7uVCQ9ooiUDTooLsqOHKfShVRvK3eY
   J6qLpE/UU/TALAkNPIWdMvgB+CfhtvVndCa/DFkeFwftdhXydbEoYGrs7
   DuyWfVPGgOcFkNfBHiuH+2wIE4oXM3O0I6mJ0ByAOAT/qDkJ5lwlhC3EJ
   A17wOEqjZeeKET1fQnUkY0WHGl8pEPGdQgqdQiYePOMxlEfQWQJ+ssOsO
   FjWmoZQNifUngZU9rmhixN69nY1shu19mn1JkvZL3HDWV0nn2JuZeBfW0
   A==;
X-CSE-ConnectionGUID: hnvUO4SbRaiYIhy1MVTzNQ==
X-CSE-MsgGUID: w2Y6YjzqSJSUTHplRgQMNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70441036"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="70441036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:27:31 -0700
X-CSE-ConnectionGUID: rQUEmtzZR5GX+NxWfmHQvg==
X-CSE-MsgGUID: ePFQhx5/RByH0snyFMXtlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="155965567"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2025 07:27:31 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	david.m.ertman@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-net 1/2] ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
Date: Tue, 24 Jun 2025 07:26:40 -0700
Message-Id: <20250624142641.7010-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20250624142641.7010-1-emil.s.tantilov@intel.com>
References: <20250624142641.7010-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Issuing a reset when the driver is loaded without RDMA support, will
results in a crash as it attempts to remove RDMA's non-existent auxbus
device:
echo 1 > /sys/class/net/<if>/device/reset

BUG: kernel NULL pointer dereference, address: 0000000000000008
...
RIP: 0010:ice_unplug_aux_dev+0x29/0x70 [ice]
...
Call Trace:
<TASK>
ice_prepare_for_reset+0x77/0x260 [ice]
pci_dev_save_and_disable+0x2c/0x70
pci_reset_function+0x88/0x130
reset_store+0x5a/0xa0
kernfs_fop_write_iter+0x15e/0x210
vfs_write+0x273/0x520
ksys_write+0x6b/0xe0
do_syscall_64+0x79/0x3b0
entry_SYSCALL_64_after_hwframe+0x76/0x7e

ice_unplug_aux_dev() checks pf->cdev_info->adev for NULL pointer, but
pf->cdev_info will also be NULL, leading to the deref in the trace above.

Introduce a flag to be set when the creation of the auxbus device is
successful, to avoid multiple NULL pointer checks in ice_unplug_aux_dev().

Fixes: c24a65b6a27c7 ("iidc/ice/irdma: Update IDC to support multiple consumers")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ddd0ad68185b..0ef11b7ab477 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -509,6 +509,7 @@ enum ice_pf_flags {
 	ICE_FLAG_LINK_LENIENT_MODE_ENA,
 	ICE_FLAG_PLUG_AUX_DEV,
 	ICE_FLAG_UNPLUG_AUX_DEV,
+	ICE_FLAG_AUX_DEV_CREATED,
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 6ab53e430f91..420d45c2558b 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -336,6 +336,7 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	mutex_lock(&pf->adev_mutex);
 	cdev->adev = adev;
 	mutex_unlock(&pf->adev_mutex);
+	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
 
 	return 0;
 }
@@ -347,15 +348,16 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 {
 	struct auxiliary_device *adev;
 
+	if (!test_and_clear_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags))
+		return;
+
 	mutex_lock(&pf->adev_mutex);
 	adev = pf->cdev_info->adev;
 	pf->cdev_info->adev = NULL;
 	mutex_unlock(&pf->adev_mutex);
 
-	if (adev) {
-		auxiliary_device_delete(adev);
-		auxiliary_device_uninit(adev);
-	}
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
 }
 
 /**
-- 
2.37.3


