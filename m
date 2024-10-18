Return-Path: <netdev+bounces-137168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D049A4A02
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70ECCB2338B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B2419259A;
	Fri, 18 Oct 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IRNqT4WK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B8192B6F
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293640; cv=fail; b=HI/BLfGyIgIy0st6TQqtfGUeXWQ9JZalwFMPjxx7xGUjDOztU8AbdKyHlD/5wA9bLyZ2Ie9wR01v8bPE5PiiOX56gOCkp6DLmgYAuWLy4Ih5pkr3zONBpbk+zt7/xNEmchb0lC9KEkSxF77HAxOaeJbneqVP+0p3u+5PvBeMz+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293640; c=relaxed/simple;
	bh=aigVrtFmdlODcoDzUAkTu2EEDAXuRELqVFW7iXHciWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLVkkENnPGsXNLryjVHd2cte/VUfjvsVZIoEySeKLwtjL4nATJWrGE4BrRvON0NPR4fKB9g6Cq0Pn3srlIunadIw2BMW8yqXwZbP7+XroUD2RbwunDSgV4z3USTmo0QSICLFCzObyW1P/UQrOLx+2wTA471Hc6Jn/JgYcIANzFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IRNqT4WK; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH5099sG/x20iksmuBxuPhw8uHM+EQFVyjzVgGpx7DSj/l0xqzJE8EY6jxL3FEeSMm0usB91WOeQWtgr6aovmq2Sf7FESKb2+E2ieayI6+T8hmalEBbsPVv8z2hkBU7vc3P4TuAc5l0AHfiiV0KCwwhOkyXICcpJfYOEfmUWpQHNbLtqReQUpOu5ssuapdwz4ZwZzCBCIxgLfNHIMZ2OMmKXe04Z8IPbxpgvjVpIbCQZmK7yFbh7xoX5fuDP+9miEc1kWjpAiWwcEhXv+CLa5fzAEKa9jJelVajeRZreIed2kalYNNmmfnnolFr4RECcvmRSe04N0m7NcDo9h7dt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwpGt7LZQgUGaYqfl+JpsnW8PuU1p5tVsq5y1AfhjMw=;
 b=vJ2Zs2Gxo2OyAAcJoMPJbYwF6OJWjtnEVb5FPocbnWIQI8lGM+ynuPX6LqDWx4FFi1wOMhcnDtZBUQbnNp+RVgm4zh7f/Xp+Sy95rY3fz7XW1ST2tyGXzgk8W9/b428vhq178jPTlhVgcjgVbnvs/a1R0Ub47LhptilF7/C4+DVXdEZYNYFd7I/AxXU6JJyhxfQ1Y/8neYl/jDmR7qp8/Dik89sHBrCC72ApWOSYrauz/+UhzMmpmLc0CcqY99LjTfc+j3gqBITZxRDDiqVNdLAhRTHzmzrjpX0g/QCZJAGm4CnoU/1JY5DmaSoi3E8iMqQrdep/RS7naxWK5Q5yKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwpGt7LZQgUGaYqfl+JpsnW8PuU1p5tVsq5y1AfhjMw=;
 b=IRNqT4WKzbMjmKa6p0+FCiMcR1r8u0WiEeVTYtN88Xz6L+ZE85nrw+SJbiQE1Xac3vL9jMm1na+8kgAZ1oBnEy9U6wfXSmZWmC5X+HKOonNWAKoTa/jpvXR0aDPBsi+A3ji8wQozhUAqm8YOttn7fCDpTEO3e+yydKx4lkTLPbXHME1lwCcmvovYPHpt1z0b5GXqQaM24NOv5oP+RAF6Vewk0Lw8mgxakNkGKVEPPfsAWer8caXdAHRcoWqM8W3QI8tafz18LmMI4kKvMaPPz/TrLclbXdSqnFniFVZD1URKE9zh2wdv6w1dJ3n0IstC84On8XEFpu99+JNfjPPW0A==
Received: from AM0PR02CA0207.eurprd02.prod.outlook.com (2603:10a6:20b:28f::14)
 by VI1PR0701MB6768.eurprd07.prod.outlook.com (2603:10a6:800:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 23:20:35 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:20b:28f:cafe::b7) by AM0PR02CA0207.outlook.office365.com
 (2603:10a6:20b:28f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Fri, 18 Oct 2024 23:20:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJc010239;
	Fri, 18 Oct 2024 23:20:33 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 13/14] tcp: fast path functions later
