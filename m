Return-Path: <netdev+bounces-95775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158D8C368E
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 14:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF3E1F2200E
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA520DD2;
	Sun, 12 May 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T5JZYf+N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE731CAAF
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517862; cv=fail; b=glcuEhxRRKML1Ec744IBZnqRE2FNsIgYu5K/joqKAhotRzjY4IjOcZV4ZRi5Bvky8nn0sU/oGRExPufom2kUTWsL9VV+xnQhdiwU9yzy7+9ecooCgOFsn6wNsdMYDk3/iB0tgtoA4bVasU5L1GecT8PEh+a7baAw4jFQhd8RqP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517862; c=relaxed/simple;
	bh=bubSuITFbCe0xUZ3gM0wMHoqNI9ohrFubSuKdhv91KM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7GlneUunpc/GbR0RRxJTl23XIjh/bPW29vTekon+liKGZMWsfKIEf5HamJUcwuNry4WFbk63DDdhW8Z6R+DOYYzTE2vPxxIvZxFGe7B0XTYyG8Vwck48uFc24GrTAdslUThg+Jzq8TG/W6o96mVbWAY8jkvui59wqkjWUJ6Vbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T5JZYf+N; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6G+wUTnasFb/KYH/a258FLHMOB239Zi9OBfzGFK82wKEzC9Mcemqf0bCrgr8KnjXy8RXrkZ3mjATEIThmPJxM7VuCMqRecQ+OSgXOG7iMrgiYteRHVE32K3XOaZ5CtL3Id/AN/Azw+5bi3i+DO4etX1Pp4812C7JJsWA6DmyHZyG31HCdDBCEDzuw/e9d9AAgdQ6Gh/RCN0brT29cvL0Fcy9s44NqvqK2nppQztsXVRCVoPGmvPMe43SMSbJTQjl9jK9Z2R/S+Aw0x6TI3wr2XdID5X9pZeLGY7dI/K80laOyZhJKxzS4/Y9uj711rCBZ61S4x+ImOjKKJ1NS+hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G10yxL8n5wPWFlV7RWEODrSO9AbYrP9j5NrZXdps8sY=;
 b=dfMV3PWL4KP4O1vz/W/ThM56ASGUxx8e37teYAZorNjiMK1hW43WLA2Y86GjKvZGcriUL/MQjKECfzlKUSi6pDn8hXelmdWz/jOasrk6kB0ada4MwfKyXsUXyH/aQ3JZict1wOg83moMIQ+i1W+ZNBITSEQDY5O5lNtRa9NCQAZam+bclJSrPZVxMzACdfYoNZ7SJTR2Eii/PZXHG8CQLp+zKBGiAFL80IgmlcIQbAOgWM6k6J/Zq5KSDcIEGH+odGtxbnibr1goVGMUi8Hs+Ip4zNxo/rTIq0PaX01DzrVg33eHqgFFfRs7GI/S19X/L4ljQHpsGP5zw1IOV/1/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G10yxL8n5wPWFlV7RWEODrSO9AbYrP9j5NrZXdps8sY=;
 b=T5JZYf+N/kUzOki6Xd9t63692YjEhwatJVRPzCK+Zt2Aj+KnxT5fwjILFbZFhGwupoWtxq64dafW1huWzv4bKMJ90SvAwfL53fJFwawOu9K2dokHGzcHnJLgMLeAu72arAZXoXOlPPJfszfhiItgKUBQWUtExOttqUAUxHgcQqxGPD1QQN9mwAi67nRRU9RJ9wPGzz4OcWGfX+q1uY40kjYJEsBBsPL32ztW20fMwc46NpUgZy6LdXZYX/4kk+xZW79a0SIgB2rSfO3h0Fqo11X4w0gzkK+5FckN6Qp46sdRZ3sI06GApA8sNW7V/3b5Y2FO5SFYeq9K/ww6aTcQjA==
