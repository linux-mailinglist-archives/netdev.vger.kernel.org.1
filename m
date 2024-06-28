Return-Path: <netdev+bounces-107825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9791C73E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF751F269CA
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D274061;
	Fri, 28 Jun 2024 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDsX4eGD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48E58AD0
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605881; cv=none; b=dCP7tY2AzinEWTSS9bFGf3Qtq//eMzAqzIWOUikLFsBMzy1SR5CC8JKhwNxIYTTv1/5PCXV3F6V6Ii/ckQ5QEU4SqBia7/8OVvDv0QEc1AcqXzSQMfRCdZRpmLPofLFzL/qM7OsfRFryhaAg2HYVafcm5oSwU6/RKk5AVLfdyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605881; c=relaxed/simple;
	bh=e8PiW+scgr5Mkdj5iE+pRbAQrE/T+r2hkSbd+2ez/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZknwzyXuO//qfiZ4rs3riCJ0IZqW8JMT/meA+gbHTmDwTHZgYNcxffA13zQ8RLnmwZNnUU0NAs1V7hKEX27hbbBKb2v3Tg6eTKrNeCEMJfJFCXicNkwSYZqryf7Cb0dfk/rBKwF9kExE+yjQeo7fnoWuNrlEwamSc4kddMO4ivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDsX4eGD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605880; x=1751141880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e8PiW+scgr5Mkdj5iE+pRbAQrE/T+r2hkSbd+2ez/kw=;
  b=FDsX4eGDkYQy+MYK3YIhGy8xknUd3uriDMXleyu+rcT/K4+apBgqp/wt
   xMnFIn6WZlX0iVgRXOzERgQ1p0OaBswt25Pt9anjTnVxZTDWkObFX5l5F
   Fn3BuFhH90i02iS+o2zHwTMgQpOaOaQ6iiTnbzXSMo5vfshKmpPEE5CkE
   7PG7R8tb2pIM3l9X15337AvYR3BfY8RnIz9Jg4i8X5RWrUhqUTQD3SLqE
   ou6hIBhsUYTLgd1TwPc2c9BLdyQIIVK/ebfmO3qjjgk17yQUzbSM54jxx
   vHm/HYzwbod8CbgQCfgJCQZOogl4ZUx8M2J8CwvYcvJxerqZMgN2AljIx
   Q==;
X-CSE-ConnectionGUID: 4OCgqOKlQjmv4Y3t7pC7xA==
X-CSE-MsgGUID: i2r5nUMuRJ2yK7BELW/A/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16623452"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16623452"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:18:00 -0700
X-CSE-ConnectionGUID: KjepFoErRB62DZ5ddrnAjQ==
X-CSE-MsgGUID: Sa0jD7ZESOOnsXO+eeovYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44676046"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 13:17:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: [PATCH net] e1000e: Fix S0ix residency on corporate systems
Date: Fri, 28 Jun 2024 13:17:53 -0700
Message-ID: <20240628201754.2744221-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

On vPro systems, the configuration of the I219-LM to achieve power
gating and S0ix residency is split between the driver and the CSME FW.
It was discovered that in some scenarios, where the network cable is
connected and then disconnected, S0ix residency is not always reached.
This was root-caused to a subset of I219-LM register writes that are not
performed by the CSME FW. Therefore, the driver should perform these
register writes on corporate setups, regardless of the CSME FW state.

This was discovered on Meteor Lake systems; however it is likely to
appear on other platforms as well.

Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218589
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 132 ++++++++++-----------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index da5c59daf8ba..3cd161c6672b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6363,49 +6363,49 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 		mac_data |= E1000_EXTCNF_CTRL_GATE_PHY_CFG;
 		ew32(EXTCNF_CTRL, mac_data);
 
-		/* Enable the Dynamic Power Gating in the MAC */
-		mac_data = er32(FEXTNVM7);
-		mac_data |= BIT(22);
-		ew32(FEXTNVM7, mac_data);
-
 		/* Disable disconnected cable conditioning for Power Gating */
 		mac_data = er32(DPGFR);
 		mac_data |= BIT(2);
 		ew32(DPGFR, mac_data);
 
-		/* Don't wake from dynamic Power Gating with clock request */
-		mac_data = er32(FEXTNVM12);
-		mac_data |= BIT(12);
-		ew32(FEXTNVM12, mac_data);
-
-		/* Ungate PGCB clock */
-		mac_data = er32(FEXTNVM9);
-		mac_data &= ~BIT(28);
-		ew32(FEXTNVM9, mac_data);
-
-		/* Enable K1 off to enable mPHY Power Gating */
-		mac_data = er32(FEXTNVM6);
-		mac_data |= BIT(31);
-		ew32(FEXTNVM6, mac_data);
-
-		/* Enable mPHY power gating for any link and speed */
-		mac_data = er32(FEXTNVM8);
-		mac_data |= BIT(9);
-		ew32(FEXTNVM8, mac_data);
-
 		/* Enable the Dynamic Clock Gating in the DMA and MAC */
 		mac_data = er32(CTRL_EXT);
 		mac_data |= E1000_CTRL_EXT_DMA_DYN_CLK_EN;
 		ew32(CTRL_EXT, mac_data);
