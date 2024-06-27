Return-Path: <netdev+bounces-107440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FD791AFE1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839951C220AE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3B19A28C;
	Thu, 27 Jun 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9l76w6d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5164DA08
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518096; cv=fail; b=PAwjgOFTZ1Bbdvl26tZ/Ev4MDUJpWaRi9MkmxVBdWPsFqAxo9wk9Swdej47aRJga8WCjeuPn12eUksc3iUZwpz5qPU0xrZyDGIlsnVvdmHGckObTFJS1Wa9H45pb8NFKhNWvPKkwJforCBGCKZ9+LxNrS12Z+IX2oZIl4eSwlcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518096; c=relaxed/simple;
	bh=k28m25uIPOm8q2SgZYgPYwlRNg1N5raOFaealqwqO40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mza+aPK58C/5QCLGbI6G8VGQ1eN6xri5M5qnHe+4UaGifVIY+/M3mm0hzIqtk1lkOkbWq1V7lhOW3Gda9QaXZ7PEzgWYI8GH2FlksrqR7jShnYhWh0HShmgcwramoQgIxGZlotiG+Vy8Y/y54ETz+dZFHgp8kz/RwgaEG4DRhUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9l76w6d; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0Z4uKxFgeJxEw6YVvPlBiIvVlEo9JKJnQJgeT9BXL53U58m9iKQf35Ua/6EsUwQlQ/errbQ3N3bEHvGo31vNC5GjcdqIiDhwnPQKcvNzuZXP+uXZ64q5PaAgJmrhJ3Fs/QhPB/jZJlclxkEQBT2dnOzcqgvldM56Tlwc0Cwqn8LpuWOl8LfhE4CFBqJxMLfGXEXLwxFLnBmPWjbmqEmw/9/RtqHragyKieWt5wn7lKQuVgz5/xZ7nyeTmRlvuYNJc5CZ9+BM4jS7dFLGaBvhEdLxC03/n7VyimZ2pImMWkwFKbyRzfJvUxZBJRb03fnl4aYb6eT3EzsEEbtSszSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuxiSX+E2Zb5/DquQSPZkrf7xThEKlp3+aHQvI8CSfQ=;
 b=NmOfvYaIvXdaqGPa6f0OOG3ujtMiq2Buvsve5I5mctWdNJLOl8sCEFrvulH52ClbXnx9BOiYdw6/bDdXZgSmZEDGAdyL03n3Tg587An1BvTk0vwFHB9+T6jiDAeeGjx/wpLPoSIXmMN4aojRrnWi0PkvXxikRvq8gNm6Lkm2C1lWXJMkbxeglJo3PezO7hjmxv1jVtKxTOCFfaz7ZfnWhjmqA3iZtcrycX81yQ6E+RnveBJy3GHlp2RQ/LZ2g7P33NuKrQh5jsuWII3/erbbcg2og0EdiJAzQEBIlVFKgyDUrbuTkcWrfybuGMQQhUVO4JOPJ9LKOeXW9t47pnzFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuxiSX+E2Zb5/DquQSPZkrf7xThEKlp3+aHQvI8CSfQ=;
 b=M9l76w6dngOFTu54Z88pPdKS6orzh+5xK8udzuvHJOfnNmns0plMJE1vgtS10J0Fm6OExR70iPetJf5v956UfuaQz9r2x4kSFrzpM8bMfWx5Xi3ES3GXjAufSdfTOf3UogI5PgLLpRfuXJ6umanzYnfTCKSEfO0M1mFGKjxretNLdbwZZV2V05LI6MQSx/yB7o17/xE1jzF2uR7d/qUiUzTZi1V08X21iQiMMEjKIyVg6V61QVf/kF83k1NAmnkamGVXo0uOzqBIpno6bjJSVFEPTcwkzGqBdrt5HHZ2gGYQU2vgDnFge5WceBFETcpEqvDzURdVE52bpzSywqSQQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Thu, 27 Jun
 2024 19:54:47 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 19:54:47 +0000
