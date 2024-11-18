Return-Path: <netdev+bounces-145917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7A9D14EE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94659284B9C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65E1B5EA4;
	Mon, 18 Nov 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j7mEA9BI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF921B21BF
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945720; cv=fail; b=MURnAuz+RvEJpSC+3GrSdVGe1oRvPoortLtC/Or/RqT+rvPM9A8/2Nd1oMFXdc6FOZh9E4cTkbl8ETtLvcrQFAFQSqJU5dxA2SV94htD9O1h1+PEKKuQffv88vjzJi52POv1FpmLaD3KsXs8uy+N/eOnQTUM+oThsKAPLxnXtHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945720; c=relaxed/simple;
	bh=h70njbfsfbU3z6wmfeazJL9VONBruywQ0hUKZq3yrTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcrUpQhWebwVRSfZ2/nBo5PRzn8RFEQ5oA4b1Bbis6pH4uJpDjUuV8q6OAEqCC+VaVx9dEvpUtnxsTaF9BGxee87raSfj5eLbXGzg6FiTq8+YmO4k7axfPQlMc0Z7VbkfTRyTxJlqMyU9dV/nwkrmHi+HUfNbwuRswzgedrI9gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j7mEA9BI; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAHuYuOU5TzDTYEnrP0DEgpQ7GZwMnO1DkjPGD4T/xWt30tmF0+Jlp5maCEEpH5AwacJxVLMgm2kuve/eefLCVFZTLgNf+/EYTmGA/TMMI0yQB1SPUC+6XqX26xI4bmUVpeR926tm68UkyVGOOH2sKDaW591fe1zXJE3Y1kPbd/n5GcHP5f6RGlpA6XLWiyUDnhxriTExpMnzGyH2pEW/UWOxpKsvvdZT6QoA5qLpGFvYMUdDEYZnhlytd4RMnDpjW10GITpk9GrrWCHZTYm1TNGuPyddgUlpBzR+kbnFwnC3oC5lSPqOLJKxpoi1UVjdcjXGXQXtXDyfQC4t7TyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQsqCrrDzPw7D26r9pB4xSObMzjNa0IJwvr1QTHxFlc=;
 b=ArU3hXq1rdCrsuNuNlxLV9Ivs1YppbkwPw5motnt3L2+ajYbFZhOXLZxrkf3ivav197xjCtjTkH1qZV8jZ70DPu++uVeGMcw36vs7eo5HTsFOdb9qT8qtnB51i/+6pbuj3BMG5fjWf1nD/xuvQbG9rTXg9vGOVSXxiUq8FaCzObpS9R+92rG+smkHuVFNt+VBRFwfdgdHvfDuAjklwanvclEBakgL9ZR+hhRsILKE1YG7spOlguCf7MOwG22O4o00vO53vErqsHk5NAQSN+zNXuFMUT1yV9aOASR6PXfYO57q0AuqRmM8bdpe0J23uNA8V+95uaRIrztbOAVOshaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQsqCrrDzPw7D26r9pB4xSObMzjNa0IJwvr1QTHxFlc=;
 b=j7mEA9BI7EaAgRiVdjVNy+mDXnKUk90RuHAe1GZxn8cI/KFRtGU6I6Hir97hgTQiL+9JmOibwrOpTYnBprkpdIyfKnFQr8mWendWswqvkJAXKp89RlZkbSFuUdsWmXr08Jpwr0AHhFt0bu55r5hxPIM+blP6bAESqsCF0w1NgZkTzX0FPKHhKvsaAFGAVqBfEYHPTgx1D1DwXNxSLeXW1vAO7lC6NmxHbCIGdqSqpfsiD1OSwX5AFayl2VhVPEaN+eq4fNt4r1+Ilu7dbsaEZ3Dj1Z5f5Ct5FXJiOz+C4axS5/kJziIdndOs/L/cNhFnZX5KkjcJF4x8QdrcLnE13w==
Received: from CH2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:610:4c::25)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:01:51 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::56) by CH2PR10CA0015.outlook.office365.com
 (2603:10b6:610:4c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 16:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:01:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:20 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:14 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 03/11] vxlan: vxlan_rcv() callees: Drop the unparsed argument
