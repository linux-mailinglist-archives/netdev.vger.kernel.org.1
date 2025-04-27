Return-Path: <netdev+bounces-186318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B195EA9E418
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3960F7A462D
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0813DA945;
	Sun, 27 Apr 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ic3CEw5S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE223155389
	for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745775065; cv=fail; b=oRorBOzco2BCWKV8JcWs7dgudn7VEBDZbYxoENobv6LeodPmKR58aFhtRy6wwlzNzPg3yOUtwaIpTDZDUE/bveJuwCWuYb7vkTBjAR9znqcUJhhHtoWcaI1npoGk3qe9CJ6xzgBbaQm6dBTH/23Fc9ZfZ8jjkVvZulg14+L/Xs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745775065; c=relaxed/simple;
	bh=trEqjdeCYZqxCD0GF49NKy1u+RicTeFzAEJaV6XoBLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sulTDecnuuWxpiFiicwcmrx2YaPrQ7ujcge7O4p4xj11k5/ckkwn7D68cIJ0WunnRKjVKyHjwnPuByjwRiO9WDl68LThQ/HSPdPEA+TS1y0Bps7KMdv1KtUQPhOvHEz38x8Y9FeHjJXr0xua6GfOpFtFheCvIHz8IbkOpA119xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ic3CEw5S; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvQ+DmWQzHpB26wHvBGQsbLPLy0ZsyHBscRDZvCltGZzJLkwMMO77tlE9ZmV3avw071y06tkkFAipwEPBZ/WKKhisPa+3QJhnjkFz4EhCTwHvxHVTNPFpm9tMQAF966JdjB1qjnU13pjtaNIbdeUqevFMOuuVGByHdiQb6Y/HbNx1nJqpjLMgCLP/p5ysVo5vVYImbEUsVBLoip44ff8hrv1oxNDpYZnnpwiqa79STnxv7OeNhCq5hIIsCja/wJqTR6gUZBn/O1+aDYKkL58bgWzhKvqV/fFdBH7oYOMYkrZzjaLEhkKrzE6Wj7hf1eB5rAp0t6iMi605M8a2M8jYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldq+A9BiqLB+hFX8AtZO7YQo7Tj8gNiW6+ZZDbfl5ho=;
 b=fq6lCuXsy/8b8WM7vuvdSQoD7+lsWEsWqXuiKxUaGCp19CVdwnYtoh3fNctwTYbjhCZRgbqbsVLGMVRs56GuS2uHYhfaECg/0+2n4g+BtLORdRjhX0ZqQW98jHo8dp7q3LuMR/48LOyMtbS9QF+zzXzKXaSioS+nLCzJDKa2lQ+l4f4Y8gWxCWqGJzFqssMvv0KUo4IpPFGy3TqaBXqTjNNc8/g3GPMVRgYLvyjg2z1RGmfUW9FDMi5EGpGb0sJd9J0QXJQiqalu/DdFHp9nBQGVTKQ0d4ECo1vzJncUByTUdnpkE12pLE3WCGZbwBJ63ms8W8xG0xAYKt4UqoAOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldq+A9BiqLB+hFX8AtZO7YQo7Tj8gNiW6+ZZDbfl5ho=;
 b=Ic3CEw5SL1JNbaam1SNz6PHRuedE9D3JybJNoS1rmuAODu3FlnkNb+h3bRrqhFOt9eWY6qeUe8Hkz7gX5y4EarPC4SUgNV4BRKirJwxx84VToHBrarzquXtD3FgWlkoBBjxvzTevAGUVHrEQ7D24UPZ326SZ8alUHDgSqoQopSyY/5Y+ndyj5MqDVSF52Jg6uO8paOq5bKtDS5wjTkvZb1bXRXNiBKciDIzGpaCzdxl5Z4v6SolM9moM9YWF0G8m5dmjuVhESj+6X7IDwVgOHPVOjZcbyIpHQwpl1ZAibTvNNn+CI0zopCbP9gVOWxl1RaksEBgagmXod+T/kGUbqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Sun, 27 Apr
 2025 17:30:57 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%5]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 17:30:57 +0000
Date: Sun, 27 Apr 2025 20:30:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	horms@kernel.org, kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 1/3] ipv4: prefer multipath nexthop that
 matches source address
