Return-Path: <netdev+bounces-42563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95807CF540
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3152821D2
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC21DFEE;
	Thu, 19 Oct 2023 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8iV7avO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF01DFDF
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5801D137
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TorfpJlEGOZu8HbexuSt80Yz2EXHGu4Yq150ze2PFuRPn46B4/UA4U0TGRLaEYfB8l8/0eUMRIW1cGtl/Rqg8gILdrFvlig/xhkbwrhhalmEEZfFwLeWqd7lVDS6pEaXmczQtRu/APJjoMeyNqZpAzMUQnKPD8p3pLni3TxKiYijuuxwsc3aw82Q1+madEuyYD8rW8GNjlW3c8JnkTWxMwmkv7Tn5Z9Lt3nmMjnfz+Zk6Rx7J3xEY+bOfRWGDWWiSjGLR2kZsTMuBcKrNc+XdRtjrB77k1SU4VybirCSJHYvt6u4L7k+fGoYwZvLylBmX4YXqSEqWktJa7LPjlJYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT5X5c0WedwdwC1sTIFKNx0SSxek6p2c9G4WS0WGnrM=;
 b=ScAapOs+UMmPAvMxQZIfuFtXv6RGYrdibjFxG0g+32/UL2tshQZecYhwqnKNA8TBDCDna78gcn2kf/VMyFT50aScMfYHNG9JF3M1wX5v4AzquCQ7E6sdNdEdpy1wb5BGOCcetCmyHlywb6xYgCNIJ9MaA6JtTfv/9sqCqP8amd4psFJwVsGTwh8SxDeN9opYZ15mOFceUsAfZwpl671VmDQ6RHvtRAZM0T2JUoHevY5bXwczFZqVIfWt5drBSHaqthNVbdAGRaFS9Mp/u73RkWRHz5K89qCsXqs+wENYq+Yc3rp9It+bAC9vF2j6L6Q3mTDUhXsqrbe5AxQEIZCDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT5X5c0WedwdwC1sTIFKNx0SSxek6p2c9G4WS0WGnrM=;
 b=H8iV7avOOKvK+zr2VwJi5xegXpmjNzZ5rkI3b5eppkc0cRXsh43PK1XDgYPcXKKQF+ARnqbRFBMid6GGmoM0zidGt06AaF01IQt85wG6U3Cfb74WPdWwGYjLXaNAR3y0sOo0d5CgjIRCC6+IuQOhl+mj18HdE1q0s5jElNPleGVn6feJ3JGHoV29rPyizyXQU35gO3ijwpecy7f2Rxfi5M2jhy8lmKH4hnFpHKM8cK1VJGzeMMzzflvmec1o5XP+t44Apft1O70Pl8pCYiqQZvq1k+OcH4bJJd9GsnONItIvFn8rIK5SxAeZpVDFJ+FfN7KIOZ15RmIRK6UCuecIPQ==
Received: from MN2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:208:a8::30)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 10:28:19 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::d9) by MN2PR12CA0017.outlook.office365.com
 (2603:10b6:208:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 10:28:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:28:03 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:28:00 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 10/11] mlxsw: spectrum: Allocate LAG table when in SW LAG mode
