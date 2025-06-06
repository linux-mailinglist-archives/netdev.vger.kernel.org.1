Return-Path: <netdev+bounces-195463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30BAD04E9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AEB7AAED5
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D78289828;
	Fri,  6 Jun 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dHSVpTgz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23A28981C
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222483; cv=fail; b=FZ75qG5QD6OfYtBcA7LfUg9RV8MLxYlC4SJDXSCl3go/5AdtxWgOhm54PdYOlmU8ALE21yc7HKgKsMKpuYqtBvy+GyTfNCVVSG+Wydav06ercQ5V2e95cQ93mGAOYoBbH29DdHfzEiYjrrTJxSLHuLDWUuiJ0rFEllFsfCz5pIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222483; c=relaxed/simple;
	bh=CgxuLVVM0NkXvTqXU2yeSrN57vmvi94w12iGzHYl3DI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWx+sLBR/hV/p5EX+omM/Aq5lxo56WMdSYeuMDp8NYlQYW4QZ9HQ4lJx2309wHP2WVpuT2b6DtjzOkbq/eiYgKN+AEt7SZDRIntVsRgKIIrvzVMUlTdznvZ0MGdqRIBWZIicGLo1LjvZ4CrydmgNdH8mt8wkcZZymWTlMDeFYuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dHSVpTgz; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXHmQaPO6xTcBOXXitmaRfVbBZtrvYctTxKLkJzjzB9JvJ6zIlFL47HtsnCWtTRSteA+3cX9wr6JAGTBn67+xSs0n/95MWbNNG09n3SFzw+weM5QM5xImoV/rQSY/MFTNuWgcRHmDoo93blmi5Cn6+bztKEGXbkpDSJIymwbj9VrtLdPUReWu7ad0WobxEcJO+ptvTn5jvkSPXzpRZB62FXzOBSa27aafa83T9bw+cH2W1HG4Buk4aw4enghPr+F46HSqnS8VgQJeup0pbpauxjKrPzDfvwU3t+TxjM0yL26kXN7Ct8iGe3mTAhG1RPOrJpVlB48/O2xxmqJwncPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHct52lom49PGBeWG3/vSiMyiUuVs8d2PkYDxcys9KM=;
 b=jKNuG4Hse88NN6z2ImoV+MLz27ixvbfJrsQ+uhONdxvh2zzTIffQbPvDhEo9zl/vWyV1qmBdg1wWX4N5UXKHduUoRy/AizQntJwSpYde1y0EvjLwJItpHQpadsxJxyi21lrmw7zr3w/LSUCu3P8QR1EvrUj7PezpJXuvTRtMNjVus5oBWfTdmt98YamIFKYDfh4ZdyMFZbaqmwQwaVc44rlpeusfPR/1Wm/tmF0Qddb4BybLO3dsOA+aEU8JnvUSCo2ioInTrWMV3J4bTFYHo/1wvwwKCcP6D0978Wf1obkiLGBsJf9JV1RNaujV4EkJVHh+sAb5cK8j9/Pe5WyFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHct52lom49PGBeWG3/vSiMyiUuVs8d2PkYDxcys9KM=;
 b=dHSVpTgzQBdhjZYDETdUYK4/qKtI+kPXtFlYZ+zs2c5Mcrfiq1UZl9RspRdcQhb5pmhRYzHYfeUwtqW+6grjRrDYLX7TxHe8VJyLcCSnclYpE0x7Cwb0zPCPJzod9Fzo0FbhKLC0C7gYK15iU7odl/SoQGJpzGpMeh1/zgYl/UkSP+HWVeyF2WtWcB53aKF+xDTR2e8pfCv2i40LM57bJm1jM6ey2I6jWq1MFw8GOS2MrUfUiifXFAIcSmBJzWjNSlUocfa0gJxgX9eh+DxPHRheFiZMqpep3o941VPYU/4C31E0Yh6V4r8rsbR9SmESRrVSnLLK4belDJJ3ofZjLg==
Received: from SJ0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:a03:39f::12)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Fri, 6 Jun
 2025 15:07:58 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::7e) by SJ0PR03CA0217.outlook.office365.com
 (2603:10b6:a03:39f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 6 Jun 2025 15:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 15:07:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 08:07:43 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 08:07:38 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 2/4] ip: ip_common: Drop ipstats_stat_desc_xstats::inner_max
