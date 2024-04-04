Return-Path: <netdev+bounces-85020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50700898FE3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2D288872
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B512D1EF;
	Thu,  4 Apr 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9fWsTtf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11313AA56;
	Thu,  4 Apr 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264869; cv=none; b=Y/cJx7uHRvRaJauDRvNOZFaWaglUZMlNPhE76rMzkyCuL9t86mHmtibf/BCgWHB2Sai5afleOeKBMwsA/pr/KQRBb4qZ/ZKSIKyDRlTUKdEc3BV9/6V+7IKoSjQp7Jv+9BwjnW1AktNtJNhFIaid+ZiyVszqeh7OHYpW2cUcZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264869; c=relaxed/simple;
	bh=SPrsCt+96Ef4t6Uvmt292hPv1QOe1YN3cl5humKxypk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNzzzevpjXKzFK0DpgEYjDvGyRtOhNGyBGPTgZf2BqyhiDeH1hDbPUIxHICtR3UgcdtRlFEyWGIemaVebXTpohF+qpvk9CWCvr2swt+CdYXfq9nMPNfuenZn87FjMDbJAual7f0VncMEsZ5tUMsuj25zQOW/TIlGiJ9+c5F3rMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9fWsTtf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so19136221fa.0;
        Thu, 04 Apr 2024 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712264866; x=1712869666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwWIR+Fvzm57PQ+qlxVYuBVk+hYeDkdNxYheKsxzHjs=;
        b=P9fWsTtfRF5EnZPCETPtAIecOobEx9egRjA5T5dokg/cX7FCaPRS4iVM4efeaEe5RC
         K2HQdqfB/CcscM1TsxUkH5GwnAJdVBSu0wo6B2VVSrM36ouAdek71I29f7Qrq5Ub18fJ
         cIqItzGFhL+n97Sfxa4K4p1OLxLQwvt7UXb69elWkQMm+ZN6y1CL3/NuWjE/hF9YnTxb
         kCd1rHoKb90UtaurjsCdrFjM9GEXAOe3OpPGHdXmaAttjfrRqpL/fXBf52WwpavbPcFA
         /sE527cb0fuHr4Dtmpx+6v1BxxIYqvhVQbics/kOV/L2q+H1D56mwa/E5ZcXSrpZU0p0
         dNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264866; x=1712869666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwWIR+Fvzm57PQ+qlxVYuBVk+hYeDkdNxYheKsxzHjs=;
        b=CRmNm30+YWXAZ+6PiafYx26+3gfVliHh9SA9kpjemCq2CcSx8JXZhQA4Bf8x0JTcTv
         mY4Sbo0jT+dEfOnhVLu/TjbmfvR4g8ZEhz0MwSwHpEefnGvoydDLKDGnTTOxoKJkCWB+
         cZcSBKc4zTjTWCrrUmxoWBqG3mObDt5nbc/1Azhch1BRrt8zkJQiRRc2OnTib16Khts4
         VlohvvBLjSYlS2DYUP2w6YRz4mmehIRTIzAgWtURu+EXAmN8zrcxWQObefsEQuBcOFcU
         FDUqeTNfxxbJl2k32thyKoj+EX06+umsRwBr6+sxzwgH9ZiZV33QA+9xRAmcG2kFLMLk
         ccpg==
X-Forwarded-Encrypted: i=1; AJvYcCVcdcVIS1st+s6yhTuGQgZLy0jyMj/n97++8+paSWI1VHftVLRqcmxF2O0vd+mm3QwY+zxNvcIUp1evu0dH0VYQiTITicr3HB7Qo/YdQW7uFiy25nEJxJ31dM/T60RxPGuIdLdZDVTe
X-Gm-Message-State: AOJu0YxcZ5+a5ps4UF6DZFr1KrYPAbIjlY0vEmVffM7jEcCvL5LxpeWy
	T59/llx1A6Wnnf3M46SqX8ORDvjuQ3lCQiT7ZYA7BoxYQDwtlBTZ8qaLfS+wbNjAOjbJtuD8Edv
	Gcr3zRCJ3yDYND1hipTREU0yLgtk=
X-Google-Smtp-Source: AGHT+IEWWvr1Up6DqHKXOF4AW/P4VLByTsrGLERC6kRaWewRX15iFarpeVpJOgGVsKZU0HjbJwYSaruZBdv89tIhFlQ=
X-Received: by 2002:a05:651c:221d:b0:2d8:4637:4062 with SMTP id
 y29-20020a05651c221d00b002d846374062mr3300610ljq.28.1712264865293; Thu, 04
 Apr 2024 14:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404123602.2369488-1-edumazet@google.com> <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
 <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
