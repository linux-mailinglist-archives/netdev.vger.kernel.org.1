Return-Path: <netdev+bounces-178481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF175A771D4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DAF3A4206
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CF2E3384;
	Tue,  1 Apr 2025 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsS7lEgW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916A2E336E
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466966; cv=none; b=D9NxGRXiY0RYBgZbD9t7XKUdC5JZ1MwBfWRU5subI88AzIuQob3sQ4QQPHham1h07RSC5Euj4Az8k8DzZjJXnDeuqLlJRkgDkSH3/V0TxU5qL7o+y8CRnd0eleG+Wk6RUblBGvbtAeXMm9DMYEt5wOo7vTzKv2DAeXAwmky5QqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466966; c=relaxed/simple;
	bh=4XfgwtpOwwF88p447a7i5E0lGitT+KIaoI/+mHL85IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCf3sNen/sdLddVMxEezSavreNtqpOOR/ZGQmcYvXP1MbH5b4L4XWA8ZAS1FvF65BqawTtvgXoVR/ZHz5j8JeFjiwev/oT56wZ6xkvN3gW9/TMqZq/eeDOcTd+wvSyrcwLfND5ffsKpGOHlyhHQulXV85HBzLE8TNM8aROiueeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsS7lEgW; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso46514315ab.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743466964; x=1744071764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfd/LWZmW1cdJq0JxxDmbV4zkHqAWFSFwhGfNaz/now=;
        b=YsS7lEgWI/OaLe1vxdp79X65l2quBTSR78KIv4LlWD4or0fsgsIJjvNKX1WjyH5ecU
         LZkEuIbTuHcuDFAZIebAcRJDk2N/wVQA0mD2gT4NpprqfEM25nQoM8x+L/vusM2Q20sF
         vathzlrWMmvXkwizpuO0h9i9DrZMenzzBqzuQAl1Rsv7vrLERk/x1ZZ4fx3n0R4+3BDl
         eVLbnJJ8rON1Ty7AKkzOPCJKowRbftsxq0FG2yy2pTKSeLwb6C9vQOdlbtBwpBTh+q2W
         9+fu1PdP+GnpVz8Ddh4eU11u8Rgd7skmeC/m7VvJCPhWQj+g5DDW2KEmLWbw+ojqnpNl
         QfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743466964; x=1744071764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfd/LWZmW1cdJq0JxxDmbV4zkHqAWFSFwhGfNaz/now=;
        b=vCpa3BcZR8yNNO89cv4gO0g8c+xy1KPV+r7ivA2zOSjBXfOhL1putcra7lXycuWNC8
         aQS6CkHXrU/j9NFJ8MBihHziQPu127EpcSoyGzOoPlaLldYyOMrhdbnsz1hmSGj2QHIq
         eMI0woMtww0yExAlrU5HVEVUMHsptmsIL5jVDeZDU9iv6WZB/LcVT9i3hMjBH2PSLnSo
         VJjLLbgqjEAmaiDoHFNMuiUfbwoPDgb4B47K/7Pa9QdOsPItEYB/uDXYs1aTynHs3ia9
         U4/B9Cs2lZ45HtoQS6X1lawYdMqYbZ9ULnxj4EZ2EcLIlwZrWfZ28Uib6tr3/VNJkctV
         v4jg==
X-Forwarded-Encrypted: i=1; AJvYcCURhqTDyqAHpzJ4iE3XcORieJMi9BV2tV/9Yn5u7XFIFjSWng2ajF+wOGMATySBXksFrWWFwpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhq149V7u+dswk93U/RXUx6YwlS3D2EQziEAoNB/ib99cvaTf
	ga5RY4INNNPhkeQuCsEPRsqAlxFAIhscuNK6ilu6s/rasG6OHdJh7u0kecaYNSmlSoSRwAPaXGX
	gZls1/GnyMpQKe8AdTDeDxa9C7UQ=
X-Gm-Gg: ASbGncvnybAK8yJjGy9SFml34bB6F2K+rAUxU5Sx/5wZfDDIjrCv+IGqZs4Ly+oLMY3
	IWx8W6uaeYObz/RvztemA6J4dy68SMYJ8Bto8L6iMVIKvaGA6Rl37F00vCuRc8xphL3EWNf37Bv
	YK80gp+xOFjEZVmtv7OxG3F5/m+KksNBAa9U+c4SIVYLdu+8C4li6k6LbYlHK7
X-Google-Smtp-Source: AGHT+IGnbuHfnaVrZiMQiitGXOPK6ZRnp84dcvly5lrPIVZ8qPqalBKYSNL47cZnl9PgefiajtHfFR9ftKV6Vg0q5wg=
X-Received: by 2002:a05:6e02:152e:b0:3d4:3c21:ba71 with SMTP id
 e9e14a558f8ab-3d5e09f7bbdmr141196815ab.18.1743466963550; Mon, 31 Mar 2025
 17:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331091532.224982-1-edumazet@google.com> <CADvbK_eneePox-VFbicSmt55g+VJdc+5m_LoS2bu_Pezatjq0g@mail.gmail.com>
 <CANn89i+xpmBDQBPPG_QDfACHL=8h5=1bKqJjvD+e4=SHU7t76A@mail.gmail.com> <20250331195038.7aafa82a@pumpkin>
