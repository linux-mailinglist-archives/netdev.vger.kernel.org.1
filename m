Return-Path: <netdev+bounces-82278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D9188D0AD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C42E2207
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAEB13DB92;
	Tue, 26 Mar 2024 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ItmmBK1S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00B13DB88
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491685; cv=fail; b=Z0NeFS4EASEUVW81tccUEfW1209wSWWILWSGp82haFHGa2Ls9G78tSZFCwaPw87/tjAFf/oJBbCUAGsrqBJetEnEP9l2NvAuXFf9QEqNwY34EVm7douBp9wu/rT5Bsp1RDsezN+MmCA6gW/HnvM5vZcv9Y8wO2uFbh0+vAgDlGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491685; c=relaxed/simple;
	bh=Ocg0Z9PNChuAMn0ItBqkCDxDcq/NhxuqR3G94vqrBtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snjDJZbYoMJgaGEdEi0sV5em50cXW1gSHjyvnNdcKgO9zwt2QEhzW0+ghcDUYFBgYCqUs0z5fkPAWpRT2rc/ZxOtngFqcP2p4WTylC/mSpaJMCC09tImiCSGKai4njSWDFeJPtmlJ9YCCt2x7QzRtnp7dFckG3DrGDZ/cRCPiL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ItmmBK1S; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/eEHi7sta5undcXFi0sgW0QmdTkkyBf+3WGDBqPrrJoP1Yz7+68KoZvO8BuAtIodAR4F3T6XGbfnCmacfMMlw5cQBO6Iv2fDciHUWIOVAvrTOKlLpK+9ObQsQ/q1ZsYkjikxhmp6Fci5hY9+mL1pPJKaBMwq5HcaEPpvRNcOaMMpiIOYcIwdBjn+JV1c9q88lTZXQqCDRkwbj8R7SkAXLj0CcnmO8yFIOoyDYVQo3VsJwFEFaQA3L0Q6M5VHK4a6Ta07xp0sUmjUgWgW6yI9kioavTTVxpXSE6cdufer19p5hmHXpArtTRM6txkF10XOnzXqUvsYk+jQO2t5TGapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM3pk4/ize6nKtPeGYTqeFVy8r569hMFO0+qvWriXzg=;
 b=VbwtOf6WGv1IIhlvLeTS/2gBw89wvBAfGndyLSJ6iMSSQybB/St3JApWGOnWy4cJa8G1AYzCmeM6oHaZ8SCcDQdKhhMRRaxiZIjJDLcSpqy3fWqndEmm4/A94PGtLQac8Nd2QzHzDPoo6WKeqFCM+d7aU1iA1s+2wyK07CizV5t/fYUqc/09QUkuYICXIvZ0XZTcigWzOjPIq5bOBYBBDtikqgSQWX2bT9Y2iKaMfDrbCYb+DneRDqmI5Ftfthtk7dnP0TSYnFui+tR8+YE2hqYQMwdCMM2H6earUgmoJOg0tG58Jg7T286BSycA54j8vnWAhji9k7ZyCH/R2e8mSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM3pk4/ize6nKtPeGYTqeFVy8r569hMFO0+qvWriXzg=;
 b=ItmmBK1SwErzXtZhTqbf+zeXOkzFS307byGpP+2Mqj+bgbtEfqU7h1q+GW/ji/sHuBztWFZJ6NqX3NDmD46zwMIzoQl7avH8Jz86VPyPSOsAgvR0EW2P6J4uBZBw8joat7yTQEqbChH3LNa1ISvrDEm/CSVIBtnMr9gf/cUcN43WKW0c3Q6ybkfOz98e/ucNn3diNvrxcgc1kQjdApFApl86M4mxvJdwG3+zs7GRMGzj/DYNkHOwKHk3AhNvOqojZGcZLNTuWi4dUwuYefcbXQsf34KyC+g5iaqUsFaVwzL1zrfKVhfb3h9D7AXRNtx63nxvpxsMU9h5JflV9gMT1w==
Received: from CH2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:4e::11)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 22:21:14 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::94) by CH2PR02CA0001.outlook.office365.com
 (2603:10b6:610:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.0 via Frontend Transport; Tue, 26 Mar 2024 22:21:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:20:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 1/8] net/mlx5e: Use ethtool_sprintf/puts() to fill priv flags strings
Date: Wed, 27 Mar 2024 00:20:15 +0200
Message-ID: <20240326222022.27926-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acaad48-f3cb-4e1b-685e-08dc4de30c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zs+d5rs5RbxBxzidTrh/LOc0ErM7zMiwkdUix6gnwcVqPoxl3tENUKLXcpkotO7da9wnOffstFy8LXPNvxYbDjuZxOQsu/MLl2bUwPE8auGV7o0rlY/dtGFIeSC4YK+dPs48vjAkXXBLtg6X++3KTFvXpRkTGrcPMOdNKIW9oRJF/JQqohDXSJlfeOLQAlBUpO1cJP1jzDMo73EF6vQaJ0Bi1bL/vEqZbYP9yPdJIPPP8gbROR0W2XGDR5wewBqbmK18jA+1ZGJ8Xd6DleHymRmlMSFDgqHXRnICMhhS3GZw4Gf9WdDZx+LU+oA1Jtqf5QNf3kuvVlk0zHEYvp1H1CSpdksWFFUzbzv33ZDaO6/O4OSvXDXyLckDfFknCeXPTA6io2CGP6vWPaWDJX1uOytmaBRoCZyQgOWFw+J0CU+kZJXRhnSZUEmLERBRI6lJJNfTEMUri80n3SYycqT7ZxsuhG/dncLdwK5xzkFKSVvLUnTLVE77rM+16GgworgNQoSOIoeclOmG8WHRZoIfVbtJWFaFgL8R1hzvYKbcFkyloJy/rk4lfuIFwFOfVlHmRSaRT804y6SeE7T6NcX3QXEpeuhZ5uXEovMREo4r+EWSCC6uW+mDiSOMAteN9klWdBMFH3n9mG043/gD0EfY7ZOzobLOq3PBGgdOi2IwT/uvdAWiRF40FnuDOgMsYXILaoUgtDB19XtfNCeOlb1Up7uTl7RuN3GjwAQk2Ji40XQrPgyKASdQlQCPNFaJEe96
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:13.4268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acaad48-f3cb-4e1b-685e-08dc4de30c19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

From: Gal Pressman <gal@nvidia.com>

Use ethtool_sprintf/puts() helper functions which handle the common
pattern of printing a string into the ethtool strings interface and
incrementing the string pointer by ETH_GSTRING_LEN.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cc51ce16df14..b58367909e2c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -269,8 +269,7 @@ void mlx5e_ethtool_get_strings(struct mlx5e_priv *priv, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < MLX5E_NUM_PFLAGS; i++)
-			strcpy(data + i * ETH_GSTRING_LEN,
-			       mlx5e_priv_flags[i].name);
+			ethtool_puts(&data, mlx5e_priv_flags[i].name);
 		break;
 
 	case ETH_SS_TEST:
-- 
2.31.1


