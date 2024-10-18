Return-Path: <netdev+bounces-136814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7AA9A329E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449D11F24BA9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB01537D7;
	Fri, 18 Oct 2024 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pCHzCEjK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC123145B14
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218081; cv=fail; b=BLgE56nu9JH084Q3lIhVPBuRsZ9SN7lgmrNME2mTsmL/Qe6XizZjBE5UPYXvsKrDknWdzOtIj0FiYN3/WKyzXv357TOjVrUKJ0ONlPrSe/rHJyx/qfsFsqrBQyqsXRiPFnMuqPiZET9CZIh0+UErDs9cbmtV10J79gu247B5800=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218081; c=relaxed/simple;
	bh=3zGp58t362CmVtDa9QFNHZzzdy0EVtxL7MMUb+yZxbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+Q41V0V6UMg76vN+nilgjI664CvOgYfHX5uVjlxL8ejqMv5JRUyqUHqY6iCClxkmr57p7IeY4F7wR28Glv7O7BW0rJgwJpt8f3l+WeCWeZJRnNk/GUaOiBQSeDFVchLaZLEdSbOAGx22a8lZBTbc7BFW8OdoDiOnVqjEFS2YBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pCHzCEjK; arc=fail smtp.client-ip=40.107.105.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=st89svh7YSQ5ppHkWkRg/xYtNmmqAMEJ0MpvBjZklQ4Nr9zJ0W9HJk2u9pKuGvPJgnEwkLNPtOGJyNb7E10MTb/BhxXo0jvFAzYyeIW5ChOitVSX3SCgvpXSvyUwOPLc9s5cjgQFB0iY95Y3FxO7eecMrNuz1o6OWc/PwgKKsXWeQxBYkAkFwL0DyeB9NkdugzZPY35Y8QNnBHKuaCp6ydd8bj5QXxbXDrjpy6WuJFtqqySo5zeF+so6fuNJfYYhrjVNoth/QUnZDZnWd64v1k+Iw5eERcGdyh+6pjU1tJX/rjw67zIAcpGNbS/bxgY6r5twoVAhgj+hI9+gOKu6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pf9hlyv6o7rclrqAn0mftxD+MbOfoa7s/42MqDOeUQ=;
 b=r/EAJi9fvVwq6A+X7OJaqAGF4PEeYAoUki5ysYWa6sIlcp7T8w4J8wtzR+3Pl46UVGXvF9ciycWwLlVCoa8jn0hvTcM1LKKQQRTTOGLbBASSvg7271hYdYmCcoslWWVGjUPDufNmwtG6vxnMECdPgANgW9u44Fd4MM287AmxBBCfI5a7M882tyEuPwWbkBauY8TkhebbPJMU6+0CJl26yPuGW4tN3ShGSmbSt+3H4jLMnuElp8pFnODEIX/XdjaAuMyUzkMw/avDHk/056I1xYcBdYdqa4+u8gM09MYYvHwePfXLp8Vl1W73Bn9u3jJBwB3Ew9VOUB+ZErj/1xzaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pf9hlyv6o7rclrqAn0mftxD+MbOfoa7s/42MqDOeUQ=;
 b=pCHzCEjKCmJZKyju0xky8MlE7YoEuD0s4TmxRg+vnE9o2JDUhp4sY09COG5VcRYVUJ7Zx+0CS1bkAsfREc7422v9ni8WLEH82SrsJoxOjlveW5N4OrbkHRKg4nY3PFXHilcCAaxJPeCEaufVPXLPuZ7I7mgzKYYQWwWwRphRZCwpS01X5NcKy1e1bO+TcygNMO1AKOQ39XT94fPws9mEvDUO2WLk7eyspqB6S36dutGewiCZRnlTZSnAzFw0WBP3OHExKhS0wFDToCUvLm9mG4TlFUhFd2lMhe1aQXLoLjvMMmFWlxacoH1zdhrRBAKaXOM+xP5CPxphX/JWbUz2RQ==
Received: from DU2PR04CA0318.eurprd04.prod.outlook.com (2603:10a6:10:2b5::23)
 by DB8PR07MB6427.eurprd07.prod.outlook.com (2603:10a6:10:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 02:21:15 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::d6) by DU2PR04CA0318.outlook.office365.com
 (2603:10a6:10:2b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0MW023685;
	Fri, 18 Oct 2024 02:21:11 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 02/14] tcp: create FLAG_TS_PROGRESS
