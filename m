Return-Path: <netdev+bounces-136816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922289A32A1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60AB1C237F9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6151547F0;
	Fri, 18 Oct 2024 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FvQ3TA8j"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0951428E0
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218105; cv=fail; b=mu47meJEYOaSW4PfLdsBRHEQruT0NbBtoPpoHMu59/itJz6CE0fz0gnsOyMgQgxMDogjN0BOi0bA2No+PgFaSHCkRtbQxvrGJ0cVGhkDXyGHPNDey3jTcbnSBXzQwa09xFwIrHxaJi9vmhmVNwDYt0Hl3vF0bJrz39d0ywsmybI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218105; c=relaxed/simple;
	bh=Hmdtr0We50ejAD355SghSxW3LOTq66I4DTi+GKYgG1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO6njd0fFDhscmGN6GzGfuDwc+5/UeWmnWiEQR6gKfkjjdQ8Ap00BoIx5NMeR5KZpwTrjkljfAgiv2scJ5x8gGcDGtyrSeoYYRM5k1s+f0L/Gq6FxK1bVhTMyvr7IziWlO/OiRbbO5XYhePCgG4Z9xPqE9uvvaiimu4QDypoL98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FvQ3TA8j; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTOLN7M7zuM/rv7PKZJmswZqdRzyf/778CubqKG8xwsMuYtbknAtzbaVFIfVagurnUT1LHdogd6B+/PG+dXN6NHsMx9KOzXjLv7vd9Y6duCWH6cMeHVIaPH9WDlSE4nUfk0LKaXd/EkjvxZKfjeaQ1mqV9tp7M0kjxKbzWUjlW7bVEh53yBu3xTeilk1Fhh0na6X3xbh3JDroY5TbkaLO3+GsW50PVBMAL1OxwRX+kXTXAeYO+WYzVtsI5PU6NZTjf49o0CuLX70oKMic8xv7Ze0n1Vc6/VU20ckTrubdVgsujYGA71qAsRgfVZt55Bek/UiN/fWoY6HsS6N1HW+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJtuM1nTfrSpcdQnGQbMn0HkkJCOFzlul0aCRL1BYBc=;
 b=S7o7jUnHEqfmkmKG3m+RyMTk4T/i+H5alA2d/gqVbzRc/AMUy6SmqEdV7gYcNmxZTxfGGAg44VBggA7bGRlJ+S7BB84zxg5nkcaOdSWQ2pKp+t13uJYG73JpNA32F7/8j86DtUHD/k5k5awMM52cuorPOC7ASgk4qsYRUrmaicAgo1/zvDcYZnTqn5ip2rAOKJD/VYieuc33lN6qyNDlrYIrW8ws8LJIqXUk2lKaBsyGKSYNe+msOU7Vc+a/Z0sfiIoTMK2/lsgfRKqBFBoIDfCO06+41f4tDjZ7z7NPNDcthTnlUCiqnioda/kNHJz0ZunPLXwISo1YjAccbEhgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJtuM1nTfrSpcdQnGQbMn0HkkJCOFzlul0aCRL1BYBc=;
 b=FvQ3TA8jS+9CrYoVSn7IBrodQH2cuxuoOWPfR/0IbpCWcUUN6LLV+42+kTqpqf0JTBfsOkAZUqxb6uXt94RoFh90OWwTMvzG8NW13AWCwN1p9iSVe3WGkbgNSDMNtuR8VN0zjLl1PnE0ZF0ItL72vL5B4l/mHa5nwNAwagYS4HgBYJyEL7mc4o5gD3ECewMUM2niYV4/ihYpMrHHzJN3pK8U4GGntUYPPPR+XfPet/7Yrw6l1kx+yP2eOxRP5hOa10Chc6kTjXFrAKTd4GfEgH18Ln2KAV3zU1VVrgXBZG0iekXy4QddVpKYq2Be67DBDrc7spkBGnbB8PgTyPd+Dg==
