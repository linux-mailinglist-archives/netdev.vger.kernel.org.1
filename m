Return-Path: <netdev+bounces-150562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A239EAA8F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD6C166633
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85A230D06;
	Tue, 10 Dec 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oz36wvnl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9662309BB
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819109; cv=none; b=d6mB7Wn6MFwHlxtsNBAlYKT+08tsj/ecy5djTuPFYsrihBsOxBVmC0s46yE9xwI+laZQHZA032TYSNxSnGY7vMi+NmP2YRQ0AHRBDG0cAMWQ/40r9iDxTp10zi+Vzo8CSJVYw/d6uMWCPZcbPya8px63drloSD7UX8nz76ptHmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819109; c=relaxed/simple;
	bh=BbFbKg0MvfgVUHaNIMbT4YTWT40ccYSl2sq+E8ATdUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bv8HZtAcbQUp7uvk+E6FvsICvLrMNqdqDGgPPwCRa0B8YVkvg/22YWNiCq7qIMqqnw7/DsSDp1xUpq9+Qu7EQpUN8uMiM2LyfpbdR7EWnfNcxuwHzV+Nk+R0nj1R9ap82+8JAqw6uGCH+QQl5uv3FAmCooO+v8tWod85KThguoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oz36wvnl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733819107; x=1765355107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BbFbKg0MvfgVUHaNIMbT4YTWT40ccYSl2sq+E8ATdUo=;
  b=Oz36wvnlP3Hc1zMdP3OaiDzLF6h/rqux9KWM8Gq1Xj1tv29ySk2K+6Ov
   peTBCCkN3EES4VKf2gqTVNRmv8xLUvvuBIsn+zoOHAoiaE+WCOcVJ+2yT
   Tp7YFiJWXwpROEKNYIbez24VeZb6kq7eGjvq++s1+YY/crOFQE7HrF11Z
   /mqJAZQiGg1mwbEnQjMRZ8JGiqqoEcp1/eLrwSG7jdSEzfI+dwSw7OFYA
   MZq6aN3+Uax7DCFfrdGDg7XIacMi9OnCAbCCcNKRRG9GKsPPNxxbUC/87
   bztv/waas3Y+yBTaKcj5/0qlbes8r8D3qOKr20Oo4BbrGRfpkLriXcIMZ
   A==;
X-CSE-ConnectionGUID: 9qG1eo2RSuCIt44+HW1WAA==
X-CSE-MsgGUID: p3t9g6YnTjK88MyPz168jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34398251"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="34398251"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 00:25:07 -0800
X-CSE-ConnectionGUID: 9PLo6fckRmCsgyeRCJVamg==
X-CSE-MsgGUID: EOixelfWRL+Rb7qzzPcQYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="99398134"
Received: from host61.igk.intel.com ([10.123.220.61])
  by fmviesa003.fm.intel.com with ESMTP; 10 Dec 2024 00:25:05 -0800
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next v2 2/5] ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
Date: Tue, 10 Dec 2024 09:22:06 -0500
Message-ID: <20241210142333.320515-3-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241210142333.320515-1-anton.nadezhdin@intel.com>
References: <20241210142333.320515-1-anton.nadezhdin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The TS_LL_READ macros are used as part of the low latency Tx timestamp
interface. A future firmware extension will add support for performing PHY
timer updates over this interface. Using TS_LL_READ as the prefix for these
macros will be confusing once the interface is used for other purposes.

Rename the macros, using the prefix REG_LL_PROXY_H, to better clarify that
this is for the low latency interface.
Additionally add macroses for PF_SB_ATQBAH and PF_SB_ATQBAL registers to
better clarify content of this registers as PF_SB_ATQBAH contain low
part of Tx timestamp

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 14 +++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 14 +++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 13 ++++++++-----
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d8ed4240f225..3c81d98883c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -499,9 +499,9 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
 	ice_trace(tx_tstamp_fw_req, tx->tstamps[idx].skb, idx);
 
 	/* Write TS index to read to the PF register so the FW can read it */
