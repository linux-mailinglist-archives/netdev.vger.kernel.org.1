Return-Path: <netdev+bounces-197241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78046AD7E38
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC411894C92
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D72DCC15;
	Thu, 12 Jun 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YmtMDnFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D3278E71
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766110; cv=none; b=OQTk+YuSKoSZvDhLe/WVrhYj0hLvCEQEgh01Cy9IJoL4yh+w4Sh446wsP6wsmUZZUG702/OUv2KHCGpYZmzfE2K6gcBbmX80FPWQpsIHDvYpqsPUeOA0U5vdqlgFtNYrvbbSxpJfuCqGVT7MH+e+UlLH95DQfYT+GidsMlsAVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766110; c=relaxed/simple;
	bh=AJppBdUW1EmRzfz3SaxyHKmmOgDstCi9I1qN8aiLox8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBMvgKWxwKNkWJbzm5P1LIr/GZR4jA0qtxjY35TDhw4G/NrcaKRo8nwPA+o+Nk9nZGV+4RIDSgrkDF6pfKpI45cMMVfVCo6BHXxavZTOKCDqkGnCiukRguJEuuUPmO4KaQkbC1VO6YlBSWKmXGGd/BerJMddvsZpyjT3vLytpEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YmtMDnFz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1107888a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1749766108; x=1750370908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yj5DhwkUbwt038eRhDuu3kMYxemvI/vqksmdDwwOVjA=;
        b=YmtMDnFzJQu7MCyVCa5SCnd+wpm7OvLFD5YMyABfGg7TfUqbNQV4RZoJeC6jTdazPY
         NIE2xvVcSoj8MJhjgZBBp3Rgw4H/LSRFXjNfQvyGQOmE6etHomVe2J0qG/hBx8GBQv3u
         /taerdhY7NDMINvjlTF3TmBn7KWVlKpKO+juaQKWLu+Yunp8G08sOWEpcs4UVwf/c+Ma
         qcLFkt4A33WQ5Rhau9Z8sxdg34EuKjRpjEwF8UHUw4q1/d4QevKGD/xtRA3VXAujmLxX
         OeLS7HsbPNII9xNuDOBR7iSQLyY7v9T8IJjLR90v7q4MOqmPqlrnqJYmmnZqVODMXTsY
         UqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749766108; x=1750370908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yj5DhwkUbwt038eRhDuu3kMYxemvI/vqksmdDwwOVjA=;
        b=NiQkG1Q3y6eKfSqRFwxjn/vI8TlT+M2ORU/DVo+ErR0cjGBYmEsDwhD7Lzv6IUXl/c
         JGXclDp0JvHYEtjQSzbdLyzzbbVhxbtvwNfHXU2NZJWp8P840Ve1vu42mfo552JBzdMU
         lok1+xSvDevnRsUE9xs/aVLlOkiurAOtXPYuLAYLfih3e+N+RNuU4inYlVNllbjlNZ8K
         2//JyIElFjvwXK7wuzL6BtX1wIXO9Do/JhWJqJls/XuyPFmjJPf/j+qLUdCsCpN2Ug9c
         2bi5w/xztwgRtiEcFNULwEpb8OXT2h/TIkSt5xu26FaIrwB390oj3oDrlOZQjCj7n9Tq
         F+rA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5Ek29aoUKlc+LZFjeW+9kgrD1QEdGOgfZPPLaR4eTUIbiWjVuHJvwsTOHkEaO0DP4m6Eu68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9JkkqXbVc8zItQ2m8ibIZQ/TYAdg3UvU/uPAWxdUTv8np/y3V
	MBsbqR8jz4uGpCWLxugKcTdTI7/1hjw4W3u42ImUPeMIkeg3yqwVOnDE+JzYyL5JO79f9GJT23D
	r2VAS0wF0MvcVU+QVYA3YZx4i0rncZqUJpr/B8IuZ
X-Gm-Gg: ASbGnctMv6yzAMLFgdRLd2NPrJ15evyg0Z8bo7ImKGCQ/9iiBuD5mypxkNE5J9YCchK
	txGJx5p/ReLObr8eSRdH0TczTF9zfY+3HM+XpYprme3+ncwT161JRBWS87Zg5/USjP4o6WU7jqA
	PfikW6h1eje34iJ/1fc+5pZj1gTYUvZeHz9mIKksOPxQ==
X-Google-Smtp-Source: AGHT+IGTn9BHqT0/KkFcGf/VAyaQUHOjwajjlRFBY9ZZmYdpMzrxFjXLdobpoU3Vbx5WcC0eOFxwTy/541P4ETag1VM=
X-Received: by 2002:a05:6a21:1706:b0:1f5:92ac:d6a1 with SMTP id
 adf61e73a8af0-21facbb3f30mr821850637.4.1749766107829; Thu, 12 Jun 2025
 15:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io>
 <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com>
 <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com>
 <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com>
 <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io>
 <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com>
 <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io>
 <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com> <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io>
In-Reply-To: <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 12 Jun 2025 18:08:16 -0400
X-Gm-Features: AX0GCFsmY0N4ihLSI7t86O1ayDqWobDY9h0ATLQ_hUVIXZnPnVG-btGlff3Ttio
Message-ID: <CAM0EoMnd0nZxJW3zpEuBGWTwB3AnJSnj242f9hMpcLdBWdcbfQ@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi William,
Apologies again for the latency.

On Mon, Jun 9, 2025 at 11:31=E2=80=AFAM William Liu <will@willsroot.io> wro=
te:
>
> On Monday, June 9th, 2025 at 12:27 PM, Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>

