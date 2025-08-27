Return-Path: <netdev+bounces-217178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208DDB37AFA
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E456681C00
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334D318149;
	Wed, 27 Aug 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AGhlU3Ly"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FC314A79;
	Wed, 27 Aug 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277732; cv=fail; b=bkb+dlz73mE5QOqHww0H33k4L3WcKSpEY9D873uNlD7JOF93htX/WcqIJnNVc1PvqkN3Sx4yyrvL4Tbqziq/YKtJSNj6TzYo1tZV24mqALIdljCOgIiIPfpDEJTsX8e24FlHOVVoLkc/Lqfq52f67g6AehLTJuRjXHAh5WSTrso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277732; c=relaxed/simple;
	bh=AZc+VngCYcy1izgEZNU9Lin0RXTrZl7/O0f9HwdghFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X18xBIdvSIvwAhNpIWx6X1FMRXtj/P/l0O3eH7GDMWAx3WbNGlZYYObXL1KaOIXyu7HjXTa9zRQt1RfIV/Tlxgz1fMsX2Ec3UqVGhYsDcyhJy+ZeFtGJEvwGOv0ytZptqwFwzFpl6b/Pm0cNwoqLzTRJfsNcwsIkGnB8XbAIZeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AGhlU3Ly; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYw5Q2ytRchldueelHXcSDzOatOM7CgSYcPSxeF6lroHqfC8OKVEUocuG8WkltJtA51yqgfB+2+HGwdhppuYFKUPBYFc5nBQx45G81TtO5zFDgmsNIcaU8QV8ECjP59rBT0qsOf4nMlX6sNxkndCkbiE1N5bEaXpqoRp+sak9VNiIlDUMVSfC5p6F+ccNOYLlDZKMLbXP+Jkk7gm57Vn9ceUr+zkPWvd0GuaQ4YOAH5hPv4A8oj0ftWV0j+YTmc6htNQnFmn9vt9Ji/af1qH3ywQAqxnnNY5Kk3gawx/tWdaykU2Zdi89HMgiz0JzGIqc+62qsBOcUn0Vx0Q8AICZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeSsHmuq2IHktoqDbjTMq59XsJMi2k0Qi4V+MXRjfJE=;
 b=d+MtEmKsxtrCeRjDkg/jmK7cra9nU2J7Sm/Xjjbp2S8KkYDZRwHCZ8AYypf5JMm439uhPnePouHrLROL0BaXPy1Hs+bZ9zk7kjmnFRp7K8yc19bYifbx4fNFhE5qDuIzCsgQ0rfhBezGdRfiwbYNY0y4Z4DsEkA3PBgrNOVZBFaq30ia0J1FD9YmYHWt7icNgRLN4xIBf6EiVPOwJF5+MNk0HaJllEJ804WEZeNmkAHLkGWvov4gKwT6bbIWRKLw07ZbysKp9IuFtf8nri8ruGg1toBCo4bbgilnxYqyGyrqTXfYhIUpleWZKf/LzwcqnK4wT7l1DydLrU5mZ8jyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeSsHmuq2IHktoqDbjTMq59XsJMi2k0Qi4V+MXRjfJE=;
 b=AGhlU3Ly+Oq3buSQDWxDEB7nTGIs3sCvSp3g1oNt6S1anLGia0nSymdN9ubgdJsQjxiiyTUgdtlS5ToVWkzGsXYY4yFmEZv570cyZZ0I7tQL5BfucAew37OIaYGmUz8zSNazhI4yRrIkXROLn6IYkRjJ8K7bASiWXKJDfNBvO5egex2It7H9vC0DdlNxSj/iKW1rcwPqAzPtQkVrLiK0CoFWkesvGv0Mk2oJBLJCceYqNN1AdrflXx0i7qXWHakBYeF0kfKhghtS8s7ilJivN068nptXI1CCEp79TuxzhcP3locVMQ7Jol8T8pJFl162jOBdSWt6HMFqJFeI0wjJzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:55:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:27 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 06/17] ptp: netc: add PTP_CLK_REQ_PPS support
