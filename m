Return-Path: <netdev+bounces-78743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECBD8764AD
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DB8284186
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFDB1EEE9;
	Fri,  8 Mar 2024 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dg5WNqVS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3F1EA8F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903004; cv=fail; b=uI9YUYw6BRtFBUsvXuIsPlSpr7CfPPpv2oaQfDPpGGWPAFNlzAI3R8zYrIdj9k/DywULLhBj8eNa+ccZor4ACDYQVNLNY4XKXFKbuTikpQfZtQVTTqFBoBqYStEiYxrtkFFWavQJPB79bypOce64R/lstG5AZrjq48QSNBA+EJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903004; c=relaxed/simple;
	bh=vPrMql4lu6lan29viOPM9n1eAyPz+gFQi3hMfkQtSow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubU/+G61nQR/jLOElTF8luyuBa49ILZKZwB2Zr40fe5ifmFqq+ud25f+q3Cws2X2HyyW2vtlM8nRDg1p+0BUi9rS8kFLwhuPzt0xANaj2CgNxpDKuSYm+bgI7MLmhtrFTNMcVqUb0sPpfITE4PIucNmZ1s2UD8V2ObNuaDZLRc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dg5WNqVS; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa6G6b/++DlSWA/JrVt6AKy2ix82dTdIcHalN0xJkNVv9FiQ73VO30Bazoh8PJ71pJJejzDHYoeVys/2QCQ/fD+ZibrMEuciZgaFZCmXd3iTESl6gNVDQ8fG4iI+DwSdUcIks65Ed/cenFscehi5W+peldwiTQv2AqXTf33Q/arU8IZ4XsfGXNMF/A/WDmc3cQGOVrJJeLflfuSveZ0NuuyYrlhk/QlbQiR654pRFc4GmK5mBtlSYTqSgn3LNiAwTcsOTeCMw76rB88zWIrRnT6piAoM1KV6X18qngA3LMPOxnqiWNQmtfDIhVKk5FIy2n8xk/mhgScS9ue6YTKZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je/dY06JKrnYZQ9xfYtbtpMY9MQcYZI6HaESi/Uk4Og=;
 b=BHoATRGPTtZDk0sMjNS3fq7Upb/Kb9lLYuDHxPUFbwYlFln7k2j02m77M9oLz4MN1Q0f2MVbA3Bs14B5lPhWYnVOa/saZnGavF4JXA/Wdmz5PzwSMgLO4DjHCbdcYuadRh3mVt+bM9VRLRawjEnyUJy2vxs6lEZja6AkcSETuEpvfxubQYFzd3Y4eKX6+FJHHp9IT7Us3ukg/qjur1urDGL1swAOToUds8S2Xi8TOHW1mUFbD4YtCbgR6Y5VuLNqv+SPAk4cYWMK0mVitEZ0JxQiyHkUSe/ujME0c3qDUgw/HjcSYKulEWdrJFy4XPfLcylEZ+NoVnJ9xckJzmBufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je/dY06JKrnYZQ9xfYtbtpMY9MQcYZI6HaESi/Uk4Og=;
 b=Dg5WNqVSVjcxmsEX5Cu8m2aVsXXtxXatW3aIaD5PCxHm1ptiybzwnZJ4Osvhum4X+DyyQiDpkQEnJsktsWTZo915QFk4rF/jZsT3S9Xp+hKMjNq6Ta3Q8iDE6nm/pJ6tQUL+V7so/gUQEjYfa7CjkvjwNOb1H9/dfQmJQpeIspk6y8tcGQg6ly3Iid2LdvKHxYMUAv91ghgkWzhyJUBR12KnTM1WI/BF3rpdZOwvUiZZiOit/prqXIgq4ERMvaQMkguj1DO74ZqzvgSAGPLH0najCjz1ndBrc6wqo4vBk9OyZKeNUcHAjboqPOd2DnAhLGHb6qJIUqAbrKUhHg6i9w==
