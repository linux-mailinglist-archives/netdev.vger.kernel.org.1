Return-Path: <netdev+bounces-215592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E7B2F5F6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C04E5C76
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C643430E822;
	Thu, 21 Aug 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggQ2xEPn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740B30C357;
	Thu, 21 Aug 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774668; cv=fail; b=Akl2fve4OLYwZHoTeYhpocZPtv8yUNihX8rHrky6vkGVqAA9QJV6IZLQMecTOYyHul8CQI2jTwqRFSfx9XjYzwRB/rkCKT1ffQxHZfRvNXUV7J3xC0DC2aPrgnoDRgyR8ef9ShL0GO/6lgNV3ZDymYW/AQF6cFY6CbpDt43u64w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774668; c=relaxed/simple;
	bh=LL//yGw4xjCS8RPXuDo2OPGj9FYDb2nfQB0wAIdK8sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wzmdvr0Mwhm2WdhSUnCRfdib5cQ1hpvFtYh/j82PRWUbkFqaoD8C+Au/OfpA5cjsdhZacRrh9ajRE6cggciGlM9zlbsqq6NHAM4/jYQOxYgxy73cVQIL+aV1FptfFRkAJqOba9WkZpM1VPMX084lYMCRJcUpZDzNE0wKjNKlyj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ggQ2xEPn; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp6ydBeohgIJVUsV5PRrcPemmlnxbQB+SffFXNfkSGVlof6FDPwySBQ/96FxuV8gZVa4NUQ9zuHJkfbGahOeoufOFYXcUPhUlLzJblpRLOp2Heodqk4APiaSfWLUQqmEiSRJnWXvNeJrVfvwW8BV4ITcLO2gZWGWh61WYCuVLkUQ4syEtlhbfIDF2O532ZKT+NK3vc/Abp1lMg35TK3Of4NQ2mKej2RNP3CgZumFgY6HME6XIMMdJz10dE4hF2tOtZxQqIxauN9Pcagu7vys2iFRF4MZRlgEUSAXPPewUtJ9fh1wwLXAg/ETll66yXORlJRTHM4JDLB819/l2sTxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF5ck0NvmNTpDFOigBikcYPn5FnAfMeAhpKzPWaDs6s=;
 b=CDfaL9NtGZjK9159PQXCVgyPhRqm6npneTi5reKoZgYpoFx4k7V7XdoaMcTPNz2yA0W2mc4TZ+akZtR7pzHT9RTStLP2mVFsBdUSvQyQpqATN5q7tmrD8O0NvrUVZj9oCZ7xNgddA2jqLQQfOAv+S0NbuxwreMpusqyYnYsRNSc0z/oTWthHDwS5gxO1ADywre+PgFKBUDvWvc6lmk0MJRIk0hygTaNBPM2N8aUUkTB2M0B5gzSGwVwU8JgSZMwe5oB36NhSmoEKZm/gsE8cUvwbxX3KlhnCtyZ2dAC2fUnPJv+ACSToilc/h64CcXFotbcUKEFa6BgkkQrnj6vjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF5ck0NvmNTpDFOigBikcYPn5FnAfMeAhpKzPWaDs6s=;
 b=ggQ2xEPnyPfhDQDnu7NCyty9fxbkOGun6az9Xnx7EuVH2gaS6NtkvsyQGFmB9n7HZ/3uciOSAuna1BUa31BQ08470SpPDzbcee46EHxMmRUgqkur5J2hbLa9eeHZcCkMD6BRJVwm+Hkhx2ycXhiyEfrh+hGfb6fIO6vFCdpQ6B5Sc6N45q61t65T0zBd6jWPWLX33ZMTBdIkhNT5VSMhrobIdQVbLZTnJu/FDss0qU+Awzr8igDsc4SP+NpTYicoz01D98su7cMMNyM9Wscga12NPOT2qHzwEsr3j4OOsfUeZgSugCM9Fiwnj2HjI/IHeHLDvbu5Fow9NOWjdw4XSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 11:11:02 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:11:02 +0000
