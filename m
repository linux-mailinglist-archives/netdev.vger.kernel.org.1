Return-Path: <netdev+bounces-135540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC599E3E2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9651C2119A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BAF1E6311;
	Tue, 15 Oct 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XRUSuX67"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D2146D6B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988221; cv=fail; b=H9CJIkCyuz3lBAlH0Lop142XGad4zhmtuJaAaLO7GAjYlkWx/eNZ7a4CfuKSOCdDDxL/xZoS6xczmlFlCir3F1AVKI2bDiCB+45djxHuxXLzi7zw3R9VO4u8B174RpSvWo+jCzoLNffp8eDQymMGraScoZtWByO+xk1H4ObUAcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988221; c=relaxed/simple;
	bh=iqP4Lrn2Z/fBm0RWoUJbIosaP4CJmoZQtGIJjWwHjO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jli2HkAjRI57ZNoPynMvjicRKWnl4tYJ2/8DQ267cS8eVf5pvfm30r+5yGOEwgw+VP/4NwYGDg138Al/i6JWWZf0tuKCGIo7vAl532BcxAIkDZs67bwF+NQcazk1XfAJWNrUIyB14cNhz7OL6zqA/LkLL8t1lPOD1jyBOhXfmAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XRUSuX67; arc=fail smtp.client-ip=40.107.249.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5Ip3xC6oQiQQeF8XG/uVvjKuxPXWzDNm9r/qoHAcS9LKmAN4a/yWnZN6kOKwvPIQwrv1RO094rwK5jnBXftw01Sq3S9xezkbIUA9OJM8dM3cDQiDZ8dVEoAN8SJUnpV0M4BlNZZTsuowzv5iTJ1o2ikwUreUryoxfHlhDiLLhf1AGjUBfdRqX+qgv2mElBgLpq7boWIjRvAQ3oCcT9/thf/LNSeal7ubQkWZOUCs56Ygyof8TQpHiRrrB+zaa0HJzsaZaJVW7y51fbVxn9r6+X509+1VTnrdjTBc6ngtNMEqVjYncsn0t5WSoxORdmfh7eYw6iRATM/sctZuGN9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=PT8uEzcoa35eLsY9dtn+qcnZQ3ZgHRHH2/qjd1pxPlkxRpA1nFVWQn7zbmfBM/XkgQavZZILzGn/todQPZKz80uqCR7CZGcxTzfBQgjdBaKsWTMJbil0j1bTFV9ggry0YDjL+RNRUA+t9+y8z2XP8SrhaxzO9GsRQIdF27T3lieF4fHfj3zq2MHqvrj3mpbckxt3qqboSwOPEFzXLZ6DmYOdCmx0SilF3KSr2UGQ6VwdrGfY3Q5AmF0Ehbs8ulRYkwxDWryNhf8g7V0Qyj4AzV6ZBQ7n+eD/lh1biAxZ8kmOMYH5UmokbitnmQ7tYQfBI/hrqZk4FDmliZ2nAiC1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=XRUSuX67ks6hKyq9Psw40XV4Wbhh8HiwVZOW8t8KS9nTIat7lowe6S4CjtJXbT3mA6oDb28uaw/jeP/Fx+VZMu+OjdV1iKixbivMEz6WjCHS2tf33o3rQu6zeE8iix9TfS91SxXKCkCLAMmo9FrahNsWtOxHBJF9XTf7vMO6BWNMMc18mc+8eLkWEcT0AVhByNvEyz7m1kbcb37mqTlUeMADIuv+LnYWcN6SAaRPfahs/rVKYMUiGhTIsSf71rLJDPcI22fZJp+btbSyHs02DURO6+bSU2sfxPWDIgKQfvAGTzZpJGmxTXd1xG/OYuR5Fb8YBkXzoEg2luxIpTYO7Q==
Received: from DUZPR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::19) by VI1PR07MB9406.eurprd07.prod.outlook.com
 (2603:10a6:800:1c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:14 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::fd) by DUZPR01CA0011.outlook.office365.com
 (2603:10a6:10:3c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtn6029578;
	Tue, 15 Oct 2024 10:30:12 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 02/44] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
