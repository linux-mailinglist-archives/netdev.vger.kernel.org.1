Return-Path: <netdev+bounces-135569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9A99E400
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A65928200C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE11EF928;
	Tue, 15 Oct 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JMYjGj5z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB31F707E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988238; cv=fail; b=u6IUIfN9uiaTLpKStdSL460c2tvcQSngg4vpqG75NB+Ni1lfuTuoKtDqYSyO9bNdj7DT3ai3U1lCrP5BhH3Zq8bghU16xukzhoSqxODJjK4x6KSR5VkoQf20pEF8Hd1gXmCX/vxz/RR/APVqZKJVU/+fxYGqkNJPZ9K8WgkMSto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988238; c=relaxed/simple;
	bh=RWWYSGqdX05mZ0PPV9KYsJLiRdXUd6QGg20gKYgn6ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHaOAPkiVq+V6IntWKlYkvtq94NLLUEiAh5cAfXc4gJal+Nmljtk4pshAnwiEWiaYOOwkTEBf4poXU3nct8/jX7HXjQ/ULqL9BGDuE0vMEcfmirUJVHsHtaO/pPVgbaTlfxpA+7RBIRgqKD1uf32RuVSuLi1L/DgZWYVU3MoZSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JMYjGj5z; arc=fail smtp.client-ip=40.107.103.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq/HDuulrDp4hefLZcCiyV/gwiX6aUW6AUlKgKBu3l5POPwEwQZhYfXzVjH414cgMzX2OoZ3qYykUGjKgFI1CU/I12OqkuLR+YlRp/Sx9lboLMO2KBmzBSa6doGjuG7CYd8EullUP5z8avb1D8NJdut6NSF9xNKRVSQ+AqOWodW91mAQIXMXoCCiPUnD56a573wTErCXaoXeARSB9qmLe9zUZ785PCdIq7sGmwDFxljOW3yJOQ7on71HlNZGLX8Xp/JZKErhl9YaIV56uI+UGdLjTTC/adV468YPO7drdCZmoxeEno0VjIlhCX/Ybz8wwHla9uUC5jekIHKlRvE7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31F4KNXY7Ey8MlgKGCRSZiPZxbFCAMjgL5OaQdxUjcM=;
 b=y7OrTfrfDNxkJvwQIhbmVlZK2Wyt/XGkgWJ7msuvSm4xNOjwytMrJCTfw2w8WZrkPY70IshIewWr8ucKqGYD0WflX+lre52S2+QnrG1W+4RkPJm59+TnaS089WuB0u1cCf2STQpCxHcTQAoQ/PXBmSmvmy0jmvdyeyd+lNc59QjFtv7bNIjpIT4nJTHlukm8iqu70ZHHmxOZE/HZ4sZSIXm7xZAuc64CgETbbouX+PYOD+yAb5/Yg52EnK9M4LhOZ0afHYtKG0IKAP5L1TsZko2bQgWMdeCrKA+m1cbG5L2rZWpL0RqhjcfyPkD1wYGJ488g61mdvvifm15fLRHEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31F4KNXY7Ey8MlgKGCRSZiPZxbFCAMjgL5OaQdxUjcM=;
 b=JMYjGj5zdwRSRhSQik5gLDAxvrBcY0hlbU3M9Taid8F7EuxYwbGqz1QkzMwbzVT4ONUhiUzb8zMcDkxcM/64jLUwhapvTreD5+3xEVqpEhq/1X6fSx0HvX29WsZm16KAYKRdX/t83C9lqHI4lWVIL4+da/ltgsJBHhck1EnkUuEzPvMfgmc80jxm7cWRVCHlPHVZcw8uU5vrlxRRJlhz4KCCVlrafPp4yPtRgOVSLX6OYW1bRKGElfgqOfIJqdnn9KZuYseKsG0JjM5++FTU9baPIUJwOqmbTzVcEsB7gbCZKyUNHZ52Bzk0yntrpc26fpWojfEG5wIU8/YoBb7S/Q==
Received: from DU2PR04CA0200.eurprd04.prod.outlook.com (2603:10a6:10:28d::25)
 by AS8PR07MB9548.eurprd07.prod.outlook.com (2603:10a6:20b:628::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:32 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::fe) by DU2PR04CA0200.outlook.office365.com
 (2603:10a6:10:28d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnY029578;
	Tue, 15 Oct 2024 10:30:29 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 30/44] tcp: accecn: Add ece_delta to rate_sample
