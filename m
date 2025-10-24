Return-Path: <netdev+bounces-232579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2226C06C56
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94B4F4E41A0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33435233735;
	Fri, 24 Oct 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk8bG6Fe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F1242D6F
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317304; cv=none; b=NvcajYpibH80Trb76VbM85EBZ5e7JtHR2rd9JpWzjvIorUgNWmMgUDzfGe3A9xA3tp3/7imh5oTFkSu8NE3aiP7cSNNOIiof+WtqsVECGFVZe05ltOVCxNk0DbGlMTWERcSgBoWIa4Q30k9DRt06p6eRhcA5wY+dSnYtFZdTYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317304; c=relaxed/simple;
	bh=0jMM1wYOZVVDSwxT4cFzdZUe+9j1Dgac2qCcTr6Wbuk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JNuLM75s3jwAQvaReIa0Eq0/sIiLxAhMajm+NVkJVA1mK8tcTIRIM1nVSWhL3l/NOztpNzhkAZdQg+pe0AECs8CuKIo1RFAHIGygsZIww1/J/WkshXfz/SPt4reekhjllVlojPvTc3uiwi9TUyX7jMvw16+xLbkLz5GHAhNEyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk8bG6Fe; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-932c247fb9aso887399241.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317301; x=1761922101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B82nDB9ireFKjPrxyVD+jWmcw9kN5uE/UhHOHx832I=;
        b=Gk8bG6FegYkXdG1HjlY3pvy4Q5b5cB6ul1V2FaFubtSO+xszGlAgarV0HM+1CLxUzL
         hA8uci+s5RD2+4taO98wbMyv4PIbNxO2G9Afzty5TzGROtXmU7iwsiBLwLR4iwg46TUU
         yGTb6Nv3e8y8+S2oaBvckzYiRFVWZD6uufKYb5d6OiNhrwIR8J4j3lNM9lP3zEODlk7d
         Dg3uC07bX/ctLzsbavoPUHruTIRi1AuXLFNAEgFChRYo/fowJUOIx4HapNqiQMiH7uwR
         jVHKDXdBTLLQUaRCmQ76ZCmb+kDEddIwW6yilCMUXI2F1zVO4FFPJ4pmjPMDiUQLkKjg
         Dwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317301; x=1761922101;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7B82nDB9ireFKjPrxyVD+jWmcw9kN5uE/UhHOHx832I=;
        b=NNaIiq/BnZf6zZ80jPegTMx5n5a/9eebmCDxMCS3YE/J7jbEqKkyvJ9Bb1J5jTFPWZ
         tjJChb3wRBrDGIrKRNKacIDM5XGgKJyqwoxvEuvZquWMSnXqaAWNPSqtBq0jKN0Px9Vu
         s91lktxwF6QVajf0Cfj+X+8a+U1DGkdc50MTZQnMDD/YSofLkqVzw+10QqpuOXCypXd9
         t5KXneOFxhCWBz/07j1wUBIvQfqF+p3aoHhC8HwvTJA/k3fKlI8Sntb+qaeXPtaKIdSU
         XVa6LiWOIClZChRL3zlY+ht9apfK/+OxdPb4fm8eh/YkioHOROyFVdypvbNeNFkWc/5P
         EJEg==
X-Forwarded-Encrypted: i=1; AJvYcCXA8ojH54kz5+iT3kJFSGuo4Ip4Xrs5s2jxnx55WeZRco92k+XU3HwqLTqykj5qEOg0zXi3zeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTj2bKLTkWazULS0PKH1ivAaPF/Mf3RVn/hpHzYDRyc+0tWgfO
	YFnbD+EcnDZpsol9EeOAaDuENB8bmUadCGOkYBsuY7X6n18IZv81GY7N
X-Gm-Gg: ASbGnctL1synYNOnzeYjciZhh1rPHx8FORxgszayGtf7URaT4TQbDD/W5+amwfd5BX+
	xpvyOJ9xJ1ufCh8tXTEc6p2H7+iyIY5HDlyhtROje2GN+0aROrUQvPEFlEaLETrHYlcgBj5sa3S
	ACGbV6P+1qvNvflMEkHkGKmwLF15xC0J9CaqrAB0tz/cUzq1R8u4IV6Fq1cZ50d31VgJhBHUfD4
	EtwQhOQggRPLqbl2oijsw2VO9omqh5oLuwpLTIbtxqqeNa5p5UD8rgoJT8X32+UE5M0pZZ64LWp
	0r2ueHgbPNjhgnHW9mCD4VOU6B3l06urJ4EFqIwxCKH9qyjH17QPmQrxWNp7i5f03Mw4TiBPdu1
	wNhnKaQh4qg5udQ+0m/SHav48iJ7Z/6fExKS3gEJi1EMNIDUBpJ/pjax7tNoFQp195gUBO2bzfs
	VA4vabhPjLtFcmjbzr32Hu3iF09ycaEwSB6nQfzax1ZOTvwL7nOLMpHti2E73WrGc=
