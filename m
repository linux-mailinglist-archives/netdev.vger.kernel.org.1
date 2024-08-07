Return-Path: <netdev+bounces-116536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59F94ACD6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F9280CA4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E8312C474;
	Wed,  7 Aug 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GMH3juDe"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74212C465;
	Wed,  7 Aug 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044364; cv=fail; b=iKPJTLLbx1NipYwz1fk8lBx7BUsrD9A2+rM2hs6Dwqwp2S2wu+GcYQXbbRMn3p/bF4jxO2QMV0t1c1RtbEDw0SD5CgEP5P64/w/X8Xmn1LlvmOx42p5yKUglDRDU7DOhpGUlllxJzrjJJG6W8/HYxJ6MpIZWqx6QslE1kGt2Wus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044364; c=relaxed/simple;
	bh=0RRIy0vcOL6S9zHKrQlXvtj9LF+AknonR//hXzYgV0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEH4b2p+xj3LMfIRS3LMg1k6ptZV60fBbZ6r2ocJ3Xy337BZmIi+I38tejBDNRbx85hHf1Z+vgXgaqrduXcp/Od5l/D962cngr/gZZ8evAJeF6MOd5tJAYEv/1/yUBwTEFt1L+xtzFNg4yhliFfsPHjESZnn41ZRrT7+Z4GOzVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GMH3juDe; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR3Y0pcSLUJHv3ae+IKoGA5STSVeFZeVJfANJsCIh6iV5wN0qh4cHKZbedF3IJapzR9s1K7lzQw6X/to1qIm8nNJ6rY3L8n3SVYP/YCZtVXFh+Bdz1Nes1SKC+Fn9vLEaPdek1PNzJgGrTM843UcsOpXKpwuCnD6iPXAXk5ReNCh4tI3uswxQvOnV/im1vXSwbbMVApEM206sdS/cAYBSwTrIeAtlQNNqYhGn7Ub0N1Eiey368gDuoBmJAPnnNFRDuScRCJuKaM0upxpsEjbSrDTwBCgj3F6OaIPWExphW0d0JSM6YCzIVOBnAolCQOKGAoUMp2A6q4o+OgPUwbKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ObibVQy5TjeGG6O2g9e4PY/D1FxQs3Dj015JfdpXpo=;
 b=jTLWuzyfG2prWhZoMUk12LpyLjnjSxsXCg2fzzMX5nW/YVbrO5Z4XsU3uX4I3zpjqDfA4mj2WmsSO6TXKqws2PECeibEIGB7uUkXt/ChrAzKFQm6D7By1J6+aUh34qs7FmNfRJoWY4OLpDUtiIIis4dZPXMOs+myLOE/VoED+3Z9pN2NMPVz9aAxqjv2bv0zrSJg9CW+QJtOfeWufzVI4XcJWsR+J0b0p9od2Uj38GYbO8kJoSZ/M1TVXC+aMm1HVAaXnrmX3O7K3571dhLCh9Rlv4NOrrO9zysyAiWLL+kEOQKQE8GjrkzhlUzBb4FM9sKfjcTYJ51i5Z5uZo2TDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ObibVQy5TjeGG6O2g9e4PY/D1FxQs3Dj015JfdpXpo=;
 b=GMH3juDeBviu59Udfsv+4TmsF0GEjXCfSy7sZ/BnT/4sknYrDZ5vkxFNpThO9WF8Z5snbGifFGgjv21PcACTwP2C3DEMPsi8mFokP/3FIWRl28GdvnY0KXK0IyY10xUnG48G7gi649b2wr/nTqBEk5RuxGsqECbnjWKSxuNiypeQz/QRaejiPIcM4jwz4bar9EkQ4rG9dO5bAynVfjkAvdesMSnQn/x1SCwTx8xkuX0lp/510e4wCWAR1fxFz0b8MSr17rI0Nd8TajoWosFxmTjJEckRJyNB2yM8vjKNc9YuYX1wbYjVJuWHY1/N5cJyOnUZaSZoOs2iLJnfbo3J2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 15:25:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 15:25:59 +0000
