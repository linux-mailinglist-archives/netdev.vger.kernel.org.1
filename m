Return-Path: <netdev+bounces-78736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32838764A4
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59B71C20BF1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CAE1CFB6;
	Fri,  8 Mar 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IUyXo2t6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481711D547
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902982; cv=fail; b=kb1VmS85XkPZ4XB/XYZXpWfp3OYUBp3Hsp8ZOvmRL59Ao6yDwctynVByYfRxiC0D2V6xDidIk1az9MouwWOVXL5SimdLErESyZlarxryP4gwNVPE1Fh5eYHzeAhJsCw5e3rJ9C4K+Lv3IAHwQ6r+qWSc/GVKaigiBMeddSX4rrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902982; c=relaxed/simple;
	bh=Uheps32TVFKxxEyrpyTpcK/skwowJQehhEyZczsXNQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+gGcc2EoDLGb/nqUid4tWWQ+9lG7O7rWqa5Xet4c3tiPtqJbtj1fV9Y+MsMD8QumCBurac/WPsnpTJCS62mzcGu9a5YN/95sMFQApLdrC9WeVr2O6CfR8GGM0s0A39GXhzngFvbqD6fhMPO1LgNsuSs0iTcRyoy20aZtAPr0TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IUyXo2t6; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j23EA5Tud6qAdhdqfitSkkB+Z915SRThMk0GU52FaBnBE92zt3BqI/wWj6JR4N6STDoVDvsSYu/4wEXHoBSTFrST2hTcEYnukH5NKEPWDxQA1N8l/Hkj5P85Idr1FgGfotW34C+/GGzjmRD6UUqwfcLIdhmlqeobTv0wDluTBeyPsP7BQNZMr1faQvOGUB6BMj62BCSYQSeyJAaqlAR6ClJcrQuYNyCEes037NHkMlkV1KrFHXvB5x192oO88GVb4CFyzwGaz3jOwbVIdOmKQ/Yr9hH0gAQXwzf7jkPb7Y/qjwlHXqXT5ph7hKHE29JNhGLQYua4NXhvlKpdSO5uPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNTMt16pv4ook8Z67tdJNDA5EiJYrtftRFdqhSfRzPI=;
 b=dv+4c4fGw7fSY3cbVVBtzBcbi9xv9yBVmctRmvGoQUN5f+Fz1aN0C1e9fImdI3JLeve+3/a6f2PO8OMbdNaMRvxMu+pOuOQOARn1NNL+hJP2khe0cTfszkdoLB7wPaDTReIx1OaRQc61QstqNNze/MQ4wi/oM+IHAXe80OTwxD8X641ALVMtcN295P+tpAggF/3jIM1DlhwO3uUxS4QcwjR4D5Fb5vTd23cV+Sy10ngfRPDLqOmdrxQ7FNGbwKohnVtMdqq6nsoRmEPu0iRl//VCuiw9l2ThJEPTiqaqT50J34Z6uwQKA4zq+q6C7L5V//rgLf170e7zpB+7rdY3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNTMt16pv4ook8Z67tdJNDA5EiJYrtftRFdqhSfRzPI=;
 b=IUyXo2t6zjlDFRpVgfztnqsrXb2r1TQXukJOAar+XJ3lwis50hNWny7qc7mxaZutkS/SyH8jANNhjBMqE/RKGBr8Hc2LVqoJu2qMbyRJ6p1qgpQXH7eBo23neb2VmPG0W84LlfauIBx6JyDcGq+zrY4vQqKv+Ftjd6VIcd//PRLg0BblWqTTjiV+vamDzoVf5kJ9nlRqTiXzj+TN1MCnIp5eOmoDF9RkAffmSSUlBUsFQzELy0BpJ5YDvv1cUbK6Owp4OInI2PCW9tRZmoXtY9pdYjH6WOgq9dQ3/ThLyhQBxSGiH/FvcnWXJ0Q6OlfnHyL8d2uhBADnteMb2O5jYg==
Received: from BN9PR03CA0610.namprd03.prod.outlook.com (2603:10b6:408:106::15)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 13:02:53 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::d8) by BN9PR03CA0610.outlook.office365.com
 (2603:10b6:408:106::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 13:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:02:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:32 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:27 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 03/11] mlxsw: spectrum_router: Rename two functions
