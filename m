Return-Path: <netdev+bounces-169588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B9A44A84
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C423A397C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1B19CD16;
	Tue, 25 Feb 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8WTBeOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644A19992E
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508126; cv=none; b=be02tVeq7VSAku0t5iNPcKdpIlo5HphKu2iKDJ8vM3URpr4SuSZIl7PfdNxC6HIm0cQalofnOpJJMKoF10h410IGi5Ht+X/kDpVbEsDj/RnUNOHSJK/9td/yOD/pvxXXYGAepM7w8ji46TjGqMxHSubKFo3SHQ3OR/+ibxKDpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508126; c=relaxed/simple;
	bh=4aacW4u/dC0KhZ09cm52SLu1zOaauWe+ywLVv1kI1Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9+EhWmHMHwM2fg07QmQkFE/epRMycJtbDA3MY5bjPgkZCNjeOFgnTAUbKCkhcXuTSDVQphRB8lTfv+qFlO/OZdI5V0Ku6Mm7Ator58loxuyqBbWJ9SzzMItX1HFcjjCvUc4c6Ns/g/ze3DStAGmcDRFc4hD9BHFlkt/Tm0s1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8WTBeOv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43994ef3872so36817865e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740508122; x=1741112922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeS3Loc5/FmmQbD09whS5MZ2mfC/ecGn+Lg324UKJMc=;
        b=B8WTBeOvA3/1/V3T/rYcb/oILE7OO63yEzPYSESp7/bX5EMsNzgracWPpJt0sK07X8
         4eOLaP7qk9vBi5HHmHzvPhsb4zOnXzDQQmKgHii0SqsAi4cBfCY50dkCKryEVnNlQ/E4
         49POnU2gXEI6TCm7eGUfrXX7oGfb12tyR5dTjD8p0+SK+8h+IyHUVwBP0/T34rkb0KBu
         ceYR4HZ0dc/RPiKj0qzUoJmCYIqVjWS+sZhoPv3pRv0ZaMRaKEIiQz1MIdZK+24/2VjO
         nCH58AtS+9wqOweufjh4vWJssFJcWOERj8Yay4rLX6OPPNKZqxeRQRakep7O96fYqQpY
         jTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740508122; x=1741112922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeS3Loc5/FmmQbD09whS5MZ2mfC/ecGn+Lg324UKJMc=;
        b=xGI8cqCazESwrOImBlWMsHtp+HUrCkNk6dxr75AMGWUFrPoXvHcqmKWwxBcd25W1na
         Q+wI+Nv/GCVotrlFcOfAeuLatXJbaKliBhDXhILatSnMU6K+o9b7Ghdi/KNDu+faAqqu
         xv5HsWErNKsFOWHVzUfhB1Dn0k4/sKFrs/n77e+rNfV8UTIR9Y0Mm7dAZyRWlgaPAzuG
         8ynfaS6VkSiDhC2zCzlfQoNJwBq/BVsTzifFjG5GZFdMGkXtMRgU1s3hopSRzJR0mL64
         cbPltH7UvYltxqelAIAH5kIrqw5HcrAzlBSKof/QbeBQfe7UurvxyDWlXhFfgK7KCMR0
         cLsg==
X-Forwarded-Encrypted: i=1; AJvYcCU+Rck4woFD/QPqb1O94ccS7SOV7L/GVdDr+Zfr0iXjomYMeGH8YgpjW00NlsWAPQQFgOAFlbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93WPcIss4Rk/xkHqIBcZDgMvlF/tlTJYJZsyKH+QP1Ld+I/Y3
	N18HQaLB5D0t4pzCSr87oMRMBIu41dF/OuBkOQEJV5vOke57m5w8y6eiJ4Qmvge7uM9+O/UtJJJ
	m0OmNYEdtQzjPGwVQh8C5IZU44VzOOAk3XXDG
X-Gm-Gg: ASbGncvXbVHMekfAyRM93inJppwY2f0qVuINnbqS0RBVWxhFZy+NGsBrsMNDYpENHNi
	NH4xnoz+q2CGzi4kWhUh+1psHQFLY2jHgbd7GqAmTuNBAISzMTc/W23FZ3jOsknkwvM4QE7lvS2
	RTbbCbI7R7tYi/GsF23iszn5hOlRi+LG3EVcAz
X-Google-Smtp-Source: AGHT+IERMW9+P4Cd27rKWisWi//6hTLlR+vjMsZDCVQ2HJHdSlUitxBXYy36mSRhCfeYWT6gUe7z9Q8+GfN9qTVJggk=
X-Received: by 2002:a05:600c:1d0b:b0:439:8c80:6b02 with SMTP id
 5b1f17b1804b1-43ab0fa35d8mr43654645e9.31.1740508122182; Tue, 25 Feb 2025
 10:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <009e01db4620$f08f42e0$d1adc8a0$@samsung.com> <CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
 <Z4nl0h1IZ5R/KDEc@perf> <CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
 <CGME20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d@epcas2p1.samsung.com>
 <Z42WaFf9+oNkoBKJ@perf> <Z6BSXCRw/9Ne1eO1@perf> <CADVnQykpHsN1rPJobKVfFGwtAJ9qwPrwG21HiunHqfykxyPD1g@mail.gmail.com>
 <CADVnQymr=sst5foNOF7ydr-fUyAK6XLvRyNvnTVBV=wgPLpBBQ@mail.gmail.com>
