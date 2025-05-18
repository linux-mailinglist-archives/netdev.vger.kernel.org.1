Return-Path: <netdev+bounces-191329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3DABAE5F
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 08:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075BA16766F
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 06:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414DF1C84B8;
	Sun, 18 May 2025 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+J5yS/f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C704B1E6D
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550840; cv=fail; b=BVqotDHnE726YRSATQfN8ThwmGnxqZ27wVhh52EaQy5kH8DmJpHzWBfBkJ5xi0OxzWgv7iS87IE3T6Md5r7BNKABnYx7nX32+LZeALzP+IHgGQNw0LjSW1zCv37DeENv7QhDxnKlaxArDtpvB5CmIqHmVlRJHrJLULNQ8knWhMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550840; c=relaxed/simple;
	bh=W82OdZEpdXC1SuhxF0q7iq/xH++ocVYU5gVgzSl8bkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qm0C5XlBz+Lpbo3hzjUt3d8pfrlyhokXeQqcQ+K/yHbuA/6dfmAgUWBnTmqtnJEWEmbu17jDcErnaLQr4S7QKDI/N5UQldIi4YNDo1vpxsLAH2orNKOCU9gQYa9FYQBkCECa7/NlKUvqCLtq+eKPcEBSrYsVkYOx/vdbwxx5x8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+J5yS/f; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3Br21Gt33XsluBsYGf1fGWGCYS0Gb/dW46X8R2DLaYX9zPskEnD5KtZG/7TD6xVQkSiRqSw20ysQw5kISk4Dk8vhDW+74f0EWfuJeVqqucIKi3OcukPyf/QTmx+mJNtBDwxUC4uUHjdXIUsQJgOra79nj1RXloSG62BwMchzTvjkC85WlpFlVCCQmWGqzrc074KxOuLg7wVXW3fxdkOEHHBnLxc99E4hIk1JaqWTAZiW2PrhjDKPOziOA4VVgTY6YLwOcr6zNP7Y8ymAaGJCKGS/WjhNBX51deoN6kTrl3cXk6aGJptjrkH0/70gJ95Tfi+MOgETLl63GBeIAAFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV6uBylF1iOF674qIKWZ9pWl04C8szq6dWRj5hV+Ovg=;
 b=IEyy9edX7tJn8Qe3eHU+XHNd7TnaEsHFIs328y6I0AZZDSrYecCirUBHk+INQEYfemFRtcnehYeTTb2TSkeojM2kP7ZqwxB30ktYJXyJTxklyzlvPHw0GmtXFg/OlfSIIRNcsKKINAMtKBPa1oqhN2MLcdmkzjhFxemXhvysGFimJHIqmPMOIWG97vtpC2ZDn7pbaZaFBU2yA2iQqMg1EEtMwFzZg+WcovnYSnTZ/XQuMZqlnIQMkqo840hO6wXzgbaj1yhbVEDRihUjaOmCfSvY5HSWg2iD9voWxWINqsmPMRdACeVCgryhsoEEmZHgHhqBirik9FeAiM+Yxu1G/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV6uBylF1iOF674qIKWZ9pWl04C8szq6dWRj5hV+Ovg=;
 b=L+J5yS/f0L86XMdKjOvKMpefThPnLvf9U5sMXcj6oebAAXuZa7pBNY+KF3yeRoEtIGGC26w84ELIZSwmG1szzKTDbxyNuiX+R7xh1kU4f3nwp2rh5F4C9J2dU43Le2Gfejzi2YJBK5WGx5xbj7sS8dvPWB5CsBo+PsKA899QCh+ghKwUGpShs2nOd2isrxZAtM8LcjhS30a3oQW2yCk//we2aeUiYs5ZR7sbm4F9FViiPHOdqH0wGByuX7DpSngQPoCcZd28amBEGmnbTMSMMhEa7mahQXS69WKSghRfbtePiO4OcB0UqmEFteCofrBhXLhyVltHnwIFTOs6kNSJwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 06:47:15 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8722.027; Sun, 18 May 2025
 06:47:14 +0000
Date: Sun, 18 May 2025 09:47:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	razor@blackwall.org, venkat.x.venkatsubra@oracle.com,
	horms@kernel.org, fw@strlen.de
Subject: Re: [PATCH net] bridge: netfilter: Fix forwarding of fragmented
 packets
Message-ID: <aCmCaMAwONiyTwR0@shredder>
References: <20250515084848.727706-1-idosch@nvidia.com>
 <aCfQfq_FEwa98RCw@calendula>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCfQfq_FEwa98RCw@calendula>
