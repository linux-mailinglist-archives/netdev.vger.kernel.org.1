Return-Path: <netdev+bounces-79610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74B87A3CB
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 08:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553A31F21A0E
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F230D171A6;
	Wed, 13 Mar 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+Hl5huM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F4199C7
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316736; cv=fail; b=Uw4loehGRfRM5zKEJcXc7W6SzLgfRanr0Igs+xpdt8otTvI63poosRf7Nv7YrjzwIoIqC0bGHj1Mwenh/7EOPM0mUY96aksUNJuqrddRjtFeD0syPPvO7gnfBPjjkSgB3vfra2l8IVQU3rWLQ3CXnSh5n1LcQU3WTApVmRSQgd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316736; c=relaxed/simple;
	bh=m+OoCGWssrTdvtiqRn8ZScNGQJSZaqj34dKJc/Mni9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M0upVfrZiTk3gkBO+5avImq0ob5HZm7bqhvZcsKQoGXFjKPx9PBXeGagt+NSfhPL3g8TipNfjGnXHgsmKLh0F6CTABj3E9QhP9IvVynykwAVL1DYRxPPk4LEd9IePTdeOjRfiImynNxNjBPZnmmYOv1UvRM+ojNtPfkAEAqv1Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+Hl5huM; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn8raKbV3RZpsYExyVkBYomLjIUZiPa5SPH5N8hH3RnhxC3ozGWSAG2KsqqU5geokAo714YKFgXdbsK2+ZS5wgDoKtbCuykOjbJXdmrGvoSNskE8H/Nsax8Ky0CN51OaKahrlvr/daegPt4qiuJpTh0zfwX0aG1QnxqTGUHefsk2PHvA1LrAzLMAtjuVdKZv7cDGF79gl6QGVEad4acMizDgYrOVv/2AFT7lrvSHwEyYrHQfv2kVjevCxqiRscoLDro+pjPh5Yi5uhtAjsPiacUNyXy5wMnxF3PPXOXsjRuC8m3kW3r1pqttEIrfatcbLbS5UFKTC8WnNqhxzaELow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v79VUBthjtIxVBIV3BU0bD0oRxh6H6LwYee18looQc=;
 b=aXuS4IOYM7pUqnsMUQsQbRIbclRk85Wr7bsQho6zC3l6oLVpQ0NbBknu52+8EpD9ap6k6nXSTrHGVIL1Mo2W8l/JrV/pdJpVooCxN0bENHTndUS4bH9k1H6UZ/S5O/NfhfRU+FWFuIfjNc06eIoQY9oMoYVNnJ8RH9IVeVn/iHoMbFlxhWAsZaKXBBkntQmYlGAA1H5xmTN/1Hiv1lKtJdUT5DDLUDfaKsu9Pi085cIHxByvOV2Q6m7K2o5CQbYMiZA0IHco2om+7LY9LYkS+gC36KxoB9rE3HbqG501oM9LoSXEG45X56X+w0T83gfCb+2bwfgezfBY63IIlXl5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v79VUBthjtIxVBIV3BU0bD0oRxh6H6LwYee18looQc=;
 b=o+Hl5huMjeEkA18B0rVBoRc1C+lrpLdNN3irskC4LzNMMXVk92AfAVBQk2C0LphTQPOlNc9qLMOHxrhc6WW+eYiHSAbqjcSrVS+ilSIgV/nZsxDVvvqsBfn7GLcE0KcO8WZqljfiPk1amBCqCQhdnlTTrUy8gHhfU3DqWmCoR8yRWjhcFZcQf7ZGsB6iJbS00E/lMpOAO94/1s5Zr9R+ndaaOX2e0GfW+LCiO9noTRSn9XyDhT4CmdXKWvRcqFK3zgGpHaWWUv/M7RQWj1kyLZDdnWfYzgx0t+JfLC8sPglwZUbZZuXzYkm3VmR2i6xgneKNBi+NX3y1WSI8nShgYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 07:58:52 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7362.031; Wed, 13 Mar 2024
 07:58:52 +0000
Date: Wed, 13 Mar 2024 09:58:47 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 3/4] nexthop: Fix out-of-bounds access during
 attribute validation
