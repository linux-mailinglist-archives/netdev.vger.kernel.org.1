Return-Path: <netdev+bounces-97626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8688CC72A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A71F217A4
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D1A146D7D;
	Wed, 22 May 2024 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxJfljjx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16B1474A8
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406098; cv=fail; b=XgK9f4BiyIPQ0yl9lYaMquEKPL8TtFP306Q7n2GDw5yDHyqT0a4FlhPBGLbKRX5VAvxGUqUCUrrM6bAE2iHLQ8D8oNCfuqpvvJZgoDiHKOYpDzLJbKWDvoOP5JPu77wwiKyj3NQtPWZPwW6oHKG5ggJ4KGJPx35wpwfQo7n6Gn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406098; c=relaxed/simple;
	bh=EZLNtW9A+HTvNFvB16/99wBAejsdbrDQUke4qa6Ri8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEv2G0iwU5ckly66cA9l4DT1nKk4ATj/oaAm7NOIpBFIEv4KhSQ5ZoXhtXLYlry53d0UYd1RiQa+ZmiuS48a2BIPlaPawj1jTqGWNFNLCzPaiLxFJEDd3/viavMwJTx1TDyNqGKhjDNWtnDI72nAC83XVZUo1B/UZk0vfncHVfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxJfljjx; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZexFZ1vVDZHcSMmtVPfGUC9ggE/bD/64zNAIhSLd26QuPbk/uKSSLzhR8/P6jz/p8qteeNsPMkJbPSqPBiEuFeGeQmULfQUI4HtnPrR45cI43Wvs//KJfcn5kayq/vooA3OXEODNJNhgIOs19K4rnbINvNgfW0fuC6pxZAT2JK5m6ttrGWQ5z13MK/cCR5rRutYr2QHeSOWzwzVqOg02vmqU9vgE8IR7IczZV8puYb9gm+4ZmgOOB2iDPcmNwUvYnUSmO48OurHVBqYq/gUCWgoBiyk+jdIy9i0J6Xz7yy/wfFxG2wb2e1hRNrC9GhGbwXRlXMdqOcVaQ3mBCW3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA6rovhlLrj84NlsTBEztKt9FiY1c4pw57+/cPP+yxc=;
 b=SptewBUTIJ7I2dyVL/KTjtlWFK2enzlaD5lEovufDCCOrMvrqVaFoJQFWLh3M75f1iAeZiOs7UKVZB2dMPmsaMqlM/C4AVH6OJhb/Pkuk2m0/hqnSPrijJmf5DG1uo9FN84sfsXXL22D8WguNyUEVIxfNNklCpr7VnYwHuT01R4C7JP8Z2Ew4ew5DOGd5asHIRl0qzFiEP6yUUfKLAd97EEUCKeWP9AUbs9z3e55pYkDTqzwBxeFwfYGLi9oCyHbMhHoE4SXlGeSy4JnmBEOPoZOppvbMf4Uv4crmZmN5ubudq9Q0L0nrDBa6wZMOkHCr9D/pfd5+yy5dFGlSJrLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA6rovhlLrj84NlsTBEztKt9FiY1c4pw57+/cPP+yxc=;
 b=kxJfljjxuI37Kbv9UKTtCCV/DtTfcYn1RXhrrnb7d+x3MQiMrZTfZXg9tF9z/XZjjEscBEG5CSM4KHvMuOktJ8SxSW1g/3u3NTePb5Mne/6TM7Qz6VlFrAH/JTzOUTIat3oUx5M/tKa7xlJEgcuXR7WdUqnZSvk8mC5ea+IjNr3AehxofdshkWMvUtAfOsZ30dat5wQ8Dcr/uJTHLIHGMoTFQOGHX7f+12KIxNwCHmbs30wBs+Xa8gbVtPAuqIB6Vdg8vp2Tj0hPkyN/OgjY4mw41R2JA7P4U3zZAo6kpEjtnxxicR3A8l+mvuTKteTFRLcomZ9K7tTcedqTyHXNAQ==
Received: from BN9PR03CA0791.namprd03.prod.outlook.com (2603:10b6:408:13f::16)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 19:28:14 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::79) by BN9PR03CA0791.outlook.office365.com
 (2603:10b6:408:13f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 19:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:27:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/8] net/mlx5: Do not query MPIR on embedded CPU function
