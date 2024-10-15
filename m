Return-Path: <netdev+bounces-135561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34F99E3F8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A3A1F23A15
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567851EF957;
	Tue, 15 Oct 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MOreTiGv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6481EF097
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988234; cv=fail; b=CPO56nLe3Rxun0NMyBf9zfdgSx3Mf/mng/5+6iQX5tcixTjcXkqyRr4RpiABv4VGmu5uFW5Mpnn1BJrvFupnPoTcztU0mAxbfa5AdMsGMRV+b5bxd3rI+gz/rPRSNUsijCiITan4VXGwalox1/ovbpaWaGzuf9Q16qwZCoSaymY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988234; c=relaxed/simple;
	bh=oI9YWbmfnn7bHGUF6Jhn8gM4ePyi183LuYShyt2yrrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd9ErFM/BzCvwCxKdSRqY8xuINbt6VL70WUle4Qv22jGzxNE1bQ0PLMEID76Zinp45mcCRalLnUTU8Ryprdh4UHUY7kIzhygaQ1Lqyfr5OwNRKZJRjGyoNKGCcAaveHhPclvz+68K2aMa7etE7bxiF87fZIl1cbtPbMMhrncmHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MOreTiGv; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu9KjXBCTlsAcCOcQ4UmOrhuFUjE9STwbKhZGdLRsQ0Eq+asnyWnB0YVb/tyf1IYc+6qIkiwXq3KS8qv5Yz7evLL5FzE8B04Ty9j0yaCyHkHfArdUec2Ovdof/vLoPPEhqWvjOVcS2NaqP4o3VW31Nv9OWHVbuQd4eT64yszpUVW+xmW22kK+qxcbFjUZ5CzJH61str2yX3uJgR3e67FrjxjeXdQq2M7/N04AjAFYXE2mEo09RoN1ljDWMFX1BL5YelhSsBnyFQY9jFqSZ3x2wQ+ADVsR2XejRg3r9kufACX3C8PRkeiPIZDr/YjVT8PAccV61j/xTkax1SUm21G/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuF+xJVS/1BDx9BCzigZZHdooEvb2yKsDDkfBtC63C0=;
 b=rC6jCHlbuV7aTLB7hr+Dh2mWTU8YfNmzvmqta06gTMm0OVMebWgUTy1Rf1iW6n21zSKkaghjTHH2BWWghcXf5qss5TvG+veSFhyNsRIq21GpDGMjdhzi9ubB1QrBgtrUkXpBqEIByiWdJ/QYoWZglol0KoqyQ9yY0l6p6zdyZPW2WwAf7KBfex/4tXAUp4NjO0K23TmCWN9/PmT2tyfbwsk1ocGROvAHp7CmhgtODVXQQhmYpIx1cJw124GBSIrIsyLu8U2sTltGB70cP8QigZg7NDs5+YQ8/aehKFInMgEmQpTQKcjItfmXFYsGT33+ZK5UxQM4hftUDuArwWAlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuF+xJVS/1BDx9BCzigZZHdooEvb2yKsDDkfBtC63C0=;
 b=MOreTiGvEDZ0BgN89JuvvSdw7UIXNwedSELqkN7dx6+uLuwfsSanK6UBWmRas/70LbuWf8YQFyqKYgjiNFsSHArZiBMfXKZOSQR+FfPaJKugyeDYafN58zZx7i21wkLm6/HfsPgTlgqX1tFKj0knKOIEgRrnQK0G9cpwOBanWeM+xELhFRAbb/JMgFm4kK7WreJOgdbIH0lWL68tp6aJe/s1y70/ncEfH2Y5bGstYzPrpuSN7rHJsjuL71S75DzXE+y3UNaVdKutP6l1S2pSksJWLkv1oZu9KJGPYMmNAuXqv2ASyb8TboX4F6aH3jpsy9reuWEOmJ825U5e5E0Y/A==
