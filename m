Return-Path: <netdev+bounces-85707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C11489BDFE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3981C20E22
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352626A337;
	Mon,  8 Apr 2024 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IR1G4N3c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DA6A32F
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575128; cv=none; b=WBuKdf4Hla4eqWEHY+wfuQI14KG6Yu5mJ/zlj00On0kadaBrjz95BSeX2LOijhRuW+A9Kt+CpYguXqKlwmh1+8VqgUMlmlpKBJ/TqK6EfAp4lVlMdX5BKPo9iwQoRo0xTCFq6SzRSDitGfRio0so41CP/sa8YpdAzHMSNJI/XeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575128; c=relaxed/simple;
	bh=tD7rAzaUCs6+G8XM/vaND6K1eBFXUIxKHfOl04kvuJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t88d4Df0y8kn3becgqWUNzYyleLXQx8Cw+Mmfjz3kMd5+JgUUzQXsKGe4cQII+57tn11YiLEQMiV0a6mrjSqAcZiFpyeMIFpgcHJAOD+jA+HWCmhVgTq2zufM2IkZdoOme9VV5svgIIoGNeV1hLDSfJBkRuzE1mrMGzdO9E+IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IR1G4N3c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712575126; x=1744111126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tD7rAzaUCs6+G8XM/vaND6K1eBFXUIxKHfOl04kvuJ0=;
  b=IR1G4N3c7BJmBGaD5IrOfTLKsFsukByrxIKnT8cNgrkhfVSSjxySUlV2
   d5vSegZsmbHX4HsjzFG8jK5wX2K8zkHgQVyj4a12wnu2EgGElG43PKo2/
   dSEd9Cod2CKNdN7neLX/tJ0TaavC4+iqmSVuRpD1ycHmhYO1oy72EJ8Un
   1L5xtIUH0Ze96Qzt9lKNPKInLdOSGQ6W1jNMplCJTdMt3887Am4YTnUrJ
   tJ5F1jwiMN0jVXmdaP6AO7Ps5M7zHDcY+6xW9oED4wQCWqMPQwSkLL6kR
   9PEki2mywSjBUefzfFB8GscJW8HuPrpyXHlY+Qn7wJSRlZPH41rBto8Yg
   w==;
X-CSE-ConnectionGUID: DuKt+lnST4m/yVPZeNEBEg==
X-CSE-MsgGUID: BwQW43wORx+/raO+RIjvNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18988628"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="18988628"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 04:18:46 -0700
X-CSE-ConnectionGUID: 5a4yEXWnRIuFOyAFSi5INw==
X-CSE-MsgGUID: nIEj/x6BTbms1YPMZ4MyDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19904958"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa009.fm.intel.com with ESMTP; 08 Apr 2024 04:18:44 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 12/12] ice: Adjust PTP init for 2x50G E825C devices
Date: Mon,  8 Apr 2024 13:07:33 +0200
Message-ID: <20240408111814.404583-26-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408111814.404583-14-karol.kolacinski@intel.com>
References: <20240408111814.404583-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

From FW/HW perspective, 2 port topology in E825C devices requires
merging of 2 port mapping internally and breakout mapping externally.
As a consequence, it requires different port numbering from PTP code
perspective.
For that topology, pf_id can not be used to index PTP ports. Even if
the 2nd port is identified as port with pf_id = 1, all PHY operations
need to be performed as it was port 2. Thus, special mapping is needed
for the 2nd port.
This change adds detection of 2x50G topology and applies 'custom'
mapping on the 2nd port.

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V4 -> V5: - reworded commit mesage
          - renamed GLGEN_SWITCH_MODE_CONFIG_SELECT_25X4_ON_SINGLE_QUAD_M to
            GLGEN_SWITCH_MODE_CONFIG_25X4_QUAD_M

 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  5 +++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 22 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  9 ++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index cfac1d432c15..91cbae1eec89 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -157,6 +157,8 @@
 #define GLGEN_RTRIG_CORER_M			BIT(0)
 #define GLGEN_RTRIG_GLOBR_M			BIT(1)
 #define GLGEN_STAT				0x000B612C
