Return-Path: <netdev+bounces-231063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2B9BF4496
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA8CB3518A3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E18246762;
	Tue, 21 Oct 2025 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oriXvq3J"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289E19CC28
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010876; cv=fail; b=TJJzM/MgZAYYlqE4meWxfLILpNyUVDOEC/NMcIQ8Nh9NCjS6yx8dwoctAnAJ3IP179d0NFgQGVHRdDy8hgo7X1wNQMHgkrYV4CC1p0AU8kMUSEyYxCy3fKPut6L6Lnv1ZC4BZFdyRC3pnqtZrpmtFOkDXdPnFNBXs6AP6MpaOnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010876; c=relaxed/simple;
	bh=MumOO+xkm0h3w4WG4Enjjsnf7V1ecIeRXZc/mMEkrN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GH1MlwVT+Gq1HL6LnhFSF2FBpQWeWMX1MlGm2082SKbqY2FD9tlIbVuJdWBz1WpddJ7a3jJPHeMZzpF2KQMLUU1LRf4Fz3JjncdIgQlpTg9LoI0/xJDhLecwf+2DI08uE2GVsbTsMP7ylkmMwEmGNYUPMhvYE7rp44Ew60yZQoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oriXvq3J; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXje75Og7IqwE7NWh04cNLyGgA7YGuzy2qv9CubGBjAbbfjEvAbdbDWqlcibd5A8HH+RSDRQXqyNhIVjtLb6MV1O16ByY0fd2Zw5y/eNZXFakfnTAKYS5jMtMaKLyznbgioPVRkGvbL6TA+mPxZTHtOGOWlVccC+X89F1rF3yJwGJJLaNI51e3hIifwjuTugHu9If7/OvTzbqLRG2t/TqNU/UEoBbireOWj69D3JkVAyw28Lw0xM6Usz6OqnfmVFyeyFqd5ibiVJkTxT6vc8Un3xXeubXzVjjbJBJMIRHDrFayds66jDFrs89kRhkyfcFztIuCDRsPaXKHMg6BKw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REsVYmWH0dwD4nnWaT5fedWNRmslgL1Ps2pUp82YoSk=;
 b=PCurcnWDC7Tt2UNTCoDyOQwS7x+OkBuB79FOpCAEErXqPovqyqISWmZ0eMs+zP0Oq8gZyG0km7mZTqZbZw1KKSCYxcgJ3C6voccvPnlle/doe5qKkX1rVaccB5ySoBb7kNTkCSuhB8DSSndlbFm422p7J/fQh7yicfynCSX4sMIWCKZ8qTIkrFMYVUD72ErjAc72Vbz9+aOB870H3Un9zD08rYvqRpVydhhZLU5fnj/a87F7llT7OG1da4Dl3PM2xRPiQIGiK62RBbEKFqiVW3QXgflVkI6OpIUJPWGpVk+TuQGcp/CPAiMIGRWVNKOmCsg7DLbZdq4QHmTG8V/c1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REsVYmWH0dwD4nnWaT5fedWNRmslgL1Ps2pUp82YoSk=;
 b=oriXvq3JSkvqoOpD8NX5SNrRVXi3QbASvIRfa6SbZjAaguNRMrLA98YCPKNwowgs8eKw4ncmYlwLixZoDZ16GtZW1GvCIh+NeHz1LWp/yCVwGXjoIqnXOwJYitMXv6sfPpLbn0zB3N/nrcDeaGeRikfWC7fsQe6mJ3qiEZv2VQfOa/VW+LXbINQ862BEBUZgIsM1lNDK9vrzkeJnT1EAa4OKEOPqWt1wmZXkmH+xGQpLR4/W1IInFZfLfUyAMupKb50o4VTLy2Mfa2JOe0gmoTwFKJbJCiLInSCagvDxf7vZquRyiEl9sO+ME8exkD/0xPAjsu+XvEo+QVn5HOY4HQ==