Message-ID: <ZfFctzVnPpwsx1BJ@shredder>
References: <20240311162307.545385-1-idosch@nvidia.com>
 <20240311162307.545385-4-idosch@nvidia.com>
 <2a064df1-9c43-4224-aa35-6c7939852d1b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a064df1-9c43-4224-aa35-6c7939852d1b@kernel.org>
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9e32df-6b7a-433e-20fb-08dc43336c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gPq2t7hHEzU0hBvbjJbGRT5it2JJ/57PAozLNYJXZzDJyy3a0X4gFY+h47HufEzdmOoe3zO0//5c9snZ8ag86T237jkDt8vwn5fWgCrejPLK8aJKcSH666C53S8w6UYRf0RvlcEOHuHJgsBiIezwI5CcHLqiyqLHXd7EeUj8wm6kHAG/klJ+3xaLTE69DzvsZrkr+52UEADW4onnNG9IeOwaL73dMSyLlt2VE0tG34xZKT3V062xqxMBg2CY1v22JH3je7X4FB0axX9o4Fbb2KR7L/ipWTmk0JHpqG9HBiMH6WKCaoezi/1Z/vO39udSXX/G/lJpfr818SLG1N/omVKmZYuON94oMqNASu/I5WO0k9Nc94UJYz/UFdfggKE96Cc6VFcZWE8Z8EpAT3NSmX9bTWtewcp1kEpXdiZHY8ScL9Joikw+f6njV9q64GBpCBFGuVId+snAocQXoqR/a6LPdgqQaKAY5Xlb65s1lMnRQqeUM8aCGlLHysLDgWzd55HQoqjHdgq9jx0+uU0OSaqZxrTL4H4GehNBw0g9ao1c5ocjMkvUjKGRwTjbLoWEdeIxmMfmUODl6OZ/JiTf6NyunpZbHz0xaX4GIL+frrn+Hv5QTntgd78eAnGdumdRFz5KYyMeB/xI2PwdKRmrTl+MUlQ9hHXWQorJ3Fzlz1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ZiR6zJq8uIFcY6iqlqMYJDbTr1j94oJShU0s2YZhMsWQEXrj+yDsxD+ApX/?=
 =?us-ascii?Q?u1jK1me5zECConI4R3maMj+WdT/lV90WvTZkwdrw1VwnGHZOfxurEmIqkzVU?=
 =?us-ascii?Q?i+k3IRB1B+x1smjHzY+Fm9gnfQDl73J0DwxPaTtSaOCfcdbfvASOhbILJnDb?=
 =?us-ascii?Q?6wFmWRsQHZf97Z6Sv/vVVEOA0/7YkMLi4wtCGDMPRIMaGjwcxE5dt6LCO7Co?=
 =?us-ascii?Q?oWoHEzD9rOdI7dyhTuiei9ssogtvAfdacJV4o3UistP4oE+epDZl0a41q0tg?=
 =?us-ascii?Q?exbFW1d0ieAr+Q/gRUx1apVhtoVXkBZRf6zg6WR0BkRwQIMnBTJN5DXqdrk0?=
 =?us-ascii?Q?rkoXkrFf+JDQa8c/xAnxfX2uYguwIr7KtGkti8cLZkKFrlDTHfW0N0CSw44m?=
 =?us-ascii?Q?tXCINh0WKYpX/gR7vmWWd4fV98IyxJegyVZyYBgj8jS6GqFwVjVfzD/+kgDP?=
 =?us-ascii?Q?J1KAUij6X35LSr0JgEOS9Djijqh+lxj3Kt2khSOFi0bkVxwubWSfY152n2MX?=
 =?us-ascii?Q?qNQSoeahYULbq1Wc7JTyQ/WT05E5pBIwwgEUM+eLcgQ6qhOaqgTQAZLp/9wB?=
 =?us-ascii?Q?B3oRRBoUz/XlbHD9qoexxE2xWwe/RynQ+0NC5FcWLv0TsZRTBKdwIfD9iuzb?=
 =?us-ascii?Q?VCKCH2UjFFdF0GSnqtD7TE1G+yJtU5UYL2Iu4G4zRjHXIpgfFeTyIKYqeX3Q?=
 =?us-ascii?Q?WCvDL/6Xx0Ia6g8fR5p2NU6LexEjbOm3C5nKA8gEGruOV5GbMyVbu4FSIQkt?=
 =?us-ascii?Q?fTHOkiDTWYlECXT9rEECUEzJCHKPXbRkZ0mZQsP5azEdiehzCWpB1jSM/hl8?=
 =?us-ascii?Q?AvZZKF9nucVsFqt9J/PkL3HyZ2Q0sIkWvhBdVGH3VcLZKlSnjqimd4BrYIjb?=
 =?us-ascii?Q?QMd6muMirYCVV84uSBxXltw4Lzp2l2Mw2haJNuPIQkeyUA0Eexewdg7EUSzC?=
 =?us-ascii?Q?3DQjtfozKj7567H361V06nlUmgC2oZWOYyrUs5b3O4bd9hjRDc3iVvbZERcU?=
 =?us-ascii?Q?SGl+qzFTRhvGbK7eseVgzM2FVOb7II0eKKKfAFrEuPqyZa3omoHtlcvw6+dg?=
 =?us-ascii?Q?k/FPRqrwEKVk2hZgLkIrOGTMYI9sm9nzm0j5j0ZgHZTnWORp45KqkoTbEly2?=
 =?us-ascii?Q?Gt8ABj2sNE0t7lgmTbWwHlBjYHfpbUFm1dtC8r8ofFvz15ek8X/HkhE3yAho?=
 =?us-ascii?Q?sebMO6G/51IB6KLJf0WEWcQ4tAU4ji3EKormZimURYIZu3JxVfTigk/FgiU2?=
 =?us-ascii?Q?p+afbWz2Xy9Y39VOUoMsVI1NX5a1VGoHFBbFXoZdfN2PrWng7ZeS4NwKPWpJ?=
 =?us-ascii?Q?BOUKEnQjo1ogldKoR3uRKfhODklMOnWxEv+2uvtxMOoRDtozr9Y49TeNNxJo?=
 =?us-ascii?Q?pzXIgvewNkBzGryk3xkUPsa2G2ZJfXTfPpdtHFAZsHAV/ufGQwsu6XkLPWRN?=
 =?us-ascii?Q?FVeLeoTDPPyC7n8gIcpNSKiL8oiInuK+HkpgpNYNMGPg2nN9Ip573rP6B7M8?=
 =?us-ascii?Q?E/hOPQE9IIPhY2AnLRd84o4AiGUNkyVre1qW5T8zjBKU6UVahvS0O6UlznuB?=
 =?us-ascii?Q?Y/kwfy0J4he8uspIy8rSU4y0e0jAy3ZAlokZmCGR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9e32df-6b7a-433e-20fb-08dc43336c4a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 07:58:52.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6POsEaXawmY4I7oKVwCg0zSmYRR0smpyzmfUcA4dj8phoT+vuqsybfElu/TAz+GL7yGmCAG/uSRVi78BTq0sYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

