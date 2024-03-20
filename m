Return-Path: <netdev+bounces-80868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773298815FD
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 17:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24F2B23438
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D46A010;
	Wed, 20 Mar 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="va8cuuFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BC69DF7
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953887; cv=none; b=aHFlR52v9Tt6zywfp4WrJ7pbAFU3OnhU3gJtILhKQHgjUmykX3WK2uMDRI2FTNZb4S6NEVQ5V0DjOi/TkN70PdRUbDaJZVNDaH/87ojlXVrF/XVqcSXtqG5x5VZ+CoyMndIjClJNjiF7JxSNC48h3eZeza/5sCmqU36960lGVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953887; c=relaxed/simple;
	bh=mJrymtDICi7bFPltbPdz2gu7QDCeDyi2aNoLDRK3u2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9uqJwnoRzzOw7dB9r+Z0d46IR09biNT3bSw8rb8bmEnGSGnJOmg9jlEaUtiqqmPBbnx6XDixV/B/L5Ub/pii2MFtocxc+Ji6HjNwvjh3f9KQZokHsGOc8ifEiy/o8m4Lh+aDEnjcyPNtZyqSn5AOuOZoSUjrCygTUh2WQwPcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=va8cuuFg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56b9dac4e6cso310a12.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710953883; x=1711558683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzPodG4qFomJO8EjbK+loR6z9eNmrS/kvFeMe1pqOxg=;
        b=va8cuuFgWChWq9anC9kEUlY+hJRsS6KzTS3VAMb6RkGw8k6czYlS6i7A6Jq3HF8goR
         EJNvg0D27+AAPA31e4od1RI4X6R2ILOFHWqE7xlCuNC26hpoHN9S9J/fThnKBVMe5EAa
         RQ3LMUFD0mofm9aSXNFC3XJFnLuPotiDKup7DpUbS7/P2VlgeoWhStCMUckgzIoIApWb
         VOqMq+FBNCcV1Cll5fNhudV7V7YPyMCu23NXhACGyJvbppw3URz36zYDkQfJg+5zoAmZ
         w/G73KV37sZBQEvYvBdzIGz5OdtKrzOLPSVT0fIDfHnOIMQBpT6GtbLVXpRudfF2JXE/
         oLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710953883; x=1711558683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzPodG4qFomJO8EjbK+loR6z9eNmrS/kvFeMe1pqOxg=;
        b=Zb/2r3ypulKy4TZykEuMFkECTRVzxicCeoJNMzIreUIzAyrf/OJSj30kwXdRkDI82W
         MpYyRoU9arZEkFx2N6N59Rx+quSVfTJM6rR40Lpu+23Fe84wyzGolLA9DEp8qmp+2fbU
         siTsrlmf1tK3aUDyelkGvfi+ZeD+chbP9cMS05VgEWc2I7QuRYRH97U/VlDpVcSrLU9A
         51It2gy8SUp1OZ7y8QgoHjIVffl0BgzgAgoS62ZkqHmennH+IfyUPBgC0us+36F+U8XN
         qpsk6Cc9rFfiWKwjQ0Zy4UFu4FRnWtcBHa+ha7VePn14sYCeuweSYmZYUFvA/YvhnLYr
         RnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU67mtIl+kZipj6davGOCUnJ+xqtFRmymSUMQp/dwOi+xV1ivitOImVytMc0HSKmlSmmscNOBGgEN5I/+qSSbtxurwgu/zd
X-Gm-Message-State: AOJu0Yw27zx3eQtsLw2NUz6B7LTak0h00/jeVDk3zNX2kDsxi/7ApMaH
	IAS7E3kHGwN0CtCCJ/0PsEzO407rqsqEej4INQbIdld/4T4G1vFFYw07AgDhV9llWr51lOgodzZ
	m+Hb59sdtzX15+SYitvuxgUUrB1UBmwvhgdjR
X-Google-Smtp-Source: AGHT+IHp9rpPNLc7D04a2Vlegq+BarNCT0eDwVjBHcW3jFj+1I/j4pCFnbEipACZrmhKgZC99ZKmx2zW+xfSlFRiicE=
X-Received: by 2002:a05:6402:1d08:b0:56b:b856:7eb5 with SMTP id
 dg8-20020a0564021d0800b0056bb8567eb5mr90332edb.4.1710953882883; Wed, 20 Mar
 2024 09:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
 <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
 <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
 <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
 <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
 <CAM0EoMkDexWQ_Rj_=gKMhWzSgQqtbAdyDv8DXgY+nk_2Rp3drg@mail.gmail.com>
 <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com> <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Mar 2024 17:57:51 +0100
