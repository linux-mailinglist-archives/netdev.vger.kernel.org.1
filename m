Return-Path: <netdev+bounces-85276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F489A02B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA81F21641
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1416DEAB;
	Fri,  5 Apr 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sela0LmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754516E897
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328565; cv=none; b=H2nOA/AY0ska3AMP8Pa9FbRGYQra85CdJP6Z59SMgqNleqT6b/3xZLLhQYSwADMfP8jrtJ7Vq7TzB/maEGpLtIYruMLrjFW9BIInB7+BcW+W0K9+VgvwdVkwO0GGRP6cNliyt0hqSBQqO7E+D95uV24gaRVEgTXzTY/Fvb+xVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328565; c=relaxed/simple;
	bh=tWEy3uDpUkGv8CXM0b7bl86HHSVyjxRNU/8Ley4Ukyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogIN7Ws2Jd7/9x9y/vh33WEKtsTrfPtvjTfVtaMQn8o6jEeG5q8AbQXagIuSviskOiFROdwAsfWfZ5HAkx+/qg4Url9LXPpIoFu0zL1tobnHafRc90yHqfc2idfwutW9YRT3i7seXdZ2OcsgkQVuBNbfzTHMNO44sUwlDbaolAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sela0LmX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e2e94095cso10283a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712328561; x=1712933361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3ujW/DDq8SFp5GEHP6PG0wD2WWvfF2hgMN6lRbymJ0=;
        b=sela0LmXec+//oB07XIxWCIQJ5cw7HEXXWq8mS5ofWl6s4EFJhEoOaLvSA+wmeGPtA
         RMXcgI30AIsvIESBst+S9mJSoP5h8djkglj6yuz5Zltxlvqw6bWOIeE0BLB2GjxIVl5P
         t6eROtm4EGYPdydt6Pmr/RJ+DtknCDuHPCgtTEBYwiJCnYsTZiajUj9plwkgpWA6OoIi
         wf4H6AUWiV40IqKDeihWOKAJK5gwXjGRJzYYbezMKsUBRgBBnm8ppJ4/Wu97XAjQxrCg
         Nw0brw5dQyCzcMiNelzfNroixsef6jGDrnWSDN95+z2r6nOc48SBq0T7pfdknJr2cFqi
         ZcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712328561; x=1712933361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3ujW/DDq8SFp5GEHP6PG0wD2WWvfF2hgMN6lRbymJ0=;
        b=W9ggHgcQYBRs9CBUHF7/emrf/Ps6K6x51hXrkBZWQtgdFL3BW9tttI4zACLVU/8UAR
         g4UDe5sPzjJv216ue9tv0ghVwIJ/mO24uUw2uv6v9YXSyK8lJGEpVqk9ieO4FEapdXXL
         rsWoaKIv+FZZosY6kDtjkbbfzDqTzrbyg62znGmpFqMyHvxmqzKodEP12jcQPx7hARSI
         u45SJdO6Ed0f22dZb9pm+eW4YO7icvExz5XxBZA5yNezE+UZ7d2PfGWJvtX0vDnyb5W1
         iK5cdeM2MRHqLjIS44fqrAVe8c9oAE/+MRDvBJqOXUFi1maBqRPTw5nJZVI4keLqs4zc
         abWg==
X-Forwarded-Encrypted: i=1; AJvYcCWPmNax1aim3tFVLBb4KrOqxoAD5bQBFHGbp/8VXFew9sr0z1HNbzDgmEgb9fS9QJ/Eh0ZrzAcWc35SPbdnwdVTzGhVNy3U
X-Gm-Message-State: AOJu0YwZChfi16zEAWlA6tUXo/W7AucrM55CJ3xmM+j3ix13/4+JPFhQ
	uSTXZJ6PyTn5kcj0/xZ1MJTCqIWpiXE5JIhyqfRBuGpV2OhB1/ctxpuXTxMYS+GOitqgGBNSloy
	X5UB2SaaT/5Vm3liFWQYNYNLimZI2zFwmBx8P
X-Google-Smtp-Source: AGHT+IHJhMtE2Viqwn/Uw+uK5Pp39pZf0azA8EmdOuAMjeczkqZaMa7FEPA/QCQz9MJ+rNcWHs685tI4kOSAKtOrHXg=
X-Received: by 2002:aa7:d049:0:b0:56e:ac4:e1f3 with SMTP id
 n9-20020aa7d049000000b0056e0ac4e1f3mr348063edo.7.1712328561357; Fri, 05 Apr
 2024 07:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404114231.2195171-1-edumazet@google.com> <CAL+tcoBhdqVs0ZMzifriVf+3gpLeA72HByB5TW4vJyUn+KntMA@mail.gmail.com>