On Mon, Mar 11, 2024 at 09:28:30PM -0600, David Ahern wrote:
> On 3/11/24 10:23 AM, Ido Schimmel wrote:
> Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks!

> 
> 
> > diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> > index d5a281aadbac..ac0b2c6a5761 100755
> > --- a/tools/testing/selftests/net/fib_nexthops.sh
> > +++ b/tools/testing/selftests/net/fib_nexthops.sh
> > @@ -2066,6 +2066,12 @@ basic()
> >  	run_cmd "$IP nexthop get id 1"
> >  	log_test $? 2 "Nexthop get on non-existent id"
> >  
> > +	run_cmd "$IP nexthop del id 1"
> > +	log_test $? 2 "Nexthop del with non-existent id"
> > +
> > +	run_cmd "$IP nexthop del id 1 group 1/2/3/4/5/6/7/8"
> > +	log_test $? 2 "Nexthop del with non-existent id and extra attributes"
> > +
> >  	# attempt to create nh without a device or gw - fails
> >  	run_cmd "$IP nexthop add id 1"
> >  	log_test $? 2 "Nexthop with no device or gateway"
> 
> The basic() group of tests do not have a delete, so this is a good
> addition. However, the ipv6_fcnal and ipv4_fcnal do have a del - seems
> like those tests should have caught the out of bounds access.

There are deletion tests, but they only provide the nexthop ID and the
purpose of providing some bogus attribute ("group" in this case) was to
trigger the out-of-bounds access in validate_nla():

pt = &policy[type];

As rtm_nh_policy_del does not contain an entry for NHA_GROUP.