+#define GLGEN_SWITCH_MODE_CONFIG		0x000B81E0
+#define GLGEN_SWITCH_MODE_CONFIG_25X4_QUAD_M	BIT(2)
 #define GLGEN_VFLRSTAT(_i)			(0x00093A04 + ((_i) * 4))
 #define PFGEN_CTRL				0x00091000
 #define PFGEN_CTRL_PFSWR_M			BIT(0)
@@ -177,6 +179,8 @@
 #define GLINT_CTL_ITR_GRAN_50_M			ICE_M(0xF, 24)
 #define GLINT_CTL_ITR_GRAN_25_S			28
 #define GLINT_CTL_ITR_GRAN_25_M			ICE_M(0xF, 28)
+#define GLGEN_MAC_LINK_TOPO			0x000B81DC
+#define GLGEN_MAC_LINK_TOPO_LINK_TOPO_M		GENMASK(1, 0)
 #define GLINT_DYN_CTL(_INT)			(0x00160000 + ((_INT) * 4))
 #define GLINT_DYN_CTL_INTENA_M			BIT(0)
 #define GLINT_DYN_CTL_CLEARPBA_M		BIT(1)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 29a86fcfd312..71b19fcb7d14 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1470,6 +1470,8 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 		return;
 
 	ptp_port = &pf->ptp.port;
+	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
+		port *= 2;
 	if (WARN_ON_ONCE(ptp_port->port_num != port))
 		return;
 
@@ -3327,6 +3329,9 @@ void ice_ptp_init(struct ice_pf *pf)
 	}
 
 	ptp->port.port_num = hw->pf_id;
+	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
+		ptp->port.port_num = hw->pf_id * 2;
+
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
 		goto err;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 5d42ca771117..bfdb640fde57 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2456,6 +2456,26 @@ static int ice_get_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw, u8 port,
 	return 0;
 }
 
+/**
+ * ice_is_muxed_topo - detect breakout 2x50G topology for E825C
+ * @hw: pointer to the HW struct
+ *
+ * Returns: true if it's 2x50 breakout topology, false otherwise
+ */
+static bool ice_is_muxed_topo(struct ice_hw *hw)
+{
+	u8 link_topo;
+	bool mux;
+	u32 val;
+
+	val = rd32(hw, GLGEN_SWITCH_MODE_CONFIG);
+	mux = FIELD_GET(GLGEN_SWITCH_MODE_CONFIG_25X4_QUAD_M, val);
+	val = rd32(hw, GLGEN_MAC_LINK_TOPO);
+	link_topo = FIELD_GET(GLGEN_MAC_LINK_TOPO_LINK_TOPO_M, val);
+
+	return (mux && link_topo == ICE_LINK_TOPO_UP_TO_2_LINKS);
+}
+
 /**
  * ice_ptp_init_phy_e825c - initialize PHY parameters
  * @hw: pointer to the HW struct
@@ -2488,6 +2508,8 @@ static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
 			return;
 		}
 	}
+
+	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
 }
 
 /* E822 family functions
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index abce7a8786f3..9228ff31dbae 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -853,6 +853,14 @@ enum ice_phy_model {
 	ICE_PHY_ETH56G,
 };
 
+/* Global Link Topology */
+enum ice_global_link_topo {
+	ICE_LINK_TOPO_UP_TO_2_LINKS,
+	ICE_LINK_TOPO_UP_TO_4_LINKS,
+	ICE_LINK_TOPO_UP_TO_8_LINKS,
+	ICE_LINK_TOPO_RESERVED,
+};
+
 struct ice_ptp_hw {
 	enum ice_phy_model phy_model;
 	union ice_phy_params phy;
@@ -860,6 +868,7 @@ struct ice_ptp_hw {
 	u8 ports_per_phy;
 	bool primary_nac;
 	struct ice_hw *primary_hw;
+	bool is_2x50g_muxed_topo;
 };
 
 /* Port hardware description */
-- 
2.43.0


