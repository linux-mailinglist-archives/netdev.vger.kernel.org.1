Return-Path: <netdev+bounces-85081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861AC8994A9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 07:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C45B28637B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 05:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C3A20DE8;
	Fri,  5 Apr 2024 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYUiljKu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BE28E2;
	Fri,  5 Apr 2024 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712293993; cv=none; b=lV2bYnusbVp0K7nshiDyJXBTVIPZCsE0fWQxUpuNrd+i6aiPtJGXCQAz3DS9rL+EqcVCFFTbFjZTCdp+m1pkNwxD55awOav1kDznPERP3TZO3ikt1MY6UO3onqEFM85SNPi8/IY1OpggwddELguVU9SwbFpAEamYLuDcY7v9abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712293993; c=relaxed/simple;
	bh=Yh5y/NOBPWAF8HU8gDDpGubvxNSJjp+VpV57uNMwDLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ao1kprULqo2VpmZDnlscwimlKHIEyVSh7740uXkZVa/GMSrn0iBzUk5vogKiv0eXSVwuje7jeJSSu2eZqun0EDJUwN4rBwXLow3Kv3KNgHTjLFtB6ow3QfGrPLCNOYYejOQ0mcVr1/E76T3NhbP3GxpvulgKp4fZ1MO4VrjXs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYUiljKu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44665605f3so198269466b.2;
        Thu, 04 Apr 2024 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712293990; x=1712898790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BUgYCUh1pAAv2v4S5nQUsZfz3aEo2GLtn2+TPhQ88w=;
        b=mYUiljKuG7fWxuZD7aJSVwKm/EMUBJdaifx0rXLXEMt1swVdCI7xaxvgZ3Vnlh23aa
         fu1jr7jDpxD3Y77NBGnBG6WB+JuuGXL2i88ls9TWOsvtbtYiCEVB+AHgUIu+v66ditsN
         urYk7XOj1sJxn+2idwMhm7fF/PRS1pgQ5HGCMkB0qTrWDPdTVhNpEtr9LNMKo/9ve3TV
         SaOLrftBt4cG9DC1kTGoYfQ74Q+0RcielTes4Q37hMFw42tFn1xpFXA3fW/Kh5K11UCX
         0SxpmA4AHH9qJe8dmy7lHVTFSB6lAXxLOuKI9bxBAEYgljBANPvAcH7sbgiImth38QzB
         ul7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712293990; x=1712898790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BUgYCUh1pAAv2v4S5nQUsZfz3aEo2GLtn2+TPhQ88w=;
        b=IqU+LhSe9PBcwGxxmH6qpKCTZFUvBAJcjEv8u4nTI78LBgmsPk3ZrUFBqP+yUgRIWc
         BHFS4yYJ+QyPii6qfTi/JcuMDMek8c+ObgSkoida31WOaMVqPmt+e1DsIFsJxfHhVLKR
         YEL1DqVMxVxwF5gfhlJQrgRZjEEcS4ajxk0u/ovzBX5lYcDTfRncaDmWnfS1OiveX1Ed
         glyRD7HwgZXC974qVzo0SUsfJJs3sdMseZoSZ9i63IpT2vQl3v2ISSDPMiNLO3NX9Lyy
         AUNeQv3/qAZ0HdGJyFe/5eztXV0019Mb4UlCNp1QJxXsUXcKVx22sMsgdMCAkgTv3zJw
         fbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw/bMnwJwJYgoY24FKDbKZrbMV6TOXaBBMYAFuwfWn1r/HYvh7X/1nURTC2m4N05mTv41DPZoSJoVawn3DC2aLeqTeDjBuvP45cMptSCxEmNxZAAR9KoA7p1k/
X-Gm-Message-State: AOJu0YxBKn6TLeWnI1DxSB3GYDfl5SmFgK8efCsR98n18A/XOInE3PSv
	R5IQ+xmpgbfTZCUXIJfiOeAekb0BNQhRQR4ecB1u30aF6OQFV/NCUNJg+WkTrDNQ0diLn25T/JG
	9vSQb8ZbmUusLwy9UDhhL5rad6HM=
X-Google-Smtp-Source: AGHT+IFFxhZJYWFXNUBgJiSi4afj1iYI8p8bxSLG9lI6B38ByT36kYZB54vSpAkmMIkUcjsxPBwfVz+lCoFPKjjefL8=
X-Received: by 2002:a17:907:6d0b:b0:a51:99ea:a9cc with SMTP id
 sa11-20020a1709076d0b00b00a5199eaa9ccmr242075ejc.54.1712293989908; Thu, 04
 Apr 2024 22:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
 <660dfbcb45cfc_23f4720810@john.notmuch> <CAL+tcoAE7AC3-jP3NYL1SXPHbC3KCRj_VOvd1=T2e0YTk8R5+g@mail.gmail.com>
 <660f81fc59256_50b87208e9@john.notmuch>
