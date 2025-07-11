Return-Path: <netdev+bounces-206076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E100B01443
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38E54A4221
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4F1F30BB;
	Fri, 11 Jul 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZIFqIkpv"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F11F152D;
	Fri, 11 Jul 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218257; cv=fail; b=tqONd3XX3ZjWnv2Nn0KZB7NyoSYuX3gil3x9HaW89B7i+F2T5fIilm1pR7V1RAUDET6Kdd+7XbRX+40xYVmxp0KxrBbfdzjsh9E3Dkmec2+HjEJsgsy87gokUxaXgaDPDNpgWaw4ek9O4hIvkI4VvuGbcizfeYRCTelwacIk+7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218257; c=relaxed/simple;
	bh=WNUQvHavS+yMpElX9rlZubHXjvZyDjKwfd0mdBwVK9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nejv6jOdnG8V9mAnxFSPAxctqFpdjXz0R9uML2UEXdhkJQa97iX7i4Hbida4dfy15JQyZaIEb65LaEfYEx9EVuX3ONGO2S7r1wpaZTNr6rYGqzgXWxnsJx72ObTdzWnu/aLDOfu4gWBld23fRAL/xRoeml4MJorEE3iV6KP78m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZIFqIkpv; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFZLlQFYI9g23tgUh5ommdX6dgSLt0N9gP0tOIt/iNHdWUW2SBvWo6E6J795jvuqWdQs9J+o3e0gHwI1qIKO9RxnuH77CRABlxW2cnNwL7BMwTJOTrhrM9SXP1rGWIflmAuLRl93zHNPrXBlgSmpPY2gEzypJsjcq9cMnbASRYefbhTEuvvwYGKmGIy2qGKciIkSBbAcMB3Mo5YB/T99N9U0z6xNIpuNq2cZvXMt/TYiymqepCW610PG2+eEuRlCqQkyW4zSSa5/DCa99jY6VY0kGrew3MwHzI3YGZrcwut80OYpur1OPPnlVIwFd98iiEwoNesopmH3KD4Q9Jxb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDIz5tidgQ5DUPGD8fM9VOfzpYktiiduVCTs//iUrLE=;
 b=JICOG0A282PIfag4sCZl77d8sQsQrWeacr4qJ9PknR5deQf3Voj71DC39Yvchcn8YXTYGtj/9ftr6x0E3MSnK950qFGUWPhHhtNKtz9iAI3F02zcQUfsLcQpm+zLOcmSLsdGnuzyedn2dl6aWbqZB2Sbxm78qm+o2UKCDu3Hwg4kTuQ3xBiC0sXMAetQjdv8GKMMcJfBaNBIqZOnIwYDnCntwnLtkWlvg4svn4QuQEeqtrahsXmeSvlqsRCrrCF7Fe/0A6SiwdvNV5L9Io48hKyoAZCPgHZ270YW5/ldoEDroGBL88nX+3MVreO/g214geza9aDMfWQLHI6uxkIhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDIz5tidgQ5DUPGD8fM9VOfzpYktiiduVCTs//iUrLE=;
 b=ZIFqIkpv8st2yG1/LZGdZUHm40f9jOB5APXSVAOjThVWAYREMeN9gZ7LYaUnyd7lkY0sjZN4J3vmLvvzOLjhwwhbdx1rBMKb0J3LDpn4J2HZQqrwZxwjuER2bdpH8B8sWiFLAUlE6FZ1lcvNWWpiZMBdy912gHt8V+2QIXchkdhGvXLoGX81A2CPH3lQRVwlEhL7Ab2aXFL28x/tkpTI2eUiXNJGIJWKP+x7WKGXkhJD6KXIccnrNEXkIqqKoTy1X6YkkMfyjFzZmqcByMoMPwA6IZCN25mQ//b4ZQoWT3BRMpORta1YxcflH5TRx1+/7h4I6cOK/1Rzr29fux7s/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7741.eurprd04.prod.outlook.com (2603:10a6:102:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 07:17:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:30 +0000
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
Subject: [PATCH net-next 03/12] ptp: netc: add PPS support
Date: Fri, 11 Jul 2025 14:57:39 +0800
Message-Id: <20250711065748.250159-4-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa51419-a367-43e1-bba1-08ddc04aff75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVWyB1GWgcdYj3iUYwiu97t6WJC9QRHywkgt5AxrXM6MJ6kc4SMu4EfwzIsH?=
 =?us-ascii?Q?1Arfv38HUpPgliXCcr+oJklb0admTpd84+YAkLh/x6TZkY2+60hheIH+Fmt5?=
 =?us-ascii?Q?oEXcjFiJ6ssNg/qMdHJt1h0TmX3LYinnCfShMMWLIE0wDKRBVEPqK7mhpNQA?=
 =?us-ascii?Q?HGu0V1QqqBWsQuXeAuctHITAFWMfvLmO7cocRvAnjhDRpcObc5OUxksqHPKG?=
 =?us-ascii?Q?dDrommTCdGLALNN+dPIGXKOYT1XVZgrXal5GOf7VVoidgB1kQdhw5CC22Abm?=
 =?us-ascii?Q?sDVt02tfcMikcEwDXwgvt17QU/KcV14P80uCSrSE1tbb6FRn+2y0XbfsNqQF?=
 =?us-ascii?Q?F0j0sHtX8uV03by0kztWIPDi5D9LukeDCtmSVpXS6ar2LlBYm2wBOhzGEnfE?=
 =?us-ascii?Q?aV00Xnqov8QoBjhlkqT+6qRSbEKTw3TWp5eTuYYTcPycqYLed+6t3qbYCKyw?=
 =?us-ascii?Q?U0jqHgPNJ8hKakwapw+0OsF/XoUE/8aaL0+Aq92mnOxbehafF96CjoWGT9u4?=
 =?us-ascii?Q?5bngzj6/hQN7l1B1mAprw/qpt611xhcpVwTRT8w9gSt62fHJJ245++B5z9Ov?=
 =?us-ascii?Q?6FDHj36Z3dMpWIW1DckPciuRR3uQxYcLsLc9fyqGLPLf2i0yfT2KKEYcZDne?=
 =?us-ascii?Q?0L6j60zawnaSZXtevBaAjXQwEivf55dxW4Vt5vNKFffVTCfmwOgXDuBnZKRq?=
 =?us-ascii?Q?KCo2f7wlXzfWM6MS8YE0CZ+M+XXMMSwYQwKvn3bsPDzeuT793DnXsYHwbdKR?=
 =?us-ascii?Q?IRJvrjxeTddQyf+genF8BLSjXE80Mc/pJ6aSvco2hKzvjnhI1noB1w7cZH8I?=
 =?us-ascii?Q?wJVRThInbpMSSzA4AMgjeP2xJrAdM0ls2SMu9nDMJr+SRkProcEVRl1cOYuv?=
 =?us-ascii?Q?Rs3mMZoP365OnsZSdrfwoYR98Uejx3xu+pn1ego2y/RUswHvbIeJOl4mIstL?=
 =?us-ascii?Q?TA/xdY4XDqa/cRxvzvwx8XcxCaOYnVWi4raBNgtGNp8Jjh73v+JIyUWYnrdE?=
 =?us-ascii?Q?AkK1SKDTkOjWEPWbZt9hdyYdfIyPip8jpsk3xMta2m5vFNf7fPvexOUVNa0N?=
 =?us-ascii?Q?bZj6Yxx95yjg4xDmLd2GCIulA3uH1NQh2bRJTUUu9DfW7sGMBXNw5T74c+BW?=
 =?us-ascii?Q?kX9rl1k2gnRXeVX5x/iJeTfxPQ1YLfUWk9UUs7arEnGSD1JDTyI+7S8r8gZO?=
 =?us-ascii?Q?bJbxYw8cfYx5XT9+fiFPyc3Y4iGCNozLZWSLYS4a0hPe50OgzcmCZHgPA49g?=
 =?us-ascii?Q?VvSjAI0e9b1vEWTDmDeKBJDxX+tkFthhW6AZDqdD6C44iyMOWrM+KnWBSN3I?=
 =?us-ascii?Q?Gvs0bK6S2nP7SV3ecpd+j1rubey1NLFlvWV/PHZ2QKTb3HqdrfftJEiQc9pr?=
 =?us-ascii?Q?YBMlTifiL+1cxgb/fHHJsIO/PD+4Tzt5zlgzwROHXC40casOzi168ioZ2CmX?=
 =?us-ascii?Q?83791P7JuD0i1vWc7Z4WuoatLmuS7TpmM47jx/x9T6CMxVY8LjQ4O0uvZVWN?=
 =?us-ascii?Q?irRdPhrBzXi59DI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lUVypgcWM38pc6mIM4tiU/ew+27JffZhLhZXLGFWPhtlGsUh5Ka2VUB40ysa?=
 =?us-ascii?Q?+n+oANPWRggTzR2xmAcQyui/kDSrYcGye5P2Pk0D2aiLfwJIVBl3zwwtVoyu?=
 =?us-ascii?Q?aHZWK5/1VBdSFA6Ac0NNcxLit90FwUZAYHj9XKWWl4tDJPZcRkm/9hSpBLWn?=
 =?us-ascii?Q?wPYl+ZLK+7Fu1r4Icg07qkYLwEVaizPALISGlFst9ZD3mh4SpzKkAyr/56iT?=
 =?us-ascii?Q?GuJ+BNCdVmCceVvNeWx64wyrpDvMdDxn0kGYPqybB2l9z+fqwKp8sZAUF0/m?=
 =?us-ascii?Q?+PdfHOuMYgGDIvVVRSYC/3dOhOWh1yiGt/UNY+9qTl3r/n82TXP53xSSrpm2?=
 =?us-ascii?Q?/eEmOOegXUDiccGqa8XtteUY+gb4A+1BVvlJPaMFr0m0GBCUZOv9KXYMVcg3?=
 =?us-ascii?Q?evwN76vPhCfPxTD/c/C3g3ma2lkv2Iq8wRCfBei+EswwGET6fuanCT2R2b5s?=
 =?us-ascii?Q?/g0J+CwQ4K+BByhYkk6lf/E2o9C7tQ2EZAm2lQYHsjvX0jIhi3bQ7GAvY+xn?=
 =?us-ascii?Q?2+3jc3odpcn9tV+UhjorHFsSrCR0Xjf9m+dMrgnb1tywyT37TltPQG/On+wY?=
 =?us-ascii?Q?NIRyEgDkBAGLo9WF4YY4uYd6bVneWHDJkvYeB/4NP9rlRwvqxhbPcrP7coki?=
 =?us-ascii?Q?NtpSaHH9Kh2ujRGVYUiUpkyxJAM4hihtB5/VBYwiKeO3O0HqA0L8YyhWrgtc?=
 =?us-ascii?Q?1SZOd8IeAXZorajMV2aY76G4cxeczCDrz61sYLZKgEbQi71tvts3sgPVGlB3?=
 =?us-ascii?Q?+v5O6Yt2lVrqr15i3SxOez7dmhVqtwEG3TLNqVh0IKUr8+xOOpWUrX7O3XFN?=
 =?us-ascii?Q?w1HC5WJ0tysmeQSkClKM0pbXYj/nS1x1n9vr2+z0K713vRZnuwrnPKJVTL+1?=
 =?us-ascii?Q?dO5D4ZPfZA87vP5aFSGX6omIoQl+qE3uB2OrsipU6uU0hKvQ/7FnU2jvnd09?=
 =?us-ascii?Q?HWe/2zLp4BGu4EIS1dXgjQ9HKcAt0GbWLcAtDRNbcVExqEmqxv7yUFFAfIMf?=
 =?us-ascii?Q?qbAVYLEP1syywrfHxljKRBJqGB0pXDJh5mc6IzagvXrzq72+mwl9Lf5v3gjR?=
 =?us-ascii?Q?sX3AR7Ve85hbTJoS/D12GkpkYYEpeGGiD86vVhjWs97VpLw4RgAOSlCMzqTS?=
 =?us-ascii?Q?yaVSSYqPGQyOQhIVq4PtkPYKIFB9x1jwT3byBBGgZCb8yXCxb02ce4wV/my3?=
 =?us-ascii?Q?HGyHhysvmJX2AyiS215h6mf3XedU7PwPXesL8AC4919xZus49m342bMd+nP4?=
 =?us-ascii?Q?wKidUfSwiDB/O8H6oSVcv058uE4XawNHMFo3vKqoTP3LVgA1PL9/Ynx9k6Uy?=
 =?us-ascii?Q?EZVcEsG4zJGMoKO0Pk6Ykow/N4JOiY2/Fml0wncmCCocX17oZMXvxPD8CnP5?=
 =?us-ascii?Q?bYfcBQWFyGTBHw0Zagh0vpWqQTtozgNOr0S88tWZJ0pLqdpoQRhny6fRvBpV?=
 =?us-ascii?Q?IQLO2ebqRZAiPeBTMAjF5xDF+9ALEeZk5ZMBVDQg9ZjRW2r+J6LGqB7jHj7+?=
 =?us-ascii?Q?M6AyOQn+Qk8LcUSdLm9X4DwHAEIfKp8zicanwBJ4TFBQNajmfHm+DmvPhNR2?=
 =?us-ascii?Q?jaxUKCWVY7AVe/Cimv7yUXu32tATFmQw4h4Vl0GV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa51419-a367-43e1-bba1-08ddc04aff75
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:30.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y7exu4aFydNEGjYY7/4CZ9jfUIeO4UPhHHXkemS9RCI54a9N0SLAeaCCM2Us2xPRglUBdRLqm1kdOMmruKF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7741

