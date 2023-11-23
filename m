Return-Path: <netdev+bounces-50639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778477F6614
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0846B212DD
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF74B5BA;
	Thu, 23 Nov 2023 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtwHGGPy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A80F189
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700763377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUqsL2eDeFp9cveIvcM49GqGjUAuLkHw0ca4enChq9A=;
	b=WtwHGGPyJPjVxF1Hrz5g16QUN+4XVYOvjbc5vs2JA1mXav6XGMTxplMrqiTUQzP1VYd8tx
	u9MK7qAmV/YSah5RP1VxhS3IBlYRcg1Fa4MV8ExE0wWwVufY5MLAUZsQd2iTszeqhGFvnf
	uw9R1fxUGGhffN377PeNiUvyVd0fV38=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-qkyfftjtMA-8fRhrc_37qw-1; Thu, 23 Nov 2023 13:16:15 -0500
X-MC-Unique: qkyfftjtMA-8fRhrc_37qw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a02344944f5so21517966b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763375; x=1701368175;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUqsL2eDeFp9cveIvcM49GqGjUAuLkHw0ca4enChq9A=;
        b=MXyWKb8VSsGdNwtrSupKd32FZxQyZg2YJw9mtw+r7sjxNkhZuzUgOZYGbXUkScpOyY
         lOd950pDkNrUscLce61RX1/pd6lyx2cRWiOx79O2mj+LHwQNgmNhrSKSxyWGa+Oo4QcV
         AAvbcX2eF4fIMXRoF411S//7WRvXSJdKGRI3J9HGRlulwIbNR8rpuqV6FbJJMJU8TnSm
         JpccRQPGN9YUaNfaspgNr+gePqmjcDtKR6Pgv+viUrZEkGXW5OEdBCGYkOXdBv6ZSf6g
         d09jD01YvRhRdhgnQeLG/uDQI5YjAPE5ihixYZLp70JGogW+duTZyYVa8afkO2WzmJiM
         Qy9g==
X-Gm-Message-State: AOJu0YzEcG8EgEEi1k7yy9TaDERI+McrSfRqHKrb6R2f3Gt5xspAKK9S
	PCiYyL3dznodEilc8u1Y9HOHjAWepTp6lo/3Ygcf9aXc3mUXh+GaXRzKmq8p393iNIch6YEdWT2
	sWQ9eHuijoWuYFDZG
X-Received: by 2002:a17:906:608f:b0:9cf:7c60:47b9 with SMTP id t15-20020a170906608f00b009cf7c6047b9mr104421ejj.1.1700763374832;
        Thu, 23 Nov 2023 10:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZNk5CI4L4U+zlggaEFj0hd+s9gbb7DfVHrXDMj6a4LsAx26gIYWQl7ZLu6AVyDKz46MbCpQ==
X-Received: by 2002:a17:906:608f:b0:9cf:7c60:47b9 with SMTP id t15-20020a170906608f00b009cf7c6047b9mr104399ejj.1.1700763374362;
        Thu, 23 Nov 2023 10:16:14 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id jx19-20020a170906ca5300b009fc9fab9178sm1062057ejb.125.2023.11.23.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:16:14 -0800 (PST)
Message-ID: <ebb26a4a8a80292423c8cfc965c7b16e2aa4e201.camel@redhat.com>
Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>,  Wei Wang <weiwan@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Neil Spring
 <ntspring@fb.com>,  David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 23 Nov 2023 19:16:12 +0100
In-Reply-To: <CANn89iJMVCGegZW2JGtfvGJVq1DZsM7dUEOJxfcvWurLSZGvTQ@mail.gmail.com>
References: 
	<fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
	 <CANn89iJMVCGegZW2JGtfvGJVq1DZsM7dUEOJxfcvWurLSZGvTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-23 at 18:10 +0100, Eric Dumazet wrote:
