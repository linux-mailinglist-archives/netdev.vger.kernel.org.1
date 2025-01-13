Return-Path: <netdev+bounces-157797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE81A0BC4C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5C3A5944
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2FE20AF89;
	Mon, 13 Jan 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Et0ZBCmD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9B20AF60
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782947; cv=fail; b=UDlczBHz+NhCgclhKyV52HSyFvIeh5DUI0+TRrk4d3Wiv2LYCbfJD6xJfVBUxolN8fain7UaYsvfg3NWQOSALBCnREbKYOJY5OTSCxB6PfDNGP1I2i/OpYJwoH4pxHjrXSCzm+mFMUbxLDE950X5Ekse9sTL5v0ToHJimBkK37c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782947; c=relaxed/simple;
	bh=2YWSsDO7jXTrhkZJaxiNopKy3ZYEh0MyMq8imLoxyU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXs0Hq3wp0wlQEvz+TclHbDOmPf173pAcNEipoFzEA0+3nLoF1WqaKTu/U/IWb/B7QhXbITgfrfhiJ5HuUxxaorjCJrBG5SxWhF29Y4Vi16IKMLr2DUoxxKJ97XRyaE+YksktbMmyX4ApLPNGq4YWNY3e+oG1iDYIyd/7xzb6io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Et0ZBCmD; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAIx9n2RkSoVW46AH9D1Sls/9f2ApLas7FeRVoyWiFTUlyvRm7VCwMrcrfkUEWT39FNwkbUcA7xgeUEX7HAgIWUvEgsN9G6TPrnjknHC84xAmlbS+JALHKa1ZQvXA9fkm9FH3Rym3p7mI6ksrlBz/n9U4L3v2jpO7nNEljPjb67yFEca5Iavja9Niufd6b5Vp7BVbDoYAxnLKe4yoNF8EWzvbCItsN4z8mqHQZELoCMJ3XOdNgnUhbGmv12yjWQLncrjrShzbkDHOhABfrViY+7BoTpqtytGSAz8WZ9B3ObeDPq77Ls/gnGz00ogz0HNSWRdSPIKGCz9I9TahdiIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnS/8T5exAcnx65qzpeqcwB7JhuXIXOEX9Leow3mi2o=;
 b=cHYxIw15NuhwMOCXjGl5xY/Fr1fmWNqVZYdpiqfcAm2WX7KKBgJ1GTsaLQzoLzxsUsCsXSEWTkSvRjiuW1Zh1FGgDMo2cF08HCkIjg9wAeE3/pcjF+EE4J2r7MfL2wyi3JEcMcLKxqZt9VRs7ah/BvY1gvmlGJJtEG5ietAHY5ARi14qm0DSLNo6SoCNVeTv31j/xxgRTUwf2umOzlLlThzMhuOvx/nRiv+t1lBNPOIJJjdy7tdPMXVv52Y7tHLToCxtfp/FDbwKiRvMXuvg/5Xv0/z/vHKhMMDov5TdCpDXgDvKLYBAgNBnVPa2LlppCUj7KOgdcR0Wq3K2JdDxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnS/8T5exAcnx65qzpeqcwB7JhuXIXOEX9Leow3mi2o=;
 b=Et0ZBCmDjpWiqV6QMRJtMjzghhGV7Y/yvNwo4RfkkETYDclAqcE3XG7waQasoI7Xz/G6txY5k0HkZOOi+RNj8cqR9oJ7ljv8XkxmldqVcA899SfPBwUVNObeWFyBhK0MmUtCiz5m/gnLXL76M3jeM4k3mZOVCylqpjmB2Yl6oQTCGbyvvJCSuasqmMO5/Gp5Eyq+omxaZ2ivSOEg58wDoDX3mVXYDBqiO+o9ElTSNWkzeatvTb7o5/cCxDfaqaS4GCk0kp37lcHHoZAB6tIEqDA0J9q76JK5QD8ZbWZx7/Hs6YWlb/JHTCvDDxBsWE56QMd3cfEYPXrCUWA5cYwXDw==