Date: Mon, 18 Nov 2024 17:43:09 +0100
Message-ID: <d54dfc56bd8835789a3b75d91873cbc9f9d2dc33.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb8f202-3122-4113-de07-08dd07ea50a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdiuUs+W96p38F/3ENgicb2LFSY0RzOWgEvFgFJlgGqz4ujpl25DppDclvdA?=
 =?us-ascii?Q?wh21mexvS0cAhmceXoe7IqxFhpFfHx5bMLLnTXLuIfd1wDEGaokcgmJu2CHS?=
 =?us-ascii?Q?+I4/cPVrFLng349k8BJ9JamRKDqZJeAgTSpuAkT3bnqU0sOF0LxOfYpvBuDi?=
 =?us-ascii?Q?fJ44ad4BOYKwPeFpMdOk0U1iUz6LtYxgcaaA03bozU5hdVKiuDkqsBMNCu6I?=
 =?us-ascii?Q?mQukzcf11PY6tEGZpr8ZHPtc637HZ+wu3ksCfi7uLZNFnI1TkkA3Pq9ulSFB?=
 =?us-ascii?Q?zVdfGIOxpe84boc0nHcWeuugtw/ktMHsy++OAZoVrQAVLd4TcdoHVhZEH1E5?=
 =?us-ascii?Q?GXlCK6MZ55dMXWA2CT4eTK8rqEoXVvGgKYQRMBZMRQiefqYif9Cn4k6py2a7?=
 =?us-ascii?Q?ZjJDMx0oH1wm1KqaUq6GiNRFhfyc3deSZDw2PTl14FkU6A0AHMVHkNiL8tjk?=
 =?us-ascii?Q?Aupjs2CEStJmOSZyD6RIkkjbvPHhtSdfAkUc4srB6C1o/bMrvfak2hMaR4tJ?=
 =?us-ascii?Q?QQqkBC+WkoonENxWZq/ZavJj1N0KcxQV1ws+Mk0C3YgO+HqbUIY1ANDoY0Oy?=
 =?us-ascii?Q?72Y6IEHDLXJsSfZjyNX8EKVI26sRtYqmwI+ZCxbCJqlYSZp/6gUlbdjmeXju?=
 =?us-ascii?Q?rE5nlKajhwdvyRiVt4QsZhYpwzYJ+SkP/RGIT+9/QRie6dFTg3o7gLvlLZIW?=
 =?us-ascii?Q?+mco+q7BY3HRvDIsqobjHAi8rLsulAGod6njv7McBfb24agdMJmL7T9mALir?=
 =?us-ascii?Q?9ogKLzeD/ouQy0yCOp+XeOIFLiR3noYHEh7kMebbMrQcbFooCKnnVy3oq9Xt?=
 =?us-ascii?Q?brkvRdCQ5dC/jncT3mMirSXhcOeyrCjVF4hOlRC8Mila09iOY8Cz27aBrSWy?=
 =?us-ascii?Q?4IPE3E7Ka6ZZslytIsGAzWAPdZNdFIA35TOLbx7WaU/6ddkFPpaEYMsujBih?=
 =?us-ascii?Q?+//AQMPVDXIsztXinfV6D9nbsu+snHGP1C5UXJ59T5xad2jthgZEesmiBrvZ?=
 =?us-ascii?Q?E66JJRTJVEXG2WmQYE+BijlOK8/EKtcTUMy1GfAYqTcIPeKqFhUHO0hDJtwM?=
 =?us-ascii?Q?+iZC616+9246UvglEWtsOodCWLPR/36w/5qhrbEDv6InpV5Q0iijT8kGcitT?=
 =?us-ascii?Q?hPbG4R1YxY5yQVbDE7XF0R3n/mkVbAyasDVxrB+Vp1S/MSPsd4HlD7x62IlE?=
 =?us-ascii?Q?UmBCX0IXWEOIF6XcQEc7/aRw2hxSP/xPPI1hIAmdKg/T7Sb/Crr3WH2ziETA?=
 =?us-ascii?Q?m4nsq8V4O+Kv1qj2kv97Arx++pn70adouPvxh0EfxrD+bupCzXujsInZUVau?=
 =?us-ascii?Q?45LpF3Gau60470KIheBusMMthUojR3b8sSymedC8ubQB5tbMq3AJFCU1+dz+?=
 =?us-ascii?Q?8iaXarZoYSNcCyDPzfujlf0tDWywUtlHdVmOW6jYkvfEYlE+Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:01:51.2042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb8f202-3122-4113-de07-08dd07ea50a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

