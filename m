Return-Path: <netdev+bounces-135565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD7D99E3FD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1685282255
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751381EF0B2;
	Tue, 15 Oct 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dMpJx5Xh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0621E5027
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988236; cv=fail; b=BQa84I0ni1GNj0GhGidgT5/My/UWKTuSTrRRytBaMiGJffor/OLyg8BtPmisZCcXurKSwwc1QclSyTCA4DmQc8yplcNEPpl9fXx51MUEkqWMPDt7rg3hPcLDHL0shfDCHOUibnRCCOcdl1VXfVjJI2KL2wA277ocCSqGMMPgtKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988236; c=relaxed/simple;
	bh=Z3SiM66emkE8FaYnCaNfsDFR6MdGQAuxmAyDcwQ2iVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrRPUTukABtDYHNrEEiPLZ/QQuCIA36Dpa2UWt5wz96BWPa6J42T4KEx1QKjFIs7az/5AojXpWOoKfeYt02MGRqiaGcxhJTw1VKlD1gDb5Zkse6spy2EU16xYq0U6rOVz4oOTmO+bgm5qDNQHDpTXw6zlVcmWLx1RsrV6CEd1X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dMpJx5Xh; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJGhEaCPo0XOZzF1Yco9dIw+ZTleOKsb0+xY5MHvvdCJkmC79gkjvR/o65Jd2KYHnQSGlQpNZPtQYGSbKdJOSIZMJNqgtnyJ2wTd6FsnndOVCcW8J0PByvNZiiswVhUE/Qh0oXciIuaoXVNGoejVZu/Ri9H/Cx+mBNyF9vYOsK3jzgJmKA2h0JEdZVp5JQ9QX1DBRBBJcn+IusRQ6N2rrLwPhurBtlLdsMdSzvwSuEItZ0XT9OFu0Hb6BbIw/M30biZZxXYBxrdY+Mx/CT9bJHtjxgzxBcLcFSdAFqOc/YbS1fMjJW+chsnKJt0+DgdIwiIUuZwnB6bFNtFRJRN1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opF8mV1g7DxL2P+/mDr13QTsVSEvtXw4Bb1IHn/sjCk=;
 b=L/YZi3PdH8m7r4bNjyfVFMt3Zldy+6zvkci+UsxRTsLclA1DpRLpqrXVbrnqIOfxmx8nRlywNhMp24LXDxyfm0OiVf/OPW+XH3t4PvRKkc6YjsEFA/IN5EL3baM8dKRpkaSOaj4tVH7WkcBoL3rs12iWVx0rDYy7YIXp7iRwnchfjxLH/k3Xs0ZMGRGmEnD8l5Q3eiA/r9RF8EqYHNh6lCM1Js34zSAt1buuNhxfBvTfoDtI/q7EuukkcedMlAAM2kE6i0V5SCwCUwywXdf2HfjTOJaLG/5TXvebORi5riRLWckMa89S7ugyAgAhBmw/oqMOWGkDl7fXzmUc/Y8OGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opF8mV1g7DxL2P+/mDr13QTsVSEvtXw4Bb1IHn/sjCk=;
 b=dMpJx5XhCtcpoJ3TbO4kBXFXFtbvdGYkUmzePyYziBmx3H0/gk3lwjRfNTnhJqH6AdeM/C88txKzTRikyGIcTL2yFSOm9wBOaUmHxkDn8x0UhDdEW9wL1CEmb29ntD4c941Zvsqy0lYyhXhm3VzsTT2fT5v5euYw4yVVJ34W4U6VRgiaG3UcUFhqSdPyJ3ZGhp8/fC/K+rfmPAtM5mePg8XZQT5zloBxDvuhuHsFeg2H6H+Lr9x9QH9NZQ/8Dgo97daA+Nf0O15Rxeya64/2Bv5DdxlpcJlth8FqecAy+rQL+4+oLh/rZByC+0rlec7tnzt2p6oSNHra5E/5qcAAGQ==
Received: from DU7P250CA0017.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::20)
 by DBBPR07MB7564.eurprd07.prod.outlook.com (2603:10a6:10:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:31 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::6a) by DU7P250CA0017.outlook.office365.com
 (2603:10a6:10:54f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:31 +0000
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
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtna029578;
	Tue, 15 Oct 2024 10:30:30 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 32/44] tcp: disable RFC3168 fallback identifier for CC modules
