Return-Path: <netdev+bounces-196214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA57DAD3DF6
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E067A5281
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECF23C513;
	Tue, 10 Jun 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lRbyQF5T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456323C4EF
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570862; cv=fail; b=szeZilPZciYpLdTdzeZqIw3MJNsDzpiQuFatWNyMm7CgKAEIytQ9dQZTD6FhYLjT+0Iks3gCUr9Kk0llnAcdoWs/eVc5tmW5OdBXum0cOJA7+PbJUv0oNkWJNt80Y0Dp9VDbcmDX9g147sAZos0wQC1gywNopMwyMFKa5jK3CZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570862; c=relaxed/simple;
	bh=+8qu8lrhhLWh4dp1feAmuePofDBcg7qweJN7YxrGM8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBISzllCUOqP8O/kLWITb4g16q/fan4GLQIWM5VOTeZFU6EsJw8RVr2AJAnPtkMEhH2cZqbuMe5UFjmsv/sZeDlE3GyW+N6GzAkZ9wQNTaUNWRCEFPTtDA0A8PDl818adRtEjOISo+0DNK2ShGzN9xrGTPBr/YzPSdXz+IMI/dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lRbyQF5T; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEDokuPM3wfDUFZ0UUqQfCmLR4rUYf/ruCzXtatQAK7gUOj3DB6k0ilWVFCdm8c4CsydcLnb/2QZYcbT7lgpCthC6A8LihRCHvr3sNBSM0RmTF8lvBFLYVKIKuHjRjx0+C/FnuaEPWzty/A7YS8CXqHapVJPY7G6jXBXsjQ2OJ3vRgsh6pm7zicfr5pAzH3ytdf2VGEc5vcayAdNmiJlBQ7S+spBmGBPY5zlVrgXTByBoLV6xl5DI+AFqvKYzK+o4lbBq1GaZKY0DOzXrJbgjAwZBwDxaD64vQrYxZvlxw3VRzLTX8STkc9SbpX6TwZ7i/BZAHGZ96HiBDw37CSXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X88acDI4fIvfRORbABjQhAPMQyLJKeLvL8V+8m8CPzs=;
 b=JrT7hHKqYif0jb+5X7cLPVtJjfNDMbhMeoRwv0ED36Juz98EIHH/TLeBSWfs0dOlQeCtPeQUYemcKPZ+JZAVD1Hrssv02UsfkpZ0b4Ak/EYhEP/hjtF0d6lFnwkLXpp+RW3IVN723kEysaiOTNS9w/ioNAQn30b3n7uuzeCCY0haEDyAcC1q4kGkPsSXD67Z7w4NK5n6dsEPnynqTAUYYB616k7N42a1Hk6+iNdu2Dm6bH4xSxUVUhP5Ad5L+L6e+VEUapkBmanYy/11qKrT4OYXL7BqtJB+55fH5SljSIGWzipVbrLUWWMbjiLskyDrHZfmXdbZyznGk7uOq+oOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X88acDI4fIvfRORbABjQhAPMQyLJKeLvL8V+8m8CPzs=;
 b=lRbyQF5TN/D11tKTApwJF4bbsqgFLDV9Z1pZXUpYFHp3DEFI8IqeEKNR2wbhvmRBr0manQj4ezS3zzpigxoMyUATfS15A8KADlwYsgp+DHvXpydsZb0fm0AMTgTdbdqwaNxj/TgDJcAAMxTk63q1KvXOtyn/o/L9esAb6EUhpFu009vOE4B70smDkr7rdiQlBPGwMCrB4LEQmmdufR9HpiU1dkQtJiLxPbMvWuVN4kyjSBZFAGvIcj+KBV9QnclGrgYcrpHNA966F1q6tQENgS6++mle91ue6oMclZOL5gVZPxHvZQSGZqIHyLwQZGGsREQa4keMaVSG/d5DNoSAwQ==
Received: from MW4PR03CA0132.namprd03.prod.outlook.com (2603:10b6:303:8c::17)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:54:18 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::f1) by MW4PR03CA0132.outlook.office365.com
 (2603:10b6:303:8c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Tue,
 10 Jun 2025 15:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:54:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:53:56 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:53:53 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v3 2/4] ip: ip_common: Drop ipstats_stat_desc_xstats::inner_max
