Return-Path: <netdev+bounces-84111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6131C8959D4
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3436282E30
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE11598F9;
	Tue,  2 Apr 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sDabu/dS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34330133283
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075847; cv=none; b=q9uvpoy776ZfbhRmbCjKBESyU91pISGQ9OdkGGyVZzRYMLs+wztmuYcVeEWh6mUkgTEwQaqHs44BaRJ6Sqs9NfAQu7LwMzrh6E4rje3dp6baMgELQXjDJPu+UXudtHPEE5Eqii/+fGJGHlzIZC5ImSz6o9hkYQxwyw/crqIOCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075847; c=relaxed/simple;
	bh=Ftu1/YtbphAuRzS6+kzLDjRXWgk3WQY3tSjLqYtXoRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJNGtLShqZcuekoeWkrhcO1df/WAG6icJMWpYssIHwHPrjqcYImgDJlcmcPPc/91lmH/dsFB1FQGZVtyq5JdB12gH8FvYR8mVwE4rwaeIqnEB5QP9rig+ZtUAQc5VWlq9zEL2+EPayDacS1So2WR0own+teXy3Ku2e2puwE4JRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=sDabu/dS; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6152ad16cd6so8896957b3.2
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712075844; x=1712680644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnOInSmpy9bn+aaODUeRXpb9+P4vfUZ3Y7TCRowdO0U=;
        b=sDabu/dSRtqn0dx6tyS0O49fXEZIRrsI+ze7l7TbzEpSj2zAhSW9ZDOXRuHT3Y+1UW
         lN69Um1eOHXkq7nxBcAAit3PlpJks8XdEJ7PlLT0WR9Y6zh/mwv/xuwHDXLftfvIT3Kj
         t3pPX2NfQhWerL1A+0RobGUjdBsCu72DHmkHtmq9Mgk5J0VdaiNOqW3IS899rP1JsKit
         gBoufAajIobSbgiFWgq40Jwg6kJ4q8e63gAMa08sA2iT2ke5SDMtsK0WO1NEgyczP09a
         s5siSxMhTAU8xhz+2LqP82hiWeoV2cqq91TcHT7LtkfemtaihwMmbBdWeR5GY+TM10Po
         W4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075844; x=1712680644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnOInSmpy9bn+aaODUeRXpb9+P4vfUZ3Y7TCRowdO0U=;
        b=UeijLomDaWoxGwnBvZiQM0mq29HqnAwYnpLijT1YvpCPUS7CWF6QHCeU1rvC9N9mD3
         rmoUZioC6J4AShVvQ0hfphvvGwXCKDtDgS+LhvsmNSu1/3SBrdgguss/r82b8JV2LaEf
         yMMVT+ZNVdDO2nnQPGt7t3rXTGVQJzb719XB2cB+cDBSnggTmwiYuDjkToYFBI+XqFLU
         x9YpLvGh37NLUVgUii577n8EBw5KETIDmRWhxaWrUqI+W8YIsLMGmiiiUcYe18m/AOLD
         U5izo7EP2u3Mxb8xYJHMcwZENtH59jmdKzWfWtizud6YWG4H42UNAtEnh/VdYVvfKQ0x
         PiKA==
X-Forwarded-Encrypted: i=1; AJvYcCWNKBo6KRgWlKsG3CpHMjkIJJEBT/Lk86a7wfeahPvtw4Kyin84z9Vz6Y79O5c0H9nKSy0jXoZCljT5PYkXtY07fWT4Aunq
X-Gm-Message-State: AOJu0YwNDAcnEw/WQsKCdwTDOZPcg7cIKQ9tep+SRq/qFLC8Oo3TjmtF
	DCaHvgakrLOgYhhx5cTfJ4Fqdz4pSsugbwgkEigY+M7N83fpMPDjAAKZoQCENVo71SC1A1Kvg0C
	/KuLW5nXNSxhAWaNpjCXtQ16oWUVOBT1+6IUO
X-Google-Smtp-Source: AGHT+IHg05AFU9nr3+SMcgPtwjdHnLUy82kmkDRwQcJfbthoidtVj0A0aODVQD98B5W/7F7yMV8QINVB7xURcXWgV5c=
X-Received: by 2002:a0d:fbc5:0:b0:609:8ed6:c491 with SMTP id
 l188-20020a0dfbc5000000b006098ed6c491mr12628665ywf.26.1712075844110; Tue, 02
 Apr 2024 09:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402134133.2352776-1-edumazet@google.com>
