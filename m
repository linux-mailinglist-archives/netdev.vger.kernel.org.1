Return-Path: <netdev+bounces-85392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC7089A939
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 07:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782CA1C20BD7
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEA200B7;
	Sat,  6 Apr 2024 05:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCGOcHR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13EF10A1A
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712382529; cv=none; b=ouymeqHSRmSeqkSpNEKUwxoAQO6TlvIluU7e04Fm+zKXHsEohUiUJBOZyXrZdcAui7Ind/R9N/zgZesvF8qlxt8izkPC5hiaNV1ZdRmaPA+Ft4LZQkhheyBLk6DZIwyF46RuBlIKP0AccfZdGfxXV0m0um43hPOh0RKTbdb5v/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712382529; c=relaxed/simple;
	bh=4CTaIu1vdl6xhM+6q/nywk71VL+bBRwfIfbquDP1fvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/SBeemSkIm6mX1jf+LmtTbQp1Clc6CtIuW/9a2QYeO18eGhfD+IMf+waAONlW/TXh6FnxJf4ky0JzbAmOVfITL14Z2vOW3NtS2A6p1LUgtRFmRPOLYV6y5ylYpVaiJImq68tsOFVOJr7KzMy0Ik23DFYB67SwQpFMXdo9jG/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCGOcHR5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so3636a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 22:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712382526; x=1712987326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVEy6G5zg+u+2ciUPfwyp6zQP32RY+PZjljkE6lwyfM=;
        b=zCGOcHR535My3NKaZoFuJgSRBKKxd5c+oL8MNeq/1klgo3m9UrFFz6KkonvOfdZoq1
         R0vtL/8ZEJXgTCHcSp4Ve1lRS2gnoLzxQqU49EPkJ070Q/RVr6jeEcgYM+pYOSZVhdVa
         lYtyyHVPlD+9/KGblZa77jIJcot3eSs46k3Xf+i96diNn239VviDG6MLwSgmUZcXGLxD
         KtPSWFQYBt2ErNdw1si3APvDwvg0pIFvkDpVKSAHLbC4Jn7f51Xg9i4e1Q4+3jK7Cqs1
         1G+a61fkAboRYUheKGoi8WNTfXsYvBJdHkrmmyfpImEtiGOFWYImRAnZUeMGZ8nO1Zwi
         X8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712382526; x=1712987326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVEy6G5zg+u+2ciUPfwyp6zQP32RY+PZjljkE6lwyfM=;
        b=p1BtAg/Std0Y9SO9nhMt9bZzGq87HamvDHzFhL2OD6oyMTIu50p7Cf1FZe1W5An4Pr
         T/R3dvO8omE7hqp/fPki1q+g/tE8oiXTX1rFb7IEtjSt2guIIFdWxhxt2+2M6gQh5sPQ
         kmkPm4EzUK+wrdQZi3zIBjkR747+QJK4z+Zp1OLxI0ku9ETHdcqi2D/822E24XhixMU6
         mUYY7fp7knBzNnQhIdosO3SArgnT7XO9clwIA88alHoI+HVZXYl10sts2iiHaH6FbzCC
         DTqLn3CrwoHDNJ4fUHvtOw6+lP6SiC/tQHTA4H3fO3geKmgOOAeOpyftcv5utOsI8/wp
         AaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcjqXZcWRnvZeBOrkeWjvvKIbRhbxfRQbrFx9RAEyB4Qhjq5CgJ6me+k7lfXu5r1BIODP20EBlLj/4fNwCIUguXOVx9PE6
X-Gm-Message-State: AOJu0YwTf1pgBxX/8e1qwKhemafI8fPa63je+YAUoYrUOebL3aQZcoiW
	cSR6OxePzY8OepBm2ShbtLDU3a5gcaor6FaDYmHtbWzlVqGI+GcHXmCl6Q3VXfdXxd9gzfd2COA
	Kv0Fvlbix/g11Zm65+eEhOCw1p/TAR3pnm3Rq3X9/xqxF8ihT2Q==
