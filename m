Return-Path: <netdev+bounces-218101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DAEB3B191
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1082C1B22B47
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0F5221FDC;
	Fri, 29 Aug 2025 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GQdA0mE1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281133985
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438143; cv=none; b=GYIhgIcNM2noEF+F1cLEEwO2R7f9JMpADUA9PwKFczq+qxtmudbGAPyYKaW7hociSvzWDXyZf/QV1K8QvPLez8sOzu9MQj0Qno4kvoPPjZCDkErwL246blzZQZPYcNxi6AfYoo+G1wG0nZXxdMYYfc/9bNUCvDTFn1I/aOFfbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438143; c=relaxed/simple;
	bh=RrsnY0XvFd+H6LZh0Hsy9en8JRKoKLk/+sSs2LtGfls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjFbw8ASZRn02lIlxOTGwkqiaHk/v9vWXQLeVQWhQjvevtbOX3VbAXrxJIaO/OPo5UMGaf4myokdMcK0UDWP8Lq3L2Z/DS/pi9qwznozHxg9DSnOTP6Te4cl3wHLV71jTHDfedYWpf6rbk86+++UPzhMqVnEbO0kezEsAnVLvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GQdA0mE1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso643314a12.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1756438141; x=1757042941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaW/viQCKyaTQqURl1kmuqQepS2WGkFhmzGNW9NcozI=;
        b=GQdA0mE1szHGoKatnxprFNAP+x0P7OlSwqtBIoYm64QEndyK6hDPVQr1vENpj1ieRG
         hg1NyS+tTdwiYhf9IhWTurGjRDkZL3u3oKa3/pB4/youknBJ6pYSUwDpFIccxeb4FVSK
         UU76nwO8AAKzvIWM84vMLkvYHnph8mOlVTCl4vSTf9rBzuYZXk/MdqK3+cYDpalTw82q
         e4+PGbD/BDQ3ouz9KtP4ZsGFYG+kWLrdWJ5FIXqn1++oV3TkCdNcRzKh6gRreMaPdsxf
         m73LtYpGggXThLUdwM096GLkYnFlqpm2IyAmnika2ca3PcqOOdaaPVXyQzDGFkdi7qEg
         UqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438141; x=1757042941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaW/viQCKyaTQqURl1kmuqQepS2WGkFhmzGNW9NcozI=;
        b=nA1B9tzSszcUrNvEgFhycuZQq1vyBUNYG2CvxY/TzZqdxiq62pYfpmF8UCvPd1eizu
         U1spdxLhzvRWPzXXXaVxt0+YOaMMGRZC+6tXjGXLc1bNXgNIrN8E6d/G5C6884Rp6E0w
         PYO5fufkv7QoFpN4d7xsa+dQXz1wVCHbvez8LcD2POMGA2zeYVCWtpBU9PRpZIUdYedl
         XdP62dLHfotfXyF6hDriIkXoES1YTiVKUslFb2ZmgYjeZQ5cr8dmt9XmFKF6Jy+4ylRP
         BWP9COqpv1VFVae0IykwidfJ/bu7uPA+414JKbA6TGRfQOlvalA1BdMqytanMeN3oG3W
         OOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxelQWZpHAd3LlpAWi3rHxb/PUWZoXX5n5u0dxVk9/NYpNpIDhfqLxbgUApO6z+wd5FaLcPxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabnkLM7Csw9SkH/iaP29wfzzku1wtKql7gxXMz9cLdDnTyukv
	5mOMIsTcsv95RbZYNMbu2jHdzB7J5mH4q+lZHRg9cNM+VR4mwiDrdUglZQ2EQBqBFa1I/O1jrwz
	LaFw3IUGRQIn/ZkrEl6ICiTVcGPWn8P/kjOUIgLN/
X-Gm-Gg: ASbGncv1zoVARLUdwJB2tCG5O6h5/uQZhZZdhD+fbPToyyL2E2skxKvOrWvda7GLGCb
	RiCexhaLbjTx6Hwv9/kwUUr6aYSth4YAHGb0zz6fi1ufn0NKxbGdcHcUy5dDh0NuehObfEBKuTc
	aHUgSJCKDXdg9QFAluwalnG5SNbHh1RGQmZGFRMgEtT6l8ZAr4fB/rgUFAdh8j0Bo5Ea0MGg6uc
	ah6tNwN9Y62n5OxZHLH