Date: Wed, 22 May 2024 22:26:53 +0300
Message-ID: <20240522192659.840796-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
References: <20240522192659.840796-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 485633ea-56a7-4ea3-ecf0-08dc7a955327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23y9Zry1VKOn9pFyIXa2Qe0ygO66nTVsEFQe8Qeva/pfkR6AnN/kML9LeI56?=
 =?us-ascii?Q?1k+MHczok/VLYTjghccxtoW4fFCEQJ44P39WsdvFov8XhVop4TdM023TyQky?=
 =?us-ascii?Q?e3mwBYH//aN7DfnPz5ODrHqAuRbujcSHCc0cRR5ftX6qazny+7MCMsMFBY+P?=
 =?us-ascii?Q?ocqWDPdQQHu0rCNFduMeizQ/1tAASaCAPFq+PaqNS99fNQc2F+UIP9ByoiHu?=
 =?us-ascii?Q?4A/15egfFVNjqqls+B6k346Y8NcLphbDd0NeHcjnHgP92YUerdH6N5rAiy5W?=
 =?us-ascii?Q?ynLcV0w0zfKPPxnLmJATeb2BNdAHWSLukMVdlTKP4o4Ndb40ptJhBwEkONit?=
 =?us-ascii?Q?tKKDI2enrlWMEHaFEw2lqGwb4xRtJRCmmNYxkQnfYuWIyAaLo1WuU0a4tFIL?=
 =?us-ascii?Q?ssEDY9VOoOzY+juclP8TSTbdkMHko5kfk1HOoUJgaYZrWK2/hzOvQzgBeg4k?=
 =?us-ascii?Q?W+I8gY7iA9Ed+eMt1q7SzvoeD+EPoo9F2Ht//icBWm93830/5BfGFlrkX2rC?=
 =?us-ascii?Q?IUBoYEKrsmBdYcbZdM12VikrjB8bj79cN5KtIWnSHeJhkIaOF4OC6Xjh17W2?=
 =?us-ascii?Q?TneYhqw3BHZjS8wBcHgnIUnv0pHAXGVlxKg8pXD4EcsRXvMQ4+l/Q3dENz8y?=
 =?us-ascii?Q?BW6LCcmEu4h7oLTeq95EfYuHsPqRPF15bAj2nukD2iiMWl0a0FNc5pQXpTc+?=
 =?us-ascii?Q?TNqC/QTljrH7A4ICd086NgsYkoHbH3C7iARvf8LfHVg6BHItTssWpUvwcwGP?=
 =?us-ascii?Q?krodMeTYNxo1JIQi/yi2yu0p0R/6VnDoWhdmwChDT4oY3VojrQCkpf82sst8?=
 =?us-ascii?Q?U61qt7UcLteYl9FeWv2mwsCyiPoLoZcJbnHjcP2oqFz0kAK8pAM9fqou2LK+?=
 =?us-ascii?Q?itr3On3sE0b6WW6r33eYSHdwD0pVZrlr2nQ/vjjkDe6Z5XWhTYAIZXVy3IPD?=
 =?us-ascii?Q?Mjtdjn9f7E+Fb8+TFkZBTeRuyzVMhPk9nQLI/qZcekHrLHR52ryPDOCZkgw0?=
 =?us-ascii?Q?oDlCDS1Fa9MzuP1NJKAiND/vPFne/fsyV0Z43k4op9NMxyeex0VF1g4Iw1GE?=
 =?us-ascii?Q?8vG+C5gz0trPxgEmNrS+0j8+aw8Wob7N/hBp0TW/SDEhmYEyIHti/RWnShCS?=
 =?us-ascii?Q?RoWXI6URnjwKAB4dvHDg+tHN2GVR7lp9H1x+JUITj9sVnYMf5JPBAQ2tiQh7?=
 =?us-ascii?Q?hV7Jf7gv5+SliNB0zDEVmSr6ZojJ00fdLkgAuQF8ENjEBYv3BpDgJzPTSefn?=
 =?us-ascii?Q?gNoom0HsKC+4Q3Ox0keMRN8qesPEgX3ae5hy2jQUMRwBgXxqDBSdN1VdE0LP?=
 =?us-ascii?Q?3DVrA6WQzMM+9ZbqocltZ0lM41Xdq19MkCXkPKrKniJX2qYiJOQp1GibZylM?=
 =?us-ascii?Q?GwCWxCM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:14.1577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485633ea-56a7-4ea3-ecf0-08dc7a955327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439

A proper query to MPIR needs to set the correct value in the depth field.
On embedded CPU this value is not necessarily zero. As there is no real
use case for multi-PF netdev on the embedded CPU of the smart NIC, block
this option.

This fixes the following failure:
ACCESS_REG(0x805) op_mod(0x1) failed, status bad system state(0x4), syndrome (0x685f19), err(-5)

Fixes: 678eb448055a ("net/mlx5: SD, Implement basic query and instantiation")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index dd5d186dc614..f6deb5a3f820 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -100,10 +100,6 @@ static bool ft_create_alias_supported(struct mlx5_core_dev *dev)
 
 static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 {
-	/* Feature is currently implemented for PFs only */
-	if (!mlx5_core_is_pf(dev))
-		return false;
-
 	/* Honor the SW implementation limit */
 	if (host_buses > MLX5_SD_MAX_GROUP_SZ)
 		return false;
@@ -162,6 +158,14 @@ static int sd_init(struct mlx5_core_dev *dev)
 	bool sdm;
 	int err;
 
+	/* Feature is currently implemented for PFs only */
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	/* Block on embedded CPU PFs */
+	if (mlx5_core_is_ecpf(dev))
+		return 0;
+
 	if (!MLX5_CAP_MCAM_REG(dev, mpir))
 		return 0;
 
-- 
2.44.0


