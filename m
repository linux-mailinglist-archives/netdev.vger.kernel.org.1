Return-Path: <netdev+bounces-135549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB199E3EC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122D71F23A1D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217421EBA1D;
	Tue, 15 Oct 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jLEFbNCH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F421CF5EE
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988228; cv=fail; b=EjDDxJRtsQZWMYJ5Dj0byHTszGOYm0N6oFTa+9QN7aXeNJN0UMFsCYDuFgt/Lf9W/dlLV8cft7hJyg44YL/wraApKXUvOOCgtjCebjdLMqsZshe3VhsbeFSoWwWvTMkMpXkOW3tOM55XcPCdwVHT+Z32UXT18KD4kDBqUil/RZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988228; c=relaxed/simple;
	bh=RJZ702L6i+bD3tlTU60URnYp1gcS/0mYSai8LLmYhtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWmnRFDvWjKxtzG0GVFZM/oJwNmcvldhv5Vrh3VOKfDcqopXd3OwCjm5MBedDeYbfFAdvYNTYqVaVN8u5Wy5pLU5cDnnTMtow0Fnmh3yPXJH5d8G0MrV3Oj0v8USWocK7E/mW89L8MPrziT6jD4gq4XaFoOlhaD+FNGB2eluoRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jLEFbNCH; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxlL9a90gTdVXt58clNqNh5WCITnjQPNIAJwzNxWBgGMkBiol234QuT9Cfk0VUDu5LR0BcDJhtq6UcE9TYvyY6nNjOd2Bf/shsRyy5FAuSrIFawLge//0asBEhJ1io1o04I+hwT8f3QpOZ7sfWDrCkRa0VGDMoU1aoRQcXmIqhRZ/XFz3ufEKOYXXLCLg2DaQynwLEm8YKEp864UYuUhMCMkhvCKldmhedw2V2Gtnu4mxjhO+tBQiKyMztJ/49vf2YirkZ68gRCQhw9r8ge+cfVLPpxlP/jswlN3Pw7lKxQ1tQTLUUspLLwc69Zq2xoONQ08jWHT7QJEkHssZRbMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAf0Zgoec2doKwCuYU6QaDGDuuPu/prOFFECekA2clA=;
 b=jHR426yVl+Lo6kC9N9I5km5pKC8nIOJXzY83m4WnEHJzxeiKJYRc8OhC8ksWCkrk3RD6u8xdNc63izWya0VwGASHjacLZzTDR7ocyMlkdWjJ1vs6tQSkbVgTJuUsEAqISbf6/o06SK0MTEcCiaTJGgvWT7q53rw5qny2kx1F2aHIQOoKCLMSqqDTTcXt+F6Q7sgQrUErvmjtQq0S2BSRlXIrLUl91G1mE48biNvGDP9VDBcAGHcA9kpIcu76TtQKlg16CzcJKjBZAqeR+7bFDCR5TlwcdVsPvZScdt4pkFTYqqEy3OOXfUHmwds3p0QNgCAh1A0Bae8ErrrE7hpYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAf0Zgoec2doKwCuYU6QaDGDuuPu/prOFFECekA2clA=;
 b=jLEFbNCH+hOzaZCql5S+bnMzGAok49TYYYCsqpT+1EVM57nqM4YEEDixQVebN73zM/zhEhqBZKpG2qGNnR5ItsNmUNoc00Ki3gnPb/uAXPHEYssFJ+ph5acdWyO2QJMiMPbhKWOW54+TE77g5Ngg3V3YFFRzRNdQaGyxdACwTcz/BvRMO0tvngQkrjpPCi4fuQNLYt/XHaoSfpRhXkvKuw0ckGUYJOaftnjTtfwK7T+sAO2q7gYfktegleaB1dfCCpLIa8bBfr6w8at5lqbid2iA4onSa5ZdAQIrHUgrJXqvp58fM6zPVwMuxeoez9vyJGTWRSdsG94jANFsZ0dRCg==
Received: from DU2PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:10:232::35)
 by AS8PR07MB7990.eurprd07.prod.outlook.com (2603:10a6:20b:39d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:22 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::e3) by DU2PR04CA0090.outlook.office365.com
 (2603:10a6:10:232::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnJ029578;
	Tue, 15 Oct 2024 10:30:20 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 15/44] tcp: AccECN core
