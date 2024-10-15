Return-Path: <netdev+bounces-135556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA099E3F2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B432280E45
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1701EF0AB;
	Tue, 15 Oct 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aOcHGAHi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02661EC01C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988232; cv=fail; b=mA2nvHThDGUbIrZcil5/wUxYobjpMLUC0tLe87oS9gG2I9Of2chk/v9RJ+W0I1IiLlBfu9Ag9WsQgW0fXBFbDtN7yx82jkQ0qmMq5GZwpzGfWtxHu3usr1uaBocx4e1vBayEJIQA7LibjEWspgCCZ0iJgXjrH8SjJu3F9Tm0i4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988232; c=relaxed/simple;
	bh=GaRiTRj4vGy7a/ovH+seDj/pbJNwdlHYL9WhlqJpLtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4ENhAGS4JzT/+9GKeW+NdyWIn7ETHkY4IyNND3vi/ttRSydLRmnnGa/gtbljObDheuHC0wvq8oNEsh1DEmXL09VtsrVG8Jqv1WEJU4zJbGeXL+aw4XrhCAktU13R+aWgySnfJfmjVUgaBEHFKtYoRJwgBpj80KuWD/0eJ6M6zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aOcHGAHi; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ6/4P7Z+NO4JDTlMdvfFWqco7zbj6TMKBtdRLVME0JBp3FzuMwEhH5dbEqhJ5I7u5gDIU9Q/8mg1x7IZZ7nfgHuRqrmoB1MruzC3cGbladKFvCEnzbgyxjgG5SuNaJbpxzRuPBsVtpYhRF5fDIlzWQXXVfhH/01vEeRiPS9PVYCk0E3bzO+5L5OTEI285Q48uEFWpQ1vvHvKMlfwNnExWy5+a+7Vrqdpym6CNzGve1Se3o9UCdZdWkB9yeEBxXbCcHJzF8tcg97LWBeJOKV2+11g3uKwN0KHaV2YEHVpptFjefj8Bd2BHN/2M7dMoR2Ek5gMPDuujjrY0/eeZZBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tA8+OFEEaeCTtJ10aJN8mcAISEKN2T4zBYLL84QNoc=;
 b=E5HYRjrTI8J7D0TE+jFnudNqohlqGQfLEoutax9R81uQahtohotWi7ZAg+UqjtCLh671QHw0oNhqs8EO9FTrbWp9xvUOQWW+/YGDnEXaIexh8Wuqq1tVkecNjRCClQBd8rzaKcIDFfoABe3AES5WvhvpIc0Xb70pIMej4zySuqT5+xJ8RVWF4dqDDuFi7rBRMN1S03jPUs/BoZ5NsHiB8hWn9zBTBdd4t5iW5sVm38sbSPT3Hj3qbAfIE2WJpQYCOaxqkXF+5aBUdXz83Yk+DA+geYuKBK8vh5MJ07kJLe1ePZGw5hKNIQMUOv5x2a4r62uOt5B9RnjsATvcpyz+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tA8+OFEEaeCTtJ10aJN8mcAISEKN2T4zBYLL84QNoc=;
 b=aOcHGAHiUrPkPhS1H/gJt3IfLSbHPxNEs+FLkrEF7JwegYv5PWo5yBq3/lXmC16+yZcvAqFsaxyE18F2RExJY3mxSxqml7NMgYtewlfJFqutw7noD5rMdGJX7olWjNJPtH6sgJFXhWCi8GJy2CaH6HQnfdk4MrYr7wJe00AvJPM+/SklRA2z+O8OvlTne2sLCJKG8G9EIIefNfTepAoLRQkRezkJDReBqoLRKo84QkMJi59iBUUIhQVx+pj03vyzd6iwBGYSBR4gnnDBxIxOru1AqlbiuaIGRpsjBt0MkYx9/kJe49wotC+y+CGNMX5oTGKvfQci2UFKq2HqB7+AGw==
Received: from DUZP191CA0048.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::8) by
 AS2PR07MB9003.eurprd07.prod.outlook.com (2603:10a6:20b:556::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:27 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::b6) by DUZP191CA0048.outlook.office365.com
 (2603:10a6:10:4f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnR029578;
	Tue, 15 Oct 2024 10:30:25 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 23/44] tcp: accecn: AccECN option send control
