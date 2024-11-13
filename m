Return-Path: <netdev+bounces-144517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B049C7A9D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7181F2344C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A42071E8;
	Wed, 13 Nov 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSecekzP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0A206E94
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520920; cv=fail; b=ds64QwWimGpX//mkq/KzTmYICnLKCi3o1u1MbOSJTOWtt8jAV40B/glK4hkMRrhvLqXdqTPasmfupmWFOJxIWcp4Ko9vnMJrLPfLCr78nkNlX4bXnCBwJHJ4Lhb7HRC/9N9kh64SXiiAjHZynjS1UstDPN4Z/4S0EhkH8HzhBrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520920; c=relaxed/simple;
	bh=w32ky00ZtCwguE4hrbvCtcUtRK6r4KWNWeVAvaTV1Gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwdSf6vwUqLhYwGgipuko6GI9k2san62+ZgJgV1geSPRPDNEeYtzbDKj9qRwNEWflRufNZb30LE3jdteaM87hLfWTNmTKmqrPC4imO6000rHopJgbOCNvtz0Ko8e46Iw0YixqC1TGpZlw+S6dxu90dF9+vtUgUj3ao6Cb94p2WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSecekzP; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shKSgyLGF4Nx+5upvfIhCB1qBlItgRRWJ8eHPEL0EvFt+qTEM9B9TqHPcCFfxqwCVlC4Ts5lEcakQMBNo536oYZGgXeEsUwY827zcr8XlYR/lejA84GZhPEL+lyb5gw/bhmtU2/mttvacawtUNc8BXTMu27eSqtd7TaUGRX7gdh+OJnL7gibMzQt4gMmr6KellrNR993ywHyRX6CNZ3u7aV9+3J+8qKth/6tVocll4kpRuswSGVO+/+R4qZ+f0swBmnRthXvl2oOXYjlSbXxdtPU2+u6wHfw7+3KNNW5JBVeIH9hDCoFbZdMO0nYr31O5pc5elJ2o/Ao8mUU6HdaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKFqlKcSMaf+Ad5L3EaasUkFZposlEq5y2QOY/SMIs0=;
 b=heYhdD3+pL/tN+9ERuqp+OcWpjEhpTmukAPidND1lulNEJlBKS0n+Cx6ogkWJBZXZOCA/JLqyiydje0qQJIxAE/i16yd9LX/3ON7//3NfI6J2726mknIO78rXQhfs1QYGQYHqTV+U3uuRXvjqWQTu7LlAgFIb3uK4ngATJM+DnezwSOhmDB2zz6tzY5A+u5xbf/yRVsfVtu71CtutcViNYymDfHxAajnRvNHBF1guCV6d/CQhekFOAgEtBYE6g7ZInBhJV9AJiS3rE0lDnR7Jace1hwFhH0dbyW3kFGimzOKh5mhjC1H4WhOamRZvSMq7FtayGXRFUQ6zUuACdL4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKFqlKcSMaf+Ad5L3EaasUkFZposlEq5y2QOY/SMIs0=;
 b=GSecekzP623RE8lWJ2xk1jHwgJWLyC19I66oVkGtVzL+bwd3aHDCuWXKTu3DTNBpbHw8SIC+B++pp+N00uWdhxAFh3ghkohyPTO1W9GiJ93OdTB3wOdbTFMpauV68XKtlAqJXFMI891X14IzOp2Yq1EG24hDbKSGtiJpmgjyMw80Z2XoXkw9Dpzv5ImPOTyZVz92/RtbqFsEV2mPEyOAb6oyM9m2BnlE7ArabzwdtI6pKfXx/LUaeE4BobyFdHYRMDVIEwgFvH+DSnPfbR7v06x2HfQ6Yfs17Kyym2+0X0jgz6Sl4YFbWVXgA0lMs7Smg7cXZrCLi5vzx+Dui61k9w==
Received: from MW3PR06CA0015.namprd06.prod.outlook.com (2603:10b6:303:2a::20)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Wed, 13 Nov
 2024 18:01:54 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::44) by MW3PR06CA0015.outlook.office365.com
 (2603:10b6:303:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 18:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 18:01:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 10:01:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 10:01:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 10:01:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 4/8] net/mlx5:Add no-op implementation for setting tc-bw on rate objects
