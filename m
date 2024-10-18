Return-Path: <netdev+bounces-136813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05069A329D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB9E1C23869
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3FC14BF86;
	Fri, 18 Oct 2024 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ljz8J4W3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FB14E2D6
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218076; cv=fail; b=bc2X2y9jQM56Ggd3BBqceQzMC0HXKBvfPREyQieNys/TRkL8SLS025wdPk7/PAxrKIi1784bu4UMtxuMt3JulJIYaqi6sg1OCbUSb+2pa7uqDzlP0DK4jKEgAcS+ubOG3VD0dS4X5JEWQqWNmWB+7EEBj6xzU1Qy1yxHx10E/KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218076; c=relaxed/simple;
	bh=iqP4Lrn2Z/fBm0RWoUJbIosaP4CJmoZQtGIJjWwHjO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWEnIGo2aC9+W63Z/Ott/vcAvkGxAdz0JCxpd11z8PeVgVjxRp8hJHM8ZHyCUQmtFzsqflp1MzaDIrs3ZoROP9Just/T4f7YeBhhpU7sL2OPA3Q49HW9ucXPBtqeRKZy3lVN6c5TEspmyWzX2dUFcuViITHk+SREJCXVQNyLw/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ljz8J4W3; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itFJb76lyzSQokJB5edkN4I4sakthP11QN1DYTlLwv/1gE3HLy8Gt5XC/f7su9bSpNLm+t/N9NHuanrgz3e9vFDZFx/rlPxERx3NQs5z4Y2F1rDHMCQN/zAWoKI9WQ54/w+K9e1xuRU06JmjbS/g3Wph/OqcM7SRmrC93+gJgX3Ni/CEv/mB9azFmTXdubhntTUmP7zu/l9aMlRNOi91iqfxvDMRPnsPZEngjVKPnb9eNzyPQXTujEUWHl0vBpfY71581zMlArIDCnw855YWvgUBkhXhoFUFeo1nHKC9z8tospJycIOLIypfHSGr8SjLcMFm5Zb4IjLUbYBpoLiqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=HPZgOFW+rNZkunFXIwAt0VTADQgLigb9tH+nNsF0kZLTe5yxOjM1fmXngTk6aNLHNT5OqJXyFuXk1qFKPwkBCvkM1BOFYOvvGDKepDdXoMRMQk/fAPfNGP7YcDFQYlMXSddaz7xySs+TSZcUFXve+FVOSxAaey8h4BBumP8g574NLQAGXDT/rWb/4R9dMX3O+4d+m4oC3oz+yeXjm+fJUrepA4q8/4dvH2LHpeXlkrZFRPyOimWkywZlgcfblJM1iTonVEyoVPokf5AwuRQD9c91Nbe95v6FA+l8hQx45TUT8Y1YqZbw6JABenQvCxRxAAeMbU0w2RYHNDfjWOBxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=ljz8J4W3/SNTigFIOWsAZ7OSkl9GbnoGLXuznnu0GkpYasQ8h2dSoohDs68OQnWUZwOHRE9Zs9mh9Br2lRUjVKGhSXRCmNU/N4hQaWY2fzFm4dDLKJlyRQmo9C7B/gtTDp7cL4t2ceF1Jf0X89GFXQiWACAoRXSD0DQn3VSeEx6NoU9OcuGS5dFWY8uzcVOv3ev0NpQuJMT+KCzAJALZF1lLGbFWnGrIl5lNpL/6Uk2hrG057qsp7VcGAWUf6TT+XgYw8GhYAI9DcDXu3FiGvIDh0VhOuAuQL71M0DJ9vG7tglOAFzJMp/g7o+Y7I01P/Bb8hwtzxGiwlbX1POi4yw==
Received: from AM6P193CA0095.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::36)
 by AM0PR07MB6211.eurprd07.prod.outlook.com (2603:10a6:20b:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 02:21:10 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:209:88:cafe::2e) by AM6P193CA0095.outlook.office365.com
 (2603:10a6:209:88::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0MV023685;
	Fri, 18 Oct 2024 02:21:09 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 01/14] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
