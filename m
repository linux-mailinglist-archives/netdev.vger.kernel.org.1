Return-Path: <netdev+bounces-92594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E46558B7FF8
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B4EB241DD
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF5181323;
	Tue, 30 Apr 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QF7dW2DE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7C1836ED
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502619; cv=none; b=MLIfBA9hN8wi7EsKxtgUEOUw+OZkiL3IxIliAqgr24smsT6PUR5NOFZRBHXvIldH2sJgMbNHniS+VuhOgAhUsyVz1O17J0ldNC5AuARYR2GbwoX4jODr8vKVzPmjAPIskmZvuDF6Bi1TI81TOcmikSGjp6sBsOFBygFb5FQi5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502619; c=relaxed/simple;
	bh=BjVIpr6D6U+ovO1hSAr1d66XKDxRf1xtjfoJTfDOelg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdr7uruPuyqaOnM9SLnvZ3DWRAMSZIbcUueb5vymN4F2em4zSDNsvGW3KpNL6X9lfN8yShxH0iL2RUtSstGR7gXEEAwysOHC7pMqKAbNkUfqxx6AnRyJ+ULpJ4HRh5VqkTh30odlwvoN/5OcYKH6DczWuBoI9dGBFAoR8S1MPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QF7dW2DE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso2177a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714502616; x=1715107416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGtmvtOeHlyT269/j4Nxx3NTS8DnpOxlrTqOxni+Mpo=;
        b=QF7dW2DE45VVFsFcrkGKpvVKB/8I5UWvziSDK7pRumJWi7CuHJHAl/g2GsajAJ5qE5
         mdfnsmoaxQb+sb2RCKHMqImPrN7yEQtDt+di0PnI+Ns3f7d6phXnvv2ZrgXFjBaLtTaM
         cInGLe72u3ISzl4vMHrUvKU1IGann8Du8Uik7d25uQpmsLyA9ntgK/P5Y4BAiEBpXYIa
         9ukzbZgewV/99fLf20o/6KVc17+9EGK164NtCZHyf4/OHUFyl+Rf+N3dhpMGmgI2clJi
         B5uFae0ZdKxzwz85PU1p1GdB+eCLGHpGK7OCX5JO2SYmNRaIGT4LbNHQwM+VGvZgow2J
         o9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502616; x=1715107416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGtmvtOeHlyT269/j4Nxx3NTS8DnpOxlrTqOxni+Mpo=;
        b=f1ymzOywWe7L9MGd9CXltlDU1vF3iT/NqZT/hjsPG4Gk6iXfyyr2aNMXj2iLVF7WPG
         2fT3/2LR1M2ejTKiJjUaA+HTXL59sBO6oqMdF/BKxPrlOIYiHO2coXNpWLLyIG7Wfnz0
         CidA1lrI9kdOZuY4uv+1SsW5xqNILehIi6d2EyvF24uC0Ant7/ZG3OLy4gmLnQm4nx3H
         /UIG9DcL7UrT8T0EvE75O/rcEwrzt/hYSLKKiOXXnUttGTeeGqpUFwB0DkwniNceJ6Ym
         mdBgO+vrB2z9kev98ZdTir5CTXuKw42oW7pt/qZXnooqqKLhjTx+AkDX/22Dm6EdTBiS
         KC7A==
X-Forwarded-Encrypted: i=1; AJvYcCX9dXsEjB7Hlpj5oUtLyCxK/edCpDFlBXLSLpHJef0sHU0zjdKm7xE8pbPr7WDBkfsIyT0c7lCjkgIxg99HEm11mSL3hMiX
X-Gm-Message-State: AOJu0YyyAINkfR8qWbpSDBGbwc4lTwvJfCwl2LpCjuXw6Uwx5PxFprx8
	KT2ls9oEmPXIASYFQMcU/cJT/UNqqSlV5Grcf1pRWexMQx5Y2tC7TeRtK88QZ18GciO67vzSPsS
	8cAugLNwyf21lGgSd0tTY9dn4LDvZeoRHihCG
X-Google-Smtp-Source: AGHT+IFqPIi0I0U5uwXKA03lZTtFwh4EsQYs456jiVSWk9AzeCPyVuefsQznoRiZp8LqcSqjngx9Art7ZwUuf5F+fdw=
X-Received: by 2002:a05:6402:6c7:b0:572:57d8:4516 with SMTP id
 n7-20020a05640206c700b0057257d84516mr25985edy.2.1714502615891; Tue, 30 Apr
 2024 11:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
 <CANn89iJJefUheeur5E=bziiqxjqmKXEk3NCO=8em4XVJThExMQ@mail.gmail.com> <ZjE587MsVBZA61fJ@dcaratti.users.ipa.redhat.com>
