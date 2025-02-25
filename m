Return-Path: <netdev+bounces-169367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E53A43926
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551657AA87A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD8F2676DF;
	Tue, 25 Feb 2025 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWuM+61g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09852676C8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474671; cv=fail; b=psqkqjRYSl+YS+DXOiSHBptBZ2FVrq4kuHflHR3Gou79UH2It7DPvD4+kw2/Oo5nFGLq7+twrCy3HHfxGzCPbz8PzOxuisk4ZigOt0mysBK+yvEw67UI3LjpxyfkBzRfumGvUXCRKwTK6fmfIjkVXCKhNSamLi85bpP4eEMoUgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474671; c=relaxed/simple;
	bh=BHoDNf/62t5mUw9AuBq8uXZfuCSIo6A9TmtCkDgMWgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9yBe1paRZFPH5S045QwnZ7vHFkvOaASWYK198BAYENzJ+viKw5hlQuMYlpeKAhVl/SsqB/LopgroZqTx1oo9e4clkBgKEhXRiu/JNLHMwyeVew3vaYPv6bH/ItSZnVlDTr3XW1WjYYNSBDGcOkqMgnmJ26lEMrk4DUzkKI/mPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sWuM+61g; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Sw7ElcExQH5R/TILbHci0HZY73uD8bf2t/RCtae1wP3xfEQK7IQaAavc5WGxUy+gm6D+WeRCjOsFwo5+14PD2ujxH1TF0xNR6zMbwBmNDsoBu8rKZg0mFdI9vAlIFSnGoDXJNtY76INnaiyBuI/lptBZBpW30EakHk44vCVR5MS5RzkXQ90Iv/TxJMXN+5PcqQW1fvgMKBiCWRqUfhlRspN6/C0suLRRRugM8+X5wPp4HNqTkUt6z5K0aalwIRpfO6Z7/Ve6FATxk6BiI/0bYmvVIFI9fgJOEISp9PorUDBUPSKkPH0nJrD4WWMVEShEMfzpA9GKteA3ciTU5eDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39AvaITQDZTIFfmPFfIDhCqh2H44mrgDEUvouteNpro=;
 b=ae0rsZHdDSScTXhNjKCcLKLGKYeG575pUVKzssaejI/1B6UHk36zM6dFbmdSd71VIeClqzvMcTnqjj1q9jErOid/qdg5QJTr6gsHqrE84yr9Puna+D4/UO44Ed+9fkJJS+cBL0Uifanajjs0QHqj3WNd8jL7J0ZV0ESCR7+PMdVwjEqtqwKZ8UbTVecs5VzttjC556muo4iyzZw/aekquP16tR0LHtXaX5grDYl7NgD4Xn0f3al2zYoyiBfK1KbwJl/kTuK6bR8znlSNKg1/sWJaAkiH7/STzizkpUFvDdXPUqJs0AZ74t5wAjIkJTrM1talbHF8ZHCBGmIqPtVciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39AvaITQDZTIFfmPFfIDhCqh2H44mrgDEUvouteNpro=;
 b=sWuM+61g9Efj9Coj3kuDKfSZn5bSVt90UlEbSzc4U0xL6uSySCW78uMX33DLkfCRUTCBzIWmk15F5xHcLdg6/4ZCVGV76/EPvY3lS6cpg2Po0kFRvHImk07ANV1s06/pNukhkbZOoy7AlFjnxXRc9DGwhnp/fZEFxV5eeNtbYZJ4p0zIwQwRYjFLugHw9xz027B0MtHP4LNMsdrfVIo9yzP2jg7kSWGTpDctkyT3vK2mB+Ie8I0FfYNFSYToBWnY1LvvUpWNvcQbKGvd8tjEW97gT/yvNIGwdfpeKnvWZw28vasP6teLiN68GxWM69a6/IFl7LivBVl8dKrhhQujbQ==
Received: from SA1PR05CA0003.namprd05.prod.outlook.com (2603:10b6:806:2d2::14)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 09:11:05 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::52) by SA1PR05CA0003.outlook.office365.com
 (2603:10b6:806:2d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 09:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:11:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:10:55 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:10:51 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 5/5] iprule: Add DSCP mask support