Received: from DBBPR09CA0005.eurprd09.prod.outlook.com (2603:10a6:10:c0::17)
 by PR3PR07MB8099.eurprd07.prod.outlook.com (2603:10a6:102:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:23 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::6c) by DBBPR09CA0005.outlook.office365.com
 (2603:10a6:10:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnL029578;
	Tue, 15 Oct 2024 10:30:21 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 17/44] tcp: accecn: AccECN negotiation
Date: Tue, 15 Oct 2024 12:29:13 +0200
Message-Id: <20241015102940.26157-18-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|PR3PR07MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: d71450eb-2210-4e93-aeb3-08dced0460a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHlib0x1YVhwTzNKM3RYOXA4WTRva3Q5WnBMOUpRdXZraXdXR29VVjVCa2d5?=
 =?utf-8?B?YitycytrWTcwaE9FT1RIZVNDTzRNWTZFLzFHSFJGMGhGVGtnZGwzSktiL1lH?=
 =?utf-8?B?TzFHWFY4MkVpZmlLK2JxMis4cHZOQWplcW5sVUJCTzhrZVFwcTBjdUVrQ0xO?=
 =?utf-8?B?MnZOSFJQcGdWVFFmS1NNT1MzTFZaYllwRUVZQ3RzekhCcy8wM1VaWWE5OTNY?=
 =?utf-8?B?dGdTRUNobXZqdFBwQ0hWVFFHVll3VFVOa01VbTgwM1A3SGNiTmlmUUloWEkv?=
 =?utf-8?B?elhucGRtaEx2QXc4WXFZVjRhYkZPSDB2MGhFV1BHYlRRZXF5emxSNE1Uc3FJ?=
 =?utf-8?B?YWw1aHBWUkp3M0RZSmJ6bDZGeGVJZkhuMlcrSGFZMGVUOTFuT3BTWk9BNThi?=
 =?utf-8?B?QW5JeEZKY0lyeHM2b2RDUzhSMzVQdGFJOUtKMGhWekFLNjB0NFI5cjRwampm?=
 =?utf-8?B?L1VOUUE1RWYxdnJjN3lRY0RUajRRQ3RubFpLRFk2VVNaWmRzbmZLbml4SkN6?=
 =?utf-8?B?ZUN2MWJjQTNDVkpqcXZiQ3F4R09uSkowZ2dHb3BjV09vMks4NEN0TEc5WEVP?=
 =?utf-8?B?d01pR2xqUjFZT3NDeStoMHRCbFlESXBtL3dsMXBTYWVWWk1tdlJoaFFNc0JW?=
 =?utf-8?B?OHJWRUtUVVdrUTZaQVdUT3JJajMvNUh1b2Zlb0xHWjg0cWZBcForUEI2NkFn?=
 =?utf-8?B?TEdkZG96dnFXWXpaSlFndVQxaUk5SUZueXlqSlNwWTYyUHVnSENiUHB3TGpx?=
 =?utf-8?B?dE45SXgzN1JWeHJCZmI3dVhSNXhsSmZ6NDZpaWl1MlFlMnNIK1c5bzNPZWIx?=
 =?utf-8?B?bDBzZWVBWEFPMGg4d21OS050djJUMzFOamtuaFVaZ1pVcFh4Ni80WER6U0dS?=
 =?utf-8?B?QUE1UEJVRjlWRzhIVS9TeE45bXp6ZFk1dE45aWoxcng5bDhvL2dWTVNVQ2FG?=
 =?utf-8?B?d3JiL2RxanJVREdhYXN0Q1BPTlJCVnR4NWI3YjFsUHhXaUo5S2xwQmlQaThj?=
 =?utf-8?B?L05McFh2Z0w4Q0FTNlU2L3Q3M2FidDlSQlA0NVpzbGxhelRxSHVBaXpzM3pE?=
 =?utf-8?B?a1doZFUrUmdGK2VPSENHTGdWcEgrVXNlK1N5RnVNaEQwcCtLalV2aG9OaVdo?=
 =?utf-8?B?Nnk3RGZGdlNhZEx0bXBseFVISkJFVEZqY2h5R2NlVnpNaXBBTGFPbTI5T1lo?=
 =?utf-8?B?NHREOFUwZVJZd3ZBMm9YUTZKdjBhNUFKUzkwWW5LZUtxajhjRW1TWFBtd1VQ?=
 =?utf-8?B?d1VPdFdpa2pmc2x0L3hOUXZjYkhXcjNBNS8wMktveXN3TmU3RkJIK0djWU9U?=
 =?utf-8?B?V3hpZWpJRURQa3Jlb28vN0VJMGdwdjZDTjBSVHN5WnpnOUZGc1E1cUVSVUJM?=
 =?utf-8?B?cDJ0NWZxbnNhT09ZUSszYUlEajZqVVpLNVNZYUFXTDJDZDNzcUlreHV2U2k3?=
 =?utf-8?B?MjJxdExvdmw1aE5vSXV0MUhpajhCV2JkaHEyeUlWbTR4VURuWStxeEZIRjV5?=
 =?utf-8?B?ZVNJenp1aFRpQUVpSndCOUE3MVBtaVBPV0ZzdzY1UWUzeGxNNXhJSXN5L3o0?=
 =?utf-8?B?Z1lkZG9zQi8yN3dCRWU1QXQzSWRWM0JzcE5zNFIwdVIyRTdCZGExaE1ETUJk?=
 =?utf-8?B?U0VveWFCeVJ3VDVpTk03WnlaVHZrWTRRMDRxQWpBUWNlalB1b01WSnBBaXIz?=
 =?utf-8?B?aVlwN3NCMjNIOE1RckhFemFTV0c3SjlUQlBrajJaeTVpQnJiK3hjRFAwODNn?=
 =?utf-8?B?R3NIK3prQmpBbjVia0RXTE9OTC9QQVQyRXl6cFhXRUFyNyttMCtENGZSbHhw?=
 =?utf-8?B?TWFkUDQrbnpMeUVuQkxsUFZCbDFGYythc3pXb2pJcjBNVU1tRXVZNXlHOGJ5?=
 =?utf-8?B?aFhSNU85c3EwQkJrTW5jNnMzaWljUmRjNVFlYjlZUW41VUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:23.5524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71450eb-2210-4e93-aeb3-08dced0460a8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8099

