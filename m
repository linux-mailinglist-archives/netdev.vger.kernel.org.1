Return-Path: <netdev+bounces-97597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD78CC40E
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205451C221B5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1056B8C;
	Wed, 22 May 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq6VbQwY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE455C3E
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391531; cv=none; b=vEa3A5a+TvE/Y7gsSt0puLZF890M+ef1ybGJU3QhxtxbpBPnfO8CkxSIqdKUd7B7Ap4CqIuXOtUjkeTMCEcwJmZAyHZtZctMwrguX1Gc3VxrjO+eFZe2ifIKSJsFb6eAGLbmgkJ8mmOqrdu9dYpNzRa8uMCsspUNMBz4kh/IVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391531; c=relaxed/simple;
	bh=pso67Fg7tiC7rA3eDP7TrmjK55RPPqVnk9NLllzsX+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbfaFlLcReckPScQxkfWS6mv2TBSFLyOlrGhIHIbv9XKvVDppPOs8REwTdk+Oz3HCqdI6zGAaxg9CN0W9l43CwDrjJ9s/j0c4tYwTBNO8+KvF3EAAd4qv58L6xzybAsq/fBldbvsdG+BfIvrfv7KjUXPKHVEMAqCy2ptrI2BkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iq6VbQwY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716391529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wszyoLDUblhZHalCn/mbkWZzj4Geoo3gN6UiN/37lkY=;
	b=Iq6VbQwYRNkVJVK/GPS4AFE2t3ZcLocSBvsmh4xX4KClyCQzSdgKzdBkAI79rIBMoffMux
	dadsn1BlA7bOkFV+0epGQ0/uUzitOmTdU9QJQyQVLdq4KbEaawGJuxaQ0xYkfHpeRUgs9x
	a801t/TNIperQh5E6VeeTBpLrcWvb1c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-JQgI0BIhNqKnFLDYsrPx2A-1; Wed, 22 May 2024 11:25:27 -0400
X-MC-Unique: JQgI0BIhNqKnFLDYsrPx2A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-354f30004c8so53621f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391526; x=1716996326;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wszyoLDUblhZHalCn/mbkWZzj4Geoo3gN6UiN/37lkY=;
        b=BJ0gwDpc2uXQApBqweH/NuP2a3nFxPm+lzX20Qe/Ni4NwQn8F7bWUFh6pbeN6dYuNP
         bCs4YSlMIm9K+LJyx/ImLSq4EvNAGfygJKgiIqXTE5ialE1qKENvN2oFEJ1Vy6ThybjK
         1UE/L/yf2yaYC+cBhWJrVbBHtf2qzEt88dmLejEnzVC8Z8eatxBvMsfhH3yv4CcNW/rp
         9rvhG9MMMaIpwZkh9f06t4Bplwo0rGAO6bM0+Q4I8fBlGHLxknNNtHpNKu7750rQgoAe
         hqQ1tt+uRdhEaK9RsRg3QhoRysSLreijNhoCfnOI9MMYQzlolDZjM//cB/3dHYQiuv1V
         MG2g==
X-Forwarded-Encrypted: i=1; AJvYcCX0KVqeF1bxNqve3B8OmZnLiTb5yNjHmnJ1RjpD/MoM7CRLazNK6KD7h4Snud4AEfQkhSZJgEufEZUdIpVPQVeko9e8DEfR
X-Gm-Message-State: AOJu0YyjJrvljQeOtY7yN+XmYYGfvwBfUMeTEKWT+4HUx17KBhm2uOzH
	leEBWpaa30cu7s/NYDaToT4R5dTBitgaBs0oW5kwrClHiBV5Hyp58CZCM7MTyyW8hD1mLiTKeME
	QxFkdo8h6BA62CT3dPlUzBPVAzldGUMjUF2U2D7YPXi1BqCRJFPCHEA==
X-Received: by 2002:a05:600c:3544:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-420fd376c84mr17589765e9.3.1716391526290;
        Wed, 22 May 2024 08:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiLMqeDhfh/qCvJvTbZG30QYu2dsEyGsC7R4hvREXWJUEZobvaj1rW9pRbxlv4rHS9g2aYVA==
X-Received: by 2002:a05:600c:3544:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-420fd376c84mr17589555e9.3.1716391525807;
        Wed, 22 May 2024 08:25:25 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm536385985e9.25.2024.05.22.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:25:25 -0700 (PDT)
Message-ID: <f39283e8d2395a994255617a78a30702a1cc4f00.camel@redhat.com>
Subject: Re: [PATCH v1 net] af_unix: Annotate data-race around
 unix_sk(sk)->addr.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org, syzkaller@googlegroups.com
Date: Wed, 22 May 2024 17:25:23 +0200
In-Reply-To: <20240522145309.74255-1-kuniyu@amazon.com>
References: <6a187b65c4b2e487461e5d3b2270670586841d84.camel@redhat.com>
	 <20240522145309.74255-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 23:53 +0900, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Wed, 22 May 2024 10:52:19 +0200
