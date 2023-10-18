Return-Path: <netdev+bounces-42441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCAC7CEBF4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7CBB2107B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FC42901;
	Wed, 18 Oct 2023 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQBUbahZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA018E0B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:24:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA111F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697671486; x=1729207486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tXYb+Sh4ldg043KyAFzilHKu7x8W34PkG63aqLBa4wU=;
  b=dQBUbahZ5CAZ1ITRvE9d6JbjlHxHXbwsbw7ZxF3Ft5S2yRFUh6J9f36z
   tlSr3HT3ES6YxX8gE98t39wx7+J/zWNNsab1bmBCuhKrpQ39uvO9+Atnn
   SSPKY88YSlt9REclQu8VlfKHT9gQ3cw18s39Ab/t7vR4vbjPgRLGNXtfN
   HdDE22JAYujutGTO1L0U/4p3nXGQzqIHGmtYiZIEe3cGwDSjP8i/pip3z
   Mx1ZTpzROuV4Qgdh5Uv25DfqxtAlg0tx6mPrDaZaYHJHtFJnfpjukjD1+
   7y5LnBO7BjC+1kaS2olCPQmUAczUqjHIFD+z4u4ENcqL3S1b7FnQIsJmg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="388996720"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="388996720"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4732353"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.144])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 16:24:48 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH net-next v5 3/6] ice: Add ice_get_link_status_datalen
Date: Wed, 18 Oct 2023 19:16:40 -0400
Message-ID: <20231018231643.2356-4-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018231643.2356-1-paul.greenwalt@intel.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Get Link Status data length can vary with different versions of
ice_aqc_get_link_status_data. Add ice_get_link_status_datalen() to return
datalen for the specific ice_aqc_get_link_status_data version.
Add new link partner fields to ice_aqc_get_link_status_data; PHY type,
FEC, and flow control.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 37 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 22 ++++++++++-
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index ee9acd19505d..d7fdb7ba7268 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1329,10 +1329,39 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_SPEED_100GB		BIT(10)
 #define ICE_AQ_LINK_SPEED_200GB		BIT(11)
 #define ICE_AQ_LINK_SPEED_UNKNOWN	BIT(15)
-	__le32 reserved3; /* Aligns next field to 8-byte boundary */
-	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
-	__le64 phy_type_high; /* Use values from ICE_PHY_TYPE_HIGH_* */
-};
+	/* Aligns next field to 8-byte boundary */
+	__le16 reserved3;
+	u8 ext_fec_status;
+	/* RS 272 FEC enabled */
+#define ICE_AQ_LINK_RS_272_FEC_EN      BIT(0)
+	u8 reserved4;
+	/* Use values from ICE_PHY_TYPE_LOW_* */
+	__le64 phy_type_low;
+	/* Use values from ICE_PHY_TYPE_HIGH_* */
+	__le64 phy_type_high;
+#define ICE_AQC_LS_DATA_SIZE_V1 \
+	offsetofend(struct ice_aqc_get_link_status_data, phy_type_high)
+	/* Get link status v2 link partner data */
+	__le64 lp_phy_type_low;
+	__le64 lp_phy_type_high;
+	u8 lp_fec_adv;
+#define ICE_AQ_LINK_LP_10G_KR_FEC_CAP  BIT(0)
+#define ICE_AQ_LINK_LP_25G_KR_FEC_CAP  BIT(1)
+#define ICE_AQ_LINK_LP_RS_528_FEC_CAP  BIT(2)
+#define ICE_AQ_LINK_LP_50G_KR_272_FEC_CAP BIT(3)
+#define ICE_AQ_LINK_LP_100G_KR_272_FEC_CAP BIT(4)
+#define ICE_AQ_LINK_LP_200G_KR_272_FEC_CAP BIT(5)
+	u8 lp_fec_req;
+#define ICE_AQ_LINK_LP_10G_KR_FEC_REQ  BIT(0)
+#define ICE_AQ_LINK_LP_25G_KR_FEC_REQ  BIT(1)
+#define ICE_AQ_LINK_LP_RS_528_FEC_REQ  BIT(2)
+#define ICE_AQ_LINK_LP_KR_272_FEC_REQ  BIT(3)
+	u8 lp_flowcontrol;
+#define ICE_AQ_LINK_LP_PAUSE_ADV       BIT(0)
+#define ICE_AQ_LINK_LP_ASM_DIR_ADV     BIT(1)
+#define ICE_AQC_LS_DATA_SIZE_V2 \
+	offsetofend(struct ice_aqc_get_link_status_data, lp_flowcontrol)
+} __packed;
 
 /* Set event mask command (direct 0x0613) */
 struct ice_aqc_set_event_mask {
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 4875d59f27f2..9a6c25f98632 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -651,6 +651,24 @@ static enum ice_media_type ice_get_media_type(struct ice_port_info *pi)
 	return ICE_MEDIA_UNKNOWN;
 }
 
+/**
+ * ice_get_link_status_datalen
+ * @hw: pointer to the HW struct
+ *
+ * Returns datalength for the Get Link Status AQ command, which is bigger for
+ * newer adapter families handled by ice driver.
+ */
+static u16 ice_get_link_status_datalen(struct ice_hw *hw)
+{
+	switch (hw->mac_type) {
+	case ICE_MAC_E830:
+		return ICE_AQC_LS_DATA_SIZE_V2;
+	case ICE_MAC_E810:
+	default:
+		return ICE_AQC_LS_DATA_SIZE_V1;
+	}
+}
+
 /**
  * ice_aq_get_link_info
  * @pi: port information structure
@@ -689,8 +707,8 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 	resp->cmd_flags = cpu_to_le16(cmd_flags);
 	resp->lport_num = pi->lport;
 
-	status = ice_aq_send_cmd(hw, &desc, &link_data, sizeof(link_data), cd);
-
+	status = ice_aq_send_cmd(hw, &desc, &link_data,
+				 ice_get_link_status_datalen(hw), cd);
 	if (status)
 		return status;
 
-- 
2.41.0


