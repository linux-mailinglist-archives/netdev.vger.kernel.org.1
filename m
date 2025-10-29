Return-Path: <netdev+bounces-233865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379DCC1987D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA39A3A7A7A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156D314A9F;
	Wed, 29 Oct 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qg9Wm18M"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258D28850E
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731701; cv=fail; b=pvi+okc5dwf93tMsM7+NRbtMCbPOT/h6gmo9vis61Co6tCd3/z9FbLBUBmy1sspYIaXV3o5ZzGWpNnsd/mkvAoHrbKFTjGC+ypIy5twFV/npg+Fu4UvvqLwNHbHryR7x2505M5+K8xoZRMFlq/vnwC6AjkbPG1GvjjX0KrLKMrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731701; c=relaxed/simple;
	bh=lTolmOQIpovpp5u2ksZ5YbUhOs0WX42+ILQxlwrD6rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cJzf5J7lILViIItmFC6IeR3aNYm0eEo1GsLODhW7f+nuoW72kzOimPconr9PFndujFm6UNKUiFG1gyIA+hYH5K6fllX9fsBUjX+TwPDFIDAKqd7RjP0/ve/i0Mh3Dly06kF5HFOF2GBi6A6cVxVxRv8WfuyslRUr/pNsu95UjVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qg9Wm18M; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ5Eg9ucuXycspHL8bXVZxtdS9LO3L6gGrfYqJyqPvmLcjDPDadn/04yT4J4w3u+heac0RS0OEKQT/s4nCqaYUHwG7Cdx0yjLuLwBffUPkRYAPVnIYljTPvNHGyI3sOJ8w2+wUH71Q61usdZa9XM1iVCkm0wVYHXWj02JJHliKVlAd0g0KGYfaZaVJ9DRiA6TGYItzTIJpbSF1JauNd5EvXDNT0+Qf28f0vbiGO+SxdU6dw9tHr5m0U2dAyZFt1VB9BuO5PmLNt2CvfrTKpv0Fp214UORCdBf7uJ03nUGSgQe106okYiQnZlORqmtlN2R4e/hIq7VNehEZokF0LVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwau+YK+ip2E+PeUDdVjqWuZGRmZ3OkQIJJNpNUq4Ow=;
 b=Bwl4h3Nykl60HEYx1ulEDMwJDmSrY6BLUF4KGNfe1DYgTOVh/HWwwCUWskx5U8g6ZRuCu3rrDWY678Exj+HU1N+Pe4QETx8xH75FsBbYz7cN0Px7PN2lh2UnOVP5uB3PyX8A+66IMjIElPXxnge8wr5mm6IZSw45ASolzxQvAujfewZW9S3d0ddxfgDSDsRmZUH+pP1dzTgM6g8Ym5jxN0jHxXNcjsXldYxwG0Uki5OKcGcp9PRWVgf8yjVeUZIPRnuJH0TfglqohT9vjo0AE1GrLRG7GWyAy0NbSE7XdqMOFsBdwRm8/+usFt8aAy7wjtpT4CsMZbh3DwCwcexKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwau+YK+ip2E+PeUDdVjqWuZGRmZ3OkQIJJNpNUq4Ow=;
 b=qg9Wm18MZg9yEYgxK/nRXhNUmFp9lGtk/xfqv3hhzR27DYaZ8sqAJpGX1o4N8m7U5sIuxvMSCF0CM4PyUN4EawxxdcdGXU+dYLz7WVSxTdIW0W/XItRWXQHkKhd10zauNBWwWGtKugkhz52g4+NJrAEaHpFzQDz3880X1Iwkx9shCDugzv/vrojhQo+bMgeRLXANYOBHti869OZMtSiOeANQpMtDD9RljvUmAroDbty84uLpyXN9SNh0V9rNNZUX0cCVoPL/OkZH6mOqLETrgaaQ1R7rLKdMeA5XSERYCnorWyBLYPDF1fmTLcuMrd8v21DNpV6BlI29dd5avhTPPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 09:54:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 09:54:55 +0000
Date: Wed, 29 Oct 2025 11:54:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
	petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net,
	fw@strlen.de, ishaangandhi@gmail.com, rbonica@juniper.net,
	tom@herbertland.com, Justin Iurman <justin.iurman@uliege.be>
