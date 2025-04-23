Return-Path: <netdev+bounces-185126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503DA989A1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE4D1B66A48
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AAB1FECDD;
	Wed, 23 Apr 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3PzAW4g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB51F4167
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410874; cv=fail; b=Kp6CHhkEZbY39evYVnQL0BVS6OD/b0XcPDUPvIY4H0f9EOgEg8JAtsOtEdshn6gbNL4oLZeoLRG92+vbNLH+56EnK8xxncB1WHPiF9gXs5wY2YL1PcxxpvPqQV+dOwLqww1hpyMDbI8cbOT/lVpJOan5Kse5cLhqFgpJK/UiCwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410874; c=relaxed/simple;
	bh=XP5+OlEEcb4c40SEbOw62J771djF2w1RUbm1r48o7O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJeTcmgLO5RjHtdCALUjHgO/5UrbD5oOjFj07aKlK459mI8F05tN24lR89uGAmauHygTRjt35NSNQ4BnYqztiF15ZbJX449qlzXruVTNpR0gpjXhHoFtlJbXFpmfswO7EZBwioyFlvM7DszWxKP8TEXjDcDccp//vrb6l38vJpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3PzAW4g; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoVfRIEHG6xkYkE+hijFVSix6/NpVToIiHi1jxrx6hMFJaRuomgNlaOi8xAejvKiGXp9Isy9DsM0ZbDT4HHNfbTgd0iaGnetA6jrxxfyP+alys+iQX0pfX4FJR1bmcFQJyMiL7MIvjYss8IonCTuSHKoXvIXVFk9nRdeJdxR4YD5nGO4ZYnb0XwiHgxDDLUfnWbI7Dn0O+G7GLNC5HSehjFG7u2cM1lm4BiZiCSs2I1o8KeH+rPp/waA3PAYUhWfr5C+fAhcpFBPgGfM6FTghH+zQJBuNJxNKgAKZZhdzTopVpWC6nOs5DjNozCLKl9o6v5Gs0kuZSoBBTt7CR1+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLpkyE+KWR+LxgcifSDOLbatRoPIKk0VAMVMbLCRUCs=;
 b=UrepmgIL9xz+35qQEI6Amwq6j2lRSXfz/3EbjQ5EbHl/2dckwwa7Ds2RIhqCLQKngz72L/LJhdDwmaAQFxNGPx18mKUrQplEa6ppCnF52aubL5OqRwIdkcxiUrrAyUaxXwAxJO5Jf5Q1InFkkw6F7QoPhFNUm8zQjddXHmVrDFtQ1kVN0IgBgiRPNlvjSGtymidRJuqV6akrsX9Y3YxqoXyCAEMG6fKPAbZ8YVVJPpKnl4XTgrlfb46NV7uRmCJUXi841aZpaearcqiOIHfa7FFdu8qefDJ6yC/sBn0GUbB4DE3SWkTsAZWU6VhyQsV7u6clPl8vkCbWEvN8/svxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLpkyE+KWR+LxgcifSDOLbatRoPIKk0VAMVMbLCRUCs=;
 b=a3PzAW4gkHNITSC2NfdOA+Pn6LWuh8pcJLSNFav1xM7H4M55cS6UXMa0EXvBDunB995qYLBymhWd4HOAVcGgKFfEGhN3//BIETwD3YnnjwZQd+1xFgqIutm1p7OSVInU3d7w5zljTLbHy9wflS9da7qW+eWJ1U7hz6IDY05mmMATsCgR48AgE/44oZqFN3DbMV4/TuwOYLBSXlyYahRTcNF8g3srYQ6ttjYTivSy7Ac/RjKIp7wejq/a4FHTxpWF/mzTKKEr8X20Exn/zZreJRWsjkq253eLbU6ivl9UZQYsbwu+XnJ7bwY3DGGza8BUiz93mDbXgaGYFkUjy07vRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Wed, 23 Apr
 2025 12:21:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 12:21:10 +0000
