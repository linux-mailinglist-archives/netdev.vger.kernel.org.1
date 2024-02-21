Return-Path: <netdev+bounces-73785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E2785E679
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739A71C24E4D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40728563B;
	Wed, 21 Feb 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6t9tgSd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E441097B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540772; cv=fail; b=WjyruT39gfruhnuK+bFMPhBHxwJxBOIXo89i6W1XSsCics8cyq4zAXKZOhl8IQmtuDSVckqYbe5WZDNooH5N3I/pC34nF2jjDrDtr7ekaibp9lxoZke+/3FlTl64njz1bOax1Ej1hIZvfKQvbr9hldnevp2e2rSvIK66waTX9Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540772; c=relaxed/simple;
	bh=pI0YH3TS13WmxiVNkNMaYCt43XgT/hfGJpxQNz+NNbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Spa+r5xFDE4M8jm9CfDHJaVh2e/3RaQIsg58coPNAS0N9Xup6t+rwCYC5CpQcqvEeqH1GJhxJbU8FwXJrqqeh61ozkfNoZO7X0/G1CdN/0xt7uM45faDKN/Qn3hxTZnCcPYbo2ws8VdBrX8wMTJg5GOAPECTDRj7hbmgsk1Qm/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6t9tgSd; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icTBbxyDThaQNWi+d6KokCYF9Z99zLk1v9KjRPIJ4cNyhGLOV+dDbciHG4XIrTjwKLshicQqzLIneVlYzAjOpgL9rAKS8oKIJegCK5c3pMj4rv8NH81AYk6iQIPbgkg4Y0XuQ8BW0LdeapERbDoI7LnfeBJn6BF15WbP9VoGyMYSPkJsY8my7TXKSLt4uqrpqmHqT6YaWnRzObGUSLHcEmlHeFutOFf6su7acuibUERB8CQjntUYf3NSMp/O95uCKYxFD/l92axYqPWQFhQ2AiXIdsMxJH1ukqowcJdgdyRjpdfZp0bOz6uY4a6VudvIyeCpAKz2+VrvXo3Z+W+LeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/1OjPoJtpFWo4y+01zOhvc7rEZCGs4+3oySDtkyycI=;
 b=BEaw4PlwqxePUQdb/HajrvvaEENbd9EpnMO4LrhqGyjCqs8kutEUT45tCn3EraxJR8pziTL5fPhGu33DS7RKQtAqI++NcwlRWez8hF0OkkEoaL4Iu6RNhmIVe+P7CesoNnuzxN3K84hqq2vqIFAEViQ2dUZZRYR3mZwOIAEBeTQwHZo1gDNR1CvHkGHaKVk/z2TOVp9WW5WBzvS/hxGi9x5k7jGxNQY/VNX7yRCpsuoOdnShgY3VxWXGBaXGpu5pWTo+AvGU3/Wh47sUbsl5r/zJQLUkpYhgt2G6c6LjJtaD1baWmRvsm5uZXThLUB6z/PP7oPTLc1wdrVKjLuuDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/1OjPoJtpFWo4y+01zOhvc7rEZCGs4+3oySDtkyycI=;
 b=V6t9tgSd1tsVLr8ClUTgqglUHiATWoYbeUoMv+yyCFDMIk2OS12jl7c4gVmvkfoql5pNR8ewoBLOttNFyTo99YEI/OaoxtKr5WZtOl8Vf28NV0Dov6ee3uMHi71B7u4sqVNNottZBq/wjsxj8GgFcjGYSX+sjtscG4hQWDQb8U207TpzBQemo8wGTaEKiVcJ90NFmEQEfgtA0DDvWAlNT/dPXK/e5He3nu4csKP10auC19talmdpfQsczuKOWDnkQBsF83L0JKXEBHF64Wx0Uk4I4xPrOMayFRkFsiAya3p+7EfC6fA4eJrQTPIO0e1jJdCKarBKiM35uD9eYiKnyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 18:39:26 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 18:39:26 +0000
Date: Wed, 21 Feb 2024 20:39:21 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 04/13] ipv6: use xarray iterator to implement
 inet6_dump_ifinfo()
Message-ID: <ZdZDWVdjMaQkXBgW@shredder>
References: <20240221105915.829140-1-edumazet@google.com>
 <20240221105915.829140-5-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221105915.829140-5-edumazet@google.com>
