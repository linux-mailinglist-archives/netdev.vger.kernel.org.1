Return-Path: <netdev+bounces-218100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0773B3B190
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5023582408
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B061221271;
	Fri, 29 Aug 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Tr4Ftls/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5313B5A9
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438024; cv=none; b=rkG1M/R0Z8ZruUzkjngob1n7Di18b6Y9l3QWgkHSSFX+SqzqS08OnP/YfKOyTnjlY3g7/vDxvNx/lqtiiF20Z81B+bJuOeW+NME7J9uYcakVZ5/Gmc4Hlgkqc5BAZss3VBa9qXyDEJA78n5PICVC2gpgc5sUDIe1hHpY3Y10/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438024; c=relaxed/simple;
	bh=ANbfd0jzIaA9ePUtELgCzgCVowseXsEdSf2PBzla+bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3Hh2At5e7+2WvxJgNHDOQpxqQKibtnufUm405HnFjbbMzZQt/Edz3egUQWFKwwcgUY/wgcpLKoQP6cu55MWAErT5+iWFun459LAHuCOv2COJAhHe6LVzRfqefiBoIXEhq78bCgN2KjWD2zZaPRdezpv2F3uS/REs/nURVRpGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Tr4Ftls/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323267872f3so1528863a91.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1756438022; x=1757042822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Joc+GTI9lI8Qa5zQEKqef60f5DK7Nz8HNGjT/4jnMfI=;
        b=Tr4Ftls/AYqf0ekGoZE6ULuSiROxOFom5BHUBt6mKcsEg0g6wOdZgmx0DQz/N/0Iqh
         pgba6nFY9za4pU0RBtPVvnPIhshqxWmBc7lyeVIS+2VxaFOhi1DUkjdLUX40Xmy6+8eW
         CaiRftC8C9zKsnguZvg/v/SKgj8d/ge0GLj+EmbmAGVr/aoQMJ1lpfrFz+EiROmoZGQp
         Xc2wMAB2JGCtC8zL/LsXoBWQsJLOoIPb7ziAl2DNjlsAsoxQ+QCJIe4gkr/+JjSjgdXY
         +NMaSTV3a94C9eAEDndUZWxZ1TqAfhqnLwWiDePku6WDzsmqe0e/WHJTRSRLfaKc2gpE
         U/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438022; x=1757042822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Joc+GTI9lI8Qa5zQEKqef60f5DK7Nz8HNGjT/4jnMfI=;
        b=m5tMGCraZMANz5b9byAW/ouRE2Pd4L0c2fqSuDXRAHSUMPpZKyoNyJG3xvVZ590QBZ
         BHHdVR9xtRwZt3MKH0xlfqemfcf12WsZpoyfuX4fp9g3EfealNNqKIQ0hDHN//xmUSTP
         PtHRFNdGrwAr1ix/ngVX2tsy1enkU/MwCqqfPLfYTayWvR+ZVTh8e5Nhbo6Mcec/zA1H
         xV70rC51/aBE1xVzX4J5oMyStT5k9ohjEPHKkziDEFmU+5UA+rThK3rlm7RzWqBgn/RS
         rLRfsVApa5RYfP1q4O+08nu0vI/+llZxdbrKDSeaCn3QOez4vmMXDvQDmTj9D+lqvARZ
         FVlw==
X-Forwarded-Encrypted: i=1; AJvYcCWzQYT/3VNVHv0A1nlM95bHWrZYV+Fcl4rmO9HXk0OIcgXhCMKbQDSd/5NiY9n42dUAHIKdsqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBszLBSURLhLkoB8toRPjA92LwfpLUl9ztyAdNQztqawENHznu
	ABcbqaPl02dZAX0FUsOorz+7IBdVktuPHRCBlPKHEFu0qIkUFeILlHLVujztx0LUeLZhFYA1U84
	eR1um7tqKnCAzgMxyTrS7k1EMC/UowP2i49SJQmZT
