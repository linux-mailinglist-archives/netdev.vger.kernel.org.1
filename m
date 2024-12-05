Return-Path: <netdev+bounces-149440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847319E5A18
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB56216D8F4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE121D582;
	Thu,  5 Dec 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DEaHWapD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0EC22145F
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413442; cv=fail; b=DNo1MD94uw6HmQIexXEUp4w75qBA9T4dSDtsyR47M2mb+ZabJXnJnYWw3DeCbI+igvvstvhDpBpAXFseSOkEYOb2zMvF+SznBhWIJNhpJELi8l1tI8g5fVrjsxXAzrOLXmK71PRFRG84cD5GZgsx6sGX9QKTpympSWqgxXEQEq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413442; c=relaxed/simple;
	bh=pYQ0hiUONS+43/z9LeVyuG6wkPCtiOF9M20tP43y8h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPjPOV5Ni8Xmqjmq4S0Yw4mc3jKO4po3emk+9Y2ykib6x3Byc3L0iP/ml1WkUz5tBsocAX+7rjWwDZ+GpjMdq24fBci/6YJRotDZ3n0gGcbWLJ5tcbF31VnU6FvKliWQpVvT73ZB7D+sAJseWLFlds5tUHJCLtJMTKEqhW9FZJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DEaHWapD; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7ZOvwmRBqia2v5Uu2w6aUyoBompRZv7Ye2lntc6jOQFHO/o+myd4WkoqHZl2onSMGnZYljFyiRayx99vGyezhDKV+LIrNHxUpEyzJOXvp+plf93to1EwGIoajycDUZCWUS2Nn2ESOjQ26jJMMmFeWkG6r/KGLvD9zNnHBx5h7bLVdhCHZenBenmlQk8OIaS1Zks7SqH/GNXrG1rTtdGgN7TGShZ4URU+id2CAfphXSXrvIrBoxz2Rs2H4k3hr4bmvbyGEoqccigfo9jAOY5BjoJ05OWR1hYaAXqrTwVbi3xZBUcJPRc3JWWuRw29qr2I06lN+xZLkKt5aPc5fqlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aesXRIBUtgBVqKpT46ya+61/FvzmggkzBKAlKkZqGs=;
 b=ApLB0Aln1Zz/KuoDRdkkHhIftEwzT88bkI/prt9EYqdpW+ShyPuSsZHnccMKtXjChbKSl+30uwrVwu195s8nii9aU0LCszIP4mAUZg4HCTiMfjoYGPox8M2rqnYldyvM+bELBYLYbvgHM4q+Wek+NbIJVWTz0GU0xcGQURvTqypjpEdh9OJlihfIwz/PcevocVQ6xyNmkebmzfhBHGMMgowa4Lk2nXPfRuYNmP2fLeOPxFt8APCP+j2dIsQ+AN43wYPCE/ptKChjSXkUrwPRUugmhVx6GA0OVqBauhZPZFoNUfWukifWVpxilTO/ZSvHZqNBI4dWKTEaviYRcc2uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aesXRIBUtgBVqKpT46ya+61/FvzmggkzBKAlKkZqGs=;
 b=DEaHWapD74renUmdW/gRBlzmi1mWfLLChKFg2E+M/FqIFvayzabnQFivuzH/ybs0lhWQF5e61BWiuyWZcPuZa0t7f3C+PFVrvZ5qCKxbVd+zAu1fuA1RHSB2QYULWgSPNK4n6c+i+i5TAViehAgOVUO2tUtkczikYQCwmhO5LF5cgImeuVezMY17MfzytoQna/BKzVT6YNZzGVvXphu/nEZdm98XVsCBiNHdL6oW1D3lyOWOlXhEBw627X6/E9uIQvGjGJzrWSLQa5H8+0FFwUlY1g8KD2uPg251Bp4T6Jt6oEMH3KlpzooSK5LqG5KhagnTY2nWYADQi0OGhtXpyA==
Received: from DS7PR03CA0040.namprd03.prod.outlook.com (2603:10b6:5:3b5::15)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 15:43:54 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::81) by DS7PR03CA0040.outlook.office365.com
 (2603:10b6:5:3b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Thu,
 5 Dec 2024 15:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:43:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:40 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:33 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 03/11] vxlan: vxlan_rcv() callees: Drop the unparsed argument
