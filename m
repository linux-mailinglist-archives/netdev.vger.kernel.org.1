Return-Path: <netdev+bounces-85125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A40899911
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF211F22567
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AD15FD14;
	Fri,  5 Apr 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHYz4AKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16741EEE6
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308297; cv=none; b=ABMCKbO5iKN9IC0XOt+UYqJ1hP5u5vhFc8UdHZljGmmTLlH2C9uP03hBPBuQ0ofYCf6bYrL3py2hS/jn9eEYgDfV2QqLxcCURkH/kHuZGwusntUO8gmp442RVLdP4IPyQNuoVYSRwEebupmDixrVVUhnZndPkMZY6Ww/uH0NYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308297; c=relaxed/simple;
	bh=AhIrEuT+bYJftdqneSKZzKj0fFAymum6I6t5pF+Vz0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvQnVByxtqDuGSRQ4nFcAuoJ5GnYehkmqQAbjV+GnJTwfeSa2WmK2l8JT/uL/nTgzMGthBXpTtTLXmPLf202gZ8NdcGiqD2a9wGzNfm6uzURzUNmC8HLcp07771FFUumUCvSrtUkNwx4QGRa7CaQDlqTzgOw2JfgzWCE+gr81fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHYz4AKk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2e94095cso5856a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712308294; x=1712913094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66v6ZZfpUUiPYvvzQnNTvA9YwejZdE7KV4QKTRMJ8qI=;
        b=hHYz4AKknRmuXJVOWZ/oQEtjhX/6ADMP1P/e4BeKN0dGI9+AeZiBJjybt/Y3NvI6gG
         9P5kO2KhAywd3DgBxuh5B/uHx+reMd4dWJazjJfxX5ZcpWJewhDQA7qWx7nQc+772Q9V
         vwJ7+/wKqdLJ1v7oVo1CsGcvfv2VDg9CH9GfRlBFe6VewXOUY8L3ltVxUb1KmVKloBj4
         t9cncIhRev6UFlNt4EevrttL7J16t5DBYX8zN8D/Azp8h+wIb3xfHVP/bU46wKl1YhCQ
         Kro9ihTy3RNhA49EurhKjMZLd18udjzZUMMtPwSdyLcYY5NdJm6k/9NbXyIIyFVFQQ3J
         0ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308294; x=1712913094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66v6ZZfpUUiPYvvzQnNTvA9YwejZdE7KV4QKTRMJ8qI=;
        b=pdVF3lPu50O90kz5LZ72SOCgz0JzUEEoQKRHD3TStUn3vpIrZMnzK81tO+ku5Ia1X8
         /7VObqNyqiaPR/OxGylqx67m62c6exQwHBiZp+khq3ehQc3lde8gYTkgoH4ffWw1KD+w
         lA+0VpehucXLaHpkgkzpYwAAzF8h0pgaKXb7hjNMjS5Oa2LN3hveUfpwjmi2hnhHFBHR
         +DLcUU6adxu7uBtN7EvkooJ1PwvsLFLanRDUJmDVEDs6s3w6xb+65I2wU/K+G7EozCu7
         hnnmkck/O0tPf40XwsStZfTGufuJrvtB6D6pzK1pxB0Y71aYAK+f8BwtUd3YAHo3L/hc
         Ut6w==
X-Gm-Message-State: AOJu0YwZ0/9AAg7YpWMHYeyq7kANT8MoV7aPVNis52CBQwluf0yZyUft
	WV2623Uby8kneKuPpqE/V8C62ZlUhgzaHd33K4jaIqFFjYusnanwUscIYEgeQy/nJsIw6ko7+xu
	iO+5L0WubM1b0Gvs/0P8AhbJRLLWPPKKVdcW0
X-Google-Smtp-Source: AGHT+IGTi8z9iXuoO3ep0VNoKrt+ZPsALQCvqeXEYHny3Pb6KTkJrC1YqiXLuJZsqKR7jOh4OZ+E4Ck0udUuisYxXP0=
X-Received: by 2002:aa7:d987:0:b0:56e:2b00:fcc7 with SMTP id
 u7-20020aa7d987000000b0056e2b00fcc7mr187317eds.0.1712308293853; Fri, 05 Apr
 2024 02:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1da265997eb754925e30260eb4c5b15f3bff3b43.1712273351.git.asml.silence@gmail.com>
