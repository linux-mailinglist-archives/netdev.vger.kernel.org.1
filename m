Return-Path: <netdev+bounces-216377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866CFB33557
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E8F3AAE38
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3327F749;
	Mon, 25 Aug 2025 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S3QEyQ2e"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F52877F6;
	Mon, 25 Aug 2025 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096667; cv=fail; b=SWgsw/Nrj0dxp9b8p2hq5v0HREno9UQn8ssayPF+sdl6x8JogRR33hUpxJq1to+fix6xEeEaIiFp9SiQULuK1hHG58fFChdIKuYQuTorsKqcHtzJwxfjOxuxEstjtDALKTWLbbW5lEw6lcEcLs1ZkQir7VTDkvnLqL/U599ipKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096667; c=relaxed/simple;
	bh=hF5UNdOdmYEvr3YO4bJQXUPYEmdEGigM7FH1BEk/g48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3Zs0lFHFsZ613IGw2h25elYtyENWRhp/d9o6joZsXF9z8Jm/ur65JYaHTLoc8fy9VdUkWMGvOaayeCjNS5fJoCF/dYMg4UZVq5DhZGGpARVZ8GWdqRxymqJ4mUJmm5qw6Mm7gz/+xMIxmNbaVJHy2tMCNnAEnRwx56hnNWagMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S3QEyQ2e; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+AkJ/mIzC/UGXbLAtqtvGwkAIbrm5d7ydfdQWxQXdET1dBPU+INCB90oSvzYx6OBo/kH/ZHoDQsDj0Y4fIul75CEWS76HxcvAEtHiB3WNaGz3J+BSbF9QWidzr34/7XizoQ9mgxqTg91qBW/A4dOoF7MJosIysMilCLakwbvl4nIIE3/CYCliLgEp+tkwMxL3URo4Tx07nEXeXlq2H87CBsTxgFb8kdCSesW7ScDAWbEWOvGWzTbTQJmRFvq1tho5xtk6S6yeRqDPpFGM92UsD60T+LlYZH3dxEti/4OlQc9saBQYPlQCaagjBtNE5VJFGow236I5GtCh/IuVp/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=vUXczvzHD9ghlYemHLIP8aaG4GtQ429wOejJr0nXVLNme3U+ijc/p6kNzeXbvlfu55MAEZ/xxw0JKRXj+Sc4sdiK+CSKCkvPN/bY1nKjh2vjj4tqRT/d/0FdWqvkHXiktPK5Xo0ticbFOXEwdXRiA2sntjsx1h9rcVhq+5VMTdG2CAZfcQnpzi+FDnRw9VS3HF3QSj2qKBxq8km73RyLbXwdfQ/2Y0NlIK2TCV92fgxxyIfgM9c60+eCF9otow8jWjCYJILA5U79tK/pSAU/094C9bv2d8jNdR68RxeRpRbApOnree366nZ61D2fA6LO9ZEI399xoTZOolf9kuAt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=S3QEyQ2eaW4T71UypkitIRCt90t+koCs3TlnIOLY3R9s5faKEizTtp6BlqUIxGTzJhQqIEfWj2Ki100OOtJMXH57aC0YuSDntPDj0rv583am3zumEv4wrtiF1Q7jZUl0+COGvQMfxqA9xLYNxNeZX6CJngoBKugW850/mwxs4Kv5ADoqXK5JYAQnOerrlgjecI0RcqVQDvcHl0qxXpzp0mRoXjDue5a0IIdg8sa6hSfM6ZdDsCQl3PSd+F9G62h7fDsT/J928Q8srUQt5PwyQ4FRu0oLlsqypoEa0u0tFfiLaA6KCsknRn/NX4gnnGxj5poS0UG03b+NUA+6TTHWpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:40 +0000
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
Subject: [PATCH v5 net-next 12/15] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
Date: Mon, 25 Aug 2025 12:15:29 +0800
Message-Id: <20250825041532.1067315-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: a665d020-29b5-4adb-738d-08dde391200a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/kT5gz/bTiaGaNMC1yafUVPDq2BdXQKIfXB6TVNbksPkEAaIlH5E1No8aj2a?=
 =?us-ascii?Q?W7/w9zny40+uM+xRWq1WRUPAh/jQfhF5XrOyvHsHB9NAS1iOAx399C71N4K9?=
 =?us-ascii?Q?WF/8vNod+QsvDtOKpa05E0VaW4DsHZGRNBbO9l/S+s8Zm+/KTMbjUuTkC/lO?=
 =?us-ascii?Q?sV7PU1G7hTASi8j4+iwpjbtcNu3//yGzK3BXuqVRhSWLzYyCzc+TVFANr5v/?=
 =?us-ascii?Q?3PgoSXDG//mJvewTwH0OoP82y5WIw+R3H7KjW7wG8SQA56Jj9ztMWuCVO8Nc?=
 =?us-ascii?Q?RFyr2XRhMujKXxphSpPqgRgxLwYmjgcjp0fX7QAtEVd0Lzta7eBj+oWkFZzj?=
 =?us-ascii?Q?1fWnfrRw7LD+LEX9MxNvIPvyoqZvfRtEDAHe4mm1gbvy+1Q8qE+MIH1vl9Kx?=
 =?us-ascii?Q?kjZCFpsP84TOzydC3r8Y7vVA7SKxEYHmVKCg6mw/1BBSqli0mnkpf7LnaUaD?=
 =?us-ascii?Q?XCVgDGB/Z1mmldo34nAB24Whrd31VeKJie8sYqU2LiLbygzepFlG8Comv+H9?=
 =?us-ascii?Q?2uRGwFWvbBl75a/u5fhymHeUHUbB/bqKz63xwpaOYZazK+SiVk7Gram6gS+2?=
 =?us-ascii?Q?bdTo93f+ly80POFz7GN3FG9xNYoop0CvdxYrF73bNgizeeV7I0UxnXaxioGZ?=
 =?us-ascii?Q?+Tso0lyZRFfnVo4GAFLVyInYSYqsNBM/K9pnkfP7DWla4le6K5BdJbgfTME/?=
 =?us-ascii?Q?dMDoP+IZFY6cygn73wRGhaZWjybUjhwdegc0fdQbKAcJOA097nLpPhW4z7fc?=
 =?us-ascii?Q?FPF/RzXkH2ewwUkeSPwB8kjdppTAwbsnNiV9yBDU8GbjX0spKMChkx5bmSBJ?=
 =?us-ascii?Q?dwl6AmYPhCW2QUOFkxOak9ZlsJe+4BDruVyCncChpNghuZbKCPQgq4eMm4by?=
 =?us-ascii?Q?g+Et9vpG3l2CwUWX/X+TBJ5GPSRyo8m6MJgJ3zYN0iurHaNKmINgxJA4S0PE?=
 =?us-ascii?Q?aa5jYMRARrg9Fk3Yo+YMeEs95MiByEdMA/kX4zZp96yRkrneO8/o6ImiEUMY?=
 =?us-ascii?Q?iJWSF9ON84/W98+QwLYatvyY3qlr1yesK2SyzTkr3cujYoxRmwFNlV7jbOXo?=
 =?us-ascii?Q?M1FuPADoVwxSqxyoiT3hUST1Q3eU0D2Ni6zxZ/MxGxTsAUc5O1ROU7YeP5VE?=
 =?us-ascii?Q?l3ATtbsLZ1ZDL3HOQwl5+FhHTyFApv2pBk9CRk1+ffRpOn6iSZGflQ4ejmom?=
 =?us-ascii?Q?frkxPWW9eCwJ9Iwgg+3JVwEuPxI1IXG6EgmVtNOistG6IsXJM5XYM4gSIUt5?=
 =?us-ascii?Q?GxMvR+yKmd6aWGaZQWmvRF0CzlcuTLY0znC0TP9EYhUeZj6hob3Nqz7npu/s?=
 =?us-ascii?Q?X84DiVF/Nk3XaNC38K54zOSgDk7OpZJts8ITRJWTxcpNQkVXMmcJftuMQJpS?=
 =?us-ascii?Q?l2XGWw0u+q05j+Kwh4K1E0J6fe85qohLzrFDA2ZFDb41dCNDzb6n9zENAv5u?=
 =?us-ascii?Q?R2q9M+155GBlD7hg7twIsyuE5xe19VvzWRJRABLNs70Cxb0dCE/+MOm2VfYr?=
 =?us-ascii?Q?2Ux7RI2RPuxtYHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFOw468GQGonL6XYYqOcZXMiFobsxA9fNBORA9cI4rZHs9vKAvvtpaOnqoiT?=
 =?us-ascii?Q?SZZ5wZ10UlfD21j3FBrqQ+b0z0XlfoS0fnjZJ4P+40Oe1eaDlnJUH7xqEvBy?=
 =?us-ascii?Q?Rx5M2jaC0EJDBzNutpjekXYxlBaryT1jNU+htuplxV+u7k4PHVppNEWJQUHS?=
 =?us-ascii?Q?8aQxqmclNUMPsREM6uzUpQ9aIbfjK9Eje6z/yRcVXhoSmrWrEgDV1cKOkBsI?=
 =?us-ascii?Q?3jn9yvryM4IEq5vAejYvYD6Y0xA6wM0wnNNyeZZbtg2s3178sv+RxrjzX5xo?=
 =?us-ascii?Q?Xb7bkgu8nlIkWnS/AVqXwUqbWqydeYbmwO84V11s90pTfJYJ1muYlUBmWvvn?=
 =?us-ascii?Q?fnsq1me7CG+/NV7aJFL76AHMb2P0BuYmQOfIQSiU1JZhC36N4kbfOkHlNLkK?=
 =?us-ascii?Q?KkGvqHjEa3ysNRDpFcTgJQwqlYfr0lw7DVbzMuVVPBRdOoDvz4kqsc7n+kh3?=
 =?us-ascii?Q?x2aY/f3qtb4DKhbN9ACl3zYTry6V/jbcq6pzKkn/qMMVsrfg+SwKijcRcnNo?=
 =?us-ascii?Q?UaQ+9wCbzZhgNd1sMDIDhFEU7XatQsNPOeuWkWqasAKy01DzfcFgemjhEjYZ?=
 =?us-ascii?Q?MK77y1Qidtheb3zCjrxUk09cDkhQbZBZLNH20vS5dj4pvPyV/xMK9Gxs4NWy?=
 =?us-ascii?Q?8Rb+pMgDhWNpm4Acbsc9Of+lZVHCXEmgusdOpQJFlX+nK5X8Ge5zlSRpuAAM?=
 =?us-ascii?Q?rggWna/vm/xI9M+31EXS+h9OItEJKFMB4+FX3j9S6ZJFE30f8Nq16yYWEU4k?=
 =?us-ascii?Q?JQU4Mzbev1/GDVgSfqll4m+h8L1TCUcFro9ctGagkeiprLtCGpYBvPUNmNoi?=
 =?us-ascii?Q?IrTEaJRxCvHQI2mpEgvLzI8Z2++ayWyhvQTQnhYWtEk51DtvEy4pcNRdDHzl?=
 =?us-ascii?Q?O8f22B97kwjQn/d2FPP6QfynRToPGW/aQiztSd6cROtdEAzYnBFk0SVOAY2M?=
 =?us-ascii?Q?S2HiYeXOlF1gErIXZ4c/W4tGZo/5eEuJOHqGAppjwi8b7lWnrMu4bGWX5p1p?=
 =?us-ascii?Q?nua/Ty3dR4+p2MeEYhhxZq7fMlkyVvduxgoV2gaaqtGb+vS/O1/adU2VyLmm?=
 =?us-ascii?Q?7aEuu20y98071Bywv6Io485ZVh5Bu9cLB/ePfrvsDKRPIAEhzFmpIrYykJsR?=
 =?us-ascii?Q?NFoyqkqDY/S0imzfpbA6t5/E0FHP43SpEmnEZfE2o/Y95Nvwq56QcUYyt0V6?=
 =?us-ascii?Q?pk+WBGoqrjcKH9kkfO5Mt1aLg9zFSR0pAfo5IU28MbB78CYORY4NotG8W6dX?=
 =?us-ascii?Q?W95duMnr3eLqklNL9PjTR548x23+39PXCtTmu0gY5TxmiWKrJR6SkeJndZ38?=
 =?us-ascii?Q?8A3UkX8juSXKJrvxVS9/FeZ0o68skL6ebBaW9PPMET3IsixAZoXukBtOoWIF?=
 =?us-ascii?Q?QTwapYN8IBe69/u5NVrb0KDi+teiYY3fV0b/4XWRi7/WllR98vSn+MTWe+Wj?=
 =?us-ascii?Q?w9Su5CPw99d/r7RLKoR7+zKgpCh1/qNUc95cXCGL5cxa+vbagwgODoxfeNyj?=
 =?us-ascii?Q?qO/Gv/HR2VJmGolRG1dRuEytHwIRHx405/2D5E4MUfAp+E4hD4uJAxxudR+n?=
 =?us-ascii?Q?MXxEenP+5YgBWXD55XnOQ3prTSyRG0tR6HPHw7mX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a665d020-29b5-4adb-738d-08dde391200a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:40.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0Kx4G0TspFnTnj5XCbyOMTrL0cuaXa1K0XGuJbmeVxr4IT3OCMc521X6zcjF7vBsYv8qPmQsGw5gqTx0jfkiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ef002ed2fdb9..4325eb3d9481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
-	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
+	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ce3fed95091b..c65aa7b88122 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
@@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		new_rxbd++;
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
-- 
2.34.1


