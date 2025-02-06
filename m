Return-Path: <netdev+bounces-163460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC740A2A4D4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E751681CD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1222619C;
	Thu,  6 Feb 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmoTe0I8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2B22619B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834887; cv=none; b=nFaBdkD9XJMoB0JH69saz414BdIyrqYHVXm0HwgY+JFkrwhn+vwTjZTNZE+cDdTvTfCzfJdPxOnz+Qo/t+qyXfduC3wkGBPNE6A6KQko/wXp1da+pXNPctNV69mYwcVwWDjeP4SmrtDvY+eqJaFTmkgg4VVKoPvloJ6VBHHNHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834887; c=relaxed/simple;
	bh=jtLt/dRuzFiFHWomZrfU6yWb/fWaQh0u+glRmdhCZWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU1Snb7HQcbwqHUNbIx45Ls8UepW7EiLiu9/36XrL6Xk/9grtC5p72i8LGV3t5fRqYhVntmzxlM3hfwHSrU8NshSvt2PHcbGQdeXz2LJyAVvvlSQq/D2T6wDBv5xgvz1lb+0hnj8aMmXCx1yqG0Dy+9NVC/e4kXBEaIuVZnX25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmoTe0I8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab698eae2d9so131536366b.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 01:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738834883; x=1739439683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NddqNv4Pau9wOr59qjmWUXeRiRiJNiOri0Qk9P7aMHs=;
        b=CmoTe0I8WJbNaAuqGhFvjwwvna85Ras/F6sc56bl2tCdMCjIZVV9cPKhq4d9ykyXYY
         ZWJ6Gi/wTLLmb/bm2tACWPSDfSRPSE6BGTcY2aBNMRuO9Vn0NEaGpIiRupfB8T7HEdvg
         xJdXFjNyvZe4OzuS4rCUL840wOU1U7cFloi4/pnGCkNoKyK6jt3jifCc0TCmw2IFM6wX
         D86yHiKY2H45rXdRsG0KmkLstp9XG50uRes40UnveRlz/8BFAQzfL6wDjwC8dJXCjA9b
         6j6kKWsFWSuzhmNJJ9aTGpEpneCOdg7gh8lsE7c6UlGKKo2bQa7D7c8eZWXb3upsN1Fx
         EKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834883; x=1739439683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NddqNv4Pau9wOr59qjmWUXeRiRiJNiOri0Qk9P7aMHs=;
        b=CeoAZ7mkoph57P7csctTZkRXqTumi2JhXinY+FsNfndWefM2KSWh5VNcPuLoiqbqZL
         xPrh9mZKaobkG2NyuPC7KLu4Y2ussvMY9jLuGZSqQlH3LSjC78MP4M1dkaDHZR2y+FTd
         de/3DJaCZC4J8mnDmYp+XfLq+KDqW2UjyEJbnnr3EYoIFMzGW6IgCBIUMDjVw3JJt98b
         2G2PXDGm4uuFlZU+/TVELuSdg0L27tPMt+UrYZqwyeN3HLjl6UYZaHfBHdrskYyCqovT
         qH1+ttmfQSfW1Lf4Icdhm09C7nqx/bQxEzdiiqE8MVDu+9YOcspjro6BSBKIFIke7Otz
         TyVg==
X-Forwarded-Encrypted: i=1; AJvYcCWUFuIcLvqs5BS/qmoa2+AE5jeHDGZThb/qpCSyMbO59T/WGDiR4X6Ksmcgh3FH2OB9LPBdeeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJ8PMELNwfhGMAQ+hmbnpqOznEyzhTk9JgNnjl2T2H297vmRL
	KRdbMJtTGLASv5Mk/uKc4YZA5ESe0EoCnK6vnhhHmp+pADcvLX8cy9nJ95BE3LcmkpJpDa4/EBj
	3btUTkYfjVTb+1FIzZZ4ksxHtLT4gQeQ37zf4bLA7yHJkBfQQs3Dv
X-Gm-Gg: ASbGncvJ11/BOGolBnpKROh2weGYr0SpyEjzdQifNQ0Y68LvQZ3zLjqQ8Oo2sEKXmi/
	20wmllZIHqXjgsm/x7BO3Ipg4j9BKtoTYEU7qpLiCUG2CfrIo/E3kJ1QopbBS3UDrfZ+nw8nnlg
	==
X-Google-Smtp-Source: AGHT+IGMe5GXEms8qOskQxcWhmZpsVp2PlhXWEgPixVhwrxbtSgThR9dZ5t65y5LrYgCRpg22ZSl3nbelMB/0Zc4eZs=
X-Received: by 2002:a17:907:1c90:b0:aab:ee4a:6788 with SMTP id
 a640c23a62f3a-ab75e32d97emr649532266b.57.1738834883233; Thu, 06 Feb 2025
 01:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206084629.16602-1-kuniyu@amazon.com> <20250206084629.16602-7-kuniyu@amazon.com>
