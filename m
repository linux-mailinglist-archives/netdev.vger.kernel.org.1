Return-Path: <netdev+bounces-137166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16A9A49FF
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DA21F24F65
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB91925B7;
	Fri, 18 Oct 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="owOnCipa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596F1922E6
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293637; cv=fail; b=t6mEp9CyMCzzhUhAnllosnDNwcqzrrxZXsT6tsabqLQH2m6VcGZLVSxKcP32SW6+KoCE/CYK6hwd28X/Xhv179EivnoQaGohoBiu6l+SzKV+kK5ttfgAWtImX99lvuc2lXOiZbBnG65K/pabym9mpmso14IvJxjRp1tFAidTLH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293637; c=relaxed/simple;
	bh=97pAa0ubJvv2b2H2vaQitorxp/V/N06gJgVq+O02mMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcxlVsQ21/4DQsq1EO5vFBvnODGUahT5RlHYUNyVSaSF7syxyRuWhPRtT9GmdI6EqwzZzVVKnUFmYAtdPVOhQv1RcQFp6DNBsmP5IuxoppalblK7vHz2hqFrNgjtOrCUewClqkTaPeq6ZG9mhM0EUjPVvll0EyR+DLOMVC9nmAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=owOnCipa; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3kgcLfCPobjhooVVxHsPc6VYRRFB/Euw5KM7ZiYehgokhyg7inx+fDunihZ4Ix8QmRPglFfy075bfj0IJaB1lSjF8PQZnFTTE+czfdXI0iSrE/gKe5p8eZqHi3e5YjPoTNbzRfJKQJNhSR1RoswzjVEWB5k4eZecTZkQmVwpiYTOub0+mn3fEG3Gg2TlttdmiZKwqIIRYWaN9v1Hm5U7+XPVpplo1NsDNdqbq7oXntHcYsCE/hudlgbvifxDlwR+qG7Qlvc5jvY0QZ42LOJDhMF3fZHC+0TlkqoVOeCly6ORy5Ck8GiV+/7RGLRuBmj0clcW7Ale+FsZBC1lGcT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz+kGr7twXFVeAzwBX767IWNa4dYXoelwJ2FNEIOVhM=;
 b=bag5gd/g9ZDTpmlAkCYtEjX11FkiLP+2tKEaa0feE0OoPmlYHjh43sLQUz2J4jNlZivTm5UCZb449CLTvAvEIWdt9H7BejzgCogIwKJBX9J0qi8lgW31S2OsUulk56TFlgp8Jr+yBc75vubGeaeGTj7RVpYveEE23dYVZThhx4Ae9LN+IcjciwWF8P1XnYgnY9mHr/R6RtuolZOFOaZwdIR1WthKe+9auAn44atKhF3VX7verNZ1gAzamamC3VYpSICOw9xnPLcqAMcfyeYD3AIfSiv6/c2DNYewnr1bdtBc/1b3Dx9Xb7z2pVJxZNQJSJntOJUixfms6dT3kh+2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz+kGr7twXFVeAzwBX767IWNa4dYXoelwJ2FNEIOVhM=;
 b=owOnCipa7ZALK5Qw7bVUHN9x1Bw+YyZ8Yd+PrrdYshyheTs+i3RKCMqvVw69MnmPr/Gl/5ap38ca9ldlbA60d5n5lN2fh6iyZuKT5++XYlYkYJi33VnhONEwCq35g+EhDwS3D/bxoYqO1t1xbI9HNtE+hjaozVoKedMYUhQndSXLKMOcph/Mbd+C7nIvwsupEUKLHuEMcTY1Q2QuiWyTzCV0SL2x2d/EoW9OrZaY4pQ02Lnt9EHRu+VNgSXImhM6COAos6YKUvMtBWKZHEHglPUEKoJSJjTyGoiq5BVW9ZILKbW3tZDR7EJ/E1yGY7V4uxOLTBtDz1C5hoIOH6wA7w==