Received: from SN4PR0501CA0068.namprd05.prod.outlook.com
 (2603:10b6:803:41::45) by DM4PR12MB7646.namprd12.prod.outlook.com
 (2603:10b6:8:106::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:44:16 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::67) by SN4PR0501CA0068.outlook.office365.com
 (2603:10b6:803:41::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.20 via Frontend
 Transport; Sun, 12 May 2024 12:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 12:44:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 12 May
 2024 05:43:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5e: Modifying channels number and updating TX queues
Date: Sun, 12 May 2024 15:43:04 +0300
Message-ID: <20240512124306.740898-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240512124306.740898-1-tariqt@nvidia.com>
References: <20240512124306.740898-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e449c1-ee69-4196-b579-08dc72813bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TuA7zalNQnluLombki07TwSRkHSMTi8jwwuNEruuXZLjYnqDlC8MO3rFNEs0?=
 =?us-ascii?Q?Zd4tl+Vw1YVB+nskaTm0wkzVg8BJddi72xrohspSOSZXRrPt8vPVyKYTbuno?=
 =?us-ascii?Q?SEG+05BjvxeJZJkh998PTff1hn5trJz7Qf5/3DXJrg3J6/pU4kT8SrWeD8IZ?=
 =?us-ascii?Q?jykf9HqYEhqlr2K15LxvUuX/0x/Jslhj3JrKo9z3fpS1W2wUHJEMVP7aE+xL?=
 =?us-ascii?Q?DS05Ut7c/kVzbm85FSO8g4dc+GlRwK/CX2YOt9YZCiScX1RstVkD32rsgL+S?=
 =?us-ascii?Q?R/mNchU6A0aOtoipsHd8KDnjS6akfp6z4+DsrcRRFoq8ALkKBONPre116v41?=
 =?us-ascii?Q?N8GhJAJkAE1hhqCBC4O0Xy7fFhivpvwvxhkkLQwZeB2vLT6JTlIg1/FOxqzj?=
 =?us-ascii?Q?pxFPDgMQJlZ5DB7X7hq8wcVynUUrLyaGQs0ZYx50u0wVU/ioWljyeqwT3a77?=
 =?us-ascii?Q?JAzpVoQ4iAQDjaHfNO3hq7LNmWLy7LEZw0v4sxLsTSXFkzu0hp8Gwgt4hBfT?=
 =?us-ascii?Q?l8ACe0W+lFGnil+x69IvANDndMpmSNgjjVmKxjpNXvIljXMpgj6q2QNrbkWE?=
 =?us-ascii?Q?TOYWykh3eVB6po+h5m4iGL5jaulcRmAKJeK9setmRrePbvY9zJIzDCOn0qKW?=
 =?us-ascii?Q?ByTBue5VBIataZA9vXzKFNK8uzb0lvh2GT37sIvrKRIdaozdl3HzejQWb6sy?=
 =?us-ascii?Q?miaiTJyEf54Wp7ZdpMav4Ail/3r7RexvYZWByZvC3HKuyLq3Gsa3BzPOAQtx?=
 =?us-ascii?Q?KbGpt6vufBKFcaD4tlO8EcZGpB1fVtQ0s2YiZU10u/HIPyxzBIWzENAGKVyo?=
 =?us-ascii?Q?WY3g+HwQ2u9JxYw4oP+urwmUXEPImnqegHONovtwqR7nYCW5wd3GurZLNKwn?=
 =?us-ascii?Q?LiB96HuXCqNDq8PGwBwzK/rXhX0Xiu/7lNEDDrtaw6ERZsVYtxmevl69q/89?=
 =?us-ascii?Q?c8o90uXPyNohnHeE2SIBg9A2tTLqe3BzOqO5kdH06ApX31I0a7XqB5DsoJ+b?=
 =?us-ascii?Q?hIBw3i4bU3eSeL8ssj/3vr+ORUyiO7OYgeOvLSSNNKIbxQQEjnki0mPP2Yec?=
 =?us-ascii?Q?oWZPltTm9LYMRi+kjsc54SLsdlhsZS1NyiPuba1Sd0vQ+OZ1krGpwzujKrAW?=
 =?us-ascii?Q?srQCwFv3sxfflZhOAKhU2hVQgSZRb8DBAcKyC4XqdXSpGRN9kqTblzrwHBe7?=
 =?us-ascii?Q?eLywsH04Xr1/assNDfqmeRYIj9MZFytkiAVbAnKD7KgtxgHuowZRVLFDpMpw?=
 =?us-ascii?Q?REf9cazJHCQBzmjFRgrODpNnzWhepR8Z4435Ht25aM+zDPXUmsNCU1yOAptB?=
 =?us-ascii?Q?DIymCrhDm2XOKZoKDq3+q1D61gdyUnpragPPSnVmFbQRiPLKp6CPVsVNvEUg?=
 =?us-ascii?Q?LeQBsS39HqeIvBknAkb0UVt9G6Wb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:44:15.8177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e449c1-ee69-4196-b579-08dc72813bcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

From: Carolina Jubran <cjubran@nvidia.com>

It is not appropriate for the mlx5e_num_channels_changed
function to be called solely for updating the TX queues,
even if the channels number has not been changed.

Move the code responsible for updating the TC and TX queues
from mlx5e_num_channels_changed and produce a new function
called mlx5e_update_tc_and_tx_queues. This new function should
only be called when the channels number remains unchanged.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 95 +++++++++----------
 3 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index f8bd9dbf59cd..e85fb71bf0b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1102,6 +1102,7 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 			     void *context, bool reset);
 int mlx5e_update_tx_netdev_queues(struct mlx5e_priv *priv);
 int mlx5e_num_channels_changed_ctx(struct mlx5e_priv *priv, void *context);
