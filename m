Return-Path: <netdev+bounces-63218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84A82BD68
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA414286D7F
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75B57302;
	Fri, 12 Jan 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zngi+WIE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56056B76
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so6182a12.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705052558; x=1705657358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52RaEaqNfgNrOJ+3OKg/14GVq28cGyoJxylc/sCmQuI=;
        b=zngi+WIEyASKwziT37Q0VHQy7M6pACVIBDVAncQWRogiOj3/r8cuEbxC5XK91Fk7hK
         zoOP/N4km6TP7zvTIzCAzfdYUHU2SFZw+bRqqiCsCeIaxaY2RyufGhoj2pkpoqaaJyS5
         zEtByz/XeCtlyoElubiMqW8OPQt+y/OaPH1xcw0gcWM9mIOJLvgqzXqTJEXl0v4Nxn6I
         ynHi0D+UMcx3MfOgMLpXtD0jl5S3dL/iv7Z5C1rNnzQOH9ZXlqrgUxKQTEbokRXHesj9
         mdjcJxwLvM249CiBGSto3cfk0Bni2OPjeeKps1VFdINePuqw/4b7WKbI+0yiGpzFS4QX
         rdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052558; x=1705657358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52RaEaqNfgNrOJ+3OKg/14GVq28cGyoJxylc/sCmQuI=;
        b=r3529KOYv41Gog5gc2n/JUQr723Eo9g3QQdO8hJhooBB65O1hl7sU4VlxNAumEWh4n
         svrZd3bzhZc7qGwyOscXWo4bJY/v4FR0c5CZTkLuIuRwRlFbr3Nw4IcDfT3P7XOTDVpE
         sUZukAFazxlmwI9kmilVKjJPRxzqL/zXQRGg7I+1aKMDvQfr048sbjs2T45Dz2zaTnOd
         2x4Lt+vv227HUOJqi7Ycbi4iGnMFeG8hrlVdyVIFPWripI3ZlupxaeWqIvJTjgyfwQz5
         VOSmwWfNbDQIt3C2Qm5eOK4YV4W+V76WVAW7JPDWmxTTntTMZNDS0kZ7/tB1aVu4I09Z
         EByg==
X-Gm-Message-State: AOJu0YyBIzqQ+0OJg8iyA63vnwuyPkMLu5NAzpXoToNYJN34JOS7fvdm
	LGi80NANj8Ed1AI0AHRmJ7nexXmX9CdrUZmDSzTb9wzuv4Ms
X-Google-Smtp-Source: AGHT+IE3ez9QRjFjJwmlRILZbXN3EpfFrMz09W8TW4KSmne/8QR3T1hj4ulxlqV4gxIyu/wVe6nbG0jZoA/+ugxHJfA=
X-Received: by 2002:a05:6402:c0c:b0:557:a991:6c40 with SMTP id
 co12-20020a0564020c0c00b00557a9916c40mr250102edb.3.1705052558423; Fri, 12 Jan
 2024 01:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112013644.3079454-1-shaozhengchao@huawei.com>
In-Reply-To: <20240112013644.3079454-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jan 2024 10:42:25 +0100
Message-ID: <CANn89iKiT-XvO00cygyMcc-EqToPLuyU3wX+jthQW7YnW7o2Bg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not hold spinlock when sk state is not TCP_LISTEN
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 2:26=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> When I run syz's reproduction C program locally, it causes the following
> issue:
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
>
> The rskq_lock lock protects only the request_sock_queue structure.
> Therefore, the rskq_lock lock could be not used when the TCP state is
> not listen in inet_csk_reqsk_queue_add.
>
> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_=
queue")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/ipv4/inet_connection_sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 8e2eb1793685..b100a89c3d98 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1295,11 +1295,11 @@ struct sock *inet_csk_reqsk_queue_add(struct sock=
 *sk,
>  {
>         struct request_sock_queue *queue =3D &inet_csk(sk)->icsk_accept_q=
ueue;
>
> -       spin_lock(&queue->rskq_lock);
>         if (unlikely(sk->sk_state !=3D TCP_LISTEN)) {
>                 inet_child_forget(sk, req, child);
>                 child =3D NULL;
>         } else {
> +               spin_lock(&queue->rskq_lock);
>                 req->sk =3D child;
>                 req->dl_next =3D NULL;
>                 if (queue->rskq_accept_head =3D=3D NULL)
> @@ -1308,8 +1308,8 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *=
sk,
>                         queue->rskq_accept_tail->dl_next =3D req;
>                 queue->rskq_accept_tail =3D req;
>                 sk_acceptq_added(sk);
> +               spin_unlock(&queue->rskq_lock);
>         }
> -       spin_unlock(&queue->rskq_lock);
>         return child;
>  }
>  EXPORT_SYMBOL(inet_csk_reqsk_queue_add);
> --
> 2.34.1
>

This is not how I would fix the issue, this would be still racy,
because 'listener' sk_state can change any time.

queue->fastopenq.lock would probably have a similar issue.

Please make sure we init the spinlock(s) once.

