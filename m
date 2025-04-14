Return-Path: <netdev+bounces-182067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C6A87AA6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245941890879
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701F25A626;
	Mon, 14 Apr 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fk4du96b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0661A83E8;
	Mon, 14 Apr 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620171; cv=fail; b=VZHxpom+Ye8dtBe5qFRGEfu7HW99pq6sHbqBkfpXwSOxMRwRsfsOz/Yzseejcu03xc5RSsj560L5kC6sObJtT5Zzm2qnLfS4Hu7F4h1YhBhpEs/NDrag84f+Tql5MRhOHrHnDZeIranQZz16fPOnyWxSI6RtohPM02xDdj5+kRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620171; c=relaxed/simple;
	bh=dRLoek6jdUSbB5K4R2SfBYiK6WvtucZXpokVua81k0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lYE2OGsfKygZwPOf0gTIgs7m3bJxK0ViM5Z2kPUk+HI0o99jxVHqSBJ2GIao5a/y8t7KWcrD2BWKy5zdGDSQU9dIV3yawz9JbU9VGvu0Ncj85COaPoBqiT4rX6GYNRB8nL/LZPaYXuLPQNWzkqb4wO898Mmb/5VfbYSqV9aEJXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fk4du96b; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLYtkjAmmfq399DKtgorihQ4/+otNXpkAjHK766WnTEluh/im+3vK+psODisAPqn4mwyspklXMiX7dwLQH5n2KIvt+SjEOGnUpQHDp+sDsZcMf/GK47Ffphqysf39EmZ14S2lAbMmasI+p57ZnLVTwqhqdzBExM+AQAZggavarNQPUvPgIz20xsBdRIXJWw2QQ2ehXMVzn8YtSqrr2GdJRZyqenN0ZBpBmM2/iJxOftaiUpInL5KSk+wetbm163A2z2BQS1UD5E1EYTA+Ix3tlPNu+kX5HtBemXcROlGMmhxE+/Z9f5wMwdUGyTYYXdWQbFFFdms5lByOSTevlQYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxfduRFEtvt65IfFcyZO5TcjMkHebX5LBbsq0fIrIUw=;
 b=TkLeztgGjNzH8uBNkyd/oAa/TsWusQRmv1j2NOKmbnDcrKT0yxlwIgRqPoNTXe/LDHzueOs6DHczJnckmvS2l1YgjeKlsGdigyYtXtPILi6Mi5sbzFiZpX15vsrWT7dfXGVXnTvrIMrAvPGJcHTOiEM3KOxxoR2ry3Vnu/BdfbeTat59+b4ux/K9S9L/9o6ZjAItx68WkDkW8iyzAjvVqXXS2MhcOTQ1k3Gp0nHcrmczw5xnr9VHbOiGatFJFOARWCKaVQswmyG450a4PWs5bv7WlvCUIN0wg58qh6cBSStBuQ91ZJuAgnm/Dn9B3rmeMBgm35ugBaLW+CTiNsB/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxfduRFEtvt65IfFcyZO5TcjMkHebX5LBbsq0fIrIUw=;
 b=fk4du96bbFjTxqOYYaDA5dM8kyuvm5zIBQdLO30+X5ZAxzZ+bHKcIF8sVKLqTN7KOANDJmz3UcpuHHscu3IoCgEBxcbdOATq2hbBg51kzu+5Dl5NGonb141gTH8aFWiaKNy1l71/KIn0JUiHTblWbRjd3IbbpxSurDEf2hR9wQrijYMtvkFSNrs2ZuPbp6P05DagScZ+uYacyJjz/d17/oEnge5mILi/NJQInullaarOESU7lua7zBZT6P9/XW1Jk8TkTqi8A3ttLewfb99gnkcxGI+Ihx2FYhycvTu0EuL8n2U3T3JFPHFS1aqnAgvM40+pMfNMLgc+D9Ok0OTJAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 08:42:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 08:42:46 +0000
Date: Mon, 14 Apr 2025 11:42:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v2] net: bridge: locally receive all multicast
 packets if IFF_ALLMULTI is set