X-Google-Smtp-Source: AGHT+IHEhaWf1FcROQOZ6ZRdGXR9UueSpxXzg/a9WDu69aAgSlDiAUw6tIiO1fbJ7TyWRep6rfv0UK9/T2mbEpURapE=
X-Received: by 2002:a05:6a20:b2a2:b0:243:9fff:786c with SMTP id
 adf61e73a8af0-2439fff87e5mr10144957637.36.1756438140646; Thu, 28 Aug 2025
 20:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com> <20250827125349.3505302-2-edumazet@google.com>
 <CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com>
In-Reply-To: <CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 28 Aug 2025 23:28:49 -0400
X-Gm-Features: Ac12FXxxV74iTzWMPoz9lfHLcWUk4_LzuXuKF7cJx0Q2aJyJqBvWeYbiz_ZOIic
Message-ID: <CAM0EoMnk8KB780U=qpv+aqvvJuQX_yWgdx4ESJ64vzuQRwvmLw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net_sched: remove BH blocking in eight actions
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:26=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Aug 27, 2025 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Followup of f45b45cbfae3 ("Merge branch
> > 'net_sched-act-extend-rcu-use-in-dump-methods'")
> >
> > We never grab tcf_lock from BH context in these modules:
> >
> >  act_connmark
> >  act_csum
> >  act_ct
> >  act_ctinfo
> >  act_mpls
> >  act_nat
> >  act_pedit
> >  act_skbedit
> >
> > No longer block BH when acquiring tcf_lock from init functions.
> >
>
> Brief glance: isnt  the lock still held in BH context for some actions
> like pedit and nat (albeit in corner cases)? Both actions call
> tcf_action_update_bstats in their act callbacks.
> i.e if the action instance was not created with percpu stats,
> tcf_action_update_bstats will grab the lock.
>

Testing with lockdep should illustrate this..

cheers,
jamal
> cheers,
> jamal
>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/act_connmark.c | 4 ++--
> >  net/sched/act_csum.c     | 4 ++--
> >  net/sched/act_ct.c       | 4 ++--
> >  net/sched/act_ctinfo.c   | 4 ++--
> >  net/sched/act_mpls.c     | 4 ++--
> >  net/sched/act_nat.c      | 4 ++--
> >  net/sched/act_pedit.c    | 4 ++--
> >  net/sched/act_skbedit.c  | 4 ++--
> >  8 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
> > index 3e89927d711647d75f31c8d80a3ddd102e3d2e36..bf2d6b6da04223e1acaa7e9=
f5d29d426db06d705 100644
> > --- a/net/sched/act_connmark.c
> > +++ b/net/sched/act_connmark.c
> > @@ -169,10 +169,10 @@ static int tcf_connmark_init(struct net *net, str=
uct nlattr *nla,
> >
> >         nparms->action =3D parm->action;
> >
> > -       spin_lock_bh(&ci->tcf_lock);
> > +       spin_lock(&ci->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         oparms =3D rcu_replace_pointer(ci->parms, nparms, lockdep_is_he=
ld(&ci->tcf_lock));
> > -       spin_unlock_bh(&ci->tcf_lock);
> > +       spin_unlock(&ci->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> > index 0939e6b2ba4d1947df0f3dcfc09bfaa339a6ace2..8bad91753615a08d78d9908=
6fd6a7ab6e4c8e857 100644
> > --- a/net/sched/act_csum.c
> > +++ b/net/sched/act_csum.c
> > @@ -101,11 +101,11 @@ static int tcf_csum_init(struct net *net, struct =
nlattr *nla,
> >         params_new->update_flags =3D parm->update_flags;
> >         params_new->action =3D parm->action;
> >
> > -       spin_lock_bh(&p->tcf_lock);
> > +       spin_lock(&p->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         params_new =3D rcu_replace_pointer(p->params, params_new,
> >                                          lockdep_is_held(&p->tcf_lock))=
;
> > -       spin_unlock_bh(&p->tcf_lock);
> > +       spin_unlock(&p->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > index 6749a4a9a9cd0a43897fcd20d228721ce057cb88..6d2355e73b0f55750679b48=
e562e148d2cd8b7d4 100644
> > --- a/net/sched/act_ct.c
> > +++ b/net/sched/act_ct.c
> > @@ -1410,11 +1410,11 @@ static int tcf_ct_init(struct net *net, struct =
nlattr *nla,
> >                 goto cleanup;
> >
> >         params->action =3D parm->action;
> > -       spin_lock_bh(&c->tcf_lock);
> > +       spin_lock(&c->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         params =3D rcu_replace_pointer(c->params, params,
> >                                      lockdep_is_held(&c->tcf_lock));
> > -       spin_unlock_bh(&c->tcf_lock);
> > +       spin_unlock(&c->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
> > index 71efe04d00b5c6195e43f1ea6dab1548f6f97293..6f79eed9a544a49aed35ac0=
557250a3d5a9fc576 100644
> > --- a/net/sched/act_ctinfo.c
> > +++ b/net/sched/act_ctinfo.c
> > @@ -258,11 +258,11 @@ static int tcf_ctinfo_init(struct net *net, struc=
t nlattr *nla,
> >
> >         cp_new->action =3D actparm->action;
> >
> > -       spin_lock_bh(&ci->tcf_lock);
> > +       spin_lock(&ci->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, actparm->action, goto_ch=
);
> >         cp_new =3D rcu_replace_pointer(ci->params, cp_new,
> >                                      lockdep_is_held(&ci->tcf_lock));
> > -       spin_unlock_bh(&ci->tcf_lock);
> > +       spin_unlock(&ci->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > index 6654011dcd2ba30769b2f52078373a834e259f88..ed7bdaa23f0d80caef6bd5c=
d5b9787e24ff2d1af 100644
> > --- a/net/sched/act_mpls.c
> > +++ b/net/sched/act_mpls.c
> > @@ -296,10 +296,10 @@ static int tcf_mpls_init(struct net *net, struct =
nlattr *nla,
> >                                              htons(ETH_P_MPLS_UC));
> >         p->action =3D parm->action;
> >
> > -       spin_lock_bh(&m->tcf_lock);
> > +       spin_lock(&m->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         p =3D rcu_replace_pointer(m->mpls_p, p, lockdep_is_held(&m->tcf=
_lock));
> > -       spin_unlock_bh(&m->tcf_lock);
> > +       spin_unlock(&m->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> > index 26241d80ebe03e74a92e951fb5ae065493b93277..9cc2a1772cf8290a4be7d6e=
694e2ceccd48c386a 100644
> > --- a/net/sched/act_nat.c
> > +++ b/net/sched/act_nat.c
> > @@ -95,10 +95,10 @@ static int tcf_nat_init(struct net *net, struct nla=
ttr *nla, struct nlattr *est,
> >
> >         p =3D to_tcf_nat(*a);
> >
> > -       spin_lock_bh(&p->tcf_lock);
> > +       spin_lock(&p->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         oparm =3D rcu_replace_pointer(p->parms, nparm, lockdep_is_held(=
&p->tcf_lock));
> > -       spin_unlock_bh(&p->tcf_lock);
> > +       spin_unlock(&p->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index 4b65901397a88864014f74c53d0fa00b40ac6613..8fc8f577cb7a8362fee60cd=
79cce263edca32a7a 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -280,10 +280,10 @@ static int tcf_pedit_init(struct net *net, struct=
 nlattr *nla,
> >
> >         p =3D to_pedit(*a);
> >         nparms->action =3D parm->action;
> > -       spin_lock_bh(&p->tcf_lock);
> > +       spin_lock(&p->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         oparms =3D rcu_replace_pointer(p->parms, nparms, 1);
> > -       spin_unlock_bh(&p->tcf_lock);
> > +       spin_unlock(&p->tcf_lock);
> >
> >         if (oparms)
> >                 call_rcu(&oparms->rcu, tcf_pedit_cleanup_rcu);
> > diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> > index 8c1d1554f6575d3b0feae4d26ef4865d44a63e59..aa6b1744de21c1dca223cb8=
7a919dc3e29841b83 100644
> > --- a/net/sched/act_skbedit.c
> > +++ b/net/sched/act_skbedit.c
> > @@ -261,11 +261,11 @@ static int tcf_skbedit_init(struct net *net, stru=
ct nlattr *nla,
> >                 params_new->mask =3D *mask;
> >
> >         params_new->action =3D parm->action;
> > -       spin_lock_bh(&d->tcf_lock);
> > +       spin_lock(&d->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         params_new =3D rcu_replace_pointer(d->params, params_new,
> >                                          lockdep_is_held(&d->tcf_lock))=
;
> > -       spin_unlock_bh(&d->tcf_lock);
> > +       spin_unlock(&d->tcf_lock);
> >         if (params_new)
> >                 kfree_rcu(params_new, rcu);
> >         if (goto_ch)
> > --
> > 2.51.0.261.g7ce5a0a67e-goog
> >

