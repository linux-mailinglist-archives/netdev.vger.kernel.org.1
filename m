Return-Path: <netdev+bounces-114172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62309413CA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12349B2475A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7711A0AE7;
	Tue, 30 Jul 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dtFz00x+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24A19FA7B
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347976; cv=fail; b=ZIMXlnHc2z4KsMwCN/3jUi48nOtcRiiSPrhFktesuqKktj9N1+D7BN4+rc2aq4ugSRocrCM0q2/sMZKWKpD1QxCM8s6fYSluvwyM64ia3DBxYvpK2+BUk8pq8FLchfjNf1rRX4uDGk4ndS9SC1EL6oO4Lgo7loWa0evs4O8WUDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347976; c=relaxed/simple;
	bh=8H2/ZGhvnKwLRYWML2bHX2Osfjz6MonZgi3J0oTxSRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/Jzc2/3R4PqbzfF1F1+vCTMyJ+UKV1brCo1omtTXchvvOWnIC2K3SS6qqNPt3kAWYktZTKv/8acjs1yRVgFNGCxH7hfbmddjQQ267H5sjySQ+i7+ZPlapu/qjFtUKggHCbpskpTi0+eipFNA2f7K8ihtk02h36RHsQnWAar2BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dtFz00x+; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBTizyqmkQr7W+9XHajxcxcErz4rYrMF/9ZpNvmDOmWXtsAb/Bfm2p9Q0uSF8qAHNLXXJzQAB7whCAK0YQ0KM8PlksRMAQ9Kb6+UAX6ACRnebT1xNkXU6akcmnqKSdZPWCBHZ0EOdgWkpAFTEjoJcPzkIUJpSwST2T0TuibRuSBiX8Lr+7D9Dhb+EMOracHjWi80GSuaVzeauCuJCuXWSLzqYGSO0j2bONeilhrfRcfFNW4ll754SjBDx0CBQmRhQf14yOyFLmQJyS87vXIvSmW0lUTcO/Wwdet1Ta9Jyzeu7ItjBy7bwuQ16gm4ch7+rh4/PYk2u03cBpyJklruQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sB7/h3zzk/aT5CvbeGb1srq/i+hL81OO9v/VY59oJc=;
 b=XsA3AeiUUgYnl8Ywmmww+ZmMwq7EhNLDtMcCHAPrrBfaGj0KQxCNfxPKTNNpamCmBnTZ4XeP4vCPd8pXWOj1HMu3o7bUI1xamtYTVnWNGTPZS6mDZ+D50i2IAQf9Ae3OWkWNxovbQdX06xL24Me0r9QALIou/xYDb962p14nkHdFMIeYeABc/SHQ8K0oDo6dakAWltffWiRQq4ylAjQRTFlF2IVQNWVjJL1mKMKenGzODLil6poUkea4uJHrO5rt5fzgjfPQ4LDyFQFnjRAnbH+sCnOgeVOd5KtsODY4QjQRzQZzG1z8o5tmdssnmre3NW3leyTdlQIGFxw17svgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sB7/h3zzk/aT5CvbeGb1srq/i+hL81OO9v/VY59oJc=;
 b=dtFz00x+P5PEYF9Gs+Vgw+Kb/HvaoZwSg+adg7KYuvs1rGGEZJO9vdHYIcueVkPc2J8oGcc/7o4weUHy0bPtDoN6gvx4cOTfCKrhyp/asySd34lF1AeJamxPgxXwHAq71Qj/WwR2JdBpzefdVcUDxcjSlKzocBvx9p3k+MCKv3KfK/QLcwvd/eUggWvcFe6bprG34l2THLQwuvwFIgF2W/8OE8L12Qu5HnzEbcpzRCE5wZyDW1rIFyHL9JP8pX5lY/qmkkEeYBJRqBRqHlivuD9fK9Kar8jo5l+DsLF2YqT9pZ8DQOpcdmUvnE9Sa/kS5xFkeqIyaCFyupO/m+4vOw==
Received: from PH8PR02CA0019.namprd02.prod.outlook.com (2603:10b6:510:2d0::27)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:59:31 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::a2) by PH8PR02CA0019.outlook.office365.com
 (2603:10b6:510:2d0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 13:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:59:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:16 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 01/10] mlxsw: core_thermal: Call thermal_zone_device_unregister() unconditionally
