Return-Path: <netdev+bounces-186469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF05A9F48F
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F175A1092
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A189266EE8;
	Mon, 28 Apr 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S3uO+XlX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4A1519AD
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854534; cv=fail; b=XCGuTxryaAawGuXLmKdRBq1VBgJZeTl0JrU9AsbZBz6YYHQzID73QIX/ehlZXj1/BsCRXPGzRCpIk4d+dYQv+N5bw/MOv2dAMIP2nyegNMz8fQowA7YxvC6/BuzcFr14qJoIIRgZtO81dD3qMkXedD6uGtVyvw9ZSPrZX0wMOsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854534; c=relaxed/simple;
	bh=yxZ1uLUJ67dF361atIXFK9w7c4MRxoN0CtrCVH6L14U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kRr5VC4i4uNzqNoJngjwBhRzInPqIUl3Ort3GO9cGAjtfpRPPdtALIir/f6SX5wnKPXNm59pH6LlHh0PtDVDNMJwI0uIc21T9rjKlErGSzLuuAd6NdC5qDIc3/Dkpi4Kuv05vJ1jSPr10/Lwm5tcV6L5dRCJMlyBLzwXpMS+mY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S3uO+XlX reason="signature verification failed"; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ+NZJ68oTodjLc25hKXPoWWiqK8bBbA3bHNEGcs8SNodZKRiGWHXKtFQ9ISpRlqolOFmEZ8fcLNDGmrSY8lz0Vh1c4N8pQajO3U5CKDByb3vlT+MTPho0Rsz9h/ly4x12j4gmfhex1i3A/EBkHzOFUyHRT5DsPKd5vdB3adAlZQHfw/WoxjXQnoeHdiZ9WDZ9rBHjicy6Ues26B3nNSqrnQ7CMKlwJx/SvzygiO/RMJFeQPHupbF7o12PbLiKOd6Nj6zeZvbqgNoJDgF2i4jeqgJ7wf3UsKXVpFABHhL921kLSZdgIWsKUVrg1uH9YbQA/V++wKxydxohIO6DshgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+aEcdScla3CwWeKk0Y/biT70atky8R9AfuCvJJxzmU=;
 b=yH/eHYJmoE55n5b38zvwn3lliK0R+bowxrNdJ1uz6o9hWAaUKv6XwaosC8JSYHHZYVVu+GCAaLFvhT3AGNpkmHtIobFgRaXRjUPKi4wXXn4ID7/yD1apSFWV/3PJb7xOKO/7+e//I2ep9bKS8AwEC18O/j5XZKzr8Wl3T+OPyb5cqcLS9KyQ1nHWcJN8WIYlekqFhUcuS0pUM3Hi6UFFxJ+TNAikm7B07HSu5AKUEd28yewr1EtTP4GZmTp7ZlKZNE9UTTjEnl1Xxwj8V2So7+zB3gNe840+MNmH0QP3XdPkw60Nfpl31T6+VwxxIB9I/f1ENP4nKF4Sv4dC1621Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+aEcdScla3CwWeKk0Y/biT70atky8R9AfuCvJJxzmU=;
 b=S3uO+XlXsnrpegskAshep8K3iFHeLvQopMwkcQJ1KZkpzZOC6nVz6Pes0O7idS2bSfECZfRaigBLFPpP9cPV0nrPA9LEXH8sEnvt2DhdKB3sXX1UJ4DGgBdYTN9tuoAfRTFgTmWpHegXEIi1CLchqb8FKmnOnJUYFn8Y+weEZkZBcIggR3E6rVFpJtI2o5Q50M62lWnHZmKcIO2deE2VNdOgXXjFEZUcj7YnhdbuW1VdNytiF6rXmZqEBMyvU6cPEFz8h17jMZ3JjalQ0KcGpJ5zGI/AKDuz+V1j47tGDUkkUgfU4zIBghvghHAB8u00wBcZo06+/X9qeoqvVpj/pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 15:35:28 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:35:28 +0000
