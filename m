Return-Path: <netdev+bounces-34103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1C7A219E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B93282AD6
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E530D1A;
	Fri, 15 Sep 2023 14:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DD10959
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:58:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C71BE6
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694789891; x=1726325891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yW2soBPY76b9jz0BBjq7N+3ZgmmS6mNbwusMHo0YdO0=;
  b=THlVsp62awbrL4ygGVGvqT3SpuAV/2ySK31LyR9kp/AfKdWoXIIO3WPS
   YCO6egA0I7Oot3ZeHgqdXDsu/YBQSp6q39eo7X6JStdUbocKgf5eu5RE8
   uzjl3SOf/ZpL0PAbL6KqH4x17NNRMZhcyTRdEaFFVAIwiRU1svHdsejsc
   XrhHl3wyxOaR7qSFkm2vFBHo3UuLdEI9GC8OrhimlFT7T0b1pJdxjWQTz
   3WFwlX1wT/gjy4mM54L9Z5Z9gZta0GinIadAgS6u3q86X6K9idZwMtkvm
   fMsWKl/yWk3zj6QZV9o0vmwSKI7XyDbBnmNdgPNTGJfLihDbCCj/KcDXF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445723972"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="445723972"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810548682"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="810548682"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 15 Sep 2023 07:58:08 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 54A8A333F9;
	Fri, 15 Sep 2023 15:58:07 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next 1/2] ethtool: Add forced speed to supported link modes maps
Date: Fri, 15 Sep 2023 16:55:21 +0200
Message-Id: <20230915145522.586365-2-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230915145522.586365-1-pawel.chmielewski@intel.com>
References: <20230915145522.586365-1-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
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
of supported link modes may vary betwen the devices.

The qede driver was compile tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 24 ++++---------------
 include/linux/ethtool.h                       | 20 ++++++++++++++++
 net/ethtool/ioctl.c                           | 15 ++++++++++++
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 95820cf1cd6c..9e0e73602abe 100644
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
@@ -263,7 +255,7 @@ static const u32 qede_forced_speed_100000[] __initconst = {
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
 };
 
-static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
+static struct ethtool_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
 	QEDE_FORCED_SPEED_MAP(1000),
 	QEDE_FORCED_SPEED_MAP(10000),
 	QEDE_FORCED_SPEED_MAP(20000),
@@ -275,16 +267,8 @@ static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
 
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
@@ -565,7 +549,7 @@ static int qede_set_link_ksettings(struct net_device *dev,
 {
 	const struct ethtool_link_settings *base = &cmd->base;
 	struct qede_dev *edev = netdev_priv(dev);
-	const struct qede_forced_speed_map *map;
+	const struct ethtool_forced_speed_map *map;
 	struct qed_link_output current_link;
 	struct qed_link_params params;
 	u32 i;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..3d23a8d78c9b 100644
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
+				   u32 size);
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..1ba437eff764 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3388,3 +3388,18 @@ void ethtool_rx_flow_rule_destroy(struct ethtool_rx_flow_rule *flow)
 	kfree(flow);
 }
 EXPORT_SYMBOL(ethtool_rx_flow_rule_destroy);
+
+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
+				   u32 size)
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
\ No newline at end of file
-- 
2.37.3


