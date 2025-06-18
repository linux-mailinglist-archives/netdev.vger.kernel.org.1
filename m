Return-Path: <netdev+bounces-199218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6CFADF77B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3BA1BC277A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A420E70F;
	Wed, 18 Jun 2025 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GZLvIsiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472F188006
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277407; cv=none; b=EUaa+krCgqPV+fLg5pXWI66qux9LrbIV5qjwzxMzcPeD3RYdQyYGEFwuVY7RcLg4JtLMJRNV4Q461qHH24LpJ9KOxlp4tITme2JoK53lZrXJdQv+h/r8UuB8O0edKfKw7UoEQhrTIhbmZA29WK7b6FrINNy6TOjFjdS4X6oyICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277407; c=relaxed/simple;
	bh=7N8tB+pzOCngodK3u/++wHF8xexKe2Kd5xcvZOS5UW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibZBYlFdH9wS0nB0Q5aup3bL8kYzyLi8aPZxsryZI6C9OMHCiYtJIqsLtleJTHYBmrCFQ5OjRoPvn0QaXi/cIbVH/GdE06wPoGRu+eUPx3Vy5O3bc4OYRugJChZ2CkSsqrz7qDVH2tjHXaaKZf1a/qdWhm6DLT+EMMS90yJ8q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GZLvIsiO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b271f3ae786so88831a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1750277404; x=1750882204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmjEa+XmSxSAzVfwQ0+hpEbR6BUOuvqiu/A1WrgDHbs=;
        b=GZLvIsiO8e3N+4skNTrHgyTaYkBXN5Mfkmn7jhPTSGaQv2CBVOyA8gjX4EVdrVA8hU
         4tyQEoVMbtF85GVTH5lUhHu1OfgZUC4zTeZL8kC0dkZXErMZ/IgW8+X2xfPnX//mbDwu
         DEEcQ4VAA93ovKAjBL+iNRhwcuPMjy6MaCeYaIH5QS+2qw8WOflI4+Vc2IRbEK+sSEyE
         xU7HccdVtOsL+2hBL4oywUk0pjWP1QnqkH8DC1Gr+JRPOZLy72Vxn+NS+rsGTIV2SoBF
         SZpH1hAR80kRtlqL0rYpyDPi6Zhrv3NIuTL8ZC1GOq59PgzrtntlbTqD1Rhu6/0RcONq
         wBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750277404; x=1750882204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmjEa+XmSxSAzVfwQ0+hpEbR6BUOuvqiu/A1WrgDHbs=;
        b=E9GojhZk5Sflq3U4Tvoyy+hudWMK2kozYPgWSo+8ygEjQAbkEDPn3Zip1QRCOAZzKI
         tHW9/4BoWzA9ZtazTHgf6KRXV/6BjnqcKtcaYML2HYuzKTO5vRMQ83g90M6TSIrjOjL0
         kG02/1bg+XtsGeDbFbLe1ozcG9qZXKem3wpLE0qn7StpFjqMojLnr2CtdjjjicTt+tK3
         pkxsgnbtUnDB5leyq1N4DipeBdPNaF0TdhcgDX1NOQOfPzK3BOPcWGGSrKzmefcY47rH
         11UqV/xZqL44MJKcQMuLNaPmWBSXTWcEA2ysuJskA5OrCkZ/IRn/MRz7TzruqLeXO1kE
         OrPg==
X-Forwarded-Encrypted: i=1; AJvYcCWkyoYnKZfAfOjOvAixo0iaAPySXTcie963r0rmw6kHyOcQw1T4tLel1wNoKZc64ulQBtnjOUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7YDvnOHliuTNSmY7//V88TRzfwwAAH9EKUSrk20HkCKCLC0r
	1WLHeiqFFj+Qd7WyMr0pZOIbyQ0fwOlKd0bnBvvdSVubrdbGQozwPAZD3v4LOHVZlUXI/VKDBju
	tAUoYFXV9D12epEVPGhOi9FTxlVPbW6MzaaecOC8t
X-Gm-Gg: ASbGncvmlv6Sk+ko+6vrI8v+AqJkWSDiA1PhV0KEAFzvo1giJI0O6vVYg7t04roZIKz
	dz6EBFWhHgaSO9+L2Re8+MkgHVK4+FqXjFI0GhxhVGR+jlPn3Dlh6tDFzBJW27cuzoJWMv/2RPu
	2OrTLh+vfAFNulzE6QNHqo+TRyjBpDafSag1CfRYIY7w==
