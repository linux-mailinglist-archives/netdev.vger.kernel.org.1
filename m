Return-Path: <netdev+bounces-113690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7F93F940
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4151282391
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615D14EC71;
	Mon, 29 Jul 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9uj72RN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E01E4A2
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266364; cv=none; b=aZme7vsP7PhcfUTjXLylhgt8/FStLS3ZyOxEsROGpAxIE6LVJcWeWrIJONqBiFQS2X8Zm2Vja7rCxKMDanhreOFE2t1efFLGrKNhmg9UJkX+nB1Te5LNyOwm3EulJNlWFdg0Dls2WfYwk7CEdXYVpq18Fqz34+1zUWpxTw3VZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266364; c=relaxed/simple;
	bh=WreofdgQRqIDOWch03mYUT/OG1Y7a5UUccAqKR3+1sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGvA/CjnvmW/4KoEsoHpPdHdsLgio0Wob/iSyrrIn3S4bsd8GyMCdOkzmP3VHNOw/SPFNcFzXT8ZlFyxUlCKA8FIsSBGi9f+bdvKxZlBc8oUOyBEXxonGTFQcUWFknF3tuFjgaR7xZddjgQUw59lP4wH5P5VCPr1PuXFNyHlCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9uj72RN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso14603a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722266361; x=1722871161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpTQO0qPhmqbgQDOxHTG7a76mLPeTFKZ7Kw6EpIExCU=;
        b=B9uj72RN99AHwX38hfGhPKvWdXttFZAxaQwBTCK9/c0sMlJHuUrQuOLE96NQuT6Vus
         eMSzKsbk6fhBykmQ1WBWJjZ/PMNR7zqZnhmGMcv8Nj5Otws7Dier+lD7ND4+wx92F+5J
         nu3b74kckCk0XecnbCP2WLOY3h1gr1GZ5aYzfY+0X+R8RL7xSZmzDfpF/hYrRzrPn5bd
         8yMUy+8mjLDd4YW325jIVYnVNyviGwycacWhhtwxncgFi3musBNe8B/XAqOyROfv8NmE
         QDSDabSPkuQWMTALHDIZHpwV45tbAuWANhOFW9DLHcIJ01CCWrwej+er9dtXP6zZMKO6
         fyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266361; x=1722871161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpTQO0qPhmqbgQDOxHTG7a76mLPeTFKZ7Kw6EpIExCU=;
        b=ZlHbPQ/PdngWz1kPKiJ8LHbm+MoM2+Pv30g4Ne+nRRHFDlCiEbw6vZSVvcJiX5pML9
         oH+blzXmA/GNgxavf2PmT3D4vWLMqRFEAug0wg1s6WcYn7G1NzfCArBaL3eoW3CjfsDt
         rx3o1iCRDmosbZkxUYLDfFUCCnP7UyCjeuoI1Og+ZseKZBeOy/ThzwP9sKQvfs57nRtS
         dwxeZhb5Ig1jl5onmeHWMY/3HDPvjsaaqYpubgpx+unXq35m0dkHDVc3PAOrGn3rXkf5
         RYAvY+fAZ1yy1ylDjjjcLQnTWFLn3TDZPCDpwXsPrs5CPNf9iLEHtaYeUfs4kNRmcJrT
         mNWw==
X-Forwarded-Encrypted: i=1; AJvYcCWGfKaJrHjT3RSLGY9YQMcBaow8M/lTUjWOz8PUuU6+nMPhtYtyQq2AMrzKvqZIJxTT8fB+HOwQNnYyTrqLK+QFoMwmzHQV
X-Gm-Message-State: AOJu0Yyw8uyi5KkaNZ/B1o3/bRR6I3zj01/YX89n4EYubW1tSl8O5QiJ
	3aDwuqLtjUzUFCOn5MWSVp4W1o2fcGyuFWbrB4GNe3ewUkNyYTzBfCWkSQqmV1AIUHRVKXAzycp
	j04UcLyCNslGsq2CXc2F4VpUyAoYcGBbb8Bb+0DGAfbNjurzoBsAi
X-Google-Smtp-Source: AGHT+IHtJ/HVfkUyN4CUm0vlKREZt1xaFXOw3H63OjieDj84/bdoUvnTo2cMH8EUAfO/kkM4suYcLrlJa9Ak6YESm8s=
X-Received: by 2002:a05:6402:51d0:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5b40d4a2ad8mr5950a12.6.1722266360729; Mon, 29 Jul 2024 08:19:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726204105.1466841-1-quic_subashab@quicinc.com> <CADVnQynKT7QEhm1WksrNQv3BbYhTd=wWaxueybPBQDPtXbJu-A@mail.gmail.com>
In-Reply-To: <CADVnQynKT7QEhm1WksrNQv3BbYhTd=wWaxueybPBQDPtXbJu-A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 17:19:08 +0200
Message-ID: <CANn89i+eVKrGp2_xU=GsX5MDDg6FZsGS3u4wX2f1qA7NnHYJCg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Neal Cardwell <ncardwell@google.com>
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, soheil@google.com, yyd@google.com, 
	ycheng@google.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:51=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, Jul 26, 2024 at 4:41=E2=80=AFPM Subash Abhinov Kasiviswanathan
