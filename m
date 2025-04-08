Return-Path: <netdev+bounces-180354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D98A810A7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C79F4C4294
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074822E3E2;
	Tue,  8 Apr 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OL3xEzN+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083EA22DFB1
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126997; cv=fail; b=npQHRdyl1I0yF9sY2i4rdRRcLHiMOZYitLjIDrSj8TanaJBCwOgSgggZW86dvixEJhvkx3AQYH0wW6exMTb/caIF9kbsJDmaFoig5u4/ox0QCaeYQz4x+F/dub3nMu6LkZ1aS6zPy0uWtgtVgRkM46TtARSXDKj34DVeAr0A17c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126997; c=relaxed/simple;
	bh=AY40BOfme7JEAVstR4vWtaIHxfWl25W9nOI1tq0vbhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icoeNLpyWcW/6Pi7RXjJh54qRFH2U2XxHCVFSGfeYIAzZ125e4XLWRfUJvT9oxnrfNSdcFvJ5FSDtlURqsve7xmc3QA2yh6pmBQF1NldDxczs1P3op2EK1NNaCVFQtDNvea4h7LKMGAK7OFfGr4e2cAzpCQCx2w0tMkr9fhSBp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OL3xEzN+; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQDM0siqFPLqklIHLDcZxPR7AelstS76KI9op62ORW1mWoHu94Th2/BNjhiUpmOBgoDt8YKE6m7HUv3EOSzSvPEUx6tu3GRw5b0PDOb8wBGCRAsAmkCxtqdtxpkCYNKe3TehCnRlJ7ptPF1HxzgI1lllCCb7p7Vnqj9FUGTzEYmkPgnmJ43uIZSYIofIK9Ddp/aUmazi22RnpvB+a3g5IcJoiOS6An2n+cUockbBnt1SC6Rl+As6hpv9/5FtxsqDfPPfh/WqExidIGFwM0kJOwSBy+pefAQBr+KNbuaM32Id+rJ15EeQfbY6P7lZ2KC+cnsKdRACXAkrIT+sWTHBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZohXcO7/Ig4JGd+UA+ZNoD9LzwjvLMDOgv7oVckylU=;
 b=iUlDKWOzoHJjmvkVmWFTzAzgcj06pLEi3eeyXK27aqlkNvvvGOSaLD5SzsNTNiPUMpWlv3A9kjS2GYZheWe3/2hS5UDnuPR+jDg0c9Zt2FAoOdk+mUejflc3UYrl/Vd0V0Nh/rsJZlMqBEcBAPc2oNk3xkehzWyeNEnfZqNPOtfbSgfHUvtDQiva6307TIMoRQcgGx+/l3Y8LS7u9DJwj5Mg4PrJkJEnG8xEXLqL1EXLQ79aQg74G5734mjLBiBAM7fa3iqr9hra/L8vt9SYqj9S7KczBtf/mTPJyWgff/7JvtHpkv1Y2JEO0xf4EJR1TzKpF3jqAhR8GXCwwSZQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZohXcO7/Ig4JGd+UA+ZNoD9LzwjvLMDOgv7oVckylU=;
 b=OL3xEzN+xXYdNtoY1+Vf9kDUqTUqB99SPKxt692pdSOyNHCX65SB07IQVWXrkK94Hdl4yZaRGu4M5g4kPHtEGuWKO24Rat0JW/CHvm9n7QWWIK5lbammxCKP7kqGdMUG+VlZfbIVFAJ90WDpEF0MBOx5tkGN863PMJ9Shy2zUQNX824GutJywTVMXun8b+ohppUP+uUDs5FS4kxmpSMXdq1mY8PsWeJjmsw86vslwRpUQvFGb/nPaSQb5unp3rmDMk8zxlBNgLSLpPkiSV4uu7P22jCSB511SPVS6WM77Bc3YV+E5jd85EL1LJS4VUdRkWJwhyrdhv+hnC2LlUvI1Q==
