Return-Path: <netdev+bounces-245610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E09CD368D
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 21:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70DA730014D8
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 20:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFB233D88;
	Sat, 20 Dec 2025 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHil6NDy"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C110A1E;
	Sat, 20 Dec 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766261923; cv=fail; b=F6VuF83pQUKrd5nz53Buv1gSh/WWamBv++5AEaP2aGb7g1kKti+A4lk4V9jThK/w77Knkx5Y1sHsYyPY9jyBfFSceYNWEvt+s8zYrrUC19NVXinMSaM9w1x6ikDky5FRRxo5plR/Bqh/+ZWQ1fE8dT4w1dBDChoKYIBJGVZoSI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766261923; c=relaxed/simple;
	bh=sYqpFntVUJIbCCSdKMGw5tJt2vgIDHCcg4cs4uyX70Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zyl5rFIHuAYNAme5s3PB5fyWBx/7VSGn23LMPrQvIv+1CpbiqE3FdJrIlc7rSXAh6zRJNRjDuq2Jg7/1HaRUvrwkrWxjxgRW+LGkTrXejvQAfTNZt1rLJ07E9JSB/gfJr8LDOd/LbwTEJn2wFUuzkJ7kBH16R8k816A0c/53y2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iHil6NDy; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxDw5fvwChys3HpVA2J/t+WPvVCc6tBqbdxj9xf9hHn3wIzQ9TB+eEFHLLwXnyb9t27fEdWblBgNGenayz1W0/GovkdlMd/EJV5SCusnGeJduKQjkLccklk5ABewZdW6srBQ0P1wlKjdycf4duwtcABHFxNXJM3IE4BrOiJR/btAO0Y6F2S/yiVJNIzxmcbN5X4Fe0gcuxzOruGbbs/ovssGZT1UUBklZZqFb/AKYvJCGEecfOV51C39BIWDMU0+J5X4OHZvIQP9QqtKkG6UPXdrLsvo9F+HiJMjQcd5u1MOWqLO4YcoyEyU2r5oaZWw1aSqGe5rlACxA35JyL7yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77RZhcFljqO/0I0KzTdsar1khuV2xq0Q+8Nf3ui+IAY=;
 b=GwEM25ge2GtUN6ISxW0rFKeAkUYc9m3CLaL6siFKkMIKYZq5297kqrJe0HsxII9lQnQFnc+QNj2+rb0lztR9++Rs4sCOrtvGNWC3SJQIFhR0tJz2h+s+580a9ERu0a3fQpzWtifj1KeZfmlnCwfgFUX89jfKx/1xgYtHOU/oGIOSSRKD2rjh6ACGFd6itpdob89yyBpnDUfC+KVJbxrTDhW8AaeA3zkRrJnccp1ixj3rgSSXPJb880uWQJOw0d1wLwQ3ETX5/p9KK5m06sm7QJbZ84piv9azpl0RYSao9tRwdP1szDz5OjwN+tuO9pCrVW/PJjV5R5DopEo145svWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77RZhcFljqO/0I0KzTdsar1khuV2xq0Q+8Nf3ui+IAY=;
 b=iHil6NDyvlS+CiAg+cUb2bIdVp4oxeqZ5F9ztwccC8gK3cXGk5/p6+5UYm2Gi4e0AD251QI8EXtbUyuIfOppn8qmEJL/vEpYpO6jO3iLIUFYOXa0k1l3jYasJgfAnTW7mfbY5OHqYAcVvh0RDKAexhcvl4Faw1YPiDUD2Jale3GZA0wZPOaHVWB4HYmsagJFJ+eyRoUvkT95vWlQE4gyLpDflqhlPXbWvZ/2+i9zNCAN0v8gokkThbpqrpulWvoy/2OVEtgHqp31QmR8LhmD3R3FgKTrKUIfTDaRf9Tgk5kylorBDTZYNkEab55nZgSTNvsyOT047hQgq19hp/fx3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB10324.eurprd04.prod.outlook.com (2603:10a6:102:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 20:18:38 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 20:18:38 +0000
Date: Sat, 20 Dec 2025 22:18:35 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: do not print error log if addr is 0
Message-ID: <20251220201835.p56yu6birhfv7we3@skbuf>
References: <20251219082922.3883800-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219082922.3883800-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR06CA0179.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::36) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB10324:EE_
X-MS-Office365-Filtering-Correlation-Id: d5167bf8-ab3b-4712-48fc-08de4004f602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zR95wv13xVVK4r92w+fGAgzBEwYmyljfty10r4sNeaS+WypTsu7pfDma++tY?=
 =?us-ascii?Q?VBfMtGbqFhI1t3ZFhmzDgoaP3hsnStPfAiPulVvaaABQ3k55q3+pY6i1uyeA?=
 =?us-ascii?Q?1GGWjivJciq5W5SW5wtRaNIAPH2d5vd/HJek7XGBv6pvEwKiZVkq5m3zOfVB?=
 =?us-ascii?Q?3OMs3B0BPvBbWhORbXmoBYCiIl4I/PlhCMsniTEgsvHqy754/CGX9e0Y3Fpz?=
 =?us-ascii?Q?sI+P+QOMVHzGK87kD890qBNSU4dIx2hsrB62hNMgtfpJ0Yw1RduU+q6x9UTe?=
 =?us-ascii?Q?LTywqisHvXlhS9jmUMF25YbPmwH5Cs+dykIOekKuf01FxF61ddCrqMxpHSjl?=
 =?us-ascii?Q?D5/Y0YROBiA4/bsSLQVxWC+5tmhOYW7tPe8kRCm3tmmff4JUMtTLg1gqNyLU?=
 =?us-ascii?Q?NwiY2J99/lnBYVCciewfN1twbGtPOtCZg3LKI8qvsu8MvhQ8PdKelrUXgZz/?=
 =?us-ascii?Q?JYlI2QWHY3JbajhXfjlCcmEvR0M8t02CdrNuHPa9isxAvsFw9rFwvy/PwRnK?=
 =?us-ascii?Q?qDT4i8RLgIZJuyx9GnUEc2n5qXu/eHEHpzwkPPaA6AaalUS7AaT+YpveTgsy?=
 =?us-ascii?Q?FimyifrsfBvk2GaJJNjSRWyE6FaJ49VQ21dcQOLbA0RYzad3G8ieUiwkyWU/?=
 =?us-ascii?Q?u6nhTICy/u/FKZiV/8Jwa2l7F0hpoxHlquxerEruJZo7AUyQE0PXVO1gnoIE?=
 =?us-ascii?Q?igMntD77gmCEwKFHgGMPnbVU6tEzo3KdE8DkNBqiNucqae5wO0I9CPPqCuPg?=
 =?us-ascii?Q?O1vjg7+Rh2yt3QT7wgBuZ9GhiAsDcdhqZiAs/sXnwva48O0a52/b/7SV9+Ui?=
 =?us-ascii?Q?P7qSHZT3QImUCgIxuvnT1rqbGT8MaFzRgR0w33HXo681X7vxBKni9iZGbl/t?=
 =?us-ascii?Q?J49xg0/j/OynZUR+4jgD10UoRPrvNiwII5CVbz22ragR5rBdtB5RU6flTEOV?=
 =?us-ascii?Q?Lz/ah0XZ7Zb1vcc4fmdUVeeDVGSR43/KBIOOwAO/5fS9S4rKsvuv4LwGXnoF?=
 =?us-ascii?Q?NBp9NbNxQ1pIj8Qsz/zvnuV6+dnMoT0zQ7hXdVamAEscDd3QnV7eQrcYzuw0?=
 =?us-ascii?Q?uTp8Z/gNVgFnnK5BV96z8bLjq3TE5P/tVyPKk43I3Zp6Szq4PJReKsrTohGZ?=
 =?us-ascii?Q?XfxvnVUadw/Cb1XwfWSfsRUuuDPLerem8rHYLp9lFutQKYUtN0hEfwNDA4ID?=
 =?us-ascii?Q?EnukwoJertmbJ/ePSPR51UljH0llYR2AsHreVedP+Q7mjbwgvUGnVLtfHMRO?=
 =?us-ascii?Q?vpbLfxAgNCAx0SduyOH0n3ASNq4/3cxQcOaNGXfZ0adXAJTY9rtjBPBBhHht?=
 =?us-ascii?Q?3HfyZ5hfOD6DwXfTbcthMrU/7yf3B6uE29IhVn4ppz6FvB3PIhpTt0MFaH4k?=
 =?us-ascii?Q?gz2wiDPI4nGlffSlbzqrI6bkazAyJu9DUDtrBeleI04rnH2FaYa8+Zm3SRMG?=
 =?us-ascii?Q?BWozWQX1IyEmOAi7PZFs9bFa+FGa+Tat?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQ0whWFcrD3VKzvvX3AroS55hwuVUTznHijUTjvs1iyTvMoLQqIb/2xYCuZM?=
 =?us-ascii?Q?ZGD0WR3iRg6A+Kkd37SaRg4xzxGR67peGiARlYYbAwDKSNiNdBnTUsenMMoP?=
 =?us-ascii?Q?B/97sFZsB3OhtausIva0GjJFGsj1Ma8ogatBqa3aYCvAwAVQvbFrH8Fa7h4x?=
 =?us-ascii?Q?Cwr2SL5jaAUhoOXOUppglmZVpKiwPlaGIWCscdLdsZzDjhSVXpL1pmuX6GpM?=
 =?us-ascii?Q?0FuqQvFPjhYsboIEaxIFbgMyiklmMjzbHAMAQR3Ku6iWoRUKGJQUnz0CBmoL?=
 =?us-ascii?Q?bk4GNf7kPakCDLgeWrBTKbIt9KMCbaPndvFfTbVWU9EHW8KlBSP5ZEGVqPHh?=
 =?us-ascii?Q?iv7c5Y9X+lxKK5ZY/zNP530KK4xt4GCI5pIN0G9Wi7j2re2PTfPIuk3Lx1uZ?=
 =?us-ascii?Q?NG+Bg3D65U60JxBcKk5Y3Cds0yGTipH3GSLUARPiaLBYKub08fiYCnyHiXJu?=
 =?us-ascii?Q?gcHCOuS/YNruXuKcNvHvjsfcfkhvMvpRufCRbGvDKDUM5dB1rqqWjTca1yoD?=
 =?us-ascii?Q?SZt3p8ji4myZqhO61RS2xq/UCryAi1ahstgMOGa/rags/X5tfORWzi1KnCzV?=
 =?us-ascii?Q?GS/VmejMuR05gqHZ7q4p4FK7CgHcO7KfOd74BquU9W/H9np7R8uzGRldKdqo?=
 =?us-ascii?Q?u/6SgDKQeDYjs9WUukH3iRIG1YsgP0EHx55KxObEyb2OQV04XZXygMoqn5xQ?=
 =?us-ascii?Q?GoX7Gm78JcaZqrRg4bSO31r++kyWVT5+1xAG68VQN6vZh2orNQDPgIeJJpUp?=
 =?us-ascii?Q?35k1U4WOoSxkb+Iy4l+C3Z/ioSdxRzGf4y5SHHIrVx77L335s1EJBjcYt2gT?=
 =?us-ascii?Q?vSz3PYlKryrYTBBBA72oZQyOQgT7Q6QnizOFxqYnqw9hH9wP0AXvl3eMEofF?=
 =?us-ascii?Q?sdyezjkwfpsrUiIjf+Vr+vQGXOPTAMZOxNC+mBY+DY0x02FQU76e7Qjk4UAo?=
 =?us-ascii?Q?FBpNlDrsqqBfIknfDayt5rX0tG2NFP9uwsgd0tDW+nOsXu9Sw7X1cSlPW2xu?=
 =?us-ascii?Q?dwLV+MT/i+NBxPOxoGV4STRSR8WZVaA/FvLbdJUDEfovtHE3F3FRGenRRRXx?=
 =?us-ascii?Q?iloUX8EmkBw3dPAdovqWOjPIDc1FrDWKIEqR7l5/byray/k3eeujddByMaQe?=
 =?us-ascii?Q?YUFoNUEwEdc8Y0CssySDy0UpoaMb3htAJXsvaLy2I8a+3gM0xxYT2nPDt0dK?=
 =?us-ascii?Q?NiWpfCZ1SkTkvWPf1pIcDEUMnI2TVVAanQGzqRgPQgNk0+TPM5GPUX9G2l9F?=
 =?us-ascii?Q?LJmKPdzsWTKb/1A6xzqvMT87xeh7f2jBKWQtsv6ddU4oaLPyLBdc1ctQuvq2?=
 =?us-ascii?Q?ZzShggbx9e5cchfVGtlBwViInz+QIoOSCHUuOoOxAK91G70CILSXZ9tRny4+?=
 =?us-ascii?Q?tM+6J0iZPeR6zDBrc5C1mek/Qwfi6FODBKjl7hRTIuwTho5xLTF1IYElhA+G?=
 =?us-ascii?Q?N05ARzIf/TWpt1ftThOB6aeZaRMrmIpnEGUw7LHscqFK92aZaumhN4s8Fc0K?=
 =?us-ascii?Q?VBH41R1rpHv8N+bJQU4BNTQGJtsdV5Pqtce45WF0wX9UkNjk+qea1P2DTgcD?=
 =?us-ascii?Q?ujmz+S5if+B/QQluIPxMHTOaSfJ5jYMhLAVj30le/Upw6fZU/dA0I5Teg0n4?=
 =?us-ascii?Q?JY1eq29N6WpTMqb+Wx2qtK9qvAqFBgjPuHUHegbv8qc21IM3HJVDsClfUu7w?=
 =?us-ascii?Q?frAWs+WXv7MDOhA+Qe2755fKqs8sBCi0gxRmG+ZWEP/iZhGACv2lftWpmGln?=
 =?us-ascii?Q?ZPv6A4Gy/HRbJ+wb17SZOcWxOqw90+Dvut7wRIWCuYL268Tdq/3wNkilb0rZ?=
