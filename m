Return-Path: <netdev+bounces-116709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C868994B674
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B929B20D03
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A41185E68;
	Thu,  8 Aug 2024 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cfGyHFF/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76D623
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096906; cv=fail; b=t+cmD79AyNwmYbhc/oHGXOyVSePoUy8TQifFmvqSSW8fJXIEpKtG4oECDVp/gXXfqXNRe0wojqfk9UFf3a0WE1FJaMddv8GA0POieXhhRgAa+pWqz775NU+Ht8lut2BO37RMCLjIdqtK6F1YJs5OiR66449gahgLg1HLZyWBCKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096906; c=relaxed/simple;
	bh=Ksaiq2I/Qk1yHT/oe3nKHxpGwe4AyJdursHlzG37J5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsjOj70d6WsAruMy/5sqBqPl3QoCId6DByyh1KriTi9BpF1dq7Bi+vXJfDnk0ovAL6RqYTSUQCKwlE6ls218W2NXUzLf8bq0tBM1mo7r1bnWP953DrV73+fo8zumvcAysdmnAwRRnvipYY5Y06EZSPRxfR572cWMSN4ZWNQ7KCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cfGyHFF/; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbOfpm93g/gfzjHApKKTU1OBPN1C+sc+jkVEu37p1BA0bISlGVhIw3OPEHOpEzqCb54GYFUY0gyloXsjfJr4ew4zqlekuNPin5g3nlDudZ+rIQtgr3C9qmgJmN2ccHv/JKtS6wAn2+DF9R0WLlk1KGLWv8JwdB2UUrG8a/ihb3YkLmi0ceDKPzFYpqP+byckHsQ02IY6sJU//Fyz1wCnioyIMQ+wW2ODWKJ3HZ5YMWhK7wl3aPFt5PGPOklaDVVyy4kUNtEyx3+WFCJnTj8QR3vyJSWJkWve6WEhjPrtj5iee+ifl7feO6fPEQZqvhGfDiBzJXsTSJBIK2tZHsp8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXMqBdgHpkVBORpsGMbYF+7zbeWeJ7oKX3OpLy/MqX0=;
 b=kHRSD3iZR25y0ovx5kf5XkXULHuhiljTRsRh38ES0+//CttsShtcEY9BpDKNTrHejE3L+Owjub/3BksdRxHAf4aanUsNazl5pYZpgKG7L3ItvdNexNz3pFjgwHQe7JGAAZ7h65EC/e7t52BJzhOO4Z8RNl45hQ03yriWL1SkzTDIDAcJhKEoNGIO9kGewnShORiK+qhZciH2DT9EJ06lCr/WeDaAVDJMCzKio7ESMBuyKjIQDkaknvWa9Fs2+eRFTPacR7AGMFxkvUodcYSutDJAjvhwYfT2EZlyVg3/cphvDKV2a3hNCXzE3dxOMVSxpqhHmQ8ALJvQDf77cQZP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXMqBdgHpkVBORpsGMbYF+7zbeWeJ7oKX3OpLy/MqX0=;
 b=cfGyHFF/5V5iTNj0xuJRp92N7bTb34aPbM9P7NjSRAOMrdxBEV0A4Ysjnkj6C1FVW5yXID5ZcODG++DboBIt9S7N0z39M73xRXPeGSQnQ/Jhl+u09sToN1L8CqqQJSc26R1IMyltBxcxPeB4L4WxkTroE6orMJTe9IjmxNijMYjODEYAKHgJFeYkpybOQYZWh0wLX/fqo9WB0aRJk5htAUk/CRrnPlO3vWRFc9kVQJcminuMHDKLYLMrnbhbr5kUv3nH4kCiEdAJAYy7mAWBk4NJeBHvYOzxdJqfLud53e6kf+En63mR2A5i58ymm80cBI9sl/3KqxUkHGDEu+iaXQ==
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 06:01:41 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::1c) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 08/11] net/mlx5e: Use extack in set coalesce callback
Date: Thu, 8 Aug 2024 08:59:24 +0300
Message-ID: <20240808055927.2059700-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bae1c7b-8cc8-45e8-1d73-08dcb76f92b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9mkkvpzsVz9RHdJI8daqA1LM3R1q4Xa+eZM1ajcoubZcVFvm4clS9e/kFxM?=
 =?us-ascii?Q?PJE8L/6HTHnRfYDG+BwMXy3pWBILNL46CoXlzIWdQBWBNEAC7gEb0+mn6v1X?=
 =?us-ascii?Q?XTK0vzVZLglLXc0KM0NS6mrOi+O5rQSJ0Fsp75iU4xk3rB/0S7Zv2F3BZr03?=
 =?us-ascii?Q?eYdbp+KlQxctfwfcwKRWlc70kQBU6As9zWn7B83+cYAoGGH/fLYw+MXueJa1?=
 =?us-ascii?Q?+xJmDVpuoMmskj4bUTgjeYgPRLVPTTnaGhK0IjS8GWia2PxljXXjrQtiVZFL?=
 =?us-ascii?Q?pZCLkfaJ5EkpqgSx9X/x7H+/BsY4CxREKgehGWSvkUxPKo62u/3KAXBA6vIg?=
 =?us-ascii?Q?aXNtsP1xoaUFHKw6e6Xe3b80j2WdigN8INqTV8dK2e4B6u1BHmumdxwWNE11?=
 =?us-ascii?Q?P9Dz2WFqlT7ggM6DPHT+H85hrxoT0tYXRxeC4z2BhRqJrXkDPgad0jHPOm3L?=
 =?us-ascii?Q?bg795JmEK1g57dO+MWyVgQlPfuQ7PSDM4UwfDT4o2UzTO37LrCk7XXlQzgeW?=
 =?us-ascii?Q?+OHkXeB4zYovDSRgquWNsRaXuStnR0jTwMryQfP6Sr27vexQ6TIrTjpC3r1R?=
 =?us-ascii?Q?559Z++nW9CjBHqCHYBrK0eFbUZFb7Gq2mI3fH6kC1cuIXul8Zaixpp/qr8Jv?=
 =?us-ascii?Q?5QFCMSzWJXjlKS2L3bG/JYE3kCz+mLdS70bM3r6kEJEnjmvhCBqaKCIavqYU?=
 =?us-ascii?Q?83aKTl0DOoMCpnKwoiO0/Hg3pZHoJjLNFREQInDG8UIzXZqgvuO9KrRpNaxc?=
 =?us-ascii?Q?9rQQ3u7F7XoUWtWkh6sx6cZ1TpWnmRQgbC/fhESDrNUDZucQ7VX7n18TBt/t?=
 =?us-ascii?Q?MEaptdQSBHjnMjsbsiPXROi21pLNSMGUIffxVEYUEt2kfB6k51YCZy95eBEM?=
 =?us-ascii?Q?Ait/mULY57H/6PVOkoifvrZpJMt+HMuGUTv2xelXoYwlauqU+9GuVSOvbZ/V?=
 =?us-ascii?Q?bFQifJJyR5fP6MPcK4FfY1oTRr3fCP8lNQTsXgphfAZjvAReuJRwtB5n0RR2?=
 =?us-ascii?Q?Ih+0Q1JH7GdMBUZnX/xwNVxhXf6I6FZGiUx71MMWu3123rxV+SNLSHqWw/om?=
 =?us-ascii?Q?lLCRXmrg4GcNYOPY+I+cJpMrhHCH9H0xLi6oCSrGeY067wktv/up7L5lIVo0?=
 =?us-ascii?Q?XI4IdskSQmyqd9ZgXM/XpETv9GGOsbP5twHBheyL5d3O8QK7dud1VQ/ZgfCf?=
 =?us-ascii?Q?hUYYkxGIThjzgBmaP/GIjBtWThOrses4r8Etzw+WWIcpzPh98YKAT8lrY+f0?=
 =?us-ascii?Q?fyiMZlbTt7vflcRLU6wNNEwKioMmS8zIsu0u8kFPEpIpgeIdTOn2WWS6t4oT?=
 =?us-ascii?Q?HEoJn248oIHF+mGS9fz7IdigyoiKmbvONTsRs6XEASat4QhGrnQKac5TjqW+?=
 =?us-ascii?Q?1VO+jdBHPF/kVNdLf96CF41+i+B4v4+mLWaL+Ble16Mj6w2vIEDfZ/I42BjY?=
 =?us-ascii?Q?WBMTF5XhcHkVa0/Gz/WYS0H+ByIbn1lf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:40.9320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bae1c7b-8cc8-45e8-1d73-08dcb76f92b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350