Received: from BL1PR13CA0252.namprd13.prod.outlook.com (2603:10b6:208:2ba::17)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 15:43:11 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::23) by BL1PR13CA0252.outlook.office365.com
 (2603:10b6:208:2ba::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13 via Frontend Transport; Tue,
 8 Apr 2025 15:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 15:43:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 08:42:58 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 08:42:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux.dev>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Denis Yulevych <denisyu@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next 1/2] net: bridge: Prevent unicast ARP/NS packets from being suppressed by bridge
Date: Tue, 8 Apr 2025 17:40:23 +0200
Message-ID: <6bf745a149ddfe5e6be8da684a63aa574a326f8d.1744123493.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744123493.git.petrm@nvidia.com>
References: <cover.1744123493.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 59347647-c5d1-41ca-8d57-08dd76b41192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbgs6c25zx2w9l0sMDv0Pw2px/JWkBUuZHsxp4TOhFYV9js9/Yxifz97FNzR?=
 =?us-ascii?Q?vPczQIgnfWe6s9xBJ1RZA9X9QFWqnvlJUI0RL0C1Z/bXfOZr3j0CY2G1PXs3?=
 =?us-ascii?Q?PGZUc3kRt13fTrka47/cqWPZLW6f2mqON5wBNbX24Gi/v8EXP7wPQfvHvLRa?=
 =?us-ascii?Q?uYvv4LdeSC6VCq2wLEi6u39SQIpGouQ/FWig+Cnbf54f2nf4DkpghfpHRsO7?=
 =?us-ascii?Q?eSmjBVZ750L4PaIoO2hGCv7WqvpIGRynIJd7SzoFB1QPjze0W7mmQz3aOZj4?=
 =?us-ascii?Q?DBy0wOYKSNTNElG2gQuSJkr27m6Wk2kfHcmA45nt0pTgvMGV3i0Eo2d9rYrz?=
 =?us-ascii?Q?A+92ZCha7GyQHAqiJ3dXTxeDtYIlMpBCENza3bTCtN7wxCO41MIDpUg4fvXb?=
 =?us-ascii?Q?AvZ3EYagYqOcBmoB62XBf2MxaWww+RtQ/S+k13cZN3ZuxVWTYXYx73hjCoZO?=
 =?us-ascii?Q?3LuqTD/O2pCXh6q46XPZzr6JMPeezFT44/vcVATMoet9me9XpN23fDtDOB4u?=
 =?us-ascii?Q?l29lWTIY2vh0lHrTsc6nyNBaDpxUq9re/7DQxGW5hoQZso4uOx5MF/zbzQRg?=
 =?us-ascii?Q?14imFMDY6vAhv3lBV6/xZW4pJd9ruZcItq0AgsQD9+2znPq58a9Gd/RntG5Z?=
 =?us-ascii?Q?wC1OFQeJZKEYrG3YaRgISGadd3ZVMfMyQccCFhrNhkDeEGpcbs8Lh7EIwJSd?=
 =?us-ascii?Q?RJwujy4XvuOrjBOrpBBHllhD925xgNH3lf+dxvPY0xshDfxpGmIw6GsLI/Cf?=
 =?us-ascii?Q?m4UkzP7xq0I2NC4VflqKk8rXncSaDJqHdlCKrkTmb7ORn930G5Op839Tfd06?=
 =?us-ascii?Q?T9Myc/NpNWf6J8/ukNPzq8LbYJPaaYbTYtQEVYNt2G20dL6dMtJ2jffsM/uY?=
 =?us-ascii?Q?/DU3HOx4e2aRyBpqrqGV6N31P0ojMEh3O4mXQQpzLT22Bb2g633g3aU9G3es?=
 =?us-ascii?Q?rmvjkDOyNybz9AJaw7LbymuZ8AkAM0sjjF8iNOa6/LLlca2ZL1WN8RBFWrpV?=
 =?us-ascii?Q?gDhymccPZD+oYpdxMcjc/yvvUXGS6Kt0k5wv5HflhUFca5EywLogKKOtgVW5?=
 =?us-ascii?Q?vr7vt/x66qu/NAMyHdMvoXuOVNKn3utiRRFn/EaEuizLNT0iQTNVbRelRGrh?=
 =?us-ascii?Q?q4d9BCgDRifjgjad2K3eVtVcagAM+/DLMCALgbkLN1qD+OXxFMhN6U0VLIR4?=
 =?us-ascii?Q?RNo1y0TXgqZ9/eGOI9K83ocpMtPp1xRN88j2lmRYJn9DfhkTbesmV1Nqp8hi?=
 =?us-ascii?Q?OvFPgS6F+ASdorMpZD5w1cFwIyzqva5ZWekv75BZ6VBGH8qbkJG6ZQvO9ari?=
 =?us-ascii?Q?5PT85sf0YcCcccHJjN9qbHJ9d2zw+ebeudSb1UWRU9EO+BJDa7TyXzndDN+b?=
 =?us-ascii?Q?qo9RLRzcituLcFFjGC8Rk3cIr5ZaPhpHWNu5B8UP9GmAqpUkM2Q0Y+3lWpQu?=
 =?us-ascii?Q?kdzPveZEL3OM42rwM8AhVjRtupsJcyKJECBkx8hZR+iAE+wcYulywZ61bUzo?=
 =?us-ascii?Q?dRUTdQLB4j7mXK8u2cw2ItAgSOSzNk+gyleM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:43:11.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59347647-c5d1-41ca-8d57-08dd76b41192
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

