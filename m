Return-Path: <netdev+bounces-207580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA62B07F17
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FF93B06A3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08B1E3762;
	Wed, 16 Jul 2025 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CV5LG6JA"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4F1CD2C;
	Wed, 16 Jul 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698780; cv=fail; b=a3mxoCX7n2R56K7MDl2sHzrbzIMp7OweQXva68i4S7KMoyTcYiHi5lA1hJM7A6QfIQ3kOrLWGoCM6Fndh0e7J59KhfP+75shNRtfmvTJGyHcAwYL3c3b81g/ex3YxCXzjrVb0DqVcePd5YLiYtJJThg9lfVE2TEpI/29xb36UKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698780; c=relaxed/simple;
	bh=VWJXuCPYZYYgBOB5vlXHO2GlQZRZwgqY2CzWSl2TFvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FwwlU49DMlnjGqvx59s4SjoDIXVgDVF9cWEgXh66p9OWl5trfkWiV+Yl/drkOM04CeGUnebmNAg6kfh7sWjh0H0HhZfiZRx5NumGUxpmS3YnZRBtgZSpTIaifq4OLFWpkpvVmPl3iyEO8Zfsk4lI3nkvoNXtX8rHFZXhijyjUg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CV5LG6JA; arc=fail smtp.client-ip=52.101.71.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lns0w/g/0KUmFbOeIpcetdO3V7CrfraJVILN92LLWtLpDlGd1UTdqr/bympmWd2m5MIXP+ZNkifBQNe+WD0hxXwKUEx0qpwkjD2YS8y0vk3n4bCX+swGyQZUN+n81Vok9Qvv9CTvdO7xfbpxGSiUJR/TfUbhU80XxZ5EITq+addU0kulcfOKu2SWjOPg0Hb5pnbejd8YPuIMS4jdIkXzl5b79DwVnVD6UzzXYwofskpwvmhgFYlxpnplFochVRGlHrRPBvMhpJH7mRL46eP6K5v2rVyRRlKQNm3KGUFcdbSkvyFlwpMtCLN+exe5FkB9uTFbvJIJPY7mA0bGG4P5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KZBm3hCTnx2Qqvs8ymoMYdgWGrfzvQjmd4nHp0SC18=;
 b=SOapuC+GnFX5pyQEEDobX6H7Vf+uzE8X/puN95qGWzQLS5dnHEHFZWw94jSe4KPOr0Io/Zzz5smiOCLWlerhO0EQ7cN2b3RwQDzLLg8wIBV1FPLn7lhYJY4cw8xUKHtXaSUZZq9JFxQROwMGIWyPl2lCmw/qsHzSfSmUGVwlAgb7dg7FBBVSbfOpGLqnAdl+aU1mzJlYx7gfgQ59jeFDJHPcFOvcuVyyLlW1yOkCZzyD35Lc2TbNA6qKM74ea392YvR/y3OdUZMVZheHoGrMYBRguP9S15wO5n/md2iiJEXwTnvzxy06gcY5ed72u9Wr3thM9J0lEkNaKJy1y8WTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KZBm3hCTnx2Qqvs8ymoMYdgWGrfzvQjmd4nHp0SC18=;
 b=CV5LG6JA7H998ja80sV+/ZukZvsjRA0l65U0xT+cY1wSnk3kDaAWnIo2gG6LdniPmEaNF+pZ/v93VcdL1xgEWt0Rj4PshqFdoA3pG/AkVqvmyIbSmXL3Bf7TEnzHaZoE/wRArLj/VTs0FvGkcoKhtdme3pPMpiXNNGjJHvDIL3zZR5b5L0XG5FV3EB5EFPV1nviAVnKUBLkk1QcohVquRxdcMQwDlhzYgLBqaUZMqSBesf7Arv0HQToxva7c/ZacxR5hNzGBdr4Y+fcCpWgbkJgbVH0A8s/bLKEP/QuXpVzhcP4hkDtng5z6kDFEVmG5gOIm3xKNU0NtdduicubOlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10192.eurprd04.prod.outlook.com (2603:10a6:800:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 20:46:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:46:13 +0000
Date: Wed, 16 Jul 2025 16:46:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 09/14] net: enetc: save the parsed
 information of PTP packet to skb->cb
