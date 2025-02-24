Return-Path: <netdev+bounces-168897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB8A415B3
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C933B2844
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6C15886C;
	Mon, 24 Feb 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="joup7owb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EE207E08
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380018; cv=fail; b=bV/8SqIDGe5XXgz+kBX17Mzh/SUOPlRfOOwbcwb+NOasICAOpvTGRwXgH2DgBhDSEynL/rim9Nhl3MYxoIscSqX5W4GTso1Dlai/A6NkpOb8Sf8pZ5YNO6FSnIo5rcsdM8ipm/L6XoA/n3tSFZ4UmCJ0sVx7lKJKuwNz2zQOFVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380018; c=relaxed/simple;
	bh=sMUHSMYllZc2m5zwIz1Y53ZtMxw+dJrdh4/kyyQIm7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyTdBL0lZ4GVGgPZxk0FHhvSG9kqWRz0FuLjMZgaXkBajyTezUQyBGqM/GwHNwYI6R7nScvwupOwSD/86hgzbWJcwFW0eQPKe80QETMMQE1VKjcJladjvWiEBznUMzG+pcFect1KPR1Na2Texxh11m9vbJJ42i64JP1yWrOl7qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=joup7owb; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AagHltkaCn2IT9GIaNHmrFBapjROiyrKaaVVst+sd5CwbINVlzm0BP62FNfdP4ZoTfjMMsCFSNMt7D0qGB2YzbKcRH6DKUHfUO4qBxcjjRAeeMmiZ2tSdIqurd++ZyhVg21Ny1/0LfW0CTs63eTas7VBIqlWpRM7WsdQZY/D2EVWRPs72MsE2xeh04OMlbYZVUQmEKCNmFGY3y6lWT6sVDGjXC7RkoMHElCF0/e1pQlnU0Vangdh+tYYrbsu8JMA9Y0QmcUlA9TNNdzrsrX9fKt5TW6GyQ+N6Es+ze7CD04V9mVszCEn+ttTzm9N3uKQN4aDzQq7WvYcl5NWtOS7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXV5aj/C8gnZUTtSeeVTH27Ityi2rqnRP6i0xW4Ypkg=;
 b=q9MVodoSMYJ4Dl/sh9xErkM0EKrLI8gd7zT+7IC1DYm0DH7T6xdGm7C+NEEsiMaWOXGRyf2nksu4wnXeO6P81+6kTfMZFDm3H9LYE5KwSrcxPeNENiM3WrPTvQyf6GcrFIG93pMha1CHhfp9gSLAOF/yI6TrmmwrFeckZE1PWf1Vq36sQ4DTSuoLFqqODh/jDNLhxOi9oUMC++DnpqIQNE2RdUuI8WZtip2uzyp8EBaLiOKBo5OWoQQiYi/eb6Zs30avBuN/2ffquniPNCIOxn7DT6Az9SVUlZoKgzy3cjHjFVuwSMpGO8FqtPYYLAL0Bd5RdNXjJOpaS7xanw9z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXV5aj/C8gnZUTtSeeVTH27Ityi2rqnRP6i0xW4Ypkg=;
 b=joup7owbNVzcu73Ymh4Rr2obdVP/0Al/Bh/In7pAq3BA7vOyiOXlWWzKBIGVWA2jUZpLvJySJczwXZ1ytPiXWGJg63bd168tlaM2DqUKG7LzCPzBMpuon9yVa6VZaFHbs7ils2azKLrPfLUh0Lwtiiv23CatejMItuc+MbZDZp/IQgAhYWgIwxa8Iy3R2ykQUgUOhoFeJOlV9P1P4hyLGQ7IfYbTdIvDtGyEsXjN7PL1d1qG9rxGV3VE+SrI2KUh71a2F1EkVZJ90AReOdT1WiN/mOdaL7JzmnTuKGzN2BMFYtHkSPzCiVW0NJLdJMGYASb/fWLxd1AL5i/fBBXn/Q==