Date: Thu, 5 Dec 2024 16:40:52 +0100
Message-ID: <5ea651f4e06485ba1a84a8eb556a457c39f0dfd4.1733412063.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733412063.git.petrm@nvidia.com>
References: <cover.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 705dca1b-2aa5-4047-59c1-08dd15439f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8TB08tQayawReHVzNhMklAcOnDpW95f+tuR03B1x98bVL9fJqqZqDHMFx4x?=
 =?us-ascii?Q?CPXUStls3XreTzelnD/avhxBQGu+VXb7ooKRHaC0hiDQ5mtq0APQxdjlHg3D?=
 =?us-ascii?Q?RVFqLc8jmYzDUULjKUmdfcS4kBqsUsBROLrrb1642lxT2DCdgH0by4DVTe0H?=
 =?us-ascii?Q?MrCUEjxniU9CKk6T1yTbOQPeOL6G43lpbI3F/WxR4XhTa33/gr7v6cqtlTrF?=
 =?us-ascii?Q?Ai/LeMHVAo4/ZeukW4Sl5+HX5Jeh1kNgJRyhHgGM8RjJjExY7wguAgJGa7PX?=
 =?us-ascii?Q?qbo4LXHqxEeOgC9SHZmkBch6Xj3Lih4AcRj3Upu1TiwcdGvDDRE5GAfUc1T5?=
 =?us-ascii?Q?MVBAgmYEze4ILwKBm98mNJRx1+7SJqI0jzDf0mKjE4ghPbVYuQaokN3KXReK?=
 =?us-ascii?Q?uHbLKYZ+pl4rWUc1IDLLdwjJA4HNKqnh2/k3qFtludGmZIIx4YuNjlpVhYG+?=
 =?us-ascii?Q?6/nMSsPb1QYuHL5bH++VwjFUptxm7RQsKxN9b0xfJ2n6CtLmb1WJC+f4jysx?=
 =?us-ascii?Q?JKJlmzpvmKq+vBTaQzzZoGUsvAvBQe85te2Rl/GygpLMTSqdp9drnfM8qmL8?=
 =?us-ascii?Q?8TN91CoyS5rEJcTAAoN08TOLHUsn5acSr69vxIoQSliobFbLKlTFp6OxhOoz?=
 =?us-ascii?Q?NNdGoMlZcsSm2lGDZXAIJn5/7/mQM6n11Y6J3XvU6x9NRBHQQeeJGrS8FM1f?=
 =?us-ascii?Q?3B5DZDZfcHP8oHv+2wa2LkgzjDTb+0yXYwvAvxpQFjAIPe6BwslrbN2rnBeM?=
 =?us-ascii?Q?cic93l8EaO7XQOt1E0tmGsTZ73oz6CQfNX+zpWXNoYrPjLyyie1RdYMRtURY?=
 =?us-ascii?Q?d4kJ5xvuXDF/KLEjGAaKSCFLzMh9MLeCNNFyKz2GaYFKbZocXQbUiYHleBvt?=
 =?us-ascii?Q?dlo360S32Jh88EpiMz2VPl323w9Y47U9TQJR0AKpw+gJDZJTE5YQqKzWWYnA?=
 =?us-ascii?Q?o4ENIkbOxkhwrCbqQh5JKSpN1rDthwgSj4RHHK83sCOBs22UYng7zuQVVMF2?=
 =?us-ascii?Q?TViTk2d1p522aDtdcXl1ZdBw+HBkua0K04u83zqWJ0orPfCJifNahLlFha6H?=
 =?us-ascii?Q?ejRJ/TSa+EPpWZgfeOX2BucJNsbsVd9egfrlqdyo/Qq7Vx8C8h+kocXoHgQi?=
 =?us-ascii?Q?mbVgBEsKIlQaRn4YtGUbrTECPbMpYMuuZ00QJ8Sz0CSLPmVJaGTrACpnALKF?=
 =?us-ascii?Q?jgbHMjFLoVox7V8MaC/73j9LfsuZBQ0dXGeTM8r8MmeTc4VJMerr1r5zudlJ?=
 =?us-ascii?Q?F8+1X63mazy1kFLoHcA589DWMOgqHXBkWRpdBrLjy7+cLCkwrRPuFvWp7Om/?=
 =?us-ascii?Q?iF+Orl0sjw1cb3RZDQAtO91XLV43v4IQ+du5tGfprZhBoxlBRFJ4BdCBbJIq?=
 =?us-ascii?Q?yevzhy78c1+uReZm28BWVne+2nbFmBqbfnxDfRSbAO48DKXU0CsqbNVNfX8F?=
 =?us-ascii?Q?rtVfIYt35pHAUlxXw5S3a1Ps+C40k8Ez?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:43:53.5275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705dca1b-2aa5-4047-59c1-08dd15439f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307

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
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ff653b95a6d5..4905ed1c5e20 100644
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


