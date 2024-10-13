Return-Path: <netdev+bounces-134926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689FF99B952
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB01C209E1
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557E013D8A3;
	Sun, 13 Oct 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h3PS/9/y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87482499;
	Sun, 13 Oct 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821107; cv=fail; b=cwKZN7xv41eR0CCMM2Y3elZAMCwtsebSv3hJNV2mgEzXOIEP1KoKRRJ51UoP/x8MEJonMfZNFKmXz1rN7J0viUcPeV+/IouYET1l/yIo9Pbh68iLs85MKvBMXCtHW7cNBGLP9yGZuK4PBUE1p4rU8nTd9WNl9sLlt2+HCOjqBI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821107; c=relaxed/simple;
	bh=D9DAfIAlpoCSA+Ie3gvm4+S6LCUGbmDGYD6FjZUexz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i89UnyD2rI5J8HjRUWLTGr2aXHOWt75Y7eXLrjtea8sZ6fPSRoXcdwNcCyWb9bQIyMWKCF9EEs2NGQ6dddggbwXAX1uqWtgNkaczsfRzK6k/xASA2m7PCXQxoXI9/6Qmyi1gcV73cJwmzTqU7TvVzVQNuus6Kd6c1dl3uPymv9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h3PS/9/y; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVv0DHAjt9dqhx5SYa+YNcMOC4sp/c7VlvcaflHUnKmF7Z1xQs2sMJMq36MGDEDF6Jgt7Q8CWi2KIORykYGmaPFUJhAjqHIlpBKNk56gK3o8146qo2Cmj5vJ2FMl26CRGwLR/uP/pIFqcH46MTxm8OUY5MNVtdGAimv5m6BmQ7jfAFVIHIkm02mnkXj770TfYDvVhwSPyZcIk7SluxUQfpwgs+nLY6wx/GqgPW4rm7Im7icFnw4o+W3gQYLSwe8RxgxDTFR9nihWeBnWEJtUDEo/e071ipMsJ4GvxS1tBVZVN5+7IG8jUhUe0CY+bSGGmlDcYKWzv6Oebn5kAJiwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyOCXJ5ZgdQhJtNretjaVNZ0AvV2MRKh4kkPx8BRXi0=;
 b=k1ORzXcWFDPYhRCMtAOQpD9aNXpN5uDD0kIHtQLs2DOzWFzqrUq+z2+ELFqzGKe4JKX9uQtr1JFiehkJbTrX/t33cYC6boIlyFmihMPeq4f4ULSkHoZHwi76MqO+Q9MyWW7LzIfLUzN5/syAcnzfOTwJ/tk0JPojl/Ihkrq1sqB9Jjl05uRvYs1jF0sTNkH8idHRqL2aq6zaaZR0OfJIExfdQEuAjqSdnL0clcXaerkkPheKh5xoA5jwAYerNpKySFolXJu+vU18ewkskhDxdBAyWDfMnaaBUNh4dijexTBD3Z8NCgYW7orPh480mh8y/ZYS+yKr7cLjuqlu2mbMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyOCXJ5ZgdQhJtNretjaVNZ0AvV2MRKh4kkPx8BRXi0=;
 b=h3PS/9/y+j8QYDacBj6MmI/EyIyFgZY4LlrFiUpAT5b/2bmTaclhzXPyiZu8H/TSYSLQEUCYtrNp1F1HczhWOwAW9hQgUQ+fpdGLGN7hFW0b/CXt7HQvHfl7B48Z0Mal7qBjYktytnQipapWr8kP6L0CC3DlSdtdMT4yR7cEkxgaQG9RQX/9Gq2JVwpG1K/gCQ6ocQnzF7ERdmFwmPc2dId3v9t5ZAchW2u9s+DvZkdB+8iI9usCtB4SrVLCNjwiDUuFwMxYhaCXykaCm5D644NsxXgDHYiXMDozG7uBM5/yukI//XEtq2jzZ38sXOa6xsR5ATbn+GiMunJtBb5J4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Sun, 13 Oct
 2024 12:05:02 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 12:05:01 +0000
Date: Sun, 13 Oct 2024 15:04:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 07/12] net: vxlan: make vxlan_set_mac()
 return drop reasons