In-Reply-To: <20240402134133.2352776-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Apr 2024 12:37:12 -0400
Message-ID: <CAM0EoMkL4UVOjy1mj-w04kned3e0czuRAiyfq9cWzP4PBWwWYw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:41=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> qdisc_tree_reduce_backlog() is called with the qdisc lock held,
> not RTNL.
>
> We must use qdisc_lookup_rcu() instead of qdisc_lookup()
>
> syzbot reported:
>
> WARNING: suspicious RCU usage
> 6.1.74-syzkaller #0 Not tainted
> -----------------------------
> net/sched/sch_api.c:305 suspicious rcu_dereference_protected() usage!
>
> other info that might help us debug this:
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> 3 locks held by udevd/1142:
>   #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire =
include/linux/rcupdate.h:306 [inline]
>   #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock inc=
lude/linux/rcupdate.h:747 [inline]
>   #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: net_tx_action+0x6=
4a/0x970 net/core/dev.c:5282
>   #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: spin_lock include/=
linux/spinlock.h:350 [inline]
>   #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: net_tx_action+0x75=
4/0x970 net/core/dev.c:5297
>   #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire =
include/linux/rcupdate.h:306 [inline]
>   #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock inc=
lude/linux/rcupdate.h:747 [inline]
>   #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: qdisc_tree_reduce=
_backlog+0x84/0x580 net/sched/sch_api.c:792
>
> stack backtrace:
> CPU: 1 PID: 1142 Comm: udevd Not tainted 6.1.74-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> Call Trace:
>  <TASK>
>   [<ffffffff85b85f14>] __dump_stack lib/dump_stack.c:88 [inline]
>   [<ffffffff85b85f14>] dump_stack_lvl+0x1b1/0x28f lib/dump_stack.c:106
>   [<ffffffff85b86007>] dump_stack+0x15/0x1e lib/dump_stack.c:113
>   [<ffffffff81802299>] lockdep_rcu_suspicious+0x1b9/0x260 kernel/locking/=
lockdep.c:6592
>   [<ffffffff84f0054c>] qdisc_lookup+0xac/0x6f0 net/sched/sch_api.c:305
>   [<ffffffff84f037c3>] qdisc_tree_reduce_backlog+0x243/0x580 net/sched/sc=
h_api.c:811
>   [<ffffffff84f5b78c>] pfifo_tail_enqueue+0x32c/0x4b0 net/sched/sch_fifo.=
c:51
>   [<ffffffff84fbcf63>] qdisc_enqueue include/net/sch_generic.h:833 [inlin=
e]
>   [<ffffffff84fbcf63>] netem_dequeue+0xeb3/0x15d0 net/sched/sch_netem.c:7=
23
>   [<ffffffff84eecab9>] dequeue_skb net/sched/sch_generic.c:292 [inline]
>   [<ffffffff84eecab9>] qdisc_restart net/sched/sch_generic.c:397 [inline]
>   [<ffffffff84eecab9>] __qdisc_run+0x249/0x1e60 net/sched/sch_generic.c:4=
15
>   [<ffffffff84d7aa96>] qdisc_run+0xd6/0x260 include/net/pkt_sched.h:125
>   [<ffffffff84d85d29>] net_tx_action+0x7c9/0x970 net/core/dev.c:5313
>   [<ffffffff85e002bd>] __do_softirq+0x2bd/0x9bd kernel/softirq.c:616
>   [<ffffffff81568bca>] invoke_softirq kernel/softirq.c:447 [inline]
>   [<ffffffff81568bca>] __irq_exit_rcu+0xca/0x230 kernel/softirq.c:700
>   [<ffffffff81568ae9>] irq_exit_rcu+0x9/0x20 kernel/softirq.c:712
>   [<ffffffff85b89f52>] sysvec_apic_timer_interrupt+0x42/0x90 arch/x86/ker=
nel/apic/apic.c:1107
>   [<ffffffff85c00ccb>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86=
/include/asm/idtentry.h:656
>
> Fixes: d636fc5dd692 ("net: sched: add rcu annotations around qdisc->qdisc=
_sleeping")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/sch_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 65e05b0c98e461953aa8d98020142f0abe3ad8a7..60239378d43fb7adfe3926f92=
7f3883f09673c16 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -809,7 +809,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int=
 n, int len)
>                 notify =3D !sch->q.qlen && !WARN_ON_ONCE(!n &&
>                                                        !qdisc_is_offloade=
d);
>                 /* TODO: perform the search on a per txq basis */
> -               sch =3D qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
> +               sch =3D qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parenti=
d));
>                 if (sch =3D=3D NULL) {
>                         WARN_ON_ONCE(parentid !=3D TC_H_ROOT);
>                         break;
> --
> 2.44.0.478.gd926399ef9-goog
>