Message-ID: <Z_zKfOHxHRr0EC5Q@shredder>
References: <TYCPR01MB84378490F19C7BE975037B1698B12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB84378490F19C7BE975037B1698B12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a16bcc-7ed6-4b15-e042-08dd7b30543e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STACYPLCZkzeeRQARQUftenFngoSHoNl4VW+IOS9uXcTXghSx7J0doQJ7vNW?=
 =?us-ascii?Q?QbNhcxnlVPPrjKTzYa3K2vLpSiPgiTJG0nbB98QqtsrzAlomq1kIl1OcML2r?=
 =?us-ascii?Q?KKci70k80AdlykjKHdmStaXSbn3+PrTY6iZ69++HK99T2V8bQYEun/prKo0u?=
 =?us-ascii?Q?1VB2e2YExnhcXHVmhbuhxu7Qp+GMM3m32G4MW0C/kjtT+vL20D5XfwxaWebU?=
 =?us-ascii?Q?oPWGgqHDiBCHcRVRmZS5QjAz4dUFo9sbDBp1TsrwDsm5+t2oX4Hai6leBse3?=
 =?us-ascii?Q?HIye9kTpJs4ldV9Q8v9x3XPyoAIFZWUuR1xzh/S980FzqNao4m26SZl9XvJw?=
 =?us-ascii?Q?7ZjDHoxwnlOhm7nCJzAH/2Rndz/r10Xw+9WLWelQlV135z26S+iHpYUq5Hkn?=
 =?us-ascii?Q?0swNzywRpmRR1Axuj901le5oLXh3Z69p35MWArdCM0fqHjLkxiE6c0AK1mQX?=
 =?us-ascii?Q?2NlKBuMECE527GG1Rnh9MVOV5In4xv6WBI6hsL7cTCM2fAJ5znCTUCclCKpV?=
 =?us-ascii?Q?39DB/0gTN2wVdmaAvdYL2WaGz81yHKKY5q7aLT7ZcZDUUHdyslLcZ8KUUhbR?=
 =?us-ascii?Q?5EVNzMOI1/IIn63RxJOocFklJkuA1riPdwCpgnxtxs4pD7IjHdh4SyPl8nVq?=
 =?us-ascii?Q?KSgL6+Yutb6VRGu7phaXgRZyUgKodL72qdpNMrp1eeRnrb4PjJo8SpLNNK0n?=
 =?us-ascii?Q?ptrBHYom8fvonI9LbCBND1Qjcm/i0yC3b/PznphjOlwhrwvGncAK8WB+BDd2?=
 =?us-ascii?Q?GV0g70+yLoafPCj7zMZbF+wVCNrDHAKVJVexNL9Hvkd1QkxO2FIQzz9QzUhu?=
 =?us-ascii?Q?f0Gw1rv+EN5d82ZBAIGNXbD2vZYhjWqIRtkYJrBO2WP7RZ20+K3TPcVPg86W?=
 =?us-ascii?Q?465OBcCYYKWdS3r1XZzTDrTd+jzCDMvu9da5kbNnKLGYObw45FiD58fp+L89?=
 =?us-ascii?Q?Xdb5V5gVXV+FgccfIGJM7j28K4NkN6qRLSx83942tmFwbX7F+4RcYg9eog8A?=
 =?us-ascii?Q?aj1VxEwNy901uZUX4WLOShWJdOtU5Fs7VQLsSNDnknfx02wFZf2Gfx/Raunf?=
 =?us-ascii?Q?QVolq+j5y1Yy9KaOTIKyQbO1l9UQFSwuSwOD0ieqnlXHREAAAz+NZ0uFgZ0l?=
 =?us-ascii?Q?L/+dD9grvZSLnNJuX1znB7+Uo80a0EFxQ/Kz71tkpQEE+wWKgyx3MwFgrafc?=
 =?us-ascii?Q?8rJufeKg3JucM37VFmyDtgXS1ORQ8lwhuppj0DDF4Vm6rhrz8c00C/J2xD1Q?=
 =?us-ascii?Q?mqUl5cISQgLrdo/BJY6JGbmCX01C+WvcsX8NH9Y/Zl5ZKW84kXd5o2RN6NPO?=
 =?us-ascii?Q?RuGRiO0m7L0oFf8o3CAIujgO8Lwc5yl47Tm+xaOacZIq7pL/tSmc/Vuypdfv?=
 =?us-ascii?Q?1Rpw9gPtYZ1soQxjaRQWwmF5S8U3PYwboArbcNsLUYhaeY+TlFys2Z5XPZvl?=
 =?us-ascii?Q?WPrgNmXn31U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XpGeDkrtmYRnme3sUCYmnmHMgw7NViEXsX8ATkP/r0FVvoarLThUhZ8FTvBv?=
 =?us-ascii?Q?ChM5GkoZiwjpeuCB8x6J9ZVl1YDO+lRNQoQttbBQSPcfrBpwwUxxp7x2WrJ6?=
 =?us-ascii?Q?9HNe4gsxkcVTAFXKGez9OahVWcVREfdqNiDxACG5miB86NmxygavIaqOs2YH?=
 =?us-ascii?Q?Z6fJ0bAdk+czpf9re/ni/6hVanAUygoLtnQSCPitjjVmBYUdcw7stEDXzf9j?=
 =?us-ascii?Q?sF+chW7zNior3QTz2ll4DlINi7OPv8UHbC5vRroPhoMxfqRm35PWOVNDCKJs?=
 =?us-ascii?Q?fCiacqbLxUC9ypo9XxJQJqLWneipTlya9EISdyfpD8B6pk39cdWLZbLVnlpI?=
 =?us-ascii?Q?ORhvqk3uFrMqDL6dAp5top7T0VNuHnYV/Nz73BBB2wlg9LuCiUqiQeKNIwEc?=
 =?us-ascii?Q?2Hx65cm5JxZue2pFjplg+3ilrOqsQJm/euh4vd3t62ZHb0VO1+jpiM6a/4uT?=
 =?us-ascii?Q?v2aS601yW9GWz9TD7YBazvRNf0UGLLIhGprFig5aeQL8XzUgInLhf9IVEhyD?=
 =?us-ascii?Q?3BiOERnKF91sXjFQOq2qeXFxOlXdq9YLXHkPgY8ZVGcXik8/bQGmln5fVHMg?=
 =?us-ascii?Q?/NIvX6fJBjQF5tJ1TBUSh5EvBUOEwKdnUoJ/21z3b5A42FPgvokB2mcthfNV?=
 =?us-ascii?Q?0lVtW/D6mIKn3mm4JRvMRXXk1xlb2a9CzGiMDBUBDE63cPwL5rdGWf36H6oG?=
 =?us-ascii?Q?ique8luI2iRi+6R7FVuI2E6ouZYHdLiYfJpMZx9+RDuWI7WvN5+f6ScRegX+?=
 =?us-ascii?Q?YtZFjO0oIzV+aIWrxS/OURusSOcuMwi9h6kC/NW6GB1wgmuit4V9Fx70S13E?=
 =?us-ascii?Q?0RsT4thrL/twgnN2BUFQNjFY+PXz5DxAMCRL/FB1jC59Jugr4WaWPM1pcakJ?=
 =?us-ascii?Q?plMCZxQxpqCBx67gQqRoW5i/TvVGB9U1Td678Kfjnv92BgtZSJCBQqDyGPE8?=
 =?us-ascii?Q?Amo4bAIZzu6ELpNdVfyb6g1T6A8Ceea92bAp9ean7t74G+JlpNqcG6epTsHh?=
 =?us-ascii?Q?GoCEUI6E3RHtXL1n7DVmLpUedhhp8hcZFKaBc5HBtDIrHVxIhg24Z5TFHdA9?=
 =?us-ascii?Q?rAwCs/0w+BLD2S1jEEJH/whSvAWDDrkf456+iWaNIVg67kfvsaTAG4xJdONm?=
 =?us-ascii?Q?ioSujgLdfmPe6tQZId3FR/DbCevc4grybDsNJLHfp35NmpB9lDymjIQYMAgq?=
 =?us-ascii?Q?ZkL9si1Z4uikaFZPowvXExolmI+sTYNZT+YdTOjkSDvTfDXYMzq7Xb165EV7?=
 =?us-ascii?Q?zEx9KXCVx5HvgkpX7CCyXpg50dslzWhyNCNstvlistlHBmo5ZIKBJoic7PmA?=
 =?us-ascii?Q?umRp+X4D7ClBJ7QyC8FrZ14Ckv9zkdQz5K1TqkKyYpU7q4y4kaAC0yYABuyB?=
 =?us-ascii?Q?aTwBL5TSYHAp5qxEjKCtqYTHpDb5cbRbWwZL1qdpgb3ZGXgyRCOkbaRgAzh+?=
 =?us-ascii?Q?nncZon/E8Q0kJev8bbXVD/O1qs8spO9toUhho02gkLz2aYuqslm+CTn7rENf?=
 =?us-ascii?Q?lvQvswu5t5vL3w6sPFf6ob/LTckbzDgA7qu3R/5Px5wDAHznstPVj0HlscaA?=
 =?us-ascii?Q?vNgissyly3OWkb6vbxBOmXYOEw5fznaOwfV/XLMv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a16bcc-7ed6-4b15-e042-08dd7b30543e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 08:42:46.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzYAxp/AfrjkeyZv9yq9mYeWz46OHaXXCdRZVZ2MjdLm6ZiNBTnW53YS86cr2FU4WpZ7g6FNnQPV5pncDEKDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

