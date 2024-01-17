Return-Path: <netdev+bounces-63949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D7830487
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3EB2881A5
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845A1DDEC;
	Wed, 17 Jan 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyjOixz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C41DDEA
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490937; cv=none; b=dwGyHdAcOCNZoCXek3lrwut4v1f9ott1M3oT3RP5hJmpEIlxDv3JL/7FVkKUDaV7r6gK/ffn4r8u9B/y8HEDfIQ/EaYQln2yfVxco86QAKwY2p38o4nlx2G6A43ipkHNsS8lVxQoFFLmWf6RMyJgHsGW/+EFUqMj+2sArcdSOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490937; c=relaxed/simple;
	bh=9UxLq6JE3tFvB3xncH++AmjBezySZHBIlAOhRzA5sGM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=o6SAprdtgS+qAl/qiZQXSLhR5IcSXcIZcPcSlx3Kt+NkpfIHQoIZrgNKNg3kRaCNMhyax1UCte/xL5ybXeB7Arii+yPzv1AzVpB+hdRiK2uyNJzQ6qjRE49mLTD5elFy01/A3URPww651nQYA6ICAK2v5XB82ZPjEPqZmuxzUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyjOixz1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-559e809aae5so2988a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705490934; x=1706095734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUTqwmaaaMo0qiplmJ0oCra8yqBQ6MPVJFihIeTbC4I=;
        b=iyjOixz1yu8LdVY4cFVBoZ6OAOIq+7eZNJr/N5r2Rhxu04rU6mEr/XTIM/TIdqrQ65
         nR3Q5ZGe/Kd9HrCQTt70Y+d73R9Mss324J3afIq+xFu64fFRVrqsxII5XQQu4yCOMpUm
         yyXCJniH/By7cMv5Mo2xN03k9uWlEXX1xxiZW6P3+e4NXgbxvYW1ADfGVfq/r5mPg2LP
         CSHvP0K+skFreh4EyleBzFww8OnDZzsQFAElLzBjLL0VgJwqxNneue1DryZrx6alSq3C
         8h5XGZL9sz5568wRCd967v8vMrSkNPMFUTGSGB1Iecvh6Q4vER2DrT7+Z2uciZUa6aMl
         eo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705490934; x=1706095734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUTqwmaaaMo0qiplmJ0oCra8yqBQ6MPVJFihIeTbC4I=;
        b=Vd3v5XvLQ0ZPPfvJOzyB5x1iyaGlwFDV1ICtWNCh6d/q/OlN8+7t5c6u6YEVyT+wpy
         gdLsJR45JxAxdZISxiERZQSypbLlAaBIe5eNnRqsTMnx8dclY0OMmcpjfoZwoIXYjcM6
         ouAo2WlW/cR7/DfPUI/zM2/ubUfqGwLUI5dhauw7sUl++9HT137FZrZMmY4ZmHRl0OGk
         2llI2zXxiZBvm9Y/IA2vJfhXePWkiP3p+mP4enfpT3BfBosh8QwjmHbRTiCx2k6h2nH9
         gVFHIyKcuIVcsimxHs3gnVl365iIrUbGVtzGCbq5d/Hx1iKkbcS3LQSU1mRHtQbC/ArX
         HOPw==
X-Gm-Message-State: AOJu0Yz48KmKbcu3Bc6gzSufz57XdZsj+z0IgI3stgS1hmV6XK2H6Ilx
	qGH3OLa723KYj1FRykD8mjBYeDbu4AC1NUFo4itXJA898DqZbjOT5HaT424iucW53IL6pZoXsVq
	UvOP3ogZDqdV4HtOoGb5asHxcixME6gg5zABI
X-Google-Smtp-Source: AGHT+IGSBvaHRGI/UZX7877PvgdggGOX159hATjt0sbm23iEulVKNprg+bgEbiTj8Rq7jypHZjIgN7N9t3W/oGJDtB0=
X-Received: by 2002:a05:6402:2904:b0:559:c381:2084 with SMTP id
 ee4-20020a056402290400b00559c3812084mr89422edb.3.1705490933875; Wed, 17 Jan
 2024 03:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117063152.1046210-1-shaozhengchao@huawei.com>