From: Ilpo Järvinen <ij@kernel.org>

Accurate ECN negotiation parts based on the specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN is negotiated using ECE, CWR and AE flags in the
TCP header. TCP falls back into using RFC3168 ECN if one of the
ends supports only RFC3168-style ECN.

The AccECN negotiation includes reflecting IP ECN field value
seen in SYN and SYNACK back using the same bits as negotiation
to allow responding to SYN CE marks and to detect ECN field
mangling. CE marks should not occur currently because SYN=1
segments are sent with Non-ECT in IP ECN field (but proposal
exists to remove this restriction).

Reflecting SYN IP ECN field in SYNACK is relatively simple.
Reflecting SYNACK IP ECN field in the final/third ACK of
the handshake is more challenging. Linux TCP code is not well
prepared for using the final/third ACK a signalling channel
which makes things somewhat complicated here.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h        |   9 ++-
 include/net/tcp.h          |  80 +++++++++++++++++++-
 net/ipv4/syncookies.c      |   3 +
 net/ipv4/sysctl_net_ipv4.c |   2 +-
 net/ipv4/tcp.c             |   2 +
 net/ipv4/tcp_input.c       | 149 +++++++++++++++++++++++++++++++++----
 net/ipv4/tcp_ipv4.c        |   3 +-
 net/ipv4/tcp_minisocks.c   |  51 +++++++++++--
 net/ipv4/tcp_output.c      |  77 +++++++++++++++----
 net/ipv6/syncookies.c      |   1 +
 net/ipv6/tcp_ipv6.c        |   1 +
 11 files changed, 336 insertions(+), 42 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index c36e519f3985..4970ce3ee864 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -156,6 +156,10 @@ struct tcp_request_sock {
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool				drop_req;
 #endif
+	u8				accecn_ok  : 1,
+					syn_ect_snt: 2,
+					syn_ect_rcv: 2;
+	u8				accecn_fail_mode:4;
 	u32				txhash;
 	u32				rcv_isn;
 	u32				snt_isn;
@@ -372,7 +376,10 @@ struct tcp_sock {
 	u8	compressed_ack;
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
-		unused:5;
+		syn_ect_snt:2,	/* AccECN ECT memory, only */
+		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
+		wait_third_ack:1; /* Need 3rd ACK in simultaneous open for AccECN */
+	u8	accecn_fail_mode:4;     /* AccECN failure handling */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5ae0d1f9b083..6a387d4b2fa1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -27,6 +27,7 @@
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
 #include <linux/bits.h>
+#include <linux/bitfield.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
@@ -232,6 +233,37 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
 
+/* tp->accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND       BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV       BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND       BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV       BIT(3)
+
+static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
+}
+
+static inline bool tcp_accecn_ace_fail_recv(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_RECV;
+}
+
+static inline bool tcp_accecn_opt_fail_send(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_SEND;
+}
+
+static inline bool tcp_accecn_opt_fail_recv(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_RECV;
+}
+
+static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
+{
+	tp->accecn_fail_mode |= mode;
+}
+
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
 #define TCP_NAGLE_CORK		2	/* Socket is corked	    */
@@ -418,6 +450,23 @@ static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
 }
 
+/* Infer the ECT value our SYN arrived with from the echoed ACE field */
+static inline int tcp_accecn_extract_syn_ect(u8 ace)
+{
+	if (ace & 0x1)
+		return INET_ECN_ECT_1;
+	if (!(ace & 0x2))
+		return INET_ECN_ECT_0;
+	if (ace & 0x4)
+		return INET_ECN_CE;
+	return INET_ECN_NOT_ECT;
+}
+
+bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
+void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
+			  u8 syn_ect_snt);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
@@ -653,6 +702,15 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 		dst_feature(dst, RTAX_FEATURE_ECN);
 }
 
