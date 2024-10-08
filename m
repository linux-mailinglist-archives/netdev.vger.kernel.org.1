Return-Path: <netdev+bounces-133262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891F9956A1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE67B24281
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE612139C6;
	Tue,  8 Oct 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mit5eKU2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06D2139DA
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412406; cv=fail; b=d8TtYm5z+fkU42bw5Q/7LTD12a5Gr3VyqkSnaUQ7+WSBOJKz+Ge1iq7kzk5x4Q3/2i1o5LklRm0FSJDl55uIeoQOzALYxzx8UinLkYizhAu9cWKMDadkQG7qnW6vilJOHruoFDkmdyh9XWn63LqhdB/vZylu69EHIPig3q8QWl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412406; c=relaxed/simple;
	bh=+IrNDjBTo9Q3uSyn/O1PqcoL05R6tufDlKDyMG1N9jM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfZva/Ub1aLHQ8k+9Fh+9luepFFht6KMymnuxkVJAb6E1Iv0TnYlbPso60sZ8hJzdWyonLjJFWugAHqJtZOlKaAKA4jyMqiObInuSDwrgEIZJ53s6sJarnNdLzwljQDuh7YwGzyBM4U4bQTTM14EMml3bHeyKO0qOiHmm2Jq2Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mit5eKU2; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU27AMe1s8y9aS8cVtvaKGf9tUw/JKMisV7h6BqMlvYkW4k1vMFm4BKc14YOBSjep9ZN/sCr6HxuS6XG8sZncRwKKNNh55OAwrkKaQgTVKLYExFRwlhR9sWwfzV4rckwacYEWqyxvV59Y15MaMNKfSILoQGWo5snOpu7ENWcXaArwk1rMusG/qcqe1T2X4bmDiINKca5tSgfIeSYvWefTHh54+BSMs08qgZ89N/w6byXyNcI42Yx2eTexpiXRkIoVnMURp/UK5PbiJfr86oGGwNvNIoFs/wOB3BBY0n4+AVhQ3jVHNQRrf6hDcFS+OJd1qiFsVVE5+XTaCcT7O7cxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZKoFqgM7Q1OL1Omik4Iv9q7Zr9Vaw/qPAwmeAfqCx0=;
 b=nft3xkWcF4sYHthKkJTCn5l/dgNqW+lpB3O7rh/qiTxXKeaLuVJBVIS0wsdpYegv2f1S2VBCnAmKvTBH7a2j39jb+YKt4WagbEdWzBAhS9ramGga7l3SIiBsHbz3FGCjgAuZg8naxvWxog9QPRDhgCRxzGIfD4eujJ/MVJngyvX9aSoaw9KydFBMmQfWvzBt/YjFgoMXR4DeOCeq4FNp8bwctvQy1RZC06cQHpl1dhTPitKUoA82+C9fbM0V9hjCaDt5Wng5g9Mwi55mNuIrneG807L+tUJ4nkpXtIaKKXEMAIcE1Lv6Msa/MA89BNn6O79eb4OWR1UlhINwKsABVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZKoFqgM7Q1OL1Omik4Iv9q7Zr9Vaw/qPAwmeAfqCx0=;
 b=Mit5eKU2cnHOxfuNOknVPXpm56DBIny4MNOABLa4aigDoQArC1ZSeAAikiEPwN8ZtL/Kv+wBLVoGJUM3QfmE0ZXGt9+yw745LxFxE3fUNq0fcxD9MddclGlxdLq8L80PVLEeptlZbhN0Xb6ztZq6vCDT9969TFVyCvkPpYAAxuCYonYFzCahbqQrehtIBoiG/OcqfxEvsoW8p/zXX99/nAKwfxrb/0wNBQ3EVwVpJ5RCywya32AHtrv6SabBhdt0BhQaj9HQam1DtErBz013G54su3mPNC25W+FdJHjgBjtvisCeB8snWp3cKgNWeAfuz8Lc8FT0k77d9wpmRcrJzA==
Received: from DS2PEPF00004567.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::509) by CY5PR12MB6525.namprd12.prod.outlook.com
 (2603:10b6:930:32::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 18:33:20 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:92f::1001:0:12) by DS2PEPF00004567.outlook.office365.com
 (2603:10b6:f:fc00::509) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.3 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 03/14] net/mlx5: qos: Consistently name vport vars as 'vport'
