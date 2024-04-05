Return-Path: <netdev+bounces-85281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1D89A06E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5828483D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482916F82D;
	Fri,  5 Apr 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn0lbDHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C516EBF3;
	Fri,  5 Apr 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329296; cv=none; b=vAsrGVFP38XMY7TIMFNqMFBh6LKedujuK1lvDwc5V3o9CC/bYqM8XPyn5wo2yeAp1wSbQkVtFSKtEl5yLnc0fQVV7LqrT4E2ovNRV1r70CFWm9v7+azxBd2B35L2ZyCCh1TTRW/XvsHe6j1diAZTLfocL/6DE9l3MDeXT0cI+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329296; c=relaxed/simple;
	bh=WQdPHhfEH6W07dzWZxpDsszRcvfbWBdBzLLBz+25lF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjT+F0iDrf/vZ7D2SnEAfTwXJsJ5P9R64Emjtth9VFmDHY+h7wEdV2DZiPhAer9rmFrIhXwuZHdUhyiWhXGJRz4XpnAn0bqWJhUQ7nK4tYisbf5VDYjVdTK0uulKCz9o27JTScc1Kl8fiqttHW6rS2bvjoWSwvK88jAOhgIMPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn0lbDHG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51588f70d2dso2896493e87.3;
        Fri, 05 Apr 2024 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329293; x=1712934093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kuRdzJQjL+sr62OsDY06K25Zcg0GpIkD0uDLnLTaQw=;
        b=Wn0lbDHGCdlTTMQfF+9OkMfRo66lZIQ703kdL36KZUrURyZNtEZNaq8y4syxfXy3R1
         E+PBZ3p0dYmPONDtaPq/x74lu9kPz+9Vu1ggBAkS7Tq/RfLEaNFi/vKqHX027AoFJdjw
         srv3OjWuKlg+Z8XcTT30vVKAxOxv7L9Kw5xxaNYLW0mODwnC77OV57iWWMsu7emY5RsB
         rcT+FFfWiVFDVtOrFEEzgv84pWYsV7OLqpEOiKxBX0VihAB5Ww6CQ0NNkWZgOVMv7G1Z
         u8YBTPitzMkA0OcMMt/ajSZKbGyz+sWkrqQ1rP+pPwk0R+8j4rAYv/zxPLt1gV6lTl11
         9dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329293; x=1712934093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kuRdzJQjL+sr62OsDY06K25Zcg0GpIkD0uDLnLTaQw=;
        b=SSz3TJihXo8ABEeQel1OeZbLmcTf21c5eVpbvwHGInMYNCy9aPl5fLvtOGVVaqO9QS
         GVLueqRPAOBhEMxcUOX2+sQcWO2SF54qR16Cj0OqpprUYhiiJUaSfG+xJVbe2FkCNYtO
         60W/MpOMcM2xlfWxqRKN5+Uy3vZPPCRZc4MuT2r/2g7j1rhgNI7VY8o2U/SBz6nsWfG3
         MlZAmdtZ+LjVac+3KJAy0Ov7gMsC3Nnpmh5oA2MbQZ1CVo6FB1XdFpENxAfJq0kzIwSY
         FgCQ3317uROhwx4sCvhjZbZ63IzZqbvdAUvccm9xngQBc5rsKojEmFArdI60qaQKJw2z
         XqXg==
X-Forwarded-Encrypted: i=1; AJvYcCVg9bOWuTDQ5kT+cxC+LbJy24Jf9xb6OTEg94XCfeYf3W9LZfjfQSEMMa9u6ChFIrX5eS/AK0njXazPFoEO4W5aryw5FcRPtft6laXBjpWSLJPM8A8NoGiom4wy
X-Gm-Message-State: AOJu0Yx+xymCgThiUkb+tynsnktGC6UKXWfRj8qqa1bUFlE6vMGJhnUU
	VhitTK4pImfRKNQ94AAdhm5V/B4D5cYtShmOJy86LOPpQDVcv1uNpVe3GKH2BJJLxCZQbRK0GXT
	Y23gHDOFQaiPnnAF//JUh7NqKii8=
X-Google-Smtp-Source: AGHT+IHYt7wrw1EnvLtjYRGLMwNkvyKKIs8TDJmyWxXsCkpQuW7le9cqhwd3BN+zj0/b1LbU6Zeo/djpfZpRmY/USfc=
X-Received: by 2002:a05:6512:3d09:b0:515:d24e:4e2e with SMTP id
 d9-20020a0565123d0900b00515d24e4e2emr1507636lfv.20.1712329292068; Fri, 05 Apr
 2024 08:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
 <660dfbcb45cfc_23f4720810@john.notmuch> <CAL+tcoAE7AC3-jP3NYL1SXPHbC3KCRj_VOvd1=T2e0YTk8R5+g@mail.gmail.com>
 <660f81fc59256_50b87208e9@john.notmuch> <CAL+tcoCRswPAD0Zd=KCrJEmvPQVKCoMYr98Rx1wO_-bbUiVvJA@mail.gmail.com>
 <66101189315a5_58030208cf@john.notmuch>
