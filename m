Return-Path: <netdev+bounces-76239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58F86CF25
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A26B288E9
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5AB7581A;
	Thu, 29 Feb 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8Ipc7kq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AA70AF3
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223982; cv=none; b=SU/I1fJviuRwPYgL2qPyGh3DETMSqNdWLDKhrINABiHSpBxSjKd1kbYEdcinWB7nE8N/F118LvmsQ/IvqoAd/EXyJIH899mMKluyl1FxuV4uWynv1D6AS70Tanz2sQU42SC4ztIo38InEf6Lo9MoU6UohkIM1CVSY6ftScxQ44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223982; c=relaxed/simple;
	bh=S+oHN3nvg716ZkodMxUIdKXI5ABayA2FF9USv1ssXf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sejtsy4o8J0f7qgkmlyMoxpwvx4OzyWy466UIqBJ26xL1bDJQMo73VYI9mk7i+Oyvmd0jmtjmtsgKhSCeZ1CkK0xK62gNOPQRA6kPk8DU9gemboVHOSdTYWgmGNZPsp5Vjqyj5dzuaCWhdwLFBzfyfJQaJynIhxghwezkcLemqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8Ipc7kq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso6292a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709223979; x=1709828779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTcLdEXiaXDRchFtFs3gs1Yz2gaH8YwzQeG3TjdC6qc=;
        b=F8Ipc7kq9isyp4aEkdeLA7d73905LVkw5fomKEeVSdr6KwxRb5aXVXGmdIBczhvqRC
         7392E1QZZDCN3pwfJ7kQe9GpleoYGA+NaGulO8bGh2pV+eQbdLksWJKkEuMJuXOxIkV4
         9KLeKHUYcvDjrySO0dMZRTMMJX5MnVuJSsOE4867Kiit/9RfH4Cj7fiSzlOngVkIInre
         vcWn4Qby8Ovd7B8f/lWTMwgCtandtMoqlwOMYlD6JjOhDAMMiM9uwwtcQVzMfND1Tm67
         Nd7rbxmbSwVZriVOi5KYlJOzO09TmShMkU+DPvAESGYNbR9qq9KZtd9cy+Hr8FUf58QV
         pHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223979; x=1709828779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTcLdEXiaXDRchFtFs3gs1Yz2gaH8YwzQeG3TjdC6qc=;
        b=dZPMwhEP9rVJuzXwEDbpr7JTOZ1Jf6L5Cr+v1JDUHXqgh2y8VjyW9N0MJCBUgoTWKv
         uKdOd/vbur/u0ae5bHFteTLRjCPehwH5yw602G6tsHJrmZ0wS9e1ESr54XZe843Gjh/6
         Nm57Kw5gcfRcWzU62lahhsm7aiDLXF+dKCJPsPtQOH7zbQdw5bXE0iI1xAS4p3i4+RWe
         u5FJdYECE6Bqo+h9ncZHpFTXHevCSjlMJLvbnB3l1U1H4RYGzUa7N/ddy7oqDA7kSyTO
         UUz7WFtLPB2JZG5cSu8foTPa7WaPibrxsCToaiH0FYa0hRsRj6Il1cUQagN9g6Be3LYu
         uARg==
X-Forwarded-Encrypted: i=1; AJvYcCUN7iDJutg6+rZCCnz9KvOgAL3kHhb7pGmZkZ3hH/WuFl6BMIOEcn4NeFA/mDzqN0YrWpWPaSBG5whf8gOjZ0EsBLxxHmBp
X-Gm-Message-State: AOJu0Yz3IwzUdmD4W6f0QaVHvf6CSgFU9Oc8pBDvTowkGLkvw+3Y68z3
	Vfl8LRyIuJ4qzwwHsb+tSWGEiOT0nGUATHJmXJd4sEmxnOXcF3TzTkEen+2C+Q7byOnfCt+UsiX
	cc9C1bUKr5YLfOl7vQOj+PuLONPMwSL1PjVop
X-Google-Smtp-Source: AGHT+IHUgR4Tq26TYSV9VhNtrjNqJ5T2qn0ScGN/jy3af3LAmheItmwHIs7sH6lMNq1FW4M0/j/QaDP/PH0vBGvyL3k=
X-Received: by 2002:a05:6402:5206:b0:565:733d:2b30 with SMTP id
 s6-20020a056402520600b00565733d2b30mr172303edd.4.1709223978637; Thu, 29 Feb
 2024 08:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com> <20240229114016.2995906-7-edumazet@google.com>
 <20240229073750.6e59155e@kernel.org> <CANn89iLMZ2NT=DSdvGG9GpOnrfbvHo7bCk3Cj-v9cPgK-4N-oA@mail.gmail.com>
 <CANn89iLPo61i8-ycKYVrUtEUVMGg09mw153eB3sPX24jXaD9WA@mail.gmail.com> <20240229082110.796fbb09@kernel.org>
In-Reply-To: <20240229082110.796fbb09@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 17:26:05 +0100
Message-ID: <CANn89iL5sb8Q1ZiPtGBWGd+ZFSVD71hPG7eoxacmDe7kenBmrA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] inet: use xa_array iterator to implement inet_dump_ifaddr()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 29 Feb 2024 16:50:45 +0100 Eric Dumazet wrote:
> > > > You basically only want to return skb->len when message has
> > > > overflown, so the somewhat idiomatic way to do this is:
> > > >
> > > >         err =3D (err =3D=3D -EMSGSIZE) ? skb->len : err;
> >
> > This would set err to zero if skb is empty at this point.
> >
> > I guess a more correct action would be:
> >
> > if (err =3D=3D -EMSGSIZE && likely(skb->len))
> >     err =3D skb->len;
>
> Ugh, fair point.
> We should probably move the EMSGSIZE handling to the core, this is
> getting too complicated for average humans.. Like this?
>

Now you are talking ! Yep, definitely nicer.

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 765921cf1194..ce27003b90a8 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2264,6 +2264,8 @@ static int netlink_dump(struct sock *sk, bool lock_=
taken)
>                 if (extra_mutex)
>                         mutex_lock(extra_mutex);
>                 nlk->dump_done_errno =3D cb->dump(skb, cb);
> +               if (nlk->dump_done_errno =3D=3D -EMSGSIZE && skb->len)
> +                       nlk->dump_done_errno =3D skb->len;
>                 if (extra_mutex)
>                         mutex_unlock(extra_mutex);
>
> > > >
> > > > Assuming err can't be set to some weird positive value.
> > > >
> > > > IDK if you want to do this in future patches or it's risky, but I h=
ave
> > > > the itch to tell you every time I see a conversion which doesn't fo=
llow
> > > > this pattern :)
> > >
> > > This totally makes sense.
> > >
> > > I will send a followup patch to fix all these in one go, if this is o=
k
> > > with you ?
>
> Definitely not a blocker

