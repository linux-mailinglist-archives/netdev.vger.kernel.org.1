Return-Path: <netdev+bounces-167450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9410CA3A50E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4591890F99
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC426F45A;
	Tue, 18 Feb 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3P8tzoe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736026AA92
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902564; cv=fail; b=fUmh2F4QJQK9AbqyuCCPXbkDUag9EaTD/5P+B6j7TrFoIHTLRWHqR1krBwFSb79Rx6JHEYpR7whRfciDBMaZ4IaCjnJ74ZbfdFVcd3P9nRH0M4Wf+ywLJgta/53Pu44Z1RKlqNgN5E6sOsTw+QH2uVG814X5jba9K6xTjXk24tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902564; c=relaxed/simple;
	bh=4uuZWYrQuZ1ZfUro9rmZE2GTTFYNO+MKPBK1qBzhvYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nsJkIFieRs9Z1IjQdgLHGJ5dMxCrSxUmYqpgns2wEf9CTQlbyYvHyCT6Jb5gnKvFeitanoi7n/UANC4N5GXp1OigCyNE74DfxWV9fS6FN07JxEGixkZ+Zipqk/NYdP5fXvPjEOdnvkp8F2N7n9/q8TBqx1OnTCPrZ+1CEGGwL5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3P8tzoe; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeZw71nt1gLhcxQh/zCuxEpzoxy8n5epHaMzmXsyOp6CYfGupXCWQ5bAgGqTt6DM0knoSHX9sUJjGzZbZAiFRG8l5nZR+0SJ2RtEm/OYGTSJevaeydRffhVt7zy1/cRRMx6tyShMlpeh+jV5mzYY2nCli+Bo9XGj7dJ3H/jNuiMqo7qlWKLjeDvs4Lp1/PtGfq4U3PWgsQzaYObpB3hRLrjFSgX5yu3sPYnDEds0KJqLmXai5gVwdMEZErkcS4euSiHlmHKdeOCxYoRJEGv+AXLZIIheWjr1hTXIvntc19xWVW41QNmbCbci3dGUG+pIldC0Ho/0XyEhcDe+XW5VqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOvMmwrhDhpnEIm5/jJU25q5QSPZlRNjL149fsYV5eE=;
 b=HWrfifFgb/Sgc2u42ijOIqwIJ7U62JK4snmhxZdL5VR3PfxKL8jLaFiGVfXRQdGDt3KLovM8lqTke1QZ/gmIixxNwixfmpsAOEkVIAyFBwMl6NnRX9WV0gj/pgK5L+XUHhclMT0NQUb1Kvf9K8gIMpH5REr24F3NfCOMVsGMaUdg+VFzeTQMppb6Dwdwtxr29d3xPgXQXi/Rhryt/c+SjYdgXHz83bsdBJxokYIum7fr0ZlFk5zD6ate3QpTYKbhvslfEfLtSiIYaNuJw58Xc4x4UI9Qb9dylhatgMok9UCIDc57HGcALOEz6jmCVTzVW/0a/xdy5JICrgZgy+4HFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOvMmwrhDhpnEIm5/jJU25q5QSPZlRNjL149fsYV5eE=;
 b=B3P8tzoe6Xj96dcjU0NQsgpdjditY+fu3rWqWVYX7sr5W2Kbsq7zdRs7V25FQSFKu7OPHUKXOWtv7DJHysZzZ6KQkC17wGmygqBK94xLQkg2EXXLwiOBjS4khwKJI2vZ700WtkcfRX4va+XBLeFmShxGtGOKF/0g4dmNOEEZu6FkD8EwRY9hfQFSb8jELH4cKnVLX6GS/Q8Jq/BCFQKmsp4YToBi2uFbA7efgWcfQiYBTOcOUlHtfAV5X2YJLOdtLqy78A8NFOfkylLHCCj5KPXSa9vd3t6PULTXFHAP2DY9e3ocVdzVswpBNGIuR+VjRrE9Qv75jE8NuJjaEAXZPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 18:16:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 18:16:00 +0000
