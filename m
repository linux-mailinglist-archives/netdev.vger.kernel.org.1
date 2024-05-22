Return-Path: <netdev+bounces-97629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D58CC72D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED05D1F2119A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BFA147C98;
	Wed, 22 May 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UPaCjGSg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511771474A8
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406105; cv=fail; b=loYi5b3MtXZ2e5wK/Bj6JCHJRrrdzkVIOSywt2ZWiIre4tHSOxArjJz0RfElSyEfmutYckn8EuxSgTnfDhIAr8CVm8WmBq2r9Uaf8Pg05pszXzgl51rbrIygOCCz4NW2mm7zx0qDcHsIo40GNsKDcnic8hCBTEcCDYZBv8BeCJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406105; c=relaxed/simple;
	bh=KxPlP92RUHqyOegZOkOqgKmhM0QlRDaAWA5cVwVqbxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bD4Dj4X+oiQkAoxBcxk+RT4l5LgLo99xhPb3GQDR1Nsz8TxcQUaqUysvUE8XEobbUIbfAkP2Ch5FBak0Kg9tcH65VgvQiOsyFTlHd4Y9nbG8vBNWI0CSxdPfKVp3z2ywiaT0WdHNgV6DrbQI54w8/SVXSaZ4vya/9Sm6GPzoaag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UPaCjGSg; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHEux+SuYzOwKrLQdAC4WaZlZ7lGr8xZjWgCGxPGSeRNE5sGm2QwxODgC9E564/gVUiMaL+xekqbAwM97QNp1WUyU3wty791eZjlWVEeeWDJPfFH8bkZ+iFCgvIeaE8Kl6Rskb1YyMKPIy/Z6LsV3L6mo07QlZ/uOy82/4vOGzgySU+cBjq5kK+2noxvFIv0sDsVv37n49wLpcdetGhnsQFBbHNR2ESYSmvhqNm6cH0T5UeiwEAw2gGnDM4RdtvijF90KIrNhvfKu8HXS4+hJFTQ3f8VdvxJtUDRzhu/iH72Sm8K4BiFz7+mjbWmLS27omAZNctPKtbk6gzjWq6wPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzfX7Ji4pB1rrb2Cn4Z41xQyzDNX+0UkaVyD0L8kJcI=;
 b=l9BdqX3DskwvsmT3EYOrXiFV5OiaqD5XNuCUswUclmr+1WPA3fHKTxftwQQg7d4HQVmlGf3d7eHU58tCkr0+lLERtDokvkVjj+/ArIiPDjn8GtTXvsxRYBKn8vRCLZ2P2w9/qFsUAU8IUpnr7zAeOooyrgZrmepxBlhkR/flnwEH9x/pt8ddsuwnrr6AHmD//HCD05DWJnqcc0FjwUjVVAa+n05SOHRzomU459xcb5uVexYa4bPMZ2qpE+22XZ708LHzN6phHc2eSzw0jCufRoEX4qptvy6HHNqYDRHE90i7d9JMGN6d3veTt9Foof11pjJtwfuX0PxxoUbZPGMETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzfX7Ji4pB1rrb2Cn4Z41xQyzDNX+0UkaVyD0L8kJcI=;
 b=UPaCjGSgTuKfYgpB77gp3bxTAtLToKkXSfDe+RTRXwVCqftaeRf0/ki16gUJDTc5xFbRRWajt++9Yun5A4RsnUGWJorLmJfJ3yV8PO0qrPl8Il1yvbxX40PdPTLoIFU0GYCmKPTH2gJVY5Xw/9u4C5xjq7MvGW+0mLy2OKWa6bFUozEQVoS4i8tY+9nFiaFDKQ6wW6KMkzsr9druzOd0tVczE6Ly8ujj4hY31I9uebzjs12sbsl2wz7YYvB9PBAnf1ox1X2+lPJwHUKXXzGSL0lYNZYs/OUYNJp/k+4WVVCULRgcvkdg3UJWJIvdWCWtN7MuOejXo/2fAvO7yG17Mg==
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:28:19 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::3f) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Wed, 22 May 2024 19:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:27:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 4/8] net/mlx5: Use mlx5_ipsec_rx_status_destroy to correctly delete status rules
Date: Wed, 22 May 2024 22:26:55 +0300
Message-ID: <20240522192659.840796-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
References: <20240522192659.840796-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ec9fd8-d136-4c3f-c5cf-08dc7a955656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?birNZFjy/93Dc3++jBFXjX2jIuPejIBwlsX0JMOo+xpY0Nz98vq9p8y6A3Bu?=
 =?us-ascii?Q?MYiYJiCMMz3XsMmFucD6B6kq/E7YI0DtrpNiKlW5QQCZwq1tyM8xg6CijUzV?=
 =?us-ascii?Q?OtXvQUkU6aDzyFvHlMLtMJDqG+Os+5ciHULBB5+SEP0s6ZObAKclTzpgjjh6?=
 =?us-ascii?Q?9at1Pm56nalCrX2N4BUB37hVf4soRMj3cVItxM+fDX/A4P2t7/l4V3GAmJbC?=
 =?us-ascii?Q?rEgiw6wEAB4THONvD3mkntkebOxlptRozc6W7aITv5929Uvy/3VAcSFwUbmy?=
 =?us-ascii?Q?WGdI217cD3eENJzyDj14nHycQCrj5K770lDGblGVWYY425+7BAk0LpcFwdR6?=
 =?us-ascii?Q?Lu+6Vf8inSxAmHyMuU0sSho2PdGvGzi3NMU25st0lOCiJo5GXWQj6cHppP0F?=
 =?us-ascii?Q?9YJAcrMqb94kkrup6rseDhVgVnFiKJpaVpHrJUBrV0LmDG7eA3PZAHniLAeH?=
 =?us-ascii?Q?ek8loUl9rfpN7arHWFxogKr9c+fcEgn0sZcny4C6AtuSI3bPakBWInEUFBk3?=
 =?us-ascii?Q?CtxfJpl4jCTvrmzkhn4VIJDbzrbEB6TBL+zCyLGan4ykCmJ/MUl+waSr+xxx?=
 =?us-ascii?Q?t354RQHk7ypgzcDcoWhTSANXf+WbTh8PGiXFT4/RPgPtg718VIXnIePv00O9?=
 =?us-ascii?Q?iovkdA24o56PpLzHBesPJ+fieCg3p7T+0OTGXYA+hKGVD6sYG4/yQdSq3/XB?=
 =?us-ascii?Q?1rQI+6nT842M8NAywq/bl02p5hhA5PriqjCsiFHHsoDzVYGrgsLlJB36Zr/E?=
 =?us-ascii?Q?y/P8hIxLW3zn40hLDcHXirYp+fxyHMo+lufOMdN6MszjogYzDNcaSxv/z3P0?=
 =?us-ascii?Q?SormsTt1JP3BRMNy5nNGPTrn8QXOXwp+bHTptqiNtpCqpRIbMAOePZy6f/p8?=
 =?us-ascii?Q?CA+nMndatgIgnikJO9ZwJITL0UUhBE2/2lEl+Ed3IBVF05fTAxtm/RdbW/K+?=
 =?us-ascii?Q?hhj3ZvfdKSx9llyCK9QriDQJCc49GWpnKSAqkQpqD6jDxoPRKZZhdryO0QIu?=
 =?us-ascii?Q?7jMcK/6WE0mm8AChzx0LcawCd9RLxLy+s7Egc409Dj93+4Eqg/V2IkHNvmM8?=
 =?us-ascii?Q?dpKArmV533mDq/3qI+9hYKtazoehpr6MszdvbfsDYpy3iMVAr7n3HWphl9qq?=
 =?us-ascii?Q?A/nTwd/OnHrOoGlSnSVt88J9Loo79A3oUxe2H8tDYZrRFv2pdknWGoL38Ykx?=
 =?us-ascii?Q?EBTPVD8+D0FTH1ECL59GHh0JTWQZ60n8vF8ljekf7sAo8VQ5+cDFE+kGSxAo?=
 =?us-ascii?Q?oPO7E5vVbVxfwvMTRHYmQNpDETG18u9Ppx9tjmxmnTIs+URrFKO+S59zx6N6?=
 =?us-ascii?Q?FqJGcMnmlhJr+DPpwZeYm6+LpGZUYsll9e1VPQLeTRYuoeqBMqMoxqx3aakI?=
 =?us-ascii?Q?DOWcSTrNQjJv2A6aFibfk5zKvg8r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:19.4979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ec9fd8-d136-4c3f-c5cf-08dc7a955656
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

