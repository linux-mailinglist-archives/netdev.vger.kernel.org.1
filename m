Return-Path: <netdev+bounces-84135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D8895B5C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B41F22092
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344B15AAC4;
	Tue,  2 Apr 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bhphpWAy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2115.outbound.protection.outlook.com [40.107.223.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783F15A4BF
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081141; cv=fail; b=LB+x3y+IRKB1Jzubut4CGWWQbGUuqejI9DYwOdi9CgDtPrSMqfSG5+ZmRCS5kiMq6ZLK5j0K0tWbdhIJGAbcmxi73ImTS2NsGvj6C9qkDl1qeSkyjL+jbB55NGBd5wlCMWuXyPjJPAtYn223sok3tBTo/Drf8NN3HO4nZNV2dP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081141; c=relaxed/simple;
	bh=wRQvslGo1xKoUpKoCNKoaT15RYabvA5jgVwF3/mHxpQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=tXQzTSPKJoMZLq7p35ALOnp85rJLo+Q66gxGKrZ01oWHsMCv+OGd0drizsMVrAyVn/oW+Vf09c0KM0ahAEiqa7N1+2LNpH19afnHbzo0DqZ6R2eBgI8LuWKXNRa73oWeYh5ZpX33S1hagk9N+dNxozogFx4Lc+e5G8LMSZ5N/y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bhphpWAy; arc=fail smtp.client-ip=40.107.223.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkDuMLYzyA5eNfKEX2yVIFURrrmqSIg1i1bUSeRtmasBld/UfwfFLYWQ7PbTYpMjVvIWB+6zW+/elztYQq/wJB7Xm0GriZxr825Bloi47TDGLtTbI98SrKubU5jKMJeQg4gKWLiw7aoGHZ4Iv77b+hiAlJfBdJZdfYjTP09Gt1kl10lk+fFG2EEjcpR3fIuFF9RBxLgtm6OKRJFGKXWBQh5zNRNEf+WFagEUnKCX0ZBgQjQ7gJUXUHxXPqn3pdXnSuDEpwSefScJ3Kn1bik31r1cCZN+H0xNJ7H3ncRemchnuHV+67aAaH2hxK5L30bXmL3tr9Ntku1yczM9ue0E+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hewoHL4opeQhrP0FaBwVzMgyLFlChj6lPoQ1U6Y/sg=;
 b=LVvUhkzTsK27GU22XAVQl/LA9IVvil2KnJXd23U5St+bXifzWBbturivvPTKreJrYMn16tvnWDl9QvXK/FMUlM7t11EyNQjc+612qbr3k/jr+ObIQyRyXqTLZMrR24FWFkib1KJcdxV4DGD+K9iVsmBO7jWHCUNW9r91uL7SwrYwYdeCNFq8Gw92wPUKJe1DJZtbT8KDMDCkOZL7tKgTxY4ILArBIJJzbt+jsX5lqRutnnTSs/MDcXHNDTuOB/8YSsrLgAtm/9F/+dMwfND24Dt9Mv3HniRU+eccvwYigQEvApu3Rh+C+FrJSsPn/P72CW6+0DDFeKgzVxXspn3L4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hewoHL4opeQhrP0FaBwVzMgyLFlChj6lPoQ1U6Y/sg=;
 b=bhphpWAyPStbaKSuDvpqdRSqQ1mIQjUUog+6cU+Vvtp+5+SKcInR02KtTTVr2B/caC1fpiCy39XR3kIrgNry/K6ZHB+snDdujPQaY+KzxaHA1PlGMNtN5MAu5NlCdZZPi1ynpDYbfrvwc/uG59t6k1Y/2a3eGXwOzfGVkKXM9U4eBwhl5tgvPoiL0QImvp2L1LfUEakO/KIx3H5xDXVFxJVYbHx3CZc39a4JGN+xatzgi6ZQ3cGA7ibVtH/ecYpVm9zk7xdsJlNN5t7KuIVdKClG2YxzNa0vKltZfm6SdtIZ+4vAMcSJBbHJOd6t5lPurynHezRrdpliqO/FhH/b5A==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 18:05:36 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 18:05:36 +0000
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-6-tariqt@nvidia.com>
 <20240328111831.GA403975@kernel.org> <20240328092132.47877242@kernel.org>
 <e32e34b7-df22-4ff8-a2e4-04e2caaf489f@gmail.com>
 <20240401080315.0e96850e@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Aya Levin <ayal@nvidia.com>
Subject: Re: [PATCH net-next 5/8] net/mlx5e: Expose the VF/SF RX drop
 counter on the representor
Date: Tue, 02 Apr 2024 11:02:21 -0700
In-reply-to: <20240401080315.0e96850e@kernel.org>
Message-ID: <87le5v4p3k.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SN7PR12MB6885:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fj7Cps+hY/paBdcxq2qeduLnk9pH29ddlfflbACVJkYN1yQuEzGqA5iADkUUPALWkqCm9z68njZ/5EkoHJJGROlHgmrnb0dv4ojIbNuQGBgATyO2ApBjej37+9iSlDwCnk0l9AC0HPj6r2uG0biWnreEZtcoUnQTFW/4o4boNafd8HqktPI182wp92ZyQ7sg619UXFBbriUyTeZmBQpDMvNkxrTstXocbNIZSn/1tm3OEiEI6qZ6uV3bkbN+SJNcsndmxg3z4VgshyG5La7qq5Mp9a1k7IZTzLY6bNuwIYfi7Sb71mAxLiJRegY3q7dLO1fXnXatF4atxaympIXbp9FsTcLz2HYrvExTogg4aiCQ/M7AlkfaQGrE+x8uOnO1Zni5XHqJLcybRBewdv2j5enBwL3lDPA5l5cXtZeR8mtdO5GTk2z9jwzDXMtgw/te6KrC/TLaVpQJ3wKy+F+UGd0Bt6JuKdsG4XlxvxvDAp5C1JMFulU9rhwzsrJlazEggO0vxGFuCqPdIp3RmFoiCO845VRnsCmUKuuWlJy3PIyBdPyUpY1JpcJEE7E504czCh4M1waZ8ksDFcOWibAnyCtPA6f9zdsoLvzORfNEd95rJxjrcN9d6mwJsYFiltqmXrg/n1fezwsgIhulRy3+rufxS1G+/xXCTFmoRfBgzh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXlQcsSNHVaaHCdJk9lau0DKnjiqVlAxuxtF5Umf5MC5L1wzCpEUjJX/sJtd?=
 =?us-ascii?Q?/JFvtFzSTK8XX4Vte2QkamSw5WVxbPDR45hUP0aUSek0UvWwq7UI7LCTtlxH?=
 =?us-ascii?Q?EaWcOpQ6a+lVabZrafBn1zVqUQWBZUBJXZ32SLVgygwxvsUnPEiuSwiyduA/?=
 =?us-ascii?Q?U1+4vsoNFbf0ymJNU6duCpJgOA0izyognnOxRPKBZJYeLtFTbyEz2yR1Zm2X?=
 =?us-ascii?Q?SYpOdtLv+pVR93fDFX8RcCqrCaqdsoQwQZPuEtQWl5aVNLKXZnsh5NnoFU7d?=
 =?us-ascii?Q?DCF9Trod+A//GQbmXSXH5xQ8jGV+mz8dz3Jy6XKFriXxIooJt/pTc3dyYuRA?=
 =?us-ascii?Q?KWJxTeqPhiiUAPynUKpB6XW/XkilTbYhg8iKoSUZszoAx7mMX2WhPeK0YWE2?=
 =?us-ascii?Q?yesgfLBSP2OQ8HVqRdnlhZckaamCc36i/9KK1DaIzD+kGsUS1W0VWP5HqEFj?=
 =?us-ascii?Q?CIqrr7+T3ZCRlwQqa95sH33yueee9Zi40cQQE7dFwv/3FJtpGKrtmAahfhNY?=
 =?us-ascii?Q?CmkC32a0ZwQ+3LvhSgB5E2kIxbUqPjmQTb9v5geu0wOGif30Zcf1Sf1+ZKkh?=
 =?us-ascii?Q?RFGjAqyVYzGvTWCQWe7CVQOdEKL8cJX+Hy2+VYhhJzCUil1Y12D/HO18CeEX?=
 =?us-ascii?Q?HiN4HgwMvsNuXPj21XWWISJb8H7mrflqTQQZguHZpFQuZOExyaVlAuXhnccE?=
 =?us-ascii?Q?cnZ0c28+Nxoaprfehj0dXLnKbe5vhY1hCaTQ2TxoS/VRBE7KGG+HB8mhMaN2?=
 =?us-ascii?Q?bf1WbjlRFiWbUHNFSKnOF5j/M8NfNGyRjh+mSoHGsyPG8/O7s4fTfT+cT+Lx?=
 =?us-ascii?Q?FyjSHV/lIdRV8AdQMguqZqJRmjDOojplOrpGsB/FjH18fepbgUe/2n/Euw57?=
 =?us-ascii?Q?mF4ZbAGiQp+9k1HeBbEs3lFQBhY3dSYjWaErB1DvlS113eZnzIonTssjUVkK?=
 =?us-ascii?Q?uYc07zP+vQwiTsNQ1b4f9Uj/x3yhKnsZGoXVXfYAG7Bu0SCAU7uo6jbNVbF3?=
 =?us-ascii?Q?ihNGonhE4apsxxhhO4oQo8+Ex3SB2t9MaCs7FoUbeZ0pYeWMI4F3TP1axRWa?=
 =?us-ascii?Q?xjc5WjTH60MZ3ZAIB5W26o8R3kKxbPrm/4sK6aQ7rECgt95A+HGE5PCNjgGf?=
 =?us-ascii?Q?aMb8YMw8lMg+f0+YfF85OfHsf17U7f4KTLmfFSHCHprUJ/2JwRGZMj+vZOXj?=
 =?us-ascii?Q?0JrmG4UYlMzUflQUhGL1hN1RKyzamZVShbX3dGERKOUl3E+7x6ulEGVdklgl?=
 =?us-ascii?Q?MLq9vai3IdMN7Xp0T8u6dpptOEegXkKnOyFXh2f42TmspfUO2m7vbZsPUU8r?=
 =?us-ascii?Q?D2IKjR1Yp33iB+mkV0DYxuIEoRkQHMmYgU/XFgiSEN+h8GcjbGr2f7r4OVCk?=
 =?us-ascii?Q?b/hK2GatbAESjQtJQYC5m2dhKbtPx8GlV3zMPVKyuz0IC2KAk1bs3v7bxdnO?=
 =?us-ascii?Q?ZdhjmffGlt8jRWa7islFCahdMhRJaUQ/kKZfmH3/lyS7bzUyAWSvNmSoQ5Wy?=
 =?us-ascii?Q?HrxRB3/VUOEFudHOBtIAMFKnG9FeOaqZKOquEkBD+h5fCPYoXfLVbYo0/Ob7?=
 =?us-ascii?Q?SOqbwUdHG3dZfrC7Hi3DjedRFTp/IX5fooAu+LJ1dZLHO8Pr+arTIgtkuael?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b9d247-0d70-40eb-0e77-08dc533f7f2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 18:05:36.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+IHHlEvh+D6PjeIjZTG9378E8s4VO+mVBN4xHO2rh2vQ3g8uiJpSI44WOyXVVsJO4kD0WnyQlg93ZyhT6ddyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

On Mon, 01 Apr, 2024 08:03:15 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Sun, 31 Mar 2024 21:52:06 +0300 Tariq Toukan wrote:
>> >> Hi Carolina and Tariq,
>> >>
>> >> I am wondering if any consideration was given to making this
>> >> a generic counter. Buffer exhaustion sounds like something that
>> >> other NICs may report too.  
>> > 
>> > I think it's basically rx_missed_errors from rtnl_link_stats64.
>> > mlx5 doesn't currently report it at all, AFAICT.
>> 
>> We expose it in ethtool stats.
>> Note that the "local" RX buffer exhaustion counter exists for a long time.
>> 
>> Here we introduce in the representor kind of a "remote" version of the 
>> counter, to help providers monitor RX drops that occur in the customers' 
>> side.
>> 
>> It follows the local counter hence currently it is not generic.
>
> I thought you'd say that, but we can't apply the rules selectively.
> Everyone has "local" counters already when we add the generic ones.
> Especially when we start broadening the "have" to encompass other
> generations of HW / netdev instance types.

In the normal case, we actual misreport out_of_buffer as rx_dropped....
Carolina is working on a fix for that.

  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_main.c?id=ea2a1cfc3b2019bdea6324acd3c03606b60d71ad#n3793

With regards to the case for VF/SF representors, we will be adding
support for reporting the out_of_buffer statistics through the
rx_missed_errors counter as well.

--
Thanks,

Rahul Rameshbabu

