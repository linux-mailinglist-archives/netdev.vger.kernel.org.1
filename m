Return-Path: <netdev+bounces-200773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4170AE6D0B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EA8162F9C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503512E3B16;
	Tue, 24 Jun 2025 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nqgu4yty"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F7274B47;
	Tue, 24 Jun 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784143; cv=fail; b=bsinULxRzmsNmyTdsaafQG9lsFElwWZH7vmyaLMWXoar5413FnGB8+l8/7H1VTJyRinPRIZP3/47UM4HDz2ECBohV75HOOq4X76DSalkIgTaUY6JPhW7+onVuZQsgqq2DkbtO5M0z4bQoNTbkULnIBpWeGeZLzwkxWYT3pGQ6Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784143; c=relaxed/simple;
	bh=NdY8eK4BxUsstmlNbHBb2Er+h1BD3l5wjJGDcOYBLsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VsNH51eklUtq/hXBFQmjKzRTLFS+qmV3uCpAC5TBtia36efzKx/zANo4+VuJQ6sgjcLm0+5KMVVvphGQR/BWjbOAqB+XDjb3xwiOZi71T+D94F38cRrQuUmaX9ClM0qmzskqHHUMXFzUoUDEtWv6Ssn6Rhp62jKEhC4ESictbI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nqgu4yty; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjB0TEetTOF9VuP8IRQjz+vJJSytkypIwSIN7c9OwgcZCdjKywlU3KRWvPhAqyArEP76MNkpnLWm+pm9XfUVCoa5TlRxEJ19DdqlI8fQicxMLfuQrugaKUAJVNAmc/zOCdrdkMdGZgc31lcEVszh2awtn2T8043yen4FVvFebMmxSkPYBjYYV0bahuLjFsyl6FBFV8Ab+V35JQ9IPNTQRP+DD2OVOpvw9/Wsy4ou7hfb1NGj0r9GkUHPWdB7XKdD3Mr18iWaKAEoEhItqV0hg6gH5gZHmJOCm9cAv5uclYnBVsXFrn0CZkA2cZPsFuu76nCl2eFICicKuUjcAsL0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4/3lDN1ygBI1dN3pGsxI7030NxbHkN6fAz1NxevXzw=;
 b=dEv7H4fZFzWqWljmspWKj4dg++pgS1orHpOLRTO+HVuNGEA1D19zcDpLHtBacQWe5NtV1LFYajIkR/CseUpY+6H+gPtvda/HHlMRiuTFEgWVnqPWXu6YQiCQfSLrZ1BgLupHodmMvqAoeQ8QqC/7d95I7Zfn6JxzurNnlqbu+RQUmp3x3kU1t0JWE1FT6Pja6HhzRNkDUTa6N1tlvb4/vO/9YkrvCaf+TCvrWDVIQ7MLV2LkH4nlPPE+Jz/WhwBbfhsy5iGF0oc4Zys4tyUgwd1JHZwJUBtHfYRZUmHl2SXXaWUbD8pDizJ4cjPmhr/wMzL0wO7aBjKkF4grRg/Tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4/3lDN1ygBI1dN3pGsxI7030NxbHkN6fAz1NxevXzw=;
 b=Nqgu4ytyg4u82+jkv0/IG9hFPwOrBXeacNAKaq8PwTGy0WcTiFc1XWkY2v2CSirQ4uoG/CUGceze2anmUsGENfefyiMiLXD4/O+lqbsoveLfk2NVn+gdiIpGNxE/YisaVFcf3T6e2IIzkCRoK8zZwoEPjgZcnX9ucTpp3M+zB84E7GuGsqnf+etvAF39yO9Qi7y6pbpWl47Oe30FA+8BUFdfiPS96HyApyPH3xSB2ygJS2PLhWpdRr/jEAERdRrqz5RZ3IcGaqO0WdS+5tgvikCSSiwtfgq/2BXzYTH+DXi70X+Oz3Pfv+sTNf5kFqO9f49N1me2AH/Ngs10b7xu3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10710.eurprd04.prod.outlook.com (2603:10a6:800:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 16:55:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 16:55:37 +0000
Date: Tue, 24 Jun 2025 12:55:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 1/3] net: enetc: change the statistics of
 ring to unsigned long type
