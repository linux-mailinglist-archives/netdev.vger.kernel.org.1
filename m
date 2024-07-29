Return-Path: <netdev+bounces-113694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F0293F981
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1E4282DB9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32025155CB8;
	Mon, 29 Jul 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAjSQxZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3513BC3F
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267183; cv=none; b=qDy+pZtLjOTKSTSyZ+0gpbgZQ7p0jJYR1PfrBmI8JO3hVKo6M+KIi71Ab9zoPIyWPT6QCfiGvayPA/5Z83p6qBmGryrfnuycMxa1YH7uZ5GbTTHoq6JyQxf7b0gQYciTaoxhnl/An7IrPjIsLOhFCnK+hThZLv00sVtHPk9lE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267183; c=relaxed/simple;
	bh=EatdYnrk9SJ0RzhQhszpMx76qS24gl6IteKnoIYpPYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZ8shcOzsTdcOXhDVh4voCI4oGllbOzW0AC/Z84iIGnWv7rH4tzOUX5xnJxVmzLrq3xaxgwEnwJCDXw17uK28g5B64HR2vbTKR+EtibMQBtDAMC3169ohy8Zkd8J4KE8d2QBKcgbYhSqQUBi++xMFqZ6XDrodnp0UfW6nOsj1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAjSQxZ1; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db35ec5688so685626b6e.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722267180; x=1722871980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSX2ccpIFReiDiByaCNe0zTPO5plfuQgyMpXUr7ZZR0=;
        b=HAjSQxZ1fc9yPYkwYUdCp/xINXGGB6QVS9ezvmw9+qurwHdasWvQqRhSmTB8N6Wudp
         MWs2mPnjNi/jBcftuqrk8B0xJh4GYe+62iDFk6HcuBMebC4R5yS5q3hQKrYGMCPupSOU
         nNhi52PWz8gYgSf8jrFTDGPeHxss5iPfyAEV4k+mkOE5FTDxEp8ksPKEWoYZp1ukCvlK
         E0qJZpJccot+ZVhMyrW63wiH04tBsUX2Srh9RHPb3wBJMqTSjv5tJSiUv/O9PkYBXUQ0
         rAlXckxEuEunwHY4qaLLNL++U/khn9lzel+u+WpE1p4RvdAacyx2BG4TGF9loJbe7Jf+
         hSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267180; x=1722871980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSX2ccpIFReiDiByaCNe0zTPO5plfuQgyMpXUr7ZZR0=;
        b=dVNVAmo6aF7Pe8CEJZmYYDDkXRr4L8l6fCpaPUEdnxAmOxj+XfWlKh9NpJKlddadja
         7MMF+cgkUwbpvzW/nN0HpQzEfHTSxv11FjcxtF4xiShIGzSVr9hmk+TEYApwv2Y3k5sa
         aVESW2WmcfCtb6ClblZtLVDXITBoTkwc7LgNZ33hJHjIg3H8/ACxF296ObGAujFsuLjp
         33V8uu60mNOWi56JEQnHspob+MXxlqEgImPZP6sKXDYYwln2uo7gOcIuP6G2eZ966VVD
         F/hHHHR5r67AalDkp2/yJKZ5RfiX3bpImiRxV8ID0NM1nytPcbF5Ce96sran8fdLCN9Z
         C3qw==
X-Forwarded-Encrypted: i=1; AJvYcCXu3oOgI+3L168egTJyC6AwgUUjT11P67CXZA0jTKhSi/crLKCLTzBzb5KqDDg8/bOuFkHTHe7V/2uwPrX8vr9ay5tfOVm6
X-Gm-Message-State: AOJu0YxbJ/6DenaZrhnaWZe3Xpd/q89na/doKUoFvYRejJ+TtmFVDSTZ
	nezkp4T62LO7jcZO+tU1timkEsJ/hEPJx49rpOYKNxOu25FgxRT1YxAAfsw55moTTc3F+IUpVr+
	/PmWV/Lc4fKU5Gtf8jstEOVqW2GKxIceJaHRY
X-Google-Smtp-Source: AGHT+IGtj5JSoJqWQo6jp6/ue9T60eRHZryETKAuZX9+Cfi0DB+TayKvCGAyrO7CDAysl4iFeEBeLLSk1YQ1zx6BbOw=
X-Received: by 2002:a05:6358:715:b0:1aa:bf62:67d2 with SMTP id
 e5c5f4694b2df-1adc06edfb9mr881746255d.25.1722267180166; Mon, 29 Jul 2024
 08:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726204105.1466841-1-quic_subashab@quicinc.com>
 <CADVnQynKT7QEhm1WksrNQv3BbYhTd=wWaxueybPBQDPtXbJu-A@mail.gmail.com> <CANn89i+eVKrGp2_xU=GsX5MDDg6FZsGS3u4wX2f1qA7NnHYJCg@mail.gmail.com>
In-Reply-To: <CANn89i+eVKrGp2_xU=GsX5MDDg6FZsGS3u4wX2f1qA7NnHYJCg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 29 Jul 2024 11:32:40 -0400
Message-ID: <CADVnQynUV+gqdH4gKhYKRqW_MpQ5gvMo5n=HHCa08uQ8wBbF_A@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Eric Dumazet <edumazet@google.com>
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, soheil@google.com, yyd@google.com, 
	ycheng@google.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Jul 29, 2024 at 4:51=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Fri, Jul 26, 2024 at 4:41=E2=80=AFPM Subash Abhinov Kasiviswanathan
