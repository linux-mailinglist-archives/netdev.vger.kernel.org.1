Return-Path: <netdev+bounces-135553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7ED99E3F0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5091F23A40
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217001EC006;
	Tue, 15 Oct 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CSD9DNCT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2A1EABB3
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988232; cv=fail; b=n2Y8xfxf02EzkTojS5myUIlPvzepyyqwPUgckHl4oVs7CzU6yaga0zD6D6UWcEPFE4/fUqVQHNWnD7UHHRn7kU4SfHC2Yaq1tt93O5FkVg4onDSEF45njU/6xX17XvZkfSvTZpRYRe37QUFFp0cFmYycCIB/VuorsrGXT8wfwW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988232; c=relaxed/simple;
	bh=tYgk/DaGzLDOtcx2pOWmTbX1aS4Ow9+jX8sXtmXZjrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxTecR8TRgKQDWguheWOUFtSRSMVRQO3x/DS9OIHXdnWOeCIsGtMrP+Pf2pr9ooH3UH+yrH2GxrXtUR9BknsNc0cDfBtSHlKQO+cHbt2tiApc18iDUBmzEOSVhC+2H4aLru0pzBOc+DWzm4t5/HDZ0TMhdITqrrRqaRBfZ/o/04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CSD9DNCT; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofu2CGxABQ2eheTAdtRW/v7R70kD3368wEdZeIagXudpmOGji/UtbU4qsNgwIByshOaYylQITx/SorneIlgRGZk6Hpxm5Ip21r6yZFhDOq174lsOgO9ARCoSXB+iMnfuDg3vESplLrUOSgahaSyI1Mq2LYSb3zX8/HSwqj5Ny22ODWOiqhcxDYHyEBqNdVWmS4j9vpu++itu3C6uiUmxDoCHg+D+rGfHGRROWiNDR/UN6xleJXg6cpEZuVrfY+4qRJ9QQzQ3zU6gMPOLCrbG463nvHzk7/b7ZS9HoKf356JmXU5mLTVIMJeAJruMYPxQOVYQ0KaqW1mi1Njk6QsZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc5z1TX6WuXueX2v7fD8Qt8cKLaAykjsfrwwf1TxHnc=;
 b=f7NlbHBMwRoaVNXAZ+s0D0OYWYCCXmdYSg/Q/pUiCHd+o04i8XsSBPpn4jIiIEGdIF9XpL6RQwvdsDJIrUds9yhmzrEWl2Yu2RaWqh/0LqU3Bv34seyTzlZ88OcsDsPKd272pRjkclIFiWyg238vEpD7mD4LGpzpI8yg+42tozYL6TU5A6Ir37ohkfkpyj/TzehBB2FEsdYgfRvMtzyEB6lW4VX0106bfJvxKZ4RL71Zgw1HgTbSCacVsgjQoYPfQWVaInVqf4py9+LCBABSP6ffvmUyWVlxYyxYeJhhMQX/zxxBv9fmd616LCz1xXq32pYF/oz6RUq7jH5nyVK8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc5z1TX6WuXueX2v7fD8Qt8cKLaAykjsfrwwf1TxHnc=;
 b=CSD9DNCTcyvPUSdteJ8JF15eRKjRozWNvU2m1vMEB7YTeOOoiJbwHs7C5+NzbAj/aBJUtSeQ6/9YgJJ2tO8e/sLVq6rg7xz7cVcRbRHx4QiOhsJIBgTY2ezA1f0CWUoqvf8Q3+GNRg8QKn6IY4mjbE/xrArnEU6hR+xkUIXsS6FUUrEmDYQxAK023bDWkui9pESajsKSnvWbbFgcEngSdk2LNlKrSIJTw3CNkeMdpIscyZegbO9Zh+kcNy5QCzVVR+NGpL8iSyS6DOP1uHmGMpgjq/6Qa465YVSbDGmV9ySy28INE2y+Z0ZZ+8xPgLrHwNLz0NJUQYzWvh6hxlyLOw==