Date: Tue, 15 Oct 2024 12:29:26 +0200
Message-Id: <20241015102940.26157-31-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AS8PR07MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1b99f0-75ac-4318-db66-08dced0465ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW9rQ3IvRGxINGZIY0ZXWEtSSmlZRHlFZmFjZWlVaE82Nk1uaW9PMnN6dytV?=
 =?utf-8?B?TDZHUjdnOUIwdUx6eXVYYXI2SU5rbGlGeGJKa2dMU2RhaXdEWEFkaFI3Tmwz?=
 =?utf-8?B?NHJqZVRsSEY3YmhnQ1AvbmE1bHNJZHEyVm9mYXZEMVhKemZ4ajZJNHVmN0xC?=
 =?utf-8?B?YXBsQ0NvM0RUNmcvL24vRWozN1kyRE85MWZnM1dWODg0QWZ3YXc2ek9EUks5?=
 =?utf-8?B?YjdFNjZtdGJKY2RRd2NBQjljV1BrMDZiWWFxeHo4dVZGYkRjM2VIWlJVaStp?=
 =?utf-8?B?VXd0YzRPamhTTWZNcm5IcHhjUFM1cWtzZS9iSzdTLzhaWHYwK0JYU0daVVM3?=
 =?utf-8?B?Y2NKd2N6cms2NkNsd3k3L3laa0dnbzVoYmxpMG5zMzJPeHczb2RrdUI4dWpk?=
 =?utf-8?B?ek4rY0ZjZjBYYlVScEMwbHNUdzkxZjVmUkNQZXNuelp4SGJLUFNwRFBreGhX?=
 =?utf-8?B?WlJ1d1lrMDloR0JKL2trbnR3NngxVGVyNGJhRGJZdVJnNkJEYmxoNGlqUW95?=
 =?utf-8?B?VDBpOHBFNWxHdFd1UDRpaWkxSXZ5MmFRY1JRZzdGNUtXOGI3YkhIUnRtUisr?=
 =?utf-8?B?ek5jUDhmYk1YclhjdjI5Y0xjUVZ6SmxialVxMmprSzJNbVF4VEtqTHl2Unht?=
 =?utf-8?B?OHlzbjVSZlU4aGhiV1piaWxvNkFwT3BZRXQ1Q21xZ2tzMWNLY3hiNHB5dEZ6?=
 =?utf-8?B?dWxPWFc0N0ZjaTBXRzdkRnl6RjlGWHgxbFBSSEdDRkM5akdvd0tMK0ZNeFNV?=
 =?utf-8?B?aEgrWlRuREZ2ZTRZS3VsZ2Zncjd3S0ZJU01rTXA5OEw2UDRaR2I0Y05kWjdC?=
 =?utf-8?B?R0ZkeVRORDBZdHhWRDRpelF4aVpMR1pJcXRaSEVnZjlKYmtxUDRJcUJ5NkNm?=
 =?utf-8?B?SEU3WWhSN2JrbElDa0MzektwQUVkN1QvVE1vbDF6Z3VVd2h2ZWxndWJ2WXRJ?=
 =?utf-8?B?RjZMQ1NSeitLK0EvTWRJZ3BBNGNtY3JwRE9UaG14RHFYUmR1b1FUWXFJK2pj?=
 =?utf-8?B?RDBidHFoU0V4bEJUaWkyZVlEOFpLV0YvYXkzZmMvS0I4cjNUQU9GUVh4RGVO?=
 =?utf-8?B?Q1hPOTJLeEhkNWdvTENJUjVSaXp4WVBydWF6ZkJEN2pvWUdiQXh0THFsdGhC?=
 =?utf-8?B?ZCs0dW9vNzVUdzNETmRtUXJ2Z05rV01uanp3VTV1RHhVcmg2L3pmTC96bzZJ?=
 =?utf-8?B?Yjl2VTNhQy9oWC9Gd3hQSGlXdHpObmhsRVVuRkh3VTY3T0I3Qll6YWNiVG1X?=
 =?utf-8?B?VVB5d2tLMWNOR0l2bkZTeVlOK1VCNlFWckRBTEJxUmhqcllWRGo4TUc1VnUx?=
 =?utf-8?B?bDB6SmhoYWpOSGkvUXhkUHIwTnJyQzhnMk5ud2djSmpXSHZtUkZidU5ySjI4?=
 =?utf-8?B?SkNRWENwb2dISGdUVCtGQUJ5aUJGb3MydDJYVE1Db3RBWXlpZXFoUHNSbmZI?=
 =?utf-8?B?aWxUR1hJU3hYQlV2RUpYSGdXOEU4YnBQNjhuVmx2UFZhVFVxT3F0NlFCcFgx?=
 =?utf-8?B?ZUkrdWZJdVprUENKV2ZCMmNqUkowNStMUEIxVk5jcThFN1N5T3Z1eWdUSnFn?=
 =?utf-8?B?TWllVWZqUTFpMEQyOWl2OXVRSHEzVldUTzU2d2NYYmw4R1lvZUg1a0hNVHhU?=
 =?utf-8?B?QTAxU3JrdHNSa3dpZzhWS2crL3cyN3p6M0NKR0ZsWGp6Ujl3d3p3OHZieHVr?=
 =?utf-8?B?MWpUSllkYW9FMlU4V2kvSTVqMSs4MEUxSTRraW54K2FWL041dWI0Sk1pZXhr?=
 =?utf-8?B?NWxkRlprdVZ5bHdzYmxRaTRTcjRHQi9iZHZVYUNVaGNucVlMUy9Nb3BDTldp?=
 =?utf-8?B?ek44OGZXd3hnb2thSkx0SW9jM2VWRkpNcXUxUVJlUHF2b1hjaUhQS1AwV0FK?=
 =?utf-8?Q?RVGfAMOIbBvHa?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:32.3944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1b99f0-75ac-4318-db66-08dced0465ed
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9548

