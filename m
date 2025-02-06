Return-Path: <netdev+bounces-163414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF31A2A367
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657D17A3CF5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D23022578C;
	Thu,  6 Feb 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxJ1yMHC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522A225A28
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831237; cv=none; b=hhsA9KpVTnAHHTySH2agbwAidUZS1PF02Wgg4+S5Lq+CNEhK1M/dxnsCemrhXfmhGLPKrcHTHqkfJmI5IwkTl+CySKrwKy5QCwHvb5s8IxVQ40UiGXl+QLyEGAsJP0O4QkOiE3K/rhGJT0Y0oieKTd9uUBwl360kkrPl0WPm+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831237; c=relaxed/simple;
	bh=rbLKv3hBZ+Wj7dmSl35OqyyYsnCfZZUSpGDd5rBfwPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuGsDPg/hVIiR8hPen060lyg7FdUmkVus5Q3iitXZjcN+w7Z1N6D5bFTkSN6L9ujCq0WQDDgY0qo7pJt7LYSM0dRHOwd4pdDSOvySSzGzZyYkzBgMrbBeGZI9N1YGv8kB6QDQRyPmx/qioCfMAhlFj8EEw9yeeqdLT9R45EWTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxJ1yMHC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738831236; x=1770367236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rbLKv3hBZ+Wj7dmSl35OqyyYsnCfZZUSpGDd5rBfwPw=;
  b=RxJ1yMHCrXDERp++ioSp5Rhuo+mwxfDxcJAjrXZYlvT0gwyWustbTO6X
   EPSOsbh1DKRDv6AxeEe1DJ3tqbQ34nxMy8XaTy5lpVYdBze0rxbv0a2zp
   FNRXvbEHHjEelqNNmQXoN5BWydmQ2FTia1GH1ELOnZJXH+owvfDMO8NSH
   3xmBGBqBwXiYNuFcMCew/FUyhTxtpjK44cuwwshZd/lyg957D9xk6PItM
   jeLtpSY7Wj8gze5lqFC2fQFnjVX6s86OpbaAi6N/Ii6Zoi8rcdSSYsruM
   PCtVysSSL0MEaLROAdPqkO/GNjrcBUIv3eSwIFZOqKI1LAkrYnXdybPfk
   g==;
X-CSE-ConnectionGUID: appydOJmS+CuUUM7OCjmEg==
X-CSE-MsgGUID: Mtq15691TjqeH6OHct+aOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49667829"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49667829"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 00:40:35 -0800
X-CSE-ConnectionGUID: ZOFmWY+RRe6ycHGT+4prZQ==
X-CSE-MsgGUID: SaGMQzDSQimmq6EgFQSWRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="110979404"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by fmviesa006.fm.intel.com with ESMTP; 06 Feb 2025 00:40:34 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 3/3] ice: E825C PHY register cleanup
Date: Thu,  6 Feb 2025 09:36:55 +0100
Message-Id: <20250206083655.3005151-4-grzegorz.nitka@intel.com>
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

Minor PTP register refactor, including logical grouping E825C 1-step
timestamping registers. Remove unused register definitions
(PHY_REG_GPCS_BITSLIP, PHY_REG_REVISION).
Also, apply preferred GENMASK macro (instead of ICE_M) for register
fields definition affected by this patch.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 31 ++++++++++-----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 63a63ef64aaa..6ca1561ec5e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -783,36 +783,19 @@ static inline bool ice_is_dual(struct ice_hw *hw)
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
@@ -832,7 +815,21 @@ static inline bool ice_is_dual(struct ice_hw *hw)
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