X-ClientProxiedBy: VI1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:803:14::25) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b548c3-2e76-4cc9-43bc-08dd95d7d314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLQzVEIkxC5L/cnm4YEuGeYZSmP4AQtLtg7xfH9IVTnA12Ayn8alisF/MwRn?=
 =?us-ascii?Q?oL3YmL+e8bqf3929pDMbKkMsgeINMxV+W/U1Vsqyb9ulmf6qYhasZyefHbVv?=
 =?us-ascii?Q?S0+9Ujb0zAxNrSKOaBCNw45xa4QH4pHMlEw2V33PpnlsJ+QvP9htIsk7gBAb?=
 =?us-ascii?Q?ixhWeTmhah7q6fUMl3TFL8iV6VIzT6IwxhafGusEJ5fMQSzl+FYvDN5MLdYK?=
 =?us-ascii?Q?N2v/yoPB0gmWZH03GO7sP2XliBYaVdZ1zmSW0vkK4GtLPOYSQlThaqm0i7kK?=
 =?us-ascii?Q?pL7cYhlwMeZFRri/d703EMSWm3O70haWny5akvj5wcLUPDQotZpTcUeX1Tz+?=
 =?us-ascii?Q?TfFwkpGiiUYgF8JPdcQBowev50A8nWmIG7zE+MHSJqRmlaoWiIjVf5gfn6+G?=
 =?us-ascii?Q?2wWz+AQFvwD75z293XLPM5HdPy3Y2OUbZU7BWkc0bHKfy2zfZ7Pq8ghmQSQR?=
 =?us-ascii?Q?zRslus76MrC0114Cn6Aa5JxJjZNdAGY0OAKuil3rLJZPlALE/q/Dlo3Slhf9?=
 =?us-ascii?Q?ge0gGsLX75BVe3D+Zmm2ghS1GadTxjVd0/rEpA7Ry45hogWueUEeBu0PXoOk?=
 =?us-ascii?Q?SmpXbqJmLHVX4jH1EaQMJMd5gX/96ZBXo47nwPVryMjBMALOVztvVP6Mn/wl?=
 =?us-ascii?Q?R6VOcl34zfSipt+KNmZ20kH92/NVBS30Bc3JDu9Hn1HgTkcPzgz2zSqMiA+R?=
 =?us-ascii?Q?P7XYsU7EchLyWRJgW7u60f1Yn6F0WDeTDC6Pj5/Trr610oWV9tKeRrJ9wgZM?=
 =?us-ascii?Q?eCDMstbby9NXvrmbE/67MQDyS3qvUb6vAVPe0QxGncn6zq98YJOO62hpGSU7?=
 =?us-ascii?Q?Madzl+xpIeTvX3rd3j05GAPYFg32Sv+Q7cmBN2dKo3eMNHfmK97MRg/9bjLl?=
 =?us-ascii?Q?UgIbIIZtpST4rwDLQWoujoBJxJfldwGt6aFBEPw1yJz4wMcGQTC020aadk9f?=
 =?us-ascii?Q?KN2u+rOznnjYnafuMJyfRZVRFyg6Zi4PaMmaQiYzsdd7nffnUukmxLirR0j3?=
 =?us-ascii?Q?rZXgvEPr2dj9N7dfhZM+aYXsZ+/39UW8NtWOBpym13bv0X1ae0sC1ZoC1POe?=
 =?us-ascii?Q?arRuhcyFY1mVO+hOjwIV7KEXgw6MKuOtAV4NQhbwfdDnj1H4a/6G35C6bo9Q?=
 =?us-ascii?Q?mwPgzzps2JI2L9X+UPyqKwT0sazu4GBCvidAvnA1Y2mfmfHbN8aJ5RCxZ3+w?=
 =?us-ascii?Q?98LegaUpUcdRxqZeBWZiQdtdWSs0g4VfEP/cTkb4aKW1DHcNfigR/75Ozl1c?=
 =?us-ascii?Q?hiIh9iU95IXg8gSAJ0oCx1gOVR2K4TzzuMMyAh1oW09Wkg8cUG8BXiPbNi1L?=
 =?us-ascii?Q?Nv+VcbACM9n0iFAdSpbJKbb51VZjDsH3C/VYY+rwQ6kigqkUxFhamFwm6o7+?=
 =?us-ascii?Q?NfoODL8Pr4A2wuXVpTCMGtdVJvv0PtMR8LFJpEMgOFycN+mFavSjINX+0hFm?=
 =?us-ascii?Q?xglRKkXpnZc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuUcy2bM3Jbpc4DYDiZCaBr+3KbFkyQhfQk5fA1opAOYNIt02JS1CtwbJtmv?=
 =?us-ascii?Q?d/swKOuPgtp37IjcN+lx0s0+SQwwsz0IVyhL6R/zmJIE+4GWtByvBzMXjLVA?=
 =?us-ascii?Q?SDMLPPmvGWVeBRE/XzG3nBQzhyyEbP6Ncohf4SLMxsMvlPVjmj30MohwbcoY?=
 =?us-ascii?Q?Buy+bNInvYsITihyaBWgxHXeMvTBfjLNYkvPvhGP4JL2ijsBmYbs7Txfunbl?=
 =?us-ascii?Q?EDwbKYG6179x2goajHZBRcqBcTXEGG4G1oDUOy58FlJhfYTmS1eT6zIdqxvb?=
 =?us-ascii?Q?LnZUOjMXUBK0rDOYrtOoLzP2Smi7bGVZWd/f+SOCBWkz9W+eD8E3u8TxTFWY?=
 =?us-ascii?Q?0x43T3cw9NdNq8NTznRrorPElkzVg35hZbZUiGh2KRWi86YafNWtC2rnZL6U?=
 =?us-ascii?Q?Vgkvu3J8kIrc2TSHIoKAURW+wlseNLI+9VzP8v7dxnbw9NJYcvMh16TlYyj6?=
 =?us-ascii?Q?NU99C8ZZJWUOpCAKdQncBtmZG8S/pN9eCV/ImpbW/lpyhUiK7bS4fQEwHaJS?=
 =?us-ascii?Q?Svp/OUfRn4IcTXmK6vSLlzYvHm9aWaEp0Z+hzjxJb8iwiO7207z2wGKTGo72?=
 =?us-ascii?Q?rkzGKE+Zlp4APHhyQNW8TPjkDp+0/8pQ6TTtj7VaKNziMgCaaqjplfh7GGtQ?=
 =?us-ascii?Q?cpvSDT3ZGT7lBLazsIGd36Hdn4NQw9OKsV3IScvCKAoI4EVQ1qP4UCv+g1xB?=
 =?us-ascii?Q?CL9gWlZ555L0FW/OtNcTSuEnGtmeW+PFp6f8677LjquFPLQ+iQZvQCBtasCB?=
 =?us-ascii?Q?28lRV1lJdjgFEHDhT23vADh46SCVvF9Z9FkB2Ez/boVNGD05FSPjHb9BdfVn?=
 =?us-ascii?Q?0+feU8NJpwy4U4Vuz2UEKSpqjldkU2T3A4NbDfFtbl0GgXzQ+F/KgKlMQWgf?=
 =?us-ascii?Q?cVprtouqtZ543r0cgJ+c5iabvnFwRNwu0mbPLGTK5enEsxzu8kBy9ujy3pj+?=
 =?us-ascii?Q?mPKiU9p7h7qHN/djqvF+UGTOYugFR6gBhTndJQoSnpGiixRVPOR79vTi2vic?=
 =?us-ascii?Q?HUHf5fGjQy0XEOaYDVx/vJzTzcNLZ9pzcXHfXaEbBMXs44RDRtjxaXk02xd5?=
 =?us-ascii?Q?FuSo2B7MQOc+scB8GFfC9Awa70g8CCH/7woMfIsvQ9lXjNBnZAXg7Vj040WB?=
 =?us-ascii?Q?7mWPea0B4K6AmH9PvKcMAMDAm/TIlmINxWqCoIf4Vdc7HbtkaKVR+B+XGshZ?=
 =?us-ascii?Q?pR/56lZOyiG4ZZ6MpmUPDWuuClqjhb4KcWGJ1wUZ/TERjHX35CH8qkhNkrVQ?=
 =?us-ascii?Q?8TjrBqArzd2ax0haIMryldOfpHWAiQaB5VjIAjbZplN4FONmqUaarR3umWv6?=
 =?us-ascii?Q?ZJ6e7DqV5yKOZzy6eq5ajwlccyGyhSlfdw9oASB1Q82pjp9wgpX9d1dWI5CJ?=
 =?us-ascii?Q?oarkX7MBcdldq3B3A6k9EI2k8JSmqg4oDXnfKpvDry/bajxWw3tQgdSw8xmA?=
 =?us-ascii?Q?UrmqDjHxUg7HWZLSC5ixMaKHwcK9ksQvQVbdRCYo6wSjntsb7MRp6ROtKk8s?=
 =?us-ascii?Q?1CmedSSHtRLJ87KQAUWQ5UxGLSLX8Rj4ay7UhX7NQGwqOz8hIDxlfxoWAizx?=
 =?us-ascii?Q?QNvb3OOz/Xr/eiYNgF9MgwhbcUM/lj1Pdd/qj6mJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b548c3-2e76-4cc9-43bc-08dd95d7d314
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 06:47:14.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJBbXtZahTtnxXdWLq6dL8VOWsIajm1coR0iBaGxRNgaT615Q+hP7BvtdzjWYNKwhaFwti8sHWvZVtmarAyOXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

On Sat, May 17, 2025 at 01:55:42AM +0200, Pablo Neira Ayuso wrote:
> On Thu, May 15, 2025 at 11:48:48AM +0300, Ido Schimmel wrote:
> [...]
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index d5b3c5936a79..4715a8d6dc32 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -505,6 +505,7 @@ struct net_bridge {
> >  		struct rtable		fake_rtable;
> >  		struct rt6_info		fake_rt6_info;
> >  	};
> 
> This is missing #ifdef to restrict it to bridge netfilter.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/bridge/br_private.h#n503

It's already restricted to bridge netfilter...

