Return-Path: <netdev+bounces-207579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02260B07EFB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35897A2547
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA792BE652;
	Wed, 16 Jul 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JtJBp3lG"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27E2641E7;
	Wed, 16 Jul 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698044; cv=fail; b=bEdybMaRFgaxkdsD6h6R1WRzyXNJgYrOS8uQo+ctYvBJKBIHSGAAZAtZSKSg9YsO4k9jlVLYM+gA1kIee4glct9lilWLlEzhHYM3o8j9HPx3eJwHfcNny5cyXvXsuX2mJAAVD4n9wRiX5u2L3mRR6kNyEfrviNvyiCHnAdSEnSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698044; c=relaxed/simple;
	bh=dG242a+R74MqNYUi+XuaCCkeg2OyvX0NBGLT4lJG0Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UBBcBSXIBJt8e5Eq+4bppo6v0zCFonDLKj2SEFiRNGKbZY8QUumy5OiuTI6EdOnwApHLX5R8ocl/h36TQV3Q4ERO0XFDpPqabuBHPOWO1MVqcfSNYI2zCY9uii4lm6A48bguG7D5W0p23tzaGIavLKYu/nSio2NVVEO4qVHVP3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JtJBp3lG; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYkJOqIkQLfYLXUCY6kbooeAnyFkEvRhLZIOVdiq1a7QKRi/vXHq7nVdsknfJKaQ8UypbxUXpGgatFu0Mqi00kyx1ox41Fl4333SYfu3MUmX2TMfrt7HEY7FrOsfLO8D3IafhWnRcfaU7ov7PjlMGxKQCKZ4fbU2OJm03F0yQI+sDM9aKYVTvvMaRTUnxdD42CRawx+5Kv/hBfWoef5+Q/PC3E70/4sei5kEKQUtmzhcwQF+WZi+W+QwTegsAbERfRYsTvB1RNyY1/nDhm/ibMTCeczXAlcbMA4wzQ2cuoxyuxzLWcPrwsF30KfAH5r6eXj0MbN05j5+uNxkZZh1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNX4Ynzk2Cmy+abZiMBhd5AvpAgZg8hjJkKNqsiU9K0=;
 b=HgY+0Szj2qpNTBbbsJ/WllOOjS66PDFXRnlQF6nhjoodl5xEUu+fnkAqpfFr+tBVa0fh+DhcPRAfFSdDFA2OhByUTpFv9uw3V7MBTER0WYD6K4S3Vc0FHr86QqF7Jq7k2Lih8AIMF0GaF91GkhSHIkoX++/B4iVTao/27WoHjgSH6w1W5ahrjSJcbGnyZByqEzm+OC5TAr3GRmnIl1qWs9x3GC/e3ZqVIrM7x347yy1RJNf5jhiUPQRNXSpzr0PjC6ww/tiMVz0VxurCtNETyJXZsyNPojrmvyRWZvYbq5fluN4A5LrVfYTLk/hyqkU3OA3K8gw33WZKNArheWp/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNX4Ynzk2Cmy+abZiMBhd5AvpAgZg8hjJkKNqsiU9K0=;
 b=JtJBp3lG0vqhcfuGGTChpunt24JVH384tMnbe5axt/Rc7TyKp+3S04wPzZB1uvmEPJec67SWurzaH+tDTo5ob/qPfwFv/PDDPYEvvziSTIu3JT6cuaDxVvv3XQiYjS6i72aq70MeYnt4w+NJ40SXFq2EIF+Du6UFPLes6M7OAYkGY4jgbJ5Fmrwz/xdnbYIfUFaXgYJzSj93XA2bDSlYVHUjd2le0ruOoCAJ8SCZ9rPU9tw5iy2BytUM1y6SO3EEqX3RSOst20gpN+lr33ZQU4ZJnOp0fp1WUisZEOhRKd6PGua8gqPsZ28tpfRNHkgf2s7UHnwSXZh6aWELGbz2VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10145.eurprd04.prod.outlook.com (2603:10a6:800:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 20:33:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:33:57 +0000
Date: Wed, 16 Jul 2025 16:33:50 -0400
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
Subject: Re: [PATCH v2 net-next 08/14] MAINTAINERS: add NETC Timer PTP clock
 driver section
Message-ID: <aHgMrs/EkO/ERn8p@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-9-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-9-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR03CA0073.eurprd03.prod.outlook.com
 (2603:10a6:208:69::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10145:EE_
X-MS-Office365-Filtering-Correlation-Id: 757b9d32-ce71-4f8e-3d18-08ddc4a81688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?35SPAYs+d1DH8zJXDK0uXHNtWMFN2d50WG5yY9udRczCAqnY1hS2lckg/kyX?=
 =?us-ascii?Q?+h39nRvbI2bKWt6uN0oE5ead03BmBDuXO5Zy0MPDF8Y7QRT0HJzBRi6+Myxh?=
 =?us-ascii?Q?iZGE0ycviKcgNjoJUR19xRZGNapuNKbZj737+40KrGmnn5ykvJ65B7m8lhmH?=
 =?us-ascii?Q?vai+wsTksCkHzRZ1BFEFhD9QPHK3r4BukQBm04kQ8yCn09F37O0hZdOo1vQd?=
 =?us-ascii?Q?vhHtbDEwKlGBhIJm/Ep6d4rZpGNGSKTjn5eY9p6n7AoSfuWiEQ63uTGDWXU+?=
 =?us-ascii?Q?6o2oTs6MkzqqQfsRXpbgamKcnWsuXfDSFeb8NvIHPISloVWXzdqOHjfU7cNe?=
 =?us-ascii?Q?JL3b7+Z1Gy/tpx0rYzk3ud3QgHT/WpiNGk+qPkI6e3GnhRMTaI9Vvzfi5Eoq?=
 =?us-ascii?Q?rxQJgdS0hCeCm6p8iqdzSrvpXVe1E3DsBOABvlgHdW2CH8RmRVQQpF04cM/H?=
 =?us-ascii?Q?bFfgTmanKQ3COadQLmBuUaFe9FopjBZlKD8RgBGsc/3z0XRwslSUzQUG5/0d?=
 =?us-ascii?Q?CZHXmNd/bmLh++4nz8HX3/YHERkEGs2tCeH72JI89dFOI6L66iQrdpI1ku4h?=
 =?us-ascii?Q?5wEGmDesoxoTI/YkyvZ7Asn9+j+n04hl9+qjTLxoOMVrc9yzgrURmbHtaGN6?=
 =?us-ascii?Q?ndyNimKkxrjGnOH7oMG59zuTZuBVELDLb/i5IAxMBXE0VEnC1I4HNUZ7NoSS?=
 =?us-ascii?Q?FPzorNIl1lwkA+jm9SgSm4CxUdqCXFW8+CHcjIptL+10Y8j1ugmC5YsKUWQP?=
 =?us-ascii?Q?0+lrJGxI5mipMceB+I2a/ldAYF//IvIbvhTBBvr94tnxg+7bcaEygRq0NuJX?=
 =?us-ascii?Q?pFdzMnrBiMxk6nBkIXv4ZMFj00J1eDzpQI7FAU8Tr7XymG/0LEoqTSO9gNkx?=
 =?us-ascii?Q?k7c7h7KNf8DebigPmEfDwqFjkw6AMnAUCpOHEhNh14g7u2m/WogHv2N4s0ZF?=
 =?us-ascii?Q?ml5kFhHPtn8ZYs0zhiJHugZhM3hYjyL41J/YSTD0nP2yov8kODPt9CURnQo5?=
 =?us-ascii?Q?3PINEGZ3mfUo+ADCEamU7q9/K1lxlPqBXlq5bQMW+M96+HYU6mnnxFZyU+Lc?=
 =?us-ascii?Q?aCvRS93HV0MTF3t1DaIEJlqhd9sx/6pabwJDIvCNt+nzX9TsTuj87uRHbEBe?=
 =?us-ascii?Q?3eHNLsYiNPTh7CB3AEj8yFECOs2OWtGlH4dt/HuCw4wDB4KVKt7SbNINhZmE?=
 =?us-ascii?Q?6gyT7SiDqQeye6jfBLh2L/c5zoUJL/oBpkKgGbjkVaHt9Z07hpmhGAaaHwdp?=
 =?us-ascii?Q?xZoNDIvNdU9+ZWnDvqTdf/YNBNFZzcEOXQGgqJJbIgyxzcYc/AklrBxtOyiL?=
 =?us-ascii?Q?qjKYHtAfkJ/ptpVaA0KQIGtd5nWHVYhvuzZYVBhYPhL1RNXHbHdafpR8aFlN?=
 =?us-ascii?Q?YsyKuBMyXDqXlT53gKpXqfT/I4+Pk7DaFJdaybW2/z4kbrYLiaCkw2H98tXE?=
 =?us-ascii?Q?gM8YdgAvzREACltjCGzYcBCZfwKQnht4JwWEd/moVhxenxNjtImecA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5RB3DZv8m9ms7hRkNjN3NWV3RB+j0rUn0PNqTobElFczC93NDzoirbbSN+wN?=
 =?us-ascii?Q?yrJae64uqwbpUOgfLQviqjdRkCNk5G+pg9qXrNKgHapPjAJT6GANGBLqscWv?=
 =?us-ascii?Q?jLitxE8HbnO3YLm/jfQaPACrRu23w65nk2aoeQ8LB8gFzILymVeXNIYwzjDs?=
 =?us-ascii?Q?Je2QtqHiu5Sig7kdGT+SEXURUcyVp0MT+nw8W+cJnkQhJ6Txs6TlMr35cehm?=
 =?us-ascii?Q?l7eGrTNNnnF4vw+tMSGe3W+H9Iwh31fO0ussl3Xir0MHsur5K2Ah4yo9Kq2V?=
 =?us-ascii?Q?0ui78xsKwqSYTTpCb1o7OiUYPU1owSsNH8Qj2rCkqBEirJrq5ZEaVRN+gcAi?=
 =?us-ascii?Q?adGI94yhIbWKhJNGupK2ak8EPA7zLeYLLptvixPuWMqgRspVNSlVpUD88yrV?=
 =?us-ascii?Q?3mpexOKbBsfQrr/LPaMBdBYVVjZgfDOs2PEsEUZq034lSHPYqnEgiQQzkklP?=
 =?us-ascii?Q?hb+po23UWRHMR/lFwfbT0t2XZixc/97572BiZ3Rg3EYccMqOhEyDpQUE+Vxj?=
 =?us-ascii?Q?qcuqKYhcT1S7Cv89FTR9SZXccPCvmy1Mi5Hp7LWEi5FnGs5cSxOEO4rjc5sV?=
 =?us-ascii?Q?Sr8KC7QfkntmFVqRmHqWzNkKWAmMnJF1PCl1oi9Ck7WL4uknxrgc+MnWDOwU?=
 =?us-ascii?Q?DC2uDphrV+NbxTbkBRW963hBeCGpoZZXhUvgbrlrcEOPIilTEfrIH3cEsS/S?=
 =?us-ascii?Q?IrXzEjoATcUDEnBYcARpWOncohb7cU8iIjQDdm1wcV/3+23GhA3GEZ/kxRi5?=
 =?us-ascii?Q?0nlSgI/TwzYCmFCfQQBTF+nghgEm60mw0XlQ6c4OeIhlDNm71AAQbg7KFQOC?=
 =?us-ascii?Q?Kt5G/KCQdIxBCINqOWceLFYD0Pi92XkfTRgmM4ganCaCeWmKXb5sy7xLddUb?=
 =?us-ascii?Q?UkyG0j3s85mw5qONGQWjA+Ldcwye7oGqbIBm55CgHbbO3zYOTJKh2aREWCvc?=
 =?us-ascii?Q?Mkr1dd1LrYGke78qWjzlyKmz6/DErBx6CiH5P5wd0wwkqVBWHXqpm7Ac4a0l?=
 =?us-ascii?Q?KIs9dnI9rluo1914el7d89sYwZmm6IpSndmmH+X5GJpchH0f6XzDd4J58gm5?=
 =?us-ascii?Q?MiOx7ZbGQQVQ+5dJUC7b0w8lI8i8lpBPtJxrVW8OCDCwDK4S0vcMItr5AWh7?=
 =?us-ascii?Q?qha5b4nwSw5GsYDKjEPUzpE68pzIbFaNhtQ1ZMGVphk6o1na4tDktlRu2MFy?=
 =?us-ascii?Q?WtNlVycCUx/ZJSgC163RuK6MeANu1SOLOzOhQ7ec0D4xb+3XVMN6WrZILCgr?=
 =?us-ascii?Q?mm1Wkn+JeiZVYf4BzpulSIZgkST/Z3Er+xGqTkMmBN7tTgKM+654/GE7iT70?=
 =?us-ascii?Q?NZOHeAwgfawSwYz7rWWFARbjFabdyGeFEQOZ3pUbnKigcSi5ZerzdUaiNg4A?=
 =?us-ascii?Q?+H9SkoSLJ9K/9DHhd5v7YbrUCLyxZNEr4pkxBLLbJ3ZvLzgUiikI91oAMw15?=
 =?us-ascii?Q?Ar7EuNJsxO27PaXAZ2k7248blp2hcE6EwLKPDH/N4DxguQc60eiOnYPgT4o1?=
 =?us-ascii?Q?DFSpS2VcF69ndRqOtL4uoaloS4b6RCySlks26A2kWITA9SneBjVuDvIdvuSh?=
 =?us-ascii?Q?ZdlEVfKs92CIIgEcldZgsXZJS/9Q1tXDw2EB/xov?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757b9d32-ce71-4f8e-3d18-08ddc4a81688
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:33:57.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7S75gNBTwcM6vr0shXiFTLLb3Q+GN+NfsRtYK3XFyUD77sAH9Zqnfd3HRAF5ubIo7/RCmT0ZYOzYLIdqeNO7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10145

On Wed, Jul 16, 2025 at 03:31:05PM +0800, Wei Fang wrote:
> Add a section entry for NXP NETC Timer PTP clock driver.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1554f33d0ac..dacc5824dca6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18005,6 +18005,15 @@ F:	Documentation/devicetree/bindings/clock/imx*
>  F:	drivers/clk/imx/
>  F:	include/dt-bindings/clock/imx*
>
> +NXP NETC TIMER PTP CLOCK DRIVER
> +M:	Wei Fang <wei.fang@nxp.com>
> +M:	Clark Wang <xiaoning.wang@nxp.com>
> +L:	imx@lists.linux.dev
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> +F:	drivers/ptp/ptp_netc.c
> +
>  NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
> --
> 2.34.1
>

