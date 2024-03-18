Return-Path: <netdev+bounces-80317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC787E549
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C512C1C20FC7
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39D28DB3;
	Mon, 18 Mar 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THL5clat"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3CF28DAE
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752070; cv=none; b=o8hJtVkMRShyfYKva6tr7SWZ9WJViD8l0Y8fa65yG4S1cC5NUDg8vfjMPVGdKhP4CBQ0OygWYxZTjE/TZVaWR7x2vOMxzmTWzHGbp4zhxe2s68/K0ta71Dnw9a7SnriN3oa+JE0J6TPjJQu+14lIiOucYj6/fjc/MwmXvrn3ABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752070; c=relaxed/simple;
	bh=p94ko8/Hp5DkOhfiGP9z8qWJHti6kyyQFDyKE9lFNzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLHFsAhz54H4IQmsKuS+9tVGraDfPZguerItK2TzqVInxlwu86r2rwnJeWq3VGIkKdchTRLyVYN8i/fzcwHYG+XjwPTAcrAtk6imL2cmixyqM7k1FRVqJG0ZvN9UYIBiiDTm6+ZAWmOeqjcnENG2X35mQ5nXfzvEjG6S7mE/0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THL5clat; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56b82f2fc60so1289a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710752067; x=1711356867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHUmVZZkH//enowhHNfhQSZre8bB7hubC6uVaHFa01o=;
        b=THL5clatxZ9mQxTy45zb+CaidChTSW6WOVOK/MKeSCvwIzMtV9rg7PqJzcFoWnY90a
         DTZNHi63u8H8g3W+1XbtaaAYUcEl1v9+Pi1Mx/PJ9z9z5bQd7syRzomfiaUdedrrqmdL
         Es40TY3a0afs3RzMZGPfvpfcY1TTIhRDGPRey8EQR/qOfnDM4RJPnzd3GG2R6DQsjPZP
         gbTyXyTYy2gR+Ra+nWmsBaJYOJR6JEMk0+uKoRfBf65300M4HG2YbLRPnrKbC/zXeCab
         TizqfkRN3ygnSq2AAtposYunzEXphSaU4y6m3OVUe9DlxNBju60p95p8Im4XcCjGxM4L
         2JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710752067; x=1711356867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHUmVZZkH//enowhHNfhQSZre8bB7hubC6uVaHFa01o=;
        b=M8b6wHNbLQf9wq9HmpQkbdH3ZQB1CM9gpxsZte8EQk+LpRgXJmZrwibzYo/UUXnu5/
         uEAdQR27h7xx96+josUnX4Ko7hcHrtGkmMoMgV1GYEIhjeGOElNpw67It9Fd/pkw4Ljx
         Tl7ygsisvsR4pcT3axINWNZIao2OBapwTeJd3av2Ohknvy7zudVyZOnVgz5jiS6Y66vs
         3U4iTaS+SfDVx/x0tyJuMrUCbUKDbA8Eahxu9+B1eh5RDcQMtgjgeScz01w3T0m46L0J
         ZPqyrgetbiF+Jyq9nhFvx2UuKV9x4qJp7T/XxEJphRaLmaUXS/KPzLgMPnEc7LpQRALk
         JBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKwA1tnvjtfZrFt7mE2KumjPWk6uikuY4pf91MWo9C2KXGFw/Vbt189kKBqWFBJauqI3F4GnBKoJoRJPCq8NtSthDCG5BV
X-Gm-Message-State: AOJu0YwnnybKBC0w0MqJYhrSwpRW6wHXz7pHRMIycRVuY2HmpDMMie1V
	XtglWWPncyYvuFsG7SIcBRLmc7zLVq5f086jYYs8n+H4Q4kynQ591m+prQ7jUnlAnSngPN6/mhs
	i1v/vhpXQyTSdQ47Pfh/pjuqphklAO3LVg02z
X-Google-Smtp-Source: AGHT+IHCq63+QFWTsybS13RQa0I1cLwZCD4wtkG9FpZQtEad2k8CQLHY0vd1K71JnOGpvLxJr97KASHxH9/My4p2LKs=
X-Received: by 2002:a05:6402:485:b0:568:6867:40d9 with SMTP id
 k5-20020a056402048500b00568686740d9mr195369edv.2.1710752067358; Mon, 18 Mar
 2024 01:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315224710.55209-1-kuniyu@amazon.com>
In-Reply-To: <20240315224710.55209-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Mar 2024 09:54:13 +0100
Message-ID: <CANn89iL4G-3tom2=rs7W1tig=rse73QSuAmQbY=AC4X6sxhN6Q@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Clear req->syncookie in reqsk_alloc().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:47=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> syzkaller reported a read of uninit req->syncookie. [0]
>
> Originally, req->syncookie was used only in tcp_conn_request()
> to indicate if we need to encode SYN cookie in SYN+ACK, so the
> field remains uninitialised in other places.
>
> The commit 695751e31a63 ("bpf: tcp: Handle BPF SYN Cookie in
> cookie_v[46]_check().") added another meaning in ACK path;
> req->syncookie is set true if SYN cookie is validated by BPF
> kfunc.
>
> After the change, cookie_v[46]_check() always read req->syncookie,
> but it is not initialised in the normal SYN cookie case as reported
> by KMSAN.
>
> Let's make sure we always initialise req->syncookie in reqsk_alloc().
>
> [0]:
> BUG: KMSAN: uninit-value in cookie_v4_check+0x22b7/0x29e0
>  net/ipv4/syncookies.c:477
>  cookie_v4_check+0x22b7/0x29e0 net/ipv4/syncookies.c:477
>  tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1855 [inline]
>  tcp_v4_do_rcv+0xb17/0x10b0 net/ipv4/tcp_ipv4.c:1914
>  tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
>  ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
>  dst_input include/net/dst.h:460 [inline]
>  ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
>  __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
>  __
> Fixes: 695751e31a63 ("bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_che=
ck().")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Closes: https://lore.kernel.org/bpf/CANn89iKdN9c+C_2JAUbc+VY3DDQjAQukMtiB=
bormAmAk9CdvQA@mail.gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

