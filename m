Return-Path: <netdev+bounces-182589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4EA893B1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2274F1776DB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64F274FF1;
	Tue, 15 Apr 2025 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fwSP2Y9s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E5190068;
	Tue, 15 Apr 2025 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744697466; cv=fail; b=POk6+4iCq2ob3//PwdBD/4UBDJhxtNS3f6iRuqL0uNwUuYwO/G0XBUJMmMV4HNF8D72cviixFISgwEpRmOyq2DWP5OR4YSycUlTG+NZHS0agsbb8O6wysUmJFzRa1fzNsnNHnEgR/enX1GolhdzNmhnofrCJ4q+38gLI+004Btk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744697466; c=relaxed/simple;
	bh=Nj76koej/FqNhWfM1V7MSDNuCp5g2UsQipRruOwLxJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nIyKKDp2nhV/McY1HCezOQbt5h1+/LFbyPg6oIUe9LojOQ/+PosOalwYMHHcIeFg9g4O6XfYoEBF6AXKOkAOiJ77JV/c4t7mYPewHzwNvAlhlWIgkwWYrkRxmi1KIC/psE1awBWQ8WthofZtg3U7cqdbK/An+jKi6sb5kG6/aRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fwSP2Y9s; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/KKpzHTj91bhVGDMGke3T2a/law/LxhnRApP7kJMjugXfnlNchTBzjIDYd8Ox3ihwGuuI+VBPU6pSupAx/7xiK4PkaIej7xnmpP90YAGSDzVT5+fUVqFg9i1g1tIGS5P/CU7eEZaiCEJhrzogQQyPrYrm52ZhcPGFCv0Vo00ovESB2BlcKQS4OQ4q0LyBI/GoMlnLCiIOF8zjetvsgaNoLxCHVf8jUaNi+8jtWbotnQYYPhUvYHaFET0e5RIV13M82n54xqUKs2lPBZmBR4TwtxwCPpiVXA6fVm33FeT/XarqUio4lviS2qbw2QI8Dy0GXn5JZZWjcZtuofZ9RRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALiJhXR3BuL6WocGlhH9GX2tkIZ9J2PlRX30DnK6yvs=;
 b=O+GokjdEUH4dwhwe0MJ0csvzFVlfzsSSmzlGXPOBXIog9kgSNIPfMWmTbwR/ljp5jA8+UD6Yg0otFap8WIKupwIT5qp5BJ7dwa/zu+7zQVggEcU4+Mcu4AwhFx9+q0jkgbVFcp6Zref9WPSs8P+0E6bz8SpX33hPgv8CZxyAjljs1is+A1cizcadpNPuKjJiLLzYcwnN/RkANlRPYl1wYGlQuBkdhU9y8o+6GjuMbb3f0hf/zLncrhGysrcsuK3+hM/JX/1InG2DOrT+7XV23hQTomUpuVicKQ31e6nAVviGE+Uo1x3O9f6HhU37QwIu0WSBe0+o35oKpvQ4HpUBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALiJhXR3BuL6WocGlhH9GX2tkIZ9J2PlRX30DnK6yvs=;
 b=fwSP2Y9s72mTmsS9eEkokqQt5iFy4Ocrqf+eI+stiHUyXkmgxns0xG0s5EqfHZAc23l2GRAGb9uo2vz+rkHavajJiWPSnKybwoYbH21xj5Klim703g00T8OAm0dpbp17HGPQO8Pe9U95Y3w3CudjUivV9X2DhZFFM20j++OlPTZTdDu2s23sdRiy1fFEf8uFQHvIrnM2RRqzoC5ugfR9jNizvtvEKQU29YoLwY5PeetdJIA/HeQ+qzo0OPyRJrWXomcB9bFvD0v//TjsgmF2/h1WMhCyfvkldh9QkVAVjEaXtpph4E7x8wgsmc1Odj3x4sgNyFkLBUpuoSlEIgxgKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 06:11:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 06:11:00 +0000
Date: Tue, 15 Apr 2025 09:10:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v3] net: bridge: locally receive all multicast
 packets if IFF_ALLMULTI is set
