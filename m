Return-Path: <netdev+bounces-117862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A7494F976
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C9C282459
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE018C354;
	Mon, 12 Aug 2024 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjXNWBjW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237114A4DF;
	Mon, 12 Aug 2024 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500996; cv=none; b=GQoRxKIDRBwSoxNJruzTDOaaFsjKR+rB7Og5PcjC1NP0Naa/VxQx6xHYtbMHZUXlIL0XSXIh6wpjQ0WeXFFg1UqoixR943Nihpmi7uvgU/UNmXMOi3hLnEDR7WDewK+O8YW4i4sWy88Y5Nw5FANvOSg87fqWmwnq6kBisWNFG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500996; c=relaxed/simple;
	bh=a06a3pGNW29gyTPgk1weaqCYbA2jS7imR1LbT+41a5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7S+lUuJi+XWlm0Sv/qVTFU5bE4xfFf5B0izClwq6AcYjFVO1dBkZtbWZvBn+ggfY7nN8sLPKF8rVW3gjNqsSkGfJsmkCJvfPQdiCMzWgLXwf5Weq19Pfu3O5D7B/80wzNtr6QgwIrCO6W+KkwvgfPM9klH1QOzbJjLbszfRmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjXNWBjW; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39b3c36d3adso17443815ab.1;
        Mon, 12 Aug 2024 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723500994; x=1724105794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne6zuaLqz7R/pnnmQlQ0mOJQkt+W57j9j1ohBlOxvMY=;
        b=GjXNWBjWh0D87k3svKZrIa0euFXOINXXH9HbDgnEwzOyi83UxxUZAz2hHPEmiNkv46
         JpwxTri7NFdMWlVj+4T0ieR5NzlNGiPv5LZAmxdyr0/CTUl5Qll+IMpfDN2ijeOeRKmh
         YEnL9lR/ObaN3b4oFgKwoHeTJPCEeMlVN6GpsKaB1YGndtmHmIDEyr+0VpkwW78/3OsF
         GMLF3QX1IRSGfTlQBtxXEQz1w3+PYQ716THi8ZPZ2jtiuxcHJZQ9Lccjwp/QT0Ppw82O
         7QQVXXFLUL1tP2ms+rBAbvNE0WjBhesxKrlL9BH1JU054ZUYIz8ePKYk6lJ4mBlpnjtq
         2ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723500994; x=1724105794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne6zuaLqz7R/pnnmQlQ0mOJQkt+W57j9j1ohBlOxvMY=;
        b=LoJ7fAgXWMe4RY1VFWTBu/luM6cIOp38oax4X3UMWqIQ81x0L+387uiwzk1yKqnb+7
         0JoHpk4JZpYucshb/aXr2tjn6Fanvh3ZaV7sxNkO8sWk2FTf9IK/Lw/vsjiszBujo7VM
         tUoziZIwdpfKuNIDacj3eCZiRGGk9uPoi43eocfW+Ao31RZHDkK2pLvgzYHvRLiy1je3
         zKt/RZQOAFBb7uWHyTTgTCvB9jFWMHv+7Pw2fw415Ev5jBT/EkfGToSTtifwegKG9XNO
         F6ZgwSghpfkssxbq3WZ0BwLIOELOHsjyneQzm3w/q2XyerYSYJV38yCImgKGD0WDeHrQ
         97Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV4u9WVsLDxdNlXtY3eN0I+IfxezaCbxdwi40MCyjTLxjO+wU1MaQcP7TTAHhWNeUnbRAijUERX@vger.kernel.org, AJvYcCW8m11wqBBB3+D4M4zllDOShQSNeA+9yAdko3o5u/N3bYhEvVu9927U+E7TDJjLRgk8+ImYLobvKD+mbDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21cYh1LLb/AVEpfRs19dMnKJC8wqSgyfdHkU67QQk4BzZmQjF
	BKZfdtEZ1lBojKboTXqiPCpMjS1Eg1svjfyPJkR2RRbDHs1vpLGJs2Wo1vZ/NTf3oWfhEA0aAUC
	IFo/hva7xrJ4T1wMHKVXYH9ATfdI=