X-ClientProxiedBy: LNXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::22) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 07925608-524e-466e-535b-08dc330c6e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b2u61cWnYTdoAQwejG5g4VqjLqB+eokGTyWPKxRVSstBf54EDE3U+b+zng4goaI8er4FxfoG3/s9Z6H1sOO0LX8TMkycYKkqhKlJwLb/gDt0djuaaZTtYR+2zHO3zQnlLW5s3U7gNWDV1XW+xpoRTKI8wPXknV/Ce/XhXkb0HLzU6GMD+IaWDR1R3farr7dtuBVCPD4a0dGf8TSjSWUlE4uFe+i8xnx8ojQNK8Jj9eSAiQ712ypTTuSdd0btCgV9UPCmHGhRnni7PYUdrFkmtC9HXP6+pgYLC8K6caQ6IBqRXsKSWeUYTLTh7HoyH1WRdLj8j2dnUxQXQvVJyfSTgPzM+PEYqebHpgWiklzKrcKfHTBhwIuGlwgmk1LadRPfSMPUcNetH+Qm7Iz2WU++Qg0miUJHBe0bU67dlp1ryjUZLWkGa8ZUrtzSBdopKGOQzoZsYaC0x9Q/CW/sNNzMqAv8m56lv2LifwJFQ3CznUVmBJycpa/BzRJpa0EHMaDbyCdsQknOpte5PDxBRPK6S/8IP26/L+wAvEhuvN32IA5CFCFownAbH2HehbIEl0wc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iQAjRzzHb8XL7eDbMtHzPbyCjUZqcKG6Fgq/SdPxX6afhgAHuT4I7k6A/giC?=
 =?us-ascii?Q?Um/nUqgjzsiQRUTvS6NzTFhksKHsdu2B0b5yPrkiicV3mL8DGYCX2iQswe97?=
 =?us-ascii?Q?H5stPeYrGhHFbTKbcAlNjwNymoGgc3Xg+lmUXlAF1D1arXp062JRhfVWfA/Q?=
 =?us-ascii?Q?Xi3dzHHesUIPSwjJlaR1RUBXiPJP3jwkTRULreN+uZyHYJ3B0e6RhrMIkpsB?=
 =?us-ascii?Q?+ITRng7fWj7TGNB8LEFTSC8diIR9V/WKuTsxw9PdhGfKeCLxL1/lDOMkFsmg?=
 =?us-ascii?Q?AGdULVHQKKRMw09FaTP/pO5CJbrwnofnmmWiTpofttyQE5TJ1LggGezuH5O1?=
 =?us-ascii?Q?ZYisgsw7lmspFgb5Ng+2nY4DAAp6Rkm2RCel99tUA1qd3sYukuJhadIkhoYn?=
 =?us-ascii?Q?sVBodj5xQD7aEvYXh+G4BZDwk0zvA5ShHGnlVVTKRbIOPbyq2QjJhRTeFbfR?=
 =?us-ascii?Q?Iis/2GgH6fJJT6TN3UT2hZ/+59/jWvre/OhDBfjXgVjg1xMhjF9hUZdhPlE0?=
 =?us-ascii?Q?STwommZmJj4yMXPM4r6jG/hANdPz/oRKsV/cMydUwJqDi5iLjc95x751WLop?=
 =?us-ascii?Q?jKI5W9+WPuu+/qxAgaFa/ogv+16hjHNy+3QGi58icSpoMg+NXiMaPuorY14p?=
 =?us-ascii?Q?ER1TJWLyHlWMgv8PGkdtHBGCWXO15ffPHyZqtG1rfj+xwuX81Ti5f1LKlaoD?=
 =?us-ascii?Q?0uqSzGA9GlmAK6t72rHZCpRUp/9piDRy4N4s599xsO7Df2lJkRixajGmq9pD?=
 =?us-ascii?Q?Cw/iBMnO1tsmp6+3Dd2esrnadcwbSpwQaW1v3ZsuXGaCOOc3W83HyCkGodEQ?=
 =?us-ascii?Q?cSZ5wwqMjkjswdnipIKPjkeXWfLNW3lYkW3Nvo0IbKM3CW9U4wfC4N+J6fk0?=
 =?us-ascii?Q?NOTq7bpKywRRmq4xRTNntoF8mriLmQuRhByaolrzrt3d8Fakqatw+7RfDDAR?=
 =?us-ascii?Q?MeaS10z17nCedZUKJ1oKVCw0YJie0zu+WqKvCD/krOp4y0KLqcHbD3csH4D+?=
 =?us-ascii?Q?C6qkTQ6jZG1mfIt8ZAyMvwxImctjlGNt8bKeae468VydCoVlKOpKThDTKLdQ?=
 =?us-ascii?Q?jTYQTFCNsJZG6xmBl6oCRT10uZQCNRiTPEZxFCnIdpTCFZF/WnZcIW8prUlj?=
 =?us-ascii?Q?3Mbz3Qn01VXfuCXTeJXs7LnXGooRr7PzNQXJy1O3mTVdDvd3UjjEfsmR3ufv?=
 =?us-ascii?Q?E6v9VcPCmYkXBQGAbv11UQwKzoO7XKxjWAJoEjpTFGW93fv4FgUcetUsQchJ?=
 =?us-ascii?Q?xrE8g+BJfYBye01iYaDCnhccUQxajRTjtcPmcnrl6vvn5ElC3cFXV5GY/gxO?=
 =?us-ascii?Q?hg9dj/lU0U2d17pEI6UEeMLL5uc6aur5Nwb+ZIhuY66cgZKz7HWOWbR7MvY5?=
 =?us-ascii?Q?BiCJdemB0CFcpdKf9PiAXzd8nd5vE5mt+LsHE/eVilv5O0WDYuNsypiHd/vN?=
 =?us-ascii?Q?rgNeJ9G62x2B5uognr5DOH5CsGowy/wXoRTl0q+CBbSUfkqkq9h84NSEE+2P?=
 =?us-ascii?Q?ZWT0pfc8q+LPSWP+6sC0bIySdTCwNm6l171p3aD0jnsgtT43eFUIfrRxhthr?=
 =?us-ascii?Q?mzlCbxGQY8kfYxNv0Or+Itcv4aq/HceV2/zbrta/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07925608-524e-466e-535b-08dc330c6e1c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 18:39:26.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO+f/O94y4BBgBcBDotcemYrP5tSpP+jqjV8wWBXNSdXIK4gdv9KI215LgFqGkAlcX1m42wHTkh41j1mx4HQdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549

