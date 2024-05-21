Return-Path: <netdev+bounces-97348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F88CAF19
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F97B20A82
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC6770F1;
	Tue, 21 May 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZqXdTCi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D9757F7
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297155; cv=none; b=EQ/2HbfAqrVpCz+3KSbBj1xqAKcF4ahn/MYznzR31kWVGEiGNAUJMgzi0EKtIS0eAA/TBQqbI6J4HzK6WJkco54p8Uqt624S6qLKkW29Yr4TtVlhbhd1bM1kU6VpHL9SQMRClXUQeVAVkYXwyu5iJkJc5bA9wj6iTVk/gCZ76Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297155; c=relaxed/simple;
	bh=hvUZ2qBzW989z9SAumAP862WdUQv6KeW6UQeYcgiKmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAnpxs3BKoGXrGsWkIWcStjDHJAHNEGT+/xtYnaWhJ2OX3mZGwV4+oENGlDqQGFliUZT0X5JnJQ5InzWZSibyUOgQ+ef36dpr/965i2tWe+w2gm6yw4SC4zjMXIfg+ZA9Yunci2BGlKqUCS2+ytLW2DcQ+QZkBEguw3fDyZtTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZqXdTCi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a61b70394c0so236790466b.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716297150; x=1716901950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSPEml1id7SscCmycuF5Ar9ecIa0ar1y03+opr94TcI=;
        b=XZqXdTCiOwoPFmPJqRfsrzUKw2FcQjLRQPbGGk/midWz3YhzcdlrjDxK/KFLhIG1oY
         ypIQ1a3i0nCzj8ea9+aaWFrd+b5/vwGIaGQ4bLjH70pxmBlXZRUV3kYHjKt5cKOsc7K2
         ggq8qs2TOZmdPGlmpBQjcYjoLORDk8FuBbkQpgX+9O+e3iHOWYBOA2Ck18z1TdscCbdl
         dUPd+yf7+PCc1DZvZkaFZkTl56U6Lj/WRfJA65ljL15xegfnblMFBPn481/M75D5aEap
         DfLufphRkGU8wZ6Wqx8yQUbkU/GopTjCtAOOrFJmg1kOVxLKfTr/gPEke8m0VsvZFUjc
         LnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716297150; x=1716901950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSPEml1id7SscCmycuF5Ar9ecIa0ar1y03+opr94TcI=;
        b=i8foAmjC2GtHBYXndcdN7btUJsUaLogmuz95Ijr1l/jPGTssng80YYM5pHE7byMPTX
         N8wsQr/GzFfANbiSe9q5Wp/5R4MsOiqiXRQbrO5dw4ukz3jSXQIj1pltdH7Gy47dYrUK
         oAw8nfIEEeYKcaPD9XgNw4QNwwqPCkxD98+VfpXd15YKeMjoc7P7b2YQHaus1W1Ia2O+
         2ZweocXNtsweZkZqZpG/yzio2R3qYZrdTLO2HL8/PEDWI4MaNSdbrUsSzra4g4p3YMfo
         /m04FRdpiuk93PG6i9ch8675YH0P4EAv6cqC4XkEAGdrwvf06/h9wb45prG2qVcHao3Z
         eJAw==
X-Forwarded-Encrypted: i=1; AJvYcCUD8uCusntIyFk2Ytwo5GUpD5bkldbQ/xaURSsRZcqwxE4JjiCSXi0c9y5EJpbwfffRq+F6OJZ9gjIr8HNLTMQPSZ1cs9jN
X-Gm-Message-State: AOJu0YwhesTvtTIGZBo/NTtYl+1jjWpiJNmzN0llnUAMXCgXKlleSrWt
	TxZHOHQd1HqUGSO28WXWfkvLmeKFZDxHtcnhJQwMBhLblVfxLSwtcpUWjljmeNsI9qnJMEBQTrM
	87OMPCNp5mlVOZZwHQgh/KUbQ10A=
