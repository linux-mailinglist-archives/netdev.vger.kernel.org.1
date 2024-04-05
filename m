Return-Path: <netdev+bounces-85279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6335289A066
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663D11C225D0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB76F16F295;
	Fri,  5 Apr 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfqQkk6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFD43170;
	Fri,  5 Apr 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329100; cv=none; b=BRGhQZLJGGKk528Q3DA5ZQlq5bCV7heM2F7RpdY5nwi3qawQIFS1Ylw5FAQYhDLzuCzK8Mz6/FJ3XxtpgD0+nM6DAQuQVKp+FCiS8tq/qkFz9bAvdVaT+5BeCIovDemhoIsIjkHlTFvg2SZbm5oqvgbKibh+PQNKG6dURZKU4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329100; c=relaxed/simple;
	bh=RbVMPQ9tcHwEBDXRH9GCy1RaLNkTY+CYq4GAsKEad/0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VBq/ImBW5tm7tDSqdNEPQKePKOivlFC8XMEVUzHzVhaiI0hNnhGyFTapC0COs5WI/Gz9F4jfYUVHNEgZ/TwXtJkiol+dMlY+5gbPB/r8pqXgphyyMrWktP74PJwD6XEgtoa29w8wLN6DfQRNQAVj0Sh+mIGf/qmYCKW6INNOcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfqQkk6n; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so1777361b3a.1;
        Fri, 05 Apr 2024 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329098; x=1712933898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmZiflZG1LSH8g3nYSM9hV+Boxznr4tkjKGtjgB7/i4=;
        b=LfqQkk6n6rrn8pPKOZNA2zv+ECoYOK98jF8pDrB638JqQDXjWPmtsdh+2MmDyJRxyD
         7lmfUJ6GfbnSLHroLk/SPtN5vtRB6ahQ5zPIMTS/xuYdVizCDf8ksYX5pA3/X6/apz1r
         y3yeNXweF0SHjpkLMFP1V6I1+VFzDmVsiMbwmZsjJqqSk1OsDWaV/Yp8Qhf1EjPbauF5
         ut72by/zG7HSXfjCnvEdj/tKeQcYZ+PAF9Vkjnb4wpoJvd4lj5dD6bav8/EhmY6HPN84
         GQWnn4dD1u7hJ1UGUV7pHxe3einHHl4SMq3lvwqXHnQLx9Tc3+zsrCVtHKBd6oVRAo/A
         Pc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329098; x=1712933898;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmZiflZG1LSH8g3nYSM9hV+Boxznr4tkjKGtjgB7/i4=;
        b=i3v1aMuHTZ2teDTw9uh3v2HdkD+nTTTNFvwT5Sdzwb+gV1sl0Q+q324i7qKj1LUXnn
         0fVH7zNYr7wVd2bcqxW2ciJ7+tT58eaLByjc5sn3aQpj3Gw/WOcQCz6J+zpDzO9TMRGP
         8l4WK8ulZHhnEe8ma+OzJ0S6SxMIBVu70bW5h54gv3LT9z3B0e0atnLKdXDYJFqFwE9c
         UUWP7kunTUxoZPOvvOlbAeuq6wmptk91vfxaVHxS921CsLaOFMHDDchBgbB2uj9vdvap
         1Lj1dt6D3kL68UGDKr9MF6LLHAU4zhF9knpRinO/IoUDty9NdFAN8o11b3GkrArOuIHN
         3XwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNlaiyim1Y/rARKvBT2dqGYSGsAR5TFFZev2CIa1fp0NrRIAD2XlLdPheEuOE95c8LL7n16p/ENlqhmCNDvNgwYKYqY+FTp5lMqFXCAiKhUFd8awsLNuhfvOB5
X-Gm-Message-State: AOJu0YyvTqbDVvI8R4Xt7/dSh7JOn0pzyeia7TCD7eFZCUtzOHb+k90k
	lQQUNM8muoAQHk5J4yM8eY6MCyhCn8d+mYrBs+UFEcyuOPB3PlG3/m5wDijU
X-Google-Smtp-Source: AGHT+IGHmifv+ScFWpw8Xiubhd8Yo/xjy7IhKrrZQNf/jLAZ0fB6JfTIgs28Xhl3ARl+P6rcZYQM3g==
X-Received: by 2002:aa7:88ca:0:b0:6ea:c4b3:10b7 with SMTP id k10-20020aa788ca000000b006eac4b310b7mr2101792pff.17.1712329098360;
        Fri, 05 Apr 2024 07:58:18 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id v16-20020aa799d0000000b006e567c81d14sm1594579pfi.43.2024.04.05.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:58:18 -0700 (PDT)
