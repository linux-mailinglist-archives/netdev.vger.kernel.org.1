Return-Path: <netdev+bounces-198258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C85ADBB54
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D9A1760D0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FBD20F088;
	Mon, 16 Jun 2025 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Ea8s5MhM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEE1DF24F
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106482; cv=none; b=TvREimks5iiNRnvmgmjt0wCSlGuU3mHeSLvJqs+EJ2brcVbsW3McfsJNpC06i/uSuxFf+65R71oOxoYp70pHCHRkH7ZM+5AbikOI/rvrY3o0jA192Z691H9ZK687SnMJiHWNUpuyv0dATOycyWne+NmaGEfXZqV7s95gI6aal+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106482; c=relaxed/simple;
	bh=WBK4jVZAfIJE9JPJ+wwLXAr24cVlEWiGniL+TW+izz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk8neDZPO/P6K9Za43hDdjpy0srRJhuozpilLSCQoztUp5tR4YLudvB6BsM8SZ8cJSdDzMh/OJU4Y7SlFH/BnDcrBVkbEYUzJTHUw7IO7+ubyPNLuCRYT+kK0NoSFjOaRcHZ1LUAp6XIF2KRfDsQGNAslkmKYyHzvS+uuH8QSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Ea8s5MhM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74849e33349so4328421b3a.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1750106480; x=1750711280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CQV9saWq/5nZZ9Xga3PC3J1oLbOOE7/ttYEb2kqOQE=;
        b=Ea8s5MhMZt2qAX8btH0JM4Kb/VUKEzjTnIZg3K0TtQRrtqTzvWhgS7PX+uGKYWVo5x
         CkNJJvhMYa373bgBlXm0MZ7mJD/D7uEsaNcC12ffzt27ICQmMa4I3nn1TpcJ08e4IbZj
         W5mIv2h2tFF7m25E1e1kgRbSHty/7Z846ZdmF19HBf5dIGSXfp9Yta01yp81O2TxarKU
         2037+at7kCDddg00DcBFjssA8VWSYvVh/KCY9zJHlfmI1xb/qEPQdkUtNe3WQWIJkxhQ
         pS6caqUROfnUBQgeianJWPRraYZ+/cILtha5gxoWYesaI3wLQU+5DHUgNMqzSDzA2PBp
         nI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750106480; x=1750711280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CQV9saWq/5nZZ9Xga3PC3J1oLbOOE7/ttYEb2kqOQE=;
        b=q1M46rKrBeDb6yVpNJrR6mD4S7arJncQPqh6AFm5gQdBDe4rwzvHutxPKhCJs0I7w1
         xx5BFcxD57+T+M2u0pwaZY+NxhBk3b/BWE8TntmAkde4N6fwuHsEBTygv0d8sLdb3YH8
         537ccwoNXTFhsfMqsKbEt/juQA5jtN+DQgYkRIa8VWZRIBY52rvL45AsEVuMeonn5LHB
         x9fb9VWAPFuncRdLupj745cB2UFVIkSWCG8CWmFvsv4lpHEdIsCHb6OhYWUp2qbwBKto
         EGtm/R+Ybz68/nb9D8gw9J23S79UCE6ZCBYoe2gMer29PNMsR4hX3YzJh+mV20RqUnXy
         vTjA==
X-Forwarded-Encrypted: i=1; AJvYcCUDpVIUXkaeVqEno72NJfWPP0PxE/z3C31/miJ9U3pwShTdAzlmsBfOu3Ji8kHdl4pQGibcg0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8165FAb7rvPBKXC/PNdcBB4m3WraAFoOnfcjOmHDwmC1+uyXz
	uiqeakKhVcgDrQIlm8iJh8dYPSst9EBZkvcyIiHBnEdbEtrMuuYhuLRvbgd6IFHbXgE/rqeOHmT
	/sou6FV0qgRxDVwP0UrSIzd/A04E3KuXZoJgB3BxC
X-Gm-Gg: ASbGncsL+7ZMYv2n3mdHhBqUeabHC9N82W3LnOmHmuJvt+MvTioK4eH3PP61RJ/eg7Q
	D0X+BUmVo9BZKGijKvvuKKZGjcCs/Sfav1Opl7NoWgwOzgwiIVTEq3M39CZUMSHMf99RNKLnEkv
	h2LWO3RcMEFbVBx5P0QBfOgpA67WjI+9yl3Eg/5qrFEw==
X-Google-Smtp-Source: AGHT+IFPX/4SrnGX0McGyEO7okXweb3IWH5fwnD/1vMqhTxDDIpgenRS0ZhJ4AeN8WP7cq9ug6gmnfU6+b7sPSqpUj8=
X-Received: by 2002:a05:6a00:a85:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-7489cffbb1emr15694805b3a.12.1750106480230; Mon, 16 Jun 2025
 13:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com>
 <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com>
 <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io>
 <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com>
 <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io>
 <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com>
 <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io>
 <CAM0EoMnd0nZxJW3zpEuBGWTwB3AnJSnj242f9hMpcLdBWdcbfQ@mail.gmail.com> <yA-qROHJ2pCMLiRG8Au4YMe_V2R27OhaXkkjkImGzbhdlyHUs5nCkbbJYGkNLM4Rt5812LGXHathpDmqSYTGv1D4YF-zeJdWbCnNIAezEdg=@willsroot.io>
