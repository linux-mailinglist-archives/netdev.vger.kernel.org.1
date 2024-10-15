Return-Path: <netdev+bounces-135548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD51499E3EB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F501F23BDF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA51EBA15;
	Tue, 15 Oct 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="k2fUprPA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AC1EABD1
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988227; cv=fail; b=G/tzfZVEiH6rni0TA3slrHXFUYH4cYIHa8yrQ36AH/FvlF15/cthQr0d1yN/WbaJ+Ry9P+PHDJa0naNT8sPaa9aHOvvb7dtpOrvZVsT2jAg89x5xXp99SZmrS7RcNNfcNwe/eVR6c9qJT2NdrQhtZjnKVnTKInLndD3dL0L+HxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988227; c=relaxed/simple;
	bh=aigVrtFmdlODcoDzUAkTu2EEDAXuRELqVFW7iXHciWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRmUY8BIZPCOCODUe2E4JsHN3vTfHfunN0aLMCMxoSKalfZMbitx99pcYQ3Wblpi+CkySY/7pYj1TjYg6Q73hEurHrSMBIAn6sbZk8WMuikiGoZzvwkPs2XUUj+P0PvnFaYIBIdzCS1Iu7YOOBi7igdhzGYqE5XDjZcuWKTb9dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=k2fUprPA; arc=fail smtp.client-ip=40.107.247.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtiMdb5WVudmHC5DgyTEa1C+w4oxqXOkv9XtAfzGxWE32DwtQ6D/7Nd5tqpxbaN2lp3nilxbtEZ5JdmBhNEsgVEvFWD1earg5SCqDjLxcoQxhd9klrPtfpIC8dNBgxrDj1/W7AfFn97QaNBPnJGoaoV0I6A2SAqf+XYBdZgRvQ8cNa2rLfva+0t5YJGaGOF8wxNfIqZPZqHCOJuhGHGlZHwUNqj3NgwOBKQh/gfAFMJiF2Pfkh4ar6UIoGOk3eE4qlY54tlj6N1e0hfJBK4oQDcTDXSE4lEHQrUx1CgBr4m/6WHQbjl/gGhe8bl8adVMz79oTb0ug93/KyPKMxOxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwpGt7LZQgUGaYqfl+JpsnW8PuU1p5tVsq5y1AfhjMw=;
 b=cSKwGesYZAYk5R+Hj1YfQ1XEIdT4DhtVPfPIwmeU5Rf+5ejEjbjbTNqUSU14HfZpokCDgSYzuZpQzCbBTHoclvvqPAhLMikYjLS4yM+sFLJ45ZAKjwimqyiPvIVW12hFW/lpLIwRLxSgg1frYw42XJAs3voPf2cK9SdwWuonCKAoy08TfHB/qgpYd9k2g+1LY0J5NJA6g95D4fE2O0/top9j6Cfi5hLM3KbBLT5JcDww0o30A3rUbVcZw1qg3YTfFrNwphH7etAPnosPRZmHujy3fiv0ccANqNK6Yfb61TlproH7onUtoqk8qSPV9hVqMdaVTObyGz/FHOXvoUbyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwpGt7LZQgUGaYqfl+JpsnW8PuU1p5tVsq5y1AfhjMw=;
 b=k2fUprPA/XYtT4vliokmAYrvFhZPgTvdb6+TlaMb4p8yLmZvIAi3gG8x6DfjkOMaZw5eLgo/+wocs3Jj1otYJegGMAPZiuQT/0FLJXoW74Ivbj4U0bYMw7MrYCeL2NF5Znc5N9yGBH145n9jx6hA7jR9K9BMyEszZRdEWWAz2HEUK1JdzeFVv/LgJ7N5oiwnVUrO/kE+knA3qQIBCZGzI8C4j2jxlqJSNZnk+Btk39MVm2pZdhARa05ca28Hfl55vi7qomBzXKDaQ86CZMaxwZchgL3ugmM4dPceHcApIRdHOTK4jjyWnVqNGSQHWb8juD7Lt9yBDM6a3J0MvOro0Q==
Received: from AS9PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::15) by DB9PR07MB9005.eurprd07.prod.outlook.com
 (2603:10a6:10:3df::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:20 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:468:cafe::94) by AS9PR0301CA0002.outlook.office365.com
 (2603:10a6:20b:468::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnI029578;
	Tue, 15 Oct 2024 10:30:19 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 14/44] tcp: fast path functions later