+int mlx5e_update_tc_and_tx_queues_ctx(struct mlx5e_priv *priv, void *context);
 void mlx5e_activate_priv_channels(struct mlx5e_priv *priv);
 void mlx5e_deactivate_priv_channels(struct mlx5e_priv *priv);
 int mlx5e_ptp_rx_manage_fs_ctx(struct mlx5e_priv *priv, void *ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 1eb3a712930b..3320f12ba2db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2292,7 +2292,7 @@ static int set_pflag_tx_port_ts(struct net_device *netdev, bool enable)
 	 */
 
 	err = mlx5e_safe_switch_params(priv, &new_params,
-				       mlx5e_num_channels_changed_ctx, NULL, true);
+				       mlx5e_update_tc_and_tx_queues_ctx, NULL, true);
 	if (!err)
 		priv->tx_ptp_opened = true;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ffe8919494d5..0a3d1999ede5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3002,7 +3002,28 @@ int mlx5e_update_tx_netdev_queues(struct mlx5e_priv *priv)
 	return err;
 }
 
-static int mlx5e_update_netdev_queues(struct mlx5e_priv *priv)
+static void mlx5e_set_default_xps_cpumasks(struct mlx5e_priv *priv,
+					   struct mlx5e_params *params)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	int num_comp_vectors, ix, irq;
+
+	num_comp_vectors = mlx5_comp_vectors_max(mdev);
+
+	for (ix = 0; ix < params->num_channels; ix++) {
+		cpumask_clear(priv->scratchpad.cpumask);
+
+		for (irq = ix; irq < num_comp_vectors; irq += params->num_channels) {
+			int cpu = mlx5_comp_vector_get_cpu(mdev, irq);
+
+			cpumask_set_cpu(cpu, priv->scratchpad.cpumask);
+		}
+
+		netif_set_xps_queue(priv->netdev, priv->scratchpad.cpumask, ix);
+	}
+}
+
+static int mlx5e_update_tc_and_tx_queues(struct mlx5e_priv *priv)
 {
 	struct netdev_tc_txq old_tc_to_txq[TC_MAX_QUEUE], *tc_to_txq;
 	struct net_device *netdev = priv->netdev;
@@ -3026,22 +3047,10 @@ static int mlx5e_update_netdev_queues(struct mlx5e_priv *priv)
 	err = mlx5e_update_tx_netdev_queues(priv);
 	if (err)
 		goto err_tcs;
-	err = netif_set_real_num_rx_queues(netdev, nch);
-	if (err) {
-		netdev_warn(netdev, "netif_set_real_num_rx_queues failed, %d\n", err);
-		goto err_txqs;
-	}
+	mlx5e_set_default_xps_cpumasks(priv, &priv->channels.params);
 
 	return 0;
 
-err_txqs:
-	/* netif_set_real_num_rx_queues could fail only when nch increased. Only
-	 * one of nch and ntc is changed in this function. That means, the call
-	 * to netif_set_real_num_tx_queues below should not fail, because it
-	 * decreases the number of TX queues.
-	 */
-	WARN_ON_ONCE(netif_set_real_num_tx_queues(netdev, old_num_txqs));
-
 err_tcs:
 	WARN_ON_ONCE(mlx5e_netdev_set_tcs(netdev, old_num_txqs / old_ntc, old_ntc,
 					  old_tc_to_txq));
@@ -3049,42 +3058,32 @@ static int mlx5e_update_netdev_queues(struct mlx5e_priv *priv)
 	return err;
 }
 
