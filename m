Return-Path: <netdev+bounces-78742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590DB8764AC
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68B81F22862
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57038387;
	Fri,  8 Mar 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJjNcy3b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93636AF8
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902999; cv=fail; b=W6UmeD9oBC1x5WaizXXWzjqz8Ps9VXfA7d5VgBhYzq0Cnrz72+92XT4SNWe5nMmPfcd3oKa+3mcePflkuhlmorUf37XSAfWCXzjQoy0BeE0aTx+U6CntJUAH6OR6IbDwF3i78bcAXJk7Zvf3V6G+lqRuTB+oAUNv9To/L+ET0U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902999; c=relaxed/simple;
	bh=JeRijEx23Ns1L/7q4wfOrIBd/3s2+2IlWxsCVjMTBPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwkQEVgwJmiBXdDUs38+JrI3mGurt666KH1wjwKQJRN3lOdbDrbyNT4piL2aZo25FxVD424E7JS+IDptqt5cUFhJAmayYKyVal3ppqdlv0vRgol+O3n2XuG3Snyl14DqmyWEfeobPZcVSPyXwpvIzLW9w+4PzCQlsBa9/njdBm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJjNcy3b; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fni+v4Yhw0EAaCVaefDymmusY2LaYBHVMEu8BX4qZG3FPlwVHr5jBSemTp8Uks7Ne60O72oz9MR+Z8+la28pnoMIFhvYQuUCMYwFozAsZ7gI9ZlulI9fEccg1GBhxvMq8snG+VdbqlodK0i96nO/9K52lUvzmNEuhPNWeNdgrnBylt+OYl19+gjQMSmUK2IGfmHzyp/9YoCOiHU3mg9mnIgM/UDnUt1PawkhgQFQVxWw8YOtHX5Elf9RwFG2XFuxorjupR9C2Nw7lakIjSoLj4wg59Q0p7cTaMYaSKBmpCIynIRPsbIgY3dx3PDK94otiyqpD2yZobenfubPo6bjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0DzTKuvVpMpdluGl4yL3+ZafZmGGyQYoiOrKx9hZek=;
 b=nZ6yrGGWpgs2i5UI/+qPAlA/UU7LtWsEmFMBKZdKABedcKapA5LwDX4gkTJ2NF493fHavGP2/YGD4ql5DR9MDQ5V00529ZXNnbKw6ZtkGSJCAH3W2MV4jS+RHUIWuL8cIU/x/VnYF8+C8BCwF/993PYaWhLEbqq8IQvDKOs04BtkqlDkmSYIYlfuf258KzUqxqy0fOBQfcEKfF9YxTvhvv0RRVfJS2N8p58vrxrKBLu4BEUhrkxVDgZqdt6gAmV/AC1lnItJgrCMoLkW1UKevjJSTHWZRNR9yTKM3+BEzIRdDI6m9BJhPdaEgHp3zGnrT0/gmlbozHHVzJ7bSomK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0DzTKuvVpMpdluGl4yL3+ZafZmGGyQYoiOrKx9hZek=;
 b=mJjNcy3bh+QPEh8sHBjYUe1p85+wsSBTe6ldred8Q2Gu3zGalEb3TICeeBXsinMauVMnJw+f8KMjeCBWvJIB/nDMjnCLFGX3W41luX/4gaRjp90SILkk7x35utL87pi8pZUfj45wmlWdKw8rFE4VYTETSw7yDAJS4zQPiPvdcxzciSjRlUH4QVzLl3H4wtbi9FRgWFNhzq8OpqtYWNiOKTerpYIgOmWLZDUXvPQyJyFyDsSy7UqT715aKWlKnmo6hOnvtXfZp35JHte3rMnJMpMai9GJHHm/liZ7ZY7YP9iynMtzzXk9TtadbMAdJbUYtv7dK0IC5plxzdjTbs50Cw==
Received: from DS7PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:3bb::32)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 13:03:14 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::20) by DS7PR03CA0087.outlook.office365.com
 (2603:10b6:5:3bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 13:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Fri, 8 Mar 2024 13:03:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:03:00 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 09/11] mlxsw: spectrum_router: Support nexthop group hardware statistics
