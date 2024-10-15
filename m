Return-Path: <netdev+bounces-135552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7595E99E3EE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B57C2817D0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B931EC00D;
	Tue, 15 Oct 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="h3wSWF/Z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809511E885A
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988230; cv=fail; b=Ev38wE5ZRAaMv8vUfycdPxPIwYKj7tzYebioDrUTtqkxCcOPfjSTzZMZcmgZ9JRYt1+8VHDMc8tYERk5ut6dUFZ02Oxh2K1906lA9cd4bAl0/2ar5P7QQd6NatP5KvVjWHbmrOw4mG+U0uaqrp7tQcJvstRL6blCBEj+gfeGbvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988230; c=relaxed/simple;
	bh=jfp/lpTJreumgN0cdPxbzSLdKDeZv/kwkFPOIwuOVxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8dtBW5B/74Ole5n3CSIpECALYJ9zlJCNggE5Y3ibv/Zs4QkhJnpYAxDtKyFa5K9l2OZdufKhev+i08A5fQrZDrqd3v/6NVSIPazpUNsmDyjOxA/ffMDtgI3WpguCJZzgbylOOYRDNtbS49zZgmDWPehjTZD31YpzS38q6gpTwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=h3wSWF/Z; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clcm0PfYvhqVbos1tMHN98UJOur1OWAzNKZPWa986slrhjDVkPyXP8pKwqNHPqAx9+fhAPvKWsDs+4Gf2sYWdTO5HcY/yb7Aw6nlLBn58MsTM1twiRalImP7I9SxLpLgz1v9FKNqaGfiI4mvem44JJEKXpVuW+BrgNYn5ANKwJzkEcX+2+s8gcsOxI6q7GrlvbAhxjrWdqVLN4aQXlW1M26QXfMcZzAGDtUUQ/jPkPJSGXIQrPlWg+T1ojA6mFgpnwxWz5LYbDVy3NdwT1+XnlQNQlaWdZefYgMVCruw3+4ozYEek/oc5svzxkhvwU6THY968hyhOEH3BmUsh80dkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMJCZI5dKZUMAGkrvczb/vE8fOfOk2YoOdm8k1fKtfM=;
 b=yFBN4CLdglGNsfnd1IALx63iV4RChg8wL9QdXc0E1AS69kxiBweHJCr2pDn7nWRIikXla830sBp+s0Ij0KeQpfoVw8UsZUPKAOFdkCupyJz2m4g+o9nswHr9u0XsiHWynVA58h4LYEWJz55KP+Pnjc7T+TOxzXV5kiawX1FK6R/7wuHnE7bTYhATF+fptYGn+UBIROQVQRz8i+09GxAbsCiqZ+kQ7jymFx6QBnijnBeCvkdO1dZpX+ttuuQIU2BiuQfb/Hfdooa55FRzgtMdHJ2Gxp1zB2XpZadm07EaUk3W0X3bq6zbx/nfg12OHr5OrElJkhxkzM0KhhNK+ToI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMJCZI5dKZUMAGkrvczb/vE8fOfOk2YoOdm8k1fKtfM=;
 b=h3wSWF/Zllz+FSP/4BtCXqXq6fT5MVpzEM3nxgWmG+px/czifl9iQ126NbG9k7iE4qJC1lD4LBNZ8itJYV2JHK2/CyVKhf+T4BG9dga3qot6rYXJrWTicbepzvZa1YDbU6d07X5Q1nASID0T17lsWAqes6HemjbK40SlaOl8ocjbSUHBK75LlQyXEca8RYX0SmcDb/Ccp1GKlUyf2cl6MawhpMKzX30nEkbYYd7jMKR/3a2v6pvMBM4s2fybX8UIDS47YIh23pB8oYpukOlFoFiAljKTbduPzoSHirSz+2S5PIA+i9GrEP72aNrJ2DQoWgTOo9W5O5QoEgvAFGutKA==
