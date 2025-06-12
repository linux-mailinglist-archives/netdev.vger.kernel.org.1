Return-Path: <netdev+bounces-197079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F016CAD7741
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2D173F3F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627CD29C339;
	Thu, 12 Jun 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EEmtkhJC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7FC299944
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743543; cv=fail; b=dblXKDqEZ8rRCxcPnZKj9Nw9Fuan//ZGM1sUpzFUVOCWGifJHi0qsdZ0W11cp9KYW+r4Yly0NMQJVX0Rs+IKgi+0eET6N9KUn8Oln4z10fmrwv70nYoY4faVB5ANkGv7K/HA4kobdu8TrF6qwHNALClsOIRSMfXk5HwC8nEdaYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743543; c=relaxed/simple;
	bh=rVS0Lm5ahFSS3RzZFeQI9w/MnuOpK6rbPrKz9m8/R2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqpvi3H8+Gv4c/FqbpPOn7m034ohFw/10SdiMCc5XNHd0psJy/2LXC1H+T2nIXJShfktIQT0bCWOwLx24Rew+QyHUppmQncPT7qUpeEVglzptOYkDcpHTgM0bT+WTPaoF8x1NkJ8iedc/u8kM8d6X5Rc6SJdk7+4sHZYPI6/QlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EEmtkhJC; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4wluAhJbBLokbe5DkouE/ondEDSfsCDGtpu4znAI9s4GaIbvk9KEKhuMV9QShOoHUjlYIFNuvTD5xzEixPWK2zskfXdG8qU4GhKStrbf6PgcFxR+OU3GDw8iee8pfrT1lSsrsj0TlqcfLG/wUQ8UdZMOjCXUEYNtg6L0hQNlQK1f/m8lSulIcQzn9/xkrij4LD0TjCZTDkGTMf2xsddBYwJP7TvOdNf+dFievPf+abiNOwbjUJI1c9Od+kmcyJepyQaZyPJpxxvg9bLwkn+hUHVZehmh3yTNPigV66P7lVy97dksFd9FU1+STg7aTE+iD74t0i473fhEhRJWF3qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXGBhUrhYWdV6k3P6oFJek1Xg/uRLdD5HJLVFy44Yes=;
 b=f376BU8eyP3dUM2vr/SlmzwCDtnbsFuLrj/+QphDanTJCt9c/3RUdXz1O0CwhDNVMpIKY2ebzxHUrXlGJoa1e+3qy0y0XhjnLoYvq/Zq+HTsN4Xhio7Tn3+rNHwnFvQez5aOYYrmRE7FJVjgwL7wqmNDx/Gv/KLGvcbxLZeAcJcPrw+70+IeDjlPa+Qg1lkl3VHZOCwtQ1sqb5zLFi9CSaDUbtXnUL1ttWba+llkJNnWrsIvku7w8ORVXkrI8LNjqNOqoyk8IOgY6Ls+FvUQPleGgrFZh/x2B2YUAKY59mhz6vTbYXtI12JGgVfKLuye2J5m6S2UwK6LdlrbCOYfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXGBhUrhYWdV6k3P6oFJek1Xg/uRLdD5HJLVFy44Yes=;
 b=EEmtkhJCnvJ/QneGMwdrs8ETuYU49gom/E03cE4HlG7g0PuA19FQxGvGS6JzliclIpRwzInizN15rmGHWwodILPsx1kkXLtnHllyf2T+9Azv36/SvglvmQ9zETWFlmhnxhZNx7CjQtLqBA3jzWwpbsG48Nl1B8M5VgrHnDO+e0Csnqusxb+VC9uMndIkVV47Rsf71Seg06WvBWsKeWgVDjf9MGU25+oVHN0tEIgo/3RN6GDkFj4dH7mSOXcxW01aDsjmH716VidM644x/d1oVGIhO49Uuh/nxyPHJhqZbrens7KPLQb1lnJ728TEtRueQn/W0GowHUPjQXfrfrl7Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 15:52:19 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 15:52:19 +0000
