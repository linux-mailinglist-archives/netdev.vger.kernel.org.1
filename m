Return-Path: <netdev+bounces-116702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AED94B66C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1AD1F247B0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC2E18454F;
	Thu,  8 Aug 2024 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3rqupTU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F9623
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096887; cv=fail; b=Bx1cu69sV6g6/mAEuKPhHNG1nmwbyMQ6yaO0/Uehfz8w8UPGGiK79d2axD+Lboq90EYx8Oq5D/PAsFMoRlTRBoYpxp+IDGPOUzCGgICapuXTvSwjwJACenqkAeyvzVhI6zCqdmqFL8aqfS1PxvW7k7wedL6B+Bb+/SSP2PzVxvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096887; c=relaxed/simple;
	bh=FQYvjhZWDp7sAQAPINj7cYImL9blQyjDw2CPfmZ+gUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEyzC0aBFmPhvLjWqJFnxq/7FYGjWMsuqvOLe1En5s6NZhhlklVe8tP7SEWX4FrF55Vs8VbucmSsS8dAG2fMPJ0ZTgvd/O++kdheRQ9j6lRITeoLqF9K7V+2jyAOnL3WtoJ1X8a66h1MUp1OmVfKcCUxzjKnKp9xSwuWxZw2CPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3rqupTU; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI9ouBd1MlhiV3jo/P1KspmqbRpi2nRTlhccpAm5YLsbzMjBNKSgGpW7rweh4PHnx/RIL8+XYZv4oufE3vSMXbrvJofLgBLc6zmPoBGnoGuxXVRng/PXNYZVE2W4MqsA4b04zLycPtyeKVrvxF/ee6oE0kNqIKo8naUXr1GeC1sy8TgDUvn77ik+8hGOTM52VIun5EisqmcfcX7y/iBbUfJBdymv8auAZRNoY1PxK1TGHSuGEw8Cm7ZcjKF0up4CCcyvTn9swAQSYkXpL3y2vTWl67XbXhnph5VsUwjIDVDdDeWi5ySId5Yul78/QaMXtd4yIb8pZ82bA/i42da88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHbSDNV2T2irJ2x/Z0a2n0hXx/l3aizWt9FIpy62CO4=;
 b=VMrg24HXsO1jzI8thdSsI/7B/EbrlZOS3MR/h8+rbQ8H8xJacIamFl7PtSVocVigWOoPeokqUcrOlyW5CAozIxosVvgAZB8ixicWBYpIfCZudkGHPtSj4Gryu6nKDnpmi1SY3vMZffScUNzm8dH2LvxQui3V9NRXB8gIr8bv5MsSrt330ryFliaVXep6RF/f1mDrIn4V1aQMkI/byAJfVyMmCd4HThzt391NH57RFV1lmg68nd34ZOJiEBP6j2qFCrsxsm8gUeOD5E3XREchhNWunB0dnNL+yJCW50pGgMYlr2bnsUrVooMwow9HXny/EINs2CkMDuPeS2dILxWycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHbSDNV2T2irJ2x/Z0a2n0hXx/l3aizWt9FIpy62CO4=;
 b=W3rqupTUGhS26BzFW2CqnL4CQJpZC5pJEw320Hh40peBxukO+e1KUP0WENEIBEkv/LoS0e2cqM7vkb3g8gDMcDbjfCqlvWdpoAKGY7/8mtyUMfoNw4ncFTUfVTrJDRv8C7j3uGpFArx5bTj9OtANUoUDdyzJ6oS5WvvQhEaJd2vrzugVRwCA32DfGcsyTBnDN6BeN/dSDsVEJZIWfhR3F+pQA+8ALaz78JadaeQ1Hciz2oED33NARIvRPlQAgAuDmgvU66PVKza8h5Z1Ii9+dCP4qSY9SwXStpgsDZN1+9+EGEK3tij553g5FWOJ6ixqPEAMIOLcZWZalFmdw94Rig==
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 06:01:21 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::5b) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Thu, 8 Aug 2024 06:01:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 03/11] net/mlx5e: TC, Offload rewrite and mirror on tunnel over ovs internal port
Date: Thu, 8 Aug 2024 08:59:19 +0300
Message-ID: <20240808055927.2059700-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1aca20-9d5b-4ce4-a61a-08dcb76f86ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GnD42wwUN2envNgw8EJx3qoBL6bCARJenNVUu8Xm1pHFmn5butyvNKWEIbGQ?=
 =?us-ascii?Q?KClPXlfxnmEVwAvRINNnRJAw2tfJPXpWjCIIA8viRzObfFCT+0232Afi1Fee?=
 =?us-ascii?Q?gzV81RGfv6DrO1QW8ipkaUDCL9M8/jrmGrWYigHXxDtSa+gOOctzEo30yjC0?=
 =?us-ascii?Q?9mgjHWEEsAOEu5vMXgUQa3o2YzkD8J96RxUOUQ3FXGsbjNK5DOuJCXjqg6EI?=
 =?us-ascii?Q?1aSocqRIZzcLvT1LNjbyZ9IZwPEWrrpUX26K8WIbAMjjcYehjMTVgHwqPfta?=
 =?us-ascii?Q?GPKRQf5S80AjQ1NXID1MUnZ1dcSoypOSZtoxd+6LyiOQYcJjJLHCJT8+lkAx?=
 =?us-ascii?Q?YwzsCpqa73AxiNTQambeu0TsnJkzvOzfelFNuxsYyDQyq7D2UCv06XRwydHJ?=
 =?us-ascii?Q?BhYUT8MH986XoThP5M/m71hUqoLiuoA9uTvlCFHq4Mn9XAjMKPo+2tWV0UKT?=
 =?us-ascii?Q?qJg85Hu61jO20LUG36xAvUI34D/pONwXGqFGHTApbQabrXyKbJaDUNTGANCv?=
 =?us-ascii?Q?bPnnzVG0HA1eU6pKdxpL1UhjHN08s4t5aFegAeQG/vKRP2Kfy2S82UIzZPi0?=
 =?us-ascii?Q?LIoq1TRi9I+d7qgvKC8lQvZapNZVGI+71/BZhmYbOqDDQMCKmEX8gcFIsIDV?=
 =?us-ascii?Q?wbsW5RjD6Fj+AWYlemao9DNNp5VcjRX2x0qLIGkyzOXYM5BYhO1cvIlDm33m?=
 =?us-ascii?Q?gzoCkeWNWqe0UA9ivWcRu8YmxKAPSJ+qH7y4VTpILKFCgEJP1N3fmKNxvs/4?=
 =?us-ascii?Q?uCK79GA2GRA6BCWjSmjgj2M8/lOx0DGSTeeey7M2cFSICAekWTzQhfjG4ziR?=
 =?us-ascii?Q?sEKppShrM6qTMTCbYQ3JSGvW2ZR8/dWVO0jC9eitzu4xBAwjKZyCEQXk8xqC?=
 =?us-ascii?Q?j6XOPagU2iI3r5NR23v/LdxLfjiUhUoqhZGHV2e9JtRpc+XdGiX8ygsx5Zu3?=
 =?us-ascii?Q?mHOS1/L4ZapynnLTJRZ1TScSwC2mVqyTQUmHuF9byiGJJsoNWeLSi+ht+Np3?=
 =?us-ascii?Q?wTl3OIVn5uYufp2V3dnwR9mdVINzUJCHDJpbfwwT+HppcddIKgsiguEe5gur?=
 =?us-ascii?Q?eZENdgfs9Y9i1p3cl499JAcuAT35IjFsfAwZd+zqZuJDnAVsT9hNZflBEDVH?=
 =?us-ascii?Q?xhLsUymYck64UD15V2BflFQ8Dbx/vMmL8U7QBUCxz0IqQ6SOrwAhHkwXxT4j?=
 =?us-ascii?Q?MkaBHqMBzr0/kS9fhlzXRML5cXd/Cy9VB2+aruQ8AGQNy4zjX5g9ZylvlwR3?=
 =?us-ascii?Q?QmHDvwxF+HWHwnsUdV6jGFv+PHQlwTJUh1GuiGf/hIy8FR6BdEO+kvfiEZQ2?=
 =?us-ascii?Q?uNv0FvxDcrHSZzWg0G/iyhYv15gsKRNBWWWWN6Gehc7QhZBc7abdE7bEVqi3?=
 =?us-ascii?Q?7drCNLOo1nGwRxWUnBnLrflqYJ3sL/XZpElpzCaoHQfnoLkxkNcTZhyxmUrt?=
 =?us-ascii?Q?8siHDvXD7EcC+jntl3OIYu68mhU/pXPt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:20.7837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1aca20-9d5b-4ce4-a61a-08dcb76f86ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010

