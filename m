Return-Path: <netdev+bounces-158105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58692A10770
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFFC1887BCF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8C2361F0;
	Tue, 14 Jan 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwbmYMNj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AE234D0D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860256; cv=fail; b=qFmyw5y9z2oqGyTUZ5OmbdtGsmyy2ruBFiZ3WQVsVMyBzO7xI/2x4Wp3LX86rvWjDv3OWQT8VNdp5epDVAJ5UA0dAAdb1030bGuXMPcr1XC5xaIloE75rMQpg15Dbw8uvjYY2hnl8YASk+DznC+7iB67NefaObD2VcXS2MR3owE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860256; c=relaxed/simple;
	bh=R+yAUiHxcysZg38LvXN1QyUSLzI8rXPCFirUC325/Z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgvZQrveSW/XGg7iNC9IapiOn8BhSjWK3IZx5KxEnUE/2GnoaSzKEUSnh2Hgw1Ay3JRVrT8iCZNqwFJSceV1gRY2RBxXjcjl2nklgX0zPPcvvZxBjj7fP5+3jJr4Km/3KmzEmyqN1hnu075ZxSILswQtnTOxly9B/xevVhBS8Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwbmYMNj; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNSSm6D4xKKeE0bsZs9KcGKHO8mQwVAQtD7DnL/Mlg/lG0mAZj9WnW4p3qYieAn7sjFRKxQghfScXIrl+QHq14RR0vTEM73dYQnDSmIqX545/4GnIMVsxOXWl4aYQxfG9NxxyRpZOlBtA985SZ10HV3cUTqK/guqNOBO2P7ZgtlQsSdksJxWXdXWFqPlORZ162z1tBkkacgqBmQte/B2ktB60qU2dGEaSSX427hr/2aMKrPCcO6RYnMklf71dsmbkXHpzCwQM477w+gRE/IRGnWVve/UR+z3RFzEayBB1eFCBrXdoBnBaiwhIdEO8o72YbUrzMu81zL6O5bh+sQQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YI7JuMTlf5m4y9WpeNmQJ5YBg3jRqCs5XDJJn1t89s=;
 b=YKIULmB7JTJkCgmJGbShg4v3aB1BXa8x1ScHKyK5wo0HIl2OQ0w0aDjQ5j72JK9gCxNLSDgI3MgL7iomMKNW8mqS7LQ07IG56JIt6hIrVDkYOlpepdjVxHQFuZ98BJRIdF0CSLEwMP+l+g1f9HqFMFsBJ3W7F9ssP4Pzr6x0E1CuavwuZrkh+VniTptUt3ZhAIeR67sEnQNuCagD1LwH4UF7hYJ7FJkRfretEqz5dVZauUoza/ffE3VUGuBxCZKFdUEayrf1hgYwOp394RH42D/RcxKmRFGQY0VlfHRQe4KfbrgSS3W0md29OoA55jHG2VMpb6rYVulM3zbYrWTnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YI7JuMTlf5m4y9WpeNmQJ5YBg3jRqCs5XDJJn1t89s=;
 b=hwbmYMNjFEJrDC/ZuuLGKHfx3ezzBhLa3ZDVD+56iUBwnnJwy71EupWBpMaOyceIbh2vhCyPQ5MoUFOSCj/BImi+/WXioT9ZBC4d5TJRaZDEI6FijJA0SCZy+MTnw8Dt0PoX+4vbzp3LLxoKsphQGc/r0/8szGfGYJHZXYixAtAtq30fPnH5eFWbiiLcMlUW/DB+DRVeAnmD36iHXcFqzm6kYHwTTJ1khnXzYa+TUY96rYqiqVR8kxhdO9v6VFFN58KWkUQohqIWr3euq+JrA2z/PFcm6GJvrMOU+8m+Kr8+xwnF+G7OUA3g/lrYLEvijEMZLBPVfBhd+dwt3lxFuQ==
Received: from MW2PR2101CA0031.namprd21.prod.outlook.com (2603:10b6:302:1::44)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 13:10:50 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::1f) by MW2PR2101CA0031.outlook.office365.com
 (2603:10b6:302:1::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Tue,
 14 Jan 2025 13:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 13:10:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:36 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 14 Jan
 2025 05:10:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 3/4] net/mlx5e: CT: Make mlx5_ct_fs_smfs_ct_validate_flow_rule reusable
