Return-Path: <netdev+bounces-162267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF70A265BF
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1693A4DAB
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E781FDE29;
	Mon,  3 Feb 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DD6Ck/4P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E41F4275
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618607; cv=fail; b=U5/Km7sB+SmgXR0uQzEVtLUHCXDsFOBByGiNdr3iwAJxW9jpkxtyKuqyoohpS4sU1fIU9iQxn9JbXb1liSoegcqSe+6Ss9ubnxu9knmuc4PffLzx/slR3odLUYmARGgh1E2er49C8y/HkgXS5LpBfrIKeEZOeT88KacATPaItE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618607; c=relaxed/simple;
	bh=U/c+u3HaScZlS76XQn4mK+KjHgriPS/qlIcFqdFpU5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9yyzZOpFgDCG2FXELm7WY/oZvA2mgmAQjSDCjjYZ60+7BR2fm9yLRNum3PHrptJImUpkzMdXmzsQaZbIooYwhOLK8Sit3wkgfVVP8OBeNbiN6jfMltHPqOoJvfC4UW+qX0PpxDZ3y0eBtngTIrsMIOdDERBdcZCoL5LoizMaoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DD6Ck/4P; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/MEzkOZx1tUbS4fID6equOJ4i2e0OxwMC5AMEWaeO7cBYDMlisHTUyYT4F5oJRb4JBCOO+VQ8udkgi8A32wq8SAwJe6Z8IZ5wvU1HVZLot+RTUDYMa/5ql78EyyPqtBfuP4xJDQNSf7eKRMrimQoxfuZnC2uzTtW/TyvezYSC6U95/hRpIa0ZKpi2nW8d+ViRqjEsgoc9rHvUhrF/nYBx2Yf5t6b9a7tZoDqg2lxuDRIFImwmtz6QiC/QUnwrrZYQyQ0kUvSRE8gwDt/yKeFgwNJ8Mh4+072ShVaZ2ZYgWZYhFUoySItTLxE/fIGk73AGy/MNdDJ75NuVk1osW1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87e3U99kE1PW2ayiv+74C8vRrFOygj02uZGO8bKIEP8=;
 b=pha6vZmGg4ekrw8z+6SwYt+O3r3r5uorXaA7taqv7jzjg2g5UKQr9PwRUzuL56Jis+R4ZhYtvKOo2Lp2qBDORoQv1fKLFX50oDYEgcy/WaVGaMa3fEHZdflqnXbfK8GowEAEl4Cs9griQTqtiO2lDJsFwZF03wTxaQ+TWd36hHJ1kkPmWBlgNqhILueCZ8qzPobHTNP5KWwxB+OMYUi8akzxi6OBY32OtCbzMK8hHWjR9V+9C4ZOfbjmQCiM82joh2a2JDqLGvnGSILSyrIA/h4nLdY3ABM4Ka5XTYDezWSdzPlmTzfv5iNv+eM2xDzGAXwQARqFJoV0+Ifrxd8CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87e3U99kE1PW2ayiv+74C8vRrFOygj02uZGO8bKIEP8=;
 b=DD6Ck/4PbGkt+EbdlgMQ2LL62/7z/b/mr8Xw8J9NGMOH0Mi32Rz003RHTNVGYVRf8fKFattry591DGmKgSyjwycZor0uo0Zmt8LflRGrKSPc/HdjZ7H3qgooStYf156eyVGBrzOEMTPlYdyzpEOw6+ZE8eUu5x6+sN4rY4X1FawwCGvlQZ/3PbSGx26ybqdG7pFAw4Ir55R8C6sVnYGuZbHJWCTj34eS79LvKBesH/bs0sPFTrcyDaZpsFSWLknhzkCid/orU8k4X7lPHINUkyTP9tQ8QJ0TM7NuaN+3bXbik8nzK4KNA9hlN1lwJDmIFF23dsqoYTfECbC6AXwSTg==
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:36:40 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::d5) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Mon,
 3 Feb 2025 21:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:20 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 03/15] net/mlx5: Add init and destruction functions for a single HW clock
