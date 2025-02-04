Return-Path: <netdev+bounces-162564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B70A2738B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7DE160D2C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719221E0AD;
	Tue,  4 Feb 2025 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cJtIYtj1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53A21770B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676479; cv=fail; b=rCVMhLKsD/P/4RBBbT0xw4KD86ugp7qsMa6qW0B8YDN+qkvBwZmOC7p22RiVoovdmf9JnBny6ZcCDRRZ/yPi7EIB7s0l1t/20CzI2r7uDXikg8m8NPUyOS/mVH8yabDm612nh3695blTvWDoLnaQkXANpeEElnNiVl3GrpzpT2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676479; c=relaxed/simple;
	bh=IZRJjXwChqAxsN/2T9NZ7RHg5Tmt2b+uXO4M+HYE8kQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0ouSN6/vXpGa6/DiirDnqLk0YJOB5cej02KWjFJRSsko/69chblTSbtTC0064oLh3L+PhZJNEJexj6L3rD+t59J1+DzvCATp4EGRrm+siBIvdkefQ/hMzbCbwOth7W7950w7M/CygkDDTpA4g90/mjROFjIzuLCkTWXnJugch0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cJtIYtj1; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyntADEd+yHN6MNHdPlCcDrIjH59VwDpE59kzDs5xjfU+1jdYSr2qmq1/wx0LJ7JjIErCVUcVAOxTbsLGp/FrC+dDhF+fyEtXNCURWPtTIfWBrhNKyYSWxIu00a/7PtRXUa0gFO/jsxVM/5Pm4vHl8nsWuOycBtK0iZmb4OZOqdHPttNwjTDBTbepAhTA/TX6KH5texP2Jh2/LbR+PMh4ZAHh9tdALzdxcVhH0IQIePtIBWtgEfHYEqbYfYSt2UmUQ3onjtkvpT9nB4i51JrM8h7LIcBPXsh2kwOs+H8zqXT4V33rWgNvbMsqLF2So92rNCSfX+878aQzyrQzp0HRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYwfgEaRU1NHuMgOq9ZNUXj1FwMbCqLYI9PU7w4nKaI=;
 b=NEvXSsUoo37pfa6ujW/92YZnttfrdFDpp65N8YwYY/kcIaQGrV+jO63t6xqq7RG8xHeitUVV7F55cXbqNz9w71xKgOfQq3OM1zFmbMNEYGtm3xtAVU9Y1Jp0RNjCJ9Ox5dA9EW6ldfjYQBYn/uxP0WOZ3aO8AS2Yrm6kSmnzks8fdOu+RkasCVpUX5oEEIRmBAW7Qg/yAe46J8hMW3PT6Ss6HavxPk/Q//1HmIyCWzP59oL0Ws5go6kbvHAx86dECM6MMWySZ8j9PEFEXxsIfKEGP7h84SIiddIecExb5x5U4gEl8RaIPond83XZXiK2/LXXnIWKRcW8nnkMpvDvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYwfgEaRU1NHuMgOq9ZNUXj1FwMbCqLYI9PU7w4nKaI=;
 b=cJtIYtj1L9fjsFe7g5LQBkLTns1d3rdLQ2ciO2ZTAVjHp8GgrE4RR1z6C3YUkslXiNC9cOxtLylLXc7Rm91R7TfJsjg2rRu+QCudvyjwdAh4/y9r5i0KNoJ4kfdzU4/7US4hbU/ZWKt+Y9xDKCsEA796h/L40EK15mUyUuDKxsoro33oIWEFWse+FbsG8a08ZTMQYFMmpLQf9uX0ubYeupBzqlh3oQ4gqVbJEO9uq/LvsvjiU9LYw8wUeDeHnpWtUqjcsRRI69Zr2oNKTalmB9Smxd2uYtMsl47GmlE9uD0j2Ns7lppKyIYUYs9bHFtw6BjidZdDDxEvlntIK/2A5w==
Received: from MN0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:52c::7)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 13:41:15 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::fc) by MN0PR05CA0013.outlook.office365.com
 (2603:10b6:208:52c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 13:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:41:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:49 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:47 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 16/16] ethtool: Add '-j' support to ethtool
