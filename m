Return-Path: <netdev+bounces-219119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AAB4004B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349D14E6658
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB92F3C12;
	Tue,  2 Sep 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="n5DdoXMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280332FABF6
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815211; cv=none; b=RyNGBWDLG7RgEj++dBJwNIyVLE1ogL/ZJ1I6Ew7cM3ByiNaeRAb4CyDsVUi62T2n3Vp3CrnICKkwTX4yVxkK14jjSH/uoMv04eYdlCgiax/Kez8OlSUZV809Ard4avJ8CxepQtcOkLZy2ZB6qXOSeUz8MV4VdqsLc+zgYFYL65w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815211; c=relaxed/simple;
	bh=RHuiK3m1R7DIHHKPjEvAfq9rh0+7qwQf6U0Wg3GoP3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IW9DwkSv7DqYgA3IsQXE57r+58Lyp2qjSQ0cOkdShJsIzz4bscvd+2HIzYaIhO5O6KkBV8IRY+5vHD8QWREpzuCJOz4C9f0lfr6rVd090/tSAxfKeFWQF4vhq7+U6qXgRk2W6o3d3S8ZCPiQ5XS2NxrxvpWsxkJ0w2UnYnevdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=n5DdoXMU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-248ff4403b9so38120825ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1756815207; x=1757420007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a60Flo8lmMe/Yb6CoO1S39iqBAD5DOh/O5L2K+vZi3U=;
        b=n5DdoXMU7FMS876XgSOxqEoBNfH4vKC6dB6cQ5awHixX9jfgURF0EtqCibtk6NOQl3
         i6SRZBglW4SbgWlajIvcItDxifQqk8fehpqezIiBtndjQTBU3zWI9kexSgUViMczcBFI
         LUh8sGf9We1t4tSjS6Cs+qno097P8ABzM0MZOOmOGJA1VXTW4m0uOTYMHdlwRDOpzc4j
         V+0KO3KVyMj0Vu8/KM3RlyeXNx1WbwASC0cP8byCGjtspqZo40E9QVEcLV4pBTuC7l2o
         1GgKTA4EsEVdUVCloco9JlPBX3ELx53W2OoMpkOgv2IBtmNBVvULOXRdZNe5CSZCnneN
         LwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815207; x=1757420007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a60Flo8lmMe/Yb6CoO1S39iqBAD5DOh/O5L2K+vZi3U=;
        b=QjSWwpB7DAQmLXbWaM+047PX94yytDkG4TyI1phA1yNXFO3O7j8QS/6bB5Jm9LzJC6
         82gAC9Ts+kE+FIT6+UowdUM5++UrbR/EZn/e+uBeOJq5uirv2n5/DaFa3GUm8nkLonzE
         O6H7d1ngHRk6HhTdNhl7B9xdqxGDZ9ioKwQLRpt3S/Alh97WhuH//GpYtGnxhj8HFO+F
         EGIl6C4FMwiMF/w8GvBP4nMmfkdBQNkT5iU3GIgEXa6K5VYbP85/3tocB6pUM9kR4f4O
         8VdUWmwu5QHkrmElL6z69OTBeIceOQw0lrzBk+Amc8D5N0tT0YRxvKO1S3opWT4ErpPf
         pK7g==
X-Forwarded-Encrypted: i=1; AJvYcCXxoqPshQ9qc529PjeVK2tysJAzExitmTW+DrVr7VoyxpNFjjO3xrWW/LYGC9NzKpFEgreMeBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFtLWEuwx4MQMU3cBp+3y0/fDDfpl/wfz+lZ3eJs8PL4C5mnf
	9SBLI8H12Gq5GZ6dSBgCvkh3hW1jR3jAgdrJMdNhYsU5tWJtB/LqJmEj0SEoxhPHGu0QKh7B9oQ
	pcyo25Y/R8pPzgqexLiFoPLMJ+/TpEpjSn6bhjnyk
