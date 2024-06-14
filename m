Return-Path: <netdev+bounces-103494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82EE908529
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FBD1F23AD9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1A1487E7;
	Fri, 14 Jun 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi8JB9XG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45B14659D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350546; cv=none; b=cfpXFI3EGRsKhJnFpEVC3LF1s+fpmn/XLFZjw2MIvmIICtd+9tChKOthSmf/CGlrFwD6ORd4Va3n1bCf3i5eSNxjhQGbmmL2wpGCoFTNQoQLaOaeIHSySVBrfCs+V73YFwMfoE/Je4Fpb7I5+/Qwo6SY8Dn/EbkkEyZJBLP1LhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350546; c=relaxed/simple;
	bh=46XxxCe8F1Msn+SyVgq3IrOxAVsrfBLY5TFBLKDVd+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KxZ+zrGuHw17A8Ogv2Xf9iJBd3PI2IW2DXSsXWBoZPj7nhhbg/q2XTjpc+hmvGW2C+WCCJIN+NbWjgAQ0G1qPM3mwAphIQ+ZvDvMv44GpDcpGXrVVUKO58KIMiHE9FNK9Io3q25xgEhLzVvBsGQP9jR7NxFtOthv9n1wYRLPlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi8JB9XG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718350544; x=1749886544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=46XxxCe8F1Msn+SyVgq3IrOxAVsrfBLY5TFBLKDVd+c=;
  b=bi8JB9XGwPU+WYxSJWtnX5TBKotTLETj/U32HsmjDyUIQjUiDpjgAZ5I
   CmipXkxcdEfMG1K1zxqT9uDMai+WbGbaXPMaVQD7ZtfCHr2C40RuNKCxL
   agD3jmFecgc55VJoeKL4NDrGm0hoNQ8fEZxELC88/nBHcaQqrB5/LvlP2
   /9D0k7l+SwoLUA8S3DhHRmDGUiewqYwDm2fWWCApwcvNVFvu8apPIvqGD
   Kv0on+7Iu3sGhB5O/qUk5bEgsSYZoM0M9jz4/EvpWvQNi6njbcNIiKpLA
   aU8cWSUsZkTJhhSbZiUek2EQmXZ9X0PP1/Inb0OoRnYnER8eR/uP2A35c
   w==;
X-CSE-ConnectionGUID: WP4DmYCOTOeEAZk3SIneuw==
X-CSE-MsgGUID: oH90cMIbSg6PaFROJVmDVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="32702115"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="32702115"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 00:35:43 -0700
X-CSE-ConnectionGUID: t/SqojwETs+9/3Yh+cMpgw==
X-CSE-MsgGUID: 8Y1ItVxyR7W2v63TjBM0Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40558554"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.123.220.50])
  by orviesa009.jf.intel.com with ESMTP; 14 Jun 2024 00:35:42 -0700
From: Karen Ostrowska <karen.ostrowska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Eric Joyner <eric.joyner@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>
Subject: [PATCH iwl-next v2] ice: Check all ice_vsi_rebuild() errors in function
Date: Fri, 14 Jun 2024 09:32:24 +0200
Message-Id: <20240614073224.4399-1-karen.ostrowska@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Joyner <eric.joyner@intel.com>

Check the return value from ice_vsi_rebuild() and prevent the usage of
incorrectly configured VSI.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
---
On v1 there was no goto done line added after ice_vsi_open(vsi).
It's needed to skip printing error message when is on success.

Original patch was introduced as implementation change not because of
fixing something, so I will skip adding here Fixes tag.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 78321616e754..114ecde0757c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4158,13 +4158,17 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
 	/* set for the next time the netdev is started */
 	if (!netif_running(vsi->netdev)) {
-		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		if (err)
+			goto rebuild_err;
 		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
 		goto done;
 	}
 
 	ice_vsi_close(vsi);
-	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	if (err)
+		goto rebuild_err;
 
 	ice_for_each_traffic_class(i) {
 		if (vsi->tc_cfg.ena_tc & BIT(i))
@@ -4175,6 +4179,10 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 	}
 	ice_pf_dcb_recfg(pf, locked);
 	ice_vsi_open(vsi);
+	goto done;
+
+rebuild_err:
+	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
 done:
 	clear_bit(ICE_CFG_BUSY, pf->state);
 	return err;
-- 
2.39.3


