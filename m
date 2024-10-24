Return-Path: <netdev+bounces-138759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D79AEC6A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF111C2303B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572E1F81A7;
	Thu, 24 Oct 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RaXSSYp5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD261D516F
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788144; cv=fail; b=s9XoewSl/jbQb8Yh1Kxjynzk43L1m7QK/Cvi4awWO+SHyLXVlD/UuhXXTFIZmFeo6FoCxJFrn2Fj9tgFTghZ8Sk2ULX40khX/zqFzIyYkHrQ3O5uSOV+Qzy1snXp29fvzQXsOUtlzDf9VnylNf+jzK01y+SEt60oLF4agJI7430=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788144; c=relaxed/simple;
	bh=5zh6ao4yei5t15ChEqqPvGc0KDlIuEJNIKnBe0f9JWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPiJSRpAJPDcK4OQXlsoEwawzuxq/OL4JK6bh9KLWN7Me7vZdjzIIWeJHWcCA4HPpTj5XZ4BoXGlTk6VHRR2bFt6FE3ZaiMvf8KH3H7NcSjADdp7EQBA3CtuR8RMGtwPo24z+AkG0vxd7Nai66sY2zFHh/NYYcrTYRGw7+5h6zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RaXSSYp5; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj6hWMnKjRtLIaU1xyJRED+xbuxwKUNcDLhOyC58XRcNpRptoGSCbySSXtkXPz37OFp6QI3XfrtEa2wijlEY2DuGNR2rHEc6/MZgQ4oScBe1Tw+BsX30i/jU8fQ3pBKLB3hB6J86EsyOzIm2O4NECLqB7y7SR9+0LSrXKmKa3iiQWe/iEZSxBVn+aAm2DOo/t06/8P5Rm3VAK6aQF30kLMjMQncM0pVXJHtxaFM2gdaCJOnNU3xqSdujrb7VQ5EjJ8EBMAYT0DsDajlbQQb8hEykma3IyukVbmtWexYGwlvDCfukofQpEiTgSsRvI5mfqzbxdMYFUa3i6fch75mdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBSZT9gUXLc3F3at7Aph2eI0aYwOXtibU3jaofEQqCg=;
 b=pH+JUCzkl4yXZfxGmhoPM4ELt2TRyCxd1B8y7p1XqBLwIcU1zFqWg4WeD/i8CibLJ16C85P92FQ8qysSkbxcuJfDJba+266Ibu7ahslwy1Yb0qMbYe6zn6HDFnI5lmz4LOwBtWRmuRE3Omu1LL2VjSmdC/4JV+fHapSLpKV75+xACEQkpu9YCvYOVNlK+jxDW1Uyln4n+Y+FzU4deBBoT/kNjaYFFCwQZokPBOwKbuwKNXsAtsc/cjCecm8TKvCEbSso+gAhNGz9gH4N+q7EffK82DShO6Xm2S+ACKFkOx/r98i2hZNO/KF2wwEvTazOj0aBiWrSXkhnpaBykbBQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBSZT9gUXLc3F3at7Aph2eI0aYwOXtibU3jaofEQqCg=;
 b=RaXSSYp50sOX65VhK5E5TGyj8AY1SCPZHy/dFR2EOr6LtbeQdHhiOId0ECaIPgyFRu19gfIW/mPnAmv7OOlx1CkSoWT0FTp3ifpSDijyWSoFQU2xYIGX8/G91UmEk0YEuKLEqFqWZpjDjSdFIV1BSPYRGjWbItXzRSSkHLgcKwXyb9HEI4T7NXc5XxAh6+igUSss6+4RAq7IRIWmDGIIRSbmd3aunXB6knxXi5loRsbIK7VXuhxtOxGtd/kw7kn95TnE+iVYqXw1oRWMVCz+GtD9FU3uJkxkBWsy1o1iJTxlSFmztqQ/iik/49UpCrm26QPaA7UjKNfHtF8y7CkGfw==
Received: from PH0PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:e::17)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 16:42:18 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::44) by PH0PR07CA0042.outlook.office365.com
 (2603:10b6:510:e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 16:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:42:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:42:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 09:42:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 09:42:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 1/2] net/mlx5e: Update features on MTU change