Received: from DS7PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:3bb::23)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 8 Mar
 2024 13:03:20 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::41) by DS7PR03CA0078.outlook.office365.com
 (2603:10b6:5:3bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28 via Frontend
 Transport; Fri, 8 Mar 2024 13:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:03:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:03:04 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:03:00 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 10/11] mlxsw: spectrum_router: Share nexthop counters in resilient groups
Date: Fri, 8 Mar 2024 13:59:54 +0100
Message-ID: <cdd00084533fc83ac5917562f54642f008205bf3.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0392a655-a59d-4bc2-7a4d-08dc3f7020da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IMCInKQMiHTJoolqBSwRTsuXcVoAsMF+MbVSUdVKvMT0bUHxsBLMEQEq/17BWz3QoFk1FLDpMp6mn3GoaR2unNQwaJD2a71/P3AmriXt8QWkPRqXASX+Bg/CYCAzH/EV/javN8YVXoECH970kGxSruDAlTa3meXm0Duh8/1YT7wGzLbaesCnehvPwQomlRL2UgU3QTGIpEdTq62yt+CNHcFu61xpGORll6Xko/Lh0O/FJ/E5ehm/Fvx1JImctYO3TVJ9TuZuGHPhFBbGymjlG19Bo0S6+/B6bCk/9+ZBqs+aagbXbGVi0nqUKoethC6GsvRSjYVl7SZRj6oxWkS+V0adNuMbJYFWwRzztd81hy6kxeOy5JKEpPKHj/86PRloOJ7p60KuE5ITaiBki6J151VrL2mYSfNuM66fjHPgqWXabo7+zloeHmX1YsZ56ga4Bogehi427iroPKibLgCPjBfEr/sYuutY2UayBdnoIIZOjGYbYh9hyhn9jJT/RYAf6D1jO7VIOyyeNz26zFtiXR8h1/g9vkiS8LPA2U5SDcc7rx51snauEnHPdMAsnUfQJJPJiEmimY3gh6FVClazVKha/7EmI4qQe66Jal95nVuWxIsmfRTENEMaDMpfdVbg3ht2u+N2ZJNTGpDbSRSAif2jKC4FkV91fG18KC47QN4gCaOQGDThaZ7LiXOdYiuNo32cABrMjZmLSggi82COHp+m88PDUgm8tedPhfqoAc/5pCUO1SCvzlUb6oN7YbMi
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:03:19.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0392a655-a59d-4bc2-7a4d-08dc3f7020da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

For resilient groups, we can reuse the same counter for all the buckets
that share the same nexthop. Keep a reference count per counter, and keep
all these counters in a per-next hop group xarray, which serves as a
NHID->counter cache. If a counter is already present for a given NHID, just
take a reference and use the same counter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 70 ++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 93ead5ccf864..40ba314fbc72 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -19,6 +19,7 @@
 #include <linux/net_namespace.h>
 #include <linux/mutex.h>
 #include <linux/genalloc.h>
+#include <linux/xarray.h>
 #include <net/netevent.h>
 #include <net/neighbour.h>
 #include <net/arp.h>
@@ -3111,6 +3112,7 @@ struct mlxsw_sp_nexthop_group_info {
 	   is_resilient:1,
 	   hw_stats:1;
 	struct list_head list; /* member in nh_res_grp_list */
+	struct xarray nexthop_counters;
 	struct mlxsw_sp_nexthop nexthops[] __counted_by(count);
 };
 
