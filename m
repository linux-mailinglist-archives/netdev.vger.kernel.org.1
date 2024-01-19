Return-Path: <netdev+bounces-64417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B92833018
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 22:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C4E1F225A6
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F457882;
	Fri, 19 Jan 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8bzxpQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758755E63
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698732; cv=none; b=G+Lq8xepCbqASFsdwaHQ3tdrNSS/D/19dUOw0VgCuk+5mqm2TpEtJ4kpb6IQA7/aJvNDlR6858p0UIZuwH0lfTcIDY979NwoA7sPqVBNSjFl1EfglC45Bdu1AOVdGVZhUHnU+8qVslhcYGbNYkLxcB/xXt+uIg3M1a9DmbEWlq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698732; c=relaxed/simple;
	bh=VTxLlaqQIdEdyLHXFM3nehEeMzb6CcJh8bBSgGh6Zyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SswQyyto5UZ/rbqySSZch+eUHGypJsPxvYozv1bw8Z2euyQ90YE6WzmFE9IqD9yTiPjMZLNN5aK1gmW7iPIe2ZO/TXLRLWgAmk7vX8GzzxSzmnIxaQvy3nd+cItGgp3xS4YazrYUJ2R1SfchGIWEov79KCiA7hGTgA/4xsE9YWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8bzxpQ3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705698732; x=1737234732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VTxLlaqQIdEdyLHXFM3nehEeMzb6CcJh8bBSgGh6Zyw=;
  b=e8bzxpQ3+X7yjTkpeFQyryJy1bWHDhIxvZpLFgP4ba0rH/HJ29sYmVKZ
   Bbz+y0AC97A++EQtWPm/7XQvmOr6rGcPeeNGq75hqrN61r28wozV41nvZ
   G+0EgelT8LdQ4SJpfCAF/8+MGuaL0NmvNPXyVH7Gs6eWSm/g9nsZ9y6RI
   dA8pGy6Ge7KFCQcMdLdg5WBNeH2N/WjnSPzECOrRAOLBBPIhhmjfLT/oI
   lu7kkju4HzBUSFO/nrBhNE+GaBfMtvNuztmUSgc3owee4uNagyzXNYeDl
   iGzVOBhUls0RSv49983beJfKSOCbQhWk21iBFeX6sdXWobvZBaPF2/OeJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7529335"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="7529335"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 13:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="761230792"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="761230792"
Received: from dmert-dev.jf.intel.com ([10.166.241.14])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 13:12:10 -0800
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: Add check for lport extraction to LAG init
Date: Fri, 19 Jan 2024 13:15:17 -0800
Message-ID: <20240119211517.127142-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To fully support initializing the LAG support code, a DDP package that
extracts the logical port from the metadata is required.  If such a
package is not present, there could be difficulties in supporting some
bond types.

Add a check into the initialization flow that will bypass the new paths
if any of the support pieces are missing.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
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
2.43.0


