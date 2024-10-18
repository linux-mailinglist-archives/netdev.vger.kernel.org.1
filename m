Return-Path: <netdev+bounces-137160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80B9A49F9
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4531C214F7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C416191F92;
	Fri, 18 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EPRF9oXN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A571917E7
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293631; cv=fail; b=gUj3XIvtmKIkSKeATnVUKdGju7R2/+3zhIc+KP30PMu5mu4/0wMwXlZPt6yGEcJ42qwyhiFRBhFwEqG+LeHvracL7o/TZFeyXLS/4H03q9xbX8xddYV6E8tfqpKkgWtelfKyZlGMu7d0o4M9GYxwsHjK5N3VwpV+5xD28cKsors=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293631; c=relaxed/simple;
	bh=3zGp58t362CmVtDa9QFNHZzzdy0EVtxL7MMUb+yZxbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgDYW3FDIRzqoU23dQD1Zxqsh75U2Ny6qVFAWDr9JcqDRHbo4CTc8lov6QdoolM2mMd1fZCa7JRMsGtI/JXeXzNbp/UKYTqJm5XE9wgVoW2R+xZELJMdkSWiqwkQOM/5WC+ggVYUyhobh53gmSUvwSErbet/476Rc5l2Uvn5TH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EPRF9oXN; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrnrEYxFnd1SHs6dIbBf5jrxvnSzPs17Jq9REZiCYihukewdpwRBhkr1Y4SNjutfQRRKhdzBNpWXUQ4o8Edg2dO/opur5/Y9Hl7X81jZUhZlJ9tZOjatf0Ve2Uj15xlwrnUVGkxbU2KWl2wx/55b6pCsSjZxG3TNZSb2lbti4caY3H8+DmEyu/kGQUW5VL0O4zBlQlauOMs1XgR3S+pzsvdFU9pblwV3lGIKXCkS002m5bTPRGKUGYp5RUz33iK6PwDG/mb8akRIaq79I1ZdTZEn3JAIc900kpuXKjzis2dHAtWyAmiwuqDvwco241Q/Vpkr8dw1ace0qe3damS3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pf9hlyv6o7rclrqAn0mftxD+MbOfoa7s/42MqDOeUQ=;
 b=I/+/aP/mmfk1ae1hH2A4mDweyjbwkjtrRA1euSsP8OGvXvNrUwjYPH9SW9Nlwq99qbwVko6A4n13DdXbUitgF59bGE6dd9XtjdecmkT+YKf1EoEJ93v3p2F3JJlhgZ4uK98NyfppU3a5WfbaNzoW6DNMnR82Q8rBvhOcX6Dcv63JWNkSaXI+8EZ50BTYP9nDgDxA3yvvnNdOaxTxoTN162A2wM8yeecqNqYRljK3FABPut8RRx0UFnqgio1qLgTPBSKVc9Us97YM1YNxRYZaLMgNvesxdnuKGOuMFrqSo0t4CBkN30L+oTfKU7ctSFpUWZefwRfXqnCHONIeaZ3F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pf9hlyv6o7rclrqAn0mftxD+MbOfoa7s/42MqDOeUQ=;
 b=EPRF9oXN2nUJD7SWKVrrNjyotZj7Dg/NhVDfwMLKf07s2FcOuZuN6QmscezOwByZiWh3ps3T6EzsLS8CsCi9J9ivqesc4kgZOCQ7g8KAMtk+qFN/rqpJkyFZPPNQNVMzc/LSdUHljG2LdlLHGjlRpR8WBPVnkP3lNuiWIrB43I8Al1cwZph9Ff/tRcqGvulb2LVVpfZAb9DK0P6wAO+jDpbNyDX/VQca2MHBCToKQITHIrTow3OHs5vuf59AglHsmGZ0luJfTQsn3I3K3JhqEeXp7M/sjtP6UpzFpLzse9db2rkekQ+BkOwczgXo1TcFO2R8XyU54fmtDrs4hO67NQ==
Received: from DU2PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:10:3b::20)
 by AM8PR07MB7588.eurprd07.prod.outlook.com (2603:10a6:20b:24b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 23:20:25 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::48) by DU2PR04CA0015.outlook.office365.com
 (2603:10a6:10:3b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJR010239;
	Fri, 18 Oct 2024 23:20:23 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 02/14] tcp: create FLAG_TS_PROGRESS
