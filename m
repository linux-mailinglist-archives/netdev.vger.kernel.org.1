Return-Path: <netdev+bounces-163412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0432A2A362
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE0916631E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637B022578D;
	Thu,  6 Feb 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmhYfCKf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2722578B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831231; cv=none; b=HsdlQ1uWnYODkCw/O0G40e1wQzvvFxANK0ThVngQhG8hr5dwsUPeqAHslfY+u2sTwJm6FUZxVyo1Q0TohwIufDPCzBKdinJyzJQJZ/NeXxvAb553AbSPuj5NbdD0E8+BTisvKMtBHhZgDBOqg0m+DoHgzWbbuK1+RWqUKSFEYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831231; c=relaxed/simple;
	bh=k1Ti7SgA70qAbXdLeZYBjcInqT9fi/BmVWI2W8IES6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LvvSEaR+J1s4daCkqaT6BrZ3Pnzk+/i2pGUj7TpVmoDzyYuf+Hj0D+PGzB7pS8JccoDaoiRhjPInLozmwVTd4bw9p9hfE23SDeAzKX9cORtyi7e2y8neL6LdT3j2jb8a4ZR+nJR5/8xZstJBdAKU/WtHA/1kCU4tFVH4vv2T0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmhYfCKf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738831229; x=1770367229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1Ti7SgA70qAbXdLeZYBjcInqT9fi/BmVWI2W8IES6c=;
  b=dmhYfCKf5kkYlOjcg4TtM5ApcMv7I+vGyFcwEUIPwD4/90OXYGSbHl3M
   KfjkGXwFqdymjEleeDBtPjd2jakbG/aZjSkjSNvfzY5uZhTm6Hf0qInRW
   sw2bYfmO4WTa2XGlQOi7A4RxXt99qKWbobonTZCd8GSX0UHJ7R2bA+4Sn
   KLXjlHc9sadT6Kk87pxXOHru7RLNInkFt22emGehywqCl+lSJAs7zHdXr
   w2UcDBpSdFHkHZzlyr4OK3I9Zk/pq1yPkh3+LFFnNnLXhCmS8UhgBbYh+
   Etc1KTWH/HL75dXmSin8Cg8yUPJjY9/HDpN2/BmLdcG1OwKGnSOaBwrYM
   w==;
X-CSE-ConnectionGUID: bNSXOfcsRcK3LAPk1I+a3w==
X-CSE-MsgGUID: eVXFjAjbSTqix0fKUmttQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49667822"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49667822"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 00:40:29 -0800
X-CSE-ConnectionGUID: YKJysrYgQTCoAZUtI26INw==
X-CSE-MsgGUID: 07vMuCMeSJKAAIWU21kd7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="110979378"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by fmviesa006.fm.intel.com with ESMTP; 06 Feb 2025 00:40:27 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 1/3] ice: Add sync delay for E825C
Date: Thu,  6 Feb 2025 09:36:53 +0100
Message-Id: <20250206083655.3005151-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
References: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Implement setting GLTSYN_SYNC_DLAY for E825C products.
This is the execution delay compensation of SYNC command between
PHC and PHY.
Also, refactor the code by changing ice_ptp_init_phc_eth56g function
name to ice_ptp_init_phc_e825, to be consistent with the naming pattern
for other devices.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 14 +++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3e824f7b30c0..c3dea6d61de4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2650,18 +2650,18 @@ static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
 }
 
 /**
- * ice_ptp_init_phc_eth56g - Perform E82X specific PHC initialization
+ * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
  * @hw: pointer to HW struct
  *
- * Perform PHC initialization steps specific to E82X devices.
+ * Perform E825-specific PTP hardware clock initialization steps.
  *
- * Return:
- * * %0     - success
- * * %other - failed to initialize CGU
+ * Return: 0 on success, negative error code otherwise.
  */
-static int ice_ptp_init_phc_eth56g(struct ice_hw *hw)
+static int ice_ptp_init_phc_e825(struct ice_hw *hw)
 {
 	ice_sb_access_ena_eth56g(hw, true);
+	ice_ptp_cfg_sync_delay(hw, ICE_E825_SYNC_DELAY);
+
 	/* Initialize the Clock Generation Unit */
 	return ice_init_cgu_e82x(hw);
 }
@@ -6123,7 +6123,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
-		return ice_ptp_init_phc_eth56g(hw);
+		return ice_ptp_init_phc_e825(hw);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 8442d1d60351..10295fa9a383 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -324,7 +324,10 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
  */
 #define ICE_E810_PLL_FREQ		812500000
 #define ICE_PTP_NOMINAL_INCVAL_E810	0x13b13b13bULL
+
+/* PHC to PHY synchronization delay definitions */
 #define ICE_E810_E830_SYNC_DELAY	0
+#define ICE_E825_SYNC_DELAY		6
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
-- 
2.39.3