Date: Fri, 8 Mar 2024 13:59:53 +0100
Message-ID: <87495a72f187df2e5d491d02729c550d235fcc85.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SN7PR12MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe3a586-62dc-4392-4c52-08dc3f701dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	62s9xla5JnfYQmuaF9CSLypm6NOgxNgTflxkeOsUHHZfUE/E9wWcyCuLRCo8BhpMV9bTlWB4gooM+kTWYt1sP4q2sEP4Nn6ieOu1S5/KgeM86pJXtqx9I8m95QVUiLC8t2FqlI7ETcVXn3DKbvsdf091HCJdCjSmQ8842oMyvcqUx8I9CJB6Bv9P1UT0l7keV72ZzkPEkACWf64H8lxWQPoNokbmX6E7n9hhyWk4PD56BVJEOSVwC6VUubs8UUBYstAlyTO2EkGcJ/0QsdQg1yEHXUUe0YlRx0kSGOGG8DzhQwj+5S0oEu5jdJJ523Ie1Zi4RqBzSCun6ARILvGNC6OK2p+ctHFo5/EjIgvrBWjdtrGhsgL97CnXztiC1yaLwxfTz43zrhzX59g28N5nV9qWaNGRdjnfiHaN2SK58wjSHGQtc9Rw2vfmySRmzoqOxTrGLoPkPe8rdXZ5DdMlwGvwz8UBeaeevqWEL+PXTiyzejAxBdkHek1pefgjr+q9uEbeuxxMox4HBpbeZOeFh1rzXI/zlx3aZNkJEGdgUbk11RXBTX0hr6Dg4cUcnnokd1CfbygfWNMT5jpHKa+bS+QBYm46YT3MAa9Vw7mKpSdbrb2SA8FFZe0xnQ3tK5NXFVk2AGrIIwD7CnwvsZLlAb6rYlXq10iCrQ8DohwVgkpLX9m2ytCbiByXBVp3geDOcjOeyDSsGmxd+YA8MGv9bss+N0n0Nx1nXxaRDOyM6pOp9gyBGPkJ6f+T1MD+Ji1Y
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:03:14.7020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe3a586-62dc-4392-4c52-08dc3f701dcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433

When hw_stats is set on a group, install nexthop counters on members of a
group.

Counter allocation request is moved from nexthop object initialization to
the update code. The previous placement made sense: when the counters are
enabled by dpipe, the counters are installed to all existing nexthops and
all nexthops created from then on get them. For the finer-grained nexthop
group statistics, this is unsuitable. The existing placement was kept for
the IPv4 and IPv6 nexthops.

Resilient group replacement emits a pre_replace notification, and then any
bucket_replace notifications if there were any replacements at all. If the
group is balanced and the nexthop composition of the replaced group didn't
change, there will be no such notifiers. Therefore hook to the pre_replace
notifier and mark all buckets for update, to un/install the counters.

When reporting deltas for resilient groups, use the nexthop ID that we
stored in a previous patch to look up to which nexthop a bucket
contributes.

Co-developed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 148 +++++++++++++++++-
 1 file changed, 142 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 922dcd9c0b5a..93ead5ccf864 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3108,7 +3108,8 @@ struct mlxsw_sp_nexthop_group_info {
 	int sum_norm_weight;
 	u8 adj_index_valid:1,
 	   gateway:1, /* routes using the group use a gateway */
-	   is_resilient:1;
+	   is_resilient:1,
+	   hw_stats:1;
 	struct list_head list; /* member in nh_res_grp_list */
 	struct mlxsw_sp_nexthop nexthops[] __counted_by(count);
 };
