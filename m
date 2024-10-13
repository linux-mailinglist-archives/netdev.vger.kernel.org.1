Return-Path: <netdev+bounces-134931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89099B96C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E74A1F2170C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5BB1428E7;
	Sun, 13 Oct 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="efy60oHo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01DA2AF1E;
	Sun, 13 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728823398; cv=fail; b=mphFAIkRWtNZi4IUCZWAFvpCMXfqtQmTPZ3qQOVV/w50WEaB0GlHGGtXLopyRsXx3y4hLIxNtJ1O0/KduZOIkPEXgCmvkTaNJ94yf7y9DJ9mZfdTDNKqgWyPlXl+GGIDXa4K82P+osz04Sxp+fiABjIXmoxAVuHY/WpGtmG8CHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728823398; c=relaxed/simple;
	bh=eHc6YYp7bLd30632RyMf7nNA+YMeOKOSTQQ4SCJJcZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cahT2rWJSakx+PAnPsoH7f9o0lwxIdDXSiZXhfoYCXgK4iUHkX5LwEfMGQlPDR9BoW0Fgj+PL/aD+YyKqN0zIltDNCTBS26STFJPIpiqERg2XCFwEU0oPY1Y87YH6OPDpL3TNVTGoRkdboqBp0L45Vvij9TOvFBeSVCIf/1rW8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=efy60oHo; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJvEhaXflr2TC3xOCZs/vyHQ63ZHOjQnKxjN8ApQRtSl9VYc5nUiQULy7wuZuVNVESojXcJvoA6iI1U28dDONCE9Glt1JdYBh7EGRfo7lF88UW+DubTOvFO+GIvlbELvkiTJKtzswPVDCm9o4AT8xG2aBgACpAbz0jiZ/BQpxyLJq3oZz+mtn6bICYULQnfRdhGtA5tljW0Zf12gyZIV3bRKsW0A7d0xYnOON5lJAogMr8QbqUCNwWXzY7X6/XcM66q59KOM86FETbCx3rpLisgNgpEHL0wdB2jasYa78RltcCqTocykamQU/EWH79wqlM6sZGawljao3qEcspcWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zScLQESylFPgT2RNxAwSeLP7/XpcN7BxzTJa7NKTIg=;
 b=Onwt7zeDbZgLK7vfD8fp7yfFJUSeyaAAh9sF1sZuzhOseFNZIleCX9dtObHlsSmLTSQ86twub8Rlr7aMNWWwjMoCQCFGXW0E78p4e+WQ/QVFZ7YuELAecmqbAO/LVJ0wW2WZeqbi5e0LfU/V6wkVb6PsxHZblySXLOkLBowPKoBPAq/fMHfPteIDl59vdteTSanrbWEw0NQMD3pcEDzHqEhET8Uq3NH8lD6y7g69CRncffVQJb3UeIm0G0QPrIfDSY64z7FrmP927j2VLurwbm5oQcJqp4iUsZT9TLVvnKL5jdLTvGrShGmfwwY8BgrmHgtONs8gMLciXXb010vjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zScLQESylFPgT2RNxAwSeLP7/XpcN7BxzTJa7NKTIg=;
 b=efy60oHo0p3c1KkQeau5naA7gmBMA4JnletfHTPZgCe90g4lU8ixuj6R4kzH4OF6g+s8BUldSUUu6flQefo5VVsaQ8k9V0FvYrqLHzoYDesWVsojnF2B0IQ6lCFJdn/F1Jmo1i6tHRa7eofE3O14scM2HwfCwyyo6qZBhFfDAmYD3YbfFNvG2gwUJv7J2VBhGsh+a97M6U9wm1rRzh+05iSUlXccZbMkZ8vapewq3BXEzeuaZYHzJ387Vk1CEimJQp8quUc8f1pbwio9PlrKwag3M09yq3axk72RIJY3PGz4/gozpOAlMMHAS/dc3ESUgGkHuQmu/VbH2Ni5DEyP+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Sun, 13 Oct
 2024 12:43:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 12:43:12 +0000
