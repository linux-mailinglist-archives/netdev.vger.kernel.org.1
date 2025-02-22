Return-Path: <netdev+bounces-168749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F7A40746
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D5719C78AD
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE8E207A2D;
	Sat, 22 Feb 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GBpsHSMZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E178205AD2
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218883; cv=fail; b=VjqJ2qdEFnJbP9Y6bI5ydE6A6wKgdKzFyjRGVeFlWSIl+sFP340yd/5nAoBDEAXjw4RS1Ujxx9N9aRWmsOoyjMYvJq8/t686A8iSSzoMqyIRcxvbIdC8SLGtsMJ2+meXd2YTQcGYP1UcE1JaKjkUZGUnNgyueXxIqvuAbYzS77I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218883; c=relaxed/simple;
	bh=l+z3pKc13aCD02UMfMjaEw3KhCl5S6cY09puVM00dS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PYciJNpiclnR6KRoX134CAtns1xzrAY7UKWUM5o30R4796UApQiJb+11Kr4UVHUi2HztkT6ireujkOrLB5KMME2zcXeTg7XWwKBqc9LCceVqc1sgGEtJxyPRd5io/5W+4iWjvdN5QYMG6emVvup2n3+4kBlIzTV5RYTwCEO7Ea4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GBpsHSMZ; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ycqdt+zi1B5xKMIppcuWC6fMOWfFjN63pvPZCZ59t+g8E/3o14ToGI6VzXhVIzvXm5KFZVDg/WWKPO1tJHO8m4hUhfJVwn5rddfc6T7dulfQ4MWbuqA4NtXx48pyC+7x5vBP6l2RyVGtZpMWsw+JLmhrQKDZz7Np7bvt8+Us8CJYDeqLavNrtmQ2Xz+MgUBLZW845Z+Xy21bOBRtvxQXQ3Px+sdnvHv0a+Z2fyfZ5+lDeEckSPMeIKdA8Peyq/HN3UJwRCJMBE+QDBGyMPMsap1MoEEpQQR9RyIn/tRfezcwAhJzKgX8ONxPRAJltVLmhH7R7tK9DzvglaZUoyburg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2SEHl8/1f0jrEc0C5eIFdKaEnbHVyrML0LIJFiHvDc=;
 b=MtxGXWn4h1S7zZK8H1QRlwCGnSe78uqdr3yMmrcEn5BSGmfCQH3lWCaDjq6xaCQuG2L2KuFn5CEfCWb29Swh1uITXOR0By2blP+rhmOYWVgt3zyEnedKqCo9Qq6D/qLyUoTX268JgzqgM0J6sEi7st2sZOL+HpxUEckZjKaaBnHy8G4988tXEwOSwsHdfnjQ9PhhV97LsDB6Mr8OAWjKo5I+ZqDtUATNbK3sRtcv3aOO1jmlGAYB/E5xipTKlQJIdrn/ABgSGLjPL1gbWlO5zsS8XHE07hEYjCP/xfetqG1xSuMb3saF+ToJem8bdLncf3owJViKWv9+r1a57ZqEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2SEHl8/1f0jrEc0C5eIFdKaEnbHVyrML0LIJFiHvDc=;
 b=GBpsHSMZGUtHYiSlGRjhLoMr8ZYgxC46ifbC17JRNNsdtgYmRVSpItcdcfrglWtv54UbwI15ZUwnLIF7Fghb/9DnH4EvrbbbcXytshN21qkosfNpM2Pn5n+yEN599O/LNSAPtp2kZINdMD2l4RNRqtUm4YSL4I3XJk/1Dl/a+SClKEylPKH6OuzWbrVmG38ChQvQfV46PhCkPMKpJI4KUCR8EZyrqPmK0cK2PSKB+9Kx6p9V2fhVeqcC6jbJHKbJxZD53J5VFU8jh3HI8cqJ0Xp5Cio5HBbf81W+qYsjXgYbSQ5RtRyPDnoqDqKpTWm1AEG/vmJ6HEy+ZAm584VQog==
Received: from PA7P264CA0499.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3da::6)
 by AS8PR07MB7944.eurprd07.prod.outlook.com (2603:10a6:20b:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 10:07:55 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:102:3da:cafe::f2) by PA7P264CA0499.outlook.office365.com
 (2603:10a6:102:3da::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 10:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 10:07:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 51MA7kKD004974;
	Sat, 22 Feb 2025 10:07:46 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v5 net-next 0/1] DUALPI2 patch