Message-ID: <aFrYghOED24f0CVa@lizhi-Precision-Tower-5810>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624101548.2669522-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101548.2669522-2-wei.fang@nxp.com>
X-ClientProxiedBy: PH7P220CA0102.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: 9092b63f-dc54-4870-a943-08ddb33ff164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sZ2+fHhsPb4UxFuPx5sinogMmyVgTXO5ReZ6g6ln3VwDCpS7/r9fJJIy+sl?=
 =?us-ascii?Q?U5hCcBtXwcaLtPh8+DtMGA2Tc5+NIQIca0kDj6SfEsYk3iNjQmLpa77QiARp?=
 =?us-ascii?Q?8rs68OcsanxhdMi87UExpD+4TzdyMr+fJ6TTGkrnIFwOZ1hSV5xoyFGcU6NP?=
 =?us-ascii?Q?/WakfoHypO+JXgWkQ9S2X4E8dWWgNwUmYpUci4mcaUxaNHkGIhD68CJH2C5U?=
 =?us-ascii?Q?ZzDd68PgntEdP+ClUbUSzFikU4ZkAh76MV3oQhY1EmH7lGwHAB7otPhdelXN?=
 =?us-ascii?Q?lxH6MHDK6vKxUvDxcFZXP+emyksCOs+KktxLxYVnbDUbXF/RE4apaIVzmSvl?=
 =?us-ascii?Q?O6gcBIY6CFvLWDUG4r18p68fHtf8ktVRyEOjJji0gn4XkoE88rB113vEiw27?=
 =?us-ascii?Q?2Wi8GZRF4tKnP9XlBmYYirZ6keyyXKmJimoo6zodrk3f5i0vrTIAxlu6AGfq?=
 =?us-ascii?Q?sIxTMaqRja3/XeghzrsoZq5vOgr6u7dREtYvmNafSvJo1sp6wEZi+qrz+oYf?=
 =?us-ascii?Q?QUaxE2bSOqkiK64pHLMKR8n25dkrHU7TCRA09uiQeucRDL5IdMf5bHs7/ps4?=
 =?us-ascii?Q?ow8hugPN9hfan/L8v38FZHq6//6LU5JGBzcy3AOfHfg3coWf93ym2yw0RnZ4?=
 =?us-ascii?Q?WNimbyo1QmG381zMIbQypBQirQZkjcJ6sFLIoMXx9QkNxH9cIuc/AESzwmJL?=
 =?us-ascii?Q?ReYVwGpan9VjmKeo3F66eGUl2NMVBez9QBpdkUEMVRLfS2f8wY7WtfKr0D+j?=
 =?us-ascii?Q?qxB7bLz8HFmPtHAZO+1h0yJPXi/AhyrWq81U6kLi5/xze0D0x5O/pthqWcdA?=
 =?us-ascii?Q?9ZiLv+p7fsa34sCPHCZHvZNgu07KHt6JGRfgP4QXoRINtIa7qnOg5K5FOD9c?=
 =?us-ascii?Q?ja8C0Szd+mVKeW2UngO7pmco6QdjgjmIOD/vQeECpqBNRlcaSqPvopdBTdjs?=
 =?us-ascii?Q?f5evhjmrJIKuWmfpB36Rhagb6+LmDXmXHaCPIRybqlJo7oIUYw38zpt0RvA3?=
 =?us-ascii?Q?Aw5xSlLxoQmVMM5GFuY4ZQ3VqwmKekukS7kbpy26/09T9vhSr4b/GtSyquAr?=
 =?us-ascii?Q?fQeaUSk11fiFW4ny71K1JtYh4n9KjRtODdgO/YR7DmywC4Ooej8X9fSlF7RQ?=
 =?us-ascii?Q?+tZe4XCnTFFzrzePhCaRv/ydAN4NteQTU+nOXKBjspJJLCS0eGQKqljRI4er?=
 =?us-ascii?Q?jJiIeBOGkGcVhI2O4r5GpZRLsSKi8USb95zTEg79PjpuYT7ph0NG4KiQMbzG?=
 =?us-ascii?Q?zF93RiwmjByL7rx6c4i66OKsg1EeQWKYIN4gyV+coNp/AJGC3aqmuABFGP79?=
 =?us-ascii?Q?FEOMcyHLaHjwKvZ8LGw3CWiqQFOMiEQt6ektMX1uyRZeiHbPLT20JDdMV2oz?=
 =?us-ascii?Q?D0EdBntbIOaEKjKQaGbY7+D1/lk8Ojy3orrPzK/fh5H67mCeUXp56MvPBObf?=
 =?us-ascii?Q?hiQuTFqVMoLG1AEpMuVMom60Vi7jOUaXFbL/4pJrChZHM2mKBCMYRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEmnAE1b846CTw1YIZATToGx/I8/CyYONh9ZRKSJriOQmCzVV+2bhVPFjf7Q?=
 =?us-ascii?Q?muHaevYABJ3KJ26bFn7cqUXeG1DFuy+t9N0V7CScf5Jlq3pNiKkRR1yI1bJJ?=
 =?us-ascii?Q?8iPpGnjZPkD5hbOgEPblb0xMd2R5YprwZEr6kO2RkyEGUXGn4uEThpKbBDj4?=
 =?us-ascii?Q?8YTS/rxxEW1AdckYNM3UJG6MKlSLcC6gTMuoCZToaA2f0okU5Ny0W3dEWS1V?=
 =?us-ascii?Q?E5cUulnAxDDOpmE5sOjYCoSjEqK2/Vph5ZqA5xykPPuim9Wkt/V924w3Qa56?=
 =?us-ascii?Q?roOC3ofCLPer4BNWIo2DD/PqJcWb+BMujBvCjBTAS1cu9bO8iyXVxNZk1ohS?=
 =?us-ascii?Q?AHzszUc85F5XZqZSAJBmbcX5BFYPgPYkRS7wxns+48w7fDoSP3jAkntwr4G0?=
 =?us-ascii?Q?Q38Sb7eLu6R+84XurpIWiG31mbp/aDXD9An+f/ANQCF2vMZ+uaADGyyr8nn6?=
 =?us-ascii?Q?GDwyOLLkLem0i1xANP4Dw27SbyP3lxzuoX3XgvQ/pOih+yb5NKYFzIynLodE?=
 =?us-ascii?Q?86L08+w4DoxIu7T9rvbkzTI+vyVjl5XMXzS5SPzvtUPhz1rsDhkvQAPzyGoy?=
 =?us-ascii?Q?1tvrjZaIUt9rSOmTGR6YCQe3fhmh5M24DV/FaJfMEoTMT+vqAJNR6BqmRaF1?=
 =?us-ascii?Q?9xlN2bhXiOHxHUUJrBFFHU7MsBCZ4G2zuT8be48BqhrpDf+iLiInrmaUZY8J?=
 =?us-ascii?Q?0egw6lN8d4jwAzKyXU+ZFVQNw9/+8taQpmNGtiQzfQpipztj02t2IGDJocGu?=
 =?us-ascii?Q?hOzFDw89Le1PSSRZF1JAFlb9bTWkB6XxBWFDFZtfvZWP8z49b0/wURUeTBfx?=
 =?us-ascii?Q?ALClqFSvYaIOu9t766GkBqUH56yywMvinK3O+EF2/okkyS9E9iXS4rjzFuhC?=
 =?us-ascii?Q?xNTDQDLdeDphueCqFlO84pMGSJVc3pTadfE7nx4wAVvIdlOO6geggn0Qn0pN?=
 =?us-ascii?Q?EVVsXq/4IVIDs8tYr3kaImepyQX6MOSan0NxfkX6aBG30N37tgDocXws1jIh?=
 =?us-ascii?Q?Ti3K7mXWN6fSd+oWDbzzQiRXiJjMoPxFcODIa3Wuv1mis3zOzxQBMhZj2Esa?=
 =?us-ascii?Q?nzlS0JaCefyJmDtRj/UdjTZoRoRA2UhXcY6z4rm0ClcHR198IZY2CH57GMeM?=
 =?us-ascii?Q?Kxy0SnuiduKpRCFxJUEPI2bKDI8Xh1xpuATUEFRMcnDgtNN+wy/bTsOfUlqN?=
 =?us-ascii?Q?xjAdR0RusYgrEyPG79yuDJn2A10+ykD0z4g42JkjcIuo/0BCDgg6VpkiQGbo?=
 =?us-ascii?Q?1BfJFfSu7sZjXeDqRYc5O6YU57c3Im7lIa3ThE2txT7pWM/sZUSgtSv+9pt7?=
 =?us-ascii?Q?hGmkPLCcxPvu14SrCmMuc7LJ7B1uj8v3tcPndMxrAYr7KKXno603XKdssG64?=
 =?us-ascii?Q?nX1eSrEMy273NeXyHONRvK9121DZ5ZqRIrVE8y5Qd8ua8yAOimQ2ROY5/+zd?=
 =?us-ascii?Q?Mwm2a5k/7eusV2nGUM9p8PQiVvKh9V3enMrCx9YiFYTJD6XWTSZ6Xd+vSK3I?=
 =?us-ascii?Q?K0r/xefh33X776vYOPHMGL+Nz+MAlaasWyN40n8cw6lYlS2wRgzojp+dIYLP?=
 =?us-ascii?Q?7iHosHAGKZdSuhM4Iuq5rm2MqKxJN76j6Qjzu3I1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9092b63f-dc54-4870-a943-08ddb33ff164
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:55:37.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2Y3ajnmfjfk20L4oj+A1tW1hK/mgMa2seilvnJkuc5iBieP2HpigeDd7xF1FXUa577vXZNcB3xYiNWzfxARnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10710

