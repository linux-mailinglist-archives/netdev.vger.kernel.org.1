Return-Path: <netdev+bounces-136219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC469A10D1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407191C223D2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DDF212EE4;
	Wed, 16 Oct 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sEpMkfvF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DED2139B5
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100290; cv=fail; b=oSy5b+d9ndcmb0oOUXFBUJQAKc2n8usDxJEpH8dgvgWXjSTIW7ZPmySl658+TlFfKqIztkLbN2hdGk3rA0myw2cqfEbtamNDC7snL1OliZiHZ7yl4LcNXOpazWebfSbvDSICIthHioWncQljNT0oh1lplx80QZ3EbfvUsnUUBl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100290; c=relaxed/simple;
	bh=3ndkomccHSzoxvPlj+dYmHnV35jwci+om0km4oZnWzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e510GEM+o/8+CtdJ3PDiD15pqZWd/ZMXfLGqGxgY1tXV4Ce7jrHyraKKugBiWnt+1M9i8mFm1dMbk2JTueQ4AuJu7N1e562Kmr1J54a6Ff+CDpPeqA10YcaBy/saOnhi6zh3vdGrnQ3OwDSJjmP2/sjnLP/o6juLLp0c8Suj9JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sEpMkfvF; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/01NaH9VRRfPF61KF+zQKQSwNRqdDTlP80mhyITA4xMoiMutUS7SvcR+AXRmnNeBLv81KQ+zO5X9Q1UScAyRF9ramqNvNCFjvkEH9XrqJwvxShlSghQD60BzsVsO7wEknN5RDPzZTglQDhtLweDNUP7ZTyM9ufYSgfzPzhD8WYQlAED2DZk78iKtQnL/mZIwBu5MggyijzUBRW1li5nDHBQ9bR7p73/vEBN6WikLQ/k8nnJXD3jSX4N9pP5bEVaHhVq8pB5P/yC2N4yvhYLdf2wOeFzd+vaIesW5pMggXF3nvdLHhnASYWN6Va/1vg2Kxnfrc4s60k3ww63MRcH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeYzfla2qMqlpadDr3MJ2Bc6hnipuwXYDrlL3CnlCo8=;
 b=hFYYVhOni28BTP2uDtNy6eV6K7zfPse6IPRyWXHIHK37h7Pu48pU16dOqmk+FTql0WVkP1l0t1rlnmrUSWolToxtIaLuHTcazqdQ2k7B03lfdxb1O0ScqU0kvmBLpyE1OMlqRuFVSd83aZMhw72fDmPeYndb19J064nL18s0QbDasIyWLUjI5w9it2MB3DMDhwNEu0abCJyQipAU92w8ZApQYOzR9YNfviqZHkeAdgj7r0ydIquvrQm2naM91MJaT1X3qjMIpQXeicw+R5+v9TZ44Xk1Z1RD7uvYKUxnrZZrRchS1diaJtGURDDqIuTNnyDl0rRhiaQ4b2z5Rnl0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeYzfla2qMqlpadDr3MJ2Bc6hnipuwXYDrlL3CnlCo8=;
 b=sEpMkfvFS9kt7N0LWSHzMUdjA1SWO2LV0I1ecgS0XHtIirGRd1sYs40FVG+kwhLTsjZAUGVUTzgBpl1Au7a6ojttB8iJFpD3brIFE6rMpQvMiu/J1BNJg5YllGQTcqUSxKKFDA4DbPUMGqBOa0680X7JQbho2O2L4U/9kypYksnGz2/FX3qzDFA4wfqOrm512EQ3ZpOuue0QW9dvxL5U2c9suoSLD13r+c+LdTPwysOwNyGcjW1q5/SDgAORzFeLCdUFgW8qFcWP/xllTzIMeCyZSQSrqadS4dOJCySaTL+UmcGUHHQHoPTJiFVjfMTMRkuPwcbRCqkhY6TrVm+xMw==
Received: from MW4PR03CA0039.namprd03.prod.outlook.com (2603:10b6:303:8e::14)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Wed, 16 Oct 2024 17:38:00 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::e4) by MW4PR03CA0039.outlook.office365.com
 (2603:10b6:303:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 17:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:38:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V3 13/15] net/mlx5: Only create VEPA flow table when in VEPA mode
