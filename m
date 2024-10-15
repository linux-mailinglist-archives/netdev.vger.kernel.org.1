Return-Path: <netdev+bounces-135579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBEA99E40C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C43E1F23CD0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27151F9438;
	Tue, 15 Oct 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MWh67FpT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA431F9400
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988244; cv=fail; b=pCfsDbnqJiej9RoVjaCd8hk2c4Szp776tyNnoFffYPXDxhAUGmmp6Zna4t+zQN2bqxqddHDhjSBQXnVAx6fZ2qIrs7YnbOwJSMVL/dwC47Y0p6qcHwEjrKNSdHEuEdEZhmFomTVlLab7IszkH+J4Ryy/ieXnbTS4ZKa5oHsYDk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988244; c=relaxed/simple;
	bh=4T4GdhUGoEUokZ3OIxzB+EWrizYn5VJAiiF0JPCBDxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COEhUAmUEIfL0kskp6NjxkT1qiq03l+iN9/8L3X+jyMVN9AvzBxxuBBtZvVyxWHEPSrOTnkPk/m6pjGJ4xiVau4V4ZHlwAH9nS5t6y3CWDiuPvwSVk70YHnM9EOpt4zMssxot7JGVFsRjnNlgwpGZUS/XQFZn40XeOgy6l7ETak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MWh67FpT; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BULrhGf5dZT12smCjf33cE7mT5C5bhbDFqVT4aN/boziyxbdUC4/rLFbgPzpkviqDr7j6fuRE0QgGG8u7+o+Y3E+AlFXODpTwvlbRyOiurTk8jeC7ZybrgZi/e6dZR6/edyGx8FluOqqVAUa/4gAhX/lti6L+44+8KrMwELFpsBWUv5foOmN9gsNktEPN7Em6m7lWwHXdVJW/su3hGj7IxN8tnLqYcQbhDTTInu0qT+3LsiOxUZEkZzDGWkKGPbhoPHFvt9hZmx8n3E3vbCBGP33A03H2eMhN3+vyOYMv4fJjiXwSxUKFMuTjgnQdIb5xNRMfyVyMLwb69nLflhV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zrYTIT0yK/vPyDCJOaOT2DYRh8LoTEQCWCtfNVV+UE=;
 b=VL5J+gl27wyCumiGjVzwkfIl5NCxgLwMS02deyyX8yQfEx1T/Hyc72IAXyuFzXedi/792sI4GF7oRHjHnYXn8fcb6ZxWLxLDAqpwLs7Ktu0spHnKGjkfRISfMqTYwVEmhtQTCh4R5bFm4JuQhRPdSaP2/ySnw5UVDNmx6NU36/+ThtG4fUFS6oCE6PW4kJXFeY/ly8k39faOssN7SttF2dDbYF4wqJPYTKj1rR05y4Vnjmc9LvdSxmQhPnWP8u5tfTI+40wcPDW6isj+kkeyGsqHyybk7clsMhXGCMbWm40rNsUsU3fG9tWA+8bXgeUUgpyxAufvsDZ4RXqNNzf/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zrYTIT0yK/vPyDCJOaOT2DYRh8LoTEQCWCtfNVV+UE=;
 b=MWh67FpTp3CCpVpviAcmWc4qVSQRYeGMSye22wlWY62OqXGTV3RMUakoUgBhfwm/G5AMfZvlmVkP0EU3QrMcMdI7oDMvygmpzoHbrGaIAHBpww4mLpLv8COJ5XTJxM46hV6psxttrKx64X7uXoBpPMT4htkNA+TNNHWqO7BwQiyNTBLOPKzZ0Ub+HCFjRnrZgaq63+zsjXFZE6909L2x4DFj0PaBIaJU+sX3//tkFmtU0bUHj7L+G6sWTRmVQiakkbwgzzANrUEjDgX0XeNPi1SBVADm7Bq3/CgztbaIpeh2EkRdo5rpvzdMAxe+arMuvMmfECt1vcVKo3eLPb1nmw==
Received: from DB7PR02CA0036.eurprd02.prod.outlook.com (2603:10a6:10:52::49)
 by AM8PR07MB7346.eurprd07.prod.outlook.com (2603:10a6:20b:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 15 Oct
 2024 10:30:38 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::9b) by DB7PR02CA0036.outlook.office365.com
 (2603:10a6:10:52::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnk029578;
	Tue, 15 Oct 2024 10:30:35 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 42/44] tcp: Add tso_segs() CC callback for TCP Prague
