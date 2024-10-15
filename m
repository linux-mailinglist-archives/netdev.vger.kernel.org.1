Return-Path: <netdev+bounces-135539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB03499E3E1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBDA1F239BD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910461E571A;
	Tue, 15 Oct 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="o465QmFY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79D14A4FB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988221; cv=fail; b=u4aQ/3lQDv9twZ3Ke2H6K8KVWZjB5vIj63NkUMEYhSS9z7S2dH8Mk1yfHh52SS1Ap6IuIV+x3ohaNM3koF/94Nzs7DvOKi1dk64hqzwiHFvDz6RiC9NGuT0cVdBHAtk+tlMu6UnkYlsZ7An5kPsTrMe0MNNa4mH4l2iDjyAYjFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988221; c=relaxed/simple;
	bh=/jUnhM67qhllbqUJmPtYVGiT6TZs/a8KJ6py5OD7NWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNNkPGEZIU9JEgTzZJ/mYXCNNtqXe9nL8hPcZztY12oEvX/asdpc/JalL5AWoWNuhfzgalBaWVbRp8uJWFajJdb6aDx30Q81LIJJ6nA73Csk+pXXByzX9NLixdFGM0P0hliwfvAzb/3nrNoWKczzEcXr+IH7+Yut4sFoT67VvmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=o465QmFY; arc=fail smtp.client-ip=40.107.249.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTZC/PboojFqKC2cb0fTfMdmXBY4+ZOICCX06GQjXsW6JMW610/mLvZDGe+b3IgolNSYp2k3980mYsPdWo0Utt91M5Xg7KKb+wEL60PAm/ICV6SvDPdXv+VbguxoLHt5ScR2vbxodyDo3WB+7a9+QjwDcXrlUNmgp3Be0QxY6PK3xuRZRpHB6A5nrSpcUvCr4hbfR0sbD9qeQcsy9NjTDhXKkES8WR1XtVMBDwJGG3zbAm0gWqvPaUaVOsHQubyxx/rj9E1vUT55kxyoBtIWvQ5/SQcAlTeP9VUToyic4+1Ul4rrinL8wLpipG9mZSzQ3zstqZQPyjhgJNcnqtw5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06rvrvJvhApG7LYRr6bC4vZiKxPmT7OwntdkaM2HTEk=;
 b=x6hoIsBSdIc/qXEP1kXALTWXVslw8asUW4uWUMmrAkqMiyHeWDC4k0tUh2mGOcj2FgX0k3zQO8aLpF6DRxMvWYo+Y3f/qrKZMXZpbxlcpVeUq6nanu2QEHVvgAj5HEkRZqNSahTLlKpjT/awVdmpYfCXbxwuEzGko+numinlZvEr5r/6I3GK4bqgk1sJYncsCEtMw0CTL5AKoeO6ZCITL1f6+cIEf9ezvrs/N2PU0iwl8UmLkyhVG/tHvLm/Sq2X4b/4Puw59V0FcEEyToNb/gcsnwjQlISph64pFG57JrlwxwZDUhLb3x6hnz67Bx3ODXfhEF7hThEP3CVevqcDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06rvrvJvhApG7LYRr6bC4vZiKxPmT7OwntdkaM2HTEk=;
 b=o465QmFYD/MF0qs90kS8+uBhYCzbzJ5Uf3QD9cqJuNhuRGmZEjfv6UkEIaopca6y6Dsf51wTPiLSL3haTaB5y3hIypCyb98H5C4h+Mn4rANb10T86rL4XrclsQB9ed6ZFYSBphrUIXdsXkKYzQgH1X9bBU4Wk40NvPPONskyv5XkNhfKb5E2Noj1F3kqHhfZY6XNJ4NUwG+XuXjdgKmRiwIGE1mmPuAV35dFePYjNv1HCjiwx4CjyT5PjrVzdOooShvhmXeZg1iG3c9ThoBekrZ1ZVRHNk3GVlYFv6QbBxTfAsbh72WJVOeuo9bFeCjF13Kcab+qNdWIxWuvrCHlJQ==
Received: from AS9PR0301CA0008.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::17) by AS8PR07MB9398.eurprd07.prod.outlook.com
 (2603:10a6:20b:635::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:17 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:468:cafe::92) by AS9PR0301CA0008.outlook.office365.com
 (2603:10a6:20b:468::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:17 +0000
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
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnB029578;
	Tue, 15 Oct 2024 10:30:15 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 07/44] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
