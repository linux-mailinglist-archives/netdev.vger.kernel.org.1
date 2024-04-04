Return-Path: <netdev+bounces-85002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F76898E95
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2328B1F26D05
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5490B132816;
	Thu,  4 Apr 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTFwBnR+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17A1339B1
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257464; cv=none; b=UWxK/39BOxDyL1OfnWiG4mE5JNHE62NHnf/qNcDMurXEr9dohBF5EWrnt/6nv9L4FmMxS2azZ7P7NjAym27VIkhFQdi8UTI3ZfMWvUVOBGmfnpnVt25APzgfCgNt5cnY61lPKX2zuoJxcdEmFc2JCe5WzfnamRBUMPxZ0dxlWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257464; c=relaxed/simple;
	bh=o+e+jiZVEfhOlZYpT3G22zOXxhO772WDVqxRnfFtvDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h30i1oDmXcsFXndyTsVLUvJMnggHsum5wFX5WMCf/IJCXAV9h69V+Gc2Fx9ykOpVfD/UHbkrlZ8gc+RyAzlMuHZlT7EN28FEuXhC6Xk+bigKw5wpUmRrTCfMBbACRNKVR3V56HUw9xiVDtoDpPKFb959ClUebtU34FkCYlgZflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTFwBnR+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e0c7f7ba3so4712a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712257460; x=1712862260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMb/vnG2VhZlXypT6e2bChSwQy9isfBQhRZgyNNXI5k=;
        b=pTFwBnR+T0iXj3WoEsZ/nPJUVqeJ/3Sx8GO6VTnNh9UOQfjzZKNgMtDLKv9BFOBDD7
         6rflhdHt4kRfBcQitjafvH2NXtNH2eLigLzaxqWHsLCqRrjQ9AucdFrbmT8vwZFUMK5i
         Mggn4oWL1pRea0vQdTW9/Y3BJg0KJuBBk+iQawrXBaTpf7toKw/jvxlsbVBIN2jGmrtn
         v/s0fxld54DZwnuXl/VYm0XMaqvC8k31I6tgtn+NOFvPcVjA3fH8/0nebw0bR13TGYpJ
         cu9uGtJKDdvy0q6S4FyUn2hi494gECaDVznMYMh+3vDABLAhS+4Y8VVlIaIRg7fGoi5w
         d0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257460; x=1712862260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMb/vnG2VhZlXypT6e2bChSwQy9isfBQhRZgyNNXI5k=;
        b=LScdj8xvMHJsPjPgioK2I4pyr7Tu1ITb+51YAB9x0PKInIKaTI4PTiGnPYLgDHANNK
         TrCEtUABQmT2LzTbw5MS0m90+t3T/ZwYeWC0sLX+NJE/spg8G4vRxIEwCF4YuunjMjb7
         W5Xq0h3x020sevKP7uQyMdE/rJep8z9Kc9SOoRXOsHU2SD2L4otVrtPI9tY/zEpbz3zN
         8KaqRHH7hD/3huljKIn8XxstpMQe2NIMsYd2TCwhwK5rojs6Pkwrp5IUNa5Qh3doWTHL
         3+9x+3dtyEGdp8LQuIUkd0EHsRzULMwke8wTJBX3Evtc1jYbC26yp8EvOGgnvs/jEgmq
         w3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWkzEYyraSuyAHCVeS5/bRDFFCpp8tdrOh0+ggiZ6NpLCR0u5O1wE/nhbyzIlJJ6Kj5vO8UHeHYqpe/VNuMJgpw3bYHnklX
X-Gm-Message-State: AOJu0YxgMXhAvVoYcWHkGvZxi0tZ12tC9Ec5FC4AEp1A5f9I06DCYwcZ
	W5hIEr1BJlsiPJXLX+ctEWe1vbMXOktWYt08cOV4xdae8pOK3nayPmuoSJsi9FZ9aprAfqQ+bCW
	D9Fdp7ToyrfXSYsZY/NjWt4/pZUvSb9c4ugJV6XMSlB1XOh1i/A==
