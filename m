Return-Path: <netdev+bounces-85278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C192E89A065
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395601F2218B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446516F292;
	Fri,  5 Apr 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvmPGxAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D543170
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329092; cv=none; b=fv80kZYfcx/1kK0Ik6UtBtG5AduzigDcmjH95lwckj8/UIIz0XN5q9v4+bdrLfJ+m+63Fk2eIJ3gNUGrhrt+X0el+oK3Y0YTjcEgS7EzAWxc2r9l4rPr/yc0NQi5cmO1oP2mlwqQW9RZ6sjSDyg0bgyt6q+lIflVcps38uTPzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329092; c=relaxed/simple;
	bh=eDsQ1wh8BYNTbYQDcinY/zm3toYh2+lZSF5p8XkoU/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbitG6KcOaeFiT9oouhdf3EnGIKPzYfJh0gw3adc5N2PsIgwhgw0B/O2SKxMV9SShtjSCi7q9jcZE8Xp8HhjYIMROhpvD8+rj9ndVELl/B7NegOOyjQ9kFxBib3AydDrZNTppnb2lITi74/Em+LQBiJgA6XAnl3tm5Y40EChqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvmPGxAu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51a742c273so81210066b.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329088; x=1712933888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDn/efkx7qh+vqZ3B7AAn2D3ir1XXB/bwDS3yVZPGtU=;
        b=lvmPGxAuiUeSzT3+8ilBYTO2PjfAkoHTJ17vbdBGkI0oZy+J1wWrhbSiOoAJT7hDtI
         O7C6+2z4kcSBnd9kNPHKFfOuZ4adbRcRw6OmGOXYXqLYGsCYgST6i5OPJL6cTzvW/z9S
         wXyOzhF0STs55Kb7AT+XUpwaEHJP+w/AskvER36TJgK7eFBaCpnBnnGdGss/HXDqn1q6
         mJlXxicfP+Wz+q6GX/u4J2eb0rVa8d9oWHXskIlmrvoa4TFOMG4cPjtVcL6lzZQ4j6lX
         /5aVjx9bWfL1RlflPR5DbvfyDmrZ9ym9gYECNcpX7cq9oqNPWIJ3xE02Sj/VaiqqPik+
         MBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329088; x=1712933888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDn/efkx7qh+vqZ3B7AAn2D3ir1XXB/bwDS3yVZPGtU=;
        b=gXauXRLpdzX2rHOJnS3Nk2MMus5jbpNWTxOunzHSMa+seSDDY7RlpdN3b1Eo+f0B1n
         8JUY3M2gOXF3913XmxTiNUtYkpgUYi5IKL8r3aImV0oW98Q2tIWFP3FFI0vblnKz3Ey5
         24IdMBsxBm9I0RnRRESVQzmBu41fTOovsaLAvpb9fAR2AXQkN0thBDZ1NuRJfAKQAXUs
         vtDL0lEhqjJTYOd1CXtXc9xYWs4pp8wqSBtropeAUqil1VYMukuqrQybjgY36aDOJ68L
         UMMn+v5cz9AOqftVMvzIZ2umjs09kfTXB+om2hOY1rEvC4ISLMmMyBtlxAdfhfOzqWbg
         TU+w==
X-Forwarded-Encrypted: i=1; AJvYcCVQSiOhdTWI3wfxH9wa6OTRH2jUGMxzneO6pN0hyeY2YYlD+w4wofSAs24UmnN4l8oRudqjz3xKTNNE+Mt+C3hlMDBAuMCS
X-Gm-Message-State: AOJu0YyWspiOyFIKLiiYpeKqPj3O8Uh3ajEKdYzuerrpjvadZk6i9bvM
	FBj68M0btRde1NH/SFXLiMAYiIlPebgr5BZg7e7Rsk53O1YdG5WgX4DZZu4uyppluDes63BJvU7
	rGpIPl7rt3rj7MWi7veDqrpFnwIw=
X-Google-Smtp-Source: AGHT+IFmFziJFdutkS/z6E9xOQ5e1IP1VOjja3MIAfPoYAq2Vc23SuVugmEs1Qme8B1btwCwcOUbVCj3EWB4yf8MDzI=
X-Received: by 2002:a17:907:2d91:b0:a51:b008:dc66 with SMTP id
 gt17-20020a1709072d9100b00a51b008dc66mr423936ejc.0.1712329087804; Fri, 05 Apr
 2024 07:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404114231.2195171-1-edumazet@google.com> <CAL+tcoBhdqVs0ZMzifriVf+3gpLeA72HByB5TW4vJyUn+KntMA@mail.gmail.com>
 <CANn89iK9pDX=dA78Bk-sm8p4xxSno6XgHT=s0epSes=WLwxOZA@mail.gmail.com>
