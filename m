Return-Path: <netdev+bounces-205948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF1B00E0D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561AC4E7178
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D5293C49;
	Thu, 10 Jul 2025 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaUw3EVu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F328C5D7
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183930; cv=none; b=Dz05v4+zvwUKTh9qaUCIBXf0BNZaeYHrdQKa7mMrroJ/kOAFy0HDwkKvd6GNGvtMjc15Yv0pxs5vu3NQvfKV5EluODLmInnMvd5su2zbGg/zrSuo1MYEEUVJ4TB76XUMnCwF3v51+iHSA1BB5ibEcPmVU5CJ5N4BnHPOu22yEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183930; c=relaxed/simple;
	bh=MygzWOTDA7UX2BwDbEodU/cuDRwq8KwrXWE+XmhXeBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFeVYd3DPVB05kFk5dmzIKnwSHIP4KcMh3eNsq4SD/seVdN+Yb+kqBwWpjIryDJpUVk+xDIu1rYI2zmv+K/OtKW5r3Sv3rAMDPty6FirZwbfwNwr9a9t4J8oKMWGbSun2g3ZruLac3K/0n8a5r3rNYcLkda1ZcwlFJHn5SVcCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaUw3EVu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183929; x=1783719929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MygzWOTDA7UX2BwDbEodU/cuDRwq8KwrXWE+XmhXeBQ=;
  b=TaUw3EVuk2JyHtMeCrJcJX9UFdthth/xFijEdEAk7yTPkgGEX7XKf/5L
   HjQhYk04g/ghlRSkQ6v2/fnrUCd8ylhns3OoYzN+mZ6andoPfg2q0No3g
   Aj6oWmtHnD0eotQLEDHnwo+gwedTxAjIbERNryufugqamiJeboM8n52gJ
   E1GY4ZIcQQrHgb7J+PMnRxR4wa4mfNJh4r+3K264QtyPiwctB2xc+fyYW
   Lei7qja3Xxehs1GkmnndTGZg6dnASSOncpYPq7efbOX+bz8DPuF4/YUe5
   G+74VQvweEi+LizJ3oNS1af4+7C2ZIzPi841wWvnEOWHDBrbRxgZq9B/U
   w==;
X-CSE-ConnectionGUID: 6PpJh2aeRJihY8dCNMUtxw==
X-CSE-MsgGUID: +KYx+ZLoSf6KKpKa+djV8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192366"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:27 -0700
X-CSE-ConnectionGUID: ld3OF/vnTyKypx8fOSFkSA==
X-CSE-MsgGUID: ICE7prvBRbyR15C+TSZ2cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764947"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	yahui.cao@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next 4/8] ice: move ice_vsi_update_l2tsel to ice_lib.c
Date: Thu, 10 Jul 2025 14:45:13 -0700
Message-ID: <20250710214518.1824208-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
References: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

A future change is going to need to call ice_vsi_update_l2tsel from a new
context outside of ice_virtchnl.c

Since this function deals with a generic VSI, move it into ice_lib.c to
enable calling it from other places in the ice driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c      | 35 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h      |  8 ++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 42 -------------------
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 2f1782e9357f..1be1e429a7c8 100644
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
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 654516c5fc3e..2cb1eb98b9da 100644
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
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 0a8f15ecac1f..307252500f02 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3860,48 +3860,6 @@ ice_vc_ena_vlan_offload(struct ice_vsi *vsi,
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
2.47.1


