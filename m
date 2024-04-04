Return-Path: <netdev+bounces-84668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE0897D60
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F651C22278
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E9746E;
	Thu,  4 Apr 2024 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNOtVy85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F6BE40;
	Thu,  4 Apr 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193968; cv=none; b=GSFYVXRJXRyAzLinOB/PZVADMoxp7oD4+gFfRzr5PGasoFJN4wRHEeufSufLTe7zglJ+40nREN85E3QUCJZf+vZ09AePYgOFs6bYegtz/5mYWiIjsHIDJe8quqwXFvu48vBuveu7VbUOIFGAIculOTvKZ/oyeAX+DpeDGRGd4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193968; c=relaxed/simple;
	bh=Xj/UxtB9OZgBXNePHN21urrLY77r1gVxBSO1k4lUddE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubAP3GOvyvx9UxuUWewIuVuMOWpBsWXtr04tg8QPt/dF42I9/Hsky/2oM3yS6BAxXAW/Nzi+LOqwPAnOhykDJjjf6syyNFGg515XIyRLNqI5MemkIYh66Hd8lnGcfKHf2GDtrs7pRQkqs9xme4TG69Nqdk+0Qs3DC5Bnsh4QzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNOtVy85; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e05fc2421so2271372a12.0;
        Wed, 03 Apr 2024 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712193965; x=1712798765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjAqpWqnjs/8BQsJbWvblhIpXQr9Er7vm0Pw2QY3tEs=;
        b=RNOtVy85UeRii2ssJFIBHBDKgLp/fal5aYL9JgImsCZCtP+zjX6bXxLLpGShceP/jX
         rMrbsVnm1MZYYDS0ILgVUSaTv1prh6aKv5XNQHgOpqRqJADFjExRTVQca6oSRvLPBbL9
         4857t9JE4Df0TKoJw9aY8REwjZMpeHu2eAaI25ljxSKJOxggdiOPLn8H8r14QeG4DUvU
         fxMqvxLyqT+te82PUhQBjxc6xFTMqt7I3lO1sidgsIPUUJwPx2y58d7yn26Qwm3lfU5u
         6DCVlzxkYtNFdNWE1PsFpFbHAk8IkCTsc5sEVvpuB64utM9jwb/hEPfJ6OV8PtwrCq4p
         uYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712193965; x=1712798765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjAqpWqnjs/8BQsJbWvblhIpXQr9Er7vm0Pw2QY3tEs=;
        b=We6PaheWqqYPtB2kY80D8eQqYFEnqTp0bnD+L7Ci4mI+sXvCMpvZBcMYDJRVGtHMnE
         8Gmc+mh9PC9g1Yb5V+lH/CG+fDrlOASB/7V6KwXwSVkqzvFf0xf/LM+rwN7n8QFnX5pF
         cs/Mpi1i1IPYeDU5lea0pnW+HX7DwvwGXahmpswWWtAXNRn2BQ4pbMyc3//m9XuTLymd
         kLJurERGRaK4qlS8475x93bTFB0JH8TsRCrI0JoirpO9zrdAoP1tNTkJfcUBXuobRAu5
         HIGJkCK78O6ZtgIPlyQTcwy7btsyZAzDodDZV3i5WWVsh2vMdzgCFzV6T8vY4pYW6Xrx
         /kZw==
X-Forwarded-Encrypted: i=1; AJvYcCWVMhLy2K4B4YyPPWT4m1v/FjdqIA+cROWa0Gu5gQJvDGKRowfXRBsaL7VZhOZTK01HyaB1FVeq9CMQpjgGl/sirCi2Oi/TupFEWiO8+VICotpSUz/lv50YqJyk
X-Gm-Message-State: AOJu0YyEzTXWUsuqt5KT3wzv2eJbD/pF5RABSI6b5TZS2Xyp10Zw+Zc0
	Yqs0HNsflbJSSViXqGbRyH7GUh9OT9vYn8uuLgCjI5N9xP8W4TlIGL7ET199OdG4vyQmRMNzawI
	vg2yZcBzDkfqJWi3t9z1JiJmLiWw=
X-Google-Smtp-Source: AGHT+IGruOHSiKSijdMXGgplXIddOZL2drwZ0yXKSOW6IZniESk2neqljptiD7+fI8IV/ZfY5TZbTWQSI4ypA531GI4=
X-Received: by 2002:a17:906:230d:b0:a4e:9e7d:6588 with SMTP id
 l13-20020a170906230d00b00a4e9e7d6588mr3292957eja.27.1712193965048; Wed, 03
 Apr 2024 18:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329134037.92124-1-kerneljasonxing@gmail.com> <660dfbcb45cfc_23f4720810@john.notmuch>