Received: from PH8PR22CA0017.namprd22.prod.outlook.com (2603:10b6:510:2d1::13)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:42:21 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::37) by PH8PR22CA0017.outlook.office365.com
 (2603:10b6:510:2d1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 15:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:42:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:42:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:42:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:42:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 6/8] net/mlx5e: Properly match IPsec subnet addresses
Date: Mon, 13 Jan 2025 17:40:52 +0200
Message-ID: <20250113154055.1927008-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9d48fa-ba4d-48c4-9813-08dd33e8dcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aWa199EXmNy0WoM3pW9nvCMvsxGV5D016Ovi3T2RbCn5VQXsDVjiAqVdJwSS?=
 =?us-ascii?Q?XsZlTdaibO/1sZ1N1YgYIfqhBwZvzPPB1a7/yRUHdtyKGwdKJjKytkjg0HB0?=
 =?us-ascii?Q?Dae/SjKnx4GXPOsmN0kJdNSoWvEunT5zDcBi7Br/ya39wo8l4QqzQOU+XaSx?=
 =?us-ascii?Q?+6zOgxjq3SYmgMK8sDT3AQQyk5EIZ4zPPbLmOOMi5Q68lkJ/9A5REvYTX67o?=
 =?us-ascii?Q?egkNi4FSy+ec47uLhkjn7BOJqJ6GWCHONVeNHiZA3up89vKaBPf3VS+n9Sfw?=
 =?us-ascii?Q?FmmPGuSr777o2pESL8Mm8rMBUySa2i3Q0qXBQduc9IodsNZlAsxaOEgS5/Fw?=
 =?us-ascii?Q?SIulzu5moFD6S27IodXXnx31A4a7e86oRfddrqjCrQ58kbNRzEQmb6lUGoUQ?=
 =?us-ascii?Q?nb3vKHZQ543+1yXPEIiFhLEg1UEoZKfw0hndD90kRSM5SCB0qkmnIp5FsODZ?=
 =?us-ascii?Q?perYNP/et0oftiB1t6l1vDSZ8H5VToR0a/3NxunxfBWg7pfQCr9BSk2kz2lv?=
 =?us-ascii?Q?VpCt9LpkvlXkT3crJomTOTUmrHfU781dvN3l+w2vCuvJKVsMgC2Hiws3IN9d?=
 =?us-ascii?Q?rgmkfVt4gK+X0x/z4nQuSoaGjai+3POwAC8BdLLLZTqoJE27ZcDzQwaVr+um?=
 =?us-ascii?Q?8Q6y0lOlmTOnFW00aliA3WobPSjL06hyN9Xecv7ALa57bPNOp/ZSNPVf1I2g?=
 =?us-ascii?Q?EvdWnxFbkFgjwRj6F7J6ADOcLMT0SS33w0XsebCa1hw742s8BBej0ue/JNBZ?=
 =?us-ascii?Q?USKXJLej0+lhFQreMq3EIaKz7vrmR2+aABnI8fILDEdcLPW2VEBEQCMW/nkO?=
 =?us-ascii?Q?/5M4gf8chutKwiavo8lVRIs+w1QALrdQ6KOwd/RUSO6MHwd199LwLoVh8xXg?=
 =?us-ascii?Q?x5ZMo+mpnwDF8wh9CssaF6ONFzwDIq7EvfgpqsPSu+XGLX60K27WtJ7WYD0V?=
 =?us-ascii?Q?3f1+c4bl+IFEnc9hUr0tB07aQFsvDiX4qbUyhSkyBosznd4uyp7EbABJlLyx?=
 =?us-ascii?Q?P5zodyh5QqeBvSJfWnaMDJT1A15Lj5uEIx26wnZr1U+bbz0/UdllYcNG5SP7?=
 =?us-ascii?Q?M9FXFvfoiUvYFd9Ir5DR6KnRgDxzdFzpb3b59m/9eAXDzGR2QEOm0gWOAe81?=
 =?us-ascii?Q?Xr61PgchjuAW0midCelqH4fFjfW6LASbb78HpFvlMN6pOOXiLaglcFt+VSMS?=
 =?us-ascii?Q?eVXDDQnECtzCqAoJz+i3Gf8ptXF0L89bcugFFytskojjV3nVtKrtrLcuJ6/7?=
 =?us-ascii?Q?hL4QpLE7bVbU1BII1zqeZ1dNeYrvEK6f8l8STL4A2UQE/mSNT8CWoLVsjQY2?=
 =?us-ascii?Q?toAMXNfvmg6ItnlgSiBXQ1rwK1EIu6gpvaYmgkiLNL25eo2mQgp9jVtOAjZ1?=
 =?us-ascii?Q?kOi/LK/gA+pqlBfaJu/OhPno+IxCr3wn5G9pPVR7aVrj9yRZQCQe15bGxnVu?=
 =?us-ascii?Q?JeoUJwJDgsaFlEb5oItaL7rFhedFzA2KR+G9lkIEPxsec+oh/Eg2l1QYE4kG?=
 =?us-ascii?Q?V/c9WAltiXyY9HM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:42:18.7871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9d48fa-ba4d-48c4-9813-08dd33e8dcf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