Received: from DU7P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::28)
 by PAXPR07MB7856.eurprd07.prod.outlook.com (2603:10a6:102:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:26 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::5a) by DU7P250CA0010.outlook.office365.com
 (2603:10a6:10:54f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:26 +0000
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
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnS029578;
	Tue, 15 Oct 2024 10:30:25 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 24/44] tcp: accecn: AccECN option failure handling
Date: Tue, 15 Oct 2024 12:29:20 +0200
Message-Id: <20241015102940.26157-25-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|PAXPR07MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: d5aa1f8b-2ab4-4e66-fe70-08dced046286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUIrNVNJWUQxVk5EZkV6UXZKSkYwSG5NMnNhU0FIaHhlWDF4TWh0NEhaekdr?=
 =?utf-8?B?dVVVOTV0aEIrTTdoRkJuUUdHU3lxQWR5a2NNMWJBUVljeU5lV1FlUUtNYjQ1?=
 =?utf-8?B?ZitwQzZDbVVESkxSOC8zdTNYTEdJNWEzMWdleXVUQ3poYUlXNkRDZGpOMUtl?=
 =?utf-8?B?MWxkNmN5K3c0d3ljT3N2cUY5bjRsc0dFZkV2a1RDWWRhQ1JKNC9yMDdNV3RG?=
 =?utf-8?B?dlZSSkJKWkI1bERGekR1UnZuRUdzbzhLejM4dWkxR2t4UzJFWDk5K2ltTity?=
 =?utf-8?B?YWdrL0hVdFFUZU5iV0hKZnFsZUJ0MytNNFpEMHFMZVphaE1vR3FLNFdaN0pK?=
 =?utf-8?B?T2I4c296MlZROXA5NHlsdHp0MkRvWUZpcXRwL3J6RDJPdXZRUXoxSUNTeXg0?=
 =?utf-8?B?ZnJHWFdsZVRXaE03RHZZY3pzT2JKYkZxSTYvSUl5VG4zNzVDSmpHM04xZ3FE?=
 =?utf-8?B?UFYzZlp4KzhmZVhDd2Nra25nWHlSNmRlWlZUOEZ3L0NKYVhHY3AxUFNZdWdw?=
 =?utf-8?B?RVFKcDR2Ni9rSW5YSWQ3TXczZEFJZTJnanA3SmtwTUw4RVJmRVZzMjFGR0RN?=
 =?utf-8?B?SWdwL3FFbEVZRDBGV3c5Uzc5Umc0QkxEMWVsclB1UjIwT3k3alBjL3dRUG9R?=
 =?utf-8?B?blUyamNudk43aG43dlRQc3k4Zk1UWFdraXMxakhYMFFiV1lwWTI5cndhK1hW?=
 =?utf-8?B?WkcxbUU4OTlJdEdKNWZwUjBtdGlmMEFzZlJRL2JMRGFBY0hQZ3hhL2hvdXY3?=
 =?utf-8?B?UWNuVUxrSFEyTGlETlBENUJjZ0x5bDBRZW5aSEEyREpKaHZiMXNIZGFMcERC?=
 =?utf-8?B?cTJJUk5ySGZDemJJTnVoc2xjb1hvQkZIWlRkbmhSRHNaenYxR3NsdVk2Zmdp?=
 =?utf-8?B?UDJNRGVpVFVERU5MRjBvdE9PMSs0K0FvNTh0cVlNY1pMWFNvMWZQZVdHdHo1?=
 =?utf-8?B?dVh0eWNXaHFxaE5tbmlyOVZCUzlYSTFJYzkrdVNHdmx0ZTUzRlVqMHFDSHJW?=
 =?utf-8?B?bUR1WUdkN0d0aE9NOW1QcGpXUldUb2NaYmliMkw5T2c0anJ0eFdiYmZXa2F0?=
 =?utf-8?B?aDJhenpyd3VHWnVUOTVqQno0WnZ3S2RCZWhDdmp3Q2RFd05CVEFjbStJQlJC?=
 =?utf-8?B?cUtBMkNSNlRpU3NDUkMxTnAwY05vQ1k0RmJkYUZCZE4vRmllOHpSVVg2R2RY?=
 =?utf-8?B?OGJhWDFoaVdLbjZRdzNSTG5KRFJUSDBkOGtGc2Z4MmprMzY4TCtZZXBNTjNv?=
 =?utf-8?B?cW9aSEhMNHRGeENYSXFOY1pOVHZCNzdtNDN1elNRZEs1MC9aakRMRDFnUG45?=
 =?utf-8?B?R3JsdXdJejRNdUFSTVlGZCtaZER2TXJobUFIWXRhUlNkSEc5YmxEM0JpK09a?=
 =?utf-8?B?ajBFeFJOY3ZaMzl0cGQxb3FvcUZSYXBjUk1mbU5GeHI2OGJZaVJYM2gwL2ha?=
 =?utf-8?B?UlZBRmcySHc4VzQwbE9vTnh6emJqSm1nYi9HU2RBdUV1ekhBSURwNGN6UGxC?=
 =?utf-8?B?TUw4NzMySUpkVjc5MmlqOFB6ZkM0OEdENFVlZ3VPODBRd21HYmMxcXl3TElN?=
 =?utf-8?B?c0Y2SmlDT0F4RXc5RFFDVUNTTzJNS01qcXBtYmZaeUUra2VTeUlxNENQMTVj?=
 =?utf-8?B?TFFDN0dSK0hvdklLbnNOc3dlNVJrV1RzUEc5T29DUmUxVW9mU28yK0NxZTJa?=
 =?utf-8?B?Zk04akFOVHpMbGVIUG4yeFpuUFlCVW9lenFVN3VabXFWaGZXbG95TUF1R2Qz?=
 =?utf-8?B?M0xlZWtRMUM3UTVJRzR5QjhobDRWWHJBVTl1T2JENXM1dGMzWGFjMk9NeHM0?=
 =?utf-8?B?a3hOR3kvL3hCYTREV0locktxM1JlSDNqOXFNVVdaL2toM1hkSkU1amVqajZm?=
 =?utf-8?Q?8BSZRqwmj/8Nb?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:26.6871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aa1f8b-2ab4-4e66-fe70-08dced046286
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7856

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

