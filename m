Return-Path: <netdev+bounces-64173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734A8318F0
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 13:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A7F1F24B78
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2924210;
	Thu, 18 Jan 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYxR9tgZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF83241F0
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580057; cv=none; b=the3QVgE0q2d3kBejtdP5BoIqvEPlveu7v+0m95inIFyMJjcirkm6jm2skXd1y2f/Et8d69ZN4JY0mgxfImTLEeyuu/7cYu3S0LcVg9LVr6Oeya3vu1cpJ+D4dauVhNsLIMlyFfC9oTAE8GZybWpNqDgliTlELg5SI92ekLmK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580057; c=relaxed/simple;
	bh=bkDtY6K6Ac2Ig3O9KOeOHxZVhC+cTLQ6M1Gb/h1pn2I=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=e2yvRbwdxe7AJj9BexfuhCtSj0dW4dadcyiZ6oYMiSOgSLNNPiqWjcfs4jl/HSczhsFQI2Nhb6SXC3H5XT7CVY09QrwV/LRCVNaEP5VWzSy6bJTpdkzan3YCegIoSiAt48qmyPyjPnUEHNcjgFbgqraxgZLsQ7sba6LTXkXfZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYxR9tgZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so4862a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 04:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705580054; x=1706184854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0YkYRkvguoD3Qyt5U+lfVL2TVHTQ0UkOYEo52fT4WI=;
        b=WYxR9tgZEkRWWlP4uqVQOD5pMOPSDhg1AisYdXK56zGFRSQ3IMdUPQovT6pR5huvZE
         SHE07oTLnuXRr/Xg+HapmDcRZzd1Z12KW/886p3ZC+JQe+LlUIwxEmDI5TzQqU0GnMT4
         Dc3Zu0Dvaqxgf9duIcDgVfiu+5rctCe/fmi3NnEUhj9OaOaofJX875GYsCQlA2QC8FRE
         /ELAC/rz02BzHMb0dQ4CEC+GiMUcZmMYgPqHsbJMKIE0RHuJh9h4FzHrM/zV4Is2uBga
         okRrjNEYKHGlcjZ7SPUT5AAO9IRBhr4jSy0vdtr5GYe+umxpx6kHr0aPqm30FY9UCIY1
         4W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705580054; x=1706184854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0YkYRkvguoD3Qyt5U+lfVL2TVHTQ0UkOYEo52fT4WI=;
        b=S1j2elnat8l/VuNpy/dMdnjSDG/223bgn/uk0zzmWWPbN8dMSyPs+z9yJ/BblD2HAm
         8JtrLk7kkBAIkk4XjqZFc5ELcNZU3KH9DctIyZgMLd6Ey3ozwMyVymPoMoHxkZ7xBXyn
         fPNX7OxHz0suYa5VryRBWlbtUAI96k27eTJxCxDJXTDxYz2b4zzfrse9emxG1GOeJFYu
         QmKwugM5FK+5inL5QxblxTFXrcUk9ZQT16t22G9IKB8InkWf8gTPyFEsnJrWArxFv2U3
         miUAKZ9dczAKMpns814MgMnryh8zfGPWJsA51b7j/vyKTmazPZ7g44rXzfkMB1T64E1D
         UIHQ==
X-Gm-Message-State: AOJu0Yx4o2rfph5tpVgkXEoLYaaZYESBDV1ef5quAmaaotxfKYASK4xU
	B0YqRGxUxSQ9zsDvdSyC8NnRdFGbZh2Tyg1hmmspLc8TyYdSdAl4Stc87/MWhkV426+X/mLkH/g
	PalLy3IebYkCJ01ApJ4UMwP4X8TB1S0Gjri3e
X-Google-Smtp-Source: AGHT+IG8BgszuE1QfQBfU2QpT6kuFAIaeLec4MYpFTHtcTsPZdCsAQ4niwquAVbhQOefcBHz7FsLVHAPBLESOmrSnLQ=
X-Received: by 2002:a05:6402:30bc:b0:559:6594:cf2e with SMTP id
 df28-20020a05640230bc00b005596594cf2emr48229edb.7.1705580053448; Thu, 18 Jan
 2024 04:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160030.140264-1-pablo@netfilter.org> <20240117160030.140264-15-pablo@netfilter.org>
 <CANn89i+jS11sC6cXXFA+_ZVr9Oy6Hn1e3_5P_d4kSR2fWtisBA@mail.gmail.com>
 <54f00e7c-8628-1705-8600-e9ad3a0dc677@netfilter.org> <CANn89iK_oa5CzeJVbiNSmPYZ6K+4_2m9nLqtSdwNAc9BtcZNew@mail.gmail.com>
 <8834c825579a054d51be3d60405c0b204fa5c24b.camel@redhat.com>
