Return-Path: <netdev+bounces-157798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132BA0BC4F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12865164119
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB94146D53;
	Mon, 13 Jan 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1qzeQYe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8491FBBE8
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782952; cv=fail; b=YQv/cbPVFYqRjrEbY1oBm5xBYW+Vc93gzah39IpaBMPaB2kvJ16DftwaUu3uGrNhgVQJJsOmkvcT9ZWCsPRs9zuKPY1Na1rSYNFBdnivbYSUtWytr6yvBok8ol/BYFQqyAD8fJ+Qsz2agtkkcTSp6P9Dh6RMy4rpTlhFagsd7w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782952; c=relaxed/simple;
	bh=7ItGA2M8s+utlplg5F9q9onjCrYRPXcuwikNQ1gfI5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh2Ueb/pmNidrsqimxecO7Plj63NaoYqais06tD7vh2kUNYLzD18PQ6VHFDQ/c1QqBvU5TYrlrrPuVVPbfttEojY7bpNWVz15Tdpq97/2971SYIgYO3RrWOLoEz8s8aUgPms16zRTHMz48YDzOMjhRzbUju24NTpdX+Fyl9kzK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1qzeQYe; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW+mEy0rlu9RrrBxxdD62Ykzk4LvSj0sA36f/5rRqo4hxue1ZWyli3HJRV8JNQNlW1RN71r1ADzocEYuf/4oPZBivO/TQfADYcoLelR44XQOEMkD6D3qAeb0GL7jB9MKcZdiLY1569OQoad98Td6T04diV9pZr/JmJ6favh4PLzP/HxlACZJEJLnEg+Zy1t6GaQS7ks4HOq2YG/3sMC3cBg/Pt+U1lRR1zkkScAaMu+N+QbdJps4EuDALx2QVl0q7WtZo3C6BCM3JBqpW2kf08DKbjttOxbn5jXP1frckJtdLyF9n5hqDbYUV0SWyiDIlFg42rp2CI+xA8Y8M8IM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqS0N9nJPW67t3PmgpCJZFIFRySb5BDdBf7/83RHn+Y=;
 b=jLZoaK5YkrnKqvL+/P/YfjuljtG9O3leXEb+lj6GROAtaE41n+qcD/HkiE16leAJEutLhOO04xf66OHeIHt2TKYu5OWdKUpzzOnVLJ4p8p/G5fuOadhedPfzzSnt1+LJyRQpPeNAw8SJFafm9mmoL/1itqvWFVq9cs48xTrpT7pNr4dPfifqxMruf1V8WadE2Lb1Dx+IlBmq/LT4n9HnoUYvpLWinNJ3jsQUFrO451foGKD/3LzIbVLgSuwJpcLcjVIiXa6pXi8ZAHMNuSuO+GN8/2KdlV59n/thU+DjjmkS7NTh0XwatQ2lP786zP83QjsKjahjhOAFyTZ0EorIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqS0N9nJPW67t3PmgpCJZFIFRySb5BDdBf7/83RHn+Y=;
 b=k1qzeQYeT9k9VxefomKqS6zJ+Sl4kTT0d71Bxm+ECnEFqU8O2m6cir9YCW7lnkUxL6vOIqOxsdJF58O+zfewb5C+4jeso68KpJTEXQqWQQA8dtMZ0s9VHmRi8X8qqrvfytjkxU36oeNGY0WbLhpPGwc2xtcbARrZlkzUk1SNEjN41XPzy2As4XhcZO5eamKLZ61BnT5W4exkYejQhYSj+PMwj2Z26vGfe/HstbMUJziBEvZVm9G0A+XDkniLkLuPrfD2JycUtOUh3+r9jZa1A81/EBdi0CEltWtK6uMxTLxDy4eIlpkYniA4JKtZoYzGLvFCpNNTnTOpwZPkky773Q==
