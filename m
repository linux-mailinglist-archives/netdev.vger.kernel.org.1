Return-Path: <netdev+bounces-13232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF673AE49
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253D81C20C2A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 01:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF437C;
	Fri, 23 Jun 2023 01:26:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25E363;
	Fri, 23 Jun 2023 01:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2E0C433C8;
	Fri, 23 Jun 2023 01:26:16 +0000 (UTC)
Date: Thu, 22 Jun 2023 21:26:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lingutla Chandrasekhar
 <clingutla@codeaurora.org>, Frederic Weisbecker <frederic@kernel.org>, "J.
 Avila" <elavila@google.com>, Vivek Anand <vivekanand754@gmail.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Thomas Renninger <trenn@suse.com>, Shuah
 Khan <shuah@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Regressions
 <regressions@lists.linux.dev>, Linux Netfilter Development
 <netfilter-devel@vger.kernel.org>, Netfilter Core Developers
 <coreteam@netfilter.org>, Linux Networking <netdev@vger.kernel.org>, Linux
 Power Management <linux-pm@vger.kernel.org>
Subject: Re: High cpu usage caused by kernel process when upgraded to linux
 5.19.17 or later
Message-ID: <20230622212614.5eb20dad@gandalf.local.home>
In-Reply-To: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 07:58:51 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > kernel process "kworker/events_power_efficient" uses a lot of cpu power (100% on ESXI 6.7, ~30% on ESXI 7.0U3 or later) after upgrading from 5.17.3 to 5.19.17 or later.
> > 
> > dmesg log:
> > [ 2430.973102]  </TASK>
> > [ 2430.973131] Sending NMI from CPU 1 to CPUs 0:
> > [ 2430.973241] NMI backtrace for cpu 0
> > [ 2430.973247] CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted 6.3.3 #1
> > [ 2430.973254] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > [ 2430.973258] Workqueue: events_power_efficient htable_gc [xt_hashlimit]
> > [ 2430.973275] RIP: 0010:preempt_count_sub+0x2e/0xa0
> > [ 2430.973289] Code: 36 01 85 c9 75 1b 65 8b 15 a7 da f8 5e 89 d1 81 e1 ff ff ff 7f 39 f9 7c 16 81 ff fe 00 00 00 76 3b f7 df 65 01 3d 8a da f8 5e <c3> cc cc cc cc e8 98 aa 25 00 85 c0 74 f2 8b 15 da 71 ed 00 85 d2
> > [ 2430.973294] RSP: 0018:ffffb15ec00dbe58 EFLAGS: 00000297
> > [ 2430.973299] RAX: 0000000000000000 RBX: ffffb15ec12ad000 RCX: 0000000000000001
> > [ 2430.973302] RDX: 0000000080000001 RSI: ffffffffa1c3313b RDI: 00000000ffffffff
> > [ 2430.973306] RBP: dead000000000122 R08: 0000000000000010 R09: 0000746e65696369
> > [ 2430.973309] R10: 8080808080808080 R11: 0000000000000018 R12: 0000000000000000
> > [ 2430.973312] R13: 0000000000001e2b R14: ffffb15ec12ad048 R15: ffff91c279c26a05
> > [ 2430.973316] FS:  0000000000000000(0000) GS:ffff91c279c00000(0000) knlGS:0000000000000000
> > [ 2430.973320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 2430.973324] CR2: 000055fc138890e0 CR3: 000000010810e002 CR4: 00000000001706f0
> > [ 2430.973374] Call Trace:
> > [ 2430.973388]  <TASK>
> > [ 2430.973390]  __local_bh_enable_ip+0x32/0x70
> > [ 2430.973413]  htable_selective_cleanup+0x95/0xc0 [xt_hashlimit]
> > [ 2430.973428]  htable_gc+0xf/0x30 [xt_hashlimit]

I take it that the "gc" in "htable_gc" means "garbage collection". It may
not have anything to do with changes to this thread. It could very well be
something is feeding it too much garbage!

-- Steve


> > [ 2430.973440]  process_one_work+0x1d4/0x360
> > [ 2430.973459]  ? process_one_work+0x360/0x360
> > [ 2430.973467]  worker_thread+0x25/0x3b0
> > [ 2430.973476]  ? process_one_work+0x360/0x360
> > [ 2430.973483]  kthread+0xe1/0x110
> > [ 2430.973499]  ? kthread_complete_and_exit+0x20/0x20
> > [ 2430.973507]  ret_from_fork+0x1f/0x30
> > [ 2430.973526]  </TASK>  
> 
> See Bugzilla for the full thread and perf output.
> 
> Anyway, I'm tracking it in regzbot so that it doesn't fall through
> cracks unnoticed:
> 
> #regzbot introduced: v5.17.3..v5.19.17 https://bugzilla.kernel.org/show_bug.cgi?id=217586
> #regzbot title: kworker/events_power_efficient utilizes full CPU power after kernel upgrade
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217586
> 


