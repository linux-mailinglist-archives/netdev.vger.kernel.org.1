Return-Path: <netdev+bounces-103398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4349E907DC8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B683C1F22420
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7A1494B4;
	Thu, 13 Jun 2024 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rfoSHJoC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AF145A11
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312547; cv=fail; b=HT5kgrXTS+98AIMK3DQ/mepMbrrzJMgQhQAyP1v+0CH2oNtw7HEDkck2vIGoIqLM5XjzD6iP5M8VvvxAZ0l6xxFVhdzKKCu56LZYqMiafsAga4054hjq90krfxozH8OZ5C48Lbi/RpvALKDtJotYaxOpXMRttfIWpUiUf1jnSyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312547; c=relaxed/simple;
	bh=/ZclC6i8TPl4r+FrvwYS4x6caDf0wcKIE3io0NZQW1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lm4RkmjGyg4fikEzJshgFLmrL+hBLaXF46WackQhtTkjd1qWMRDBeVw7KGi4zs6C/WvcPEDXnEz+1cNaLzWj3RjT6qXTBpw/uNn6lG0kdFvHRHqcZ3jSwRwxYS412S0K77zhslz5hYg4zJi54zBmG6CjYgEz25Ojq60rk6JljFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rfoSHJoC; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWy6yqN6oJ2Fp7Txmhz8znoWmyIHpYjqG7vNz91oKx1iOBXJGOcqBbFg1Q4eApRuYJCrtUNtoYuUnydIlw3PikmPp4zLhz3Fr1/7FZckLjvH/Egk+QUqTSBxFQmAVC8hYKRcJIZwoFRInHpm7+Zp8301JXww4qWK5CHKiLt6CWgra94Nl+/ohJBnJa79pjT5XxpweKNDGgkMKXz4fyqcFKL5W4NgVEeCVTmxYplcrlxllE7ifZ745rX3gnWOPIyPktIiPJiyFeNYp3I9yYFKBEvuxVIgfaLC/72lYBFLttFb3Fj1CbyUYgAReT5DLMoiALba2pAyhuPFpkDBL+4xgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEvZUV0o5pTEmb2jjo32VU2hBFSXeVvvRlACit5PUtM=;
 b=oFwAcWeEzjNfIy18wFwpEJLnP5kVNsQFn4KKpQ+OIfy54od54sIG2MnW3TXWcL+8bmzH+lRmGKSEW6JcjH/ugs2vcs4x38hCakujvxtS9afQLW7MciqY7Ce5/oLjcLrs+1mLz2dbYxBW0Ym5rwWEF7M2gLVObWkUrfCzRNn7NOyelJi9M3mNPJmpWCPVg7HTjT5NFjTOJPuNi2fZaTTvBiI9nBLYQN2kzRMz9lj4IFLHwOIN4dQ61WnYTtD2+3WTby2y3kEcgNF15KyEnluVhuPhcKyYzfBxyAeDbhQqnPURLs/4F9fOvMieGxtke90CAMY60vxUnNECH2JvxQ9lOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEvZUV0o5pTEmb2jjo32VU2hBFSXeVvvRlACit5PUtM=;
 b=rfoSHJoCVqa/pW3/HSjt7ZGDvVfs2G27PVM8vR90MiokSJyv/4zmXWYUn/f9v1Hw5zmGi1kyKN0ubgAPrtiEAGAIlGRTv4Wo87Hxes+b0C7cNyncfGSE+hDOm8ojisTUR2kyQTG4LYUCDHKM/F8zoJXeE6nXoQGZhUYEARtr3Tvh+ahbyDE8F7zbCcAgOqaflEdG6TY9kae0z8anBzLPLMg19eUTKJhTnPPLW1IqjkFYnJr6XUN3askZ7BqTrykuq7D14MSyAgXaHIOlHfeWLpNm7IGcd2L7Vg1PxeNaFAtj8MsnVeUZPvT4r0NFAIkEze19yuK9TVQJwLn4rffuCw==
Received: from MN2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:208:239::31)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 21:02:22 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::1b) by MN2PR08CA0026.outlook.office365.com
 (2603:10b6:208:239::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 21:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:02:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:02:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:02:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 13 Jun
 2024 14:01:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 5/6] net/mlx5e: Use tcp_v[46]_check checksum helpers