Date: Tue, 15 Oct 2024 12:29:11 +0200
Message-Id: <20241015102940.26157-16-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0C:EE_|AS8PR07MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8956fb-6e97-4740-ab82-08dced045fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFpiWmR3MVZVN0daT00vY3YxazVRYUUwNVRLbEtuaFZ2MHl2NTRYSmtaL2pX?=
 =?utf-8?B?Y0tiUDV2aXlCckVKWldMUTBLL0Uvc3BDNE1LT0paUm95dW1rcmh0Y3dlaFBX?=
 =?utf-8?B?RndLQWh0eEFWdTYzTFlKbzdmZXB0bC8yZmxSd09abC9PSkMxbFNDak5ick1o?=
 =?utf-8?B?eUV1SDJkTmg2bmtKOVgrVDNMbmVoMWFkT1NqMkk4aGlUd0dFZWFOazdqNXlK?=
 =?utf-8?B?cWQ2UnhEN0NMQTFtalBSMFd2Z0txQ1hoMG10b0RvYndDS0E4SEJvSUFRdjZ4?=
 =?utf-8?B?SVV1d3MzQ1J3R3RSODN4SWhxemJOOGhUQ1NTdnJmdi9Fc2doZldiclhHaDJH?=
 =?utf-8?B?QkFzbEpBbENoQmMzMmVudGRQa1ZkNlpSWXFqdW1qbWl5dXU3K0pJMTBTOUdW?=
 =?utf-8?B?N3RpdTk0SHVmeDMwSG55NytoQmNyRkRuVHFzbFM3bjRURzBUaDA4SklmU1JS?=
 =?utf-8?B?TnMybVJlVEVIdFZqTHNSV3J5NHppUHpBSEt5dGptWGdrRWNCRHlleTVOWlQr?=
 =?utf-8?B?SUdqUkpsMkIzaFFWTWpoQ1hoMmsxdCtRVFlyeC9ES1dsUEJCMStaYSt4bDk0?=
 =?utf-8?B?eUlNQkIwSFc3SG41RndhR29NVFlldWxBSnZpL0dlMFBpUWpxQ3MvVzJhOFBI?=
 =?utf-8?B?Y3lVbkZHVXErdVU0VEFPUUpvVENVblBvV2lkYk5talRmd3YyelBORC9VMEdl?=
 =?utf-8?B?NnNqbFpQTDgwTUpuL2NJZkF3VXkxUUZDaU45VUxGTTFTOUNjSHovVnI0dXFp?=
 =?utf-8?B?Y3lVSTkzMWFHbVU0STliQmtZVVVhNk8yTDlsaThaTVM5TE8rc0w3WjloTmNv?=
 =?utf-8?B?RUxqeE45TWdUT216MU10UzlESWF0d2lTbGdMcEhubWdtc2hEY0l2UlpGV0Ru?=
 =?utf-8?B?RGtRMjBlajF4cytrMnhINjBxcFl0cVJoajVVdTVNWllEKzdRRUQ4YkM1cmRI?=
 =?utf-8?B?bjNmeHJhblVCc0hVRm5iV0FLd3ZHRGRuZ2Z2cWJxMHRQQ3RuTTFlbk45ZDJP?=
 =?utf-8?B?OFQxbWtrZUhIdUtPYVNQY1hUU2dOSkxBVk1ZeEpLRnljMTBCbm5JQUk5K0hn?=
 =?utf-8?B?YllxeVpuNzZwWkQ0ZDk3RE5hUk9JTE9jR2ZjN0lKZnB1dlU4Z1ArUHowV2ZL?=
 =?utf-8?B?Tm1WREd4ckpDQ1ptT0k2dCtvNnBqdDExTGFOek9sS3BManlwdFp5eE5BaEVu?=
 =?utf-8?B?VjR2OTBXY2U1bzVTZmVuSFYxbWRDYWM1eEdpWXBOZHZMOXZRVHZrNUt2TkVp?=
 =?utf-8?B?Y1llYjB1Wno5REw5Vkp3ek41RzMyQXF1YlZFVFRNV0VJRFJVQy9YcDBOdHlm?=
 =?utf-8?B?N3VNamZVamxtYXhUcHZnQW9RNEVVbGNDMXJtejFyclFadVNVY1pPbWlNbUM0?=
 =?utf-8?B?NU95VjRUVFhCN0lDMUZqc212eVBtd3ZSMDhocTJPZklOZHpPMnFnWEtJOSs2?=
 =?utf-8?B?YU5nZTVPVC9JRndBQXFFTThWRDZ1Smxzd1V5c0pKRStYR1BoMXcrOGJwejZQ?=
 =?utf-8?B?R1B0UWVMMnI4SHNwY3BHY3NjeEtLeU9oWlFUSXZJMWI3cTlRaW1mL0MwSlY2?=
 =?utf-8?B?bDNOS3RoemtVdkpjRGo4WVZxTnJWeHlTd0FQMzNkd2lTSUlROXYzUldKRDZ2?=
 =?utf-8?B?OGFEcU9SaXljYUIvOGhRQkJ0a3B1U1ZjZFZ6alRXSDNPQ0g4Q3BGWWZ6algr?=
 =?utf-8?B?M0dQQXR5VncreVlGdjcrUzBraEFVWjY2UWVxQVBMVWtxdmVUbG9kZVZWT0hj?=
 =?utf-8?B?WEQ5MFdPZjFmSm1lc1JJSGZ0OFJHL0R6NDhBN3lXSUNadlN2Zzg1MWdTZGF5?=
 =?utf-8?B?NTgwTjVaQjFSeTYyeW5WUFd5S08wdnR1MmtZS3g3bmVDblJWQmNHZlhmSmw0?=
 =?utf-8?Q?Rm/hXWkTfW7NO?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:22.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8956fb-6e97-4740-ab82-08dced045fe3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7990

