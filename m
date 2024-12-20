Return-Path: <netdev+bounces-153621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190C9F8DCE
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D57318941BA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAB41A4E98;
	Fri, 20 Dec 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j4VfvAsN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EB154BE5
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682586; cv=fail; b=iimZv57SUjBRsI2vezYBzPXXP4EAOzTigd8Ow4VFfTbB1s6qsuqiwc4PpWztw/tvKsl3C9i/mF+kVkYj4aRF6iG0+Dv+PtiFMYrxUXUwY6P07qL9eNZqRVMu+2p6tdf2RjWg1nX07iYJWcz1hgAiKv3Bh0S8xeyM59qEy8xmY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682586; c=relaxed/simple;
	bh=PYnTZJ3wu42dlc+7GKP/tXLkhDjXJdbW3+PwjSQyrgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=io11L/XiI29QZA0p+5bzU/SvqRFECEkMUSyFGWcVtEiWU/hRlNLVUcsqVDguDvqEpfK1cxigK5jMYO7vAfyGa4dPk6EqBKWSWE/yn9wtp6QuWcXiNL3OqBGGcC19IuY+P9BmqThWM5IAezDYTDDGJzVQNZSY5bH1epwO72ddcec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j4VfvAsN; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrPqE9G6hF2z8dDVl+spORtr4rRhWKli9hEF12lkfNNwlsr0p6zYGZie8kmE6CWH0r8IY55gt2lI62wYSLXFj+vKQuamtCrU5eXh9NZJ5VZu+Ua1yHNWewkF8DMc/xF1aqdjvNguXNbYoyZif3Y+uJLhlEmEKiRgrDKqUhekAgKpftOwtH9DVXbzmMrnY+dY1DNjrKZmOv+YITiy2+aSyl1mQvQoN7xBX1ba3v/ln94OVeKdCmhVqsIRLwX9pJutl6FA5ZBGVlPQY8o469d+xEK+Vkx3EyNLgb+/eR0rlMMsUthGnFBLPHDfV3PgYU8Sc1uvO2+NpQi6R0q1ddynyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVEqexDKL9mey9U2kV89fH6rrMowgW6KqC/n3RTgq6Y=;
 b=RgDOTqEo9ttDoTjgh1ib8PklqaDTy2EGIH4VxL520kQ/EMXf4/p9QBc0IwNfQOWo5WDX2ij332kwzym6RTZHuOSksRWlrsOR+jKyPZ/8xuEcK1FLhzyK1heWUvepsxFcHOBK0YHSkRPfnUEHaozjG3R4dPyw62KistPdxF8YyVrw74cdPpD/xLmSK6Xn2ew/iAdoDwqyga0wEY3Esvvqd2EmreU3CXFccws6OuFkREFSzhrJ05rxaTEuIGh/RZSGcJutLR/eUP8vtbTh1bmbua5ENBoM9XgeEqhlGe1gGl55oEU39aG0X7OOt0Wx+9QCl1+V/eiVJYQMCQG248LznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVEqexDKL9mey9U2kV89fH6rrMowgW6KqC/n3RTgq6Y=;
 b=j4VfvAsNRPKXnR0pfOUxMVGPepQ6FyLLKdOLz/20W/d7UHXL97F7oFkRod0u9i/3jTQznglYAo0nJ2RyRw/WLEWAqh/urg957gbbNFz8YldaWSNBe3ODjxkjd0RHGKM3kpxMdHxvIu1FQHZBzjEn3LTBQA8VKgkvzHqnNOK8aQ3lK5WhTrjuvIJDE2QM04cSl3ZdOnIt3X+Cf6Zz4nxrhzdj9cL4CyrD4YFAbM6IS7/N9p9AqKPfEAxdq3YiYnUfhRl9niQUJEcWkVoX/Diyk0SuBzecBKYtENRhNbrB6I6cnj3WnGXg5BW5aEHf4qsOnlCkf/6WW3vk2Xdmo9J7uA==
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 08:16:14 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com (2603:10b6:303:80::4)
 by MW4P223CA0018.outlook.office365.com (2603:10b6:303:80::23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16
 via Frontend Transport; Fri, 20 Dec 2024 08:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 08:16:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Dec
 2024 00:16:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Dec 2024 00:16:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Dec 2024 00:16:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 4/4] net/mlx5e: Keep netdev when leave switchdev for devlink set legacy only