Message-ID: <CANn89iLjK3vf-yHvKdY=wvOdEeWubB0jt2=5d-1m7dkTYBwBOg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:54=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Mar 19, 2024 at 5:38=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Mar 18, 2024 at 11:05=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 6:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Mon, Mar 18, 2024 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 18, 2024 at 3:27=E2=80=AFPM Jamal Hadi Salim <jhs@m=
ojatatu.com> wrote:
> > > > > > >
> > > > > > > On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim <jh=
s@mojatatu.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <j=
hs@mojatatu.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <ren=
mingshuai@huawei.com> wrote:
> > > > > > > > > >
> > > > > > > > > > As we all know the mirred action is used to mirroring o=
r redirecting the
> > > > > > > > > > packet it receives. Howerver, add mirred action to a fi=
lter attached to
> > > > > > > > > > a egress qdisc might cause a deadlock. To reproduce the=
 problem, perform
> > > > > > > > > > the following steps:
> > > > > > > > > > (1)tc qdisc add dev eth0 root handle 1: htb default 30 =
\n
> > > > > > > > > > (2)tc filter add dev eth2 protocol ip prio 2 flower ver=
bose \
> > > > > > > > > >      action police rate 100mbit burst 12m conform-excee=
d jump 1 \
> > > > > > > > > >      / pipe mirred egress redirect dev eth2 action drop
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I think you meant both to be the same device eth0 or eth2=
?
> > > > > > > > >
> > > > > > > > > > The stack is show as below:
> > > > > > > > > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > > > > > > > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > > > > > > > > [28848.884851]  ? 0xffffffffc031906a
> > > > > > > > > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > > > > > > > > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > > > > > > > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > > > > > > > > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > > > > > > > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > > > > > > > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables=
]
> > > > > > > > > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > > > > > > > > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > > > > > > > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_connt=
rack]
> > > > > > > > > > [28848.890293]  ? do_select+0x637/0x870
> > > > > > > > > > [28848.890735]  tcf_classify+0x52/0xf0
> > > > > > > > > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > > > > > > > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > > > > > > > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > > > > > > > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > > > > > > > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > > > > > > > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > > > > > > > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > > > > > > > > >
> > > > > > > > > > In this case, the process has hold the qdisc spin lock =
in __dev_queue_xmit
> > > > > > > > > > before the egress packets are mirred, and it will attem=
pt to obtain the
> > > > > > > > > > spin lock again after packets are mirred, which cause a=
 deadlock.
