Return-Path: <netdev+bounces-212993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658A5B22BF3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFE7620370
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2762F5321;
	Tue, 12 Aug 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QTnEs4Ke"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05D1E835B;
	Tue, 12 Aug 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013551; cv=fail; b=JLo7O+VBOlAY+SLqjdxFmSQylF1QOqOwKZo3NAWhhbGHFhReKIicnZn1/KUoNPsV04rNe6rx1r2X/k9yZ06VnpmwOUo0e7iMSyx0rAbUhx7t5xtwaqn9u2MbsiudTgZbuNFTV8IwTI7K46i1kKm5jMFgoRPUdlkrQxE3vP5o27c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013551; c=relaxed/simple;
	bh=hCdeLLFkzCy/D671X9E+VEUXmwb9MV0k27E6Sr87c0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fm0ZZHYocHH63folYhul2QpVOMerOlH3yrLQ96UA3W13DBcVWFZ+y4m96Bf1Q1UueuYT4Wxwg5DCwlo4J7yz+sGmyDniNTn8XnGa5KPBJ2foGAq0AvKBN4yGxH1lFS8i24da3KxH4EORE2E59IzJmEfH4ezZqbP/uTn7TPXryPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QTnEs4Ke; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mf9lZ/b1WiqswTkq67Egby73Hr+QZftm0B9i/GW1Qr/jrPTsXSgDc4tuzvZxcNxiIkb8mHsFbNSjI8G8Y3T2hmLvg5JSgTxVhgbfLjvv0ivOFhCo0qmTk7rYDGs6RBCgF+XrCNsCemBIUNpgFg8nYvy67UyqDj2NyODqyobnHT86UJ9Lp49lVag/VfpuueKHzYyf93FuP7xTGwua9XFQmZsCxyYlSOSB3GrTQ0sjNnfdIAGgUg/+MF2fqIm5gaW93cjDhp/lznoXVdAiY3BMp8SV+V8SGvpzZbw1xISy/rP86ul9tt1y6hi86BP0jubovo1Q/EHxKnudLayiRA3kFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pxt193N3sSJFs7332/rvIoL+xGZsgpGJVMGrGJIAJGs=;
 b=jRVsoVir127rzzmDVenkhfQBaa33005RG2oFxW7A5ALEiJt1J8ZA7AVZ3Ni4j9bBKFwwRreqPUvSTu2FOBb2wRZXoAIe/Du5HuhF5vZcKkditG/PZKaCCCdixJMd05mXrmnWIOQMRpfb156u22em5axiNxJZvBKy9W4DDcJEAvL9dYFGatrq0TvfsS9MS5yDd+USsOxz5yhWQ88zTk2uKJHUxPPLSjjwXUeTmAWhvPRK/iWjVIfDXwLZnueNQvpI+fmaFkV9nanMcA9kpPpBChHPxjJ9X2svqf7VwkGfPiOWbq5AGm24nDXhA9GvpeZGxkZY9Xccg03xXP4rSveVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pxt193N3sSJFs7332/rvIoL+xGZsgpGJVMGrGJIAJGs=;
 b=QTnEs4KejL/GWmCCGSY6g5eWWy29YAx0O+HYRaJaP60znl+Y3qQWPn4YFqXvhHep91FA0rEAfp2ivBq+eCVnBHwH2y5LYzz8qnIrxPqTqWokjvwRP3tKiTqzddF8OiSn01QRMsKBHGvdnw1OY1E7d9HZEfqx/vvOeomwaMZcX2tYC/GFjpd/TC7FkEawwUQXxNboSvECQgEgVGKUWMqO58k5oq2ica7GvxhAEZE4cLlHac2EOI5eadirFMRFCQMILWpGc7TvHScY7kMDJ/1y8b0YLBZvCgc8ZHOzICpEZkCh+46k000TMVF48fnrJV9ruUxi2o+8uCFJuJTFN4H19A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7281.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 15:45:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:45:47 +0000
