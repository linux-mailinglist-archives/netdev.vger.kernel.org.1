Return-Path: <netdev+bounces-178479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90CA771C5
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A3A3A2045
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD362AF04;
	Tue,  1 Apr 2025 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0mwcSfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18A2E3384
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466551; cv=none; b=H+3HTf7pnh7x8ypcyF3oOHrLcLijbpbv1H+QfsUeLglWwbtIlyxD26tpUtmXI6KCldshxPthF0jXLMuOetYGBJPoEppKqMj+ym4lqfDHQuC41RyTyNMIMzWla6GqUxVn4jQXz5d/MJ/j8y+2Wwy1trAq91hNJ6MocCXC2ifslbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466551; c=relaxed/simple;
	bh=/m1WuTZ+O9iJ/eXeQUq6FN4oSDp9iqOjnkMuniMKBeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxxSgmSaeDlIVUvj9S7HukwRBqbD7OUSwKfx6FAYOh4Qkk0eY5eGf5eyT1NF+iOomwOC+Mmd5sAnLMCr1Mxg3R02eIa0ORcC91m+jGWp1NuAVbymuRvh+btBs0dE8EoEWcoioXrDZLorm4XdtgFZ/Au8NNqcIDmzlB8IAn7ZYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0mwcSfO; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d5d69c535aso11708745ab.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743466549; x=1744071349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBcOSJdagmL0/Z2bzqJND4pUfeH7/3ttFoni0xH8e9A=;
        b=h0mwcSfOLXeIsJRNbYExIvsyHctgbYgLAiwZHWuVX6BasA0hLOkvEd2UcfmTRGbw9R
         cE1TQfKjsYIVB3ZrBY7WT081zn2AfmIXRdbJxmlevgfR7dll0D+rCQfP21W8qB9fE7g+
         TA3YeZhMJe7TSLL9C5d1Eq+CW3ObSjqiR0rxDIiOUp1E5QAcbuPK416vq/viNIspwpXw
         6/HQf+05B0BpajCHWOeGmx9vi6SscUjc1k39bp9Ji2cMZ6QdbguEJSEuPjQLOhcpZC0P
         6+7oAaiIeZA/dWgIEPA7cl1GCpQDLaQQRoA3xGpOvURTTaSIgtFJ37OvL9XRC/F1kcIR
         epLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743466549; x=1744071349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBcOSJdagmL0/Z2bzqJND4pUfeH7/3ttFoni0xH8e9A=;
        b=HGolvuoUe78rlHzMHZnUZDXaXTGeVCYlHV1wuMRt40KHLLgcg51pYd2TkS3P1Xs49B
         jrDwufbN2QRjLxcMgPEUBmLeE1W8hXynzsC87IoX2we1zvcQfn23nRu/CKx1/U4aP4e1
         SePQ7PLtAAcyvuZxY9VIBG+x5AT0tIAtfsV+KNvC32vqixle9UhqJenIBU8GYh/x75XN
         LE6l60IR0pu/ocGGyiTJGtnBtUcJMlC7NJ+zUdIxaikcrRj1+wuBkm7FNAmi22KL79aQ
         EJfL7m+uHfEGP6ybBqyFjO3hUktOLPgdW3Crig8ngqSU1G6SptyLSMOvXQF2Jp7eqR+g
         O51Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjzpVukA+U+6x1uhVF3XPKgaiYa+uZsIaAwzb2l+jfhwMOETeL6EnOk805taQGf0nMfFUu0r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkGxvLIBFrUoFw7L7cS5ImjUIU9t2+WPyaHtE5k/58XEmPo51
	IpzLcM2SbHNqES9rZX4Y8Yz5g7fAM6+GB2yh3zZ2C0a13lXn7EgUT9ZTc2+0FgvPmPXcux8XTg4
	Sta1AwTgv7pOTlsXzzTMy+lp4mE0=
X-Gm-Gg: ASbGncvO3bYb7dtjaJe/f3MLw3wnS5cw0jfXuQQJUZklTujLfVWApMakleDGw73eFsB
	Z7ZcD0Lg/D7bN29NeubsAEhMFrJfbG/y8wSYZlqmOzISTtsayyZ56JkNInPF3rBD3HyW9LKeHwZ
	TjPG7dawjuuhwRSP5YQh6Js7tVKuH5tV2KVn5Lcom1PcqUiWMhbgquBklMgdsv