Date: Fri, 05 Apr 2024 07:58:17 -0700
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
Message-ID: <66101189315a5_58030208cf@john.notmuch>
In-Reply-To: <CAL+tcoCRswPAD0Zd=KCrJEmvPQVKCoMYr98Rx1wO_-bbUiVvJA@mail.gmail.com>
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
 <660dfbcb45cfc_23f4720810@john.notmuch>
 <CAL+tcoAE7AC3-jP3NYL1SXPHbC3KCRj_VOvd1=T2e0YTk8R5+g@mail.gmail.com>
 <660f81fc59256_50b87208e9@john.notmuch>
 <CAL+tcoCRswPAD0Zd=KCrJEmvPQVKCoMYr98Rx1wO_-bbUiVvJA@mail.gmail.com>
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
> On Fri, Apr 5, 2024 at 12:45=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Hello John,
> > >
> > > On Thu, Apr 4, 2024 at 9:01=E2=80=AFAM John Fastabend <john.fastabe=
nd@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() w=
hich
> > > > > syzbot reported [1].
> > > > >
> > > > > [1]
> > > > > BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_e=
nqueue
> > > > >
> > > > > write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu 1:
> > > > >  sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
> > > > >  sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
> > > > >  sk_psock_put include/linux/skmsg.h:459 [inline]
> > > > >  sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
> > > > >  unix_release+0x4b/0x80 net/unix/af_unix.c:1048
> > > > >  __sock_release net/socket.c:659 [inline]
> > > > >  sock_close+0x68/0x150 net/socket.c:1421
> > > > >  __fput+0x2c1/0x660 fs/file_table.c:422
> > > > >  __fput_sync+0x44/0x60 fs/file_table.c:507
> > > > >  __do_sys_close fs/open.c:1556 [inline]
> > > > >  __se_sys_close+0x101/0x1b0 fs/open.c:1541
> > > > >  __x64_sys_close+0x1f/0x30 fs/open.c:1541
> > > > >  do_syscall_64+0xd3/0x1d0
> > > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > > >
> > > > > read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu 0:
> > > > >  sk_psock_data_ready include/linux/skmsg.h:464 [inline]
> > > > >  sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:555
> > > > >  sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606
> > > > >  sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
> > > > >  sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
> > > > >  unix_read_skb net/unix/af_unix.c:2546 [inline]
> > > > >  unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
> > > > >  sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:1223
> > > > >  unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
> > > > >  sock_sendmsg_nosec net/socket.c:730 [inline]
> > > > >  __sock_sendmsg+0x140/0x180 net/socket.c:745
> > > > >  ____sys_sendmsg+0x312/0x410 net/socket.c:2584
> > > > >  ___sys_sendmsg net/socket.c:2638 [inline]
> > > > >  __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
> > > > >  __do_sys_sendmsg net/socket.c:2676 [inline]
> > > > >  __se_sys_sendmsg net/socket.c:2674 [inline]
> > > > >  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
> > > > >  do_syscall_64+0xd3/0x1d0
> > > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > > >
> > > > > value changed: 0xffffffff83d7feb0 -> 0x0000000000000000
> > > > >
> > > > > Reported by Kernel Concurrency Sanitizer on:
> > > > > CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W     =
     6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS Google 02/29/2024
> > > > >
> > > > > Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL poi=
nter
> > > > > dereference in sk_psock_verdict_data_ready()") fixed one NULL p=
ointer
> > > > > similarly due to no protection of saved_data_ready. Here is ano=
ther
> > > > > different caller causing the same issue because of the same rea=
son. So
> > > > > we should protect it with sk_callback_lock read lock because th=
e writer
> > > > > side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callbac=
k_lock);".
> > > > >
> > > > > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg i=
nterface")
> > > > > Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.=
com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3Daa8c8ec253892=
9f18f2d
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/core/skmsg.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > > > index 4d75ef9d24bf..67c4c01c5235 100644
> > > > > --- a/net/core/skmsg.c
> > > > > +++ b/net/core/skmsg.c
> > > > > @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(str=
uct sk_buff *skb,
> > > > >       msg->skb =3D skb;
> > > > >
> > > > >       sk_psock_queue_msg(psock, msg);
> > > > > +     read_lock_bh(&sk->sk_callback_lock);
> > > > >       sk_psock_data_ready(sk, psock);
> > > > > +     read_unlock_bh(&sk->sk_callback_lock);
> > > > >       return copied;
> > > > >  }
> > > >
> > > > The problem is the check and then usage presumably it is already =
set
> > > > to NULL:
> > > >
> > > >  static inline void sk_psock_data_ready(struct sock *sk, struct s=
k_psock *psock)
> > > >  {
> > > >         if (psock->saved_data_ready)
> > > >                 psock->saved_data_ready(sk);
> > >
> > > Yes.
> > >
> > > >
> > > >
> > > > I'm thinking we might be able to get away with just a READ_ONCE h=
ere with
> > > > similar WRITE_ONCE on other side. Something like this,
> > >
> > > The simple fix that popped into my mind at the beginning is the sam=
e
> > > as you: adding the READ_ONCE/WRITE_ONCE pair.
> >
> > Let me know if you want to try doing a patch with the READ_ONCE/WRITE=
_ONCE
> > we could push something like that through bpf-next I think. Just need=
s
> > some extra thought and testing.
> =

> Yes, I'm interested in it. Just a little bit worried that I cannot do
> it well. I will take some time to dig into it.
> =

> BTW, would this modification conflict with the current patch? The
> final solution you're thinking of is using the READ_ONCE/WRITE_ONCE
> pair?

Idea would be you can drop the read_lock/unlock once READ_ONCE/WRITE_ONCE=

and such are in place.

> =

> Thanks,
> Jason



