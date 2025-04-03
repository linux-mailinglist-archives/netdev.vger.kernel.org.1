Return-Path: <netdev+bounces-179001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09476A79E7D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC2618965C3
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A81E24291A;
	Thu,  3 Apr 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3QebAjXB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC819241CA0
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670253; cv=none; b=W72YXo9lY6u3SW8Krbz5w/ITht3OsFWlee6HsP19g/+D3eiDvXZnfQcU41Yc/W6l1pP3J4sxWh2mlTry3C0X+E/m4hHEpLyRUk0YM6X7mQ8KCYI05A92r4OufpM0AfWvBpEOF7LRZ0IOAPWHPIfZXe0fMrtvnjh1dg+KL2qUK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670253; c=relaxed/simple;
	bh=UaelArsO2luVYREaIW6pQIDGq6x06+QN6l2Zdg3TlH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuMifOaR+/LnskHq6U6jVRLq4UH76OUjKR+aXMSZ0dbauI1uZRTYU9Np8ejlJ0ncI9zvSjQV3Q34cKldxr5Jgw/nQGBQGFT01ic2aZPWirWEieZ6S6LlvQjAmuOEhKTEVAoSikHGoAqsmN4oCANzHMbsc9pEumy7hiic148U2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3QebAjXB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54b0e9f2948so15483e87.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743670250; x=1744275050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waVYuyZEvvgvzsTNFF1L6mkOzy8Tey/iR+VGGkCuFoI=;
        b=3QebAjXBKCOAnBhNX3EfWo3V+mNSsa7+c8WZ5CvSxGWBJjC1a8t98PVO8ub9DsEyc+
         RhBiPFZpsoEznCiyXAc0NmZF+basT5z5s1sfQlnaYGnpEIWGXiMKDy/01ufmR7nGSpE8
         kAzWpzW+t/mSMWboQTRmM4oIMqKH93NwoK77psZx3SIkBKFoiU9D0eYtCQ4ToqlKph7D
         WpZFxuH668eTOTcwuZS7AOZCSVG7ukS/gKqdyGJLpsIun01+X5k0kHJ3gOcf1Gk+TCXf
         F+D0WOhUQDAwUn/ecbM5BGG9Dzq8sI4XSN7KfqsP4UOH54YcXQ54tJSqppGmC1NrB6wz
         p8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670250; x=1744275050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waVYuyZEvvgvzsTNFF1L6mkOzy8Tey/iR+VGGkCuFoI=;
        b=Aa6Z3Z0NfTdWV6dRcvOl6pFRiiOqQU/IoSzEKk9hadJtKLhUOTI+0y1of9s5EdD3zR
         Ig0JiDaaTgVXLq0zIn2E089NfcdTZ2tdXqAX7YG3AmcCedwg6J6dCla6bRUpJrRsLoh6
         XEuFOg4rvn+0/WHPvNv3ImQJvSeZ7ldD+A0Wtm3Ak/RrWFwC2XinmA5adiRg8j37b6t7
         BX2wTn3eC/D4HuNgNwpSxrKSMCgo5tR4erPw8M8p3PhzUZFwGNDA4ZdzI6X+4iEXIceB
         0HvULEQjz+FXBmgu6uCxpFX+gdZTGZD2eU4WWF6T5WEZmyvvhmzPpFpJllYlAu+qw0Qb
         IrtA==
X-Forwarded-Encrypted: i=1; AJvYcCX7KdDCEp+COtwhjkc1/LlCbTdoZJxUOtI0SBQarr0Uk/x08q0TnYQqJdMPDTy4hLwWWL1p4+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhzb8/cFbQWafgYE3QonxuJfjL4zh1WaP2mThxxcmB1bTyLHT2
	s3EeQWtJdx6mjxaKe68eNvF5DTed7AHPqtuSloGBS+yzmbwdX2MF6LbvUy/6Zq7+qnpEh3kNQWH
	dYglW0S7r/ZxwVn5/1FWr7vxAtB8vkYlXLy51
X-Gm-Gg: ASbGncsfNXW/zl6j2XuaHWCHLxuOHeSSbtdzOwwZ63+aMq00jC1GDLFphRLyXUw0+dh
	c8mKKUSxpp+DcFTdouCG6ekqfb6G5t6O1q7F074+6MMID/LUNtTfhR7C6aFu4DNhGqkxs6TR4hE
	ekSHFHuXoIXFNJp+FF3cgPqkwBRbhzQxQHqVY8mvC4QqX1SiVZStOdnRLsb98=
X-Google-Smtp-Source: AGHT+IEQHaJ3DyDu1Wy235koG/AIX50S6iGl+gqLmVJ7GpvSpBv7/x5toqpX/cSRzFiElBLy2X4oOJTVYzxf33Jl+tw=
X-Received: by 2002:ac2:5e69:0:b0:549:58d3:9d3c with SMTP id
 2adb3069b0e04-54c1d9b2230mr140474e87.7.1743670249492; Thu, 03 Apr 2025
 01:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402162750.1671155-1-tavip@google.com> <20250402162750.1671155-2-tavip@google.com>
 <20250402134631.5af060dc@hermes.local>
In-Reply-To: <20250402134631.5af060dc@hermes.local>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 3 Apr 2025 01:50:37 -0700
X-Gm-Features: AQ5f1JrgzwB656BFRactvx5YsXRF4aW8F3pzSzjRm22dPJpKaaHd1xHYRJ7wD_8
Message-ID: <CAGWr4cSM0=fUJLG19J-YB+YzV8dUMHHdd0wJWaKsn0i7DYMZ8w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] net_sched: sch_sfq: use a temporary work area
 for validating configuration
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:46=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>

Hi Stephen,

Thanks for the review.

> On Wed,  2 Apr 2025 09:27:48 -0700
> Octavian Purdila <tavip@google.com> wrote:
>
> > diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> > index 65d5b59da583..1af06cd5034a 100644
> > --- a/net/sched/sch_sfq.c
> > +++ b/net/sched/sch_sfq.c
> > @@ -631,6 +631,16 @@ static int sfq_change(struct Qdisc *sch, struct nl=
attr *opt,
> >       struct red_parms *p =3D NULL;
> >       struct sk_buff *to_free =3D NULL;
> >       struct sk_buff *tail =3D NULL;
> > +     /* work area for validating changes before committing them */
> Unnecessary comment.

Fair, I'll remove the comments (here and below).

> > +     int limit;
> > +     unsigned int divisor;
> > +     unsigned int maxflows;
> > +     int perturb_period;
> > +     unsigned int quantum;
> > +     u8 headdrop;
> > +     u8 maxdepth;
> > +     u8 flags;
> > +
>
> Network code prefers reverse christmas tree style declaration order.
>

Thanks, I'll fix the declaration order.

> +       /* copy configuration to work area */
> +       limit =3D q->limit;
> +       divisor =3D q->divisor;
> +       headdrop =3D q->headdrop;
> +       maxdepth =3D q->maxdepth;
> +       maxflows =3D q->maxflows;
> +       perturb_period =3D q->perturb_period;
> +       quantum =3D q->quantum;
> +       flags =3D q->flags;
>
> Comment is unneeded. Rather than doing individual fields, why not just us=
e
> a whole temporary structure?

Do you mean save/restore a full struct sfq_sched_data? I am not sure
it is safe to do so since it includes a struct timer_list which, if I
am not mistaken, could change under us during save/restore as other
timers are added / removed.

Beside that, it is quite big (688 bytes on 64bit) so not ideal to put
it on stack, would probably need to allocate / free it. And we need to
copy a lot more fields than we need. It seems a bit inefficient.

