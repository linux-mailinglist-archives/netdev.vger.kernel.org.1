Return-Path: <netdev+bounces-206079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22CB0144E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7786D5A385E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF431FDA8E;
	Fri, 11 Jul 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wzv+FXHq"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0641FBC92;
	Fri, 11 Jul 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218271; cv=fail; b=KZm2bBdVwWd4du3fsxRGCpn5S/4XKsRHjHzkbxNh3NcIR/lnUJjF8iXrabNmTC/6Gwesdku0wycTc27CTUXchu4O+3iaU0wwxQlN7yMwxvHo2+0AoidJKca3vXViovM1NTR3cDCbiEVYQigTbTTRcFT960F+/29xClB7UemDo/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218271; c=relaxed/simple;
	bh=tDXPeJTHBw7PJcUxZtcm8vE832lweK7KRjoNsvxmX4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvWq3UHDX95mtHCSJ4oekWFWON6ZA4iEerOV3Nr55kXbMJsT1pRI7vr8j8Ecij75T+Dy1aIiND0BJBppMwkXT45qJgxx/nhTumGaZkEpzAhJF06AkZR68J4GTKaCBl40dzU0kem/Ad4xqnSxIuRDKlO0hEgFq2X+09zQjwnZbhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wzv+FXHq; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L54nSwGHd7abmUu9wG9ET/QyTugoNqXAPeoEg6jYKHPyeYXFLe9y9ZOJwC+TZ26KXctIrm2SfzbHFcnG+RyQlSEsp2Ku5XC2sktKgbGXe84k+OK9H/pXg1tUOH8xTW1o4WYZUiDryFEBtyFpAfiiCYwcsceuzFvaGmHxb1n/pOiTYuJ6DLkyL1VzoEYUW0Iyhts/0xKF9wWRuIOVCnSfEz1bU1kpS6EgIj/lHSr/DhwkKN8cy+v8wF01naYKgU6L5FNUZvszZhppoNtXRfROjFx7YhYGWqRRMEcMOZhUQ0KD+xuI3sa3l14Pz9DKqjL43SMXAMBr3OCWe3Kvx8abuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ULgX5rTBg5zwLPPk8KnuFLcvkOa9Vc4w4vmuVQT+DU=;
 b=oEJifz7lhqVU7AlF/C5/LMHeYY4S+IWKp9vpraPLcNZ/sL9UeL3Xj43ncW/TgvRB/oTTzBOgWwRfqH9BvsDld/f7cgUj9nH4VxhuDGrMt2vxxcJK4Q0wtMsPEUGbLmwNU2rd4dO2gbjbLuqP5QId4GUcmK99oy/Aqk12y6aJaJuloF3/oCvuR7GBi6Aiqh/MXoGYbTr1XUMkInElm8DF3GPxjTWF4MZ0ODIKsLviXP70jq+/ZIlhNIGzj6BPOBV84LGIBTB/Citydpuy47B1zVs2PGuia6zYN8p4S9inXMTtzUqcwQtRdIMxSrF5zch7+6vF7ZWcIbppUZyU45L/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ULgX5rTBg5zwLPPk8KnuFLcvkOa9Vc4w4vmuVQT+DU=;
 b=Wzv+FXHqAYFdB5VgQYItStmaPhpy6dbWrCugTrwOJevFezR4sWgIJXn2qEDI6ZbvAQlaLsq33gUU+Adk7uh1fnx5olOzBtIH6gN2hmeev59MgyS8lJrhzTi9kFhiIEXuJg2ixNutRA2O11YYtUL55KpK8KhEip5QMa0NlbIA2IklwTd/XwLKlPaJH3BRwihLxPjOmRFap8/QqIycCbiyj2SaGheZta5XgwM4oqdvakCaUb5lyYakWCz0gdAMCA4bzHh2FSgQinq1LvMjPFKZOxH5wQImpkykO9lpChcfME8zVY5YjwhlTFDg8nr6Ray2j079SzUL1piHvDq6QlWo/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 06/12] ptp: netc: add debugfs support to loop back pulse signal
