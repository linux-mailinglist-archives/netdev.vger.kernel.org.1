Return-Path: <netdev+bounces-187180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD31AA5842
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2004503471
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A722AE7B;
	Wed, 30 Apr 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoNtpZBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02A22A808
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053513; cv=none; b=d5sAUiCKSxMf+DGm23penm38nXHk62qzVGBj5v5zUfKB+lM7nitUotrnA39pPEry+duin/lG7i8NLde8u1cgEgcI3MrrE6sjYkK6uvEc/KWbs5ABc6S8tQsO7CGrTlV0I8/vdqmv0F1eIodDUmjGj9RKtpJljl34aRhXQ6cN1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053513; c=relaxed/simple;
	bh=OYC8S7dHU/v0AL94qqFHTHeD1xMd/btzDbvBJSN3/0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXCdIji6OXZfBfWv2KE48gJ/lEDAiKa2admIOVZ5HrOSLJ4T7Vhj5N2+ZuotNLDzM3/pndgX5ZVi4y4J/bdb9zCs9Mxrh715QEMhu8oK0odqQQozhil8q2d3KIu8zcZLgBD42Lzzh52r+nectV0lPvULkySqhGVm+a9yyR0Te2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoNtpZBJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053512; x=1777589512;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OYC8S7dHU/v0AL94qqFHTHeD1xMd/btzDbvBJSN3/0U=;
  b=FoNtpZBJvfLcgJnX58PXEktGyGZ7ExqIZW4gfK+7+f45idglVEjEs0Kp
   dGRLvnGHdsvNN/mo/0Z34Xg+ybjm4u33hw1q0NSuL30tVosJQ5f38osX2
   Od+77dlv/ZpjrY9ztdySX0wK5ISp4yWHgH5JpE8GHaJG4khmKVEGAr+kv
   jGADmIEuI38+lpyOKQyJUnxGrr6fEUJaBzzkkGg0m0iFNxuRJzyShie4L
   gC1RDfzlJ24trrCmhWU+6Q3kIJuusclNdmgx46l7xzS+U+/wWKLqs+6i1
   v3+XooCu1xMF+30pn/2CfwMmlviG6lCJukQrrYVUvJBtkcDaUnZhLFFfd
   w==;
X-CSE-ConnectionGUID: FPKPBgzkQTSI4fo/R9qtKA==
X-CSE-MsgGUID: 5mf89aHaR0KSs74ooNGn5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120912"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120912"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:41 -0700
X-CSE-ConnectionGUID: uktFWRxtRO+iBD1B419J4g==
X-CSE-MsgGUID: CXN93SBzTXmY+bM9fALlNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145103"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:43 -0700
Subject: [PATCH v3 12/15] ice: wait before enabling TSPLL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-12-ab8472e86204@intel.com>
References: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
In-Reply-To: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Milena Olech <milena.olech@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

To ensure proper operation, wait for 10 to 20 microseconds before
enabling TSPLL.

Adjust wait time after enabling TSPLL from 1-5 ms to 1-2 ms.

Those values are empirical and tested on multiple HW configurations.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 0792d60438cad479934bac0ffd3454c8b193079a..93016bf92256e658e3d794ccf117eb7cd03af6f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -229,12 +229,15 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
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
@@ -357,12 +360,15 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
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
2.48.1.397.gec9d649cc640