Message-ID: <aHgPjwiIWfhYnPyC@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-10-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR01CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c23634e-6e94-4800-9a97-08ddc4a9cd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzka39FxRJEzjb8FDHfipFfNQSnvl9xoUUsbeIrRcLEgZllO5QoU3n5B51uG?=
 =?us-ascii?Q?cLMtAkFN+PZ5UmSXPYMww+KJcOhnjfAUBHirTpDDAJlZ+vdcnyyNisusXceP?=
 =?us-ascii?Q?TY6TIAlYd5NXfoHyI8hsV19GGq+wEqF02KGMo1UzhD+abrmOlNoRZA0cq/63?=
 =?us-ascii?Q?Xvw5ifkl15IVFhSFtZkJDNeIe6me+K1Ih1HWTPS1I6E28K7MjvrNW0RgJU3D?=
 =?us-ascii?Q?2OFQDzNMjzcnPMshSWAcofI00Q1t64Z/mRwgsGEZgHwJHe6b3qzxSYtaMQxQ?=
 =?us-ascii?Q?rTqZmso8cZFKSIAebqtRA+9OJRwfV2wZWRX2dTgBnzXNC91QUPGnFCurDwI3?=
 =?us-ascii?Q?Rd0q4PjPKYGcR+UflIrN3xqhzsLEMS2cl0MN5Rqh0jSZMtfnwgch+kAJYyq5?=
 =?us-ascii?Q?KGsfM5jFClPD2t5oFNeJZK+uc4/CizLp1gaxsxw7xQSuKO97VIhKJYEjqqPI?=
 =?us-ascii?Q?77hKJSKOzJXTGm0b3L1YYTGZunrftPHD2whD+51Zo4OFfunETEqfBcAGFVeI?=
 =?us-ascii?Q?txDIMQZeLhQrv3X1GpHlYQSVzjGgecanyb75pqWGAfMRvZENiqeCL/FNa8e2?=
 =?us-ascii?Q?ct8lT6vdxV2q5ffX0yEha+tO11cYoAR650vUbAXOgnRgzTaMNkHpyz8W3K17?=
 =?us-ascii?Q?CKVN6nWJ/20QgOW+HYcFNbagbEY7wLv8r2ykZc/JJbl5+EPr8nmFBwZuO2hy?=
 =?us-ascii?Q?irYzgB9gk24B3MTz+pL7X4aUoQJr3cHNgxJi3Cv1J0CwKnndO6o81keJabDp?=
 =?us-ascii?Q?NKpaEFvyAAK0399UPQxWrKGweqPd9W51BQJK2LYRuFp9sQsHIbiJ/J6Xf3j3?=
 =?us-ascii?Q?LA6r3jyZ4sAKP5HwwaLXHUxAiYccbt61WtW+HE3mcZP8+TVmKgZUnQbsVTW/?=
 =?us-ascii?Q?r1sHtyP3ayFU76xVewJX9KsVA9KjO8WD1IJ+1O/MNLFHg55zTsWYlBW0Gr2M?=
 =?us-ascii?Q?WrBl6Y5SW49NR+/uWMobJa9rCGJRiQA7PoCXDhlEiCZ+F3JT40eXuMLcrrN2?=
 =?us-ascii?Q?S6y5x5z8a032Q20W/B1v1UsoRs/3JMZtIWMNYj4pE0ifr3fyvNFNd8B23n5l?=
 =?us-ascii?Q?J4FyIKoWe4bskgHxFcHKVRy2HLi0S6lfmsuveDUIAx5MFuxMY7mJOF30x3mQ?=
 =?us-ascii?Q?NDgU8poRgni+rXbVtHhuVei3wow5WKSHh5aSDcqSCXR30i4rIr84PUWfpnvs?=
 =?us-ascii?Q?Pvvy4TAhMEAchTocn9iKo2FczJYWhMzXrGP2frCAMvoi4x+nLob4R9leKTv6?=
 =?us-ascii?Q?3Fb7x/Qt5iKyCt1NXnjrH5YunmCB1TGMkhWxPJ+PY6DSgvJsJz+TUkShfHGQ?=
 =?us-ascii?Q?UGZn+JkPOLHSkRkWR5IFAGKzVheVsuBFyJAAZbJGDLWYUOmEa9iRciSf90dR?=
 =?us-ascii?Q?rz+GDYg5Ete08n5+9SiBFfFznAcnMFn4w0v8HyfvoMXdmQYeHaFTntPlV9Mq?=
 =?us-ascii?Q?7IksYZgjygiDqBuMpwBk8CBrtoZEwz+D4T1wcePGPYDHqqRoL14Z1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nzm6jcGLJxyvwW+cOVPwQzC/5fawx08qk+0h1ge5MJhFIYIfOeovFEFPbXk2?=
 =?us-ascii?Q?Q+8IbSdlxWOxwK+CeLnpNHDvTSqAmwY6M5Al6LrVgPejuVK24Bxc5e8AI4aK?=
 =?us-ascii?Q?WofsEL6U5yhB6zV3/Z9dmtok2C7EPrw9S1UAPtJtfmH6IXgMDu/z+TFIx7Di?=
 =?us-ascii?Q?8gLq6UVE11WL2E9Myd7+vkuO9lKcFS6oCCP15fCLLt4s3CzMj1fhWediCWz6?=
 =?us-ascii?Q?I/gzgs4h1aNfwczXYt2h+LASqEOQIwIUWGfstnzB1BdwPKC6bbfTEftdLGrz?=
 =?us-ascii?Q?I1AJOq3ZrCCPMDBdCZpm3qviYLXvi72P9p4J5vJMddifQpK8aVxQcNS/Fhy3?=
 =?us-ascii?Q?IOvrYx5YD8CMh+9OEgbBh7m00U2/W4sq+FBFnEgrnnGNOZwae44NSUyFx9f3?=
 =?us-ascii?Q?H/soJ8ZynZxVabAw7UKfCaVP84URk3z42yhuBtg5eX+1BL/eipt5a37/KQ6I?=
 =?us-ascii?Q?hYAp8oMo/r3irN4YLGtdFBth00SijGNBbU/WH4l3GTSKNme45GZj1pSVE8ZK?=
 =?us-ascii?Q?HMLIs1SYloHYZIRamNJjGSd5v7y18tgNW+X88DTKhfO6jKiwMFf/22U8DALR?=
 =?us-ascii?Q?Wz/aGXTmMjbyg+PTgHZ4L8Dn04TaMEwqhnfDpDxJvGR2MHORkFqBBvMSHrQt?=
 =?us-ascii?Q?JxR0KwJumcVbJq3nurIPynTOc6gB0VJBbhl6bVxcusGRGx6A5ukmW+GDrmcr?=
 =?us-ascii?Q?bLAUGVM+6jKgsZPfZ3nTlsPMcO1odvmoq5KewYXvXJCV+h7hFRPuKd2t2/To?=
 =?us-ascii?Q?ginEZe1g5HGf4f7iz6n9lxFXxnOoQwxVVEuaCAuJaBBhbYefCjUj3DzlOV71?=
 =?us-ascii?Q?v3Pbq5YtohA7yiHMtjKmzxrtk6/8gIE2kaMVlSZYYbp0L+cjCYASQWERIYb8?=
 =?us-ascii?Q?HSb7i0tbajTHPjIeDMRA2IrDz7EuUteQNcQW0H8BoZgsWABQN2svNr7uEOCo?=
 =?us-ascii?Q?Gd6hGFZ9mkufoIeH74CCFTMUgBjlwzM1P0BT8gwaNwSHmey0cTVdku7Mgx8Z?=
 =?us-ascii?Q?450w68NlDGc43mD0qgf7nwzhDOwwK4gKHNrMAAtrp8hUQHrI7tsAOG89UC12?=
 =?us-ascii?Q?k+sDav9Vx1QRaTBqvMlcS1npouven1quQgAXFC7ET80+KK1yN1cO+e4n/AXs?=
 =?us-ascii?Q?rE5oHbWy7h0VzaVaGP9ghsDh4Qc8nJFFKudSkLVhGM0yUnwxkGiOQGmdVCJ2?=
 =?us-ascii?Q?112BM+0SzvMQaUZUUl22iMrsQ+QWXof0rWhPSKDseuoobGikbOOzey66hWla?=
 =?us-ascii?Q?X8p4l1hVK5+WdAi09KomLONLNuTUJvTWAqOYY8FTF4odgj8vGTMXU2q0T9Dk?=
 =?us-ascii?Q?cTE0lnr+NycQ4BamlZy1ExdHP0YPQOJYTRh67RvETU1nJTVKqnO2CswOY3z+?=
 =?us-ascii?Q?dgp+ZwIgG1itXKOtUamdsHtLlrekjYAsQm03Pzw80jWPT3IjWmUDBoJeOrQH?=
 =?us-ascii?Q?WSqP7sMEvinT9meBw3hZkCRKlwBM0YRrHfey1KSY0pJrfmX3TOQ4mD7gEj4G?=
 =?us-ascii?Q?FGN/ebwGw7zXy8UHr2Fw8lZxCPwQDxG+uo6/ZGs14zhqkvCYVXfgfHzvVwbv?=
 =?us-ascii?Q?czGlEcq1VDxjiPG5N1P2r2nnLhaYmHBYyigCTqQN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c23634e-6e94-4800-9a97-08ddc4a9cd70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:46:13.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuLE4Jz+D11rg8DIlVYrkZLGZW7Uv7esif2p6/mU4cV0VSVBk/9LlaIFgojpV3kfRFPFd8f2TEgJ2FvS36At2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10192