Message-ID: <Zwu3ZMdTHGv4t3eo@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-8-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-8-dongml2@chinatelecom.cn>
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b683d0-7f25-4ac6-a063-08dceb7f4433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jKml+ldy1MExlATfQe8sPrl+v3oIWXsNi/BUWUnZgtIevH03jpS+I2c2mdct?=
 =?us-ascii?Q?oS+u1gUspikvTp5BZEqek1Ok9wBsNyuzeIKVMiN3c1rZPQ+QluyuH4a4i19+?=
 =?us-ascii?Q?91Ss/Q74IM0BWYNZNOKGPywuIT8AuLjGY1DgLP5AyknK9atFbhJWo05nsPWT?=
 =?us-ascii?Q?py22+lcAId6E8UecB0AbZKq6thfPEIHUglTekzrZdNcT00xqLYJps6HlNkPW?=
 =?us-ascii?Q?8voMqjSciWYLdkMx865YG+xedWtNiU4EX3N3HD59Yx6SlVcgsxY2xC6CUW9u?=
 =?us-ascii?Q?Acu2+WobNsVkZDSNngit2RPkLlPUPGTrY4cBt4wxhRvNdsQDM0fRM5CzXnQG?=
 =?us-ascii?Q?HztSj/0IeniK5R4y5iLU7TEiqk3M5ttswB0v2cO5JsTTuRiVTNBZvZcI1pUE?=
 =?us-ascii?Q?1f1DtYpdVWv+PE+w/SvFKs9t2xKxwcJHgjLPQNQB/r7bqxpesFOHfsutCyZv?=
 =?us-ascii?Q?wn/mOla05rolz9ObBzutXbCThdS0n08kNcvzPBqVB8W3yl0GtF9H95Phsvm/?=
 =?us-ascii?Q?yE9yldAxoWXEgaN623VBVpALKaZEkAigIQIMAOOBbXac4ERHtvG9CPbDWooo?=
 =?us-ascii?Q?DW3edpztjaR+hkBKfHtHwUrs+yW+VBAn3P8xJcv+DFqj0rmL1FQLfgF57d1k?=
 =?us-ascii?Q?NQ9ZdpYaFFjUjsuuTH6O/j0ud0KvKiUo2DiR9iAvQldPsOBRMLPC+AIkWHX2?=
 =?us-ascii?Q?4tJnegv0aGlDid4V79DZ1ZZMHWbcqo7lJIUWkOwiMiX1/AU0tCL/Mkx9aNRG?=
 =?us-ascii?Q?7X7OcRO0f28Iv4oGPA90qiTvC22izMBZmez3ePo+xkIG5x28PPp2ARC4/lep?=
 =?us-ascii?Q?e9lPGn92O3CHFN49NWuIrFMdwvWlV8hsFqJe8yNuFDIlCKeaRFfl0kpzxjr9?=
 =?us-ascii?Q?ULJb4rI1ZQBUSVujOgCQQ/WaKnnQAq2uXhyHtg4flUuJHsGYFBwfP2vL/Vlw?=
 =?us-ascii?Q?ogVAHttD3wqiXpkMvYg3OCiv5FWKaJ5rUmYKivMRXGUoE3hnzE5vZBFlsPvH?=
 =?us-ascii?Q?DgEu0HgTylSV3cttVnvKGWEymbRoVDHzEEzgeq5nJYmVUEiD1mF9c5+BZYBF?=
 =?us-ascii?Q?w6IVA1y0z7VBFYy6dGx4CXTdVcLy0S4NT3/4swTJXIvEmlHduh/8nXULkXG+?=
 =?us-ascii?Q?sx7obELoaqlmLZabkIf9qrrspVZ1wOELV6Ipj+WHGDK5Kuu9F6j5m9+xJwYk?=
 =?us-ascii?Q?Oi9AOpilcMSNFtE2kr7kUuwRPbN1PQiISWAwAyGjniJGjg/CtGMS6bIbvRxu?=
 =?us-ascii?Q?xtYPfq6pWjP+i4JRNvBFZxCPa4P+ITgnEQnVMPUdOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJZq1YimJpXQ6EnpyMmdSIDkrVdzMVeAVCKw1Iy9FGtsUC5eCscELCngTwgf?=
 =?us-ascii?Q?8tDXnypO/BF0rXeSdG4fAAwAooktJXJbqQBaL8yZAuqaZYCkXWMDByd5gBM/?=
 =?us-ascii?Q?skagItUuDR1D61dpz2Zl8LD7PVZNwqBH9oH2ZI5gJwrboSRG/jDBQDSYUH8b?=
 =?us-ascii?Q?al0/gVG0b5S5zK4q8ANDiv6ZCbwEkumMRsNSTG/m1r84VSsy5tX02dy1BHWB?=
 =?us-ascii?Q?tmDJtXlsq0QEGZfty4yPtnkkBSf/BJkMncuD33rnQkCEdQXqDNmaPTyI96xs?=
 =?us-ascii?Q?6FWLajkuOmY2JtuG48xUA8sP+egoZ+9YZz3lQR/UJB7mnHpX5vIY7wGw47AC?=
 =?us-ascii?Q?aQGkpPieW1/Mj9x5uiZjx+xln0E1us0n9sbYQB44KnpO3iuSAJBxw8Et8vKN?=
 =?us-ascii?Q?rf6MoK4RSUFF9F3D+FJyRnuuRZ6HpIVFlGFSdFSlrWKMmSWHd+RxzkFm2/rK?=
 =?us-ascii?Q?iGUnarKCgcVVANVGdGukr1oTRyYNowEyvFCx/wKZ+BAsD7nTF5x+qixLXhK9?=
 =?us-ascii?Q?cvPUFpix6gsDbs0Pva2/jf+z2Vjk7UEPk9JtFUpPuJAUmpyYvn3/qOezapFo?=
 =?us-ascii?Q?u4gGGBATQPlG+qrPEL0y7+Dg3mIPryKe08TtEcuHkLb/x9Pt2uCPG3/SaRg+?=
 =?us-ascii?Q?bKbee6bnQB9j9VMKm9Hhn905wJgXdgBxGTPUadWyGfyP8Nycaqbz0hX/iXdk?=
 =?us-ascii?Q?WFt2AwkIbsnAYGI0sLI1Hl0wrNXxmti1x/uReiFg/T0HqZGKghD6q4pVHBiv?=
 =?us-ascii?Q?jYUCCj2HXEX/4MvFAQkZtFwstmQ5AC93u7PrXsbjqjwOn/Ov7DksBMWN/ZsW?=
 =?us-ascii?Q?DUTZISgOOwWqoEex8DnFbFQHFwb2F06M0rmMKSDhVl40T/BDis9dMTaSCKjD?=
 =?us-ascii?Q?/Uwzy5y5yjwhe+8aSqPO1qgDPmHvb8UF0ejVETuzuq8MOI0uaNXipdQSMBEz?=
 =?us-ascii?Q?l2cFZqHEvyyy4GqJtLfqepL1SIijRXCmss7377gqdqFrDNF41O5o16u6Xeny?=
 =?us-ascii?Q?h4oRcL+bTaFsLkJRk/LkC+6D3q8fotAVxaZqTvuxmA5QNxdb6YOuAqTjW+ez?=
 =?us-ascii?Q?NcSGEo36WTu0VTBA5k9hG5R1+mhng+8clv91yaRNuY+3arBVJlAGS2X0zpOJ?=
 =?us-ascii?Q?R9TNSvhRDqL3MSt2VR9IyHQabrtGmsQIKFxb5L0aLkJXSLdLhk9us7yK3XWi?=
 =?us-ascii?Q?61lI6d0Z4N+8TKSyqSWixO0439UlmpCN6OwuuictYElbuqt2H1Jcvgnpl/KL?=
 =?us-ascii?Q?/yUxd6wavALlksu6rEGHR0zuwOjCg1fPKW6bKUDtiy0xq0elwu2QQOzuEHsO?=
 =?us-ascii?Q?9jyfXmyzV9RCfoVdZFdtjWZJv2ZNcMTkO1pELMZrtHwyAAa/m3d0iW7qA/hE?=
 =?us-ascii?Q?DKeDitNm4PpuadFh4xZtrHytu7jVkGrPmdCJ9O6+d6xgyV/3PAN839u2cGTC?=
 =?us-ascii?Q?sVH/Er5QzeziiKstwTThd4DQFhgdihnX9vqOBigr8tH7hOAtB4TYHEyEIx+p?=
 =?us-ascii?Q?MDSxvLygWW75y5jK8T+QcSKiSB+CDtjCQ8KtFbQMRguuVh+mxOdrVBEdtROO?=
 =?us-ascii?Q?ruKAF53ZYc2CK7ehHPnOjZvzlE7N/3Cn9tn2K1sU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b683d0-7f25-4ac6-a063-08dceb7f4433
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 12:05:01.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COjC1JYLq3YfeMy1K/YJmV08E4ppzfEz9j0GxPYRyiXq/1ME4+FYyln6hFsAeAi4aUm5vxCg0T3/YB3ADv/73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

On Wed, Oct 09, 2024 at 10:28:25AM +0800, Menglong Dong wrote:
> Change the return type of vxlan_set_mac() from bool to enum
> skb_drop_reason. In this commit, the drop reason
> "SKB_DROP_REASON_LOCAL_MAC" is introduced for the case that the source
> mac of the packet is a local mac.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

