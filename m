Return-Path: <netdev+bounces-148517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4469E1F47
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC97F28372B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098B1F7065;
	Tue,  3 Dec 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NH9IxxRe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49051F666D
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236423; cv=fail; b=MVlp2ftWwkGejvicn/M+zbXphWJRF0Bzxw+dwcUgeD4pyRqeUT8K+GuWjeODY0jbqg2J8lWVZnv8o49fuy/MVIn6k/ohWYtpL0unDQYDT6t1s/qfTMjHetxKn/f5mG9QoVtsuZqgRu5zKXiayomePAcfXBP7gVQXWIrJrKs+OMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236423; c=relaxed/simple;
	bh=4GQJIgOr+jH+qEZ9ZRA7gqMi8p4z+BPjtrbe0NQqaZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRcJEJ+vS7jvOO3OvnTatQho/hdxjvQbQy/xNIezXDi3ZpXcNrKmbo3qtZdf6xMnOq59Ckb7iUC/rsyYGKtht3EFHuDOfu01LHKdp9R8rHLY10MDdZ3VTbZq+1294S/fvtLzowdqbG+Rm+QuTSGQjE98vabBc7d0au27AqESBR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NH9IxxRe; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyWm2q6ZP7LhT3/3nLLjbzD6IgI3bACl5ypaqqY0vAOPSBbCQSLWRmj0HvUsgGtI2tLm1gBVRiIcw3/LN43eshF1fg/JOpdi5BkFm+yTgE76xV1437qj6CvQuww/9ud7Ytc/vOTbfRuiP8nszbtVTHW1PiZgofDEySSZV2Ya4eL5nLGB0Ki2WJ6P821/IdiSLZs7Xwlkui91MO0HaeQqLZLXE0Bp2c9i9uGf76zCGAvOyLrlu0aFcEhqOKYL7nhSXPBxcjg5xfqX02XUIG0p9OeqxHew5p+Vw3O1frTYFw6XbEkVX6HKSNMDKucK13h/5g0KuaIEzoXQO6kDXBVKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtiXRJGrc+4Q43BPC3VbY3lGq+9yXd3YB1cIMyWnEKY=;
 b=fODcmZ5p6DYbQMPrITKN/atOCikBe9jV86RcsHdrXGpXonLNzlMG6eJQkVdVgp4Afx9vEpLWfbtB0gjaaeItHfYuqSqDzXaHHy0tLkGgswE8he/xry5srEH9761FWLYQlTewCPd35R3gv4moDN1yuUlT2lz8NO4N61Fes1oJ4uqWRst8QXLZygZJ3502owCqTp1nGAJ0416GxZIEq1KG3IinsG6XgfuVGolSUWPEeLaQ128L3c5sbGf+bd0X40modIPIqTiajqGhq3eCvrnH46DZ3R6iB2ivgcesYMzw6niQk4sXaB0GFPHH/A1zgc32W1hMfRAHDVsEC9blg+qxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtiXRJGrc+4Q43BPC3VbY3lGq+9yXd3YB1cIMyWnEKY=;
 b=NH9IxxRejQSLeCDUEaeRvfMyQuySMzRYhFHIQKmhHz6bXEK0yy0TrByQFS/FQhGBOR0RFdNGKiYEFhHXsqxdtUPcnUw7YNZiHJCBGixuUCnbYUW8qz5wOQf1zGwgxljPtlEdqKT8NwZ+uv/PsgF6oMCemP8Mxkd/DoudgMoMsfsXb8B11cfyIdHjDbfH0KyVYYXP3SBHIxL7ujvzHbOYmDVN8F4/00oZ+PpqgmhKXRJ2RK5jotTZxI/VDTLxUNYpIZHiNJupheuhMJYaefJ6ZuNxXzZaqKDfPkoEqbdGc1H8380O4L2zspLxi0G0LXg9nsFd6UrpGXLe6a1gEPlCaA==
Received: from MW4PR03CA0219.namprd03.prod.outlook.com (2603:10b6:303:b9::14)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 3 Dec
 2024 14:33:35 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::22) by MW4PR03CA0219.outlook.office365.com
 (2603:10b6:303:b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:33:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:15 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 02/11] vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