In-Reply-To: <20250331195038.7aafa82a@pumpkin>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 31 Mar 2025 20:22:32 -0400
X-Gm-Features: AQ5f1JrmCp9CSTdSTAD3gk2_wDWZWqvN6R-AM0IlczsJhzIdv2baAGUs9VaB7vM
Message-ID: <CADvbK_f1CauY6Oo1A0VeCDNdUL4T0ZA++K3g_1B_xJu=gD_a4w@mail.gmail.com>
Subject: Re: [PATCH net] sctp: add mutual exclusion in proc_sctp_do_udp_port()
To: David Laight <david.laight.linux@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 2:50=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 31 Mar 2025 18:11:38 +0200
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Mon, Mar 31, 2025 at 5:54=E2=80=AFPM Xin Long <lucien.xin@gmail.com>=
 wrote:
> > >
> > > On Mon, Mar 31, 2025 at 5:15=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_s=
tart()
> > > > or risk a crash as syzbot reported:
> > > >
> > > > Oops: general protection fault, probably for non-canonical address =
0xdffffc000000000d: 0000 [#1] SMP KASAN PTI
> > > > KASAN: null-ptr-deref in range [0x0000000000000068-0x00000000000000=
6f]
> > > > CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller=
-g7f2ff7b62617 #0 PREEMPT(full)
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 02/12/2025
> > > >  RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
> > > > Call Trace:
> > > >  <TASK>
> > > >   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
> > > >   sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
> > > >   proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
> > > >   proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
> > > >   iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
> > > >   do_splice_from fs/splice.c:935 [inline]
> > > >   direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
> > > >   splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
> > > >   do_splice_direct_actor fs/splice.c:1201 [inline]
> > > >   do_splice_direct+0x174/0x240 fs/splice.c:1227
> > > >   do_sendfile+0xafd/0xe50 fs/read_write.c:1368
> > > >   __do_sys_sendfile64 fs/read_write.c:1429 [inline]
> > > >   __se_sys_sendfile64 fs/read_write.c:1415 [inline]
> > > >   __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
> > > >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >
> > > > Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> > > > Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/netdev/67ea5c01.050a0220.1547ec.012=
b.GAE@google.com/T/#u
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > > Cc: Xin Long <lucien.xin@gmail.com>
> > > > ---
> > > >  net/sctp/sysctl.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > > > index 8e1e97be4df79f3245e2bbbeb0a75841abc67f58..ee3eac338a9deef064f=
273e29bb59b057835d3f1 100644
> > > > --- a/net/sctp/sysctl.c
> > > > +++ b/net/sctp/sysctl.c
> > > > @@ -525,6 +525,8 @@ static int proc_sctp_do_auth(const struct ctl_t=
able *ctl, int write,
> > > >         return ret;
> > > >  }
> > > >
> > > > +static DEFINE_MUTEX(sctp_sysctl_mutex);
> > > > +
> > > >  static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int =
write,
> > > >                                  void *buffer, size_t *lenp, loff_t=
 *ppos)
> > > >  {
> > > > @@ -549,6 +551,7 @@ static int proc_sctp_do_udp_port(const struct c=
tl_table *ctl, int write,
> > > >                 if (new_value > max || new_value < min)
> > > >                         return -EINVAL;
> > > >
> > > > +               mutex_lock(&sctp_sysctl_mutex);
> > > >                 net->sctp.udp_port =3D new_value;
> > > >                 sctp_udp_sock_stop(net);
> > > >                 if (new_value) {
> > > > @@ -561,6 +564,7 @@ static int proc_sctp_do_udp_port(const struct c=
tl_table *ctl, int write,
> > > >                 lock_sock(sk);
> > > >                 sctp_sk(sk)->udp_port =3D htons(net->sctp.udp_port)=
;
> > > >                 release_sock(sk);
> > > > +               mutex_unlock(&sctp_sysctl_mutex);
> > > >         }
> > > >
> > > >         return ret;
> > > > --
> > > > 2.49.0.472.ge94155a9ec-goog
> > > >
> > > Instead of introducing a new lock for this, wouldn't be better to jus=
t
> > > move up `lock_sock(sk)` a little bit?
> >
> > It depends if calling synchronize_rcu() two times while holding the
> > socket lock is ok or not ?
> >
> > What is the issue about using a separate mutex ?
> >
>
> Don't they need locking against a different path that is using the socket=
?
> Not only against concurrent accesses to the sysctl?
>
Hi Davide,

The lock is used to protect the variable 'net->sctp.udp4_sock',  and there
are no other paths accessing it.

The udp socket is created to listen on a specific port for receiving only,
there's no need to access net->sctp.udp4_sock in sctp data path.

Thanks.

> Presuming the crash was because of the net->sctp.udp4_sock =3D NULL
> assignment in sock_stop(), if 'min' is zero allowing 'new_value' zero
> then the pointer is left NULL.
>
> IIRC sctp_sk(sk) is fixed, so the sock_lock() doesn't do much apart
> from stop some unlikely 'data tearing'.
>
>         David

