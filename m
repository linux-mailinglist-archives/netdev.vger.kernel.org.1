Return-Path: <netdev+bounces-230005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7BBE2E5E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B9A3E546B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD97330D3B;
	Thu, 16 Oct 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQ6jELVR"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A8330D2F;
	Thu, 16 Oct 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611412; cv=fail; b=B5fFCYXFXgFl1xn5K33Obi+qzsnLIf+QlB/GYPBMD1jSDt85gY9O23Ffg4slOQzgBmrgx3dSojd/xI+OeA6suBdTR7yQt3goqAVoGfzu7fY/Mh27eztoutvM6GXbRLbdvqCjOWDOFTgX3zBg5QsS/GlmhE2wFygmoRGB88OnMDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611412; c=relaxed/simple;
	bh=d1E0n1nadeue7eBe//A5U6cvs1rsuWgf8TbGg7+3KBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLi+NaWybyvPTenonkd3WByCXgDRmRm+PqOUTrf+45jT1hfGvuDh4qNtH59O8Qo7hPVJdUdkSyZk4GOrTbfpl5ktWSCbWV/Qr/faZBRoDY9iK0N8lilkcWWdC6N3VDvwfmhxwGFDCz3KJgam97wkD+UNB+MxeYC0Ld9jiZ2vEOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RQ6jELVR; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTh6+InYc5JYXtiLka82bevbhW27iiKNmSTY9XmBVv/Sq5U4nO+99PjBnLckmbLgOt1hXIEMIZloyzu8SilGqMLBf+ObKgvpHKEBJGqc1jkBS/URgU5etRepwXIEFVuHR+AuowTaFNWIdYkEzoFU1Ic2AuNDlLjA9F9UjictgciXH53ctlSvsKV9YOEvzSMf286+6nwoRY4ieq2XLr/QGlD1YJWegMKIJ2BxMK04E0JdVbCkm15Jn7444+6FTKgcLsC6Yek7WtpFYHpH3xYqq8IVr3uZjDNlgz0TsyI3qql1cRzh459s0oIa0xtZ+rrZjPnGvU/wS5PtpKDB+XQxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgKvh7NPde9OLD9oF0KrLyo84YDiJHPhqRDxTVV0o7k=;
 b=GJbufr5ko5MUtBkjrm45GlxkPU6i4S1azH8a4DANz1245oQXyoc6s7XbgrObV/uE/jjNVSipgk4jAOLqY1MbrADPzQ0r46jBXN2Bo+e+bG5X0i7D97dGe7NcE1bKJVi0NTZkjuAqNzO3ncAlfb0y6o8KEjk1fiNMqbmUZZlVNneb44jr4ZrjyC3KKIQq84abb/wko7PrNQ7RVbaTrZddqUmLXNaqP1Kb/CkEmj9MqDwjRJ4zhYhQ9ygSNRIqSXLFyBoH5btgnHu+J6gS7Ui5mmGfZAsECwHXuk76yp85kyggfsvsKXfelBtzrE1CoG8BagcjM+Z6mF7JNe+F7ZXtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgKvh7NPde9OLD9oF0KrLyo84YDiJHPhqRDxTVV0o7k=;
 b=RQ6jELVR4BNtBvZz8St6jfWdf8bb5C2imHZyfKCuVgZjhaleJWpj6I6rssF2vTu0C7O6zYOwZ2PlifZj/ZkRNHBSs8ei9P6O6tYLM0NnC1jSIq4XFyGbneid4uwMwKT7a3ZsbK0XD6myTIhAyiySZSHfkaQRDsZTuWMGcWrFp/pC1oVlTcihHLiGPxwDwcCAh8SiiWzN+m6aTCXPKhoN2C9JbGFvwu5qHXQY9xoS9S5tfPIlcEF50z7kkZfhgfWi3q8QGLIDqwyQqGY0163+HBuAEidDLuiIMkTeERtYqpJ5B9hgDsaM32gPM9x8s8BcDu9pzYHzb/MtuH75PnfVwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:43:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:43:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 7/8] net: enetc: add standalone ENETC support for i.MX94
