Return-Path: <netdev+bounces-303140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 44dNE9WwQ2rXfAoAu9opvQ
	(envelope-from <netdev+bounces-303140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:04:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACB6E3F5D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:04:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b="BIyvX/1j";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303140-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303140-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BFA23072414
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888DA407CC6;
	Tue, 30 Jun 2026 12:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D59405C55;
	Tue, 30 Jun 2026 12:01:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820917; cv=fail; b=bOTySD0xsKPYJx5j32k1cq/psDhJsPWsww37ZmwJYe7nSUlIHSFr6YMZ/leJCd9y08GP4eDsg7q5pdzZgZNn9fA20wUQr7g/A2I/QEAmtYtbAE9NfQXmZM5HNDMLAaq2gP2aVx6fKg8RDBfznKhjZpgkD1V6Dw1pCqy0c+Ruq5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820917; c=relaxed/simple;
	bh=eHd/N0lqgmUv6F9/kVeZH80/vj/Ug2LnFq8X0K7jWVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ftbkGo5zWgDZrT7Jr5Dzy2bF6g1NXiPnfNDVh0sBuZraFUmSkMocHZ96g6F/xRocko3KAnG1H+jQqo6URG8OGt9n3iXcxK/vjWdJjSgPerSbT1J6hEt3jJullNdUTrgwQLK+negjeXd6isJu8IPfSu0ruokUONWRLVqk9s9LvSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BIyvX/1j; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhWKyjLCTAMZ2miBMvPXPPvuLYbpB8grLpNLipQE6VVDX+NDN0DJm98dEdYKIJ26HFGQIbyPtIbP3U02aQvjsPS97tAcnOK1s1UrF0AVhbPA72I5SP69gem1VoApTBULxJ6cnCHGDaI9zwFlaiJMYz7irRcceLkt8d7vklDNSpgsGTOaeEcPDIM1bdMcV0/tec69b1BybRPadAZ+It2deXirtp3UC11ZOPn5guLt8/REJJuI5SryX11k13+2HzAYqsKO2gsvgpT1JCWOp1EPepoiTkzpKSQZfNRTyR7TCun0OiHZDTzMFxRGUu0UY0IUQjMthQTKbkBSztpW83OzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp8tcFgXhMqpLIMrY4X12rw+rY5znkjBoeRjhhnLSlY=;
 b=iL9U9zXmeF6pxH4ZxS7jUED7io+qzIQc17lwlteb97HHIO+C0YcFAUiWxSqZ+sC8cOxFzryHQ6E4F2+qlj1Fsj0GQqSztY+0chyvL91IWandKT7Pn1gzlQ31xMK7/LIZyCSsVFLIjWYgj/ElLoSgGtaV+8AcZDT+XHhZTyYyLrS4C+F4TMtgo0lHY+TOr/BcsHRm9+7zLteDQ36hrro70xM6AlNp25tmVTBW5WyxWc36qmmY7uLzxwMBsPz5MDZU/z/NIg33PlPo47RM+E0i62uKWeYTFps+DCV0Myvf8vO2e2izf5WKD/1MF+vq2d1HCw8P/tOhc0nVval8EDX7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp8tcFgXhMqpLIMrY4X12rw+rY5znkjBoeRjhhnLSlY=;
 b=BIyvX/1j2+V83Mc2fNWdUlWb5WX3X2gpQmZjyY10OjqUc+CAwlgsXjTWQZm99L0pOyKKUHlPtDW0YEHn+LewcOX5KeUCpSPYVk27RQvwZ5QEY32z4Ujgl308cvl1e64EulEvQs+7WjSg3Vxi4ILzS43+yGh9H/6rTc810RLi+ncR3LdrDGlPwD5NFvRlpXtTFut54bKFbHUQ14u5Jj/AnVhs72FuGeHlKafwP0BBU0tw6gZU/CUMn98sGdfZi6WWOHlVBf0YcxPErwraFzxQ/o6M1HRtjZ/u+aMLYrms/zZ78vHtJUix/8NHVcRn/h8yjjCzW/BXPYgZYIzCK90WUg==
Received: from DU2PR04CA0066.eurprd04.prod.outlook.com (2603:10a6:10:232::11)
 by AMDPR07MB11456.eurprd07.prod.outlook.com (2603:10a6:20b:73d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 12:01:49 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::8f) by DU2PR04CA0066.outlook.office365.com
 (2603:10a6:10:232::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 12:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Tue, 30 Jun 2026 12:01:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 7D9782054D;
	Tue, 30 Jun 2026 15:01:47 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	linux-kselftest@vger.kernel.org,
	memxor@gmail.com,
	shuah@kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	horms@kernel.org,
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
Subject: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with tso_segs() CC callback
Date: Tue, 30 Jun 2026 14:01:45 +0200
Message-Id: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|AMDPR07MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: 6037cdd1-2b66-48a6-1ddf-08ded69f5d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|7416014|376014|56012099006|18002099003|6133799003|3023799007|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	7cCuRiXrS7b8cZoBy7MLOhe1s9NvOYsEfjUIdc6mbzpThmvX5olZbJJhJ1if5t7xqAseCp3BtD26Oz4Bt8Bk/5KcFtBS4puLRjl+FMquQKkIHXV0rHLNgaEv4W+3/2EFKd6k/w3dA29OajOIRx+MXPQKb98BE5haZP38Fj8eAKpTaqeIHDU0BsHia6J6JuZTBVt6QiaiP6l9rXbnqpFjPflGmd19VGtfAbqncIq9+R2VUdqoXhCV1q92dVQR6/6UmsM5ZEHN6a68fcCZt98qfEOxxNYS1ID9xCv85qJ6m7dA2/2bnPQLBpIEuvDgp625zl4WLhrBkoqhRSleMT1VIcLD5ZgUEI4mEkmX4RqLET2EykPxLRdqkWCm4HV6JgXfJQC2JeWurCC9AG60qF9ub5jx4r51U835BcI/Umn5MIIota7qzVK5aZ3wKx/J6Yk+i9IfjjJlQdXljhxWM3mphmXRa2GL7Vo6R0JyGcgcicCN9mCmi99/3TG2pcHRqIjGUyQrEgL906EFFeEe9EnoEW4kRQPxqECIpTShFvytK6P+tpXbTd6ocz+RJCSFVnD2JD3Ikho9zEMviOuyJt/rvTsjgS6Cp18XmFjM4jYfJkBmRREDUiqci1BqhLqNre17GGpfDeBjUQQ8aGjjiW6RyS1ikdLVo25rSQBEKTnmnJL8PWfmZUxX/vW3Sq+pYBjcwScSObmNIlk2CO0IalyqWJFJbQannwhAXP3kJxFd0O/Y2ps1DP0lMsS53tL33r2P
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(7416014)(376014)(56012099006)(18002099003)(6133799003)(3023799007)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZCKDiIJlMTI0NzS2uTjyBXeZv+L1CUxY093zfP1YSRzGykjNraoNXId5fPsd04zoxghDz1YTS45VxgdkWv7tih8nBBoxmzQphcoPr72BM0DWVcUS9W7GNbH0RodVnJyF09Hk1UQuO0cTwxnsjcblq/sMyZlLhvAtG8MiGpzNDucEbxGyFEpLSCT58TnhS8kjdSPgAM2l0yGhh74JVuHBNmN9yWVJA/DU6xtWDlyjvOSyzRfj0mlvKpY4qN7NFenOqTGplwU1FCtfd5VDnzT/9QsCLhwZu8VqWmRnw1ZmpGpB/xfuTLg3UwLEZ4U4BEpcDzq9Ks1pscbreHVPLz5syw8l6s7sb3f+LGR8d1QSjfzH3eoFxkLbiIy5SyqDNAN6bH/5PUh4owUiFB6wWU+811yAe5ddBbibhQCyXfRYJp67QUSkhv6zn5v3o/vjttRo
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:01:49.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6037cdd1-2b66-48a6-1ddf-08ded69f5d9c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11456
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,vger.kernel.org,gmail.com,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-303140-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:chia-yu.chang@nokia-bell-labs.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,nokia-bell-labs.com:mid,nokia-bell-labs.com:from_mime];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAACB6E3F5D

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch replaces existing min_tso_segs() with tso_segs() CC callbak
for CC algorithm to provides explicit tso segment number of each data
burst and overrides tcp_tso_autosize().

This change provides below impacts on BPF struct_ops users:
- The callback is renamed from min_tso_segs to tso_segs
- The signature gains an extra u32 mss_now argument
- The return value semantics is changed from "floor value passed into
  tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing

As a result, BPF programs shall be updated, beccause retuning a small
constans will now directly limit tso_segs instead of the minimum.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h                                | 13 +++++++++++--
 net/ipv4/bpf_tcp_ca.c                            |  8 +++++---
 net/ipv4/tcp_bbr.c                               | 13 ++++++++++---
 net/ipv4/tcp_output.c                            | 13 +++++++------
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d1c0..7fb42a0ce7da 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -824,6 +824,9 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu);
 unsigned int tcp_current_mss(struct sock *sk);
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when);
 