Date: Thu, 21 Aug 2025 11:10:57 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	parav@nvidia.com, netdev@vger.kernel.org, sdf@meta.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 7/7] net: devmem: allow binding on rx queues
 with same DMA devices
Message-ID: <73yte2bgpw4e6vdycrbgiyhujtl4z6h33e743vvo2rg3bioajb@u3ebcsmuench>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
 <20250820171214.3597901-9-dtatulea@nvidia.com>
 <20250820181609.616976d2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820181609.616976d2@kernel.org>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 1336546e-b1e8-4ef6-ca3f-08dde0a36a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zlb6DuZ0kd7nIrZXehylsCEt1jbo/E8d2UTL9enweSSux5wJktZ6DV212ol3?=
 =?us-ascii?Q?4cMnDkpshbt8y4alMRl8zB+AoIxw/VsHfb09dQEpPFufoy32w6XvjUoKdxOl?=
 =?us-ascii?Q?vuZzJMa0N7H3Db5pk0+D16C7uI0XgQXJPq50iwpSmrpovqkqY37F4i1RxOq+?=
 =?us-ascii?Q?5AmtW4egO8TbYQ5MlG1Pc/dQ6szDwsHVgt4Y+8eFjNNUEk+Zw95ksVucf5pT?=
 =?us-ascii?Q?Ce3dVn/y9LMNthqNIIvghKg9J6WD/j2Cz0G8W3PD4PEVANstJ9hlcd3dCXds?=
 =?us-ascii?Q?HlHEJIcInO5nwm+FqBuVy0GvFeyObgKC0IHxrmV4MfNcqaUiRKjyAgfSoLb8?=
 =?us-ascii?Q?WrZ/lgVV7lchqDWrRtHxMDa/s9CoWkZLOtTnlgKrx6SV9WvzoTeSKGRohlhj?=
 =?us-ascii?Q?FhqAesmKfo0w2qviSvwj7I7iwx88cPqNZODTHr1Oq+Bz7X5+j4Z3J6oOeq45?=
 =?us-ascii?Q?5fdaos+92KIASOZ81uWGv0thU0LA6rclRZwavXwz8f4Wse5X1HNEdAHzZ5E+?=
 =?us-ascii?Q?OwJ17FZHVUwDd98rALtUQTTOUXAedaR/AJslbgzdAgxjsrlYdKMGHXeiod6Z?=
 =?us-ascii?Q?i6F1ewHxolwXKynEbuJF4ly523toB2E3fH88/HIVneigqSr9iNniRBdjohvl?=
 =?us-ascii?Q?FXomeA5O0nZbZb5CTV11mb4wC0wiC0GcYX7ynavk3BETRNm89H3KgJHDnYPI?=
 =?us-ascii?Q?51lEO4Zc1zjxE+VO2pELehBJGqsgi06z5nCSXYyJHJGCwzOBYj1QrYVRfrnB?=
 =?us-ascii?Q?u6uQU4MgQk637FSEgGvCZc/twS81JQbl1jwwKaojd2us8D8uX+4n0B9afVrV?=
 =?us-ascii?Q?/hYBIpZQZC1dkjqoj1Xf1DX7kcZ2H/BOqcrd5DyNl5M472NXyPEmb3++Y+Jd?=
 =?us-ascii?Q?+JW37VOS1uvyUMum+qNYs7RsMNqq9eYZOVfkVFGJxMdVwnVZSshwIC4jdnZL?=
 =?us-ascii?Q?BwABdXIMN0iNfcvKZnDXmD07o5+YXkZCX/7xlnHDVVfIFAkc3O+XxYweE1pd?=
 =?us-ascii?Q?YoiOQUtq7sLUpd1O2D7fvs/Hi50piI9cwkcGhT/LvyGGvQoCxye5LAk10j7T?=
 =?us-ascii?Q?/cxJWNV2D/Uf1RZRv/Dj+vRbW32kzbG5vwvsr4ZN9U2qgdNESlheVKIVTZOi?=
 =?us-ascii?Q?dyfucaTOeB6/lOAzmS67kPsbYS4kHx3rLw+Spc6ko4mMUI/RP0QaA2hlvTji?=
 =?us-ascii?Q?3/SKH0XJuM3ntgCW3+YdCrfV390t5rT/7ihO+jwZ5odxbVLoIknLyg2wJTlf?=
 =?us-ascii?Q?WsLTmrzlO99InscESHRjSBqfdzcdUCsfNcNqBg9+yRWz/DvypKMObXOry0gM?=
 =?us-ascii?Q?9mWMnAO0i8TvEDsE8ayzpQ8rgE4C+jKjGde9gYoevNojkURFnpAHod9VDa96?=
 =?us-ascii?Q?tEtJ5mv4oq9lfe/4KH5lenpYCRIhntcedNrCs1OxJEQKYM1WrLuKQWKUDuA3?=
 =?us-ascii?Q?4eApPoT0Tjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NXyWqUKPYiqsi1Wk8RARdtYQbWHtywFLWBUczGybowHITxyqIMDSl+6HCHV?=
 =?us-ascii?Q?SvrFDvzkgEVgy0RIQlMn2ak5tG3cANISmuZtzU2zp1jqrZLxqhzDeG3t3XEH?=
 =?us-ascii?Q?mN/QKyYukxmOiLK8cRzB6ihEtIDFI1hnydfLaqKK5j68iwRz1iP3b/d4lLro?=
 =?us-ascii?Q?QpRRcrDovjPwJPui1z+4z6wF4cpnTkC4mIZNNbb7xeOUJweXF/Mg2IN0pKpQ?=
 =?us-ascii?Q?K7nxINw41H+u0dnAFNoDpS6Awj9qMBD1GcCLv7oRVVR5x+pcAPN4IdhGSeCc?=
 =?us-ascii?Q?2PM1IUZ8H7kYvcAOc2UwgciSyW4+U7qypd+Sm/+2NNqUcYTGrZO1HLfHcS21?=
 =?us-ascii?Q?/8+FAIChro2IM6X/i2SKOGpqFkRNZMwNiPp4Nqc/eDGpOsZoUQUL8sPoetQk?=
 =?us-ascii?Q?pfj6gfqzBgx5MfcKeRaJjMHI+jUu9Cp/1L5yXT9gz+ag1mJEPcrZYe4fHNMO?=
 =?us-ascii?Q?pEBpKQEKzFcwHlwH0t+8dqjiQxGC6Uev7Cx/tUkmwsx6y0+UVwZMNWtyJgdU?=
 =?us-ascii?Q?pmyKgE0B84WROTLow/Q0tEMJzve5LshdxZg88D+D+DI5HwBAdrDYj3Bfc/FV?=
 =?us-ascii?Q?K7bJ3w9YwaQ3aqONt019c+W1x7mTRbX9Zegqhi3rmby7W1g8GtjuzrDXsecZ?=
 =?us-ascii?Q?ysqHdpQwZz6zBDneXReYnxSCw3kPZcE2lmYV+ZK2oHD7FkNAg/M32ivJFczl?=
 =?us-ascii?Q?kNbr+UDs9ZUK5KdlIBqD5FyPrGA3jA7snIZsprOQ1m4n6gxSbquORsAl/3Jg?=
 =?us-ascii?Q?iKCiwVCOQy8DC8fI9xHP7jbZWya+YYAP5LSu9Zx5S3tSIZUqHBaEuQxXMiTk?=
 =?us-ascii?Q?yJO8tHTYms9jLYvhVQ7KoDLZuoG7G0XbtGy1yU4l3fixEDCWRkoLtr9SboAL?=
 =?us-ascii?Q?2Wua6GojqhRLNSqQWLUdH2DEPwGIBAX4tTt8OaCBfHnWsykDgLVFWQIMX3NH?=
 =?us-ascii?Q?+FAHbqdvFTVFtA493CQImRJFS1Row8tsl5Hb8H0PRHOnxN3pdPrOHNIBGHWC?=
 =?us-ascii?Q?kvkSFSE0lWZHIGC+VLyZG8YUXb/cQQGu84j72WgU6VweufkZ+/Voh3ohnmk/?=
 =?us-ascii?Q?ar6QXw6djb0fTADZQ8lw/OVQrF8kzVjUrbnerva5m5fD0E4GMn4VL+DxgrxL?=
 =?us-ascii?Q?miQSjIoVKNesFmIN3s3Eie7vtFBlqGpq/Ck8zUoChALABgpWxJjurUdgqOHN?=
 =?us-ascii?Q?2f3Cf4kS/1lLmrD7uDIud2vA5aF9lfRhtXNELw+tZd3U3EHcV2a6vAUgq8sh?=
 =?us-ascii?Q?Ddc4RtydNPaq/LNFFDR1A/4XsTahrSMQ7WJjkTy6fl3z6d9MU6NfQbDu9Qjn?=
 =?us-ascii?Q?uKG4puWR2nhqCLEeVfOlzpxQ312X2aGXSVagvZuKYsOAVbZZ+lCIfhJqHPXf?=
 =?us-ascii?Q?yBOzYb72qMJaG4nj9mGOGglEKN7wkna4gYTqlGRj2SXwFXqY3z0O53Lhxa6b?=
 =?us-ascii?Q?lYc7Bcogkofh/+Zwyz0KchKN87vKmN9lzlQKqynUDruHzH+qyCtUsix22a1H?=
 =?us-ascii?Q?gksOndKSY0RPk2WYEY1zwnPtiVt1/C9VAdJlb5jWRXNJCcavsMcM2L6ooEs4?=
 =?us-ascii?Q?mru9gCTm6ECvndomrP93bzeO3FR7XK6wU98REPT9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1336546e-b1e8-4ef6-ca3f-08dde0a36a18
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:11:02.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+xHkC0dLKXa3OH9lg2AdYKzdtLjcEj9oJcOXlq+QPL6oSAb0p1kT71O30ovCUCnY423c17iZsU4z9h42oPnkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

