Return-Path: <netdev+bounces-134910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31E99B8A8
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC91C20A7B
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3610135A79;
	Sun, 13 Oct 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwO8qHf6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5EE139580
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802028; cv=fail; b=CEp22YvOSM2pBXvI6AabMawLdT2Dxf6hYUQu7GxuI/+1yBHyPKXo1+3vfAVMbHUfUTi/H6UanLdQZMpiQl/xRNZdZP8Q76siVVZDJQG/msJxsAjSubSPD+Irw32NnqvhbX6hpDmuuQN8OdBJEDZbCmZajQq9SZFKxrSq/25t47M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802028; c=relaxed/simple;
	bh=3ndkomccHSzoxvPlj+dYmHnV35jwci+om0km4oZnWzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogihNktOcQeEQ+zHPwUIfY4Ds8c21R1KvDqqiKtE6CVoErtBjdL5XsOgrP8PWgvq4S4BAsBCo7KZlsAM3loB9TlJrtI3UGFTn9QepTc7hOUkEwppHBJaKS4fhAzx35Ult4g1D6vKKcraWGJ/WdrqBfumYgszh9h7fYDbAGXjL7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwO8qHf6; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJC6wWhRyAJMuVf6LfVR4m0d9Qxhx6rs6SmpiczjZvHFUz0goNaPSlA+WJKNBxhsmFk/6hB56wIfB4YbWxsIUhxlfkjvgNFBvz38lWe41nVR90fibuWYtt9vCP9nYdKz3LQV/8joBAlabEwT2Kr+y8CnS5BHMmAJk8+mdhWrvThjjHVm57W9Q35LRaDP79iD6lYk6Hm+3U5HzHcVK8cfGY5gvCzpNQ1xDvAYo9PU/npYt3efeOmpWIEEnYwkehgZK7ISFdZKY3nJW8swhK1WAxwHxQ6Kpq17SLBc2cdsjr2/fdz7Evvd9e0ZtqsucSzzuUqLsvIAgA4RCgds1Fwoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeYzfla2qMqlpadDr3MJ2Bc6hnipuwXYDrlL3CnlCo8=;
 b=rElElauNy+nbwVNLeDZTUijW+ky+IBpFmfysYI3Vubcwuq7Kd2hLlI62P0HjRgw8pN9roGuxwp5FwTVB3y3yXAZQ9Kbm2RXHHG16FXguFWg6XZh1M8HDPMSIU6jyom8vAnbAZbHEoRA5cB1ndZKJ0+1Dl/uw0RVRHRBMcCdk++NFcSCfZWBOZ1IL1OfZE98tl3iFKmYt+lq6F5eB7JB3NJIXNwLyrhypq0eOPUOYzHS/jAi3qeRreb9OcjdHir16gd2VxxvBBjdwVOwsa1lLx/5CfEwPpU9L0HAd86+4lQusFeSmzGzv4MZzz98e47sk14j/vjS6shPW8eumyvDc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeYzfla2qMqlpadDr3MJ2Bc6hnipuwXYDrlL3CnlCo8=;
 b=VwO8qHf6n/AChKKlWN5/QB46P2VECM6veu+6JYIVOSal/dwe8vnWsA8T8SA5jAmIssobq4FiWOpwGAzg0lMj3NRbVT/LR6Xkd7VAoSGchlQIe1mv24QGbRwWoYKaGIx26uuFZrtm/bIISEgrdDCOJYM7wiYQPFF43fd+2dOxKR4Euc9Ed+3tfNjMx7iXytRHZHbPonLJvG6krvK0lu0UErjhPAjPRwvLVoSPGNZ0nY5cmwsjMgRW7kNOr634z0HcoS5jrMHGTzL8q7vHDJrO3k89tJEovbF0gytk5cIDyvYzXR9lVtMztKKN6fjJjFuvz8NWwfx3i43VQt87La2JVg==
