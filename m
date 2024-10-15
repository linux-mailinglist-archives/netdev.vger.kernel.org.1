Return-Path: <netdev+bounces-135550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE899E3ED
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC402823A8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57AC1E7669;
	Tue, 15 Oct 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EhXBg643"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5971EBA13
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988229; cv=fail; b=iX9U+GnguIrotxtx27gWBEtsyM5xNLnS9Ut7uYj4rIAmj7tEM6pyISw0qfsyRsAi5oshxnnmClhrhNmfdJqDqGJe3WZVg3LA2jtumSpedxFHHUVlPi7cPfSTOTGGYotxj87qOOiR6wVwAyIGY8JTlyg9aFOb/VMSlQcjmDm12p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988229; c=relaxed/simple;
	bh=ZZLBBPsXEl76UOxnvAZ1AxEbusKk9Gb/BZJI0Ei8xMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZP6yDf8mfigulaXvotuWM2Bw8nJJilgYtKFeBAzfB3c8fOLghRlVI6KXcwb7v+LL+//HuJIHYblZau0cumZsnR62HTZu9x5dkId0bVsX/3hDr4h/DhnXkdfSqeGoN/LL4tiRm0PK4O/wK5ZWo/82LYjvNec9JUz38kYeJgAjDgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EhXBg643; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayheyiWbyS8UEBP5krTBGvChFWPpDG7xSU+6beb3ZVDvlHEffc5V43rMUvM2axIAVXobtFe70UQm0vtPHsRkM/s5q+EcbTC94RwLqnJ2i+3Niwr0PpYItO+SqJuCuYTSrx4Mz+np9aypKoENey7fhO6+TRUw6+vVn6/qcgUHJmHiBUfx4qel4pKjR3Na3K+FKnsDD1tZJaOW5okWN4SlKTajxze9C7F2e4MlMvJ7ElHOBYu94cp6/olreoUffSaMfZ15tWKE8o1pAwZWpXl1czTvPemvkBdApmOkflHqKuJy7EpuJzzZFLEA6n8tNMXmRcS5G6PTs5wSk0R+RQKa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTd4kCFgA0flO2yxP58SbyTLmsBf6cIegpV9zqGv+Ho=;
 b=I2ZuS4qDWe8U8IXzh/j05EMDBVXTQiJMdC/IdGqzSxm931pouBRqZNG/1iqSbuGTVzxsSWTIp9atCnzINVmVUP0BdqqzvSK7VRqZySlM8zUizF13J2vhZq63902bfRqDdr9pOJ/vsB6bCF8KsydnDw3wrgk6r+p8K0PfTVg+xN0/pLwUqm1be1Acemh9oqw6CuaEZXTb48J8WuqRkUf9LLFl0E/BSifz2kT3xxIiQpUUxS67HDfaAWRqY5VpFYIa66BoHRoYNwGTBSA3SLlyOXFeUTVB0QTBnhKWdfIYFyVGlj+zT3JRbmyiBJYGhg/wkWvPe6pZaNwFzjXKSuxkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTd4kCFgA0flO2yxP58SbyTLmsBf6cIegpV9zqGv+Ho=;
 b=EhXBg643sQbKPrGfsLu0Est84Nl2wyaZzGZehRGM1EmVEE7YsDPwslpYVRj2LHPZT4ZvnRGSOo7aIQTU8BBEJhZi1QqOoQANrYprlAWkpwtrPUrUn6qcPzijn96Bsce45NiimmOqz7/A1yVV05TPwQVy2WAj5L6Cg6psBsgB+OmSfuVe1BKmykLk1UNrVA0SGj3zXoROZXRPpDR7UQdBfIYw8WlorsmiPC0dKuzDv3RbpE7NetoBlwRHdiHDCpP6MCXWFNvbaXxZ+h08c4/0NCl2WitZYFZbOyeU6alqbocrmZjAmTjtb7Hh4YagrWIT+6f8IoyKVGR0cyKqHY+Rdg==
Received: from DU2PR04CA0189.eurprd04.prod.outlook.com (2603:10a6:10:28d::14)
 by AS1PR07MB8615.eurprd07.prod.outlook.com (2603:10a6:20b:473::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 10:30:20 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::6c) by DU2PR04CA0189.outlook.office365.com
 (2603:10a6:10:28d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnG029578;
	Tue, 15 Oct 2024 10:30:18 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 12/44] tcp: allow ECN bits in TOS/traffic class
