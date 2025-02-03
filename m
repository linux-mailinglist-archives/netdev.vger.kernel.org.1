Return-Path: <netdev+bounces-162272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11046A265C5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC883A5D49
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559C211291;
	Mon,  3 Feb 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="THCtPYJR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB120E71C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618619; cv=fail; b=WpPFS5xtMNcOZMpAjZExJiAdpNMYZeFeSB2VP0fePSoEpCk9/jWTbFJdz3A8c+q0ttaMeu/HH4lILsHeK7qe/E8Aqq5HC+g+MYisxPL3qUPvUj6Y4ruZkm5DVRzlGIHhH0gEErzQgf9BZFU2n/BFrZR6dFHA6MtdHNd6QgZm0i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618619; c=relaxed/simple;
	bh=1LnzjVtBJcaaGMmg/KNsU+PFxrfO4MVtT38jhxwc2q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmwMKsGoupiBWqsfAvbkjKQd16HHOi9vtzbnfvfsvlR65J6wsIU4wAR0h8FoImbD5ZWtREAkUcROALN8ieABEVOKV08t1QdlDTAy6s77Crckn2seGCbtUlvozfFxtwdTz/gAoUNQCFlTuAxKg/iHbk9Meha0R722Dd+OBNboxdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=THCtPYJR; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYQAP7k98+vYEwOQF1w7JZHfd615QNg+ixvfPP44ozDre5fLRyYX2BQ7zRjOFc08O4QdLaasUBS0rJrzVqBDzXfm8Wts0z6JGgghIYV+91q9xZqeDAZlMKkRyYwv0KjLYWVA67fDoLfAVs8gd8K9JFqRgOfAQliowFDum5zmvQYb2C9L8lxkf6t/e6X0DHrn2mKNv1paJ+s/sc/MJ5a9HPKvcgc9qNOEaERBEazJRHZz84pD+afm95d0rBG4Sjdr1ZseX7H0iHeBBIov14/QD/ZQTNjjSkvYC6TY+vcn2/0XYdBxGkOMdKpQyUy94hIU/FqSLGlo4GQadJJzGBfExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0nZVfOWaiJKAvs+VA6YYwxoHIi+IdeV5bqKDYlKfLw=;
 b=ewsxISq1IU4A6yTMsEXQaF2uBzSYl276kB9qOPVOevIPCpvsx0qvBHylwJ02y7ZnkoC0mzZZ2esuv5i7+Wwj4yzV7etjWrtliqaHOSn9gKyg7QfB213viRpNifpU+KP6WJrQrrmOqHaJyop7kcG/AS4180UDjhf/Smc77w+BoktIWJzjuAtuoFurXIcvZtVQHT/6mIt1JDVnW7pSpJKGinv7OBhDrAcTg05QnYsWtrJlZ2rGxSxSIQXZ7LDlx0dXNI1c9grKib2000QEEiCLG0ejLoKfnIK3oYTpHFubEDbjz1Qu2WMau2KNFViIJUMNUbVslF2Mo/O/Zn3IgnPK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0nZVfOWaiJKAvs+VA6YYwxoHIi+IdeV5bqKDYlKfLw=;
 b=THCtPYJRcPGSGgPO9Ymf6d4xi3pNCaau/HhV34bYsZSTNCTszd2Ei4SgF6IH9tV8S3bR+yHHGurb8zivSB2PA3ZRwaDeqAeTY8xcVew1/mmrcup+4D+Z0if6IwWGWe4sS8hptb5tBaQJMRORB6UFtUtH1Xg51lo9jQ/3LvWIgoMnMGbcL4cVaI6/6ZwG9NU1xNBKfyHLVdOuH51FIrE3qLAVjbntJFiTJRuo64eEAIRb+5biTVudR5zH+4kqP9Hea6f8/zE9JNhMKHxd1QQuLLzLe1xWQW9FcGCbFlNsSBilfNsvmAs/LuzHGyvj5OKPd/RAXkzbX0c3563gR1ciWA==
Received: from SN7PR18CA0020.namprd18.prod.outlook.com (2603:10b6:806:f3::14)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:36:51 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::c1) by SN7PR18CA0020.outlook.office365.com
 (2603:10b6:806:f3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 21:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:37 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/15] net/mlx5: Move PPS notifier and out_work to clock_state
