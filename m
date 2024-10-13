Return-Path: <netdev+bounces-134903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410D99B8A1
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CBF281CFD
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585C213A863;
	Sun, 13 Oct 2024 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcPWz8vx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DD13A3F3
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802013; cv=fail; b=ETA0vQMxztCrRuv3yqgGI2zU6QQEchGrMsqpJDzJD0XOhC+kXuxXE34HOXY1DHnGCkP1p2g3+5bpNbiOQIKy6RB8pzg2SMqhJRQ9s9ClCKW8IXxa4LDvttohDfIapMmGFcd6KWBkLgTg+HmcV1Kax14wwL6BCES2zelHw1Hu84s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802013; c=relaxed/simple;
	bh=4h3oO8XpvebvLXP/BR/hMVU8Y3rSkPGnLNOnqxeDOrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to2FJGRQfvrBPTKeBAgb1PsSSO70xx+nZuxZAW2etuilwRJXuCJopyTVKuHp0KwenMoeRA3oVhuS4fyouEOKCjmZkGxuq3baLnqyonP9AKYzGRDL6fZVNsM5TciQRjn5Wb2dwJTM53NeRkMNYq1dPATSaLMSn3BxxUcGKvU3eq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcPWz8vx; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC+r4r9eoAHhDUitvD3q3gvdfPHc7qnZ0H0fUTNzWfOi4dTTAVrw5AM333rYjcaxpopLekditpmn8N6dsdyeU0QFYygbr03l4mvXuzlpdiigTIPn+KnAHyx1iyUjKq5opjTi9pixR4W5KQhTv1RMZcCm5FZZwoyFRbvNmn0JlbYxIJnuxUlTFd2dKRkKf/S6WWGgMfuOSnD5w0iIdmY0WGp9Jg6Vv09hIEGQixk0pDB4gr95jufGfgYn03Ie/ERkWps6lNYBdhnHBCIxEto7FBCrbHEpNFxsAvSvpjWlg579xqVAcHPy1eOKWp811RL5glXIZdCEWgO/OYEph3fAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJrwU/w5nHDMD0R6dcUh8Ri2w8pdTb/2i6LRQzkIrW8=;
 b=lXynDh+8UW5BrslOowTcZY/J1fOXKUGbAqjUOEcQoMTG1xMHgzcG62BoMR84/NO+UX+8rgt/KiZchHiRVXBFPvrnXmVuoG1HuyrONJ3Hvjo/gHc0KA4pntF1jY7gcTrrT/fzge/MhEsXx7jueG+kCVvVMS84KkLTBLZIa96LALBMZkd8vs73IPHgWhiC2J99m8NulMxpPPXjecIScglGKY+qaSeDAkZc5dKMs7yf8xJEGtL0jJTX9Xg1gkouwb9xdUosWIsPg69eYPuKh2+467qbb7q1RC00nKaDEVyV9Efpv95VFCGzvBtZ2NwFSUZebZqXqOWdsgM4lXeKVvi7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJrwU/w5nHDMD0R6dcUh8Ri2w8pdTb/2i6LRQzkIrW8=;
 b=rcPWz8vxW+EqOSIEz8Hh/H6e95shqwujlZ3H5xP+4k/ouNllciKQ8OfzvxrbPvrSJ2UvWkMhv/MOteBXHzpV3bSbeRzmxFA1CEopfdAyGdctDgiDLXhhHmkoHKOWwcLfgDr6iqi8PiRmX763ki7fY83a4TbX5eAPPssytaHeG7aCTAACeMht4tF+Dy8er3wxqGb/N09pi72RUs7LHFS8NmSm6zDkHFHfDtUkM7DGded5H4TCHNsZqOkKr57yCkRtksVB9+4hoiUEDEtxg4nUJZvVqbwtcBXGX6RNrRSTNtS7QV3iCzf+kCYpDx8WK+EJ0IrQt+dJBQRns/610hoaIQ==
Received: from CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::15)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sun, 13 Oct
 2024 06:46:48 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::ec) by CH5P222CA0001.outlook.office365.com
 (2603:10b6:610:1ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/15] net/mlx5: Refactor vport scheduling element creation function
