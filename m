Return-Path: <netdev+bounces-195786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FDAD2369
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7353B3036
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727D218585;
	Mon,  9 Jun 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tmNGK8v5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F5182BD
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485292; cv=fail; b=ouFwdgnMPAjRB9DmrKSTeBTHq7H0lOsspUfkfAUm8YuPGiJJB0N7nJm7Y5wq/paWIyAnS5eYe+nwHxLJ7AYeFrKF5USaJa+2MpGxBpqd79ObSU4krs1cMTjRQCL5bWmOCSfSWBBfviceB6VqcNoILdy8N73XQGF8ATkjJpR6ZtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485292; c=relaxed/simple;
	bh=/w/Gau1eXlNL2y9bOpaIXxjwqgWltU6Zlftvj2NcxdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHmcW0L246FvTMY7g4zidVValErPTKxsWPQHLHIEb5A4skq0Yq6L2aZYr/o1qoz+r8a1FCw2oIZIpCXcQOSH3BrKLDqdS1EeDd1dXHVKBk5EO/pVjlS6b4BwKi4m56t4bP4nN/DjmRkxHpk6N02B37b+EfbTpS/nhXeP+CQzZZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tmNGK8v5; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gs04lDMLGf/0Wl8McIfIIHxjfezwzvjkWrnvSqQ8Rg6C50O6bveYL6y0h41IplUK7GoE62e1cn2p3dfaSmhJda/rI8xD2EqoYnph7crqIiClEJJBvxVwm5u0Ndp8IXlL4+32Ey2+DRrvPO+bTtACP8y2FYOXCtTwryHM0bE1mzuzLMCgo3n88M9LS2Xm8OAtxDIBaOs/RFE42iK1rG6dmN+X0ixLwdl/2DTAAqZc7tRbtiR8s66ylkROoc84JtKCSFIFborGAngj+46qM1QrE1mQnbgK2wj7H9iVx0WE1Kt4xJhCScqSTXSZufOXeuDETEiNsiITtKgx/cwd9CsG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQQJc27+j63IHI6AWLpoVSvUeRkaVrckVktIhDzMKzI=;
 b=PLkxNT5LNd9+J5D+nK9tmhAjnz4Ic3nhuxckve2GcpWOKYJqRG4cjY5hIYmAs3i6sOCUG1ViOSTa5T8Z7npuWdpwLVxwwyopGtz/kxReXXQhXKCwuecHv0+hBxLK9XCN6t2PEb4FMzqPjryTeie0jqJ6yrl5C0OU4dUKTonMkZRmfgk3YwWUerJzsijhp/24qQhDHWkoAqC6VWUejaN/n22IPQrU0A4iMoaJM80u7DwkP3iEoSXPCkKwRGMFihXG/tigz0p1Af34e4f2Kzu8q3/DYqxpb5hvOEDenbCF+h4jwNlRK5aSmC8t3cirs/MR8TdYe9kI3DDe4/HQgULyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQQJc27+j63IHI6AWLpoVSvUeRkaVrckVktIhDzMKzI=;
 b=tmNGK8v5HBUWJMh2tFtk8hR2QyXm87LD6oAA+1YvGLfOMG299otdDNN0KWLco27Evma9t87m+3h1ep+NWkCGzRMFEa7T4zOSQTmei+PfY1bM2LQJbHxWoZ9tnnuwxllEmVF/RPPTSvbqqXRHHXxU0ASC4wnB8b/FQtPZ1xTBiSc01z1vu9Fmg4jNyFrwSa6ZWm5zqGjLSRKTkzMNoW1Po54O9VRoEFb+7x2FlpxQvApCG+ED6zHdYwEKb/fIGZifx9SBge7iIMa6vk/QQ7kepM26UVD22bnENMpF2/C0HIVrVTuK+S4PXj+Kev0XQ0+/aI1pIkNdrhyUYwoC/zW9Sw==
