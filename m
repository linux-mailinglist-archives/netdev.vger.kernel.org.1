Return-Path: <netdev+bounces-135575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B599E407
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9692328225A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274171F8EE9;
	Tue, 15 Oct 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tbJB3STr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217F1F892C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988242; cv=fail; b=LdQ95edL84TeIuZoYULMJlspVhWyJi3yS+CsVLnv+F+Z+HMBHyPnp2ZFogUMm4TvQg+C/GHlOaqkTCTJ99iCDNugtEavpG2lFJ/KaSxJCpq8vyNZwaq8CfTpRZElLLORGzl8yYeTb6eKGEOeShmjqJedGdqPL+fe0URHZ80V7RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988242; c=relaxed/simple;
	bh=m2bjuGZ9973GOriQACD6gE3iiazOgfcxNFe3v9lkr7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+nLVbaBOUGUs1q9/QF+fXsf4uawgNIdH7+uJ8brvAL8imr0xlm00LuEynQAcgnewq9xTmxuR+u/RhCxY62PibVfjM4QOC3ii65QbKtysqBgtgPNxo8SR8bz5388sTNv8UMI9iz7rlikfkKu+mWq3Dr6m6ZJevXSvFl5PLD8m5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tbJB3STr; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVAkQwlkGppXn2F7FbzxusC5wtlTadYj2SLqCeGyqu2IkVWTbZEZfMtfDMuokKkYx9sKvO0Iriz2BA92nmwKit70WgFDbBPLlqIpaiKMIpSc2ghvzQj4jhmOykC3zpIqN9Ecxm1ZPfxIW0mkATzemYR6zNqBJZ1C7YQkB0hMpmeCve34nyvW8Nc2wF31ximOFUyANAqpvA3WwP+zdQVswiHa4NzXCtY/P8kwHYygnAMSQNuBIQvwCUUui09J9MiZhNym8+aRYIgirk3liyvR6SYLpFgiKMqaiENMqZvkq/uEZ6+KLMQD5bTkqnGySU6UTTV9squdQWrNsnoy4cjjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqz10crZQa689L0IhzGKSopfBC4GqxfMkmPM9aiowZQ=;
 b=VoIok/FvrApTuXoqpXsaZTuglC2lFWRv+J4/FE9Is0mDNktGW6oEVM7IOUoGQ4vBen3TLfiW1mPiBooj3hAqZTJZZWf/OfQQ2xuoAhY3KW13KzpxQEG+LjtWYJG6i082lbkl32Pc2n94SvX8/i++GxznOakUxMg4zklZ/CMd4PIR/4QpNiZ1mWmoIOBc4F8UuZ6YqJbeccBw+yvqbZJs+sBkHaQozGdzaXAIku8jAEy09HV9CMiOOazpPrVg6OBwiCRrUr5/Cw0IurqB0kAQg4PvrU/CTdytZMLjjPpadzi3/JhDT2XB/MF3KVNx3I5X/CsIwKfdPcE4smwDDX0Z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqz10crZQa689L0IhzGKSopfBC4GqxfMkmPM9aiowZQ=;
 b=tbJB3STrk5Je5tRJpOzNNVAF4X2l1dUp9/mcvQkgTVSqcg0jUr9vho9/xOaKjvW6OacCso28r9ZGhaKkQ7NAEAu+ZE42cuIaIBZstovKrcMzNOEoLalmeYiTfU1ebkznOJAwIqHqIUYnjdep3SFI27lcQIfUcBxVd4f/vHcrxbHNVm5G1c54xvDELb48BoE/BGMWHPjEJoPywdlaY/uDy8wXIiVeExHUEt/l0diM3/sBJr0bMoxkVYUD6xzWg2qKwS2VLno+E90Q1GJ2Sw0N+0zH1RAU/j0Qr6FBoBaBLcQQI0mSwSkspm7qTcaf78pALTbtF3cyyn2MIB3wG5dMlw==