Date: Wed, 27 Aug 2025 14:33:21 +0800
Message-Id: <20250827063332.1217664-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d22bdd-0a7d-49df-f03c-08dde536b421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SzazSOJQNuHrCPtMu74qBFIQtRUqijK2dwpukwSZPXAk9bZSnOxzFadXJgOj?=
 =?us-ascii?Q?uu+wQB2jjnvuw2cj8vQSxBZg9GwnVHsf1pOnF26bmhgfNarJGurAtn3kXTDf?=
 =?us-ascii?Q?8n8H0PXGcBDvzSmHiLS5bHw8qpsX7rJfIOv+quDeEuSISfvlu/ySSFRQmCkQ?=
 =?us-ascii?Q?ZhpiTcabTPaUNdU4jNxJSd846Og5IKd9Gs9XWU+Icw0XtdlCpqQ8k9xDfy1z?=
 =?us-ascii?Q?KrTZ8jCnQBg59QrwUUAArTR9gTl5jbz5KSvhTIq38bzPCGrw9mJV9cdFJGhV?=
 =?us-ascii?Q?Fdy0G8yNqMWYLZrITKdAbFjcGoh/Tdr+KSmgLKmtoZMkeFRLh9sWZLYMVKs1?=
 =?us-ascii?Q?7xKNm+0TSvjE6izYUszR5gVCg4DW9fEXPBRgSVFHkAM/H/qAv1I/g1u+rypM?=
 =?us-ascii?Q?Iy5ikOnq4cBXICumscL9zYPlpk5CPwVghlWyGAsLX6IAQSWzIBUWyVJAJz/q?=
 =?us-ascii?Q?xEtOM6zoNcpwkCSxUHvS9SPWMl9rou7pHOGv8KZtoSkW0Xg+NAbTTaSXrI5y?=
 =?us-ascii?Q?OsUjRnSmrU6SnK4vlfTlc3VHhIuUKfW1uoETe7fBmo7CwXfkiK22GyePesrX?=
 =?us-ascii?Q?fETiY2MoQXsKIM/8P3mDrkTnXMIGoJGT1Hl5nJfikbmK0hgBuAGyr1YiuUaa?=
 =?us-ascii?Q?7NTAy484D/p7WIJhxeGtPeVv/wHZ+PI0UAvC36RXLrLp+BpVKPklNPO/HUtM?=
 =?us-ascii?Q?ne+eQxYcEhOOJPsbexa+GdR1gZDCLUOXEiaXmOQ6YR4MrzBMzZLwsLBR074q?=
 =?us-ascii?Q?t11S7EKWzXeRMEsRAHpPJs46tFAndM3XMyXrEAQZZqD1us1lqgfN8mXhnuOy?=
 =?us-ascii?Q?xL5dGcgCbfpIBalAoT1DIRbGnqJeiMsHOuXczYW44/86bz9Fst/KWgAbJYTb?=
 =?us-ascii?Q?in/vitGNYM/ie14yn9Vyg3LvwVzqrkL9OEJi1r9MLy8L+OwuwFA3f33B3muf?=
 =?us-ascii?Q?Wcqlwr34S0ddJ1BXpw7Fuj94CVXnOobLYPAmiM75+4ljjwWeIW0B+ezvuB3Q?=
 =?us-ascii?Q?VhaCtSVF5gPeVNRvulJa9cYLwdTRu83MtCBavugkOkiXlQx2B7VhUF9xPK0s?=
 =?us-ascii?Q?O7mqW8PQ6lTCg6e3v0t/Ap6xIH3Ltvp7LmAE8UIIjaYjWGVSrDZWZ0RT1Rnj?=
 =?us-ascii?Q?baZSiL/aL+wh684Bai5wAC+dNtZvu6DmtRPQdk+YK3ggGSLP7T/D7EwjBFGT?=
 =?us-ascii?Q?apJSYIlJJB8imt6JRTfSYk557brMJ4veCCh1aEFJ4VFlm6SBeNd529ua4mid?=
 =?us-ascii?Q?37+56/1Yjn62FZEzsfZRwvQvT/ODQkqAlFnC5czTIqJ3ZUOWFy1Vkyczs51W?=
 =?us-ascii?Q?YKCFTxohXLjWStQ2eMOY3AmLsxAMlqIuNY5uKUSlYrnH3tNgDbvdDcMOD7+5?=
 =?us-ascii?Q?GsDCLRnmJJ/44sHGiYsW3hQZxXgJOqmtOGagqvaGfnVxavYIiDj0eqhUS7yy?=
 =?us-ascii?Q?A1k92UCH5Ej/H940S6N3QH4Ft92ezb9T9W7eG3usJexthRsonST2rot02S2r?=
 =?us-ascii?Q?ZzDq8ZEl4PyPUCJz9p2TJb7J73cVUzsU7lbQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k39L2ehvpATpS7qGZOOZ9QiSDuXSzI2HS0UfjNU5OD+0KOLSewp+Dv/FUeNb?=
 =?us-ascii?Q?EuEwWwLLy8CX3NwonGB2sY9NT3FrkzSmBvCzUhoO5U80Co61pak6yfg+S1GZ?=
 =?us-ascii?Q?Z3zq0CP/HWhJ9wtGd4Su6vMAZI4fkYPyBERgHtQI3pK82vVuFOK3QaYa1+KK?=
 =?us-ascii?Q?3dgr7i67skz4q5/GcuuteGpH65fjsdLNyKGIaB4bWqjAHNMmVb/CgTqCvBnK?=
 =?us-ascii?Q?wkJoj+gByROd+fxCq62cLgOCH40rCYHFylIJkxI1P71Hf7CFijSHP9xHAK2w?=
 =?us-ascii?Q?qtXD65w52I4ce9jlvmaPZaXboLunNbohe/pBFG7evzv0i0yvtzBFzU4JBbOH?=
 =?us-ascii?Q?Z+Q4Cu633/SPh77rq3MYkv/ComAkNrNR+jXhlhkgsTwuzR7JZ+FICE/ldMLN?=
 =?us-ascii?Q?n8TQj6Ttr1W3dyCsArh1I1pFG5IrUnFlQ4CxAgUfl6AbbaJ0sEPTH8PALPh3?=
 =?us-ascii?Q?NnXBCc6yrUelI6rad+B/w//BPLSbsEla6Z/SaU3U4xRRqm7dagMlfNfeBJS2?=
 =?us-ascii?Q?Cg+amfuwKTUgf3TD7QrUqS9L9LSsppwPQCf23LzCGXQ9A6Vivq6cAJEX/2kV?=
 =?us-ascii?Q?I6jM69W6maGxv7c+wD/Q0Ilf3LM0IwIRc41T/9s8wuMDtWro3v0ydJmDTjG0?=
 =?us-ascii?Q?+tps6sfxeCU/L31N7w3vnLoCJko43J1HY2uzYdn15nvbAtFfRwfqSkfgNFy4?=
 =?us-ascii?Q?RhIECx0gheghqP2xjE8nOQfUuVJL+FyN1PhrSBP5nDu7hpQO1J11ndVYuoVL?=
 =?us-ascii?Q?Df0tN0mdXSwxqxEJtLSx62XEJw1YpIaqTYGfU4fmbJEC5Nf4wzXS79jcp0yN?=
 =?us-ascii?Q?RMO6XeoDu+7/ZaykC4TnbL88sa+8zHfigIlXQTk2IZFyWZn6sMb3GjPXQ+A8?=
 =?us-ascii?Q?MK8vJVKMoDc/UPbhs+wBz5ju1M47cAszRO4lNGKuy4tkk6rmr1TvLjK613DX?=
 =?us-ascii?Q?hJ+zm2DgcDPYUr7BiL8hHEZ2+H/NPIAwngt9+43N470cVYpyowm2Cky60/k2?=
 =?us-ascii?Q?x7t4ggOCcY/eHEAt9dNtNTAxgaZsYGoVEH8iFpMszhlCDwjtFek7Fl2TISKB?=
 =?us-ascii?Q?vA7CIJXKTdYB8pwiCzHDR52qolA2TBeu16BIjcH/KGElK2+hVK8OxIl76EnN?=
 =?us-ascii?Q?HUWzKbJtTV/KMuaniha4Q4haTfllGyP0vl2xM5agK02fuXZYzP4nvUhK/RNl?=
 =?us-ascii?Q?qoUtKwJRgRl+l5zd+QWhCxyg347YMtGUs8R7/N8AFxhsJks7M4fpvtQVIFmw?=
 =?us-ascii?Q?FR6/+o6Xa59nRl/2HB/63aRH4NoMnNddMbvsIqpzEMSOlL8ErzEdKMgseGun?=
 =?us-ascii?Q?+6wcWJwJcHp/lCiN5npr1qt1NMoC8vJXpRlWwKztTE+bDMy/zeV1P4f9e3zn?=
 =?us-ascii?Q?5CyAxa6EhXFfUVPYRtLB4pCZbpOzmjVyHl17/vklzBuZhfJz3qj7ZX/+/SdD?=
 =?us-ascii?Q?k4XgIDJGViPiRx7EzvHyDotM1ygc9SJ1tgU09kDqCjFx+4O/sbwkwwYphM23?=
 =?us-ascii?Q?JwzPoRoFkPDk13YmtVbAA88aBE5wYI9eVzrvfliEmDL3823jLuAmh3IIsYrw?=
 =?us-ascii?Q?qzFxB8vGiLpPjaX68KBtOgO/7arHDgrPEtMoJMhf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d22bdd-0a7d-49df-f03c-08dde536b421
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:27.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LFrRTFKPH2kLd3DXkwXl9ZKhqpMsPV6DxE8QdMyaak567sv9QSzqJ4AQGR99A8MWbCoW//++dZUjjwIMslMaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