Date: Wed, 7 Aug 2024 11:25:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] net: fec: make PPS channel configurable
Message-ID: <ZrOR/eqZgaYxfPaL@lizhi-Precision-Tower-5810>
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-4-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807144349.297342-4-francesco@dolcini.it>
X-ClientProxiedBy: BYAPR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:a03:60::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7ccdc5-c23a-4850-2b69-08dcb6f53d39
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?3nlQKPxT1JI+/Gsvak7/HJljbpJy50C0AxX0ovlK7QW0hr6fdRebsehZeMHM?=
 =?us-ascii?Q?zdBNRXibFSu6t+LDs3t0XrcB1BpWq1/KIHrsdA/zGBbJyZKC9uYr43d0qL5B?=
 =?us-ascii?Q?/jlRpGMjRJFyolxaP6liYeLO4hsEirAyDzFjYqepJq26w2ZQ6Lb9LTLYeNFI?=
 =?us-ascii?Q?ve2jlWuzBWY3gVhASNeqAgb3GE9q/MJVOaqJT9OFN0Vhyoe68UihhWWi8j0i?=
 =?us-ascii?Q?cDELvjODIhnm8EzVzzbXGvACI1T+1rsuCVcGairkFunKCIFo4HKS3X217RJs?=
 =?us-ascii?Q?sbRlA/trlCjPn6z2HMKpPPtWuy6ET9lOVFz73ZfZa6C6jnTi3iXpIJDs0ef2?=
 =?us-ascii?Q?B/F0IxJVCH8/ffC4nYhpbD8uCgYdWv/oPuoBOlH1YvigycLnzs3m9WRVX9QC?=
 =?us-ascii?Q?RtIuak9FwWnaG79hmvHpLXcySSp7THO7wEMsduYt99KAcf2lV12jbxMvqja3?=
 =?us-ascii?Q?pZhKErK8hJ9jj1sooeogt+MeNtCGEvObAHmfiURP71sBpfubgPUF6lEszdCm?=
 =?us-ascii?Q?JYQZE8mQJq8n8GvE/qNxXVWjDzvvXEEkM6jfYH3IPPV+usvGNxE22u1HBqf9?=
 =?us-ascii?Q?HN7fnUUKQxAt5Z+BonBB7hNxcqeiafT//5r4a9F2is8kz6sgAmdEtbYuW87K?=
 =?us-ascii?Q?Y5VC/qJHlK/Xgn4jGNPdV0ea3Tm4+ASvoX7domdfZnhOER84CsbiTHvJkE8U?=
 =?us-ascii?Q?BOVlwpMHXyAWQ44AiYLfT+rxCcPruo9RfUYW3y1sOePQScgQmChqDwLe1D6b?=
 =?us-ascii?Q?C8mXAH9SqAvkv7Rg33FgNy28uc9vkAaWMSLtSFy7menUSlr59qQbaYX5hdKX?=
 =?us-ascii?Q?1l29pW56Iu8IDxZdqcNz+GEi1k/od9ob+WARls8OFqxEdtyeuInsgYw0XikV?=
 =?us-ascii?Q?RsiCzDfQoeJrfUFCiem1CRoV/iUwLJUOuNx39UyIlWvo+5o8pk1TiN5t7LLf?=
 =?us-ascii?Q?KN3CZc76QkzaJvm9H/rDALzKBoWEV2fl/k6uBvPRMuOkL66bnvFfX1w6rXXA?=
 =?us-ascii?Q?AzVuZbfVYa7jWGbWXoMo4f3xKkeR5p18OntMvpqfJ7/jFRVVcpmaj1niPigd?=
 =?us-ascii?Q?Y7SKMeE62NisYOV3hw9GLD0A8WAFfGft4pfsyLOYf+IF3fER0uMLSHdXTmYa?=
 =?us-ascii?Q?ceezN5iH+Mh4HytJDSRY6RtsQDyi4FkH9jKaptO+Jgd0V+ea94QVP+B0b9Jb?=
 =?us-ascii?Q?7FOiT7MmKNUaRjQafrZHJ4h+L+dc0d0btOwvpa9ouIRjrlKe0lQ08Ck4P2yz?=
 =?us-ascii?Q?b/wOTtxpPEE0jQlKytRKGYMWc4yBLhM/bY94tw7A8NTgSTjhQda+/nVb95JX?=
 =?us-ascii?Q?XAMOt4OHvsH3EVNJRAjU/JkBpJ1eBxphSA6+IhJPXyuVS1nTvvS/GemPGUUf?=
 =?us-ascii?Q?jcujD0dg9yuyxM2UQv/mT/CgZhDzKYdRGlzVxjDjyXyUzMGHaQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?PUPwVacnV5KDxrwAHRyuwD3xgPxhi17hoQ5rJ4NiQ0c3+n1XKJwpWxzUDc9h?=
 =?us-ascii?Q?zhtmtI7pBsroBEhteQsOEp0vt2eM0B+n4H6OfZq5VOg+FP5TmETs/56bKhOn?=
 =?us-ascii?Q?tBKIB8kiLTHEZ+n2JEQDFRo9WRNa2tYTWDFNAOIr5KUX39bjlERM9U287Em+?=
 =?us-ascii?Q?6w7ocg9T5uw2DA2V1ewD5uxowjAHXEtWMHLE6v22CHMX0+3dmfX7GN+QbQ86?=
 =?us-ascii?Q?wCThaJWTFbxetxUSsvlAj2hPhK6Rwv6v/LqZ/acdwPomBExP+Oz0MzWWxEbJ?=
 =?us-ascii?Q?NvC4TJXlLwIuRcFTubRW5FtEzABO45ZshcqKsFHHickEZrge2HUSdHoKl0eR?=
 =?us-ascii?Q?vffuH/RvXwyZ1+kSBhQIPKjndACL2Jgh+hL0IjFIopjDSW3w9TvrekKR/OpE?=
 =?us-ascii?Q?ZNU1l+r1S3f8jiZbkJ1A9wE0pUiLvIIBoQxaqJtBpYZvstauAv6y6tviLd1n?=
 =?us-ascii?Q?tQhbcTIuJNWxOx+kUVSsXFdjZeBFWsXN/7Of3ydz3T294GCBDJrnw9iDynEQ?=
 =?us-ascii?Q?ldq/SW2vpkNMRsPQTIn1wVcvmm3vErmIFgVVCbM3Kg3AN+g3ous1UzVluJEF?=
 =?us-ascii?Q?MkvKDts/5i9ii1n+GaPzkGAsb6K6zoCaEWSiO/NYLw2quGOGpbMiNuio+mwV?=
 =?us-ascii?Q?zncg053Ljdg49H/IX8QhgRxioo+8yJGEe2bB2wrp6g4PnGMDH6O2mk3YHoGs?=
 =?us-ascii?Q?uk4yephp6ynshxZWL+zx08iE3TqOf/GPlSL1gBA8VFQp2yfWGoQgQF7EdtRz?=
 =?us-ascii?Q?imqLSlUTNfhAHwUDnUMGPQzvjr60hvpHKL8h82TIiU3QkWZ/b4+5Qq4kq2Jc?=
 =?us-ascii?Q?WZyU72djNkxh+KZgi5dillbWUti5bkLelmHV8Lh/79BSS40ORWqgvZ3Zi4lz?=
 =?us-ascii?Q?t3aZPwnmbplfc5pikSC0DwvozO63lrt2B7i2Qt3Cu5t1wDExqAZrc4gvCNyU?=
 =?us-ascii?Q?SIRkisZDv2VQmgBCXL7XyzTmygrqjypsxRmtdQYVx7vD0q8m/A+i9nGt2iRT?=
 =?us-ascii?Q?DROyditkdJNF0pB3IdgdqRgf/TnD7j0pAsWrSSQhFVWmbdYGWiFKjXLxF17h?=
 =?us-ascii?Q?egdoE2jYUXKxgPkHbIt34VfxA9Rq62wLRkjdMMAtwputdB33EEx6cKb3Fwyj?=
 =?us-ascii?Q?mIX8afVBI7XQMKwvjdYWr3CWT1lT4yF6M4yzLGL9PvyETB+1V/opM0qPJk02?=
 =?us-ascii?Q?CJ3f7OSMTXL+wuaiI6BwtkAAniM04v+7MjEYRcFBmUnrXMxqsRHTAu97cRBm?=
 =?us-ascii?Q?1iDKyfOSX8i0idn2F2yC7GAxC1acMS9QuQkmsMRkmCCV9phSZ4l1vi8m9RIm?=
 =?us-ascii?Q?7UyUgMYZTS2CAfSP2EvIuNlVYN5tdryXiPR/B1W0BYgy1n5b+7NyDevotEsS?=
 =?us-ascii?Q?mASFWfLcDkgc+NXGb9Im1bKCuoYX6sx8A9ajC4kqgG2dDThK4emqpzOIM2HD?=
 =?us-ascii?Q?QYu6KqYqcPnvshKjTH4miKkFaqMzufk0PsTo3Cl81F2WmAszXf92sIZfvpjw?=
 =?us-ascii?Q?Memt3NqkA4RibrP9xlrWuheBmqsXASoYAmiJ2VHlINPdz45ocrg5qB1kok5+?=
 =?us-ascii?Q?VEObKq7VEGyDwA9pHSu+WsAOofayoXlUi3KQ3+Wo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7ccdc5-c23a-4850-2b69-08dcb6f53d39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:25:59.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qnq8SkEI6sMHzeBON2N+uwdRYYC9GSIQZc9fTRE8Yyh0W8TRcrwg4PoxbcrHTiE+e3ksR0O7vQKTMqRi7/xsfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