-
-		/* No MAC DPG gating SLP_S0 in modern standby
-		 * Switch the logic of the lanphypc to use PMC counter
-		 */
-		mac_data = er32(FEXTNVM5);
-		mac_data |= BIT(7);
-		ew32(FEXTNVM5, mac_data);
 	}
 
+	/* Enable the Dynamic Power Gating in the MAC */
+	mac_data = er32(FEXTNVM7);
+	mac_data |= BIT(22);
+	ew32(FEXTNVM7, mac_data);
+
+	/* Don't wake from dynamic Power Gating with clock request */
+	mac_data = er32(FEXTNVM12);
+	mac_data |= BIT(12);
+	ew32(FEXTNVM12, mac_data);
+
+	/* Ungate PGCB clock */
+	mac_data = er32(FEXTNVM9);
+	mac_data &= ~BIT(28);
+	ew32(FEXTNVM9, mac_data);
+
+	/* Enable K1 off to enable mPHY Power Gating */
+	mac_data = er32(FEXTNVM6);
+	mac_data |= BIT(31);
+	ew32(FEXTNVM6, mac_data);
+
+	/* Enable mPHY power gating for any link and speed */
+	mac_data = er32(FEXTNVM8);
+	mac_data |= BIT(9);
+	ew32(FEXTNVM8, mac_data);
+
+	/* No MAC DPG gating SLP_S0 in modern standby
+	 * Switch the logic of the lanphypc to use PMC counter
+	 */
+	mac_data = er32(FEXTNVM5);
+	mac_data |= BIT(7);
+	ew32(FEXTNVM5, mac_data);
+
 	/* Disable the time synchronization clock */
 	mac_data = er32(FEXTNVM7);
 	mac_data |= BIT(31);
@@ -6498,33 +6498,6 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	} else {
 		/* Request driver unconfigure the device from S0ix */
 
-		/* Disable the Dynamic Power Gating in the MAC */
-		mac_data = er32(FEXTNVM7);
-		mac_data &= 0xFFBFFFFF;
-		ew32(FEXTNVM7, mac_data);
-
-		/* Disable mPHY power gating for any link and speed */
-		mac_data = er32(FEXTNVM8);
-		mac_data &= ~BIT(9);
-		ew32(FEXTNVM8, mac_data);
-
-		/* Disable K1 off */
-		mac_data = er32(FEXTNVM6);
-		mac_data &= ~BIT(31);
-		ew32(FEXTNVM6, mac_data);
-
-		/* Disable Ungate PGCB clock */
-		mac_data = er32(FEXTNVM9);
-		mac_data |= BIT(28);
-		ew32(FEXTNVM9, mac_data);
-
-		/* Cancel not waking from dynamic
-		 * Power Gating with clock request
-		 */
-		mac_data = er32(FEXTNVM12);
-		mac_data &= ~BIT(12);
-		ew32(FEXTNVM12, mac_data);
-
 		/* Cancel disable disconnected cable conditioning
 		 * for Power Gating
 		 */
@@ -6537,13 +6510,6 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 		mac_data &= 0xFFF7FFFF;
 		ew32(CTRL_EXT, mac_data);
 
-		/* Revert the lanphypc logic to use the internal Gbe counter
-		 * and not the PMC counter
-		 */
-		mac_data = er32(FEXTNVM5);
-		mac_data &= 0xFFFFFF7F;
-		ew32(FEXTNVM5, mac_data);
-
 		/* Enable the periodic inband message,
 		 * Request PCIe clock in K1 page770_17[10:9] =01b
 		 */
@@ -6581,6 +6547,40 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	mac_data &= ~BIT(31);
 	mac_data |= BIT(0);
 	ew32(FEXTNVM7, mac_data);
+
+	/* Disable the Dynamic Power Gating in the MAC */
+	mac_data = er32(FEXTNVM7);
+	mac_data &= 0xFFBFFFFF;
+	ew32(FEXTNVM7, mac_data);
+
+	/* Disable mPHY power gating for any link and speed */
+	mac_data = er32(FEXTNVM8);
+	mac_data &= ~BIT(9);
+	ew32(FEXTNVM8, mac_data);
+
+	/* Disable K1 off */
+	mac_data = er32(FEXTNVM6);
+	mac_data &= ~BIT(31);
+	ew32(FEXTNVM6, mac_data);
+
+	/* Disable Ungate PGCB clock */
+	mac_data = er32(FEXTNVM9);
+	mac_data |= BIT(28);
+	ew32(FEXTNVM9, mac_data);
+
+	/* Cancel not waking from dynamic
+	 * Power Gating with clock request
+	 */
+	mac_data = er32(FEXTNVM12);
+	mac_data &= ~BIT(12);
+	ew32(FEXTNVM12, mac_data);
+
+	/* Revert the lanphypc logic to use the internal Gbe counter
+	 * and not the PMC counter
+	 */
+	mac_data = er32(FEXTNVM5);
+	mac_data &= 0xFFFFFF7F;
+	ew32(FEXTNVM5, mac_data);
 }
 
 static int e1000e_pm_freeze(struct device *dev)
-- 
2.41.0


