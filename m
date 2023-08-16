Return-Path: <netdev+bounces-28283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04977EE13
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 02:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE7F1C2126C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 00:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39718F;
	Thu, 17 Aug 2023 00:05:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4F644
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:05:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62311FD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 17:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692230718; x=1723766718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UWDMSET60yRUlq9+3LE6ATf4kCHTJiKH91xV9MfxoM=;
  b=iO3bB1qK/+vIipk3LGtL3xPBnUvlhPQ4+ytVfZYq3hGwwUam+ZayRR1t
   PuBbZ19fCNlHA75V9JQDOc+X6ow3Tvqo+EQsFyYx1wCxFCZadRk/tyxTs
   wxJjkQ7rtLhvP0dHb8a2lupE+QIhsvT8H5OF6lhACLdr1rlP5WRtxf6H5
   dFzntQtRjDJJRidMQv0UtRo4n6BEEGCKIC4UC5V1TimR3GaTqD0E5Fv1O
   SiXJzmZRnnj/8mKgGtQnjk3Rjh7Dk5Fot5WvUuQZJ+TupaM4TUf1S2dFs
   CazqM71V+QaVzIMEunOWk7UoLQ7oCOQG+K3zVO0KVpefqrvUIpaY5mKCf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371570656"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="371570656"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 17:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824422135"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="824422135"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2023 17:04:51 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alice Michael <alice.michael@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next 3/7] ice: Add 200G speed/phy type use
Date: Wed, 16 Aug 2023 16:57:15 -0700
Message-Id: <20230816235719.1120726-4-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816235719.1120726-1-paul.greenwalt@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alice Michael <alice.michael@intel.com>

Add the support for 200G phy speeds and the mapping for their
advertisement in link. Add the new PHY type bits for AQ command, as
needed for 200G E830 controllers.