The functions vxlan_remcsum() and vxlan_parse_gbp_hdr() take both the SKB
and the unparsed VXLAN header. Now that unparsed adjustment is handled
directly by vxlan_rcv(), drop this argument, and have the function derive
it from the SKB on its own.

vxlan_parse_gpe_proto() does not take SKB, so keep the header parameter.
However const it so that it's clear that the intention is that it does not
get changed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1095d0bb2bf9..835dbe8d6ec0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -622,9 +622,9 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	return 1;
 }
 
-static bool vxlan_parse_gpe_proto(struct vxlanhdr *hdr, __be16 *protocol)
+static bool vxlan_parse_gpe_proto(const struct vxlanhdr *hdr, __be16 *protocol)
 {
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+	const struct vxlanhdr_gpe *gpe = (const struct vxlanhdr_gpe *)hdr;
 
 	/* Need to have Next Protocol set for interfaces in GPE mode. */
 	if (!gpe->np_applied)
@@ -1554,18 +1554,17 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 #endif
 }
 
-static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
-					  struct sk_buff *skb,
-					  u32 vxflags)
+static enum skb_drop_reason vxlan_remcsum(struct sk_buff *skb, u32 vxflags)
 {
+	const struct vxlanhdr *vh = vxlan_hdr(skb);
 	enum skb_drop_reason reason;
 	size_t start, offset;
 
-	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
+	if (!(vh->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
 		return SKB_NOT_DROPPED_YET;
 
-	start = vxlan_rco_start(unparsed->vx_vni);
-	offset = start + vxlan_rco_offset(unparsed->vx_vni);
+	start = vxlan_rco_start(vh->vx_vni);
+	offset = start + vxlan_rco_offset(vh->vx_vni);
 
 	reason = pskb_may_pull_reason(skb, offset + sizeof(u16));
 	if (reason)
@@ -1576,14 +1575,16 @@ static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
 	return SKB_NOT_DROPPED_YET;
 }
 
-static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
-				struct sk_buff *skb, u32 vxflags,
+static void vxlan_parse_gbp_hdr(struct sk_buff *skb, u32 vxflags,
 				struct vxlan_metadata *md)
 {
-	struct vxlanhdr_gbp *gbp = (struct vxlanhdr_gbp *)unparsed;
+	const struct vxlanhdr *vh = vxlan_hdr(skb);
+	const struct vxlanhdr_gbp *gbp;
 	struct metadata_dst *tun_dst;
 
-	if (!(unparsed->vx_flags & VXLAN_HF_GBP))
+	gbp = (const struct vxlanhdr_gbp *)vh;
+
+	if (!(vh->vx_flags & VXLAN_HF_GBP))
 		return;
 
 	md->gbp = ntohs(gbp->policy_id);
@@ -1712,7 +1713,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 * used by VXLAN extensions if explicitly requested.
 	 */
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_proto(&unparsed, &protocol))
+		if (!vxlan_parse_gpe_proto(vxlan_hdr(skb), &protocol))
 			goto drop;
 		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
@@ -1725,7 +1726,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_RX) {
-		reason = vxlan_remcsum(&unparsed, skb, vxlan->cfg.flags);
+		reason = vxlan_remcsum(skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
 		unparsed.vx_flags &= ~VXLAN_HF_RCO;
@@ -1753,7 +1754,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (vxlan->cfg.flags & VXLAN_F_GBP) {
-		vxlan_parse_gbp_hdr(&unparsed, skb, vxlan->cfg.flags, md);
+		vxlan_parse_gbp_hdr(skb, vxlan->cfg.flags, md);
 		unparsed.vx_flags &= ~VXLAN_GBP_USED_BITS;
 	}
 	/* Note that GBP and GPE can never be active together. This is
-- 
2.47.0