Date: Fri, 18 Oct 2024 04:20:39 +0200
Message-Id: <20241018022051.39966-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|DB8PR07MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 8294d080-6f40-45f1-196b-08dcef1b89ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUp5QlV4TVNYNURROXdBYm4xTkFGNTErRFRFR096ZEVKSHBnOXYzWFN4aVEr?=
 =?utf-8?B?VzhEVytYOXdSbXRxVjFlZzBQeVJ3bDNuRkNqMGdZcVB5T1VQOEQ5ZS9GWGhy?=
 =?utf-8?B?TmZKOUpSOVlFczRpcVJyejVWNHJpbXZRWEZSbTkvZHpSNnA5OXViQ2tqakZo?=
 =?utf-8?B?UHhGcTlkbmhTd0dPbmY0L2dMdThsTnF2VjFqMlkrK2xuZlpKSW1IaVlUUzJY?=
 =?utf-8?B?aFM3MkxVMVN1VEdUN0ZiZktPMThCSFptcG9RQi9JL0MwOXo2SndrNW5PUEg3?=
 =?utf-8?B?WWVaM2ZIL0h4KzIzc0FLRWRPUno4ZzB3RklvYXpJUU5pOElCSEFwK01ocVdU?=
 =?utf-8?B?aS8vc1g4bFM0Zmx5am80ejhJL2UrWWR0dXBaQ3pLVVRNQXFXdXlKaXBFa2g4?=
 =?utf-8?B?THVPd2hjM0FuWlBSamF6ekYvNXdPcGpjOU42RkIvbmdZRUJwcEMvVCtieEFJ?=
 =?utf-8?B?MDZZNFhxalF3SzlVYUFUZHdiZytxVTdWemtZTVR2WDlNUzRYSm55QUVlbWxN?=
 =?utf-8?B?U1kzWGtWdmoxUmgxaWI4WFpsY1dmL1QxaEFaa2dBWXlWbzJDRzc1U1lnb212?=
 =?utf-8?B?dlJ1U3Y3OGRmaVUyVzdrWHIyNXJJVURZbHFYQWJzVkQvRWU4V05PU1RDRHJL?=
 =?utf-8?B?bU93SGNOSlRwcmpsOC8zVFBpRkpQa0lWRkNMKzI5b3ZtWkxMS3d2QitTcnd3?=
 =?utf-8?B?VXo0Qkt1WkVGd1hSNm55Wm1zWEJmVjRNT0crbHJMeXRDL0lsc3RCLzR1ME1t?=
 =?utf-8?B?TlF4NFY5QXRmcW5XMWFZVmk1RjFqbzhqRjNPZkUxeHhyeTI2cUxYRVo2TmI2?=
 =?utf-8?B?d1ppWWdYVkJrRFZ0akNCQXJKR1EvY0lRcXBCc3NOeUlSNUd0cEYvVm80U1Q3?=
 =?utf-8?B?M2tXRWMveENoZUEyb2JPY0NkWWd0b1pyeWdESjdHRGNZWUdzZU0rYjkrNFdQ?=
 =?utf-8?B?Q0VBakZ0WjE0c3lTWVdidDNnMW50U05IMHVONGpLeDlRV0FibVNDZ3VKT0dR?=
 =?utf-8?B?QVYxOEZkajBqRm5iWTU3ZVM5WjlPMEFJYSsrbml6K3NRUEUxa1pTVlhqZFpa?=
 =?utf-8?B?a0xZZFIxSGUwdlkyQ1VuYnlBaE5Pb2gyWDl6Qm51UTBtc0xybjZKREZkWW9R?=
 =?utf-8?B?amlEdEZOUlUyNVM3cnNHdHZuVFlDVVhKdFBxVEhEQlhYQ1pYMG9sSG4yNkk5?=
 =?utf-8?B?cnpPVVN6MHB3eC9ySXdwZmhnMVNRdjd6aDE0Uzluam5ZZDZuVmhJWmppODN0?=
 =?utf-8?B?MThEeVlvQi9wdnJmajd0ZzRmNThVRjFWeUJEYXNOT20zTzdjSCtGd2pRbUZM?=
 =?utf-8?B?NE4yUEVMU0tBbDRCQmRHZVYwTlI3NDdXajNpM2t2ZlluMWE1OThrY01wTGRW?=
 =?utf-8?B?MW5vc3kyWjZ0SXVKRTZaNjNDc2JVUU0rYVplc2Zlcm5CcDZFR3FwQjBnMmFZ?=
 =?utf-8?B?RjRRcXBYZmhDWmU5UG1rekVwTmszYTVSU1BweGhwMGt1QlFOQmFoQjNHYS9q?=
 =?utf-8?B?Y3d4c1dSWktYaXVHYXk4MlZIcVFuQUZuNE0zWlQ0c3lPUFEwamhUN0NFQlVo?=
 =?utf-8?B?Rm5KV093N0QwbHlBbHV3MTZYTmdVRnl4QWt6OVh3LzVvT3FvRDdFRUowdGtM?=
 =?utf-8?B?enBvRzFXKzZMQ3lqbXdONGhBTSsxS25DMTB6d21sSW9XUTRSem5HejVpUko4?=
 =?utf-8?B?QnFSZlh3ZmpvUHpNYTFqRDdRWUZKNHFXSk1oejhjOWRMallmWFBBVXRwMVF2?=
 =?utf-8?B?TTFjcWJCa01xZHg4SFM5bUVIcXhiNWRuRFhPMVlmL3M3aEI3dzNJZXl4Q2JK?=
 =?utf-8?B?elF3Mk5CYktiMGR4ZzQxUGJSTkwvVEk4VEVxRFBORk8vMDRVbzQvQWNlOGpy?=
 =?utf-8?B?cHVlRllqa2g4dWRrOVJ5azR3MUhMYUdoK295NC9iQzhhZnZhMzR6bFcxM0tx?=
 =?utf-8?Q?cSVOT8O6eX4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:13.2499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8294d080-6f40-45f1-196b-08dcef1b89ec
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6427