> > > > > > > > > >
> > > > > > > > > > Fix the issue by forbidding assigning mirred action to =
a filter attached
> > > > > > > > > > to the egress.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > > > > > > > > > ---
> > > > > > > > > >  net/sched/act_mirred.c                        |  4 +++
> > > > > > > > > >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++=
++++++++++++++++
> > > > > > > > > >  2 files changed, 36 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mir=
red.c
> > > > > > > > > > index 5b3814365924..fc96705285fb 100644
> > > > > > > > > > --- a/net/sched/act_mirred.c
> > > > > > > > > > +++ b/net/sched/act_mirred.c
> > > > > > > > > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct =
net *net, struct nlattr *nla,
> > > > > > > > > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requ=
ires attributes to be passed");
> > > > > > > > > >                 return -EINVAL;
> > > > > > > > > >         }
> > > > > > > > > > +       if (tp->chain->block->q->parent !=3D TC_H_INGRE=
SS) {
> > > > > > > > > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can =
only be assigned to the filter attached to ingress");
> > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > > Sorry, this is too restrictive as Jiri said. We'll try to=
 reproduce. I
> > > > > > > > > am almost certain this used to work in the old days.
> > > > > > > >
> > > > > > > > Ok, i looked at old notes - it did work at "some point" pre=
-tdc.
> > > > > > > > Conclusion is things broke around this time frame:
> > > > > > > > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-=
email-fw@strlen.de/
> > > > > > > > https://lore.kernel.org/netdev/1465095748.2968.45.camel@edu=
mazet-glaptop3.roam.corp.google.com/
> > > > > > > >
> > > > > > > > Looking further into it.
> > > > > > >
> > > > > > > This is what we came up with. Eric, please take a look...
> > > > > > >
> > > > > > > cheers,
> > > > > > > jamal
> > > > > > >
> > > > > > >
> > > > > > > --- a/net/core/dev.c
> > > > > > > +++ b/net/core/dev.c
> > > > > > > @@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(struc=
t sk_buff
> > > > > > > *skb, struct Qdisc *q,
> > > > > > >         if (unlikely(contended))
> > > > > > >                 spin_lock(&q->busylock);
> > > > > > >
> > > > > > > +       if (dev_recursion_level()) {
> > > > > >
> > > > > > I am not sure what your intent is, but this seems wrong to me.
> > > > > >
> > > > >
> > > > > There is a deadlock if you reenter the same device which has a qd=
isc
> > > > > attached to it more than once.
> > > > > Essentially entering __dev_xmit_skb() we grab the root qdisc lock=
 then
> > > > > run some action which requires it to grab the root qdisc lock (ag=
ain).
> > > > > This is easy to show with mirred (although i am wondering if syzk=
aller
> > > > > may have produced this at some point)..
> > > > > $TC qdisc add dev $DEV root handle 1: htb default 1
> > > > > $TC filter add dev $DEV protocol ip u32 match ip protocol 1 0xff
> > > > > action mirred egress mirror dev $DEV
> > > > >
> > > > > Above example is essentially egress $DEV-> egress $DEV in both ca=
ses
> > > > > "egress $DEV" grabs the root qdisc lock. You could also create an=
other
> > > > > example with egress($DEV1->$DEV2->back to $DEV1).
> > > > >
> > > > > > Some valid setup use :
> > > > > >
> > > > > > A bonding device, with HTB qdisc (or other qdisc)
> > > > > >   (This also could be a tunnel device with a qdisc)
> > > > > >
> > > > > > -> one or multiple physical NIC, wth FQ or other qdisc.
> > > > > >
> > > > > > Packets would be dropped here when we try to reach the physical=
 device.
> > > > > >
> > > > >
> > > > > If you have an example handy please send it. I am trying to imagi=
ne
> > > > > how those would have worked if they have to reenter the root qdis=
c of
> > > > > the same dev multiple times..
> > > >
> > > > Any virtual device like a GRE/SIT/IPIP/... tunnel, add a qdisc on i=
t ?
> > > >
> > > > dev_xmit_recursion_inc() is global (per-cpu), it is not per-device.
> > > >
> > > > A stack of devices A -> B -> C  would elevate the recursion level t=
o
> > > > three just fine.
> > > >
> > > > After your patch, a stack of devices would no longer work.
> > > >
> > > > It seems mirred correctly injects packets to the top of the stack f=
or
> > > > ingress (via netif_rx() / netif_receive_skb()),
> > > > but thinks it is okay to call dev_queue_xmit(), regardless of the c=
ontext ?
> > > >
> > > > Perhaps safe-guard mirred, instead of adding more code to fast path=
.
> > >
> > > I agree not to penalize everybody for a "bad config" like this
> > > (surprising syzkaller hasnt caught this). But i dont see how doing th=
e
> > > checking within mirred will catch this (we cant detect the A->B->A
> > > case).
> > > I think you are suggesting a backlog-like queue for mirred? Not far
> > > off from that is how it used to work before
> > > (https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-gla=
ptop3.roam.corp.google.com/)
> >
> >
> > spin_trylock() had to go. There is no way we could keep this.
> >
>
> Not asking for it to come back... just pointing out why it worked before.
>
> > > - i.e we had a trylock for the qdisc lock and if it failed we tagged
> > > the rx softirq for a reschedule. That in itself is insufficient, we
> > > would need a loop check which is per-skb (which we had before
> > > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw@s=
trlen.de/).
> > > There are other gotchas there, potentially packet reordering.
> >
> > If we want to make sure dev_queue_xmit() is called from the top (no
> > spinlock held),
> > then we need a queue, serviced from another context.
> >
> > This extra queueing could happen if
> > __this_cpu_read(softnet_data.xmit.recursion) > 0
> >
>
> I dont see a way to detect softnet_data.xmit.recursion > 0 at mirred
> level. The first time we enter it will be 0.

Then it is fine, no qdisc spinlock is held at this point.

 The second time we would
> deadlock before we hit mirred.

This is not how I see the trace.

Mirred would detect that and either drop or queue the packet to a work
queue or something.

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 5b38143659249e66718348e0ec4ed3c7bc21c13d..a2c53e200629a17130f38246ab3=
cdb8c89c6d30e
100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -237,9 +237,15 @@ tcf_mirred_forward(bool at_ingress, bool
want_ingress, struct sk_buff *skb)
 {
        int err;

-       if (!want_ingress)
+       if (!want_ingress) {
+               if (__this_cpu_read(softnet_data.xmit.recursion) > 0) {
+                       // TODO increment a drop counter perhaps ?
+                       kfree_skb(skb);
+                       return -EINVAL;
+               }
+
                err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
-       else if (!at_ingress)
+       } else if (!at_ingress)
                err =3D netif_rx(skb);
        else
                err =3D netif_receive_skb(skb);