X-Google-Smtp-Source: AGHT+IH+6/RQaO0j8e5fEAx7ygp/2AUoJsujWNEOmDtIU9n8qtUh1Tn1g9ze1RHPi9b8Ra1UkZAvF5mZlKgBGKkOjR4=
X-Received: by 2002:a17:906:78b:b0:a59:ba2b:590e with SMTP id
 a640c23a62f3a-a5a2d65f27dmr1937984166b.48.1716297150124; Tue, 21 May 2024
 06:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518025008.70689-1-kerneljasonxing@gmail.com>
 <CANn89iJqmp36tYxFgrTYqZ69EFc9c=eK69dhfPhriAwpk-fW-A@mail.gmail.com>
 <CAL+tcoB3ZXhYfGbdmR2ARit9VW9550wUXtaXroJ714Z6e0Hz=A@mail.gmail.com>
 <CAL+tcoCCznKP8Jb8poy90+9azjZ+1467oF8KGeT5vQwFQZ_trg@mail.gmail.com> <CANn89i+M2ErRFF_Jgj6jE=0jDws50euKnr7KHEm4vH8=_VF0kQ@mail.gmail.com>
In-Reply-To: <CANn89i+M2ErRFF_Jgj6jE=0jDws50euKnr7KHEm4vH8=_VF0kQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 May 2024 21:11:53 +0800
Message-ID: <CAL+tcoBzijiKSwJdy6AhLH2Po+8b3sKUScvEAzKLFJea_KGvsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 net-next] tcp: remove 64 KByte limit for initial
 tp->rcv_wnd value
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, May 21, 2024 at 8:56=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Tue, May 21, 2024 at 8:36=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Eric,
> > >
> > > On Tue, May 21, 2024 at 12:51=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Sat, May 18, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and S=
YN rwin
> > > > > to around 64KB") limited the initial value of tp->rcv_wnd to 6553=
5, most
> > > > > CDN team would not benefit from this change because they cannot h=
ave a
> > > > > large window to receive a big packet, which will be slowed down e=
specially
> > > > > in long RTT.
> > > > >
> > > > > According to RFC 7323, it says:
> > > > >   "The maximum receive window, and therefore the scale factor, is
> > > > >    determined by the maximum receive buffer space."
> > > >
> > > > This seems not relevant ?  wscale factor is not changed in this pat=
ch ?
> > > > tp->rcv_wnd is also not the maximum receive window.
> > >
> > > Thanks for your review.
> > >
> > > I can remove this part. I was trying to claim I do not break RFC.
> > >
> > > >
> > > > >
> > > > > So we can get rid of this 64k limitation and let the window be tu=
nable if
> > > > > the user wants to do it within the control of buffer space. Then =
many
> > > > > companies, I believe, can have the same behaviour as old days.
> > > >
> > > > Not sure this has ever worked, see below.
> > > >
> > > > Also, the "many companies ..." mention has nothing to do in a chang=
elog.
> > >
> > > Oh, I just copied/translated from my initial studies of this rcv_wnd
> > > by reading many papers something like this.
> > >
> > > I can also remove this sentence.
> > >
> > > >
> > > >
> > > > > Besides,
> > > > > there are many papers conducting various interesting experiments =
which
> > > > > have something to do with this window and show good outputs in so=
me cases,
> > > > > say, paper [1] in Yahoo! CDN.
> > > >
> > > > I think this changelog is trying hard to sell something, but in
> > > > reality TCP 3WHS nature
> > > > makes your claims wrong.
> > > >
> > > > Instead, you should clearly document that this problem can _not_ be
> > > > solved for both
> > > > active _and_ passive connections.
> > > >
> > > > In the first RTT, a client (active connection) can not send more th=
an
> > > > 64KB, if TCP specs
> > > > are properly applied.
> > >
> > > Having a large rcv_wnd if the user can tweak this knob can help
> > > transfer data more rapidly. I'm not referring to the first RTT.
> > >
> > > >
> > > > >
> > > > > To avoid future confusion, current change doesn't affect the init=
ial
> > > > > receive window on the wire in a SYN or SYN+ACK packet which are s=
et within
> > > > > 65535 bytes according to RFC 7323 also due to the limit in
> > > > > __tcp_transmit_skb():
> > > > >
> > > > >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
> > > > >
> > > > > In one word, __tcp_transmit_skb() already ensures that constraint=
 is
