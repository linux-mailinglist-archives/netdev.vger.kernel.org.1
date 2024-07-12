Return-Path: <netdev+bounces-111044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D707792F83B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5990B1F24153
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F39167DBD;
	Fri, 12 Jul 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hko0stQV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571215EFA6;
	Fri, 12 Jul 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777499; cv=none; b=ZVruLEAHMqfrLmvS5+YHd9FK7ticktk6KlNWYlD4NEjdpjRKZygwXYqE0I05I4nHZ0vpwbZ8IEUVkMMrJokdq2cGaw7rjvGJ9soSYpjKda1iyn2ogHXXtvgoPMZjd8eXGZUA12jzer2D6RvR90dojXqoLDTsjQOiQS0ZoQuUiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777499; c=relaxed/simple;
	bh=AzEg1UCC/dP12DnBBLeMU5IhLxJ7HG62/flm+CPRQxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4Z+veuIio2UeacBQtaldJCR5ccCapO+z0N2DUk1IeEJMrihqimwQrTHcCwgAWmS9WBTPJa10os+1LyBia5bG/xwJ4ETJcceYcpT2WYjbsdXIVhTpg0osw6cUgqppJOI73aqyCVeonUGqwQaOYxRztWOuGK9jzojAgcCv8Dp/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hko0stQV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720777498; x=1752313498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AzEg1UCC/dP12DnBBLeMU5IhLxJ7HG62/flm+CPRQxw=;
  b=Hko0stQVokAq4zXYd4G4ZHyZ1iWw0hv3rV3EUrwM7l5sjxy/pFNKQsyt
   qn0duJShQ6wIgdv0YCboiTBKb+K1JKtfDHyEFkxL58rw2LmFVS9+hWI2L
   6kllY3FG2/3t7OGyQeMg8xamN0vTzIIAgeGd1HY/WcYrAqjTXDE2d/n+t
   dfDrJ+w7w6SWnDvP0Fz5N9Ovyu1OFx2t8wLyarZEX4NAfwFL09sczcbnl
   VwUSctDdDAjTJVizJDAmG/i7erzsfEVoWl/d3k8lTGov76tI4Lil1iE6n
   ovpF7VBcBHtojQBQZNb84b2mWV0C1FacyeJVuywFU9S0TpdpfOqLUncfs
   g==;
X-CSE-ConnectionGUID: 9VvtpEvgSUiHwHC5pslnsw==
X-CSE-MsgGUID: weGpNFmVRJyRRLSGSbq7TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18076983"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18076983"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:44:56 -0700
X-CSE-ConnectionGUID: SkVpG3jGQG+ZVlZBMcwM1w==
X-CSE-MsgGUID: oLY91aF5SAa51ao3YC9fWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49524314"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2024 02:44:52 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1D6ED2F1F;
	Fri, 12 Jul 2024 10:44:50 +0100 (IST)
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
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 4/6] ice: print ethtool stats as part of Tx hang devlink health reporter
Date: Fri, 12 Jul 2024 05:32:49 -0400
Message-Id: <20240712093251.18683-5-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
References: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../intel/ice/devlink/devlink_health.c        | 32 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 10 +++---
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  2 ++
 .../ethernet/intel/ice/ice_ethtool_common.h   | 19 +++++++++++
 4 files changed, 58 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
index 41f203cbdf6a..2fbf6f08d0f6 100644
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
@@ -76,6 +107,7 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
 	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
 				     (event->tx_ring->count * sizeof(struct ice_tx_desc)));
+	ice_dump_ethtool_stats_to_fmsg(fmsg, event->tx_ring->vsi->netdev);
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 39d2652c3ee1..bc431e692b28 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1519,7 +1519,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 	}
 }
 
-static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
@@ -1897,7 +1897,7 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 	return ret;
 }
 
-static int ice_get_sset_count(struct net_device *netdev, int sset)
+int ice_get_sset_count(struct net_device *netdev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
@@ -2000,9 +2000,9 @@ __ice_get_ethtool_stats(struct net_device *netdev,
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


