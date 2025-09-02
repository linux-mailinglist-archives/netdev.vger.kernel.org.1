Return-Path: <netdev+bounces-219111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE390B3FED9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561E11B25FDF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B22820BF;
	Tue,  2 Sep 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ASxynsy/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0952877FC
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814185; cv=none; b=sGDTcsMrUWXrDpRA8QZF0BmCFzYhlt+h9HYoNIioMj+nhoAj2k6O6lOfpfrlLzg3tWmFnYIxM9IUJvz9+Iz70A0kytJ3dvK/61BjP+k9YNnBNXjFAJoO/ocKtggdcpHl9xNFn5TulToQ2nvsmUsg4HX5jD+6k9sfb6+sbjQfzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814185; c=relaxed/simple;
	bh=a4+qaPk6CuAqFunCtmEKctLvYSfJxyUtEVtlvPDRuGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUYtXM9pYlLrF+GMCrHtU6kuF0p0VVbseMgVRoySuJv7vVQez10itgtnxwNRloUDHucNmpNWOVdVlTtlUi86ObYT3kyToRpEyTvTCrjtXXAeOrXWMSPzPEHUMi+RuNGM1qgvrd9sOK+qF9ZtWpeE0GZq9Jv2MQPV65pYUD7gp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ASxynsy/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso2801419b3a.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1756814182; x=1757418982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvMcC0BUbnGEvrjesh840ZolL99Mqv/X5rLcLIAN724=;
        b=ASxynsy/39ThfgpM9zYDOrNU9p02DJC4xv7TtqbI50LiVBwVvk5dnKxbk4CBAFmeR/
         P/Vn4zCiKbg6J6QLHq9mpZ992PQCcAgXeuYNOWwDxmYj6leUHc3SUcgt42m/q41KHZlf
         I3anIm768krUImR/Ua16zQBxsSWl6b+rlkXx2R/0pNBaCd6BJmkJODvoQzV7wC/Gev9b
         BA2Hbl60v3fj1NqfoPhUi4gbr3dx2jurVZDeQEggCq4KrLMUZ2o6oK/3h5PC0GSzBa73
         0uSuQt8ql+kENVbKOveXBiIxfj3hzOj2jTQQaGdP29hpgzQp0Ssq2FsPELJlhQWgu3q0
         WNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814182; x=1757418982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvMcC0BUbnGEvrjesh840ZolL99Mqv/X5rLcLIAN724=;
        b=Rt/L37E7AeAH0J65VEyqnwJrSUicXur92bqot8HcYWkLFRkj8HrU8TU/izdhuJN8NR
         TlGyZO8lTrPwTN7XxQo0k89sTtCQw/S3FrN7vys+RXZPnUn8lU1fq31+A9sUcYgrdfzy
         y4u2EqHMzytojMwx6TumNvaEZRETfzV1kuMrJFlpaqaaOIBet8nTLwGgKa8JNlnjYJpR
         VwWJ+YyUtFDl5ijKjPtGw1PdS/fcu6Ak47wwmrPFjD86jqy2Qdj8DeeqzY5DJ7EkL8z9
         HbK8l9ayge3ZUK6oxgDR+Ck2+NsuLNZSzu6h3xaSoTESv5wLwBPJZjNINr+AH+9H1But
         JC8w==
X-Forwarded-Encrypted: i=1; AJvYcCXhPZaViRSQsqxhghBOtEPvVLqqzto1N2tHQFM4xLoD1YGKyDFyqqfms3hhmwawH7QzpdcUvXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8m5LWMV+8Uyl5kNStqB5wkPnait+sIaqjobOYMQE+ovjOWZ62
	98mMGXILwCumIa69NGOcRrq5DGXbc8Qw2xtX1NFVIGZLVZRELdzv3UVkEip2OdVpcR+yj6OWQ53
	NgwQwOVCb5Nf8tPKlgUrASgNajUPsIC9k/dADz5Xr
X-Gm-Gg: ASbGncv1UywXnv4hE2FvYA4g4tdVpEJpLkvyFrOXTjLki/aJcGvmvhK5c4OAd/4VNSp
	qaRBQmyWP/P7EMIgnXPi0m2l8mTX5oucXgxoHjN0hoUmAYr/u1Pdqr1TkGNoMulMgLhDpkEE5/5
	Xn0xD4RhW866MVS6okQvP6TE0ee1cd2MzQGLcZVJ+rVWyf150rmZRLhwC+OPkB8UGfWHwBD+Ree
	+eVXb+8xW0PwjD2WcG26EKI3vVeCCm02qoSiw0=
X-Google-Smtp-Source: AGHT+IFdB4zAoUa1DnvwTufZKmVxhxp7j60gvDpAqxCeSL8Pvamtv4I9lgRpBSAsgFP0J92wqDFKghSwa4nQkbMQqU8=
X-Received: by 2002:a05:6a20:b926:b0:245:fbee:52ec with SMTP id
 adf61e73a8af0-245fbee5727mr2235377637.36.1756814182475; Tue, 02 Sep 2025
 04:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901092608.2032473-1-edumazet@google.com>