On Wed, Aug 07, 2024 at 04:43:48PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Depending on the SoC where the FEC is integrated into the PPS channel
> might be routed to different timer instances. Make this configurable
> from the devicetree.
>
> When the related DT property is not present fallback to the previous
> default and use channel 0.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 6f0f8bf61752..8e17fd0c8e6d 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -529,8 +529,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
>  	unsigned long flags;
>  	int ret = 0;
>
> -	fep->pps_channel = DEFAULT_PPS_CHANNEL;
> -
>  	if (rq->type == PTP_CLK_REQ_PPS) {
>  		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
>
> @@ -712,12 +710,16 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  {
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct device_node *np = fep->pdev->dev.of_node;
>  	int irq;
>  	int ret;
>
>  	fep->ptp_caps.owner = THIS_MODULE;
>  	strscpy(fep->ptp_caps.name, "fec ptp", sizeof(fep->ptp_caps.name));
>
> +	fep->pps_channel = DEFAULT_PPS_CHANNEL;
> +	of_property_read_u32(np, "fsl,pps-channel", &fep->pps_channel);
> +
>  	fep->ptp_caps.max_adj = 250000000;
>  	fep->ptp_caps.n_alarm = 0;
>  	fep->ptp_caps.n_ext_ts = 0;
> --
> 2.39.2
>