Message-ID: <aA5px6qCjTWbHimM@shredder>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
 <aAujZJXqlG8VZpJF@shredder>
 <680cf54b983d5_193a06294ab@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680cf54b983d5_193a06294ab@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 83488ba5-faf5-4759-72c6-08dd85b144fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ypbl4aB2xpd/eRMwS3H9bAgsZicoAcbohrHI23NTN+WjVTIao2V4zVBUMp15?=
 =?us-ascii?Q?f1VY9NYb/Pbov8O6SVRnANzCPUqt5nLldK2W745lBoUUBVgfEgFdw3UBHIeJ?=
 =?us-ascii?Q?BuNv2v38U4/JjK+r5HOg7q6XZVk7n4ncT2EWK35EPOyx9VqK5fkL/WnohvFq?=
 =?us-ascii?Q?B5VEX0MktoGWWc7zDU37Mfip8sC/jrJj0zrsDyNyimO2In71D7ix0pN4A+Zj?=
 =?us-ascii?Q?Xt4EWlRtoJZCTlgxkoQLexPs3lH1ECX3wsFc9ff/sobDKHoQI1h0shoy1Vfp?=
 =?us-ascii?Q?WLOvcZtMqGlxI+ZvXHxv4RgjsdRUIkywkc09pXIPW0jySp3uObCeDxXHLktm?=
 =?us-ascii?Q?7vnxOGyllhY2Of3L/ctE1tW9LpvK3MZp6aZAvuSr2W9hQWSNFsY+0VlDYns4?=
 =?us-ascii?Q?oErVjCkG8p5yVaBr0isPEOyMs9ctpSt0hGZ3nqYZpZVWJa2ktk6kx9g9KWrD?=
 =?us-ascii?Q?NcJt+ZAs+19lro9yIcRHn3mBZxegxqikGyx5tzR3SlLlMf0luOSlNrVrfm0N?=
 =?us-ascii?Q?AOtawsp5asnx37UtvuY5ewYrvU+enEbfidVhnYc6tGBsnnEsRce3oc8lWUIh?=
 =?us-ascii?Q?uvuvvYJMwZqHr70RMWRf1EEMQly9Xm2V7qAFnLQrMOngOgA2DNCUHGXgqwEY?=
 =?us-ascii?Q?JpMMz5qqDHAnx2G3M2BVNZ5Zj4Dzo6fKbyvKyMaC0kYSLPVuOZQaqJY+Abd3?=
 =?us-ascii?Q?8dqJK1fpVatgBOq+IXneMVStgGw5B2IHagf/b3vmWdb4ROtoPmsr7BhdS0kj?=
 =?us-ascii?Q?eShl9YylxXWHiLlCchIPok+801mMTqEItyz32PSDyD/K84di9srDb1gCe3xi?=
 =?us-ascii?Q?W4f1yB19nGisl5/LO1szFMRtPoil7h6pHsza/dgRuuJrlyPPytdDhao3iXJI?=
 =?us-ascii?Q?UCPMhhZdgB7E0Bm31+KWoo5XWM4UtksQJ31ikMCduxiG6xe8uZ5JmBow2g/l?=
 =?us-ascii?Q?dQBIXcA9WyPywcWyFzgE9iYCRfp48pjxD/GXmA813jEZJPGNn5mx4gUJBPuU?=
 =?us-ascii?Q?WuKGmEy+G4TdaJhewAnf1tNSRqmteCEfG8jxPbB4lY0t+QW/V2xjYcAczwMi?=
 =?us-ascii?Q?ZAd4x65WUPeqCPoUQIG1h20Uvj5nP1wJMwRUsgO0QkBU5J3eNklmP6Fsgs3E?=
 =?us-ascii?Q?wXxnJjZiA15Bp5x8Y319FAL/p4xZbeE/rygSlhn1c8pqqrmaCQlff36tqD/0?=
 =?us-ascii?Q?EHsXmZTDHQdYA9ZhbqkRZ0sx9gHsaJbKQiRYvmYx8//HHi3Fsm8uyyMYXDG5?=
 =?us-ascii?Q?0J3C/+2KsQXJMwDrjRQIHJsjfRF1umZBMgWa29h9nWMja2ADdv7NCdeF4Ar0?=
 =?us-ascii?Q?1ZzVV0uu3ueMQOy59oCyUJC1s7Mrtv5Oerbqj/WV8EMQ6yht40bB1TfaffRG?=
 =?us-ascii?Q?NJaoYQKgRFwVcqE+xSdhm0ShKHHOu4XW6g1c0VgjtiNa3ZZAmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W4ZvdQ1Rm4w12gFHKnBrsJR1U3gSCouoNUYFWsIbkgpcsB4U4MfkUiMeSwDX?=
 =?us-ascii?Q?D+4KJVG0sBF54kCqT8ozHs53ue1lcDD2YOYNzppeYKA553hTy6ugXvw+KzK+?=
 =?us-ascii?Q?JWCttOBdvoAO31ctTYvATgi3DzI37ZhtRHBSnvxMeOye7YFcqDZmCuZWdcic?=
 =?us-ascii?Q?DRB5dFebXvcEuCeKmMM8caOYYUkWj3pKpwo6qGqsoChZmP/njXgg7/KtOpqR?=
 =?us-ascii?Q?4HW7wAeD0aA+TmvEhRbsD4xbv6Ggr4oWfGqvVuWXRMz5ioUeQHzhsx7h5uw9?=
 =?us-ascii?Q?HAKGrVJPz7I7gGH11LJl78gO7rNsWOr5CnWmiF+jvBbSXZyVLzI5eFSqsFiQ?=
 =?us-ascii?Q?pjtKqWvcnf8aX2cXJ85TMBfGmEIiUBppHwy9OIg+m96MZAMsZjuN4sR6jA4W?=
 =?us-ascii?Q?zl1NEku4pHzHkW+hyrCfhIg339OyAUd9V1Y+0ZSV0YDTaTRt03EsQ/aqm+xj?=
 =?us-ascii?Q?wSg0a8CCM2qYsxqNIyd7ZzOe/J11X2UBcXGhf8E9QK8PNp/7768Ig51Bo5A7?=
 =?us-ascii?Q?pLuZBCrRVlUoSqHbCGVcV2APN4tvLr84K34+BN9i/wvdWK7bS/IMCduh6v5O?=
 =?us-ascii?Q?9ZK3gh1keUMXiV4ieRyBe7uS4kfscmRoVowC7vdZvJE8IPlDKIF2HAygoYdJ?=
 =?us-ascii?Q?AVg2r/f3KI1tQ7wjOrorelXItqX3qEAZ4PnvsV+p9dAr8zEwOFcQvD1FSZjM?=
 =?us-ascii?Q?Uoe+APbH5Q8q9udK/4bVRJN+eR+eGULeYHruK04Vu6HZXdOFnO8fMrBBIE5G?=
 =?us-ascii?Q?KexFipWy2ebfbYiliueLrC2EB9nt+CXqgMiY3TJqSMt66eCbzQvtFVIIcAs7?=
 =?us-ascii?Q?lO7YLQM5GnTDfARM2dNSbs2EZkLJdbhAr7vUttaY2dihT07cwbbHwRdWQAwb?=
 =?us-ascii?Q?Q5igEzItHA6aHcX88btvj7lfLy5MdP7kf15oX0g7dK49IrX4Q2TgTHND3r95?=
 =?us-ascii?Q?7lhg+rL7s7bhJowcMumODybaAZRdB5mf7piKvNzQsmMZUYC8zXGb9ve4kVgb?=
 =?us-ascii?Q?3jfvw64gjHoQ3/JZ0B++mfeVdETVqolNcfOr0r4PT3jJC+yDihSCq1Gb0C4b?=
 =?us-ascii?Q?5utmq/BhxUi1sr6qkoj4slkxtHYV/MgHDM/+vmlFWmIZfA4omaeg/QoDIDCg?=
 =?us-ascii?Q?7yngklhK9hML18Wur2EHqXFsp50JqVXdbDJfxS4ZUwBOzHCg84NOVZ78iyYk?=
 =?us-ascii?Q?0zxQBSsPYm46AH0uKqOR8jl5Z8vnV/pSQShTghqLurdXdgq+DWnLhMX6PHrv?=
 =?us-ascii?Q?v/qY4HjlJvjjXvaoC45A0Fq9u2Lm9P+7N1hnrwAoTjGakU/8MtWiiKrNTs3D?=
 =?us-ascii?Q?2CAUnGZm46G+fwMPNJDyUXTS4x3emmWZDiVBsDVmRIvQF43N/4IB4uli5485?=
 =?us-ascii?Q?Jkam82QPfQMa+GY8aYtbIaJoXtJo++4U47sv5JIwWDK6HmOB6xYkEWeF1AC7?=
 =?us-ascii?Q?RMTfhLIGTYLU+l6cPPyxnIRWHL/QECjnZQeHzUi9p1+rorCeY0mzqbi7Eb5C?=
 =?us-ascii?Q?c3mKGbXPqGFk82D/snhDAJ1jK2X0uXVoHaO7OAcJPE6C8x3iQmRW+/iv/ZxG?=
 =?us-ascii?Q?MTuaH45HVyCZD1EwSMSxmFhZBH1Eqczww7DO6Fqb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83488ba5-faf5-4759-72c6-08dd85b144fb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 17:30:57.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGBwZXw5z6lwTlromoYO7UXeP+lIVziRTkpCMv4VFmsLBCVSScceVPpf4cDLbuHEwG9fKHhYJBLBs0iZ9UDJ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

