Return-Path: <netdev+bounces-135560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B899E3F7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E19E1F23CCF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF411EF946;
	Tue, 15 Oct 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tH1FquCx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713891EF096
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988234; cv=fail; b=JVzGSH5Q3hKSu7QlUsZ+qhvzzsMO8ciZyxPnjr7wzMcdIMZdJJL76AeVkgUBlpltXc/z2Aw/7XApcstx3SHKYeTeYcVxiW8jpeBZe9+dCR7FUxo4i42kEocSyPGYsHwe3eCiBEYECCtVmWyj0Si9DXhe/75jc1eTgrY6q9Y9Jtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988234; c=relaxed/simple;
	bh=oSrZ25P4rMvYCO7G+mJ23xPkNYveZyjFXhIjL8qcYfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGsJBfwXbPkD5nucAs2lp0NuH1plYpfaCtMjYU8pr4fQ+nSyBrH55Dz2yf7Ymn15S5axFLkbzQ5p04soDia4SSKvwsZEvFKsif4JN4sxvTTJ+sB3KBlbGr7E7UQ/bspLzV7+ivWQlQPWVy9r+o9pWokXR0m+dQma2VoFhV7Z8AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tH1FquCx; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWMhTJ1dIIzK3rz9CAissBBCUF/EybhxX5UY8zQVVmelzsNBiY/BNGkcFL9FkaYR4XqS3w6LMPd89GCrUy6w+GpWlLVEs7kbhPNBJ3mvf0nTt2l3zMQAHpV4oRaBenmN45qo/cOxJVjeEiVgY86pYF2De1IuGz+t/WHf/NsGvR1pXAvZkOEHKehRp0PMu+ZbVMJnF97TKfTnWfuva90C0nFroao3gz0wfLCJT1iYxZiCRx5p6UjxCTLimY1/Kpx8CpwJ8gVcNRlr44vINJ8Zmril8Ln8uCFmvsxlpFHw9ScpeXI8kh0YljyRs1PvpTF5FTCIz84BxAYUzV2I4Kckbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lka/rWekSVA05v97HPwWmAH4utvYvC99HyKhOLrMgfk=;
 b=bLC8pp8G/j0K/vNMfbUg8Gmx7mPbfh8uo86Je3/4NUUfVv3vodc2aPFH69lXAapKyMJ2KA1Nz0dqBGXWYTgMbh+YtzouzxOYqOocR+VUTnIVd+kNaOSueenmKMQsdgCA2FzFNGRFBqfDlSjpM3j/0rRL5/lNHmgMxbMIAiTEHkXOYfSaLFuBBX+xyUZyOfZvOfbihpT7ZqfA26LPR3189pdvfAC/+pO2VWcvQ+sq6fKHg1QcmG4O42v9xFScCXlFxpLWXgMZVE0gQhkBvB7M2vwuGJ/ss4IaRdn0IBGaCpNwVs0mwotR3tWthBD6tjS5CxwT/wwbWGTBpNGZQu91kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lka/rWekSVA05v97HPwWmAH4utvYvC99HyKhOLrMgfk=;
 b=tH1FquCxiLBk+AXpDFpNgUJMbOm6ReTG8DxbWpQaZaGI9LF8VEqpljNzMnejjhl9lBRjC5NCehOJmuN9t0r3JB+pfq+7DTDZtyzqXWVQhsxcIXMdivA+XFcES0qW4RsTKmho0JAw3Icqs/0LmQZ3oZe73/mz/BsRBH1EKOhViglun8XPyeceLcoGaHNXFhkhUhAFI7vhsSdYZqeL4ewxpxTdJ9ttptNqblSPMsjSFPnhXV/4UCw9sUyW42IRZg8zlBQ0KoC7oGzXFmhynsly4I4GAVeKrj9qNJ+H8YAEA8cV1mMXNaydK+E0D1yJjrqHx3e4xkK6w5XeqLZtmOjdJQ==
