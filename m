Return-Path: <netdev+bounces-228506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C022BCCFE1
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A0E425AE8
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466E2F0C6F;
	Fri, 10 Oct 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="behOat92"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F22EF652;
	Fri, 10 Oct 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100535; cv=fail; b=PXjjcPBjCik/IDYJDqdt+wwR/zwS+BTeOdjtlWeIScPUD+sIo+3v7ssq+zE31nZxMqEn2gxuv/bKyki6Xfc6GKDsu7fQBT/u6RJVOHdYe29H4EN2J9ttdpk59dsyde8xy11D4DxrnEiH+aptoDY4wgfl2GF1QWf7og/u0yFNJh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100535; c=relaxed/simple;
	bh=Z5jJEF4NyIsXC8cKBK1m/nJ4RM/6Yf09W5MsgTd2kLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LJUtK7CKXhb/OCw9fhTgomoH2pa8kDLMadzMi+dwdW7cnlcOF7EkXGy24lycUxLBTrfHF4zJyvMOscMybGWila8aYAP6mllgikHq8runtfce39/vSCVr9kpkbvN01s8ghvEjtK9mdJVlJ0WbxYGdtUO15q891wbCrNqkf87p3e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=behOat92; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwMaIFx4XJpteLfliClRxUdloXFpRL8NvZYSmzQgtgdIf6Ip/x8SnI/Z12ewqNYewWKFXdfXNHiUpjlSluLvBC4Mfcuv7om+vmU6GAvalQIUmlDo2Yo9Kbiap5Xwe44WXi6wZrO7WEJXxIBpy2m7ecI+Yy5X7KM8S6+bWsh9HEQ25bGm/ZrJAH2WHDfLqy2DvU4eAV9zqVAjFYXigDSOZaNI1WoTh0bKab9R+SgAPf9amW1LCQCCpBccv19ZrQB8nD5xCtrYFJpa4WpGupxBUQ3vp2Kez4Y96K0cYjB3OZug1FnAIiacP42U/FJCXqJE5DEmIQxnM1Ogqu2hgpgYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f4BEGZW0+5/RYt4U5KEFf0UIwJgSCIV9EUt5H3Tom0=;
 b=TvYEKWrjMr0nPVXSDwMGkSs/s7LbDxPyT8SRCP23bEVVhW2TmAs8qT+JnOIqSmXRI2AdHxv/8Va/upUN8FL8cFq2BIvh989S81fNiT52VHJIBSdlYUfw90S6SZcFZxZEMQ6tt1mlCXHfl299TAPwfIYzkSwBwRvYaeFNJ6UZcPgarHJsCFjsM8L6CNsNbKctNyDnv7JniMk+pA8LYVzqCLpJ5/5hAvPw9m2rzUiA1Im2K+FBzxyRpvqIi9nqBe0b8TbNbsJ8vafaACg8SYIJC3Rqffw4lzJD5rDPSQe3HJ0RING/jVX4FbrYC8x1jClTEtoZNPlCAOt77y5Z93hR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f4BEGZW0+5/RYt4U5KEFf0UIwJgSCIV9EUt5H3Tom0=;
 b=behOat92ZZTaGyo8Chl1tfzPvrUVjqkVVJvLZ13fhSrBtu4ZTnJQ2FgLw+C9be6A41SuWHGpVCdOOKxGqpOmHGwkkJ12iBh6gNwVpnQ/E+nN/d9VcHfpErWmcXVLR3F7YMSc0RwwGHWdzIHq/gNXvESk/z1v+ZAWduL86Q2uR3UdSNFgUCyXmrYepnW3RV6dzMIhHKUFPWzTueYiwYhWenUhV3l2reVrzbkrXOZrcOMY7P9vIOSYiVFfugyEZHOPBS5QInU+IQLHIsca37e0fYdyPXyIKKH+fGaCuCkLGsvawoD7f4VPH8+MRnEL6DDJdezxZ4LUj9MIVV3HLnXQcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10132.eurprd04.prod.outlook.com (2603:10a6:102:407::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:48:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:48:49 +0000
Date: Fri, 10 Oct 2025 15:48:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com
Cc: xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Frank.Li@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Message-ID: <20251010124846.uzza7evcea3zs67a@skbuf>
References: <20251010092608.2520561-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010092608.2520561-1-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10132:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f0d591-1f95-4444-6999-08de07fb5bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hLaI+seJzXokIj1deNwMiufL3zEX3RRk92CZCQGVIvwb+9Vhat6JjBzpX1O?=
 =?us-ascii?Q?WI7UAdaRwksLOHc9HOZtFVrYcAKVc9k2Ul4va94bPE8c890auOs08261t2Z5?=
 =?us-ascii?Q?dznVL33Enbo5/E139AUqt0gCmhDfM0r9R+vTWdo/k/8LVGOn58TXGnca3v8W?=
 =?us-ascii?Q?h867CIb3uPcPY152p3o0elWUx0xtWpccmZezCXkgo0Sj+OycDxkNPPI4ej5f?=
 =?us-ascii?Q?ntEosRcrjALtrjlXNVKdaWZPKklyZUGufh4889VKwmppFCvsy6nHc+iwby3p?=
 =?us-ascii?Q?Jbt6/bx/QfOrpZNC0OWoSqI8pc9EHzUSaipGSsVXnqKYkIjorySUM+LbemsG?=
 =?us-ascii?Q?ITysZ+iciqJZsRuwodv2Eb+jvpVvXT6tgcSt9MTZlQFqF++vZFYmz0+4e2oC?=
 =?us-ascii?Q?jfjtfQzQtUBDGqW24ddpFmXrP2RMD76I+0HGYd6YOvwwXtZHcd+DsAmScA1E?=
 =?us-ascii?Q?VfjSzbHOT+D/UFvTk3Ub261Ie8tzEzfRL2amH3p8I6HkpJlOeUKl4u8aDRWz?=
 =?us-ascii?Q?J3kZxpCkU+AOwMmpWNJAPGlVtHvjBHZONa30KDWLRi3fz6YIyj3gXPQyro9c?=
 =?us-ascii?Q?guWrzxFmRITUAME3XMHCR7XduIyKZWp8xjq1sO/GRxHimGSGUwz5w/LMGax3?=
 =?us-ascii?Q?NIBvQ4XMjZYvxMXhHiE1r1l7+R09CC/3jkKZ8gm6P9mRGXH6jVURBU/xbGsM?=
 =?us-ascii?Q?gLRNRPrBQjOFmHzgJPrunrPNSyd8mypXUxv1/tYKh3oJ4kyAmr5sJX1+jVS5?=
 =?us-ascii?Q?WWzWoYQMDdeo8XNBIMzf529DEU2JHnuKV9fkDK+dEl5dhzLeWxGlJTzwx51q?=
 =?us-ascii?Q?dNOS9hUNgelX1DLXtjTHgN9+ZR62ldcqxUaVp4HCPHo5OYsi61ZcapKRWecM?=
 =?us-ascii?Q?/l7rAPtguuEsiaVvIDx5jCE9mJmuugFndSRvRf/Rbb0uWgbMoBJRbUI9uZGL?=
 =?us-ascii?Q?k2pbUFRiIIJNpSFrnKahB95EPmAFoWF43h+7gdSnfPAnGfFm+cgHYdA+mCTt?=
 =?us-ascii?Q?8x8paJWa/DGUi0ElMHS7ZGGb8zsgpyRuC+5As+GJmSP0yQXt/vB5IEwnQ4Ns?=
 =?us-ascii?Q?od8ERM4Ni5AhdHK46y8ypWaRbIzYefr4Cx3YvpKwhZjaVCMOTy/mH8Kq21uJ?=
 =?us-ascii?Q?kKswNOdHpX+bdLXeH9qkBcHGgDwMSeXMI0Afu31jcxsMhVmt2U9Oz6rXPecf?=
 =?us-ascii?Q?09RRTJI2P31OxYBWi5LlCi6lC+lgxu+a7JKEmCNxcK459ItuLRq/aPtVJksC?=
 =?us-ascii?Q?HuF62My5WUkT6cUrm9Awvny2puHtVZdM/fe3NGjk1dyQMhEC3f97su/sg1Yq?=
 =?us-ascii?Q?1t7578TSVlkNtH0pDFo96VLh63xU19WKkUd7ITomoHvduGNnpW/MjlNgS6Pn?=
 =?us-ascii?Q?ukl3JN5Wdwa3ff06f8RHp0w2ARs6kSoGTezzXou0h9fNySCP7PMPFJOQyvZ5?=
 =?us-ascii?Q?G8Iv4ZkxrvmEKbWJXDB6w9wBkgsNuYlu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xLUBhpWsfjXyxUDz+/hJorYHtaeTCu8BtYVMxMhIPg1SBLQ0Z5WENJVZ620V?=
 =?us-ascii?Q?XVJ1lBCxmlTlTpJIkn2/zM0eAtOQbrqLgQnJBOgCQCXJCShRTssoOWAT5fu4?=
 =?us-ascii?Q?kifQ994XhPlCUKeGDG10oiB0ike2KREL2cbnbQWrabCwVdDFTgyLj5XsZOQr?=
 =?us-ascii?Q?iTRSmPlwaUDF/1TYeGPMoMSVmGUjfI+5rcOkt9ajg61xM4goHxk0guFnPmTO?=
 =?us-ascii?Q?MPTxtX+L6qpeYf8FvEdbxpgf6ANmypHfDHXZHn1Yfu7d8Rj08iPCE44JWdgD?=
 =?us-ascii?Q?O4b4njzQPpZUsUpmSaereGk2i42asAd94zSZxvMRJFRZSKs5sxItd2KQ1FwX?=
 =?us-ascii?Q?eXDu6t8sIvGB+O3odjiySTc4JMwZ/Dwdp7/aj8PhPX2Qf8rZFzM8I3iUPHp8?=
 =?us-ascii?Q?8xyD/oe9KneZeadp+XB682/8sHllX2zW0oZqcNru+7Sljuxd5VaMZ4JnPgOV?=
 =?us-ascii?Q?CV2feYyy6k+EssSNCUqWE4opo/ST502JhGePVKR+AVKbCuO1X90RALoN5ykr?=
 =?us-ascii?Q?8PG1uXKwS7j0ZOd76K8EqdC6ahY+W56IWQRErlbEQ68HZaqij9x3DqAyHivc?=
 =?us-ascii?Q?5faiBe5o8sB4jsQJIjzyUoXvrH7R+Y0iAW7uKMKhUX5N0qosbiT3PrCd3soH?=
 =?us-ascii?Q?+Iqr+C0t9uQfze7vbTtQaNPiIQEfrYKsSeJYUWNvKtV5XGmXAGAgBDQ2s0eh?=
 =?us-ascii?Q?4U2MXogkc1mH81es04WzSp1cAcs0s27VnmvwxHpk2Ai8YPk36+DQsamHgkcM?=
 =?us-ascii?Q?POJJgWwglMKtHgN3L8nD2oZwKKMHv5PuHDFO2VMm4doFhKh1WcrDJjSo76Bj?=
 =?us-ascii?Q?6TsqNbefTOnG1oiz4kJgEybWOJ5bDVM3mVqytP94ENrWRgQeh43Vtl5V5z2x?=
 =?us-ascii?Q?lSblOkMYq8lfDABrXfFJ6GR1OXHUQPh++YPOLVOq0PmKuDllY3Jwwn9pP6XG?=
 =?us-ascii?Q?Ewtb+U7/JM+oxAGqAr2HMfticZv//SaazNEuhhgYhMczSHdPI+VMf+7+litw?=
 =?us-ascii?Q?75I7eziqEtfJqGDJlErsxJHDPcA/rIkj9px9G5qhQQgVEO2b65auSwaBGHpO?=
 =?us-ascii?Q?a3RgibeHBHtJuhmx5EWovQVbZ+ZjCj+RFCN9EPga1+88kaEA7QAJ2D4udBzc?=
 =?us-ascii?Q?wfhQvPpiRZgmrqW9WaY8xYjfPpsKAdhrepFLlAx5n6IBFQRFBVblKOXaZzxG?=
 =?us-ascii?Q?l4S1NpylI3YAJ39H3Mg507+D8J1GhzpiSU96b+eTKVdGu9dMvpcQOgYLR+AF?=
 =?us-ascii?Q?QZuPrmXiwLIySFbKyMIsTuFTZFl5xrxt9R0KG2IzeM/P+00frNuoYa1AsNkL?=
 =?us-ascii?Q?IFFVhgYCUDNG2ficjdKpP8LsebFbxGbZhDy11wYBqKV/KVq3fGcNplgZaQb7?=
 =?us-ascii?Q?dKcaYzEWdYk0ZIpnqM9BPI8bJ7TOKnxpZM9GjVXx2x0T2LuDO/hmIpjNzEIM?=
 =?us-ascii?Q?nwNSZVoJlNz4TTXopv7jSTEyztNj8xDIFlOGdgAKMj+s+dD9Hy/Xzb28F/p5?=
 =?us-ascii?Q?tjwog1rkoFjPCc3Ivi35vkmGTxZUUFC2jrGzFMOSnH3Dix7GgHNQ1Wy8x+eU?=
 =?us-ascii?Q?zUsTNW7Y9k1xwW+rzQxKrIGl6hbCvqIDu8AKeAc5pu7YXh0lTWiNWun4qjA3?=
 =?us-ascii?Q?tRhlr9ISftXp9eUMCktV5haOR+H4JgAwls8bd2KoC+nn+Y5EJx2JZ/x1kD5L?=
 =?us-ascii?Q?GiF50w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f0d591-1f95-4444-6999-08de07fb5bf8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:48:49.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1T14kCYn4V4tmU40kWtNZkyGBZqHb3kxzIv2J4xEPBGNKYuFpAaTYaPgiq7FSy8cdMIXLDIRGBGB3tQOFQU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10132

On Fri, Oct 10, 2025 at 05:26:08PM +0800, Wei Fang wrote:
> ENETC_RXB_TRUESIZE indicates the size of half a page, but the page size
> is adjustable, for ARM64 platform, the PAGE_SIZE can be 4K, 16K and 64K,
> so a fixed value '2048' is not correct when the PAGE_SIZE is 16K or 64K.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 0ec010a7d640..f279fa597991 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -76,7 +76,7 @@ struct enetc_lso_t {
>  #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
>  
>  #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
> -#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
> +#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
>  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
>  #define ENETC_RXB_DMA_SIZE	\
>  	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
> -- 
> 2.34.1
>

I wonder why 2048 was preferred, even though PAGE_SIZE >> 1 was in a comment.
Claudiu, do you remember?