On Wed, Aug 20, 2025 at 06:16:09PM -0700, Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 20:11:58 +0300 Dragos Tatulea wrote:
> > +static struct device *netdev_nl_get_dma_dev(struct net_device *netdev,
> > +					    unsigned long *rxq_bitmap,
> > +					    struct netlink_ext_ack *extack)
> 
> break after type if it's long and multi line:
> 
> static struct device *
> netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
> 		      struct netlink_ext_ack *extack)
>
Will fix. Hope to remember for next times as well.

> > +{
> > +	struct device *dma_dev = NULL;
> > +	u32 rxq_idx, prev_rxq_idx;
> > +
> > +	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
> > +		struct device *rxq_dma_dev;
> > +
> > +		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
> > +		/* Multi-PF netdev queues can belong to different DMA devoces.
> 
> typo: devoces
> 
Thanks!

> > +		 * Block this case.
> > +		 */
> > +		if (dma_dev && rxq_dma_dev != dma_dev) {
> > +			NL_SET_ERR_MSG_FMT(extack, "Queue %u has a different dma device than queue %u",
> 
> s/dma/DMA/
> I think we may want to bubble up the Multi-PF thing from the comment to
> the user. This could be quite confusing to people. How about:
> 
> 	"DMA device mismatch between queue %u and %u (multi-PF device?)"
Sounds good. Do we still need the comment? A similar remark is done in
the commit message as well.

Thanks,
Dragos

