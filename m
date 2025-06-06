Return-Path: <netdev+bounces-195464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81B7AD04EB
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8047AB2D0
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357C289E02;
	Fri,  6 Jun 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nGDeeGh+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8F289835
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222488; cv=fail; b=sw9nhdeuQetMZPx55qHpTTPLf4LQsO45ciHEFueeW507UKSh4n8QLVMCtPwzP1tzqX4PYHXO1jqStTUltJ0Xg7tQ8BXFHubmgf0GWFPB9xIvwlBd/JuIUfdTunzrYcJBVo4OZsHvXqDJZk52t8u+4xXvqhsieoU/c7xcfSSFXsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222488; c=relaxed/simple;
	bh=Wc03XdL0nMmB2AL2mJQbq/VMqBko2++mr7g1FIQ2VmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA32kqxcnu4LzjtWPlAbGUr3F7qrxyJtXZ+BckL2N0j9AGG+CSk7hrptweGQ5knruryEtYoXdbFj2Fv2uEONsPEvTML43s7NhHoksDWlt9no7Q1liFEhcPHjtBvQx76E/7CxqQersKE0uWh+KEmsJRhgu822Mgd8cy9P7Kv1dAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nGDeeGh+; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9w4ik1R7fLJmwXUhIm7yj8iks88xZyaecHh2m8OpV6/GYO8wXFiPxR3xL/qVP+hsu0WikN6/ycp87dh/HxW2Y0SLxLQSdT5o1TorzbosNn39jdiJO74KYt6Sp0kETu6oxLKzII7DKgJ67q47QPuBztZLR8q2NRdwkNe+HYL2DzUPU5MMnPugr93W9OwG5vdM5EAfTs5NQSTa4sv4QieydZ27io3D5l9KmiGN3Y8VhXqBWeHAN7+VfEWYEHElKS+fONLjh1eh2RDZqdpq5wxJiT46v73iFNoXyLfCtxP8uCoQzG9uwrDDddgpaS5zBzdJ/D4r62AvbSkS/Rk9xHEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg+z+Wy5WXyU6eke3cVYKf0xIMCnga9KNuN4cqaiWVA=;
 b=Ji2weSJhIoyBxIiZTFPXlqnNNVO5VVWMl3khYbejdd2J5757lfqekQ04sfmA+IOt/hYH9Z2jVruUeqP52lOhUPaMK183Y8AKFF1HmVWiNIWPaUbya4V0KRQA34Xbx5062BMxmgQsBS0JK8k5119O6Kz8VNjicn+2guyjMRgmzdDVRl/3Ths9jeQNkxkRonNX3UuGhEg8KNoNStVa7GmthoiHOaYzOYvQW5e1JdTuyfD668S9eufkjAnwiKerK71amUE2SXMsV/dj33ayQZgqqJbU/9WUBcTFu0dTxSAg2iMhCfazZT7eZ9soK8k2N56mzPYaoGcFX/J5sOz8N0o+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg+z+Wy5WXyU6eke3cVYKf0xIMCnga9KNuN4cqaiWVA=;
 b=nGDeeGh+J+8OADHVqGkns/4ymdN3lzAGjZHChLg3HCgkgoSNbQzMIQ078259eHpJkgb8g5dLtaOs29+D89+EVB6pJZUJAJEbIiWCxVfbrYG92yAfModJVrsRrirx9GKE22s3f9NHiCVClLhBb7zaqvDtR7Q8lq6beltjGnExbTmy4LDU4Bv1K4XPGuhUO12dAC9MLMMOhFjBw4XgzHHCXqmsCoC3gN2ji/uLkAd6TDihWhOMjJUhHZK2wagNmW6etiSWwF3s7h7d+pRX0vhvF+Ek7vKvrKXBjHk0jpAvir5XS801yQW5rCRKzS8vxKDomPvblaQt/WxARZeK6sdv2g==
Received: from PH7PR17CA0009.namprd17.prod.outlook.com (2603:10b6:510:324::17)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 6 Jun
 2025 15:08:02 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::2f) by PH7PR17CA0009.outlook.office365.com
 (2603:10b6:510:324::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.40 via Frontend Transport; Fri,
 6 Jun 2025 15:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 15:08:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 08:07:44 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 08:07:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 3/4] lib: bridge: Add a module for bridge-related helpers
