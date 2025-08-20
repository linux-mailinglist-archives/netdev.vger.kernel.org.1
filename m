Return-Path: <netdev+bounces-215365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E338B2E45B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1102A00E4E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC78258CDC;
	Wed, 20 Aug 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ArXLd/z4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DED253B40
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711925; cv=fail; b=VtoG9msfvhSk7oHdav6ZmbtholVSmKXonw+5lomecd5bHNfU8yMDNtqJFaZ+IQP8DytdQ8BrL0t7M6gwDJ2hXHzkkgxoAbIUloW33UAt/SHEdpI7qHAQsbRf96unvaB3dYvRtZrWx/Mi7e9XnTPnXnNONwVqYVAuA8GhRIFTfuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711925; c=relaxed/simple;
	bh=tBGcCnRU/jnbYvOAjmeUr47QsOYS7EC4a8PhEq3ypkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=st3gbFThDwSoieJKbcoD25S7OuBoqGeECx9eyOA1s+4pkeN/SkNcOzIH2rjkLiirP1toTp4zAgCSWpWb24YvyApCpJaa7mZB5v6yd+fXf/fzfuSBFZW27XcBnaMTC92LnWPTUouta1bIAJmXNwGhcjGwF/d5B2O9t2eUTsLyqig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ArXLd/z4; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss8VfFsYDC86/IKJQLcWEjwfC/u7DMFk50cuFgCaiyQnbkKkk80KFbamel28RhmX3lqcb6jRU5BPzMFg+GKZ2/2BpQuAtAVb5dpysQCFy1xpkD/iHvV0LFUDvAdCZNue/q+XmWUw6g8kG5nTmcoHDtpsKMW8u0ILAP0tRMV/yotqiXWnVksxBWmfKdYQhCpRldyNMoCvOy1ICIdF2YmaMtvac4dTH9KnD2HpZ4my6NpCeM+kbkoNr4/milz1WyTtk/zjVX8IiUUdBgkNzZHj8EYl4qnsaVVE6DaI6QHnZNAWXwkgjEWXgc7FB3RZfd6I0N/UDo3ISATJpuKdFEdd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ0wTznFly3oQ7PR7zIMHvGgOZNT6kv4pUVsfvC0kvM=;
 b=XV1PpaCIw9p0FP3P2a2/ezkBIlwJktRoPVlj6STqFyZtMbmQwBFVksNF9npq5RT3bmJBWFbVhgjfLmeAcDKJ+F9teUymEJ/GEDSsro6tktobyJlzsgIfPuLCig39Z+EJwauOpHj/MPyTuanwqQKbs3GoGUIpVG5UqOZ5gHB1gPsVIvny3EPba5xwYJsg8zba2kqaCs5FfWyyP4fuO/hqlHYg7ZX0sVwg5cmXuKGiyvqpytlJl500xNZnlyfbrgj5P0uO5scb77N0qk06s+KNwdjk6GFi7vEqUsH2GbKoZGDyRug7LDwcx4rpnzYGy90Cn5HiKZkspaDmqiBgySrinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ0wTznFly3oQ7PR7zIMHvGgOZNT6kv4pUVsfvC0kvM=;
 b=ArXLd/z4YA30/Z9ao892dNPqf/CCNHL/sN1VdutHyio5wkd+SkQFZF1EQDsGwcLl7BB/tmNnO2VuWVLl9YNWglv8Q424vmwlQka/lVw/xmV+zTrm3xOWjXSnOQ/x0mTv28l3BlXaGcHFUaHEk4PydGZVYnb/FvfgmwR3aSM0EGlRwzHG5/SvaWKDiUdgzDI5UwdZ1YibLc0eImXMx27MvQEzC5MKFAc8/8EH8UchPCRBa9yBPXXz6t1gOGbET4qHOHmhhZIlu2VEKyT2HlHCOz/7Tv5en3OomsMF07cTKpeoePmbp1n7JNWm+zBkkpxHSX1wxqpUcP1ZpeviaAqxvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 17:45:19 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 17:45:19 +0000
