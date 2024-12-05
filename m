Return-Path: <netdev+bounces-149441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1649E5A1A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A345616C1C3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035C21CA1C;
	Thu,  5 Dec 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upViCKvR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA6222568
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413445; cv=fail; b=Ewf1AoQ7tYYxZlIvvqwu6DI+df5Sai3vysSPJYZiufU77yLtWWVxr5Z+WQJaSQvYcMZwSEqePcdEF/daCRIXs4/zhK5qghRLKLvDOsV1Yxf+3BphXxHrCJ5ont8HIU9X/QNj9zOoHbu1IFwOb3TlRjhgQZZKggd80gACngAgTII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413445; c=relaxed/simple;
	bh=fl9ReNOQ49ijU8XnRf3AgHatzeL6YYoJ0y4O95CUc2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byAl5Htazm5h8sCaNt4N10VFKozKXYNE9ymIFh6wMK1AdsQ8VLhUQw2gF5O5pxuioT+U3f7xUvtha/ZGRf58/uNKKjGGFEvjzukY4H+fpkwoet7jJl/pgzHFdqj/dSTK5LTVvVqEDhZ4RdG7YVRuOWgawYmBPFhlDevml+m5os8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upViCKvR; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTEqReG5zhy1P1WVGGzqtQiDpqp5IcMPDyJnPULpQ1y5G6/aCHRS7/jJzhZBWZFy/QXaWJ0cnjcE55b9VKlLpeIh4RRMo7yeif6DMlMm1D4+qewVwHhQUkYBLefVHhzHVIuETqQgleTh8BELkq/eCAdt/Hy6xK8ylrNQJW5tLYxaaSSI71J3Y5ZtX+oc4ePU7hphjC30YDoyuSXgytr4vi0/5hjmObG+pk4MBudLnmRNZqg02D1MmN1Jc7MfsH/1kSi73+41bnKK3ZEUWCPkeo3gqvWdqxUUMCaG3msXgD+V6wym0RpNnLXeUrsSW26HbnBcy4P15+L5j1H71+ThTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcwhpM17a1BbHMHgsknwcWdF6ZbnNiXn27D68zYlWNM=;
 b=y/UCRybhmioICkKFpIpKCT6MungAd1bd4QmrDjBnGU+bpCLNaMWtfKGpGXLM44ezI0SF0aTBqSqScOv0Vfss/t6REgUUcP55C+5JlTiNxsnodFjUehGQZdstO1KSH/P5m0NUNqIMSd0+5tJencHZfIlEMiw/7UpZR30APuyv84iqFD3gGGgquqdNaRnPrNLGmwxJ9IEu10zx0oeudet4o3BRgbXeOfCOZPgnM2efK6Leu7ksewkugnRctEiQcXGmjVqjkHa2SkhInol8TCIqQYxeZW6iBGcFmpP/sp55EnatbRTN57y5BReAYG8apzmUN51ggTD7IUvfd3t7jlsycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcwhpM17a1BbHMHgsknwcWdF6ZbnNiXn27D68zYlWNM=;
 b=upViCKvRaZp8bEDQuIndKM1gJ2AFX3tXJQ7RfIBYvl55/n61aiLHxec2bj7Vsn5F5xE4RYaRX6AFoOzBeGCm87aXsRfPNO+mCDgcRv1+Hy5NFMxYwELDLA3QOYhqIZEg0H5U+sT0HPitV1M3FWBU0lyIiBHMaB8e6QKhE4DoHMzulj7QZsdG9VNVbv6n8xTndic2EPLHgnosiiUkmDbzbJBRSig6xVVlegHc8oeySYwHzZUQjPa7MGPLfNl+ehhroCsA7FRrJ1AwLENElF3OEIZYoFCCg/FOng/455Aw/hYN62GcvnibjYqlm4jW08qOlPkO+bTkh5HoQOJcJ6VCEQ==
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 15:43:58 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::70) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 15:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:43:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:47 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:40 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Menglong Dong <menglong8.dong@gmail.com>,
	Guillaume Nault <gnault@redhat.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 04/11] vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