Date: Sat, 19 Oct 2024 01:20:05 +0200
Message-Id: <20241018232017.46833-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|AM8PR07MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3905d5-0102-4505-3613-08dcefcb7250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGJEcFpnYllBSlFxK3M0UHR1dmY4dWlIekxHUUhNZDAyUWpsVVlEL29PajRx?=
 =?utf-8?B?TWw1N2FaREprQnVvZFdRSmtKRmUrdXgwNWFhOU4ydTlrR0d5dnlyZ1dCbkR3?=
 =?utf-8?B?d05CTi9hVWxhUGJJVGFhQXJtK0tiK283Z0tHUy9DU1JtcHNCU1N2M29UMTUx?=
 =?utf-8?B?VElJNWdmVmw5WjlhdnlGOWxOOTlTaHpONWR5bHNuSmdDK1JnTU9xSzYyeXFD?=
 =?utf-8?B?YVZMTTRQaU42a0VWQ0pTMzJnc2laMWxRdTBMZHVQR3IxZzk0bUhvd2ovdllX?=
 =?utf-8?B?TmVGQjM0dVJHK0U3ZE9sRnlzc0NQM1hoRDdnSDU3ZGhpRXhVejU1UDRQNmRW?=
 =?utf-8?B?Zkc3bUdwclNSWVJXU1ZvVFpBR0Z4dUt4SlJmaWZZbzVJT2dEQTVIMVVzNjM3?=
 =?utf-8?B?cmFZSU1EenM1Y3JQZVZEdDNxK3BDVUF3TkRSYUNtME5nWlRPSUpYekRWbEtN?=
 =?utf-8?B?dzVGQitoUi9VTnJsYzRzUi9kOHFtblhUS1p3VGpMU2VhaUlCRjFra05hR3JI?=
 =?utf-8?B?b2hTZE9iV000MkZvNEpubS90M1NlekZydXUrYzcvKzdPQ3cyU2piRCtocDRw?=
 =?utf-8?B?NDd4QWxBaXJZOStnQm5RRDZycjVuREVDZmg1Q01LT2dGOGNqMTZNTkp5bThO?=
 =?utf-8?B?Szd4dmd0cEJVV1NTOXNTY1hTZmlNV0ZHdXIyaGpGaml6eE5oME0wVjE0TlNa?=
 =?utf-8?B?S2tyNHlQajFqcnNOSGVYa0F0MWpwTG9MQjdiQTJNUExOYjh5SG1CSHA2bDRW?=
 =?utf-8?B?ZncxVC9seDNyV3lYNEJEdUNqVjl0ZWFsZWE3bGZ2bEVPclNoYnZsZUZIaGlG?=
 =?utf-8?B?eXFQLzdHNGhublRjYldzcmhUOXMzQW5WSUtUL29zanAweHdCejVTZTlvbkVL?=
 =?utf-8?B?dGZ4cWtxaEpCQjFhcnFYVmF0bzNQbndFanNOVmNnMVRSQnU0SUFRODlZZlJ4?=
 =?utf-8?B?WUpxcndtRGYwS3owVUxEaXc5ZkEyMVgzRW5wUUxnN0taVnVuWWNMcm93MXlP?=
 =?utf-8?B?aFF3N1RLM0hBYmU4c3hnL0cvUHU3cWprVDVwRXJzdzc2V0RmOERXTTE4K3pa?=
 =?utf-8?B?NkpGR1drUmg3dzRIekN5aXgzamxTT3dDRnlLWE9YNlRSS2gxSk1vQmc0eVVR?=
 =?utf-8?B?Vm1SSWhrM1BtallWemlHMHlMajJtZWhFRS9KeEhnZzlTVjR1V05MOU51UnFT?=
 =?utf-8?B?djdjTUVGWU1lSThQUHZzNC8xSnkyTkVKVmU1VVpkS1NBV0s3c3JLTnIzSExl?=
 =?utf-8?B?a05meEFISmRwOUNNT0pIN1A3dVBjTGY4RVdjc0lCVWNRR25lYmdrTmpEVzRt?=
 =?utf-8?B?Z2lHU3FxNHp3QWlYT3ZBVEpjdnhQZmZQUGdyN3pWOTZiV3JUUGdpVHZ0U0tw?=
 =?utf-8?B?ZnYwUnJIbWlGVkxNWFdTWEJoWmpPalhtd3ozZFpzbU9hYTM2dVdKUGE2RWd4?=
 =?utf-8?B?dXVLUWttU0dyWUpTVExKVVlHNDlxdktRUCtZREM2VXpKSHJLZkZEcTZvbnZH?=
 =?utf-8?B?TXRFb3g1NjVFbWdielkrM3VDZGdPeHcwWE9mY2IrRG9mZ2E0ZWZ6ZXpOcEhO?=
 =?utf-8?B?RWdEdXZHcUJuUFBWKzNJdXZzaUNIVU95N2QyRFdDNEpQUEVYTUJteVJnR2Rl?=
 =?utf-8?B?ZjBwWUpyQnRTaTBlY1RNNnRZOTA2MFU0dE1ZSkVtVTFKSVJTUHNVVzNOV0Rr?=
 =?utf-8?B?ZzlmVlFrUmlhYkM5Rm16enkxY3RYR2llL09MZUx3WFluRHBRcTNpL0lUa2dx?=
 =?utf-8?B?TGZIMmY0QTlSVFpBSU9VYXFwanB3VFRvTkVEUDdORXVPb01Dekp1UXJmT1BO?=
 =?utf-8?B?Z2luNUtHVVlTVmJUOEFwT2hXWFFXcWEzWEJjY20zT1MyOWNFQjF5QmIxL2Vh?=
 =?utf-8?B?a1g5WmROb3NyUjNyNWpwTGtHbEg2a0tGVFpBNUxXeW9JRU5reHRVVHZVUitx?=
 =?utf-8?Q?xh/c+knbcw8=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:25.3464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3905d5-0102-4505-3613-08dcefcb7250
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7588

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


