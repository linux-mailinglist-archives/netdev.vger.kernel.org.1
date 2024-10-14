Return-Path: <netdev+bounces-135329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A9799D89D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCD1B21DE4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F21D174E;
	Mon, 14 Oct 2024 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rls+gdQM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E01D1512
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939288; cv=fail; b=PBKCn+ylV2nBqTLFERScaiedbELq1z3Kh1aCQCUCdDvOFAcot9iu3YXRoqkY6cNA1ErqRLjTRr/sRaJ7bb/mUayZW4xSSHraR2yP1rQKnLnB4ZADlyk0LdvHEtH3PDI7jsOyv3KHQehrccHCbBBvajCFzwjoji45enptYZD7/5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939288; c=relaxed/simple;
	bh=U/G2gS9Ue0Z/UYEyy2Ch4Z4mEaN8bWbBC0GG5leJNGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9qj4jgFypP8ym+rZPqg6ZbobevIdgMY66CxcbGg9pAwhJfCFSricEO1LEIdIG4Z1ruP1eZYaVkDb70oqK7XI2GmIOliXbJvn9a7fCVVs9yDXWglzu/a76MhN4xbrOvgJLtWyLvJjcUqMDUF3pw+Q+UrM9vL50RxXUAir63DJrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rls+gdQM; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ardULIvq8RJ9uz0QKRA+5epkrep3WcLcWlB0+sYWG2oh6rs7ZzbZy00r58daM4yJZSX6ChUf3Ml3jzZrZuw4/autRuoZLU0kfrD/ir1EBECNYVUJ0CgkQCRlMNvDsf+pLKTjoDM1F+ggZ1jcdNihJhRK3n9bEfQt/mrO2Nu9B0Y6R6VNYJcpcSjO0EIsJHzbCp15PIVH3RLfL3gbJhr8Ye4M3J+YdgPTDLmOH4FFi6jap5loSlzY9ZySWF1NKxLfaELuwHg+M3CZ8GdbqmzZHlqIZ5QPRdxYKLCo3E0Y63QOhwz07V88VzbFN0jZ547E5SCjK5ojUvKd/JYoL8rV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN3eWKCowuMpK99awCwCq63kEy0/+WIkDoi9f0tBmNY=;
 b=wj4N6d1kJ3eockcvimSIBGwEubxag7anleICac3qHXPgzkiJtwxSh9Q5rzl9chsvsFLrja8s0YrHApjJnzSFlzRz2D1mzLEzfDK+NLlgb/pHM5LegT62dIfCTz0xecn7Z9sYnhiOPWnqlA7giibvNKp0XS/M31X8Kl19wXjHbDo7R1b/SNRoRZr68+5uyYKSbSSvSbSYn0+rr4Mk0DQDjxkeDJFI4E+8mtbY5vtvR/VN+eejY8T1kd33Ml8NHKLrVNTteXB+VKwT0KYzawVCZk4nXSS6elGdyhxNWvAHrb4XyrdAdoxQcGHeR2Qm7//Iik3o/gdNf0GD5657gqXpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN3eWKCowuMpK99awCwCq63kEy0/+WIkDoi9f0tBmNY=;
 b=Rls+gdQMptveRXILv595Xq4osN0YJFxQq1tIj8OFnLaf7aNrJG97ZxBKftYck0mpw05l53j65EDiIQi6oaDH+GkP+/3rcRSJ9DaztRBlpwj918cvBrWLEByKMf0WdTMqfHmRouQypt1UJ1u+Z6z32TWhIXBa1VE1QLT4PcSniJ04BzY18xYrHzcKW9cSIJ14MEbRbrPqqHMbwlB6auFJn+XX2EwvReKoCsyZhXXHW52mR5loiW1mka6LIKurpQYTX8hRDkT7nDNoiwG+zwqTb8s4qa5LRjMLk0AD/67Q5RPfoUPEvWCQWbNZokOfBdJT4eS/qz/t/LtyCwFmQX7jtw==
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:54:41 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:174:cafe::17) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.4 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 20:54:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 09/15] net/mlx5: Remove vport QoS enabled flag
Date: Mon, 14 Oct 2024 23:52:54 +0300
Message-ID: <20241014205300.193519-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ac08b2-2fe8-4072-ae1d-08dcec926cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fOl+iZwUVOZKEZhoSkxwo2xcOg9abMYnm/M3NLcPtZXEmqsVwH1GrVWnsX1x?=
 =?us-ascii?Q?+rRyKXjTxPwukWb0Reggt2iZu/8z91NZaHHcvFbjXOE/VJk1ZxZ1733TStjG?=
 =?us-ascii?Q?YM47D8W33OF3qBv2h2SjGbB1fLOcCrwa8KtmDZ1K70/s9XrKJNcobqL54ZKc?=
 =?us-ascii?Q?yIJCAUf4V/pCBtlb4ivzCcSehUcTH5FxRokWtvTgCKMj0UeTe3PFo/YbZKQ0?=
 =?us-ascii?Q?XHZWLuITZkE0yfRkA6OvGi7v2mz8QT+oRXOzcPcvXwBKtNtbPj2JRzT8QYNT?=
 =?us-ascii?Q?2yqDkUtNWqPfo0wd8wF5Rh+pgMddNAGd5YzmvxLnZHSRreuvBsciZE38WxV+?=
 =?us-ascii?Q?6f8DLDXFPbIOwG6SPuhzKSBzvxVCWCxMSsuDf9+Icd/yKUdYtSGLwhBZQVRD?=
 =?us-ascii?Q?bxqfsTpciA/peSdkmC20NdXxX/NgxcgqkPIZ333dl9LqpCpwUbV8kPb+qY5r?=
 =?us-ascii?Q?a+BMTwlQeC2S2bDiQpZydE3UKMyM+P4eoYBcv8g7RFZCeNFNAadeJelXvzSd?=
 =?us-ascii?Q?8qw2zLrWXsfo4NwccKIc+V53K58cMj7HP2+qlgAJIq0takO2xjaB0r7Ja6NW?=
 =?us-ascii?Q?orGNw2Ug/18tlN/U1X0QYHRrJ97NnWaJfFJmvuWfirbOdUJI/DL74fYkqUiG?=
 =?us-ascii?Q?1/EdCy3zTVKa48AqB1OG6CmwwYkKF3ULKf+3ougfPrrxa7FAn8AxsGBp5mBo?=
 =?us-ascii?Q?7b9VPjm4hVu07nhdgFDRS5xotsynsILXNgQZQfuh+mFBSUwFj3Ukz5YWgDPR?=
 =?us-ascii?Q?iWzL8eTpzkSghqywwwZca620XYQOqH0cwwfV8Jx2Hg5q1X6GcnqBfnzmc+pq?=
 =?us-ascii?Q?ylLWddJDDyFSsAt9bSLibzXPxwDbaaOnYKUUzz6hmQplNNEN4B+EuX538cws?=
 =?us-ascii?Q?XAruXpjhRR0UbKDMi5yqvDsb4r1UFCZ+ST1NakZepBdS9uuQY3gwVr6kDkue?=
 =?us-ascii?Q?y27ckLYawIeM3vlu2K3xsK6Mz1/0rwhT4GPraJNjJkwOj3LOGvhksk+vmghK?=
 =?us-ascii?Q?vutK6me6FrJ3AAI5SCjWqSsrMnLopa6rj4nvs0jvZyuMr+BvKR9W/+OM/+gL?=
 =?us-ascii?Q?pXuK/EJi/iL2nR3EabSfia6Gdr7D3d4VxLm2mBYexwjONIwnJ2MdzczNMrVF?=
 =?us-ascii?Q?6V9S7IigXu0j3D4yIarxoTq7Nj2zwY5AbfL/1odOcRmHwhnJ48b6OHRqBc+R?=
 =?us-ascii?Q?e/ovlHupdwXfT65hfsCpM2A3Qe83tFpYwPt+9UomQUAJbjLLaUBzesVEDnyE?=
 =?us-ascii?Q?Uu1lyH+WaRlP6cm7et6tj4NhQmYqA+s+BknbxB5xtHk51/olaYpDzPwxuG4V?=
 =?us-ascii?Q?OtEf5RTVUWnWLuqQlUlfBTZxFTNn3QbyqoxWXyVGuJTIv3G1POHd2jb5TV6B?=
 =?us-ascii?Q?1B7HxlBDVZHY0lQVClNBww5wXn3Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:41.3594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ac08b2-2fe8-4072-ae1d-08dcec926cd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

