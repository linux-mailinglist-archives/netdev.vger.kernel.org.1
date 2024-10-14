Return-Path: <netdev+bounces-135332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F599D8A1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7169BB21C99
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E91D26F7;
	Mon, 14 Oct 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNBqosxv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1611D2238
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939300; cv=fail; b=dXAOx1v2gq0vFSLQlqEk6wfrZJ8zR9XuE1NiJYiGJX/L8ieYeXgD1ST2bsaoitypA8FwL44GUBaISeaTKHZre7kywPyGB2izS4XCknpbrBV/HwMaYPyM/1G9CYRl6AEVHtWcjNv2M+trIc4HYUst7R1qGD1hJexpx/ba3si0PJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939300; c=relaxed/simple;
	bh=2TcKTPp0bKnP/mWG1aiVa/q3LWtt41hAOhsXyxShtXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azldG/6iHJ14SQaGkmdSm4y+y2M2yjhMLwYZgT6NDND09CvPkbXJthC34jll46idC1O3FjGpv6LHv5s176G0fb2e32PLW8h6j8wYWanQCxr+To3nl9m5mikicooUudPTji42/0BOiomUV0l6Io+hN10RCIsYR3x3rfYgZB3twWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sNBqosxv; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shRLgn4bp+A6UqjDlmQ6FxBZpYbD1wFhvM9Pya/DkRhLiYQAcwkA7ZxRK3TspTUT8TSr2et1oAiGIroEQ3qT1OkI7A1D09k1GYYHgNyRNNlhd8T8+fkOU+1u07q3sAJLGjC0VmCkLo4u3POxxoFJ+fG9kFYa+Ks1b9qcvHM65/Shz46tUC3A0iabnrnccScLL7GT7Bqp3CuyAnXiMfoXy2FlCmKhdm0ggRzSYZr45dEnt2ielXS6osvGw9ZP6VMucrtPObvOOcm3ZAizwOxw/1i2Ne4WhnHf6Aw1RbOXKakO0uB0BrLlBi6gGTOmVgpBHoHatEMnrzt+ZhlJo2zqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV1/mQR5oVJudf1fDkcVH8tyGjewAHXQXSphYh4Ty+I=;
 b=uAuKZwrSKn32YTt6SdzBLs85B0qeZiBPOMsdT5FWIu3QaLn6QumIdVDhub0co1EFRuXfNOl3KG2yf6qID0qUt/a1EQqP0kK5qo0KfCZZRheMYDFxWWYZUJ68W6CROHwSHnD3ZYkFnzskiPbP6cXb7diK81/jBJVBsrZuy3KhtPYivLXzONeKThAeFvPlPGhhoxfMwvA6rJskSog5MGzLzh4Nehl9jt3fgnJrvPscuZAngYAr8UpqJeHBczLQh7DbKiQRue78OSPGZ2bnQ2I26AedPiYUsLam/1QiXS3xOjFgfNJ7AbAyddn5HNNfDAGZ3Mz06xGrIFpgexH4Q5fTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV1/mQR5oVJudf1fDkcVH8tyGjewAHXQXSphYh4Ty+I=;
 b=sNBqosxvW9qWzKz8AIX5pMqrbkpjX2omkhieI0WgWtSe6qKbgnjyc4EUG6VIFwQe2umoOotQWnXZTuQAj3eqCPyyZKHdUo/QqxLQBMPoT1XgPBrzOzDlTyd9107gkbWRCblzWjDmS9OyjCEk7ZN27cOTfE+Gegis2vY1oFJ+1pJc6vzUagM4u3bGM+S2SG8gY7m87jB8jfjiNKFM9gxXOx4vlcN7jdGfa/A6ZZcoeFq33RZiEO1a3BLVSBpbr/RrX5Sm5EQlHJzbdfQNeRfd9UY6XioAIML7Godjpj7dUmYFvZxuElx+l8AUvH2+UbSZiftphrb9y/p0bzvfYm0J9w==
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 20:54:55 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::20) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:54:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Aya Levin
	<ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 12/15] net/mlx5: Add sync reset drop mode support