Date: Mon, 3 Feb 2025 23:35:04 +0200
Message-ID: <20250203213516.227902-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: a55a95c1-ef80-4f07-9d59-08dd449ad860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UvB0/Em16Mn4boAsF1qn+gPwUYxchuAWZPMTrvoHCQB3aRHQ8HVyG8fuPnl4?=
 =?us-ascii?Q?Pb67FtWvDD4ffV7gA3HaHp0G2nk+x9q0Cy1kdHJyKJlyD5bpX3WLNscoyND5?=
 =?us-ascii?Q?J0ewmgrykpctMmn1S4KceqOZ9G4+/Sj+fyWCVxO9unYUjSgICAsJxXls+dn2?=
 =?us-ascii?Q?Ju+QS/sNv4XlVSknpA2YmDkZipn1VuJvTFjO1WzhevrfNJ9EP7dcK2/SBN2F?=
 =?us-ascii?Q?4LzEoQDNg7D6hPDSEevS8VtBXo0M5hO+Tsulb5lfxWArnyY+mSq/89lXcdm5?=
 =?us-ascii?Q?+v1HRb5kgOpe6eWfDW63lTY6CoSPMuwJ4Cxby5sgznMcVuPNLRVXkuO6rJh0?=
 =?us-ascii?Q?ISCPfY4+cWSsQndzrQQ0Kwg5wr2S+zLSho3K32tI2isD+/UAe+/foz9V3Ghh?=
 =?us-ascii?Q?iJLuGnx9ULiD5u6HwA1vOytYWyur+rfJhRq7Uns3UyAafjh+F9Y1cf06Yg/I?=
 =?us-ascii?Q?2R6X3vbARM39fZ1QcSTj4gw/2upoBhEC1Qtt0jdfba5W9M2F/cLF6d/bYlD3?=
 =?us-ascii?Q?43LLDEeTlJ27zkkJBAEOeh7w7lBQAbYbJY20QGqJYdrhIlZID/To2OhYzD5Y?=
 =?us-ascii?Q?7ywCyQNZdwOn/H//toFxC8Q5u4vmorazGAv+6i7ld0XJORWCNoTmhtdGHvsb?=
 =?us-ascii?Q?z+AfkFTXajtf2yLwVRSuZ0fxP62krM+GSsEXFQafXYzBMaDRR0ZKiKI1EB4p?=
 =?us-ascii?Q?giM9Fq63xlIpupTXUa2Pdi9/k+TfaAQkPCUfCJL4zKpXbHOhE/ah652vXF9D?=
 =?us-ascii?Q?wakTMgFG1/npogr8epUwaznoXSxZ3yOfqR4pdoW454XA+v+61iPri3sb8E+e?=
 =?us-ascii?Q?ALA8trBLS8elZACMzswq5crK/iCBTeiq6dzsmO1Kq0sTrAjS3AALbF/6xhQK?=
 =?us-ascii?Q?Ml/djFMZtgPicf5fUEqAtYt8fvgpeRJa1gJtGsBIsk91gMI0p4TFKRvgsqPq?=
 =?us-ascii?Q?l5BPMmEz8k3UH9Qpn8lkGhyv6l80z3ocTihEHsVDXb4amA9j5Ufk3dv0eVAb?=
 =?us-ascii?Q?KvpcjDtxRWqb0DyOacbAJLc4Opl2ZZMZRmYPNabAqmp9WOiolPiyuauzQ3Dj?=
 =?us-ascii?Q?4aWMvAhWrLYn3Lvtx4faM8rhDgJQYmQg5PaR4J2Lx+e7Gn/NvbNSeu+d2lMO?=
 =?us-ascii?Q?nkkY9mHeCLP6/VwqaFw/ZU1stRgUONJDB0XPr4MfHYVa79RJ11KoYDO2jlhK?=
 =?us-ascii?Q?KzlGQyQAh1WIPicoWw84DaVBBV7mb1nLD3iP8sPBBuTl1zktc+PUOGrGuSeF?=
 =?us-ascii?Q?7TPA1bvB7QYarrSt7MiawXLIRye6kLqzcIggbDcve4QWBWPHK05plasG7pFD?=
 =?us-ascii?Q?EKWVths5pgdhj9OgDHQbmqXZyGejcTas2O7aBxBjuvigj8CFaEkrVmAVEf80?=
 =?us-ascii?Q?jkXaazbcBjoffhfhboXPgufsn4OJiXcGK0wT83pWxkGrMjrrojnqnETR7LiX?=
 =?us-ascii?Q?E3fNtE8BAepp9aq9LXhpz3E2bahEQ6rE48w/w39/+qvayGYuQk7U2BcnbTES?=
 =?us-ascii?Q?HVPZZqbd4V75xvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:40.2028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a55a95c1-ef80-4f07-9d59-08dd449ad860
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490

