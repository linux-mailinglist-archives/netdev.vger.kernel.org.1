Return-Path: <netdev+bounces-135537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F299E3DE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074C81C2165E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8A1CF5EE;
	Tue, 15 Oct 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kqv+dRbt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD413AD20
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988220; cv=fail; b=J2YVUSbk/t6JpkNmv6dexCGDOpJm99DiFtxIFMnidKlQbwTLjpKtbJ5dSV1qMgx2ft5nfaP8PSj6koJWA39LtNgOMUMdUiau3rn3o1ae17nLkSDXHFf+i5cBtsCM1Oxbem6jqEMjcjG0dkWSe1Twtp45ez603jjw3EM0gdc+kFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988220; c=relaxed/simple;
	bh=3zGp58t362CmVtDa9QFNHZzzdy0EVtxL7MMUb+yZxbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMjq7cX9m1UCVut0EQQtZXl8mWU3UrmFV6K+iNIOPBjoj1fkysj0wbHsAbCJgC87tt7nNr9XXtUEPix4yUA79bjBJ1D9zz/sZ/eKZpJljMuUe163UUOicefu9QORi2xECkjvbZbRU5FM4QfkIUCAkfbuCEeqCR9pMgrnCd6WWXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kqv+dRbt; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOBMIx1kcITEoXHx3Kz6q9FbGTHTOHKyTJnLtkS3Yaz96MWXsL3zZqsGwdBsl7R3JbccivPYBbwXEDwwY74gNrVjVQ2UsrURhVduZeOF8HNBucCC9Y1NCNzcOyrNiqk2n5oiN7hLSoVdHnBB6zRISPzSYDi2V7YoXhNA+JvNWouNMSW50QR31QNa8YpmnXSWCK/pq+JIAnvTUWVysTwAIfJ5uf6nRJew0C4OEXhUBtMCzBL1lMJuZC33j7bYeaaMfTEJm2RpCzpqG8B5Fd/W1yxq22ENSMm2PgotZCN4W3s5SpiJq3Yrt5ZdKpPyhE8AsFxo5xTyhiLJKDgNBi1umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pf9hlyv6o7rclrqAn0mftxD+MbOfoa7s/42MqDOeUQ=;
 b=hIuL3Mi11260OvcjlBjYH1rTMb1riYEeQ/RcOMzJWcx/W+tlgdmii8rZa+rApHeciV57P0Lp3WUBMaWRzj/n91FVWKc+fglM9gnqo9e8pkQdO8j1tLWCjmTKP6iUnQGhD44CouSDYMMm0js5P9qCHMloVzRVlyrqqU5sxfc5564O/pn37y+ctf6sKFtjfcnBPVD3n5k9mfvZiJae7IVLbn03GvTfUTJH6p1OpvSPjETLQwFUO4voOwfkmGzMuzCicp+Bc9vII/UZFZ5c3e7c1NwhLiDiGCrSMZiv0XhBO84GBfIaeof5MjeRHcBt+c3DEAOqxpsqlt9HlPDLYpajOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pf9hlyv6o7rclrqAn0mftxD+MbOfoa7s/42MqDOeUQ=;
 b=kqv+dRbtZ8gqZnfIle6w/euZgClFNTKyFd2RNPU3a9H2ubahKIADBOOXhPwHliv14udMjKt9H1XKtqbh0tHKCtJhWKIy1+sD9fU6llF6KyJYlgX4BgzY3Z7X6PHcvABC5WTf0BXfOIu6Md+akBfpe0RA1DhyTGeE164dPnwJwWWp7XoZdTeMAXj+HAoFFWjaE7jqoWUSo7HYI0C6C1vfnKjrWolH6kDlTL0oYCAiMG1yrzsvvzjDbkhol/zOEVnLGPFt8GIhMGqp14vkrJ6qArza5KMRvuaSEx0NaWLSX4Y4+7H8tFBdGTUNLUViwqaLtqq8IZw4j5QnoU1FVTkSEQ==
Received: from DU2PR04CA0199.eurprd04.prod.outlook.com (2603:10a6:10:28d::24)
 by AS8PR07MB7416.eurprd07.prod.outlook.com (2603:10a6:20b:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:14 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::c3) by DU2PR04CA0199.outlook.office365.com
 (2603:10a6:10:28d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtn7029578;
	Tue, 15 Oct 2024 10:30:13 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 03/44] tcp: create FLAG_TS_PROGRESS