Date: Fri, 11 Jul 2025 14:57:42 +0800
Message-Id: <20250711065748.250159-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b226d39-c99e-4a8c-6912-08ddc04b0935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iu9rxIBoEq2ciPWie3U0g770lrs84vVnOV4W0/uPV5HeXpcaz7tzBY8h8/TZ?=
 =?us-ascii?Q?5PEE3fUPDUfnti2gM9jS9AOBvwBIF9pCzoU6xYWXQnALfzwG9Kzu06Pdf9IU?=
 =?us-ascii?Q?NMOQFkjcOj0seNfkeGmkEGU/Gg3e0tR31DiTYcllGav0bRxujkvCdRiDudeE?=
 =?us-ascii?Q?zBu6BuNZD4sBL9peCL7Ithq/x+SfQ3hUFivaBbTSUE29o0QxKG6cK7tsqW6M?=
 =?us-ascii?Q?bj+7aUs8iN1r/6XEr5lfxve6Y3+0euozyBu2MhJBRNfmLmA2FtrlXqPGGvFX?=
 =?us-ascii?Q?AlzdinglWZoKWHujdcXW1KUEyixE02JwDBgIxkmkDqI8bq9FqrrPVKyi6stc?=
 =?us-ascii?Q?zn7UBJW3XlrDcdwHoD3aPOIjmAf7TPZ4yau3F6MaIMv1wEsiRPunjWPbEcXM?=
 =?us-ascii?Q?rUa6WnOiOpK+0KvVdeGBOszCVwoEgezno0tsxHkqVpsCJA9N+zxFZTc5aJYr?=
 =?us-ascii?Q?sSxGY52rEofzzOPGc++c83sCDIU4Gj2SpLUlRgCaj+Cp/5e28QD7DWcktZTG?=
 =?us-ascii?Q?XrznR6FZqtgzbK/4X7Lntrj2gaSeLcOcnRlQsQXHrYKJC6V5Rne0ZLxOrN/7?=
 =?us-ascii?Q?S6g3bCqUel/ZmSqNC65t6xUttyMWL9MBbwe2oq5KDWIo2IRWZyAiGITZ6E1c?=
 =?us-ascii?Q?SqOF2HRRiIeaDuD5kjE5qBSRtsOXAJEG3Puxcpaahs6WHULpTpMi5UDKqCVZ?=
 =?us-ascii?Q?GaWRSbYrimVufdTU9RkgpXyjNpFgngvYIO2VswabNvYfQtjophGVkZdWRDC6?=
 =?us-ascii?Q?PQR0JaHevmZTReTEpB1sZfEBs/DQ/wI/5OvmtQJpnkKE1bqYOAHQvbI1t0Gg?=
 =?us-ascii?Q?wjmZ5ZbgH5EBpUUr9eviUXBC022JnFQgOpe1qcFmjzOaJ4t6eD+B99SUUvyc?=
 =?us-ascii?Q?ipPTMDOH4IQqTlNT4IPxfUjIZl4K9qCGocR2CXg/f0hh13vN1jxzgML3PogU?=
 =?us-ascii?Q?9VHcBIvU7/h0LddT10S5nr6dnrFV8a6KGWYEofKgamgTTRfF5Zye8Fyk35Ff?=
 =?us-ascii?Q?+D7/t0YxxxPlwZ1/ddX1+INPw1y9HGEZI4LcZJXSFJkEoncm4BWVkOmPh3cF?=
 =?us-ascii?Q?CoQFWj6FUubuL5PeK/s6S0KkgreMZFz1JEeq5CVttRUcCmppjemaHuJQ6jED?=
 =?us-ascii?Q?qaC8XEJ5+lSiX1440ZKV0AU4WZjMAzz5WHBJmc3KhSvUH2TradYuqf05v1jF?=
 =?us-ascii?Q?ir/GU5rOvKqqAsofUgpKkpFbFFycCQaFuAEkPa4RJSyqRk8SCm6qPfNx91Aa?=
 =?us-ascii?Q?NHSDyzxPyGWdLLyj18wLirZIOMxdzoaY4nAql08jpDQMUxHY5TVEM9aTFH1x?=
 =?us-ascii?Q?wMPlstb/GPI6645RewO/v1zp1M/cqXb2jU8zG028OJ5Rbh+wXwBsF6r8VZlD?=
 =?us-ascii?Q?le+HrQuSFLQx58TJ5mUDqZiwzF4+RS38RMmHIcKU2wLs4wkqZG1vW9oW0EZy?=
 =?us-ascii?Q?o3WvQmZJPKPSOJA83wP018fGnbZPktJXCr5zv3sl1JcAoI6WHX4ZOk01Mncr?=
 =?us-ascii?Q?470QXn2+bOeWqnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2sZarCA3m1NHBJpQ1R1BK8sPMRFPTt8RHDdUwK8hRT7qzK2laXiPrHHvpCHM?=
 =?us-ascii?Q?4KHUEKEpyU935meGEQ1xJmgZIYhTkhPCZPI3uHibbAvTHgWcYGJquKriBali?=
 =?us-ascii?Q?kHE9PvoG14aqZY0pk1pkRvP0FZ5lErcx8nfO98r/fQ9396zHVaW4EbQh9huL?=
 =?us-ascii?Q?p5jBOW8eFi7LWNDCKDFlX+oykHoCJex422ZVI0H8KZwTlvNOg8CC6Ia5kq+8?=
 =?us-ascii?Q?OGYgc46OYbt1vsf+wq+KrfXyDnxVxgomoI3UVI98kLAKi1+adNXM2uHLtAR6?=
 =?us-ascii?Q?dC/MWeGMro5kpJBOCQEUIz+K5cki7GAIFY4myApdnGwu4ibbgb4KltY1x50m?=
 =?us-ascii?Q?3EyHU24OghlobbqH7LexrYRjTMwdJrwIzRbsSji3xeQctT8a4dzX1VbJGSkg?=
 =?us-ascii?Q?Lk64TsJYbIht4u5L6z2+eqYzidrTCLOHUv6qgLhFBxOqT42p6A6C6Q6Q6CW4?=
 =?us-ascii?Q?AAIJxTdV43h+oxpSBx3DzZRnnIuL/qm/6pRiLW6jllzPLTT8mro3YUIohgqE?=
 =?us-ascii?Q?4xAZbxa+DMQRtxl912Bh6PW2LcmQvlcL4IrvnUWiJCCCA1SCC/omWo+E1ZdJ?=
 =?us-ascii?Q?CaaTCp7N7APySPnObhtCsEriPhToM3MWn3Ycp8c6pq8isXyqrB/OmiDfhWrL?=
 =?us-ascii?Q?/11V96AplN2KFMypyhv8P0/pm1ban1HN8rWTr+q2L7mWLbHHU1Up9rqZYi0a?=
 =?us-ascii?Q?YzSY3Z8UsrS0mc2zYLgifnR/1zk7bNM1cTUcY1KAQdD5pVCJ2FbeDwKBQRV5?=
 =?us-ascii?Q?eXdxaMAYL6BCiaLWs8/2E5beTpy8vOHMkdDhfN/iqpSz79IEspWC8acwYhpQ?=
 =?us-ascii?Q?rhB7XMUozAoGEZLFA1T7o8axCyAka2cSwvR82ZaqgY4+z8bW1ZyJWB5/z5be?=
 =?us-ascii?Q?vLb+qrMR/lTUB+t3OzpBCTjFggK/JOWLDzpPVlWbUnzRa3jgvoKUFt6M9qK6?=
 =?us-ascii?Q?/nRUIguyL9/2G+wj7L7Zma6mdoxr3X2xcDf6SrkFe8R9iXbOUwBaEPFWLN1g?=
 =?us-ascii?Q?ogxiGP1FslrgOkiv6nPY7Ap6+L/+0sGlQ+zf0pucFOxdt95clv0DnuBlA1sB?=
 =?us-ascii?Q?lstvYIpi6WQdR3shD0HT1d/04p63O59aI/GE8LOU7X7uYm2ykSozua3JMEvl?=
 =?us-ascii?Q?W23Rai0zzkPv/85tibTgnALaHJvIZJYFDyxGPX5uLsmdPQ4HKEglSfG/bqpp?=
 =?us-ascii?Q?QN8sHgcPD7VU9zAKu0qMZTo2oOJxeEHLWlrd1zX8xXxPj9u3Or76Xry+xqFY?=
 =?us-ascii?Q?zW1sQycPlVAZLpFRhFX7Bp/VZ9o0Gg+TWOBn4qzHV/0hQ25pKNXd96xgxQjF?=
 =?us-ascii?Q?kCWILRwfagCcFlJFFSgs5Y29tlbPSXp3aRk5+/T7z/ftysoAX5YYW8TEpGcc?=
 =?us-ascii?Q?h/kBsUMP7iIij2IYMTNQi2PSV7iZheP5YSNsNUrivJsVtpLpSHq8x2kvNhS9?=
 =?us-ascii?Q?C3WvCJQfRKH2QYCDaGA4jQSENvdDhWHB96Of3tyKM/jG6vCticwHjJjats5i?=
 =?us-ascii?Q?gqLl7ghitt1/rPrt72EmKmqrc297x7f+uthG1w1kHg/QECXSP0hJei0cLpYq?=
 =?us-ascii?Q?0+Y/1YyegfAW7uTe0Kr1aNqoAlXEFL3J7Kv7uBQm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b226d39-c99e-4a8c-6912-08ddc04b0935
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:46.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXanNaP2GtDra5dDsput336B6ORxm2PgbzRf5ra9WW1/thwJTt4SvZCqSxB1DlbDadCEpoCEI/C4AJIPHUOCXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

