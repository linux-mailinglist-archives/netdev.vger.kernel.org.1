Return-Path: <netdev+bounces-42695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF887CFDD7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D3B21274
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2530F82;
	Thu, 19 Oct 2023 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AspNCr5A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610AE2FE3A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B7EC433C7;
	Thu, 19 Oct 2023 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697729298;
	bh=KPdyBswbgyFl9TO6CKdUH3Sqyqr07CXAudJGRZvb+H0=;
	h=From:To:Cc:Subject:Date:From;
	b=AspNCr5ADkEchz6wytQu+Im6Um/HpyyBkCum0MLlYTjFQuU1ow0b4G5IqmLvWIWjw
	 u2/blsSnZgRA+p3/FNYUjiZYEcLXrhHuM8gHD61KfCPtJnODk+JpNWjAQEqq5vPJzc
	 AeT/heLR5saCoRkPtqwTk9MXnPHPZs9FtArx5gByLCiMwjp6cGgTIOxm/gL7BkjEr7
	 J63agmYr3TvHjUIK0/deGT2CFgKigMReciH4aquE6PfvUhHBLN+q2hhtML3pdWWAyS
	 zrkX0UItHR+Oss3o+IUgMH+C9DxLpQZtzmCxIsK6rNQLFIBkN/2zClldPzWEga72Xv
	 dYSh8VaUq4cVw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	paul.greenwalt@intel.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	gal@nvidia.com
Subject: [PATCH net-next] ethtool: untangle the linkmode and ethtool headers
Date: Thu, 19 Oct 2023 08:28:15 -0700
Message-ID: <20231019152815.2840783-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 26c5334d344d ("ethtool: Add forced speed to supported link
modes maps") added a dependency between ethtool.h and linkmode.h.
The dependency in the opposite direction already exists so the
new code was inserted in an awkward place.

The reason for ethtool.h to include linkmode.h, is that
ethtool_forced_speed_maps_init() is a static inline helper.
That's not really necessary.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: paul.greenwalt@intel.com
CC: hkallweit1@gmail.com
CC: linux@armlinux.org.uk
CC: vladimir.oltean@nxp.com
CC: gal@nvidia.com
---
 include/linux/ethtool.h  | 22 ++--------------------
 include/linux/linkmode.h | 29 ++++++++++++++---------------
 net/ethtool/common.c     | 21 +++++++++++++++++++++
 3 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8e91e8b8a693..226a36ed5aa1 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -13,7 +13,6 @@
 #ifndef _LINUX_ETHTOOL_H
 #define _LINUX_ETHTOOL_H
 
-#include <linux/linkmode.h>
 #include <linux/bitmap.h>
 #include <linux/compat.h>
 #include <linux/if_ether.h>
@@ -1070,23 +1069,6 @@ struct ethtool_forced_speed_map {
 	.arr_size	= ARRAY_SIZE(prefix##_##value),			\
 }
 
-/**
- * ethtool_forced_speed_maps_init
- * @maps: Pointer to an array of Ethtool forced speed map
- * @size: Array size
- *
- * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
- * should be called during driver module init.
- */
-static inline void
-ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
-{
-	for (u32 i = 0; i < size; i++) {
-		struct ethtool_forced_speed_map *map = &maps[i];
-
-		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
-		map->cap_arr = NULL;
-		map->arr_size = 0;
-	}
-}
+void
+ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index cd38f89553e6..7303b4bc2ce0 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -2,21 +2,6 @@
 #define __LINKMODE_H
 
 #include <linux/bitmap.h>
-
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
 #include <linux/ethtool.h>
 #include <uapi/linux/ethtool.h>
 
@@ -53,6 +38,11 @@ static inline int linkmode_andnot(unsigned long *dst, const unsigned long *src1,
 	return bitmap_andnot(dst, src1, src2,  __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
+static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
 static inline void linkmode_clear_bit(int nr, volatile unsigned long *addr)
 {
 	__clear_bit(nr, addr);
@@ -72,6 +62,15 @@ static inline int linkmode_test_bit(int nr, const volatile unsigned long *addr)
 	return test_bit(nr, addr);
 }
 
+static inline void linkmode_set_bit_array(const int *array, int array_size,
+					  unsigned long *addr)
+{
+	int i;
+
+	for (i = 0; i < array_size; i++)
+		linkmode_set_bit(array[i], addr);
+}
+
 static inline int linkmode_equal(const unsigned long *src1,
 				 const unsigned long *src2)
 {
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index f5598c5f50de..b4419fb6df6a 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -685,3 +685,24 @@ ethtool_params_from_link_mode(struct ethtool_link_ksettings *link_ksettings,
 	link_ksettings->base.duplex = link_info->duplex;
 }
 EXPORT_SYMBOL_GPL(ethtool_params_from_link_mode);
+
+/**
+ * ethtool_forced_speed_maps_init
+ * @maps: Pointer to an array of Ethtool forced speed map
+ * @size: Array size
+ *
+ * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
+ * should be called during driver module init.
+ */
+void
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
+EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);
-- 
2.41.0