From: Jianbo Liu <jianbol@nvidia.com>

To offload the encap rule when the tunnel IP is configured on an
openvswitch internal port, driver need to overwrite vport metadata in
reg_c0 to the value assigned to the internal port, then forward
packets to root table to be processed again by the rules matching on
the metadata for such internal port.

When such rule is combined with header rewrite and mirror, openvswitch
generates the rule like the following, because it resets mirror after
packets are modified.
    in_port(enp8s0f0npf0sf1),..,
        actions:enp8s0f0npf0sf2,set(tunnel(...)),set(ipv4(...)),vxlan_sys_4789,enp8s0f0npf0sf2

The split_count was introduced before to support rewrite and mirror.
Driver splits the rule into two different hardware rules in order to
offload it. But it's not enough to offload the above complicated rule
because of the limitations, in both driver and firmware.

To resolve this issue, the destination array is split again after the
destination indexed by split_count. An extra rule is added for the
leftover destinations (in the above example, it is enp8s0f0npf0sf2),
and is inserted to post_act table. And the extra destination is added
in the original rule to forward to post_act table, so the extra mirror
is done there.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 103 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tc.h   |   1 +
 .../mellanox/mlx5/core/eswitch_offloads.c     |   7 ++
 4 files changed, 112 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
index 6cc23af66b5b..efb34de4cb7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
@@ -109,6 +109,7 @@ struct mlx5e_tc_flow {
 	struct completion init_done;
 	struct completion del_hw_done;
 	struct mlx5_flow_attr *attr;
+	struct mlx5_flow_attr *extra_split_attr;
 	struct list_head attrs;
 	u32 chain_mapping;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 30673292e15f..a28bf05d98f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1739,11 +1739,102 @@ has_encap_dests(struct mlx5_flow_attr *attr)
 	return false;
 }
 
