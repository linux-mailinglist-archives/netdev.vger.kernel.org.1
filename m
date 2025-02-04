Return-Path: <netdev+bounces-162553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA8A27395
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA57A469E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6552165EE;
	Tue,  4 Feb 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ueqHn5Ma"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB342163B8
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676451; cv=fail; b=k0s9OvVDExrWlLYhv5Yd/8SZTWR/leInyFQh8/5vrPKCwd27G1Y3NPhS0C65zqE92eU7UHQQ2/NjVREqEsoUZPBPlWjUNSOoEI5VZ7E5B21LGvlEU8PSqnTkedab9hC2YkiYcUDv5Se0aZtli+E+56Px/Oo5vLgU6pFzvbCAqgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676451; c=relaxed/simple;
	bh=ZHSSEtEeuHoIju1YAj1fdObzJg6neqk5rEqhD3FYP18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijbXUk1/Uy7eQS0URJwQvcY2JrgW/SWB4WW9YuRED9wHbNo+3W36fYPYjOSxkP/KDuCLSZY3BZmgN1FlNdI1riXGPJv9+6prQKtiIfKY/HxVwLV51rLzbQBddX3qDCnvWmhKHsmCk2Pj1aUOH6LRrFtqxVBpsPPlq7RkdIjxZ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ueqHn5Ma; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr7uEBDOec8TZktp9CWYypijXyacO1SRGiJ+tn5kMxQtjMGjwgAPTTHYSwt0WfcX5blGMA+n2buSBwkCHFcRgK/phaHXoA35mdXcyjpHgZGnn1cRIHnz2+IJfa+w+irODgkKe49+R7FMkeG4C5NSjd0HcqUCFCCgqjwVRGhrSWLaOdAPuqE4CNS6Ar68AA/bP8nqBfU4s9pZTgtJbk2JKHYP9vcy9+jKGMONPy9LoDyY21+N4+o1YYq0t98Auzvd/pLE/8SX8h2DW2guAvgmp2sM7FkySdUS+QCjrfcy1TGs11miqpSK0jO3XSo6K6eAem/zzbuZEibd2t54Fk2uUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMd7JNSG1MXZURwkEpUYq6oSlRvrTzhriiIBmJssAWc=;
 b=o2ofO441b13m3qA/rIxjIepUkymN6AvVBU5YAPrEJ1R9kJBCh0pLt3eDs/bNCPfaW5aED75C/ZcX/RV7/haHseFSKy1jTLK77pzBBKqQtz/bZovUitI6KfG1oDOwS6ErNHip1eUYwtKQQvKt5uCTgpr8vAhI/oVrfz/CnwClxMbRXlyBYFoIkI3HFqGW2c7iGE1J8L0mETvqDhDYQ9GNJ8oeMCRdC5YsbnDsEDo11ethx7q8ll89OJxGrGx0vTwbkRUT3aIEjb9B16qBAIrOM0IWB2wpkhLT65xd9xgWIfJpd441whgQl8OapqfKuPPfewQQRhno9RD8odEZm2V9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMd7JNSG1MXZURwkEpUYq6oSlRvrTzhriiIBmJssAWc=;
 b=ueqHn5MaLFWQ8SOdwbdT8vCtBv295K6BzbC9jsF8hEcZWxmqwlIf1jVkPEfabh1So8gIDTI0YbD6Qf36SCcMB9W05EV3VfVDIFPzbnFokD8+CaUmG2R6RJ8hlt+Qz1JqnlTHgG63Miz9yH9fsBtmxkaMBdpHQpWAqlvKuCxEvF2KcEulZCi7WSxBqmHTcn8lfuNrR124M/tOyzbK87NOPGwJkzm4+EqZuU2lQalvbc6fpBFuwQ2H5BXn+pYNmKJSaA2xNVBJIX5JFpZEZiiLAOvkKJzgmFiPolGIQ4w3NkRhSdvrgHN31Cr1Zkb1BVLX5FO7+DOsZF4PtOwT2mAneQ==
Received: from MN2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:208:23e::12)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:40:47 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::50) by MN2PR14CA0007.outlook.office365.com
 (2603:10b6:208:23e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 13:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:25 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:22 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 05/16] qsfp: Reorder the channel-level flags list for SFF8636 module type