Date: Tue, 15 Oct 2024 12:29:28 +0200
Message-Id: <20241015102940.26157-33-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|DBBPR07MB7564:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 61163cd3-2a01-468f-7c39-08dced04652e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gMPHV3IWuhdFtB7Kfk6Sd1sUmOiTBcvoPFs7Yoan9xC9qKvPSzrYjaOZNUi1?=
 =?us-ascii?Q?1MDbKUjWhvy5BA5dVE/mX4xP7iwvKoT+mJsKAdb6B9dcGSWYqPQqCvK8vlT4?=
 =?us-ascii?Q?J/yghRjqjwGGVxIZUucrA2ra2iwNAXTuOHFp8oqdZDiMA33vbW52jB2ch+Qe?=
 =?us-ascii?Q?h5mbU0GZgHN7QLNoNma1kHkS6z1Z9cF2RbDilLu+zwNES0ibMCb99KSI7r8/?=
 =?us-ascii?Q?cy5fiMMhdVfLwPGLyJMtazjQ2TTp8ln74mLuXgrpCC5PUhDj1w3kb7Jg9IIi?=
 =?us-ascii?Q?P72roj3d62bYWc5oDp1C9px6dvImN8j30UQo3gg81HOWzU99EpLxa/ma7DmQ?=
 =?us-ascii?Q?wkpJgvaK78BwBLlDuZ7yyW4x4Cxc0C26UJ8FNRW/O7MSf0vEo18yk6PVnLRH?=
 =?us-ascii?Q?h3BLbdzlQ21jW9NFEX/f8fClTczP2D9Aycg75na+qtBtAadxVXrm+13ofKok?=
 =?us-ascii?Q?fhIKWcZMqIx+i37IyvDCFTH+TXGuU9sFltlu1zl3LxOpH+mZSaLhZB9a2I8a?=
 =?us-ascii?Q?MYhUsSAM+7qPJHheJaU4r/EwrmJ29p/jqzqwrNzOll1sW5CA4DbruW0WAGbv?=
 =?us-ascii?Q?f25M2AFE35e2Fwf8ubQVehQb5ngPe7aQSrJv5KCpBKUEEt4rkPLeZbbRR+qH?=
 =?us-ascii?Q?mDHI+SK+1MsWLVmoTjUnPkrtZ5HdwAVrQKhMisqVoC8VbOc4zKcqC18kNS6u?=
 =?us-ascii?Q?MX+ioKwRAwknhMJYeGkmBb2R/gLNsrDhn7ZFoEiCiqdSA0wC0WU2zsruTJY/?=
 =?us-ascii?Q?+Cg/WCEJOhLgQssZ7iRO2nxufFTJqk9EueI8rdT6m95l4vh8A+9km8LSkeci?=
 =?us-ascii?Q?yQrtNf3eEcn8Kmh/W7YMXFdl7of1HXPxn5sILDKRd7ml2Li5T4lCLfemasG9?=
 =?us-ascii?Q?qo4gLPyYOpDbOm7LkE/vwWLfGQhMAFwaedAZTqwKwUNSlKJN8Q57FbsPPJtc?=
 =?us-ascii?Q?JWbEqT8zq1bd7M1bR1ABucU7E1p/Q9/BFtNeD85j/CItAbKo65dyjKLlRu8o?=
 =?us-ascii?Q?Vf/9hIdbdXHefRb6gAnqHWehQJkhguy7xCkIh/sY2526t6ud+PsbYAOIk7r/?=
 =?us-ascii?Q?SyEsAabWGsrcH5tKzytW7j5UHyzJDqJht4WNuvZyBmprOcFpi5br5IYewp46?=
 =?us-ascii?Q?v7LA0NTTDi234m/emoH/q3/E/RSaap0zdxB0yqQXxADUSDEkXmX1AfJu5ikL?=
 =?us-ascii?Q?GuSGNkcau9zhqYnM3PeO/AFcsVECKFCltpPmWlNCOzAVnDTkut5IH6DqXoWD?=
 =?us-ascii?Q?qVYyzm5c0nPtrYnI6vYz7EuJT8OY+VJCgfXGyg9rVB6DUTX0poMDAAHN/3+w?=
 =?us-ascii?Q?Qhf8zLJsLrx+Cl1ztczzT6gdvK757WEZe44brpluIRTkaHlfWY7XxgPqlqZe?=
 =?us-ascii?Q?ljZOtjvHBHXgmDHRd3hgUN/P1PuA?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:31.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61163cd3-2a01-468f-7c39-08dced04652e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7564

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        | 11 ++++++++++-
 net/ipv4/tcp_input.c     | 11 +++++++----
 net/ipv4/tcp_minisocks.c |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cecbec887508..4d055a54c645 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1254,10 +1254,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ECN		BIT(1)
 /* Require successfully negotiated AccECN capability */
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(3)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_WANTS_ECT_1 (TCP_CONG_NEEDS_ECN | TCP_CONG_NEEDS_ACCECN)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1397,6 +1399,13 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
 {
 	return inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bd7430a1e595..fb3c3a3e7c56 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -452,7 +452,9 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 		break;
 	case 0x1:
 	case 0x5:
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -476,9 +478,10 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 	}
 }
 
-static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 			    const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -489,7 +492,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
@@ -7111,7 +7114,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index cce1816e4244..4037a94fbe59 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -495,7 +495,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk) ?
 				     TCP_ECN_MODE_RFC3168 :
 				     TCP_ECN_DISABLED);
 	}
-- 
2.34.1


