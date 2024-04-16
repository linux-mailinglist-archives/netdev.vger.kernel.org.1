Return-Path: <netdev+bounces-88213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F3B8A6560
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601CB284511
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D019484FCF;
	Tue, 16 Apr 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF9E4z9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5984D3C
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253547; cv=none; b=EgzyWIaK/XNPDubEGNFr7qGWlbnehlEmIEcRs6PhUQcf0lDwmyAKrETZz/vSpWu1u06PqcSCWFgXEJ59P+K45PaNAe+uKkrQWnmbbfTqsP9fw7UF/5S5PQc46Bks5ySNEmLye0YRw4Tbd192Hh32FOqbxqVILHJeqpvTShsvkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253547; c=relaxed/simple;
	bh=8nRAuIrKSOl83qtuN7TRWMOC/wovzZJSi6qJeS7QCLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ/XAMh1LSjDbCqkbzbdtQwYCWCDTxeUrjkGo05vJEsx9rmXCnrZjW9CAoAJxCo+lup9fdPlC5JzG9Ym3YdAsaB9U7t6gLNdRm0I5SljSadu4qCSwqskddtaGNFwqdovN45/ihFbAHELcFEwsg4k8qZP82YZilDlK58Z+T/49mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF9E4z9k; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a53f130b0e6so195192366b.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253544; x=1713858344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcm+hGflW7P7c6S3jcRl3Quy0llUmt9VHpKg4MTgNSE=;
        b=BF9E4z9kdF/xkM84e0OJ/G6gfHi7Aq7+kPDOIl5NCADe3sRfJhoxLuKPwk5PM5gBF2
         7mIgLE3Oo126R1vQf2Ix6cY+DnG6F6W9r9IxzEpEFN+pRXBrnpatJhM9VyiyYwyo67G3
         KHTYIhvgqZC6Tp9vcQb6o+ru7kXr6k5Ey9M8xj++0B9sGwlQE02P9HX1RmE8NFMQHB9s
         xMK5I58otJzdkUlYTCGJ9AD84LzqlRU53t5rQvWD0GV+C49LmGCY5ieavgyLJDFHVaSR
         vuczV1jZ24WlYIneNAVNGEYqXWUyX7dtFVxB+MU28vSqOSLnn2DH0at/N1QHOX2IV/Kh
         K9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253544; x=1713858344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fcm+hGflW7P7c6S3jcRl3Quy0llUmt9VHpKg4MTgNSE=;
        b=uFE0L5UVUN65dPVgMoH2CbqbeW4GT0MHZlN/FlLV4j24V8SwycU6r43H9oP6TgC00v
         aQFEVhoiGkd/7rearmQdBjiHSlhs4n2L4tG34H0PleoDrv/TkKO3iRIvrAa60JExI8J6
         GIo+79p5qjkZQa/nsa1KZ7D5YA3sMrjRunxwzMNimGAJk6a4MhlkmQUMs07CGJ7mH2ys
         Z4Dqm1wrP4jMwYJhuy0h7VWAVENleKtW7WGSJd05TEwOBWZkSn3B7A2juxw+Af4zvcWy
         DilCpt3F3ajW1Vb3vF3VDW7J5KOe6GcVZSHaIQBfUmw1zEP/2bzeoh0GHZwFaKBNZsWH
         yimA==
X-Forwarded-Encrypted: i=1; AJvYcCWuN2xPHkWgCrPLPKzRX/KzeeAOgWDQteEVruExd20UOqU/oGUiIYTHIiJVTSzf0kH2Bl6gcrNJJn6/xJfW5YfzxcjoTPt6
X-Gm-Message-State: AOJu0YyPxhkxCus9P0LA8vu4DuVp65PcZPDeFuW9HL0Jb/aE4C1kTwKj
	kxXTqTdOg0GHy7mYgMrs3KolsG9LphIOAp4A77aoWI4jR7+F+0uGHBTBST1JrPSMoLGfwSWmGMZ
	TaMElfbBNsUO2Fy8kknqzq/yFQSZKjo9i
