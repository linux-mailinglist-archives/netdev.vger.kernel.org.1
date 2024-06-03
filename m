Return-Path: <netdev+bounces-100357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A068DAF1D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79111C23F4D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6C13BC0E;
	Mon,  3 Jun 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8pewcl1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57B13BAD9
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449826; cv=fail; b=iA+rgPHoK4cY+1XXRCwuz6Ha6QsNohGE7wd7sm/yvbG6cS10+zCD5U2lvm+VfPXhsm7UE0fICdjxuKrxRUI1DPcoeB5RxgYCWK92hm2KzfyTQ9yJLX6oQvknCLluZMx4gB/jsDjlXTNpQErq+yRPnRG6K0HTLplI8weN0a+SfhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449826; c=relaxed/simple;
	bh=BmOKbKVa1CG7RAKersuUwWCTWBUBQRSsEl0DxU+jZSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuwIqujX5PeLxpYiOD/e7Q91LmmfIDUIChQD8rNr4lrn5LAt30mC65hoxEu6Uu1obX090F2khefzvk0QVe4Tc9mDlRtGn3Z7obs/n5dGXdQ1ehPdAr5YeTdOJ1Ix2RxvzWWb5azzOyj11NLr4Y1dpciRp7aUWxCkFg8plt9Rasc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8pewcl1; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYu4RQcO67Du/jivyYSdlPKMPQu3gdnxHG6JZRAlq/pMZRZ2XGMdP/KPKWfQuS17YQo0b+0veWhwvyHTgKh942EoKrJfAS/E1mwRKuP53br+ebOxRAFMV1ker8Gl6FUeBIS3gUVRtzTSbrTE9Y4AJ1yBDeFkbbaXTTYIS8huC9t3nw6zGyniod5OKkRNpc5zvZL6Yier9V31j3KYacrypmTvLiw7ZnmSO8PZUbA89F6zooJRTwwsdiYUJmIhc3B0JbjGiAYq+o6xN0er0wF+2GaSPJtTIeYyP9xoWUDtLsqf/gbNmljX7nrgmyG18cLBPDCXxWkDBcDJ/xTCS+eKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekTscCCgFfc3UI1HivK0T3e6YkI0BW5ektRjdmANkxM=;
 b=IPKkbdpNTgi78ui/NtnaTfGERQ0r/cx84AskXlJa5sXD4pTmk4m8Ez9HpMrYWG3/AppM+D3/TbWSBANTdq3TtzJSbnxZQ+K0vwQ75wvCEUsy0od2s391K3z1TWgMwKSdXNUBXD6xrhoae5i02JyGYfK5ENUbdWXmfwKSkmkhEGLQDsNQbaWNVse1uA6nKkISD2nMHc719MT08f478ibXOhvFulcblJLZJP7nei1dVyDEWD6x03892qP33JRcm1slpJDcpms2aSR7jjJfh+An0dFf3EGi0Ecfb3P203NorKMgg/dwk6ueh06aQAXEfJBMLZFxqNuRS3dzjHXm2fnNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekTscCCgFfc3UI1HivK0T3e6YkI0BW5ektRjdmANkxM=;
 b=M8pewcl1DRKNcmxu4FrRFVyqaI/9d9hvGkiYCExQB/nR9W3VvwJ7DMDdNjGzA05iIq2K3ElWUBM1R9uTj9MnXpzQe4KTvKXcZ9DKCmNA3WSFqUEzkO8Z8LJFHwcFnNV4oYZ+sGGiILxOnambUTxTRfAtShAILj/LtBE2KEflDmluurhxeFwyNF/NkOeG+Mel1Hz7lCZ7otZBlZN23PDkFNxr9ubF1eZhsmT8xVRcpCc0Qe1PfpE3xXfDAkevaWuoHT9Jp8vt2LJaOoUy+KuifwEa+ckzFCPkRDLoiQUqo9/p8CmU6NMG0fligTOfe5v0McXSJcEJfRdE3YpXGH5jsw==
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Mon, 3 Jun
 2024 21:23:42 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::37) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 04/14] net/mlx5e: SHAMPO, Fix FCS config when HW GRO on