-static MLX5E_DEFINE_PREACTIVATE_WRAPPER_CTX(mlx5e_update_netdev_queues);
-
-static void mlx5e_set_default_xps_cpumasks(struct mlx5e_priv *priv,
-					   struct mlx5e_params *params)
-{
-	int ix;
-
-	for (ix = 0; ix < params->num_channels; ix++) {
-		int num_comp_vectors, irq, vec_ix;
-		struct mlx5_core_dev *mdev;
-
-		mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, ix);
-		num_comp_vectors = mlx5_comp_vectors_max(mdev);
-		cpumask_clear(priv->scratchpad.cpumask);
-		vec_ix = mlx5_sd_ch_ix_get_vec_ix(mdev, ix);
-
-		for (irq = vec_ix; irq < num_comp_vectors; irq += params->num_channels) {
-			int cpu = mlx5_comp_vector_get_cpu(mdev, irq);
-
-			cpumask_set_cpu(cpu, priv->scratchpad.cpumask);
-		}
-
-		netif_set_xps_queue(priv->netdev, priv->scratchpad.cpumask, ix);
-	}
-}
+MLX5E_DEFINE_PREACTIVATE_WRAPPER_CTX(mlx5e_update_tc_and_tx_queues);
 
 static int mlx5e_num_channels_changed(struct mlx5e_priv *priv)
 {
 	u16 count = priv->channels.params.num_channels;
+	struct net_device *netdev = priv->netdev;
+	int old_num_rxqs;
 	int err;
 
-	err = mlx5e_update_netdev_queues(priv);
-	if (err)
+	old_num_rxqs = netdev->real_num_rx_queues;
+	err = netif_set_real_num_rx_queues(netdev, count);
+	if (err) {
+		netdev_warn(netdev, "%s: netif_set_real_num_rx_queues failed, %d\n",
+			    __func__, err);
 		return err;
-
-	mlx5e_set_default_xps_cpumasks(priv, &priv->channels.params);
+	}
+	err = mlx5e_update_tc_and_tx_queues(priv);
+	if (err) {
+		/* mlx5e_update_tc_and_tx_queues can fail if channels or TCs number increases.
+		 * Since channel number changed, it increased. That means, the call to
+		 * netif_set_real_num_rx_queues below should not fail, because it
+		 * decreases the number of RX queues.
+		 */
+		WARN_ON_ONCE(netif_set_real_num_rx_queues(netdev, old_num_rxqs));
+		return err;
+	}
 
 	/* This function may be called on attach, before priv->rx_res is created. */
 	if (priv->rx_res) {
@@ -3617,7 +3616,7 @@ static int mlx5e_setup_tc_mqprio_dcb(struct mlx5e_priv *priv,
 	mlx5e_params_mqprio_dcb_set(&new_params, tc ? tc : 1);
 
 	err = mlx5e_safe_switch_params(priv, &new_params,
-				       mlx5e_num_channels_changed_ctx, NULL, true);
+				       mlx5e_update_tc_and_tx_queues_ctx, NULL, true);
 
 	if (!err && priv->mqprio_rl) {
 		mlx5e_mqprio_rl_cleanup(priv->mqprio_rl);
@@ -3718,10 +3717,8 @@ static struct mlx5e_mqprio_rl *mlx5e_mqprio_rl_create(struct mlx5_core_dev *mdev
 static int mlx5e_setup_tc_mqprio_channel(struct mlx5e_priv *priv,
 					 struct tc_mqprio_qopt_offload *mqprio)
 {
-	mlx5e_fp_preactivate preactivate;
 	struct mlx5e_params new_params;
 	struct mlx5e_mqprio_rl *rl;
-	bool nch_changed;
 	int err;
 
 	err = mlx5e_mqprio_channel_validate(priv, mqprio);
@@ -3735,10 +3732,8 @@ static int mlx5e_setup_tc_mqprio_channel(struct mlx5e_priv *priv,
 	new_params = priv->channels.params;
 	mlx5e_params_mqprio_channel_set(&new_params, mqprio, rl);
 
-	nch_changed = mlx5e_get_dcb_num_tc(&priv->channels.params) > 1;
-	preactivate = nch_changed ? mlx5e_num_channels_changed_ctx :
-		mlx5e_update_netdev_queues_ctx;
-	err = mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, true);
+	err = mlx5e_safe_switch_params(priv, &new_params,
+				       mlx5e_update_tc_and_tx_queues_ctx, NULL, true);
 	if (err) {
 		if (rl) {
 			mlx5e_mqprio_rl_cleanup(rl);
-- 
2.44.0


