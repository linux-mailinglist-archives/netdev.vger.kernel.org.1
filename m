Return-Path: <netdev+bounces-175411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D2A65B0F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A897A64A6
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202271AF0B4;
	Mon, 17 Mar 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjprF0b1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F41ACED5
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233217; cv=fail; b=ChO5LVFKLYWMYAWqNRgXIoJNxMbQoZJcSphRdJObeC4t0fi82aTAM6sU+x1EbG4w68OzkAXvxdw8hULs52glYE/zOKZGgJgAF/MafcvklszOeGNpB1zhJsf/FfNcTXAbf/w1VZj0sXCH8MRzb1VCHhyPYttsOSHf6Pqd3nZ6GBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233217; c=relaxed/simple;
	bh=ElmsW+oRGrk+lNI9Z66SEn8luxq9f1Zk2jOf4OmrMYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3K8EaDEXZOz5BUE3FGlwOKDEc4r0RrUppgkFoWQXhJXv7BfFpKBXG1nG09tjVjM5KEhu3iZz04sGncyRG77LCsp+lNNA68p1BnoIwCgcn0qkBH1iZGkkVj5v5yfAyJ/tkiOtk6QYJQ/TB5O1LoGR21dt/tkOyTW9WmdqAlCgEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AjprF0b1; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJHaKADA+CDKSMhRcsED8w/4pVsTDksTHqDpHXDDQeyHcZCXr4na3JXXmts972xmg3uZt3cX7T6c5THJUNqfW93fMsja4cWJIYFLwIjp675VC/O5Ba789KXPYjT2ijo6Qwxdag0IQAIE9WuVYURUHyEODhtcZVWHJ1VeaiuaE1Lj9MyiFMmAbggHFpKxNqGWX+j72foZJp2gYvqtCWXUmwcWnffINTCrZ7+dmhnqbA8i48LTEsvD3NKgonGQSK1gw9SskkwYmXiWGNm2kd3bqIc4lMc6LbmT8lTXmXYGNJ7s0Ntz1y7cDHP+bQERfwbX7DHYDeYIQFqUKfBPulEKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPAGq+zWVhBr5mWZn1/+oQm8GaC9LPtZzMZSEkxo3cc=;
 b=xTxg88qQ/aLI9kM9mktxwuxZbcI8k7YL0RUmpbd2bEmrvfbcdBJQrc+HXm2pS/Sj92W93pWxTAE3jI1pQrf9Cl2l7WTKqxpeBw0lumIiZ2IfAnIbVTIsmYVhzkzQYrtvFmAAoePlui8/8Q5NMCJK7kRwv/jh+Sm8T/2JGucin/KQGh3km7K5blQ1aMdooksyYrk3qEJxw2PdJ97qqODjft4toUAw45hvp1qgBGzopSzQV8eDUIcGGXkva28vptUoqRE/1crchEmGgiO9gkqDjj7nSW3n7BW7MNXFZy2d0Db8lceUqfptiBqlpgAllAHaddygd9jqrDVYrGZCYid8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPAGq+zWVhBr5mWZn1/+oQm8GaC9LPtZzMZSEkxo3cc=;
 b=AjprF0b1JlaSuJj/b4oD31jvSwa73900EJzlSE11ezn/j/MBIvEC+QGA6sEnWzf+FXC8YWF0g6EZTso8THLx4R2uBwxUYEKlzPGsBPvpqb9hOTrcNMG5Hy7ahBpDFhbS5d4id8zIAlgP/67uuzsLsqq7WgfLKyWmn2bzAOqgmf7x336kjMNMUzwLr7LxC5uhk9f4tU/eivpf2c9kRnMhL2gZSpBn+c7Bv/c/HILUrQ4CgmRVDNAM9ZId1hskNFDwSzVNfjayDRFQN4pLC/o54qsnzNkyezVZ0TjtyPNfq+C5NEuh6rcOanXE7wcxdmGNGewxs2VOWj5pbp5e/Oh0GA==
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:40:11 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::ea) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 17:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:39:58 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:39:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/6] mlxsw: Trap ARP packets at layer 2 instead of layer 3
Date: Mon, 17 Mar 2025 18:37:26 +0100
Message-ID: <b2a2cc607a1f4cb96c10bd3b0b0244ba3117fd2e.1742224300.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742224300.git.petrm@nvidia.com>
References: <cover.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: d6779719-27b3-4df8-3320-08dd657ac444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cNwoX6jKSgW9kFL7RgY0nf5NhvhbdsKs32JkJ5Yv26GRzTML5ocSseyFZi67?=
 =?us-ascii?Q?421td72qzH2c5PE4DC+3T158iD+QZVd31w9KX381cl2MXHJXGwuti9rgXKKN?=
 =?us-ascii?Q?Ghq3UHX9K8sMn4e8JvrDuGMDpwnYUq3IV2KyaihP94YCEltCG9TDcTpTtHdh?=
 =?us-ascii?Q?wO8do+rGiGrG7OSdVp7QvQKEeTnMvXT55v8cBf12LeF45BW3SRFOivtwQTKt?=
 =?us-ascii?Q?GWg3tZVZzBv0KUewC5mgoMbe+0njxfgk+LSNMMXx++ewGYX81OXgb1hfZDoA?=
 =?us-ascii?Q?8OWDjN5rrjY/SxRtLX/GGiyH5ehtygFcP82hOVXgRKskaIb3XakysqwbxaGt?=
 =?us-ascii?Q?ryoknaP6Km3+6yJExbWHDPaAs8XaZNvT6ngf4aCWRglXLxTKNrwVcXgdz842?=
 =?us-ascii?Q?lagCb96NpxzpOQvhB3+Ut1AT0HJ8+Tw90ElOj/whmU34SMHWC0FeaGr+h8HH?=
 =?us-ascii?Q?JN1pTZ89rjqc/Fjs0FbqqqxcpRMnrDQEiVZTh0DRXw1C5EAvh+n7ULGKpBau?=
 =?us-ascii?Q?A1ZHko60tbN/7Z/2w8cL4XU7tfiIJIxW2gBExtBJ1lSS1jYMKe7kNYf071Yr?=
 =?us-ascii?Q?G+6llw42ns8Cg7K5I/Xdl7bkFiyE3u2qTfQRVJeJ6+IQaNucGlLV2L1cfg/o?=
 =?us-ascii?Q?095EhSxAoP0047EOC0bx1DjlTXCZBCRlOrguKBaax+9/qbaw3ZDSnvjWEUDv?=
 =?us-ascii?Q?EOqeRpX00dIbPqIFez9Ztpog+CYMV34OmUtDtq6lFMGZC7bWpRgI3JE0WnM/?=
 =?us-ascii?Q?xW5nNqkqauojjoo0qNVWc39A5rNYRhv0yIJB7SPTm+HgC18kBwL7S/ZD/ImR?=
 =?us-ascii?Q?z+NnuoQSBSZm9l8jZXMzwaqWhpxSbPtGoYfauGlcW34Uf0n4otBepv33w3Wp?=
 =?us-ascii?Q?pY9248M5BjsjCFTHlhT2fplUUbgjuxWvLtNioXOpaicPwwvbnBPVxtWabuWe?=
 =?us-ascii?Q?RTChgLc2khj7pCxfeRq7994X2e3y+r+yDWnuCHGg6FnouRpypjpSdScTyv6c?=
 =?us-ascii?Q?kvrzbAQSP8qL+ON1/VkoTTQruLkyAiyx9kt0VKXmvLf83xYDyVXzDe8s3amY?=
 =?us-ascii?Q?v4xzlOwNMHVfTKuo5MlcHLzXnrbJB6mKmErVOyUbC8nRJwBYlI0Qo9tw//aZ?=
 =?us-ascii?Q?1Ws8QIk9Dow2uwqel1hkCs+MNnvc2PoN5k3n6ylWHxHFqCvGiH7su5SaJS6q?=
 =?us-ascii?Q?5/4NiTMRoM085TOeHR4Tg3haHdL22eIAHXR5ZjNg7wB79gyzc3/K3PVfqQOH?=
 =?us-ascii?Q?R9zJ91hhnYdkiDdaBJraOWra+MnN6iVpJZVgcDwo0CShV7q4UXOLqLcvv72V?=
 =?us-ascii?Q?4U5dwdfLVKTUUfHDacyWnrdYqjpNIEfEKQ3CMRuzqMQxU1TtKREdlPKa/M+d?=
 =?us-ascii?Q?o7thsAS2VY+IGEgrgLrBNHhGXUpbLQn4dRw17zROKo5qhtmMCyZyIm7tt2Oe?=
 =?us-ascii?Q?JeeVRAACRyUzmn0kst6kmYdEuafd1yK512kfcSUhW9MX3ux3cA+vjKX79Wqo?=
 =?us-ascii?Q?/MqN9QpG23VDNe8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:40:10.8291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6779719-27b3-4df8-3320-08dd657ac444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576

