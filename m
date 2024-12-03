Return-Path: <netdev+bounces-148604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8579E2974
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6056164741
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3171F9F7C;
	Tue,  3 Dec 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d0ctjSfi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401951F8AD2
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247448; cv=fail; b=mnOPqPpVSpwwi5z97QV4p6pluaClRHqo3nfV0jSdnNFJwd5RSScLbXYieqea8j3R1PJf0tcaGtHBJNsDL4NS0S/11uBec0R0vpuBbqCPgBfMG0FE8IB31kadaHMYnP8Qz23IU6ZqrAZUGK+4xoB6YTMA407zp+JY3N2PhdYYgfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247448; c=relaxed/simple;
	bh=OaZy6C4uT1c6jxoIHicF0cy/zrRyxoxgHHmZNre92qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aGBkqcIpm4fz8dDqehc2zK5gkKpeh7FkSr/2pwaRN5UzxB7Lv3LRt7CbFgnmB3VG3VVxQRbvhxKJP67DSsTG7y5g5oD/2C5Fm01JUhyS2zUFcZvtL4fk60tIWdj3YElcC//a+Tzxw9cHBiBq0J0PT46sLMsCxFn5Lsg3xDOIWKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d0ctjSfi; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghFJjpvJE26e7BnG1zv6QwQi8//LSS3cl58XcxThXdVtyhISiP4h2c+R0cSnixdcQ33L51ZgzTz3lajgfreC8lYJ9hSsCEEarkdQrXa7NlcL3QdshitOVvax2wrDTgKJCGpye+tV+QIVw3XUY5IOoMr5oNsuzyW0IdMmvU9W7tHnDuDa28NM+motZ5OScoBsiCT+gvJVmYGC1qDtaAVbVkJsib/Jy9deKiwsEZZEAGbKJJ85GQP35FV0R7JfvB84bHBO12UCTMhBvrGUgGPhrwUlrzs6SvT6LasdDsdTS4EVcO7WW7aidw6BDGcMwp4b8wow5mTza4T93Dp9nhJaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZzmCm32H6sbzxwn44dc+2+LgUF/2qhQsXSXN4m+9Ac=;
 b=SfePdtw8tj9mxDeRKFUtZtlbmS7VpMDnQV/JEC1EJ6hWXEL7BCJ5WI7exirU63kfGa6vLflTZTtl6QS64kslTRD53ea8eqagavubW1+IYQgDA1mTGOInoMv+8YGwHsJ+VwGuPZ1mia3O09iTgzL3PVIArBV5QzUlLF5UBmWW/UKwcuk5EhjaJJJ1l6ShTROxxpWmHQs+cqaymTx+Vgeh242aw9omxgUNVH7/v+xbn5Eop5zTaUh89TfsoSbY493is07oHSttqpWrCLGYTdZZ/u4r3qohUMokFK1/mZktD3VK+qLDCYL9LqOMzpp/naEyXKV4fSnV8hNH/ajhAs40dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZzmCm32H6sbzxwn44dc+2+LgUF/2qhQsXSXN4m+9Ac=;
 b=d0ctjSfinaYITYVvRbkXmZItaksOdKfILHhsEtxChsSm0DNWi0NXlcJHpqJPAPAp6iJclbq/bowtq3YdwXEjhHM8n/HU1Q9DJM8ElNtl/ca3PwfmmJaVewe/DM6hdKSa9146I6kAkNjaczVF7R5nMPw8fQMcE2KMAmlATwHu8ksSYRoLqq4jMaTygfF4BCg6vAp1ZI5OgfIItyflUWXRA0gA8ppHvFlAau3ah1xRGMCpfCw7YM/8SQcuDInTd607Lu14v1/i4OfeylgT6HO+T1jipR0+oXj0JfmVIils/xUrhs04Sn+dMuMFR5/zEM+AfFZFKqiSn/nEaHW2zXSUHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 17:37:21 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 17:37:21 +0000
