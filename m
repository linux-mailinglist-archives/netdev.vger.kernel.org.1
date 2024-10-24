Return-Path: <netdev+bounces-138760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DF69AEC6B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612AA283599
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45C1F8197;
	Thu, 24 Oct 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r/kschtq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84916F910
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788152; cv=fail; b=r8fB+k8aLPOCU+kj/5QR22otFNpdMtCWvZGbhar9MakAapTnO6+U1Ohmz7KAcJz23BMUlxPoPd1vQMd98rbKn2f6KJVbqb5nC5unVaX3M9T0yTO5Aq5Vln9Y+Egy4TsUGb/9TI0U2RwmvVg6AISUPJoIeWtKbCUiWkYlecLtigo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788152; c=relaxed/simple;
	bh=y58O24QIsgCRLbetpZp2jNgsJ118HjWPEANcyKQ/AB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDNygUMQMfzBFN+YnjialMq/nFqxi4GyA74P0RIYRR3MP96aoSflrHVznvQ1lQVk7+19wSFdoq/88xI/z0Sqbw2NyHtxwWT9P8CbDoGlaeNfV5uQI/uJso8EZ8Z1hcT98RX1M4sbnD+8vIJ6Wm7IQZ0BOCo6gmXscMFb/vxAAFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r/kschtq; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvClJZ7Z2u6xS70Dn7YXYO2u/brIfYlruuxVtplNSXLABBYt3NSRvxKr1ZmgLGiucu0lDwTkZVpr4ae1G/vsY239gTs4mEUquT9A3dii2D5Egpkf5SeJue+Bkp1nKww4xkScj/1fRAkOZi1wBEyU/sbh06rC1jqJVFIQH8tYmROGRMn9qdIQoQC+0JHlqEfJd8SX3L3wtfRZxdwt9ngq8k7EeJVrAgetJwF5WqJOC305xvgCjg3rX7PRn0jgFqn90dmgUkcDi0utZXtjIBb27fLosqdK8pOoNdEV7FbBz1IKCCklHyRdkNMIkcsknDdQv7OjYuHsk85qODHYCwP50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV1H3bQ7qTa28AglpO8nORV+DIzdFIMMkf/tifmpjnk=;
 b=Ki15UZvmLusZbrUOohSF9NyhWPcvlN4PTGXPlY3jbPX5gKrZA1kW7INZMVtswXZ1WNeuwXb5GNQvu0FNr3nZ1BlQpbRrJaroha7UuAEGO7/Cwcz67+TystNs1ycB+9HUhCzhzBMtyGmKc574fAyPPRsdxPL/P6m8QzT6Qqur8L7ESma1laNRocu/ZZBusuN8ISsFXSl7/AFiiKwbZU6Fx4t+AJyJi+2pkVJPipsnS/xqRPLG1Oc90/gw64BjxMJP092n30/LeZFKVZuLBfEubQUsyEeKdM5cbxnKKlgvUsmnXT00VjAy+iImi/Yhkmhx4VICIoLVSSoIJFltBET5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV1H3bQ7qTa28AglpO8nORV+DIzdFIMMkf/tifmpjnk=;
 b=r/kschtqWCwtoY/BqNY33jtwoWfQImYUr6YEbpgvl+LPXYoudsA1e/RFIiSauvgP/0NJQ/3O/ihJcNaSLiORI6EuidSUVIy5vVfgZrwRdLDEYIeacTWparRggUZd3mXPpgGkc/buty3jnDdM/b6JbGDoaVtwe7psF+tB4REEhGTQN/fSMsVsUmvXRTVjMJ8zAbQ8Y5+0QYZDSRwVnQCurxc6zrEsIxdAJMiunaQMGynHovs5disJKNdXHK4QBmwo37HKuB6GVGA//4UivPaw9Vb4vpoTKcyxphwjyBI/wFzzBDRZIoAS5fy9I0CH5th74tHDoKbqJ6tFnT2paBM4Cw==
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 16:42:25 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::5) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 16:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:42:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:42:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 09:42:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 09:42:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5e: Update features on ring size change
Date: Thu, 24 Oct 2024 19:41:33 +0300
Message-ID: <20241024164134.299646-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241024164134.299646-1-tariqt@nvidia.com>
References: <20241024164134.299646-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa318aa-d504-4d69-a7f3-08dcf44ad669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EX+v+bu8drOdGAAjIppo6DuAMqx7owpdj/stZmgFUDrQjuVI2u2Xj3+PWTbp?=
 =?us-ascii?Q?D78bBN172HUc+PmVu2oFadDvG6AseepzxJNBdec+4G1d2ADuUkpzHEAxFo/G?=
 =?us-ascii?Q?OHfBjwTsvb9ycRR+P5U9yXTzVAAbf+0/Jirp7ouQCFzCjCH7J4znhSnXHBzt?=
 =?us-ascii?Q?uK/xAVfdWTG2hTPolRfxQ8CJUY9ZBvHLe8NCTo0q3lJ4n/u6XTWhqNOUIEKc?=
 =?us-ascii?Q?fbDimnmN+DU6lsP150Au30FmKY0RB3kv/4vT+51HBxP77TuvjXtO0gyws8HI?=
 =?us-ascii?Q?PqQDCnCXNzp9tpXrQ8cFr9cGkZ9S3+bVDGdyUt3qEXtdxV7x7T0J1xMXVhL2?=
 =?us-ascii?Q?dDXe0gVn4H5UFG9c7Np5JPCOXUq78XalrWpTYfNBiM3PQavdav2xJfQJ+8CG?=
 =?us-ascii?Q?bmIo2e8ZeR/DYj3jcatTuaT+k0jyLs7qwFZsogjvZir/vjE3qrH55IV9VNJG?=
 =?us-ascii?Q?k6oFEGBLuTpM0tzp3ZgvElH7+P7ye5Wx4FwsXL0+DzXnoJq7Uq3ZIR+N4Nj2?=
 =?us-ascii?Q?hq8vqWnMEQBgfotRg6uGLVakrcETTgdSUwdoCx736UE7/oq1TwnN2rtSJXFv?=
 =?us-ascii?Q?qY9uSvXgiIbSK8wcyFWr8RV9u8CJr/XvclwNUiqb5Bbram3sOVGtp2c3vkNX?=
 =?us-ascii?Q?dm26hOYbWM+n+DX5fDGOktRofdC5+OVrFUBRuviN+NQz1hZdM9DtfGKMdl1Z?=
 =?us-ascii?Q?sT500XVbtHasu09ifc4+qZ69T/9Y1ZQp0xp2Wt8dYqyldcKRnMrtCGL/QsJf?=
 =?us-ascii?Q?HFoPxonn9G46K40YbNeMc5BuYtuiPMuQZ5x4otlHUQcGaTu0JIIuM1U8PZKl?=
 =?us-ascii?Q?XrTwbH4JbFpRULxk0iMLUaGSuGLNkNxQc6ZjnO0WiWb6VmkB3GpmFRo+ceI0?=
 =?us-ascii?Q?ccPlfWSI0Dy983yLKDaOMx3hFnaO8/ySwmAMvXho1s1GcxjkW1m/hjKfu5fr?=
 =?us-ascii?Q?/xVVxDgTK1GS+b3ioPz/ux3L2cIfO+DFpHoHvEOHpuKwN2XUjwuzhQrZUL0e?=
 =?us-ascii?Q?QByLf59Cb2L+I0+4FeAySZHhTkOcEKKvFjzfeSCRTZanMdlALmXIKCb+F+et?=
 =?us-ascii?Q?R3p4KZs7dKivors+5ZBZoizMhdgKOE/WGlkW1E0H2ovH/lqiN2TWUFcLbRSE?=
 =?us-ascii?Q?zNin9wAdu83sq/Yzb4qdy+Lvjnd3V0XWjmL7dZo9sHHSAPL3GKiPhLTtfIhF?=
 =?us-ascii?Q?pvjqiVk0ulhXj4iorumOzzdkS3uSYZa4f/b7abvUBsbTZ4GrDT7j0xEaMPH/?=
 =?us-ascii?Q?+mNrUBO+7p53viT09TxAigfRIsbptVMjIjmkjQhKB8mROGa2KRPw6gzEod5q?=
 =?us-ascii?Q?krlcn34i76A+SHDl7b9vonVveB55FwTYqDW/B92tbx+glVqaekkKcAI2ZnyE?=
 =?us-ascii?Q?vtG+ReA1bePPC0EGlFSMWl77g4Ylmdk8EwwHWC3ZkcMnDTghMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:42:23.9898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa318aa-d504-4d69-a7f3-08dcf44ad669
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263

From: Dragos Tatulea <dtatulea@nvidia.com>

When the ring size changes successfully, trigger
netdev_update_features() to enable features in wanted state if
applicable.

An example of such scenario:
$ ip link set dev eth1 up
$ ethtool --set-ring eth1 rx 8192
$ ip link set dev eth1 mtu 9000
$ ethtool --features eth1 rx-gro-hw on --> fails
$ ethtool --set-ring eth1 rx 1024

With this patch, HW GRO will be turned on automatically because
it is set in the device's wanted_features.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 1966736f98b4..cae39198b4db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -406,6 +406,9 @@ int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
 unlock:
 	mutex_unlock(&priv->state_lock);
 
+	if (!err)
+		netdev_update_features(priv->netdev);
+
 	return err;
 }
 
-- 
2.44.0


