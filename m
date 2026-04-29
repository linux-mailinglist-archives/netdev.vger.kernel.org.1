Return-Path: <netdev+bounces-282240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEmyDUak8WnxjAEAu9opvQ
	(envelope-from <netdev+bounces-282240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:25:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F269E48FBB9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9672300B58B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9CF3822BE;
	Wed, 29 Apr 2026 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8CjGuwM"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD46388E63;
	Wed, 29 Apr 2026 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443905; cv=fail; b=apTGxvxPvFxIvCbnC0/zQartkQrIPzzVxa3KSHGBrFTgHYA220nJfrYtDeFCYM6ans9R179Gy8/tvdUvv+bIG7WpZkhXIyOFYgExcBBkNqDfHxnq/tammP6hC2a1q5lsO0wPB0EQ13NtNP2hHKCTK5CV+k+WywTROCsmN21XJEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443905; c=relaxed/simple;
	bh=uBBNjm/uXqoh3BYyQFRZNM+9GzRpWFtycr51w0f5Knw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJG4gf3uyNVW0mL2mUXVTGb2hTz0CNOj04ymf/somBmzQU/aDl5mnFMft05Gv3ahfONWsGCKL3elziMCbXecnPKd3HK6nfEbhB5JI1hACrGLo2KtJg/nCR4Q/prblr0O/6b1eV6ce5e15yt7/iGZNItRyeVNpm8DkqRtg3AKvrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8CjGuwM; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjgfHrMd0SrmhD5kKKYXcCPG3pczJA/7CJLHBvk2xII45S3kl9KAHvgUrOcLTyByqiMFiRrcJUUigXUFmWTJS7ra7Z9U6TTMCs5rjG8Cly76UYU4po9oNp83lQbdKrqFnYCaFR4V/nTDWiJPVssJWAM43uCd4UyI4hWeMutVa+skjMCBNvxSCZc/1su/RhrK5jj4FF1fZF8USm12WD9RIVG0HpGDcaaBqv9tBhHgnWgUEC52G5CZiGSwlkbANnq0t1VEEZDnpBPo5vTwnWbN/jw3HooXlfkBw5y+P2p6/2Tecj6Uy/b0hNMhyAhzZ2HTqfJ1XX9WLVA0AM/ThBYLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCRkgxWBcA+Bm4a1kg1jwe90f9Qdbgv4ZpVfg+PNiEo=;
 b=K8RueG4jNZRB/8egdLynLA1+69qtcA0jASYuNZwvE/7U2RvcO0ZsrAiW3yGG0u4IMbWFjUEZQsQtS7Hq3Cs/et1sc3Z86DlyynODkI382WFdk0NEZdNZA67dABLWAz03V1HYXG+v06W5fk4GTQFlgTbbC/fZp9pe/ba1ntgfLnH6wg0m7ayeVXCi776FdwmQZiIcc+cDZFJBZIcl/QS2umtdNx/HvK+O5CM71TR7bDjGxtI6SzFDx4DSa2lQ1CkrgUXYx5IVj0i5WWgoJm5dqu6VGfiwhbrbMPl+R2jGDzGtDZMel/0CM7mMMvh0hDQCUj0lTa1ZROt1MM9qhB0+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCRkgxWBcA+Bm4a1kg1jwe90f9Qdbgv4ZpVfg+PNiEo=;
 b=t8CjGuwMERbG5bYZlcqQMEtxaZL/+BK711+SsMYC6lbofzc5Q6EEnf5NzCtDDs3usqwu2I5fF76uCkd8WiXlmqavvD9w4TheLmwd2tbMoc64fP0jBf3ADSIaY7t8P7n30Ud0FBsZbfkhDEt/GDnupEivUIDjlLAQxCv+sM7NVz23NCn6WvjjdZnG5zZJhOQ5WTQxOT9kXmFion13er6k26AOJ+m5xHw1XHW7wT6rEEBOR/M1CgR67aQJkFF2yt5eWdBLGtTMUyUCZ80X7r/ZvrlUFuyVpDqsHC1JNqYgfdcByX4ahTXyp9c7or9kH2Stmdd4Cpc7lBjbir14b5oyNw==
Received: from PH7PR17CA0008.namprd17.prod.outlook.com (2603:10b6:510:324::8)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 06:24:52 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::b8) by PH7PR17CA0008.outlook.office365.com
 (2603:10b6:510:324::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 06:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 06:24:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 23:24:29 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Apr 2026 23:24:25 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <shuah@kernel.org>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH net-next 1/2] bridge: Do not suppress ARP probes and DAD NS unconditionally