From: Amit Cohen <amcohen@nvidia.com>

When Proxy ARP or ARP/ND suppression are enabled, ARP/NS packets can be
handled by bridge in br_do_proxy_suppress_arp()/br_do_suppress_nd().
For broadcast packets, they are replied by bridge, but later they are not
flooded. Currently, unicast packets are replied by bridge when suppression
is enabled, and they are also forwarded, which results two replicas of
ARP reply/NA - one from the bridge and second from the target.

RFC 1122 describes use case for unicat ARP packets - "unicast poll" -
actively poll the remote host by periodically sending a point-to-point ARP
request to it, and delete the entry if no ARP reply is received from N
successive polls.

The purpose of ARP/ND suppression is to reduce flooding in the broadcast
domain. If a host is sending a unicast ARP/NS, then it means it already
knows the address and the switches probably know it as well and there
will not be any flooding.

In addition, the use case of unicast ARP/NS is to poll a specific host,
so it does not make sense to have the switch answer on behalf of the host.

According to RFC 9161:
"A PE SHOULD reply to broadcast/multicast address resolution messages,
i.e., ARP Requests, ARP probes, NS messages, as well as DAD NS messages.
An ARP probe is an ARP Request constructed with an all-zero sender IP
address that may be used by hosts for IPv4 Address Conflict Detection as
specified in [RFC5227]. A PE SHOULD NOT reply to unicast address resolution
requests (for instance, NUD NS messages)."

Forward such requests and prevent the bridge from replying to them.

Reported-by: Denis Yulevych <denisyu@nvidia.com>
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 115a23054a58..1e2b51769eec 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -160,6 +160,9 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 	if (br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
 		if (br_is_neigh_suppress_enabled(p, vid))
 			return;
+		if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
+		    parp->ar_op == htons(ARPOP_REQUEST))
+			return;
 		if (parp->ar_op != htons(ARPOP_RREQUEST) &&
 		    parp->ar_op != htons(ARPOP_RREPLY) &&
 		    (ipv4_is_zeronet(sip) || sip == tip)) {
@@ -410,6 +413,10 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	if (br_is_neigh_suppress_enabled(p, vid))
 		return;
 
+	if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
+	    msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
+		return;
+
 	if (msg->icmph.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT &&
 	    !msg->icmph.icmp6_solicited) {
 		/* prevent flooding to neigh suppress ports */
-- 
2.47.0


