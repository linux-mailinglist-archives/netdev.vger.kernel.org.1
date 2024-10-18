Return-Path: <netdev+bounces-136819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA89A32A6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F71F25034
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142316C684;
	Fri, 18 Oct 2024 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jEF23sWM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5913D881
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218125; cv=fail; b=XNa/nPGhCKDfJlPDXhoDIuFj2hpu5o0lhKOn5WSp6B4MzUiqccL/7UGKzz8yLleIoFBfegBI53Q2qT+/01OPscciS3OL9IgrCHqXjlr5eU/CHkFTacDUovkvIUo0crQZcZalGH2vEOwzqQOf3UYFBCPBC3SdoVjGlEGvZOTI3zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218125; c=relaxed/simple;
	bh=jdXed6V/Yh0NaH+TDgmUGtmxQ71q3BvRQy9Z+lTQNLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbmn+8kMR89A3Rp+3BBG1FPDwXwKD6S7MAm0NPspLH+A1YANAX4EVyfAqx4+henQN2/0QWRDVV8xbuhTAUiD2te+a1iNmaBivtL8FzDGsAvxlWBNDgCl3Dpblzk0vRXahB8jcwlx8YXdutR68PER0L3nS1GXGCQV5EQ5ZkM6dSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jEF23sWM; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysFLgs/bKYhJJ5RbaR1KKrpJVUeO6hMGQe10u31YOd41QdnotSXXsaaUiJYUfTDj8xIGXFYWhcrsdpHFyK71P3YsK7gxnFcSxUIKo75hS8Mbox4yOoCKcbVj0Yyn7eXOXiB51dKSe9c2gvkPPngs9LyNnxbpbi4MGP1/LYLLfHjQzZAuNyhGYtRm5X+HgNM7jRqaMKxTktc8mvGw2gn/dTqtwApuMa1VxzU05QDKKAi8Xiip0AwuU0Rtx4mJUJydIn274jnDlfBcIgPaOAerMEfiS0prJz6V8WTCrlljuKoaAfzzlv3vTPk1yW32U9wQEFGFYERMIv/PcVNEIDW4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULMd+A5h7VJxRvwiM7CWeriIZLgKm/nirYpOmNuOV6E=;
 b=mSgyv5ChAS7FO0aR32MH96NAALINlRgmeG6XtfNWujJ2beaDqt5QeZdCI5EK+2qyluIrvgTCenN4xUIDUJk7qZB2ZFjHE3Ayw3dzuVHcuGe7JDSqqmHMqDb89IA0sFwyexDcdqyPhxpbCoALiTm5Fgh4WL8zrWVlQ30F30RwdTftFlp8zJ3epbpD3HhOqsZQPzSJpCBgI8Wr74/7jecSP9jlYtYkpksMtKD08r7tsXchhm42hQF+FuWHBwR6yxK1hcTQGe+V2hRag1qdbkJrJnDFYKVgNahHfl5uSjFtM3mLogKV+fEhLPvvhQpqC5k0g/67b0LHbN6xO3+P6fajpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULMd+A5h7VJxRvwiM7CWeriIZLgKm/nirYpOmNuOV6E=;
 b=jEF23sWMmijgrEvt474q3LeeULjS//I7hnfwBYEf2xb6eUM9lqGWg7PjWWVCdgcd6HECxexwobJrWCqX+ajPt0aWz0ZGSDILz2WncM1d9ELxp31YIk4qy2wpzbKn3yI8So/KNtIdZWNlN8NBcYrJEFXD8X2qtxqqXfWaEH5yLDET5uLJkKxgL0UXvFmSs5ft8kW88ZY9PRmwvjZDCTBO98cGOo2UELlfzh3aiNbh5iSz2ynD9Z20kO3zPZvA8c+xdWoN+net1q+N1CUpUyUzqc7DdI6RSDW94HiZcCmtpn1JEuHqkittUti/RaEEToeqp8kG30u/fCPL0cKMcsiPuQ==
Received: from AS9P194CA0001.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::9)
 by VI1PR07MB6430.eurprd07.prod.outlook.com (2603:10a6:800:13a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:21:59 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:46d:cafe::fe) by AS9P194CA0001.outlook.office365.com
 (2603:10a6:20b:46d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Mb023685;
	Fri, 18 Oct 2024 02:21:58 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 07/14] tcp: helpers for ECN mode handling