From: Jianbo Liu <jianbol@nvidia.com>

Move hardware clock initialization and destruction to the functions,
which will be used for dynamically allocated clock. Such clock is
shared by all the devices if the queried clock identities are same.

The out_work is for PPS out event, which can't be triggered when clock
is shared, so INIT_WORK is not moved to the initialization function.
Besides, we still need to register notifier for each device.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 48 ++++++++++++-------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index e7e4bdba02a3..cc0a491bf617 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1153,17 +1153,11 @@ static void mlx5_init_pps(struct mlx5_core_dev *mdev)
 	mlx5_init_pin_config(mdev);
 }
 
-void mlx5_init_clock(struct mlx5_core_dev *mdev)
+static void mlx5_init_clock_dev(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = &mdev->clock;
 
-	if (!MLX5_CAP_GEN(mdev, device_frequency_khz)) {
-		mlx5_core_warn(mdev, "invalid device_frequency_khz, aborting HW clock init\n");
-		return;
-	}
-
 	seqlock_init(&clock->lock);
-	INIT_WORK(&clock->pps_info.out_work, mlx5_pps_out);
 
 	/* Initialize the device clock */
 	mlx5_init_timer_clock(mdev);
@@ -1179,28 +1173,19 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 		clock->ptp = NULL;
 	}
 
-	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
-	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
-
 	if (clock->ptp)
 		ptp_schedule_worker(clock->ptp, 0);
 }
 
-void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
+static void mlx5_destroy_clock_dev(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = &mdev->clock;
 
-	if (!MLX5_CAP_GEN(mdev, device_frequency_khz))
-		return;
-
-	mlx5_eq_notifier_unregister(mdev, &clock->pps_nb);
 	if (clock->ptp) {
 		ptp_clock_unregister(clock->ptp);
 		clock->ptp = NULL;
 	}
 
-	cancel_work_sync(&clock->pps_info.out_work);
-
 	if (mdev->clock_info) {
 		free_page((unsigned long)mdev->clock_info);
 		mdev->clock_info = NULL;
@@ -1208,3 +1193,32 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 
 	kfree(clock->ptp_info.pin_config);
 }
+
+void mlx5_init_clock(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock *clock = &mdev->clock;
+
+	if (!MLX5_CAP_GEN(mdev, device_frequency_khz)) {
+		mlx5_core_warn(mdev, "invalid device_frequency_khz, aborting HW clock init\n");
+		return;
+	}
+
+	mlx5_init_clock_dev(mdev);
+
+	INIT_WORK(&clock->pps_info.out_work, mlx5_pps_out);
+	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
+	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
+}
+
+void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock *clock = &mdev->clock;
+
+	if (!MLX5_CAP_GEN(mdev, device_frequency_khz))
+		return;
+
+	mlx5_eq_notifier_unregister(mdev, &clock->pps_nb);
+	cancel_work_sync(&clock->pps_info.out_work);
+
+	mlx5_destroy_clock_dev(mdev);
+}
-- 
2.45.0


