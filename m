Return-Path: <netdev+bounces-165194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34348A30E41
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295EF3A6CC5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8A250BED;
	Tue, 11 Feb 2025 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qqhb7t4s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B89250BE2;
	Tue, 11 Feb 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284319; cv=fail; b=f9lmSpx5sI7eql9eR73dcJEFSnXp0317oCIpy4uqroYflVkbInv73zCfHJnxJ9W31jQHUaqn0AtDZY+JTN6HYQQU/G+sekBKqQMFMauglfC6GkpHpgp1ui7w3GYUvHbj1GvhlIEtN1ewBaoXq6NeYqFa0Y+6GTu4h5tjjTITzD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284319; c=relaxed/simple;
	bh=4jKZCsKYUcPSFN+YNUQI+MbG81dznFurjwVZJbShZo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ngYTJdwD9QZ8weJTzet7RI+Ii+rsjQ+r1+IUpRh2q5JrXLWATlP2mT1YoelXSzTD5FWAbu9DQQq16QkKnmtNkJ8q+vkGTAKOvrJC7vla8FDGJn/Vbyq+eHlqtneMIEcVQ1Uy2SA6lmn8g92mELaHHhrNUymEbxIk08f3ImYUchs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qqhb7t4s; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aViAPLDau+t0FQjnbKBpfpNnBxCVNpyUxwNz5+3dx3ZRxbiZqklaElGMZYhLdjrv6gl5I9qbEFGLLhGRgjK4a7r8/+c+xL0oksmgQJQxtfgKaix7aktmcY0XXVB8EfrkxUk1Jq490m7YTZ20VR8+wEfSZxCVOE+ibJY5n0tlvRP654VuINF0XT3WEe7JT/5iBI2tZHkRju1iQS60a76taKHx5pkThTmSjONTZt5C6x6omZKkIik0X0EKcg1FQpPkKkGzQx/6ga6Rksbe5GKL0wzK76spxwfbHbeRtR8YaRYgvmyxBCjv1UQI3lnEKLAEtRjig3X5pKNKeg7TP1UozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjC/5zG7L42JSoWsNtkE7MFgxj9zEKBIA3UEzKwyoCA=;
 b=BECBgAfN2/+jKD/XEBWwXUGT8kOQxDXeXkLsGD4xooxSEtEFTJcw2v10grjkyGU0GyZUanaw39PMuCs4xC8a6wQG8gO6o6q+BXYMJu4l/LUCEMGiO5uYGmJ3y1L6/QDSV5/ya/DSEBDs/suM5ag+L7UPLLjLJMnG/GTlsCKO6gzSFXDv69+0bNte1Tx69U8JHNno4DEk39KqPVn24GEYnmQrLbt02bt9bxfTf0U2JC9lAok1Nvquga1IyBSyl6TwGbDzN33ZB34cAIbQwWz0PypBZhUI9vZyXDcA+uc7H1kecJXUuTKIBZfc9NrOBr57a2k4lRk+ADf1U2wJEknHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjC/5zG7L42JSoWsNtkE7MFgxj9zEKBIA3UEzKwyoCA=;
 b=Qqhb7t4sEey9bOvR1Uk6GIcizt/FOz2dcHLMU3LCJzblZl+Ih8XUU8EjAHwo1wJVFdrvbwPrjnKDgxdvM9PhJ8Wj5jEiPFK3Q1pFDb0BOtm5WjFVdzNHskHj78EXYYBFUReqht+03ReexXTFwMYUlqIxA/3AILGiSCz0qBYeYQKIPXyHISMFdaeKEyvBUsvruPutu0ai+ChWfua4zA0Kswe0ENqrs0cNLWggD9ExChHmf589HYnL2gMiE5QnKlqmM0IGXtIFRMICxcJHdL54GVw8/9t1pB0Bm0RrwqT/XlPMruHE8fYR7hWVAwQDylADLKRYdP1O3cwQFtn6dO6a1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 14:31:54 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 14:31:54 +0000
Date: Tue, 11 Feb 2025 16:31:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, amcohen@nvidia.com
Subject: Re: [RFC PATCH v1 net-next] net: mlxsw_sp: Use
 switchdev_handle_port_obj_add_foreign() for vxlan
