Return-Path: <netdev+bounces-30091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73E785F54
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C861C1C20BFA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6B1F951;
	Wed, 23 Aug 2023 18:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E01ED47
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:11:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D39CE6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692814272; x=1724350272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WH+ERfP4d4rt3knHNtwJlJTTkcnUJm7JtkDQX08d96Q=;
  b=DKi08HgsczrR0nagmJ7wTA7QZatIYW5qjqGlZid6GheaCUIXKOtiq5ae
   trFksqgzcfrcZhClQbtK16SyX6e96szUPM40WG9qr40a5JOIVOm7knXdF
   lOOD0+Qfj2renKkLx1juxcTBIPMyrPrEIR5fdmhpYj0BTv3XML2DaeaRN
   UzSL2qRBAu8JI16jP891Fem1guZUjNIFSEEVaT3udnJ0g2rtGg6/vPT8Y
   PbtxZG8OrPSNR59HGvZljDCBIBPCuwkhe2+1K9e+6zCV3Ic9DF9SH1p7v
   Vesu9+P5GSpShtf1ba2PRYSJnxA76D8MisDe1jJau7yoJ1TsA81T28WVi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="364412445"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364412445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802233711"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802233711"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2023 11:11:10 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1ED71333FB;
	Wed, 23 Aug 2023 19:11:09 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH iwl-next v3 5/8] ice: Add ice_get_link_status_datalen
Date: Wed, 23 Aug 2023 20:06:29 +0200
Message-Id: <20230823180633.2450617-6-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
References: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paul Greenwalt <paul.greenwalt@intel.com>

The Get Link Status data length can vary with different versions of
ice_aqc_get_link_status_data. Add ice_get_link_status_datalen() to return
datalen for the specific ice_aqc_get_link_status_data version.
Add new link partner fields to ice_aqc_get_link_status_data; PHY type,
FEC, and flow control.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 37 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 22 ++++++++++-
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index c38e189ea8f7..baa60e88ad33 100644
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
index e8225b275f70..e611e32b4a17 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -576,6 +576,24 @@ static enum ice_media_type ice_get_media_type(struct ice_port_info *pi)
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
@@ -614,8 +632,8 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 	resp->cmd_flags = cpu_to_le16(cmd_flags);
 	resp->lport_num = pi->lport;
 
-	status = ice_aq_send_cmd(hw, &desc, &link_data, sizeof(link_data), cd);
-
+	status = ice_aq_send_cmd(hw, &desc, &link_data,
+				 ice_get_link_status_datalen(hw), cd);
 	if (status)
 		return status;
 
-- 
2.37.3


