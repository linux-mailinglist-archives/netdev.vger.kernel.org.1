Return-Path: <netdev+bounces-135563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1099E3FA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239D5B20979
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648C1F12F7;
	Tue, 15 Oct 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PNiTohpm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361F1EF0B2
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988234; cv=fail; b=ND7kwNVqYOgsu81Erk49pWtx95tbkoXVBy3FJEqyMW9FcbeU9tT8bIi52EXI1QBUaGG+CDgN9OyY3QWSJSxzs2goW/9mm4py7gLsi10o3RLkIQYtk4YlJkHNA5OmpH2fWx5O0jOD4EvafjEPmMgXGAj1CrYZGjDiYmYEAsvfBLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988234; c=relaxed/simple;
	bh=l3W49FJ7X3P04GpewYlcqTWRoP8Xre8nK2J7Qt/y5fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwVA9gRFzkFVjadOfwJxwvg3fp1ScSCcqIpYiemUH7fd/HBW7/W9hB1QuIKvSH82nxjMXvfKG3rPXLB512fd8vQ0B5IvP+GynCHLY2D1jbS8rVuA1Usra0vHbpFfYuErYmU4kQJHRwkv0xOA3W8iVexCGWJDRlGop+CBTRQmy18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PNiTohpm; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+847yXSFzA2YGsMZfppSULUYv1w4MvDq5U1aY1m/HlilYeT1KRgrI3lw6v1bkgSteAvhjy2GRhXcETliwjb7WUkR0ciuNrfAQa319EIB/E5NueXvcgWzBoELcNIgk8jo2GbKGBOvokKZOktOS4bTO5vY9cyI8kx50uTABdF+MX7ra3Yl0XYxfSvhfmlIc58zmwODXZ2wATXxEdDujqTblHwQlsEtbyZMif3W20CbvOV8oDMoZufKe2Y104QNYS/sy20SAuLT23Aj5QMxyiqNX2wx2PXGZze7iCSWyXStYmULIpAEBJNHaklVdGeWQ6gDQ/tsmxhiAAL8wJEQhPIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/jO4hr0m/M8yM9w8vziwXR2crAOIvRN4ZIq5v7IPvM=;
 b=d7UREbmhnkO+1TFPVPaXfPqgMlTWySegYsf/GDX/BrrOEKnTiOEdRuqTrQLcyAaZn6oF+pJspvW7g50/IqaVfdGp2HwJm0vXTG0zjrHWkad5AfSiCPkRaZxLSVDfruf+oSqYWeO66ppyFtvCV0MuryYGqfMr2R4LS9lriEEkzld5f36gwqVZ92WI9FISbOzqLCdKWJ12fjlCbrUnH3/MytYU9W12WUIeKnUI13GYRXbHwaqqvmjJXvu1Y4AQERzjWeNhZ6lg966AmVcTNNulecHLZTxaM2I54A890VDzJQmF3/5mcUQpd9qgmbPkOXaASIN0zP5lAIXtDPZXPXU0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/jO4hr0m/M8yM9w8vziwXR2crAOIvRN4ZIq5v7IPvM=;
 b=PNiTohpmJMqrlPC+WBRF6vdcBDTrx7Q9+Rz8Vnd5vir09nRiv2EUs5keY9N2+v14U2DdcXlhQPcENlVv+sMY9W+faVV4negZXcdx45iGhoQHo06IIjarieuXn6Pbn3A64vji6vGiHI6P+AH3R9GYdhSIvPqiwgBW+LNySW7i1ffbt5ZnBWaSG241wcMUeTGHoFglahTjtrcd5rdRc6XXUyJzATstVjdwLDWKwuecrnlHnlmRZQh17wc4eZ/YctbBrMDgEs1KoD5w3DeBAia/oMmWW02nOEiv5ZBYRDjUmt9HqmbYOASUZ1WnnLluVp1Kncl6XPUbT17AQt+MpL2zag==
Received: from DB9PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:10:1db::7)
 by AM9PR07MB7090.eurprd07.prod.outlook.com (2603:10a6:20b:2d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:28 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::42) by DB9PR06CA0002.outlook.office365.com
 (2603:10a6:10:1db::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnT029578;
	Tue, 15 Oct 2024 10:30:26 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 25/44] tcp: accecn: AccECN option ceb/cep heuristic
