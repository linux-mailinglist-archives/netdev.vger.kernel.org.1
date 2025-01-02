Return-Path: <netdev+bounces-154819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A699FFDA3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105547A1629
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88817BB21;
	Thu,  2 Jan 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U33RjH2p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDB18C907
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841768; cv=fail; b=WbdIGPhT7GJmQnouYP3LdY4CvJfLhdtHUBsW4vmex00tnynVL9eZwfRByeTyWbZ6VzUlblrDAI/ZLe+nMCxLOnbWvjrTfON6AI5lHkpFiVynUVHu3uIkRH8GlVl2sJn5R0b1zqNtKBf4ggI94X/7GB9c0UEBQuXYQpzWL+yz8yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841768; c=relaxed/simple;
	bh=//2ZOx1OpAflRRlQ5rQZdszPTk61GGvygtYAhjrTfOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tImym3XNvQpaUM1kBzLriP+XdkakisH4Vak/kMEmYTNw+Js0iRr/wH2eQ25GqeoUf2Y4/GLiaFTJkbkX/R7TXGDNWxLMNd+Yxa3P2iOaycRoTXrW39si/hxsAeseqYl3q5Ujb18ax5pGHClMUcjosup7x6VNug+wFXtndz8l7/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U33RjH2p; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjSxtHh7V2LgoGmz8IUWtdZ2Sk5LIoZgULtfxws7AdmteS+yNc1WEdN09ACSB+NncTCNF8V2p4XsPu+AF4DzMpc6uGwaSqyktuGmT4Ba7iei6ozaMKdY1SaXTKSumEXNzV5hqOPR9AiX4piGEwEsGvWkAoC1vf2eXh36a3gAJO0IeEnWumUsD3w51r96MpgfLRvGXhrC56csTLrLR5wfHfpXqx+7mfKQFhxSG4KJT1S83RZ80JZuXlhY2h5cmi/B4FddVA+w0i8NJDo80FBOzmTrkz9sPz9diPKC6MkiTvqU6Mk6Ahj0iKZGtHcqUngBM/gADMXUju0NQeaPVfP2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TL6lnopL/EWJyQ2zVWuCnElIE58m4HHuaHPX/hMDCY=;
 b=GqLF+AEmTELK+7g8vcfRvruhyAfN82BmYpswOR9nmxU4exWoCCGDEGBH+yRNic/FcpXkORAFEHSOPsfbdc/kDsq8t2w4thjnkFM+KdMXXALn1ZGbyjKQggaeXVqjfhNDti0mU9bABxkbd97CMg3GXkuHjyKzXij6jfjelb7ZLLrRdxkzChp64W3cKTie5pg2BOyPxAsUs7ouT6Ue5X184WPcM7Bwc/gc9BoKDHAhOLg5MntIm6np2eI7/6gTjCLGQ9uP8KNA8AIJME3iB++f7O2jj3Jlr/B1Fxhkfyyad9NI95BiCV5ovCNJMtNVSEo1r2a1+150Y1WmfHNNsK8t6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TL6lnopL/EWJyQ2zVWuCnElIE58m4HHuaHPX/hMDCY=;
 b=U33RjH2pH5PDBBaiKS+BkxkKg6//Dio0Kj/YUFwOiVfNJjZAU1sNtvKt8GmWaYiiGkMzhW5nfcNRq5WDLNVuUImJno9AA1i7Rm1X8sgPC4/mswwzsQgmHiT0S4Th10jdmZWtJDaGJ+UPjZ5Heu9Z/HnQxMS74mI2JlSoEbrvEvA+EPeKqAIwwq7r7jkVEjN2FNBacJOv5RdjmBDVOc3QUX4p06WeIotMldIx5xcoja6j9z3XlppDjQYjx/vAGaniMNnPC1WBJCNEQjnN6qNmjM7dKA8OHOgRHcEAm0fvDqjJiS66S6cLM3kXizuhAo/zMiJMR0VwhdxsiPeAtxns+Q==
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 18:15:55 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::45) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/15] net/mlx5: HWS, separate SQ that HWS uses from the usual traffic SQs
Date: Thu, 2 Jan 2025 20:14:09 +0200
Message-ID: <20250102181415.1477316-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eace3bd-f2a6-4b0a-9a01-08dd2b597f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NG1BB//LSEB8WPGctVQ3eeFFB9aw36ABoFz7yvYteWKllMS4/qVOQshRn98l?=
 =?us-ascii?Q?ilrGOxYRUhuhv9o9ZM7/zO4Jq1OZUfC+PCrCbMFB2KoNsZvKB1ft8CKTZyGG?=
 =?us-ascii?Q?EOsYKPydmdq+1XIgywRlIMmw98DX5LtSeTfzmaC1x2HsiL20sGoE+cmXXmxu?=
 =?us-ascii?Q?axVMzA/cqlfebCEMx//A6pZiScx72oOTci932R8pHR+u1wiyJF8ft1fJvmjH?=
 =?us-ascii?Q?M5VkB3dbXZKyhIUSbKjRg43zcEOO879OmGttRiVURR48T8KrJ77bXmih7XqS?=
 =?us-ascii?Q?Xl5nWUG6MSk3+mQ+7uaHPmRN72LUkP+nxXmUdXw1YOw2SlCwl6uEmZbLmuF3?=
 =?us-ascii?Q?qTLW23E1uPQoLQUCPgFJIe87+KoVN1001vGxaUu5Jyev2NofQmRviKed/+1K?=
 =?us-ascii?Q?wNlS3FGsKpS9Kh9+eyY9p1eXcWG6TWsx0viuB0UVPqxwrAwQ4kmD6pLMecNi?=
 =?us-ascii?Q?ujXd8PsM/mczXyguL8VU2KZpTlDk3v6TUJSuDY9QayRdLjd/4kXcqNigGeR+?=
 =?us-ascii?Q?6H2c5hPoqKOdcnqTvU9YBm9xkc70Guu5tEgTWNdwWAWfNXEGwbY+qfE/dxHi?=
 =?us-ascii?Q?ft/Z+feqckb06mwVwzcQMNRLV+THWYzZuYcjdB+yMZmefMBHQNcHn6MxOPKc?=
 =?us-ascii?Q?3KP7ujYhi/jmIpdhe1uVI8aW13EhemKEEUoIfTPyoyP1VPMGiofzGOEvl+zI?=
 =?us-ascii?Q?V12B/kpVNvvsiFVMtSe/zKpzDmhfRMYyRht3GhiK7G/du7PHBwz21QJnFQiM?=
 =?us-ascii?Q?5SvtW+EG4P4JAFH0DCy2DCkY5xK87mwX2Qs8Bv3znfyYKjD4t/cQkE9m4ZCz?=
 =?us-ascii?Q?CDGQDCMsZinPEbHubjJ+lM6rbnI+hmtAZQy4zqwXqc0tkZNm98nBcrCZzSrX?=
 =?us-ascii?Q?AeZ2C7DjBc4XdJq0a2QzxuPlyIr4etaF6U0LI9g1+B93p6Z2H12aLEOshlfH?=
 =?us-ascii?Q?69oI6ypfGrkl3TbW5CyMZtgxj9SnIzvparh6OYvruWbkWgCULyz+anNs6O8Z?=
 =?us-ascii?Q?5l7AXyp9C3SqNYBJTWNjsASPDrZy3bFNC1MgxI3luMtPzVwVDH+2EI9FRP11?=
 =?us-ascii?Q?8qX+8lfpPje2d2W4pRVRn9fhtOJy9Yqon0oq0yp5zArSe1Nvpf3ViAFGV52h?=
 =?us-ascii?Q?fgbHqYCv7aFPlUVUyqBNvVMZ10m2aLjNIWaoEGLsmEVR1sQYRY60ujniaw+2?=
 =?us-ascii?Q?Tvfc9QpInxux8scX1QpqC4wZipeAAigIc1Qm1BU4ByTGkGRG5+TrFdMiCIJc?=
 =?us-ascii?Q?ZilkiPXGtQ+H0TAluCYAXVmw3PMD0wPROwJzBPd055Aps6ricfh3o1rFh+55?=
 =?us-ascii?Q?2UIPSZ7Y/krUhG0TSLwWgLjbcd/RHH6dZrt/pwwc2jJo6T39JTiLzVW1Pvfi?=
 =?us-ascii?Q?mlmnujFpzRam8/8urdMvKRap+FnBTYMis81x3nsrwJ7ArmgM6pg+yAumi8tS?=
 =?us-ascii?Q?lqzz/EurSiFE0nvXQaNKLlLvhSd/jb4AwbSHIZxadl7HyDr+vtfx0ltk0Q0P?=
 =?us-ascii?Q?AnAgRCqgD/VXQmk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:54.1471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eace3bd-f2a6-4b0a-9a01-08dd2b597f40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Mark the HWS SQ as 'non_wire' so that 'Flow Update' flow
won't mix with network traffic.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 20fe126ffd22..c680b7f984e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -633,6 +633,7 @@ static int hws_send_ring_create_sq(struct mlx5_core_dev *mdev, u32 pdn,
 
 	MLX5_SET(sqc, sqc, state, MLX5_SQC_STATE_RST);
 	MLX5_SET(sqc, sqc, flush_in_error_en, 1);
+	MLX5_SET(sqc, sqc, non_wire, 1);
 
 	ts_format = mlx5_is_real_time_sq(mdev) ? MLX5_TIMESTAMP_FORMAT_REAL_TIME :
 						 MLX5_TIMESTAMP_FORMAT_FREE_RUNNING;
-- 
2.45.0


