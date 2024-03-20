Return-Path: <netdev+bounces-80881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996BF8816D0
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 18:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA84B221FC
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6C6A8B2;
	Wed, 20 Mar 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WHdBeUjO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F66A35F
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957030; cv=none; b=kRSxDwCtjJe8G9NCul8MgIjJz2cY5rSAXGaK33MAdzkjSbTS/jSrk8FWxiCt8dluz1+Z5aOg9TTB/jE+kp9YAwqRCXD3/rnofSJz1YGFc3uOJtesuu18J1Xxrp/xzfVEmKEJEvzyb0h8S92BVS1kvbQJ7yieGg5JA9eAacjeN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957030; c=relaxed/simple;
	bh=UjXWUvJopG5q754nqPt8w4RVgjmeWVIEHL64qfNUAdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWb37CQRQMIZfDa7e82YbQ3+j8+1dX7I8eH8ltkFfVM4WOi+3FuvCWGrC7/KCxpEi3wyjENIMcMe78S9n4RxXOrGEdHs/sIk40BbRAbp0gRpTc8/DjH5sMaDv0XZWYFa9QACR36YM11Jh/QbUqW8yQSulYMSGWyPTXeilIvpYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=WHdBeUjO; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso67701276.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710957027; x=1711561827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6ISNMMDzXZ+r6NjIexQ9uVO/oDKNpvVF49eIPoa25o=;
        b=WHdBeUjO+V0Kw2SXroWEufti8BwyPIsGFlpHa6XffsSpt6HXx0GdGyRMKb4ngwoyPh
         6/JnoU/G0HZFaHzK95CsoIbUQi8Fw2ITByaGT57C6vIjoE/oflZ7bwXjq8tKoPJbQcwK
         lU5FPIXakbBEq6cwNoSYBH21qLyS/yg/ee/WTmPlFJylRwQAaKCHdC72duiFLCsgpJML
         /AkqS0RYnfOsKs8kDqKKaAV5Cd6vV8wquKgKBreaqjTElyskI/7biGXt5MlZLgFQRl2D
         Z7UY2O9nCk2oA+HViGUlYfysWaYPhpTHWe7YVpoeiIrcH2vUGdmB9mXuaPAjjGgH9oiM
         zDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957027; x=1711561827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6ISNMMDzXZ+r6NjIexQ9uVO/oDKNpvVF49eIPoa25o=;
        b=BKqF77IklK1Tqt6eiNHtDXgTSHNPJ+HDDko7BWbbGl2msN5Zrf5GRni0Dd9HyzUrOe
         mGiOoPzBRMzC7hXqmW8tLsQA1V1rYnc2lXzXX9GBfMNl75nOh9Oc8qGg08BHRf+5tH0l
         91UxOBqMKzMj41mjKDmBm4lkaaaRkyl/H4BbKe88Bh428d0zyZxL+F4NmHq9rxu1VtE3
         dQXy9sciJ7DesXKry3LbGH5hsyr0A5N1P2Z23tX2Q3v4BZr8R+AhqHLYt1weIJQ/y2Vv
         gh0ZbWNLNCsJxs4KFFX08XdcVIqFyYIlQ3sFo0aeJG1cHhvNHG8N2cE8jnlPzLYlFRd8
         D5KA==
X-Forwarded-Encrypted: i=1; AJvYcCU5V5Eo2HXM45x2q6oNREferxcdK7bvQ/9RYQ7ziCwRTjjoFV7uiLch9dv5AmBZzU65jQ0dTaZm3/lwI5fRnjaFtWMG00Rm
X-Gm-Message-State: AOJu0Yz2hf/Kj4v6n5wWnvsNy9hRjlkalHwcilwQKPeYSVSztq7Vdw2i
	MarX11OOQgT+gpM5eN9L5hu/kAOo/tOGWTcFSnuC3FRCKFAeCMkJGr+dZmb980ORrh7wYoLFxyL
	kzn5QqE61B86UZTKPFPmMDOE9ssnBR+fSkTyy3C5zepdr5y8/rA==
