Return-Path: <netdev+bounces-164765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8929A2EF78
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CE016752A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00A235C1F;
	Mon, 10 Feb 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUACYJnt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542E22FF21
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196912; cv=none; b=TmZdKfRcBKXh/MdDd1YpgJ10Wokkd00bZFkj9nJ6awTws3jYX5Kd3rQO6vKqoxrsHt2TcXdIHQHYycwVJMWbdnulttKH1cW1ErwkG9vQkQR3gGox5ajkXWriYYM3CFs/OrLrPO8a4Lr3FozycICbIJd9jpgcdSxXESflXU2911M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196912; c=relaxed/simple;
	bh=JawMQ25PioYK1t5EJK+WJDqH43Pq8L2h+ivUz7dPYAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGOp7uTtPy4A6xiCzDaxXlNDtlpifHoQmWWWpMoTwt/QS/pOlCduSE5lYBhTk81iQlu4CO1MPnq57qInUO9S5QP9fnnKdJhGaLvdI0o38+1I/Ow07uWawIssXvyq/JCED5ja27a491ifzArCPNvV3oIcazKR1/Dpmvw52YtUwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUACYJnt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196911; x=1770732911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JawMQ25PioYK1t5EJK+WJDqH43Pq8L2h+ivUz7dPYAM=;
  b=fUACYJntwU5UGO1wpUAJNgVAQK55LYS3kmrVqelGDf85YHw2FzvzoQzW
   WDBg27E6D9sf2YDE4Oh7pu1UhBv0tw/txub+s7+yMWvy+zG/B32b8crq2
   EgfQ4hp4pR2blolj+8ZSQUVgt1/mhU3zT51o30T5zK42vYM/UlVuzwrmT
   QEatf2BBkXaGBSoeG+QQoPy2ZionGTmV2EnceR7ODkPqG0AMjDq/S3Fz4
   DUKpOWU74Uw47NgD8uVQnvPEj+PMW+JljEdVM4e5x4tptwHG79Rf5C4iR
   a6DhwZymgtw3GQRHJhmNFyzAODTbfGUyswrvkp9nqakL/Iacq7FwgHsTx
   g==;
X-CSE-ConnectionGUID: 4XJnHDJBQdyxLuyo9F3Eww==
X-CSE-MsgGUID: JUUjpJUVScWjHH6mWE6XeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39927481"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39927481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:15:10 -0800
X-CSE-ConnectionGUID: yGI+t8CLQf62Hy3aDJaPRA==
X-CSE-MsgGUID: IX337HWXSpylSEJYJMV1sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117421106"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 10 Feb 2025 06:15:09 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v2 3/3] ice: E825C PHY register cleanup
Date: Mon, 10 Feb 2025 15:11:12 +0100
Message-Id: <20250210141112.3445723-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
References: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Minor PTP register refactor, including logical grouping E825C 1-step
timestamping registers. Remove unused register definitions
(PHY_REG_GPCS_BITSLIP, PHY_REG_REVISION).
Also, apply preferred GENMASK macro (instead of ICE_M) for register
fields definition affected by this patch.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 31 ++++++++++-----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index cca81391b6ad..e5925ccc2613 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -780,36 +780,19 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define PHY_MAC_XIF_TS_SFD_ENA_M	ICE_M(0x1, 20)
 #define PHY_MAC_XIF_GMII_TS_SEL_M	ICE_M(0x1, 21)
 
-/* GPCS config register */
-#define PHY_GPCS_CONFIG_REG0		0x268
-#define PHY_GPCS_CONFIG_REG0_TX_THR_M	ICE_M(0xF, 24)
-#define PHY_GPCS_BITSLIP		0x5C
-
 #define PHY_TS_INT_CONFIG_THRESHOLD_M	ICE_M(0x3F, 0)
 #define PHY_TS_INT_CONFIG_ENA_M		BIT(6)
 
-/* 1-step PTP config */
-#define PHY_PTP_1STEP_CONFIG		0x270
-#define PHY_PTP_1STEP_T1S_UP64_M	ICE_M(0xF, 4)
-#define PHY_PTP_1STEP_T1S_DELTA_M	ICE_M(0xF, 8)
-#define PHY_PTP_1STEP_PEER_DELAY(_port)	(0x274 + 4 * (_port))
-#define PHY_PTP_1STEP_PD_ADD_PD_M	ICE_M(0x1, 0)
-#define PHY_PTP_1STEP_PD_DELAY_M	ICE_M(0x3fffffff, 1)
-#define PHY_PTP_1STEP_PD_DLY_V_M	ICE_M(0x1, 31)
-
 /* Macros to derive offsets for TimeStampLow and TimeStampHigh */
 #define PHY_TSTAMP_L(x) (((x) * 8) + 0)
 #define PHY_TSTAMP_U(x) (((x) * 8) + 4)
 
-#define PHY_REG_REVISION		0x85000
-
 #define PHY_REG_DESKEW_0		0x94
 #define PHY_REG_DESKEW_0_RLEVEL		GENMASK(6, 0)
 #define PHY_REG_DESKEW_0_RLEVEL_FRAC	GENMASK(9, 7)
 #define PHY_REG_DESKEW_0_RLEVEL_FRAC_W	3
 #define PHY_REG_DESKEW_0_VALID		GENMASK(10, 10)
 
-#define PHY_REG_GPCS_BITSLIP		0x5C
 #define PHY_REG_SD_BIT_SLIP(_port_offset)	(0x29C + 4 * (_port_offset))
 #define PHY_REVISION_ETH56G		0x10200
 #define PHY_VENDOR_TXLANE_THRESH	0x2000C
@@ -829,7 +812,21 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define PHY_MAC_BLOCKTIME		0x50
 #define PHY_MAC_MARKERTIME		0x54
 #define PHY_MAC_TX_OFFSET		0x58
+#define PHY_GPCS_BITSLIP		0x5C
 
 #define PHY_PTP_INT_STATUS		0x7FD140
 
+/* ETH56G registers shared per quad */
+/* GPCS config register */
+#define PHY_GPCS_CONFIG_REG0		0x268
+#define PHY_GPCS_CONFIG_REG0_TX_THR_M	GENMASK(27, 24)
+/* 1-step PTP config */
+#define PHY_PTP_1STEP_CONFIG		0x270
+#define PHY_PTP_1STEP_T1S_UP64_M	GENMASK(7, 4)
+#define PHY_PTP_1STEP_T1S_DELTA_M	GENMASK(11, 8)
+#define PHY_PTP_1STEP_PEER_DELAY(_quad_lane)	(0x274 + 4 * (_quad_lane))
+#define PHY_PTP_1STEP_PD_ADD_PD_M	BIT(0)
+#define PHY_PTP_1STEP_PD_DELAY_M	GENMASK(30, 1)
+#define PHY_PTP_1STEP_PD_DLY_V_M	BIT(31)
+
 #endif /* _ICE_PTP_HW_H_ */
-- 
2.39.3


