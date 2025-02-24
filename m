Return-Path: <netdev+bounces-168898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEDA415B6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AE1188D38B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17761A5BA1;
	Mon, 24 Feb 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+1I1pVH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE361A3160
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380022; cv=fail; b=fgMi8t368Q13+l29Hmp8avabYvMzjzHED3ClXwr2Iuq/6zSQSlwjnXb2jcYExlnZQshZSEDV7eGkFOanTMR9pTJUVXGIfSXj6/Y82NPuALiK8M2A9Vzrb0x4OrUn3NIeWbwD9km4PZDLBspb7etU0l8QDybC10o2FdX06NWhRn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380022; c=relaxed/simple;
	bh=MOE6fgSbvADWYBCFRSlG3btFQ2enFZXGT3E00hSfI3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqCSZ+fI1vorgQ2GLX6NPIYtVEvB+gqWGV2NpPTg7aTGxIdo4Qv5eAeFdpwDK1BRZDNomk/d2slKfx0pgO1o6gRTKv0vEzIkglosDQC/xTWnFe6zG3QYfHy5cSS4kv8vINBqivG7Tb9hgUElpRQQlGFYOAt5nOxKcUqWXS4tCo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+1I1pVH; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdB7VC0OFkeJsl9hKWm84jD6qR6ClJb3ueTiQtT1adNwvz7DRkNgiZFo7qGOo1GqokXdNEsNiqORGujTz8DM2DqqIDZOkv2oNR4NWaSiX9g8zwPFTcIduW1qOsCFRCTdYtYpRmfb5hJJGyvF1sT5s96hGZjgvtAnrLkQiRwEvhQpwSa7tXNlK+2jBiBJ28nqlyRhQ8UxfTmUo4iSbCFp0AE8iYDxgIoGeCM5bRPZiVmuJf3wLve40HegdnNUCJHatoJ3+cPm/veStafwuXVddAw97f34MV8b+4GTPgFzwc8dJls78uJ/cvwMSUmbNthGnuUbDLXyTdmQ25+Q/GIh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TekZGvKoY49AFIL7KcOzfIE4zxP+rj9/EMW9KE9MicQ=;
 b=vjMVH+XwBguTOGM+pWYhpImLsNbqGGG4Rq1+l+WheLG1374XDDcAFVrurIPXbSEXwukq8BxzR8Xx1rlq8BpG8Qmvi2xu/cD2H2OigDL+2TO3YKoi39DPjI3Ht/GDdq+DU/xI2VDyRQ2Reh8sjpa8zsYUCPDOF0ddSSBQMcHtLbW9Bt50XhrPz7NzPXIQ2atYln22Ty61QO6hi577O7+WiiOkJG/uNL8ijPdeaJGZ7d5uNNOfKCtQ0wrvxbNJCvCOSkpTiGraQzl3qyQI0gT4ljHl+yxR66egWK/AHmN2kgYdtnPU7z1ps0n5pWWHI3Grx5I5iM/gCnLdcYzo+1MKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TekZGvKoY49AFIL7KcOzfIE4zxP+rj9/EMW9KE9MicQ=;
 b=J+1I1pVHUlIpItqkMRuvr8e/SIz+c66f+UEo7nNXJozZf5ErB92vN+aSAU2+q4avCuW3SdDZPdaUgkrUoVLgLGWzg/bwBoLK4EYGWlpwgSm8DUA28OijxlOcw9Am9xC3xHHgiccc/V9lJ0nrD30iEJKlOdaurroFenee3bCnl7CiULKQo70ppqJXBoYdwWmbTX5m/Vq5afLq1h9sT4uJcuICn3xpC+UdzMGEF9P01yYYVl+IWEPNH+k3oGF2cVuhc8oAS1hU2wU8wYrwAg+vPeOf5UOoK3wX/mmaPht9ZqRu7gO48/U/i7Cj8SJPazvg8TdADbXFoHprCrq9sWFDew==
Received: from DM6PR14CA0044.namprd14.prod.outlook.com (2603:10b6:5:18f::21)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:53:37 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::8f) by DM6PR14CA0044.outlook.office365.com
 (2603:10b6:5:18f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 06:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 06:53:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Feb
 2025 22:53:25 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Feb
 2025 22:53:23 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 5/5] iprule: Add DSCP mask support
