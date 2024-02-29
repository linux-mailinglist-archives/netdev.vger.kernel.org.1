Return-Path: <netdev+bounces-76284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4498D86D200
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26071F22EA7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896B7A121;
	Thu, 29 Feb 2024 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="quVg3Oy5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4CF78270
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230933; cv=none; b=XqOcl+iKQjLFZB+WAgfLXTSJfteyrukHL/hgtFYH5T4OVnHLkJ4eH0fWUq/CD5QKywLrayfh5ZlXckN+0XBsQbRSlRzPfV3pCds7A4dn2CriymWS5sEyO8moCRDrn9/nReWfe/Prh8aU14fSF5+Uw4sazu1qVbFcvNiGr2LuUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230933; c=relaxed/simple;
	bh=7dzpqAwFqsgMKxQV4RX9pSEBbENuidbafHfuEJoPZnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eecvUf1V5Z/jRrp9i2sQGmyl2ygqT3+H9B1RqnqoTUtRE6W6o7UWeGkcVoc/8aW4OiIjo5l8CLnHYgTWIqdx/J9iPBcgn33EsXewPwdeMeCG1x8LW8BF4qlSI/pCp1IbBCH2/p4u+Eb3mHsuvilWfwf9/5auYw02fuVm24k18zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=quVg3Oy5; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6096ab005c0so9121377b3.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709230930; x=1709835730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smc0ukzYCQtIMKyHsBRa/Mz/AXSRooQrgYXnFsUF8VE=;
        b=quVg3Oy5sQX/4xcZp8109eIVVG3zE6WZkxT6qJjTeNsxU0OoMN6L29ndeB7hdmvKJL
         9vKEmKhzSgCHWA7r2aZbZmVNzp8zZTByXla7RZb1M/zbMmb6WuISebYnWwEGplPAw7Ic
         Ub78fqI0A5OWr/BduCH9a/4TgvXpOa+49LQng3rY6//2/ZRzHmSf9Csh/0aHF9iovL32
         IoGTpbNjsvraPOAavmuWthhrwKC79nDebhdgKAoddVJfGspctAFWSCj9zmsVq+5N56G8
         HT5y4VwQ2q22lCAH5D2em+XoGhZp407cjAn3c/UBURhRIubLvPUthzVLhYCVUACCoAzH
         Wr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230930; x=1709835730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Smc0ukzYCQtIMKyHsBRa/Mz/AXSRooQrgYXnFsUF8VE=;
        b=UIn3bFYY3hJMnKCyjdtPKPuNqJaqMZLu4+nBZiKz2LN58i5mx3m1ekGzD0V+fkl+Z2
         OHQc3p984btjnWh0HGUuTecnwK+CL9l27uEOt39QpuH9qiLNYoO+ScLjPGsz+S4C1GhS
         Zp/mksvG9YmVfEVl22vh4Ur2bzUNrMyr7sGP556AO2L6DIsscHvwdBwwH5DAxLq7ivBt
         J0NgwfFLpX2r751QXT3Dzt16Oi9C+b2UB8mlaD+1nIsP2W2enfsyJ97pPiraTgyhPMxY
         pSnRNdxg6pUytdvkgpPHiE6aRK3w0mcnampfevvljIDlWB9YvTVKHZSk9fBfBEnReI+A
         SJvw==
X-Gm-Message-State: AOJu0YyjmdG6tSAg7vvfgHQCWhixhXLeGFKX/fsHks8y8tJZoBlVvkxw
	tkSMNEkB02xZYcveGf4QalGnqX0FZkmAsBQWjm6QVcKpYCcpQ8TC7g0Q2wMQFX/eov625Up7zHo
	lsyt/NmvGT57+yOdAl2FKPF8G/ILBMACSDvIg
X-Google-Smtp-Source: AGHT+IFbZxS+A+uNkuH1f3efwUxOTWD76R3r3zbGnAYEN66bmkaDwZjH3YAdtPbkWnS97YoquPVvXJKipIcupW6zeno=
X-Received: by 2002:a81:72d6:0:b0:609:77f0:ff40 with SMTP id
 n205-20020a8172d6000000b0060977f0ff40mr1463243ywc.20.1709230930192; Thu, 29
 Feb 2024 10:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-2-jhs@mojatatu.com>
 <c771211a5e62dcaf2e2b7525788958036a4280fa.camel@redhat.com>
