Return-Path: <netdev+bounces-184595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC7A96517
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7B53BA077
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600D202C2F;
	Tue, 22 Apr 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C17oggqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614281F1524;
	Tue, 22 Apr 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315599; cv=none; b=HTljRKHcadpgs8qravi/JqNhdlNun6URUF4NhEwb0raVJO3kJWwDiguE4/VB6JLdMYrNLVjnHRLXZPvnmvayqtLARMppS3XWnQTQemvoEDoH8HFS9sTDjEi5aQDu/yw3MEX+g31jpwxUFKfVc1Itcc+lOJehiPvCRa540Q2PP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315599; c=relaxed/simple;
	bh=nQfvSQTk3q5Ln1Mb1BzF5AhQYYL5+U7RCTpig9HFDe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wri/u2Xlu1nqFF+AtNNs8NVfv9dz423lmw2XdLJZLqoF0zqXt/zlQZRNnZsvxWNbdIjifbmZWnXjptyjxgeOaSRUqZOZRON+yifM20CEnhs/JweU2diI5vbR9hU7skoTkAKm+xfwkHydJMdrxRrjpRWzmADFXI4J/6JTWHMmrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C17oggqg; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fce04655so46446166d6.3;
        Tue, 22 Apr 2025 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745315595; x=1745920395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yETBkW1U88nCu/gylpzqjgQQTBz7Y8uKO9OA9A9LFVE=;
        b=C17oggqgFLQ+fFdy6yfDZlFLz3j+lMmYFGFZ14TdOEB5nWHjbdK5AWHTBmENeIdBYN
         LU1I1pRKKQRfkhiuGHmBMzMa5+/8MW8fltu/Gig00rKE9pKDXCs5j8rHKhB+ksnQ5dLv
         TNhpTyt5NOO6rKp82vnfvdx0v/mjdKT/NwGGPJ6htCdVZlqpH9HQIgdcaFTW9x0wJeZn
         UD1Xd7BO+Het3UZIe41VAb0diPw+CDs6zelfzyPgwkzXIBWaCymqmAWgc6a0HmTHhN5j
         0cb9LgeYvpv2hZeyVtR4gWDnG6/gAESXK+/6vLaayZrCXXv6axxSVTxYexbl+2Y9lddI
         3pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315595; x=1745920395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yETBkW1U88nCu/gylpzqjgQQTBz7Y8uKO9OA9A9LFVE=;
        b=CaMqHSbgdzefVnnZNExwzYJ6BMVAI3mZElpXP8Ch/tgYxnuqT/Vu2VF2OWN9G/y55F
         Oa9F0dkYHDkj5ymOM10j1W7L2muP/wr31CNDGB0DEvwLTaoyL7uVtKa3U37DtYcCX2jL
         IElvFxnvAGWOaQ1fT+BJ5vU6OMy9ZwBisCuJHxkbzRGvhs/Pq7Shdi5QA4+om+0jr0yR
         FpOPTBCl7lZaGZ6wziIT2kpi9iBQLIZTKH3S+L1H2dXd6BF/NyFMSUO7niNdVrPHF258
         eKidCn9X0Y8bos/Det+Kdiu5GcUuuZgUmzvr3u0MLkkXRS7/n6SMBXyunIk4KkefRGbo
         3iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIQm/3rFEIFM23Kh2jEvvmMv6j3lfRANyp2BmfrMmp8rmP/Vk4tX+bk2CMLdZf5OEljyaUukk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3u4eHSy7d+4i59QgiRWWVT26TP2cBxN284kP8U+cSjMj2Fbnc
	KDXTFhLCjLhRFxH3ySY7c6ymfKU/dCMqfcdGPpewlyxfArD9lKGZMC8OboRKc/eumNz13B6zyIz
	mU4Y760B04O8z6eZYf5MQjY31wDvTa3mhYRs=
X-Gm-Gg: ASbGncupYb1kuneh6gj4/KFtvQzvHQCMPN7ydpRDE14zGQ63RReFzHNLFhvK98VowwM
	BxS5M5fFdRCsvohGzVLK9RB5pe82Zpx8/xi6HllgkIwvPpvPbfAGPgQ1fbP1Lqb8fFNv045zEdK
	Hqc0bJsHJQhvYw3v95jTqrNpde
X-Google-Smtp-Source: AGHT+IG9EHPlaIkF6blMPd0BV9rfzA8PqWZ82hTSrVfZVaEAW3ZDFSX1gMGce2uY0p5zhrx5tpnS3xIvOwd//eopcMQ=
X-Received: by 2002:ad4:5b83:0:b0:6e6:5f28:9874 with SMTP id
 6a1803df08f44-6f2c45020bbmr259686826d6.2.1745315595118; Tue, 22 Apr 2025
 02:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250416101926eucas1p193c52e72b20321605905f1c465c8ac06@eucas1p1.samsung.com>
 <20250416101908.10919-1-e.kubanski@partner.samsung.com>
