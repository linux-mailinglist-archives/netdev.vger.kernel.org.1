Return-Path: <netdev+bounces-207504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE44B078CC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20AAB40733
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E98626E143;
	Wed, 16 Jul 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9H+8O+7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740C26528B;
	Wed, 16 Jul 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677444; cv=fail; b=iMRAxHF6yLbMMMHeCBpmVaRkcy3eFfbpvVCYctobMS6/1+Y9Fjgx3usG78ODtW3CS8tdG5f7Is3dJZc1tOiA1VQ4ehDBMXPDRKW3bImeyHJjqzUzUTNPuDj1q27tCez2PC+gEeKPVab5VL865zihigzM4C46yLolxENYiYrGnLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677444; c=relaxed/simple;
	bh=qPn9nwIprxhXeGjNe3oy1JQzQ5MH24M98sf+uonZ3Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/xbJF21aTt6uoBfpkJY18Tq0xVXxAiTPsZ33uGGI3zotgUGhw2ZtvoaKkons9W69BtU9jNE/IFzjSbKb6QwImoKgQFapoIscp0mI/vRUxE00SXyHHZLsCHc/ZEkKOUfbqsONg4zyEFU84CErjAjWb8EVYByWdbbfmlLFhT2sl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d9H+8O+7; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzRFzIrqlOGTpfLyoRuvwIRzzhsxdNtgcI0qyz1B84KTAOuSCHavkmUz97AFBQSPIegLs0hHHguK6GGFpOsA3h0fq77QTAy7V+ODIG0piE63s1C+hnm5BO5EWXYkNdCIpCDF1tRDq2PDhMaV2M0yt5RbtTVmj1ZzQH94e7ZDlk4AULVzfRezodUFSThxrVzFx9FHNujwBbaHEXuv155+j4cEGNZDW7taQW1PRq/f3MKRFyBhJd8JRrXy85hisglLN30Kr7lZEhBUZpHGoObkVmnXZmYnbx9rIGj0AxHUvL7NI5OtoItORb7fNGnIHm0kNkwgL5SPGZPVYVFRZ4rZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auSQlaCF9u0IWTnOngBewpFirOBEk6kymYt/vvK9swk=;
 b=dNtaDiFM14anGrY0g0JeTMmOyM9GTwCX/AIkxVKxw8DyPN2UExx17G5xVgND2kpvnw55PHKplzrvL3xiGAIP33tY9d2gNFFWd6LelRsC7os4/agKoeCTB40WRsSfDDX0epvodSR6swfXU2l8h4C/DPGzr4yHJGlFAHTeqiuFZ0CnR55uh+WvS6htRi4TH/ICbtYnPis5PQxBsC55r19aaTqy+5X4H+CCeC3vfyeeY7+R+cfCLdgm9+tjeBt6FzJ923xsZyarmWurgtqNCb6h4HNRqJGYiepWdK84PeMBR6ZbJyHvukC7dtxDb6MHsoJCn4tDa52LP01A0oQh2dXeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auSQlaCF9u0IWTnOngBewpFirOBEk6kymYt/vvK9swk=;
 b=d9H+8O+7+24CBHwWhjJOPz3clNMSU2U/BgSub/bFxv4DPy+bSlp7rVZX7AAa6PInxOSQeaIsnm1zcRt6rkq14WBWq6HLxaNydkWL5N1HJAFrETy0WY2CyoWJiBnsxcARyvXvK26RRN3p/4FGRwyx3lJCZwanWQaFH6oAg/GNrFpNzxEOjwLBrqvtQPBLHTJ21OTFn9Oz6KZpUEHALTk41SF9DZ8QWt0afk5Lzzjmhc7b6n7zDeGb2YLOWDHwvIfB8czRMAgIClUO22esZFVjzXOPailIw9jFC1RVfVwRF6GQCt/6hAKgWKwTTFtNyb8US4lfD0dYyb6x6iTnBX4k0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Wed, 16 Jul
 2025 14:50:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 14:50:39 +0000