Received: from CH2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:610:4f::24)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:53:30 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::24) by CH2PR18CA0014.outlook.office365.com
 (2603:10b6:610:4f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 06:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 06:53:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Feb
 2025 22:53:19 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Feb
 2025 22:53:17 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 2/5] iprule: Move port parsing to a function
Date: Mon, 24 Feb 2025 08:52:37 +0200
Message-ID: <20250224065241.236141-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c167a0-0be5-4956-53b0-08dd549ff260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9Ce4HwZ8lBQOA0ZVzJo5nwpcqJjNlH82Msy7g2+vTsg5MYiyVT9mP6rdOR7?=
 =?us-ascii?Q?/oAT1OeBriCromVkmTfbeTB/gKnm5YIRrvIvdcFLWWn/5xYnWanjyF9mgdbN?=
 =?us-ascii?Q?e41BlGDm+ypmIce2sL6yJdnBLvo/ofJcqgvXa8SIPTh/Aky1kK7cCofq6K/a?=
 =?us-ascii?Q?AVmsTHwPTUnR+7+UoXvC6dXNCcndeGSbZfZWZb7JVc7RKPV/LVTwKm3j4W50?=
 =?us-ascii?Q?rxHp0fF86mbmRYzITaUEnr5dqJu3PkZHQwU5IPCEQ9ut1caqyOZu/53RNFau?=
 =?us-ascii?Q?Sga6HfaI4DBkalPjwNw7JX7bf//H5kaOrgOnEvQOt8/kSrOv6NBqQdSJHs7W?=
 =?us-ascii?Q?946YXxGRCWM5ZOY+FchwmdQ3hzyUPjP092WhEanJ1ToLd+sqFfofhRzVfCVv?=
 =?us-ascii?Q?ApGItMsWRPYkHuGXfUucn08Ov4+I3yTIK0Rn69OmgzWaJmwTtO0Sf5lZJSHH?=
 =?us-ascii?Q?y3N5ad8HM7CHL+ulos/N6cJPJAyoM5XmlpzNueiM3kUaDyMtPlZ8ayP7U+Do?=
 =?us-ascii?Q?hV4OXHS8DMZHK07qm8pQqAqaTHPM3DioCz4pqWPXOjf2iPxmv5hrMO3tIKTl?=
 =?us-ascii?Q?uk+ITVokoQrmeE4415qOMaZaI81MaGJr1faasayULGQsGUOPC2po6uRZ8pc6?=
 =?us-ascii?Q?MqZWjfR2CosWtXC+LhVH5MGahWKPcgxfmz0e1VFr8qte1huw5otX+D/er00O?=
 =?us-ascii?Q?IioAmWBt4gjXkLsnr6darKWRpNBojUbpiozIDXIZUvESxh/wQcu6IZCK0Gj9?=
 =?us-ascii?Q?Jyz8tAWWTcXZY9m0ASi0t8yOCX2hd//QecZVeWis7DrKPKWehwnhOYk/6kba?=
 =?us-ascii?Q?pK7uAs57wAIwmDICIq6wbT4i1RRB7wFTB/yDKEdJScEaLfxJZl9iUGFCLCSU?=
 =?us-ascii?Q?JU0RpgOu4rceu7MiQorNm66UibwMRHCEBLaUXzobmdODCYCRQ2SUzpfStYNr?=
 =?us-ascii?Q?aSin0TtjoPPjV6gL5lEicTPDT4y3pAJSCFrlPJFDLbKJrHnSPqlNCafl/yuK?=
 =?us-ascii?Q?7zkgI52DOsaK5Z2dFJim3zZhvRrZnOCuVZsYPwACaiS66VrVkJgTEJbiBulv?=
 =?us-ascii?Q?7tcpuW6bKkUtsQoCOw+8KNOWIeKiugxZxeSLaV9l/KqslKnp/xx7m52UfK4v?=
 =?us-ascii?Q?21Qu/HcfNGAE0RbXk75O8+KSx2bwk1UMsWv5PloaO9k8YoDpq/GT1bMdfLe2?=
 =?us-ascii?Q?AQ77stNIRYMX+zBsolJfD3pE79jY7Sm3vjCg4yILy0YKB+H0Oo8g2qOi2jbu?=
 =?us-ascii?Q?OAuc7/Q74nCWP2nIUbahXAQcC1MxrkexL/SaQb0lHPJ/Ez44Ee3seEdKmoG6?=
 =?us-ascii?Q?mOtoGGTiLPkbfqrAVyQKDz19IWNN++nrxHazXrsl2HisgKsblarxkdCQZVbz?=
 =?us-ascii?Q?4j/cJJhdarD7IrsttIQjd/MoOOHb5CIPk0wDSDv1OHhm8bQTyynAanp6raRL?=
 =?us-ascii?Q?uJS27KUXMwx0FbM98ocjJ7Gu/pN7m/WoIduKPrkEg/vAt7mooBE+QE7veHu4?=
 =?us-ascii?Q?y1bpJyVA4UoX8QY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:53:29.7692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c167a0-0be5-4956-53b0-08dd549ff260
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679

