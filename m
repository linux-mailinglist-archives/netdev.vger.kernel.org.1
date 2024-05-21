Return-Path: <netdev+bounces-97281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609788CA74A
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 06:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9C5B213B2
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 04:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5C23777;
	Tue, 21 May 2024 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ej1d0mtx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0321A0D
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716265033; cv=none; b=bkjcNhRsc7Re3BCsqb/eBkY9P1ritEyGwkM5/C7Y1vtxEqJUbeZ2J07P37rUxkxn0y+Ol4xGAjhNk1wyDfqPx63MrGSL/MdjzBJU+iTwMi/EG2Ii3QDOOBdHKNTdqXXfMvQz674g3NDKG+E5sbTeA4GydrRZMPCXMaKbBUnSBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716265033; c=relaxed/simple;
	bh=B5Ws7oPSJieA8dv3nUKBQt58B0bVX+DbH5x8TKiglsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8jfBEYhF2liGZ1BMKNbC1Op+MSaAyCzzaZecwQZcyXoBUv07fWnqYSPCRPe1/IrmU3KdTe3ds9XCm9hYvqsJPA8fOLIgWGsgHesCI5g3uaHqcZxomSFONICyWq95EbrjU+nuJW2EBlc4oj2JdMWiUf9txEKHVAEyKbVocORDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ej1d0mtx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so24748a12.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 21:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716265030; x=1716869830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7sTyi4dMqm5zx7i9SZ6M/M/hQj4ZKfkdffWcm34RTuQ=;
        b=ej1d0mtxfdGgLZ8KcKF7TLQ3RDrXRkUMRsbeUz3fvecLrcJDVct0Y1AGRBFYiPnme+
         wR40AUegEOOMJpKUVLUqsOWDndFPX2tCcaGX4sbPHFD6tnz6DBo/43CeV6B0vsdzM/3Z
         F+6NsDNqcKYNy6M5tDQCx4mpYb0Ft/SmnplkoM+zdvwcwgLBVbBPqav0aZRa17i0ME5G
         iFQrUZX50xKRLS1eOXbMGM9hY5exhh4sS34hOLIMpjbZMm/5NIRoyw2/oGDVntvMQ8s/
         tc/NdbWqASx6/rwb3dBbDz4N+7o+sVELIGs/6makdwDo6GQFqc5Mhe8aUYReisnJ7KdT
         jl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716265030; x=1716869830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sTyi4dMqm5zx7i9SZ6M/M/hQj4ZKfkdffWcm34RTuQ=;
        b=K/wEO59RUL+w5M6m0ycFFD2F5cb8MkApZbUhjGM+RVtIqXWXz8RdNExu7oC7dFLMZK
         6Tw2fXTVRHD9pmRSHq52gIs+9yToAPAyXPN7GbME8saUpt1dJ1gS22p4UW5Ue6lFHdc2
         qSidUBCjkTSVIrwd1Ejiik4TQmhOVR3UX3OKa6T3Q/vhfE+8PQ8jkQPcoU8gMH3Mvwwv
         IBzhECxzgE3H8rDgy/Ue+nQB0Om2FfZertIh9RSl3D9gCZKHqLIZo4YMxUNrzjHvp5bk
         1mbA3ypvrUsm7FTq5fVa7alOzVLZkoGcuu1PCGi2+nKYygOOWy+qsaURBGzX0usVBTKS
         GUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY2PXKOZPFXsl2eDzvv+ScRTFJSbeD9xy9sszra0Lib0JQYKyp2sTbpwlZudfqDZODVv5OPQc8ZrM5TFU68Z/PNgRUOiMr
X-Gm-Message-State: AOJu0YyDKlZGUZ9pbBftoz/qp+7uIRFxAR/F72ni7Jiyqw6XQ8N1c/bg
	0lLa2Llq0RKKFl6iFp/FaEeJNscXlHgQIJ50uyxNSm57RVJFL7qR2at0Il+8h6zSz2QELPbuz6J
	Awy20RpNz9xzTo6kxWE29l/z28PxiN0INaVpSdiwpjLA7FoSzyigdJ8Q=
X-Google-Smtp-Source: AGHT+IHAFZEu7xcamOd+Blg9qJBAhkq0+W7qiALByMK6OvFnWCnIx+cFpkG24T9Ep/IJoigzYL19O4kZLwUlZ2VrhyQ=
X-Received: by 2002:a05:6402:6d4:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-5752a7db1a6mr458573a12.4.1716265029666; Mon, 20 May 2024
 21:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518011346.36248-1-kuniyu@amazon.com>
