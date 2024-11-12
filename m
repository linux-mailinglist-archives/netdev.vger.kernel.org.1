Return-Path: <netdev+bounces-144179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876889C5ED3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EBE2828C4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FC20EA29;
	Tue, 12 Nov 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lvCRj8J5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6B189B8A;
	Tue, 12 Nov 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432185; cv=fail; b=df4bESepN+bp4vNxFGoZEzB2bO2+CZNJAL2siQozxTSMnIKxORn4iGQQr/T5ugssXr3Rg7eN1z0SJc+ElZsP1MBm5+FERAqzCPoV2LzEQN3699wqi6OxqdtOd+6nhc159XMSJvMfMbHGR0JPk9JzH+ONrclxkYTl4FysOyiJef8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432185; c=relaxed/simple;
	bh=jJ90H/9ODveq4nQyRsx5nm/A3n1p3yDGYfsJCXNEKkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lC9sslxIMaiHexM+tfqtCFGA8npIWBv/5oeftw+73dcowbSuZD90DO+RMjpbLVMjSVTeSywZiiKxkz/Zt34F7YBRX4sk6YisFwxiSE0HM4ClzQBUbg0RVFQaD3DEmdfJTXcpm58DQLwSEIeVc3DkEFZuusy63zo+oQIZKRlPloM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lvCRj8J5; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzFYnH5CkDWihtJiTluW/Tgju2XRg9HdhlsMchDLFsyM6BrrBU2LQvfRRfUs/cH0IsCRgnRJqa16S0Xj3uBUs9x7jzCdmavjZkmh5HLg7ZPKFHacdJDcDBcEOMKFQ8VSJEQqxDwAJcthN1UFHKaDae1AGLZ9+F0Ny5Eo1DNZ0D0+22l1T3e5XUDAaf40loaP8mqu9R1RLhWKEOSc/+MW92J7EYLEaSiYaUxlQejXQMRRs+8UuZGjEwpxNpAeQnu1sbPCm9bIXUunVqL2xgVdpfW4twXs17/HfeUJTFmo+HdOxFuW7hY9UEg6AomXV4pLkypl8z9CpIByZRLQvbw0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEcNGnwujqnN7TBPrr2S+zrdNv6l3GtW7Nmyn8udAGo=;
 b=USQ4ebkyGzHU998m7fkVKGEMNiPurwe2xejRlsAg4IqYP7gLELpyw2+meKlysuR5nxjHOMfqS4FE4Kc5bwsWQgCJgUzRDMY56GlTa0ePWm4qT8iQxJp9CsheTDM5BNWlawIH0Z7OMd06xD2yP3SIL3nJ3aQgzwpvNuWZwT1RG9BS64ejLEuS7/zzBd/ISIwoM49vjDtvDGhCH61v/L/0zkVqOzI3OJfGqzpN1j5/1smmD9bOGlz/qRUn8B1sVmhxZ/EOeW9Le4Fsyqp3DGA94Z3mQy9IS1PP5/fpoWTGmggrs8h+tHVuadu6MJQkEUXRXzZTWTrdakHUr5MG5fLmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEcNGnwujqnN7TBPrr2S+zrdNv6l3GtW7Nmyn8udAGo=;
 b=lvCRj8J55KumdgvgrmxkbKCzwmPtv319cE8zpHPBHJqiUmwo472VLgfXd2mvbPeorGDtF5tKwc/vTEtEucqxigH1fmtAVsCyPBnvDlm1I3ZGNSYbkM+s/XFzQYe3q/PDz1mj7M/2jJ0BfaAL0XpCVVDb/IIZv5DDeur75cQnKcSQnpXs36FIGkwy7W1fMaXjRaHXqogPoqZt4gw20R84R/Rny4+f6hjn2XnrOBUilpRDJrto6/1VlDM2GUNmST/v0tqeSjm7Tdk3TvU5Yq8WVtw4OidSKZ4CgnE69iUsvgaprhD0/lkVQBX4n6GvIXhg4Osrs3vJDejejUA2sK5gFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 17:23:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:23:00 +0000
Date: Tue, 12 Nov 2024 12:22:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net-next 5/5] net: enetc: add UDP segmentation offload
 support