> CC Neal and Wei
>=20
> On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > After the blamed commit below, if the user-space application performs
> > window clamping when tp->rcv_wnd is 0, the TCP socket will never be
> > able to announce a non 0 receive window, even after completely emptying
> > the receive buffer and re-setting the window clamp to higher values.
> >=20
> > Refactor tcp_set_window_clamp() to address the issue: when the user
> > decreases the current clamp value, set rcv_ssthresh according to the
> > same logic used at buffer initialization time.
> > When increasing the clamp value, give the rcv_ssthresh a chance to grow
> > according to previously implemented heuristic.
> >=20
> > Fixes: 3aa7857fe1d7 ("tcp: enable mid stream window clamp")
> > Reported-by: David Gibson <david@gibson.dropbear.id.au>
> > Reported-by: Stefano Brivio <sbrivio@redhat.com>
> > Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> > Tested-by: Stefano Brivio <sbrivio@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/ipv4/tcp.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 53bcc17c91e4..1a9b9064e080 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -3368,9 +3368,22 @@ int tcp_set_window_clamp(struct sock *sk, int va=
l)
> >                         return -EINVAL;
> >                 tp->window_clamp =3D 0;
> >         } else {
> > -               tp->window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> > -                       SOCK_MIN_RCVBUF / 2 : val;
> > -               tp->rcv_ssthresh =3D min(tp->rcv_wnd, tp->window_clamp)=
;
> > +               u32 new_rcv_ssthresh, old_window_clamp =3D tp->window_c=
lamp;
> > +               u32 new_window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> > +                                               SOCK_MIN_RCVBUF / 2 : v=
al;
> > +
> > +               if (new_window_clamp =3D=3D old_window_clamp)
> > +                       return 0;
> > +
> > +               tp->window_clamp =3D new_window_clamp;
> > +               if (new_window_clamp < old_window_clamp) {
> > +                       tp->rcv_ssthresh =3D min(tp->rcv_ssthresh,
> > +                                              new_window_clamp);
> > +               } else {
> > +                       new_rcv_ssthresh =3D min(tp->rcv_wnd, tp->windo=
w_clamp);
> > +                       tp->rcv_ssthresh =3D max(new_rcv_ssthresh,
> > +                                              tp->rcv_ssthresh);
> > +               }
> >         }
> >         return 0;
> >  }
>=20
> It seems there is no provision for SO_RESERVE_MEM

Indeed I did take that in account.

> I wonder if tcp_adjust_rcv_ssthresh()  could help here ?

I don't know how to fit it into the above. tcp_adjust_rcv_ssthresh()
tends to shrink rcv_ssthresh to low values when no memory is reserved.=C2=
=A0

Dealing directly with SO_RESERVE_MEM when shrinking the threshold feels
easier to me, something alike:

               if (new_window_clamp =3D=3D old_window_clamp)
                       return 0;

               tp->window_clamp =3D new_window_clamp;
               if (new_window_clamp < old_window_clamp) {
			int unused_mem =3D sk_unused_reserved_mem(sk);

			tp->rcv_ssthresh =3D min(tp->rcv_ssthresh,
                                               new_window_clamp);

			if (unused_mem)
				tp->rcv_ssthresh =3D max_t(u32, tp->rcv_ssthresh,
					tcp_win_from_space(sk, unused_mem));
               } else {
			new_rcv_ssthresh =3D min(tp->rcv_wnd, tp->window_clamp);
			tp->rcv_ssthresh =3D max(new_rcv_ssthresh,
                                              tp->rcv_ssthresh);
               }

Possibly the bits shared with tcp_adjust_rcv_ssthresh() could be
factored out in a common helper.

> Have you considered reverting  3aa7857fe1d7 ("tcp: enable mid stream
> window clamp") ?


That would work, too and will be simpler.

The issue at hand was noted with an application that really wants to
limit the announced window:

https://gitlab.com/dgibson/passt

I guess touching rcv_ssthresh would be a bit more effective.=C2=A0

Not much more in the end, as both window_clamp and rcv_ssthresh can
later grow due to rcv buf auto-tune. Ideally we would like to prevent
tcp_rcv_space_adjust() from touching window_clamp after
TCP_WINDOW_CLAMP - but that is another matter/patch.

Thanks!

Paolo