On Wed, Jul 16, 2025 at 03:31:06PM +0800, Wei Fang wrote:
> Currently, the Tx PTP packets are parsed twice in the enetc driver, once
> in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
> and is unnecessary, since the parsed information can be saved to skb->cb
> so that enetc_map_tx_buffs() can get the previously parsed data from
> skb->cb. Therefore, we add struct enetc_skb_cb as the format of the data
> in the skb->cb buffer to save the parsed information of PTP packet.

Add struct enetc_skb_cb as the format of the data in the skb-cb buffer to
save the parsed information of PTP packet.

Use saved information in enetc_map_tx_buffs() to avoid parse data again.

>
> In addition, the variables offset1 and offset2 in enetc_map_tx_buffs()
> are renamed to corr_off and tstamp_off to make them easier to understand.

Also, rename variables offset1 and offset2 in enetc_map_tx_buffs() to
corr_off and tstamp_off for better readability.

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Add description of offset1 and offset2 being renamed in the commit
> message.
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
>  drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
>  2 files changed, 43 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index e4287725832e..c1373163a096 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
>  	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>  	struct enetc_hw *hw = &priv->si->hw;
>  	struct enetc_tx_swbd *tx_swbd;
>  	int len = skb_headlen(skb);
>  	union enetc_tx_bd temp_bd;
> -	u8 msgtype, twostep, udp;
>  	union enetc_tx_bd *txbd;
> -	u16 offset1, offset2;
>  	int i, count = 0;
>  	skb_frag_t *frag;
>  	unsigned int f;
> @@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	count++;
>
>  	do_vlan = skb_vlan_tag_present(skb);
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> -		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
> -				    &offset2) ||
> -		    msgtype != PTP_MSGTYPE_SYNC || twostep)
> -			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
> -		else
> -			do_onestep_tstamp = true;
> -	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> +		do_onestep_tstamp = true;
> +	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
>  		do_twostep_tstamp = true;
> -	}
>
>  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
>  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
> @@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> +			u16 tstamp_off = enetc_cb->origin_tstamp_off;
> +			u16 corr_off = enetc_cb->correction_off;
>  			__be32 new_sec_l, new_nsec;
>  			u32 lo, hi, nsec, val;
>  			__be16 new_sec_h;
> @@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  			new_sec_h = htons((sec >> 32) & 0xffff);
>  			new_sec_l = htonl(sec & 0xffffffff);
>  			new_nsec = htonl(nsec);
> -			if (udp) {
> +			if (enetc_cb->udp) {
>  				struct udphdr *uh = udp_hdr(skb);
>  				__be32 old_sec_l, old_nsec;
>  				__be16 old_sec_h;
>
> -				old_sec_h = *(__be16 *)(data + offset2);
> +				old_sec_h = *(__be16 *)(data + tstamp_off);
>  				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
>  							 new_sec_h, false);
>
> -				old_sec_l = *(__be32 *)(data + offset2 + 2);
> +				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
>  				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
>  							 new_sec_l, false);
>
> -				old_nsec = *(__be32 *)(data + offset2 + 6);
> +				old_nsec = *(__be32 *)(data + tstamp_off + 6);
>  				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
>  							 new_nsec, false);
>  			}
>
> -			*(__be16 *)(data + offset2) = new_sec_h;
> -			*(__be32 *)(data + offset2 + 2) = new_sec_l;
> -			*(__be32 *)(data + offset2 + 6) = new_nsec;
> +			*(__be16 *)(data + tstamp_off) = new_sec_h;
> ++			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> ++			*(__be32 *)(data + tstamp_off + 6) = new_nsec;