Date: Wed, 23 Apr 2025 15:21:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	petrm@nvidia.com, razor@blackwall.org
Subject: Re: [PATCH net-next 12/15] vxlan: Create wrappers for FDB lookup
Message-ID: <aAjbLNUErWRPa03b@shredder>
References: <20250415121143.345227-1-idosch@nvidia.com>
 <20250415121143.345227-13-idosch@nvidia.com>
 <1887db7e-aa4b-4dd4-b297-dd6f8a31fb0b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1887db7e-aa4b-4dd4-b297-dd6f8a31fb0b@redhat.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e7d959-7e01-4452-1729-08dd826154df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7DyRP5x47ETG/dAiRfhSCwp7zVpR+yhSAgnsUmRxW5+7EYLwPl6+XF50HC9?=
 =?us-ascii?Q?Reew7Oa/QhdrNzfIXiQpt/TnxaXgCXYee2bw26EDXXE5l9AtrH4RyVYx2vKj?=
 =?us-ascii?Q?KWA6QCCpQuLBB80MsnAXoxgrPSoYMo8DSPsMxV0cwfQBCujbdVEg0gE/zLy8?=
 =?us-ascii?Q?V1VvSeSWJVs+cq1R3RV4SaC4l7DKiKmPdFTPhuebbLB6lrOoJfxSYK5B19Ax?=
 =?us-ascii?Q?ygWwM1m0U/WStlI3LXJKoms4YcmXAoWhleQTt5wbcuJYoYcZdFo4bbUGQ3G6?=
 =?us-ascii?Q?hg9/yiVODgg7ALqKqRKMiMV9EzKYwUgAgy6gSd95G/yIuJMYilUhVJ9PzjUl?=
 =?us-ascii?Q?zIvhGplzzuloim5dPn/0WCyf5ycrLtgoV71O2Ebr2399jgu1X2NhkArBcfkd?=
 =?us-ascii?Q?vcsTNaAgGx0iykMgRfm7qzXO6eE7YxhncyT877fEVdR1zNwoF4mbh0LmpuSM?=
 =?us-ascii?Q?tgB25lsp/Lk5ODTDk7oL+YY1VusDmHJIy8FPKlvusGTjZWtJmt1kd/mro55E?=
 =?us-ascii?Q?hSGFKBSMTLFem0Gzx6XHnvbgRQDSxhzOeEyrqVvRYW0HchfSeX1qdJz9KF4X?=
 =?us-ascii?Q?PKC1EC5BQM/F0LtEKefwgRFgue6Td546wTz5fUvnaoe42Crook13mYMtk/nh?=
 =?us-ascii?Q?UxeMLAVJFVQJmfHJOUguwS22HnW1W9KCtMLxzGWnu3ISyMvZAEGedZ0BuBB2?=
 =?us-ascii?Q?GH4rXfwu9jVVjFEoI7ThV7IVBsNgxrCOkZGdvccmGcUHDRp3ADzltwLKDlIU?=
 =?us-ascii?Q?pMcTdfQ4wcwA5Qf0Bd9c6OHBINiguhTGvvNxRKqCVFpv/DkIAI94moy3+T8d?=
 =?us-ascii?Q?dyVduAPeW01RDneKQbxVRUp7NvW3zRH0DWfmb8Zw/CBr2ZcAk9oDLT27TdU8?=
 =?us-ascii?Q?5hF2vcKoDjcKaJ3Y7HAZ5zLaVdaAYCbZuEnHxpeh27uJiPQ+zptL2hAFXIHr?=
 =?us-ascii?Q?5xNIWs+1i0G8qttcDW4nteDQKLft4OjI1j0/qa8k1iklSxE+2104+bMgy3br?=
 =?us-ascii?Q?RReQG+QFSaDpR6145ShNdO96n7Uc7DZiGZgchZ38CoxLFqB/0annsXXY/Mmp?=
 =?us-ascii?Q?5d9dpyR74qYt8zY4fjIxz6cPq9epEY4k2BRC56DVJA/WJ7fd3l6kTHCCOmV0?=
 =?us-ascii?Q?7EPrDwQDzWYifTocaDKB0Vauw3Of+3thR9pbTYEWtsQi1LeYzJh09HDJCMTD?=
 =?us-ascii?Q?kT6AJhL3q/dmqZZFotPesTKIZKpTK+y9/Gog58FzNZLm9MsEobsn0pe25RsZ?=
 =?us-ascii?Q?Ow86M4oXo/7Caxu0MAVl/HMJee5O/7r3WyvjHiyTdZv/v8XRz5MlUMRQ92Tt?=
 =?us-ascii?Q?E9jl8PfFyIm3V6JFfTbobl1pPPvIcFFPWOrPTfpEj1PrR+CCidmmXfrNw9tc?=
 =?us-ascii?Q?OzoM/yZM5HLZ/pSXZAtS6cyY6nEuSLYg+U+B3zyLLxNwQC1DmjrlltMrjrHk?=
 =?us-ascii?Q?D//iD5dXM7w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXUc41xvNnr7kXKfjznPPjFD5pcur0uqEqSrz+fs36juEz+t/kQpUlI4d7Ki?=
 =?us-ascii?Q?/esRBLeNtF6aGFO9XBIn4EEJWHcd7iHkOawtKEEt89Sg/0kTiJ1wdeo/LB9W?=
 =?us-ascii?Q?UvlX6/xPml4H/QeQHY1Vp+xthZioMwOGghcVYAv+h+MwIEOMYw4zKY3A6f+T?=
 =?us-ascii?Q?62AgUn5zOA9n8gaEh1Ab9CIl9upHdQ+aokxdLVoJ3SdixPEA9xraphPf5jj6?=
 =?us-ascii?Q?bWl1LE9uo6r8g/ctUwoO5+yEwseHNSOprylTGRvbw7egSe0L1MaM3DEXufiC?=
 =?us-ascii?Q?K8E2Gkd57rqqEQGfcD43DzUFXjVsQBsN0z+o5SjV5Xq5cZX60XALy88FR0El?=
 =?us-ascii?Q?U8bMdjLo2JxC7mlVTlpGyx72Ng1ihki/l3XGhIJId3rwWmG2Sw0dCC/ysFOb?=
 =?us-ascii?Q?BY9NPTVageAieRSny5cOFKEIlYqphc6O1oasqE8X1QaBVVvS2J2oJ4n74SiH?=
 =?us-ascii?Q?QMUx/xVHMpCs1lU+ktP4sjyXOTbx/Kif+fp3CSG48yEZd5sQF1ez6QYJfE8I?=
 =?us-ascii?Q?FBOPaPrQ4zpuJIrnT0KpDicxhRlw2BGsQJU+ABvku0ZVgORZMvNon1Mwv7ZN?=
 =?us-ascii?Q?lRt8ySFpI2HVPQL1Pak0MeHIF3p51DA5qjlF1lz9CGknKxvoZfwprsEPzeqX?=
 =?us-ascii?Q?LaXg6BF2KFEeMIRxbofw2Hopn/MLlU7B7L3U1BJTkqjMAdz9knj5m1lS0SnS?=
 =?us-ascii?Q?inT9nHl6dRC/okmVa/ts86jyhaJNR0AOjzq3pxcQseqi/ZmgamlA2Eg2yoxD?=
 =?us-ascii?Q?03noZYiQUur7BukbKhFPortUYkj6Vdt/dpdfCKVSabx/kz7wa/y8mblrToUh?=
 =?us-ascii?Q?k78P9qJZhdYAoAOd7qEsUva4H7KS4pfiEWqh0WeAm+caMsbNLKB63ibNkL+V?=
 =?us-ascii?Q?Avewg6/ooyQPfVFdbsd2/Pht/QS6nCLo718CHUU0ON5rrXZgZPG64Nbibjqy?=
 =?us-ascii?Q?x0AsSG3RWnmrGF+FsJuAo3/inLgUlOwAMnpomXkV/7EMowqT1Dm5pjHZJgOa?=
 =?us-ascii?Q?URR7az411sdO0u8oqbwYXjk9TrhGNTrQ3sq0C3EUnxMzEaIsukAtcr1qNimA?=
 =?us-ascii?Q?62heQRBiGSE3jonVfeCEMXWs9bS/uaPZjBu15n1SRExmH91f/OG68Vz+rb6N?=
 =?us-ascii?Q?23RX20vkjNNTki0plYYQIQfTaMlPZ8ROAoAR84HFuftiA4UpoE0pozncmFkI?=
 =?us-ascii?Q?ApbmCP/hs341sBiF0xJGq5F3bCgXJTnJmLPIhqJHQTQN0SCuCPaki02e9mcz?=
 =?us-ascii?Q?37qF1OLPlhK/IqTiW5WW7k92RyIV+cd+orJ11e+qeN4s1EKQxjwguS3TA/KM?=
 =?us-ascii?Q?1x8ia365p1dEt40NtA1gnEQqnR1f9M2aXCsyqATLrx3ZiElZmlCK68vzw34I?=
 =?us-ascii?Q?O2QX6OsjK/wl/AJZ+ouV7yHaPa3gzDRXfxPDuLMx+zbslxHqX4vLZihR4Bux?=
 =?us-ascii?Q?JorVR3g3j/SMfYRjt50Wz9CeoAtj0xFhbWY1XFWnvreQMGXY3wJ9+RdTak7Q?=
 =?us-ascii?Q?yAA4LySdKQGsSBjie1TdwW/mqKmXJ6wzOP6t7Sgu3YNiIVLWMUe3kDzEAqQx?=
 =?us-ascii?Q?LluSH2peg2l+5jr2bWuJVuV+fKI71lzmEHWdPTkw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e7d959-7e01-4452-1729-08dd826154df
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:21:10.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbQa0Y+niiLhmj3pCQCF8Feq7YDYVxL7S5IOyJlfglel1zZEWalfpwpxZqqu1Nb6X6VHNlYZCzkjIavg7Fl/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

On Tue, Apr 22, 2025 at 10:46:01AM +0200, Paolo Abeni wrote:
> On 4/15/25 2:11 PM, Ido Schimmel wrote:
> > @@ -1286,7 +1300,7 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
> >  	struct vxlan_fdb *f;
> >  	int err = -ENOENT;
> >  
> > -	f = __vxlan_find_mac(vxlan, addr, src_vni);
> > +	f = vxlan_find_mac(vxlan, addr, src_vni);
> 
> Minor note for a possible follow-up (not blocking this series): AFAICS
> the above is safe because the caller held the hash lock (otherwise f can
> be released as soon as vxlan_find_mac() returns). It could be possibly
> useful to make the code more readable a vxlan_find_mac_locked() variant
> do to this lookup without the RCU lock and with the proper lockdep
> annotation.

Thanks for the feedback, but I'm not sure I understand what you are
asking for. vxlan_find_mac() expects to be called with the hash lock
held and there's a lockdep annotation there to make sure the lock is
held. You want me to rename vxlan_find_mac() to vxlan_find_mac_locked()?

> 
> I think even the previous lookup could use a similar helper.
> 
> Cheers,
> 
> Paolo
> 

