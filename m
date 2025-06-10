Return-Path: <netdev+bounces-196216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B86AD3DF8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DC9177B22
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1093238150;
	Tue, 10 Jun 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uQp8pjev"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72AE23AE9A
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570873; cv=fail; b=BkiItEfV5RrCTTc7M3NnVCs2QMBOJ1u/Tl6CAvQ2gRCsxbPBTGEPpWS8n7z1bIHUTtg5iYqCT8ZEDl3LTLuyW6h6T7EIvVGfYQk7emZ9pk59EuRCadomA3H1rU6QLe2jf4RIqcbdcX9K6ooMQrTeuW+whXzsK16PWMcmjFJKJ+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570873; c=relaxed/simple;
	bh=hPQ4crTDpujy+TqVAaQgFdZvgCItPuWU9gkU5e0nZ+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd3L/W4F3aYMbYaVxXxD+XjcypbLT1aUQKhiGqDsxJMWxdFOrF7O6KFXIgJenuTms69Q6IMwr5bzGccAe0cvtdFi92jVH4O3WvSOJEYsaY+ThCfwSIRzA/8KhVwpeZOpAZJShjsGhqmvHrWmm0ZSe+UL3kJBsguKpQbaxKVm86o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uQp8pjev; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8lFqQIdZE/h3m2afQUQEitzvTtDtH/WIBe7TqrIgzXWE7rKU4bqginJbZdg3x5ZH6loK5wv1kbjTWiXi8mHMjNiETCFqXw1yLMgAyrR/Y2HIfXzYvdvgZpbUgjlRAl+vMa5m8xpDD85qkNjGpZd70BzqrAIlKEqkFMbpL0A08CZqPViasDGFkRfPiZEhasfPVsmHwPEd1fYRLGUBygOi/aFbb0jm4dXciVtsMFO2rbSp0pHcG4RyBDKpEKn1/J6OBpqlJFOgBFYCXRbMBPQ0bMuu2b0XR1+agrgL/Qbb8sVckhcvcCBXb4mwzusv4bERE2nKhM9oz3+TbuGunU4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srBCN3IlupwrZkB15JZj6/gJqNQmC9kR8J7h01Kjywo=;
 b=zLOBHbumRx7cSjMv0nBfnIXNR3ee67qp6stZxDovy4JpVHf8UYv+DOhAZO5hSnlvP3gjc+3n1axmjfPpn1KJY9uQUgVjVxhr1Uw6C7wMy81IfF/biZZL+mwkQZFyM1YYEB+nD2ZIjqxg6lawA2zLRp+YL5nM7UqgpTa33KCZnMDwAPW7By71WTus7RdFRd0flixuGov1+2f8QjVRLT/unTf093B2eCOHPooJxd7IP90NwuG4V3qS+nvJLYgup4ESkL8lpEMhLcIWhBykcSAiEi6VU/I/xzJaAnSoZsmpnRPlQBFD7b2AsMF/68+MQwEIkEpjZMWPVpjPF31dWC739Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srBCN3IlupwrZkB15JZj6/gJqNQmC9kR8J7h01Kjywo=;
 b=uQp8pjev9zF/EpYl68TuYwGSMGboT217Lb0jQHDAWp9+BQfhhBh+8mCHdine6Mrq9cABWLZ/i3Ny4pljzblRdcFJkc/0WCZyYsj7qPOB9mBncxm5ablicIkO98Q4qiY8m47w/59EMt+Toxd+0fnaPj/Zz1XcpCyGxacSH9Kvoie52rT5AFgNThOBlr415aK9xV8obksGuhEyHQ9+WgzSvw9CqqXwULXXRUSFCEMaKodiB1AYhF+CPJODSTfv51d83wiWrKSQolwwviiYVqQPeGMICQaxp8a82tBBmyb7xuKObuRSlMcVIx7FDCBAIcS9WrrfzijK4dAQaSLvqS/76Q==
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:54:27 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::88) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Tue,
 10 Jun 2025 15:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:54:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:54:05 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:54:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v3 4/4] ip: iplink_bridge: Support bridge VLAN stats in `ip stats'
Date: Tue, 10 Jun 2025 17:51:27 +0200
Message-ID: <f45aec48b2c7db079d8ede72453854a8ac435590.1749567243.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 301f9e1d-c731-4de8-2da9-08dda837148a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vss0kxshOdvLlUcU8OON9ePh0hKfoe313tBnKz2WGf5X3W5XhGjyDylMqKip?=
 =?us-ascii?Q?l86UnINV4sBMnSpUMnKOZTluo83LXEWeWQcEzfTEUoxDDl44xadXWn6Q83sS?=
 =?us-ascii?Q?VgN6/n02PRFMidtCTY/sAxFkl6ZUv3uiK7IkNDJGGUxCsOozVILqsXvtnXu5?=
 =?us-ascii?Q?D4mZK1U2bwWuawzqkN8mROe/0jcqr5nbPf6ZGrZcEepKujXMYgX/cvQtRRBh?=
 =?us-ascii?Q?/7HQNBFX4395P247IK2ocgrHJZBh9ceWKDW/r0w7vkLPpU59fphVFZ9ovDyj?=
 =?us-ascii?Q?GpJdqo49SeGuCe98iwVf5asMKlDuRg0ahkd0z8eh5Oe8BpTE4ekDVPZV8yTT?=
 =?us-ascii?Q?XJW7084xwrEIxPPMBGJLT6qXnplmwDLo4cmZsyQiatGxZFp3CWgltr3THgjf?=
 =?us-ascii?Q?fZ0v0kY6PvI1gA5vYHFnns0DePhemgLMBI3IWwYl/eIoVX1cPyc4LN2mB6MU?=
 =?us-ascii?Q?xrC7395Txk6o18Ck2VYaKq3DWF6SZPbnAqn9eKh6/6MEDjOnwde/fSKtmo/P?=
 =?us-ascii?Q?WD/euGOSO0AO1i9zEhAlnN17FemOPOAzngXSIrwMG8OhFkn5IiIYe/cjHb6r?=
 =?us-ascii?Q?fTtQU8wd/OXxFlPuP7NrOFqpNztBXaGgdSnmccK33iwL+rApdPl6CmKHmmaT?=
 =?us-ascii?Q?o7S8zvZ+6Wqj8w1syZ7XCl4U6izfzuz+kelIWOsfRCEQKMQv0XWWXXNmR8/N?=
 =?us-ascii?Q?6+WufsIKSA5UTWHl7SOidRDfb2URSFPoA9USrhvkM7zsWUXXu9vRpjvFA9PY?=
 =?us-ascii?Q?UCk5Y/xt1l+9P6+fqjQY0giXrjlnFlnbr7/WFlE8zScgR1ULMlJvHIp73Edh?=
 =?us-ascii?Q?DzkuC7KAYAQ39Q2wf/7gmr0XTvhpxljfQwzU5suJKxVxoHdqbem3WpoGvQnQ?=
 =?us-ascii?Q?TeHUIKxYIYQqsI3UZ/BpAmOwmvI5aEqrTeuoqMRb4sOZ/BOid6M00zH0Osgd?=
 =?us-ascii?Q?x/kWhq0NrlO4tSZ094WLW5mnTvc/1hfOTP5rYoukv6oVYWA87hkbAfPAUlbG?=
 =?us-ascii?Q?VKW2Db9FUGkvjqNWFMd/ifkYiteFsVvox5cVDmnCjTzoMg6mPVmw1s5PbzJS?=
 =?us-ascii?Q?FguYB71d8NEUvzn2V/UT5OkYIafKmkG9h0TFNYQ8R9OkkpoiyWlrx1lY/DRW?=
 =?us-ascii?Q?3irPFtsZIWb+rVK1GrAuTtwrYo8z+9zVpTAityAlFhKeN5H3P4ekmFYReQ3N?=
 =?us-ascii?Q?oC71I3cvM7Q0TMW4zOYfQptlGgVNUE0QUnKCRTgeUYN0s/UUhtaykwE1WR07?=
 =?us-ascii?Q?PEjMOt3BVUoaDyHKA2BIKdd1PlrejcrzgDdDGms9hDGrQ8p82ezyt5EO187G?=
 =?us-ascii?Q?CMNXNAjDCDI/YlCVOwG7yBeMnxQmyBYxtTAyusQxrb+4wTbK/YGTF8F73VvJ?=
 =?us-ascii?Q?l0kgTR+qVGMXRxUhYRgGtTj2HtTxm5yYkgxZZHcY4cIWLa9GrTq83Lx6/3AF?=
 =?us-ascii?Q?tCQkZu8XTQE4m2ZekQEiSdGRL3III1dgZPa/Gtt+2SY4VYGXNrWdWICItcEb?=
 =?us-ascii?Q?Bdwl6pjXUOAikFDxHVvNc/ZX+YyeIDkssg5w?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:54:27.6809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301f9e1d-c731-4de8-2da9-08dda837148a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

Add support for displaying bridge VLAN statistics in `ip stats'.
Reuse the existing `bridge vlan' display and JSON format:

 # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
 2: v2: group xstats_slave subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev v2 group xstats_slave subgroup bridge suite vlan
 [ {
         "ifindex": 2,
         "ifname": "v2",
         "group": "xstats_slave",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Similarly for the master stats:

 # ip stats show dev br1 group xstats subgroup bridge suite vlan
 211: br1: group xstats subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev br1 group xstats subgroup bridge suite vlan
 [ {
         "ifindex": 211,
         "ifname": "br1",
         "group": "xstats",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "flags": [ ],
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "flags": [ ],
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v3:
    - Add man page coverage.
    - Order the VLAN suite at the end in both master and slave subgroups.
    - Retain Nik's Acked-by for these.
    
    v2:
    - Add the master stats as well.

 ip/iplink_bridge.c  | 48 +++++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-stats.8 | 12 +++++++++---
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 3d54e203..31e7cb5e 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -14,6 +14,7 @@
 #include <linux/if_bridge.h>
 #include <net/if.h>
 
+#include "bridge.h"
 #include "rt_names.h"
 #include "utils.h"
 #include "ip_common.h"
@@ -978,6 +979,26 @@ static void bridge_print_stats_stp(const struct rtattr *attr)
 	close_json_object();
 }
 
+static void bridge_print_stats_vlan(const struct rtattr *attr)
+{
+	const struct bridge_vlan_xstats *vstats = RTA_DATA(attr);
+
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
+	bridge_print_vlan_stats(vstats);
+}
+
+static int bridge_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
+					const struct ipstats_stat_desc *desc)
+{
+	int ret;
+
+	open_json_array(PRINT_JSON, "vlans");
+	ret = ipstats_stat_desc_show_xstats(attrs, desc);
+	close_json_array(PRINT_JSON, "vlans");
+
+	return ret;
+}
+
 static void bridge_print_stats_attr(struct rtattr *attr, int ifindex)
 {
 	struct rtattr *brtb[LINK_XSTATS_TYPE_MAX+1];
@@ -1088,10 +1109,27 @@ ipstats_stat_desc_xstats_bridge_mcast = {
 	.show_cb = &bridge_print_stats_mcast,
 };
 
+#define IPSTATS_STAT_DESC_BRIDGE_VLAN {			\
+		.name = "vlan",				\
+		.kind = IPSTATS_STAT_DESC_KIND_LEAF,	\
+		.show = &bridge_stat_desc_show_xstats,	\
+		.pack = &ipstats_stat_desc_pack_xstats,	\
+	}
+
+static const struct ipstats_stat_desc_xstats
+ipstats_stat_desc_xstats_bridge_vlan = {
+	.desc = IPSTATS_STAT_DESC_BRIDGE_VLAN,
+	.xstats_at = IFLA_STATS_LINK_XSTATS,
+	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
+	.inner_at = BRIDGE_XSTATS_VLAN,
+	.show_cb = &bridge_print_stats_vlan,
+};
+
 static const struct ipstats_stat_desc *
 ipstats_stat_desc_xstats_bridge_subs[] = {
 	&ipstats_stat_desc_xstats_bridge_stp.desc,
 	&ipstats_stat_desc_xstats_bridge_mcast.desc,
+	&ipstats_stat_desc_xstats_bridge_vlan.desc,
 };
 
 const struct ipstats_stat_desc ipstats_stat_desc_xstats_bridge_group = {
@@ -1119,10 +1157,20 @@ ipstats_stat_desc_xstats_slave_bridge_mcast = {
 	.show_cb = &bridge_print_stats_mcast,
 };
 
+static const struct ipstats_stat_desc_xstats
+ipstats_stat_desc_xstats_slave_bridge_vlan = {
+	.desc = IPSTATS_STAT_DESC_BRIDGE_VLAN,
+	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
+	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
+	.inner_at = BRIDGE_XSTATS_VLAN,
+	.show_cb = &bridge_print_stats_vlan,
+};
+
 static const struct ipstats_stat_desc *
 ipstats_stat_desc_xstats_slave_bridge_subs[] = {
 	&ipstats_stat_desc_xstats_slave_bridge_stp.desc,
 	&ipstats_stat_desc_xstats_slave_bridge_mcast.desc,
+	&ipstats_stat_desc_xstats_slave_bridge_vlan.desc,
 };
 
 const struct ipstats_stat_desc ipstats_stat_desc_xstats_slave_bridge_group = {
diff --git a/man/man8/ip-stats.8 b/man/man8/ip-stats.8
index 26336454..e9ff49d5 100644
--- a/man/man8/ip-stats.8
+++ b/man/man8/ip-stats.8
@@ -152,9 +152,15 @@ Note how the l3_stats_info for the selected group is also part of the dump.
 .in 21
 
 .ti 14
-.B subgroup bridge \fR[\fB suite stp \fR] [\fB suite mcast \fR]
-- Statistics for STP and, respectively, IGMP / MLD (under the keyword
-\fBmcast\fR) traffic on bridges and their slaves.
+.B subgroup bridge\fR - Various statistics on bridges and their slaves.
+
+.ti 21
+.BR "suite stp " "- STP statistics"
+.br
+.BR "suite mcast " "- IGMP / MLD statistics"
+.br
+.BR "suite vlan " "- per-VLAN traffic statistics"
+.br
 
 .ti 14
 .B subgroup bond \fR[\fB suite 802.3ad \fR]
-- 
2.49.0


