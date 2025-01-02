Return-Path: <netdev+bounces-154813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EBA9FFD9A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FDB7A0603
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6F1A83F4;
	Thu,  2 Jan 2025 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqjxxBnO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F018801A
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841746; cv=fail; b=XaGcnpyAEp7zxw8rPKS/kmh3DsyjmKcXCWGQRlUDrYTDN2pymXtXkWAyuJTxZxEfaQrRVvKz3tsTbcq7wYmk66J34E1bqQVHXN3NDFsFaWXBFNyAR5I0clEzKlNssCJScSFinn00Xcxf/g6D5HTJhQhthQa7/aqj1XVnKXX54uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841746; c=relaxed/simple;
	bh=pigy0yutngVrEujhSCnPM+PYijoeG3diEict5qR8Vqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeCKaEezCQmnu5gkFM4aPa2ScYdjC5LAoRE3ae0MsWqqkVJPIkJ6G4PYajSpk8/SJgbfW1i9i5feEJseoowwFVMw/lo7f8wtJL1NrOQDgSV6koLTtrKY/C51MhP89tdP6AafRknVYWABIIyv1UTYqY9fV0isZbZsgK3ATGle8r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqjxxBnO; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3i11+Xfjq9yLxj1j9GGYuuLhvGZwhUzmWB1WoT66W6jGFon+EXfzH4jRveqwzGc2ki7GqdJzw70JEr91jgGozeeYHowwBA/0fm39UPsb5rMfpeYlz0Gq3/il6WeRGQ99D1JXOzgrFIAFJ8iz7pdfmGzzOaOd51yNAPakxYcoypfKW+MgeAvE5ZW2fkMJnXHFM9yBCNFUQkLmgYdgohHEcpoWyigUAjMu5fr77GbkUvmMViJvyU7D0WCSt8dPo9+uFYmwOMrJORE6e1a/wPWXnXX9QBBfJqEZsKh88p2YOkc3AMOaYdfEGfYRI5RgChno6PJGDyInl85IZAQh33AnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecy3aVhXhr33ZQc6eBjQDmmjoLX5YtfoXg3CO6fQBfg=;
 b=C33H/mwsg6RI1LUxzTrnpit5+Y7i+h4bb0fNzfkFx0yz4FmH0UC7tQKGj9IPCS8WJuk/vrkkOC+Btf5fx/bRqkfKsCv5cYWVpaNPTuHKkKVP/IbfV21xxEtbzqSvGtRBWD5RVCJzllpGdye5hgS8rwHUX0Gz4YPeMuZtTLfReXyheWSJdP30HSuNSrBSllkUe0NYNTsqCddT1jSJ9cCvMdGJACHmt+p8GziN9HxxGbMqiL2ZPc62jtAfdroIMwezEdlXB4TfWGZ0oGFUFEJLN72cZUcK0MSEc2X0+TObc4Vt/3lTXtlaqDm6DzyJGTpKRNOTM1vsyj8P+VM1pEB0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ecy3aVhXhr33ZQc6eBjQDmmjoLX5YtfoXg3CO6fQBfg=;
 b=uqjxxBnOT1g5lhHCmGMLov56zqG1+BLLqQdj2Xwf/w7IpbStJ7gpilEI1fW+CwdwAnCpSjuerrkwOwDmsD3LDnXo8tIWGMQUpPgvTOCQ+v2ppdkBUASY2f9i/InJmn0vfOVMENQD+ZcfSa2cQLnoibls76EIgm3/FWhLW6llitCgw33Box1jE9I505bKQpTTHqbenieyW0ZRmHLgB11+3WvlyxIIJo0PmNhPl4pOptog0uCjVCeJvOMcKrqThnKJLCPdNEgJznoVf87bIxjmol+jLkIXcOUzFa+ZgsvrYr0SV0SvM5eC1Omxm6+kbF/N0p2K8vJiaLdFZiJY76GVDw==
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:15:33 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::4c) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Thu,
 2 Jan 2025 18:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:18 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:14 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/15] net/mlx5: HWS, add error message on failure to move rules