Date: Fri, 8 Mar 2024 13:59:47 +0100
Message-ID: <f59272958697a718f090f59f892d32beabcd8972.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cc4e7c-96d7-4901-5024-08dc3f701086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lPZ1921qBQwLSu2dNXEPOAF351CJz0Y1K3IRdA2K+XAIfnelkrKJyDjRtYdPAb6p5kOjrstrwylhgpp8GhNVUDr2HAwOX2YRRaDZHNCGfDMdhbNj9i9wtxaB/mGAqhMhZbN2DnV97tiquEOw/+GYbXItWu4BUsN40TyJ+NWmSVsN6GGUX36Si9UKdAvPtQ+1HIWcpGn6r05U/BhmQJlm1ZBnUv72au+lE8ex3K2jiAhEJWN4TfvXaY2MLxNZZyKu9pmQiE/nLIliyAFqUVmeNw4ZiHBBiso53lCoi2LDinMGCJIQQ89/It+L3549hwXXxWPAOulare/Z3AOJEh0SJtI1+ghdXP4D526vmX7tKA1lk0+L8PsrhdPlygCWGZWakGaaV/7Cq2eEZ4sSSKflH7oua3DMtnnwaZUsx7PbU6Wcn880qTLckL2AQMvvoQdObATJICBUsNCF3PL1QCBp7Ofthsa6JKll8wwPmn/KyIIPpjK95ADozi84SuaZYywfYrVKTB4eLU75nO46cBtVay7cyLbdE2pWgqPhAZyKmoPaoZRht4lJB2fXTDHsDoJeZm1czdup8R5q5ku3iUgpCjrBCcg0u7Iizlio9G8S2x+y4NSgC94gBV4SQTb/GRbC1TCkQ+aYn7pOKWLDWh8lMOrhH+qKDWwZXMiKZpPrcLlnaPDPI+4Np0ajttrItusEbqYfzGuBmpqtE9Tqt3V40RELIzolYyO/ZXwYYJenWLTgETJdxZ/07nOOZiiP5611
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:02:52.3861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cc4e7c-96d7-4901-5024-08dc3f701086
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

The function mlxsw_sp_nexthop_counter_alloc() doesn't directly allocate
anything, and mlxsw_sp_nexthop_counter_free() doesn't directly free. For
the following patches, we will need names for functions that actually do
those things. Therefore rename to mlxsw_sp_nexthop_counter_enable() and
mlxsw_sp_nexthop_counter_disable() to free up the namespace.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_dpipe.c  |  4 +--
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 26 +++++++++----------
 .../ethernet/mellanox/mlxsw/spectrum_router.h |  8 +++---
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
index c8a356accdf8..22e3dcb1d67a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
@@ -1193,9 +1193,9 @@ static int mlxsw_sp_dpipe_table_adj_counters_update(void *priv, bool enable)
 		mlxsw_sp_nexthop_indexes(nh, &adj_index, &adj_size,
 					 &adj_hash_index);
 		if (enable)
-			mlxsw_sp_nexthop_counter_alloc(mlxsw_sp, nh);
+			mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
 		else
-			mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh);
+			mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 		mlxsw_sp_nexthop_eth_update(mlxsw_sp,
 					    adj_index + adj_hash_index, nh,
 					    true, ratr_pl);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 87617df694ab..9bb58fb0d1da 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3151,8 +3151,8 @@ struct mlxsw_sp_nexthop_group {
 	bool can_destroy;
 };
 
