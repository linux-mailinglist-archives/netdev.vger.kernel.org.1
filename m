Return-Path: <netdev+bounces-97289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979D48CA83F
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276F81F2200D
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492C44384;
	Tue, 21 May 2024 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlGjRROG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80BC12C
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274608; cv=none; b=YCohAySNJrtERcyayqK4E4PD+KHCiPpwH88xZqOiFKr3KvVCipAuIbeXeIvtBnsUgygtfamTkuUZY+7v0G/LisiTrPCkoXu+dLx+CJVFeVJPM6Oxspg/m8DjWzRuH5uql7NIshB8a2ZcUspo5LHc28/X8eV9LyaKDYIv73y7dpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274608; c=relaxed/simple;
	bh=KQlyjqbwicRLRliDGW3cmQ5xtCMicBmxKHaynMCm36U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0qEQbRB5/IUEA4goqwEGC9SOinGnKwsrHn7kilwJ3RCjjuxaFIVySRZHyxu02tturGz9nRxz20rg1lYy5NCtl0/VhHNwXb96QwH2r5mJ5NVfNsvk/Jze/SgATNW6IjYBbRIF222XNxioljxjGw4trWEoKre5UE3Dwy15YZsyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlGjRROG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51ffff16400so8164259e87.2
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716274605; x=1716879405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gh9QyHYw9CifexvkNg635ufvXVtVCSHxDgIeX+fKcY=;
        b=hlGjRROGMqLziaHJ1MCJ7cWh3lgiZdgi8q658wN2f/bFULOpsoqd09uCx/JWaSn8ZU
         MNLL7CN/Y8zNaUpEM0wYXGwSxPGsNNgpJ0FxT/RwY643eOQXv5m8OEa53w5Elu2rpyiP
         U7GXlUpJKEDiTokLFK7w8tRohw9leKCtzHLmpmr/upu9Mm/kW5xsiu1f7BJoug7CVnZp
         fS331tQZNwZZxk41hpsk6ykHgZjfNg9IrpY1h0gKqSv8xf+6MGgMEoLPyru/UXCQ347w
         8MAnPX2bW7zJFBNjGdUQval3LM0v/3etGqn95GO4g3EY4gu9Bhg5jtop61mG+pbyJPwU
         8iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716274605; x=1716879405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gh9QyHYw9CifexvkNg635ufvXVtVCSHxDgIeX+fKcY=;
        b=pwf03+HF5PybXSBIKvnBJnRTFp2XQ32fKkRMGAMNZ843qxmiGqFCsTzIJMt23HCUDB
         lGmbzGNgURyTyFzGOcvHf/KDck7qBfuBfYV/ExKoGeLDVcMWpzKS0RvgGyT2g7huUmCR
         f51uZq9xQcsa/Zx/gzmGWWa9OatJz5K4Qb2X2QqfibmJwZpl4zrlwl2BitdJvLRDAOPr
         JlQemVOUMSKHNRv7qBIG5HXw0BGo9zTeEJvVdo+JNZVP/Iea5B0JvMYozLUE9HGhYtIb
         Z8tR4mvy6A9rVrywUMPLC9WcJ326I9/oe2lx0oeIzkj1lOezkkdelpIYoqNkNJc47ehs
         BFvw==
X-Forwarded-Encrypted: i=1; AJvYcCVQsErWmuV4rNZ/QPOIlk7OaT64FDxTw9SpjiSkjG6YjhwbQZ/EM/KEA/+j3/Ap7n5mfGBRAua97cZl9zp+gCO3Z2sDd+R1
X-Gm-Message-State: AOJu0YwASz2RPcqyuUeqQcrLCZGUvHWz20zZXQ2pIIAnOrByZGLCs1hG
	DfhnUvY0zkeZQeZdE5ER14RSIH7KYaSxKCBsi4EW35Q9Jofy1DA88hvUOTAmHsiXz2UAhUVPV1f
	QFH2VvgwtjPBijvyUceXaToq0AEc=