X-MS-Exchange-AntiSpam-MessageData-1: wQJ63Z1UiZLBYrmwdct1t445Hh1FSUr82JA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5167bf8-ab3b-4712-48fc-08de4004f602
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 20:18:38.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpDGQH1Gu82rPi5wvk+P0UbW4fiMDPuJPZsYdcBIrpnpPEuUls0n6NJadGcIn5MkGGbnX+PrkVAFdi6B3V/DDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10324

Hi Wei,

On Fri, Dec 19, 2025 at 04:29:22PM +0800, Wei Fang wrote:
> A value of 0 for addr indicates that the IEB_LBCR register does not
> need to be configured, as its default value is 0. However, the driver
> will print an error log if addr is 0, so this issue needs to be fixed.
> 
> Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.MX94 ENETC")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index 443983fdecd9..b2d7e0573d32 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -578,7 +578,9 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
>  
>  	addr = netc_get_phy_addr(np);
>  	if (addr <= 0) {
> -		dev_err(dev, "Failed to get PHY address\n");
> +		if (addr)
> +			dev_err(dev, "Failed to get PHY address\n");
> +
>  		return addr;
>  	}

Can we please handle this the same way as the other netc_get_phy_addr()
call path (from imx95_enetc_mdio_phyaddr_config())? Separate tests for
"if (addr < 0)" and a later "if (!addr)".

This leaves the possibility of future refactoring to make more logic
common, and makes that refactoring obvious for anyone, not having to
think whether subtle underlying differences exist or not.

>  
> -- 
> 2.34.1
>