Date: Tue, 15 Oct 2024 12:29:08 +0200
Message-Id: <20241015102940.26157-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|AS1PR07MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 312e2f9d-a114-43fa-8afd-08dced045e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXlVaFNRZlora3Jsb3p4Q1loeDNORE5mdTFPM20xMGlVS3B1YmtWcm91Z1pT?=
 =?utf-8?B?WDM2N2VVOE5nakIvdGdEczQ4amNLamN6R3pOMjd0M0dqaGVsTTA0L0xJTzZS?=
 =?utf-8?B?QzU2TzBqS1ppYmpIMTkwaEkrR1B1a3NJRUZLUUY1cTFrWnZUbXFQRmtybWps?=
 =?utf-8?B?YlVtZ09UOXorUWxuaWJoVU1KRTBMQXNDb3k4MzZHWnpyOVpqWWc1YXFiMTA0?=
 =?utf-8?B?TVJKYnJ4aUpTQ2laNTdxWWNNNGlacnhxRXY2SEJHM3h5NTNGb2NHOE1aVlVp?=
 =?utf-8?B?TEkycFJsVjlDNmZGUmZqeWk3V3ZIMWY0akJLUStHYVpCUFZTYjM5QzdOVkFq?=
 =?utf-8?B?Zjd2dWFYblI3aW5STUl2d0hIV1lTZWxrckV6VFc2WTI0TWxBYTc3NG00QU5H?=
 =?utf-8?B?RHBXUGtlU3lZWmxPVlRhalllQUJVeStFTkQzSnpCU0h2cGcraHdEUmxNSGFx?=
 =?utf-8?B?Vm5SQkVFUnQ5MzU5eG0za0VQbWJRdXRnQW1EQmNhY1pXcCtDOFdQVVlHVjFs?=
 =?utf-8?B?bUo4RjNGZWhYWW0wSm4zRzVRUi93VkZCdW1wMUVKbW5uRFZ6bGYybTJBbmha?=
 =?utf-8?B?NG5XaW03Q25vVFRrUDdKYXhrNFhRKy9SMEI4UkxzSDZWMUVaVER4UmxGMUp6?=
 =?utf-8?B?M1JPSFJWQ01kTVRpeUNzUnJzVVJpamlhNkk4NE5vWkl2WVhlYlFYTlB6VDZR?=
 =?utf-8?B?d3JlVFpKMWlNRXB1ZnJHVUVVTjUxSThKWjBrMDkxZ05EdEp3V0lkL0lCbHFB?=
 =?utf-8?B?RG1JUjJBZEFXMjN4dFoxUHZTUXZtSlJkNVB1Qy9mbGtPQkR0cVErMXJkdTR2?=
 =?utf-8?B?NS9tRG9PSWl3SktIcjdoUDFZbG1uMmlNZlZZdzM3UFY0d1pvbmxFcHJYTnd3?=
 =?utf-8?B?aEh2R3M0WkpIZ3hldnBEbmRsaFUwY1g0VVZPb1RHY0lUUXRZK0d4UGhJMkJC?=
 =?utf-8?B?bnZDckRrblRsaTlCRzRyaTBpeEFWTjhhTW5Lc2JFMklwVTZDMmVVZFQrT1hm?=
 =?utf-8?B?RXdOLzc5b0JwSjQ3VFp6V2dZL09uSERuSzU5WStQNGsyMFNiWlFDUFVGRFM4?=
 =?utf-8?B?VWJWcEFKSVEyUkF1VTlZUzV5MEJsek53Q05Jdjg2a2tiUTZ2L0JsendqVUd5?=
 =?utf-8?B?VXBETDBFb2NsSy9DUkM2L0JlNDBSQzR5cjhjMlB5Wk5TdDN6N1YxSHo0N3h2?=
 =?utf-8?B?L3gvemdIZXVZMDVLdzFVcFRXVkppaG1mbWZlbWtHS3E1ajJ6a1hKZ3ZJSk5q?=
 =?utf-8?B?YWRxeTJiUGRZQlhtNkt0Q0xrelJsQnVXckFqZ0JHOWh4Qks2clBkN3U5ZFRZ?=
 =?utf-8?B?WElFUGdFd2NJYnd3OGVXdGt4YW5GVVlacFdDTjNDbjdMYVcyZWo0REtvaW4w?=
 =?utf-8?B?NkM0ZkF4alU0NGVJNnd2SlRyaVc2ZU5CaW5PNEVTa0NzdndHU3hmMHNJTnBT?=
 =?utf-8?B?NkNHTWx5dnRVZURUcmFhUnhpR0NqdVpFVnovODhGeTdVendZS1hvU0o1Vnh1?=
 =?utf-8?B?MGR3Q2M4UU84NDZjdkw5TG9lWnJFV2Rya25NVG1kV0dhN29aTGszMzRoaXFi?=
 =?utf-8?B?a3ZoamZpeFQzM3gvVnJYalhzOFZFQks5YkI5VjRRTTlCR2dXMHYyUFpZSHQ3?=
 =?utf-8?B?alFwdERibGtrM0pZWXVwQ1dtM2N6MXQxUktoUW5QbTl2ekQrb1g3VytuR1hX?=
 =?utf-8?B?ZjRuNXltOGRSSkVYSnlKOWk5MjEvTWk3N2kvcExVdGJFeFI2eXNQZjFQQk5M?=
 =?utf-8?B?bjNsM1pvS3RlNmpUQW43L2loN2gxQVovb243V0t6Mnc4aHhXdlZ1OFVzUU9T?=
 =?utf-8?B?TzFXNW5zTG0zS1FQQjdxaHJLdmNPWmg4NUZYcFhuODRFRXJYK1pnVkpTd1ZO?=
 =?utf-8?Q?Z46XuaYyiHlZI?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:19.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312e2f9d-a114-43fa-8afd-08dced045e67
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8615

