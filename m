Return-Path: <netdev+bounces-106025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC62F914410
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B5B1F22B0B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE447F5F;
	Mon, 24 Jun 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlLIp4V+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C549620
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215978; cv=none; b=tIjV68VHRJKD6l9up2Hvnt6PXGVOd+89vsqBOMd42ty8OIrZtN3MbUDTLlyILesEaHrjQ916P+VMayug1FZidXWmj3q4JYSVTqDUFI1NP+mkySslxo/HpLQaSl+2bvPP23SgyrfE0VWGCt2u+S2AM/jBLGccTCePMPGGeLyvGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215978; c=relaxed/simple;
	bh=NPzN9Uq5rPl0alRRzp0xYujnv5op3AGREsoiuba2g3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0vxoH4trZ+zd+YxkZTPgPiXKdnyZLUSIyWtDV3GzCiKRvjngGCyI3xTD6i1OvtBJMVQW7OSFhHaLk8IGrqiAV2CZGJvFqGoUooloSqWiccJ8oo0SF3ah8pJDaXzn6SCqraLklWek+5pg4TF4L+kGzhJ0alIxX/d+aC+dN0amWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlLIp4V+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719215977; x=1750751977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NPzN9Uq5rPl0alRRzp0xYujnv5op3AGREsoiuba2g3E=;
  b=mlLIp4V+DOpgBhJZx1HnueyY79QNy/iVOERZPn7Pe1go8YLGkibuwBK3
   hW6DOJo+AH9askPDUGo+CllDO9ApI2jZdU7nujmTq8o6d1QBZRZZuJjRj
   p05RpnJrn/EivSsaA0440FkFghxlgb2K8cW6i6QboE+ssOFnZV5vCT082
   7zN01/6n8jYoU+9dBVRswcituUnLQP04+6PyAaakiUbVTx3NIpRZ00J9i
   HEW6tE7JqOEC/+vaRItlw4FQwMTezzz3CGsT+4CuIZvs+Yk1NRKM5Ke6E
   egFx3crpYMKJhLU7B7e6jVFek/vZ2HKSiMGbfAk3M3SSFyQfJgnKdOOPa
   w==;
X-CSE-ConnectionGUID: BKeXnXHqTZat+AxVs9pfKQ==
X-CSE-MsgGUID: WXSFrproSzquQ4n+7SGVQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16304326"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16304326"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:59:36 -0700
X-CSE-ConnectionGUID: 5Pq8rWL1RP2s5KO6Lw7Kow==
X-CSE-MsgGUID: K/rcWNEWSo+/TmKxYzznuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43662741"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa006.jf.intel.com with ESMTP; 24 Jun 2024 00:59:34 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Wojciech.Drewek@intel.com
Subject: [iwl-next v1] ice: remove eswitch rebuild
Date: Mon, 24 Jun 2024 10:05:10 +0200
Message-ID: <20240624080510.19479-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the port representors are added one by one there is no need to do
eswitch rebuild. Each port representor is detached and attached in VF
reset path.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 16 ----------------
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  6 ------
 drivers/net/ethernet/intel/ice/ice_main.c    |  2 --
 3 files changed, 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index d8c06147d4d4..c0b3e70a7ea3 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -607,22 +607,6 @@ void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
 	ice_eswitch_detach(pf, repr);
 }
 
-/**
- * ice_eswitch_rebuild - rebuild eswitch
- * @pf: pointer to PF structure
- */
-void ice_eswitch_rebuild(struct ice_pf *pf)
-{
-	struct ice_repr *repr;
-	unsigned long id;
-
-	if (!ice_is_switchdev_running(pf))
-		return;
-
-	xa_for_each(&pf->eswitch.reprs, id, repr)
-		ice_eswitch_detach(pf, repr);
-}
-
 /**
  * ice_eswitch_get_target - get netdev based on src_vsi from descriptor
  * @rx_ring: ring used to receive the packet
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 20f301093b36..20ce32dda69c 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -12,7 +12,6 @@ void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf);
 void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
 int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf);
 int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
-void ice_eswitch_rebuild(struct ice_pf *pf);
 
 int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode);
 int
@@ -66,11 +65,6 @@ static inline int ice_eswitch_configure(struct ice_pf *pf)
 	return 0;
 }
 
-static inline int ice_eswitch_rebuild(struct ice_pf *pf)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 {
 	return DEVLINK_ESWITCH_MODE_LEGACY;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f38a30775a2e..14b61ed34dbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7699,8 +7699,6 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_vsi_rebuild;
 	}
 
-	ice_eswitch_rebuild(pf);
-
 	if (reset_type == ICE_RESET_PFR) {
 		err = ice_rebuild_channels(pf);
 		if (err) {
-- 
2.42.0