> >
> > I didnt finish my thought on that: I meant just dont allow a second
> > netem to be added to a specific tree if one already exists. Dont
> > bother checking for duplication.
> >
> > cheers,
> > jamal
> >
> > > > [1] see "loopy fun" in https://lwn.net/Articles/719297/
> > >
> Hi Jamal,
>
> I came up with the following fix last night to disallow adding a netem qd=
isc if one of its ancestral qdiscs is a netem. It's just a draft -I will cl=
ean it up, move qdisc_match_from_root to sch_generic, add test cases, and s=
ubmit a formal patchset for review if it looks good to you. Please let us k=
now if you catch any edge cases or correctness issues we might be missing.
>

It is a reasonable approach for fixing the obvious case you are
facing. But I am still concerned.
Potentially if you had another netem on a different branch of the tree
it may still be problematic.
Consider a prio qdisc with 3 bands each with a netem child with duplication=
 on.
Your solution will solve it for each branch if one tries to add a
netem child to any of these netems.

But consider you have a filter on the root qdisc or some intermediate
qdisc and an associated action that changes skb->prio; when it hits
netem and gets duplicated then when it goes back to the root it may be
classified by prio to a different netem which will duplicate and on
and on..
BTW: I gave the example of skb->prio but this could be skb->mark.

Perhaps we should only allow one netem per tree or allow more but
check for duplication and only allow one per tree...

cheers,
jamal

> Also, please let us know if you would us to bring in fixes for the 2 othe=
r small issues we discussed previously - moving the duplication after the i=
nitial enqueue to more accurately respect the limit check, and having loss =
take priority over duplication.
>
> We tested with the following configurations, all of which are illegal now=
 when we add the second netem (tc prints out RTNETLINK answers: Invalid arg=
ument).
>
> Netem parent is netem:
> tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100=
% delay 1us reorder 100%
>
> Qdisc tree root is netem:
> tc qdisc add dev lo root handle 1:0 netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1:0 handle 2:0 hfsc
> tc class add dev lo parent 2:0 classid 2:1 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 2:1 handle 3:0 netem duplicate 100%
> tc class add dev lo parent 2:0 classid 2:2 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 2:2 handle 4:0 netem duplicate 100%
>
> netem grandparent is netem:
> tc qdisc add dev lo root handle 1:0 tbf rate 8bit burst 100b latency 1s
> tc qdisc add dev lo parent 1:0 handle 2:0 netem gap 1 limit 1 duplicate 1=
00% delay 1us reorder 100%
> tc qdisc add dev lo parent 2:0 handle 3:0 hfsc
> tc class add dev lo parent 3:0 classid 3:1 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 3:1 handle 4:0 netem duplicate 100%
>
> netem great-grandparent is netem:
> tc qdisc add dev lo root handle 1:0 netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1:0 handle 2:0 hfsc
> tc class add dev lo parent 2:0 classid 2:1 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 2:1 handle 3:0 tbf rate 8bit burst 100b latenc=
y 1s
> tc qdisc add dev lo parent 3:0 handle 4:0 netem duplicate 100%
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..6178cd1453c5 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -1085,6 +1085,52 @@ static int netem_change(struct Qdisc *sch, struct =
nlattr *opt,
>         return ret;
>  }
>
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static struct Qdisc *qdisc_match_from_root(struct Qdisc *root, u32 handl=
e)
> +{
> +       struct Qdisc *q;
> +
> +       if (!qdisc_dev(root))
> +               return (root->handle =3D=3D handle ? root : NULL);
> +
> +       if (!(root->flags & TCQ_F_BUILTIN) &&
> +           root->handle =3D=3D handle)
> +               return root;
> +
> +       hash_for_each_possible_rcu(qdisc_dev(root)->qdisc_hash, q, hash, =
handle,
> +                                  lockdep_rtnl_is_held()) {
> +               if (q->handle =3D=3D handle)
> +                       return q;
> +       }
> +       return NULL;
> +}
> +
> +static bool has_netem_ancestor(struct Qdisc *sch) {
> +       struct Qdisc *root, *parent, *curr;
> +       bool ret =3D false;
> +
> +       sch_tree_lock(sch);
> +       curr =3D sch;
> +       root =3D qdisc_root_sleeping(sch);
> +       parent =3D qdisc_match_from_root(root, TC_H_MAJ(curr->parent));
> +
> +       while (parent !=3D NULL) {
> +               if (parent->ops->cl_ops =3D=3D &netem_class_ops) {
> +                       ret =3D true;
> +                       pr_warn("Ancestral netem already exists, cannot n=
est netem");
> +                       goto unlock;
> +               }
> +
> +               curr =3D parent;
> +               parent =3D qdisc_match_from_root(root, TC_H_MAJ(curr->par=
ent));
> +       }
> +
> +unlock:
> +       sch_tree_unlock(sch);
> +       return ret;
> +}
> +
>  static int netem_init(struct Qdisc *sch, struct nlattr *opt,
>                       struct netlink_ext_ack *extack)
>  {
> @@ -1093,6 +1139,9 @@ static int netem_init(struct Qdisc *sch, struct nla=
ttr *opt,
>
>         qdisc_watchdog_init(&q->watchdog, sch);
>
> +       if (has_netem_ancestor(sch))
> +               return -EINVAL;
> +
>         if (!opt)
>                 return -EINVAL;
>
> @@ -1330,3 +1379,4 @@ module_init(netem_module_init)
>  module_exit(netem_module_exit)
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Network characteristics emulator qdisc");

