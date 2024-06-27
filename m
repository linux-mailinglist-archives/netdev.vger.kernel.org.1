Return-Path: <netdev+bounces-107417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0425A91AEBE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855D61F21C3E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D8819B3C3;
	Thu, 27 Jun 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Do1395K+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D419AD85
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511490; cv=fail; b=Mf6xFqXvgdQ4jF9qr91AecJjaRYclk2iOfdQRM4Gg+nV2TrwU6qWxyFwjwgGvbWjxAU6Q2VU1ahRf7EeXfo7UkoAuTAAaBInDIie4owoc+AX24Tw5skpKdYVljEC12ixZf/zKbC+7Y9dy1Ypy/0wv1E5f2IAE9CW1tbn9fpaSW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511490; c=relaxed/simple;
	bh=lk+e2QqIMLXks1su1vtDkosoZWYpcTW6x+CK+9QHOpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojlDHxLuK8zgCRZbrrYWJPft659RR6FdoZ/anWsBUNlnLViemruNS/1I7Rn8MvMZgMfWHCRI/NhwgcPMaeD3YO0GhuhQk/iKqWkOkkDF6lrDPqvXA53+gnFBfAM1s1zIWTwHQOXqSsOqtFkcLdHs/bWl+M7gRPVtobTJoS/1ZrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Do1395K+; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZAAw/gDWft1l0dIIU0xbmjiC2g68iKa04PwpAgz7PWPbm5oz3+FiCMYUMOVFKsqnm+ICKwN4Y+JjlHcAlG3PDqs5qnsCLCX0EwV/EuoSUYZXuzNW8rRFpvnFA+2EVlN+YeRfHwNK9jFBUsfj+I4k/mlvyAukJ6LBvXrhV/navKAM+Pm5hNVAMgVifSjcgEl0z5vXRWonY3HoNG4mquGY1/qrRWvA4IusBrxr7Eimmyt8twyRPyDpeRc4dYp+qgHH1USZHquKagpwyfQiOw6WtzDCLQKEnwx6cvXboMMh3kxxpRWcu7DEbS4/vMl5d4MQmT0EjEZYAQH4nupgZ716g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hCg8VCZDzUTSCudGzKrdIi4jPS2FNL+ci31fPsRHK0=;
 b=GQLJCphcrFfkMEZ9X2JrPlqWuMNVSCjYrTyYi7XbiDo4CQ4ZJgHPLcI3leiv2hktqTkn0C9Nqt9lLkxYpYGyFWsuqjC/epVPhhuMgIdRGBRM2pH6iUddx4Q15sjR62OSBRWEasTFJhGk3y8kcv/0p73itqqoLxGhK+1TI9h9o7L3nVoHUzENEKeTbLKwQEZyJ824Jqiq0YCgVpizx5LcNPE910CnrhS6sZggnIA2qfAowiTSYbBMGgHvE+t+vcwWM9XcM5Tt5RK9G+QUFDznXlzb0xluBn2dHtijsS5XtSLhigRXKbfee/C1W2Oo0exJYFUf+1U7UFuATGQ0SVnzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hCg8VCZDzUTSCudGzKrdIi4jPS2FNL+ci31fPsRHK0=;
 b=Do1395K+Rtmij/9awlh18BXyNQEDZyjV9pWxUQJ2hPCGYyMT7wm1tf3VDo45pvXLU9wWboJYvAADZTNrOu6ndJPVh1Z4dpCzd1kgHehBXkmO/5knEQU9C2mU6jR9+GTATWwh1RzkjU3YinU+trqgtKEs3uL1pGq43BzUblAilt2dSqNzfQTtnA0JVE1YxHlgPa/Olp6Ssq1v1azLp1GcllJIVLaDErRPmBl3/EEOZGfFnTAcEAaTWsrjsosIEcS/bj9XuzVXcy5etYxumpPqXmEKTJhb+W2JtwENG304tQhFIJ+wDyQzS57UvQoWfJ0N6cDXzdbrbfF7/5wULU3JHQ==
Received: from BL1PR13CA0141.namprd13.prod.outlook.com (2603:10b6:208:2bb::26)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 18:04:42 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::8b) by BL1PR13CA0141.outlook.office365.com
 (2603:10b6:208:2bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:04:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:04:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:04:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 7/7] net/mlx5e: Approximate IPsec per-SA payload data bytes count
