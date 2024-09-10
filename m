Return-Path: <netdev+bounces-127000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2504097395C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45E2287CB2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21711917E4;
	Tue, 10 Sep 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVIa5PXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA40142E70;
	Tue, 10 Sep 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977181; cv=none; b=GED8oHoqxoaY4Bg07FLgKrIyHf+1GrmzrwaNIi88/9SFAE3PQADLzwXB2oG5dl1Nr0mf44OjxvnNEeEqsYfF9cBrsheyvZ5iJRD3LKsQfbwiUQjPs1v4ZgdauDq3W7KfT60PEol+qz4Oe1egXOg8NPQl/GlO9n/eGhx/kpqthmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977181; c=relaxed/simple;
	bh=jbrecd11WFqI7AyYdsjiiXuSghG3NjLS/shHI634aQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaOd4b20QWhWkGZaRf8acEw101JXz06paCRu0d0vW8V+Cw2KUC++Ymbv//e5Opbe93UOBzN9uB0NZetrcVOVZjvO8GpemCmv6sFhg3zMuw5zTIlI9wdPKSjaMulBwzsLQyrvffxPwh1kwIXTr8a94/UK6Rpxcin4CjuqTxv/VRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVIa5PXS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso3540434b3a.3;
        Tue, 10 Sep 2024 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725977179; x=1726581979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyfwxGKZw+6ZzN2i4N1qZpr30iZL3SMqqAZXEPo3IXo=;
        b=SVIa5PXSQaqnEwBKoWNAOaiOVYbUoapK/bG8Gp54SUpiI4gZbAyer8VvmyLammzEMQ
         s/y2YBV+/zeOVrC8G7Qt5/f5lxgfAYrY1dNj9ScFZv3X2e6vwbw2Hv6cDJpy/8VRnUfw
         bGVek8bhgGSQnWO0ncwD4Lh9CTcgLWpe9Zlw+SbECjrEaoTySp49SA6wxr5sbEWqFnR2
         XPnCC5qxNzK64kynkRZ3CS+PoZ0/yCyfwbwVXPL7GaCo8WRcuq/QSVou5eA+shicR0fr
         8QbChlhjmt1dYUfhCIBJOfyTms5G9/TDveEF3azECJtjWjaK52Ov5eKSR/mH6ppMgWXY
         RUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977179; x=1726581979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyfwxGKZw+6ZzN2i4N1qZpr30iZL3SMqqAZXEPo3IXo=;
        b=fOSyUiZ7M2jjh4cVQWpa4e0XN3E6omM4q+JIzO1PjIYeFZz365pYBKkqn4cdo3Xd7w
         NxZ6HKZ3FKRs/rLP1cMf5/3NzURxZ+/+5Q+KWUEfDEi5HNeprm2OIGAiFx1FqWrXAE/5
         wfFSHo1o59BR2G8kBT2ihPJhcNPuqELikcRyPu9rTDCTowbnNljMVp6kO3x0yc6j3nyD
         RF7GfyZGpZ+jvErthi7tGMhTa6+z3Z/9Tsg5sJjLSF6xAFGOiQLWSfFi8BBj4EL+3M4n
         GMjAfmAFiP3So0bbHpxm8crKehNj+yArIPHBiT/fRPmNf+h/E++kMvRZbS+Svmen4wy8
         d2jA==
X-Forwarded-Encrypted: i=1; AJvYcCU3XTqsJOGsxXxG4QjwwD1uaRgs/CmPL8xhf/PBQ237MP8yZrVs4xfNjN4mJQjmzczKdrBeawI56+JQHHI=@vger.kernel.org, AJvYcCX1w82490aRljPvy89YbT8KeYZxH9PRGe+FQJ8xYJbyVTD4wsk+iKMYuGi6arSCkRcVQEtMNzGt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp++kiPy670JL10Z+M358Mh6+7C0Xi8spEtjqUr5wN0sBavNi7
	b0+0L3Tyca0z83c52RV7s5yl4E5KxgB21ZLKQARQmRdw2aWMAqOIIOA7DUoKcp5wy0XY0l5sWdO
	zNMbD1MdVkfXO4hJgB6LdOzsMekfomslS
