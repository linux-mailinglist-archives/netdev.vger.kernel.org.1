Return-Path: <netdev+bounces-187183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A6DAA5845
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5EB1C22946
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1EA22CBEF;
	Wed, 30 Apr 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OffqQ1/7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749222B59F
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053515; cv=none; b=Y1INX1Bu+HgULe85zkl/K5sSl6L2k53NiTuy0z3VEgO4+w/nxkq6QMc+Qp/KHLhgv3PrbKSAbAst3oHFkyEvzuR4n5TiWhMJh3MaqXu0AMzZDJ8NpXKzXUBqo1Nlq8xI4V+/H6H2Qj7thl3CJiUZIA64y01gWEQKd3vYP48ThD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053515; c=relaxed/simple;
	bh=m++wo7A9ad8MM4i6a8V8RzXDMWqd1AmBRiBAhiCSGfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FT1Eq+9sSlRGxDztXV5E7PwjEPcDXe8neSK/8Nw3TSUVV9XJGntg+Wk8nOZFQnSehHeU7aP4vX/L54Lu6P2KqfYsBtnqtW5lxPaDtvXywSFTPkuWSdzNSJDyfeZBj5Jywj51qfB/nEMcrwCksBnB6eg/5GlnZURi1WmSc9KtgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OffqQ1/7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053513; x=1777589513;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=m++wo7A9ad8MM4i6a8V8RzXDMWqd1AmBRiBAhiCSGfc=;
  b=OffqQ1/7GecXYelZsFKNQlmZvP2fjLcu2blzIdtjF7q9CWBlPgMXU/EX
   YaOCwldivJmvloZuoPQ0uSpr5cjNox2i80JM9ojJhWVc4S8Ci4ZixJE1J
   b5AEATPXanEOz2tNo1S6zSGUrVMsGpN1A2kPzkdNzWNk/zK5Qyt+N3ni0
   oJ80d1L/77RXJBhKmNGTxRbdEBuXLYhry1lnRYAjIUVfJqBCwnW61f3S9
   cLFkLflMTWo3BGafOOQvT8QrE1nwfejR9ACu44aznbkY6xQBhn+iB7EoA
   89jG5uWNCoY1gPNhWLq0PJRG1nISZ1tdKxV8ceQ2lKISzn1cAJsv9+hqs
   w==;
X-CSE-ConnectionGUID: OB/2JVKlSK6FE09TwujZpw==
X-CSE-MsgGUID: acfuCrwpSaaC2vnzRmAPAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120914"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120914"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:41 -0700
X-CSE-ConnectionGUID: xlRfk/KZTIa537EGLTfHBA==
X-CSE-MsgGUID: up09loImT3O5D1HtSDEfZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145108"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:44 -0700
Subject: [PATCH v3 13/15] ice: fall back to TCXO on TSPLL lock fail
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-13-ab8472e86204@intel.com>
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
index 93016bf92256e658e3d794ccf117eb7cd03af6f8..d5db0bdbb36402c7e45f49cf55e1dbe0cac10df2 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -497,5 +497,17 @@ int ice_tspll_init(struct ice_hw *hw)
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


