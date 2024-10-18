Return-Path: <netdev+bounces-137164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67B9A49FD
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE941F24E7F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980361922E9;
	Fri, 18 Oct 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="K5DCBuaj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F671922E2
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293635; cv=fail; b=rfGsBXt67mEGvR7QhVxxYOKwY8/bIKLLGKugh4qX4aXxiV7xuySVOqKNkBJo42ZEs+TSLpU04CR+aTgVbCZ1LvOJqju0iVhzdeTgIa86n3D7I+k1hpWAOqbYPsozgNs5a/IqUJ1A9dSADKxxY8GPXroR+67KEXgOzpkYFB50YJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293635; c=relaxed/simple;
	bh=/jUnhM67qhllbqUJmPtYVGiT6TZs/a8KJ6py5OD7NWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8jnsZI4snjtJPXIdqp21tIEa6j/q2ACpFv3NfA5v6j27bxtMYQAGnajkQIwKxU3y44yjCNqfd3vjRN+mBEwszsjsu6mCOHdJCK05m7ff/cNL93t7J0NcLe62XoDBqXK+l+tqswNSyr8JLenzAMkQBx6NdtGwOBgldib2WxSNiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=K5DCBuaj; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESGxa0zpH3jfTtUYvdFkOn2wUz6IlUOzOSoQbo5FMoQ/jJRx1kwuyCCEylVGhXxWqN5iA3VS+v5wi7RRhoIRbm7cPLaXUDMqbqISoSYdiUFkF9bdMy8CW/9M0yjXZdjjhbyXASitgj8C2rFKhjS5tWE6f9fQEIdw6WbyrsRnFXyByFy9teYxqr6wK7+zXz0EjIZogLo9Vgg4FsyXhrrn8FW8JeaG6NzFkg57D873Idco16NmN2WgWR8KKsWkSbECJz0jvptsHDcD9thBuLkfAL9pErWqaGOuko2amq29Ar6P5haesTltgyMrhZmxtX1lodDOLaqWS3TkEpoNtZ4Vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06rvrvJvhApG7LYRr6bC4vZiKxPmT7OwntdkaM2HTEk=;
 b=jKRrfpcHST38ggUyq0EZNTI9KGy25ykcmz0Y4IOEW6/trDbVDksGtc2KZv7KZR3ty7MrfnQzRl/vGZvgxwBrnHKC2yj7L351KBZaH/YU628dPROhtyELc+Z5wVC5vxItHy8C5+P66pi1Cu66PtmA1+1vmPvQHsd9KhJ867oZUFvJE4PhYeSPJ+xqHli39RweLK+uLhYZEOcjXm7M22KgSGsmm+xe0+2g24Lt8ogW/7sEf3xnnarEcWS3VZp/u5XBxKAsIvKO9utlWySgKqvWSyMIEAFlvBXtLlnt/EK45E+3DPz2iKMiPIsDmv0ff9ZM7DMCPoxvpIfPINBU9X+cMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06rvrvJvhApG7LYRr6bC4vZiKxPmT7OwntdkaM2HTEk=;
 b=K5DCBuaj12av9WVV6dHiwalmYn2e2ev488x7Qe70gLS6w63IE5V61nPT9vF/sZLzuoMxaJUHYo7ZnlziELwIgP8XYgCDKSsFYr7fla6o4jfWy+ZxEAKtpw4R9POCEsgKV2jU20XL3fKiaXAo1AnC8q9OZGteLkiJwVZ2Q58GX21JIiLGMc1qJbRvVthD8AlZyQAHnIU0nKAchrVemK+XZRrIs2Y1QGO7Zw3hbuKzn23fmsdOV6kamFKWnwmkw0YlOBqnVlDs6sACVYDBUBWFq4tWXXkvF/fhlMZuLnMrdsqxPNugnhYJ/vTbpzqI1cKuo4peI3R6ctVd4fuTqKEotQ==