Date: Thu, 27 Jun 2024 22:54:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: Matching on DSCP with IPv4 FIB rules
Message-ID: <Zn3DdfGZIVBxN0DR@shredder.lan>
References: <ZnwCWejSuOTqriJc@shredder.mtl.com>
 <ZnypieBfn3CxCGDq@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnypieBfn3CxCGDq@debian>
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: d7633b38-bf79-4773-3240-08dc96e2ff43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oU3HtIqCHxWsejoPgwjlzy8iwW9ry4VETJhqg3S9dh/e28zdSUwHqsQdI5/u?=
 =?us-ascii?Q?eG7p/LYneanf2yPEEGazdYnXIlnrzuyWQvHnGrkh7abYtwNZIKgQBC2v5F2Q?=
 =?us-ascii?Q?CEGBJRPsJj31bBTc09ZVuJ5LBcfNjOO8WgDtmwvXoR8tduKRS7hkoDdptgg3?=
 =?us-ascii?Q?uES/seJ1aoMY6yunGLBvo9dhx+LaHaBOJ5SCWfmj4/xbxAcJyq2WVO7UMIFY?=
 =?us-ascii?Q?dyJ0XP2qdMZMP6tXQUQ2KEQs/zrSzAn/CF9uXv02BRrKHUstgo1C8HWeHYG0?=
 =?us-ascii?Q?Pr5Bk1XbLuuwB6DY73wpospExpY0D+1QklY+GNmBlFDHOunAFiG1y5WPqykM?=
 =?us-ascii?Q?CiCGeQ58MbFWGUGRNzPJ1nYk+UGBdN5gazWN4vnt2z/bP3/tgg380maQQcou?=
 =?us-ascii?Q?RM154IOjPz5/ocPjayFtyexx6j/nnoC3DX7Dwtz4PYyg5tZynCPwc8dVVZdI?=
 =?us-ascii?Q?OyBZ8Is6Qr4DIu3+GiFwzKY2uPi3VN85g7CR4RVD/WNu3Ynzs4xhSlmiY21G?=
 =?us-ascii?Q?TxwtnsIZGaD6q+/ykyB2rZ9Y/lYCsj7TlZEoT1qzLSRIFoGV8uzxY9vSvpK7?=
 =?us-ascii?Q?afUr7FCWKzjl0MGL+AD6Y1tQg60rsUC7HNHrQniwb0xPg4LTrSlE5i9VP/i6?=
 =?us-ascii?Q?RBQHoAIeTYwkJw95xhJA3D+25jRRqsV2Zh8ibFBXy94vUMBjRzk7JwWsREjQ?=
 =?us-ascii?Q?oM2g4Nuo9lftat0flgBfghcD9dPx+XDAsUTSdxS/ttBduEnyZ9MF4Emjz2SF?=
 =?us-ascii?Q?Fglg2qR1hPz95wn5oH8qvinCUqNlqlOyJ+A9Oasw8N5RFvjTkG5neYUf9Wt1?=
 =?us-ascii?Q?4NvR5803IUwnzbmAg02JR9l98CAy1NrNZmUvWMtVILRxQ+zErVDtiVFhvJbp?=
 =?us-ascii?Q?89INiWnEO3owH59aKwM2ynVi88pWkEg7WrA/pmCRJvXlBohUrJrJuCtw7ste?=
 =?us-ascii?Q?UhbwB3pQfdXKu+81on71PGTrf2ZXAKRaEALa3OmPX8zb85exbkiDWmy994ar?=
 =?us-ascii?Q?vx5cz8+ilQGzR1W3TjEnGkoyZ7PhHkHdqtIPRJza5U3sNmksscL56enkOviv?=
 =?us-ascii?Q?/YUMqVxeSZQVnqcuAuUhRKySs4kwGpRbkfLyksqQVuqhPlBfNCigdwecs6jM?=
 =?us-ascii?Q?4kUJ58MEGHVT/9uf+oG3fgP8LgA0VMozQ2kYmXXxRW7qFDzBm7TjMMR3dg7r?=
 =?us-ascii?Q?tCRYD3tYsdMaVmFsXQofXYF4wiTE0guehRIBXfNVomnYtc+Go0JQI9AVHp+H?=
 =?us-ascii?Q?z/gnRjVuz6iD329H44JfO58h4yt0OwLJyMkD7pOPpCQ3ZIdwSssXy/y+1K0y?=
 =?us-ascii?Q?likN3FZ8RIalsbZX9dnZcHV2z3n3wWQG/ebsqRKR4Lybjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WZpCNK5IPGR1r2Dm8E+q47KhbJH4S8Y22/chSkpMORMeP7eWLHxQXCRBYnYR?=
 =?us-ascii?Q?rVCTMG7AgM1Bm5zZfthMwcW9bM1OAdY4d4Hd52cCAknayuxCmrvF2UI7Keiv?=
 =?us-ascii?Q?I/899CaH0WmfwrwgJKI7/kKL/PDno76U//VYLLKdzYD4wuoPndSIfkRDxtJS?=
 =?us-ascii?Q?ah/xZ0TqlI7VLQAqNBJyijG3g5WHUO22e1QHoH5gcJBwjIjZ37APE8ad27y1?=
 =?us-ascii?Q?QWulQtyZuWR+wOw7iLW5eXiY7MstuqfZAj7I0iSiYbpZHdQDsZUQkLh5D7al?=
 =?us-ascii?Q?UepYunxvNZNrABxCwz/XYvFOfvAe0gdrUXT7XYexIUURapmRO4s7Yll3HngG?=
 =?us-ascii?Q?Oyvlj89FQ9jgAYIIgHaWMOOmdgAH/j9zWlkqY1NNvgb5gUAQyeoeDYeBAxAN?=
 =?us-ascii?Q?nThg+Tnyg9yeO5VOBJsypDcLxOdxqVF2crQu+tUJSNO1KHDpe0trOEGGV8WS?=
 =?us-ascii?Q?fheGXW+36xvAgUsY9hYYu26c3voP1ZpTKMBowHqZ/hfrS60hkMgGRTBCFMEZ?=
 =?us-ascii?Q?4xtde7/FCv+I6bHYkzippQ4WlwSiEsGZwX6FsY76RKJCATrnI5GxE2pED19f?=
 =?us-ascii?Q?vLKw/O88ulFBMh28wh9KsfGmRDGZTLDkxLPoRnTkYnrGpan/XRC/8aiwYQAN?=
 =?us-ascii?Q?1UDB149UrIWDqEVFwQnSZkNJVmAp0Dy3K+cctuENrrg02DhnzvhnOIOWK48H?=
 =?us-ascii?Q?pWVn1c62JsMMkryCnqerSvj4XYEoPziU4qm5FwESiHf4Hci4mQK7F/tVAg/x?=
 =?us-ascii?Q?FnXt3Md9BQ23ogsOyS3wQU7iVMxSzkafiqYRFcNDlsv/mvjsrUMAlsHThvO1?=
 =?us-ascii?Q?Shud2nZHlBBOnySzJgHG6VfGfftjTYTldNVEzc4Hf9C+I9zcY6H6UuibuNBe?=
 =?us-ascii?Q?/GIf2EOhvF78KWaLNuw1GKCaU5JoLUINdlfqMqRaW9tQo7vLE3ECs0l2YbsG?=
 =?us-ascii?Q?4nEBUWamTchHFX31UBttfhyaRyXrHL3bZ3cL0CF7YGUjAtoW2eR1n3PM4WV0?=
 =?us-ascii?Q?voWOC4PNoK+N0Wti+QmpAlhCHKBe2a6l+ZWt1cmDUHZ7HIA0RTqJhdeRGnuL?=
 =?us-ascii?Q?k3csx2fJ6PQsQopuucycm4Kb82GzbCVabxzqUHMgvsmMHlWjYyAkB9JS3THK?=
 =?us-ascii?Q?y2j5ukSfgaGzF0pyRFxqS12it5Sx+Pd9ZyXaCZ/LZew/EOoYHTbtSFf76Nqu?=
 =?us-ascii?Q?IGhWE7GnzBxM0SV/jTa5LT3zox9JyWxapj/XMaUyhW0rLMKsn379g5UN2N6x?=
 =?us-ascii?Q?xU7mdnSGfjJ/MRlBxdhOSM9n8Ikgp2zPUa4k3kq1yK9ZzdSNWcRDLWoGZMD9?=
 =?us-ascii?Q?PUvqBh5Lh/lKacBPWXyOppYuO1ijo/uZO53bveFRtxWTOaf9rggdKwqVLy/g?=
 =?us-ascii?Q?+4ocMivmWWurUVoDPvXGo41mOuLt56phzNlVjGTeKX1JDwJE/G8rBIJSPWu2?=
 =?us-ascii?Q?2nBYq+SZsa2WgicciGsk+vjSHqvD9San/CVopx0hG90+Uoh8sRi/iPW2DHgV?=
 =?us-ascii?Q?0KNUXu0rvLjp2qHiekNAA4YspbHvM/S2M+jFIL+lcctlU7FmZ4HSjN+Jansp?=
 =?us-ascii?Q?05ekLYitddq7dGmGX78IpwjrDO3ZYxZryTxyx987?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7633b38-bf79-4773-3240-08dc96e2ff43
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 19:54:47.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B19dslxz7loAXVrMSszlnAN19xxFGQ/+wo/2kHDZgwZgZpHPyxjiBhmO68Nm1sF+eNpUJhfxCl/4qKJqQxcN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