The NETC Timer has three channels, any one of which can generate the PPS
signal, since the kernel does not provide a parameter for setting the PPS
signal channel. And this is also related to the board design. Different
boards may choose different channels to output PPS signals. Therefore,
the "nxp,pps-channel" property is used to indicate which channel the
current board uses to output the PPS signal.

In addition, if there is a time drift when PPS is enabled, the PPS signal
won't be generated at an integral second of PHC. Based on the suggestion
from design team, it is better to disable FIPER before adjusting the
hardware time and then rearm ALARM after the time adjustment to make the
next PPS signal be generated at an integral second of PHC. Finally,
re-enable FIPER.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 194 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 87d456fcadfd..abd637dab83b 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -23,6 +23,8 @@
 #define  TMR_ALARM1P			BIT(31)
 
 #define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
+#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALM1EN		BIT(16)
 #define  TMR_TEVENT_ALM2EN		BIT(17)
 
@@ -38,9 +40,15 @@
 #define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
 #define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
 
+/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
+#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
+
 #define NETC_TMR_FIPER_CTRL		0x00dc
 #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
 #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
+#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
+#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
@@ -50,6 +58,9 @@
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
 #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+#define NETC_TMR_DEFAULT_PPS_CHANNEL	0
+#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
+#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -74,6 +85,8 @@ struct netc_timer {
 	u64 period;
 
 	int irq;
