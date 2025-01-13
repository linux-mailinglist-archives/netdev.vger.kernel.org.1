Return-Path: <netdev+bounces-157796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9DBA0BC46
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453F4188561C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786741FBBFA;
	Mon, 13 Jan 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XhI6EgKX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62A1C5D6A
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782945; cv=fail; b=UC4N6c815hIhXAnLuSIwFLr+Bq0pOHNfvnAsc76de31Iz1Hv7xt8L6fXavhzqRAzEo06goVJJJA4Mxi6IJy47jACLrilM2BUir20SAJr6NqhWc+9A3zd37LLdzGmjPgy4GpqB0a7pkrmZMY7+oNu0snH3MkoB7O/u5TKG73epHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782945; c=relaxed/simple;
	bh=Je32aEfhq5MwRpc0INa1ubjj5aMKIkIc9tjxi9yaVgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOoHjnbI+ADu2Q3I2DJoM3D3S+yRB5Fdixp1U7UZxpb/vdSA6PcQi23baSWWGdbWksB3JahfAZIKjSkuz/lQ4c/GujLLoe8bse4SiO9whRJZb4h0iN1MQjOnKp9TCYySoyHEDq/0kusPE+ZuH886916J3134bEOCHRNmRX7xykE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XhI6EgKX; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn1v/d1OliwqVOMZoHLpx5oO1b8PUXKgFCfGsOHhJxQJGM1CMicJ3spKpC4Sr7+BtadxfHace35sako4UT+0fk+DCsNf4ZT95d4T1pXBAwvYFb0Z2n6J4VDFhb4eI/Arhg/dQvNZv1040I3llgAQyZ0lLz4SYdf0C7OWQARUwV03D0A1h8Vcyz2Rj0bsGvbl7ahywoc/B5nA64Q5Zyinpe0ME6Rz4yXJoGdZv0Plz12rNfo21Uz/3lRhVZRzPor+AKnVQU68vec1dsVzgu0URTKNsDedY2aQfAy3DcwP2tOr1CrBgNbrzn2nikhwD/F2JVlVFDMBd+NTGEyP/eudng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4v85Pkqu7kuP+kPIIArL35uy7uQdRo7MvI3CDkvr+s=;
 b=MnhUaApZer4bGnk7CQcKjbhIKwaE3EeXOfQXPZR5gj5J6BqiXojzDoGuKWyNr1C3Pd9aKO2KUL8A3uusqI1m8nZrr0Am7fqqUUW0vRBVd/AeNBQqbNnlb5lqqdyynYWogiBaLpthjAdfYDT99qq5KEnQL13D6SsOs/SBW18XCvl5DukgJV053EqhqSPOrqtg0Z0sbN72Vkje/dKS7NV/tecVMN8O222eEAse6Ge9CzGQI0KC4Y/xSO1DGDySfCBLPyHSbJYVSbyerZhWM72jPxlQqcw9wPjLjrP9ZMldKHDeOkOFqG4PcqRIWR2+4xipfBJhanw8NHgn40lHZ3ohhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4v85Pkqu7kuP+kPIIArL35uy7uQdRo7MvI3CDkvr+s=;
 b=XhI6EgKXVf259ZgaY6VE0CHLcfU1EEPuW6rKQ9aQ39U23IvMarGjcbn+cs7bT9T8K+30xKcSh/yt9WgDoqfjfCKVDMusvF7EVMyalAhqSxHW2PS234EZiPVxSxS7Av/PSRwDJMbUTSDydZwZ5BVYbU7nzSSxuxeA6BYTnrtd8Esrag4TTh1UMX919HKQR1TsW1YJSD+kamoS3/tXIuGlX9xH4QBf7I1+3krwIUj1gxabxjVn+Nt0//1e+X0TvSVmgSX+PcOcJwNb3KYSjsRBmLKNxHpnd5xoSqE2KPOsH69SSvB9WRuRJu4+np9iBaP+1WLI3H7B1CcZmzK+bB9BKA==
