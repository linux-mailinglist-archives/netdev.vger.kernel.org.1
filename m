Return-Path: <netdev+bounces-42560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B53D7CF53A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0361C20F77
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E561DFC4;
	Thu, 19 Oct 2023 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPu8aufB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AD18B1D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2934121
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0xKS0YiIM/OaanGeG20UIo3GB1wo3xqJV0IHrwGGuigMwxM5QOpsU5Gjmt+YEzModfvub9zAK8eKomzLBtDMxfoUTKZupJ6OKlYmTperIi6IDxtdUkG3TUWlmCemhTd86UuJ3K2ZKSsJeqvA5IA4R+z05lxH4F1YfEOynNxVFmOlXceTK4sh7KRpXlxi6AlNrCHyVH+/w9u04f+j+t+MmB5vs+KJUeR10GrTJDrdeMF4jLVLDj+cvDnnl4C6vzt0xfVVr/Q/24+JhbB5bRqs8d3Iwwvi+pumGk2qIadYSKJfGgCOLmaFXhNYAurIy5errtrTMHFiQsCmldqQ9L4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er5kz+4kiYPPvIL/vCZCwpwCqvvcGrGXo7N8U820u/k=;
 b=PhZcNycGll1yH7eSVVDs6XFS66l66yJvgz10hdeCYqCRbKce8aOKvGluAUqKy8WzoI7RQiftD/TDVnNJRo0NuKBUQfOy6f+2GEKuofQ7VzIZAeIA7gEfd9QgfJL5dqrm4oMgFuefLdcXRyjhFd3yxg8JuZpogSiXI7PAYI/H92vei9hGxv+PbCEpPOo3s22b2lGAA3XD91aHAG4b572scUWi2EP6AHFUHR+x9zylgEMjtBLmUHtoKATtAKukxMVHvKBK+bzYypm5bb6sbja/wJY9y4eIT64ojpAoSeuCTaAL7ZGumclOz87h5y1WgP3Qlitg4gRhVZQMxyjncqQmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er5kz+4kiYPPvIL/vCZCwpwCqvvcGrGXo7N8U820u/k=;
 b=KPu8aufBkh7+3i5z4BUnka3qvwXmt/XUsYiuBZWlboQ3i4J80tTEJVRB9E0LAWts1vVUTXMGoJFQGTsWdFuoPxCPVU1nPmSOrOBjbSmm7U3NNdlF/Ez0Qq6rvzBkTcIuLKXMzAkGzA41GouBeZtpKlzUNo4QbeDTkTsa+lSHATkxUSKSxo6zx/Zcf4Gl0S8aUR5Td/7Xl1b4l4TSzjfZLErN35INw354yle3M2rQga3VGX8sGhXJCD2T1XQmrZFANpcbLr8vUm+C8ND8OZhhBUbo0AQrDp274TMA5AKjWTvuq29rYH4QUz+HbRmP4BliQ9sdwhKh6VAuOCKUdIKInA==
Received: from PH7PR17CA0056.namprd17.prod.outlook.com (2603:10b6:510:325::17)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 10:28:13 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::3) by PH7PR17CA0056.outlook.office365.com
 (2603:10b6:510:325::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 10:28:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:28:00 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 09/11] mlxsw: spectrum_pgt: Generalize PGT allocation