Received: from AM8P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::15)
 by DB9PR07MB8728.eurprd07.prod.outlook.com (2603:10a6:10:30f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 23:20:30 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::53) by AM8P190CA0010.outlook.office365.com
 (2603:10a6:20b:219::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJV010239;
	Fri, 18 Oct 2024 23:20:27 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 06/14] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
Date: Sat, 19 Oct 2024 01:20:09 +0200
Message-Id: <20241018232017.46833-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|DB9PR07MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ffa877-193e-401c-c578-08dcefcb7470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGNkeWZsM3RQa1hrc2M0cmVWTjVOMVpNOXI3UE5uSXhMOHkyOGhMb250WmNK?=
 =?utf-8?B?Y0NpMlRkRjRsT2YyRnN2eW02clFoRlNSQUhrWHlpd1l3UzFIc2lNZGYwcEpU?=
 =?utf-8?B?RDRFbG55SU9pcTJPcUE4YkdsK0hiN0hMaS9vZ1g4d0tvMGN4VG9ycHNkSThp?=
 =?utf-8?B?VGhsVW5Mck51ZHhRMHY1M0lRRGJCVzFEMTYzKzN2WDBwWmZUT2J5VkNWandi?=
 =?utf-8?B?d280ZCtBUi8rd2p5dE1PMDYvVnlTQTlvUFZDUjZMRlhGcThibHRIc2JiRGR3?=
 =?utf-8?B?cS9qRGYrdkErdkdXTHJseUIzUWpMbXQvUTJyNFhER3p0TTF1bEdOc3A1RFBr?=
 =?utf-8?B?WTZsVkgxUDBmdElIN2NRaTlZYTlMbGpkQldoSU52WkdvdCtWOUtlWExxdC80?=
 =?utf-8?B?MWVWV2dnZHNnZ3p6ckl4TnNSR0ZWM1dDY1VITjlSa0xGL2N5d1orUnRkb2d5?=
 =?utf-8?B?emppMi9sbGhFK0xnUkd4czYvR3EvN3YvY29VSHYyUDhNRmh3UkdzR2EwZTgw?=
 =?utf-8?B?NG1XVGYrNzhSRDdTS2lLMWQ4cFRPVXBvOTRzMnhtKzlCTExNNXNrOFJtSzg1?=
 =?utf-8?B?RlRMNlhxYUZVYWt0ZHl5dE8zbytoay91NlJEdk1zczlTNjNUOU92eE52R0JP?=
 =?utf-8?B?ditRVThGMHhkYlhTa2QyZlpyL1NVeUNtV2VYY3I2Qks1MlMvRVd6anNoWXNH?=
 =?utf-8?B?Q3AvTEFGeTd1dU1rc3RQZ3c2a0ZmL01TeUFPcFNmRE80RjdidEhKZHpCdUxX?=
 =?utf-8?B?ZEMwSXg5WnpCZk9sWnQ0VXMzalhWRGFXcmw3Qm52RGJuTmhkd2x1MXNNVU0v?=
 =?utf-8?B?ZkM3VERKSjRSS0pTZy9qbFFkZGxXaXl2UTNDc1d0eG9XeE96M0k4VFpkSHRl?=
 =?utf-8?B?QWFzL0NNb0RzZEpaTlEyb1NmTjFWUjJMRjRtTGh4VUFybzR6K3JHelBEcHJ5?=
 =?utf-8?B?QW5tbkduNEJqL0R5anQyc1hoQUYzUlp1V1dQRjA2OXBvZjJvMzlQVEJkeWVy?=
 =?utf-8?B?ZnNtVnpqeDBIcXVYcEJoQVYySGwwOVBjMlgxRUFNSm1ieUFtaUZUS0JaaDkr?=
 =?utf-8?B?WHc4V1lUVjhEK2NFZlJUNm8zSTVpSjAvZG9EemtEUmp2eW41a1JFSERMMS9F?=
 =?utf-8?B?MXE5dzlqb01GcHIzTk05NXRkQjh0Rm9SVkhVcDkwTnphcDlDQVJ3NmJBL1FK?=
 =?utf-8?B?VElLdStwNW4rWm42R2tzeEhiUTVuRjhKTERwQTcyTDRmUFhCRjM3VDZ1eWlS?=
 =?utf-8?B?ODg4YW92dWV2bGthS1U3L25vdkJBQWhHWGNaSVNrTGd3bzZLbmdUVXM5d3dq?=
 =?utf-8?B?L2E0cW1SS05lZjVWckRvbDdDMEFxS2RDUTBMdHlmU3JVNTdkSk1xU2pzNCsz?=
 =?utf-8?B?RmhVZ2lNMU5YQVc1R0pzR01rbDM4eFV1RXRUaUxObmhMazRkbzBjVXh1b2pR?=
 =?utf-8?B?aWV4MHo4N1ZjdEtRYkM1ckRrelJWUTZ1OEZjb3Yxb2d6d3dFQmU0VTlUWWp4?=
 =?utf-8?B?bkoyODRnU1JLV1JiSGNTamhrNjZQODloQnBrZ01NQjlKNVVTWlo4OEF5MzlF?=
 =?utf-8?B?eWR4WjBYYTE4NldCK3dTZlkwQlBnYTJFZVkzN0U5bmUwYVJLR0dLaWwzZURp?=
 =?utf-8?B?dGJ4U2VlTDRPRVUvdVdWczErT01TdjRSWVFMUEQ1RTRoVUM0Y3VZNnByMU1p?=
 =?utf-8?B?bEwyeUVVczVnRWJYV1ZPeXNyK3lnLzJDa1lzK2RPTTd5TG83eTVvaFFIbmZS?=
 =?utf-8?B?N1A5RGNZYlJIbnVBQjNmZi9URk45dFRyaGFPSVc2N3lMUS8zRi9wdmV1cGRV?=
 =?utf-8?B?akpNemJqdGF3aU95RmJoblVSWGZ2VXo5YUhkZWtXSy9yMCt0dFVZTWwyajJY?=
 =?utf-8?B?ODJBb3MzbUxYbmVZMUFNQ2g4N2VqTWd6QVVObGRIcHN0aEhhcTlpTGR0S1Iw?=
 =?utf-8?Q?5dEeb5JV5cs=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:28.9465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ffa877-193e-401c-c578-08dcefcb7470
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8728