Date: Mon, 28 Apr 2025 18:35:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ferenc Fejes <ferenc@fejes.dev>
Cc: dsahern@gmail.com, netdev <netdev@vger.kernel.org>, kuniyu@amazon.com
Subject: Re: [question] robust netns association with fib4 lookup
Message-ID: <aA-gNpCWG2XJaf-X@shredder>
References: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
 <aAvRxOGcyaEx0_V2@shredder>
 <2eb4b72dc5578407715e91f87116d2385598fa82.camel@fejes.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2eb4b72dc5578407715e91f87116d2385598fa82.camel@fejes.dev>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8d69b4-d56b-4615-ce86-08dd866a4d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?MgHKniFeBKOMINV03YKFUq6ZzwoJR6K7XBDRMFw7WEnLqY5HpE494fFTQ9?=
 =?iso-8859-1?Q?WXNUzrUVlBUvtbABzSzFiqH8J+zvFjtCp+dZL6Z+wRaO6i8TMcVHGanBd5?=
 =?iso-8859-1?Q?KW/6HBp7EHL1/t/Cf0VSf/CMYW2+c+mtY1JiiTrpPFq1iC+O6InIsNngvD?=
 =?iso-8859-1?Q?iXSkLtKPSwKrVehZKBOoDZ3Na6m9EljUeRVJ/7HVyhcjgXK+tlpKlfKAYi?=
 =?iso-8859-1?Q?eyZMF0taYrxr6C6mNsb9XsnHNzPDdHqhyy5sW6acFwCylGJxz1FOQERDJ3?=
 =?iso-8859-1?Q?r8MUyC8Bc6ciM0W5dZDHdXtWI5WV4KXfpcezZGFH/OA3JcIbRcPZ2UBRbx?=
 =?iso-8859-1?Q?Nr9/TfpKFTHz1bE1R9iTba2wZywEZpfVwrjvIcOyoztq6V3jHdbt1/LAgy?=
 =?iso-8859-1?Q?i/n6yfTEREuYxvKim+aw1xYAQYD5BmEw9ZBQUcQWjSnWQn+o3ZQlEhHaOj?=
 =?iso-8859-1?Q?GtCmsG58UFaCBSg7UdqjQTg8SIcT1OOJKiLYoc7p35J0/1nEe4d6Lp+tQU?=
 =?iso-8859-1?Q?YGr8IqpPXuZIjVPSiFmdnKijjs51Ou4FGXxA/+TdipEAAqqArDdYrHpJQf?=
 =?iso-8859-1?Q?EyAD0gMGxiqiC9qlbZm47nqDRJzUk4t1AZ4vdmaYa4k5H2QPEUXk0sy+IQ?=
 =?iso-8859-1?Q?4EcSH3ODEvYOqTOqAxDNWTK70NTRpILfFebo2PdYCjp0Iz23iggPU00Ojt?=
 =?iso-8859-1?Q?2RyxKGQ5qHRkJcKr65etQOULNDMuEyx9O520yzgmeWJvXLdvKPzLrRmS+v?=
 =?iso-8859-1?Q?swpWkhmCtWeT6WAeL3oTmWBBOYDR0o9qO1LAH6YSrWCvpNfWxLU5r0A3NF?=
 =?iso-8859-1?Q?PQDFVfPH1dopsAM5bcFz9Te4sfKOqOCgCr5bgwTZC4arcWK4lrGEKI41tG?=
 =?iso-8859-1?Q?1F5V5Txc2qqHOArFc4TtzamTAFgxZcsP0o8EqL1HMOkmX8KGCNHBj22UKv?=
 =?iso-8859-1?Q?fKniaJhgP+LEQlwtKi1ImAYitrwOmm4tqHjGG8Z8+CZLzeBHp2iPQZFz7m?=
 =?iso-8859-1?Q?TfK4oe8kDOdrPSTnyTSpMEsPC16BUkXi6thCg66iHETUhz5zCJFYRDKK0H?=
 =?iso-8859-1?Q?CIgMFcr3n0cCK3RxJLNKlndk9NYMgODGlEVTOoliC5a0pzh9KlHQNDvkS7?=
 =?iso-8859-1?Q?p3gxil64tM2RJTWnmhP9Cnbz9Xle0qDi7/XQxCRuDF2EgwqW3d8Ut6aNtB?=
 =?iso-8859-1?Q?1w/abyBcRxRS7Ky45iT5DYsiRWNzxeali5+77M5KxlYzY87raA9E0houcs?=
 =?iso-8859-1?Q?rB2aKCk5nIhzqTATrxLteNLYM7MqToBNDp6vYv5AyMBOtVfd1H4wNhkhG3?=
 =?iso-8859-1?Q?iF+M1ncycFpucjGTV/yDrjkdS2wlOjVmRMv4VB+C4XmubXIktAHEruouzy?=
 =?iso-8859-1?Q?6Ichw/SOVG8uBx/j6l1K3bxtu8bcTL1SCxE3kTHW4gS/KjmmhRXt90cUJj?=
 =?iso-8859-1?Q?YnLVf0vJ/wztQE0cRuBTfK4xDNQldxU8wAwGavaFPYP47NwR2Dd2xEPh6m?=
 =?iso-8859-1?Q?U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ko4RuFldtWFgK145i7wVq5NzefnqMbNDvomA+PuIHtV7HxoTNhEj+4b62d?=
 =?iso-8859-1?Q?P+pvAa5UVGMe8XZkzLCjItr0BLx6Gk9Q6ZGr8PL87iBY6mSfrY8v0XMkBb?=
 =?iso-8859-1?Q?DXOqdR7uh1QIJZvLIR59g1VWMu8IRTdCjhp+z+84HUGR2PlyUKHJ3PfCFN?=
 =?iso-8859-1?Q?PG7eQlOmyPLOqNM4ZlE9fX80nNdmjSsnOo16aavv8xF3R7qWceJl5Zx3uL?=
 =?iso-8859-1?Q?zQWDzisVf8MoqqEBva/5acNMjND01uyNhK9+NolDh+WCpKRh0RjgxR7zpp?=
 =?iso-8859-1?Q?GReK0S/Cq+aceDVNCS1iOQEf6gRED1Ctc8QUY+Ne+E3DqRyzXZKe2Rk+PW?=
 =?iso-8859-1?Q?usMeNfre9y/xec+Ih/BO40XB2SA7/GF3akVXWyGfm6hPrq7aMTKF+HsdeX?=
 =?iso-8859-1?Q?tAFKBdakNTDdmrAPPNK7+xwCsZ+VCCb+4QTG9P1fW3DIMQFL1Y+5xrd76E?=
 =?iso-8859-1?Q?hpaZmDkNoXMWPl+MSebtkEHrYs9KKhAR/SLlYL/nBmBu1eFRu5RDV7Xrrk?=
 =?iso-8859-1?Q?JF+9jJYpUcF/EbijY4R0CslE9+sbeGbhjGJsZeNznl7H1XsqPjgR9hvAwH?=
 =?iso-8859-1?Q?KZGA0xw7/nPcX8FzWcPE6rEkBVF1f6Ebfoa9FBdam1SlUFOf84ns9Ms7UT?=
 =?iso-8859-1?Q?SZTGbow3q+K09O+Y14z4MxaFYhDdKtcNW3FFW2mGDB6w7uLQzuSQQt6JDn?=
 =?iso-8859-1?Q?4PIQ3HEb64m7mVnwNRyh7oT+euWqytIPWVdBxMiy5jerSdsB2VlM36WNF0?=
 =?iso-8859-1?Q?ctV55lAaKFAF6XEL+RpAfyslgqClyyGaUPT67ecbe2EXLgzcdJQ7vWi35z?=
 =?iso-8859-1?Q?YKtoe80qaezu19uJNqhns69+4muT8Y0sqiwVvo3VoU06DqgATGhoJ7xHgA?=
 =?iso-8859-1?Q?lVISk8rVsvKYD4Az6yr79k+oFiWDWXOM2Dgvg+HrAx1Yd/b1pxj7GmVry/?=
 =?iso-8859-1?Q?7S/WvDaYC/BzNTSYTaxIpbZDjUYJFiuAQ0/CeKvInUaXobhDDKxlBnCkFy?=
 =?iso-8859-1?Q?5OU5WBUKnULfI+HBoCczFtB5zTciJW4/OjgHv7wuld24yFbs1+Olf2LnOx?=
 =?iso-8859-1?Q?hIcJWTc7HOd6a/SYMJLXa6L5WsnQN0zTVKdpuebsz4e0G9LlkNoGtq226I?=
 =?iso-8859-1?Q?69uOHVQDiTBrI9POZ2o5sqXha7O/J+RMFrbwWIanYemtCvHpQn3OZ287t8?=
 =?iso-8859-1?Q?bKQbUyrvErfIn7BVAtwRLRwFTeZBzsTiKCCIS24Vg5QSwGebXUfaEXAMwb?=
 =?iso-8859-1?Q?K27JigF9Wqyze4l2HrhVNSQs4HbiS/bvOepLxQZ4mh5IMpi2DyPlECP9Cl?=
 =?iso-8859-1?Q?rIO+nVi3l7nU3fnpke6vHAnuaaBzO0yuHGjU3nB3IJyMNPhZgVcbNcbe5L?=
 =?iso-8859-1?Q?UrKP6nfH1JFW7xcEmMNzoE6h0wWoNprrx+qTatmcVkeiS/Ff88EvdoZYXR?=
 =?iso-8859-1?Q?rKQ3wchJ1Q4IefKDjd2D36xET26yQHkv8xtpVsSyCGkgdTBOJEDkT/z4sc?=
 =?iso-8859-1?Q?8yxz/6+fszu4HXoz0OBTZ47Y+i3ri3+XhzMNfiIiQJcPRXRykl9J02Rtqn?=
 =?iso-8859-1?Q?4JYrZ2tEGKYvvR4Vq2KcaZ27DJ6RGsiTvLI8DHRoB9JO5VP0Era7IkmBrr?=
 =?iso-8859-1?Q?ckNsWMRJLU2SloZ6STX1oEg5id3CMPzHYg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8d69b4-d56b-4615-ce86-08dd866a4d50
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:35:27.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJNj+pt0cXPA9zvDicmZiIFAR47BrXx1dutXThdM06tuUhe4KXLHsO0EqYRFcmzeFMZE4fniA/Tad6gkKeuJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776