Date: Tue, 14 Jan 2025 15:06:45 +0200
Message-ID: <20250114130646.1937192-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250114130646.1937192-1-tariqt@nvidia.com>
References: <20250114130646.1937192-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca75e38-7822-40b5-dcef-08dd349cde2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URPsaBBf7PcdXksBdP6GEgrLd2ggb8g2Z8jdOvfM7HhbtUp8LiXq0LdEx/tV?=
 =?us-ascii?Q?gvWl+QWD2DgWwOjKgGv3NEbk6nwBjCpP56VBAKSVFNLffPJqwZObUM7GrNqk?=
 =?us-ascii?Q?9diB7XWG+RWK8sNDrTNJ59Bhy+qq2d9IkgcUiPgDMXtqEt3VgpoX0xY6OQ/l?=
 =?us-ascii?Q?EgZchf8VZPVUyS7Y2F39Piixacwot4B9pitDP+rQqaqHb+HWzdL1WTV6ldcA?=
 =?us-ascii?Q?VRct8mH+s7OXk00ifjbJRD8b3p+x8/UB63Fsf9YlSwWhJsD59L5nersm5ZMR?=
 =?us-ascii?Q?RgeNppfyL74lh8ya16zWZIHiQHgzLANGgFSmsCOMCKaBbPVYze2Cg6Ms5FaX?=
 =?us-ascii?Q?Rprsx43fhqK3sJFzzdzaDR96bmYHVqhtgxd6RQwSmGeDRzeUhjGu6jS5kChC?=
 =?us-ascii?Q?1lQYu+vy4FFtpsu22qjcDEKhtbiLZP+h7lBC8opbH7DibRxDr7VsVjZ2AcCl?=
 =?us-ascii?Q?5k0ZOjUg8qvxT5UNqaLlfoMw87ZGl1oR106VOzZIeYWswG0uxJPKtt7I4IkE?=
 =?us-ascii?Q?GsUxAJ21OMTH1Q2fEC0RcoGcYneek5uVorlg/IO2SqD6YQLuBlTBs6xTYYK2?=
 =?us-ascii?Q?1FqLq8q9jhJgIBB0iUs9A6v/oZvMJTcg01EUxvgnJHD1kRRTEX0slo7MEvRH?=
 =?us-ascii?Q?62dooPyomgkzsmM461bu5xMHziZuaNeJTysPzT/FJQLnc3F65iQuU9HBvelT?=
 =?us-ascii?Q?r4rSFN9oq+Ehkomg2g2aY7sxIdvovSa625ZJdtnyMr7FECbnRZFpx+VmxtGB?=
 =?us-ascii?Q?hgX7bWfIOKLJXTLHliPyN32tNMxnjDK6wTdAlO+cQnJ1zAjK6eW5m9wxIdtz?=
 =?us-ascii?Q?pkGwHJdWknHsqtAe0dcCPjO+P/g2ASYXkIStE3DGSWvnyvdmXSgtxdQTvM9A?=
 =?us-ascii?Q?Cwx4apZ8eGfhjX25eAmoS55aCeRC9OJh22jspgKda8GGw6W0r5EwGYxbgTKq?=
 =?us-ascii?Q?Gw5ZYrRLaMoiQZ4sYrJCNa9PdJUGS2V22EyFOPvi9ALeRbw0GVMgSNJF7HV1?=
 =?us-ascii?Q?QlCKgbSz5INWC+ysgwSo4t69e0gEXuIC/fuBOkWIcTI8S3yH0ptMVTBzntF8?=
 =?us-ascii?Q?pYCVVuCJSIm1VF6TqFyGz1AgVTkrSgi+n04J+nXKqHJI7BXJsou6ZhIXBPpO?=
 =?us-ascii?Q?/oYb6+04jthhBQFWociONiOwjUaUyA/QKNQ+ZARF2EJoTmVC4R4OAJz2Sn1i?=
 =?us-ascii?Q?eTTh5C5HtecxAeqNvCVxeXiSKUvpJrsgum/wysmbGQaWlyK1wcFpZ32XaZeX?=
 =?us-ascii?Q?6WcO5SIRIDPmdGUofSurRV7iIYAc6wsOw7dGQa3gRhOGVTQQ5jCohfLLApYG?=
 =?us-ascii?Q?rDXVsFS/OSQaPbffL9x7BF9GcI8sRAIK8+qSM6w+yAoH8N19H3+rlJBwT3Gr?=
 =?us-ascii?Q?UXoTZoQS3F1iBkQBDlHXJMU6Lcn9+OllaY/xpp2eTZ1MRj8YP5vMxy69+S7G?=
 =?us-ascii?Q?L1pz7g+wLqRJwJj5IhovuQ9iPfoZeMN4K0xjvcw1bZHdwMTrbaOC1kA2DInR?=
 =?us-ascii?Q?kZSrBoqCufXY4eg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:10:50.3256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca75e38-7822-40b5-dcef-08dd349cde2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538