Date: Thu, 5 Dec 2024 16:40:53 +0100
Message-ID: <2a0a940e883c435a0fdbcdc1d03c4858957ad00e.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff56120-55b2-43bd-6e49-08dd1543a238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQ8Zl+mdNMjGk6bMYMaEVr9gBXS7ux2bspArs7t1tLm45lVXhkoYkz2DOUNG?=
 =?us-ascii?Q?i5ZJnW6kUYGsSdmILGnRkrVXGIvhTMYvDLl3M1GXHPHPyv7zR9ANkZCfczQX?=
 =?us-ascii?Q?A+Y+akO7iC67K60G0c+luabL94rAGuQ8nduzYkPzKPHysexVzLj4x+0qwZ9o?=
 =?us-ascii?Q?UAVEVO9yA1xIHPj2RXplQWrQ1P1CLeTLCi/oA9RASx2mygjsm9dhINfEpHqJ?=
 =?us-ascii?Q?jtLcRr5tmVU/MDcYCYwDrYGL+0rxeIsy88tE8hk/wuBqTz2M82aEPBAkb1Ue?=
 =?us-ascii?Q?G7kijRXyj7ugJiNFup32qgzrXUhbx00rDtL2jV/Uao5dCJYi1V8fok9gqXoS?=
 =?us-ascii?Q?3bThKDUG3sUYpobYdCCPRu+ZmyD8s+yYckoZ+0rMFknT2zyXNic9Xl+AA5Wr?=
 =?us-ascii?Q?+WCkMCRIRMiKneifjVFp9a8PSO50n5MNTOO1crPATQUr3AtdgPVi4Xmt1ulp?=
 =?us-ascii?Q?kJF8HHrev2tfKgCrqVyBnTfDRsMycc7CK9CnfvgPTUAhomw/8A9Su3FUtize?=
 =?us-ascii?Q?hPI2GZ3DTbK0S8Tx5yHgI1iNPPaI3ovBmKqpgAH3sCqy1Cbelxir43wqXgGm?=
 =?us-ascii?Q?dk6VceAtfLdB68ImEkb1hvoH35IwCxA8+GR7HBESi3WuLvhtwdilTVuZNp9d?=
 =?us-ascii?Q?bS1lTxBLUtaa3NUhHMkirFplqpcT5w5mWI3sQONw4h6jpKEqGGQ2YIwGpHH1?=
 =?us-ascii?Q?xS0/WPt5REPvfw1eUMrhgYJR5k4vm3psQKaf59VNRp+yVbYkVTwjFFfbTjPR?=
 =?us-ascii?Q?JjijjAjEGMXi0tQmGWzUaz4ywH8CUh8/HGYZf33nLbEN3GKoSqisCLhhDBvG?=
 =?us-ascii?Q?Nh882k87bPKrW0ac5HshJ2y4FAgnFJBzCQ1AwojbcSbLGgciFopFDZafGoq0?=
 =?us-ascii?Q?qTIjTItfKbrcM6124wz6Q6YxXflDMDl2hsZxEBOd4t52cBR2M4arr/WGcyXs?=
 =?us-ascii?Q?YQu+mGuVahOQhcL/SLNka0nvRXelCgCDSL0wVcuJrSUWM5Z3t0l1HLsgkjD0?=
 =?us-ascii?Q?86fh08UHWjipMbNBl0D1cbXPsf0EHfvJn3AHFp37DnzY+N3w0eE49hPZ0ZyY?=
 =?us-ascii?Q?BDvTJD9DQyyXVvQuUVgkJpIx07GUQwrVKrPSK/be+F6OGZ5zg5Gtg4F4VYiI?=
 =?us-ascii?Q?rfYVnHCOE58vnfrKSFq7TQqE4UkOS13EfpIEM1ziduDbjVha44xZ5hYFONg4?=
 =?us-ascii?Q?Lu8mgzpupyValgPrw+aC+TMxTdJ6mwXBI4Pw0ihClWsQLJMGtfpBQItSrr0X?=
 =?us-ascii?Q?XoqnZ6JUfR6+s/JRjQUziec5K8wHNtXBMhLNUYbI5v4wAmUQgMvcdd9awtw9?=
 =?us-ascii?Q?BPZegPMwCCbmcYYzr5rtjRx/0oR+b5FnCXQHZFpB8Qi8a6fwI65dAxNiPrNj?=
 =?us-ascii?Q?WISS5T3Ae73YNW1V+UwsvSUQwMk9knkomLrqBpSp7GELp1XwCul6AUBKPt6T?=
 =?us-ascii?Q?lKHALDOhC16zG6mAiyq23D/ez7SsQ0XA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:43:58.4609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff56120-55b2-43bd-6e49-08dd1543a238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891

Having a named reference to the VXLAN header is more handy than having to
conjure it anew through vxlan_hdr() on every use. Add a new variable and
convert several open-coded sites.

Additionally, convert one "unparsed" use to the new variable as well. Thus
the only "unparsed" uses that remain are the flag-clearing and the header
validity check at the end.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---

Notes:
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