+/* AccECN specification, 5.1: [...] a server can determine that it
+ * negotiated AccECN as [...] if the ACK contains an ACE field with
+ * the value 0b010 to 0b111 (decimal 2 to 7).
+ */
+static inline bool cookie_accecn_ok(const struct tcphdr *th)
+{
+	return tcp_accecn_ace(th) > 0x1;
+}
+
 #if IS_ENABLED(CONFIG_BPF)
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
@@ -942,6 +1000,7 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
+#define TCPHDR_SYNACK_ACCECN (TCPHDR_SYN | TCPHDR_ACK | TCPHDR_CWR)
 
 #define TCP_ACCECN_CEP_ACE_MASK 0x7
 #define TCP_ACCECN_ACE_MAX_DELTA 6
@@ -1023,6 +1082,15 @@ struct tcp_skb_cb {
 
 #define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))
 
+static inline u16 tcp_accecn_reflector_flags(u8 ect)
+{
+	u32 flags = ect + 2;
+
+	if (ect == 3)
+		flags++;
+	return FIELD_PREP(TCPHDR_ACE, flags);
+}
+
 extern const struct inet_connection_sock_af_ops ipv4_specific;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1145,7 +1213,10 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN)
 
 union tcp_cc_info;
 
@@ -1277,6 +1348,13 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 1948d15f1f28..3bd6274c8bcb 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -401,6 +401,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
+	struct tcp_request_sock *treq;
 	struct net *net = sock_net(sk);
 	struct request_sock *req;
 	struct sock *ret = sk;
@@ -427,6 +428,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	}
 
 	ireq = inet_rsk(req);
