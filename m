Return-Path: <netdev+bounces-29071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3AA7818F8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400BF281CB6
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A386123;
	Sat, 19 Aug 2023 10:40:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AD4A0C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:40:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0A14967E
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692438429; x=1723974429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwYiVxcmKpuCofKbhZQM/f+edCMMthkqE79Fl1YTomc=;
  b=ngzyEbMmwWir/k14Z8rLWGNJ+4fU22uM47+wbSe7Q9Diabu82qWi76aD
   sfxz0vfYfhectjeg891psFqlFP2WBAIoqjunynsikp6A1CN4dO6Dd6Hx8
   D5uHn6LTTrbiTIP80pxJd9fGlWNYdYB92rK2H7DSHtrEZSoMgGWESeyi0
   zsh7pNRTMHiNImGmIK0FiyInAAE/sX4SZ0WCei94RcwMKaeOEZlQP0wPT
   Nn2MUXWFg35QCdHOl7O4PF+Viv8Gu6f1E6NvDy20Vbsm3Zi6QxKhV1p+E
   nHwRpjZEOczevcAz67dAl70nKtcY5Wn/Qk2wFoG0e8Xx3+zQlx5XL90hD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459641095"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="459641095"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 02:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="800719379"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="800719379"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2023 02:47:07 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 2/9] ethtool: Add forced speed to supported link modes maps
Date: Sat, 19 Aug 2023 02:39:41 -0700
Message-Id: <20230819093941.15163-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The need to map Ethtool forced speeds to  Ethtool supported link modes is
common among drivers. To support this move the supported link modes maps
implementation from the qede driver. This is an efficient solution
introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
maps on module init") for qede driver.

ethtool_forced_speed_maps_init() should be called during driver init
with an array of struct ethtool_forced_speed_map to populate the
mapping. The macro ETHTOOL_FORCED_SPEED_MAP is a helper to initialized
the struct ethtool_forced_speed_map.

The qede driver was compile tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
v2: move qede Ethtool speed to link modes mapping to be shared by other
drivers (Andrew)
---
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 92 +++----------------
 include/linux/ethtool.h                       | 74 +++++++++++++++
 net/ethtool/ioctl.c                           | 15 +++
 3 files changed, 100 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 95820cf1cd6c..a01acd48f7eb 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -201,90 +201,20 @@ static const char qede_tests_str_arr[QEDE_ETHTOOL_TEST_MAX][ETH_GSTRING_LEN] = {
 
 /* Forced speed capabilities maps */
 
-struct qede_forced_speed_map {
-	u32		speed;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
-
-	const u32	*cap_arr;
-	u32		arr_size;
-};
-
-#define QEDE_FORCED_SPEED_MAP(value)					\
-{									\
-	.speed		= SPEED_##value,				\
-	.cap_arr	= qede_forced_speed_##value,			\
-	.arr_size	= ARRAY_SIZE(qede_forced_speed_##value),	\
-}
-
-static const u32 qede_forced_speed_1000[] __initconst = {
-	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
-	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
-};
-
-static const u32 qede_forced_speed_10000[] __initconst = {
-	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
-	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
-	ETHTOOL_LINK_MODE_10000baseR_FEC_BIT,
-	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
-	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
-	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
-	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
-};
-
-static const u32 qede_forced_speed_20000[] __initconst = {
-	ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT,
-};
-
-static const u32 qede_forced_speed_25000[] __initconst = {
-	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
-	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
-	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
-};
-
-static const u32 qede_forced_speed_40000[] __initconst = {
-	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
-	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
-	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
-	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
-};
-
-static const u32 qede_forced_speed_50000[] __initconst = {
-	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
-	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
-	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
-};
-
-static const u32 qede_forced_speed_100000[] __initconst = {
-	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
-	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
-	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
-	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
-};
-
-static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
-	QEDE_FORCED_SPEED_MAP(1000),
-	QEDE_FORCED_SPEED_MAP(10000),
-	QEDE_FORCED_SPEED_MAP(20000),
-	QEDE_FORCED_SPEED_MAP(25000),
-	QEDE_FORCED_SPEED_MAP(40000),
-	QEDE_FORCED_SPEED_MAP(50000),
-	QEDE_FORCED_SPEED_MAP(100000),
+struct ethtool_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
+	ETHTOOL_FORCED_SPEED_MAP(1000),
+	ETHTOOL_FORCED_SPEED_MAP(10000),
+	ETHTOOL_FORCED_SPEED_MAP(20000),
+	ETHTOOL_FORCED_SPEED_MAP(25000),
+	ETHTOOL_FORCED_SPEED_MAP(40000),
+	ETHTOOL_FORCED_SPEED_MAP(50000),
+	ETHTOOL_FORCED_SPEED_MAP(100000),
 };
 
 void __init qede_forced_speed_maps_init(void)
 {
-	struct qede_forced_speed_map *map;
-	u32 i;
-
-	for (i = 0; i < ARRAY_SIZE(qede_forced_speed_maps); i++) {
-		map = qede_forced_speed_maps + i;
-
-		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
-		map->cap_arr = NULL;
-		map->arr_size = 0;
-	}
+	ethtool_forced_speed_maps_init(qede_forced_speed_maps,
+				       ARRAY_SIZE(qede_forced_speed_maps));
 }
 
 /* Ethtool callbacks */
@@ -564,8 +494,8 @@ static int qede_set_link_ksettings(struct net_device *dev,
 				   const struct ethtool_link_ksettings *cmd)
 {
 	const struct ethtool_link_settings *base = &cmd->base;
+	const struct ethtool_forced_speed_map *map;
 	struct qede_dev *edev = netdev_priv(dev);
-	const struct qede_forced_speed_map *map;
 	struct qed_link_output current_link;
 	struct qed_link_params params;
 	u32 i;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..245fd4a8d85b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1052,4 +1052,78 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
  * next string.
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
+
+/* Link mode to forced speed capabilities maps */
+struct ethtool_forced_speed_map {
+	u32		speed;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
+
+	const u32	*cap_arr;
+	u32		arr_size;
+};
+
+#define ETHTOOL_FORCED_SPEED_MAP(value)					\
+{									\
+	.speed		= SPEED_##value,				\
+	.cap_arr	= ethtool_forced_speed_##value,			\
+	.arr_size	= ARRAY_SIZE(ethtool_forced_speed_##value),	\
+}
+
+static const u32 ethtool_forced_speed_1000[] __initconst = {
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_10000[] __initconst = {
+	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseR_FEC_BIT,
+	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_20000[] __initconst = {
+	ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_25000[] __initconst = {
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_40000[] __initconst = {
+	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_50000[] __initconst = {
+	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_100000[] __initconst = {
+	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+};
+
+/**
+ * ethtool_forced_speed_maps_init
+ * @maps: Pointer to an array of Ethtool forced speed map
+ * @size: Array size
+ *
+ * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
+ * should be called during driver module init.
+ */
+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
+				    u32 size);
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..ac1fdd636bc1 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3388,3 +3388,18 @@ void ethtool_rx_flow_rule_destroy(struct ethtool_rx_flow_rule *flow)
 	kfree(flow);
 }
 EXPORT_SYMBOL(ethtool_rx_flow_rule_destroy);
+
+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
+				    u32 size)
+{
+	u32 i;
+
+	for (i = 0; i < size; i++) {
+		struct ethtool_forced_speed_map *map = &maps[i];
+
+		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
+		map->cap_arr = NULL;
+		map->arr_size = 0;
+	}
+}
+EXPORT_SYMBOL(ethtool_forced_speed_maps_init);
-- 
2.39.2