Date: Thu, 19 Oct 2023 12:27:19 +0200
Message-ID: <741107f4bc32b6b0c7567a05d5f7a27427bb03ca.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
References: <cover.1697710282.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 3247313b-b7b4-45b6-5cb1-08dbd08e1ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P2a7yfKhBbs8qJ6M89tpTVtiJA3hMCwm44zcdlVpXV25nRy9+xM86CG7GNNYpoBzCvuYYbOTkEDuP0RnYE+iMNrIyR1p1WqXFoWhxdq1AwXnV0jz/DaWDUj47jWdNjjpg9ZYqXYfuK5o+HWFkQ/1VEglDUNgLIIfY9a0R5hKqAXVHBwbNaux7YUcUYo3qEbr4QjwVutIztuuVBppOv889YNcoQ3IGP5bxXL1RVBEnE6kbaz7jN43twmw6lgAynlvFO2WKQVXvYO7E/WKetgdOz+W69EFqtuK9ALinOH3grSKaef6Nr8TtJfMECKpjW6qBdvQr7i6rvPV0ItPk3Ib4QNqfZSNe2ZlplHYaeGVZswLqaJDG5Lhb8rJI1nmavsZnUs8sY6StDxHHZVNC+SaxcLTN19I/dhFg6efCmxYtvaDkC1z1L6FDuOazxWgeF2DSSwYDzwGuT4xbZ2C743ubkpdJn/Phf+o8MmlwX2s5skmKSXO0z0CRI3QuFdRKemQwywgSYo0UROzA53SR//l10ZmeHNkRgW1XpQLqlpuLIjPylO3Wus6x9GFkCFUc25f+Vhqj0KYANhjY74/N+MMpeHMUW7JAaoUXuX7jbQBB6eDOaABhmVTeHcifczjKctx/9EfcFc1busWoiJ0MoT1LzsQdIhFNlYoupHVgZkkuZX4oO+b4T5rB3WnRGy+OsxEnHtLES5cfuPrqaHejDMD4VLiQD579h7Y+1eLoePtnNhgLDasvAoVz3gFCq4V2rF/
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(46966006)(36840700001)(66899024)(86362001)(40460700003)(36756003)(40480700001)(41300700001)(4326008)(5660300002)(47076005)(8676002)(66574015)(2906002)(54906003)(316002)(83380400001)(110136005)(16526019)(70206006)(70586007)(36860700001)(478600001)(6666004)(7696005)(2616005)(26005)(426003)(82740400003)(336012)(8936002)(107886003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:18.5820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3247313b-b7b4-45b6-5cb1-08dbd08e1ca9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

In this patch, if the LAG mode is SW, allocate the LAG table and configure
SGCR to indicate where it was allocated.

We use the default "DDD" (for dynamic data duplication) layout of the LAG
table. In the DDD mode, the membership information for each LAG is copied
in 8 PGT entries. This is done for performance reasons. The LAG table then
needs to be allocated on an address aligned to 8. Deal with this by
moving the LAG init ahead so that the LAG table is allocated at address 0.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 93 ++++++++++++++++---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  1 +
 2 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 9dbd5edff0b0..d383d00dd860 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2692,6 +2692,63 @@ static void mlxsw_sp_traps_fini(struct mlxsw_sp *mlxsw_sp)
 	kfree(mlxsw_sp->trap);
 }
 
+static int mlxsw_sp_lag_pgt_init(struct mlxsw_sp *mlxsw_sp)
+{
+	char sgcr_pl[MLXSW_REG_SGCR_LEN];
+	u16 max_lag;
+	int err;
+
+	if (mlxsw_core_lag_mode(mlxsw_sp->core) !=
+	    MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_SW)
+		return 0;
+
+	err = mlxsw_core_max_lag(mlxsw_sp->core, &max_lag);
+	if (err)
+		return err;
+
+	/* In DDD mode, which we by default use, each LAG entry is 8 PGT
+	 * entries. The LAG table address needs to be 8-aligned, but that ought
+	 * to be the case, since the LAG table is allocated first.
+	 */
+	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, &mlxsw_sp->lag_pgt_base,
+					   max_lag * 8);
+	if (err)
+		return err;
+	if (WARN_ON_ONCE(mlxsw_sp->lag_pgt_base % 8)) {
+		err = -EINVAL;
+		goto err_mid_alloc_range;
+	}
+
+	mlxsw_reg_sgcr_pack(sgcr_pl, mlxsw_sp->lag_pgt_base);
+	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sgcr), sgcr_pl);
+	if (err)
+		goto err_mid_alloc_range;
+
+	return 0;
+
+err_mid_alloc_range:
+	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, mlxsw_sp->lag_pgt_base,
+				    max_lag * 8);
+	return err;
+}
+
+static void mlxsw_sp_lag_pgt_fini(struct mlxsw_sp *mlxsw_sp)
+{
+	u16 max_lag;
+	int err;
+
+	if (mlxsw_core_lag_mode(mlxsw_sp->core) !=
+	    MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_SW)
+		return;
+
+	err = mlxsw_core_max_lag(mlxsw_sp->core, &max_lag);
+	if (err)
+		return;
+
+	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, mlxsw_sp->lag_pgt_base,
+				    max_lag * 8);
+}
+
 #define MLXSW_SP_LAG_SEED_INIT 0xcafecafe
 
 static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