X-Google-Smtp-Source: AGHT+IEBoVHlwV2qyuagz/Vv9wCMqhRYrkAgd9xa9VleNQRIbAioTRv4gxZd6sEwjrFr2x1w0LwjEJfOoaqWol2UNP0=
X-Received: by 2002:a25:844b:0:b0:dcd:741f:490a with SMTP id
 r11-20020a25844b000000b00dcd741f490amr5796794ybm.7.1710957026975; Wed, 20 Mar
 2024 10:50:26 -0700 (PDT)
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
 <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com>
 <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
 <CANn89iLjK3vf-yHvKdY=wvOdEeWubB0jt2=5d-1m7dkTYBwBOg@mail.gmail.com> <CAM0EoMmYiwDPEqo6TrZ9dWbVdv2Ry3Yz8W-p9u+s6=ZAtZOWhw@mail.gmail.com>
In-Reply-To: <CAM0EoMmYiwDPEqo6TrZ9dWbVdv2Ry3Yz8W-p9u+s6=ZAtZOWhw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Mar 2024 13:50:15 -0400
Message-ID: <CAM0EoMnddJgPYR75qTfxAdKsN3-bRuqXrDMxuwAa3y95iahWFQ@mail.gmail.com>
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

On Wed, Mar 20, 2024 at 1:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Mar 20, 2024 at 12:58=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Mar 19, 2024 at 9:54=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Tue, Mar 19, 2024 at 5:38=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 11:05=E2=80=AFPM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > On Mon, Mar 18, 2024 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 18, 2024 at 6:36=E2=80=AFPM Jamal Hadi Salim <jhs@m=
ojatatu.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 18, 2024 at 11:46=E2=80=AFAM Eric Dumazet <edumaz=
et@google.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Mar 18, 2024 at 3:27=E2=80=AFPM Jamal Hadi Salim <j=
hs@mojatatu.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim=
 <jhs@mojatatu.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Sali=
m <jhs@mojatatu.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai =
<renmingshuai@huawei.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > As we all know the mirred action is used to mirrori=
ng or redirecting the
> > > > > > > > > > > > packet it receives. Howerver, add mirred action to =
a filter attached to
> > > > > > > > > > > > a egress qdisc might cause a deadlock. To reproduce=
 the problem, perform
> > > > > > > > > > > > the following steps:
> > > > > > > > > > > > (1)tc qdisc add dev eth0 root handle 1: htb default=
 30 \n
> > > > > > > > > > > > (2)tc filter add dev eth2 protocol ip prio 2 flower=
 verbose \
> > > > > > > > > > > >      action police rate 100mbit burst 12m conform-e=
xceed jump 1 \
> > > > > > > > > > > >      / pipe mirred egress redirect dev eth2 action =
drop
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I think you meant both to be the same device eth0 or =
eth2?
> > > > > > > > > > >
> > > > > > > > > > > > The stack is show as below:
> > > > > > > > > > > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > > > > > > > > > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > > > > > > > > > > [28848.884851]  ? 0xffffffffc031906a
> > > > > > > > > > > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mir=
red]
> > > > > > > > > > > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > > > > > > > > > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower=
]
> > > > > > > > > > > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > > > > > > > > > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > > > > > > > > > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_ta=
bles]
> > > > > > > > > > > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_table=
s]
> > > > > > > > > > > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > > > > > > > > > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_c=
onntrack]
> > > > > > > > > > > > [28848.890293]  ? do_select+0x637/0x870
> > > > > > > > > > > > [28848.890735]  tcf_classify+0x52/0xf0
> > > > > > > > > > > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > > > > > > > > > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > > > > > > > > > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > > > > > > > > > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > > > > > > > > > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > > > > > > > > > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > > > > > > > > > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > > > > > > > > > > >
> > > > > > > > > > > > In this case, the process has hold the qdisc spin l=
ock in __dev_queue_xmit
> > > > > > > > > > > > before the egress packets are mirred, and it will a=
ttempt to obtain the
> > > > > > > > > > > > spin lock again after packets are mirred, which cau=
se a deadlock.
> > > > > > > > > > > >
> > > > > > > > > > > > Fix the issue by forbidding assigning mirred action=
 to a filter attached
> > > > > > > > > > > > to the egress.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.c=
om>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  net/sched/act_mirred.c                        |  4=
 +++
> > > > > > > > > > > >  .../tc-testing/tc-tests/actions/mirred.json   | 32=
 +++++++++++++++++++
