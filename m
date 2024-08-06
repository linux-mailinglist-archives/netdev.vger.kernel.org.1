Return-Path: <netdev+bounces-116112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F694921E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BB9B2DC6C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FA41EB48B;
	Tue,  6 Aug 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lReU5af3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE21D6181
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952234; cv=fail; b=fkvfF9OO1gyAHndJc0nwjw7QqX6H9nAxLlRENLGosiydoIAbigZOA9O3nhH8jhxoPmGKkCsJetuxP1vYrtEkWzxJjLaLRLoEX9YPtVWPn+r/aw6eQa36YmSDUwElehRMjEt3/ZWzNeNEKgN+flK9fQTc0R7eD+thVI4HYyj3D2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952234; c=relaxed/simple;
	bh=FQYvjhZWDp7sAQAPINj7cYImL9blQyjDw2CPfmZ+gUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDfQWJzREOCjhFp0vt42541S8nuxRatxuiEhIB3bFvznU9bcWVaqoLeJJiHgwPsQdmcjGJWXPTPM8J4/KK1J/g/3uww8sD45TZ+mosXUvc2r/w9yQmz5bQ6e4C9QveZ4kKj9RQw13p2GrtyA0DDd9yRg97dSkHDCTxSo94seYbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lReU5af3; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+sAjh6DwWDOO7vORNR4tsSm3Wpmb5xBgr+7gizDLnhe2chpoOuNOGAeNOmz9eKpUz+zmZ7Ec6Qf7ExDmbYD/erR9w0MOfjFm5lX/6tA6na5h1izWzrHBy2po1sKxuUV4DMW/tpFarl6Y5qy6MtadpLoTD5xrKFbO0Ap6p4vJ8WT4WAYu1i2NNwFbfSANelkwZ2kBLNmL4U8iPPXOuoLd7McrL/d/aG20BhkCFl/NopkWy0mKlrVNTkjgOHn44OR2+j+udQzCa1eAQmTZ7uy2+sutiAtNoZtrbis+eWSw9jhwp6TnM2gmyglSXQZo3ODg5Ra7uiZhddGkmiWnW7TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHbSDNV2T2irJ2x/Z0a2n0hXx/l3aizWt9FIpy62CO4=;
 b=MJNEZVQdum6pFaKH7fka1ROcDkeA5CMU153O4T/Ob2W2hZSBQaAlJNgJezsNHAEFnzQn7rH66rH2KXvCYkj00n9ChEmHc8zybKGvsVutwJzEELOYl3DxM3vpvaBiRwH3dlpQOzU4HGcHMuSDuNp55fzFa1F9eCfMl9e2tDSSaOMYuC34f5PMsvWE/27O0SPmxVhCfTwiod2RSeVDtADN5IoL40fgZoMtcYkp00dA+zxJIx1fAjznPtO/DcTXLMDRBNlFYggoghuDw+EcFmX5TSnU7JuTrBKsG6mDxx+IzYoEBQmSBCKLQAE+tLOmol7ykZxJ2egTANS0nReKTPM9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHbSDNV2T2irJ2x/Z0a2n0hXx/l3aizWt9FIpy62CO4=;
 b=lReU5af3UJSOY9xtZ1KG6lfF1p3DICVmdO+oulJFf4GGwYrWkqdtQ1oKMaR8YtuGMKdasKI6punKDVQydCNGWVfywkZvBnYjS8DYi6QDXqETwz+urCLy50/HZhIEfyJe5M2/EsAA5EW2kob6lqZKDvBLVmReYTpiExwA9vpmdTUtO07l1B8+v+VYUYLsNPJN6IQOAoAil6p+viCs4aVqne6jFQ5VXuVK9Js3XBbi4KBVJie38zJ5fy5x4P3cupelP1mjqSbiABuQ/VOcbL9v5kQ2stjWowE0kJZj+BoVt3mD1+vU5f5CbRPdTpEuqmGI12nGPeseq3xU52sxMZYsjg==
Received: from CH2PR18CA0045.namprd18.prod.outlook.com (2603:10b6:610:55::25)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 13:50:28 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::b2) by CH2PR18CA0045.outlook.office365.com
 (2603:10b6:610:55::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 03/11] net/mlx5e: TC, Offload rewrite and mirror on tunnel over ovs internal port
