Return-Path: <netdev+bounces-207389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45BB06F81
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D545D3B3AC3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73FB28FAA8;
	Wed, 16 Jul 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V1IaSyEN"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176328C841;
	Wed, 16 Jul 2025 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652284; cv=fail; b=i4RXR+eu5cArQEl1D0tz7Qim8+NO9cJq4dyabvDhbBToiuRnssBDq870anIweN1WBeeNoOCPfh8iUi67hagJxWpk839UyztT0k0gNy64PMJrC5wIc65khWL/IpHvJ2uQ5/9arWgpgacEtmNGALOgoLUGb4+XoebLJUHGUHozabs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652284; c=relaxed/simple;
	bh=ngLzBEoyyOmgJ42PsvpLgE5+eQe78P5ki3ZGqQy+R4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Llu/FRs4xat21Y+b1TFAjrezn9D2pyc8rbIi5bVWrhrRAqxqXPafxP+opOTfjah8yd5OcH2jcCmVGhsyLJ8njy46HmlvaYDQ0ugwr1SBxNVHGUVBEa32kw7H/frefil0/aVR52OQneWfWh0ZZUoklHScou2nhFastfZUB8OFpik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V1IaSyEN; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISd/TraCH1ZmKBwU7lH3iPMdM/K934AGfrysraBynekowfWGF6wcHnHcByLc/ZutF1wFO0dqUjkKwx9bugrB2lsvHOiuOaz/aPgIpDVs6f89EIGq5t4FYIs5nEf5LnRhK7a5wzuNbZemNX6qEgOrmVYmss+6ugY8WBGLjkW//4Nx1Z6Zw6fegS4Laik8i6HJ8Td6sn1Kb+f9jcLlEQYr2628rM4s3iHL+a0H4OMZOo7Z/SlZi0n9kXsZ3I0wjnwR5w1b2Ui7nrFpD96gnbYolhbwh+FmnpNYRQ0zREWn8NajRNECN/UbfJqMKTdMzQKVl2JeAT7SA8bYhKDN2qQHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DffU+YGmKKVlmrRpPGkKfmPD1ATw8sZTXvIVbogdhMM=;
 b=JRdoVPxfm5uLHsQjadexwVCnHQ4DX2KyRCh2XK3Rmhk1OuUqvuYjsZ/4RJg65kGv4M+o51hTWVMgXaWpcc+8zlFaAWOIWRhKxWWKjB+baSYdd/ugG+HoGtwbuIdU/aaoDPGshYFagyeazWozVbub2vNzCRwmpd7/HxmyteJ7B+fSD2BYxDPtI1GMj+z8aEpT8AmYXd+pOkDTf/NYpE7eqzO2gO7nLjt7mp881ymuUWYlaUhE5YjQMFsIkNKi7OtC0OIzI8q0LXo+2vESPN0ig1RUrOh8aQB2CUaQtShOcrv5gA0uhFYkm7N4g9D5tSEAHEBiCshuViyBP0hyeR2Cmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DffU+YGmKKVlmrRpPGkKfmPD1ATw8sZTXvIVbogdhMM=;
 b=V1IaSyEN+yLdzstjCIysxx82lG+ZCzry/LBBtuA9IOHlaBiwzSf1ThhFkwRX4B1ZNsddzMoYKPGvBSEgAkJZ6miNfG4+Z9+7qip2T0HwxbNk587vLVZAhrlAlCzNjqcsnrDoXziuFZzB5nIAIJxd4I6a+uE/0OJ1m6hFc3jAGE6RUFBNS7/2V2M8JUGurxKiwQ6X/Vm45UtcOXXaQIF8afju4LLZFBU0u/Ra8rNnRLmZM2BFfUk+rZ40S7+FOymiCZQMeAjEXbFO8s3yvHuEvxLmdxnGHlRJGDUxjqfsyI70gXUFtcwt/M7cnjkf7r8gNZHSnbn8CpEo5oAu+YL5/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:19 +0000
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
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 03/14] ptp: netc: add NETC Timer PTP driver support
Date: Wed, 16 Jul 2025 15:31:00 +0800
Message-Id: <20250716073111.367382-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 62327ecb-f0e2-44f4-ae7a-08ddc43d8ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkhKwnGKwJCx0TduVO6RLUiUESkLzFRDBlwfxVo5z0rD4qNJOXdNqJdzIiSV?=
 =?us-ascii?Q?zJUFN8gEMQN0qj3ZopEvM2q5VpBo59KKhWuyIRk7W9YC+jeTzIEyEyq0wUya?=
 =?us-ascii?Q?tHq5uNns4OuqKIzu3KIF9LEm1BaCtjt9mbIFgjWUs7LNvXD0lkvRUG+MLbnV?=
 =?us-ascii?Q?znPdmFIZd3yXQJeBRxvNpD1GrVTGooya9rr34AO6+UTryAhW46sOoWVD8KWe?=
 =?us-ascii?Q?eYeYGF5JidSGJX0EbMU+0Yn6+desM/5Vi8WM6GLeBPkyLSqms7b0Jdtyd+b0?=
 =?us-ascii?Q?6sb9avyyBgLou5JkBaY06rNQMajE4FpkzbyPmMKu9ItYnMcaWi8jns2NBrII?=
 =?us-ascii?Q?HrJRzUPaCG56aPtylaqCBMdxlCXZpguHp+r1ETQuKIk6BS03za3xrqos7Qwb?=
 =?us-ascii?Q?I1JgGkHFVtG5LIRdHg9GFfUOsahoaicl5P4u2QEeayyLWca+S+yJKnCR/ttZ?=
 =?us-ascii?Q?AWjkVrJhbxxIcpua3Jbzwg3d/yLcIfPl/EGWIV9Vo36LfFKmLvaHJiLi5OD3?=
 =?us-ascii?Q?Vdc7TcK8d1qQ3BROLp9ms3HNyQMCn6JNP9lhKQKrsAM+gZuorN2mA9Uq2HKb?=
 =?us-ascii?Q?Es3nM+8oMTKdmtNRi7yp2g0dvmJ9xORZkI7wgV9AT3MeliRxw6rznT5JKr8F?=
 =?us-ascii?Q?4DZGMFIYdmdbUC3CuJXnA9VmlGcE6AmJ578yAiTIC6RPO1CoWyOCoBmuTbbN?=
 =?us-ascii?Q?3iCYbYH6ixPS7NRUpncvsU6nbyq61tVS4Y03Xjc4Q/FDFAoLHaG8PWzndr5x?=
 =?us-ascii?Q?ScnMIjulwG3t5yqdusmciGI6XQ50QWJd2z1PIzoHsAX29CGDmfFnHLmZ4CGm?=
 =?us-ascii?Q?kC4LnAhpZw0y0B3pE2RmBT+6f2ZP3f/ZLbN5ydczXUh/RkzcXABMl4QuSjwn?=
 =?us-ascii?Q?gydEGQU7xAbwddpQgBgDr5LzmURylulzVbC9/hVf25zwvbDT/Kxiz99BJyc8?=
 =?us-ascii?Q?lgH4y2J1/vHbM3wJ5UYtP4Fq5UACTHqltraIC8fB7L9x1B6jMoQVOiOio/VW?=
 =?us-ascii?Q?kpKRBRpsA5RRKBG/zXzFiu0Qll8LF3GilcRgLw9KOjNy6+df4+yLT42pBAup?=
 =?us-ascii?Q?ckH4v0OHw9NL8GjM3XpkIAiGxviwRKUnbgbY7z4OifY3HrNerHvDrdxgqmlv?=
 =?us-ascii?Q?tuRHd5O/3ddR9u95c3PAOevTq+IHfJtbUaP598FnhDLRFbZTUa2c+hRceTep?=
 =?us-ascii?Q?99wQvNNYMLpLtNFP2zWwvRGJE83+4uFmtov2uLS/7jS6/fJ8/MJOmA9tMgdo?=
 =?us-ascii?Q?pCqZqoW1RcyuUEuuwA07kIGjNalpCpm6gjN/4aj+cXRR4in95zVAqMm5HY/4?=
 =?us-ascii?Q?pfnVwlG15lggkCaEBkSgbIqdPSmFx9T23eGFzgJk/3gQajnwRzVDUW/9r/EQ?=
 =?us-ascii?Q?d4FGtUCdzqkG+jwDucbMasM/rV1omrkS/ndFN6F4hyNCDNAXO7HE9lBHQvvQ?=
 =?us-ascii?Q?RlJ8AKKCbWkULhj0NaHrl8DQd/ikrlXxBY6HzlaezJ9Vm6Guf5R7l9alzdmu?=
 =?us-ascii?Q?gSMWK3y+qsDkPjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ynlsZ94MxFU5hMMlsfMc0375i+WBbravQwOcGoj4eoDAjqc0lGD+pE8qETo?=
 =?us-ascii?Q?d3GwZZ6w9dIMGS1A/qLMpNgv6isOb6TnL4OxtiFx2UOvjPDAQd2IQoM0YUdY?=
 =?us-ascii?Q?Tyviz1eCadkBYPRO+FcK785j5FHd7wo/z+0diVTogWPjV5raogbchn1MgP6H?=
 =?us-ascii?Q?fpr7H0VV05aKHoSdiC6/1MrreGVST/K7uiRL8Hlp04NWOGF4wRDIo7rTcBlq?=
 =?us-ascii?Q?5UgG41Hv0H50QG3PJgUt//5OXLERf44d3wahP1Qy7vnVsl6SvWcLfCCCmki7?=
 =?us-ascii?Q?w/N/gsuo8mFgZ0lWg8+9PdU66ls8I5TBfyi88Rx95SUgo3ElAF9zNwsXqg1f?=
 =?us-ascii?Q?dJTL56P8PF/EkL2/gvWBaAqtnedFnC7lrk0qlmiNXjuvx2kf3Wb0k3wSzD04?=
 =?us-ascii?Q?IUpULyCzNnS6I5LQEZkNaJKsuIC3VDxJTsz21vA+GRLmoxgxoN4dFdOVNwb3?=
 =?us-ascii?Q?utJb1jD9KUQqwqLxdZTMNcUHKSa1hjNcfii5iYB6aiXlhN9fjX2UHERZ7oW3?=
 =?us-ascii?Q?a8wsgNX67EtIhxuI+4PlhZEou26MkbPMPHJiI5iCpI/3gH+z5roruxyCSWJb?=
 =?us-ascii?Q?YtrHvdsaoVyqYCPJlk/Z24WeRuT2pQbx55+GNK2fP//KVX6YCK6w4RNKztOt?=
 =?us-ascii?Q?+coNfEHKSyiCLvzUJ7oPSvFuBV5sn6I0T5Z1Yh3LP8hiCRwFzLn2OnRKkapO?=
 =?us-ascii?Q?ibsXX4lU5m4tRiI60Ay+vSfXk2yep9ryF+UNGuG4PyWVvakR2cXexRDQiH5a?=
 =?us-ascii?Q?gd7dHsAI/bI2C9Dc6uEM/P6pBF9Wng4fDecWy3zm0pczkDvRWOVW0Z/oEEFG?=
 =?us-ascii?Q?a6Z+6oZhor8MpiFLxzytJwU0HkEgYXTIQAl0Q/YB6zhh2RI9KuW3Lt2VfANs?=
 =?us-ascii?Q?33KDy9My+UHHdikr/d0l0PbP+ziampSQwGXu5HmHLN2Mnn0rdGqpYZmNXDJK?=
 =?us-ascii?Q?jPyvGZ3GBr1C5abnaQuqjQ5TTuNnNuPPkBtWZgNh+BblYCKFJAqCroqmwvli?=
 =?us-ascii?Q?kRGVQNC70Sc5B9oichqHPWmQ65xiUZ7iR1H3+DszoPpawK/fCqfjtni5cCj0?=
 =?us-ascii?Q?dengWAskBHjQY3VBcq7Qke2c66cePOHDKT/guFJvpwjUFadumPoUmdNt7vMQ?=
 =?us-ascii?Q?x99tY69/Cos35wmKDMS95MB4mKiPoX0WWxMdPlJzKNLnLRMXX+YdqOMEotW9?=
 =?us-ascii?Q?mTaLmz1z/rd8406dAEpH/Av5mFkOss6sUPtGSMyia6T04bcS3PXmf70HZ1aP?=
 =?us-ascii?Q?P3Guee86Qy3KQrWER8NHjLk/MdJ2eM0zULd33w/162AF50qcgPLMm0PmI5Tn?=
 =?us-ascii?Q?a4qCC7EDFLRzaU0uZcw3UxB4miSM6se8ufZ6yWSTnDfXTpJzdKo3ZnibJbTA?=
 =?us-ascii?Q?318XqdPFmcRBQUY2rLDXHMizuKDJgbvwYkIg9FonTsKG82xhAhBDvOy4PpRv?=
 =?us-ascii?Q?AZRPNFU3QM+bQQv5+uIu7HhwaeNTUQGY5ccsetTzchtoQXrYbZzTY+swP1Ep?=
 =?us-ascii?Q?8EgWst6FzVTJyIyXya5d0rTpfdjWk8jbccu08nVrcwgA4IbUnFF7a5FZj1oM?=
 =?us-ascii?Q?EN8s1uxq6WRBFAuw+VWgYLSghzC+UN9Z+Dz3NCkw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62327ecb-f0e2-44f4-ae7a-08ddc43d8ca1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:19.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3WMlwO++jwuMWAFTiOOlhR1i/+9+MATDSh7IByPsuCFTYtxhUjB0idPh42QKg3y0S2cbV72kMEQA0NvYDQFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