Received: from AS9PR06CA0737.eurprd06.prod.outlook.com (2603:10a6:20b:487::13)
 by DB9PR07MB9956.eurprd07.prod.outlook.com (2603:10a6:10:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 18 Oct
 2024 23:20:31 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:487:cafe::a2) by AS9PR06CA0737.outlook.office365.com
 (2603:10a6:20b:487::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJX010239;
	Fri, 18 Oct 2024 23:20:29 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 08/14] gso: AccECN support
Date: Sat, 19 Oct 2024 01:20:11 +0200
Message-Id: <20241018232017.46833-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|DB9PR07MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: 11df40ac-c393-41a4-223a-08dcefcb757c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zi9PbGtkTmRrL0Q1YmdBQXl3VEN3Q3N2aWt2MzdWSEUrODNBZGZhNkdIN1Nq?=
 =?utf-8?B?L2dQbjVLL0pFUkFQeDl2WWZmMXFMb1QwcFhWZ1cvd2ZrQ0kvRWlOTzNaQmwr?=
 =?utf-8?B?c0hpRWp2d0h4eCtrU2RKY1JNWFNNR0o1ckxnOFRCWTBtSGJsWDY5WWVQeWxR?=
 =?utf-8?B?SWVVWHVESmZWRHZNZ3JuenZmaDA2UDFVZ2hpUmdCUGU4bG5vdE1YYWUxZFVK?=
 =?utf-8?B?dnUvWXVCRzRDekFtVUxQa08rWGlIZHZEdmxZNnBwOTBZdTRnU3B1SWsrbERj?=
 =?utf-8?B?YW95enRTU1BxUG51RlF6QlB2bnBHVVRhL0JvWUV4aG54T00vVzFockNaK2x6?=
 =?utf-8?B?d0h4QlpJNU5nOVVGZmtWT0ZGbzJ0bjMzT2lIN0RuRGtnVHNQVFRyUjl3WVB0?=
 =?utf-8?B?L0Q3WWFCS25OOGZiTmZXWGdqU2gxbEF0RnVEZWxSRTM2ZTRtenBCUm1PN0Fy?=
 =?utf-8?B?OE1DbWtobWU2YnhpL2gxWVh3SVdTblB1d1VHWDdwcjBYN1RyR2N3OUFWbGhJ?=
 =?utf-8?B?dWlVT2pLM0wzMnVJZCtsbzM0M2RxdS93WHg4ekJlU056M2FRVGh1MnNuUGUv?=
 =?utf-8?B?STh0cTZhWTlqQy9VNHdGZk9TcjZYVGtXZ1BhektsV3BxVitmMUlPSDJ5NEho?=
 =?utf-8?B?Um84b24ySG5WZWxiQyt5SWlmaG4wUmtHMms0djMycDhhWmRzUm9hT0dLK2Yy?=
 =?utf-8?B?bjNoYVF2Nzc1RU9Sb0svQ3BrOFp3Sm9jeDZPTlA2MEhYbWJGWGZyZ2pJNnZH?=
 =?utf-8?B?b0JWMFNjbXFBTytnZTdhaUY1QW0zUUowWU92V0hMRVhHbVNQVmNnSkp5WHZN?=
 =?utf-8?B?Z2FnWGpPK1RFT2hMMXhrOG0wMUVRR2xFc0JJY2Fab0RCQkc2V09kRHVZM1Q5?=
 =?utf-8?B?UnJUUDZmM3gvdmRtT0dzbnFzUGJTNFgzZ0VIMWNrWENGcmcvY25TbVVIUDRn?=
 =?utf-8?B?bHZaZ0lkeWFIOXY3MjIwUGtvaW9TMWJxT2tWVlJDVTZsYnJnUTdaaXVXSVhS?=
 =?utf-8?B?bjNERXVodG9IUWVEeTc1RHE5ZHp5T0tCRmxWdUIwL3ZmSHhPdUl4WHJ0YVJX?=
 =?utf-8?B?dzVrQUJQeVF4TnhFUXhzdUROOERkMHhwMThZckZGZnR3eTlzd1UzcDFvbU16?=
 =?utf-8?B?WG1BTVQ1OUptaHBjUG9HdVRyV1pNVWNSS1Z6LzBrSlB5QU1SOWZ1YVRGZHB3?=
 =?utf-8?B?S1FseFNvOW03K29pVCtCWjgwWDNLSE5HbUtrZmUyUC9NQWViVDVybVIrdEFs?=
 =?utf-8?B?SjRLeGpoR1NBLy9tSUZKUEt0a0gzdWZhNWNSKzA3TnhpQmZjcEdhQjZPbFdI?=
 =?utf-8?B?Y1BnNDAycFlMZFZQMnllZURPbjdzVVpOWXVIR25sTzcrWUlNcGdXZjRoN1Q5?=
 =?utf-8?B?UktWZithSUxUam5ib01VWVp2TjZvbld1MVoxYVc0V0RYZ3lzSXh0akZPWFNi?=
 =?utf-8?B?RFQ2Q1plMUxSZjduelpHYnpGSnl6L2ViSytTQXlodnc2RytiYmphc041QVFD?=
 =?utf-8?B?YXBjMlFZTk85WkhXejVxdkVOaWorZFFYcHNsd1RWWEZGczFTMWtHSGI3S0Rq?=
 =?utf-8?B?WEZkejJjWTdSbEw0UTgxcmlxNHRVa3RySEJxRmNYQ1hKeWNoR1A0UCsrT3NG?=
 =?utf-8?B?aEIvTlc0dlk1cHJoeFErVldqY1RWdmZCYXcrQmtZbGFDakxkWWw2UUtMd3Y3?=
 =?utf-8?B?Z0wvS2gvRVFQM0wxK3EzWnBWc1NvcEZZRGY0S0lURDd6UWYza1pDTUd5WUVI?=
 =?utf-8?B?d2xXUGpkdlk3SXppLzk4SzR1ejQvNTFlQ2xxckZzR2xLN0R6RFFuSlh6c0hX?=
 =?utf-8?B?L2NXeWo3SjRTdENPZVRGVzRETnFOcko3TGdsRDNsZSsrdUJZbVBybmNJUkZy?=
 =?utf-8?B?TThVekNtQlMybnJIdEJ2NTk5UlA3ZzYzczVQRTZ5WkVJaTgva0hmNHVYNDR5?=
 =?utf-8?Q?AAtdJ6jgvTU=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:30.7143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11df40ac-c393-41a4-223a-08dcefcb757c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9956