Date: Tue, 15 Oct 2024 12:29:38 +0200
Message-Id: <20241015102940.26157-43-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|AM8PR07MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c54c00-bbb9-4f4c-67b5-08dced046887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGJhTGhtSXJHbVhtTTBsZ3ZKN2dxakhhRWVEbmI3MmpBSkZDY2hHNktiVng0?=
 =?utf-8?B?bndSMTQ1Ky90RnRRaU5JYnVCNTZlNklPNjc2dzFKZ0ZPVUEyblhSNGVmT3FR?=
 =?utf-8?B?dU5CbUU5aE5weGxKVVo4aEtBRnFnZXJGQUtDaGlnay8zcmtxT1dSS2o5L0k0?=
 =?utf-8?B?bVhpY2xRQm1FOWx0NmpJQ1Rpd29YaWdVdEltUHRDRktSNVoreXhWTDV1aTd5?=
 =?utf-8?B?VmRaWTNJcEV4NFJpWm5nZ2RodEJ3SVZITG9vTnFpM3MxK2FIOUlaTnpld29S?=
 =?utf-8?B?OVVtaTFuVkFHc0xUckoxcmdUSlZmT3FWQmM5UlBuZTJqWks0MFBlMlNpdXd1?=
 =?utf-8?B?Ukt2cEY1WFMyQWZieUFrOTE5Y3BMMk00a1I0SFJseFMrbWFkV2YvclQ5ais5?=
 =?utf-8?B?cWtwOTk1WXowc3hSK0ljZUR1SlYyOXdPUW1RN3Q3S1FNQjlVemE0anlITGlP?=
 =?utf-8?B?K2UrYlk4UjhsT2duazVPck9sZFk5OFdMMkNqbWdVQWFqK3A5YTBlWTRIQmlj?=
 =?utf-8?B?YVZUdjJpcTJlaVRNT0dyRkxEQys3NnVCUUxiWllLZG82ZVF3SjdoWVB6U241?=
 =?utf-8?B?U3VmTmRBcG5NYnFOVEQ1c1RHdElFYnZNYjVUZ3ZhV09sa1hRN0ZEQTJ0TThP?=
 =?utf-8?B?d2YvUHJKOWxXaytjM0xuRVhEbHZJb09sWXI5TTJYR3lucDRnRzk3TWt5RUty?=
 =?utf-8?B?TE5mUXY2bDFhY3lIeVlqK25oZXlpaW9zV2x5ajJVQlUvMExXLzZBR1EwSVc2?=
 =?utf-8?B?Qzh4d1c2aHVhSDB1UjdnME9lZGdiY2RkVTVPemMyRC9RdEJSRkcrK0ppdzd5?=
 =?utf-8?B?bEpwRllHenZzQlRKc2ttYkpjOEhyUkRRNVVsVWYyYkNEMVRtMzRjbmR6YmtE?=
 =?utf-8?B?WG9XaW96RGxqT2hzVmtMbVc4VzlwWUdUUjV3T3dVU1JTdUNQWlhHeEkxMDA2?=
 =?utf-8?B?Vmc1blU5USt2emppcjN6VEk2NEk2M0FMOWZRcEoycFhaV3gxSWpUNVkyTDNB?=
 =?utf-8?B?cDdscVBzMGtBWHNRQkJpNzdHRzg1N1l1OURlbXlwRS9hY2kwd0o0ZDlpVmlH?=
 =?utf-8?B?REx6VzNmRElLKzVLM3FxUjM0Q3haV1dzN1U0dXpIaHNsVWYzeFp3byt2aTI1?=
 =?utf-8?B?amJxTTNHMkhEVWhLa3A1bENFWTZMU1BDVldudm5tNHZhK1l4ZnRqR3phVGo1?=
 =?utf-8?B?QWV6cy9yMUJIOVhabCsrNW5nbGpnOUZjbTQ1bTA5UjI5SjNvZ0Z3VzlDVnc2?=
 =?utf-8?B?WHptd08ycFErS252QjU2N3RYYld5bkZYRGVHWTRCcE14RnZtV3ViZGFvenNi?=
 =?utf-8?B?TlNSOUtSWU1aU1BVV1VMVEJVdTdSbGdkWm9pdTJjYzBkMWlRcjRNNTkvWEF2?=
 =?utf-8?B?QVlPbEZubFRuaWhHdmVoQ2VhaXBLdTJGOFlsRmtHZ0taSDRLSStjSmZ6NzFy?=
 =?utf-8?B?SCszMS9wd3RWcU5UMU1KRXJ3b1ZJUmZneXpxZU1LNGtYZmdFdGhjZUdqYUE2?=
 =?utf-8?B?cHEyREUwNHBBb1FHN2NkeU96aXBvL0szaEVyRXh0ZHhBVmxHZUFqR0lYTk5Z?=
 =?utf-8?B?QVpmdzVRSExYd1dsZkhYeXZ0bkZkdWF3ODcwSjlEd3RuSjk2VDhHSVJ3Qkh1?=
 =?utf-8?B?K2hWNWhodnlKRlU3Z1JMQnZiclB1WUJiQ0hHY2RrZHVEeWpRZkoxU0REKzA2?=
 =?utf-8?B?NXd3WmZVL0FoZ0hlWDdGOWxPb205dUwzQnErSUtneStiWmRSRDE2NUhoYXpQ?=
 =?utf-8?B?eDhyeHJKdkJobUdqTFFOMklzSkZvNTM3SDV5UkJIaGpnTHJtVmFCTVJ4RGU3?=
 =?utf-8?B?VDM2OERtZlJBdFJnNnJKVG9ZSnBQUHQzS0NLaE1oeXhFN1Q1YmYxSk10c3Zy?=
 =?utf-8?Q?Rp6ohhwsCVYA6?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:36.7405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c54c00-bbb9-4f4c-67b5-08dced046887
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7346

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch adds tso_segs() CC callbak for CC algorithm to provides
explicit tso segment number of each data burst and overrides
tcp_tso_autosize().

No functional change.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h     | 3 +++
 net/ipv4/tcp_output.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ffb3971105b1..ce7230c1ba5f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1322,6 +1322,9 @@ struct tcp_congestion_ops {
 	/* override sysctl_tcp_min_tso_segs */
 	u32 (*min_tso_segs)(struct sock *sk);
 
+	/* override tcp_tso_autosize */
+	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
+
 	/* call when packets are delivered to update cwnd and pacing rate,
 	 * after all the ca_state processing. (optional)
 	 */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4e00ebf6bd42..0f0e79b42941 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2275,7 +2275,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 			ca_ops->min_tso_segs(sk) :
 			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+	tso_segs = ca_ops->tso_segs ?
+			ca_ops->tso_segs(sk, mss_now) :
+			tcp_tso_autosize(sk, mss_now, min_tso);
 	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
-- 
2.34.1


