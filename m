Return-Path: <netdev+bounces-145921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04209D14F0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499C91F23561
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811E1C07CD;
	Mon, 18 Nov 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="daqzuoaU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E201BD4E2
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945732; cv=fail; b=Ovpny/YN7/EAc3iVmvBbXvIivk0xE4E26gXiYKybpzUlkrKuOAwOcAdVhJtTevl2LbcSXyc2tSqCljzW1V8slrv2tXRu/daEpu90nHE55UiOD59S21tP8jGLQxRoZdK3eU2l5rBuih9rrQwmZ62DbNN4DnJhHCe7f4ve70KUV6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945732; c=relaxed/simple;
	bh=iJ4aaw5HTEFuCTFZPIk6hZooa9CSigFar7TsonG6a5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Smfch345IUt+s8tsZSTgaQODoPPpJYMfgNEQ3TulJjDfrUypKNyS0QiC0NsKhdlqM+nJx9Ev8XAdBO+pRlZEdX1G69IhHwZNqy3M/FxCMFYzpgKk7+Eb4Ghj58lye3uR83bSZUFFlldTmsUech7L8w6DzDM5Txrps/ts0zP6+E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=daqzuoaU; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD80XCQXm8H23efjfFMXqVuRYNFYyOy1RMkSOJftkfPT71bfOd54oNOE/tBBcn/Dz1clfs2MzDHGjToM4r4eP5aAHwRUwb3PTR3V1JiwmkoxJQtuu8D/T3KsSjiyV4tQwv0wBQ6qE9yNUWytCKGaLDh5vY7uhY6TlLhvt3+sPf7VYrcSYzkcd/+L/1HAUKYEtqdwRKLey650kb8LQsLf19R3+9Pu2qFwsGMWTWyEEUq6rp3MYOADQanCKA6+23akyTKQiYFbcf9pHg81kjy740WubdtDwErIfq1svfo93B6bC7xR31y9wmOsDWvQAGyQA5tDZmPG4RuI2WYZyTwrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LghsmdqwR0uUilIDKT3uJJ1lfVCF8vhRuCoy490rGSk=;
 b=u7Qk4ld3v4Hlb/WHKSGFzE1lMyqgiGxy/rQrTiTvXbckAsDVHFDSjig2qVaXFtJibQZMW1BH2IIsYY44CQ1jvZcfqnF4FpOhXlhKw/jalaE0vw+jc72kNjE7UAXDwN5Ic2cTe7695yAPQ9xaMAEdG9//n5spD2HecUhul2sYonnl6XoPQUv9LCnfvlqZTeHvhc3vGnTsNEbhj3Xep4/QPPCzTCgZRAvGdsFgRllqaDy/pFPLHCwSOux2F16eHrYyOG9X8oyhvtiP7MrcrBq48dd/03BsgEUOnYvkzK64xVl3beaZAWVtw82jzZTOqZO1p7Ipv/5g4s8c+rWjEUfIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LghsmdqwR0uUilIDKT3uJJ1lfVCF8vhRuCoy490rGSk=;
 b=daqzuoaUUu9tC0RzNf3uizKeevEq8NY6hIMcT6zrGuPoHa8u/FzdlumR9b75buA/8MzTow9QKywTtdKEiGf7ZJHW6VpALfci0PiVExckdBjqdiGMf7IOOsVmPnJ7VTEhmAKTK2MwrmKuTpna6IeQG0NmOcYs9neYb8TjCF3GyPD4IQ1q2TVjCJe+OEAutHwwaL/7nTFRsAWqLeh9dDRA0Q4rL459JC6wrPjWobtdK9wr2TJIL3x3tbj5yf3gEFCCuhRzThIvxtP7A26GasQRTp2Q5t0vwQUdIpycrdfP5QUN4LtZj/v2LOpxPdgfNdYhCE68PrrDV2dMi9bo8PBwQA==
Received: from CH2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:59::21)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:02:07 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::ed) by CH2PR03CA0011.outlook.office365.com
 (2603:10b6:610:59::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:02:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:46 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:40 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 07/11] vxlan: vxlan_rcv(): Drop unparsed