Message-ID: <ZzOO7IROQ7BXHqqZ@lizhi-Precision-Tower-5810>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112091447.1850899-6-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c95420-c60e-4986-e4d2-08dd033ea834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAB6JvoxY7OyJimOOppvn/7yw6rHFuAgdXql09LBLfeIFc+tQQWwHxcraPZL?=
 =?us-ascii?Q?8vhoN6liaQrMtvFVsr6RcTu9qvr+OHmcjf7Xy2e5932o3APpGa1rbLRFUlwB?=
 =?us-ascii?Q?GLR1fHbBXJk8NhJLUa47jqRFfy75uoUQAE10JCmjFQYj3XBz/zKpGTQYohhM?=
 =?us-ascii?Q?8yy7KE1bayw0m0bGfMpkqpppE/G6eFI8bOblHJUW8nmmpLPjieQeTH9SV1g+?=
 =?us-ascii?Q?7MxkWMlp+LSvwNynPU+6Zra1s5z012srvu9nYUMteHBjY1yvb1XWBh1sqxx2?=
 =?us-ascii?Q?b7n/0UcjIBS4SFcKrIdnUc+X++eia2zY4kyJoGydtSxeUKTyRgTrC3epJazC?=
 =?us-ascii?Q?F0JXKrOIufZMW/dxd699Dznl6Uq3YGX48TQg08WGgrcBA6vUPWFdAqJ1jwim?=
 =?us-ascii?Q?OXym8Ar8KZUZQdnVG1N+UeHczFLvnsURq+8uJzK+rWjcF3M+qEfX1rG/38EW?=
 =?us-ascii?Q?MkHiBxgFca9GVUp8JgeVZxV2KgDfl/9jq15/ACDCI1iOG1hPL2WYFcQJGZ6p?=
 =?us-ascii?Q?gpcGS2KGwFX8baznCyX289NrKwv+hhYMLxsV/Jjy8OtWpl3U5CVbmJ6IN4Ps?=
 =?us-ascii?Q?5Bw4Ns0A2Zx/bABAkSUlUg7AX6OhEdubSWol+JDMZktuFSGf8Khi//XblbDS?=
 =?us-ascii?Q?9uXfkltmLiiScQT7bqO0bIdfMdN6WQeOtV/wmaBxx6NEDDER9J8ezkZ53J4g?=
 =?us-ascii?Q?Qb0XYC8HPb067UUlzc/7ESkmY19tg6wNxYwXSOTvuWd5EhaxaagfzXzGmdbq?=
 =?us-ascii?Q?qi3yZpB5ASJPp6rh4TVANhHi5KF5gVLlWH1Cj498rcUJkbvrv5w/AE3up5uk?=
 =?us-ascii?Q?7u6AFJx395qMZMj7XlaOw7DDi00+30AvFyA38lPPM1Pri4Md3wVQNeN3Czo4?=
 =?us-ascii?Q?jNZs7Wp47L07MGA54Ln5fTfXYQ8d+oRubm+L6Gg8UrDbpTL4VSY9KS2ul+KC?=
 =?us-ascii?Q?qxIs09NiSNJA7OGwkMCErA0vbwY+iH2il3QjCAKcl8EqRCI9EXA+QCKtGggE?=
 =?us-ascii?Q?MBQ9iwxLyFSTeJex947sT0UHu6R6pjTWjYT3QV3n8vOLS1PI1F8ADzUtn806?=
 =?us-ascii?Q?Uj/Q3eKKhB4jlE3T65AcTm4NU9MFiKf4ZxrflLOQ2ngaYtF6nP6inqzH6Pmu?=
 =?us-ascii?Q?kVzKqGgm7/mcKkI+ka7VlipJ/tdz5aWHJRM1k5W6EgA423usGwZG7CdZB4/7?=
 =?us-ascii?Q?IcbaKhlYOEYD2Yfsyyw3ugXRMwHcnFUs2hj+nltsctqdh3ZxYrAyT1LCLSEq?=
 =?us-ascii?Q?HisqBok+xH6zNT136E4Y7a4id4YgD9d0rbF4LeQWbE5mg5ar34djSfGXipJs?=
 =?us-ascii?Q?kPsczlOgJVuWVNiA7yrkLQi7X7lDFEccD/cEnDJyWNta+xUEOZUFS09LIAYH?=
 =?us-ascii?Q?/xieCk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0t65nAsNnpYpDJexNtCwhSButa60xdHBt7G4a1kZJMQLLLxQMaXYP+rbl36w?=
 =?us-ascii?Q?8F7svNZ0rM77peCDGDFmlVwU+CiN0Tgl52BxMQ9SKDpvm4QpvBq2apAF12GR?=
 =?us-ascii?Q?59EZA62s/E1h4gkvaYpzgsu4hHhMxzA3Gr84oxFfWJwZh/XzKnBibSgJaHST?=
 =?us-ascii?Q?kfBUq9S2Fd9SZo04BvPTwC67ZDHkk57BQ1b1TRP7O61o+HsrzqGIPtydUhB/?=
 =?us-ascii?Q?prNa3u/MRMfBZvRagjm0aUmuEkUG7tp9m8LBhdfeskrQSwfCx5XE/GSYK7XQ?=
 =?us-ascii?Q?DYhJwMSU8L1JKttSMZOnJ3OPwGgagSlBDLCl+3K6vJGsMNoYz3EUZ6CV+I4e?=
 =?us-ascii?Q?3l8cq1RaeJoor9B8gf7kNa0yjhahqdI0smGH9OvjNSqraQeTblV+egdSm32w?=
 =?us-ascii?Q?hNt0ip6+moALPQ5KKpfcQ+NYMLCEYbG1gwehZiKYcO7LAe2MWD7a99D2RQH2?=
 =?us-ascii?Q?1BKLukdT3RFF8+NPksBBA1dxC+mC84hyy/Z1uf9mHuNMYsyOL+rAr4wcdvnf?=
 =?us-ascii?Q?AsgGOiagJXt4kd1xtWEpUEzEbw9nqCy6+uVT4IlLf3S67QWfWefM0TzrJoF9?=
 =?us-ascii?Q?XxdaJ9RjujUV9zrMDDqCtCN87e6H/DSnRdFjTbKiSmH23ukc/Ob/aoAvLN90?=
 =?us-ascii?Q?jlnKfpwQogC4hIHklFzKyPDEn4Q0ijtoobpgbqNVv2KbizcsXxL9AljRgJUe?=
 =?us-ascii?Q?Uf6Vg+mvdtCxciqw3gTU351QKjQEwuCj3TolegBKPIHfXIMFQTruF0yCw9Uc?=
 =?us-ascii?Q?sk9mxExpKZxXQ9KHup4sEEKO1J8uaQMj18XObPWCgki32wAwnxQ/cRJJwxQh?=
 =?us-ascii?Q?k0qnF1K+QsjtCKTCWXQynZKoACfIo5sQomtl+TyVXLacjEhdpSRtFnXm7Np3?=
 =?us-ascii?Q?msHKRfAwlx8AISliiGQtz8vce2r1GYJ3jJMReLE2kzXaD5js0yx35t5kcC99?=
 =?us-ascii?Q?g0yK37Xy7nWsbDimTuVdoQ6JwJIIr0BiVW/sHPECnHZI+Yii8M7SO3Oj/hcL?=
 =?us-ascii?Q?Sgt4MJfWNKorWdcLhmNr1upYi+QkfZeTdZXMqAzPf47nDvRHlj/M63fYuMoY?=
 =?us-ascii?Q?c+XeY2elsbMROUZb6ft9HRHI4Vaj/97wwWdR4+ykV/epXJ4eA5s3bX6nZsqz?=
 =?us-ascii?Q?Z+g9V/8urTN5CsQeC8Mz+kRKOmNNAc/GkThwjY6u4j6SIJwqOXW+s27CshkU?=
 =?us-ascii?Q?SG3AOJWt8g+QPAwaAV8lguTfNmHRfXvxLmxptxUXRlgk6ydEinKoW1Lamelx?=
 =?us-ascii?Q?XAainX1s8+nMPioiTaxrO8OF2/xhx8DQiD4GgEDfKl+oKc3eKira5kjANg2e?=
 =?us-ascii?Q?t1K0tdf/3dwdAVFPqn7d2F/VfFjTuLYTZtZypv4Zd22vxSAWGxLTbJjcJtNA?=
 =?us-ascii?Q?vkyoFxmnNFC9ZUWMUqq/vCHluhROqKaUbBdGg2DIiQbcu+1wKrlmLtc4BnEr?=
 =?us-ascii?Q?i8FC9YQZ1oY7mRksmCqzWgncnMUlcR6/MnCZM3JbdzDKP0WLPG+IFusVaE04?=
 =?us-ascii?Q?H4UT8mU7X6I32QVny+BRti3oZshgYuZVxkcG4VrMtyTBesod3H8dSjtM5pLY?=
 =?us-ascii?Q?0rEP/P/186UXpQ/VINM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c95420-c60e-4986-e4d2-08dd033ea834
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:23:00.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD1R2bzxt8hfuV/2LcOrDVQy8Fpx+1zIFj6idp6YB5IdQFzD6sr3wVxDstSsI8H2Y/2h0PNEgkj+oXvoraV1/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

