Return-Path: <netdev+bounces-96443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4E8C5D9D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 00:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD531B21669
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49515181D03;
	Tue, 14 May 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ia/9E6qg"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6F181CE9;
	Tue, 14 May 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725320; cv=fail; b=fJnx4VMR8smEfwBdWUpWEcjJ3wAjDOltKr6DlQfihDqLevLxHrV9ME5HQBOkZb04YQDY8YPGIQRSTASbJ6A9Q0rGquMV6pkssE4ksvNwVdMlTNkx+JyOIgpft3dauUBYe9qLIWdAY+gv7yI1Mte6uyHVGSdaj9BLxM7cmHfRAqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725320; c=relaxed/simple;
	bh=PlfUNIwQKE9D7h8HKrjTYEMJ2mRgfXb3DUvT5tMm31k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+iML/JcKzlej489TaQF44t1LEZovMDEBFCQNfLIy6J0UgH/c1NOkQ1asQJB/lsxtXpJXbARtTginRcGI6sJ2OAM9JGHzFJZFnQ4q3FjlARUo2rAfkWA0b/RSYv2FDsBocWNa6FOBtbY+MQoxpC9qNbqrze4kt2Z2i3lmXMPDjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ia/9E6qg; arc=fail smtp.client-ip=40.107.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt7gdsZ4j4631ZlhqWEyANdtzC4N0a/9duDysz5UUWCeBgqHcIQ7dvrq0PWUR2JPd3yN/CYKICIkYjkMSlntpdjZ5aS/Azic2jZbm3P03GfSJ2ES0P9tkI6qHKsOqqW/ulY9ZGu/iYgi9xi+VL1YdKCxEd/cvDj3p1eGhSUMZiMdVrifmB9GfEkv6Xiw8krMx7guug1PlfPxWqpy57gJvvR0jP07rvpF2Xfuysx19BRdFclMnFw4boLEVFxD9I7T4cfHdY/pV+0AyMv7HE95BpjRt5EyHNSsvDn6QFVsZDC6dJPTNMkXxEGd0x6yxq/R48EIJHGySSII9TjME+I8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5juzmfJRIQe0PbtDCy5r4P5A6Y6I4t/Auo37LCYOnM=;
 b=SRYUza87ntgtULPCENvuklsWVmQXN/GtOvWvmhsG8MizHhmIT+k5VsMhYnaE2hdHR2KQ1UiPjN4E5YxURdJlOe8MUljbVgpSsy+AX16hD8KSk88978myzwru0+S79lzV4s88vV9oTdXlrozQW8btO2/NpaNZVd5nFR87RbbcbUcLQyUyvuEWwfM0K9i/1zHtRo/6wFCvGHivfYtLShTncSjpSwKQzQt95RPMWBQ6GC1G6wabYf7lefWE/r5/huzQ8izlRX8JarVEAGMgg0Y5v3sdtXORQ+JkWIcCdW1SG0EPe+ycnUKg8FneH5TJini9hkU5IvUUO1wHYGPXiBh6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5juzmfJRIQe0PbtDCy5r4P5A6Y6I4t/Auo37LCYOnM=;
 b=Ia/9E6qgu8I4/g2Ivk8N53hbY69qARZq/OytVVWxvCj23lhltaDO6Ymlhuu87cQjUP0HyTzPK07MjUkwOOCBq0Vio5kT1V7tL4jN3h+iGiXgstTZcr00GrrJuxuyG5mVXGySR3wG0vvh01RHhXK3Iqb/Cg7KmEC8weF3x1OBhUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by GVXPR04MB10202.eurprd04.prod.outlook.com (2603:10a6:150:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 22:21:53 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87%3]) with mapi id 15.20.7587.026; Tue, 14 May 2024
 22:21:52 +0000
Date: Wed, 15 May 2024 01:21:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: lan966x: Remove ptp traps in case the ptp is
 not enabled.
