Return-Path: <netdev+bounces-216279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B251CB32E3E
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0ED1B6424D
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AF8263F38;
	Sun, 24 Aug 2025 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqD8wN5+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E90261B91;
	Sun, 24 Aug 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024835; cv=fail; b=H6zfJqXuLgAxEIIBdJsBCiAuW+nZw6CZo41F0DgWExK+T9GbpF7WObuBJvWLgFYseOETclnv+mx+ZxZD7dinqRXBWjd/+1Nt3GXMcWd3KpmOVnD82XOQl4cnY9RBwr0ZvA9f1jHEWImMTks4DQJ4dup4fGbXJMorBCez+byyBxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024835; c=relaxed/simple;
	bh=/n7FJQX5ttpIq2ad0MbSwZzZsr0Rxz8+5TmLc2OaTlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nK9Ib5IDJCtW3ehPlZ73kKaZFD1n0ifo3VzqDsPRTceZByh6TnXzbKSPzQ0Sr2EH7Wov+KlVLkroQ8dRfHX8i/ewegMqy9qnvL8S0dz2dbL8fB/no0gfXRa5eYY7Q24S+xC6falNn/Sj3qHFNq3R/ldlt41OCIISIvNxYlYuX1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqD8wN5+; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9+0nM5m16z/gy2P4XbrgATtzP1dvM5zXXiQNI+mDcntyhzd2LWYOGI9lS7yfZPDChP/YYWXqdqXPEAIkAtyB4mtlgmawECtVy1vOD8wn3qBtgUyOS40jVduU4zlTzj7E1LD/LHbrpKncJ+AtoxdXUypHLve4SZBF9IuU5lYt75TqI88e8hY9sIFGdMIO2iD+PsKMiPH78yfSipxTRCRMrWPcXA0h469m47EduFJW75NfvjK5/g9sycnYWZB32p3QJXCLeeF0kZiRy6H2BANK0J6kGX3JbFXir2T/NMDHe5o5LSvSieb/u94EY4Nn2Z7xNME8dwV5B2a2Xd2yMaW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxT4xanGOcEgu3Vn+vOkaorVoIU0gaPMOCvu6Lh+DkA=;
 b=jvGo05nS2LiQTyEXOc8j54wjQkwRwEf9u56dzbOegrFPYzh5ImDrnzSo2OFF2B5TwjCvGajXbgVJypVj+dWU+N6xg7ERud/57HUIea3Wn8e13t/9K46IgO0fkBzWjpSf84xt/XZqt9Vkoc07YgMjxbNRju77oLxHDHsJ22FhKPQ5oAPC2AQcvdmvaqY3b8qvYMeFfl9lx9tkChY1YIBuGAYTbfcWdGgAQJ5GKKc89LhtYrCLeI2jw3CJ7n9wOcdjKI9K7GD8+yxOaT5MfvEsO/BeK0MsHiqX3lMsJ9uc2jCy4XuPEvtA3BSNqbjus7+6vRIFkCJJFr8Qje93sEBcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxT4xanGOcEgu3Vn+vOkaorVoIU0gaPMOCvu6Lh+DkA=;
 b=oqD8wN5+4HVHkV2DoFwoFsTcZjp43pwNnj8xU/HlpQiSKhpnaAp4AvfyQFvnfC+ymk7OpLEkDvoRcFNSks7P2u3UcZjYFwUdTHibmBGoc2bmH8NoTHI4/xOqLh8gElJgG2nl+QSgoQh4a/Bmt5av/+m5I9Ffu/x1UceekmuxO1mp/46f9VoAIYgE3aAXat9GNvTP96fwBwDhm7xJ9wLOp5XuFy9oMp18Q13C3zcUaZvCI1zJ85vqqnfi52xRDG471ejqXf4CxulmHQQPA5bdn+Q3hoM0JdiuigzVHIPRUqW6ookRYVpKEtZszag9QmZrVUlrZCuHwb+ygHYHRlqdxA==