Date: Wed, 20 Aug 2025 17:45:05 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com, 
	michael.chan@broadcom.com, tariqt@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	alexanderduyck@fb.com, sdf@fomichev.me
Subject: Re: [PATCH net-next 11/15] net: page_pool: add helper to pre-check
 if PP will be unreadable
Message-ID: <lettgwcorq342iie3hjwv66lgmt2nxbucjmkw6gvqpjoawytqi@qzuvoqs4xt4q>
References: <20250820025704.166248-1-kuba@kernel.org>
 <20250820025704.166248-12-kuba@kernel.org>
 <DC77YRDDLDV2.2RNW77Q8HPLTH@nvidia.com>
 <20250820075247.153b392b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820075247.153b392b@kernel.org>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3f4bbe-7898-4349-00dd-08dde0115452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h1X/u2wYmMBlWrtKnA8NDVm+8/MPQoQ9ADUgnAKOZ/bxQiR0UuJMHl8uO+nw?=
 =?us-ascii?Q?8VHshdrGb+LXvdszH4smnWSO8URAy8+m0GwEigEf1Cm+JDHxttlmE3QgT6TA?=
 =?us-ascii?Q?XbhQzEE8qk04nAglCayN/ghUDP2IWVhExH9TulU1FwfEV6ccuOuHTFaNsVgf?=
 =?us-ascii?Q?kRZUK8mn40YSpNxnepy5xnJnjT5CQYXdOSbuhm1yaxMLhR8ClYHgy7eN3abV?=
 =?us-ascii?Q?loZmmYhShMYXimT4QPoOMSeipDnUMMZe6+KkMZfgEzwHBLUMdA5nwzxIwMuc?=
 =?us-ascii?Q?UcRwndJgC1hukp2XNDLAJav77528WFBpoRkg5RZb1gwA20OEPqBurw06imG7?=
 =?us-ascii?Q?FNTQe3aw++ryDkpMtt6GO4NSTRlHMzWYfhQVt8Ih5HFKYb8EGwJzECYkbW0I?=
 =?us-ascii?Q?ngedc4uss79ebGrjO2l3tDQgRQyw2wWdSoCDP80PTWYkUy/YND7NtqWq5h8m?=
 =?us-ascii?Q?ZIgFEio0TLFyp1JaJdtYBv8brJqC4eebQBi2QVV/QCIqQ0QlgW300P3+Q5My?=
 =?us-ascii?Q?Bqzu4le4QBTX/S6FQqFVsuvnIrzkwI+sLWZmt/04fcK+RpD580/3C2ix+x38?=
 =?us-ascii?Q?BmMVTjSgt7747fbL5VVttQ8Wa9w7r8MJYSH4nEEu30+roK6tB4lAC6g+fjjL?=
 =?us-ascii?Q?GI2vfUEfd9UciaynOa5Z8IVinOa1M2oKjgsrNPWO5i7fYbVoEk0XyztP0zOX?=
 =?us-ascii?Q?YbFPO5Fa3+2zw6mz4tAstjZsRpRoKNj2umyDCrpY9BtAMNdTW6ceidrYyYOo?=
 =?us-ascii?Q?ouXibQf+ejwsM9382o4H9c9wJwDSgzkHwu17ErRjNkZwU0jLJLxt1g4JyBoV?=
 =?us-ascii?Q?mSICdfkiAnrFZTQrNKH8pu06MGlWYb7q636FH4jM9B6hWb/TWbZylGcx5V/i?=
 =?us-ascii?Q?ZtCXLYdZEK80dpnWib2HCKBPB7iVBBdbvofAwgLTUTHHAqZMYCXIMajWXTBw?=
 =?us-ascii?Q?FRIN6an28bGqexnCD79LbQQvuAI9sBEiNUPfIQpZY2/+Fxj8SzsEykySty/B?=
 =?us-ascii?Q?Kx4V4AJM6GiDpSwXeH0iKMHPIkGs1D/dv+AZkDkPNsGVF2pwwuE2FwNt5rCI?=
 =?us-ascii?Q?wpqmJed4EdU5e3LyWBzqab+68FH74UAIfpwMYYAp/kG+oIciB1YqTzRH1n8Y?=
 =?us-ascii?Q?955VJ/Pa+xqNqUX2E0PtINirbY6F5bmDe8G4besXFwtDlXbzeYdOw4WS9yiI?=
 =?us-ascii?Q?rNy2P3Jb9H2HDRBpMupuNp7UWHq8A7y4tpDfgAFUqw8vuKntzZpqL1axaEnM?=
 =?us-ascii?Q?tyLHw/UaKpyoNeqMmoJxuTnpTRrsSqi7bIpIVxNMLmd/Il0IjYmIlt/rHboI?=
 =?us-ascii?Q?Sjse5ohzVSIqyWehkAPNvEtLbDCjZjXX1CTU8SJqFpVfd6JTReXPI/4f/VtP?=
 =?us-ascii?Q?1yYGF2IyVnHj1fgFZtznFsnvEQzcVqMjwX2GqEABCo3jjdE+ww9rqh0Mc4JM?=
 =?us-ascii?Q?SzZx56uD+a0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZXyM2HOqDKI5G1uUBprkXZQwCbnlTMN0A35VcCj+RfJF8wzk4pRykldhkJG?=
 =?us-ascii?Q?EFLZba8DmxHKaXZSHTKegit8QUHkDMBzx6lo2ps0Ej+iBz/DJnaEeGhbqXCd?=
 =?us-ascii?Q?6yOtyvIi93/EZqjnPntLkh+LkTqGzds2aNS/H7KDq0IjRcGRm3b49rgI2Bfr?=
 =?us-ascii?Q?6lq0+LgVHBoef3QCPOxTzxTq7IuyQJ9wQuubqrCcW3YEpvL+5GniVIor2Bsl?=
 =?us-ascii?Q?tWPhEwxRqVVl9bv3LymSWh+IwEhVZMHCD76AEJC+q9bxgRG/KfIsjltLVPfq?=
 =?us-ascii?Q?sndWIcLZQ0Nbn2Qkiwlthz/VsovmYNC6/N+4n/myERmHRrueHIqLhfecDHAk?=
 =?us-ascii?Q?PEji41N+DvJBn/nWClil4Q8eUsQTC9lAa3k1pEf0+6ZLkqLpdXcbjFPzSA2D?=
 =?us-ascii?Q?ppP8dxpCeLuQ3vgZEnctt0zGQfsGooRKYCIWBepJsh8DiXDoDut3rmxRxrTZ?=
 =?us-ascii?Q?EgrbFGmCDA+k4nt0m647/8Wj6WUJiScLazWVaFFpZzPMrlqbBQqziVLiBFGS?=
 =?us-ascii?Q?8REvphTNOs9uzJOOoqNzoLdcztSPb3fe2cH1M8+nNdNGlgmuZuuHBLevWlyF?=
 =?us-ascii?Q?zJqD8LirB9056zruMM/Z3CwB5ufFvEa9nWDe0WEZh5wFOzPbKAMvVR1Urea3?=
 =?us-ascii?Q?GZdxXLN/EBjxTrR5kGOttMNCNxuO5n5Xi2YLLNQnF1kuSwP4yzGF72DoeFcU?=
 =?us-ascii?Q?F6DRGShl65x4/PT5FK96jPMh74Gx34zRBu04RXQssuxPzFESwGbOZzZNwukh?=
 =?us-ascii?Q?OIBN/n+tSRJ0rkFjzyAWAw3RxvP7gdk11KazV1dC+8fnRK8IPiPi2BZm5I6m?=
 =?us-ascii?Q?BELVHRnA6TsUAa7eWits4kXfeAqQBNrnAiCL6Izpd5Avu7KHXh5XmIiVT+bq?=
 =?us-ascii?Q?uWW78Uk4zMElnPfu54mqeyjmqh78Vh2tq4V8gUD57Vy4AL7+y2UHoykvN5eA?=
 =?us-ascii?Q?PXzd3D+mZNULhz0+5CF1KDJ3QB33geN+niRRNNhf2/PMjLUCmasJOvQQgbL9?=
 =?us-ascii?Q?2a6sO7zKe2luGt58o0pJNb4Bf0ma1Ftc46H8v0U1dO3Et2NtWp5Y/N2cNtw5?=
 =?us-ascii?Q?Ua4UG6U11MFeYSvMtW/E8DAX9DFXO4ZqOsh6v0URndtltuOpb5uZtNCNihXr?=
 =?us-ascii?Q?KuaX0/KG8uOUvfa2BBm+r3qUlt6862H9jHRgwn9kammG8LmOytn0agI2uf7J?=
 =?us-ascii?Q?NzallYud/StJbhDk+O8wd2maEGiV9suDdH8F3cAlHo7UlsNEnoCNqkStddFF?=
 =?us-ascii?Q?nNnsNltMpz5Xx1Z21lDHhpv5sfpz29rvUlwUBUCF1hKqUgWPPj3JxRApBcpL?=
 =?us-ascii?Q?jqw026Y4QCQsV+0Uwez/F4b3tcmDUDw4TPmemGgphUsShrorLHY7+gcgnqf2?=
 =?us-ascii?Q?jWBlUSWlNEINYDRknwHwfS/i2ItzrgrOyiYs66z6olFJkLpOztMBsMMi95Z3?=
 =?us-ascii?Q?nbb1NZ1VyqEG8K/Mxtmq+1+Jgu3TFGQOk0XYTijKVfbZwlLgMahEXRGVilTt?=
 =?us-ascii?Q?gUqje3Ulhi4JXmPOlUvcpK4WkerUFX963dFm//VDHESmv8hYszxBzpf/RxjL?=
 =?us-ascii?Q?hHqHqapfQZ/WBoJSBIMD/NrT1Sog2eH4/AZEwTY1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3f4bbe-7898-4349-00dd-08dde0115452
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:45:19.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlqwtARmz+9zGMetvjU8H00XLGqbvfPbiPjz7QEXznH8mIFVBTd5EbmLLwvDllCJIoTqenoqXEsuHKIcdq5Q2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

On Wed, Aug 20, 2025 at 07:52:47AM -0700, Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 11:30:42 +0000 Dragos Tatulea wrote:
> > > +bool __page_pool_rxq_wants_unreadable(struct net_device *dev, unsigned int qid);
> > > +
> > > +static inline bool
> > > +page_pool_rxq_wants_unreadable(const struct page_pool_params *pp_params)
> > > +{
> > > +	return __page_pool_rxq_wants_unreadable(pp_params->netdev,
> > > +						pp_params->queue_idx);
> > > +}
> > > +  
> > Why not do this in the caller and have just a
> > page_pool_rxq_wants_unreadable() instead? It does make the code more
> > succint in the next patch but it looks weird as a generic function.
> > Subjective opinion though.
> 
> Do you mean remove the version of the helper which takes pp_params?
> Yeah, dunno. I wrote the version that takes pp_params first.
> I wanted the helper to live next to page_pool_is_unreadable().
> 
> If we remove the version that takes the pp_params, this helper makes
> more sense as an rxq helper, in netdev_queues.h / netdev_rx_queue.c :
> 
> bool netif_rxq_has_unreadable_mp(dev, rxq_idx)
> 
> right?
Yes, I think so. The memory provider name seems more precise as well.

Thanks,
Dragos


