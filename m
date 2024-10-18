Return-Path: <netdev+bounces-137161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E449A49FA
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F88283EB4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919331922C9;
	Fri, 18 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Mg8b0H2X"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E85191F60
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293632; cv=fail; b=I7J06eaJl1hZ4dQLQUHF80M45+PKq8+S0U7OQWJNfofrmj9ul5g15fb4x9mCI8lWLLY66qsupOURzHtDCpLM+7coItEIXa4LUtHyWtU3b4dnAyieblDG56dLhslm7GWldQQ6Fj9kBE3SGCkkuI9dqyka91w5v6qc7JJS0P5X+JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293632; c=relaxed/simple;
	bh=iqP4Lrn2Z/fBm0RWoUJbIosaP4CJmoZQtGIJjWwHjO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQuHTPe1uhokYZq/cvETa4yfNgYekU/351jM3HCvJx6F3d0USu4fEKKluedhq7r8XBsejgvNSqV6EXBkdHt1f7zVeAVMzq1JpCKTNshN96NTHY2ODQwXa7tDI4zDvkikZXt5KJBKvhjZwLvdLgE2zecow0KCwJmpgY3Zmug9EbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Mg8b0H2X; arc=fail smtp.client-ip=40.107.249.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB3HfSg54H7nEUun6RAjRKuhdhw18F21Mq196Pn/IznZkldz0rPCCRphbf3nYRdKwLFWL2sVp4OA0qCvl50Mapa80HCK5NnayALXS64I4wf9vVRsA0EH5FY6QY1NuRVohJDy4oJWwE46wDqZBqhKa4NIN8yvzy2IYa2gL2Joc1FAquMdpFMn0WP5QGY0dJ/aqbpMaNqlj44g7roIuOqooZiIMNa/r7B94U6p1dckBnD30DVRDkFuCH7++i2hCZJLz4mIRa3oEuYakrB/THfQIsxBjuLNy3xPTk4kv5MNgk2z9v+iD44VENlLQlCWFZf6y26xQcKqjkNVRq2zqlfUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=NU5lIh0ET4lYWPRn0L6WSEOqAeXrd1u8oJbRBbmljy2++jqDjLu2MKMVH6+QTwWKOkblD5xPUM4iTRELHg7IkwDGK+sUrnJb/NhT7MXfTN3rERxMadqXMcpeMkyfmv0u+pBaO43ip00SF1Gf/rLtxD2jhfVk445nBHdldbfWENGh1J/hvSojevTHsIJlOTK0Nu3qxL+AYa/1yhKA3UxUGXsmE6tcO5SG8nspQnBasrNvYGw0qZwSo4JfGAMn8xTbELa/H0L8Zm9KonfFLhDcSuMxrC/iLoVlMPMGkEVdZamV2rZOVI2WhdMhWgBdAn75k0HL08t2gY5nz6h1mdyRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=Mg8b0H2X78R+bDBijffB/M0mkBUdECFJOgw/pvMLrRDwzGHqYRtPQs4JP3UqRqcNTFGAZ3i1IFNpcreY1592Ci+cjvY69PwwfbKbc8gARKplIBP4MHvV3cQQ1BNfNpNekIcqmRgcuSu9vjeCTnCIo36P3C8bOCMjG15EDW+WQGgQH9Xm4CCuhAXCH95XNnEp6+JAGv6Dl/tc9i8CSUSMj8MVtbF27RcSqUxSxD4ZoAdskY+fPSWLrHypccbx5omxssZRSGNCPqPEWAtD6wfwHHyjuuVcKfF+COYTZ70VqEc6tGBf90bxl2zIPaZrqUSvFpxbfBWczy6GGMAMdyCflg==
Received: from AS9PR06CA0759.eurprd06.prod.outlook.com (2603:10a6:20b:484::13)
 by VI1PR07MB9706.eurprd07.prod.outlook.com (2603:10a6:800:1d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 23:20:26 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:484:cafe::b9) by AS9PR06CA0759.outlook.office365.com
 (2603:10a6:20b:484::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJQ010239;
	Fri, 18 Oct 2024 23:20:23 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 01/14] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
