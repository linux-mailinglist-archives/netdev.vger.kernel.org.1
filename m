Return-Path: <netdev+bounces-156485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51309A06817
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E97167ABE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFD204F64;
	Wed,  8 Jan 2025 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="au5gS7re"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C1204C26
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374689; cv=none; b=VT519Tc6qRelQgV+xCJkPNjouZ/jQoJ2gvsl8tueay3kmasVRCnm+DL3kYVJ8uLu262FzDrY54W3Hq7WKfAfUJWvgVX9moHdDWzZpn5wxwMNQscguYJoL+Trf0GyxcJXBtu3Th1DdT7Ru+bE6fP/nqAvz9Ad4qqBxI/ftFxZvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374689; c=relaxed/simple;
	bh=bB74ZHhycH96hzRhIIogjeshJ8bwhPYtHgAdwYxid0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBP4vHrDzp+L/wAuhDbKZsU4veNKuhS08/fJgyycywMMr869XWoNTaJweQFghlDmMBpxLWR5RvQn91/uq9x2Gi15hoeV+WbYaT9rKbl+WvGoSk8dPbqyXc/9RyZx57EYUtHD/5yfu7v/1rnVAecqSFSuIjNZGhGX69IayJdjMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=au5gS7re; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374688; x=1767910688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bB74ZHhycH96hzRhIIogjeshJ8bwhPYtHgAdwYxid0M=;
  b=au5gS7repOHYWV04KzoSINb85cfzMS3IQhBckgs7LdBctS4k+vnjNJoQ
   QS0CPxhFC9bgLltA9sEPpFh9Se5Itge/j1sfMcmjm9ANlRodUQnuTCVBJ
   qBjrepJMY5keXoIBfA9AeUnxApFcrouFhJ2YDBOudGtQdpe010p7/Zh46
   giQVzM1XqVfXloWbwJIBWlDkDF1zsLj5wLcK9E7fDAaYk2TlBlPKIU6lb
   Q9hbdBCOoucEREQ8XCvxwugWX3GuNBKiQOT/hWJOdghJV6o5bac+ErQkt
   1+bzQIdjMYJi77F6usk00JOCEuSgGCHq2yivakFvA8YQNHDBdiJ8h8hRu
   A==;
X-CSE-ConnectionGUID: ZrZ1QDD6Siq3SMbpdv+zDg==
X-CSE-MsgGUID: dso/KcG6QHewCsOkaDI1fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384677"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:03 -0800
X-CSE-ConnectionGUID: aW47HvZZSJGkEMC/kJ9fYQ==
X-CSE-MsgGUID: jTTp29MMSZ+zP2KzrukNjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545127"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:03 -0800
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
Subject: [PATCH net-next 07/13] ice: use string choice helpers
Date: Wed,  8 Jan 2025 14:17:44 -0800
Message-ID: <20250108221753.2055987-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
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