> > <quic_subashab@quicinc.com> wrote:
> > >
> > > tp->scaling_ratio is not updated based on skb->len/skb->truesize once
> > > SO_RCVBUF is set leading to the maximum window scaling to be 25% of
> > > rcvbuf after
> > > commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > > and 50% of rcvbuf after
> > > commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio").
> > > 50% tries to emulate the behavior of older kernels using
> > > sysctl_tcp_adv_win_scale with default value.
> > >
> > > Systems which were using a different values of sysctl_tcp_adv_win_sca=
le
> > > in older kernels ended up seeing reduced download speeds in certain
> > > cases as covered in https://lists.openwall.net/netdev/2024/05/15/13
> > > While the sysctl scheme is no longer acceptable, the value of 50% is
> > > a bit conservative when the skb->len/skb->truesize ratio is later
> > > determined to be ~0.66.
> > >
> > > Applications not specifying SO_RCVBUF update the window scaling and
> > > the receiver buffer every time data is copied to userspace. This
> > > computation is now used for applications setting SO_RCVBUF to update
> > > the maximum window scaling while ensuring that the receive buffer
> > > is within the application specified limit.
> > >
> > > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > > Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> > > Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.=
com>
> > > ---
> > > v1 -> v2
> > >   Update the condition for SO_RCVBUF window_clamp updates to always
> > >   monitor the current rcvbuf value as suggested by Eric.
> > >
> > >  net/ipv4/tcp_input.c | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 454362e359da..e2b9583ed96a 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -754,8 +754,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
> > >          * <prev RTT . ><current RTT .. ><next RTT .... >
> > >          */
> > >
> > > -       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) =
&&
> > > -           !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> > > +       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf))=
 {
> > >                 u64 rcvwin, grow;
> > >                 int rcvbuf;
> > >
> > > @@ -771,12 +770,22 @@ void tcp_rcv_space_adjust(struct sock *sk)
> > >
> > >                 rcvbuf =3D min_t(u64, tcp_space_from_win(sk, rcvwin),
> > >                                READ_ONCE(sock_net(sk)->ipv4.sysctl_tc=
p_rmem[2]));
> > > -               if (rcvbuf > sk->sk_rcvbuf) {
> > > -                       WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> > > +               if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> > > +                       if (rcvbuf > sk->sk_rcvbuf) {
> > > +                               WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> > >
> > > -                       /* Make the window clamp follow along.  */
> > > -                       WRITE_ONCE(tp->window_clamp,
> > > -                                  tcp_win_from_space(sk, rcvbuf));
> > > +                               /* Make the window clamp follow along=
.  */
> > > +                               WRITE_ONCE(tp->window_clamp,
> > > +                                          tcp_win_from_space(sk, rcv=
buf));
> > > +                       }
> > > +               } else {
> > > +                       /* Make the window clamp follow along while b=
eing bounded
> > > +                        * by SO_RCVBUF.
> > > +                        */
> > > +                       int clamp =3D tcp_win_from_space(sk, min(rcvb=
uf, sk->sk_rcvbuf));
> > > +
> > > +                       if (clamp > tp->window_clamp)
> > > +                               WRITE_ONCE(tp->window_clamp, clamp);
> > >                 }
> > >         }
> > >         tp->rcvq_space.space =3D copied;
> > > --
> >
> > Is this the correct place to put this new code to update
> > tp->window_clamp? AFAICT it's not the correct place.
> >
> > If a system administrator has disabled receive buffer autotuning by
> > setting `sysctl net.ipv4.tcp_moderate_rcvbuf=3D0`, or if (copied <=3D
> > tp->rcvq_space.space), then TCP connections will not reach this new
> > code, and the window_clamp will not be adjusted, and the receive
> > window will still be too low.
> >
> > Even if a system administrator has disabled receive buffer autotuning
> > by setting `sysctl net.ipv4.tcp_moderate_rcvbuf=3D0`, or even if (copie=
d
> > <=3D tp->rcvq_space.space), AFAICT we still want the correct receive
> > window value for whatever sk->sk_rcvbuf we have, based on the correct
> > tp->scaling_ratio.
> >
> > So AFAICT the correct place to put this kind of logic is in
> > tcp_measure_rcv_mss(). If we compute a new scaling_ratio and it's
> > different than tp->scaling_ratio, then it seems we should compute a
> > new window_clamp value using sk->sk_rcvbuf, and if the new
> > window_clamp value is different then we should WRITE_ONCE that value
> > into tp->window_clamp.
> >
> > That way we can have the correct tp->window_clamp, no matter the value
> > of net.ipv4.tcp_moderate_rcvbuf, and even if (copied <=3D
> > tp->rcvq_space.space).
> >
> > How does that sound?
>
> Can this be done without adding new code in the fast path ?

I was imagining that the code would not really be in the fast path,
because it would move to the spot in tcp_measure_rcv_mss() where the
segment length "len" is greater than icsk->icsk_ack.rcv_mss. I imagine
that should be rare, and we are already doing a somewhat expensive
do_div() call there, so I was imagining that the additional cost would
be relatively rare and small?

> Otherwise, I feel that we send a wrong signal to 'administrators' :
> "We will maintain code to make sure that wrong sysctls settings were
> not so wrong."
>
> Are you aware of anyone changing net.ipv4.tcp_moderate_rcvbuf for any
> valid reason ?

No, I'm not aware of any valid reason to disable
net.ipv4.tcp_moderate_rcvbuf. :-)

Even if tcp_moderate_rcvbuf is enabled, AFAICT there is still the
issue that if (copied <=3D tp->rcvq_space.space) we will not get to this
code...

neal

