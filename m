Return-Path: <netdev+bounces-135567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C41A99E3FF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2E428244D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC821F7091;
	Tue, 15 Oct 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XU1PcGP8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958151F7077
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988238; cv=fail; b=KzTWO0Oyt+hYeVpfG9rTUTvYN0Q+n13pglmAc11vrBl5JKU+u24/EQral+zy9r37MExLX+IdeZgmS+vUzivWHXUxk8zqV0SCfurPq0oDEUmVdgSxVtnn6KviGXkwQzSHdP40GMJF7rg1d5i7fOy9HzsYsI0M1pyoIA2gzjjDcR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988238; c=relaxed/simple;
	bh=PqvjgjMwi3rbXacaP9BTrylFqEXOptDY7ko1sSD4Yok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTOEC64hzxbCKPQwPoHKJ5mUASdFG/yYIzT4WVmUlknuH3tDcmSnt/t73IvlG5NGzVhxcxZSJG8vww7ZS+N21wDUdpXK1Wk1HWhOL5DAfTpb3utl3ecV3TtgniH6we1JH9oqc5lDIGj4+rghGB75kYQ6z+GXRJuXe0tVf7vt7Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XU1PcGP8; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thtutetDSTVcRysv1CDL1n0aBX1QUR7EqHCsH/fZeXhLY2sP1Lxp273/RqOfaCrbPuzohfkHQDBVnPX5pTJspW18Z/AzBQXgiwXtWy6NzlmSTWUy50ZvXZdjjjiZLhv7awmrEHaw4NmGhaBRruO8xPQMg5465otFI0SNE+jYff+APkptGfefi+Lvr8H+65B3/OTAbrsAL3voG9oHt83YycqVnMo5bCjb/uDvsuSXhQgDbGB9YCzF672X3LlpQjXti2DhyDDMF1+NOOoaWRiMN7hmq3llcNkQSQOhFAHGxfuKO/hyd3ZaLjQQwgBp56mJVOhDhK0Jsmvh3iNezNUtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je7YDCIDXh+7FWSdBz6KLrHVgPpuU54a9eqWTbRAePE=;
 b=LRRn5osytBUmBFjcw2UQ8BYLK2K8ubfeXmYS6C/hhboX7+JDERk78GlZ6SkImb54sN1jkvHKZNXDFkAuVyOLOLNTbSr7ELdGZM/RWR9p+tJKEAoySgScqtTHKgbQZJpw2LzpGZbL8yFHzmSauYXbpglJiinc3L+JoAtKwNvziNpsGesL7iVvzllXb1fdfXS7FVsQZUjT/+Lj+2b3tc00bS40CuCMUXujj+DAcGg8ypAhQPd04j+gjjIx7JlMI09be55w1f6spkpIk+Shz7EnRUOLZ1mDB/tf75Xhkm7xFLsVEr5Va5gNIWFBTFwXNNE/A8sSejEzvsZjpCT/czZucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je7YDCIDXh+7FWSdBz6KLrHVgPpuU54a9eqWTbRAePE=;
 b=XU1PcGP8YaYTv2Yq0ePqDpgrKs0zyICm4PUVFtKdmdLq7wn0lfoWkM5cEw8VrtDWh4OGSH+R4SOW6AhxMgHMJIPLa9kFnjel6RFL33Ze8trj79TSgVThMIq/kE66KcMKtK3BpSntP0Yoip7z1OEloXgfakFCAfgtywYrvNPsq4LeBfZ5fZ/IdFkXCdE3kkK5uEbjC5EVnv8m48cwRwk3g38z/Lyj6nbBwIi9pmVbhPQNzIkMJMUmSqq+sePbaRXHcT4EenNg6eXWduBt92hOA0kmyq3qW/SeBdxcVNl/Adew4kPmdBSzVd04H18kBXOq0hFx39G2Eqb9p2ARq4UpjA==
Received: from AS4P195CA0040.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::28)
 by DBAPR07MB6535.eurprd07.prod.outlook.com (2603:10a6:10:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:31 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::9a) by AS4P195CA0040.outlook.office365.com
 (2603:10a6:20b:65a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnb029578;
	Tue, 15 Oct 2024 10:30:30 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 33/44] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Tue, 15 Oct 2024 12:29:29 +0200