X-Google-Smtp-Source: AGHT+IFvBMg4DM+3V11sC1/JgPTyTXWkniWRH0aAs/rNLewgOUTAN8RU7qtvjo/1kL+NTlKuoI9kUUd1yn3XpuijW2Y=
X-Received: by 2002:a05:6300:6a09:b0:220:658:847 with SMTP id
 adf61e73a8af0-22006581003mr4086415637.14.1750277404428; Wed, 18 Jun 2025
 13:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io>
 <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com>
 <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io>
 <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com>
 <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io>
 <CAM0EoMnd0nZxJW3zpEuBGWTwB3AnJSnj242f9hMpcLdBWdcbfQ@mail.gmail.com>
 <yA-qROHJ2pCMLiRG8Au4YMe_V2R27OhaXkkjkImGzbhdlyHUs5nCkbbJYGkNLM4Rt5812LGXHathpDmqSYTGv1D4YF-zeJdWbCnNIAezEdg=@willsroot.io>
 <CAM0EoM=QxAJS4ZK68mup55O7wQFqkQds-p2Us3R0U-W6FK6krw@mail.gmail.com> <KqiixybBnBLRGzU7hRxP5bpji1w9tvkkNJVawNPK04HV4Sq66HwoXkfvY-zUb-igUkh0WT0BdfbBmjpkA0H-tES79qTMRM9OuFH5HUsYwJs=@willsroot.io>
In-Reply-To: <KqiixybBnBLRGzU7hRxP5bpji1w9tvkkNJVawNPK04HV4Sq66HwoXkfvY-zUb-igUkh0WT0BdfbBmjpkA0H-tES79qTMRM9OuFH5HUsYwJs=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Jun 2025 16:09:53 -0400
X-Gm-Features: AX0GCFvAfKsdgeUN3Ofufbg5ueAw8hr3ZlWQQGRRMbZQDQLtdOa53ydRdYjMeBw
Message-ID: <CAM0EoMmC9nuzEB0ydb5VZh8NRZQcfZ=TmFxQ82CLg1S2Ew8ZWw@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:13=E2=80=AFPM William Liu <will@willsroot.io> wro=
te:
>
>>
> On Monday, June 16th, 2025 at 8:41 PM, Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> >
> >
> > On Thu, Jun 12, 2025 at 11:34=E2=80=AFPM William Liu will@willsroot.io =
wrote:
> >
> > > On Thursday, June 12th, 2025 at 10:08 PM, Jamal Hadi Salim jhs@mojata=
tu.com wrote:
> > >
> > > > Hi William,
> > > > Apologies again for the latency.
> > > >
> > > > On Mon, Jun 9, 2025 at 11:31=E2=80=AFAM William Liu will@willsroot.=
io wrote:
> > > >
> > > > > On Monday, June 9th, 2025 at 12:27 PM, Jamal Hadi Salim jhs@mojat=
atu.com wrote:
> > > >
> > > > > > I didnt finish my thought on that: I meant just dont allow a se=
cond
> > > > > > netem to be added to a specific tree if one already exists. Don=
t
> > > > > > bother checking for duplication.
> > > > > >
> > > > > > cheers,
> > > > > > jamal
> > > > > >
> > > > > > > > [1] see "loopy fun" in https://lwn.net/Articles/719297/
> > > > >
> > > > > Hi Jamal,
> > > > >
> > > > > I came up with the following fix last night to disallow adding a =
netem qdisc if one of its ancestral qdiscs is a netem. It's just a draft -I=
 will clean it up, move qdisc_match_from_root to sch_generic, add test case=
s, and submit a formal patchset for review if it looks good to you. Please =
let us know if you catch any edge cases or correctness issues we might be m=
issing.
> > > >
> > > > It is a reasonable approach for fixing the obvious case you are
> > > > facing. But I am still concerned.
> > > > Potentially if you had another netem on a different branch of the t=
ree
> > > > it may still be problematic.
> > > > Consider a prio qdisc with 3 bands each with a netem child with dup=
lication on.
> > > > Your solution will solve it for each branch if one tries to add a
> > > > netem child to any of these netems.
> > > >
> > > > But consider you have a filter on the root qdisc or some intermedia=
te
> > > > qdisc and an associated action that changes skb->prio; when it hits
> > > >
> > > > netem and gets duplicated then when it goes back to the root it may=
 be
> > > > classified by prio to a different netem which will duplicate and on
> > > > and on..
> > > > BTW: I gave the example of skb->prio but this could be skb->mark.
> > >
> > > Ah, good catch. I attached the modified patch below then.
> > >
> > > > Perhaps we should only allow one netem per tree or allow more but
> > > > check for duplication and only allow one per tree...
> > >
> > > I believe we have to keep it at one netem per tree. The OOM loop can =
still trigger if a netem without duplication has a netem child with duplica=
tion. Consider the following setup:
> > >
> > > tc qdisc add dev lo root handle 1: netem limit 1
> > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate=
 100% delay 1us reorder 100%