From: Cosmin Ratiu <cratiu@nvidia.com>

This function checks whether a flow_rule has the right flow dissector
keys and masks used for a connection tracking flow offload. It is
currently used locally by the tc_ct smfs module, but is about to be used
from another place, so this commit moves it to a better place, renames
it to mlx5e_tc_ct_is_valid_flow_rule and drops the unused fs argument.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     | 75 +------------------
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 71 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en/tc_ct.h    | 10 +++
 3 files changed, 82 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 45737d039252..0c97c5899904 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -13,7 +13,6 @@
 #define INIT_ERR_PREFIX "ct_fs_smfs init failed"
 #define ct_dbg(fmt, args...)\
 	netdev_dbg(fs->netdev, "ct_fs_smfs debug: " fmt "\n", ##args)
-#define MLX5_CT_TCP_FLAGS_MASK cpu_to_be16(be32_to_cpu(TCP_FLAG_RST | TCP_FLAG_FIN) >> 16)
 
 struct mlx5_ct_fs_smfs_matcher {
 	struct mlx5dr_matcher *dr_matcher;
@@ -220,78 +219,6 @@ mlx5_ct_fs_smfs_destroy(struct mlx5_ct_fs *fs)
 	mlx5_smfs_action_destroy(fs_smfs->fwd_action);
 }
 
-static inline bool
-mlx5_tc_ct_valid_used_dissector_keys(const u64 used_keys)
-{
-#define DISS_BIT(name) BIT_ULL(FLOW_DISSECTOR_KEY_ ## name)
-	const u64 basic_keys = DISS_BIT(BASIC) | DISS_BIT(CONTROL) |
-				DISS_BIT(META);
-	const u64 ipv4_tcp = basic_keys | DISS_BIT(IPV4_ADDRS) |
-				DISS_BIT(PORTS) | DISS_BIT(TCP);
-	const u64 ipv6_tcp = basic_keys | DISS_BIT(IPV6_ADDRS) |
-				DISS_BIT(PORTS) | DISS_BIT(TCP);
-	const u64 ipv4_udp = basic_keys | DISS_BIT(IPV4_ADDRS) |
-				DISS_BIT(PORTS);
-	const u64 ipv6_udp = basic_keys | DISS_BIT(IPV6_ADDRS) |
-				 DISS_BIT(PORTS);
-	const u64 ipv4_gre = basic_keys | DISS_BIT(IPV4_ADDRS);
-	const u64 ipv6_gre = basic_keys | DISS_BIT(IPV6_ADDRS);
-
-	return (used_keys == ipv4_tcp || used_keys == ipv4_udp || used_keys == ipv6_tcp ||
-		used_keys == ipv6_udp || used_keys == ipv4_gre || used_keys == ipv6_gre);
-}
-
-static bool
-mlx5_ct_fs_smfs_ct_validate_flow_rule(struct mlx5_ct_fs *fs, struct flow_rule *flow_rule)
-{
-	struct flow_match_ipv4_addrs ipv4_addrs;
-	struct flow_match_ipv6_addrs ipv6_addrs;
-	struct flow_match_control control;
-	struct flow_match_basic basic;
-	struct flow_match_ports ports;
-	struct flow_match_tcp tcp;
-
-	if (!mlx5_tc_ct_valid_used_dissector_keys(flow_rule->match.dissector->used_keys)) {
-		ct_dbg("rule uses unexpected dissectors (0x%016llx)",
-		       flow_rule->match.dissector->used_keys);
-		return false;
-	}
-
-	flow_rule_match_basic(flow_rule, &basic);
-	flow_rule_match_control(flow_rule, &control);
-	flow_rule_match_ipv4_addrs(flow_rule, &ipv4_addrs);
-	flow_rule_match_ipv6_addrs(flow_rule, &ipv6_addrs);
-	if (basic.key->ip_proto != IPPROTO_GRE)
-		flow_rule_match_ports(flow_rule, &ports);
-	if (basic.key->ip_proto == IPPROTO_TCP)
-		flow_rule_match_tcp(flow_rule, &tcp);
-
-	if (basic.mask->n_proto != htons(0xFFFF) ||
-	    (basic.key->n_proto != htons(ETH_P_IP) && basic.key->n_proto != htons(ETH_P_IPV6)) ||
-	    basic.mask->ip_proto != 0xFF ||
-	    (basic.key->ip_proto != IPPROTO_UDP && basic.key->ip_proto != IPPROTO_TCP &&
-	     basic.key->ip_proto != IPPROTO_GRE)) {
-		ct_dbg("rule uses unexpected basic match (n_proto 0x%04x/0x%04x, ip_proto 0x%02x/0x%02x)",
-		       ntohs(basic.key->n_proto), ntohs(basic.mask->n_proto),
-		       basic.key->ip_proto, basic.mask->ip_proto);
-		return false;
-	}
-
-	if (basic.key->ip_proto != IPPROTO_GRE &&
-	    (ports.mask->src != htons(0xFFFF) || ports.mask->dst != htons(0xFFFF))) {
-		ct_dbg("rule uses ports match (src 0x%04x, dst 0x%04x)",
-		       ports.mask->src, ports.mask->dst);
-		return false;
-	}
-
-	if (basic.key->ip_proto == IPPROTO_TCP && tcp.mask->flags != MLX5_CT_TCP_FLAGS_MASK) {
-		ct_dbg("rule uses unexpected tcp match (flags 0x%02x)", tcp.mask->flags);
-		return false;
-	}
-
-	return true;
-}
-
 static struct mlx5_ct_fs_rule *
 mlx5_ct_fs_smfs_ct_rule_add(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
 			    struct mlx5_flow_attr *attr, struct flow_rule *flow_rule)
@@ -304,7 +231,7 @@ mlx5_ct_fs_smfs_ct_rule_add(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
 	int num_actions = 0, err;
 	bool nat, tcp, ipv4, gre;
 
-	if (!mlx5_ct_fs_smfs_ct_validate_flow_rule(fs, flow_rule))
+	if (!mlx5e_tc_ct_is_valid_flow_rule(fs->netdev, flow_rule))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	smfs_rule = kzalloc(sizeof(*smfs_rule), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index fec008c540f3..a065e8fafb1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -2430,3 +2430,74 @@ mlx5e_tc_ct_restore_flow(struct mlx5_tc_ct_priv *ct_priv,
 	atomic_inc(&ct_priv->debugfs.stats.rx_dropped);
 	return false;
 }
+
+static bool mlx5e_tc_ct_valid_used_dissector_keys(const u64 used_keys)
+{
+#define DISS_BIT(name) BIT_ULL(FLOW_DISSECTOR_KEY_ ## name)
+	const u64 basic_keys = DISS_BIT(BASIC) | DISS_BIT(CONTROL) |
+				DISS_BIT(META);
+	const u64 ipv4_tcp = basic_keys | DISS_BIT(IPV4_ADDRS) |
+				DISS_BIT(PORTS) | DISS_BIT(TCP);
+	const u64 ipv6_tcp = basic_keys | DISS_BIT(IPV6_ADDRS) |
+				DISS_BIT(PORTS) | DISS_BIT(TCP);
+	const u64 ipv4_udp = basic_keys | DISS_BIT(IPV4_ADDRS) |
+				DISS_BIT(PORTS);
+	const u64 ipv6_udp = basic_keys | DISS_BIT(IPV6_ADDRS) |
+				 DISS_BIT(PORTS);
+	const u64 ipv4_gre = basic_keys | DISS_BIT(IPV4_ADDRS);
+	const u64 ipv6_gre = basic_keys | DISS_BIT(IPV6_ADDRS);
+
+	return (used_keys == ipv4_tcp || used_keys == ipv4_udp || used_keys == ipv6_tcp ||
+		used_keys == ipv6_udp || used_keys == ipv4_gre || used_keys == ipv6_gre);
+}
+
+bool mlx5e_tc_ct_is_valid_flow_rule(const struct net_device *dev, struct flow_rule *flow_rule)
+{
+	struct flow_match_ipv4_addrs ipv4_addrs;
+	struct flow_match_ipv6_addrs ipv6_addrs;
+	struct flow_match_control control;
+	struct flow_match_basic basic;
+	struct flow_match_ports ports;
+	struct flow_match_tcp tcp;
+
+	if (!mlx5e_tc_ct_valid_used_dissector_keys(flow_rule->match.dissector->used_keys)) {
+		netdev_dbg(dev, "ct_debug: rule uses unexpected dissectors (0x%016llx)",
+			   flow_rule->match.dissector->used_keys);
+		return false;
+	}
+
+	flow_rule_match_basic(flow_rule, &basic);
+	flow_rule_match_control(flow_rule, &control);
+	flow_rule_match_ipv4_addrs(flow_rule, &ipv4_addrs);
+	flow_rule_match_ipv6_addrs(flow_rule, &ipv6_addrs);
+	if (basic.key->ip_proto != IPPROTO_GRE)
+		flow_rule_match_ports(flow_rule, &ports);
+	if (basic.key->ip_proto == IPPROTO_TCP)
+		flow_rule_match_tcp(flow_rule, &tcp);
+
+	if (basic.mask->n_proto != htons(0xFFFF) ||
+	    (basic.key->n_proto != htons(ETH_P_IP) && basic.key->n_proto != htons(ETH_P_IPV6)) ||
+	    basic.mask->ip_proto != 0xFF ||
+	    (basic.key->ip_proto != IPPROTO_UDP && basic.key->ip_proto != IPPROTO_TCP &&
+	     basic.key->ip_proto != IPPROTO_GRE)) {
+		netdev_dbg(dev, "ct_debug: rule uses unexpected basic match (n_proto 0x%04x/0x%04x, ip_proto 0x%02x/0x%02x)",
+			   ntohs(basic.key->n_proto), ntohs(basic.mask->n_proto),
+			   basic.key->ip_proto, basic.mask->ip_proto);
+		return false;
+	}
+
+	if (basic.key->ip_proto != IPPROTO_GRE &&
+	    (ports.mask->src != htons(0xFFFF) || ports.mask->dst != htons(0xFFFF))) {
+		netdev_dbg(dev, "ct_debug: rule uses ports match (src 0x%04x, dst 0x%04x)",
+			   ports.mask->src, ports.mask->dst);
+		return false;
+	}
+
+	if (basic.key->ip_proto == IPPROTO_TCP && tcp.mask->flags != MLX5_CT_TCP_FLAGS_MASK) {
+		netdev_dbg(dev, "ct_debug: rule uses unexpected tcp match (flags 0x%02x)",
+			   tcp.mask->flags);
+		return false;
+	}
+
+	return true;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
index b66c5f98067f..5e9dbdd4a5e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h
@@ -128,6 +128,9 @@ bool
 mlx5e_tc_ct_restore_flow(struct mlx5_tc_ct_priv *ct_priv,
 			 struct sk_buff *skb, u8 zone_restore_id);
 
+#define MLX5_CT_TCP_FLAGS_MASK cpu_to_be16(be32_to_cpu(TCP_FLAG_RST | TCP_FLAG_FIN) >> 16)
+bool mlx5e_tc_ct_is_valid_flow_rule(const struct net_device *dev, struct flow_rule *flow_rule);
+
 #else /* CONFIG_MLX5_TC_CT */
 
 static inline struct mlx5_tc_ct_priv *
@@ -202,5 +205,12 @@ mlx5e_tc_ct_restore_flow(struct mlx5_tc_ct_priv *ct_priv,
 	return false;
 }
 
+static inline bool
+mlx5e_tc_ct_is_valid_flow_rule(const struct net_device *dev,
+			       struct flow_rule *flow_rule)
+{
+	return false;
+}
+
 #endif /* !IS_ENABLED(CONFIG_MLX5_TC_CT) */
 #endif /* __MLX5_EN_TC_CT_H__ */
-- 
2.45.0