In-Reply-To: <20250901092608.2032473-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Sep 2025 07:56:04 -0400
X-Gm-Features: Ac12FXzDQ2q8SMgrmIIM9ohKIc0nHQ2hlq0koicmdfsjrwL41qKo4QjCY75TMA4
Message-ID: <CAM0EoMk6e-qyXZsONXx0awDcQ-r+X30hsB9uqqFhd=12k9pOcQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: add back BH safety to tcf_lock
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Jamal reported that we had to use BH safety after all,
> because stats can be updated from BH handler.
>
> Fixes: 3133d5c15cb5 ("net_sched: remove BH blocking in eight actions")
> Fixes: 53df77e78590 ("net_sched: act_skbmod: use RCU in tcf_skbmod_dump()=
")
> Fixes: e97ae742972f ("net_sched: act_tunnel_key: use RCU in tunnel_key_du=
mp()")
> Fixes: 48b5e5dbdb23 ("net_sched: act_vlan: use RCU in tcf_vlan_dump()")
> Reported-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Closes: https://lore.kernel.org/netdev/CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbM=
u=3DfJtbNoYD7YXg4bA@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Eric - i dont think this will fix that lockdep splat i was referring
to though, no?

cheers,
jamal
> ---
>  net/sched/act_connmark.c   | 4 ++--
>  net/sched/act_csum.c       | 4 ++--
>  net/sched/act_ct.c         | 4 ++--
>  net/sched/act_ctinfo.c     | 4 ++--
>  net/sched/act_mpls.c       | 4 ++--
>  net/sched/act_nat.c        | 4 ++--
>  net/sched/act_pedit.c      | 4 ++--
>  net/sched/act_skbedit.c    | 4 ++--
>  net/sched/act_skbmod.c     | 4 ++--
>  net/sched/act_tunnel_key.c | 4 ++--
>  net/sched/act_vlan.c       | 4 ++--
>  11 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
> index bf2d6b6da042..3e89927d7116 100644
> --- a/net/sched/act_connmark.c
> +++ b/net/sched/act_connmark.c
> @@ -169,10 +169,10 @@ static int tcf_connmark_init(struct net *net, struc=
t nlattr *nla,
>
>         nparms->action =3D parm->action;
>
> -       spin_lock(&ci->tcf_lock);
> +       spin_lock_bh(&ci->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         oparms =3D rcu_replace_pointer(ci->parms, nparms, lockdep_is_held=
(&ci->tcf_lock));
> -       spin_unlock(&ci->tcf_lock);
> +       spin_unlock_bh(&ci->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> index 8bad91753615..0939e6b2ba4d 100644
> --- a/net/sched/act_csum.c
> +++ b/net/sched/act_csum.c
> @@ -101,11 +101,11 @@ static int tcf_csum_init(struct net *net, struct nl=
attr *nla,
>         params_new->update_flags =3D parm->update_flags;
>         params_new->action =3D parm->action;
>
> -       spin_lock(&p->tcf_lock);
> +       spin_lock_bh(&p->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         params_new =3D rcu_replace_pointer(p->params, params_new,
>                                          lockdep_is_held(&p->tcf_lock));
> -       spin_unlock(&p->tcf_lock);
> +       spin_unlock_bh(&p->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 6d2355e73b0f..6749a4a9a9cd 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1410,11 +1410,11 @@ static int tcf_ct_init(struct net *net, struct nl=
attr *nla,
>                 goto cleanup;
>
>         params->action =3D parm->action;
> -       spin_lock(&c->tcf_lock);
> +       spin_lock_bh(&c->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         params =3D rcu_replace_pointer(c->params, params,
>                                      lockdep_is_held(&c->tcf_lock));
> -       spin_unlock(&c->tcf_lock);
> +       spin_unlock_bh(&c->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
> index 6f79eed9a544..71efe04d00b5 100644
> --- a/net/sched/act_ctinfo.c
> +++ b/net/sched/act_ctinfo.c
> @@ -258,11 +258,11 @@ static int tcf_ctinfo_init(struct net *net, struct =
nlattr *nla,
>
>         cp_new->action =3D actparm->action;
>
> -       spin_lock(&ci->tcf_lock);
> +       spin_lock_bh(&ci->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, actparm->action, goto_ch);
>         cp_new =3D rcu_replace_pointer(ci->params, cp_new,
>                                      lockdep_is_held(&ci->tcf_lock));
> -       spin_unlock(&ci->tcf_lock);
> +       spin_unlock_bh(&ci->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index ed7bdaa23f0d..6654011dcd2b 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -296,10 +296,10 @@ static int tcf_mpls_init(struct net *net, struct nl=
attr *nla,
>                                              htons(ETH_P_MPLS_UC));
>         p->action =3D parm->action;
>
> -       spin_lock(&m->tcf_lock);
> +       spin_lock_bh(&m->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         p =3D rcu_replace_pointer(m->mpls_p, p, lockdep_is_held(&m->tcf_l=
ock));
> -       spin_unlock(&m->tcf_lock);
> +       spin_unlock_bh(&m->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index 9cc2a1772cf8..26241d80ebe0 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -95,10 +95,10 @@ static int tcf_nat_init(struct net *net, struct nlatt=
r *nla, struct nlattr *est,
>
>         p =3D to_tcf_nat(*a);
>
> -       spin_lock(&p->tcf_lock);
> +       spin_lock_bh(&p->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         oparm =3D rcu_replace_pointer(p->parms, nparm, lockdep_is_held(&p=
->tcf_lock));
> -       spin_unlock(&p->tcf_lock);
> +       spin_unlock_bh(&p->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index 8fc8f577cb7a..4b65901397a8 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -280,10 +280,10 @@ static int tcf_pedit_init(struct net *net, struct n=
lattr *nla,
>
>         p =3D to_pedit(*a);
>         nparms->action =3D parm->action;
> -       spin_lock(&p->tcf_lock);
> +       spin_lock_bh(&p->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         oparms =3D rcu_replace_pointer(p->parms, nparms, 1);
> -       spin_unlock(&p->tcf_lock);
> +       spin_unlock_bh(&p->tcf_lock);
>
>         if (oparms)
>                 call_rcu(&oparms->rcu, tcf_pedit_cleanup_rcu);
> diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> index aa6b1744de21..8c1d1554f657 100644
> --- a/net/sched/act_skbedit.c
> +++ b/net/sched/act_skbedit.c
> @@ -261,11 +261,11 @@ static int tcf_skbedit_init(struct net *net, struct=
 nlattr *nla,
>                 params_new->mask =3D *mask;
>
>         params_new->action =3D parm->action;
> -       spin_lock(&d->tcf_lock);
> +       spin_lock_bh(&d->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         params_new =3D rcu_replace_pointer(d->params, params_new,
>                                          lockdep_is_held(&d->tcf_lock));
> -       spin_unlock(&d->tcf_lock);
> +       spin_unlock_bh(&d->tcf_lock);
>         if (params_new)
>                 kfree_rcu(params_new, rcu);
>         if (goto_ch)
> diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
> index fce625eafcb2..a9e0c1326e2a 100644
> --- a/net/sched/act_skbmod.c
> +++ b/net/sched/act_skbmod.c
> @@ -194,7 +194,7 @@ static int tcf_skbmod_init(struct net *net, struct nl=
attr *nla,
>         p->flags =3D lflags;
>         p->action =3D parm->action;
>         if (ovr)
> -               spin_lock(&d->tcf_lock);
> +               spin_lock_bh(&d->tcf_lock);
>         /* Protected by tcf_lock if overwriting existing action. */
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         p_old =3D rcu_dereference_protected(d->skbmod_p, 1);
> @@ -208,7 +208,7 @@ static int tcf_skbmod_init(struct net *net, struct nl=
attr *nla,
>
>         rcu_assign_pointer(d->skbmod_p, p);
>         if (ovr)
> -               spin_unlock(&d->tcf_lock);
> +               spin_unlock_bh(&d->tcf_lock);
>
>         if (p_old)
>                 kfree_rcu(p_old, rcu);
> diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
> index e1c8b48c217c..876b30c5709e 100644
> --- a/net/sched/act_tunnel_key.c
> +++ b/net/sched/act_tunnel_key.c
> @@ -531,11 +531,11 @@ static int tunnel_key_init(struct net *net, struct =
nlattr *nla,
>         params_new->tcft_enc_metadata =3D metadata;
>
>         params_new->action =3D parm->action;
> -       spin_lock(&t->tcf_lock);
> +       spin_lock_bh(&t->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         params_new =3D rcu_replace_pointer(t->params, params_new,
>                                          lockdep_is_held(&t->tcf_lock));
> -       spin_unlock(&t->tcf_lock);
> +       spin_unlock_bh(&t->tcf_lock);
>         tunnel_key_release_params(params_new);
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> index b46f980f3b2a..a74621797d69 100644
> --- a/net/sched/act_vlan.c
> +++ b/net/sched/act_vlan.c
> @@ -253,10 +253,10 @@ static int tcf_vlan_init(struct net *net, struct nl=
attr *nla,
>         }
>
>         p->action =3D parm->action;
> -       spin_lock(&v->tcf_lock);
> +       spin_lock_bh(&v->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         p =3D rcu_replace_pointer(v->vlan_p, p, lockdep_is_held(&v->tcf_l=
ock));
> -       spin_unlock(&v->tcf_lock);
> +       spin_unlock_bh(&v->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> --
> 2.51.0.318.gd7df087d1a-goog
>