Received: from SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21) by
 PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:42:20 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::94) by SN6PR01CA0008.outlook.office365.com
 (2603:10b6:805:b6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:42:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:42:07 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:42:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:42:04 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 7/8] net/mlx5e: Rely on reqid in IPsec tunnel mode
Date: Mon, 13 Jan 2025 17:40:53 +0200
Message-ID: <20250113154055.1927008-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: f91774f3-ea7e-4873-49f9-08dd33e8dddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NTxKCM7v4CisDu2dYL7ybI9jZCAqfPOzl8DUE+W14tGLeIxNMF0AoHFsuYay?=
 =?us-ascii?Q?S1iIc3KS7Zg8NyFD4NgDqcU/1edE0yYpYLAKdyqmoQXNTPCoeI0fqv9oKGvG?=
 =?us-ascii?Q?tSrVjYQ4HIs+GYO5K3FAtwkEW9WyCf9X9p8YpZRh31WgNFPSG938DsE5Tg+c?=
 =?us-ascii?Q?LuPLafaah5m7Zllj1QDNiFMyONmchxdzPxho4bF/fUHo7u9wA8MLuEK7FGGf?=
 =?us-ascii?Q?Sdddvmev8KWPm7cyO+C2NqNkuZKPv5unr0oRcQjfQbqqwTvlTDonTEk0K16u?=
 =?us-ascii?Q?t1CLaWrQ+L1gGvvbWkqFSHRZZffSc8HKq7u+K/NOgbrmL3MwBdt7eaNTdcmv?=
 =?us-ascii?Q?Yx3OLS7EnxZCoeIvM0UQthXWwHKSx1IP0O6C7sPJ58ehBFxC0tB7PU7Nj7fu?=
 =?us-ascii?Q?H+h1RL/UXmZaUmU9SPqP5t2ahnd6HrdXI9P1OPKHhjd9N0m4J3OxxRDpDat4?=
 =?us-ascii?Q?45nL+WAx8U9o2M89dZKMhYeNp4r4os3bHl5JIx0/gY/V5LyajSRq7mqmWX0m?=
 =?us-ascii?Q?siHIK2EILIO8qdgr1yYBjqfO/v3I9lLh2rUKBx4Cv1r85smSElMqZy5+UvmN?=
 =?us-ascii?Q?hRsHqnaKbdoRMAyVuQQY4pN+7dKcJsXWRt3+rPX7A+t2ROLny6Zb3gh0EYnU?=
 =?us-ascii?Q?9AEmMSbab4KOYTN8VSBZkDNFM691jBMToSpbfOo9CBl8bvpRW8Wy30GeCWja?=
 =?us-ascii?Q?nSMtqV3p+40cMzMed8KJ8atFdiYtWt2MI8L9leitWbzq41ZpnZMkyqYmt155?=
 =?us-ascii?Q?hZxMXj66nztmOkoA0wqwXHn1x/bngUcbLRI/tRbxcM5/Zo+AKdY5Q/aq54nk?=
 =?us-ascii?Q?fB1kj09Alzp3BBYJkCY+dpX7XxYZDafTP2BW2iC0kB0Wsay2klm7uGfuMiZk?=
 =?us-ascii?Q?E3C/mYlRiVUmyDGmWiF2M2v9op0b79JGWkuNAndgTDbt7DKBTs2SolgP0aZe?=
 =?us-ascii?Q?Kv6aD9PT5WnGUsocFTLYBXGmCq+NEMQ/HuBHaSG11zh9e8DQxpLO330slsD1?=
 =?us-ascii?Q?g8JfXQoz3reZhMCvzeQoiIiJZiHtxRBKeRhS7wWIA2bUp+4YWJfLAt2PRNE/?=
 =?us-ascii?Q?lQ0ZgBocfNwh/hieQ4ArB0frcjr0luU4++mv7G/l+z/3iuRyiPvV+N+kepg8?=
 =?us-ascii?Q?qT3GzvbW2f3fl0ijDSwfmJ77YE6QDnHT+SMpO1RcpQMS//sKhYBtWTRIuRew?=
 =?us-ascii?Q?54ru9xDHIHt+YjVzbPK0Wd0/VTNPqGHXlSeu2FIqmZ4AtGgAjC6l5NEUHEMI?=
 =?us-ascii?Q?V8Gy9Rekl5dIQ6EPnYioPwXDCXeO7WcWIiHTFN/LCkY3opR/jZUyBIS271sm?=
 =?us-ascii?Q?61oR9tpuWF3ElE85nrvEDQjxCoLndfFf24twh7uuvgtrSC//6i0utrYzdKY2?=
 =?us-ascii?Q?WJ3eCjtDOw/+dxH/UKUnsv1f4bh3fRfU0IDZs//F/F2Z8B+ivayk7LDMJwv6?=
 =?us-ascii?Q?jpm0RxITdMbXWPSFK8SaKpppelD3OJe4c/FkNw0N4HKSwoNB2G366LkK1/l5?=
 =?us-ascii?Q?GdB1yBL5FhRDVIY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:42:20.2481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91774f3-ea7e-4873-49f9-08dd33e8dddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

