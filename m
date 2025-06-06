Return-Path: <netdev+bounces-195465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E52AD04E5
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BB73B3AC4
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D41289E04;
	Fri,  6 Jun 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KjZkw9ex"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6E28983F
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222489; cv=fail; b=fPpVBXPSeM26WDPJ540Zv4TslWCaYatzIzfxqwIQzn6JEkMbWGNg3zKFPh48B2uUGdpPG+mseQaonZ1aZxGMuChN9uxFgz0RYv55C7/h04zRLSXDF1t+M9EjzL03r9fwxb+QZ9ErU1ihQPrqMkti9M1Uvkln1+JOZkyqPyRjHSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222489; c=relaxed/simple;
	bh=DILS+GrF+iDReUD8W2v5cnXYX6NQjdCWNLsazDPuFlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhVg3fUY6efeozpihBZ43iCeqXe7NY7dnswUr5Ovfo5CFjOzI9n/kppldF/l8XfCFRotVJdC6xLiIWwlJhOuvrIEpLQHjYGA++gbQvZz3zgmhYN0bQPPWtvuW7MUiPFI9jDSitlU7TaBd6CnNbysrg/2wzZJZOq0E4IRgtsecrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KjZkw9ex; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbUKvjcxRpKYQAF7kXJYke4gumWwqtKN2AYvjx7L5cnT/7i17S9rkvKmy7mVca4EsDho5DIgQg/9N9AtSq3uqj5LLh3x/nkruNLyx7TY7DGYXtWhacgd+FPAdchEeClL+4SLZIlcUzeRqRHj8jZHE9JG0hTx3tXAXSK8q0G78aSazFbAE7qeEAXECdtaSQ+W4KO0KDS7E9RlggM0GK+zP/rTiOCwDmifHl5PfxNJSrX4bes/KQh8Ab+TKetUDkEfbII/TpgJqLdRPyxNEFTlbPkfHOaGIVAF16zdWpXH7yO6Pbuu8PXHOXLw2dm4s8ZOmQ7D8Db0tw+xjYB48/pWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHEcjAIejqY8VOH611dqtU9nkwYOJwCeH7aYG2Wfqco=;
 b=yKb4Rn2sciXYp8Zp3UoF78MapK3WI78Mh0Ol3i0ZTCc9nHQbC7rLMW6hAUV+g9jJiemR1GmddpPLGYfAKZJZpS93fqJ2yywKGqxNtrjCgXHCAoiBpNceLLywE22lVRryST7CMfShwPSLksuqwCbEBD+YiQ6obBPfulFoGzq/a23NIpnjOFe4aqa5LcJoQtXSP6sJ5nl/Pow7w83TvevAsmm/OpxsNL5JA6OoAR5EuSM2I74zYso/FJ9YCiEI4Bys7nEoG+vancjn5vujkDZJzeaF1tMQUFyReQgcOVFSlEBYQX5ZACo2RDYtJFkn1kpAm8uB1mw6PKyGGDakG7FWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHEcjAIejqY8VOH611dqtU9nkwYOJwCeH7aYG2Wfqco=;
 b=KjZkw9ex27pB8DGmWWL73/UhoCC/4aghIowjV1UpS90Deg4czMuy1kEXsuKNXo/6rVxTdJrOdp0SnrdXTyj+tBxYc7mzMGpgfQQsE+RZMPmr/vBZgK+qHRpbOpV2Erb7gPyPlryEBv6l0YB123kshmm7LPxp3LZp0A9VgxA3CJJJ845mXOhp12WanJPIWItCYZHNYcYLFAUOVXeLnYcraaesitsKTLapEQSLS1cjDhJ9MLbZxJZcnOu1ScXScnTVf2x6+pwFR3nNoer1/5haICO+8vSpSJIFIdgSgLT4cluBxno6SgrIiz4jcH48631/C3vXCxN84PkELUYBgkw+Nw==
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 15:08:04 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::38) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Fri,
 6 Jun 2025 15:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 15:08:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 08:07:47 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 08:07:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 4/4] ip: iplink_bridge: Support bridge VLAN stats in `ip stats'
Date: Fri, 6 Jun 2025 17:04:53 +0200
Message-ID: <997a47a1dcd139a0e50ea4a448b45612b58eac69.1749220201.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4632b6ed-d7ef-41d5-130f-08dda50befe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GUgehxAZeDwQsI++7b0an90pb1dCrsTnI7bRw8iL2COAlTYqrQUwRT3PgDLy?=
 =?us-ascii?Q?8C1bzn56XAfqMszOVLo9q6DJKEjxEdFl1bGUxOoSyoC6EDme3koDISTooaeV?=
 =?us-ascii?Q?NcAo2vErEoDDJq99iJiZpsbUQ/JkYHXYyJNJA3stU1wdP91jPSI7BRB/0yn0?=
 =?us-ascii?Q?a3T+5SzmT0NOCRb5nJW8ICbpKlLupPe87+Y4TGrpNxC6S6ZditBfV6Hfv5Pn?=
 =?us-ascii?Q?Y1/bZp4AZ3sx1Dfzv/nu9NDH6GwZhLvT3v7QMCkJLsJOQA/Sh1MMg3BMYbnu?=
 =?us-ascii?Q?7nchlTXGLwVV4TmcT4uI9ovPTHrs4o5h1CLTPzDpMcIGRg/NK1pUtryA3cFC?=
 =?us-ascii?Q?8kgDX3MJj1oqJGV7VhZLbTz+89GlxOr6STD2xY1coCU9ug997UKaATZbMkLw?=
 =?us-ascii?Q?opcFiuLOOyyx7oBykVJuF34ZMASElSnCsdl7GyUgsqrua8r9LTdx6mA70m8o?=
 =?us-ascii?Q?oMFj73Jf4vuwzk3Neu/1oWXUvTczq1/OfcWs7m7zcSNGBLZaY/aYCaCZf/L3?=
 =?us-ascii?Q?dBjjpFtAuwdkyaE1+KhNnMoI480IFb9yl+SWQiHf3oFz4PUkN2VhWN24OnFd?=
 =?us-ascii?Q?IIo1iEV2hMEHcxsltiz/NNGrsHlUkt6lPWhy4U8YsStCfqeg/TzlDZXrAhBy?=
 =?us-ascii?Q?rTr03ehIIWLWxZyur5Fg6XDbszv2tbS75caUVwSsZrj7XUavOK9IgNY7dfvT?=
 =?us-ascii?Q?322a8bIC9cdodFQvSbP8xEZXKkw9Bak67tYaWkRnb2L2g90NDUFYe6H9us7M?=
 =?us-ascii?Q?gOQ8jnpZGlQkPA2HrBTZ4Szg0OLk1Yqy2kFKUZEuvz9pl0O341zPR/g5scx5?=
 =?us-ascii?Q?OYw9VveMIjt62lWZRvZUN2O3+Ai+ypvW8S9cRPQxfu+92Y4/Nb9gSPOLuL9u?=
 =?us-ascii?Q?IASTwHc+J6eWpma8m2tSXJxea9hYHdsqQ8O7S3NfJPEFiyD3asIFZqtyZwBh?=
 =?us-ascii?Q?UJj60vEnNgyWWe8UQQK+AGSmj82wkRG8a2o4KkESPusAz3d+cxqMjEgYbsiY?=
 =?us-ascii?Q?XaTrKxGqGCc15wOsGTUSltrQNyq8B52yBrLc+6T23Foe8BjgUwAz1HSnkM77?=
 =?us-ascii?Q?oMTOuZvP7Qw59NfTDojLkY/jkQr7mzjzv+ojtthDU7oMX22PcruFbviZnlNn?=
 =?us-ascii?Q?L/n+R7a1oQ4u5qR0FlO24DTJbR/l4xMxLKaaSMhUcqFGzaC3lho/V4cVTivH?=
 =?us-ascii?Q?GDT6gxHgDIfaJ401zo1WXs5njgWhLTlZNpyM+jj17xHrTeWolUC+HQAtwf8+?=
 =?us-ascii?Q?7lYCsnyHM/Fj2L1SZCULCBfe2ISHXWqk0zko1bwFd/AjBMlyApJb6tbF7Gow?=
 =?us-ascii?Q?IYelsswVEm4Hgh+QMHAmq8eJULd2PASwqtuG87rM6T5tmEtIYIIArpmVsSh1?=
 =?us-ascii?Q?6sMZijuwEjEw3khAiQ+kbWjz9/S+Z0rYuRCq76u9Ab6iwJ6tZDdRfNCZqtY2?=
 =?us-ascii?Q?XpD4P7VUe0Th83+/lyu9DncgeMUEgGfgcKbxhKVMkXQEXmTSCwp8D5t3/N9i?=
 =?us-ascii?Q?Z1jDLurg3mS1J9WQb5SGnLkB9IQ/rGxRgfSe?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:08:04.2741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4632b6ed-d7ef-41d5-130f-08dda50befe4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055

Add support for displaying bridge VLAN statistics in `ip stats'.
Reuse the existing `bridge vlan' display and JSON format:

 # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
 2: v2: group xstats_slave subgroup bridge suite vlan
                   10
                     RX: 776 bytes 10 packets
                     TX: 224 bytes 4 packets

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
                 "rx_bytes": 552,
                 "rx_packets": 6,
                 "tx_bytes": 0,
                 "tx_packets": 0
             },{
                 "vid": 20,
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/iplink_bridge.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 3d54e203..531c495d 100644
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
@@ -1119,10 +1140,25 @@ ipstats_stat_desc_xstats_slave_bridge_mcast = {
 	.show_cb = &bridge_print_stats_mcast,
 };
 
+static const struct ipstats_stat_desc_xstats
+ipstats_stat_desc_xstats_slave_bridge_vlan = {
+	.desc = {
+		.name = "vlan",
+		.kind = IPSTATS_STAT_DESC_KIND_LEAF,
+		.show = &bridge_stat_desc_show_xstats,
+		.pack = &ipstats_stat_desc_pack_xstats,
+	},
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
-- 
2.49.0


