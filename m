Return-Path: <netdev+bounces-37436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A47B5570
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 09BDA28327C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80C1A70F;
	Mon,  2 Oct 2023 14:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213041A70D
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 14:49:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC639F
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696258140; x=1727794140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KOQMV818xCipf/e+EGi3dODAa8BfBBQy1+WAij/AE9E=;
  b=Q95q+pLjyJZsXIbkLwJD8fMwFGwiZVwJkG/fR345c5Qcftf2aYgNTzVc
   PYx4UuWCw90vIs5kaOHODtGv0Sja2u4+qoUzsmqeMRWBQlaLuEqlOqKuJ
   1nEM11udsdQpKVb7TaRfd7RPrb1taxEpORd8VbrLy0ZTn3eu8Qv7SCAVf
   oVEawX1OqFo4G4/1fbaHr1eO1ITNJeAWUwGWV1nMNkehJzrS8Lb08jY/j
   6LNV4SRFXtbi+fqppP9I/T+6iCSTiip3QhsJlOhR8pxK0JNiwLQeLJhLN
   WGSPHy78J+PWi4RhJgXZqSx+BQoYWBIp2JPzRGkJW4ZMhkd7O4XEzgc4P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385476087"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="385476087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="874374998"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="874374998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 02 Oct 2023 07:48:55 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0DB4C43C32;
	Mon,  2 Oct 2023 15:48:53 +0100 (IST)
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
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH net-next v3 1/2] ethtool: Add forced speed to supported link modes maps
Date: Mon,  2 Oct 2023 16:44:11 +0200
Message-Id: <20231002144412.1755194-2-pawel.chmielewski@intel.com>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 39 ++++++-------------
 include/linux/ethtool.h                       | 20 ++++++++++
 net/ethtool/ioctl.c                           | 13 +++++++
 3 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 95820cf1cd6c..d3750e39d055 100644
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
+	qede_forced_speed_maps[] __ro_after_init = {
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
index 0b0ce4f81c01..34507691fc9d 100644
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
-- 
2.37.3


