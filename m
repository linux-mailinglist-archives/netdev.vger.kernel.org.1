Return-Path: <netdev+bounces-216829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F23FB355B3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69271240D5F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA418FDDB;
	Tue, 26 Aug 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiimnQsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C39460
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193588; cv=none; b=CadBEsAEQM8zlpVAM0e4j4dTESI1+VwNhC4kdjOCgeLVM6TIMp1fy4oHundY73HhA38X+P4hJEoYy/bi7dm/F0TbnxBiOlikXScKxkEDiTVaFDH2m4Nmq1o4LUCdvzwS1eDySB5NKxk4bJmyaJFUaNv7d7QdBPMwrhkUp+sBEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193588; c=relaxed/simple;
	bh=t90MfFrKu26OKxnDhpKftUytsoBlhBGSaaj4mS0CDdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzbafBXWvIzWw+WbUNbJGjy4+Bm0pyh3z5vNLMLPFG+vBOejOYIVnvRHxuIE8/qAe0+ixbCxP01F6ltQDm/FL+VC9Dfm0AHkeDE5+x1t3K8cfFar//ip1pX55xr2gyTyjHtY/Scn8hTdImURaZ//EP9bLXBKwcffzXV6bUU9U+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EiimnQsL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c59dc9so71301961cf.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756193586; x=1756798386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deY2yrxUFegHzxxk7U7oCkHMbww3xqSyI5T2Ryg9WEk=;
        b=EiimnQsL8y+07NiEz3ZSjyhr27hDlvJQP8hCCQbUZ2d4dC9/i0VRyJwtYaVQ/1ktVq
         4LlA3YUgpTbUUlqD9vUEnLn+Hbg+ZnwTTx2ynpQael/UaYUyfLN+xfHRKyVyOY1Jndz8
         IB7gwN1gRhls997WSLx/SWuwgJUpyEZpyTQmWGYPjX86zQXqISsTkArG9wleDfqXiqYx
         lWeIsGhW3guGjpOg2HZxiZjHY4qWqcw+vIW09oqmhB+l+cuAsmPMubrtqpof3f2Zs4lu
         qvNYgRIFD/0OUw4NamBm8cwQXPGU9Z5zBNh0evrOc0k0yZNZ/yNfHYmhX2XqtZfCi9Bq
         HEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193586; x=1756798386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deY2yrxUFegHzxxk7U7oCkHMbww3xqSyI5T2Ryg9WEk=;
        b=X3IJQ6wuFARyTOPXuyvoWSrjPdZSzeOYU3ckJhlgNjvHWYJhVh2cgMzh65zNpvt5bc
         jDmDi8N1bci5CUiLnaeBEnnlqrz+0ma2gdL1XOyaby+u42Lf3AqvF5UXvynoA3625at8
         ecHaqGGN0c0Ly9P4dcsC5U+XDfwJ0h3gBwxkS8xjvQKAKVxCiJa9ZKKXEhjNt7CagSEW
         D6O8KH9DJkUDsSuBezo03S0IMMn4QgHbPLyaEprSJdBLvbuZ3cKxpCcO+83VMS/doBa0
         w+G0L++/A1yY0uWyP60wAtXfbVWVJcXEAcgbkER+a/xh8qKGXm+4bxPOUFJGAQuFZr0q
         8hTA==
X-Forwarded-Encrypted: i=1; AJvYcCW2EMHPShE6BQoQC0biIuAPLYt81UbKTWgy/T7XDDz2ylfFq8Iw6FWUgLM5G/Zx7JitLLRQ96k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFQI0v/u286YEMTkELE0/YhmUnMLTfvy+XNvv2S9Bsm3nwlpX
	GM5Z4GNr5pKa4ijW+00CP2LjbkFkjQ4lZpgSXYFCq5It7s3onR2i9fIV/hWPcy6xSkoIenj1MFs
	tSa1zs+o8JIskzamnxZn8jdGLXYHZhKIbBYbhcxlq
X-Gm-Gg: ASbGncv/10Bs2/VTOTRtHx5+nyPHWovwlaXgQocX/5/MXSEjGj3f5SsZVJwqMiW8jPJ
	MqUXV7/s8RTgzclm9R3Kt0c/xPKdVt/6FT/k4EAWdSGLqW6KSDUsD0Tsb54SDEstfQD9wkY6kQT
	ybfHbP4KoHO4EZMNPuYIYfc1UrYaYVpvS6A/3Re6j7eOeXa6pVNbwbYwL9pUqkbZmLWA1ZrAQeO
	ZlvurnF2VIcf0LrjrbpN4WV2yz2td0BuMFT
X-Google-Smtp-Source: AGHT+IHlIh4Xl7Oz79WbCpz7KNmgFS72lNM4EOKBNeHe7sO8z3/LYDLd6NZAEq2o/vVJPd1tFfh2fBVBmToUtljK/28=
X-Received: by 2002:a05:622a:1c11:b0:4ae:751e:e4ef with SMTP id
 d75a77b69052e-4b2aaa2dfb0mr176590281cf.30.1756193585303; Tue, 26 Aug 2025
 00:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826023346.26046-1-dqfext@gmail.com>