Date: Tue, 15 Oct 2024 12:28:59 +0200
Message-Id: <20241015102940.26157-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AS8PR07MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cc4fef-39cc-400c-d142-08dced045b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUFsRTN1aDlCVk9NRCtaZEhrWEQ1bWJyRDVxWWZIUitHUXJjYy9XY21lRUxF?=
 =?utf-8?B?Zy9uQnF1dnBWVGlYTjJocS9GRG9LZEYrK2ZpTTFBOTU1ZWxtaUNZa2lEUnQ5?=
 =?utf-8?B?MVdjRis5WHppL085ZXRvUWJIekhYbkNRNStTUHQ1cUc5eFhwSm9CKzdnWHgy?=
 =?utf-8?B?MVc4NjBxbEsyNHpwNHNvaXZOdWZ5VXFqWVkwZk0zVVg5M1EvaXEvUUExTEhN?=
 =?utf-8?B?cmFXRUZac2dWeUdFaTV6aDlud0xtbWpkdEtjMzhPMGxZL1RCU09ZbUppVWdY?=
 =?utf-8?B?RnhiWTNKbVZtS3FpUFA0OHl1MmliTXRRZXJBd0tldW9VeG85bEhCT1hteExy?=
 =?utf-8?B?S084UmhKL0VpOXoyY0Jjd1oyVXdtdWpkTjh6RkhQZ0pWeCt5S1hmREZYS1NU?=
 =?utf-8?B?c3VDN3FiSVlmU1o5K2t4R040ckFFQmFLWVNKZjhOVHp6bXRpdXBpS0ZqTkJ4?=
 =?utf-8?B?T1pvQjJuVHFhcjV1K3dwdzBFRWk4aVlHSzlHRFd1U1BsRmhqWUp1TlNiRVpF?=
 =?utf-8?B?cnY1ZldhZ0NROXBQVnZpZFVZVWwrUXdkeHpuZWdIR1JLcTJHVFdpUzFzamRh?=
 =?utf-8?B?MkVwbUF4b2FVRHVFN2NZSVZEQjBIQ1Z6OVVBL2QycGcwcWd3STIzdXgvbElQ?=
 =?utf-8?B?RlZSOFpiQy93UzhJS1E1b3RMUzVpQzJWQ2VQUWVnSjJTSEd3U09zVXl5T0pW?=
 =?utf-8?B?cmtvdGVsVFdCSFVJK2M0cFl1SE5nMXRzREU3NkN1ZmhQRFJJZng3d1VJS0V0?=
 =?utf-8?B?aFJ1UVMvTHZlRTA5ZVRicHQ1eWdzTHI2K2JxRHZhQzJXcmtadWJTS3JhaDcx?=
 =?utf-8?B?c2QvbzBHWjJ3NHlxa0pBcGtPZjNhRll6SUpDSUN1cFVaeFdiQVZlc0szZDlh?=
 =?utf-8?B?Z3Zndm8xOWJqWFRVSjI1VWxUaWkwamVoQitibmx3a2p6ZFpreCthMG85Njhh?=
 =?utf-8?B?T3pQYy9aZDNDem8vUW9TS2VqWmhlbXV3UWpLNmVZeU5wQ0N4Nnp0cmZ1VXVG?=
 =?utf-8?B?MlBPY3VkYWFPdC9PN1FmTHBrNGFRSStpUGhlM3o0V0RTQW9nQmlPTWEyOHlJ?=
 =?utf-8?B?L3E1U2d5ODloOHZWWUNxem8wSFJUU0F0cGNxL2NmQ2ZSSE91U29WZHU3dUpU?=
 =?utf-8?B?YkpVNVZnSENTeWlLZUxWYlRIWEsxeXAva1ZmRzZ2eDZqWmUwalJPQjEwN09j?=
 =?utf-8?B?bUtSSElmUFAvSWdSMGMxYnNFOFFqZnNLVzRHbTBlQURqYzJNS2JxVDFCUDNC?=
 =?utf-8?B?MGViaUU1Q2dTdy9TdFRzYi9LbFN3bEZnOEM2UmJLeUFpVTNTZ0ExbWc1M2Jx?=
 =?utf-8?B?UTcwbFpZQ3lGS3h0eGNrcVJvVFdvZlV1ZUJnTlBxanNJVERaa25odEFKWXhj?=
 =?utf-8?B?azhJckJQU3g0cDRYd3dKNlVVV0IzNHRRZDZuWmsvbnY1RzM0ZE5lcnhaeU5s?=
 =?utf-8?B?MGhHc0pEUU1vYXgvd1lNNVB0RzRwc3B1UXdlSmZrajFVZDI5RjYrRE93K0Jt?=
 =?utf-8?B?Mnl1V1RxZDcyNDdKRUVBWVJGR2RPNzRTSENoaHN4QlZyU20xclJKTmdvbXl1?=
 =?utf-8?B?K0tlNnBpOFlqcEFOdWxQclQ0Z1NudVprUlZBT09sajVDTXg2QlRrUmlPdXla?=
 =?utf-8?B?OUhQQStPSHloYUVRMERWeURNZk1QY3RKczYyUUJvbFduNGVLR2t5bzRNOVR4?=
 =?utf-8?B?ekFYVisrZzk2bjA1d0ZIYnkzN2doejBoUU5vQm5ZWTU1TUYxUFY0SzAxRUtH?=
 =?utf-8?B?YWJNNGE0Y09kM0hpNXdqMTFuN1hIRlpuMnhNZHhOMGhuRUUrVENaOFdBa0Vn?=
 =?utf-8?B?YW90UVNYd0g1N0Q4NXN5d2RBTDFPS2k5MEdVUyt6VFhFNTZJSGJRT0E3aGJQ?=
 =?utf-8?Q?z42/PxDlglqJb?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:14.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cc4fef-39cc-400c-d142-08dced045b3c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7416

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


