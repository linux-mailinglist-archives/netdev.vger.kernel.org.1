Return-Path: <netdev+bounces-186025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B812EA9CC48
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511011887016
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611125E82E;
	Fri, 25 Apr 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MXXkq2CT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D825F7AE
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593208; cv=fail; b=snsJGFuNP1/CY0xXunrV4jJq0aYdx84HUygTKpqSwoXy9cmNyNf3NbGA2LvEcVBBJQD198X58G0TJpxd0gyN6fzj2i/iUrapGAqc/KOTOGRkPHESVx6nHWsfYqCuGd+m1a8nVGtskf0mcPURwMxgn9ySZ9aXvWLMlp5zqwDn7JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593208; c=relaxed/simple;
	bh=0Zi3yPzm8dD3Ea8tgwwLMj3OYZIdFs7HJvVBLUf88uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Meti4c6P2HvVX290TMJxZdccVpQDsIUpH8L7MQJ4F5oqfA84LjjrFI6UJknioEttlPPlhdGKzvz0r2aXxTdlMMMlIx3rH/xZCC2kT/luyGRKoDGRaJlg9jT4qb0RkzEn4d1nN19QyGVfwMNXjRO/7kVR08Qt12E+W456ySJrhRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MXXkq2CT; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+32NfUOO4zedVAC2kI5tijZXSvOFT6kjXHkprSyj28NrnQwygiC7CU0OuRmaQuNcUFlEnozHJsmaLbf1dGGSM38jow2r5Bmiw+/QwDi3EKKci/VFWTw9oGXR3EU8b7vLT6hHt8xMt8Ppw5wDjghBHkLc1yqHWUG+o8O0qjL6FL1ag1gRHWMEiV0KIt+/05lhwUV9VX8qFj1wmnBx+62/N/AcKvsCyLWKpZUjukOPBushhJSjIHcS63CI1FOKBSFG7zglsovDo3+eJxvpbFkAZ5TOjrb78lSXDBqWG6ZugGqhSsRqfyYZNgGsOdISnHON6+Ri3KNCSwsvh54vCC2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67fGYjHoV1XoohyY/17rN6jMadYhFulZPsu0mODZJp8=;
 b=p6THG0wfYtmfmDiPx+uzO876/XwXKv0yf7ODjT5MU1CQXzdhLsyIfwIKCkiRJvxgiifcAcjnq0eKZZjIjb/VwZTPu21dsMMzj0IHvC4t4iAnb+GUgZzzWD3+4xnSeGLaJAqDBQkOk9ZtB8ZKY0n4GIz0K7ENcv+fMjjEu1Pw1QNZHK4IZK6X5mqx1yz8MGpSJb//0+uYH+A+nhV+5mmbCT/JFVD38b7Y1sAEftL4JmVTxvHgA425/DyvbRMpurJtR8lfzSN2NynraYIFVO5ecYfVeNXKS4zAnBQxOwsLzPs63EYEn5y+4fhfokxSUGFHfv+Tyg0WqsZrZQf3v22RDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67fGYjHoV1XoohyY/17rN6jMadYhFulZPsu0mODZJp8=;
 b=MXXkq2CTj3okOjPfWbPC9pmSbSjoQhve24FXrTSwgP6yZuFnQaFTPYSaZd6/jxwsl33JdmrCKfQf1la0RiY+ls8Y+lNGxin+kxLXqjEmw0gm78HNN001OlLhVpL9RMDY7SV88HZ/FLxeHS6XJ/HvtaX84nHSFFyYL0NoUdbbheKqvcBPuzjuEY7wnoC/kj9818C5z+9UyJ3b2mh+zKyFp3S9/c+Zq0CufHsaL+PqDUwrTT8UgWHochgwHMsMO4noiI3T9/C32/+LCtos0dIkIFksMdvW8JcTncfkfztbcVav6/9aYdX09SOzt7BaFmoPN9r0r3uQH+rKQ2FGUP/wdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 15:00:01 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 15:00:01 +0000
Date: Fri, 25 Apr 2025 17:59:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	horms@kernel.org, kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 1/3] ipv4: prefer multipath nexthop that
 matches source address
