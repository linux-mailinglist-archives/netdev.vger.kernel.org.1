Return-Path: <netdev+bounces-109982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E892A90B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09FBB20766
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C414659F;
	Mon,  8 Jul 2024 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqOd/7rN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C4149E13
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463939; cv=none; b=WLwNFJbVd7nTtn07RYga3rraR4131w2m8Ill2ar8DuI59CY2ZtHD24GbfE0OplO6B6nt2XtWZF46YphlZpFQnpC6zeMEx2Bj4ZiCRLUBiPNY5qEorzeRZDYhKQn+RI72X8dwo6hPJ5EK+TbpNf0iboDzkloXUNgZLXcCuzuE2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463939; c=relaxed/simple;
	bh=jw3D9j+QJo3KuNXBYmyvoFTXvrohJmZadapfIC6e92c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV7pj3XujT5ZicdoNG8LhDvGTu9GMqDRCKq+VmeMPZ2bwKail6eL65/mGEnWYo8CMIUdauMPoIxYT4Ya14J+r9IqZ/hfKjJAmdDhVDPuIFBJPHGLRWcsWt4aSQJL24Hk36lYr7DpGwIt3usYV6xD0rSO1Jay/UV9RJY0SqMY41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqOd/7rN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so2581a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720463936; x=1721068736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/7AOfM82HEClkhnrbW1vxy8gOpqEVFo124zuBjPedI=;
        b=UqOd/7rNTWWsC1DaZasRuhUnu83NogZl0TcXL+VsyFDsBuOYwJSyNpFMjGWmdjNEFp
         tKnpPw0wXsu/YmIuJCgVXL8SEjPwWrXRv8gmsY0bhsqrfPJsE9qDYq/vbWjWU7jCFtbv
         PJsYkzxjDDfolDr7QwNZvJTREPKEGaSbLXpaN0Mw9SfOG1464Lv6YS+smTvlc+cgYi5G
         uOlA2rglFp7LMI5xWDZzo/TaMnSoKiWCPhunk2xwqza+N+0n4lJ/Rdbw51FoDRyuH8wF
         DQ4RuWWPEHOAdRjIwv7vAr4NxlBFOPyzTN2VMwvNcwV7j06Lz6HgZ64zYMKsoQZ7udbB
         onlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720463936; x=1721068736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/7AOfM82HEClkhnrbW1vxy8gOpqEVFo124zuBjPedI=;
        b=CorGQzfGbPZ+DEMyddyEpxjHdLsGco6HoAWnHIwIPikjNKgNvycGxB0ivA+yJFNrNj
         252BUJR+DYQCyUFSoomJ2nfN1UmnuRSDn/b7irfafNh+oA9P1oOl02fEkLZwGxGyF4xJ
         xy5+O6OSh74dm3Punx3RdK9kWd1WTZAioNgBTYedrUfQMBVb1mbGir8ol8GB9lAESCVI
         rWAadc25+CAfa8EzMHwtHwr2o4JE0/YWWmtCWvxAZKZ+iDU3pT9BkrR+tgCjZzh6zG15
         Qz1BW5Vt/593fERF8BNb27ulgnP6Ix0ruWVuYjZLlim84pYM11hptBTCMYTFajbzWTqC
         CkrA==
X-Forwarded-Encrypted: i=1; AJvYcCUwdn3m/w+LM5kL9P8rPc4dWrn2gwckuCiodmVRX0KSjqSkKRJuzpaYZYHuWvXAStutT8jO2BZLbJvz2bbLTiA8Vz0PGiqx
X-Gm-Message-State: AOJu0Yw6lJjjh0iCMfDpLY9irq6DuJTe82PKEsgsmA3EJQ3DsCLwVGSS
	xLIP+EDnr6+qfPhyr5rFzAOa+/ME53NJ/z6vSJYh1zTwnLMf7uEEJ6LgicMVdlrNF70NtfZOWZW
	fax+jSBaCYQCo0Z6qeP1OpbCzRNefHIt69/AAiXy7PI7QD9HMyDmj+DA=
