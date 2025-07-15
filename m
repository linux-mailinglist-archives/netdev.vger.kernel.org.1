Return-Path: <netdev+bounces-207236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9EB06510
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB951AA68A3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7A283FCF;
	Tue, 15 Jul 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcTnOiyY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB568188A3A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600195; cv=none; b=MqoFXrsYiDMois50GhT3PCmF0j0pFlA3jHTFzzmeS2yMw9nHDwnAnmAZlqbHXnK48WdrpP3wu5/4gJBm8gHVm6RIHboYA6UFy9XXkQujdktc6QOliynltTrf9tUaOseS6/sYWT5Rdc+U7Wqwojc+WsKxkWnDFjEek1DEG5000xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600195; c=relaxed/simple;
	bh=pehoxP024czHcd1In25hgG2lQB8pJ4bx/4nZIsPd1ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHiRJXli1462+cC1kqj6lIn/QXaXuBdKR7ljoMkVa/Ira2cFkAvHXxTfTulZqAtGzkT+PeO7g2k7yAPI0LxBUaZcXTXyACryUAfVkX4Ya6dVrlirHuHXXoUwicmWR4yuWsIzmUhg+EmznQz0oUsKVwmcSIgWgHW2XRQc7ION8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcTnOiyY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so5750759a12.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752600192; x=1753204992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrBEHvbyjbBwpnL2v0xLb6watAHES4qPbtV5S8HHU+s=;
        b=LcTnOiyYwsGrTevWwQJQrwuEPPOsCsrP0z5SSqt+dNCu7oqLjwdsyZsRcc7xpE6sPQ
         J7NNYGOJbsd+rdrVF3RNWlVCHsNtHItuzYC9RVa2CzYaZ6RvFL6gmYfnxsiLvqwvLSzt
         BalgoDOcGE/810SLE5Z5qYkBqpI50/5mxTPlEqvP+83toepJ3FJNLKHnc+AH2KqR7aMG
         w+4k9Q15RRNqsdwFqohjfFvYJpCSudDGIoFfE8LKryLM8W6YaNAULiCfGkY+MsFTblQq
         LjJ+kd4ndbQWYxL3GSTclPR7IFaqNN/noqafpa1s3iyFM/1XfIEW9MR3tmop6a42FlyA
         9Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600192; x=1753204992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrBEHvbyjbBwpnL2v0xLb6watAHES4qPbtV5S8HHU+s=;
        b=RE7LDDinRV2fpgH53ZMV87CVdHTgyIuPgo9zgBO2BEVZc23D7zmlZahmFXVyYoFUM/
         chkCUfEaSK1rqTLMlw5haOgAYKEJtFhxOYWvY1J4Zhc4DqrjQY8ZDMuDKbx6tiXONcLJ
         WjCU2I+sWUihTONDzukXbC/Yho+NiPbcSqSj246CB99PRdhnQx/X4fVfKTxeVI4yIFcb
         ZEAbF/NhTTQZ+uHOcIJZS5yEHr/vT/3x+0K0vNjUWM+mXmOQc0KbnZZD4PmyD4UZVZaX
         1KqEEdPTZ9+cU0lxO0XrCFAdx6A0IayNaWwU2hXlnL+tRBSd0ZeoQBa/KaJgIQzTwXgC
         o2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVEd2TMLW/uPLprCXqlSDtnLWJ4yUSFMVuxTUnlQhGAKU+x2w/zB6jiHMVFXvwhhMdh8y0xCMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZw9qs2P5EBKMwM5YMXU8eX6HQrqOdU996IFZ1o6nWyTaXqDt
	rFuWCHh9J021FhG8jIgOjCMHFuARikLqyax9Do0gmxLe0Tpv8baNIJB0
X-Gm-Gg: ASbGncvUy7A+/kTaboGQTlFpoBOX20ww+n9HBKVSok9hthJFBUHaqGSO7nGWRHHolZH
	9LuG4LFJznJN1pfnhKgAyABuWQoj7HJNH9679lpAccUQh/FdxqLz56smM4ya7mhD41XPyv/GB1s
	DCPQ2k3Vd7Rf7tEEE8oGPGA89/3mydDlj+kypx3Go53TPBVjMls9v0xXjeGy5Vk24fYbexO18R2
	Rkolgt6LtRd3W+r44WndOjL5SPVRwggpl8i94h2CkyNdt7b5toJthGkcrA8i7R3j1QYfw7hmoM2
	3/jTn/lq2yuvGm59lWAEy5+3gWRhrvW3sJ/K1rmG6SUiQ9azU9KsqBfwUaMZQpUAbr0Ph1WVEr/
	KFMmjjdSzJFARtDAFhfshTx4TOA==
