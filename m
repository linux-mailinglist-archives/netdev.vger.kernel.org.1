Return-Path: <netdev+bounces-98062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC68CEF3E
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125BB1C208E0
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2596D4D9EC;
	Sat, 25 May 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5jjNaZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82754481A6
	for <netdev@vger.kernel.org>; Sat, 25 May 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716646473; cv=none; b=GbgXMu82VvQHM06fbLK56phThTJkwOAYmMbu1ShTPwrSpn+bF5OD/wpQoftvnRv6eKnsziSJlkC5iwiUNSF3MVTuz+NmXk/J8BOwrJl6Wxqz/tcy0ipeUjtVp1cPGqIZb4InteH7u3O4r25ttcKwnfDifIRREXTtcO4udQw8FuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716646473; c=relaxed/simple;
	bh=tygnWgpAB9RwItXTQF1LhohGr4eX3wQ0BjW/uD9xOy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAee8sdh3K7pV4WwmrvMl8e8UIQ5J1jxR0szO5Wjnh87jGA4gfn8wFH3F5Tqj7ClUAejtJ2b/AB8mIhRzOe2A1brgAg+PXBtvh0D+AsW8IwBIzwLI8OydaeEEgmFkjqrAlk9Xl1Hn+BEhsfNBttz0GGzZBwB9crDX18Ny12sM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5jjNaZU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-627ea4e0becso40329067b3.0
        for <netdev@vger.kernel.org>; Sat, 25 May 2024 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716646469; x=1717251269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeEQ7gYo8UIeO3e0dQAJbwuy61j11X0psjvoeDyZ6fI=;
        b=K5jjNaZUxKhwQeiZFvt46W4llX2Jxb+tA9+A5VGAdHmIgTKsiLfCvBMyKBNyFCvJye
         R1HhC8kIjx/YyI7Oacz0qqMA2fHf6Ydbj/lH4ua8/EjLVP/dIaayudpjROdLJPQD+Ujx
         fzkAAQdu4Z0EfKEcojzmSTTrPFXlTcGCZw6pY92hG2zaUc2Tx2pcbKclbkchgicBFft5
         Vv7bdrwRxPyyhhn6M6LOaLGRnK1v2EvdS6rlPoFXZwOZrb3uVav+kwWMU+aI4ySz3D1b
         W6G9G42geKZWwZEUVr7Bgrfx65nI5xR4vpAUFQITSjoZsfwjnqMNMHbSUI1HDmLx48tH
         kDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716646469; x=1717251269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeEQ7gYo8UIeO3e0dQAJbwuy61j11X0psjvoeDyZ6fI=;
        b=jrwz0zbOkRmTf55w73n/RyrFvzgSj1tRhS/3ZHdTO384/Bd/Vxvi2/xVoSdZkqvash
         OQQmLocittEN4tiwOtnlMjwvbFE8C4yvheKWQK8PjZVyBeME++BhP4f9sf98aNCOnMxE
         hljaWlNWE4ye+Iqr2ddlkwRyNytvnwC9YMuDVgxwWdh/c1SDudXPCFoRUByhM9GSVtHj
         SHDeIHQoa2VmfVUjkyXoqbOpyDq5y8esFcnf3+E2jSLEw8y7tqNgxD2ChY9gN0NSQ0RV
         nl0mQY3f8ZCYBoraeAF2kptvmU6h2SCHhmVJEfgd+yo+3msAsQMpbWwJRKu0C/flJb40
         SY0g==
X-Forwarded-Encrypted: i=1; AJvYcCVMsfbyFLJ7LW6dUkXqhLtycZm6r0XSv8r/V3GNMvVgvoz1MTXlbktyo9J71Njc0gK7hcfORNlQVaWwdhzmBe6uxhE8AaSf
X-Gm-Message-State: AOJu0YyySx11W1A8YoeDYILEUfpBpXcbOc5S1BkrWelBYyi9jKqEeSZQ
	enSQk4YvyeA31z7XV5bhvGMN3XyvURih7Pu+dHbEVafQXd6q9ZM7l4fMqyoMIhlqKuo5tDV2btj
	e12dOwzGegHuRQifqScaKdcLNOQzZXjaI93na
X-Google-Smtp-Source: AGHT+IEXbzpGQRKkc9dODGQoxtEFRr1uTVrFesUOBgOBGBePOns3zqGuFadznqg1R3ZB59pn4V2pw/9vElGGRXYOOLA=
X-Received: by 2002:a81:b666:0:b0:61a:dfd6:fd6d with SMTP id
 00721157ae682-62a08da9ae4mr47261007b3.25.1716646469271; Sat, 25 May 2024
 07:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-2-edumazet@google.com>
