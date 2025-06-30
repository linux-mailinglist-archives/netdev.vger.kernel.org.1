Return-Path: <netdev+bounces-202642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9069FAEE70B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE02189B313
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9661E299957;
	Mon, 30 Jun 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoK9Sg1d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACC1D54F7
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309889; cv=none; b=tyEB8BxjIoAOuqyTvilhQczqlAWzzge5Cjjf0Ta1CFWN0Qq5s0MR1FtTYrfyx9Uf13dZls33wD04mFft1r3qbR5Hjy8+yyICVomC09c73esceyemAJC7Ij5Dm2byGOYy0XnawKUuqygMK4QVwroMKHboCulBS+TYq/2KhhwzrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309889; c=relaxed/simple;
	bh=TZiHnx5DHZRPZ8KegtBxOajJhgILmh3ZAFEMmgWmHsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqwXc3ltgAgtJDeFHKtiq9Gn7yP1M6mp74Iq0cNR8Wdfag7GpN5v0zZu+2ZdmEKvCLlmmc1Iaw7vHvpkvW+SXiFnf0TWiYUaLWJu+m+q5V4n1RYXlnnmkIX8SW/JBVrDx//qGDhOc5JmNxGsL0IWVW/B33jTD+GzMmXjhpHLxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoK9Sg1d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167afeso21612875ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751309885; x=1751914685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faYx6HWB5dve4xDPBWFV8si/a4Y1nrpnWe89ZEp52tc=;
        b=QoK9Sg1dlXX207Dw7W5qx60TudfnIjAOH9rjvt6sKfDao45DOL5k47nBQ4lg4BM5vX
         TmMxHec1+cG1Vkxn/xfghUjUi3e4EQhEmVynjoYZ0kNulBVHoRHsw8x2H6WU9XfRS5PB
         XoauiFCzDRkMCNmKD9HTdllnIM+dXWnkWe8YqdrZlYXae4miP4wZoNjQK+0yVlEpEz6y
         /C+ZhjFY+rBXnTE13PixK6nyRyrbmKW5dfDBi99NrhkZ0iIo7GNANG5brwM+o5SWF6r3
         E5+2pvq8XjnEd0BpGCSDc8/OYlSBHpK0a4m6EUu64Gsf2wGpRopdXNVFNJFaJtnftDFk
         X61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309885; x=1751914685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faYx6HWB5dve4xDPBWFV8si/a4Y1nrpnWe89ZEp52tc=;
        b=Fs8UeEXEeVzWExH+n+sWAPM54jnDgD2ESMrqHsb1NYXxFgdvSECcgoEivSqd5lHICb
         vvRN2uvd219TgzTFn+DVvZ1I7m5vHT08rQ/1t2aMc9e95nVEq2HMx400JRTB+JulJKvS
         EyfJbR/OxYtJJauOGRpEdZIAWucVG2VH4LtcO+DwWQhZsx1RkBgYh9sx5ckBCA48ql94
         3ag1hdvwiribveE/IAFYyZS5sAoKonUCXEDl6mReOfU3ZAX80R3FoEzmNLwlnEmEYYpc
         cCmn0dchxFLeIK7k+Et/3jAxzyDI37uAK7y+K21kgYg1HNH2RkqI7Rh2UL/NxIxlAQr6
         7eEA==
X-Forwarded-Encrypted: i=1; AJvYcCXXEEtwX/xOwiaOm+0X0zhOEDE70UyFAAGkmatu1ZAsGmOhi4lwfIvoDCW06K0O1MbgIW0joco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTx/NjyWbOJVa4W+e/lBQjlaFqZCH3yOAFRB1iFgeMCpDj6JlF
	GFTARpfYk8GsPYW0fPbNgW82oJ7pnV1UCNhF1i7eMi0y3t8rH85+gIqrzD32HGlrBXVu7hCfvqM
	Zm9oEqAlfx2FryoyE3HSQIjdKw42vmtzIC7y/p0aK
X-Gm-Gg: ASbGncsBoxu9A5+6efQCKhzEooTunx1KKKQWMqUaGoOGCVrkFgfUHy9d+JOZNj0/97i
	rpBY6xAxDaSyxXVrmYV862X0su0TzfzqvYRAojV9/imlCt3OjfcuFf3IUrmSsskXuiHgLygQWB9
	vOH2y+TXQCilLiMl9keF8U/zV6+NN7OJc8SBJHH7jF+V07QgOd8Rc2gTfajENLwxl3cvRWs/F0f
	g==