+	treq = tcp_rsk(req);
 
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
@@ -481,6 +483,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
+	treq->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a79b2a52ce01..01fcc6b2045b 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -726,7 +726,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_FIVE,
 	},
 	{
 		.procname	= "tcp_ecn_fallback",
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 499f2a0be036..f5ceadb43efb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3336,6 +3336,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tp->wait_third_ack = 0;
+	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fcc6b7a75db8..0591c605b57a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -394,14 +394,91 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
+/* AccECN specificaiton, 3.1.2: If a TCP server that implements AccECN
+ * receives a SYN with the three TCP header flags (AE, CWR and ECE) set
+ * to any combination other than 000, 011 or 111, it MUST negotiate the
+ * use of AccECN as if they had been set to 111.
+ */
+static bool tcp_accecn_syn_requested(const struct tcphdr *th)
+{
+	u8 ace = tcp_accecn_ace(th);
+
+	return ace && ace != 0x3;
+}
+
+/* Check ECN field transition to detect invalid transitions */
+static bool tcp_ect_transition_valid(u8 snt, u8 rcv)
+{
+	if (rcv == snt)
+		return true;
+
+	/* Non-ECT altered to something or something became non-ECT */
+	if (snt == INET_ECN_NOT_ECT || rcv == INET_ECN_NOT_ECT)
+		return false;
+	/* CE -> ECT(0/1)? */
+	if (snt == INET_ECN_CE)
+		return false;
+	return true;
+}
+
+bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 {
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+	u8 ect = tcp_accecn_extract_syn_ect(ace);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback)
+		return true;
+
+	if (!tcp_ect_transition_valid(sent_ect, ect)) {
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		return false;
+	}
+
+	return true;
+}
+
+/* See Table 2 of the AccECN draft */
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
+			       u8 ip_dsfield)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 ace = tcp_accecn_ace(th);
+
+	switch (ace) {
+	case 0x0:
+	case 0x7:
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		break;
+	case 0x1:
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp))
+			/* Downgrade from AccECN, or requested initially */
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		break;
+	default:
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		if (tcp_accecn_validate_syn_feedback(sk, ace, tp->syn_ect_snt) &&
+		    INET_ECN_is_ce(ip_dsfield)) {
+			tp->received_ce++;
+			tp->received_ce_pending++;
+		}
+		break;
+	}
 }
 
-static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th)
+static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+			    const struct sk_buff *skb)
 {
+	if (tcp_ecn_mode_pending(tp)) {
+		if (!tcp_accecn_syn_requested(th)) {
+			/* Downgrade to classic ECN feedback */
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		} else {
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		}
+	}
 	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
@@ -3825,7 +3902,7 @@ bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 }
 
 /* RFC 5961 7 [ACK Throttling] */
-static void tcp_send_challenge_ack(struct sock *sk)
+static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
@@ -3855,7 +3932,8 @@ static void tcp_send_challenge_ack(struct sock *sk)
 		WRITE_ONCE(net->ipv4.tcp_challenge_count, count - 1);
 send_ack:
 		NET_INC_STATS(net, LINUX_MIB_TCPCHALLENGEACK);
-		tcp_send_ack(sk);
+		__tcp_send_ack(sk, tp->rcv_nxt,
+			       !accecn_reflector ? 0 : tcp_accecn_reflector_flags(tp->syn_ect_rcv));
 	}
 }
 
@@ -4022,7 +4100,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
 		if (before(ack, prior_snd_una - max_window)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
-				tcp_send_challenge_ack(sk);
+				tcp_send_challenge_ack(sk, false);
 			return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;
 		}
 		goto old_ack;
@@ -6007,7 +6085,7 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-static void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6047,6 +6125,7 @@ static bool tcp_reset_check(const struct sock *sk, const struct sk_buff *skb)
 static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 				  const struct tcphdr *th, int syn_inerr)
 {
+	bool send_accecn_reflector = false;
 	struct tcp_sock *tp = tcp_sk(sk);
 	SKB_DR(reason);
 
@@ -6128,7 +6207,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (tp->syn_fastopen && !tp->data_segs_in &&
 		    sk->sk_state == TCP_ESTABLISHED)
 			tcp_fastopen_active_disable(sk);
-		tcp_send_challenge_ack(sk);
+		tcp_send_challenge_ack(sk, false);
 		SKB_DR_SET(reason, TCP_RESET);
 		goto discard;
 	}