Hi Guillaume, thanks for the detailed response!

On Thu, Jun 27, 2024 at 01:51:37AM +0200, Guillaume Nault wrote:
> On Wed, Jun 26, 2024 at 02:58:17PM +0300, Ido Schimmel wrote:
> > Hi Guillaume, everyone,
> 
> Hi Ido, thanks for reaching out,
> 
> > We have users that would like to direct traffic to a routing table based
> > on the DSCP value in the IP header. While this can be done using IPv6
> > FIB rules, it cannot be done using IPv4 FIB rules as the kernel only
> > allows such rules to match on the three TOS bits from RFC 791 (lower
> > three DSCP bits). See more info in Guillaume's excellent presentation
> > here [1].
> > 
> > Extending IPv4 FIB rules to match on DSCP is not easy because of how
> > inconsistently the TOS field in the IPv4 flow information structure
> > (i.e., 'struct flowi4::flowi4_tos') is initialized and handled
> > throughout the networking stack.
> > 
> > Redefining the field using 'dscp_t' and removing the masking of the
> > upper three DSCP bits is not an option as it will change existing
> > behavior. For example, an incoming IPv4 packet with a DS field of 0xfc
> > will no longer match a FIB rule that matches on 'tos 0x1c'.
> 
> Could removing the high order bits mask actually _be_ an option? I was
> worried about behaviour change when I started looking into this. But,
> with time, I'm more and more thinking about just removing the mask.
> 
> Here are the reasons why:
> 
>   * DSCP deprecated the Precedence/TOS bits separation more than
>     25 years ago. I've never heard of anyone trying to use the high
>     order bits as Preference, while we've had several reports of people
>     using (or trying to use) the full DSCP bit range.
>     Also, I far as I know, Linux never offered any way to interpret the
>     high order bits as Precedence (apart from parsing these bits
>     manually with u32 or BPF, but these use cases wouldn't be affected
>     if we decided to use the full DSCP bit range in core IPv4 code).
> 
>   * Ignoring the high order bits creates useless inconsistencies
>     between the IPv4 and IPv6 code, while current RFCs make no such
>     distinction.
> 
>   * Even the IPv4 implementation isn't self consistent. While most
>     route lookups are done with the high order bits cleared, some parts
>     of the code explicitly use the full DSCP bit range.
> 
>   * In the past, people have sent patches to mask the high order DSCP
>     bits and created regressions because of that. People seem to use

