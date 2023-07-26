Return-Path: <netdev+bounces-21356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36F87635E0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D283281DBB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6FFC126;
	Wed, 26 Jul 2023 12:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EBCA4C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:11:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2095.outbound.protection.outlook.com [40.107.244.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA71739
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3WCwmMYwTwfccG9+izuWERzTvirnAuuNGTy5wrsjYjC+QQAEmp3a+fyRxoVL4DC6O63OcpHN3eddJXwSUE6WdwSkhu5S3gVnhH48weyl3zHbkYMuzP29M2UEnpPsaWM+yEOk9YiMHgqW4EyzgqC4QHgZeVSYp90d0Tx5m1rpSYvocCxIqrCuMpn9OZlf0qf8wikZLTjzmkAWlRAMM5x2sj4LOek5S5G5T5FFzGbR15bp9vzrPfREqYyn8WDxzpAdhzlAfCSWDQHlvzKciPwANdThjvM01Lx9KhFWW5WLa6uiMh1xrH4gs6oOTve3BWxXFdncoG2K86+VlGsNpypJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpipeLmJgEx03bEum2q0znlULJjUfggMF2HiLAdm4Tw=;
 b=Oi1uaB7PH33D9uHjmf6Ev0FOK60TemR0r/BieSENE6uxcTBQyT0XeHhgGI+9adXrSR8xzcRTW0Z/ixFzBuqwfU8cRNixr+ECOU9fEdemsiZM+cWr3U77GFk0ZPzlEr9hZx2MIOjyCTwKmroXyZ8pbZrfT1Uks5o7A+6Z4yBEB7NSCMK90Ps3US9KWGJ87L4FMADWKANrAGpWKWUXppfXvcQArMiYeiOdXCcXuAnCrSPtJ5kB7WJAFw9mAH0uhqhufNrNfxhreyJONrngihZrDF35M+LZQLbQHHGyeoAygJc8kIWX8ugPvgE6fuLR+GczglcsAaCn3U79swwkyXnH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpipeLmJgEx03bEum2q0znlULJjUfggMF2HiLAdm4Tw=;
 b=b6l8Z3C0juL6Y2Nl/7LQHDmrO1ZybaItiZ4bQqjxMvT61dpWqpZeNXIG+s8pN6GdNlUrLjklxf7KX60HJ4PqicAo+KEniyFfQJBc3nZ+t4bJib+jnp7cNr0CjRehK2LRaOxjWvzdWqpCRG1w4EU0ko5YYVvWn43KCAOQAW8JBjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5710.namprd13.prod.outlook.com (2603:10b6:806:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 12:11:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:11:09 +0000
Date: Wed, 26 Jul 2023 14:10:57 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Vedang Patel <vedang.patel@intel.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] net/sched: taprio: Limit
 TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
Message-ID: <ZMENUf0/vg/zBtzf@corigine.com>
References: <20230726011432.19250-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726011432.19250-1-kuniyu@amazon.com>
X-ClientProxiedBy: AS4P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e137fa-042a-4238-206d-08db8dd16536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/wCE4Zz28jYoLvZmT7mIfDBpaEJY7df9U0kLNYBnU5rDcFqCmoRWp3v5S603HWSFmmi0JPf1tdKWkKmKdV1FlcQwMIYqPnNt2hNZUpr7NvctVnjflKGc8PMtiDNbrkuir/cyfDt/EYOeJXZTsexbAUyCG2VvxOSLiXM/F+ViL6wvTi9+oFP2+Y2Awij82QFSs/IywdRVpoNURu5ORDGC12ZHJxuuUpTWsuIw9hYX4LSQlQQnVYyPeYIZjVyfKTD1PeJINOSDbwyo+PqsTL4VGn8+m6052+0kSDT3Kf2Ts1SEXsDq1+ool+ck//JQ0kYKHXUSVxe8IRrCMlRritAeVWEl1xL3okLbRbEehVnKPq7c5xNS3CG7GvRPuYJxBaIPSZzG1XmmwhMO+wofZVLLxTvWM3IQrle5d/Q+ZQtl64pFgIpXxnyzMgGuODzt0SnQw5SfMI0XckXnzBuIxfTVeixq6HjWZ9O/X+CWjY2BeY1fII3CjHIcLmrpqqo/EzmQ5VCWMQH0TJ/A0FqmIWMKateGFrA2d9kBl5b4JarZM3yFdNAZE9Y4jw9N/JpYdAxQ5lfp1WSHdJc07A8JgZLPF9Ec9Lmf/IhiiX/lRXB/314=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(136003)(376002)(366004)(396003)(451199021)(7416002)(8676002)(8936002)(44832011)(5660300002)(2906002)(38100700002)(478600001)(2616005)(45080400002)(36756003)(6666004)(54906003)(6486002)(6506007)(6512007)(186003)(316002)(86362001)(41300700001)(66946007)(4326008)(66556008)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHegtkhC1bdbV9z4y9tj46LBiAciww3q7J5G5eCeG48RBXzP5p8b7oCjX5qP?=
 =?us-ascii?Q?kvhv+qpGTZoegnj1wpfLqfYyDBI7VQF65RqtE4R8JPaNmFdDrz+IbVY3t4zO?=
 =?us-ascii?Q?fgk1lPjGwUItOKnbeXx4Y4w0DcWTNptPkpm4Jo4NrPFi0SDHG8fFQvvToJ4N?=
 =?us-ascii?Q?McDiLIkQcLiggySoSkFLtKqf2sAREtszUjSUy9L66lZen/TOgLRDNjf88tCA?=
 =?us-ascii?Q?YcvMkxOCejcahVqCcgUue5S7c9SVmc3Qba+0hbYgM53sDaj/wEyTbVFjMDeu?=
 =?us-ascii?Q?RiBMcAGXgKLwaxp7cuTavXyG3bn5W3JaqPYh8uvid5GOBQmpzA6Vul+HSEWr?=
 =?us-ascii?Q?QfuPNANlWqLRq8pnpSuGPxtmzdFz3eWHbd1+vrcymagt78+AhXP16aTo7iB4?=
 =?us-ascii?Q?HdeP5F8fbdsah2idYq0ki3p3b3gMIOgi+HY1MjfH0nBycGDaYyVZUYwKFDZG?=
 =?us-ascii?Q?QWh4+offLnXnU01Mb6M49KMPmHoTzw4RzqW7dT4cJLNOKgv7bIc0OP26IUak?=
 =?us-ascii?Q?HBXX9XD9A6/kQqzgfYxF+GZCCLjUFJSWaq6smxLfWQt702AfdGUHIwVCGuk2?=
 =?us-ascii?Q?qPyFnNe1MI6qWzjrQTvh4H+TUnUix2gOCZHILNr4CN37/d1k4FIFH6gzFs03?=
 =?us-ascii?Q?X96tJPBE8FyHGyMw4dr8ZR3/DenGLx9HCMZjP9EYxJF4IsiLv84cprS8CG+2?=
 =?us-ascii?Q?r8U2/7t7YPJpmZ+LNyNKANe9W2bJvhbQ4exkeHjZsLigIAu1mzI5ztUUkAJ3?=
 =?us-ascii?Q?XwH6nm4739xwColCwJJhhEegboYkqjTUMzELQFx3yXSxivNMpVk0BQr/qvat?=
 =?us-ascii?Q?Ig/vh0gKpYxuV2PC/slP+6DeFfmZd3TM/cD8XLlLk8p5nlS7/2PZQh6vVw3B?=
 =?us-ascii?Q?5zClyUy7uP6t7mFNUiiqtMQeAcXkEqOAcTCsztl70042+8qwwWklCD+/2bJh?=
 =?us-ascii?Q?t/ZRbeIoKWCwEQiCDLAKV1qhvFlGLIOGZBhqG+jNM+LjZ+u/6bxWBFt4B25+?=
 =?us-ascii?Q?lKNIQ1awxUSh5BGj5Cz9BVepQ2Nn90ru5Fl5pxJyLVp0xl990fhXvJ0QTUsg?=
 =?us-ascii?Q?zolxO+G9CuvL2rSYPpVxr4uaBYotSviexgopIYionBBxXUVoZNivWLpNXLTs?=
 =?us-ascii?Q?YZCd8yVl85HYBZpMTA+B5Hm5tozXokiBJluKZIb9RObTue66+0sGxo97UGxW?=
 =?us-ascii?Q?b6tBI1FJJSqGwAYYtFr8avUJoxo/4UW9GVlqmz5QnHcCRWpGkATGZDLJLYY8?=
 =?us-ascii?Q?pb4Ox1Dr3o7Q/S8JPUCczDTJJz1TFE0wF7/xVu9y5NShDZPBQiYlvpdl0gel?=
 =?us-ascii?Q?TbRA6b4H3XRh5EDFjRnPEHEwoPw0XhS9nIOcanhjlNR+XZ6WZl2LR04bLewH?=
 =?us-ascii?Q?utOKprnjX7pxnr1LdLxnhzRxvWXWpS2IrA2M6HLsk6XFhzrMLwLSf19UbcKW?=
 =?us-ascii?Q?1AasZWeDoGc63gmHdbnNRQ/STak8D+2CJm+sLnp2MOEOLgmBmWOSbxFVi2Qg?=
 =?us-ascii?Q?HK6kJW7HXP0teKz7vvZtK0vU0j/hZDEqwhpw1KdMoBdP8EbZ/OjaRjMh97bz?=
 =?us-ascii?Q?LnU56e6nN0HgBNzS1xAtm4NopGOzZ1Cfs235NGt5JQxvqFjQ9EPHfMf0VAmE?=
 =?us-ascii?Q?EbbaDorvmV5+01JWJRsyNwdGfbJ7Q+NzBFkFcgfk8sQvfx6RNijlPFrCvfU/?=
 =?us-ascii?Q?sZd0MA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e137fa-042a-4238-206d-08db8dd16536
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:11:09.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5yNw29WzdUy5tHhAg6QfVDovYgq6r92umLIw+5qJA1E6bR919qFW3Jw7wr+rB8SPL9u5ozyEEhcS2584Uq9hOu1V2Edk3vYQZgrZwu7Sl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5710
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 06:14:32PM -0700, Kuniyuki Iwashima wrote:
> syzkaller found a zero division error [0] in div_s64_rem() called from
> get_cycle_time_elapsed(), where sched->cycle_time is the divisor.
> 
> We have tests in parse_taprio_schedule() so that cycle_time will never
> be 0, and actually cycle_time is not 0 in get_cycle_time_elapsed().
> 
> The problem is that the types of divisor are different; cycle_time is
> s64, but the argument of div_s64_rem() is s32.
> 
> syzkaller fed this input and 0x100000000 is cast to s32 to be 0.
> 
>   @TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME={0xc, 0x8, 0x100000000}
> 
> We use s64 for cycle_time to cast it to ktime_t, so let's keep it and
> set min/max for cycle_time.
> 
> [0]:
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 103 Comm: kworker/1:3 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:div_s64_rem include/linux/math64.h:42 [inline]
> RIP: 0010:get_cycle_time_elapsed net/sched/sch_taprio.c:223 [inline]
> RIP: 0010:find_entry_to_transmit+0x252/0x7e0 net/sched/sch_taprio.c:344
> Code: 3c 02 00 0f 85 5e 05 00 00 48 8b 4c 24 08 4d 8b bd 40 01 00 00 48 8b 7c 24 48 48 89 c8 4c 29 f8 48 63 f7 48 99 48 89 74 24 70 <48> f7 fe 48 29 d1 48 8d 04 0f 49 89 cc 48 89 44 24 20 49 8d 85 10
> RSP: 0018:ffffc90000acf260 EFLAGS: 00010206
> RAX: 177450e0347560cf RBX: 0000000000000000 RCX: 177450e0347560cf
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000100000000
> RBP: 0000000000000056 R08: 0000000000000000 R09: ffffed10020a0934
> R10: ffff8880105049a7 R11: ffff88806cf3a520 R12: ffff888010504800
> R13: ffff88800c00d800 R14: ffff8880105049a0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0edf84f0e8 CR3: 000000000d73c002 CR4: 0000000000770ee0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  get_packet_txtime net/sched/sch_taprio.c:508 [inline]
>  taprio_enqueue_one+0x900/0xff0 net/sched/sch_taprio.c:577
>  taprio_enqueue+0x378/0xae0 net/sched/sch_taprio.c:658
>  dev_qdisc_enqueue+0x46/0x170 net/core/dev.c:3732
>  __dev_xmit_skb net/core/dev.c:3821 [inline]
>  __dev_queue_xmit+0x1b2f/0x3000 net/core/dev.c:4169
>  dev_queue_xmit include/linux/netdevice.h:3088 [inline]
>  neigh_resolve_output net/core/neighbour.c:1552 [inline]
>  neigh_resolve_output+0x4a7/0x780 net/core/neighbour.c:1532
>  neigh_output include/net/neighbour.h:544 [inline]
>  ip6_finish_output2+0x924/0x17d0 net/ipv6/ip6_output.c:135
>  __ip6_finish_output+0x620/0xaa0 net/ipv6/ip6_output.c:196
>  ip6_finish_output net/ipv6/ip6_output.c:207 [inline]
>  NF_HOOK_COND include/linux/netfilter.h:292 [inline]
>  ip6_output+0x206/0x410 net/ipv6/ip6_output.c:228
>  dst_output include/net/dst.h:458 [inline]
>  NF_HOOK.constprop.0+0xea/0x260 include/linux/netfilter.h:303
>  ndisc_send_skb+0x872/0xe80 net/ipv6/ndisc.c:508
>  ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:666
>  addrconf_dad_work+0xc14/0x13f0 net/ipv6/addrconf.c:4175
>  process_one_work+0x92c/0x13a0 kernel/workqueue.c:2597
>  worker_thread+0x60f/0x1240 kernel/workqueue.c:2748
>  kthread+0x2fe/0x3f0 kernel/kthread.c:389
>  ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
>  </TASK>
> Modules linked in:
> 
> Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