Date: Sat, 19 Oct 2024 01:20:04 +0200
Message-Id: <20241018232017.46833-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|VI1PR07MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: 194d5db6-4582-4bfb-02ae-08dcefcb71ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1VQSmxudGQvZnVHSll3N20yQlFGZUUvdnErQlI2WC9xbVQrQ1pSZDVJQ3Rm?=
 =?utf-8?B?NUduc0RIelZmUy8wQ3RCM1prVXhXK3JIY0IxRjRUanVUUHA0bnlramhDN21B?=
 =?utf-8?B?b3BlOUdzUXJYY1gwcS8yT0JZRHRWakZLVGU0VmJ0QkF5V1lyVmxMK3RQMGNP?=
 =?utf-8?B?SFU1VHhyUE5xZC9MamN1RHVGMzFud3I4M0w0OGxvWE5ON3ZSYit4WVpVNURu?=
 =?utf-8?B?SmtncXJ5MEp1Sk9Dc2RYa0tTZlMzeFhIK241U2FyZ29NdkhWUDFQeTFnMTZN?=
 =?utf-8?B?TlVYNDFnMklEYkRESE52QTBVSXhPcFJ6ckcxdmNZOEVRczJncmJpS2hZcmFJ?=
 =?utf-8?B?emJSRFpoR0JaOFM0NDR6dG9XY0hwdUZ6UjFQOFROSWpvSWdJZnh6SmtFSVBS?=
 =?utf-8?B?RnNPSG9FRU1HMHZPUExLZWtFRjV0OHpuaUx0Z3NLQnVReE1hMGtkc1Q4c1B0?=
 =?utf-8?B?TUh0aWpkNFB4Tm0wWXJ3dmtrU3FZeDAvU3N0bTg2N3RQVHlTdmlnL0Z2QzZ2?=
 =?utf-8?B?T3I0QUphQS9IbW1qZThDOTQ3alFTWUxwZ29wbEJxeWhIdEdnUTJ6eElIVnl1?=
 =?utf-8?B?eFBiaWpjMkZKRmdGeUt3bGdRQmtRekNCd1dkUGFNZXUvN2lIZ1pieWNpOXVi?=
 =?utf-8?B?cTBFNjUrY3RLU2JwcGdINHljYzk1am1Meml6bkNtbTA5NWkwdGdaR042VE5o?=
 =?utf-8?B?a3RaaUN5Nmpxd3k3U1Ywa01hdnRzK1phUFRremJSMmc2WmhjZzBDN2w0NzRS?=
 =?utf-8?B?NjhVZVJFOGIxQnVMdmF0Rjh6MTl3ekF1M3F5SU9PVnJPS0RQT0NGYTVycFFv?=
 =?utf-8?B?Ym9rcWdNWnJEZUFaNkJkWjRjUUhEMVdEOEVPQ3Fqa0tCREh6Z0l4ZE01Q1ZT?=
 =?utf-8?B?RzNlcFRXcUh2YkF0OXBIcXVhMU5LUVdZMk5DUjRZZldxOSt5YyszS1g1RElZ?=
 =?utf-8?B?OGZQd3lwdUlGRWljRUFzQ0d6OEdlQ0xkclRUV1JyTkYzZGRVVkdKY1EzbzFp?=
 =?utf-8?B?QitseTlQUTN6akM2OEQ3b3ZncHlmSFQrWG5hNytzQXc2bEdVOUlFL1hlc3ZR?=
 =?utf-8?B?bW93MUdVVW83d3V5ZVlHSlo0RWpKT2tiYTNBekNLQlJtcDV1cXd3WlMrZW15?=
 =?utf-8?B?VXBZRFpOYXFOelFydGRYMVcyYVJoRVV1NGZSbzdKL2dSTllhclFLbXExbmtP?=
 =?utf-8?B?YklrUWhkWktNSHJYL05WWS91dVRiSGp3MlVRQU5kM1ZFSXdKbEQrNjdtNSs4?=
 =?utf-8?B?bmZlU0JlS1Z5ZjJzSVZtZjhIMjIvOUIxRXdEaEFQNVE3aS9sdUwxbTlhaVBq?=
 =?utf-8?B?bktPUzJTMU5NL2paWUZ2MFc3V2MwbWJpb0VWeGJGc2hKay9oUlM5S0hpUXZZ?=
 =?utf-8?B?aXByS0NpWFgxTm1sdm53YzA5YlM5ZjllT3JRWGFTVGN1WWp6T2JROGFZSzVn?=
 =?utf-8?B?UmwwbjBmcVBQbFkwRXNzTjRFQzhJN0Y2QkxEeGxkdlBTUi9oN0ZHVU9WQW5N?=
 =?utf-8?B?MlE0cFJGUGFPazd4K3pTQXp3MGpuSFZIZVEzQWdyMEJ5ME55YW1SRW5zKzFp?=
 =?utf-8?B?QkNIZFB1MUpZM3JvSHZYdzNwR0hibmR4bTZjVU8rQ1N3NWtyMU5zNnJxd3p4?=
 =?utf-8?B?UzFJYWJwQUk3ZHhZbVRaN1dJMVlDNTZEQVdlVjc0SzE3aTl1d0s1cWN3eTlP?=
 =?utf-8?B?aVZkRkorYWNaVGhlNkVRQ0pRaE5KUW9QMW1nRVdHa2l4M2R0clZFQmFETzEr?=
 =?utf-8?B?YmxoUTNnVG42V3MyZGpoMllIYU5aL29tNjhpNGpacmtJTTdmTTUza0tRME4z?=
 =?utf-8?B?em0xcW5yaGhLL0t3YlA3L3Z5QzJwOUVFUGNnaWpjM0IxNXo5M2pnVnd3S0pn?=
 =?utf-8?B?QnZocUs2NmJIQURqdEg0RldIQ1hqd3M2NURFdVdpVHlsWTl5Ym4rZGY0U2VX?=
 =?utf-8?Q?rvN1BkS6QPk=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:24.3302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194d5db6-4582-4bfb-02ae-08dcefcb71ae
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9706