The NETC Timer is capable of generating a PPS interrupt to the host. To
support this feature, a 64-bit alarm time (which is a integral second
of PHC in the future) is set to TMR_ALARM, and the period is set to
TMR_FIPER. The alarm time is compared to the current time on each update,
then the alarm trigger is used as an indication to the TMR_FIPER starts
down counting. After the period has passed, the PPS event is generated.

According to the NETC block guide, the Timer has three FIPERs, any of
which can be used to generate the PPS events, but in the current
implementation, we only need one of them to implement the PPS feature,
so FIPER 0 is used as the default PPS generator. Also, the Timer has
2 ALARMs, currently, ALARM 0 is used as the default time comparator.

However, if the time is adjusted or the integer of period is changed when
PPS is enabled, the PPS event will not be generated at an integral second
of PHC. The suggested steps from IP team if time drift happens:

1. Disable FIPER before adjusting the hardware time
2. Rearm ALARM after the time adjustment to make the next PPS event be
generated at an integral second of PHC.
3. Re-enable FIPER.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v5 changes:
1. Fix irq name issue, since request_irq() does not copy the name from
   irq_name.
v4 changes:
1. Improve the commit message, the PPS generation time will be inaccurate
   if the time is adjusted or the integer of period is changed.
v3 changes:
1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
2. Improve the commit message
3. Add alarm related logic and the irq handler
4. Add tmr_emask to struct netc_timer to save the irq masks instead of
   reading TMR_EMASK register