Date: Tue, 15 Oct 2024 12:29:19 +0200
Message-Id: <20241015102940.26157-24-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|AS2PR07MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: 98faa436-6b86-49e0-a879-08dced04622d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnRJV2kwKy9lSXNpbWhtYUtlZzRmY1U3K3pGS3BxUFlib3U3Nll2VDZEOWFo?=
 =?utf-8?B?TjRNVzZFL0I5Z3FiLyt5amRpNms2Q2Q1Y3ZCMlVFTjYvTnl2OWgyYjRjcksz?=
 =?utf-8?B?MVkxVWVLVnYwSHRpSXZTL0RTUmR3SVlHMkIyOS9ZcEpFZmQzUnVqTGdYdUFD?=
 =?utf-8?B?UHRnVlNxVmUwT0JVT0hsa0c5dXhQM0grZlYrNy9xM1YvK3llRm1FRVJSTGQy?=
 =?utf-8?B?N0YwSjhZSnM0QmZUNFpnUmM5L0JrTGZaV00wSUduZVFDV2d2TVdiMHhVQjZn?=
 =?utf-8?B?ZXdXcWI2UHVPcDFueGtTWkVCeGs0bWJIZW9GYkMySGN6YU8xVDI4R1pBZDF2?=
 =?utf-8?B?Vkc0VEErSDlNMlZWc0xjdk9zNE10bWpKbkFjZHBibmdUWklzbDUyUWZuemZF?=
 =?utf-8?B?OUpla1orb0lTM3U0dVRoeXJHbU9HVGN0ZnlTM1FPTlJVYnZiQ3RXZEdBb0dB?=
 =?utf-8?B?NWpBY3BPU2VzRVRvNW9velA4YUFtWkdBY2k4UXdmendLd2Q4RjlQZ3JiNmdx?=
 =?utf-8?B?N2pXbHBlS0Q5WWJWZkQ1azBEZ2dpbTlyRE8zajVieHRaYlZremZXOEtGNkY5?=
 =?utf-8?B?N29UamJ0WEZzME05dUlrOXk1VDVIeHAwWjNNSmhGODBFSUVSNmhZN2phejlF?=
 =?utf-8?B?MERldjJZdTFFREg1ZDVhR28ybGtBNy9zR0N6MUJ2YWVWTHBLWHJtYWIwYVFy?=
 =?utf-8?B?WStRdC9XQnNvV2xBaFV2Sm1PZHlkbmNmWGdTSjZvUjRrQWY0OTc4MDhmYUtx?=
 =?utf-8?B?cXhqTVF3K2drK3Y5SWRrRlB6VktqeDBuL2JDTTc1UEMvKzY0aVlDc2V4ZzNt?=
 =?utf-8?B?UDVJS0xiM3FZNTJMckxrKy9HMThNRUF0MVB0T3dUQ1IyMlF5MTJLYXZWK0VG?=
 =?utf-8?B?aDV2Y09tbHRoZkNMUDZOR0Q0WHZiRlAwbmY2UmFoMDM3Q3FFL2lvcDhOaUNZ?=
 =?utf-8?B?ZHJLZFJrVWYrUHNjVWxadDFmTWlBb0ZlZVNpZ3NwMnZNbG9IRVFOaDJVZDFi?=
 =?utf-8?B?aStabUtTbjNFYk8yR1F0a29zdzF2TUNBSjVJUERSMk5FVXowNzB0NHpMdGhy?=
 =?utf-8?B?d3hIVmhwcTFZZkNuYlB2TzJIUmZmK0ZiNy9sdVBLZ0dKSkNYS0kyREZDMlhw?=
 =?utf-8?B?eG4wMGhWNFBzWXY4V2ZXMEF1Tnltdk45bWFkdjZ2TXZyQXhHOURabGgvNTRk?=
 =?utf-8?B?K3FLcVBzTnNTbGQzcWhJWCtWM2ZCVHQxYzBFdXVmcGN6YWEvR1pOOGcvU3Vy?=
 =?utf-8?B?M3A0cFUxUDF2bG1FY0VwcWw0V1JlcXc4OUxXWmxXbllyY3NYSHBkd0VWM1p0?=
 =?utf-8?B?eDlKdklPL2hjWlVZeXJtL2VEalZBTVBFNEd1ZmY1WGJzdFh6VGlsbzBabUFT?=
 =?utf-8?B?OUlPaDZqd2RrNGp1VGQ5Q2N1NHBoT3lzOHp0dWN0c3ZrVEJMdjAyNnpObk8x?=
 =?utf-8?B?eTJGY21KZTA5ZGxIYlZHS1RFeC9kOWlpODZObGN3aThaSXN0TFdCcjA3VFRk?=
 =?utf-8?B?dWtRMEpUTDlDL2EwdjhDQ2cwb04rT1lLVmE0RnFqajk1UTJjN1kvSEwrMUhI?=
 =?utf-8?B?dG9UUHdVUi9nYS9maTBBSUc3SlBUUjdCemRLVkhndnkrbmgvWXRBNzhJUlJF?=
 =?utf-8?B?VWRYL2Z1eXdhMkVDNU41OUdhSGQyUDlFRHVOTk90S09JRk5EY2Uzdk1BV0pB?=
 =?utf-8?B?bkN3allPdWROTEtDZHZpWWErdis1N05jWnNhTWRVNm0ySHNEVWF5NUVPZTN4?=
 =?utf-8?B?VjRTcUJ5bFQxNFJ2Z0hPa2NuYzVuL1lDeHJwek9tQk5DckxTSGZ4Z0h2YU1V?=
 =?utf-8?B?emRaSFhqdExaT0gycDArN0l4OXV5UkVMM2xHbExkVjlGOTRjUEpHSmdwL3VT?=
 =?utf-8?Q?Z0cQOtfuBREBV?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:26.0860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98faa436-6b86-49e0-a879-08dced04622d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9003