strange why there are two ++ here.

>
>  			/* Configure single-step register */
>  			val = ENETC_PM0_SINGLE_STEP_EN;
> -			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
> -			if (udp)
> +			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> +			if (enetc_cb->udp)
>  				val |= ENETC_PM0_SINGLE_STEP_CH;
>
>  			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
> @@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  				    struct net_device *ndev)
>  {
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	struct enetc_bdr *tx_ring;
>  	int count;
>
>  	/* Queue one-step Sync packet if already locked */
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>  		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
>  					  &priv->flags)) {
>  			skb_queue_tail(&priv->tx_skbs, skb);
> @@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>
>  netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	u8 udp, msgtype, twostep;
>  	u16 offset1, offset2;
>
> -	/* Mark tx timestamp type on skb->cb[0] if requires */
> +	/* Mark tx timestamp type on enetc_cb->flag if requires */
>  	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> -	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
> -		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
> -	} else {
> -		skb->cb[0] = 0;
> -	}
> +	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
> +		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
> +	else
> +		enetc_cb->flag = 0;
>
>  	/* Fall back to two-step timestamp if not one-step Sync packet */
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>  		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
>  				    &offset1, &offset2) ||
> -		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
> -			skb->cb[0] = ENETC_F_TX_TSTAMP;
> +		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
> +			enetc_cb->flag = ENETC_F_TX_TSTAMP;
> +		} else {
> +			enetc_cb->udp = !!udp;
> +			enetc_cb->correction_off = offset1;
> +			enetc_cb->origin_tstamp_off = offset2;
> +		}
>  	}
>
>  	return enetc_start_xmit(skb, ndev);
> @@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
>  		if (xdp_frame) {
>  			xdp_return_frame(xdp_frame);
>  		} else if (skb) {
> -			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
> +			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> +
> +			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
>  				/* Start work to release lock for next one-step
>  				 * timestamping packet. And send one skb in
>  				 * tx_skbs queue if has.
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 62e8ee4d2f04..ce3fed95091b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -54,6 +54,15 @@ struct enetc_tx_swbd {
>  	u8 qbv_en:1;
>  };
>
> +struct enetc_skb_cb {
> +	u8 flag;
> +	bool udp;
> +	u16 correction_off;
> +	u16 origin_tstamp_off;
> +};
> +
> +#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
> +
>  struct enetc_lso_t {
>  	bool	ipv6;
>  	bool	tcp;
> --
> 2.34.1
>

