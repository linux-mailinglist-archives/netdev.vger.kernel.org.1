Return-Path: <netdev+bounces-135321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197A99D88F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F57B1F21AD2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC4B1D0F5D;
	Mon, 14 Oct 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AV/9pTx3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EE1D0E05
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939258; cv=fail; b=BY0t6bwfxxExq9Dd7Ujlqwh7YnaE2Pccqiq49+19750C5MUWFuOKB/BK4RDBObpMnGrDMODbJvGvBFd5VHGIweQa1h36xYWzraFDsT69Tmg0M4ngx0wCSnHrgQ5zK1lBlNIUT1Xo3JepuTWt7sS781nYSh+xp6GnvvrcEriBxQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939258; c=relaxed/simple;
	bh=weMCZS39IOKCF+hKMXNbsD+dX5AKEe6J1hDxl+XqDLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edJNvghys/vWXRB2omC49tlbVseggkiUkoWfakJCyNu5HIf7HSxI3LkWihqiV4sXQPj8JMrukRduxYK7pZcTDOjfx6KGA+8312YH5K3JM9wdKfNSB4i4mmwaFGHJi2E9l3Rg8mUteWPXT/JXNXzOJgNv7WuyF1N5HroZLctXcZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AV/9pTx3; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX+RBStWiUy7P3kZJq3kw/OJ1xEfQ1bTsOfe/GRiolzD7hePjP3prApbj58SPkqu42uMHG62I7YQEQo5q1zFIMSBbAKWlC6kU3ln4z/kvWD4D3SCwjBlnTqGAT1erizr+mYBRBgxnWrk4fHVmdBhvFXUF8yWsvQg16p13O3Cy4Ms06geTSVwclcOeetAQwTtfjmwrLkdSFAHL8rOeoxuZru2Ro1Dvbvw+xPaHAPIqKIRH1LNeQYqr9d7p06sMVBASHgXy/Lmec7nxeWcip5MavzvAJ00ZfEdwpibySULZWrMzwnSTIIYQOMX+asPJd0aqEpF7ExjF1ewDLTyAaVkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5bCgS1PIpHXIzENYErpe9PopDJLKHrzX0iMvdqJ5+E=;
 b=HM6Qppwp4YIHzk9NzKok76FcGccjemplF+gldt0FWK8EacomOxqu07MwKIZeeBOZ49pntlBiWPGz+n7kdUI05B9HSewn153bWB9X4VSrXPE8nmW72+nuo//M6Isye4Ax40QjwqIOjAHq0htShYRtdz4y/AcMjkGhTua6SwqAneFGCySnsUIR8bReG9ROHiG5p9DKCvpVBDK7vSJA/t4T3JHEa+QqujZrB6bkSSJQtotibUfBzTAQw5GkQM5f9z2CKlvAGkOBtlXtSwYeqysquD2DaUFYPCD3vk06rICtEzSA2ULBfKd/TUQrm+XXMmZZH8EC+BPMP+KyLzQff6uVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5bCgS1PIpHXIzENYErpe9PopDJLKHrzX0iMvdqJ5+E=;
 b=AV/9pTx3fmxOcmg61W6Ot0Tf/n6EhisVCEsYynriVnGRhdzurwQGxuiBsqfdt2hVf2bW2TiskkQEzzFU2iqM+zrQFH6j4ec0hZokg8F4FhXtqfJq2LelTv5I12k+Lxch/fMZuQb6rv0Y1wDV7BYmm+rJ2rXHqB5uyMRKEodlr+cyj8v5jGYH/APG1fcoMQHhqCYL4ddsfNkovZOr/sGtgp7I1/mPeG2D5i9+OKH0/nw2g+W2aLcPeSe++N0oscflB9b9UCUnF1/LjXMXxhbx1QsPQXMj9DKilNI2gWzr9j8cF9Pj7Zz93hpkrR1XkDNfyFgfHbGWFsoNMydNg9yZQg==
Received: from CH2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:59::26)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 20:54:11 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:59:cafe::c) by CH2PR03CA0016.outlook.office365.com
 (2603:10b6:610:59::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 20:54:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:53:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 01/15] net/mlx5: Refactor QoS group scheduling element creation
