Return-Path: <netdev+bounces-244298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED0CB4298
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6626930A9553
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739E2641C6;
	Wed, 10 Dec 2025 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYoZbdEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4F21E091
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765406735; cv=none; b=A3GubqLfByuZV/o6WT9oMiZtHlQFbNtFxL8IoS5KAfZLyXu1z4gjdPrsZ/3jn6TURZGX2wwO0ZdW7W3nkBzY+FKT8P2Gd8TivLHnLdZU67oKY5rlTsNzl0VBDUg4SBy8ANCwNCLAxkwNAXTeCujMwJFn62QArJrrBEurWVslCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765406735; c=relaxed/simple;
	bh=nJiFt3dZK6kLQSTbUjkX5cAFATbAFaRwAYZY69aPv0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdZvXTQzRlgq1sJDrT0TkDJ7YJero3cqhG/f2SCM6q/VYGRwF3o0PyqaPcn3k2jHxmleAQm7W4i/Ot5Tas2DhuDuzpR6S9iLSFzG5SUG3dATs7GjTPAE9vx0hmG2fGwYYwSUtXm7Q5TPxycJ42MReZUcSttqOcI3kgr/l+nHpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kYoZbdEt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34a4079cfaeso380302a91.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 14:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765406732; x=1766011532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49e86Khlq+HoKGUIZo+RXa4A2Mah6OheJk2cnQfMygM=;
        b=kYoZbdEtgUwsxBcH//mgxRrBZZb0y6YSZ++bsK6pqv4nCf5pVDHD475nkoPFNIdP1A
         WqWipCUvZ98egtUz8CxZlz6X/+35/Eb2HDFptQT4CeE5RvGkOIIyUb+Pa+Mf7+lIe2jo
         q2P+ykBq+nVhf+a512K4QL2JJOnej2ot7kJXSFpX5C16pkReb6Ez9pN6PWMI6Xb5jXVx
         4CXlIttYdB1R4wL5ORMFO1TVRTZq4j1x3VBolf+Ot2IqRDXeyTiBDGJLI0LxVOWbxYH3
         ngXMSzC5Bh1iDbVueaYVqVbTmf3TE93mWZPOzQoVAaQtN7DqFxiQVSdH+xeEAbKdAEXq
         FhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765406732; x=1766011532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49e86Khlq+HoKGUIZo+RXa4A2Mah6OheJk2cnQfMygM=;
        b=YLigzubZ4NgPwB1CSUzYhHbS7mE5plAk4O7EhXy/DGnM8OZW5xiudl0MWPh8aFxkyc
         kedrJlljTHA8/O8X3Xs7a8/fID357j1KNhcjWN8HNc9pHheOGA+1+eMM8Oq5GfF+B0pu
         ywX2LTTvKnhE60q1ZIcGonOB4oj7h7DWQv1DXKtWTDTkRPZvI0pILbYqP/gI96yrREuk
         qNaWJwYCpjjyY3l28FZDohqUvXCEd0g7GJMbpqdq6Y4Q1rqK26FhIY3wF15tuLc3pYe4
         g59BXeHTb4+ZibLIMme/zOZCg8IflyMbUyieiUuU8Wvghop84ClnVanDOqiOiEDUP61r
         bm1A==
X-Forwarded-Encrypted: i=1; AJvYcCWYiUWE3OVaq9zleiOH+54S4Arr4Nh+NH57lotiTEjJdZgk//PTt/SGSpFCdJ+GQb2SGLmerEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxWOWF1yzjX6TUm59s8Nz2+sjiMwfx2lXCjO7mLl4LKQ5PShV
	ZHNQy2CTH+WOIHW652yrP9V2jBNiJTvaRQ+uJiAjznqsXVZkXgl39AA8WpXdASv79nJyzjXsvdX
	RCEUaGFpPFL12TEtNrslGSfzNA67Ege8FyT04wYnh
X-Gm-Gg: ASbGnctrnd0uLnW5Ju7c5OZJcTt50UbFxz9Mu5t5pA+orgaRgNAo2fmZNB9uR0qiN5O
	38kSt1yOxIWYxmMvA9aTy9jVNQ6DQvenpCgR9dwyDLp+Cv4bc3pLKViAbdvMfxXEVKkLCRA3hlB
	8A5DRrxcn0pOTNoXepZMHBj08tJKQEfPiCuV87SVIbjODrhdN1Zeetw1zdA8b74hQ3TrRKxkRPx
	sqsP70growSurn08kbATOvb97SA5MR10qSiwzqNUT9TbHmeD1jPXXWwyja31ME/zTBWAvsdW+Y2
	wl7ZU0JF9425OmCBvI9yxa3qvNQ=
X-Google-Smtp-Source: AGHT+IFSxOP3MZ+a1ZrrSUi+CwxbtfzGl5XHLGlYzpk9klURD9KLHVoFo4LMP8s8Vkn0PvlLvytTSwObxP80kqZUPdg=
X-Received: by 2002:a05:7022:110c:b0:11a:51f9:db0 with SMTP id
 a92af1059eb24-11f29666119mr2489036c88.11.1765406731715; Wed, 10 Dec 2025
 14:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210081206.1141086-1-kuniyu@google.com> <20251210081206.1141086-3-kuniyu@google.com>
 <CADvbK_fhSZGLcKb_UPCoP55ODmggvQn0jg53BKihLxO9xwt7+g@mail.gmail.com>