Date: Wed, 16 Jul 2025 17:50:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: bridge: Do not offload IGMP/MLD messages
Message-ID: <aHe8NslImAs76-u5@shredder>
References: <20250714150101.1168368-1-Joseph.Huang@garmin.com>
 <aHdF-1uIp75pqfSG@shredder>
 <67753866-5237-4758-9bf3-d6a8611ac179@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67753866-5237-4758-9bf3-d6a8611ac179@gmail.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 513ec4e8-8626-4d26-5230-08ddc4782194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0eP82p1my6I8XkM7hQ8S0kfmQiSQYSL+fi61vhWhoOGowZbg93GkgFLX2ps?=
 =?us-ascii?Q?MUuY6+yUyaJjyEW9/Z8EKqLrii5jRVquLtAE+nYrZPqcSOEY0ue/umRgOmqZ?=
 =?us-ascii?Q?jNAc0jumVt+v1BC6SGTUzmPzSTTY8FwE9qY5T11HgOvrSUwRo1qq6RsDFjxv?=
 =?us-ascii?Q?Ys+4FbsMzUmecg7NUs8wQE9mHaJkjU7unwFnIfMbKBoCm/3wBHnJOr95tLxh?=
 =?us-ascii?Q?HEffcKM7pX0I8gy8vJWThMnm+B6WMfYGdi9FzZ/hQ1hp7n85al/eVLCeHPGr?=
 =?us-ascii?Q?huQ/O2qbmuqYvFyOU7BnwIy9UBei1YOSaamRFMj0uVQLFgTKWjik5tKxA4uz?=
 =?us-ascii?Q?1Ho3lkPpu8eXxT0LAecyrGm7szFpti+QtmsYuGaNxZGtXfmi/AEsMX75iAmU?=
 =?us-ascii?Q?B4GwoI42PZn/lOQRR6l0XQ/pazPMWVxXqrSs83D7ibNl08yPwez351ttFk2B?=
 =?us-ascii?Q?es8t5tYcpJfDx9721aq+ffJQ8wfhnld4rRwXpljRYY92PN9bzbnX9Zdy8zeV?=
 =?us-ascii?Q?liOWM/CqUnIUUJwZ0bf9FuvBZSxd5dxMmO97qa5/hI4tZERhnsQPqVoWYi1w?=
 =?us-ascii?Q?To+/tBx8XIbPVPngMZRz+fXS3yMT5EVQfpMbinOKLprZn76XnF3YZZ3DrW3k?=
 =?us-ascii?Q?R9Srssg784SM0CdFvu1t4Lsh68L/gUp3u1kMLqVP1jkiqJZSYXCwL6jjPIiA?=
 =?us-ascii?Q?iQQYWfgPt5nPyolCMK/mlbnYWjNSAfaNnmLh/bCoqpgtRRm6Yd3H2TQeaYhJ?=
 =?us-ascii?Q?T1j/lcPP4SGeG5+4s/LZOdsDUKA+nGxmi2tJz7oGglLL0zaBAubZpnzaN1Hh?=
 =?us-ascii?Q?YdJDAQ1A+wbLc8NZuNsOCC159XUWBuk6lZqga21AUNoP7rCMzcgPF/srDHaE?=
 =?us-ascii?Q?ITvZuYR4OhvYJEp6nFdUUpsKOicjwzvrzcLRjqMW6IGNUHvua5sJO2S5BBGN?=
 =?us-ascii?Q?QuAX2C1kELe6/WnHBJ+9oG6GMBGqoMFKQYCtwENt5ult3XouFE1Lny9d4PR5?=
 =?us-ascii?Q?8xsV5rCt8rGxvSaepSJODtZfFxc9/LrFFyEpUDIw+GUeGYXqmRrYLUBGSqjN?=
 =?us-ascii?Q?N9pmCDsbRkOAyrJlMqpEvkhUI4R3Wbcl7UZcv0NUdJsqXwgYsdz+3GAtMdQ2?=
 =?us-ascii?Q?p6Q7XOaCW6a0cLanAuMkf4//3RUMRNDaJ+r00vJx3dC7HMWSfxrtGUgy/KYU?=
 =?us-ascii?Q?9ubzJQ3gszRN+rkHqHTujhKjYVt0mbRGhJeTQEO2o6YMXLStEj597X+xfhi0?=
 =?us-ascii?Q?agokGbKqer5b7Bi4nDcLIJvlGPUNjYf+fv+jW6F7maIO7bbfhqYIEfIw5nAf?=
 =?us-ascii?Q?RuoiqsKMGjTHymuWidWVFvpifZ2XnIRz9DPjw4KMglEkN/VCowDLJm9A3bWK?=
 =?us-ascii?Q?C+Nnq5r0TLRwGazr69R/6MllGwCERZJimFVPwoVmR2dvFu/H+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORY4p1HCFy9B+SJNYEGoSFWFwpziJ9SUaLWdeM9xsr3dCNsOGopUZU6C5VER?=
 =?us-ascii?Q?Mo6Vj/aHt2zjSM6Oj/+lwfxD8+waa9O9iK0UE4Uiuu8mhlKNRo2SX4GFch+A?=
 =?us-ascii?Q?0V8j/OiC6FPsN/f+cCfm+zKCdwk8Dx57p4pPez4grxAcSNvKehPeWr2pM085?=
 =?us-ascii?Q?pFWG5Qu/XAlIY9PbiX+jviLmfdYXPgnIfvFXYIwTMmTKJa+Q3ZaPFTH419F7?=
 =?us-ascii?Q?OFoShzWkbrI0tyYpP3F09TwBgzjRZwYM3MnhWs2w6DlyflA6R+a4mnruhY4B?=
 =?us-ascii?Q?nwZRWWwayoUsTlO9S2aMcp9rJY117CTNdyiZ+XAV/Ys7eRxEXXdvi+fSULdT?=
 =?us-ascii?Q?L9sQHqGPTUH9xaBMSAqVY/EzT6o33jJDJ7O4S16CPaKkhn15bMnh5FbuYHBF?=
 =?us-ascii?Q?7UIxfiuUmXD2OGaFIr+KqDpw/RiTqTqmQ77v4lyWZZ0eac2tHQSCCL7CVSgW?=
 =?us-ascii?Q?1ZJBwE2VtaVUtPP6/X9OVATv7YZ1E2LR/HzC+vp0d4PD3mbqw6d1Invqz3g+?=
 =?us-ascii?Q?TdWnIBkeMwqV5tgbrkkUwOEs3KavbxQ/e2eVldvDW1A8Y5ipjMhTOxMN3WAN?=
 =?us-ascii?Q?jhw6CKF7hrJdnxETwRbuatYDkjrLqUvedMTWKb6kTT9iekGUn7SCqgkfIrbZ?=
 =?us-ascii?Q?fOjQfUan1OtAd+9CRpXzaRo7oyotU53FlBgIbcVs7ZoK0RdAmjwpDYdwCOWI?=
 =?us-ascii?Q?uQMpRMZXdhkgrfMXfF/7kCYKbQJagEyIrf1gq0RLCPM023xsDwsgCHOD1Bgl?=
 =?us-ascii?Q?bOBHhRMKgv6CUFDsdA5Xm4kwjv/CpCb4cm7rsTf2CIpGLJp83MOGy22yMz48?=
 =?us-ascii?Q?kZkuE4SW5GtaDsQCUO6Y8q4KL/RXjkHxmY4KnbSiHIw8RkeiQV9f2niVcnNK?=
 =?us-ascii?Q?X2/A1JX94fKZPBiSQM+RnwMPGGNvnLVH9Z+nqzTenUDzZX1cdffqVrJYiMNk?=
 =?us-ascii?Q?+i5b7RZ/7xcCPCo1DDAE6dKrGhPayNEB2bffN7WU+iKj6Mad6plDajvtQdMk?=
 =?us-ascii?Q?I7DpAToUB6TThzEdVW2AxdWGUQoHk6K/Elas+hK2LdGYaCM+6/yYyM5IZN0q?=
 =?us-ascii?Q?SkdUdiN/3ifpwubFb2WxhcqkiWPpO5l3yVQ2Hes5zA3MW8EDio79Q1MFvJy+?=
 =?us-ascii?Q?N8YgJejybI/rBH3cEZBSauZY3UgOYCJpyLWXLvB14eoJNYuEeIWJIZRiQAO0?=
 =?us-ascii?Q?y5A4kuscoEb/TLyp7ke9zfB4c5mE2cUZEngU9xl9CzeStr3MWidyAvMOJrBt?=
 =?us-ascii?Q?7ecjexVAGwayLOMCmns74McafH0Bfp7I+Pye142KU6l6hm+DfcXtUjaAx+gy?=
 =?us-ascii?Q?4p6jzaNZC1oYDRg0WLo8NvkIkAz98853xzMZXqEvEKw6AFzulcRB/fkDOcTr?=
 =?us-ascii?Q?Hnwy/y5v79EJGu+qHRtq6UFlckmvP9tOL1qHSzoLwW+664bC1HENjB+olL+v?=
 =?us-ascii?Q?bIsqqYFW0A4IRIZcEPGUjqNdyco3JDre6RJZnULcv8oR3zodESwrDEzY/QrG?=
 =?us-ascii?Q?4uvovVW5iD9OdXfX7+JqYegyZ37josFJ80swhWD9vyoAryOcpM4Zw7KfFRXM?=
 =?us-ascii?Q?dQ9gQRJNYx7CZyqCy3hnuJQii0BoDH+4wX3iUumd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513ec4e8-8626-4d26-5230-08ddc4782194
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:50:39.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kd5WBM7ftVQjq7mQt/h/lgUA2m3tzwNA1JaMijRwwARmZSHQyqsk+ETkbcva7MgqWt1wBFDcEISxSjLODyqbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

On Wed, Jul 16, 2025 at 10:29:55AM -0400, Joseph Huang wrote:
> Talking about these packets being low rate, should I add unlikely() like so:

I don't think it's needed and probably not measurable in most (all?)
deployments. The entire thing is hidden behind static_branch_unlikely().
It just seemed weird to perform the checks about the Tx offload and only
later check if it's even a packet for which you want this offload.

> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..9a910cf0256e 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct
> net_bridge_port *p,
>   	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
>   		return false;
> 
> +	if (unlikely(br_multicast_igmp_type(skb)))
> +		return false;
> +
>   	return (p->flags & BR_TX_FWD_OFFLOAD) &&
>   	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>   }
> 
> Thanks,
> Joseph

