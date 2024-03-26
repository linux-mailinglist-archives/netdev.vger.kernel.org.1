Return-Path: <netdev+bounces-82175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B445B88C90D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B801C645BD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF113D243;
	Tue, 26 Mar 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIH+fFY1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83913C9DD
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470255; cv=none; b=e5AhwbyMRadf70okgpMO6MLqdvXuNMeUXAtD+NjHKtiauf0rN1nJG/5H7bDNTOAjixogPN8hDgrU7UZP81Boy2ZSo1KusrZwyqe3RjtSV9EcsvYVYuPkuWu5rDy9l7u8rLASOugpKku5LE6vWEwSnwbBwPs36RXS0D86akDdALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470255; c=relaxed/simple;
	bh=yr5zOTqCUcLgqRbdJNu5E7bEj/Raluc6r3n+6K8txno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPKk1PamWfhjsxNGqnAQ/fWnaJbVdj7yvX5PWYyAoJBSDhFgXtuUq/sSASSTMBqkZdpSLETc4hfHEJ6vitr6G5OmdWpIeYwOTe/nn7tgo4Xqka5OsyzzjwRKvO8nz0L+p623L70fAzrYc8fR6Avb0lkVZoDR4tyTJTXD8ZKuFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIH+fFY1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470253; x=1743006253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yr5zOTqCUcLgqRbdJNu5E7bEj/Raluc6r3n+6K8txno=;
  b=fIH+fFY1+rOgmqQLkGmhFHG/o10ylKlc9IfEzxa8Dt+Rm6EH86lddDUi
   RGlrt5E0EIoBELEO9RBL/nXIao6xgmzGo+1v6kmbTtqRr4sN3N7bkCFZA
   iBo2Iixy0YvIlIv3wef04SPt6G0K6NVSPiwL/SMDEe4cxcdOSUnmj9Bri
   2aJ/kYXu1PgzZt2iQdmk2SoIAa7j79CFs7sVmtWUriNBKtKwtTXDDfqGW
   kyAFa1FNYf9g+hvIJjpUKhlyUgmnSEBYMIjP/ear6emlCc89EJUIt9KNP
   WVDO4sxMOhFGAvv895NUMdGdZ0tbP1F1fZMAqn4Eu59HUz2x1oVIsVNCl
   w==;
X-CSE-ConnectionGUID: R8KDTzhsQMGVU4Pgp6Ud7g==
X-CSE-MsgGUID: 4qt7XX9oRbCxdn/+ih0aEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6725033"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6725033"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20729287"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 09:24:11 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 06/12] ice: Introduce ice_get_base_incval() helper
Date: Tue, 26 Mar 2024 17:22:27 +0100
Message-ID: <20240326162339.146053-20-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326162339.146053-14-karol.kolacinski@intel.com>
References: <20240326162339.146053-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add a new helper for getting base clock increment value for specific HW.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  7 +------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 6c74881e302c..b6379875a894 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1229,12 +1229,7 @@ static u64 ice_base_incval(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	u64 incval;
 
-	if (ice_is_e810(hw))
-		incval = ICE_PTP_NOMINAL_INCVAL_E810;
-	else if (ice_e82x_time_ref(hw) < NUM_ICE_TIME_REF_FREQ)
-		incval = ice_e82x_nominal_incval(ice_e82x_time_ref(hw));
-	else
-		incval = UNKNOWN_INCVAL_E82X;
+	incval = ice_get_base_incval(hw);
 
 	dev_dbg(ice_pf_to_dev(pf), "PTP: using base increment value of 0x%016llx\n",
 		incval);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5223e17d2806..d477d334b1d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -285,6 +285,18 @@ int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num);
 int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 				      unsigned long *caps);
 
+static inline u64 ice_get_base_incval(struct ice_hw *hw)
+{
+	switch (hw->ptp.phy_model) {
+	case ICE_PHY_E810:
+		return ICE_PTP_NOMINAL_INCVAL_E810;
+	case ICE_PHY_E82X:
+		return ice_e82x_nominal_incval(ice_e82x_time_ref(hw));
+	default:
+		return 0;
+	}
+}
+
 #define PFTSYN_SEM_BYTES	4
 
 #define ICE_PTP_CLOCK_INDEX_0	0x00
-- 
2.43.0