@@ -6139,16 +6218,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
+		if (tcp_ecn_mode_accecn(tp))
+			send_accecn_reflector = true;
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
-		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
+		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt) {
+			if (!tcp_ecn_disabled(tp)) {
+				tp->wait_third_ack = true;
+				__tcp_send_ack(sk, tp->rcv_nxt,
+					       !send_accecn_reflector ? 0 :
+					       tcp_accecn_reflector_flags(tp->syn_ect_rcv));
+			}
 			goto pass;
+		}
 syn_challenge:
 		if (syn_inerr)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNCHALLENGE);
-		tcp_send_challenge_ack(sk);
+		tcp_send_challenge_ack(sk, send_accecn_reflector);
 		SKB_DR_SET(reason, TCP_INVALID_SYN);
 		goto discard;
 	}
@@ -6358,6 +6446,13 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	if (unlikely(tp->wait_third_ack)) {
+		if (!tcp_ecn_disabled(tp))
+			tp->wait_third_ack = 0;
+		if (tcp_ecn_mode_accecn(tp))
+			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+		tcp_fast_path_on(tp);
+	}
 	tcp_ecn_received_counters(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
@@ -6611,7 +6706,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 *    state to ESTABLISHED..."
 		 */
 
-		tcp_ecn_rcv_synack(tp, th);
+		if (tcp_ecn_mode_any(tp))
+			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -6683,7 +6779,9 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 						  TCP_DELACK_MAX, TCP_RTO_MAX);
 			goto consume;
 		}
-		tcp_send_ack(sk);
+		__tcp_send_ack(sk, tp->rcv_nxt,
+			       !tcp_ecn_mode_accecn(tp) ? 0 :
+			       tcp_accecn_reflector_flags(tp->syn_ect_rcv));
 		return -1;
 	}
 
@@ -6742,7 +6840,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th);
+		tcp_ecn_rcv_syn(tp, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
@@ -6925,7 +7023,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
-			tcp_send_challenge_ack(sk);
+			tcp_send_challenge_ack(sk, false);
 			reason = -reason;
 			goto discard;
 		}
@@ -6972,9 +7070,16 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->lsndtime = tcp_jiffies32;
 
 		tcp_initialize_rcv_mss(sk);