Message-ID: <aAujZJXqlG8VZpJF@shredder>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d935d3-0174-4438-07cd-08dd8409da34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfJ+WQ1KxzRRbcrDDydGJMYkTU/CsGirA91k2Eist4zAfobRW1BUby34Wlcr?=
 =?us-ascii?Q?GkVYIeUx5B40CHhzBaTu9rUEL4wepF+5UJ9+A3dUhWGWa8dpho5xIldHgB9w?=
 =?us-ascii?Q?sLFuTYi+M0UoLv4xpHdM2sBPj4ZbC2pXFkQYWMmsXgL6p6c2VhIkkwgzUCUT?=
 =?us-ascii?Q?np/3N82RtjRB4P76ifYTy4taV93LgUpawpczJKc3nKLvqFTO3RTHq+2SO8lZ?=
 =?us-ascii?Q?/uRgZ/rj6uECCorAH3nJHw0cTFMIOqntUZAB1svNpJOHDhFqQA5R8b9KfUXO?=
 =?us-ascii?Q?+kzJ/iBmexkf8e5qDHaJELTVx2g8xQf6pbmJCsJfs6jNfA5ZwDYtaPORpWkr?=
 =?us-ascii?Q?MIQDHMUB6asUXhu44hpFxWKwPnP+eq/pkwgvpVp5TusD3asdLMHZbzVJYFef?=
 =?us-ascii?Q?fkpcyM3wELeLDY1n/7zH7Q2J8Wca6Va2RNekg5yN8himQ9e46yzCFli6NF3s?=
 =?us-ascii?Q?63AGAsGvYU9BlUD9CFb8rBm8gsDmUcLjC9kp0C7nS6wDfWTOPM3uzRGqo6RC?=
 =?us-ascii?Q?gaQQl54///Nw9vwPAbL+gIBdf9XW6AkU6w8qNlXKbyacmMt2sSfqgfePb7+H?=
 =?us-ascii?Q?Sw7Bf40zPN9FddfyETvr8s+kLwhk2MxAFdZgOmZ9H9IPGbNPz7/3VDBGwpSA?=
 =?us-ascii?Q?u+fmkk9ZUPrAMcWhhLm7SXF38+iTVjMOU8iXB4U7HO2+DkX6REo7UPyRNO7x?=
 =?us-ascii?Q?lxdVD9ULmQkFJcRviVbJqod2cWHjRZ3TItjsLopZ5thtua6CPq7eJ2oPdbMr?=
 =?us-ascii?Q?C5HoX+zuSt1bK92CDBTFWrT/KVRL1+XoXEQZPkXFqfx1q0LiAetS4J1cxWVA?=
 =?us-ascii?Q?GZlg21vXMNxavHwcOaiIa1gb4Ws8yDRiwG2Gc5px4N9Clj2sE1opOK9/Ogt2?=
 =?us-ascii?Q?btePyouq7NV9fM2ctuJwuGL7OjpA6d2pCzHkiJ0KbG5RkHGGVucFba8svPG5?=
 =?us-ascii?Q?cexqoMuTUvdzHR+NJXEQ6Lemr3N6EfbfgnKJkD2C+wWqm+p+/6b65WlkoEHL?=
 =?us-ascii?Q?USdJPKjBIjXDn9Mmz/bRkcHsEfvIxeJo3hHY+r9DczVKo+l9lPbV+/sCS9Jh?=
 =?us-ascii?Q?eVmFjvzakscM7xjFAqG6TrJIptpBzRskqFiU4eRjoB0O6WktQ/pj+WICLki6?=
 =?us-ascii?Q?lRg2qt+jyiG0DoIweLaJBzyz2RgE0nlVDe0AB+u2E7ZDkejuicyYhLWsYrSp?=
 =?us-ascii?Q?cdTYqRIKAkQY5LnP6LEkF9gVg+8bJrnoxtL0HVXopx57M+sIgsJjvC2U9KFW?=
 =?us-ascii?Q?0d0qzSC0Yg29+S/hZiqoOR0ZcaIBKd/60OZa6fmYKZKie1JiratQpPFJjKC2?=
 =?us-ascii?Q?xQiAzN2yySP+l25t8/ZYbZIDhF12uqB977JK3RoBry8J/ju8rSV4DVUYKhFN?=
 =?us-ascii?Q?AHR7tnv0Wejnn2fUH6u/eDlTeavk9wF9wmUqIqQmR9stEZSJ2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sav902q3IQR7NFAUmBI+nMKe2VROd368FJ8dUsB8k7aVp17+sXPWIzscktWS?=
 =?us-ascii?Q?2Dlplvd6/nvYmnLyGvKNiaqcXAlXVf6TFTSQwlAMhz55ThSMrFk4WC+XWWiU?=
 =?us-ascii?Q?Oeu8vZzd62qfydUx+1yUYqhT8VJ1vrDDo0kh6HuFOXpfDWua4GaundbPYFv2?=
 =?us-ascii?Q?UCCItFsuq1lhc6zF6YmLvAHSh6xj5FHTm1TU60JgxVacaVVLML9Ko5tcrbAx?=
 =?us-ascii?Q?cSfXApkVWSe932A5F5qt2614ggNW4Ik3Fd4C4kaA0N8/ErHd/5jUHR0jHDPX?=
 =?us-ascii?Q?2dQZmfy7/Da0NH5sNplz1iDHDxRQZHTeP3r/voZGIJLsqlf7/3XI596rkI8s?=
 =?us-ascii?Q?rJHdx7a4mhTPIBKNdt+6kH6SuiSKl41b+fEtt/5nQ1roaWNmopApZ2HoEtUf?=
 =?us-ascii?Q?IYViwPEpZZtIC7+0OIz0B1qj1r0AMQ7/Q2F0Zj40Yqe71d7JjmOxVOCOPKkR?=
 =?us-ascii?Q?UWSIAnBYLPksSkcLgmMTkrE3ffGDLHApbm0TiMDETtgsf08b0FoMIgPckjtB?=
 =?us-ascii?Q?07NZi5zCnzeBl8qiTRv1CKLr11w8IXezdm9xRvcxd14sBFZ3+T+v2LrzMwRK?=
 =?us-ascii?Q?CsU5CwP0z0Xlfsa6HBSfF2yb2DKzGcyf1jlrCyLBsmhUwOhedxJtEdf0GWkp?=
 =?us-ascii?Q?QNDAJ4zKvEsrzgmjLXr2S/vKaeJ/fQ3K32Hf006/j2/oMKO49MtV758CLo39?=
 =?us-ascii?Q?EAvGS+TSCWU2bPGbgn+CZE1m+Lycp8TT8V+R6NLklTUwlN1P0WKF7C67xaMo?=
 =?us-ascii?Q?nHMCaF15iw6fSMHMxxPpLO+CiF54vW3m0U2iSHGBEmomdgUSi7TusUCLVw/I?=
 =?us-ascii?Q?4Lm/r05m0pKbhwH0N1aOyo5nDY5Y+osKFUYRNTme486LBo4IVleYh+Z7k0Ab?=
 =?us-ascii?Q?sRJ8DtRGNzvgz5MSSEY7oFlQ9L0pjg1AdSbraPmG9tjizvEjDuzzmBsCpBCv?=
 =?us-ascii?Q?VfSBt7RfETlp2MsPo21crE+SbMCLsE78wHJR3k8ZzKRhECn4AZV9c9avELXN?=
 =?us-ascii?Q?Y0g+GiGsa42gNofnN1cVG8BnKSUKQY6JmYbvqz33G95clQrmhfYajORwAa1K?=
 =?us-ascii?Q?mE3bCPR2BaqlH7xtc3b2aeHcX6hX4VXDwukzer7kgdQbcntcn/HJ54K4lZjm?=
 =?us-ascii?Q?6MV6C8GS96MlGqmMYqseN8VNmscBLNvYDzvlFBKCDB34v3XPUXBFNvWI6btS?=
 =?us-ascii?Q?acxS3gRN5c1DPN5Ut2E+4aOpPPDCWdCBkuDS5Jg5WqKIl19iWbOVXX6uXOkV?=
 =?us-ascii?Q?1Mshh30QYQclsQXusyuCo/sw0AJmQ9E9ed2j+2U2KqUqhcMTv8fHa1AwTEAU?=
 =?us-ascii?Q?kJBqEwgoz3Zx3hgPMu/hdzC2GtXVXgkS4vwt0QSMIS/fUcTnkB1ADS4p+F0n?=
 =?us-ascii?Q?owSq7T0XRJpyqPzQy4ywn2n00J0ol/6ceGTpwROpf1K8Namti2V8LV7VQvs7?=
 =?us-ascii?Q?DXcMjVBVMj3/zS/f2CnQdsF+N2yH3q75azvW1SYIECoGZ8AVWktv5IQm0F+4?=
 =?us-ascii?Q?f3+AGIgVpR1lgKUBXlXKeDhF9QVeNCLXcZhoy+WL0g0cNl97M7+CUcA7Dj82?=
 =?us-ascii?Q?BQRIDgdMXFCB92QqntMmev2caKBHBrq2iSPYTwt3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d935d3-0174-4438-07cd-08dd8409da34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:00:00.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojAh8zb8XiHoikrlCfIMlBhopCDKlFLNDk4Bw+Vl+fHbx4uLhObuRIaaYzDHPB7Z3qjkRold2Xi7uHyOayruSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

