Return-Path: <netdev+bounces-97017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F938C8C44
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBC01F22F70
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B003C101CF;
	Fri, 17 May 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gkwi/EvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D961A2C19
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715970943; cv=none; b=frxZEQEzlHqcEAqmxlgKFSpG6jeQDd8iCRDvgqGED3yKSnX9vwf9VfrrQPG2+zEaB6Y3wA/aIHfuw1k2Fd8hbqX1IY2NJVSau7vZbN5+lfaNJ1eYSTYq9ES9Zj6/gdCVPejEzlox4JHpqeOG4k1Eejy6hHNQMKhRarwH/I5kfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715970943; c=relaxed/simple;
	bh=hNF0da0IkNSpvL/BRbLJm/umeR054dj8n9zbBsCtNeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiRYQWTfs+8kuZ/UqswrLkaWPPU5q0sI3ZyyPUYOxwT1+P8Zup6PgX1cgW7A5/+FblmUXLDeZUdQoGajjoTS2CpbCFAJZp2qN85DdEcy44yeEk2bDrBa/Wt7WxsisgtbEks3qnymRHCLKkenKqt7R/7m/AXpKfwxDmfuDKK+D6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gkwi/EvW; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4df3d1076b0so312840e0c.1
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715970941; x=1716575741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvzy+cseOO29oDOd57ANYjfML0Ccq0dPd9qo8HfORaQ=;
        b=Gkwi/EvWeLCGToupfrHpwcSZgYju69pAp9WbzcEpV6OSjigDpixQ1V23WOm6Pu1uoa
         VRST/j1S5AWMI7z/G7/l45SKCvA523cVJZdFxaXVeY/jp2eq8UscFfgoft4qDGjIVenu
         QuGMNxi04OoH/rG0PTUeh6mrnvnEv8jBQc4vtf7M5eJ3ENaMUGb71SCePKYPYQYrxLm4
         b9MaIF379Cih0jEHD81xAlF8qPzXwmq2ROuIasqeSU1HlZKlNYjl0p42fIJ6E2LFjSw+
         E90B8uGg6uQimF1MqeoYUxmeHibu1dVvvRfR8NBSUUgWlUsojkE8tKs8GAFUGEIUaNY4
         Lhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715970941; x=1716575741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvzy+cseOO29oDOd57ANYjfML0Ccq0dPd9qo8HfORaQ=;
        b=J9LcFyuz4mbKwoueBhQQaQBUz/gLg96WonXHlhjb4GJghwClw1XluS2fn3gJ1VAeNG
         7VULov0fcnJjH1rW/Fr3aHr3d740YEmkiv7GX1tataApx4M9H9irEO7AG9SY5wM7Qzxt
         R+84ua0gy+1mRNpUB4FuQsKeGdQGE/2NXOCnqAEUBiryJ7w3kSzjEF77Qe0fgk3LX0i3
         9tLslppzVkJ2cfdfD0yB2SjaGmO+n+q2uQOYaGlBKWvYBGU2dj/dwQpGGV/hHRjYSSrf
         +vrvEeVdTfbf2rvLL04VFSZ/QksmhnzOgD1N+y4+NxdrGQJ12TkotghUYroKYj0qvh+w
         +7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9hqBWaLrzM6g7xOpbJhM6BuFfWx5UTB8yUeekXv1jNQ5XqM0v5ZGeAr8hzucctglW4B2ZZw1gTJ9hUqHzdfgNatM1WCx7
X-Gm-Message-State: AOJu0Yw9cp9R9/NpJ5rKyZCidf4Tqg6hQozDaAqVRdFq5jHmcG5xICz8
	sXkaE+Tlt76Cz5ZVOgP/5KnP7EQr7PhdFg7R9BwY1EsVs0U5rnWlGmPXQSDOD94Lr0a+VGFi13L
	PD/wucZ3C/zwWMjph67DFdjdAZ4Aed4tPlOj2
X-Google-Smtp-Source: AGHT+IEXVXGAXmCq8Bb4wwBo8uhfImQnt3/mJJwfp3wnIo++wgODQWKKkKYE7vHHEiRT0ksUYqbfG9binAF5eiWp4vg=
X-Received: by 2002:a05:6122:2005:b0:4d3:3446:6bc9 with SMTP id
 71dfb90a1353d-4df8835ad1dmr21227267e0c.14.1715970940522; Fri, 17 May 2024
 11:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517085031.18896-1-kerneljasonxing@gmail.com>
 <CADVnQymvBSUFcc307N_geXgosJgnrx4nziFcpnX-=jU7PronwA@mail.gmail.com>
 <CAL+tcoDbB2if_=h7XSRU9_i2G=xT+fqmxCU-Mhe438PYcqxj-w@mail.gmail.com> <CAL+tcoAQSh9ScCduvhKNW9q8A7dhzA3OPuBde6t2=rsxg8=5Jg@mail.gmail.com>