On Mon, Apr 28, 2025 at 12:20:06PM +0200, Ferenc Fejes wrote:
> On Fri, 2025-04-25 at 21:17 +0300, Ido Schimmel wrote:
> > On Thu, Apr 24, 2025 at 01:33:08PM +0200, Ferenc Fejes wrote:
> > > Hi,
> > > 
> > > tl;dr: I want to trace fib4 lookups within a network namespace with eBPF.  
> > > This
> > > works well with fib6, as the struct net ptr passed as an argument to
> > > fib6_table_lookup [0], so I can read the inode from it and pass it to
> > > userspace.
> > > 
> > > 
> > > Additional context. I'm working on a fib table and fib rule lookup tracer
> > > application that hooks fib_table_lookup/fib6_table_lookup and
> > > fib_rules_lookup
> > > with fexit eBPF probes and gathers useful data from the struct flowi4 and
> > > flowi6
> > > used for the lookup as well as the resulting nexthop (gw, seg6, mpls tunnel)
> > > if
> > > the lookup is successful. If this works, my plan is to extend it to
> > > neighbour,
> > > fdb and mdb lookups.
> > > 
> > > Tracepoints exist for fib lookups v4 [1] and v6 [2] but in my tracer I would
> > > like to have netns filtering. For example: "check unsuccessful fib4 rule and
> > > table lookups in netns foo". Unfortunately I can't find a reliable way to
> > > associate netns info with fib4 lookups. The main problems are as follows.
> > > 
> > > Unlike fib6_table_lookup for v6, fib_table_lookup for v4 does not have a
> > > struct
> > > net argument. This makes sense, as struct net is not needed there. But
> > > without
> > > it, the netns association is not as easy as in the v6 case.
> > > 
> > > On the other hand, fib_lookup [3], which in most cases calls
> > > fib_table_lookup,
> > > has a struct net parameter. Even better, there is the struct fib_result ptr
> > > returned by fib_table_lookup. This would be the perfect candidate to hook
> > > into,
> > > but unfortunately it is an inline function.
> > > 
> > > If there are custom fib rules in the netns, __fib_lookup [4] is called,
> > > which is
> > > hookable. This has all the necessary info like netns, table and result. To
> > > use
> > > this I have to add the custom rule to the traced netns and remove it
> > > immediately. This will enforce the __fib_lookup codepath. But I feel that at
> > > some point this bug(?) will be fixed and the kernel will notice the absence
> > > of
> > > custom rules and switch back to the original codepath.
> > > 
> > > But this option is useless for tracing unsuccessful lookups. The stack looks
> > > like this:
> > > __fib_lookup                    <-- netns info available
> > >   fib_rules_lookup              <-- losing netns info... :-(
> > >     fib4_rule_action            <-- unsuccessful result available
> > >       fib_table_lookup          <-- source of unsuccessful result
> > > 
> > > My current workaround is to restore the netns info using the struct flowi4
> > > pointer. When we have the stack above, I use an eBPF hashmap and use the
> > > flowi4
> > > pointer as the key and netns as the value. Then in the fib_table_lookup I
> > > look
> > > up the netns id based on the value of the flowi4 pointer. Since this is the
> > > common case, it works, but looks like fib_table_lookup is called from other
> > > places as well (even its rare).
> > > 
> > > Is there any other way to get the netns info for fib4 lookups? If not, would
> > > it
> > > be worth an RFC to pass the struct net argument to fib_table_lookup as well,
> > > as
> > > is currently done in fib6_table_lookup?
> > 
> > I think it makes sense to make both tracepoints similar and pass the net
> > argument to trace_fib_table_lookup()
> 
> Thank you for looking into it.
> 
> > 
> > > Unfortunately this includes some callers to fib_table_lookup. The
> > > netns id would also be presented in the existing tracepoints ([1] and
> > > [2]). Thanks in advance for any suggestion.
> > 
> > By "netns id" you mean the netns cookie? It seems that some TCP trace
> > events already expose it (see include/trace/events/tcp.h). It would be
> > nice to finally have "perf" filter these FIB events based on netns.
> 
> No, by netns id I mean struct net::ns::inum, which is the inode number
> associated with the netns. This is convenient since it's easy to look up this
> value in userspace with the lsns tool or just stat through the procfs for the
> inode.
> 
> Looks like struct net::net_cookie is for similar purpose and can be used from
> restricted context (e.g.: xdp/tc/cls eBPF progs) where rich context (struct net
> for example) as in a fexit/fentry probe is not available.

I'm not sure the inode number is a good identifier for a namespace. See
this comment from the namespace maintainer for a patch that tried to add
a BPF helper to read this value:

https://lore.kernel.org/all/87efzq8jbi.fsf@xmission.com/

More here:

https://lore.kernel.org/netdev/87h93xqlui.fsf@xmission.com/

Which I suspect is why Daniel added the netns cookie:

https://lore.kernel.org/bpf/c47d2346982693a9cf9da0e12690453aded4c788.1585323121.git.daniel@iogearbox.net/

Regarding retrieval of this cookie, there is SO_NETNS_COOKIE:

https://lore.kernel.org/all/20210623135646.1632083-1-m@lambda.lt/

Seems to work fine [1]. Maybe ip-netns can be extended to retrieve the
cookie with something like:

ip netns cookie [ NETNSNAME | PID ]

[1]
# cat so_netns_cookie.c
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/socket.h>

int main(int argc, char *argvp[])
{
        socklen_t vallen;
        uint64_t cookie;
        int sock;

        sock = socket(AF_INET, SOCK_STREAM, 0);
        if (sock < 0)
                return sock;

        vallen = sizeof(cookie);
        if (getsockopt(sock, SOL_SOCKET, SO_NETNS_COOKIE, &cookie, &vallen) != 0)
                return -1;

        printf("cookie = %lu\n", cookie);

        close(sock);

        return 0;
}
# gcc -Wall so_netns_cookie.c -o so_netns_cookie
# ip netns add ns1
# ip netns add ns2
# ./so_netns_cookie
cookie = 1
# ip netns exec ns1 ./so_netns_cookie
cookie = 2
# ip netns exec ns2 ./so_netns_cookie
cookie = 3