Date: Mon, 14 Oct 2024 23:52:57 +0300
Message-ID: <20241014205300.193519-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 3366c018-dad5-491b-2185-08dcec9274dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbVRZGSiiRrXpKOmWWk5j3uFyTFcw3AYt6Sup/fu5FVl9BOQZFN0qlc83Qx+?=
 =?us-ascii?Q?Ow87XXTco7HAl3tCofoX8KZ7MkO0vBcx9BIKQ5x9TgdiLVRzNtrflGf8Vd+V?=
 =?us-ascii?Q?bEPl6Xsn3a9c/jJah2UtrxC2ZLbgT2hvHb0YK+r1WqrsOo9GLGLfxmh5ZSYK?=
 =?us-ascii?Q?HH/hlc0uVXgVJI+AgX21CyePRh4+R/oHK2Iz3QTWnWBHIy2h0aNeLs4+dM1g?=
 =?us-ascii?Q?5p94pPu0/RZT162jbHIBH3yceEnDwgJjYabd1XuwWHLcTz14vykzeNvGN1Kd?=
 =?us-ascii?Q?SRI8MhutSt/Jnk0+tdN2K+V8e/hBj0NwUm3I6EUuuFnowU6FWFOO9CheP8pu?=
 =?us-ascii?Q?oOokrU/3HxAFkdLBuvfRGMfwm8xAFNLpQv8+8FcvSYU6/uTtMnQar3A/O04g?=
 =?us-ascii?Q?+0j2et8l1U3a2l/FPfUdFvjvs29hHDdBsVSuoRXp06RDmV3C0eViDI1cYX/R?=
 =?us-ascii?Q?tjxc2PPr3k0+hd3Q9XOv6ZDpEZ3YpXiPmlFMQi9nOc9WpCMw0QW3QpcKX5dm?=
 =?us-ascii?Q?WfC05tWri2kjM4ZTt8xeYFkchS60TMpcXGRr5Ie0wBcmSYaV5LAB8KTXPhnw?=
 =?us-ascii?Q?7G9FPN79cHPHgix67snCXpWBnqF0VSDIV6dcYNpfMwxIZF4ZoHgRR3RhPw7I?=
 =?us-ascii?Q?bJokyAjkt920NREUS/31fiTi+BIL04v9CrAJQlOnme9c4LoIjOliky3X/Uuo?=
 =?us-ascii?Q?Vxjg3KapqgLWzizbUKns9tyA2mMiUZ8dLSB/a3koP+KpppxDiOepQO/sIAJr?=
 =?us-ascii?Q?2+tu+QPW/jymAUWklvWTZVeI7LbToWjOGtQHB2Rgy5iuH3GZvh1MByaJGHU9?=
 =?us-ascii?Q?/9OHN5U+8DwGyz0PJM7xgD3HIBuSYvks2QObg8Vss8f21YqZhPsuRw5soZqX?=
 =?us-ascii?Q?cRC7KXQyNuAgnc+b0KIv0GxrKgl78KH6AasJsSKtoZQvXwtPOGFvVym7VFjA?=
 =?us-ascii?Q?b5wswJEyCXNN9ivDZct5x0qwjrRM2IruWvvpfBGkKuRPty+QEV+thjnhe4DX?=
 =?us-ascii?Q?JoIhjQRft9Sz2AJ3uoCsJmqWsuakHHye+bx1HWFm/aci4T1fJgbN2j38M8GL?=
 =?us-ascii?Q?eMBuJX536xVwK2LU3XZO4Nm1giodsEyMyqRKUpsyt07I72QdMuSEjHVVWJKr?=
 =?us-ascii?Q?EUEsPetZstd4XG0edrnoqrN4VFDYMYbZ9TlYg49wxRFDZDoz5S3cwBefk2/w?=
 =?us-ascii?Q?hzBpxU2I9laDdsvo7viPjClLcPU6+zJg0zHxQDT1tp127SqCY5jrAmrmzmEn?=
 =?us-ascii?Q?hwbfGHSGBOkdhgoqIKH+OgaJd5jFikqmm7YIHDn7Gn49MRRoYzSMYP6Tkb+c?=
 =?us-ascii?Q?k3BI9GVTm2iO42AfceyZxqtJ6Oij00dYMH197V62ZNbdPfbcIhbxTDBdsR4V?=
 =?us-ascii?Q?BqFrGyJDF6lrLFFxDSGD9QzLMUME?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:54.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3366c018-dad5-491b-2185-08dcec9274dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328

From: Moshe Shemesh <moshe@nvidia.com>

On sync reset flow, firmware may request a PF, which already
acknowledged the unload event, to move to drop mode. Drop mode means
that this PF will reduce polling frequency, as this PF is not going to
have another active part in the reset, but only reload back after the
reset.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 4f55e55ecb55..566710d34a7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -35,6 +35,7 @@ struct mlx5_fw_reset {
 enum {
 	MLX5_FW_RST_STATE_IDLE = 0,
 	MLX5_FW_RST_STATE_TOGGLE_REQ = 4,
+	MLX5_FW_RST_STATE_DROP_MODE = 5,
 };
 
 enum {
@@ -616,6 +617,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	struct mlx5_fw_reset *fw_reset;
 	struct mlx5_core_dev *dev;
 	unsigned long timeout;
+	int poll_freq = 20;
 	bool reset_action;
 	u8 rst_state;
 	int err;
@@ -651,7 +653,12 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 			reset_action = true;
 			break;
 		}
-		msleep(20);
+		if (rst_state == MLX5_FW_RST_STATE_DROP_MODE) {
+			mlx5_core_info(dev, "Sync Reset Drop mode ack\n");
+			mlx5_set_fw_rst_ack(dev);
+			poll_freq = 1000;
+		}
+		msleep(poll_freq);
 	} while (!time_after(jiffies, timeout));
 
 	if (!reset_action) {
-- 
2.44.0