X-Google-Smtp-Source: AGHT+IEaWnC/hG0i2Jyl2ooeI9T0tHYk5wpfk8x/F/XIh4rDyof1+d+y6w1eApxWWXzkF66TeRZchiTnRDV3IRYUXlM=
X-Received: by 2002:a05:6402:27d0:b0:56e:76e:6ea9 with SMTP id
 c16-20020a05640227d000b0056e076e6ea9mr94620ede.6.1712382525847; Fri, 05 Apr
 2024 22:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405221057.2406-1-kuniyu@amazon.com>
In-Reply-To: <20240405221057.2406-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Apr 2024 07:48:32 +0200
Message-ID: <CANn89iLrwfVkAaf2ERUm=e832BuJTzpgFGxr46-1SR+23z7QrA@mail.gmail.com>
Subject: Re: [PATCH v2 net] af_unix: Clear stale u->oob_skb.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rao shoaib <rao.shoaib@oracle.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 12:11=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller started to report deadlock of unix_gc_lock after commit
> 4090fa373f0e ("af_unix: Replace garbage collection algorithm."), but
> it just uncovers the bug that has been there since commit 314001f0bf92
> ("af_unix: Add OOB support").
>
> The repro basically does the following.
>
>   from socket import *
>   from array import array
>
>   c1, c2 =3D socketpair(AF_UNIX, SOCK_STREAM)
>   c1.sendmsg([b'a'], [(SOL_SOCKET, SCM_RIGHTS, array("i", [c2.fileno()]))=
], MSG_OOB)
>   c2.recv(1)  # blocked as no normal data in recv queue
>
>   c2.close()  # done async and unblock recv()
>   c1.close()  # done async and trigger GC
>
> A socket sends its file descriptor to itself as OOB data and tries to
> receive normal data, but finally recv() fails due to async close().
>
> The problem here is wrong handling of OOB skb in manage_oob().  When
> recvmsg() is called without MSG_OOB, manage_oob() is called to check
> if the peeked skb is OOB skb.  In such a case, manage_oob() pops it
> out of the receive queue but does not clear unix_sock(sk)->oob_skb.
> This is wrong in terms of uAPI.
>
> Let's say we send "hello" with MSG_OOB, and "world" without MSG_OOB.
> The 'o' is handled as OOB data.  When recv() is called twice without
> MSG_OOB, the OOB data should be lost.
>
>   >>> from socket import *
>   >>> c1, c2 =3D socketpair(AF_UNIX, SOCK_STREAM, 0)
>   >>> c1.send(b'hello', MSG_OOB)  # 'o' is OOB data
>   5
>   >>> c1.send(b'world')
>   5
>   >>> c2.recv(5)  # OOB data is not received
>   b'hell'
>   >>> c2.recv(5)  # OOB date is skipped
>   b'world'
>   >>> c2.recv(5, MSG_OOB)  # This should return an error
>   b'o'
>
> In the same situation, TCP actually returns -EINVAL for the last
> recv().
>
> Also, if we do not clear unix_sk(sk)->oob_skb, unix_poll() always set
> EPOLLPRI even though the data has passed through by previous recv().
>
> To avoid these issues, we must clear unix_sk(sk)->oob_skb when dequeuing
> it from recv queue.
>
> The reason why the old GC did not trigger the deadlock is because the
> old GC relied on the receive queue to detect the loop.
>
> When it is triggered, the socket with OOB data is marked as GC candidate
> because file refcount =3D=3D inflight count (1).  However, after traversi=
ng
> all inflight sockets, the socket still has a positive inflight count (1),
> thus the socket is excluded from candidates.  Then, the old GC lose the
> chance to garbage-collect the socket.
>
> With the old GC, the repro continues to create true garbage that will
> never be freed nor detected by kmemleak as it's linked to the global
> inflight list.  That's why we couldn't even notice the issue.
>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7f7f201cc2668a8fd169
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