By "patches" you mean IPv6 patches?

>     the RT_TOS() macro on whatever "tos" variable they see, without
>     really understanding the consequences. I think we'd be better off
>     without RT_TOS() and the various IPTOS_* variants, so people
>     wouldn't be tempted to copy/pasting such code.
> 
>   * It would indeed be a behaviour change to make "tos 0x1c" exactly
>     match "0x1c". But I'd be surprised if people really expected "0x1c"
>     to actually match "0xfc". Also currently one can set "tos 0x1f" in
>     routes, but no packet will ever match. That's probably not
>     something anyone would expect. Making "0x1c" mean "0x1c" and "0x1f"
>     mean "0x1f" would simplify everyone's life I believe.

Did you mean "0xfc" instead of "0x1f"? The kernel rejects routes with
"tos 0x1f" due to ECN bits being set.

I agree with everything you wrote except the assumption about users'
expectations. I honestly do not know if some users are relying on "tos
0x1c" to also match "0xfc", but I am not really interested in finding
out especially when undoing the change is not that easy. However, I have
another suggestion that might work which seems like a middle ground
between both approaches:

1. Extending the IPv4 flow information structure with a new 'dscp_t'
field (e.g., 'struct flowi4::dscp') and initializing it with the full
DSCP value throughout the stack. Already did this for all the places
where 'flowi4_tos' initialized other than flowi4_init_output() which is
next on my list.