Date: Tue, 4 Feb 2025 15:39:46 +0200
Message-ID: <20250204133957.1140677-6-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1563e8-32d7-4fe1-7eab-08dd452187a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vDk8kgo3aM4//yV0NxuTdED9zFwkHkLMuAdo8tpsGV71NBligtkMq4hDJghZ?=
 =?us-ascii?Q?ZQDHQVYLHYwissxJCXqJnd5rgPUcxzNV/YrQn7XN2GAUWxnYuVWhWD3dRPuL?=
 =?us-ascii?Q?KYFyzBNXieUt2LsKkuhsu5WEVz4Gq4R+3Nwt7CUZYmkINxdBqFbp+JRorZx1?=
 =?us-ascii?Q?HJOBOiyK8XO5rrE+yrnsDDf3DeMRWWJAJDxWQSzHxAXSawbOiFSrXXUkB4T0?=
 =?us-ascii?Q?G1Gm1m62Csu17+efnTrlJAKBuot37cPQpniOH8o61Vue2WFdNg3EummEIu73?=
 =?us-ascii?Q?1QHYIVKgxrbug59w7S1JEhOdx06XgrTrt8JztMD9t0cKRt6ITscq26xEQ7mP?=
 =?us-ascii?Q?ZoHb8RhF7Pv+RsKC04mi4mRaT33d4rvea135XmV9qFCE8yjXEMocSXSrc/FJ?=
 =?us-ascii?Q?nriY/Tx14crULAUmDgZOyqBSpys/E7Yl9RtPtu93oBeiSoh54bKQhXtTUKQm?=
 =?us-ascii?Q?8V1msWxDoFHqoXguRSc7hvxz6kHkOg3V7pvVKzWXXQDgHn0GMsjL+EJ4swy5?=
 =?us-ascii?Q?GFtr6X8nSbyhpMh43cYAnpheDvVOJXw/bIbYQH5KafgGgWgTzdxDQZRPKIdU?=
 =?us-ascii?Q?oR3xWGFULJyiOQxTt+1O4eW1DKZsCBPvSBhjxw0qa9cGl1FMlOW9Th7in0LQ?=
 =?us-ascii?Q?3fdgjaF9v/vsFT4ANGeeGI+PeUmRYjdSCO6DwZzQWjLqUJSOl75CGR03PeYm?=
 =?us-ascii?Q?h+v25h/nARKv6U0qVml8H/CZ1u/j7lOyy+fbAICFk0WdB4y4i9nAIX4pbGX6?=
 =?us-ascii?Q?5Fjg6yLcxQoz5JQG96zLFKPtQoqrDvkS6oXLYL+ROPiN0OLP/uFXOa2dqhBl?=
 =?us-ascii?Q?2Q0EXR3NG9pkR2mh9cs9zU2rJ2viCTNdleBnJJ+RozY/B4OblXXKVQOt4CG5?=
 =?us-ascii?Q?wimf+AMla7kUQTMqYtelU4btltu10F1zxjp5uz9u26DJ/j1/DBwgOu6QpMTv?=
 =?us-ascii?Q?JQfHTpmU+SdwJeBqHLET2LpWwS0o3ggSNsJaQ+XwbmV6XTVBF0GexUyH8jgJ?=
 =?us-ascii?Q?i4L7Lt5PIfaRC6qDX9YniW64PjluZrcsYD2JtfMICOg0+EZPQoxa8QSOFjmY?=
 =?us-ascii?Q?3hHxP3Y03ORKhtLBuxqUG2+gkMDOLP3Dshm7mT2uOqEjN5e5ERj+YqH1LBps?=
 =?us-ascii?Q?jx9wYbTVWKnMFrD7pNmwdIMMpVsLYPfmoKn6R9nMBV2tmNaghz84NpHATDE5?=
 =?us-ascii?Q?qzLHGZhJvwUeOlYCYewr7zUPIjQG9jPXsJLdr296Ec1QdczSq7AmkkeI96e9?=
 =?us-ascii?Q?nZ+iMMTbgjVBg60T9ATyG0/PxNYa5J0rhthXp1qDmVJGJzRnTYdc5KDw3yWR?=
 =?us-ascii?Q?v9NOkAH5GsZiOFZ6kf6C0uFF0wQSRsbFrn/HV44VobkIWJRBGiiJArNalBNY?=
 =?us-ascii?Q?ADt+emZ9eQf2usgR8VKNkm+pNdP+j0ZOEYwi2s/SKzRAsNxLOIel/9cm9OWI?=
 =?us-ascii?Q?BxpJ+Ge4aiuKmv3bKUfRoRmTzHaswy2glRA5MqDv4ZpDs7kth+iHTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:46.6324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1563e8-32d7-4fe1-7eab-08dd452187a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933

Currently, when printing channel-level flags in the ethtool dump, we
iterate over a list where each element represents a flag and a channel.

The list is structured such that, for each channel, all elements with
the same flag are grouped together.

To accommodate future JSON support, where per-channel fields will be
represented as an array (with each element corresponding to a specific
channel), the presentation order needs to change.
Additionally, the hard-coded channel numbers in the flag names should
be removed.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Simplify sff8636_show_dom().

 module-common.c | 168 ++++++++++++++++++++++++------------------------
 qsfp.c          |  17 +++--
 2 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/module-common.c b/module-common.c
index ec61b1e..4146a84 100644
--- a/module-common.c
+++ b/module-common.c
@@ -87,112 +87,112 @@ const struct module_aw_chan module_aw_chan_flags[] = {
 	  CMIS_RX_PWR_AW_LWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
 	  CMIS_RX_PWR_MON_MASK },
 
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 1)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 2)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 3)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 4)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LWARN) },
 
 	{ 0, NULL, 0, 0, 0 },
diff --git a/qsfp.c b/qsfp.c
index 5baf3fa..c44f045 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -711,13 +711,18 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	}
 
 	if (sd.supports_alarms) {
+		bool value;
+
 		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
-			if (module_aw_chan_flags[i].type == MODULE_TYPE_SFF8636)
-				printf("\t%-41s : %s\n",
-				       module_aw_chan_flags[i].fmt_str,
-				       (map->lower_memory[module_aw_chan_flags[i].offset]
-				        & module_aw_chan_flags[i].adver_value) ?
-				       "On" : "Off");
+			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+				continue;
+
+			value = map->lower_memory[module_aw_chan_flags[i].offset] &
+				module_aw_chan_flags[i].adver_value;
+			printf("\t%-41s (Chan %d) : %s\n",
+			       module_aw_chan_flags[i].fmt_str,
+			       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
+			       value ? "On" : "Off");
 		}
 		for (i = 0; module_aw_mod_flags[i].str; ++i) {
 			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-- 
2.47.0