X-Gm-Gg: ASbGncs8fIQuXKxUZv6k6lqv0hFL7bmW4hRoBEAoqlhi1qM0nOlevNsRXMRDmIIR3y9
	ZPGsnFnPaqvNLCCMDG67GFHfLz26yPR2qPVjP7QT2a7zu3/dgQtccbj+TCtf9IFl2WopbC8aTPx
	8dH+goTGR6p95VlvsIn0jYVGjOYrf4dybm16QBW4RodecTXIkdVKVsDMxhaQ+HBAZEkXFhKoxyD
	Mkj+rytFnUgUfBaV1IgQtve5l1WRU8=
X-Google-Smtp-Source: AGHT+IHdIP1MFmfCe83xxGCQe+nc5B/+VeEoy6QF+cI6w2P8Hyzht9kZvWdMFs093hJ53s0xZe1D91F0R/96DLvSNHU=
X-Received: by 2002:a17:90a:ec85:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-3279e8877fbmr8993028a91.37.1756438021836; Thu, 28 Aug 2025
 20:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com> <20250827125349.3505302-2-edumazet@google.com>
In-Reply-To: <20250827125349.3505302-2-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 28 Aug 2025 23:26:50 -0400
X-Gm-Features: Ac12FXxmk0zdGBJRs5g0AS5LM5KrmDq5gRJNxq5G6Y4Ow-iDlc7MDSOBz7En1_s
Message-ID: <CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net_sched: remove BH blocking in eight actions
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Followup of f45b45cbfae3 ("Merge branch
> 'net_sched-act-extend-rcu-use-in-dump-methods'")
>
> We never grab tcf_lock from BH context in these modules:
>
>  act_connmark
>  act_csum
>  act_ct
>  act_ctinfo
>  act_mpls
>  act_nat
>  act_pedit
>  act_skbedit
>
> No longer block BH when acquiring tcf_lock from init functions.
>

Brief glance: isnt  the lock still held in BH context for some actions
like pedit and nat (albeit in corner cases)? Both actions call
tcf_action_update_bstats in their act callbacks.
i.e if the action instance was not created with percpu stats,
tcf_action_update_bstats will grab the lock.

cheers,
jamal

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/act_connmark.c | 4 ++--
>  net/sched/act_csum.c     | 4 ++--
>  net/sched/act_ct.c       | 4 ++--
>  net/sched/act_ctinfo.c   | 4 ++--
>  net/sched/act_mpls.c     | 4 ++--
>  net/sched/act_nat.c      | 4 ++--
>  net/sched/act_pedit.c    | 4 ++--
>  net/sched/act_skbedit.c  | 4 ++--
>  8 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
> index 3e89927d711647d75f31c8d80a3ddd102e3d2e36..bf2d6b6da04223e1acaa7e9f5=
d29d426db06d705 100644
> --- a/net/sched/act_connmark.c
> +++ b/net/sched/act_connmark.c
> @@ -169,10 +169,10 @@ static int tcf_connmark_init(struct net *net, struc=
t nlattr *nla,
>
>         nparms->action =3D parm->action;
>
> -       spin_lock_bh(&ci->tcf_lock);
> +       spin_lock(&ci->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         oparms =3D rcu_replace_pointer(ci->parms, nparms, lockdep_is_held=
(&ci->tcf_lock));
> -       spin_unlock_bh(&ci->tcf_lock);
> +       spin_unlock(&ci->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> index 0939e6b2ba4d1947df0f3dcfc09bfaa339a6ace2..8bad91753615a08d78d99086f=
d6a7ab6e4c8e857 100644
> --- a/net/sched/act_csum.c
> +++ b/net/sched/act_csum.c
> @@ -101,11 +101,11 @@ static int tcf_csum_init(struct net *net, struct nl=
attr *nla,
>         params_new->update_flags =3D parm->update_flags;
>         params_new->action =3D parm->action;
>
> -       spin_lock_bh(&p->tcf_lock);
> +       spin_lock(&p->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         params_new =3D rcu_replace_pointer(p->params, params_new,
>                                          lockdep_is_held(&p->tcf_lock));
> -       spin_unlock_bh(&p->tcf_lock);
> +       spin_unlock(&p->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 6749a4a9a9cd0a43897fcd20d228721ce057cb88..6d2355e73b0f55750679b48e5=
62e148d2cd8b7d4 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1410,11 +1410,11 @@ static int tcf_ct_init(struct net *net, struct nl=
attr *nla,
>                 goto cleanup;
>
>         params->action =3D parm->action;
> -       spin_lock_bh(&c->tcf_lock);
> +       spin_lock(&c->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         params =3D rcu_replace_pointer(c->params, params,
>                                      lockdep_is_held(&c->tcf_lock));
> -       spin_unlock_bh(&c->tcf_lock);
> +       spin_unlock(&c->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
> index 71efe04d00b5c6195e43f1ea6dab1548f6f97293..6f79eed9a544a49aed35ac055=
7250a3d5a9fc576 100644
> --- a/net/sched/act_ctinfo.c
> +++ b/net/sched/act_ctinfo.c
> @@ -258,11 +258,11 @@ static int tcf_ctinfo_init(struct net *net, struct =
nlattr *nla,
>
>         cp_new->action =3D actparm->action;
>
> -       spin_lock_bh(&ci->tcf_lock);
> +       spin_lock(&ci->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, actparm->action, goto_ch);
>         cp_new =3D rcu_replace_pointer(ci->params, cp_new,
>                                      lockdep_is_held(&ci->tcf_lock));
> -       spin_unlock_bh(&ci->tcf_lock);
> +       spin_unlock(&ci->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index 6654011dcd2ba30769b2f52078373a834e259f88..ed7bdaa23f0d80caef6bd5cd5=
b9787e24ff2d1af 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -296,10 +296,10 @@ static int tcf_mpls_init(struct net *net, struct nl=
attr *nla,
>                                              htons(ETH_P_MPLS_UC));
>         p->action =3D parm->action;
>
> -       spin_lock_bh(&m->tcf_lock);
> +       spin_lock(&m->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         p =3D rcu_replace_pointer(m->mpls_p, p, lockdep_is_held(&m->tcf_l=
ock));
> -       spin_unlock_bh(&m->tcf_lock);
> +       spin_unlock(&m->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index 26241d80ebe03e74a92e951fb5ae065493b93277..9cc2a1772cf8290a4be7d6e69=
4e2ceccd48c386a 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -95,10 +95,10 @@ static int tcf_nat_init(struct net *net, struct nlatt=
r *nla, struct nlattr *est,
>
>         p =3D to_tcf_nat(*a);
>
> -       spin_lock_bh(&p->tcf_lock);
> +       spin_lock(&p->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         oparm =3D rcu_replace_pointer(p->parms, nparm, lockdep_is_held(&p=
->tcf_lock));
> -       spin_unlock_bh(&p->tcf_lock);
> +       spin_unlock(&p->tcf_lock);
>
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index 4b65901397a88864014f74c53d0fa00b40ac6613..8fc8f577cb7a8362fee60cd79=
cce263edca32a7a 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -280,10 +280,10 @@ static int tcf_pedit_init(struct net *net, struct n=
lattr *nla,
>
>         p =3D to_pedit(*a);
>         nparms->action =3D parm->action;
> -       spin_lock_bh(&p->tcf_lock);
> +       spin_lock(&p->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         oparms =3D rcu_replace_pointer(p->parms, nparms, 1);
> -       spin_unlock_bh(&p->tcf_lock);
> +       spin_unlock(&p->tcf_lock);
>
>         if (oparms)
>                 call_rcu(&oparms->rcu, tcf_pedit_cleanup_rcu);
> diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> index 8c1d1554f6575d3b0feae4d26ef4865d44a63e59..aa6b1744de21c1dca223cb87a=
919dc3e29841b83 100644
> --- a/net/sched/act_skbedit.c
> +++ b/net/sched/act_skbedit.c
> @@ -261,11 +261,11 @@ static int tcf_skbedit_init(struct net *net, struct=
 nlattr *nla,
>                 params_new->mask =3D *mask;
>
>         params_new->action =3D parm->action;
> -       spin_lock_bh(&d->tcf_lock);
> +       spin_lock(&d->tcf_lock);
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>         params_new =3D rcu_replace_pointer(d->params, params_new,
>                                          lockdep_is_held(&d->tcf_lock));
> -       spin_unlock_bh(&d->tcf_lock);
> +       spin_unlock(&d->tcf_lock);
>         if (params_new)
>                 kfree_rcu(params_new, rcu);
>         if (goto_ch)
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

