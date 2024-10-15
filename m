Return-Path: <netdev+bounces-135899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64C99FB39
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EE9283B7A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3E1B0F0F;
	Tue, 15 Oct 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PEY7qMYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1F21E3DB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030602; cv=none; b=Yz24dJp3pCQm6n0mGXeebZ6GPyepIgmJ8CEKcxyse4qty68gFNEgqiazUUw/027H7kiep90dsYl5j2k81XQazPx7GlLf989EJ7vAly4Ra+yh77rJo7/8LCSPezvr+m6OLeBZQtZp7/MMkiLShp0KjGYEsdtumRdd35eZZgPqmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030602; c=relaxed/simple;
	bh=hAXhPSiFEzq/5C5oDsoq2csifhVliKPy6KZ87upJlBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS/KsRJZY30EIxKW1fMa+GiVhlTGvtpfXpKpbajvkjDQnmNGoNnBSHl8dYTpHXlEHloPl1JOEwZsThIQW7NFteKtsUBFwLIHYlMKrFpD41oeZ5ms2nAPwMbZEUMtg+XaPE7YED0YZgKfOrauVvu+5w3z5zXjIAZ9maLWRgc52XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PEY7qMYr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e7086c231so1458121b3a.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1729030599; x=1729635399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIVUa6cza5As2WnLp7U7w9Jj8bSiKZ0fCkvvBrUYIew=;
        b=PEY7qMYrap/wb48FZNfeBwE/zCdjd6qwwLIfyFkv288uJ5EofInI2ocpEh9Ochfa+4
         wQNvydvyZEwauH4J3CmkTwTsovoNZY8l3bMBYncDqTC354LmJ5guEQ1w+hAdtvli2J3b
         QVGeeOiWT2eH2NpdNKtg1+D2J8r0d5Rh4EoMQUuFmjd7VV9X4srCZrha8PC5pfCoAq9S
         MUp8cpDxAXdYm6fGzTRDYiK2BImHODu5qMbAq8kbzrUs/RFQkfe8ipYXTek4mSZxGKiJ
         UHQxjtklG3u1jaOHWRcjhuB/oXyOBNAg8obd3HEJbI6KcJDmm0sK4PEj8QeoCf4V38+0
         MwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729030599; x=1729635399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIVUa6cza5As2WnLp7U7w9Jj8bSiKZ0fCkvvBrUYIew=;
        b=GdW/goXqr7eBWOH+howH6jddaUQBQ72kQfZllcfqZ6lLJZSBECOVmTunVk9fwtk7r0
         /vWFpvgiNz1VniQVwZ6Fmr4wPDNBpJgpPq7lfsh8GhOAR1DZgtt+9zURseB0rCI6QQpT
         3Gl17mDxfTpFICnWuqJ8dZoqu7QWJasE0aQyD3g8DC/wM6oovGPfSSkAseQ07AUbd5e8
         5xrU/D+MEvVkMYcFaXYgztiDW2MhQ9I1Zi5+HiCA6Y76+5AtFICauv0xgWTVavuzJlPR
         UcddSKZByZF9G49sWW6bdIVzy0lQzhvLJ6IH142/mUpeaFawdVPt7G1oj4SZs0KDzWw4
         FpWg==
X-Forwarded-Encrypted: i=1; AJvYcCXuM2tAd5A0OU2wPnO3LfIk4edcp0AZM98r92QtKNuWEHwo9dIGORjhuCAjEeDUTxo0rqmFsRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSVdSbPiu4HvPM/9hgmvW5l4l0jkylmBgDV0drSf2Ku1GRlRj
	YrTblF3ZMgVssbnVbsO7kRIKiLgRd9CXw822sM8PnOVB7fitG/7MWH17vnZH+SbuBGXC2jlEkdF
	EYQJ6xLaVB4S3Oy/u09ybxktMtSd0zjnG1/da
X-Google-Smtp-Source: AGHT+IH3BXX+JcNRfkJENr9XGmKh9x735MwNRDflhh6VSEZcWFiIDCp6gqxA3ieR1ImXFm5ypzu7lZLNX6MqSYCxTCQ=
X-Received: by 2002:a05:6a00:3cca:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-71e7da25185mr3031687b3a.8.1729030599152; Tue, 15 Oct 2024
 15:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-5-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-5-kuniyu@amazon.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 15 Oct 2024 18:16:28 -0400
