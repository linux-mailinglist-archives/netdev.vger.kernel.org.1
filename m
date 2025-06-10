Return-Path: <netdev+bounces-196215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD748AD3DF4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E9C177BB8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC623D28E;
	Tue, 10 Jun 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DtuaPGXP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503C1D5147
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570868; cv=fail; b=fU3cZqYqGhOsXKdMZC8Eh8cilqc/zFMWwdgbiBRVKVU5x0cq+kZnKq/zNDvN1xaEMn6o4Tm5UANr13RmiIiLqollh9mUClHE76xXJD01mKHdeoiJKSlJlQD6U26iF7TlqevCtYh5PRQnMSxRXb8lOxnA2ldDRGn4Xd8XlJStYYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570868; c=relaxed/simple;
	bh=53e/SkcU9GVWAmxkc8Dlfem5RjM1YE/Ybh0a80UhlNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiXpWxUY4blg7w8NAqXdd0J5ssZi6lwYTM7lKlKU3plVHT92zLWu7yhc0Oxds3jGAjoE0o+rNAm9GVANLZg0XXqcWzJC6AiCpbdrJKDvAVOQtJaIYjNONohj+MHYrYGMpTDUhQzkOTkD1+8QJEBy7Zd6DV1u5OpJCpY+fXbDXbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DtuaPGXP; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0g80Hmjcg5QurtePCGVQZakWpHkt5oDrBz3fFM0CGLI+lK4PTlUz7XQSaVI/lLrDV/dTZpS+x6zuD+89d17Ug1onvGKeMZPFVsYC0/4tueRyeOTU6iWP2VYg9UkMPtPp5TA3uXMrJUj06qjJxU834e3Zs9E0wGNOK8BK/ewIbyp01Zt1KKmMghxNGwFDbk0HI0EqNSUusIOSSrnMeFOWwz1VzGodQiH1NnIWNZ7jzpsr31JPLOuWe7YLVmqrMuBb0iD8kHJAhiqvVwhDcPCWMqvuK52kDaZ0HTILTAuWoMT5KUiUMh17mvy7ZWA9jKTOgPf5mIaGEnlFNd2WAa6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBm1Yjz+AMuGPu0ugcbaLmS52D9Tc1+tPwgV7I8yvZA=;
 b=BNNfa54+W49JRVGNrGAdDaZp6oNqBXwwfhjbnqw0AWl8Cc4W0AfArt3aphZGxL2e67MyIck4TWP1LX8M3AzTroZ5m66eGt1hMHG2drNHkTiqEfNd1p02qEv6URDExVEjpFZUshvx3FtFs4e/P9zd7Mrhb+/Fz/nW3KP6kUtrsT5rGawtseLEgv0dKxyUotsQxBVryYY3oSnv4PJZlACZ3iM+Q1IV73evOnTfgQf0Ptyt2XckRv4Cc2qXeYVGD0FON7r4QMfmB6aBGIbvonwR2BO+w1HvSWubUJgx2eEFxFCbc66Spuxpr9bJ7iMkGFGs52KsDRiT2s6yJcs05p6PMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBm1Yjz+AMuGPu0ugcbaLmS52D9Tc1+tPwgV7I8yvZA=;
 b=DtuaPGXPg02Uc0fzxQ4Pd44P45AvswWwedNhofv0cvopSFpjCwqPm3xlJtXP0aAIvX9varEEwKV2S1qhAerelDcP2uEjoXOJyMJKRHh8oWCrQQykx+htODzHBdqVJ8ToQUb0SLlCmzIK7BBVJfBGd9xOaseXlack7nmN73eiNvNP/d63naC1yLKJOMcf/HsRDvOpTVP1sB9xywebU5aCzE7TwF/naHQl5bOaT09JMGTq4LraIvOfOhOelWHWhYm8uW0ilEcaJiOSUavA/B0UQ/VBGfpi08/hEBerkdf0TN5RtNGbbt1jkzeClsNMVPVYXMj1fcE3zdBeYY4rIQpM/A==
Received: from BLAPR03CA0102.namprd03.prod.outlook.com (2603:10b6:208:32a::17)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 15:54:22 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::f9) by BLAPR03CA0102.outlook.office365.com
 (2603:10b6:208:32a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 10 Jun 2025 15:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Tue, 10 Jun 2025 15:54:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:54:01 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:53:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v3 3/4] lib: bridge: Add a module for bridge-related helpers