Date: Fri, 18 Oct 2024 04:20:44 +0200
Message-Id: <20241018022051.39966-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|VI1PR07MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e9f64b-d537-4fee-7eeb-08dcef1ba557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2kxa0wrRjdIQUc2TWIxTFQ3R3pVNytQR1p4VStPNjllY0YxYUU3Qkh6ZG5Q?=
 =?utf-8?B?QjdQMWZlaGVPSytJNUtad3NKc1FFZnBjVmNBc1IzYW11SnE4NVFQU1k1dDlZ?=
 =?utf-8?B?QjZuZVJIblRQYnBBUHdUS0o2ZndsTmY3RVkwV0Ird1JsWFV3YVA3b3I3UTA3?=
 =?utf-8?B?M2dINUtMSXRGK0dOMm5RYjVJZ3AzUGVPOGFUVXdDUUlmdVNENDN4d1J5MlEw?=
 =?utf-8?B?UDBMNmQ2Vjd0N1NvZEZPK3VqaUFCZG1tTkpHd28zeERQYWRVU0V4eEh3M2hn?=
 =?utf-8?B?Rlg3Yy9xVFA3S2YxQ3RtS3kvWVlNZHF6RzBEdE54VUlRaFlNOEVFbnE1bGNl?=
 =?utf-8?B?S1VkaVgvRG56WG91SXphSWIrRXlaWE9xOW1Jc3k1LytOTlkwTDZ3WEhzYTEv?=
 =?utf-8?B?eFRYYkNrV1ZsMzdVTlErNThCWkRDdjdvOE1UZlVRZ3k2blgxa0xUTERFNXg3?=
 =?utf-8?B?bVVnVlRRcmlNYU1LLzdEbWRkcDRNVkJVek9ySnIvL1ljSG53MWNEanRnMWtZ?=
 =?utf-8?B?NHZ3MHRWMkI5RisxVTdySmduN3NNLzZYbitjQ1J6UWFlQ1BjcW1XWkVma0Zi?=
 =?utf-8?B?VnJHZUcvS1EvamczVUdhSnVXZDRXZEMxNFBYMVpPampJNThZb3NKM2VFNGdz?=
 =?utf-8?B?NWdYakQwRzdqYmNOa1lCbEpvL05HVVUvOCtRMGRsZ1BmYlJjUEN3c3lEamlY?=
 =?utf-8?B?OUh4QUJIbUovTUhpNXJiRFhHMUQ3dzVWUlp1SENSRkYxWXhIRlMwQ3JXOUEr?=
 =?utf-8?B?RFJrdjl6RGtMWEszTUtuZlJCTzl5SExYSmJmZ2oxUDdSSHJYQk5NNFlHWUNq?=
 =?utf-8?B?SWgxK051NlpBSXZGTmg4aFIvUUcwdWRUY1JsdlJsSnVaT0E5SWJRaUVTbVNZ?=
 =?utf-8?B?TzBNNFFIMmVGT2hIamJLZ2xFMDFWTFp1OHRnTXlTekVNbU9sTXJqQ1N0OVNP?=
 =?utf-8?B?SUF2OUZ4eXFLSGZyeVRLM09oalJlcHdTcHRaMVRxS3orK0kzM2NjRGkxV2pT?=
 =?utf-8?B?UWhnRVVrbENWQUM0NHVJMDNlbXMvdGdaZ2FNbW1BREF0enB0bjRBdXlNUVpB?=
 =?utf-8?B?QVlYM291UENsdFl0eHg2R1hycWVVWkI0OEpmN0o0bFVCMk5VWEVIeHk4bjFy?=
 =?utf-8?B?eFFJLzNyb01WYXR1VTFjeTJHTFc1UXpGTVRlL2lKamRtYTFvK0pUM0pmYlJR?=
 =?utf-8?B?a0FFWE50c2V2aVNzNmt6V1pudS96eGVBbEdITHBzeS9uY1prYUlFTGtFZ3lu?=
 =?utf-8?B?UFNCY0x3blorMVhpMjlCT0pCM3JTdnMxZ29yNTlZT0diNGx2L3BQdk5Uc1dr?=
 =?utf-8?B?SVBNYlMyazVJUmkvNTVtc2RSTU5JeFFvdy9xTnRkOTdObzVaYUhLdXNkRWlu?=
 =?utf-8?B?OG53eG5icjBnNnNkbzFaZ0R1RU5TSXUzK24rOW5ydnltSUhLVHl4UHB2TFc3?=
 =?utf-8?B?OVU3bWM2NGlGYUkzZGlCdnFGczFySnk4YzZ3dEplTTVMaDdRVnc2TmlyWmEz?=
 =?utf-8?B?MTZCYkszekdPZW0rSGhseTcxcFp4ODZ4RGxyc052bVFjOE91c3NZQlUwbTJ2?=
 =?utf-8?B?NzFLRFNjWm9keGYwdGdjSjAvMjBHc0krNWtLa1dhYnJKc3UyM2tRSTJVaG1M?=
 =?utf-8?B?RjhiamNUdnRWMFJsdTh5bkxFci9xTE9vU1lwTjgvSXVEY1Bad1AvbU9Ob053?=
 =?utf-8?B?SHNPempSYzh4OXZPNEY0STRENTNHUVg2VmhSeDZYSnp4UnAyZ004emhnM0N6?=
 =?utf-8?B?Vi9odmFvSThDNUJtOHNsYVRIWnFjVHhjN3liKzhRbjFaNy94YzdGZXljZDJD?=
 =?utf-8?B?c0czM09tdGNTekc5TEFHZEpUdkpxODRFTzJ6Y2pVaUh6T0RqRXhtRURUaWtG?=
 =?utf-8?B?eXFDUjg5dDVQMmpyNkNlSmY2bUZzQzdwU2JpbU54cjdtTHRqbUE2SnJhTjZJ?=
 =?utf-8?Q?TOgNE0xdwbU=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:59.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e9f64b-d537-4fee-7eeb-08dcef1ba557
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6430