From: Ilpo Järvinen <ij@kernel.org>

- Move tcp_count_delivered() earlier and split tcp_count_delivered_ce()
  out of it
- Move tcp_in_ack_event() later
- While at it, remove the inline from tcp_in_ack_event() and let
  the compiler to decide

Accurate ECN's heuristics does not know if there is going
to be ACE field based CE counter increase or not until after
rtx queue has been processed. Only then the number of ACKed
bytes/pkts is available. As CE or not affects presence of
FLAG_ECE, that information for tcp_in_ack_event is not yet
available in the old location of the call to tcp_in_ack_event().

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 56 +++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d844e1f867f..5a6f93148814 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -413,6 +413,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
+{
+	tp->delivered_ce += ecn_count;
+}
+
+/* Updates the delivered and delivered_ce counts */
+static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
+				bool ece_ack)
+{
+	tp->delivered += delivered;
+	if (ece_ack)
+		tcp_count_delivered_ce(tp, delivered);
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -1148,15 +1162,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-/* Updates the delivered and delivered_ce counts */
-static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
-				bool ece_ack)
-{
-	tp->delivered += delivered;
-	if (ece_ack)
-		tp->delivered_ce += delivered;
-}
-
 /* This procedure tags the retransmission queue when SACKs arrive.
  *
  * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
@@ -3856,12 +3861,23 @@ static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 	}
 }
 
-static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
+static void tcp_in_ack_event(struct sock *sk, int flag)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	if (icsk->icsk_ca_ops->in_ack_event)
-		icsk->icsk_ca_ops->in_ack_event(sk, flags);
+	if (icsk->icsk_ca_ops->in_ack_event) {
+		u32 ack_ev_flags = 0;
+
+		if (flag & FLAG_WIN_UPDATE)
+			ack_ev_flags |= CA_ACK_WIN_UPDATE;
+		if (flag & FLAG_SLOWPATH) {
+			ack_ev_flags = CA_ACK_SLOWPATH;
+			if (flag & FLAG_ECE)
+				ack_ev_flags |= CA_ACK_ECE;
+		}
+
+		icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
+	}
 }
 
 /* Congestion control has updated the cwnd already. So if we're in
@@ -3978,12 +3994,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_snd_una_update(tp, ack);
 		flag |= FLAG_WIN_UPDATE;
 
-		tcp_in_ack_event(sk, CA_ACK_WIN_UPDATE);
-
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
-		u32 ack_ev_flags = CA_ACK_SLOWPATH;
-
 		if (ack_seq != TCP_SKB_CB(skb)->end_seq)
 			flag |= FLAG_DATA;
 		else
@@ -3995,19 +4007,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 			flag |= tcp_sacktag_write_queue(sk, skb, prior_snd_una,
 							&sack_state);
 
-		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb))) {
+		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb)))
 			flag |= FLAG_ECE;
-			ack_ev_flags |= CA_ACK_ECE;
-		}
 
 		if (sack_state.sack_delivered)
 			tcp_count_delivered(tp, sack_state.sack_delivered,
 					    flag & FLAG_ECE);
-
-		if (flag & FLAG_WIN_UPDATE)
-			ack_ev_flags |= CA_ACK_WIN_UPDATE;
-
-		tcp_in_ack_event(sk, ack_ev_flags);
 	}
 
 	/* This is a deviation from RFC3168 since it states that:
@@ -4034,6 +4039,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	tcp_in_ack_event(sk, flag);
+
 	if (tp->tlp_high_seq)
 		tcp_process_tlp_ack(sk, ack, flag);
 
@@ -4065,6 +4072,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
-- 
2.34.1