Date: Wed, 13 Nov 2024 20:00:29 +0200
Message-ID: <20241113180034.714102-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241113180034.714102-1-tariqt@nvidia.com>
References: <20241113180034.714102-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5518c6a7-410f-4d65-5b61-08dd040d41c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjpMZnC7uVYKxhGRYlJK/8WitGAARiLu4QDTvIng/WxP8VEyXfahhE0lXRqB?=
 =?us-ascii?Q?M4I2fCXusajrWlcaKsggEqsG0Ie54dS/KQYQb8eRQ27jCoEPR1gFUSjZmRBH?=
 =?us-ascii?Q?JBrsHGwAI+sXHJ+ZQkFin/tPAfYPkb7IIc1URS6Wtpa9ogTvetvxobIWN8SB?=
 =?us-ascii?Q?5Ie54VVLd7AdnkPjq7lDaA7gb+T5CoqfD3v5TXvOBKfPlMzkrWKttymQrxxV?=
 =?us-ascii?Q?17e4B1ps+IyomDsErtN2h2SJxXS6KZLopgCvFqBvt1vwKo9Bga2H1StERMlv?=
 =?us-ascii?Q?CxD7eQ8kHFNkBCXcz3myjGfOXVSE+raxwI/j2RAWuImficLgkD7xhaGEt0Wu?=
 =?us-ascii?Q?P8e/q9Pq0MibgLkNePEZ9CgFqsUwlL5U++Z8nw+dUXXpRihUpa4CFTVEVH4E?=
 =?us-ascii?Q?85+1UENEXmYh/rMtfNmfHHFMqmOMTrZSjPTUf/SmUqiHAfLtHaB2WmWhEOcg?=
 =?us-ascii?Q?+2uYZDaQ0nHgBahXCw63ikNBt9EXS1Xo0fYhanqNDSARBq9MDUmv0BruVNoB?=
 =?us-ascii?Q?ZnmpaYCwOYf5czyTIpyfcv+rA0xXINELJEIqUlblEhJm7i75ZFj+QaizqWN1?=
 =?us-ascii?Q?kht9aPr6Gh4kOCWXVbUx+8eUCw4FL8/Qw7HNwMSzqUXvvLJ9jK+S1yc3+mWJ?=
 =?us-ascii?Q?xtfA7kcBKfxZywde/qBgjBSxgjA3KyiObFfrAiVtVqIblm70CL1NBIGDhJr0?=
 =?us-ascii?Q?425CDXWwODY+y7UMCq7F4gTbNmqdvPniKKU0Q7qJwGEDLjDnLFrMq711gFqO?=
 =?us-ascii?Q?+FEDwFYcwYtHHw5ddhKO9PT09yAMT90AbVn/NKsfIbuExUrusEbtUlJAjJJu?=
 =?us-ascii?Q?VWiC4Bl2H5nnTgfE1JJjUFV2U1jKksiRio2Q+fmQFRA0sQhfTAIDIIEMrpnv?=
 =?us-ascii?Q?y+eBzLWZkv2KUomXI1YtcOdTbtZcLn5TNvSTj+R5RZv/O1Ps4/cqYKSIEZmb?=
 =?us-ascii?Q?Inpd91Cao04NLEHbQKUGhPFYeh4gDFTnWovunjDegq/xp1qSyCviiDiJ8F0s?=
 =?us-ascii?Q?vWRgP0engBfuGl7iyWfFLfmni+Gr4NolIDJXV4MXiJog8UCzAdPGuOYY56SM?=
 =?us-ascii?Q?Rz6klXtOqP2XXTZIv2SfIqcfII5sbe+16z5R5xDANKltsaSYzn1DBt9+mq/A?=
 =?us-ascii?Q?2f+IOkJ9LMyN74tBcZF4oOiJDLUjuOmNedJtwK462a0FL3oQYemMyB1C1JWu?=
 =?us-ascii?Q?SkLiQjFpiV2ILwZamQ3niySYx90IGn5Ql7zj5wGC24tLvBSV+q6FRxClqVMC?=
 =?us-ascii?Q?XfaMrMsGM8hO9k9hbOSL/kzbymXkO3lQ20udIX+f4xzqkLIb3XSNCEWlojMp?=
 =?us-ascii?Q?AHbXQR8ZvkURf6OEcU4LEXnPs7l88y8pUg2fDZGbTHJhzNvjpOl068xcdCKR?=
 =?us-ascii?Q?CuEikhpELihBIO1XdPo+Em7vJknyNwseUbXXDvdR62WMVvGsww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:01:53.9898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5518c6a7-410f-4d65-5b61-08dd040d41c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..728d5c06d612 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -320,6 +320,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..db112a87b7ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -882,6 +882,20 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 6eb8f6a648c8..0239f10f95e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,10 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.44.0


