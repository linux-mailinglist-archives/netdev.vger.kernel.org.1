Return-Path: <netdev+bounces-97048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A073E8C8ECD
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 02:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AED281F62
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A3E1A2C0C;
	Sat, 18 May 2024 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNKkIySQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099445010
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990706; cv=none; b=WaVGyME4EP+G/hrEw1M7CIMksrKaXLN5X+U2BDcPZvXrLXohuJhEp7Lya33n0qw/3D2z27BAt/tRosqsRJULTjSwxO+SOXkUDj1vWrqxIlTuhRO9kKMllwljMAQx57n5Tfq9Ewg9O0gEfScRtA2gY/BsPhICGsZpbZOdtZfNER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990706; c=relaxed/simple;
	bh=I0+ea+w7+RYRcboxD3MLZueaJOp7s1MmbtE8e2lkRDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbCEnvJat0HWmqHdSIX4QYQQAxY5RaMU+o+GP6lABKczPVkaowEvPGCeMzB1hgJA/eYbvGLwB1Eaedb/OP/Hwj1MglNzoH4clF3+4RILoXhUEIVPX1G9tZCQs8k5gV61rQxCygQCOfqRRAfpKqAC+g2B0mftawIzS2ff1HQPlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNKkIySQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5cdd6cfae7so467066766b.0
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715990702; x=1716595502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eyReMuF7Ofh2RKAFqcB9fvMRtrXuh+l2+HjQ0qgsZ8=;
        b=ZNKkIySQgZr2rgwHTjPcgmbmLxlSlA3oN0GmJjGFEI7XkvcS0kJpqb164MRxuXWzEu
         gh0SuB09gxrLjH/claSkqnEsPOZB8Oq+v++XoEex79sS3hfquFo7BQanMuzosFTucxzE
         i9TiFUWcTDw7Wwlxo4lkcAd024vXPFGHWiNC/Lo3TIQFQYL7LuQ1sEu6kekrbUuEdfrX
         dYWlMsa0/HGXzbAWjpls+OESL55yMheRIjSTz3eQPAvb0lP8GqPO0hyImh7lav5bwBMo
         pZfU/jzWw+AhmWNf4TpCUULpBnNfRrMmy8qz8W9OR6ko+1Bb1bQJOZbKMa4stzt57Xkn
         Z1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990702; x=1716595502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eyReMuF7Ofh2RKAFqcB9fvMRtrXuh+l2+HjQ0qgsZ8=;
        b=KXw3YpsmiTo4Jz3XhvmAez4leyzXCxlY7s96+9LvAryv0NzxGmXxpvW06sQKec9qAj
         5VsnDFce23HCCq6TucRd6sVQdlLleJrAjIa0F95wbxLEPyimYwXOnE4zhX3SEqz70Wak
         pIa3DRK8pw5pzC0+HieUqmZ6Rzel+f9SI7hGF2tYsR+OZyWhM+iYmB92XG4sTsoBJQRq
         nNKDk4HStfVv92KM2i/rDnanPKi0SO3nDJliqgmMcO8GQolNNgCWNlJXyUKvH1/91rm4
         Yx6cIHaJjKE3drJo79J+yMsRv98/6IKJLZCw/42c7BchTDp8kHME3zaIDuUgcqSSCyjz
         itAg==
X-Forwarded-Encrypted: i=1; AJvYcCW8CwGfb/Kay3fYVGhHEt/bVWugtCbyOBIYA4FfTWVodgntu3Na73vZ0Konx0FXuiTFL6N5K1AGCvP3udQRFxgSsofYKRJa
X-Gm-Message-State: AOJu0Yyk0mGCEQPD2TR4Lxdfzw1ehHqqIRuXuuvsN8yd2ndkJ70oSFTB
	avVaY7TVJ/NslJ9UsqtXzCSJreWNUCyuJeJD4SphOwrVoQPCIBqUhBOMz6H5mRx7qWbU0NUXTk4
	hagbojbt7GzmHFT0YKVcHyqumotA=
X-Google-Smtp-Source: AGHT+IHcpWpEPBEOlanqqT4t9Hj/fWN4J92e950F317YxdZ7LFHz18o6DmZz4h+M4wAITmKBkMXNl1c3tXOHkUyFdZE=
X-Received: by 2002:a17:906:2dd7:b0:a5a:8cc0:8c23 with SMTP id
 a640c23a62f3a-a5d5ecdc937mr38990066b.27.1715990702212; Fri, 17 May 2024
 17:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517085031.18896-1-kerneljasonxing@gmail.com>
 <CADVnQymvBSUFcc307N_geXgosJgnrx4nziFcpnX-=jU7PronwA@mail.gmail.com>
 <CAL+tcoDbB2if_=h7XSRU9_i2G=xT+fqmxCU-Mhe438PYcqxj-w@mail.gmail.com>
 <CAL+tcoAQSh9ScCduvhKNW9q8A7dhzA3OPuBde6t2=rsxg8=5Jg@mail.gmail.com> <CADVnQyn1tNaAYyOA98oyV_8d0k8VA24Z4kNVcB3=QLt1Qxz6=w@mail.gmail.com>
In-Reply-To: <CADVnQyn1tNaAYyOA98oyV_8d0k8VA24Z4kNVcB3=QLt1Qxz6=w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 18 May 2024 08:04:25 +0800
Message-ID: <CAL+tcoDyegkbrC1fx0onTZe5JqW+JnM9oAoLVQXr2Mj7Zqt7TQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: break the limitation of initial receive window
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Neal,