Date: Sat, 22 Feb 2025 11:07:24 +0100
Message-Id: <20250222100725.27838-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|AS8PR07MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ddf111-06ba-4b06-00cc-08dd5328c65f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bmNWRm84SjBZM3k5RXFkcHg1eXI1ZDlsYTFnMEVHQXptM2U0ZlgzSlI4VzNn?=
 =?utf-8?B?aVI0Y0V5TTFUWHplV2NtdWMrbWRvZitjV1JIdERRSGwzZTFVQ3ZvK0hzcWZI?=
 =?utf-8?B?UThkdlpBRkhlOCtTQ1VYQktpM1RnWm90UjBKVDNhWlcvYTNJa0k5cHRoeWxv?=
 =?utf-8?B?ZUp6bzFvWVZPQlpEemlUYkJZWGlOZ2YrMUxodTh1alV1K1RuNVBaNENQK1Js?=
 =?utf-8?B?NnR1TElLdjlLZUlmeVp2RU5IZktEQXpZWUxPL21oYnNaUGEzdXRIMCt4dG9I?=
 =?utf-8?B?TnlpaERLU042TndVeWo4VG05NjJJVFU3OVJ0eno0WFFiK29RR0NHSVdKVStu?=
 =?utf-8?B?Y2hSYWJRV25iK1BHMWZFOHg4NW1VNXlNZ1hMN1ZGR1pIVHNjZDBrV2k2eUVL?=
 =?utf-8?B?ZWwvU2pvV1Y1bmowMFU3WXhjNGUrdVlJemUxT2Vhb2dLWStFaTdzdWtleWFw?=
 =?utf-8?B?RUUvcmI4QmpDQitQeE5GbkpyNHFFdlA0ME9FZnNPdnpoa3JnaFdDQzFzS1B0?=
 =?utf-8?B?VlJyN1VadVpFVnhrZVcwQ1g5NjVqNXhnZklJekYyOGU3c05XMlluUWdnU1RL?=
 =?utf-8?B?R2lCalAycE9qLzNqdUkvS0pUMlJYTzU1Uk9ZbEp5U0xzTlJPeXdOMVE1cGUz?=
 =?utf-8?B?ZElUOENlcHVDcE96VHhpMEpDOXMwT0hwaUlhS2tUQVVPcFlvUVBLaVBDbVF5?=
 =?utf-8?B?dTUvVWhwUW84eVpkSi9sVjlDTGdsaTR3dmZ3VXhHQUZ1M1IvUGwvNndkSXRO?=
 =?utf-8?B?L01DeWg4d2pBNkVOcXlydk8vT2hPaFZ5Nkx4dnc3MDVsMlBYclZSNFJPcUhJ?=
 =?utf-8?B?bkZsSUo4MnhOL1Frb0JFNitZajViVUErQ3A3M1JSUlBHS0loZTNhYk9ZSCt5?=
 =?utf-8?B?T3JJMEd0NzlFeHd2cE5wK0dvek56ZjdrVmVPTGVHUkUwL1ZLS0hldUU2REZs?=
 =?utf-8?B?OFp6cG0xOURUdEdEdTdDUjlmM2FJRWZybjVrdzlTUU14ckpYKzcvckJzNmRx?=
 =?utf-8?B?VzdtZDA4MDgrSEtaTGtzZ0w5d2JDNkpnWk5EM0UrVU1pM0poT3I5ZThINWxJ?=
 =?utf-8?B?UmhvZXdkRnpGSndKSzBFd29meFhsMlBuYnJnOVNoenlab2hFblZ2WjlGVjJC?=
 =?utf-8?B?N1Q0YmxxdXpyNzVVd09aVXJ6cU1rYzRMcGFkN1JZOE5VNTdhZTdvYkErNFA1?=
 =?utf-8?B?UlVMWmdFb05UYWxNcUN0bGtCQVlaaXV1cFBlRi95MEFMRnFnLzFKcmIyc0ZH?=
 =?utf-8?B?KzZ5aU5ZNUNJZ1daQVpOY1ZKblY5dHkyNDlGTTBwY2NIaEt2VVpKVEVwKzVa?=
 =?utf-8?B?RklKL1k3clp4M2dsSi94OU0rekprUVF0UFZmQXJwT0FnY1VFS3YwbHMxb1Uv?=
 =?utf-8?B?ZHp4eEFwYkhrZ0FlNS9qYVpNMzRncFZEZzV5QzZUUEh4N0pCZ3Z0UUtCWEc1?=
 =?utf-8?B?ZjQwSU05c2d5OXZIY29aOXFuZHVmL2tSSHV3blMwZHVRNmFQT0ZNL1J1ZWx1?=
 =?utf-8?B?blpBdXZua3huazNFUlY5UUx3MGxGMlF4dVJIaGdHMXA2aEdMemJvb3pOVU5q?=
 =?utf-8?B?SlpLMlh5Q1crS1RKUjBGaWhBdUYrYWJzWXVDclJFbGQzSEE1SitjNGJBaWpl?=
 =?utf-8?B?bnIwMHd2TEc1MVpRbGlhSHd5ZEsvUXBrWmJaeGdjc2hJalMzVHpNZEozTElo?=
 =?utf-8?B?Nk1obUo1eHJBVEc1aUhoSDAzYTVQU3hYUTBCNXRsNjFXMnp2STcyYVZFaWdO?=
 =?utf-8?B?bGxNVk5GK1lZN3NRWHMzeW5CSXp2Y3FSTGorWFVkcGFPZGZCTmphK3FISUVj?=
 =?utf-8?B?dlU4L1JyYjNuNG9NWWROcitHR2ZCRWJneHRaenJxQTYrTGtpakNvdDRKcG5s?=
 =?utf-8?B?UlR2WktiU0JIa2xaL1JPcTNGbGU4Qlp4OFFiQ1NZVURWUXc3djhGUS82bjZR?=
 =?utf-8?Q?k8QurEKVfMQyz3S8obX8u4lEYS3LKx7B?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 10:07:54.7296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ddf111-06ba-4b06-00cc-08dd5328c65f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7944

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 patch v5.
  In addition to the changes, a comparison was done between MQ + DUALPI2, MQ + FQ_PIE, 
  MQ + FQ_CODEL as suggested by Dave, you can find them below.