Received: from AS9PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:20b:488::32)
 by PA4PR07MB7582.eurprd07.prod.outlook.com (2603:10a6:102:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:35 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:488:cafe::f) by AS9PR05CA0006.outlook.office365.com
 (2603:10a6:20b:488::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Tue, 15 Oct 2024 10:30:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnf029578;
	Tue, 15 Oct 2024 10:30:32 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 37/44] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Tue, 15 Oct 2024 12:29:33 +0200
Message-Id: <20241015102940.26157-38-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|PA4PR07MB7582:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d77be7f-91d8-4d5b-3b2b-08dced0466bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?boDaUdI5VlE9haR0WmaFdEUO95GxV3AcLCErgggbhv18lREWi62fxlxzR1mZ?=
 =?us-ascii?Q?dNBV/3X6eKvaUjNrTiT5adCkHRXsLHARWm/lTi7FBQ7AC/8q0FEUeqNsHm+c?=
 =?us-ascii?Q?uwy/qsp0Vq/4iQTPBsnVzCALa8IB9YHE4fWXF3cLoOnNg8rUaZCRvD4gnbl0?=
 =?us-ascii?Q?WCN9Ln6MSI41Lve3CLpafBzujmDp4E/xngAd7RK89FvW8cl0tXyMAQ0uZ3Oh?=
 =?us-ascii?Q?rlpV+yoOiNo0LdcOecsQfnXOqtq7OyB5NTkxSmu+MR1Lksp4XW2gxZJVvuhy?=
 =?us-ascii?Q?ygfQbvd/bKyisPERP2Rueo/iJwKfE4FOxbloBpf85zk+NjFh+AeVr6c6rkzm?=
 =?us-ascii?Q?lI/0B2Kqseuf42hxyx9TLX8ENX8eQE1joTiIRxwWFfgTU/auCOzEOfLlueTn?=
 =?us-ascii?Q?FPu5LOr1kBclRb07eeTQzqjPAOgzaMzWou1gE/NlgEvl1a7cmVn7UFdpv5V+?=
 =?us-ascii?Q?6IM+w31rvkPEfwEejzUKNfrFvfMh5xdnrqLljyXBLurpMQfoQUWgR98j4JTy?=
 =?us-ascii?Q?jqyOGRQchMLXJheBW2Q9IgD4jySfdlTj1K64ut5eq3EIf7R0NM5PUIuBhSbK?=
 =?us-ascii?Q?dzJgbhHnA8CFVZuXgECXFdYC/qAidLUDBNz+oSQM53eoJmon97AZ9ttbOHJU?=
 =?us-ascii?Q?1sozOjiuEVyabTZJLB+ogxVnxsnkPrm2gF6ut6yIMRPAPxioQCLkCk4PE0Oa?=
 =?us-ascii?Q?gLdwPk+ykLTkttchaqKIFJ+RYF0nLbfKeqxU/7cB4zCxZ3B9yTylciO3rj5D?=
 =?us-ascii?Q?SsPZmVUcp61ViT3/YCIHdFarS8AWl09Rcu6dZH5jN+UrKrIbKgz/HKvzX0wf?=
 =?us-ascii?Q?V9CxWuTo55ALytE4WOlqXetoicGwcVtF/+XnSTWvbmfvgUa8/xy1WZ0LqFmV?=
 =?us-ascii?Q?Bv3ztHR2QAeg7+1CLDPmj653l972qimJt9499WlmTrE3Y6xH8zO1RcGJHdld?=
 =?us-ascii?Q?KmxlxwycrKReYMAJKJbS2ZpJHr5NLPzxFjbwn4gQevos7R/01wAUGAOCGMp2?=
 =?us-ascii?Q?4sHFMuK2bjhZ7WINARd0UlOOvqP6PSy47zZHXLm1n3Ti2X3EuZWRhvufpFbB?=
 =?us-ascii?Q?G1DvvAabv7ZHsLdyLwbv3jWogcssp3lO92IayUh3LlAhSQJ6Q4bvTv9crgVd?=
 =?us-ascii?Q?4PWEYkn0BZ0Q3jgWQuR0lDeHpTk9hr+aTGQDmeMfcVkgZPtljiVbQRJSXRRJ?=
 =?us-ascii?Q?kNEATRePwlT4U6sh4H3wrow2BmIMGHUzh++qDiW8c154qfpABh/ryaUU0MJ6?=
 =?us-ascii?Q?jv6m5n3+YTGlv2mEcAiyPtGZUdOvN3sPyu24nB/zNW0Valqu4iZSTQVPmqjk?=
 =?us-ascii?Q?QtDoL1gfNWf4LAs3IzD9P9dZKaA9QZXJa4C1nnudwjQIf1SMHnK6hORX7pB9?=
 =?us-ascii?Q?sPg9Dh2eaF0itccLcZlMVAYC/cW00sV/ygiN3SbDp4FzwNeZxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:33.7847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d77be7f-91d8-4d5b-3b2b-08dced0466bd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7582

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

