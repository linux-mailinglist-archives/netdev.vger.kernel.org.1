Return-Path: <netdev+bounces-137172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008F9A4A05
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D17DB22299
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E740192D6C;
	Fri, 18 Oct 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TnYKOhMC"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D0192B63
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293642; cv=fail; b=AIybKDiK6phCq0vyS/SbZwDuhSYE7kgmO1/K6PK1oOse+2yjNXdn3F9FK/6VqheuifpcXb+VJP3N445o9ucKFxjxm/XNiu3C6KQkMSKRxZPDc06x+Q3tjzp2taZyDY+t2vPykxaFXXE8epkErwySOl7vw1uqFcH+F5fXF15WbnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293642; c=relaxed/simple;
	bh=ZZLBBPsXEl76UOxnvAZ1AxEbusKk9Gb/BZJI0Ei8xMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpDYLGz68MyDPKFI0VFDSv51WzQfBpraNXR1NusEypvJHQwO29LPJOIQtCAcyK2zw9xsS9ZrCAQHYqyYt6a4DWi6+DcFRskSjd0T8NuM/io4M15U5fPdg+MVORHSq2ZTuNumd9N0PgpslnC1DcWYo+8yhPWoPEoEgqeAXJmDtxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TnYKOhMC; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTY+SLNOrgeeq/ZS4L5x+yBzzhHeF2nSFb69q4H7eVe/7Tx1pn3i4afdSpP1SHH4cZ57AN6ZATVnSM+gY9K3lowTMMei7IT4rQEL/HsZyp6aBevfkWWGl/3y+TOHYG8DjBb4e3Y7GnQL/DgSKUSb/wPXGQLvX5qAlXffoxmRZuuC+OVwTjtHeXrTNT6YucEHWDvE3bpkNJSO8Z4It8RDZ7RRG7vrmj5xz8RtmVbmVm8BLWnkUM0xDLce/etHem7Fg9nt8VAf+g2leCzQGiAPEMa9z4iQl9plPUZUrJyAFXa/O77JWkxoerNCJ3rmWy9oG8serWEdse/QfwQFQOJsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTd4kCFgA0flO2yxP58SbyTLmsBf6cIegpV9zqGv+Ho=;
 b=wRR4XvHYlLkAsu0AoSTt1qhbuTpjv7HI3yro988sWIeAdrBYMKfoAJbYUdjCIEoST49LLHCTTSHlh+ztyetLuv/W4Ivdkrte7xK4kFI8TZvPq4m6IjqwWEq3PC5MmTbRQ/lw4LPgpWTwfOdm9vlN15hYrmzgB0gWyHqemu36suZMw4hU5T5A3ZJkpKC+B5bFZYuXa1DaXQLUnqwzld6KdPchI1i01dlNDX5L3yI82z8H+QC6B13289T3ss+qgae/aNgwzlawZbvdVnxwq4PysTqRQ0bQQHScYDyvRIEyboiwLjE74rGfjuPmffnfiVHxKL5nYbJtfj9WjmAnQAoTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTd4kCFgA0flO2yxP58SbyTLmsBf6cIegpV9zqGv+Ho=;
 b=TnYKOhMCELafpPXMCKFeVdwIixFGjnT6Ur6Fclqjz2/SS3MRieTIFn5e0czeeTqRZL2PeerO2xTFwGhgBLG22AxO7z0V78oVbR4d4U1jQrX5qebDn6EXUDD+TtHjifs95Ljf15pPnU0yBSc6tV9EXJ3j9CNkORetoB/A9hfo4lTaEao8/fcbO1NgyjYEtRHZ++r+HWm2bY3bAU069dCoW3PrTLc9Qna3wXukecJCnWGF/J8c+xmR9ntGUU82AWE2cuZw7LBb/t+XBIzHOxBFeO13WxEUB9eZOGOCh133jNV5bhQtfHCSONmGxlk0Hi3hGdZIRKxB1AbzSpg68+3Uhw==
