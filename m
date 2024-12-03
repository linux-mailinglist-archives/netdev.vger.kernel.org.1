Return-Path: <netdev+bounces-148518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123CF9E1F49
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFF8283985
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501501F7062;
	Tue,  3 Dec 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WpRIMG/I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9331F6678
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236426; cv=fail; b=tUH19rU7xCD03gbRUed0oWkuxDeu1gQT/1DIMtodZhsM4XJo5eOzEgnuXgTHO7a5sp9d9OSLcPFsgTkWi0mG+RyEoc7RpjfhEe883poExNaClxLVRFORAJxXNfjODu4sCa1wUUCuz4gV5+gh6YK2ZMwoNIuyhaIS5zFW5hBIOwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236426; c=relaxed/simple;
	bh=puIhedtgnUJxO2rEFJt0S9bD/HV0lyDPWWjXdJmYyF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kU2OWMnBWuzZOMBV3XnCVf3dJWNJOrWn44cdRIHox1VmXzalYak51lrR7E2wLB8OgZWFUA/IWHF15FdbZt6hu1TmAZevFqEdHkuaRhNDHJi4G4drguBCxppfcMwnwKRLLL8uU0Ch6yH54eGO4nHEku094Fq90sfPRr8WHrG7WZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WpRIMG/I; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+gkTFbysZSFCgLIYeC9StqCh5pD9bfqFaABiXhNB5D7hcaBc1UYvJVbsm3o/obuiHnMo1SVRWDcc+nb19EmFdjVxh9XWYAjwB6ugJpM+s1gU67rGIQ9w/A1/jo3GTCjmLBDZPLYaUVCMz6Lssdz3R8VKmvaAnuyK1yNpysW8YVLXU2rTB4Qp6klRfnTDhnLL0GY27Ics9VV9lO+Lx6QbZbNXRoDzSowIq4f3l6DPAreiRnYob9N7/O/Nd0ZNwMvAQlaAheJMRd844S9BwykJE3F9dz74+IzxbVCPP56d1u1mItlsUfKgcPPTapVFGLdugPiqwl/DahrEpAg2FFrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ore/hU3zp+Byhib/gI1Qt+HFR+rjbqwfwomGv1BF08g=;
 b=oFjnlSroqgvJdbCaWbj93g0V+tMkzOphuuuhIDtbJ9F0On/L2QT7fH/3iTtODIfxfkZIsw4gd667ZyhRMBeEio71dePgelpah4IpQjeJXDSYfMTqddQEH0kSI8PTz9XlyVN9dwqnuiVEMF6iuOFuA5DEnjyhmZacHVXsW1vey+oc4MujnOSgQ5I/4zdfIWNjFioOeAEJoO0gLuhD3aclTLY2Y/MSf/UBdXI3zKiJr2xCydq25kuLBxNzEZijMEniveBi9Q1+kb+UATMuUFk6UDeTFW+Vp3IZKRjoBSP5aGFTJ+fz2met59Jww5tfgTTwOnKbpfq0+6z5KTW4oNsETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ore/hU3zp+Byhib/gI1Qt+HFR+rjbqwfwomGv1BF08g=;
 b=WpRIMG/IfkDWXMEBas1NkJhH9CEOxL0PNtvQj6jZWXUYhbcu//VRwdywpCY/nEcuXre6ANaYXnNtMoA/micsupAWl14APb9nxD51+9m2cPf83zPZtfshecYR83RJ/Nj/kK5QNvPZb+Tg9NnOxrCx9CU71EwinZZY8Fs6u1CAvAXdwsifn09FGTHt/uuOCaidCxFfKI7C6VSe+UteRai3rpoaGuhw+3OWCe3Mr0TAkkgy/kJs4zayXLPYevbvcjzqEtV6tq46EQefjOwF3XweXF1jgV9qZkDLIP6IcKu29CdiCeVg141ZmTc5o9wo1M+LEiWQsAHYh1lj+g4EKoJu2Q==
Received: from CH5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610:1f0::16)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 14:33:40 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:1f0:cafe::e5) by CH5PR05CA0003.outlook.office365.com
 (2603:10b6:610:1f0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Tue, 3
 Dec 2024 14:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.1 via Frontend Transport; Tue, 3 Dec 2024 14:33:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:22 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:15 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 03/11] vxlan: vxlan_rcv() callees: Drop the unparsed argument
