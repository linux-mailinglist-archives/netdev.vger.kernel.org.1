Return-Path: <netdev+bounces-71694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD7854C3E
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB3E28C9DB
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D235B217;
	Wed, 14 Feb 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OmdnEJrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A505C5EE
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923499; cv=none; b=JqFJlYPr+RfDdqCHWy6KVw7vs4R2vD1P0hPPy+Z7VvySls7b1duf78pHvoOpQsuIzucisCV5hmTOl/BtCx0UunKsprngij7zrL54emCapGHVMQDZYv6n6c1T1FQKv3ew1G39C6eafKSjVB2lJXXyhqgJQgGDqIf//TPyHNZwv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923499; c=relaxed/simple;
	bh=NlmnNxzYMDE3zUOi4zUyM8+w91Y9ltOpfN/PBei7Ls0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUhFlshNut4Z3LbgaA44h6ThzZfNmtiUiUHb/GDMeMB3YuJr4kk3YJIGbW9Is5GfG+JbgIcjj8Xayu84nHlinRC4by3cSd64kWrIddKrwh/QQFn7xTNuE4Bur7vC+9XnoUfB3w1j1v2kTm6mUXmPIzQZDEx0qdZqDkpkR1hT+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OmdnEJrW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so4863966276.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707923496; x=1708528296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRZ47wKSuUBPjFaDfePVn0mV4MMgGRTUygA9eUMdTeQ=;
        b=OmdnEJrWItcw3Mc+UIJCbpGnaJJ+i5x29HVfZwszW/JrZ+YUv9vJKogrUhC003O80C
         01tFjPgDvag/9rHtJQWJ+iDyhNtTlNzKiU6DquSlbNLLrhpwWQyLlJygQ9sXVkslXR+y
         E6brq457wpd+eF7lRz00/Gr7S5XOlNy4LZlulVx/EoJWnJtwYnKzfuokRC1t1v+cVzK8
         CbslGYjzgfJMPyNVQ9/H3N9GMTOUHiEoaVkgyxBbtmx5tiWD76V1JZqUcUPioamPPs9C
         eyG5g76CyeeXJYJtOvIcTk2VEG1ywf9Sgpe9+OvvAIOyxc7+3CHE1KxL4eFBaPj+SpVz
         ZC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923496; x=1708528296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRZ47wKSuUBPjFaDfePVn0mV4MMgGRTUygA9eUMdTeQ=;
        b=goJjwslgqGtrDZRr31TAPC1UymlBhbpg7u8vH0g+mlbh3yQe9E0NDoJSBTbsdIj87V
         kC3SDaLJVjoQx+ZvuUyFgY+AB5pvNS2k1s7pZpScQJlFhGAKc6pV0MS94qG86q0pWncW
         Ah1xOck6w5/eu7V0Rwzf6eJgtxPdP12nUcCogTIxS5O9la8XRBHAm3BO+nt6gHS24ASv
         j8LVIu6HVR1cTDMoxTy6VBxXaa+wuDBoOu0Y2ey1yyCL+5kaYgtICYGSyFXbA+I4O1YH
         gncC+1tWpQ/AHbT4kwyGXbKHFM+7H1lc6L+cts8rOjzxeTa8wH4XmfgkivGsCaK+1u+C
         tQcw==
X-Forwarded-Encrypted: i=1; AJvYcCX35sEPP91JJ2BkycJnRRmU7YDaqFBmRBf3F0PRuow6JsTOUwtNROWYmgqjI8ParJw/UsFaZ2rCokgfjt5MdFk8Vj+aK2gB
X-Gm-Message-State: AOJu0YwwXCP4jV5r9gZRkAs++C3Iab/7g9sabSshkdxndgeDVxp2xCVj
	yDpYah+sf4WsVvhxxue5LXJZqdvYJ7IIEeaCPT27UVERQr9qtpR1xr0N89JXLMdknpCgo3BbLSB
	1IHAynzjKrFBh1Tuny9jTX+GEId71xkPMIAhv
X-Google-Smtp-Source: AGHT+IH6DPwGZc4SW8uZ9j0NhNVWXf3L8NywmcOi6VaxoYIstlA9eiC14SeAdxZgx5dr5TQhMZ+WhV7kvbtnKLWuZjc=
X-Received: by 2002:a81:a14c:0:b0:607:9504:ebf6 with SMTP id
 y73-20020a81a14c000000b006079504ebf6mr3008504ywg.0.1707923496486; Wed, 14 Feb
 2024 07:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209235413.3717039-1-kuba@kernel.org>
In-Reply-To: <20240209235413.3717039-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 14 Feb 2024 10:11:25 -0500
Message-ID: <CAM0EoMmXrLv4aPo1btG2_oi4fTX=gZzO90jyHQzWvM26ZUFbww@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred ingress
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Davide Caratti <dcaratti@redhat.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shmulik.ladkani@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlo=
g
> for nested calls to mirred ingress") hangs our testing VMs every 10 or so
> runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> lockdep.
>
> In the past there was a concern that the backlog indirection will
> lead to loss of error reporting / less accurate stats. But the current
> workaround does not seem to address the issue.
>
> Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Link: https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aa=
e226.1663945716.git.dcaratti@redhat.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> CC: shmulik.ladkani@gmail.com
> ---
>  net/sched/act_mirred.c                             | 14 +++++---------
>  .../testing/selftests/net/forwarding/tc_actions.sh |  3 ---
>  2 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 93a96e9d8d90..35c366f043d9 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -232,18 +232,14 @@ static int tcf_mirred_init(struct net *net, struct =
nlattr *nla,
>         return err;
>  }
>
> -static bool is_mirred_nested(void)
> -{
> -       return unlikely(__this_cpu_read(mirred_nest_level) > 1);
> -}
> -
> -static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
> +static int
> +tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *s=
kb)
>  {
>         int err;
>
>         if (!want_ingress)
>                 err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
> -       else if (is_mirred_nested())
> +       else if (!at_ingress)
>                 err =3D netif_rx(skb);
>         else
>                 err =3D netif_receive_skb(skb);
> @@ -319,9 +315,9 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, str=
uct tcf_mirred *m,
>
>                 skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingres=
s);
>
> -               err =3D tcf_mirred_forward(want_ingress, skb_to_send);
> +               err =3D tcf_mirred_forward(at_ingress, want_ingress, skb_=
to_send);
>         } else {
> -               err =3D tcf_mirred_forward(want_ingress, skb_to_send);
> +               err =3D tcf_mirred_forward(at_ingress, want_ingress, skb_=
to_send);
>         }
>
>         if (err) {
> diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools=
/testing/selftests/net/forwarding/tc_actions.sh
> index b0f5e55d2d0b..589629636502 100755
> --- a/tools/testing/selftests/net/forwarding/tc_actions.sh
> +++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
> @@ -235,9 +235,6 @@ mirred_egress_to_ingress_tcp_test()
>         check_err $? "didn't mirred redirect ICMP"
>         tc_check_packets "dev $h1 ingress" 102 10
>         check_err $? "didn't drop mirred ICMP"
> -       local overlimits=3D$(tc_rule_stats_get ${h1} 101 egress .overlimi=
ts)
> -       test ${overlimits} =3D 10
> -       check_err $? "wrong overlimits, expected 10 got ${overlimits}"
>
>         tc filter del dev $h1 egress protocol ip pref 100 handle 100 flow=
er
>         tc filter del dev $h1 egress protocol ip pref 101 handle 101 flow=
er
> --
> 2.43.0
>


Doing a quick test of this and other patch i saw..

cheers,
jamal

