Return-Path: <netdev+bounces-136818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B466D9A32A5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7319B2854D5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4F165EFC;
	Fri, 18 Oct 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SK8GvZHS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8C156242
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218113; cv=fail; b=Z1hOKGUi1j1Z147ZU0534y3xHC/i8Uc0ZF6UOmAZ8Xl7hJoMBLVgfbpAO+YFbnOkBOARKeIPe1cI0MA57Pu6nccYjdaR1eJXn6JQXq60UpevmKvkufRzMRg1fA6EiQu4XJqb9f0ivvnVxpQS8Og3tJjODWYhxvEsWl5cOL2cw5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218113; c=relaxed/simple;
	bh=/jUnhM67qhllbqUJmPtYVGiT6TZs/a8KJ6py5OD7NWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGGvtX7sF4FmcSgLCc1wW/D2c6QbT6OIo5+3t4ue4T3G9jBYgHjmycV1fqq2JMG3XF1Z/rJDnknL4Xo9HQVbm+r1NEK8QrUN8lxBv8Hg+vVge6alj/g5O8zjUh8QEsL290oWfa+PpENPUGS+9j20pM0wT3X1Up7Ei7SczfFNpWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SK8GvZHS; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFUo9qYdY8OdU+SjsKojbPr+rNwu1pm7oC6avni4/jL6ZNmqW77nCgWiQPVyWDdAjqedVPCcyZARpZmK7GEsdwrdH8b8WC1IU+PrsXa+MNYKAsuZLs1uCtCWVfn/Sp4d7lsfmodX4rkg+OOKX2Dhdewxlz2dKch7kVx81ZyR2B5osY5dQNBUFbrX8F+q7+rUqkFSuNcrSzxDnbEzZbI/tyz5ORfDr1TmFpeo8qOTqW4qm83FBnqA3IptNwtmkq6YOYCOz75D2EpGqRIwGLGSeBcu5amrrHnkKkpa0va+m0ox9gY+j3uM8dZ423Ol/hvm/zJ+th25iWYiE4xPF+g/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06rvrvJvhApG7LYRr6bC4vZiKxPmT7OwntdkaM2HTEk=;
 b=VKrlUAaNW/BJSyUgbZx2xSSOsaW33/vrd7FWpiZ7F3cnXiK0nwTuv0IhcPMHenYINc3tF9OsHkWcfmVGW+/XFix10lGWNexdom6EjUHgfP1zYKSp44HutYOMhPNJRnrKmYTiCQJuoyjpJTbRG1Mqdb4BPe+QUfG7f6pBvoZh1snGqH1syiOB4TKJs/MHmzXLp1/7jclZYUvqQRlWEZLDatdSOt6jrr6eiF5VuOQ7jTCi6FP3Wnr21FPrhiI09shaPNq4fdhPZfE3CsUSMoLcdK9dwjJoGkcUUHUPIUjrQauaV3/X6Et5XkbMbGT9D6Z1VChz89gxnNP1xKWNm8Iklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06rvrvJvhApG7LYRr6bC4vZiKxPmT7OwntdkaM2HTEk=;
 b=SK8GvZHSeAfcOfRCjaB4af+0QeZL7zyZI/+tMO6eGQE7zLs5V3pA8d9Qfq5eD7ZsmGgr1aOYBoOVq0m7hGbW8b9vt2kK9H3s4ZZ2rhC5Cc5fX4SRtubtcDUK50xQip38LKs0GJ/9uBBvPVAMCwXV3YoHu8vlXI4JrMe/ZZMAEZEtIRSmUJKz+PZlnD4PnTZo6U+lRUgRHgkrzrs4fi+FHSDe/tzMafsUo7M21TpVgh3YBn2v5CoX07cqCL4R0mUbRvj2sNcHYqRTSHceM6tESXpZpoxsaGaILju9vd9VQpUb6A5MEFVCe4MbJewJbRQ0Cjk4Z7IOy4k0D6Xu/+FQvw==
Received: from DU2PR04CA0350.eurprd04.prod.outlook.com (2603:10a6:10:2b4::22)
 by PAWPR07MB9877.eurprd07.prod.outlook.com (2603:10a6:102:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 02:21:47 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::d8) by DU2PR04CA0350.outlook.office365.com
 (2603:10a6:10:2b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Ma023685;
	Fri, 18 Oct 2024 02:21:44 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 06/14] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
