Return-Path: <netdev+bounces-231669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5311ABFC40E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FB71891410
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A5F33F8DE;
	Wed, 22 Oct 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8W8kxii"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB69460
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140597; cv=fail; b=JojSx2f6lWozIr6eRNd3sF8C7igzKshn+eA3H77ncdwg8So9RdbWlm455m0jT2VrklNwAsQcWPVmGI9EFO0r3n70EiO6kcr/8foAHEygK7sFdAeMzzTj3g3f3Wpov7l+KzpTa1YhgzZlDOEC7Svh75aZRuTT2Pw82QvLB0wcjgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140597; c=relaxed/simple;
	bh=AQardGZe782QJiC7gmkPVDpAPRyrqbipmmrEfHeMMUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMb7CMvzccpWcrhFB2eryeQ7JqW37byn+uZqeFOl6MG17Ervok2yX1Y5MSC5FYMQGkSLoceiI0roG5J1ES6/khhfPtSyu57DiBiJr6Bs5ZuG3l6f0NsJmIkBvxbnq/q86UiFcYIGx1Nb0hTmYfOEuytnKX6hzadg0pX2oSKI+pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8W8kxii reason="signature verification failed"; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OV3MFk15rZwa9JJILjkqV755gjXTnkKCdd3dLacouzxznFYyCSWhFesGqPGvKDFwI6DN+TkfNSwof5wNImx3VqyY2Mese9R8HXe/lTWMJW/5oAUpQZSaQGHCT5Op4kQ4JCI4Hhg4M1TzLk/VvSQlWsg3arhyt77zSq2G5p5z6ExSLPGKMmrVLg0chzTMGA44QccLngaL8MEr5RDhOpNOPc9/gTHcgpuoorfwoWpiD3C9pSjMWJTPBVSKXJ52klIqVsTsfx0xvhTYwncw/VcqG+64ukKxWLudXnYjdAo2XgGA397tIWwwIXaM9eSzB5us6LhddwrVyeXmFKFmFmNg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQIRuFcVev/gW3o3hy67YsvrVgAEblHuRrepbse1Q4A=;
 b=JG5WrLKbEMb4are0Q/xbFQnQoBBp8dSjzoMwZtyUF9jAM0BIvewQWx3gqBhbfK8qvjYCbOSiBsnvcG8Q1tCX7n/qZwCOFbC87EuRyVyxvBJwvs85Klh0jpRzoBzuXzCb3GlNNiKTINZb3ceCCFHBeSxC/2NjWxJyW3cIv8y6x2skHYjsxkX2uU9srGv8fAs2ngs/VMJb57CYCchDrxRB9gTexWyI3/Ius12rwHkNF+FtRG9Ld/1ncwt+HUy90k3XaMp1p2AMP9Ht6KRUiOMjpjdUUbb8F71Rk1RFDgADXBwLPHbqQsGjm79skJkBvPZdLoIdfaypszPlbwPR9KVZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQIRuFcVev/gW3o3hy67YsvrVgAEblHuRrepbse1Q4A=;
 b=F8W8kxiiBK5bbHUPChXERt44oNSTQwZqFAf9BKg5PwcSRN2lU0KyJZndjSaPgtpC9oWf0pRDgEJm30W44Ot8nUYoTfYJqFq6wZrztaL2AqORoTjY0DzfOIpECJVDmiW1Fo1wCtTIcpR1m+ZfkruniDu9MPt8N5LUv2gaDyz8N+Q1FCcz/dcDtHhhBrUF89Q2eu/v4v1KEN9B/Y8GhuvIIoNu29FUwI1WXgSASw6/xpXnthk37rReUwP1eDx8Cg1e8ajDbtoBUGBgjtLTKK/cjeiuZ4+2Abwl09DC5ElPk+fwlSdwLxw5fYMzuVd8BlbmFTnyPLiE4kXDeD22zwiNGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:43:11 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 13:43:11 +0000
