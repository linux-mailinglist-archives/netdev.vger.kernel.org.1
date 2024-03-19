Return-Path: <netdev+bounces-80692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C288064F
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 21:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E8E283ECF
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC433BBED;
	Tue, 19 Mar 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2FEZ7aii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75963BBC7
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881696; cv=none; b=rEAzUVJJH6pSrlnFpP3Qops7arJCIsxPfAW1l26AoQ1WMSMsRXY2bAHbnaNv9hyzH0uuOsECcIjGG3DpBnxK1VNBOfXR0U8e9lnxQhjuHMSTQJmtZeXccWAVch3DA3G/jgDNywzKjAkGxwzOwKi/1tTcXCfqSUzMItnDWj5/Vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881696; c=relaxed/simple;
	bh=LQvTxXYbcsp9TFIT7h1YYHTPZwAxGjEVTzRQMWOzQgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3U6Wh8W1Q3hj2CP3E8Fhmon6xRrjxqrTFXEo0/wNMspjxjPMy4KkvuLBH9TuB3/4m+jBCjdrgjXSMjyjTXX0MqTJMar4YxxInUxSRXsa37In7tN6l+oAppnW53D6/9dWZ1GSHrteu7piJcDDtQACjZlDHQ/Au0uK7vn4m3HOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2FEZ7aii; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a434ea806so65549837b3.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710881693; x=1711486493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha5surPc/Q5avUtZPlPwQSkY+uM9tUDjUMqFaPrdcrc=;
        b=2FEZ7aiihihX5DMkxRterDdS5LKhgvlZKy/7WCSqvn95BbgqlK36D10KVCc5rNcXAz
         O/tomQGHCP6CETh/VqKPjGPGW95QomyLMGyXE4yz2YkwfYqdUUt8oc5Bci+1X8DoO6Jq
         zGfruRymz/3htcoVnuPZW0V1bQQoj0Oy/uJy2hQlwj+3hxZlekYnekUMLI9BcnhM6bgW
         Z5Y/gwsHOcX7+hP4i8ljWLsTW9J54owvRwRc1bWDsPNw6CpkhInzfRYxdmWJx531ltwZ
         R5fCIQFgQmdxL6mohyQKYmRzKMUbOluxpfazitysN3I5QQCjhD+K+r3hrf58wWJgbDpc
         vrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881693; x=1711486493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ha5surPc/Q5avUtZPlPwQSkY+uM9tUDjUMqFaPrdcrc=;
        b=U3w9vUT4CTfM/PJNtF6OR3UkZQy+uKEZevFO3rW4c9FHthRTXjJX5Cb85NOoBLbWvW
         ctHh1kHLaV6KVBT6yDpK7AEaRpQOi0hFF+2/H3+gdJk48YEJ/CZ+x0jRNeHlNvhXzYli
         RYyENspIppEuxyj7yW3myIGTsTc8tOq8lqKZPRw9JEuddme3Kcufcp8MzjPT/SDvxp1N
         yieQrdX8NOoQ/ad08JD57/9k+XH+zQ7oRvWeFfMWWkuNF31vJn0GWn9yCCSATpvNv/AO
         1GstmeFPt0pfgEnH4iuhq9RtDkBf9yXLX0LP7DHtsWew1rmDEJFxyhY8P1QD+EDRyF13
         UfvA==
X-Forwarded-Encrypted: i=1; AJvYcCUN6fAAIARvJOPEP30OcXyt0RRgoPE7ebHfi46PEbeER/eaatgXXPUI9eUMBTFMM4R9rJXOg6/Hl8xlKUXiWFcotE8x2YeZ
X-Gm-Message-State: AOJu0Yyh6JYLlfakqcVOgjZ1wOuFUTN7CO0rtGf/oTGKVayz2bINIx7w
	ajFbyfYTCh01qW1T3bv+YJCZRxC4VG5PiKgXJmvOHk84hw134gpXHQ+/YHZz8VrjZZbpzvthRcS
	g6i1gDbdyDkRSO/8teYp86ns8d2KaHSSs5ueW
