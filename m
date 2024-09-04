Return-Path: <netdev+bounces-125169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2F96C289
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB0B1C21AC0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43C1DCB09;
	Wed,  4 Sep 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpwMVFfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1A1DA620
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463976; cv=none; b=kVDqtrMKRno02FaxP1HG8G4F++hyB2AIYGL6SC8vo5uF5Mvrhc+zyHM4EsmDQfls7XURrAN1RAbOzyZe1PdBCwZdXbCQpyuJm7EHifd05zinbByJSa/xWzcnUXxvMrfRJSJTdAYsUJUD8m4HuhDABuZSKxDKJ33eHk1+nUOim84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463976; c=relaxed/simple;
	bh=L2CxG4uSXLFjPz6ojyIYyKdahKnRcDqOBb2XNahmM5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEmiRKMtW4QfHBamuD8mNRcf60xL50pTQqLTKard8ZP1IJiFyG09tCQssfboWrhZNOp5bVsusra9d1kmoBW2G4lPtbKjuc+g+Tinyr+5n8n36uQVLB2J80fZjf1+2mhhBYXHRFUuRNTIM3SMOo9Cih3cLt3Oh9J4vv+IKRwFvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpwMVFfB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5356ab89665so442863e87.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725463971; x=1726068771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b3Ig2Hog+Y/V6WlZWEgPgpsrW3qHKomzY9wB6HePvc=;
        b=CpwMVFfBX9vl1G60JD7BiZtIYFqsBEPvYCY/L0kXoGA/hpMOX2moETUWwypwg5ifwV
         /MLjp7kvwq/UPYZXpYCUYVWlifJKE+I5NfrzESnobe2rkQRv+6CODPtdZ9fT5qQ3xOEv
         1BrREzA+Ras9snYIq735Bx2z6Qou2PZAaSQ3yOXVdEJll6MBpSdZjE49WVxmthJ50TB8
         bz9qx4BiKEzKuqdYkApnL1KT9vWUlfGIepOuhOcUkbbYGvupirswMMlIQhZLbs0Z+rPJ
         tqC4kRzlMsxkx5sF9n6+Y5Da8X8x8sTVcPuz1ksFA3wZIZSxSKCt9n6VfZNaENe+Y4AO
         I8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463971; x=1726068771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1b3Ig2Hog+Y/V6WlZWEgPgpsrW3qHKomzY9wB6HePvc=;
        b=AJzk9E4HUjmcJ3y6c5oFbfquAql/eUg7Sz/HFR24tZciC/f055loiLsLhakV/Dgk4J
         dkbPvxad5EBRJ53f1lAAapyvbq1Qw8vIcdrf5PbYRB7iWw2EiLjngzmC0NkMkofOuWcC
         4DHJGTre2F5CMmV7ubHm5kw28iUOieUQJbR9V8dF8M7grt1yxIY1EIANfQLRhdmzhXHE
         hReIDxjskPCQMuTh3Xa8wkbbQ8nxVNV78H9kXp4Ii0K433zua6lXx/jZqigbvl6AJ8RQ
         3vZHvr/GEh1tNGDal+nADUd1/XgntpmTyXwiioOlL1773NKLtPrm0DE6PjjCSPUJvOzo
         Hlpw==
X-Forwarded-Encrypted: i=1; AJvYcCWzCtHsejVp2vXwZdBK0tmMjmCsenbwh0dIZ01CLm3DSskbiJWBBNJEvN9wS+Qva42d6NDbATY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCe7GU2mB1kaghWnKerRiNPl0/ixmY5svCZ1pFXGSlHb31P12E
	W8BliK6Z1GSBX6qdDLasDnki4O+x1PHGR8qinJhX+EKH/3gQNkFYKWc2foApSwfyKSQLF7+aVOg
	H+V4s/BYc300XLaqj+i6Vqwp/Vgo11f8IMRYB
X-Google-Smtp-Source: AGHT+IE2X9ISx84xTY816bRxYCEkZj0kJKXRG56mLLLtdoDhYXq9GLpG5LVugUSQzfhxqYrypcSMfZkhhoSrIkut8Tw=
X-Received: by 2002:a05:6512:2387:b0:533:4656:d503 with SMTP id
 2adb3069b0e04-53546b92e32mr12626396e87.37.1725463970387; Wed, 04 Sep 2024
 08:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000083b05a06214c9ddc@google.com>
In-Reply-To: <00000000000083b05a06214c9ddc@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 17:32:39 +0200
Message-ID: <CANn89iKt9Z7rOecB_6SgcqHOMOqhAen6_+eE0=Sc9873rrqXzg@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>, 
	Rao Shoaib <rao.shoaib@oracle.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:13=E2=80=AFPM syzbot