rx_create no longer allocates a modify_hdr instance that needs to be
cleaned up. The mlx5_modify_header_dealloc call will lead to a NULL pointer
dereference. A leak in the rules also previously occurred since there are
now two rules populated related to status.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 109907067 P4D 109907067 PUD 116890067 PMD 0
  Oops: 0000 [#1] SMP
  CPU: 1 PID: 484 Comm: ip Not tainted 6.9.0-rc2-rrameshbabu+ #254
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/2014
  RIP: 0010:mlx5_modify_header_dealloc+0xd/0x70
  <snip>
  Call Trace:
   <TASK>
   ? show_regs+0x60/0x70
   ? __die+0x24/0x70
   ? page_fault_oops+0x15f/0x430
   ? free_to_partial_list.constprop.0+0x79/0x150
   ? do_user_addr_fault+0x2c9/0x5c0
   ? exc_page_fault+0x63/0x110
   ? asm_exc_page_fault+0x27/0x30
   ? mlx5_modify_header_dealloc+0xd/0x70
   rx_create+0x374/0x590
   rx_add_rule+0x3ad/0x500
   ? rx_add_rule+0x3ad/0x500
   ? mlx5_cmd_exec+0x2c/0x40
   ? mlx5_create_ipsec_obj+0xd6/0x200
   mlx5e_accel_ipsec_fs_add_rule+0x31/0xf0
   mlx5e_xfrm_add_state+0x426/0xc00
  <snip>

Fixes: 94af50c0a9bb ("net/mlx5e: Unify esw and normal IPsec status table creation/destruction")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 41a2543a52cd..e51b03d4c717 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -750,8 +750,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 err_fs_ft:
 	if (rx->allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(mdev);
-	mlx5_del_flow_rules(rx->status.rule);
-	mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
+	mlx5_ipsec_rx_status_destroy(ipsec, rx);
 err_add:
 	mlx5_destroy_flow_table(rx->ft.status);
 err_fs_ft_status:
-- 
2.44.0


