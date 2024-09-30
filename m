Return-Path: <netdev+bounces-130345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14B98A218
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B661F2475B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A9198A3B;
	Mon, 30 Sep 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHrcMiZN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA6196450
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698581; cv=none; b=uiDzV0Y4drHKsvOS1U52+CRUAP1CU6h9N2VexFVLxNII5npYImkbZ6I1QKwyw7D+zwFfO5u2DS/41E/R4Nxe3Ppt8gLftNpF+2T9LIynekkYdSuzTPRvbckdMKM17VBQhy+aiSCSz4ZMzGbOcRPN7Y6pbl1MqKq8uaeNpZWLNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698581; c=relaxed/simple;
	bh=z5uNvCrGh1IL7UzBF5A15vw4jAhThlhneEsFgScSbAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzrbBBsReJqEVMyf8p3vUFtSOvC2hepe07wLXhM1DR00yLTE4PzqInNiW2sdp/Ypiya972HbN0od4hTac2rTXLrg3vRTGE/jJZS7DSpkQ7RFCwue7mHLQo6iQJNtTnNRmlFPhdaGZx9mHYA+lOlo1HRcfzYWeJC9i8SJ5mx34cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHrcMiZN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698580; x=1759234580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5uNvCrGh1IL7UzBF5A15vw4jAhThlhneEsFgScSbAA=;
  b=PHrcMiZN7i8Q6Tyu7MO8g5AMToZYSYNlbxPaa6mOEi3YNCuhf0Y/1LZd
   HeP9nn3ivBXGRNVzDVT5/IQ052EIUPmgF/d2BmAZNMYteqKZIoQlxyM0E
   JVnGbq3aW5Oj95gZp/TpcwY4LLcJXAS4gbwohsrcSf4Pw8uLZ0/gSeX30
   pdIjYN/BrjNennzgPeKM/6zFYZhSrjJtM6NfNF7cTOFxS70VEzbaqDcAj
   Wo1qIo17rdP5AoiGZbOWXqCpWRgZpVGEQGi/6uicN1tojkIbJDQc+q1KT
   CHSh3wHgcchN8KYzaO0YD2AScN3gnpk/UbFRTdrZ7uvmU6TERyd9q/ah+
   g==;
X-CSE-ConnectionGUID: O6u/fBozREqhZfKg7LYXwg==
X-CSE-MsgGUID: jpNSQnMWT3eV2dmmjctFYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26666774"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26666774"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:16:20 -0700
X-CSE-ConnectionGUID: cNHF/FSNScO3vzixhXkOgA==
X-CSE-MsgGUID: NyKDsY0rTwOFvl8o38D2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73592783"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2024 05:16:18 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v12 iwl-next 3/7] ice: Use FIELD_PREP for timestamp values
Date: Mon, 30 Sep 2024 14:12:40 +0200
Message-ID: <20240930121610.679430-12-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121610.679430-9-karol.kolacinski@intel.com>
References: <20240930121610.679430-9-karol.kolacinski@intel.com>
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
index 62bd8dafe19c..6328c0bbddd6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -674,15 +674,12 @@ static inline bool ice_is_dual(struct ice_hw *hw)
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
2.46.1