Received: from CH0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:b0::8)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 06:47:03 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::6b) by CH0PR03CA0003.outlook.office365.com
 (2603:10b6:610:b0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:47:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 13/15] net/mlx5: Only create VEPA flow table when in VEPA mode
Date: Sun, 13 Oct 2024 09:45:38 +0300
Message-ID: <20241013064540.170722-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e20eeb-e940-4bae-8cb4-08dceb52d83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+Xb722zmAwK5TYwLP3WDCU7pFoREhCibmy/+N+F6u7mC6b7DQaleIOONmZF?=
 =?us-ascii?Q?vQn0apeO1F6Xg2bnHFytcKm7p34UCorxvS4Hqi6MobBRMbzr66rexENTHLm3?=
 =?us-ascii?Q?lBizGDXlSYJlaRb1ZIJFKSG9nlnAaTyJitPQBC7UXSkk71Mm5vEazeWzQE9y?=
 =?us-ascii?Q?zRSAJQcAz7RG5uECTFakjCk0q0iFbalAvw8IL1GlFA/YKz/Y5hcUdNXgafPS?=
 =?us-ascii?Q?yeh0+9VB7UUq0j3Y981o8EkI9u2DXS3zi+2uy1ENYkgfGUlq/IflDissF+L1?=
 =?us-ascii?Q?Cm3UxzB8qWhqhRZeH31Ubgjq/Esx9P3QYrfBGQqstTXRH27IIZQb0cnBhcgj?=
 =?us-ascii?Q?Yf1SG19y00wAb1ZzX6Wqvj4MEeAFm+JUefXAOCEvCbYjPksjcTQYzzBjTuos?=
 =?us-ascii?Q?Y3g5268/RTcZOEBW+xGgsaUWN15oV5l9RqeQpM+wf2bB4mOBbAgHcD7VfT/d?=
 =?us-ascii?Q?bBlSXzrv62dRlYS11cuYmFDwWfI27qNzZDpF6zvT3nVUBcbeKXnaj+xNRUF/?=
 =?us-ascii?Q?+Ort9gqY4H0ZGWWz4KeDMJdY3QFNobKX70PjA9xoUm8XqbmuWDI2aCXyW0lF?=
 =?us-ascii?Q?7sef+4eJRPxoIVGAntpRWxTtJlDtQHhKiUFaCfRZYCNV73K/bCnafP9I9WAW?=
 =?us-ascii?Q?wq/KjfLrvobaxqvSvJh7hJZkSqvTjXxyxX1FEbs9vU+OlgaCnJH3F5jkqdbP?=
 =?us-ascii?Q?f7uqJ6XxaAhxEL3ZTI3b8XNP3f7KosIMXvCuf1x1UGRIPSRjieZ5jtSw/VP+?=
 =?us-ascii?Q?ekWbA7U0rIp0eTdqLO8AiDiEi+jsUTcf65PimKbeL6CoXLFseVlsgCsQSHQV?=
 =?us-ascii?Q?Wi8t4FaU0CcoqrHXR/ypIqoQagtJvAYG3wihALgX9KWcWdVIayWiXxy1eVzr?=
 =?us-ascii?Q?8YiCewU7bJyHG7BgHEanEro94x4Kwjquos30P5/dJHPgdMehTp0gotTuyFXH?=
 =?us-ascii?Q?U3fClrb4EqORdHdnVvcjfepQ5/UO6wV143j5wF/a47LnU3pSHLaTgNnYZYUn?=
 =?us-ascii?Q?bEFedX4xbO6uGDDmdwoiuWXfhznclwO19gP3fxkbcHm6Z+LGArtySMXuLAgP?=
 =?us-ascii?Q?PW3N52CHhfvdvTIAJEwJDwa3tQjxk21rjYnzGUt/blM/8We5ulqb2gcDCgHf?=
 =?us-ascii?Q?HJzuaL1xOMkFvESCUhXE/ubQMyFGPJHClMWvAottaQgV98tVsNwXyshQm1J5?=
 =?us-ascii?Q?8YRbKBTsS0iWEp7tQEcueSnib5sCPs2RXBuI5Ih6GrNfSnjTVuJMFZ5WLDYS?=
 =?us-ascii?Q?gXDF3IfB/ZULAjDy6rZnroaU9q+8jm2APZjS+wxhB4t9ZJKaMs00O2AyOH58?=
 =?us-ascii?Q?q+tHePri6ngpQ9GdY+Z9Gr2J3ZGstUsVNd/3/ee7eE4y1zatX3M5n2cOEWEz?=
 =?us-ascii?Q?TYX0HzV2khwTkNr8erbJY3riOeXW?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:47:02.6275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e20eeb-e940-4bae-8cb4-08dceb52d83d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