On Sat, May 18, 2024 at 2:35=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, May 17, 2024 at 1:49=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Sat, May 18, 2024 at 1:41=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Fri, May 17, 2024 at 10:42=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com> wrote:
> > > >
> > > > On Fri, May 17, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Since in 2018 one commit a337531b942b ("tcp: up initial rmem to 1=
28KB and
> > > > > SYN rwin to around 64KB") limited received window within 65535, m=
ost CDN
> > > > > team would not benefit from this change because they cannot have =
a large
> > > > > window to receive a big packet one time especially in long RTT.
> > > > >
> > > > > According to RFC 7323, it says:
> > > > >   "The maximum receive window, and therefore the scale factor, is
> > > > >    determined by the maximum receive buffer space."
> > > > >
> > > > > So we can get rid of this 64k limitation and let the window be tu=
nable if
> > > > > the user wants to do it within the control of buffer space. Then =
many
> > > > > companies, I believe, can have the same behaviour as old days. Be=
sides,
> > > > > there are many papers conducting various interesting experiments =
which
> > > > > have something to do with this window and show good outputs in so=
me cases.
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/ipv4/tcp_output.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > > > index 95caf8aaa8be..95618d0e78e4 100644
> > > > > --- a/net/ipv4/tcp_output.c
> > > > > +++ b/net/ipv4/tcp_output.c
> > > > > @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct s=
ock *sk, int __space, __u32 mss,
> > > > >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_si=
gned_windows))
> > > > >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> > > > >         else
> > > > > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> > > > > +               (*rcv_wnd) =3D space;
> > > >
> > > > Hmm, has this patch been tested? This doesn't look like it would wo=
rk.
> > >
> > > Hello Neal,
> > >
> > > Thanks for the comment.
> > >
> > > Sure, I provided such a patch a few months ago which has been tested
> > > in production for the customers.
> > >
> > > One example of using a much bigger initial receive window:
> > > client   ---window=3D65535---> server
> > > client   <---window=3D14600----  server
> > > client   ---window=3D175616---> server
> > >
> > > Then the client could send more data than before in fewer rtt.
> > >
> > > Above is the output of tcpdump.
> > >
> > > Oh, I just found a similar case:
> > > https://lore.kernel.org/all/20220213040545.365600-1-tilan7663@gmail.c=
om/
> > >
> > > Before this, I always believed I'm not the only one who had such an i=
ssue.
> > >
> > > >
> > > > Please note that RFC 7323 says in
> > > > https://datatracker.ietf.org/doc/html/rfc7323#section-2.2 :
> > > >
> > > >    The window field in a segment where the SYN bit is set (i.e., a =
<SYN>
> > > >    or <SYN,ACK>) MUST NOT be scaled.
> > > >
> > > > Since the receive window field in a SYN is unscaled, that means the
> > > > TCP wire protocol has no way to convey a receive window in the SYN
> > > > that is bigger than 64KBytes.
> > > >
> > > > That is why this code places a limit of U16_MAX on the value here.
> > > >
> > > > If you want to advertise a bigger receive window in the SYN, you'll
> > >
> > > No. It's not my original intention.
> > >
> > > For SYN packet itself is limited in the __tcp_transmit_skb() as below=
:
> > >
> > >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
> >
> > With this limitation/protection of the window in SYN packet, It would
> > not break RFC with this patch applied. I try to advertise a bigger
> > initRwnd of ACK in a 3-way shakehand process.
>
> Thanks for the explanation.
>
> I think the confusion arose because in your title ("tcp: break the
> limitation of initial receive window"), I interpreted "initial receive
> window" as the initial receive window advertised on the wire (which is
> limited by protocol spec to 64 kbytes), when you meant the initial
> value of tp->rcv_wnd. There are similar ambiguities in the commit
> message body.
>
> I would suggest resubmitting a version of the patch with a revised
> commit title and commit description, to clarify at least the following
> issues:
>
> + For the patch title, perhaps something like:
>   tcp: remove 64 KByte limit for initial tp->rcv_wnd value

Thanks for the help.

I'll update it.

>
> + For the commit description, in the sentence 'Since in 2018 one
> commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin to
> around 64KB") limited received window within 65535', please revise
> this to clarify that you are talking about tp->rcv_wnd and not the
> receive window on the wire. For example: 'In 2018 commit a337531b942b
> ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB") limited
> the initial value of tp->rcv_wnd to 65535,.'

Got it :)

>
> + For the commit description, please add a note that RFC 7323 limits
> the initial receive window on the wire in a SYN or SYN+ACK to 65535
> bytes, and __tcp_transmit_skb() already ensures that constraint is
> respected, no matter how large tp->rcv_wnd is.

Okay, I will add it to avoid future confusion.

>
> + For the commit description, please include some version of your
> example of the receive window values in a handshake, like:
>
> One example of using a much bigger initial receive window:
> client   --- SYN: rwindow=3D65535 ---> server
> client   <--- SYN+ACK: rwindow=3D14600 ----  server
> client   --- ACK: rwindow=3D175616 ---> server

Agreed.

>
> + For the commit description, please include some version of your
> example of the evolution of the receive window over the first 3 round
> trips, before and after your patch.

I'll revise the body message according to your comments.

Thanks,
Jason