From: Ilpo Järvinen <ij@kernel.org>

Whenever timestamp advances, it declares progress which
can be used by the other parts of the stack to decide that
the ACK is the most recent one seen so far.

AccECN will use this flag when deciding whether to use the
ACK to update AccECN state or not.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5a6f93148814..7b8e69ccbbb0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -102,6 +102,7 @@ int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 #define FLAG_NO_CHALLENGE_ACK	0x8000 /* do not call tcp_send_challenge_ack()	*/
 #define FLAG_ACK_MAYBE_DELAYED	0x10000 /* Likely a delayed ACK */
 #define FLAG_DSACK_TLP		0x20000 /* DSACK for tail loss probe */
+#define FLAG_TS_PROGRESS	0x40000 /* Positive timestamp delta */
 
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
 #define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
@@ -3813,8 +3814,16 @@ static void tcp_store_ts_recent(struct tcp_sock *tp)
 	tp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 }
 
-static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
+static int __tcp_replace_ts_recent(struct tcp_sock *tp, s32 tstamp_delta)
 {
+	tcp_store_ts_recent(tp);
+	return tstamp_delta > 0 ? FLAG_TS_PROGRESS : 0;
+}
+
+static int tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
+{
+	s32 delta;
+
 	if (tp->rx_opt.saw_tstamp && !after(seq, tp->rcv_wup)) {
 		/* PAWS bug workaround wrt. ACK frames, the PAWS discard
 		 * extra check below makes sure this can only happen
@@ -3823,9 +3832,13 @@ static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
 		 * Not only, also it occurs for expired timestamps.
 		 */
 
-		if (tcp_paws_check(&tp->rx_opt, 0))
-			tcp_store_ts_recent(tp);
+		if (tcp_paws_check(&tp->rx_opt, 0)) {
+			delta = tp->rx_opt.rcv_tsval - tp->rx_opt.ts_recent;
+			return __tcp_replace_ts_recent(tp, delta);
+		}
 	}
+
+	return 0;
 }
 
 /* This routine deals with acks during a TLP episode and ends an episode by
@@ -3982,7 +3995,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * is in window.
 	 */
 	if (flag & FLAG_UPDATE_TS_RECENT)
-		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
+		flag |= tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
 
 	if ((flag & (FLAG_SLOWPATH | FLAG_SND_UNA_ADVANCED)) ==
 	    FLAG_SND_UNA_ADVANCED) {
@@ -6140,6 +6153,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	    TCP_SKB_CB(skb)->seq == tp->rcv_nxt &&
 	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
 		int tcp_header_len = tp->tcp_header_len;
+		s32 tstamp_delta = 0;
+		int flag = 0;
 
 		/* Timestamp header prediction: tcp_header_len
 		 * is automatically equal to th->doff*4 due to pred_flags
@@ -6152,8 +6167,9 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if (!tcp_parse_aligned_timestamp(tp, th))
 				goto slow_path;
 
+			tstamp_delta = tp->rx_opt.rcv_tsval - tp->rx_opt.ts_recent;
 			/* If PAWS failed, check it more carefully in slow path */
-			if ((s32)(tp->rx_opt.rcv_tsval - tp->rx_opt.ts_recent) < 0)
+			if (tstamp_delta < 0)
 				goto slow_path;
 
 			/* DO NOT update ts_recent here, if checksum fails
@@ -6173,12 +6189,12 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 				if (tcp_header_len ==
 				    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
 				    tp->rcv_nxt == tp->rcv_wup)
-					tcp_store_ts_recent(tp);
+					flag |= __tcp_replace_ts_recent(tp, tstamp_delta);
 
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
-				tcp_ack(sk, skb, 0);
+				tcp_ack(sk, skb, flag);
 				__kfree_skb(skb);
 				tcp_data_snd_check(sk);
 				/* When receiving pure ack in fast path, update
@@ -6209,7 +6225,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if (tcp_header_len ==
 			    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
 			    tp->rcv_nxt == tp->rcv_wup)
-				tcp_store_ts_recent(tp);
+				flag |= __tcp_replace_ts_recent(tp, tstamp_delta);
 
 			tcp_rcv_rtt_measure_ts(sk, skb);
 
@@ -6224,7 +6240,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 
 			if (TCP_SKB_CB(skb)->ack_seq != tp->snd_una) {
 				/* Well, only one small jumplet in fast path... */
-				tcp_ack(sk, skb, FLAG_DATA);
+				tcp_ack(sk, skb, flag | FLAG_DATA);
 				tcp_data_snd_check(sk);
 				if (!inet_csk_ack_scheduled(sk))
 					goto no_ack;
-- 
2.34.1