Date: Thu, 2 Jan 2025 20:14:04 +0200
Message-ID: <20250102181415.1477316-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bf11b4-f86e-4706-f516-08dd2b597260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0r6vgcUE/d/PS5GZWY3Xf5jXg2iLXe2sRGUSaEDaV+GH/32zXsitwgKhVFh6?=
 =?us-ascii?Q?LB9dBUjQc4qrGRyfi58YuL/o2Av2t3JEPY/2sTNSdc5GPqOT7rRsgn+jh0uW?=
 =?us-ascii?Q?8ui1xkjx+aaOx7uOF5PDJ3Pg7ivbItVA8k+qibaWTyO5yiLG60IvtClm5HL3?=
 =?us-ascii?Q?GmoCvZSMz+cuNJ3lISPRHdRaqzVxoqfll0kVNm8TUj5WD1ZfgbybdBjD5VNs?=
 =?us-ascii?Q?Bmae7IxH0SpCMbri0yAwQmLI4PupZaZO0FlrrqNHkgNmCILyvyKkZzsTJ8j+?=
 =?us-ascii?Q?6rLBfhf6ng2IR6UmGO95LY+oWkJRMLd2JGYO3yxh+6YPz3Mz73e8ExX/OT6C?=
 =?us-ascii?Q?pZmYlEsbPCte1Kxvmsiy17VXQnJRTdwxhjZCkY1pGXVTvkQLUQQzw1jI9hVq?=
 =?us-ascii?Q?s0zzw39tC6BMhupXA0JDswH0Afab03gR/8tEx3MaOIt1PXFUpJypFwj1El+H?=
 =?us-ascii?Q?2tlQxHiN8wLS5PR3WMVQ+uQ4JEIJ4uLi5l585lPg8CUqsNbRKdHhPgyOpav3?=
 =?us-ascii?Q?ChwA6zu2ngS2w6ZdACH7Kl6a4XwEZMzVQ/3X5Ros7I9L44veI8YErN6TfrqK?=
 =?us-ascii?Q?w7jVgARkk4QZqwBEUocsmVTMUEO9PXAaZkKecEZ9P/Rm0oR2CdkMmgVaNnjy?=
 =?us-ascii?Q?WBR+4kfRS0FzHBlUv1mDJ2GsBFfjk1pQ8RW3Se1llWS6bTslErPWr63DyTSI?=
 =?us-ascii?Q?zsYeom56soxNuyXiJI8YLiD3tl2k4L/sc4qnWbs4kimlsx3nJUbyKxCTrB2t?=
 =?us-ascii?Q?Yi54y2BbSeCsxpKv68iwDT4cV+eJgVCPetY0kAJXB1J/Z1Ipff5fgQERukmE?=
 =?us-ascii?Q?QsNikhk/wUR1Ho0jY28z4Dzv71ZSW+Ixl9Hm7G+VOMtAdYBTOI41WPtwX6bO?=
 =?us-ascii?Q?b9k0C1sizFxoPqdn/wJLaH7wFcjvPz6OyDix6dxt4IecOD2nR/1JheX5HRjY?=
 =?us-ascii?Q?OVHJS2v7j4bQbwQ4lxBfEmWG0JDUxOWHnHVZGy/olXDDYmLGfiapYbqyh9Xe?=
 =?us-ascii?Q?Amiw9vhuNnxxIAEM4waSTFD2zfjLd7jNW35cGHdF48Ht1WEs9D8h4xquFYhq?=
 =?us-ascii?Q?4LJhEiyxPbubqhs6eioxzGsuM3DfVtlqPpGvwi/1ZdmnWrzelCRivwV/cvyU?=
 =?us-ascii?Q?4k7V1vnuhMbVpKz2Qx4bLkxLT9Is09Qz/E4aNjEjZfm+REC2TMk7DWA/K4t+?=
 =?us-ascii?Q?qszI3W2HxrtU+Tuw5s+H2RcP7w0L6TH2Go5draRdmn03969htc3ayrxZ604N?=
 =?us-ascii?Q?FBbMaAsAlz2aBtOwMTvl5pwbyMi7QVPpmxLLearK0TuSqomtXi/d6IFU5ZZ1?=
 =?us-ascii?Q?S19WNmC2XzL9JsRPnfy6BEuv1+/ibr9EJfyZHp6LSBjByTKkTrIzPtSSRaTW?=
 =?us-ascii?Q?pkgJi4y1/owdzKPopnRkN/5h7gYn9ouIlApeyDZ5wBedghjQGXfdp+EU5I7i?=
 =?us-ascii?Q?p450HlaMOfPIgrUcNOEw6rF07+PqDuKSnc7HY1mZvnD8lXchlQBdH5gIuK/0?=
 =?us-ascii?Q?7AP+1nW7FDLmOoc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:32.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bf11b4-f86e-4706-f516-08dd2b597260
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Add error message for failure to move rules from
old matcher to new one during rehash.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index baacf662c0ab..af8ab8750c70 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -615,8 +615,12 @@ static int hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_match
 
 				ret = hws_bwc_queue_poll(ctx, rule_attr.queue_id,
 							 &pending_rules[i], false);
-				if (unlikely(ret))
+				if (unlikely(ret)) {
+					mlx5hws_err(ctx,
+						    "Moving BWC rule failed during rehash (%d)\n",
+						    ret);
 					goto free_bwc_rules;
+				}
 			}
 		}
 	} while (!all_done);
@@ -629,8 +633,11 @@ static int hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_match
 			mlx5hws_send_engine_flush_queue(&ctx->send_queue[queue_id]);
 			ret = hws_bwc_queue_poll(ctx, queue_id,
 						 &pending_rules[i], true);
-			if (unlikely(ret))
+			if (unlikely(ret)) {
+				mlx5hws_err(ctx,
+					    "Moving BWC rule failed during rehash (%d)\n", ret);
 				goto free_bwc_rules;
+			}
 		}
 	}
 
-- 
2.45.0