Received: from DM6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:5:15b::19)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 01:41:05 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:15b:cafe::34) by DM6PR18CA0006.outlook.office365.com
 (2603:10b6:5:15b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 01:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 01:41:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 20 Oct
 2025 18:40:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Oct
 2025 18:40:51 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 18:40:48 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next 1/2] xfrm: Refactor xfrm_input lock to reduce contention with RSS
Date: Tue, 21 Oct 2025 04:35:42 +0300
Message-ID: <20251021014016.4673-2-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251021014016.4673-1-jianbol@nvidia.com>
References: <20251021014016.4673-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d4f5fb-a4ea-418e-3698-08de1042e628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmzkKmzMPUHO+vYdyz1OEGp7Gt0jXwNA3TdYlcQRE6hY+R6wy5N35ht+JYSW?=
 =?us-ascii?Q?a0BQShWqOPkKyQc17Y8GYRAqILjSx2vA3z+XFLqMvoPSXLmxWaqp3hwhHmhK?=
 =?us-ascii?Q?fylSVgDCvlgxrYqIWo7suMtz+NQ/leLnjuQfHPyGYBBgDuY9mGYg5GGfqhXG?=
 =?us-ascii?Q?WSGZMu2GkDUOtg7vI708Yx9wpY8SXPJjIRRMZX/kPWyo15I9yueribBdKQNN?=
 =?us-ascii?Q?p/GF2uZs2HtCx3fCRTBJwRbL51PuDb+VBbAD2jvdyGTr9RMdCHr2hX4kOjyS?=
 =?us-ascii?Q?QrZabRIs4An8wJb/himIy8PVozaHZuAe/uhPPoFkdDdO8NUL3YauU5BYc0Ht?=
 =?us-ascii?Q?ry0kPLyvZd3H+0uuYh5cOf8QR4flrCyLqfiXRQKbBdM/xyISRbQ7hrPDrfdP?=
 =?us-ascii?Q?Su45pyBQbQTQabvxhoOadMddPvXEhHsRmcYioUDn4dXuk5uFtp1O9gaOD7mu?=
 =?us-ascii?Q?cMb/qE25CUdrsnzj8Xwrf2o7dwYZQMg/1nyFqaFfve79l8QfkQjnlHa6Tx/c?=
 =?us-ascii?Q?OmQMtUoB2dUvccRvDa+rl+S2lXRwq9yaYsqleCXtJsqrTJniFGGuRLQ+STV6?=
 =?us-ascii?Q?6IDJpH9XRdNWMVB+annhO+BA367USmE43kJNsPja20D+VkvMXaIXupMSzAhm?=
 =?us-ascii?Q?Fpo3zq5/FxlrBRitOma51jA4AQBEQtcts1+ZS/LqLt7XnwHNqRmLmlbzTSu2?=
 =?us-ascii?Q?nDRjJ/MboAotkn6zmyphG7Qg1tJIVnyQGhRa0OKnE7BOPAogeBPI/VpLsGcB?=
 =?us-ascii?Q?+WwDIf8uflpCh2bQfoBE4qi7kIvH6h2Y2oLyHnNvlyrqydCsGxp7he7P4vGY?=
 =?us-ascii?Q?Wk2K4/LXISO330vujOp7L44tI4nUJwMGcoZmXunlBkhZ5SuKeoqH0PNHADHr?=
 =?us-ascii?Q?ma78LoZpvrKMTdhHeFlclxlfpWLAupzX8HQc4x+nYn/DcX6Zk8xXI6SGMzpG?=
 =?us-ascii?Q?m+EBn6Lb2dAlo9by1MPizvR0ed3qYrK1WmsV1M+wzBxsf/pn7+E+bPBrhXv2?=
 =?us-ascii?Q?JiZOqmhhrqhNXg5naZwRoz7Rft1qMOARLyjkXtgNLbeh4YqZEPe0QZ7MrrRq?=
 =?us-ascii?Q?Y2rUS8gyXrJUTPROcamOhTe+8LOeuVB+OUE0sTFn0VIUU/2dhhs0Q2wLDfjw?=
 =?us-ascii?Q?KHdE8XFh3gGx5V5n6lZ7XyOmcHedz8ENE0kzjnQYkqzakPBxsqBw4V4zovZA?=
 =?us-ascii?Q?pGjJsFo3zfMwNvHpMvQe4KtzWM0qEK/tAdQ/4suuZyIEQNAXXc4ynl0+g+mO?=
 =?us-ascii?Q?k3yB8x2kqHZYxjlRBGmvS34TGeM862wqFRdY/kGHyoRWRI0yXH7jenEqo8x6?=
 =?us-ascii?Q?kxQTClUtt0UtKtemmX3xGCS8colEZ2HXu9g/HtUkxMLhD2VdOHu3FsL61qmS?=
 =?us-ascii?Q?6M0509geVqF0JyPIsql9z5cVmhhc3WV/DnIcJSE9RIRbmtjyyZhDdvLrXJwu?=
 =?us-ascii?Q?JJhO7YwoAv+S1DbJCabm6vG8qxiClO353esCGD3uYq4FSAF+ONbXNcv13LOA?=
 =?us-ascii?Q?GEn5MDh8DtUdbUHpd2gRATnsoyQ6dIht6iDb8muTnHPG3hFDH22pmIGGrRDL?=
 =?us-ascii?Q?gqv+517L+2GMy0fiRSA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:41:04.6895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d4f5fb-a4ea-418e-3698-08de1042e628
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269