On Thu, Apr 24, 2025 at 10:35:18AM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> With multipath routes, try to ensure that packets leave on the device
> that is associated with the source address.
> 
> Avoid the following tcpdump example:
> 
>     veth0 Out IP 10.1.0.2.38640 > 10.2.0.3.8000: Flags [S]
>     veth1 Out IP 10.1.0.2.38648 > 10.2.0.3.8000: Flags [S]
> 
> Which can happen easily with the most straightforward setup:
> 
>     ip addr add 10.0.0.1/24 dev veth0
>     ip addr add 10.1.0.1/24 dev veth1
> 
>     ip route add 10.2.0.3 nexthop via 10.0.0.2 dev veth0 \
>     			  nexthop via 10.1.0.2 dev veth1
> 
> This is apparently considered WAI, based on the comment in
> ip_route_output_key_hash_rcu:
> 
>     * 2. Moreover, we are allowed to send packets with saddr
>     *    of another iface. --ANK
> 
> It may be ok for some uses of multipath, but not all. For instance,
> when using two ISPs, a router may drop packets with unknown source.
> 
> The behavior occurs because tcp_v4_connect makes three route
> lookups when establishing a connection:
> 
> 1. ip_route_connect calls to select a source address, with saddr zero.
> 2. ip_route_connect calls again now that saddr and daddr are known.
> 3. ip_route_newports calls again after a source port is also chosen.
> 
> With a route with multiple nexthops, each lookup may make a different
> choice depending on available entropy to fib_select_multipath. So it
> is possible for 1 to select the saddr from the first entry, but 3 to
> select the second entry. Leading to the above situation.
> 
> Address this by preferring a match that matches the flowi4 saddr. This
> will make 2 and 3 make the same choice as 1. Continue to update the
> backup choice until a choice that matches saddr is found.
> 
> Do this in fib_select_multipath itself, rather than passing an fl4_oif
> constraint, to avoid changing non-multipath route selection. Commit
> e6b45241c57a ("ipv4: reset flowi parameters on route connect") shows
> how that may cause regressions.
> 
> Also read ipv4.sysctl_fib_multipath_use_neigh only once. No need to
> refresh in the loop.
> 
> This does not happen in IPv6, which performs only one lookup.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