X-Google-Smtp-Source: AGHT+IE1wIwxYx92FIUj98f3nugjGtni5M6TSINwCB0JguCgBPRca8AInYMijesalfeSng0mAs1RYQ7DRqQR3NLviPw=
X-Received: by 2002:aa7:8887:0:b0:718:d96d:34d7 with SMTP id
 d2e1a72fcca58-718e3f9caacmr15109730b3a.3.1725977178738; Tue, 10 Sep 2024
 07:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iLmOgH6RdRc_XGhawM03UEOkUK3QB0wK_Ci_YBVNwhUHQ@mail.gmail.com>
 <03C87C05-301E-4C34-82FF-6517316A11C2@gmail.com> <CANn89iLYUjfsaXrtV19_DF9nUSaLSwmWnd7tzh8+v9OoUesBHg@mail.gmail.com>
In-Reply-To: <CANn89iLYUjfsaXrtV19_DF9nUSaLSwmWnd7tzh8+v9OoUesBHg@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 10 Sep 2024 23:06:04 +0900
Message-ID: <CAO9qdTEOSa=GAQQ-tcWa6hUJVNKBKDOqLOVOZffKw9K5SJeOBA@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent NULL pointer dereference in
 rt_fibinfo_free() and rt_fibinfo_free_cpus()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Sep 10, 2024 at 5:23=E2=80=AFAM Jeongjun Park <aha310510@gmail.co=
