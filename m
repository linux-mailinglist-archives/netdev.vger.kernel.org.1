Return-Path: <netdev+bounces-97516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABAA8CBD4F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F19D2814AE
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D58002F;
	Wed, 22 May 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6okhUiW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303117E583
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367947; cv=none; b=Hd32pBcwsJ63+d/ktJ1o+TUOwHwXtdD9zE7EukeD32Qo/bBVq6mpGcTKB7RFM4Kf0TFpe0tMl72LdQkBA4txWVT2xV6agm5czcDffGVcW6ClWajIsOPbqdm7FVGFqck4Cs27lUGHjf3BmHJbnBuzRIS3cNgpmIgyyyZgy5aW6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367947; c=relaxed/simple;
	bh=1a0tijc7EepbdlV49Y8gUMIe2Lw23vq46ZftZaywC7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nks34gutJUjWtzba/D8keEmE0PqzHzskjjTaYjLV7VoeAnLmLfmESzUs9m3WzgBnFpaogLxAEPIZfeQqEvOhEf71PkYqEmmdn9QFNa+ciFEOzbM3iTeeWMJElf74YQLyxvVzuQCM4MVm0J6yah+yo1sod32KNkepv1vcUzr1YwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6okhUiW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716367945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x8Z/+64QvbiN0Qdg5uYolDNncR4gIyQttw+JmN+I2dk=;
	b=Q6okhUiWr+xxXxNJYxe9PGW7AVo02aDYaHYoMJx+x0qBwYHEo7E9CUXsViBINtQu/ZG7c4
	3w4ips/WHn5tc0CmwZP+G6kA9aBh6Qy0MYMTmbuvwRt7Pc0bJZq0DuUild15lXfJY+Os03
	9JeuMh+A+KRjf8oZ/rm6amILxSqfd0k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Lg4HwWTzPnapa62Hxz7aAg-1; Wed, 22 May 2024 04:52:23 -0400
X-MC-Unique: Lg4HwWTzPnapa62Hxz7aAg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51ffdd3524eso2311306e87.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716367942; x=1716972742;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8Z/+64QvbiN0Qdg5uYolDNncR4gIyQttw+JmN+I2dk=;
        b=KXERmT5YxcZfiBY+N9jx6qoEq5aIf2xBQhkEECTswdCtTJTqQyRvJxyvC8ADXpI+S0
         siIA0Ph7dRGtGg0kFUuzOxOIQBwv8+pL1SPi/XiwAiaH/jiuoFTWaIbUUvW0fUH5o3UH
         VbHtIXJL+V8oLupswtZBdpk7n2Xm7NDnn2jkLsLN8wZmtYDpic305wWjQ7WUjG23LsrA
         gvtUqXnro7+zxok8VAlgvZtbE3EqIE8KwWC8mExIEw7KZLthevYSzoJVH2bqUWBAhewc
         ySqlki27QV0VIxxGM6qPArlhekSFw7AAFkleOJKyH0PPw6V7e0WYQqKVJziZ6xM/RERL
         XAiA==
X-Forwarded-Encrypted: i=1; AJvYcCXY/IT+m4ERtsi5needRZVsjwADsfSaquLN2Ok63Pn1+kZmtT8gPbZYzXc7MEQ3ckbx/xRB/H9Ecn846ZLGZJjsdaZK6Aa5
X-Gm-Message-State: AOJu0YytzerwYhVG2O1b/TdcyG0pUtLppTop2pLWcDdB4hshUFtFnq9M
	Whus/ct3uDW8fdIxlu/1GS7KivejsVRDEDm9fenLBWtveirHFUv+y5AdIUgJCaqDYPsLrSOJBJi
	WJWaLcg1jCg82FUkWbRu+SVRO4RVUWsmPPwba5CFX8UHrAYWnu4MVbg==
X-Received: by 2002:a05:6512:2814:b0:516:c241:a912 with SMTP id 2adb3069b0e04-526bda691a6mr908744e87.1.1716367941953;
        Wed, 22 May 2024 01:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXwnvRNmTipJ0Yq4wnXDUw/O8voEpeIJO7dw1Ln+lXyjoX4tpnJ1XdMGry0hSnthoMtB5zAw==
X-Received: by 2002:a05:6512:2814:b0:516:c241:a912 with SMTP id 2adb3069b0e04-526bda691a6mr908730e87.1.1716367941486;
        Wed, 22 May 2024 01:52:21 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc887sm33471422f8f.98.2024.05.22.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:52:20 -0700 (PDT)