X-Google-Smtp-Source: AGHT+IECxMETaBumCX6mT8bW72XAu59ybzU+MzXjpeYLd4mKJO7nfQrI6CO3/mJ84BWr30EgDVZGl0s33j7++n7nYRQ=
X-Received: by 2002:a05:6e02:1c05:b0:374:983b:6ff2 with SMTP id
 e9e14a558f8ab-39c478d11a2mr18427565ab.20.1723500993822; Mon, 12 Aug 2024
 15:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812105315.440718-1-kuro@kuroa.me> <CAL+tcoApiWPx8JW9DeQ6VbAH7Dnqtw7PmVVvup9HMyBHHDhvcQ@mail.gmail.com>
In-Reply-To: <CAL+tcoApiWPx8JW9DeQ6VbAH7Dnqtw7PmVVvup9HMyBHHDhvcQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Aug 2024 06:15:57 +0800
Message-ID: <CAL+tcoC6MCPx-TZup6N9BgcK9Smn5xjppKAf949uKXgs8m5XJQ@mail.gmail.com>
Subject: Re: [PATCH net,v2] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:00=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Mon, Aug 12, 2024 at 6:53=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrot=
e:
> >
> > We have some problem closing zero-window fin-wait-1 tcp sockets in our
> > environment. This patch come from the investigation.
> >
> > Previously tcp_abort only sends out reset and calls tcp_done when the
> > socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
> > purging the write queue, but not close the socket and left it to the
> > timer.
> >
> > While purging the write queue, tp->packets_out and sk->sk_write_queue
> > is cleared along the way. However tcp_retransmit_timer have early
> > return based on !tp->packets_out and tcp_probe_timer have early
> > return based on !sk->sk_write_queue.
> >
> > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> > and socket not being killed by the timers, converting a zero-windowed
> > orphan into a forever orphan.
> >
> > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > reset to peer and close the socket accordingly. Preventing the
> > timer-less orphan from happening.
> >
> > According to Lorenzo's email in the v1 thread, the check was there to
> > prevent force-closing the same socket twice. That situation is handled
> > by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
> > already closed.
> >
> > The -ENOENT code comes from the associate patch Lorenzo made for
> > iproute2-ss; link attached below.
> >
> > Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978=
-3-git-send-email-lorenzo@google.com/
> > Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> > Signed-off-by: Xueming Feng <kuro@kuroa.me>
>
> You seem to have forgotten to CC Jakub and Paolo which are also
> networking maintainers.
>
> > ---
> >  net/ipv4/tcp.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index e03a342c9162..831a18dc7aa6 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
> >                 /* Don't race with userspace socket closes such as tcp_=
close. */
> >                 lock_sock(sk);
> >
> > +       /* Avoid closing the same socket twice. */
> > +       if (sk->sk_state =3D=3D TCP_CLOSE) {
> > +               if (!has_current_bpf_ctx())
> > +                       release_sock(sk);
> > +               return -ENOENT;
> > +       }
> > +
> >         if (sk->sk_state =3D=3D TCP_LISTEN) {
> >                 tcp_set_state(sk, TCP_CLOSE);
> >                 inet_csk_listen_stop(sk);
> > @@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
> >         local_bh_disable();
> >         bh_lock_sock(sk);
> >
> > -       if (!sock_flag(sk, SOCK_DEAD)) {
> > -               if (tcp_need_reset(sk->sk_state))
> > -                       tcp_send_active_reset(sk, GFP_ATOMIC,
> > -                                             SK_RST_REASON_NOT_SPECIFI=
ED);
> > -               tcp_done_with_error(sk, err);
> > -       }
> > +       if (tcp_need_reset(sk->sk_state))
> > +               tcp_send_active_reset(sk, GFP_ATOMIC,
> > +                                     SK_RST_REASON_NOT_SPECIFIED);
>
> Please use SK_RST_REASON_TCP_STATE here. I should have pointed out this e=
arlier.

Sorry, my fault. It's the net tree which doesn't have the commit
edefba66d92 yet, so you don't need to modify this.

As I said, the patch looks good to me. Let Eric make the decision
finally. Thanks!

Thanks,
Jason