X-Google-Smtp-Source: AGHT+IHjjhW9Mkc3MLi6AOXsxcvpZLuQOJNY5GEHtIJTZ5uVt1mdDCC/RFDainqjKD6ddgbeQDnoyNq4EjeHd53ZWV8=
X-Received: by 2002:a81:dd06:0:b0:610:bc71:43ab with SMTP id
 e6-20020a81dd06000000b00610bc7143abmr8114088ywn.44.1710881692500; Tue, 19 Mar
 2024 13:54:52 -0700 (PDT)
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
 <CAM0EoMkDexWQ_Rj_=gKMhWzSgQqtbAdyDv8DXgY+nk_2Rp3drg@mail.gmail.com> <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com>
In-Reply-To: <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 19 Mar 2024 16:54:41 -0400
Message-ID: <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Eric Dumazet <edumazet@google.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 5:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 18, 2024 at 11:05=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Mon, Mar 18, 2024 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 6:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > On Mon, Mar 18, 2024 at 3:27=E2=80=AFPM Jamal Hadi Salim <jhs@moj=
atatu.com> wrote:
> > > > > >
> > > > > > On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim <jhs@=
mojatatu.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <jhs=
@mojatatu.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmi=
ngshuai@huawei.com> wrote:
> > > > > > > > >
> > > > > > > > > As we all know the mirred action is used to mirroring or =
redirecting the
> > > > > > > > > packet it receives. Howerver, add mirred action to a filt=
er attached to
> > > > > > > > > a egress qdisc might cause a deadlock. To reproduce the p=
roblem, perform
> > > > > > > > > the following steps:
> > > > > > > > > (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> > > > > > > > > (2)tc filter add dev eth2 protocol ip prio 2 flower verbo=
se \
> > > > > > > > >      action police rate 100mbit burst 12m conform-exceed =
jump 1 \
> > > > > > > > >      / pipe mirred egress redirect dev eth2 action drop
> > > > > > > > >
> > > > > > > >
> > > > > > > > I think you meant both to be the same device eth0 or eth2?
> > > > > > > >
> > > > > > > > > The stack is show as below:
> > > > > > > > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > > > > > > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > > > > > > > [28848.884851]  ? 0xffffffffc031906a
> > > > > > > > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > > > > > > > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > > > > > > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > > > > > > > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > > > > > > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > > > > > > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> > > > > > > > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > > > > > > > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > > > > > > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntra=
ck]
> > > > > > > > > [28848.890293]  ? do_select+0x637/0x870
> > > > > > > > > [28848.890735]  tcf_classify+0x52/0xf0
> > > > > > > > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > > > > > > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > > > > > > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > > > > > > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > > > > > > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > > > > > > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > > > > > > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > > > > > > > >
> > > > > > > > > In this case, the process has hold the qdisc spin lock in=
 __dev_queue_xmit
> > > > > > > > > before the egress packets are mirred, and it will attempt=
 to obtain the
