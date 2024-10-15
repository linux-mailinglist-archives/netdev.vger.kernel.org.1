Return-Path: <netdev+bounces-135574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F379299E406
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749161F23899
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CD71F8EEF;
	Tue, 15 Oct 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qHGHbKbl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3E1F890E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988241; cv=fail; b=TQ+Rld4bhXEffbsx8gByedSgvCja//atOBeAsM1jBdHAkOJEU0Z/H24mPTGtuiXklZCPZGsrf65Zpy/oeM2NgTWX5tay48VK/cZk4gmNOkdJlg1eQCPgYJtCVCDPCxhmsr1LTxS9rbV8P203A1S9WQ64WE9C3bYDmwyAm1+cF4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988241; c=relaxed/simple;
	bh=n0ht4NonO0gPeu25Nz9iKgSiyMTjU9RGDiU/LtcuWGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDJHlz7g0xM9Wnnf4MFmdUXgiFXH8a6w+bSMnNBnNZsAmXVnhi34j9U1YbpbyjbkoUJHU7oY25xNJuV4JEXIlOktVWAKzF1XI7m/vsBIgpQ9BWk0uoZEMwZ0jUW1Q9+i3pBFMzxdQ+OT+e0CBNiz+J5vgtJemQsUoTY40Gpno74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qHGHbKbl; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmqK5YPlGt++aENgoXDlUoPYln3BOd8AyswMQKwk1t2lA3ACL9GxsQvi+T7L2U45uBS7/ub3sVcLi2jI0iai0TDvZyBRWC0x0YXhzalKX8zs+1Blf8Qu548LJcLz+ZJsELjKMeIHCqszP//VZARx+m4+S20CmS4FT0VmxxQYJO7fYwokun5a+O+w6s3dEpssLgFxsM34vecruY2CnJyf6etMPtIb04VFK3grwG1xxv6tb/xwLlFHeAybsvMya3wyQrF5SDoZxXAuwc1QQU1QXEZwl0xQaxfOXJ37erA6ckF/pCMtTXEMPZbCnr72R/kKsiVOwZzvFwPBdKqmD43OLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqrfXx3oGh/3+d/rGqS0pjom0F/F2FRvhC7XT6xhw1E=;
 b=LA2yp/D0ics74RXChmIGqsRoHWZ5wi8zM6eIcVSI2Q94IajkjqrOyp/KfXPpRsrSMRahiF1ps3ADbwnC9FJwHtJxaHVuURdYBpX3uIXlLcL5SCUwbzaS19B0kG4LBaBLsMqlJj6PoRWCGkAIS4Aet21bHIugavcVGpA82DgNmMxr0E54y3pMv/GwEAi/8q55alRRml5gZTFVkQVGs/PwebfbzeTnpnF4GZD/Ze8nXgFliBZZbD0HA15gmYbvo5mAwy5Tvfnjt9QXkBL7qCtCiEqU111sxtGTDrLLovWHgwxhf08BaOQjEZFq0e2vlKjZKV0CAnhYP0UocYCFbPiisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqrfXx3oGh/3+d/rGqS0pjom0F/F2FRvhC7XT6xhw1E=;
 b=qHGHbKbleLMK+vtFVTA6jYmUjXRdxGqAr5Gb2xNjQbAwav0z2qU6RDW0vijvyscYb0bt/u2LBRLaA4Uwe9gL2aQOD+oh13f+rIJBIUB2hdcs9k6IFWh32U2BGpDESHO+IhTCw4cdTN4ghr4HEkJYOcPvVO1ZuofchCyYLhcs04fFQedYgj3SL41nkxkx/P0Hm+AxfB366qj/y9gM6oXiy1tp2xxBT1Tvfqynu3Q7aV1reQuN3fK3pdEEjUCL88I9U3cocU5/e3y1DNKg27lgvI2LSw7V4nFvQJj+La+AQkqfEelYxKFd1/xelL+L6wifKxcKdpkx/wK8A2pxxLI6Dw==
Received: from AS9PR05CA0288.eurprd05.prod.outlook.com (2603:10a6:20b:492::12)
 by PR3PR07MB8051.eurprd07.prod.outlook.com (2603:10a6:102:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:35 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:492:cafe::d0) by AS9PR05CA0288.outlook.office365.com
 (2603:10a6:20b:492::12) with Microsoft SMTP Server (version=TLS1_2,
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
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnh029578;
	Tue, 15 Oct 2024 10:30:34 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 39/44] tcp: accecn: verify ACE counter in 1st ACK after AccECN negotiation