From: Gal Pressman <gal@nvidia.com>

In case of errors in set coalesce, reflect it through extack instead of
a dmesg print.
While at it, make the messages more human friendly.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 9760215926db..c14a5542ae9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -699,26 +699,34 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 	int err = 0;
 
 	if (!MLX5_CAP_GEN(mdev, cq_moderation) ||
-	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify))
+	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify)) {
+		NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
 		return -EOPNOTSUPP;
+	}
 
 	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
 	    coal->rx_coalesce_usecs > MLX5E_MAX_COAL_TIME) {
-		netdev_info(priv->netdev, "%s: maximum coalesce time supported is %lu usecs\n",
-			    __func__, MLX5E_MAX_COAL_TIME);
+		NL_SET_ERR_MSG_FMT_MOD(
+			extack,
+			"Max coalesce time %lu usecs, tx-usecs (%u) rx-usecs (%u)",
+			MLX5E_MAX_COAL_TIME, coal->tx_coalesce_usecs,
+			coal->rx_coalesce_usecs);
 		return -ERANGE;
 	}
 
 	if (coal->tx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES ||
 	    coal->rx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES) {
-		netdev_info(priv->netdev, "%s: maximum coalesced frames supported is %lu\n",
-			    __func__, MLX5E_MAX_COAL_FRAMES);
+		NL_SET_ERR_MSG_FMT_MOD(
+			extack,
+			"Max coalesce frames %lu, tx-frames (%u) rx-frames (%u)",
+			MLX5E_MAX_COAL_FRAMES, coal->tx_max_coalesced_frames,
+			coal->rx_max_coalesced_frames);
 		return -ERANGE;
 	}
 
 	if ((kernel_coal->use_cqe_mode_rx || kernel_coal->use_cqe_mode_tx) &&
 	    !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe)) {
-		NL_SET_ERR_MSG_MOD(extack, "cqe_mode_rx/tx is not supported on this device");
+		NL_SET_ERR_MSG_MOD(extack, "cqe-mode-rx/tx is not supported on this device");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.44.0


