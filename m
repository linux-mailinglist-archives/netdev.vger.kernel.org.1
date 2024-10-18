Return-Path: <netdev+bounces-136824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC59A32AB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F56A1F2486E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61893176AC8;
	Fri, 18 Oct 2024 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QZA2MT8b"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FF1741D1
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218138; cv=fail; b=ADN8aRMZcXPWZ7Ao7kiafAA9/NgJ7vXG1R0WgPIuI2WFvetPJMn+gD/AhnlvazEYLeictBEPIF5Guvr3VfqPO0e2KCbvEjMQ64ZiaiqOYNeTtK/7B+ES3ns06T/2EhiJW+k2/L2niEy7F/jNmfhpTp4cNPpxn3TRBplpdncaW6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218138; c=relaxed/simple;
	bh=ZZLBBPsXEl76UOxnvAZ1AxEbusKk9Gb/BZJI0Ei8xMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FM6AhnRZC1YmzGnUPuNj0/eFpv6Tmd6mmRcz5p9r2JXokM+JHi8NmGgqRGyAsuwy7NLh9YlgbMm0ImiyusJG5KKoF7GUSp+6TauYmjzCtPbRc2azoja6iGTeZJ/ys3U0A7jKY6sLm9lnu1zRdh+tEJ+CWtVIpQSTYra1HbI+NXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QZA2MT8b; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B726S+2TaJC4JNF6v6V4Gy1sUby2Pb0BDJYuw2Ar+jgjz7GwNvbhQgVM/wqCctPI9zMW9vIbtHiqXtwCKtuf7SvSyhZEjQ/f7rwgdvc1u5AHNX0jNvmR/188PWzK1Uj79NqcWmFQsERF3fxJK4xTGLbi4DTUKjtj+IlotF2UoI3dQHV2fsD4dHeddxFR3bAmb1oH0EWlsHFNZ2eQSC8UMEryjyuNDJHXHI0ohRDkjqwqFHP0kjMkwwqxmJqE9/tJmIdXrOQlO4sSkw5uEQVL/MBF/NZO526zmXMZ+bechw+GXfUDZibTIAj/9fg6FneaQxYPf4Uv9UBtvxAmxOpESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTd4kCFgA0flO2yxP58SbyTLmsBf6cIegpV9zqGv+Ho=;
 b=NJewbaem17/YV6wx5wPauQY0YqkqQRwQ/PGBx+UJRwqd9tCEbD+2zmZcvQTCZlqKqnDYCXXR51AnVnYzdI44fdCJh8qe3LkWjQyQwhcwLd+0gEfF77F4SG7jaUYHm7j93/AGfseLWCCKs0a2iHf39by5xyT7LK8oKY5XT46aVVrmsagssjmao8fu2ZJdP5K1RwtzVAgTYSalFhUVO4JiYrs1t5RiAthV+z4+i01MNXctw/EokhNTrf8Z7Fv8n5B5EYEZqUROr8tfucnB3Encjp1iJO9s3266fffIFeSmS7//NJx3ggm2XRXBMpV2KvmnR3AeePWJ/TS+TW3N7NAGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTd4kCFgA0flO2yxP58SbyTLmsBf6cIegpV9zqGv+Ho=;
 b=QZA2MT8bbOQsgjYtxNzctysCQsOCx2YN0FA+VIK573QVMfLYFTPrFf+Fhc/glMUHzhozlrXofiG4Hd2FEO/2IjteD4qAFsTLtd6WFdMBkdqQ/0Mc2NwbxpGJ3uIe5RY7qidIxXO55mZiSnQfwcD6t0tNrhCdoAIAG+6lcZwXkeaIQQ2MCoAuWyiVoRITPxV9OysNqJuLwbHcPDXFvIBcGi4T34LamsjGmRRTlF+tJunKu9x3lF7GP8NZyUMUhcf8O3XKgK02SzVuUZ9ZqJW7FvezMCSGSrRa6EEEgJ9jaswav/b37nlsFFgcuk9vJ7ruSJhYlOBv1edzmRekdfzVkA==
Received: from DB7PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:10:36::36)
 by AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:22:10 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::fe) by DB7PR05CA0023.outlook.office365.com
 (2603:10a6:10:36::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:22:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Mf023685;
	Fri, 18 Oct 2024 02:22:09 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 11/14] tcp: allow ECN bits in TOS/traffic class
