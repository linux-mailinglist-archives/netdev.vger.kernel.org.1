Return-Path: <netdev+bounces-247381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40ACF903C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E7DF302F2C5
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF1342158;
	Tue,  6 Jan 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="miHU667/"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C2341AB6;
	Tue,  6 Jan 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712532; cv=fail; b=JuFOLl9DsVcCH4+mS+MopV/6GQWNA7mhqcXxDNP0ni4eh6I6iI4bUv28lkc2+As6SoDpEfmDGChKLOAjBj/SbONFFXCg6EnzvhBz+ja7DUcL7vd3nV6Xp+PbWZifxJJJVFS/h8lBztOu/pyesNzGyl34Q5mNN5em1Xh5jY/E/rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712532; c=relaxed/simple;
	bh=/EMnKAjJe4R9gdCNxEnHp+a0Li7DAEn/q2GtREvUc68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BTtLWg193EJkWxsQx9+ib0CByZU5zx+2UZKamtoma09IfwaPl+HKkvMRVw6W0Suht/0fBblGRGq3yK4GSgS2ThHN110T2+btcMfhZtbEeziIihTdMA+ruCO0sXwvEO8yJ4JGuDSXhSNM+p785KSh9IOYV0RO3+9q17aAujBMPG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=miHU667/; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNGjwVzLpCBkAUM0RoTIjWdze7WuK4Hu1sbT16xPn5Fgw0jZZtMSHOspTeHzZRtfiYalIZ75V4HWgF4kS6MYdbcD+ifrV5gGaxgjq87g5fy5N5dNEeWIqMUW6qOCVieSL6vBf6jd5g85ry/NTehJOh+B6XQUm9P3cYeX6EP3Wh4HTvXSZanXDjy6SD16dg/WYhBgvVa3VElPAEDX64BGCYjG2DK3lG0zzOzXABwCnkLH2DOYUgRz1HuRqcVO4do06mRhLlPwLF04SUfAVMou4YFU+bkfCGpBwOQZPe+DbDjV9GZ8KIoBFM08lZ2MI41HtRo5t8jqFl3bZl75WrvY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUAD4/AxU/AylBxt5EkwCgqZFjmdvpSHxw5e2V+L+ZE=;
 b=ZMUr4PBec7AjljCB5w3P9p7bDOIuVoH2BdmV/teKDF+Q4lmaETzxqTWXD8jqZWJWUlfnE/TSeqUVCVWb56RaN6l4aZjipELG/0CoNxJO8ZOetmm20B+DJHXjsmmp7MJAeCCUFMsU+rpYrz3bBbmRe3a4aExSBkuYBwYWGnSiZC3d2Fh7z8DYhnymm9eOAqX3y3rDQ5Vq/bt34NRJ08OWSrgwaBR8m1sTlDE753dwbb2nNbQ0WljkTKO/b5pMd421nHk1TnHp4l5s7Wopl5/GTHv/yLjrMknzmogl7lbwjh4Bb9CGFKw8AWYFAhogNjHWdlyZfwPcG8fQCFw1KdYIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUAD4/AxU/AylBxt5EkwCgqZFjmdvpSHxw5e2V+L+ZE=;
 b=miHU667//tPAdNDdWI+LXZIHWR0r+jzMr4qyUterblCz9qtIlMgZ+O4wYz98jr8WwaNK2ooSMaRaWSTWzphh8IkDAddqWhJCgTjSr/qFurbJnQaSOVBC7DgT8oRiUFSjjCtqk7N4kmBjwiGUuos6+pxEhZzRwiy3vOWb0I1/AfKMAW2RPRNy5m5Kb7owI/rwByqyxt+r5/VqXjohTqhLDtj87XB8BESThK1LJrIeY72W8Yj5dya0r4ifQTJ9dno+F8SR0G3CrIF2PKrvU9E/3+jpGbqLaQYH0Phceet/6Yd/Hi11hdoCtvbQsLVx9VVnOrrnHKrGpV9pq2ycPZ699Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10289.eurprd04.prod.outlook.com (2603:10a6:800:242::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 15:15:25 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 15:15:25 +0000
Date: Tue, 6 Jan 2026 10:15:15 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	"maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	"open list:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
	shawnguo@kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: microchip: Make pinctrl
 'reset' optional