Date: Sun, 13 Oct 2024 09:45:32 +0300
Message-ID: <20241013064540.170722-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bea9c3f-9bb9-4373-194e-08dceb52cfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MbJshuh4zCZaB6jLuWUuAlhNGota4REw738Bjtmt6MowGFGTofv5sxIFbLhz?=
 =?us-ascii?Q?zvlVAsWW9hS91j+ir+xN4fdrLYOQwjD4CCk5hk0CoNvqmUTO0EYADuEbVDuC?=
 =?us-ascii?Q?2Zfaw3UEAmbd1dzpYCBTfQb5CDL8dw2pMtwOwN6a41Mq0vB3asJukedeHHuv?=
 =?us-ascii?Q?dycwVwCxWIG6YdRk1X/pqv9NOJHHvYcFg1Kbw4aOpdxN2q94eT2uZpK82Low?=
 =?us-ascii?Q?oEs+dwNU5Tzj1YICmq/A8yv4nTzWU16BiZLQsnN77m88aDrZ/BV2sulL0HqH?=
 =?us-ascii?Q?if5WfZKg7m0gwaL2EazbyShOPIe4hJEPU0wNh6PBEfa13sNKQbIq/rMCdKI/?=
 =?us-ascii?Q?4cxZULIzI7bnh3MarSxHwsHhQ4v7suPVIcMpha8jomKfoKQWbJn8RR6t0MAB?=
 =?us-ascii?Q?2n26OJFEGaKkPZsN5kEsIO5R8WrylXjIxXUDTU7LFS7DXFaukny8on+EeAKf?=
 =?us-ascii?Q?USsACEXBmjokjmIHK9Hu43MPUH7/sPdJRix3oF/4ud66RhltRkDyt+jin7nh?=
 =?us-ascii?Q?qLRciCsXcMEjHjlRIvh2BAE0jr6EcRq4jfGw+qCHyPo2JWWuAdKKsjh3j8Zt?=
 =?us-ascii?Q?xHkoZYs/UZtjZD1FfFC5WVrMBjpO60fKrzx4gIFjMISR188u/1/Rg7aNH0tk?=
 =?us-ascii?Q?ZO2VURGZoa6hSGmowRHs9t3wxcWksOM0h4hJzooD10v4rZtuHzsgdMUIYEWT?=
 =?us-ascii?Q?J3w31P3ZCzM66U8k6th8mudpTa39GRslWLgB0H6oYWMhsIedPtTPKJdpmpJX?=
 =?us-ascii?Q?rSG2bza0cxi5UfSH61fYkRwPAk6BIUTYkAQhygif2dfCZbJlR8f0yfmC5y8a?=
 =?us-ascii?Q?SIFydzGw4gKwmG93YEBZXqGBlmEbTRmh7Ep9xiGIXKObdIm402XY6c3K7iiW?=
 =?us-ascii?Q?IJIBKzzA8oqFTFIwYgImeIG59F3DdPPI/y5UJ0Er8VTVEI0f5yD2kq7QnXAs?=
 =?us-ascii?Q?qsnysp3VUdERc8Uqrsnh1sF/j/lK9g6XfTH9vPBaB1lz5OjS+kPnGy95jD9K?=
 =?us-ascii?Q?5yjYu69asCc8jiQj21cVLaKRSSUPgRK7ffxm/dXvvKYUo1/0JoDkSfa9WwAa?=
 =?us-ascii?Q?DTArEAOUeWo/gom36q6TpfnDCk0o7RSUKdqL+Y/PiLWZVMxd5fUlboK8k3/K?=
 =?us-ascii?Q?Ft77xm45FGQeQb+rxtCJLnPXOh3//VATnuBRj19iWRRHX1RVhnsaf5C3Fj/r?=
 =?us-ascii?Q?93IwvG2uIb5l1EttoC6qKr3PHlxLnT8Qoyd4E01kVkk2TUI9WOMV2Kyi7He3?=
 =?us-ascii?Q?MLvHpyqVtV+rli3QZWN4VJFUThpG7rNgurTEvV/lFvGCWXD5FMmrJhBc87O2?=
 =?us-ascii?Q?GKYOdsyU1MdNSzT1P9Jp9uAJr5OTwS65LlHE0Z353pUyZO2p9QXIohcoxs/w?=
 =?us-ascii?Q?q6qKCAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:48.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea9c3f-9bb9-4373-194e-08dceb52cfa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

From: Carolina Jubran <cjubran@nvidia.com>

Modify the vport scheduling element creation function to get the parent
node directly, aligning it with the group creation function.

This ensures a consistent flow for scheduling elements creation, as the
parent nodes already contain the device and parent element index.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index d3289c1cb87a..d2bdf04421b0 100644
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
 
@@ -715,13 +717,14 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
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