Date: Fri, 18 Oct 2024 04:20:38 +0200
Message-Id: <20241018022051.39966-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|AM0PR07MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 51494289-4d27-4240-3eee-08dcef1b87f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2RMQU95WXpseGs1MzhVVndwYzdqUDdpdCs3OWtiYU1tdzdxSXllRmpRc092?=
 =?utf-8?B?QXlxYlJzZ2FNWHRoN1NwaFVESWhHNWx1Sndjbks4dHFaWWovNWs2ZXgyVTFB?=
 =?utf-8?B?ZzUwK0ZhemhpdnBtL1IzY3I2dHowZnNkTkJBeWlESVFkT3luSHM2elRqOTJL?=
 =?utf-8?B?ZFZKK0RZNCsrcGlacDNBSXhOa2ZwOTlWdUFHU0g2SU5WK3laSElnWXR1SnFa?=
 =?utf-8?B?TVNUemtzcUZRVVpLM0hWaDdpOVdod0NTVHZZaVJlMWZ4ZTV0WThvcnVVeXVj?=
 =?utf-8?B?b1cvbVZYTFQ5ZTJ4M3pFZnk1ckZQSWxOYVFqa1MrTzR1TlFhb040cEVhOGlJ?=
 =?utf-8?B?eUZpdmlWT1VtaitiQ25tRkNDb3FnaVVhdnY3aTJ5YWc2OUlvNGtaUzZPQ29I?=
 =?utf-8?B?aENFQWNrYnhHcWlDb0xFRHVpZW5Ea3JDR3BaU09CS2dhcnFnMDExNXk1blE3?=
 =?utf-8?B?dUw3b1JaNVU5M20rR0NjQU9GMUdnRS93R3NiWjN3MFhPb0hjMktWQlJTT3Ux?=
 =?utf-8?B?UHUxUGNmOEJSaGpPM09QdTZ1N1JjejBIemJNVU9hL3Y5eU1KcTFYOTN2SlZY?=
 =?utf-8?B?M1dBcFZvbTZiSzBYTGtmK2pUc2dENDFWUXpZeXBkaHkreHgxRG9yaWJNM055?=
 =?utf-8?B?YXJ3VStsclh2b0VmdFRzR1B1UUdCZGRFY3p3Q2g0V0VobVgxZHlsTTdYVlUw?=
 =?utf-8?B?ejdoSHhsRSt1emNQQWtZeHB0akI0c2pLNmtSb0dEZzJWVEMzQ2RzQzZHWUJx?=
 =?utf-8?B?K0ZTRUk4bWtiZmxrU1dkZWgxL0RUeUJ1U092VXVndnpFTE1GbUhFMlA5c3Yr?=
 =?utf-8?B?bjdteVk3SjRTNDBXckc1S1U3USs3dyt3QmF3TXZuelNFSFdrQys0MjVUY1Ja?=
 =?utf-8?B?Y3F5dnVrVzgyYld3YmJFekY2ZE9BRlVOcXUyOXdSaFdiUjVtcVpaRThoeXZp?=
 =?utf-8?B?NmhXTzIxTnJYT0ZnSVFvT21sbWpwZFI0SGYvK1gvQUZySjBONnJ0Tml5Vkhz?=
 =?utf-8?B?dXVIK2duUU5FZUx5dkFaQjR6QkJ1alhzTXJtNi9ZQk5yYVdQd2FRazhTaEFS?=
 =?utf-8?B?YkdGcWhjUkVuMDZnSjh6UndsU1hUQUhYaCtHd0gxTHlZTUJjNGJKVDNKREZm?=
 =?utf-8?B?S2YxNWo3TTJHZDhzOXpvdVRMVXJkSjJvK2xBTy9FZVJiSklzVFdnYUNwZEN6?=
 =?utf-8?B?STYrRlBnQkY5dE9Zek43UW5nVnIxRUY3RUdISFZLN0oxZFNyZ29JdTluSkh2?=
 =?utf-8?B?TEFGUFZEQmtnbkZIK3dvQllyMFZYcE54c1pnSFM2ZDR4dTAraWNIbVJQbDJh?=
 =?utf-8?B?WGdSTUJXUDY0REozMXk0dW9TdGZkSm5ORUkxSWp1TnNQNXo3T2dTWG94MEpi?=
 =?utf-8?B?V2RnaW1MWnFMNzFIRGx0Vlk4MEZXR2ovd2VhWko5bVJPOWdEQ2dPTDQxajdU?=
 =?utf-8?B?Ym5LSXE5bGtVWW9aWHUwd21UNjc0ak9pZGhXR21xOFc1RzZ3Y1p2bXJSdFFM?=
 =?utf-8?B?TWRmR0VBL3lGQUFqL0hkdEFPTE53a1dGYm5VMGVaMUpWWGhYOFUvUnNzY1Js?=
 =?utf-8?B?d25kNnA0eG1DdC9xZDZ6WHI2TWJWeU1tSkRVZTZZdW16NmhFdzlhMS9jNUFP?=
 =?utf-8?B?MUljYXVnWmhMelhoeEpKUkowOGN6Y1BBVW5sSjQzZzg3czR4Z2RQNXpIN1Fj?=
 =?utf-8?B?TFZIT3pXSGJYZG5iTGs4enprZEZlY0xoT3BpSGdtdmpwVTE2SjI4akVDNUJl?=
 =?utf-8?B?RGhWSEVCdTIweGZrRjMzQ085NTlhSzJ2WisxMGo1VEgwR3lhSDNJQy9CMkU0?=
 =?utf-8?B?UklLSXNyRkJ6VUpwdXpQUHIwc1VVMENrM1NBL1hxMzVEU281bzdmRHlPNzZo?=
 =?utf-8?B?Q3F2WHRGeWwvb3diNk5BNTRxRG5nMk50RTVzR1czbnVrZTFEdWFTamVENmhJ?=
 =?utf-8?Q?4n73St9ghaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:10.2695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51494289-4d27-4240-3eee-08dcef1b87f3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6211

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


