Return-Path: <netdev+bounces-116705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B4E94B66F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1BD1F24A6D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D6A186289;
	Thu,  8 Aug 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utwQNhmB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B313CFBD
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096896; cv=fail; b=XwYB6rJqvSZ/orK32K290tyg35a3oqIOG/Myrzlp1X5nD6MTw6JJecMu08A6Ed1WS1Hctwu0u20IIdf8QxegAZxLURQb2gP6YzylgqJroSazhWqLlVYa6gNfZtvRTRWtBKjlDx5+EJ6DERL6hY6B6h0+Tl6tFBKpehiHGw5uNTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096896; c=relaxed/simple;
	bh=damO4B68FeDBBgvNcV6B59CjpW5vBS7D/m+DIiSv7Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUZxoaFkvikaV1d9AKzx04+F+/9YDL/QYxExV+7iERUxhmGwCTO/+Yky9K5wky8lO4bkvTrMGdO/QUsDW6yNSqamxhtcvonGoTYGWJxABeC+xNh+NoiXQa4vcsc5l8dUMPbab3WkIjQPydCgvGhA2/i8gliuJzhBicY0Vdsj4ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utwQNhmB; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk0Wslbze7s3l7aAQIgmKH76z40Vz0kHpcHd87sldbn0jJigwGAiovaIazhWlJK2h5rkBq/6FMR6vODI5u8E7aeNF9flgmMKG3VLYe0JvlV6g3kZY/dVI9OCQSPJGaBQQhYgSfzg4CQC5I686ZDxUim4YRcIXKyp3qnoHqYt8MvG5cerMJrS/lYalRTy2DQcrzwmla9/qGlJAOoIzW0vpQvCsiwub/adGJUNhU7IKY3hwvDNst3ABnxzbN5PXSljgKs2dD3xm9iNjoUa8FAH7ZOLfY1//XYJ+aF7JIZQWYd7s1YXbWaTiPQT+LwnlZ1RpIr4yudPB59tASEoVKyFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSOqis10XSa2hlFQiWocg5SmOiC1mkHyTaiKGHbxKFw=;
 b=Wr4Ug2M7kFMNje2ktF/1PzaFh72xkMzMNoa557oU807mp76Ly1wISywVFs7b0NfdfzVU/ShUav8B7ZpZj1qZQuzyN4sEZVZ5MtAUqKnUoBoVkoj/dEqE7oiVxBAazyUxEJnUcvtQgP/q2kgWeszCY+9j/QEEEIS5UgltSAsLOBxHNzUd7x8/Qnzb6UtDSxnWxuAWdR1wdZHf03b6TGWSnvkkWPehKv/pgIneWAU4x5hyezFqu11nJMUdLx4nCSwqKMIBIjkS7oVpbbFoo6VRMqDpKDij8IMeoRWYKJVhTz3SYo0Wu0Zaxgj3FAmJI7j36S4/Cq5b6NQxXRfU0xykvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSOqis10XSa2hlFQiWocg5SmOiC1mkHyTaiKGHbxKFw=;
 b=utwQNhmB1v8YpCh9kALaad1x4JytLoKoWKOhfzId3oHR3+CHxq9ObIDFEwc4BfpmLRramwl4SNZ6wG60Ck9pOppPac2eEDTJlDF29ECgApX4zJXaL5WvkizrtWTeDprvZEDVhej70kVmiieZHPqfNIY+CInTmhIP3nf81Sygsj2UsHUJ4aDPJbUZVEwmczPdQ7jPNjZXSqtyf0YbHGlbU/6CRine3EzTZ9UG9yEv0DvUAlPW3dqSDPKkz0ZF96fyv3A+QLPFik31vVfxb6Ez0Cry5ysojhhKuwpLupRc14gCbkT/+xRdEBCk3RmyPnKASJFu3feKP2K70JLRK289ew==
Received: from BYAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:a02:a8::24)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 06:01:31 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::76) by BYAPR03CA0011.outlook.office365.com
 (2603:10b6:a02:a8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 04/11] net/mlx5e: TC, Offload rewrite and mirror to both internal and external dests