On Tue, Jun 24, 2025 at 06:15:46PM +0800, Wei Fang wrote:
> The statistics of the ring are all unsigned int type, so the statistics
> will overflow quickly under heavy traffic. In addition, the statistics
> of struct net_device_stats are obtained from struct enetc_ring_stats,
> but the statistics of net_device_stats are unsigned long type. So it is
> better to keep the statistics types consistent in these two structures.
> Considering these two factors, and the fact that both LS1028A and i.MX95
> are arm64 architecture, the statistics of enetc_ring_stats are changed
> to unsigned long type. Note that unsigned int and unsigned long are the
> same thing on some systems, and on such systems there is no overflow
> advantage of one over the other.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.h | 22 ++++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 872d2cbd088b..62e8ee4d2f04 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -96,17 +96,17 @@ struct enetc_rx_swbd {
>  #define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
>
>  struct enetc_ring_stats {
> -	unsigned int packets;
> -	unsigned int bytes;
> -	unsigned int rx_alloc_errs;
> -	unsigned int xdp_drops;
> -	unsigned int xdp_tx;
> -	unsigned int xdp_tx_drops;
> -	unsigned int xdp_redirect;
> -	unsigned int xdp_redirect_failures;
> -	unsigned int recycles;
> -	unsigned int recycle_failures;
> -	unsigned int win_drop;
> +	unsigned long packets;
> +	unsigned long bytes;
> +	unsigned long rx_alloc_errs;
> +	unsigned long xdp_drops;
> +	unsigned long xdp_tx;
> +	unsigned long xdp_tx_drops;
> +	unsigned long xdp_redirect;
> +	unsigned long xdp_redirect_failures;
> +	unsigned long recycles;
> +	unsigned long recycle_failures;
> +	unsigned long win_drop;
>  };
>
>  struct enetc_xdp_data {
> --
> 2.34.1
>

