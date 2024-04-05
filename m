Return-Path: <netdev+bounces-85080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A6899490
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 06:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7281C20EB0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 04:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574DA20322;
	Fri,  5 Apr 2024 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7yJz7OX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FB19BA3;
	Fri,  5 Apr 2024 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292352; cv=none; b=sdh6GFr4RTrIPDhfzQkQfqR4qDQz658TpMCv7XMq4ZWG1KT5sPAEBomtlX8+qkFl5kYtU+0m5IFV24iRPnImobcuVxaz4ElLj942DLEV2++v1nm9NMVfMVg1YTurcENxfPfqarIhkq2yLAgQvQ3Yd16l2rOS9pA9t8bcpOSB7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292352; c=relaxed/simple;
	bh=1PPF8KmGxh5mj/yWvzoijvNHrwcFuI+UTlEitdNLCUU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V1/BvBY7mcdMuNTTsjlwDqNqkUW12HfOFUqziyURR7LVn5AiXZzUJoD5+Z2X00klhTgztW/K6s9VnwCSyxkM1tYLxd3PBZ57WWp2wpkmvNB3gl4XMW4Bcf7Lue+vu8zKQbTFDLUOrBN/JGGK9Ydd+mTo9YH1X+iEK9XDJWXAuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7yJz7OX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e6a5bd015dso776035a34.2;
        Thu, 04 Apr 2024 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292349; x=1712897149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcCQkiJEPd/TzujRBZ4mXYAdvot+pHVeCPWvQ7gpqKE=;
        b=d7yJz7OXfHy9hR9R4lzyZhmgrxMIK1qe9ziQ4mQiuBzvhWGHeJzUj/g/Yz8Q12rSe6
         MklfS/CjpdC7FiQtO05qQHqZNNBd9PDsBRB3b+4jShjs8E9iBzg+UD6b5xCW8zXV2Ul3
         lLjujL7e6HoCu3BXTGct6LBytJQwWfgl6p33QC6F+t2GAMDyIi2I1ZdFkH3MB7vj+WG9
         tEhPihQNPbhFTv2i01EcNHEQOXYlIwMz8oCMrC3kQ1q9SoP7cXl/+WTjs1ZGEuQO37qU
         X6FUk/MW2xkG8Gq/dvghobDOrVpSgYLufFrZTU5+8+yliVY7xmc30dI4+PJO0010mfRh
         ToLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292349; x=1712897149;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wcCQkiJEPd/TzujRBZ4mXYAdvot+pHVeCPWvQ7gpqKE=;
        b=JFF0ndzvpcayL65X1XF3wTcBbNEkUOuaAxWXxcszf7KMCf+afia5I3qAJw5g34NmAI
         ZDtho5MSVIziigtiqjBQrHv5KmemBzYBNuwRPgZI1rlOHzLUzAP8Haq0YJwr3EMZRvOL
         /kqXWH1wYTWlPeSDHEcWQBMH1rR5ikrzLdLPt7Qg9OqMJFiwubs95e6NEGfQntmHHHBT
         D2h7ZvzJLYdESlg25q/xgP0G3JKSbRmEzJyjW8lQnmbgfrl2eBCafRWuzx0wEdmwZlGk
         CmYxTVEEAqsFBh/r/5ZOPGMCR8kUZRo3B1Nn8Pb5JmmDeIPy8OhFsxv+ODyGcjH83Trr
         VhTw==
X-Forwarded-Encrypted: i=1; AJvYcCXxOuypQFlKYYj/smu5YqTnuFE7DH9SEUS6VJXrkfMjqtp74swSBppqYP4Z5JEN7tqCGcWkvDrbrWFEe47maoVcXEEx4L8wCAn9WzFNqVy4+IXS4+7vSEH6f+JX
X-Gm-Message-State: AOJu0Yw4JY6GMBVRm82nlfoGjN7eWTS7WXykMXvad1pKl3Y36rdTSg45
	xrqtpwhUkGnK6usEA3bl/3y/LaDj/xAY5QHqZs/6//fllHISFSfK
X-Google-Smtp-Source: AGHT+IHI9gPGfcZWvscQi0HD0IE7krWjrDy9UM5+ZjLZgTcEZJwa8OcgwckfUVo1lrskoRMMtLe2aA==
X-Received: by 2002:a05:6870:860d:b0:22e:8d62:fa75 with SMTP id h13-20020a056870860d00b0022e8d62fa75mr396682oal.44.1712292349569;
        Thu, 04 Apr 2024 21:45:49 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id y41-20020a056a00182900b006eb058b2703sm522613pfa.187.2024.04.04.21.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:45:49 -0700 (PDT)