In-Reply-To: <ZjE587MsVBZA61fJ@dcaratti.users.ipa.redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 20:43:22 +0200
Message-ID: <CANn89iJRA-1z60cvGnbqYa=Ua-ysR9uHufkrFmQGRmN-4Dod2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 8:35=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> hi Eric, thanks for looking at this!
>
> On Tue, Apr 30, 2024 at 07:58:14PM +0200, Eric Dumazet wrote:
> > On Tue, Apr 30, 2024 at 7:11=E2=80=AFPM Davide Caratti <dcaratti@redhat=
.com> wrote:
> > >
>
> [...]
>
> > > @@ -1389,6 +1389,7 @@ static struct Qdisc *qdisc_create(struct net_de=
vice *dev,
> > >                 ops->destroy(sch);
> > >         qdisc_put_stab(rtnl_dereference(sch->stab));
> > >  err_out3:
> > > +       lockdep_unregister_key(&sch->root_lock_key);
> > >         netdev_put(dev, &sch->dev_tracker);
> > >         qdisc_free(sch);
> > >  err_out2:
> >
> > For consistency with the other path, what about this instead ?
> >
> > This would also  allow a qdisc goten from an rcu lookup to allow its
> > spinlock to be acquired.
> > (I am not saying this can happen, but who knows...)
> >
> > Ie defer the  lockdep_unregister_key() right before the kfree()
>
> the problem is, qdisc_free() is called also in a RCU callback. So, if we =
move
> lockdep_unregister_key() inside the function, the non-error path is
> going to splat like this

Got it, but we do have ways of running a work queue after rcu grace period.

Let's use your patch, but I suspect we could have other issues.

Full disclosure, I have the following syzbot report:

WARNING: bad unlock balance detected!
6.9.0-rc5-syzkaller-01413-gdd1941f801bc #0 Not tainted
-------------------------------------
kworker/u8:6/2474 is trying to release lock (&sch->root_lock_key) at:
[<ffffffff897300c5>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
[<ffffffff897300c5>] dev_reset_queue+0x145/0x1b0 net/sched/sch_generic.c:13=
04
but there are no more locks to release!

other info that might help us debug this:
5 locks held by kworker/u8:6/2474:
#0: ffff888015ecd948 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3229 [inline]
#0: ffff888015ecd948 ((wq_completion)netns){+.+.}-{0:0}, at:
process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
#1: ffffc9000a3a7d00 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3230 [inline]
#1: ffffc9000a3a7d00 (net_cleanup_work){+.+.}-{0:0}, at:
process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
#2: ffffffff8f59bd50 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:591
#3: ffffffff8f5a8648 (rtnl_mutex){+.+.}-{3:3}, at:
cleanup_net+0x6af/0xcc0 net/core/net_namespace.c:627
#4: ffff88802cbce258 (dev->qdisc_tx_busylock ?:
&qdisc_tx_busylock#2){+...}-{2:2}, at: spin_lock_bh
include/linux/spinlock.h:356 [inline]
#4: ffff88802cbce258 (dev->qdisc_tx_busylock ?:
&qdisc_tx_busylock#2){+...}-{2:2}, at: dev_reset_queue+0x126/0x1b0
net/sched/sch_generic.c:1299

stack backtrace:
CPU: 1 PID: 2474 Comm: kworker/u8:6 Not tainted
6.9.0-rc5-syzkaller-01413-gdd1941f801bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 03/27/2024
Workqueue: netns cleanup_net
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5194
__lock_release kernel/locking/lockdep.c:5431 [inline]
lock_release+0x599/0x9f0 kernel/locking/lockdep.c:5774
__raw_spin_unlock_bh include/linux/spinlock_api_smp.h:165 [inline]
_raw_spin_unlock_bh+0x1b/0x40 kernel/locking/spinlock.c:210
spin_unlock_bh include/linux/spinlock.h:396 [inline]
dev_reset_queue+0x145/0x1b0 net/sched/sch_generic.c:1304
netdev_for_each_tx_queue include/linux/netdevice.h:2503 [inline]
dev_deactivate_many+0x54a/0xb10 net/sched/sch_generic.c:1368
__dev_close_many+0x1a4/0x300 net/core/dev.c:1529
dev_close_many+0x24e/0x4c0 net/core/dev.c:1567
unregister_netdevice_many_notify+0x544/0x16e0 net/core/dev.c:11181
cleanup_net+0x75d/0xcc0 net/core/net_namespace.c:632
process_one_work kernel/workqueue.c:3254 [inline]
process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
kthread+0x2f0/0x390 kernel/kthread.c:388
ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
</TASK>