X-Google-Smtp-Source: AGHT+IFviOsR4Fdq1cDvlNUnvPwg8WxXWQWmfd35rdoSzpDnV3rlcbIY1f3UNm62J3S2IdAwd7B3N4Cv81wNvLuy5tE=
X-Received: by 2002:a19:9107:0:b0:523:892c:9e0 with SMTP id
 2adb3069b0e04-523892c0b0fmr13565049e87.41.1716274604400; Mon, 20 May 2024
 23:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518025008.70689-1-kerneljasonxing@gmail.com>
 <CANn89iJqmp36tYxFgrTYqZ69EFc9c=eK69dhfPhriAwpk-fW-A@mail.gmail.com> <CAL+tcoB3ZXhYfGbdmR2ARit9VW9550wUXtaXroJ714Z6e0Hz=A@mail.gmail.com>
In-Reply-To: <CAL+tcoB3ZXhYfGbdmR2ARit9VW9550wUXtaXroJ714Z6e0Hz=A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 May 2024 14:56:07 +0800
Message-ID: <CAL+tcoCCznKP8Jb8poy90+9azjZ+1467oF8KGeT5vQwFQZ_trg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 net-next] tcp: remove 64 KByte limit for initial
 tp->rcv_wnd value
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, May 21, 2024 at 8:36=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Tue, May 21, 2024 at 12:51=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Sat, May 18, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN r=
win
> > > to around 64KB") limited the initial value of tp->rcv_wnd to 65535, m=
ost
> > > CDN team would not benefit from this change because they cannot have =
a
> > > large window to receive a big packet, which will be slowed down espec=
ially
> > > in long RTT.
> > >
> > > According to RFC 7323, it says:
> > >   "The maximum receive window, and therefore the scale factor, is
> > >    determined by the maximum receive buffer space."
> >
> > This seems not relevant ?  wscale factor is not changed in this patch ?
> > tp->rcv_wnd is also not the maximum receive window.
>
> Thanks for your review.
>
> I can remove this part. I was trying to claim I do not break RFC.
>
> >
> > >
> > > So we can get rid of this 64k limitation and let the window be tunabl=
e if
> > > the user wants to do it within the control of buffer space. Then many
> > > companies, I believe, can have the same behaviour as old days.
> >
> > Not sure this has ever worked, see below.
> >
> > Also, the "many companies ..." mention has nothing to do in a changelog=
.
>
> Oh, I just copied/translated from my initial studies of this rcv_wnd
> by reading many papers something like this.
>
> I can also remove this sentence.
>
> >
> >
> > > Besides,
> > > there are many papers conducting various interesting experiments whic=
h
> > > have something to do with this window and show good outputs in some c=
ases,
> > > say, paper [1] in Yahoo! CDN.
> >
> > I think this changelog is trying hard to sell something, but in
> > reality TCP 3WHS nature
> > makes your claims wrong.
> >
> > Instead, you should clearly document that this problem can _not_ be
> > solved for both
> > active _and_ passive connections.
> >
> > In the first RTT, a client (active connection) can not send more than
> > 64KB, if TCP specs
> > are properly applied.
>
> Having a large rcv_wnd if the user can tweak this knob can help
> transfer data more rapidly. I'm not referring to the first RTT.
>
> >
> > >
> > > To avoid future confusion, current change doesn't affect the initial
> > > receive window on the wire in a SYN or SYN+ACK packet which are set w=
ithin
> > > 65535 bytes according to RFC 7323 also due to the limit in
> > > __tcp_transmit_skb():
> > >
> > >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
> > >
> > > In one word, __tcp_transmit_skb() already ensures that constraint is
> > > respected, no matter how large tp->rcv_wnd is.
> > >
> > > Let me provide one example if with or without the patch:
> > > Before:
> > > client   --- SYN: rwindow=3D65535 ---> server
> > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > client   --- ACK: rwindow=3D65536 ---> server
> > > Note: for the last ACK, the calculation is 512 << 7.
> > >
> > > After:
> > > client   --- SYN: rwindow=3D65535 ---> server
> > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > client   --- ACK: rwindow=3D175232 ---> server
> > > Note: I use the following command to make it work:
> > > ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> > > For the last ACK, the calculation is 1369 << 7.
> > >
> > > We can pay attention to the last ACK in 3-way shakehand and notice th=
at
> > > with the patch applied the window can reach more than 64 KByte.
> >
> > You carefully avoided mentioning the asymmetry.
> > I do not think this is needed in the changelog, because this is adding
> > confusion.
>
> What kind of case I've met in production is only about whether we're
> capable of sending more data at the same time at the very beginning,
> so I care much more about the sending process right now.
>
> >
> > >
> > > [1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > v2
> > > Link: https://lore.kernel.org/all/20240517085031.18896-1-kerneljasonx=
ing@gmail.com/
> > > 1. revise the title and body messages (Neal)
> > > ---
> > >  net/ipv4/tcp_output.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 95caf8aaa8be..95618d0e78e4 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock =
*sk, int __space, __u32 mss,
> > >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed=
_windows))
> > >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> > >         else
> > > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> > > +               (*rcv_wnd) =3D space;
> >
> > This is probably breaking some  packetdrill tests, but your change
> > might [1] be good,
>
> I'll do some packetdrill tests and get back some information soon.