Date: Tue, 8 Oct 2024 21:32:11 +0300
Message-ID: <20241008183222.137702-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
References: <20241008183222.137702-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b91ad6-2cd7-47be-0a8e-08dce7c7ae8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I5nl3m/C2+hGhTk642jJKCSopWBIz1vBZvQEp/l05P/EWA2/zI4KodG+Q2ip?=
 =?us-ascii?Q?r8357NrFKcbpkbzypDvsHZGegbnntyH9sZ9QXb5mKNIBY/IHt1S3KW3depfB?=
 =?us-ascii?Q?D54TUmBVmwtpFtYMVWv4h++ZHRes2j4pe3E/l8mr9mpxcHjma6JSGaThhY7y?=
 =?us-ascii?Q?77VG6bJjmZC/bJ7loyL3aizB5ifqe5t0TjHwWdX+1jmOUqIK9HFqPc1ZrxU4?=
 =?us-ascii?Q?ARGIffiz29uj9Q1MoM3LX4DgTKNKIAVBH1jiF+VQgyFW9Pvlrz75d79JPl+a?=
 =?us-ascii?Q?FxISzXvS7t/c/MmJ+vLxd8oFAgktzS1+SXVi7pU0BVpJtDk5ushCj1YNhX9P?=
 =?us-ascii?Q?QNRWNKn1SmhFMmyQpqMGEc0PLuW2NISmCZdtc2lLsqGI/UOKKZRq/E5GHC2r?=
 =?us-ascii?Q?Hs9r1BthFmhBQHNId6zYC4RA6nLFIG7xCC6qF5mU63xokVwPbgefKjtcF0Lb?=
 =?us-ascii?Q?gcKRs8rUZZBTBDbi8P12R2maC41+jJ2HMsYzDYSahTM9UZnyz9zJ6x51JjFC?=
 =?us-ascii?Q?q25Dhaej1zH88HgzBTW3OL/DxY5NPWtL84Jo2/UL2yNz5ySZWFC4oJ2Z36Cl?=
 =?us-ascii?Q?Lthcq/24mMvQlZZ0ny/Sao1nWu0Tlsk9flrfLW0W+WdwMDGkeVdSUIjpc0VO?=
 =?us-ascii?Q?1aEJyw623BDOFYLX2zzAFWcLgZJDEcp6nJ1aSkjEO1X884POKLIOPtfVHWFr?=
 =?us-ascii?Q?bPO6Dvc5x3ocCDXdm240SxzergcCxb4iPwAwIzipkkZsn83ybpNpL8Zx+gTu?=
 =?us-ascii?Q?gFYSh5S2nZrwjAK7pRBkbsLKY4zMfn4+OmVdfEyzYNhL8O+fONRccsKjkv56?=
 =?us-ascii?Q?sy4BMHW7Px0/t9XNM3hLy484ihNHZpVJ0KNfcDN39Aar6jXvBL0TCxcpsdnY?=
 =?us-ascii?Q?ZsUZiE+4tciXSJ3J1EZohA7M03cnwbUWr6bCdWLPf9nfk3FoY9o9zEPkKhz5?=
 =?us-ascii?Q?BxDuNRyo1Z8BPeV9plporNUx0Bl05rd7/K8oQVToq6kKYuXQqwimDhCVh0rF?=
 =?us-ascii?Q?Ju8LcYqd2MqhOW1n3kHUhQaOK0SJqTiZ7k0iySMIXFHjDiuEQZrWi2PKzprO?=
 =?us-ascii?Q?BEk3DjFvqiAQfkTPqSUFEHyo40rzOHy+tDlCnjy3LYO3mAleIDq13DnBkG6v?=
 =?us-ascii?Q?ivL97gI+aMHaikbVnqNToO+eYg40uDledX8z9PfZNlCWZ7FnWPRpvxVJUexg?=
 =?us-ascii?Q?65dEanZTN/kznzWAPPlAfwFfkJB0+LwoUzYvbDHlQrx08ntLKruq/J8phtLJ?=
 =?us-ascii?Q?/aDWVlQYAM9fODAVz+HkpTbsjKVHcy3iHG6DBJklHsaJiMPP165RVUrcSUoH?=
 =?us-ascii?Q?mycob2/wui8fmvFyCjUYxLJfZGMN26zQCIoJ9MMhsaepC53T7eCUAbjZrayJ?=
 =?us-ascii?Q?BJujo6M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:19.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b91ad6-2cd7-47be-0a8e-08dce7c7ae8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525

From: Cosmin Ratiu <cratiu@nvidia.com>

The current mixture of 'vport' and 'evport' can be improved.
There is no functional change.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 73127f1dbf6e..8be4980fcc61 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -88,7 +88,7 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 					      bool group_level)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	struct mlx5_vport *evport;
+	struct mlx5_vport *vport;
 	u32 max_guarantee = 0;
 	unsigned long i;
 