Message-ID: <20240514222149.mhwtp3kduebb4zzs@skbuf>
References: <20240514193500.577403-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514193500.577403-1-horatiu.vultur@microchip.com>
X-ClientProxiedBy: AS4P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::7) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|GVXPR04MB10202:EE_
X-MS-Office365-Filtering-Correlation-Id: 515d8c91-7be1-472a-2f2e-08dc746441b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sP5vOrC5ABdHrHPYrVWHtZ4CptcRFw71zWN8TuR+cGHRxj9xfmiGWxT7cZ7+?=
 =?us-ascii?Q?zS8LtJQ7wVN63oHhTswXlg5N26yJsp0fm7lebrQSU7V011Tqhw2s0GqqjJKm?=
 =?us-ascii?Q?Ji9A+BcDiJJWC4Q+Jcn4DXJOVeuQovQOIt5BydXmMnfER74J6e3x7S87kRtV?=
 =?us-ascii?Q?aysh/WgKv6iNQl2cqLRROjNjcsr5tdxSXdOhTNBdPY/lM3gW13QPlkuO5dq9?=
 =?us-ascii?Q?lYaW3GNZsSbMJDHLfWorbxqgsMGyNKQqNPKUeA3nunJSc1qdxBFwjkvkds+a?=
 =?us-ascii?Q?Dyzm0PFC7Tr2G8D4EsnZrOtsn+G1AzWK3TPON5b26X6+wSI+54VMcmAOXIsL?=
 =?us-ascii?Q?cYmqb47S+vU+/TRj+iCsFYOBe2pcXk9gJbVnubaP7jXUVkE0+yTX6/QViqnp?=
 =?us-ascii?Q?tx0h0kBaaDbi/kntDM7cIOutAAPfb1RMAO7D+cYlAwHtAMf8Okn7lf9aa2ZV?=
 =?us-ascii?Q?XrPCeD81/CAWwH5zd65UjvC4Sb8Yd7GhaWrpqzMdYSOGscxpi1TaO0JZNoX9?=
 =?us-ascii?Q?gLDL2fu2uOwhOM7iy6QGvUY26OHJnDHRmUjY+x/bXVHdvpm2eAq/F0v5v6za?=
 =?us-ascii?Q?3fyJuQSuTjZ/62UPzkzVz8aToUYTGQqePD4WnTtsmH4R+EriTXUaKtjiLm4L?=
 =?us-ascii?Q?nBpV2jjim9s2bU7itcqL8/NM1FCp4aP2TXBl9/aAMRxQZrt4iRnqKMvR+4Dk?=
 =?us-ascii?Q?bFK8JAGfN5tKMK9kXnDpUhgizVl5Lh/DeTdkE15UcT4grNra0SrstSLaHIgz?=
 =?us-ascii?Q?Iz5EynWRwODKihKxjmCpZFYS6g/lNWNxHFwYBRedLaCi5jnY7RuSnVXbvcMH?=
 =?us-ascii?Q?m3qnvy0TNT8EbGvId6kXR/zDOnSYJPAmAix36a63pdQ9+j0QfYd4+qAAIq0m?=
 =?us-ascii?Q?sHJwfsIXWBQxDnMAg7YX/OmuqVHcdJA4p8TvBtcC+6qvvOpzfazskUoBUrdz?=
 =?us-ascii?Q?3Xq9xZljHq6sGbpVLyIWoCPhMwQgGeT6OUR60tSoCLkZ5ioFLK3ci/h9FQRZ?=
 =?us-ascii?Q?2YdgAMy3ILWZwUKo010Kg1X3PP++5wi7asO+d0DY03clFtIAl9t7cwFSAuQ7?=
 =?us-ascii?Q?BLts2xHXJxjXIHq7mpbxNnGT9WM3gEz8Xbd5NWDDHzUdbrLMVWWg648vV+2Q?=
 =?us-ascii?Q?NqAiOUO/w682WRwHGNzctAPbPmmQcvE9cAeUpigdVvWSPkZjHAtYmNbrzzLA?=
 =?us-ascii?Q?8lfLgIJ4AiNRqLdUYDb+SImInqQNVljLzxU1cFHDamkgwMRJc5fpmFi5aMBU?=
 =?us-ascii?Q?JOAINE35mD+z1bmS7+JHcsHQS3tWCvc8xxnjjPkJBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ck01MvhtSsm4f5NtWmPR8KYgpti66fz+34NYeeWfIt8DzUXx/XycX7849kHh?=
 =?us-ascii?Q?PsRhC4ICj2qeJ3bhQqzGZ0WvNDC99HtHhhUwNpyYdhPiIvNe7tSMIQ/IMTTz?=
 =?us-ascii?Q?M97cxybrQTgRxm+VcEY8CuHZiY4e71+H2cqQ9bbtplJCMc01XhvGckISZsR2?=
 =?us-ascii?Q?ZaKTqx9hFb1rWmc/Gv1unoB0KonQWT5Q29NVk/KpNEFcY9jrUgV6/lz2b002?=
 =?us-ascii?Q?a1VoiwYKvuOUaLZ+mWfY4SY9Icxf3xwZGV0feOmL5E2eQOuAq8ts0kjUZvIJ?=
 =?us-ascii?Q?D0FzTgeXop1tytPqh8DPfj5QYL2Z3UpWCYZPir7tZhp8/oDhuZF68hQcXg+a?=
 =?us-ascii?Q?m2MeDCN1/w80vi2iyBzuVSeuckFaVbxse58hTU5FgsbkED+CA3wvIkdEyCAU?=
 =?us-ascii?Q?uqi4B3Cl25jNkcMryYOnM0aPyAWarslB2IoiqWX9kY8ocPK6TiuoLvnkq8er?=
 =?us-ascii?Q?gmeLAXmodSS8eogu0em8lFx46m1l3zmbighOEQH1WEFqqhTmJd5Nbt58PZj0?=
 =?us-ascii?Q?SCJr8m7USusYKAYPsd+7FSEwaH5LvgvTGTN1Htjlp70ho51dAz1V9EihP9HU?=
 =?us-ascii?Q?CCc7do3IwH/PeBsnqBXyVKEpqCBVpSCPkRu+2FOU+oh/rbCUv/YOb54L27G+?=
 =?us-ascii?Q?HNxC6YyOt9b+ihN3K+KUdeWnF1ZjPHxA9sYZrONOI4MnoiZzKgVZoQkaYADh?=
 =?us-ascii?Q?X9hx0C48riC90xGrlNg2ZTpisyZJntF9JwDxXm5RtaY8esz0AVpzpgfIvYWY?=
 =?us-ascii?Q?vBXcm+UKXUDonqRW6lq7/UCLa5DSQOibiR+yN+i03CiK5Y6WCgdkh06TRBCK?=
 =?us-ascii?Q?x15WvEduWxFp2dKAXhOCPy8WbRizen4Xepcg6nJJhxbh/SrexGR1QnHpVexm?=
 =?us-ascii?Q?JHXeVG6/re6p7ds3vhWShMa8qmkKkO9BUCqC/V7MWg6oV9gzq+wQbhArBHeX?=
 =?us-ascii?Q?7Y5S8GojF+yqP/OEkwq8250iuNs+dMY88vILx0DKqQASzFLmkvQdpRjvOCiG?=
 =?us-ascii?Q?h8YA/06lPvrEZke1mEueic9HvmphX9uDWd52w1fE24ZXv1IFIv6xWzvGrss2?=
 =?us-ascii?Q?8BMDZoiXe2qyAS+NkeN2iZGDnGTSViuxyHUoIEcaiaOeAQEhcSS9C9+i+ms8?=
 =?us-ascii?Q?GrNQ3/5nfgKRFmSjOykODUA4eVH/3GmX/ngg2CgMqfQ8I/f1yyKUjsHQDYlh?=
 =?us-ascii?Q?BFCx1B4M5VOxgoEZa4SP1BXU0in/OqVxWZSE8QhIepE0SRNT+gPVOY+6skf4?=
 =?us-ascii?Q?iyqJwCqEmtu31oxMz/JovTiCyO94nYXH45yt1pUUeWtPzbXwPh0z6fsxl2Jp?=
 =?us-ascii?Q?wnYlqkUdFpEn5ZKcE7vshvWQemFgpmboA/jDzY+Q/7+nxp1RyxwjPpCVGZHg?=
 =?us-ascii?Q?g8zaDU/E1Lf7kAY2YFuy6Zxopux8UUBKOZ/NyFC1J7xec2FUchRcNRl+gVya?=
 =?us-ascii?Q?sRViVf7IS3TsdK6rv40DRT97GtNU9xb7+d5UCcZW9vKDcm7w3pT7nTQ1ENCM?=
 =?us-ascii?Q?UOzvohFn/f+9Ng/I1ifES+ELINgKcuJaMSaLfoG3ZKDUGhJeN+uJC9eUUSOv?=
 =?us-ascii?Q?MhvCNsU7uWtFXKoh6X+AlgYVjX5yszcJpdEOZf6qGbv4TEyz/3k72h2d5ud1?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515d8c91-7be1-472a-2f2e-08dc746441b3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 22:21:52.8569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ/XngKwUQ8vgEYHiu4D0K780Jcfy2A7S+o6FeNGdtPkCAkHjIXmn/ErqBfKszPXY8mjApnD3S6tpwqk8hO/ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10202

On Tue, May 14, 2024 at 09:35:00PM +0200, Horatiu Vultur wrote:
> Lan966x is adding ptp traps to redirect the ptp frames to the CPU such
> that the HW will not forward these frames anywhere. The issue is that in
> case ptp is not enabled and the timestamping source is et to
> HWTSTAMP_SOURCE_NETDEV then these traps would not be removed on the
> error path.
> Fix this by removing the traps in this case as they are not needed.
> 
> Fixes: 54e1ed69c40a ("net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 2635ef8958c80..318676e42bb62 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -479,8 +479,10 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
>  		return err;
>  
>  	if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
> -		if (!port->lan966x->ptp)
> +		if (!port->lan966x->ptp) {
> +			lan966x_ptp_del_traps(port);
>  			return -EOPNOTSUPP;
> +		}
>  
>  		err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
>  		if (err) {
> -- 
> 2.34.1
>

Alternatively, the -EOPNOTSUPP check could be moved before programming
the traps in the first place.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

