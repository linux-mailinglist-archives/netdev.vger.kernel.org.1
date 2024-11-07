Return-Path: <netdev+bounces-143006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA19C0DE9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5902F1F229B6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BC217465;
	Thu,  7 Nov 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnyVET/F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881862170C2
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004607; cv=fail; b=TIhjj8NGu1vov7h9/R8kScWiW1YTA/OuBAhfEQWucfuNM4TUJrg+5RsILQUlXj/3phs9WbxUPdLzNxjCAuohuHJILY1VRktnOr6fUvhtqGwSMCJJaInfjwszaMXiqMqnNs2Pot5FO0P0d4FNd0Jr2qWRJcz4U1akDOaHJYhB0gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004607; c=relaxed/simple;
	bh=BbHjsFZ6M/2S0Vtsiu5bTxrLtP43bSIVpnZJDQ0M6P8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFYg0AW6zjeX3qbErqEBft1f6FnriDR4IuJY2ZLfGEilra74LfXiiWdBVDF8TmEpd4mUYK8TNl7D802Sh90UqLgH/n0oDl4wIMC2yUUEkjwuMOM2mFiuIUhToX4AGoqdcCXgweMzvHvFxPh+1KhetK7ACGXWhO7D9FzSV7uuWdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TnyVET/F; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaN5clau8Z0wEsthaQJ7tsbaLOtpduul87PrSAiPEmCsSbbaKtAoMUdoAkPV+kJIi2rotOPJfqd1lRwrJ/a4UU+EQR2NjwptgpgyjhacNx2poqJE2JTIpO5ZhY6WtqVRHtMG0/+UZ8ASdPlzNnxJGNNgJt4jwBlgRAlVger21FCG0TWNjPFL//21QKS0AF9yUCghUxsQOuuSZYR2a1N/x1Ma3QPojP4tsQ2+Muukw5wNJSe3fxQVOpUXJ5+ueV2ZuyVduTqwTEEWRkdKFCqeD8bXwi1Fd3KYd5FQFdcn3MkYbObVGT8lwsK+8srROHQ+JUKWeQq9jjw4TH3kuFr1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRLH0M0LFehKMfjsGvnAS13qN2GwCDcOxzaSAEE15zs=;
 b=wYnnLSWC8DrzfrF3/cathfzaN5PZfM9ImatyjtwdEOV0ALg8ZlfRaZdeUQediFncTUoYYTGN/sWIJo5tmNg3t4cUuOTHBaY7tufh7Mdnozd8l1V2oFfTNwKLw8dfOi3Miv8++cUFC//FXsWD2wkZC485VgNc8AT7+yrbgy6r9sf/AwqC8eDQOcZPBI/+UZ7/oR3mz7avhcBv9QTrXBfp2lEIuvTj37AgglBJl3HZenaV2eomAvH974gkeUxebqce8zUCflrRxAj5Y/7epcDThzxpTZA0THy1I7ldhlmvTBeqfxTHDkesLQfGBKhzcaOaKEyp0NcI+0Dqb5BvdfmBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRLH0M0LFehKMfjsGvnAS13qN2GwCDcOxzaSAEE15zs=;
 b=TnyVET/F4f5RG+D3GsR+UlBSySJWEOwERTxUF9slW6D6Gtkb4JrmhJv6ZxlIoYlxc0xW0BL7IjPx9S+BXxDjIP9urEas3qqR+OQtBw/T731Ch+hc73u6c4r/0jb+qj014cZP/L4drrUbov3/JZMhfhg6JGxtKiBQ0/7pFOsvrr7Dkjh9uJexd/T/WWhM/gKpgAm7d+/uqOv97O1ctR7FddgAN9NBYZjFalxQhxY1X4moTjI0UESNoBi/nNawJFqYAjC0Jp/ZAn2UWuNy4HOUcoNsSzCtRxDAli5Maye0n0xmHXk1lSLQdBKROi+IRA4y1aQUdHasiRosYJyH88Fi9Q==
Received: from SN7PR04CA0053.namprd04.prod.outlook.com (2603:10b6:806:120::28)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 18:36:41 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::4a) by SN7PR04CA0053.outlook.office365.com
 (2603:10b6:806:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:25 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:23 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 5/7] net/mlx5e: clear xdp features on non-uplink representors