On Wed, Feb 21, 2024 at 10:59:06AM +0000, Eric Dumazet wrote:
> Prepare inet6_dump_ifinfo() to run with RCU protection
> instead of RTNL and use for_each_netdev_dump() interface.
> 
> Also properly return 0 at the end of a dump, avoiding
> an extra recvmsg() system call and RTNL acquisition.
> 
> Note that RTNL-less dumps need core changes, yet to come.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

BTW, not sure if you saw, but there's a failure in the fib_nexthops test
in Jakub's CI due to a lockdep splat [1]. Reproducer:

# ip link add name dummy1 up type dummy
# ip nexthop add id 1 dev dummy1
# ip nexthop add id 2 dev dummy1
# ip nexthop add id 10 group 1/2
# ip route add 198.51.100.0/24 nhid 10
# ip -4 r s

Seems like an oversight in nexthop code and fixed by:

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 6647ad509faa..77e99cba60ad 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -317,7 +317,7 @@ static inline
 int nexthop_mpath_fill_node(struct sk_buff *skb, struct nexthop *nh,
                            u8 rt_family)
 {
-       struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
+       struct nh_group *nhg = rcu_dereference_rtnl(nh->nh_grp);
        int i;
 
        for (i = 0; i < nhg->num_nh; i++) {

[1]
=============================
WARNING: suspicious RCU usage
6.8.0-rc4-custom-g85d71c2cf96e #20 Not tainted
-----------------------------
include/net/nexthop.h:320 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by ip/668:
 #0: ffff88801c1a3eb0 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x155/0x9e0
 #1: ffffffff85d4fba0 (rcu_read_lock){....}-{1:2}, at: inet_dump_fib+0x133/0xab0

stack backtrace:
CPU: 19 PID: 668 Comm: ip Not tainted 6.8.0-rc4-custom-g85d71c2cf96e #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xbd/0xe0
 lockdep_rcu_suspicious+0x211/0x3b0
 fib_dump_info+0x1ae2/0x1e10
 fib_table_dump+0xc2e/0xf70
 inet_dump_fib+0x7fa/0xab0
 netlink_dump+0xd47/0x10f0
 __netlink_dump_start+0x702/0x9e0
 rtnetlink_rcv_msg+0xb6e/0xf20
 netlink_rcv_skb+0x170/0x440
 netlink_unicast+0x540/0x820
 netlink_sendmsg+0x8d8/0xda0
 __sys_sendto+0x27a/0x3f0
 __x64_sys_sendto+0xe5/0x1c0
 do_syscall_64+0xc5/0x1d0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

