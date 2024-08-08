Return-Path: <netdev+bounces-116856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C70594BE09
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE06BB2160A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881518C929;
	Thu,  8 Aug 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edphm43T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AD1487C0
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121919; cv=none; b=Q7xqWWqCuMab1eJJvp8jbZyb1ewRrc3kzf1KEALmTW1VKazn0oS2CHra6599iwEwoQSu8DFW8PSa9FU2z2bhFVnshMGx7rSDkdpUMwOCpjYjWh1dJeTw1/32ojMq68GzBrtwHWt9PmYFsN8eRiw+mq06PIsgqdDwz1fwNF0gT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121919; c=relaxed/simple;
	bh=+d8DdgduNTeedRsYArvK/lfw1KmycAiuex+juw2noZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATwliGv0HdTHQTYr+6zkmh7r+B8OrmagUqx/EQi88943U0BkAqewC44mofBFaofGvsqV3vwHeHq2ctVGMhZEPPq5GGE+CTXg0vj7CJm+SbKOGHjagyWYuHfcKsqORZClKSZpejhluxo+kFKxPWKE1HSVF+MkbdrSYzmg/CWZT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edphm43T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723121917; x=1754657917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+d8DdgduNTeedRsYArvK/lfw1KmycAiuex+juw2noZI=;
  b=edphm43TuZrGs+bJwk3Qf0Lgj8V8bLzOgHkRmkfx++T3l7BQnqgwBHE7
   zAnQHr+HBmgysDTzhX4pKROq3R7W2kPy2YsWq3JozFBXIelwsqF30Xg1X
   /cAcZ4Q16QyAyT1+XqnuOE720LIQ/v0Bbw3JWy0g9qsDB5HhNcCVj+B+s
   /ofG0wpdrNiGBoaHTwgIyVCcu/3uxAvdD+KvLZefQjZJ0Wtg9P8A+cXlF
   WJ+XwyMuds+qMJfDluASriYxJMYmyD6FzORhvkQgxIY0x6A/OSyHe4AxL
   /+gE40PaSSqb+mGp7Nc3cTPMyB87m4styFVEPOsc7IHAx8+MX+GTVhIBO
   A==;
X-CSE-ConnectionGUID: Fm5NfQ4WQZGyKrmUImzm3A==
X-CSE-MsgGUID: qglRRKSUTkSMz3/6RHuYPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21404759"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21404759"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:58:34 -0700
X-CSE-ConnectionGUID: JkNpYmUaQxeGjHH0aj+fMQ==
X-CSE-MsgGUID: IgB/onBcT1WrGWZn/Gttkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61595071"
Received: from unknown (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 05:58:33 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v5 iwl-next 2/6] ice: Use FIELD_PREP for timestamp values
Date: Thu,  8 Aug 2024 14:57:44 +0200
Message-ID: <20240808125825.560093-10-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808125825.560093-8-karol.kolacinski@intel.com>
References: <20240808125825.560093-8-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 13 +++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 00c6483dbffc..d1b87838986d 100644
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
@@ -4952,7 +4953,8 @@ ice_read_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx, u64 *tstamp)
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
2.45.2