From: Amit Cohen <amcohen@nvidia.com>

Next patch will set the same hardware domain for all bridge ports,
including VXLAN, to prevent packets from being forwarded by software when
they were already forwarded by hardware.

ARP packets are not flooded by hardware to VXLAN, so software should handle
such flooding. When hardware domain of VXLAN device will be changed, ARP
packets which are trapped and marked with offload_fwd_mark will not be
flooded to VXLAN also in software, which will break VXLAN traffic.

To prevent such breaking, trap ARP packets at layer 2 and don't mark them
as L2-forwarded in hardware, then flooding ARP packets will be done only
in software, and VXLAN will send ARP packets.

Remove NVE_ENCAP_ARP which is no longer needed, as now ARP packets are
trapped when they enter the device.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c      |  2 --
 drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c | 12 ++++++------
 drivers/net/ethernet/mellanox/mlxsw/trap.h          |  5 ++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index c7e6a3258244..2bc8a3dbc836 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2409,8 +2409,6 @@ static const struct mlxsw_listener mlxsw_sp_listener[] = {
 	/* Multicast Router Traps */
 	MLXSW_SP_RXL_MARK(ACL1, TRAP_TO_CPU, MULTICAST, false),
 	MLXSW_SP_RXL_L3_MARK(ACL2, TRAP_TO_CPU, MULTICAST, false),
-	/* NVE traps */
-	MLXSW_SP_RXL_MARK(NVE_ENCAP_ARP, TRAP_TO_CPU, NEIGH_DISCOVERY, false),
 };
 
 static const struct mlxsw_listener mlxsw_sp1_listener[] = {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
index 1f9c1c86839f..b5c3f789c685 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
@@ -959,18 +959,18 @@ static const struct mlxsw_sp_trap_item mlxsw_sp_trap_items_arr[] = {
 	},
 	{
 		.trap = MLXSW_SP_TRAP_CONTROL(ARP_REQUEST, NEIGH_DISCOVERY,
-					      MIRROR),
+					      TRAP),
 		.listeners_arr = {
-			MLXSW_SP_RXL_MARK(ROUTER_ARPBC, NEIGH_DISCOVERY,
-					  TRAP_TO_CPU, false),
+			MLXSW_SP_RXL_NO_MARK(ARPBC, NEIGH_DISCOVERY,
+					     TRAP_TO_CPU, false),
 		},
 	},
 	{
 		.trap = MLXSW_SP_TRAP_CONTROL(ARP_RESPONSE, NEIGH_DISCOVERY,
-					      MIRROR),
+					      TRAP),
 		.listeners_arr = {
-			MLXSW_SP_RXL_MARK(ROUTER_ARPUC, NEIGH_DISCOVERY,
-					  TRAP_TO_CPU, false),
+			MLXSW_SP_RXL_NO_MARK(ARPUC, NEIGH_DISCOVERY,
+					     TRAP_TO_CPU, false),
 		},
 	},
 	{
diff --git a/drivers/net/ethernet/mellanox/mlxsw/trap.h b/drivers/net/ethernet/mellanox/mlxsw/trap.h
index 83477c8e6971..80ee5c4825dc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/trap.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/trap.h
@@ -29,6 +29,8 @@ enum {
 	MLXSW_TRAP_ID_FDB_MISMATCH = 0x3B,
 	MLXSW_TRAP_ID_FID_MISS = 0x3D,
 	MLXSW_TRAP_ID_DECAP_ECN0 = 0x40,
+	MLXSW_TRAP_ID_ARPBC = 0x50,
+	MLXSW_TRAP_ID_ARPUC = 0x51,
 	MLXSW_TRAP_ID_MTUERROR = 0x52,
 	MLXSW_TRAP_ID_TTLERROR = 0x53,
 	MLXSW_TRAP_ID_LBERROR = 0x54,
@@ -66,13 +68,10 @@ enum {
 	MLXSW_TRAP_ID_HOST_MISS_IPV6 = 0x92,
 	MLXSW_TRAP_ID_IPIP_DECAP_ERROR = 0xB1,
 	MLXSW_TRAP_ID_NVE_DECAP_ARP = 0xB8,
-	MLXSW_TRAP_ID_NVE_ENCAP_ARP = 0xBD,
 	MLXSW_TRAP_ID_IPV4_BFD = 0xD0,
 	MLXSW_TRAP_ID_IPV6_BFD = 0xD1,
 	MLXSW_TRAP_ID_ROUTER_ALERT_IPV4 = 0xD6,
 	MLXSW_TRAP_ID_ROUTER_ALERT_IPV6 = 0xD7,
-	MLXSW_TRAP_ID_ROUTER_ARPBC = 0xE0,
-	MLXSW_TRAP_ID_ROUTER_ARPUC = 0xE1,
 	MLXSW_TRAP_ID_DISCARD_NON_ROUTABLE = 0x11A,
 	MLXSW_TRAP_ID_DISCARD_ROUTER2 = 0x130,
 	MLXSW_TRAP_ID_DISCARD_ROUTER3 = 0x131,
-- 
2.47.0