Date: Thu, 7 Nov 2024 20:35:25 +0200
Message-ID: <20241107183527.676877-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
References: <20241107183527.676877-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: c32a5c4e-2025-41c4-18b2-08dcff5b1f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hJbsmFlYkSV4+JIllHkYGrTABye1FW+3XYYZb/7uBdIhOPSLBBDMiBk0qlYY?=
 =?us-ascii?Q?JlO2ioRkIDFJK0uSEY24KBlaljI2aAxSd/tC1rlYWPjf5MZdTLwTsb8y3yrr?=
 =?us-ascii?Q?QLpB1UoQBgujPdWoV57PYQ6y6QkLuZ1hQsURE5WVWWJrG0gZjTJGP2o5cVxl?=
 =?us-ascii?Q?DmzraDNG+IirHl916qleFmizd7ssFEcFdKTl8tSBw77dOGCTrXwDYWtBbcus?=
 =?us-ascii?Q?LFGVrSxn6KZkFSrXAUjIKK9y4KVBezFkI9ZOdqb3C1f2QmiTOeq2yl3TwcAz?=
 =?us-ascii?Q?KnLoonrEX//vUXULue2qJcpv4vo2aiSyeX2BLTfOSSHs+zpkMsIQ0ZWIfTYP?=
 =?us-ascii?Q?oRFq2OUoQDwElgMgbD3wMnCBOgDesVRPRj5qk6XniWd0cylYSMi6c8G+0JCz?=
 =?us-ascii?Q?GVzxTZdrtQ4OpDx5eVjCSfMRynw7Or8iHuTsqUnXlSNdkES1Ak2wdMygGbr7?=
 =?us-ascii?Q?7X/4YjW+OwIwIyIzYoITySqoJwXS4YhUdJXxMalKBNQ2rQUXiQHcregCus03?=
 =?us-ascii?Q?4hlSVsHejo+fYJZ24tRKaZCiTB9BET8+5ezIOVtdp6OrLb0ZrqY7IStr9iq6?=
 =?us-ascii?Q?Nk+hbG3PXJzHi7HKs+Fc3EwuEztcuPq1pABe95hkIAyvMHUVP0oaeaHMxLWq?=
 =?us-ascii?Q?uWXSAV5QhNfmvH5XNg6dAy7kdG5w0PnuZ5pDS/4uewAwPq7FT2mQpTQZpvp3?=
 =?us-ascii?Q?X0aCkZpLikPF9BZ3kbhXv2dgT7x/qhsTezWHcnP8PU49o+/1TK7JKC+AUw+K?=
 =?us-ascii?Q?zIlinuti+EniwxSGakjtzHKvToVg2+n8TVFIaTs8RTW1B2E6iCeSGIRkpb7L?=
 =?us-ascii?Q?vo0AAgD4SqFVZCtaqFRBEh0rqq+dDCkjO142guglSz6KbRVIxDcr/Dcrng4P?=
 =?us-ascii?Q?H2c9yZYIQ0bevdmh5eYnpF1zRhR5DSOEmkBjERtkqcAo5RycFUiTLrk3uxhB?=
 =?us-ascii?Q?cq4KY60zx9KIqKXQm24PXS6lwqHnx5CNSn8GnIUh2lAAUXPZqD3c1IkGU9Pr?=
 =?us-ascii?Q?gnOtrw1uPiM+ux5V/BwZO2dC5UrDH0O/7i37zBi6/k6mTeErTWQlMOSazpUJ?=
 =?us-ascii?Q?oyQ77lHMH8X0fnKon2C+wcdGDRIcmln8/bnuRJSbKAOk20vRTlgGkiEQ4/U/?=
 =?us-ascii?Q?aPlqGpPgHcKdJe//6VD+wCPskF/TIHBRtcHjOSPNdcozwAHGVE+G3d1bt6J7?=
 =?us-ascii?Q?5OCwreHqDaJOQ22dwot3Oz4wSe0XmXCpzOcIf9yFDakHCTbgDcK+vzhi8rJc?=
 =?us-ascii?Q?GMnefTDdUIaJoONvwFKbdA9lfyVJNUxdz8iV9I1IIGXuwG6thTMS9fmLdak/?=
 =?us-ascii?Q?bi0ZQZ5njQbomxmZsHmQDuH/MLKjcTiFrfiH6fD8IxbbDo1LAL4QMl2kSiox?=
 =?us-ascii?Q?cvstItFcdbK8sNmfrDh545LZuacXTi4IP2R+y+dfGHZ3/GTADA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:41.0377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32a5c4e-2025-41c4-18b2-08dcff5b1f47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827

From: William Tu <witu@nvidia.com>

Non-uplink representor port does not support XDP. The patch clears
the xdp feature by checking the net_device_ops.ndo_bpf is set or not.

Verify using the netlink tool:
$ tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump dev-get

Representor netdev before the patch:
{'ifindex': 8,
  'xdp-features': {'basic',
                   'ndo-xmit',
                   'ndo-xmit-sg',
                   'redirect',
                   'rx-sg',
                   'xsk-zerocopy'},
  'xdp-rx-metadata-features': set(),
  'xdp-zc-max-segs': 1,
  'xsk-features': set()},
With the patch:
 {'ifindex': 8,
  'xdp-features': set(),
  'xdp-rx-metadata-features': set(),
  'xsk-features': set()},

Fixes: 4d5ab0ad964d ("net/mlx5e: take into account device reconfiguration for xdp_features flag")
Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e601324a690a..13a3fa8dc0cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4267,7 +4267,8 @@ void mlx5e_set_xdp_feature(struct net_device *netdev)
 	struct mlx5e_params *params = &priv->channels.params;
 	xdp_features_t val;
 
-	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
+	if (!netdev->netdev_ops->ndo_bpf ||
+	    params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
 		xdp_clear_features_flag(netdev);
 		return;
 	}
-- 
2.44.0