X-Google-Smtp-Source: AGHT+IF0ibnkkxdp++HmtE0N/dy975JKRQmL8rvO5SycI9Fa8W7qeAs5JxAs0s6yOjGbScUKyYKH1Q==
X-Received: by 2002:a17:90b:1fc3:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-31c9e70024bmr9840a91.9.1752600191586;
        Tue, 15 Jul 2025 10:23:11 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c660sm15581959a91.28.2025.07.15.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:23:10 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:23:09 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHaOfYkrEhxhMEKN@pop-os.localdomain>
References: <20250710100942.1274194-1-xmei5@asu.edu>
 <aHAwoPHQQJvxSiNB@pop-os.localdomain>
 <aHBA6kAmizjIL1B5@xps>
 <aHQltvH5c6+z7DpF@pop-os.localdomain>
 <aHRJiGLQkLKfaEc8@xps>
 <20250714153223.5137cafe@kernel.org>
 <aHWcRp7mB-AXcFKd@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHWcRp7mB-AXcFKd@xps>

On Mon, Jul 14, 2025 at 05:09:42PM -0700, Xiang Mei wrote:
> On Mon, Jul 14, 2025 at 03:32:23PM -0700, Jakub Kicinski wrote:
> > On Sun, 13 Jul 2025 17:04:24 -0700 Xiang Mei wrote:
> > > Please let me know if I made any mistake while testing:
> > > 1) Apply the patch to an lts version ( I used 6.6.97)
> > 
> > Please test net/main, rather than LTS:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
> 
> Thanks for the information. I re-tested on the latest version of net/main,
> which contained my patch, but it doesn't crash on 5e6d. I re-verified 
> this patch and can't connect it with a null-deref in dequeue.
> 
> 
> Here is more information no how I tested:
> 
> 1) I ran `python3 ./tdc.py -f ./tc-tests/infra/qdiscs.json -e 5e6d` 100
> times
> 2) The KASAN is enabled, and my patch is on it
> 3) All 100 results show `ok 1 5e6d - Test QFQ's enqueue reentrant behaviour
> with netem` without any crashing in dmesg
> 
> I may need more information to trace this crash.

Sorry for missing the decoding, I have attached the decoded stack trace
at the bottom of this email.

Also, today I had a bit more time to play with this, I can confirm the
following change makes the crash disappear.

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index bcce36608871..0c59aa2d0003 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1135,6 +1135,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 * choose the new aggregate to serve.
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
+		if (!in_serv_agg)
+			return NULL;
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
 	}
 	if (!skb)

But I am _not_ saying this is the right fix, since I don't look deep
into this. It is only for you to narrow down the problem.

If you need any other information, please let me know. It is 100%
reproducible on my side.

Thanks!

-------------------------------------->