5. Remove pps_channel from struct netc_timer and remove
   NETC_TMR_DEFAULT_PPS_CHANNEL
v2 changes:
1. Refine the subject and the commit message
2. Add a comment to netc_timer_enable_pps()
3. Remove the "nxp,pps-channel" logic from the driver
---
 drivers/ptp/ptp_netc.c | 263 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index defde56cae7e..2107fa8ee32c 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -20,7 +20,14 @@
 #define  TMR_CTRL_TE			BIT(2)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_FS			BIT(28)
 
+#define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
+#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
+#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+
+#define NETC_TMR_TEMASK			0x0088
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
@@ -28,9 +35,19 @@
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
+/* i = 0, 1, i indicates the index of TMR_ALARM */
+#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
+#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
+
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
@@ -39,6 +56,9 @@
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
+#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
+#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -59,6 +79,11 @@ struct netc_timer {
 	u32 oclk_prsc;
 	/* High 32-bit is integer part, low 32-bit is fractional part */
 	u64 period;
+
+	int irq;
+	char irq_name[24];
+	u32 tmr_emask;
+	bool pps_enabled;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -124,6 +149,155 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 	return ns;
 }
 
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
+	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
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
+/* Note that users should not use this API to output PPS signal on
+ * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
+ * for input into kernel PPS subsystem. See:
+ * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
+ */
+static int netc_timer_enable_pps(struct netc_timer *priv,
+				 struct ptp_clock_request *rq, int on)
+{
+	u32 fiper, fiper_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
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
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
+				FIPER_CTRL_FS_ALARM(0));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
+		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
+		priv->pps_enabled = true;
+		netc_timer_set_pps_alarm(priv, 0, integral_period);
+	} else {
+		if (!priv->pps_enabled)
+			goto unlock_spinlock;
+
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
+				     TMR_TEVENT_ALMEN(0));
+		fiper_ctrl |= FIPER_CTRL_DIS(0);
+		priv->pps_enabled = false;
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
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
+	u32 fiper_ctrl;
+
+	if (!priv->pps_enabled)
+		return;
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(0);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl, integral_period, fiper;
+
+	if (!priv->pps_enabled)
+		return;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
+	fiper = NSEC_PER_SEC - integral_period;
+
+	netc_timer_set_pps_alarm(priv, 0, integral_period);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
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
@@ -136,8 +310,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
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
 
