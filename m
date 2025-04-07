Return-Path: <netdev+bounces-179931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C3A7EEB0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F79A188FA93
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67746221727;
	Mon,  7 Apr 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="t4iOJ2nl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA001219A8F
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056648; cv=none; b=W5fK+crrS4ZuhmMMuDLqAmPxR1WGt/+ZvvVbEm3Yf3RPWoTlPx5si5U4vmV0fZzeozfAHzzE6QmE4w6BtWG2KhaXkEDGom2chqY6Rnb5/QOP47G8nc+yAxqaxWZMRIJUc3KSVpZq6MRew4Ie2TNz7OQYvrswsuKJ7z/rCtUCqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056648; c=relaxed/simple;
	bh=GJm5AAqsFY6aJyQ3mErLpakDfx+UroMneWGWDFo5bvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9vlEWk1M0QVYTIQGbg7Kv+dOQis1vArW30zOrvKJ6LyZYdyHgt71f6nk3oLKF1AS4yIa7dyUvo3tCCnwuMONpvRhq/jYqMXhlzlEX2rLBTNTgsQ8L8YBSN/h00AEPZDjsXnhLZ43HOuVwvV5hinJAXCNlMYcstKxD+JUxPDw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=t4iOJ2nl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso4578928b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744056646; x=1744661446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsuOkPfsGZezasE1kRezDpn/5NKVL97SLdxoQ8A29oY=;
        b=t4iOJ2nly/ph3Hw8ay/dGoyG54D1IDLpYbiUp2n4NCw+65hKylhWP38M6NSpl8ghX7
         XbnbZYWrxnhL2K3PerW2dUzNvZOHcz/4l1x2Igp6fbKJh6xteXbiAsXqInJg7n8kT7la
         aiKC7qrpweB+cs5ogUHEC9UJm2iGoPvqnepMAkkfpZwKq4uEV+o9nE1fabrfvmSyffkK
         45x0YRaLaJe+18nE/ZZpiN2ktF3iDf/DUyTfsldJxtYP+d841nqjVp4e3Slj/Ha4nPjU
         Dp/bs6TQM3omGR4bEQeXDIwjXbQCV2l2zkCJ8eSS7pS00IKzCwdvhhvUG3+nNJQias/v
         D6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056646; x=1744661446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsuOkPfsGZezasE1kRezDpn/5NKVL97SLdxoQ8A29oY=;
        b=X9inhtXvNaJ9NcfWDuERJoP/U6MCOSM4lxDn1952bHei9HhKOZ3ehdfAbbmv/o+gtG
         xDk0lfHCmN+AXEkAehqEdRLxO1OKPBqKkLQGt3khEJo2SkZAYh1SX7mxYV+FU8dlMRiO
         ddhWh3/gzUCv2s0ZzdV1mXDVvHwe7MsfDc4fo+EgowVxo84/Z0ObkkzJKg7Q6QW40iGx
         M/V5w7vf5wWjZenuXbyFZ9zc7nx1r+o48YPyFTtK64TbfWsS8s350RmGf7egDYGHaA8i
         YyanPMjKogQZZ+ufz28aVHl9HljCcSGg7P0Q9K5MlcQM12zm8rd9ol2Rx/U7wMZZXAJP
         Z1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW1IhANtTAuqr6t2mMyvRK6H+uGu5KOAiHlkqHeodiDh2sHwZ6xveagZfBac9rwPqy5seN9gjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUA6yErWDGEbs1kzC6xNoy/m4xVfEMTE2/IxD3AWdvhi0YLtS
	iCiNf6OQWauokJ8nbZhaJIV2ROIP6rANaSt+dAKvdDSJf0SIOVLn6aPmIVBOu/gAEJnxTAkDYm9
	G3aPC5/yaT1uyv2GEo545w1/moE/Y1qWW0xA/
X-Gm-Gg: ASbGncuKdY8tGqWUkJNAZZ+gn8HNk9vjVgFOI3OndRsevmVeFZC0kw754IJ1HyvypkT
	RYsef+ZYEskC6otErFwnB7DecikPh27yeE8JSM77goiXumYQT5SSA02d1aJESOLfhqHdTCzJHO0
	ydoUyRr4Vn1ZVd8XayDl6FCaRhAw==
X-Google-Smtp-Source: AGHT+IH3lg0ghKyET0c2bIYTw2sxsCa4+HPJfbJP7rk1RPDj1/AoUv+0YoykzNP51L0cw8i4UyfFKWOYT1/TGNGYJPA=
X-Received: by 2002:a05:6a21:1706:b0:1f5:5a02:e1ba with SMTP id
 adf61e73a8af0-2010474b1c6mr23351387637.37.1744056646056; Mon, 07 Apr 2025
 13:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407112923.20029-1-toke@redhat.com> <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
 <CAM0EoM=EL-KVC-LKC8tyY1BRSYtjEgKPPmcwzAvj+z+fw04gpQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=EL-KVC-LKC8tyY1BRSYtjEgKPPmcwzAvj+z+fw04gpQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 7 Apr 2025 16:10:34 -0400
