Return-Path: <netdev+bounces-234226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C6EC1DFAD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC541883349
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B33230BCB;
	Thu, 30 Oct 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul4NomV2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB035975
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786217; cv=none; b=XS/JZmJ8AsA60xGAeD4By0JL1jv7unlFhdCprR0th3VoswaW2WN6fN6sl7HniIx4l1eLs2XcLDASYnrN3RnB3f2MMGdXYgdDupvi5xry5exhjWPD6wb4g40lwtFCpLsaBb/qKG6wEglODwzzri8vJcMNwIxCMZK6AewyZ2wFCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786217; c=relaxed/simple;
	bh=lQ15o5SQIgxmeP6L6BmRALkuN+sHoAYKh1cDcozXqq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZR6nWpSYw4HKQmX8kUv6QXgSkIWd9CHNcvKDok8tM4OBm3Te92IZHyl9XG1NksbZPKo01ZUgUv2cbLStE4zdq9uc7ae4+sFLQqd9ErOEGhQ+SlT5v5BupgrF2jD7Hw2MlOl0LkftbgTo+Q822vm3mN3P4sNs1uD8guv76jJCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul4NomV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E47C4CEF7;
	Thu, 30 Oct 2025 01:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761786217;
	bh=lQ15o5SQIgxmeP6L6BmRALkuN+sHoAYKh1cDcozXqq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ul4NomV2TsNfYHqre7Qywiy8HAX2pJoCFUqWD7h14Uz/o6+vzXfLjM++uX8fhEDwG
	 T7QGbdCbZsimwDVev6q6rOfQX6XRWO4oRAWf3pOp34XvLhmpSmUE1h7oRw/gCs2yNK
	 CyUb+zbY8QK0LSIAnzNUHmSOmwUGwvg6NzQuNrVVA9vzkWE/eI9oegvxseM9BdUjYe
	 5IM63YYC8j6LGa2Cj+Jd1pqWU40L3gsediEKycaZkBQgYHCQ1hY/+mcK/lkBx5s5wm
	 UM6U9A862t0NSkSt5o0mptLl9vI8peVACF4ttIHUgFbs7ajTvzR58ThkZSFns6BgNV
	 25bevrQzJf4LQ==
Date: Wed, 29 Oct 2025 18:03:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzbot+87e1289a044fcd0c5f62@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net-next] net: sched: Don't use WARN_ON_ONCE() for
 -ENOMEM in tcf_classify().
Message-ID: <20251029180335.7326de77@kernel.org>
In-Reply-To: <20251028035859.2067690-1-kuniyu@google.com>
References: <20251028035859.2067690-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 03:58:23 +0000 Kuniyuki Iwashima wrote:
> [0]:
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250
>  should_fail_ex+0x414/0x560
>  should_failslab+0xa8/0x100
>  kmem_cache_alloc_noprof+0x74/0x6e0
>  skb_ext_add+0x148/0x8f0
>  tcf_classify+0xeba/0x1140
>  multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
> ...
> WARNING: CPU: 0 PID: 31392 at net/sched/cls_api.c:1869 tcf_classify+0xfd7/0x1140
> Modules linked in:
> CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:tcf_classify+0xfd7/0x1140
> Code: e8 03 42 0f b6 04 30 84 c0 0f 85 41 01 00 00 66 41 89 1f eb 05 e8 89 26 75 f8 bb ff ff ff ff e9 04 f9 ff ff e8 7a 26 75 f8 90 <0f> 0b 90 49 83 c5 44 4c 89 eb 49 c1 ed 03 43 0f b6 44 35 00 84 c0
> RSP: 0018:ffffc9000b7671f0 EFLAGS: 00010293
> RAX: ffffffff894addf6 RBX: 0000000000000002 RCX: ffff888025029e40
> RDX: 0000000000000000 RSI: ffffffff8bbf05c0 RDI: ffffffff8bbf0580
> RBP: 0000000000000000 R08: 00000000ffffffff R09: 1ffffffff1c0bfd6
> R10: dffffc0000000000 R11: fffffbfff1c0bfd7 R12: ffff88805a90de5c
> R13: ffff88805a90ddc0 R14: dffffc0000000000 R15: ffffc9000b7672c0
> FS:  00007f20739f66c0(0000) GS:ffff88812613e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c2d2a80 CR3: 0000000024e36000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  multiq_classify net/sched/sch_multiq.c:39 [inline]
>  multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
>  dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
>  __dev_xmit_skb net/core/dev.c:4214 [inline]
>  __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
>  packet_snd net/packet/af_packet.c:3076 [inline]
>  packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:742
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2630
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
>  __sys_sendmsg net/socket.c:2716 [inline]
>  __do_sys_sendmsg net/socket.c:2721 [inline]
>  __se_sys_sendmsg net/socket.c:2719 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f207578efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f20739f6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f20759e5fa0 RCX: 00007f207578efc9
> RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000008
> RBP: 00007f20739f6090 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007f20759e6038 R14: 00007f20759e5fa0 R15: 00007f2075b0fa28
>  </TASK>

nit for the future: I think you can be aggressive in trimming
down the stack traces. I'd have used this here:

  FAULT_INJECTION: forcing a failure.
  name failslab, interval 1, probability 0, space 0, times 0
  CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
  Call Trace:
   <TASK>
   dump_stack_lvl+0x189/0x250
   should_fail_ex+0x414/0x560
   should_failslab+0xa8/0x100
   kmem_cache_alloc_noprof+0x74/0x6e0
   skb_ext_add+0x148/0x8f0
   tcf_classify+0xeba/0x1140
   multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
  ...
  WARNING: CPU: 0 PID: 31392 at net/sched/cls_api.c:1869 tcf_classify+0xfd7/0x1140
  CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMPT(full)
  RIP: 0010:tcf_classify+0xfd7/0x1140
  Call Trace:
    <TASK>
    multiq_classify net/sched/sch_multiq.c:39 [inline]
    multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
    dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
    __dev_xmit_skb net/core/dev.c:4214 [inline]
    __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
    packet_snd net/packet/af_packet.c:3076 [inline]
    packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108

