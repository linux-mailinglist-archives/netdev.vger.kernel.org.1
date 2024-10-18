Return-Path: <netdev+bounces-136826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113649A32AD
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E451C238BE
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E217B4FE;
	Fri, 18 Oct 2024 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oUGGwCmF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF41741D1
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218145; cv=fail; b=QZYpnepkkbr/E4jHhrhElaqVUn8QWqNHx2u6IoHpvtOp3RvPcOyWtt9h2TqGIe+YRteilZaOpwEf9oXFCmyUw2S8oYRJ4sxdCrXg6o7jBbISZz283skJECWzXFi6pCPIVQ4LxfwQcvBJv1Vv3ImE989FDmAS5Q63HYCkvqzeAxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218145; c=relaxed/simple;
	bh=aigVrtFmdlODcoDzUAkTu2EEDAXuRELqVFW7iXHciWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCdN89ZzA4J8/7NmEDgAxLL++FAQR6n4+s9GzHfALMTFx1vZkxhFXYtM0RcBrelzxQTIDmLDM7Sj9jPBmcwssmLZB2i1Q+ZA/obRO0D5WW4JczceHAubGH9XaXIYW3VpblUy7ynYiHfrs5yIU9KIwGGpFTeIc4s6JVJDV7+HOEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oUGGwCmF; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUJVepJLdo0EUhVvm50JorlEKUZopPsXv98qhZcK+yiuN6Y8EFKlAvjznMQwcZyxc9JEeCRmqcsLvpxX6ErNp9xZIB9VEve6380DGRnlyhThukgcgPKVhu3Se+ETUXTHn/aWwsvSy+Orscl7bDMV3lKm9w/LMFxpHkeJNq0AU3egdBi6ic94TmMmPQaskDJJqEW/H6zLNvem4sTUl5/GbmV/N5yZfWvQzmlS1najHe1AaW1o0YBIjs4oZcx1gfd1S/HhGaHVMYfE7gLcdlj621y0PGgFlp+QzJdfacTkAWeW6tvjUfbQCssSh+rnxdolic+YdlXsCghw61fPDV8arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwpGt7LZQgUGaYqfl+JpsnW8PuU1p5tVsq5y1AfhjMw=;
 b=atmVrDMd4mpFfVYBhvBcABOizO16A9blLA8CN2QEPCZwwi8ArdWlfgAi8XoYMK9Z1PEB/soRE/E6xhsrz/VUgi950M3awR8Lli/FozAwGG8ySqLQP2QrAtMDce0J7Genyfh2viZOVHE4hMK7HxNscwzaCQS/zGy/tt2YTtw5NPhFY2/9yrzGJyoWIJE0/Go132+NgjXNA5Tz3tJ6lvoX8rrJJcIKZXyMsg8AUvah+pSPWioN9EJjblzInRxMDXCpo8K6SI82A6gVVRi3jmn/17qp4olU2z2PoTTEiyyJdLrfrCyHms7TIuzth5YsFzCcW3kYe0OMz3LE/HDR62k/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwpGt7LZQgUGaYqfl+JpsnW8PuU1p5tVsq5y1AfhjMw=;
 b=oUGGwCmFR7vrO9wFsr8OU8MuS7rrF5+R63ypSVYgsFgSDlP9dQvEWY7VJKEs+pRPn1imUvHwFfZMz2PmELoXRK3JmkMezzJXpqWwCNjnH/K5cmxriTyHFuLlxEfE3H4EL3E9CvXEaqemIc45pdTaAArvPBAvQdaBr7+1451YKIOzc7mBuKnAFu9dFS7Er6Fd2UMzLSr+jotHBo75SP8QfMIvShH/N9EB3NbOPzoG9TAS1/wyC4Nmwbmx6bOEkLMWyQxLizwy9ooWMrA8+UtLB2trCIPEltgBPI1hUK8Bcr4DJLn2LI6kArAmacPmIkns4aUZ7NVVE4gVJeHH+BsOmA==
Received: from AS4P190CA0059.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::26)
 by DBBPR07MB7516.eurprd07.prod.outlook.com (2603:10a6:10:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 02:22:15 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::6a) by AS4P190CA0059.outlook.office365.com
 (2603:10a6:20b:656::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 02:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:22:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Mh023685;
	Fri, 18 Oct 2024 02:22:13 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 13/14] tcp: fast path functions later
