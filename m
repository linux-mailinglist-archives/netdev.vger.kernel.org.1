Return-Path: <netdev+bounces-37435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484E7B556E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6DF271C208CE
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F21A5BF;
	Mon,  2 Oct 2023 14:49:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812001A700
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 14:49:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85870B7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696258142; x=1727794142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YI337NDib3HjeDmkE/CY4l6KOioR/S3EP7lU7GCo+BM=;
  b=KD/Zv6CNljeoTyHgvvfiBM75HZQ9kCswh+/nFlGnGjAGPsJ9HrqWYd5y
   /cCI68iefNPj4yx7l7dHjDfxfz2tpphyQTi6TkDg9JJwaU7ygDD8jlz+K
   Ro9jAqBLvyh916Q0z1vLhhdHqr/sLP0ND9NHn70igHvTWhze0cPAVMrbH
   Fv6CXqlQREcpv+xg39pn/UJGNusPejLwdJm4jLL137q61Ov/w+HguyQ/Y
   Jp8Rq1maBXa2eXjBIGlZ67wdKWZ30AU7Nb9OrWv7Rg0KvkibvsyBXVJOr
   q2UJ5MTkNStQszSPtEqcBYWSDmWpFfDlKVYMbytvfikwFfX4Vyfwlj3Sw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385476098"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="385476098"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="874375006"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="874375006"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 02 Oct 2023 07:48:56 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 340B743C33;
	Mon,  2 Oct 2023 15:48:54 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	horms@kernel.org,
	vladimir.oltean@nxp.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jdamato@fastly.com,
	d-tatianin@yandex-team.ru,
	kuba@kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH net-next v3 2/2] ice: Refactor finding advertised link speed
Date: Mon,  2 Oct 2023 16:44:12 +0200
Message-Id: <20231002144412.1755194-3-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231002144412.1755194-1-pawel.chmielewski@intel.com>
References: <20231002144412.1755194-1-pawel.chmielewski@intel.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor ice_get_link_ksettings to using forced speed to link modes mapping.

Suggested-by : Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 200 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c    |   2 +
 3 files changed, 138 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fcaa5c3b8ec0..988b177d9388 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -960,6 +960,7 @@ int ice_stop(struct net_device *netdev);
 void ice_service_task_schedule(struct ice_pf *pf);
 int ice_load(struct ice_pf *pf);
 void ice_unload(struct ice_pf *pf);
+void ice_adv_lnk_speed_maps_init(void);
 
 /**
  * ice_set_rdma_cap - enable RDMA support
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d3cb08e66dcb..b027788c42f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -345,6 +345,86 @@ static const struct ice_priv_flag ice_gstrings_priv_flags[] = {
 
 #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
 
+static const u32 ice_adv_lnk_speed_100[] __initconst = {
+	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_1000[] __initconst = {
+	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_2500[] __initconst = {
+	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_5000[] __initconst = {
+	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_10000[] __initconst = {
+	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_25000[] __initconst = {
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_40000[] __initconst = {
+	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_50000[] __initconst = {
+	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+};
+
+static const u32 ice_adv_lnk_speed_100000[] __initconst = {
+	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+};
+
+#define ICE_ADV_LNK_SPEED_MAP(value)					\
+{									\
+	.speed		= SPEED_##value,				\
+	.cap_arr	= ice_adv_lnk_speed_##value,			\
+	.arr_size	= ARRAY_SIZE(ice_adv_lnk_speed_##value),	\
+}
+
+static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[] __ro_after_init = {
+	ICE_ADV_LNK_SPEED_MAP(100),
+	ICE_ADV_LNK_SPEED_MAP(1000),
+	ICE_ADV_LNK_SPEED_MAP(2500),
+	ICE_ADV_LNK_SPEED_MAP(5000),
+	ICE_ADV_LNK_SPEED_MAP(10000),
+	ICE_ADV_LNK_SPEED_MAP(25000),
+	ICE_ADV_LNK_SPEED_MAP(40000),
+	ICE_ADV_LNK_SPEED_MAP(50000),
+	ICE_ADV_LNK_SPEED_MAP(100000),
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
@@ -2007,6 +2087,55 @@ ice_get_link_ksettings(struct net_device *netdev,
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
+		aq_speed = ICE_AQ_LINK_SPEED_UNKNOWN;
+		break;
+	}
+	return aq_speed;
+}
+
 /**
  * ice_ksettings_find_adv_link_speed - Find advertising link speed
  * @ks: ethtool ksettings
@@ -2014,73 +2143,14 @@ ice_get_link_ksettings(struct net_device *netdev,
 static u16
 ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 {
+	const struct ethtool_forced_speed_map *map;
 	u16 adv_link_speed = 0;
 
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
+	for (u32 i = 0; i < ARRAY_SIZE(ice_adv_lnk_speed_maps); i++) {
+		map = ice_adv_lnk_speed_maps + i;
+		if (linkmode_intersects(ks->link_modes.advertising, map->caps))
+			adv_link_speed |= ice_speed_to_aq_link(map->speed);
+	}
 
 	return adv_link_speed;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c726913bc635..0dd7f23395b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5633,6 +5633,8 @@ static int __init ice_module_init(void)
 	pr_info("%s\n", ice_driver_string);
 	pr_info("%s\n", ice_copyright);
 
+	ice_adv_lnk_speed_maps_init();
+
 	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
 	if (!ice_wq) {
 		pr_err("Failed to create workqueue\n");
-- 
2.37.3