-void mlxsw_sp_nexthop_counter_alloc(struct mlxsw_sp *mlxsw_sp,
-				    struct mlxsw_sp_nexthop *nh)
+void mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
+				     struct mlxsw_sp_nexthop *nh)
 {
 	struct devlink *devlink;
 
@@ -3167,8 +3167,8 @@ void mlxsw_sp_nexthop_counter_alloc(struct mlxsw_sp *mlxsw_sp,
 	nh->counter_valid = true;
 }
 
-void mlxsw_sp_nexthop_counter_free(struct mlxsw_sp *mlxsw_sp,
-				   struct mlxsw_sp_nexthop *nh)
+void mlxsw_sp_nexthop_counter_disable(struct mlxsw_sp *mlxsw_sp,
+				      struct mlxsw_sp_nexthop *nh)
 {
 	if (!nh->counter_valid)
 		return;
@@ -4507,7 +4507,7 @@ static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		return err;
 
-	mlxsw_sp_nexthop_counter_alloc(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
 	list_add_tail(&nh->router_list_node, &mlxsw_sp->router->nexthop_list);
 
 	if (!dev)
@@ -4531,7 +4531,7 @@ static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
 
 err_nexthop_neigh_init:
 	list_del(&nh->router_list_node);
-	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 	mlxsw_sp_nexthop_remove(mlxsw_sp, nh);
 	return err;
 }
@@ -4541,7 +4541,7 @@ static void mlxsw_sp_nexthop4_fini(struct mlxsw_sp *mlxsw_sp,
 {
 	mlxsw_sp_nexthop_type_fini(mlxsw_sp, nh);
 	list_del(&nh->router_list_node);
-	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 	mlxsw_sp_nexthop_remove(mlxsw_sp, nh);
 }
 
@@ -5006,7 +5006,7 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 		break;
 	}
 
-	mlxsw_sp_nexthop_counter_alloc(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
 	list_add_tail(&nh->router_list_node, &mlxsw_sp->router->nexthop_list);
 	nh->ifindex = dev->ifindex;
 
@@ -5030,7 +5030,7 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 
 err_type_init:
 	list_del(&nh->router_list_node);
-	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 	return err;
 }
 
@@ -5041,7 +5041,7 @@ static void mlxsw_sp_nexthop_obj_fini(struct mlxsw_sp *mlxsw_sp,
 		mlxsw_sp_nexthop_obj_blackhole_fini(mlxsw_sp, nh);
 	mlxsw_sp_nexthop_type_fini(mlxsw_sp, nh);
 	list_del(&nh->router_list_node);
-	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 	nh->should_offload = 0;
 }
 
@@ -6734,7 +6734,7 @@ static int mlxsw_sp_nexthop6_init(struct mlxsw_sp *mlxsw_sp,
 #if IS_ENABLED(CONFIG_IPV6)
 	nh->neigh_tbl = &nd_tbl;
 #endif
-	mlxsw_sp_nexthop_counter_alloc(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
 
 	list_add_tail(&nh->router_list_node, &mlxsw_sp->router->nexthop_list);
 
@@ -6750,7 +6750,7 @@ static int mlxsw_sp_nexthop6_init(struct mlxsw_sp *mlxsw_sp,
 
 err_nexthop_type_init:
 	list_del(&nh->router_list_node);
-	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 	return err;
 }
 
@@ -6759,7 +6759,7 @@ static void mlxsw_sp_nexthop6_fini(struct mlxsw_sp *mlxsw_sp,
 {
 	mlxsw_sp_nexthop_type_fini(mlxsw_sp, nh);
 	list_del(&nh->router_list_node);
-	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 }
 
 static bool mlxsw_sp_rt6_is_gateway(const struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index ed3b628caafe..bc5894c405a6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -156,10 +156,10 @@ int mlxsw_sp_nexthop_counter_get(struct mlxsw_sp *mlxsw_sp,
 int mlxsw_sp_nexthop_eth_update(struct mlxsw_sp *mlxsw_sp, u32 adj_index,
 				struct mlxsw_sp_nexthop *nh, bool force,
 				char *ratr_pl);
-void mlxsw_sp_nexthop_counter_alloc(struct mlxsw_sp *mlxsw_sp,
-				    struct mlxsw_sp_nexthop *nh);
-void mlxsw_sp_nexthop_counter_free(struct mlxsw_sp *mlxsw_sp,
-				   struct mlxsw_sp_nexthop *nh);
+void mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
+				     struct mlxsw_sp_nexthop *nh);
+void mlxsw_sp_nexthop_counter_disable(struct mlxsw_sp *mlxsw_sp,
+				      struct mlxsw_sp_nexthop *nh);
 
 static inline bool mlxsw_sp_l3addr_eq(const union mlxsw_sp_l3addr *addr1,
 				      const union mlxsw_sp_l3addr *addr2)
-- 
2.43.0


