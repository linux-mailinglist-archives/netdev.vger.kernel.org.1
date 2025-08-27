Return-Path: <netdev+bounces-217329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A8B38568
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB82173803
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B921CC68;
	Wed, 27 Aug 2025 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j8OdSZj5"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1332144D7;
	Wed, 27 Aug 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306157; cv=fail; b=QGJHH2vnyBTiidVIUj6dw06n1gNXh+4oEm2X6gQmUWP/an2RhCJMktKyA7eEeN6xwyivyB6LA8DsY7CpyQFYtj5o2iXpfM1aOYvL6u4w2ngvxRyVzwt95UeSf2mgKRrrDAACOkhiIHr6wYWUpZvzYatBUe3x49Ambhmseb7KDnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306157; c=relaxed/simple;
	bh=eHKjRwastsij8a+Hx6h8bimR5Kc4WqDfBydbUbGH4PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPm79BbDNefHSShz9aUYQFGOExOBpckrS6lr9B4eGZ/YX8YvxQqN1a0L4cLRrsyQln13RhbZuhLTLTYiPs6B/mcVb4vSgTQlhOUIOonVxuUmdUYAZ/HSOjFztsCRI53UxqXfH0Vv3lLxNuFaLFWrVngdkhWbx4eEWX31C12XFdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j8OdSZj5; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5orp62mkZwB7Q/BlqO05/2r0w8PaTBKz9mO2eUUqnvmaibSDHrDQ3TtiPlLiIlduw6n4isu/gSnBO6Ek2jaSz6SjFX/N/8V14Fdz82GNVWCrOZy0Xn4AIE8yiw7G4PGKg5LACtcmv19Zwv3vazimG1crqtgRWrkxN/MJOHe19vdv/sYJt+4em+qOrkJciQG7BBSS40LSP8PhbpRCFWSSEGzkMi29dJfiDFuTtXA/IGV4+PE+xvnpouRT+oXPodhEQieyPJqN6X6zLLxPAPbiUP5cZ9/Oc4nVqdpMNdIDsjlfrmoR8ts8/UPR6Hl4DmOXwCV1J5xM0oapZuJVzN7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXAV7U+MqTQ8Jb+XbdmQqiwYVFeMVsdXSI7kQqrwuu8=;
 b=KQqA/MavuG1vdG8FJ7ad65lCD5i+1gffByywaBI4VURr+h+HBk6byrIEjd7ljoDNgLE4VVfIe4CTjanMWXpcR3vW6X1ebvZWrfFHE9xTBRT0C1tYaCoP1NrT0BaoTiL4dJB7c63tccF5BOxMGC2y+3FXbiNF+E/RN2hzgI7PNpDt02ORPyAvISPrijQTpD9y6t/PjUUwuwlth7uxWQF1rxuZtDLKCXuOrvn+rZ5JxALO1H1S4Z5yrMfbmDFkCHj7zm7orpJzJm8EwJwv7CXmEdmj8DP4NctznqMyx1a5QyUG2SS1xot0ya0YJ55ZeMshWB4jgTqHxHrNGznMfHViKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXAV7U+MqTQ8Jb+XbdmQqiwYVFeMVsdXSI7kQqrwuu8=;
 b=j8OdSZj5n6CXUUuLERla49WJt/zt/XDNpylUXvRLM+4gysnrnfB6cgGetz6ZbwPSk/vRoN4FN8fMNoZ+RC4dOtm39IwLDOMTZegxNweKeINIGE8essDUbfgg7qlPQVF3MbMUN64JF4k+Sn9raAf2uJA0X+NXGwd8LTfIwL3CGBuMFw2CHQJyBPJ6D4iuYwlKWZkLwYGb4DZts9qGGKZEjzXJwLlFkjQ0Isu4/MG1yQLkvspT2cj71ISX1Cz90ZF4d6iyOyVW0dXRNyYT6mldbnOgB/7repL0XbBnfCWXlZ89myd7to0eQeHQ+MzNoYg/SS+FozYcce2fx/i9PlOqKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 14:49:11 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 14:49:11 +0000
