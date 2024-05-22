Return-Path: <netdev+bounces-97633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9A8CC731
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C4281AD9
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11817148309;
	Wed, 22 May 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JOIPjosD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED2148314
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406117; cv=fail; b=Pj23G2AhSR+sb3FFxvvYlC/XEbzi5VvlJbl1OBoqx/gfgi/fpEZKohQrOYU4DjPtfAQ9RqWBU5E0btMpsidDQAKaurCwGzoqPRzbYyGhKstPmjeGL//wYELruqG3Y2NwwiDTn49xdne4RPZXk4BpSGBL2dVvUHpAk9RcCjt4+RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406117; c=relaxed/simple;
	bh=X3cymmSwD0vj57+f3G5/VZ+Ob6XtD7q99aba7P6RPIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcQ3v4BSVRVTHCpv4u//O9u3aN4CkNlHPP6eDd7cAvEVGCsH8ROVW7FRdB55vBwJlD6xFKrBPIWF76X2uYlK9f5eORUEL8+LBatqhNlMvHB6AQtUsb/7shBdM1J8bFuwHhG6LyiXCAOQH39bCgu1Teeo1+HHuweSBrOJ3WfjH9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JOIPjosD; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ/dR6FHhrFil7WDH+MDNa/VCI7BVrvGKSAEIJyQWVo3W0IasI3lzltWrCoQMEIIsQl21eUEsVc7RUOuhd6/2NBcUWIqQep8kF6rq1D0nI5nLl4rVC5m1RElNKngiXvBlo94eMBTB7KT5jGlL2ScM8b8CKBDJjHMWC3EuQLZeCbv9W3hW2eB5KgqGMbquym6sf8geP7P6WEkDr6SlbFTGmf3y0gl5SFk0u3ozjt72hY25E2slK/jr2M/FgMEh/SL9N0GE7L/GeyHI9Iam+uiyxS1iJHzCJmxrhYunHX7PLlGpaBVVkTLyF42wGcW0agW0ma7Z5hllF71L7yFAh/WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxiVyl6Vpk+UYuzI0XlP0gq3R3Hzq5EysNVtawihEzc=;
 b=UU0nqqE6rv1rUAHmDlz/iq99yFYYrBe87rKRNaQVv8gL2a/VgLq88k+nahWFHyxiBszldvR5yxaSh7rFQuTeLd6rKpFPRaYMWbeNULW5ZFFNYzeGHw5ArLo31R9L2qtdLRGdwHooKWw2TPeDk7PWusaHS30C0gR5bYCDeUP7CHZL0anvOAqhCWkgZ+kQNWaaTb4TnEEHigPRiM8uPNq8uKmofigUj61OTqnKGwS8dPKn+ETrS3xoVXACChuyd6+Vo7N+LBln6CAlOfflvhUQrVLf6wYOgbHSozgDWe+jFC5TmRxyGRbW/K6QEjbvn7/b4MVn+l3kKbEJSpUbLLBedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxiVyl6Vpk+UYuzI0XlP0gq3R3Hzq5EysNVtawihEzc=;
 b=JOIPjosDp+SohCsL6pn11Slb1WYMe/AyGVSRwJiD3rO1cWdq8ToFRRzyYq8fz1ntpklZZaSWNnFvUXdoENqBs1NPS5A6umrWK9WTwLFusZyoSInrHrCEH3q59d+9n9f4+PpCRqNN0sV6TNWCpStSQKP2hkMrPD3l8tOSGUTwdBJSLjSdy17rWava6anbOlRonPOP2wZXV/e1Y7NOZbePm2OzEpa4WkkAt0TA+7UFslmEQK5cxZPZeLclwooZZEAR8vZYj8sURshB4HSItbmcLPv9KB2XMOzv+PEanAOVeYkWrTa6RczItGOW1uLiQtsv5VW0eKAGkMIsg7+td8wjqA==
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Wed, 22 May
 2024 19:28:32 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::3c) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Wed, 22 May 2024 19:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:28:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jason Baron
	<jbaron@akamai.com>, Dragos Tatulea <dtatulea@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 8/8] net/mlx5e: Fix UDP GSO for encapsulated packets