Received: from SJ0PR05CA0101.namprd05.prod.outlook.com (2603:10b6:a03:334::16)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Mon, 9 Jun
 2025 16:08:07 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::46) by SJ0PR05CA0101.outlook.office365.com
 (2603:10b6:a03:334::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.8 via Frontend Transport; Mon, 9
 Jun 2025 16:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 16:08:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 09:07:49 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 09:07:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 3/4] lib: bridge: Add a module for bridge-related helpers
Date: Mon, 9 Jun 2025 18:05:11 +0200
Message-ID: <b50c8fdb2fed1c8d47f06ee139f26fcb263472bb.1749484902.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749484902.git.petrm@nvidia.com>
References: <cover.1749484902.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 80225753-078b-4d0a-92f7-08dda76fd263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4VSuSrx4qvcxY4WdLhwmdmpMmqd0ltREIt0CzNLKHglOprtUcn72WoRb0nxF?=
 =?us-ascii?Q?ZWCB3NhDbVZc9DR7JtdFYdPrHGODiGXZdhDDVYXwCIponYCy7oM76rstkn+z?=
 =?us-ascii?Q?KEDkD/DOjkdeRR5r0NMWxkeFmBEfdWvo/RUhyp7FJy92iCJGORbIktXeJrup?=
 =?us-ascii?Q?rmnIxf2Qk6aTVQWiy4dz/PaCwQUYGBBGanM7ws42FY/1vbq4r9RFntrOiJVx?=
 =?us-ascii?Q?efWpklorleGoMmOU9fA2FL2My2pxIKFeGtjrJYU/6OZYU7xQNwv/Kme7z+8Y?=
 =?us-ascii?Q?WnuSax6tvFs4oMyFUhlC0xyzozfa+QsmNn0FWENCZR200ggzZb1jfQx9633l?=
 =?us-ascii?Q?APeHwR5Wwvmg5JQF8Ij+mqDt+eicGFwOAUG0E0d0eyJyg4foMUMPeItYfjZZ?=
 =?us-ascii?Q?wKwMwN8HTlWsqJK/XVexU6aqJVkDX2HFs431nwb6eFnn4InbcGmpkpJZyknA?=
 =?us-ascii?Q?QrBR65skFXfKp7/yNGcTXiZjtoNpVrK4JWvGhXtJrW+eoUCsZQNgQ70sHWt9?=
 =?us-ascii?Q?QSjLYpQ/kNnsgMhlKEbOYpxyjB26xww4IQm3mg6vfW/hnC38Q33VRMREdlG7?=
 =?us-ascii?Q?wA0O1TzU2qHzEjqAojGrla7PBHUzG01SFmOIyecx917R5+n1CZaH/cN0M57x?=
 =?us-ascii?Q?TVSd5yOgrTjudVek1H8S5T36P7ADt0C5+5I6+RFhiORG+W+5jfP65Rc7RS3x?=
 =?us-ascii?Q?PHE9iqFF8XVTu4ACi14tcZ7TjKA1bw8RrWnPrd9ieGgbLmmdJsao6b7udaaK?=
 =?us-ascii?Q?EaiyU0roPZnV+Q1OFTlBH+6hfE0XvmSsaRa/2eWUi62ZAXwskUHYKQnFYxJq?=
 =?us-ascii?Q?DT3MBiR6hrZkrfEwIdUtnwYpo7uwLrUgOHuFG6P8R0ZqDMlHf99ao6hagIOa?=
 =?us-ascii?Q?MOX3JYVGTA+EnKEq97lDjIidyvS9V2ka6dBwkm/c4A/7NkJ4130iGLovsyym?=
 =?us-ascii?Q?LdSpuEktPWX1gvwVf7mC0kuf8zx6Ukw4dyJIl3a35HBWIhB8kX6d/0iwff4r?=
 =?us-ascii?Q?Tq/gWCBycj0ckW+0P5jNnjanOp2Dj8ThGackJN9Ol6mR6tGV0TUWPJBFo9S6?=
 =?us-ascii?Q?N4DOlbFhuNHXOGoVeWEDGe7KO2xITZArHYRC837UDURxXHqZwc8JkLsX9s9D?=
 =?us-ascii?Q?F+FtO/x0Z2gT58knZGfA2i+pkc9dggwYZLk+ZibO+xlwnuy6DZBn+lkc+5tt?=
 =?us-ascii?Q?znvYG5y8yrK8RxTQDcocR2EgVDND22rSGGvk4EMiNwfoslnlEKJLu8E+d8ov?=
 =?us-ascii?Q?MqgQdROPBMp1GC19wkLLPS8/t614jkW+zcT3H+He5KCPlNdDRPC0oD5yDBto?=
 =?us-ascii?Q?q5sRmdV6Ddy2EjPKhntZKImCCIFicKVHR2yxfcEkwmyi+zZjGGlamhqmG/08?=
 =?us-ascii?Q?O8/vfQrN1L5VTPSixwiFlZDXRjf6ZSmv06jSmBmDSq4Wz8OnTEb5rLHuyN54?=
 =?us-ascii?Q?OTDGQSOVWouVyyhWt89rrDm7US80+SMjR7lX6xOCJM3wm+oPql2j2yCdPYy3?=
 =?us-ascii?Q?+CneIqsdOqcgvG3Y+NRCDxr9xvj0CDpQ23Zb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:08:06.8307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80225753-078b-4d0a-92f7-08dda76fd263
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