Message-ID: <aV0nA521iLnxYTVu@lizhi-Precision-Tower-5810>
References: <20260106143620.126212-1-Frank.Li@nxp.com>
 <20260106150245.exhf5soqdjv7nkb7@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106150245.exhf5soqdjv7nkb7@pengutronix.de>
X-ClientProxiedBy: PH8PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:510:23c::27) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10289:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5799be-ed5e-4ba9-1ff4-08de4d366b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kPimdYMrzehqQ2KiLznx01MWKgP0nMFKfNAhFjvhWjugL2TBY+7H1xNiIT/s?=
 =?us-ascii?Q?gOsPxaYQEMAbAm/Rk3rVHUe7YeM/dyKNvfbW8gp8tjtsu+l1VpKoSFYuIWFs?=
 =?us-ascii?Q?Tg0HSmE2yrnDGWUha8D5AkkTo7mnjmKdX2z3iaaGJ6D9PIPVK9nBipt+mdiX?=
 =?us-ascii?Q?uA3Yc6wTKaz2y0DSK6CNMO538dYsPxGqKYQEllujjRyevjZWr3yJZyIOR8c7?=
 =?us-ascii?Q?bg5U5B8SlwEuxfdoCr/J7xMdtCKt2dQGaVURE2+9piXRrrwbSSrQeFXuGPYl?=
 =?us-ascii?Q?neg5ThhzXB/fRQbnUl08XKbwC1MAPT+y49Ezj6I78KZlO1pfgowyE/3YZlMh?=
 =?us-ascii?Q?gi0fYPDan4a89ayPJggRsq+aivj+Oj79rw8v6AQF6yKQIf4q1D9xTCG+hPmq?=
 =?us-ascii?Q?ikVfOqjwhXmIgwAMjbqjptGwI7tQcCh3gKEKgOm1/p3UzxdJj4H7U15Qydn/?=
 =?us-ascii?Q?vaMFUeElrh1OikiqLlJra+fdWxKLOTMB/yjRQBthNaxCWeSjyJrm5z9U/qwn?=
 =?us-ascii?Q?uxVMfAtzQB+tYgYzR2CMFnYmatBxintxNyby7fEEijBc4kR+rHZPSH+vnztw?=
 =?us-ascii?Q?wIuAfdAyBT0Ke/YI+4FtWAW1/LVN556d35EFLOCYqbkmXBoCMGbUPQ2uj2rz?=
 =?us-ascii?Q?Cm8VqHTd9dkZDakKxbLPfkjAA33EZ131oiCxRWZho1CeaGgR2wJH+z9Cqpew?=
 =?us-ascii?Q?XLnkLKBz84lDaN7WFERRavGw8UQ2Pa5wFAcEPp03dpJ/AXCU8BW7lF7cvJ/9?=
 =?us-ascii?Q?cFxlGW6Vu6vnnw/X4hzTJjR6ts/WkuIbqxMXxsDFxxIC8ZkIgaYb0U36dR3B?=
 =?us-ascii?Q?PuUyl2sU7MPBnMyl+RqkLNliFMvFUyUs5wKBMp1EjH45FqHzJLlZijQRDwyq?=
 =?us-ascii?Q?5BrTFbLYFqSG2H3kw4zaVzfvzbF+PU1h4XmXDCE4OMcvBnYqg8OO5knBqX+V?=
 =?us-ascii?Q?lUevYIwxUkvwlpAja/sFRqudvyihLqOQStNWb3BuTQV5RPBAE2tXFQ7ZJNu1?=
 =?us-ascii?Q?R1k43ZItfqTPTXyfyCLxP5iQdxWeeirMd/64UtxQNUjTaB65yAZQYr9dxx4W?=
 =?us-ascii?Q?AV7TGbFB52qXEnz+yWoJQb8+fr9xdv3cr+UuPEyQQBazYDsh7vANUzESxfjK?=
 =?us-ascii?Q?tfLeWh48p746L1gPIhQ51l5uNB7lhE6jsa+hXCkvrJ2LFJqA7H2C8LU5moHj?=
 =?us-ascii?Q?II2hec3ysHm4ZH9UHprx+q8NQA4QwAYWnU2BLjwoqDi1AZmTdTc/ZxmNkd6e?=
 =?us-ascii?Q?T7/ZNDz/gwBkiYw35Km/upVHjCX9FPqCCbjjb0Fot68DGErNLxUry496gX/R?=
 =?us-ascii?Q?jGQ6uCvWTmrdcNTiwjaKcq3AMgkVvY7cFtW47YWqbqLTucUlD7ryrqtuyu+x?=
 =?us-ascii?Q?RvButeddmwXMu3l+U+t7UKShXi02vGesS8c7MTzXQfp6hwMiJS3MR9dZ1RVc?=
 =?us-ascii?Q?cKjrXm08IwoOqhZuKzZ8U4RYFxOM3ux2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFVS/GMMfeWTfZUlktw/80VGf+n4nYQQimILUAm8Z9eye/ppimFCussRn9Hd?=
 =?us-ascii?Q?xNj1bnX6PsHVDkURugdcMwJpaEzrbp+87yrVU9AI2s2a44k94NgBAFIVvMt4?=
 =?us-ascii?Q?Ecnjm8CG9KKGcb3SRdoR3BhyYla40VjCJLMfGoKnb1QkpcLnj+2r1MKwDiIA?=
 =?us-ascii?Q?2Y3Fq9MGD+t5micd5alBOW0uGCgzthUP69V+koQWTTsEr8GV6vbfy5x6up/b?=
 =?us-ascii?Q?hWJlQHVu8Ia7Wf5GMqvgJPHFxKAZszFYbi3hKPI5Qzdw8Upts0bxeJHRb9Jp?=
 =?us-ascii?Q?OSJKTAfJhuYRwdrsLeNwDPXoCaa626wlagonM5M678P9eVayWZbzfsG3t61W?=
 =?us-ascii?Q?Prir/sgvb9OJZGM6lGjmxftC3wLsEymyCZkRro28X1Sy+vZZqAP67TJKw3JT?=
 =?us-ascii?Q?CyCotv/TyoRMelZFOl6xm/AJHM/JMCkqKgttCJ5gvS5R9PiyhHbrxMm1EKAV?=
 =?us-ascii?Q?0EvSh78ZpV8TtbAkEwmF2GdArXr6ymMEzXiMIiRz4fAzk6f7jV48uXrIN3eH?=
 =?us-ascii?Q?PnF9uao4dYt/vhf/YXg4E94MK2TvadTKEajsXOFay8jm+5mWTeLYMd9b2TVe?=
 =?us-ascii?Q?BdBjXH3PPA+PilIP3pUoY1B5mQajjY74PkMrbrt9KeMuz72IVANxSbaik6/D?=
 =?us-ascii?Q?a8yNjVV/yNGaQ810VsKBo1RPjIpbuDJNko4yPgOGYwDLm22G/f/XAONcivHd?=
 =?us-ascii?Q?sdlHrXY1qfr6abbGS0ukunCdECC0El3Tv5c5W0KXERwvdQor4P/5M07rA6nA?=
 =?us-ascii?Q?QOn5CfKKQc4m5kpOxMp1NvvwW3sKbvql4dhwpuFM+i5ppurunDvNZRFkqdiN?=
 =?us-ascii?Q?/JaI4m+4d64QFBaXmmsoV7lmtftc967ApVetBuibF9WkCRojgm/SgNNgkijX?=
 =?us-ascii?Q?OK/enuvoCFLBnds6SomtvzgARTTOPWzTgstnfJlFDVpjx5vPrroPj86mq+hN?=
 =?us-ascii?Q?HGGOmoxWAMZAIEt2TybCAyPufE96RC5SSI0IYPj23VqWdjrHKnel2PJacRF1?=
 =?us-ascii?Q?ltAZszbSx2cO25Ig980mD4yZnMBknAwptwuMFKMXuf/sy9sBXA+wLqTE27YT?=
 =?us-ascii?Q?a4MymZFQgoj89BsVcUG//AacQdxuM3zFlce5P+ObM7T6sYJ0Iq0+ldX63O03?=
 =?us-ascii?Q?G7MzRLwPgAideDbZjOqvCtCMoQjOQG0uKb2gsd7uWhOPQcOGplOj6JPFLImI?=
 =?us-ascii?Q?kM0ZCwSjEuLUMtPK595JAQIe3awcvd/wAc1Fgb60IwSOjVBcHPM0sLJ1TR4A?=
 =?us-ascii?Q?Ub41sCUm6WNqBYlUcUIEi/MzCHR1UeByK5qwXBn/My81dN0gVCUaZTueFtjY?=
 =?us-ascii?Q?4KAZpSmjeg3UPT/eWZC4mpVMhW9Zxl/PdXnWzzT5wtgfkmV4tJThJEXykLYa?=
 =?us-ascii?Q?xVdxGVUyp/9f/NXie7aZvIK7lwJMrHgwSr8NUBIf/pk5gK/xQrVWm6vj8hzB?=
 =?us-ascii?Q?HETjWsaDBOTjj80HkZXQ/RiU7o3W7SM+rLA7peedFpRi/7Wb3cDkpA5Bstxo?=
 =?us-ascii?Q?1wvXnvxtVz8T8P28FzpnKMG2uXVfmNhlepsWeGY3GslS8n/g4ff+JbRvrMCo?=
 =?us-ascii?Q?o+ln785WB7VS2POFdInwMytObOIxUagLd9qQ5nf1nAfMAB/1gI8pS1OEvXf6?=
 =?us-ascii?Q?oJ/yomRra0gEnx5QlwCXWTeYNkY3/hCD84i//DSVhyyXif9kvA5X/6qZXoCm?=
 =?us-ascii?Q?M2g/7qp6RLFfQ4BL60wu5YZVNaTMosz6pSt2EFzmYDAex8oLRH06Y5NHSC1S?=
 =?us-ascii?Q?3tmtVyW5/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5799be-ed5e-4ba9-1ff4-08de4d366b03
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:15:25.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXCnefKJQs6P8b7JsMjS9lD9+wK7RZDipSBnEs+S1uRW9PmCx5OEXDb51VDYASW/lf5TZAaB8bom/OjmfDZeAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10289