In-Reply-To: <660dfbcb45cfc_23f4720810@john.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Apr 2024 09:25:28 +0800
Message-ID: <CAL+tcoAE7AC3-jP3NYL1SXPHbC3KCRj_VOvd1=T2e0YTk8R5+g@mail.gmail.com>
Subject: Re: [PATCH net] bpf, skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
To: John Fastabend <john.fastabend@gmail.com>
Cc: edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net, ast@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello John,

On Thu, Apr 4, 2024 at 9:01=E2=80=AFAM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() which
> > syzbot reported [1].
> >
> > [1]
> > BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_enqueue
> >
> > write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu 1:
> >  sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
> >  sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
> >  sk_psock_put include/linux/skmsg.h:459 [inline]
> >  sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
> >  unix_release+0x4b/0x80 net/unix/af_unix.c:1048
> >  __sock_release net/socket.c:659 [inline]
> >  sock_close+0x68/0x150 net/socket.c:1421
> >  __fput+0x2c1/0x660 fs/file_table.c:422
> >  __fput_sync+0x44/0x60 fs/file_table.c:507
> >  __do_sys_close fs/open.c:1556 [inline]
> >  __se_sys_close+0x101/0x1b0 fs/open.c:1541
> >  __x64_sys_close+0x1f/0x30 fs/open.c:1541
> >  do_syscall_64+0xd3/0x1d0
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >
> > read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu 0:
> >  sk_psock_data_ready include/linux/skmsg.h:464 [inline]
> >  sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:555
> >  sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606
> >  sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
> >  sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
> >  unix_read_skb net/unix/af_unix.c:2546 [inline]
> >  unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
> >  sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:1223
> >  unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg+0x140/0x180 net/socket.c:745
> >  ____sys_sendmsg+0x312/0x410 net/socket.c:2584
> >  ___sys_sendmsg net/socket.c:2638 [inline]
> >  __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
> >  __do_sys_sendmsg net/socket.c:2676 [inline]
> >  __se_sys_sendmsg net/socket.c:2674 [inline]
> >  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
> >  do_syscall_64+0xd3/0x1d0
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >
> > value changed: 0xffffffff83d7feb0 -> 0x0000000000000000
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W          6.8=
.0-syzkaller-08951-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 02/29/2024
> >
> > Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL pointer
> > dereference in sk_psock_verdict_data_ready()") fixed one NULL pointer
> > similarly due to no protection of saved_data_ready. Here is another
> > different caller causing the same issue because of the same reason. So
> > we should protect it with sk_callback_lock read lock because the writer
> > side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callback_lock);=
".
> >
> > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface=
")
> > Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Daa8c8ec2538929f18f2d
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/core/skmsg.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 4d75ef9d24bf..67c4c01c5235 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_b=
uff *skb,
> >       msg->skb =3D skb;
> >
> >       sk_psock_queue_msg(psock, msg);
> > +     read_lock_bh(&sk->sk_callback_lock);
> >       sk_psock_data_ready(sk, psock);
> > +     read_unlock_bh(&sk->sk_callback_lock);
> >       return copied;
> >  }
>
> The problem is the check and then usage presumably it is already set
> to NULL:
>
>  static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock =
*psock)
>  {
>         if (psock->saved_data_ready)
>                 psock->saved_data_ready(sk);

Yes.

>
>
> I'm thinking we might be able to get away with just a READ_ONCE here with
> similar WRITE_ONCE on other side. Something like this,

The simple fix that popped into my mind at the beginning is the same
as you: adding the READ_ONCE/WRITE_ONCE pair.

>
>   sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
>   {
>        saved_data_ready =3D READ_ONCE(psock->saved_data_ready)
>
>        if (saved_data_ready)
>              saved_data_ready(sk)
>        ....
>
> And then in sk_psock_stop_verdict,
>
>         WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
>         WRITE_ONCE(psock->saved_data_ready, NULL);
>
> And because we don't actually release the sock until a RCU grace period w=
e
> should be OK. The TCP stack manages to work correctly without wrapping
> tcp_data_ready in locks like this. But nice thing there is you don't chan=
ge
> this callback on live sockets.
>
> I think at least to keep backport simply above patch is ok, but lets move
> the read_lock_bh()/unlock_bh() into the sk_psock_data_ready() call and th=
en
> we don't duplicate this error again. Does that make sense?

Thanks for your quick response and such detailed analysis:)

It makes sense. I will move it into the sk_psock_data_ready(), then
three callers for now and possible callers in future would never go
wrong.

>
> Thanks,
> John
>