In-Reply-To: <20250826023346.26046-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 00:32:53 -0700
X-Gm-Features: Ac12FXzBtCRsUpuJEN9ybDqrxqSHBaucm7Kmce9MibixcCK5G4g74MBAQnkY8u8
Message-ID: <CANn89iLZUkQrsfqvEZGmz9ZVoVk1CNQzaZyCcJ53o9e2-1GTPQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] pppoe: remove rwlock usage
To: Qingfang Deng <dqfext@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:34=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Like ppp_generic.c, convert the PPPoE socket hash table to use RCU for
> lookups and a spinlock for updates. This removes rwlock usage and allows
> lockless readers on the fast path.
>
> - Mark hash table and list pointers as __rcu.
> - Use spin_lock() to protect writers.
> - Readers use rcu_dereference() under rcu_read_lock(). All known callers
>   of get_item() already hold the RCU read lock, so no additional locking
>   is needed.
> - Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
>   period.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
>  drivers/net/ppp/pppoe.c  | 83 ++++++++++++++++++++++------------------
>  include/linux/if_pppox.h |  2 +-
>  2 files changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 410effa42ade..f99533c80b66 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -100,8 +100,8 @@ struct pppoe_net {
>          * as well, moreover in case of SMP less locking
>          * controversy here
>          */
> -       struct pppox_sock *hash_table[PPPOE_HASH_SIZE];
> -       rwlock_t hash_lock;
> +       struct pppox_sock __rcu *hash_table[PPPOE_HASH_SIZE];
> +       spinlock_t hash_lock;
>  };
>
>  /*
> @@ -162,13 +162,13 @@ static struct pppox_sock *__get_item(struct pppoe_n=
et *pn, __be16 sid,
>         int hash =3D hash_item(sid, addr);
>         struct pppox_sock *ret;
>
> -       ret =3D pn->hash_table[hash];
> +       ret =3D rcu_dereference(pn->hash_table[hash]);
>         while (ret) {
>                 if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
>                     ret->pppoe_ifindex =3D=3D ifindex)
>                         return ret;
>
> -               ret =3D ret->next;
> +               ret =3D rcu_dereference(ret->next);
>         }
>
>         return NULL;
> @@ -177,19 +177,20 @@ static struct pppox_sock *__get_item(struct pppoe_n=
et *pn, __be16 sid,
>  static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
>  {
>         int hash =3D hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
> -       struct pppox_sock *ret;
> +       struct pppox_sock *ret, *first;
>
> -       ret =3D pn->hash_table[hash];
> +       first =3D rcu_dereference_protected(pn->hash_table[hash], lockdep=
_is_held(&pn->hash_lock));
> +       ret =3D first;
>         while (ret) {
>                 if (cmp_2_addr(&ret->pppoe_pa, &po->pppoe_pa) &&
>                     ret->pppoe_ifindex =3D=3D po->pppoe_ifindex)
>                         return -EALREADY;
>
> -               ret =3D ret->next;
> +               ret =3D rcu_dereference_protected(ret->next, lockdep_is_h=
eld(&pn->hash_lock));
>         }
>
> -       po->next =3D pn->hash_table[hash];
> -       pn->hash_table[hash] =3D po;
> +       RCU_INIT_POINTER(po->next, first);
> +       rcu_assign_pointer(pn->hash_table[hash], po);
>
>         return 0;
>  }
> @@ -198,20 +199,24 @@ static void __delete_item(struct pppoe_net *pn, __b=
e16 sid,
>                                         char *addr, int ifindex)
>  {
>         int hash =3D hash_item(sid, addr);
> -       struct pppox_sock *ret, **src;
> +       struct pppox_sock *ret, __rcu **src;
>
> -       ret =3D pn->hash_table[hash];
> +       ret =3D rcu_dereference_protected(pn->hash_table[hash], lockdep_i=
s_held(&pn->hash_lock));
>         src =3D &pn->hash_table[hash];
>
>         while (ret) {
>                 if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
>                     ret->pppoe_ifindex =3D=3D ifindex) {
> -                       *src =3D ret->next;
> +                       struct pppox_sock *next;
> +
> +                       next =3D rcu_dereference_protected(ret->next,
> +                                                        lockdep_is_held(=
&pn->hash_lock));
> +                       rcu_assign_pointer(*src, next);
>                         break;
>                 }
>
>                 src =3D &ret->next;
> -               ret =3D ret->next;
> +               ret =3D rcu_dereference_protected(ret->next, lockdep_is_h=
eld(&pn->hash_lock));
>         }
>  }
>
> @@ -225,11 +230,9 @@ static inline struct pppox_sock *get_item(struct ppp=
oe_net *pn, __be16 sid,
>  {
>         struct pppox_sock *po;
>
> -       read_lock_bh(&pn->hash_lock);
>         po =3D __get_item(pn, sid, addr, ifindex);
>         if (po)
>                 sock_hold(sk_pppox(po));

Are you sure that RCU rules make sure sk_refcnt can not be zero ?

sock_hold()  will crash otherwise.

if (po && !refcount_inc_not_zero(&sk_pppox(po)->sk_refcnt))
    po =3D NULL;

I will send fixes to drivers/net/pptp.c, net/l2tp/l2tp_ppp.c,
net/phonet/socket.c, net/qrtr/af_qrtr.c, net/tipc/socket.c

