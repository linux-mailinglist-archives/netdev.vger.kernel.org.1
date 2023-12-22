Return-Path: <netdev+bounces-59942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB43281CC8F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C23284C68
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9702241E6;
	Fri, 22 Dec 2023 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAb6F+ud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76E241E4
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dba02a162aso1481360a34.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703261294; x=1703866094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElRCe8a8yXJNEP/4xNq1GJbF+qLn0LeEYLNfeZtVlCQ=;
        b=EAb6F+udr+4jXkywaU7mK4t7d1Dv8IgEOMFKVtNDwaNIBCqcu968kJDhZsiFKQTeqn
         GJbKtqlQylz0jxX76IpuoE/T01YZuHkGsg33dNJpwnL0FKvopTnE9apWwKGbcRZ/hnih
         uWAaUqdkJ4VbnJVLEvywS5NIODqYB4E6VRjqu0UB4io4oeK80QHVhiNHhu5MuDwTz6nc
         MC1mruvaH6Km7z/3IeQ+HnLbqyoFSxzZ8xxSSHVmgJUFjtmEx72SgiCfKIbMZ24/yGDl
         3NtqwmPlJNgHTr3veKoMn4qMr2aEAXm3JJjEDf1oA8Fy0FZBtPF12HNskKqKoZhEPmEK
         TI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703261294; x=1703866094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElRCe8a8yXJNEP/4xNq1GJbF+qLn0LeEYLNfeZtVlCQ=;
        b=oYdeF1qaMYluyRKaGEl1fb5vZKkysUQYmZ2HFm2xTPhZMtPGem8WhQ8k2A2Stfqstg
         g9Sz/5IIIDUZyd+qL9oQ5LpwQ+3pRYCKSyhi9BS/JVPlw1/jeI5mPR0qld7kBpIQUEC8
         NM6Okvw8ZhqZyOfs6tcem8da9k53bCQeHZimXNiaACxYROXpvOHZ7jrpZxyz3qI5uo9t
         BDYvCb1u3Y1e7jzB+L6qCVxXzBNiILDOgb6yDKfhzkoJjyo2K+u1rLfOifoaaEMo6KBV
         tt0jyiOnnuVWmySSCqUYZSKdmeYHpGSe20HSJ9M76Ww7Xqlzpsf1Qhm4356TCmCiUV77
         awoA==
X-Gm-Message-State: AOJu0YwLVIvwlsEbN8X9XTvoM7x4qysbJDCieptJ3JCfi5l+ITyUxwTw
	r7M/i80gcaiFmIwi4rfvYdl8TALLLGGob3Ixk/o=
X-Google-Smtp-Source: AGHT+IHeuZPoHCgzP1xTNSRTr+jcGHBKoXerisAERztrVzZ4Z+EHG+ePsNe3orio1a6OuOn4hPRJ7Od7nfHmUEvFohw=
X-Received: by 2002:a9d:6d06:0:b0:6db:a784:e63c with SMTP id
 o6-20020a9d6d06000000b006dba784e63cmr1588029otp.52.1703261294438; Fri, 22 Dec
 2023 08:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219170017.73902-1-edumazet@google.com>
In-Reply-To: <20231219170017.73902-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 22 Dec 2023 11:08:03 -0500
Message-ID: <CADvbK_e+J2nut4Q5NE3oAdUqEDXAFZrecs4zY+CrLE9ob8AtZg@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix busy polling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jacob Moroni <jmoroni@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Busy polling while holding the socket lock makes litle sense,
> because incoming packets wont reach our receive queue.
>
> Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sctp protocol=
")
> Reported-by: Jacob Moroni <jmoroni@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/socket.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c..6b9fcdb0952a0fe599ae5d1d1=
cc6fa9557a3a3bc 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2102,6 +2102,10 @@ static int sctp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>         if (unlikely(flags & MSG_ERRQUEUE))
>                 return inet_recv_error(sk, msg, len, addr_len);
>
> +       if (sk_can_busy_loop(sk) &&
> +           skb_queue_empty_lockless(&sk->sk_receive_queue))
> +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> +
Here is no any sk_state check, if the SCTP socket(TCP type) has been
already closed by peer, will sctp_recvmsg() block here?

Maybe here it needs a `!(sk->sk_shutdown & RCV_SHUTDOWN)` check,
which is set when it's closed by the peer.

Thanks

>         lock_sock(sk);
>
>         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
> @@ -9046,12 +9050,6 @@ struct sk_buff *sctp_skb_recv_datagram(struct sock=
 *sk, int flags, int *err)
>                 if (sk->sk_shutdown & RCV_SHUTDOWN)
>                         break;
>
> -               if (sk_can_busy_loop(sk)) {
> -                       sk_busy_loop(sk, flags & MSG_DONTWAIT);
> -
> -                       if (!skb_queue_empty_lockless(&sk->sk_receive_que=
ue))
> -                               continue;
> -               }
>
>                 /* User doesn't want to wait.  */
>                 error =3D -EAGAIN;
> --
> 2.43.0.472.g3155946c3a-goog
>