> >
> >
> > I didnt explain it clearly - I meant if you have a netem that has
> > duplication then dont allow another netem within the tree. Your patch
> > is in the right direction but does not check for duplication.
> >
> > > The first netem will store everything in the tfifo queue on netem_enq=
ueue. Since netem_dequeue calls enqueue on the child, and the child will du=
plicate every packet back to the root, the first netem's netem_dequeue will=
 never exit the tfifo_loop.
> > >
> > > Best,
> > > William
> > >
> > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > index fdd79d3ccd8c..4db5df202403 100644
> > > --- a/net/sched/sch_netem.c
> > > +++ b/net/sched/sch_netem.c
> > > @@ -1085,6 +1085,36 @@ static int netem_change(struct Qdisc *sch, str=
uct nlattr *opt,
> > > return ret;
> > > }
> > >
> > > +static const struct Qdisc_class_ops netem_class_ops;
> > > +
> > > +static bool has_netem_in_tree(struct Qdisc *sch) {
> > > + struct Qdisc *root, *q;
> > > + unsigned int i;
> > > + bool ret =3D false;
> > > +
> > > + sch_tree_lock(sch);
> > > + root =3D qdisc_root_sleeping(sch);
> >
> >
> > Hrm. starting with qdisc_root_sleeping() seems quarky. Take a look at
> > dump() - and dig into something (off top of my head) like
> > hash_for_each(qdisc_dev(root)->qdisc_hash, b, q, hash)
> >
>
> What is the issue here? My understanding is that the hashmap does not hol=
d the root - sch_api.c shows edge cases for the root node when adding and d=
eleting from the hashmap).
>

True. Ok, so no objection to using qdisc_root_sleeping() - I was
initially comparing it to what you would need to do in dump().
So more below in that relation (take  a look at dump):

+static const struct Qdisc_class_ops netem_class_ops;
+
+static bool has_netem_in_tree(struct Qdisc *sch) {
+       struct Qdisc *root, *q;
+       unsigned int i;
+       bool ret =3D false;
+
+       sch_tree_lock(sch);

You are already have rtnl being held by this point. No need to hold this lo=
ck.

+       root =3D qdisc_root_sleeping(sch);
+
+       if (root->ops->cl_ops =3D=3D &netem_class_ops) {
+               ret =3D true;
+               goto unlock;
+       }
+


You dont need rcu here - again look at dump() hash_for_each() is the
correct thing to do.

+       hash_for_each_rcu(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+               if (q->ops->cl_ops =3D=3D &netem_class_ops) {
+                       ret =3D true;
+                       goto unlock;
+               }
+       }
+

And therefore unlock etc becomes unnecessary.

cheers,
jamal

+unlock:
+       if (ret)
+               pr_warn("Cannot have multiple netems in tree\n");
+
+       sch_tree_unlock(sch);
+       return ret;
+}


> > > +
> > > + if (root->ops->cl_ops =3D=3D &netem_class_ops) {
> > > + ret =3D true;
> > > + goto unlock;
> > > + }
> > > +
> > > + hash_for_each_rcu(qdisc_dev(root)->qdisc_hash, i, q, hash) {
> > > + if (q->ops->cl_ops =3D=3D &netem_class_ops) {
> > > + ret =3D true;
> > > + goto unlock;
> > > + }
> > > + }
> > > +
> > > +unlock:
> > > + if (ret)
> > > + pr_warn("Cannot have multiple netems in tree\n");
> >
> >
> > No point to the pr_warn()
> >
> > > +
> > > + sch_tree_unlock(sch);
> > > + return ret;
> > > +}
> > > +
> > > static int netem_init(struct Qdisc *sch, struct nlattr *opt,
> > > struct netlink_ext_ack *extack)
> > > {
> > > @@ -1093,6 +1123,9 @@ static int netem_init(struct Qdisc *sch, struct=
 nlattr *opt,
> > >
> > > qdisc_watchdog_init(&q->watchdog, sch);
> > >
> > > + if (has_netem_in_tree(sch))
> > > + return -EINVAL;
> >
> >
> > set ext_ack to contain the string you had earlier ("Cannot have
> > multiple netems in tree") and user space will be able to see it.
> >
> > It will be easy to check the existing qdisc for netem_sched_data->dupli=
cate
> >
> > Also, please dont forget to run tdc tests and contribute one or more
> > testcase that captures the essence of what you are pushing here.
> >
> > cheers,
> > jamal
>
> Best,
> William