In-Reply-To: <20250206084629.16602-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 10:41:12 +0100
X-Gm-Features: AWEUYZlStskq-COu74lKPjgUz7GZGgh0jKph91wq0qwsPRPY6hmYxPYm7E-hkjg
Message-ID: <CANn89iLhtzeM+0oO_SQuK5sbj_ueVk63wE37qhS84wPdc-jbzw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 6/6] fib: rules: Convert RTM_DELRULE to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> fib_nl_delrule() is the doit() handler for RTM_DELRULE but also called
> 1;95;0cfrom vrf_newlink() in case something fails in vrf_add_fib_rules().
>
> In the latter case, RTNL is already held and the 3rd arg extack is NULL.
>
> Let's hold per-netns RTNL in fib_nl_delrule() if extack is NULL.
>
> Now we can place ASSERT_RTNL_NET() in call_fib_rule_notifiers().
>
> While at it, fib_rule r is moved to the suitable scope.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/core/fib_rules.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> index cc26c762fa9e..3430d026134d 100644
> --- a/net/core/fib_rules.c
> +++ b/net/core/fib_rules.c
> @@ -371,7 +371,8 @@ static int call_fib_rule_notifiers(struct net *net,
>                 .rule =3D rule,
>         };
>
> -       ASSERT_RTNL();
> +       ASSERT_RTNL_NET(net);

This warning will then fire in the vrf case, because vrf_fib_rule() is
only holding the real RTNL,
but not yet the net->rtnl_mutex ?

> +
>         /* Paired with READ_ONCE() in fib_rules_seq() */
>         WRITE_ONCE(ops->fib_rules_seq, ops->fib_rules_seq + 1);
>         return call_fib_notifiers(net, event_type, &info.info);
> @@ -909,13 +910,13 @@ EXPORT_SYMBOL_GPL(fib_nl_newrule);
>  int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
>                    struct netlink_ext_ack *extack)
>  {
> -       struct net *net =3D sock_net(skb->sk);
> +       bool user_priority =3D false, hold_rtnl =3D !!extack;

I am not pleased with this heuristic hidden here.

At the very least a fat comment in drivers/net/vrf.c would be welcomed.


> +       struct fib_rule *rule =3D NULL, *nlrule =3D NULL;
>         struct fib_rule_hdr *frh =3D nlmsg_data(nlh);
> +       struct net *net =3D sock_net(skb->sk);
>         struct fib_rules_ops *ops =3D NULL;
> -       struct fib_rule *rule =3D NULL, *r, *nlrule =3D NULL;
>         struct nlattr *tb[FRA_MAX+1];
>         int err =3D -EINVAL;
> -       bool user_priority =3D false;
>
>         if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
>                 NL_SET_ERR_MSG(extack, "Invalid msg length");
> @@ -940,6 +941,9 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsgh=
dr *nlh,
>         if (err)
>                 goto errout;
>
> +       if (hold_rtnl)
> +               rtnl_net_lock(net);
> +
>         err =3D fib_nl2rule_rtnl(nlrule, ops, tb, extack);
>         if (err)
>                 goto errout_free;
> @@ -980,7 +984,7 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsgh=
dr *nlh,
>          * current if it is goto rule, have actually been added.
>          */
>         if (ops->nr_goto_rules > 0) {
> -               struct fib_rule *n;
> +               struct fib_rule *n, *r;
>
>                 n =3D list_next_entry(rule, list);
>                 if (&n->list =3D=3D &ops->rules_list || n->pref !=3D rule=
->pref)
> @@ -994,10 +998,12 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlms=
ghdr *nlh,
>                 }
>         }
>
> -       call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops,
> -                               NULL);
> -       notify_rule_change(RTM_DELRULE, rule, ops, nlh,
> -                          NETLINK_CB(skb).portid);
> +       call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops, NULL)=
;
> +
> +       if (hold_rtnl)
> +               rtnl_net_unlock(net);
> +
> +       notify_rule_change(RTM_DELRULE, rule, ops, nlh, NETLINK_CB(skb).p=
ortid);
>         fib_rule_put(rule);
>         flush_route_cache(ops);
>         rules_ops_put(ops);
> @@ -1005,6 +1011,8 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlms=
ghdr *nlh,
>         return 0;
>
>  errout_free:
> +       if (hold_rtnl)
> +               rtnl_net_unlock(net);
>         kfree(nlrule);
>  errout:
>         rules_ops_put(ops);
> @@ -1324,7 +1332,8 @@ static struct pernet_operations fib_rules_net_ops =
=3D {
>  static const struct rtnl_msg_handler fib_rules_rtnl_msg_handlers[] __ini=
tconst =3D {
>         {.msgtype =3D RTM_NEWRULE, .doit =3D fib_nl_newrule,
>          .flags =3D RTNL_FLAG_DOIT_PERNET},
> -       {.msgtype =3D RTM_DELRULE, .doit =3D fib_nl_delrule},
> +       {.msgtype =3D RTM_DELRULE, .doit =3D fib_nl_delrule,
> +        .flags =3D RTNL_FLAG_DOIT_PERNET},
>         {.msgtype =3D RTM_GETRULE, .dumpit =3D fib_nl_dumprule,
>          .flags =3D RTNL_FLAG_DUMP_UNLOCKED},
>  };
> --
> 2.39.5 (Apple Git-154)
>

