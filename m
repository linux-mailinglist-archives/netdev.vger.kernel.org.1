Return-Path: <netdev+bounces-93667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1718BCAE2
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 11:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5098E281041
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0D14265F;
	Mon,  6 May 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmvjb858";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SoP3ciIn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2041422C5;
	Mon,  6 May 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988314; cv=none; b=Nx/wZr94u+gPhzlZbIR5DYa8x5+o4R441vvQBCj/9kso36bJiIBHslT5WbAJgShVbU10OYvquGijt1+UhTiz7vMOOjyhCxI5BKrr3vF6mwcJaT50NEIWmn81n+rrsVfiuDrI0lA9wK4+i6jz8bHBuleKAK77HwlQM+vzKmkAAoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988314; c=relaxed/simple;
	bh=ODpeiCqsrfnAPBRCl3YM4SgJ8qpjJ2f01XZmGwQWErc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K82XJCQ/xRdEkFnFmPxZzM4OMapflDW4ZEnwvqSQgJcapPedj3BYfokYcMEJu3z+f41P0pgyVleLKRayzV+IQkicrIOcKWfxKCjmRwgZPRTJqlm99Q1OitChkbiI0HspzlprxSjXdJpZ+JRmynBgSRep1bcfPlSV+t64w0WrL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmvjb858; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SoP3ciIn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 6 May 2024 11:38:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714988310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12S4Ks79HUDPA38wU3I+DyciMkE2tOBgkSBcQoXwOgg=;
	b=xmvjb858kngp5O+0x1+tbu2jTEnwfVHdcAYiUmnR8bob79rHQO0r//qJZLfsjpMLC1yhPc
	iCsT9R8M0T9gUZDLlfpIdGPFll4k2FJ6op3qdxe8azQmdldym+QjC8uKv/24BqIfNTR5uU
	242g6zVgds6oEpuIcZiM/gSyQesdY8MYEELXUEENr5ZkxAJG5svlhFoJFV5w1jEK/7LMNE
	ZG5+jfH7csSh/t3wkxCmqtYGCvfa9dc3UXoY15RrVX8UxWYUd/lKt2QtrAvcZajqEu4EJO
	YIFZz3911ekSX3rXIu566cPdb+uMR+yI/fStTtV1VaBYiuuFBJuVkVz0WA20nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714988310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12S4Ks79HUDPA38wU3I+DyciMkE2tOBgkSBcQoXwOgg=;
	b=SoP3ciIn1mKDgVGw1oDlWWKKwOnT+VMVuuCfO8KVKJozA4JSbq8jASebAXaemwOE9lzps7
	SdNdsNB4ZZj5R3DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 net-next 00/15] locking: Introduce nested-BH locking.
Message-ID: <20240506093828.OLP2KzcG@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <0d2eca9e80ae644583248a9e4a4bdee94999a8f8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0d2eca9e80ae644583248a9e4a4bdee94999a8f8.camel@redhat.com>

On 2024-05-06 10:43:49 [+0200], Paolo Abeni wrote:
> On Fri, 2024-05-03 at 20:25 +0200, Sebastian Andrzej Siewior wrote:
> > Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code within
> > local_bh_disable() section remains preemtible. As a result high prior
> > tasks (or threaded interrupts) will be blocked by lower-prio task (or
> > threaded interrupts) which are long running which includes softirq
> > sections.
> >=20
> > The proposed way out is to introduce explicit per-CPU locks for
> > resources which are protected by local_bh_disable() and use those only
> > on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.
>=20
> Let me rephrase to check I understood the plan correctly.
>=20
> The idea is to pair 'bare' local_bh_{disable,enable} with local lock
> and late make local_bh_{disable,enable} no ops (on RT).
>=20
> With 'bare' I mean not followed by a spin_lock() - which is enough to
> ensure mutual exclusion vs BH on RT build - am I correct?