From: Leon Romanovsky <leonro@nvidia.com>

Existing match criteria didn't allow to match whole subnet and
only by specific addresses only. This caused to tunnel mode do not
forward such traffic through relevant SA.

In tunnel mode, policies look like this:
src 192.169.0.0/16 dst 192.169.0.0/16
        dir out priority 383615 ptype main
        tmpl src 192.169.101.2 dst 192.169.101.1
                proto esp spi 0xc5141c18 reqid 1 mode tunnel
        crypto offload parameters: dev eth2 mode packet

Fixes: a5b8ca9471d3 ("net/mlx5e: Add XFRM policy offload logic")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 41 +++++++++++++++----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e51b03d4c717..47df02ef5d69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1150,9 +1150,20 @@ static void tx_ft_put_policy(struct mlx5e_ipsec *ipsec, u32 prio, int type)
 	mutex_unlock(&tx->ft.mutex);
 }
 
+static void addr4_to_mask(__be32 *addr, __be32 *mask)
+{
+	int i;
+
+	*mask = 0;
+	for (i = 0; i < 4; i++)
+		*mask |= ((*addr >> 8 * i) & 0xFF) ? (0xFF << 8 * i) : 0;
+}
+
 static void setup_fte_addr4(struct mlx5_flow_spec *spec, __be32 *saddr,
 			    __be32 *daddr)
 {
+	__be32 mask;
+
 	if (!*saddr && !*daddr)
 		return;
 
@@ -1164,21 +1175,33 @@ static void setup_fte_addr4(struct mlx5_flow_spec *spec, __be32 *saddr,
 	if (*saddr) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4), saddr, 4);
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
-				 outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4);
+		addr4_to_mask(saddr, &mask);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4), &mask, 4);
 	}
 
 	if (*daddr) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4), daddr, 4);
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
-				 outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4);
+		addr4_to_mask(daddr, &mask);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4), &mask, 4);
 	}
 }
 
+static void addr6_to_mask(__be32 *addr, __be32 *mask)
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		addr4_to_mask(&addr[i], &mask[i]);
+}
+
 static void setup_fte_addr6(struct mlx5_flow_spec *spec, __be32 *saddr,
 			    __be32 *daddr)
 {
+	__be32 mask[4];
+
 	if (addr6_all_zero(saddr) && addr6_all_zero(daddr))
 		return;
 
@@ -1190,15 +1213,17 @@ static void setup_fte_addr6(struct mlx5_flow_spec *spec, __be32 *saddr,
 	if (!addr6_all_zero(saddr)) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), saddr, 16);
-		memset(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
-				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), 0xff, 16);
+		addr6_to_mask(saddr, mask);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), mask, 16);
 	}
 
 	if (!addr6_all_zero(daddr)) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), daddr, 16);
-		memset(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
-				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), 0xff, 16);
+		addr6_to_mask(daddr, mask);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), mask, 16);
 	}
 }
 
-- 
2.45.0