In-Reply-To: <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Apr 2024 17:07:32 -0400
Message-ID: <CABBYNZK08zDX07N9BTcFku=RSzc=W_74K2n2ky5f+qSexSLM+g@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: validate setsockopt( BT_PKT_STATUS /
 BT_DEFER_SETUP) user input
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, Apr 4, 2024 at 3:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Apr 4, 2024 at 8:31=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Eric,
> >
> > On Thu, Apr 4, 2024 at 8:36=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > syzbot reported sco_sock_setsockopt() is copying data without
> > > checking user input length.
> > >
> > >  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/l=
inux/sockptr.h:49 [inline]
> > >  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/so=
ckptr.h:55 [inline]
> > >  BUG: KASAN: slab-out-of-bounds in sco_sock_setsockopt+0xc0b/0xf90 ne=
t/bluetooth/sco.c:893
> > > Read of size 4 at addr ffff88805f7b15a3 by task syz-executor.5/12578
> > >
> > > CPU: 1 PID: 12578 Comm: syz-executor.5 Not tainted 6.8.0-syzkaller-08=
951-gfe46a7dd189e #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 03/27/2024
> > > Call Trace:
> > >  <TASK>
> > >   __dump_stack lib/dump_stack.c:88 [inline]
> > >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > >   print_address_description mm/kasan/report.c:377 [inline]
> > >   print_report+0x169/0x550 mm/kasan/report.c:488
> > >   kasan_report+0x143/0x180 mm/kasan/report.c:601
> > >   copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
> > >   copy_from_sockptr include/linux/sockptr.h:55 [inline]
> > >   sco_sock_setsockopt+0xc0b/0xf90 net/bluetooth/sco.c:893
> > >   do_sock_setsockopt+0x3b1/0x720 net/socket.c:2311
> > >   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> > >   __do_sys_setsockopt net/socket.c:2343 [inline]
> > >   __se_sys_setsockopt net/socket.c:2340 [inline]
> > >   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> > >  do_syscall_64+0xfd/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > RIP: 0033:0x7f3c2487dde9
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f3c256b40c8 EFLAGS: 00000246 ORIG_RAX: 000000000000003=
6
> > > RAX: ffffffffffffffda RBX: 00007f3c249abf80 RCX: 00007f3c2487dde9
> > > RDX: 0000000000000010 RSI: 0000000000000112 RDI: 0000000000000008
> > > RBP: 00007f3c248ca47a R08: 0000000000000002 R09: 0000000000000000
> > > R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 000000000000004d R14: 00007f3c249abf80 R15: 00007fff5dcf4978
> > >  </TASK>
> > >
> > > Allocated by task 12578:
> > >   kasan_save_stack mm/kasan/common.c:47 [inline]
> > >   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> > >   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
> > >   kasan_kmalloc include/linux/kasan.h:211 [inline]
> > >   __do_kmalloc_node mm/slub.c:3966 [inline]
> > >   __kmalloc+0x233/0x4a0 mm/slub.c:3979
> > >   kmalloc include/linux/slab.h:632 [inline]
> > >   __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c=
:1869
> > >   do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
> > >   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> > >   __do_sys_setsockopt net/socket.c:2343 [inline]
> > >   __se_sys_setsockopt net/socket.c:2340 [inline]
> > >   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> > >  do_syscall_64+0xfd/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > The buggy address belongs to the object at ffff88805f7b15a0
> > >  which belongs to the cache kmalloc-8 of size 8
> > > The buggy address is located 1 bytes to the right of
> > >  allocated 2-byte region [ffff88805f7b15a0, ffff88805f7b15a2)
> > >
> > > The buggy address belongs to the physical page:
> > > page:ffffea00017dec40 refcount:1 mapcount:0 mapping:0000000000000000 =
index:0x0 pfn:0x5f7b1
> > > flags: 0xfff00000000800(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > > page_type: 0xffffffff()
> > > raw: 00fff00000000800 ffff888014c41280 ffffea0000a26d80 dead000000000=
002
> > > raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000=
000
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12=
cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5091, tgid 5091 (syz-execut=
or.3), ts 75758857522, free_ts 75730585588
> > >   set_page_owner include/linux/page_owner.h:31 [inline]
> > >   post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
> > >   prep_new_page mm/page_alloc.c:1540 [inline]
> > >   get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
> > >   __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
> > >   __alloc_pages_node include/linux/gfp.h:238 [inline]
> > >   alloc_pages_node include/linux/gfp.h:261 [inline]
> > >   alloc_slab_page+0x5f/0x160 mm/slub.c:2175
> > >   allocate_slab mm/slub.c:2338 [inline]
> > >   new_slab+0x84/0x2f0 mm/slub.c:2391
> > >   ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
> > >   __slab_alloc mm/slub.c:3610 [inline]
> > >   __slab_alloc_node mm/slub.c:3663 [inline]
> > >   slab_alloc_node mm/slub.c:3835 [inline]
> > >   __do_kmalloc_node mm/slub.c:3965 [inline]
> > >   __kmalloc_node_track_caller+0x2d6/0x4e0 mm/slub.c:3986
> > >   kstrdup+0x3a/0x80 mm/util.c:62
> > >   __kernfs_new_node+0x9d/0x880 fs/kernfs/dir.c:611
> > >   kernfs_new_node+0x13a/0x240 fs/kernfs/dir.c:691
> > >   kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1052
> > >   sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
> > >   create_dir lib/kobject.c:73 [inline]
> > >   kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
> > >   kobject_add_varg lib/kobject.c:374 [inline]
> > >   kobject_init_and_add+0x124/0x190 lib/kobject.c:457
> > >   netdev_queue_add_kobject net/core/net-sysfs.c:1786 [inline]
> > >   netdev_queue_update_kobjects+0x1ee/0x5f0 net/core/net-sysfs.c:1838
> > >   register_queue_kobjects net/core/net-sysfs.c:1900 [inline]
> > >   netdev_register_kobject+0x265/0x320 net/core/net-sysfs.c:2140
> > > page last free pid 5103 tgid 5103 stack trace:
> > >   reset_page_owner include/linux/page_owner.h:24 [inline]
> > >   free_pages_prepare mm/page_alloc.c:1140 [inline]
> > >   free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
> > >   free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2532
> > >   release_pages+0x2744/0x2a80 mm/swap.c:1042
> > >   tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
> > >   tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
> > >   tlb_flush_mmu+0x34d/0x4e0 mm/mmu_gather.c:300
> > >   tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:392
> > >   exit_mmap+0x4b6/0xd40 mm/mmap.c:3300
> > >   __mmput+0x115/0x3c0 kernel/fork.c:1345
> > >   exit_mm+0x220/0x310 kernel/exit.c:569
> > >   do_exit+0x99e/0x27e0 kernel/exit.c:865
> > >   do_group_exit+0x207/0x2c0 kernel/exit.c:1027
> > >   __do_sys_exit_group kernel/exit.c:1038 [inline]
> > >   __se_sys_exit_group kernel/exit.c:1036 [inline]
> > >   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
> > >  do_syscall_64+0xfd/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > Memory state around the buggy address:
> > >  ffff88805f7b1480: 05 fc fc fc 05 fc fc fc fa fc fc fc 05 fc fc fc
> > >  ffff88805f7b1500: 05 fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
> > > >ffff88805f7b1580: 04 fc fc fc 02 fc fc fc fa fc fc fc 05 fc fc fc
> > >                                ^
> > >  ffff88805f7b1600: fa fc fc fc 05 fc fc fc fa fc fc fc 05 fc fc fc
> > >  ffff88805f7b1680: 05 fc fc fc 05 fc fc fc 00 fc fc fc fa fc fc fc
> > >
> > > Fixes: 00398e1d5183 ("Bluetooth: Add support for BT_PKT_STATUS CMSG d=
ata for SCO connections")
> > > Fixes: b96e9c671b05 ("Bluetooth: Add BT_DEFER_SETUP option to sco soc=
ket")
> > > Reported-by: syzbot <syzkaller@googlegroups.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com> (supporter:BLUETOOT=
H SUBSYSTEM)
> > > Cc: linux-bluetooth@vger.kernel.org
> > > ---
> > >  net/bluetooth/sco.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > index 43daf965a01e4ac5c9329150080b00dcd63c7e1c..9d013f01865fd2509f28e=
ac3bceadf682f0a5edb 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -843,6 +843,10 @@ static int sco_sock_setsockopt(struct socket *so=
ck, int level, int optname,
> > >                         break;
> > >                 }
> > >
> > > +               if (optlen < sizeof(u32)) {
> > > +                       err =3D -EINVAL;
> > > +                       break;
> > > +               }
> >
> > Usually we deal with this sort of problem by doing len =3D
> > min_t(unsigned int, sizeof(u32), optlen) so we truncate the value if
> > smaller, perhaps it would be better to have a helper function that
> > does len check internally.
>
> Well, what happens if user provided optlen =3D=3D 1 ?
>
> opt would then contain 24 bits of garbage.

We might need to do a memset so if userspace just send one byte that
would still work, not that are actually doing memset right now so you
are right that in that respect it is still broken since it accessing
uninitialized value which perhaps is not triggering any build errors
but I wonder if we should attempt to fix that as well.

--=20
Luiz Augusto von Dentz