X-Google-Smtp-Source: AGHT+IHwUj1UGZPq4japhLxPuwlciVfLWtRzXl24HeV3YNAXWLEASniwcLfN7MYaay9sE494z8nl3A==
X-Received: by 2002:a05:6102:3a0a:b0:5d5:f6ae:38ca with SMTP id ada2fe7eead31-5db2e5b4d6cmr1881460137.41.1761317300887;
        Fri, 24 Oct 2025 07:48:20 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5db2cca25a9sm2128784137.14.2025.10.24.07.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:48:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:48:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1ba874bc7bc@gmail.com>
In-Reply-To: <CANn89iLidq+WTYkg2-U6g8tK5W=squKoQcYECc=RjF_h7-g-wg@mail.gmail.com>
References: <20251024090517.3289181-1-edumazet@google.com>
 <willemdebruijn.kernel.249e3b8331c2c@gmail.com>
 <CANn89iLidq+WTYkg2-U6g8tK5W=squKoQcYECc=RjF_h7-g-wg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: optimize enqueue_to_backlog() for the fast
 path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Fri, Oct 24, 2025 at 7:03=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > Add likely() and unlikely() clauses for the common cases:
> > >
> > > Device is running.
> > > Queue is not full.
> > > Queue is less than half capacity.
> > >
> > > Add max_backlog parameter to skb_flow_limit() to avoid
> > > a second READ_ONCE(net_hotdata.max_backlog).
> > >
> > > skb_flow_limit() does not need the backlog_lock protection,
> > > and can be called before we acquire the lock, for even better
> > > resistance to attacks.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> > > ---
> > >  net/core/dev.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 378c2d010faf251ffd874ebf0cc3dd6968eee447..d32f0b0c03bbd069d36=
51f5a6b772c8029baf96c 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -5249,14 +5249,15 @@ void kick_defer_list_purge(unsigned int cpu=
)
> > >  int netdev_flow_limit_table_len __read_mostly =3D (1 << 12);
> > >  #endif
> > >
> > > -static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)=

> > > +static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen,=

> > > +                        int max_backlog)
> > >  {
> > >  #ifdef CONFIG_NET_FLOW_LIMIT
> > > -     struct sd_flow_limit *fl;
> > > -     struct softnet_data *sd;
> > >       unsigned int old_flow, new_flow;
> > > +     const struct softnet_data *sd;
> > > +     struct sd_flow_limit *fl;
> > >
> > > -     if (qlen < (READ_ONCE(net_hotdata.max_backlog) >> 1))
> > > +     if (likely(qlen < (max_backlog >> 1)))
> > >               return false;
> > >
> > >       sd =3D this_cpu_ptr(&softnet_data);
> >
> > I assume sd is warm here. Else we could even move skb_flow_limit
> > behind a static_branch seeing how rarely it is likely used.
> =

> this_cpu_ptr(&ANY_VAR) only loads very hot this_cpu_off. In modern
> kernels this is
> =

> DEFINE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
> =

> rest is in the offsets used in the code.
> =

> >
> > > @@ -5301,19 +5302,19 @@ static int enqueue_to_backlog(struct sk_buf=
f *skb, int cpu,
> > >       u32 tail;
> > >
> > >       reason =3D SKB_DROP_REASON_DEV_READY;
> > > -     if (!netif_running(skb->dev))
> > > +     if (unlikely(!netif_running(skb->dev)))
> > >               goto bad_dev;
> >
> > Isn't unlikely usually predicted for branches without an else?
> =

> I am not sure this is a hardcoded rule that all compilers will stick wi=
th.
> Do you have a reference ?

Actually I was thinking CPU branch prediction if no prior data.

According to the Intel=C2=AE 64 and IA-32 Architectures
Optimization Reference Manual, Aug 2023, 3.4.1.2 Static Prediction

Branches that do not have a history in the BTB (see Section 3.4.1)
are predicted using a static prediction algorithm:
- Predict forward conditional branches to be NOT taken.
[..]

But online threads mention that there even for x86_64 between
microarch generations there are differences on the actual
prediction behavior, as well as of explicit prediction hints.
And that's only Intel x86_64. So not a universal guide, perhaps.

> >
> > And that is ignoring both FDO and actual branch prediction hardware
> > improving on the simple compiler heuristic.
> =

> Lets not assume FDO is always used, and close the gap.
> This will allow us to iterate faster.
> FDO brings its own class of problems...
> =

> >
> > No immediately concerns. Just want to avoid precedence for others
> > to sprinkle code with likely/unlikely with abandon. As is sometimes
> > seen.
> =

> Sure.
> =

> I have not included a change on the apparently _very_ expensive
> =

> if (!__test_and_set_bit(NAPI_STATE_SCHED,
>                                     &sd->backlog.state))
> =

> btsq   $0x0,0x160(%r13)
> =

> I tried to test the bit, then set it if needed, but got no
> improvement, for some reason
> (This was after the other patch making sure to group the dirtied
> fields in a single cache line)