Date: Fri, 20 Dec 2024 10:15:05 +0200
Message-ID: <20241220081505.1286093-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241220081505.1286093-1-tariqt@nvidia.com>
References: <20241220081505.1286093-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 12854554-e2c8-459a-c831-08dd20ce91ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oknqf1ZEG5DKx3jY+9kZlfHwOSCbKDVVvIEZ33gf61F/or1n293uWWm/terk?=
 =?us-ascii?Q?OKNQ6Li/FF4gyhY7pwVYT900WxO501RWvkiIzmaOqY3M9PBHccNaU2QGSEjB?=
 =?us-ascii?Q?CgYULNc0k7zErnvmyC3Xwq1Dj0G2SskNjOIbDi35QV7M0VNUzvciPnk6/LDY?=
 =?us-ascii?Q?wPBoltN20/CNOUd/5aaYJ6OrM36sKLv7XgZ4NLdD/nApF9x7643KjoyMqBba?=
 =?us-ascii?Q?YobYlPP2RLx8RJrVX28V+ItSQR2A3FAe4vMJiBOp4x9El47K7DXK1L+fVaxP?=
 =?us-ascii?Q?2I9c18DDh7GSKsg/XQRhvKwez6w//WFAbUcuQr4OIQC2m6SOSaZhBKyCn9xm?=
 =?us-ascii?Q?7TaiC5DHaRGx+0rVtF6acfb9KStV41xh/HDckdxAUCJsvgZzYyi+7Xb7h+N4?=
 =?us-ascii?Q?24ogpgHPg+bV8KYmhC4+IucETzAIaFJKhy1ckUjaynzKlZJS8bW8sP9uTYAm?=
 =?us-ascii?Q?JfhjYko+jDFDEeixGDs8XaCVsoEE0bTMkFuKXXBxUtcNv7jGOo8MFsF2wHIY?=
 =?us-ascii?Q?QxMWBNRkO8al4O7EjphV3E9IDaQjgZriZkqukgrM8ShEnDYHjMGUtHNbniYI?=
 =?us-ascii?Q?0AGYEXerAYmHUnTD9ly/FIvCv5ybOe4vxJ5vlMDaeGZKnxTu4j/ZaBPYzjtB?=
 =?us-ascii?Q?omzrbROvouvJ5m83w2IVvex77iWSF770bpHhJ3Ta9o6Ec13SosMgzVqwcHdb?=
 =?us-ascii?Q?IyuDIngve3Z1doIM02yGy3itwcP13c/KEcjiQ7AGdeLguBhysXeSIDWQogRo?=
 =?us-ascii?Q?/FgsOhFH09CzbZkW+QjXrp4fOBOHSMU1WX+8UMWcSkcNzrqRkjQDADbjRWpI?=
 =?us-ascii?Q?mxlfwhQ00GNoKIZ0IX5Ovrsg6b3iNo3D8fk+cfNP7KCO4XLZhNXQ0HzgLLEh?=
 =?us-ascii?Q?ikfZhuBPIVYZfhQa8X6xSJD+8THIzNdidUEMEb7D755jpUWLYm48k8PamkKO?=
 =?us-ascii?Q?jMgVBpAILJOnw2Zkr6I03lUWGdjkbyuLJ7VFZzzkEV7KvyKgSjXpByjiip2S?=
 =?us-ascii?Q?9gURxjEKxgMJZFDkvTR7zSD22MmTr1pCqzg8Bt8qNTiJTUYcc2p1WzsepRxO?=
 =?us-ascii?Q?KJ3IodB8sWWWpOLAYbBqYt0U0CxraO0KZC8X5YtTSPYE0BHg1lsW52Cv8GOI?=
 =?us-ascii?Q?tnzR8MubPRiNGwja4+0+K3BfaNuwQ8vCGfXkza9U9aWys27PEjAmLfjY+TcJ?=
 =?us-ascii?Q?BPAJ1y0vxyS/ImbF/KN6ZQUZzA8cUzXAMn41fUBPzkjh+4AUq2HujXwcW3AH?=
 =?us-ascii?Q?3eDw/nBYw9wSLgu1xBT92xtATkVDf+rlDJFauJtEavtaDfbSwmYDKDOGC5NO?=
 =?us-ascii?Q?tIqSKvdrkAYjwb3vFH8CfS5Zo0UiHyqA1F2o3wW8kwADnSAwZ0VAYxLfXMwO?=
 =?us-ascii?Q?NJA2TNkQw9roCZYhARSe6Uy6if361pIb/eX8EBMG/Z50ED3fiukXEvTTnNp/?=
 =?us-ascii?Q?1h4lp3MK40QTYKRsJJGERjqm57z8ZXIO5wd9Rs2bkEBW85KybWdpzySWYQ9w?=
 =?us-ascii?Q?bJjKV+7eaSMipyo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:16:13.9419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12854554-e2c8-459a-c831-08dd20ce91ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030

