Return-Path: <netdev+bounces-243086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EBAC99627
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49796344DBB
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23545286410;
	Mon,  1 Dec 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXmfM/u9"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6722279DC3;
	Mon,  1 Dec 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628190; cv=fail; b=ou2E2TO/AKvGr+jL6T4BgoXGRHKWvQaboySV9AJ3NzGcj75lxcibDyj0RXW/uenFG7NlSj2+c2A5yXqEHfiJXit6bBXjZ3k9wLI/brFZc1rTbIKoiklP9FzBu3jF/VJL4MIYeEp+TDuCs7IpHPMBai7SVciNJO01TA2u4Laszf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628190; c=relaxed/simple;
	bh=0D2REc74iRIobyBbPRnwjjDgMs9jmaErJNbOGpD3qw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gfkIZb6VegEQhaavST1S7E2b5v2hCW+W2G9gIz/yk+1FgnxhFtZqV1mxZzknWjYQRxCepiYU/PkGx7tYpln3C4xwj6OUu+cN9gv68jrutZgp0jIzQelYGkK8dcYn5Jb5+2yxniGOJQ5Z8vldI6TALftJYysztOB/kCwzdSupCx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TXmfM/u9; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNdxbF/PilNKvfcvEvl/FxL/rvz3ZoLloQn9NihyxWYmNcSs6y+cMzv7HmGIndthEpiEFGwdsC37gc+Ak7Mmrt1KBVtp0EdQ7klIBRCDyTus0Xppf4vBfxXfEtlBVNKezJYHe6AxI9mqY2M9ejXUN+bOeVD2rlUzTvCudUJUTbxecVuQup+NCn3OZsCr7TFupNrJ9h//B81v96e7IF6tsz/ui3z6qWjO+jVseorLeSUj+FvHR2+hJ5KkeBI7UvIeTUCRTvL7Wb5lG7AphhQuTLuuqfwq+i48VD4icWgkml0mmJA0N4ILXkz0Gdce62Ppjxv3oa9e2PxCoXPAIS5Mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XJYzN2x0rU7QajPcBBrzo4SQmsK7EVVgZvKhu0niss=;
 b=lI1yiO66Sb4jxS6kQagqmu5Uf+jzmoJmF52Mn6dZBbbmqtGJmjtmuK3oE2gBEfyAFrd6zRczZ3k4/bMJB8Dzgl4FYVF+YqLQ0gyWJBVmeXhcU+lNc2BPvIb0F3u5I6vGFmPG+ITil9BjEieOpsLutUxiRqauhr7wE7AcYlDBseGEpRanxFlWz8UC5oJbDzkJIqiFDL267aWABG0sI/MYqx0H4wn9OCPcvJbCpYzjE1E7ukSNDTO4gdTcxfr7gftJKJ/9voxmz189+F5+R60k29BJgNYOo3H8aCo9SYAoubaD30X6HwYoPNJcUfvMCVmTco/uv73u4lbP1KPCAVj65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XJYzN2x0rU7QajPcBBrzo4SQmsK7EVVgZvKhu0niss=;
 b=TXmfM/u9d4mjLArSu2m1qp3fz0A05Z/QF/x3CuUWtH586bTEaUPoSt+vqWdfbnooQRxbDUfsNWBYRX+88HRFyUnB75wlJi/4NUghsy4aaGQVOQi0p75Xg+td4tWsqxG6tDl/X9yVQnKGh6NmPwpV2NgCGIWb+6K6XCNX0wMfv5K9qeVNx+Bk7OXVmK/G89QAG9+vIH/UaDImbUohYv1ZsItrNdMRpavrnKW/F2EW6H5pt5LHCW6Fper+0SJp7w9jiSDoeyidsM2zvP/ha9hFhqq4o4APeKigCKwmzi+vHR48WzKlUfKqtDgH374MpVCmSF96/F0/3LsW5fVPLmymFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by MRWPR04MB11520.eurprd04.prod.outlook.com (2603:10a6:501:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:29:44 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:29:44 +0000
Date: Mon, 1 Dec 2025 17:29:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: Re: [PATCH 1/4] net: stmmac: s32: use the syscon interface
 PHY_INTF_SEL_RGMII
Message-ID: <aS4W0M+ZkQzuUjtT@lizhi-Precision-Tower-5810>
References: <cover.1764592300.git.dan.carpenter@linaro.org>
 <6275e666a7ef78bd4c758d3f7f6fb6f30407393e.1764592300.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6275e666a7ef78bd4c758d3f7f6fb6f30407393e.1764592300.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: PH7P220CA0096.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|MRWPR04MB11520:EE_
X-MS-Office365-Filtering-Correlation-Id: 867a5458-b331-42c5-5ba9-08de3129205f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llv9pMi2yGXROP05bLp4HTkaeMywqWKviNc9h0nZ5CW7iHmFCE5yNKD7Kty1?=
 =?us-ascii?Q?pr9UIibE94LiSlyHbrzT3EIl+sy2d1PExE7GqfB2rV6R1I14rdtr7k4XLmxq?=
 =?us-ascii?Q?8z3vMtZ7AeCHqkPib/iQauEDBeip98kSND7zpD0xIVI0o9efvWuDD9LNd822?=
 =?us-ascii?Q?VNnTdK7S1AtDGcVsTOBd455x3dKaQxNbMgkD+EPOP832WWtUILdr9wLiWe9J?=
 =?us-ascii?Q?I9eEFImjRaRluCXagZmUVdbC3HyxCUKqOT8e7WNEqbAnvVo8ggpy4FYrbbKI?=
 =?us-ascii?Q?ivPd/uD7tHtZaYORpZZs/9pV6e8qMNikamg4yiMs0v2zAXReK8g7jBfDyiHW?=
 =?us-ascii?Q?4WRgTgW/e3hKAuW4Hikt+LH3a2R2qLTzBagWsVGk7CbkVQlRRWNzGM/WIBHA?=
 =?us-ascii?Q?ffyqZ+X+JuRCevIWbUlCeHrETX+/l3Vs5sqSSEICo4Pwa+B6iAbqRbfoPkpC?=
 =?us-ascii?Q?CPaZ3M419QdLcT2cI/RGd6caqpMAJWKTIt364osDvajW6ff8bLv8I9PY0LXv?=
 =?us-ascii?Q?RLYkYAKUyrT/J2K4zJB6R6Ypo6v3M+TJKstBBWPvc7dUrROFLWdqMhXkyW3I?=
 =?us-ascii?Q?NOltboGAgA9xGuRAZ6bSOjaddV0ZcvJvLaGmx9wW38voheh9GfB0PCduEYYx?=
 =?us-ascii?Q?kmkLUt+WeekqGw48g966Ha8Y4fK6tPZ1uWr6G+ER4CPNzMiV5Q6Bt1gmCefh?=
 =?us-ascii?Q?HdaTIAWAZ7BJC5f4dVNCEFvPvAPghVVlLnpZZAFrdtDMYkZo012WINaaJDhf?=
 =?us-ascii?Q?UQUIRJQs/Xkdafr85Xoet4pW/qZuP/3POwRzAEjJDR0v6lZIOb+B0LwMkZjJ?=
 =?us-ascii?Q?8kgkQjJQcENb8k3uG+doIYlBNWsoi81fVqbq8qBgjqc2KRnzSBrGC6eZQUpm?=
 =?us-ascii?Q?uKjZ8jmxS2Jv/bXquCy54oIf0YYRjWg4k1hj/JZBCuypPUAaC3B9UQKcvHtg?=
 =?us-ascii?Q?W+lpqh0OrdcFqzOzdzbh7sDyDY906IuCYeSP8Lg3kts4CwfODxFo7kHpGttx?=
 =?us-ascii?Q?tlJSMXoUG5DFZ8qLrYFZc5cG5VrtZXSVvDvuX6ex2oI0sWznu+Y+auYhlHOw?=
 =?us-ascii?Q?+AR5JKuQcbXBdkRnjWP2MJV9MQ0IFEOKGg1joq7pJuwnrP0cHVtc1nijfSrZ?=
 =?us-ascii?Q?U0qC67wuoWntWAMf80SEyMQdHV/mvsb3FZH4hXax4ma5XzdGLyumdpzoXjgZ?=
 =?us-ascii?Q?Y9BqDiUNPWo9dLCP7CatD36gAzlP9NDA/+QG/n+AjSUaIOtuargefWmcDb6y?=
 =?us-ascii?Q?LIEyO20K9xE5YL8nsliKbRaluSurkERsW3IyxyAtD3MTQJQ3aaHWluWEculD?=
 =?us-ascii?Q?PsSlANJANKKq1dcGwwEmBCzeUmF+LvqEkTBEetF9EYG+rIL5jPVaJiMmekvS?=
 =?us-ascii?Q?QaJqX5yPnGPTvzOLhESlWCx1sv1ZGvGk9c5w9vydBNocL94KtniJGdZog1I7?=
 =?us-ascii?Q?0vi7MBGE+FOomvYqQ1bbQPfqTXJsANsqLeYui33YXN2nILUqhS72zPMNBB+M?=
 =?us-ascii?Q?AvFB7tNxtqEqChm7oYTHOPR4BUR+YPEO2UY0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6q2G3hXwbJMji9q5Sfa8vQaygZfkhhjrXmkFkdz1FMw0t0jNYmbj5M55KXZ?=
 =?us-ascii?Q?nSUuAYs7NfXJGm2fHeVFi063hhkysujxGsVG3xIZCCWraagJLDPd0rlDQK0Z?=
 =?us-ascii?Q?QyQwONJ6cOACAmon1dMGB44xvMuYSzPXznpreOgP1fdMZEu09dnevAwux/Ul?=
 =?us-ascii?Q?fbbT0rSQznQSmKs/ta+tuSFZuJB7zAIma9Zoj6HPFwfGA4Ba+DP5TeQHvQnE?=
 =?us-ascii?Q?IIv4i85ykCgxE3eWlkGJHcZG6Tbk1SdSYXaO4tcFAlEdgbf+VVr3L9n76E0j?=
 =?us-ascii?Q?6/WfzkWyTvWrXZanZJKvPlv7sREcXh9OttcAJpnWSbGybx3CMkfuQI/ouaNR?=
 =?us-ascii?Q?EvVFN1zOMmax/UeQ0QfZGwdcu+Ouk0hFdh5dfCIfiENfkrrm3+kuUd856i2D?=
 =?us-ascii?Q?sh2Vv0F7/3NgV23u4g9LnpdqsLuQtYC0N3sIGkOOxpq7TMSL20AAdo0j10Ym?=
 =?us-ascii?Q?a0cmuKEHAogexbGVKQiODAZNXx0E98YQwLxY8E+cZU9oGpLtksFDI6XRe6bP?=
 =?us-ascii?Q?D1wAs2uupX1wPmJUi7+FQerFvyWMCIl2KM9ckw+jIM9SH7gi6kIuFmdHunl4?=
 =?us-ascii?Q?V8XcnKWKmYdwoy8T/bBQZhwYNLLYvaEk4WizXXxYkD/ro9i4Jw01BrA+A6Pi?=
 =?us-ascii?Q?Xz+9AqdIe7TOvN8PN/CSe04wUgU8lhg4ITPLyHZmc5lIkq7YsJANM8pxIDMF?=
 =?us-ascii?Q?G8ej3TTNEu+LZqg+nV7unaY3rAyZRFoj5h80qWmdq3uge+Cm/JVl/GnIcDxW?=
 =?us-ascii?Q?+MognxFg9CFLbzEft6/PFKhBVmdAQJmeh4CJbB5wtsF6o9weApTy7JBFsXjN?=
 =?us-ascii?Q?R6AsI0r0sa001wuwXK+qzcYxpjDRUJCEonS45IQBb5Fbo9Ycf5pjuQzxsNj4?=
 =?us-ascii?Q?X/wOM0UCsbZ2msrc64TvLrYPYUL7Ki3WyyIWxw0pQpuLutP/LaS2jDuk9zSd?=
 =?us-ascii?Q?jJIfREFx8im0qYTKnhtk634DsmECApo5cX4tfT9fQpHZJIHWdGWbOEcGJsXc?=
 =?us-ascii?Q?tfyM1a3DpNsrRqtNsaV0D/IqVflHwRt8yJETnFp1hn720ILVuYs8hq4sMb8X?=
 =?us-ascii?Q?IFpr+vFIhfupsDaN4/MueWTtDZzeifG9I/vpaxe/9Q1upVxNauC62WXFtkma?=
 =?us-ascii?Q?p/qSirqtYYfuq2B4XEzy6o0ePOkc7Hws/I+lGPXfvNgyCcsgAFqZr4LxbHZP?=
 =?us-ascii?Q?rmgnG2L8KuCDHsPwK3ipmz5EwsO06ckmNlo+3KoS1U9QtmlkyS++hIjtXzUV?=
 =?us-ascii?Q?1uJ0mXKxMiuEl6B8guGqD5YXlcc3plBGbM0Yd8FDpfPWWi+V3XxjPpOKeA5m?=
 =?us-ascii?Q?Qn7nIjMRZpT6Lq6kGTCgQF24J8aovqjqYS4wW5FGd4ntWMwpKaPT7NhXp3mm?=
 =?us-ascii?Q?T36chxqRoKzmaIyua+YOlDh/HZkuwAx49+g/tXG4a9YlO1DGqyAbz6Pb3+lO?=
 =?us-ascii?Q?j0mruvnucsyWZ8XDgjIbKPdkXz1IfYhmP9QnYlnzK07MS7a9Ke1Rcc5igArt?=
 =?us-ascii?Q?hy/9sMxphGBAS3fYdCBgYJF1aFGgAUM4GOhF/KIBsIUFTIrKLUTDPf5IXX3L?=
 =?us-ascii?Q?573WkxnRO5FG0cMU994=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867a5458-b331-42c5-5ba9-08de3129205f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:29:44.2202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcURw/LRmvxc7iWIEskRTj9CAxu9TtGK/z75p4EczJ0ZMD7xFy/MHgAyNwEdfw53NRhaarTPObRjpzfRDB7Ufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11520

On Mon, Dec 01, 2025 at 04:08:20PM +0300, Dan Carpenter wrote:
> On the s32 chipset the GMAC_0_CTRL_STS register is in GPR region.
> Originally, accessing this register was done in a sort of ad-hoc way,
> but we want to use the syscon interface to do it.

What's benefit by use syscon interface here? syscon have not much
well consided funcitonal abstraction.

Frank

>
> This is a little bit uglier because we to maintain backwards compatibility
> to the old device trees so we have to support both ways to access this
> register.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 5a485ee98fa7..20de761b7d28 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -11,12 +11,14 @@
>  #include <linux/device.h>
>  #include <linux/ethtool.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_address.h>
>  #include <linux/phy.h>
>  #include <linux/phylink.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/stmmac.h>
>
>  #include "stmmac_platform.h"
> @@ -32,6 +34,8 @@
>  struct s32_priv_data {
>  	void __iomem *ioaddr;
>  	void __iomem *ctrl_sts;
> +	struct regmap *sts_regmap;
> +	unsigned int sts_offset;
>  	struct device *dev;
>  	phy_interface_t *intf_mode;
>  	struct clk *tx_clk;
> @@ -40,7 +44,10 @@ struct s32_priv_data {
>
>  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
>  {
> -	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	if (gmac->ctrl_sts)
> +		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	else
> +		regmap_write(gmac->sts_regmap, gmac->sts_offset, PHY_INTF_SEL_RGMII);
>
>  	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
>
> @@ -125,10 +132,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
>  				     "dt configuration failed\n");
>
>  	/* PHY interface mode control reg */
> -	gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
> -	if (IS_ERR(gmac->ctrl_sts))
> -		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
> -				     "S32CC config region is missing\n");
> +	gmac->sts_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +					"phy-sel", 1, &gmac->sts_offset);
> +	if (gmac->sts_regmap == ERR_PTR(-EPROBE_DEFER))
> +		return PTR_ERR(gmac->sts_regmap);
> +	if (IS_ERR(gmac->sts_regmap)) {
> +		gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
> +		if (IS_ERR(gmac->ctrl_sts))
> +			return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
> +					     "S32CC config region is missing\n");
> +	}
>
>  	/* tx clock */
>  	gmac->tx_clk = devm_clk_get(&pdev->dev, "tx");
> --
> 2.51.0
>