m> wrote:
> >
> >
> > > Eric Dumazet <edumazet@google.com> wrote:
> > > =EF=BB=BFOn Mon, Sep 9, 2024 at 8:48=E2=80=AFPM Jeongjun Park <aha310=
510@gmail.com> wrote:
> > >>
> > >> rt_fibinfo_free() and rt_fibinfo_free_cpus() only check for rt and d=
o not
> > >> verify rt->dst and use it, which will result in NULL pointer derefer=
ence.
> > >>
> > >> Therefore, to prevent this, we need to add a check for rt->dst.
> > >>
> > >> Fixes: 0830106c5390 ("ipv4: take dst->__refcnt when caching dst in f=
ib")
> > >> Fixes: c5038a8327b9 ("ipv4: Cache routes in nexthop exception entrie=
s.")
> > >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > >> ---
> > >
> > > As far as I can tell, your patch is a NOP, and these Fixes: tags seem
> > > random to me.
> >
> > I somewhat agree with the opinion that the fixes tag is random.
> > However, I think it is absolutely necessary to add a check for
> > &rt->dst , because the existence of rt does not guarantee that
> > &rt->dst will not be NULL.
> >
> > >
> > > Also, I am guessing this is based on a syzbot report ?
> >
> > Yes, but it's not a bug reported to syzbot, it's a bug that
> > I accidentally found in my syzkaller fuzzer. The report is too long
> > to be included in the patch notes, so I'll attach it to this email.
>
> syzbot has a similar report in its queue, I put it on hold because
> this is some unrelated memory corruption.
>
> rt (R14 in your case) is 0x1 at this point, which is not a valid memory p=
ointer.
>
> So I am definitely saying no to your patch.
>

I see. Thanks to the explanation, I understood that this patch is wrong.

However, while continuing to analyze this bug, I found out something.
According to the rcu_dereference_protected() doc, when using
rcu_dereference_protected(), it is specified that ptr should be protected
using a lock, but free_fib_info_rcu() does not have any protection for
the fib_info structure.

I think this may cause a data-race, which modifies the values of rt and
&rt->dst, causing the bug. Even if this is not the root cause, I don't
think there is a reason why free_fib_info_rcu() should not be protected
with fib_info_lock.

What do you think about protecting the fib_info structure like the patch
below?

Regards,
Jeongjun Park

---
 net/ipv4/fib_semantics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 2b57cd2b96e2..77431879ee39 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -234,6 +234,7 @@ static void free_fib_info_rcu(struct rcu_head *head)
 {
    struct fib_info *fi =3D container_of(head, struct fib_info, rcu);

+   spin_lock(&fib_info_lock);
    if (fi->nh) {
        nexthop_put(fi->nh);
    } else {
@@ -245,6 +246,7 @@ static void free_fib_info_rcu(struct rcu_head *head)
    ip_fib_metrics_put(fi->fib_metrics);

    kfree(fi);
+   spin_unlock(&fib_info_lock);
 }

 void free_fib_info(struct fib_info *fi)
--

> >
> > Report:
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 0 UID: 0 PID: 4694 Comm: systemd-udevd Not tainted 6.11.0-rc6-0032=
6-gd1f2d51b711a #16
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:dst_dev_put+0x26/0x330 net/core/dst.c:149
> > Code: 90 90 90 90 f3 0f 1e fa 41 57 41 56 49 89 fe 41 55 41 54 55 e8 0b=
 90 af f8 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f=
 85 da 02 00 00 49 8d 7e 3a 4d 8b 26 48 b8 00 00 00
> > RSP: 0018:ffffc90000007d68 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8976519a
> > RDX: 0000000000000000 RSI: ffffffff88d97a95 RDI: 0000000000000001
> > RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed100c8020c3
> > R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff1ab5a81
> > R13: 0000607f8106c5c8 R14: 0000000000000001 R15: 0000000000000000
> > FS:  00007f235c5fd8c0(0000) GS:ffff88802c400000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f39c90e5168 CR3: 0000000019688000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > Call Trace:
> >  <IRQ>
> >  rt_fibinfo_free_cpus.part.0+0xf4/0x1d0 net/ipv4/fib_semantics.c:206
> >  rt_fibinfo_free_cpus net/ipv4/fib_semantics.c:198 [inline]
> >  fib_nh_common_release+0x121/0x360 net/ipv4/fib_semantics.c:217
> >  fib_nh_release net/ipv4/fib_semantics.c:229 [inline]
> >  free_fib_info_rcu+0x18f/0x4b0 net/ipv4/fib_semantics.c:241
> >  rcu_do_batch kernel/rcu/tree.c:2569 [inline]
> >  rcu_core+0x826/0x16d0 kernel/rcu/tree.c:2843
> >  handle_softirqs+0x1d4/0x870 kernel/softirq.c:554
> >  __do_softirq kernel/softirq.c:588 [inline]
> >  invoke_softirq kernel/softirq.c:428 [inline]
> >  __irq_exit_rcu kernel/softirq.c:637 [inline]
> >  irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [in=
line]
> >  sysvec_apic_timer_interrupt+0x99/0xb0 arch/x86/kernel/apic/apic.c:1043
> >  </IRQ>
> >  <TASK>
> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentr=
y.h:702
> > RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h=
:152 [inline]
> > RIP: 0010:_raw_spin_unlock_irqrestore+0x3c/0x70 kernel/locking/spinlock=
.c:194
> > Code: 74 24 10 e8 d6 03 6f f6 48 89 ef e8 8e 77 6f f6 81 e3 00 02 00 00=
 75 29 9c 58 f6 c4 02 75 35 48 85 db 74 01 fb bf 01 00 00 00 e8 bf 24 61 f6=
 65 8b 05 c0 79 0b 75 85 c0 74 0e 5b 5d c3 cc cc cc
> > RSP: 0018:ffffc90001f978f8 EFLAGS: 00000206
> > RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1fe4be9
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> > RBP: ffffffff8dbc0ac0 R08: 0000000000000001 R09: 0000000000000001
> > R10: ffffffff8ff2a39f R11: ffffffff815d29ca R12: 0000000000000246
> > R13: ffff88801e866100 R14: 0000000000000200 R15: 0000000000000000
> >  rcu_read_unlock_special kernel/rcu/tree_plugin.h:691 [inline]
> >  __rcu_read_unlock+0x2d9/0x580 kernel/rcu/tree_plugin.h:436
> >  __netlink_sendskb net/netlink/af_netlink.c:1278 [inline]
> >  netlink_broadcast_deliver net/netlink/af_netlink.c:1408 [inline]
> >  do_one_broadcast net/netlink/af_netlink.c:1495 [inline]
> >  netlink_broadcast_filtered+0x8ec/0xe00 net/netlink/af_netlink.c:1540
> >  netlink_broadcast net/netlink/af_netlink.c:1564 [inline]
> >  netlink_sendmsg+0x9ee/0xd80 net/netlink/af_netlink.c:1899
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg net/socket.c:745 [inline]
> >  ____sys_sendmsg+0xabe/0xc80 net/socket.c:2597
> >  ___sys_sendmsg+0x11d/0x1c0 net/socket.c:2651
> >  __sys_sendmsg+0xfe/0x1d0 net/socket.c:2680
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f235c8b0e13
> > Code: 8b 15 b9 a1 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f=
 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 48 3d 00 f0 ff=
 ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
> > RSP: 002b:00007ffe93910d38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 0000556a6858ba60 RCX: 00007f235c8b0e13
> > RDX: 0000000000000000 RSI: 00007ffe93910d60 RDI: 000000000000000e
> > RBP: 0000556a6858bdc0 R08: 00000000ffffffff R09: 0000556a685488e0
> > R10: 0000556a6858be38 R11: 0000000000000246 R12: 0000000000008010
> > R13: 0000556a6856fc30 R14: 0000000000000000 R15: 00007ffe93910df0
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:dst_dev_put+0x26/0x330 net/core/dst.c:149
> > Code: 90 90 90 90 f3 0f 1e fa 41 57 41 56 49 89 fe 41 55 41 54 55 e8 0b=
 90 af f8 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f=
 85 da 02 00 00 49 8d 7e 3a 4d 8b 26 48 b8 00 00 00
> > RSP: 0018:ffffc90000007d68 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8976519a
> > RDX: 0000000000000000 RSI: ffffffff88d97a95 RDI: 0000000000000001
> > RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed100c8020c3
> > R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff1ab5a81
> > R13: 0000607f8106c5c8 R14: 0000000000000001 R15: 0000000000000000
> > FS:  00007f235c5fd8c0(0000) GS:ffff88802c400000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f39c90e5168 CR3: 0000000019688000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > ----------------
> > Code disassembly (best guess):
> >    0:   90                      nop
> >    1:   90                      nop
> >    2:   90                      nop
> >    3:   90                      nop
> >    4:   f3 0f 1e fa             endbr64
> >    8:   41 57                   push   %r15
> >    a:   41 56                   push   %r14
> >    c:   49 89 fe                mov    %rdi,%r14
> >    f:   41 55                   push   %r13
> >   11:   41 54                   push   %r12
> >   13:   55                      push   %rbp
> >   14:   e8 0b 90 af f8          call   0xf8af9024
> >   19:   4c 89 f2                mov    %r14,%rdx
> >   1c:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> >   23:   fc ff df
> >   26:   48 c1 ea 03             shr    $0x3,%rdx
> > * 2a:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping =
instruction
> >   2e:   0f 85 da 02 00 00       jne    0x30e
> >   34:   49 8d 7e 3a             lea    0x3a(%r14),%rdi
> >   38:   4d 8b 26                mov    (%r14),%r12
> >   3b:   48                      rex.W
> >   3c:   b8                      .byte 0xb8
> >   3d:   00 00                   add    %al,(%rax)