Received: from PH8PR22CA0006.namprd22.prod.outlook.com (2603:10b6:510:2d1::10)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:42:27 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::50) by PH8PR22CA0006.outlook.office365.com
 (2603:10b6:510:2d1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:42:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:42:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:42:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:42:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 8/8] net/mlx5e: Always start IPsec sequence number from 1
Date: Mon, 13 Jan 2025 17:40:54 +0200
Message-ID: <20250113154055.1927008-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250113154055.1927008-1-tariqt@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: b92c632b-f0f7-442b-9d70-08dd33e8e1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3Wb8xQOgRVQE5eLbQLkI1EFN0ZwVnpWvivEk0fW9LBOArMnYzbZZDtUnhS0?=
 =?us-ascii?Q?pNmZn/e2bcO+EPWpHp33y/vbapAbzVR0uyYVSRkxsUNKe6UlZER9gMX/NPsi?=
 =?us-ascii?Q?rI6VFPOl82e41YspWE9BaRg91sMxraKyr9OgTHTO0HZlk26JB2kfpkZI35NP?=
 =?us-ascii?Q?tDCE7iB4PSaHaGsOZ+GRnD5ei5YPj9yG84dj9MRc8C9OLcsnzpp0/GDfahxz?=
 =?us-ascii?Q?YZ2dZMjtecubromHGlC0dThgkxGASWxmEmMl7Q1WBDhROuERr8QJgrJGF7Aa?=
 =?us-ascii?Q?8IggQwlV7GHDzC38jbYWGWhjvTje19iWbOMsSHmi1rvwP4l5L177x/M8kY+X?=
 =?us-ascii?Q?ssOYR/H2rmTI8+NELW/vqjTilLIp4Q1zxB6eK1P70MidzKAvvfQlkk6sBTE5?=
 =?us-ascii?Q?91fVd6fGrSphqkPyZv0Gdf0v0wVv+ypRC/VZwjxyOQOtzTJBEYAfqgO6LOUU?=
 =?us-ascii?Q?1qb9YiLlzPF5SStwgSnPrIBgabQOy4WaQoAEj/3+tD4qB2kxhTY2yo6SrdTI?=
 =?us-ascii?Q?hynOwGXIAoI/edIRyjDNHWmVtCWWDBm4rSxypvPgeqZS48K+WH0bLEDPKFR5?=
 =?us-ascii?Q?lISTLF6Z7YCdPYFf0NSz44B46r3M3YSudHsRXV3zTR0cnw8WQsa5mZumhp2g?=
 =?us-ascii?Q?GM044/bPPl7PS87i7zqm11YjRN8z8r97Lp3wViuo2tH2oSJmQepD2X0+3rmw?=
 =?us-ascii?Q?psKSc+eXbEmSPfylrAmqUuxweF52pAugZsXj8Ug3xJM9msbSpq8o8euu4hFy?=
 =?us-ascii?Q?sRa78D6++LCcBlwIecx1wJn1RhMS59zPyXsn6lbsCZZ9XHz3W87RlkA6KtpH?=
 =?us-ascii?Q?FgO8GZ4Ng2zUWQf/XwTssZdCC3Pnlp4Qez/OTYqZMNH+ybn+nda7+6LP1vfT?=
 =?us-ascii?Q?lp/Rs4Lr+cUKjt7SxRfcdhvB4DuwkKLKw9co5ScTC1l9hnM6Y7zdC9HHHl2h?=
 =?us-ascii?Q?Ifplc2Y2QrcLpp1pkws17Cx3h8XTugESzX3fr5kcAQBFomRgN0LzkAvxtKo1?=
 =?us-ascii?Q?b2GwsIFJG1zOEa6d0n0V6eNDgi0WcEMw0sn4KZtq6rOyRctDO2ybm/NDePhj?=
 =?us-ascii?Q?1YYIWEuwEphIS4Ct4w4skLxfFXus7fizNf7Uvq2XVMU2QNvNgQSL92N3Kank?=
 =?us-ascii?Q?EuB32RsdjwO86VDc2JvbS/5Px9ACJgvgVQMNbGEOjKQjCH1b8A1jiCSNvVaG?=
 =?us-ascii?Q?6xxO+UMQTmqm0ycN8twEDUEHDVgJeuavf0lOxBDiSg/qLl+0FxXWApHcqd16?=
 =?us-ascii?Q?etFgDZAzFjRun8hsBFPBGihC2U5LPpL8fIoVl6Kv7DzoHnO7zvYUgrDAiV+/?=
 =?us-ascii?Q?JpWrtk6WdDrswaAu6s4ZrnyzkvpZmmVMxoJfbtJqrvZUSpbRpfoZ2Hfco1qY?=
 =?us-ascii?Q?eJg4TO2DAHNTv1s7CnWkF8PWijAEa80gN6yjTTyOjKBxmAcpLC+q9M8QDzyf?=
 =?us-ascii?Q?FULWk2CUPrsxVMZEEgxo+KUpv1ZX7gScFW6TOgme8zheSZeQp4TVH+iWLZNs?=
 =?us-ascii?Q?fbK6Lk20m0212O4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:42:26.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92c632b-f0f7-442b-9d70-08dd33e8e1ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115

