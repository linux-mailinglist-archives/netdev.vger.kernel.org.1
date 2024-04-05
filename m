Return-Path: <netdev+bounces-85289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C789A110
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1290CB25B4B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3316F900;
	Fri,  5 Apr 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiYu8iOu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9B16F8F7;
	Fri,  5 Apr 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330909; cv=none; b=ZcQA2vlM8LaUqrc+vFo47ewWbtFBdeICihNqMnKt2uoPjT81lkUgy6S3jD74Bq6TWJrqDLm0GhYHHxZRtCvrKeAl5twMLwY7HtXlv5P3NXPzkvpPIF7NLjQ31ISs/Iauds5pjt0dpHUKwd+Ktjl1U1z/7Ivi9eyswTQdsiiphFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330909; c=relaxed/simple;
	bh=/HsEo8VyRQEXWRKNaNCAo2AE+0DJD1aVpvTfv3EdaV8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eEh3nPkuU8NvxHOYQepRL9XtkUw4fnc17JrPnLOCLkyo5Ar4qwmISvxeMDh2DFJumrqzmtJmuhce9CodX133m5K1I6jQ6VhUbYJYLu4bTB+040xyBee9Z18XFUePWQCVQTpjuUncBa1GkowZ6T2z9eMP3HyuNXVEyJgxqOCitjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiYu8iOu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2987e9d06so19636445ad.2;
        Fri, 05 Apr 2024 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330907; x=1712935707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEqvPtS64Tr1SkoQGm1HY5+hYdDDs+ljKCuZlmB4V8s=;
        b=CiYu8iOuR+LROCml0ev4iVBgI1feXtfUtFfjcDCLREa4HpyL7d2jM8kI5Xjup+0OYx
         YAqbqAVuCydFpBrrOImuV3UNUCU4vyMRoYhLkBJLI25toWdJUjfhm7yacHYy9SBbKdxU
         UbAPqOMRKyKzpZPq57ci9WQRY2ob5bDEY7P0rVe0GqHkoUr/T7/oLC4ZaqGVKxzrgSI3
         SmgUogcsEFKuh1CU2qypX8CxiHkNJ/PjUsjnfzDooNGMlVXRjUpY4lnXze+xS7iw+wJx
         AqxgLpkJaIgJMhgWRkHYVkPtVIumP4nloNyiYtpzsPVOgml8u+kBdBD66GDQdWZoei2q
         B0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330907; x=1712935707;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fEqvPtS64Tr1SkoQGm1HY5+hYdDDs+ljKCuZlmB4V8s=;
        b=ePQNk6NBtaDNMwSR/5LGGOrM0cqG8eFmLYXz6og4Z9MJQdePFfBC4vdruHSiNUIuDx
         WynFc/l57vC6TgbntgdW7ftEj0yPXjv5B2cBulSyjC34IYjUvPlKY44NeJRIzjnWvMG+
         XB1OWg3hpIacmZWgVgLFHyzJGyFL9TUadRwVWo5ovH//N01aLZnue5ID1Ea4I3kg2Rv6
         fkaNIb3AJaVGpGXCFjLh795myOzE+QZ9Gwe1V2jMdE902tWBLgYDQyOFDo+LypyN+RFQ
         x0Pi1d3GzHnuxQAGG94Zu67JMut8lWo1aE6sdqD74GOL4Ronq5I/hmuQPUQ5JFtLNVt6
         jEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD603nqPTgsQpFpyad2xSM/gpF7msWI+z/c0gMclDiOVcDZR6fpkAuXzu/F+g70Q9yZnqTkknW6hbzUAtfn26tL49AqMEHseUi/rxSUG2XkD4Une+qqWM+0DjW
X-Gm-Message-State: AOJu0YxmDQGfNXw8SS/O8t+FT8J4+sUGO+CyIYS2acO2lpUUpPGCTqJW
	dScZPKwCk/bX0LOikU8xSYt4hA9yBiQrqVUDDxbGcrW2Xs9cGjjm
X-Google-Smtp-Source: AGHT+IGdGa9z2jNCJkGNAGb9/wOsxGQ8/CIwLspBlK4XeiBB7lKjWXIixAl1d5sPmbOGzJ6RcwIUhQ==
X-Received: by 2002:a17:902:f151:b0:1df:fd30:8b2d with SMTP id d17-20020a170902f15100b001dffd308b2dmr1218091plb.50.1712330906744;
        Fri, 05 Apr 2024 08:28:26 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001dcfaf4db22sm1702291plh.2.2024.04.05.08.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:28:26 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:28:25 -0700
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
Message-ID: <661018991cb4e_589b0208e9@john.notmuch>
In-Reply-To: <CAL+tcoAjX_WMquGG=-jqFG8B14fHcjg-0HL6PNrbad9mP2Z8Zw@mail.gmail.com>
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
 <660dfbcb45cfc_23f4720810@john.notmuch>
 <CAL+tcoAE7AC3-jP3NYL1SXPHbC3KCRj_VOvd1=T2e0YTk8R5+g@mail.gmail.com>
 <660f81fc59256_50b87208e9@john.notmuch>
 <CAL+tcoCRswPAD0Zd=KCrJEmvPQVKCoMYr98Rx1wO_-bbUiVvJA@mail.gmail.com>
 <66101189315a5_58030208cf@john.notmuch>
 <CAL+tcoAjX_WMquGG=-jqFG8B14fHcjg-0HL6PNrbad9mP2Z8Zw@mail.gmail.com>
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
> On Fri, Apr 5, 2024 at 10:58=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Fri, Apr 5, 2024 at 12:45=E2=80=AFPM John Fastabend <john.fastab=
end@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > Hello John,
> > > > >
> > > > > On Thu, Apr 4, 2024 at 9:01=E2=80=AFAM John Fastabend <john.fas=
tabend@gmail.com> wrote:
> > > > > >
> > > > > > Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue=
() which
> > > > > > > syzbot reported [1].
> > > > > > >
> > > > > > > [1]
> > > > > > > BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingre=
ss_enqueue
> > > > > > >
> > > > > > > write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu=
 1:
