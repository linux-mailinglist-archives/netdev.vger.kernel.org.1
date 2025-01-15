Return-Path: <netdev+bounces-158497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A0A122DF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2042F161A5C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C0023F294;
	Wed, 15 Jan 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kvWgtJYb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC182416A9
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941291; cv=fail; b=tO4+3hoaES8lTUu47FkX7h7uHxbZ+l33UGs/uE2VxH0/iFwYzL+cdd+H46au5F4KqMTtzep9ry6YCNjVjqDhEIspKeadVD4c3Ac+6mq5TV7S+K2ANzFhVcoo1TpNSFsT5TT3J8Yf/OzSkFwLpv09ol7W1RRZlsKh+Zm0o5A7gf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941291; c=relaxed/simple;
	bh=wl1BAk3XayMFX2BlxKNaqTn7d5T3wBp7SsTgXpKlueg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rb2haK6cRHhiTTeLGVMt9ZTMa2dj4DAZzUSvngS8V6IEILHkgFRlt6VMnJxX6U7hr10/uwIEB0OAjyh626I2dmI67gc87VR1uqB9ZC36WOst8G11PiiEmsEoMtKY33/qGONQY/uh2vMW/e8QnPqkaZDs4k0cvNf3/hLLRWQ52HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kvWgtJYb; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDv/RNPZirtlt7eZoqLHfzoAVrZ6zamkxtq/Fp1kC81XiZ2R82o9YSPsHY06BEsb/ZXifgG/pAEaUJjTr7x9/dXdt5OVD/EYbyGYESb4xDhLV3jH01XY+Ad5b2JN7JpSP9ZmqQpTlBR6XRmUb3vAULP8C5K19Ju/PmLhRo3+16YW46OeYP4ecw1yQ9dWFb44WczbxcAkQYQvza03anhDlxzNJTChq7CskEUoMMQdKI357SQEB1ds3H5IkSRaj8aooBR2iFpYWgfKC+Dabw6dz8FybBu8eZjSpDxIDaFl/3LCiWIJIPQuU1DcOhIrBu+WEa9hJMxPjE+TkU2utNRpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOzoC4q3TeF0hohy59ao2FSnRok+0d0FKsxmDqS5T/E=;
 b=qqtHt5ZxmGaBq/8sr+4tMe3YOjnWKUPAXWFc9gbjlUTZF7bUL8cXy01ir1xMaj70io6ENR6aJbx2ETolGpasvV157ATG+kvfhRFoocC0QN0aET4rQTO4/qrnaUg8cyJqZLs6Tda9jPlE2LAGbgntparn/QuPSGIN/1AHBZ27TuA5fBxzokSEMtdIqEdEWDUZibuEHpY5Fg93Dsg0RQB1vcnsISuCQxQkIJfvCcWWdg8wr7ALHze9SPkjz2nZzc6p0M74mUizl5AoZyI+2RLgMrVyLkxFjlvfUgV0V01HlvmPpZQ2El2sp9UAUZV+A5r0vVaLHT+0P4LIFAysUC+xzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOzoC4q3TeF0hohy59ao2FSnRok+0d0FKsxmDqS5T/E=;
 b=kvWgtJYbMK+wTOmMhxtPMg0T7fnaerIKhNNRjPKCXC7DsTW0b4b98J5Q9WjjfQ7iHMQzMZJqfgcKxzDl6CXHuM1mUMsMrdtNGyZ9UPCZzzuQa/7lCao1VHLlKOSiHxBp1MFKlf3nXP9eNm95BnI3IghgK6T2U085k8dqcufmyWUar+HEFbHYQa+QIULZmPQS+guCoIbbZ5BkLYjnfolSyKgVA4xPTG4MxcLV5c/tpfYH+rxAq/4mrR5o2GQolki0xA/Ws6zSTpnQ/sdJJ22FKvkF8tmmvIx74r6kIE/wfFkZcx8HeRc2R+PSSi2mlG657Tm+G7myVNmPQOsgc6hywg==
Received: from MW4PR03CA0267.namprd03.prod.outlook.com (2603:10b6:303:b4::32)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:41:26 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::5a) by MW4PR03CA0267.outlook.office365.com
 (2603:10b6:303:b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Wed,
 15 Jan 2025 11:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:14 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:41:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 6/7] net/mlx5e: Rely on reqid in IPsec tunnel mode
