Return-Path: <netdev+bounces-236992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 696A4C42F05
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10BCD4E1705
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361E15A864;
	Sat,  8 Nov 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYJqvOiI"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265B1EA7CB
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617701; cv=fail; b=SczDsIS5IPuNTHUHH+5vnJtyYzkP2I7f83IFFoLN9gUtv7VN9lWg2TAGrY0I81wDTDmF1m+UxzLVG4QgKiq6q5VpHQvojwojcgGk+oxRFk5yLQwVLwJSNWeNIG8TBo4s/CI9JWeZlpamw88M0w3Zmizg0KZs9u1euQZNhnsJ6L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617701; c=relaxed/simple;
	bh=Z4p6IV94T80rp1buX4ILFAAJ08yotfuRagzo7SaXm10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2Ymwpx0zGKPOQ0a8Pxqx3sensl5hbA5GuefpTTREMUoARs9F8A3sS6C033UM9oe5u5U7f9sAwD2BG5a4tPfbeaE/ci2jDwteIMZy8lRbYBBpFVt3IaZ5oCvj5ZCUwgYIa57uW1rMHgCS8WkG7S2aZl0nL51nlqp9QOCpH66Kvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYJqvOiI; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym98ev08TCzQk+Fb8TvWrUmDRET923lTLDaaOGh01Y0+Y7XLJ3rvkZi+fKXyLnv+bqtIIHAuOvC+NPAEwet//EvYA4CC+dx40gorbsOXEK/gTxlEAcYsJ4CPA9HO6KSfXczDtyrCA+ie30ioZG039RI1XY2ycQURtlQUWmKNcBB3BMhJXZdR4OOHLMOwoSQbcpYUqqfsaDcDSasOP086kk2FQKu8/LSpLnmyNGXg3rJ+W1EEOrGQl/D8GGN9VCQuMpOulv4HTMwz/OVauMPS2lszwwb/NQMzaVd5IgB0f3AnBp73UFNs+Mq3RJ1kfQxMF2ShES3kcfGHqs9L5TJRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiHz2BxuhRM3l/kOjHMEzCpBJgiI/6xL6fbaABFePws=;
 b=g11P6BQOuiPAeei9207BrZkhJFQSTQMv926HGTFTa43fGOJh1zT8KzaG4r80S5c8H+QhkJ0er8d/rkYWl1rcVu33ye0Xv0hB30i0fOV6eejDWX+YZ87RjTTbJmOvN2wkWZBIjAJYJ3VFaz+Ut2iAR/hlkTP9zWM50J8mjefr4nzyV6DxhIibc64vyLKYu3nAWEbOd/x6PpRJVqqQ2Tnp7d/N1P54JMHtnfvXzHi4RF/j44K7iVcN+H26FZFB6Nr4KvbynF/z5xLSniF+xTj4R4D5yAroDNOoUepHim6/Y7uHhA7Yl7UvXdvimZb8TV5zZX7o+CMpIVR/EDtVybxpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiHz2BxuhRM3l/kOjHMEzCpBJgiI/6xL6fbaABFePws=;
 b=tYJqvOiIRQ3/ZyDN7orhF/COnlfqf4KrMp7RLc6Jkzxb/0K0SsfY9bxsHEvACSUkgyesrKhZ/jy0CCeCDKqLRRJ0vwzKl1D8q95pgYUgB2BssZKszehz+uota5raLU3skvfG/3GvfdyC2b/7hphFPbdRcNF8GMiZ07h5hnAwyIw538QqiWSQDDZ+vxSqgjPWAR0jGQpkLf0L+N9LoUofHWtfmsxfYBc1IwNO1TSvfe470L13DE4DV01PRWOQbn1zcCcqzL7WsMVGWoMm0NPr5MRkytBibJ75Bcl6MTjWGyVtvnVITqqR1hJRl1dLtnd9MOffFMruL0DECxgecmEbUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 16:01:37 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 16:01:37 +0000
Date: Sat, 8 Nov 2025 18:01:26 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David 'equinox' Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	dsahern@kernel.org, petrm@nvidia.com, willemb@google.com,
	daniel@iogearbox.net, fw@strlen.de, ishaangandhi@gmail.com,
	rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next v2 1/3] ipv4: icmp: Add RFC 5837 support