> > > > > > >  sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
> > > > > > >  sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
> > > > > > >  sk_psock_put include/linux/skmsg.h:459 [inline]
> > > > > > >  sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
> > > > > > >  unix_release+0x4b/0x80 net/unix/af_unix.c:1048
> > > > > > >  __sock_release net/socket.c:659 [inline]
> > > > > > >  sock_close+0x68/0x150 net/socket.c:1421
> > > > > > >  __fput+0x2c1/0x660 fs/file_table.c:422
> > > > > > >  __fput_sync+0x44/0x60 fs/file_table.c:507
> > > > > > >  __do_sys_close fs/open.c:1556 [inline]
> > > > > > >  __se_sys_close+0x101/0x1b0 fs/open.c:1541
> > > > > > >  __x64_sys_close+0x1f/0x30 fs/open.c:1541
> > > > > > >  do_syscall_64+0xd3/0x1d0
> > > > > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > > > > >
> > > > > > > read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu =
0:
> > > > > > >  sk_psock_data_ready include/linux/skmsg.h:464 [inline]
> > > > > > >  sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:=
555
> > > > > > >  sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606=

> > > > > > >  sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
> > > > > > >  sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
> > > > > > >  unix_read_skb net/unix/af_unix.c:2546 [inline]
> > > > > > >  unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
> > > > > > >  sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:12=
23
> > > > > > >  unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
> > > > > > >  sock_sendmsg_nosec net/socket.c:730 [inline]
> > > > > > >  __sock_sendmsg+0x140/0x180 net/socket.c:745
> > > > > > >  ____sys_sendmsg+0x312/0x410 net/socket.c:2584
> > > > > > >  ___sys_sendmsg net/socket.c:2638 [inline]
> > > > > > >  __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
> > > > > > >  __do_sys_sendmsg net/socket.c:2676 [inline]
> > > > > > >  __se_sys_sendmsg net/socket.c:2674 [inline]
> > > > > > >  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
> > > > > > >  do_syscall_64+0xd3/0x1d0
> > > > > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > > > > >
> > > > > > > value changed: 0xffffffff83d7feb0 -> 0x0000000000000000
> > > > > > >
> > > > > > > Reported by Kernel Concurrency Sanitizer on:
> > > > > > > CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W =
         6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute =
Engine, BIOS Google 02/29/2024
> > > > > > >
> > > > > > > Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL=
 pointer
> > > > > > > dereference in sk_psock_verdict_data_ready()") fixed one NU=
LL pointer
> > > > > > > similarly due to no protection of saved_data_ready. Here is=
 another
> > > > > > > different caller causing the same issue because of the same=
 reason. So
> > > > > > > we should protect it with sk_callback_lock read lock becaus=
e the writer
> > > > > > > side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_cal=
lback_lock);".
> > > > > > >
> > > > > > > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_m=
sg interface")
> > > > > > > Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotm=
ail.com
> > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3Daa8c8ec25=
38929f18f2d
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > >  net/core/skmsg.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > > > > > index 4d75ef9d24bf..67c4c01c5235 100644
> > > > > > > --- a/net/core/skmsg.c
> > > > > > > +++ b/net/core/skmsg.c
> > > > > > > @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue=
(struct sk_buff *skb,
> > > > > > >       msg->skb =3D skb;
> > > > > > >
> > > > > > >       sk_psock_queue_msg(psock, msg);
> > > > > > > +     read_lock_bh(&sk->sk_callback_lock);
> > > > > > >       sk_psock_data_ready(sk, psock);
> > > > > > > +     read_unlock_bh(&sk->sk_callback_lock);
> > > > > > >       return copied;
> > > > > > >  }
> > > > > >
> > > > > > The problem is the check and then usage presumably it is alre=
ady set
> > > > > > to NULL:
> > > > > >
> > > > > >  static inline void sk_psock_data_ready(struct sock *sk, stru=
ct sk_psock *psock)
> > > > > >  {
> > > > > >         if (psock->saved_data_ready)
> > > > > >                 psock->saved_data_ready(sk);
> > > > >
> > > > > Yes.
> > > > >
> > > > > >
> > > > > >
> > > > > > I'm thinking we might be able to get away with just a READ_ON=
CE here with
> > > > > > similar WRITE_ONCE on other side. Something like this,
> > > > >
> > > > > The simple fix that popped into my mind at the beginning is the=
 same
> > > > > as you: adding the READ_ONCE/WRITE_ONCE pair.
> > > >
> > > > Let me know if you want to try doing a patch with the READ_ONCE/W=
RITE_ONCE
> > > > we could push something like that through bpf-next I think. Just =
needs
> > > > some extra thought and testing.
> > >
> > > Yes, I'm interested in it. Just a little bit worried that I cannot =
do
> > > it well. I will take some time to dig into it.
> > >
> > > BTW, would this modification conflict with the current patch? The
> > > final solution you're thinking of is using the READ_ONCE/WRITE_ONCE=

> > > pair?
> >
> > Idea would be you can drop the read_lock/unlock once READ_ONCE/WRITE_=
ONCE
> > and such are in place.
> =

> Got it. Allow me to work on it. Lockless protection is surely better
> than rw lock. But can we let the current patch go into the tree first?

Yes v2 fix has my Reviewed-by and should go in as a fix. The above
improvement can go through bpf-next when its ready.=