Date: Tue, 3 Dec 2024 15:30:28 +0100
Message-ID: <4954b8bb05480aa5ac8fc4a417a196e18c2a0dfa.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: a33ca949-05f9-4c24-9425-08dd13a777f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7uV/aMXhgxhk48srWf+l0sWeHKmB7f5ppSmbzBzHyMw6XZRModet0zGlwBVb?=
 =?us-ascii?Q?SBxi2qTIGMI2IoXPCAh6p+StwUdhWJ78kLhgkhtKTa0HCPm5dZK1vMQNbkuF?=
 =?us-ascii?Q?2u0Ki9UAn9R3OeXmLPFhxJzGZ3COMUUw0iPQXSkTn2Mg0cFxlNQy55Qe/VJC?=
 =?us-ascii?Q?T43rgppSKv3ikUb1YU4/Rd5yEjc71SOi07BPeheaDWK0pVALZx+tJRmmRtS/?=
 =?us-ascii?Q?plr/2outMKV8R/K2pcjpV7Xk0IrxT9NUhvgWpBIu2f9E2eBzOfFnrlLKT0KC?=
 =?us-ascii?Q?7eg6zDX+K6/+Rz6DxJhosheWrl+rkQHanpnu65kjY/v6urhqAKcsvgH04K/U?=
 =?us-ascii?Q?3yPfdhBJ+CtgOE6jdLPxfKy/lfEnY3l2LKI0UyCNgqsKWlf1XlX1i81dG2Uc?=
 =?us-ascii?Q?5tla9nielpn6r17Ap6eb/ddVz0I1VKnSGY2FurxpFC6pOaxdJRfyflUGHQh8?=
 =?us-ascii?Q?vDR1+gfrl7xtDN+E3DDhjBN6iuK6qbIfI12bHdTNtXhS2fVRoZ0fossNQ1TU?=
 =?us-ascii?Q?mwiW+i4ImwzutCOVYksAAJzqQHz7YLvPnZI9IqijAnSlucdZrGwi7uYv9R/6?=
 =?us-ascii?Q?+I928a3Bi9vHFtpX/x2DvzWFCEJc/xdhmswhROfc3avq4BseIdBIIeVADEm9?=
 =?us-ascii?Q?7lQHxXWLV1XL3K2+fkUkl4qDVfSeetAeYbX9yCIAYz3GlxK6RGlq1UiTUyxN?=
 =?us-ascii?Q?KGt396Laox6OuKd8f7ABkN+Og4UesomPRc7KJTgxivrSdrLV3fvsIKXgKqzL?=
 =?us-ascii?Q?Ja5++j02KycoTleeQLgBO8+Ee43Ej4eDiJ7UsSslaEfoxV7Z0Kxsc7Ut0F8o?=
 =?us-ascii?Q?vCq4XkxfbUlPy7KyRWjGJMHrNEQ2tHNw4UeR176S2rQojJIY3283tkod1n41?=
 =?us-ascii?Q?xCVZuGQ0V4Au2Ik1qKBT6aqwrsCq/mpepDS/ZRrAofefnEJWAWganZoiC6Yg?=
 =?us-ascii?Q?93xscqghip33n5tGymmOURBRFxMP0LP9GZyEj0BPUtcvobtfHLi33NDVehv5?=
 =?us-ascii?Q?Kqt5B8AXYYhiU9gDXCe9QGLBwnMUBFFZlPbMzfm0cotKLt0VnaAGTDRAwi5+?=
 =?us-ascii?Q?LQoJGu4Oiezxv4YgYqQ2AtfaixvbVYlkONRB0VeulJP91XKh9KOelT1QcRZq?=
 =?us-ascii?Q?96oafYWzeixFZW74YBGNm/nh9yxcm0owBaYAKDUQZpd03vXxYkprLfMwEceF?=
 =?us-ascii?Q?IUBjgzKTHGKmbYakO5FFDJLTI2raNomueQUPdtKxaPOjkU9Y589niEJ7eeBj?=
 =?us-ascii?Q?XU0xhhGs60PgD27uVsvxLQBQfbUcAouH7QW6tuN0fdoA4LarBgfDQbluoLVb?=
 =?us-ascii?Q?ZB6HxMLP+x321GJLmd/LZisTHAJHXzBsGGvtDru9NbwUqdlauGj9esNbsX8V?=
 =?us-ascii?Q?IU5/oMCSn9KKDwXq7eIQAgqMAWKq15k9McrzjtEnBRjygR5RGhuNTpEXwulo?=
 =?us-ascii?Q?HLMR8gEDTaInFiD4fNriFZfDW8Q3Jmy8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:33:34.8811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33ca949-05f9-4c24-9425-08dd13a777f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

In order to migrate away from the use of unparsed to detect invalid flags,
move all the code that actually clears the flags from callees directly to
vxlan_rcv().

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d07d86ac1f03..ff653b95a6d5 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1562,7 +1562,7 @@ static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
 	size_t start, offset;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
-		goto out;
+		return SKB_NOT_DROPPED_YET;
 
 	start = vxlan_rco_start(unparsed->vx_vni);
 	offset = start + vxlan_rco_offset(unparsed->vx_vni);
@@ -1573,10 +1573,6 @@ static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
 
 	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
 			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
-out:
-	unparsed->vx_flags &= ~VXLAN_HF_RCO;
-	unparsed->vx_vni &= VXLAN_VNI_MASK;
-
 	return SKB_NOT_DROPPED_YET;
 }
 
@@ -1588,7 +1584,7 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	struct metadata_dst *tun_dst;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_GBP))
-		goto out;
+		return;
 
 	md->gbp = ntohs(gbp->policy_id);
 
@@ -1607,8 +1603,6 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	/* In flow-based mode, GBP is carried in dst_metadata */
 	if (!(vxflags & VXLAN_F_COLLECT_METADATA))
 		skb->mark = md->gbp;
-out:
-	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
 static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
@@ -1734,6 +1728,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = vxlan_remcsum(&unparsed, skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
+		unparsed.vx_flags &= ~VXLAN_HF_RCO;
+		unparsed.vx_vni &= VXLAN_VNI_MASK;
 	}
 
 	if (vxlan_collect_metadata(vs)) {
@@ -1756,8 +1752,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP)
+	if (vxlan->cfg.flags & VXLAN_F_GBP) {
 		vxlan_parse_gbp_hdr(&unparsed, skb, vxlan->cfg.flags, md);
+		unparsed.vx_flags &= ~VXLAN_GBP_USED_BITS;
+	}
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
-- 
2.47.0