Date: Fri, 18 Oct 2024 04:20:43 +0200
Message-Id: <20241018022051.39966-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|PAWPR07MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c05696-c50c-4722-b52a-08dcef1b9d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmtSQ0lSb0ZQVzlpNUZ2NmVRZXFpcnJENVc3RnpYeUlablVUcjJQN1h5Z2Ez?=
 =?utf-8?B?OXZjVFpDeVY2L3F2YThiQzVnajNnYmg4UVdzSHpUUk9sWHduVllVNkZpbTRZ?=
 =?utf-8?B?ZDM5K2lETlhXR0VKWCtsbTRDS1c5TERyeDhab0VsUFdjOUtzTkt3bU1scWsx?=
 =?utf-8?B?K3VvbkVDZ0c0RG8xUzdSOHBSRWRaYWhZY2c0TnE0T0tYcWFCT3I1dkZqNldR?=
 =?utf-8?B?Z3I4YTNkdm55SkxaZEpBY2lkN25vL2xWUXdGMEFPU3lmU2JGeWxOMmlPNGNK?=
 =?utf-8?B?ZXM1TjRFVjVLRk9EYnlNRGlIZ240ZzR1QWlNTTJ3UkE4Tktaa1NRVmVHOWRG?=
 =?utf-8?B?U0tCWWpJRkExS093MW5ZOFN5ckFmWElYRjJ4cUl0T1ZCblBjTS9EdTgvQVh5?=
 =?utf-8?B?VCtZeVUyeXhYckZUb0xHYlVSTW9wU2loY0V6YWdxTXhRL1RZd0pLQTlCYW0x?=
 =?utf-8?B?d3ordGFRSForSW15eDM0V2dYMzJwcmFsSTFuS3hWOXBhUm15WXBWNzkxTUU3?=
 =?utf-8?B?NXVjdnVGQTZ5RnZJVlU0N3V0R21HTEVEMyswK0pML2xSU3NUUnpFMGliUHJa?=
 =?utf-8?B?T0ZnK0JxM29ibUlXcFFJYlhkdVpBcld3aG9SOURxWFJUZlhKeW96dkMvSE4v?=
 =?utf-8?B?OXpXM0NVUTc5MklXbzdGSzV2d2Y3U0hnTm9EVjRGK3BDZVZGMkJ1d1FqOTdH?=
 =?utf-8?B?TStHcnJ1LzE4V0d2QWRwU1BaaHI0Qm9BUGRTMGZwb2lGVXNUZ1lJSCtTUEow?=
 =?utf-8?B?cytpekZTSnZPT1FleHZKVUQ5TllqSVI1Y2lCWnF6ODBaS1ArM3Q4dG5BZU1Y?=
 =?utf-8?B?cDcxdktkUHhpVkh0VFE1Qk55WGMxR3FoUFo4dkFTbkQ5MXg1NlFwbWw3WWI1?=
 =?utf-8?B?dmp1dE45MkVTbGtheEx6NzFhc1pYYjlVUUhhTnEwRWdPMEFCcWJCWHJ6TDYr?=
 =?utf-8?B?TFhQc1h4NzUxMURIaHp3MlJBREVqU0NFaDFBenBLbkZuVjk0SHhjWkRVRXFk?=
 =?utf-8?B?QWE3ekIvWkVnN2xDejAyUnozQ2k5ZnVSREc4Sk9YZlNiMEhCaExveHl1Vncr?=
 =?utf-8?B?bGRkdzl5akozaUFjajdoTjI4N1JqcjlZeURGOTUycWVKWW9nWVFZbGVxbXZk?=
 =?utf-8?B?Q0F6RHcrQ3hpdHgrcERpYnY3UE1TOEZhSktKYUMyVkZwb2t2T1JxQTVuOGtP?=
 =?utf-8?B?ekdLT0lDZEFjQ0oyU3dUUFMyTGtDZTd0OXpQZXFQN1kzVW5oakZZUVVyLzR5?=
 =?utf-8?B?cE1Cb3ZCdzY4bHNzQzBXUEwwdG1aRGVpVzA4cVFkRWFlU1ZZTm5JQ0xYdGxH?=
 =?utf-8?B?d1FBbzJQWHl2MW5jY1JHalhTZTdYWmY2T0pqNjBKUVgwQUhsdURNdWhBT0tC?=
 =?utf-8?B?aCtvWDczZUNwYmlWNng3bU5hRk05VENWZ1VZcWs0aGlUaytacmhZRWcrMW1Q?=
 =?utf-8?B?NHNHdDc0Z0d4SEpIcDJYeUhqTGxySDRtQjdrWnlsSC96MFZDVk9OQ2NKYUxK?=
 =?utf-8?B?aU92bWU0UVBMVnhXRGJyZ1hEdFdHYmQ1aG9uaGtZYTFDbzc0MFE2eVZWY3N4?=
 =?utf-8?B?ZzlrS2RtN2RaajBKT05kSGVmY2FZQVluSHdWS1A3aXRRMHU0VkZoMWxhWG1m?=
 =?utf-8?B?QlBhUEZYNlMwTlNTRzJwQzVhZ0pyWnA5b0s2V0NBVDVBM29TQStycmY0M3lO?=
 =?utf-8?B?d3gzMENxR3JmTDZ0SFU1U08yVEpYcGRTTkQrTFJUMVM2S3had0VRSWlXNk5k?=
 =?utf-8?B?RkQzODZ6RkI2U29ZMUFXQ3ZNeXJtV1JBVXlleFVQcTlEYnhtNEIvOVd1cGxx?=
 =?utf-8?B?RHhzRWFSS3FCQWgwK2hoeFlEa29DVnZhdjRQay9yMDhuRUR6bGpZNWx2RHhz?=
 =?utf-8?B?WmZHVnNFT0JFVUpSSS8vSjNqM3RoUUtuUGppQUFmRGtmdE9ZQWVneE5kcHJY?=
 =?utf-8?Q?KUFI1SJSVUs=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:46.0738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c05696-c50c-4722-b52a-08dcef1b9d51
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9877

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