Date: Tue, 15 Oct 2024 12:29:10 +0200
Message-Id: <20241015102940.26157-15-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|DB9PR07MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 612fdc85-9e7f-461f-388d-08dced045eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2xsZGdhaWtTWFcvTXNUSmltZlQ1VzhnVTRVUmFnRWVMdmVLWmkzdUs3TVR0?=
 =?utf-8?B?MnJrOVUzbmd1LytmaXNSa2g4OFZlU01LV0hTakxQbS9hMHh5RUNlUFBON1ht?=
 =?utf-8?B?TFNZZzJEYit0Z2xmWFdXL2w1SDQ2eERoUmtXcW5uNzdhd0duc1NVczgxWDgw?=
 =?utf-8?B?MC9JcTJPNTBIV09ucDZGUk9GbE5Tc2lTbUNHRkIvTDZlL2Z1UmMyaWFjZjlI?=
 =?utf-8?B?K2p4bXFWVUlLZk05cmZtM2kvL1l3b29XaHZ3azRoL3ZqREp0TWV1OTh5b0VW?=
 =?utf-8?B?MGpRQXhERzVkOFBwOXF0R2FFbFhWdEROblE4NDF1eTRxckp3MWlvUnIvck1N?=
 =?utf-8?B?WEZieFNpbHBHdlR5UjYrdlh0K2FzMWc0cDhZeVJ3VlJEWjMxTG4wR3R6S2pj?=
 =?utf-8?B?SFExMkhCNW00ck1OL3RiM3JDYWN3R0hnK25OMlNIbFhyZkl4QXhzWkhUR0di?=
 =?utf-8?B?SFNWQ1k0aWdFbG54cGtRTndqclVqb1MzMFYvZUkxWk1meElzL2dTTnR2VVBE?=
 =?utf-8?B?ZnFOOVhtTzhXbDM1ZHllZzFLak1aaVZxNE9XdkFoOEkwNTdNMUVHWUxzbkdY?=
 =?utf-8?B?bXhlaDNpUEMrTEJaUlhmYXNXb04rWU9kNWV0bnYxVEtaUGlianEzVEsrMjZB?=
 =?utf-8?B?dVJvOTl0V0RySHpBWExhMlowOVZsTHF0TjAycy9nMGxjbWxoeG1ZMkVtZy9B?=
 =?utf-8?B?Y3pCRnlWNG11V3VVYjM2SytGTWlsSVg4YUZmVGtybEZCcUUzRW5VUitaU1Qv?=
 =?utf-8?B?TER1Yk5GcjF1di9EeWdoMkNiblF3TnVUcUhiZGFwVVhkU0k4eGgrYnZUeHZi?=
 =?utf-8?B?andYT2ZvUG5rRjdVZWtSUlkyTGVuQy85SWVZdXNPellnRTBtSmczY0F3eThk?=
 =?utf-8?B?RmJNQStUbGxlMzZNcFFyYXBtVUVXUnMyVngzOWlQQ2ZSNURpWXZJYjBEUDYr?=
 =?utf-8?B?a3ZBUWkxM0JwdnBhTWp4azN3ZGVPS2FuYnp0dEpCNVdCNVZ5NTZtQ0U5YjZC?=
 =?utf-8?B?VXRtRUN1amRRL3NQbStJS2JDYWROQUNXb2NoN0Q1WU1hN0JyVnJsZTYrWENw?=
 =?utf-8?B?TkZFV1djUGdJeU5YbEJUc1BKblpsUE9zV0RCL2hmZW4zaEZXZHF0S21ubjVy?=
 =?utf-8?B?KzFUUk9QNHBFN1YzYlBaTDdNc2FuM1dySnhIMmx6MU9SdFFxeHErclRBVW1q?=
 =?utf-8?B?STErSGtBTnBwa21wSFBWVmtZUndyTVd4ZU1kdWh5OGNZdDREeEwrbkgrQmM0?=
 =?utf-8?B?dzIyejZpbm96d1l5TlM5c2JxVHJ4T1Z0Y2R0eEdRYm1KN01XUFNKd3NQWHJW?=
 =?utf-8?B?blp3b21saVArSnRwZEw0cU8rSWxabWt5T0hpVkt2SzBhWHpnMThDYVo1YXJm?=
 =?utf-8?B?WFVJL1lSRXl1NnZFTlU5cEtHYUhBaWVZaW9nYkdTd0h0VVNjREJsWGlOOVpR?=
 =?utf-8?B?UUpScEpmOXdjaElhVnJscm1rVExmZ1hDUkQrNlF0Q3YyN3htcUNuR2hiVklI?=
 =?utf-8?B?b204TklybGRPQ2x2akJSZlA1SFBWYVdmL1hPbk1XZ2FKWEhCMmxyTFhPblBU?=
 =?utf-8?B?cVZud3p4Rm0xREFJWkdsQW0vcEw0VVU2SXpnYmthTDRwS2NaWHFhU3RuWHNs?=
 =?utf-8?B?aS9uL1NZbG01ejVpVXduNHhmRHZqR2VhY1BvdmN4U0tSNkdRSWJTajVCL2kw?=
 =?utf-8?B?K21OVk8xd2t4d3Rhcmo4dEtBWmhxNHJjOWhWSWduN3c5dkluNGQyNDlZNkZx?=
 =?utf-8?B?SzVRWjFIN2JSWDdSMVU4Zi81WGNhQXlyR2hlTmpSZUZiQTlsT241R0swQVBB?=
 =?utf-8?B?My8yK0VqSGJKL2xSQkU3OTZIcnE3a05YSnMyd1hsbnNTZWdvL0NtRVcvK0pK?=
 =?utf-8?Q?SG61A2yUPxjUX?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:20.6774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612fdc85-9e7f-461f-388d-08dced045eed
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9005

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