Date: Tue, 10 Jun 2025 17:51:26 +0200
Message-ID: <8a4999a27c11934f75086354314269f295ee998a.1749567243.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749567243.git.petrm@nvidia.com>
References: <cover.1749567243.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cac60c6-dc96-4e51-6047-08dda837115e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8jxKYxHQlxR0MKkRsR5w0zN0UQE983h4w4jrV0WXfWdvoO1NhgV53nKJA46M?=
 =?us-ascii?Q?+u1dHJ8jKL789cCkY9k+ZRogfrfM3hLrVlDtFNfwFq0Gg8abZOt0yDsIGtiV?=
 =?us-ascii?Q?Z90eGEvUGeK1Htzv/gXtM+VkbNB/VEjCDIAEyG9Q66VhZyCfSEsIOMluNkxm?=
 =?us-ascii?Q?V+fc3igBj7RZVQcnh6s231Mc6rDwNzzquQER/JlQWL+HLApDuDB3QGrGDG+n?=
 =?us-ascii?Q?eF/jlci1P/JD2DY9fx3Koh097pCPhZgegszSmarW0Sys9qqetKPbj23VzYd1?=
 =?us-ascii?Q?pojnoqILbNkj/yUgqHKeZx20DuNKImuL5Y3pilElyXA6mdu6/nBtcyguLmiL?=
 =?us-ascii?Q?OnI7Il7X1zRRv3361+P9lxYkegkTqZlLjxrgI++qkfHnmUbZ1OQbnLxqlnh2?=
 =?us-ascii?Q?9PXSXPZCIYATXLvk93U0ipcG/hEHJcXO+D9rsvOZz83Efb0Hffl0YFFCHaXF?=
 =?us-ascii?Q?UYEQiD5ERfsmkK/01OfqHqa+VBPPjUY4kMajI32A11M8RH3MQqfzCE5XgOI/?=
 =?us-ascii?Q?NZTl52fCPFIrxpO9271L3onqQ/ANmXHRPx3xJhzD57PdiOCQ96NhG76ROyU/?=
 =?us-ascii?Q?3GwgY4x44mZBJUXl/gpaTdmSsnhaFxIeFspooX/c0tAPoqBSDFgpK17aB+a3?=
 =?us-ascii?Q?G029zMfUO/mczp1lp5h7/PUQ6CKGOD4mj6285rPoqwUUXO+IC8apBtcx2ZjI?=
 =?us-ascii?Q?cOrVz1LpsK216hpAuEudAcYADwpDYW0LcTeZEeXqWNpqomeMDIoV2KZJ3Y5F?=
 =?us-ascii?Q?9fK5ujsLerdvS5l9YPbEIRn683rbryq9F53ew2InZgnh/R7hVCJjWgFdaCK+?=
 =?us-ascii?Q?7+qsGQLW0p7ljLhPgIx15ZAp/oeGbLIYmdrPCKxaYEdYou1l6uvxerGMMJIn?=
 =?us-ascii?Q?iC3KDBJbAcxzzHSUWO+3CBJh8isDiNyKkCEPWjj0GJLrWhCqa6YUJfCbR9Yv?=
 =?us-ascii?Q?0crgvSDmjUJz7DZcgi17Jp7Ga2ERBLGDNHdsj6Wogpjb59ZELQf0U4G862g8?=
 =?us-ascii?Q?pqXUsiIGdk+6xT500vztiJYMGaP+DHVVigRRqA2Pvh5qVJZZLUJLsRuO2Z3g?=
 =?us-ascii?Q?+1e0g7J3Ot7ucp7Q1IIU+bf/oi6lAuGZakyvxlYynoeqZei7ShVmfdqGPh77?=
 =?us-ascii?Q?wV7dRL/340MshtJNz4j0GqOrgmNqquVvfH8y597/kbFQUt15fwh1y0Rh6Vb4?=
 =?us-ascii?Q?EnRkQ6inj8bqoBv0yIdJ06Xz3BdAnffVS8UMP+hgkXaKY7cinmxfmHHrX8lB?=
 =?us-ascii?Q?y+Ge1GMECq/9jdbVz54udfTQiOKGCZNaZyZYLeYuMCxhzZzVEHqb3t3xDpF6?=
 =?us-ascii?Q?LSduZi/yqAE8vdhXVMTx89zciJlV810Z5xUsmJwLj8GVr/senGKSqDmJpl3q?=
 =?us-ascii?Q?rlIVX4nbOCxV6+BWli0bA0B2l6KdFHLlwQabqpVkY0X4BZ8418he6wuIm2+X?=
 =?us-ascii?Q?cY/zbPbKXpVzWcMra+Z1La3Nf55O5Gb/DOsXD/VFLm90ZhL8cHYlTWFbgvHU?=
 =?us-ascii?Q?K/geDccFVCcARaM0ikr2/tnrrSYHdgpz82nu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:54:22.2552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cac60c6-dc96-4e51-6047-08dda837115e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568

`ip stats' displays a range of bridge_slave-related statistics, but not
the VLAN stats. `bridge vlan' actually has code to show these. Extract the
code to libutil so that it can be reused between the bridge and ip stats
tools.

Rename them reasonably so as not to litter the global namespace.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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