> > > > > respected, no matter how large tp->rcv_wnd is.
> > > > >
> > > > > Let me provide one example if with or without the patch:
> > > > > Before:
> > > > > client   --- SYN: rwindow=3D65535 ---> server
> > > > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > > > client   --- ACK: rwindow=3D65536 ---> server
> > > > > Note: for the last ACK, the calculation is 512 << 7.
> > > > >
> > > > > After:
> > > > > client   --- SYN: rwindow=3D65535 ---> server
> > > > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > > > client   --- ACK: rwindow=3D175232 ---> server
> > > > > Note: I use the following command to make it work:
> > > > > ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> > > > > For the last ACK, the calculation is 1369 << 7.
> > > > >
> > > > > We can pay attention to the last ACK in 3-way shakehand and notic=
e that
> > > > > with the patch applied the window can reach more than 64 KByte.
> > > >
> > > > You carefully avoided mentioning the asymmetry.
> > > > I do not think this is needed in the changelog, because this is add=
ing
> > > > confusion.
> > >
> > > What kind of case I've met in production is only about whether we're
> > > capable of sending more data at the same time at the very beginning,
> > > so I care much more about the sending process right now.
> > >
> > > >
> > > > >
> > > > > [1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > > v2
> > > > > Link: https://lore.kernel.org/all/20240517085031.18896-1-kernelja=
sonxing@gmail.com/
> > > > > 1. revise the title and body messages (Neal)
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
> > > > This is probably breaking some  packetdrill tests, but your change
> > > > might [1] be good,
> > >
> > > I'll do some packetdrill tests and get back some information soon.
> >
> > I'm done with the packetdrill tests[1]. Here are two tests failed
> > after comparing with/without this patch:
> > 1) ./packetdrill/run_all.py -S -v -L -l tcp/ioctl/ioctl-siocinq-fin.pkt
> > 2) ./packetdrill/run_all.py -S -v -L -l
> > tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt
> >
> > For the first one, it shows:
> > "FAIL [/data/home/kernelxing/source_code/packetdrill/gtests/net/tcp/ioc=
tl/ioctl-siocinq-fin.pkt
> > (ipv6)]
> > stdout:
> > stderr:
> > ioctl-siocinq-fin.pkt:28: error handling packet: timing error:
> > expected outbound packet at 0.302321 sec but happened at 0.342759 sec;
> > tolerance 0.004000 sec
> > script packet:  0.302321 . 1:1(0) ack 2002
> > actual packet:  0.342759 . 1:1(0) ack 2002 win 65535"
> >
> > For the second one, it shows:
> > "client-ack-dropped-then-recovery-ms-timestamps.pkt:33: error handling
> > packet: live packet field tcp_window: expected: 256 (0x100) vs actual:
> > 532 (0x214)
> > script packet:  0.012251 P. 1:5001(5000) ack 1001 win 256 <nop,nop,TS
> > val 2010 ecr 1000>
> > actual packet:  0.012242 P. 1:5001(5000) ack 1001 win 532 <nop,nop,TS
> > val 2010 ecr 1000>
> > Ran    3 tests:    0 passing,    3 failing,    0 timed out (0.91 sec):
> > tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt"
> >
> > The reason is unexpected window size. Since I removed the limit of
> > 64KB, It is expected from my view.
>
> I think you misunderstood what I was saying.
>
> Basically, this change will break some packetdrill tests, and this is fin=
e,
> because those packetdrill tests were relying on a prior kernel behavior t=
hat
> was not set in stone (certainly not documented)
>
> >
> > [1]: https://github.com/google/packetdrill
> > Running: ./packetdrill/run_all.py -S -v -L -l tcp/
> >
> > I wonder if you mind this change which might be unpredictable, how
> > about this one:
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 95caf8aaa8be..3bf7d9fd2d6b 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -231,11 +231,13 @@ void tcp_select_initial_window(const struct sock
> > *sk, int __space, __u32 mss,
> >          */
> >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_w=
indows))
> >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> > -       else
> > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> >
> > -       if (init_rcv_wnd)
> > +       if (init_rcv_wnd) {
> > +               *rcv_wnd =3D space;
> >                 *rcv_wnd =3D min(*rcv_wnd, init_rcv_wnd * mss);
> > +       } else {
> > +               *rcv_wnd =3D min_t(u32, space, U16_MAX);
> > +       }
> >
> >         *rcv_wscale =3D 0;
> >         if (wscale_ok) {
> > ?
> >
> > It affects/changes the TCP stack only when the user tries to use 'ip
> > route' to set initrwnd.
>
> I much prefer the prior and simpler version.
>
> Only the changelog was not very good IMO.
>
> Also, I think this is fixing a bug and should target the net tree.
>
> If it took 6 years to discover the unwanted side effects, we should
> make sure the fix
> is backported by stable teams, thanks to an appropriate Fixes: tag.

Oh, I see. I'll submit a new one soon.

Thanks,
Jason

