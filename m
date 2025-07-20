Return-Path: <netdev+bounces-208432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBEFB0B65E
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02E71887468
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B54191484;
	Sun, 20 Jul 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+B3jaAZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDA15A8;
	Sun, 20 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753021015; cv=fail; b=gvLcE0gGwZw7PWpqZ+9FGc+Ejc7dvYJagvhyiqGLKdRwApN6fZAJ9HrtWWzv1JW8U6OWj3rnFKMLN9KYzOKZ95FS+ShH3cEnp/Lj1/04CdDLBMTgvS31EHZapwa5rkw0f3WB92R3sUpYTVy7V3RZqfmK/5bvUmZDp7KSmmKaJEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753021015; c=relaxed/simple;
	bh=g04dqnvcbsEfGW36scfRERu9X8sW2dIZfvd1yDbArnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajp4nuayfya0BzRLittEqduD/1b+ioo1DNCLhb0evRyHXvOj+5KR0dz6z4OYDyuHptdXku8A8KPdM8sENCM/wVB825SGR9mufGh9yy1V2J4AauE52ttj6kFK9ipzjNB7YWwZCn9gtSMePMXnrsdB5bsjBs0ppi+QCbWu4+OUthE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+B3jaAZ; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVvL9y6bAmU4U9JVtYeUHCWin0LTbyhx9V6e7XpzuKk1Sdm2klOemEkk1oZNNshNKoYENEDY3fU5nVBkz46PJh5t4J1hzlQs0gAz60q/82YzSQyUb6grVn4xJTArVWe0XxoIx9/8dTZ9WqbLfn0Ivnbys75HANXSc5nWDk4NtHROueUrnZ81qVCqs3fWyXsJ4fMRImOMqB6pZhDw//gRWozXQBES8GuxBdbVy02mXwHLXW8o0HtTG5sqRIWBY3EaXYmH+JfnCs+Yi6biKitt+H8F2Jr7POjv4ThgA/Uh0yIst2JloLiIjRHxWUEpKtR7i2XwlX0O8nUn3GxeexiK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmj78rWEXUFbungG2Og+VJ1OcGqtNllVuwj+SgYDDSA=;
 b=bzDk9elnXD0SpNGdpWQEXYfT5aQtsFibtnashfzk2y8VD2NxeBvuLZVlzDXHEtDuKl9viKqr+2TH+KEht8vgHCQ93wYRVAu7fredTBoxv+cP6+OAQ0KYTOT7fo0ccc9qN9CuzFET87cBSzEFTf2JCHiGCBYiI2/J4BLFZn82esYifVKWeUkS7/XfjWcS0gZuKZxMkc9qKtg347XI5hmMKPpyFEtbonunuL1MaTqD+bsCkHiqzn9DveqOyOnSIV8HhsQOuYa5d0ZwbN2kRM+PQRrXdBL1jR2lME/Hm71gS4NUQ+DW4KgS9AUGBxS+s/WZMgF+NZ6SMrYuu+tuM0xYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dmj78rWEXUFbungG2Og+VJ1OcGqtNllVuwj+SgYDDSA=;
 b=G+B3jaAZeyYdQUaUI+PXT5njII4dFNJ1atGfrN/4XOeOWgcZ1cktRogJ1YktctBf7na3WT0RaHO5mLhH/0UdmnO6xPaYKR2cU5poUg+/y1UdEdgJiNNuXxWCSAJJSIo8CGTaqRzjaoVqezD6kp/SSgvd3LFxGD1ei38l4mV6pjVGy+Sg3dBAMW0zzSGwR78IcHKzyzZ9PJOw8VwamdYIXMxh12QELgpS+K0hz5EVy8RXhdmSTjiqNp87wn5A14FoKSrbcyUUm+dRrf2EfxAMtbOuC1DLcM0INwAjKbPQNYXPXq1Pk+BA2Z+u5fbIwy01/aBZM/qLQrx4RjjyPp34Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 14:16:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8943.029; Sun, 20 Jul 2025
 14:16:49 +0000
Date: Sun, 20 Jul 2025 17:16:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: geneve: enable binding geneve
 sockets to local addresses
