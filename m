Return-Path: <netdev+bounces-83380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C45892178
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FC0B2368C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111A85C43;
	Fri, 29 Mar 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRlk//JC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622118594B
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729069; cv=none; b=rEzJpGDg0Ti/DyBHGSY0fG0fX/V7PTMJyZsgoQigisLYMmJck0ejMR3CjMw/WpLkRiI8BqFGwIqhOqWGnuYfyhcmYWi7bvkqP8ZJIZ+KHNg4DMLIPBkoqbibv117tXfjy4r9U5Ddl9zXZTVljundrKcxSSOOgiLHUu4zbgWnp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729069; c=relaxed/simple;
	bh=ERHAALLSA2vzNMYtvNj4cUg4n40CUGxACTCDlBu/TEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hztPSSaHcmkxxGPej0LDaaoCGHle43f9nH9JpbHJ0ms8LCp01G92J5RFSSw1RhgmRIsBcFGicpZQwbgLmrSa5HtNUPup0ltF1fn+yzD3flzXStpYuWmdc9Gyjsb7MTpS2QBWyKQKkrigu81twhc3j5jdGzRMGG3kGG42BWN7lZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRlk//JC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711729068; x=1743265068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ERHAALLSA2vzNMYtvNj4cUg4n40CUGxACTCDlBu/TEw=;
  b=HRlk//JC4YVzpYdTS4AnocNdGeEUv8xQztzuVnWjzCddOpY1VHiuk2Ke
   GMMeoVgETB/oiaHj+9LAaLcPJzePYCL+XUc0yZ5M2vc3h4pTr2EbwjeY0
   jQUHT5Y4ZM6b24J7TNx/9iXO9vexF/vtaawVksan5aUEmcbgxcJ3Mikrt
   dA/uDdno8uaAlbBAxMnj5ijL9jETz0lfDZ7yQPNaHzLkGQfK9GFPmMXKu
   rsESrrsGp722sdWV32evcDB5GhjtR/L+E+4NM7WaC8zmPJFxf0pWLPY/e
   9Lm7SV/f94DkqBmR5i9De7cBOqMIZjLZfkFW0ZdkhZAli3SkG6x6SNJkx
   Q==;
X-CSE-ConnectionGUID: ghkoUTBCTFyhlwMNGQXShA==
X-CSE-MsgGUID: eciUDsNoT82BLdvIPpdjHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7038341"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7038341"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21474544"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 09:17:46 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 06/12] ice: Introduce ice_get_base_incval() helper
Date: Fri, 29 Mar 2024 17:09:45 +0100
Message-ID: <20240329161730.47777-20-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329161730.47777-14-karol.kolacinski@intel.com>
References: <20240329161730.47777-14-karol.kolacinski@intel.com>
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
index 7980482bbf56..cd2dab7b4c44 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1210,12 +1210,7 @@ static u64 ice_base_incval(struct ice_pf *pf)
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


