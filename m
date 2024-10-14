Return-Path: <netdev+bounces-135327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B299D89B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811D11C21204
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE41D5AC7;
	Mon, 14 Oct 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dNSe78G6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD21D5AB8
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939280; cv=fail; b=B0qa1Ckym4x+DnvDRmKIg2S9Fl5titBChgYPA1LKlC6SRehFll972dYUS699L1F45et1gf0nVLRrQePa6lm1yUGaKt6+zHXfuIJjfdHFuwhcCj6VTSJe8cpr4p+RVTrfFCYe2vHtmJO/SFDDmrYxaDA/H+cbOGEI7XX51duWgPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939280; c=relaxed/simple;
	bh=MSWCVyeH9TgNYs5KvbJDVf1fdngaZ3o7bmwFc1BAmwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcjVoSVfth1MNL79RyddsEyzdF/5lFsfavYYf6KWVRQ+xgKmm2TU98+5m3KzoN2jPGD8DgvGo4IU2WprmCJNYyWPpX97/y3JX9z2WyT/PzTJqUHc3+KB5HuScAvObF41CjF2rXxK0OJ+ZOtXkZXuDW2rcpOjr/NwWTAgePleUdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dNSe78G6; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbC2qsNEL3v7d26lwDI3jFBf6qhQ2FcdHAljgbwyG4CafoI84gKtt59gXS4JvlCCZE3no3kIMN/1YzX/Nc9Ew5TlPm1Ybq4BkPpjlc66V5JPqwlBxVTfVyhL1DbiOk7WI/+J8dGK1uN3DfOFHTwUT73hfHva+TQaeAGRlJAH2pB35+YVT69a/erT9D+U5yIhWBPzC84Y3DweNBKPDFdKfQG2Q8LmKquMAksvqoYMIQwuQSDcnhMErOmsDTKKkv17puVv9zEtPqDshNh4Ui0NqRYPPPlFvfJvREw9ObuWcSZclgPKAdsGUj474697rwCe5iXhv/UNY5rU6M+jOWWXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raD33nTQ1NeIuENpL4ip3zm3qx/Byd/TA2TsWr/K8eo=;
 b=lMkP/ufy9DQkGqlbZkb+9JLEOJv4znvHZHI2W/84Jra8JUOQYOEtQMhrvo5uE7xxNGHpfBbDkWJgQtxubccOM2W/fZegi//Ey42OHkzgUBo6p7JLNp50zWkdhbKNVz0n6Xi+ckZFezEgrAavx9cRrNtybn2Ms7KPgjZxwzmTlNad6HPSVq6l3dcpK0TCUKNXy2S8lnrBsFRAPhrOgjKl23jKixcuopfwyDKX+kmBwcd+JJBL27EpkfqnYiyH7Ano+uKpir2Nf6C94clpOtvACLJrfN7n/Zkb4MsTuoQYopqFB8KLvglgZj3nkRT4Yp3X3G1VZwCTnYxuYN3cqAM7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raD33nTQ1NeIuENpL4ip3zm3qx/Byd/TA2TsWr/K8eo=;
 b=dNSe78G6WdDOnXhB8bNykSI/al1MU9nT+9TgYc5FO0R6zU70J7zSsY3N6BxD11s6BR6iCYUpYkQ0zsWUtwgiIY4ajTLncAy3CtbWV/98fohMawyLBGWOsqTQ+vHcxeBuyJY+QZWuC6CIgjUhXKCBcGs4bbUlSDpH9n3CnKqa4eyHgoe+OdscybeNXN/H4VGsAejIbe2o3Lk5j3R25gMPrRLazgzmQaj/U9zcuRN+OU2BthmvF0YCgYX6zXhNiZM5ma2RzGuRPNwZqBdOz4KzSI97ckiX0jl5MEAnKnc55Gfe3qxkdSo3Cmciu3Pu92s3Jjw1bcgUZXMcXaZ1MyeTWw==
Received: from CH5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:610:1f1::15)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 20:54:34 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f1:cafe::17) by CH5PR03CA0021.outlook.office365.com
 (2603:10b6:610:1f1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 20:54:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 07/15] net/mlx5: Refactor vport scheduling element creation function