Date: Tue, 18 Feb 2025 20:15:49 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	donald.hunter@gmail.com, dsahern@kernel.org, petrm@nvidia.com,
	gnault@redhat.com
Subject: Re: [PATCH net-next 5/8] net: fib_rules: Enable port mask usage
Message-ID: <Z7TOVUyjrric13aw@shredder>
References: <20250217134109.311176-1-idosch@nvidia.com>
 <20250217134109.311176-6-idosch@nvidia.com>
 <20250218181523.71926b7e@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218181523.71926b7e@kmaincent-XPS-13-7390>
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: a34dfc25-92f7-4e5e-1f9d-08dd50484c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJEfLyRbBJyuxvE/IPcQtotw55xzR55pGHY+CTKhaOQygtHVskqddlVwD6az?=
 =?us-ascii?Q?SflQf4gV1Uw4NE61opzyF+LuQDibZd61m6yCv6Xuyeq26NYHE1yElwOOIdST?=
 =?us-ascii?Q?75oCHmDvbY3o3Jyn/p5K4OeSHwxTpAEnRsezXh9Iki9nzUx/IsEWq0wphe9T?=
 =?us-ascii?Q?7boSF+qZo1NdMgExQJ5GIXRMtjWdsPol6sFBOcJNWezc9dS9cyMx1WIbHlh1?=
 =?us-ascii?Q?1AANkzbhRfhwqG3NsY+adpsi9bXHcJbQ6N+rIK2st7dMMCzP+0OC63J0ZSxg?=
 =?us-ascii?Q?q0xSZ7OaXlv6HDEpEPFn4Y30GUAJ0OpFfs6/WyBBSU8HaPC9uMSfc11cojHw?=
 =?us-ascii?Q?pJlIq9AiOvNWnO1xkSe1gNq9ok8D8cZYBAe4iDUqDmbl6tV0cyVb01z2O/PY?=
 =?us-ascii?Q?D3Co3gEZ1nzbjAKik8+zaAoNxcSxg2P+n5wrPyS/w6FE9H/Far3pyRqgJ6cb?=
 =?us-ascii?Q?lI+93R4WebDqeL6oLKPgbcpwWU9FFW8iWPISiudf3D5Orm+NckcVWbg4Vcyp?=
 =?us-ascii?Q?Zc+U27qk61r9/Zyw3IzmX06vVIVtXM1M7zv58Tk1tERXACU6ffmemkqilo5p?=
 =?us-ascii?Q?526O8grqxO+W2VgJsXEO9TLuZsMK7vUufTexLB26hdapa+ExOu1zNQCTV0ZP?=
 =?us-ascii?Q?r+2++vWGNCIJlOZBeohG/FDc22iSpJ8PDn4W7AiO5AuUXaKc0ngBuBDphl8T?=
 =?us-ascii?Q?wJeehMcvuH/HW90T16l+Vdg7RYKnpZjlzfIv8zM7mlTXi7H5QzrmGodI7VoH?=
 =?us-ascii?Q?xfoWDvZBdce9x1GQj3fU1uh5ET1D2N+ergb4s/3xcWmc7yp4aMd7yc3rfvVc?=
 =?us-ascii?Q?yfNw2jii/zvO0vVz4iqnSh+WQl6rMrrauZnIrc+9IjE3AMoizECFuyg3FyJ0?=
 =?us-ascii?Q?83dOSJCrIl2egJ39bkNBEUQe4dOwzKVAeu37ndN5mJnnrKOx2hOjnMxQ5qSJ?=
 =?us-ascii?Q?D4p/msFjy2sxj/+rjYMp7xcgAvu+xDdKlX1sYsCGIYFPT7ob60XcM0fWwkTZ?=
 =?us-ascii?Q?tbyfDzoTesP1i79sSiImy02rkZGHwmaGk5bcwwM0VIfsW5eUggz7JzCe1GAK?=
 =?us-ascii?Q?RCk6nLCNJgJIglzvLdN0+ocQbXRCqlekxn06hCU27zySRItpCsFWgqyQXysM?=
 =?us-ascii?Q?BAX0bDfqFxUJgeT38YxIx0NSsEBM/vq8ReAcG7S8ftvVnv19hwpxCeRb2kAd?=
 =?us-ascii?Q?V1Ozx7Pw1JcRFrwnkq6uH89xTII8ji+NHrvtqDq4vZuamCI3urWhh7snpXzd?=
 =?us-ascii?Q?7qCM9v4njmA+YDSidUI1qbYFpWu94E/NSdz7BTIKk0h5zfBDhzlorrLQd01R?=
 =?us-ascii?Q?C0sW9cGhuN4KGVqbfAC0xlgP7v1GX+t7Pq+NeKxyUZPh+8VkdzygdWZVKDXR?=
 =?us-ascii?Q?2qL+5bbRJAlvHd2Q8zt/bwr9GsMw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2emICWRwHIZp1sKkyFp6yB3rDyW2g4BtubPbgz0qrnBl/4Aawkl3qYYyItC?=
 =?us-ascii?Q?lgHvJYeNu/AW4j+IbCR6LaO4rzU6zMYpbwbqwuz+u0c4osVSTHs4cW+iXV99?=
 =?us-ascii?Q?jpc2rrpVQtwF7ZvHitc7ZvKyKFUNR8toLDjxUx26/l9ZyR2SLinPVrKJRzuW?=
 =?us-ascii?Q?QpmqLoc21LrJvWr5pYIuptWWYxphWiyIOqR+69D92Y/T6iMZaWN4MoR5I9DW?=
 =?us-ascii?Q?5i31dFaRc7Ek4j6qB3WrvgvUE0mIAcYcdAutBbVBZC0WZ6KMUD0ZtY326uuk?=
 =?us-ascii?Q?5Ci7NXGJ0STSTCPQcL5FhimLZaEJIQvEqw2lPaUGU5VVoYVRY5nGCQdZiqqv?=
 =?us-ascii?Q?2edJ64Ru6Z+3nWnA2mtmLDNwkyHeZDkcCLu5G9CoyVpjEUFPZbu+xrGYaeDK?=
 =?us-ascii?Q?ttvIt/kXYsrwzW+Y0t1X/vXdY8GZah9MKr/cE50HmvZuXB8jhC9OtJQxr5j6?=
 =?us-ascii?Q?All2WBsZjzIMF/hexfX8aGqR0hMfJ04cg0jELBVGytv3d8/2/vkrhXmsPz+b?=
 =?us-ascii?Q?F9I7Fq6QfK1nvobofUtcjsWpZJqVMQUhQ2/+B9ZfXcQXtynZ4pG7kK6z3Ish?=
 =?us-ascii?Q?hBhy+TocKOS9C5mmwXkIUxe68CO2s2mMnuVYcrvR5tXJO5HlfXJxtbZlOGT6?=
 =?us-ascii?Q?3fbOn2pr+Uq5ZfA77c15hycnYxel9X6iVSbTokLzg8CPJinOV0ARvXxquvtX?=
 =?us-ascii?Q?GRDpV2/Zsd5P/sP31wzt4VqXGipQxlSJI6YP+ZRNX7TaBSiOCe9WuxgUDv1m?=
 =?us-ascii?Q?5mwbDy3hPXhVfUffMYCsTiimZxNxWVPC7L1STMXJeurmCgtiCPteqCtqigsf?=
 =?us-ascii?Q?M8Ay4WRNjJ1AMVaxat+OGbjfB28mWTUtzMzAuDBKhQjcVLkcClEO4OJTyN+N?=
 =?us-ascii?Q?wI4hg7nSZO5r7q96eNz1xLVa5/gCCnlMCJmvNoT0P1XXiE+7O5eq2mGfRd4+?=
 =?us-ascii?Q?ErhnRKuGsPOkYBA8kn/OiUghW2HOjvvdMULQM4DYTvRVyCk2fuSUgpMx/gYS?=
 =?us-ascii?Q?a+pccrrYdYkwlafUcBprympXzzCmeraLea/q7dWp9ZifdVIXDNTpn/RId8XI?=
 =?us-ascii?Q?UDA4dKlWNcoKyWCC2/ljUjIbBdt6D2+drW6x1Se+ioyvxe8wgD1zT7wmh83N?=
 =?us-ascii?Q?Pb36WdQXK8XPDwkkMPrCdsoO3fUF+b7G9aDbsDs4ojafOM3VITAvYLxpNz/w?=
 =?us-ascii?Q?6H0v+vRLIUho9L5olpU5ir8mEQseK1jX5mMjQxyK5xiagggPgdFzswEHkp8V?=
 =?us-ascii?Q?sZWbkGBWj2FCE3VbSO3eCkbev4SsVgRkxHTbKFpruUEW4ja+rJ6n6jXBSvEK?=
 =?us-ascii?Q?MZkK6B7Gw3YUxrkSy6hZqw4+wRahPFtsYNNffJmIRj4JKIowLqCH8C5a7Qry?=
 =?us-ascii?Q?Hdb5/k9AVi6fEAw16uJxVJ5Cz6vLhaNJdqvy8ebTHwd0HPuJU6Hfs4cQyAmX?=
 =?us-ascii?Q?gCj4OYCXeKqDI0G3DIrhNDyDwskt98TKlV0eWP07ObQ3Ypm52Arv6O6v35dV?=
 =?us-ascii?Q?RFUQCk+fT4f6gXcm8YBHPgRzwo8V1ULI6R/IzCGX8Ez7Qek76WWZOiYxJLr6?=
 =?us-ascii?Q?Sg1+dTa7LdI0jM0AaXuTbCBd7ZVDfbvM9WURqPNL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34dfc25-92f7-4e5e-1f9d-08dd50484c0d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:16:00.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zaekIljMHUlfpP+IbjAGkBjbRMkCchqmqLcGub500gYPrsMvFu9DMXekkI3SDIROJdqdaSzuzRR5jvyLfXaVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