> > > > > > > > > > > >  2 files changed, 36 insertions(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act=
_mirred.c
> > > > > > > > > > > > index 5b3814365924..fc96705285fb 100644
> > > > > > > > > > > > --- a/net/sched/act_mirred.c
> > > > > > > > > > > > +++ b/net/sched/act_mirred.c
> > > > > > > > > > > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(str=
uct net *net, struct nlattr *nla,
> > > > > > > > > > > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred =
requires attributes to be passed");
> > > > > > > > > > > >                 return -EINVAL;
> > > > > > > > > > > >         }
> > > > > > > > > > > > +       if (tp->chain->block->q->parent !=3D TC_H_I=
NGRESS) {
> > > > > > > > > > > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred =
can only be assigned to the filter attached to ingress");
> > > > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > > > +       }
> > > > > > > > > > >
> > > > > > > > > > > Sorry, this is too restrictive as Jiri said. We'll tr=
y to reproduce. I
> > > > > > > > > > > am almost certain this used to work in the old days.
> > > > > > > > > >
> > > > > > > > > > Ok, i looked at old notes - it did work at "some point"=
 pre-tdc.
> > > > > > > > > > Conclusion is things broke around this time frame:
> > > > > > > > > > https://lore.kernel.org/netdev/1431679850-31896-1-git-s=
end-email-fw@strlen.de/
> > > > > > > > > > https://lore.kernel.org/netdev/1465095748.2968.45.camel=
@edumazet-glaptop3.roam.corp.google.com/
> > > > > > > > > >
> > > > > > > > > > Looking further into it.
> > > > > > > > >
> > > > > > > > > This is what we came up with. Eric, please take a look...
> > > > > > > > >
> > > > > > > > > cheers,
> > > > > > > > > jamal
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --- a/net/core/dev.c
> > > > > > > > > +++ b/net/core/dev.c
> > > > > > > > > @@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(s=
truct sk_buff
> > > > > > > > > *skb, struct Qdisc *q,
> > > > > > > > >         if (unlikely(contended))
> > > > > > > > >                 spin_lock(&q->busylock);
> > > > > > > > >
> > > > > > > > > +       if (dev_recursion_level()) {
> > > > > > > >
> > > > > > > > I am not sure what your intent is, but this seems wrong to =
me.
> > > > > > > >
> > > > > > >
> > > > > > > There is a deadlock if you reenter the same device which has =
a qdisc
> > > > > > > attached to it more than once.
> > > > > > > Essentially entering __dev_xmit_skb() we grab the root qdisc =
lock then
> > > > > > > run some action which requires it to grab the root qdisc lock=
 (again).
> > > > > > > This is easy to show with mirred (although i am wondering if =
syzkaller
> > > > > > > may have produced this at some point)..
> > > > > > > $TC qdisc add dev $DEV root handle 1: htb default 1
> > > > > > > $TC filter add dev $DEV protocol ip u32 match ip protocol 1 0=
xff
> > > > > > > action mirred egress mirror dev $DEV
> > > > > > >
> > > > > > > Above example is essentially egress $DEV-> egress $DEV in bot=
h cases
> > > > > > > "egress $DEV" grabs the root qdisc lock. You could also creat=
e another
> > > > > > > example with egress($DEV1->$DEV2->back to $DEV1).
> > > > > > >
> > > > > > > > Some valid setup use :
> > > > > > > >
> > > > > > > > A bonding device, with HTB qdisc (or other qdisc)
> > > > > > > >   (This also could be a tunnel device with a qdisc)
> > > > > > > >
> > > > > > > > -> one or multiple physical NIC, wth FQ or other qdisc.
> > > > > > > >
> > > > > > > > Packets would be dropped here when we try to reach the phys=
ical device.
> > > > > > > >
> > > > > > >
> > > > > > > If you have an example handy please send it. I am trying to i=
magine
> > > > > > > how those would have worked if they have to reenter the root =
qdisc of
> > > > > > > the same dev multiple times..
> > > > > >
> > > > > > Any virtual device like a GRE/SIT/IPIP/... tunnel, add a qdisc =
on it ?
> > > > > >
> > > > > > dev_xmit_recursion_inc() is global (per-cpu), it is not per-dev=
ice.
> > > > > >
> > > > > > A stack of devices A -> B -> C  would elevate the recursion lev=
el to
> > > > > > three just fine.
> > > > > >
> > > > > > After your patch, a stack of devices would no longer work.
> > > > > >
> > > > > > It seems mirred correctly injects packets to the top of the sta=
ck for
> > > > > > ingress (via netif_rx() / netif_receive_skb()),
> > > > > > but thinks it is okay to call dev_queue_xmit(), regardless of t=
he context ?
> > > > > >
> > > > > > Perhaps safe-guard mirred, instead of adding more code to fast =
path.
> > > > >
> > > > > I agree not to penalize everybody for a "bad config" like this
> > > > > (surprising syzkaller hasnt caught this). But i dont see how doin=
g the
> > > > > checking within mirred will catch this (we cant detect the A->B->=
A
> > > > > case).
> > > > > I think you are suggesting a backlog-like queue for mirred? Not f=
ar
> > > > > off from that is how it used to work before
> > > > > (https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet=
-glaptop3.roam.corp.google.com/)
> > > >
> > > >
> > > > spin_trylock() had to go. There is no way we could keep this.
> > > >
> > >
> > > Not asking for it to come back... just pointing out why it worked bef=
ore.
> > >
> > > > > - i.e we had a trylock for the qdisc lock and if it failed we tag=
ged
> > > > > the rx softirq for a reschedule. That in itself is insufficient, =
we
> > > > > would need a loop check which is per-skb (which we had before
> > > > > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-=
fw@strlen.de/).
> > > > > There are other gotchas there, potentially packet reordering.
> > > >
> > > > If we want to make sure dev_queue_xmit() is called from the top (no
> > > > spinlock held),
> > > > then we need a queue, serviced from another context.
> > > >
> > > > This extra queueing could happen if
> > > > __this_cpu_read(softnet_data.xmit.recursion) > 0
> > > >
> > >
> > > I dont see a way to detect softnet_data.xmit.recursion > 0 at mirred
> > > level. The first time we enter it will be 0.
> >
> > Then it is fine, no qdisc spinlock is held at this point.
> >
> >  The second time we would
> > > deadlock before we hit mirred.
> >
> > This is not how I see the trace.
> >
> > Mirred would detect that and either drop or queue the packet to a work
> > queue or something.
> >
> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index 5b38143659249e66718348e0ec4ed3c7bc21c13d..a2c53e200629a17130f3824=
6ab3cdb8c89c6d30e
> > 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -237,9 +237,15 @@ tcf_mirred_forward(bool at_ingress, bool
> > want_ingress, struct sk_buff *skb)
> >  {
> >         int err;
> >
> > -       if (!want_ingress)
> > +       if (!want_ingress) {
> > +               if (__this_cpu_read(softnet_data.xmit.recursion) > 0) {
> > +                       // TODO increment a drop counter perhaps ?
> > +                       kfree_skb(skb);
> > +                       return -EINVAL;
> > +               }
> > +
> >                 err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
> > -       else if (!at_ingress)
> > +       } else if (!at_ingress)
> >                 err =3D netif_rx(skb);
> >         else
> >                 err =3D netif_receive_skb(skb);
>
>
> I doubt this will work - who increments softnet_data.xmit.recursion?
> We enter __dev_xmit_skb (grab lock) --> qdisc_enq-->classify-->mirred
> (recursion is zero) which redirects entering back into  __dev_xmit_skb
> again and deadlocks trying to grab lock.
>  Maybe something is not clear to me, trying your suggestion...
>

jhs@mojaone:~$
[   82.890330] __this_cpu_read(softnet_data.xmit.recursion) 0 in
tcf_mirred_forward
[   82.890906]
[   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   82.890906] WARNING: possible recursive locking detected
[   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G        W
[   82.890906] --------------------------------------------
[   82.890906] ping/418 is trying to acquire lock:
[   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1778/0x3550
[   82.890906]
[   82.890906] but task is already holding lock:
[   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1778/0x3550
[   82.890906]
[   82.890906] other info that might help us debug this:
[   82.890906]  Possible unsafe locking scenario:
[   82.890906]
[   82.890906]        CPU0
[   82.890906]        ----
[   82.890906]   lock(&sch->q.lock);
[   82.890906]   lock(&sch->q.lock);
[   82.890906]
[   82.890906]  *** DEADLOCK ***
[   82.890906]
[..... other info removed for brevity....]

Needs more thinking...
A fool proof solution is to add the per-recursion counter to be per
netdevice but that maybe considered blasphemy? ;->

cheers,
jamal

> cheers,
> jamal