Date: Fri, 6 Jun 2025 17:04:51 +0200
Message-ID: <2295631ffdf81687e4cc7eb2b1ff09e2434c623d.1749220201.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8ad402-aa23-4ee6-5457-08dda50bec98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hKJhhb9sk2jHQ6uCRONbH+ommOVD6gn/P0wUsGGRYesS00TkoiOuiMRT1CcV?=
 =?us-ascii?Q?e04BBNGtu6S2yyTTWpoYQRjm12fHxEBmihA/zzweYfki0AtGAK9/wybGfA8Q?=
 =?us-ascii?Q?nPQO/GMYJyRi7QVrZJ9rGZM0u+dyRe3+CkhFZwduSUFviFEI6bAmuwA1f9/U?=
 =?us-ascii?Q?P83mHi2L+43gPd98Ylaa2PiMrJWJktSN9DJ0Et2PevPO/5DKp2i5q5AYFKbq?=
 =?us-ascii?Q?dDjoiE1Hfm3AkuAxfDt+MGqluPio+L/IgVjmh1tCD9C+DqoWsPOdMe5yNm16?=
 =?us-ascii?Q?dfopIgpWRBWkt/70qnp9KPqOrdyUzsD/rvViD+q1IJtQ/0Qg8dmBNEZRB0Fg?=
 =?us-ascii?Q?HZ2UoS4SNZJkTki53QnhoDrdIy9EyovVRdePMxZK/8/ocB06+HWPFbt2AsmH?=
 =?us-ascii?Q?Ho+oYzdaKDjPw1TE1G0iZTJXvwaCOGN6LfHD4g8XJcRs2nkicWw/G7sR51vd?=
 =?us-ascii?Q?qLFGzlN5Ikx8V7Xnj/nLvPbEmEvBFM/MpufVzDiXIbJQqXFEBi0WnjOB1dVu?=
 =?us-ascii?Q?Yk4eYmIe9OFSm5+sK1koxQ8f/Yn4t7hjPnXJiUnIwTB0g4CyrcWPAilBc+um?=
 =?us-ascii?Q?Lj/R9+zIgZSnPmqsJ4gClFoOh7dtuv8dz47sBv2A+ITtFzvZWMEZk0GYPmmW?=
 =?us-ascii?Q?a2vfZkZToe90rtYYXz0gQ2DyuqthL++jInRqy2fK3qF//VuP7FmWWlk68bNC?=
 =?us-ascii?Q?kG8SQMbMqP5fUARwbrk587xyV9+2+G9j66VJDX5pyi0YZa/gqvPUcGiCh9c2?=
 =?us-ascii?Q?dg3IudgWtdP5YpsiizP/wE8uZTB/b1h1P0NI/hZwRUB7uAxMsHh/u87jAuXR?=
 =?us-ascii?Q?iRQUG+Xgxzx69g4qyjwBtu1bOABrY0pCaiKjhdWd9rwNJzRQGyDQWe86F3Eq?=
 =?us-ascii?Q?z2g+dwkaKsK8/eARwp2Gc28SlROFktvoSDadBwPzvOO+l3TJUub4HsFIfwRZ?=
 =?us-ascii?Q?URvkL5vqJP0uEuviI4trvAjUX9nCjKe3LyAYiPXrUYokwyfbrYcdKbiSblIu?=
 =?us-ascii?Q?PdjJVmhK6anPGORsAiHMJYgzARXoNjbKi2OM05d+L82yaQohXSXrHWQJl0BF?=
 =?us-ascii?Q?NEAxIgeJJeeN1L5wUnDtx+6g8aDoUKwV2DVSoInaOOj5FMEO1SAkFsdfL5/g?=
 =?us-ascii?Q?9qUAwn7Pm9TRzEmjugOnu3VFeSgJgVV3CZTaSp869CiqJzkvY4xwL8JVxosm?=
 =?us-ascii?Q?NackeGpBbvOF6YHsBnSckUA+PpojOO43SNMy14TEBIKkOD1MLbzJfaf1g1Lj?=
 =?us-ascii?Q?7WrrVrUEo/YuAAYMOEUJAOOSL9h1K2+o6C8uf2vbsDb7zuIVHNmNoNueRmRF?=
 =?us-ascii?Q?TsCKeui1daI3cFi5L7ggKZEVc0dWphUTNtrR3M7DpXoP4tMXkDzz9irTMIOc?=
 =?us-ascii?Q?NQ80PMTw00qsxyYBFmAJ3IRKBUkfrDNw8NqfbRcb1XArKwm9yrrhx/srwrdJ?=
 =?us-ascii?Q?lWxLRYkb1C1DlTfKiVj627w6YzAcxwe43p5XkG42+ry+Or1OWlP3/0ZuZQ7B?=
 =?us-ascii?Q?Z5XXKEbxOrWWAjKSrD+2cO+yXTomXaV1vg4T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:07:58.7833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8ad402-aa23-4ee6-5457-08dda50bec98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808

After the previous patch, this field is not read anymore. Drop it.

Signed-off-by: Petr Machata <petrm@nvidia.com>
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


