Return-Path: <netdev+bounces-158310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F993A115E2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027083A6AAB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798BC1805E;
	Wed, 15 Jan 2025 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0AwYJZW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB182AD2F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899738; cv=none; b=HBNrkvx5PRJ/o2LSwtBGqe1h0h9mSdRAXKTpL2TW2TyWDVug3I+ZV8aEJ/rWq6hwv8B1gY+yc5+z2Kep0XNdVEFuCYG+ZrTTDROyVHsP/KU0hbVOCdGYjAzmSL+AorLqnCBfPtiAYxa1FO43qdGmk0KWDcMw7uH1p/XeY82vV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899738; c=relaxed/simple;
	bh=bB74ZHhycH96hzRhIIogjeshJ8bwhPYtHgAdwYxid0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/ojm7QXkhtv7Jj5tqG/om2UwwOyzraF0RtgmGEng4zi/QvK03ZtLk7B2+Vqd58rOcpuz0eBUAn6lUv0QSgI6Irhm4jWDN5yUG0MTh3EgDgy961Lhh3v9kUEXOYaa2M6gwKwvhr/uCqPwOesD7yR4eLQv4Hw5r1aRs9/PMX8pzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0AwYJZW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899737; x=1768435737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bB74ZHhycH96hzRhIIogjeshJ8bwhPYtHgAdwYxid0M=;
  b=j0AwYJZWn4iNP7MUTSMs3RHp7ny+fsl/oP8mujHsSGn7SAsaky+2Ewas
   hM8XsrNY0nP65wZzkM1jBtjy8kTBldRmvBglwu5Bfkjer2jPZ47JnG5xT
   Nwp2rNKail0Q0Y5Rh1MVp3KHhgXaJ0KJY+0UMglKYjrr1Xo3t32DSDmb5
   xJxCbeh6YCQ7b0BXtUGKkRfb7ArQRx8ShedUIrGhVBdXk4Vi6HrPUg2YV
   iDW4C3oexOolfDKFjjWLVuzXyoNaOqNIY7malM3EpYm71jwkRlawfzECP
   gj/GBb/RDq/498aIxCQ5DP40yr8zDbwphNZbw+EeDEuFUrwk9gk6iQx2Y
   A==;
X-CSE-ConnectionGUID: VLlCWvshTc+qOelVZ5UFhQ==
X-CSE-MsgGUID: QmzLig92SmWcW0SqZmC/eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897494"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:53 -0800
X-CSE-ConnectionGUID: y8b24wfyTM2GGemzMH+xlg==
X-CSE-MsgGUID: Vjg3W49ZQAKjGzFZs8EozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211419"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: R Sundar <prosunofficial@gmail.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH net-next v2 07/13] ice: use string choice helpers
Date: Tue, 14 Jan 2025 16:08:33 -0800
Message-ID: <20250115000844.714530-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: R Sundar <prosunofficial@gmail.com>

Use string choice helpers for better readability.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202410121553.SRNFzc2M-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 518893f23372..6f9d4dc82997 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -391,7 +391,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw24.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -469,7 +469,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw24.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -546,7 +546,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw23.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -651,7 +651,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw23.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
-- 
2.47.1