In-Reply-To: <20250416101908.10919-1-e.kubanski@partner.samsung.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 22 Apr 2025 11:53:04 +0200
X-Gm-Features: ATxdqUHbkAm8vm6z4FQF1hB3H-7aTHmuQlu_qulyA9dIL7lUpgWW_6X-1Tw_jEc
Message-ID: <CAJ8uoz0Tap7JtQdoHFrXeE96XxUhJroZTPbCKhUeR3u3jzOWjA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] xsk: Fix race condition in AF_XDP generic RX path
To: "e.kubanski" <e.kubanski@partner.samsung.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 12:19, e.kubanski <e.kubanski@partner.samsung.com> wrote:
>
> Move rx_lock from xsk_socket to xsk_buff_pool.
> Fix synchronization for shared umem mode in
> generic RX path where multiple sockets share
> single xsk_buff_pool.
>
> RX queue is exclusive to xsk_socket, while FILL
> queue can be shared between multiple sockets.
> This could result in race condition where two
> CPU cores access RX path of two different sockets
> sharing the same umem.
>
> Protect both queues by acquiring spinlock in shared
> xsk_buff_pool.
>
> Lock contention may be minimized in the future by some
> per-thread FQ buffering.
>
> It's safe and necessary to move spin_lock_bh(rx_lock)
> after xsk_rcv_check():
> * xs->pool and spinlock_init is synchronized by
>   xsk_bind() -> xsk_is_bound() memory barriers.
> * xsk_rcv_check() may return true at the moment
>   of xsk_release() or xsk_unbind_dev(),
>   however this will not cause any data races or
>   race conditions. xsk_unbind_dev() removes xdp
>   socket from all maps and waits for completion
>   of all outstanding rx operations. Packets in
>   RX path will either complete safely or drop.

Thanks Eryk.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Fixes: bf0bdd1343efb ("xdp: fix race on generic receive path")
> ---
>  include/net/xdp_sock.h      | 3 ---
>  include/net/xsk_buff_pool.h | 2 ++
>  net/xdp/xsk.c               | 6 +++---
>  net/xdp/xsk_buff_pool.c     | 1 +
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index bfe625b55d55..df3f5f07bc7c 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -71,9 +71,6 @@ struct xdp_sock {
>          */
>         u32 tx_budget_spent;
>
> -       /* Protects generic receive. */
> -       spinlock_t rx_lock;
> -
>         /* Statistics */
>         u64 rx_dropped;
>         u64 rx_queue_full;
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 50779406bc2d..7f0a75d6563d 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -53,6 +53,8 @@ struct xsk_buff_pool {
>         refcount_t users;
>         struct xdp_umem *umem;
>         struct work_struct work;
> +       /* Protects generic receive in shared and non-shared umem mode. */
> +       spinlock_t rx_lock;
>         struct list_head free_list;
>         struct list_head xskb_list;
>         u32 heads_cnt;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 89d2bef96469..e2a75f3be237 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -337,13 +337,14 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>         u32 len = xdp_get_buff_len(xdp);
>         int err;
>
> -       spin_lock_bh(&xs->rx_lock);
>         err = xsk_rcv_check(xs, xdp, len);
>         if (!err) {
> +               spin_lock_bh(&xs->pool->rx_lock);
>                 err = __xsk_rcv(xs, xdp, len);
>                 xsk_flush(xs);
> +               spin_unlock_bh(&xs->pool->rx_lock);
>         }
> -       spin_unlock_bh(&xs->rx_lock);
> +
>         return err;
>  }
>
> @@ -1724,7 +1725,6 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
>         xs = xdp_sk(sk);
>         xs->state = XSK_READY;
>         mutex_init(&xs->mutex);
> -       spin_lock_init(&xs->rx_lock);
>
>         INIT_LIST_HEAD(&xs->map_list);
>         spin_lock_init(&xs->map_list_lock);
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 1f7975b49657..3a5f16f53178 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -87,6 +87,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>         pool->addrs = umem->addrs;
>         pool->tx_metadata_len = umem->tx_metadata_len;
>         pool->tx_sw_csum = umem->flags & XDP_UMEM_TX_SW_CSUM;
> +       spin_lock_init(&pool->rx_lock);
>         INIT_LIST_HEAD(&pool->free_list);
>         INIT_LIST_HEAD(&pool->xskb_list);
>         INIT_LIST_HEAD(&pool->xsk_tx_list);
> --
> 2.34.1
>
>

