Return-Path: <netdev+bounces-232085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43EC00AE3
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04C483425DB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6FC30AAC9;
	Thu, 23 Oct 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V2n1UW2t"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891F309F0D
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218370; cv=fail; b=Go82gHM5ljSApGF6ZKT/tbG2j5SBm+FsXs8JQU2a27C0bC04oV1UW7EyCgZkRBWQ3w+OC2UneG2ixYwEumM3QS/KfMGrULjAPRHeFDLmSX3m1yHZudPXz/eqJw3XjmhRCq0V0vuKSt63zWI14GPfd/8ctTU+o9OBQi0TI1jUKLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218370; c=relaxed/simple;
	bh=Y5X2IJoZcpk1Un+6O62KF6UN8P9xEqwACh2jUn0kSVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbHuN/6iP6LILHKoS/RamoLA6jwDiixMXeZSXUN0qwNSgOmdumfwIWLVTo2cr0l3zoj6cD7LSopF/VF0nSiSaiH1G2iG/QgORiZ5QSc5c+RJ4twlHB+B5sY5uQsbgU+F0xB9pOHRr4yQe2FNFufav6FRgTs3y2jD3jT1oKEOfdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V2n1UW2t; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIITjs7P9MmZCP5yl5glX6gv3jLM5eofgnZ/9Usk/ibREBF1QIBVOx4DmFSvpppcU4oVf5PGmSNvjpo+leL1UP+fwD9NeWdJoWISISjGSEJtpZmMPu3t12Cq6y0Ep018FM2Goeh674+/218aeEs2W9ZkaTl2aQ7PqbucVZjY755kh1bTYlSkjkU1oVtVu2hcVB1JoOyS4YqTJzaPxim/pvM2wt7GqALYrCMAiVP6jpImF/N3q/lMr4PYONKV8ak22C2Fac7jsTMazdh1uBmB4jj0TFyJbsyq+OywWeTk2t+eSZWXrpGvbQYqISYLUJoYqLDK6L66zsPg0+YeqSbgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5X2IJoZcpk1Un+6O62KF6UN8P9xEqwACh2jUn0kSVM=;
 b=V15yOVhA8HUWjviNavS7Ke5/mV/gjE3v0frEoYqLqsbaoUyyPRVHg2HW+DcpVxgmmzCbsVxEJIjUano+YpQAyaof6AbRQZ0IV6jDD3j2PNKCft933lb7NGN/zr+neK/98bMKmAkhSgep/7cKp3+O0YS65YCnErV5wbI5kXNK0E08El3MtgJL/ZAtYTQJZH9Az9qre/R4TLjENyc5crLQtPChAOSOIrnhQd0cNVADmnc6GI/8LmP/Shk+LDY5d6eFx5cZiTPS//SYVZFThOshJwwIjcT7dbXfG+HhWMw4jFktbgV6BM7EaIFWeKvZfD5ExRTsFUSawZVs+WW8V8CYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5X2IJoZcpk1Un+6O62KF6UN8P9xEqwACh2jUn0kSVM=;
 b=V2n1UW2t/wlcqp48LK6B6E9YFblghTnJFAtrqKv2A+0yzcrLB0QWiCdpnJeS9i1h71xDLMcdGRbibL9RVBi3wF4eygCFKy7cQn13DoHJrUCJrvxsqaRuvwwhbnCMjiPNJjBD7i/zRYjEMK8+Cxr4PHyMASRfXkpe3edQ0rT4NQuvQG7VCPARFdHt4oC8gQeBdwSu56gfW8UCyjhfh/bqYDadfol6rMWwU4WTmCenDn4smFrggUUZ3RDxSVh2CvuPFrph5pSo88yj0oO0LQeyHPum/Ae9nRzUy4O62dMVWeGVQ072B4xPKjPj6eTfuyYYvfVye/79D10Eyzd88J5LMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 11:19:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 11:19:23 +0000