In-Reply-To: <1da265997eb754925e30260eb4c5b15f3bff3b43.1712273351.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 11:11:20 +0200
Message-ID: <CANn89iKzwxgzX7-TAqjN5np8fksVM=qq1A0rFRdNKWjYJYWLaA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: enable SOCK_NOSPACE for UDP
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:37=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> wake_up_poll() and variants can be expensive even if they don't actually
> wake anything up as it involves disabling irqs, taking a spinlock and
> walking through the poll list, which is fraught with cache bounces.
> That might happen when someone waits for POLLOUT or even POLLIN as the
> waitqueue is shared, even though we should be able to skip these
> false positive calls when the tx queue is not full.
>
> Add support for SOCK_NOSPACE for UDP sockets. The udp_poll() change is
> straightforward and repeats after tcp_poll() and others. However, for
> sock_wfree() it's done as an optional feature flagged by
> SOCK_SUPPORT_NOSPACE, because the feature requires support from the
> corresponding poll handler but there are many users of sock_wfree()
> that might be not prepared.
>
> Note, it optimises the sock_wfree() path but not sock_def_write_space().
> That's fine because it leads to more false positive wake ups, which is
> tolerable and not performance critical.
>
> It wins +5% to throughput testing with a CPU bound tx only io_uring
> based benchmark and showed 0.5-3% in more realistic workloads.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/net/sock.h |  1 +
>  net/core/sock.c    |  5 +++++
>  net/ipv4/udp.c     | 15 ++++++++++++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2253eefe2848..027a398471c4 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -944,6 +944,7 @@ enum sock_flags {
>         SOCK_XDP, /* XDP is attached */
>         SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>         SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
> +       SOCK_NOSPACE_SUPPORTED, /* socket supports the SOCK_NOSPACE flag =
*/
>  };
>
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMES=
TAMPING_RX_SOFTWARE))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5ed411231fc7..e4f486e9296a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3393,6 +3393,11 @@ static void sock_def_write_space_wfree(struct sock=
 *sk)
>
>                 /* rely on refcount_sub from sock_wfree() */
>                 smp_mb__after_atomic();
> +
> +               if (sock_flag(sk, SOCK_NOSPACE_SUPPORTED) &&
> +                   !test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
> +                       return;
> +
>                 if (wq && waitqueue_active(&wq->wait))
>                         wake_up_interruptible_sync_poll(&wq->wait, EPOLLO=
UT |
>                                                 EPOLLWRNORM | EPOLLWRBAND=
);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 11460d751e73..309fa96e9020 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -342,6 +342,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short =
snum,
>                 hslot2->count++;
>                 spin_unlock(&hslot2->lock);
>         }
> +       sock_set_flag(sk, SOCK_NOSPACE_SUPPORTED);
>         sock_set_flag(sk, SOCK_RCU_FREE);
>         error =3D 0;
>  fail_unlock:
> @@ -2885,8 +2886,20 @@ __poll_t udp_poll(struct file *file, struct socket=
 *sock, poll_table *wait)
>         /* psock ingress_msg queue should not contain any bad checksum fr=
ames */
>         if (sk_is_readable(sk))
>                 mask |=3D EPOLLIN | EPOLLRDNORM;
> -       return mask;
>
> +       if (!sock_writeable(sk)) {

I think there is a race that you could avoid here by using

if  (!(mask & (EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND))) {

(We called datagram_poll() at the beginning of udp_poll())

> +               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +
> +               /* Order with the wspace read so either we observe it
> +                * writeable or udp_sock_wfree() would find SOCK_NOSPACE =
and
> +                * wake us up.
> +                */
> +               smp_mb__after_atomic();
> +
> +               if (sock_writeable(sk))
> +                       mask |=3D EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
> +       }
> +       return mask;
>  }
>  EXPORT_SYMBOL(udp_poll);
>
> --
> 2.44.0
>