Date: Tue, 12 Aug 2025 11:45:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 10/15] net: enetc: save the parsed
 information of PTP packet to skb->cb
Message-ID: <aJthobCLg3E/lCzV@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-11-wei.fang@nxp.com>
X-ClientProxiedBy: PH8PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f624516-647e-4e69-55f6-08ddd9b74e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXFlmi/EeX0Vz8JUNpbbpmmzI5yeNyXBgmsZ/I/OfD/lYgvMRF1xuX781ezp?=
 =?us-ascii?Q?RADUD1Izny3MVi/3/eJp18+aP+vuQ3H9KRGn0gjFHHHX/Ljzgw5gE0OZEYd4?=
 =?us-ascii?Q?9tJOlbzanymY5/uqSC0j3qASfSnXzlq6ajXT68sdirt6vQwneHzzfp1gZQh1?=
 =?us-ascii?Q?g+3QjCJ8GH9RbRaPcUedXd7EcJ/U+objnFvOFvWBoZuKhNmNKLXlWVXkKRdl?=
 =?us-ascii?Q?t9IwVwwMqjwCJ2yH8lpcvVKt9Noc3vZgT7/VF7kTB2vGL+BNlAmD0LjIGfQk?=
 =?us-ascii?Q?ioKBoBF8p9W8L8Db1eOK68Vdxklf0hNReZHmej2y8Q/3B34ejDqBGPfX1Byq?=
 =?us-ascii?Q?sIjk8ekazByfCD88leHxtZr5pBiLrdIt/TK5cTYWYjPbU5SjfjLESsh8tM/Y?=
 =?us-ascii?Q?Q2JWadkuGXpanuQKyxz/OQH+SlR83CIcgqNuSqdRxVB1ImjD1n0bRxt2D1Hp?=
 =?us-ascii?Q?MrYvaqWhjpQvgLL5tDodL6Pwx/wqUlQZ/dUPsfSCkmiixk9/ZIeV4IGxAVr0?=
 =?us-ascii?Q?/e8ByQvQA4/nd6+wysZSjlFhqRvE3FM9KOYSJZth1Hgp769CiGUPSVeKzNZe?=
 =?us-ascii?Q?c6qWYkgiIpklnT37waa9LUHDUHzcm/79LpbcCpv4QMwfhd+HDCmkdgqTFrY4?=
 =?us-ascii?Q?pDuJ21I6joUEJGQOyYr1ziYoEAjWR3C8U/qYtU3+opNHGJgmZcYfRcucxQnh?=
 =?us-ascii?Q?/n/7Nq3/+0Dx9dhLEl5DxRZyxUU9BH+mu/I9EUTDmLRML1xwr5SXckBdjss3?=
 =?us-ascii?Q?5c1FFxUFJON2SqfDqpZtYJOp/vo0fcL8R79BjnKMQxp8ivqspYZ1WU4Xd2TF?=
 =?us-ascii?Q?9qBO6tYtNXBPcbDH5kfDEnhZPhgFW57+3dsy60MsbHivvhYh46j8ioqGr9Fa?=
 =?us-ascii?Q?Zl1TQJIG0ufUPJG+ynDg6UdrXKOriJaDjl6UyZTKWPi1Hn4i6/kaoCABmHP2?=
 =?us-ascii?Q?fx7XB5flt4pC48CmdSrCbgqVIwc5Uin9ONTRtcFXJHHtEHFWlrG1yXowoofB?=
 =?us-ascii?Q?qdddLMw+lybHiWFmPUuN4IZ47GGeKNniwTTBRLDD/z5D3v/FLKnXEncvhN3K?=
 =?us-ascii?Q?BU/8K9tnBazwqO9oQvB2zlL9cqg78pdhqJK5WQHEmEP3PAO8IHyHz7rl2AOB?=
 =?us-ascii?Q?ko6DlPouy2V9j2TTpIUIaGUs+XXiAXDJoudKhcyVP6fEuiRbMdrIuJk1uiQ/?=
 =?us-ascii?Q?zPcxRhlQ5Ex2bVVOEF51jv/T4kexGgnWP/NxzWlJKl4NARdZVFGFC9OS9ni1?=
 =?us-ascii?Q?w+zDnERZ7khUDlOSd+TOtcIZt5iSNKZPEYoQ6weULSDtIhqnM7LKBPulAEx8?=
 =?us-ascii?Q?qTkF6vf0zcR8fcES/9t5iTUko6wVdLMATstYDJdAKsylFCCD+XFGN3rI++Db?=
 =?us-ascii?Q?zZ/zNEJloXsy8y6Eo3dw7NJNO2kPcbN2K2e/FCJp/yIxtCQ5HHsZq7y9DOmF?=
 =?us-ascii?Q?h3juSm0vF6COYMyELz1gpo4ERTOPoE7TJqM0dN9rt/B0RjJ9N2k5iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWSxj9b1+hruWXxvXZYTywhxXaDLklHmcB0ln3Qzg6MvYPsmQnw08yqLO7qC?=
 =?us-ascii?Q?kVTialeWucbsXBhXQYdyITV64D7lltMjQArhE9mQep498bhMrnU2Q5i77gGz?=
 =?us-ascii?Q?AgFyDocCLsMLS9zmdOTtWRVWUmTKsp1+xanfqpMv8mP3CHR3IyopIA+lShcv?=
 =?us-ascii?Q?1yuwQGMhwLCijz1jc7Ne46aEQyR2MOJAX8ca3qrcYd80P71ZDj5ud+62zKmf?=
 =?us-ascii?Q?NlO6IMyrX5fMTIDy2ToWqn7TfOCuKqoP/xivsTCQrEp1T1narr1nBm4BVDv6?=
 =?us-ascii?Q?3L5J26v4Lv732T/wHtKeRHcLSwXpdPibJwVY4NV2rTkD/7leJ6KMd7WolGkm?=
 =?us-ascii?Q?G1FY+swgn+NHjrhwtqCol+MiTLb8zcJD38t9+f6CBWonISxfx+KD5OjQM9Xn?=
 =?us-ascii?Q?hEPgltfPP8Q1B61CALepuoRHL2C0lot3EwPevj7l7fEGI+nWo3NVuOgVeOSt?=
 =?us-ascii?Q?auGi2ETcN40K2nJXmTowqeUBBhy5ZiILuFCta3aJOWTTwzt6IsAkp5u1kuM4?=
 =?us-ascii?Q?BxxJSNjgqYHxd0YdBLN4WokgmN5Piwexs6FmoYa0XfSc5rHpoWnMJGSWcG19?=
 =?us-ascii?Q?JQj2CfMfJvwB1r6fibmWGYlErigy024RSkbDoDKadaLfUNbu9TIpg2j9es0I?=
 =?us-ascii?Q?IA/LsiwtMewT4BlwvIVMUh7On5oQI52UrBy0y/pQKoGPcEjxvEVMqjIU8M9z?=
 =?us-ascii?Q?dRf+6w7WIDBX01sGaORQmnAX18xuyE3GVRBH7ku7FhHTXfVPVBkxWElG2ugZ?=
 =?us-ascii?Q?RNb7pHqpbiGmV8iLOQKFiJ5tINQe26yglqtYhDAxUJJ07q9wHpMKu/U1A9RF?=
 =?us-ascii?Q?FBWbWGJOXKaHZLpm/I5sYz1Ilh92LAQvUszDi90D7Sc1UcXfUQhCmL9yzPyG?=
 =?us-ascii?Q?ApNJ38KLDVqC5elz703+DQAqTVEwFt/tSN1LKqZmrtWjWBrpUxfJiw54unk+?=
 =?us-ascii?Q?FZcTKMmtU8OhWefCq74xFHgiEy7Mcvol5UsveATElUxX8xSrA/3ShiGA82FB?=
 =?us-ascii?Q?suK4J4L43OI+ulAq6MD2oOh8RXR1pbgp96+/8ZqdkyxEer4/+56W40t7nDYv?=
 =?us-ascii?Q?Ym/2ac8kIgw4+IExQEfhkQCKtfaG9k15xBJJCAkW31zEPXNNlk9F0b4XQCCT?=
 =?us-ascii?Q?G8WWaHZJ8AjxKWZoD50B3Ov40fH9jSiXx7O8Yy1XejxWid1N29WyO6p07J+e?=
 =?us-ascii?Q?f+KO2XWCiY0nhNlF1WcSkP9y4UbFllnvGCeoDRXuOtlCCWGTlzxNh3nLEHpQ?=
 =?us-ascii?Q?p1v0H8aC+7+nqpSUEA6N/54kAw/trRZcCORJgXDBOx7yEgrf70j5gzTBsHAZ?=
 =?us-ascii?Q?9CTCHReoJMKXMgGVsfLXd6xoNG2ftZn4epKMkPIJqvUO5iQf9jP3zzhzya88?=
 =?us-ascii?Q?XkhIR158JtNaJ90+W+YMJjIwy6k3FrVyDaPFAHUnzdfNYfaPT94kc1aYz4lt?=
 =?us-ascii?Q?DNAFb8oGJ9NZeRGmZ0wG0/7Bo4WoN9/4IR+4wXzmI25J7qG0TXVFQEAijGL8?=
 =?us-ascii?Q?J/bK7EFNsMQstcnT2pXO2aCbs/zr1CQVum1y1miIBp8Q4eFeZfCWKNSfDG1b?=
 =?us-ascii?Q?HjhxqC44T3Qdv2yGp94xRxkGFU60vp88I2sjVkQX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f624516-647e-4e69-55f6-08ddd9b74e03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:45:46.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLe+SCxj+e0b+AZDmScoTXoEddrlIti5g68aLCkDoC+YdvaorIRlFVLe333YpmzSEkfk6zKJwIs36nMg5cMRZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7281

