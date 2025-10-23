Return-Path: <netdev+bounces-232182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2FC02281
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99EBA348963
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C932F764;
	Thu, 23 Oct 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="khOQnctV"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695B3148D9;
	Thu, 23 Oct 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233753; cv=fail; b=IG4/keNeOlWzfg/pUsEo2jfcCZp/h5PkJAJO8lXV7iWz+wiTTZ3s/IZ5UhpZcQjhoHI5fcVy3GFsp0LrKD35EKsNVHY903xnV+uho/GLAl/+4U5fwFIhPmuTj0ZAbJijIWSBhOsCazAXsCNwBqngvm+IHV3HYhoRZA6uqui6YiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233753; c=relaxed/simple;
	bh=NQtzmlXSJD4ONmBN7ggjoxBuT0Dt4ceS8qLdp7lBsXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XfiSC5k2LjDerWhKYWEbj9I9aN22R1ZeZfgjFXrjdbXOFoeCkNT72oeNHU3Oe4uKNyqs8mUErLd5cvLcAce09oCU9HB5IY3IU2iCGP0ex02ITdED4jPAe9oKxa/B4A621zsIr0cF8twwWWVOkWMfDh59KaW4VypMrs+nDZKcbLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=khOQnctV; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnObAg+Knbtvbw1NcnQwWGZN3yCYJbPil3wtZuJTapJdgZuwa8/gFpRqDGf9Keh8n3CoX4V+LR+WMMm9lzUpPejaUf8VhVIhyyj1KXGuHu0+NTCyyrE6f28EgDoTLSKHEn9syyFb/XZZRt6CXRTzqakpGBdquOa7e0kvNszJ6tUA3Kavmd+9mHEe9BMH++ClsGxY6PL1zu04BB9gJQvjNtTQXulAKThPH5QJgFvGJ27p3AwFbu+pxjC1X9Nm06e4Exj6x9ocRKTOr27Yc/0eSBdhfTew1ACvIz4vU4LY5wQdZFz8Av4f6BNNecuYWWg6KeciknxPrGnq+qbnm5Xvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52+z86Vzw310MxaGxQ8nEgN4naio5UuyfBstAi7juWA=;
 b=QrO6cEP4bVfgjkuYYTJxNV+4NiJuSQDS9eYu6VIN4knc9orYQ+a2EiZeHyt/V24osI66JSJ2lfKLr/0enXy/ncnwrAjfnv2Z5x04oYiz7Zh4Nz0NU8Ymw6OH6dVoF3661Dy36co7isJICsQmUqFBlRxRG9NZC2wnk2Pv9ljP4nVVuwYRhbrZJluNfr+1H3N1UhAHhEbUZOGz3e6ryWS9JQsQz3ckMP+MXXM9szy9rWl8apDQaOJ6z8C6VkOLQEvoFA9hTt6ZcqZxLOQAGeFxil3Whd6SAAjUV+s8otWTJhmxqQin+QVfqfogU2GaJTubgpQRQTz0MCbC9e7hwBVBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52+z86Vzw310MxaGxQ8nEgN4naio5UuyfBstAi7juWA=;
 b=khOQnctVBg19s2KmhF8+xomBO1cIlu9X1C62YKhIS+jL0kvqAcFOOd9Xe+bSuJDLS5ppUHiNObTH24crDo++4bTdNkCT8qNwH5cdTaitDr5FP1YADI/YdOGYHa2oKXuWizPRv6u5DoCsuHQ2rty4Fpi+4fgOtkFnDXFn4ESUmmgxNpFvlWjx+NFotEYF4PBBamoO5w6778nkedcUtl+I3LL6EpqIFm4uSHgmDT5RRX8zDRRo4nyPN3oWu+z85NFKfYVqHqeuqsPTSQJfMcCGI8UvK9mko0cd59C4vJ2wtqMjBQ5MeGuVVVsudtXFens/SCFAmT6WsbeeWGHWlRf4JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10909.eurprd04.prod.outlook.com (2603:10a6:10:587::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:35:48 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:35:48 +0000
Date: Thu, 23 Oct 2025 11:35:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 4/6] net: enetc: add ptp timer binding
 support for i.MX94