Date: Wed, 29 Apr 2026 09:24:04 +0300
Message-ID: <20260429062405.1386417-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429062405.1386417-1-danieller@nvidia.com>
References: <20260429062405.1386417-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 58eca8fd-9670-4a1f-f040-08dea5b805c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VR0P+bpqUCdQzN3F2wcYECYALvElIUiUvgdWdTeaFg5i+qN/3mcZfZ7toKLTbyX9+gR+WDGQorh0leMgf+/E9wy0l287jukxxGK7eHl4RNHQqFAJdw8DjuEfuvEIMQZLzgLVewKShxH4Dh8tK4XTYewsVholBcFl1RoZzoqrRFJJUcCqS+CUkWGekxUrkgSERE7vmGbbXw7oFm1RGIloziS68SwFDTVmmix+lVc+BaiEpB+ZV1prWGOBj43LPvwO7Fmnp5kkcefNXtVAycck8NkPWoNwuSnBqkQzB0CKYUrvbf7UVD1QWaYJtuVCTNjpEBYCPBo4h+MPR7agrLyymWyF431iv7aYZfxGSQ4FhTU8aaWWrEyB6q1KpwLxltzfLiswu6mjxl2k00+OCTt+WSr0YCG5R0qKkjJEA7w98j7tMxpQ9zwZcdCm0XGIJW2JRNQhFD0R9eI/yKGsN2ljUeJvys3l9WXTP9/x5tFFxVwRZz/ezfxhRO3FqE52UWCM03A+tzMWTQaJ5Sh97436iZhWz2ZvfIc5pL6k5c11HIokUlH2beANNqvAjvk24LJ54Om22yBVEYqx8Ube9PvUl5L6/xG3wKLChx+EUH02hUahsTBVZ4Oot9x30XCEmz8r7iM8MN0K9QSSK2CvAMu5S+2sE+GaoNJ380yL91yF7mpi7o4+OlEZdHcqgKsbeSDOMN7HhZItt7OaH+gRvWeq5cUzhJ70di8VU6j6AyyWhm4Ovt8az8BoqZGN5DbeHKwyiNfsZs13DniffD5CIzZnbw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p6ss/QRtwi0XFlig5vuLrSB4cXLtsdy8I0nGtUSUC2fEi0jBO5+B8b7bjQZwHud0xyX2q15rkqs2XfMI5M1z4qHi3wCZXw48EZ6FbOKTd5L+MFTNgKvQdygP07sZO/9Sj23cedkj6VbrNI0m7PMwX1hRvIFzLZCu2go0XCH9qUgNu57YDrainkCupzrN4vjyzMJ5r2O0W+NDy1I2ZgOHBixXK56N77d7daA55IDKTHzsVxaRCMb2jFwt6txxKKJwxVBdmhqQhct3bzSooiDBc0kUl1RDlxxOVwoW2e5YWWKA/2yfhPvMwuNcJQqRaACstPjodRNjqIAh27WcpFSbRjDsbRHx2WpO+6WdH93zpcbmVDti3vp4yf/cqnutX0jfVyaK+M8LwXOXeZ0k32Dnjp3uIPkr3yXmjl5nxPs58QrweGUwr1ZYX2bHYaXtTMY+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:24:52.0927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eca8fd-9670-4a1f-f040-08dea5b805c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
X-Rspamd-Queue-Id: F269E48FBB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