Date: Sun, 13 Oct 2024 15:43:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <ZwvAVvGFju94UmxN@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-9-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-9-dongml2@chinatelecom.cn>
X-ClientProxiedBy: LO4P123CA0225.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ac23b2-433b-4b58-fe09-08dceb8499bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JuYrFb2BHNswBjzktXY3/C9UcVF1sStqyMuhr3npLMjANvYdwWHMt4rUNT42?=
 =?us-ascii?Q?OT/2xNZ8RmLK4o97TuSGqS3ZK9FmZJW6cf5a+ULUfk2QqTVuiyTOCCCKIapw?=
 =?us-ascii?Q?q4pkVoIfVNH05qDPzQMlPW70hkIT2oNrrPt26VM+SsMVfXKFqIXlgagXZNwG?=
 =?us-ascii?Q?7EXxJQSZq5t6erREp2zdW1OnM34Nz4jh4hr+TOSGr2u2RTb7LRUEphNaYqaW?=
 =?us-ascii?Q?0RNmWKo7Pa2WkCoabCT5qW0NBsxKSzgsiG5STX+LtejzlH4eMdtBgukydIDt?=
 =?us-ascii?Q?Z5KDDF5pFM6n/e5qthDhkms3/eFSoD+0abl3O4C5uDQ3bGxu6boVGOmOZpX3?=
 =?us-ascii?Q?s5El7YvsV9V3r3Y/5U1vp7EFASQ+K/YfyotHYgLhJjU8YFINLaEbG8HgBNxw?=
 =?us-ascii?Q?rPt7e7Ll2MBL5OcT5v5Y0Fnen5w04mu2eRflY/3yzTp7BpDSb1grUXUVRJF9?=
 =?us-ascii?Q?4mQf6fEVD4ZEsLVlniPcWvJaJrfZvR79GdQvRwKl7tMcsfLUgDI4oJQBjio3?=
 =?us-ascii?Q?QZaG65a/exm7kKL18sv8Yw19vWFHCPd/+7kJTDjESpQM8ga97pjxVLNKA8YD?=
 =?us-ascii?Q?CyA/fXHNXLw7nJTPmASYLHmYjVeoDgliuCok4fbMOXNRjeSMTotQHreF6lcP?=
 =?us-ascii?Q?1ZtYzH1AByRxPVxJebsClOEIODLi6qEgCJpDa7U7YzoxNwHbA/MZVLIRbkfe?=
 =?us-ascii?Q?VuzSGwWbe8hrpGrBVnUwlhcOhckiuEezhG1D1NAcrfSzR5O94y7Epib8Bujr?=
 =?us-ascii?Q?DwKXsMBinSeOJsKp5x+MLt51ttYhjB7BPwyGHoofHwjU1yV7bBm/VplsCzY/?=
 =?us-ascii?Q?fpsNHY18fr9iNclEDtamN8csI+ytG4ZUpbsCUBmu8iIhUIzbTr2XDrVXpI78?=
 =?us-ascii?Q?ERVfRfKH5OZXLTGikBkdR3bHVFpPDhpzX+NyHLY5KhUaVwH5sOlwVysxknNa?=
 =?us-ascii?Q?9aRMrsGkMMBNF3jOz7Ly06ruGl+MwadkziLwu0cYsag7J43G5B9Z9OaIHgpg?=
 =?us-ascii?Q?NWCChZig4WJUL2XOQHqFstMVbKUie8fZq4bFc6wmvgJn1lzTiBvJHryAtuBr?=
 =?us-ascii?Q?G2sKjttYn2HnIhu03KR9OMP0+rMwmwlUqJuGmLw1DjXQdjkRGR1SOI8aymOf?=
 =?us-ascii?Q?tLAbqX8eFEHZyDLY56pUU029AcnIFxwAywFairrJAJo7wqP4XOPWoTvCTvef?=
 =?us-ascii?Q?MX1CDj3wBKJkXjTYKVHjajBXXCVD82hq9nd2c/gsLUj+ByqOiwIzpa9F5N4k?=
 =?us-ascii?Q?Je4sZ4j6OGKQ7GySqF1m8qFLKXEovL5rBE5XSBBtfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V5UWUo8qtnUxerhWpXOXvhnS8T1d1zoypZIb50+IGSbeQk8mdIk5znQKWCUp?=
 =?us-ascii?Q?D7n9Evfvoe3kjw1KiTwidJxp5JuDp6h7LT04ASpj1qKby+9G4jeLRDwXpvVT?=
 =?us-ascii?Q?7HXVY91Tr52lRTCLFRwuJSOQ/dG32AEmr21OfIM7TwEhN4C6PzcMjy2n94D3?=
 =?us-ascii?Q?ehLZ9FlYbgqikvRWKZmG2bXNQDsIXTcOyzaYD5T/magd5ZGRfm1eJG3dCBzd?=
 =?us-ascii?Q?0VUEeUlL+sthhuosfEK4h62cn5aoG/Vfb3a3SAWuVtJSgpiMZ5UhWOw7Ow0Y?=
 =?us-ascii?Q?rg+6rxhbHbXI5UB58urMSu8SITzB5HTf44SQ+5C6zrUcipAT5IzsN9o1pJtl?=
 =?us-ascii?Q?CB2w2YnQBgUWg47m2g6jrP+QlP44bMSDntkco03gJq35EYJQ2YlHQc7dk/jz?=
 =?us-ascii?Q?2Gz0jruv6epKoJCuhzuquBKdH+i7x9hpCd/P34fFT8CCRbjT+wXNpkjSd7KB?=
 =?us-ascii?Q?Aw1j3d2w3elFGeQgfZSaZbIq6+9JX9nymeW3dpAc5uOpzM6r0v7VhNbCsGP1?=
 =?us-ascii?Q?J5uFiNuA/5+TS34x0fjGy1QfJTwGZLC0aSZ+NcG48s2FJztiFR/cHYAv18Sg?=
 =?us-ascii?Q?t0Nt/mz5P9Kyth3FdlnJVCvJcHTfd33aKpVEurM8GFIYQNBXDtil9vnY5jsj?=
 =?us-ascii?Q?WtfGBzM3SNdvxIkck1iLh5KjpZK3fVzybnb/EbqOG6IaCE9EB7bf13GTzd4t?=
 =?us-ascii?Q?ukrUUbzIJ9fCFuRVDD0t586PPjvPuvINfwnIEaZaf7S/wqlRdenDX7m7cIBl?=
 =?us-ascii?Q?neS1ZnQc58BXtKK3hRn3jlB/A9mSwjlvFTnNVpr0VmZkWX4nzj6mJR12wQMC?=
 =?us-ascii?Q?X4oPKTFsNPvUyjomExg6yrDDZJCz50SXNiEwrf4fK/8EFp/6Cw9/W5PfDUgY?=
 =?us-ascii?Q?6IF0dZeBcTJrMtoq3rzAOqxmV0nMKqsMHeUsVbvBlXfdT052sckmsywBPjlg?=
 =?us-ascii?Q?zYIHCVahgGQLJqCmM9R3DtxKZ3ikgR2trSPVhuUesOG7jgxsk3XdvQWzgPmo?=
 =?us-ascii?Q?BvU5q2A/6T2q8Sx4+llOeM943JnqCyVCmVA1sM58svBWQ5RN+37PQ3EjH3yc?=
 =?us-ascii?Q?Z7Qd2BtC+1TnFtMwMOAFIEinJUmUfGj3Zwe2mUYEPTBTlGdwsBVf1BCKr39J?=
 =?us-ascii?Q?BnuPj8ggFMwFt8BvGmDQlsjlXfUgIs1aB7p/qXodm05jXpRd3G8JnKEaYkhA?=
 =?us-ascii?Q?OhIpXAPj3g9mojHEPk4qponRFmGg1DzQH254O6EMYQmLDCxYreJZWA4G5l3+?=
 =?us-ascii?Q?iHw2jP6093/geWiG3h45cPvnK3/olU7fM1XIT9LT4RAP8L3ASACDl2/aQ6c5?=
 =?us-ascii?Q?66g2fpUZxa6NlXtNJ6ddTK4tgdGIcehAqJ8WNwAM4pftv3t1S4On3lUpMVgT?=
 =?us-ascii?Q?+eVRS+uHfJIw/HNu3U/S9RGOZRkbOjgwNkTLkJbG5ZnTyMbdeYgEtN22OMqE?=
 =?us-ascii?Q?K6FA4POBlcBTqP484hU1HC6ncOOiWVg+U6wAjIAPbxzxgWKjBjqDvyVN24VT?=
 =?us-ascii?Q?ndVfFVbofVaBYVf3drSpECJdrtth3XSFlO7SlgGoank7Bg6oKSa0j7RdYgMg?=
 =?us-ascii?Q?LnduUeEdGhUzSi+o0CdwnT3zB9RwTklkT8j+eHCn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ac23b2-433b-4b58-fe09-08dceb8499bf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 12:43:12.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u5vDM/WSJ0IAtHelHkkY98ln14oi9dZBqPmuGtyKzJObNc0WCkXNoyyoOTr2dN9+FRZah+L23dXqUMZgayDQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983

On Wed, Oct 09, 2024 at 10:28:26AM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> new skb drop reasons are introduced for vxlan:
> 
> /* no remote found for xmit */
> SKB_DROP_REASON_VXLAN_NO_REMOTE
> /* packet without necessary metadata reached a device which is
>  * in "external" mode
>  */
> SKB_DROP_REASON_TUNNEL_TXINFO
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

The first reason might be useful for the bridge driver as well when
there are no ports to forward the packet to (because of egress filtering
for example), but we can make it more generic if / when the bridge
driver is annotated.