Date: Fri, 14 Jun 2024 00:00:35 +0300
Message-ID: <20240613210036.1125203-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f446b3-d12e-4a92-af42-08dc8bec1e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|82310400021|1800799019|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ojpcpJI4qy3cdpcalBOy7sTCgb6vyhHmylJcvwqpBExbKyjqM32bWDA4kIsa?=
 =?us-ascii?Q?fOWBzrezgnotejiPH8aSg6AOtp8JQ07wj1Ux/7rUnxPHTMIdPDCEbbS2pdnw?=
 =?us-ascii?Q?puuFWp1zrc6vOSiKfPbGeJakpQSZELgGbIIgxSS+l1Mb1leENSO9SZj9n0Pu?=
 =?us-ascii?Q?sEJpkHMJ6ojmXeudHIvpMB/5ckR8FlY18O0IbC0XmkzU2QMNDpd553E/tpPn?=
 =?us-ascii?Q?8qtxebvh/Na5X6HRJI65E6HSS0Ra4eHTqKGhXq0+egswdgtbG5U8Lq3Synjx?=
 =?us-ascii?Q?1DPKhrN4qqXUyEjbOveHsnZpEuHV1CBWBpxFZM8xRXwofYCA8KMwYlL0cWCj?=
 =?us-ascii?Q?9AGGxgieEwAtqBSjcrdZqn2m5zfZa545KXwguhgw2CTfk52vM2BVQzYLdn8N?=
 =?us-ascii?Q?zvNfp7q4jxyDfixBwnMZ85U8qK9dJccMw3DROCVElWKycBSixw9HDuOJfq1y?=
 =?us-ascii?Q?liG4Xn9C8cPOYqtR95J8sG3Le6A/P1RqLeQh+SbJBJCyek9htcVhyhVNZ4h2?=
 =?us-ascii?Q?OLc0ljTF5Uhd3WW8eQKKpGphWOwHvZcIAHRYhKuKIi7zAnI7YLjeodVPMPZh?=
 =?us-ascii?Q?ndlsozM7NKuk37agu/Im8pivALc01LsFCdfYrvSO6PvXOc4Siq2pOSSc854I?=
 =?us-ascii?Q?5lqwJZudgKV/vE5blKi+qnLcw079kG3p071t40v6UeC55Eb8xdsn/ouXIQ8S?=
 =?us-ascii?Q?jwKKmlHtQVrjVRSXeEDMjoJKoPBCCxVllZNlakiwOs/h1Vzn2DD6nswLsNJ8?=
 =?us-ascii?Q?iaEs1CSK/mwNxZl+BPjX/AoxS5kBXV+zD9ahdDVvhx0rEJnskHq3NUS8FltZ?=
 =?us-ascii?Q?2W8Vu23LFPBiwPg79PJhx1fNrnumWSUP2fkwYOJl8kteGCy9NEhwmknIE8UT?=
 =?us-ascii?Q?O6vJmJRih6TYUb1jrlhWZ6bF4BkOHnCES/Pjf+zzPQD8dj83/YIxmZuJ8Teb?=
 =?us-ascii?Q?/JX3stCwnC5ec68OeaItRzUMUFvqhhvHGnpXUFKP1+PdIpwAYk+n7CUfYCO0?=
 =?us-ascii?Q?OYYZVxdFXM/MO+4ikwwfDB5qIrz7EB913KmbeoZsT93fA3WErDwZQMeSeCN0?=
 =?us-ascii?Q?WAfaS6HCc6yFtaDoazHHxsNvQAXLJigK7XEwWgkL1QDXFSLENwKj2PcMjVwx?=
 =?us-ascii?Q?gPtBeiU0JRujYH+YvMFP7c9n3aZt+hl0T60jP7jYsIfTFtpp2Lv9jUCMrjNK?=
 =?us-ascii?Q?vy0BJauWXp9dJjgcbt98kIzGpuKFbGaUlc88JfOhZX5hOsUHEEHlcZGDMWr9?=
 =?us-ascii?Q?UqLaBv08/zkzFaZS9H16OvUHOUuBBYiBiHoR5YMOGwe9X+6XLj4EvswKdyLX?=
 =?us-ascii?Q?dxdEwg56oBjG6ny6MS3KOBPu1Xj95zQc1H98oesji9FOxyfg3KNHWFz77qRm?=
 =?us-ascii?Q?JAK3AvU08UXqnc8DWi04KPYUfn448WQTXfJAJCi/tEXUmgxdGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(82310400021)(1800799019)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:02:21.8094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f446b3-d12e-4a92-af42-08dc8bec1e81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157

From: Gal Pressman <gal@nvidia.com>

Use the tcp specific helpers to calculate the tcp pseudo header checksum
instead of the csum_*_magic ones.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 43f018567faf..225da8d691fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1182,9 +1182,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 		check = csum_partial(tcp, tcp->doff * 4,
 				     csum_unfold((__force __sum16)cqe->check_sum));
 		/* Almost done, don't forget the pseudo header */
-		tcp->check = csum_tcpudp_magic(ipv4->saddr, ipv4->daddr,
-					       tot_len - sizeof(struct iphdr),
-					       IPPROTO_TCP, check);
+		tcp->check = tcp_v4_check(tot_len - sizeof(struct iphdr),
+					  ipv4->saddr, ipv4->daddr, check);
 	} else {
 		u16 payload_len = tot_len - sizeof(struct ipv6hdr);
 		struct ipv6hdr *ipv6 = ip_p;
@@ -1199,8 +1198,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 		check = csum_partial(tcp, tcp->doff * 4,
 				     csum_unfold((__force __sum16)cqe->check_sum));
 		/* Almost done, don't forget the pseudo header */
-		tcp->check = csum_ipv6_magic(&ipv6->saddr, &ipv6->daddr, payload_len,
-					     IPPROTO_TCP, check);
+		tcp->check = tcp_v6_check(payload_len, &ipv6->saddr,
+					  &ipv6->daddr, check);
 	}
 }
 
-- 
2.44.0