Unshaped 1gigE with 4 download streams test:
 - Summary of tcp_4down run 'MQ + FQ_CODEL':
                           avg       median       # data pts
    Ping (ms) ICMP :       1.19     1.34 ms          349
    TCP download avg :   235.42      N/A Mbits/s     349
    TCP download sum :   941.68      N/A Mbits/s     349
    TCP download::1  :   235.19   235.39 Mbits/s     349
    TCP download::2  :   235.03   235.35 Mbits/s     349
    TCP download::3  :   236.89   235.44 Mbits/s     349
    TCP download::4  :   234.57   235.19 Mbits/s     349

 - Summary of tcp_4down run 'MQ + FQ_PIE'
                           avg       median        # data pts
    Ping (ms) ICMP :       1.21     1.37 ms          350
    TCP download avg :   235.42      N/A Mbits/s     350
    TCP download sum :   941.61     N/A Mbits/s      350
    TCP download::1  :   232.54  233.13 Mbits/s      350
    TCP download::2  :   232.52  232.80 Mbits/s      350
    TCP download::3  :   233.14  233.78 Mbits/s      350
    TCP download::4  :   243.41  241.48 Mbits/s      350

 - Summary of tcp_4down run 'MQ + DUALPI2'
                           avg       median        # data pts
    Ping (ms) ICMP :       1.19     1.34 ms          349
    TCP download avg :   235.42      N/A Mbits/s     349
    TCP download sum :   941.68      N/A Mbits/s     349
    TCP download::1  :   235.19   235.39 Mbits/s     349
    TCP download::2  :   235.03   235.35 Mbits/s     349
    TCP download::3  :   236.89   235.44 Mbits/s     349
    TCP download::4  :   234.57   235.19 Mbits/s     349


Unshaped 1gigE with 128 download streams test:
 - Summary of tcp_128down run 'MQ + FQ_CODEL':
                           avg       median       # data pts
    Ping (ms) ICMP   :     1.88     1.86 ms          350
    TCP download avg :     7.39      N/A Mbits/s     350
    TCP download sum :   946.47      N/A Mbits/s     350

 - Summary of tcp_128down run 'MQ + FQ_PIE':
                           avg       median       # data pts
    Ping (ms) ICMP   :     1.88     1.86 ms          350
    TCP download avg :     7.39      N/A Mbits/s     350
    TCP download sum :   946.47      N/A Mbits/s     350

 - Summary of tcp_128down run 'MQ + DUALPI2':
                           avg       median       # data pts
    Ping (ms) ICMP   :     1.88     1.86 ms          350
    TCP download avg :     7.39      N/A Mbits/s     350
    TCP download sum :   946.47      N/A Mbits/s     350