Message-ID: <aQ9pVt1mvU96p-R-@shredder>
References: <20251027082232.232571-1-idosch@nvidia.com>
 <20251027082232.232571-2-idosch@nvidia.com>
 <aQ4tamfiDiC1TomU@eidolon.nox.tf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4tamfiDiC1TomU@eidolon.nox.tf>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: da0d53af-6ec8-4997-1044-08de1ee0187a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VPcJrN+niICnzFcP4r0ACRgST/c9sE17PwnhJURbxb8JcTBV8xf7FVjeOgrG?=
 =?us-ascii?Q?TNvVfmavSs5vvCZFTOyEBDqATxVf8gM74FTTj0F8/9bZvJOkur0SZcdM+R/l?=
 =?us-ascii?Q?WSgBg24tarGZypIKyjyu3O8VjE1ZMln/ufUF503NFYLionMSO+LqmVC8lg4f?=
 =?us-ascii?Q?VcjgMzR9wVVuZ3+2weMPq5SjmKxqQR/+kHoeiqY1IkwHX+EWIaAWFH1aRujJ?=
 =?us-ascii?Q?EriRtVBcrGY9HG69rZHLb7YJNGY9MTP7zwQv0j84huliFXJtqS6o5CbDLsCJ?=
 =?us-ascii?Q?R/0LADTB/8sUs79CvwbtKMGwibuXFHiZD8qI3AUQ4XCMhnBwmcFmRHSuLFLZ?=
 =?us-ascii?Q?KmeFmrZYiKi0TpuXfoeaOGS4dCky6ZvXZbh0xMwZdqMDj1DBXknEas51T2LF?=
 =?us-ascii?Q?Sx1BPAQ+S9G11QiW3P8Df6w+K91OroKGGJbceirs9kSaOmIDrd5oMf6A3iJ/?=
 =?us-ascii?Q?vgScaXDyVwkw3PCzOc10E4u1Neyk45jGHLQnbR6bEpMX2124t4q0ogQ9Aofe?=
 =?us-ascii?Q?PzK0UBob62jNY2cmXfakxGGXkeQWqf4RamJ++UxAX/tqk84O7tmyfjM0LghS?=
 =?us-ascii?Q?yd32S0j3kLPz9QCUtr4qUE61HbKg83j4Vk3x4OkhsPWJrjApverA9TYvAqJI?=
 =?us-ascii?Q?4t8dZnLI1+uy9aP8D6NCZot7MhGLUdyNtkCElQdlLt4T7tOCwUlGQKbMWn4X?=
 =?us-ascii?Q?vfw9w8z+WnnxqbNOkXn+saIuRPyGgSg8q78MUf9rgegZuu6QUJoEo4xApuQw?=
 =?us-ascii?Q?7L/aRZ84iOheROuccS0ZIzaeicrQ2aXaaCg758Fg3okq/unS3wesLud1cwHi?=
 =?us-ascii?Q?HbPsiC7MI36ezg7l8AG1ibhSJ87qkSsd4kkTczrDP5GAxOtXJCnIHWRMOayB?=
 =?us-ascii?Q?jCtbvMwBlSMGjS0xqDcDCQU9fUgHIWK5iZsfLIaR4XKCWxdE+Zu4F/3vlDYd?=
 =?us-ascii?Q?xjNi5HmIVScw2N8A/hEQutyEBkZaqUUqSZJhgeI3vwV6mvWKITRJffiKf3vO?=
 =?us-ascii?Q?HtrZLPVdofymGMBf5wMHFMzM4nOBypl+QqOszyJT60Uoi7n7aKDr5w80uawO?=
 =?us-ascii?Q?ofAZ2snNL4Qjvg4f9RLzNAWpoEoeJyc9kMwOOWzLHHJ37NU5ze9KLkQiZIui?=
 =?us-ascii?Q?q2+7l3w2mXVFtU2VoZoZD7xEG09EKHXaGZk+M9FMtQXfKWmTGut6ftK9sftn?=
 =?us-ascii?Q?38JfT+XALL4Sx8fzuKm4ibrQjP7yh7mqvBJpv7M0slGDzPf7q/Pi5jE4HImu?=
 =?us-ascii?Q?q8NAvouMYh1sXitXmYit0V18vxxShFTsn+2fQrdwRmzs/CMQ6k/u8KhIDXb6?=
 =?us-ascii?Q?sUF727xYFsUh90lAposFO6Zcvb/Bl9Kg6fTI5JDcS53odaVzk3k+QM+q529L?=
 =?us-ascii?Q?FJl6c97KJOh0rJEVnVY7intcuSDidiuPlPpA5bYW5ZAPlECXoJaPNxhdS3If?=
 =?us-ascii?Q?jCCDUxYN/5oKBA3CEJ2qUZC5JD7grR10?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7AP9td7gCi+7Dk7dbnbPeVzBekxEIKhzUW3zp2zQumQZ2SyQgX2igR2D2bkT?=
 =?us-ascii?Q?3z9hkQYLZ4NTCER98kKeOQgLHiwJJIZlUKZUhbeEQErMR57tiVAD64ypp69W?=
 =?us-ascii?Q?ounNwVAxUqMVZddJJUF34Pnp6Ankfemp2xSpfJLnu1k9NCPug6v7NOh+DELK?=
 =?us-ascii?Q?j8XWFqKmSA/yAcvrmwfcvZ7rMcHaM02T6vimsknIjVGt/m6omVz2vi1TrOg9?=
 =?us-ascii?Q?HXUNd1vnceTtol7PGc1K7RVIjxJFclp7dKO+xBnOwiSwEj54j7OXBMvPSQah?=
 =?us-ascii?Q?yTnurTz3WOSS+tlO8+cnCPJZ42fwnpXPcM9h9+oiR3eieShdu2DwIvApg0/z?=
 =?us-ascii?Q?p54KM0WxjxrFiqpsm8tJY94L8RKTPDZOnG22V9efYyyVgCxmxy9/YX5crcyk?=
 =?us-ascii?Q?kNpcj93PmjxZF9WrOqXKvsmDnc9q0D7cxvxPj6ZB5S92P3Sli0tAjGWvK05C?=
 =?us-ascii?Q?TBk6bg9cE9OkqPdKhsb2GZ2sdnKvQdR5LlLfWEKi/HOOtWp7dytl0JC7GD9j?=
 =?us-ascii?Q?48ScbgrUHiNGYNztvfkVNjXkN6lr2Pq0hEUFtFduz7MNq5VfsZ/a2kiyywfK?=
 =?us-ascii?Q?/v5Y3K40A74Mmah2Ss8EOPYa00bsMeDo/XPWx0v+0KTRo6WkmvY8FtSi330x?=
 =?us-ascii?Q?BGxUMtfd/dJxjoJeg/lHPmSdRNKJ7CBN/ffzhgxIAyoRL/sPT+s3bsi0HsKa?=
 =?us-ascii?Q?X+uGreYipwPSf5k0No8mWjyMHy9y68NCGPtTLEAGfF5GKPdJcv773CaxiKw+?=
 =?us-ascii?Q?+Qadrf9RXLY0eruahttor2+uy6Ax/b+rW6b0QD7g7cy+qZCkFkNFLflADI/c?=
 =?us-ascii?Q?sice2o8R5VAshvuQ2qG+mlqp7FQwFQGQKLnD3V2MjqwuhzLkb+i8SIdBVfla?=
 =?us-ascii?Q?+x7rmqG8CxLrvY0lgS5avRlzvEHzqKPJXQ/rkrXjbwiT3aJ5X3DySd3n5TfV?=
 =?us-ascii?Q?/Sg9dzdrlSMqLPbHHJ5LmA/DUPfQ/52e8LYXSYVl17uoxcLLyAtOyGToDRP/?=
 =?us-ascii?Q?GqyR8pFLzeFn0ZAZtHqDRGymPnTyvTMyv3xa+wwdOGl1Hw7zueCEXG31st6c?=
 =?us-ascii?Q?Ktxz8Me16zk7/l/UxKZk4T4LS191f5nQZk6zlzrssoWW9j/2pLUV1dKPqkYI?=
 =?us-ascii?Q?c/O/7lNIjBRMiqhhHbJiWByvO0AOtY10VVYqwM5nDyDVLF3HwcJftv+5EMK3?=
 =?us-ascii?Q?q2xp8E1AQ/btLkxEBtBT9lfzyJ4r9myXTBN4yVXr6HpRHEJ6C32xgP9D4In4?=
 =?us-ascii?Q?HzMjQLpHxTYtHf/kAFZaN/diQTiKKc4RVJrUsb391a9l1h0vT2WtR1L2mgil?=
 =?us-ascii?Q?nue2w5dHwBEg0HqYh+ksjUEwgk5r+QkodM0mj0/F37lGz6z91H8LgjrKW5pq?=
 =?us-ascii?Q?cHyq7YqtMhelDE4Ld+10hkJQQ/9WoJo8SO6nsIUC5dScaVdbEBkc5Pf9ya6v?=
 =?us-ascii?Q?ZOtSzyllnWXR7L5RYP10jrdPL1+ByTdAM+Pm3GBO5/d+KlZBbNQTagsGWiC8?=
 =?us-ascii?Q?wloXiPNi/qAbVy0z0AV5ZgwtLkneWP9ok95N8BRF7xDF8DLh2u7rHTRuHsxA?=
 =?us-ascii?Q?E4qWSEfE01P6wZ2zVoUq+lWlLZxUNEqYZjshCmC2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0d53af-6ec8-4997-1044-08de1ee0187a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 16:01:36.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYg9X7MoLms6lvoDEr0/0/8lfTmsHtDKEoFZitdBPRHOZKTPhG14HBcpjt/Ejdn/dzrhALF4bnaiH7OpsLXUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769