2. Keeping the existing semantics of the "tos" keyword in ip-rule and
ip-route to match on the three lower DSCP bits, but changing the IPv4
functions that match on 'flowi4_tos' (fib_select_default,
fib4_rule_match, fib_table_lookup) to instead match on the new DSCP
field with a mask. For example, in fib4_rule_match(), instead of:

if (r->dscp && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))

We will have:

if (r->dscp && r->dscp != (fl4->dscp & IPTOS_RT_MASK))

I was only able to find two call paths that can reach these functions
with a TOS value that does not have its three upper DSCP bits masked:

nl_fib_input()
	nl_fib_lookup()
		flowi4_tos = frn->fl_tos	// Directly from user space
		fib_table_lookup()

nft_fib4_eval()
	flowi4_tos = iph->tos & DSCP_BITS
	fib_lookup()

The first belongs to an ancient "NETLINK_FIB_LOOKUP" family which I am
quite certain nobody is using and the second belongs to netfilter's fib
expression.

If regressions are reported for any of them (unlikely, IMO), we can add
a new flow information flag (e.g., 'FLOWI_FLAG_DSCP_NO_MASK') which will
tell the core routing functions to not apply the 'IPTOS_RT_MASK' mask.

3. Removing 'struct flowi4::flowi4_tos'.

4. Adding a new DSCP FIB rule attribute (e.g., 'FRA_DSCP') with a
matching "dscp" keyword in iproute2 that accepts values in the range of
[0, 63] which both address families will support. IPv4 will support it
via the new DSCP field ('struct flowi4::dscp') and IPv6 will support it
using the existing flow label field ('struct flowi6::flowlabel').

The kernel will reject rules that are configured with both "tos" and
"dscp".

I do not want to add a similar keyword to ip-route because I have no use
case for it and if we add it now we will never be able to remove it. It
can always be added later without too much effort.

> 
> > Instead, I was thinking of extending the IPv4 flow information structure
> > with a new 'dscp_t' field (e.g., 'struct flowi4::dscp') and adding a new
> > DSCP FIB rule attribute (e.g., 'FRA_DSCP') that accepts values in the
> > range of [0, 63] which both address families will support. This will
> > allow user space to get a consistent behavior between IPv4 and IPv6 with
> > regards to DSCP matching, without affecting existing use cases.
> 
> If removing the high order bits mask really isn't feasible, then yes,
> that'd probably be our best option. But this would make both the code
> and the UAPI more complex. Also we'd have to take care of corner cases
> (when both TOS and DSCP are set) and make the same changes to IPv4
> routes, to keep TOS/DSCP consistent between ip-rule and ip-route.
> 
> Dropping the high order bits mask, on the other hand, would make
> everything consistent and would simplifies both the code and the user
> experience. The only drawback is that "tos 0x1c" would only match "0x1c"
> (and not "0x1f" anymore). But, as I said earlier, I doubt if such a use
> case really exist.

Whether use cases like that exist or not is the main issue I have with
the removal of the high order bits mask. The advantage of this approach
is that no new uAPI is required, but the disadvantage is that there is a
potential for regressions without an easy mitigation.

I believe that with the approach I outlined above the potential for
regressions is lower and we should have a way to mitigate them if/when
reported. The disadvantage is that we need to introduce a new "dscp"
keyword and a new netlink attribute.

> 
> > Adding the new field and initializing it correctly throughout the stack
> > is not a small undertaking so I was wondering a) Are you OK with the
> > suggested approach? b) If not, what else would you suggest?
> 
> Sorry for the long text, but I think you have my opinion now.
> And yes, whatever the option, this is going to be a long task.

Yes :(

> 
> Side note: I'm actually working on a series to start converting
> flowi4_tos to dscp_t. I should have a first patch set ready soon
> (converting only a few places). But, I'm keeping the old behaviour of
> clearing the 3 high order bits for now (these are just two separate
> topics).

I will be happy to review, but I'm not sure what you mean by "converting
only a few places". How does it work?

> 
> I can allocate more time on the dscp_t conversion and work/help with
> removing the high order bits mask if there's interest in this option.
> 
> > Thanks
> > 
> > [1] https://lpc.events/event/11/contributions/943/attachments/901/1780/inet_tos_lpc2021.pdf
> > 
> 