Date: Thu, 19 Oct 2023 12:27:18 +0200
Message-ID: <8d5298af7ccea1c2dc357eb288048f2cca63a3fa.1697710282.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f81c745-18de-41fa-0045-08dbd08e191b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zeoc9pWDHNPXsoCSiRFwVpxaLAdDtl6+i6UjRwmNS0i+jVnWdzDmiUZlweh4Lr9BBGQVOXfevuYVw/5aUDiDiQNL4Qr4mlFvwvQrrFFUU86Wgg06l5EzjriwC5SkNSCAEvhOVcDSNMZ+jJiZzm2bnBL2ZcWwL4vCgiaWa5JY6s1b1LY+OMksWB2nZmV3Ca4tomaYy7szelZ/2fo73Jl+tIGlv2/o0nx98TXl9cq0JRfGo11OA9EXSWpzRXknC1Tvnzu0TnVIk/O4p+f0/80957BNypqrl1u/mfTx3ziWmwcAsjrpHbB+WtkUPrzm+R3URkHVR0hMCkkW0rHuYRxKLwiIxkX+VZ/2PI5ZVN6tzm+NoYCQdadZCXAGmb9fM7JfTNOxh9BPoXjbE94IHXeZlNclwmeJQg+vKOy/vMjkw4vWq6ISFphdBWANZzYFZs77GNTg48QLnau4pVRAn8NDMq0lR2BIWdb23ZMmmWh7iDMzJa+0+5ClWzH+BoWc/25pVh0+3F48v0XjSiqf68VkRcCepcOs0OPnC1RUNDYRENSbgJg/BW4Rl5vhzUEEziCvQsl/YNWUpX30MmCrklTCQ6RwdWBUBlU7LTdgIbBKhAz/Y1cgQlhVaypb2cmHqnXtFSJjAuyCo6E9F/0aROwDIduNy2cCB+MKE+Lufph0pUWgX9AgAM+YvdsLy5IpzqfhmEBxUTmcpz/z6t6In4f1ABEpyJnaxmcBfyEXJ0ckUnL1iZxbDgI51sBE32gYzOLL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(41300700001)(36756003)(26005)(2906002)(336012)(2616005)(426003)(86362001)(4326008)(8676002)(8936002)(107886003)(16526019)(36860700001)(82740400003)(356005)(83380400001)(7636003)(47076005)(7696005)(6666004)(5660300002)(316002)(478600001)(110136005)(70586007)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:12.6627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f81c745-18de-41fa-0045-08dbd08e191b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

PGT blocks are allocated through the function
mlxsw_sp_pgt_mid_alloc_range(). The interface assumes that the caller knows
which piece of PGT exactly they want to get. That was fine while the FID
code was the only client allocating blocks of PGT. However for SW-allocated
LAG table, there will be an additional client: mlxsw_sp_lag_init(). The
interface should therefore be changed to not require particular
coordinates, but to take just the requested size, allocate the block
wherever, and give back the PGT address.

In this patch, change the interface accordingly. Initialize FID family's
pgt_base from the result of the PGT allocation (note that mlxsw makes a
copy of the family structure, so what gets initialized is not actually the
global structure). Drop the now-unnecessary pgt_base initializations and
the corresponding defines.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 +-
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    |  8 +-------
 .../ethernet/mellanox/mlxsw/spectrum_pgt.c    | 20 +++++--------------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 02ca2871b6f9..ac9d03937f4b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -1480,7 +1480,7 @@ int mlxsw_sp_policer_resources_register(struct mlxsw_core *mlxsw_core);
 /* spectrum_pgt.c */
 int mlxsw_sp_pgt_mid_alloc(struct mlxsw_sp *mlxsw_sp, u16 *p_mid);
 void mlxsw_sp_pgt_mid_free(struct mlxsw_sp *mlxsw_sp, u16 mid_base);