On Fri, Nov 07, 2025 at 06:33:30PM +0100, David 'equinox' Lamparter wrote:
> On Mon, Oct 27, 2025 at 10:22:30AM +0200, Ido Schimmel wrote:
> > +/* ICMP Extension Object Classes */
> > +#define ICMP_EXT_OBJ_CLASS_IIO		2	/* RFC 5837 */
> > +
> > +/* Interface Information Object - RFC 5837 */
> > +enum {
> > +	ICMP_EXT_CTYPE_IIO_ROLE_IIF,
> > +};
> 
> ...
> 
> > +static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
> > +{
> > +	struct in_device *in_dev;
> > +	struct in_ifaddr *ifa;
> > +
> > +	in_dev = __in_dev_get_rcu(dev);
> > +	if (!in_dev)
> > +		return 0;
> > +
> > +	/* It is unclear from RFC 5837 which IP address should be chosen, but
> > +	 * it makes sense to choose a global unicast address.
> > +	 */
> > +	in_dev_for_each_ifa_rcu(ifa, in_dev) {
> > +		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
> > +			continue;
> > +		if (ifa->ifa_scope != RT_SCOPE_UNIVERSE ||
> > +		    ipv4_is_multicast(ifa->ifa_address))
> > +			continue;
> > +		return ifa->ifa_address;
> 
> For 5837, this should be an address identifying the interface.  This
> sets up a rather tricky situation if there's a /32 configured on the
> interface in the context of unnumbered operation.  Arguably, in that
> case class 5 (node info) should be used rather than class 2 (interface
> info).  Class 5 also allows sticking an IPv6 address in an ICMPv4 reply.

This patchset does not add support for class 5 objects and the above
code is strictly about choosing an address for the "IP Address
Sub-Object" in a class 2 object. Support for class 5 objects can be
added in a different patchset. An administrator can then choose to
include both objects in ICMP error messages.

The kernel does not avoid using a /32 as the source IP of ICMP error
messages, so I don't see a reason to avoid using such an address in the
"IP Address Sub-Object".

> 
> I would argue the logic here should be an order of preference:
> 
> 1. any global non-/32 address on the interface, in a class 2 object
> 2. any global /32 on the interface, in a class 5 object
> 3. any global IPv6 on the interface, in a class 5 object
> 4. any global address from any interface in the VRF, preferring
>    loopback, in a class 5 object (addrsel logic, really)
> 
> [class 5 is draft-ietf-intarea-extended-icmp-nodeid]
> 
> + analog for IPv6
> 
> (cf. my other mail in the thread)
> 
> Cheers,
> 
> 
> -equi