In-Reply-To: <20240524193630.2007563-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 25 May 2024 10:14:09 -0400
Message-ID: <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_reset() ends with a sequence that is carefuly ordered.
>
> We need to fix [e]poll bugs in the following patches,
> it makes sense to use a common helper.
>
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tcp.h    |  1 +
>  net/ipv4/tcp.c       |  2 +-
>  net/ipv4/tcp_input.c | 25 +++++++++++++++++--------
>  3 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 060e95b331a286ad7c355be11dc03250d2944920..2e7150f6755a5f5bf7b45454d=
a0b33c5fac78183 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -677,6 +677,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
>  /* tcp_input.c */
>  void tcp_rearm_rto(struct sock *sk);
>  void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
> +void tcp_done_with_error(struct sock *sk);
>  void tcp_reset(struct sock *sk, struct sk_buff *skb);
>  void tcp_fin(struct sock *sk);
>  void tcp_check_space(struct sock *sk);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 681b54e1f3a64387787738ab6495531b8abe1771..2a8f8d8676ff1d30ea9f8cd47=
ccf9236940eb299 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -598,7 +598,7 @@ __poll_t tcp_poll(struct file *file, struct socket *s=
ock, poll_table *wait)
>                  */
>                 mask |=3D EPOLLOUT | EPOLLWRNORM;
>         }
> -       /* This barrier is coupled with smp_wmb() in tcp_reset() */
> +       /* This barrier is coupled with smp_wmb() in tcp_done_with_error(=
) */
>         smp_rmb();
>         if (READ_ONCE(sk->sk_err) ||
>             !skb_queue_empty_lockless(&sk->sk_error_queue))
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 9c04a9c8be9dfaa0ec2437b3748284e57588b216..5af716f1bc74e095d22f64d60=
5624decfe27cefe 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4436,6 +4436,22 @@ static enum skb_drop_reason tcp_sequence(const str=
uct tcp_sock *tp,
>         return SKB_NOT_DROPPED_YET;
>  }
>
> +
> +void tcp_done_with_error(struct sock *sk)
> +{
> +       /* Our caller wrote a value into sk->sk_err.
> +        * This barrier is coupled with smp_rmb() in tcp_poll()
> +        */
> +       smp_wmb();
> +
> +       tcp_write_queue_purge(sk);
> +       tcp_done(sk);
> +
> +       if (!sock_flag(sk, SOCK_DEAD))
> +               sk_error_report(sk);
> +}
> +EXPORT_SYMBOL(tcp_done_with_error);
> +
>  /* When we get a reset we do this. */
>  void tcp_reset(struct sock *sk, struct sk_buff *skb)
>  {
> @@ -4460,14 +4476,7 @@ void tcp_reset(struct sock *sk, struct sk_buff *sk=
b)
>         default:
>                 WRITE_ONCE(sk->sk_err, ECONNRESET);
>         }
> -       /* This barrier is coupled with smp_rmb() in tcp_poll() */
> -       smp_wmb();
> -
> -       tcp_write_queue_purge(sk);
> -       tcp_done(sk);
> -
> -       if (!sock_flag(sk, SOCK_DEAD))
> -               sk_error_report(sk);
> +       tcp_done_with_error(sk);
>  }
>
>  /*
> --

Thanks, Eric!

Thinking about this more, I wonder if there is another aspect to this issue=
.

I am thinking about this part of tcp_done():

void tcp_done(struct sock *sk)
{
...
        sk->sk_shutdown =3D SHUTDOWN_MASK;

        if (!sock_flag(sk, SOCK_DEAD))
                sk->sk_state_change(sk);

The tcp_poll() code reads sk->sk_shutdown to decide whether to set
EPOLLHUP and other bits. However, sk->sk_shutdown is not set until
here in tcp_done(). And in the tcp_done() code there is no smp_wmb()
to ensure that the sk->sk_shutdown is visible to other CPUs before
tcp_done() calls sk->sk_state_change() to wake up threads sleeping on
sk->sk_wq.

So AFAICT we could have cases where this sk->sk_state_change() (or the
later sk_error_report()?) wakes a thread doing a tcp_poll() on another
CPU, and the tcp_poll() code may correctly see the sk->sk_err because
it was updated before the smp_wmb() in tcp_done_with_error(), but may
fail to see the "sk->sk_shutdown =3D SHUTDOWN_MASK" write because that
happened after the smp_wmb() in tcp_done_with_error().

So AFAICT  maybe we need two changes?

(1) AFAICT the call to smp_wmb() should actually instead be inside
tcp_done(), after we set sk->sk_shutdown?

void tcp_done(struct sock *sk)
{
        ...
        sk->sk_shutdown =3D SHUTDOWN_MASK;

        /* Ensure previous writes to sk->sk_err, sk->sk_state,
         * sk->sk_shutdown are visible to others.
         * This barrier is coupled with smp_rmb() in tcp_poll()
         */
        smp_wmb();

        if (!sock_flag(sk, SOCK_DEAD))
                sk->sk_state_change(sk);

(2) Correspondingly, AFAICT the tcp_poll() call to smp_rmb() should be
before tcp_poll() first reads sk->sk_shutdown, rather than right
before it reads sk->sk_err?

thanks,
neal