X-Gm-Gg: ASbGncsE0uigpfjUdkIPhWP0C5pfe04gp0naO0A6I8liirQNmPHk4IXV+4WcrA5pkhY
	w0KTnqnGmE7aSqB5Oo3vi5TrAxpJ5Z1+gU7Mu1p+AB7LzpQ+43o6umUkuhV3AKPfQFBVIY44dxy
	DCRA4zQQ/+HJPTym9AMJTAlhWnjXg6TVjYt+XN0bZBm12tmY9LpSL2p1a2Bn3B4SRwdCaCAwbYb
	YiCcxkeZoQq4andgw==
X-Google-Smtp-Source: AGHT+IHl+Vw+Uu02xnYlNWIYK3MUuFcXAo9SEnJ03Ax2utXCSZlJgheL/SJoFO2ICapaxSqwD0rOEkKCmJk3wWANjow=
X-Received: by 2002:a17:902:e749:b0:24b:1625:5fa5 with SMTP id
 d9443c01a7336-24b162561c4mr27430545ad.11.1756815207058; Tue, 02 Sep 2025
 05:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901092608.2032473-1-edumazet@google.com> <CAM0EoMk6e-qyXZsONXx0awDcQ-r+X30hsB9uqqFhd=12k9pOcQ@mail.gmail.com>
