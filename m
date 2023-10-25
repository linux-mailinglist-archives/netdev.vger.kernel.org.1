Return-Path: <netdev+bounces-44289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45117D76F6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C7E1C20975
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47535886;
	Wed, 25 Oct 2023 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2TnHric"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5E34CC1
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:42:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9138137
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698270128; x=1729806128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3CF6pV5fvrreALg/KCSd65YS8R5ETpKwbJ/LdbdmBFs=;
  b=L2TnHricJCNHq9n62vAAFEjzBSw2u9CdFj0IR0j5mucKKalasVkqK3Y/
   FW6zY9BDEAPjZIbqoo2Ep0KcEBNFshTRDnAbWgRJU6lRKGzp8VdvRqEJt
   GkBiI4Qh9a+mOV52TtWUGmxGtezpB76JaMFT3HvHv7eyzOsgI+gGSQa2j
   QKcFPrwm6iozGyZEwl4+9jZvQEBC7Zgf0EOUebHLMu7Wkb5vNrdBPaUbz
   qTNHbrhE3qhZgCC6YtcvwOYPbEYVuFKKFcTcjpVeD4ZwISaNmyUV/H5Cw
   9JQUGmohu3YCiVttTgu0N9WvhlN0V6Q1AdB0VsMwEmfdJCalskjcOu0T4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="6022482"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="6022482"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708825459"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="708825459"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:42:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Brelinski <tony.brelinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 3/6] ice: Add ice_get_link_status_datalen
Date: Wed, 25 Oct 2023 14:41:54 -0700
Message-ID: <20231025214157.1222758-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025214157.1222758-1-jacob.e.keller@intel.com>
References: <20231025214157.1222758-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

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
Tested-by: Tony Brelinski <tony.brelinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
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