In-Reply-To: <CANn89iK9pDX=dA78Bk-sm8p4xxSno6XgHT=s0epSes=WLwxOZA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 22:57:31 +0800
Message-ID: <CAL+tcoBEPLUN1Zj0YNR8VUWXrEwG0ba2a6GahW9wspBBwGMR3g@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: annotate data-races around tp->window_clamp
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Apr 5, 2024 at 4:29=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Thu, Apr 4, 2024 at 7:53=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > tp->window_clamp can be read locklessly, add READ_ONCE()
> > > and WRITE_ONCE() annotations.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/ipv4/syncookies.c |  3 ++-
> > >  net/ipv4/tcp.c        |  8 ++++----
> > >  net/ipv4/tcp_input.c  | 17 ++++++++++-------
> > >  net/ipv4/tcp_output.c | 18 ++++++++++--------
> > >  net/ipv6/syncookies.c |  2 +-
> > >  net/mptcp/protocol.c  |  2 +-
> > >  net/mptcp/sockopt.c   |  2 +-
> > >  7 files changed, 29 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > index 500f665f98cbce4a3d681f8e39ecd368fe4013b1..b61d36810fe3fd62b1e5c=
5885bbaf20185f1abf0 100644
> > > --- a/net/ipv4/syncookies.c
> > > +++ b/net/ipv4/syncookies.c
> > > @@ -462,7 +462,8 @@ struct sock *cookie_v4_check(struct sock *sk, str=
uct sk_buff *skb)
> > >         }
> > >
> > >         /* Try to redo what tcp_v4_send_synack did. */
> > > -       req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt-=
>dst, RTAX_WINDOW);
> > > +       req->rsk_window_clamp =3D READ_ONCE(tp->window_clamp) ? :
> > > +                               dst_metric(&rt->dst, RTAX_WINDOW);
> > >         /* limit the window selection if the user enforce a smaller r=
x buffer */
> > >         full_space =3D tcp_full_space(sk);
> > >         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index e767721b3a588b5d56567ae7badf5dffcd35a76a..92ee60492314a1483cfbf=
a2f73d32fcad5632773 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1721,7 +1721,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
> > >         space =3D tcp_space_from_win(sk, val);
> > >         if (space > sk->sk_rcvbuf) {
> > >                 WRITE_ONCE(sk->sk_rcvbuf, space);
> > > -               tcp_sk(sk)->window_clamp =3D val;
> > > +               WRITE_ONCE(tcp_sk(sk)->window_clamp, val);
> > >         }
> > >         return 0;
> > >  }
> > > @@ -3379,7 +3379,7 @@ int tcp_set_window_clamp(struct sock *sk, int v=
al)
> > >         if (!val) {
> > >                 if (sk->sk_state !=3D TCP_CLOSE)
> > >                         return -EINVAL;
> > > -               tp->window_clamp =3D 0;
> > > +               WRITE_ONCE(tp->window_clamp, 0);
> > >         } else {
> > >                 u32 new_rcv_ssthresh, old_window_clamp =3D tp->window=
_clamp;
> > >                 u32 new_window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> > > @@ -3388,7 +3388,7 @@ int tcp_set_window_clamp(struct sock *sk, int v=
al)
> > >                 if (new_window_clamp =3D=3D old_window_clamp)
> > >                         return 0;
> > >
> > > -               tp->window_clamp =3D new_window_clamp;
> > > +               WRITE_ONCE(tp->window_clamp, new_window_clamp);
> > >                 if (new_window_clamp < old_window_clamp) {
> > >                         /* need to apply the reserved mem provisionin=
g only
> > >                          * when shrinking the window clamp
> > > @@ -4057,7 +4057,7 @@ int do_tcp_getsockopt(struct sock *sk, int leve=
l,
> > >                                       TCP_RTO_MAX / HZ);
> > >                 break;
> > >         case TCP_WINDOW_CLAMP:
> > > -               val =3D tp->window_clamp;
> > > +               val =3D READ_ONCE(tp->window_clamp);
> > >                 break;
> > >         case TCP_INFO: {
> > >                 struct tcp_info info;
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 1b6cd384001202df5f8e8e8c73adff0db89ece63..8d44ab5671eacd4bc0664=
7c7cca387a79e346618 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -563,19 +563,20 @@ static void tcp_init_buffer_space(struct sock *=
sk)
> > >         maxwin =3D tcp_full_space(sk);
> > >
> > >         if (tp->window_clamp >=3D maxwin) {
> >
> > I wonder if it is necessary to locklessly protect the above line with
> > READ_ONCE() because I saw the full reader protection in the
> > tcp_select_initial_window()? There are some other places like this.
> > Any special reason?
>
> We hold the socket lock at this point.
>
> READ_ONCE() is only needed if another thread can potentially change
> the value under us.

Oh right, thanks. The socket will be locked as soon as the skb enters
into the TCP layer.