Date: Mon, 3 Feb 2025 23:35:08 +0200
Message-ID: <20250203213516.227902-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f4e1a4-20ef-4680-ce89-08dd449adec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C576PNFQlknEpEbSKaDKWLkKMwR2MWORHQ3Woor8vnd/IX4f7tGuZ2xFUA9H?=
 =?us-ascii?Q?2tGNqFukxgCC7S8BKQ5/WwI7WYn5Jk7VkMpdH7EIUYKttNCLVho+1AhXNjer?=
 =?us-ascii?Q?a0B9qPoWIysl9bupXEmZ3zR40cAToiZTdbQzKXZxlQ6FNRfxvOcp3xzw4ztt?=
 =?us-ascii?Q?en3CWlhAzTLYG8NXxbb3umNNKKX9qkXcw4hQCPH+vAMUtaU01X0VOk9lBo+E?=
 =?us-ascii?Q?w3oUwAMImZF90q4sssKPe6BRbPNApYktCgn0Td836gwLBxrWnE2lhKMDzRCf?=
 =?us-ascii?Q?Y+RfazYOYHKAJWToucrOyxburPG1ek8kFq/cR2ehs057joKknMb/7DsSu/RO?=
 =?us-ascii?Q?Adx9wBot7uKtEHoNf2F/oyQR/n7YpQFQ2w2oMa0ofTQhw73E8huvWMeIvhgO?=
 =?us-ascii?Q?9gQGMJIYTouSFf2gqW0dKOqAR5kqmtSu9wrlDIHanTk3V8ocmAAit1TprduP?=
 =?us-ascii?Q?2J5YN9DNbCeKvQFVUQV8Uv4461yw8m/H5Ky2bQd1DHHC6pFaar6NbUc++Ffn?=
 =?us-ascii?Q?aYKBXs31DVlx0lWlI2//D3xNRGDuBEtb6RF0cNmDAHaA+lCuMZjcYT4sofIw?=
 =?us-ascii?Q?zVtpTaX/kv3J2y5Djlo9HDvegXSldjhITrOf1xzO9Tu67lnnRPgZiRxsFlE3?=
 =?us-ascii?Q?OBFUMbbv4WTDDMYzkubSot/6ug3g78HqjItfxTuotSR/p3Tf7gTwE7DmhuHk?=
 =?us-ascii?Q?Kf779Tqd+MQJ9zhSJ48kTAMtqGfkJkr0unLRHLlzXkyqRuFNWhUq0yX0BTfN?=
 =?us-ascii?Q?bNiJUseCApEpWmXV5cc7O3bcbKc/xRsV/qIlvGee5s1zbz+aZMUCRyTwl3zO?=
 =?us-ascii?Q?V7OpF+V2WbjrHv6gVs1K/idu0KSV6z4vg2JuSc/CIjVkpINf6qvRjbcFjGCu?=
 =?us-ascii?Q?l35TydNDbbghA4DjBrHVz+8fPDvGAVPQdTvBWKDg3cTi9E/2Ybitq9jKl7Dj?=
 =?us-ascii?Q?xK+WZAZX918y0DoK1Zk5fpX5GeFuKVDmzdV0K1O3QuwtGizm3R82KnHNEiYA?=
 =?us-ascii?Q?5P5gk2vgPRCKPFtv6stbMELOGRqIImy5hYwbjb/hOeoueNFk+4ELaLXNCc4e?=
 =?us-ascii?Q?LjS1rri4sNIGAn4f0Kpf4jpD5sbEH/4dkpgKo/627ngHscV5wLSDBUIlP5Ln?=
 =?us-ascii?Q?+t8RNRL3Tevr6GxqN6WcCcla3tIG/ooEepzHXF8YUqsUslSpw1fmY5XH0xz7?=
 =?us-ascii?Q?8eQlASV921pwKR2tM8QAW8oXeZmvlBIC/o2gPIMK4j1Isg7NGGB3cUrG0VM9?=
 =?us-ascii?Q?EqBoFOYooIHdrK+vvHQkq3aFccOf3vIZOd7vT71NpiKKsr2YAK05ahoEvxJ4?=
 =?us-ascii?Q?S6gcs5FK4cNgOYCu2iwj6popMHZ0PjaGwTavEhV6ltipNEva7lUXQxpvi/+l?=
 =?us-ascii?Q?TftXrUCEgj1Mu352OJzwZcGrc9iedVqfXwyFkOVdryTiV7ds8JfGu9Rxxn17?=
 =?us-ascii?Q?ykbCWLdXfBLsRjQbkOIpsrp+/xFP+F2s0foWlzuqBWFbhYtltRcETKAHVuVE?=
 =?us-ascii?Q?u/jDNxh3KreP8Zc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:50.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f4e1a4-20ef-4680-ce89-08dd449adec7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510

From: Jianbo Liu <jianbol@nvidia.com>