Message-ID: <aPpLSv1jhP19S8k/@lizhi-Precision-Tower-5810>
References: <20251023065416.30404-1-wei.fang@nxp.com>
 <20251023065416.30404-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023065416.30404-5-wei.fang@nxp.com>
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b3434a-839c-4ba5-2e9f-08de1249d6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZbJpbSpc2N72QO0d/9RUTIx4qyZmala/8ba7jRJaHir0xJFdUuJWSfYIf6H?=
 =?us-ascii?Q?YpybGqqpCTLhJmB9C/8W2vaSVkn3MXITYZdpgzLNNZMXlBMZ9H7kg4xF2+A2?=
 =?us-ascii?Q?nwC5jFfe5gbgQ0AjTO/M+nWd3IMWvnolJ38LckMkII/m9VaKwQ84RIM2pSao?=
 =?us-ascii?Q?8nqQdZMcOhZCQumGyB++QRVca0BezZEP4stiFjRBDARputTXvepm81pAcPra?=
 =?us-ascii?Q?pNfh6MeIyFhQcLXg+HaNdr8keOZ3yAlAiEO+YPMsI6iXCSHal8tFKiHkadZN?=
 =?us-ascii?Q?VSNmoJJvBZJwOJCINzdkxqOE/KULIpCDXBFakzi0U6HAcuMo6b37q2DJu8HM?=
 =?us-ascii?Q?ZRAJKbLZULEp5mD+Pcsl7oYOEyAId/CIFqVVA9MCkjC4IjqkrDa/Iy7//NKQ?=
 =?us-ascii?Q?EuziozyvZR6qvUTSThxrPec+22ofqj0OW8ukwm2f2Xpa4Mt4SXT2HmKMzm7S?=
 =?us-ascii?Q?BszpU+beE0cteh7OMgER6zx3Gnb4DruvGg9P+rgx+mIz43vKotZ6KZPxyjCC?=
 =?us-ascii?Q?qO8xucQLgPqNqi01nPFz9e/n8/xaNJd1q15a9uqRyqDCj3UiyBk+rzFZfmGz?=
 =?us-ascii?Q?TSJPB1m8O2ID2WeONHeBI4zeA5U3JVaOXMUhIR3DYA1cFw3XKV1TbThMvyvF?=
 =?us-ascii?Q?+xtShBCzC2xaohFtDi2UVxxnrRLWSEmvJz24e+jAEUjbStiI42P+AVc06Zjt?=
 =?us-ascii?Q?KQDK99iE3Ea/RizwpMUnqEaywXlr7mZFMFyW4wme6IHsayYNsXdL7++C2VyF?=
 =?us-ascii?Q?NYYYnzAIZ5PE55euFEFZjgLXOo9RupY0fOVA8GkgBE8CntYSyxS/Lhira/vf?=
 =?us-ascii?Q?+/aHzjTYb9n9JCFbZAVwRTUxfXMEAyEvV2ptq985edsXxmtnH624dXbc6Vwn?=
 =?us-ascii?Q?TZG5j8VCkQnqwpC7+QbKpfTUfvDIuCdstz2Sp29PW5BTBAo8a6QBSjLHa3d5?=
 =?us-ascii?Q?2xdv4LvdTKu6S8N1vkeJwqCY98zp2zLfCucNWysGVJaGn22f8E8mJ1o73h6n?=
 =?us-ascii?Q?WradzQx4RLZVdrP5xZhthCHL36AO5ld9r8pxviM0shypmu65MiTDUZrCWzNM?=
 =?us-ascii?Q?CXmTkGJMJkwxZQThbC7O7FADQgJM2wqzZNQzqqkxgVqS6ZnFJF7aeCvqoDPO?=
 =?us-ascii?Q?27qWAk6acDGzlkIoAVj8soi7+UXhcJGaYruuTpm6qlDDrRvJ2pN2fKt1mMsl?=
 =?us-ascii?Q?XiKc0wIXH/hbmDKacLCHAo3ApkJ/jGxcH7cegGLvFrKihxYXDSCtp53IMIry?=
 =?us-ascii?Q?BMeiP37h2cZlstgQNoAQmEanAUPygTf8XGAZCZucYnAon6DxXPfI9cArECFm?=
 =?us-ascii?Q?+wgONjgpQrgz5296HGOrwD6+mIIpPpWhO0YBLBGo0pBaxqLpND2utLclTUU5?=
 =?us-ascii?Q?ZVmrYc2fltjH/J8VupInWJarxYoRJVF39PJbzm/q3ECUUoVynKtzvapvurK/?=
 =?us-ascii?Q?Js3sHF5ehNo6Nm22cvQs1Oe+QkWxlGy/BqASaZtp5E87cdGj3XgVw/RHKS5C?=
 =?us-ascii?Q?6izVYSxu539GFHcKJGpEA+oiuieB6/4vNXsf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cqzkmywcfPxRrpShnSdGVlvU+WLLHaCPLTKRI6hVl3TOMUH4vFbGGWbm+rgJ?=
 =?us-ascii?Q?tjO87ZENiXo5WoyTCB1XPDOihCVU59+nbU0d35QtET7dCUD/m5sXC7yIAyX0?=
 =?us-ascii?Q?wy2XETbM/eehMkebn5mqQ//AJyGpnj2ZFiYd7I2uadrPlczaTICzcHcJ+Yra?=
 =?us-ascii?Q?k2PjGZjupYSQIxZrzhMpz1nXUamT3Lo28gQ6+1SX/3koyLjtCuty5o8t9r5Q?=
 =?us-ascii?Q?irw26YFdLGExsJpHe/ui9vB609VWkvVLHRU+nIfuK9bmQ38IknHf3vnBlZFb?=
 =?us-ascii?Q?tSGEwr0tFCwyhASo5ah+4iJmSocrEOl2bXVYe9exnyuOABChJcIj8mE3KrDk?=
 =?us-ascii?Q?DNcq5JwrcXEICpzHmZMBBHhfu/lQXuvCnfMulppQCqO0Yfa76OAudw6e5j7n?=
 =?us-ascii?Q?Y8/DP/qvQJDCJBc3zvoSdtgpYs7HcnCD5OGIJAEuWPE72T8NSOo+jTyA4X6s?=
 =?us-ascii?Q?LRxe2jXF5j3Hfu5hI9n1UNwl45afOYHslBKnUpQJ27pzIdZZTPBd7xBFUxNT?=
 =?us-ascii?Q?CFJYJAtMomU+FeMICGvVPEnm0V3VrkTiZh9cEt0wdmGwSbxMKpF1K8Ql8VTb?=
 =?us-ascii?Q?9wphKGh95q63JSGyVqFoBEP5oBYTdmkBpM+3KZKtF2baFQLJdlcwr4OTIEvJ?=
 =?us-ascii?Q?vVTlp4oVBb4kHz8a9GSzRaZXtH5tHpiSd5GZKCOgI30NtyX2cJjhp2qXY2qz?=
 =?us-ascii?Q?qgOYp2lv1yQ0JR5GNUcgTius5ZX/HnsbQurhsNmV4pxlcIBu5NDS781FVCi/?=
 =?us-ascii?Q?OWKDym/gCFrxZ+0BdYSyuw5TijcomsY1NJCFq/cBxanwqsOJMJkWOLsT2Fnk?=
 =?us-ascii?Q?E56wr1K1l5kfJW41KZiQ9z9d/KQTknImlpvKRJcrqRElBH8N4Wx16G4Km+GM?=
 =?us-ascii?Q?mszmBI3ojqCHXC978Ebu6YEA1g4RuUdHVxEfyegQ0d/O4sczU7Z67hGcqtRm?=
 =?us-ascii?Q?b3DmwNUuIRxDYyTWCjQa/lVE7L59kAUma92tBZvknIJMb8ndGBEOyF3nHnhW?=
 =?us-ascii?Q?pRUIxa7QHMr2xOapmYLNKM6O+Q9Jfp8kfIVlP9b103qfoyXLzVuPJtg5NJrw?=
 =?us-ascii?Q?VYvYHmx4IdPNCXCzfvsPK2kofMvFOHdzWtTW7GjNVgaKGVMZmltvQpaS22PX?=
 =?us-ascii?Q?MuFWJNGeuDvWXWAkeABD9Iw55RZjt6ZGFNTinjPKvV8FRnklI9A4xGRe48Al?=
 =?us-ascii?Q?HDTuHekqBLxKbfiPagBgFHUVJ80vYBSRTsYCgtQAJ7cnpe7w4FuGsvFNmIRo?=
 =?us-ascii?Q?Zab5xHXU9gxTvF03JKie6zG5U+GwUSOqCHv/CPqcogAIfPMh9bbstbNVGkn0?=
 =?us-ascii?Q?QZ6UTwjx1MdSCCRPBBgqHhYdJGP3vW2G2sb4a/nEcGDo56bmPGWeawD0SmBK?=
 =?us-ascii?Q?ovLbl1wRgRB7x7rNfCv0PjykAjaNvGgxj4ReY6oiTWkAiy9AXv3Z702ol5Zr?=
 =?us-ascii?Q?fXubKvoRhK7UWdK7InC+7nHrQIJV93UaL3DdYZ6cOwE8wH24ZSeZDpo3mw4W?=
 =?us-ascii?Q?FiNJK2mqx+pgH2Mnag/GxJw7bT2rCMCzJoUYL2PBnWZq2oEDtKIwVYVs7ARk?=
 =?us-ascii?Q?vHkdr+/qol2v81CzjRCXsM+P3rnZckAj55MsSVwU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b3434a-839c-4ba5-2e9f-08de1249d6c4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:35:47.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC5e/TOR04ZVo/49rVBowcgmOwhSAiEasyUKUHotB4yS+8D5KyB8H3shu2nJW572yNT+tk3rJRok8z9Cett5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10909