The NETC Timer supports to loop back the output pulse signal of Fiper-n
into Trigger-n input, so that we can leverage this feature to validate
some other features without external hardware support. For example, we
can use it to test external trigger stamp (EXTTS). And we can combine
EXTTS with loopback mode to check whether the generation time of PPS is
aligned with an integral second of PHC, or the periodic output signal
(PTP_CLK_REQ_PEROUT) whether is generated at the specified time. So add
the debugfs interfaces to enable the loopback mode of Fiper1 and Fiper2.

An example to test the generation time of PPS.

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 1 > /sys/class/ptp/ptp0/pps_enable
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 108.000000018
event index 0 at 109.000000018
event index 0 at 110.000000018

An example to test the generation time of the periodic output signal.

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 0 260 0 1 500000000 > /sys/class/ptp/ptp0/period
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 260.000000016
event index 0 at 261.500000015
event index 0 at 263.000000016

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 119 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index b4c2f206752e..7f3e401f51c5 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -21,6 +22,8 @@
 #define  TMR_ETEP2			BIT(9)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_PP2L			BIT(26)
+#define  TMR_CTRL_PP1L			BIT(27)
 #define  TMR_CTRL_FS			BIT(28)
 #define  TMR_ALARM1P			BIT(31)
 
@@ -128,6 +131,7 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct dentry *debugfs_root;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -1003,6 +1007,119 @@ static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
 	return val & IPBRR0_IP_REV;
 }
 
