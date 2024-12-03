Return-Path: <netdev+bounces-148519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D69E1F4D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB75B16686D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6A1F12FC;
	Tue,  3 Dec 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMdsVFyX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC341DE2DE
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236434; cv=fail; b=VlAdtqG5tqntOr0rGPU7GDAYxOZP6YB+MTARqXP7D6NnLHMLq8K1KLAANh+D7CLSpcCyGJ8rH5J3OUZOR3EtjqQVEr5UExlPQSt4YGfF8dc6SyTBr0kkEBKsxABZlMlGFPU1FKvVot3GJy8pNiJINAV+q2CgQrTkDvAcK0fwvPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236434; c=relaxed/simple;
	bh=Ki34WqS/EMstIYWIphDnz6sxQu0buEjLc1aAWSgDkTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0yTchl2dl9PND5Da29D9jTNOaxpVcHjLKWZNlekMVovie+NWFuog6+a5j7lvnyi27hwfgaWha1H8Cv2Lr9mPC4GnwrhxSs3LTIpT6RG4vR3BS8uSRstJRAGX31GEUVIUvi80EWKY77Nl50kSsg+rge4iAEbgYMnHvcqkKJP+v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iMdsVFyX; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWncgZAtw8A9VGDuW7iT4AD4/1tPAMnhV5PcvDGW/0uimnD2nVeAuOHBPsyHx5/V+uChv2nxx29WZieJFaDkGrmwGaPJeEFMu/EnUYcGeD8D9r8r5YS/5D60I4xJ0i17NdcDEqYuIItBYaaz5Yp9onp4CQYnCsIFDLnZOhX3ujCTbG6Hw3EY9nvUkgHI3iaSA40Qudtp/eFYsYrYX8EaOKkHYs52ngvvYHY469mt+9nvzLYxV9W8fGhLxlkonzfQrNv5FhHZxzodUxHefP2mUSoXLD8FvXv+3HK1YS7NUNIqwX5sFdYdsvuPAYq5Vd8aiFGdALENl4j6UwRAqN+G5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG4kirMCXuWKuB+/aEVMWgu7OJOXrIZK2s+qV7ZAZBI=;
 b=Y0VKZOMIQ+kbgA2NSr1Ges3ZXz4FitWwjkvlfPOj2KUYniFvu/rTSASoXd480bVl3YzbY8lhCU7tbLL2oYVH2yTgnES+vlno1UlkqqgfLCyHXiLwktG6h5MUYojirCWFKz3cXLnFqb1hrszfYpR777ysWUX9yUcrMpnwLsCCY9qP9H2v/Y3B5TI+8cQMzfHi9NHQq3DPZedU9t6r+BNbcR7WqCEBmkbyczdhZfB+MgHUjlr5C2HxLG7BRiWneMj2VQmbwYZAsRiOzN51Gn4WcycLo+A4QiH6d4Jv9Ol6tK0fSF0k47hR491KlNo6z0QzjZf24qHhDLUNLY2SZTUafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG4kirMCXuWKuB+/aEVMWgu7OJOXrIZK2s+qV7ZAZBI=;
 b=iMdsVFyX00KPr2+gOiIz2Ttpf9+wdBRdcBP/78wD+9z/hcPZP33bNjQ0WeKWCCLF6u9PP9Z3TVLGi6F4IUA9919ezTZtfRyi7wbal5+sl5VcDaMLIzfgSrbBAkquqQdwTMJ8uG0ki/zSh5XbZO4jLw9X2pZv63DRRcLOW6WGq3QZRmWD7y6nKWZLn7I9z6UgYc2g7D7ZKRFVC5pYxXcZnCep2LxNE1wzW0L39cjpi9Lhx7x/kNR44rHeJjg90BTG3YZ2RaOujBw1CgZJeVCwaHs84o6M5pNukeTuQ/icV0MoHb9wKQx5PC8PHrmQEY00UcYnIFSWJfcq/wMDFjLbtw==
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:33:47 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::a4) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.1 via Frontend Transport; Tue, 3 Dec 2024 14:33:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:28 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:22 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 04/11] vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
Date: Tue, 3 Dec 2024 15:30:30 +0100
Message-ID: <d28c09cf04d210255882d7f370862f60e8f7fdf3.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdf0893-5449-4784-67be-08dd13a77ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7YfUxLl/d6e25TMNS/RvjcSHtdLn29hJuduXdfjZLp39J7qnoDJlu9yX0hR?=
 =?us-ascii?Q?jGR9pMkdRDPf8/9yAkC980hGMR4kuJXjuTX+G/8OgAW+pMk4zlmN+p1ifRPU?=
 =?us-ascii?Q?C1tjyZm2BF+J1jL0xkjdlHjES/hry6+jxE71ulZFhhgSzfzqNP+xWF89JsB/?=
 =?us-ascii?Q?65xVrMg/ZxIk0s+ATo2ZvZPlhOP6b6O7nTkwEwVAf/RMHE7FpKXm2OebZv+s?=
 =?us-ascii?Q?iLlYpRmFe0sIqyWiLeNfCnaE6KtVLKa3VWphP/+2zmtNMi2zjz3t0cEOb40U?=
 =?us-ascii?Q?4SbBK5ggnwJIEdH1kE81QR5t38ZLRZq+cCLy0bjfTdFd7Anoc7SN1vhWf72R?=
 =?us-ascii?Q?RBaO5PxFMk2bFFjcOHJNMLiFl39B7j4dwwmo6svSL3flSAxmuQsRbB8JK8rS?=
 =?us-ascii?Q?eeLBWmhBlYl4Wvzl3zoGEZlJAxyJgsL906IYPQro+dfseR69Nlfh+vKoqY9c?=
 =?us-ascii?Q?QzVsjV0IQAUXWLIEw50EgRYbHxyyKGhMqzUgiP1PvlEd7RQsEjPp42QaOpz5?=
 =?us-ascii?Q?ycNrbS/+0KC3M6oeUlmZ7pDvmvNp7rnCZSgEhG+g03oop20boVp4bcFTznIi?=
 =?us-ascii?Q?OKki4Z2lT/BPXv5BjvwPrSELZ0Axg8Fu+Fnl33b3i4l3motVgPJzD9quPbSu?=
 =?us-ascii?Q?AoXSUI+0bC4jY7WvLRptgI7JXOF5tPwW0gKC4Wy0JeV94JOb+PuDopn5gwG0?=
 =?us-ascii?Q?P2zkn5T6MditMmLmgDtSyeJwziCCm7o1jH+SYNC86PDVxFujyMaL6FcJx36G?=
 =?us-ascii?Q?AlhKdiSAxrjqSnVSJ5XOtiK2eRSqZtugaowOi2aWZ6ScbTsHRQsEddN4iBpq?=
 =?us-ascii?Q?MAImxewRhYRHVR/ttW1AZIntM9pGzbBJtGLXSzsNEW1F+HD5Mb2Z04vj76DK?=
 =?us-ascii?Q?WDoLKRRaNukqNXS6N+wBLWDftStlGO8sx47SHKyqP4mreIrO6J4P2fu89O0Y?=
 =?us-ascii?Q?jrEbZ72cdjqZ+AMEBsH38N7vD7ki5ryHrSnPmmZwHGqQFAcEqCYHsMKACoaH?=
 =?us-ascii?Q?Vg3zTBcBsMxLr5izGbyAMTz6U+aYl3rtafRgSARvE2b9yV5FKCEUqqvUdbmc?=
 =?us-ascii?Q?H1iFGa0Q7GC/TArGh/7Hi67L7IM29hqQ0QhQ9MfjN7u0J/tSkwlxNO+e2WB5?=
 =?us-ascii?Q?+YZQkuq5urH62Qh4V4cX7dSX/B2Yu5jbE4b52DyhzyhWUHSPX1CVQY6K6fYV?=
 =?us-ascii?Q?lHMaHMFI+8rwN+7zLmW/KzY1tB5LKEIWNG8L1l1XBHUuNp5MbI76epTS/TG0?=
 =?us-ascii?Q?KmGlAh6zOM6oHHwM05ZxJK/0HFoQ31DiqkfbkqCuNTLCVOMyhtMnOuOWYSm1?=
 =?us-ascii?Q?KYDY9yZ2AK8QiwCGhNm05p9V3KosX8qLLqFk8hM5jKhtLco1BuXGScAz3fC3?=
 =?us-ascii?Q?rsXM2dne6dlDPqLudurHbWbcQ58H0l8gUAS+TUOnBJd3W4BuwRct79FYLoZx?=
 =?us-ascii?Q?Pscow+tu43suWqGf/82fCoMnM3dzK3BE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:33:46.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdf0893-5449-4784-67be-08dd13a77ee0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