Message-ID: <Z_34arGmvmWVHbPu@shredder>
References: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: b23e4eb6-e713-4593-4e55-08dd7be44b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?boQNojyLrIIs0PqFmkCOJAAoICWI/fzhpNcJv3o5lN/uDTbh6yX/dxvd6XaG?=
 =?us-ascii?Q?IGLqo1Fp9SfrOYPsm/WuHT0a+jaxi2XTqDsqtC1Jv0+q3B64VLxPGqGuOdV9?=
 =?us-ascii?Q?gLlRb5nDcXVglQmRmEHSMzw3AcllLfK+0RHGRZHqMeeT+hkbsxXvMzNnua38?=
 =?us-ascii?Q?8uVKQTRmroM1Q2hJtvlcorzhfba2ESG1AgxmdGsbuLNI+wAgVBvwU60m+Apc?=
 =?us-ascii?Q?EPvDbTt6Q5HmGEvvNzyR0TikQwq4qkI0FaMSPeSa6lIuvaEawTS6XKb+iD6e?=
 =?us-ascii?Q?2jLA4nDo+rm0JIfUlt1j8zaIjX77bfAoODh2AiVtS2uf/hAYxf44lpU9MMuw?=
 =?us-ascii?Q?vTgn/HuZHZdBEov5oZph7WeWeZwNw5mV1xreWnsGEO6aYcpy1oQLbuY5BOKX?=
 =?us-ascii?Q?W5IW1EnHRmBSSY0NHvaN+FfFExSA4NQRMEbCwuaeCFMKQ9/1UkfTW33MfJmC?=
 =?us-ascii?Q?B818TbrrIMVZYCkbl/O4H7PXCix6lIltuJBjlkxE1awckiIx8V42uuuD60jb?=
 =?us-ascii?Q?6a5bqSXVjoIAx1wo69nHajowT6URjGAD1TWPigx3jC3sJkbuoLZO7beQ8Zlv?=
 =?us-ascii?Q?AVe2mljTRQiGs2aSNQbwBi0n216cMyjK12xW91hMs6I2i9YqHtrKjwc7J4Ik?=
 =?us-ascii?Q?VUhQ5/NVX4ovtS4HjtAv+jBir2dLvn/NqnyxUUGGDkJymv3Mxez2cTE/sW7Y?=
 =?us-ascii?Q?KiqPcfEsK998o/oDkGp0SWJMNf32ni1IvUhQVaR5LrRaUgQMP9CGEhUhRIRI?=
 =?us-ascii?Q?/DzmZgGohEwuXtStoVGTnSiMMKrG37GRS3to/J9AMZqGz+GBiiiWJ/0SAmLJ?=
 =?us-ascii?Q?ChwAUcsXt+hNVdBKdEokBOujPzIth3yz7TW/P8cv35LWpwVVZLqDSomEvdSM?=
 =?us-ascii?Q?JBtHJf8OMkV+mxhOjRQFJJWFsA8owVZ5ZcaOIKQ3Yxxf0I6gY34PQqQE9g+P?=
 =?us-ascii?Q?WpMD3nK/os71cHp8CdEPtKSg1Csq93JzakRTCMCd6tSno4V86lVk5KL5c6uA?=
 =?us-ascii?Q?VmWcBfc0CDk5qv69MITXbIZkLujkMsgxYVZglxn+/V4hDgPbKy7cZp4PTk9G?=
 =?us-ascii?Q?+/gPgRncmbA/3fEmfBou+syM0SvOecRUBilaHn4UzBUYSeiD57YQTPH/A7Ak?=
 =?us-ascii?Q?Wm2FEMMTVDsxBCegF82OKFN7KwDcPMGGtroqWnqev6L2kgYEFnhYfANxZCnE?=
 =?us-ascii?Q?O5pTpQgpm5RWMyTLM2CGPJyPpQ5o9RZWXMwcXEVni6MBWNawc8DpviwDi8xJ?=
 =?us-ascii?Q?pjbaqNgQXVsaSpskQykdB7UhisEz7rEeTCpjzvwBAEQhgvRPJigraP1+Am8L?=
 =?us-ascii?Q?pfNnf1Fg9/hSQPO4CqYfSBmpELTqsyqcGSkllcbOj0zMQ278SbZmQf1voE4X?=
 =?us-ascii?Q?VUNvxjVItDcPG8fiHuNThu5O8oyzs0E4BX7sv4emKxhPD1g3+P/ezxt3zcIv?=
 =?us-ascii?Q?LV8rnjmjd18=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebdy2ZFBDrn9qQTnWk4KnD3BK72RQnHWbZVBxbhGX9CaMPfSB9tu5uc3S7gp?=
 =?us-ascii?Q?DIw1kkIPVDQIFKOepijlvbYB50NoYiksX4N0wtdlBGIXbQUy+Y0N7iLLsnmT?=
 =?us-ascii?Q?kEiBsKdEMcVtIQRQ9fDJYIXLb+Xfte3Kpx85RcLKhEV1Q7UvE+hN9/mRAXK2?=
 =?us-ascii?Q?+qGw5HnEeoJQGTtHDVjt0rqpUDJ3Yu01UuoYKt9KAVj38ycAxCiFInTY/5a/?=
 =?us-ascii?Q?4XVg8ASklyZYLm2y7YB52LKeY0d0EmsriocEZD8enZOEOFqeXMWFyXnQKCoQ?=
 =?us-ascii?Q?FCNRBcVL4hoQ8OuVHyrqKy6u17YEzb5UeF5lIPvJtSynnNhFfGKrazLKE9rn?=
 =?us-ascii?Q?Zmx+Tueaj41oZH3YsWqQYtQfU5EqWKSIiLPld/biT8XAZALiHvrdCRk7k7lY?=
 =?us-ascii?Q?ATDxGHRZNXW43a8/GzHHkhvZ8l4YiKRZGo6ymH2LGCPUBZcs0C5THgBr7HUP?=
 =?us-ascii?Q?1a/lSAoiWbhwROW3Kg06nkcanGi9OPatB585B9DozhLVpCCqycVa4aNKblLK?=
 =?us-ascii?Q?OhMRVa5/MrHxj9IRS2vzpNpRG98Q9UaOhB2Osp3ZUyi95PXFfZvz5ink28yP?=
 =?us-ascii?Q?jeftfpoew2o8TfcLaWTLrS3mXyL+lcwxNKTfeiPXNsl2UAkRmXlT+hT6Sjki?=
 =?us-ascii?Q?/4mqv0nyc2wAod90pfN7wr1EleQD9Cy4+8Hl3vPTLLo6TVYIbDT1WtOuXcN6?=
 =?us-ascii?Q?H485SzIJDwGi1MbinEvNkXocMyOx2BL6xZQ1n1ti050Jz2u+5R3SiixFiovn?=
 =?us-ascii?Q?w+p2xE5pxpWz0A2u/4GlajsFvLInJ6iUhaF8hCMVU4KnPp1MtgjtsyDnE4k9?=
 =?us-ascii?Q?wj+Ju0Knp7dBE37h/E0ghACyMn33K4xaoJr5Cn5tl7Fz2AXmTePh/xvpPYKX?=
 =?us-ascii?Q?YFIBA7ia/D659bkqpiApOhZpELoihn4n//dgnSoPwm6H0fgU4+FsXPntvlCg?=
 =?us-ascii?Q?uSV+yg8zTx5ROfgI/KV4vPadNo1vjFYqeXofuY+y3JP+vngCR34H4DsOBfOm?=
 =?us-ascii?Q?0STp4fg7peOChsSmAHA3kP9WkALRuiMphEzwfK8kYTinUl0f/yD88Ud5hRO2?=
 =?us-ascii?Q?EEhoe9awP7lZ9D1nIwbKYFwKWavPLIMIUMRCGreWxjaQBRpqWTt1ud9NcB95?=
 =?us-ascii?Q?08grlWwFTz7JJL5f3AeQqwoQTlt0OaQHOpTT/VE8byNHk1Bm/oHiaVstjlh+?=
 =?us-ascii?Q?CvUXPp19ASTMJbWDnouJLH0j4LSMxoW8mlNj3lxWOTSOR4vwfqHsawjsGGao?=
 =?us-ascii?Q?ACaZxVhvuurn00c909mrJxI/Vq5xOJA0IlvHA0KHFRCr0oRRIBlugmZh8oQ5?=
 =?us-ascii?Q?epTzxJcWs+4ISM+emwBTT/TheHd13VsKUUyw0sktPkqfxokM9lwgFnA9HHPA?=
 =?us-ascii?Q?Zrwt/PS9McfzusT+NGty+wlLbXcDDnhlS3r8oBEBSHbM/FsUZ+8cchyAPMTm?=
 =?us-ascii?Q?0qsy87DhvjtiEzKqM2h0IBcy04Kyxsy681uZ2XklnUDeLDz9DsffNfBvpQ7I?=
 =?us-ascii?Q?qCDcQgW1MVcqmuClyNKAWGIhZBPcN5XiTJ36PQY8qVPJ/bL1f+N2sbdQ6lz+?=
 =?us-ascii?Q?lkaGIR113EhZsOzWPLRI1rq7ztXzajpthcTMJwYj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23e4eb6-e713-4593-4e55-08dd7be44b37
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 06:11:00.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiIHNibt3tdrJDIJSoOMf6Dnqpi5Nz+K5VMW2CiAdNb1OZXUq3W0wIHSO0VHumWfBlEWobRVmY7i83TIzG6Utw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148

On Mon, Apr 14, 2025 at 06:56:01PM +0800, Shengyu Qu wrote:
> If multicast snooping is enabled, multicast packets may not always end up
> on the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received
> locally, let IFF_ALLMULTI allow all multicast packets to be received.
> 
> OpenWrt uses a user space daemon for DHCPv6/RA/NDP handling, and in relay
> mode it sets the ALLMULTI flag in order to receive all relevant queries on
> the network.
> 
> This works for normal network interfaces and non-snooping bridges, but not
> snooping bridges (unless multicast routing is enabled).
> 
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Closes:https://github.com/openwrt/openwrt/issues/15857#issuecomment-2662851243
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