Received: from PA7P264CA0145.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::17)
 by DU0PR07MB8945.eurprd07.prod.outlook.com (2603:10a6:10:413::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 23:20:33 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:102:377:cafe::f2) by PA7P264CA0145.outlook.office365.com
 (2603:10a6:102:377::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Fri, 18 Oct 2024 23:20:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJa010239;
	Fri, 18 Oct 2024 23:20:32 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 11/14] tcp: allow ECN bits in TOS/traffic class
Date: Sat, 19 Oct 2024 01:20:14 +0200
Message-Id: <20241018232017.46833-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|DU0PR07MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a5bbf4-1ed7-45aa-0121-08dcefcb7712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0xpdmdSRHhCN2pDYmNzQTlFazNFNHJ0VWR0eWt2WVlUenVHVEJ3cCt2eCtP?=
 =?utf-8?B?M3lyWk9RRjRiV2JNbUlaUG05UjdFQ0ljMFlkNE9mcE5qYVM1eU40S1kxeFBL?=
 =?utf-8?B?cm1XUi80Y2pualgvRjFiMmxuNTZ2M3RVVkI0Nkt6eW51cUFRNy9ZbzdtZXFD?=
 =?utf-8?B?TWIySitVNUlmUC9DcEM0V0k2emJFU1VjUEtGbkNuQmdNeFlYWlkzY1I4a1dK?=
 =?utf-8?B?ZDVWWlA3TkFZaWZoZllqaHFPYVRJS04ya0txV0RLTWl6TklJeXJPdXJ6MTkv?=
 =?utf-8?B?L1IwakFZREZQbm53RkJCZXhmZy9jWU1hSXAwaFZ0clNlZ0FxaGREUW52L1du?=
 =?utf-8?B?eU9EWVVtU3IvMU1kN2k4RzBPUGdIaENUWWNPSmNQcHJZY3U1azFTZ0E2L0ZS?=
 =?utf-8?B?TC8wSFJWQ3NGQjJlby9qeENQVkdpV0tYSDJleXIvd2tlTVlITzlyQ2dscFdj?=
 =?utf-8?B?VDNkRWtVTW14MFlsREN4SlN6eDJQZFNQSGg5MGtWcmdIQjJaVE9PeTdTYjg0?=
 =?utf-8?B?QjhmOVNEa2htM0RIeGxMeEdpRVhKekkwa01SeVJ2d3NqODRBSXUzeGlNaHhv?=
 =?utf-8?B?dll0aGFDMDZ3OStkT0xFRGc0Tmg0K1M0N0Q2Zjg4ck9La2dhTXd5aUp4aTJ3?=
 =?utf-8?B?YTgzc2RoQXBudmg3K0l6RU1ITWM4bHd0WExXdDhCdnF5WUtuV0Z1YVVVVUJp?=
 =?utf-8?B?OG9kSWdhcUFHNGR0KzcxeFM2U0ZCV0JwaHVzL3h4eE02RXYvTzRMMUd5b1hq?=
 =?utf-8?B?RStTT0w1bmZXdkwyRjJrMTd1NnZIc284RzBjUW1zTGEzb3FzVDRUUmxML0ZX?=
 =?utf-8?B?VUU0UXNEeWhKNEFzclp5NjhHVlVnaTUxTE1yWmdJV3ZuU3o4LzJHU2wzL2d5?=
 =?utf-8?B?Qys3ZmkzR0cwR3VnN2dqWnhBTFBqeGJSdVo2azB3TXRsQlQzeTdqcFhwSGJV?=
 =?utf-8?B?QjlXOHdlUHNodloxQy8yeXV2NUowNXNab0hwWTVTRTJxcXJPMWNNbzIyMENE?=
 =?utf-8?B?elZIT1JRZksxeGJWU1FSNFUzUE4yelRoTzdST3QvWXk3WE9uNWFiNlVtb3dv?=
 =?utf-8?B?NzN3OFYvYzFQT1FablQ0c2JWaHYrZnFpYzZoUFV1RFZ4a3diaEExNTJNOGk3?=
 =?utf-8?B?cHdRRWh5YUg1RUoxTjVEeEZaSEE3bDg3bnI5RktNSENsQ2JVQzNiRGtISitX?=
 =?utf-8?B?Y0p4czMyQndBM2NreVlyVkJRTXhrUVZHR3FpQk5lR0F1U0Z2bUFoQjJTN3VV?=
 =?utf-8?B?VnhTbGNZM1dic1ZhamdsNXQ5cFFRL2kwY0NndEJWK1pCVkhjNXVVOU5Dek1Q?=
 =?utf-8?B?WjU4N3Z0NW0vLzNuV3hVL3R5MG5IejNodFhwQVV5dTFpeThyc0xueUo3YVg5?=
 =?utf-8?B?NGRvMGRxUlBYOVBqbDZYeDFGckV0cGJ1a3JXaDdtWFlwcU52bnQ1aktIOHJM?=
 =?utf-8?B?a0pXSytjQUk5OWhveTdnT1ZQazdFdGhSV1JqSGpwNTdWc3pFZVRTbWJWV1BT?=
 =?utf-8?B?dUNYNDJlUitpQS9MQzIvLzd6WldVRmEzVmJQcFgvSkhQczNDaUJWU081SW5H?=
 =?utf-8?B?YnNBT3h4MUx1NzFmT1NOSERSYXFMc1AzcExjZGh5WUQ3d0VWc285WksvRVla?=
 =?utf-8?B?RUxLcUtJYkF3dGtVNEcyaTJTZVdFY2lVVnN2ZndvZy9DRWJwTURtU0FPckpG?=
 =?utf-8?B?WHRDZDJHcTBSYks3UVdYakpLTG0yZFRlellwTEkrQVdmVUZpYm9UN0RwcmJD?=
 =?utf-8?B?ajFWN21nUVpOWGpGdGI3aUkydDZiZVdXOTM0UTlNSWt6eEQ5TlJabXNZdXlU?=
 =?utf-8?B?aG53eHBaa2lndE1Ia0dNNU81NjY3S09rVE9ZYm9tY04rblRES0c3ZEVFQ2tC?=
 =?utf-8?B?emQ5OTI3VTk4Q3pudTAzQWNyQXBuYVIvSUcxNGdyVGdpdFdrWXdRZ3BsSFR3?=
 =?utf-8?Q?E8Yh30UF744=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:33.3586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a5bbf4-1ed7-45aa-0121-08dcefcb7712
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8945