One note below

[...]

> -void fib_select_multipath(struct fib_result *res, int hash)
> +void fib_select_multipath(struct fib_result *res, int hash,
> +			  const struct flowi4 *fl4)
>  {
>  	struct fib_info *fi = res->fi;
>  	struct net *net = fi->fib_net;
> -	bool first = false;
> +	bool found = false;
> +	bool use_neigh;
> +	__be32 saddr;
>  
>  	if (unlikely(res->fi->nh)) {
>  		nexthop_path_fib_result(res, hash);
>  		return;
>  	}
>  
> +	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
> +	saddr = fl4 ? fl4->saddr : 0;
> +
>  	change_nexthops(fi) {
> -		if (READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh)) {
> -			if (!fib_good_nh(nexthop_nh))
> -				continue;
> -			if (!first) {
> -				res->nh_sel = nhsel;
> -				res->nhc = &nexthop_nh->nh_common;
> -				first = true;
> -			}
> +		if (use_neigh && !fib_good_nh(nexthop_nh))
> +			continue;
> +
> +		if (!found) {
> +			res->nh_sel = nhsel;
> +			res->nhc = &nexthop_nh->nh_common;
> +			found = !saddr || nexthop_nh->nh_saddr == saddr;
>  		}
>  
>  		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
>  			continue;

Note that because 'res' is set before comparing the hash with the hash
threshold, it's possible to choose a nexthop that does not have a
carrier (they are assigned a hash threshold of -1), whereas this did
not happen before. Tested with [1].

I guess it's not a problem in practice because the initial route lookup
for the source address wouldn't have chosen the linkdown nexthop to
begin with.

>  
> -		res->nh_sel = nhsel;
> -		res->nhc = &nexthop_nh->nh_common;
> -		return;
> +		if (!saddr || nexthop_nh->nh_saddr == saddr) {
> +			res->nh_sel = nhsel;
> +			res->nhc = &nexthop_nh->nh_common;
> +			return;
> +		}
> +
> +		if (found)
> +			return;
> +
>  	} endfor_nexthops(fi);
>  }

[1]
#!/bin/bash

ip link del dev dummy1 &> /dev/null
ip link del dev dummy2 &> /dev/null

ip link add name dummy1 up type dummy
ip link add name dummy2 up type dummy
ip address add 192.0.2.1/28 dev dummy1
ip address add 192.0.2.17/28 dev dummy2
ip route add 192.0.2.32/28 \
	nexthop via 192.0.2.2 dev dummy1 \
	nexthop via 192.0.2.18 dev dummy2

ip link set dev dummy2 carrier off
sysctl -wq net.ipv4.fib_multipath_hash_policy=1
sysctl -wq net.ipv4.conf.all.ignore_routes_with_linkdown=1

sleep 1

ip route show 192.0.2.32/28
for i in {1..100}; do
	ip route get to 192.0.2.33 from 192.0.2.17 ipproto tcp sport $i dport $i | grep dummy2
done