Date: Thu, 23 Oct 2025 14:19:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net,
	fw@strlen.de, ishaangandhi@gmail.com, rbonica@juniper.net,
	tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <aPoPMXrfAlSnbgA8@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <410cd787-0085-4409-97c1-2019a7baab8b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410cd787-0085-4409-97c1-2019a7baab8b@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d20bd5e-18af-4ca7-10e6-08de122604fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ap5l7DoSXjoBMc7ly1XE10G5D4JGQkNZxNjzsPsJakSoybUzgwxPJI7+V304?=
 =?us-ascii?Q?sGzKSw/LOSXiHIs4f/B2ekbNT/Dlni9R4i5LdPNs4s/wVO1/sWcuiCIVfIiZ?=
 =?us-ascii?Q?NdJskCbTAOhuyOU1lL2V6vgKDFHu/lksbAbD/NOU1JYRSZ3xcU6XJj1R34wj?=
 =?us-ascii?Q?pCXz6gQuzT5ZRPEdubytq0fGUidW8hQGQCd1QL11kFoWTFii9JmazZEKb6VP?=
 =?us-ascii?Q?wYDL9vq0TBM/RjEezZ1pQikE7P/Wtgf66kePB5mr9V0LggwMoed/Duyx099N?=
 =?us-ascii?Q?/R6H9ZRF0o9iFCIXixbdj0k1nozsM9KGkjv7JTZxcX3bcSxjfoBmqvUHNKkH?=
 =?us-ascii?Q?tt8xSTrpTVspir+QwMpQvWm+nKDdYc/ikY8qxpEJtgBW3nwgqQvBH2azN7bG?=
 =?us-ascii?Q?GOf0Lp5svchQPjdIxkLyVrH2q4P4m9nI7TZEXMMV/qzLQUFwc91HjQc+HEIf?=
 =?us-ascii?Q?07r8c8rsxNuQxUVjtrrJpOx8M/eMaStY3fcA19c/yHEvqr2u17NgTc0KXGli?=
 =?us-ascii?Q?lGcX8FryX26zDZZ3vA4CPXfqEbkC1L86iC9xt1XLsLaCO3SuqexyJtaUdwHt?=
 =?us-ascii?Q?FGzHKAyQZxulZOC7aOG7VqZ2eTQ2IoDEvN51KH16ucMIZUV3U7hxiteH6eB3?=
 =?us-ascii?Q?B26rWm+ubB61KBgnBrgak4+gsaxv2RZDLjgNMf75tJxDj5vrFdK/mcdljN8L?=
 =?us-ascii?Q?Im1ITWq66oyr0j/T27rqdsLYOwZuHzfMWqGWNyvCsrdubX8Rx317qX7iNEjK?=
 =?us-ascii?Q?/yTdqw+QNDFj0Is0wv+yBpADJjh7FVVFjDOQgZpFvSGYuDxAvMaFlcjX63D5?=
 =?us-ascii?Q?k4aSSl5dDck6hnGGjYeSwA6HmbACKS1UmV5BHR6MI2PAi1RHoySikwG9y6hk?=
 =?us-ascii?Q?i3He9d4WW7h66rhqHrlrkqKylia3g32lc63jz18n1sCbpr+mLYufAxoZoQPV?=
 =?us-ascii?Q?CGNliiNZrVKoz9u1hu7aYRV/BBCbuP/8OHHRHOPRmzmd5GEXPFFZ7nmD3BY0?=
 =?us-ascii?Q?gaqzIn68KijzN4xrKctaB6mHF+uIBUBVBQiwj7Y0uBZXwIq3RjNhWNk2PrwB?=
 =?us-ascii?Q?hIsTQPrPPID6kbgkTRAY1f8vE3dE4uTohXpedqd3SVkE0GYrtMFCnrsUVqpA?=
 =?us-ascii?Q?ji6C3eEOSQRIjXC75fVKxx2IqkDUgVFR3vpnTpQRKabJhSIMJzueO378sG+F?=
 =?us-ascii?Q?AaJnaiwC71rKyzD4FaMJfRqgY2tvkX6ScWQtBdW8YlcLrJEfS9yZCpWYnzyE?=
 =?us-ascii?Q?owY5hzkQBMXnOh6XWCKAmXKUek5TFtfr1XkE9GAvmqe3zHsGT+Of3WCBb8EY?=
 =?us-ascii?Q?o4Z7ALk75CRznBNxsY+HnjHIoTjZsSwDab+431gRZMwEHP5wUG056f3y8Jnm?=
 =?us-ascii?Q?JkOEuD2yJUB8LFXw3mVhOp0mkv/i3hIuBgBOUAZHkyCK8Ih6BGjkW97Fngb0?=
 =?us-ascii?Q?uYA+GluBy5KQ2wSEEoPAPZfu/eiVdAyVxc5tA7qMO3lGJTQMhBt7Tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ljkRu2WKgszY1elSw5Fesd9cLZGujkj8g58PsrulZQ5ZC4E5l9gCvFpqwlV2?=
 =?us-ascii?Q?WdhzmK9Z0Q+sIBauSEoPtNG++NV1UH/K3vyF8U+pMc8XUYGfcl0Ra30YwbQL?=
 =?us-ascii?Q?QiuX8gP33zP8v+Swwt+RuNGfyIVKUoR31pmIAQyR8fn+sVoVlo7SSltZh9Ka?=
 =?us-ascii?Q?rZUnzuw6Xo4VwSfE1quC8io5j++EMA5xeTogZFcU772ZKdKHdtMJSmD6Zqam?=
 =?us-ascii?Q?dTqbv5YiHk+ZM6yXkxKAWEDIIcYsqbJlg0ZXqfca9kNgilOU4El7oNtvCMp2?=
 =?us-ascii?Q?22yI7k31t3m3WwytsP9Ku5cUVgMZmHAAildzhPwlCo2TD7q2NVpeHc1vZlC1?=
 =?us-ascii?Q?Xtip2Sbf9RrXsDcT5mBxnISY5ZfethqSAQrD3EIyu7kuCNkBywGcpyUct8ZZ?=
 =?us-ascii?Q?lyzVC9nzkdoIHLXLmlfGK7fsrAXXoVW2wAG/KgoshEEPIart2A6SGOU5Frx7?=
 =?us-ascii?Q?WvrPrXwZdkGhv93YiyZM0wyay2xmC01j9vyPLoFkI7kmDRUEBWQHL1Or3PS2?=
 =?us-ascii?Q?30Zsrj9Q2iYHmgDiDHkeIVAf+UZ7jDPxBHsFFLOG5sQvYQqu4Vsgz5d6jTJf?=
 =?us-ascii?Q?hpZ/GUnNjmBVo1l7Z+NVki1mUZBVhazKk6Mm5S3j/Btc3csuIZ9dGzhJ7QoB?=
 =?us-ascii?Q?duPEA+wcl3IM2mYXI5e5uIaIdvrrU9fLQLsE3U9EybejACPGFpfk1HtrgpaM?=
 =?us-ascii?Q?/CyIqllogT3ShENOz+U963jHSaR7bFzRVgJ3vQMiq2G5VzdKom0C1GGRk46l?=
 =?us-ascii?Q?4oDBXFLiSTYaYJIBt3EsyOEaTOv9Xlt3AqrgXO2TrECg7z3WmIb0+wTwRitd?=
 =?us-ascii?Q?ePZSTaeRSw4FG1d59km1WIjR4XJYMaw6ZQBg/LdsFt0zfdd24Z2BCu4oMBAR?=
 =?us-ascii?Q?QO1GhLHa8RaB4+gA1EqFMLN2mQGXU0ab4AaORrB2IkkFYEkEo6SrMcRAKf50?=
 =?us-ascii?Q?wjR3dpm0iWFPSegjkyCCclV7qk1nrxt1tCcoPECiEo7K28724asT5LD2aAuD?=
 =?us-ascii?Q?NN5pEW7ni6cBPbfBVH4Ex+7Qu4NeXs7hOSbGimCuxWGLH9ZrXfoXE3Qgk18M?=
 =?us-ascii?Q?IMNi1wAoeocDtgyOIjSTeCp417JgQju8mAwtClfNOjb4Dpi/eOxQwkFjl0TZ?=
 =?us-ascii?Q?Q9C1EJ6vVV6LJG57oQsYg/udkJMId6rwrkO3LqoJY0RywpLdbn+qbnmvHk+c?=
 =?us-ascii?Q?4AcFXvCSXE6ibmJOkjRhzdHg5OUcMBVzn32QwdgVDd5G/79x5ZmGQC5RSoji?=
 =?us-ascii?Q?2VBDIPZ2DAgiPqf3txlLkvTiw8ezrEZAkoDBWLG+qj5nBhvI73rpfsw0Gjwe?=
 =?us-ascii?Q?8O0XoT7TUChVGLfuk3oFqb3Km5i1SoK5iV5DQ+QpPTyq3hLqzO6CeXuUncS1?=
 =?us-ascii?Q?rwqzRhOl0k6VBwJA/F82MbD2xI+ddzgsyV8qhbV1v/IEjhXATg6LPtjeoR+l?=
 =?us-ascii?Q?s1/siQBNyJ82IRodSy7ilHjmKpaEsL8CYO4RHjKthNYZD4IaV11NYBAxYex2?=
 =?us-ascii?Q?aN9Yxx0z0OJNMgFYoJRGTd0D0FVaOpM6u12Weu3K47rYmZVkSOaY2QfxngvV?=
 =?us-ascii?Q?pmCA1MIAk7kbzHQJwtG0YgbSqsS2WAgOJ00EX27d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d20bd5e-18af-4ca7-10e6-08de122604fe
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 11:19:23.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3S4EWALofOUA5pvlN5MJTY663K8qBCiZo/e4B8h8jAYJh6uH95ZEGqlPPUA795AMt7JbHk0baPwrg+q4jZCpPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On Wed, Oct 22, 2025 at 11:29:20AM -0600, David Ahern wrote:
> For the set:
> Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks!

> Did you try testing this with an older kernel versions on the receiving
> side of the icmp packet? ie., making sure older code does not have a bad
> reaction to the extra data in the icmp.

I didn't touch the ICMP receive path so I don't expect any regressions
there. The only open question there is if the kernel will be able to
correctly parse the ICMP extensions when the IP{,6}_RECVERR_RFC4884
socket options are used, but like I told Willem, I don't expect any
problems given that traceroute, wireshark and tcpdump parse these
packets just fine [1].

[1] https://lore.kernel.org/netdev/aPnw2PkF3ZMP9EJr@shredder/