+static int
+extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *attr)
+{
+	struct mlx5_esw_flow_attr *esw_attr;
+
+	if (flow->attr != attr ||
+	    !list_is_first(&attr->list, &flow->attrs))
+		return 0;
+
+	esw_attr = attr->esw_attr;
+	if (!esw_attr->split_count ||
+	    esw_attr->split_count == esw_attr->out_count - 1)
+		return 0;
+
+	if (esw_attr->dest_int_port &&
+	    (esw_attr->dests[esw_attr->split_count].flags &
+	     MLX5_ESW_DEST_CHAIN_WITH_SRC_PORT_CHANGE))
+		return esw_attr->split_count + 1;
+
+	return 0;
+}
+
+static int
+extra_split_attr_dests(struct mlx5e_tc_flow *flow,
+		       struct mlx5_flow_attr *attr, int split_count)
+{
+	struct mlx5e_post_act *post_act = get_post_action(flow->priv);
+	struct mlx5e_tc_flow_parse_attr *parse_attr, *parse_attr2;
+	struct mlx5_esw_flow_attr *esw_attr, *esw_attr2;
+	struct mlx5e_post_act_handle *handle;
+	struct mlx5_flow_attr *attr2;
+	int i, j, err;
+
+	if (IS_ERR(post_act))
+		return PTR_ERR(post_act);
+
+	attr2 = mlx5_alloc_flow_attr(mlx5e_get_flow_namespace(flow));
+	parse_attr2 = kvzalloc(sizeof(*parse_attr), GFP_KERNEL);
+	if (!attr2 || !parse_attr2) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+	attr2->parse_attr = parse_attr2;
+
+	handle = mlx5e_tc_post_act_add(post_act, attr2);
+	if (IS_ERR(handle)) {
+		err = PTR_ERR(handle);
+		goto err_free;
+	}
+
+	esw_attr = attr->esw_attr;
+	esw_attr2 = attr2->esw_attr;
+	esw_attr2->in_rep = esw_attr->in_rep;
+
+	parse_attr = attr->parse_attr;
+	parse_attr2->filter_dev = parse_attr->filter_dev;
+
+	for (i = split_count, j = 0; i < esw_attr->out_count; i++, j++)
+		esw_attr2->dests[j] = esw_attr->dests[i];
+
+	esw_attr2->out_count = j;
+	attr2->action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+
+	err = mlx5e_tc_post_act_offload(post_act, handle);
+	if (err)
+		goto err_post_act_offload;
+
+	err = mlx5e_tc_post_act_set_handle(flow->priv->mdev, handle,
+					   &parse_attr->mod_hdr_acts);
+	if (err)
+		goto err_post_act_set_handle;
+
+	esw_attr->out_count = split_count;
+	attr->extra_split_ft = mlx5e_tc_post_act_get_ft(post_act);
+	flow->extra_split_attr = attr2;
+
+	attr2->post_act_handle = handle;
+
+	return 0;
+
+err_post_act_set_handle:
+	mlx5e_tc_post_act_unoffload(post_act, handle);
+err_post_act_offload:
+	mlx5e_tc_post_act_del(post_act, handle);
+err_free:
+	kvfree(parse_attr2);
+	kfree(attr2);
+	return err;
+}
+
 static int
 post_process_attr(struct mlx5e_tc_flow *flow,
 		  struct mlx5_flow_attr *attr,
 		  struct netlink_ext_ack *extack)
 {
+	int extra_split;
 	bool vf_tun;
 	int err = 0;
 
@@ -1757,6 +1848,13 @@ post_process_attr(struct mlx5e_tc_flow *flow,
 			goto err_out;
 	}
 
+	extra_split = extra_split_attr_dests_needed(flow, attr);
+	if (extra_split > 0) {
+		err = extra_split_attr_dests(flow, attr, extra_split);
+		if (err)
+			goto err_out;
+	}
+
 	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
 		err = mlx5e_tc_attach_mod_hdr(flow->priv, flow, attr);
 		if (err)
@@ -1971,6 +2069,11 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 	mlx5e_tc_act_stats_del_flow(get_act_stats_handle(priv), flow);
 
 	free_flow_post_acts(flow);
+	if (flow->extra_split_attr) {
+		mlx5_free_flow_attr_actions(flow, flow->extra_split_attr);
+		kvfree(flow->extra_split_attr->parse_attr);
+		kfree(flow->extra_split_attr);
+	}
 	mlx5_free_flow_attr_actions(flow, attr);
 
 	kvfree(attr->esw_attr->rx_tun_attr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index b982e648ea48..e1b8cb78369f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -86,6 +86,7 @@ struct mlx5_flow_attr {
 	u32 dest_chain;
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_table *dest_ft;
+	struct mlx5_flow_table *extra_split_ft;
 	u8 inner_match_level;
 	u8 outer_match_level;
 	u8 tun_ip_version;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 768199d2255a..f24f91d213f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -613,6 +613,13 @@ esw_setup_dests(struct mlx5_flow_destination *dest,
 		}
 	}
 
+	if (attr->extra_split_ft) {
+		flow_act->flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
+		dest[*i].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+		dest[*i].ft = attr->extra_split_ft;
+		(*i)++;
+	}
+
 out:
 	return err;
 }
-- 
2.44.0


