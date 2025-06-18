Return-Path: <netdev+bounces-199183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952ACADF4EF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026D31BC358C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D13085B8;
	Wed, 18 Jun 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNI70Ni/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CC307AFF
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268578; cv=none; b=Cbs2EeNzLtiKNBZLlpIF7Hv/o7RzE7oIrmH8zLFkTdcT0JhJt/MTJC/MCL6x4EuI2MBIQmuHBN4BFtTrcCreA4ANPPd79jz8EObkVK/vI5H6h5DbwOf4k3pP47to5wPTU8C5bJQnv6xHcI4mA6ooPhrUgxARBFCXznjw5vVfO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268578; c=relaxed/simple;
	bh=FXhm67LmU6WilAzE0Azu4+miuC0Fd+mwTqI2UG+CS6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuyibmWkqzVPS+XvOsfSiAieiIeVrJa2fW54+2Tvhgp6W9CSOsgMJfWPlU7H2aA4blIkYVfzutqWYswsVK2EzJ+1GUBhO56ddHC2iMZoFoJzWhsnczNqSZLv8TTrl3VPxNg0w7h4fGLq8L15bbo/HQ+a0SIz/YWAWLfqx+s81G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNI70Ni/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268576; x=1781804576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXhm67LmU6WilAzE0Azu4+miuC0Fd+mwTqI2UG+CS6A=;
  b=PNI70Ni/Km5C0RRBXfFa/H/EhcOYj5gHyvsWt1mXlazB2bhdQZZ9KTUS
   9Xo8ny17kxzRMDAxGd/iZOHX2u0zW9fhuMV3TiF0gQLQwUgGegyR5RRMK
   2YD0vSmBL2ubqXT4F0v8S0w2Bps+UJ36qz+NT+czw/kVlDEEEmiJo4GCi
   Wjl0jywSg6ccr6k1a7VkAIAiPyXX0+PJksbNTcNYL6HDtYwPNqTAHiUAs
   T2QJPi1XthyiAU9B2FXgWoDRfL4uI/jX7VNb68vw5bw+RGQto2/iRZ3bA
   hH7Ls14jn1emLCjdmrWZmQLFQzlBYmBqD8x+TiDHWt1fy1+MIRF/flcst
   Q==;
X-CSE-ConnectionGUID: A9bg+3F2RN+6Kl63mQPHcQ==
X-CSE-MsgGUID: ReWIO9YZTpiJlkJXannWFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183762"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183762"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:53 -0700
X-CSE-ConnectionGUID: UeAEPbiNQoeICEtw8MjX9w==
X-CSE-MsgGUID: dG488fpCQ9Cfh9piFImyMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149696008"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:52 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 13/15] ice: fall back to TCXO on TSPLL lock fail
Date: Wed, 18 Jun 2025 10:42:25 -0700
Message-ID: <20250618174231.3100231-14-anthony.l.nguyen@intel.com>
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

TSPLL can fail when trying to lock to TIME_REF as a clock source, e.g.
when the external clock source is not stable or connected to the board.
To continue operation after failure, try to lock again to internal TCXO
and inform user about this.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index a392b39920ae..7b61e1afe8b4 100644
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
2.47.1