I might have I misunderstood your rephrase. But to make it clear:
| $ git grep -p local_lock\( kernel/softirq.c
| kernel/softirq.c=3Dvoid __local_bh_disable_ip(unsigned long ip, unsigned =
int cnt)
| kernel/softirq.c:                       local_lock(&softirq_ctrl.lock);

this is what I want to remove. This is upstream RT only (not RT queue
only). !RT builds are not affected by this change.

> > The series introduces the infrastructure and converts large parts of
> > networking which is largest stake holder here. Once this done the
> > per-CPU lock from local_bh_disable() on PREEMPT_RT can be lifted.
>=20
> AFAICS there are a bunch of local_bh_* call-sites under 'net' matching
> the above description and not addressed here. Is this series supposed
> to cover 'net' fully?

The net subsystem has not been fully audited but the major parts have
been. I checked global per-CPU variables but there might be dynamic
ones. Also new ones might have appeared in the meantime. There are
two things which are not fixed yet that I am aware of:
- tw_timer timer
  https://lore.kernel.org/all/20240415113436.3261042-1-vschneid@redhat.com/=
T/#u

- can gw
  https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutronix.de/
  https://lore.kernel.org/all/20231221123703.8170-1-socketcan@hartkopp.net/=
T/#u

That means those two need to be fixed first before that local_local()
can disappear from local_bh_disable()/ enable. Also the whole tree
should be checked.

> Could you please include the diffstat for the whole series? I
> think/hope it will help catching the full picture more easily.

total over the series:

| include/linux/filter.h              | 134 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++-------
| include/linux/local_lock.h          |  21 +++++++++++++++++++++
| include/linux/local_lock_internal.h |  31 +++++++++++++++++++++++++++++++
| include/linux/lockdep.h             |   3 +++
| include/linux/netdevice.h           |  12 ++++++++++++
| include/linux/sched.h               |   9 ++++++++-
| include/net/seg6_local.h            |   1 +
| include/net/sock.h                  |   5 +++++
| kernel/bpf/cpumap.c                 |  27 +++++++++++----------------
| kernel/bpf/devmap.c                 |  16 ++++++++--------
| kernel/fork.c                       |   3 +++
| kernel/locking/spinlock.c           |   8 ++++++++
| net/bpf/test_run.c                  |  11 ++++++++++-
| net/bridge/br_netfilter_hooks.c     |   7 ++++++-
| net/core/dev.c                      |  39 +++++++++++++++++++++++++++++++=
++------
| net/core/dev.h                      |  20 ++++++++++++++++++++
| net/core/filter.c                   | 107 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++---------------------------------------
| net/core/lwt_bpf.c                  |   9 +++++----
| net/core/skbuff.c                   |  25 ++++++++++++++++---------
| net/ipv4/tcp_ipv4.c                 |  15 +++++++++++----
| net/ipv4/tcp_sigpool.c              |  17 +++++++++++++----
| net/ipv6/seg6_local.c               |  22 ++++++++++++++--------
| net/xdp/xsk.c                       |  19 +++++++++++--------
| 23 files changed, 445 insertions(+), 116 deletions(-)

> Note that some callers use local_bh_disable(), no additional lock, and
> there is no specific struct to protect, but enforce explicit
> serialization vs bh to a bunch of operation, e.g.  the
> local_bh_disable() in inet_twsk_purge().
>=20
> I guess such call site should be handled, too?

Yes but I didn't find much. inet_twsk_purge() is the first item from my
list. On RT spin_lock() vs spin_lock_bh() usage does not deadlock and
could be mixed.

The only resources that can be protected by disabling BH are per-CPU
resources. Either explicit defined (such as napi_alloc_cache) or
implicit by other means of per-CPU usage such as a CPU-bound timer,
worker, =E2=80=A6. Protecting global variables by disabling BH is broken on=
 SMP
(see the CAN gw example) so I am not too worried about those.
Unless you are aware of a category I did not think of.

> Thanks!
>=20
> Paolo

Sebastian

