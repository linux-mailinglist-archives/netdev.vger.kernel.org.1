Return-Path: <netdev+bounces-135566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228F99E3FE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AE5282932
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3161F7080;
	Tue, 15 Oct 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="o72X9GUO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7881EF928
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988237; cv=fail; b=sYmx4wLudoi6Ks7v6xRUspwlhCoMusrP4/tCwtmHBO+9uyXu7hkUJ8rTtw7PGMFjW+Ny48ENUhK+lyc3byrGQ5F/85kkwfiIATC2frlt5ApSNou2iis1Kz0KQfDCUbrupcVeCva2NOsue7bxN8pqpsX/pJruZ6mH475flUVSx5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988237; c=relaxed/simple;
	bh=m7ZFbhE+q6Ubo9equZlDNf2HvkGNHhW9Gqn/b1++HCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV72nfiO6aj7x9jIsA5jgFCdbatV9QBj89yLCR4eYX6i4vOQe37pRo6p3YykolQokxENvXH5ukO83PaIpz22WkENRuNwOWhnb6gQ7C2kHHPTh0kl2MJ1RCxEoAD86ADFGOq0qGPKCZTOncmkx9UJrWfc+9xTXcWJ2IkUPFRo2fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=o72X9GUO; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1A7rQuy112l8Cc1hFVdab/j+muAgN9nK8wDJhEf84kNlVIU4lPNajGkFwfbqWVY1A8PoK8a3vXRfyV8eKzkozfALbXThN0jOYMfiTKPzGqJ3FqgZ1fO7TssL+3H898MInqa3cDWgTqxcghTxEozgyRPAOD6CLiHjS3HZbSOyD7zlUwnp3AUvGvoNnbNayBDULNYRU5gJlRW0nvfZ9dX0PiieBdArRuA1w6o7UbZF3EFYcpjFQxE+0oz9Z3/HHuSm22/zOWZOe4fLEZo2qBJDUQVncnDdcHwrpLno/eZWmWQaAtDfPAdFHXx1XVt/R+fkBoSaC0YDID0OyGFMVz4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZfkgv0GIEaWmXgw+T300VxmuZzovMl/bQtEbA19A1Y=;
 b=r94PENJLsr8wqfi68cT8Fpa/vmAakRavJCHSG8tHGkEK7tuYwUZuybgV7NiBzp/3IS8WEZDxQnaztag9O6PpwPNmifgPqx/TkjzebFkL793oG8QrAM2j6aTo7KkNb5Zz3QhdumwATurwVyllplALw7gL8KquJ1806ICrL/zpvMW86PNMrc5gbRrh42qDwIe4jFY4h2e4AFzMsbgDLqYoFAYgSVl8uV7+8d/Aj//9cyfoEz4/fdKZ2DAK+p8ay2hAxtc6p1FrXsTxNaBBO7pIx2zX0sha2fJLkXGRsu7EyI4dd1n9yKRmkB5kMjoo5prkDTc6tt9TRHlr+UNVw0s7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZfkgv0GIEaWmXgw+T300VxmuZzovMl/bQtEbA19A1Y=;
 b=o72X9GUOVPRLS2tLv7rMpEzTAU4vm+Y4IKodpu4r3RMts1qCudS0C3yEcqYMprJwYZ6dItRBMJh11Dn0NGX3bt23GXm2w/wPFV1e7wAmPNqLhr3VQvEuCjihJKPmxk4fHP7FjLBvhletrCh6MNU/lpqb2pW5mhNgRJo77oLNnJ0VEK7mun3i33gT2X/rtf9LVpoi5BweTebdT+MERasFjzCrYyEnpCebNbNg/aiD3uRrGzdlMoHDiZhk58PPUk5j0lRHO5F8JJoSgnXxJjWaXxd/djL1eD8gBv8sXCwUFx2cDEdSR8sZweDPDhAOdfZfe7qth+FVr7F8MJICt0kEEw==
Received: from DU7P250CA0029.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::18)
 by DBAPR07MB6680.eurprd07.prod.outlook.com (2603:10a6:10:182::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:29 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::db) by DU7P250CA0029.outlook.office365.com
 (2603:10a6:10:54f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnW029578;
	Tue, 15 Oct 2024 10:30:27 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 28/44] tcp: try to avoid safer when ACKs are thinned