Date: Thu, 04 Apr 2024 21:45:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: edumazet@google.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 daniel@iogearbox.net, 
 ast@kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Message-ID: <660f81fc59256_50b87208e9@john.notmuch>
In-Reply-To: <CAL+tcoAE7AC3-jP3NYL1SXPHbC3KCRj_VOvd1=T2e0YTk8R5+g@mail.gmail.com>
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
 <660dfbcb45cfc_23f4720810@john.notmuch>
 <CAL+tcoAE7AC3-jP3NYL1SXPHbC3KCRj_VOvd1=T2e0YTk8R5+g@mail.gmail.com>
Subject: Re: [PATCH net] bpf, skmsg: fix NULL pointer dereference in
 sk_psock_skb_ingress_enqueue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> Hello John,
> =

> On Thu, Apr 4, 2024 at 9:01=E2=80=AFAM John Fastabend <john.fastabend@g=
mail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() which=

> > > syzbot reported [1].
> > >
> > > [1]
> > > BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_enque=
ue
> > >
> > > write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu 1:
> > >  sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
> > >  sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
> > >  sk_psock_put include/linux/skmsg.h:459 [inline]
> > >  sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
> > >  unix_release+0x4b/0x80 net/unix/af_unix.c:1048
> > >  __sock_release net/socket.c:659 [inline]
> > >  sock_close+0x68/0x150 net/socket.c:1421
> > >  __fput+0x2c1/0x660 fs/file_table.c:422
> > >  __fput_sync+0x44/0x60 fs/file_table.c:507
> > >  __do_sys_close fs/open.c:1556 [inline]
> > >  __se_sys_close+0x101/0x1b0 fs/open.c:1541
> > >  __x64_sys_close+0x1f/0x30 fs/open.c:1541
> > >  do_syscall_64+0xd3/0x1d0
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu 0:
> > >  sk_psock_data_ready include/linux/skmsg.h:464 [inline]
> > >  sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:555
> > >  sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606
> > >  sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
> > >  sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
> > >  unix_read_skb net/unix/af_unix.c:2546 [inline]
> > >  unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
> > >  sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:1223
> > >  unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
> > >  sock_sendmsg_nosec net/socket.c:730 [inline]
> > >  __sock_sendmsg+0x140/0x180 net/socket.c:745
> > >  ____sys_sendmsg+0x312/0x410 net/socket.c:2584
> > >  ___sys_sendmsg net/socket.c:2638 [inline]
> > >  __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
> > >  __do_sys_sendmsg net/socket.c:2676 [inline]
> > >  __se_sys_sendmsg net/socket.c:2674 [inline]
> > >  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
> > >  do_syscall_64+0xd3/0x1d0
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > value changed: 0xffffffff83d7feb0 -> 0x0000000000000000
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W         =
 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 02/29/2024
> > >
> > > Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL pointer=

> > > dereference in sk_psock_verdict_data_ready()") fixed one NULL point=
er
> > > similarly due to no protection of saved_data_ready. Here is another=

> > > different caller causing the same issue because of the same reason.=
 So
> > > we should protect it with sk_callback_lock read lock because the wr=
iter
> > > side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callback_lo=
ck);".
> > >
> > > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg inter=
face")
> > > Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Daa8c8ec2538929f18=
f2d
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/core/skmsg.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > index 4d75ef9d24bf..67c4c01c5235 100644
> > > --- a/net/core/skmsg.c
> > > +++ b/net/core/skmsg.c
> > > @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(struct =
sk_buff *skb,
> > >       msg->skb =3D skb;
> > >
> > >       sk_psock_queue_msg(psock, msg);
> > > +     read_lock_bh(&sk->sk_callback_lock);
> > >       sk_psock_data_ready(sk, psock);
> > > +     read_unlock_bh(&sk->sk_callback_lock);
> > >       return copied;
> > >  }
> >
> > The problem is the check and then usage presumably it is already set
> > to NULL:
> >
> >  static inline void sk_psock_data_ready(struct sock *sk, struct sk_ps=
ock *psock)
> >  {
> >         if (psock->saved_data_ready)
> >                 psock->saved_data_ready(sk);
> =

> Yes.
> =

> >
> >
> > I'm thinking we might be able to get away with just a READ_ONCE here =
with
> > similar WRITE_ONCE on other side. Something like this,
> =

> The simple fix that popped into my mind at the beginning is the same
> as you: adding the READ_ONCE/WRITE_ONCE pair.

Let me know if you want to try doing a patch with the READ_ONCE/WRITE_ONC=
E
we could push something like that through bpf-next I think. Just needs
some extra thought and testing.=

