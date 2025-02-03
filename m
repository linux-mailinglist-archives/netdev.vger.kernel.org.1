Return-Path: <netdev+bounces-162277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA79A265C9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A211F1886299
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF220FA9D;
	Mon,  3 Feb 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5HZ4dhx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB59210F53
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618641; cv=fail; b=sfmOMINTTbUyihogNZznacF11/6Y8ZqKCXqJBv1spEQVlJej28hHMFlRNr03/AN6S1kJCokzo4C0WAHUhuw4VLupnv8MIrJrO2KoIOk+9q9p3vrntCuoRpPbnkP85f1AfK1JzvxkjT1EhvXakKBmGKF4pFgsiknYK8uWmX1XoWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618641; c=relaxed/simple;
	bh=iw9yrFvyY35yZZlx2HECosIKYzQc7JsvouAOhCCb6nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQBZiVXhrZWqUaXaBD6+UlYJfTFFiOgDQ4Qd09fFMqqRccbGoYoX5nEcsR7aAdbZc/i62OE2KR2PvxcHDfCqxdAi+6HDA17ntyEoVstE1SAfidJqc9kdiQAIKfcdnQWC2ZSRbkKraY0yqoG2H409nQFGYOdYivSl5KFN+aP94aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5HZ4dhx; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fnz5eAPKqrsUjFjdoKGGrHYaUdts1hRyDhQMQR36EH/Fev0qP28eEaEpaW7nyXCI13vwcm+wtgnJdsBI1SVifmlCu7YKAQ06RRF7lc+ZqDtseGHBe2pXMcCuInyhe87skibK8jx9poT06neLY5L34t/ZB0rG1nwXp+AZLrtNKLD1HiKt3ctmsPiVtTwfB9ajh/6yjHsxSMsjk1ZJHLDdyRtGI9CQtyY71kzlcdjNfr6Dzo1fskZDgMYXaBn2I7WTqzEfP/UQ7ZW7xy5iBRi8F4ee6UvjpujaQXdq6ERKCEm4nvt77SbP9e+TOacdIRaM3WDOkwxJQxbVqy1Wa8E1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHPfiVuqGqoue/XkSx2yB2UAnnhUZxfnIz98oflot94=;
 b=pCUq25X6upvLYXM4K6brB15Dv1WB1P/2XGOGbBpVEpbaxuFQTdm1DGzQLMxu8epbkoedANIBysQxFNjuRh+eIIhFSr3sI94M2SkgiukXeNi9rgvFQ/fPeJGLhK3PPALzu/cAToVZelYC3S3k7ZrxGKoJoOTeiT8W6C76RgzjddtlNgABq/C8xL4M6uVxbJOhX1eRmD+JfESUdfY71/iYwr+Xz+3BFfOtdBZDWaYhQ7zA8ghihZXRKw1HAprdxznMHTxAvoYeXcrMhG59wDX9GzC03pLQbzLYmcSLxOpEkPQxF34HHKFGsFJeNgVK0o2RsMa3sTqPRhqMArhNtwNE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHPfiVuqGqoue/XkSx2yB2UAnnhUZxfnIz98oflot94=;
 b=h5HZ4dhxM/1V/KTcUGZa8yZjB9P6CCVo28RyVnFV5eaJM7TKOTBxH498hnXAg4vSe7OM79gWTo+co1ECpOrAfFbuCs7oUMCBDYqSbUtW5HknvwufHntwKSC5jTUTm6bX1Sxlx3spCeVIDD3MFpw8lzKzLwHH6ie4ScgXXZOe+fQetUW9sYCEIiA+mphiTuLfG0AuSgIDmQM+VGvQcl4K0L6VKG5IlszKdNsrqSfU/kLaHpfJqfDrDiXjclb1KEJAWZ27x7zjG1/69wmTvfMct0t4ZQxLzvlzNHOlaEym28b5BuIxJ6KdxYcqHGFC7oXlOAO2I4Klti56UL9TopfCSg==
Received: from SA9PR10CA0029.namprd10.prod.outlook.com (2603:10b6:806:a7::34)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:37:13 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::a9) by SA9PR10CA0029.outlook.office365.com
 (2603:10b6:806:a7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 21:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:37:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:37:01 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:37:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 13/15] net/mlx5: Remove stray semicolon in LAG port selection table creation