Date: Mon, 24 Feb 2025 08:52:40 +0200
Message-ID: <20250224065241.236141-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224065241.236141-1-idosch@nvidia.com>
References: <20250224065241.236141-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: f9038eac-f2c6-42c8-914c-08dd549ff6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsqK7RS97uvklRJH/VuF63rWHaw63AcVrEmYr88/sUJ16rRCw1hrCZt/xSJq?=
 =?us-ascii?Q?y/rH8AyY4jfkSMwhE5/8LvY/jUSnpJ1w/1mHY5cAnoc6Mcg6Bis5w3PuU4u7?=
 =?us-ascii?Q?BTS9H6Dn4SN6jnp7tFbtBa9Rw69h4Afitvt3k1E3mkUzvzDSFpJuJqfPXd8C?=
 =?us-ascii?Q?YChQoEbFeIWbKWLr6tV/hcdC63TCtSGuVu2UZsxR3kEcWtRbchByN3XAizdQ?=
 =?us-ascii?Q?UOWS+6WsKyEBZPa6CM8v/AKYjfeMHm6rArPzc8+jnqmeqPOb6/2EnvzELisY?=
 =?us-ascii?Q?sFmS5+QHZPiwPr7F6y5xcBJxTKmnHubrTdB+EiuJmpuoLS+bNq3PXheLZPjX?=
 =?us-ascii?Q?U3uLVfkKClXwrydF2rqI+pwvqIEsMlW/04z14tp+HDn6/P+x2UxprvzfmQYA?=
 =?us-ascii?Q?R6DBZjCaat9jYv0FqfhoDV8nbLFxJ9OHpua3V8unLXCRo6FajK3QAU2sgb21?=
 =?us-ascii?Q?iCau9tk0w+dSnL2CvZxv+9pvkI6FqlHArIfVXeZh67YR9gjtgb4UtL8qxgNn?=
 =?us-ascii?Q?9adNh6XbXb4LCiWGL7Vc1LbVm5j8tVSY9l8CrRHIjzaH4MT9zJ0C5OOv4jhk?=
 =?us-ascii?Q?dPwbkqhJ/tMCjGCoYOVmlVNUAua8DN7H7z0x7YEQ7zcoxIpc+wI/0eA74e8z?=
 =?us-ascii?Q?Li5yrbYHXA0eBnZplFgmI6sdnu/kTXxh114QdAK5622QAQ4ZZUFeREQ9O+NE?=
 =?us-ascii?Q?3n53RzaD13BrgmLBpr+iKB1R35H86iaI441wgAQosGiLkNNvPCv+5yr+gRq7?=
 =?us-ascii?Q?mMvUpRSWS4IT/Mp/IiqHtuD6rvwsapvTqSfEPa/HEZO8zc2HGKzfE+AaPmu/?=
 =?us-ascii?Q?5q9fw1Sdn3SyjuetIrWbf8wI1KiRSuFYTNUbqEDJK2a/ae+c152Ph2+xO2+Z?=
 =?us-ascii?Q?aq1Km8kMoF0NggwRT6u4iBgurq1EmAaNpNJEk+vYNIMWOwdXsJc6WcDRvIeK?=
 =?us-ascii?Q?9FMbr2eV9zyVgutzvN3RlZN/ZlG0Dcb57VKq5N32aWoempq5zPXAKK7E3Lqd?=
 =?us-ascii?Q?TV/luLtm338n7g8gUS+5oMWNrvcZQCVcZpNV8oTXKH8pdY9kN2RvHugthKkX?=
 =?us-ascii?Q?sE1JTusIKDy4sW4hO/M1Y4+rgmUY1GUGH1TvWM/fRAHpnkQN2sppJGv574UU?=
 =?us-ascii?Q?WR7ZXfnWCCenrWsmbuoPQq+jSpXzXSqEQWcILpkWBUHoOzi6wxPh8V1xlZ/M?=
 =?us-ascii?Q?RX6LHko0a3K7hDAj0XoyJP4m0tQUmsEacL2eC3V/jhXW0VmQY7ZC6RPg4fjt?=
 =?us-ascii?Q?Te82SQmljMQwvNbGlGYgNxN6iMXGFaeyT7//QsCP3YfggIS57i85a5JtgDkV?=
 =?us-ascii?Q?MHV0EknoBLi/kSMmjTZahjlP29iQIV+WYyOUjNHe0VWONPKIdfM3GkTB8i4V?=
 =?us-ascii?Q?4gfQhn4/QrFsi2OP17cI3u8AcaX/gkF6R8jTjJGuUiBWRHkPedVzyUYiCKbr?=
 =?us-ascii?Q?ZwQLiZPOqqk127hn3MKHgoTxfTtwJI1s2AL4mjZkuMx8GM+uQLjesa7bAKQK?=
 =?us-ascii?Q?RB0vPLgf9Lc+5OE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:53:37.2181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9038eac-f2c6-42c8-914c-08dd549ff6ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144