Date: Wed, 27 Aug 2025 10:49:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 net-next 14/17] net: enetc: move sync packet
 modification before dma_map_single()
Message-ID: <aK8a3+gA52I6Ffcy@lizhi-Precision-Tower-5810>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
 <20250827063332.1217664-15-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827063332.1217664-15-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:a03:54::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 57140640-12fd-4149-8a8e-08dde578e297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yajrUl7B2TeEicbYolc9QbWuXJdJj1NRwfhdcaxwH7GKKJ9TRkJhq9FnYozQ?=
 =?us-ascii?Q?pc8hT//+r8rLcsX5NnJ9duIHP24ypkTsNERNoWtliP2v0JcAAg73O3kGvNWw?=
 =?us-ascii?Q?+m/dD+EfCUoasIjP+r02wNqHdZc2r8y9HaC8ddB+yt/L/4CSkyq7IZdct18X?=
 =?us-ascii?Q?El2mYDsHuREwJ5HMEKyxO3ijmcs2hVv12/fzqW2b5V22EvTuRgFdROyhTeUu?=
 =?us-ascii?Q?0dzBopodYVkT3li40pYUkaRFn8F43LjGCykWfX8g7tD3K+8/pQPOLj2g1ReI?=
 =?us-ascii?Q?hlna3PwvIizyOifYP6Zc5+Sxif28Ny9kpFU0/zx2vWId0YmEjx7jhAuTkQx9?=
 =?us-ascii?Q?eGXu1nRcHDDsRwJbHIADexSexH139ZipJrhnwaGOYErd5iRSdZmBY5CjmLD3?=
 =?us-ascii?Q?B87D4iATDQhYfIq0gTw7hOSI/3MgNLjBY+T2y7CxF2NhLjQfWa4fgKuzRfqK?=
 =?us-ascii?Q?3KkNdrnyrtxw2jFmTTcDIWWltWQk3YsyeFJ/yRFfzCNQhf/kqxcbBI3znB/7?=
 =?us-ascii?Q?jSv/gENiZXBek0WYv/F91agePcp6WoR59QqmTO172j1J3n7pxscwLusgWGu7?=
 =?us-ascii?Q?mGANGGUo/fJN/6cfs8s2YhKHqE3HNWkJ/8veRg7up2/plU4aG30W2KWUN0Ae?=
 =?us-ascii?Q?9N2RnAw93Sws40hXMu7Mv3B/ELXbJkjCMBXkVufxhXOaGtE1OEIaCRlmJ9GF?=
 =?us-ascii?Q?h/SGgXL7R5i1jhermyzmCUYVCt2tXhxQNt/pYF0HRcl7jXMUd+ek0QmFBFwP?=
 =?us-ascii?Q?SPOPPD2jxFNqfcO7JlTh2VIMNJc7rkVW5NaIEdNGFVHAbJq6u1tmEyexzlzm?=
 =?us-ascii?Q?kZsMzS+c19xkx+9lDY/QYSjosaX15FhKgG1ZIL+qEM4R880T3WNs5FqfhsXy?=
 =?us-ascii?Q?ObQkQy0FseF8J9TyKREfTmra6eH71t9v63q91JUaTOF7osfmWeoPeis5CyJg?=
 =?us-ascii?Q?FaOT/2b/Hg9c9BfE81pdiEX181NOxHsoNgcL43hgUeAMaE4g3iF01h634e5t?=
 =?us-ascii?Q?HLIW4SEXaSRQ9nI8UbOnVC3MqBDdQ2QRGyQIFxWBsc2NE+z2mXflPWvUgvG3?=
 =?us-ascii?Q?3uquC4IuUyzW3AVyaOsA/AxxC+E2A4He+hDyMBubPqcRorxMbgvnFnpqIy0E?=
 =?us-ascii?Q?nLgSxe815aAI2CpjgwVXvAvUjZG4qZemUXieQz5IlywQg8MMN0DyS04HR5Ir?=
 =?us-ascii?Q?V13v2pNMq066B9+WbCoi389T68QkxQuKes/j+Akcm79PLP84So2CC7j9xVoW?=
 =?us-ascii?Q?v4IGWqpbO4xCj4fqpCVyqESuSBkW90uQIdIJ8d2hdXR4gGK1TZaEDJ/kZmkA?=
 =?us-ascii?Q?YsI2r8WGsvUHnuGCHmW57JHkWOnQXL6EhsPt1GKNFsS8wGkha0dqSUqal1Xl?=
 =?us-ascii?Q?vmkCH5UOnc/Je6pO9NKsHTI9Zcj+6sD2bSwgLanbn8aY6Dn3nAWeSA8vs4o6?=
 =?us-ascii?Q?gsEZdSNmsyYz+O4K3iIMgEsg5xNiQoHhlxmluKgJpAdq8oJnQV1XMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4SmACd8JgMCNaZRbz3k4+B7iVrbbrW35T2K5w3MEJXW43ttq89a15HjXQD+R?=
 =?us-ascii?Q?Wr8Q36ZMhvGWruBHExgJdMwBJQjB6pRCj7teR5IcjGVglWIF9Kdta3/GwZ2t?=
 =?us-ascii?Q?C/NedevD9MYydTNesqWl6wCn4CLEc3YBfPMMFuc6g18DdSxCY3o/u6oV1TEi?=
 =?us-ascii?Q?qpMqv4+F1xA9JmsixVwj2RLdsVl9dC0ZPrSR0BYXRV89hueUlMQ9dKbIkfHj?=
 =?us-ascii?Q?EsRjgQY03NnAxi3AHVyNC40l69oQQChBtjIGOnfzV30MidHtKjDvi3PYWCIO?=
 =?us-ascii?Q?LVwcD7krJC7eaizRZPmCFo2fA1GUfkHrkX1S+8wgAG7aNXsccLWm5mzeqsYk?=
 =?us-ascii?Q?DSZXUTbvw9iG2b8TkhjxEuP04ngG8se1iQe1qGVFSx7Axe//W18dhuFmbyBS?=
 =?us-ascii?Q?nFQGiKg5IOmGz14EqcIOvfEpo/gNv78OwKEIu6A2OyQRChhQV8rkmfSvNpWV?=
 =?us-ascii?Q?XtFVnv0+lLT1ecFO1PVQO/+7O4iOA7hi371hYvZ9VahlFTqG1iTxGDGgZFLZ?=
 =?us-ascii?Q?3aJizxxNLT+wtrdFCjT0zCQydZc6KrTHqvrvg0GaYx6Y2cbdXtsBrEeLEF9Z?=
 =?us-ascii?Q?Kb3l/wdeVVV0KJoaBx8fDlXlpncda4lh3wx0ZFed6oQJoVnCdGC73zgOxaNl?=
 =?us-ascii?Q?usL1Pf1tkNCyi2ehGPtGtAHlsEnM/YWiG7hQF5SXKhtFl8SyTp9pKv6tBP+3?=
 =?us-ascii?Q?0qX9JoN27Yo+aip/0i5rFhkpVuCfVN3AfC1WlnkEr7jIsuye5Z/h1S9AIYkZ?=
 =?us-ascii?Q?Hfvp4B0fcsbYQLSp0IfhN5AmlIkcj59kutbx6dDpRYFhVOxfhR1tcKMmoKNj?=
 =?us-ascii?Q?AsNhLZpnz6fhUCPFOra4v/PL4o0Q0OFuN/3GgH9+UfySgvHaXkBz46xH7Z4a?=
 =?us-ascii?Q?JLf3izBB7IuRmHkfSlG0Cmv6HHnvvUZyfxOI0DwZXp3yaBxTiG0LMTpdOORq?=
 =?us-ascii?Q?QPlpAfvQGRKfOunZjf07JHNKM6PqkK9QaBTqgvMnyIfcorRectNuwyZLu4Fe?=
 =?us-ascii?Q?wmOPMKEieyEAdPJcnWjCAA1ZSMytgZoFr9UFBPMrZuGuWbv42AHnOGLXMU6M?=
 =?us-ascii?Q?rHhkJ4lrAP3m6SLmKQa3CuOzdn7xpNNxUeU67mibW59sWvip6OULsAMt0Jrf?=
 =?us-ascii?Q?BiNtL4gQHso3AHTEdYVVrUhwjLAF9rWZYsmoob4UxUueuoIa1oZ5Y5pzVhrO?=
 =?us-ascii?Q?d3xkoE5s86mQWDF/BcX5ofPDswhjpQnl7J8T+nIS5slFvb3QjHMOzdenpyKv?=
 =?us-ascii?Q?O2GVkalR2aYiQVO9V+akzlW7bT6/kdacg7j6dK4Fn/y+mEIqFILABwLPRqZk?=
 =?us-ascii?Q?mVjOqm50zLTyH+D0KCKQZeKTODRdT0lQ7i47uu1ykwp0/Ka0hifNAa44b1AY?=
 =?us-ascii?Q?DW4SzxJWOvEg2svUbkdrrBJA3dBW/UdKWxDPYhpfjPgcCuCFE10Cbm9OIZ/i?=
 =?us-ascii?Q?OKv1lhU4WM6r5h/x2Tl1Oun+PIOhpe/KOl/RHMNi3JHed7jyvxWq42otlnYo?=
 =?us-ascii?Q?ojp0vhHG1ztueT+LF/1lLesdzWEqhZd2g4J7c6vkX7eKlaJ+bcPtpabPJoCk?=
 =?us-ascii?Q?8YvL2xO2+MQjzfoJ6NhTS8F1ymZv3oReE2WD3qfP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57140640-12fd-4149-8a8e-08dde578e297
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:49:11.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe9bPeeuzdnCykKleTiSQFVOP9sPE5SoeP79UDvEil3ZVpT/PjheYbTLRhbc0Y0mH9VCEtFKXfVnfJyHrLS1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