In-Reply-To: <CAL+tcoBhdqVs0ZMzifriVf+3gpLeA72HByB5TW4vJyUn+KntMA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 16:49:07 +0200
Message-ID: <CANn89iK9pDX=dA78Bk-sm8p4xxSno6XgHT=s0epSes=WLwxOZA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: annotate data-races around tp->window_clamp
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:29=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Apr 4, 2024 at 7:53=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > tp->window_clamp can be read locklessly, add READ_ONCE()
> > and WRITE_ONCE() annotations.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/syncookies.c |  3 ++-
> >  net/ipv4/tcp.c        |  8 ++++----
> >  net/ipv4/tcp_input.c  | 17 ++++++++++-------
> >  net/ipv4/tcp_output.c | 18 ++++++++++--------
> >  net/ipv6/syncookies.c |  2 +-
> >  net/mptcp/protocol.c  |  2 +-
> >  net/mptcp/sockopt.c   |  2 +-
> >  7 files changed, 29 insertions(+), 23 deletions(-)
> >
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 500f665f98cbce4a3d681f8e39ecd368fe4013b1..b61d36810fe3fd62b1e5c58=
85bbaf20185f1abf0 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -462,7 +462,8 @@ struct sock *cookie_v4_check(struct sock *sk, struc=
t sk_buff *skb)
> >         }
> >
> >         /* Try to redo what tcp_v4_send_synack did. */
> > -       req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt->d=
st, RTAX_WINDOW);
> > +       req->rsk_window_clamp =3D READ_ONCE(tp->window_clamp) ? :
> > +                               dst_metric(&rt->dst, RTAX_WINDOW);
> >         /* limit the window selection if the user enforce a smaller rx =
buffer */
> >         full_space =3D tcp_full_space(sk);
> >         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index e767721b3a588b5d56567ae7badf5dffcd35a76a..92ee60492314a1483cfbfa2=
f73d32fcad5632773 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1721,7 +1721,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
> >         space =3D tcp_space_from_win(sk, val);
> >         if (space > sk->sk_rcvbuf) {
> >                 WRITE_ONCE(sk->sk_rcvbuf, space);
> > -               tcp_sk(sk)->window_clamp =3D val;
> > +               WRITE_ONCE(tcp_sk(sk)->window_clamp, val);
> >         }
> >         return 0;
> >  }
> > @@ -3379,7 +3379,7 @@ int tcp_set_window_clamp(struct sock *sk, int val=
)
> >         if (!val) {
> >                 if (sk->sk_state !=3D TCP_CLOSE)
> >                         return -EINVAL;
> > -               tp->window_clamp =3D 0;
> > +               WRITE_ONCE(tp->window_clamp, 0);
> >         } else {
> >                 u32 new_rcv_ssthresh, old_window_clamp =3D tp->window_c=
lamp;
> >                 u32 new_window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> > @@ -3388,7 +3388,7 @@ int tcp_set_window_clamp(struct sock *sk, int val=
)
> >                 if (new_window_clamp =3D=3D old_window_clamp)
> >                         return 0;
> >
> > -               tp->window_clamp =3D new_window_clamp;
> > +               WRITE_ONCE(tp->window_clamp, new_window_clamp);
> >                 if (new_window_clamp < old_window_clamp) {
> >                         /* need to apply the reserved mem provisioning =
only
> >                          * when shrinking the window clamp
> > @@ -4057,7 +4057,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
> >                                       TCP_RTO_MAX / HZ);
> >                 break;
> >         case TCP_WINDOW_CLAMP:
> > -               val =3D tp->window_clamp;
> > +               val =3D READ_ONCE(tp->window_clamp);
> >                 break;
> >         case TCP_INFO: {
> >                 struct tcp_info info;
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 1b6cd384001202df5f8e8e8c73adff0db89ece63..8d44ab5671eacd4bc06647c=
7cca387a79e346618 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -563,19 +563,20 @@ static void tcp_init_buffer_space(struct sock *sk=
)
> >         maxwin =3D tcp_full_space(sk);
> >
> >         if (tp->window_clamp >=3D maxwin) {
>
> I wonder if it is necessary to locklessly protect the above line with
> READ_ONCE() because I saw the full reader protection in the
> tcp_select_initial_window()? There are some other places like this.
> Any special reason?

We hold the socket lock at this point.

READ_ONCE() is only needed if another thread can potentially change
the value under us.