From: Leon Romanovsky <leonro@nvidia.com>

All packet offloads SAs have reqid in it to make sure they have
corresponding policy. While it is not strictly needed for transparent
mode, it is extremely important in tunnel mode. In that mode, policy and
SAs have different match criteria.

Policy catches the whole subnet addresses, and SA catches the tunnel gateways
addresses. The source address of such tunnel is not known during egress packet
traversal in flow steering as it is added only after successful encryption.

As reqid is required for packet offload and it is unique for every SA,
we can safely rely on it only.

The output below shows the configured egress policy and SA by strongswan:

[leonro@vm ~]$ sudo ip x s
src 192.169.101.2 dst 192.169.101.1
        proto esp spi 0xc88b7652 reqid 1 mode tunnel
        replay-window 0 flag af-unspec esn
        aead rfc4106(gcm(aes)) 0xe406a01083986e14d116488549094710e9c57bc6 128
        anti-replay esn context:
         seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0x0
         replay_window 1, bitmap-length 1
         00000000
        crypto offload parameters: dev eth2 dir out mode packet

[leonro@064 ~]$ sudo ip x p
src 192.170.0.0/16 dst 192.170.0.0/16
        dir out priority 383615 ptype main
        tmpl src 192.169.101.2 dst 192.169.101.1
                proto esp spi 0xc88b7652 reqid 1 mode tunnel
        crypto offload parameters: dev eth2 mode packet

Fixes: b3beba1fb404 ("net/mlx5e: Allow policies with reqid 0, to support IKE policy holes")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 47df02ef5d69..772b329aecc5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1743,23 +1743,21 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		goto err_alloc;
 	}
 
-	if (attrs->family == AF_INET)
-		setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
-	else
-		setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
-
 	setup_fte_no_frags(spec);
 	setup_fte_upper_proto_match(spec, &attrs->upspec);
 
 	switch (attrs->type) {
 	case XFRM_DEV_OFFLOAD_CRYPTO:
+		if (attrs->family == AF_INET)
+			setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
+		else
+			setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
 		setup_fte_spi(spec, attrs->spi, false);
 		setup_fte_esp(spec);
 		setup_fte_reg_a(spec);
 		break;
 	case XFRM_DEV_OFFLOAD_PACKET:
-		if (attrs->reqid)
-			setup_fte_reg_c4(spec, attrs->reqid);
+		setup_fte_reg_c4(spec, attrs->reqid);
 		err = setup_pkt_reformat(ipsec, attrs, &flow_act);
 		if (err)
 			goto err_pkt_reformat;
-- 
2.45.0