From: Ilpo Järvinen <ij@kernel.org>

AccECN connection's last ACK cannot retain ECT(1) as the bits
are always cleared causing the packet to switch into another
service queue.

This effectively adds a finer-grained filtering for ECN bits
so that acceptable TW ACKs can retain the bits.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        |  3 ++-
 net/ipv4/ip_output.c     |  3 +--
 net/ipv4/tcp_ipv4.c      | 23 +++++++++++++++++------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      | 23 ++++++++++++++++-------
 5 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ae3f900f17c1..fe8ecaa4f71c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -417,7 +417,8 @@ enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
 	TCP_TW_ACK = 2,
-	TCP_TW_SYN = 3
+	TCP_TW_SYN = 3,
+	TCP_TW_ACK_OOW = 4
 };
 
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c94..2fe7b1df3b90 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -75,7 +75,6 @@
 #include <net/checksum.h>
 #include <net/gso.h>
 #include <net/inetpeer.h>
-#include <net/inet_ecn.h>
 #include <net/lwtunnel.h>
 #include <net/inet_dscp.h>
 #include <linux/bpf-cgroup.h>
@@ -1643,7 +1642,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 	if (IS_ERR(rt))
 		return;
 
-	inet_sk(sk)->tos = arg->tos & ~INET_ECN_MASK;
+	inet_sk(sk)->tos = arg->tos;
 
 	sk->sk_protocol = ip_hdr(skb)->protocol;
 	sk->sk_bound_dev_if = arg->bound_dev_if;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d5aa248125f5..9419e7b492fc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -66,6 +66,7 @@
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/timewait_sock.h>
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
@@ -887,7 +888,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
 