In-Reply-To: <20240117063152.1046210-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Jan 2024 12:28:40 +0100
Message-ID: <CANn89iKhWyw9YvS_cgfuym0sK4O-FS2xXyWgU=MjZ0g=wesYjg@mail.gmail.com>
Subject: Re: [PATCH net,v3] tcp: make sure init the accept_queue's spinlocks once
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, sming56@aliyun.com, 
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 7:22=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> When I run syz's reproduction C program locally, it causes the following
> </TASK>
>
> The issue triggering process is analyzed as follows:
> Thread A                                       Thread B
> tcp_v4_rcv      //receive ack TCP packet       inet_shutdown
>   tcp_check_req                                  tcp_disconnect //disconn=
ect sock
>   ...                                              tcp_set_state(sk, TCP_=
CLOSE)
>     inet_csk_complete_hashdance                ...
>       inet_csk_reqsk_queue_add                 inet_listen  //start liste=
n
>         spin_lock(&queue->rskq_lock)             inet_csk_listen_start
>         ...                                        reqsk_queue_alloc
>         ...                                          spin_lock_init
>         spin_unlock(&queue->rskq_lock)  //warning
>
> When the socket receives the ACK packet during the three-way handshake,
> it will hold spinlock. And then the user actively shutdowns the socket
> and listens to the socket immediately, the spinlock will be initialized.
> When the socket is going to release the spinlock, a warning is generated.
> Also the same issue to fastopenq.lock.
>
> Move init spinlock to inet_create and inet_accept to make sure init the
> accept_queue's spinlocks once.
>
> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_=
queue")
> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> Reported-by: Ming Shu <sming56@aliyun.com>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v3: Move init spinlock to inet_create and inet_accept.
> v2: Add 'init_done' to make sure init the accept_queue's spinlocks once.
> ---
>  net/core/request_sock.c         |  3 ---
>  net/ipv4/af_inet.c              | 11 +++++++++++
>  net/ipv4/inet_connection_sock.c |  8 ++++++++
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/request_sock.c b/net/core/request_sock.c
> index f35c2e998406..63de5c635842 100644
> --- a/net/core/request_sock.c
> +++ b/net/core/request_sock.c
> @@ -33,9 +33,6 @@
>
>  void reqsk_queue_alloc(struct request_sock_queue *queue)
>  {
> -       spin_lock_init(&queue->rskq_lock);
> -
> -       spin_lock_init(&queue->fastopenq.lock);
>         queue->fastopenq.rskq_rst_head =3D NULL;
>         queue->fastopenq.rskq_rst_tail =3D NULL;
>         queue->fastopenq.qlen =3D 0;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 835f4f9d98d2..6589741157a4 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -244,6 +244,14 @@ int inet_listen(struct socket *sock, int backlog)
>  }
>  EXPORT_SYMBOL(inet_listen);
>
> +static void __inet_init_csk_lock(struct sock *sk)
> +{
> +       struct inet_connection_sock *icsk =3D inet_csk(sk);
> +
> +       spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
> +       spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
> +}

This probably could be an inline helper in a suitable include file.
No need for __prefix btw.

static void inline inet_init_csk_locks(struct sock *sk)
{
       struct inet_connection_sock *icsk =3D inet_csk(sk);

       spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
       spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
}


> +
>  /*
>   *     Create an inet socket.
>   */
> @@ -330,6 +338,9 @@ static int inet_create(struct net *net, struct socket=
 *sock, int protocol,
>         if (INET_PROTOSW_REUSE & answer_flags)
>                 sk->sk_reuse =3D SK_CAN_REUSE;
>
> +       if (INET_PROTOSW_ICSK & answer_flags)
> +               __inet_init_csk_lock(sk);
> +
>         inet =3D inet_sk(sk);
>         inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 8e2eb1793685..5d3277ab9954 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -655,6 +655,7 @@ struct sock *inet_csk_accept(struct sock *sk, int fla=
gs, int *err, bool kern)
>  {
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
>         struct request_sock_queue *queue =3D &icsk->icsk_accept_queue;
> +       struct request_sock_queue *newqueue;
>         struct request_sock *req;
>         struct sock *newsk;
>         int error;
> @@ -727,6 +728,13 @@ struct sock *inet_csk_accept(struct sock *sk, int fl=
ags, int *err, bool kern)
>         }
>         if (req)
>                 reqsk_put(req);
> +
> +       if (newsk) {
> +               newqueue =3D &inet_csk(newsk)->icsk_accept_queue;
> +               spin_lock_init(&newqueue->rskq_lock);
> +               spin_lock_init(&newqueue->fastopenq.lock);
> +       }

So that we could here use a common helper

if (newsk)
     inet_init_csk_locks(newsk);


Thanks, this is looking quite nice.