X-Google-Smtp-Source: AGHT+IGaA+ZZ0vH/lYCVaf/SBD34nHVf9zgOXEElCTOIYt/mpiSObBH5PQ3ClsEbElAzf2j8H4R20zL7r08v1SerkjI=
X-Received: by 2002:a17:906:5959:b0:a54:e183:6248 with SMTP id
 g25-20020a170906595900b00a54e1836248mr2680885ejr.0.1713253544133; Tue, 16 Apr
 2024 00:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-5-kerneljasonxing@gmail.com> <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
In-Reply-To: <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 15:45:07 +0800
Message-ID: <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Reuse the dropreason logic to show the exact reason of tcp reset,
> > so we don't need to implement those duplicated reset reasons.
> > This patch replaces all the prior NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp_ipv4.c | 8 ++++----
> >  net/ipv6/tcp_ipv6.c | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 441134aebc51..863397c2a47b 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >         return 0;
> >
> >  reset:
> > -       tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > +       tcp_v4_send_reset(rsk, skb, (u32)reason);
> >  discard:
> >         kfree_skb_reason(skb, reason);
> >         /* Be careful here. If this function gets more complicated and
> > @@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >                 } else {
> >                         drop_reason =3D tcp_child_process(sk, nsk, skb)=
;
> >                         if (drop_reason) {
> > -                               tcp_v4_send_reset(nsk, skb, SK_RST_REAS=
ON_NOT_SPECIFIED);
> > +                               tcp_v4_send_reset(nsk, skb, (u32)drop_r=
eason);
>
> Are all these casts really needed ?

Not really. If without, the compiler wouldn't complain about it.

>
> enum sk_rst_reason is not the same as u32 anyway ?

I will remove the cast in the next version.

Thanks,
Jason

>
>
>
> >                                 goto discard_and_relse;
> >                         }
> >                         sock_put(sk);
> > @@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >  bad_packet:
> >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> >         } else {
> > -               tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > +               tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
> >         }
> >
> >  discard_it:
> > @@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >                 tcp_v4_timewait_ack(sk, skb);
> >                 break;
> >         case TCP_TW_RST:
> > -               tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED)=
;
> > +               tcp_v4_send_reset(sk, skb, (u32)drop_reason);
> >                 inet_twsk_deschedule_put(inet_twsk(sk));
> >                 goto discard_it;
> >         case TCP_TW_SUCCESS:;
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 6cad32430a12..ba9d9ceb7e89 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >         return 0;
> >
> >  reset:
> > -       tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > +       tcp_v6_send_reset(sk, skb, (u32)reason);
> >  discard:
> >         if (opt_skb)
> >                 __kfree_skb(opt_skb);
> > @@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_=
buff *skb)
> >                 } else {
> >                         drop_reason =3D tcp_child_process(sk, nsk, skb)=
;
> >                         if (drop_reason) {
> > -                               tcp_v6_send_reset(nsk, skb, SK_RST_REAS=
ON_NOT_SPECIFIED);
> > +                               tcp_v6_send_reset(nsk, skb, (u32)drop_r=
eason);
> >                                 goto discard_and_relse;
> >                         }
> >                         sock_put(sk);
> > @@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_=
buff *skb)
> >  bad_packet:
> >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> >         } else {
> > -               tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > +               tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
> >         }
> >
> >  discard_it:
> > @@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_=
buff *skb)
> >                 tcp_v6_timewait_ack(sk, skb);
> >                 break;
> >         case TCP_TW_RST:
> > -               tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED)=
;
> > +               tcp_v6_send_reset(sk, skb, (u32)drop_reason);
> >                 inet_twsk_deschedule_put(inet_twsk(sk));
> >                 goto discard_it;
> >         case TCP_TW_SUCCESS:
> > --
> > 2.37.3
> >