X-Google-Smtp-Source: AGHT+IEAcjcyKWLX8IGw8wTUppJZH4i7riBtc0RQCt/3/8ykZlolN/mjYOEf8ClvOWFxxd7su6ESR0M7s/2qrfOsepo=
X-Received: by 2002:a17:90b:2f88:b0:311:ba32:164f with SMTP id
 98e67ed59e1d1-318c9223bc9mr22173186a91.8.1751309885135; Mon, 30 Jun 2025
 11:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com> <20250629214449.14462-2-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250629214449.14462-2-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Jun 2025 11:57:52 -0700
X-Gm-Features: Ac12FXw7A4SVhNMJuauAUOYKSoANG8Z2rhgG2M1ftidVrx3qT2zTFy6SN-2Ltqo
Message-ID: <CAAVpQUC1Z=eUcX9RqE7PLRvUPVHeuc8X7dnk1Vr_6w0_t+V84A@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next 1/6] af_unix: rework unix_maybe_add_creds()
 to allow sleep
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 2:45=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> As a preparation for the next patches we need to allow sleeping
> in unix_maybe_add_creds() and also return err. Currently, we can't do
> that as unix_maybe_add_creds() is being called under unix_state_lock().
> There is no need for this, really. So let's move call sites of
> this helper a bit and do necessary function signature changes.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  net/unix/af_unix.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 129388c309b0..6072d89ce2e7 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1955,21 +1955,26 @@ static int unix_scm_to_skb(struct scm_cookie *scm=
, struct sk_buff *skb, bool sen
>         return err;
>  }
>
> -/*
> +/* unix_maybe_add_creds() adds current task uid/gid and struct pid to sk=
b if needed.

This is not a correct kdoc format.
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-d=
ocumentation

> + *
>   * Some apps rely on write() giving SCM_CREDENTIALS
>   * We include credentials if source or destination socket
>   * asserted SOCK_PASSCRED.
> + *
> + * Context: May sleep.

This should be added later when this function starts to sleep.


>   */
> -static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock =
*sk,
> -                                const struct sock *other)
> +static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *=
sk,
> +                               const struct sock *other)
>  {
>         if (UNIXCB(skb).pid)
> -               return;
> +               return 0;
>
>         if (unix_may_passcred(sk) || unix_may_passcred(other)) {
>                 UNIXCB(skb).pid =3D get_pid(task_tgid(current));
>                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>         }
> +
> +       return 0;
>  }
>
>  static bool unix_skb_scm_eq(struct sk_buff *skb,
> @@ -2104,6 +2109,10 @@ static int unix_dgram_sendmsg(struct socket *sock,=
 struct msghdr *msg,
>                 goto out_sock_put;
>         }
>
> +       err =3D unix_maybe_add_creds(skb, sk, other);
> +       if (err)
> +               goto out_sock_put;
> +
>  restart:
>         sk_locked =3D 0;
>         unix_state_lock(other);
> @@ -2212,7 +2221,6 @@ static int unix_dgram_sendmsg(struct socket *sock, =
struct msghdr *msg,
>         if (sock_flag(other, SOCK_RCVTSTAMP))
>                 __net_timestamp(skb);
>
> -       unix_maybe_add_creds(skb, sk, other);
>         scm_stat_add(other, skb);
>         skb_queue_tail(&other->sk_receive_queue, skb);
>         unix_state_unlock(other);
> @@ -2256,6 +2264,10 @@ static int queue_oob(struct sock *sk, struct msghd=
r *msg, struct sock *other,
>         if (err < 0)
>                 goto out;
>
> +       err =3D unix_maybe_add_creds(skb, sk, other);
> +       if (err)
> +               goto out;
> +
>         skb_put(skb, 1);
>         err =3D skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, 1);
>
> @@ -2275,7 +2287,6 @@ static int queue_oob(struct sock *sk, struct msghdr=
 *msg, struct sock *other,
>                 goto out_unlock;
>         }
>
> -       unix_maybe_add_creds(skb, sk, other);
>         scm_stat_add(other, skb);
>
>         spin_lock(&other->sk_receive_queue.lock);
> @@ -2369,6 +2380,10 @@ static int unix_stream_sendmsg(struct socket *sock=
, struct msghdr *msg,
>
>                 fds_sent =3D true;
>
> +               err =3D unix_maybe_add_creds(skb, sk, other);
> +               if (err)
> +                       goto out_free;
> +
>                 if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
>                         skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>                         err =3D skb_splice_from_iter(skb, &msg->msg_iter,=
 size,
> @@ -2399,7 +2414,6 @@ static int unix_stream_sendmsg(struct socket *sock,=
 struct msghdr *msg,
>                         goto out_free;
>                 }
>
> -               unix_maybe_add_creds(skb, sk, other);
>                 scm_stat_add(other, skb);
>                 skb_queue_tail(&other->sk_receive_queue, skb);
>                 unix_state_unlock(other);
> --
> 2.43.0
>