Test 5e6d: Test QFQ's enqueue reentrant behaviour with netem
[  879.667437] ==================================================================
[  879.668309] BUG: KASAN: null-ptr-deref in qfq_dequeue (net/sched/sch_qfq.c:1138) 
[  879.669041] Read of size 8 at addr 0000000000000048 by task ping/544
[  879.669430]
[  879.669430] CPU: 0 UID: 0 PID: 544 Comm: ping Tainted: G        W           6.16.0-rc5+ #542 PREEMPT(voluntary)
[  879.669430] Tainted: [W]=WARN
[  879.669430] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  879.669430] Call Trace:
[  879.669430]  <TASK>
[  879.669430] dump_stack_lvl (lib/dump_stack.c:124) 
[  879.669430] kasan_report (mm/kasan/report.c:636) 
[  879.669430] ? qfq_dequeue (net/sched/sch_qfq.c:1138) 
[  879.669430] qfq_dequeue (net/sched/sch_qfq.c:1138) 
[  879.669430] ? __pfx_qfq_dequeue (net/sched/sch_qfq.c:1089) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? lock_acquired (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:6164) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? sch_direct_xmit (net/sched/sch_generic.c:358) 
[  879.669430] ? __pfx_sch_direct_xmit (net/sched/sch_generic.c:319) 
[  879.669430] dequeue_skb (net/sched/sch_generic.c:294) 
[  879.669430] __qdisc_run (net/sched/sch_generic.c:399 net/sched/sch_generic.c:417) 
[  879.669430] ? __pfx___qdisc_run (net/sched/sch_generic.c:413) 
[  879.669430] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[  879.669430] ? __dev_xmit_skb (net/core/dev.c:4139) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_tracking.h:128 kernel/rcu/tree.c:745) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? dev_qdisc_enqueue (./include/trace/events/qdisc.h:49 net/core/dev.c:4070) 
[  879.669430] __dev_xmit_skb (net/core/dev.c:4172) 
[  879.669430] ? __pfx___dev_xmit_skb (net/core/dev.c:4077) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? __pfx_rcu_read_lock_bh_held (kernel/rcu/update.c:371) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] __dev_queue_xmit (net/core/dev.c:4679) 
[  879.669430] ? __pfx___dev_queue_xmit (net/core/dev.c:4621) 
[  879.669430] ? validate_chain (kernel/locking/lockdep.c:3922) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[  879.669430] ? neigh_resolve_output (net/core/neighbour.c:1507 net/core/neighbour.c:1492) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? lock_acquire.part.0 (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? local_clock_noinstr (kernel/sched/clock.c:282 kernel/sched/clock.c:306) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? mark_lock (kernel/locking/lockdep.c:4728) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1)) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? eth_header (net/ethernet/eth.c:100) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? neigh_resolve_output (./include/linux/seqlock.h:391 ./include/linux/seqlock.h:411 ./include/linux/seqlock.h:852 net/core/neighbour.c:1509 net/core/neighbour.c:1492) 
[  879.669430] ip_finish_output2 (./include/net/neighbour.h:539 net/ipv4/ip_output.c:235) 
[  879.669430] ip_send_skb (net/ipv4/ip_output.c:1502) 
[  879.669430] raw_sendmsg (net/ipv4/raw.c:657) 
[  879.669430] ? __pfx_raw_sendmsg (net/ipv4/raw.c:483) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? stack_trace_save (kernel/stacktrace.c:114) 
[  879.669430] ? kasan_save_stack (mm/kasan/common.c:48) 
[  879.669430] ? kasan_record_aux_stack (mm/kasan/generic.c:548) 
[  879.669430] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.669430] ? __ww_mutex_die.part.0 (kernel/locking/ww_mutex.h:277) 
[  879.669430] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? local_clock_noinstr (kernel/sched/clock.c:282 kernel/sched/clock.c:306) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? __lock_release.isra.0 (kernel/locking/lockdep.c:5547) 
[  879.669430] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? inet_send_prepare (net/ipv4/af_inet.c:836) 
[  879.669430] sock_sendmsg_nosec (net/socket.c:712) 
[  879.669430] __sys_sendto (net/socket.c:2157) 
[  879.669430] ? __pfx___sys_sendto (net/socket.c:2147) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? local_clock_noinstr (kernel/sched/clock.c:282 kernel/sched/clock.c:306) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? __lock_release.isra.0 (kernel/locking/lockdep.c:5547) 
[  879.669430] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? lock_release (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5894) 
[  879.669430] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.669430] ? __do_sys_gettimeofday (kernel/time/time.c:147 (discriminator 1)) 
[  879.669430] __x64_sys_sendto (net/socket.c:2183) 
[  879.669430] do_syscall_64 (arch/x86/entry/syscall_64.c:96) 
[  879.669430] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  879.669430] RIP: 0033:0x7ff0cdd89e27
[ 879.669430] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 45 85 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
All code
========
   0:	c7 c0 ff ff ff ff    	mov    $0xffffffff,%eax
   6:	eb be                	jmp    0xffffffffffffffc6
   8:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   f:	00 00 00 
  12:	90                   	nop
  13:	f3 0f 1e fa          	endbr64 
  17:	80 3d 45 85 0c 00 00 	cmpb   $0x0,0xc8545(%rip)        # 0xc8563
  1e:	41 89 ca             	mov    %ecx,%r10d
  21:	74 10                	je     0x33
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 69                	ja     0x9b
  32:	c3                   	ret    
  33:	55                   	push   %rbp
  34:	48 89 e5             	mov    %rsp,%rbp
  37:	53                   	push   %rbx
  38:	48 83 ec 38          	sub    $0x38,%rsp
  3c:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 69                	ja     0x71
   8:	c3                   	ret    
   9:	55                   	push   %rbp
   a:	48 89 e5             	mov    %rsp,%rbp
   d:	53                   	push   %rbx
   e:	48 83 ec 38          	sub    $0x38,%rsp
  12:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
