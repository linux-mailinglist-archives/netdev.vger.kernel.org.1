Return-Path: <netdev+bounces-173483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB6A59278
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93BF169666
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0CC227E9C;
	Mon, 10 Mar 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8K9fYwr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B063229B02
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605268; cv=none; b=uINRZaIhr9aW5mRIZHJB8G6iyxiI0032MV5xqdu84AnKqjOMIPNlvbMmPRYiguhHmjZbCdaDQZLvWmemlW06fAVwC2xRy47cFvfi0JCXDsyPvmQf9UeQIXK8wwHzdfT2+6pTiZayBu++PH8yR46jau8wMWSoUPeROj8+yKAf5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605268; c=relaxed/simple;
	bh=IdCX5fBQqKpVnwixW04l2xWUpKyxIWVvXXjM9IZiuzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHVihoizMbgodnP6pHIbOwyY/5E76vk5ZYrtuuTtbWq2cL4949MZd7dOpcwgE0rzPPWdU77LOeS2wEcX7Guhnw22kww8AveUDYVBtqOqD1ndGw/MRclJYhhyj7PggFEqKDbbf6yZ6SNhLmcu8I2zP6pY2KRT3ULRlFfqeOIR7bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8K9fYwr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741605267; x=1773141267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IdCX5fBQqKpVnwixW04l2xWUpKyxIWVvXXjM9IZiuzk=;
  b=P8K9fYwru2aD+m3lGuim5yVaO1qeA2zfEEusgkxP8hzaEfDlCFvLJl/w
   ggA4dC731vpAlyC5XlScAJOZH934ZAjw+QogqT3l2xxvIwmW4RTcijRdp
   VlmEapTSQG4wfVCHYVSbx1H00hnFy/Awt5pPyqf3tva2mnM6oyKpT2lhQ
   f0HcWcJ/RV4xhOp4n1+DnxRpjNWXCqoVBuob8fpzf9R0TPVhvn96lAstD
   BTxvnw+FdO6h+Jy2XX6NxyAnfADFF8EGZPtWLoDqTQkRtDYahpsjWTWv3
   HYRzs8LBnMHojbPXGwZ359CPRsKpNPwfKLjuswrG16RRcATz25hYTEwCH
   g==;
X-CSE-ConnectionGUID: WU5WZLBbQM6VHrMSyR7cFA==
X-CSE-MsgGUID: zFIe+RswSrGpagOYnZf5mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65048700"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65048700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:14:27 -0700
X-CSE-ConnectionGUID: GVXExb/YQKqgB3rMavZPBA==
X-CSE-MsgGUID: l2hmgPpcRMGAP+BLXgVakg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119968330"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 04:14:25 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena-olech@intel.com>
Subject: [PATCH iwl-next 08/10] ice: wait before enabling TSPLL
Date: Mon, 10 Mar 2025 12:12:52 +0100
Message-ID: <20250310111357.1238454-20-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111357.1238454-12-karol.kolacinski@intel.com>
References: <20250310111357.1238454-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To ensure proper operation, wait for 10 to 20 microseconds before
enabling TSPLL.

Adjust wait time after enabling TSPLL from 1-5 ms to 1-2 ms.

Those values are empirical and tested on multiple HW configurations.

Reviewed-by: Milena Olech <milena-olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index dce5164ebd9b..62da095d32ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -222,12 +222,15 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	r24 |= FIELD_PREP(ICE_CGU_R23_R24_TIME_REF_SEL, clk_src);
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, r24);
 
+	/* Wait to ensure everything is stable */
+	usleep_range(10, 20);
+
 	/* Finally, enable the PLL */
 	r24 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, r24);
 
-	/* Wait to verify if the PLL locks */
-	usleep_range(1000, 5000);
+	/* Wait at least 1 ms to verify if the PLL locks */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_BWM_LF, &val);
 	if (!(val & ICE_CGU_RO_BWM_LF_TRUE_LOCK)) {
@@ -348,12 +351,15 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	/* Clear the R24 register. */
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, 0);
 
+	/* Wait to ensure everything is stable */
+	usleep_range(10, 20);
+
 	/* Finally, enable the PLL */
 	r23 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, r23);
 
-	/* Wait to verify if the PLL locks */
-	usleep_range(1000, 5000);
+	/* Wait at least 1 ms to verify if the PLL locks */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_LOCK, &val);
 	if (!(val & ICE_CGU_RO_LOCK_TRUE_LOCK)) {
-- 
2.48.1