+u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+		     int min_tso_segs);
+
 /* Bound MSS / TSO packet size with the half of the window */
 static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 {
@@ -1361,8 +1364,14 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs (optional) */
-	u32 (*min_tso_segs)(struct sock *sk);
+	/*
+	 * Override tcp_tso_autosize (optional)
+	 *
+	 * If provided, this callback returns the final TSO segment number
+	 * and will bypass tcp_tso_autosize() entirely. The implementation
+	 * must derive an appropriate value and ensure the result is valid.
+	 */
+	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
 
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..27c4cdfd80a8 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -284,9 +284,11 @@ static void bpf_tcp_ca_pkts_acked(struct sock *sk, const struct ack_sample *samp
 {
 }
 
-static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
+static u32 bpf_tcp_ca_tso_segs(struct sock *sk, u32 mss_now)
 {
-	return 0;
+	if (unlikely(!mss_now))
+		return U32_MAX;
+	return tcp_tso_autosize(sk, mss_now, 0);
 }
 
 static void bpf_tcp_ca_cong_control(struct sock *sk, u32 ack, int flag,
@@ -320,7 +322,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.cwnd_event_tx_start = bpf_tcp_ca_cwnd_event_tx_start,
 	.in_ack_event = bpf_tcp_ca_in_ack_event,
 	.pkts_acked = bpf_tcp_ca_pkts_acked,
-	.min_tso_segs = bpf_tcp_ca_min_tso_segs,
+	.tso_segs = bpf_tcp_ca_tso_segs,
 	.cong_control = bpf_tcp_ca_cong_control,
 	.undo_cwnd = bpf_tcp_ca_undo_cwnd,
 	.sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 82378a2bfd1e..b63e77b14c65 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -297,11 +297,18 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 }
 
 /* override sysctl_tcp_min_tso_segs */
-__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
+static u32 bbr_min_tso_segs(struct sock *sk)
 {
 	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
 }
 
+__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
+{
+	if (unlikely(!mss_now))
+		return U32_MAX;
+	return tcp_tso_autosize(sk, mss_now, bbr_min_tso_segs(sk));
+}
+
 static u32 bbr_tso_segs_goal(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1151,7 +1158,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 	.undo_cwnd	= bbr_undo_cwnd,
 	.cwnd_event_tx_start	= bbr_cwnd_event_tx_start,
 	.ssthresh	= bbr_ssthresh,
-	.min_tso_segs	= bbr_min_tso_segs,
+	.tso_segs	= bbr_tso_segs,
 	.get_info	= bbr_get_info,
 	.set_state	= bbr_set_state,
 };
@@ -1163,7 +1170,7 @@ BTF_ID_FLAGS(func, bbr_sndbuf_expand)
 BTF_ID_FLAGS(func, bbr_undo_cwnd)
 BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, bbr_ssthresh)
-BTF_ID_FLAGS(func, bbr_min_tso_segs)
+BTF_ID_FLAGS(func, bbr_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
 BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 00ec4b5900f2..f3fc4b64e61d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2253,8 +2253,8 @@ static bool tcp_nagle_check(bool partial, const struct tcp_sock *tp,
  * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowance
  * is below 1500 bytes after 6 * ~500 usec = 3ms.
  */
-static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
-			    int min_tso_segs)
+u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+		     int min_tso_segs)
 {
 	unsigned long bytes;
 	u32 r;
@@ -2269,6 +2269,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
 
 	return max_t(u32, bytes / mss_now, min_tso_segs);
 }
+EXPORT_SYMBOL(tcp_tso_autosize);
 
 /* Return the number of segments we want in the skb we are transmitting.
  * See if congestion control module wants to decide; otherwise, autosize.
@@ -2278,11 +2279,11 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
 	u32 min_tso, tso_segs;
 
-	min_tso = ca_ops->min_tso_segs ?
-			ca_ops->min_tso_segs(sk) :
-			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+	min_tso = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+	tso_segs = ca_ops->tso_segs ?
+			ca_ops->tso_segs(sk, mss_now) :
+			tcp_tso_autosize(sk, mss_now, min_tso);
 	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
index 0a3e9d35bf6f..58262e490336 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -10,7 +10,7 @@ extern u32 bbr_sndbuf_expand(struct sock *sk) __ksym;
 extern u32 bbr_undo_cwnd(struct sock *sk) __ksym;
 extern void bbr_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern u32 bbr_ssthresh(struct sock *sk) __ksym;
-extern u32 bbr_min_tso_segs(struct sock *sk) __ksym;
+extern u32 bbr_tso_segs(struct sock *sk, u32 mss_now) __ksym;
 extern void bbr_set_state(struct sock *sk, u8 new_state) __ksym;
 
 extern void dctcp_init(struct sock *sk) __ksym;
@@ -90,9 +90,9 @@ u32 BPF_PROG(ssthresh, struct sock *sk)
 }
 
 SEC("struct_ops")
-u32 BPF_PROG(min_tso_segs, struct sock *sk)
+u32 BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
 {
-	return bbr_min_tso_segs(sk);
+	return bbr_tso_segs(sk, mss_now);
 }
 
 SEC("struct_ops")
@@ -120,7 +120,7 @@ struct tcp_congestion_ops tcp_ca_kfunc = {
 	.cwnd_event	= (void *)cwnd_event,
 	.cwnd_event_tx_start = (void *)cwnd_event_tx_start,
 	.ssthresh	= (void *)ssthresh,
-	.min_tso_segs	= (void *)min_tso_segs,
+	.tso_segs	= (void *)tso_segs,
 	.set_state	= (void *)set_state,
 	.pkts_acked     = (void *)pkts_acked,
 	.name		= "tcp_ca_kfunc",
-- 
2.34.1