Message-Id: <20241015102940.26157-34-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|DBAPR07MB6535:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc5f917a-43c8-4a02-d1cf-08dced046565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/03uvcGNjDbUQ7J7LV6jY/ACGl/U7icqNu9QuFPcOu7RtHo6ucTv8jbzQaDB?=
 =?us-ascii?Q?gQE/qMV6AzK/cHmZs9copCBTng2bWFbOuHHMkzqwmoSuLPl9nKv9MUBwi12/?=
 =?us-ascii?Q?jn+BN80w3g3BuFbsNvgT4E6rhNQFus+VnSEbOMgm6lHZiXgwYWlVBuq+YHaT?=
 =?us-ascii?Q?y3jUpFo4rzk869zuWVjH4ys5y2PfOTaP281MbYzS2StminJXPZJtrQK/kESc?=
 =?us-ascii?Q?6/TJEeOIqPGleOQEa4zWdf5ZfRI1vfdUY2S/rmcbGabHU1+pon1XwrYE/FjV?=
 =?us-ascii?Q?CbGGp8QNTFGnlXF2JjdiZRlY5ZvjG2donz7EzoxuOed2vF8vFdpGwweBbAWL?=
 =?us-ascii?Q?B08/4B+RkKuqvqhBm2HXCSoFuDn/QjmU/96tvttDlhV/cP+ShWM2B7DNpemQ?=
 =?us-ascii?Q?74/hzz+P1AXECxtg9MCXx81QSwPTqbv+F/kacf2LRKKWtaZrPE63sFvbilBa?=
 =?us-ascii?Q?CqQoDFdgqlQ63GWh/7o97MIosHntfwwwh9hjc1AP0Tkr8JlWN8jsUMt3s/LO?=
 =?us-ascii?Q?QhmKu5SwSi10grfg2jzZgzGNc3swLu4TN/udf+3KAYY7slf+8ggazG5s4nmZ?=
 =?us-ascii?Q?Eau0JPecYaFfJoNDfNQt+jumdU62aZ6dq8h8n6Tjc6HLFb43qZ2vxMbXiLh2?=
 =?us-ascii?Q?Thsut69uU9ZD/JiuiNJlU+pdXuDGA/zMs0v4rCTi/lg75UMNPZhFZEDM0nrj?=
 =?us-ascii?Q?uGMXkoaw0iXCHZ0JVGmtS4vOqSiPenT+T82coRi/8WtfZCOyrT+rHGescyYs?=
 =?us-ascii?Q?sscrz9A1lwBXgLnFxYSaFobJL5IVdmzbscfJJIrm0EDdK1PRQtYKJ+v6x5Zy?=
 =?us-ascii?Q?cEBacoCCAwSojkTJAthSSCW7qGAgmsIAOTcWxHROozyIwoXID6/INkOgjGoC?=
 =?us-ascii?Q?69MC3L1ziKdd5a3xo8FSVCKwLv+NTOJemFbMfPzuxpK7ByhvbQvwH0DyTIWD?=
 =?us-ascii?Q?r3WK7YlYxQeK96jUKSi7irgK4OeR4f2QrOuuLr7rit/An24EXXb0NLCWGBNV?=
 =?us-ascii?Q?xjUcw9RGdiRi7yiVyEbtuWdKefkpX2U2yQYuymhR81gntk+sI9gM+5osnbym?=
 =?us-ascii?Q?4Qti3Q7RK8kyleoCr2zehrwqL8xvI0c32z4++FA24uc4yIqud6DVCWOFF8AR?=
 =?us-ascii?Q?2hIB/oi0A76VQ9T/eZhKlZmp2kH81Doe2pSuaNH3VuqZJTLjT0Wc6CaMdGKP?=
 =?us-ascii?Q?htu5GvAmna3BV1QoVPUoJi6mI3AhYbLnKK+p4PXbCx+1SJllLMfbfCocDEN4?=
 =?us-ascii?Q?0lOhDOIUOJhW/RiXvZyr7049I85N83aiDn8iuRO9oiWbF1a35peA6A6j+zNC?=
 =?us-ascii?Q?lOfiDjXJjvwvQoZWu8yexX7i6tyaaWjhp1zgZcxARoAzStHQ4ICVTiRhKk7M?=
 =?us-ascii?Q?iXHp72VHuDfuyzg6yTMuFBa8SNLK0rEFrwoq5sGM4r0DUzIAhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:31.5341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5f917a-43c8-4a02-d1cf-08dced046565
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6535

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

3.1.2. Backward Compatibility - If a TCP Client has sent a SYN
requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1) then receives
a SYN/ACK with the currently reserved combination (AE,CWR,ECE) =
(1,0,1) but it does not have logic specific to such a combination,
the Client MUST enable AccECN mode as if the SYN/ACK confirmed that
the Server supported AccECN and as if it fed back that the IP-ECN
field on the SYN had arrived unchanged.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fb3c3a3e7c56..062bb77d886f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -438,6 +438,21 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 	return true;
 }
 
+static void tcp_ecn_rcv_synack_accecn(struct tcp_sock *tp, const struct sk_buff *skb,
+				      u8 ip_dsfield)
+{
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 			       const struct tcphdr *th, u8 ip_dsfield)
@@ -451,24 +466,22 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			tp->saw_accecn_opt = tcp_accecn_option_init(skb,
-								    tp->rx_opt.accecn);
-			if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
-				tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(tp, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(tp, skb, ip_dsfield);
 		if (tcp_accecn_validate_syn_feedback(sk, ace, tp->syn_ect_snt) &&
 		    INET_ECN_is_ce(ip_dsfield)) {
 			tp->received_ce++;
-- 
2.34.1