From: Leon Romanovsky <leonro@nvidia.com>

According to RFC4303, section "3.3.3. Sequence Number Generation",
the first packet sent using a given SA will contain a sequence
number of 1.

This is applicable to both ESN and non-ESN mode, which was not covered
in commit mentioned in Fixes line.

Fixes: 3d42c8cc67a8 ("net/mlx5e: Ensure that IPsec sequence packet number starts from 1")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c  |  6 ++++++
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c       | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 21857474ad83..1baf8933a07c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -724,6 +724,12 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 	/* check esn */
 	if (x->props.flags & XFRM_STATE_ESN)
 		mlx5e_ipsec_update_esn_state(sa_entry);
+	else
+		/* According to RFC4303, section "3.3.3. Sequence Number Generation",
+		 * the first packet sent using a given SA will contain a sequence
+		 * number of 1.
+		 */
+		sa_entry->esn_state.esn = 1;
 
 	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &sa_entry->attrs);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 53cfa39188cb..820debf3fbbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -91,8 +91,9 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 EXPORT_SYMBOL_GPL(mlx5_ipsec_device_caps);
 
 static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
-				     struct mlx5_accel_esp_xfrm_attrs *attrs)
+				     struct mlx5e_ipsec_sa_entry *sa_entry)
 {
+	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
 	void *aso_ctx;
 
 	aso_ctx = MLX5_ADDR_OF(ipsec_obj, obj, ipsec_aso);
@@ -120,8 +121,12 @@ static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
 	 * active.
 	 */
 	MLX5_SET(ipsec_obj, obj, aso_return_reg, MLX5_IPSEC_ASO_REG_C_4_5);
-	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
+	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT) {
 		MLX5_SET(ipsec_aso, aso_ctx, mode, MLX5_IPSEC_ASO_INC_SN);
+		if (!attrs->replay_esn.trigger)
+			MLX5_SET(ipsec_aso, aso_ctx, mode_parameter,
+				 sa_entry->esn_state.esn);
+	}
 
 	if (attrs->lft.hard_packet_limit != XFRM_INF) {
 		MLX5_SET(ipsec_aso, aso_ctx, remove_flow_pkt_cnt,
@@ -175,7 +180,7 @@ static int mlx5_create_ipsec_obj(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	res = &mdev->mlx5e_res.hw_objs;
 	if (attrs->type == XFRM_DEV_OFFLOAD_PACKET)
-		mlx5e_ipsec_packet_setup(obj, res->pdn, attrs);
+		mlx5e_ipsec_packet_setup(obj, res->pdn, sa_entry);
 
 	err = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
 	if (!err)
-- 
2.45.0