On Tue, Feb 18, 2025 at 06:15:23PM +0100, Kory Maincent wrote:
> On Mon, 17 Feb 2025 15:41:06 +0200
> Ido Schimmel <idosch@nvidia.com> wrote:
> 
> > Allow user space to configure FIB rules that match on the source and
> > destination ports with a mask, now that support has been added to the
> > FIB rule core and the IPv4 and IPv6 address families.
> > 
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  net/core/fib_rules.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> > index ba6beaa63f44..5ddd34cbe7f6 100644
> > --- a/net/core/fib_rules.c
> > +++ b/net/core/fib_rules.c
> > @@ -843,8 +843,8 @@ static const struct nla_policy fib_rule_policy[FRA_MAX +
> > 1] = { [FRA_DSCP]	= NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2),
> >  	[FRA_FLOWLABEL] = { .type = NLA_BE32 },
> >  	[FRA_FLOWLABEL_MASK] = { .type = NLA_BE32 },
> > -	[FRA_SPORT_MASK] = { .type = NLA_REJECT },
> > -	[FRA_DPORT_MASK] = { .type = NLA_REJECT },
> > +	[FRA_SPORT_MASK] = { .type = NLA_U16 },
> > +	[FRA_DPORT_MASK] = { .type = NLA_U16 },
> >  };
> 
> I don't get the purpose of this patch and patch 1.
> Couldn't you have patch 3 and 4 first, then patch 2 that adds the netlink and
> UAPI support?

Current order is:

1. Add attributes as REJECT.
2. Add support in core.
3. Add support in IPv4.
4. Add support in IPv6.
5. Expose feature to user space.

Looks straight forward and easy to review to me and that's the order I
prefer.

Thanks