From: Ilpo Järvinen <ij@kernel.org>

Rename tcp_ecn_check_ce to tcp_data_ecn_check as it is
called only for data segments, not for ACKs (with AccECN,
also ACKs may get ECN bits).

The extra "layer" in tcp_ecn_check_ce() function just
checks for ECN being enabled, that can be moved into
tcp_ecn_field_check rather than having the __ variant.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7b8e69ccbbb0..7b4e7ed8cc52 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -357,10 +357,13 @@ static void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
-static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
+static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	if (!(tcp_sk(sk)->ecn_flags & TCP_ECN_OK))
+		return;
+
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
 	case INET_ECN_NOT_ECT:
 		/* Funny extension: if ECT is not set on a segment,
@@ -389,12 +392,6 @@ static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static void tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
-{
-	if (tcp_sk(sk)->ecn_flags & TCP_ECN_OK)
-		__tcp_ecn_check_ce(sk, skb);
-}
-
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
 {
 	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || th->cwr))
@@ -866,7 +863,7 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 	icsk->icsk_ack.lrcvtime = now;
 	tcp_save_lrcv_flowlabel(sk, skb);
 
-	tcp_ecn_check_ce(sk, skb);
+	tcp_data_ecn_check(sk, skb);
 
 	if (skb->len >= 128)
 		tcp_grow_window(sk, skb, true);
@@ -5028,7 +5025,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 
 	tcp_save_lrcv_flowlabel(sk, skb);
-	tcp_ecn_check_ce(sk, skb);
+	tcp_data_ecn_check(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
-- 
2.34.1