On Tue, Jan 06, 2026 at 04:02:45PM +0100, Marco Felsch wrote:
> Hi Frank,
>
> thanks for fixing this.
>
> On 26-01-06, Frank Li wrote:
> > Commit e469b87e0fb0d ("dt-bindings: net: dsa: microchip: Add strap
> > description to set SPI mode") required both 'default' and 'reset' pinctrl
> > states for all compatible devices. However, this requirement should be only
> > applicable to KSZ8463.
> >
> > Make the 'reset' pinctrl state optional for all other Microchip DSA
> > devices while keeping it mandatory for KSZ8463.
> >
> > Fix below CHECK_DTBS warnings:
> >   arch/arm64/boot/dts/freescale/imx8mp-skov-basic.dtb: switch@5f (microchip,ksz9893): pinctrl-names: ['default'] is too short
> > 	from schema $id: http://devicetree.org/schemas/net/dsa/microchip,ksz.yaml#
> >
>
> Fixes tag?

This one is only fix warning, some maintainer wants add fixes tags only for
user visualable issue.

If maintainer want, it can be added when apply, commit hash already in
commit message.

>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > index a8c8009414ae0..8d4a3a9a33fcc 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > @@ -40,6 +40,7 @@ properties:
> >        - const: reset
> >          description:
> >            Used during reset for strap configuration.
> > +    minItems: 1
>
> Does this mean that all others can now either specify 'reset' or
> 'default'? If yes, this seems wrong.

No,  It allow that
	 case 1: "default"
	 case 2: "default", "reset".

Don't allow 'reset' only.

Frank

>
> Regards,
>   Marco
>
> >
> >    reset-gpios:
> >      description:
> > @@ -153,6 +154,8 @@ allOf:
> >              const: microchip,ksz8463
> >      then:
> >        properties:
> > +        pinctrl-names:
> > +          minItems: 2
> >          straps-rxd-gpios:
> >            description:
> >              RXD0 and RXD1 pins, used to select SPI as bus interface.
> > --
> > 2.34.1
> >
> >
>
> --
> #gernperDu
> #CallMeByMyFirstName
>
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