In-Reply-To: <CADVnQymr=sst5foNOF7ydr-fUyAK6XLvRyNvnTVBV=wgPLpBBQ@mail.gmail.com>
From: Yuchung Cheng <ycheng@google.com>
Date: Tue, 25 Feb 2025 10:28:06 -0800
X-Gm-Features: AQ5f1JoDQgmdLmiMMR1LW_dPFt7XL6YR8XMmExuyx9kj5KboOjBn6hJyI-dKdM0
Message-ID: <CAK6E8=cB5LW8EtP5Hs6Xb8HP7Hr7TzHSHx--c7yj50RhUraUEQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Neal Cardwell <ncardwell@google.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, guo88.liu@samsung.com, 
	yiwang.cai@samsung.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com, 
	sw.ju@samsung.com, "Dujeong.lee" <dujeong.lee@samsung.com>, Kevin Yang <yyd@google.com>, 
	Xueming Feng <kuro@kuroa.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:25=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Mon, Feb 24, 2025 at 4:13=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Mon, Feb 3, 2025 at 12:17=E2=80=AFAM Youngmin Nam <youngmin.nam@sams=
ung.com> wrote:
> > >
> > > > Hi Neal,
> > > > Thank you for looking into this issue.
> > > > When we first encountered this issue, we also suspected that tcp_wr=
ite_queue_purge() was being called.
> > > > We can provide any information you would like to inspect.
> >
> > Thanks again for raising this issue, and providing all that data!
> >
> > I've come up with a reproducer for this issue, and an explanation for
> > why this has only been seen on Android so far, and a theory about a
> > related socket leak issue, and a proposed fix for the WARN and the
> > socket leak.
> >
> > Here is the scenario:
> >
> > + user process A has a socket in TCP_ESTABLISHED
> >
> > + user process A calls close(fd)
> >
> > + socket calls __tcp_close() and tcp_close_state() decides to enter
> > TCP_FIN_WAIT1 and send a FIN
> >
> > + FIN is lost and retransmitted, making the state:
> > ---
> >  tp->packets_out =3D 1
> >  tp->sacked_out =3D 0
> >  tp->lost_out =3D 1
> >  tp->retrans_out =3D 1
> > ---
> >
> > + someone invokes "ss" to --kill the socket using the functionality in
> > (1e64e298b8 "net: diag: Support destroying TCP sockets")
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dc1e64e298b8cad309091b95d8436a0255c84f54a
> >
> >  (note: this was added for Android, so would not be surprising to have
> > this inet_diag --kill run on Android)
> >
> > + the ss --kill causes a call to tcp_abort()
> >
> > + tcp_abort() calls tcp_write_queue_purge()
> >
> > + tcp_write_queue_purge() sets packets_out=3D0 but leaves lost_out=3D1,
> > retrans_out=3D1
> >
> > + tcp_sock still exists in TCP_FIN_WAIT1 but now with an inconsistent s=
tate
> >
> > + ACK arrives and causes a WARN_ON from tcp_verify_left_out():
> >
> > #define tcp_verify_left_out(tp) WARN_ON(tcp_left_out(tp) > tp->packets_=
out)
> >
> > because the state has:
> >
> >  ---
> >  tcp_left_out(tp) =3D sacked_out + lost_out =3D 1
> >   tp->packets_out =3D 0
> > ---
> >
> > because the state is:
> >
> > ---
> >  tp->packets_out =3D 0
> >  tp->sacked_out =3D 0
> >  tp->lost_out =3D 1
> >  tp->retrans_out =3D 1
> > ---
> >
> > I guess perhaps one fix would be to just have tcp_write_queue_purge()
> > zero out those other fields:
> >
> > ---
> >  tp->sacked_out =3D 0
> >  tp->lost_out =3D 0
> >  tp->retrans_out =3D 0
> > ---
> >
> > However, there is a related and worse problem. Because this killed
> > socket has tp->packets_out, the next time the RTO timer fires,
Zeroing all inflights stats in tcp_write_queue_purge still makes sense
to me. Why will the RTO timer still fire if packets_out is zeroed?