> > > > > > > > > spin lock again after packets are mirred, which cause a d=
eadlock.
> > > > > > > > >
> > > > > > > > > Fix the issue by forbidding assigning mirred action to a =
filter attached
> > > > > > > > > to the egress.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > > > > > > > > ---
> > > > > > > > >  net/sched/act_mirred.c                        |  4 +++
> > > > > > > > >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++=
++++++++++++++
> > > > > > > > >  2 files changed, 36 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirre=
d.c
> > > > > > > > > index 5b3814365924..fc96705285fb 100644
> > > > > > > > > --- a/net/sched/act_mirred.c
> > > > > > > > > +++ b/net/sched/act_mirred.c
> > > > > > > > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct ne=
t *net, struct nlattr *nla,
> > > > > > > > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requir=
es attributes to be passed");
> > > > > > > > >                 return -EINVAL;
> > > > > > > > >         }
> > > > > > > > > +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS=
) {
> > > > > > > > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can on=
ly be assigned to the filter attached to ingress");
> > > > > > > > > +               return -EINVAL;
> > > > > > > > > +       }
> > > > > > > >
> > > > > > > > Sorry, this is too restrictive as Jiri said. We'll try to r=
eproduce. I
> > > > > > > > am almost certain this used to work in the old days.
> > > > > > >
> > > > > > > Ok, i looked at old notes - it did work at "some point" pre-t=
dc.
> > > > > > > Conclusion is things broke around this time frame:
> > > > > > > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-em=
ail-fw@strlen.de/
> > > > > > > https://lore.kernel.org/netdev/1465095748.2968.45.camel@eduma=
zet-glaptop3.roam.corp.google.com/
> > > > > > >
> > > > > > > Looking further into it.
> > > > > >
> > > > > > This is what we came up with. Eric, please take a look...
> > > > > >
> > > > > > cheers,
> > > > > > jamal
> > > > > >
> > > > > >
> > > > > > --- a/net/core/dev.c
> > > > > > +++ b/net/core/dev.c
> > > > > > @@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(struct =
sk_buff
> > > > > > *skb, struct Qdisc *q,
> > > > > >         if (unlikely(contended))
> > > > > >                 spin_lock(&q->busylock);
> > > > > >
> > > > > > +       if (dev_recursion_level()) {
> > > > >
> > > > > I am not sure what your intent is, but this seems wrong to me.
> > > > >
> > > >
> > > > There is a deadlock if you reenter the same device which has a qdis=
c
> > > > attached to it more than once.
> > > > Essentially entering __dev_xmit_skb() we grab the root qdisc lock t=
hen
> > > > run some action which requires it to grab the root qdisc lock (agai=
n).
> > > > This is easy to show with mirred (although i am wondering if syzkal=
ler
> > > > may have produced this at some point)..
> > > > $TC qdisc add dev $DEV root handle 1: htb default 1
> > > > $TC filter add dev $DEV protocol ip u32 match ip protocol 1 0xff
> > > > action mirred egress mirror dev $DEV
> > > >
> > > > Above example is essentially egress $DEV-> egress $DEV in both case=
s
> > > > "egress $DEV" grabs the root qdisc lock. You could also create anot=
her
> > > > example with egress($DEV1->$DEV2->back to $DEV1).
> > > >
> > > > > Some valid setup use :
> > > > >
> > > > > A bonding device, with HTB qdisc (or other qdisc)
> > > > >   (This also could be a tunnel device with a qdisc)
> > > > >
> > > > > -> one or multiple physical NIC, wth FQ or other qdisc.
> > > > >
> > > > > Packets would be dropped here when we try to reach the physical d=
evice.
> > > > >
> > > >
> > > > If you have an example handy please send it. I am trying to imagine
> > > > how those would have worked if they have to reenter the root qdisc =
of
> > > > the same dev multiple times..
> > >
> > > Any virtual device like a GRE/SIT/IPIP/... tunnel, add a qdisc on it =
?
> > >
> > > dev_xmit_recursion_inc() is global (per-cpu), it is not per-device.
> > >
> > > A stack of devices A -> B -> C  would elevate the recursion level to
> > > three just fine.
> > >
> > > After your patch, a stack of devices would no longer work.
> > >
> > > It seems mirred correctly injects packets to the top of the stack for
> > > ingress (via netif_rx() / netif_receive_skb()),
> > > but thinks it is okay to call dev_queue_xmit(), regardless of the con=
text ?
> > >
> > > Perhaps safe-guard mirred, instead of adding more code to fast path.
> >
> > I agree not to penalize everybody for a "bad config" like this
> > (surprising syzkaller hasnt caught this). But i dont see how doing the
> > checking within mirred will catch this (we cant detect the A->B->A
> > case).
> > I think you are suggesting a backlog-like queue for mirred? Not far
> > off from that is how it used to work before
> > (https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-glapt=
op3.roam.corp.google.com/)
>
>
> spin_trylock() had to go. There is no way we could keep this.
>

Not asking for it to come back... just pointing out why it worked before.

> > - i.e we had a trylock for the qdisc lock and if it failed we tagged
> > the rx softirq for a reschedule. That in itself is insufficient, we
> > would need a loop check which is per-skb (which we had before
> > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw@str=
len.de/).
> > There are other gotchas there, potentially packet reordering.
>
> If we want to make sure dev_queue_xmit() is called from the top (no
> spinlock held),
> then we need a queue, serviced from another context.
>
> This extra queueing could happen if
> __this_cpu_read(softnet_data.xmit.recursion) > 0
>

I dont see a way to detect softnet_data.xmit.recursion > 0 at mirred
level. The first time we enter it will be 0. The second time we would
deadlock before we hit mirred. I am also worried about packet
reordering avoidance logic code amount needed just to deal with a
buggy configuration. Dropping the packet for this exact config should
be ok.
How about adding a per-qdisc per-cpu recursion counter? Incremented
when we enter the cpu from the top, decremented when we leave. If we
detect __this_cpu_read(qdisc.xmit_recursion) > 0 we drop as per that
patch?

cheers,
jamal
> This can be done from net/sched/act_mirred.c with no additional change
> in net/core/dev.c,
> and no new skb field.

