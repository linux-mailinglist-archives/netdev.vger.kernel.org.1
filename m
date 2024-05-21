Return-Path: <netdev+bounces-97309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E638CAAF1
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514FDB21A93
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5260279;
	Tue, 21 May 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIQEmQKv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13055C29
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284636; cv=none; b=YWE6v2CaJm/0nBVWDHTj+/mNQiv1PXdsCZ/F0V0XxXknF8r1k+rhwbZOR4XJikGd2HloTpkIwOdBA2Ir+zv0QUdcDSgF0FnAJRpcr77ZN5xVbaiifYbxySvxku8Su5+c+iJiyI1ghIbt0Mtsba2SHXR0C90bgHR3xcWonSzkxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284636; c=relaxed/simple;
	bh=pJZqDRDD/9Hh9SrHLI76Q9X2eFLs4jpmapixpMKMwoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYXCe2XrLf5umxuPaDUkQ09HDD1Q0SgMm4swoBY1aciZkPILgcEVfqeF8OhIKQEEB/5lES62ZTloXG+HcKvMCAY+iIfA1t8nwznfPGf5z/vNikO/isGd7L3M/LsnK+Qf80l2Dtd5x4U6wCL2chyvuBvg56Zih2wBcQn38fCTRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIQEmQKv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso27833a12.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716284633; x=1716889433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEkfwRDKM9l+Gxx0Q9+PRGn0v/pNQncnl6GFtS7K7e4=;
        b=NIQEmQKvJCSMNkViFWdc0/uxVjzjrA9idTCjiVcko5Ax/dqOXRw9UY/Ry5iC6waaDX
         s/RrEVbIakcphDXKEuvcBO/Xe4DoMKLC5NA4Dh4LED7NYecQurxdyhA9FI8RRkLbbnFP
         rcRtmF7gOsgr4RAQ75Va8pWMiIbi77EnqrMqzalhW/Fjmhxm9DjH6BRh1mpgcNCoL2Bo
         +hcFry9p4sg6AGhHf/keuqsQ0v/UaS3a1J/HH5NmBaf1grbu9eCv9l6ThhvSfBtJXQHK
         EbgFoDLA+hMSM3/bt5vQC3hAtkd0dOEeOO6prBaM5U73SPcJJ8N9U/Owx/0wxqHjU+34
         L0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284633; x=1716889433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEkfwRDKM9l+Gxx0Q9+PRGn0v/pNQncnl6GFtS7K7e4=;
        b=sfyBL2EOHsQLPGY/sZ9OMd6ISs/HfDagR9xiDEkzH0QCUglo0WGtLYxCBtLbXy4PBx
         NS7msK8GLR8bVNXFwaKb/jJhhQFo1YE5FRuUigFt8hhFN3mVR/g3G3FM5L369qkLgv0g
         8IpCvzJgSH/3qwBJVpqZ53y/0KUpMbqDjaSr5R2tyxO6875aMv+Xxb5Dm+dxfduYsalY
         G6rWxGRaiBQn78ANlIUbF3p9PON1LoMCyI5UM69rDnTz/+YOVXgmzTWfSDnrfqNNUp4j
         vNvAe6uSBQQE6g3GyYn0QFPI47YO1pZlj6XweKoMW6ECx/nDiN1vKf66uR5dKvoLYu7Y
         V8pw==
X-Forwarded-Encrypted: i=1; AJvYcCUwQIfwr6Wk+GwVwZGfpcPQvefQV4drohRSAndHgRLUME2plgAkepU4OsCyOZhrlNDPPrQJkonBKL7KGRFVIDqjpxDuTTY8
X-Gm-Message-State: AOJu0YwT1acS7fpAql6QqHPflwWdaCEZu9Z/y4+GROtoe2mKROgQx3xS
	SFB/kTQelAI9dv8zt9hrUczH5s+Iw9k6SMBsCqaEjH01bxtZzhEXCcEC8NoidP79lZZox9X/UHU
	PeXBmb/J8wg56Mbgt6nEAF5Rd999Zmap8mbR8
X-Google-Smtp-Source: AGHT+IGqnurdRwCxu+/OZ80iJhHE6XtQx8gu5JMBGcfi7O6GQ219wroMRM89635OVG6g7df2qx17a79YED6KlTlhGSY=
X-Received: by 2002:a05:6402:42ce:b0:572:9eec:774f with SMTP id
 4fb4d7f45d1cf-5752a4268d9mr600315a12.0.1716284630959; Tue, 21 May 2024
 02:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518025008.70689-1-kerneljasonxing@gmail.com>
 <CANn89iJqmp36tYxFgrTYqZ69EFc9c=eK69dhfPhriAwpk-fW-A@mail.gmail.com>
 <CAL+tcoB3ZXhYfGbdmR2ARit9VW9550wUXtaXroJ714Z6e0Hz=A@mail.gmail.com> <CAL+tcoCCznKP8Jb8poy90+9azjZ+1467oF8KGeT5vQwFQZ_trg@mail.gmail.com>