Date: Mon, 14 Oct 2024 23:52:52 +0300
Message-ID: <20241014205300.193519-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfec468-33dc-40ab-53b3-08dcec926863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sfiC1AbB9EC6PaHHHbr5I+FQacXMEVUV0o9pGnxDLMcifoHuFPUAjDj/Roto?=
 =?us-ascii?Q?lAHHMFiuRL6GxOH9QXGJB0QxmDNNkCWW4cf6LBKnsrLBMZ4twjK1dAcEI8eT?=
 =?us-ascii?Q?0fnaWRO4wqv/Jbv0upEsV+zoEjU4EGeR6GrwD25yxD7oXWc7ssxmYgASyn9H?=
 =?us-ascii?Q?K6zbRq6j8xjTAm2HC5QsKceZHS0MQIidmlgTXKP++l1E7ZDNMdIFs0W1wqBx?=
 =?us-ascii?Q?sL5B/sSQxpZJaEn61wihFFEiGYee/H4BPdNIA1HT1fySNI/wkVzZGA9eWoB5?=
 =?us-ascii?Q?GPTE6pQmvqPqOTLwcD4QZfe9IMCh6elTvhyxyXiLIXSyxE+RmXSxqpv6UVfV?=
 =?us-ascii?Q?Pxx0m1DIIklUi8iZcrm9sw+/AjR1ndiZkpfylcJOG2CFGrlOwKHwG9Hb7Lf6?=
 =?us-ascii?Q?qr3OjVdAhEYoagAo69YSlCfs7ufn6ILZ1Fd2jn9uAqaCrFXAit4FmXeSz+1d?=
 =?us-ascii?Q?F28X7Ajp0kMk365WbBZWk6DCKHqxqwm2qb8SZnwBf2UpbTUzfjel6cyG2exI?=
 =?us-ascii?Q?/e1OntiPhUrrzWPO7OSoHAB4izKTpnzvKKb9W9pqFloWRk9jFXSrRlV6MYbv?=
 =?us-ascii?Q?qx4SHTSVERXrDPlAE8vExTETYhAYJIgwrMUZSsTfQGqab2QKtXPd2HpKoquj?=
 =?us-ascii?Q?WbBppPWi86qXxsxBdOLPf1ZL02qqz7CndAPKI16AHRG+2Bc+XxbwI/RfMPtk?=
 =?us-ascii?Q?1/nBu0jiN477AXfaqIGNuXw+6pFcs/J0zQ9dZqORkRdbtGHoj9F+TcbNIqDJ?=
 =?us-ascii?Q?vMWUSn2GJDSTgveJu+JmxOLUMHeaVy/rNXwQVUjQnMD6eg+8j0N8lahBzeFY?=
 =?us-ascii?Q?C/1L0sgmn+bLlUJ0qapAHWrzIBXyJR+filqKem8rtg+bU83f1SHkXtzy2PiN?=
 =?us-ascii?Q?UwPfI8ajhswkJKRJvMtXGme84nLaLZ4R7VbnjoBtCRCuipqIsdXDmUbEqN9w?=
 =?us-ascii?Q?AMq0KIShQYBY2X5FoDCMorHHjL07zBbcL2DqNfzHTpuQWBZG9s8cfAToEBJ6?=
 =?us-ascii?Q?b173kVH+JtPFua4PJMzS39ixQboG5BwqoXIfPzS7UdZcZpAhXYdXxaOxd0mc?=
 =?us-ascii?Q?YEk1fSxVuMZhb2q1uf/F17/DIQMz/I5DiS2yYgDaMe57bGDgs1lUivqpvzf+?=
 =?us-ascii?Q?yWp0XL0fOGq57zxuO2xQZxgn6TxmRAFMtv0w9KM+L5PQYtW/JXOTl+nLSpaW?=
 =?us-ascii?Q?UlexDyKX3R1KEQGsbT7pSw1nB+nc+Odeb03C39gpscapUFBaYqTewc56jvRI?=
 =?us-ascii?Q?8MxKtG6umEQ6hb0UyVcesI83Q16ZJLnzJfvyfY1+EaqjT+0IoaCalCt6PoIJ?=
 =?us-ascii?Q?6tbySW/5mofus8FNUWJ8250x8rRzgSfF0Jv+diIEtc45FUVdEF8hW9XSoPoF?=
 =?us-ascii?Q?ZOrO05E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:33.8925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfec468-33dc-40ab-53b3-08dcec926863
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

From: Carolina Jubran <cjubran@nvidia.com>

Modify the vport scheduling element creation function to get the parent
node directly, aligning it with the group creation function.

This ensures a consistent flow for scheduling elements creation, as the
parent nodes already contain the device and parent element index.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 840568c66a1a..bcdb745994d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -407,10 +407,10 @@ static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_
 						  tsar_ix);
 }
 
-static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
-					      u32 max_rate, u32 bw_share)
+static int
+esw_qos_vport_create_sched_element(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+				   u32 max_rate, u32 bw_share, u32 *sched_elem_ix)
 {
-	struct mlx5_esw_sched_node *parent = vport->qos.parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = parent->esw->dev;
 	void *attr;
@@ -432,7 +432,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 	err = mlx5_create_scheduling_element_cmd(dev,
 						 SCHEDULING_HIERARCHY_E_SWITCH,
 						 sched_ctx,
-						 &vport->qos.esw_sched_elem_ix);
+						 sched_elem_ix);
 	if (err) {
 		esw_warn(dev,
 			 "E-Switch create vport scheduling element failed (vport=%d,err=%d)\n",
@@ -459,21 +459,23 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
 		return err;
 	}
 
-	esw_qos_vport_set_parent(vport, new_node);
 	/* Use new node max rate if vport max rate is unlimited. */
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_node->max_rate;
-	err = esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share);
+	err = esw_qos_vport_create_sched_element(vport, new_node, max_rate, vport->qos.bw_share,
+						 &vport->qos.esw_sched_elem_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport node set failed.");
 		goto err_sched;
 	}
 
+	esw_qos_vport_set_parent(vport, new_node);
+
 	return 0;
 
 err_sched:
-	esw_qos_vport_set_parent(vport, curr_node);
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_node->max_rate;
-	if (esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share))
+	if (esw_qos_vport_create_sched_element(vport, curr_node, max_rate, vport->qos.bw_share,
+					       &vport->qos.esw_sched_elem_ix))
 		esw_warn(curr_node->esw->dev, "E-Switch vport node restore failed (vport=%d)\n",
 			 vport->vport);
 
@@ -717,13 +719,14 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	INIT_LIST_HEAD(&vport->qos.parent_entry);
-	esw_qos_vport_set_parent(vport, esw->qos.node0);
-
-	err = esw_qos_vport_create_sched_element(vport, max_rate, bw_share);
+	err = esw_qos_vport_create_sched_element(vport, esw->qos.node0, max_rate, bw_share,
+						 &vport->qos.esw_sched_elem_ix);
 	if (err)
 		goto err_out;
 
+	INIT_LIST_HEAD(&vport->qos.parent_entry);
+	esw_qos_vport_set_parent(vport, esw->qos.node0);
+
 	vport->qos.enabled = true;
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
 
-- 
2.44.0


