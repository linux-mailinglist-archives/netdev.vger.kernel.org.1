Return-Path: <netdev+bounces-298203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u+TdBGvfKmoyygMAu9opvQ
	(envelope-from <netdev+bounces-298203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F7673605
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=dZgTR468;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298203-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298203-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE0343108F35
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA02423152;
	Thu, 11 Jun 2026 16:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD504279F9;
	Thu, 11 Jun 2026 16:15:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194522; cv=fail; b=jNf1hJJ3KEWStybxMFQ4jgHpu25cC5QGPnvNCJJoMZAXgP2nCZcvftrcqfbaXeHO9NNTx6y+GXOT5xReIkDDumdGwsQKZnP82sB1PJ1JdwYXmk6Eied3O9YSw81yWQ4rUFg/jJvWUgkGz0dF2s/198+n171Jia6SSKdPfg++NQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194522; c=relaxed/simple;
	bh=1mQruVR5wadJTSu1Dds/x68HxnhO8nginA2SQCZpoOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVcZx7ba+sKmCim6JTugEQmDddItWtsR5n9/aBej2VhRw1zBs9h1Jo0oeFlgw1ZWubKWy9dqiFZtGHTDzRIu1DLYw3agDPNmTo/pmthvcahIKST+DIA96vjubs1j+5yrNwGsFdHL+A1o7Yj+l3dry39Wh6A4PTKr/eSB0k1j1sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dZgTR468; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzdl06eP8PquovkZTmBsSz9syU74UjNjmUR91LZI4rlEaHdj32RDmy4IdRXGdFqM0MSAlRB0IYirW5dw2pUhr464g280K+0K5xSlGHOmBPMvbi2r+jMNOSXheiyeBdP5VTfTAfQ+UVPM2Z96bMpF+uQOjoZ4MB82HHKzghhr/9/Lm6Trz95LWjk5yn5TjW7RvnYbgL5+PhmZZPX0jkcMW3JGvZNJN5BUn2MSqhEEF9sVpvuwhQVBQ4VRyZvMTE0H1yksl0L46Bi1Jgb70Gq7d1wYmx0irbX3Nvz64YF92ykGuyZtTGBfYToSzXiCUhyAZ7msakaPDT319cyEmUAzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DJ4i76r5ZruO5o3jRw27yS96X/qIdf4NQTbEywQcco=;
 b=qmZl4JYBRADveXn9oe94ibkB6TrSWt6efesJNah/d2gq27Wae4WtnxPrOZeXjd3UowYICfNDnpG9Dgg5LNSYNykUbEuwXpv19ne6gg28FLk58RemMlh94jAgJPPcVuJtGe68CsnetA2+DckJxHlqAOvRyJpeCIqov8RB1LihqewluZsmdD58D058PzlLdDUJmvofZCfLltO2wtTIHPV3m355NG5auUIFnJGV/dXBCUVV21dLCBQizM4EG4MNd+iD8fRbl4m9xOgmrEF6Q/c0OwQF/h83wdDheI7GbV0x037N4Yn9A/dXXUuIWI6AA66atiUg8ok5QeL+ax68dKoMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DJ4i76r5ZruO5o3jRw27yS96X/qIdf4NQTbEywQcco=;
 b=dZgTR468EEQm6zWY+1KhOTS9FG18xaTaRb1bL28ELdNSkqz6CYVyqo2fiGLa7ILwKoYMAAXoHOWiiOIo9G86wweqeAb0z18kYMKAvcfDv/lqR6lsNLNBMpo0qt4Sdbls2j04Mse8mBMcYbbNjXoVLbaf1RhW26t+uaSs35fEJ4mueuR2Tun32z4tY/07R5kzkds8dhEc97GHU3HvTKpB5Z/m14ZerjLGrPF4s1sPBcAdS+pK8QeV5E6mel4heixlrOGNw7i3hIYbVIHd1rHSe32z/RysVgaYYUWd8f1yvMsBCgPs34wXkq4wsCjhgd4zruelHS0N+0w0ejkdz2UgMQ==
Received: from AS9PR06CA0399.eurprd06.prod.outlook.com (2603:10a6:20b:461::12)
 by VI2PR07MB10887.eurprd07.prod.outlook.com (2603:10a6:800:2dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 16:15:13 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:461:cafe::63) by AS9PR06CA0399.outlook.office365.com
 (2603:10a6:20b:461::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 16:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 16:15:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id E04AD68004E;
	Thu, 11 Jun 2026 19:15:11 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 net-next 4/4] tcp: Add mss_cache_set_by_cca for CC algorithm to set MSS
Date: Thu, 11 Jun 2026 18:15:04 +0200
Message-Id: <20260611161504.228319-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|VI2PR07MB10887:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fb5df27d-ba22-4e06-6b0e-08dec7d49e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|22082099003|18002099003|921020|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	a4ZinX0UW79hZw0GQEvNlf1MFw986jNkn5Zq/CRa1aP2flg308xFwIq9xO+QlOMhEVI/pIsNdxxz1n/I1Af2fmHUk+NikeBzNag8hV2awODML3qWU7CuTxfEIIrYTVFL6D77sdAfwsdlwhvPeKySlzH4LXS2rZM7B/HUbXWCaeVQfEOUSWsvoSA/rdflVr3/ahmwPLTfpV9ZqIbYysc5y6VQI3FjukBNNepO09BrZBOOvH5j1uqoXB6l3LwoR99FBmjiydv1htfipieWRDTczMR3wB+irIQy7bJN2e+P4xHMlRanqmT1OWHrAieNqYGSqWTS4opGmm8pscTJtC1CJIlmGm3MnXvX7tyKkj1x7I/Qqyq0rs+sYN3RXS7h8R8V7+HedXUoxeJ7WKJOF+e7qWr0chdk8tu1MsIuRP5JpR+EzHo+gwQQeYnCcSG7r0PWzET6mMJF6By74heqlPyztd+pfgtkCVv8aVF/LoF44uVR5mNZwmEJ6SlR8pwZyOpJ4EnmKSLziXR/ZdosfriRFjY6oW+BgSmc8YqDGxBizdYLREAcz7nAaxP1WonQT0tBq4BfRURQG57fVH/JJ6X/Iiyydefi8T+6/KJgefuQJ9+e4M5E/JN+UJE7B92Bo+kEWROLSZ9TiTPje09nv6kEGWeXGl0lLcnDlQdFvMJL//j85bsJeS4/R5t5CAFi4hWTYf+zYX79agPFA7YH5vvwxNfR6rXW5VAr/i5jJ8h6GpSdBwQluWcJN7t57OYYptwK7/r/ESow36r501tw34kU2w==
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5bAk8cKjsOT9UmqLEc4IA/2INfNygiTOeGwcFA00ZWQ5VBMasISlTrTKB9KiBXdLaGckafShp3C34iAEY22HAlMioB5WUQ2MQ9WBeV9iBLxZdXeQFoe41zrX+5Vu8ehrkDB9PtrlEn6xDAZrTUD+se/KOVeuxdWAZ1K8drGk2NYJo9LbDgNwsw+Yg/uNs86HRqugwbvFEE2ZVCzqbYhtjngufVHXtCDsOHj4nvjRxxg6VLKb0DeohQTbOqRZcB5uxFqQb4iQTqwtYCYfUt20bbo5kAJxxOXwbrQQJkrt9lwxTOj8MJ6aCA09+r3ZBg94Ej95J5lB47JCqt9YMDRcJw+8f2l2VE+uPO8Tr0kzLluxGMUlbxUm9Qtm2opvR6I/1GZfkBr4MNT2GEbYX2hS8Fm1RU5NteZuzhESAVSAWX7Bm5X+8Y3QguzT6pxsOCWQ
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:15:13.0979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5df27d-ba22-4e06-6b0e-08dec7d49e0e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB10887
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:chia-yu.chang@nokia-bell-labs.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298203-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,gmail.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,nokia-bell-labs.com:mid,nokia-bell-labs.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 970F7673605

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Make the CC module set the mss_cache smaller than path mtu. This is useful
for a CC module that maintains an internal fractional cwnd less than 2 at
very low speed (<100kbps) and very low RTT (<1ms). In this case, the
minimum snd_cwnd for the stack remains at 2, but the CC module will limit
the pacing rate to ensure that its internal fractional cwnd takes effect.
Therefore, the CC algorithm can enable fine-grained control without
causing big rate saw-tooth and delay jitter.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   | 3 ++-
 net/ipv4/tcp.c        | 1 +
 net/ipv4/tcp_output.c | 5 +++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 8a6807082672..f12c14d80b7a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -232,7 +232,8 @@ struct tcp_sock {
 		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
 		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
-		recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
+		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
+		mss_cache_set_by_cca:1;/* mss_cache set by CCA */
 	__cacheline_group_end(tcp_sock_read_txrx);
 
 	/* RX read-mostly hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 890182a151e1..d2464a31596e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -458,6 +458,7 @@ void tcp_init_sock(struct sock *sk)
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tp->snd_cwnd_clamp = ~0;
 	tp->mss_cache = TCP_MSS_DEFAULT;
+	tp->mss_cache_set_by_cca = false;
 
 	tp->reordering = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reordering);
 	tcp_assign_congestion_control(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a7206fa61957..07ae14e68f77 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2074,7 +2074,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	int mss_now;
 
-	if (icsk->icsk_mtup.search_high > pmtu)
+	if (icsk->icsk_mtup.search_high > pmtu && !tp->mss_cache_set_by_cca)
 		icsk->icsk_mtup.search_high = pmtu;
 
 	mss_now = tcp_mtu_to_mss(sk, pmtu);
@@ -2088,6 +2088,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu)
 
 	return mss_now;
 }
+EXPORT_SYMBOL(tcp_sync_mss);
 
 /* Compute the current effective MSS, taking SACKs and IP options,
  * and even PMTU discovery events into account.
@@ -2103,7 +2104,7 @@ unsigned int tcp_current_mss(struct sock *sk)
 
 	mss_now = tp->mss_cache;
 
-	if (dst) {
+	if (dst && !tp->mss_cache_set_by_cca) {
 		u32 mtu = dst_mtu(dst);
 		if (mtu != inet_csk(sk)->icsk_pmtu_cookie)
 			mss_now = tcp_sync_mss(sk, mtu);
-- 
2.34.1


