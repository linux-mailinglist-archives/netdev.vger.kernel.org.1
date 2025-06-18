Return-Path: <netdev+bounces-199268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3779FADF963
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789371BC0731
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D373228002C;
	Wed, 18 Jun 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhCbLSFT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E727F74E
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285510; cv=none; b=nR1ns+IWvTIL67CjpxGxwdS+I1MbMlAtqSGNCYd0yvuDOEV1XVIHgIgsEB6g4ypKHFpQY6iuqtDa41L58l5wDeQXLzinqokcmsVs9h/64FAIvlkf7yymDFMNNBe/JvK9+asEoaMjHpj1q5tE1Fp0zNGovp8n/LeCDSjnpoP2Jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285510; c=relaxed/simple;
	bh=01edmvdye+A2A3p3Nes/FGzi4ZU7AR2pXTGXrPAL64o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLSVBrrYMFtk/A1t2r4k8aNUqNGTdrzIIBki95g9kwYvDlYbFY5XmiLpGDT+igbMxKB/hcnoA2ki8HGfiAnG4Bmh7Rv+sZKgo8Zy0+BQ+3n2ySpBRlktnB42ngjWW4Wa7FczS11PbWI+XO6z+2xsjYtzoc7sBvuAjkz7eyJkbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhCbLSFT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750285509; x=1781821509;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=01edmvdye+A2A3p3Nes/FGzi4ZU7AR2pXTGXrPAL64o=;
  b=lhCbLSFTkXGrB/wVPxsa+VTJOpZKcEp/Mg8i2At8qnXkpJuC8zg11ikv
   wEXjuKlBemBmLHQI0lCixx12h2EMCAQlvf/b72CuRNc+7QpZx0knTJZrf
   HZLFjS34R04ZNyPp9l5q4wlv/yRUvzozn+NZzYWVyEHb4VcWzHF7qQVog
   scE8E84z050yxKWcUFV/Q+BGt54y+TGurTY05QLwb/hFqV2+vdIMclTl8
   5F8KBZ6PW7K1AlE7son+Blnj7uSt9ITYanMLMZLQ0zPXaaQSA4hyCS8w2
   9SMrXnIfqfn1qUD2sVOn3MUx9wesEuTyjLIi4PJW6NOyjDFLkFlUsZF4L
   w==;
X-CSE-ConnectionGUID: SKn0aKgPRGGbO+KlA5m80A==
X-CSE-MsgGUID: usqxJqMESBOfzf4SBab4nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52447739"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52447739"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:05 -0700
X-CSE-ConnectionGUID: GP+Y5Z6MRfmLSxiskrDuLw==
X-CSE-MsgGUID: Pw6mJoodTmypC6mFV/OJMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149870014"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 15:24:39 -0700
Subject: [PATCH iwl-next 4/8] ice: move ice_vsi_update_l2tsel to ice_lib.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-e810-live-migration-jk-migration-prep-v1-4-72a37485453e@intel.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
 Madhu Chittim <madhu.chittim@intel.com>, Yahui Cao <yahui.cao@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

A future change is going to need to call ice_vsi_update_l2tsel from a new
context outside of ice_virtchnl.c

Since this function deals with a generic VSI, move it into ice_lib.c to
enable calling it from other places in the ice driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.h      |  8 +++++
 drivers/net/ethernet/intel/ice/ice_lib.c      | 35 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 42 ---------------------------
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 654516c5fc3ededf99d3aa9574a546177295a716..2cb1eb98b9dabc63c44aa20f04acb19040df56f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -11,6 +11,13 @@
 #define ICE_VSI_FLAG_INIT	BIT(0)
 #define ICE_VSI_FLAG_NO_INIT	0
 
+#define ICE_L2TSEL_QRX_CONTEXT_REG_IDX	3
+#define ICE_L2TSEL_BIT_OFFSET		23
+enum ice_l2tsel {
+	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND,
+	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1,
+};
+
 const char *ice_vsi_type_str(enum ice_vsi_type vsi_type);
 
 bool ice_pf_state_is_nominal(struct ice_pf *pf);
@@ -116,4 +123,5 @@ void ice_set_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
+void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel);
 #endif /* !_ICE_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1ea9863a387be14b34a6705c44bc5b6361a808bc..d75836700889151d856157226eb2d3a8e50b1b34 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4020,3 +4020,38 @@ ice_vsi_update_local_lb(struct ice_vsi *vsi, bool set)
 	vsi->info = ctx.info;
 	return 0;
 }
+
+/**
+ * ice_vsi_update_l2tsel - update l2tsel field for all Rx rings on this VSI
+ * @vsi: VSI used to update l2tsel on
+ * @l2tsel: l2tsel setting requested
+ *
+ * Use the l2tsel setting to update all of the Rx queue context bits for l2tsel.
+ * This will modify which descriptor field the first offloaded VLAN will be
+ * stripped into.
+ */
+void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	u32 l2tsel_bit;
+	int i;
+
+	if (l2tsel == ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND)
+		l2tsel_bit = 0;
+	else
+		l2tsel_bit = BIT(ICE_L2TSEL_BIT_OFFSET);
+
+	for (i = 0; i < vsi->alloc_rxq; i++) {
+		u16 pfq = vsi->rxq_map[i];
+		u32 qrx_context_offset;
+		u32 regval;
+
+		qrx_context_offset =
+			QRX_CONTEXT(ICE_L2TSEL_QRX_CONTEXT_REG_IDX, pfq);
+
+		regval = rd32(hw, qrx_context_offset);
+		regval &= ~BIT(ICE_L2TSEL_BIT_OFFSET);
+		regval |= l2tsel_bit;
+		wr32(hw, qrx_context_offset, regval);
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 65eb6757a02143f3765716dedcd090dff2d84d2c..691ebb143e75863d25d6c0fbd1f0f330b363f919 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3845,48 +3845,6 @@ ice_vc_ena_vlan_offload(struct ice_vsi *vsi,
 	return 0;
 }
 
-#define ICE_L2TSEL_QRX_CONTEXT_REG_IDX	3
-#define ICE_L2TSEL_BIT_OFFSET		23
-enum ice_l2tsel {
-	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND,
-	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1,
-};
-
-/**
- * ice_vsi_update_l2tsel - update l2tsel field for all Rx rings on this VSI
- * @vsi: VSI used to update l2tsel on
- * @l2tsel: l2tsel setting requested
- *
- * Use the l2tsel setting to update all of the Rx queue context bits for l2tsel.
- * This will modify which descriptor field the first offloaded VLAN will be
- * stripped into.
- */
-static void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
-{
-	struct ice_hw *hw = &vsi->back->hw;
-	u32 l2tsel_bit;
-	int i;
-
-	if (l2tsel == ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND)
-		l2tsel_bit = 0;
-	else
-		l2tsel_bit = BIT(ICE_L2TSEL_BIT_OFFSET);
-
-	for (i = 0; i < vsi->alloc_rxq; i++) {
-		u16 pfq = vsi->rxq_map[i];
-		u32 qrx_context_offset;
-		u32 regval;
-
-		qrx_context_offset =
-			QRX_CONTEXT(ICE_L2TSEL_QRX_CONTEXT_REG_IDX, pfq);
-
-		regval = rd32(hw, qrx_context_offset);
-		regval &= ~BIT(ICE_L2TSEL_BIT_OFFSET);
-		regval |= l2tsel_bit;
-		wr32(hw, qrx_context_offset, regval);
-	}
-}
-
 /**
  * ice_vc_ena_vlan_stripping_v2_msg
  * @vf: VF the message was received from

-- 
2.48.1.397.gec9d649cc640