Add DSCP mask support, allowing users to specify a DSCP value with an
optional mask. Example:

 # ip rule add dscp 1 table 100
 # ip rule add dscp 0x02/0x3f table 200
 # ip rule add dscp AF42/0x3f table 300
 # ip rule add dscp 0x10/0x30 table 400

In non-JSON output, the DSCP mask is not printed in case of exact match
and the DSCP value is printed in hexadecimal format in case of inexact
match:

 $ ip rule show
 0:      from all lookup local
 32762:  from all lookup 400 dscp 0x10/0x30
 32763:  from all lookup 300 dscp AF42
 32764:  from all lookup 200 dscp 2
 32765:  from all lookup 100 dscp 1
 32766:  from all lookup main
 32767:  from all lookup default

Dump can be filtered by DSCP value and mask:

 $ ip rule show dscp 1
 32765:  from all lookup 100 dscp 1
 $ ip rule show dscp AF42
 32763:  from all lookup 300 dscp AF42
 $ ip rule show dscp 0x10/0x30
 32762:  from all lookup 400 dscp 0x10/0x30

In JSON output, the DSCP mask is printed as an hexadecimal string to be
consistent with other masks. The DSCP value is printed as an integer in
order not to break existing scripts:

 $ ip -j -p -N rule show dscp 0x10/0x30
 [ {
         "priority": 32762,
         "src": "all",
         "table": "400",
         "dscp": "16",
         "dscp_mask": "0x30"
     } ]

The mask attribute is only sent to the kernel in case of inexact match
so that iproute2 will continue working with kernels that do not support
the attribute.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/iprule.c           | 73 ++++++++++++++++++++++++++++++++-----------
 man/man8/ip-rule.8.in |  9 +++---
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index fbe69a3b6293..d4d57b8c96df 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -24,6 +24,7 @@
 #include "json_print.h"
 
 #define PORT_MAX_MASK 0xFFFF