Date: Tue, 15 Oct 2024 12:29:03 +0200
Message-Id: <20241015102940.26157-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AS8PR07MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 045b047a-e91d-4a14-0634-08dced045c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0wvTzJDdG10Q2lkQkh4WU5wWkRMZVpUTTVFY3FzRkVyM0REbTk2djd4MWc0?=
 =?utf-8?B?L2loS1g1TU1Vc2RFR0JSSzd0cjdPVEFFZk5qeExDakh4TEFrNzFhN1VZQTdq?=
 =?utf-8?B?OUY2RFF6UmJZbGRpeWF5cVZCZ3ZVV09qNXVwMVZMYys0R2dPM0V5czhiWG9w?=
 =?utf-8?B?ZlBZRzR6cEdHQ2xNSlRqem5TYlpzajllN1BmK3BCako1bzdjQXlyOUFCaDNP?=
 =?utf-8?B?NXUzcGFQM0dKb1AwK0tIYWFIbklmWGdmVWF1U3dpUjlmOU5KY1lmR2UrTW92?=
 =?utf-8?B?UndaTzlyNmhUbjgyMklmK2gxc2lXZEZMUUx5OVB5ZW9uZHpENXVIUDIzMUtZ?=
 =?utf-8?B?T3VpOTRDZHNTSk9UZlRwUExTOWF1UDlaeDlub1pHbE0xblN6RVM0R20wREQx?=
 =?utf-8?B?S0ttWWxVMENoVmEyR21KcTMxSzRHK0Jqb2RpKzl4bGpwbHI2KzFYalJmaUFC?=
 =?utf-8?B?SXFnN1g5cW1hRXRTUGhFQUhzbjlselkzKy9yTjR6Ny8wSGVIU2RDRU9zaXRy?=
 =?utf-8?B?dkZMQ01kQWp1ek1LREhiMHJDbnY2NnlYdGV3S2tWdnc0N3lrQXJvNHBORDhI?=
 =?utf-8?B?N1ROZ1hHc2dQRmF0a2lML1c0eTZIM3lvS0xLK0FTRmVmaUZET0x1alZrMEJx?=
 =?utf-8?B?clpYYVZEL0VxNElrTkdpeFBmY3hNQ3VaWDNaQnhnb0FVV3AzdzdLTms4K2xT?=
 =?utf-8?B?VENLYllqYlBDbFhTZ0U0TnpyeFlmVXRDbk1ha2pnZ09hRFNYNlNKUVFxNElG?=
 =?utf-8?B?ZkZpKzdTZklZZ3Bpdy9DUzFSZGkyME41d0FTNjIxU092ZFFDTFVhcGpZZnJS?=
 =?utf-8?B?WDBVeHN0b08zTi9ZRG5mRUNKa2Vnc3plMzJLeFNlbHVUSWtBVzN6a1RyVGZo?=
 =?utf-8?B?RUN4UUhkcEhrNkhOWFpwSEZZZ3dXa2JiUThaV3ZQZ3FYTzVna2pDYk9nbHdW?=
 =?utf-8?B?aHNGK3pzdll5NGZXVTc3cFYvcXdObm8wVWh5NU4yZUhPbTBQT0ZrQi8xMmQ3?=
 =?utf-8?B?QU1WeEMvbG1xdmcyZmNwQTA3L2dvYzRrZ2NEZk1RTnZMZWg2dThxWjBnWjdl?=
 =?utf-8?B?WE9VRmh4Ti81dlhLNnhVQWtoU00zWXV0ZEcvYjhIQ0Z0ZE5lTzhkWjllcEJp?=
 =?utf-8?B?a2Z3VGJ1WnRFbkJMeUF4YUFxOWVYOEozZXRnOEhWSFNxWFVGSEVJY00zWmsx?=
 =?utf-8?B?YlJOMDNrbmltY3BueldaRExxSVFsQ01mY1VrRDh4TzRhSFJ5Y1lRMTdBR05S?=
 =?utf-8?B?Qld5c0x4MW9aZzRhZldwZHFhOUFkam4zZ3lxbWVlK3NQT3U2MjZuM0JuWXVP?=
 =?utf-8?B?MTJwU1hVcWEvLzB2MktlNjFSNThMenNxZzhDdGkxWE8rZmRMRGtmS3ZoZkda?=
 =?utf-8?B?UTVSY3YxWjYvejJ1L21rUUhCNEpteVAwWFI2dW9XWGZuQjlPR2Q0QmhzRUs4?=
 =?utf-8?B?eFhrNVlUMFAxWkV1OUJqNDdUYjNRRm5HZzI5cm40UEVha05hZmJOR1JDelp6?=
 =?utf-8?B?ZXVPZHBkMkhMYnhSbXpjOXZkeHE4RFBsU2JrTWk2ZXhrdkVHc1VKM1cydk95?=
 =?utf-8?B?aElPWVI1T3hHL3FtMFpsa2pMWjhvRW5Nb0lMU3VQcFdVUjV5aE1TNnNIdzFM?=
 =?utf-8?B?cUFGZEZMZ1M2M3luVzhSVUsyK1VocUlxQjdURTVSQ1JIQ2xoSWRVYVZLNFRo?=
 =?utf-8?B?UEZvcmVRU1dqWlBVTWtxZVo3bVpma0FSSTUzSTIwdmZIK09Bc3JHWFdxM0hm?=
 =?utf-8?B?UllCRHlOempPb0RJV0tSUDdZYzhvYVBNNklDaWRWRlpBQjdmOHprZXU5dlJH?=
 =?utf-8?B?d2R2Q3RENSt4WjVQdml1TmxnRUpsdTNaQXFmZmpaNFpSeTE0cDFsVjhIenF1?=
 =?utf-8?Q?UHEFN5gZJu6Gt?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:16.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045b047a-e91d-4a14-0634-08dced045c92
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9398

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