Unshaped 10gigE with 4 download streams test:
 - Summary of tcp_4down run 'MQ + FQ_CODEL':
                           avg       median       # data pts
    Ping (ms) ICMP :       0.22     0.23 ms          350
    TCP download avg :  2354.08      N/A Mbits/s     350
    TCP download sum :  9416.31      N/A Mbits/s     350
    TCP download::1  :  2353.65  2352.81 Mbits/s     350
    TCP download::2  :  2354.54  2354.21 Mbits/s     350
    TCP download::3  :  2353.56  2353.78 Mbits/s     350
    TCP download::4  :  2354.56  2354.45 Mbits/s     350

- Summary of tcp_4down run 'MQ + FQ_PIE':
                           avg       median      # data pts
    Ping (ms) ICMP :       0.20     0.19 ms          350
    TCP download avg :  2354.76      N/A Mbits/s     350
    TCP download sum :  9419.04      N/A Mbits/s     350
    TCP download::1  :  2354.77  2353.89 Mbits/s     350
    TCP download::2  :  2353.41  2354.29 Mbits/s     350
    TCP download::3  :  2356.18  2354.19 Mbits/s     350
    TCP download::4  :  2354.68  2353.15 Mbits/s     350

 - Summary of tcp_4down run 'MQ + DUALPI2':
                           avg       median      # data pts
    Ping (ms) ICMP :       0.24     0.24 ms          350
    TCP download avg :  2354.11      N/A Mbits/s     350
    TCP download sum :  9416.43      N/A Mbits/s     350
    TCP download::1  :  2354.75  2353.93 Mbits/s     350
    TCP download::2  :  2353.15  2353.75 Mbits/s     350
    TCP download::3  :  2353.49  2353.72 Mbits/s     350
    TCP download::4  :  2355.04  2353.73 Mbits/s     350


Unshaped 10gigE with 128 download streams test:
 - Summary of tcp_128down run 'MQ + FQ_CODEL':
                           avg       median       # data pts
    Ping (ms) ICMP   :     7.57     8.69 ms          350
    TCP download avg :    73.97      N/A Mbits/s     350
    TCP download sum :  9467.82      N/A Mbits/s     350

 - Summary of tcp_128down run 'MQ + FQ_PIE':
                           avg       median       # data pts
    Ping (ms) ICMP   :     7.82     8.91 ms          350
    TCP download avg :    73.97      N/A Mbits/s     350
    TCP download sum :  9468.42      N/A Mbits/s     350

 - Summary of tcp_128down run 'MQ + DUALPI2': 
                           avg       median       # data pts
    Ping (ms) ICMP   :     6.87     7.93 ms          350
    TCP download avg :    73.95      N/A Mbits/s     350
    TCP download sum :  9465.87      N/A Mbits/s     350

 From the results shown above, we see small differences between combinations.

v5
- Update commit message to include results of no_split_gso and split_gso (Dave Taht <dave.taht@gmail.com> and Paolo Abeni <pabeni@redhat.com>)
- Add memlimit in dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
- Update license identifier (Dave Taht <dave.taht@gmail.com>)
- Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
- Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
- Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
- Add dscsriptions of packet counter statistics and reset function of sch_dualpi2.c
- Fix step_thresh in packets
- Update code comments in sch_dualpi2.c

v4
- Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
- Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
- Fix line length warning

v3
- Fix compilaiton error
- Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)

v2
- Add Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
- Use dualpi2 instead of skb prefix (Jamal Hadi Salim <jhs@mojatatu.com>)
- Replace nla_parse_nested_deprecated with nla_parse_nested (Jamal Hadi Salim <jhs@mojatatu.com>)
- Fix line length warning

For more details of DualPI2, plesae refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).
--
Chia-Yu

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  140 +++
 include/linux/netdevice.h                     |    1 +
 include/uapi/linux/pkt_sched.h                |   38 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1081 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
 8 files changed, 1423 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


