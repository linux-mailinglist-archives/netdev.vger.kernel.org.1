Return-Path: <netdev+bounces-135581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D6299E40F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623311C21D85
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD161F8F04;
	Tue, 15 Oct 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lEoQzdvw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0651F9409
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988246; cv=fail; b=ejizAJ4xGBFf3iwhrKc0A0bupxfLdxcbDgGDVrzATKMB8KjmiiglwmgZ+GoKsYaiCCviPKs0C50brhiLLtHzSwOQg2MLJcJTm2kcDCY2gWTQqsiqg4Y43tBKqFOB0w6ytnS6zcMQRM9uI1VTthsbFx2T3JtJTmTc/+YArouN0+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988246; c=relaxed/simple;
	bh=yfUTNItIo4Pe3L3s+Qr6v8JwqHZKo+BecWRWqapFkP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQemusK+oFU8oJNf24sRHuUlybrDMasIL3Ml33sFsky92MpAbT/rws6Ul2LWF0/zmFlYKZWHkZKCOImJ8IGB3BixhxKL+09CHtgUUJhFeUj93FdBKm52aXPPEsc78Q1fF95MCYAWoLMU9bdvDGNbiN/WGsWR6ZecscinayPZJHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lEoQzdvw; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afDNcVB8KgpwuCJOS7S4fPDinoKQ/479sHJdEww3sDOpxrGsmh8TFRnWhIHeEtDu+GxlXl/MKt9DV7CDOkQhSR1kcjpwi4+mbCKvsHO+91Wmn44bZ1PppyUkdM5L0U24Iqsp3bNuV/vauvaqATf/LAopwdTvouBeSt/8V6FzNI9p5CEFCHz1tv8LcGIs1h+yOaNzQwjJiPrGxgydiddxgMPJGLLk4T9iOyTa/LxGDwUSS0WuVMuPIyOKFQQkZAyXN802GmmCaX77h6r2dB6P9lpEUJgR4mjwG3qcuxg8zpmJ8HORNJm6ykKYqqODKcp9P6Kq7v6QQGZrAWmP+mv2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCKvQc+wQVzwtIAgtT9u6pacSckr8C6sIgT+3wVZ6W4=;
 b=P2MKyTsFm2zthYjUyKiG+FAVQi+N17r9w3eqWiNfORXPIGTjtYSCumDV7hsaxcDzfnTxt93+eiZZEYuuz9+Ehe6nYlrqPE6MR4Y+ddhcLUn982G0Q0ulBEEF/HwMze7oofUEZAz5A1U3t6uk943BGURrdLCZAZnmHGwWnswEr/6jumj8WmwaPv81XytR0QLmI3TaISg/e4dNWD8b8PGml4n4jTmkc9Yf9E7AnfFxh0FnP5BH9iKEJoKtikmViZs4DBdIFeImiNVjhxpUjVud3Pz2nh8FPXjPqeAt+m9Zr3DbDf+BTaRPxeeR6qMf3v9kjOjWh33QM6Mh7VobLyXC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=bobbriscoe.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCKvQc+wQVzwtIAgtT9u6pacSckr8C6sIgT+3wVZ6W4=;
 b=lEoQzdvwrB0ZUUDRY603Gsr8im1MnXPy84YolLIfBKfCbqpR5Gh/t+jmZJkH5ntncbS4fVw1XcMJ08w7MTZ2IGHVqwjqjHFzuefKw38tYV4CJEl/d/mxxTxbYjmzNk9JKz8yFew9IRrKCQzADGvNFEKu7w35mmcXMfNfWIqirtlZFjkswYy9GeBqB5PJDvQwb99a2SI20Mc8COBbp2iQF5HJmwf1hQlPFZGqh2uVXsqHbqAMKXrgCVZR5XqnoK42MLFh64N+YBJLJ5mgGrhuMsQ2gYtWAvrAyJdpm42dop23WfPyXv9dtaWU13x5B/T1PxuaQWIiCHWU5FhEao3xgw==