Date: Tue, 15 Oct 2024 12:29:35 +0200
Message-Id: <20241015102940.26157-40-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|PR3PR07MB8051:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 644b3fd8-4995-49b7-4362-08dced04677a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sHJK7+afs+aq26m2Ff1F/NG4Na6L2YTb+0fRiERLRnkxRiyeKj8DBZH0ToJB?=
 =?us-ascii?Q?bQwJAQUr5AW5Ga/I1rxTp5JV1opfShtPmDha+Nxm/eQFWA8VNVfCEcb6E71v?=
 =?us-ascii?Q?PTnwCsmoF/RaB2sjBAjT/jbG1igZTS2Pp5HbZeRcPDKkBFzES0BnXi5Sm0Lj?=
 =?us-ascii?Q?wGpDI39CIS6KcdysavzLfTY2LUGGbDqs3k6EJor4XDihzSU6Aga//EcldQCT?=
 =?us-ascii?Q?BURVlygTbs7qf/peusp51YppLAXhtmVVZRFEffYtxWLSmj9ju5rKk0S9N0Xy?=
 =?us-ascii?Q?PsN83lw+zrfAX1gQwC1iSfd3LvDSd7LW/stg5FOfbGU/skpkcOtnYfxCT8z4?=
 =?us-ascii?Q?jPpYmwtL5E7+y3tngrsF8/JJEBVJrc8KhQ2j0welXorHBTgNqsPgQScuBDCk?=
 =?us-ascii?Q?zAw6iDF6c+RRG3xlzswuvmPqjAm7i7/5TghsWWWtoukVsV5RE47ZtmXiTtaY?=
 =?us-ascii?Q?ybnnHBlqeBSEcXftr4AoHfh7Xu0yxe+nljgTbnXf7+Qhs4h9Zne5Pro69Ls2?=
 =?us-ascii?Q?L+mzUE2hx4HrzU9pf4hDcVTOvpae1HnFoEsM0mtVqoLYWayAUo+toZJK053l?=
 =?us-ascii?Q?2Cgt361vNp2BL+iUGEy2LdYF5C7X1TK9cKOSdptv6ivqjXW5jdkmvUWEQUXX?=
 =?us-ascii?Q?OuIX3M8xC9i+tq1ypGL2Qp0rlmxmriERQde/bRDHPzP+jSPrP+UvFpkhc9MS?=
 =?us-ascii?Q?ywCy+cD8RIhHud2fEu/LRkbTHXvayKEYWLVoGzym9SITbkaVmw964ZGfzr7a?=
 =?us-ascii?Q?wG92peKGo5ZwwlucnPM3DuPJGJWX5ccJfiK4Ec6XsaYeRQ3AijJURs4Kjyz4?=
 =?us-ascii?Q?KuCIIQXPUG44yg3kZ1J1wc+PkMEKltwdNyRrcrDC3lk5O9jn6jtDbFhy+vbu?=
 =?us-ascii?Q?9KHm8eyO8FJBHEhmTqbMmSiEY8JOOiDUwi3OlX+f32U7/f+sNEyLws9vcxwL?=
 =?us-ascii?Q?IIKSvx45wlVQIEeZS8c8oiujPVkl81yeipQzfRZWxiU/nYgdOyZQBPJknOQO?=
 =?us-ascii?Q?c0npZrNKEUcfD7pC08hVnK7w09teVtmlJUEGfE/N5ZXLWyML085tZ0AEkHkN?=
 =?us-ascii?Q?GJReHgp5z9vABld/5MWuZgeuPqHYX0tCYz3kLtMjXH80/bQdY5oxBwvAymXT?=
 =?us-ascii?Q?NfiNB52zZL0jvHOSR8EYck6Ix5JTC1vy+zOk91MZ84FRUSy1yqgZeUq/wRTb?=
 =?us-ascii?Q?CAm65fMnAfj7rZyGOFW1u68musjspe0OyUJLyLrMDBfRTiLFFMa9aXzwPsR9?=
 =?us-ascii?Q?AsmyQA+ONcPrareNrRxedyNNRdpzwl7Tk2qd78jsgzZt4JzpeSq9uN11Bh+y?=
 =?us-ascii?Q?ARJubcBCqjxxy8uu45BS4wx+3zJA99KU2ArenYgzCD3oJZJMRmtKqEH306/2?=
 =?us-ascii?Q?8o7llHxsCMDyGQmge23gUu9/L6Qpm/ZmW0Uv3Al5oYg4j+4zmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:35.0235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 644b3fd8-4995-49b7-4362-08dced04677a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8051

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

After successfully negotiating AccECN mode in the handshake, check
the ACE field of the first dta ACK. If zero, non-ECT packets are
sent and any response to CE marking feedback is disabled.

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

3.2.2.4. Testing for Zeroing of the ACE Field - If AccECN has been
successfully negotiated, the Data Sender MAY check the value of the
ACE counter in the first feedback packet (with or without data) that
arrives after the 3-way handshake.  If the value of this ACE field is
found to be zero (0b000), for the remainder of the half-connection
the Data Sender ought to send non-ECN-capable packets and it is
advised not to respond to any feedback of CE markings.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e88f449e89e1..0786e7127064 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -687,7 +687,8 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-				u32 delivered_pkts, u32 delivered_bytes, int flag)
+				u32 delivered_pkts, u32 delivered_bytes,
+				u64 prior_bytes_acked, int flag)
 {
 	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -724,6 +725,16 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (flag & FLAG_SYN_ACKED)
 		return 0;
 
+	/* Verify ACE!=0 in the 1st data ACK after AccECN negotiation */
+	if ((flag & FLAG_DATA_ACKED) && prior_bytes_acked <= tp->mss_cache) {
+		if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+			INET_ECN_dontxmit(sk);
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
+			return 0;
+		}
+	}
+
 	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
 		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 
@@ -763,13 +774,14 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 
 static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
 			       const struct sk_buff *skb,
-			       u32 delivered_pkts, u32 delivered_bytes, int *flag)
+			       u32 delivered_pkts, u32 delivered_bytes,
+			       u64 prior_bytes_acked, int *flag)
 {
 	u32 delta;
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
-				     delivered_bytes, *flag);
+				     delivered_bytes, prior_bytes_acked, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -4303,6 +4315,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
 	struct rate_sample rs = { .prior_delivered = 0, .ece_delta = 0 };
+	u64 prior_bytes_acked = tp->bytes_acked;
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
 	u32 ack_seq = TCP_SKB_CB(skb)->seq;
@@ -4422,7 +4435,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	if (tcp_ecn_mode_accecn(tp))
 		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
-				   sack_state.delivered_bytes, &flag);
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4460,7 +4474,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
 		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
-				   sack_state.delivered_bytes, &flag);
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
-- 
2.34.1


