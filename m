Return-Path: <netdev+bounces-239179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CA2C650BE
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA264E62CB
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56392299AB3;
	Mon, 17 Nov 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AyXYKfpy"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07802580FB;
	Mon, 17 Nov 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395684; cv=fail; b=U9Uduy5S1ScLV+SdjdLz113th0KE717ZokpkWgCLcKyoCAsxpuTitXmZJTFfqYzRVre0w+ld6Z1DEp7y9D2YG7VbI0DrmcY/9GCkPwemJerYm8TO2MOkOIt4INkK72veEIrDODmk01nhaZuKzUpHCcolyEDNIWB5fFUeSlTF+Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395684; c=relaxed/simple;
	bh=iUIcaQwTcNQFonR44xut+oWfGoem5HzoN3YZq8cRl/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGCsuj1JMSkwtbZy/Jy6O2i3O1IBoVJSjIcpGY1iHZsacvVkKqxIkK4v/1Th3URTpsltXPfpDrHRooG63xXVm1UxrtoV2iqsNZUH+1JKjOKyi4OVbHRg7ZBQY824JhuSVRiKmGUGGNvjn7UkV2YTQExaw99fPPjB4Bg4/Ub9LLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AyXYKfpy; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m14PyiYGtQ4q4bWHD7wcLWiP8jVukyunhJZSD5aEja8r/a4rdKq8vrqzqRtkAWHS3klC1rb3Zvo741HJTvMYr4j0nD39miub4qTpDW1owQJUJGSqi+acBhQrhmIlUUOHshohitjpXzeA58X9c4SW1U8uT90z/IKO7I0dkapvyhOo/BgxSO6pYPJdzlgpQbNIih0s2W3RDkpNlB5NVhCIi2a/BGMVNG7khdcvVfW5zgaMWe94Qy5d+6EqhHtQiy8eDMmaKIcRHXNJD1DoU1b2ZX5OLWxEip9XSTKbk5j84qAr98Qmxfg9cvlkRz7z7U6qnUpsKrQsmRcmnLvxSeJTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlB/O9spfhPO/Bs4xlk5Pi9sK19TOmSR2BFp/QvPL8A=;
 b=H5RczZ5sdXy5hqGktP1Y61qHm+sPIok9JxL8jr2dHHea2Nfm7QtolIuNCPZw1MkeMDA4jc/J3qvPmmcMOBvLrqZqJlcW++naJgsI05qhfBRV1ojZUvyHiOZjGLo0/B0P1tfwV0MvRO5iAafUJUMYcSDXU3348oKFvWMhGfPmuBGkTbjIMmzkyBsxJNMkvshmOYAaRPUG0kj8On+eF21/lnV8IorjlkNuf/rQZjiUhfqbe4CsNPNAe2jseeacxRP0XNa+BbluhZM3TvhTdDuK7RdHs68Y5swRAtqF7MDnVRey/0WoS4WfI4wgUTVexB7YdZ8dcpOn77U+CGJuvLbxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlB/O9spfhPO/Bs4xlk5Pi9sK19TOmSR2BFp/QvPL8A=;
 b=AyXYKfpyB7wudF0hI7/tyepGptW1a8J+SsUb86tXi1/fr9+Q0i9Jw+L8BGKDn5Q1/YfwVa1X3NqsXcmE2vvGYD4RviXgjkDaZ5jTNjQpyrapsWI9vDb5sIiz3ORdavija6MAFwLS22a9uAdG5ylPfEwBDXAdh7TGGOVPE7+7Ui0zKQt4xaxKCnuwlE4f14s8CWXLgy0AMBb744rLMgH6OJ5gJ0TI8rg+4bT93x7pp1zoTZknmD+oMGJYvgXA/pH5gHoVw0pzJD9kv+lJjz0j8fwiHo/NYN3qcDwvuQnv6NO1121SVPe1nLvfaKlzxeQ/FxjH6C41uKx2bN8YQgSvQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 16:07:59 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 16:07:59 +0000