In-Reply-To: <CAM0EoMk6e-qyXZsONXx0awDcQ-r+X30hsB9uqqFhd=12k9pOcQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Sep 2025 08:13:15 -0400
X-Gm-Features: Ac12FXzuJ9Jj3k8XtDWywGoYuAKmyaqtt5gD6uFFAEGzyQcCF0tSjRa8xwPYhrY
Message-ID: <CAM0EoMmQ75NMqdnC32d_vQ_5p23je4g8SVQvUy+sbu2y5JXCPA@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: add back BH safety to tcf_lock
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:56=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Mon, Sep 1, 2025 at 5:26=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > Jamal reported that we had to use BH safety after all,
> > because stats can be updated from BH handler.
> >
> > Fixes: 3133d5c15cb5 ("net_sched: remove BH blocking in eight actions")
> > Fixes: 53df77e78590 ("net_sched: act_skbmod: use RCU in tcf_skbmod_dump=
()")
> > Fixes: e97ae742972f ("net_sched: act_tunnel_key: use RCU in tunnel_key_=
dump()")
> > Fixes: 48b5e5dbdb23 ("net_sched: act_vlan: use RCU in tcf_vlan_dump()")
> > Reported-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Closes: https://lore.kernel.org/netdev/CAM0EoMmhq66EtVqDEuNik8MVFZqkgxF=
bMu=3DfJtbNoYD7YXg4bA@mail.gmail.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Eric - i dont think this will fix that lockdep splat i was referring
> to though, no?
>

Quick test reveals it was fixed ;->

cheers,
jamal
> cheers,
> jamal
> > ---
> >  net/sched/act_connmark.c   | 4 ++--
> >  net/sched/act_csum.c       | 4 ++--
> >  net/sched/act_ct.c         | 4 ++--
> >  net/sched/act_ctinfo.c     | 4 ++--
> >  net/sched/act_mpls.c       | 4 ++--
> >  net/sched/act_nat.c        | 4 ++--
> >  net/sched/act_pedit.c      | 4 ++--
> >  net/sched/act_skbedit.c    | 4 ++--
> >  net/sched/act_skbmod.c     | 4 ++--
> >  net/sched/act_tunnel_key.c | 4 ++--
> >  net/sched/act_vlan.c       | 4 ++--
> >  11 files changed, 22 insertions(+), 22 deletions(-)
> >
> > diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
> > index bf2d6b6da042..3e89927d7116 100644
> > --- a/net/sched/act_connmark.c
> > +++ b/net/sched/act_connmark.c
> > @@ -169,10 +169,10 @@ static int tcf_connmark_init(struct net *net, str=
uct nlattr *nla,
> >
> >         nparms->action =3D parm->action;
> >
> > -       spin_lock(&ci->tcf_lock);
> > +       spin_lock_bh(&ci->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         oparms =3D rcu_replace_pointer(ci->parms, nparms, lockdep_is_he=
ld(&ci->tcf_lock));
> > -       spin_unlock(&ci->tcf_lock);
> > +       spin_unlock_bh(&ci->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> > index 8bad91753615..0939e6b2ba4d 100644
> > --- a/net/sched/act_csum.c
> > +++ b/net/sched/act_csum.c
> > @@ -101,11 +101,11 @@ static int tcf_csum_init(struct net *net, struct =
nlattr *nla,
> >         params_new->update_flags =3D parm->update_flags;
> >         params_new->action =3D parm->action;
> >
> > -       spin_lock(&p->tcf_lock);
> > +       spin_lock_bh(&p->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         params_new =3D rcu_replace_pointer(p->params, params_new,
> >                                          lockdep_is_held(&p->tcf_lock))=
;
> > -       spin_unlock(&p->tcf_lock);
> > +       spin_unlock_bh(&p->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > index 6d2355e73b0f..6749a4a9a9cd 100644
> > --- a/net/sched/act_ct.c
> > +++ b/net/sched/act_ct.c
> > @@ -1410,11 +1410,11 @@ static int tcf_ct_init(struct net *net, struct =
nlattr *nla,
> >                 goto cleanup;
> >
> >         params->action =3D parm->action;
> > -       spin_lock(&c->tcf_lock);
> > +       spin_lock_bh(&c->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         params =3D rcu_replace_pointer(c->params, params,
> >                                      lockdep_is_held(&c->tcf_lock));
> > -       spin_unlock(&c->tcf_lock);
> > +       spin_unlock_bh(&c->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
> > index 6f79eed9a544..71efe04d00b5 100644
> > --- a/net/sched/act_ctinfo.c
> > +++ b/net/sched/act_ctinfo.c
> > @@ -258,11 +258,11 @@ static int tcf_ctinfo_init(struct net *net, struc=
t nlattr *nla,
> >
> >         cp_new->action =3D actparm->action;
> >
> > -       spin_lock(&ci->tcf_lock);
> > +       spin_lock_bh(&ci->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, actparm->action, goto_ch=
);
> >         cp_new =3D rcu_replace_pointer(ci->params, cp_new,
> >                                      lockdep_is_held(&ci->tcf_lock));
> > -       spin_unlock(&ci->tcf_lock);
> > +       spin_unlock_bh(&ci->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > index ed7bdaa23f0d..6654011dcd2b 100644
> > --- a/net/sched/act_mpls.c
> > +++ b/net/sched/act_mpls.c
> > @@ -296,10 +296,10 @@ static int tcf_mpls_init(struct net *net, struct =
nlattr *nla,
> >                                              htons(ETH_P_MPLS_UC));
> >         p->action =3D parm->action;
> >
> > -       spin_lock(&m->tcf_lock);
> > +       spin_lock_bh(&m->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         p =3D rcu_replace_pointer(m->mpls_p, p, lockdep_is_held(&m->tcf=
_lock));
> > -       spin_unlock(&m->tcf_lock);
> > +       spin_unlock_bh(&m->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> > index 9cc2a1772cf8..26241d80ebe0 100644
> > --- a/net/sched/act_nat.c
> > +++ b/net/sched/act_nat.c
> > @@ -95,10 +95,10 @@ static int tcf_nat_init(struct net *net, struct nla=
ttr *nla, struct nlattr *est,
> >
> >         p =3D to_tcf_nat(*a);
> >
> > -       spin_lock(&p->tcf_lock);
> > +       spin_lock_bh(&p->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         oparm =3D rcu_replace_pointer(p->parms, nparm, lockdep_is_held(=
&p->tcf_lock));
> > -       spin_unlock(&p->tcf_lock);
> > +       spin_unlock_bh(&p->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index 8fc8f577cb7a..4b65901397a8 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -280,10 +280,10 @@ static int tcf_pedit_init(struct net *net, struct=
 nlattr *nla,
> >
> >         p =3D to_pedit(*a);
> >         nparms->action =3D parm->action;
> > -       spin_lock(&p->tcf_lock);
> > +       spin_lock_bh(&p->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         oparms =3D rcu_replace_pointer(p->parms, nparms, 1);
> > -       spin_unlock(&p->tcf_lock);
> > +       spin_unlock_bh(&p->tcf_lock);
> >
> >         if (oparms)
> >                 call_rcu(&oparms->rcu, tcf_pedit_cleanup_rcu);
> > diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> > index aa6b1744de21..8c1d1554f657 100644
> > --- a/net/sched/act_skbedit.c
> > +++ b/net/sched/act_skbedit.c
> > @@ -261,11 +261,11 @@ static int tcf_skbedit_init(struct net *net, stru=
ct nlattr *nla,
> >                 params_new->mask =3D *mask;
> >
> >         params_new->action =3D parm->action;
> > -       spin_lock(&d->tcf_lock);
> > +       spin_lock_bh(&d->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         params_new =3D rcu_replace_pointer(d->params, params_new,
> >                                          lockdep_is_held(&d->tcf_lock))=
;
> > -       spin_unlock(&d->tcf_lock);
> > +       spin_unlock_bh(&d->tcf_lock);
> >         if (params_new)
> >                 kfree_rcu(params_new, rcu);
> >         if (goto_ch)
> > diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
> > index fce625eafcb2..a9e0c1326e2a 100644
> > --- a/net/sched/act_skbmod.c
> > +++ b/net/sched/act_skbmod.c
> > @@ -194,7 +194,7 @@ static int tcf_skbmod_init(struct net *net, struct =
nlattr *nla,
> >         p->flags =3D lflags;
> >         p->action =3D parm->action;
> >         if (ovr)
> > -               spin_lock(&d->tcf_lock);
> > +               spin_lock_bh(&d->tcf_lock);
> >         /* Protected by tcf_lock if overwriting existing action. */
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         p_old =3D rcu_dereference_protected(d->skbmod_p, 1);
> > @@ -208,7 +208,7 @@ static int tcf_skbmod_init(struct net *net, struct =
nlattr *nla,
> >
> >         rcu_assign_pointer(d->skbmod_p, p);
> >         if (ovr)
> > -               spin_unlock(&d->tcf_lock);
> > +               spin_unlock_bh(&d->tcf_lock);
> >
> >         if (p_old)
> >                 kfree_rcu(p_old, rcu);
> > diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
> > index e1c8b48c217c..876b30c5709e 100644
> > --- a/net/sched/act_tunnel_key.c
> > +++ b/net/sched/act_tunnel_key.c
> > @@ -531,11 +531,11 @@ static int tunnel_key_init(struct net *net, struc=
t nlattr *nla,
> >         params_new->tcft_enc_metadata =3D metadata;
> >
> >         params_new->action =3D parm->action;
> > -       spin_lock(&t->tcf_lock);
> > +       spin_lock_bh(&t->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         params_new =3D rcu_replace_pointer(t->params, params_new,
> >                                          lockdep_is_held(&t->tcf_lock))=
;
> > -       spin_unlock(&t->tcf_lock);
> > +       spin_unlock_bh(&t->tcf_lock);
> >         tunnel_key_release_params(params_new);
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> > index b46f980f3b2a..a74621797d69 100644
> > --- a/net/sched/act_vlan.c
> > +++ b/net/sched/act_vlan.c
> > @@ -253,10 +253,10 @@ static int tcf_vlan_init(struct net *net, struct =
nlattr *nla,
> >         }
> >
> >         p->action =3D parm->action;
> > -       spin_lock(&v->tcf_lock);
> > +       spin_lock_bh(&v->tcf_lock);
> >         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >         p =3D rcu_replace_pointer(v->vlan_p, p, lockdep_is_held(&v->tcf=
_lock));
> > -       spin_unlock(&v->tcf_lock);
> > +       spin_unlock_bh(&v->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > --
> > 2.51.0.318.gd7df087d1a-goog
> >

