Return-Path: <netdev+bounces-116117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44E94921D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1960280F3B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE351E7A5F;
	Tue,  6 Aug 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ow+by+J6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485541D47A2
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952237; cv=fail; b=ZWnKK78vESiKu4URmbMvh0MqIyb+IHJZzqIIoT30PjLXp6XatCBeKTE8MNRCiITJUDswV1hWx2L80Kf3AhIgeT2F+zhAq+NZkX/gKn9mqiF2PTyQtt9b+Z0D+f2VwfA+a2dzoWlHTVzcvV+y25KuRjkVASq1z1HJT1N8y/NnJ2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952237; c=relaxed/simple;
	bh=XZPzHc79aEcc8hIOXjBmUvuRL52CB58rCIXLN+I8mCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esJ3fvTcG/mZxqsIaICbrF9dyMZfnm8U3Eq78cOKqVKEpXHb5VcKXC06Rp9K0NcQddZ7Gx/3dBIc/8CEVgq+ipAqv8DRcHz1VuYTTwcOJ2fwC+12SJT/bDl816WpHiiFZkLM8vhUFdYtHA/iZn8iP9eZeNUDh5HqUgChMFYU4lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ow+by+J6; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spoHGoaTVpVOykd4XEwKbO3Tjv7joCSjFi3tACYE6v+Cbs59CPdbGgDD9K1d3SxCgCy18pMnMDYfLTNPlFjh1z0OZ6id1SChcRtNOZkE0/nOVOOJCokD39eKsPMCKM5XXEye4hqmIeuZh05o/Bjdn4Y61XIV9Rm4olJYKaZyZiuAo5GL0OhzSgh+8w/l0xo01xOjkA6U2iDrMsCbkP1Y3YCP8hRu6YDIApLXzNVMOEzRgDY4RaBAbkADPV6bgM7QimUMxN5Kjb0yrp8FY8Oiw7jQ2z3L+CsgCIyYWLfoXRHEJhKQwr3DngHAdhFEcDibU/4uNjhlHu+Y0yh9DeSJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DifpBBpLegKOciyEyO0MkTLjDbgdi31gvoClxiT5XS8=;
 b=baFxuze8bVUSHujmPZDzR+iQvWr73/GLEcaVP5IvRp7/hKEHd4In1DCZO4QizzDS/XdCg3t3KDM2ZeIWIdswNKMOjvhnmh3RF9B62uC/4Lzfv1GYZC1Aw37eucLgMnFRNooVH5Lj6IJUVgVTYDLKFq/bU9DATblrrnMa8rl4CrVAT6KeJxXDYyp0aK29iJHZj9nuNdMUUVHArgYKktHqgYOgCADLE/a3eUgtgVjqATfUXPQwBiGD9ZNlSpCZjh2GlT/hWBfR7SxbeHBIIQX6O3hZWIYxgxdgrjo0tu91hGnQsCJ5Dy/9g2fipHqhUOmtJyUbkpwxHUC9VvKBUHHYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DifpBBpLegKOciyEyO0MkTLjDbgdi31gvoClxiT5XS8=;
 b=Ow+by+J6DMMzBNdhqTHGbpPjW9czg+SDzRgKpJcfwIUhkMgxkcYv1a7nyPFtlrNaEnDKCuw+DV0UItbDZekVgicxLIyK3C1IYfVXEe+pZh5A47BwwTb3KV1RMC9Ik17pLllNs/pItGJHmNjg4XoJZGs6kO1S85cD/98bIJOllpyG4Hs6JJ05LeBgSt5XuhyZgyFj8pIwugwxJsFd4l3gujF/+KzaKknE7gND7BU9Cy3F+Ru0TKhNtGT14STh/dmgkyyZucRQjugp5MjlEujs+HZSz/BBgWUUE1rbzO6Gl8LAQO6qFmlqnYWoyjlmCkW/r+W+/d2d5HTg+q2bwRWFng==
Received: from CH0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:610:e5::24)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Tue, 6 Aug
 2024 13:50:28 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::8) by CH0PR03CA0259.outlook.office365.com
 (2603:10b6:610:e5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Roi Dayan <roid@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 01/11] net/mlx5: E-Switch, Increase max int port number for offload
