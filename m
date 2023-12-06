Return-Path: <netdev+bounces-54592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE28078AA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEDC1C20F7F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8769447F4B;
	Wed,  6 Dec 2023 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgt0Me/i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491F1BD
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701890971; x=1733426971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EtbxV+3dlFDlLU6eavI4GmCtRiztOc0sM01SAKbVkjA=;
  b=Kgt0Me/iqg6PyCluZaXFscP/C1lb1vmbAMGvgBeV2jhpBOPvRX/NLNsU
   m/+LxAzZTrrlxTxNJnfmy8ESr/LdrszC3wdse1e1N8RNPvDhBcQA9gC/1
   /i7pMTY/jKoxqqvGfpBg5JzxmOlkiitrhooBOKmqk2TyJyjmwUMgvJUEZ
   FWuDALTIu5hFTMYexTaGYScT4FXuvdf/4FdwsO1PeiswbVJuAkDgFbtx1
   Nrhkr7cBQEFwkPv2wRSK8BD4brnALBzIjmPHKI0AIOA5GeYqewddgY5P3
   +ag68xiup34OMQvbqTg5N3LJbHhNkE+6/CZJLmJKapoPYBpV24vJ57bLF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1214431"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1214431"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 11:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889446512"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889446512"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 11:29:29 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Subject: [PATCH iwl-next v1 2/3] ice:  Add helper function ice_is_generic_mac
Date: Wed,  6 Dec 2023 20:29:18 +0100
Message-Id: <20231206192919.3826128-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/ice/ice_common.c   | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_controlq.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0a519310472b..2a973fac8e54 100644
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
index 39be42ae3711..d0ef1fdd6493 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -111,6 +111,7 @@ ice_update_phy_type(u64 *phy_type_low, u64 *phy_type_high,
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
index 0c3b64f65a0d..71e6d1252df5 100644
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
index 1fff865d0661..935b1a3394de 100644
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
2.39.3