Received: from AM8P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::9)
 by GVXPR07MB9702.eurprd07.prod.outlook.com (2603:10a6:150:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:21:39 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::d7) by AM8P189CA0004.outlook.office365.com
 (2603:10a6:20b:218::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001B2.mail.protection.outlook.com (10.167.16.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0MY023685;
	Fri, 18 Oct 2024 02:21:37 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 04/14] tcp: extend TCP flags to allow AE bit/ACE field
Date: Fri, 18 Oct 2024 04:20:41 +0200
Message-Id: <20241018022051.39966-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B2:EE_|GVXPR07MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: d3aaaaaa-52c9-4c0a-5549-08dcef1b98ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUxvUGNjaEVZKzI0MnJ6dHA5Z3htbUpHOGJ6YldwWmppM3NTMFRhNDgveWY1?=
 =?utf-8?B?MElNeHZtSWc0b1JzcVRYWng4cllUcHBlQ3MvRDJiZThxWHBiaEtGVG96WW8y?=
 =?utf-8?B?VlVkdXQxYjZCMGsxV3NyUlYySW9odm9vMU5zUlc2M2lsOFVvb1dQMXc5UjdS?=
 =?utf-8?B?ajRXSWtBcTNGTEdpWnVSQjUzUllaNEFXTUd3dkpiRVpUMW1kWW5zWlJUSUh5?=
 =?utf-8?B?SS9adzRZRkRXU2VuWFQwMjNSNTllczV1dC9RU0hadTJ6OGFZbFByeTc4RytO?=
 =?utf-8?B?NnFOMUozdzVGVHNIMWppWmV2cTZGdWJoU1BmL05CT05mSlZOclJwK2VXbGMz?=
 =?utf-8?B?WHA0MWE1MVppV2pUbWdYMGxUQVE3UWQvV0NxdHNBWjF4TUxVSWoxMjFRZnox?=
 =?utf-8?B?azZqL3hJRi85czRXc3lxUDcyQUdRVDZMckZLQVVjSEZrWndXUmxPODZBeSti?=
 =?utf-8?B?ZFRqbmJ4dnlTSUJodVczWkZWc0FTcVBORm1VR3ZHbE1Za3N5NFoyUUVFSUNl?=
 =?utf-8?B?TjlFTnRqY2tBN1B5cDdENGd3Mm1xVlQvTmVKVC9OUHY3S3dsM3VBTnBFc1lj?=
 =?utf-8?B?RVJwNk1BSGNadjIvZkQrVkJ1aXViZWkzWWtSR1pmaUFiZDllaXhFRDJIWDV2?=
 =?utf-8?B?V2wyMnR2c0tCZVVxSVQwRFYxR1o5c1Z3MkQyMVB3c0c0Z3hZWU5nRzJqeGJC?=
 =?utf-8?B?NTAyZW9kMlJpTk11Rkk3S0h2WDAyWXNjckcwYUZWL2hpNmFmZWJsYVlWQXlW?=
 =?utf-8?B?MkxMcDB4bTlmWGtLTXZodW5tUjM4dmNWYnJYUlJuYlRwRE13L0lhdjdiNEc2?=
 =?utf-8?B?WHdGV3hhbk83L1Z0aHlVWnpvQ1Q3VVlPMk5Hd3lTSFlFT3IwaFJSdER6UExl?=
 =?utf-8?B?SUZhb0JYR1hMNENIQ1lKWGNyRnc3d2pOZmpjcG1XOUdPZU1tQjJmaEZPdEFm?=
 =?utf-8?B?S2xqU2R5bUFCRGJEaGNKRGZuQXUrSFAyQzVDeDlCaWtrNFBPcVdleGx1T2E1?=
 =?utf-8?B?ZnFTbTA4YmMxcFZENHhwS3BlczcvUEozM21jYkNqWm5kdTJBb3lpM1U3SkNm?=
 =?utf-8?B?Ym1xak5Xb3RaWWJxSGpscTRuc3I5Q1Nhbi9JamRrQXBnSU1vTllKeE95b2hI?=
 =?utf-8?B?a0pkc1Y1aGxzSGVJNU8xRUdLK3BCelJQTnJja09qcXE0T24xQUltZXgrWGVH?=
 =?utf-8?B?ek5zL0FDaWZDeDhIdTFVc0M1WGNrcXZ1N2JJeVhpVDdwTjY3Q2JBRXlwcVI3?=
 =?utf-8?B?enVsVEIzL1k0K0NMSDVqeXFYQmlqWWZzalNEY2pnYXd4ZUJJa2Z1SFRsUlVB?=
 =?utf-8?B?QkZST0cybk9BMG5SaWE5Sm9ORGh4M0V2aktTWTNId0htTXZUaWVnWVJVb254?=
 =?utf-8?B?ekVHNjArbzVySnhuNXB3YWIyL3kyQU1XeVFqTDRTM1lrYlh4VUJsYU9LTGY3?=
 =?utf-8?B?aG5Ha2s2eHcwVmdkOUtvbUJMa1ZZK1RXdlNmOXpja3JOMGo4ejQ0NkF2clg1?=
 =?utf-8?B?cVJaTWxFL0dVSWRLaVRrSVBmZ0duYURlbHlKNE9WZTZBQTNDUFowSDY0czln?=
 =?utf-8?B?K0lFSE5lb05xTVRpMkc3dkpaa0QzZ2tKS2JnT1RDMFovUzJuSkRMMFB0c1pJ?=
 =?utf-8?B?anh4d2MzWE1OYVpyVUV0bEtObStZZGppemozVjl2Tmg3NElnNlhuVlJuV0Ri?=
 =?utf-8?B?dkFMd0NOam54R2FsMUZmOU1ic1hLVjNxVGV3R0g2VE1lOExCN0FPRFE3N3dB?=
 =?utf-8?B?ZDF2Qmx3SkdNamJid1NDZ2g3UjFSOVRFMG9BQWNiMTR6WkFSUm5aaXNXRlY4?=
 =?utf-8?B?dllHVDBXaXVZK1UyblZBTnQxVlRVWm5Uc3FaeU5QeHE3QVhxTUdKZzZ5Uk1L?=
 =?utf-8?B?NUlCK2t2cU94MitIa093eDM1VnhsNGF2bE1wMEYwS3BuV1RHcTFDVUFqMTY4?=
 =?utf-8?Q?RLeuUliEkgs=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:38.5307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aaaaaa-52c9-4c0a-5549-08dcef1b98ef
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9702

From: Ilpo Järvinen <ij@kernel.org>

With AccECN, there's one additional TCP flag to be used (AE)
and ACE field that overloads the definition of AE, CWR, and
ECE flags. As tcp_flags was previously only 1 byte, the
byte-order stuff needs to be added to it's handling.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h             | 7 ++++++-
 include/uapi/linux/tcp.h      | 9 ++++++---
 net/ipv4/tcp_ipv4.c           | 3 ++-
 net/ipv4/tcp_output.c         | 8 ++++----
 net/ipv6/tcp_ipv6.c           | 3 ++-
 net/netfilter/nf_log_syslog.c | 8 +++++---
 6 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bc34b450929c..549fec6681d0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -920,7 +920,12 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_URG	BIT(5)
 #define TCPHDR_ECE	BIT(6)
 #define TCPHDR_CWR	BIT(7)
+#define TCPHDR_AE	BIT(8)
+#define TCPHDR_FLAGS_MASK (TCPHDR_FIN | TCPHDR_SYN | TCPHDR_RST | \
+			   TCPHDR_PSH | TCPHDR_ACK | TCPHDR_URG | \
+			   TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 
+#define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
 /* State flags for sacked in struct tcp_skb_cb */
@@ -955,7 +960,7 @@ struct tcp_skb_cb {
 			u16	tcp_gso_size;
 		};
 	};