> > tcp_retransmit_timer() notices !tp->packets_out is true, so it short
> > circuits and returns without setting another RTO timer or checking to
> > see if the socket should be deleted. So the tcp_sock is now sitting in
> > memory with no timer set to delete it. So we could leak a socket this
> > way. So AFAICT to fix this socket leak problem, perhaps we want a
> > patch like the following (not tested yet), so that we delete all
> > killed sockets immediately, whether they are SOCK_DEAD (orphans for
> > which the user already called close() or not) :
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 28cf19317b6c2..a266078b8ec8c 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -5563,15 +5563,12 @@ int tcp_abort(struct sock *sk, int err)
> >         local_bh_disable();
> >         bh_lock_sock(sk);
> >
> > -       if (!sock_flag(sk, SOCK_DEAD)) {
> > -               if (tcp_need_reset(sk->sk_state))
> > -                       tcp_send_active_reset(sk, GFP_ATOMIC);
> > -               tcp_done_with_error(sk, err);
> > -       }
> > +       if (tcp_need_reset(sk->sk_state))
> > +               tcp_send_active_reset(sk, GFP_ATOMIC);
> > +       tcp_done_with_error(sk, err);
> >
> >         bh_unlock_sock(sk);
> >         local_bh_enable();
> > -       tcp_write_queue_purge(sk);
> >         release_sock(sk);
> >         return 0;
> >  }
> > ---
>
> Actually, it seems like a similar fix was already merged into Linux v6.11=
:
>
> bac76cf89816b tcp: fix forever orphan socket caused by tcp_abort
>
> Details below.
>
> Youngmin, does your kernel have this bac76cf89816b fix? If not, can
> you please cherry-pick this fix and retest?
>
> Thanks!
> neal
>
> ps: details for bac76cf89816b:
>
> commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4
> Author: Xueming Feng <kuro@kuroa.me>
> Date:   Mon Aug 26 18:23:27 2024 +0800
>
>     tcp: fix forever orphan socket caused by tcp_abort
>
>     We have some problem closing zero-window fin-wait-1 tcp sockets in ou=
r
>     environment. This patch come from the investigation.
>
>     Previously tcp_abort only sends out reset and calls tcp_done when the
>     socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
>     purging the write queue, but not close the socket and left it to the
>     timer.
>
>     While purging the write queue, tp->packets_out and sk->sk_write_queue
>     is cleared along the way. However tcp_retransmit_timer have early
>     return based on !tp->packets_out and tcp_probe_timer have early
>     return based on !sk->sk_write_queue.
>
>     This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
>     and socket not being killed by the timers, converting a zero-windowed
>     orphan into a forever orphan.
>
>     This patch removes the SOCK_DEAD check in tcp_abort, making it send
>     reset to peer and close the socket accordingly. Preventing the
>     timer-less orphan from happening.
>
>     According to Lorenzo's email in the v1 thread, the check was there to
>     prevent force-closing the same socket twice. That situation is handle=
d
>     by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
>     already closed.
>
>     The -ENOENT code comes from the associate patch Lorenzo made for
>     iproute2-ss; link attached below, which also conform to RFC 9293.
>
>     At the end of the patch, tcp_write_queue_purge(sk) is removed because=
 it
>     was already called in tcp_done_with_error().
>
>     p.s. This is the same patch with v2. Resent due to mis-labeled "chang=
es
>     requested" on patchwork.kernel.org.
>
>     Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-79=
78-3-git-send-email-lorenzo@google.com/
>     Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
>     Signed-off-by: Xueming Feng <kuro@kuroa.me>
>     Tested-by: Lorenzo Colitti <lorenzo@google.com>
>     Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>     Reviewed-by: Eric Dumazet <edumazet@google.com>
>     Link: https://patch.msgid.link/20240826102327.1461482-1-kuro@kuroa.me
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162b..831a18dc7aa6d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
>                 /* Don't race with userspace socket closes such as tcp_cl=
ose. */
>                 lock_sock(sk);
>
> +       /* Avoid closing the same socket twice. */
> +       if (sk->sk_state =3D=3D TCP_CLOSE) {
> +               if (!has_current_bpf_ctx())
> +                       release_sock(sk);
> +               return -ENOENT;
> +       }
> +
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 tcp_set_state(sk, TCP_CLOSE);
>                 inet_csk_listen_stop(sk);
> @@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
>         local_bh_disable();
>         bh_lock_sock(sk);
>
> -       if (!sock_flag(sk, SOCK_DEAD)) {
> -               if (tcp_need_reset(sk->sk_state))
> -                       tcp_send_active_reset(sk, GFP_ATOMIC,
> -                                             SK_RST_REASON_NOT_SPECIFIED=
);
> -               tcp_done_with_error(sk, err);
> -       }
> +       if (tcp_need_reset(sk->sk_state))
> +               tcp_send_active_reset(sk, GFP_ATOMIC,
> +                                     SK_RST_REASON_NOT_SPECIFIED);
> +       tcp_done_with_error(sk, err);
>
>         bh_unlock_sock(sk);
>         local_bh_enable();
> -       tcp_write_queue_purge(sk);
>         if (!has_current_bpf_ctx())
>                 release_sock(sk);
>         return 0;