Date: Wed, 22 Oct 2025 13:42:39 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH V7 net-next 02/11] net/mlx5: Implement cqe_compress_type
 via devlink params
Message-ID: <efj4hbhm5ek2vtvu6ssohprswedljy3d527myi3vgc6mhvntau@w6t4ewo7zuiy>
References: <20250907012953.301746-1-saeed@kernel.org>
 <20250907012953.301746-3-saeed@kernel.org>
 <ec51df17-260e-4ec9-a44a-9f0c3d3a2766@gmail.com>
 <d4ee68d6-7f57-4b24-970f-41a944a22481@gmail.com>
 <4dde7c9e-92ac-43b4-b5c8-a60c92849878@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dde7c9e-92ac-43b4-b5c8-a60c92849878@gmail.com>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: e20fd953-09ec-4043-4975-08de1170f118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?icHhS3/vPaeDU2NruWcEVofgZq7wwJHisrMYXXoYlMio4NiTiu1YJ/7557?=
 =?iso-8859-1?Q?lP9/WUAA6ljEUS5y9tt+GwcWtd63mdMfnkwvB3f7wSVNu83skNLjCZM2Jg?=
 =?iso-8859-1?Q?0Qv7rEtgCOHxPbMythQpOZbEGu82j9Cn69zkF3yKHSLI1t/nhrDeUg+vYd?=
 =?iso-8859-1?Q?221uinG01h6PUuqNafXiU3skJzmxRFgsxPV31Mo+5oYfKG4eH5RUgDkq9x?=
 =?iso-8859-1?Q?ixJOivx0ODm8ntBDErhOdhhCLsOWZ6Y64xy0jypRjdgHdyBdBK1Z1kb9YR?=
 =?iso-8859-1?Q?Wbgzr3KPuWU4utGfgfsrseSbrj+YEgK93gQigC0UD+N7cYtrjccGCKV/Gh?=
 =?iso-8859-1?Q?pGRmhHlbTAB/dIoqfHT4pwSUcVKelbkWyqDP1dDdQoMrMQuHSrHBGwudJd?=
 =?iso-8859-1?Q?luKCmyLByyf7bLoecJ2kA3nG76Ijyr3zY+n/0Ls29aJaHJ94XNDoyxuYCj?=
 =?iso-8859-1?Q?RvG2ebLl8m0nbQ2VW26gubBluis9ZB/2swRXUuhVKLF04nqfKOQG0QuoMj?=
 =?iso-8859-1?Q?+lC86bR4f88TI9hXFE5G3398IoTfCzDvVxkV4JabpRbtKU0syTW6yhllsW?=
 =?iso-8859-1?Q?C5zqHcJck13BLgaI1Yl0AFxpclkubuiGwWsQhGw1RrYGG483FxEzck+J0G?=
 =?iso-8859-1?Q?oD0basPnMPKU7LnS0pVxIPN15W/IpoE4confpxFYH4o39bxwGaUBz8OHt7?=
 =?iso-8859-1?Q?HB5NybqcDmcm+xHJv5SBT6aKZVwztEoyqXYytXyfxs7hUw8/0XTkvpomXX?=
 =?iso-8859-1?Q?rkTUji7XRANe90NayNuT05eYJIXGiBMotU36psR8roic+TGpmNVLvWZarH?=
 =?iso-8859-1?Q?uCcBZLVg3/nKAxmSLWJkmsQfZrHNPBu8A9DApYcoVXqJl5kcjqfDgkfkno?=
 =?iso-8859-1?Q?f9nSSFlFkpRS8kQJZlXG4aAuJKUTMKZfMBaJRsXdFTPsdPUPnhGSWcf7Hz?=
 =?iso-8859-1?Q?QOntJhsNjYytIwz1Mbl4iHkloD1rrUZqEi7QdpotILsQqZFCnNFYE7TOXT?=
 =?iso-8859-1?Q?ylugvDCE9QvzKUuiBR5lZZpqIHUoAIg2Jch3p0/KLjYqS0vpZkKM9w6IvG?=
 =?iso-8859-1?Q?NfBGUEu6OnWIhe1lSc3Wn6eRitOUzcya0wWzKos4/1jsZda+l99A22C+vG?=
 =?iso-8859-1?Q?+3PHRz5ReskGgfAjR/WjFQsldJyB8oUyatvTG9BsvpksPllp1IXOjQeRV5?=
 =?iso-8859-1?Q?RO8c+LZg7uoCUEI4KtgOSfZgZFxK/bM0kLMNcBJo9hEkgLkoDc2hchfUZm?=
 =?iso-8859-1?Q?BYQzDNhySA5nVRL3NDUvC3ujFXJB/3svnILzV1BK9jN1NTnNeHp4G4w6fM?=
 =?iso-8859-1?Q?S/bdzWzAETAlazfP/niQADaGnhPCvIR6d+W3JfNJYJ0HrBCUuBhnWiBn7/?=
 =?iso-8859-1?Q?S+JXeRwUNIlYd3FQiO2ejomy4yqurDgjpia8L9Gw2svGUEGNRAzUFvvd5d?=
 =?iso-8859-1?Q?PQKnM7MQsGdiSvFMBqtejHjgE/D0g4hBu8ZR4SAJ0FE/6xc1HdaRKTYgxP?=
 =?iso-8859-1?Q?ZGaPaR257YemN4IpEzKRRt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?xy1jGaDJkN5wLWV1l6cTMHYGyA2aPREtKAwrdr2qlEHdMBQ+mukBVKbZUS?=
 =?iso-8859-1?Q?Z+rTwaQ8ZcxAuBTTam7LAtiTKSTiaXwTRmEPbB0n9WSz4FXcMOnD4cRwfb?=
 =?iso-8859-1?Q?AQjVXLSTssGIon2mvR3Mf6AqOu00vK6HDGu2bzO1RCdp7Y0SMWglPzn17P?=
 =?iso-8859-1?Q?DxjpZeC79ZUQ5ejUl2KOYZFO4aGgi0qUt8j5EyXWDwtt9q/UwRMb9i3TQa?=
 =?iso-8859-1?Q?1Ka274CJLmH0WrsSjbsI3mtebedN5j0kru6y+By/y38kqigwo3SeK3+/bt?=
 =?iso-8859-1?Q?OYCDmz6Qh1p5lFpZ7OL+T8pAignFBP8KCsN5PGgsxY9g9vTLB1Fr4p/0IG?=
 =?iso-8859-1?Q?2QO+rq6BIi8YfiRDDWZoolMulVrjmOBhBFgdJXlt8oJJ19qm59wmUy3LHk?=
 =?iso-8859-1?Q?AQtdXc/JkK6oz2A9/FkvSXHf0hpa1A/PPBN3N3BQBeXnPFMjnarBL/X0Kl?=
 =?iso-8859-1?Q?LKP27b2e4BkGYAq4v7EYtHzAghDO6pme1UbHtbM12i+IZEVOyWXcCveMSt?=
 =?iso-8859-1?Q?BEgZqQGP/JjNOPbIHk0iCgufTp4TZ9k/LPDG7qxepOcA4bl9mQXsCwsUJ8?=
 =?iso-8859-1?Q?AlBm9WdDMlNuQT2l6h9vZ1lzukdKA+ur/VGuS9jyZPvP0bd1OQqsH+kBk2?=
 =?iso-8859-1?Q?venW8rNh5c6pmZibDeqFvVjNJtTi5oM3bE0y/E9Axjw9mZMAMJ+lukJv7R?=
 =?iso-8859-1?Q?5/EnFGzyLctNZXIpCUQ5dUcUqSw6QQc00fiuQK/ZF+MSg9FRnP4/mVAz9d?=
 =?iso-8859-1?Q?ZNuIqjJ64wdm0ozD7ao5EzQNSXNw5vhgg6tRldZB+mxayH4ERoDh02R5Vg?=
 =?iso-8859-1?Q?Zm+C0MG0I/HL2K3vPwn1A/p2EsfkXBr/vPaqPw+CTPUt/5gJTM3heIP7B1?=
 =?iso-8859-1?Q?MI7RhvQVE+k0AorZxUEu2EqI9YH9ab+vUHuVxjkvnJToAReVQVmJeD/u+G?=
 =?iso-8859-1?Q?+6Nouf0O1bHsB5NPrLMBoa/3r3sS6Nz2+xyBaCGFhKd3JwI8SyFagOKIwP?=
 =?iso-8859-1?Q?VIsbXmnjCjIILSldghGYdrJDKOcdUe+Ft+Zy0eV3rYdHlqaERYvPPqMT2q?=
 =?iso-8859-1?Q?8opY14IqVfqttxc09tUMKoJn85gQ4fWeEbtV+59cxAucGYuoJnLx7+o8h8?=
 =?iso-8859-1?Q?HpltMNGTQdznzxlIqIvoalbOX/j1tMZIyOkgkyZMdi2pIfeEo/8VsHmtLY?=
 =?iso-8859-1?Q?Xl68x6iiLZKTd/eayFtqyUYE+XpOlDTBDanmXh8Vs4Dpggl+qAkARI0Oor?=
 =?iso-8859-1?Q?GFHvno3mrG7GCq2jppoKfX94/UzhxlEeNSQZVeVYYK9dOT+eG1dBoNcmby?=
 =?iso-8859-1?Q?bIksOjJfy0eGFgtTOpXbA8AiIg8N9DkJHVGEd2WuJ+7CFZqd4g4KnaZrkI?=
 =?iso-8859-1?Q?Wh3juJopXFXDXLccacAJtywRYe44QlRJFCCNVOO57wiFjJ9McS8Civ6eIE?=
 =?iso-8859-1?Q?iZyKLK1lsIGX3DU4a49EIotpmCpuGbEqfkrz32m3dQ8WLEpysWatove8Ii?=
 =?iso-8859-1?Q?fzPDt+wgQJg1LagkjbrVFdQjc32YVvu0TOl7Abbes/iZxc5f0NvWy28qBC?=
 =?iso-8859-1?Q?pLh9htz7dwWevaSr/22dahEBNBspFSudC6p1Yx4U3UCrGSXoc3hfpI+ciH?=
 =?iso-8859-1?Q?tnMarE3l3jpUCAUj0eg8r01EHf8dK5gmrW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20fd953-09ec-4043-4975-08de1170f118
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:43:11.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nzm+BSPaSlzsUY+badUrY6EUqxcLAZpJ6tpl+bMxR0HtrmLYaPW94u9w43tI/VrBvdEqoJwtnvbynQoC3r9ULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

