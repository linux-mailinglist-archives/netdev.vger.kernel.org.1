Return-Path: <netdev+bounces-201647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E981AEA378
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953BD1C432A9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407092356D9;
	Thu, 26 Jun 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+Bb5rU0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296C211A0C
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955373; cv=none; b=UcPBaFAkfnpO8s4p/2Syk427ATtZEh8gmMkI6zJkY9amtH+x/WKQuAystr37nhp9uYP5mq5/K8kp0VeQrmknbHcVPKj9xKlHrBJlM1fzkHb8t8b1/tLoquWWbvoQab8B5vIknAx3lWPKpm0j/Ln8MhVtbf2Rm7XWRAR0H274E4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955373; c=relaxed/simple;
	bh=t8wT5hZ1DUx/a+lnzvHgDi4K3ibom1T+L8UZ2ULfk+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btTyij3o5wHPoWlBW8e0a+6V+CtskSqPjrNepqJ21qc2b41IenEHYR/Yeuci9Og2CM2KiRjeceoCZSdYknT8H60dq+tcHxQOHtyqhYotd6zPeIrepX4u5DdZcMj+azdXLvw3OrjQ65bUrcV7SfM6d29oB0ftgd8cf1lATpGrnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+Bb5rU0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750955372; x=1782491372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8wT5hZ1DUx/a+lnzvHgDi4K3ibom1T+L8UZ2ULfk+8=;
  b=i+Bb5rU0tI7I6K6MDuYtyYAihhOEKgjnd2/isBQtzOK9v9DlybHP8FA/
   p1EwhgNaiq58cd4BpgMQsHq+zjqNHjAlk9nx0xy2qzlj1EWaaSIuabqpY
   W0sf8GETtmSIjHLgAnwhk/i78XgmHxYaB2jtssTsYY1QE0kNI+9WPKjFw
   +QZwd7clVMdn5zJ/S4Ib4bVj3elSkk4e3iVvBqCd3eP1DeziDDvT3bDM2
   qNRQZcgjIY7NrBNzRJi4Jb0XeCs3CISweRo7krBukK/2Z4g/uGBq+bJi/
   0hbgNESTYjVxTuJRNb0Y38aD6vAQQnpEYVfYH9OvDlx5wzwo1Uwvjzmv6
   A==;
X-CSE-ConnectionGUID: 6G9zsuaaQ2iVV0SIl1IL9w==
X-CSE-MsgGUID: PvOYdnOSQc611NDO4pW3fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="70830011"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="70830011"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:29:30 -0700
X-CSE-ConnectionGUID: /XOYoccOS0KRlV8mJ2QzqA==
X-CSE-MsgGUID: mIsTZT+kSaq+0+la3MRPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="156852476"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2025 09:29:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	karol.kolacinski@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 2/8] ice: read TSPLL registers again before reporting status
Date: Thu, 26 Jun 2025 09:29:13 -0700
Message-ID: <20250626162921.1173068-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
References: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

After programming the TSPLL, re-read the registers before reporting status.
This ensures the debug log message will show what was actually programmed,
rather than relying on a cached value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index e2f07d60fcdc..440aba817b9c 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -239,8 +239,15 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
+	if (err)
+		return err;
+	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
+	if (err)
+		return err;
+
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, false);
 
 	return 0;
 }
@@ -433,8 +440,15 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
+	if (err)
+		return err;
+	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &dw23.val);
+	if (err)
+		return err;
+
+	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, true);
 
 	return 0;
 }
-- 
2.47.1


