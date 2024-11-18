Return-Path: <netdev+bounces-145916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DB9D14ED
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7431F2354A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B271BD9EE;
	Mon, 18 Nov 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPvpy0TM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBA1BD9FB
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945711; cv=fail; b=jglruJT82wGfyADOsAnscdKlYpi76TgeKQQO9GO6l6uNzVnvs45y9VWkalM8adC0zNAWBr70rqHsO/3+/FCXfUFNRTFmOPFtQ++kCGLJZhMq7AQigFZj1HYHNG9oSeLI3vofxGt4QXWGLLCJpQtQz2TCiTZX37YYQIiS6/NiTRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945711; c=relaxed/simple;
	bh=4fORPvsEbXLVZq8MRnvTMasHw+NgXKqcZO+gGA6jr2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGgBXsrVUXjapWCOchrXW0VqP0vnP5i6IKjhzZ2xKuDGjjbqg9QpZgFScPvF7+u/r0nWGP1JNIRnHjmUfTtsJxHWb0knUKOYOIjVKB8SSRgXpPX6PUlCDvgOL4RCdv4Hm4fwbXRlcpCgVKV25XDzWwjaIuVEm+bf31/fJDax65c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPvpy0TM; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9qTRFmaoECBbCiYewl/LiJbiPClLWMzMma5V/s5xYfLp46TkFQD42O/dzXNq9TEV6Nz+HtY2wdJJyqYbnbymmuXNKsGvgQBIXvc4QrmMw4wh+8IhBapvRyBJCZnsnDRSwUT017A/SbKhjMhAa6loR33O/o2H4OAnhIM9/arFPH/DZXKcS5ltiGCOE+aoj8ekohGEHDpMURbDW25mEBvLJw+5wNgkmAHm8aErtX65DTzvT91TRjrY5IBSz6dQYxj6v2rYhka5XMdcR7SK1C67ANXG0fNfTsLrCFbKrEr8PyA4ED3ROG1U1AB4i4xm5Ydj+4kTqZlvLXFnQZiTJkKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enwBRnt/sNGwgK7wLgrncBevVJiaFC/QCok+OXdBKec=;
 b=xm0d/Zf1cthnibzaEIHg20mNzX7AZJd0PwBak7+R1WnyLYPH1V7DhB5oH0pj/eWATf8hbWz/4tuMoqBJ1lOTOMfhPvw3QbynGO9HiseCg4MhB7MoZSDWZO77TYvw55ccqsXUwVOqZoAgXutjyPgCWCebKPRnYJmaeCiMvKkbvml8x16k4fWGooCkh3SI4/KfcuL17k9UEWmm3DLSeL1/nd2H9blS9qBSvsjDpa1AURziQrsrrrtnvC0HwF42yyLoQ5uz6ragU4pUtZcXyk+so/eaDeMBM6l7WM4CZZPxYHNBx+ju5seogwLuXFuAABcjaSECTsOtqmwUS9vPYbo+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enwBRnt/sNGwgK7wLgrncBevVJiaFC/QCok+OXdBKec=;
 b=oPvpy0TMbhPFCjejMpCNwzI3dGjqs90AEhcyMfPzVMciktbcW7uKUQmAC6nZlpJoFM9Sirm23HTtz/doxq55AHJrme4AwIdqkSd487C3kdft1xBYRJMxdUpl3Q52GxX8T68o1A6eX2spBU6E0TTeEWOGET2rzkVUqfykrS7thN3xJK6lNSzBRFjRFm5MyDuYb0TnR+srdUCp3JLUtoEHx2cvho224+15UkzZ5U3qniggpq7KNPf3bTF/ZFsHNNKasH0JQxWPdheOoObHd9zHM4UmDHWhHFUVz9KP2E80B/GaTWpyPfvUH71+SBxNaZALRAlxFY3jB40pp4DjwCCWEA==
Received: from CH2PR10CA0007.namprd10.prod.outlook.com (2603:10b6:610:4c::17)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:01:44 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::b6) by CH2PR10CA0007.outlook.office365.com
 (2603:10b6:610:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:01:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:14 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 02/11] vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