Date: Tue, 30 Jul 2024 15:58:12 +0200
Message-ID: <0bd251aa8ce03d3c951983aa6b4300d8205b88a7.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7ad653-3c16-4bea-709d-08dcb09fd54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6h98Rbitv6aeIMoq/DYa1h840mCPRjzxXw4hnLc+IA3sa7VQ+HkowsAhG1sW?=
 =?us-ascii?Q?jDixUWT2iT3ateYQjkVdi92exstQJIgiCKPN+NVe36tBSH0Nv9i+/x4V2Lp+?=
 =?us-ascii?Q?dsZkCJMGSocT5fIKiYWM8Cq9QWw9L6VfJbQwshmMCxAZ4Wwn4KfX/FkTLNew?=
 =?us-ascii?Q?GfaTLIDvEi4atrd5atshfIZFZj9SjRElUacFdJsOF22YnGi7f5mMMTIHqcyN?=
 =?us-ascii?Q?zFRJbfULS5wyQEUFAGA/aFCdWJzEA70RvHA/NcDZOrEZHwepdMvQZ7NhzB20?=
 =?us-ascii?Q?AsoYVG28rNMu9CaW/K3kkmqimlJA2/idTXfQB5DaJE758iUKmHnAMIEB9uUw?=
 =?us-ascii?Q?uGgxHyikcLvfdest9s51ToeFdp46Ur605zlDjPZ/pRjajv/cIgz6JaQNQufG?=
 =?us-ascii?Q?15BhQXlWLkClYa9wOo2+v8PBQF1qXkU9wpZKhqJGb7mxeICKWJxWevXcIlbS?=
 =?us-ascii?Q?BqhijR0J9qu3K3KjvYIKR+cEv3yOyVg5acURxFOQK2VC797TD0Q5A8HpVO59?=
 =?us-ascii?Q?jh7+0wRGw64uqgH6PQwem2S3t3Hskxex1bgR/Syc2EVkBCI+9DQnVNh3X/iS?=
 =?us-ascii?Q?CMgBECAvmbytYOd7NgaWrZjgMRuB933ereYzUoikojjd1aNLZLWzNPBC1e1M?=
 =?us-ascii?Q?1b6iWd0IIXdLQFCnfbrd7tl1BG4ozcE4RNrz0aHUyoWj6ShOoq2d36cp4+uj?=
 =?us-ascii?Q?JvccELCpvre+/BO0Fo9Huz/Z+8sp+He7EHplnuunwS1iwmW8iasAZ2U7kaaI?=
 =?us-ascii?Q?YyK/rRC8IB0bw6WVCPQ4ozqcCB+Iywvp9Qav6jYUyFyJ3d4KG0oHjAMPzU3q?=
 =?us-ascii?Q?vH75Dhns7i52r2fsZmqImN+8rN7RfUXMFYSVH/cXPpBT8f+VXIttGWQqHzUd?=
 =?us-ascii?Q?BIFap2kpE7kXv6t4YMTqXr/3o7t2JvWU8pRcw87krSuEYQQIoDYSQEhDU0X2?=
 =?us-ascii?Q?8VMUImC6VMFhdZf0x92G4/TQ71KF9G+/i6sKCK/4GugPGg8v42YQHEmFxSCR?=
 =?us-ascii?Q?ogX7TEtgBVfDai8GBS7zQnkSI3vs8D1LpPTTzILezOpytHS7Lp9PchQWqTG0?=
 =?us-ascii?Q?kzzQ0pko7up6HkDjRWtg9eAhyjkqXIKpnl+0hiJspMAURMrNhkj6YsROkUa2?=
 =?us-ascii?Q?XAsThyJI/7c2Ft5DuldowZ6CZAmosNQxztpHKfhnfTBE0DhePLPuNH5TgCvR?=
 =?us-ascii?Q?UL4/suQ7jpugTrmFqDtjVOo2bB5mQiDNmddYlZ8wmi0EWh8ohrcRWaTL1wYg?=
 =?us-ascii?Q?ydQBytT4B5XTP44oC+H41eWThb1HEnEF4snQ4VAY1MB9MXJyR/+m2HxpsCN1?=
 =?us-ascii?Q?obKYOJpgoIvmFg7miO2PM9vaLBdvla7hXF99I2A49sE3nVptwXEJoeO1gyXf?=
 =?us-ascii?Q?TjS6xSyGVQpZ85UIelvCdPyy/dVLqKAgFdPxVmflsH9WhsKL8X6ltv3U1RqZ?=
 =?us-ascii?Q?kAyjg5vII2ssfhUPkCJ1G8y0hzI+W0DK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:59:30.3831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7ad653-3c16-4bea-709d-08dcb09fd54c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453

From: Ido Schimmel <idosch@nvidia.com>

The function returns immediately if the thermal zone pointer is NULL so
there is no need to check it before calling the function.

Remove the check.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index d61478c0c632..0b38bab4eaa8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -821,10 +821,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 err_thermal_gearboxes_init:
 	mlxsw_thermal_modules_fini(thermal, &thermal->line_cards[0]);
 err_thermal_modules_init:
-	if (thermal->tzdev) {
-		thermal_zone_device_unregister(thermal->tzdev);
-		thermal->tzdev = NULL;
-	}
+	thermal_zone_device_unregister(thermal->tzdev);
 err_thermal_zone_device_register:
 err_thermal_cooling_device_register:
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
@@ -845,10 +842,7 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *thermal)
 					     thermal);
 	mlxsw_thermal_gearboxes_fini(thermal, &thermal->line_cards[0]);
 	mlxsw_thermal_modules_fini(thermal, &thermal->line_cards[0]);
-	if (thermal->tzdev) {
-		thermal_zone_device_unregister(thermal->tzdev);
-		thermal->tzdev = NULL;
-	}
+	thermal_zone_device_unregister(thermal->tzdev);
 
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
 		thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
-- 
2.45.0