Date: Tue, 25 Feb 2025 11:09:17 +0200
Message-ID: <20250225090917.499376-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225090917.499376-1-idosch@nvidia.com>
References: <20250225090917.499376-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4e974a-a679-43a8-767b-08dd557c5598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9cFhSCGKcog92DCTItag2+pgLVVbgdsZCAbbmbVgrzBVe7PIem6FQvOhbaNP?=
 =?us-ascii?Q?aTD2QM8Af4IMsYc7VIq+3cN9hZOjuOI/tOqtIj8q1evu9I1Pw9qvCvH8xi9h?=
 =?us-ascii?Q?en/jIv0zegNW+DCCvLO9vSTlxzYL37u11bGtV4Ua4Y2F3g7Si2XwYpdTN7Fb?=
 =?us-ascii?Q?daxiF5dS74DWLDB4246WAO0mG+EECqbhY/6XknW3iBRf4+leZKsuX2NikHjH?=
 =?us-ascii?Q?WRASE4fTYLaG+qZjdP3PPF89vVnaF6mDcE5ghZrFcQL+N9fljmjnoB4A7ew8?=
 =?us-ascii?Q?t9i3/F8zPknMiUMCaK1Kmnt//dbTzv8hySfONYl//DY1WIXgnqqCwzfNOp2e?=
 =?us-ascii?Q?USzpy2oYoeFa9tOGNj7frez0muLp31MfNAP8lrLJet/jDjx9nBVXs9fdR99R?=
 =?us-ascii?Q?NZC8v9qJVv3Sw1Ts+ALP5EZiJMQ/YMMHkVLj/qGw11e3Y64WFFwnepWwQ/ck?=
 =?us-ascii?Q?5tM3/RWG1mLQo/PqmITRnEp5g9kQOxCHUalMQkWFgbbXTqqfA5HncyRL/KUZ?=
 =?us-ascii?Q?/ayY0oZb3xHiKAuvIhEgR5JjYAreDjCQrzdBBO+bWgICqvr7y91WydGqH6yk?=
 =?us-ascii?Q?x62bUuqDsIt9ITnZguH3wsFI77K0nRZLwJaVCFAKMDEWAAd81kQOLkHqFKF8?=
 =?us-ascii?Q?dSwax707qZuuH4NEiOadFDs7umLpFwW+mCc4RSLMBG0UuVGs47caA5zSvi3u?=
 =?us-ascii?Q?kZ1GWgNaRKrkfMPGLT1IxdFmB2vicyxejq/kzfH+uDZnEYDSNmYXjKuHpHRZ?=
 =?us-ascii?Q?eFgEouB1wXudsxwvqBHFqJb1IqOgFxrK6/EmW8XlBxYOT154Gr9DgrmTLCc6?=
 =?us-ascii?Q?n78+rL/DqSJ6FG2lhjcv1hNmcvN8UbjOvVZJmohMRCvHw+gwd0WXXk1iKcoi?=
 =?us-ascii?Q?9KN+xXUaOoq7Thq79CoR1g0tgguWsJ5ec204pjUoYGTfO12q4wzDaKIR+c9b?=
 =?us-ascii?Q?dXIQ5wlLBexlzjJV/r4BGrhyOKwQ81cDaaEWamk2KlVKM7gx8TNzRJfvlUya?=
 =?us-ascii?Q?IJG/XeJRQxDklBR+w4zdAK7fgMwqvxcul6TREkBrNlVMkiLFEW+fRq/zYC5v?=
 =?us-ascii?Q?A4+Vlw9pwQBIslblEnO3rqGHZSoK3PJMcIVLt3KpGkc8NoSRM/gSX6Q1rlYh?=
 =?us-ascii?Q?m5U/nQCJz4JY4OXJfMFqL/pQ4jxY8urg7zXTAOXnPaT8cu+uK+uvmC5zxyY1?=
 =?us-ascii?Q?n5j5aKfZekGoLy9KLUrc3zEHTr7/YvZVZ7IyN2PVwSd9yTtxeDPCjZA2Kkm9?=
 =?us-ascii?Q?AfEuAK9LQme7WNS8jR4eLmRBAlMtkB3+OOmkX9ENdBgZ4meJFY5WbM4xHbMq?=
 =?us-ascii?Q?2upu4R1z2Y0czsj6HDmhNIX1eeCUFJCPGwpqMhCjliPOzlr5giy9X0VoNrbQ?=
 =?us-ascii?Q?z5+ZlvoBBt+Kd2NFHUxvZ+rlqsfvkI3v9m6oj3/6slflMwLibpYLj+DVfrom?=
 =?us-ascii?Q?JAZraDeDmw7ZUg4AYxAJMZFiz4EssdGYvpCIsn81sYhGbR2gCKlUzSZ59K6Y?=
 =?us-ascii?Q?U8VfDCSZGssbzjo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:11:05.4808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4e974a-a679-43a8-767b-08dd557c5598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886

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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 ip/iprule.c           | 73 ++++++++++++++++++++++++++++++++-----------
 man/man8/ip-rule.8.in |  9 +++---
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index 3338c7d6773a..3af02da24950 100644
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
@@ -687,6 +711,21 @@ static void iprule_port_parse(char *arg, struct fib_rule_port_range *r,
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
@@ -841,13 +880,9 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
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
 
@@ -1130,12 +1165,14 @@ static int iprule_modify(int cmd, int argc, char **argv)
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
index 6a2a3cd848df..6331a021d95a 100644
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


