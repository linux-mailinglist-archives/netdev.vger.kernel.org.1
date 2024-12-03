Return-Path: <netdev+bounces-148683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1909E2E5E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEFBFB3557A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14920897E;
	Tue,  3 Dec 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9T3TOyw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F554207A01
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259038; cv=fail; b=sWX256JWHdadYGkpK0ujoQstxerGJ1Z3ko3RYSj64NConDrtA2vC40ZVLGRhZSSQtH4ARqT/+zHyOf8fFAgqPX5mr86f8qcZ9FzcNkXsKqYVNtvMU0Qp5Qo/G+HbcrdUAoXeR76CGwbjB/6dHJnRL4Nlt26YukUvYjJjBXchCLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259038; c=relaxed/simple;
	bh=kSOHsY89zawPDFu6s6ta2comrsvaR92zcm4QTfJP7Nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8pE161rLj2wdZr9JZ/Me3beZtlPmhigAb9rFNAUU8qQhKn9HpL2qLkfkX37G4yH9SZEGieZIvl/pifLI+Us6epwx/lnW8A7roO4DiH8ZI/7iJBjWEvSZlOqneJn4j7HnjF88I6XTCz5oKFq+2kdYZIjT79iIgfH818/2Hb0mNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T9T3TOyw; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF2suhakJx7eGGWl2CEa9rZ9Xl3qmHL+LZmMp+pW7XcwkhCA7mQBnzEChBCPzmKCa28FM5vzXjy4wvqOVSGkEzCL3HtL0cj85fz5fNaawrickk41MzYYo7mpWRuv8DjXfZghvYCPUWPxYYy5+rcxxqaOk32zVEutARjt2RX00qGMbxPLJ2nvB3UrQsJJlHcmSeE0JSZt+DamnO05WhVA6x+CxH1b1X6lvRBfq5H6TmyPqbNfy9gGNODcr2/1jT02P2uP7JeOX8a5L6PwqQHLUT5clq2dh6OpoYNm9krKFR+R85LRxufdyLHsfGGn3FMqtYYlQLAAJYBcaULrTg6OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbSQKWIFpXDg+/eZFkVDeUNl1MM5Xb61rHfErMkk8zU=;
 b=XF8I9nzcQE+lU2AkR+Y4oxm8Fy6WGLduheQTCI8IB7MZE9PFcnM1pzFxZ9TA0/cORPKZpgSYLurOpumGvFe5o3hlPML+sOE/OrJeP8OZP22ttQG6MN9s7xysQ4SRzJQeIXQ2ZndwF6GnpWd5ZWedNCvuLdvyNeefdjoVdQTEY4ki+gw8Z0Ska0n/lM7hZpreyoQtDEOHRH7N4xZ2sCEkC3/Sdi4SMvcEjp+LKNMdQRtKorcWI1ZygtkIoRo//rp8YTXmTFq7c57JZrCdJUiegRx1HwnZXTpapAO60ZLE+/INA/if1nK4PEifH5x+tQe6CjIhrWtsW65QJGfAMH+wxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbSQKWIFpXDg+/eZFkVDeUNl1MM5Xb61rHfErMkk8zU=;
 b=T9T3TOyw+GwE/Q36Nw6zF7HMaMoPBD3aZYqprvs6/2kvgjfKACK+KN1pIyt3uv1udIfefZXTk6cimXCxcA8Lbi96T9iQJgtgZ7rJwhv1zLqCwIhXTcwaVDfJHoQqndmdt24U87gxJEzmi82N2OK/NjbtOLuMuDdFq9LyRfxq+dDpjZzD76d24rmswyKO8xPuXdmggGRJoiwwkOtLkxu3eO2qtuDQMWAUDjEjOqsVgTkzx5RxKM77SrjDhOzh16Lba637z2P/JVM/Ew9kgRSyccti9nMOBD1oSgoHomueCXbMs8VJ0RDUcrbj1YG9hFVdjBtObAzi/440jwmEsh8tfg==
Received: from BN9PR03CA0749.namprd03.prod.outlook.com (2603:10b6:408:110::34)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:50:27 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::c5) by BN9PR03CA0749.outlook.office365.com
 (2603:10b6:408:110::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 20:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:50:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 12:50:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 4/6] net/mlx5: E-Switch, Fix switching to switchdev mode in MPV