From: Jianbo Liu <jianbol@nvidia.com>

In the cited commit, when changing from switchdev to legacy mode,
uplink representor's netdev is kept, and its profile is replaced with
nic profile, so netdev is detached from old profile, then attach to
new profile.

During profile change, the hardware resources allocated by the old
profile will be cleaned up. However, the cleanup is relying on the
related kernel modules. And they may need to flush themselves first,
which is triggered by netdev events, for example, NETDEV_UNREGISTER.
However, netdev is kept, or netdev_register is called after the
cleanup, which may cause troubles because the resources are still
referred by kernel modules.

The same process applies to all the caes when uplink is leaving
switchdev mode, including devlink eswitch mode set legacy, driver
unload and devlink reload. For the first one, it can be blocked and
returns failure to users, whenever possible. But it's hard for the
others. Besides, the attachment to nic profile is unnecessary as the
netdev will be unregistered anyway for such cases.

So in this patch, the original behavior is kept only for devlink
eswitch set mode legacy. For the others, moves netdev unregistration
before the profile change.

Fixes: 7a9fb35e8c3a ("net/mlx5e: Do not reload ethernet ports when changing eswitch mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++++++++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  2 ++
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index dd16d73000c3..0ec17c276bdd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6542,8 +6542,23 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 
 	mlx5_core_uplink_netdev_set(mdev, NULL);
 	mlx5e_dcbnl_delete_app(priv);
-	unregister_netdev(priv->netdev);
-	_mlx5e_suspend(adev, false);
+	/* When unload driver, the netdev is in registered state
+	 * if it's from legacy mode. If from switchdev mode, it
+	 * is already unregistered before changing to NIC profile.
+	 */
+	if (priv->netdev->reg_state == NETREG_REGISTERED) {
+		unregister_netdev(priv->netdev);
+		_mlx5e_suspend(adev, false);
+	} else {
+		struct mlx5_core_dev *pos;
+		int i;
+
+		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))
+			mlx5_sd_for_each_dev(i, mdev, pos)
+				mlx5e_destroy_mdev_resources(pos);
+		else
+			_mlx5e_suspend(adev, true);
+	}
 	/* Avoid cleanup if profile rollback failed. */
 	if (priv->profile)
 		priv->profile->cleanup(priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 554f9cb5b53f..fdff9fd8a89e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1509,6 +1509,21 @@ mlx5e_vport_uplink_rep_unload(struct mlx5e_rep_priv *rpriv)
 
 	priv = netdev_priv(netdev);
 
+	/* This bit is set when using devlink to change eswitch mode from
+	 * switchdev to legacy. As need to keep uplink netdev ifindex, we
+	 * detach uplink representor profile and attach NIC profile only.
+	 * The netdev will be unregistered later when unload NIC auxiliary
+	 * driver for this case.
+	 * We explicitly block devlink eswitch mode change if any IPSec rules
+	 * offloaded, but can't block other cases, such as driver unload
+	 * and devlink reload. We have to unregister netdev before profile
+	 * change for those cases. This is to avoid resource leak because
+	 * the offloaded rules don't have the chance to be unoffloaded before
+	 * cleanup which is triggered by detach uplink representor profile.
+	 */
+	if (!(priv->mdev->priv.flags & MLX5_PRIV_FLAGS_SWITCH_LEGACY))
+		unregister_netdev(netdev);
+
 	mlx5e_netdev_attach_nic_profile(priv);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 40359f320724..06076dd9ec64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3777,6 +3777,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	esw->eswitch_operation_in_progress = true;
 	up_write(&esw->mode_lock);
 
+	if (mode == DEVLINK_ESWITCH_MODE_LEGACY)
+		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	mlx5_eswitch_disable_locked(esw);
 	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV) {
 		if (mlx5_devlink_trap_get_num_active(esw->dev)) {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fc7e6153b73d..8f5991168ccd 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -524,6 +524,7 @@ enum {
 	 * creation/deletion on drivers rescan. Unset during device attach.
 	 */
 	MLX5_PRIV_FLAGS_DETACH = 1 << 2,
+	MLX5_PRIV_FLAGS_SWITCH_LEGACY = 1 << 3,
 };
 
 struct mlx5_adev {
-- 
2.45.0