Date: Fri, 18 Oct 2024 04:20:50 +0200
Message-Id: <20241018022051.39966-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|DBBPR07MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfc496d-4cac-49ea-94a8-08dcef1bae84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJ2N2ZEbmErb1E1c0htNS9kY1ppWER0ZGtodE5tQmwremdseG9KWjRHeStv?=
 =?utf-8?B?RnJiZ1A3VkY2RDFDT3EycG9PL2ZseE1yTjNFWjRqNHdZa2NSR3dpazdtenQ2?=
 =?utf-8?B?TFBpQ0VhTi9NUG0welZrY3VRUkRBK295WitabEdKLzhYQ05pRHVteFBUUHAy?=
 =?utf-8?B?SXZwVkxNT1BSem54UjRpWG9Xc1NBRmtsMVZhQXdkQWJuZExwdWdaQVY0T2Zl?=
 =?utf-8?B?RG1YclRBbGx5WWFZZDdKdjB0WDBXSENtSnNkUjJiMWZ3VzJ0blFLVWZqREpY?=
 =?utf-8?B?czNYWTdYN01KQ3NMNjcyaTFsSGRKem9xR1YrZVZvODN6d3RPazM0eUJmMTh2?=
 =?utf-8?B?OTFQVUFoNjI4a0JNcUxENWE2cGtyVDh2bTlBNHFxS1drTUhNaXlrcGJxeW11?=
 =?utf-8?B?Q2Fuam9rQWhkZXkwa01WaEtSMGxPTFlnT1owcmgxM2dJNklSTEh6ZHFjY2NL?=
 =?utf-8?B?S1ZFM0tqTGRXZi9LL2w1eHhDLzdTcVg2VEIzcDNpQXpDWTI5dndSTCt1Y2Qv?=
 =?utf-8?B?Q0ljakh5aXMwT1YrdDQ4dk82ZUJlcnJpZngyZmhmMUoyUGFYcVE4OExOclR2?=
 =?utf-8?B?N1ZxUUtXU1Z3STBWN2l4Z293bE84dnMzQmNIUVY0blk3TWZWNFo1L1NyaGZE?=
 =?utf-8?B?VEFDdDJ6a1RCanBDYnpQYXpuOW11QWFiNHRzWlo1ajZPaDhIZ1BBSlpIQVVn?=
 =?utf-8?B?UGdrd0dLNjZ6QUZQZjBjWEtld1gvVTNZL1JJQ1B3KzY5Nk1lSGJuNWlhdnpi?=
 =?utf-8?B?ZngvK25yd1JmZURQSVNGZXBDblhEeDUxUmp5aGh5MjJOZmowRlZrTVhzV0Zo?=
 =?utf-8?B?MU85UEhFa2pSNG11bVk2UDhXWWhlL0x3eEVYcHJZSG9xaFBEQlhVbHQrM2hr?=
 =?utf-8?B?S2ZYNkRKcEZzcXBuYzNYRkZxaWU0V1QxSDBRTktPWld2c0dqbGN3ZDF1R2g3?=
 =?utf-8?B?YVZHRTltR1Z4V1VOQjgyajlwZEplYmV2UHVrazBsL3hJbEpNQlloMnh2WmRN?=
 =?utf-8?B?TDVkbUVhWTdYeWM4NFFzL1h1UEZDT2doWjFKR1NoZUdJQTdZZlRsaEluZElO?=
 =?utf-8?B?TUlsbW1maVlMSFk2MUVhb09vcmlrcHh4SkMxQ3NQdGNyRk5rTWcwN0RvRWdK?=
 =?utf-8?B?OSs0NjZ6SytvalNURzJpYXA1bERqZXZ5b21zSGtNUU1IbkVtQklNR2RFQkVa?=
 =?utf-8?B?SjFKU3ZCOHdmTHdQaDNsSk9VMTdoVjhySHE2NU1rY3pRbmtoSUhSdmhjeWxB?=
 =?utf-8?B?a0Y3RlBCUmNZbkVYdWM3K2p2eXpaRlZna25yTitlRXZnVURuSlp2d1IrTTZF?=
 =?utf-8?B?c0FXOUxDUFA2bE5kekdSWFhqRlNQL21kSTJBQlJEb0YrbVpaMWlnZWlid1p5?=
 =?utf-8?B?emxVK2dSM0dWUmtYdTRyVVNwL0hkc1JDUEpIakYyZDliY2J5czV5ejkrUjc1?=
 =?utf-8?B?ejJlZ1FrY2xkZDF4cWN3Q3JoZCs5UUN5OCtIUnp5MjczUmNwWXBpQ1JTK1lM?=
 =?utf-8?B?bEhycTQxRXNzbnN5Um9HYnlvM3pCbU9Cb21WWUVvTGkxWi83Ukk5ZUc3d1NJ?=
 =?utf-8?B?TXpTQ2NXaXlLNVpTc3FUWFZONFJ0U2NLZEZwTjZTYU93UHVqSHl2S082cHZq?=
 =?utf-8?B?WTdWSmFvbFM1dmxQVVlRdFdPTkljdHJyTnk2MFJvUVhXeXEzeTZoSk9yQnFt?=
 =?utf-8?B?M2xCOGZVeFVneTFvQzlzWnB1Y0w0a1JXcDl2cVRKZGFzTTgzWTRibHZhTnNS?=
 =?utf-8?B?TlVYUldFNnNLTFZVQ1B4UTIycHQ3emFTTG1rNTVmMEhnL1FqV2xRVW1ieEcv?=
 =?utf-8?B?eVJ2YXJLdXQxQytzK2htcyswN0hwWjBDSkR5ZS80UlI4SkFkTHlxazBaNzEw?=
 =?utf-8?B?ejU1OFVPUkd0L3QxaVN3RHJHTmZQbVpyQkhzOUJyVUROTUJac0ordlFFSHVP?=
 =?utf-8?Q?wWBYMJwSmEA=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:22:14.9597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc496d-4cac-49ea-94a8-08dcef1bae84
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7516

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4d4fce389b20..7ceff62969e0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -788,33 +788,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
-{
-	/* mptcp hooks are only on the slow path */
-	if (sk_is_mptcp((struct sock *)tp))
-		return;
-
-	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
-			       ntohl(TCP_FLAG_ACK) |
-			       snd_wnd);
-}
-
-static inline void tcp_fast_path_on(struct tcp_sock *tp)
-{
-	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
-}
-
-static inline void tcp_fast_path_check(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
-	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
-		tcp_fast_path_on(tp);
-}
-
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
@@ -1768,6 +1741,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 	return true;
 }
 
+static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
+{
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
+	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       ntohl(TCP_FLAG_ACK) |
+			       snd_wnd);
+}
+
+static inline void tcp_fast_path_on(struct tcp_sock *tp)
+{
+	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
+}
+
+static inline void tcp_fast_path_check(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+	    tp->rcv_wnd &&
+	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    !tp->urg_data)
+		tcp_fast_path_on(tp);
+}
+
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
 
-- 
2.34.1


