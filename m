Return-Path: <netdev+bounces-41108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FE7C9CA0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 01:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9DF2816AA
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 23:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABAB156D1;
	Sun, 15 Oct 2023 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3wxqs9l"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5565154BF
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:51:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB0AD
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697413867; x=1728949867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MRP/8dO1Nhj1C2Twam6anFmo6pHcRJrAnBkWA1dtyDQ=;
  b=I3wxqs9l0X9op8qbTT8lKK9xR3SG24Jqm3AFErOLjrGB4Wcx/YjoPzbC
   3FWxFaGKzD/ev6IdiTLaud2nLRwFDGPc9nLaMmyXwdrpehAFPqf2K5yIy
   Tz9OLV+ucpaGIuSP6Jedr77LCvgNfkpaPCjsOY3ScamobC3q/uslqSdJ4
   yiQXDokBl/gAl/kuFNWPIIbSY0r3Ijfv7P7BJKWBb0Jc7tnNlXvJTO9Xe
   DvLjPbqe+VT/8SAT9G8D6eZw3y5X8qhlwW0PCSE5ZMnq75PkY0caoPqMO
   2wsi/gEjLZPn7IU/hwzzRWvayVNZj5nmch3HqjdM8WiLvddkXUWVhSTIT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="370496084"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="370496084"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 16:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929159773"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="929159773"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.144])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2023 16:51:06 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	vladimir.oltean@nxp.com,
	jdamato@fastly.com,
	pawel.chmielewski@intel.com,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	kuba@kernel.org,
	d-tatianin@yandex-team.ru,
	pabeni@redhat.com,
	davem@davemloft.net,
	jiri@resnulli.us,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 1/3] ethtool: Add forced speed to supported link modes maps
Date: Sun, 15 Oct 2023 19:43:02 -0400
Message-ID: <20231015234304.2633-2-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231015234304.2633-1-paul.greenwalt@intel.com>
References: <20231015234304.2633-1-paul.greenwalt@intel.com>
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

The need to map Ethtool forced speeds to Ethtool supported link modes is
common among drivers. To support this, add a common structure for forced
speed maps and a function to init them.  This is solution was originally
introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
maps on module init") for qede driver.

ethtool_forced_speed_maps_init() should be called during driver init
with an array of struct ethtool_forced_speed_map to populate the mapping.

Definitions for maps themselves are left in the driver code, as the sets
of supported link modes may vary between the devices.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 include/linux/ethtool.h  | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/linkmode.h | 29 +++++++++++++++--------------
 2 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..8e91e8b8a693 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -13,6 +13,7 @@
 #ifndef _LINUX_ETHTOOL_H
 #define _LINUX_ETHTOOL_H
 
+#include <linux/linkmode.h>
 #include <linux/bitmap.h>
 #include <linux/compat.h>
 #include <linux/if_ether.h>
@@ -1052,4 +1053,40 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
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
+#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)				\
+{									\
+	.speed		= SPEED_##value,				\
+	.cap_arr	= prefix##_##value,				\
+	.arr_size	= ARRAY_SIZE(prefix##_##value),			\
+}
+
+/**
+ * ethtool_forced_speed_maps_init
+ * @maps: Pointer to an array of Ethtool forced speed map
+ * @size: Array size
+ *
+ * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
+ * should be called during driver module init.
+ */
+static inline void
+ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
+{
+	for (u32 i = 0; i < size; i++) {
+		struct ethtool_forced_speed_map *map = &maps[i];
+
+		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
+		map->cap_arr = NULL;
+		map->arr_size = 0;
+	}
+}
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 15e0e0209da4..cd38f89553e6 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -2,6 +2,21 @@
 #define __LINKMODE_H
 
 #include <linux/bitmap.h>
+
+static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+static inline void linkmode_set_bit_array(const int *array, int array_size,
+					  unsigned long *addr)
+{
+	int i;
+
+	for (i = 0; i < array_size; i++)
+		linkmode_set_bit(array[i], addr);
+}
+
 #include <linux/ethtool.h>
 #include <uapi/linux/ethtool.h>
 
@@ -38,20 +53,6 @@ static inline int linkmode_andnot(unsigned long *dst, const unsigned long *src1,
 	return bitmap_andnot(dst, src1, src2,  __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
-static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
-{
-	__set_bit(nr, addr);
-}
-
-static inline void linkmode_set_bit_array(const int *array, int array_size,
-					  unsigned long *addr)
-{
-	int i;
-
-	for (i = 0; i < array_size; i++)
-		linkmode_set_bit(array[i], addr);
-}
-
 static inline void linkmode_clear_bit(int nr, volatile unsigned long *addr)
 {
 	__clear_bit(nr, addr);
-- 
2.40.0