+static int netc_timer_get_fiper_loopback(struct netc_timer *priv,
+					 int fiper, u64 *val)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	switch (fiper) {
+	case 0:
+		*val = tmr_ctrl & TMR_CTRL_PP1L ? 1 : 0;
+		break;
+	case 1:
+		*val = tmr_ctrl & TMR_CTRL_PP2L ? 1 : 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int netc_timer_set_fiper_loopback(struct netc_timer *priv,
+					 int fiper, u64 val)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	switch (fiper) {
+	case 0:
+		tmr_ctrl = u32_replace_bits(tmr_ctrl, val ? 1 : 0,
+					    TMR_CTRL_PP1L);
+		break;
+	case 1:
+		tmr_ctrl = u32_replace_bits(tmr_ctrl, val ? 1 : 0,
+					    TMR_CTRL_PP2L);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	if (!err)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
+}
+
+static int netc_timer_get_fiper1_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 0, val);
+}
+
+static int netc_timer_set_fiper1_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 0, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper1_fops, netc_timer_get_fiper1_loopback,
+			 netc_timer_set_fiper1_loopback, "%llu\n");
+
+static int netc_timer_get_fiper2_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 1, val);
+}
+
+static int netc_timer_set_fiper2_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 1, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper2_fops, netc_timer_get_fiper2_loopback,
+			 netc_timer_set_fiper2_loopback, "%llu\n");
+
+static void netc_timer_create_debugfs(struct netc_timer *priv)
+{
+	char debugfs_name[24];
+	struct dentry *root;
+
+	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
+		 priv->phc_index);
+	root = debugfs_create_dir(debugfs_name, NULL);
+	if (IS_ERR(root))
+		return;
+
+	priv->debugfs_root = root;
+	debugfs_create_file("fiper1-loopback", 0600, root, priv,
+			    &netc_timer_fiper1_fops);
+	debugfs_create_file("fiper2-loopback", 0600, root, priv,
+			    &netc_timer_fiper2_fops);
+}
+
+static void netc_timer_remove_debugfs(struct netc_timer *priv)
+{
+	debugfs_remove(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -1049,6 +1166,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	}
 
 	priv->phc_index = ptp_clock_index(priv->clock);
+	netc_timer_create_debugfs(priv);
 
 	return 0;
 
@@ -1066,6 +1184,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	netc_timer_remove_debugfs(priv);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_free_msix_irq(priv);
 	clk_disable_unprepare(priv->src_clk);
-- 
2.34.1