From: Ilpo Järvinen <ij@kernel.org>

This change implements Accurate ECN without negotiation and
AccECN Option (that will be added by later changes). Based on
AccECN specifications:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN allows feeding back the number of CE (congestion
experienced) marks accurately to the sender in contrast to
RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
Congestion control algorithms can take advantage of the accurate
ECN information to fine-tune their congestion response to avoid
drastic rate reduction when only mild congestion is encountered.

With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
track of how many segments have arrived with a CE mark. Accurate
ECN uses ACE field (ECE, CWR, AE) to communicate the value back
to the sender which updates tp->delivered_ce (s.cep) based on the
feedback. This signalling channel is lossy when ACE field overflow
occurs.

Conservative strategy is selected here to deal with the ACE
overflow, however, some strategies using the AccECN option later
in the overall patchset mitigate against false overflows detected.

The ACE field values on the wire are offset by
TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
real CE marks rather than forcing all downstream users to adapt
to the wire offset.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   |   3 ++
 include/net/tcp.h     |  26 ++++++++++
 net/ipv4/tcp.c        |   4 +-
 net/ipv4/tcp_input.c  | 113 +++++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_output.c |  21 +++++++-
 5 files changed, 152 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..c36e519f3985 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -294,6 +294,9 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	received_ce;	/* Like the above but for received CE marked packets */
+	u8	received_ce_pending:4, /* Not yet transmitted cnt of received_ce */
+		unused2:4;
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7ceff62969e0..5ae0d1f9b083 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -413,6 +413,11 @@ static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->ecn_flags |= mode;
 }
 
+static inline u8 tcp_accecn_ace(const struct tcphdr *th)
+{
+	return (th->ae << 2) | (th->cwr << 1) | th->ece;
+}
+
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
@@ -938,6 +943,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
+#define TCP_ACCECN_CEP_ACE_MASK 0x7
+#define TCP_ACCECN_ACE_MAX_DELTA 6
+
+/* To avoid/detect middlebox interference, not all counters start at 0.
+ * See draft-ietf-tcpm-accurate-ecn for the latest values.
+ */
+#define TCP_ACCECN_CEP_INIT_OFFSET 5
+
+static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
+{
+	tp->received_ce = 0;
+	tp->received_ce_pending = 0;
+}
+
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
 	TCPCB_SACKED_ACKED	= (1 << 0),	/* SKB ACK'd by a SACK block	*/