Received: from CH0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:610:77::34)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sun, 24 Aug
 2025 08:40:30 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::5b) by CH0PR04CA0059.outlook.office365.com
 (2603:10b6:610:77::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sun,
 24 Aug 2025 08:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:05 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Hamdan Agbariya <hamdani@nvidia.com>
Subject: [PATCH net 04/11] net/mlx5: HWS, Fix pattern destruction in mlx5hws_pat_get_pattern error path
Date: Sun, 24 Aug 2025 11:39:37 +0300
Message-ID: <20250824083944.523858-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8d45fb-0edc-4fd3-e3c0-08dde2e9e20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0tTUyHspbYXQeMiJRx5Z1QTrXsarKDQr/rmzaSAr47wQvqgzvWIDdGWEy2YV?=
 =?us-ascii?Q?8JNVqB13VEyJIRE3GB3sBnjC19daGsDXrgR0l3EwLVuvuHZIUzd4bw/MOP46?=
 =?us-ascii?Q?9uzX2T4Zygr9qjgDWSWx4V8aBg1h+W3naiNtx22/2o/BHa5hUMkxol7SoQe9?=
 =?us-ascii?Q?hY+bOT92NVpw++jjDyizuRLDND67GDI1knE07Ya+R58W0hKMdsSGLp91QKbQ?=
 =?us-ascii?Q?rS7+cgchgFN9M9qHWpIeL/PaCihWAMZPydUdXqxb2L7EnOYfezv3zO1yWXcT?=
 =?us-ascii?Q?X7ShT4TdKkllVuFv+8bJ1R+G+gQ+hPByd0Iq8JYvOrBmh0c1kkbNTHueUQqk?=
 =?us-ascii?Q?9Pov9zympBsYLKeQyI2GotB0zd/XVNluzwGrqqC1xuFRo0lIAMPuVbsOGe8v?=
 =?us-ascii?Q?LR6HBYp7oUmJ9j0sPsl1EwP+nbIlXl/Kg0iFSODdtAEZjEDS5BuJfDYNS8N5?=
 =?us-ascii?Q?FWtRz9oNc6ZK8J5v7BPyjxwqr1Pn6wnHt0dIx9wDmnlnHnZeHJMHwKtZn+vN?=
 =?us-ascii?Q?c+/b/Ol9ZecebhGRMfdnqM0c0N1A9P2F8kqpUgiaqGRYh//EVB83FRLeD6Ul?=
 =?us-ascii?Q?YrzEDKZ+Q8lOojSFP5Jv8BVxReulMEcp+VluAmid+KOrdUQaThfhcwPvkMT9?=
 =?us-ascii?Q?rQUMh+gTgymd+saDOpBHytS7/yISI32ZbMOLpFD0ssmpHUV7T4LXg4CoxtG2?=
 =?us-ascii?Q?qo1rqdjAWNCwEPR6vQeuEG4MZMOH4yeurVhzAIRtav2zkFfslopn6UqNc9mw?=
 =?us-ascii?Q?3iBIrC1/eEkDtTs1hQeyAKWmj7XzMtnUozvEm5CfgnEtH5YGpZJhlHdKsVOu?=
 =?us-ascii?Q?q3D9NHPDzsPyG8DEtMx0LN/IAfzOFAH2GFSsRACHTrDVvtfRAxlcbrHHKcpH?=
 =?us-ascii?Q?Mx1bT72ladHbDQMJqzCW3lU6ozNYVKddbtKy26OucsEqi5TSlWrxHYCysUX9?=
 =?us-ascii?Q?loNUj9cl+MOqMrmXl/kDgjYwbpb8A/hJ1JfJCjrD7yoV6uY7Pc5I4u/h/YR4?=
 =?us-ascii?Q?5rs7XeYdgknAS7Vy4jdf99cXZxoj3ps7DfGEjjl3KgcY0/pog7jjH9E3ylKJ?=
 =?us-ascii?Q?6WoMM0dLaqu5MGptgqTOuroTv2XcCi033OOLzmCSyXA5DQI4p3AZ0To5XdHt?=
 =?us-ascii?Q?Fo2ge2c7qoTxbxXr2/a1wNDJIzXqfy1ZvR4c5c2iTftpCmg2vSohSnOW95Ar?=
 =?us-ascii?Q?PJya8yrCGr9kGuTvAbZEg+XDd50JtSzsnXJ2LK16h1HMNSjNlZL+jjyoTHca?=
 =?us-ascii?Q?1bvytRV1iHFoCKFW2uIT0yruhUx5KFN/ZM8qttVjeUZvrsgehCXTgBiFjo9i?=
 =?us-ascii?Q?Iyxl3kcTqWjqCYY9PweQBkedm5+tD8UtcocvGkaDmhTzFdhJ1T8F4Oh022M3?=
 =?us-ascii?Q?Do8ZhtGj3uCDJHBozRj/7ZAA4xO/B7HX4HKyStRCvbDtuCuPk+4Q47AURcFK?=
 =?us-ascii?Q?GevTCkM87QiI9Epn4uiduJfZ0DJGSjrdTtXvv1wn5XwDiK+uG1GHxNdCsl9k?=
 =?us-ascii?Q?DfTTSZxqUe0Vvui2b9FE4hobrMhnsm4bDoqr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:30.2522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8d45fb-0edc-4fd3-e3c0-08dde2e9e20a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

From: Lama Kayal <lkayal@nvidia.com>

In mlx5hws_pat_get_pattern(), when mlx5hws_pat_add_pattern_to_cache()
fails, the function attempts to clean up the pattern created by
mlx5hws_cmd_header_modify_pattern_create(). However, it incorrectly
uses *pattern_id which hasn't been set yet, instead of the local
ptrn_id variable that contains the actual pattern ID.

This results in attempting to destroy a pattern using uninitialized
data from the output parameter, rather than the valid pattern ID
returned by the firmware.

Use ptrn_id instead of *pattern_id in the cleanup path to properly
destroy the created pattern.

Fixes: aefc15a0fa1c ("net/mlx5: HWS, added modify header pattern and args handling")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index 622fd579f140..d56271a9e4f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -279,7 +279,7 @@ int mlx5hws_pat_get_pattern(struct mlx5hws_context *ctx,
 	return ret;
 
 clean_pattern:
-	mlx5hws_cmd_header_modify_pattern_destroy(ctx->mdev, *pattern_id);
+	mlx5hws_cmd_header_modify_pattern_destroy(ctx->mdev, ptrn_id);
 out_unlock:
 	mutex_unlock(&ctx->pattern_cache->lock);
 	return ret;
-- 
2.34.1