In-Reply-To: <20240518011346.36248-1-kuniyu@amazon.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 21 May 2024 06:16:54 +0200
Message-ID: <CACT4Y+afQ-Y-Lt=A8LGv5zrAcb29a2TEweCqiqCuU+iL9xAkSw@mail.gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Annotate data-races around sk->sk_hash.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 May 2024 at 03:14, 'Kuniyuki Iwashima' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> syzkaller reported data-race of sk->sk_hash in unix_autobind() [0],
> and the same ones exist in unix_bind_bsd() and unix_bind_abstract().
>
> The three bind() functions prefetch sk->sk_hash locklessly and
> use it later after validating that unix_sk(sk)->addr is NULL under
> unix_sk(sk)->bindlock.
>
> The prefetched sk->sk_hash is the hash value of unbound socket set
> in unix_create1() and does not change until bind() completes.
>
> There could be a chance that sk->sk_hash changes after the lockless
> read.  However, in such a case, non-NULL unix_sk(sk)->addr is visible
> under unix_sk(sk)->bindlock, and bind() returns -EINVAL without using
> the prefetched value.
>
> The KCSAN splat is false-positive, but let's use WRITE_ONCE() and
> READ_ONCE() to silence it.
>
> [0]:
> BUG: KCSAN: data-race in unix_autobind / unix_autobind
>
> write to 0xffff888034a9fb88 of 4 bytes by task 4468 on cpu 0:
>  __unix_set_addr_hash net/unix/af_unix.c:331 [inline]
>  unix_autobind+0x47a/0x7d0 net/unix/af_unix.c:1185
>  unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
>  __sys_connect_file+0xd7/0xe0 net/socket.c:2048
>  __sys_connect+0x114/0x140 net/socket.c:2065
>  __do_sys_connect net/socket.c:2075 [inline]
>  __se_sys_connect net/socket.c:2072 [inline]
>  __x64_sys_connect+0x40/0x50 net/socket.c:2072
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>
> read to 0xffff888034a9fb88 of 4 bytes by task 4465 on cpu 1:
>  unix_autobind+0x28/0x7d0 net/unix/af_unix.c:1134
>  unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
>  __sys_connect_file+0xd7/0xe0 net/socket.c:2048
>  __sys_connect+0x114/0x140 net/socket.c:2065
>  __do_sys_connect net/socket.c:2075 [inline]
>  __se_sys_connect net/socket.c:2072 [inline]
>  __x64_sys_connect+0x40/0x50 net/socket.c:2072
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>
> value changed: 0x000000e4 -> 0x000001e3
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 4465 Comm: syz-executor.0 Not tainted 6.8.0-12822-gcd51db110a7e #12
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>
> Fixes: afd20b9290e1 ("af_unix: Replace the big lock with small locks.")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 92a88ac070ca..e92b45e21664 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -327,8 +327,7 @@ static void __unix_set_addr_hash(struct net *net, struct sock *sk,
>  {
>         __unix_remove_socket(sk);
>         smp_store_release(&unix_sk(sk)->addr, addr);
> -
> -       sk->sk_hash = hash;
> +       WRITE_ONCE(sk->sk_hash, hash);
>         __unix_insert_socket(net, sk);
>  }
>
> @@ -1131,7 +1130,7 @@ static struct sock *unix_find_other(struct net *net,
>
>  static int unix_autobind(struct sock *sk)
>  {
> -       unsigned int new_hash, old_hash = sk->sk_hash;
> +       unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
>         struct unix_sock *u = unix_sk(sk);
>         struct net *net = sock_net(sk);
>         struct unix_address *addr;
> @@ -1195,7 +1194,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
>  {
>         umode_t mode = S_IFSOCK |
>                (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
> -       unsigned int new_hash, old_hash = sk->sk_hash;
> +       unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
>         struct unix_sock *u = unix_sk(sk);
>         struct net *net = sock_net(sk);
>         struct mnt_idmap *idmap;
> @@ -1261,7 +1260,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
>  static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
>                               int addr_len)
>  {
> -       unsigned int new_hash, old_hash = sk->sk_hash;
> +       unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
>         struct unix_sock *u = unix_sk(sk);
>         struct net *net = sock_net(sk);
>         struct unix_address *addr;



Hi,

I don't know much about this code, but perhaps these accesses must be
protected by bindlock instead?
It shouldn't autobind twice, right? Perhaps the code just tried to
save a line of code and moved the reads to the variable declaration
section.

