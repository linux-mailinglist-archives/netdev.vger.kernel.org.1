Return-Path: <netdev+bounces-200461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D81AE5893
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C174A7BE1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6C189B84;
	Tue, 24 Jun 2025 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OokdlrdH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DF146D6A
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725010; cv=none; b=os5ycE+CRHCQcESYsvErRv2mYuuN0FR5gmrqBTCw8B8smOUERXsz5yd9rk9/8xKtlfJIxoqA2ysSzyo2L6zSQJblg4TrzKdwH2P9NcB7FDMM46uUonAnnuVyTpEAe0qEwYLF1ejufjrHHreQ0uBytLY+nuWoVXiR5v5qmzvOtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725010; c=relaxed/simple;
	bh=JQulblvZ9KguPREQqmiIHpNZ2kGo1SG8kyE41WYNtTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7gHget2Y9x5NPBEiFnFrRaC8Pk38JFsuWsPVAx2djoQX35xGbZ05JY4IQSaH0+flMfJcpWslssyXtq5ISj7XL2bm0ATs5FSoFkKlqBRVWPM2Bb3HnhTBYtR4RuvWVnqYzZA6LQUtiop20TxvuaT+Xr/zMGHYqyeqXKnpm23Ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OokdlrdH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725009; x=1782261009;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JQulblvZ9KguPREQqmiIHpNZ2kGo1SG8kyE41WYNtTw=;
  b=OokdlrdHfrxn6qpNllUmWnq93c4xxikPtUKjUTQUTRNSFxC/YgKeWe0D
   thPR1Uk7mWg841YF67xcLe7i37ry27LK5a+OEJb2gDAIQKi8mIJh4CbUx
   8NF941BaYpEXn0OShtVTChW1JNGAuLPKvGKJ40jZdPH1zTRmyuBl2hGQy
   yEaBcgIVoeXz3r4Ege8IBqX6Hd+2MobHoEqXPp/+2NpYHNlEktwnBxHNL
   zyivkgsG+4HFST5GpH14eNGF7iEHcR1KRk9NB5oXMqmNGDTgrdxBr42Ug
   en62KUAfGTVum94Q3RF2PIewcC+xe+bE7+JPFms9FiY6A3sklquLCx5dy
   w==;
X-CSE-ConnectionGUID: uFKjpsaZTC6dZ77VSg8yuw==
X-CSE-MsgGUID: mfff6gsZRUWqvisOROxL6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52067911"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52067911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:06 -0700
X-CSE-ConnectionGUID: ffmBVAaDTXyI68ELtCYZFg==
X-CSE-MsgGUID: ebUURq9LQLWHsQ9ewLjkLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157534038"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 17:29:58 -0700
Subject: [PATCH 2/8] ice: read TSPLL registers again before reporting
 status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-kk-tspll-improvements-alignment-v1-2-fe9a50620700@intel.com>
References: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
In-Reply-To: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

After programming the TSPLL, re-read the registers before reporting status.
This ensures the debug log message will show what was actually programmed,
rather than relying on a cached value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 5a2ddd3feba2f96d14c817a697423219cadc45e6..ce494fc2193ece9e64a6957bcaf18edd621992df 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -239,8 +239,11 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
+
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, false);
 
 	return 0;
 }
@@ -433,8 +436,11 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
+
+	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, true);
 
 	return 0;
 }

-- 
2.48.1.397.gec9d649cc640