From: Ilpo Järvinen <ij@kernel.org>

AccECN connection's last ACK cannot retain ECT(1) as the bits
are always cleared causing the packet to switch into another
service queue.

This effectively adds a finer-grained filtering for ECN bits
so that acceptable TW ACKs can retain the bits.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        |  3 ++-
 net/ipv4/ip_output.c     |  3 +--
 net/ipv4/tcp_ipv4.c      | 23 +++++++++++++++++------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      | 23 ++++++++++++++++-------
 5 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ae3f900f17c1..fe8ecaa4f71c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -417,7 +417,8 @@ enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
 	TCP_TW_ACK = 2,
-	TCP_TW_SYN = 3
+	TCP_TW_SYN = 3,
+	TCP_TW_ACK_OOW = 4
 };
 
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c94..2fe7b1df3b90 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -75,7 +75,6 @@
 #include <net/checksum.h>
 #include <net/gso.h>
 #include <net/inetpeer.h>
-#include <net/inet_ecn.h>
 #include <net/lwtunnel.h>
 #include <net/inet_dscp.h>
 #include <linux/bpf-cgroup.h>
@@ -1643,7 +1642,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 	if (IS_ERR(rt))
 		return;
 
-	inet_sk(sk)->tos = arg->tos & ~INET_ECN_MASK;
+	inet_sk(sk)->tos = arg->tos;
 
 	sk->sk_protocol = ip_hdr(skb)->protocol;
 	sk->sk_bound_dev_if = arg->bound_dev_if;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d5aa248125f5..9419e7b492fc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -66,6 +66,7 @@
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/timewait_sock.h>
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
@@ -887,7 +888,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
 
-	arg.tos = ip_hdr(skb)->tos;
+	arg.tos = ip_hdr(skb)->tos & ~INET_ECN_MASK;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
 	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
@@ -1033,11 +1034,17 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	local_bh_enable();
 }
 
-static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
 	struct tcp_key key = {};
+	u8 tos = tw->tw_tos;
+
+	if (tw_status == TCP_TW_ACK_OOW)
+		tos &= ~INET_ECN_MASK;
+
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1080,7 +1087,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			READ_ONCE(tcptw->tw_ts_recent),
 			tw->tw_bound_dev_if, &key,
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			tw->tw_tos,
+			tos,
 			tw->tw_txhash);
 
 	inet_twsk_put(tw);
@@ -1157,7 +1164,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			READ_ONCE(req->ts_recent),
 			0, &key,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos,
+			ip_hdr(skb)->tos & ~INET_ECN_MASK,
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
 		kfree(key.traffic_key);
@@ -2177,6 +2184,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 int tcp_v4_rcv(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
+	enum tcp_tw_status tw_status;
 	enum skb_drop_reason drop_reason;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
@@ -2404,7 +2412,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;
 	}
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
 							net->ipv4.tcp_death_row.hashinfo,
@@ -2425,7 +2435,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v4_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v4_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd6515ab660f..8fb9f550fdeb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -44,7 +44,7 @@ tcp_timewait_check_oow_rate_limit(struct inet_timewait_sock *tw,
 		/* Send ACK. Note, we do not put the bucket,
 		 * it will be released by caller.
 		 */
-		return TCP_TW_ACK;
+		return TCP_TW_ACK_OOW;
 	}
 
 	/* We are rate-limiting, so just release the tw sock and drop skb. */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 252d3dac3a09..d9551c9cd562 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -997,7 +997,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (!IS_ERR(dst)) {
 		skb_dst_set(buff, dst);
 		ip6_xmit(ctl_sk, buff, &fl6, fl6.flowi6_mark, NULL,
-			 tclass & ~INET_ECN_MASK, priority);
+			 tclass, priority);
 		TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 		if (rst)
 			TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
@@ -1133,7 +1133,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
-			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
+			     ipv6_get_dsfield(ipv6h) & ~INET_ECN_MASK,
+			     label, priority, txhash,
 			     &key);
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
@@ -1153,11 +1154,16 @@ static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			     tclass, label, priority, txhash, key);
 }
 
-static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
 	struct tcp_key key = {};
+	u8 tclass = tw->tw_tclass;
+
+	if (tw_status == TCP_TW_ACK_OOW)
+		tclass &= ~INET_ECN_MASK;
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1201,7 +1207,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
 			READ_ONCE(tcptw->tw_ts_recent), tw->tw_bound_dev_if,
-			&key, tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel),
+			&key, tclass, cpu_to_be32(tw->tw_flowlabel),
 			tw->tw_priority, tw->tw_txhash);
 
 #ifdef CONFIG_TCP_AO
@@ -1278,7 +1284,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
-			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
+			&key, ipv6_get_dsfield(ipv6_hdr(skb)) & ~INET_ECN_MASK, 0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
@@ -1747,6 +1753,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
+	enum tcp_tw_status tw_status;
 	enum skb_drop_reason drop_reason;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
@@ -1968,7 +1975,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN:
 	{
 		struct sock *sk2;
@@ -1993,7 +2001,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v6_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v6_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
-- 
2.34.1