Subject: Re: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
Message-ID: <aQHkY6TsBcNL79rO@shredder>
References: <20251027082232.232571-1-idosch@nvidia.com>
 <20251028180432.7f73ef56@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028180432.7f73ef56@kernel.org>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2d35e0-e37d-45a3-b898-08de16d13690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kq3EDj0BTgMBIJjkDcJzy7XSg5kYzM+I9lTijgjY53MpA9Bo6zO2vJx16JPP?=
 =?us-ascii?Q?0BgJodGhIq4r7Kp8GDTXXxCK7X9kiy6hkzIslM4wVR1A/MAbQHEONPJtjRnO?=
 =?us-ascii?Q?ttwgIsAjrySlW4xtaQclXMOZmV10qMk0nvnrf/pm1q3rPkCbCq8cHcBU+hu4?=
 =?us-ascii?Q?oY4qNbL6TDR1GMgqbsZsek7Ob3rpEKveOlMwu3RTxcbUmm3sxE7+Uz8N3dpQ?=
 =?us-ascii?Q?B6fdaiPmoKisws0BUHi5X922cS6JOcpNDC8oytVjheeUr+e/biIaRZhMMwpa?=
 =?us-ascii?Q?OAF9n3fLJc4JeDsI0A2mMqFnVp0bFNnzn1L5JytHdZQkB3ChwKnZKAWt68zB?=
 =?us-ascii?Q?PjcuZnvzsutr+7Lg7N78JvCXnkrhCSlgCUIhf910K75S7i8yI5yugp4Io6nN?=
 =?us-ascii?Q?hR7iN4WjrfEdrnhFi5TW77TFJm1H4o6ZyUALxeocP9PHhsr/Ab8w0wO+D9tD?=
 =?us-ascii?Q?2bBLHj7XzFLSvBiGlCI4Bg3g03dZylb0JoTKUpkahtC3pMFDMP1O4lJLm3N8?=
 =?us-ascii?Q?NgGtji4LSWw1YQqVJLhgl59J65pIwUFZV4Dl3tSZ5+vbfnXXKxqbxIgG59Yi?=
 =?us-ascii?Q?VAvkF869XFHE8Dlf4c42xRavNeo6qS2P4UXVI+Cc3/aB+dn0JpGyNyi9M7qP?=
 =?us-ascii?Q?JAhAaTcLbobAIrTgGTRpFjv8r0V86ohv41wM8VhwCJojTgdOm3XsFaHpJQdP?=
 =?us-ascii?Q?lN4oWllThQUHea47osA7QfmDnjOQRVrPICl7F9dRvHUglRrQPanBobGg3mE2?=
 =?us-ascii?Q?rItqXA8cr/KUcuUxBbnHMw8cljRrEzxYrlAXVF3f2ekaAD34+kEcbmexUPW8?=
 =?us-ascii?Q?zaiGAIGITDTwQ6dpJWxWCQUqwThH6ruNvytDwngvlQlM1oSI4udfrM2azfk1?=
 =?us-ascii?Q?ARtQnYuIygedIKst35mH9rH6od9SXnJRiTZ4qfmzb3mfZX+Sdu4rbAXAMHj8?=
 =?us-ascii?Q?v6PNubMsjUwFQiAJpIGaZ0M/pFZ1e8+/VHllhpa9SCfUsYyYyOI5mIhY8AOq?=
 =?us-ascii?Q?XgES5+uzbi1tygQOd+j4Bu9VR9AhqdwQkgYXQHegvzSR3n4ZsU+Y/ZGIc4Aq?=
 =?us-ascii?Q?Gmorotvden8t0HOHsX2oZpBwaUgVZl39wM4sflq2e4g9AZYwS6tFxI/IOwkj?=
 =?us-ascii?Q?eQKuZoHf4Sx79fCErYN018M/2Skb9MgAOu7zn1ny+yt0NC9DRKWwU9PSqzR7?=
 =?us-ascii?Q?fUrJPCTP8qqoheogrf7MFfHydKvrnpnM8+xK3go5uiqwH4V4aeN4CaCWYxoG?=
 =?us-ascii?Q?liJGA95Ly1uAZFwSq7qgN1GBzT07q8c/jtuh2MC46PFhg6i/dU2jAS9ZpeXD?=
 =?us-ascii?Q?GwNHUkyilrCDtMVzaOWadDfRc3nwJbdIJD2RWGZpAnzaP0UeVhliwZHuKV6o?=
 =?us-ascii?Q?AC9jnMaFYfEy82dXaj0ytPaCk70dsbDSiK3jReXbNT3z62YwRMc5bAJv3cCO?=
 =?us-ascii?Q?rp4EnE6tEcCBLdakhUbEFJVTaUvzNGqk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OXX2cGfDNZuxIZab+H6TMe6wEq2UUXLeyOc7+LlAJ4WoRZyx90OhOv5d+obu?=
 =?us-ascii?Q?d0cQT5VFKkgWm9DBatP3Cy40Vq1xbiGAb5dF53v55tr8oMxjvd8BCrkC7TAG?=
 =?us-ascii?Q?kWNfISaKgP2hhBhfSLax6LoEbfN5/+cZ8Fzb4hD1DMIZHUD3Pap9Z1F0CVsu?=
 =?us-ascii?Q?NknhPjRJ34MybT09CzOspXaxwjFLW26+y/k0MAL5pCbak9zOn/Rnl3MblF/m?=
 =?us-ascii?Q?ba2eDsRmeX1peLS02WJM5ieVdu4jv0AhX8zwzSXJfvL3scq1iu9kjDnHSd20?=
 =?us-ascii?Q?OVDEh5ybuzNdJlhyxwbkcfk5r53x/RHt+KmYMeUAOAUGpjb0KbSBAVsyd8Ya?=
 =?us-ascii?Q?kRUYR0i7BnKEV1PNQuoiR19tLzVM++HKQH0PGFZZq9Sy8BAxlibE+w8o4Orf?=
 =?us-ascii?Q?QfCcLDMs2HuBIdwpQcPrP5jSEuMFeL2qL++XOIDoSn8o39Zp05dMlnWoRspd?=
 =?us-ascii?Q?pNiPcxPksHtrOqzaWWYEKUlB5VMh3AlfvfQSVJ40rfJWhtmLO4kNuBDH9cQ9?=
 =?us-ascii?Q?RCrIREuZPiCYuw5otSNPHkQHRNngq/72oeJgo/260hd07raj1J1mZYKgCyI/?=
 =?us-ascii?Q?tD9ODRU9H6cHer0d89FqZz27QjwHybQRM4PWxMbVmUMnJJFl+/jbsQBBTX8Z?=
 =?us-ascii?Q?WJk0w9stod1VHkaxVolZ8SQJb5YZqaroZUN4RKbjCWyEBORONFMW7ih0at2c?=
 =?us-ascii?Q?9ZkGC+BIgjiHn/a4jMNacycMsMNM69rfYqghxG3cPITqfl/ot4qUDBdbxWVI?=
 =?us-ascii?Q?kdwlbRpkb0lSQ0FnGWlAbbaQmKCAlp+T2L7gA3XtKh9X6KWzPD0YqGrTun1X?=
 =?us-ascii?Q?144M+y7zn0J31jZykInuy+zTYP2HLQsiczrGZoWDOYNJXz69R7KiCKzjBCRf?=
 =?us-ascii?Q?JQQvRd0Lnf8rYZPnfhfU4VWZuJeADzy1ZYrrORbCzo6jtuG5Wr1kID7TKRWW?=
 =?us-ascii?Q?vZDwVha5KZaX1EjN7pXH3J5+QPVKSr46Z/mX9O+91fqyoR94S36v02P6yZge?=
 =?us-ascii?Q?o5LWX1k/qw1OEAX0yWynHjGn42Q3kImxSRvPyp3V8ulT0exspGrG1e5KUuR4?=
 =?us-ascii?Q?z5ariSioQpHEnKlU+DBBxd1tAdl6N9VXhBXxnsMruQ1COg1mMWfOVCXev0xI?=
 =?us-ascii?Q?UqjnDwpXwKM6vcZWmOKKLA5Vb35nSbaXB+t/AgApSG+Xetks1KKH6v79mTtS?=
 =?us-ascii?Q?EPh28+/DWBzzFp/fs5g+Xl7wLDn5fkMS5oHa3VwerYzGwPZQl6WcbE8mLj8x?=
 =?us-ascii?Q?PdKyR1+gMICb8tDW0oYhbGx95HUH1iPUOXNaZQ8iqi1b5ISq3Ak+E5emZrPo?=
 =?us-ascii?Q?Bpm8b9Ku95jVRMxEFcM46oS4NxOePc5pyQ6avHn8tMpsyzo2Elk2bltFbg8+?=
 =?us-ascii?Q?rmwxnjv4Tq9nUL2n7E4byycnOY/Crftmanj+J0O5cowDp989HsOG+pMsSWMv?=
 =?us-ascii?Q?8n+czvkEKthQJAdBCW1xZVKcbwyH3/6mpVLaY0Xf6OgXK5pHTJbkH4ch1Rwb?=
 =?us-ascii?Q?HI1X8ADu1+FgPrO9h9JUpkCxH5RkX7aYPqYAdjY6vcAWJRhKN1o0ceIR3vN0?=
 =?us-ascii?Q?cp+gSU3uOwhMm5u5z7NUAP46/7mPu3M3f2i87i0M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2d35e0-e37d-45a3-b898-08de16d13690
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:54:55.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4OnNfjKKox6Az8cOTq+A8cZrll6Hw0Aw98oOo6kuc5w8K1FRBcw4jLIqBN8cOs90BHRmUSFUFh49QCcC8eeBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405

On Tue, Oct 28, 2025 at 06:04:32PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 10:22:29 +0200 Ido Schimmel wrote:
> > This patchset extends certain ICMP error messages (e.g., "Time
> > Exceeded") with incoming interface information in accordance with RFC
> > 5837 [1]. This is required for more meaningful traceroute results in
> > unnumbered networks. Like other ICMP settings, the feature is controlled
> > via a per-{netns, address family} sysctl. The interface and the
> > implementation are designed to support more ICMP extensions.
> 
> Is there supposed to be any relation between the ICMP message attrs 
> and what's provided via IOAM? For interface ID in IOAM we have
> the ioam6_id attr instead of ifindex.

RFC 5837 precedes IOAM and I don't see any references from IOAM to RFC
5837. RFC 5837 is pretty clear about the interface index that should be
provided:

"The ifIndex of the interface of interest MAY be included. This is the
32-bit ifIndex assigned to the interface by the device as specified by
the Interfaces Group MIB [RFC2863]".

> Would it make sense to add some info about relation to IOAM to the
> commit msg (or even docs?). Or is it obvious to folks more familiar
> with IP RFCs than I am?

I'm pretty sure that when people are told that the message contains "the
32-bit ifIndex" they don't think about "the wide IOAM id of this
interface".

