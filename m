Return-Path: <netdev+bounces-200465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971AAAE5897
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32093AA68E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484F1714C6;
	Tue, 24 Jun 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmvFNQ+p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391E194A45
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725013; cv=none; b=KeynWICow1qkvnLG+xpUIQ1qmCtN9fp2OmrmsAJqaYcN3scZHeTkDo9l2tkhbJ/eSpVcKh9t6sTIuroRnjVPkm/Ctb5fYaVUhwae+3J1qTP3Ezm0Fy6FR13jY95YxJdH/xsfBiePfkbjsHy+wrtU4DUnBAVd3/aAsa9f2ihugqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725013; c=relaxed/simple;
	bh=o4hj3F9sT37zdvuAQpgExiaMoeCQnU2Bj09aX+sXwAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxvsohV/oZfeP4aPfQAwBDg1hbPy0N8Rh1uEtJgMh4VITU0zLXXhg72dLFXDO4vb0KKUKKF6/PGrThGek8eZhau/hllXS2lV5CA6r0zlm+G6O2fmi3a0yU/kEUu0L3F/ScNzC6zYsxIA4btWS6hLRRHQjxOnPmYmQpUIwBbQ0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmvFNQ+p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725012; x=1782261012;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=o4hj3F9sT37zdvuAQpgExiaMoeCQnU2Bj09aX+sXwAM=;
  b=lmvFNQ+pYpVje8ToxW5Ae7FAK4J5MuxpKtR2fyWim1fWik7qeZ7dAb4+
   nvboB97e4DK/beRdwJShjILMuwexCJDcnZiYnZFtPKnE9YqzSoVqcesKs
   8zCwRBl+z8Li2Pe50v9pgSS3OBPHtQTAQaFVFmlzBdoLuZUGX5P4gHbD1
   OMbrDoZ0iUWBk4eWkVUVAv7FPo0OCxyk5vF/CP0Na5ZwDot9Csvcx8SPa
   lFOtXVVkySMDgcnJQ8K3x6yIQynoaq07NB5o/A5p23Nx7+DBZuZ6lfp+H
   AdHc8e6EreGWi9SQkuDWHd5jFwaU3S/S0WTkvzBOAkC2o2ej4n8ao+RCz
   w==;
X-CSE-ConnectionGUID: 8NL2ykTfRtS93nM05WTtWA==
X-CSE-MsgGUID: vvkncbGBTouHEw4+d3wPqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52067921"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52067921"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:07 -0700
X-CSE-ConnectionGUID: ucq3/5DaQYKC2ivB8+EpMw==
X-CSE-MsgGUID: KB1hCkS7TqCfrDvXElPSIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157534051"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 17:30:02 -0700
Subject: [PATCH 6/8] ice: fall back to TCXO on TSPLL lock fail
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-kk-tspll-improvements-alignment-v1-6-fe9a50620700@intel.com>
References: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
In-Reply-To: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Milena Olech <milena.olech@intel.com>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

TSPLL can fail when trying to lock to TIME_REF as a clock source, e.g.
when the external clock source is not stable or connected to the board.
To continue operation after failure, try to lock again to internal TCXO
and inform user about this.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index abd9f4ff2f5563e35dd8e8fa551eb944d8f5802a..886a18b2e65fa03860f8907552f2a57b0717fdf7 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -605,5 +605,17 @@ int ice_tspll_init(struct ice_hw *hw)
 	/* Configure the TSPLL using the parameters from the function
 	 * capabilities.
 	 */
-	return ice_tspll_cfg(hw, tspll_freq, clk_src);
+	err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+	if (err) {
+		dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to predefined frequency. Retrying with fallback frequency.\n");
+
+		/* Try to lock to internal TCXO as a fallback. */
+		tspll_freq = ice_tspll_default_freq(hw->mac_type);
+		clk_src = ICE_CLK_SRC_TCXO;
+		err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+		if (err)
+			dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to fallback frequency.\n");
+	}
+
+	return err;
 }

-- 
2.48.1.397.gec9d649cc640