Received: from AM6P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::28)
 by PAXPR07MB7983.eurprd07.prod.outlook.com (2603:10a6:102:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:38 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:209:7f:cafe::9) by AM6P191CA0051.outlook.office365.com
 (2603:10a6:209:7f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnm029578;
	Tue, 15 Oct 2024 10:30:36 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
        Olivier Tilmans <olivier.tilmans@nokia.com>,
        Bob Briscoe <research@bobbriscoe.net>
Subject: [PATCH net-next 44/44] tcp: Add the TCP Prague congestion control module
Date: Tue, 15 Oct 2024 12:29:40 +0200
Message-Id: <20241015102940.26157-45-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|PAXPR07MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: a776f52a-1fab-44a7-549a-08dced0469a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXN1ZldXaWpxUGFZOE1McncrV1U3SzVCbmNCRTVLazRLbUtvd2w3U0NqWkc1?=
 =?utf-8?B?aEh0V3J0cURsbjlhSGxEOVFWRTd6T1cvM0oyOVlPMVUvcitEMXF0RkZQZ1Ir?=
 =?utf-8?B?dUF3djE1VnpLalhRU2p3clZvRkdRSGxBMTJxZ0tVYjMvNkMrSWcraWI2K1Za?=
 =?utf-8?B?ODg3SDRoT0lSUDU5azJlNjFLQUhYcFcwaWQzYTlLYlRQSlR4UXB3b2pObDc2?=
 =?utf-8?B?RUVScy9ISjJFMC9EbkZBTXlYbUhwL2xEUDhCZ2IzQURjNE9ZZUxwS0pMaVpm?=
 =?utf-8?B?ZloyVzd1VmFsNVFiSDk0eEN4N2RaQnUzZXIxUEUrbTh5aVlCTitPMXNjMUpF?=
 =?utf-8?B?TldaS0pQUkVpU3lHY2g4aXZYOHNvakhpZ1phK2Rxem9uWWxZWHVWaHcwcXBy?=
 =?utf-8?B?RElHb3haTGkvcGt3Qk5vQkFTZGwwYVF0UWRpejNWYWtYM3h1QzJuczNWUVQw?=
 =?utf-8?B?QXRuQnV3clZ2UWVoZjlaUTN5bDJWYmhCNmMybWJsTWd5SHRwR00wK2s3SmV4?=
 =?utf-8?B?YmIvazc0ck40RXhnUHo2OHpqeGh6ZTFSTEZJc3NjeFhNNWVLYVZmU1BJZFVj?=
 =?utf-8?B?TGtjbUVVVFJpZ003ZFR1ajlPWjZFTy9BbHpCZ2d2MU9ZK2FUZjVZeVRLZ0pI?=
 =?utf-8?B?Y1M4TzladS94OU90SCt4OFZXRGc1QWJYa0l6a2h5cm1BL3FwWm9Vc3RRaWJO?=
 =?utf-8?B?VitEb08wMWtNNnFRejVKOUQ3aWluaUVLSnpEUW4vQm5IYmljTHJxQUZDNTh6?=
 =?utf-8?B?akxCQkxnMVgzOVN4eXVMY05wL3U1SlNZdjFqOVhWM1N2UmhENXl6ZlhoQnAr?=
 =?utf-8?B?YzBKeUxDUE5wZVVMQ0VNWEZQdXVrMFYvd09kOERlR1VweW5yQ0dzZERRVU90?=
 =?utf-8?B?ZDE4UHR5MXZXRTlLY1Fqa0tsMlhnVVNqaXNkQUhzZ1d6amkzOGppakVXcThQ?=
 =?utf-8?B?eGpoS0MvdVJhR1lxUHNmVDdiMDZtc2dRUEV0d2FiTG55aWJ5WWdneGI1OThq?=
 =?utf-8?B?S2NkMzdHOTluUUE1dWl0cEszR2lCUURia3Z3Z0JUYzRyS3h5ODRlYWpqOTRw?=
 =?utf-8?B?b1Fvbmpkdng5dDFERHlkWWtlcElycXNvTmREbG90R051MXlRdkI4V0RwTzJ0?=
 =?utf-8?B?VksyYlAzaHFXd3B4TFRRaU9VNnZTaTJWMUp5SHVlbG4yc1c4L1F2SXR0U2Fi?=
 =?utf-8?B?TU5JZUl3ZFUwQ2N4YXoyYlljc1J2RlNScHd5S1dCeGN2eGltTG51NzUwbDIw?=
 =?utf-8?B?MGNyUFN1cE5aMlRUb0hvbzE3MlVlT1VCc0JPNnk1Rnl5djZ6NUhSOUVUVytV?=
 =?utf-8?B?UUhVbnZiTURuTVBHaFdVN0VnNnJjaFJ4Kzh2cWY2TGsvQThvNTZiTlk2MVNL?=
 =?utf-8?B?bFozZ3l0RkhEUGVMSll6U0JJWlBrTWZRU2h4T1NBVWxYV1ZNZ1JSWGFMcXJk?=
 =?utf-8?B?emJiOTFLM3UvaTlXZ2dseWVrdDQ3ZVR2UUpKdnFSbEloZGc5U0V4UWVzYlBu?=
 =?utf-8?B?emg0cVJOWVlhdlF0RDFmNmFYMGF6ckdlZ3Mxb1Y4MHRSV0pGRm5FMFNqdEll?=
 =?utf-8?B?UTZ6UjdrTUhpWDl1NlZubmVHd2hNaWdwM1lUQU1sZUQ3MW1ZMjNiUVRJVDhS?=
 =?utf-8?B?T1dHN2RqV01lL2lyeWU0MTliVjZIaVNEVy9TRVRZeURRM3gxSjZwbXVLaU5D?=
 =?utf-8?B?YU9mTHJYajNMSm5WZXpMQjVGcWJKcmlBZ3g2Q243UEp2Nkw3RU1hSGVyWUpz?=
 =?utf-8?B?ZksxQjlTeXpic0lNbkRsdHNaL2trQjFjK0ZBWlhkZyt4UTNzRDNmcEtSSUFn?=
 =?utf-8?B?NmNVWTZQQXlGL3ZnNlFtSGRDUWxyYk1DdGg4Njl0cGN4b0xwWjRTdTFlVURw?=
 =?utf-8?B?TGlFR0VNRmxSb0VkWXFteVdoY3JFdE9acTJHaTRmcVRFSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:38.6547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a776f52a-1fab-44a7-549a-08dced0469a4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7983

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

TCP-Prague evolved from DCTCP, adapted for the use over the public
internet and removing all reasons why the NW would need to build a
queue in a bottleneck link to control the rate of this congestion-
control. As such, it needs to implement the performance and safety
requirements listed in Appendix A of IETF RFC9331:
https://datatracker.ietf.org/doc/html/rfc9331

This version enhances DCTCP by:
* RTT independence
* Fractional window and increased alpha resolution
* Updated integer arithmetics and fixed-point scaling
* Only Additive Increase for ACK of non-marked packets
* Pacing/tso sizing
* Pacing below minimum congestion window of 2
* +/- 3% pacing variations per RTT
* Enforce the use of ECT_1, Accurate ECN and ECN++

All above improvements make Prague behave under 25ms very rate fair
and RTT independent, assures full or close to full link utilization
on a stable network link and allows the NW to control the rate down
to 100kbps without the need to drop packets or built a queue.
For RTTs from 0us till 25ms and link rates higher than 100kbps, the
resulting rate equation is very close to:
      r [Mbps] = 1/p - 1
Above 25ms, a correction factor of 25ms/RTT needs to be applied
(reducing the rate proportional to the higher RTT).

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/uapi/linux/inet_diag.h |  13 +
 net/ipv4/Kconfig               |  37 ++
 net/ipv4/Makefile              |   1 +
 net/ipv4/tcp_prague.c          | 866 +++++++++++++++++++++++++++++++++
 4 files changed, 917 insertions(+)
 create mode 100644 net/ipv4/tcp_prague.c

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index 86bb2e8b17c9..69d144ba3627 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -161,6 +161,7 @@ enum {
 	INET_DIAG_SK_BPF_STORAGES,
 	INET_DIAG_CGROUP_ID,
 	INET_DIAG_SOCKOPT,
+	INET_DIAG_PRAGUEINFO,
 	__INET_DIAG_MAX,
 };
 
@@ -231,9 +232,21 @@ struct tcp_bbr_info {
 	__u32	bbr_cwnd_gain;		/* cwnd gain shifted left 8 bits */
 };
 
+/* INET_DIAG_PRAGUEINFO */
+
+struct tcp_prague_info {
+	__u64	prague_alpha;
+	__u64	prague_frac_cwnd;
+	__u64	prague_rate_bytes;
+	__u32	prague_max_burst;
+	__u32	prague_round;
+	__u32	prague_rtt_target;
+};
+
 union tcp_cc_info {
 	struct tcpvegas_info	vegas;
 	struct tcp_dctcp_info	dctcp;
+	struct tcp_prague_info	prague;
 	struct tcp_bbr_info	bbr;
 };
 #endif /* _UAPI_INET_DIAG_H_ */
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 6d2c97f8e9ef..f55438c70579 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -679,6 +679,39 @@ config TCP_CONG_BBR
 	  AQM schemes that do not provide a delay signal. It requires the fq
 	  ("Fair Queue") pacing packet scheduler.
 
+config TCP_CONG_PRAGUE
+	tristate "TCP Prague"
+	default n
+	help
+	  TCP Prague is an enhancement for DCTCP to make DCTCP congestion
+	  control deployable into general Internet.
+	  TCP-Prague evolved from DCTCP, adapted for the use over the public
+	  internet and removing all reasons why the NW would need to build a
+	  queue in a bottleneck link to control the rate of this congestion-
+	  control. As such, it needs to implement the performance and safety
+	  requirements listed in Appendix A of IETF RFC9331:
+	  https://datatracker.ietf.org/doc/html/rfc9331
+
+	  This version enhances DCTCP by:
+	  * RTT independence
+	  * Fractional window and increased alpha resolution
+	  * Updated integer arithmetics and fixed-point scaling
+	  * Only Additive Increase for ACK of non-marked packets
+	  * Pacing/tso sizing
+	  * Pacing below minimum congestion window of 2
+	  * +/- 3% pacing variations per RTT
+	  * Enforce the use of ECT_1, Accurate ECN and ECN++
+
+	  All above improvements make Prague behave under 25ms very rate fair
+	  and RTT independent, assures full or close to full link utilization
+	  on a stable network link and allows the NW to control the rate down
+	  to 100kbps without the need to drop packets or built a queue.
+	  For RTTs from 0us till 25ms and link rates higher than 100kbps, the
+	  resulting rate equation is very close to:
+	  r [Mbps] = 1/p - 1
+	  Above 25ms, a correction factor of 25ms/RTT needs to be applied
+	  (reducing the rate proportional to the higher RTT).
+
 choice
 	prompt "Default TCP congestion control"
 	default DEFAULT_CUBIC
@@ -716,6 +749,9 @@ choice
 	config DEFAULT_BBR
 		bool "BBR" if TCP_CONG_BBR=y
 
+	config DEFAULT_PRAGUE
+		bool "Prague" if TCP_CONG_PRAGUE=y
+
 	config DEFAULT_RENO
 		bool "Reno"
 endchoice
@@ -740,6 +776,7 @@ config DEFAULT_TCP_CONG
 	default "dctcp" if DEFAULT_DCTCP
 	default "cdg" if DEFAULT_CDG
 	default "bbr" if DEFAULT_BBR
+	default "prague" if DEFAULT_PRAGUE
 	default "cubic"
 
 config TCP_SIGPOOL
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index ec36d2ec059e..47b1304ffa09 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_TCP_CONG_SCALABLE) += tcp_scalable.o
 obj-$(CONFIG_TCP_CONG_LP) += tcp_lp.o
 obj-$(CONFIG_TCP_CONG_YEAH) += tcp_yeah.o
 obj-$(CONFIG_TCP_CONG_ILLINOIS) += tcp_illinois.o