In-Reply-To: <660f81fc59256_50b87208e9@john.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 13:12:33 +0800
Message-ID: <CAL+tcoCRswPAD0Zd=KCrJEmvPQVKCoMYr98Rx1wO_-bbUiVvJA@mail.gmail.com>
Subject: Re: [PATCH net] bpf, skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
To: John Fastabend <john.fastabend@gmail.com>
Cc: edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net, ast@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:45=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Jason Xing wrote:
> > Hello John,
> >
> > On Thu, Apr 4, 2024 at 9:01=E2=80=AFAM John Fastabend <john.fastabend@g=
mail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() which
> > > > syzbot reported [1].
> > > >
> > > > [1]
> > > > BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_enque=
ue
> > > >
> > > > write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu 1:
> > > >  sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
> > > >  sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
> > > >  sk_psock_put include/linux/skmsg.h:459 [inline]
> > > >  sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
> > > >  unix_release+0x4b/0x80 net/unix/af_unix.c:1048
> > > >  __sock_release net/socket.c:659 [inline]
> > > >  sock_close+0x68/0x150 net/socket.c:1421
> > > >  __fput+0x2c1/0x660 fs/file_table.c:422
> > > >  __fput_sync+0x44/0x60 fs/file_table.c:507
> > > >  __do_sys_close fs/open.c:1556 [inline]
> > > >  __se_sys_close+0x101/0x1b0 fs/open.c:1541
> > > >  __x64_sys_close+0x1f/0x30 fs/open.c:1541
> > > >  do_syscall_64+0xd3/0x1d0
> > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > >
> > > > read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu 0:
> > > >  sk_psock_data_ready include/linux/skmsg.h:464 [inline]
> > > >  sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:555
> > > >  sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606
> > > >  sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
> > > >  sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
> > > >  unix_read_skb net/unix/af_unix.c:2546 [inline]
> > > >  unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
> > > >  sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:1223
> > > >  unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
> > > >  sock_sendmsg_nosec net/socket.c:730 [inline]
> > > >  __sock_sendmsg+0x140/0x180 net/socket.c:745
> > > >  ____sys_sendmsg+0x312/0x410 net/socket.c:2584
> > > >  ___sys_sendmsg net/socket.c:2638 [inline]
> > > >  __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
> > > >  __do_sys_sendmsg net/socket.c:2676 [inline]
> > > >  __se_sys_sendmsg net/socket.c:2674 [inline]
> > > >  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
> > > >  do_syscall_64+0xd3/0x1d0
> > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > >
> > > > value changed: 0xffffffff83d7feb0 -> 0x0000000000000000
> > > >
> > > > Reported by Kernel Concurrency Sanitizer on:
> > > > CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W         =
 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 02/29/2024
> > > >
> > > > Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL pointer
> > > > dereference in sk_psock_verdict_data_ready()") fixed one NULL point=
er
> > > > similarly due to no protection of saved_data_ready. Here is another
> > > > different caller causing the same issue because of the same reason.=
 So
> > > > we should protect it with sk_callback_lock read lock because the wr=
iter
> > > > side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callback_lo=
ck);".
> > > >
> > > > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg inter=
face")
> > > > Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3Daa8c8ec2538929f18=
f2d
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/core/skmsg.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > > index 4d75ef9d24bf..67c4c01c5235 100644
> > > > --- a/net/core/skmsg.c
> > > > +++ b/net/core/skmsg.c
> > > > @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(struct =
sk_buff *skb,
> > > >       msg->skb =3D skb;
> > > >
> > > >       sk_psock_queue_msg(psock, msg);
> > > > +     read_lock_bh(&sk->sk_callback_lock);
> > > >       sk_psock_data_ready(sk, psock);
> > > > +     read_unlock_bh(&sk->sk_callback_lock);
> > > >       return copied;
> > > >  }
> > >
> > > The problem is the check and then usage presumably it is already set
> > > to NULL:
> > >
> > >  static inline void sk_psock_data_ready(struct sock *sk, struct sk_ps=
ock *psock)
> > >  {
> > >         if (psock->saved_data_ready)
> > >                 psock->saved_data_ready(sk);
> >
> > Yes.
> >
> > >
> > >
> > > I'm thinking we might be able to get away with just a READ_ONCE here =
with
> > > similar WRITE_ONCE on other side. Something like this,
> >
> > The simple fix that popped into my mind at the beginning is the same
> > as you: adding the READ_ONCE/WRITE_ONCE pair.
>
> Let me know if you want to try doing a patch with the READ_ONCE/WRITE_ONC=
E
> we could push something like that through bpf-next I think. Just needs
> some extra thought and testing.

Yes, I'm interested in it. Just a little bit worried that I cannot do
it well. I will take some time to dig into it.

BTW, would this modification conflict with the current patch? The
final solution you're thinking of is using the READ_ONCE/WRITE_ONCE
pair?

Thanks,
Jason

