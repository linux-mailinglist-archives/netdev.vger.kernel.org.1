Return-Path: <netdev+bounces-118733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF8952954
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89CC1C222D1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2191779B1;
	Thu, 15 Aug 2024 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyH2/gK2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9D53365
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703101; cv=fail; b=h58RtbTUH6NcFMMIZTwRkjdm1czroGvOPY9/X1r6H4WUjRmcyb8sYgrYs95SZElWSXtteOM5yLaDSrePNHO35Vwfo3tJnXwq3UUu27m8xzgtaEUoRuBW1gGVikl0RKpEeGb6hinWQLsuo17Ctd/TGknTD/Ew0zYIfcr4UeEMGoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703101; c=relaxed/simple;
	bh=ScPS69T5mE3qA7ccoxxSRdBEYrALUEz6pFCzcPcIw5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7xM18DVOUPDdcQk8U7c3Enm5A9UlDtwpFU17bh8YJFa6kl9NkNAtPpZIxqgrT7y2F9E7wBFxg7LQBJBAW9nyL8LLBuZJitstwrNrCyZXV53Zp6fJRrGSYIktjphi2Vgjr8w4oaVN/++AIR6miG7Gx1EXAnN0sDUZJXIiNxb8wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyH2/gK2; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkbRABk7/MDNauiNf8DpA7Xy6cjZhQBqQVR7giJFabtFhJ9xo8OmiZyhylFwUTwSyIpXmQciEf80AM/V+18+WTZmNEvqPZmDbkok3UFOZkBWJKeIdlp1q6pgVAFR+JmPCy1RkPxtohe4FFDGKoBiOsNcbz3Vd/SSQIC89ZMXQICnGx3kX/dCYZGvo8bxbWicYAlumI+RlkugeXsXpzi+8ba0NMvy14GGfp7308ZCHjH4DAgOy0hCqMx9enroByF18lwHY/UGshkkDOSDHLx2Pn70Ng3ep5xcza+j3mTNKxJt0ps8s505pWccT6R5P5gQ7w3gT83FzujN3TIbVvtlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOeBQDgwPBaVGM19+Amf34frifWgoE6ExOx5JP36VIs=;
 b=KMopEqpmakewJR4trwqeM6ERYnfPdK4kaJzRSQoYDhhSWJOX5+qcOrFNsI375sXsqS2Hxjaca2Sg3GhpOYoIlicr6z7oUjpqfKJezPoxqNbbWaXGlKp8tcmJ8G3hDOqxexaHtwwzFAIOHssTdlfFECzpt2ubI9/7FPVWBU3rsQOS8sMD6suz+WDrHgzbq45w5a+B/Kjcp8niHqU1Sv50pOoDUkXFIWsSIhe6BbCL9pHv7C3BJZ2rMfQylUyFF1izS5/dDgw1FG8QCZqPLgGMpHy/wanZHAN6YyES0qW5dTvpE6ga/fOBYKamklrkaWH3BLYB3uc13ha8NvpRA1EYWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOeBQDgwPBaVGM19+Amf34frifWgoE6ExOx5JP36VIs=;
 b=tyH2/gK2+xljs5fCCwYR3tdDQDhGfsRdnaIZVvM9JHnNYyyBGyfTx3yeZ4rCnIHSBwO9F/cWOSI5Y7GCb99mim0igGkyHV2moF0Y0YGSbmmsB7bKSTAMW7Gwd7Y1RIgZW0qv31vxbrwYMX5JB9Z3zFLEALfbhs6zMzyQPqXxGqMb7rfAcOXXlQkx8JLIkGadU3ZAKlwaUncgC2YCJABuOCJH/cq9OiwmMvtcocmZnFzuUl98IvdZdEw3zQmaEN9J8G6b4BOOOHthr0bNe6b33/aSrXvvdpHtVY9vq9JA5pDpgxt4BuVN0QJ+7G5Y/gLmOFogWoYS3F8wZ5Z4mwRR6w==
Received: from BL0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:91::31)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 06:24:53 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::ca) by BL0PR05CA0021.outlook.office365.com
 (2603:10b6:208:91::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Thu, 15 Aug 2024 06:24:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/10] net/mlx5: Allow users to configure affinity for SFs
