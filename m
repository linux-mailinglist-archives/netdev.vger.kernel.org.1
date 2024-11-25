Return-Path: <netdev+bounces-147251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE389D8BB3
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1562865DF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3E1B6D14;
	Mon, 25 Nov 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h2sxGSBL"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052301B414F;
	Mon, 25 Nov 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557303; cv=fail; b=SjmlFOfEWBuqAkPqv9qPXjyQOaepxUF99EbFRmJIXWHWtIOuLwRgE8BLOnqRm7++70JlpmtBF/aSAh7CUyKshyxIPGS6zo9p2e16CLntYdY7y6YCo1oRmWlKh8yvaW10hPDtF9PKdqn4l2IlSTOni5Hkr61xhmcUVVi6w0SfB2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557303; c=relaxed/simple;
	bh=j6FlPcSGpU07hasCvCQ2IEtEyk/5tjUvDZsj33XdCuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SKq6Iww6Wzjb5yR9yY8HzLkvG6/ssqmiUn+t45ngzzvQIjRetOJOtxdFszZEetHf6axxeZ7dKgaDngQXm1XfpMdu6ghbacyLCODSYQCgSQqqNhOy++M4CRbNuB7nCcQ4NJEUVh679RDxMuZrFGnln5KUUS2Qd/iJUS80/tdlfok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h2sxGSBL; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlDBm/ukK2Rivq0iREE1i4BxZhECRh/RfTiLYopFE1uaAeUDgzsYdqALSDODqARDh6h3N/pe21jJsNxprHd+4YrpKbzDL0P7N1nV+VZydgLWbRHtnvu1pLuJEdSE+NrX+0TQYxC23hZqIqrsYQry7fRBRn6vo+C7yNN6DteFzx+R4JmsIDx1Xf/rQk5sLKuEkoLmJr/gNsLUZ1cw13o6+oo5Dh8zi7R5zHOIxXinxfHRgonxhExVtcqHxb162LHXFJ771PCPxGO85rWiVUCCQ8INlydkDzez9GNj2YAcCz8vlbsIc/riT3qdu/39HaMD5yQUIsD8sGbxJT/MfF27Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUNLtVZ9GWZp+CVt7mAB4IWl4ogTIZsgEuID508Oi94=;
 b=t+OjMLYxLLOveavy0u9lkmUQnYebrX/fWn2zWvCemY6fU28tYjN881ASlapofs6n9UtYuErSDiI3y0mJ/uMw7/EGfvk1JvpgUsEXebPk/vdFlFTeggrrSzEvaKCjguBflsF3SAK1ow/1X0RjnHldoEkn/tbcHpkH0p6e4d/kB7QvDmkpJodl7Wh+wIHzKIL+b90WtIJn7WSpsVOo92ad+byehu5Ow2dv3RMMDeFitnjpSAy/zW5bxpUyziKyouN9Mri8fliGfd3VJezfYL7DKjYU6WbxgIWcmgsFODherQzMDoFQvaITHdIwSoi3urIfJaTjTuMRhUn84GR34OKNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUNLtVZ9GWZp+CVt7mAB4IWl4ogTIZsgEuID508Oi94=;
 b=h2sxGSBLexTcpyavuAhbfr/1XKpBeH68iIEVk10PTNYY7HCJtPdJn3h635dmGNRgTP6NtFch8k41CCW57aOJF+V8L4xu6WlOYmA6ZFidt5Q9R3TwM5Z9Ck9dplOLKL62wvoScIcwh51l8i5X9Vl/vEan5vrGnrGhuh5DOz4Nej03nYksbbF2wJJuThDOg0Mmj0Dj+5sqJGrhqosyUD/7EM6CwjOQwvN6z3CgIa1yK0tyYif/P84If0T0IROKP5NghSzfiumLqpp91pOei0aYIxM0/z7wa2V5U39cJ0HyZIp9hjAqO0FT0K3kkzJsXF/SAeSorOW3skNBTt+cAWLMeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7133.eurprd04.prod.outlook.com (2603:10a6:800:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:54:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:54:57 +0000
Date: Mon, 25 Nov 2024 12:54:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, florian.fainelli@broadcom.com,
	heiko.stuebner@cherry.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: phy: micrel: Dynamically control external clock
 of KSZ PHY
Message-ID: <Z0S56m1YIFEPHA/Y@lizhi-Precision-Tower-5810>
References: <20241125022906.2140428-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125022906.2140428-1-wei.fang@nxp.com>
X-ClientProxiedBy: PH7P221CA0047.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fabf89d-ec93-43ef-0d45-08dd0d7a4643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?57zRTAOJFBAEj7zoqE1mp010McLuwYTKSLvRkiGovL9IB1IhjokHqXUOpZH4?=
 =?us-ascii?Q?tZw6DXDuGP4+scLudMPmFVdrCK+TzFyQVBw6GDlUAbbIIqxlc5cfkj/Uhb1N?=
 =?us-ascii?Q?/cXvusm2edPf1QerT7By3/fM/6ymfj7rtMNh+uCyJmZHz+U6xSbbqUZw1mAz?=
 =?us-ascii?Q?gwB6wQh85MNy9mI6CyonedyLGKNuaqSDrpETr83UwCi9eWEnyw8oC0x5H0F7?=
 =?us-ascii?Q?/5eG5iEDNa/g0SUnCfX4SwgJ2qGR2t0FdzFPjk7YqC0/jZ9txTxS2v4mW3S/?=
 =?us-ascii?Q?CuzF2EUtbsJdaTNAFDLOiVtzbKqX+SdFY26QJvsUZ6QBRV2LnPaqOtEsaBvz?=
 =?us-ascii?Q?+1EVzTUrtpUQtFapvwT5f7EXHOFIQwOMRrkMTy203gtplhIdAsK4d4KG2iLy?=
 =?us-ascii?Q?60KPAXR7rbuEaHPAyu8ov6YgLyc+fE0wqMeIfuyi+UqXAtwO3TGBv3CGrCXK?=
 =?us-ascii?Q?XzfP43n5iusEGrLoD8bMGddWnpcXTOjx9dqdy1oqfP0uDO5K/KeSFWOmj2pd?=
 =?us-ascii?Q?2N05DK6suNXZxnau7BcgBacAbdLkShSiUZzhbznVir4DHm7+NtB3NFDk/JY9?=
 =?us-ascii?Q?iz+BOBoppuF8OQm5JMoE9wimylE9Ad93MVjNzLpExZGVepvIBxRefF8OGEWQ?=
 =?us-ascii?Q?1f5SD/OSIWLq7EFvo4Hl0pUoXwEpUrfaDFAHg+Np1ZQSErm8idvRwGsI6nU4?=
 =?us-ascii?Q?tVlw56ugk2PJ/+3M9V+/3P/prJ4hNukw0FC2/7Gdr2DJstveWjC1curL4tcO?=
 =?us-ascii?Q?ekW3ph0pT4fPP4PVN7CHetDH/CFZIxOZkfpEk4bTTCZMnth9EjMA28sqYLHr?=
 =?us-ascii?Q?379UstNo6FdeznA2EQ9zshtwiluJe3woTIoSE8L7WnEDX09JR62hxT4Howf7?=
 =?us-ascii?Q?KfgcEdYsxiI+AxRQYUZHqLwXUQkDBW0LKJEdRCL3xAoVWrrTieRhXDOBOIP+?=
 =?us-ascii?Q?c8QG5/XMAHpew7KiZBmGKuUP6gbD4XQrZ0N5dy7aVufJJiIDORPL6ZI12F1o?=
 =?us-ascii?Q?OC6byRlcXwoDZ5UOEt9/EyLd0znHR0sCFNy4WoJLZ78q7wiuEVkZaihqqsX/?=
 =?us-ascii?Q?zPMhe8BVoIl5StvGfIZfRdV00kLFxufqw+tNLwyLRflHoRD6EePx2Trwtn/m?=
 =?us-ascii?Q?hwGZVEk7ZY47uw36Fad6XyfeAOMKJf3k0x4ZoOYWnNM2ySBzVPAJgqKzZuNv?=
 =?us-ascii?Q?EbTgm6k5vWYYiCrcMFxlTYrTIjR769iEqtOVElF0j9aTW1+3QR+xQiBxE/WM?=
 =?us-ascii?Q?Y4Cp0WQIlK03AwgTjFwLyXG/8dx2BYZ1GmdL2+1N8UC2HuQjmzKA+J5/nl6+?=
 =?us-ascii?Q?HOhc5UD1u1NMvFzpC5M6XzMmvvWDXO6jnVaAuW1DsM+1prKpEuTY44iC15wm?=
 =?us-ascii?Q?Ym4l/Zga089KChTqX1i3lMCrlsC9+gaZHmYwPt8kNukEaFeRNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eX2aelcCPfXnJTea7hpae2/htZO8DiMnc/aE9TwLvFeDuBLT76bNH1NSFvEi?=
 =?us-ascii?Q?I8dnvHpJQp69AA8xFfsCIlCCbzqxSQMwc2v3idhMcx8X85kWth2tnvgKoDzm?=
 =?us-ascii?Q?UPz2ZthZOE8xs9PS2CvQEHDWubsnr9Cl3HFUTViSwCR9ucGMwxgUrlmIKA0F?=
 =?us-ascii?Q?U6xCVRzkKXr9wg+Yj2QflL675URxq6ZRZcTcz7A5gDUleQc6XSbEp2PHAFLb?=
 =?us-ascii?Q?EhCyx9m4HGTLzq1f3mYku0vtkvKol88BMVBUW3RFDbYs0pfABgxYS1Rl9Fx0?=
 =?us-ascii?Q?q4GtJOdUIEemmAmhzf5dkEtgKMqkeFOj3N6mUROcgswsgs6qRLSBsXJR0vTY?=
 =?us-ascii?Q?b+aj7624C4X2xdo30BpNX/nkvNCJpbIQJl6Dns3eQVcehVJDu8k7+HzPZgcS?=
 =?us-ascii?Q?uxt6dv9HJ9clPY7my8QL0MOq0TFY3xuSkUbIGSIKVRIQyAqZln7+9Cy8tzhF?=
 =?us-ascii?Q?aVRMHkcnQyvuO7NSZeXW3ilBjel1IMfZF9Nc/+n4m9XEhpfPh9q5A8D/b4Yv?=
 =?us-ascii?Q?xdAqVr9kcsujWCq3evEM6ZhNck1LQFl8NwVPtcBz2qHFve/NqQv/voolPZR7?=
 =?us-ascii?Q?87umVg4SqatTd09oXJreb2UPvO6mmaFHy0PefY0DkBx50+LfzG/WUBHmDJgh?=
 =?us-ascii?Q?aOMzgh1YFeN1caB4yCpP97fYbEstWgsNOdg6uOhMJHEnjSkiKXdpk0rYDGU+?=
 =?us-ascii?Q?yTj+YgzFbYSHxyhAOmv2TDn5HsXESktkr4/h4qOngnUwh/pEImMxFQkVCywV?=
 =?us-ascii?Q?fgoPWYiov722mzyYTjuvxbLVgCXenvkHaf4pIeF5uMJf252n9WSlAlcK6HtA?=
 =?us-ascii?Q?O/PEcesaI6VvWzGzO+ewwR1DaLSefeHUo+bSppnebt+MJi/EkmUSv6VDDowe?=
 =?us-ascii?Q?FfcoQ+YZ0abRxf+/+oXGZx9xO9+dMXn3K6TiZvtowf/vV6lf8LEkvwEzGUNU?=
 =?us-ascii?Q?z5UPcZEVhoGhMQMnBV5pouidZIrlupLnb46PJ7EThHb3yNC0jnlG8l1ggiVl?=
 =?us-ascii?Q?VIpIGIPpL3kLz2G5iZt6OMjS8esC41OLZoTTxdTi6B6lEpMUpMRP79nBNe5c?=
 =?us-ascii?Q?9TCjzZYQ7qeI9sT5pN4OANVXU1mP6IYTqgxhnzUX/HdkZ8JIyA1lMdb2Gzir?=
 =?us-ascii?Q?HZJAcoZFnshX0i1jmvWvXdJkNLZCfaviBVoJVgsZvILExCxV9GOtTcwzPHcA?=
 =?us-ascii?Q?FRkbUTwRJ0Amt/DXiHYdJEzFSKZchNahfYpekk0j96DwqFIpNn050TP5fbxY?=
 =?us-ascii?Q?N8yVnNfia/xAsWDYm8kYd8euEA75nGTuaE8GWocQQlEODChNPoOGMA2C0hDT?=
 =?us-ascii?Q?0Ud+H1G2jMh9LrnxQqD4t0pJgVzS2hTLvkNKcWBMPmVkJML1ggLRrIsKoZSu?=
 =?us-ascii?Q?xM4XzjnGorgVLNmSIe05+r09eFmQZBSzm6UfnhLBcDLLatzgUKDKLdvJcYax?=
 =?us-ascii?Q?RWlwWLwMT9h116PApMweRS3i8d945hULQ+SHxJp08daKwYXBh7cPaDs5mY3H?=
 =?us-ascii?Q?9ROwHuOc44zZUuq+7PHG8ow7rGvAHOH4GUck+b5pxiMbl5lQek47pHzXg7Fq?=
 =?us-ascii?Q?B9a7PodKEQyH0uNTVUwfgrqBY4qgCqC1aWIljCre?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fabf89d-ec93-43ef-0d45-08dd0d7a4643
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:54:57.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV5McTRDvTZEYZbjisMqmNDoxmKGLKbO3maZFCB6c03+2m+Mfc42UwlvnFunJ5QrjTJRm1oEiT0ipRndqm+YTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7133

On Mon, Nov 25, 2024 at 10:29:05AM +0800, Wei Fang wrote:
> On the i.MX6ULL-14x14-EVK board, when using the 6.12 kernel, it is found
> that after disabling the two network ports, the clk_enable_count of the
> enet1_ref and enet2_ref clocks is not 0 (these two clocks are used as the
> clock source of the RMII reference clock of the two KSZ8081 PHYs), but
> there is no such problem in the 6.6 kernel.

skip your debug progress, just descript the problem itself.

>
> After analysis, we found that since the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> external clock of KSZ PHY has been enabled when the PHY driver probes,
> and it can only be disabled when the PHY driver is removed. This causes
> the clock to continue working when the system is suspended or the network
> port is down.
>
> To solve this problem, the clock is enabled when resume() of the PHY
> driver is called, and the clock is disabled when suspend() is called.
> Since the PHY driver's resume() and suspend() interfaces are not called
> in pairs, an additional clk_enable flag is added. When suspend() is

Why  resume() and suspend() is not call paired?


> called, the clock is disabled only if clk_enable is true. Conversely,
> when resume() is called, the clock is enabled if clk_enable is false.
>
> Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
> Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/phy/micrel.c | 103 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 95 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 3ef508840674..44577b5d48d5 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -432,10 +432,12 @@ struct kszphy_ptp_priv {
>  struct kszphy_priv {
>  	struct kszphy_ptp_priv ptp_priv;
>  	const struct kszphy_type *type;
> +	struct clk *clk;
>  	int led_mode;
>  	u16 vct_ctrl1000;
>  	bool rmii_ref_clk_sel;
>  	bool rmii_ref_clk_sel_val;
> +	bool clk_enable;
>  	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
>  };
>
> @@ -2050,8 +2052,27 @@ static void kszphy_get_stats(struct phy_device *phydev,
>  		data[i] = kszphy_get_stat(phydev, i);
>  }
>
> +static void kszphy_enable_clk(struct kszphy_priv *priv)
> +{
> +	if (!priv->clk_enable && priv->clk) {
> +		clk_prepare_enable(priv->clk);
> +		priv->clk_enable = true;
> +	}
> +}
> +
> +static void kszphy_disable_clk(struct kszphy_priv *priv)
> +{
> +	if (priv->clk_enable && priv->clk) {
> +		clk_disable_unprepare(priv->clk);
> +		priv->clk_enable = false;
> +	}
> +}

Generally, clock not check enable status, just call enable/disable pair.

Frank

> +
>  static int kszphy_suspend(struct phy_device *phydev)
>  {
> +	struct kszphy_priv *priv = phydev->priv;
> +	int ret;
> +
>  	/* Disable PHY Interrupts */
>  	if (phy_interrupt_is_valid(phydev)) {
>  		phydev->interrupts = PHY_INTERRUPT_DISABLED;
> @@ -2059,7 +2080,13 @@ static int kszphy_suspend(struct phy_device *phydev)
>  			phydev->drv->config_intr(phydev);
>  	}
>
> -	return genphy_suspend(phydev);
> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	kszphy_disable_clk(priv);
> +
> +	return 0;
>  }
>
>  static void kszphy_parse_led_mode(struct phy_device *phydev)
> @@ -2088,8 +2115,11 @@ static void kszphy_parse_led_mode(struct phy_device *phydev)
>
>  static int kszphy_resume(struct phy_device *phydev)
>  {
> +	struct kszphy_priv *priv = phydev->priv;
>  	int ret;
>
> +	kszphy_enable_clk(priv);
> +
>  	genphy_resume(phydev);
>
>  	/* After switching from power-down to normal mode, an internal global
> @@ -2112,6 +2142,24 @@ static int kszphy_resume(struct phy_device *phydev)
>  	return 0;
>  }
>
> +static int ksz8041_resume(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	kszphy_enable_clk(priv);
> +
> +	return 0;
> +}
> +
> +static int ksz8041_suspend(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	kszphy_disable_clk(priv);
> +
> +	return 0;
> +}
> +
>  static int ksz9477_resume(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -2150,8 +2198,11 @@ static int ksz9477_resume(struct phy_device *phydev)
>
>  static int ksz8061_resume(struct phy_device *phydev)
>  {
> +	struct kszphy_priv *priv = phydev->priv;
>  	int ret;
>
> +	kszphy_enable_clk(priv);
> +
>  	/* This function can be called twice when the Ethernet device is on. */
>  	ret = phy_read(phydev, MII_BMCR);
>  	if (ret < 0)
> @@ -2194,7 +2245,7 @@ static int kszphy_probe(struct phy_device *phydev)
>
>  	kszphy_parse_led_mode(phydev);
>
> -	clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, "rmii-ref");
> +	clk = devm_clk_get_optional(&phydev->mdio.dev, "rmii-ref");
>  	/* NOTE: clk may be NULL if building without CONFIG_HAVE_CLK */
>  	if (!IS_ERR_OR_NULL(clk)) {
>  		unsigned long rate = clk_get_rate(clk);
> @@ -2216,11 +2267,14 @@ static int kszphy_probe(struct phy_device *phydev)
>  		}
>  	} else if (!clk) {
>  		/* unnamed clock from the generic ethernet-phy binding */
> -		clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
> +		clk = devm_clk_get_optional(&phydev->mdio.dev, NULL);
>  		if (IS_ERR(clk))
>  			return PTR_ERR(clk);
>  	}
>
> +	if (!IS_ERR_OR_NULL(clk))
> +		priv->clk = clk;
> +
>  	if (ksz8041_fiber_mode(phydev))
>  		phydev->port = PORT_FIBRE;
>
> @@ -5290,15 +5344,45 @@ static int lan8841_probe(struct phy_device *phydev)
>  	return 0;
>  }
>
> +static int lan8804_suspend(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	kszphy_disable_clk(priv);
> +
> +	return 0;
> +}
> +
> +static int lan8841_resume(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	kszphy_enable_clk(priv);
> +
> +	return genphy_resume(phydev);
> +}
> +
>  static int lan8841_suspend(struct phy_device *phydev)
>  {
>  	struct kszphy_priv *priv = phydev->priv;
>  	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
> +	int ret;
>
>  	if (ptp_priv->ptp_clock)
>  		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
>
> -	return genphy_suspend(phydev);
> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	kszphy_disable_clk(priv);
> +
> +	return 0;
>  }
>
>  static struct phy_driver ksphy_driver[] = {
> @@ -5358,9 +5442,12 @@ static struct phy_driver ksphy_driver[] = {
>  	.get_sset_count = kszphy_get_sset_count,
>  	.get_strings	= kszphy_get_strings,
>  	.get_stats	= kszphy_get_stats,
> -	/* No suspend/resume callbacks because of errata DS80000700A,
> -	 * receiver error following software power down.
> +	/* Because of errata DS80000700A, receiver error following software
> +	 * power down. Suspend and resume callbacks only disable and enable
> +	 * external rmii reference clock.
>  	 */
> +	.suspend	= ksz8041_suspend,
> +	.resume		= ksz8041_resume,
>  }, {
>  	.phy_id		= PHY_ID_KSZ8041RNLI,
>  	.phy_id_mask	= MICREL_PHY_ID_MASK,
> @@ -5507,7 +5594,7 @@ static struct phy_driver ksphy_driver[] = {
>  	.get_sset_count	= kszphy_get_sset_count,
>  	.get_strings	= kszphy_get_strings,
>  	.get_stats	= kszphy_get_stats,
> -	.suspend	= genphy_suspend,
> +	.suspend	= lan8804_suspend,
>  	.resume		= kszphy_resume,
>  	.config_intr	= lan8804_config_intr,
>  	.handle_interrupt = lan8804_handle_interrupt,
> @@ -5526,7 +5613,7 @@ static struct phy_driver ksphy_driver[] = {
>  	.get_strings	= kszphy_get_strings,
>  	.get_stats	= kszphy_get_stats,
>  	.suspend	= lan8841_suspend,
> -	.resume		= genphy_resume,
> +	.resume		= lan8841_resume,
>  	.cable_test_start	= lan8814_cable_test_start,
>  	.cable_test_get_status	= ksz886x_cable_test_get_status,
>  }, {
> --
> 2.34.1
>

