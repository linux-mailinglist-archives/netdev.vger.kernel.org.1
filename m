Return-Path: <netdev+bounces-244391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58DCB62C1
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90810300F9C2
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28623EA8E;
	Thu, 11 Dec 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwmkdtsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AC23D2B2
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462877; cv=none; b=hHdW5aKcoFHXEfUD7cZPlSnxhC2IV4IrmOWlewaaeYQH677p3cEHuHQ9HZeEnHFXkJ5xqeImlIN4xKloEAjvm4TP/LrXBoDWd9ALPnfT7jdcNhnE9YE4dfKkah+sXQ5uJCuaRMqoeaW3poA96DX0fQWeVmzvOhsQh6LfeXywAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462877; c=relaxed/simple;
	bh=OtMVvT7PAxlWiQF/sjTXeNmYXlakuIaMdXNcuca9We0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAwEivtGIueaLmPfwh+sf+TsNL+kdonGYUZRieByW5Kafx0XFOtg1jN1hGxISyMq9GSDvDyhBMsgSeoLkcejv9MENQJcOuaDMJTFmyO7CWJpoeDuJPT7cBuIFdmhcdPh/6cnh12FfX220KOT2X8ghH0EQ0RfjnRsIj29jipGxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwmkdtsy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340ba29d518so85946a91.3
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765462875; x=1766067675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPAvPVPnOMxEMvkuieq2yuesc5t9gpM5MwAjDwFRqgM=;
        b=IwmkdtsyF/tI3+xbbUrc4A/s46oFrCmip4bcTiqE8GxPxnd0YRCdyVw9GVyvwQeusI
         ZuxM+VC1iuAgsuyxYq+yG2nRvgMy9oPdkNyD1+7jYBzvcA2bRbCvI9Q0wH7GqzbbqGQe
         PW9SudDsV3EgUvqM4m7IX8WeVDxEdG3UAeq59q6QACOzIJWSWHaeTf9LOVaZ1+1Ump5n
         acwmVsLM985rzG2ug8jJJ156+ywn2OAabzxOFnoaYWxHUm3ZsQ9Qy68zeQt4KjZlvPVJ
         fVyjIegvVF7hfKg/zmX0xm891Eb8XJhwZCGCOb93esjbkaq9oRb30jAlHB4HuRPoDkcI
         8Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765462875; x=1766067675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPAvPVPnOMxEMvkuieq2yuesc5t9gpM5MwAjDwFRqgM=;
        b=wgJpuDypxpG49MC3AUw/7M/6SiQbVMG/dlLwMSqYXHGFOwyWMFs3p25AKn+EkOQDtd
         L89kKWQZluI6t8tKBoqGqVeoLvYHSN7NyxOEXZM3jb17/GF9XqzzeNqqKxh44lRjB1Ll
         V+jPdZYtXnx8LT9FZV/CaxRPuhVEKR/tAV4FEdkNBAye6eqznhd3DmJ9uVQbEPnA7tGd
         NOghX1GA7VOf6gcFgeRoF5+6tpSf2ev2bqfE6leDfT/s5U1WkRyYBIPL42OgqtjHkMXN
         ZfbGejAfVH3Gjz04Kz4Qt2ESQswtpvoSTwBX518HdUGO6lRTw3lIyj8gE0AxNhiZl/T7
         ANyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNW9wyclCLtr7Q7UV5zkTbnRS+jayDE/4hwU5CH2VwgD+mFOTxj0QNkYufReeVb2x6Np2NPf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmRa6AKDDu0hRyLuMizDnOkl/BRZkEVIfszOMHjzAGmleF03J
	Lsade+flHXrHe31OUMOq/qYBMiw3R2muvwxm40WQXlsRJUMyVDX/MQgYHvy3BIG/Mxe5XPTUizT
	drwD0dv1e3SUH3q3Kbb/6+wBElWIS/2E=