I'm done with the packetdrill tests[1]. Here are two tests failed
after comparing with/without this patch:
1) ./packetdrill/run_all.py -S -v -L -l tcp/ioctl/ioctl-siocinq-fin.pkt
2) ./packetdrill/run_all.py -S -v -L -l
tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt

For the first one, it shows:
"FAIL [/data/home/kernelxing/source_code/packetdrill/gtests/net/tcp/ioctl/i=
octl-siocinq-fin.pkt
(ipv6)]
stdout:
stderr:
ioctl-siocinq-fin.pkt:28: error handling packet: timing error:
expected outbound packet at 0.302321 sec but happened at 0.342759 sec;
tolerance 0.004000 sec
script packet:  0.302321 . 1:1(0) ack 2002
actual packet:  0.342759 . 1:1(0) ack 2002 win 65535"

For the second one, it shows:
"client-ack-dropped-then-recovery-ms-timestamps.pkt:33: error handling
packet: live packet field tcp_window: expected: 256 (0x100) vs actual:
532 (0x214)
script packet:  0.012251 P. 1:5001(5000) ack 1001 win 256 <nop,nop,TS
val 2010 ecr 1000>
actual packet:  0.012242 P. 1:5001(5000) ack 1001 win 532 <nop,nop,TS
val 2010 ecr 1000>
Ran    3 tests:    0 passing,    3 failing,    0 timed out (0.91 sec):
tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt"

The reason is unexpected window size. Since I removed the limit of
64KB, It is expected from my view.

[1]: https://github.com/google/packetdrill
Running: ./packetdrill/run_all.py -S -v -L -l tcp/

I wonder if you mind this change which might be unpredictable, how
about this one:
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 95caf8aaa8be..3bf7d9fd2d6b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -231,11 +231,13 @@ void tcp_select_initial_window(const struct sock
*sk, int __space, __u32 mss,
         */
        if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windo=
ws))
                (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
-       else
-               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);

-       if (init_rcv_wnd)
+       if (init_rcv_wnd) {
+               *rcv_wnd =3D space;
                *rcv_wnd =3D min(*rcv_wnd, init_rcv_wnd * mss);
+       } else {
+               *rcv_wnd =3D min_t(u32, space, U16_MAX);
+       }

        *rcv_wscale =3D 0;
        if (wscale_ok) {
?

It affects/changes the TCP stack only when the user tries to use 'ip
route' to set initrwnd.

Thanks,
Jason

>
> > especially because it allows DRS behavior to be consistent for large
> > MTU (eg MTU 9000) and bigger tcp_rmem[1],
> > even without playing with initrwnd attribute.
> >
> > "ss -temoi " would display after connection setup  rcv_space:89600
> > instead of a capped value.
> >
> > [1] This is hard to say, DRS is full of surprises.
>
> To avoid confusion, I will remove this link and relevant statements.
>
> Here are my opinions in conclusion:
> 1) this change doesn't break the law, I mean, various RFCs.
> 2) this change allows us to have the same behaviour as 2018 in this case.
> 3) this change does some good things to certain cases, especially for
> the CDN team.
>
> I'll refine the changelog as far as I can, hoping it will not confuse
> the readers.
>
> Thanks,
> Jason