In-Reply-To: <CAL+tcoAQSh9ScCduvhKNW9q8A7dhzA3OPuBde6t2=rsxg8=5Jg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 17 May 2024 14:35:22 -0400
Message-ID: <CADVnQyn1tNaAYyOA98oyV_8d0k8VA24Z4kNVcB3=QLt1Qxz6=w@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: break the limitation of initial receive window
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 1:49=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sat, May 18, 2024 at 1:41=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Fri, May 17, 2024 at 10:42=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
> > >
> > > On Fri, May 17, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Since in 2018 one commit a337531b942b ("tcp: up initial rmem to 128=
KB and
> > > > SYN rwin to around 64KB") limited received window within 65535, mos=
t CDN
> > > > team would not benefit from this change because they cannot have a =
large
> > > > window to receive a big packet one time especially in long RTT.
> > > >
> > > > According to RFC 7323, it says:
> > > >   "The maximum receive window, and therefore the scale factor, is
> > > >    determined by the maximum receive buffer space."
> > > >
> > > > So we can get rid of this 64k limitation and let the window be tuna=
ble if
> > > > the user wants to do it within the control of buffer space. Then ma=
ny
> > > > companies, I believe, can have the same behaviour as old days. Besi=
des,
> > > > there are many papers conducting various interesting experiments wh=
ich
> > > > have something to do with this window and show good outputs in some=
 cases.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
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
> > > Hmm, has this patch been tested? This doesn't look like it would work=
.
> >
> > Hello Neal,
> >
> > Thanks for the comment.
> >
> > Sure, I provided such a patch a few months ago which has been tested
> > in production for the customers.
> >
> > One example of using a much bigger initial receive window:
> > client   ---window=3D65535---> server
> > client   <---window=3D14600----  server
> > client   ---window=3D175616---> server
> >
> > Then the client could send more data than before in fewer rtt.
> >
> > Above is the output of tcpdump.
> >
> > Oh, I just found a similar case:
> > https://lore.kernel.org/all/20220213040545.365600-1-tilan7663@gmail.com=
/
> >
> > Before this, I always believed I'm not the only one who had such an iss=
ue.
> >
> > >
> > > Please note that RFC 7323 says in
> > > https://datatracker.ietf.org/doc/html/rfc7323#section-2.2 :
> > >
> > >    The window field in a segment where the SYN bit is set (i.e., a <S=
YN>
> > >    or <SYN,ACK>) MUST NOT be scaled.
> > >
> > > Since the receive window field in a SYN is unscaled, that means the
> > > TCP wire protocol has no way to convey a receive window in the SYN
> > > that is bigger than 64KBytes.
> > >
> > > That is why this code places a limit of U16_MAX on the value here.
> > >
> > > If you want to advertise a bigger receive window in the SYN, you'll
> >
> > No. It's not my original intention.
> >
> > For SYN packet itself is limited in the __tcp_transmit_skb() as below:
> >
> >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
>
> With this limitation/protection of the window in SYN packet, It would
> not break RFC with this patch applied. I try to advertise a bigger
> initRwnd of ACK in a 3-way shakehand process.

Thanks for the explanation.

I think the confusion arose because in your title ("tcp: break the
limitation of initial receive window"), I interpreted "initial receive
window" as the initial receive window advertised on the wire (which is
limited by protocol spec to 64 kbytes), when you meant the initial
value of tp->rcv_wnd. There are similar ambiguities in the commit
message body.

I would suggest resubmitting a version of the patch with a revised
commit title and commit description, to clarify at least the following
issues:

+ For the patch title, perhaps something like:
  tcp: remove 64 KByte limit for initial tp->rcv_wnd value

+ For the commit description, in the sentence 'Since in 2018 one
commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin to
around 64KB") limited received window within 65535', please revise
this to clarify that you are talking about tp->rcv_wnd and not the
receive window on the wire. For example: 'In 2018 commit a337531b942b
("tcp: up initial rmem to 128KB and SYN rwin to around 64KB") limited
the initial value of tp->rcv_wnd to 65535,.'

+ For the commit description, please add a note that RFC 7323 limits
the initial receive window on the wire in a SYN or SYN+ACK to 65535
bytes, and __tcp_transmit_skb() already ensures that constraint is
respected, no matter how large tp->rcv_wnd is.

+ For the commit description, please include some version of your
example of the receive window values in a handshake, like:

One example of using a much bigger initial receive window:
client   --- SYN: rwindow=3D65535 ---> server
client   <--- SYN+ACK: rwindow=3D14600 ----  server
client   --- ACK: rwindow=3D175616 ---> server

+ For the commit description, please include some version of your
example of the evolution of the receive window over the first 3 round
trips, before and after your patch.

thanks,
neal