Date: Tue, 3 Dec 2024 19:37:18 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
Message-ID: <20241203173718.owpsc6h2kmhdvhy4@skbuf>
References: <20241203170933.2449307-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203170933.2449307-1-edumazet@google.com>
X-ClientProxiedBy: VI1P195CA0083.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PR3PR04MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b8f806-f94b-47ad-b766-08dd13c12405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHjeryrsuyxJatw8JkxID9yuxAkeByeAZe2wJpHR25qta3gh6Zr0ddy2Z2wE?=
 =?us-ascii?Q?hstrtP7+jKkOvAkj9eEq2OwkjEgqKCvr5z2jcdBpdZGz/cvnJ2X6riv9zrvA?=
 =?us-ascii?Q?CVix0yizOhAws+XLwSDaf1jZhBzkiBr6pWAwjueF1p89xWEh/61uhAJsFiNz?=
 =?us-ascii?Q?Dw86YLcZOEhIh5Sx2wLHVFNHks01trYkI3nd2/1sf4zFaIFSK+ZMmLqut8iJ?=
 =?us-ascii?Q?IymFE1Z4/VFtTHoyT7CEOyCkRqIjzQZAN3yx6/z/MiFI9r2yBow++gLqZJC0?=
 =?us-ascii?Q?fUzXfibCI9BRMO+vKUd9tABIchZQCXDwqhnZpNyG5G3fxd9ad+8ocLv5Se2F?=
 =?us-ascii?Q?S6+qgrLfHLFmh+wTnYGFLNorEmtneI/uWX5vRuA+O1RQ4vVt4IuMkoUZog3X?=
 =?us-ascii?Q?c0iov+tZkcrOkYBXSrXV0/jfT2c51wwQJZr/AFaS8x38Jya/EaSOtwtJsR90?=
 =?us-ascii?Q?oiq6TTMrlA2KGaOPap+Iv0ElngSpXFEtqYxzoxLAP9xIieTN0stLTpRZiLqw?=
 =?us-ascii?Q?kRQOPrpU5P0zgilDPZZ5y7+DHpXP25Vfat5yCMSv5b78r2JcSlDTKmck2s8v?=
 =?us-ascii?Q?EboOZHPIs8WB1HSzbHJstU2T0ZAzvkT9TV5VNpI4D40iTJM8kkfm4YdLDZdL?=
 =?us-ascii?Q?CjxaB/5+1bZCObqBBAp7rhWDJUSUg+U+TZiTA8wqZ2SooIKGk45JZwQI+/8R?=
 =?us-ascii?Q?gnpuxR80ES9qwsqYJ4rVTJLQjimk2LWBlCSsvfVub0tH+TqW11b5aN9Dk270?=
 =?us-ascii?Q?Tnca0G/K/xgkH23lcH+TwRg31K/i083hCaW5J+czRIIyftd9voyyPZCjAbnz?=
 =?us-ascii?Q?sb842o7yguHtRVPENbJdoAjqHK7Y5Cbt8WqrCOHAjWuwbf1x3ARiB8HdBsKi?=
 =?us-ascii?Q?00ieI6yILlpYIo6hviLZ4wS6tB4P9eN3srNCPhYOeXlnW8lswP1dJtUrAU6v?=
 =?us-ascii?Q?G4ylMgX0AAi0B6noltqZzCaI0uxnBrW4Oge/HxVxTGUeWqzCG5wh1dMLdrmH?=
 =?us-ascii?Q?71o6gfokf1Pk/RgpLalU+VHEKdJOK6RUinOfwKF63fJjm9DcGN3CNE/mwQpl?=
 =?us-ascii?Q?RmSjT5iAhXFC5rcObmxAre0yLSdXnlVHHES69F9VjWbB3arICsrveEwNSCMf?=
 =?us-ascii?Q?k4bKJaKUOcQ+kWSg8iLz+tSq4iE+8FO1a0UiZKO5LgMrpy6zRMZqNkVD3/un?=
 =?us-ascii?Q?DroYFEefGDQHxpSWSaJJkbG3f9pI+gMZ5Tom/8NtexD1JtSkRp6TIjGcz2Ov?=
 =?us-ascii?Q?+eH/r6RvL40+NOu4dk+jWgH4VXv088oSWKCo1aelsLW/r4UnV2buS/5GGnqE?=
 =?us-ascii?Q?1L0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrT/N1OmAt5e0o46xpTNNo58VbFGkb5LPwFlFzwOsa756HhB7NnvBCs9t1Q/?=
 =?us-ascii?Q?EpDue5guIpXwoZfL4lHofQbPAEnZTcnE2H3N09N3naM4n04q6f+Kq11cnhsY?=
 =?us-ascii?Q?vSru7m93tw6MBh1KF5mvVoV9gHiRPjbZlrMEuaRvYEcy/8WUP67N5aya3Hwm?=
 =?us-ascii?Q?WMeea/PYwOO2E/1pUHIgrUewZMYDwUr22axvB4IIHIceXWAcjJ3dozbh0p35?=
 =?us-ascii?Q?+YMfF2rvINewFjQjIeI/Xk0S/fd5UL+A0/wedKhcZknyeGHdUgh3F4zFfylA?=
 =?us-ascii?Q?ANmtaJuxSydAYpOrewTCVMWKgQQ1gQotT6GyPwpPQ4Jc5netI5uDEkSQoPzO?=
 =?us-ascii?Q?hXZQkn5BiRGzG0jcdCR6+OQShkf6ebe3ZwYjj/6mHz30cULgyFR/GNflte6y?=
 =?us-ascii?Q?cyKKyb76/MrT7395vFW7HmaIcubA1FSKapVRoC7im0QzEikYs3uZ8Kmrr8FQ?=
 =?us-ascii?Q?AOSgjWPRgdr/iLOQ3kH7QmX9+AM330MeFIz5DZnvPqGPfzJgi7qxojo6lcmZ?=
 =?us-ascii?Q?IEuzlVADy1/+7R22CUwnakUjxLcZ27cPns2MIdZGqaAJgLknuoCyNevgcAHH?=
 =?us-ascii?Q?qRMnX3qYBfmhpGexw6OGcA3XLeeMtA/EEjvuBrVS0oyqgN8R7NinQY0Qg6EB?=
 =?us-ascii?Q?a3Wv5EuVLDBF1l3pe21z2Vp6Q79m/PYRhZ2Cf7P3Fy7yPFeiHmmhoN2YCFDS?=
 =?us-ascii?Q?aX8FTjiYaq4FPy/VmKOyBDUjpG6/VkQINcvoGJH57tN0jFAHycJrNN8mIx7S?=
 =?us-ascii?Q?qywHBjpuqlJm2Ju4EXhTlrEYsUiQDCIGj1Ob2LH0/RVVqqhZSDxzAsr5vZTf?=
 =?us-ascii?Q?r+iN4kBhbF3KvP9uozwK3iy44Pw7KQuExkC/tFTfEBwi4/4oZNGZK80H3w9f?=
 =?us-ascii?Q?SkVQ+9htm7nVrO/yspVXKiWKMfpJnThNTs5M0ibFIFcHwEx0oZumbSu36B9C?=
 =?us-ascii?Q?revqcaKnapDCMAiADet9eQuPmHbzUKgf94GYzrKA/DxLqpmTXhgbQ2crYIG8?=
 =?us-ascii?Q?cGffyQPHG8kyoO1DZAOBtTUpCJK+jfPH5pqerJ8rXAU5SN9K9kubNuFJGk3S?=
 =?us-ascii?Q?gHOm+XIL8x0JiyxvyXtvzOXXEEh201eoHXmYa5DTvAtN+C4Y4IRMBhN5QPQR?=
 =?us-ascii?Q?PuNLfFoyPLz486CHuV3v/J+o45H27K29bK84NdY4cc1FWXy6kLRMPEgWDGbN?=
 =?us-ascii?Q?9rwO9l6tnxFoODjRHlLahCrNN0mbfPmWeCCUp7/+SnnnBpIH8cRWcF9J42tf?=
 =?us-ascii?Q?zZ3KyvT/h5woS6kQYq1fKHnSM33IICoxgbjQ/sBHdUTABm2HI5igF0EblqTm?=
 =?us-ascii?Q?/cAa7CNFhJRgH/Ia4eh1lVTLEBDhgXa1JjQA8rCF8x4dpfxxBGYTpm4ywBvM?=
 =?us-ascii?Q?fp8uUFgfLMXf+bX7mhJNs3h+03GEMHextzxo6ynT21P6dgOhS5SBhpxydM1d?=
 =?us-ascii?Q?BLA37bvFZPplGRdaqIh5mGmMLckFx85rvQXYGZvPtxv0LYpe1zhwjc9DPQoo?=
 =?us-ascii?Q?P4laUVp3jYr+wPdDjlC2ItKU0vEmRFJ9FGGV9S3jgZwLpe/1QuXZ075FrWs9?=
 =?us-ascii?Q?bmbrivnaqMlIYUvK1G0TAPg7/xNmvvAb3xQoTGNpIw13tsoIw9QXjETGLj3g?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b8f806-f94b-47ad-b766-08dd13c12405
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:37:21.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oRcEhPcsCYO+3ZaDkqeF1uEOe0YkpJi7QiwGzWW1GMmB+hZpCsR+McliBbSgQexZXf9SYLNnChELewQCt8a1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322

