Return-Path: <netdev+bounces-86991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3108A13AC
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191861C20DCA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B914B088;
	Thu, 11 Apr 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S00vp98q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15C14AD2B
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836562; cv=fail; b=GDKS4TPufrpmdBO1Q9mQIfCQ/jYKKzuvY4SfMGqLIIiFgwfJO3BDoleCDlNJ+I0vTe9Ndb+2n9HTH/dIuDbvqrCaCJgDk30ELdDrfBszB6OLrbGS9p61RHOg3ho7xghhW1Ue2iHfcefd/VT0bG8dTEPXlJwMFi1X0IB6g64e/bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836562; c=relaxed/simple;
	bh=i9sKIi5wa3AbCzStTeXl+wXsoE5yWvclF+Sfa5I5hdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWXMpI2x7qTGyggqDxBRHLTE7OXSoioY2ua9UQekHahz79TsbCXOqmfSPe5CpwG1/oVDbJ6HCmNxEGysjow15zyyYg6RIOdO8k/9QQRIzVfvyVZwS/2GyW7ATD41mWbpT8T6etfTShtiUF4vwW6Kau3rz2x9eMOfMHFy+JcNL7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S00vp98q; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEFqCgYbZMwFnLFYArAgaqTbCaVCQ0ce5R2YVnz8/38zLJJjphwkgCHMxoTu8gRh1fgZ26RBUMKzCW/9fG/2gP9uKMv9fgQIxm6/++zJADe4DD2vZQcLRmBJS7FYcED9SCMl3R2OQgiD8RlEkFC0vNq4rPJ8eJ2bXd0CWxnAn7sGlbRb2qZadXp9szh9jl7N+SpMZd9BReae1P6Uj8aciD5Gm9atntdlqfS+rif/6u4kYJUFLhjlf1aTKOB/Fi3k0Fyhl7SPGvdFr8cYK43wZpp2JFbQLxQIjCTPM9Dq/IHCkGQzXQuSLsQpZPCk+VH962TFgZy9c/PZQ09+Del/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsee4fjAOJhHm/G/i5meN9uOvehHzfOjtSiFc2gqZe4=;
 b=OESHIaj0DiecW08zNyJPZ0V74AV49EwwI5Ih9oroLLO+DTgtx9lXELgrAkWTE4NNaI4EEFU2ZOL4wBYz3tTv8bE6xgXSFR3wnhInAIeQpDhstxh0YP+lM07n4fh0Z4NT/HypcaBQhQC2DhiNtQI4SwdnCkZgrHvAkYm3gFZVUc2ASOZ1l3xpbaSzJkWPTADAczA6dGKCI3SIbwn2VCZo/PA4DlEsPgbj/6S0lGG7HVWbKqIpmjrJHDa9+N0LvlYfrheLiDtHEa7fIwF1zIPl9k19ARXHs5vMbBxvxJBMsZd75MJUX3mQb2oXvcctsv4nnpc7Pl6hmvDiChLVxgmooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsee4fjAOJhHm/G/i5meN9uOvehHzfOjtSiFc2gqZe4=;
 b=S00vp98qb54t+M2t2fi7e3YdUqcTBzzwhmvQ9n2gyCU8gFDGnLPATEsc4t+CQOfUVGkG1Q9/NVYkJ+zHnwt4ALnYlMdHsJ8Ih5evnIXauZTvKB9AZ3en0HHDgIz7rM+q5cIty2Bp3ZemohH8o8yLS/zB8mIhs3N+pg16f8OEej+fCtcfgiGXJAThPBnnaY1FzMZJu+3CG5uQvXFlbGy+J6jtcrUtI+4wTLvn49RPNb27bf1cylUGD5CFzxhlgqGz+EgLtWNUX0xtQjC1r5GH6fnKR90w5yaNEbUQg32SvRV92uZolJJPHJyzV2p4zsDoM+LFwkI8KifYZ2QFqLdM/A==
Received: from DM6PR01CA0003.prod.exchangelabs.com (2603:10b6:5:296::8) by
 PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 11 Apr 2024 11:55:57 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::44) by DM6PR01CA0003.outlook.office365.com
 (2603:10b6:5:296::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Thu, 11 Apr 2024 11:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:55:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Apr
 2024 04:55:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 04:55:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Apr 2024 04:55:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net 2/6] net/mlx5: SD, Handle possible devcom ERR_PTR
