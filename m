Return-Path: <netdev+bounces-120092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC4958465
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D3B26D15
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD218EFDE;
	Tue, 20 Aug 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJjrPz6w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330018EFE8
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149473; cv=none; b=ouFnM7BK84oRQ7yYF3BckzLuPtOl+XYhBXvQb31KAb8VHFfYYaXb7dozqLOYzUAO+YChxQ99F5qCmzBLlreH9in8c7hriFPZodUNFO4nsc1VTIp1F9+novQZ/NDnAT9sOX2lOeP9Z5wnkvJdlz09/44b5qjrp9vH51cMp2G05EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149473; c=relaxed/simple;
	bh=ccUycTBkR5zXHgkraI6V9rtWVprTFQUObzP/IBNQB74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbXr+ecASJ32rZVfIGPuDBLbSkwqB9Arkly7rYE1s91DCOerZefCqxGm1vrur9P3K8zlpzYRmJKDVkhBTJn/P3oSfzi6xqjKI4fI+p+Xj+MpMecCHjzADDjNxR1t6nz+dYZaBA8QYPHjWkJh+CO47tsk5khBDXs5mrB1ycoSwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJjrPz6w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724149473; x=1755685473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccUycTBkR5zXHgkraI6V9rtWVprTFQUObzP/IBNQB74=;
  b=UJjrPz6wGMSYd6fUglVFRXOKIbsT/qSGjN+2Gf81ff7O3+cdKv2Z8dZL
   AZQ4Zqpx3omnrWfv6QqYTkL5t+YzTur/gZPlMwmfDTe4t+FtnEHavXy+S
   pkiItxqCFgQfDevuYktxh9JNJe98kiN6rJ5o8ZexyUKt94oQiGec1kjvT
   EMQKFVXswOkLNoPK9DM+/tcP4p9RGjgr7EaKw8hL/aUbw62lSAtkZMSzd
   WXJIHKFb7RcLZ4qRslLuwjjDdxB9sNmZVVtGH8ps9DTwAvwkB45ieqn1Y
   eLQesMnqThIPCvnDOXz6MgquVhZaHHSsHnJx7wDr+U6yUsWZZVbnmQGYL
   w==;
X-CSE-ConnectionGUID: Q5VaFwCWTYqUR4h0vtIZ/Q==
X-CSE-MsgGUID: xUWYqpFRSoS6xc/SUcsTqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="44962821"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="44962821"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:24:32 -0700
X-CSE-ConnectionGUID: cIwZp3PMT2a1USffRce57g==
X-CSE-MsgGUID: LRsm/rQrQHOsVD6I883aOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="98152806"
Received: from unknown (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by orviesa001.jf.intel.com with ESMTP; 20 Aug 2024 03:24:30 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 2/6] ice: Use FIELD_PREP for timestamp values
Date: Tue, 20 Aug 2024 12:21:49 +0200
Message-ID: <20240820102402.576985-10-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240820102402.576985-8-karol.kolacinski@intel.com>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using shifts and casts, use FIELD_PREP after reading 40b
timestamp values.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V5 -> V6: Replaced removed macros with the new ones

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  9 ++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 13 +++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 00c6483dbffc..25d4399a7966 100644
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
index 8a28155b206f..df94230d820f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -673,15 +673,12 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
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