Received: from DU6P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::10)
 by AS8PR07MB9473.eurprd07.prod.outlook.com (2603:10a6:20b:631::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:25 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com (2603:10a6:10:540::4)
 by DU6P191CA0016.outlook.office365.com (2603:10a6:10:540::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnO029578;
	Tue, 15 Oct 2024 10:30:23 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 20/44] tcp: accecn: AccECN needs to know delivered bytes
Date: Tue, 15 Oct 2024 12:29:16 +0200
Message-Id: <20241015102940.26157-21-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|AS8PR07MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 113c7c30-361d-40a5-b400-08dced046119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzIzZ2VNWHF1V2ZiSmoyeE9FbkJPUWlDN091dSs1NFViS3MyWTMzRnBRSEVa?=
 =?utf-8?B?NWVaU2ppTEJuTDRPeTEwS1BFMWpONFVxSXZLME5lTDR1cDYvTnVSTkxYSW95?=
 =?utf-8?B?SVk5UE9RemlkbElyeUh6MTJVVndXcXFUSUxjbmZRWnJlWjV6NUFGZmFhMUp3?=
 =?utf-8?B?eStnVXRJWlhpUmZ5d0twMlNqUVNjR0RFZklBTFZEZ2JQRzZJYkxkaWx2aHNr?=
 =?utf-8?B?Q1ZnckJEZ1k5YU1iZ0Evc3lsQkRORlI2eTMzSklyNnhkZnM2cUs4M2VZelZM?=
 =?utf-8?B?a0tjRWtpa3M5RTBtd0I0MDh5MVhrckhFVitwUTcrcEtGaVJ1ZndDSGtrdmZZ?=
 =?utf-8?B?cVd4QVUyb2hOTUwxdlhqZmdJTnZqWkxudW1nczJUUFVMTlNOdDU3Y25IS2xK?=
 =?utf-8?B?cllBaHBUdjRuUExWK2J3dlpobTBObjM4ZkJLTVJudnB4ZmM4Q2cxQnRnd1Br?=
 =?utf-8?B?VnhkZE9WQkYrU0NCMElVbmh1NjBBUGNmWURSY1JEdVVOOWw5SU5uWDVGVzUy?=
 =?utf-8?B?VUFjbWJGc01LSDFTMkFsREVtZjhKU3hZTjVPMnVkN0ljQkNsVHVVVVROSzY3?=
 =?utf-8?B?VzY4bDR4UnIzUzNDZ0NaVWtIeHFiK3ZkalRDa0E1T3owSVVodlg5L2VzWEZ2?=
 =?utf-8?B?VmRhTUliN0FNQXpXaVV1a2Z4d3FQWCtVT2dXdXlSQlNQeE53WXdRMDN5cE5k?=
 =?utf-8?B?YmprNHR2UGZMSjZqdnJxL2Z3R0xIbkxxWUpRTHFCbHBxUUZ6S09GM0ROZmRF?=
 =?utf-8?B?dXNjd0pEdE5jTjFBTisvK1o5MlpYdHY5TlhBcEpKSEZ1a0NVSnRQS09EbDh2?=
 =?utf-8?B?SVQrcTd6cE1hYjRNdGR4K0xRV0RjOTlLdmlNUjQ3THFsOFNiWEpUYW00OVJl?=
 =?utf-8?B?cTBEZ0xHWWFKY0ZMKzJ4eFVCcXhrMkluQUg5UVFZQ3VvTnlaeXRCaU9PTVdH?=
 =?utf-8?B?MkN0KytzaVp3cGFXMS85UkZ5T0dyNGVOSTV5cng1N2xvSElveUlIZExrcjJL?=
 =?utf-8?B?WjAzZk5XRnhlTm9ZdVRlaDNhQWxrR3dMMXNKTDBmbWhrMkJTRmhOZWI3eGNq?=
 =?utf-8?B?Z1JZY3JWaGViYUNBbDUwY05WWHo3WWZleS9HTTFhTnZYM3FVU3pBMzlsVGZu?=
 =?utf-8?B?dkxwb1NHUEEwL0V6bm5hb2pWRTZCOUk5MGVPRTc2TGw3RjJiUVFuVCtiUlFS?=
 =?utf-8?B?WGhaL3ZZbSttRTVzenQ0THFPYmtEUnE1K2taOXE1VzhhcEJTZzNmWTNqK282?=
 =?utf-8?B?Y0ZXMk1ONy9NVUNIemFTTTNkZkpJdlRDbzFzVTQ3eWpnNmU4WFJ0VUNEZnZR?=
 =?utf-8?B?cTNSZTg4UHZvU0tQWExuWHNYWjRseDltWTN3WWp3M2lDRzcvSWNSbk9hWlpO?=
 =?utf-8?B?Rlo1NzJNbThpWE9BVlNzUFVZK1ova2xlbmVKWDlJSTUvNWFYKzRLcGQ4ZXha?=
 =?utf-8?B?ZUxHYm5VajZSZU04MTJIMkZaMjN2MGxpK3MyRS9yZ2NPZTVneXpFcGhZa0dl?=
 =?utf-8?B?UGhRZFdyWDJqVWt2N0RmNjFsT011dXRJbEJWc0krNWdLa2xVaDdibitxSDZ6?=
 =?utf-8?B?M0FjaWcrUUxlZ3RORjZNYlVxZ1pqejJ2VGJYS3d3dTdvMnBVaWhkRFlJWUlQ?=
 =?utf-8?B?amF5MXg4ZVlIMGY1bTlCUGI0ZXByNzJVblM0bXg3dzNzSzZZTEdoZTRFcjFw?=
 =?utf-8?B?RlprR0tCREp6OFd4cUVYakhoWm1hbGRVQXBSRkEwTzhhUWQzS0JiU2Y2SkZ0?=
 =?utf-8?B?c0JCcGdueFJqTVVKcUZ0NE4yV3FWQ3ZUWjQzNitRdE9VbGNZeWZSTndzcDdu?=
 =?utf-8?B?L1NZQTlWckhXM2wweFUrL3FSWWdhT0ZuTVMzZmxYQUx4eExOblV0dGhIVUVF?=
 =?utf-8?Q?RMpE29irROCKG?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:24.2775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113c7c30-361d-40a5-b400-08dced046119
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9473

From: Ilpo Järvinen <ij@kernel.org>

AccECN byte counter estimation requires delivered bytes
which can be calculated while processing SACK blocks and
cumulative ACK. The delivered bytes will be used to estimate
the byte counters between AccECN option (on ACKs w/o the
option).

Non-SACK calculation is quite annoying, inaccurate, and
likely bogus.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c6b1324caab4..f70b65034e45 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1159,6 +1159,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32     delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1520,7 +1521,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1580,6 +1581,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 
 		/* Lost marker hint past SACKed? Tweak RFC3517 cnt */
 		if (tp->lost_skb_hint &&
@@ -1621,7 +1623,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1913,6 +1915,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3529,6 +3532,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3632,6 +3637,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			delta = prior_sacked - tp->sacked_out;
 			tp->lost_cnt_hint -= min(tp->lost_cnt_hint, delta);
 		}
+
+		sack->delivered_bytes = (skb ?
+					 TCP_SKB_CB(skb)->seq : tp->snd_una) -
+					 prior_snd_una;
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
 						    tcp_skb_timestamp_us(skb))) {
@@ -4085,6 +4094,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