X-Google-Smtp-Source: AGHT+IH2rffnP6DBD4qLcrzLNSFGcsSgyWwV+Bmgc4T7l+NgAX01Oo228engQog7KezsADI8aL4fCgQyxTF0T4+PI4s=
X-Received: by 2002:a92:ca09:0:b0:3d3:f19c:77c7 with SMTP id
 e9e14a558f8ab-3d5e09c8d9fmr96379865ab.16.1743466548788; Mon, 31 Mar 2025
 17:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331091532.224982-1-edumazet@google.com> <CADvbK_eneePox-VFbicSmt55g+VJdc+5m_LoS2bu_Pezatjq0g@mail.gmail.com>
 <CANn89i+xpmBDQBPPG_QDfACHL=8h5=1bKqJjvD+e4=SHU7t76A@mail.gmail.com>
In-Reply-To: <CANn89i+xpmBDQBPPG_QDfACHL=8h5=1bKqJjvD+e4=SHU7t76A@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 31 Mar 2025 20:15:38 -0400
X-Gm-Features: AQ5f1Jo3ZHTkBc8x9UFJq-DMO8hqT1J-aIFWUbxX4Pm5hxdwdSx7quvcXWYsuVo
Message-ID: <CADvbK_cG8VogkfR9r=7byXJU+_Z=wfsP8uQYC8VazpW+rdB3jg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: add mutual exclusion in proc_sctp_do_udp_port()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:11=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Mar 31, 2025 at 5:54=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Mon, Mar 31, 2025 at 5:15=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_sta=
rt()
> > > or risk a crash as syzbot reported:
> > >
> > > Oops: general protection fault, probably for non-canonical address 0x=
dffffc000000000d: 0000 [#1] SMP KASAN PTI
> > > KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f=
]
> > > CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller-g=
7f2ff7b62617 #0 PREEMPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 02/12/2025
> > >  RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
> > > Call Trace:
> > >  <TASK>
> > >   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
> > >   sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
> > >   proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
> > >   proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
> > >   iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
> > >   do_splice_from fs/splice.c:935 [inline]
> > >   direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
> > >   splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
> > >   do_splice_direct_actor fs/splice.c:1201 [inline]
> > >   do_splice_direct+0x174/0x240 fs/splice.c:1227
> > >   do_sendfile+0xafd/0xe50 fs/read_write.c:1368
> > >   __do_sys_sendfile64 fs/read_write.c:1429 [inline]
> > >   __se_sys_sendfile64 fs/read_write.c:1415 [inline]
> > >   __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
> > >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >
> > > Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> > > Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/67ea5c01.050a0220.1547ec.012b.=
GAE@google.com/T/#u
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > Cc: Xin Long <lucien.xin@gmail.com>
> > > ---
> > >  net/sctp/sysctl.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > > index 8e1e97be4df79f3245e2bbbeb0a75841abc67f58..ee3eac338a9deef064f27=
3e29bb59b057835d3f1 100644
> > > --- a/net/sctp/sysctl.c
> > > +++ b/net/sctp/sysctl.c
> > > @@ -525,6 +525,8 @@ static int proc_sctp_do_auth(const struct ctl_tab=
le *ctl, int write,
> > >         return ret;
> > >  }
> > >
> > > +static DEFINE_MUTEX(sctp_sysctl_mutex);
> > > +
> > >  static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int wr=
ite,
> > >                                  void *buffer, size_t *lenp, loff_t *=
ppos)
> > >  {
> > > @@ -549,6 +551,7 @@ static int proc_sctp_do_udp_port(const struct ctl=
_table *ctl, int write,
> > >                 if (new_value > max || new_value < min)
> > >                         return -EINVAL;
> > >
> > > +               mutex_lock(&sctp_sysctl_mutex);
> > >                 net->sctp.udp_port =3D new_value;
> > >                 sctp_udp_sock_stop(net);
> > >                 if (new_value) {
> > > @@ -561,6 +564,7 @@ static int proc_sctp_do_udp_port(const struct ctl=
_table *ctl, int write,
> > >                 lock_sock(sk);
> > >                 sctp_sk(sk)->udp_port =3D htons(net->sctp.udp_port);
> > >                 release_sock(sk);
> > > +               mutex_unlock(&sctp_sysctl_mutex);
> > >         }
> > >
> > >         return ret;
> > > --
> > > 2.49.0.472.ge94155a9ec-goog
> > >
> > Instead of introducing a new lock for this, wouldn't be better to just
> > move up `lock_sock(sk)` a little bit?
>
> It depends if calling synchronize_rcu() two times while holding the
> socket lock is ok or not ?
hm, It doesn't sound normal, although this ctl_sock only handles the
out-of-blue packets.

>
> What is the issue about using a separate mutex ?
no issue, just don't want to introduce a new lock for this only.

Acked-by: Xin Long <lucien.xin@gmail.com>