From: Benjamin Poirier <bpoirier@nvidia.com>

Currently, when VFs are created, two flow tables are added for the eswitch:
the "fdb" table, which contains rules for each VF and the "vepa_fdb" table.
In the default VEB mode, the vepa_fdb table is empty. When switching to
VEPA mode, flow steering rules are added to vepa_fdb. Even though the
vepa_fdb table is empty in VEB mode, its presence adds some cost to packet
processing. In some workloads, this leads to drops which are reported by
the rx_discards_phy ethtool counter.

In order to improve performance, only create vepa_fdb when in VEPA mode.

Tests were done on a ConnectX-6 Lx adapter forwarding 64B packets between
both ports using dpdk-testpmd. Numbers are Rx-pps for each port, as
reported by testpmd.

Without changes:
traffic to unknown mac
	testpmd on PF
		numvfs=0,0
			35257998,35264499
		numvfs=1,1
			24590124,24590888
	testpmd on VF with numvfs=1,1
		20434338,20434887
traffic to VF mac
	testpmd on VF with numvfs=1,1
		30341014,30340749

With changes:
traffic to unknown mac
	testpmd on PF
		numvfs=0,0
			35404361,35383378
		numvfs=1,1
			29801247,29790757
	testpmd on VF with numvfs=1,1
		24310435,24309084
traffic to VF mac
	testpmd on VF with numvfs=1,1
		34811436,34781706

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/legacy.c  | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 288c797e4a78..45183de424f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -176,20 +176,10 @@ static void esw_destroy_legacy_vepa_table(struct mlx5_eswitch *esw)
 
 static int esw_create_legacy_table(struct mlx5_eswitch *esw)
 {
-	int err;
-
 	memset(&esw->fdb_table.legacy, 0, sizeof(struct legacy_fdb));
 	atomic64_set(&esw->user_count, 0);
 
-	err = esw_create_legacy_vepa_table(esw);
-	if (err)
-		return err;
-
-	err = esw_create_legacy_fdb_table(esw);
-	if (err)
-		esw_destroy_legacy_vepa_table(esw);
-
-	return err;
+	return esw_create_legacy_fdb_table(esw);
 }
 
 static void esw_cleanup_vepa_rules(struct mlx5_eswitch *esw)
@@ -259,15 +249,22 @@ static int _mlx5_eswitch_set_vepa_locked(struct mlx5_eswitch *esw,
 
 	if (!setting) {
 		esw_cleanup_vepa_rules(esw);
+		esw_destroy_legacy_vepa_table(esw);
 		return 0;
 	}
 
 	if (esw->fdb_table.legacy.vepa_uplink_rule)
 		return 0;
 
+	err = esw_create_legacy_vepa_table(esw);
+	if (err)
+		return err;
+
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
+	if (!spec) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	/* Uplink rule forward uplink traffic to FDB */
 	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters);
@@ -303,8 +300,10 @@ static int _mlx5_eswitch_set_vepa_locked(struct mlx5_eswitch *esw,
 
 out:
 	kvfree(spec);
-	if (err)
+	if (err) {
 		esw_cleanup_vepa_rules(esw);
+		esw_destroy_legacy_vepa_table(esw);
+	}
 	return err;
 }
 
-- 
2.44.0


