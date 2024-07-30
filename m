Return-Path: <netdev+bounces-113991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE782940837
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E300B22671
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95018EFFB;
	Tue, 30 Jul 2024 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="On8WBF0E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDA161914
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320336; cv=fail; b=NyVVeJ9ix8/uICbYQ28qGRW3dzz2/revknkk4xJDeuSebH7NISji+VHFZsg0HMImroPzVlEgz67wHtLLRrBgxCTkhhE4GN5u0eXO7SjA5PGJPXv5wxNezf0zNS/r+92Bgksu4jeC/niGZRAD0dMWEtteA3cZUXoRSpCGMLURyEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320336; c=relaxed/simple;
	bh=MBT6Q2/M6kI7b7qO9TdO+imCttgRPonI/cpRDMPdCfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6cIbxWm936sSk9YpikOMQufk5q72RqvNOQPGho7dOJqIUJKCmsTQSopp875NUaToNyhDB0c1qD5et6oTc31iRPpC9CCCaL8lSQajIJnOOd+bIC37XFNpP7SxUPJp+IdgFfpaZVQNv1LGOmfijjMe3HdQlVJ99cGA8fGks44DC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=On8WBF0E; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2tc3TQMmcV2cZafu6tYUyolIsBVI8xIJkGLf0ZNfvog7TZ34MtQgBN39uVEqr88Vw35ikTZ/tywNAHpJXf30nfYhWidfZF3vgt9CWFAXPpdsgG5qs/R+iUCtl/k64yr2E+wjV2mS9AN8lKQnXpmrnPd/nzCm/CR0oR2UytXMJjmr9I7wHAD/3opcjX6Qm1B7JVRXbJRevYLxJjzNpliBftiViZselx4sBVqty18HTbn4bZx+iNCuZzvYLnB3pNaqRIshd9liPpOqBCby+Qxfh6UInpGk9jjLfxhCO0f1A15B9uVeyFNcyC30RmJ+UrKt/OSC2F8/dkeUOZN9ko0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54XDDcLl+3fKYBO8HUdeR0HMl4DZ3+VrjZs3FlGH5V0=;
 b=QUPC4wurNl0pWJhtBtWhgN5gnHP9qhjz9nvovhOx8fhyotPzKxbzlj0MLcZy0UrGlxVHSl6ygNzrXaOgawxzLSynb7DgmKx74Mym8BoNWC+zvDMkT+jNmyOOEisOPAj/tHAiQ6Gw78ScfE8IC3yc/qOoiAb7U+UT+7BBbezTw9aMbLoQqxBweXC1jxsaCyEdp7JnSK/uYbhrMqi7oQcT34GTQvNqG3mUnFhef1fmokSSNKkGcTYXBOBWTEBy9kFB5oaSUhxbaSXqyt4PQvFVr3iNuZPWRXioxbprQF7lulUgFtRXStnpq+m7HDygXopbejIt7tp62cH4crZiJtvlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54XDDcLl+3fKYBO8HUdeR0HMl4DZ3+VrjZs3FlGH5V0=;
 b=On8WBF0EmfVLh/E6omh5v9lQJPcrldbgS6EpQx04XzFkW8rA10k8dVcPrJjmaTpO6a0hC0kJ4Qm97DvZTQiO/qDv7XFNmbWkBkX4BdRQPqmm0Umi1C0zNca+Z1yIDHEZWUEra8SnxbUOa0XERtuavVrGuvtcTdCvfAEQW+/6MvH0DWCCeHrQJn8hW9rmYjw+mAnrFgqBgIn2yDJHNi4evbZ3OYvbKi1F6cQkZ9MeA9E6MnPkOPaKuUeELuAJ/SarN6qLNNlpnfQYB5qa6xDPUHm88ngYa69uTxyZwWAr4KshtSoO4DW0rgKFJM/lll52jyTFK7rCWE6zZ17/VZwzxA==
Received: from CH0PR03CA0447.namprd03.prod.outlook.com (2603:10b6:610:10e::24)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 06:18:52 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::c9) by CH0PR03CA0447.outlook.office365.com
 (2603:10b6:610:10e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Tue, 30 Jul 2024 06:18:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 8/8] net/mlx5e: Add a check for the return value from mlx5_port_set_eth_ptys