Date: Thu, 16 Oct 2025 18:20:18 +0800
Message-Id: <20251016102020.3218579-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: d449eef2-ade8-4028-5000-08de0ca0d6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p50fErybx4Y+VuDiDXlEPFJkk/6tU9Qs+B3xUuU4d9xngRmtf4wcf0M+tZ6w?=
 =?us-ascii?Q?t62aDM7JP31F9VJpcwSFCxAsxFBcPzxfmXEI/WfZAVJHUd0gMQ8fdnXhEjyP?=
 =?us-ascii?Q?bvI0oE3SEq1yDJ+D+nClnY2wxkcbpHV2F46Z57Er9MoylAsrCYQCIoZDZEVx?=
 =?us-ascii?Q?9QMAaKarLGEAQlC5s/bJQjKq/jTRWULurgXjgi8kGxvCXdWoKpH9VVhg0a2i?=
 =?us-ascii?Q?F3YRR1SWEEO8xSHlru+UzUGUC0HtuVivUadzxgCt8QiSq1pKSg8YTwVcyDc9?=
 =?us-ascii?Q?RWsguk8HP111+LEaFkCwG0d74opAzn9Y4yfGQrzFnLfDHRmPDBBewUzHGUuI?=
 =?us-ascii?Q?kzlbGZF0ywywFFQOuFZgrU4TEyZWTUVldxJ8Xyh/NxfoucwBCf15qxD0VRsG?=
 =?us-ascii?Q?axWRDgVAEQtlljR24IHdnfoGottZM2/kPGeJ7UVWT5JtoP9xc3v1HsjyyS+N?=
 =?us-ascii?Q?JYpWUznTEpRwwQRTBKc7zGZG7/aeQeOBl/1Wmky6WtESVtwhaq+HDY76HuFr?=
 =?us-ascii?Q?aGkZyZVuN8MDZYlYQfxyfdPDEKzVeenvwcVCE3EZ5Rw7ia6aXly+muYYTES+?=
 =?us-ascii?Q?9RoZvElWWujE3u91/CgoLL31CQieyakjsiVSzG3Kn/SLf40g9LdU5KxdH31n?=
 =?us-ascii?Q?MwdSWWqVs3ry1j5pypPILuTbr2AfQ8IoQyyuV2vrv9pBe1WDh2wzi+5pTWmI?=
 =?us-ascii?Q?hh9zq8sIglfX1ZXXF+Hi95WoKOfIMw4dKguSGhqLNGMXkmjWGLiJ9l5+HGnk?=
 =?us-ascii?Q?T8+cnv1vNR6HANUfptTiPCFE3CTCahpPcQQe/b7pjEFtMWsBq7tPwSBbUxX1?=
 =?us-ascii?Q?r1ZnJ4hQ6SpuPlXOHOJbLy3hSecqRLYMHghT0LQqx+y60PoE9Ncj2OUl1MU+?=
 =?us-ascii?Q?3XOQdvKaEsp2SLHbxiymowpRBhSh7Bl2eR+d7A9oRfd6vluTzgi3I8s211bA?=
 =?us-ascii?Q?LyhWXAw52jFgu+YxnnGC7xyR0tBDmy9y3Uc2c3x/rWyCp3SoyPl4QMj/4oB+?=
 =?us-ascii?Q?7cqHm99lV7BpXgwlJgjA3Zm2u2c5/1Mnlak1x8cSsNo3/CEKJs3l9FSUv0+r?=
 =?us-ascii?Q?ALD5vCQUbp9YMlxEuUqYOE10b+2+LJrEllHQEHjggSqVyO8Hq2DQmHmWDGF9?=
 =?us-ascii?Q?NuEbcFR86te4Ljka6CZYCC85iaZ69kKCKVgsjpKBI/8+lZGaICvERtQ/py58?=
 =?us-ascii?Q?r6Xt29jYWKBDPLBlKdg4NXyWA1+dVho9H3mcpJrqFEjMuagFTtVPMr9WAvSb?=
 =?us-ascii?Q?XvM+2VkvWSXJPBnTWgCJluTBtOBRkNRSS5LdI/xAN8BGL/+lo2+QExA3Dnu4?=
 =?us-ascii?Q?L7kCb/H4Jbja3LM0PP1sEzPKbBmgXFTkk3fDRtdhStYb5owuB+yA03+BIOvp?=
 =?us-ascii?Q?7PDEwSLjXNsI5LagR25WdO6jCD3trGOyw3wtdJMrx5Nws4r/x8pYfYYdtZGs?=
 =?us-ascii?Q?yXifADaFyt6XUX5I9j8jyzmcx3y+7L9uwMuBGtR5qjoevZTAl0/5bXzhkZ4v?=
 =?us-ascii?Q?/XzURTNUyv+o4sHU4nu22dgl+3UyqijhPG6U23tPliA9wTLydZIYa1G/XQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EQBZZi+PYdN2FjQ1vrYRL6ONvPvVEC2y0/ClKi5jKEwhBr12ma6VYiULHoCo?=
 =?us-ascii?Q?eiU3ByN5TJ9jvvl3K82O1q1cY/xqbZ7F1Y4nX5qVk9FN60lEI+mV0/METJeP?=
 =?us-ascii?Q?lgYFCD+ibFQLVaE1dLpSIfvqlAr+ApD5HGB4tg4WOiQjioOSVSDuKeXpvrqw?=
 =?us-ascii?Q?+ncqF9fQ7iiiuje2Y5arqtir9mkRBb5JuXva4dDGZjL1nmHBlY4z7YLlb5fw?=
 =?us-ascii?Q?kdI9j7xYGUUL/CXy4ZaaWOzViSc0gAtKQuUwfCoein4EJV2wAwFE2jhDcLO6?=
 =?us-ascii?Q?ABYmR07IuS9z62TR8wlelxsZqvzWk5GXgvq5OlLLzxG0vZVFmK0opXBS7+5X?=
 =?us-ascii?Q?5rc2EGXb4Bto9ZNReXXTQGhgLHtlPIAcbYcslhl9Otper3vWKezWebcqlNBT?=
 =?us-ascii?Q?3u9CC7Y7YoLHaklbtXfn9FWI6BjrbUvl5or9ZJ5hYbEApGBmNi7CYNCbHA2i?=
 =?us-ascii?Q?odR4iIX0xIE5eF/amU28jMBYSTX9DESZOQaT4dx7+395VfnkgIbTjC15aFw4?=
 =?us-ascii?Q?Jw95kx73nPNoxBRQ18Wya9RQMAeFUuTrrR4+WrHoQCZLtu9JQgO3+NtSsTNQ?=
 =?us-ascii?Q?2SP72lXbDsy6iXoH5U7Y1YKC/ejOltrzjAZjhqVZY5BgtpdQyvFSVOyv6jUJ?=
 =?us-ascii?Q?gRwd277ykilqcPW93hvukKFlovROaS74pRVagduGHRyxjnS8mHAK7YG1Nv2t?=
 =?us-ascii?Q?sVS/7XbzxozfaVm1K35/vjWqCKPkmmmwn9efF748eoGDIURi+18H43Dhkyl7?=
 =?us-ascii?Q?/g0d6sf0c4yk23ONWwKXrH2hqsLxjyZRDL3gv/5fGAFucPsBrD9pvxcwUCzP?=
 =?us-ascii?Q?T0VvYSvQOoOfE9vHvKDoIsOZqVFx8ze0b7Bum08LaFq4/LlSwpim3zIAz8T0?=
 =?us-ascii?Q?LbCHUfTpUUVJ0W+7cAjaHC154BEurwTJGPxEHwJCoS2uty1ut8OPEliQ/xbY?=
 =?us-ascii?Q?5AyKuD2/OFImZHcHYdpvosG8XwwMxS/27tW7tSWXmo806GgiFu4eC5OU6n2W?=
 =?us-ascii?Q?rw7z7NVQhZbOaUOzi4uq4+vgJh66w0kdRa2k7qnaAcmHjr2ovKEpl3jZ75+u?=
 =?us-ascii?Q?LKOLfsLANIrOmdf8h9qnU1SEaylmFvSlZ5kzcEr6RWnmiP1BDxRDn7nzQrBD?=
 =?us-ascii?Q?5AkYBjWMfykoUeLHJK5JzbJxz78BPsgjsWWwaxrzEe05Riq9NGUN1wvOlAjq?=
 =?us-ascii?Q?p+s12YphJyjLtNmYtNfvkOU1ME6AqO59TryJLS5kNG/Qz5kq7jPvQsP5Rme8?=
 =?us-ascii?Q?dicw6SUpVLeIdeYC8h3ntLPMtj13es7Vt527HJTDMvYry6g1dgnUy+HQfV+l?=
 =?us-ascii?Q?zfOL4rTuvPWHIXNWjsMN5DmAergsftoca7hgltKcG1ZD/tAn/WDWygO9la8V?=
 =?us-ascii?Q?BOeB4/3ndj0VEMRpKUJ/gISaGvhRWnp2oeLRMO5FsBHUp5SbCT8coKPs/LsJ?=
 =?us-ascii?Q?DquAhgSwFyItQgkdviZC7xARuLwlATwS4mxE9nZbzZUVHPKv4goHONMP8GHA?=
 =?us-ascii?Q?mX99jU0ZpkTo1ezh4H/T9HiP4LffHoch5dcH3t3QfnQGqjuvOnThAqvCTXA1?=
 =?us-ascii?Q?7pAjC+7urLXtBr28/KGF4/IgOswW7Dl+E/xe2Dev?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d449eef2-ade8-4028-5000-08de0ca0d6f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:43:27.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyLUW91D44d7EVvv82xURHwnVvCZGHzcMggc2xnPbZL+g1X1fYqOjtd2ArayIO++DlJmSqs26y+dFJeWEzlzOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

The revision of i.MX94 ENETC is changed to v4.3, so add this revision to
enetc_info to support i.MX94 ENETC. And add PTP suspport for i.MX94.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 4 ++++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 88eeb0f51d41..15783f56dd39 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3732,6 +3732,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_PPM_DEV_ID,
 	  .data = &enetc4_ppm_data,
 	},
+	{ .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_pf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 5ef2c5f3ff8f..3e222321b937 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -936,6 +936,9 @@ static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
 	case ENETC_REV_4_1:
 		devfn = PCI_DEVFN(24, 0);
 		break;
+	case ENETC_REV_4_3:
+		devfn = PCI_DEVFN(0, 1);
+		break;
 	default:
 		return -1;
 	}
-- 
2.34.1