Date: Mon, 18 Nov 2024 17:43:08 +0100
Message-ID: <52d8bb7103a070447c0403fac5c32b8a06c9acd8.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 9634b75c-3144-4c3a-623d-08dd07ea4c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hEA9X0b0WFrj6fRlKXzehUXJBD5OLU0TP1qBWZ0j/iicUECN81+qU2efqrbI?=
 =?us-ascii?Q?wemQDlV4Jfgu/TjSy95O3P7kEUBQnoYWXBEmXD3JTTyifyFg4CFGPAQZ1C3n?=
 =?us-ascii?Q?YezFrlWdSt8E11nlygfU0c7cnmcvbcqhs5hzvTQPzMQkdwfmBHfoxQ+CPyy/?=
 =?us-ascii?Q?4chFVhInZ3kiooiToARRtVEwRIBGUp8f2/Gnzk/RTWok6ljIXE0AM998ecf1?=
 =?us-ascii?Q?SarSb3r/FTBHKP6rUX/DlPDVpimV9kWsmPivAtPDwna2ZUCOAYAUhVKbD/PB?=
 =?us-ascii?Q?rgYCb+tDis9zxBG5IAK822LTaFFQ7GRGZK+Gu5V8qJhGx7bArFwBU3TCmBOF?=
 =?us-ascii?Q?4asknK+bww1bGP4I2gVwBIg+ktBZZ3Eva0QgQjitK3eZiWpTOF5++QS6IEdj?=
 =?us-ascii?Q?Z+lBmpISHXxuLuzuuS17SIcLyX4FZWJ9MFy+XZywqagEKVnztJ0rcglD25nJ?=
 =?us-ascii?Q?W1hFyRkzIk32kwBH64FM5oGRvSzyItYI94jHrYMY6q/cbS5Z8i0K3+KzpDjM?=
 =?us-ascii?Q?aw1jQyOmoQY4QNeLermmUC2IOA/5dPh9y/MresH0Ljk1QnMkI0RLMnPYTc54?=
 =?us-ascii?Q?5xwYyyIPRBc781DnwFZYiFKgEAKgAbg4FESYYisXhmdYh5f6r/TDXOdSWp+k?=
 =?us-ascii?Q?GHWWpILne+VxI1guCzsXhEPH8T+uAdh7RS8vI/yHH2Msc2FOkXMbMpuTZLub?=
 =?us-ascii?Q?Halv6D5gqd//Tt2HPgWe6/ptbreFFrPrXoWre3GtIDUUdy7oRlZ0V7f75eXv?=
 =?us-ascii?Q?bXwbIMHi0ptTh2PJi5Me/WBZe+4KbvUBqxZGfNwtpFv3jsGr2N7m1EqTluxN?=
 =?us-ascii?Q?1YmzxTOX5yQ3LCq6iO3J325GuILDYmUCz9/QsEUfhwv4+qRdpuwoHDS8s16/?=
 =?us-ascii?Q?WDKB7oMmn8wzVidNe041WyglaoO/VarT2Z6IE8syA890CwPjyO79ihajSkHG?=
 =?us-ascii?Q?T0KJC0TNZ4DrxkJhrznT1I9AQjaWZ7c58V8ODnuShC1uWB8S+72qjrZ8pBVz?=
 =?us-ascii?Q?AlgovU74Om3ydhb+hM3SoD3BuOQkYIKOv6fTWHmnmUWmJGqrrMXWgX7CsYJz?=
 =?us-ascii?Q?ZQMAfi/UEiXepr2iBGwKUxQ7Wj04bD0t5Vm07kkAoh0pSYGxSeZBD9PSIN5O?=
 =?us-ascii?Q?y7YCQUqE1yxyDHtYKjxB3hVCiqZBIGN7s8oGu/gqAZDnwVN+Su/L4FTSmbQj?=
 =?us-ascii?Q?2xtHohQcsrWA01YJbh70GJz0P6qvX9FjXPcFpZAVNf8WgsMcc/h21ZtObYfa?=
 =?us-ascii?Q?NTIENZYc2+Z5lFjEOCcPG/H3ogW9YXoO1BkPHIaZXGvGU7ToZrCiyFVS5xTB?=
 =?us-ascii?Q?oxnRmzVe+/8X2DkvwPhpRlMUkhp64lX/kxfyd3VD+wZGOd7zrKhZqxXea+xs?=
 =?us-ascii?Q?FFBsOzDLRmsqwC2Ldem2GkKfRp3nGQGHKFcMRhKptwY/C12l/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:01:43.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9634b75c-3144-4c3a-623d-08dd07ea4c37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352

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
index 071d82a0e9f3..1095d0bb2bf9 100644
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