Having a named reference to the VXLAN header is more handy than having to
conjure it anew through vxlan_hdr() on every use. Add a new variable and
convert several open-coded sites.

Additionally, convert one "unparsed" use to the new variable as well. Thus
the only "unparsed" uses that remain are the flag-clearing and the header
validity check at the end.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 4905ed1c5e20..257411d1ccca 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1667,6 +1667,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
+	const struct vxlanhdr *vh;
 	struct vxlan_dev *vxlan;
 	struct vxlan_sock *vs;
 	struct vxlanhdr unparsed;
@@ -1685,11 +1686,11 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 
 	unparsed = *vxlan_hdr(skb);
+	vh = vxlan_hdr(skb);
 	/* VNI flag always required to be set */
-	if (!(unparsed.vx_flags & VXLAN_HF_VNI)) {
+	if (!(vh->vx_flags & VXLAN_HF_VNI)) {
 		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
-			   ntohl(vxlan_hdr(skb)->vx_flags),
-			   ntohl(vxlan_hdr(skb)->vx_vni));
+			   ntohl(vh->vx_flags), ntohl(vh->vx_vni));
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		/* Return non vxlan pkt */
 		goto drop;
@@ -1701,7 +1702,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (!vs)
 		goto drop;
 
-	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
+	vni = vxlan_vni(vh->vx_vni);
 
 	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
 	if (!vxlan) {
@@ -1713,7 +1714,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 * used by VXLAN extensions if explicitly requested.
 	 */
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_proto(vxlan_hdr(skb), &protocol))
+		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
 		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
-- 
2.47.0