Date: Wed, 22 May 2024 22:26:59 +0300
Message-ID: <20240522192659.840796-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: d509382a-d119-4c69-11e3-08dc7a955dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7XZ4fDj0At5fpNj5l0MF6BfGeAov13m+3tQgSDQr2rAVEbmTb59tOn7LiMrH?=
 =?us-ascii?Q?jLMleu1AZTy/1Mg6GKRn3FsqtUlu9Wp4FcjVddqpAjrbiv9j3z9fDwsVTvX7?=
 =?us-ascii?Q?bZpoApAZDxQpROYOPtgdl7D1EJSHzYZcexZWdDZQjZXLTzpMsxgviHBu+OKQ?=
 =?us-ascii?Q?THI6Y5hw2vE48FJ3/o7vKj5aTLZzgI8tH1Y5VZjpZQM6hfA8t4wdsrELQHot?=
 =?us-ascii?Q?arRdlIvbvY9ZpyxsL5Qd3wmnT1jV0CzuF36uRStRcUw3pjywkLiUVS/yeDdg?=
 =?us-ascii?Q?j4g2xssN8by8cBdVNMYp3xl9R62TUKosc33oFq3r1uiiCpCxE6uRFumHBf5K?=
 =?us-ascii?Q?oxy48+rVk4S/PDBDBqbdpXaO+k2vZWXZDsWqQOKL27/JWmppTOUkobYebKJp?=
 =?us-ascii?Q?PW+SZ3vcKHV7qI7gB92rj4XvWcC9QPAu8KVeNQFqsEktUl0Z16RY/jtF2/iV?=
 =?us-ascii?Q?dE7t0QN8imGyRQQHkQROJ/wFIsbxmUy6KI/4AvFYG6ZfOdARJwaxQo2eE9Ig?=
 =?us-ascii?Q?U8mmu7ZI0DsGoYY2uTzA82g7oTpp977dfBbe9bR01VNEfk6HXVad+gHvMcPV?=
 =?us-ascii?Q?kmGybsu/pcknSY8Pg6pVadkdhgDiTKmB/mJ4PNAwijK+jIaUITbgFXhuIIoP?=
 =?us-ascii?Q?X5ZjXKOuaJnnxdyK3SXfOu0BiaHdc/AKNuXLyZMVxA4lSH6TVW+AyZojs4X1?=
 =?us-ascii?Q?dFCeKFJ++6NQWj21h3oUIYtXifnUjoC6YdYBtl4CRyLkfmFiJ31QkdSdNx3u?=
 =?us-ascii?Q?f+XjAGhEAP+1ZoVU7saBy4RsypftkgYrDZDN46rsvh6mr0igd/qKZfEzRRlN?=
 =?us-ascii?Q?p6zlyRJIgFjhPMUX1stjiIPIEBap3tTCFgN6hfvULtHL6cIS2V3/Ug9qncC0?=
 =?us-ascii?Q?t9OE3xScPiH78FYobL2VORxv91cu2+liEkUSq8p0LMTdFh2SAs6N7TRVQAcN?=
 =?us-ascii?Q?GpjvAsi47qhmJvNhNh3/4HXp3Zfw/nJteLzsc+R8rPfqr77NXfWbyNVzeYNL?=
 =?us-ascii?Q?G7KcB3+v/ljlWxca+he6qZLw/5SodP1uvhGsM1iQPIHzRqe7/jOnfL1kb0np?=
 =?us-ascii?Q?sMX+jGV6QujEoDQEpCGocsj3HsxVfKAeejKFOzmT6n3HnnEU+4j9bPU4qNwS?=
 =?us-ascii?Q?mpdXvwgznHiJBeWRnp7vgLprAe78sMxRxP7lD7I3xtE6e8Eq6AaHOZ0spWO+?=
 =?us-ascii?Q?a8+9i3ImRsq3ld+hOgiAWSynwBhZ/+eTlZe3qMo6G9f9JH554WcUjCKyGomc?=
 =?us-ascii?Q?zYehZZ5KvGtGomzlccyqSNSaMNxYUn2aoCyiGiGwwoI3QBsC0HKRGBM//Me2?=
 =?us-ascii?Q?g7AVLLf6qjswPhgEmWDlACKXdZB8xnGTE00qQ6GuocDBNg6uy61SkdjtdZyM?=
 =?us-ascii?Q?wf/4B0niO493gj2ONiMaTsl6rO6M?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:32.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d509382a-d119-4c69-11e3-08dc7a955dcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406

From: Gal Pressman <gal@nvidia.com>

When the skb is encapsulated, adjust the inner UDP header instead of the
outer one, and account for UDP header (instead of TCP) in the inline
header size calculation.

Fixes: 689adf0d4892 ("net/mlx5e: Add UDP GSO support")
Reported-by: Jason Baron <jbaron@akamai.com>
Closes: https://lore.kernel.org/netdev/c42961cb-50b9-4a9a-bd43-87fe48d88d29@akamai.com/
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h   | 8 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c           | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index caa34b9c161e..33e32584b07f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -102,8 +102,14 @@ static inline void
 mlx5e_udp_gso_handle_tx_skb(struct sk_buff *skb)
 {
 	int payload_len = skb_shinfo(skb)->gso_size + sizeof(struct udphdr);
+	struct udphdr *udphdr;
 
-	udp_hdr(skb)->len = htons(payload_len);
+	if (skb->encapsulation)
+		udphdr = (struct udphdr *)skb_inner_transport_header(skb);
+	else
+		udphdr = udp_hdr(skb);
+
+	udphdr->len = htons(payload_len);
 }
 
 struct mlx5e_accel_tx_state {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 099bf1078889..b09e9abd39f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -153,7 +153,11 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb, int *hopbyhop)
 
 	*hopbyhop = 0;
 	if (skb->encapsulation) {
-		ihs = skb_inner_tcp_all_headers(skb);
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+			ihs = skb_inner_transport_offset(skb) +
+			      sizeof(struct udphdr);
+		else
+			ihs = skb_inner_tcp_all_headers(skb);
 		stats->tso_inner_packets++;
 		stats->tso_inner_bytes += skb->len - ihs;
 	} else {
-- 
2.44.0


