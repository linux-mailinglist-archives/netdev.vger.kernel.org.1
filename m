Return-Path: <netdev+bounces-179922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F185A7EEC2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074E8176FD5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F97A21B1AA;
	Mon,  7 Apr 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MMYAXap7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE912222D2
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056533; cv=none; b=kHhRLgLv4S/sRvjJzEaGKvc5EMPfl5/LPN/DKrnYgwWx1cPhMqOJ2FgzIpLEtazWfnU7bsfhBuiWd0z1efwS7jakStittchK6JCquDfk4egnhebq8vwOpvJ3OOEWcZDxIoqv8cnTBFBkWeAj4L3oPotHiXVwZUcIOZr49Uck5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056533; c=relaxed/simple;
	bh=OKqIMVk0hKAjWR0mH2qVZytzkQd2W2PFeKNIO9ryXjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCR1SilIkYQUH2Sr6GA6LM1frQF0At35l6puddRPhVLjoi8eucObBZZwH9xm8dmRYga3/uIdzLGSMYKB5Iygj82UsAdrFyjN7vcedarTMu6abqaC0p5uhFIGr/qjAiqwcMDnI9TfwKmkWtww1YFWelrDY3e5y07hvDtDmiuchds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MMYAXap7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739525d4e12so4242508b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744056531; x=1744661331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X/ebr3VKSVdeAz5rsTuMCx4eGbyIGh4RqIqbgApkpA=;
        b=MMYAXap7hIxSyGTiEEpvuwyg7aXi26BZdCJNyoihUc9ZSAk5Wh1XwC7aBAnFBvuHNO
         kMSD70vjxfURFs8f0vJQkFyEY1vMJqM5vQEOQgeZTZI3RqpEMn7W3uPk1LKdiCMW/2sF
         5chrnZNLOBIjDDLpg3pV/oVVBll+9WduZjtCMkTZqnrYgH/O5J8kCZZ9IhE8HJ4k0lIm
         c28gQL5PKARsRYoiuR0+39VgwSPYDa5xYnNU5zk8d7RHXtBXbSS5XHQArQB881VwXKHD
         6Ut4jkBlwbdjssJGPZN8nJK/yHqnAEk2i0lV2wjyd6Xf/vcR4f7+e2oFuGxk5H+XFslk
         MxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056531; x=1744661331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X/ebr3VKSVdeAz5rsTuMCx4eGbyIGh4RqIqbgApkpA=;
        b=AT5+aC9gJINo110pbeMBaB8iWhvDkRnU/DWTNUohPj02qLUMQoscxdWLl/xL66zuZI
         51yvPRMd9I/dJ2fGemQ7lPi1jU2oO26Cy20CXr85zKAHtN665oRlAPfMvtzgMrSHpCgZ
         OcupXiXbQk/MvTefmAN/szEd7oxZZrYeb1f7w+inVlQJp7KIQZ7/8kQRfn/nabAQhu6p
         oK/zSmFk2AgCzJ6ISk8jJeUUI3gNPc1kbP/cxxO247UGZmYXkfgWgLe1V+wyjRI+h8cd
         sfI77k4xQE5+ez+1Xl0+wkIckRX8gciv0qt40yDoKcdRx3drjxcsYRGjFVFWCzBJyUKK
         svkw==
X-Forwarded-Encrypted: i=1; AJvYcCURUoKtsCijIJyaN7JF1X/0sYqwqO08q/pk/Am47zHnIFuxPO9AQC2HZFuHUk8716L8pkylarw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlndY17IpUD2qkNGyx7jtMRezYJ5WXaAYbiCHM6eEyF/s3PUp
	Hd4sdZVQ9yDQjgEqqp4ljzUDkMGxyVHg5ZpZsSWtjXUHvV5TwTUZKCqFmsXBB9NZFxrGLhM4IrA
	9RMhyXUFwOwEbiI2ZSQeej6SKRyYFB6fUN4mm
X-Gm-Gg: ASbGncuiK9jLSU6bTOz5e+Y6oI7IkinPJY1kyJzX6YCEKw7XKN6ERe5Ys6ixILWUYP5
	x9PSVvsjgKs3opgQz6gUI2Ns2OxL8fCjF+y4/kje+9UJx54KQavQiw2UFjmiTGcY9t2cogOStji
	oHfpNcsU/MfKKaQi0wxQT4X7nJpQ==