From: Ilpo Järvinen <ij@kernel.org>

Handling the CWR flag differs between RFC 3168 ECN and AccECN.
With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
starting from 2nd segment which is incompatible how AccECN handles
the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
With AccECN, CWR flag (or more accurately, the ACE field that also
includes ECE & AE flags) changes only when new packet(s) with CE
mark arrives so the flag should not be changed within a super-skb.
The new skb/feature flags are necessary to prevent such TSO engines
corrupting AccECN ACE counters by clearing the CWR flag (if the
CWR handling feature cannot be turned off).

If NIC is completely unaware of RFC3168 ECN (doesn't support
NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
with AccECN on such NIC. This should be evaluated per NIC basis
(not done in this patch series for any NICs).

For the cases, where TSO cannot keep its hands off the CWR flag,
a GSO fallback is provided by this patch.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/netdev_features.h | 8 +++++---
 include/linux/netdevice.h       | 1 +
 include/linux/skbuff.h          | 2 ++
 net/ethtool/common.c            | 1 +
 net/ipv4/tcp_offload.c          | 6 +++++-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 66e7d26b70a4..09ebcb19b463 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -53,12 +53,12 @@ enum {
 	NETIF_F_GSO_UDP_BIT,		/* ... UFO, deprecated except tuntap */
 	NETIF_F_GSO_UDP_L4_BIT,		/* ... UDP payload GSO (not UFO) */
 	NETIF_F_GSO_FRAGLIST_BIT,		/* ... Fraglist GSO */
+	NETIF_F_GSO_ACCECN_BIT,         /* TCP AccECN with TSO (no CWR clearing) */
 	/**/NETIF_F_GSO_LAST =		/* last bit, see GSO_MASK */
-		NETIF_F_GSO_FRAGLIST_BIT,
+		NETIF_F_GSO_ACCECN_BIT,
 
 	NETIF_F_FCOE_CRC_BIT,		/* FCoE CRC32 */
 	NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
-	__UNUSED_NETIF_F_37,
 	NETIF_F_NTUPLE_BIT,		/* N-tuple filters supported */
 	NETIF_F_RXHASH_BIT,		/* Receive hashing offload */
 	NETIF_F_RXCSUM_BIT,		/* Receive checksumming offload */
@@ -128,6 +128,7 @@ enum {
 #define NETIF_F_SG		__NETIF_F(SG)
 #define NETIF_F_TSO6		__NETIF_F(TSO6)
 #define NETIF_F_TSO_ECN		__NETIF_F(TSO_ECN)
+#define NETIF_F_GSO_ACCECN	__NETIF_F(GSO_ACCECN)
 #define NETIF_F_TSO		__NETIF_F(TSO)
 #define NETIF_F_VLAN_CHALLENGED	__NETIF_F(VLAN_CHALLENGED)
 #define NETIF_F_RXFCS		__NETIF_F(RXFCS)
@@ -210,7 +211,8 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
 /* List of features with software fallbacks. */
-#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
+#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | \
+				 NETIF_F_GSO_ACCECN | NETIF_F_GSO_SCTP | \
 				 NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
 
 /*
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655e..6ccae6933aaf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5066,6 +5066,7 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 	BUILD_BUG_ON(SKB_GSO_UDP != (NETIF_F_GSO_UDP >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_UDP_L4 != (NETIF_F_GSO_UDP_L4 >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_FRAGLIST != (NETIF_F_GSO_FRAGLIST >> NETIF_F_GSO_SHIFT));
+	BUILD_BUG_ON(SKB_GSO_TCP_ACCECN != (NETIF_F_GSO_ACCECN >> NETIF_F_GSO_SHIFT));
 
 	return (features & feature) == feature;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 48f1e0fa2a13..530cb325fb86 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -694,6 +694,8 @@ enum {
 	SKB_GSO_UDP_L4 = 1 << 17,
 
 	SKB_GSO_FRAGLIST = 1 << 18,
+
+	SKB_GSO_TCP_ACCECN = 1 << 19,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 0d62363dbd9d..5c3ba2dfaa74 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -32,6 +32,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_TSO_BIT] =              "tx-tcp-segmentation",
 	[NETIF_F_GSO_ROBUST_BIT] =       "tx-gso-robust",
 	[NETIF_F_TSO_ECN_BIT] =          "tx-tcp-ecn-segmentation",
+	[NETIF_F_GSO_ACCECN_BIT] =	 "tx-tcp-accecn-segmentation",
 	[NETIF_F_TSO_MANGLEID_BIT] =	 "tx-tcp-mangleid-segmentation",
 	[NETIF_F_TSO6_BIT] =             "tx-tcp6-segmentation",
 	[NETIF_F_FSO_BIT] =              "tx-fcoe-segmentation",
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..0b05f30e9e5f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -139,6 +139,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	struct sk_buff *gso_skb = skb;
 	__sum16 newcheck;
 	bool ooo_okay, copy_destructor;
+	bool ecn_cwr_mask;
 	__wsum delta;
 
 	th = tcp_hdr(skb);
@@ -198,6 +199,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
+	ecn_cwr_mask = !!(skb_shinfo(gso_skb)->gso_type & SKB_GSO_TCP_ACCECN);
+
 	while (skb->next) {
 		th->fin = th->psh = 0;
 		th->check = newcheck;
@@ -217,7 +220,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 		th = tcp_hdr(skb);
 
 		th->seq = htonl(seq);
-		th->cwr = 0;
+
+		th->cwr &= ecn_cwr_mask;
 	}
 
 	/* Following permits TCP Small Queues to work well with GSO :
-- 
2.34.1