Date: Tue, 3 Dec 2024 22:49:18 +0200
Message-ID: <20241203204920.232744-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203204920.232744-1-tariqt@nvidia.com>
References: <20241203204920.232744-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: efb6a51d-071d-4ab5-a674-08dd13dc1d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4aakeQljvespho5biM0r+LtsgbgfPNLcVau0hh9ldQS6pnptwEs0vcI9VMHN?=
 =?us-ascii?Q?bzKeSD0mIABwYlnbURYOVIhoOWT/ADUCVebWJZEpsQfYz75yLyAGVM8WCKkW?=
 =?us-ascii?Q?vT5gUpecJaVVRqg23QKQqPKYPEvt1yNwGJNVsEwLK1T0ghIbGW1S3amDARho?=
 =?us-ascii?Q?/n8Wz7FNLeoBivAQuEpVHqGc9+7vHkrJlwWid8lE7aMFUNg8uxfpIEcmK43z?=
 =?us-ascii?Q?z1YofgaywZNx7ALDDPYuu0LvA6V/maNLcuoF2daAH9Arsj7aAzxk5MrBL2Us?=
 =?us-ascii?Q?jPLhboB8+VGFX1YpyT3C7kQhPe/7TQq+nApnovZ5Pp6Jvs2CBpnMqs9BrTwT?=
 =?us-ascii?Q?YTooDU1XwSklB++Hcvpoq2tMkLQ39j4BVm2Qo30RvSD2qK26jVe8rrqQ778F?=
 =?us-ascii?Q?6M1TRy1SjCVmmoxBqLfSmbSEDVeAefBxSkQ1HGHhOOIGPE4d1Sa8uEzoAiRA?=
 =?us-ascii?Q?z6VGMlI/QTgzwzrrs9ypY0XM0nLMfNJXEtmiC4XqfoJt89RwHs8ikrGhGa/r?=
 =?us-ascii?Q?fDzeEi40Ukew1n9sHjoCMvNq6pSq1Jt48jtXLk9Zq/iNEE1Hy86Lhki0aIca?=
 =?us-ascii?Q?PKNMCm97LyRC7/D+ehXLTabuYAxD2FLaPSQZSiAj5/wNXa6C5W9MynycpAwh?=
 =?us-ascii?Q?pSlQY5Qe91IQd1gtaj7hhuttPWaH07sY+j4HEzsvbaTI0HXV+v6U1RHEEiyz?=
 =?us-ascii?Q?UKinaf64EGCL/8HdfR7IoE0fepAtyB0gKbOl0jNs0cQSAkUwJdVR2514ug1S?=
 =?us-ascii?Q?0JXE+1mSD27kX0E2cVYeuijp3jNgm41adTS++lVFB8mglg+FkNtHQ26m4pbK?=
 =?us-ascii?Q?Nq3o2kykbcOc/iHqKhKJW5MAL4Utph12CesNg1WIo+K4V0BLppBYQg4NQfKI?=
 =?us-ascii?Q?9A6IH5duO+/eFODPj8fDqPHmT/WkhonbNDSgLFUdqjqctpGxuttLO9j4I+9H?=
 =?us-ascii?Q?W4OPT6N+PWvCK2TNhuyyUExYWt7SzYYisHQvmR/uqFIAAVd7tGsLkm3Xv3e0?=
 =?us-ascii?Q?o2kWhqoiFprZAKezEaQ3C8j1oorxCkZj7jJBFR0LTYcSBtSWS0CiAPikRB/J?=
 =?us-ascii?Q?cH659J6d0gM9KQ3iNLNDKMlDqG7BeiBf6+JPPc5AXuKTU3NtWzuwmUXZJpMB?=
 =?us-ascii?Q?KPT0TgoBwtceNbEyhagacDPUJDaV8t65D0RL6xuA8qwXDbHL0hEGVTosdHlB?=
 =?us-ascii?Q?SmqwWc/1pQRYD5TuotwQdCELnfug0BkJQdA8/G4K4ccPEaGv+WoKeAVI6SxG?=
 =?us-ascii?Q?/rmGU84p5y+hP64L/powPpT3kUd+7WUnXfo7v6S4oVhRPev84w0Xr8bEdNS+?=
 =?us-ascii?Q?HuH9QAaw2chMH3rFw3qWyM4b2EQkLOqUrHrg4ErK4yd+U6QfvjnR2M5YriHo?=
 =?us-ascii?Q?w9IU8MDzyzaaYQEfTrmJSj/qfJc3SMnWVQPY55Rfm8T9Wgbog9C8bvrBO6Tl?=
 =?us-ascii?Q?GKfChBFsDa3Rtqc+JrA0J3OqLaeMDPgu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:50:26.3977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb6a51d-071d-4ab5-a674-08dd13dc1d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530

From: Patrisious Haddad <phaddad@nvidia.com>

Fix the mentioned commit change for MPV mode, since in MPV mode the IB
device is shared between different core devices, so under this change
when moving both devices simultaneously to switchdev mode the IB device
removal and re-addition can race with itself causing unexpected behavior.

In such case do rescan_drivers() only once in order to add the ethernet
representor auxiliary device, and skip adding and removing IB devices.

Fixes: ab85ebf43723 ("net/mlx5: E-switch, refactor eswitch mode change")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 5213d5b2cad5..d5b42b3a19fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2335,8 +2335,8 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
 static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
 {
 	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
-
-	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV) {
+	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV ||
+	    mlx5_core_mp_enabled(esw->dev)) {
 		esw->mode = mode;
 		mlx5_rescan_drivers_locked(esw->dev);
 		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
-- 
2.44.0


