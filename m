Return-Path: <netdev+bounces-162634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B152EA2770A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39C43A40EB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD64215193;
	Tue,  4 Feb 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRILoke+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45658188583
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686077; cv=none; b=B3hCzkcZCNg39nVhU29av3uo09Whgp5vWIL02Pt9bIwK6a/22PNIWeRUtsdvhseQ/lXtS+9q0fulYEgUILI9Q9B0gLdJ8QgdD1K1l9Ok69TvidAPuEoKm+8LeLIsZBOQfsd14h4Vmigi+MrNIraKKjD/2wMEctPGb1xcL3rsp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686077; c=relaxed/simple;
	bh=s/dEPbQUVA9KWSnht2DZl3DhkEjC3y6f5a8K34JXAtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6T5CYH7dD7YeV3/xtXrMbeJPKE/RPKfGKiPO2UwGYH5nNjilG31Odc6lb4Swr3bcv5j/VFXkByb8fdmUdhhZDmxis5Uiw4TzhtOmIFUn9icd9UyvlrciTU6Qzu5BTx5JoZe5oZN3mDxyiN3xY6M9DaLIPNshqrrJzdW0xKQGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRILoke+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD64BC4CEDF;
	Tue,  4 Feb 2025 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738686076;
	bh=s/dEPbQUVA9KWSnht2DZl3DhkEjC3y6f5a8K34JXAtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BRILoke+oglRoJqIvEzxJMBoZswC4m6RQWIarOPfggazO2CUwB89oMLOjiKNHSImA
	 K8WImHUSsFDiwhqY+ZFb8FHUPsZ9XMFfB+AQQBcnhS8mYPsefMForuRCzwfph6kqSa
	 7x8tqmWbigEVV7attwafeijUkMGm4KoTxTBDGG0UAMS6aJ2Eo0ppcQxAICrYuwK03U
	 yxu7BcW5x08Q8n/PEyj7cZBli3KVhVwbqeKA+uVOmqttzHcX5z9ivwhqWZn/XC7BNt
	 zrkWjbk7YuOZ6Do7DkqmqqZclYMNd0GMmaKdwnOxM6fhNY8wvV5QBZhW32QxWpenKL
	 s8wBhNjR24/vA==
Message-ID: <7bdc93b7-3f1a-47ab-bf1f-8ad684e4f569@kernel.org>
Date: Tue, 4 Feb 2025 17:21:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 net 09/16] ipv4: icmp: convert to dev_net_rcu()
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250203143046.3029343-1-edumazet@google.com>
 <20250203143046.3029343-10-edumazet@google.com>
 <20250203153633.46ce0337@kernel.org>
 <CANn89i+-Jifwyjhif1jPXcoXU7n2n4Hyk13k7XoTRCeeAJV1uA@mail.gmail.com>
 <CANn89iKfq8LhriwPzzkCACfrPtVz=XXdnsqQFz6ZOFgqJX7ZJA@mail.gmail.com>
 <CANn89iJKeRYZh42MKvqLgLFwCSoti0dbSkreaOMSgmfWXzm-GA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iJKeRYZh42MKvqLgLFwCSoti0dbSkreaOMSgmfWXzm-GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 04/02/2025 11:35, Eric Dumazet wrote:
> On Tue, Feb 4, 2025 at 5:57 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Feb 4, 2025 at 5:14 AM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Tue, Feb 4, 2025 at 12:36 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Mon,  3 Feb 2025 14:30:39 +0000 Eric Dumazet wrote:
>>>>> @@ -611,9 +611,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>>>>>               goto out;
>>>>>
>>>>>       if (rt->dst.dev)
>>>>> -             net = dev_net(rt->dst.dev);
>>>>> +             net = dev_net_rcu(rt->dst.dev);
>>>>>       else if (skb_in->dev)
>>>>> -             net = dev_net(skb_in->dev);
>>>>> +             net = dev_net_rcu(skb_in->dev);
>>>>>       else
>>>>>               goto out;
>>>>
>>>> Hm. Weird. NIPA says this one is not under RCU.
>>>>
>>>> [  275.730657][    C1] ./include/net/net_namespace.h:404 suspicious rcu_dereference_check() usage!
>>>> [  275.731033][    C1]
>>>> [  275.731033][    C1] other info that might help us debug this:
>>>> [  275.731033][    C1]
>>>> [  275.731471][    C1]
>>>> [  275.731471][    C1] rcu_scheduler_active = 2, debug_locks = 1
>>>> [  275.731799][    C1] 1 lock held by swapper/1/0:
>>>> [  275.732000][    C1]  #0: ffffc900001e0ae8 ((&n->timer)){+.-.}-{0:0}, at: call_timer_fn+0xe8/0x230
>>>> [  275.732354][    C1]
>>>> [  275.732354][    C1] stack backtrace:
>>>> [  275.732638][    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.13.0-virtme #1
>>>> [  275.732643][    C1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>>>> [  275.732646][    C1] Call Trace:
>>>> [  275.732647][    C1]  <IRQ>
>>>> [  275.732651][    C1]  dump_stack_lvl+0xb0/0xd0
>>>> [  275.732663][    C1]  lockdep_rcu_suspicious+0x1ea/0x280
>>>> [  275.732678][    C1]  __icmp_send+0xb0d/0x1580
>>>> [  275.732695][    C1]  ? tcp_data_queue+0x8/0x22d0
>>>> [  275.732701][    C1]  ? lockdep_hardirqs_on_prepare+0x12b/0x410
>>>> [  275.732712][    C1]  ? __pfx___icmp_send+0x10/0x10
>>>> [  275.732719][    C1]  ? tcp_check_space+0x3ce/0x5f0
>>>> [  275.732742][    C1]  ? rcu_read_lock_any_held+0x43/0xb0
>>>> [  275.732750][    C1]  ? validate_chain+0x1fe/0xae0
>>>> [  275.732771][    C1]  ? __pfx_validate_chain+0x10/0x10
>>>> [  275.732778][    C1]  ? hlock_class+0x4e/0x130
>>>> [  275.732784][    C1]  ? mark_lock+0x38/0x3e0
>>>> [  275.732788][    C1]  ? sock_put+0x1a/0x60
>>>> [  275.732806][    C1]  ? __lock_acquire+0xb9a/0x1680
>>>> [  275.732822][    C1]  ipv4_send_dest_unreach+0x3b4/0x800
>>>> [  275.732829][    C1]  ? neigh_invalidate+0x1c7/0x540
>>>> [  275.732837][    C1]  ? __pfx_ipv4_send_dest_unreach+0x10/0x10
>>>> [  275.732850][    C1]  ipv4_link_failure+0x1b/0x190
>>>> [  275.732856][    C1]  arp_error_report+0x96/0x170
>>>> [  275.732862][    C1]  neigh_invalidate+0x209/0x540
>>>> [  275.732873][    C1]  neigh_timer_handler+0x87a/0xdf0
>>>> [  275.732883][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
>>>> [  275.732886][    C1]  call_timer_fn+0x13b/0x230
>>>> [  275.732891][    C1]  ? call_timer_fn+0xe8/0x230
>>>> [  275.732894][    C1]  ? call_timer_fn+0xe8/0x230
>>>> [  275.732899][    C1]  ? __pfx_call_timer_fn+0x10/0x10
>>>> [  275.732902][    C1]  ? mark_lock+0x38/0x3e0
>>>> [  275.732920][    C1]  __run_timers+0x545/0x810
>>>> [  275.732925][    C1]  ? __pfx_neigh_timer_handler+0x10/0x10
>>>> [  275.732936][    C1]  ? __pfx___run_timers+0x10/0x10
>>>> [  275.732939][    C1]  ? __lock_release+0x103/0x460
>>>> [  275.732947][    C1]  ? do_raw_spin_lock+0x131/0x270
>>>> [  275.732952][    C1]  ? __pfx_do_raw_spin_lock+0x10/0x10
>>>> [  275.732956][    C1]  ? lock_acquire+0x32/0xc0
>>>> [  275.732958][    C1]  ? timer_expire_remote+0x96/0xf0
>>>> [  275.732967][    C1]  timer_expire_remote+0x9e/0xf0
>>>> [  275.732970][    C1]  tmigr_handle_remote_cpu+0x278/0x440
>>>> [  275.732977][    C1]  ? __pfx_tmigr_handle_remote_cpu+0x10/0x10
>>>> [  275.732981][    C1]  ? __pfx___lock_release+0x10/0x10
>>>> [  275.732985][    C1]  ? __pfx_lock_acquire.part.0+0x10/0x10
>>>> [  275.733015][    C1]  tmigr_handle_remote_up+0x1a6/0x270
>>>> [  275.733027][    C1]  ? __pfx_tmigr_handle_remote_up+0x10/0x10
>>>> [  275.733036][    C1]  __walk_groups.isra.0+0x44/0x160
>>>> [  275.733051][    C1]  tmigr_handle_remote+0x20b/0x300
>>>>
>>>> Decoded:
>>>> https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/976941/vm-crash-thr0-1
>>>
>>> Oops, I thought I ran the tests on the whole series. I missed this one.
>>
>> BTW, ICMPv6 has the same potential problem, I will amend both cases.
> 
> I ran again the tests for v3, got an unrelated crash, FYI.
> 
> 14237.095216] #PF: supervisor instruction fetch in kernel mode
> [14237.095570] #PF: error_code(0x0010) - not-present page
> [14237.095915] PGD 1e58067 P4D 1e58067 PUD ce1c067 PMD 0
> [14237.096991] Oops: Oops: 0010 [#1] SMP DEBUG_PAGEALLOC NOPTI
> [14237.097507] CPU: 0 UID: 0 PID: 6371 Comm: python3 Not tainted
> 6.13.0-virtme #1559
> [14237.098045] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [14237.098578] RIP: 0010:0x0
> [14237.099324] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [14237.099752] RSP: 0018:ffffacfd4486bed0 EFLAGS: 00000286
> [14237.100079] RAX: 0000000000000000 RBX: ffff9af502607200 RCX: 0000000000000002
> [14237.100452] RDX: 00007fffc684a690 RSI: 0000000000005401 RDI: ffff9af502607200
> [14237.100821] RBP: 0000000000005401 R08: 0000000000000001 R09: 0000000000000000
> [14237.101182] R10: 0000000000000001 R11: 0000000000000000 R12: 00007fffc684a690
> [14237.101542] R13: ffff9af50888ed68 R14: ffff9af502607200 R15: 0000000000000000
> [14237.101956] FS:  00007f76b73f95c0(0000) GS:ffff9af57cc00000(0000)
> knlGS:0000000000000000
> [14237.102372] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14237.102679] CR2: ffffffffffffffd6 CR3: 00000000039ca000 CR4: 00000000000006f0
> [14237.103160] Call Trace:
> [14237.103435]  <TASK>
> [14237.103720]  ? __die_body.cold+0x19/0x26
> [14237.104340]  ? page_fault_oops+0x134/0x2a0
> [14237.104553]  ? cp_new_stat+0x157/0x190
> [14237.104799]  ? exc_page_fault+0x68/0x230
> [14237.105013]  ? asm_exc_page_fault+0x26/0x30
> [14237.105259]  full_proxy_unlocked_ioctl+0x63/0x90
> [14237.105546]  __x64_sys_ioctl+0x97/0xc0
> [14237.105754]  do_syscall_64+0x72/0x180
> [14237.105949]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

I think I got this issue as well on MPTCP side, when using GCOV, but
something else using the debugfs could trigger that as well I guess. It
is apparently fixed in the Linus tree, see 57b314752ec0 ("debugfs: Fix
the missing initializations in __debugfs_file_get()")

https://lore.kernel.org/all/20250129191937.GR1977892@ZenIV/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