+	u8 pps_channel;
+	bool pps_enabled;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -148,6 +161,142 @@ static void netc_timer_alarm_write(struct netc_timer *priv,
 	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
 }
 
+static u32 netc_timer_get_integral_period(struct netc_timer *priv)
+{
+	u32 tmr_ctrl, integral_period;
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
+
+	return integral_period;
+}
+
+static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
+					 u32 fiper)
+{
+	u64 divisor, pulse_width;
+
+	/* Set the FIPER pulse width to half FIPER interval by default.
+	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
+	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
+	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
+	 */
+	divisor = mul_u32_u32(2000000000U, priv->oclk_prsc);
+	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
+
+	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
+	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
+		pulse_width = NETC_TMR_FIPER_MAX_PW;
+
+	return pulse_width;
+}
+
+static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
+				     u32 integral_period)
+{
+	u64 alarm;
+
+	/* Get the alarm value */
+	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
+	alarm = roundup_u64(alarm, NSEC_PER_SEC);
+	alarm = roundup_u64(alarm, integral_period);
+
+	netc_timer_alarm_write(priv, alarm, 0);
+}
+
+static int netc_timer_enable_pps(struct netc_timer *priv,
+				 struct ptp_clock_request *rq, int on)
+{
+	u32 tmr_emask, fiper, fiper_ctrl;
+	u8 channel = priv->pps_channel;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+
+	if (on) {
+		u32 integral_period, fiper_pw;
+
+		if (priv->pps_enabled)
+			goto unlock_spinlock;
+
+		integral_period = netc_timer_get_integral_period(priv);
+		fiper = NSEC_PER_SEC - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+				FIPER_CTRL_FS_ALARM(channel));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+		tmr_emask |= TMR_TEVNET_PPEN(channel);
+		priv->pps_enabled = true;
+		netc_timer_set_pps_alarm(priv, channel, integral_period);
+	} else {
+		if (!priv->pps_enabled)
+			goto unlock_spinlock;
+
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
+		fiper_ctrl |= FIPER_CTRL_DIS(channel);
+		priv->pps_enabled = false;
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper = NETC_TMR_DEFAULT_FIPER;
+	u8 channel = priv->pps_channel;
+	u32 fiper_ctrl;
+
+	if (!priv->pps_enabled)
+		return;
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl, integral_period, fiper;
+	u8 channel = priv->pps_channel;
+
+	if (!priv->pps_enabled)
+		return;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~FIPER_CTRL_DIS(channel);
+	fiper = NSEC_PER_SEC - integral_period;
+	netc_timer_set_pps_alarm(priv, channel, integral_period);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static int netc_timer_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		return netc_timer_enable_pps(priv, rq, on);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 {
 	u32 fractional_period = lower_32_bits(period);
@@ -160,8 +309,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
-	if (tmr_ctrl != old_tmr_ctrl)
+	if (tmr_ctrl != old_tmr_ctrl) {
+		netc_timer_disable_pps_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		netc_timer_enable_pps_fiper(priv);
+	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
 
@@ -190,6 +342,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	netc_timer_disable_pps_fiper(priv);
+
 	tmr_off = netc_timer_offset_read(priv);
 	if (delta < 0 && tmr_off < abs(delta)) {
 		delta += tmr_off;
@@ -204,6 +358,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 		netc_timer_offset_write(priv, tmr_off);
 	}
 
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -238,8 +394,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_disable_pps_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -266,10 +426,12 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.max_adj	= 500000000,
 	.n_alarm	= 2,
 	.n_pins		= 0,
+	.pps		= 1,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
+	.enable		= netc_timer_enable,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
@@ -422,14 +584,31 @@ static void netc_timer_get_source_clk(struct netc_timer *priv)
 	priv->period = div_u64(ns << 32, priv->clk_freq);
 }
 
-static void netc_timer_parse_dt(struct netc_timer *priv)
+static int netc_timer_parse_dt(struct netc_timer *priv)
 {
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	if (!np || of_property_read_u8(np, "nxp,pps-channel",
+				       &priv->pps_channel))
+		priv->pps_channel = NETC_TMR_DEFAULT_PPS_CHANNEL;
+
+	if (priv->pps_channel >= NETC_TMR_FIPER_NUM) {
+		dev_err(dev, "pps_channel is %u, greater than %d\n",
+			priv->pps_channel, NETC_TMR_FIPER_NUM);
+
+		return -EINVAL;
+	}
+
 	netc_timer_get_source_clk(priv);
+
+	return 0;
 }
 
 static irqreturn_t netc_timer_isr(int irq, void *data)
 {
 	struct netc_timer *priv = data;
+	struct ptp_clock_event event;
 	u32 tmr_event, tmr_emask;
 	unsigned long flags;
 
@@ -445,6 +624,11 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	if (tmr_event & TMR_TEVENT_ALM2EN)
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
 
+	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(priv->clock, &event);
+	}
+
 	/* Clear interrupts status */
 	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
 
@@ -499,7 +683,11 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		return err;
 
 	priv = pci_get_drvdata(pdev);
-	netc_timer_parse_dt(priv);
+	err = netc_timer_parse_dt(priv);
+	if (err) {
+		dev_err(dev, "Failed to parse DT node\n");
+		goto timer_pci_remove;
+	}
 
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
-- 
2.34.1