Date: Mon, 3 Feb 2025 23:35:14 +0200
Message-ID: <20250203213516.227902-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7131b2-c2b4-4bbb-6640-08dd449aec51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQW0VydO5Mwf/KoeUMKMf0UTED1CWWJmZPM45UKGB1f0RWnMv55ZUCs4DOeA?=
 =?us-ascii?Q?+ossc8JrCSsIELj1XaaVIlWeUlwRffKZ9/w7SyyZ8SAreUqCI2q6+iatfpBa?=
 =?us-ascii?Q?NK9jbc7QX6zJvFd7Uv19PLw3TCvx13B9NCI28S8Vdk6d0WEwH5pchTyaU0Ja?=
 =?us-ascii?Q?UgmWCyXetUFIZbCDhhKi3Vn31wk1DqFfX//GZNBUb7nEsTXBLKWfc6ocKzq4?=
 =?us-ascii?Q?wCiArI5X4gfMJt7fU8AJlBf9jMwsNozNAMGO9ac+QS7hEkrqjc5MkXN8c567?=
 =?us-ascii?Q?Y1Gd0V8+fYAc4uRM07NpyTlwqFlLkBtSFBHtWxbJaCN4hybEeZrHV8evnhwF?=
 =?us-ascii?Q?ZHw91NnBRbVr6jfhNlSS5F8giJWMDdm5I/lOvohdVzNpMx1NmTQFEn8Wj5SP?=
 =?us-ascii?Q?JEMzs+QC1qbDwplZ/ULeO0KAaIylrnXKED/7myYkWUFJ1bgDvyNZbTtf/na3?=
 =?us-ascii?Q?/W68gv0FYdgZMPcDI1wbd/z0gV9pb31x0cXxoIgR8GDHwY71lLMdrRzDEVhu?=
 =?us-ascii?Q?WwU86byt7LgE60q9xLHh89E3qPx7eceUy6s4r/3cb3yH4N8vVTeJ0Z+YhEzi?=
 =?us-ascii?Q?SLGe3VK4ownYjTjfBg2bEf3HI03PfLeN6/T7wh4k74jb1c6tw4piFMgbEKmN?=
 =?us-ascii?Q?+MqadxpMNCIeuGz+NiZBwc3wNcCuvwbaF2ZWtWASyUzXIgV4UlF/ZefDjxyi?=
 =?us-ascii?Q?4UFEBh1XpFPF2/QONWNRSZp+NgURZSE59L/t/y2WReTh1tiV64/ipnvYRs28?=
 =?us-ascii?Q?fLQB1fP9IzuvEgHXBAOE7N191Q4AZHDohDJBbu8Xc43RyFURIT8Ha2FBCjoL?=
 =?us-ascii?Q?ogDBbyGOjDF4zkiozd9DrIPO25dgZHcq8VzD5tbMLjfRUZqhjCkZuK8qoIwm?=
 =?us-ascii?Q?YYHwbDk7m3IC7WFNPj/oUiDHB2dCJ1cKrNOuFEkwQ96b9UIESTBia8XafDT1?=
 =?us-ascii?Q?feV4UXYZDhFl6m/iRwOyoYHmw/J4tJ+R9Vsq8nGJrKD3O0IrO90c+eCWnZ+X?=
 =?us-ascii?Q?kQ0gOFjs8/4GWP1tnm3Kk/x1zN2JPi1qIZsO1gdbjBlX//TmKrYByDiXx4KA?=
 =?us-ascii?Q?j7RgSTcFR+embxJG67RyJadp14CbrUw0HXCbPv7ODaYzomAbTAjnuYsg9EwI?=
 =?us-ascii?Q?XxwoAdRZHAIDQyJto4pvuL+6t1snLdrDdcdn8dXBoTpnxuvOVP+jhjdE2Wky?=
 =?us-ascii?Q?1tWfyNwOaExuEA41tCLrh+M3ECm47T4mHNQorKmFFMxtjNQjO3Qm2667Rybr?=
 =?us-ascii?Q?q8QqQxTVbu3Q+EGgowWwc08NXT3ymNMhI3QS0VcR/jHGjvhIBxW9zH9QsLmk?=
 =?us-ascii?Q?p1fqJnZe8zBwlv5YNpqUQMa3+V2nrVzuCx6HvMdiihhmvSJGfbSGu6kzO6ZO?=
 =?us-ascii?Q?o9msGH+q+b53zKEV0Kv4hxfvUp2V5I6/F6v28mk6A37hEwCeoBcJCp0H7e98?=
 =?us-ascii?Q?ysg8pocKMv9XpJGLKj0ICKaXeKhadZAzHdAeVITKDiZ6PaUZsro5GRwgUrXS?=
 =?us-ascii?Q?mAr9gdu7XutS4bg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:37:13.5482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7131b2-c2b4-4bbb-6640-08dd449aec51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

From: Gal Pressman <gal@nvidia.com>

Remove the stray semicolon in the mlx5_ldev_for_each_reverse() loop.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index bde79cac33a9..d832a12ffec0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -97,7 +97,7 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 						mlx5_del_flow_rules(lag_definer->rules[idx]);
 					}
 					j = ldev->buckets;
-				};
+				}
 				goto destroy_fg;
 			}
 		}
-- 
2.45.0


