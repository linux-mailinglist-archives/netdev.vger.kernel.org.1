Return-Path: <netdev+bounces-299157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eQ4BNeRVLmpZtgQAu9opvQ
	(envelope-from <netdev+bounces-299157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:19:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 774BA6808B1
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=qpKNyWP7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299157-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299157-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23001301571F
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F8390987;
	Sun, 14 Jun 2026 07:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67729346AE3;
	Sun, 14 Jun 2026 07:18:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421537; cv=fail; b=QtKSLwXXRwJi3rHTRyoeruwchwTyB3+++YJ5sks2RWtfpeliXTiN5vlB6ui5ekXhVz5i4uD6HKaCc5oPkkd9D4Yhk+0onXewuy5akqwf8BtC9mSDe0/VRl6dukooh6Ft8ZbvA+isiXVprO09uO3nmK/4c4rFzY9j97lcCgpfoTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421537; c=relaxed/simple;
	bh=ReafgJqtXESWWRKSNcXYSwz0VWWb6vRIwHsi06XhaRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nlhSsOQQJzaaxTH8ErrzcNo8FtSHIGhTEmgBltQfs9bJWgr+/ERXAI8Nhfq+Qljl3g8QvMtYtZfNw6cWddSbl65gnDxZ4COiwCLbEzjkLgq6uIHsLzOMmJx9KN1L/w2YgllKPmwO04cmXZb1cFeOvQldsMXUtxlgw0iU3X+kuNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qpKNyWP7; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGHa1DmiCfS/NdYH0/4ZfCYnFWJ60Qaf6KcJgyr0tJhNzsE7ZA7zsTo/76evKUtQu/EZlzKOQRTraoy9ETbl7CBjRdRT7zA7QcOrSwPVzBunuWAAyGzz+yRkso6mxDJmgUAhynkBRAO0Q3E/zwdQYCyWSv0g5Amhz+0aNkAJ3FxXdeCDxn2oxPXGDKjeUnz1Kd7Dz0BuZJtkig+TqPnKDogmdQ+Ub8zuMxmcQB28PE/1ImxKGbH+akJl75Vpzce8z511zI87hwcjowhGU/yMREDw1OflN9BODnfvT4/lYUwE/ovUeTnsyf4UuBa4rtwXflWjTetQYYftpr9tI0H8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60S6ewrTPpyUw6VWmEqyuhAQ3Ub1Mtnrh9Vq/CNDkcA=;
 b=r/AK3QcFeq34UYK12jAo22YtXY5MmnX7/G6BnlhHdqPj+TmyCjZpsD8SyB51n75T68okoaur/sp9UXS7BEKomz2WOfcFPpqBPvsOFWUVvkmy6yDuee9SMU093zOQroJvhxt2cl0cYNvyU+NgwQfuKJTeVFEakRQV7dFrexM8FCVfBd5gzAjPO7fZ5WFnvOtndpoaY/DVBtHrn/QL/qOINVxPTmFkEMShEpryrjzqADQElNXK+buvX4oD1dtQnEiMcesBLOFAbfNFDtnEYXhYVUi2QGT76xceO5onmyGmNnW2TkxQ1u+9cNiJAeNC2YbsnWzSS1Xwm+vfHbe+LmWTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60S6ewrTPpyUw6VWmEqyuhAQ3Ub1Mtnrh9Vq/CNDkcA=;
 b=qpKNyWP7WrYaYRO0qi73jlGmLAPrp7znstpZMc6vdBlnSRQGmj1XFiSIs4NpOBcLv4bIwXmfOlXB/63K3tw6We9EiOfK5VtpX68cNIQJjhOlb8DYwNFfku1O9iDmZgPXFYuSWZDu5sZKf6ojDzxCW1fztO/ASAEOVxGeeIWKGcu9dRneScToIoQG153fY5fZqZC1vHJ+/mv/XQe+A2IFAV91Ufu533AeFezjCcTtBHrTifrteTGL+Jbxb79hbSlZe/EiM0xl2c5PEpvqkZZnWaZV62wED8VcI/3SF3LnmzAHK/WGoIhvJllogylqaW2t1+epfZfNvNOIa77IHwXrtw==
Received: from DU7PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::13) by AS8PR07MB9210.eurprd07.prod.outlook.com
 (2603:10a6:20b:5ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 07:18:51 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::30) by DU7PR01CA0028.outlook.office365.com
 (2603:10a6:10:50e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.17 via Frontend Transport; Sun,
 14 Jun 2026 07:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Sun, 14 Jun 2026 07:18:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 91E2568004E;
	Sun, 14 Jun 2026 10:18:49 +0300 (EEST)
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
Subject: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with tso_segs() CC callback for TCP Prague
Date: Sun, 14 Jun 2026 09:17:56 +0200
Message-Id: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|AS8PR07MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 332dc418-3284-4265-5cde-08dec9e52f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|23010399003|82310400026|56012099006|11063799006|18002099003|3023799007|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	oPZIMO/qa9mi6fzt6vDaj8dsYgkBIrbBrVsTO/ll0MwwJZZ7NPsa7XaNEmihi8OzLtduyjoJmToj3D/Hywq5e1gFKZ6PsKghlCHVbrDHy+sB819M2uHC9P0CHMW0m2O7UjqkcZR4uigfSZRcD+Q9gAxXIcjPP+evw8xRfuvie7AIqAn6CUs5Vk5iw0PMSZ+2uqiaJj5z1icc3j4q51krTtn0lAHo/hnTqrIGNnPwAEINrIrfwIzSbZGZ6vpU7NoH0cNhNPPVhHSCSxBvnBcPoxvArcGCoMh1F90MmENiUjTDQh97xmn6OAM5FBJy1q1Cbg2X2nOL39vSAMRBWFes17A84tS8NFxYzUukGgn+FuRQoDm8rXrsqjkt0XP6+mHxRhHKNcR9CQkp21DrGZZX8JkivLer3PIguz851JlfQLpm13RcTSiziH2GmPpCdiZ3RkwUetPCnm6WzqDWe4A+HHaavFOSvbNK8vJe75LZBVNIgQPs5x5GH1wUKzfIbnxwSZE5rTy50d2gLwwqKLgDgpk5Txj4mwNClOjaHQNbv7SETqGiTyNhGWhBHCtnsbRXV2+AhvDihERlsV7gfBPkK8K0EI46/zuvSZIhZIenvtTfz5XDyEgZM6miyloLBbH5rzDKHmpr5ed/4oSmS4rASUzr17DM63WTt3U/n1A+WtYSUuP5ighvjIKztXg91RX2MwkND+2AdHyppsPrI2u4FOmdRCTl3KUx9z1fPvUQjuN9l3GneHGIf2fJzanUyVpi/rJYW7eipUiO4wmdLsxCEA==
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(18002099003)(3023799007)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5cQhBjwYHlcAbJZF6CI9MxgIy8dPqhxLYtvVnUwHjzR9ETCbwExA+oWfugIifQvAUo3JRxztueQmpmgYn4VmfLbQgHiPcWeNrl3dirIadTaWea61qQgjeAaMROZZR5tU1Lpu/97ETu2vWVeE65n7Nn1pGdP270hDzNLUqryUl4d5/fDQaPyIfputC+58FBuoSXKR+rwflRpQDH7U/yRd7aw3gkXkOlEF9i3980I/YDympVIAVZjwFi9L4iHPiDyFW0OGm3AFnZasm70QMpOl8W9ysRt6Hj1UZ/7QmrPOWStG1kINCSaCRpcEZyxJ8m3ALXivJzSrwX9LFk3qcI3b9jHediWjRx6FrapOSAhQ5GbfJxATcdLq9+pzooKmAITQq9Rf+e5WYm+WTh14JfzB2Wp1F1mzPkiO1fggdbB2bjw4n7fFZ2wR8LsH8Np1n6+S
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:18:51.2463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 332dc418-3284-4265-5cde-08dec9e52f68
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,vger.kernel.org,gmail.com,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-299157-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:chia-yu.chang@nokia-bell-labs.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,nokia-bell-labs.com:mid,nokia-bell-labs.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 774BA6808B1

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch replaces existing min_tso_segs() with tso_segs() CC callbak
for CC algorithm to provides explicit tso segment number of each data
burst and overrides tcp_tso_autosize().

No functional change.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h                                |  7 +++++--
 net/ipv4/bpf_tcp_ca.c                            |  4 ++--
 net/ipv4/tcp_bbr.c                               | 14 +++++++++++---
 net/ipv4/tcp_output.c                            | 13 +++++++------
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f063eccbbba3..34d370ea9ceb 100644
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
@@ -1361,8 +1364,8 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs (optional) */
-	u32 (*min_tso_segs)(struct sock *sk);
+	/* override tcp_tso_autosize (optional)*/
+	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
 
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..ed4fea98dfde 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -284,7 +284,7 @@ static void bpf_tcp_ca_pkts_acked(struct sock *sk, const struct ack_sample *samp
 {
 }
 
-static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
+static u32 bpf_tcp_ca_tso_segs(struct sock *sk, u32 mss_now)
 {
 	return 0;
 }
@@ -320,7 +320,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.cwnd_event_tx_start = bpf_tcp_ca_cwnd_event_tx_start,
 	.in_ack_event = bpf_tcp_ca_in_ack_event,
 	.pkts_acked = bpf_tcp_ca_pkts_acked,
-	.min_tso_segs = bpf_tcp_ca_min_tso_segs,
+	.tso_segs = bpf_tcp_ca_tso_segs,
 	.cong_control = bpf_tcp_ca_cong_control,
 	.undo_cwnd = bpf_tcp_ca_undo_cwnd,
 	.sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 82378a2bfd1e..15536564246c 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -297,11 +297,19 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 }
 
 /* override sysctl_tcp_min_tso_segs */
-__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
+static u32 bbr_min_tso_segs(struct sock *sk)
 {
 	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
 }
 
+__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
+{
+	u32 min_tso;
+
+	min_tso = bbr_min_tso_segs(sk);
+	return tcp_tso_autosize(sk, mss_now, min_tso);
+}
+
 static u32 bbr_tso_segs_goal(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1151,7 +1159,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 	.undo_cwnd	= bbr_undo_cwnd,
 	.cwnd_event_tx_start	= bbr_cwnd_event_tx_start,
 	.ssthresh	= bbr_ssthresh,
-	.min_tso_segs	= bbr_min_tso_segs,
+	.tso_segs	= bbr_tso_segs,
 	.get_info	= bbr_get_info,
 	.set_state	= bbr_set_state,
 };
@@ -1163,7 +1171,7 @@ BTF_ID_FLAGS(func, bbr_sndbuf_expand)
 BTF_ID_FLAGS(func, bbr_undo_cwnd)
 BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, bbr_ssthresh)
-BTF_ID_FLAGS(func, bbr_min_tso_segs)
+BTF_ID_FLAGS(func, bbr_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
 BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 26dd751ec72a..a09b00c5483e 100644
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