+obj-$(CONFIG_TCP_CONG_PRAGUE) += tcp_prague.o
 obj-$(CONFIG_TCP_SIGPOOL) += tcp_sigpool.o
 obj-$(CONFIG_NET_SOCK_MSG) += tcp_bpf.o
 obj-$(CONFIG_BPF_SYSCALL) += udp_bpf.o
diff --git a/net/ipv4/tcp_prague.c b/net/ipv4/tcp_prague.c
new file mode 100644
index 000000000000..6db9386b13af
--- /dev/null
+++ b/net/ipv4/tcp_prague.c
@@ -0,0 +1,866 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Nokia
+ *
+ * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
+ * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
+ * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
+ * Author: Bob Briscoe <koen.de_schepper@nokia-bell-labs.com>
+ *
+ * TCP Prague congestion control.
+ *
+ * This congestion-control, part of the L4S architecture, achieves low loss,
+ * low latency and scalable throughput when used in combination with AQMs such
+ * as DualPI2, CurvyRED, or even fq_codel with a low ce_threshold for the
+ * L4S flows.
+ *
+ * TCP-Prague evolved from DCTCP, adapted for the use over the public
+ * internet and removing all reasons why the network would need to build a
+ * queue in a bottleneck link to control the rate of this congestion-control.
+ * As such, it needs to implement the performance and safety requirements
+ * listed in Appendix A of IETF RFC9331:
+ * https://datatracker.ietf.org/doc/html/rfc9331
+ *
+ * Notable changes from DCTCP:
+ *
+ * 1/ RTT independence:
+ * Below a minimum target RTT, Prague will operate as if it was experiencing
+ * that target RTT (default=25ms). This enable short RTT flows to co-exist
+ * with long RTT ones (e.g., Edge-DC flows competing vs intercontinental
+ * internet traffic) without causing starvation or saturating the ECN signal,
+ * without the need for Diffserv or bandwdith reservation. It also makes the
+ * lower RTT flows more resilient to the inertia of higher RTT flows.
+ *
+ * This is achieved by scaling cwnd growth during Additive Increase, thus
+ * leaving room for higher RTT flows to grab a larger bandwidth share while at
+ * the same time relieving the pressure on bottleneck link hence lowering the
+ * overall marking probability.
+ *
+ * Given that this slows short RTT flows, this behavior only makes sense for
+ * long-running flows that actually need to share the link--as opposed to,
+ * e.g., RPC traffic. To that end, flows become RTT independent after
+ * DEFAULT_RTT_TRANSITION number of RTTs after slowstart (default = 4).
+ *
+ * 2/ Fractional window and increased alpha resolution:
+ * To support slower and more gradual increase of the window, a fractional
+ * window is kept and manipulated from which the socket congestion window is
+ * derived (rounded up to the next integer and capped to at least 2).
+ *
+ * The resolution of alpha has been increased to ensure that a low amount of
+ * marks over high-BDP paths can be accurately taken into account in the
+ * computation.
+ *
+ * Orthogonally, the value of alpha that is kept in the connection state is
+ * stored upscaled, in order to preserve its remainder over the course of its
+ * updates (similarly to how tp->srtt_us is maintained, as opposed to
+ * dctcp->alpha).
+ *
+ * 3/ Updated integer arithmetics and fixed point scaling
+ * In order to operate with a permanent, (very) low marking probability and
+ * much larger RTT range, the arithmetics have been updated to track decimal
+ * precision with unbiased rounding, alongside avoiding capping the integer
+ * parts. This improves the precision, avoiding avalanche effects as
+ * remainders are carried over next operations, as well as responsiveness as
+ * the AQM at the bottleneck can effectively control the operation of the flow
+ * without drastic marking probability increase.
+ *
+ * 4/ Only Additive Increase for ACK of non-marked packets
+ * DCTCP disabled increase for a full RTT when marks were received. Given that
+ * L4S AQM may induce CE marks applied every ACK (e.g., from the PI2
+ * part of dualpi2), instead of full RTTs of marks once in a while that a step
+ * AQM would cause, Prague will increase every RTT, but proportional to the
+ * non-marked packets. So the total increase over an RTT is proportional to
+ * (1-p)/p. The cwnd is updated for every ACK that reports non-marked
+ * data on the receiver, regardless of the congestion status of the connection
+ * (i.e., it is expected to spent most of its time in TCP_CA_CWR when used
+ * over dualpi2). Note that this is only valid for CE marks. For loss (so
+ * being in TCP_CA_LOSS state) the increase is still disabled for one RTT.
+ *
+ * See https://arxiv.org/abs/1904.07605 for more details around saturation.
+ *
+ * 5/ Pacing/TSO sizing
+ * Prague aims to keep queuing delay as low as possible. To that end, it is in
+ * its best interest to pace outgoing segments (i.e., to smooth its traffic),
+ * as well as impose a maximal GSO burst size to avoid instantaneous queue
+ * buildups in the bottleneck link. The current GSO burst size is limited to
+ * create up to 250us latency assuming the current transmission rate is the
+ * bottleneck rate. For this functionality to be active, the "fq" qdisc needs
+ * to be active on the network interfaces that need to carry Prague flows.
+ * Note this is the "fq" qdisc, not the default "fq_codel" qdisc.
+ *
+ * 6/ Pacing below minimum congestion window of 2
+ * Prague will further reduce the pacing rate based on the fractional window
+ * below 2 MTUs. This is needed for very low RTT networks to be able to
+ * control flows to low rates without the need for the network to buffer the
+ * 2 packets in flight per active flow. The rate can go down to 100kbps on
+ * any RTT. Below 1Mbps, the packet size will be reduced to make sure we
+ * still can send 2 packets per 25ms, down to 150 bytes at 100kbps.
+ * The real blocking congestion window will still be 2, but as long as ACKs
+ * come in, the pacing rate will block the sending. The fractional window
+ * is also always rounded up to the next integer when assigned to the
+ * blocking congestion window. This makes the pacing rate most of the time
+ * the blocking mechanism. As the fractional window is updated every ACK,
+ * the pacing rate is smoothly increased guaranteeing a non-stepwise rate
+ * increase when the congestion window has a low integer value.
+ *
+ * 7/ +/- 3% pacing variations per RTT
+ * The first half of every RTT (or 25ms if it is less) the pacing rate is
+ * increased by 3%, the second half it is decreased by 3%. This triggers
+ * a stable amount of marks every RTT on a STEP marking AQM when the link
+ * is very stable. It avoids the undesired on/off marking scheme of DCTCP
+ * (one RTT of 100% marks and several RTTs no marks), which leads to larger
+ * rate variations and unfairness of rate and RTT due to its different rate
+ * to marking probability proportionality:
+ *     r ~ 1/p^2
+ *
+ * 8/ Enforce the use of ECT_1, Accurate ECN and ECN++
+ * As per RFC 9331, Prague needs to use ECT_1, Accurate ECN and ECN++
+ * (also ECT_1 on non-data packets like SYN, pure ACKs, ...). Independent
+ * of the other sysctl configs of the kernel, setting the Prague CC on a
+ * socket will cause the system-wide configuration being overruled. This
+ * also means that using Prague selectively on a system does not require
+ * any system-wide changes (except using the FQ qdisc on the NICs).
+ *
+ * All above improvements make Prague behave under 25ms very rate fair and
+ * RTT independent, and assures full or close to full link utilization on
+ * a stable network link. It allows the network to control the rate down to
+ * 100kbps without the need to drop packets or built a queue. For RTTs
+ * from 0us till 25ms and link rates higher than 100kbps, the resulting
+ * rate equation is very close to:
+ *     r [Mbps] = 1/p - 1
+ * or typically the other way around that a flow needs p marking probability
+ * to get squeezed down to r Mbps:
+ *     p = 1 / (r + 1)
+ * So 50% (p = 0.5) will result in a rate of 1Mbps or typically the other
+ * way around: 1Mbps needs 50% marks, 99Mbps needs 1% marks, 100kbps needs
+ * 91% marks, etc...
+ * For RTTs above 25ms, a correction factor should be taken into account:
+ *     r [Mbps] = (1/p - 1) * 25ms / RTT
+ * with RTT and 25ms expressed in the same unit.
+ */
+
+#define pr_fmt(fmt) "TCP-Prague " fmt
+
+#include <linux/inet_diag.h>
+#include <linux/inet.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/printk.h>
+#include <net/tcp.h>
+
+#define MIN_CWND_RTT		2U
+#define MIN_CWND_VIRT		2U
+#define MIN_MSS			150U
+#define MINIMUM_RATE		12500ULL	/* Minimum rate: 100kbps */
+#define PRAGUE_ALPHA_BITS	24U
+#define PRAGUE_MAX_ALPHA	BIT_ULL(PRAGUE_ALPHA_BITS)
+#define CWND_UNIT		20U
+#define ONE_CWND		BIT_ULL(CWND_UNIT)
+#define PRAGUE_SHIFT_G		4		/* EWMA gain g = 1/2^4 */
+#define DEFAULT_RTT_TRANSITION	4
+#define MAX_SCALED_RTT		(100 * USEC_PER_MSEC)
+#define MTU_SYS			1500UL
+#define RATE_OFFSET		4
+#define OFFSET_UNIT		7
+#define HSRTT_SHIFT		7
+#define RTT2SEC_SHIFT		23
+
+static u32 prague_burst_shift __read_mostly = 12; /* 1/2^12 sec ~=.25ms */
+MODULE_PARM_DESC(prague_burst_shift,
+		 "maximal GSO burst duration as a base-2 negative exponent");
+module_param(prague_burst_shift, uint, 0644);
+
+static u32 prague_max_tso_segs __read_mostly; /* Default value for static is 0 */
+MODULE_PARM_DESC(prague_max_tso_segs, "Maximum TSO/GSO segments");
+module_param(prague_max_tso_segs, uint, 0644);
+
+static u32 prague_rtt_target __read_mostly = 25 * USEC_PER_MSEC;
+MODULE_PARM_DESC(prague_rtt_target, "RTT scaling target");
+module_param(prague_rtt_target, uint, 0644);
+
+static int prague_rtt_transition __read_mostly = DEFAULT_RTT_TRANSITION;
+MODULE_PARM_DESC(prague_rtt_transition,
+		 "Amount of post-SS rounds to transition to be RTT independent.");
+module_param(prague_rtt_transition, uint, 0644);
+
+static int prague_rate_offset __read_mostly = 4; /* 4/128 ~= 3% */
+MODULE_PARM_DESC(prague_rate_offset,
+		 "Pacing rate offset in 1/128 units at each half of RTT_virt");
+module_param(prague_rate_offset, uint, 0644);
+
+static int prague_alpha_mode __read_mostly; /* Default value for static is 0 */
+MODULE_PARM_DESC(prague_alpha_mode,
+		 "TCP Prague SS mode (0: Half cwnd at 1st mark; 1: Init alpha 1)");
+module_param(prague_alpha_mode, uint, 0644);
+
+static int prague_cwnd_mode __read_mostly; /* Default value for static is 0 */
+MODULE_PARM_DESC(prague_cwnd_mode,
+		 "TCP Prague mode (0: FracWin-base; 1: Rate-base; 2: Switch)");
+module_param(prague_cwnd_mode, uint, 0644);
+
+static int prague_cwnd_transit __read_mostly = 4;
+MODULE_PARM_DESC(prague_cwnd_transit,
+		 "CWND mode switching point in term of # of MTU_SYS");
+module_param(prague_cwnd_transit, uint, 0644);
+
+struct prague {
+	u64 cwr_stamp;
+	u64 alpha_stamp;	/* EWMA update timestamp */
+	u64 upscaled_alpha;	/* Congestion-estimate EWMA */
+	u64 ai_ack_increase;	/* AI increase per non-CE ACKed MSS */
+	u32 mtu_cache;
+	u64 hsrtt_us;
+	u64 frac_cwnd;		/* internal fractional cwnd */
+	u64 rate_bytes;		/* internal pacing rate in bytes */
+	u64 loss_rate_bytes;
+	u32 loss_cwnd;
+	u32 max_tso_burst;
+	u32 old_delivered;	/* tp->delivered at round start */
+	u32 old_delivered_ce;	/* tp->delivered_ce at round start */
+	u32 next_seq;		/* tp->snd_nxt at round start */
+	u32 round;		/* Round count since last slow-start exit */
+	u8  saw_ce:1,		/* Is there an AQM on the path? */
+	    cwnd_mode:1,	/* CWND operating mode */
+	    in_loss:1;		/* In cwnd reduction caused by loss */
+};
+
+/* Fallback struct ops if we fail to negotiate AccECN */
+static struct tcp_congestion_ops prague_reno;
+
+static void __prague_connection_id(struct sock *sk, char *str, size_t len)
+{
+	u16 dport = ntohs(inet_sk(sk)->inet_dport);
+	u16 sport = ntohs(inet_sk(sk)->inet_sport);
+
+	if (sk->sk_family == AF_INET)
+		snprintf(str, len, "%pI4:%u-%pI4:%u", &sk->sk_rcv_saddr, sport,
+			 &sk->sk_daddr, dport);
+	else if (sk->sk_family == AF_INET6)
+		snprintf(str, len, "[%pI6c]:%u-[%pI6c]:%u",
+			 &sk->sk_v6_rcv_saddr, sport, &sk->sk_v6_daddr, dport);
+}
+
+#define LOG(sk, fmt, ...) do {						\
+	char __tmp[2 * (INET6_ADDRSTRLEN + 9) + 1] = {0};		\
+	__prague_connection_id(sk, __tmp, sizeof(__tmp));		\
+	/* pr_fmt expects the connection ID*/				\
+	pr_info("(%s) : " fmt "\n", __tmp, ##__VA_ARGS__);		\
+} while (0)
+
+static struct prague *prague_ca(struct sock *sk)
+{
+	return (struct prague *)inet_csk_ca(sk);
+}
+
+static bool prague_is_rtt_indep(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	return !tcp_in_slow_start(tp) &&
+		ca->round >= prague_rtt_transition;
+}
+
+static bool prague_e2e_rtt_elapsed(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	return !before(tp->snd_una, ca->next_seq);
+}
+
+static u32 prague_target_rtt(struct sock *sk)
+{
+	return prague_rtt_target << 3;
+}
+
+static u32 prague_elapsed_since_alpha_update(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, ca->alpha_stamp);
+}
+
+static bool prague_target_rtt_elapsed(struct sock *sk)
+{
+	return (prague_target_rtt(sk) >> 3) <=
+		prague_elapsed_since_alpha_update(sk);
+}
+
+/* RTT independence on a step AQM requires the competing flows to converge to the
+ * same alpha, i.e., the EWMA update frequency might no longer be "once every RTT"
+ */
+static bool prague_should_update_ewma(struct sock *sk)
+{
+	return prague_e2e_rtt_elapsed(sk) &&
+		(!prague_is_rtt_indep(sk) || prague_target_rtt_elapsed(sk));
+}
+
+static u64 prague_unscaled_ai_ack_increase(struct sock *sk)
+{
+	return 1 << CWND_UNIT;
+}
+
+static u64 prague_rate_scaled_ai_ack_increase(struct sock *sk, u32 rtt)
+{
+	u64 increase;
+	u64 divisor;
+	u64 target;
+
+	target = prague_target_rtt(sk);
+	if (rtt >= target)
+		return prague_unscaled_ai_ack_increase(sk);
+	/* Scale increase to:
+	 * - Grow by 1MSS/target RTT
+	 * - Take into account the rate ratio of doing cwnd += 1MSS
+	 *
+	 * Overflows if e2e RTT is > 100ms, hence the cap
+	 */
+	increase = (u64)rtt << CWND_UNIT;
+	increase *= rtt;
+	divisor = target * target;
+	increase = DIV64_U64_ROUND_CLOSEST(increase, divisor);
+	return increase;
+}
+
+static u32 prague_frac_cwnd_to_snd_cwnd(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	return min_t(u32, max_t(u32, MIN_CWND_RTT,
+		     (ca->frac_cwnd + (ONE_CWND - 1)) >> CWND_UNIT), tp->snd_cwnd_clamp);
+}
+
+static u64 prague_virtual_rtt(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	return max_t(u32, prague_target_rtt(sk), tp->srtt_us);
+}
+
+static u64 prague_pacing_rate_to_max_mtu(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 cwnd_bytes;
+
+	if (prague_is_rtt_indep(sk) && ca->cwnd_mode == 1) {
+		cwnd_bytes = mul_u64_u64_shr(ca->rate_bytes, prague_virtual_rtt(sk),
+					     RTT2SEC_SHIFT);
+	} else {
+		u64 target = prague_target_rtt(sk);
+		u64 scaled_cwnd = ca->frac_cwnd;
+		u64 rtt = tp->srtt_us;
+
+		if (rtt < target)
+			scaled_cwnd = div64_u64(scaled_cwnd * target, rtt);
+		cwnd_bytes = mul_u64_u64_shr(scaled_cwnd, tcp_mss_to_mtu(sk, tp->mss_cache),
+					     CWND_UNIT);
+	}
+	return DIV_U64_ROUND_UP(cwnd_bytes, MIN_CWND_VIRT);
+}
+
+static bool prague_half_virtual_rtt_elapsed(struct sock *sk)
+{
+	return (prague_virtual_rtt(sk) >> (3 + 1)) <=
+		prague_elapsed_since_alpha_update(sk);
+}
+
+static u64 prague_pacing_rate_to_frac_cwnd(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 rtt;
+	u64 mtu;
+
+	mtu = tcp_mss_to_mtu(sk, tp->mss_cache);
+	rtt = (ca->hsrtt_us >> HSRTT_SHIFT) ?: tp->srtt_us;
+
+	return DIV_U64_ROUND_UP(mul_u64_u64_shr(ca->rate_bytes, rtt,
+						RTT2SEC_SHIFT - CWND_UNIT), mtu);
+}
+
+static u64 prague_frac_cwnd_to_pacing_rate(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 rate;
+
+	rate = (u64)((u64)USEC_PER_SEC << 3) * tcp_mss_to_mtu(sk, tp->mss_cache);
+	if (tp->srtt_us)
+		rate = div64_u64(rate, tp->srtt_us);
+	return max_t(u64, mul_u64_u64_shr(rate, ca->frac_cwnd, CWND_UNIT),
+		     MINIMUM_RATE);
+}
+
+static u32 prague_valid_mtu(struct sock *sk, u32 mtu)
+{
+	struct prague *ca = prague_ca(sk);
+
+	return max_t(u32, min_t(u32, ca->mtu_cache, mtu), tcp_mss_to_mtu(sk, MIN_MSS));
+}
+
+/* RTT independence will scale the classical 1/W per ACK increase. */
+static void prague_ai_ack_increase(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 increase;
+	u32 rtt;
+
+	rtt = tp->srtt_us;
+	if (ca->round < prague_rtt_transition ||
+	    !rtt || rtt > (MAX_SCALED_RTT << 3)) {
+		increase = prague_unscaled_ai_ack_increase(sk);
+		goto exit;
+	}
+
+	increase = prague_rate_scaled_ai_ack_increase(sk, rtt);
+
+exit:
+	WRITE_ONCE(ca->ai_ack_increase, increase);
+}
+
+static void prague_update_pacing_rate(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 rate_offset = RATE_OFFSET;
+	u64 rate, burst, offset;
+
+	if (prague_rate_offset && prague_rate_offset < ((1 << OFFSET_UNIT) - 1))
+		rate_offset = prague_rate_offset;
+
+	if (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2) {
+		rate = ca->rate_bytes << 1;
+	} else {
+		offset = mul_u64_u64_shr(rate_offset, ca->rate_bytes, OFFSET_UNIT);
+		if (prague_half_virtual_rtt_elapsed(sk))
+			rate = ca->rate_bytes - offset;
+		else
+			rate = ca->rate_bytes + offset;
+	}
+
+	rate = min_t(u64, rate, sk->sk_max_pacing_rate);
+	burst = div_u64(rate, tcp_mss_to_mtu(sk, tp->mss_cache));
+
+	WRITE_ONCE(prague_ca(sk)->max_tso_burst,
+		   max_t(u32, 1, burst >> prague_burst_shift));
+	WRITE_ONCE(sk->sk_pacing_rate, rate);
+}
+
+static void prague_new_round(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	ca->next_seq = tp->snd_nxt;
+	ca->old_delivered_ce = tp->delivered_ce;
+	ca->old_delivered = tp->delivered;
+	if (!tcp_in_slow_start(tp)) {
+		++ca->round;
+		if (!ca->round)
+			ca->round = prague_rtt_transition;
+	}
+	prague_ai_ack_increase(sk);
+}
+
+static void prague_cwnd_changed(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tp->snd_cwnd_stamp = tcp_jiffies32;
+	prague_ai_ack_increase(sk);
+}
+
+static void prague_update_alpha(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 ecn_segs, alpha, mtu, mtu_used;
+
+	/* Do not update alpha before we have proof that there's an AQM on
+	 * the path.
+	 */
+	if (unlikely(!ca->saw_ce))
+		goto skip;
+
+	alpha = ca->upscaled_alpha;
+	ecn_segs = tp->delivered_ce - ca->old_delivered_ce;
+	/* We diverge from the original EWMA, i.e.,
+	 * alpha = (1 - g) * alpha + g * F
+	 * by working with (and storing)
+	 * upscaled_alpha = alpha * (1/g) [recall that 0<g<1]
+	 *
+	 * This enables to carry alpha's residual value to the next EWMA round.
+	 *
+	 * We first compute F, the fraction of ecn segments.
+	 */
+	if (ecn_segs) {
+		u32 acked_segs = tp->delivered - ca->old_delivered;
+
+		ecn_segs <<= PRAGUE_ALPHA_BITS;
+		ecn_segs = div_u64(ecn_segs, max(1U, acked_segs));
+	}
+	alpha = alpha - (alpha >> PRAGUE_SHIFT_G) + ecn_segs;
+	ca->alpha_stamp = tp->tcp_mstamp;
+
+	WRITE_ONCE(ca->upscaled_alpha,
+		   min(PRAGUE_MAX_ALPHA << PRAGUE_SHIFT_G, alpha));
+
+	if (prague_is_rtt_indep(sk) && !ca->in_loss) {
+		mtu_used = tcp_mss_to_mtu(sk, tp->mss_cache);
+		mtu = prague_valid_mtu(sk, prague_pacing_rate_to_max_mtu(sk));
+		if (mtu_used != mtu) {
+			ca->frac_cwnd = div_u64(ca->frac_cwnd * mtu_used, mtu);
+			tp->mss_cache_set_by_ca = true;
+			tcp_sync_mss(sk, mtu);
+
+			u64 new_cwnd = prague_frac_cwnd_to_snd_cwnd(sk);
+
+			if (tcp_snd_cwnd(tp) != new_cwnd) {
+				tcp_snd_cwnd_set(tp, new_cwnd);
+				tp->snd_ssthresh = div_u64(tp->snd_ssthresh * mtu_used, mtu);
+				prague_cwnd_changed(sk);
+			}
+		}
+	}
+skip:
+	ca->hsrtt_us = ca->hsrtt_us + tp->srtt_us - (ca->hsrtt_us >> HSRTT_SHIFT);
+	prague_new_round(sk);
+}
+
+static void prague_update_cwnd(struct sock *sk, const struct rate_sample *rs)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 increase;
+	u64 new_cwnd;
+	u64 mtu_used;
+	u64 divisor;
+	s64 acked;
+
+	acked = rs->acked_sacked;
+	if (rs->ece_delta) {
+		if (rs->ece_delta > acked)
+			LOG(sk, "Received %u marks for %lld acks at %u",
+			    rs->ece_delta, acked, tp->snd_una);
+		if (unlikely(!ca->saw_ce) && !prague_alpha_mode)
+			ca->frac_cwnd = (ca->frac_cwnd + 1U) >> 1;
+		ca->saw_ce = 1;
+		acked -= rs->ece_delta;
+	}
+
+	if (acked <= 0 || ca->in_loss || tp->app_limited)
+		goto adjust;
+
+	if (tcp_in_slow_start(tp)) {
+		acked = tcp_slow_start(tp, acked);
+		ca->frac_cwnd = (u64)tcp_snd_cwnd(tp) << CWND_UNIT;
+		if (!acked) {
+			prague_cwnd_changed(sk);
+			return;
+		}
+	}
+
+	if (prague_is_rtt_indep(sk) && ca->cwnd_mode == 1) {
+		mtu_used = tcp_mss_to_mtu(sk, tp->mss_cache);
+		increase = div_u64(((u64)(acked * MTU_SYS)) << RTT2SEC_SHIFT,
+				   prague_virtual_rtt(sk));
+		divisor = mtu_used << RTT2SEC_SHIFT;
+		new_cwnd = DIV64_U64_ROUND_UP(ca->rate_bytes * prague_virtual_rtt(sk), divisor);
+		if (likely(new_cwnd))
+			ca->rate_bytes += DIV_U64_ROUND_CLOSEST(increase, new_cwnd);
+		ca->frac_cwnd = max_t(u64, ca->frac_cwnd + acked,
+				      prague_pacing_rate_to_frac_cwnd(sk));
+	} else {
+		increase = acked * ca->ai_ack_increase;
+		new_cwnd = ca->frac_cwnd;
+		if (likely(new_cwnd))
+			increase = DIV64_U64_ROUND_CLOSEST((increase << CWND_UNIT), new_cwnd);
+		increase = div_u64(increase * MTU_SYS, tcp_mss_to_mtu(sk, tp->mss_cache));
+		ca->frac_cwnd += max_t(u64, acked, increase);
+
+		u64 rate = prague_frac_cwnd_to_pacing_rate(sk);
+
+		ca->rate_bytes = max_t(u64, ca->rate_bytes + acked, rate);
+	}
+
+adjust:
+	new_cwnd = prague_frac_cwnd_to_snd_cwnd(sk);
+	if (tcp_snd_cwnd(tp) > new_cwnd) {
+		/* Step-wise cwnd decrement */
+		tcp_snd_cwnd_set(tp, tcp_snd_cwnd(tp) - 1);
+		tp->snd_ssthresh = tcp_snd_cwnd(tp);
+		prague_cwnd_changed(sk);
+	} else if (tcp_snd_cwnd(tp) < new_cwnd) {
+		/* Step-wise cwnd increment */
+		tcp_snd_cwnd_set(tp, tcp_snd_cwnd(tp) + 1);
+		prague_cwnd_changed(sk);
+	}
+}
+
+static void prague_ca_open(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+
+	ca->in_loss = 0;
+}
+
+static void prague_enter_loss(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	ca->loss_cwnd = tcp_snd_cwnd(tp);
+	ca->loss_rate_bytes = ca->rate_bytes;
+	if (prague_is_rtt_indep(sk) && ca->cwnd_mode == 1) {
+		ca->rate_bytes -= (ca->rate_bytes >> 1);
+		ca->frac_cwnd = prague_pacing_rate_to_frac_cwnd(sk);
+	} else {
+		ca->frac_cwnd -= (ca->frac_cwnd >> 1);
+		ca->rate_bytes = prague_frac_cwnd_to_pacing_rate(sk);
+	}
+	ca->in_loss = 1;
+}
+
+static void prague_enter_cwr(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 reduction;
+	u64 alpha;
+
+	if (prague_is_rtt_indep(sk) &&
+	    (prague_target_rtt(sk) >> 3) > tcp_stamp_us_delta(tp->tcp_mstamp, ca->cwr_stamp))
+		return;
+	ca->cwr_stamp = tp->tcp_mstamp;
+	alpha = ca->upscaled_alpha >> PRAGUE_SHIFT_G;
+
+	if (prague_is_rtt_indep(sk) && ca->cwnd_mode == 1) {
+		reduction = mul_u64_u64_shr(ca->rate_bytes, alpha, PRAGUE_ALPHA_BITS + 1);
+		ca->rate_bytes = max_t(u64, ca->rate_bytes - reduction, MINIMUM_RATE);
+		ca->frac_cwnd = prague_pacing_rate_to_frac_cwnd(sk);
+	} else {
+		reduction = (alpha * (ca->frac_cwnd) +
+			     /* Unbias the rounding by adding 1/2 */
+			     PRAGUE_MAX_ALPHA) >>
+			     (PRAGUE_ALPHA_BITS + 1U);
+		ca->frac_cwnd -= reduction;
+		ca->rate_bytes = prague_frac_cwnd_to_pacing_rate(sk);
+	}
+}
+
+static void prague_state(struct sock *sk, u8 new_state)
+{
+	if (new_state == inet_csk(sk)->icsk_ca_state)
+		return;
+
+	switch (new_state) {
+	case TCP_CA_Recovery:
+		prague_enter_loss(sk);
+		break;
+	case TCP_CA_CWR:
+		prague_enter_cwr(sk);
+		break;
+	case TCP_CA_Open:
+		prague_ca_open(sk);
+		break;
+	}
+}
+
+static void prague_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
+{
+	if (ev == CA_EVENT_LOSS)
+		prague_enter_loss(sk);
+}
+
+static u32 prague_cwnd_undo(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	/* We may have made some progress since then, account for it. */
+	ca->in_loss = 0;
+	ca->rate_bytes = max(ca->rate_bytes, ca->loss_rate_bytes);
+	ca->frac_cwnd = prague_pacing_rate_to_frac_cwnd(sk);
+	return max(ca->loss_cwnd, tp->snd_cwnd);
+}
+
+static void prague_cong_control(struct sock *sk, u32 ack, int flag, const struct rate_sample *rs)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	prague_update_cwnd(sk, rs);
+	if (prague_should_update_ewma(sk))
+		prague_update_alpha(sk);
+	prague_update_pacing_rate(sk);
+	if (prague_cwnd_mode > 1) {
+		u64 cwnd_bytes = tcp_snd_cwnd(tp) * tcp_mss_to_mtu(sk, tp->mss_cache);
+		u64 cwnd_bytes_transit = prague_cwnd_transit * MTU_SYS;
+
+		if (likely(ca->saw_ce) && cwnd_bytes <= cwnd_bytes_transit)
+			ca->cwnd_mode = 1;
+		else if (unlikely(!ca->saw_ce) || cwnd_bytes > cwnd_bytes_transit)
+			ca->cwnd_mode = 0;
+	}
+}
+
+static u32 prague_ssthresh(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	return tp->snd_ssthresh;
+}
+
+static u32 prague_tso_segs(struct sock *sk, unsigned int mss_now)
+{
+	u32 tso_segs = prague_ca(sk)->max_tso_burst;
+
+	if (prague_max_tso_segs)
+		tso_segs = min(tso_segs, prague_max_tso_segs);
+
+	return tso_segs;
+}
+
+static size_t prague_get_info(struct sock *sk, u32 ext, int *attr,
+			      union tcp_cc_info *info)
+{
+	const struct prague *ca = prague_ca(sk);
+
+	if (ext & (1 << (INET_DIAG_PRAGUEINFO - 1)) ||
+	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
+		memset(&info->prague, 0, sizeof(info->prague));
+		if (inet_csk(sk)->icsk_ca_ops != &prague_reno) {
+			info->prague.prague_alpha =
+				ca->upscaled_alpha >> PRAGUE_SHIFT_G;
+			info->prague.prague_max_burst = ca->max_tso_burst;
+			info->prague.prague_round = ca->round;
+			info->prague.prague_rate_bytes =
+				READ_ONCE(ca->rate_bytes);
+			info->prague.prague_frac_cwnd =
+				READ_ONCE(ca->frac_cwnd);
+			info->prague.prague_rtt_target =
+				prague_target_rtt(sk);
+		}
+		*attr = INET_DIAG_PRAGUEINFO;
+		return sizeof(info->prague);
+	}
+	return 0;
+}
+
+static void prague_release(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	cmpxchg(&sk->sk_pacing_status, SK_PACING_NEEDED, SK_PACING_NONE);
+	tp->ecn_flags &= ~TCP_ECN_ECT_1;
+	if (!tcp_ecn_mode_any(tp))
+		/* We forced the use of ECN, but failed to negotiate it */
+		INET_ECN_dontxmit(sk);
+
+	LOG(sk, "Released [delivered_ce=%u,received_ce=%u]",
+	    tp->delivered_ce, tp->received_ce);
+}
+
+static void prague_init(struct sock *sk)
+{
+	struct prague *ca = prague_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!tcp_ecn_mode_any(tp) &&
+	    sk->sk_state != TCP_LISTEN && sk->sk_state != TCP_CLOSE) {
+		prague_release(sk);
+		LOG(sk, "Switching to pure reno [ecn_status=%u,sk_state=%u]",
+		    tcp_ecn_mode_any(tp), sk->sk_state);
+		inet_csk(sk)->icsk_ca_ops = &prague_reno;
+		return;
+	}
+
+	tp->ecn_flags |= TCP_ECN_ECT_1;
+	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
+	/* If we have an initial RTT estimate, ensure we have an initial pacing
+	 * rate to use if net.ipv4.tcp_pace_iw is set.
+	 */
+	ca->alpha_stamp = tp->tcp_mstamp;
+	if (!prague_alpha_mode)
+		ca->upscaled_alpha = 0;
+	else
+		ca->upscaled_alpha = PRAGUE_MAX_ALPHA << PRAGUE_SHIFT_G;
+	ca->frac_cwnd = (u64)tcp_snd_cwnd(tp) << CWND_UNIT;
+	ca->max_tso_burst = 1;
+
+	/* rate initialization */
+	if (tp->srtt_us) {
+		ca->rate_bytes = div_u64(((u64)USEC_PER_SEC << 3) *
+					 tcp_mss_to_mtu(sk, tp->mss_cache),
+					 tp->srtt_us);
+		ca->rate_bytes = max_t(u64, ca->rate_bytes * tcp_snd_cwnd(tp), MINIMUM_RATE);
+	} else {
+		ca->rate_bytes = MINIMUM_RATE;
+	}
+	prague_update_pacing_rate(sk);
+	ca->loss_rate_bytes = 0;
+	ca->round = 0;
+	ca->saw_ce = !!tp->delivered_ce;
+
+	ca->mtu_cache = tcp_mss_to_mtu(sk, tp->mss_cache) ?: MTU_SYS;
+	// Default as 1us
+	ca->hsrtt_us = tp->srtt_us ? (((u64)tp->srtt_us) << HSRTT_SHIFT) : (1 << (HSRTT_SHIFT + 3));
+	ca->cwnd_mode = (prague_cwnd_mode <= 1) ? prague_cwnd_mode : 0;
+
+	prague_new_round(sk);
+}
+
+static struct tcp_congestion_ops prague __read_mostly = {
+	.init		= prague_init,
+	.release	= prague_release,
+	.cong_control	= prague_cong_control,
+	.cwnd_event	= prague_cwnd_event,
+	.ssthresh	= prague_ssthresh,
+	.undo_cwnd	= prague_cwnd_undo,
+	.set_state	= prague_state,
+	.get_info	= prague_get_info,
+	.tso_segs	= prague_tso_segs,
+	.flags		= TCP_CONG_NEEDS_ECN |
+			  TCP_CONG_NEEDS_ACCECN |
+			  TCP_CONG_NO_FALLBACK_RFC3168 |
+			  TCP_CONG_NON_RESTRICTED,
+	.owner		= THIS_MODULE,
+	.name		= "prague",
+};
+
+static struct tcp_congestion_ops prague_reno __read_mostly = {
+	.ssthresh	= tcp_reno_ssthresh,
+	.cong_avoid	= tcp_reno_cong_avoid,
+	.undo_cwnd	= tcp_reno_undo_cwnd,
+	.get_info	= prague_get_info,
+	.owner		= THIS_MODULE,
+	.name		= "prague-reno",
+};
+
+static int __init prague_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct prague) > ICSK_CA_PRIV_SIZE);
+	return tcp_register_congestion_control(&prague);
+}
+
+static void __exit prague_unregister(void)
+{
+	tcp_unregister_congestion_control(&prague);
+}
+
+module_init(prague_register);
+module_exit(prague_unregister);
+
+MODULE_DESCRIPTION("TCP Prague");
+MODULE_AUTHOR("Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>");
+MODULE_AUTHOR("Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>");
+MODULE_AUTHOR("Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>");
+MODULE_AUTHOR("Bob briscoe <research@bobbriscoe.net>");
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION("0.7");
-- 
2.34.1