[  879.669430] RSP: 002b:00007ffe4cac91a8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  879.669430] RAX: ffffffffffffffda RBX: 000055e418e480a0 RCX: 00007ff0cdd89e27
[  879.669430] RDX: 0000000000000040 RSI: 000055e41c31d320 RDI: 0000000000000003
[  879.669430] RBP: 00007ffe4cac91f0 R08: 000055e418e4a320 R09: 0000000000000010
[  879.669430] R10: 0000000000000000 R11: 0000000000000202 R12: 000055e41c31d320
[  879.669430] R13: 0000000000000040 R14: 00007ffe4caca8a8 R15: 00007ffe4caca8a8
[  879.669430]  </TASK>
[  879.669430] ==================================================================
[  879.723794] Disabling lock debugging due to kernel taint
[  879.724460] BUG: kernel NULL pointer dereference, address: 0000000000000048
[  879.725259] #PF: supervisor read access in kernel mode
[  879.725888] #PF: error_code(0x0000) - not-present page
[  879.726472] PGD 0 P4D 0
[  879.726818] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[  879.727409] CPU: 0 UID: 0 PID: 544 Comm: ping Tainted: G    B   W           6.16.0-rc5+ #542 PREEMPT(voluntary)
[  879.727698] Tainted: [B]=BAD_PAGE, [W]=WARN
[  879.727698] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  879.727698] RIP: 0010:qfq_dequeue (net/sched/sch_qfq.c:1138) 
[ 879.727698] Code: 03 00 00 48 8b 7c 24 08 e8 14 e5 ff ff 48 8b 7c 24 18 48 89 c3 e8 cc 31 5a ff 48 89 9d f8 02 00 00 48 8d 7b 48 e8 20 31 5a ff <48> 8b 7b 48 48 8d 84 24 a0 00 00 00 48 8d 54 24 50 48 8d 70 c0 e8
All code
========
   0:	03 00                	add    (%rax),%eax
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	7c 24                	jl     0x2b
   7:	08 e8                	or     %ch,%al
   9:	14 e5                	adc    $0xe5,%al
   b:	ff                   	(bad)  
   c:	ff 48 8b             	decl   -0x75(%rax)
   f:	7c 24                	jl     0x35
  11:	18 48 89             	sbb    %cl,-0x77(%rax)
  14:	c3                   	ret    
  15:	e8 cc 31 5a ff       	call   0xffffffffff5a31e6
  1a:	48 89 9d f8 02 00 00 	mov    %rbx,0x2f8(%rbp)
  21:	48 8d 7b 48          	lea    0x48(%rbx),%rdi
  25:	e8 20 31 5a ff       	call   0xffffffffff5a314a
  2a:*	48 8b 7b 48          	mov    0x48(%rbx),%rdi		<-- trapping instruction
  2e:	48 8d 84 24 a0 00 00 	lea    0xa0(%rsp),%rax
  35:	00 
  36:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
  3b:	48 8d 70 c0          	lea    -0x40(%rax),%rsi
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	48 8b 7b 48          	mov    0x48(%rbx),%rdi
   4:	48 8d 84 24 a0 00 00 	lea    0xa0(%rsp),%rax
   b:	00 
   c:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
  11:	48 8d 70 c0          	lea    -0x40(%rax),%rsi
  15:	e8                   	.byte 0xe8