X-Gm-Gg: AY/fxX7fl4K9WJCzBwGOKduZUNyZxb4mvLSsEyaYq9UNvTXDwA4OXGRJqinXfGQWzCw
	q3IJ95D4NTCcgi1PcVgF/nInWwSmPaz0Xw3zi5nyUCe7LomGD0O98PS7xEuHtK6Za5IWgpYapDp
	Oj2DZ9Gy+sUSl5afuFne7kI23DZHX5zwl8e+GBYoLza4KxFGXlsVeP/21zjfovmLzX5vFliVIvV
	keF5vC58h0R6UfdpSrKN4LDvpkkIFhOaC7ZPDSWyP9UQdo/RnISx+TNQvnmZ/5UyDvBRqU=
X-Google-Smtp-Source: AGHT+IEp0/jM1lTSRkVuwtZE956s+2lpEEejviHnmpbu0Qtub25mapmSA8t8+TxhXKubVsh+7jb9lRM8DUKOMozCVZ0=
X-Received: by 2002:a17:90b:2d45:b0:349:30b4:6365 with SMTP id
 98e67ed59e1d1-34a7288be9amr5726671a91.27.1765462874529; Thu, 11 Dec 2025
 06:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210081206.1141086-1-kuniyu@google.com> <20251210081206.1141086-3-kuniyu@google.com>
 <CADvbK_fhSZGLcKb_UPCoP55ODmggvQn0jg53BKihLxO9xwt7+g@mail.gmail.com> <CAAVpQUDYA9vm1-St4X7xRGG655=8Khj7sEcWCn4JDQm3p-671A@mail.gmail.com>