Date: Tue, 10 Jun 2025 17:51:25 +0200
Message-ID: <6dc4c8b667e8befa86d84036743eaeefe3c02b38.1749567243.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a1764d-5381-4380-a984-08dda8370f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DWQFxSUZsmPRJr/2x2TU9W7bAqokBvqxuD06cuTMKhroV2rl24I6FzAHXtFS?=
 =?us-ascii?Q?Gbf6fS23IlMYQGIkIAe5Cr05mq7R9Q1YVwifd1z3Tf0U+xXlbYRw7//z0W+Z?=
 =?us-ascii?Q?YWbyHegpBTXxyQsAXNbfWS/LP1IWHGJM8y8Pfqj0r4ozR402zxrpnFjR8jta?=
 =?us-ascii?Q?wNKbFxL2bz2xZoIYKyM2K/Ivth6SA6EwRjuOmeHzsy3xE7ImOY+baRbnqrW9?=
 =?us-ascii?Q?LjFL3fEsVEqoqIIsdTvjd0AHSW1tanWQEXMEjBTR/mynlhCnZmFeN6FCMh05?=
 =?us-ascii?Q?scABH5pVdtUcwmUBZAO332S6ulnZqENHX7MVRrD+RMcNGJyQUTBT+6FDypkr?=
 =?us-ascii?Q?F+gki2MkN5p/MNxgHFepcidwvzBYX2HAsqIg7LBYtzNfPITpe1GZSzq0kNKu?=
 =?us-ascii?Q?voR7XDq73OuykISSBzTWNK1b9BY9Zc/FeTo/HSofRB412nqc/d514w55KCpC?=
 =?us-ascii?Q?FBIigAA32AwUvy/cbb0Y0V5SIA3dVtMzUsXADnYPzS8hFfxv+9tFnWeuRNjx?=
 =?us-ascii?Q?Ig9KZA3i3IxWKTqFmaRldKdC4RtCZELXLHo/F2HCdUBSRSKYxJqGeH5K5AbW?=
 =?us-ascii?Q?DAEoOqwUOrsj/s7WuP/VMGTrb/31JChks2ewKD0Dcfr2P1cJEkB+Rsxdz3lC?=
 =?us-ascii?Q?u/NsVe4LK5Ve5pLgKjMcKzQqq4bwNzolnFowFmgj1VDhn84Aw7x4PDkFod0v?=
 =?us-ascii?Q?wVZlHBcJVRdg25r6Dv7k+hNOWuYMugYlnUz5aF8UOJOyPyhdMIYSn5APTKnJ?=
 =?us-ascii?Q?gXJT3c6lKzzVEohBlOif60c7T740e5v2kJbXOM8Ki0Uop2OB9LB1kP8d2itS?=
 =?us-ascii?Q?QVU4sPnuxkNmmF8eIK4YGQHgeQAMEbn6vmMBlI7qY0mfjV+plw32wrExZG40?=
 =?us-ascii?Q?Q+kGSOonkiMAlg7JIjXZBuwptmSfwHyerQm1uA+DL4X3bI/vHEgA4WBFgY1X?=
 =?us-ascii?Q?cUUy1/bLezm2T1+9PzHkHWUnXXyvELtz/WsX07IpWBmmsWyYfJ0W9+iuzGlI?=
 =?us-ascii?Q?XwEMIIugnHAa/338o/+pue0LHTWUBfZ+c7FWcFXjE/hxjUDhvSFo6eVJyuuy?=
 =?us-ascii?Q?JQGOvmpIIv6BxeNyOiya/5oi1TUy+FrgH56KZapjtJke4p0ke6/EEFI3Pv9t?=
 =?us-ascii?Q?UeLjoUTdVEzX9vuxj3k/L+f37bGdERRF++mILwF1woHsLgzT45AL367kZzLk?=
 =?us-ascii?Q?O5F0Il7Nh4jsMPaKEMD+MKtffrFPhGIa1tBnwVebf9qihaBCILYKSzvudGOT?=
 =?us-ascii?Q?zztXTbUUX85A1GSkY2g/+HgbrAqhEJlJf/sHpmoHbkrxEoBPSGGavUPZCV3y?=
 =?us-ascii?Q?MXlVqkEX/1dmTzgjJLri5a3tOU9lbzRzYgcJGXIsy/mGGzSux+0ZloLiLOsp?=
 =?us-ascii?Q?YLRmClm3mB+n9PLCjGQd+0ej+PvmMH3oniVdYjZV28xYzveNBWJRzyKde0ba?=
 =?us-ascii?Q?Q4Td2jYK2uJSV13XbbG1+L3EqHTOM5yKe+BnBTV1qUiE6a+tDtNfjw/fmPQL?=
 =?us-ascii?Q?0EjXewD4OpMgQFd0fpT2mZcJKEmXQcp9q74V?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:54:18.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a1764d-5381-4380-a984-08dda8370f09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

After the previous patch, this field is not read anymore. Drop it.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 ip/ip_common.h     | 1 -
 ip/iplink_bond.c   | 2 --
 ip/iplink_bridge.c | 4 ----
 3 files changed, 7 deletions(-)

diff --git a/ip/ip_common.h b/ip/ip_common.h
index 37de09d4..3f55ea33 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -195,7 +195,6 @@ struct ipstats_stat_desc_xstats {
 	const struct ipstats_stat_desc desc;
 	int xstats_at;
 	int link_type_at;
-	int inner_max;
 	int inner_at;
 	void (*show_cb)(const struct rtattr *at);
 };
diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d0..a964f547 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -940,7 +940,6 @@ ipstats_stat_desc_xstats_bond_lacp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("802.3ad"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS,
 	.link_type_at = LINK_XSTATS_TYPE_BOND,
-	.inner_max = BOND_XSTATS_MAX,
 	.inner_at = BOND_XSTATS_3AD,
 	.show_cb = &bond_print_3ad_stats,
 };
@@ -962,7 +961,6 @@ ipstats_stat_desc_xstats_slave_bond_lacp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("802.3ad"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
 	.link_type_at = LINK_XSTATS_TYPE_BOND,
-	.inner_max = BOND_XSTATS_MAX,
 	.inner_at = BOND_XSTATS_3AD,
 	.show_cb = &bond_print_3ad_stats,
 };
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index d98bfa5a..3d54e203 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -1075,7 +1075,6 @@ ipstats_stat_desc_xstats_bridge_stp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("stp"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_STP,
 	.show_cb = &bridge_print_stats_stp,
 };
@@ -1085,7 +1084,6 @@ ipstats_stat_desc_xstats_bridge_mcast = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("mcast"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_MCAST,
 	.show_cb = &bridge_print_stats_mcast,
 };
@@ -1108,7 +1106,6 @@ ipstats_stat_desc_xstats_slave_bridge_stp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("stp"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_STP,
 	.show_cb = &bridge_print_stats_stp,
 };
@@ -1118,7 +1115,6 @@ ipstats_stat_desc_xstats_slave_bridge_mcast = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("mcast"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_MCAST,
 	.show_cb = &bridge_print_stats_mcast,
 };
-- 
2.49.0