-	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
+	__u16		tcp_flags;	/* TCP header flags. (tcp[12-13])	*/
 
 	__u8		sacked;		/* State flags for SACK.	*/
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dbf896f3146c..3fe08d7dddaf 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -28,7 +28,8 @@ struct tcphdr {
 	__be32	seq;
 	__be32	ack_seq;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u16	res1:4,
+	__u16	ae:1,
+		res1:3,
 		doff:4,
 		fin:1,
 		syn:1,
@@ -40,7 +41,8 @@ struct tcphdr {
 		cwr:1;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	__u16	doff:4,
-		res1:4,
+		res1:3,
+		ae:1,
 		cwr:1,
 		ece:1,
 		urg:1,
@@ -70,6 +72,7 @@ union tcp_word_hdr {
 #define tcp_flag_word(tp) (((union tcp_word_hdr *)(tp))->words[3])
 
 enum {
+	TCP_FLAG_AE  = __constant_cpu_to_be32(0x01000000),
 	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
 	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
 	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
@@ -78,7 +81,7 @@ enum {
 	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
 	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
 	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
-	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
+	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0E000000),
 	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
 };
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9d3dd101ea71..9fe314a59240 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2162,7 +2162,8 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff * 4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = ntohs(*(__be16 *)&tcp_flag_word(th)) &
+				     TCPHDR_FLAGS_MASK;
 	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
 	TCP_SKB_CB(skb)->sacked	 = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 054244ce5117..45cb67c635be 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -400,7 +400,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 /* Constructs common control bits of non-data skb. If SYN/FIN is present,
  * auto increment end seqno.
  */
-static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags)
+static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u16 flags)
 {
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
@@ -1382,7 +1382,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	th->seq			= htonl(tcb->seq);
 	th->ack_seq		= htonl(rcv_nxt);
 	*(((__be16 *)th) + 6)	= htons(((tcp_header_size >> 2) << 12) |
-					tcb->tcp_flags);
+					(tcb->tcp_flags & TCPHDR_FLAGS_MASK));
 
 	th->check		= 0;
 	th->urg_ptr		= 0;
@@ -1604,7 +1604,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 	int old_factor;
 	long limit;
 	int nlen;
-	u8 flags;
+	u16 flags;
 
 	if (WARN_ON(len > skb->len))
 		return -EINVAL;
@@ -2159,7 +2159,7 @@ static int tso_fragment(struct sock *sk, struct sk_buff *skb, unsigned int len,
 {
 	int nlen = skb->len - len;
 	struct sk_buff *buff;
-	u8 flags;
+	u16 flags;
 
 	/* All of a TSO frame must be composed of paged data.  */
 	DEBUG_NET_WARN_ON_ONCE(skb->len != skb->data_len);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 597920061a3a..252d3dac3a09 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1737,7 +1737,8 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff*4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = ntohs(*(__be16 *)&tcp_flag_word(th)) &
+				     TCPHDR_FLAGS_MASK;
 	TCP_SKB_CB(skb)->ip_dsfield = ipv6_get_dsfield(hdr);
 	TCP_SKB_CB(skb)->sacked = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 58402226045e..86d5fc5d28e3 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -216,7 +216,9 @@ nf_log_dump_tcp_header(struct nf_log_buf *m,
 	/* Max length: 9 "RES=0x3C " */
 	nf_log_buf_add(m, "RES=0x%02x ", (u_int8_t)(ntohl(tcp_flag_word(th) &
 					    TCP_RESERVED_BITS) >> 22));
-	/* Max length: 32 "CWR ECE URG ACK PSH RST SYN FIN " */
+	/* Max length: 35 "AE CWR ECE URG ACK PSH RST SYN FIN " */
+	if (th->ae)
+		nf_log_buf_add(m, "AE ");
 	if (th->cwr)
 		nf_log_buf_add(m, "CWR ");
 	if (th->ece)
@@ -516,7 +518,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Proto    Max log string length */
 	/* IP:	    40+46+6+11+127 = 230 */
-	/* TCP:     10+max(25,20+30+13+9+32+11+127) = 252 */
+	/* TCP:     10+max(25,20+30+13+9+35+11+127) = 255 */
 	/* UDP:     10+max(25,20) = 35 */
 	/* UDPLITE: 14+max(25,20) = 39 */
 	/* ICMP:    11+max(25, 18+25+max(19,14,24+3+n+10,3+n+10)) = 91+n */
@@ -526,7 +528,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* (ICMP allows recursion one level deep) */
 	/* maxlen =  IP + ICMP +  IP + max(TCP,UDP,ICMP,unknown) */
-	/* maxlen = 230+   91  + 230 + 252 = 803 */
+	/* maxlen = 230+   91  + 230 + 255 = 806 */
 }
 
 static noinline_for_stack void
-- 
2.34.1


