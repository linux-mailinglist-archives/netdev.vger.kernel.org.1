Return-Path: <netdev+bounces-116896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9994C01F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C77287790
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B74195385;
	Thu,  8 Aug 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qn5LOyQ/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A23194C93
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128192; cv=fail; b=VxVkf5k9Bc/oc6ZxmtK0TD7+4Y9I4PG3z1tikxRpKttXLfEwcWic3la+chIo0YZR7FGQgJkymNl6zc13mV9AhJwY86ZzUcZ5hXaMlIC49DRuRoLoTn8EePu36t5ecJ7Q+iqW2vIAaMJCu3rOOdOQRC13acrRgXycV9eD7cYq1dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128192; c=relaxed/simple;
	bh=FPEHQNmQWuGMqbvZjLfs3+5kdAYGyhPc909zj0V3fDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7kV41aabbuF+YrZ49Te+JC2RbSvK3R8T6iOYh1b9oYwd4GGeIPQb1JViWJOf+qT3KwLltuIF9ia/1/VeQr69vENFEKCalHf4rE7MukOzFKgy8MKZ+2m8569/l0730oS4lRQmhS7r6nHMqUmWHpaONSCJbJGVAQXnwWT5ZbhJh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qn5LOyQ/; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHtkhVH8ChVwb7luSm6kklBc6Yc3cty7LOuM5fGGHC+UtZMYDACNMs+Gc+dfLM0Zfb4juCyGYMSQlePjxHEtDQQCZT8CNQJosgIAWV21nppcGwadilrxs1ryPwJ2in4EN89qRJry7/0OYWBwx1tKh3CxM8XgP7Cqkg3+vT2iZqs8U1dJh9/uBOCVo/M9ma9GzAkB3U3vBjolQfCUllbuHLFadcJ/RKhwTQNJPEwAHC9a6WYjZh3vP6FgP/fttXiISn5sD7HHzcptSpkl+e0Uz3AeOWvpPFx1gt6GK3mf2CKdSNG/Bp9KVHSTDux00LSjxi/NaATOTN8m5K2ryhziPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlACDccSPFh14KNSr5mDT9mJTtrtZR0g05NZEe/ZbtA=;
 b=QkH2rwLiv0HkdAer5sHEn8N7Q7LHKsGKkla5xTcZX6pz3EX+JhbZab3yOtwE9wi8aLsufsS6lv5wo2XfyyGNrxDubHm9oWyDlxMFjkW8OYpXw2TAk20qzEYSrltWl3Br9Ht95aRhKnXVhNOI564a5rJzvtBlbK58dy+cPQXS+gsMFD3Pfczo9mysy6xRER3wZszo+S6/7bbInXUIbRfOIVDiXsri1zy6z+xV7PXikBgT/eyC/z6vZ1w29FfBVgWihBTKypM6zyaR7V4csxYQLhoxCqdNXDM1/JS3lPe7+uWgl1CkM+w5s5IU1fC9NsbxEidYRwAlfVG9xlQaY7E1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlACDccSPFh14KNSr5mDT9mJTtrtZR0g05NZEe/ZbtA=;
 b=Qn5LOyQ/Pi+5B4hrA7h9tL0yozeYaPrVHfb9ntTR9bPSJa26aD6tQQ+zUePak612o3xGwjvwupYpF2W5Qy9uGdj8zZPk+90tWbN0eilwn9cCcpzTInQwv8ZkUtaXrZbDdn0cjGE7i14YQ+1ux/bJg0ngg1lM+LpzJ6X/IdM9HdqakY+BbQhWYX/Be2+DWrAUVp1vdichvDX7gjn5bXHwJNnjNc/9sQMba/Bwmfz+RfDU2LNtsxJo32iC8f1ub02g66u9yCOTibOIDodU1p4omiNvWjJzjRAooUssfdOs7hlQrxXPxdvTuDSqOt/bI2Dt+uxWOK9BuD1f0BAs4SGRQQ==
Received: from CH2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:610:53::36)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Thu, 8 Aug
 2024 14:43:04 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::9) by CH2PR17CA0026.outlook.office365.com
 (2603:10b6:610:53::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 14:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 14:43:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 07:42:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 Aug 2024 07:42:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 Aug 2024 07:42:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 4/5] net/mlx5e: Correctly report errors for ethtool rx flows