In-Reply-To: <66101189315a5_58030208cf@john.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 23:00:55 +0800
Message-ID: <CAL+tcoAjX_WMquGG=-jqFG8B14fHcjg-0HL6PNrbad9mP2Z8Zw@mail.gmail.com>
Subject: Re: [PATCH net] bpf, skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
To: John Fastabend <john.fastabend@gmail.com>
Cc: edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net, ast@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:58=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Jason Xing wrote:
> > On Fri, Apr 5, 2024 at 12:45=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > Hello John,
> > > >
> > > > On Thu, Apr 4, 2024 at 9:01=E2=80=AFAM John Fastabend <john.fastabe=
nd@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() w=
hich
> > > > > > syzbot reported [1].
> > > > > >
> > > > > > [1]
> > > > > > BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_e=
nqueue
> > > > > >
> > > > > > write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu 1:
> > > > > >  sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
> > > > > >  sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
> > > > > >  sk_psock_put include/linux/skmsg.h:459 [inline]
> > > > > >  sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
> > > > > >  unix_release+0x4b/0x80 net/unix/af_unix.c:1048
> > > > > >  __sock_release net/socket.c:659 [inline]
> > > > > >  sock_close+0x68/0x150 net/socket.c:1421
> > > > > >  __fput+0x2c1/0x660 fs/file_table.c:422
> > > > > >  __fput_sync+0x44/0x60 fs/file_table.c:507
> > > > > >  __do_sys_close fs/open.c:1556 [inline]
> > > > > >  __se_sys_close+0x101/0x1b0 fs/open.c:1541
> > > > > >  __x64_sys_close+0x1f/0x30 fs/open.c:1541
> > > > > >  do_syscall_64+0xd3/0x1d0
> > > > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > > > >
> > > > > > read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu 0:
> > > > > >  sk_psock_data_ready include/linux/skmsg.h:464 [inline]
> > > > > >  sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:555
> > > > > >  sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606
> > > > > >  sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
> > > > > >  sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
> > > > > >  unix_read_skb net/unix/af_unix.c:2546 [inline]
> > > > > >  unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
> > > > > >  sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:1223
> > > > > >  unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
> > > > > >  sock_sendmsg_nosec net/socket.c:730 [inline]
> > > > > >  __sock_sendmsg+0x140/0x180 net/socket.c:745
> > > > > >  ____sys_sendmsg+0x312/0x410 net/socket.c:2584
> > > > > >  ___sys_sendmsg net/socket.c:2638 [inline]
> > > > > >  __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
> > > > > >  __do_sys_sendmsg net/socket.c:2676 [inline]
> > > > > >  __se_sys_sendmsg net/socket.c:2674 [inline]
> > > > > >  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
> > > > > >  do_syscall_64+0xd3/0x1d0
> > > > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > > > >
> > > > > > value changed: 0xffffffff83d7feb0 -> 0x0000000000000000
> > > > > >
> > > > > > Reported by Kernel Concurrency Sanitizer on:
> > > > > > CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W     =
     6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS Google 02/29/2024
> > > > > >
> > > > > > Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL poi=
nter
> > > > > > dereference in sk_psock_verdict_data_ready()") fixed one NULL p=
ointer
> > > > > > similarly due to no protection of saved_data_ready. Here is ano=
ther
> > > > > > different caller causing the same issue because of the same rea=
son. So
> > > > > > we should protect it with sk_callback_lock read lock because th=
e writer
> > > > > > side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callbac=
k_lock);".
> > > > > >
> > > > > > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg i=
nterface")
> > > > > > Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.=
com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3Daa8c8ec253892=
9f18f2d
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  net/core/skmsg.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > > > > index 4d75ef9d24bf..67c4c01c5235 100644
> > > > > > --- a/net/core/skmsg.c
> > > > > > +++ b/net/core/skmsg.c
> > > > > > @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(str=
uct sk_buff *skb,
> > > > > >       msg->skb =3D skb;
> > > > > >
> > > > > >       sk_psock_queue_msg(psock, msg);
> > > > > > +     read_lock_bh(&sk->sk_callback_lock);
> > > > > >       sk_psock_data_ready(sk, psock);
> > > > > > +     read_unlock_bh(&sk->sk_callback_lock);
> > > > > >       return copied;
> > > > > >  }
> > > > >
> > > > > The problem is the check and then usage presumably it is already =
set
> > > > > to NULL:
> > > > >
> > > > >  static inline void sk_psock_data_ready(struct sock *sk, struct s=
k_psock *psock)
> > > > >  {
> > > > >         if (psock->saved_data_ready)
> > > > >                 psock->saved_data_ready(sk);
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > >
> > > > > I'm thinking we might be able to get away with just a READ_ONCE h=
ere with
> > > > > similar WRITE_ONCE on other side. Something like this,
> > > >
> > > > The simple fix that popped into my mind at the beginning is the sam=
e
> > > > as you: adding the READ_ONCE/WRITE_ONCE pair.
> > >
> > > Let me know if you want to try doing a patch with the READ_ONCE/WRITE=
_ONCE
> > > we could push something like that through bpf-next I think. Just need=
s
> > > some extra thought and testing.
> >
> > Yes, I'm interested in it. Just a little bit worried that I cannot do
> > it well. I will take some time to dig into it.
> >
> > BTW, would this modification conflict with the current patch? The
> > final solution you're thinking of is using the READ_ONCE/WRITE_ONCE
> > pair?
>
> Idea would be you can drop the read_lock/unlock once READ_ONCE/WRITE_ONCE
> and such are in place.

Got it. Allow me to work on it. Lockless protection is surely better
than rw lock. But can we let the current patch go into the tree first?

Thanks,
Jason
>
> >
> > Thanks,
> > Jason
>
>