Date: Tue, 3 Dec 2024 15:30:29 +0100
Message-ID: <447beffc2adcaf8ffc6a6d066e8d9c71db3c5f8d.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: fbacca2c-49a6-4ca4-dffe-08dd13a77adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gCXE/FwY8uHyV7GjF7MmtO7scaTzQvGVrJV4n0XPPrnE8eJYiYZU1FlQ1+ca?=
 =?us-ascii?Q?82u3NSexIzZp1Gneo/321B6USIfNFqgCwhKeJ6Ym67xJNpdEHMSI7FsZpGQL?=
 =?us-ascii?Q?CMZS1MwKb5lQ5OOfXt/e0xmF99QBJBg0QPoQr5HkGXm8zAC6iiAv/nLrXXbY?=
 =?us-ascii?Q?/rXsgn01tcpArmiqxR6yY1buiXXCuNGeXHp7+NkqcEBmimypBxG+iRL0Ow+R?=
 =?us-ascii?Q?8Y/L9L1IMMkUBqAlOkamOLJeRVMtnQV0iD2gG6b09ywBYg3xL7xoVjKUfwUX?=
 =?us-ascii?Q?/5ygc0s1c9gDh5WLZdBCwfXBx8u+k3z3F1XwKeg0Jfrd/LyRbVXzLWvhO2Bb?=
 =?us-ascii?Q?lUZ/bdGSba1mhq4bZX4quVR0awyCQk2xm92fJEDC41AiRDFsgFqwQ2UsADOL?=
 =?us-ascii?Q?CFU/Lb/taQcNsDu9/0rjXNJRMA36yaTUJiXN2gBrWteXSTC0yt6ocuqqUur0?=
 =?us-ascii?Q?x4V0GCGaTOZ2Hi1IKQQmEZp3wcquep+I0/qH7vSwLRp88UkEBKBMMMcElE61?=
 =?us-ascii?Q?qXpziAFdAG+i5pahY1sWaKkt1DSM88I3NOPTe/5VYnByJfVpIe4k8RlzvKH3?=
 =?us-ascii?Q?6KIuEyX2e5LsWgWGcMbYgWLgwPZsS323CL0/dL8j6DAG6L5RAWEHdQDGDNmR?=
 =?us-ascii?Q?05CQXjiaC+I6FWGX5Yq5MzDPP03O38jIHLSsXjVOEw0Nrr5fNuvdhSpUxQfq?=
 =?us-ascii?Q?ntmlB1Sbwp0KbDv3kVnUS9wXDILy0TYoGVhFatyA9CsidMLmB3mDHoCVReWu?=
 =?us-ascii?Q?dCWZEH8XoGK62WCx26nFDo+lAaivXFlAUlwB1G/h7X0pH2l+Chb4YRrpnKPV?=
 =?us-ascii?Q?82Eo/bUXh5dJ+f8QRrlsGWLTob8UMoHcS+FotvJhYaRTuPfnM0v2IDe6DxES?=
 =?us-ascii?Q?YRaDRcHS8hx3rJRsOvgoxF4h1Sjqy0yveL4QNY1QYSvwdzVYh+QHxO9Cz6BV?=
 =?us-ascii?Q?jeu3/EVggwxystGbiVSYIrwGB1n7YOsV4mDapyBeSaARSOLBTLpBzooWLoou?=
 =?us-ascii?Q?AHTy7WJpTwWTRX7V+ncwZZrrSiOd1PP4EFyDDE7b7ZsC060Gibvet5RpuZW+?=
 =?us-ascii?Q?SxCsCHW79Qz5l4wVTYkLxj9DhzqeW33DqRaWEQArI/EVwZVuPsQFZQAwdcDd?=
 =?us-ascii?Q?siv0BNy6/KYILLEd6y/bZWX/oauGjL+Ta73MzRz5sSILbJv+9y90i5JnORiH?=
 =?us-ascii?Q?zmjlQxx+zxt+Pi50g+sGE8htyR/CUlG9hbtaataGiVsCFvPmrxVQsgD2QdNQ?=
 =?us-ascii?Q?k8q+XS1w1Hh9XKu9olzVgXX3s8aZpaH9cclWrA2+koZAW7cql46as1/yT4tP?=
 =?us-ascii?Q?bc2aVrc1wYdWqOPlGLGBkUtvqzdlQpN+vcMPaUaCIJcPP1+w0upypmH3kvUt?=
 =?us-ascii?Q?TGFbyGSh8/AIwsTeLHFaq2LuVjqfYbT3I6rcHtPqR2vgcxIqFUJuaTog3Mlv?=
 =?us-ascii?Q?3nHMROWkckR9ZOSd4McRFkJwpSHytawc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:33:39.6561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbacca2c-49a6-4ca4-dffe-08dd13a77adf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603

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