Date: Thu, 11 Apr 2024 14:54:40 +0300
Message-ID: <20240411115444.374475-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411115444.374475-1-tariqt@nvidia.com>
References: <20240411115444.374475-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a331166-be0d-4a84-6355-08dc5a1e58fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H9Bm9G80wBh0KrRY0Y3gGUTRCxMiWb6rmeKoBXhtWanIghfeOMT3X4QFs8d30bL9UeuXdeav9nsWbYh6EwmdG+FKW/3Q6wQMXa/jxSHLJ363AyvuaXQtsTlnCYhP0Jf5ABGh5OaM+NdAmDw4ui0cwaw4A8Bsep8Y73Zz1UaIr9ctgohb93OcmzrdJziSgjkBb5KNzLkEpgLWvtLt1IgfjgmSH+SkvdRxbp83Zi2NHy8bbWJSohHC8BOpw7kBIx4wFn27rn+4tR/qiC3jE26rwyXWfAvF+qpopHbBvdNsam5Q6fwpMI3/mtLhOevep+jj+XBulmcpdfkWZ+qtgoJYHDZStpV4ocIQ5Yr2CqX7T0diueI61dtqFHgDVmOEa2phUcR7Q97/EekeYk26DAc3GE6O5mVQb7FFJBs+I2Y5t0gDTiRHcwOGp3YZxHHr37NgZDmb+HqaKTCa0xr+BU+wN8EWWNtcXHJvKkO0wTxz79Y6hyAVp3lpWFPxxtTY6hoC8qB9dKEtnOFp+4nknZ/JJWoMUkJsTLt5VhRgBTVg5p0xs91QFbqtzDwkhCysN1RRcEleu/WEGcZPVWoIX2vf6MOsVmge4Z4YxW90mmtPZx5Tz6LWBXwmJLsH3Pn8YWlqu0P4EG4BPxamvKduFzO7quet/lbd+lQ2U1mM1wi6C2C1MDrKNUcXf7pTRue2z8iQgUzrG5yDH8mWud395XU/BmMR6kTjUkqRqnx8qHGRAxe2hcRk67+0TrVuzYfCyUAN
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:55:56.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a331166-be0d-4a84-6355-08dc5a1e58fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

Check if devcom holds an error pointer and return immediately.

This fixes Smatch static checker warning:
drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c:221 sd_register()
error: 'devcom' dereferencing possible ERR_PTR()

Enhance mlx5_devcom_register_component() so it stops returning NULL,
making it easier for its callers.

Fixes: d3d057666090 ("net/mlx5: SD, Implement devcom communication and primary election")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/f09666c8-e604-41f6-958b-4cc55c73faf9@gmail.com/T/
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c       | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c           | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c             | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b375ef268671..319930c04093 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -209,8 +209,8 @@ static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
 						      *data,
 						      mlx5e_devcom_event_mpv,
 						      priv);
-	if (IS_ERR_OR_NULL(priv->devcom))
-		return -EOPNOTSUPP;
+	if (IS_ERR(priv->devcom))
+		return PTR_ERR(priv->devcom);
 
 	if (mlx5_core_is_mp_master(priv->mdev)) {
 		mlx5_devcom_send_event(priv->devcom, MPV_DEVCOM_MASTER_UP,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 1f60954c12f7..844d3e3a65dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3060,7 +3060,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
 						     key,
 						     mlx5_esw_offloads_devcom_event,
 						     esw);
-	if (IS_ERR_OR_NULL(esw->devcom))
+	if (IS_ERR(esw->devcom))
 		return;
 
 	mlx5_devcom_send_event(esw->devcom,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index e7d59cfa8708..7b0766c89f4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -220,7 +220,7 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 	struct mlx5_devcom_comp *comp;
 
 	if (IS_ERR_OR_NULL(devc))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&comp_list_lock);
 	comp = devcom_component_get(devc, id, key, handler);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 5b28084e8a03..dd5d186dc614 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -213,8 +213,8 @@ static int sd_register(struct mlx5_core_dev *dev)
 	sd = mlx5_get_sd(dev);
 	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
 						sd->group_id, NULL, dev);
-	if (!devcom)
-		return -ENOMEM;
+	if (IS_ERR(devcom))
+		return PTR_ERR(devcom);
 
 	sd->devcom = devcom;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 59806553889e..a39c4b25ba28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -956,7 +956,7 @@ static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 		mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_HCA_PORTS,
 					       mlx5_query_nic_system_image_guid(dev),
 					       NULL, dev);
-	if (IS_ERR_OR_NULL(dev->priv.hca_devcom_comp))
+	if (IS_ERR(dev->priv.hca_devcom_comp))
 		mlx5_core_err(dev, "Failed to register devcom HCA component\n");
 }
 
-- 
2.44.0