Date: Tue, 4 Jun 2024 00:22:09 +0300
Message-ID: <20240603212219.1037656-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ba1958-3a97-47dd-21e2-08dc84137104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQNltyq+v8rpCcLxguaw4ZBTuw20GQR70BM6Og/T9GPPENKoHjmFmeIZ/6oz?=
 =?us-ascii?Q?Vv6l5Y938UWQSMNoVdGgzcIHcenw+PAU++fs3Z10KuSfcgjR0eD0NyexTDTl?=
 =?us-ascii?Q?svRcvmVScZqPKg0DZElplF1ea+YezrujHk5qki536rzzr2yMBlD61gz/79gU?=
 =?us-ascii?Q?n7qQqeMEYU/zK8Y4Scd3KvCG8ACRCMFeHxdGGG37mOwpwnb6H1LxVPryjqAb?=
 =?us-ascii?Q?DfvDnMma/kfY5QT616ntsYirK7vsGhL+Nc4YiUL3aUG4rZr7uj47QVpspUEr?=
 =?us-ascii?Q?0Sj20ep3ZPLHW8s9YK4yVRs7CAa9lVVQu65tiIMptUiI5a0Y3o1hSsIpva/M?=
 =?us-ascii?Q?VZ0G+06EZpseWC3q6v/so02J7YQrSoYVQANrRBeXezCMJrnIwhDHGQKdqrz2?=
 =?us-ascii?Q?ugEa8pTZFkN2GWYtRuuuWAmFgfoz7b5Qhj9Ki+ncRpMGqbwtQfqBNwKM5MPt?=
 =?us-ascii?Q?V7ZDB85czwtVYvmcW9imZe9XlU9VPp1w3YZLzqWuuYM+H+IXxVttYe3kWGLd?=
 =?us-ascii?Q?QZ/wY4WpjJghqPCqEbKQpcMhuW+9PHuJNTXk+4XNnCx5vngnG8bUb+92WLnP?=
 =?us-ascii?Q?sZFMhjobtdis3fZ2YqTJe3e4/3n1yQRW+YTEpH6DW6dX8MCjHRydNsQg7ImG?=
 =?us-ascii?Q?5WrVhrZpBdeJpkV6g5/wOsZfmk9p8azDY0gMTuuw58wHIbd2aCHczdtmD4aJ?=
 =?us-ascii?Q?Bc2jSQvFGLsZuZ7rnvmLmLMin3zc6SLnbqe6SoseDxz+YzfRlPdyRiJZouNJ?=
 =?us-ascii?Q?bTUCW3FtGYQnZUWqSjBs2WtcykYjga2X80iVfmURaUIZg3fpVAnzqXPPxbZp?=
 =?us-ascii?Q?GBOYGTiPam9zUNTyyGN2n3hVnYpKvTQ1uuWdarXq0CeJMphMK0V+iP/vuo+7?=
 =?us-ascii?Q?Qxx7nZYkzmyrWJfVF73Jxi324ZQZeqdeyI8DVBrgezt6NhfJ3PKX1LCodIuk?=
 =?us-ascii?Q?KraHWVgDlpg6iuOq5xC4ecw/fIU9CHN3TBXlKhQtEl6YYUBsgmSa7u2BOiZg?=
 =?us-ascii?Q?hudf9mXtgWS3sQrzzgCrB6PCjIS4NchJKLzvZaUpIayDW1z4KYhETghD7nSR?=
 =?us-ascii?Q?YWu7vgcUP4UqFsRQqSrL4Hx117tFSqcqR73a+9Wz4nK2+qKikS5vBTCsaD80?=
 =?us-ascii?Q?iLP2SK+iLdbxpK4u7qsv+ezQv2UPtsssBiebeDzaMpKQiOa7TcFZY1UN0I8l?=
 =?us-ascii?Q?0oM55mWwULB1OBWRbZXT0ImDOhROyJbYvndyV8F5c5sYgsPAK9WTltvTcVGr?=
 =?us-ascii?Q?KyIU69LZR9MKmrppsadBPTvILi7CJIQ7RLM07qsGKgkPg0z7+KbXlc+cTAxy?=
 =?us-ascii?Q?wHL/hqqtywYLaOmyMMhwndxjfYFUvj6p5rtaP5O374oGqHlF4ISLn7UKsKS/?=
 =?us-ascii?Q?5z+G1eo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:41.3702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ba1958-3a97-47dd-21e2-08dc84137104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033

From: Dragos Tatulea <dtatulea@nvidia.com>

For the following scenario:

ethtool --features eth3 rx-gro-hw on
ethtool --features eth3 rx-fcs on
ethtool --features eth3 rx-fcs off

... there is a firmware error because the driver enables HW GRO first
while FCS is still enabled.

This patch fixes this by swapping the order of HW GRO and FCS for this
specific case. Take LRO into consideration as well for consistency.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c53c99dde558..d0808dbe69d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4259,13 +4259,19 @@ int mlx5e_set_features(struct net_device *netdev, netdev_features_t features)
 #define MLX5E_HANDLE_FEATURE(feature, handler) \
 	mlx5e_handle_feature(netdev, &oper_features, feature, handler)
 
-	err |= MLX5E_HANDLE_FEATURE(NETIF_F_LRO, set_feature_lro);
-	err |= MLX5E_HANDLE_FEATURE(NETIF_F_GRO_HW, set_feature_hw_gro);
+	if (features & (NETIF_F_GRO_HW | NETIF_F_LRO)) {
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXFCS, set_feature_rx_fcs);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_LRO, set_feature_lro);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_GRO_HW, set_feature_hw_gro);
+	} else {
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_LRO, set_feature_lro);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_GRO_HW, set_feature_hw_gro);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXFCS, set_feature_rx_fcs);
+	}
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_VLAN_CTAG_FILTER,
 				    set_feature_cvlan_filter);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_TC, set_feature_hw_tc);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXALL, set_feature_rx_all);
-	err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXFCS, set_feature_rx_fcs);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_VLAN_CTAG_RX, set_feature_rx_vlan);
 #ifdef CONFIG_MLX5_EN_ARFS
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_NTUPLE, set_feature_arfs);
-- 
2.44.0