From: Ilpo Järvinen <ij@kernel.org>

Create helpers for TCP ECN modes. No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        | 44 ++++++++++++++++++++++++++++++++++++----
 net/ipv4/tcp.c           |  2 +-
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++-------
 net/ipv4/tcp_minisocks.c |  4 +++-
 net/ipv4/tcp_output.c    |  6 +++---
 6 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 549fec6681d0..ae3f900f17c1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -372,10 +372,46 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 	}
 }
 
-#define	TCP_ECN_OK		1
-#define	TCP_ECN_QUEUE_CWR	2
-#define	TCP_ECN_DEMAND_CWR	4
-#define	TCP_ECN_SEEN		8
+#define	TCP_ECN_MODE_RFC3168	BIT(0)
+#define	TCP_ECN_QUEUE_CWR	BIT(1)
+#define	TCP_ECN_DEMAND_CWR	BIT(2)
+#define	TCP_ECN_SEEN		BIT(3)
+#define	TCP_ECN_MODE_ACCECN	BIT(4)
+
+#define	TCP_ECN_DISABLED	0
+#define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168|TCP_ECN_MODE_ACCECN)
+#define	TCP_ECN_MODE_ANY	(TCP_ECN_MODE_RFC3168|TCP_ECN_MODE_ACCECN)
+
+static inline bool tcp_ecn_mode_any(const struct tcp_sock *tp)
+{
+	return tp->ecn_flags & TCP_ECN_MODE_ANY;
+}
+
+static inline bool tcp_ecn_mode_rfc3168(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_RFC3168;
+}
+
+static inline bool tcp_ecn_mode_accecn(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_ACCECN;
+}
+
+static inline bool tcp_ecn_disabled(const struct tcp_sock *tp)
+{
+	return !tcp_ecn_mode_any(tp);
+}
+
+static inline bool tcp_ecn_mode_pending(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_PENDING) == TCP_ECN_MODE_PENDING;
+}
+
+static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
+{
+	tp->ecn_flags &= ~TCP_ECN_MODE_ANY;
+	tp->ecn_flags |= mode;
+}
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82cc4a5633ce..94546f55385a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4107,7 +4107,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_rcv_wscale = tp->rx_opt.rcv_wscale;
 	}
 
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_any(tp))
 		info->tcpi_options |= TCPI_OPT_ECN;
 	if (tp->ecn_flags & TCP_ECN_SEEN)
 		info->tcpi_options |= TCPI_OPT_ECN_SEEN;
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 8a45a4aea933..03abe0848420 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -90,7 +90,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
-	if ((tp->ecn_flags & TCP_ECN_OK) ||
+	if (tcp_ecn_mode_any(tp) ||
 	    (sk->sk_state == TCP_LISTEN ||
 	     sk->sk_state == TCP_CLOSE)) {
 		struct dctcp *ca = inet_csk_ca(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7b4e7ed8cc52..e8d32a231a9e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -334,7 +334,7 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
@@ -361,7 +361,7 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (!(tcp_sk(sk)->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		return;
 
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
@@ -394,19 +394,19 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || !th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if (th->ece && !th->syn && (tp->ecn_flags & TCP_ECN_OK))
+	if (th->ece && !th->syn && tcp_ecn_mode_rfc3168(tp))
 		return true;
 	return false;
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867a..bd6515ab660f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -453,7 +453,9 @@ EXPORT_SYMBOL(tcp_openreq_init_rwin);
 static void tcp_ecn_openreq_child(struct tcp_sock *tp,
 				  const struct request_sock *req)
 {
-	tp->ecn_flags = inet_rsk(req)->ecn_ok ? TCP_ECN_OK : 0;
+	tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+			     TCP_ECN_MODE_RFC3168 :
+			     TCP_ECN_DISABLED);
 }
 
 void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 64d47c18255f..bb83ad43a4e2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -322,7 +322,7 @@ static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 	const struct tcp_sock *tp = tcp_sk(sk);
 
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
-	if (!(tp->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
@@ -351,7 +351,7 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 			INET_ECN_xmit(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
@@ -379,7 +379,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tp->ecn_flags & TCP_ECN_OK) {
+	if (tcp_ecn_mode_rfc3168(tp)) {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-- 
2.34.1


