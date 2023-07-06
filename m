Return-Path: <netdev+bounces-15840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778AC74A23F
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F862813BF
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7868F7D;
	Thu,  6 Jul 2023 16:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6F33E2;
	Thu,  6 Jul 2023 16:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4518EC433C7;
	Thu,  6 Jul 2023 16:33:03 +0000 (UTC)
Date: Thu, 6 Jul 2023 12:33:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vivek Anand <vivekanand754@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Pablo Neira
 Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lingutla Chandrasekhar
 <clingutla@codeaurora.org>, Frederic Weisbecker <frederic@kernel.org>, "J.
 Avila" <elavila@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Regressions
 <regressions@lists.linux.dev>, Linux Netfilter Development
 <netfilter-devel@vger.kernel.org>, Netfilter Core Developers
 <coreteam@netfilter.org>, Linux Networking <netdev@vger.kernel.org>, Linux
 Power Management <linux-pm@vger.kernel.org>, x86@kernel.org
Subject: Re: High cpu usage caused by kernel process when upgraded to linux
 5.19.17 or later
Message-ID: <20230706123300.55d6450b@gandalf.local.home>
In-Reply-To: <CAJnqnX5dHiXe3smKhj6JT9+6FNdgrAR=5_Hm8BSRpVF3uARYUg@mail.gmail.com>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
	<ZJpJkL3dPXxgw6RK@debian.me>
	<20230627073035.GV4253@hirez.programming.kicks-ass.net>
	<99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
	<20230627101939.GZ4253@hirez.programming.kicks-ass.net>
	<CAJnqnX5rYn65zVQ+SLN4m4ZzM_jOa_RjGhazWO=Fh8ZvdOCadg@mail.gmail.com>
	<878rc22vxq.ffs@tglx>
	<CAJnqnX5dHiXe3smKhj6JT9+6FNdgrAR=5_Hm8BSRpVF3uARYUg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jul 2023 18:23:25 +0530
Vivek Anand <vivekanand754@gmail.com> wrote:

> Hi Thomas,
>=20
> Further analyzing, I found that I did set
> "CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm" in my kernel config earlier which w=
as
> causing high CPU consumption.
> Setting it to "CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dn" resolved the high CPU
> issue.
>=20
> Is there any suggestion regarding the use of this config
> "CONFIG_NETFILTER_XT_MATCH_LIMIT" as I'm getting high CPU by setting it to
> "m" ?

That config enables the compiling of: net/netfilter/xt_limit.c

The htable_gc that you reported is defined in: net/netfilter/xt_hashlimit.c

It has:

static void htable_gc(struct work_struct *work)
{
        struct xt_hashlimit_htable *ht;

        ht =3D container_of(work, struct xt_hashlimit_htable, gc_work.work);

        htable_selective_cleanup(ht, false);

        queue_delayed_work(system_power_efficient_wq,
                           &ht->gc_work, msecs_to_jiffies(ht->cfg.gc_interv=
al));
}

So it queues itself every ht->cfg.gc_interval msecs. That variable seems to
come from some configuration of netfilter, and I think you can see these in:

 find /proc/sys/net -name 'gc_interval'

Perhaps you have it set off to go too much?

-- Steve


>=20
> Thanks,
> Vivek
>=20
> On Thu, Jun 29, 2023 at 7:48=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>=20
> > On Thu, Jun 29 2023 at 12:05, Vivek Anand wrote:
> > > I've tried booting with "spectre_v2=3Dretpoline retbleed=3Doff".
> > > This change didn't work. Still CPU is 100%
> >
> > This does not make sense.
> >
> > retbleed=3Doff has the same effect as CONFIG_X86_IBRS_ENTRY=3Dn.
> >
> > The only difference is that with CONFIG_X86_IBRS_ENTRY=3Dy and
> > retbleed=3Doff there is one extra jump in the low level entry code
> > (syscall, interrupts, exceptions) and one extra jump on the exit side.
> >
> > But those extra jumps are completely irrelevant for the kworker threads.
> >
> > Can you please provide dmesg and the content of the files in
> >
> >  /sys/devices/system/cpu/vulnerabilities/
> >
> > on a kernel booted with "spectre_v2=3Dretpoline retbleed=3Doff" ?
> >
> > Thanks,
> >
> >         tglx
> >