Date: Fri, 18 Oct 2024 04:20:48 +0200
Message-Id: <20241018022051.39966-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|AS1PR07MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 3292fa98-b830-403a-358f-08dcef1babe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjVxWnpLUTJqcFJySHhzMXYvNzdpeEJXTTBUR3B0RlRhWGFtTGF5NC9SSGNo?=
 =?utf-8?B?ZzZIMXF3MkJkRmtWcHVrWGJjWDJuU0NsZmFrWE5TdS92L0greGE1RHAyUy81?=
 =?utf-8?B?MlI5QXc4TGM0YmZaYnE1S3hNZjIvQnlzZ2JyNWtPZDJuYkZ0WEFIWTBobXBy?=
 =?utf-8?B?Nis1TGUvQWpjeCsvUnN3ZFkzMWJPa1BDdUVMSER3K0R5SkxLaGFHaWVSSkha?=
 =?utf-8?B?RkRxVnBJZU41djltN2VvNHM4emFiL3FXWFRXNW80dXhWMkU2SC9XUi96R0dk?=
 =?utf-8?B?aHRpTW9hbS9SM0M4SUptSGpLeStZcW9nbm9rZHU0Y2g0Y0E1bkRlVWhOM0do?=
 =?utf-8?B?WDBpalpNeTJER2VKbFdCMEJiRjUxa0JzbnpYNThxQlZmbDlCRDhIdGVlVXBr?=
 =?utf-8?B?S3J1RW9nZHM5Wlova1pmdGFlZk9Xd0FXM3NlQit4UzhLdmVqMzNXeXNjaXpx?=
 =?utf-8?B?OWViVjF1dXBIY2U5cXlGeGZnTHoxeVpIM3kwcWhITWRYSTJRUm05RjQ0TU1X?=
 =?utf-8?B?OTM0U1B4ZUswWElvMWdKMCs0UlJRV0svRlNTRnczRmFBYktqU0VLSklMQjFq?=
 =?utf-8?B?d1VwMVNxNlRPa0xOaXBPVmpZNjZZRU84VGpRRHJ2QnQ0cmZ5REk3RHJMK1NC?=
 =?utf-8?B?eHB1UWczWFVkS1NjRlNzR3JHbkZXS1F4U09Vd2FRODJBV2VXRnRzRjdaTUpQ?=
 =?utf-8?B?MGFKOER6UW9PMWxlRUE0K1NLNWo2STV1dDJFU1dUUlNPQ3VBZWtpSFVxd0pH?=
 =?utf-8?B?S0RCVHVIM3NVTFM4Mk9lYllyVlozNUVHa2hkaUNVZnZLZll6UFRIMWpMWUM1?=
 =?utf-8?B?TFFJRlVQWGFXU0N2WXZDMUNFUWlXVHpEY3ZuUE1DSWQxNTJKL0xEQ3dCL3Rz?=
 =?utf-8?B?YTIxODA2NC90S3FTM2hxMHdLOWNhUGpIRHFCeGVDM3hQM21DekltMWFnQW03?=
 =?utf-8?B?V3krZng5K0VFaFBYRVJJUEg0WjE1SndsZEJNd3VkMmIySmh3RzdBdDkvZmh4?=
 =?utf-8?B?RWhRUTh1S1BTZVFNVzlXRkc2amo5VzZjUytnRWR4VFpPUWRDeVQ5SFBJMXlx?=
 =?utf-8?B?dm1LMVZGTGh2bEJKOUNLODJ0NmVSbXg5YUxHbi9sbW94VUh4aFZKNHV6enE4?=
 =?utf-8?B?YS92c0JUUnV5YVZtTGhCTkhtc2lCVWtuOVlGMzl4U0ljVXQvazMyRUVoVWRM?=
 =?utf-8?B?cFl2ZG40cTh5SW1OdkRhWSs4c0VSbWFiOG40dnlzdU5CRi9yNThUOWtvZk9B?=
 =?utf-8?B?VVpSS2RYbWtXNDNjR3FOSVEyb0d3Q0NqMjZJL3hLRjRtQ3VnL3F5N2pOcGta?=
 =?utf-8?B?VzNLZHphR3V1ZmZmMGJjTFFjNkxjSHpKNGxCZmFja2VCcStqZTVwbVRHVDA3?=
 =?utf-8?B?TDJQdnh5aFdTRUhQTWs3TWdPc0xpZWdtYWM5NlRqWi9iYnZGVVB3UEcxUEVM?=
 =?utf-8?B?eFpIcW9rYk5icXJwQ1pLN2ZzcnBJeU1CSFRkSlhpZUZ0OXdGbkFITUFkQUll?=
 =?utf-8?B?RUZkditNb1B5MmFvTWRqQlU4ZG9zUTh6R1NVK1BJcEthYXdoWlVwWGF0Nk84?=
 =?utf-8?B?Y2xvbXVUbmxwMVluQkRPWDV5U200VllyNGNZUlRsdnVsdHlJZDV6RVlBdXFo?=
 =?utf-8?B?U1kzcmdjVHRYL1VoelhmVFF5N3RZN1FmL1BQVGdXYm9uajVJSUdwbGZkY1hx?=
 =?utf-8?B?dVRWMHBVSVpzNnQ1bUppak5ESTcrdnhyRWZTN2NTN2w5UzNjYVlzSDN1U3No?=
 =?utf-8?B?Nk53ZVhQZUNvbVdiSzlOQ0dmWm9VbS96N3hIQ1RjUklVVXBXV3FkQ21LRnhv?=
 =?utf-8?B?bDhUS0lqSERtQmtrWVo4MVZ1RjJ5K1I1V2syMFdkeWZIeFowRzFLRDJKc1Jw?=
 =?utf-8?B?elpHTkVQQmtwOWNQcER3aGtTT2hBdmRZWkhjV3ovOG9COG9XS2lCT20rSEw0?=
 =?utf-8?Q?viAgP4ct9kk=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:22:10.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3292fa98-b830-403a-358f-08dcef1babe5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8408

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