`ip stats' displays a range of bridge_slave-related statistics, but not
the VLAN stats. `bridge vlan' actually has code to show these. Extract the
code to libutil so that it can be reused between the bridge and ip stats
tools.

Rename them reasonably so as not to litter the global namespace.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Add MAINTAINERS entry for the module

 MAINTAINERS      |  2 ++
 bridge/vlan.c    | 50 +++++-------------------------------------------
 include/bridge.h | 11 +++++++++++
 lib/Makefile     |  3 ++-
 lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 46 deletions(-)
 create mode 100644 include/bridge.h
 create mode 100644 lib/bridge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c9ea3ea5..82043c1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -31,6 +31,8 @@ M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*
 F: ip/iplink_bridge*
+F: lib/bridge*
+F: include/bridge*
 
 Data Center Bridging - dcb
 M: Petr Machata <me@pmachata.org>
diff --git a/bridge/vlan.c b/bridge/vlan.c
index ea4aff93..14b8475d 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -15,6 +15,7 @@
 #include "json_print.h"
 #include "libnetlink.h"
 #include "br_common.h"
+#include "bridge.h"
 #include "utils.h"
 
 static unsigned int filter_index, filter_vlan;
@@ -705,47 +706,6 @@ static int print_vlan(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
-static void print_vlan_flags(__u16 flags)
-{
-	if (flags == 0)
-		return;
-
-	open_json_array(PRINT_JSON, "flags");
-	if (flags & BRIDGE_VLAN_INFO_PVID)
-		print_string(PRINT_ANY, NULL, " %s", "PVID");
-
-	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
-		print_string(PRINT_ANY, NULL, " %s", "Egress Untagged");
-	close_json_array(PRINT_JSON, NULL);
-}
-
-static void __print_one_vlan_stats(const struct bridge_vlan_xstats *vstats)
-{
-	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
-	print_lluint(PRINT_ANY, "rx_bytes", "RX: %llu bytes",
-		     vstats->rx_bytes);
-	print_lluint(PRINT_ANY, "rx_packets", " %llu packets\n",
-		     vstats->rx_packets);
-
-	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
-	print_lluint(PRINT_ANY, "tx_bytes", "TX: %llu bytes",
-		     vstats->tx_bytes);
-	print_lluint(PRINT_ANY, "tx_packets", " %llu packets\n",
-		     vstats->tx_packets);
-}
-
-static void print_one_vlan_stats(const struct bridge_vlan_xstats *vstats)
-{
-	open_json_object(NULL);
-
-	print_hu(PRINT_ANY, "vid", "%hu", vstats->vid);
-	print_vlan_flags(vstats->flags);
-	print_nl();
-	__print_one_vlan_stats(vstats);
-
-	close_json_object();
-}
-
 static void print_vlan_stats_attr(struct rtattr *attr, int ifindex)
 {
 	struct rtattr *brtb[LINK_XSTATS_TYPE_MAX+1];
@@ -783,7 +743,7 @@ static void print_vlan_stats_attr(struct rtattr *attr, int ifindex)
 			print_string(PRINT_FP, NULL,
 				     "%-" textify(IFNAMSIZ) "s  ", "");
 		}
-		print_one_vlan_stats(vstats);
+		bridge_print_vlan_stats(vstats);
 	}
 
 	/* vlan_port is opened only if there are any vlan stats */