The PPS notifier is currently in mlx5_clock, and mlx5_clock can be
shared in later patch, so the notifier should be registered for each
device to avoid any event miss. Besides, the out_work is scheduled by
PPS out event which is triggered only when the device is in free
running mode. So, both are moved to mlx5_core_dev's clock_state.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 37 +++++++++----------
 .../ethernet/mellanox/mlx5/core/lib/clock.h   |  2 -
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 7e5882ea19e0..2586b0788b40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -80,7 +80,10 @@ enum {
 };
 
 struct mlx5_clock_dev_state {
+	struct mlx5_core_dev *mdev;
 	struct mlx5_devcom_comp_dev *compdev;
+	struct mlx5_nb pps_nb;
+	struct work_struct out_work;
 };
 
 struct mlx5_clock_priv {
@@ -336,11 +339,10 @@ static void mlx5_update_clock_info_page(struct mlx5_core_dev *mdev)
 
 static void mlx5_pps_out(struct work_struct *work)
 {
-	struct mlx5_pps *pps_info = container_of(work, struct mlx5_pps,
-						 out_work);
-	struct mlx5_clock *clock = container_of(pps_info, struct mlx5_clock,
-						pps_info);
-	struct mlx5_core_dev *mdev = mlx5_clock_mdev_get(clock);
+	struct mlx5_clock_dev_state *clock_state = container_of(work, struct mlx5_clock_dev_state,
+								out_work);
+	struct mlx5_core_dev *mdev = clock_state->mdev;
+	struct mlx5_clock *clock = mdev->clock;
 	u32 in[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
 	unsigned long flags;
 	int i;
@@ -1012,16 +1014,16 @@ static u64 perout_conf_next_event_timer(struct mlx5_core_dev *mdev,
 static int mlx5_pps_event(struct notifier_block *nb,
 			  unsigned long type, void *data)
 {
-	struct mlx5_clock *clock = mlx5_nb_cof(nb, struct mlx5_clock, pps_nb);
+	struct mlx5_clock_dev_state *clock_state = mlx5_nb_cof(nb, struct mlx5_clock_dev_state,
+							       pps_nb);
+	struct mlx5_core_dev *mdev = clock_state->mdev;
+	struct mlx5_clock *clock = mdev->clock;
 	struct ptp_clock_event ptp_event;
 	struct mlx5_eqe *eqe = data;
 	int pin = eqe->data.pps.pin;
-	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 	u64 ns;
 
-	mdev = mlx5_clock_mdev_get(clock);
-
 	switch (clock->ptp_info.pin_config[pin].func) {
 	case PTP_PF_EXTTS:
 		ptp_event.index = pin;
@@ -1045,7 +1047,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		write_seqlock_irqsave(&clock->lock, flags);
 		clock->pps_info.start[pin] = ns;
 		write_sequnlock_irqrestore(&clock->lock, flags);
-		schedule_work(&clock->pps_info.out_work);
+		schedule_work(&clock_state->out_work);
 		break;
 	default:
 		mlx5_core_err(mdev, " Unhandled clock PPS event, func %d\n",
@@ -1271,7 +1273,6 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 {
 	u8 identity[MLX5_RT_CLOCK_IDENTITY_SIZE];
 	struct mlx5_clock_dev_state *clock_state;
-	struct mlx5_clock *clock;
 	u64 key;
 	int err;
 
@@ -1284,6 +1285,7 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 	clock_state = kzalloc(sizeof(*clock_state), GFP_KERNEL);
 	if (!clock_state)
 		return -ENOMEM;
+	clock_state->mdev = mdev;
 	mdev->clock_state = clock_state;
 
 	if (MLX5_CAP_MCAM_REG3(mdev, mrtcq) && mlx5_real_time_mode(mdev)) {
@@ -1301,24 +1303,21 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 		mdev->clock_state = NULL;
 		return err;
 	}
-	clock = mdev->clock;
 
-	INIT_WORK(&clock->pps_info.out_work, mlx5_pps_out);
-	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
-	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
+	INIT_WORK(&mdev->clock_state->out_work, mlx5_pps_out);
+	MLX5_NB_INIT(&mdev->clock_state->pps_nb, mlx5_pps_event, PPS_EVENT);
+	mlx5_eq_notifier_register(mdev, &mdev->clock_state->pps_nb);
 
 	return 0;
 }
 
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = mdev->clock;
-
 	if (!MLX5_CAP_GEN(mdev, device_frequency_khz))
 		return;
 
-	mlx5_eq_notifier_unregister(mdev, &clock->pps_nb);
-	cancel_work_sync(&clock->pps_info.out_work);
+	mlx5_eq_notifier_unregister(mdev, &mdev->clock_state->pps_nb);
+	cancel_work_sync(&mdev->clock_state->out_work);
 
 	mlx5_clock_free(mdev);
 	mlx5_shared_clock_unregister(mdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
index eca1dd9039be..3c5fee246582 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
@@ -38,7 +38,6 @@
 #define MAX_PIN_NUM	8
 struct mlx5_pps {
 	u8                         pin_caps[MAX_PIN_NUM];
-	struct work_struct         out_work;
 	u64                        start[MAX_PIN_NUM];
 	u8                         enabled;
 	u64                        min_npps_period;
@@ -53,7 +52,6 @@ struct mlx5_timer {
 };
 
 struct mlx5_clock {
-	struct mlx5_nb             pps_nb;
 	seqlock_t                  lock;
 	struct hwtstamp_config     hwtstamp_config;
 	struct ptp_clock          *ptp;
-- 
2.45.0