Date: Mon, 17 Nov 2025 11:07:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Message-ID: <aRtIVlVcv+8+LtHv@lizhi-Precision-Tower-5810>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
 <20251117101921.1862427-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117101921.1862427-3-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 2999f1ad-9d09-4fb4-730e-08de25f379f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?peDXXziZ04DUhkgaedMBwf5PbZtwlnDWSM4B6y14agSBzfe0ipZpDt2Znxsi?=
 =?us-ascii?Q?jvcoBRzFZaxoEcwwUoKsuAdLX9V7P1uJmBJINrW3wI48BnqKc8BQdyKyf/j7?=
 =?us-ascii?Q?FJB8pHBweV39ysYp4igkpq5WcgGs+qUrXOUIWpF72NXMcs6noDFuOvUbs411?=
 =?us-ascii?Q?QE8He55ApErsrsdty1rK6Y8nDe6JK1TQfxNGvLNgwa25h7WAysA444bKu4Zr?=
 =?us-ascii?Q?yESDK1TcpwSUMBfl4Pkqq929vrWyMaJWkw/FVmht2QJcHYIEYc7ux4VCAG9+?=
 =?us-ascii?Q?s8rfpHpzWhZ19hXym6pxbo200aQdItPPYSzQ/QNVGsjdoZxZHgCjRFjGb0KU?=
 =?us-ascii?Q?7aPW/5z+hF8VSFzMone1r3+wFOSqQYv8crdJ2I8PZrJvH1RzMHCuLk6VQLYZ?=
 =?us-ascii?Q?bOIEJE8Rff3Iv2PACi3o2N3NTpPicX8lglBBmXad41Z8gz5rh3GUlrWJe/9N?=
 =?us-ascii?Q?tsZqjwsYUo4S5LIaXRkGzi4OLukNAKjxmpE1EZp1aEvpjLaZaCVKd24EG9mV?=
 =?us-ascii?Q?BZmMT5WpPuCc/TIp2n9Zzlnkm8yT/CdJHn+vu+L5V1RfGdSzNbguYX2YkEDM?=
 =?us-ascii?Q?FoFliZmpFkEBf5ijuy3mD/i7llDoEhFYGPK/9IG7haPQMQwKlc3ny6XPkUTL?=
 =?us-ascii?Q?Khg76evHySbmJ2PaYD3yqpl5IQ/c2Mjk7rwot1yzi477JQLxpDxGKvvHvfCh?=
 =?us-ascii?Q?Pok1u+ESrfmqTPJqnie4YRr3nP7jOpSWitoKR326JDtAfx5q0XpDHAOqKGSb?=
 =?us-ascii?Q?6gXuHm21fLTNVxmMEIUUcmXlIWw3K9ibpA7W0kl4VhL7jFn3I01SydWfvXow?=
 =?us-ascii?Q?4Mqq+Zy2RFN8sdxTkaMfFPhCb6Wz7vBxpC20aSplAP5e6S4ky7Zj8IxRmOoY?=
 =?us-ascii?Q?LxAYkVItWQx/EyVp5SEdsjYB9RqJNVGVCpquxn38h/nNvdlvTj6nOwtWlDRN?=
 =?us-ascii?Q?+roKwIxiE1C/Y8tU7KRrPYytpbjvbbENpAHn2q1LSYcoQ9xmaNGdZUktcWDu?=
 =?us-ascii?Q?qRNrDgOkh65aHkn+FQ+U5CKN473wxUS08En/GM6gCIjwyooAHDQGXTrbT8pE?=
 =?us-ascii?Q?e6CUV8xg7g2DkEq2R9oauYYPxcENUV8UftuB6/+vBUjg9UhukW+bItA64vMn?=
 =?us-ascii?Q?hrEL/IffxV9o11663B9nXAnv87R8Omz1pbu9+v1cMHc6l+cqnWh5rjB0eMn3?=
 =?us-ascii?Q?FLF1+Pe73b7z9o4lt8X3e1QQ5bNCQclLg/j0T+Kr2YCZ9AQoVEkqh8KXLIt/?=
 =?us-ascii?Q?S8uuUmE7MmrWIPscwuf1zOZUDwJ+VjEEjY9vjXWG4W58CGuXcCqcIJflrzaE?=
 =?us-ascii?Q?aKWBm8NWryV6zlXJJXLRkfy8Vbq/Ytb4OZMzdpjb+1IjDGBHL0iKhtyljF0D?=
 =?us-ascii?Q?4er83GafXdOIFxjdEWRb/yxHnRgOe01qRir5keuDq9fwgZsUt+fB4Z3St6rF?=
 =?us-ascii?Q?GeS8iioIqSun/E4igZVCq3u2dzTzBZibH6R9Zu5396ii0iLS0Prou/8de6ol?=
 =?us-ascii?Q?KITy+qQlSexySA2SLi67eCZgORYxik3ZZ9C9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2qHfNgZ+q0v5fw1f0T7iEHx3F+3RMRUoZ5n1cZSnBOU8l4eIgo8cagIy8yu?=
 =?us-ascii?Q?3PAGQ7CLbmCJWnog35/ygqjsxZY8kqF19du+vdAZ8baLWvm/m/krH+dWl9J0?=
 =?us-ascii?Q?SDQh+gX99PnrvKggMNu0Zaq3uOzk5kzlzytiCqsl1XSjybEhBq8c2psifRjr?=
 =?us-ascii?Q?ftPlGNd3PTJc+3LMLiDKh0T6BoaGYAoWBupiaz3yrKFAuxq5yhXO5h3Fh+kw?=
 =?us-ascii?Q?kcBdwIwIqcO1f5loFtXUw7hTqxet7DEJK4F3GR5Ir5CovN+8SbFw7A+zL0ca?=
 =?us-ascii?Q?b+ggs8hZ51FaF158arlFCknAMZzGHVurT0M+y6nuqacnADvJoIc/hMWl1/VF?=
 =?us-ascii?Q?QZsKL5Bl6m1lWJcrwGyzQXQSex79aQvmo3tourAq7D0/tZYlV69yNpn+I8AT?=
 =?us-ascii?Q?7CvqmVOv1UxNv3Z2dlexXBgdIX+IQOO++thU5C0M7HDn0tqxIGi4235WLs/E?=
 =?us-ascii?Q?0yEOej5G5/6i2TxX0j3TA8NkVSXoJCs7h57o4dEuV8D4qctG6acRfX+va+oE?=
 =?us-ascii?Q?/WwrrEzajagE8VI1z5BYpTcRma+8g3gTJeUVxXAg6q5xizI91rGYwTRiZs+D?=
 =?us-ascii?Q?iydceKfj4UAyXBpATx4ds7zfG0K5F3RSv0kjOCk38MVp6BQ3J6jyPq1Gu6dE?=
 =?us-ascii?Q?Qy9MVOobOh72MIC+1/0NWSvOgkrdjuVJIb34Wcz9MZd+v0zPSP4eZFQKWReD?=
 =?us-ascii?Q?L/lLxLC0JeOgtv0gVZ1tZZJmNaZbj5yYmt3PtPWh0TuxyWQnt+H2p1s56zQK?=
 =?us-ascii?Q?03iTfulrTYUFe2rn5Iu1fgbUyAM6OAoN/HlUjuiD9T3BrPX50TlB3YTYevE3?=
 =?us-ascii?Q?JSoMOiezWUapIP6x2EIcDZ4hRBNG88UvMdLkVt6tmxGyADneAmWk0F88nCR5?=
 =?us-ascii?Q?b4Rv1dRq0JLh49z5grrTvZ4IrEJH9sTYv91r1fsrDDYjMuQf79VSC7akkxYQ?=
 =?us-ascii?Q?krv8cPX6Zpn9jRQJH952/NzdGpu2a/vkubIhF27Nitrhv4mOcdLGjEYAYzJM?=
 =?us-ascii?Q?+avUdxbUbdhu7sWX+Ru2ZlQYEsVHWT8O1M7BYdEOJ2CBD7ilZ9JhjoKuoJvj?=
 =?us-ascii?Q?WfHiCtq63wJHeHDZ7n7frMEaPZ1qljZldR++3563XYcjXgqjS1FMzvpb5zU6?=
 =?us-ascii?Q?cq58zBo9rJEWmRAPfbPiLUqDK40hk8YL+qGm46garDZIrKzqK7VP+x+CI2Y/?=
 =?us-ascii?Q?dCtltvJ+lCJI3TZZt08KzJ5jSBr1M2Tu81ydxamiSLmhGmJMh76rlFQHjO6T?=
 =?us-ascii?Q?Bajq3wP2pa8iO46jCX9EHQEawLReThPOErvUWvaiuQFxMFjHlwFOTeeEVIUN?=
 =?us-ascii?Q?+fVZjFTHc0SiXKgoINU5SfUShEYVOP6dOyUYUQ/2oo378Pseli5wt4R40SmI?=
 =?us-ascii?Q?OcrEOvXj8MtSHhistRse3W7B7Z9GZww2u5Rwitq9C2PeB/kRy8MIJdN0SLph?=
 =?us-ascii?Q?ypBoas4XNZX9TJFOYSiDj0fR/xP0jZpD32BvRltHPGpSrCnVYlwY+lky41tv?=
 =?us-ascii?Q?6coihSypfMrXZHGm9yIayDrnZdg0kgR2nxP+ub2RgVaFE6MuvdT1+R1kO5U7?=
 =?us-ascii?Q?MXiQuDF9OGgJVc2nYnc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2999f1ad-9d09-4fb4-730e-08de25f379f7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:07:58.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJTGUGJwIFb3Oa4E9SRUvUcrEoAVrtIZC4/Rc3UmDFJU9CqdP4YcsmHRaHF5bHpGIpJXZN4UbojEiawLHAdvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846