Date: Tue, 30 Jul 2024 09:16:37 +0300
Message-ID: <20240730061638.1831002-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: f560e52b-7de2-43de-8ce8-08dcb05f7b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIimqtZdBjXQmVbT/Bo4QnC2wYN1uZsB6aGYu0bnqWiM3WtafW5FrwyZlcSJ?=
 =?us-ascii?Q?wvxEX55rcZNw02qINs3YCLJ1dp/VJFB1aPVlEEwDFFPxR360zITUxivvWMtM?=
 =?us-ascii?Q?hLPQLa7Fj9+mnRPy5IapDk7xXJIxoOoxbHABpU6H7kOhWfyhKK2nl2oz6lMW?=
 =?us-ascii?Q?GlT1SJ7raZNBvFE/kFkAl8WcvmPtErtNLJYiOWOBkmvn7ba+LHHCBBz6n134?=
 =?us-ascii?Q?8yWpi+qxZS/atkZMhp2qarrWAoVcl3r6C8WRD5+WsIEc4Uf/9c5u8q/crNWH?=
 =?us-ascii?Q?TA3lzYLffGgIJcv32tqCy4wWGlVusk2jS9QInIhAYOq7MjErPBEgF49AKyiE?=
 =?us-ascii?Q?KjKPWmiV7TwDHytbFZ0TUaZPBwKEd+QCoH1/oIHHdVRMCuZf4IH6Zdz2vUFB?=
 =?us-ascii?Q?fiPq7uh4NiGWyiizZIlSBqwp/o3na6CciL5gKqcvJuqrwYj+ULgi2b1N16p/?=
 =?us-ascii?Q?vU7BJAw3yK//jje42cRv+mYqPm09XgOvwYQ1KtunfKPhSbahcBChAEgb8Ket?=
 =?us-ascii?Q?4u2S4cFUu47G7YpvArZ5ZRbofTPIgwxCojrG57bhWX6NQS1L7uAxxbFNQqiv?=
 =?us-ascii?Q?EpPIIUNVAoHV4xymuFceNvYUCNX9++nWdZY/jiy3A4NSweyyawnVweGJlt6Y?=
 =?us-ascii?Q?sYJ624EatAiZt9LOYi1PDxDUVgBKbajstkDSVY97BDk8NXyrrKQDSGDYyHHy?=
 =?us-ascii?Q?+SErt5/+MhB/4VfA3T77IzaygR+P6g3ThogSJHANSd9UJaS5be9rZt+51zRH?=
 =?us-ascii?Q?7lyDJMYTc9EB0CcHWRfl4upY5zvpXDlTfe4op7K/ISqzMh9QSLLYSZbQx81E?=
 =?us-ascii?Q?py+pzJKTxgwSsRvUUvacojCEwrrDl3mTTXEqNkRlxR6NCDm1LwT2Fdk8V89K?=
 =?us-ascii?Q?Y6pDm0FfsYaB89SvbRxi+xuu1xt815bh/PkLu0nAQrMkCRihMW6by6LQPIUG?=
 =?us-ascii?Q?/KS+589JHRxPao1APziTmN69QqmmMEMHZJNMUpqGrzewcM1t/s2pBJOwiMbr?=
 =?us-ascii?Q?RLJWN0nGlGgoY1uvrRFOafqxiFBzskAmv/CIIHxGEwCE3DXXKJ/x/rWywNrQ?=
 =?us-ascii?Q?tkfzUdcw6ndaxXRniW3PmLRj6KYvvDR/kIV/N66Oe4KgfjJTEynYe9hr0EHY?=
 =?us-ascii?Q?HEiE/rTJzLa0T1oqsIw8qC0ZmB+oCpswLpxbc288o4ktSaZdJGIeZxMTLZ9B?=
 =?us-ascii?Q?Ze6k/zWl0J5mr3+BX15iw4Ylkz4hGVUoLy3a/R9Mu0tRf8dTapnsKHAyC3yB?=
 =?us-ascii?Q?YtMnQ6IlYd58+2uojmKmHl5X7uKofeNpIS2iyPylw4KWZilZPGhpbvts/Fb1?=
 =?us-ascii?Q?72ySGL2+yhWvJNmwjFPBZOTS75TevbJoTeyoLGzFTtIIEtCo+je9/NshRR7w?=
 =?us-ascii?Q?aTMGtfl4h2W5jzdXN944aAfrNJAFaoYV9tBkCjD212X8g9/Q0f8idvHsY95W?=
 =?us-ascii?Q?DuswscYUFVk3XKK5ye6kpfIe/Zueps5L?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:51.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f560e52b-7de2-43de-8ce8-08dcb05f7b7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

From: Shahar Shitrit <shshitrit@nvidia.com>

Since the documentation for mlx5_toggle_port_link states that it should
only be used after setting the port register, we add a check for the
return value from mlx5_port_set_eth_ptys to ensure the register was
successfully set before calling it.

Fixes: 667daedaecd1 ("net/mlx5e: Toggle link only after modifying port parameters")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 00d5661dc62e..36845872ae94 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1409,7 +1409,12 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	if (!an_changes && link_modes == eproto.admin)
 		goto out;
 
-	mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
+	err = mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
+	if (err) {
+		netdev_err(priv->netdev, "%s: failed to set ptys reg: %d\n", __func__, err);
+		goto out;
+	}
+
 	mlx5_toggle_port_link(mdev);
 
 out:
-- 
2.44.0