-int mlxsw_sp_pgt_mid_alloc_range(struct mlxsw_sp *mlxsw_sp, u16 mid_base,
+int mlxsw_sp_pgt_mid_alloc_range(struct mlxsw_sp *mlxsw_sp, u16 *mid_base,
 				 u16 count);
 void mlxsw_sp_pgt_mid_free_range(struct mlxsw_sp *mlxsw_sp, u16 mid_base,
 				 u16 count);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 4d0b72fbfebe..e954b8cd2ee8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -1076,8 +1076,6 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops = {
 
 #define MLXSW_SP_FID_8021Q_MAX (VLAN_N_VID - 2)
 #define MLXSW_SP_FID_RFID_MAX (11 * 1024)
-#define MLXSW_SP_FID_8021Q_PGT_BASE 0
-#define MLXSW_SP_FID_8021D_PGT_BASE (3 * MLXSW_SP_FID_8021Q_MAX)
 
 static const struct mlxsw_sp_flood_table mlxsw_sp_fid_8021d_flood_tables[] = {
 	{
@@ -1442,7 +1440,6 @@ static const struct mlxsw_sp_fid_family mlxsw_sp1_fid_8021q_family = {
 	.ops			= &mlxsw_sp_fid_8021q_ops,
 	.flood_rsp              = false,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_0,
-	.pgt_base		= MLXSW_SP_FID_8021Q_PGT_BASE,
 	.smpe_index_valid	= false,
 };
 
@@ -1456,7 +1453,6 @@ static const struct mlxsw_sp_fid_family mlxsw_sp1_fid_8021d_family = {
 	.rif_type		= MLXSW_SP_RIF_TYPE_FID,
 	.ops			= &mlxsw_sp_fid_8021d_ops,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_1,
-	.pgt_base		= MLXSW_SP_FID_8021D_PGT_BASE,
 	.smpe_index_valid       = false,
 };
 
@@ -1498,7 +1494,6 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021q_family = {
 	.ops			= &mlxsw_sp_fid_8021q_ops,
 	.flood_rsp              = false,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_0,
-	.pgt_base		= MLXSW_SP_FID_8021Q_PGT_BASE,
 	.smpe_index_valid	= true,
 };
 
@@ -1512,7 +1507,6 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021d_family = {
 	.rif_type		= MLXSW_SP_RIF_TYPE_FID,
 	.ops			= &mlxsw_sp_fid_8021d_ops,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_1,
-	.pgt_base		= MLXSW_SP_FID_8021D_PGT_BASE,
 	.smpe_index_valid       = true,
 };
 
@@ -1697,7 +1691,7 @@ mlxsw_sp_fid_flood_tables_init(struct mlxsw_sp_fid_family *fid_family)
 		return 0;
 
 	pgt_size = mlxsw_sp_fid_family_pgt_size(fid_family);
-	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, fid_family->pgt_base,
+	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, &fid_family->pgt_base,
 					   pgt_size);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_pgt.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_pgt.c
index 7dd3dba0fa83..4ef81bac17d6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_pgt.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_pgt.c
@@ -54,25 +54,15 @@ void mlxsw_sp_pgt_mid_free(struct mlxsw_sp *mlxsw_sp, u16 mid_base)
 	mutex_unlock(&mlxsw_sp->pgt->lock);
 }
 
-int
-mlxsw_sp_pgt_mid_alloc_range(struct mlxsw_sp *mlxsw_sp, u16 mid_base, u16 count)
+int mlxsw_sp_pgt_mid_alloc_range(struct mlxsw_sp *mlxsw_sp, u16 *p_mid_base,
+				 u16 count)
 {
-	unsigned int idr_cursor;
+	unsigned int mid_base;
 	int i, err;
 
 	mutex_lock(&mlxsw_sp->pgt->lock);
 
-	/* This function is supposed to be called several times as part of
-	 * driver init, in specific order. Verify that the mid_index is the
-	 * first free index in the idr, to be able to free the indexes in case
-	 * of error.
-	 */
-	idr_cursor = idr_get_cursor(&mlxsw_sp->pgt->pgt_idr);
-	if (WARN_ON(idr_cursor != mid_base)) {
-		err = -EINVAL;
-		goto err_idr_cursor;
-	}
-
+	mid_base = idr_get_cursor(&mlxsw_sp->pgt->pgt_idr);
 	for (i = 0; i < count; i++) {
 		err = idr_alloc_cyclic(&mlxsw_sp->pgt->pgt_idr, NULL,
 				       mid_base, mid_base + count, GFP_KERNEL);
@@ -81,12 +71,12 @@ mlxsw_sp_pgt_mid_alloc_range(struct mlxsw_sp *mlxsw_sp, u16 mid_base, u16 count)
 	}
 
 	mutex_unlock(&mlxsw_sp->pgt->lock);
+	*p_mid_base = mid_base;
 	return 0;
 
 err_idr_alloc_cyclic:
 	for (i--; i >= 0; i--)
 		idr_remove(&mlxsw_sp->pgt->pgt_idr, mid_base + i);
-err_idr_cursor:
 	mutex_unlock(&mlxsw_sp->pgt->lock);
 	return err;
 }
-- 
2.41.0