Date: Fri, 6 Jun 2025 17:04:52 +0200
Message-ID: <5cc3cf81133b2f1484fbdadd29dc3678913ce419.1749220201.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749220201.git.petrm@nvidia.com>
References: <cover.1749220201.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d1f601-4dbd-4139-d353-08dda50bee55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RRFJL8CTEsxrCsz3xISbpJdw90EYfO3D8O3oKWnVEpd6tBx07R1c9HhDMMPj?=
 =?us-ascii?Q?DRHFq/lE8muYGOJxFtVvGJMuvg4woh8RpAQ7alLgw/x00Pv+TeiLG920tXz8?=
 =?us-ascii?Q?eJIcpKoGXm9V6T51u2/kcB9RZDRTdlSxRf5z2xrHtgbrQKGfh4iA1IZAC39r?=
 =?us-ascii?Q?2vcG8sB+qexnJe9Hj2Tb8LZWav5tKXGWZjb1JhMYneQF60X81UEq9Y3ZWso3?=
 =?us-ascii?Q?8Sf+ul9bGrw4QXvSrq1sIfzeawy9SRZiAxXpnyzliZFv0JKNTYImBl3Z4X5i?=
 =?us-ascii?Q?aus5SOhico6lyEpVUi8MKefqxm0IHqAfNO96zU6KOo/Io3l0GIdTGJSuAXu7?=
 =?us-ascii?Q?URNxMz3dORcgQ6qAUJHPyDpR1fdvPMwxv+LRcaJFDfJSPC5oF5Lb5U8zBGp5?=
 =?us-ascii?Q?PncxA4NUU/PKYbLJBGohIXUm06M9rqXITtJh7Gbe+TnIEh02dsqBokDbmneU?=
 =?us-ascii?Q?u8R6o+kSZAwuKNVjT9TPqceD+IP5cUeCxwmSZ8X/Ck+a5y07Nf6xJJdO78og?=
 =?us-ascii?Q?0U7MJ8FqeJ7ioOT0jQceJCe/F3UN9HkR35DKEaGB+yWzstbGrYNmC5e/CKHA?=
 =?us-ascii?Q?0vYVy2xDotFcoJyKPtJqb9dK4zW1PaluMNIsgAoGlvgLrfw5QUn9/eGlwCOr?=
 =?us-ascii?Q?QfNrw5ncl9KLP+ymWMPMPvPdf3n5cqaxheC9vK0VFKBw1OVI05VZZ0p6nrYi?=
 =?us-ascii?Q?enHkI0Z4VLd0Oo1Lu2KxvCNs0GFqrwPNg0ErQ0dGa3hVc4omyWmqisQFanWV?=
 =?us-ascii?Q?SihKAp+dqMSmyaUY9qBz1PJiLrTG0MErkkvkC5ctEkJz1D+ypunUsrM31y3X?=
 =?us-ascii?Q?ImQb1gnvSzlHfXf+3fpgzMQ0NsxfY7Q1QRgarZY96bNsP54pQO1fUOg+oONV?=
 =?us-ascii?Q?PR9jSKzt5CO6ca2h6G0LD+CufTfsEw8sT1WW4qxk4M8mgmyVTErxYeyyV+9m?=
 =?us-ascii?Q?MQJSPfj0Dh6r5vsuJDovtVZ+OB4UcYOgSQh1xQcL8xw7QfkQnze51rDqqRHJ?=
 =?us-ascii?Q?zAb6HLjxaCHWEm4WzppCsVUZVFZTv+6FPMEp74pFnd2ggyd9pqnHkWShzmKY?=
 =?us-ascii?Q?7jeY8CIQ5TYMEqoL4B07KhYSv/g5Bm36t72afOCkm3Z7TDcrugQdOr+TswO1?=
 =?us-ascii?Q?pV+EzCay9eR8nuft+Xdtg6WQJjeAvY3nFGawBH6LSpvvdBUqXIPzJpJDhoaz?=
 =?us-ascii?Q?xjngTQDTOv5zsQwL5HKYLPZujyuf9pMeQZv38x23S5B5yiva8nQdzq4ymnTP?=
 =?us-ascii?Q?5hIjavktMsQtjUnGhdkkzyCy8USHXNE9mfIRX64GuRjHdLM2xmxVJnCK6x9x?=
 =?us-ascii?Q?utst6mM353mG/iQ3vNOJkVUxFtWczLByIWMYbbaoWqTwDFIb82CHwtuKTnwb?=
 =?us-ascii?Q?jyskFhf1XSCybKSOL/KI5LeQFmmN7MLuZx8QspS+C3Rl6pM9A2UpEJBltlt8?=
 =?us-ascii?Q?JaC0FVkIicOOv3tOtckw6WScc+wUE4GXoHGOMDHtu1TdvrOkFknxMFI46mtw?=
 =?us-ascii?Q?xncHkEVhDrdk0P0A9refjyvkkQxIZKKTq+NP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:08:01.6838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d1f601-4dbd-4139-d353-08dda50bee55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

`ip stats' displays a range of bridge_slave-related statistics, but not
the VLAN stats. `bridge vlan' actually has code to show these. Extract the
code to libutil so that it can be reused between the bridge and ip stats
tools.

Rename them reasonably so as not to litter the global namespace.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 bridge/vlan.c    | 50 +++++-------------------------------------------
 include/bridge.h | 11 +++++++++++
 lib/Makefile     |  3 ++-
 lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 46 deletions(-)
 create mode 100644 include/bridge.h
 create mode 100644 lib/bridge.c

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
index 00000000..0a46b6a2
--- /dev/null
+++ b/lib/bridge.c
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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