On Tue, Nov 12, 2024 at 05:14:47PM +0800, Wei Fang wrote:
> Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
> enetc and LS1028A driver implements UDP segmenation.
>
> - i.MX95 ENETC supports UDP segmentation via LSO.
> - LS1028A ENETC supports UDP segmenation since the commit 3d5b459ba0e3
> ("net: tso: add UDP segmentation support").
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2: rephrase the commit message
> v3: no changes
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 82a67356abe4..76fc3c6fdec1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
>  			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
>  			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			    NETIF_F_GSO_UDP_L4;
>  	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
>  			 NETIF_F_HW_VLAN_CTAG_TX |
>  			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			 NETIF_F_GSO_UDP_L4;
>  	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
>  			      NETIF_F_TSO | NETIF_F_TSO6;
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 052833acd220..ba71c04994c4 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
>  			    NETIF_F_HW_VLAN_CTAG_TX |
>  			    NETIF_F_HW_VLAN_CTAG_RX |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			    NETIF_F_GSO_UDP_L4;
>  	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
>  			 NETIF_F_HW_VLAN_CTAG_TX |
>  			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			 NETIF_F_GSO_UDP_L4;
>  	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
>  			      NETIF_F_TSO | NETIF_F_TSO6;
>
> --
> 2.34.1
>