-		tcp_fast_path_on(tp);
+		if (likely(!tp->wait_third_ack)) {
+			if (tcp_ecn_mode_accecn(tp))
+				tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+			tcp_fast_path_on(tp);
+		}
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
+
+		if (sk->sk_socket && tp->wait_third_ack)
+			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {
@@ -7144,6 +7249,14 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	bool ect, ecn_ok;
 	u32 ecn_ok_dst;
 
+	if (tcp_accecn_syn_requested(th) &&
+	    (net->ipv4.sysctl_tcp_ecn >= 3 || tcp_ca_needs_accecn(listen_sk))) {
+		inet_rsk(req)->ecn_ok = 1;
+		tcp_rsk(req)->accecn_ok = 1;
+		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+		return;
+	}
+
 	if (!th_ecn)
 		return;
 
@@ -7151,7 +7264,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	ecn_ok_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
 	ecn_ok = READ_ONCE(net->ipv4.sysctl_tcp_ecn) || ecn_ok_dst;
 
-	if (((!ect || th->res1) && ecn_ok) || tcp_ca_needs_ecn(listen_sk) ||
+	if (((!ect || th->res1 || th->ae) && ecn_ok) ||
+	    tcp_ca_needs_ecn(listen_sk) ||
 	    (ecn_ok_dst & DST_FEATURE_ECN_CA) ||
 	    tcp_bpf_ca_needs_ecn((struct sock *)req))
 		inet_rsk(req)->ecn_ok = 1;
@@ -7168,6 +7282,9 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->rcv_nxt = TCP_SKB_CB(skb)->seq + 1;
 	tcp_rsk(req)->snt_synack = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
+	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->syn_ect_rcv = 0;
+	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
 	req->ts_recent = rx_opt->saw_tstamp ? rx_opt->rcv_tsval : 0;
 	ireq->tstamp_ok = rx_opt->tstamp_ok;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9419e7b492fc..97df9f36714c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1182,7 +1182,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 			      enum tcp_synack_type synack_type,
 			      struct sk_buff *syn_skb)
 {
-	const struct inet_request_sock *ireq = inet_rsk(req);
+	struct inet_request_sock *ireq = inet_rsk(req);
 	struct flowi4 fl4;
 	int err = -1;
 	struct sk_buff *skb;
@@ -1195,6 +1195,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 	skb = tcp_make_synack(sk, dst, req, foc, synack_type, syn_skb);
 
 	if (skb) {
+		tcp_rsk(req)->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
 		__tcp_v4_send_check(skb, ireq->ir_loc_addr, ireq->ir_rmt_addr);
 
 		tos = READ_ONCE(inet_sk(sk)->tos);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 8fb9f550fdeb..81d42942c335 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -450,12 +450,51 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 }
 EXPORT_SYMBOL(tcp_openreq_init_rwin);
 
-static void tcp_ecn_openreq_child(struct tcp_sock *tp,
-				  const struct request_sock *req)
+void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
+			  u8 syn_ect_snt)
 {
-	tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-			     TCP_ECN_MODE_RFC3168 :
-			     TCP_ECN_DISABLED);
+	u8 ace = tcp_accecn_ace(tcp_hdr(skb));
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	switch (ace) {
+	case 0x0:
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		break;
+	case 0x7:
+	case 0x5:
+	case 0x1:
+		/* Unused but legal values */
+		break;
+	default:
+		/* Validation only applies to first non-data packet */
+		if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq &&
+		    !TCP_SKB_CB(skb)->sacked &&
+		    tcp_accecn_validate_syn_feedback(sk, ace, syn_ect_snt)) {
+			if ((tcp_accecn_extract_syn_ect(ace) == INET_ECN_CE) &&
+			    !tp->delivered_ce)
+				tp->delivered_ce++;
+		}
+		break;
+	}
+}
+
+static void tcp_ecn_openreq_child(struct sock *sk,
+				  const struct request_sock *req,
+				  const struct sk_buff *skb)
+{
+	const struct tcp_request_sock *treq = tcp_rsk(req);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (treq->accecn_ok) {
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		tp->syn_ect_snt = treq->syn_ect_snt;
+		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tcp_ecn_received_counters(sk, skb);
+	} else {
+		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+				     TCP_ECN_MODE_RFC3168 :
+				     TCP_ECN_DISABLED);
+	}
 }
 
 void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
@@ -621,7 +660,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
 		newicsk->icsk_ack.last_seg_size = skb->len - newtp->tcp_header_len;
 	newtp->rx_opt.mss_clamp = req->mss;
-	tcp_ecn_openreq_child(newtp, req);
+	tcp_ecn_openreq_child(newsk, req, skb);
 	newtp->fastopen_req = NULL;
 	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 42177f464d0c..ebda1b71d489 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -319,7 +319,7 @@ static u16 tcp_select_window(struct sock *sk)
 /* Packet ECN state for a SYN-ACK */
 static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 {
-	const struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
 	if (tcp_ecn_disabled(tp))
@@ -327,6 +327,12 @@ static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
 		INET_ECN_xmit(sk);
+
+	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
+		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
+		TCP_SKB_CB(skb)->tcp_flags |= tcp_accecn_reflector_flags(tp->syn_ect_rcv);
+		tp->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
+	}
 }
 
 /* Packet ECN state for a SYN.  */