[  879.727698] RSP: 0018:ffff888028bdf598 EFLAGS: 00010296
[  879.727698] RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffbfff0a76a05
[  879.727698] RDX: fffffbfff0a76a05 RSI: 0000000000000008 RDI: ffffffff853b5020
[  879.727698] RBP: ffff88800fe10000 R08: fffffbfff0a76a05 R09: 0000000000000001
[  879.727698] R10: ffffffff812e16d4 R11: fffffbfff0a76a04 R12: 000000007d70a3a8
[  879.727698] R13: 00000000000005dc R14: 0000000000000000 R15: 0000000000a3d70a
[  879.727698] FS:  00007ff0cdac0b80(0000) GS:ffff8880b0a78000(0000) knlGS:0000000000000000
[  879.727698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  879.727698] CR2: 0000000000000048 CR3: 0000000016582000 CR4: 0000000000350ef0
[  879.727698] Call Trace:
[  879.727698]  <TASK>
[  879.727698] ? __pfx_qfq_dequeue (net/sched/sch_qfq.c:1089) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? lock_acquired (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:6164) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? sch_direct_xmit (net/sched/sch_generic.c:358) 
[  879.727698] ? __pfx_sch_direct_xmit (net/sched/sch_generic.c:319) 
[  879.727698] dequeue_skb (net/sched/sch_generic.c:294) 
[  879.727698] __qdisc_run (net/sched/sch_generic.c:399 net/sched/sch_generic.c:417) 
[  879.727698] ? __pfx___qdisc_run (net/sched/sch_generic.c:413) 
[  879.727698] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[  879.727698] ? __dev_xmit_skb (net/core/dev.c:4139) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_tracking.h:128 kernel/rcu/tree.c:745) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? dev_qdisc_enqueue (./include/trace/events/qdisc.h:49 net/core/dev.c:4070) 
[  879.727698] __dev_xmit_skb (net/core/dev.c:4172) 
[  879.727698] ? __pfx___dev_xmit_skb (net/core/dev.c:4077) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? __pfx_rcu_read_lock_bh_held (kernel/rcu/update.c:371) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] __dev_queue_xmit (net/core/dev.c:4679) 
[  879.727698] ? __pfx___dev_queue_xmit (net/core/dev.c:4621) 
[  879.727698] ? validate_chain (kernel/locking/lockdep.c:3922) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[  879.727698] ? neigh_resolve_output (net/core/neighbour.c:1507 net/core/neighbour.c:1492) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? lock_acquire.part.0 (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? local_clock_noinstr (kernel/sched/clock.c:282 kernel/sched/clock.c:306) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? mark_lock (kernel/locking/lockdep.c:4728) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1)) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? eth_header (net/ethernet/eth.c:100) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? neigh_resolve_output (./include/linux/seqlock.h:391 ./include/linux/seqlock.h:411 ./include/linux/seqlock.h:852 net/core/neighbour.c:1509 net/core/neighbour.c:1492) 
[  879.727698] ip_finish_output2 (./include/net/neighbour.h:539 net/ipv4/ip_output.c:235) 
[  879.727698] ip_send_skb (net/ipv4/ip_output.c:1502) 
[  879.727698] raw_sendmsg (net/ipv4/raw.c:657) 
[  879.727698] ? __pfx_raw_sendmsg (net/ipv4/raw.c:483) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? stack_trace_save (kernel/stacktrace.c:114) 
[  879.727698] ? kasan_save_stack (mm/kasan/common.c:48) 
[  879.727698] ? kasan_record_aux_stack (mm/kasan/generic.c:548) 
[  879.727698] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.727698] ? __ww_mutex_die.part.0 (kernel/locking/ww_mutex.h:277) 
[  879.727698] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? local_clock_noinstr (kernel/sched/clock.c:282 kernel/sched/clock.c:306) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? __lock_release.isra.0 (kernel/locking/lockdep.c:5547) 
[  879.727698] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? inet_send_prepare (net/ipv4/af_inet.c:836) 
[  879.727698] sock_sendmsg_nosec (net/socket.c:712) 
[  879.727698] __sys_sendto (net/socket.c:2157) 
[  879.727698] ? __pfx___sys_sendto (net/socket.c:2147) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? local_clock_noinstr (kernel/sched/clock.c:282 kernel/sched/clock.c:306) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? __lock_release.isra.0 (kernel/locking/lockdep.c:5547) 
[  879.727698] ? __might_fault (mm/memory.c:6971 mm/memory.c:6965) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? lock_release (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5894) 
[  879.727698] ? srso_return_thunk (arch/x86/lib/retpoline.S:225) 
[  879.727698] ? __do_sys_gettimeofday (kernel/time/time.c:147 (discriminator 1)) 
[  879.727698] __x64_sys_sendto (net/socket.c:2183) 
[  879.727698] do_syscall_64 (arch/x86/entry/syscall_64.c:96) 
[  879.727698] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  879.727698] RIP: 0033:0x7ff0cdd89e27
[ 879.727698] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 45 85 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
All code
========
   0:	c7 c0 ff ff ff ff    	mov    $0xffffffff,%eax
   6:	eb be                	jmp    0xffffffffffffffc6
   8:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   f:	00 00 00 
  12:	90                   	nop
  13:	f3 0f 1e fa          	endbr64 
  17:	80 3d 45 85 0c 00 00 	cmpb   $0x0,0xc8545(%rip)        # 0xc8563
  1e:	41 89 ca             	mov    %ecx,%r10d
  21:	74 10                	je     0x33
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 69                	ja     0x9b
  32:	c3                   	ret    
  33:	55                   	push   %rbp
  34:	48 89 e5             	mov    %rsp,%rbp
  37:	53                   	push   %rbx
  38:	48 83 ec 38          	sub    $0x38,%rsp
  3c:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 69                	ja     0x71
   8:	c3                   	ret    
   9:	55                   	push   %rbp
   a:	48 89 e5             	mov    %rsp,%rbp
   d:	53                   	push   %rbx
   e:	48 83 ec 38          	sub    $0x38,%rsp
  12:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