3.1.5. Implications of AccECN Mode - A TCP Server in AccECN mode
MUST NOT set ECT on any packet for the rest of the connection, if
it has received or sent at least one valid SYN or Acceptable SYN/ACK
with (AE,CWR,ECE) = (0,0,0) during the handshake.

3.1.5 Implications of AccECN Mode - A host in AccECN mode that is
feeding back the IP-ECN field on a SYN or SYN/ACK: MUST feed back
the IP-ECN field on the latest valid SYN or acceptable
SYN/ACK to arrive.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c     |  1 +
 net/ipv4/tcp_minisocks.c | 27 +++++++++++++++++----------
 net/ipv4/tcp_output.c    |  7 ++++---
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 062bb77d886f..e88f449e89e1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6497,6 +6497,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			send_accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				tp->saw_accecn_opt = tcp_accecn_option_init(skb,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 4037a94fbe59..301606ff1708 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -775,16 +775,23 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !inet_rtx_syn_ack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += reqsk_timeout(req, TCP_RTO_MAX);
-			if (!fastopen)
-				mod_timer_pending(&req->rsk_timer, expires);
-			else
-				req->rsk_timer.expires = expires;
+					  &tcp_rsk(req)->last_oow_ack_time)) {
+			if (tcp_rsk(req)->accecn_ok) {
+				tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+							    INET_ECN_MASK;
+				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0)
+					tcp_accecn_fail_mode_set(tcp_sk(sk),
+								 TCP_ACCECN_ACE_FAIL_RECV);
+			}
+			if (!inet_rtx_syn_ack(sk, req)) {
+				unsigned long expires = jiffies;
+
+				expires += reqsk_timeout(req, TCP_RTO_MAX);
+				if (!fastopen)
+					mod_timer_pending(&req->rsk_timer, expires);
+				else
+					req->rsk_timer.expires = expires;
+			}
 		}
 		return NULL;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e5c361788a17..74ba08a33434 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -397,7 +397,7 @@ static void tcp_accecn_echo_syn_ect(struct tcphdr *th, u8 ect)
 }
 
 static void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(struct sock *sk, const struct request_sock *req, struct tcphdr *th)
 {
 	if (req->num_retrans < 1 || req->num_timeout < 1) {
 		if (tcp_rsk(req)->accecn_ok)
@@ -408,6 +408,7 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ae  = 0;
 		th->cwr = 0;
 		th->ece = 0;
+		tcp_accecn_fail_mode_set(tcp_sk(sk), TCP_ACCECN_ACE_FAIL_SEND);
 	}
 }
 
@@ -440,7 +441,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 	if (!tcp_ecn_mode_any(tp))
 		return;
 
-	if (!tcp_accecn_ace_fail_recv(tp))
+	if (!tcp_accecn_ace_fail_send(tp) && !tcp_accecn_ace_fail_recv(tp))
 		/* The CCA could change the ECT codepoint on the fly, reset it*/
 		__INET_ECN_xmit(sk, tp->ecn_flags & TCP_ECN_ECT_1);
 	if (tcp_ecn_mode_accecn(tp)) {
@@ -4052,7 +4053,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack((struct sock *)sk, req, th);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