@@ -3189,15 +3190,17 @@ mlxsw_sp_nexthop_counter_free(struct mlxsw_sp *mlxsw_sp,
 int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_nexthop *nh)
 {
+	const char *table_adj = MLXSW_SP_DPIPE_TABLE_NAME_ADJ;
 	struct mlxsw_sp_nexthop_counter *nhct;
 	struct devlink *devlink;
+	bool dpipe_stats;
 
 	if (nh->counter)
 		return 0;
 
 	devlink = priv_to_devlink(mlxsw_sp->core);
-	if (!devlink_dpipe_table_counter_enabled(devlink,
-						 MLXSW_SP_DPIPE_TABLE_NAME_ADJ))
+	dpipe_stats = devlink_dpipe_table_counter_enabled(devlink, table_adj);
+	if (!(nh->nhgi->hw_stats || dpipe_stats))
 		return 0;
 
 	nhct = mlxsw_sp_nexthop_counter_alloc(mlxsw_sp);
@@ -3217,6 +3220,15 @@ void mlxsw_sp_nexthop_counter_disable(struct mlxsw_sp *mlxsw_sp,
 	nh->counter = NULL;
 }
 
+static int mlxsw_sp_nexthop_counter_update(struct mlxsw_sp *mlxsw_sp,
+					   struct mlxsw_sp_nexthop *nh)
+{
+	if (nh->nhgi->hw_stats)
+		return mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
+	return 0;
+}
+
 int mlxsw_sp_nexthop_counter_get(struct mlxsw_sp *mlxsw_sp,
 				 struct mlxsw_sp_nexthop *nh, u64 *p_counter)
 {
@@ -3224,7 +3236,7 @@ int mlxsw_sp_nexthop_counter_get(struct mlxsw_sp *mlxsw_sp,
 		return -EINVAL;
 
 	return mlxsw_sp_flow_counter_get(mlxsw_sp, nh->counter->counter_index,
-					 false, p_counter, NULL);
+					 true, p_counter, NULL);
 }
 
 struct mlxsw_sp_nexthop *mlxsw_sp_nexthop_next(struct mlxsw_sp_router *router,
@@ -3786,6 +3798,7 @@ mlxsw_sp_nexthop_group_update(struct mlxsw_sp *mlxsw_sp,
 		nh = &nhgi->nexthops[i];
 
 		if (!nh->should_offload) {
+			mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 			nh->offloaded = 0;
 			continue;
 		}
@@ -3793,6 +3806,10 @@ mlxsw_sp_nexthop_group_update(struct mlxsw_sp *mlxsw_sp,
 		if (nh->update || reallocate) {
 			int err = 0;
 
+			err = mlxsw_sp_nexthop_counter_update(mlxsw_sp, nh);
+			if (err)
+				return err;
+
 			err = mlxsw_sp_nexthop_update(mlxsw_sp, adj_index, nh,
 						      true, ratr_pl);
 			if (err)
@@ -5052,7 +5069,6 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 		break;
 	}
 
-	mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
 	list_add_tail(&nh->router_list_node, &mlxsw_sp->router->nexthop_list);
 	nh->ifindex = dev->ifindex;
 	nh->id = nh_obj->id;
@@ -5077,7 +5093,6 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 
 err_type_init:
 	list_del(&nh->router_list_node);
-	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
 	return err;
 }
 
@@ -5100,6 +5115,7 @@ mlxsw_sp_nexthop_obj_group_info_init(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_nexthop_group_info *nhgi;
 	struct mlxsw_sp_nexthop *nh;
 	bool is_resilient = false;
+	bool hw_stats = false;
 	unsigned int nhs;
 	int err, i;
 
@@ -5109,9 +5125,11 @@ mlxsw_sp_nexthop_obj_group_info_init(struct mlxsw_sp *mlxsw_sp,
 		break;
 	case NH_NOTIFIER_INFO_TYPE_GRP:
 		nhs = info->nh_grp->num_nh;
+		hw_stats = info->nh_grp->hw_stats;
 		break;
 	case NH_NOTIFIER_INFO_TYPE_RES_TABLE:
 		nhs = info->nh_res_table->num_nh_buckets;
+		hw_stats = info->nh_res_table->hw_stats;
 		is_resilient = true;
 		break;
 	default:
@@ -5126,6 +5144,7 @@ mlxsw_sp_nexthop_obj_group_info_init(struct mlxsw_sp *mlxsw_sp,
 	nhgi->gateway = mlxsw_sp_nexthop_obj_is_gateway(mlxsw_sp, info);
 	nhgi->is_resilient = is_resilient;
 	nhgi->count = nhs;
+	nhgi->hw_stats = hw_stats;
 	for (i = 0; i < nhgi->count; i++) {
 		struct nh_notifier_single_info *nh_obj;
 		int weight;
@@ -5347,6 +5366,43 @@ mlxsw_sp_nexthop_obj_group_replace(struct mlxsw_sp *mlxsw_sp,
 	return err;
 }
 
+static int mlxsw_sp_nexthop_obj_res_group_pre(struct mlxsw_sp *mlxsw_sp,
+					      struct nh_notifier_info *info)
+{
+	struct nh_notifier_grp_info *grp_info = info->nh_grp;
+	struct mlxsw_sp_nexthop_group_info *nhgi;
+	struct mlxsw_sp_nexthop_group *nh_grp;
+	int err;
+	int i;
+
+	nh_grp = mlxsw_sp_nexthop_obj_group_lookup(mlxsw_sp, info->id);
+	if (!nh_grp)
+		return 0;
+	nhgi = nh_grp->nhgi;
+
+	if (nhgi->hw_stats == grp_info->hw_stats)
+		return 0;
+
+	nhgi->hw_stats = grp_info->hw_stats;
+
+	for (i = 0; i < nhgi->count; i++) {
+		struct mlxsw_sp_nexthop *nh = &nhgi->nexthops[i];
+
+		if (nh->offloaded)
+			nh->update = 1;
+	}
+
+	err = mlxsw_sp_nexthop_group_refresh(mlxsw_sp, nh_grp);
+	if (err)
+		goto err_group_refresh;
+
+	return 0;
+
+err_group_refresh:
+	nhgi->hw_stats = !grp_info->hw_stats;
+	return err;
+}
+
 static int mlxsw_sp_nexthop_obj_new(struct mlxsw_sp *mlxsw_sp,
 				    struct nh_notifier_info *info)
 {
@@ -5523,6 +5579,79 @@ static int mlxsw_sp_nexthop_obj_bucket_replace(struct mlxsw_sp *mlxsw_sp,
 	return err;
 }
 
+static void
+mlxsw_sp_nexthop_obj_mp_hw_stats_get(struct mlxsw_sp *mlxsw_sp,
+				     struct mlxsw_sp_nexthop_group_info *nhgi,
+				     struct nh_notifier_grp_hw_stats_info *info)
+{
+	int nhi;
+
+	for (nhi = 0; nhi < info->num_nh; nhi++) {
+		struct mlxsw_sp_nexthop *nh = &nhgi->nexthops[nhi];
+		u64 packets;
+		int err;
+
+		err = mlxsw_sp_nexthop_counter_get(mlxsw_sp, nh, &packets);
+		if (err)
+			continue;
+
+		nh_grp_hw_stats_report_delta(info, nhi, packets);
+	}
+}
+
+static void
+mlxsw_sp_nexthop_obj_res_hw_stats_get(struct mlxsw_sp *mlxsw_sp,
+				      struct mlxsw_sp_nexthop_group_info *nhgi,
+				      struct nh_notifier_grp_hw_stats_info *info)
+{
+	int nhi = -1;
+	int bucket;
+
+	for (bucket = 0; bucket < nhgi->count; bucket++) {
+		struct mlxsw_sp_nexthop *nh = &nhgi->nexthops[bucket];
+		u64 packets;
+		int err;
+
+		if (nhi == -1 || info->stats[nhi].id != nh->id) {
+			for (nhi = 0; nhi < info->num_nh; nhi++)
+				if (info->stats[nhi].id == nh->id)
+					break;
+			if (WARN_ON_ONCE(nhi == info->num_nh)) {
+				nhi = -1;
+				continue;
+			}
+		}
+
+		err = mlxsw_sp_nexthop_counter_get(mlxsw_sp, nh, &packets);
+		if (err)
+			continue;
+
+		nh_grp_hw_stats_report_delta(info, nhi, packets);
+	}
+}
+
+static void mlxsw_sp_nexthop_obj_hw_stats_get(struct mlxsw_sp *mlxsw_sp,
+					      struct nh_notifier_info *info)
+{
+	struct mlxsw_sp_nexthop_group_info *nhgi;
+	struct mlxsw_sp_nexthop_group *nh_grp;
+
+	if (info->type != NH_NOTIFIER_INFO_TYPE_GRP_HW_STATS)
+		return;
+
+	nh_grp = mlxsw_sp_nexthop_obj_group_lookup(mlxsw_sp, info->id);
+	if (!nh_grp)
+		return;
+	nhgi = nh_grp->nhgi;
+
+	if (nhgi->is_resilient)
+		mlxsw_sp_nexthop_obj_res_hw_stats_get(mlxsw_sp, nhgi,
+						      info->nh_grp_hw_stats);
+	else
+		mlxsw_sp_nexthop_obj_mp_hw_stats_get(mlxsw_sp, nhgi,
+						     info->nh_grp_hw_stats);
+}
+
 static int mlxsw_sp_nexthop_obj_event(struct notifier_block *nb,
 				      unsigned long event, void *ptr)
 {
@@ -5538,6 +5667,10 @@ static int mlxsw_sp_nexthop_obj_event(struct notifier_block *nb,
 	mutex_lock(&router->lock);
 
 	switch (event) {
+	case NEXTHOP_EVENT_RES_TABLE_PRE_REPLACE:
+		err = mlxsw_sp_nexthop_obj_res_group_pre(router->mlxsw_sp,
+							 info);
+		break;
 	case NEXTHOP_EVENT_REPLACE:
 		err = mlxsw_sp_nexthop_obj_new(router->mlxsw_sp, info);
 		break;
@@ -5548,6 +5681,9 @@ static int mlxsw_sp_nexthop_obj_event(struct notifier_block *nb,
 		err = mlxsw_sp_nexthop_obj_bucket_replace(router->mlxsw_sp,
 							  info);
 		break;
+	case NEXTHOP_EVENT_HW_STATS_REPORT_DELTA:
+		mlxsw_sp_nexthop_obj_hw_stats_get(router->mlxsw_sp, info);
+		break;
 	default:
 		break;
 	}
-- 
2.43.0


