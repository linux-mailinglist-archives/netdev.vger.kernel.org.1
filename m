Return-Path: <netdev+bounces-71082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C4851F40
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C191A1C21E13
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3274CDEB;
	Mon, 12 Feb 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nte+dJVF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0D4C622
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772333; cv=none; b=WIpTLkb0TAkSNBT/aPu7TkCLG93ne8DBJ/v15093TcuONENIIvTS2Q2tWGuThFCy+kuYcxHLNjfgtd2kTf+C7VHak3yiY6xHN6Ru0vrI5rvi7TfU3oo2tsGth7P61yiyF4xX0OU+uRq80P/xpzERe25/7CI30NYuvgfy+NOKHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772333; c=relaxed/simple;
	bh=Xht4Khms1kt3D+hw2e0/BEXuWnJQaVHGQ43X/fKioD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qr3mnlS4e5c8Yqj2kBdlUPuDzwHdQO61p2iW2MBk7TXf0x0hgioFu+bSVPvo6sa9CrmFqaOr5SUZz6Xo4lWWaQJ5+eViPcEYjwXP/Tffwz9Ln7LjtYLWL9mphpnSH0kCtUJxV9fE1saEcWaO+oQk4lcaEQJntRV1TGc5lnggEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nte+dJVF; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707772331; x=1739308331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xht4Khms1kt3D+hw2e0/BEXuWnJQaVHGQ43X/fKioD0=;
  b=Nte+dJVFjCx80jlvL4F7pMc235rnTSr+djW+YNklmNnruhr4+QE/WlTU
   Xj4Ww0VkKt4YqFKv5P9JY/Brof/jX6bEsW7V9iMVagA+XrFEpOjSJBunu
   3AbErnRLgxPQtOZ+023gDYeMcmGUgb38FolAbGw8Hl44nJqo8TUHJganS
   3LqXvF3Q4G8CRd4c0qVEeeHAFxxi9NaTCQ/riY44ss60ufK2xhzsYnkcd
   51ekQKdRd7hrh9SIxCFrljRtZL+Gm3cMEOzozIxl1wkCpUePdWq/tkopw
   V2ft190QrRux8tP4+MMGkV1eic5LfEkmhV6dhYQXeJelcoIxYK9lMPpQ5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436910913"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436910913"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7335614"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2024 13:12:07 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/5] ice: Add helper function ice_is_generic_mac
Date: Mon, 12 Feb 2024 13:11:56 -0800
Message-ID: <20240212211202.1051990-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
References: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

E800 series devices have a couple of quirks:
1. Sideband control queues are not supported
2. The registers that the driver needs to program for the "Precision
   Time Protocol (PTP)" feature are different for E800 series devices
   compared to other devices supported by this driver.

Both these require conditional logic based on the underlying device we
are dealing with.

The function ice_is_sbq_supported added by commit 8f5ee3c477a8
("ice: add support for sideband messages") addresses (1).
The same function can be used to address (2) as well
but this just looks weird readability wise in cases that have nothing
to do with sideband control queues:

	if (ice_is_sbq_supported(hw))
		/* program register A */
	else
		/* program register B */

For these cases, the function ice_is_generic_mac introduced by this
patch communicates the idea/intention better. Also rework
ice_is_sbq_supported to use this new function.
As side-band queue is supported for E825C devices, it's mac_type is
considered as generic mac_type.

Co-developed-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_controlq.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index cc8c9f2b72f5..a7e6e5c1d06e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -169,6 +169,18 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	return 0;
 }
 
+/**
+ * ice_is_generic_mac - check if device's mac_type is generic
+ * @hw: pointer to the hardware structure
+ *
+ * Return: true if mac_type is generic (with SBQ support), false if not
+ */
+bool ice_is_generic_mac(struct ice_hw *hw)
+{
+	return (hw->mac_type == ICE_MAC_GENERIC ||
+		hw->mac_type == ICE_MAC_GENERIC_3K_E825);
+}
+
 /**
  * ice_is_e810
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 42d45a73359c..32fd10de620c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -112,6 +112,7 @@ ice_update_phy_type(u64 *phy_type_low, u64 *phy_type_high,
 int
 ice_aq_manage_mac_write(struct ice_hw *hw, const u8 *mac_addr, u8 flags,
 			struct ice_sq_cd *cd);
+bool ice_is_generic_mac(struct ice_hw *hw);
 bool ice_is_e810(struct ice_hw *hw);
 int ice_clear_pf_cfg(struct ice_hw *hw);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index e7d2474c431c..ffe660f34992 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -666,7 +666,7 @@ bool ice_is_sbq_supported(struct ice_hw *hw)
 	/* The device sideband queue is only supported on devices with the
 	 * generic MAC type.
 	 */
-	return hw->mac_type == ICE_MAC_GENERIC;
+	return ice_is_generic_mac(hw);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b3c24e40ccb6..1fa3f40743f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1649,8 +1649,10 @@ static void ice_clean_sbq_subtask(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	/* Nothing to do here if sideband queue is not supported */
-	if (!ice_is_sbq_supported(hw)) {
+	/* if mac_type is not generic, sideband is not supported
+	 * and there's nothing to do here
+	 */
+	if (!ice_is_generic_mac(hw)) {
 		clear_bit(ICE_SIDEBANDQ_EVENT_PENDING, pf->state);
 		return;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index a508e917ce5f..9ff92dba5823 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -132,6 +132,7 @@ enum ice_mac_type {
 	ICE_MAC_E810,
 	ICE_MAC_E830,
 	ICE_MAC_GENERIC,
+	ICE_MAC_GENERIC_3K_E825,
 };
 
 /* Media Types */
-- 
2.41.0


