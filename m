Return-Path: <netdev+bounces-29073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E5781900
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9131C20A19
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CA86ADB;
	Sat, 19 Aug 2023 10:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCB76AB8
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:40:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68E631A50
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692438517; x=1723974517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/kwRuUK+CalYXet4DV6th1Y1wXcgjhVUi/HEjFZzhVg=;
  b=RxlXLtFyb/BbdWDixpD9S/RAWEk6Ik+AggKRGMky+KCwwRwEu3YS3Br2
   49uEcnBwG89XBN7yhHXmL/OdTjY70HvNo9oDEoVv4Y8rZM8IAw58ikt7h
   KMjlsZOoQIsxmF+Np72IPWpCVyGLKsN7olDBhcMnoq7KNW5IGB4sBv8wp
   KiRa6ecfErkZueRvoRKcsjHQJ/2S3kpLvgGCWx9o2wkoQvy9zKpDKbNCW
   xBfn+Iz9yiWKJ6bGGCGQgwNJdunZv8wwXqdC1oFnGLJRzfYeUrLCqaOCO
   6df2vKUcXKW42Q1JNnuvOPQ9O83oxGuxHKwAim3HIEG/MrI98UV5a7/Sc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="377031855"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="377031855"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 02:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="909145857"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="909145857"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2023 02:48:36 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 4/9] ice: Refactor finding advertised link speed
Date: Sat, 19 Aug 2023 02:41:11 -0700
Message-Id: <20230819094111.15212-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

Refactor ice_get_link_ksettings to using Ethtool forced speed to link
modes mapping.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Suggested-by : Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  11 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 156 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   8 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 6 files changed, 111 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5d307bacf7c6..1030a4d1d94e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -974,6 +974,7 @@ int ice_stop(struct net_device *netdev);
 void ice_service_task_schedule(struct ice_pf *pf);
 int ice_load(struct ice_pf *pf);
 void ice_unload(struct ice_pf *pf);
+void ice_adv_lnk_speed_maps_init(void);
 
 /**
  * ice_set_rdma_cap - enable RDMA support
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
index d3cb08e66dcb..14d030d208e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -345,6 +345,24 @@ static const struct ice_priv_flag ice_gstrings_priv_flags[] = {
 
 #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
 
+static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[] __ro_after_init = {
+	ETHTOOL_FORCED_SPEED_MAP(100),
+	ETHTOOL_FORCED_SPEED_MAP(1000),
+	ETHTOOL_FORCED_SPEED_MAP(2500),
+	ETHTOOL_FORCED_SPEED_MAP(5000),
+	ETHTOOL_FORCED_SPEED_MAP(10000),
+	ETHTOOL_FORCED_SPEED_MAP(25000),
+	ETHTOOL_FORCED_SPEED_MAP(40000),
+	ETHTOOL_FORCED_SPEED_MAP(50000),
+	ETHTOOL_FORCED_SPEED_MAP(100000),
+};
+
+void __init ice_adv_lnk_speed_maps_init(void)
+{
+	ethtool_forced_speed_maps_init(ice_adv_lnk_speed_maps,
+				       ARRAY_SIZE(ice_adv_lnk_speed_maps));
+}
+
 static void
 __ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo,
 		  struct ice_vsi *vsi)
@@ -1638,6 +1656,15 @@ ice_get_ethtool_stats(struct net_device *netdev,
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
@@ -1652,8 +1679,9 @@ ice_mask_min_supported_speeds(struct ice_hw *hw,
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
@@ -1796,6 +1824,9 @@ ice_get_settings_link_up(struct ethtool_link_ksettings *ks,
 	ice_phy_type_to_ethtool(netdev, ks);
 
 	switch (link_info->link_speed) {
+	case ICE_AQ_LINK_SPEED_200GB:
+		ks->base.speed = SPEED_200000;
+		break;
 	case ICE_AQ_LINK_SPEED_100GB:
 		ks->base.speed = SPEED_100000;
 		break;
@@ -2007,6 +2038,55 @@ ice_get_link_ksettings(struct net_device *netdev,
 	return err;
 }
 
+/**
+ * ice_speed_to_aq_link - Get AQ link speed by Ethtool forced speed
+ * @speed: ethtool forced speed
+ */
+static u16 ice_speed_to_aq_link(int speed)
+{
+	int aq_speed;
+
+	switch (speed) {
+	case SPEED_10:
+		aq_speed = ICE_AQ_LINK_SPEED_10MB;
+		break;
+	case SPEED_100:
+		aq_speed = ICE_AQ_LINK_SPEED_100MB;
+		break;
+	case SPEED_1000:
+		aq_speed = ICE_AQ_LINK_SPEED_1000MB;
+		break;
+	case SPEED_2500:
+		aq_speed = ICE_AQ_LINK_SPEED_2500MB;
+		break;
+	case SPEED_5000:
+		aq_speed = ICE_AQ_LINK_SPEED_5GB;
+		break;
+	case SPEED_10000:
+		aq_speed = ICE_AQ_LINK_SPEED_10GB;
+		break;
+	case SPEED_20000:
+		aq_speed = ICE_AQ_LINK_SPEED_20GB;
+		break;
+	case SPEED_25000:
+		aq_speed = ICE_AQ_LINK_SPEED_25GB;
+		break;
+	case SPEED_40000:
+		aq_speed = ICE_AQ_LINK_SPEED_40GB;
+		break;
+	case SPEED_50000:
+		aq_speed = ICE_AQ_LINK_SPEED_50GB;
+		break;
+	case SPEED_100000:
+		aq_speed = ICE_AQ_LINK_SPEED_100GB;
+		break;
+	default:
+	       aq_speed = ICE_AQ_LINK_SPEED_UNKNOWN;
+		break;
+	}
+	return aq_speed;
+}
+
 /**
  * ice_ksettings_find_adv_link_speed - Find advertising link speed
  * @ks: ethtool ksettings
@@ -2014,73 +2094,15 @@ ice_get_link_ksettings(struct net_device *netdev,
 static u16
 ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 {
+	const struct ethtool_forced_speed_map *map;
 	u16 adv_link_speed = 0;
+	u32 i;
 
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100baseT_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_100MB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  1000baseX_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  1000baseT_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  1000baseKX_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_1000MB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  2500baseT_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  2500baseX_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_2500MB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  5000baseT_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_5GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseT_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseKR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseSR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseLR_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_10GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  25000baseCR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  25000baseSR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  25000baseKR_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_25GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseCR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseSR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseLR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseKR4_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_40GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  50000baseCR2_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  50000baseKR2_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  50000baseSR2_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_50GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100000baseCR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100000baseSR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100000baseLR4_ER4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100000baseKR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100000baseCR2_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100000baseSR2_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100000baseKR2_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_100GB;
+	for (i = 0; i < ARRAY_SIZE(ice_adv_lnk_speed_maps); i++) {
+		map = ice_adv_lnk_speed_maps + i;
+		if (linkmode_intersects(ks->link_modes.advertising, map->caps))
+			adv_link_speed |= ice_speed_to_aq_link(map->speed);
+	}
 
 	return adv_link_speed;
 }
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
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 356bf8884a63..ffed5543a5aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5672,6 +5672,8 @@ static int __init ice_module_init(void)
 	pr_info("%s\n", ice_driver_string);
 	pr_info("%s\n", ice_copyright);
 
+	ice_adv_lnk_speed_maps_init();
+
 	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
 	if (!ice_wq) {
 		pr_err("Failed to create workqueue\n");
-- 
2.39.2