Message-ID: <Z6tfT6r2NjLQJkrw@shredder>
References: <20250208141518.191782-1-ericwouds@gmail.com>
 <Z6mhQL-b58L5xkK4@shredder>
 <20250210152246.4ajumdchwhvbarik@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210152246.4ajumdchwhvbarik@skbuf>
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 494922bf-71e2-46f2-f0de-08dd4aa8d48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fybf1moQrCNkiC+a8PQS7JDILMwmyrbwNGD0W9oagOnpBYJt6/ueq9uNSqTV?=
 =?us-ascii?Q?DCweTdaXPo62D0SPQe/wIxSgHR99+I+WZlWMmbNo5iPT8tIRNGHxWHKkykme?=
 =?us-ascii?Q?50eoWu+pq0fhDjnddmjK+gLWX4IcBmST/k9iIoqKnWc9GKNPTOBJq0cedPdS?=
 =?us-ascii?Q?4+gEXrV0VK/sIO3QRb8wz/hnTA82pJzCn3VnxB/34s6t6jnQLmLQansjybL/?=
 =?us-ascii?Q?hQy9oaWwtrAViOtvBjN/Iuz/mhA5yIb2iCJZUcbDASLALtn0VkNWqPU6V+Av?=
 =?us-ascii?Q?njPCPSt5GpTawXUd+QaqunGDDhOC8QELR/bBvBNADh0e8gy12IYREt8oi3uW?=
 =?us-ascii?Q?5HxcKi3ORAtnsp8Z65i1Fmcw1LB4oUZp0P9nDp8SsAEMcvm7KYId3SVwKjsc?=
 =?us-ascii?Q?JNIz78dAs19Scc7cpAqgtOyOpFu6lqAgLSEN2LzlOS26yf0TW1V3Ff+4A8Bn?=
 =?us-ascii?Q?Vj93bXOmuLKIBsF7/YN2t/VmfeQyozgC0Ul2TkbMvUc0oAmu7O9tISlsRByh?=
 =?us-ascii?Q?mQjGLLf2+06PdCgLB5to0hNPrc0tu+KkZOt/z2WWQZkQ5OiDoLAPWJq0By5Z?=
 =?us-ascii?Q?C2aXBPua+AHLJWsqsBfTZYBb2th917Q4bubkAZJ52tf4L04++ZhsfWFICAGB?=
 =?us-ascii?Q?AzhBeXCvgtiiyimxIP3/Pnjgje+BzhSweZQCk7ooM9DPvdAtHOxdR8/0LjMO?=
 =?us-ascii?Q?mDdszc8X1Yb1PYqi7dF90DsmnplDWCjggKylHNP1VzzqB45VNn82uXJO4t3/?=
 =?us-ascii?Q?uYBRPvF00Q0LXy65He4A66jn8S/AlcW6WKHSP8yKcuyblxeINLJqeDfdWmej?=
 =?us-ascii?Q?qB2luHWsyXFl975U4RSM1H1uTIPFuFVsBZqG6B9zy8XfKamc+InzwlXWwpOt?=
 =?us-ascii?Q?HEwZQgHkAQ9aQdukKOagX6xq1vsPuFeuunnOZ1NZvPbyKJhctL0lRRw/Qh1G?=
 =?us-ascii?Q?Mv+pk57L/M2ViB4De47H6cSZSKf6est0QoBaGYVfQHhiMrlx7drNgW5J3lSr?=
 =?us-ascii?Q?Dg3UCmUJq2z08eMd4x+riUmt3gsvXzjTvAuR7IjOVK2eaeOpXqrFNf2gaduv?=
 =?us-ascii?Q?Fil0uchrasUWTQZhb1q05RA/dnGmOWtFestDzcU3UrOKx92YiCmP3PT9+MSF?=
 =?us-ascii?Q?7eJqgNgMod7ANZPObN7perVX2R4JQiN3gTbjTHkYDcYwISxuADkA2gc32685?=
 =?us-ascii?Q?wzcqlqWLg/uEKCQ51Dsas/qdd6FhQiJLp4cCLpvP2ZoSb5+DnGkdmySRxqpp?=
 =?us-ascii?Q?UsqguxWqOTR7acWgSxWzn/OdcB7Da7ztVFN7UaNqe3nw4L3pqwfokWmDRSEb?=
 =?us-ascii?Q?CLh3ERHWbR8BJLRXaSYOTkh6KvXfkFJYh3GI4levae0ApsBijxzwLbqqC227?=
 =?us-ascii?Q?N45Kmq6ylbYJCQKTocHmFURMxZXs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5vL+UVp7qnl5Sja+YMXarqdXYwguZx7hTz5sbsv+QmvYbAPxxVUijIuVM8H?=
 =?us-ascii?Q?zQNxharZn8f0FtbVSzrt577PGS4lVgLU1Ls4lq2+2tBpT5mMmy/dZ3EbK+P3?=
 =?us-ascii?Q?PQvcz5FXkO6L+kdUV9Z3Wu0vTaQ5GxtuBcuOUiIFibxmaCCTwGHjHC3rgsrK?=
 =?us-ascii?Q?p+Ra0QXMEEkD68y3WUl2D6RKWC4Okpu9xw4fZk8x68a4jGce0WfBU/s83H2C?=
 =?us-ascii?Q?t8A1DMbegod81Q9wwDJXgcPrw/SPgLBXxFVpQj2mL8s8A/IqXNK3COzkCjpS?=
 =?us-ascii?Q?GCZ+h9UdpDhn8IsEr3X47LAkZ+djKzGaL12FBakpMKl2Qi1X4SsCfpRGbwFx?=
 =?us-ascii?Q?zR18gn2F8IJYU4lIDissQLNln0e5p1XDFgbZIMADTNzN2zJmmOnH5OXAF9Fa?=
 =?us-ascii?Q?9WlJG6yXr3hQAhKLWzsXAOBF/yC6HAeN77Xa2d8psrXLr0N3IW9DRxGpJTPk?=
 =?us-ascii?Q?3YVEuM+uE7tRoebVjwT5ud6GsJudcYkfspuYf8DgrHCQGjAhKSKgob9teHYF?=
 =?us-ascii?Q?9t7hLKHFnrMbPVfmFlSD8Skxklk9Wo0yo1qlw2R4oSnUTZ8/MUPQzK855508?=
 =?us-ascii?Q?NixtG4nRv+Xiy/2lahZaccjNE2HNy9bkPB6NySStqh2LNO/FElbzdeQrFK5k?=
 =?us-ascii?Q?nHzimqMwcWNBLxua+zJjtE3wwwlZvcbNO1io5h7z4/dYl1Fl/2TFr88YiDs4?=
 =?us-ascii?Q?PVlXRwbYlD259lR4DM/gx5ykx+YDeHkUmJ86GJRcR/1KqwFuALRdY88K3qvy?=
 =?us-ascii?Q?LqFo6iuoSi0wqNv1rYYha12xnec5ym7oBH9MWWu6gjPm8xesGep2xqWLJ/Ui?=
 =?us-ascii?Q?Gd/mTAdd95hXhiz8S6FaUSPMg+G84HJzv3lxa0VT/ELOqeKkEq+Q3UkgxMk7?=
 =?us-ascii?Q?2OJGHxeMuidrXx8ATQgYMkazjRFhjIuEzxTTgWRkqPh72guwd39yQ8YgXtrj?=
 =?us-ascii?Q?o6ZsmAKcCsybdP1ZIhPM+TwklxANhb9117YPiNHNOQZs8PbR9/eKJTtsKjIl?=
 =?us-ascii?Q?NttfD0XdxcAfXOZnpNNI0PZGmyprm8SoD6uQvEmJ9ww8mUXwVFf0It+22ZO0?=
 =?us-ascii?Q?w0Ip32wS3wvrMXZbT7qYdm/3nDIiMcLMnbFjqIi2DtxPgPeA3Z3wJhZ8kdkf?=
 =?us-ascii?Q?ICry4iwpjMVOga06qYmrOEGJ+3JG9yhdbCCEgS2FzuDKsm7L54OTUYL0JVQo?=
 =?us-ascii?Q?FHCEjh86DmnFjw8Kz/LUyOYrVsBOhblPONRfRtoHOvB750kJFtyVARl+c0Cj?=
 =?us-ascii?Q?T0buurlo32osTI47MABd+igmZQB2W8nc2D60hUMhUQRRwmWEsndkG2kWgFA0?=
 =?us-ascii?Q?HbCaa0s8dNhLIupG5nCP1KYuH5WUd7GxoX9eWA7J0j8oTepRRe056tUG4oyP?=
 =?us-ascii?Q?tbLhU70oSPYDubCF0grttn6dv5Q5xJyXSe+G7aC+rGcR2r8AItrowR7zhI2H?=
 =?us-ascii?Q?wKQRT+f6i4fZHkph68dn6kOnZlxNQATvoFdkNICK8Z635xH3wkwvVUJ0QBCd?=
 =?us-ascii?Q?VJj3qrP88FU/Ria05+LCpQMff9SXf1hYTuh9FQWdOCIVZErixbmPwl16RpLz?=
 =?us-ascii?Q?8xxCxVXJdAnuZcbi8FDDi/yj3gP2ew8dJhRpsVLX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494922bf-71e2-46f2-f0de-08dd4aa8d48f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:31:53.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ijt51X0l0yKWGGjRmk/f/6T3XzVC1G76/6dFeJHNrpFIdYh4Zmwd/V15+zDWO2NoNspXXEOEDVkJKNjHPqi28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