Hi Eric,

On Tue, Dec 03, 2024 at 05:09:33PM +0000, Eric Dumazet wrote:
> syzbot reported an UAF in default_operstate() [1]
> 
> Issue is a race between device and netns dismantles.
> 
> After calling __rtnl_unlock() from netdev_run_todo(),
> we can not assume the netns of each device is still alive.
> 
> Make sure the device is not in NETREG_UNREGISTERED state,
> and add an ASSERT_RTNL() before the call to
> __dev_get_by_index().
> 
> We might move this ASSERT_RTNL() in __dev_get_by_index()
> in the future.
> 
> [1]
> 
> BUG: KASAN: slab-use-after-free in __dev_get_by_index+0x5d/0x110 net/core/dev.c:852
> Read of size 8 at addr ffff888043eba1b0 by task syz.0.0/5339
> 
> CPU: 0 UID: 0 PID: 5339 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:489
>   kasan_report+0x143/0x180 mm/kasan/report.c:602
>   __dev_get_by_index+0x5d/0x110 net/core/dev.c:852
>   default_operstate net/core/link_watch.c:51 [inline]
>   rfc2863_policy+0x224/0x300 net/core/link_watch.c:67
>   linkwatch_do_dev+0x3e/0x170 net/core/link_watch.c:170
>   netdev_run_todo+0x461/0x1000 net/core/dev.c:10894
>   rtnl_unlock net/core/rtnetlink.c:152 [inline]
>   rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
>   rtnl_dellink+0x760/0x8d0 net/core/rtnetlink.c:3520
>   rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
>   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
>   sock_sendmsg_nosec net/socket.c:711 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:726
>   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
>   ___sys_sendmsg net/socket.c:2637 [inline]
>   __sys_sendmsg+0x269/0x350 net/socket.c:2669
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2a3cb80809
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2a3d9cd058 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f2a3cd45fa0 RCX: 00007f2a3cb80809
> RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000008
> RBP: 00007f2a3cbf393e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f2a3cd45fa0 R15: 00007ffd03bc65c8
>  </TASK>