On Mon, Nov 17, 2025 at 06:19:18PM +0800, Wei Fang wrote:
> From the Kconfig file, we can see CONFIG_FEC depends on the following
> platform-related options.
>
> ColdFire: M523x, M527x, M5272, M528x, M520x and M532x
> S32: ARCH_S32 (ARM64)
> i.MX: SOC_IMX28 and ARCH_MXC (ARM and ARM64)
>
> Based on the code of fec driver, only some macro definitions on the
> M5272 platform are different from those on other platforms. Therefore,
> we can simplify the following complex preprocessor directives to
> "if !defined(CONFIG_M5272)".
>
> "#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || \
>      defined(CONFIG_M528x) || defined(CONFIG_M520x) || \
>      defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
>      defined(CONFIG_ARM64)"
>
> In addition, remove the "#ifdef" guard for fec_enet_register_offset_6ul,
> so that we can safely remove the preprocessor directive from
> fec_enet_get_regs().
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec.h      |  4 +-
>  drivers/net/ethernet/freescale/fec_main.c | 57 +++++++++--------------
>  2 files changed, 23 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 41e0d85d15da..8e438f6e7ec4 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -24,9 +24,7 @@
>  #include <linux/timecounter.h>
>  #include <net/xdp.h>
>
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
> +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
>  /*
>   *	Just figures, Motorola would have to change the offsets for
>   *	registers in the same peripheral device on different models
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index e0e84f2979c8..9cf579a8ac0f 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>   * size bits. Other FEC hardware does not, so we need to take that into
>   * account when setting it.
>   */
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -    defined(CONFIG_ARM64)
> +#ifndef CONFIG_M5272
>  #define	OPT_ARCH_HAS_MAX_FL	1
>  #else
>  #define	OPT_ARCH_HAS_MAX_FL	0
> @@ -2704,9 +2702,7 @@ static int fec_enet_get_regs_len(struct net_device *ndev)
>  }
>
>  /* List of registers that can be safety be read to dump them with ethtool */
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
> +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
>  static __u32 fec_enet_register_version = 2;
>  static u32 fec_enet_register_offset[] = {
>  	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
> @@ -2737,6 +2733,21 @@ static u32 fec_enet_register_offset[] = {
>  	IEEE_R_DROP, IEEE_R_FRAME_OK, IEEE_R_CRC, IEEE_R_ALIGN, IEEE_R_MACERR,
>  	IEEE_R_FDXFC, IEEE_R_OCTETS_OK
>  };
> +#else
> +static __u32 fec_enet_register_version = 1;
> +static u32 fec_enet_register_offset[] = {
> +	FEC_ECNTRL, FEC_IEVENT, FEC_IMASK, FEC_IVEC, FEC_R_DES_ACTIVE_0,
> +	FEC_R_DES_ACTIVE_1, FEC_R_DES_ACTIVE_2, FEC_X_DES_ACTIVE_0,
> +	FEC_X_DES_ACTIVE_1, FEC_X_DES_ACTIVE_2, FEC_MII_DATA, FEC_MII_SPEED,
> +	FEC_R_BOUND, FEC_R_FSTART, FEC_X_WMRK, FEC_X_FSTART, FEC_R_CNTRL,
> +	FEC_MAX_FRM_LEN, FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH,
> +	FEC_GRP_HASH_TABLE_HIGH, FEC_GRP_HASH_TABLE_LOW, FEC_R_DES_START_0,
> +	FEC_R_DES_START_1, FEC_R_DES_START_2, FEC_X_DES_START_0,
> +	FEC_X_DES_START_1, FEC_X_DES_START_2, FEC_R_BUFF_SIZE_0,
> +	FEC_R_BUFF_SIZE_1, FEC_R_BUFF_SIZE_2
> +};
> +#endif
> +
>  /* for i.MX6ul */
>  static u32 fec_enet_register_offset_6ul[] = {
>  	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
> @@ -2762,48 +2773,24 @@ static u32 fec_enet_register_offset_6ul[] = {
>  	IEEE_R_DROP, IEEE_R_FRAME_OK, IEEE_R_CRC, IEEE_R_ALIGN, IEEE_R_MACERR,
>  	IEEE_R_FDXFC, IEEE_R_OCTETS_OK
>  };
> -#else
> -static __u32 fec_enet_register_version = 1;
> -static u32 fec_enet_register_offset[] = {
> -	FEC_ECNTRL, FEC_IEVENT, FEC_IMASK, FEC_IVEC, FEC_R_DES_ACTIVE_0,
> -	FEC_R_DES_ACTIVE_1, FEC_R_DES_ACTIVE_2, FEC_X_DES_ACTIVE_0,
> -	FEC_X_DES_ACTIVE_1, FEC_X_DES_ACTIVE_2, FEC_MII_DATA, FEC_MII_SPEED,
> -	FEC_R_BOUND, FEC_R_FSTART, FEC_X_WMRK, FEC_X_FSTART, FEC_R_CNTRL,
> -	FEC_MAX_FRM_LEN, FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH,
> -	FEC_GRP_HASH_TABLE_HIGH, FEC_GRP_HASH_TABLE_LOW, FEC_R_DES_START_0,
> -	FEC_R_DES_START_1, FEC_R_DES_START_2, FEC_X_DES_START_0,
> -	FEC_X_DES_START_1, FEC_X_DES_START_2, FEC_R_BUFF_SIZE_0,
> -	FEC_R_BUFF_SIZE_1, FEC_R_BUFF_SIZE_2
> -};
> -#endif
>
>  static void fec_enet_get_regs(struct net_device *ndev,
>  			      struct ethtool_regs *regs, void *regbuf)
>  {
> +	u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  	u32 __iomem *theregs = (u32 __iomem *)fep->hwp;
> +	u32 *reg_list = fec_enet_register_offset;
>  	struct device *dev = &fep->pdev->dev;
>  	u32 *buf = (u32 *)regbuf;
>  	u32 i, off;
>  	int ret;
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
> -	u32 *reg_list;
> -	u32 reg_cnt;
> -
> -	if (!of_machine_is_compatible("fsl,imx6ul")) {
> -		reg_list = fec_enet_register_offset;
> -		reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
> -	} else {
> +
> +	if (of_machine_is_compatible("fsl,imx6ul")) {
>  		reg_list = fec_enet_register_offset_6ul;
>  		reg_cnt = ARRAY_SIZE(fec_enet_register_offset_6ul);
>  	}
> -#else
> -	/* coldfire */
> -	static u32 *reg_list = fec_enet_register_offset;
> -	static const u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
> -#endif
> +
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
>  		return;
> --
> 2.34.1
>