On Mon, Feb 10, 2025 at 05:22:46PM +0200, Vladimir Oltean wrote:
> On Mon, Feb 10, 2025 at 08:48:32AM +0200, Ido Schimmel wrote:
> > On Sat, Feb 08, 2025 at 03:15:18PM +0100, Eric Woudstra wrote:
> > > Sending as RFC as I do not own this hardware. This code is not tested.
> > > 
> > > Vladimir found this part of the spectrum switchdev, while looking at
> > > another issue here:
> > > 
> > > https://lore.kernel.org/all/20250207220408.zipucrmm2yafj4wu@skbuf/
> > > 
> > > As vxlan seems a foreign port, wouldn't it be better to use
> > > switchdev_handle_port_obj_add_foreign() ?
> > 
> > Thanks for the patch, but the VXLAN port is not foreign to the other
> > switch ports. That is, forwarding between these ports and VXLAN happens
> > in hardware. And yes, switchdev_bridge_port_offload() does need to be
> > called for the VXLAN port so that it's assigned the same hardware domain
> > as the other ports.
> 
> Thanks, this is useful. I'm not providing a patch yet because there are
> still things I don't understand.
> 
> Have you seen any of the typical problems associated with the software
> bridge thinking vxlan isn't part of the same hwdom as the ingress
> physical port, and, say, flooding packets twice to vxlan, when the
> switch had already forwarded a copy of the packet? In almost 4 years
> since commit 2f5dc00f7a3e ("net: bridge: switchdev: let drivers inform
> which bridge ports are offloaded"), I would have expected such issues
> would have been noticed?

I'm aware of one report from QA that is on my list. They configured a
VXLAN tunnel that floods packets to two remote VTEPs:

00:00:00:00:00:00 dev vx100 dst 1.1.1.2
00:00:00:00:00:00 dev vx100 dst 1.1.1.3

The underlay routes used to forward the VXLAN encapsulated traffic are:

1.1.1.2 via 10.0.0.2 dev swp13
1.1.1.3 via 10.0.0.6 dev swp15

But they made sure not to configure 10.0.0.6 at the other end. What
happens is that traffic for 1.1.1.2 is correctly forwarded in hardware,
but traffic for 1.1.1.3 encounters a neighbour miss and trapped to
the CPU which then forwards it again to 1.1.1.2.

Putting the VXLAN device in the same hardware domain as the other switch
ports should solve this "double forwarding" scenario.

> Do we require a Fixes: tag for this?

It's not strictly a regression (never worked) and it's not that critical
IMO, so I prefer targeting net-next.

> And then, switchdev_bridge_port_offload() has a brport_dev argument,
> which would pretty clearly be passed as vxlan_dev by
> mlxsw_sp_bridge_8021d_vxlan_join() and
> mlxsw_sp_bridge_vlan_aware_vxlan_join(), but it also has one other
> "struct net_device *dev" argument, on which br_switchdev_port_offload()
> wants to call dev_get_port_parent_id(), to see what hwdom (what other
> bridge ports) to associate it to.

Right.

> Usually we use the mlxsw_sp_port->dev as the second argument, but which
> port to use here? Any random port that's under the bridge, or is there a
> specific one for the vxlan that should be used?

Any random port is fine as they all share the same parent ID.

BTW, I asked Amit (Cced) to look into this as there might be some issues
with ARP suppression that will make it a bit more complicated to patch.
Are you OK with that or do you want the authorship? We can put any tag
you choose. I am asking so that it won't appear like I am trying to
discredit you.

Thanks!

