Return-Path: <netdev+bounces-149438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D16D9E5A14
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAB816D17B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2F221457;
	Thu,  5 Dec 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tv7W9sEo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0F221442
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413432; cv=fail; b=iNLz43A34MaZM4MCQRa1GzAYEbRHQPex4tk57EDMc32H6j7OsANYsPi6xq8kPG3m72f8gaAuV9PC6ZOs/YYoCN2IbXwhzt8zjNtqUg9kY29+dtamHOY9xuBIKSL+PdXYOiklulWU6ZMkK3HLHP0/0HpJuSD4HasyD8P7GQBtS0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413432; c=relaxed/simple;
	bh=l/hGMYxsV1+BQfKDPlXhHpfYVA2Zu60ZsNLIFrxMJX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfCW4IrgYyWHZC0vXAIA9nKCoR1CWk5A8ePaLjF8hgppKjRP0Zlb38lmxcmWYXydxlkO7f3CKEXhwX/viVG+W4CmsJcNlTzx3zcyEAPlCHjasaKXivNOC8OB5XzHFFoIJU04gVZA17xDgpcdU7QKhlKpIgkP/Nc58HEJLbauJvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tv7W9sEo; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaGpe/i4pMECYMGwT9ofYwoWMcNKOS+hEJ1A35eMnGuP8uJq1HwFoeSFN7uQEXXkd2WozI7GlWfIm/GzzK1+PelqhnmH+4Q8CkWf+U73Qa+rOAhPVIBdlx2nj83ldJYK8V4Ha13KL9k0gom0ubhq9hWeChH3q5NYhNY+qW7JECV12OyyHXI0Gj17cLEr9lSspRLac6rdfSeQbV7BY99xdK2W7a5l+VRCHqC6WRsKZHS/5Aji/RAdkBRRYCBE0vlCGjS+vCEgaF4pAAgp15uVbDa3d5ORiQAB1Eq5LArhhEMoKLqueJNF129sr9NFCjBE+tbsgnz3zss5uAc5RMzKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW/GRYfLFfomW7u06CId1bfH0ejF+qNwWhOq5l+KzwE=;
 b=t7PLjpsCqGxWDU+NnEUG3wXptU5/uR0KoddvvakgvO+aQVySyumxLz3LjylWC+4QKne28+kfKJK8Uw8f6HAufGmYWXX1Tot9vrMA0ITlc0NZiV03AOdf+7VafRtomgMSTccOBgpDi2EbTrwgvB5GGG8CTOVsgZBXuy8/hBQVDMY1TDzpSKHyuNWSMuhA7gjyLPOKtn0iaGe4bwSWi8IzWyK9m4V0l3EGct6YXi1zkRILVpEjNnpKpMeRLPjB61y6NAwpAQoKzMOI49tcaU9e3ghAFRTOTsZLQ/iSUA+AAMGRDJJkuaA685SnIQKWCIH8Vr/N/ovVTvc7T3MyUqh/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW/GRYfLFfomW7u06CId1bfH0ejF+qNwWhOq5l+KzwE=;
 b=tv7W9sEom3qTHlzjIBFLUW1vvKtBPFsYGAOwrp1oqbIVPdu5jjT2pynVsexqaQlo3T3h50YhheupjAVo9eCKfXtyDjgTSuNUlqFy9qlOrFODFRd4V145GIxt00bPTLCBQxTs51zPQeuyiOrg7VMu1HjSYpWSW3teUsmfkJIxF2BqDUCbeiSRt3EP89T2O5UWg/lWlus/P4TzeGiBV7JEz+MUvneZuytV1xYzCHlX1Np3HcB17IC+3ofi4YWw2WFlvOiSGDPXiwA09eYZNbmXhpqvEkLBwraesaDX7L/Nk3F5qq2WX/vW3LtDel3YQuc+8eXTteFfoDsaHdRB1cLYeQ==
Received: from DM6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:5:bc::42) by
 DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Thu, 5 Dec 2024 15:43:41 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::ca) by DM6PR13CA0029.outlook.office365.com
 (2603:10b6:5:bc::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Thu,
 5 Dec 2024 15:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:43:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:26 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:20 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 01/11] vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