X-Gm-Features: ATxdqUGku0nUYDz0Bo72hibWQGnB_Ihd4De0Ez_jgM0nrEHu5CAXhlTFWUKxMIM
Message-ID: <CAM0EoM=a=MuV5BOrPbFmkJa_5aYeDwk49mRXtVncwLwA_a8uwQ@mail.gmail.com>
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach too
 many actions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ilya Maximets <i.maximets@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:08=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Mon, Apr 7, 2025 at 3:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Mon, Apr 7, 2025 at 7:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> > >
> > > While developing the fix for the buffer sizing issue in [0], I notice=
d
> > > that the kernel will happily accept a long list of actions for a filt=
er,
> > > and then just silently truncate that list down to a maximum of 32
> > > actions.
> > >
> > > That seems less than ideal, so this patch changes the action parsing =
to
> > > return an error message and refuse to create the filter in this case.
> > > This results in an error like:
> > >
> > >  # ip link add type veth
> > >  # tc qdisc replace dev veth0 root handle 1: fq_codel
> > >  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i =
in $(seq 33); do echo action pedit munge ip dport set 22; done)
> > > Error: Only 32 actions supported per filter.
> > > We have an error talking to the kernel
> > >
> > > Instead of just creating a filter with 32 actions and dropping the la=
st
> > > one.
> > >
> > > Sending as an RFC as this is obviously a change in UAPI. But seeing a=
s
> > > creating more than 32 filters has never actually *worked*, it could b=
e
> > > argued that the change is not likely to break any existing workflows.
> > > But, well, OTOH: https://xkcd.com/1172/
> > >
> > > So what do people think? Worth the risk for saner behaviour?
> > >
> >
> > I dont know anyone using that many actions per filter, but given it's
> > a uapi i am more inclined to keep it.
> > How about just removing the "return -EINVAL" then it becomes a
> > warning? It would need a 2-3 line change to iproute2 to recognize the
> > extack with positive ACK from the kernel.
> >
>
> Removing the return -EINVAL:
>
> $tc actions add `for i in $(seq 33); do echo action gact ok; done`
> Warning: Only 32 actions supported per filter.
>
> We do have a tdc testcase which adds 32 actions and verifies, we can
> add another one which will be something like above....
>

And using your example:

$TC -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in
$(seq 33); do echo action gact ok; done)
Warning: Only 32 actions supported.
Not a filter(cmd 2)

cheers,
jamal

>
> > cheers,
> > jamal
> >
> >
> > > [0] https://lore.kernel.org/r/20250407105542.16601-1-toke@redhat.com
> > >
> > > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > ---
> > >  net/sched/act_api.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > > index 839790043256..057e20cef375 100644
> > > --- a/net/sched/act_api.c
> > > +++ b/net/sched/act_api.c
> > > @@ -1461,17 +1461,29 @@ int tcf_action_init(struct net *net, struct t=
cf_proto *tp, struct nlattr *nla,
> > >                     struct netlink_ext_ack *extack)
> > >  {
> > >         struct tc_action_ops *ops[TCA_ACT_MAX_PRIO] =3D {};
> > > -       struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
> > > +       struct nlattr *tb[TCA_ACT_MAX_PRIO + 2];
> > >         struct tc_action *act;
> > >         size_t sz =3D 0;
> > >         int err;
> > >         int i;
> > >
> > > -       err =3D nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO, nla=
, NULL,
> > > +       err =3D nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO + 1,=
 nla, NULL,
> > >                                           extack);
> > >         if (err < 0)
> > >                 return err;
> > >
> > > +       /* The nested attributes are parsed as types, but they are re=
ally an
> > > +        * array of actions. So we parse one more than we can handle,=
 and return
> > > +        * an error if the last one is set (as that indicates that th=
e request
> > > +        * contained more than the maximum number of actions).
> > > +        */
> > > +       if (tb[TCA_ACT_MAX_PRIO + 1]) {
> > > +               NL_SET_ERR_MSG_FMT(extack,
> > > +                                  "Only %d actions supported per fil=
ter",
> > > +                                  TCA_ACT_MAX_PRIO);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > >         for (i =3D 1; i <=3D TCA_ACT_MAX_PRIO && tb[i]; i++) {
> > >                 struct tc_action_ops *a_o;
> > >
> > > --
> > > 2.49.0
> > >

