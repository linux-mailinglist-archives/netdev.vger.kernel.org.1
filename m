Return-Path: <netdev+bounces-82181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63B88C915
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8324F326170
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272613CC56;
	Tue, 26 Mar 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+FNxRVp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05F13D276
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470271; cv=none; b=o0tyXx5WnyHZIK334aAW5yUvElU+fm9Z2tMmn5eUTUPKeprCfCCHI6YMqzSVVpsMAPfYWRUsuYddvvZ+6dX7GGVeCh2YLikdUkd1x3d955GMFaaMSEj8JK9zBuxBF1eYoWXwYP4T6C9LwB0eLMkhXeQb1JwkbmxqleTU3UlF3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470271; c=relaxed/simple;
	bh=W9j+uHAz/M06o1V2KVd2LMoxJsS3CRjj3D7GD6FgCAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ5tNBaK36n4kq3wk8Ooyef1+674UOXlOM6OxPzF8bIQ7/5lyhimWWEcp7VGfqYyVgjaCR6DJZuwiIj6I6TCYpGzZYsrpP99EvoSppvOrlDGOsrclKE64S1kYg6g/ak3BJRIk7K502WjSkkj1B2+5wpwr/1D6u6xmC4bjaGrbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+FNxRVp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470269; x=1743006269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W9j+uHAz/M06o1V2KVd2LMoxJsS3CRjj3D7GD6FgCAI=;
  b=V+FNxRVptQkJWBsif2OGXmDqf6NuoC0zFPeDQIylASQ25m8CKblbezeJ
   hpHRvdp3B2jdirPp0fPs87bku0PumNeok/m7R6lbwcP6xI29T/C1yekHu
   FGNckL3ysseSZTIC0rSWTTC7c0+N3OgfB9XaNosvnMFmADYrimcLjqdhO
   an7iYhDYzNe4qdf9Wv+R6FTkKvs6yAUv1J2OnBf7dBXPjMa6uw5DklGK9
   DkPY+5UKJ4+PZ3Ra8TrKYwz57Me2Fo72ug4/YGmtO2LcDmUPBPp6ih/an
   DQrzhypRTBAVhFKJLiXAQjETAB5pqB4Vb/mUOTsZD95inSZvpHUvFNkz+
   w==;
X-CSE-ConnectionGUID: zkZhNYZNR/q6Usk6HRUSyg==
X-CSE-MsgGUID: hZy9C9LyQGKnSXnLrrd8mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6725064"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6725064"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20729306"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 09:24:27 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 12/12] ice: Adjust PTP init for 2x50G E825C devices
Date: Tue, 26 Mar 2024 17:22:33 +0100
Message-ID: <20240326162339.146053-26-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326162339.146053-14-karol.kolacinski@intel.com>
References: <20240326162339.146053-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

From FW/HW perspective, 2 port topology in E825C devices requires
merging of 2 port mapping internally to CPK and breakout mapping
externally to CPK. As a consequence, it requires different port
numbering from PTP code perspective.
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
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  5 ++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 23 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  9 ++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index cfac1d432c15..26260eed852d 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -157,6 +157,8 @@
 #define GLGEN_RTRIG_CORER_M			BIT(0)
 #define GLGEN_RTRIG_GLOBR_M			BIT(1)
 #define GLGEN_STAT				0x000B612C
+#define GLGEN_SWITCH_MODE_CONFIG		0x000B81E0
+#define GLGEN_SWITCH_MODE_CONFIG_SELECT_25X4_ON_SINGLE_QUAD_M BIT(2)
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
index 14c53b8a60e3..6da2f162753d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1491,6 +1491,8 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 		return;
 
 	ptp_port = &pf->ptp.port;
+	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
+		port *= 2;
 	if (WARN_ON_ONCE(ptp_port->port_num != port))
 		return;
 
@@ -3354,6 +3356,9 @@ void ice_ptp_init(struct ice_pf *pf)
 	}
 
 	ptp->port.port_num = hw->pf_id;
+	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
+		ptp->port.port_num = hw->pf_id * 2;
+
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
 		goto err;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 64a496dd553b..b7448153ea3f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2463,6 +2463,27 @@ static int ice_get_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw, u8 port,
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
+	mux = FIELD_GET(GLGEN_SWITCH_MODE_CONFIG_SELECT_25X4_ON_SINGLE_QUAD_M,
+			val);
+	val = rd32(hw, GLGEN_MAC_LINK_TOPO);
+	link_topo = FIELD_GET(GLGEN_MAC_LINK_TOPO_LINK_TOPO_M, val);
+
+	return (mux && link_topo == ICE_LINK_TOPO_UP_TO_2_LINKS);
+}
+
 /**
  * ice_ptp_init_phy_e825c - initialize PHY parameters
  * @hw: pointer to the HW struct
@@ -2495,6 +2516,8 @@ static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
 			return;
 		}
 	}
+
+	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
 }
 
 /* E822 family functions
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index e019dad56819..c5b2ad113d1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -851,6 +851,14 @@ enum ice_phy_model {
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
@@ -858,6 +866,7 @@ struct ice_ptp_hw {
 	u8 ports_per_phy;
 	bool primary_nac;
 	struct ice_hw *primary_hw;
+	bool is_2x50g_muxed_topo;
 };
 
 /* Port hardware description */
-- 
2.43.0