Date: Thu, 24 Oct 2024 19:41:32 +0300
Message-ID: <20241024164134.299646-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e307e3e-6646-46f4-e8ff-08dcf44ad287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDi0eCJzg/eK5nCuvf/RD7pD0vRUtf8/yx7MJ7bdOxuhQUrZ2z24xLqwLXtO?=
 =?us-ascii?Q?up5Ulntd010pgxJHdf2IqLBjjQr6VHcNxJDPm9JkGGsUX/6q2MOe6YJacDvd?=
 =?us-ascii?Q?qk1P4L1NoOj3x1j4ZaShU6WoKdpWWeqnhcIyxFt7aSyTIJr4jJx2dnfo+p19?=
 =?us-ascii?Q?vfOsDANvmHqmE6rgkmBKZJBF+LK6slCJs5IC48CK5+TmLm5rYKZshPq3pQV2?=
 =?us-ascii?Q?d3bqvLfqRR0IsmaRxzTv5UH3CVvQZZi1IvpHiSvHrF36gmqYTQwmLwNB2CtV?=
 =?us-ascii?Q?BKq94AOVp7w/l7vh6kr6XG0cXFLZyQAKXsAnRS/i6wz3wZPh4K4PzKlEfa/l?=
 =?us-ascii?Q?l1iYBhEslKVgTTWc1wHFcyszxlbsQel0ts70W+UH+5aGL1AKNXphmmTbU1zS?=
 =?us-ascii?Q?kGejDJdAfC8dXCXteP46h06qBOqq0QkrkEscwYj1J+xYmfLWmt/LwA3m00Lo?=
 =?us-ascii?Q?BVUkg9vavMFirtvKuyZ3ovgCBI+poLfMn5LvTr8+wRVwl6oDHxmnANAu+ddA?=
 =?us-ascii?Q?Kr2UBm/UJhDDunepUnt6XnJw97DnAdk3p1NdEwACm6DIWmKxBkvuS0XAF8n0?=
 =?us-ascii?Q?AMx6X9J514YQ11kcFrTCplzVyQNE/xlKAHl8OWZn6xYJD3t0M2/YEgEdWDuN?=
 =?us-ascii?Q?l+lKyCEztJBiWhc3K0fapM3ZY/INm9tbUgkYS3eZ5nJQ2EWT+lxmEyI0gzN/?=
 =?us-ascii?Q?d2/z+OOa+xJAezKDmhpL3FoJi+gVps8jlbg6eWgteB7+gRAdQX+OWGkakjYv?=
 =?us-ascii?Q?thiLgubzNu2YxdipN62nnw/5rgevTBKgXuufH48KLpQlB0xbZQYApCZ9g3s/?=
 =?us-ascii?Q?LxNIvxeP3U41QQ1f4AGI3UlMNoQ80A6v8f6GbnzPOPZm00+LHK34qAbjo3Ux?=
 =?us-ascii?Q?KyQ0+MH2CNxx5WllqiBDgZn/gwa9sn5R++6YuQDiZxXcmvECfgc8Au5w01b1?=
 =?us-ascii?Q?q4iqTtSUMrTULAKuumd3k0v0tg+t2MwPnpNV8yIcYkMswgacK8O3pHT0zC8w?=
 =?us-ascii?Q?BV/oZsTSBEJLPy9mG98O/MP4yYZHfWxp73yiY0/afbjGQAA2MxOXnm7DKeOd?=
 =?us-ascii?Q?hiz1jE2ViXDBly66L8soiIhJY1PqjqYgQx0wxzDWogDJFZ39A2wVkOBfA+RH?=
 =?us-ascii?Q?2YfV9zy0LfbCHgh1nEOhTClO86f1386oaRd56u9fmGdTS/+h/krxztcv7VEI?=
 =?us-ascii?Q?N3gA42Up5XsSi0UHD+EJ+zuOrtD3vin4cLXtXP7f5AAO4TU/ITIanCZJgR2b?=
 =?us-ascii?Q?mMkDtIJW2uEOXDDDJZHSYBUKAlWfPSfnJ6aWWSXsH8CnqxwSuGD3fwzvqmUZ?=
 =?us-ascii?Q?gEyHFP26h5k+JsYZHv77pydI9LtavsLSQ68Uory08qNKl7m12qDIhENBFQeW?=
 =?us-ascii?Q?mw12d3jB6blEqByiyFsz1Qp7//c9UsMxMbp8hLRAsPLw422w7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:42:17.5709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e307e3e-6646-46f4-e8ff-08dcf44ad287
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588

From: Dragos Tatulea <dtatulea@nvidia.com>

When the MTU changes successfully, trigger netdev_update_features() to
enable features in wanted state if applicable.

An example of such scenario:
$ ip link set dev eth1 up
$ ethtool --set-ring eth1 rx 8192
$ ip link set dev eth1 mtu 9000
$ ethtool --features eth1 rx-gro-hw on --> fails
$ ip link set dev eth1 mtu 7000

With this patch, HW GRO will be turned on automatically because
it is set in the device's wanted_features.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ce94859014f8..235d00300626 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4557,6 +4557,10 @@ int mlx5e_change_mtu(struct net_device *netdev, int new_mtu,
 out:
 	WRITE_ONCE(netdev->mtu, params->sw_mtu);
 	mutex_unlock(&priv->state_lock);
+
+	if (!err)
+		netdev_update_features(netdev);
+
 	return err;
 }
 
-- 
2.44.0