In-Reply-To: <CAL+tcoCCznKP8Jb8poy90+9azjZ+1467oF8KGeT5vQwFQZ_trg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 May 2024 11:43:36 +0200
Message-ID: <CANn89i+M2ErRFF_Jgj6jE=0jDws50euKnr7KHEm4vH8=_VF0kQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 net-next] tcp: remove 64 KByte limit for initial
 tp->rcv_wnd value
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:56=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Tue, May 21, 2024 at 8:36=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Tue, May 21, 2024 at 12:51=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Sat, May 18, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN=
 rwin
> > > > to around 64KB") limited the initial value of tp->rcv_wnd to 65535,=
 most
> > > > CDN team would not benefit from this change because they cannot hav=
e a
> > > > large window to receive a big packet, which will be slowed down esp=
ecially
> > > > in long RTT.
> > > >
> > > > According to RFC 7323, it says:
> > > >   "The maximum receive window, and therefore the scale factor, is
> > > >    determined by the maximum receive buffer space."
> > >
> > > This seems not relevant ?  wscale factor is not changed in this patch=
 ?
> > > tp->rcv_wnd is also not the maximum receive window.
> >
> > Thanks for your review.
> >
> > I can remove this part. I was trying to claim I do not break RFC.
> >
> > >
> > > >
> > > > So we can get rid of this 64k limitation and let the window be tuna=
ble if
> > > > the user wants to do it within the control of buffer space. Then ma=
ny
> > > > companies, I believe, can have the same behaviour as old days.
> > >
> > > Not sure this has ever worked, see below.
> > >
> > > Also, the "many companies ..." mention has nothing to do in a changel=
og.
> >
> > Oh, I just copied/translated from my initial studies of this rcv_wnd
> > by reading many papers something like this.
> >
> > I can also remove this sentence.
> >
> > >
> > >
> > > > Besides,
> > > > there are many papers conducting various interesting experiments wh=
ich
> > > > have something to do with this window and show good outputs in some=
 cases,
> > > > say, paper [1] in Yahoo! CDN.
> > >
> > > I think this changelog is trying hard to sell something, but in
> > > reality TCP 3WHS nature
> > > makes your claims wrong.
> > >
> > > Instead, you should clearly document that this problem can _not_ be
> > > solved for both
> > > active _and_ passive connections.
> > >
> > > In the first RTT, a client (active connection) can not send more than
> > > 64KB, if TCP specs
> > > are properly applied.
> >
> > Having a large rcv_wnd if the user can tweak this knob can help
> > transfer data more rapidly. I'm not referring to the first RTT.
> >
> > >
> > > >
> > > > To avoid future confusion, current change doesn't affect the initia=
l
> > > > receive window on the wire in a SYN or SYN+ACK packet which are set=
 within