Received: from DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) by DB9PR07MB8026.eurprd07.prod.outlook.com
 (2603:10a6:10:2ae::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:24 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::f2) by DUZPR01CA0306.outlook.office365.com
 (2603:10a6:10:4b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnN029578;
	Tue, 15 Oct 2024 10:30:22 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 19/44] tcp: allow embedding leftover into option padding
Date: Tue, 15 Oct 2024 12:29:15 +0200
Message-Id: <20241015102940.26157-20-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|DB9PR07MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: de79cb3c-6564-4e80-0771-08dced0460d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE4rUythdFg0MWw2WVNVakJ5aWpldGJCMmJPTGJtRk4zVEJZZVVxbkZLcm5V?=
 =?utf-8?B?TGtXNGJLVzIzL2pxZGRvSnNzRXlKUDZCRnZvYnJKYkZBam1ncStuckpjLzVJ?=
 =?utf-8?B?eWJYSUF5K0VVMW5obDV0OXFJWldrM1QxTGxRbFdPVSs1K2wwZjV0N1d6a29m?=
 =?utf-8?B?SGphRC9OUDMvQzErcTNKbi8wd3lnalVEZ3lqaXY1UDk2L2IwazhtK2RKalNX?=
 =?utf-8?B?d2dBa1drcTZDZDRQOW9CL2pvUWZuYStDejJPcnZTL1JnbWR5UWUxUVF2SDN2?=
 =?utf-8?B?VE81K1NpM0F1anJaTjRLQ0hhTVdxN2VMLytlNVZwN1VYbWFjOTBBdFR5aUVL?=
 =?utf-8?B?K2psQjdFNDBtaHl0NWVBSnh5TktJV3lRcDdEcFR6OXN4Rmltdm5hK1M3VnBl?=
 =?utf-8?B?NDkyWi9USzA4aEUwRjlpQUpjTGVybGlMVWczaGZpYmNZdGpIT0dtYkEyVHdR?=
 =?utf-8?B?dGhBcy8wSEZ3UXdUa2IvV1VUVTdxam8rSHIrcDZHWmovS1lFS1FyZkRZNG1Q?=
 =?utf-8?B?ODBlUm90SlE5eTcxSHpic3dNVDZxeWhteDZjVDVkV1hEMXNKcU5PbkpNbTNM?=
 =?utf-8?B?UmpsSVpwMEp5eHRMN254SUlPbHpQUldtcUdHUCs1SnpjcTdnQnN0ZUJpTWFK?=
 =?utf-8?B?WXRzek1jOTE0U2hpdlFwb01GajB5TWJFdGZBOHVPV1RIRy9mM2pHVFgxUldu?=
 =?utf-8?B?eklQTEM5bS9RMDliTnhRaXlCK0NuZG0vV2JhM1RKTFNuQWZUQnl2eHFISjc5?=
 =?utf-8?B?MXN3UzVDUFB3VzVpRjJHU21xdXNBSUE2ME5kZUE4akFMdWdISGM4UXo1eWM1?=
 =?utf-8?B?SHRCQVJzRXNxSTFJRElzQVhFOHdGQ1hBdFlOMjV3V0xXTzZWRkI4N3dQRll0?=
 =?utf-8?B?RFo3RVRvZHQ3b01qU21GNjZiSEwxS0FXSi9pbVoycEhaRUkybkxyY0FCbmZz?=
 =?utf-8?B?a2N1TW5mWUJoQk1xczZVL0dzU1hYSys5K1VvRlRqMTA2aWQyVG1LRDIzMWgz?=
 =?utf-8?B?bGxQeVlDQjgxVEd3NzBVdmZ5K2RqTkVWTGNuZVJsMmcvcjFlNHJtUFdSVTVL?=
 =?utf-8?B?NDJNVTN5TE9uVzlOM3hXbkxSUTJhUGY1SFNsaWoxWWg0QkY2REZ6bzRTSy9h?=
 =?utf-8?B?NmYvMWprdmgwSnFpWWdlZ0g0VVR5eFo0SndOZlFGWUE3NkNKa1Q1dFlyTDhT?=
 =?utf-8?B?UEp3WHRDT1RIN0MwRDJ0cWNGME1RV3BrMTJ3T1BKdURkVU5nc2JpVHFtZDkx?=
 =?utf-8?B?NE1obDlKZmg1NUxydFlQQXJzWnByZElHN3pHR3Q2Vm1sMHhGWDlWMVRjMEJH?=
 =?utf-8?B?aStUZE1vcnlmbFpKTjhEWjB0L001UTJ3Z1IvWVJJM3RGR1FWUTJwdVJNcEow?=
 =?utf-8?B?cktLdDVyekMrZ0hGNE1US2VkZVBtdE1DSlZ6ZTZPbjFUVUJINzI1SFdsZ2V0?=
 =?utf-8?B?VTBqZlF0VVZOMm01ZURBVjhMY1Z0QmJvaUNmMndLcHV3ZmtFUFlQbEpwbnU0?=
 =?utf-8?B?cDYvVGlpZEFmTmQ5UVYwS3Y2TDVjWld4ZnZxdi9USEI5K2dYR1FiNllCak1s?=
 =?utf-8?B?dnlzTklMMVhUQUVVV2ZycDFqSnY2VkpwQ3V3ZHNVUVZvUjlXQ29xOHo0N21N?=
 =?utf-8?B?bWtJYVlvMjRWUXR6SlFkSjB2ZE03L2VCN3c0VXlhNlEvN0hOTHZSRmNvUXFh?=
 =?utf-8?B?RnhxUHBuRVNTSkNrSWJLZElPNmQ5Y3Z2ZGJzdDBHZUZTaWJqc1NSZHJSM0pX?=
 =?utf-8?B?TTR4M0srWStqL2xLZjBlN1dDd1R3MkV6UjNHYjRiZDlibkszdnREK3RUdVF0?=
 =?utf-8?B?a29EOVZJcm95L2FRanJ6ZzZIcGhjSEx1TTdVUXIxOGtOcXhSM3JKWXdUdlVY?=
 =?utf-8?Q?aba16zbTrphjC?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:23.8078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de79cb3c-6564-4e80-0771-08dced0460d2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8026