Message-ID: <CAM0EoMkAns=QXc-Lh3gkRmJ4SrGbbKpSbaSy5Btv7uw0NTUYUA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 04/11] net: sched: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will remove rtnl_register() in favour of rtnl_register_many().
>
> When it succeeds, rtnl_register_many() guarantees all rtnetlink types
> in the passed array are supported, and there is no chance that a part
> of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
>
> v2:
>   * Add __initconst
>   * Use C99 initialisation
> ---
>  net/sched/act_api.c | 13 ++++++++-----
>  net/sched/cls_api.c | 25 ++++++++++++++-----------
>  net/sched/sch_api.c | 20 ++++++++++++--------
>  3 files changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 2714c4ed928e..5bbfb83ed600 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -2243,13 +2243,16 @@ static int tc_dump_action(struct sk_buff *skb, st=
ruct netlink_callback *cb)
>         return skb->len;
>  }
>
> +static const struct rtnl_msg_handler tc_action_rtnl_msg_handlers[] __ini=
tconst =3D {
> +       {.msgtype =3D RTM_NEWACTION, .doit =3D tc_ctl_action},
> +       {.msgtype =3D RTM_DELACTION, .doit =3D tc_ctl_action},
> +       {.msgtype =3D RTM_GETACTION, .doit =3D tc_ctl_action,
> +        .dumpit =3D tc_dump_action},
> +};
> +
>  static int __init tc_action_init(void)
>  {
> -       rtnl_register(PF_UNSPEC, RTM_NEWACTION, tc_ctl_action, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_DELACTION, tc_ctl_action, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_ac=
tion,
> -                     0);
> -
> +       rtnl_register_many(tc_action_rtnl_msg_handlers);
>         return 0;
>  }
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 17d97bbe890f..7637f979d689 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -4055,6 +4055,19 @@ static struct pernet_operations tcf_net_ops =3D {
>         .size =3D sizeof(struct tcf_net),
>  };
>
> +static const struct rtnl_msg_handler tc_filter_rtnl_msg_handlers[] __ini=
tconst =3D {
> +       {.msgtype =3D RTM_NEWTFILTER, .doit =3D tc_new_tfilter,
> +        .flags =3D RTNL_FLAG_DOIT_UNLOCKED},
> +       {.msgtype =3D RTM_DELTFILTER, .doit =3D tc_del_tfilter,
> +        .flags =3D RTNL_FLAG_DOIT_UNLOCKED},
> +       {.msgtype =3D RTM_GETTFILTER, .doit =3D tc_get_tfilter,
> +        .dumpit =3D tc_dump_tfilter, .flags =3D RTNL_FLAG_DOIT_UNLOCKED}=
,
> +       {.msgtype =3D RTM_NEWCHAIN, .doit =3D tc_ctl_chain},
> +       {.msgtype =3D RTM_DELCHAIN, .doit =3D tc_ctl_chain},
> +       {.msgtype =3D RTM_GETCHAIN, .doit =3D tc_ctl_chain,
> +        .dumpit =3D tc_dump_chain},
> +};
> +
>  static int __init tc_filter_init(void)
>  {
>         int err;
> @@ -4068,17 +4081,7 @@ static int __init tc_filter_init(void)
>                 goto err_register_pernet_subsys;
>
>         xa_init_flags(&tcf_exts_miss_cookies_xa, XA_FLAGS_ALLOC1);
> -
> -       rtnl_register(PF_UNSPEC, RTM_NEWTFILTER, tc_new_tfilter, NULL,
> -                     RTNL_FLAG_DOIT_UNLOCKED);
> -       rtnl_register(PF_UNSPEC, RTM_DELTFILTER, tc_del_tfilter, NULL,
> -                     RTNL_FLAG_DOIT_UNLOCKED);
> -       rtnl_register(PF_UNSPEC, RTM_GETTFILTER, tc_get_tfilter,
> -                     tc_dump_tfilter, RTNL_FLAG_DOIT_UNLOCKED);
> -       rtnl_register(PF_UNSPEC, RTM_NEWCHAIN, tc_ctl_chain, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_DELCHAIN, tc_ctl_chain, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_GETCHAIN, tc_ctl_chain,
> -                     tc_dump_chain, 0);
> +       rtnl_register_many(tc_filter_rtnl_msg_handlers);
>
>         return 0;
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 2eefa4783879..da2da2ab858b 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -2420,6 +2420,17 @@ static struct pernet_operations psched_net_ops =3D=
 {
>  DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
>  #endif
>
> +static const struct rtnl_msg_handler psched_rtnl_msg_handlers[] __initco=
nst =3D {
> +       {.msgtype =3D RTM_NEWQDISC, .doit =3D tc_modify_qdisc},
> +       {.msgtype =3D RTM_DELQDISC, .doit =3D tc_get_qdisc},
> +       {.msgtype =3D RTM_GETQDISC, .doit =3D tc_get_qdisc,
> +        .dumpit =3D tc_dump_qdisc},
> +       {.msgtype =3D RTM_NEWTCLASS, .doit =3D tc_ctl_tclass},
> +       {.msgtype =3D RTM_DELTCLASS, .doit =3D tc_ctl_tclass},
> +       {.msgtype =3D RTM_GETTCLASS, .doit =3D tc_ctl_tclass,
> +        .dumpit =3D tc_dump_tclass},
> +};
> +
>  static int __init pktsched_init(void)
>  {
>         int err;
> @@ -2438,14 +2449,7 @@ static int __init pktsched_init(void)
>         register_qdisc(&mq_qdisc_ops);
>         register_qdisc(&noqueue_qdisc_ops);
>
> -       rtnl_register(PF_UNSPEC, RTM_NEWQDISC, tc_modify_qdisc, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_DELQDISC, tc_get_qdisc, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_GETQDISC, tc_get_qdisc, tc_dump_qdis=
c,
> -                     0);
> -       rtnl_register(PF_UNSPEC, RTM_NEWTCLASS, tc_ctl_tclass, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_DELTCLASS, tc_ctl_tclass, NULL, 0);
> -       rtnl_register(PF_UNSPEC, RTM_GETTCLASS, tc_ctl_tclass, tc_dump_tc=
lass,
> -                     0);
> +       rtnl_register_many(psched_rtnl_msg_handlers);
>
>         tc_wrapper_init();
>
> --
> 2.39.5 (Apple Git-154)
>