Date: Tue, 6 Aug 2024 15:57:54 +0300
Message-ID: <20240806125804.2048753-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd27016-b287-409a-90a0-08dcb61ebaab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRtykhpAVNqoDiemQQSulQ+z5Ji3wAtlfepVcUiNtLMWoiwf15nEx3qdHEtt?=
 =?us-ascii?Q?q/WRn6KZ7H4Pk6OR+ofxOBWmrPcNHjMHV6ORR7MznFrZjdgDuC4deoik09sD?=
 =?us-ascii?Q?X0TzUDWIdxUWWMbhjpwlS5XlUWzscCjn21w9h96Brj2wAvY/ozBWnxighiGN?=
 =?us-ascii?Q?E5qlOCDK0UUJJfptrgUgJm0PKY/1/OAb/ngjUyQa+d+Mi6hBb+L2a2LzWLwp?=
 =?us-ascii?Q?eQ/dFA81wg68+2ZTqS40PuuCBqHcQACmtayNJsYIcWCN2hTTAsWfadYGwqWw?=
 =?us-ascii?Q?ncBggtMkLWKsPksvIQezkaY1yuUGN13Mfi5J5MVzhUFtaexxpmbzmU1zKrJd?=
 =?us-ascii?Q?SH5OmXhsPudkjutvtPcHDnmH8JfhKfsW74MZhT/Srm43qSWWgh/G7nmHzV+h?=
 =?us-ascii?Q?GCqzAX/Yzr5KIyT2NqFAVyrYGIWvWlj6EEk/OjvZH4zSgWBEpPhRf0Rw9rRY?=
 =?us-ascii?Q?BuSCcz2T3uhvZXJpyQiuPbjt+IIL18nrjRYgccCffLRHXd0tIqzWuNMr5VN8?=
 =?us-ascii?Q?M+JfHK8sllGOmtSVY7m25fDDUle+tW6gCj8KEh+IBazVOCoEsjldTtXf1V7t?=
 =?us-ascii?Q?U+93/aK4S+JUkhfXrEgczCPl0ZN/2QNifQRSFcL4CZOmD1FkLZed53M4QH0N?=
 =?us-ascii?Q?ZcakGyuoAb3fDZbMZnTeKhLYUjY3gdLcAzuX1FnJtrM5jKTTSkhqoJ9Za+4g?=
 =?us-ascii?Q?cIY4xtBKhXF1B9NUw0v9L4gNtJdVeaFHNXi0HjUof0vawMel2XbE3zrruNDp?=
 =?us-ascii?Q?bLDbwwXY4ejMSSldmnsVj2to08Ki4r2wpC1gukNDh0NoT35Fysyj0Qg+v3Ll?=
 =?us-ascii?Q?KEi/prIh4mgqVyRQ3LaoGxqpl6S40ADRDtMLeYEJ2wAC5iMJkAGATxk/LZHS?=
 =?us-ascii?Q?fEeG1vz/mkrwLZ81WEBz+Hn5E2x1qdKsQzMRXGTKMirZzyTtCPBtPQ9xV/Cv?=
 =?us-ascii?Q?0uTAGYL1813m0FqihIMhom5++/6PkX8wBnUV5X+TaONieo1/ixWqC3NAMHn7?=
 =?us-ascii?Q?YqPmrp4FA6nq0rGsKIVvqjXy4bbbOq3fXBH8hvNqEvEgWHXBAPqee+A5Xlzo?=
 =?us-ascii?Q?L9mA8kL/QfZ6IRFMlaqYru0AI3/qVUvKayAepK0eLqkZvVuKUDK6h+MV4tXW?=
 =?us-ascii?Q?2sxloJQLYZNRSIXS+4tMBWyeF+cYcvZnJO6HUAuGnh9pUPp5M/DeJ0YwkMD6?=
 =?us-ascii?Q?Br8CFY0CCMuTCcBMNOn1WHchOkIZfKhE72wkDa7o5N6f2r1cOZjQZ24eWMIX?=
 =?us-ascii?Q?BGF6OuJPbB1fLoeTKh355PYl4YmHodSFEf94HhM45g06MK8phlDXxZMLd3nv?=
 =?us-ascii?Q?NeOPCKoNJPtD6ARsMNlg1hDP0OQqyKnulUCgPoWvE73vWqFqGQWI3bT7erch?=
 =?us-ascii?Q?Ga8c3zrsnDdvFn4DBXnVXsNFspdJdGXCpgtf2OFgwmFHgRkQUPp+nMdrc6oI?=
 =?us-ascii?Q?W2TeKd9LJMwraT7hPSYw1iQN4v/NPggY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:27.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd27016-b287-409a-90a0-08dcb61ebaab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

From: Chris Mi <cmi@nvidia.com>

Currently MLX5E_TC_MAX_INT_PORT_NUM is 8. Usually int port has one
ingress and one egress rules. But sometimes, a temporary rule can be
offloaded as well, eg:

recirc_id(0),in_port(br-phy),eth(src=10:70:fd:87:57:c0,dst=33:33:00:00:00:16),
	eth_type(0x86dd),ipv6(frag=no), packets:2, bytes:180, used:0.060s,
	actions:enp8s0f0

If one int port device offloads 3 rules, only 2 devices can offload.
Other devices will hit the limit and fail to offload. Actually it is
insufficient for customers. So increase the number to 32.

Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index c24bda56b2b5..b982e648ea48 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -139,7 +139,7 @@ struct mlx5_rx_tun_attr {
 #define MLX5E_TC_TABLE_CHAIN_TAG_BITS 16
 #define MLX5E_TC_TABLE_CHAIN_TAG_MASK GENMASK(MLX5E_TC_TABLE_CHAIN_TAG_BITS - 1, 0)
 
-#define MLX5E_TC_MAX_INT_PORT_NUM (8)
+#define MLX5E_TC_MAX_INT_PORT_NUM (32)
 
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 
-- 
2.44.0