In-Reply-To: <CAAVpQUDYA9vm1-St4X7xRGG655=8Khj7sEcWCn4JDQm3p-671A@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 11 Dec 2025 09:21:02 -0500
X-Gm-Features: AQt7F2pOI1id04fFLW9Xnlg1zhxPjPUv4jcKT3z4J9pnaSYhlGZz9PDp4Te0CzA
Message-ID: <CADvbK_dCuuaBSkOeO=utQZcmf0H4WKSi5ZrUG+UggbxbjWAm2g@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] sctp: Clear inet_opt in sctp_v6_copy_ip_options().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 5:45=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Dec 10, 2025 at 11:32=E2=80=AFAM Xin Long <lucien.xin@gmail.com> =
wrote:
> >
> > On Wed, Dec 10, 2025 at 3:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > syzbot reported the splat below. [0]
> > >
> > > Since the cited commit, the child socket inherits all fields
> > > of its parent socket unless explicitly cleared.
> > >
> > > syzbot set IP_OPTIONS to AF_INET6 socket and created a child
> > > socket inheriting inet_sk(sk)->inet_opt.
> > >
> > > sctp_v6_copy_ip_options() only clones np->opt, and leaving
> > > inet_opt results in double-free.
> > >
> > > Let's clear inet_opt in sctp_v6_copy_ip_options().
> > >
> > > [0]:
> > > BUG: KASAN: double-free in inet_sock_destruct+0x538/0x740 net/ipv4/af=
_inet.c:159
> > > Free of addr ffff8880304b6d40 by task ksoftirqd/0/15
> > >
> > > CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREE=
MPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 10/02/2025
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:378 [inline]
> > >  print_report+0xca/0x240 mm/kasan/report.c:482
> > >  kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
> > >  check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
> > >  kasan_slab_pre_free include/linux/kasan.h:198 [inline]
> > >  slab_free_hook mm/slub.c:2484 [inline]
> > >  slab_free mm/slub.c:6630 [inline]
> > >  kfree+0x148/0x6d0 mm/slub.c:6837
> > >  inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
> > >  __sk_destruct+0x89/0x660 net/core/sock.c:2350
> > >  sock_put include/net/sock.h:1991 [inline]
> > >  sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
> > >  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> > >  rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
> > >  handle_softirqs+0x286/0x870 kernel/softirq.c:622
> > >  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
> > >  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
> > >  kthread+0x711/0x8a0 kernel/kthread.c:463
> > >  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >  </TASK>
> > >
> > > Allocated by task 6003:
> > >  kasan_save_stack mm/kasan/common.c:56 [inline]
> > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
> > >  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
> > >  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
> > >  kasan_kmalloc include/linux/kasan.h:262 [inline]
> > >  __do_kmalloc_node mm/slub.c:5642 [inline]
> > >  __kmalloc_noprof+0x411/0x7f0 mm/slub.c:5654
> > >  kmalloc_noprof include/linux/slab.h:961 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> > >  ip_options_get+0x51/0x4c0 net/ipv4/ip_options.c:517
> > >  do_ip_setsockopt+0x1d9b/0x2d00 net/ipv4/ip_sockglue.c:1087
> > >  ip_setsockopt+0x66/0x110 net/ipv4/ip_sockglue.c:1417
> > >  do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
> > >  __sys_setsockopt net/socket.c:2385 [inline]
> > >  __do_sys_setsockopt net/socket.c:2391 [inline]
> > >  __se_sys_setsockopt net/socket.c:2388 [inline]
> > >  __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Freed by task 15:
> > >  kasan_save_stack mm/kasan/common.c:56 [inline]
> > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
> > >  __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
> > >  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
> > >  poison_slab_object mm/kasan/common.c:252 [inline]
> > >  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
> > >  kasan_slab_free include/linux/kasan.h:234 [inline]
> > >  slab_free_hook mm/slub.c:2539 [inline]
> > >  slab_free mm/slub.c:6630 [inline]
> > >  kfree+0x19a/0x6d0 mm/slub.c:6837
> > >  inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
> > >  __sk_destruct+0x89/0x660 net/core/sock.c:2350
> > >  sock_put include/net/sock.h:1991 [inline]
> > >  sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
> > >  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> > >  rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
> > >  handle_softirqs+0x286/0x870 kernel/softirq.c:622
> > >  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
> > >  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
> > >  kthread+0x711/0x8a0 kernel/kthread.c:463
> > >  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >
> > > Fixes: 16942cf4d3e31 ("sctp: Use sk_clone() in sctp_accept().")
> > > Reported-by: syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/6936d112.a70a0220.38f243.00a8.=
GAE@google.com/
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  net/sctp/ipv6.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> > > index 069b7e45d8bda..531cb0690007a 100644
> > > --- a/net/sctp/ipv6.c
> > > +++ b/net/sctp/ipv6.c
> > > @@ -492,6 +492,8 @@ static void sctp_v6_copy_ip_options(struct sock *=
sk, struct sock *newsk)
> > >         struct ipv6_pinfo *newnp, *np =3D inet6_sk(sk);
> > >         struct ipv6_txoptions *opt;
> > >
> > > +       inet_sk(newsk)->inet_opt =3D NULL;
> > > +
> > newinet->pinet6 =3D inet6_sk_generic(newsk);
> > newinet->ipv6_fl_list =3D NULL;
> > newinet->inet_opt =3D NULL;
> >
> > newnp->ipv6_mc_list =3D NULL;
> > newnp->ipv6_ac_list =3D NULL;
> >
> > I noticed these fields are reset after sk_clone() for both SCTP and TCP=
.
> > I believe the same applies to MPTCP.
> >
> > If that's the case, is it possible to move their initialization up into
> > sk_clone()? Doing so would address both issues in this patchset.
>
> Yes, but moving unrelated ipv6_mc_list etc would be net-next
> material, so I can follow up after net-next reopens next year.
>
>
> >
> > Also, memcpy(newnp, inet6_sk(sk), sizeof(struct ipv6_pinfo)) might be
> > redundant, since sock_copy() already copies this with prot->obj_size.
>
> Exactly, I should've removed it when switching to sk_clone().
> I'll follow up on this too in net-next.
Fair enough. It would be nice to also set newinet->inet_opt =3D NULL for IP=
v4,
and newnp->opt =3D NULL for IPv6 sockets.  That way, any sk_clone() users t=
hat
forget to re-initialize these fields won=E2=80=99t end up crashing the kern=
el.

Thanks.