In the future could you please trim irrelevant stuff from dumps like this?

> 
> Allocated by task 5339:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>   kasan_kmalloc include/linux/kasan.h:260 [inline]
>   __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   kmalloc_array_noprof include/linux/slab.h:945 [inline]
>   netdev_create_hash net/core/dev.c:11870 [inline]
>   netdev_init+0x10c/0x250 net/core/dev.c:11890
>   ops_init+0x31e/0x590 net/core/net_namespace.c:138
>   setup_net+0x287/0x9e0 net/core/net_namespace.c:362
>   copy_net_ns+0x33f/0x570 net/core/net_namespace.c:500
>   create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
>   unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
>   ksys_unshare+0x57d/0xa70 kernel/fork.c:3314
>   __do_sys_unshare kernel/fork.c:3385 [inline]
>   __se_sys_unshare kernel/fork.c:3383 [inline]
>   __x64_sys_unshare+0x38/0x40 kernel/fork.c:3383
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 12:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2338 [inline]
>   slab_free mm/slub.c:4598 [inline]
>   kfree+0x196/0x420 mm/slub.c:4746
>   netdev_exit+0x65/0xd0 net/core/dev.c:11992
>   ops_exit_list net/core/net_namespace.c:172 [inline]
>   cleanup_net+0x802/0xcc0 net/core/net_namespace.c:632
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> The buggy address belongs to the object at ffff888043eba000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 432 bytes inside of
>  freed 2048-byte region [ffff888043eba000, ffff888043eba800)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43eb8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 04fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
> head: 04fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
> head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
> head: 04fff00000000003 ffffea00010fae01 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5339, tgid 5338 (syz.0.0), ts 69674195892, free_ts 69663220888
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>   prep_new_page mm/page_alloc.c:1564 [inline]
>   get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>   alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>   alloc_slab_page+0x6a/0x140 mm/slub.c:2408
>   allocate_slab+0x5a/0x2f0 mm/slub.c:2574
>   new_slab mm/slub.c:2627 [inline]
>   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
>   __slab_alloc+0x58/0xa0 mm/slub.c:3905
>   __slab_alloc_node mm/slub.c:3980 [inline]
>   slab_alloc_node mm/slub.c:4141 [inline]
>   __do_kmalloc_node mm/slub.c:4282 [inline]
>   __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4295
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   sk_prot_alloc+0xe0/0x210 net/core/sock.c:2165
>   sk_alloc+0x38/0x370 net/core/sock.c:2218
>   __netlink_create+0x65/0x260 net/netlink/af_netlink.c:629
>   __netlink_kernel_create+0x174/0x6f0 net/netlink/af_netlink.c:2015
>   netlink_kernel_create include/linux/netlink.h:62 [inline]
>   uevent_net_init+0xed/0x2d0 lib/kobject_uevent.c:783
>   ops_init+0x31e/0x590 net/core/net_namespace.c:138
>   setup_net+0x287/0x9e0 net/core/net_namespace.c:362
> page last free pid 1032 tgid 1032 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
>   __slab_free+0x31b/0x3d0 mm/slub.c:4509
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4104 [inline]
>   slab_alloc_node mm/slub.c:4153 [inline]
>   kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
>   __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
>   alloc_skb include/linux/skbuff.h:1323 [inline]
>   alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
>   sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2881
>   sock_alloc_send_skb include/net/sock.h:1797 [inline]
>   mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
>   add_grhead net/ipv6/mcast.c:1850 [inline]
>   add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
>   mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2234
>   ipv6_mc_dad_complete+0x88/0x490 net/ipv6/mcast.c:2245
>   addrconf_dad_completed+0x712/0xcd0 net/ipv6/addrconf.c:4342
>  addrconf_dad_work+0xdc2/0x16f0
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> 
> Memory state around the buggy address:
>  ffff888043eba080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888043eba100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888043eba180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                      ^
>  ffff888043eba200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888043eba280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> 
> Fixes: 8c55facecd7a ("net: linkwatch: only report IF_OPER_LOWERLAYERDOWN if iflink is actually down")
> Reported-by: syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/674f3a18.050a0220.48a03.0041.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/core/link_watch.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> index ab150641142aa1545c71fc5d3b11db33c70cf437..1b4d39e38084272269a51503c217fc1e5a1326eb 100644
> --- a/net/core/link_watch.c
> +++ b/net/core/link_watch.c
> @@ -45,9 +45,14 @@ static unsigned int default_operstate(const struct net_device *dev)
>  		int iflink = dev_get_iflink(dev);
>  		struct net_device *peer;
>  
> -		if (iflink == dev->ifindex)
> +		/* If called from netdev_run_todo()/linkwatch_sync_dev(),
> +		 * dev_net(dev) can be already freed, and RTNL is not held.
> +		 */
> +		if (dev->reg_state == NETREG_UNREGISTERED ||
> +		    iflink == dev->ifindex)
>  			return IF_OPER_DOWN;
>  
> +		ASSERT_RTNL();
>  		peer = __dev_get_by_index(dev_net(dev), iflink);
>  		if (!peer)
>  			return IF_OPER_DOWN;
> -- 
> 2.47.0.338.g60cca15819-goog
>

Thanks for submitting a patch, the issue makes sense.

Question: is the rtnl_mutex actually held in the problematic case though?
The netdev_run_todo() call path is:

	__rtnl_unlock();						<- unlocks

	/* Wait for rcu callbacks to finish before next phase */
	if (!list_empty(&list))
		rcu_barrier();

	list_for_each_entry_safe(dev, tmp, &list, todo_list) {
		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
			netdev_WARN(dev, "run_todo but not unregistering\n");
			list_del(&dev->todo_list);
			continue;
		}

		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
		linkwatch_sync_dev(dev);				<- asserts
	}

And on the same note: does linkwatch not have a chance to run also,
concurrently with us, in this timeframe? Could we not catch the
dev->reg_state in NETREG_UNREGISTERING?