<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fbdaffe41adc Merge branch 'am-qt2025-phy-rust'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13d7c44d98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D996585887acda=
db3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8811381d455e3e9=
ec788
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14b395db980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16d3fc5398000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/feaa1b13b490/dis=
k-fbdaffe4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8e5dccd0377a/vmlinu=
x-fbdaffe4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/75151f74f4c9/b=
zImage-fbdaffe4.xz
>
> Bisection is inconclusive: the first bad commit could be any of:
>
> 06ab21c3cb6e dt-bindings: net: mediatek,net: add top-level constraints
> 70d16e13368c dt-bindings: net: renesas,etheravb: add top-level constraint=
s
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11d42e6398=
0000
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0xa6/0xb0 net/u=
nix/af_unix.c:2959
> Read of size 4 at addr ffff8880326abcc4 by task syz-executor178/5235
>
> CPU: 0 UID: 0 PID: 5235 Comm: syz-executor178 Not tainted 6.11.0-rc5-syzk=
aller-00742-gfbdaffe41adc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
>  unix_stream_recv_urg+0x1df/0x320 net/unix/af_unix.c:2640
>  unix_stream_read_generic+0x2456/0x2520 net/unix/af_unix.c:2778
>  unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
>  sock_recvmsg_nosec net/socket.c:1046 [inline]
>  sock_recvmsg+0x22f/0x280 net/socket.c:1068
>  ____sys_recvmsg+0x1db/0x470 net/socket.c:2816
>  ___sys_recvmsg net/socket.c:2858 [inline]
>  __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2888
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5360d6b4e9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff29b3a458 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
> RAX: ffffffffffffffda RBX: 00007fff29b3a638 RCX: 00007f5360d6b4e9
> RDX: 0000000000002001 RSI: 0000000020000640 RDI: 0000000000000003
> RBP: 00007f5360dde610 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff29b3a628 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>
> Allocated by task 5235:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:312 [inline]
>  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3988 [inline]
>  slab_alloc_node mm/slub.c:4037 [inline]
>  kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
>  __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
>  alloc_skb include/linux/skbuff.h:1320 [inline]
>  alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6528
>  sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
>  sock_alloc_send_skb include/net/sock.h:1778 [inline]
>  queue_oob+0x108/0x680 net/unix/af_unix.c:2198
>  unix_stream_sendmsg+0xd24/0xf80 net/unix/af_unix.c:2351
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
>  ___sys_sendmsg net/socket.c:2651 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 5235:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2252 [inline]
>  slab_free mm/slub.c:4473 [inline]
>  kmem_cache_free+0x145/0x350 mm/slub.c:4548
>  unix_stream_read_generic+0x1ef6/0x2520 net/unix/af_unix.c:2917
>  unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
>  sock_recvmsg_nosec net/socket.c:1046 [inline]
>  sock_recvmsg+0x22f/0x280 net/socket.c:1068
>  __sys_recvfrom+0x256/0x3e0 net/socket.c:2255
>  __do_sys_recvfrom net/socket.c:2273 [inline]
>  __se_sys_recvfrom net/socket.c:2269 [inline]
>  __x64_sys_recvfrom+0xde/0x100 net/socket.c:2269
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff8880326abc80
>  which belongs to the cache skbuff_head_cache of size 240
> The buggy address is located 68 bytes inside of
>  freed 240-byte region [ffff8880326abc80, ffff8880326abd70)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x326a=
b
> ksm flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xfdffffff(slab)
> raw: 00fff00000000000 ffff88801eaee780 ffffea0000b7dc80 dead000000000003
> raw: 0000000000000000 00000000800c000c 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(=
GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4686, tgid 4686 (ude=
vadm), ts 32357469485, free_ts 28829011109
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
>  prep_new_page mm/page_alloc.c:1501 [inline]
>  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2321
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2484
>  new_slab mm/slub.c:2537 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
>  __slab_alloc+0x58/0xa0 mm/slub.c:3813
>  __slab_alloc_node mm/slub.c:3866 [inline]
>  slab_alloc_node mm/slub.c:4025 [inline]
>  kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4080
>  __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
>  alloc_skb include/linux/skbuff.h:1320 [inline]
>  alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
>  uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
>  kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
>  kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
>  kobject_synth_uevent+0x4ef/0xae0 lib/kobject_uevent.c:207
>  uevent_store+0x4b/0x70 drivers/base/bus.c:633
>  kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
> page last free pid 1 tgid 1 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1094 [inline]
>  free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
>  kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:408
>  apply_to_pte_range mm/memory.c:2797 [inline]
>  apply_to_pmd_range mm/memory.c:2841 [inline]
>  apply_to_pud_range mm/memory.c:2877 [inline]
>  apply_to_p4d_range mm/memory.c:2913 [inline]
>  __apply_to_page_range+0x8a8/0xe50 mm/memory.c:2947
>  kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:525
>  purge_vmap_node+0x3e3/0x770 mm/vmalloc.c:2208
>  __purge_vmap_area_lazy+0x708/0xae0 mm/vmalloc.c:2290
>  _vm_unmap_aliases+0x79d/0x840 mm/vmalloc.c:2885
>  change_page_attr_set_clr+0x2fe/0xdb0 arch/x86/mm/pat/set_memory.c:1881
>  change_page_attr_set arch/x86/mm/pat/set_memory.c:1922 [inline]
>  set_memory_nx+0xf2/0x130 arch/x86/mm/pat/set_memory.c:2110
>  free_init_pages arch/x86/mm/init.c:924 [inline]
>  free_kernel_image_pages arch/x86/mm/init.c:943 [inline]
>  free_initmem+0x79/0x110 arch/x86/mm/init.c:970
>  kernel_init+0x31/0x2b0 init/main.c:1476
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Memory state around the buggy address:
>  ffff8880326abb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880326abc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
> >ffff8880326abc80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                            ^
>  ffff8880326abd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>  ffff8880326abd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup


Another af_unix OOB issue.

Rao can you take a look ?

Thanks.