Date: Mon, 14 Oct 2024 23:52:46 +0300
Message-ID: <20241014205300.193519-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 601cedfb-c0d1-4eee-8766-08dcec925a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WnAtDlvOXGJ6YTSvauFBt1+mto9OZzpHsuW6kKnbfEA/ChKI3oyxF/yBqzXa?=
 =?us-ascii?Q?ej1/+7NqXLVZ1aSnqgobZ3dnGDkrPkN/qeinWHhnagWAC7aEjPPr1bZhIAF9?=
 =?us-ascii?Q?jBdsr1KtMfwKq8WEvXvlmawJfIhx9q48JmODtVO9S3UQMfotPbsk3oTBD7oH?=
 =?us-ascii?Q?ZM8VKknUQc4zrMGcgCAvCILWYIw8LWaOS4pUg5ItjrANIbxws96uFu9ifI2k?=
 =?us-ascii?Q?m0p5esfT8VWfRlC+CXc69BbK1CeF4D4xB4agwONaumemcaGNY5DsU4GZOC49?=
 =?us-ascii?Q?0WfubFuPuUD8pFNZ91WdJ0ZFc6zxKtPgC38JmvtYJXITm2dXNZ/awLdEovHO?=
 =?us-ascii?Q?ghgmpgGn0gdE6CbQSpGu4VbQ4gg5Zs6v9JHUBb/KympO5TS0kf4IOgzaX3DN?=
 =?us-ascii?Q?oC62JZxq/JKBB3yME/U0wdyVg++ac8K6LwCm3ZQWDeLlA8qXAaKDHy8j1pxI?=
 =?us-ascii?Q?eSGLepJennNbsYJR5cqPwal2Y3FYmCmNySGKN4Roq6WptxuTKUiET5U2quEK?=
 =?us-ascii?Q?TJmCE5uc80QDFvEQtbity/PUf7mmPtoyjDaphY7sBOYtdmcvOQZhZTBc6Ufi?=
 =?us-ascii?Q?lz7JRj3F1WetIx28mZbuX+x/17Gr7qtG32f1nlGVsy9ia2CK+5bWZD/Jo6T0?=
 =?us-ascii?Q?mkgpkLHrGsTZcwhI7e8oxd1wldrUPBX28duuDJuqDN9oM96E7SM7iolMTNON?=
 =?us-ascii?Q?oETZ4feG9Hqi+wy2cTCLrs7j5lqq7a+oj1ZPC11zdL6eVV79A9BX1s/Z1BL1?=
 =?us-ascii?Q?ql0x7Zm2FJy/q2g3/qP/bpSWzrnNMrfeKJakQ/7EbfX2OHEgBcrqmS7JHTIu?=
 =?us-ascii?Q?+dRAPdMG7wCa2A4AboCSULr73rea/pfkyv3Cydu1VqYROoH08lQrd7Go98Ii?=
 =?us-ascii?Q?YgTdB2B+qBtqGN0vdGQDxssWeUCR1eZ6hqJuTtKkscNx09erR7gC7ElXskCQ?=
 =?us-ascii?Q?2XfvRauAulmbnqTW3QRsFzLmr4ecCviLjq5B3XF/nc+kHNbl41oSL9bzvz8X?=
 =?us-ascii?Q?e2zzz2lu5M9ASu9CDyFT+5/n68GPGVKJGrRRPIrY9nEZdINYLQaEZYngvgp1?=
 =?us-ascii?Q?EWUWz/gEbsHDkGd1gtx3YlCtfUouLmkDToO+XP/s7prbDTGqmd27zO57d9xc?=
 =?us-ascii?Q?ZJ3p/ytihJaKK23muaptdQnrDYTpzHWyAdBgDkiNMaXkrDa0jyfAiCIyIjD7?=
 =?us-ascii?Q?IkW2y0rrD+yA5rzz908wG8k+o4Ja625tlcJQ0W6cqKQpu5o8916Jk1i5mY2p?=
 =?us-ascii?Q?ySb5QIF2a2w9Bg/skifq+FTzB3h7sNNnRGakjRlR2KccH00OUnl8pAydkw5L?=
 =?us-ascii?Q?ng+jd/RPvfSp07CETaRHzj6G3b0OqDF0U2R2lRRTariVo0n6ge9t0aywRevK?=
 =?us-ascii?Q?HrWPvtnFK762EHCMTuuCXj3qehnO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:10.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cedfb-c0d1-4eee-8766-08dcec925a7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `esw_qos_create_group_sched_elem` to handle the creation of
group scheduling elements for E-Switch QoS, Transmit Scheduling
Arbiter (TSAR).

This reduces duplication and simplifies code for TSAR setup.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 64 +++++++++----------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index ee6f76a6f0b5..7732f948e9c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -371,6 +371,33 @@ static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
 	return err;
 }
 
+static int esw_qos_create_group_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
+					   u32 *tsar_ix)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	void *attr;
+
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+					     SCHEDULING_HIERARCHY_E_SWITCH) ||
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
+		 parent_element_id);
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
+
+	return mlx5_create_scheduling_element_cmd(dev,
+						  SCHEDULING_HIERARCHY_E_SWITCH,
+						  tsar_ctx,
+						  tsar_ix);
+}
+
 static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
 {
@@ -496,21 +523,11 @@ static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
 static struct mlx5_esw_rate_group *
 __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
-	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
-	int tsar_ix, err;
-	void *attr;
+	u32 tsar_ix;
+	int err;
 
-	MLX5_SET(scheduling_context, tsar_ctx, element_type,
-		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
-	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
-		 esw->qos.root_tsar_ix);
-	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
-	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
-	err = mlx5_create_scheduling_element_cmd(esw->dev,
-						 SCHEDULING_HIERARCHY_E_SWITCH,
-						 tsar_ctx,
-						 &tsar_ix);
+	err = esw_qos_create_group_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
 		return ERR_PTR(err);
@@ -591,32 +608,13 @@ static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
 
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
-	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = esw->dev;
-	void *attr;
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	if (!mlx5_qos_element_type_supported(dev,
-					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
-					     SCHEDULING_HIERARCHY_E_SWITCH) ||
-	    !mlx5_qos_tsar_type_supported(dev,
-					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
-					  SCHEDULING_HIERARCHY_E_SWITCH))
-		return -EOPNOTSUPP;
-
-	MLX5_SET(scheduling_context, tsar_ctx, element_type,
-		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
-
-	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
-	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
-
-	err = mlx5_create_scheduling_element_cmd(dev,
-						 SCHEDULING_HIERARCHY_E_SWITCH,
-						 tsar_ctx,
-						 &esw->qos.root_tsar_ix);
+	err = esw_qos_create_group_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
-- 
2.44.0