Date: Wed, 16 Oct 2024 20:36:15 +0300
Message-ID: <20241016173617.217736-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 972788c9-e84f-4762-28e1-08dcee0947a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p2coCIXuPZnyzpEsSEoTBVaOo6k+Z1AU6+cyTY7dFn9JgF30aC+gHZiYLWZn?=
 =?us-ascii?Q?JwYH0TMF9Zv4DTcEj6AYQSUIMt8GjcYgGFvzp+3u3b1dlu+wRaFtnPrGL9Rs?=
 =?us-ascii?Q?rtsid2BhkcRF9yCs9weosfyaHTy5/wTSqrCSDrEmQM/gFT+ZyPLRu+AZfH14?=
 =?us-ascii?Q?Xw7LP8A2QEzGw44wF+hjU/ovGMJ6b93XW4OAhKeiJSchKobpmhC5rzL4ZslS?=
 =?us-ascii?Q?Hkd19Q1dmAKTe8qgZe6ECgayLb+b+AK1bqSImc3MA32SdafPCtO5FGrL8V8t?=
 =?us-ascii?Q?UCJdIUulVNgyirEuUMKWBQG69zKziHfWbq+rbQiZAC/TT83ZqWTGh4VBUTkL?=
 =?us-ascii?Q?OqKhYGcWF1nqER2iMy1HKEHMnqbWj4MlyTas/aWlY1HW1icP/YR8tvS87uKp?=
 =?us-ascii?Q?ftQYuAAZlACY+XJI3QIQTCs/5Z263wpe70tpz94MeJwHDgZtguoqkv5ZL1Dy?=
 =?us-ascii?Q?KFjxHF4ryeCeFKLc+KP+cb1xfYx1Z4xOEm6gy+JeVq+iM0fbCuPnF1j8pJZW?=
 =?us-ascii?Q?b80bjsJ3Z0bpsrWbM/yegRvIHPPnDxxZgLMqDPLAnmgAbwTTEkVm7iOTlFbl?=
 =?us-ascii?Q?tk7aea1dG/r4CXIqXo1mSCR3Yqks83p034He91ju124gW6YN6PjxP9pXgiu8?=
 =?us-ascii?Q?Oq6Pp8bIFShneu0Ycgrgf0qg3XC4RGMJM8RHRLkK+3Xvjqkm12gT/cMYo0JP?=
 =?us-ascii?Q?UMSHiwzYPhS9CydOhB32OEy81j6RrPCQZeydrpy0jBTmf/L4TObJaCpjZi1A?=
 =?us-ascii?Q?10gQjK7D6DxR1moe8L4JPj/YFX8CZM4I9avBIVeqoxAUo3RGhc79jlbcGWTQ?=
 =?us-ascii?Q?zlk/6xojID/dUkGUJrdD6mIZoHW/8attKzBZnRWQef4+ntZYWhNlyhgiPZl+?=
 =?us-ascii?Q?/DL/x5+fPdVzhwRnLL/aUc8NO1tAO3WRmbkRpiagW9ZnIel4n6dYZrK/D8Im?=
 =?us-ascii?Q?MJZv+fqmbG2jaMk54ZklOrd7oad7VgXOZ3lA5FrNoF15XkDDiPLX5nZgPwku?=
 =?us-ascii?Q?CzqaNUY/V/zpuJBuMoqTBLcobD90y+psE0rM+jeT4uzXY5vTl730v0CjMvSW?=
 =?us-ascii?Q?QHVv16NluyyMbTk1UFtonhXeUtLrxwZ/N199sZgIkP4vxV02PzHpv/tOgB1D?=
 =?us-ascii?Q?5Ms0h/oYMAyvDLCR/AnV+1s4ZkrYq5ulVQ5JVMPDSM5PiegePBR0vsdMNC6J?=
 =?us-ascii?Q?KA+BD61jpDqlya3nRMzxjjlExZpZ9dPws8NXS2uKOmk/VUNkDEcWSNdziUpj?=
 =?us-ascii?Q?KaTWU7Gqm/boXKb3fphVJMp2AQ9p6EWlWY3Y+CQ/lamRHUjFeEk61hi3VtKO?=
 =?us-ascii?Q?uoEYzHou8IVnSB+cORmkD2FGZjyuxhQgqy/TBkhoZO5w5RR2IXXgLnHU9v5h?=
 =?us-ascii?Q?sWlCImHRSVDEnIlOzcVoDyBccru7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:38:00.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972788c9-e84f-4762-28e1-08dcee0947a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184

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