X-Google-Smtp-Source: AGHT+IHpZVtqJff3eqI/KgUwHM2gmUw93R1s6aMPUcql955ZmIve/a+MQkGdY/3IxXWmUBUqBaZ/2wrKT5jYRjmbCxU=
X-Received: by 2002:a50:bacd:0:b0:58b:dfaa:a5cd with SMTP id
 4fb4d7f45d1cf-594d1b13fe1mr25669a12.2.1720463935361; Mon, 08 Jul 2024
 11:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708182023.93979-1-kuniyu@amazon.com>
In-Reply-To: <20240708182023.93979-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jul 2024 11:38:41 -0700
Message-ID: <CANn89iJF4X+zFFFfhHdDWcYxTO0J_TZ-oN=X_8_FuQqxsCWJCQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller triggered the warning [0] in udp_v4_early_demux().
>
> In udp_v4_early_demux(), we do not touch the refcount of the looked-up
> sk and use sock_pfree() as skb->destructor, so we check SOCK_RCU_FREE
> to ensure that the sk is safe to access during the RCU grace period.
>
> Currently, SOCK_RCU_FREE is flagged for a bound socket after being put
> into the hash table.  Moreover, the SOCK_RCU_FREE check is done too
> early in udp_v4_early_demux(), so there could be a small race window:
>
>   CPU1                                 CPU2
>   ----                                 ----
>   udp_v4_early_demux()                 udp_lib_get_port()
>   |                                    |- hlist_add_head_rcu()
>   |- sk =3D __udp4_lib_demux_lookup()    |
>   |- DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
>                                        `- sock_set_flag(sk, SOCK_RCU_FREE=
)
>
> In practice, sock_pfree() is called much later, when SOCK_RCU_FREE
> is most likely propagated for other CPUs; otherwise, we will see
> another warning of sk refcount underflow, but at least I didn't.
>
> Technically, moving sock_set_flag(sk, SOCK_RCU_FREE) before
> hlist_add_{head,tail}_rcu() does not guarantee the order, and we
> must put smp_mb() between them, or smp_wmb() there and smp_rmb()
> in udp_v4_early_demux().
>
> But it's overkill in the real scenario, so I just put smp_mb() only under
> CONFIG_DEBUG_NET to silence the splat.  When we see the refcount underflo=
w
> warning, we can remove the config guard.
>
> Another option would be to remove DEBUG_NET_WARN_ON_ONCE(), but this coul=
d
> make future debugging harder without the hints in udp_v4_early_demux() an=
d
> udp_lib_get_port().
>
> [0]:
>
> Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/udp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 189c9113fe9a..1a05cc3d2b4f 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -326,6 +326,12 @@ int udp_lib_get_port(struct sock *sk, unsigned short=
 snum,
>                         goto fail_unlock;
>                 }
>
> +               sock_set_flag(sk, SOCK_RCU_FREE);

Nice catch.

> +
> +               if (IS_ENABLED(CONFIG_DEBUG_NET))
> +                       /* for DEBUG_NET_WARN_ON_ONCE() in udp_v4_early_d=
emux(). */
> +                       smp_mb();
> +

I do not think this smp_mb() is needed. If this was, many other RCU
operations would need it,

RCU rules mandate that all memory writes must be committed before the
object can be seen
by other cpus in the hash table.

This includes the setting of the SOCK_RCU_FREE flag.

For instance, hlist_add_head_rcu() does a
rcu_assign_pointer(hlist_first_rcu(h), n);


>                 sk_add_node_rcu(sk, &hslot->head);
>                 hslot->count++;
>                 sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> @@ -342,7 +348,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short =
snum,
>                 hslot2->count++;
>                 spin_unlock(&hslot2->lock);
>         }
> -       sock_set_flag(sk, SOCK_RCU_FREE);
> +
>         error =3D 0;
>  fail_unlock:
>         spin_unlock_bh(&hslot->lock);
> --
> 2.30.2
>