Date: Tue, 6 Aug 2024 15:57:56 +0300
Message-ID: <20240806125804.2048753-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c960a9-524d-4e06-18f2-08dcb61ebadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?by0hd4S6RTcsjjjFNEJtq8YLGtNx4oMtp9h+AbcXYTzvjav/mG++GVJXeOM0?=
 =?us-ascii?Q?31kjr+TlP1YTgvxMGbVi9u/B0SSF0VNhLsj8k9u8OG0x7cvylQlj1GIwUEed?=
 =?us-ascii?Q?OJlTuvXewj3j8QY2wfMj2CaDzyPTUJP6A1dExUmmE8bm16rZMn6MSIYUfnsA?=
 =?us-ascii?Q?ST76OObIA+cSNEv3KlI+JG+3rh88UZyHbxLfxXGHbf+YWDrQSUtsyUBHOyE+?=
 =?us-ascii?Q?rD9+/yKTq18qaiQ3j5GDJvT+6hxxwEGW/ad7QcgbAP3AOd65iCYSz+h5yktf?=
 =?us-ascii?Q?Nb6hwQc8yZLjKKM/cgDNx5OFkzXgmENCT7qMwjyDYXVxtmm/Lf/rSZ/p9ktq?=
 =?us-ascii?Q?iebz+CNVy/dEkzbEh1TwkLFbkGEAOIBsQ77XQR+r+Kv5tRsMYP7tqdc9KOMn?=
 =?us-ascii?Q?rLj7EtwNL/XJhmVa9Fu5jlVt4KYldHcMz5M3U/C5Cu8Vc3Ym7oSg70EbnCMM?=
 =?us-ascii?Q?sKXmYRN+W7tueuyfG9MoTOZN+eSQ+MgdD6VyYuD6MnxIcPNZz8LZ9zncJB4q?=
 =?us-ascii?Q?Hmix2cw+H8IFSOVNOKA0pcuKrmG67R+bd34JFPx9YicSwXX6oMvCHbrPHwgO?=
 =?us-ascii?Q?IaBmTMLfveMzUgLVpXm8nGiVZrE7ZAs9VDrEmiSzSuUtRgbgyDB8NtyQu4T5?=
 =?us-ascii?Q?x+Y4qDtGRMJxyOwHtPm67zGNZjl1pcHu/TTMIauJXJhe2CbHckQGzXr6r4sj?=
 =?us-ascii?Q?fpSbSqxtu5zlpOazyL22NH6EZqQsfrixhHgpg7VmRh2Ohbi+rNyG7gIzEDIY?=
 =?us-ascii?Q?2Mi/Tqm4GUNctpACt4hMPPlwsWatD+UBgzSzWdkR1c7fD4a730Y2ogCHU1nC?=
 =?us-ascii?Q?0y7v2sjWtQcyecMA3GaOCkRmFOs3DfGx85O6lNWlSEjSXmuahckt57WCmPeI?=
 =?us-ascii?Q?zzSEhvV6aroP887RKf0xcSmCTpH+w4MzfeQbfezvsRGmVGwyt3NlqjAWVtsS?=
 =?us-ascii?Q?upeoNJNVRQ4c5ytinOGfZ4t34qcZ0oIl7DIFh/roON8zO692VlXpq7VAFIIT?=
 =?us-ascii?Q?3pZTVPfjrntPmniJHvc6K44a3cZt8JAzRoOWcvBn6yGxE0t936o4D90WtMFM?=
 =?us-ascii?Q?/fVTZibRstLu5qprDTMrUO8y7qZblOAMGGbxKTkj2vwCGNSWTKdmrPB2+XmY?=
 =?us-ascii?Q?dVO6YddEe4nCX2KJbhR3GcTj04vVDFxmDImoCcoq25WPnrvRxJ2tKg21WwGP?=
 =?us-ascii?Q?sJ+wXutDcc9bM0qeKR7pmlmrfKVmPMoOgrzICdQwhZRDLbagltfVWigAQuvl?=
 =?us-ascii?Q?wPVRVokNDy5Khe2qDM+A0KKBNU+X0/+JQuwlroNcD2fI568Wmh/gVzb2QmCu?=
 =?us-ascii?Q?QrqXmhInuz38nEg/mxOJyqGS2vWHpX/f/jGuHRDcrrETZ/UfwQNwn43YkHAr?=
 =?us-ascii?Q?pgey3WnTajtpa+517r6USGa6wMts11CLLyuzabND89OjMLHurZOFKmt40ub6?=
 =?us-ascii?Q?DEpApv3NGXVKqZHRDDBM05dryLJPeHFQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:27.8400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c960a9-524d-4e06-18f2-08dcb61ebadb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

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