Date: Thu, 12 Jun 2025 15:52:12 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, 
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk, asml.silence@gmail.com, 
	ap420073@gmail.com, jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <vuv4k5wzq7463di2zgsfxikgordsmygzgns7ay2pt7lpkcnupl@jme7vozdrjaq>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-20-kuba@kernel.org>
 <5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
 <20250612071028.4f7c5756@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612071028.4f7c5756@kernel.org>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb8357e-9743-4b96-348b-08dda9c91c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGbRNIsARyyfDya8TqyNkTKSFuG2kegCpD6lZgn8NHva2iDGDrvElnaQ9z5u?=
 =?us-ascii?Q?3umzKYPKsBsBHXaTV6g+Cs7QOdCsJdE3hnjh5rgVV7UrYfpiVVqOYy9JxUAk?=
 =?us-ascii?Q?TByEm1/ciSzd/8D/xrBfV5cqbtp1rejMaW2C6430p+YlyQHJ8KcLZUmQcGQe?=
 =?us-ascii?Q?Xdx+JcbRdgCkcNFBVUU4dfvZLUFxF+2RzgUOIZJ2T/rCG+QMupnso3QzTd14?=
 =?us-ascii?Q?B6KU/w1QTUht0S967f0+DknFyXrHiojCLP2ZVriLMNvboasS+odGiRB3WznU?=
 =?us-ascii?Q?IIzpjEQ9s9o4M3KsTWMUmknIFbN2OqxfRKBw79qpqvTMo7xMvjyuU4Z4Bfxe?=
 =?us-ascii?Q?+U6uThGWke1PG1nHeMa9qY5c7xad/iNMQ+jwizSnFacdbhax6oLbAaYHLGoa?=
 =?us-ascii?Q?7WgAMPZl3nI9VXsWl+8pLRQQ5yTamZBxX+kW9N8IiaEjCFsJCvMUyYgucso9?=
 =?us-ascii?Q?IFCl2myY3h925fAkDDOd+epiW7OWVRuDVKJYdnNoBGYK+BaJmC5DQxd37RgO?=
 =?us-ascii?Q?EYHSQk9m7FUwjKHxpJFgDW6awOo4pLqdsxvZ5US80LfqJAPsNZYmdmX7OVEv?=
 =?us-ascii?Q?abWBwQYgrdFsK/gIF7g5uFnRkjjCHV6wlYgrKBUA4ZxMoUvHf6PcFrQYkfmV?=
 =?us-ascii?Q?uS272qFwsHYV+zgz6TX8KglqsALig3iH8Ce/YMkjBJHi7xQlnTEKnx7p8A2y?=
 =?us-ascii?Q?mrKLPlV2IT/uMDeTS1FVrEgf7DqgtuzbdSjIACjzDhduI/i/QUerJNzgU1Pm?=
 =?us-ascii?Q?SHS8VCgULK6r+KIXF+bH7vnLZG12PISNJjDkvbm0ixSZzKTQAHAbZD/hSdp9?=
 =?us-ascii?Q?Sf9ZC76To1K63RmvZzfEBaCVXFlOZYB+hA1WmOrsI9HB5USaluLluRI+U8VQ?=
 =?us-ascii?Q?SjFfNU0AptE+U4eOnTGErfQyoUi4NijH36lJo60SfTETBmkxOrlogMgAxobz?=
 =?us-ascii?Q?e/cOLIBAiRHE80j9+ljM/GmkvrQy7go2MKY8CeQCcdKBIxqwN1wWGrXl1mPF?=
 =?us-ascii?Q?joMEaqkMW1OjfkwTCP9mn+uNN2HXqhZdqqImyNxJMaKL9/vE5Y6paxr9nkqT?=
 =?us-ascii?Q?9Zudi9DM/O6GlgRsJsgh81nYsUaKIX4tDbC9M5jnTgzf1Bo7aR71kYj1AZqL?=
 =?us-ascii?Q?SPgiO3aROss6Bvibt/Pwc9N4ST0iJy2k1fmaOiB0IIn4X2PDns+w0zgHqPwx?=
 =?us-ascii?Q?qhHArmKKpvwxfAL6QC+5DAnAQ0ybMjVfTzc8UwfTAVuFXe6jTO3dTSpsHTNQ?=
 =?us-ascii?Q?v/vriPHLeo5CzkphDFOA8XLpykSYTnz95eNrw8uVr6azmrCz9FzLE71Kz5tj?=
 =?us-ascii?Q?2HCtj/S3yzsw9leyh9Ki1G+p/KS5x64Szz4LGwKLZQlapAoPhAxpf63eW6et?=
 =?us-ascii?Q?he6VxuhTZIl/gnsXRzDdNt8w1eDDDnDhoXj6oG8u3oimDtrQgg8Qxw5ZNM+s?=
 =?us-ascii?Q?/YmbbvM4Nns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLy97cb8jgP8vUd2qJ66wPE/pWTenWobgHJLTo4cMeyps2i0Sl5+qNdnFrpm?=
 =?us-ascii?Q?xOTZvRJCTZActOSBox4XBZAjw6UeCGgWvLY7SvbUv82n/tcKF5Aq0x8kQcc9?=
 =?us-ascii?Q?IfCLqtpp8cr4B4FCD8fN+RancIjyGe3sTTHpnRFni6nC7Tss/VdbSwrY7vQC?=
 =?us-ascii?Q?OdqzmFTWtx8/f979UDl2ZOpSZsLsZxsIjeRsdRLmRMEZvB5y9Atg1wRh3Kn/?=
 =?us-ascii?Q?3a+3PQ5Xz3Q3wfFWooym82G4fS+8NgPk1+ipyik+OnK5yklrG53LlbnqkQSt?=
 =?us-ascii?Q?6IxVd2uxZPb2gA9584VcwAoMMJIq33c2x6C9KQO9fmNb2llybGWyvbo8l1YD?=
 =?us-ascii?Q?tY30sj0fXJvW0A/f1CYOS51w4EwzdCZ/MyxYCMEptGkhSDWDxHv077r/rdqT?=
 =?us-ascii?Q?GT1H91hRdsloNtEpVA01/V1Ri4kno9T70XRg4cVW3697sZ8YZmlyB+3+Dy97?=
 =?us-ascii?Q?9t+96u0kB3ltCeg3Y8uoqVLrw766nCp2k1/RZdoa7bZcrm8goW8ocKTY2WaA?=
 =?us-ascii?Q?iaCoN//8eKPIfU88lWY3Y21ZSYMHH9vqLvHbUwr9yMfDc/hfNlh5YDDHTmYf?=
 =?us-ascii?Q?veY/8CYDSxxMVpyOzrOwbvwy8uz4C7X3bgvIrMAXC14tCNDSXHVaMcVp0QKd?=
 =?us-ascii?Q?V6M4r3AEMKk0MX1KbjaFVkvJRFb8yxZpwUCjrArgsFgNW3yLDHQaAmwm3nWC?=
 =?us-ascii?Q?Rq++HxVTM1uiYIX2DoJ0vsL6u3woftNICpLHuuWDo0Dbi7vU9qGY2oMLX2X7?=
 =?us-ascii?Q?xIZRNtR2eEJnRy3H+SjfGo9deHz65lDmK08VDZadZxQG1suvqDmjPdy5F+B7?=
 =?us-ascii?Q?ri4893c2Du2lUkhUQuGgpTqSzrjUyS1pFJpqqeHGqHBgH+JEhE03FgRe+1B5?=
 =?us-ascii?Q?vG8ef25kc6mPyvdKIDVd1d3tkZozitoKk0+wZjbUl8NW/BFUgJ9RxecNzTmy?=
 =?us-ascii?Q?8MvpA3bQE6tAD3C0o01ewnzNJ+/965E0x+AYdcYcuN1FkeNbDgL5fg2j2puj?=
 =?us-ascii?Q?iL6gTSwaXC9FKlPscFHYP+Cj6Jr63QeO8kpQ7QysKLvKGRaf2/c0eGInpNZC?=
 =?us-ascii?Q?VwVd0IO1mjcZ8ANNv7ppss2h9eiTNM47vcVkVJKAzJuDBspvTGeEE0of5qAH?=
 =?us-ascii?Q?Wp00iYRImmp2637SarzqEHS8+CCBglH3q+74RJU439oiqp0lbvJW3zqSdcZR?=
 =?us-ascii?Q?YhX0bxwNfnH2SEsh/4esAWILlhUq8PKdEIMCkB7ysqfu1HYK5VkMLzLljBXz?=
 =?us-ascii?Q?o2zYXWzmNckPHcrwsvNyOAnKfIK0vznRbt4RruW3fYo1vugQKH7jE+OOrlSh?=
 =?us-ascii?Q?fqZU+veoLjDCejRtKMxqdbSdncyG7SSCHQD830LAEdWOc9vIoCPAm6ujfn5J?=
 =?us-ascii?Q?9qOi1lLJwW3ge83al8stQ2lhYcf5JvWt3mwBuYRFyeUHeV2N/1urBMuzUQta?=
 =?us-ascii?Q?vK/ek50vGawdtuzdAcmiC9GO5muQ6h+lOj8J23XMdf+N4vOWwM9u4ZZh6jDa?=
 =?us-ascii?Q?voZLUu3qAYj3ExTed5eCfIEuo0qO1oi8FtvVo4mzPnb9/0FEnR7mFD6016GW?=
 =?us-ascii?Q?wwt/WezCxq3P8v22AMFEAM9siovBGj4q5LfKdv7W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb8357e-9743-4b96-348b-08dda9c91c7b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:52:19.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX913icqLJChBW5w5QYKlS49/YtjvH42Ic1iAtZvEs88f4O8tIGCsrqATJ6wunXLYgsY/gIl1ssB7Ehu5kWF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593

