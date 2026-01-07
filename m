Return-Path: <netdev+bounces-247783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF1CFE69D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7004C30090D3
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A203354ADF;
	Wed,  7 Jan 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XBnBl2LE"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F086352949;
	Wed,  7 Jan 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796423; cv=fail; b=jUtuOoQ9/pd5jGQSiMyToywr6dHNxVJ9e50vhu3/1E9f5knkLdTnS8G9+K6QLayR8hK0rZKLFY6nPVnr3HoCN4eDwCo2qaEgvUyToPYLYFQbAtzxauxy3vqRnOAiPG4drDEdjA3yIvkLSQyW+9mlaNYjXzX7F0coOIu/iR6thJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796423; c=relaxed/simple;
	bh=wQaC0SBeS9YnIOly2AJWxl9gfuwQhnF0JX78OvD9Awg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZjBA3nPBDG0djumc3uIWX7D+eIXXnBnxSHwujRdzOvrRREVJECUQDJBx+ASO0+npzkB2Cvre37S2XNMcn7CdxAEORkv41c3EDIfVITU/J23+WsKpLrQb2T9l2WErgI2sGKUdHRP8AMFVOgvtH4WQKiNWu68qHiR3S7EIQpWCVsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XBnBl2LE; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g38ev6E+zbtLi1VM7Dj0pzkH1vTOdEdtKaelAUh6fB7bqoLQxSBbBlo13uSe1qUFTKNX5Q3GGUsviju13tXlkCEaQ5YH3cM8FXoEkalHSOYJIeRFxyFw77CDkySdRq64uwM/hvIa0x9WaYJ38CwF4OLxCuiB51/p+NCDpfX2Jj6FlpyAarSMxfrcBOcJvljZkJOI63kkZ8GpmZvGNFNKEZUcQ7mLB35c0yNUGLdYGc3dtQ1JMAQwAG5zD+LWTYr5US+C/YAmtGStZfRkZ8957B1h5CMZBu5U3Y+EhWjTSWAXzPsDpuRtkijPI8R+MeZDXyWJcUoM8W2RMqGV4L88pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF1mbS1bhK9eipsoxt/w0VjfPcEAMVlu4G6pkBziQ1s=;
 b=ZkpX9/FM/w0uvGDOU/SlPeczoTPvHW1MRu6rDbpivnKOTYUNoioN3AY8fB4EuBqyH8Is4+eSXfsN78U8Ylw7YVxejWkNhwarU35oJ1mxkEzJdGb4vk690Gqp+dObCRNT2QzINezOKOpFEVyxTYNwZa4WYBR3/TH3Cyl44JFxT+wynj7XYYE8gqiwckFeiTe6jjotkFyWwdDuaXzxQfyeAKxqlCVVzMa+cy+KmkI2DvQJHKpOdPtSNIUxCbghoxmLWM9A/VLnQx2XRxmUcKXmWLuJ1N+/T8LUdjMVsbZlAkSfn5kXlMeLP+1Zy4FkT2BO+cwGJ1tO11bOP/EdoFeWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF1mbS1bhK9eipsoxt/w0VjfPcEAMVlu4G6pkBziQ1s=;
 b=XBnBl2LE1tLMMQbAdKOD19E7D7OeFCgfpasgY0jc33e/FQE3p39tAc+LO0inzphT4x3RMpV/bsVxHps69NrjRZwAQpBvd+HxEKZkxJ8hyRENXShCyGfQq+l4FP/TSaMa0hDs1kWTVfR96r/qOHxwUqqvFb1Ziv52LVbGh457AuS8ZeMgGDdc14wrtLKyRB1CWEI/5NmIK4FOA5W1k01XGdIeaFsjp8liAQAyXR9tsH1W3o8hr9CfKy17dvw3Hy2Mw4O9RwONSPKGO++mx3YrlApHzaURgWNOjCE7qpSbdxnULlZ3Y1PZx6NKtQsY3NDG2V5sxLuMG7GhcVQCv6GGdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB6794.eurprd04.prod.outlook.com (2603:10a6:10:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Wed, 7 Jan
 2026 14:33:38 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 14:33:38 +0000
Date: Wed, 7 Jan 2026 09:33:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: fix build warning when PAGE_SIZE is
 greater than 128K
Message-ID: <aV5utzwO6WZS0aT8@lizhi-Precision-Tower-5810>
References: <20260107091204.1980222-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107091204.1980222-1-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a222753-cf79-4ae2-3e73-08de4df9beff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pLrXDCehZVIbvw305a4IEVkysHvFM77ixNMTVRIuEDu+FiuyPAsYGh9Mi/rG?=
 =?us-ascii?Q?6WJ813/k6fApkbHYYUhcpTfKAstv7x5Ffcz0KBtrVFctDv3nmPGlcqcVhs+C?=
 =?us-ascii?Q?g63ssPCtOkXyeJb2x+TYXbbKGKxlRL0PXVCiIQYxKka6Zb6bDTYxpnHVd2DJ?=
 =?us-ascii?Q?dLPPodDNSL6YfD72atRTEN+J4TU+87Ag62kGkc3N4FT+FhqGFjbsi0TZXUa1?=
 =?us-ascii?Q?xbMq+lXFd9HsUWRY6LnVCJsaH9K8rs93/SIiBohkh9CtEu8UEYmy0Gdb36Ys?=
 =?us-ascii?Q?C/y+Yf7raKPUO2BWd2PrmGKyYx3gbVc2HdnbOo2bRfprQsrKBV4uqFpSEUAj?=
 =?us-ascii?Q?EexdSl+2yyP4ZIZ477QS/TMzu8bHmgm4jUPV7R216jE7UwFSgoeqwOOxQFql?=
 =?us-ascii?Q?AY5ryox7MiIVg3tgsDhIp+kiz1LeOdYjTFLAEnkVanVoOAnxCtrFsfUV1y9n?=
 =?us-ascii?Q?H6dDNs+gJWWVnByKAMyenC1gktKaNaOFwjQB0qPvrJx6OMqZfk8dfXZjeRy5?=
 =?us-ascii?Q?1qUxgb/sm2OW0yV1rySfMMiEjddSNeb6zVpHBLtY7jGM1a/OHgm5pHfGTJj/?=
 =?us-ascii?Q?GXxSt786fNO4QcGsRSjjFsgpfm8AbhC61edEMe3ShYZ89DHpdSd3oyEzptX6?=
 =?us-ascii?Q?fU63aLGG3xCgZvE8ArbXzmJz+qGYXdud4pHhKuxQyRBie7+8KJGnW+qflkfK?=
 =?us-ascii?Q?Nxz999N3cTCiRDahA4sRh1ndVxQvWDkcVWB0hudAUb64h0Hw9qN4VynrGKbj?=
 =?us-ascii?Q?MVBQ8YkzcCVPynwG9zPjRr/hgWisPj7Q0oh9CDsQMU66buQGfp2y7CzmGCDy?=
 =?us-ascii?Q?ElnwR/oHtC8veYLAb9WG8i3q2HQp1vGoL441S7v2sqWNJmYORPRoR38e7bWB?=
 =?us-ascii?Q?PjZ+jS2/tXheTWevMilRNGngo2JplwdSVJT+CCMWY+jIVmblCmZ+uDD1/UY0?=
 =?us-ascii?Q?Zxut+muOCkIoJnfb4/VJTXhsIt+nyWiga/ZUghdzQrlED6fnN5GpQUiLrR8Z?=
 =?us-ascii?Q?TCnpo0kqh5t4WTdIoDxJ0Di0Oj3POfPtlERfYcjjYp9VSPcIuWf3pS38fsyQ?=
 =?us-ascii?Q?36FGyFpUP1qkVQMs36ndetasJqwW5LK0C+LxkXToqJGXaJr7P4ZOsaxTCKUV?=
 =?us-ascii?Q?PpZJs3oip5Q78wUBOEuESpDWDNKc6en1ICBahvzZX4Xo7ghG+R0xRBzTZSMV?=
 =?us-ascii?Q?+XN+yUTN52cQeFkFM79KhytmGm2HROJmHV60/rCx7OK7PJmFxhR7btTYJIP/?=
 =?us-ascii?Q?UrazUJfVtRvwU8vzo2dQJsDFl34rexcGuf2L0JcwmhYe8GfijAxfroea3FxO?=
 =?us-ascii?Q?WR934iGuctYk6l7ibBstnNodEIQ1gen4eE9w2KSjJJEjxraptrFBQv9Bml+W?=
 =?us-ascii?Q?Sc7kUV5yXfIx5cUMheIColIj4gaicJAheNbu+6gho/98qamWyk0zzGVRhohp?=
 =?us-ascii?Q?GLB8QJ0zbnz5XACn2bzk1sj7OUDA+8EF0JMj8I3bBrNCoP+nYy5oHSsHUCX1?=
 =?us-ascii?Q?Gpjx0gzNV7IgcdsZmjdmHKebw0q/Z0QkmW+W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SCVnTGwAlqfowCcv2qJWPtqUqRMAS3pIzDEACOEJDKA05smVLcrB4lb7BWLT?=
 =?us-ascii?Q?bE6IEx+IaiMcMyhxSKzneD1uS+jtwtdJvmPaoSSUgUubPiKvydrtQQWCIXlW?=
 =?us-ascii?Q?jClwQYOmrmjORClVTJX5lpMivFgSfYJROST30v095J52bushkZukG5bMLgAs?=
 =?us-ascii?Q?ifZN2FmkSEoJNxZ7AUIxMJk5cLG0x6KAAFHhxmxlKK1BQVCX24k/K+xIYIU+?=
 =?us-ascii?Q?WpNlR0pm0kHpNCO5sByvMaefPNMNsUYpo30lQvSuNhEAy4rLqPMKyBRRULH2?=
 =?us-ascii?Q?+GQ+PPYfUxvmXkkYtKa4iZMHF9M6icM/WWnaI8XJejZ6uyBloe6cxjeVv2ZR?=
 =?us-ascii?Q?FraaoWKa1ZdEzpIom9aHGNssUvWY6cpsgqcvnZoDJ3v6He3ibUzMC8NuIpez?=
 =?us-ascii?Q?EGSkdy5MmTWSE4ax9smlC4+ubqVJMBBV0EjKXfFekyX7Md6+CUbCm77ZGxeP?=
 =?us-ascii?Q?L4jb7jKQwu0adr/G6a3YtFeSA/pTgeryKJGuR7T6u7tUN89q8GxO+HPo8vBo?=
 =?us-ascii?Q?c+OoVAQ/WkzVkTzK0Ha6mlO1dsTVY1oclHQLfiv7S6hIRlRm93gDHGNOVmaw?=
 =?us-ascii?Q?qER2wix7le+B4cXrDWQ7+1Z6QUdVZ0tAUamgqv1RdP3ZHq34gKgG1rnP6VlY?=
 =?us-ascii?Q?CtnMVWFHtVcP9rA1Bw+xzcPYF9VMe3sR5qZAuVjwiW90cMEndVjfmi0spHan?=
 =?us-ascii?Q?tb/Y6yVJwx03E/o7zl4E3Uzl3/bsjxP0UQjDocefY2ogmMFlBT9/Gu3zu7WG?=
 =?us-ascii?Q?pqAIQEt0YgKECM1CnTgyzoYj+Z2Dsjah5CGg+JKUAiGHRxGd+Bg1bR1Q+9TE?=
 =?us-ascii?Q?L8JmohBPoT7R82qwgkz4S1E0c+NsM9Y1dCcBhLo3mIaKpYmEJT/FV81k+eMB?=
 =?us-ascii?Q?AMNUUnsH+Sfa2Fy9tVm61GeJaiIKqnLJKByRk+QKVsv9ZyeuDrcmDdw/IgAe?=
 =?us-ascii?Q?bfDbVoCPt5wsd3MEhmJomt6z1+ieATIns96OuO8xKAd5R9MOLayQEQJoFPDc?=
 =?us-ascii?Q?3T/yEGfDEPHlpV0332rZSiW7wv4OjVnkDZM9ga8yEmqwLvj6lbP+65wiaDJ9?=
 =?us-ascii?Q?V0WfF7ng135KsQ2Wrz8WEpAvB4MZyzcY4zOFu+bwa5gObPkz14sn2EbPhHe7?=
 =?us-ascii?Q?3pFrqVXHktkc2lGleXpbuHgPgUbQe7ZlUeaI5WUO58SGD8rtMN9kbpL9BAID?=
 =?us-ascii?Q?W3W2rKQ1SFBg6kXQbBJfgRQq4t3EFYNfLH7ae38OMSSE2199tKSvQ/fvDxO+?=
 =?us-ascii?Q?skh6tmguwy1TEFUEnU3VpU/V2vm3aNyey4nmzuwlz8HNSEviRx7gNNU8dK7k?=
 =?us-ascii?Q?dwX/mSXluWsZLg8ygfHTcA7Bbi4RvfCBFuOBWrs1etf0CAtf+L6ZarXcyH2a?=
 =?us-ascii?Q?fdDgGDkz6leSZAlH17D8wRm4oM+5jdab5YCMj4f/2lyrOcEkzdMrSp0lqA01?=
 =?us-ascii?Q?od2EyRwRR1q+MGdtA491tQ07/3nk013PiSF1hfXgRDFm8jbe2g4zzxyJcPRM?=
 =?us-ascii?Q?s36mcht2Va8URAVuQEVgLH3XNNCayLKYSqk5iSXjvdHXblj+Xq3axFiOVhh+?=
 =?us-ascii?Q?Kebz6yD/zRv5bUQJv5oHWSx1PY/C5QNMJI6miwk6il909b1XqoZq5pMQm5+9?=
 =?us-ascii?Q?PqFgOR7BMA8Cyy55NxYatAqlj5LLbXFmfNbdGaA9S6K0AWczMwJ1flRwhKAw?=
 =?us-ascii?Q?HIDVBYQ7Bbx3N1ufVttl3j119QpEzRv8RwgbdtBeHdlkkzwM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a222753-cf79-4ae2-3e73-08de4df9beff
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 14:33:38.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgknQECpZ1f4OSoDe9mN4LwEa5FcBDJ6+SsPF/Amrp1ETSNGSbumKq+3YNwSSFKK5q2CB/VUD1nLgfJcCyHq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6794

On Wed, Jan 07, 2026 at 05:12:04PM +0800, Wei Fang wrote:
> The max buffer size of ENETC RX BD is 0xFFFF bytes, so if the PAGE_SIZE
> is greater than 128K, ENETC_RXB_DMA_SIZE and ENETC_RXB_DMA_SIZE_XDP will
> be greater than 0xFFFF, thus causing a build warning.
>
> This will not cause any practical issues because ENETC is currently only
> used on the ARM64 platform, and the max PAGE_SIZE is 64K. So this patch
> is only for fixing the build warning that occurs when compiling ENETC
> drivers for other platforms.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601050637.kHEKKOG7-lkp@intel.com/
> Fixes: e59bc32df2e9 ("net: enetc: correct the value of ENETC_RXB_TRUESIZE")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index dce27bd67a7d..aecd40aeef9c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -79,9 +79,9 @@ struct enetc_lso_t {
>  #define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
>  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
>  #define ENETC_RXB_DMA_SIZE	\
> -	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
> +	min(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD, 0xffff)
>  #define ENETC_RXB_DMA_SIZE_XDP	\
> -	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - XDP_PACKET_HEADROOM)
> +	min(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - XDP_PACKET_HEADROOM, 0xffff)
>
>  struct enetc_rx_swbd {
>  	dma_addr_t dma;
> --
> 2.34.1
>