Date: Thu, 8 Aug 2024 17:41:05 +0300
Message-ID: <20240808144107.2095424-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808144107.2095424-1-tariqt@nvidia.com>
References: <20240808144107.2095424-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: e96054b1-1069-4125-791d-08dcb7b86862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J4VJc/t+fkbn9ZnXGElnK7DGaEYUay1gCG0+/3Aqz51+XAkMByGdtSng5lWa?=
 =?us-ascii?Q?mB24qcRCVMuuKW6SKGLBdS02oG9EUNqOqqw2p1c7jM9flEcbbXCvs8MBLyRV?=
 =?us-ascii?Q?5V6/Oj0m/vv5XWiidQQ7WQo3Q+4ujFOit5aD78CkjOo4SWQSL2cAYZFS18VT?=
 =?us-ascii?Q?LrtOWKIcmOlS2S6Tb8JT321ELHstRFlob1yUgNQlbPhk8/ptHCidgaMYXm0W?=
 =?us-ascii?Q?vAg/NOuc0tqzUlyuOtaD59O3PzgyBQCjvV8G74e4IwJ/aNTxt8TkOFMGo0jr?=
 =?us-ascii?Q?L1E4uDezqy7i01GSBsPnIufNdlXZOoiHDOOH9h2CFSFe22viYsHjdcSNpG/T?=
 =?us-ascii?Q?0u81WMqwBLwOUFCwL2PCATIoTHVgIOgvcq700YPSdnWguMk8Cf7bkK/DHVGT?=
 =?us-ascii?Q?opylLNu5EurHNLrSi5yrn/RDCioMu/UANCLD65fn1BwJQ2HKUfI7WLLhepQk?=
 =?us-ascii?Q?T4CCfYtgkABAKbK+7+ucHPXLZJAd28U/Ch+RCfLg47D+NRezUg90l+9L9WdY?=
 =?us-ascii?Q?1S7svoe4x77G26ak8F4bMpY5c+4yp7jFfi7SgE18XgZjhLZdf4HhxI3vnbuv?=
 =?us-ascii?Q?qTAUaLupLvjSG4Ag/SmndXZmDdFGNWrwdmW7BQ3xLoxCVjGlp3+cASuujOwP?=
 =?us-ascii?Q?rJpg+UPe0ne36mPlQZeNhBfV+3MrehRCMSZa0yIWxkR1ROBfUe0NugNZIeOQ?=
 =?us-ascii?Q?MKh5DSZqSXsrIALoMmqO03Ucv4D8yjw8jSrqLdU1wXM5ChYG6n0tiYnxQvL+?=
 =?us-ascii?Q?AcjH4iwGi/vUwYtHgTK4GsQ24/Mbi5J3v9/eNxOrfWC/bGygFiYOuSVki53t?=
 =?us-ascii?Q?SJ0GKI71IXbdm1t854C5qt7lCu2gIWsrfS5EQpa69Elx7Gb3XVdvB/3SAFKb?=
 =?us-ascii?Q?pqgKp2tXgx8bNlFIiQi0KiC1jxtDxxH3u3NF7LmM8GhgGJLLdTSoRkE6B/rR?=
 =?us-ascii?Q?Ehfi3D1+E1yXGIu+RwlAFrukF53qQMqlPrVYa6UgLgHxSFFGa/SC9LDZbPYk?=
 =?us-ascii?Q?UL8EMZr55YPUK6Rj8Pp0jwZTUiOEvTssPjvsn8rfTc0+zKSd5YuIHXgg3uWK?=
 =?us-ascii?Q?8FjtjE08lSJxc7T5oZboqGvR1r0/ONm4bxw3lL6ZoZadQKXbYnw27jCY62xE?=
 =?us-ascii?Q?fbk9vsnnbVKXhhU7ZveFEPO1P9/scfnAL2OHDlwEAUZsNTqqDCR2TkA/ZIpv?=
 =?us-ascii?Q?iYPSzxEHuaf416ZV7aKqUoEbS7ccD0zwsoSVN/7LRTsCBgmoMVgVPN84h30B?=
 =?us-ascii?Q?e0PF46uR+QfOrORHsW/YVaAhwhZ2PTmV9hP6YbAqsggl5HMXPF/xJRN5SAyz?=
 =?us-ascii?Q?erIB260yUGI43A7GTZXceSXMviMlYQXo5Fmx6wKVgt69WHreutCNgCdmhqVh?=
 =?us-ascii?Q?DA1CUUb7RgPQVhpiI5sWIxCiU29G5tvXraSeANIiGYuNMcvP6XKI8sW6wmD0?=
 =?us-ascii?Q?87a1X/BaGN/R+4FcJqIBJBGFagy2I9vA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:43:03.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96054b1-1069-4125-791d-08dcb7b86862
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, an ethtool rx flow with no attrs would not be added to the
NIC as it has no rules to configure the hw with, but it would be
reported as successful to the caller (return code 0). This is confusing
for the user as ethtool then reports "Added rule $num", but no rule was
actually added.

This change corrects that by instead reporting these wrong rules as
-EINVAL.

Fixes: b29c61dac3a2 ("net/mlx5e: Ethtool steering flow validation refactoring")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index 3eccdadc0357..773624bb2c5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -734,7 +734,7 @@ mlx5e_ethtool_flow_replace(struct mlx5e_priv *priv,
 	if (num_tuples <= 0) {
 		netdev_warn(priv->netdev, "%s: flow is not valid %d\n",
 			    __func__, num_tuples);
-		return num_tuples;
+		return num_tuples < 0 ? num_tuples : -EINVAL;
 	}
 
 	eth_ft = get_flow_table(priv, fs, num_tuples);
-- 
2.44.0