From: Ilpo Järvinen <ij@kernel.org>

Instead of sending the option in every ACK, limit sending to
those ACKs where the option is necessary:
- Handshake
- "Change-triggered ACK" + the ACK following it. The
  2nd ACK is necessary to unambiguously indicate which
  of the ECN byte counters in increasing. The first
  ACK has two counters increasing due to the ecnfield
  edge.
- ACKs with CE to allow CEP delta validations to take
  advantage of the option.
- Force option to be sent every at least once per 2^22
  bytes. The check is done using the bit edges of the
  byte counters (avoids need for extra variables).
- AccECN option beacon to send a few times per RTT even if
  nothing in the ECN state requires that. The default is 3
  times per RTT, and its period can be set via
  sysctl_tcp_ecn_option_beacon.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h        |  3 +++
 include/net/netns/ipv4.h   |  1 +
 include/net/tcp.h          |  1 +
 net/ipv4/sysctl_net_ipv4.c |  9 +++++++++
 net/ipv4/tcp.c             |  5 ++++-
 net/ipv4/tcp_input.c       | 31 ++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c        |  1 +
 net/ipv4/tcp_minisocks.c   |  2 ++
 net/ipv4/tcp_output.c      | 36 +++++++++++++++++++++++++++++++-----
 9 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1d53b184e05e..e4aa10fdc032 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -305,7 +305,10 @@ struct tcp_sock {
 	u8	received_ce_pending:4, /* Not yet transmitted cnt of received_ce */
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		prev_ecnfield:2,/* ECN bits from the previous segment */
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		estimate_ecnfield:2;/* ECN field for AccECN delivered estimates */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8a186e99917b..87880307b68c 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -136,6 +136,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index adc520b6eeca..b3cbf9a11dbc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1042,6 +1042,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->estimate_ecnfield = 0;
 }
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 0d7c0fea150b..987e74a41b09 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -737,6 +737,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_ecn_option_beacon",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_FOUR,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ea1fbafd4fd9..e59fd2cabe03 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3340,6 +3340,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5040,6 +5042,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5047,7 +5050,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6daeced890f7..14b9a5e63687 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -459,6 +459,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (tcp_accecn_validate_syn_feedback(sk, ace, tp->syn_ect_snt) &&
 		    INET_ECN_is_ce(ip_dsfield)) {
 			tp->received_ce++;
@@ -477,6 +478,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6247,6 +6249,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6259,8 +6262,32 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
 		if (payload_len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen, minlen);
+
+			/* Demand AccECN option at least every 2^22 bytes to
+			 * avoid overflowing the ECN byte counters.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    ~((1 << 22) - 1))
+				tp->accecn_opt_demand = max_t(u8, 1,
+							      tp->accecn_opt_demand);
+		}
+	}
+
+	ecn_edge = tp->prev_ecnfield != ecnfield;
+	if (ecn_edge || is_ce) {
+		tp->prev_ecnfield = ecnfield;
+		/* Demand Accurate ECN change-triggered ACKs. Two ACK are
+		 * demanded to indicate unambiguously the ecnfield value
+		 * in the latter ACK.
+		 */
+		if (tcp_ecn_mode_accecn(tp)) {
+			if (ecn_edge)
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+			tp->accecn_opt_demand = 2;
 		}
 	}
 }
@@ -6381,8 +6408,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
 			send_accecn_reflector = true;
+			tp->accecn_opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e632327f19f8..21946ac00282 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3448,6 +3448,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = 2;
 	net->ipv4.sysctl_tcp_ecn_option = 2;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = 3;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ad9ac8e2bfd4..75baa72849fe 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -490,6 +490,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bddd0b309443..22f6cfba5b27 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -792,8 +792,13 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
 				       TCPOPT_NOP);
 		}
-		if (tp)
+
+		if (tp) {
 			tp->accecn_minlen = 0;
+			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			if (tp->accecn_opt_demand)
+				tp->accecn_opt_demand--;
+		}
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -970,6 +975,17 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 	return size;
 }
 
+static bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon >= (tp->srtt_us >> 3);
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -1213,10 +1229,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
-		opts->ecn_bytes = tp->received_ecn_bytes;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
-					       MAX_TCP_OPTION_SPACE - size,
-					       opts->num_sack_blocks > 0 ? 2 : 0);
+		if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= 2 ||
+		    tp->accecn_opt_demand ||
+		    tcp_accecn_option_beacon_check(sk)) {
+			opts->ecn_bytes = tp->received_ecn_bytes;
+			size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+						       MAX_TCP_OPTION_SPACE - size,
+						       opts->num_sack_blocks > 0 ?
+						       2 : 0);
+		}
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
@@ -2933,6 +2954,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);
+
+	/* AccECN option beacon depends on mstamp, it may change mss */
+	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
+		mss_now = tcp_current_mss(sk);
+
 	if (!push_one) {
 		/* Do MTU probing. */
 		result = tcp_mtu_probe(sk);
-- 
2.34.1