On Tue, Aug 12, 2025 at 05:46:29PM +0800, Wei Fang wrote:
> Currently, the Tx PTP packets are parsed twice in the enetc driver, once
> in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
> and is unnecessary, since the parsed information can be saved to skb->cb
> so that enetc_map_tx_buffs() can get the previously parsed data from
> skb->cb. Therefore, add struct enetc_skb_cb as the format of the data
> in the skb->cb buffer to save the parsed information of PTP packet. Use
> saved information in enetc_map_tx_buffs() to avoid parsing data again.
>
> In addition, rename variables offset1 and offset2 in enetc_map_tx_buffs()
> to corr_off and tstamp_off for better readability.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v2 changes:
> 1. Add description of offset1 and offset2 being renamed in the commit
> message.
> v3 changes:
> 1. Improve the commit message
> 2. Fix the error the patch, there were two "++" in the patch
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
>  drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
>  2 files changed, 43 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index e4287725832e..54ccd7c57961 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
>  	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>  	struct enetc_hw *hw = &priv->si->hw;
>  	struct enetc_tx_swbd *tx_swbd;
>  	int len = skb_headlen(skb);
>  	union enetc_tx_bd temp_bd;
> -	u8 msgtype, twostep, udp;
>  	union enetc_tx_bd *txbd;
> -	u16 offset1, offset2;
>  	int i, count = 0;
>  	skb_frag_t *frag;
>  	unsigned int f;
> @@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	count++;
>
>  	do_vlan = skb_vlan_tag_present(skb);
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> -		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
> -				    &offset2) ||
> -		    msgtype != PTP_MSGTYPE_SYNC || twostep)
> -			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
> -		else
> -			do_onestep_tstamp = true;
> -	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> +		do_onestep_tstamp = true;
> +	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
>  		do_twostep_tstamp = true;
> -	}
>
>  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
>  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
> @@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> +			u16 tstamp_off = enetc_cb->origin_tstamp_off;
> +			u16 corr_off = enetc_cb->correction_off;
>  			__be32 new_sec_l, new_nsec;
>  			u32 lo, hi, nsec, val;
>  			__be16 new_sec_h;
> @@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  			new_sec_h = htons((sec >> 32) & 0xffff);
>  			new_sec_l = htonl(sec & 0xffffffff);
>  			new_nsec = htonl(nsec);
> -			if (udp) {
> +			if (enetc_cb->udp) {
>  				struct udphdr *uh = udp_hdr(skb);
>  				__be32 old_sec_l, old_nsec;
>  				__be16 old_sec_h;
>
> -				old_sec_h = *(__be16 *)(data + offset2);
> +				old_sec_h = *(__be16 *)(data + tstamp_off);
>  				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
>  							 new_sec_h, false);
>
> -				old_sec_l = *(__be32 *)(data + offset2 + 2);
> +				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
>  				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
>  							 new_sec_l, false);
>
> -				old_nsec = *(__be32 *)(data + offset2 + 6);
> +				old_nsec = *(__be32 *)(data + tstamp_off + 6);
>  				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
>  							 new_nsec, false);
>  			}
>
> -			*(__be16 *)(data + offset2) = new_sec_h;
> -			*(__be32 *)(data + offset2 + 2) = new_sec_l;
> -			*(__be32 *)(data + offset2 + 6) = new_nsec;
> +			*(__be16 *)(data + tstamp_off) = new_sec_h;
> +			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> +			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
>
>  			/* Configure single-step register */
>  			val = ENETC_PM0_SINGLE_STEP_EN;
> -			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
> -			if (udp)
> +			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> +			if (enetc_cb->udp)
>  				val |= ENETC_PM0_SINGLE_STEP_CH;
>
>  			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
> @@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  				    struct net_device *ndev)
>  {
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	struct enetc_bdr *tx_ring;
>  	int count;
>
>  	/* Queue one-step Sync packet if already locked */
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>  		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
>  					  &priv->flags)) {
>  			skb_queue_tail(&priv->tx_skbs, skb);
> @@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>
>  netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	u8 udp, msgtype, twostep;
>  	u16 offset1, offset2;
>
> -	/* Mark tx timestamp type on skb->cb[0] if requires */
> +	/* Mark tx timestamp type on enetc_cb->flag if requires */
>  	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> -	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
> -		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
> -	} else {
> -		skb->cb[0] = 0;
> -	}
> +	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
> +		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
> +	else
> +		enetc_cb->flag = 0;
>
>  	/* Fall back to two-step timestamp if not one-step Sync packet */
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>  		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
>  				    &offset1, &offset2) ||
> -		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
> -			skb->cb[0] = ENETC_F_TX_TSTAMP;
> +		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
> +			enetc_cb->flag = ENETC_F_TX_TSTAMP;
> +		} else {
> +			enetc_cb->udp = !!udp;
> +			enetc_cb->correction_off = offset1;
> +			enetc_cb->origin_tstamp_off = offset2;
> +		}
>  	}
>
>  	return enetc_start_xmit(skb, ndev);
> @@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
>  		if (xdp_frame) {
>  			xdp_return_frame(xdp_frame);
>  		} else if (skb) {
> -			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
> +			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> +
> +			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
>  				/* Start work to release lock for next one-step
>  				 * timestamping packet. And send one skb in
>  				 * tx_skbs queue if has.
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 62e8ee4d2f04..ce3fed95091b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -54,6 +54,15 @@ struct enetc_tx_swbd {
>  	u8 qbv_en:1;
>  };
>
> +struct enetc_skb_cb {
> +	u8 flag;
> +	bool udp;
> +	u16 correction_off;
> +	u16 origin_tstamp_off;
> +};
> +
> +#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
> +
>  struct enetc_lso_t {
>  	bool	ipv6;
>  	bool	tcp;
> --
> 2.34.1
>

