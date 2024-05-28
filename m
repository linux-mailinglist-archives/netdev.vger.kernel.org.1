Return-Path: <netdev+bounces-98815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A27378D2888
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0879BB250D8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BE1411DC;
	Tue, 28 May 2024 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTVIktSx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A5140389
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937461; cv=none; b=SzQE3P7YEEZQba9U9dHxOPzDMT3NRTWIO3OPgr0lrEDmxOHaOUQ/8dXXE/o/KF3oklGd6SmnGw+GfwZHe1Vw5+ff8yvuCuFSKC4h85WAgvRAfebgHITZBuug4S3V9LSVMUMKgQMqDJX/Wgq7ORLvlg4jZFPirRcLyDbUNOASMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937461; c=relaxed/simple;
	bh=Wwh570W2fWq0e6p7MFWYoVD3oDk6oPSy1NeIzCTqwBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TR6XmWGGyDx7/Iiwj2w/FN5hl2R2R3CMXH3yTmC0NBjv5sttCEdTDM4MakyVGtf9+J+dR65bXyg29B4KL/JROpRIEu6rjU79g0cMxMCG1Iy0Eye7bv4nB/aD9XFG178ziJtRSjZtguka71a0Q12CSDOj4+DtqYdLTVpWMuGg1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTVIktSx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937460; x=1748473460;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Wwh570W2fWq0e6p7MFWYoVD3oDk6oPSy1NeIzCTqwBM=;
  b=jTVIktSxb56CjCY7o3P6Ke36Nie3v0DkdK3OGFWyWaQMYoKlhoCjMcP5
   eCUYBm/ZSU4VoTQvFSlOZ2AgTa+gx1PzS9CN6c3la2cEiiJtpbVeJM073
   4ch8mpCSjenrhSsl0Ty3vPjAvV3jOk3zjfTfGdZPWtr3aqAFnIcZqeY4k
   H9CtZmsX4VZs8JPGMNiVJHpXmsou4zNt7cDNIihQ2B+QiVJqrCLuKduEy
   9U8APPloydErIdXY6jpRp3UKowVeKvmX55PVlODAWUJamEPv6WrN7ib6b
   xiSQy7FxZlIJe+1SYtguYd5VtSr7GGyMMuRU8epmJm9wG6s5ch1J2IwCB
   w==;
X-CSE-ConnectionGUID: A4tx04xqSAC9svVD38qgBA==
X-CSE-MsgGUID: 2wYi2DVBROiAdfHkCi+R2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13444905"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13444905"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:13 -0700
X-CSE-ConnectionGUID: 51MucxUQRTWfYxLpoBmdMg==
X-CSE-MsgGUID: ozLq/83IS6SnUwt8Q30dTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="39672314"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:12 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 16:04:01 -0700
Subject: [PATCH next 11/11] ice: Adjust PTP init for 2x50G E825C devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-next-2024-05-28-ptp-refactors-v1-11-c082739bb6f6@intel.com>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
In-Reply-To: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c        |  5 +++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c     | 22 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h       |  9 +++++++++
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
index 3af0f4a2c3be..adbb9cffe20c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1469,6 +1469,8 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 		return;
 
 	ptp_port = &pf->ptp.port;
+	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
+		port *= 2;
 	if (WARN_ON_ONCE(ptp_port->port_num != port))
 		return;
 
@@ -3282,6 +3284,9 @@ void ice_ptp_init(struct ice_pf *pf)
 	}
 
 	ptp->port.port_num = hw->pf_id;
+	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
+		ptp->port.port_num = hw->pf_id * 2;
+
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
 		goto err;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 2c41921f76e8..1e9a4ccd0ea2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2644,6 +2644,26 @@ static int ice_get_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw, u8 port,
 	return 0;
 }
 
+/**
+ * ice_is_muxed_topo - detect breakout 2x50G topology for E825C
+ * @hw: pointer to the HW struct
+ *
+ * Return: true if it's 2x50 breakout topology, false otherwise
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
@@ -2676,6 +2696,8 @@ static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
 			return;
 		}
 	}
+
+	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
 }
 
 /* E822 family functions
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 841860784e3c..5f0da6850b03 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -853,11 +853,20 @@ enum ice_phy_model {
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
 	u8 num_lports;
 	u8 ports_per_phy;
+	bool is_2x50g_muxed_topo;
 };
 
 /* Port hardware description */

-- 
2.44.0.53.g0f9d4d28b7e6