+#define DSCP_MAX_MASK 0x3F
 
 enum list_action {
 	IPRULE_LIST,
@@ -48,7 +49,7 @@ static void usage(void)
 		"            [ ipproto PROTOCOL ]\n"
 		"            [ sport [ NUMBER[/MASK] | NUMBER-NUMBER ]\n"
 		"            [ dport [ NUMBER[/MASK] | NUMBER-NUMBER ] ]\n"
-		"            [ dscp DSCP ] [ flowlabel FLOWLABEL[/MASK] ]\n"
+		"            [ dscp DSCP[/MASK] ] [ flowlabel FLOWLABEL[/MASK] ]\n"
 		"ACTION := [ table TABLE_ID ]\n"
 		"          [ protocol PROTO ]\n"
 		"          [ nat ADDRESS ]\n"
@@ -238,14 +239,21 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 	}
 
 	if (filter.dscpmask) {
-		if (tb[FRA_DSCP]) {
-			__u8 dscp = rta_getattr_u8(tb[FRA_DSCP]);
+		__u8 dscp_mask = DSCP_MAX_MASK;
+		__u8 dscp;
 
-			if (filter.dscp != dscp)
-				return false;
-		} else {
+		if (!tb[FRA_DSCP])
+			return false;
+
+		dscp = rta_getattr_u8(tb[FRA_DSCP]);
+		if (filter.dscp != dscp)
+			return false;
+
+		if (tb[FRA_DSCP_MASK])
+			dscp_mask = rta_getattr_u8(tb[FRA_DSCP_MASK]);
+
+		if (filter.dscpmask != dscp_mask)
 			return false;
-		}
 	}
 
 	if (filter.flowlabel_mask) {
@@ -552,8 +560,24 @@ int print_rule(struct nlmsghdr *n, void *arg)
 	if (tb[FRA_DSCP]) {
 		__u8 dscp = rta_getattr_u8(tb[FRA_DSCP]);
 
-		print_string(PRINT_ANY, "dscp", " dscp %s",
-			     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
+		if (tb[FRA_DSCP_MASK]) {
+			__u8 mask = rta_getattr_u8(tb[FRA_DSCP_MASK]);
+
+			print_string(PRINT_JSON, "dscp", NULL,
+				     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
+			print_0xhex(PRINT_JSON, "dscp_mask", NULL, mask);
+			if (mask == DSCP_MAX_MASK) {
+				print_string(PRINT_FP, NULL, " dscp %s",
+					     rtnl_dscp_n2a(dscp, b1,
+							   sizeof(b1)));
+			} else {
+				print_0xhex(PRINT_FP, NULL, " dscp %#x", dscp);
+				print_0xhex(PRINT_FP, NULL, "/%#x", mask);
+			}
+		} else {
+			print_string(PRINT_ANY, "dscp", " dscp %s",
+				     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
+		}
 	}
 
 	/* The kernel will either provide both attributes, or none */
@@ -694,6 +718,21 @@ static void iprule_port_parse(char *arg, struct fib_rule_port_range *r,
 	r->end = r->start;
 }
 
+static void iprule_dscp_parse(char *arg, __u32 *dscp, __u32 *mask)
+{
+	char *slash;
+
+	*mask = DSCP_MAX_MASK;
+
+	slash = strchr(arg, '/');
+	if (slash != NULL)
+		*slash = '\0';
+	if (rtnl_dscp_a2n(dscp, arg))
+		invarg("invalid dscp", arg);
+	if (slash && get_u32(mask, slash + 1, 0))
+		invarg("invalid dscp mask", slash + 1);
+}
+
 static void iprule_flowlabel_parse(char *arg, __u32 *flowlabel,
 				   __u32 *flowlabel_mask)
 {
@@ -848,13 +887,9 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
 			iprule_port_parse(*argv, &filter.dport,
 					  &filter.dport_mask);
 		} else if (strcmp(*argv, "dscp") == 0) {
-			__u32 dscp;
-
 			NEXT_ARG();
-			if (rtnl_dscp_a2n(&dscp, *argv))
-				invarg("invalid dscp\n", *argv);
-			filter.dscp = dscp;
-			filter.dscpmask = 1;
+			iprule_dscp_parse(*argv, &filter.dscp,
+					  &filter.dscpmask);
 		} else if (strcmp(*argv, "flowlabel") == 0) {
 			NEXT_ARG();
 
@@ -1137,12 +1172,14 @@ static int iprule_modify(int cmd, int argc, char **argv)
 				addattr16(&req.n, sizeof(req), FRA_DPORT_MASK,
 					  dport_mask);
 		} else if (strcmp(*argv, "dscp") == 0) {
-			__u32 dscp;
+			__u32 dscp, dscp_mask;
 
 			NEXT_ARG();
-			if (rtnl_dscp_a2n(&dscp, *argv))
-				invarg("invalid dscp\n", *argv);
+			iprule_dscp_parse(*argv, &dscp, &dscp_mask);
 			addattr8(&req.n, sizeof(req), FRA_DSCP, dscp);
+			if (dscp_mask != DSCP_MAX_MASK)
+				addattr8(&req.n, sizeof(req), FRA_DSCP_MASK,
+					 dscp_mask);
 		} else if (strcmp(*argv, "flowlabel") == 0) {
 			__u32 flowlabel, flowlabel_mask;
 
diff --git a/man/man8/ip-rule.8.in b/man/man8/ip-rule.8.in
index 4945ccd55076..7d6a82b2c492 100644
--- a/man/man8/ip-rule.8.in
+++ b/man/man8/ip-rule.8.in
@@ -37,7 +37,7 @@ ip-rule \- routing policy database management
 .B  tos
 .IR TOS " ] [ "
 .B  dscp
-.IR DSCP " ] [ "
+.IR DSCP\fR[\fB/\fIMASK "] ] [ "
 .B  fwmark
 .IR FWMARK\fR[\fB/\fIMASK "] ] [ "
 .B  iif
@@ -239,9 +239,10 @@ a device.
 select the TOS value to match.
 
 .TP
-.BI dscp " DSCP"
-select the DSCP value to match. DSCP values can be written either directly as
-numeric values (valid values are 0-63), or using symbolic names specified in
+.BI dscp " DSCP\fR[\fB/\fIMASK\fR]"
+select the DSCP value to match with an optional mask. DSCP values can be
+written either directly as numeric values (valid values are 0-63), or using
+symbolic names specified in
 .BR @SYSCONF_USR_DIR@/rt_dsfield " or " @SYSCONF_ETC_DIR@/rt_dsfield
 (has precedence if exists).
 However, note that the file specifies full 8-bit dsfield values, whereas
-- 
2.48.1