On Thu, Jun 12, 2025 at 07:10:28AM -0700, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 11:56:26 +0000 Dragos Tatulea wrote:
> > For the hypothetical situation when the user configures a larger buffer
> > than the ring size * MTU. Should the check happen in validate or should
> > the max buffer size be dynamic depending on ring size and MTU?
> 
> Hm, why does the ring size come into the calculation?
>
There is a relationship between ring size, MTU and how much memory a queue
would need for a full ring, right? Even if relationship is driver dependent.

> I don't think it's a practical configuration, so it should be perfectly
> fine for the driver to reject it. But in principle if user wants to
> configure a 128 entry ring with 1MB buffers.. I guess they must have 
> a lot of DRAM to waste, but other than that I don't see a reason to
> stop them within the core?
>
Ok, so config can be rejected. How about the driver changing the allowed
max based on the current ring size and MTU? This would allow larger
buffers on larger rings and MTUs.

There is another interesting case where the user specifies some large
buffer size which amounts to roughly the max memory for the current ring
and MTU configuration. We'd end up with a page_pool with a size of one
which is not very useful...

> Documenting sounds good, just wanna make sure I understand the potential
> ambiguity.
Is it clearer now? I was just thinking about how to add support for this
in mlx5 and stumbled into this grey area.

Thanks,
Dragos