When neighbor suppression is enabled on a VXLAN port, the bridge is
expected to reply to ARP/NS messages on behalf of remote hosts when both
FDB and neighbor entries exist. This allows the bridge to suppress
flooding of these messages to the VXLAN overlay.

According to RFC 9161 ("Operational Aspects of Proxy ARP/ND in Ethernet
Virtual Private Networks"):
"A PE SHOULD reply to broadcast/multicast address resolution messages,
i.e., ARP Requests, ARP probes, NS messages, as well as DAD NS messages.
An ARP probe is an ARP Request constructed with an all-zero sender IP
address that may be used by hosts for IPv4 Address Conflict Detection as
specified in [RFC5227]".

However, the current implementation unconditionally suppresses ARP probes
and DAD Neighbor Solicitations, which breaks Duplicate Address Detection
(DAD) over EVPN.

For DAD to work correctly over the VXLAN fabric:
- When the bridge does not know the answer:
  flood the probe/DAD packet to allow remote VTEPs to respond.
- When the bridge knows the answer:
  reply to indicate the address is in use.

Fix by adjusting the early suppression checks to exclude ARP probes and
DAD NS from unconditional suppression.

When replying to a DAD NS, br_nd_send() is adjusted to set the NA
destination to the all-nodes multicast address (ff02::1) and clear the
Solicited flag, in accordance with RFC 4861 section 7.2.4.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index deb1ab1f24b0..3205346f298c 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -164,7 +164,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			return;
 		if (parp->ar_op != htons(ARPOP_RREQUEST) &&
 		    parp->ar_op != htons(ARPOP_RREPLY) &&
-		    (ipv4_is_zeronet(sip) || sip == tip)) {
+		    sip == tip) {
 			/* prevent flooding to neigh suppress ports */
 			BR_INPUT_SKB_CB(skb)->proxyarp_replied = 1;
 			return;
@@ -262,6 +262,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	int ns_olen;
 	int i, len;
 	u8 *daddr;
+	bool dad;
 	u16 pvid;
 
 	if (!dev || skb_linearize(request))
@@ -300,8 +301,13 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 		}
 	}
 
+	dad = ipv6_addr_any(&ipv6_hdr(request)->saddr);
+
 	/* Ethernet header */
-	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
+	if (dad)
+		ipv6_eth_mc_map(&in6addr_linklocal_allnodes, eth_hdr(reply)->h_dest);
+	else
+		ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
 	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
 	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
 	reply->protocol = htons(ETH_P_IPV6);
@@ -317,7 +323,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	pip6->priority = ipv6_hdr(request)->priority;
 	pip6->nexthdr = IPPROTO_ICMPV6;
 	pip6->hop_limit = 255;
-	pip6->daddr = ipv6_hdr(request)->saddr;
+	pip6->daddr = dad ? in6addr_linklocal_allnodes : ipv6_hdr(request)->saddr;
 	pip6->saddr = *(struct in6_addr *)n->primary_key;
 
 	skb_pull(reply, sizeof(struct ipv6hdr));
@@ -330,7 +336,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
 	na->icmph.icmp6_router = (n->flags & NTF_ROUTER) ? 1 : 0;
 	na->icmph.icmp6_override = 1;
-	na->icmph.icmp6_solicited = 1;
+	na->icmph.icmp6_solicited = dad ? 0 : 1;
 	na->target = ns->target;
 	ether_addr_copy(&na->opt[2], n->ha);
 	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
@@ -435,7 +441,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	saddr = &iphdr->saddr;
 	daddr = &iphdr->daddr;
 
-	if (ipv6_addr_any(saddr) || !ipv6_addr_cmp(saddr, daddr)) {
+	if (!ipv6_addr_cmp(saddr, daddr)) {
 		/* prevent flooding to neigh suppress ports */
 		BR_INPUT_SKB_CB(skb)->proxyarp_replied = 1;
 		return;
-- 
2.51.0