On Sat, Apr 12, 2025 at 09:16:13PM +0800, Shengyu Qu wrote:
> If multicast snooping is enabled, multicast packets may not always end up
> on the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received
> locally, let IFF_ALLMULTI allow all multicast packets to be received.

Would be good to explain in the commit message why this is needed when
you can instead configure the bridge as a router port. Felix provided
useful information on v1:

https://lore.kernel.org/netdev/7932cd23-571e-4646-b5dd-467ec8106695@nbd.name/

> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
> Since Felix didn't send v2 for this patch, I decided to do it by myself.

Felix provided his SoB on v2? If not, "Reported-by" might be more
appropriate.

> 
> Changes since v1:
>  - Move to net-next
>  - Changed code according to Nikolay's advice
> ---
>  net/bridge/br_input.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 232133a0fd21..aefcc3614373 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -189,7 +189,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
>  		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
>  			if ((mdst && mdst->host_joined) ||
> -			    br_multicast_is_router(brmctx, skb)) {
> +			    br_multicast_is_router(brmctx, skb) ||
> +				(br->dev->flags & IFF_ALLMULTI)) {

The alignment here is off. Also, you can drop the parenthesis.

>  				local_rcv = true;
>  				DEV_STATS_INC(br->dev, multicast);
>  			}
> -- 
> 2.43.0
> 

