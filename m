Return-Path: <netdev+bounces-153967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E509FA589
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 13:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893621662D2
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0118A93C;
	Sun, 22 Dec 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="anLX7YwS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56031189F57
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734871162; cv=fail; b=QPtdCP5hvSGJMLwOgVD0R3oj6yW4J1EvpinFzsNwXnU+hpXCN9/fYSot3r2HmTLQAvZfi9G2fT1+NZhrz4Tyt28BmXrOx0MRrftevGCK4lNZpGy+V7XrEen4p8hBjwjLLw0aHRv4er//RSuzJ/P1jbCK50pGr8L+23Yw9sWjnp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734871162; c=relaxed/simple;
	bh=i0ujMHky7OUQ/RRerQZVttnxU3QPULeJsnRokf8AYLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdNAepwMx8pcrtwWHrRfjktH8M6Cs5XlujLwKKfOFxOMp0OD4lNGH9REalSTkHBQpfzD+jRnQuFMsI30ObCaXT2Ji/JpjHFL/9v06aLdGVBGYYI97cizgSSYUE7qdumDRhYGJHObeIw2Hy1/5PoRmO12+xZOIzmO4Zl5/cVvCkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=anLX7YwS; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQeVIDyNcfR3jeG6hpuSWwPpFqjlGDAttXJZhJsWtle96gE8Q2rko32JNnTSxUKW27bSbL5/1DTSw4BkHYWn3Ei9OzY9PDhTT3r5mGLqhNdhXH8s5t6aiUICm1wL6ENo+cHuj0AcvF0FX825lP54W8FxYzD4dGHLBsMxgyzcJLn5tRZSuYYqcPY3i8Met5mJ5JbatQUFFjjCy7drCZ7gkymbD6VzeZBDM85DB4B3AOr/OgZJ+F9EJlQtpKyIT3RExW2/E6SBwetF6iLZuByFR+8jzIl8P3j//wVTmaWd6RyHajHaxbGsLnt0+F7ljpD8qAV9OkoIfzmtdeJSss2D6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62PRypaj+VEWTjk3D2GeVOiylFHYGDS65SoLBRWQrYk=;
 b=vumKBsIUaqJ9tUj4SmrGLe3yxibTxhEZz9a/+VndQp7B5HNRQ3paujDrWNlMtZaF9+FOcBKQKRjinelIzM2FlHDg00d21G3QJWGsCW6Cd+IMyfIuJVp05eYTs7gccr/Bbk3usbrcF2mao0CiFb0AHeSWCQ4QOHxymw1C8m8ggYFnSX0eJe4n4qlDL14gVql6MZ7/RrYxBD41+CTGw6wLH3DDrr5WmBwUobYixss45Go+tSxRKwzlAB5cbE9CP9DYKt14zXyy4U1GwguWbv9jEoRSXm4Rye7/TP/xuRMQK+iI6fkSUCFwEnW3Cf/1GslteUSJMKB7yFfn8IG788hFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62PRypaj+VEWTjk3D2GeVOiylFHYGDS65SoLBRWQrYk=;
 b=anLX7YwSEPA3zsQYfmQKRyv8EzKl7P/UnCm9cQX5oA7HU32RbYKTZRYr479yZG/Z6xGQgNMPLrkNLAgw9r2ym7jYQoqmFBlyXX47VcK1CDc3C/tM22ePmc5Lx2V+Af6cMrF8j44Kyerddu4Vt0sVw8itFaC2Dq53bTZYenMyymdSJAtIgsQBX+RmeDOuzVo1hhjVFglXYsTlAILptALmdsEmI9lSsj5kHiABvGlE/S90ZLTB2+zGqek5wzNT4xEYTCQeWmlYqe1NJWHZ8bg/Oy7lTvipxGlLo4gQooVT+1YhqFPZ+872pCvy4v7rj2+lH200V9uqlOCC8ymy7/jAzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Sun, 22 Dec
 2024 12:39:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8272.013; Sun, 22 Dec 2024
 12:39:11 +0000