Date: Thu, 5 Dec 2024 16:40:50 +0100
Message-ID: <5d237ffd731055e524d7b7c436de43358d8743d2.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dde673-1a1f-4c61-7dd0-08dd154397e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FeMhSmeF02TvsWwFVLm58wuHmmemyjwc3aBDAsvJm52YF53LtXt92dDk4Gtp?=
 =?us-ascii?Q?nPcQhGUv+oxe+ryapOT786h/J92GLQXj7KDLQPewtkydJidJqxd25+fFM39Q?=
 =?us-ascii?Q?KMhR5nbpk6/ODTbhIz0oWw4KviEWxZWX+IOcNZfMCXh3gZa+kZPq3qrQ6Hwo?=
 =?us-ascii?Q?MZ2UJygMBnKcBUmMxKxpo4T/eSkRmur04hM68U78p/WYJVutf/HpsWQwlsn3?=
 =?us-ascii?Q?zSNnnEiBZZK94gOa+C0ou1VdNYR0m5ksnfVi03i5xY/W/NRgenn9FaktO3r/?=
 =?us-ascii?Q?KYnwD/3eMBRWozSmHWRz7jARu+OWrjfDOMj96NOcBWAlsZb6YxaFXv4yu4Wv?=
 =?us-ascii?Q?x0t8in6a/ACqUyU7Il2EYHTAVzxfz8b7oHWIjY4HmYkqQM2XVIKzoAQSxP2p?=
 =?us-ascii?Q?uSKsDe9ppHWYRNP33rMnBUwd0X0Lwh1uoE3DoCP/TAa8vA1Q6juGoiBSnbXg?=
 =?us-ascii?Q?fTqWb4QiGng7B0SgYW5PpqVTw/asz+35dyDEe4914LaNqmDVIxXMVKOVaYzY?=
 =?us-ascii?Q?Ee7h7Ha3WC3I7kbTJTpRN/lJOyXSczNtYu+1LJB/zhzRxSk/k8jUFic9NtcA?=
 =?us-ascii?Q?VuLTyCmvgyZ+pgxHobzeAppc6LQ6VsbNCpmstuFSZuVuJxFqqEWqxn0/pqfY?=
 =?us-ascii?Q?C/L/x1CuOwYZqIh2tZNFBusycZDon3kLkIy6k3DJSM7zmKZGSBKiPBASoT01?=
 =?us-ascii?Q?eXD3Kn/lsTW+lQucLMNA2KCfesOaq++Z++ju+59o4kIXNhWnYyHFv6VOL+gs?=
 =?us-ascii?Q?iB21IV4fR+QF/ORodzwpNfA0Rmyff0Bq/o1ifSjUKRJssbe+ZlMhQkwoaXO6?=
 =?us-ascii?Q?VEtn8nO/SD6D4IqS/F/LxwmtJ5awgcllxBDJPZhSrtsbDf2EWb0SIRrbOY8v?=
 =?us-ascii?Q?qP4aMfxZk9b/iOV+1Fwk9lMGKQKLkSVKSS9y0aJT2TadVUW+UflOnefzH3VU?=
 =?us-ascii?Q?iVUAIGAxSR3GsvDNVBOd/3t/o9AKXJPWTYyOkmIdipWqzvRCs1/xBRMeLpIK?=
 =?us-ascii?Q?GNPNuBspO78sLq9qlA6ZYf6QfDpfTV3vRMKn0N1EeITE89F0yiX0IBfYH80g?=
 =?us-ascii?Q?nOriN5m7mVuzE9AgizTokVvenRa7L4tq30AOm/k64Gh+PANi2r8Pm1r9i9st?=
 =?us-ascii?Q?rOEI+pJK5O6OqfpYhR8CgWWjywfK0sm78YoGZJVr+dAZFNw0FUVRLkilITVH?=
 =?us-ascii?Q?+H+fwCD99bnmKXsE26XR5dYb9MGb15otKyo8fha+EBfGlARh1FX0m3zsQ1FE?=
 =?us-ascii?Q?DTxwtcU7/o7C5SZIVjDd377UZO2OH/PlbdLRY9ihdCo4qKKH+SvyGHx/w1va?=
 =?us-ascii?Q?ZCYBWE59ua1BxKTlyTjpZf5B12KEsHrDrbfZUBG2qJhBjnIgXr3ttz4W30X2?=
 =?us-ascii?Q?rpsVvlsmph178jXT/9schoZswx0mgoSC7FpA+QiPINxcfWxwg9cMq+Q0nVC9?=
 =?us-ascii?Q?HvsokNvNGf6jH6EhHxpes9Hi60Nppxqa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:43:41.0242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dde673-1a1f-4c61-7dd0-08dd154397e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

vxlan_sock.flags is constructed from vxlan_dev.cfg.flags, as the subset of
flags (named VXLAN_F_RCV_FLAGS) that is important from the point of view of
socket sharing. Attempts to reconfigure these flags during the vxlan netdev
lifetime are also bounced. It is therefore immaterial whether we access the
flags through the vxlan_dev or through the socket.

Convert the socket accesses to netdevice accesses in this separate patch to
make the conversions that take place in the following patches more obvious.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 4053bd3f1023..d07d86ac1f03 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1717,7 +1717,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	/* For backwards compatibility, only allow reserved fields to be
 	 * used by VXLAN extensions if explicitly requested.
 	 */
-	if (vs->flags & VXLAN_F_GPE) {
+	if (vxlan->cfg.flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(&unparsed, &protocol))
 			goto drop;
 		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
@@ -1730,8 +1730,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vs->flags & VXLAN_F_REMCSUM_RX) {
-		reason = vxlan_remcsum(&unparsed, skb, vs->flags);
+	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_RX) {
+		reason = vxlan_remcsum(&unparsed, skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
 	}
@@ -1756,8 +1756,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vs->flags & VXLAN_F_GBP)
-		vxlan_parse_gbp_hdr(&unparsed, skb, vs->flags, md);
+	if (vxlan->cfg.flags & VXLAN_F_GBP)
+		vxlan_parse_gbp_hdr(&unparsed, skb, vxlan->cfg.flags, md);
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
-- 
2.47.0