Date: Sat, 19 Oct 2024 01:20:16 +0200
Message-Id: <20241018232017.46833-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|VI1PR0701MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: d353debd-49e3-4309-454c-08dcefcb782a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlBzQlpSU0g5Qm84ZmtNaUhzR1pmckovVlNtNkdjY0ZteG9VbzFuM1R1Tkkx?=
 =?utf-8?B?TCtsTXgyQ080MmwvQTgzcmt0VW1lVU5qZTVNV1oyc0dZdVkwYU9uZFYyV0pB?=
 =?utf-8?B?K1lwekx0b2hFRndsUnN6MVppVWFJQSsyc2VNUVJqcEtFOXplOWNMekVFNUgy?=
 =?utf-8?B?c0M1Q2RLdXNYS0RheUhWS056ZXdhanQycEZLUVpBRi9YY1hVLzJ0UlVOdk8y?=
 =?utf-8?B?WUdqZHl4L2QxTWtKRExNTFIvSTA1SjExSjYyTm1MVUl4czJtamdwMmNMMkRZ?=
 =?utf-8?B?cG1XbXVvSHF3ZDhxUk9sU3FxNy9BL3UyNGFFdHdpNGZPOEFsV3JSR2Z6OXky?=
 =?utf-8?B?cTZZRlM5SWFCYW5DcWQrdjM1S3BVSDUyWnkyeFRoTkRwcVRFeHgrV3BnVkF1?=
 =?utf-8?B?RnJpVW9wSzlwUGd1V2ZHczc5VXZPWWFnWFdWbXpYVjBWcWU3NloyOUNiMWxE?=
 =?utf-8?B?bXNiditueGpocHdETlpqUllTSi9KZCtiZjlKQ2EyQzQrSStCRC91S1FKd0JP?=
 =?utf-8?B?YXl0T05xK0tTTFIrQk5ZTThEQ1RReGNTVm1TZGJQNXIxSDZSSklVWkZwdXBz?=
 =?utf-8?B?YkV3d29KUHFXTVNrVFZMZXdqR3g5MUw4NWJrek8wcEduQTJleFJBQzBKMmRR?=
 =?utf-8?B?TVRsN0E4Q0RsRWdyVVg0RUJNbUJ4NHBpWUxPZXdJdUR1dWZ2Y2NoZmk1Yk1N?=
 =?utf-8?B?UFhyM1dobjBQS2FQZXU3ckM4bmpxNFFraWlZVVpILzdBTDU0RDJOM1NLdkpM?=
 =?utf-8?B?TkY5dS9yVVV6aDY0Z3V0ZjRMMlVxaHFBTjZGNmhmL0JhS2plMFp2bzNDa295?=
 =?utf-8?B?Rnh4ZWVobWlvWHVoY0NhWUN5cksyZU9FdmN6b0NSWFhIOUZnbnczYk9VSjA2?=
 =?utf-8?B?YStIVTlEZDBKamNzTFN3R1RUWmZNcmhrVkZ4N3lVWDJNdVVLcGtPcEJjNld1?=
 =?utf-8?B?Z1MyL0ZjSzBJcExSSzRXdlYxUnUreWtUeGM3SEFOMVRHaEs4ZDVNN2pndWVZ?=
 =?utf-8?B?dDU2Qk1xbnhqUWp0MERjN3I0enRvdWQrYTBoZ2ZPRTZTMWFqMWFTZUdDQVl1?=
 =?utf-8?B?R0VOOHBsUGVQS3lwaDFCcmNjQWhCTGw0Z2FSdlVJdFFKa3RTaWFYWUJFUlUy?=
 =?utf-8?B?TXY0dW9sRlRldU53Q2RqR2swOXN1ZjJEVklyWW41UWh2TXlLY0h6cUlaWGFj?=
 =?utf-8?B?TlBISlh0bmc4SmdEVXhoRXRzaWtab2g5bGFhUnJCN3htdU1WZDZRZXN2T0Q4?=
 =?utf-8?B?ajROUUpRTFo5Ulo3QkFtU29mSGZGNzc1a2J2Yi9oNzNXVFJMVzBlc2JVdzRV?=
 =?utf-8?B?R3RoeGhyTW1QODY2NjRzcHhKckF1Y2JIS3ZKSWhoSGRQQkNrOHhYbmJzUUo5?=
 =?utf-8?B?a1hwSEJGbE4wWVBMWXNhdzdPeVlIMkZ3WUNZK09TbWxlVEJ4SFNoN2dhYUlq?=
 =?utf-8?B?RGVBd2pUalZZZkdPRlYwMkRRR0xQZzRIZDBteExON1RtWUZIclhic0hHWHAv?=
 =?utf-8?B?ZXhkdWtQYUpOQ1Ntc04zSlprZC9SbS9OTmMvN1UxUU5JNVJ6VjlhNE11UUp6?=
 =?utf-8?B?RVlqKytUK3ljZC8vUTQ4V0kxdGFseDNwVEV6Ri9ScWNMUHAyU0Jlb0E5elgy?=
 =?utf-8?B?M25OY1l1dGpSL0ZFcHdjRFZUU00ralBYUkE1TDkvaWZkazRKU3FMWXZsUkdM?=
 =?utf-8?B?NnJ4T0M3Njg4Q2I2OUdmZkpvSmlWZGxzV00yTlAzUHVpQ2F4bTVWcEg4SWhi?=
 =?utf-8?B?d0kra3BiR2ZOVjJ0K1BkdkRGVzFmNVVJVlV4ZlBMTDZYMGwweHZQVkxBTW1J?=
 =?utf-8?B?VU11ZXlyVDRaVjRFV1NlYXBDbEZzTlhXZ1lJbWdlNElhWUlNbng4NmJPYUxL?=
 =?utf-8?Q?BBaXsueDsZOM2?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:35.2109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d353debd-49e3-4309-454c-08dcefcb782a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6768

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