> <quic_subashab@quicinc.com> wrote:
> >
> > tp->scaling_ratio is not updated based on skb->len/skb->truesize once
> > SO_RCVBUF is set leading to the maximum window scaling to be 25% of
> > rcvbuf after
> > commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > and 50% of rcvbuf after
> > commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio").
> > 50% tries to emulate the behavior of older kernels using
> > sysctl_tcp_adv_win_scale with default value.
> >
> > Systems which were using a different values of sysctl_tcp_adv_win_scale
> > in older kernels ended up seeing reduced download speeds in certain
> > cases as covered in https://lists.openwall.net/netdev/2024/05/15/13
> > While the sysctl scheme is no longer acceptable, the value of 50% is
> > a bit conservative when the skb->len/skb->truesize ratio is later
> > determined to be ~0.66.
> >
> > Applications not specifying SO_RCVBUF update the window scaling and
> > the receiver buffer every time data is copied to userspace. This
> > computation is now used for applications setting SO_RCVBUF to update
> > the maximum window scaling while ensuring that the receive buffer
> > is within the application specified limit.
> >
> > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> > Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.co=
m>
> > ---
> > v1 -> v2
> >   Update the condition for SO_RCVBUF window_clamp updates to always
> >   monitor the current rcvbuf value as suggested by Eric.
> >
> >  net/ipv4/tcp_input.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 454362e359da..e2b9583ed96a 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -754,8 +754,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
> >          * <prev RTT . ><current RTT .. ><next RTT .... >
> >          */
> >
> > -       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
> > -           !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> > +       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf)) {
> >                 u64 rcvwin, grow;
> >                 int rcvbuf;
> >
> > @@ -771,12 +770,22 @@ void tcp_rcv_space_adjust(struct sock *sk)
> >
> >                 rcvbuf =3D min_t(u64, tcp_space_from_win(sk, rcvwin),
> >                                READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_=
rmem[2]));
> > -               if (rcvbuf > sk->sk_rcvbuf) {
> > -                       WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> > +               if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> > +                       if (rcvbuf > sk->sk_rcvbuf) {
> > +                               WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> >
> > -                       /* Make the window clamp follow along.  */
> > -                       WRITE_ONCE(tp->window_clamp,
> > -                                  tcp_win_from_space(sk, rcvbuf));
> > +                               /* Make the window clamp follow along. =
 */
> > +                               WRITE_ONCE(tp->window_clamp,
> > +                                          tcp_win_from_space(sk, rcvbu=
f));
> > +                       }
> > +               } else {
> > +                       /* Make the window clamp follow along while bei=
ng bounded
> > +                        * by SO_RCVBUF.
> > +                        */
> > +                       int clamp =3D tcp_win_from_space(sk, min(rcvbuf=
, sk->sk_rcvbuf));
> > +
> > +                       if (clamp > tp->window_clamp)
> > +                               WRITE_ONCE(tp->window_clamp, clamp);
> >                 }
> >         }
> >         tp->rcvq_space.space =3D copied;
> > --
>
> Is this the correct place to put this new code to update
> tp->window_clamp? AFAICT it's not the correct place.
>
> If a system administrator has disabled receive buffer autotuning by
> setting `sysctl net.ipv4.tcp_moderate_rcvbuf=3D0`, or if (copied <=3D
> tp->rcvq_space.space), then TCP connections will not reach this new
> code, and the window_clamp will not be adjusted, and the receive
> window will still be too low.
>
> Even if a system administrator has disabled receive buffer autotuning
> by setting `sysctl net.ipv4.tcp_moderate_rcvbuf=3D0`, or even if (copied
> <=3D tp->rcvq_space.space), AFAICT we still want the correct receive
> window value for whatever sk->sk_rcvbuf we have, based on the correct
> tp->scaling_ratio.
>
> So AFAICT the correct place to put this kind of logic is in
> tcp_measure_rcv_mss(). If we compute a new scaling_ratio and it's
> different than tp->scaling_ratio, then it seems we should compute a
> new window_clamp value using sk->sk_rcvbuf, and if the new
> window_clamp value is different then we should WRITE_ONCE that value
> into tp->window_clamp.
>
> That way we can have the correct tp->window_clamp, no matter the value
> of net.ipv4.tcp_moderate_rcvbuf, and even if (copied <=3D
> tp->rcvq_space.space).
>
> How does that sound?

Can this be done without adding new code in the fast path ?

Otherwise, I feel that we send a wrong signal to 'administrators' :
"We will maintain code to make sure that wrong sysctls settings were
not so wrong."

Are you aware of anyone changing net.ipv4.tcp_moderate_rcvbuf for any
valid reason ?