@@ -1025,7 +985,7 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
 		print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
 	}
 	print_range("vlan", vinfo->vid, vrange);
-	print_vlan_flags(vinfo->flags);
+	bridge_print_vlan_flags(vinfo->flags);
 	print_nl();
 	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	print_stp_state(state);
@@ -1051,7 +1011,7 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
 	}
 	print_nl();
 	if (show_stats)
-		__print_one_vlan_stats(&vstats);
+		bridge_print_vlan_stats_only(&vstats);
 	close_json_object();
 }
 
@@ -1334,7 +1294,7 @@ static void print_vlan_info(struct rtattr *tb, int ifindex)
 		open_json_object(NULL);
 		print_range("vlan", last_vid_start, vinfo->vid);
 
-		print_vlan_flags(vinfo->flags);
+		bridge_print_vlan_flags(vinfo->flags);
 		close_json_object();
 		print_nl();
 	}
diff --git a/include/bridge.h b/include/bridge.h
new file mode 100644
index 00000000..8bcd1e38
--- /dev/null
+++ b/include/bridge.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BRIDGE_H__
+#define __BRIDGE_H__ 1
+
+#include <linux/if_bridge.h>
+
+void bridge_print_vlan_flags(__u16 flags);
+void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
+void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);
+
+#endif /* __BRIDGE_H__ */
diff --git a/lib/Makefile b/lib/Makefile
index aa7bbd2e..0ba62942 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,8 @@ CFLAGS += -fPIC
 
 UTILOBJ = utils.o utils_math.o rt_names.o ll_map.o ll_types.o ll_proto.o ll_addr.o \
 	inet_proto.o namespace.o json_writer.o json_print.o json_print_math.o \
-	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o ppp_proto.o
+	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o \
+	ppp_proto.o bridge.o
 
 ifeq ($(HAVE_ELF),y)
 ifeq ($(HAVE_LIBBPF),y)
diff --git a/lib/bridge.c b/lib/bridge.c
new file mode 100644
index 00000000..a888a20e
--- /dev/null
+++ b/lib/bridge.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <net/if.h>
+
+#include "bridge.h"
+#include "utils.h"
+
+void bridge_print_vlan_flags(__u16 flags)
+{
+	if (flags == 0)
+		return;
+
+	open_json_array(PRINT_JSON, "flags");
+	if (flags & BRIDGE_VLAN_INFO_PVID)
+		print_string(PRINT_ANY, NULL, " %s", "PVID");
+
+	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		print_string(PRINT_ANY, NULL, " %s", "Egress Untagged");
+	close_json_array(PRINT_JSON, NULL);
+}
+
+void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats)
+{
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
+	print_lluint(PRINT_ANY, "rx_bytes", "RX: %llu bytes",
+		     vstats->rx_bytes);
+	print_lluint(PRINT_ANY, "rx_packets", " %llu packets\n",
+		     vstats->rx_packets);
+
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
+	print_lluint(PRINT_ANY, "tx_bytes", "TX: %llu bytes",
+		     vstats->tx_bytes);
+	print_lluint(PRINT_ANY, "tx_packets", " %llu packets\n",
+		     vstats->tx_packets);
+}
+
+void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
+{
+	open_json_object(NULL);
+
+	print_hu(PRINT_ANY, "vid", "%hu", vstats->vid);
+	bridge_print_vlan_flags(vstats->flags);
+	print_nl();
+	bridge_print_vlan_stats_only(vstats);
+
+	close_json_object();
+}
-- 
2.49.0