Date: Thu, 27 Jun 2024 21:02:40 +0300
Message-ID: <20240627180240.1224975-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d1558f-9b4d-40fb-7fe9-08dc96d39ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8smZ7IqNLCm8S513y8lGnfMA7QKPFgimMljvlFKh0gakyKusOF3d+LhFjTLB?=
 =?us-ascii?Q?UIwXKS7GOXgN9IPczWiBZqMU4qC7PEikWvFQQoCPhs7X78/tU0vfBNzGInVH?=
 =?us-ascii?Q?K9Uybgqpwh8OrAESuOlXfq743a5HttQIkpkCIoV2Y0O6wnblAcfG/iOnQVat?=
 =?us-ascii?Q?sppaCWCP4UF7lBisx8US8b0dDLWyZrLH4WabRvUJGMSbM73956PUK/CVobzV?=
 =?us-ascii?Q?TaMLqp1IQEMyd5OLjYpDb2A39ONZnQDLWh4ZgBD2MrMqmvIHS1m/ee2hhMeu?=
 =?us-ascii?Q?0d7LtbY32VdJwpxxF3kPd8DDNX1XlGcH3e3LCf5cjFR2R/iCa70agZvAK5a1?=
 =?us-ascii?Q?ibTkRlqPby8n2KU/6GTzIaCLHyZETvbr1EIb6OVlEseoU0uImyhdZoJi9mX+?=
 =?us-ascii?Q?VywDpM4R3b6tO+ghZxbCSzJ+QhUKNXD0n6kssSQf5fqZB8iq7edhLYa9CNk1?=
 =?us-ascii?Q?okZMSp1zpMdM9hUZLS5tZH4sryXeaVQHDBrTXcwGwm+AmJY+iLuFHMb3oG86?=
 =?us-ascii?Q?VrB11EX+Fuznqm1XUQztDPZ6W0DNa8msGtW9cNiz3p7W8R63EYnm/E5c22ak?=
 =?us-ascii?Q?WWp6lA5SVsRQ4tmHVmbB4Zp0fcB+yl8FWZobuZzQXPX0MBcCgV5d71n9JtG/?=
 =?us-ascii?Q?8U6qYGaa6a6JzBxvWv0he2JVDnJXygcooh/1dag8e6MWKOZJ2n8FSSoEXU4w?=
 =?us-ascii?Q?hJOroTBv6tweRnEhLQqVJPmGhz9ScKmBnMrnVNhOex+75NGO52TJVn6zwytT?=
 =?us-ascii?Q?yUkLN/VvQ79+Q+HBdKdEA+6Y0Vc9bdQI+xh/bPqCp5NOizmoxSd9q4RNtaJo?=
 =?us-ascii?Q?YwIWHBpGePUvC00X2pNBgIokNXeCunh+xjcHp7W7FMn1rOi79iczY56+r/nT?=
 =?us-ascii?Q?ymQ7BxU2+9oj1pzw+tiCtm+7HZ9oTA9jIo1Yb/FPPm9SxlGJAwvKqhJKM3cb?=
 =?us-ascii?Q?BlDvYLL+I9UdD6Ih8/F/+jw3PstIQ8eGS4IZixJpfAK9s65cSJU6snEwifaf?=
 =?us-ascii?Q?uShqR3W8A2STnIRqU8eD67obDDrGQ0BkUAIPyJzCX3phxBz0yw1m+9NXL6Go?=
 =?us-ascii?Q?FE5VO6U0Iy8mOFWbwDPpvkx5MnBS38x7oc+75JwsR9za/BWD+sry28HYnfk+?=
 =?us-ascii?Q?kYcWdlLFa06d/S4a9hKbgi2KttlYvlEFDCcQLp7aQfIGAFGjJXBQkcSh3+xt?=
 =?us-ascii?Q?pctb63I8/SpT5szqNFcO1S0X06JGRHb0BdJ9MvjplBSkze0TDPxLL2yyD4hh?=
 =?us-ascii?Q?ZCBcZfAgL/RAH7L2VXsDzBffANcq5GTqbRCictbYz8OvUJVnpkENZS4aQU3J?=
 =?us-ascii?Q?uUhzqMuMfoBspKa5E+MVQeqIu8xWQ+ffyGNK5TF+yqanfcYUm/X+mZA0A7+A?=
 =?us-ascii?Q?XuNnppifEgodUBqwkOJLEntBo2AO8TCmtkUxXsJv4nJUNyek7J8nSYkFcz8d?=
 =?us-ascii?Q?NMp+0s5qarXiGMFuXLH/z/JL0jnJiDQk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:39.0871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d1558f-9b4d-40fb-7fe9-08dc96d39ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038

From: Leon Romanovsky <leonro@nvidia.com>

ConnectX devices lack ability to count payload data byte size which is
needed for SA to return to libreswan for rekeying.

As a solution let's approximate that by decreasing headers size from
total size counted by flow steering. The calculation doesn't take into
account any other headers which can be in the packet (e.g. IP extensions).

Fixes: 5a6cddb89b51 ("net/mlx5e: Update IPsec per SA packets/bytes count")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 2a10428d820a..3d274599015b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -994,6 +994,7 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	u64 auth_packets = 0, auth_bytes = 0;
 	u64 success_packets, success_bytes;
 	u64 packets, bytes, lastuse;
+	size_t headers;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
 		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex) ||
@@ -1026,9 +1027,20 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	mlx5_fc_query_cached(ipsec_rule->fc, &bytes, &packets, &lastuse);
 	success_packets = packets - auth_packets - trailer_packets - replay_packets;
 	x->curlft.packets += success_packets;
+	/* NIC counts all bytes passed through flow steering and doesn't have
+	 * an ability to count payload data size which is needed for SA.
+	 *
+	 * To overcome HW limitestion, let's approximate the payload size
+	 * by removing always available headers.
+	 */
+	headers = sizeof(struct ethhdr);
+	if (sa_entry->attrs.family == AF_INET)
+		headers += sizeof(struct iphdr);
+	else
+		headers += sizeof(struct ipv6hdr);
 
 	success_bytes = bytes - auth_bytes - trailer_bytes - replay_bytes;
-	x->curlft.bytes += success_bytes;
+	x->curlft.bytes += success_bytes - headers * success_packets;
 }
 
 static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
-- 
2.31.1