[  879.727698] RSP: 002b:00007ffe4cac91a8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  879.727698] RAX: ffffffffffffffda RBX: 000055e418e480a0 RCX: 00007ff0cdd89e27
[  879.727698] RDX: 0000000000000040 RSI: 000055e41c31d320 RDI: 0000000000000003
[  879.727698] RBP: 00007ffe4cac91f0 R08: 000055e418e4a320 R09: 0000000000000010
[  879.727698] R10: 0000000000000000 R11: 0000000000000202 R12: 000055e41c31d320
[  879.727698] R13: 0000000000000040 R14: 00007ffe4caca8a8 R15: 00007ffe4caca8a8
[  879.727698]  </TASK>
[  879.727698] CR2: 0000000000000048
[  879.727698] ---[ end trace 0000000000000000 ]---
[  879.727698] RIP: 0010:qfq_dequeue (net/sched/sch_qfq.c:1138) 
[ 879.727698] Code: 03 00 00 48 8b 7c 24 08 e8 14 e5 ff ff 48 8b 7c 24 18 48 89 c3 e8 cc 31 5a ff 48 89 9d f8 02 00 00 48 8d 7b 48 e8 20 31 5a ff <48> 8b 7b 48 48 8d 84 24 a0 00 00 00 48 8d 54 24 50 48 8d 70 c0 e8
All code
========
   0:	03 00                	add    (%rax),%eax
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	7c 24                	jl     0x2b
   7:	08 e8                	or     %ch,%al
   9:	14 e5                	adc    $0xe5,%al
   b:	ff                   	(bad)  
   c:	ff 48 8b             	decl   -0x75(%rax)
   f:	7c 24                	jl     0x35
  11:	18 48 89             	sbb    %cl,-0x77(%rax)
  14:	c3                   	ret    
  15:	e8 cc 31 5a ff       	call   0xffffffffff5a31e6
  1a:	48 89 9d f8 02 00 00 	mov    %rbx,0x2f8(%rbp)
  21:	48 8d 7b 48          	lea    0x48(%rbx),%rdi
  25:	e8 20 31 5a ff       	call   0xffffffffff5a314a
  2a:*	48 8b 7b 48          	mov    0x48(%rbx),%rdi		<-- trapping instruction
  2e:	48 8d 84 24 a0 00 00 	lea    0xa0(%rsp),%rax
  35:	00 
  36:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
  3b:	48 8d 70 c0          	lea    -0x40(%rax),%rsi
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	48 8b 7b 48          	mov    0x48(%rbx),%rdi
   4:	48 8d 84 24 a0 00 00 	lea    0xa0(%rsp),%rax
   b:	00 
   c:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
  11:	48 8d 70 c0          	lea    -0x40(%rax),%rsi
  15:	e8                   	.byte 0xe8
[  879.727698] RSP: 0018:ffff888028bdf598 EFLAGS: 00010296
[  879.727698] RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffbfff0a76a05
[  879.727698] RDX: fffffbfff0a76a05 RSI: 0000000000000008 RDI: ffffffff853b5020
[  879.727698] RBP: ffff88800fe10000 R08: fffffbfff0a76a05 R09: 0000000000000001
[  879.727698] R10: ffffffff812e16d4 R11: fffffbfff0a76a04 R12: 000000007d70a3a8
[  879.727698] R13: 00000000000005dc R14: 0000000000000000 R15: 0000000000a3d70a
[  879.727698] FS:  00007ff0cdac0b80(0000) GS:ffff8880b0a78000(0000) knlGS:0000000000000000
[  879.727698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  879.727698] CR2: 0000000000000048 CR3: 0000000016582000 CR4: 0000000000350ef0
[  879.727698] Kernel panic - not syncing: Fatal exception in interrupt
[  879.727698] Kernel Offset: disabled
[  879.727698] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