Date: Sun, 22 Dec 2024 14:39:01 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: Fix netns for ip_tunnel_init_flow()
Message-ID: <Z2gIZbztO6rrU4oT@shredder>
References: <20241219130336.103839-1-shaw.leon@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219130336.103839-1-shaw.leon@gmail.com>
X-ClientProxiedBy: LO2P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::18) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: b81a2a15-4c86-436c-c183-08dd2285a237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hwK5HgUhk3xxEFf7Xvo6oLbbKMI3EGu+SYhw2N+Vm7hY2NJjrDRdZZfDn1+k?=
 =?us-ascii?Q?rQOchC9K4eyFPJU2hLMjThO8r88+MOYQSKVXmrvJVyBaScRIrtS1y7pGTlrb?=
 =?us-ascii?Q?1c3xu15xl4VU1q6dX6ZPfjN6TjHKa4nnQoENeooppNqJcTXpdcmCRp5u0ZxR?=
 =?us-ascii?Q?g2lCfu7Jvxaa2LWI6B+mGB76cb3kCvfxB0bxGt8isykfPLQ5AHuxQKBPi/0m?=
 =?us-ascii?Q?vlVvIJnnIlekJHqCmf82AqII4V6mEZ74XkMrD326Wl44++mKGvvw92Bc4tNW?=
 =?us-ascii?Q?mZdtAQ8QHYL4gzB/AlpFLGP5Zj8UnCcWOazZCIIFFUCIuxWDSOuEhVVzb8BB?=
 =?us-ascii?Q?dhGvqzHnPBvvJuKfjm81+kpMlZrx0hmq+WwJoKeN5Z8R6RU49lxqa2fT3XFC?=
 =?us-ascii?Q?ghBtUfQk7IJJjI3EtMYXaktWpWrNStLEIRnVfPfNnW8j/OriCciUfSKpeJ2K?=
 =?us-ascii?Q?YJVG7LkeZsT8hobKtKCBuRQeiHM55Z5yzXnlBTBsav10RSMpPuoPpRJTU+lT?=
 =?us-ascii?Q?1nNEbBUxfHmF73DTQ4WT+JYbzf9TcO6PilEjOG3dzusrYYnHHrtQHd7jTOPB?=
 =?us-ascii?Q?difOw7yIx0/eNRgX2IJYvSlM+1oq768+MDvHsXdY/lHNg0I37ZAgakUMw8FM?=
 =?us-ascii?Q?3XMT8XTI4EOgx9iFCyc9cDjFmeXYean3RoFWC5dE2j1m7hj0ORBqz4pt1OQW?=
 =?us-ascii?Q?cXzxUJSrk+JktRx+bHDd/1KjNArOPmHCWyJnHUytyXlqSY/31y5gLpb2mSGv?=
 =?us-ascii?Q?zErcDAH2H+W967A8yA1g9p3IJrVGB15bRfJV5i19fw0Ik/ppCgJIquookVG8?=
 =?us-ascii?Q?HVJTOiFPyzT0U8YtpjakmmYcV8U/LLZKm74LbAAFxH8pGtC2ZFJmwOxDrxPJ?=
 =?us-ascii?Q?FhDYviJigKKMz4c1V4ZDX+EO7osK0UQcZcgA/i60z7kfitk1Vodej6m/RHvc?=
 =?us-ascii?Q?OvraVef9i5uNpmW4Ex3Svxpe7T0YTUuG5cnVpMeSCd/sXg71D+CC/6QGw68L?=
 =?us-ascii?Q?6ZyFVKDn/uluAYSCYo4REECai6wlQjQ0nWU4rPZri/H1MS/nfeoDsoZz/OCo?=
 =?us-ascii?Q?zwbOXVAUzvPrEMSYglV0kjX+YCk+IxTC6FdGonvxRG2eK09+K4TOtZkUwp7M?=
 =?us-ascii?Q?bfI+9ErkuTU/uWlGNM+0oxxt5b9lwdGFvsdMKIqQHwMn28Kcv/RuJlT1hfP4?=
 =?us-ascii?Q?yfPemRDQqLz0kdX3EJtB+5AJ2JJTCL16x+Xog7RxKnV83sL9a3cmDTDw9AOP?=
 =?us-ascii?Q?vtuLAltUaz4QBSBvD4bs7CNQ9nTe/bEpuoBYTOqEjpX8KrboE/NmbLeVvkvr?=
 =?us-ascii?Q?AHphcOrWIJcQw+AGyhVRt2IzW50mk2z7vCgw3++meJT0/yPJ4cZ4/JEmECjX?=
 =?us-ascii?Q?+mA1xiYhLaiL5o+0Ygt8wdP/Hv99?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnezuV82Gud+mFcYv56T0c0ePSSOf+TzZx0wR5LKeL8DUos9tNQ9heCEMg8N?=
 =?us-ascii?Q?dlc/JJp9bjB/sWSOmC9O1kuuRP93+xAH8uWfn6HekboR0Km3GGv7wRvtLXzn?=
 =?us-ascii?Q?bxDyhG/2EJAF338NRtwnwBnoVhV/Qb4XkvNlidxE9WueMG7ZZHSZ6kIgCiaK?=
 =?us-ascii?Q?MYX9GyyokexDcTej62FwUSFFW68N/BFk+QgeDoWN4UZ7fXzcUO+G5GKEhNZv?=
 =?us-ascii?Q?atskTdSh3KBcBamJEyx/2WHkpsMM6RWFjnKBMMVWhUM+IgI7StxYCZWbYag7?=
 =?us-ascii?Q?iaGdefg8dyCsCe4O8zeJNz7zz6aGTq0YNzpriRDX0Ae6tU07zs+3bjoN+Dhu?=
 =?us-ascii?Q?g2h/jKR5ms4q2sXKnB84tIanZ6mVjdEd7juxRmiSpKiiAs72Nc5rXRBvlEd1?=
 =?us-ascii?Q?x7+rNTjGgxKSpgZTKBEByKa+WIOs+XY6vOJYPOxNXzffItp49E1hVPKl5Nqw?=
 =?us-ascii?Q?3XbZdDONnCRMFHGDfwtiaU1/J8hilykysqNhOshMToJU0maQ8X00+3YoSAZd?=
 =?us-ascii?Q?5Tdm2ZXTnflXebtMADNjBrDjXKZ8aloZaLLBUO6JCnYZi+asntvXq1XW5Bs3?=
 =?us-ascii?Q?04W3+mBw9hytBZGoz8+wpABKElcWdfdUko2+hxvZlMYWx8mbOKf7jrMj4xf9?=
 =?us-ascii?Q?YR8tJSAiNHrFKnh5hFyf1TAB249AFdelhaeFtB2NScWki3vkfe9VmmoeXkBp?=
 =?us-ascii?Q?JuuDGw+ACNNXmTRVkU7YrYgb1Lm/nGyua8/hN1nTxMkwIGmOU2SlZIgP0TKc?=
 =?us-ascii?Q?UntMe8JQUMKTUwK2s+CS7SXLSljd5fHpit60D/xKUNCMYi2iNxFg0TV1/z96?=
 =?us-ascii?Q?7ozbGFXgUERfrSY9Plhz3mit70yIWKQjl1jMDoh9iYyqwmNOtIydcvVAoOhb?=
 =?us-ascii?Q?jTwPnh15/U9HdhfLE1tSFVdx0qZeO8ILhvxk+0+0M5t7UhXaXXFDk4HhMRPN?=
 =?us-ascii?Q?qYLPmwPhdeWgXP4Bb0Qb1BJxQVwclxwb5b3VWWmYcdS6sVxsdZ0tExHYIK1k?=
 =?us-ascii?Q?1UW+BZqDIMaYGVPw8AVpDFSdEPtQ6vySdzRCm7JW6342P/dBUSTuXnv9peoC?=
 =?us-ascii?Q?CJCXuQ38YEfqLtARU+X3zDDDrTcmYjLity4wb+iJMIYKDmQjt9KyyxmVtO3O?=
 =?us-ascii?Q?v5a3BcQLby8Gm/WDtgtvAIqMk9K56xoNmGXybp8EvVZppM1dtYV8ky/U469O?=
 =?us-ascii?Q?4dztb46MQ8sk9G+JPtdKrtC4vy+hysR/W0Q82kN9SJYs8M2Bz26/FqYEkHm/?=
 =?us-ascii?Q?PETAZMUYomhB9sTQ+7cqWVxa86lQNQBYjmWCWaCbL5DNNhP7whgFDWUBz3SE?=
 =?us-ascii?Q?pIqT5e8ckoQqNLd/zYDp0OXtpxrbl/7FSh9N5LelbESULJQWt80cmrHmECC+?=
 =?us-ascii?Q?YfRwFeqNmvrl0eM8eG9gQfaEWd8nwUffVvMR1HX3YdwQfGOTr9NkaxdrcBZY?=
 =?us-ascii?Q?CDSyuPlK0y3Z17x5RgDBTqYH8sny5rhzo3LIOI0UvvXiUydc+unRq4kKVKyJ?=
 =?us-ascii?Q?L4KboVbS8FWcA2iNU4JYRXixnm0EAgLkYBwFyAdfReqZ+WMfPdRWsgAwP/ho?=
 =?us-ascii?Q?l31L6UL/uxx04CMLZ2BgPF6z3fIFKwCHMnUzTium?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81a2a15-4c86-436c-c183-08dd2285a237
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2024 12:39:11.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOwgGk276NvYUm4aHz4WruJ/+sX9dVR23rt3gp2a13dLZMXhpFMB6VUx7ct5YC1RUkcnB0MmXy6+MhwKVTnAjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

On Thu, Dec 19, 2024 at 09:03:36PM +0800, Xiao Liang wrote:
> The device denoted by tunnel->parms.link resides in the underlay net
> namespace. Therefore pass tunnel->net to ip_tunnel_init_flow().
> 
> Fixes: db53cd3d88dc ("net: Handle l3mdev in ip_tunnel_init_flow")
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