Date: Tue, 15 Oct 2024 12:29:21 +0200
Message-Id: <20241015102940.26157-26-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|AM9PR07MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: d4031417-2146-40ef-30b4-08dced0462c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHpUODg5ODdvcFU2VHo0cXlmajVtNUVCZ2JERDJ2WGtmME5ET0trWXo0b09l?=
 =?utf-8?B?THoxRWJETTVRc0R6VndvcmRyUW5zUEpBZGZ2Z3dVNWRFQ3l6OVpabGs4VGNR?=
 =?utf-8?B?YlVvcUduamYrdzFXcDkxdkczQjdRWFpnSlpBbGJlR3FvQXhHZXBVdlFwWXht?=
 =?utf-8?B?dzYzSFlSYXFJTXR6QnlDcjFXaDdQVi9CVzY1dVB3dUxBVWREYno3MEd0WWxB?=
 =?utf-8?B?MkpIRE1PdTlxeUxSUzNiT3ZTdVpKVGtzd3FMb0VXLzZpZ0I1d09UUUhLNkZa?=
 =?utf-8?B?aHBpMk9uTFF3S2tmQVVJdWJ1aTh3QlJybmFQKzVVSXNDcjZXT1dwKzBnRnRE?=
 =?utf-8?B?cGRoYThzYm1LQ21XL0drcmRLa0I1am0vNy96ZVR0K28vazFhWElETnJNZ0Nx?=
 =?utf-8?B?SnRLa0ZreTl3OThJWllHVHZlbE03ZWg1MEh5TGJVM002MmtkWkdhWDlNeG51?=
 =?utf-8?B?dzdqWkgvWHZyRDZrdWx6NkI5b0w1WndFOEFBK1ZVaC9vYU9RUVN3cGR0WGhO?=
 =?utf-8?B?c3pWUVVZYUNEdGZBLzlMREFubU9rZC9abmhCcEFkTFVML3JLeElYL3JIZTlE?=
 =?utf-8?B?TVBMUDNoNndGUU9RY2VscXVNWE5WNUdwdnVuRllwRG05VnZEYnFaMTRybzNk?=
 =?utf-8?B?WjByQmhQRlBOT05KbEZWTGRwYnlrYnVSMUUxakxUdFhsTmpUekk0R0VtSklQ?=
 =?utf-8?B?Qm9zajl6bkE5OWNyaDRveDZBajFRa1ZYSWVRYTFiTWh4YkJDRmZCL0ZYckY2?=
 =?utf-8?B?dUNNN09xMDNVQW9aVXdhdWpIVHdYd3dYcVh2eHhPTk5HQjBWMVNiWXdzWWFm?=
 =?utf-8?B?NGZMQmxrSkxLcEx5T0JicVRkZTIwRlJZLy85L1BnY05jR2pZMURTYml2S001?=
 =?utf-8?B?V2NvcXp0N3dZUk5rN0FYN3JHRC9QMlAwV09wa1hyMVd0aU9MODF5V2dMdTJE?=
 =?utf-8?B?cW1lWi9CdkdkdGxlK1dmblFtaldnMzNib3dMT2txbHFTZ3d4ZU5OcUdSWlBT?=
 =?utf-8?B?bk1qYjcxcE93Z2J2c1V2UUIxRmMyZlpTNVFDMzNQb0N2bjd5UlhLNU01U1JU?=
 =?utf-8?B?Q2VWUXgwRHNEUjRLSzJiOVpFS1ZReWVNa0RxYWFUWUdZdXVtRERra1J0Q0F4?=
 =?utf-8?B?RFBEM0k0ZWtjZHJLUFhuMllCd0l0QjBvZGdseCtpV2JlRzFwZDg4ZVNlMmd4?=
 =?utf-8?B?bWZJUUNkWnJaTTIxcFAwVFNlc0RhejNYRTU2M2dHVTBITHV3Z0V6V3A2QStH?=
 =?utf-8?B?YjZFdTJ0a1FYUHpKODNlVGszZEw2NnZ4RXBwNGxoQVltTmZ1Z2RwOENxTkQv?=
 =?utf-8?B?MTE3NUV1NXN1QkFPRnZMTGJ0eHM3b0Y3VGFpWllkYVovSmI1TkdmeityR0lv?=
 =?utf-8?B?YitJd2pSNFdpWnBhVzREU2ZOOCtOaWduQmNQUnVhekgzeXh1clNqb2NlL2Nr?=
 =?utf-8?B?V05JVzRYTVN5RlQvQVFYNTg2VXZ4YVp3ZG90UjVMbVBMMXMrVkFuQWNkMGY3?=
 =?utf-8?B?WDZja2lSRmVNclRJcm9Vam9SUklvaVlRcVR0bEhXY2FOWDlZZ3lNblhVZnFN?=
 =?utf-8?B?cmhQL2NXWUxJcXoxVi9nSlA2UFZKQWNQQXRFWjZYTWlqQ1VsZ2s1NGY0MCtx?=
 =?utf-8?B?UVg1TDZJaEhoMU14aUNRVGg4Y29YMzhxaXZVVElFME00YkoxRWYzbjMzd3Ro?=
 =?utf-8?B?YiswRzVmWEhkanNrMUFhZUtiM2ZibFFFNzVaVCs3L0VZWVQxNWUwSktmUjRT?=
 =?utf-8?B?elNsVFM5VFlCSzdJWUk3dUo0REJhT1lsaHdoNk5ZT3J1NllLc3FDRmlaQjhD?=
 =?utf-8?B?aXRMRnVZbXh5MVZhVmExUjBINUczdTVFbWFQazdjay9mWkJibjMrdEpORThl?=
 =?utf-8?Q?gERRF7e5eQs8J?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:27.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4031417-2146-40ef-30b4-08dced0462c6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7090

From: Ilpo Järvinen <ij@kernel.org>

The heuristic algorithm from draft-11 Appendix A.2.2 to
mitigate against false ACE field overflows.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 18c6f0ada141..a2f6b8781f11 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -242,6 +242,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND       BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a8669c407978..79e901eb5fcf 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -669,15 +669,17 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes, int flag)
 {
+	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 delta, safe_delta;
+	u32 delta, safe_delta, d_ceb;
+	bool opt_deltas_valid;
 	u32 corrected_ace;
 
 	/* Reordered ACK? (...or uncertain due to lack of data to send and ts) */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
-	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+	opt_deltas_valid = tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
 
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
@@ -699,6 +701,16 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 
 	safe_delta = delivered_pkts - ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+		if (d_ceb > delta * tp->mss_cache)
+			return safe_delta;
+		if (d_ceb < safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
+			return delta;
+	}
+
 	return safe_delta;
 }
 
-- 
2.34.1