In preparation for adding port mask support, move port parsing to a
function.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/iprule.c | 57 +++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index ea30d418712c..61e092bc5693 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -600,6 +600,29 @@ static int flush_rule(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
+static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
+{
+	char *sep;
+
+	sep = strchr(arg, '-');
+	if (sep) {
+		*sep = '\0';
+
+		if (get_u16(&r->start, arg, 10))
+			invarg("invalid port range start", arg);
+
+		if (get_u16(&r->end, sep + 1, 10))
+			invarg("invalid port range end", sep + 1);
+
+		return;
+	}
+
+	if (get_u16(&r->start, arg, 10))
+		invarg("invalid port", arg);
+
+	r->end = r->start;
+}
+
 static void iprule_flowlabel_parse(char *arg, __u32 *flowlabel,
 				   __u32 *flowlabel_mask)
 {
@@ -746,27 +769,11 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
 				invarg("Invalid \"ipproto\" value\n", *argv);
 			filter.ipproto = ipproto;
 		} else if (strcmp(*argv, "sport") == 0) {
-			struct fib_rule_port_range r;
-			int ret;
-
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid port range\n", *argv);
-			filter.sport = r;
+			iprule_port_parse(*argv, &filter.sport);
 		} else if (strcmp(*argv, "dport") == 0) {
-			struct fib_rule_port_range r;
-			int ret;
-
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid dport range\n", *argv);
-			filter.dport = r;
+			iprule_port_parse(*argv, &filter.dport);
 		} else if (strcmp(*argv, "dscp") == 0) {
 			__u32 dscp;
 
@@ -1036,26 +1043,16 @@ static int iprule_modify(int cmd, int argc, char **argv)
 			addattr8(&req.n, sizeof(req), FRA_IP_PROTO, ipproto);
 		} else if (strcmp(*argv, "sport") == 0) {
 			struct fib_rule_port_range r;
-			int ret = 0;
 
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid port range\n", *argv);
+			iprule_port_parse(*argv, &r);
 			addattr_l(&req.n, sizeof(req), FRA_SPORT_RANGE, &r,
 				  sizeof(r));
 		} else if (strcmp(*argv, "dport") == 0) {
 			struct fib_rule_port_range r;
-			int ret = 0;
 
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid dport range\n", *argv);
+			iprule_port_parse(*argv, &r);
 			addattr_l(&req.n, sizeof(req), FRA_DPORT_RANGE, &r,
 				  sizeof(r));
 		} else if (strcmp(*argv, "dscp") == 0) {
-- 
2.48.1