Date: Thu, 8 Aug 2024 08:59:20 +0300
Message-ID: <20240808055927.2059700-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad4f46d-9958-49d9-13ea-08dcb76f8cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8Nk8ghY74NNtSl4J2WmlpjuyQp53LBWyiA5r21f1x8mBpwfn0yD9ohLbdWV?=
 =?us-ascii?Q?OMicJrp56GJpI68YfopNj2XVMPtBVzwE49mz7SBIgAORqk/BkS16W3C6KU98?=
 =?us-ascii?Q?WVNNXDEnzzm5RUs/gtqALrfokj6460ISSme6GemkOqOgeFKAB+fb5UmIhgeo?=
 =?us-ascii?Q?qF1EFoj2ZW/bYTGNmgre7NGZExk4c/m9Ts/YVketJy+PkfR9i1hvZ0VujD0v?=
 =?us-ascii?Q?OCrTuHIGtTTeehQEPsbHN1idehR80nUQyHHQ5S9XuinHToI4XEDfCblbSial?=
 =?us-ascii?Q?tU2GSiLfU7UDVwQuWK1ecJ0j8jAPTABO9+DKI6SjoNTOLbsDeWlTauaZhdG7?=
 =?us-ascii?Q?IT7h2GRMDZP7xAPTGOO9613cZfwpZ64NVX/Zr24ZOD8uTsnmjyYQTzXKlT0T?=
 =?us-ascii?Q?oUoNbXP78Zb23ciqK+a7f+OeAlVPf0pjvojWY3ND7wOF08tWOLe3c7asplOh?=
 =?us-ascii?Q?464jDo3x966N0kYFTKD5bLxBngKESfNpU1u07UcmKv+I5ruRMIho7iXGUFmE?=
 =?us-ascii?Q?I7FHv8SuM/7C3VL5wDYYx2uxaYwrRZ0qEBUbddHBkKaRzziUaHx5hY77S0W3?=
 =?us-ascii?Q?5qlimpJy9BD0rY2V5GBdd2sYXTW2bRBYL0G8k/wX+Pf1PdYfTZ9DqJsr86ii?=
 =?us-ascii?Q?p4/kv4imsOAC7GFgdhYaREmesl1I72e+v0FP8Qj3UFyDKgtlSbwDedLr+93j?=
 =?us-ascii?Q?cZFf2z+Kl24N+2dew7cGoKdGoJWpk1fui8NZDzXwxCznW7R0V0VrmnIyMOKC?=
 =?us-ascii?Q?y/KGEDsVbjfuZ2QS9gnicWxeoO+zEuYolGd3mwdTtfSEy4E7QR31YalqRGp3?=
 =?us-ascii?Q?YPgtvZBKyGc41JRQbBUHNkGKcxViIPTzC+JMMQThHUth5Xw/NDElMDbvdV95?=
 =?us-ascii?Q?u51rIgYgtVRg/JUKX1U8qkJvM/g+YnGaUvAYRK0MHoRGQ6MPxiiUi5ShLcee?=
 =?us-ascii?Q?k0svluEMVkiIyfq4T4BSeJa73mzHfnPyN8DOjaFpEvxNWksVqCsQ9VtcAjaD?=
 =?us-ascii?Q?B6oPqdoqfqhdd5+pRj5nsWK+Z/l54GO5y1gq0yCsGMa4KnBoEkKQh1iNK1TO?=
 =?us-ascii?Q?JPYudLuPRg0GEZljl0XfbWvV+BI9hlBP7D6YPdMAEYSXTBQyIA/Us4VQzdyx?=
 =?us-ascii?Q?6o5SNgG9DgTFNSRtEdvckcHClvd5+Sdk+A5S55+Dc9lK6AeiJxxenINfPcMe?=
 =?us-ascii?Q?rddbPFX85IAgwzHEvA5tnz10a9bJxqooBBgcbP3ZCTU3N9UlJaJ8N+1bzvU4?=
 =?us-ascii?Q?LTa+yys0UAZ9rIzgeNsRm9ee/tH2i1gzFgXfioQNtUuFk9dLOHJlcsBQ/9yG?=
 =?us-ascii?Q?3S6J8zVIFb3DhHCYq8UApWkgYHrP6lDeAUUqs8/JBy9qmTtyAdayCRM4hUF+?=
 =?us-ascii?Q?ObkultGMGXWYvdfuYLDxHreYlxFn5Hob/FbP9ik39bbhjXq/j6sabw1Kb3YM?=
 =?us-ascii?Q?7+FfJgiGwk84zLFHkf+MhO1gN2vIERRg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:30.9476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad4f46d-9958-49d9-13ea-08dcb76f8cb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

From: Jianbo Liu <jianbol@nvidia.com>

Firmware has the limitation that it cannot offload a rule with rewrite
and mirror to internal and external destinations simultaneously.

This patch adds a workaround to this issue. Here the destination array
is split again, just like what's done in previous commit, but after
the action indexed by split_count - 1. An extra rule is added for the
leftover destinations. Such rule can be offloaded, even there are
destinations to both internal and external destinations, because the
header rewrite is left in the original FTE.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index a28bf05d98f1..6b3b1afe8312 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1742,12 +1742,17 @@ has_encap_dests(struct mlx5_flow_attr *attr)
 static int
 extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *attr)
 {
+	bool int_dest = false, ext_dest = false;
 	struct mlx5_esw_flow_attr *esw_attr;
+	int i;
 
 	if (flow->attr != attr ||
 	    !list_is_first(&attr->list, &flow->attrs))
 		return 0;
 
+	if (flow_flag_test(flow, SLOW))
+		return 0;
+
 	esw_attr = attr->esw_attr;
 	if (!esw_attr->split_count ||
 	    esw_attr->split_count == esw_attr->out_count - 1)
@@ -1758,6 +1763,18 @@ extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr
 	     MLX5_ESW_DEST_CHAIN_WITH_SRC_PORT_CHANGE))
 		return esw_attr->split_count + 1;
 
+	for (i = esw_attr->split_count; i < esw_attr->out_count; i++) {
+		/* external dest with encap is considered as internal by firmware */
+		if (esw_attr->dests[i].vport == MLX5_VPORT_UPLINK &&
+		    !(esw_attr->dests[i].flags & MLX5_ESW_DEST_ENCAP_VALID))
+			ext_dest = true;
+		else
+			int_dest = true;
+
+		if (ext_dest && int_dest)
+			return esw_attr->split_count;
+	}
+
 	return 0;
 }
 
-- 
2.44.0