With newer NICs like mlx5 supporting RSS for IPsec crypto offload,
packets for a single Security Association (SA) are scattered across
multiple CPU cores for parallel processing. The xfrm_state spinlock
(x->lock) is held for each packet during xfrm processing.

When multiple connections or flows share the same SA, this parallelism
causes high lock contention on x->lock, creating a performance
bottleneck and limiting scalability.

The original xfrm_input() function exacerbated this issue by releasing
and immediately re-acquiring x->lock. For hardware crypto offload
paths, this unlock/relock sequence is unnecessary and introduces
significant overhead. This patch refactors the function to relocate
the type_offload->input_tail call for the offload path, performing all
necessary work while continuously holding the lock. This reordering is
safe, since packets which don't pass the checks below will still fail
them with the new code.

Performance testing with iperf using multiple parallel streams over a
single IPsec SA shows significant improvement in throughput as the
number of queues (and thus CPU cores) increases:

+-----------+---------------+--------------+-----------------+
| RX queues | Before (Gbps) | After (Gbps) | Improvement (%) |
+-----------+---------------+--------------+-----------------+
|         2 |          32.3 |         34.4 |             6.5 |
|         4 |          34.4 |         40.0 |            16.3 |
|         6 |          24.5 |         38.3 |            56.3 |
|         8 |          23.1 |         38.3 |            65.8 |
|        12 |          18.1 |         29.9 |            65.2 |
|        16 |          16.0 |         25.2 |            57.5 |
+-----------+---------------+--------------+-----------------+

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/xfrm/xfrm_input.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index c9ddef869aa5..257935cbd221 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -505,6 +505,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			async = 1;
 			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
+			spin_lock(&x->lock);
 			goto resume;
 		}
 		/* GRO call */
@@ -541,6 +542,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
 				goto drop;
 			}
+
+			nexthdr = x->type_offload->input_tail(x, skb);
 		}
 
 		goto lock;
@@ -638,11 +641,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop_unlock;
 		}
 
-		spin_unlock(&x->lock);
-
 		if (xfrm_tunnel_check(skb, x, family)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
-			goto drop;
+			goto drop_unlock;
 		}
 
 		seq_hi = htonl(xfrm_replay_seqhi(x, seq));
@@ -650,9 +651,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		if (crypto_done) {
-			nexthdr = x->type_offload->input_tail(x, skb);
-		} else {
+		if (!crypto_done) {
+			spin_unlock(&x->lock);
 			dev_hold(skb->dev);
 
 			nexthdr = x->type->input(x, skb);
@@ -660,9 +660,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				return 0;
 
 			dev_put(skb->dev);
+			spin_lock(&x->lock);
 		}
 resume:
-		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
 				xfrm_audit_state_icvfail(x, skb,
-- 
2.49.0