Date: Mon, 18 Nov 2024 17:43:13 +0100
Message-ID: <37b3b793970baea64d4ad306eeacd18d9d3bdd55.1731941465.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731941465.git.petrm@nvidia.com>
References: <cover.1731941465.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: e9be2031-da8f-41dd-2420-08dd07ea5a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?prwxwCrw8y1/KaCxmbICVSquD4CrfAuDKJQdzZPVo356D8Qxo09gIyfagrEv?=
 =?us-ascii?Q?DkvKkVqTpz5l60hSYE2jz+tOAGMQGL/siO12ZWSZULftQPG4yUr5H2HTDZca?=
 =?us-ascii?Q?o/wLzOx0qgD5l4oymwTW5xDZckdOKtbu+b9LYnMgCjI7b4bW8rMFfNDmTl+0?=
 =?us-ascii?Q?bnKdrnL1LZM2ka6xIZR4zrEyFEjnBv+ve528bvUxAUGcjzJTd3i0bf3meJrS?=
 =?us-ascii?Q?WuAzQcgtfWNG4WBQVb4BcdN36DMak5YniI1DaEFXyqrQy/LDPd7Z+PZKi9L9?=
 =?us-ascii?Q?XA+x5/WyEQgVlYUyfr1uhu39ivAZeY6i9+zU+cbI54/w3a69z4qrR99EItOx?=
 =?us-ascii?Q?IspddGqcQ3O87jvDFe4sTrdfgJXkANFF+nGcYcPDtTjHXlxQ23Xcd+kzOH3B?=
 =?us-ascii?Q?phxz3BxmugvUCpVEFBjYbpzCSBGYpnVgcRpz0EsmxAndM0GglOGQUd+6Sie3?=
 =?us-ascii?Q?MXCANblOyGeZ6mLLjc5D2+3EDpDM38qzcqpPnKzsNQI5ceKi4jjAYqcfAflo?=
 =?us-ascii?Q?F9EpdaFpzyOe5dBQQZ48ixbtVg2igFsUa+z5MOfvV1DdE0AtCKk1GtkSpHe+?=
 =?us-ascii?Q?xIijD5Muw/mVxVEOo914rGW6zsllupVRNkVoYtXr6v3Jk5MZadHkn1DWVox7?=
 =?us-ascii?Q?7d5Fz6qmERSBFqQO+lGscNEke6mjYvTj4XBTpT6qBWJioiAulrn4iBconr1n?=
 =?us-ascii?Q?NrCEYpMi59ukVdzlF5MOmAkntHEYYoDkBmGVvQjonlkW4iBUz4jPKgf2NF0j?=
 =?us-ascii?Q?jmujRl6UnJVl3p+3506jGxMAVEwYg0ulpAWh1zjwQl5UCYY1pMJ1AJMyeEdI?=
 =?us-ascii?Q?WBjiLN0klg0J6ppdvRdguM7ggkZasqqCGrgnw8x+EPnQqd+fppy+3zKOctiX?=
 =?us-ascii?Q?VzEgYvBfaxEqDrwKewAzgK1FqzYRHgtppHMTSHme1w+lCCDHBnzUn0fQQgFo?=
 =?us-ascii?Q?Jv1o+MnDYgwcro/AWT12xVkZTNJpA94RXxIzrvdjwMfAPF7e9C09baTWd6sk?=
 =?us-ascii?Q?vZMTLp/mEjXzv1CYu1LTAbe1ZRDlLuXk2Z9jgl8IlDThMI1yhPipZsxi4c0p?=
 =?us-ascii?Q?b29sJxfCXO3vWzA9z1x94m4mWxkCaN41+rYDMjwbSXp9xXA6OZzvctL1UmJX?=
 =?us-ascii?Q?Ts1eC21F2eOdwM2sxUfMv5da67qetQ/Ji2atl/UpKZ1d+s5IoUXp+2jBATb/?=
 =?us-ascii?Q?Z24KRVUV7GGljKskPabINlBIJZcIkzcm68noG/EyfliReczf3YrhxbFqpU2X?=
 =?us-ascii?Q?OnrEcuMF5pcrzoe/RLcUt34aVduHIbty2MnCsJdySzMfBguHT9Qn8jYnCbDp?=
 =?us-ascii?Q?rb5whEC8Zz2jJ5KnVl2F1Hjta1wgMpYySjHMF/mypEE3C9fHXy9raa+rz0e3?=
 =?us-ascii?Q?+Ks6OR5dU3yYOCGp12MQpG98PXW9HVrRVGwZEFOoVl0M51eAhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:02:07.2810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9be2031-da8f-41dd-2420-08dd07ea5a40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

The code currently validates the VXLAN header in two ways: first by
comparing it with the set of reserved bits, constructed ahead of time
during the netdevice construction; and second by gradually clearing the
bits off a separate copy of VXLAN header, "unparsed". Drop the latter
validation method.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 090cfd048df9..e5c7b728eddf 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1670,7 +1670,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	const struct vxlanhdr *vh;
 	struct vxlan_dev *vxlan;
 	struct vxlan_sock *vs;
-	struct vxlanhdr unparsed;
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	__be16 protocol = htons(ETH_P_TEB);
@@ -1685,7 +1684,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (reason)
 		goto drop;
 
-	unparsed = *vxlan_hdr(skb);
 	vh = vxlan_hdr(skb);
 	/* VNI flag always required to be set */
 	if (!(vh->vx_flags & VXLAN_HF_VNI)) {
@@ -1695,8 +1693,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		/* Return non vxlan pkt */
 		goto drop;
 	}
-	unparsed.vx_flags &= ~VXLAN_HF_VNI;
-	unparsed.vx_vni &= ~VXLAN_VNI_MASK;
 
 	vs = rcu_dereference_sk_user_data(sk);
 	if (!vs)
@@ -1731,7 +1727,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
-		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
 	}
 
@@ -1745,8 +1740,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = vxlan_remcsum(skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
-		unparsed.vx_flags &= ~VXLAN_HF_RCO;
-		unparsed.vx_vni &= VXLAN_VNI_MASK;
 	}
 
 	if (vxlan_collect_metadata(vs)) {
@@ -1769,19 +1762,12 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP) {
+	if (vxlan->cfg.flags & VXLAN_F_GBP)
 		vxlan_parse_gbp_hdr(skb, vxlan->cfg.flags, md);
-		unparsed.vx_flags &= ~VXLAN_GBP_USED_BITS;
-	}
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
 
-	if (unparsed.vx_flags || unparsed.vx_vni) {
-		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
-		goto drop;
-	}
-
 	if (!raw_proto) {
 		reason = vxlan_set_mac(vxlan, vs, skb, vni);
 		if (reason)
-- 
2.47.0