In-Reply-To: <CADvbK_fhSZGLcKb_UPCoP55ODmggvQn0jg53BKihLxO9xwt7+g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Dec 2025 14:45:20 -0800
X-Gm-Features: AQt7F2obQ9BUjE4gw8CVROtLNo58Dpb-4pX4OwJeUfq4kl8me3uwrM7lq4CpOPY
Message-ID: <CAAVpQUDYA9vm1-St4X7xRGG655=8Khj7sEcWCn4JDQm3p-671A@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] sctp: Clear inet_opt in sctp_v6_copy_ip_options().
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 11:32=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Wed, Dec 10, 2025 at 3:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > syzbot reported the splat below. [0]
> >
> > Since the cited commit, the child socket inherits all fields
> > of its parent socket unless explicitly cleared.
> >
> > syzbot set IP_OPTIONS to AF_INET6 socket and created a child
> > socket inheriting inet_sk(sk)->inet_opt.
> >
> > sctp_v6_copy_ip_options() only clones np->opt, and leaving
> > inet_opt results in double-free.
> >
> > Let's clear inet_opt in sctp_v6_copy_ip_options().
> >
> > [0]:
> > BUG: KASAN: double-free in inet_sock_destruct+0x538/0x740 net/ipv4/af_i=
net.c:159
> > Free of addr ffff8880304b6d40 by task ksoftirqd/0/15
> >
> > CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMP=
T(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/02/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xca/0x240 mm/kasan/report.c:482
> >  kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
> >  check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
> >  kasan_slab_pre_free include/linux/kasan.h:198 [inline]
> >  slab_free_hook mm/slub.c:2484 [inline]
> >  slab_free mm/slub.c:6630 [inline]
> >  kfree+0x148/0x6d0 mm/slub.c:6837
> >  inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
> >  __sk_destruct+0x89/0x660 net/core/sock.c:2350
> >  sock_put include/net/sock.h:1991 [inline]
> >  sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
> >  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> >  rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
> >  handle_softirqs+0x286/0x870 kernel/softirq.c:622
> >  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
> >  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
> >  kthread+0x711/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> > Allocated by task 6003:
> >  kasan_save_stack mm/kasan/common.c:56 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
> >  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
> >  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
> >  kasan_kmalloc include/linux/kasan.h:262 [inline]
> >  __do_kmalloc_node mm/slub.c:5642 [inline]
> >  __kmalloc_noprof+0x411/0x7f0 mm/slub.c:5654
> >  kmalloc_noprof include/linux/slab.h:961 [inline]
> >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> >  ip_options_get+0x51/0x4c0 net/ipv4/ip_options.c:517
> >  do_ip_setsockopt+0x1d9b/0x2d00 net/ipv4/ip_sockglue.c:1087
> >  ip_setsockopt+0x66/0x110 net/ipv4/ip_sockglue.c:1417
> >  do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
> >  __sys_setsockopt net/socket.c:2385 [inline]
> >  __do_sys_setsockopt net/socket.c:2391 [inline]
> >  __se_sys_setsockopt net/socket.c:2388 [inline]
> >  __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 15:
> >  kasan_save_stack mm/kasan/common.c:56 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
> >  __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
> >  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
> >  poison_slab_object mm/kasan/common.c:252 [inline]
> >  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
> >  kasan_slab_free include/linux/kasan.h:234 [inline]
> >  slab_free_hook mm/slub.c:2539 [inline]
> >  slab_free mm/slub.c:6630 [inline]
> >  kfree+0x19a/0x6d0 mm/slub.c:6837
> >  inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
> >  __sk_destruct+0x89/0x660 net/core/sock.c:2350
> >  sock_put include/net/sock.h:1991 [inline]
> >  sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
> >  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> >  rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
> >  handle_softirqs+0x286/0x870 kernel/softirq.c:622
> >  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
> >  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
> >  kthread+0x711/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >
> > Fixes: 16942cf4d3e31 ("sctp: Use sk_clone() in sctp_accept().")
> > Reported-by: syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6936d112.a70a0220.38f243.00a8.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/sctp/ipv6.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> > index 069b7e45d8bda..531cb0690007a 100644
> > --- a/net/sctp/ipv6.c
> > +++ b/net/sctp/ipv6.c
> > @@ -492,6 +492,8 @@ static void sctp_v6_copy_ip_options(struct sock *sk=
, struct sock *newsk)
> >         struct ipv6_pinfo *newnp, *np =3D inet6_sk(sk);
> >         struct ipv6_txoptions *opt;
> >
> > +       inet_sk(newsk)->inet_opt =3D NULL;
> > +
> newinet->pinet6 =3D inet6_sk_generic(newsk);
> newinet->ipv6_fl_list =3D NULL;
> newinet->inet_opt =3D NULL;
>
> newnp->ipv6_mc_list =3D NULL;
> newnp->ipv6_ac_list =3D NULL;
>
> I noticed these fields are reset after sk_clone() for both SCTP and TCP.
> I believe the same applies to MPTCP.
>
> If that's the case, is it possible to move their initialization up into
> sk_clone()? Doing so would address both issues in this patchset.

Yes, but moving unrelated ipv6_mc_list etc would be net-next
material, so I can follow up after net-next reopens next year.


>
> Also, memcpy(newnp, inet6_sk(sk), sizeof(struct ipv6_pinfo)) might be
> redundant, since sock_copy() already copies this with prot->obj_size.

Exactly, I should've removed it when switching to sk_clone().
I'll follow up on this too in net-next.

