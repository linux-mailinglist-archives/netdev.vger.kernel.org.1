Return-Path: <netdev+bounces-97260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE1F8CA565
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 02:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB791C20C65
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 00:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791A8441F;
	Tue, 21 May 2024 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAWziaWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39518D
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716251822; cv=none; b=Ps+MBe2r8JlWb/zpO8Q9rdEMwsaZA0QTvJygsn8icL/E4H9Kkr85uPzzkCS4+n4yT3ubPHUX6BpbI0rmNYkJ4wixwwPiNcly8+s5tAIroHArDel8gBxLdD6RT4rKfun4vJZN4tmm4fjKVkn/o12td084FYTDSB2MYm/r5RI+f+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716251822; c=relaxed/simple;
	bh=MgZyyug74mmv3vx3WB7b6kYo3Fdcj+meQsfulj8fSW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcbG09UpmraagJ3z6mcMtqd6SV6Wo9EmFUucBTibvSDTsRLCOQnB/eErUaBfauTjb3EiOF2dX6PHzJ8h2OK9wQPWd0H4pO32xhzFB5mbI62sl2XprwHtyffKblJffAbeANn3LDejHiluA+DUDyXMwbXIKrc2RCprXpFChA1vJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAWziaWU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c0a6415fso833802166b.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716251819; x=1716856619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYi5evOQslXb4XeD/O+Usn03MdFApEUe93TbBKvkOdw=;
        b=LAWziaWUv6b3gSul1xMi4Nia9+w6Grr+fzKo5g+wnfNz7QhWODRXrUYKjpXojAQtXJ
         Za770H0Ugz6tjeUEum7X3pjeN2z6GD15YcaufW4B42ylq5BnyBxcbRsbpiluwqQziTKi
         XSwn8lwBsqFRNT57urwS2peDLp1QUMteeyL+cGv4GMLw98FAaIOmHBDEkF6os5yeT/XY
         0vLWyt4AiyRKMPP7Zk75bwdYo3boxs0St8usnan+Q08vraotQos8ZbQw4ik4lQvJYnkl
         dnpQR9IoS+b0woG9FKk5K5hn2AcM5wxOMRcbKk7+wBwkKCIoSQFG5CRMqNS2s4z9R4Ea
         Zh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716251819; x=1716856619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYi5evOQslXb4XeD/O+Usn03MdFApEUe93TbBKvkOdw=;
        b=B8BZi13UFjstK/IOO5NEZ7HYtvMYdpAFX2mXwa5pYP239pxsceeb4F/pBmcvi/CQO7
         w0n8OpFcJ9JbzZu+w1nij92b1GqgmHmvXM61nbyDF0T3TbfHK2brGLePZqOQsi0eFqY8
         exrBVZyHOUhbapDReIWAFti3y4vOW7SFsZDiIJaoFxMKD5DO3YGQSimMoRS2fMmmGxo1
         PYVX62fI1sA+RTRTUZdWyQQxD315+Lc1pM4mEdNj2zNk7aBXE5F8nj0aAklMnYRfedV0
         apJSgjBdljwvNSzTsQA26D4ogmmxoYOY27FKDsl+GL5TMl5q9+VM7BirLSjj6wwCMsF5
         PR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+mumsc9SmoYj9BocXWMxHHHMshtq12s4Jyd6lnOmYTBhewf/44NDj8zxa1FDI5Q052qnumkv7g2jQV/RPOhmSDTEE7fZz
X-Gm-Message-State: AOJu0YyTALN5b6FMmANXcBRjmru5te5YOyVwkV9SYlgtMLKflvXK2iV0
	I9AqOfOH1T66AYLTmS6Cru4bSHEmjsR5uqrG+IsyDJAiD3gNX7puHUh3Jg0JP3mElRw2QE4t6s1
	sw3b6M3Oyh+Je93+Q1b4BCX75oK1zdGiq
X-Google-Smtp-Source: AGHT+IGfsbNTk5EWRAnV3VlkxYhxDkHi+69qKXyazuklkP2dqC+nNdxUjqYltLeozgXpejwAMsijiyZ9lCH9+tqULnY=
X-Received: by 2002:a17:907:3208:b0:a59:ad15:6133 with SMTP id
 a640c23a62f3a-a5a2d6759d9mr2479824966b.71.1716251818670; Mon, 20 May 2024
 17:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518025008.70689-1-kerneljasonxing@gmail.com> <CANn89iJqmp36tYxFgrTYqZ69EFc9c=eK69dhfPhriAwpk-fW-A@mail.gmail.com>
