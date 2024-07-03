Return-Path: <netdev+bounces-108864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0666926189
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713ED1F2543D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A4417B4E8;
	Wed,  3 Jul 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAM9WdbF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1817A926;
	Wed,  3 Jul 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012365; cv=none; b=MjAUdgJt7EDCC1Wuqwi+05jWH4QGh+/OgqXLG2aOiXg4sX9v6riyoDcYzbOAo7/MMlFw2kcXqUfUGMYXfypSYhom82HQ8eTXuy8mg1Ys2TSJRq4Ui4OFJQlpHZ2usWXhFFdZVl2dvV3P58uCYsuKHEfBl5cTqcM0dMOorVQirnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012365; c=relaxed/simple;
	bh=6YUvj8x7CBc4d6PYcb7HYz/bfW3oASOIRH1WMVTGBOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJX1ePkOK468Z9bAS9baSZ0ejfu73qCMvcFroFjJw1uGE4zOM0VVdFZ804SCvDDtWvN5g1OM5ywBzTjz3y9kz/dxkDcopnUt3bDibccBuinI/rpbI6csQtwGvYrB+77LXmVrzoMvC+IdKXaYnfEAEVRror37adzsYAU19OC7KmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAM9WdbF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012364; x=1751548364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6YUvj8x7CBc4d6PYcb7HYz/bfW3oASOIRH1WMVTGBOA=;
  b=bAM9WdbFBashnYFasvu4UcvK3pYUBRfzxf4DMJni9mXAiv5snzSYCoF1
   vzlFomu5dTsk7VvveCtdsHE5ceEPyXZE+mthKH8n7qF+RUE9PQbCexpoB
   +Snz0gArI5wHq09jCsG/1YzyZWPJINYImvEJb7oz7Pq1k/7RLOI0vPaDW
   D5J0bXLPbTyqu0tXXUxm2B4aol+Lf12+/+CwT9wGFPNSJZPpDTQqQ5JgL
   Or4i2XwEYKIk2Sz+DtIeKrDTV+2+d7Eu8mgP571Qfe0WgntBY1Z4Bu2s7
   fcVsDB0S5J1Zv2wwX7EDBzBHJHlbbFcNNeMa1jLI5EuwZtu4ss3fC/o0h
   g==;
X-CSE-ConnectionGUID: mNFIUwrUTCGY5yqwfdgg7w==
X-CSE-MsgGUID: 6ryBHBYeTG2OgTo/4sp0kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27857142"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27857142"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:12:35 -0700
X-CSE-ConnectionGUID: h4paI16NSVaZ9zbM8ZjjRA==
X-CSE-MsgGUID: cWdv3/j9TByEALayr0azhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46321589"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 06:12:32 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A0B812877D;
	Wed,  3 Jul 2024 14:12:30 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1 4/6] ice: print ethtool stats as part of Tx hang devlink health reporter
Date: Wed,  3 Jul 2024 08:59:20 -0400
Message-Id: <20240703125922.5625-5-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Print the ethtool stats as part of Tx hang devlink health dump.

Move the declarations of ethtool functions that devlink health uses out
to a new file: ice_ethtool_common.h

To utilize our existing ethtool code in this context, convert it to
non-static.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../intel/ice/devlink/devlink_health.c        | 32 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 10 +++---
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  2 ++
 .../ethernet/intel/ice/ice_ethtool_common.h   | 19 +++++++++++
 4 files changed, 58 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
index 311719e69ea5..d6956bba1da2 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
@@ -3,6 +3,7 @@
 
 #include "devlink_health.h"
 #include "ice.h"
+#include "ice_ethtool_common.h"
 
 #define ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, obj, name) \
 	devlink_fmsg_put(fmsg, #name, (obj)->name)
@@ -32,6 +33,36 @@ static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
 	}
 }
 
+static void ice_dump_ethtool_stats_to_fmsg(struct devlink_fmsg *fmsg,
+					   struct net_device *netdev)
+{
+	const u32 string_set = ETH_SS_STATS;
+	u64 *stats;
+	u8 *names;
+	int scnt;
+
+	scnt = ice_get_sset_count(netdev, string_set);
+	devlink_fmsg_put(fmsg, "stats-cnt", (u32)scnt);
+	if (scnt <= 0)
+		return;
+
+	names = kcalloc(scnt, ETH_GSTRING_LEN, GFP_KERNEL);
+	stats = kcalloc(scnt, sizeof(*stats), GFP_KERNEL);
+	if (!names || !stats)
+		goto out;
+
+	ice_get_strings(netdev, string_set, names);
+	ice_get_ethtool_stats(netdev, NULL, stats);
+
+	devlink_fmsg_obj_nest_start(fmsg);
+	for (int i = 0; i < scnt; ++i)
+		devlink_fmsg_put(fmsg, &names[i * ETH_GSTRING_LEN], stats[i]);
+	devlink_fmsg_obj_nest_end(fmsg);
+out:
+	kfree(names);
+	kfree(stats);
+}
+
 /**
  * ice_fmsg_put_ptr - put hex value of pointer into fmsg
  *
@@ -77,6 +108,7 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
 				     size_mul(event->tx_ring->count,
 					      sizeof(struct ice_tx_desc)));
+	ice_dump_ethtool_stats_to_fmsg(fmsg, event->tx_ring->vsi->netdev);
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d1940fc6f2f5..91f16396e20d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1522,7 +1522,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 	}
 }
 
-static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
@@ -1900,7 +1900,7 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 	return ret;
 }
 
-static int ice_get_sset_count(struct net_device *netdev, int sset)
+int ice_get_sset_count(struct net_device *netdev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
@@ -2003,9 +2003,9 @@ __ice_get_ethtool_stats(struct net_device *netdev,
 	}
 }
 
-static void
-ice_get_ethtool_stats(struct net_device *netdev,
-		      struct ethtool_stats __always_unused *stats, u64 *data)
+void ice_get_ethtool_stats(struct net_device *netdev,
+			   struct ethtool_stats __always_unused *stats,
+			   u64 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 9acccae38625..fd021d2813f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -4,6 +4,8 @@
 #ifndef _ICE_ETHTOOL_H_
 #define _ICE_ETHTOOL_H_
 
+#include "ice_ethtool_common.h"
+
 struct ice_phy_type_to_ethtool {
 	u64 aq_link_speed;
 	u8 link_mode;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_common.h b/drivers/net/ethernet/intel/ice/ice_ethtool_common.h
new file mode 100644
index 000000000000..0c772056f006
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024, Intel Corporation. */
+
+#ifndef _ICE_ETHTOOL_COMMON_H_
+#define _ICE_ETHTOOL_COMMON_H_
+
+/**
+ * DOC: ice_ethtool_common.h
+ *
+ * This header is for ethtool related code that is reused in other places.
+ */
+
+void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data);
+int ice_get_sset_count(struct net_device *netdev, int sset);
+void ice_get_ethtool_stats(struct net_device *netdev,
+			   struct ethtool_stats __always_unused *stats,
+			   u64 *data);
+
+#endif /* _ICE_ETHTOOL_COMMON_H_ */
-- 
2.38.1


