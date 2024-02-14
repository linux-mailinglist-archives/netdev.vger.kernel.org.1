Return-Path: <netdev+bounces-71696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02546854CAF
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800C81F21704
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44AC5C8FE;
	Wed, 14 Feb 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OE5B3r9U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20F5A0FB
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924524; cv=none; b=T7bJHklO2qa02zfn4ZZODfsIcJogTZFUP9CGPX66dvY5bCohawHTWfYJHQclnG69xDxZKZYfc7YsF6RbHS5OeWgt7v2d1MoM+Hwi70TwpZjc2ZOuiwE7LA1CHK0ZGUbST+1SlkmUXVebd3tsf0YCntUFalyxG3flPNpucBYOMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924524; c=relaxed/simple;
	bh=G15TqHdEE144bOIh/z8f8dKP6Vvk9CUAmr6zfPfDjsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJmqIt8/ugdfnELk8friICW7SVsdfdgRHg82XeEazIi1/t9Cqf3Q2R0VX/MEeHzd/56sGPlDHVjdjQ5f6/gju286p9okrDL1zPLYVhmC0YPD1d8VdAcg2eyutYOVbmcREa/aG9tcwgcJBwcVK8bRs+2iZ7DSf+qLQj1J60x6RVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OE5B3r9U; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6079d44b02bso13214427b3.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707924519; x=1708529319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FecxPQNxYeinCZmHFCm1giAbRlI+/nh934wisu/Qa7U=;
        b=OE5B3r9UTLTDz2g8sAFrhZIuscVnkdUykdaQ0b2flxkImuzhgtlq5hl1pVSiKZunKw
         YeC8v5cHhH5SFvwo8LKB0t2pPQbO/+GpGwpDKg2cQQDO26fJIoJKVnaTfime2OwMBDT2
         owq0M7bec6E/1C4WDGJqjwRxvA0cZ3D+XL1B+8HoprxiGv/75ErZIYsUGycN48/yIQVf
         l4y0BvnHQFc/KESGfhx1nvuZfcbRkCWd+MiP91HmQQLySgJbcQGqa9L1euQKJs31Jq9y
         v6oY7/Pyn1poTA4J9pZk5xTvkkWiMqNMrKkQQlX79IW+qhx2NzNjakl/phvQhotO/Tf2
         SpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924519; x=1708529319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FecxPQNxYeinCZmHFCm1giAbRlI+/nh934wisu/Qa7U=;
        b=dqvao0ePtDts3E5TW1t4xXVCQYfpYcORAuaLe3bx/XSXhCNz7wRj5CGwO0bqX/k7Hd
         NiXtFdVxvl5PEEF8BYJPyR/g7/OaczlpNH7IXCI2wdlvs0+BDing4t+xofqZQxVqo3h4
         oOMS8OuPbCLVuZqbUvi86TqzFbs4mArJukO3/0rDTzfnbeLZVE8HCoOGJ0d1QvASDvtD
         iiMiNtCn8PbYGwQErm4CbQ1eAFxKnhmhgWP6MaCA7c/K61wc0T1gB8e7p8WgWjh9rJ6d
         xgz7haTFUaigzRPfEoOMIChvCcU0qyxzh8HHnGUOuPTJSfOY7VF1bo74BtzIQwwm3sJJ
         ik6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXR2i7kpCkWQ7xsKHwQwOJtikbdg2GSAbwd7hdwrsn8xGjq2jP/OM0DWl2z3sAOdrVL0SYGimITarW38J8FT3hpZx+GVbm+
X-Gm-Message-State: AOJu0YxVVcG0bJX2U9aiOD6V4UMqh0Nopl/uXARbH+q+JNXeQ4dNp6GS
	ALNB/xgpU0YgdAkRYbamhoWT4dqxdR0ZIJ+CuHUhd1TCSSY6AEWyEuv7nhUKNDZgMwdKpXVTqHd
	jARuc+tsZjezkxjeRvzPAQQMOOzlGA/bSw5Ol
X-Google-Smtp-Source: AGHT+IHYY5MzHmMMDJ297wAodxBpGbmhBxY0La57nDfdeHjwDI15NToZMPGTZKCySVIXQrTqIYwqfXBkDmYbzBnydUY=
X-Received: by 2002:a81:7241:0:b0:604:9322:9d56 with SMTP id
 n62-20020a817241000000b0060493229d56mr2665002ywc.38.1707924518788; Wed, 14
 Feb 2024 07:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209235413.3717039-1-kuba@kernel.org> <CAM0EoMmXrLv4aPo1btG2_oi4fTX=gZzO90jyHQzWvM26ZUFbww@mail.gmail.com>
