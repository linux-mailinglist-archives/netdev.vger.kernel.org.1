Return-Path: <netdev+bounces-90917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF8D8B0B41
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828721C21260
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C515ECDD;
	Wed, 24 Apr 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LydayIx5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A315E811
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965866; cv=none; b=pilZSBVMNjLFt2BmQMe+R8Cwsr2JMFVMpVZa1GBZTxrDJZEZzMVjIL0ja9IIuuUzDyKS+3cbp4aa/XIRNtHSdzWFt0tfNPSt+6dT15VPT5UYYlrWE7KnP05ekJTlaCvtFGP4kX2AX0Yiyv6b+mMTvKZx0Hw+Jl2bRjFlAq1j0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965866; c=relaxed/simple;
	bh=egHb0Lp4OhhNz5u1JZsj1weDZwPvuJiu9KYA5suEfws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAbJmYkXISa3fFVofOX/m/VAZIlbcdNuSI0s/aQxKVdCblceXBZQfROG0PqYWhJOKbf3gnWwo+74LngyUp40BctLLGHVsQeE3rh46KrW05Bq/rzqMLoIRDHA2i1Ld4C0PWWRvmanyBknj2AhT0112PVy/Ojqf/tlsjnXbIuPXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LydayIx5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713965865; x=1745501865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egHb0Lp4OhhNz5u1JZsj1weDZwPvuJiu9KYA5suEfws=;
  b=LydayIx57AKP/PNGsmDuJxWSqOqcIVNneABWDh4pIzKZaf3E60r+HSEJ
   XcUFrDI5tMSVcU7OXZwlp8QBTLGv/lQBsN5ya2cTowd11EdDk8tQcKw78
   hZia0AutzzsFaiiEfd1zKQDLU6gQ7viWmasol+IV8b/AGnCG7TIW9OEso
   bF15QH1hn609W1v2XDj/X6TnQGyPvOJkqi/1y15hp6H2qt47VTp+RTGjQ
   ZWkQgoK5BuepawJKX7nV1p0iagDqRAzDqbp0D8ISiN1MyhAb1aK2whoRx
   p+yekYKbMxcLZULo7GV3EtuR5qiAS3Aq4kZL9GBaCdoo+B9quB4frgsO2
   Q==;
X-CSE-ConnectionGUID: KUNnawc9S7eXYeEpXGAcIw==
X-CSE-MsgGUID: bfkwHAf2QVOvIFP9l6dQXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27110457"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="27110457"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 06:37:44 -0700
X-CSE-ConnectionGUID: sgHTVi/lQoOXoSBwryJtqw==
X-CSE-MsgGUID: LaU4l4ReQAGc7kDa2/IiqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24601097"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa010.jf.intel.com with ESMTP; 24 Apr 2024 06:37:41 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v10 iwl-next 04/12] ice: Add PHY OFFSET_READY register clearing
Date: Wed, 24 Apr 2024 15:30:12 +0200
Message-ID: <20240424133542.113933-19-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424133542.113933-16-karol.kolacinski@intel.com>
References: <20240424133542.113933-16-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a possibility to mark all transmitted/received timestamps as invalid
by clearing PHY OFFSET_READY registers.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 11 ++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 34 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 412555194c97..4ed2213247f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1933,11 +1933,14 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	/* For Vernier mode, we need to recalibrate after new settime
-	 * Start with disabling timestamp block
+	/* For Vernier mode on E82X, we need to recalibrate after new settime.
+	 * Start with marking timestamps as invalid.
 	 */
-	if (pf->ptp.port.link_up)
-		ice_ptp_port_phy_stop(&pf->ptp.port);
+	if (hw->ptp.phy_model == ICE_PHY_E82X) {
+		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Failed to mark timestamps as invalid before settime\n");
+	}
 
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 0a4026c8a3ba..25b3544c4862 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2409,6 +2409,40 @@ int ice_phy_cfg_rx_offset_e82x(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
+/**
+ * ice_ptp_clear_phy_offset_ready_e82x - Clear PHY TX_/RX_OFFSET_READY registers
+ * @hw: pointer to the HW struct
+ *
+ * Clear PHY TX_/RX_OFFSET_READY registers, effectively marking all transmitted
+ * and received timestamps as invalid.
+ *
+ * Return: 0 on success, other error codes when failed to write to PHY
+ */
+int ice_ptp_clear_phy_offset_ready_e82x(struct ice_hw *hw)
+{
+	u8 port;
+
+	for (port = 0; port < hw->ptp.num_lports; port++) {
+		int err;
+
+		err = ice_write_phy_reg_e82x(hw, port, P_REG_TX_OR, 0);
+		if (err) {
+			dev_warn(ice_hw_to_dev(hw),
+				 "Failed to clear PHY TX_OFFSET_READY register\n");
+			return err;
+		}
+
+		err = ice_write_phy_reg_e82x(hw, port, P_REG_RX_OR, 0);
+		if (err) {
+			dev_warn(ice_hw_to_dev(hw),
+				 "Failed to clear PHY RX_OFFSET_READY register\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_read_phy_and_phc_time_e82x - Simultaneously capture PHC and PHY time
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5645b20a9f87..5223e17d2806 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -208,6 +208,7 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time);
 int ice_ptp_write_incval(struct ice_hw *hw, u64 incval);
 int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval);
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj);
+int ice_ptp_clear_phy_offset_ready_e82x(struct ice_hw *hw);
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp);
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx);
 void ice_ptp_reset_ts_memory(struct ice_hw *hw);
-- 
2.43.0


