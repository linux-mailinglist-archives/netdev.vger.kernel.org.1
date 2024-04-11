Return-Path: <netdev+bounces-86986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB568A13A7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704C12876EA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440E14A4F8;
	Thu, 11 Apr 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RP1Optc7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016814A60C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836556; cv=fail; b=fG0EZZY+iRZeH1873lQPjwYJ0/0/1XuTEz9teUUllNsoDMZYBG0/vT7M5TVyl7a3hIerX6mQ1wLVkdrnII1q7oeKkD5QGRTbQZmB0IEK974tb2q4QfmdR/Wt2iamm7JVDK8gYjYjk1TqiZLIRb+UD24lxHL+D15rql0XdYOQ2O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836556; c=relaxed/simple;
	bh=IRSXB/b/HaGibNlD0BFrq5ql9OCWK9uVBIVP4776vaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br3Jr5afYmUMca4aCnmjtG5mJePxkXpUk/4hYdwP1FmWdCi388lMgNkuyx8xyIYrbAaseAvxB8lzNMnPrg5rDajAPPqmrTUMSfCwfSQ5KWbUgoFF4tQhBFSZO1NShihcLdbwZLQXJZOeMBSiZO2mjdC5NHlii9ShF4hWhVRw9KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RP1Optc7; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlnM52odI8VJ1FA2I/zwE5rIpJ1ZxpeyzyWe1YA7gKo30GENknSg5v929P8w2MUNgv+eEmOfJV5YuHPQtO+DDvqVuedH4uWfA868H8gOlevrR7FLZis5LbYjlo8rx+7yi/GS3fyzifwgGasclczS8o560luICvNQdWCzUkOqea+UiS/F89OhzANERTf6sXAis9jS6LjL8jOIPq7pcr1DDE9Vgm8fCQR+/E/TeMDza5/MBzArsTvDw0DMlDv8eQ5m7gBJJbNI6VvVJ/15CP5e80RyGPuw23DeNn4Yr+FzZCJIXcjJjCvDREVXBHAb42pVcZbvfX3iAl5r0BX37fE1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL1zynO1PzWgT42EUteuFyeGXkqTOYUDs0p8Drrl35U=;
 b=iWSZ7M0+YZWR6MyuBuT/bd7b7TQbr6LvJhLGDD2DAjv2f+qbCg17srH/nmGXHYFbTVBdln9d6ULm0AFQe6WNS4hL9Ep7E+DXHmUDBMVOjeZfkiZqJRUKzyQg67VfKt3WSWQF1Jyu57QIPdz5TgkU04iJ3vr3esTqn+ptnlL9DiBDsEKgkcNqJr4wcgra9vTgJxuA/W2WPAvimUG4PSSA43xlp2M/nriBxdaNlxr0YKPL62mbweRgITg8TCx3HpiNJ9Rf6WyKCpNBhZGMjNXj9kHFyNHWvw+spBZzPAXVkgIuNE6RIr/vDluW5hmB7sXRaYC1YArlL3cFyTuiTqNR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL1zynO1PzWgT42EUteuFyeGXkqTOYUDs0p8Drrl35U=;
 b=RP1Optc7TqBDyrolkBrbJ6P16KUy5riRf+s3aU/se8v7/Q4N9+0XKiun4kJ82qHZS4OpT0fzi8XKj8yPBb0Gv9uyJeEK5dR0ZA2rVVw+HiJP+bN0MN1YS31sydP9EZT15Bqn0zBzetnHJGc2QmMKLEL0Cl9K+p1Uk8H3kckUVCWt51Ig1cz+CxkWjkVvszg8uWTZOA3dnrNtbobfwV94mg9lIEsyM3PtCW4A9CBVOH9+2M5wlxAohz6Iwa9RE6APWT0KN6dIIMCvjQdjnvMYanJhuHWkS9kzt9aEAmyxzSGi/r49uDpOTjC36ZBSgcwkQ/VnQtZpkqaxjeQvcQFdkg==
Received: from CH2PR05CA0065.namprd05.prod.outlook.com (2603:10b6:610:38::42)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.54; Thu, 11 Apr 2024 11:55:50 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::13) by CH2PR05CA0065.outlook.office365.com
 (2603:10b6:610:38::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Thu, 11 Apr 2024 11:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:55:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Apr
 2024 04:55:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 04:55:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Apr 2024 04:55:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 4/6] net/mlx5e: Use channel mdev reference instead of global mdev instance for coalescing
Date: Thu, 11 Apr 2024 14:54:42 +0300
Message-ID: <20240411115444.374475-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7ba1ff-fee4-462e-a9a5-08dc5a1e5461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TlUGvYsS0aQYXzi6CiXBGcsrM/LNmvKNkQqPghag5ldVHM1I0Fx9CRgCgPs34W4gvbhfm4mS6/2KPcF3JbF9ijonRlqlCFDdWypi7nf13bSeDFu0aKsRr+aCtuK7kAqYlpVOXbt8/FRhvyZl6DTZvHVRmfHGe4AMfx3nvNcb498svr8DeXa4kERo2H7zpSE3yvbwLBTy2GJAR+L2fgDyCG14psyrz9z6PQGo+LfXAVIwUr337TFRK0HrBaNlgmrVX/Uuhs/Sc8q3lLnWusQ+ujEjb334itTAaYQNz7iphwA5PRf7IxBk3Jo+kMGEVnLQVvbl/48Bxzby/0QKsxlImHfu0TzVthub2u0pV3QavqmLAF4fb45UJaAvOMgQ+g+UaL/elRlTsqLuXa8vdC4mZOqyTxJjm6IuO82jtmSlCjQ8Pb27qvYxmkdjsfq6i2Dpdh5eUm+7X1UtXHoJcCGvZV7hAaN7R+0x9tgu756FXkvvOa8WPczVofPN4uRGVVxo7QShhpSmPOUPXr62a6syBe4pG4ZBEUfnlSCivSDUo/ZFvGPMSkkrJlnF/t3kSBcBoyhm8+Rx5gTc4YbbGmfL1ixzjxxsBFWBslA7XEi4D81Z2mWBNo87TvyJWjNn2tWoFH/bxzpdOmdUEZb6L+PRVomwDc3cBfAN0sKbwk5T8K1mcO5z4aAg4HEvASbifcjpIPNLjGQmacbpTqOsuKlf40FruovJN+SimVGyDYRSM7RnsvFSh1UyIDp+GtneOeUv
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:55:48.9566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7ba1ff-fee4-462e-a9a5-08dc5a1e5461
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Channels can potentially have independent mdev instances. Do not refer to
the global mdev instance in the mlx5e_priv instance for channel FW
operations related to coalescing. CQ numbers that would be valid on the
channel's mdev instance may not be correctly referenced if using the
mlx5e_priv instance.

Fixes: 67936e138586 ("net/mlx5e: Let channels be SD-aware")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 8f101181648c..67a29826bb57 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -589,12 +589,12 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
 static void
 mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
 {
-	struct mlx5_core_dev *mdev = priv->mdev;
 	int tc;
 	int i;
 
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
+		struct mlx5_core_dev *mdev = c->mdev;
 
 		for (tc = 0; tc < c->num_tc; tc++) {
 			mlx5_core_modify_cq_moderation(mdev,
@@ -608,11 +608,11 @@ mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
 static void
 mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
 {
-	struct mlx5_core_dev *mdev = priv->mdev;
 	int i;
 
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
+		struct mlx5_core_dev *mdev = c->mdev;
 
 		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
 					       coal->rx_coalesce_usecs,
-- 
2.44.0