@@ -2723,16 +2780,27 @@ static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
 	if (!MLXSW_CORE_RES_VALID(mlxsw_sp->core, MAX_LAG_MEMBERS))
 		return -EIO;
 
+	err = mlxsw_sp_lag_pgt_init(mlxsw_sp);
+	if (err)
+		return err;
+
 	mlxsw_sp->lags = kcalloc(max_lag, sizeof(struct mlxsw_sp_upper),
 				 GFP_KERNEL);
-	if (!mlxsw_sp->lags)
-		return -ENOMEM;
+	if (!mlxsw_sp->lags) {
+		err = -ENOMEM;
+		goto err_kcalloc;
+	}
 
 	return 0;
+
+err_kcalloc:
+	mlxsw_sp_lag_pgt_fini(mlxsw_sp);
+	return err;
 }
 
 static void mlxsw_sp_lag_fini(struct mlxsw_sp *mlxsw_sp)
 {
+	mlxsw_sp_lag_pgt_fini(mlxsw_sp);
 	kfree(mlxsw_sp->lags);
 }
 
@@ -3113,6 +3181,15 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_pgt_init;
 	}
 
+	/* Initialize before FIDs so that the LAG table is at the start of PGT
+	 * and 8-aligned without overallocation.
+	 */
+	err = mlxsw_sp_lag_init(mlxsw_sp);
+	if (err) {
+		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize LAG\n");
+		goto err_lag_init;
+	}
+
 	err = mlxsw_sp_fids_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize FIDs\n");
@@ -3143,12 +3220,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_buffers_init;
 	}
 
-	err = mlxsw_sp_lag_init(mlxsw_sp);
-	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize LAG\n");
-		goto err_lag_init;
-	}
-
 	/* Initialize SPAN before router and switchdev, so that those components
 	 * can call mlxsw_sp_span_respin().
 	 */
@@ -3300,8 +3371,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_switchdev_init:
 	mlxsw_sp_span_fini(mlxsw_sp);
 err_span_init:
-	mlxsw_sp_lag_fini(mlxsw_sp);
-err_lag_init:
 	mlxsw_sp_buffers_fini(mlxsw_sp);
 err_buffers_init:
 	mlxsw_sp_devlink_traps_fini(mlxsw_sp);
@@ -3312,6 +3381,8 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_policers_init:
 	mlxsw_sp_fids_fini(mlxsw_sp);
 err_fids_init:
+	mlxsw_sp_lag_fini(mlxsw_sp);
+err_lag_init:
 	mlxsw_sp_pgt_fini(mlxsw_sp);
 err_pgt_init:
 	mlxsw_sp_kvdl_fini(mlxsw_sp);
@@ -3477,12 +3548,12 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 	mlxsw_sp_switchdev_fini(mlxsw_sp);
 	mlxsw_sp_span_fini(mlxsw_sp);
-	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_buffers_fini(mlxsw_sp);
 	mlxsw_sp_devlink_traps_fini(mlxsw_sp);
 	mlxsw_sp_traps_fini(mlxsw_sp);
 	mlxsw_sp_policers_fini(mlxsw_sp);
 	mlxsw_sp_fids_fini(mlxsw_sp);
+	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_pgt_fini(mlxsw_sp);
 	mlxsw_sp_kvdl_fini(mlxsw_sp);
 	mlxsw_sp_parsing_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index ac9d03937f4b..c70333b460ea 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -212,6 +212,7 @@ struct mlxsw_sp {
 	struct mutex ipv6_addr_ht_lock; /* Protects ipv6_addr_ht */
 	struct mlxsw_sp_pgt *pgt;
 	bool pgt_smpe_index_valid;
+	u16 lag_pgt_base;
 };
 
 struct mlxsw_sp_ptp_ops {
-- 
2.41.0