Signed-off-by: Alice Michael <alice.michael@intel.com>
Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 11 +++++++-
 drivers/net/ethernet/intel/ice/ice_common.c   |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 26 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  8 ++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 90616750e779..d28c610b004d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1099,7 +1099,15 @@ struct ice_aqc_get_phy_caps {
 #define ICE_PHY_TYPE_HIGH_100G_CAUI2		BIT_ULL(2)
 #define ICE_PHY_TYPE_HIGH_100G_AUI2_AOC_ACC	BIT_ULL(3)
 #define ICE_PHY_TYPE_HIGH_100G_AUI2		BIT_ULL(4)
-#define ICE_PHY_TYPE_HIGH_MAX_INDEX		4
+#define ICE_PHY_TYPE_HIGH_200G_CR4_PAM4		BIT_ULL(5)
+#define ICE_PHY_TYPE_HIGH_200G_SR4		BIT_ULL(6)
+#define ICE_PHY_TYPE_HIGH_200G_FR4		BIT_ULL(7)
+#define ICE_PHY_TYPE_HIGH_200G_LR4		BIT_ULL(8)
+#define ICE_PHY_TYPE_HIGH_200G_DR4		BIT_ULL(9)
+#define ICE_PHY_TYPE_HIGH_200G_KR4_PAM4		BIT_ULL(10)
+#define ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC	BIT_ULL(11)
+#define ICE_PHY_TYPE_HIGH_200G_AUI4		BIT_ULL(12)
+#define ICE_PHY_TYPE_HIGH_MAX_INDEX		12
 
 struct ice_aqc_get_phy_caps_data {
 	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
@@ -1319,6 +1327,7 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_SPEED_40GB		BIT(8)
 #define ICE_AQ_LINK_SPEED_50GB		BIT(9)
 #define ICE_AQ_LINK_SPEED_100GB		BIT(10)
+#define ICE_AQ_LINK_SPEED_200GB		BIT(11)
 #define ICE_AQ_LINK_SPEED_UNKNOWN	BIT(15)
 	__le32 reserved3; /* Aligns next field to 8-byte boundary */
 	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a6c99ba31dc9..7992eaab94fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5379,6 +5379,7 @@ static const u32 ice_aq_to_link_speed[] = {
 	SPEED_40000,
 	SPEED_50000,
 	SPEED_100000,	/* BIT(10) */
+	SPEED_200000,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 9a858d8ae26e..a1a64237cf19 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -400,6 +400,14 @@ static const u32 ice_adv_lnk_speed_100000[] __initconst = {
 	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
 };
 
+static const u32 ice_adv_lnk_speed_200000[] __initconst = {
+	ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
+};
+
 struct ice_adv_lnk_speed_map {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
 	const u32	*cap_arr;
@@ -424,6 +432,7 @@ static struct ice_adv_lnk_speed_map ice_adv_lnk_speed_maps[] __ro_after_init = {
 	ICE_ADV_LNK_SPEED_MAP(40000, 40GB),
 	ICE_ADV_LNK_SPEED_MAP(50000, 50GB),
 	ICE_ADV_LNK_SPEED_MAP(100000, 100GB),
+	ICE_ADV_LNK_SPEED_MAP(200000, 200GB),
 };
 
 void __init ice_adv_lnk_speed_maps_init(void)
@@ -1732,6 +1741,15 @@ ice_get_ethtool_stats(struct net_device *netdev,
 					 ICE_PHY_TYPE_HIGH_100G_AUI2_AOC_ACC | \
 					 ICE_PHY_TYPE_HIGH_100G_AUI2)
 
+#define ICE_PHY_TYPE_HIGH_MASK_200G	(ICE_PHY_TYPE_HIGH_200G_CR4_PAM4 | \
+					 ICE_PHY_TYPE_HIGH_200G_SR4 | \
+					 ICE_PHY_TYPE_HIGH_200G_FR4 | \
+					 ICE_PHY_TYPE_HIGH_200G_LR4 | \
+					 ICE_PHY_TYPE_HIGH_200G_DR4 | \
+					 ICE_PHY_TYPE_HIGH_200G_KR4_PAM4 | \
+					 ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC | \
+					 ICE_PHY_TYPE_HIGH_200G_AUI4)
+
 /**
  * ice_mask_min_supported_speeds
  * @hw: pointer to the HW structure
@@ -1746,8 +1764,9 @@ ice_mask_min_supported_speeds(struct ice_hw *hw,
 			      u64 phy_types_high, u64 *phy_types_low)
 {
 	/* if QSFP connection with 100G speed, minimum supported speed is 25G */
-	if (*phy_types_low & ICE_PHY_TYPE_LOW_MASK_100G ||
-	    phy_types_high & ICE_PHY_TYPE_HIGH_MASK_100G)
+	if ((*phy_types_low & ICE_PHY_TYPE_LOW_MASK_100G) ||
+	    (phy_types_high & ICE_PHY_TYPE_HIGH_MASK_100G) ||
+	    (phy_types_high & ICE_PHY_TYPE_HIGH_MASK_200G))
 		*phy_types_low &= ~ICE_PHY_TYPE_LOW_MASK_MIN_25G;
 	else if (!ice_is_100m_speed_supported(hw))
 		*phy_types_low &= ~ICE_PHY_TYPE_LOW_MASK_MIN_1G;
@@ -1890,6 +1909,9 @@ ice_get_settings_link_up(struct ethtool_link_ksettings *ks,
 	ice_phy_type_to_ethtool(netdev, ks);
 
 	switch (link_info->link_speed) {
+	case ICE_AQ_LINK_SPEED_200GB:
+		ks->base.speed = SPEED_200000;
+		break;
 	case ICE_AQ_LINK_SPEED_100GB:
 		ks->base.speed = SPEED_100000;
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index b403ee79cd5e..b88e3da06f13 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -100,6 +100,14 @@ phy_type_high_lkup[] = {
 	[2] = ICE_PHY_TYPE(100GB, 100000baseCR2_Full),
 	[3] = ICE_PHY_TYPE(100GB, 100000baseSR2_Full),
 	[4] = ICE_PHY_TYPE(100GB, 100000baseCR2_Full),
+	[5] = ICE_PHY_TYPE(200GB, 200000baseCR4_Full),
+	[6] = ICE_PHY_TYPE(200GB, 200000baseSR4_Full),
+	[7] = ICE_PHY_TYPE(200GB, 200000baseLR4_ER4_FR4_Full),
+	[8] = ICE_PHY_TYPE(200GB, 200000baseLR4_ER4_FR4_Full),
+	[9] = ICE_PHY_TYPE(200GB, 200000baseDR4_Full),
+	[10] = ICE_PHY_TYPE(200GB, 200000baseKR4_Full),
+	[11] = ICE_PHY_TYPE(200GB, 200000baseSR4_Full),
+	[12] = ICE_PHY_TYPE(200GB, 200000baseCR4_Full),
 };
 
 #endif /* !_ICE_ETHTOOL_H_ */
-- 
2.39.2