Date: Tue, 4 Feb 2025 15:39:57 +0200
Message-ID: <20250204133957.1140677-17-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204133957.1140677-1-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: aca5e126-55ad-4ef0-0355-08dd45219843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FAzrGrZHTBSySQUiqdxrX7i7/T0tQ27d6NG8CQmS2ZPzmkdSsEtnEylSjLlX?=
 =?us-ascii?Q?QLDx7XGiQRNX+o0ITzMCXFGdEVEbzj7FxRwto/fi9UqVDTvtJI9k43KPmT+I?=
 =?us-ascii?Q?yyG13tQOT3/03ydVTJR/aGoei10mAO5cNkeVgwV0RQC8LUd5G/SWjFWXTQjd?=
 =?us-ascii?Q?nT11/H9dAJbHZIpIFHTRcC3geYJdelh5RhWkQolCgt6K9Kb3pDtSTdF2oPTD?=
 =?us-ascii?Q?0y04YQoHO85iKSHbso+N6B4DIjG5gd/HZBLYBUUNjtohK1PmTPbCkc/6AVee?=
 =?us-ascii?Q?11dU7I3xm5gxps/7aG6uKgvFwOImGw+5bw+Ta/oQTDhEgzdKK/MDQ3wDNNb0?=
 =?us-ascii?Q?+CA+abwi0AhuyKie3PTRHrBEkoUKNn6EZThq6LM4sM38tR+AuzrZMXLTeyFL?=
 =?us-ascii?Q?Xa8ENOX0umcy/TGSDluG4UjU2Bs2CWsRf8V2ILQyVIiiPoSkiP9Bwp5ae6u7?=
 =?us-ascii?Q?NAYkZqc4UmLCYwW20grMpTFGoxemJeZHrnAnL+eHLK20t2aW9haQQwhx1hZ8?=
 =?us-ascii?Q?Y3raE4B+hv/ZYFlOuO71TtugaDbM4so9HnIK3Uaxl3JzTg3+mrR6U+X5H/2C?=
 =?us-ascii?Q?1CvehIsRilPulZ4ky8j8ol5O9KzLf29lybq98WTBLgUugX7x4HYgszMj/rPE?=
 =?us-ascii?Q?gnTpqWQv2OWzTYeiB31wto/NulBvfd6bnU5ZyrGV+SAwvPxxeyOE2yT4m7Ao?=
 =?us-ascii?Q?VTgIefbILNZ+zSsfpyhhHXqgHGRW4RhKDBKsK6sge0Q0/53yNzu8A8ycx7Qo?=
 =?us-ascii?Q?OG8m+kLCMc0hLHdPDE8H9QazXpx315iP+h0h1z89zjbC/+GY3YCw8dnsmltg?=
 =?us-ascii?Q?IkGNPoOSkifUVFKRDKA0U5dtlaJ+FuZiBosHAlIdHSIp8YLCLm8anDzhyaXm?=
 =?us-ascii?Q?hUb0ktRhIz2ghG6iYLMR345AjxcihzvMMJ8ns1txNQzW6LvC4R4/6fOXlAwU?=
 =?us-ascii?Q?QMz1xDtUZ6pYFBoE0Wop23kU0wEuyj3Tc1JPxOjHzx+vOZ9RTd0RFrPvfrKq?=
 =?us-ascii?Q?i77JpWwr5UjwxCMIJYmjqTMrCYp5p123w8dU/BAyVjLfrTolXZZjfAMYbzWg?=
 =?us-ascii?Q?H61sqDxGieX1Ld8EDWgtgD7MvV4aMvg4fYsK+NqzPLPLhLePGMsqg46O5Aq0?=
 =?us-ascii?Q?TxE9VZgKbFXai5am+lwbryJKmTpRkLCuFaK2Ye5DS5pwpQJkHV+rjyXLSDsd?=
 =?us-ascii?Q?1ukF0INfXJ7BSpiBJmhx9iTvjX1onv2NYYfMUd+jk0lJx5oLgBbyqtJ4dUT7?=
 =?us-ascii?Q?v1oSjbh8gElC/mdShngEBOQHqpDTJ9CDTLBMwaEL7IzZsvqFs3towouBh6Sq?=
 =?us-ascii?Q?8PXLBdnXGnILmIbbo8WNmgjZmUhMLiJOvHHl44uE/BJaNKMcacNV5BZXuzSQ?=
 =?us-ascii?Q?wZd/FACg9goxjSKzmoWl8/DTfHhcnjKBBCdHUDPjBnxbFplcdx7izB/E7knQ?=
 =?us-ascii?Q?kf6Mq9r/WnUBh71HSRrYhnjR+54WuE7e7lWbR7GJdLKZnNN1qnw09Mb3Xwut?=
 =?us-ascii?Q?w28WPk5zh6Ammj8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:41:14.5213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca5e126-55ad-4ef0-0355-08dd45219843
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324

Currently, only '--json' flag is supported for JSON output in the
ethtool commands.

Add support for the shorter '-j' flag also.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 8a81001..453058d 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6303,7 +6303,7 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout, "\n");
 	fprintf(stdout, "FLAGS:\n");
 	fprintf(stdout, "	--debug MASK	turn on debugging messages\n");
-	fprintf(stdout, "	--json		enable JSON output format (not supported by all commands)\n");
+	fprintf(stdout, "	-j|--json	enable JSON output format (not supported by all commands)\n");
 	fprintf(stdout, "	-I|--include-statistics		request device statistics related to the command (not supported by all commands)\n");
 
 	return 0;
@@ -6565,7 +6565,8 @@ int main(int argc, char **argp)
 			argc -= 1;
 			continue;
 		}
-		if (*argp && !strcmp(*argp, "--json")) {
+		if (*argp && (!strcmp(*argp, "--json") ||
+			      !strcmp(*argp, "-j"))) {
 			ctx.json = true;
 			argp += 1;
 			argc -= 1;
-- 
2.47.0