On Thu, Oct 23, 2025 at 02:54:14PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> The i.MX94 has three PTP timers, and all standalone ENETCs can select
> one of them to bind to as their PHC. The 'ptp-timer' property is used
> to represent the PTP device of the Ethernet controller. So users can
> add 'ptp-timer' to the ENETC node to specify the PTP timer. The driver
> parses this property to bind the two hardware devices.
>
> If the "ptp-timer" property is not present, the first timer of the PCIe
> bus where the ENETC is located is used as the default bound PTP timer.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index 5978ea096e80..d7aee3c934d3 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -66,6 +66,7 @@
>  /* NETC integrated endpoint register block register */
>  #define IERB_EMDIOFAUXR			0x344
>  #define IERB_T0FAUXR			0x444
> +#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
>  #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
>  #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
>  #define FAUXR_LDID			GENMASK(3, 0)
> @@ -78,10 +79,16 @@
>  #define IMX94_ENETC0_BUS_DEVFN		0x100
>  #define IMX94_ENETC1_BUS_DEVFN		0x140
>  #define IMX94_ENETC2_BUS_DEVFN		0x180
> +#define IMX94_TIMER0_BUS_DEVFN		0x1
> +#define IMX94_TIMER1_BUS_DEVFN		0x101
> +#define IMX94_TIMER2_BUS_DEVFN		0x181
>  #define IMX94_ENETC0_LINK		3
>  #define IMX94_ENETC1_LINK		4
>  #define IMX94_ENETC2_LINK		5
>
> +#define NETC_ENETC_ID(a)		(a)
> +#define NETC_TIMER_ID(a)		(a)
> +
>  /* Flags for different platforms */
>  #define NETC_HAS_NETCMIX		BIT(0)
>
> @@ -345,6 +352,98 @@ static int imx95_ierb_init(struct platform_device *pdev)
>  	return 0;
>  }
>
> +static int imx94_get_enetc_id(struct device_node *np)
> +{
> +	int bus_devfn = netc_of_pci_get_bus_devfn(np);
> +
> +	/* Parse ENETC offset */
> +	switch (bus_devfn) {
> +	case IMX94_ENETC0_BUS_DEVFN:
> +		return NETC_ENETC_ID(0);
> +	case IMX94_ENETC1_BUS_DEVFN:
> +		return NETC_ENETC_ID(1);
> +	case IMX94_ENETC2_BUS_DEVFN:
> +		return NETC_ENETC_ID(2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx94_get_timer_id(struct device_node *np)
> +{
> +	int bus_devfn = netc_of_pci_get_bus_devfn(np);
> +
> +	/* Parse NETC PTP timer ID, the timer0 is on bus 0,
> +	 * the timer 1 and timer2 is on bus 1.
> +	 */
> +	switch (bus_devfn) {
> +	case IMX94_TIMER0_BUS_DEVFN:
> +		return NETC_TIMER_ID(0);
> +	case IMX94_TIMER1_BUS_DEVFN:
> +		return NETC_TIMER_ID(1);
> +	case IMX94_TIMER2_BUS_DEVFN:
> +		return NETC_TIMER_ID(2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
> +				  struct device_node *np)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct device_node *timer_np;
> +	int eid, tid;
> +
> +	eid = imx94_get_enetc_id(np);
> +	if (eid < 0) {
> +		dev_err(dev, "Failed to get ENETC ID\n");
> +		return eid;
> +	}
> +
> +	timer_np = of_parse_phandle(np, "ptp-timer", 0);

struct device_node *timer_np __free(device_node) = of_parse_phandle(np, "ptp-timer", 0);

Frank
> +	if (!timer_np) {
> +		/* If 'ptp-timer' is not present, the timer1 is the default
> +		 * timer of all standalone ENETCs, which is on the same PCIe
> +		 * bus as these ENETCs.
> +		 */
> +		tid = NETC_TIMER_ID(1);
> +		goto end;
> +	}
> +
> +	tid = imx94_get_timer_id(timer_np);
> +	of_node_put(timer_np);
> +	if (tid < 0) {
> +		dev_err(dev, "Failed to get NETC Timer ID\n");
> +		return tid;
> +	}
> +
> +end:
> +	netc_reg_write(priv->ierb, IERB_ETBCR(eid), tid);
> +
> +	return 0;
> +}
> +
> +static int imx94_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	struct device_node *np = pdev->dev.of_node;
> +	int err;
> +
> +	for_each_child_of_node_scoped(np, child) {
> +		for_each_child_of_node_scoped(child, gchild) {
> +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> +				continue;
> +
> +			err = imx94_enetc_update_tid(priv, gchild);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int netc_ierb_init(struct platform_device *pdev)
>  {
>  	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> @@ -441,6 +540,7 @@ static const struct netc_devinfo imx95_devinfo = {
>  static const struct netc_devinfo imx94_devinfo = {
>  	.flags = NETC_HAS_NETCMIX,
>  	.netcmix_init = imx94_netcmix_init,
> +	.ierb_init = imx94_ierb_init,
>  };
>
>  static const struct of_device_id netc_blk_ctrl_match[] = {
> --
> 2.34.1
>