> > > > 65535 bytes according to RFC 7323 also due to the limit in
> > > > __tcp_transmit_skb():
> > > >
> > > >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
> > > >
> > > > In one word, __tcp_transmit_skb() already ensures that constraint i=
s
> > > > respected, no matter how large tp->rcv_wnd is.
> > > >
> > > > Let me provide one example if with or without the patch:
> > > > Before:
> > > > client   --- SYN: rwindow=3D65535 ---> server
> > > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > > client   --- ACK: rwindow=3D65536 ---> server
> > > > Note: for the last ACK, the calculation is 512 << 7.
> > > >
> > > > After:
> > > > client   --- SYN: rwindow=3D65535 ---> server
> > > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > > client   --- ACK: rwindow=3D175232 ---> server
> > > > Note: I use the following command to make it work:
> > > > ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> > > > For the last ACK, the calculation is 1369 << 7.
> > > >
> > > > We can pay attention to the last ACK in 3-way shakehand and notice =
that
> > > > with the patch applied the window can reach more than 64 KByte.
> > >
> > > You carefully avoided mentioning the asymmetry.
> > > I do not think this is needed in the changelog, because this is addin=
g
> > > confusion.
> >
> > What kind of case I've met in production is only about whether we're
> > capable of sending more data at the same time at the very beginning,
> > so I care much more about the sending process right now.
> >
> > >
> > > >
> > > > [1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > v2
> > > > Link: https://lore.kernel.org/all/20240517085031.18896-1-kerneljaso=
nxing@gmail.com/
> > > > 1. revise the title and body messages (Neal)
> > > > ---
> > > >  net/ipv4/tcp_output.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > > index 95caf8aaa8be..95618d0e78e4 100644
> > > > --- a/net/ipv4/tcp_output.c
> > > > +++ b/net/ipv4/tcp_output.c
> > > > @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct soc=
k *sk, int __space, __u32 mss,
> > > >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_sign=
ed_windows))
> > > >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> > > >         else
> > > > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> > > > +               (*rcv_wnd) =3D space;
> > >
> > > This is probably breaking some  packetdrill tests, but your change
> > > might [1] be good,
> >
> > I'll do some packetdrill tests and get back some information soon.
>
> I'm done with the packetdrill tests[1]. Here are two tests failed
> after comparing with/without this patch:
> 1) ./packetdrill/run_all.py -S -v -L -l tcp/ioctl/ioctl-siocinq-fin.pkt
> 2) ./packetdrill/run_all.py -S -v -L -l
> tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt
>
> For the first one, it shows:
> "FAIL [/data/home/kernelxing/source_code/packetdrill/gtests/net/tcp/ioctl=
/ioctl-siocinq-fin.pkt
> (ipv6)]
> stdout:
> stderr:
> ioctl-siocinq-fin.pkt:28: error handling packet: timing error:
> expected outbound packet at 0.302321 sec but happened at 0.342759 sec;
> tolerance 0.004000 sec
> script packet:  0.302321 . 1:1(0) ack 2002
> actual packet:  0.342759 . 1:1(0) ack 2002 win 65535"
>
> For the second one, it shows:
> "client-ack-dropped-then-recovery-ms-timestamps.pkt:33: error handling
> packet: live packet field tcp_window: expected: 256 (0x100) vs actual:
> 532 (0x214)
> script packet:  0.012251 P. 1:5001(5000) ack 1001 win 256 <nop,nop,TS
> val 2010 ecr 1000>
> actual packet:  0.012242 P. 1:5001(5000) ack 1001 win 532 <nop,nop,TS
> val 2010 ecr 1000>
> Ran    3 tests:    0 passing,    3 failing,    0 timed out (0.91 sec):
> tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt"
>
> The reason is unexpected window size. Since I removed the limit of
> 64KB, It is expected from my view.

I think you misunderstood what I was saying.

Basically, this change will break some packetdrill tests, and this is fine,
because those packetdrill tests were relying on a prior kernel behavior tha=
t
was not set in stone (certainly not documented)

>
> [1]: https://github.com/google/packetdrill
> Running: ./packetdrill/run_all.py -S -v -L -l tcp/
>
> I wonder if you mind this change which might be unpredictable, how
> about this one:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 95caf8aaa8be..3bf7d9fd2d6b 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -231,11 +231,13 @@ void tcp_select_initial_window(const struct sock
> *sk, int __space, __u32 mss,
>          */
>         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_win=
dows))
>                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> -       else
> -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
>
> -       if (init_rcv_wnd)
> +       if (init_rcv_wnd) {
> +               *rcv_wnd =3D space;
>                 *rcv_wnd =3D min(*rcv_wnd, init_rcv_wnd * mss);
> +       } else {
> +               *rcv_wnd =3D min_t(u32, space, U16_MAX);
> +       }
>
>         *rcv_wscale =3D 0;
>         if (wscale_ok) {
> ?
>
> It affects/changes the TCP stack only when the user tries to use 'ip
> route' to set initrwnd.

I much prefer the prior and simpler version.

Only the changelog was not very good IMO.

Also, I think this is fixing a bug and should target the net tree.

If it took 6 years to discover the unwanted side effects, we should
make sure the fix
is backported by stable teams, thanks to an appropriate Fixes: tag.


>
> Thanks,
> Jason
>
> >
> > > especially because it allows DRS behavior to be consistent for large
> > > MTU (eg MTU 9000) and bigger tcp_rmem[1],
> > > even without playing with initrwnd attribute.
> > >
> > > "ss -temoi " would display after connection setup  rcv_space:89600
> > > instead of a capped value.
> > >
> > > [1] This is hard to say, DRS is full of surprises.
> >
> > To avoid confusion, I will remove this link and relevant statements.
> >
> > Here are my opinions in conclusion:
> > 1) this change doesn't break the law, I mean, various RFCs.
> > 2) this change allows us to have the same behaviour as 2018 in this cas=
e.
> > 3) this change does some good things to certain cases, especially for
> > the CDN team.
> >
> > I'll refine the changelog as far as I can, hoping it will not confuse
> > the readers.
> >
> > Thanks,
> > Jason