X-Google-Smtp-Source: AGHT+IHk8z8Z5qwZEbyzFItCrBtfoyqdahaq12PuqaAWLmxw+dTYDhxrcv9ys+iPMttCQkM5Kf8BvibGYi0kZ64a61o=
X-Received: by 2002:a05:6a20:9f47:b0:1f3:48d5:7303 with SMTP id
 adf61e73a8af0-2010472dfb8mr25188096637.31.1744056531031; Mon, 07 Apr 2025
 13:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407112923.20029-1-toke@redhat.com> <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
In-Reply-To: <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 7 Apr 2025 16:08:39 -0400
X-Gm-Features: ATxdqUFIXoWpV_4CixusFM9WVZYPds5eJ1-upA6zl_Aje7fgaWpysDTFkf5y3n0
Message-ID: <CAM0EoM=EL-KVC-LKC8tyY1BRSYtjEgKPPmcwzAvj+z+fw04gpQ@mail.gmail.com>
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach too
 many actions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ilya Maximets <i.maximets@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 3:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Mon, Apr 7, 2025 at 7:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >
> > While developing the fix for the buffer sizing issue in [0], I noticed
> > that the kernel will happily accept a long list of actions for a filter=
,
> > and then just silently truncate that list down to a maximum of 32
> > actions.
> >
> > That seems less than ideal, so this patch changes the action parsing to
> > return an error message and refuse to create the filter in this case.
> > This results in an error like:
> >
> >  # ip link add type veth
> >  # tc qdisc replace dev veth0 root handle 1: fq_codel
> >  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in=
 $(seq 33); do echo action pedit munge ip dport set 22; done)
> > Error: Only 32 actions supported per filter.
> > We have an error talking to the kernel
> >
> > Instead of just creating a filter with 32 actions and dropping the last
> > one.
> >
> > Sending as an RFC as this is obviously a change in UAPI. But seeing as
> > creating more than 32 filters has never actually *worked*, it could be
> > argued that the change is not likely to break any existing workflows.
> > But, well, OTOH: https://xkcd.com/1172/
> >
> > So what do people think? Worth the risk for saner behaviour?
> >
>
> I dont know anyone using that many actions per filter, but given it's
> a uapi i am more inclined to keep it.
> How about just removing the "return -EINVAL" then it becomes a
> warning? It would need a 2-3 line change to iproute2 to recognize the
> extack with positive ACK from the kernel.
>

Removing the return -EINVAL:

$tc actions add `for i in $(seq 33); do echo action gact ok; done`
Warning: Only 32 actions supported per filter.

We do have a tdc testcase which adds 32 actions and verifies, we can
add another one which will be something like above....

cheers,
jamal

> cheers,
> jamal
>
>
> > [0] https://lore.kernel.org/r/20250407105542.16601-1-toke@redhat.com
> >
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > ---
> >  net/sched/act_api.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index 839790043256..057e20cef375 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
> > @@ -1461,17 +1461,29 @@ int tcf_action_init(struct net *net, struct tcf=
_proto *tp, struct nlattr *nla,
> >                     struct netlink_ext_ack *extack)
> >  {
> >         struct tc_action_ops *ops[TCA_ACT_MAX_PRIO] =3D {};
> > -       struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
> > +       struct nlattr *tb[TCA_ACT_MAX_PRIO + 2];
> >         struct tc_action *act;
> >         size_t sz =3D 0;
> >         int err;
> >         int i;
> >
> > -       err =3D nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO, nla, =
NULL,
> > +       err =3D nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO + 1, n=
la, NULL,
> >                                           extack);
> >         if (err < 0)
> >                 return err;
> >
> > +       /* The nested attributes are parsed as types, but they are real=
ly an
> > +        * array of actions. So we parse one more than we can handle, a=
nd return
> > +        * an error if the last one is set (as that indicates that the =
request
> > +        * contained more than the maximum number of actions).
> > +        */
> > +       if (tb[TCA_ACT_MAX_PRIO + 1]) {
> > +               NL_SET_ERR_MSG_FMT(extack,
> > +                                  "Only %d actions supported per filte=
r",
> > +                                  TCA_ACT_MAX_PRIO);
> > +               return -EINVAL;
> > +       }
> > +
> >         for (i =3D 1; i <=3D TCA_ACT_MAX_PRIO && tb[i]; i++) {
> >                 struct tc_action_ops *a_o;
> >
> > --
> > 2.49.0
> >