AccECN option may fail in various way, handle these:
- Remove option from SYN/ACK rexmits to handle blackholes
- If no option arrives in SYN/ACK, assume Option is not usable
        - If an option arrives later, re-enabled
- If option is zeroed, disable AccECN option processing

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  6 +++--
 include/net/tcp.h        |  7 ++++++
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 47 +++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c | 33 ++++++++++++++++++++++++++++
 net/ipv4/tcp_output.c    |  7 ++++--
 6 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e4aa10fdc032..d817a4d1e17c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -160,7 +160,8 @@ struct tcp_request_sock {
 	u8				accecn_ok  : 1,
 					syn_ect_snt: 2,
 					syn_ect_rcv: 2;
-	u8				accecn_fail_mode:4;
+	u8				accecn_fail_mode:4,
+					saw_accecn_opt  :2;
 	u32				txhash;
 	u32				rcv_isn;
 	u32				snt_isn;
@@ -387,7 +388,8 @@ struct tcp_sock {
 		syn_ect_snt:2,	/* AccECN ECT memory, only */
 		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
 		wait_third_ack:1; /* Need 3rd ACK in simultaneous open for AccECN */
-	u8	accecn_fail_mode:4;     /* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b3cbf9a11dbc..18c6f0ada141 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -274,6 +274,12 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+/* tp->saw_accecn_opt states */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
 #define TCP_NAGLE_CORK		2	/* Socket is corked	    */
@@ -475,6 +481,7 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 			       u32 payload_len);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e59fd2cabe03..7ef69b7265eb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3339,6 +3339,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 14b9a5e63687..a8669c407978 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -439,8 +439,8 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 }
 
 /* See Table 2 of the AccECN draft */
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -459,7 +459,14 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		tp->accecn_opt_demand = 2;
+		if (tp->rx_opt.accecn &&
+		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+			tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+								    tp->rx_opt.accecn);
+			if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+				tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+			tp->accecn_opt_demand = 2;
+		}
 		if (tcp_accecn_validate_syn_feedback(sk, ace, tp->syn_ect_snt) &&
 		    INET_ECN_is_ce(ip_dsfield)) {
 			tp->received_ce++;
@@ -574,7 +581,21 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	bool order1, res;
 	unsigned int i;
 
+	if (tcp_accecn_opt_fail_recv(tp))
+		return false;
+
 	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (!tp->saw_accecn_opt) {
+			/* Too late to enable after this point due to
+			 * potential counter wraps
+			 */
+			if (tp->bytes_sent >= (1 << 23) - 1) {
+				tp->saw_accecn_opt = TCP_ACCECN_OPT_FAIL_SEEN;
+				tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+			}
+			return false;
+		}
+
 		if (estimate_ecnfield) {
 			tp->delivered_ecn_bytes[estimate_ecnfield - 1] += delivered_bytes;
 			return true;
@@ -588,6 +609,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	order1 = (ptr[0] == TCPOPT_ACCECN1);
 	ptr += 2;
 
+	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+	}
+
 	res = !!estimate_ecnfield;
 	for (i = 0; i < 3; i++) {
 		if (optlen >= TCPOLEN_ACCECN_PERFIELD) {
@@ -6410,7 +6438,14 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			send_accecn_reflector = true;
-			tp->accecn_opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
+			if (tp->rx_opt.accecn &&
+			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+				tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+									    tp->rx_opt.accecn);
+				if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+					tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+				tp->accecn_opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
+			}
 		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
@@ -6900,7 +6935,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th, TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7476,6 +7511,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_synack = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 75baa72849fe..cce1816e4244 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -490,6 +490,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
@@ -544,6 +545,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
 #endif
 }
 
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
+{
+	unsigned char *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	ptr += 2;
+
+	/* Detect option zeroing: an AccECN connection "MAY check that the
+	 * initial value of the EE0B field or the EE1B field is non-zero"
+	 */
+	if (optlen < TCPOLEN_ACCECN_PERFIELD)
+		return TCP_ACCECN_OPT_EMPTY_SEEN;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+	if (optlen < TCPOLEN_ACCECN_PERFIELD * 3)
+		return TCP_ACCECN_OPT_COUNTER_SEEN;
+	ptr += TCPOLEN_ACCECN_PERFIELD * 2;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+
+	return TCP_ACCECN_OPT_COUNTER_SEEN;
+}
+
 /* This is not only more efficient than what we used to do, it eliminates
  * a lot of code duplication between IPv4/IPv6 SYN recv processing. -DaveM
  *
@@ -704,6 +729,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -879,6 +905,13 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!(flg & TCP_FLAG_ACK))
 		return NULL;
 
+	if (tcp_rsk(req)->accecn_ok && tmp_opt.accecn &&
+	    tcp_rsk(req)->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tcp_rsk(req)->saw_accecn_opt = tcp_accecn_option_init(skb, tmp_opt.accecn);
+		if (tcp_rsk(req)->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_OPT_FAIL_RECV;
+	}
+
 	/* For Fast Open no more processing is needed (sk is the
 	 * child socket).
 	 */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 22f6cfba5b27..ee23b08bd750 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1069,6 +1069,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		opts->ecn_bytes = synack_ecn_bytes;
@@ -1151,7 +1152,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->ecn_bytes = synack_ecn_bytes;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining,
 						    tcp_synack_options_combine_saving(opts));
@@ -1228,7 +1229,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp)) {
 		if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= 2 ||
 		    tp->accecn_opt_demand ||
 		    tcp_accecn_option_beacon_check(sk)) {
-- 
2.34.1