In-Reply-To: <yA-qROHJ2pCMLiRG8Au4YMe_V2R27OhaXkkjkImGzbhdlyHUs5nCkbbJYGkNLM4Rt5812LGXHathpDmqSYTGv1D4YF-zeJdWbCnNIAezEdg=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Jun 2025 16:41:09 -0400
X-Gm-Features: AX0GCFuRmjEvcV5YmOZ0xiVaNcrdPHoMHcS_jV9H13pOVPn5IlnxVdklqLdYsbo
Message-ID: <CAM0EoM=QxAJS4ZK68mup55O7wQFqkQds-p2Us3R0U-W6FK6krw@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 11:34=E2=80=AFPM William Liu <will@willsroot.io> wr=
ote:
>
> On Thursday, June 12th, 2025 at 10:08 PM, Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
>
> >
> >
> > Hi William,
> > Apologies again for the latency.
> >
> > On Mon, Jun 9, 2025 at 11:31=E2=80=AFAM William Liu will@willsroot.io w=
rote:
> >
> > > On Monday, June 9th, 2025 at 12:27 PM, Jamal Hadi Salim jhs@mojatatu.=
com wrote:
> >
> > > > I didnt finish my thought on that: I meant just dont allow a second
> > > > netem to be added to a specific tree if one already exists. Dont
> > > > bother checking for duplication.
> > > >
> > > > cheers,
> > > > jamal
> > > >
> > > > > > [1] see "loopy fun" in https://lwn.net/Articles/719297/
> > >
> > > Hi Jamal,
> > >
> > > I came up with the following fix last night to disallow adding a nete=
m qdisc if one of its ancestral qdiscs is a netem. It's just a draft -I wil=
l clean it up, move qdisc_match_from_root to sch_generic, add test cases, a=
nd submit a formal patchset for review if it looks good to you. Please let =
us know if you catch any edge cases or correctness issues we might be missi=
ng.
> >
> >
> > It is a reasonable approach for fixing the obvious case you are
> > facing. But I am still concerned.
> > Potentially if you had another netem on a different branch of the tree
> > it may still be problematic.
> > Consider a prio qdisc with 3 bands each with a netem child with duplica=
tion on.
> > Your solution will solve it for each branch if one tries to add a
> > netem child to any of these netems.
> >
> > But consider you have a filter on the root qdisc or some intermediate
> > qdisc and an associated action that changes skb->prio; when it hits
> >
> > netem and gets duplicated then when it goes back to the root it may be
> > classified by prio to a different netem which will duplicate and on
> > and on..
> > BTW: I gave the example of skb->prio but this could be skb->mark.
> >
>
> Ah, good catch. I attached the modified patch below then.
>
> >
> > Perhaps we should only allow one netem per tree or allow more but
> > check for duplication and only allow one per tree...
> >
>
> I believe we have to keep it at one netem per tree. The OOM loop can stil=
l trigger if a netem without duplication has a netem child with duplication=
. Consider the following setup:
>
> tc qdisc add dev lo root handle 1: netem limit 1
> tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100=
% delay 1us reorder 100%
>

I didnt explain it clearly - I meant if you have a netem that has
duplication then dont allow another netem within the tree. Your patch
is in the right direction but does not check for duplication.

> The first netem will store everything in the tfifo queue on netem_enqueue=
. Since netem_dequeue calls enqueue on the child, and the child will duplic=
ate every packet back to the root, the first netem's netem_dequeue will nev=
er exit the tfifo_loop.
>
> Best,
> William
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..4db5df202403 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -1085,6 +1085,36 @@ static int netem_change(struct Qdisc *sch, struct =
nlattr *opt,
>         return ret;
>  }
>
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static bool has_netem_in_tree(struct Qdisc *sch) {
> +       struct Qdisc *root, *q;
> +       unsigned int i;
> +       bool ret =3D false;
> +
> +       sch_tree_lock(sch);
> +       root =3D qdisc_root_sleeping(sch);

Hrm. starting with qdisc_root_sleeping() seems quarky. Take a look at
dump() - and dig into something (off top of my head) like
hash_for_each(qdisc_dev(root)->qdisc_hash, b, q, hash)

> +
> +       if (root->ops->cl_ops =3D=3D &netem_class_ops) {
> +               ret =3D true;
> +               goto unlock;
> +       }
> +
> +       hash_for_each_rcu(qdisc_dev(root)->qdisc_hash, i, q, hash) {
> +               if (q->ops->cl_ops =3D=3D &netem_class_ops) {
> +                       ret =3D true;
> +                       goto unlock;
> +               }
> +       }
> +
> +unlock:
> +       if (ret)
> +               pr_warn("Cannot have multiple netems in tree\n");

No point to the pr_warn()

> +
> +       sch_tree_unlock(sch);
> +       return ret;
> +}
> +
>  static int netem_init(struct Qdisc *sch, struct nlattr *opt,
>                       struct netlink_ext_ack *extack)
>  {
> @@ -1093,6 +1123,9 @@ static int netem_init(struct Qdisc *sch, struct nla=
ttr *opt,
>
>         qdisc_watchdog_init(&q->watchdog, sch);
>
> +       if (has_netem_in_tree(sch))
> +               return -EINVAL;

set ext_ack to contain the string you had earlier ("Cannot have
multiple netems in tree") and user space will be able to see it.

It will be easy to check the existing qdisc for netem_sched_data->duplicate
Also, please dont forget to run tdc tests and contribute one or more
testcase that captures the essence of what you are pushing here.

cheers,
jamal