@@ -3156,6 +3158,7 @@ struct mlxsw_sp_nexthop_group {
 
 struct mlxsw_sp_nexthop_counter {
 	unsigned int counter_index;
+	refcount_t ref_count;
 };
 
 static struct mlxsw_sp_nexthop_counter *
@@ -3172,6 +3175,7 @@ mlxsw_sp_nexthop_counter_alloc(struct mlxsw_sp *mlxsw_sp)
 	if (err)
 		goto err_counter_alloc;
 
+	refcount_set(&nhct->ref_count, 1);
 	return nhct;
 
 err_counter_alloc:
@@ -3187,6 +3191,56 @@ mlxsw_sp_nexthop_counter_free(struct mlxsw_sp *mlxsw_sp,
 	kfree(nhct);
 }
 
+static struct mlxsw_sp_nexthop_counter *
+mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp *mlxsw_sp,
+				struct mlxsw_sp_nexthop *nh)
+{
+	struct mlxsw_sp_nexthop_group *nh_grp = nh->nhgi->nh_grp;
+	struct mlxsw_sp_nexthop_counter *nhct;
+	void *ptr;
+	int err;
+
+	nhct = xa_load(&nh_grp->nhgi->nexthop_counters, nh->id);
+	if (nhct) {
+		refcount_inc(&nhct->ref_count);
+		return nhct;
+	}
+
+	nhct = mlxsw_sp_nexthop_counter_alloc(mlxsw_sp);
+	if (IS_ERR(nhct))
+		return nhct;
+
+	ptr = xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
+		       GFP_KERNEL);
+	if (IS_ERR(ptr)) {
+		err = PTR_ERR(ptr);
+		goto err_store;
+	}
+
+	return nhct;
+
+err_store:
+	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nhct);
+	return ERR_PTR(err);
+}
+
+static void mlxsw_sp_nexthop_sh_counter_put(struct mlxsw_sp *mlxsw_sp,
+					    struct mlxsw_sp_nexthop *nh)
+{
+	struct mlxsw_sp_nexthop_group *nh_grp = nh->nhgi->nh_grp;
+	struct mlxsw_sp_nexthop_counter *nhct;
+
+	nhct = xa_load(&nh_grp->nhgi->nexthop_counters, nh->id);
+	if (WARN_ON(!nhct))
+		return;
+
+	if (!refcount_dec_and_test(&nhct->ref_count))
+		return;
+
+	xa_erase(&nh_grp->nhgi->nexthop_counters, nh->id);
+	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nhct);
+}
+
 int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_nexthop *nh)
 {
@@ -3203,7 +3257,10 @@ int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
 	if (!(nh->nhgi->hw_stats || dpipe_stats))
 		return 0;
 
-	nhct = mlxsw_sp_nexthop_counter_alloc(mlxsw_sp);
+	if (nh->id)
+		nhct = mlxsw_sp_nexthop_sh_counter_get(mlxsw_sp, nh);
+	else
+		nhct = mlxsw_sp_nexthop_counter_alloc(mlxsw_sp);
 	if (IS_ERR(nhct))
 		return PTR_ERR(nhct);
 
@@ -3216,7 +3273,11 @@ void mlxsw_sp_nexthop_counter_disable(struct mlxsw_sp *mlxsw_sp,
 {
 	if (!nh->counter)
 		return;
-	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh->counter);
+
+	if (nh->id)
+		mlxsw_sp_nexthop_sh_counter_put(mlxsw_sp, nh);
+	else
+		mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh->counter);
 	nh->counter = NULL;
 }
 
@@ -5145,6 +5206,9 @@ mlxsw_sp_nexthop_obj_group_info_init(struct mlxsw_sp *mlxsw_sp,
 	nhgi->is_resilient = is_resilient;
 	nhgi->count = nhs;
 	nhgi->hw_stats = hw_stats;
+
+	xa_init_flags(&nhgi->nexthop_counters, XA_FLAGS_ALLOC1);
+
 	for (i = 0; i < nhgi->count; i++) {
 		struct nh_notifier_single_info *nh_obj;
 		int weight;
@@ -5227,6 +5291,8 @@ mlxsw_sp_nexthop_obj_group_info_fini(struct mlxsw_sp *mlxsw_sp,
 	}
 	mlxsw_sp_nexthop_group_refresh(mlxsw_sp, nh_grp);
 	WARN_ON_ONCE(nhgi->adj_index_valid);
+	WARN_ON(!xa_empty(&nhgi->nexthop_counters));
+	xa_destroy(&nhgi->nexthop_counters);
 	kfree(nhgi);
 }
 
-- 
2.43.0


