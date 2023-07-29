Return-Path: <netdev+bounces-22472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17A767964
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC9928272D
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C7194;
	Sat, 29 Jul 2023 00:17:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C017E
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:17:38 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13263212B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690589857; x=1722125857;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=H0Uo/Kci2n+y5xMjSl5k3S8yYTOlsGMn2lVabsORRHI=;
  b=FXCyWVREm8vUemBEokJRHA3SqnPVuEAY8hh79/TWDijC18wEJEHCuuvK
   TF90rE5BirdazFD191GG9AXCarDY3NdnOGKVMaaNv8daPKGiLAXcn3iJA
   E/9zcIfbKkP9Ygi+5GPMDlmJLlkR15vDWQBAprKh/ELTWZD1BMHmtHguQ
   VQqkPqn8IGloJVZF7FsUbIEDbEJw7K20QXkF+KXv3RQPPHb3PUt/dhwJu
   YAJDjrkk3N7R9uPgp1cC6CoWD7vY9kVsOppxkB1JajHYdXYg/lnPc8PCv
   WuwG2rG83AIXDUxeDr6DERoOJPIYv5R40bIrRGx6xVkHb0MYsPzsTFmok
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="434998993"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="434998993"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871007846"
Received: from preyes-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.255.230.246])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:17:37 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal
 Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>
Cc: Vedang Patel <vedang.patel@intel.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>, Pedro
 Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH v3 net] net/sched: taprio: Limit
 TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
In-Reply-To: <20230729000705.36746-1-kuniyu@amazon.com>
References: <20230729000705.36746-1-kuniyu@amazon.com>
Date: Fri, 28 Jul 2023 17:17:34 -0700
Message-ID: <871qgr371d.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

> syzkaller found zero division error [0] in div_s64_rem() called from
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
> set max for cycle_time.
>
> While at it, we prevent overflow in setup_txtime() and add another
> test in parse_taprio_schedule() to check if cycle_time overflows.
>
> Also, we add a new tdc test case for this issue.
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
> Co-developed-by: Eric Dumazet <edumazet@google.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Cheers,
-- 
Vinicius