Message-ID: <aHz6R2DnSwRz_Qet@shredder>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
 <20250717115412.11424-5-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115412.11424-5-richardbgobert@gmail.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f642ffa-f74a-4f63-ad3e-08ddc798113c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GZvSCTg/k4eVgRJj/apriTFT1SmG1jwwMPj8AoUEdhYjdS/8nmZm2D++ZjLT?=
 =?us-ascii?Q?3Au8szYRlydbdSsNT42LYVpghfuJNk+Vm69EgLLYDQqR+YVR+t5B6BCB1Hec?=
 =?us-ascii?Q?LmdUwJ/Etc9OmzgQd8ZWI8LICJYxN5mmWs0lcEEKMaGxIt5ya9TAWeodt3o8?=
 =?us-ascii?Q?JNnZzUhVYWpHJ3RWX3+jz6uGOw7t7KTstfvPxC5l3oumn8sPFX0mEBEuk2Ch?=
 =?us-ascii?Q?2hDihQ14dkqZ/1GKWti+02bO8Emm4MxRDGqCd7wh3/I0d4JTy738HMBrg29v?=
 =?us-ascii?Q?q5VDPMX5leAa4YqLmGCNTIrrKpFguAU+nipOoGZ3Bo6lzJL3Ywf9DrOUvQ+C?=
 =?us-ascii?Q?FedQLTXGUXMDXu2qgE163RtlUOI/QMWoufLQ/FE1T3EPN13C1HFGF5jPuxoj?=
 =?us-ascii?Q?7AOZjL5veN9ZcC2vmYTavIFFsYnn8CfJIXtnnSbDp8H//qAgGBiHt9iWvALE?=
 =?us-ascii?Q?f/pApo/+jg5rzO05qYZfAGNUhd2rbMIEARWaYMSKwH+K5U38mkmfW5rqDvEE?=
 =?us-ascii?Q?ZIzaegmk5Q3UoRRfFwTPmbwslqqju9swp8VBicRqaMGbyCCi9o7cQAMv/ZcV?=
 =?us-ascii?Q?v1MVG5xbiKhIl0Pifu9FenmXZ5mqefjk2f+bRoaenWKK/Y9oJ7T9bn4Pnvua?=
 =?us-ascii?Q?wN6tOkF4hPs7YFwTv8WTAClGCUP4kwLTPrx06NDZl4R4ZHgsJ7oH4sC+TE1l?=
 =?us-ascii?Q?PrY5+E92bxrtSBKisaj4lf3eaQ2lf2iJ/DAqa54F/AWeSiqlm66M09ynfOTI?=
 =?us-ascii?Q?H9LhAiceS2ayU/CDEVAp8D6db711V6/oqlF7S4NOuJ6hVPopyxuLjOWOlUKL?=
 =?us-ascii?Q?n4g3m+/Q1CAwugTtTl6i4p2R9BmJIT1/rWl6GnnJAE9pdXyuIAN1QvRHLL/H?=
 =?us-ascii?Q?z5ildshin+GOhp++uBcFDP1mojYYqX18zHCvoaEqS31iUmCaPZmId3+9qdx0?=
 =?us-ascii?Q?CvplIxf7SSJfIr8Rn/cSxk+opCGCnbVDwHfVeAcBYBCnAmd79p82H0qBxgXK?=
 =?us-ascii?Q?KdQZ4TGD3Xqde1EEQq/c3ojN0jqRxRDOFM3OMuJoXqkDgxV0nAH18XiuWGAr?=
 =?us-ascii?Q?aI+lhuhsz9u0jfR3sMp1Nl76IRhMvR1qq8uSrcpqPD24n3P7BY/PifsEvvMd?=
 =?us-ascii?Q?hgMgmzdy26UFz9h+q1CsChpsmN3poUYobCeyoI13XriGWigcq8ckGJ5kbxRO?=
 =?us-ascii?Q?yyBMTQX15mghdBIc9wBGoA5kDGhaG1ng0NmvwDFkRWT9dpENxSy98xLHyw2/?=
 =?us-ascii?Q?bMVH7hT5g9to9i024OBzziVaL3TDAgdMEzrJNA9Rj14xmekLA1HAfaVAv3rw?=
 =?us-ascii?Q?gfbcMW+JCDsox+GSQtgjzIw8oDRGRzlXgg6BUZAfXCUhzUhjusViqrCB10/r?=
 =?us-ascii?Q?IqzMbSDV9aQ7xZ7CynfWTNhvy3RS+02a1dAUf4zdc34jdQb+QOFIJD6ZTepX?=
 =?us-ascii?Q?7/kzw6oqoOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbmg9gyFD6swGGzjFWAbWfSBFcbmY1H15nwLP3JmgmDlFEhb6EtFRuvORdoX?=
 =?us-ascii?Q?bWiNHSSt5Y/acOvBZZr/yvUrUUymO9bSz5tkkmq+wmTu5Nb7pNUd1IWdO7pM?=
 =?us-ascii?Q?Hj+xzG769owWit1wvLjIOoygH9EIQVxfQ1YzP0NktXOgh7L6d6lEcX567Ipx?=
 =?us-ascii?Q?+B7GecGDJzC30NCBQAc2rDAYKM86oyaMkF4y1tzThVx3uh0D0kd/69rsywzm?=
 =?us-ascii?Q?tNLqSicpPXCHXpWKTylAVEwbMG0mY+dMDUOvoEm55lZlK/0MXw5Ut/3jjSq9?=
 =?us-ascii?Q?ewus6hil5LywWlqfApYeVH6qLR8tyj8jWRh3SlJmURMPciw9p6s2ISK7fAd8?=
 =?us-ascii?Q?qXfgak1bxsFMri7tK9S6lYAXGTz6OOJ79cYU/VHYAOZYuqTv1ZkMUbF+oHjU?=
 =?us-ascii?Q?rcwzvq40YUHYdwZJbZXB0ym48usLkUsvcTBCEknzwXm+LhSJJN7114huBI6l?=
 =?us-ascii?Q?95/5BZ/Az2jgmB3MtE0wZUS2TH7DDva01tJ+tutGKQzkyXpop/ESGAS85HD1?=
 =?us-ascii?Q?AmLp0H4sB8TlyaG+MA/cksvJGJn/C4+0lcTZ5UxylUt5RWjUvQ0Dkc8mBnYt?=
 =?us-ascii?Q?cfcgPqElWqxMbmebHgelaElsIKOoMkVGrAdx8wgTDst39eogj/Nh+XkawCax?=
 =?us-ascii?Q?GDvX9oiJjDtTgX6Q45DWNXrpTfNjuoC5GzJ4S//OmF61JF6vWu1T8GDg5x26?=
 =?us-ascii?Q?cGbUNGBSlToiHvKv6eV60yzhUKV2w55DUTEhlFmPk37Q9gx8BNBLM2PlTHKE?=
 =?us-ascii?Q?6NYweX0qh5zPywKEN2/NCit9UzDsravMtJqEuIeOFCIZMP/+33IFtQAjgLCz?=
 =?us-ascii?Q?A4Bza12TSgxSUx62mZgSt/J7CiZ/vlOU1CmpEI5zzMt6YW4fdAG7Ev8FC4Up?=
 =?us-ascii?Q?YcrMuIcx9q/Scuw0Ux2t/b3gydCHKO2UGskreDw0+jQtvLn0uc9CzxxDnogB?=
 =?us-ascii?Q?0Gvt4a5nWf4o6OTlgw1RnjdFP1W+G9zHX+QVroJJhJyCbowN37pK+ckMXSNJ?=
 =?us-ascii?Q?0hgcf1sbTzrOoLVZ5cVIUTnxFT11T3exROHf/XS+S3xYrTwsshz+eV+sAeqO?=
 =?us-ascii?Q?cZtt7nMW5aBKJXog35J6xekO3tSr5crPcEZmn1GqKZseYI+vt0QglDAskW3F?=
 =?us-ascii?Q?9iuovKRVJzQkH+O4rFF+3RiN+FmvH1qs2Sh8jBf2+GfNwUL2isksqd7FNzEu?=
 =?us-ascii?Q?tMk2xhxQzuDiuSkgMQ5Qact8VUh08Oz9+7nOZ4cgH0gcJLtaOCgDmYLsgrVh?=
 =?us-ascii?Q?C+zS5bzPxH1vod1ua23b12UXrbipPLK8Kud7rFzWb8ELir8ZxVlhxynB8KQt?=
 =?us-ascii?Q?BKytSpWsXY25Aar4gSF9E/kbzsgVLWRpqBXt//pBm63eGm1aCkVqsQPK4eWl?=
 =?us-ascii?Q?S3FcPO2iHcv4AfNmEtulNBy7NijfClCpKNjMpolVpVGWRgZ7E71wXkZRMWMx?=
 =?us-ascii?Q?QOiy3TRzs3abCTTY4il4dHjPHVhq0yIBEuXF42omNPfItgsu1Vnmy9wQefTC?=
 =?us-ascii?Q?5bfJ2V0ttZ2qXTQ++NLBFYWOrEd388Zbj60VJvavn1c/H8ud1EXN+oU5h9rB?=
 =?us-ascii?Q?rXfKB/USpeW1aIPgjFXrlJOtRvJNnudoM7VzhqD3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f642ffa-f74a-4f63-ad3e-08ddc798113c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 14:16:49.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRchIGXNeAEZU4YgDg/mXyUNMuluQhxj7loGF3SJwJbwZWhyd3+oobeXQs3P527iCdz4vqJbxeRZUlcD6+FjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

On Thu, Jul 17, 2025 at 01:54:12PM +0200, Richard Gobert wrote:
> @@ -1246,6 +1272,8 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
>  	[IFLA_GENEVE_DF]		= { .type = NLA_U8 },
>  	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
>  	[IFLA_GENEVE_PORT_RANGE]	= NLA_POLICY_EXACT_LEN(sizeof(struct ifla_geneve_port_range)),
> +	[IFLA_GENEVE_LOCAL]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, saddr)),
> +	[IFLA_GENEVE_LOCAL6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>  };

Please update rt_link.yaml as well. See for example:
https://lore.kernel.org/all/20250226182030.89440-2-daniel@iogearbox.net/