NETC Timer provides current time with nanosecond resolution, precise
periodic pulse, pulse on timeout (alarm), and time capture on external
pulse support. And it supports time synchronization as required for
IEEE 1588 and IEEE 802.1AS-2020. The enetc v4 driver can implement PTP
synchronization through the relevant interfaces provided by the driver.
Note that the current driver does not support PEROUT, PPS and EXTTS yet,
and support will be added one by one in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Rename netc_timer_get_source_clk() to
   netc_timer_get_reference_clk_source() and refactor it
2. Remove the scaled_ppm check in netc_timer_adjfine()
3. Add a comment in netc_timer_cur_time_read()
4. Add linux/bitfield.h to fix the build errors
---
 drivers/ptp/Kconfig             |  11 +
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_netc.c          | 568 ++++++++++++++++++++++++++++++++
 include/linux/fsl/netc_global.h |  12 +-
 4 files changed, 591 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ptp/ptp_netc.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..3e005b992aef 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,15 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_1588_CLOCK_NETC
+	bool "NXP NETC Timer PTP Driver"
+	depends on PTP_1588_CLOCK=y
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC Timer as a PTP
+	  clock. This clock is used by ENETC MAC or NETC Switch for PTP
+	  synchronization. It also supports periodic output signal (e.g.
+	  PPS) and external trigger timestamping.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..d48fe4009fa4 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_1588_CLOCK_NETC)	+= ptp_netc.o
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
new file mode 100644
index 000000000000..82cb1e6a0fe9
--- /dev/null
+++ b/drivers/ptp/ptp_netc.c
@@ -0,0 +1,568 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Timer driver
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/ptp_clock_kernel.h>
+
+#define NETC_TMR_PCI_VENDOR		0x1131
+#define NETC_TMR_PCI_DEVID		0xee02
+
+#define NETC_TMR_CTRL			0x0080
+#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
+#define  TMR_CTRL_TE			BIT(2)
+#define  TMR_COMP_MODE			BIT(15)
+#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_FS			BIT(28)
+#define  TMR_ALARM1P			BIT(31)
+
+#define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVENT_ALM1EN		BIT(16)
+#define  TMR_TEVENT_ALM2EN		BIT(17)
+
+#define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_CNT_L			0x0098
+#define NETC_TMR_CNT_H			0x009c
+#define NETC_TMR_ADD			0x00a0
+#define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_OFF_L			0x00b0
+#define NETC_TMR_OFF_H			0x00b4
+
+/* i = 0, 1, i indicates the index of TMR_ALARM */
+#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
+#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
+
+#define NETC_TMR_FIPER_CTRL		0x00dc
+#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
+#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+
+#define NETC_TMR_CUR_TIME_L		0x00f0
+#define NETC_TMR_CUR_TIME_H		0x00f4
+
+#define NETC_TMR_REGS_BAR		0
+
+#define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_DEFAULT_PRSC		2
+#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+
+/* 1588 timer reference clock source select */
+#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
+#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
+#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
+
+#define NETC_TMR_SYSCLK_333M		333333333U
+
+struct netc_timer {
+	void __iomem *base;
+	struct pci_dev *pdev;
+	spinlock_t lock; /* Prevent concurrent access to registers */
+
+	struct clk *src_clk;
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	int phc_index;
+	u32 clk_select;
+	u32 clk_freq;
+	u32 oclk_prsc;
+	/* High 32-bit is integer part, low 32-bit is fractional part */
+	u64 period;
+
+	int irq;
+};
+
+#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
+#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
+
+static u64 netc_timer_cnt_read(struct netc_timer *priv)
+{
+	u32 tmr_cnt_l, tmr_cnt_h;
+	u64 ns;
+
+	/* The user must read the TMR_CNC_L register first to get
+	 * correct 64-bit TMR_CNT_H/L counter values.
+	 */
+	tmr_cnt_l = netc_timer_rd(priv, NETC_TMR_CNT_L);
+	tmr_cnt_h = netc_timer_rd(priv, NETC_TMR_CNT_H);
+	ns = (((u64)tmr_cnt_h) << 32) | tmr_cnt_l;
+
+	return ns;
+}
+
+static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
+{
+	u32 tmr_cnt_h = upper_32_bits(ns);
+	u32 tmr_cnt_l = lower_32_bits(ns);
+
+	/* The user must write to TMR_CNT_L register first. */
+	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
+	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+}
+
+static u64 netc_timer_offset_read(struct netc_timer *priv)
+{
+	u32 tmr_off_l, tmr_off_h;
+	u64 offset;
+
+	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
+	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
+	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
+
+	return offset;
+}
+
+static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
+{
+	u32 tmr_off_h = upper_32_bits(offset);
+	u32 tmr_off_l = lower_32_bits(offset);
+
+	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
+	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+}
+
+static u64 netc_timer_cur_time_read(struct netc_timer *priv)
+{
+	u32 time_h, time_l;
+	u64 ns;
+
+	/* The user should read NETC_TMR_CUR_TIME_L first to
+	 * get correct current time.
+	 */
+	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
+	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
+	ns = (u64)time_h << 32 | time_l;
+
+	return ns;
+}
+
+static void netc_timer_alarm_write(struct netc_timer *priv,
+				   u64 alarm, int index)
+{
+	u32 alarm_h = upper_32_bits(alarm);
+	u32 alarm_l = lower_32_bits(alarm);
+
+	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
+	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+}
+
+static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
+{
+	u32 fractional_period = lower_32_bits(period);
+	u32 integral_period = upper_32_bits(period);
+	u32 tmr_ctrl, old_tmr_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
+				    TMR_CTRL_TCLK_PERIOD);
+	if (tmr_ctrl != old_tmr_ctrl)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 new_period;
+
+	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
+	netc_timer_adjust_period(priv, new_period);
+
+	return 0;
+}
+
+static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 tmr_cnt, tmr_off;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_off = netc_timer_offset_read(priv);
+	if (delta < 0 && tmr_off < abs(delta)) {
+		delta += tmr_off;
+		if (!tmr_off)
+			netc_timer_offset_write(priv, 0);
+
+		tmr_cnt = netc_timer_cnt_read(priv);
+		tmr_cnt += delta;
+		netc_timer_cnt_write(priv, tmr_cnt);
+	} else {
+		tmr_off += delta;
+		netc_timer_offset_write(priv, tmr_off);
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	u64 ns;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ptp_read_system_prets(sts);
+	ns = netc_timer_cur_time_read(priv);
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static int netc_timer_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	netc_timer_offset_write(priv, 0);
+	netc_timer_cnt_write(priv, ns);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
+{
+	struct netc_timer *priv;
+
+	if (!timer_pdev)
+		return -ENODEV;
+
+	priv = pci_get_drvdata(timer_pdev);
+	if (!priv)
+		return -EINVAL;
+
+	return priv->phc_index;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
+
+static const struct ptp_clock_info netc_timer_ptp_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "NETC Timer PTP clock",
+	.max_adj	= 500000000,
+	.n_alarm	= 2,
+	.n_pins		= 0,
+	.adjfine	= netc_timer_adjfine,
+	.adjtime	= netc_timer_adjtime,
+	.gettimex64	= netc_timer_gettimex64,
+	.settime64	= netc_timer_settime64,
+};
+
+static void netc_timer_init(struct netc_timer *priv)
+{
+	u32 tmr_emask = TMR_TEVENT_ALM1EN | TMR_TEVENT_ALM2EN;
+	u32 fractional_period = lower_32_bits(priv->period);
+	u32 integral_period = upper_32_bits(priv->period);
+	u32 tmr_ctrl, fiper_ctrl;
+	struct timespec64 now;
+	u64 ns;
+	int i;
+
+	/* Software must enable timer first and the clock selected must be
+	 * active, otherwise, the registers which are in the timer clock
+	 * domain are not accessible.
+	 */
+	tmr_ctrl = (priv->clk_select & TMR_CTRL_CK_SEL) | TMR_CTRL_TE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
+
+	/* Disable FIPER by default */
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		fiper_ctrl &= ~FIPER_CTRL_PG(i);
+	}
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+	ktime_get_real_ts64(&now);
+	ns = timespec64_to_ns(&now);
+	netc_timer_cnt_write(priv, ns);
+
+	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
+	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
+	 */
+	tmr_ctrl |= ((integral_period << 16) & TMR_CTRL_TCLK_PERIOD) |
+		     TMR_COMP_MODE | TMR_CTRL_FS;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
+}
+
+static int netc_timer_pci_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err, len;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(dev, "dma_set_mask_and_coherent() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	pci_set_master(pdev);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	priv->pdev = pdev;
+	len = pci_resource_len(pdev, NETC_TMR_REGS_BAR);
+	priv->base = ioremap(pci_resource_start(pdev, NETC_TMR_REGS_BAR), len);
+	if (!priv->base) {
+		err = -ENXIO;
+		dev_err(dev, "ioremap() failed\n");
+		goto free_priv;
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+free_priv:
+	kfree(priv);
+release_mem_regions:
+	pci_release_mem_regions(pdev);
+disable_dev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void netc_timer_pci_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	iounmap(priv->base);
+	kfree(priv);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *np = dev->of_node;
+	const char *clk_name = NULL;
+	u64 ns = NSEC_PER_SEC;
+
+	/* Select NETC system clock as the reference clock by default */
+	priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+	priv->period = div_u64(ns << 32, priv->clk_freq);
+
+	if (!np)
+		return 0;
+
+	of_property_read_string(np, "clock-names", &clk_name);
+	if (!clk_name)
+		return 0;
+
+	/* Update the clock source of the reference clock if the clock
+	 * name is specified in DTS node.
+	 */
+	if (!strcmp(clk_name, "system"))
+		priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	else if (!strcmp(clk_name, "ccm_timer"))
+		priv->clk_select = NETC_TMR_CCM_TIMER1;
+	else if (!strcmp(clk_name, "ext_1588"))
+		priv->clk_select = NETC_TMR_EXT_OSC;
+	else
+		return -EINVAL;
+
+	priv->src_clk = devm_clk_get(dev, clk_name);
+	if (IS_ERR(priv->src_clk)) {
+		dev_err(dev, "Failed to get reference clock source\n");
+		return PTR_ERR(priv->src_clk);
+	}
+
+	priv->clk_freq = clk_get_rate(priv->src_clk);
+	priv->period = div_u64(ns << 32, priv->clk_freq);
+
+	return 0;
+}
+
+static int netc_timer_parse_dt(struct netc_timer *priv)
+{
+	return netc_timer_get_reference_clk_source(priv);
+}
+
+static irqreturn_t netc_timer_isr(int irq, void *data)
+{
+	struct netc_timer *priv = data;
+	u32 tmr_event, tmr_emask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
+
+	tmr_event &= tmr_emask;
+	if (tmr_event & TMR_TEVENT_ALM1EN)
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+
+	if (tmr_event & TMR_TEVENT_ALM2EN)
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
+
+	/* Clear interrupts status */
+	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int netc_timer_init_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	char irq_name[64];
+	int err, n;
+
+	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	if (n != 1) {
+		err = (n < 0) ? n : -EPERM;
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
+		return err;
+	}
+
+	priv->irq = pci_irq_vector(pdev, 0);
+	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
+	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "request_irq() failed\n");
+		pci_free_irq_vectors(pdev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void netc_timer_free_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	disable_irq(priv->irq);
+	free_irq(priv->irq, priv);
+	pci_free_irq_vectors(pdev);
+}
+
+static int netc_timer_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	err = netc_timer_pci_probe(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	err = netc_timer_parse_dt(priv);
+	if (err) {
+		dev_err(dev, "Failed to parse DT node\n");
+		goto timer_pci_remove;
+	}
+
+	priv->caps = netc_timer_ptp_caps;
+	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->phc_index = -1; /* initialize it as an invalid index */
+	spin_lock_init(&priv->lock);
+
+	err = clk_prepare_enable(priv->src_clk);
+	if (err) {
+		dev_err(dev, "Failed to enable timer source clock\n");
+		goto timer_pci_remove;
+	}
+
+	err = netc_timer_init_msix_irq(priv);
+	if (err)
+		goto disable_clk;
+
+	netc_timer_init(priv);
+	priv->clock = ptp_clock_register(&priv->caps, dev);
+	if (IS_ERR(priv->clock)) {
+		err = PTR_ERR(priv->clock);
+		goto free_msix_irq;
+	}
+
+	priv->phc_index = ptp_clock_index(priv->clock);
+
+	return 0;
+
+free_msix_irq:
+	netc_timer_free_msix_irq(priv);
+disable_clk:
+	clk_disable_unprepare(priv->src_clk);
+timer_pci_remove:
+	netc_timer_pci_remove(pdev);
+
+	return err;
+}
+
+static void netc_timer_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	ptp_clock_unregister(priv->clock);
+	netc_timer_free_msix_irq(priv);
+	clk_disable_unprepare(priv->src_clk);
+	netc_timer_pci_remove(pdev);
+}
+
+static const struct pci_device_id netc_timer_id_table[] = {
+	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
+	{ 0, } /* End of table. */
+};
+MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
+
+static struct pci_driver netc_timer_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = netc_timer_id_table,
+	.probe = netc_timer_probe,
+	.remove = netc_timer_remove,
+};
+module_pci_driver(netc_timer_driver);
+
+MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..59c835e67ada 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2024 NXP
+/* Copyright 2024-2025 NXP
  */
 #ifndef __NETC_GLOBAL_H
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32 val)
 	iowrite32(val, reg);
 }
 
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC)
+int netc_timer_get_phc_index(struct pci_dev *timer_pdev);
+#else
+static inline int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.34.1