From: Ilpo Järvinen <ij@kernel.org>

Include echoed CE count into rate_sample. Replace local ecn_count
variable with it.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a2f6b8781f11..822ae5ceb235 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1285,6 +1285,7 @@ struct rate_sample {
 	int  losses;		/* number of packets marked lost upon ACK */
 	u32  acked_sacked;	/* number of packets newly (S)ACKed upon ACK */
 	u32  prior_in_flight;	/* in flight before this ACK */
+	u32  ece_delta;		/* is this ACK echoing some received CE? */
 	u32  last_end_seq;	/* end_seq of most recently ACKed packet */
 	bool is_app_limited;	/* is sample from packet with bubble in pipe? */
 	bool is_retrans;	/* is sample from retransmission? */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b1b6c55ff6e2..bd7430a1e595 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -745,8 +745,9 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	return safe_delta;
 }
 
-static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, u32 delivered_bytes, int *flag)
+static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
+			       const struct sk_buff *skb,
+			       u32 delivered_pkts, u32 delivered_bytes, int *flag)
 {
 	u32 delta;
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -756,11 +757,11 @@ static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
+		rs->ece_delta = delta;
 		/* Recalculate header predictor */
 		if (tp->pred_flags)
 			tcp_fast_path_on(tp);
 	}
-	return delta;
 }
 
 /* Buffer size and advertised window tuning.
@@ -4260,8 +4261,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
-			       u32 ecn_count, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, struct rate_sample *rs,
+			       u32 prior_delivered, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -4272,8 +4273,8 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
 
 	if (flag & FLAG_ECE) {
 		if (tcp_ecn_mode_rfc3168(tp))
-			ecn_count = delivered;
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+			rs->ece_delta = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, rs->ece_delta);
 	}
 
 	return delivered;
@@ -4285,7 +4286,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
-	struct rate_sample rs = { .prior_delivered = 0 };
+	struct rate_sample rs = { .prior_delivered = 0, .ece_delta = 0 };
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
 	u32 ack_seq = TCP_SKB_CB(skb)->seq;
@@ -4295,7 +4296,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
-	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4405,8 +4405,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	tcp_rack_update_reo_wnd(sk, &rs);
 
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered,
-					       sack_state.delivered_bytes, &flag);
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4432,7 +4432,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+	delivered = tcp_newly_delivered(sk, &rs, delivered, flag);
 
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
@@ -4443,14 +4443,14 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered,
-					       sack_state.delivered_bytes, &flag);
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4471,7 +4471,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
-- 
2.34.1


