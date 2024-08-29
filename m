Return-Path: <netdev+bounces-123231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F9964358
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321D51C245E5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCB1922CD;
	Thu, 29 Aug 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw9BBNXo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2119309C
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931734; cv=none; b=Mn6JLY411MLgFZRk+U4bIu4bM886O5a147ESJSNHmqzQTH6o9BqJtyTCLgXXfFpzQEaWOEvXR87NcpMJlFDj6Wd6hfuEaxrI9XM3SiplITHnM8Kq5Tb2ElU5mKzM0meP9EOH1MUAvGt+awgJpvAYCODK0A6eEnh5E9du14C0kGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931734; c=relaxed/simple;
	bh=2mQSaneFaAvse1S7g/x7TBTbL628yvuAB8xbMvb2QkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu52n8H7AL8q/AVq8bG7upZ3PjhNajW2Hfkgh6PjsZNZ99m+KnNQHgmogtqvaFbhOLcPAS1tU2vPsZULnktHEKsP4YImgGjlLIVWSAlHHvlHEk7DKDP+mURmKoUK08/KoVz+FWynfoca237j/qegQp1Z8E1Mga8Sp2/7ByAxZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw9BBNXo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724931731; x=1756467731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2mQSaneFaAvse1S7g/x7TBTbL628yvuAB8xbMvb2QkY=;
  b=Tw9BBNXoeyf6vZLjTvK1/CAECTj+QOLy8rLbFo1MmtYFUzAvj1SZvLGM
   jiEF9YN3YN5ecmUpjBi2E7dcMIm2pKHwVQnOGfXzlNQ0dMTiqrb23hqev
   iMgsg+Sy6fFoMNmm4k3j+LZAzEhEn4PQ3fKRs+Lcp143l4jA3CIQ8TsYt
   PFJPRM4uZo/4aFiH8njfagWHSfdQVAt4v5X02dCn+l7W5JLkoWNfsRtC6
   y7D6ATVOASmyKlTYJ5hEfKkj2flM1Tu0EMxWRWcS5xHzPbSO3X2KFaqTQ
   RsfKSpUvuCkMB7RYBkaV7U+yoxUjRSFHrxj2fqdE6MJOfQ0ujvdU+Zt8M
   w==;
X-CSE-ConnectionGUID: eapkACeLRha9GxXbvSucCg==
X-CSE-MsgGUID: 5ZUMF3lxSziTPiuNKRsqDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23092329"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23092329"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:42:11 -0700
X-CSE-ConnectionGUID: m3EtpyI5QEOQQwrEpG8emg==
X-CSE-MsgGUID: YYigrl9ESLKNPBIrqdQUEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="64045401"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa007.jf.intel.com with ESMTP; 29 Aug 2024 04:42:09 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v9 iwl-next 3/7] ice: Use FIELD_PREP for timestamp values
Date: Thu, 29 Aug 2024 13:37:39 +0200
Message-ID: <20240829114201.1030938-12-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829114201.1030938-9-karol.kolacinski@intel.com>
References: <20240829114201.1030938-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using shifts and casts, use FIELD_PREP after reading 40b
timestamp values.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V5 -> V6: Replaced removed macros with the new ones

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  9 ++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 13 +++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 0fc4092fd261..65a66225797e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1520,7 +1520,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = ((u64)hi) << TS_PHY_HIGH_S | ((u64)lo & TS_PHY_LOW_M);
+	*tstamp = FIELD_PREP(PHY_40B_HIGH_M, hi) |
+		  FIELD_PREP(PHY_40B_LOW_M, lo);
 
 	return 0;
 }
@@ -3199,7 +3200,8 @@ ice_read_phy_tstamp_e82x(struct ice_hw *hw, u8 quad, u8 idx, u64 *tstamp)
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = FIELD_PREP(TS_PHY_HIGH_M, hi) | FIELD_PREP(TS_PHY_LOW_M, lo);
+	*tstamp = FIELD_PREP(PHY_40B_HIGH_M, hi) |
+		  FIELD_PREP(PHY_40B_LOW_M, lo);
 
 	return 0;
 }
@@ -4952,7 +4954,8 @@ ice_read_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx, u64 *tstamp)
 	/* For E810 devices, the timestamp is reported with the lower 32 bits
 	 * in the low register, and the upper 8 bits in the high register.
 	 */
-	*tstamp = ((u64)hi) << TS_HIGH_S | ((u64)lo & TS_LOW_M);
+	*tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
+		  FIELD_PREP(PHY_EXT_40B_LOW_M, lo);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 51bc691f1d0f..3968e064cc22 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -676,15 +676,12 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 /* Source timer incval macros */
 #define INCVAL_HIGH_M			0xFF
 
-/* Timestamp block macros */
+/* PHY 40b registers macros */
+#define PHY_EXT_40B_LOW_M		GENMASK(31, 0)
+#define PHY_EXT_40B_HIGH_M		GENMASK_ULL(39, 32)
+#define PHY_40B_LOW_M			GENMASK(7, 0)
+#define PHY_40B_HIGH_M			GENMASK_ULL(39, 8)
 #define TS_VALID			BIT(0)
-#define TS_LOW_M			0xFFFFFFFF
-#define TS_HIGH_M			0xFF
-#define TS_HIGH_S			32
-
-#define TS_PHY_LOW_M			0xFF
-#define TS_PHY_HIGH_M			0xFFFFFFFF
-#define TS_PHY_HIGH_S			8
 
 #define BYTES_PER_IDX_ADDR_L_U		8
 #define BYTES_PER_IDX_ADDR_L		4
-- 
2.46.0