From: Ilpo Järvinen <ij@kernel.org>

There is some waste space in the option usage due to padding
of 32-bit fields. AccECN option can take advantage of those
few bytes as its tail is often consuming just a few odd bytes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ebda1b71d489..becaf0e2ffce 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -703,6 +703,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
 	return ptr;
 }
 
+#define NOP_LEFTOVER   ((TCPOPT_NOP << 8) | TCPOPT_NOP)
+
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -722,7 +724,9 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			      struct tcp_key *key)
 {
 	__be32 *ptr = (__be32 *)(th + 1);
+	u16 leftover_bytes = NOP_LEFTOVER;	/* replace next NOPs if avail */
 	u16 options = opts->options;	/* mungable copy */
+	int leftover_size = 2;
 
 	if (tcp_key_is_md5(key)) {
 		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
@@ -757,17 +761,22 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
-			       (TCPOPT_NOP << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
 			       TCPOLEN_SACK_PERM);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(OPTION_WSCALE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
+		u8 highbyte = TCPOPT_NOP;
+
+		if (unlikely(leftover_size == 1))
+			highbyte = leftover_bytes >> 8;
+		*ptr++ = htonl((highbyte << 24) |
 			       (TCPOPT_WINDOW << 16) |
 			       (TCPOLEN_WINDOW << 8) |
 			       opts->ws);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(opts->num_sack_blocks)) {
@@ -775,8 +784,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			tp->duplicate_sack : tp->selective_acks;
 		int this_sack;
 
-		*ptr++ = htonl((TCPOPT_NOP  << 24) |
-			       (TCPOPT_NOP  << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK <<  8) |
 			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
 						     TCPOLEN_SACK_PERBLOCK)));
@@ -788,6 +796,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		}
 
 		tp->rx_opt.dsack = 0;
+	} else if (unlikely(leftover_bytes != NOP_LEFTOVER)) {
+		*ptr++ = htonl((leftover_bytes << 16) |
+			       (TCPOPT_NOP << 8) |
+			       TCPOPT_NOP);
 	}
 
 	if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
-- 
2.34.1


