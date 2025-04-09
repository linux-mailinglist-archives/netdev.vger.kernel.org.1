Return-Path: <netdev+bounces-180765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1387A8263F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4181B66BA8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2D2641FB;
	Wed,  9 Apr 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSTGE5w0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817F263889;
	Wed,  9 Apr 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204916; cv=none; b=pGgPezdtFkSX1m9HPbGNp4yfkUFt4Z/fDh2EZGJQJ/Yib2PSRq+aNNiL8gb/IWJF2n4Bsa3Cxx740a6jihwYiGIOaChbcmpsOMNrk20IAe9Z+ElfA59LV/aenBkfjZtFo47GNggij+cSP3R7PULrE0qXf3kkdt2vzHrXcs5Vv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204916; c=relaxed/simple;
	bh=SmrqXL4RqYVu9PyS6OdO8GxT2NhYunMwLJ3j18/+GeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnjYjDdS8K50R1TfX0caeHkadHSjWdFil49/XA/sFPZEH2X1njaaVuU3qYS9yTWRd2XVKX5EAp7H5ie3WqUrh3t7A+y+b0OFJlOPkjn9QC2ux3Zs0By6XccaMj5Fas9fNKUSMK/IwZWX/GCm+LQiJQPadtOcVj6rIBjcZH+cdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSTGE5w0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e900a7ce55so99132896d6.3;
        Wed, 09 Apr 2025 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744204912; x=1744809712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SCBNp4JG6p8TrqxQOWK55yW9vDXymXnDHD0MufGLyMs=;
        b=PSTGE5w0p0Q2tjnSQ5R04vSw9bgQzXptP5EbstLF0NnPfEz72aEXZ7V1EcN6UdnonC
         DGagoJCHh0ivLyplUUAbvVRwls8+9xiDgOEsaYKzJ+uI9mxfPtB7SpXyh+A4jlmRe1mV
         up7mEUm9KtnNUgwKzAGZhrHztDVTaUjJDb/GXKxo3wMFZ29yhPgGh+iTQ6oH9Ys65WqC
         xpx7OZcGED7PVqG7n+ZhaNY2EoWioFl1eYEcPYBd1qeGrUeacxyWQRQ//EE+9Ld6auFA
         Md8rWF181CO4kyfa+W2Xd03MVuC4LRacbJjAW+T6CZcbYDFcD3R2uuSD5qMlMqgPXgcf
         hpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204912; x=1744809712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCBNp4JG6p8TrqxQOWK55yW9vDXymXnDHD0MufGLyMs=;
        b=qmapOstMbsyWIXBIsDHPS5vlch94nOFOsCiTcqr20VL6U/w+mFXMxy1+G+jOENwJf9
         ntE7um25KbfF7GIm0jjBYFBMYIIlAIVPFkqPEPiT+8RN04mrD8WVmQ6ick1XwVjGdbq9
         pexBxroKIooun9rXllxzp1RcEKupsw1yFyxWWi59qZBfF/VadtKyHQ2RbTCp4AmQdOkT
         IbYnipn1OIz0bURRx2gBQwHp5S0URkOh+8GQrf4m1j1hCw9bqdVL0ZpQyBS16Oco67tQ
         8H7QkXGqQsOh7QU1gY6Qt5AWZVLTdgqtDZPccmll2GjQc/OfyrIP2CGlQe6h7F1ZGTyn
         j9WA==
X-Forwarded-Encrypted: i=1; AJvYcCVhkUQlx9IzXwxGF/6S9o6ZlTlpaZJIliurx91mXlgDRT4C9LZn01HcCbOTUhZz8ho7Nvx0xpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRyvYapFbnYEn+uOvEgm2gKVrakKIP+vkBn5tzaZxFsP62jAv
	dEJjkbbSVk3Acmvced04M0OghDDRc1IXb5MusfqUevbXsKmXSIt5sEeSG2TJLUThT2HsAexeNFY
	4glLYFjgB27IUl8Zo0WAnhAgwNms=
X-Gm-Gg: ASbGnctCiNUA7wbH6sqvDqdn+TdubMkjyuHf+Td7mJTapafwxrMYY+yeNpkT5f8PsL9
	LZGJ2FIV4bhajQYHInpTHiVKGccLRyxElR/Ltvofa7nz0DvUgoISAkZwkSvgTluMoOshs7EjsZg
	li6I5nCbpLcQMEJ2l2vvf6plNo
X-Google-Smtp-Source: AGHT+IEK6Kny/es6p6BhHc5qmMh2JHSDKmv1HyuA+ZNybmkFb6rEmjsaFGmivL505JRYubKnVnHnszm2Vbrzo6lCChE=
X-Received: by 2002:a05:6214:1315:b0:6ea:d090:6365 with SMTP id
 6a1803df08f44-6f0dd7f0da3mr33962516d6.32.1744204911762; Wed, 09 Apr 2025
 06:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250409125216eucas1p150b189cd13807197a233718302103a02@eucas1p1.samsung.com>
 <20250409124950.58819-1-e.kubanski@partner.samsung.com>
In-Reply-To: <20250409124950.58819-1-e.kubanski@partner.samsung.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 9 Apr 2025 15:21:40 +0200
X-Gm-Features: ATxdqUGbbHJXnd4jMCEYZb64rxFS1AXoPyCmugRzmhq5mK_PvHhd6OqKS-X-iLI
Message-ID: <CAJ8uoz1px+AanwpyaY4vNy7yJrwwTdqE8W6mWqgLBR1k1ngZgQ@mail.gmail.com>
Subject: Re: [PATCH] xsk: Fix race condition in AF_XDP generic RX path
To: "e.kubanski" <e.kubanski@partner.samsung.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 14:56, e.kubanski <e.kubanski@partner.samsung.com> wrote:
>
> rx_lock moved from xsk_socket to xsk_buff_pool.
> Previous synchronization didn't take care of
> shared umem mode in generic RX path where sockets
> share the same xsk_buff_pool.
>
> RX queue is exclusive to xsk_socket, while FILL
> queue can be shared between multiple sockets.
> This could result in race condition where two
> CPU cores access RX path of two different sockets
> sharing the same umem.

I do not fully understand what you are doing in user space. Could you
please provide a user-space code example that will trigger this
problem?

Please note that if you share an Rx ring or the fill ring between
processes/threads, then you have to take care about mutual exclusion
in user space. If you really want to do this, it is usually a better
idea to use the other shared umem mode in which each process gets its
own rx and fill ring, removing the need for mutual exclusion.

> Now both queues are protected by acquiring spinlock
> in shared xsk_buff_pool.
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
>
> Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
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