Message-ID: <6a187b65c4b2e487461e5d3b2270670586841d84.camel@redhat.com>
Subject: Re: [PATCH v1 net] af_unix: Annotate data-race around
 unix_sk(sk)->addr.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzkaller <syzkaller@googlegroups.com>
Date: Wed, 22 May 2024 10:52:19 +0200
In-Reply-To: <20240518000148.27947-1-kuniyu@amazon.com>
References: <20240518000148.27947-1-kuniyu@amazon.com>
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

On Sat, 2024-05-18 at 09:01 +0900, Kuniyuki Iwashima wrote:
> Once unix_sk(sk)->addr is assigned under net->unx.table.locks,
> *(unix_sk(sk)->addr) and unix_sk(sk)->path are fully set up, and
> unix_sk(sk)->addr is never changed.
>=20
> unix_getname() and unix_copy_addr() access the two fields locklessly,
> and commit ae3b564179bf ("missing barriers in some of unix_sock ->addr
> and ->path accesses") added smp_store_release() and smp_load_acquire()
> pairs.
>=20
> In other functions, we still read unix_sk(sk)->addr locklessly to check
> if the socket is bound, and KCSAN complains about it.  [0]
>=20
> Given these functions have no dependency for *(unix_sk(sk)->addr) and
> unix_sk(sk)->path, READ_ONCE() is enough to annotate the data-race.
>=20
> [0]:
> BUG: KCSAN: data-race in unix_bind / unix_listen
>=20
> write (marked) to 0xffff88805f8d1840 of 8 bytes by task 13723 on cpu 0:
>  __unix_set_addr_hash net/unix/af_unix.c:329 [inline]
>  unix_bind_bsd net/unix/af_unix.c:1241 [inline]
>  unix_bind+0x881/0x1000 net/unix/af_unix.c:1319
>  __sys_bind+0x194/0x1e0 net/socket.c:1847
>  __do_sys_bind net/socket.c:1858 [inline]
>  __se_sys_bind net/socket.c:1856 [inline]
>  __x64_sys_bind+0x40/0x50 net/socket.c:1856
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>=20
> read to 0xffff88805f8d1840 of 8 bytes by task 13724 on cpu 1:
>  unix_listen+0x72/0x180 net/unix/af_unix.c:734
>  __sys_listen+0xdc/0x160 net/socket.c:1881
>  __do_sys_listen net/socket.c:1890 [inline]
>  __se_sys_listen net/socket.c:1888 [inline]
>  __x64_sys_listen+0x2e/0x40 net/socket.c:1888
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>=20
> value changed: 0x0000000000000000 -> 0xffff88807b5b1b40
>=20
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 13724 Comm: syz-executor.4 Not tainted 6.8.0-12822-gcd51db110=
a7e #12
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index ca101690e740..92a88ac070ca 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -731,7 +731,7 @@ static int unix_listen(struct socket *sock, int backl=
og)
>  	if (sock->type !=3D SOCK_STREAM && sock->type !=3D SOCK_SEQPACKET)
>  		goto out;	/* Only stream/seqpacket sockets accept */
>  	err =3D -EINVAL;
> -	if (!u->addr)
> +	if (!READ_ONCE(u->addr))
>  		goto out;	/* No listens on an unbound socket */
>  	unix_state_lock(sk);
>  	if (sk->sk_state !=3D TCP_CLOSE && sk->sk_state !=3D TCP_LISTEN)
> @@ -1369,7 +1369,7 @@ static int unix_dgram_connect(struct socket *sock, =
struct sockaddr *addr,
> =20
>  		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
>  		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> -		    !unix_sk(sk)->addr) {
> +		    !READ_ONCE(unix_sk(sk)->addr)) {
>  			err =3D unix_autobind(sk);
>  			if (err)
>  				goto out;
> @@ -1481,7 +1481,8 @@ static int unix_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
>  		goto out;
> =20
>  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> +	    !READ_ONCE(u->addr)) {
>  		err =3D unix_autobind(sk);
>  		if (err)
>  			goto out;
> @@ -1951,7 +1952,8 @@ static int unix_dgram_sendmsg(struct socket *sock, =
struct msghdr *msg,
>  	}
> =20
>  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> +	    !READ_ONCE(u->addr)) {
>  		err =3D unix_autobind(sk);
>  		if (err)
>  			goto out;

There are a few other places where ->addr is accessed lockless (under
the bindlock, but prior to acquiring the table spinlock, e.g.
unix_bind_* and unix_autobind. The latter is suspect as it's called
right after the touched code. Why are such spots not relevant here?

Also the  newu->addr/otheru->addr handling in unix_stream_connect()
looks suspect.

Thanks,

Paolo