@@ -1743,11 +1762,18 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 
 static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
 {
+	u32 ace;
+
 	/* mptcp hooks are only on the slow path */
 	if (sk_is_mptcp((struct sock *)tp))
 		return;
 
+	ace = tcp_ecn_mode_accecn(tp) ?
+	      ((tp->delivered_ce + TCP_ACCECN_CEP_INIT_OFFSET) &
+	       TCP_ACCECN_CEP_ACE_MASK) : 0;
+
 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       (ace << 22) |
 			       ntohl(TCP_FLAG_ACK) |
 			       snd_wnd);
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 94546f55385a..499f2a0be036 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3336,6 +3336,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5025,6 +5026,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5032,7 +5034,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e8d32a231a9e..fcc6b7a75db8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -334,14 +334,17 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
+	/* Do not set CWR if in AccECN mode! */
 	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
 static void tcp_ecn_accept_cwr(struct sock *sk, const struct sk_buff *skb)
 {
-	if (tcp_hdr(skb)->cwr) {
-		tcp_sk(sk)->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (tcp_ecn_mode_rfc3168(tp) && tcp_hdr(skb)->cwr) {
+		tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
 
 		/* If the sender is telling us it has entered CWR, then its
 		 * cwnd may be very low (even just 1 packet), so we should ACK
@@ -377,17 +380,16 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
 
-		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
+		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
+		    tcp_ecn_mode_rfc3168(tp)) {
 			/* Better not delay acks, sender can have a very low cwnd */
 			tcp_enter_quickack_mode(sk, 2);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	default:
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	}
 }
@@ -421,10 +423,62 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 				bool ece_ack)
 {
 	tp->delivered += delivered;
-	if (ece_ack)
+	if (tcp_ecn_mode_rfc3168(tp) && ece_ack)
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+/* Returns the ECN CE delta */
+static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+				u32 delivered_pkts, int flag)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta, safe_delta;
+	u32 corrected_ace;
+
+	/* Reordered ACK? (...or uncertain due to lack of data to send and ts) */
+	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
+		return 0;
+
+	if (!(flag & FLAG_SLOWPATH)) {
+		/* AccECN counter might overflow on large ACKs */
+		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+			return 0;
+	}
+
+	/* ACE field is not available during handshake */
+	if (flag & FLAG_SYN_ACKED)
+		return 0;
+
+	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
+		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+
+	corrected_ace = tcp_accecn_ace(tcp_hdr(skb)) - TCP_ACCECN_CEP_INIT_OFFSET;
+	delta = (corrected_ace - tp->delivered_ce) & TCP_ACCECN_CEP_ACE_MASK;
+	if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+		return delta;
+
+	safe_delta = delivered_pkts - ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
+
+	return safe_delta;
+}
+
+static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+			      u32 delivered_pkts, int *flag)
+{
+	u32 delta;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	if (delta > 0) {
+		tcp_count_delivered_ce(tp, delta);
+		*flag |= FLAG_ECE;
+		/* Recalculate header predictor */
+		if (tp->pred_flags)
+			tcp_fast_path_on(tp);
+	}
+	return delta;
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -3912,7 +3966,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
+			       u32 ecn_count, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -3920,8 +3975,12 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 
 	delivered = tp->delivered - prior_delivered;
 	NET_ADD_STATS(net, LINUX_MIB_TCPDELIVERED, delivered);
-	if (flag & FLAG_ECE)
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, delivered);
+
+	if (flag & FLAG_ECE) {
+		if (tcp_ecn_mode_rfc3168(tp))
+			ecn_count = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+	}
 
 	return delivered;
 }
@@ -3942,6 +4001,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
+	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4049,6 +4109,9 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered, &flag);
+
 	tcp_in_ack_event(sk, flag);
 
 	if (tp->tlp_high_seq)
@@ -4073,7 +4136,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, flag);
+	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
 	tcp_rate_gen(sk, delivered, lost, is_sack_reneg, sack_state.rate);
@@ -4082,12 +4146,14 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4108,7 +4174,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
@@ -5940,6 +6006,24 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 	}
 }
 
+/* Updates Accurate ECN received counters from the received IP ECN field */
+static void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+{
+	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+	u8 is_ce = INET_ECN_is_ce(ecnfield);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!INET_ECN_is_not_ect(ecnfield)) {
+		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+
+		tp->ecn_flags |= TCP_ECN_SEEN;
+
+		/* ACE counter tracks *all* segments including pure ACKs */
+		tp->received_ce += pcount;
+		tp->received_ce_pending = min(tp->received_ce_pending + pcount, 0xfU);
+	}
+}
+
 /* Accept RST for rcv_nxt - 1 after a FIN.
  * When tcp connections are abruptly terminated from Mac OSX (via ^C), a
  * FIN is sent followed by a RST packet. The RST is sent with the same
@@ -6188,6 +6272,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 				    tp->rcv_nxt == tp->rcv_wup)
 					flag |= __tcp_replace_ts_recent(tp, tstamp_delta);
 
+				tcp_ecn_received_counters(sk, skb);
+
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
@@ -6231,6 +6317,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			skb_dst_drop(skb);
 			__skb_pull(skb, tcp_header_len);
+			tcp_ecn_received_counters(sk, skb);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6271,6 +6358,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	tcp_ecn_received_counters(sk, skb);
+
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
 		reason = -reason;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 556c2da2bc77..42177f464d0c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -371,6 +371,17 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+{
+	u32 wire_ace;
+
+	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+	th->ece = !!(wire_ace & 0x1);
+	th->cwr = !!(wire_ace & 0x2);
+	th->ae = !!(wire_ace & 0x4);
+	tp->received_ce_pending = 0;
+}
+
 /* Set up ECN state for a packet on a ESTABLISHED socket that is about to
  * be sent.
  */
@@ -379,11 +390,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tcp_ecn_mode_rfc3168(tp)) {
+	if (!tcp_ecn_mode_any(tp))
+		return;
+
+	INET_ECN_xmit(sk);
+	if (tcp_ecn_mode_accecn(tp)) {
+		tcp_accecn_set_ace(th, tp);
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
+	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-			INET_ECN_xmit(sk);
 			if (tp->ecn_flags & TCP_ECN_QUEUE_CWR) {
 				tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 				th->cwr = 1;
-- 
2.34.1