@@ -163,6 +340,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	netc_timer_disable_pps_fiper(priv);
+
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
 	 * TMR_CNT, which will cause latency.
@@ -171,6 +350,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -205,8 +386,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
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
@@ -217,10 +402,13 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.name		= "NETC Timer PTP clock",
 	.max_adj	= 500000000,
 	.n_pins		= 0,
+	.n_alarm	= 2,
+	.pps		= 1,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
+	.enable		= netc_timer_enable,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
@@ -237,7 +425,7 @@ static void netc_timer_init(struct netc_timer *priv)
 	 * domain are not accessible.
 	 */
 	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
-		   TMR_CTRL_TE;
+		   TMR_CTRL_TE | TMR_CTRL_FS;
 	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
 	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
 
@@ -357,6 +545,65 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
 	return netc_timer_get_reference_clk_source(priv);
 }
 
+static irqreturn_t netc_timer_isr(int irq, void *data)
+{
+	struct netc_timer *priv = data;
+	struct ptp_clock_event event;
+	u32 tmr_event;
+
+	spin_lock(&priv->lock);
+
+	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
+	tmr_event &= priv->tmr_emask;
+	/* Clear interrupts status */
+	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
+
+	if (tmr_event & TMR_TEVENT_ALMEN(0))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+
+	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(priv->clock, &event);
+	}
+
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int netc_timer_init_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
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
+	err = request_irq(priv->irq, netc_timer_isr, 0, priv->irq_name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "request_irq() failed\n");
+		pci_free_irq_vectors(pdev);
+
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
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -376,16 +623,24 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
 	spin_lock_init(&priv->lock);
+	snprintf(priv->irq_name, sizeof(priv->irq_name), "ptp-netc %s",
+		 pci_name(pdev));
+
+	err = netc_timer_init_msix_irq(priv);
+	if (err)
+		goto timer_pci_remove;
 
 	netc_timer_init(priv);
 	priv->clock = ptp_clock_register(&priv->caps, dev);
 	if (IS_ERR(priv->clock)) {
 		err = PTR_ERR(priv->clock);
-		goto timer_pci_remove;
+		goto free_msix_irq;
 	}
 
 	return 0;
 
+free_msix_irq:
+	netc_timer_free_msix_irq(priv);
 timer_pci_remove:
 	netc_timer_pci_remove(pdev);
 
@@ -396,8 +651,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
 	netc_timer_wr(priv, NETC_TMR_CTRL, 0);
 	ptp_clock_unregister(priv->clock);
+	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
 }
 
-- 
2.34.1


