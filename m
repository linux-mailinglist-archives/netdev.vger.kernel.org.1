Return-Path: <netdev+bounces-199185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C440ADF4F0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450DF1BC33EA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408423085D7;
	Wed, 18 Jun 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8+eOmPV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32853085AA
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268579; cv=none; b=SfBN+viTsnxH2WB9LIGtpkEjMxJQaYr5wKga3lPy7zSKoJLcF/OLlR2zXK/l3xH1z8jLJ+nrxzqQ/oPv3S95nqWl6tEqmgHAgH9YJx6WSmjFSrz5qGyRSCwlzBa+c/sUb1/MlYXgxVeAgBrANdbtq7dYEEQ8k7ijzwYR2sUuHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268579; c=relaxed/simple;
	bh=JZRs3NlHp5F6bBE5Ucu4kzhg5BzIEsY+ETBlB1hrpwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PShL20ZBkQ03oLmIwyi5zy63aoJYulCHKu+ZnDNtWd11275zwNqZ5RDulnZuQCwOzAnN9A+ffu6nuKuTGrKFA/3HcNTuV0a8/vJ1mtEJ0wnIRRGELXSjg80PPc2RmtcJNnMUWNnCSqBo4o5I9XeP8Lv9YGu3ftSbBzSG7+m4TrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8+eOmPV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268577; x=1781804577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZRs3NlHp5F6bBE5Ucu4kzhg5BzIEsY+ETBlB1hrpwM=;
  b=c8+eOmPVl3FHyWM2wOwDdzB8dxgSExF9oTE9v08e9OYAxsL1gYD+Mnge
   gMaVlKy/4Xz33I/7/FzhnnsluIULuPYEZu47CwIxPTWj3Ba3RgfIhXjcL
   Muka+U4lm2NRI13NT2kyYKnwO3XVoq+EaIkRfGFK50+H7Ykx4L/BZImgj
   FT9tQ/2XnkQ9HAheM7U3K6yxkcWJ+xVHF1awutxkUzpq+rpG1gvdy4U9N
   lkmAvyqxOCDwttpya46ZoEMlLqwU0yEoCRb+ucnG8ldI80nHBn327vMIn
   8Haju6IWxsbS8UzgT9RwvBt7vGlSF2YzPmvGoY0sXM+o52Wv9USh/bCkF
   A==;
X-CSE-ConnectionGUID: k8zOf8zMQR+npIrZVjcrRg==
X-CSE-MsgGUID: hPc2sL2iQWWRpfw3tIzS0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183780"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183780"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:54 -0700
X-CSE-ConnectionGUID: ExZfNtfPRHiBoXV+8OpVjA==
X-CSE-MsgGUID: b8DyjT0gT6KEHgSUtehk3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149696040"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:54 -0700
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
	richardcochran@gmail.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 15/15] ice: default to TIME_REF instead of TXCO on E825-C
Date: Wed, 18 Jun 2025 10:42:27 -0700
Message-ID: <20250618174231.3100231-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The driver currently defaults to the internal oscillator as the clock
source for E825-C hardware. While this clock source is labeled TCXO,
indicating a temperature compensated oscillator, this is only true for some
board designs. Many board designs have a less capable oscillator. The
E825-C hardware may also have its clock source set to the TIME_REF pin.
This pin is connected to the DPLL and is often a more stable clock source.
The choice of the internal oscillator is not suitable for all systems,
especially those which want to enable SyncE support.

There is currently no interface available for users to configure the clock
source. Other variants of the E82x board have the clock source configured
in the NVM, but E825-C lacks this capability, so different board designs
cannot select a different default clock via firmware.

In most setups, the TIME_REF is a suitable default clock source.
Additionally, we now fall back to the internal oscillator automatically if
the TIME_REF clock source cannot be locked.

Change the default clock source for E825-C to TIME_REF. Note that the
driver logs a dev_dbg message upon configuring the TSPLL which includes the
clock source and frequency. This can be enabled to confirm which clock
source is in use.

Longterm a proper interface to dynamically introspect and change the clock
source will be designed (perhaps some extension of the DPLL subsystem?)

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index bc292d61892c..84cd8c6dcf39 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2302,7 +2302,7 @@ ice_parse_1588_func_caps(struct ice_hw *hw, struct ice_hw_func_caps *func_p,
 		info->clk_src = ((number & ICE_TS_CLK_SRC_M) != 0);
 	} else {
 		info->clk_freq = ICE_TSPLL_FREQ_156_250;
-		info->clk_src = ICE_CLK_SRC_TCXO;
+		info->clk_src = ICE_CLK_SRC_TIME_REF;
 	}
 
 	if (info->clk_freq < NUM_ICE_TSPLL_FREQ) {
-- 
2.47.1