On Sat, Apr 26, 2025 at 11:01:31AM -0400, Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > On Thu, Apr 24, 2025 at 10:35:18AM -0400, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > > 
> > > With multipath routes, try to ensure that packets leave on the device
> > > that is associated with the source address.
> > > 
> > > Avoid the following tcpdump example:
> > > 
> > >     veth0 Out IP 10.1.0.2.38640 > 10.2.0.3.8000: Flags [S]
> > >     veth1 Out IP 10.1.0.2.38648 > 10.2.0.3.8000: Flags [S]
> > > 
> > > Which can happen easily with the most straightforward setup:
> > > 
> > >     ip addr add 10.0.0.1/24 dev veth0
> > >     ip addr add 10.1.0.1/24 dev veth1
> > > 
> > >     ip route add 10.2.0.3 nexthop via 10.0.0.2 dev veth0 \
> > >     			  nexthop via 10.1.0.2 dev veth1
> > > 
> > > This is apparently considered WAI, based on the comment in
> > > ip_route_output_key_hash_rcu:
> > > 
> > >     * 2. Moreover, we are allowed to send packets with saddr
> > >     *    of another iface. --ANK
> > > 
> > > It may be ok for some uses of multipath, but not all. For instance,
> > > when using two ISPs, a router may drop packets with unknown source.
> > > 
> > > The behavior occurs because tcp_v4_connect makes three route
> > > lookups when establishing a connection:
> > > 
> > > 1. ip_route_connect calls to select a source address, with saddr zero.
> > > 2. ip_route_connect calls again now that saddr and daddr are known.
> > > 3. ip_route_newports calls again after a source port is also chosen.
> > > 
> > > With a route with multiple nexthops, each lookup may make a different
> > > choice depending on available entropy to fib_select_multipath. So it
> > > is possible for 1 to select the saddr from the first entry, but 3 to
> > > select the second entry. Leading to the above situation.
> > > 
> > > Address this by preferring a match that matches the flowi4 saddr. This
> > > will make 2 and 3 make the same choice as 1. Continue to update the
> > > backup choice until a choice that matches saddr is found.
> > > 
> > > Do this in fib_select_multipath itself, rather than passing an fl4_oif
> > > constraint, to avoid changing non-multipath route selection. Commit
> > > e6b45241c57a ("ipv4: reset flowi parameters on route connect") shows
> > > how that may cause regressions.
> > > 
> > > Also read ipv4.sysctl_fib_multipath_use_neigh only once. No need to
> > > refresh in the loop.
> > > 
> > > This does not happen in IPv6, which performs only one lookup.
> > > 
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > Reviewed-by: David Ahern <dsahern@kernel.org>
> > 
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> > 
> > One note below
> > 
> > [...]
> > 
> > > -void fib_select_multipath(struct fib_result *res, int hash)
> > > +void fib_select_multipath(struct fib_result *res, int hash,
> > > +			  const struct flowi4 *fl4)
> > >  {
> > >  	struct fib_info *fi = res->fi;
> > >  	struct net *net = fi->fib_net;
> > > -	bool first = false;
> > > +	bool found = false;
> > > +	bool use_neigh;
> > > +	__be32 saddr;
> > >  
> > >  	if (unlikely(res->fi->nh)) {
> > >  		nexthop_path_fib_result(res, hash);
> > >  		return;
> > >  	}
> > >  
> > > +	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
> > > +	saddr = fl4 ? fl4->saddr : 0;
> > > +
> > >  	change_nexthops(fi) {
> > > -		if (READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh)) {
> > > -			if (!fib_good_nh(nexthop_nh))
> > > -				continue;
> > > -			if (!first) {
> > > -				res->nh_sel = nhsel;
> > > -				res->nhc = &nexthop_nh->nh_common;
> > > -				first = true;
> > > -			}
> > > +		if (use_neigh && !fib_good_nh(nexthop_nh))
> > > +			continue;
> > > +
> > > +		if (!found) {
> > > +			res->nh_sel = nhsel;
> > > +			res->nhc = &nexthop_nh->nh_common;
> > > +			found = !saddr || nexthop_nh->nh_saddr == saddr;
> > >  		}
> > >  
> > >  		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
> > >  			continue;
> > 
> > Note that because 'res' is set before comparing the hash with the hash
> > threshold, it's possible to choose a nexthop that does not have a
> > carrier (they are assigned a hash threshold of -1), whereas this did
> > not happen before. Tested with [1].
> 
> This is different from the previous pre-threshold choice if !first,
> because that choice was always tested with fib_good_nh(), while now
> that is optional?

I'm not sure I understood the question, but my point is that we can make
the code a bit clearer and more "correct" with something like this [1]
as a follow-up. It honors the "ignore_routes_with_linkdown" sysctl and
skips over nexthops that do not have a carrier.

I tested with [2] which fails without the patch. fib_tests.sh is also OK
[3] (including the new tests).

In practice, the patch shouldn't make a big difference. For the case of
saddr==0 (e.g., forwarding), it shouldn't make any difference because
you are guaranteed to find a nexthop whose upper bound covers the
calculated hash.

For the case of saddr!=0 (e.g., locally generated traffic) this patch
will not choose a nexthop if it has the correct address but no carrier.
Like I said before, it probably doesn't matter in practice because the
route lookup for the source address wouldn't choose this nexthop /
address in the first place.

[1]
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 2371f311a1e1..ce56fe39b185 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2188,7 +2188,14 @@ void fib_select_multipath(struct fib_result *res, int hash,
 	saddr = fl4 ? fl4->saddr : 0;
 
 	change_nexthops(fi) {
-		if (use_neigh && !fib_good_nh(nexthop_nh))
+		int nh_upper_bound;
+
+		/* Nexthops without a carrier are assigned an upper bound of
+		 * minus one when "ignore_routes_with_linkdown" is set.
+		 */
+		nh_upper_bound = atomic_read(&nexthop_nh->fib_nh_upper_bound);
+		if (nh_upper_bound == -1 ||
+		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
 		if (!found) {
@@ -2197,7 +2204,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 			found = !saddr || nexthop_nh->nh_saddr == saddr;
 		}
 
-		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
+		if (hash > nh_upper_bound)
 			continue;
 
 		if (!saddr || nexthop_nh->nh_saddr == saddr) {

[2]
#!/bin/bash

trap cleanup EXIT

cleanup() {
	ip netns del ns1
}

ip netns add ns1
ip -n ns1 link set dev lo up

ip -n ns1 link add name dummy1 up type dummy
ip -n ns1 link add name dummy2 up type dummy

ip -n ns1 address add 192.0.2.1/28 dev dummy1
ip -n ns1 address add 192.0.2.17/28 dev dummy2

ip -n ns1 route add 198.51.100.0/24 \
	nexthop via 192.0.2.2 dev dummy1 \
	nexthop via 192.0.2.18 dev dummy2

ip netns exec ns1 sysctl -wq net.ipv4.fib_multipath_hash_policy=1
ip netns exec ns1 sysctl -wq net.ipv4.conf.all.ignore_routes_with_linkdown=1

ip -n ns1 link set dev dummy2 carrier off

for i in {1..128}; do
	ip -n ns1 route get to 198.51.100.1 from 192.0.2.17 \
		ipproto tcp sport $i dport $i | grep -q dummy2
	[[ $? -eq 0 ]] && echo "FAIL" && exit
done

echo "SUCCESS"

[3]
# ./fib_tests.sh
[...]
Tests passed: 230
Tests failed:   0