In-Reply-To: <CAM0EoMmXrLv4aPo1btG2_oi4fTX=gZzO90jyHQzWvM26ZUFbww@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 14 Feb 2024 10:28:27 -0500
Message-ID: <CAM0EoM=sUpX1yOL7yO5Z4UGOakxw1+GK97yqs4U5WyOy7U+SxQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred ingress
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Davide Caratti <dcaratti@redhat.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shmulik.ladkani@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:11=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Fri, Feb 9, 2024 at 6:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > The test Davide added in commit ca22da2fbd69 ("act_mirred: use the back=
log
> > for nested calls to mirred ingress") hangs our testing VMs every 10 or =
so
> > runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> > lockdep.
> >
> > In the past there was a concern that the backlog indirection will
> > lead to loss of error reporting / less accurate stats. But the current
> > workaround does not seem to address the issue.
> >
> > Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions"=
)
> > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > Suggested-by: Davide Caratti <dcaratti@redhat.com>
> > Link: https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8=
aae226.1663945716.git.dcaratti@redhat.com/
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > CC: jhs@mojatatu.com
> > CC: xiyou.wangcong@gmail.com
> > CC: jiri@resnulli.us
> > CC: shmulik.ladkani@gmail.com
> > ---
> >  net/sched/act_mirred.c                             | 14 +++++---------
> >  .../testing/selftests/net/forwarding/tc_actions.sh |  3 ---
> >  2 files changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index 93a96e9d8d90..35c366f043d9 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -232,18 +232,14 @@ static int tcf_mirred_init(struct net *net, struc=
t nlattr *nla,
> >         return err;
> >  }
> >
> > -static bool is_mirred_nested(void)
> > -{
> > -       return unlikely(__this_cpu_read(mirred_nest_level) > 1);
> > -}
> > -
> > -static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
> > +static int
> > +tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff =
*skb)
> >  {
> >         int err;
> >
> >         if (!want_ingress)
> >                 err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
> > -       else if (is_mirred_nested())
> > +       else if (!at_ingress)
> >                 err =3D netif_rx(skb);
> >         else
> >                 err =3D netif_receive_skb(skb);
> > @@ -319,9 +315,9 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, s=
truct tcf_mirred *m,
> >
> >                 skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingr=
ess);
> >
> > -               err =3D tcf_mirred_forward(want_ingress, skb_to_send);
> > +               err =3D tcf_mirred_forward(at_ingress, want_ingress, sk=
b_to_send);
> >         } else {
> > -               err =3D tcf_mirred_forward(want_ingress, skb_to_send);
> > +               err =3D tcf_mirred_forward(at_ingress, want_ingress, sk=
b_to_send);
> >         }
> >
> >         if (err) {
> > diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/too=
ls/testing/selftests/net/forwarding/tc_actions.sh
> > index b0f5e55d2d0b..589629636502 100755
> > --- a/tools/testing/selftests/net/forwarding/tc_actions.sh
> > +++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
> > @@ -235,9 +235,6 @@ mirred_egress_to_ingress_tcp_test()
> >         check_err $? "didn't mirred redirect ICMP"
> >         tc_check_packets "dev $h1 ingress" 102 10
> >         check_err $? "didn't drop mirred ICMP"
> > -       local overlimits=3D$(tc_rule_stats_get ${h1} 101 egress .overli=
mits)
> > -       test ${overlimits} =3D 10
> > -       check_err $? "wrong overlimits, expected 10 got ${overlimits}"
> >
> >         tc filter del dev $h1 egress protocol ip pref 100 handle 100 fl=
ower
> >         tc filter del dev $h1 egress protocol ip pref 101 handle 101 fl=
ower
> > --
> > 2.43.0
> >
>
>
> Doing a quick test of this and other patch i saw..


So tests pass - but on the list i only see one patch and the other is
on lore, not sure how to ACK something that is not on email, but FWIW:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

The second patch avoids the recursion issue (which was the root cause)
and the first patch is really undoing ca22da2fbd693
I dont know underlying issue in ca22da2fbd693 is solved (and dont have
time to look into it). Davide?

cheers,
jamal

> cheers,
> jamal