Date: Thu, 15 Aug 2024 08:46:53 +0300
Message-ID: <20240815054656.2210494-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815054656.2210494-1-tariqt@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: d71500a2-813b-47b3-b672-08dcbcf2f90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hUBNvyh3WVsUwAmVhEYn9KhJy2OlgtRbZq/gfUqZoV9DCSC55fot+Q6VoFlb?=
 =?us-ascii?Q?v2dETWU2omvXaksdwR0ux8mcjw8e3w/DrijIDen9JUrm7dleJgX3uuzhHStf?=
 =?us-ascii?Q?4IYDxbwR+bJag0bbpF4kQwfpN6YzvBwPU31L5QvfG9jb+JORyBDJ1lTlyKRZ?=
 =?us-ascii?Q?bGBxaJFVGlMnQLgVLeRagaACMWPSNgn+7fY5F4ZyhfnHhI9byobVn45T9nnQ?=
 =?us-ascii?Q?gMasb+QdlrQC3945Uda09VDCSnp1LMCbbDXYFoCcHnJEd7Ow+j8l7gGdWHhJ?=
 =?us-ascii?Q?y83F+UdA2DqFa+E3kpJHvQk+oEsVSc6sSrELIoMVbcvGxp3SqVFxwNsNDuHV?=
 =?us-ascii?Q?KDT/sj2m16JZkfgOojHHEvruQzPvQawMw5D6/rkFrJ5PSPplER2/lkM/rIVx?=
 =?us-ascii?Q?iojSduhpbFEH3GQ0nFZeV8sJ4TYSHlvob1eB2inekEv/02FvRKYArbQ1Vetz?=
 =?us-ascii?Q?H9hDN009k3NxwXTd8Ob86bFgqwyveIR9pUVhatu2Ec4mN6H1PGGfKEU/WYQT?=
 =?us-ascii?Q?i2WRnXBIUBfmQeZACf2MOraHqpVR7ng6R0EUCHbG3TYv2MQhF3wMVhBAH7Us?=
 =?us-ascii?Q?LDV4NtEjpvIVhJ/Jd1ydVUkhRAwZJoguoXeqOsN8Qscp8vts7T5/dy1f3E+/?=
 =?us-ascii?Q?SefBjHjMTx4P8O6umidlsVyYR9fyOdoWzJRyT2tRGr+zLbZp+mbh1ZdLEqKH?=
 =?us-ascii?Q?MVHyuxHF4tiS+PoY1qG2f17ZhcRi6VQVvmJ5Jcj0rERvyOkQhrhXi2iTs9/f?=
 =?us-ascii?Q?HQm0Hlk5tpo38T2A5ZnOcDcS1tBvMVPIHuL6QvhSCtALc8hdQV7PUSV6BMMh?=
 =?us-ascii?Q?/2nwoA2AR/n4PdYgcT16bp/p+xdKNqK05qZF/XuZSs2EMaiXE/oi8L7/eaGe?=
 =?us-ascii?Q?4U3nKuopXeVn2dp75PejR4nFIwPKIEE5TkJfpfLMyezfiIvcfaw6CnA290OE?=
 =?us-ascii?Q?SwGPLQO6WBGREJ1wDeyVpjWChrNRAWcDgglqcP/HhZ1qDSSzQkEg5bhGZU7Y?=
 =?us-ascii?Q?5oGxiFxfa2BuPY7/td+d15OdoMO/1fC+s3jLQKzF+mthc0Sua0sOkeIed/23?=
 =?us-ascii?Q?eixwyXCEJPA2BhkNqay2L5LlyYfNbgmTyDFvw0aosdbdD00jO9SJz74k1imj?=
 =?us-ascii?Q?91nCDeLObHSBy9qXCBmt7SP6eyX5L6g8DWpmshX4gIsqvO20bI0FbGi68JqI?=
 =?us-ascii?Q?XAFLSLKLsH3pzkCyTPbM+GJXWST8LkV4yalBMAJo4Nq4/RWNLA5I5rdZZhJp?=
 =?us-ascii?Q?NB/licGfo0uIZAG4OTyzK0sJXJjjmDDTuvD1387bIPVqO7K4IiQ/W8zHBoFC?=
 =?us-ascii?Q?eS+WBCPCnBaIG66E9+tcB6orpU0c7aV4+q74O2iErdiEn+ufbtJTaXPachlw?=
 =?us-ascii?Q?B/adx/wEyzI4dru8g6GL7TDC3c1be/rRd8R9GG/RlQnwPIFwz4m4OkT4Z86d?=
 =?us-ascii?Q?/ajSEmtY3T5mKCYoIK0BGt/7ifYeYpfZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:52.2928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71500a2-813b-47b3-b672-08dcbcf2f90e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

From: Shay Drory <shayd@nvidia.com>

SFs didn't allow to configure IRQ affinity for its vectors. Allow users
to configure the affinity of the SFs irqs.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index cb7e7e4104af..66bc5a32ea3d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -915,7 +915,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 	if (!mlx5_irq_pool_is_sf_pool(pool))
 		return comp_irq_request_pci(dev, vecidx);
 
-	af_desc.is_managed = 1;
+	af_desc.is_managed = false;
 	cpumask_copy(&af_desc.mask, cpu_online_mask);
 	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
 	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
-- 
2.44.0


