Return-Path: <netdev+bounces-199178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77043ADF4EB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758A41BC2FF3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FED307AD4;
	Wed, 18 Jun 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCvKY7Ex"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62D2FE391
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268574; cv=none; b=sWGiuCQVERbtJGQMuoK12Uji87K5bxIFQg4ZeWAKB6A3vKFJEZ/NWMxhizhnzdEMoXZokLUtdOp4rLpJNVNyghz0Bplm/FCYsPwtarA1PfI8FfQpT7BY8bl0+pgU4BdU8msEuaFfaYqOgJvd5P15xAgbZUGv9hccJwLyg3eaPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268574; c=relaxed/simple;
	bh=Z5kkU6+E1c0JF2JHDsX6B+jdUnp2jwbeNLrKLL9/F5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZgmz011wFXZWmFMQCG82m9Bq5FkO0LFm1HijZB8NkZ2SzFlmVvL2SIZXEz26S6vYhiqBUspjkyb2Bs9hJbW5xFlk9rlySUGWKtRBDOwYsxtyxNBJDypsrZ9RRGNpz0S54ur1TAPhOHzeOwLtovTkivcqXmF9Yn2AoMR9jNdyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCvKY7Ex; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268573; x=1781804573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5kkU6+E1c0JF2JHDsX6B+jdUnp2jwbeNLrKLL9/F5k=;
  b=PCvKY7ExKHHNMhRvog6elHkxbqJg3OepTOmywUxwgL/5Ho/Lrn1Fehvp
   16mbhJzq4jG/T0jzpOuympSZMZtoAOahhVOr20r4cg/hHaYuudpJehjXj
   cSOnW7WovQWYixkVUuMeDLHlLgyCZcMYgJ05bEcTZrgrH809foSwWzMhI
   YDtth87dFyJHNbvwtBRA7FG31Qq6HhL+Ow4104vh3LbqNNbLQPECP8Oo6
   s7HPGTAS6cv+UuE+dschMn6LTNWfeOf5U80/7TuTppObz7glpFg5aIpKb
   lH77PWatMA2p1b4ge6iR77qy4UNhjBJ5hfxowcGMbdlAv7/B10rJULWT/
   Q==;
X-CSE-ConnectionGUID: j9Ys8l0zQoWHzovpYBwwZA==
X-CSE-MsgGUID: Bq6dVv2sQ16fixsueE6d/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183721"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183721"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:49 -0700
X-CSE-ConnectionGUID: A5bwJYCxRWmjnCXWv1QdkA==
X-CSE-MsgGUID: TapG7U8ERfKWAAWBTcaOaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149695932"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:48 -0700
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
Subject: [PATCH net-next 08/15] ice: clear time_sync_en field for E825-C during reprogramming
Date: Wed, 18 Jun 2025 10:42:20 -0700
Message-ID: <20250618174231.3100231-9-anthony.l.nguyen@intel.com>
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

When programming the Clock Generation Unit for E285-C hardware, we need
to clear the time_sync_en bit of the DWORD 9 before we set the
frequency.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 2cc728c2b678..8de1ad1da834 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -285,6 +285,11 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
 	}
 
+	if (dw9.time_sync_en) {
+		dw9.time_sync_en = 0;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
+	}
+
 	/* Set the frequency */
 	dw9.time_ref_freq_sel = clk_freq;
 
@@ -296,6 +301,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		dw9.time_ref_en = 1;
 		dw9.clk_eref0_en = 0;
 	}
+	dw9.time_sync_en = 1;
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
 
 	/* Choose the referenced frequency */
-- 
2.47.1