Date: Tue, 15 Oct 2024 12:28:58 +0200
Message-Id: <20241015102940.26157-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|VI1PR07MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd9a17-2837-4a87-b825-08dced045b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGRYbUtRMVFtYStuQ0wrcTMvdS8xbnJmYXhoWUZFTlVvTWpyd0h2WDM4STNJ?=
 =?utf-8?B?RUdYYXllaTRMYVdiWmFEWjlrMzQrWjVwVzlxYUlkcXE3QTZNcjhvZWR0WXBE?=
 =?utf-8?B?RjNUT2FmemgrUUJZZGRCYzlVVEZadXdBRVlselVNcDY0cXNlRUJlWnpIclRr?=
 =?utf-8?B?THdlajNMK1RrMW5GRUxpSE1Od3pkS0Q3ZHRydXRPMENpS3lLcEFJcnlpc2J0?=
 =?utf-8?B?VkdIRVhRR2hiV2JBYnZaOGJkbGRIeUF3dDQ4aUR6dHQydkY5anlmSk5aWG00?=
 =?utf-8?B?T1FqMUwra1Z3TFlmdFRXZCtzZ2RYOTFRd1FVOEtOT1Q0cDJvb3VWSnBOc3Qy?=
 =?utf-8?B?Rmc0ajVRWWVOVm15b0NlMDN5UkdrQitGbldSNXRpMEwxQ1p1NHJjM0NjdlAr?=
 =?utf-8?B?dytxa1ZaMW5IbmhqU2pMUVRYNy85cktra2RpcERhWmpmc3NIQnMxTWM3c3hK?=
 =?utf-8?B?R2w2TnVqTnZSN004YXM2TTBXZjFER29TNTYvWFpuR09ybnV6UURHdC9pWDBt?=
 =?utf-8?B?c3hUdStzbDhwV1dQOU8zd0FNaElTaDdMYzQ4b2QxT0dzYVB6cFpBR3hlaGRZ?=
 =?utf-8?B?UXgwVXJYZ0UyZDU5RTVVZ1FFL2lmdFBNTHo2blc5YU1nUDBmZlRLaXhaL2Q4?=
 =?utf-8?B?dTcyWDQzNG5OMnZ2OTZOV25qUGZsRnV3eHZZc0EvdDdQRXEvK3kxVVlRd3ZJ?=
 =?utf-8?B?TTB4MnYxaFZPTDY4WFg1dm9Ja29oSmpqQkZNUkZDM1c2SnFOSitwSWV2OGQy?=
 =?utf-8?B?ZUtMWEZvNkl3bk81a2ZCcm5VUEkvOUc1NE1wL3A0bjh2MExDY2FhcG00eDFl?=
 =?utf-8?B?NTdrYlNiR3Y5T0RpUlU4bEFhclRqTzFIeVN5d0N4d0FNQnNqbUZwSlVUYTlV?=
 =?utf-8?B?RE12T2ZkR0toZjV2dFVIM1hSVi9KR04yRVFibWNXR014QmZwOFV3THpJTUF2?=
 =?utf-8?B?MUUrUEhqQ2lDbGRIWWlJS2dmaXByb050c1ltOGVIalI3M0tNNTMxaU84L0No?=
 =?utf-8?B?UTlCallWZWRGSHdNR25hclBTK3pWYUhZYlhYc3IyVFdGYWlldnVRU0IzUEtj?=
 =?utf-8?B?OWM0WGdlWUsxdHFyd3ZFOVBiR0NHNC9ITFovZXRGVXdPcHprSkVYcXhEelg1?=
 =?utf-8?B?ZHQ0eGJFbk9tcXlpSkl6WElRNi9lVHpDdlJQWUVxYTdQU3crU2xYRnNWdFhH?=
 =?utf-8?B?c3hnV29uSWZzOVpCd0FtbTg3aTZ0cFIvMlIveWpYMTdBMlkxaERPWXRoNzZo?=
 =?utf-8?B?YUpkQ01SZTFYSHRuSWR5TWN6Y3NsR1FRYmJLUTNZOFc4ejdxY2doSUpQSG16?=
 =?utf-8?B?dHlHR2pVbWc0WXdDS3VOUUJ0NEM5OEZKRExsUTZhVzBvbEgxeVNkMytqb2gx?=
 =?utf-8?B?QVJHUlRQSHFRdDVpOUtMQmlYWWVPYlUxMmd6bDZwNnYrNzlCNklaU1duNE9n?=
 =?utf-8?B?bGhjV1ZKMjd4MFJ5SVRRc0dXTzIxa005U0kwUS9iVHJmcUs5TEZhNnZUYXVX?=
 =?utf-8?B?RExCOFd3eWo3NWFQZGh4ek9oMVpxSzVNaUtEVWl5bjBBNFJtd1QzSmptdS9q?=
 =?utf-8?B?b3VBRVlGU2VONFpFTEZwQTYrV0NUS2UvSjFBM3pONkk0RU9vNmVkZkhvTE13?=
 =?utf-8?B?R0hPTEpYUlZpK3lMVURHUWY5YW4zUHhXUEF1OTFUU3ZROUJNb1ZFc2VVRzBs?=
 =?utf-8?B?YVdrRjV4eEJqV2d2eEd4aEE3RUxhT2l3SkRwRHlQQW5aQ1NSMXpZTVdiZk1V?=
 =?utf-8?B?M2tzNVRjaGxGZGM0cFBuWFlod3B3S084UFN6SjNHOTlZOXBhcksvTnUyUnMy?=
 =?utf-8?B?TE42TEhQWDJTRlRtTFhDYVBGQ0d2VXFxajJOS2FsLy8zVmIzVWp3dEVac3pV?=
 =?utf-8?Q?+Tme8XKvhtFMW?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:14.0696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd9a17-2837-4a87-b825-08dced045b01
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9406

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