From: Carolina Jubran <cjubran@nvidia.com>

Remove the `enabled` flag from the `vport->qos` struct, as QoS now
relies solely on the `sched_node` pointer to determine whether QoS
features are in use.

Currently, the vport `qos` struct consists only of the `sched_node`,
introducing an unnecessary two-level reference. However, the qos struct
is retained as it will be extended in future patches to support new QoS
features.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 13 ++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 --
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index a665b8990dda..b36fbaf8ead0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -742,7 +742,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-	if (vport->qos.enabled)
+	if (vport->qos.sched_node)
 		return 0;
 
 	err = esw_qos_get(esw, extack);
@@ -761,7 +761,6 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		goto err_alloc;
 	}
 
-	vport->qos.enabled = true;
 	vport->qos.sched_node->vport = vport;
 
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
@@ -787,9 +786,9 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 
 	lockdep_assert_held(&esw->state_lock);
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled)
-		goto unlock;
 	vport_node = vport->qos.sched_node;
+	if (!vport_node)
+		goto unlock;
 	WARN(vport_node->parent != esw->qos.node0,
 	     "Disabling QoS on port before detaching it from node");
 
@@ -836,7 +835,7 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	bool enabled;
 
 	esw_qos_lock(esw);
-	enabled = vport->qos.enabled;
+	enabled = !!vport->qos.sched_node;
 	if (enabled) {
 		*max_rate = vport->qos.sched_node->max_rate;
 		*min_rate = vport->qos.sched_node->min_rate;
@@ -933,7 +932,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled) {
+	if (!vport->qos.sched_node) {
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
 		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.sched_node->bw_share, NULL);
 	} else {
@@ -1142,7 +1141,7 @@ int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled && !node)
+	if (!vport->qos.sched_node && !node)
 		goto unlock;
 
 	err = esw_qos_vport_enable(vport, 0, 0, extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e77ec82787de..14dd42d44e6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -214,8 +214,6 @@ struct mlx5_vport {
 
 	/* Protected with the E-Switch qos domain lock. */
 	struct {
-		/* Initially false, set to true whenever any QoS features are used. */
-		bool enabled;
 		/* Vport scheduling element node. */
 		struct mlx5_esw_sched_node *sched_node;
 	} qos;
-- 
2.44.0