In-Reply-To: <CANn89iJqmp36tYxFgrTYqZ69EFc9c=eK69dhfPhriAwpk-fW-A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 May 2024 08:36:21 +0800
Message-ID: <CAL+tcoB3ZXhYfGbdmR2ARit9VW9550wUXtaXroJ714Z6e0Hz=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 net-next] tcp: remove 64 KByte limit for initial
 tp->rcv_wnd value
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, May 21, 2024 at 12:51=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, May 18, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwi=
n
> > to around 64KB") limited the initial value of tp->rcv_wnd to 65535, mos=
t
> > CDN team would not benefit from this change because they cannot have a
> > large window to receive a big packet, which will be slowed down especia=
lly
> > in long RTT.
> >
> > According to RFC 7323, it says:
> >   "The maximum receive window, and therefore the scale factor, is
> >    determined by the maximum receive buffer space."
>
> This seems not relevant ?  wscale factor is not changed in this patch ?
> tp->rcv_wnd is also not the maximum receive window.

Thanks for your review.

I can remove this part. I was trying to claim I do not break RFC.

>
> >
> > So we can get rid of this 64k limitation and let the window be tunable =
if
> > the user wants to do it within the control of buffer space. Then many
> > companies, I believe, can have the same behaviour as old days.
>
> Not sure this has ever worked, see below.
>
> Also, the "many companies ..." mention has nothing to do in a changelog.

Oh, I just copied/translated from my initial studies of this rcv_wnd
by reading many papers something like this.

I can also remove this sentence.

>
>
> > Besides,
> > there are many papers conducting various interesting experiments which
> > have something to do with this window and show good outputs in some cas=
es,
> > say, paper [1] in Yahoo! CDN.
>
> I think this changelog is trying hard to sell something, but in
> reality TCP 3WHS nature
> makes your claims wrong.
>
> Instead, you should clearly document that this problem can _not_ be
> solved for both
> active _and_ passive connections.
>
> In the first RTT, a client (active connection) can not send more than
> 64KB, if TCP specs
> are properly applied.

Having a large rcv_wnd if the user can tweak this knob can help
transfer data more rapidly. I'm not referring to the first RTT.

>
> >
> > To avoid future confusion, current change doesn't affect the initial
> > receive window on the wire in a SYN or SYN+ACK packet which are set wit=
hin
> > 65535 bytes according to RFC 7323 also due to the limit in
> > __tcp_transmit_skb():
> >
> >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
> >
> > In one word, __tcp_transmit_skb() already ensures that constraint is
> > respected, no matter how large tp->rcv_wnd is.
> >
> > Let me provide one example if with or without the patch:
> > Before:
> > client   --- SYN: rwindow=3D65535 ---> server
> > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > client   --- ACK: rwindow=3D65536 ---> server
> > Note: for the last ACK, the calculation is 512 << 7.
> >
> > After:
> > client   --- SYN: rwindow=3D65535 ---> server
> > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > client   --- ACK: rwindow=3D175232 ---> server
> > Note: I use the following command to make it work:
> > ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> > For the last ACK, the calculation is 1369 << 7.
> >
> > We can pay attention to the last ACK in 3-way shakehand and notice that
> > with the patch applied the window can reach more than 64 KByte.
>
> You carefully avoided mentioning the asymmetry.
> I do not think this is needed in the changelog, because this is adding
> confusion.

What kind of case I've met in production is only about whether we're
capable of sending more data at the same time at the very beginning,
so I care much more about the sending process right now.

>
> >
> > [1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v2
> > Link: https://lore.kernel.org/all/20240517085031.18896-1-kerneljasonxin=
g@gmail.com/
> > 1. revise the title and body messages (Neal)
> > ---
> >  net/ipv4/tcp_output.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 95caf8aaa8be..95618d0e78e4 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock *s=
k, int __space, __u32 mss,
> >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_w=
indows))
> >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> >         else
> > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> > +               (*rcv_wnd) =3D space;
>
> This is probably breaking some  packetdrill tests, but your change
> might [1] be good,

I'll do some packetdrill tests and get back some information soon.

> especially because it allows DRS behavior to be consistent for large
> MTU (eg MTU 9000) and bigger tcp_rmem[1],
> even without playing with initrwnd attribute.
>
> "ss -temoi " would display after connection setup  rcv_space:89600
> instead of a capped value.
>
> [1] This is hard to say, DRS is full of surprises.

To avoid confusion, I will remove this link and relevant statements.

Here are my opinions in conclusion:
1) this change doesn't break the law, I mean, various RFCs.
2) this change allows us to have the same behaviour as 2018 in this case.
3) this change does some good things to certain cases, especially for
the CDN team.

I'll refine the changelog as far as I can, hoping it will not confuse
the readers.

Thanks,
Jason