In-Reply-To: <8834c825579a054d51be3d60405c0b204fa5c24b.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 13:14:02 +0100
Message-ID: <CANn89iKN6Bkm96UUvchq99vr1J_SbHWY7D0DFD3RXU4o74J7qA@mail.gmail.com>
Subject: Re: [PATCH net 14/14] netfilter: ipset: fix performance regression in
 swap operation
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	netfilter-devel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	kuba@kernel.org, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:08=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Wed, 2024-01-17 at 17:28 +0100, Eric Dumazet wrote:
> > On Wed, Jan 17, 2024 at 5:23=E2=80=AFPM Jozsef Kadlecsik <kadlec@netfil=
ter.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, 17 Jan 2024, Eric Dumazet wrote:
> > >
> > > > On Wed, Jan 17, 2024 at 5:00=E2=80=AFPM Pablo Neira Ayuso <pablo@ne=
tfilter.org> wrote:
> > > > >
> > > > > From: Jozsef Kadlecsik <kadlec@netfilter.org>
> > > > >
> > > > > The patch "netfilter: ipset: fix race condition between swap/dest=
roy
> > > > > and kernel side add/del/test", commit 28628fa9 fixes a race condi=
tion.
> > > > > But the synchronize_rcu() added to the swap function unnecessaril=
y slows
> > > > > it down: it can safely be moved to destroy and use call_rcu() ins=
tead.
> > > > > Thus we can get back the same performance and preventing the race=
 condition
> > > > > at the same time.
> > > >
> > > > ...
> > > >
> > > > >
> > > > > @@ -2357,6 +2369,9 @@ ip_set_net_exit(struct net *net)
> > > > >
> > > > >         inst->is_deleted =3D true; /* flag for ip_set_nfnl_put */
> > > > >
> > > > > +       /* Wait for call_rcu() in destroy */
> > > > > +       rcu_barrier();
> > > > > +
> > > > >         nfnl_lock(NFNL_SUBSYS_IPSET);
> > > > >         for (i =3D 0; i < inst->ip_set_max; i++) {
> > > > >                 set =3D ip_set(inst, i);
> > > > > --
> > > > > 2.30.2
> > > > >
> > > >
> > > > If I am reading this right, time for netns dismantles will increase=
,
> > > > even for netns not using ipset
> > > >
> > > > If there is no other option, please convert "struct pernet_operatio=
ns
> > > > ip_set_net_ops".exit to an exit_batch() handler,
> > > > to at least have a factorized  rcu_barrier();
> > >
> > > You are right, the call to rcu_barrier() can safely be moved to
> > > ip_set_fini(). I'm going to prepare a new version of the patch.
> > >
> > > Thanks for catching it.
> >
> > I do not want to hold the series, your fix can be built as another
> > patch on top of this one.
>
> Given the timing, if we merge this series as is, it could go very soon
> into Linus' tree. I think it would be better to avoid introducing known
> regressions there.
>
> Any strong opinions vs holding this series until the problems are
> fixed? Likely a new PR will be required.
>

If this helps, here is one splat (using linux-next next-20240118)

BUG: sleeping function called from invalid context at kernel/workqueue.c:33=
48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 22194, name:
syz-executor.0
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor.0/22194:
#0: ffff8880162a2420 (sb_writers#5){.+.+}-{0:0}, at:
ksys_write+0x12f/0x260 fs/read_write.c:643
#1: ffff888042b48960 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at:
inode_lock include/linux/fs.h:802 [inline]
#1: ffff888042b48960 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at:
shmem_file_write_iter+0x8c/0x140 mm/shmem.c:2883
#2: ffffffff8d5aeb00 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire
include/linux/rcupdate.h:298 [inline]
#2: ffffffff8d5aeb00 (rcu_callback){....}-{0:0}, at: rcu_do_batch
kernel/rcu/tree.c:2152 [inline]
#2: ffffffff8d5aeb00 (rcu_callback){....}-{0:0}, at:
rcu_core+0x7cc/0x16b0 kernel/rcu/tree.c:2433
Preemption disabled at:
[<ffffffff813c061e>] unwind_next_frame+0xce/0x2390
arch/x86/kernel/unwind_orc.c:479
CPU: 0 PID: 22194 Comm: syz-executor.0 Not tainted
6.7.0-next-20240118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 11/17/2023
Call Trace:
<IRQ>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
__might_resched+0x3c0/0x5e0 kernel/sched/core.c:10176
start_flush_work kernel/workqueue.c:3348 [inline]
__flush_work+0x11f/0xa20 kernel/workqueue.c:3410
__cancel_work_timer+0x3f3/0x590 kernel/workqueue.c:3498
hash_ipmac6_destroy+0x337/0x420 net/netfilter/ipset/ip_set_hash_gen.h:454
ip_set_destroy_set+0x65/0x100 net/netfilter/ipset/ip_set_core.c:1180
rcu_do_batch kernel/rcu/tree.c:2158 [inline]
rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2433
__do_softirq+0x218/0x8de kernel/softirq.c:553
invoke_softirq kernel/softirq.c:427 [inline]
__irq_exit_rcu kernel/softirq.c:632 [inline]
irq_exit_rcu+0xb9/0x120 kernel/softirq.c:644
sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:6=
49
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:59 [inline]