@@ -334,8 +340,20 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool bpf_needs_ecn = tcp_bpf_ca_needs_ecn(sk);
-	bool use_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn) == 1 ||
-		tcp_ca_needs_ecn(sk) || bpf_needs_ecn;
+	bool use_ecn, use_accecn;
+	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
+
+	/* ==============  ==========================
+	 * tcp_ecn values  Outgoing connections
+	 * ==============  ==========================
+	 *      0,2,5       Do not request ECN
+	 *       1,4        Request ECN connection
+	 *        3         Request AccECN connection
+	 * ==============  ==========================
+	 */
+	use_accecn = tcp_ecn == 3 || tcp_ca_needs_accecn(sk);
+	use_ecn = tcp_ecn == 1 || tcp_ecn == 4 ||
+		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
 
 	if (!use_ecn) {
 		const struct dst_entry *dst = __sk_dst_get(sk);
@@ -351,35 +369,58 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 			INET_ECN_xmit(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		if (use_accecn) {
+			TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_AE;
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_PENDING);
+			tp->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
+		} else {
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		}
 	}
 }
 
 static void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 {
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback))
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback)) {
 		/* tp->ecn_flags are cleared at a later point in time when
 		 * SYN ACK is ultimatively being received.
 		 */
-		TCP_SKB_CB(skb)->tcp_flags &= ~(TCPHDR_ECE | TCPHDR_CWR);
+		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
+	}
+}
+
+static void tcp_accecn_echo_syn_ect(struct tcphdr *th, u8 ect)
+{
+	th->ae = !!(ect & INET_ECN_ECT_0);
+	th->cwr = ect != INET_ECN_ECT_0;
+	th->ece = ect == INET_ECN_ECT_1;
 }
 
 static void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (inet_rsk(req)->ecn_ok)
+	if (tcp_rsk(req)->accecn_ok)
+		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+	else if (inet_rsk(req)->ecn_ok)
 		th->ece = 1;
 }
 
-static void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+static void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
+			       struct tcphdr *th)
 {
 	u32 wire_ace;
 
-	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
-	th->ece = !!(wire_ace & 0x1);
-	th->cwr = !!(wire_ace & 0x2);
-	th->ae = !!(wire_ace & 0x4);
-	tp->received_ce_pending = 0;
+	/* The final packet of the 3WHS or anything like it must reflect
+	 * the SYN/ACK ECT instead of putting CEP into ACE field, such
+	 * case show up in tcp_flags.
+	 */
+	if (likely(!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACE))) {
+		wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+		th->ece = !!(wire_ace & 0x1);
+		th->cwr = !!(wire_ace & 0x2);
+		th->ae = !!(wire_ace & 0x4);
+		tp->received_ce_pending = 0;
+	}
 }
 
 /* Set up ECN state for a packet on a ESTABLISHED socket that is about to
@@ -393,9 +434,10 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 	if (!tcp_ecn_mode_any(tp))
 		return;
 
-	INET_ECN_xmit(sk);
+	if (!tcp_accecn_ace_fail_recv(tp))
+		INET_ECN_xmit(sk);
 	if (tcp_ecn_mode_accecn(tp)) {
-		tcp_accecn_set_ace(th, tp);
+		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
@@ -3404,7 +3446,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback */
+	/* RFC3168, section 6.1.1.1. ECN fallback
+	 * As AccECN uses the same SYN flags (+ AE), this check covers both
+	 * cases.
+	 */
 	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
 		tcp_ecn_clear_syn(sk, skb);
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 9d83eadd308b..50046460ee0b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -264,6 +264,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
+	tcp_rsk(req)->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 	if (!ret) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d9551c9cd562..6e49f22ce379 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -542,6 +542,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 	skb = tcp_make_synack(sk, dst, req, foc, synack_type, syn_skb);
 
 	if (skb) {
+		tcp_rsk(req)->syn_ect_snt = np->tclass & INET_ECN_MASK;
 		__tcp_v6_send_check(skb, &ireq->ir_v6_loc_addr,
 				    &ireq->ir_v6_rmt_addr);
 
-- 
2.34.1