On Mon, Oct 20, 2025 at 08:24:19AM +0300, Tariq Toukan wrote:
> On 18/10/2025 0:54, Daniel Zahka wrote:
> > On 10/17/25 5:51 PM, Daniel Zahka wrote:
> > > 
> > > 
[...]
> > > 
> > > Hello,
> > > 
> > > I'm facing some issues when trying to use the devlink param
> > > introduced in this patch. I have a multihost system with two hosts
> > > per CX7.
> > > 
> > > My NIC is:
> > > $ lshw -C net
> > >   *-network
> > >        description: Ethernet interface
> > >        product: MT2910 Family [ConnectX-7]
> > >        vendor: Mellanox Technologies
> > > 
> > > My fw version is: 28.43.1014
> > >
[...]
> > 
> > Sorry, I should have mentioned my kernel version. It is a vanilla net-
> > next kernel from:
> > 1c51450f1aff ("tcp: better handle TCP_TX_DELAY on established flows")
> > 
> 
> Hi Daniel,
> 
> Thanks for your report.
> We'll look into it and reply shortly.
> 
Thanks for the report Daniel. It seems that this was a bug in the FW
which was fixed. I was able to reproduce the issue on the above
mentioned version but not on a newer one.

Could you update the FW and check it on your end as well?

Thanks,
Dragos