@@ -101,11 +101,11 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 			max_guarantee = group->min_rate;
 		}
 	} else {
-		mlx5_esw_for_each_vport(esw, i, evport) {
-			if (!evport->enabled || !evport->qos.enabled ||
-			    evport->qos.group != group || evport->qos.min_rate < max_guarantee)
+		mlx5_esw_for_each_vport(esw, i, vport) {
+			if (!vport->enabled || !vport->qos.enabled ||
+			    vport->qos.group != group || vport->qos.min_rate < max_guarantee)
 				continue;
-			max_guarantee = evport->qos.min_rate;
+			max_guarantee = vport->qos.min_rate;
 		}
 	}
 
@@ -134,24 +134,24 @@ static int esw_qos_normalize_vports_min_rate(struct mlx5_eswitch *esw,
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	u32 divider = esw_qos_calculate_min_rate_divider(esw, group, false);
-	struct mlx5_vport *evport;
+	struct mlx5_vport *vport;
 	unsigned long i;
 	u32 bw_share;
 	int err;
 
-	mlx5_esw_for_each_vport(esw, i, evport) {
-		if (!evport->enabled || !evport->qos.enabled || evport->qos.group != group)
+	mlx5_esw_for_each_vport(esw, i, vport) {
+		if (!vport->enabled || !vport->qos.enabled || vport->qos.group != group)
 			continue;
-		bw_share = esw_qos_calc_bw_share(evport->qos.min_rate, divider, fw_max_bw_share);
+		bw_share = esw_qos_calc_bw_share(vport->qos.min_rate, divider, fw_max_bw_share);
 
-		if (bw_share == evport->qos.bw_share)
+		if (bw_share == vport->qos.bw_share)
 			continue;
 
-		err = esw_qos_vport_config(esw, evport, evport->qos.max_rate, bw_share, extack);
+		err = esw_qos_vport_config(esw, vport, vport->qos.max_rate, bw_share, extack);
 		if (err)
 			return err;
 
-		evport->qos.bw_share = bw_share;
+		vport->qos.bw_share = bw_share;
 	}
 
 	return 0;
@@ -189,7 +189,7 @@ static int esw_qos_normalize_groups_min_rate(struct mlx5_eswitch *esw, u32 divid
 	return 0;
 }
 
-static int esw_qos_set_vport_min_rate(struct mlx5_eswitch *esw, struct mlx5_vport *evport,
+static int esw_qos_set_vport_min_rate(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 				      u32 min_rate, struct netlink_ext_ack *extack)
 {
 	u32 fw_max_bw_share, previous_min_rate;
@@ -202,19 +202,19 @@ static int esw_qos_set_vport_min_rate(struct mlx5_eswitch *esw, struct mlx5_vpor
 				fw_max_bw_share >= MLX5_MIN_BW_SHARE;
 	if (min_rate && !min_rate_supported)
 		return -EOPNOTSUPP;
-	if (min_rate == evport->qos.min_rate)
+	if (min_rate == vport->qos.min_rate)
 		return 0;
 
-	previous_min_rate = evport->qos.min_rate;
-	evport->qos.min_rate = min_rate;
-	err = esw_qos_normalize_vports_min_rate(esw, evport->qos.group, extack);
+	previous_min_rate = vport->qos.min_rate;
+	vport->qos.min_rate = min_rate;
+	err = esw_qos_normalize_vports_min_rate(esw, vport->qos.group, extack);
 	if (err)
-		evport->qos.min_rate = previous_min_rate;
+		vport->qos.min_rate = previous_min_rate;
 
 	return err;
 }
 
-static int esw_qos_set_vport_max_rate(struct mlx5_eswitch *esw, struct mlx5_vport *evport,
+static int esw_qos_set_vport_max_rate(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 				      u32 max_rate, struct netlink_ext_ack *extack)
 {
 	u32 act_max_rate = max_rate;
@@ -226,19 +226,19 @@ static int esw_qos_set_vport_max_rate(struct mlx5_eswitch *esw, struct mlx5_vpor
 
 	if (max_rate && !max_rate_supported)
 		return -EOPNOTSUPP;
-	if (max_rate == evport->qos.max_rate)
+	if (max_rate == vport->qos.max_rate)
 		return 0;
 
 	/* If parent group has rate limit need to set to group
 	 * value when new max rate is 0.
 	 */
-	if (evport->qos.group && !max_rate)
-		act_max_rate = evport->qos.group->max_rate;
+	if (vport->qos.group && !max_rate)
+		act_max_rate = vport->qos.group->max_rate;
 
-	err = esw_qos_vport_config(esw, evport, act_max_rate, evport->qos.bw_share, extack);
+	err = esw_qos_vport_config(esw, vport, act_max_rate, vport->qos.bw_share, extack);
 
 	if (!err)
-		evport->qos.max_rate = max_rate;
+		vport->qos.max_rate = max_rate;
 
 	return err;
 }
-- 
2.44.0