Date: Tue, 15 Oct 2024 12:29:24 +0200
Message-Id: <20241015102940.26157-29-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|DBAPR07MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 838707fa-44c6-47dd-29c4-08dced0463d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3RVaXNwUjdSVE9ZYVg1NjNzRTFQQktWK1krd2ZxS1M2MHJCQk5acjFYWTJz?=
 =?utf-8?B?SmtULzNGd0JkU0tLWHVXdWJuektkbFkrUHJrSFRLQ0JDdmluMy91ZTVwdXUr?=
 =?utf-8?B?ZHppNmhiOWI1UkkvNklNRWFXc0VqcFRSUzlaS1NDMlNqTDhzYnVhS0t0N0Yz?=
 =?utf-8?B?cHB1UU52MG1ZUXhCTmFQeXBQMDRsN2QzZWRqRzNPbnpYa1JXa1F0aHl1M0ZJ?=
 =?utf-8?B?d1BtS25QdzBhclBYU2NvajhZVDVnY091RlVRL0pSenZCcCtDOTY0MmZEbG54?=
 =?utf-8?B?K0dQRnpweExCSnhtdm5BZjRvdTBrYUQrSDNGdVN5V1FYN1dib29TSituRkQx?=
 =?utf-8?B?TE5JdEU4R2RJQjhCRmNmbllnWTFTemIrRFh1dlR5blBXdit5cm1GajljNSt0?=
 =?utf-8?B?ZEJoRHRyeFpxVzZHVlUzOThOaFYvanYzUWsxUVlrWFVOQVFqT2dCeVZOWlk5?=
 =?utf-8?B?RUJmOFVZOS9iOWlpdS8vNTkwVkU1NE5nek1DelV1aEsvbUMvMmU4aXQ1Ync3?=
 =?utf-8?B?dkJmNGR6NlNxT2NLRHFjWjZPdjExengwWVZkNGowRUs0WmhqTE1KM3NoR1Bx?=
 =?utf-8?B?eWtPbTh4OXZsdjdYam9qcVB6NnFIT3lHSVgzN0k2Nyt3OXJUT3gwQXFBNEkx?=
 =?utf-8?B?N240bzAyN1Rjb3VMNzJtSjJod0NBbFA3RmhmaW9xR0ZLRkNuaDBOSXlNeXcy?=
 =?utf-8?B?ZUxQZTlLeTVsMDNOak4ycWJKUU5CNkl1bEJqbUhRbk1DclNxNENXWXFYYzc3?=
 =?utf-8?B?MklTdURaTHFTUCtvc1E2aVRWOTk1T1JZTFYrOHhDb1M2VythOWlZb3JSbGRa?=
 =?utf-8?B?enpFN1M1cW9ZaXYyVXRPak9aWS9MK3R3OEJpMm5acTJ0bVNoZGdrZ0ptUERp?=
 =?utf-8?B?Vm1POHlXMEZNWmE2c0ZDR05Xc3NLMStFSGRocHB3eE1DMlErK0xVUXpVS0xX?=
 =?utf-8?B?c1VuRENVZWsveElnYnl4dElCWmgwVUh2SUkzQkRrVUlqbkFMU3F0R3JSTExU?=
 =?utf-8?B?enh6K2txNlRiOFdVamgwbFlNTldRYkhJUmFQVVpjckhYQ0E1dVc4K0lPOUN5?=
 =?utf-8?B?bmx2bnpsQW42Qm1rQUF4QWtFSm5sZkJQNVNtdTJrNUU4TTFLYkJkZ0VVL2dq?=
 =?utf-8?B?ek9uM1pXUGtHTWtqdFJqMUltMER6TE9scXJUMEVRUzZBS1VjWVpub3FFTnhG?=
 =?utf-8?B?cmxHeDNScU5hMStJSEx0Q254eXJWUjAxQnFUbEZjSDNiTnpqcWxYbTlMSTdK?=
 =?utf-8?B?eXdwcXlNK3hDellVV1lFaEVWUXJULzlTT0RuL1dLb3NmTHR0a0V3cDU2dm90?=
 =?utf-8?B?aGFNOWJhRTVOZzNBcHNNRzNXbTZpb1phdFQ5QktIRGZPN2xaN1JBYzNhQXNw?=
 =?utf-8?B?WDJLOHRIaTFlZ0VIQXFRakhCTzJQM0diTmZ0RlZMVVVkbVRMRTdIMFIzWDRj?=
 =?utf-8?B?Vzh2NHhjanhySE54cFlRWXBqMzI5U1NScFY0cXpocTVPbXVEem1kRi9teThM?=
 =?utf-8?B?Q0FNaUdGZyswanR3alZKYjBJNExNWWprUFVUWFFhV2J5RE9mUDZHcWYrbDdL?=
 =?utf-8?B?TVgxbGM4cklVb25lK1ExVThlWmJTRkRYc1laZEtvdVdBUGtlMTJ6d0NZT2p3?=
 =?utf-8?B?NVpna2VmeDRGZUdEZG5EWDFyVUE2RmVqSERYUkVtT1ZRRjhTemV0b3R4a3hT?=
 =?utf-8?B?Y0w5NHRiTEpUcDdaTnRDdmpoV2s5M1k3eHNIT25EMXVFZ2w1TUczNVROY0Ew?=
 =?utf-8?B?S0Y3TURaTEJyZmU2YlFiaDROZlI2dGd2dmxETHp0WXB4azcyQUVXWFd6VVVl?=
 =?utf-8?B?V0RtWjZ3cCtkT2FEaTM5ZUdJT2ZkeTdRT2NZQ0hsTkhlcVBMdHAzaFNSKytD?=
 =?utf-8?Q?gXjvQ3pa3uXJJ?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:28.8590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838707fa-44c6-47dd-29c4-08dced0463d7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6680

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h  |  1 +
 net/ipv4/tcp.c       |  4 +++-
 net/ipv4/tcp_input.c | 20 +++++++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index d817a4d1e17c..9dbfaa76d721 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -309,6 +309,7 @@ struct tcp_sock {
 		prev_ecnfield:2,/* ECN bits from the previous segment */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		estimate_ecnfield:2;/* ECN field for AccECN delivered estimates */
+	u16	pkts_acked_ewma;/* EWMA of packets acked for AccECN cep heuristic */
 	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7ef69b7265eb..16bf550a619b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3343,6 +3343,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5043,6 +5044,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
@@ -5051,7 +5053,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 132 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ac928359a443..b1b6c55ff6e2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -665,6 +665,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes, int flag)
@@ -681,6 +685,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			tp->pkts_acked_ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			u32 ewma = tp->pkts_acked_ewma;
+
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+			tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+		}
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -722,7 +739,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 			return safe_delta;
 		if (d_ceb < safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