X-Google-Smtp-Source: AGHT+IEgPLByot8LIdYDuX+UEoS3JBYUZ8nJP2JyHe1zTkP6udenYvsPZCAsXEe06fBBNMaa/YA9UAMPjVqwtd85uPI=
X-Received: by 2002:a05:6402:206b:b0:56d:fdc5:b515 with SMTP id
 bd11-20020a056402206b00b0056dfdc5b515mr195123edb.4.1712257460382; Thu, 04 Apr
 2024 12:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404123602.2369488-1-edumazet@google.com> <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
In-Reply-To: <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Apr 2024 21:04:09 +0200
Message-ID: <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: validate setsockopt( BT_PKT_STATUS /
 BT_DEFER_SETUP) user input
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:31=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Eric,
>
> On Thu, Apr 4, 2024 at 8:36=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > syzbot reported sco_sock_setsockopt() is copying data without
> > checking user input length.
> >
> >  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/lin=
ux/sockptr.h:49 [inline]
> >  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sock=
ptr.h:55 [inline]
> >  BUG: KASAN: slab-out-of-bounds in sco_sock_setsockopt+0xc0b/0xf90 net/=
bluetooth/sco.c:893
> > Read of size 4 at addr ffff88805f7b15a3 by task syz-executor.5/12578
> >
> > CPU: 1 PID: 12578 Comm: syz-executor.5 Not tainted 6.8.0-syzkaller-0895=
1-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> > Call Trace:
> >  <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >   print_address_description mm/kasan/report.c:377 [inline]
> >   print_report+0x169/0x550 mm/kasan/report.c:488
> >   kasan_report+0x143/0x180 mm/kasan/report.c:601
> >   copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
> >   copy_from_sockptr include/linux/sockptr.h:55 [inline]
> >   sco_sock_setsockopt+0xc0b/0xf90 net/bluetooth/sco.c:893
> >   do_sock_setsockopt+0x3b1/0x720 net/socket.c:2311
> >   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> >   __do_sys_setsockopt net/socket.c:2343 [inline]
> >   __se_sys_setsockopt net/socket.c:2340 [inline]
> >   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> >  do_syscall_64+0xfd/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7f3c2487dde9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f3c256b40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 00007f3c249abf80 RCX: 00007f3c2487dde9
> > RDX: 0000000000000010 RSI: 0000000000000112 RDI: 0000000000000008
> > RBP: 00007f3c248ca47a R08: 0000000000000002 R09: 0000000000000000
> > R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000004d R14: 00007f3c249abf80 R15: 00007fff5dcf4978
> >  </TASK>
> >
> > Allocated by task 12578:
> >   kasan_save_stack mm/kasan/common.c:47 [inline]
> >   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> >   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
> >   kasan_kmalloc include/linux/kasan.h:211 [inline]
> >   __do_kmalloc_node mm/slub.c:3966 [inline]
> >   __kmalloc+0x233/0x4a0 mm/slub.c:3979
> >   kmalloc include/linux/slab.h:632 [inline]
> >   __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1=
869
> >   do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
> >   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> >   __do_sys_setsockopt net/socket.c:2343 [inline]
> >   __se_sys_setsockopt net/socket.c:2340 [inline]
> >   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> >  do_syscall_64+0xfd/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >
> > The buggy address belongs to the object at ffff88805f7b15a0
> >  which belongs to the cache kmalloc-8 of size 8
> > The buggy address is located 1 bytes to the right of
> >  allocated 2-byte region [ffff88805f7b15a0, ffff88805f7b15a2)
> >
> > The buggy address belongs to the physical page:
> > page:ffffea00017dec40 refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x5f7b1
> > flags: 0xfff00000000800(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: 0xffffffff()
> > raw: 00fff00000000800 ffff888014c41280 ffffea0000a26d80 dead00000000000=
2
> > raw: 0000000000000000 0000000080800080 00000001ffffffff 000000000000000=
0
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc=
0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5091, tgid 5091 (syz-executor=
.3), ts 75758857522, free_ts 75730585588
> >   set_page_owner include/linux/page_owner.h:31 [inline]
> >   post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
> >   prep_new_page mm/page_alloc.c:1540 [inline]
> >   get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
> >   __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
> >   __alloc_pages_node include/linux/gfp.h:238 [inline]
> >   alloc_pages_node include/linux/gfp.h:261 [inline]
> >   alloc_slab_page+0x5f/0x160 mm/slub.c:2175
> >   allocate_slab mm/slub.c:2338 [inline]
> >   new_slab+0x84/0x2f0 mm/slub.c:2391
> >   ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
> >   __slab_alloc mm/slub.c:3610 [inline]
> >   __slab_alloc_node mm/slub.c:3663 [inline]
> >   slab_alloc_node mm/slub.c:3835 [inline]
> >   __do_kmalloc_node mm/slub.c:3965 [inline]
> >   __kmalloc_node_track_caller+0x2d6/0x4e0 mm/slub.c:3986
> >   kstrdup+0x3a/0x80 mm/util.c:62
> >   __kernfs_new_node+0x9d/0x880 fs/kernfs/dir.c:611
> >   kernfs_new_node+0x13a/0x240 fs/kernfs/dir.c:691
> >   kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1052
> >   sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
> >   create_dir lib/kobject.c:73 [inline]
> >   kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
> >   kobject_add_varg lib/kobject.c:374 [inline]
> >   kobject_init_and_add+0x124/0x190 lib/kobject.c:457
> >   netdev_queue_add_kobject net/core/net-sysfs.c:1786 [inline]
> >   netdev_queue_update_kobjects+0x1ee/0x5f0 net/core/net-sysfs.c:1838
> >   register_queue_kobjects net/core/net-sysfs.c:1900 [inline]
> >   netdev_register_kobject+0x265/0x320 net/core/net-sysfs.c:2140
> > page last free pid 5103 tgid 5103 stack trace:
> >   reset_page_owner include/linux/page_owner.h:24 [inline]
> >   free_pages_prepare mm/page_alloc.c:1140 [inline]
> >   free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
> >   free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2532
> >   release_pages+0x2744/0x2a80 mm/swap.c:1042
> >   tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
> >   tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
> >   tlb_flush_mmu+0x34d/0x4e0 mm/mmu_gather.c:300
> >   tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:392
> >   exit_mmap+0x4b6/0xd40 mm/mmap.c:3300
> >   __mmput+0x115/0x3c0 kernel/fork.c:1345
> >   exit_mm+0x220/0x310 kernel/exit.c:569
> >   do_exit+0x99e/0x27e0 kernel/exit.c:865
> >   do_group_exit+0x207/0x2c0 kernel/exit.c:1027
> >   __do_sys_exit_group kernel/exit.c:1038 [inline]
> >   __se_sys_exit_group kernel/exit.c:1036 [inline]
> >   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
> >  do_syscall_64+0xfd/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >
> > Memory state around the buggy address:
> >  ffff88805f7b1480: 05 fc fc fc 05 fc fc fc fa fc fc fc 05 fc fc fc
> >  ffff88805f7b1500: 05 fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
> > >ffff88805f7b1580: 04 fc fc fc 02 fc fc fc fa fc fc fc 05 fc fc fc
> >                                ^
> >  ffff88805f7b1600: fa fc fc fc 05 fc fc fc fa fc fc fc 05 fc fc fc
> >  ffff88805f7b1680: 05 fc fc fc 05 fc fc fc 00 fc fc fc fa fc fc fc
> >
> > Fixes: 00398e1d5183 ("Bluetooth: Add support for BT_PKT_STATUS CMSG dat=
a for SCO connections")
> > Fixes: b96e9c671b05 ("Bluetooth: Add BT_DEFER_SETUP option to sco socke=
t")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com> (supporter:BLUETOOTH =
SUBSYSTEM)
> > Cc: linux-bluetooth@vger.kernel.org
> > ---
> >  net/bluetooth/sco.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 43daf965a01e4ac5c9329150080b00dcd63c7e1c..9d013f01865fd2509f28eac=
3bceadf682f0a5edb 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -843,6 +843,10 @@ static int sco_sock_setsockopt(struct socket *sock=
, int level, int optname,
> >                         break;
> >                 }
> >
> > +               if (optlen < sizeof(u32)) {
> > +                       err =3D -EINVAL;
> > +                       break;
> > +               }
>
> Usually we deal with this sort of problem by doing len =3D
> min_t(unsigned int, sizeof(u32), optlen) so we truncate the value if
> smaller, perhaps it would be better to have a helper function that
> does len check internally.

Well, what happens if user provided optlen =3D=3D 1 ?

opt would then contain 24 bits of garbage.