> > On Sat, 2024-05-18 at 09:01 +0900, Kuniyuki Iwashima wrote:
> > > Once unix_sk(sk)->addr is assigned under net->unx.table.locks,
> > > *(unix_sk(sk)->addr) and unix_sk(sk)->path are fully set up, and
> > > unix_sk(sk)->addr is never changed.
> > >=20
> > > unix_getname() and unix_copy_addr() access the two fields locklessly,
> > > and commit ae3b564179bf ("missing barriers in some of unix_sock ->add=
r
> > > and ->path accesses") added smp_store_release() and smp_load_acquire(=
)
> > > pairs.
> > >=20
> > > In other functions, we still read unix_sk(sk)->addr locklessly to che=
ck
> > > if the socket is bound, and KCSAN complains about it.  [0]
> > >=20
> > > Given these functions have no dependency for *(unix_sk(sk)->addr) and
> > > unix_sk(sk)->path, READ_ONCE() is enough to annotate the data-race.
> > >=20
> > > [0]:
> > > BUG: KCSAN: data-race in unix_bind / unix_listen
> > >=20
> > > write (marked) to 0xffff88805f8d1840 of 8 bytes by task 13723 on cpu =
0:
> > >  __unix_set_addr_hash net/unix/af_unix.c:329 [inline]
> > >  unix_bind_bsd net/unix/af_unix.c:1241 [inline]
> > >  unix_bind+0x881/0x1000 net/unix/af_unix.c:1319
> > >  __sys_bind+0x194/0x1e0 net/socket.c:1847
> > >  __do_sys_bind net/socket.c:1858 [inline]
> > >  __se_sys_bind net/socket.c:1856 [inline]
> > >  __x64_sys_bind+0x40/0x50 net/socket.c:1856
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > >=20
> > > read to 0xffff88805f8d1840 of 8 bytes by task 13724 on cpu 1:
> > >  unix_listen+0x72/0x180 net/unix/af_unix.c:734
> > >  __sys_listen+0xdc/0x160 net/socket.c:1881
> > >  __do_sys_listen net/socket.c:1890 [inline]
> > >  __se_sys_listen net/socket.c:1888 [inline]
> > >  __x64_sys_listen+0x2e/0x40 net/socket.c:1888
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > >=20
> > > value changed: 0x0000000000000000 -> 0xffff88807b5b1b40
> > >=20
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 1 PID: 13724 Comm: syz-executor.4 Not tainted 6.8.0-12822-gcd51d=
b110a7e #12
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.=
0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > >=20
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/unix/af_unix.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index ca101690e740..92a88ac070ca 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -731,7 +731,7 @@ static int unix_listen(struct socket *sock, int b=
acklog)
> > >  	if (sock->type !=3D SOCK_STREAM && sock->type !=3D SOCK_SEQPACKET)
> > >  		goto out;	/* Only stream/seqpacket sockets accept */
> > >  	err =3D -EINVAL;
> > > -	if (!u->addr)
> > > +	if (!READ_ONCE(u->addr))
> > >  		goto out;	/* No listens on an unbound socket */
> > >  	unix_state_lock(sk);
> > >  	if (sk->sk_state !=3D TCP_CLOSE && sk->sk_state !=3D TCP_LISTEN)
> > > @@ -1369,7 +1369,7 @@ static int unix_dgram_connect(struct socket *so=
ck, struct sockaddr *addr,
> > > =20
> > >  		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > >  		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > > -		    !unix_sk(sk)->addr) {
> > > +		    !READ_ONCE(unix_sk(sk)->addr)) {
> > >  			err =3D unix_autobind(sk);
> > >  			if (err)
> > >  				goto out;
> > > @@ -1481,7 +1481,8 @@ static int unix_stream_connect(struct socket *s=
ock, struct sockaddr *uaddr,
> > >  		goto out;
> > > =20
> > >  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > > -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> > > +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > > +	    !READ_ONCE(u->addr)) {
> > >  		err =3D unix_autobind(sk);
> > >  		if (err)
> > >  			goto out;
> > > @@ -1951,7 +1952,8 @@ static int unix_dgram_sendmsg(struct socket *so=
ck, struct msghdr *msg,
> > >  	}
> > > =20
> > >  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > > -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> > > +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > > +	    !READ_ONCE(u->addr)) {
> > >  		err =3D unix_autobind(sk);
> > >  		if (err)
> > >  			goto out;
> >=20
> > There are a few other places where ->addr is accessed lockless (under
> > the bindlock, but prior to acquiring the table spinlock, e.g.
> > unix_bind_* and unix_autobind. The latter is suspect as it's called
> > right after the touched code. Why are such spots not relevant here?
>=20
> When u->addr is set, bindlock and the hash table lock are held.
> unix_bind_(abstract|bsd)() and unix_autobind() are all serialised
> by bindlock, so ->addr check after acquiring bindlock is not
> lockless actually.
>=20
>=20
> >=20
> > Also the  newu->addr/otheru->addr handling in unix_stream_connect()
> > looks suspect.
>=20
> u->addr is set before the socket is put into the hash table, and
> it never changes after bind().
>=20
> otheru is found by unix_find_other() from the hash table, and then
> we access ->addr in unix_stream_connect().  So, there is no race.

I see.=20

I think the serialization chain is not trivial, I think it would help
future memory to at least mention it in the commit message or in a code
comment.


Thanks,

Paolo


