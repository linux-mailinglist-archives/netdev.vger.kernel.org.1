Return-Path: <netdev+bounces-71501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC28853A09
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C55B24159
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751FD10A3F;
	Tue, 13 Feb 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCHukumi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358510A0A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849623; cv=none; b=t2CDaMwS+gjGwt9B/iEd0hNqircM+y8TEtdzBMlKrsfb2uZww7LHcGiX+PEOxqFEz8iftVwi+Tt64WRAivxXZdYVy5HMZ8A1aE4qsw20i4lTWLX2w67AzKPI+wxeAGWlHr1bw7Xqw/544dLxgUKfhrMR3x7EGJwBuhRcRdMR3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849623; c=relaxed/simple;
	bh=E+AgJMEqm5THmqYKP4EmuVtGkYA3bmx0DLU8MEL5R0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lP1xaCDONf6rkFB0rQgLZAxsrrut2N8KqxXNv3xM9tymk3MnJDw5vEhtjeJJbDQ9iKyP/i5KHSf0bXr8NZPfjiLWi6/ebyJAs1lETwyHNyU6o2yekBQETvIsmMtdspkHifm6/DzQIhwYuFpO9VQhFZgD4DNrkbJKyhtRcwGNpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCHukumi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707849621; x=1739385621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E+AgJMEqm5THmqYKP4EmuVtGkYA3bmx0DLU8MEL5R0Y=;
  b=ZCHukumiVlHvOOI4EKdGkylh7JTOtKl1nZu4BzoY2zZPcFz5QjtuXoMc
   6L1cMFAgGTY3XTTTMQAPvtY8T7/Sryj3+86q2qBjquHRZ7yhXE1GvbCbT
   lI2Etu0+ZXUeQWPd4tX7kmXHtjqYLHGfjBARFIbsy92jey8dmqY0Zrxra
   jV2y0/okoOQq/ZASFl5/F7uSqZJlU1NW+NItxqj1H392LBZQRnJRPucY8
   nzjTOpksKw1Wofl7dmQKwk57Gw90Om7B8VBF/YKWiQ04Blv8AZOXv+BDz
   aTEcWfqhroyccdCpzUR+CoHCnAZS5E1Nmx+ZLq8EQGmSMK56Pgxc9IVyA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24344792"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="24344792"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:40:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3144653"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 13 Feb 2024 10:40:11 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net] ice: Add check for lport extraction to LAG init
Date: Tue, 13 Feb 2024 10:39:55 -0800
Message-ID: <20240213183957.1483857-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

To fully support initializing the LAG support code, a DDP package that
extracts the logical port from the metadata is required.  If such a
package is not present, there could be difficulties in supporting some
bond types.

Add a check into the initialization flow that will bypass the new paths
if any of the support pieces are missing.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 25 ++++++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_lag.h |  3 +++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 2a25323105e5..467372d541d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -151,6 +151,27 @@ ice_lag_find_hw_by_lport(struct ice_lag *lag, u8 lport)
 	return NULL;
 }
 
+/**
+ * ice_pkg_has_lport_extract - check if lport extraction supported
+ * @hw: HW struct
+ */
+static bool ice_pkg_has_lport_extract(struct ice_hw *hw)
+{
+	int i;
+
+	for (i = 0; i < hw->blk[ICE_BLK_SW].es.count; i++) {
+		u16 offset;
+		u8 fv_prot;
+
+		ice_find_prot_off(hw, ICE_BLK_SW, ICE_SW_DEFAULT_PROFILE, i,
+				  &fv_prot, &offset);
+		if (fv_prot == ICE_FV_PROT_MDID &&
+		    offset == ICE_LP_EXT_BUF_OFFSET)
+			return true;
+	}
+	return false;
+}
+
 /**
  * ice_lag_find_primary - returns pointer to primary interfaces lag struct
  * @lag: local interfaces lag struct
@@ -1206,7 +1227,7 @@ static void ice_lag_del_prune_list(struct ice_lag *lag, struct ice_pf *event_pf)
 }
 
 /**
- * ice_lag_init_feature_support_flag - Check for NVM support for LAG
+ * ice_lag_init_feature_support_flag - Check for package and NVM support for LAG
  * @pf: PF struct
  */
 static void ice_lag_init_feature_support_flag(struct ice_pf *pf)
@@ -1219,7 +1240,7 @@ static void ice_lag_init_feature_support_flag(struct ice_pf *pf)
 	else
 		ice_clear_feature_support(pf, ICE_F_ROCE_LAG);
 
-	if (caps->sriov_lag)
+	if (caps->sriov_lag && ice_pkg_has_lport_extract(&pf->hw))
 		ice_set_feature_support(pf, ICE_F_SRIOV_LAG);
 	else
 		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index ede833dfa658..183b38792ef2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -17,6 +17,9 @@ enum ice_lag_role {
 #define ICE_LAG_INVALID_PORT 0xFF
 
 #define ICE_LAG_RESET_RETRIES		5
+#define ICE_SW_DEFAULT_PROFILE		0
+#define ICE_FV_PROT_MDID		255
+#define ICE_LP_EXT_BUF_OFFSET		32
 
 struct ice_pf;
 struct ice_vf;
-- 
2.41.0


