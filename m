Return-Path: <netdev+bounces-35530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D97A9C80
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7F4282E11
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0A4B20E;
	Thu, 21 Sep 2023 18:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB264BDB1
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:11:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C7A0C16
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695319055; x=1726855055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkbsYbgDnlQ7QoDEUPwcHhC3+FBi0qzx5JzdtTXaCBY=;
  b=JHeV0R6Nf08Yjsa1Comv8sEIKnFGZaZRwTs9BB+3e1F3l0iWAcDQlMD2
   OD3SsB7t3BVXUtDVSF5zHVkT8sIm06C/+DXkP4EUJ5qy4/jRap6SNDFaW
   HKh2KGumpg/rXZ2ThnAfBGCZLYQJ57TStB83ekgT4VYgSiffBdSBnV4at
   vu8nh4hEIgylS/P7qrlot5DARI04ZzO2BXxKj4NJzKlf86BHboDj6TRvY
   m5p5BjucRnBUgCrFURs7OiSj0OuYzhnfrvE7K7oyIJJ6mFZ01yPnVqeU2
   qH63PBInbHgIJrOQyFBgPl1Xivkyf3BWQjbqSox15yj2VCs92Oyi4P3FT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383278150"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="383278150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="890377518"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="890377518"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2023 06:54:06 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E686B284F5;
	Thu, 21 Sep 2023 14:54:55 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	horms@kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH net-next v2 1/2] ethtool: Add forced speed to supported link  modes maps
Date: Thu, 21 Sep 2023 15:51:39 +0200
Message-Id: <20230921135140.1134153-2-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230921135140.1134153-1-pawel.chmielewski@intel.com>
References: <20230921135140.1134153-1-pawel.chmielewski@intel.com>
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

The need to map Ethtool forced speeds to Ethtool supported link modes is
common among drivers. To support this, add a common structure for forced
speed maps and a function to init them.  This is solution was originally
introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
maps on module init") for qede driver.

ethtool_forced_speed_maps_init() should be called during driver init
with an array of struct ethtool_forced_speed_map to populate the mapping.

Definitions for maps themselves are left in the driver code, as the sets
of supported link modes may vary between the devices.

The qede driver was compile tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 39 ++++++-------------
 include/linux/ethtool.h                       | 20 ++++++++++
 net/ethtool/ioctl.c                           | 13 +++++++
 3 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 95820cf1cd6c..f018afb2362f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -201,14 +201,6 @@ static const char qede_tests_str_arr[QEDE_ETHTOOL_TEST_MAX][ETH_GSTRING_LEN] = {
 
 /* Forced speed capabilities maps */
 
-struct qede_forced_speed_map {
-	u32		speed;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
-
-	const u32	*cap_arr;
-	u32		arr_size;
-};
-
 #define QEDE_FORCED_SPEED_MAP(value)					\
 {									\
 	.speed		= SPEED_##value,				\
@@ -263,28 +255,21 @@ static const u32 qede_forced_speed_100000[] __initconst = {
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
 };
 
-static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
-	QEDE_FORCED_SPEED_MAP(1000),
-	QEDE_FORCED_SPEED_MAP(10000),
-	QEDE_FORCED_SPEED_MAP(20000),
-	QEDE_FORCED_SPEED_MAP(25000),
-	QEDE_FORCED_SPEED_MAP(40000),
-	QEDE_FORCED_SPEED_MAP(50000),
-	QEDE_FORCED_SPEED_MAP(100000),
+static struct ethtool_forced_speed_map
+        qede_forced_speed_maps[] __ro_after_init = {
+		QEDE_FORCED_SPEED_MAP(1000),
+		QEDE_FORCED_SPEED_MAP(10000),
+		QEDE_FORCED_SPEED_MAP(20000),
+		QEDE_FORCED_SPEED_MAP(25000),
+		QEDE_FORCED_SPEED_MAP(40000),
+		QEDE_FORCED_SPEED_MAP(50000),
+		QEDE_FORCED_SPEED_MAP(100000),
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
@@ -564,8 +549,8 @@ static int qede_set_link_ksettings(struct net_device *dev,
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
index 62b61527bcc4..4e2c1d07df38 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1052,4 +1052,24 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
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
index 0b0ce4f81c01..9e62066376da 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3388,3 +3388,16 @@ void ethtool_rx_flow_rule_destroy(struct ethtool_rx_flow_rule *flow)
 	kfree(flow);
 }
 EXPORT_SYMBOL(ethtool_rx_flow_rule_destroy);
+
+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
+				    u32 size)
+{
+	for (u32 i = 0; i < size; i++) {
+		struct ethtool_forced_speed_map *map = &maps[i];
+
+		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
+		map->cap_arr = NULL;
+		map->arr_size = 0;
+	}
+}
+EXPORT_SYMBOL(ethtool_forced_speed_maps_init);
\ No newline at end of file
-- 
2.37.3