-	wr32(&pf->hw, PF_SB_ATQBAL,
-	     TS_LL_READ_TS_INTR | FIELD_PREP(TS_LL_READ_TS_IDX, idx) |
-	     TS_LL_READ_TS);
+	wr32(&pf->hw, REG_LL_PROXY_H,
+	     REG_LL_PROXY_H_TS_INTR_ENA | FIELD_PREP(REG_LL_PROXY_H_TS_IDX, idx) |
+	     REG_LL_PROXY_H_EXEC);
 	tx->last_ll_ts_idx_read = idx;
 }
 
@@ -528,20 +528,20 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 
 	ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
 
-	val = rd32(&pf->hw, PF_SB_ATQBAL);
+	val = rd32(&pf->hw, REG_LL_PROXY_H);
 
 	/* When the bit is cleared, the TS is ready in the register */
-	if (val & TS_LL_READ_TS) {
+	if (val & REG_LL_PROXY_H_EXEC) {
 		dev_err(ice_pf_to_dev(pf), "Failed to get the Tx tstamp - FW not ready");
 		return;
 	}
 
 	/* High 8 bit value of the TS is on the bits 16:23 */
-	raw_tstamp = FIELD_GET(TS_LL_READ_TS_HIGH, val);
+	raw_tstamp = FIELD_GET(REG_LL_PROXY_H_TS_HIGH, val);
 	raw_tstamp <<= 32;
 
 	/* Read the low 32 bit value */
-	raw_tstamp |= (u64)rd32(&pf->hw, PF_SB_ATQBAH);
+	raw_tstamp |= (u64)rd32(&pf->hw, REG_LL_PROXY_L);
 
 	/* Devices using this interface always verify the timestamp differs
 	 * relative to the last cached timestamp value.
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8e11a97601fe..136213aed47c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4871,23 +4871,23 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 	int err;
 
 	/* Write TS index to read to the PF register so the FW can read it */
-	val = FIELD_PREP(TS_LL_READ_TS_IDX, idx) | TS_LL_READ_TS;
-	wr32(hw, PF_SB_ATQBAL, val);
+	val = FIELD_PREP(REG_LL_PROXY_H_TS_IDX, idx) | REG_LL_PROXY_H_EXEC;
+	wr32(hw, REG_LL_PROXY_H, val);
 
 	/* Read the register repeatedly until the FW provides us the TS */
-	err = rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
-				       !FIELD_GET(TS_LL_READ_TS, val),
-				       10, TS_LL_READ_TIMEOUT);
+	err = rd32_poll_timeout_atomic(hw, REG_LL_PROXY_H, val,
+				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
+				       10, REG_LL_PROXY_H_TIMEOUT_US);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
 		return err;
 	}
 
 	/* High 8 bit value of the TS is on the bits 16:23 */
-	*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
+	*hi = FIELD_GET(REG_LL_PROXY_H_TS_HIGH, val);
 
 	/* Read the low 32 bit value and set the TS valid bit */
-	*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
+	*lo = rd32(hw, REG_LL_PROXY_L) | TS_VALID;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 4c059e2f4d96..71097eb67d54 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -694,11 +694,14 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define BYTES_PER_IDX_ADDR_L		4
 
 /* Tx timestamp low latency read definitions */
-#define TS_LL_READ_TIMEOUT		2000
-#define TS_LL_READ_TS_HIGH		GENMASK(23, 16)
-#define TS_LL_READ_TS_IDX		GENMASK(29, 24)
-#define TS_LL_READ_TS_INTR		BIT(30)
-#define TS_LL_READ_TS			BIT(31)
+#define REG_LL_PROXY_H_TIMEOUT_US	2000
+#define REG_LL_PROXY_H_TS_HIGH		GENMASK(23, 16)
+#define REG_LL_PROXY_H_TS_IDX		GENMASK(29, 24)
+#define REG_LL_PROXY_H_TS_INTR_ENA	BIT(30)
+#define REG_LL_PROXY_H_EXEC		BIT(31)
+
+#define REG_LL_PROXY_L			PF_SB_ATQBAH
+#define REG_LL_PROXY_H			PF_SB_ATQBAL
 
 /* Internal PHY timestamp address */
 #define TS_L(a, idx) ((a) + ((idx) * BYTES_PER_IDX_ADDR_L_U))
-- 
2.42.0