In-Reply-To: <c771211a5e62dcaf2e2b7525788958036a4280fa.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Feb 2024 13:21:58 -0500
Message-ID: <CAM0EoM=t6gaY6d0EOtmMGwb=GtLjcuBqS3qjupeb_hi0HuODQA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/15] net: sched: act_api: Introduce P4
 actions list
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 10:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> > In P4 we require to generate new actions "on the fly" based on the
> > specified P4 action definition. P4 action kinds, like the pipeline
> > they are attached to, must be per net namespace, as opposed to native
> > action kinds which are global. For that reason, we chose to create a
> > separate structure to store P4 actions.
> >
> > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > ---
> >  include/net/act_api.h |   8 ++-
> >  net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
> >  net/sched/cls_api.c   |   2 +-
> >  3 files changed, 116 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/net/act_api.h b/include/net/act_api.h
> > index 77ee0c657..f22be14bb 100644
> > --- a/include/net/act_api.h
> > +++ b/include/net/act_api.h
> > @@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *pri=
v);
> >
> >  struct tc_action_ops {
> >       struct list_head head;
> > +     struct list_head p4_head;
> >       char    kind[IFNAMSIZ];
> >       enum tca_id  id; /* identifier should match kind */
> >       unsigned int    net_id;
> > @@ -199,10 +200,12 @@ int tcf_idr_check_alloc(struct tc_action_net *tn,=
 u32 *index,
> >  int tcf_idr_release(struct tc_action *a, bool bind);
> >
> >  int tcf_register_action(struct tc_action_ops *a, struct pernet_operati=
ons *ops);
> > +int tcf_register_p4_action(struct net *net, struct tc_action_ops *act)=
;
> >  int tcf_unregister_action(struct tc_action_ops *a,
> >                         struct pernet_operations *ops);
> >  #define NET_ACT_ALIAS_PREFIX "net-act-"
> >  #define MODULE_ALIAS_NET_ACT(kind)   MODULE_ALIAS(NET_ACT_ALIAS_PREFIX=
 kind)
> > +void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *a=
ct);
> >  int tcf_action_destroy(struct tc_action *actions[], int bind);
> >  int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
> >                   int nr_actions, struct tcf_result *res);
> > @@ -210,8 +213,9 @@ int tcf_action_init(struct net *net, struct tcf_pro=
to *tp, struct nlattr *nla,
> >                   struct nlattr *est,
> >                   struct tc_action *actions[], int init_res[], size_t *=
attr_size,
> >                   u32 flags, u32 fl_flags, struct netlink_ext_ack *exta=
ck);
> > -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags=
,
> > -                                      struct netlink_ext_ack *extack);
> > +struct tc_action_ops *
> > +tc_action_load_ops(struct net *net, struct nlattr *nla,
> > +                u32 flags, struct netlink_ext_ack *extack);
> >  struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto =
*tp,
> >                                   struct nlattr *nla, struct nlattr *es=
t,
> >                                   struct tc_action_ops *a_o, int *init_=
res,
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index 9ee622fb1..23ef394f2 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
> > @@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
> >       kfree(cookie);
> >  }
> >
> > +static unsigned int p4_act_net_id;
> > +
> > +struct tcf_p4_act_net {
> > +     struct list_head act_base;
> > +     rwlock_t act_mod_lock;
>
> Note that rwlock in networking code is discouraged, as they have to be
> unfair, see commit 0daf07e527095e64ee8927ce297ab626643e9f51.
>
> In this specific case I think there should be no problems, as is
> extremely hard/impossible to have serious contention on the write
> side,. Also there is already an existing rwlock nearby, no not a
> blocker but IMHO worthy to be noted.
>

Sure - we can replace it. What's the preference? Spinlock?

cheers,
jamal

> Cheers,
>
> Paolo
>