On Wed, Aug 27, 2025 at 02:33:29PM +0800, Wei Fang wrote:
> Move sync packet content modification before dma_map_single() to follow
> correct DMA usage process, even though the previous sequence worked due
> to hardware DMA-coherence support (LS1028A). But for the upcoming i.MX95,
> its ENETC (v4) does not support "dma-coherent", so this step is very
> necessary. Otherwise, the originTimestamp and correction fields of the
> sent packets will still be the values before the modification.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v6 changes:
> new patch, separated from the patch "net: enetc: add PTP synchronization
> support for ENETC v4"
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 4325eb3d9481..25379ac7d69d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -303,6 +303,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	unsigned int f;
>  	dma_addr_t dma;
>  	u8 flags = 0;
> +	u32 tstamp;
>
>  	enetc_clear_tx_bd(&temp_bd);
>  	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -327,6 +328,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>  	}
>
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +		do_onestep_tstamp = true;
> +		tstamp = enetc_update_ptp_sync_msg(priv, skb);
> +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> +		do_twostep_tstamp = true;
> +	}
> +
>  	i = tx_ring->next_to_use;
>  	txbd = ENETC_TXBD(*tx_ring, i);
>  	prefetchw(txbd);
> @@ -346,11 +354,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	count++;
>
>  	do_vlan = skb_vlan_tag_present(skb);
> -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> -		do_onestep_tstamp = true;
> -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> -		do_twostep_tstamp = true;
> -
>  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
>  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
>  	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
> @@ -393,8 +396,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> -			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
> -
>  			/* Configure extension BD */
>  			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
>  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> --
> 2.34.1
>