-	arg.tos = ip_hdr(skb)->tos;
+	arg.tos = ip_hdr(skb)->tos & ~INET_ECN_MASK;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
 	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
@@ -1033,11 +1034,17 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	local_bh_enable();
 }
 
-static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
 	struct tcp_key key = {};
+	u8 tos = tw->tw_tos;
+
+	if (tw_status == TCP_TW_ACK_OOW)
+		tos &= ~INET_ECN_MASK;
+
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1080,7 +1087,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			READ_ONCE(tcptw->tw_ts_recent),
 			tw->tw_bound_dev_if, &key,
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			tw->tw_tos,
+			tos,
 			tw->tw_txhash);
 
 	inet_twsk_put(tw);
@@ -1157,7 +1164,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			READ_ONCE(req->ts_recent),
 			0, &key,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos,
+			ip_hdr(skb)->tos & ~INET_ECN_MASK,
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
 		kfree(key.traffic_key);
@@ -2177,6 +2184,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 int tcp_v4_rcv(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
+	enum tcp_tw_status tw_status;
 	enum skb_drop_reason drop_reason;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
@@ -2404,7 +2412,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;
 	}
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
 							net->ipv4.tcp_death_row.hashinfo,
@@ -2425,7 +2435,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v4_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v4_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd6515ab660f..8fb9f550fdeb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -44,7 +44,7 @@ tcp_timewait_check_oow_rate_limit(struct inet_timewait_sock *tw,
 		/* Send ACK. Note, we do not put the bucket,
 		 * it will be released by caller.
 		 */
-		return TCP_TW_ACK;
+		return TCP_TW_ACK_OOW;
 	}
 
 	/* We are rate-limiting, so just release the tw sock and drop skb. */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 252d3dac3a09..d9551c9cd562 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -997,7 +997,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (!IS_ERR(dst)) {
 		skb_dst_set(buff, dst);
 		ip6_xmit(ctl_sk, buff, &fl6, fl6.flowi6_mark, NULL,
-			 tclass & ~INET_ECN_MASK, priority);
+			 tclass, priority);
 		TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 		if (rst)
 			TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
@@ -1133,7 +1133,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
-			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
+			     ipv6_get_dsfield(ipv6h) & ~INET_ECN_MASK,
+			     label, priority, txhash,
 			     &key);
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
@@ -1153,11 +1154,16 @@ static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			     tclass, label, priority, txhash, key);
 }
 
-static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
 	struct tcp_key key = {};
+	u8 tclass = tw->tw_tclass;
+
+	if (tw_status == TCP_TW_ACK_OOW)
+		tclass &= ~INET_ECN_MASK;
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1201,7 +1207,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
 			READ_ONCE(tcptw->tw_ts_recent), tw->tw_bound_dev_if,
-			&key, tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel),
+			&key, tclass, cpu_to_be32(tw->tw_flowlabel),
 			tw->tw_priority, tw->tw_txhash);
 
 #ifdef CONFIG_TCP_AO
@@ -1278,7 +1284,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
-			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
+			&key, ipv6_get_dsfield(ipv6_hdr(skb)) & ~INET_ECN_MASK, 0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
@@ -1747,6 +1753,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
+	enum tcp_tw_status tw_status;
 	enum skb_drop_reason drop_reason;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
@@ -1968,7 +1975,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN:
 	{
 		struct sock *sk2;
@@ -1993,7 +2001,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v6_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v6_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
-- 
2.34.1