Date: Wed, 15 Jan 2025 13:39:09 +0200
Message-ID: <20250115113910.1990174-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250115113910.1990174-1-tariqt@nvidia.com>
References: <20250115113910.1990174-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2d3866-cec5-40d0-2756-08dd35598b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8iPuFfWhU2rVriwJ4PaqFPuABaxZRAbv9+xHgrWsJBHKYKXBFGzt6SqsOiH0?=
 =?us-ascii?Q?9pn+wNwGeRn1dxhUdC2nvG8u4rn/mRuhPV9gFGwv19GyJVNLP4sy7CsOGvJr?=
 =?us-ascii?Q?yBW8yS48bhsroKdrQ6OymY7ynQonHRixD2VJx/RKoMec5X5m2FGXaAjJY2FR?=
 =?us-ascii?Q?BNE+5qsFRvzXelTcFtgZG9H3EHKzshvnM/enEhctE4YHUXHG2rjr7c3clipp?=
 =?us-ascii?Q?nt4yU9kOgmAmfORbipbVeJyamSTKwJGtkjCE3hYdVy3uU6btz4ScwAoJzq7e?=
 =?us-ascii?Q?4vKif85Ir49J+MiqQt7bvfsQpXZw95ihJSoKynY8CbEVS/PrMSwXO6+FrRdS?=
 =?us-ascii?Q?6b5gefX4Lh4mekxAozKpCaquro1weiFbZv8NpHoHtyTqkwcqcHkPngGnHAR7?=
 =?us-ascii?Q?YAOA54ehhsDDyEQkVWCtxEJQBEBaoUDnLvRvX5764DD+uwZ5Q9nG05Pxk3Iz?=
 =?us-ascii?Q?4Bg2xk0wf5sLjRs4F5J5JdPNNGgNxzOrSPFHEhRyk7wnfC2E2whsfsspRmBC?=
 =?us-ascii?Q?6LuvC/xIiN9dwA2vALLLAX+9p2YA/HGudhDLjl2gSuNPK/+mbTw+/kyF4HPz?=
 =?us-ascii?Q?5ojmm63oDeGLUVOVqMPnPYN2Qeo6bYW7qnxVaB6ZyD8OXek+JmexzgLsHUIB?=
 =?us-ascii?Q?NqAjjo5OdFRkInIQNlZltXOYoSHxe0glllm/rGZRLARBzs3GVI1P8b3//ER4?=
 =?us-ascii?Q?cNcrzhfF+ypDF3xpVM/L9Zru0fHv/PlAJ+RnOc5Fw+xsEGvgLdc0Et1s3g/+?=
 =?us-ascii?Q?o076qH83ORruRbG19fUZ3eGA7DOxf3jR7QrbHX0pglIDGY+CI4ElsGA73ZwK?=
 =?us-ascii?Q?TXi5MAhF3n39s6Upk3AX2Sdg3APxOMFPlLBXHtGE85JAeKfw3tcDTDcXiOfs?=
 =?us-ascii?Q?/tzmf2ZQXWsgsp6taOgpQ9wn64ZycjEDCW8bBNx13zOv5h9/IAKDNiudOPRY?=
 =?us-ascii?Q?LjZz3NfYcAdPqlbvVkZwghKh4LpP5l6pLizBBqadvlSR2zR+p/hn4FUe8Z96?=
 =?us-ascii?Q?EHrxaSevLxakdHwkvA+cGxsrpgNNTx0mUnWD70XAlawXUS+19H/70SbGDGDv?=
 =?us-ascii?Q?G0Zj5sURHzVbraQZ871nNTiWuvmJcX8Y53RCpxTR3UZ1TEiw8xokxnz4hKCE?=
 =?us-ascii?Q?ETFjLGln4wUuPO7fgrtTxpMhKas6DN4kmkbu89cwFgj7H6b33InOqTtLKn4x?=
 =?us-ascii?Q?VGJVYJNVLIv3C/twhdF5sIFM1bDnsJnFbrd4gmNd+gL/qsHwmbauqNW/mHJl?=
 =?us-ascii?Q?PNWfRnNsnIxAMvNDyOwGGFm+/5OZtTP6g9IxDsOCSvnjK3ecu+CvQDGApjXz?=
 =?us-ascii?Q?ceyrciTKYNPqBl4oxr6Q0BgUmYvbCcIBtqNgeAum8o8foJ/cNndhVXTs6jtr?=
 =?us-ascii?Q?+2LmYB8LoYvlS7pXi9dH1u2XE/jH8M4ze5ns/Ks+cuEeIZmvi0isSgFX/W5C?=
 =?us-ascii?Q?ZywgPEwhEFwXRrgK3tHhmYpRcq09WLmvcsRG8mquPptdpKaa2CGSZ3A5kbfy?=
 =?us-ascii?Q?g6SVoTD4OcYzx/A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:26.2826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2d3866-cec5-40d0-2756-08dd35598b69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e51b03d4c717..57861d34d46f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1718,23 +1718,21 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
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


