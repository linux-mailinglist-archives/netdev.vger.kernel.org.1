Return-Path: <netdev+bounces-118969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB19953B45
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B10FB241E6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8A13B29F;
	Thu, 15 Aug 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ELLoNH7p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B13D984;
	Thu, 15 Aug 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752274; cv=none; b=QM2zHlNPbPHtWnD1WdNPd9shqgfp6eKlVJkE3Juzg3LqHN5W6BSMpYhmyePLYDqHcItgikPvEKaM7HAckHZdPaeN9unsv1k3aFyxT6WIu9KWnKhK6iefdnLZSx1KpVlBrDuNIlvSt/+bRhTi4BkDyiDaQ1JiPMGoWpt09zo2ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752274; c=relaxed/simple;
	bh=T7Af5Z8FPdh1Ky+qGwNoMQo1OXS2Xww8z6aUJ0cMIY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b82z9V/P/GP/QBY8r75Jxkfc/LoMp7ezw6W6GwKkHhhFq0Cl4Ynotsf/QOHxpYjEmQREaIJLlzr0VZd+WcVQaruFEymHnXP8VljgfhdF4xaLUUG/xfOd7DbS9P033/iWEgR5fVaD0x3+oNvGnlHw119m6VBRF89Dei2BLBbSXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ELLoNH7p; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723752272; x=1755288272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAN/GfutCegf685uHhUm8z5Pz+egyuFA5+K7wbX+YsA=;
  b=ELLoNH7p2aL9nTcvPnEKs103J8hY+vrF4bBByKq1pRrwDMnlZrLZIR3p
   MbVFN4ROW4PSxT7p7NpBn/27V72bzC/B7jkn+0WUfPaLuJgfJrWajSzwu
   XKrOyid5R+EyzvhrWe++GLi7Pefr+rKKAxQUS3ibypDOFhNOMD1YqN9Ox
   A=;
X-IronPort-AV: E=Sophos;i="6.10,149,1719878400"; 
   d="scan'208";a="115932591"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:04:30 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:30877]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.141:2525] with esmtp (Farcaster)
 id ed4652e0-1971-4e04-a0f4-adda3480de67; Thu, 15 Aug 2024 20:04:30 +0000 (UTC)
X-Farcaster-Flow-ID: ed4652e0-1971-4e04-a0f4-adda3480de67
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 20:04:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 20:04:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in kcm_release
Date: Thu, 15 Aug 2024 13:04:18 -0700
Message-ID: <20240815200418.44944-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000fe2e920617dfdafb@google.com>
References: <000000000000fe2e920617dfdafb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>
Date: Tue, 07 May 2024 09:41:19 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9abbc24128bc Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d93522180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
> dashboard link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11839322180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13010a54180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce13ec3ed5ad/disk-9abbc241.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/256cbd314121/vmlinux-9abbc241.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0af86fb52109/Image-9abbc241.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __skb_unlink include/linux/skbuff.h:2366 [inline]
> BUG: KASAN: slab-use-after-free in __skb_dequeue include/linux/skbuff.h:2385 [inline]
> BUG: KASAN: slab-use-after-free in __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
> BUG: KASAN: slab-use-after-free in __skb_queue_purge include/linux/skbuff.h:3181 [inline]
> BUG: KASAN: slab-use-after-free in kcm_release+0x170/0x4c8 net/kcm/kcmsock.c:1691
> Read of size 8 at addr ffff0000ced0fc80 by task syz-executor329/6167
> 
> CPU: 1 PID: 6167 Comm: syz-executor329 Tainted: G    B              6.8.0-rc5-syzkaller-g9abbc24128bc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Call trace:
>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x178/0x518 mm/kasan/report.c:488
>  kasan_report+0xd8/0x138 mm/kasan/report.c:601
>  __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
>  __skb_unlink include/linux/skbuff.h:2366 [inline]
>  __skb_dequeue include/linux/skbuff.h:2385 [inline]
>  __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
>  __skb_queue_purge include/linux/skbuff.h:3181 [inline]
>  kcm_release+0x170/0x4c8 net/kcm/kcmsock.c:1691
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xa4/0x1e8 net/socket.c:1421
>  __fput+0x30c/0x738 fs/file_table.c:376
>  ____fput+0x20/0x30 fs/file_table.c:404
>  task_work_run+0x230/0x2e0 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x618/0x1f64 kernel/exit.c:871
>  do_group_exit+0x194/0x22c kernel/exit.c:1020
>  get_signal+0x1500/0x15ec kernel/signal.c:2893
>  do_signal+0x23c/0x3b44 arch/arm64/kernel/signal.c:1249
>  do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> 
> Allocated by task 6166:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x40/0x78 mm/kasan/common.c:68
>  kasan_save_alloc_info+0x70/0x84 mm/kasan/generic.c:626
>  unpoison_slab_object mm/kasan/common.c:314 [inline]
>  __kasan_slab_alloc+0x74/0x8c mm/kasan/common.c:340
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3813 [inline]
>  slab_alloc_node mm/slub.c:3860 [inline]
>  kmem_cache_alloc_node+0x204/0x4c0 mm/slub.c:3903
>  __alloc_skb+0x19c/0x3d8 net/core/skbuff.c:641
>  alloc_skb include/linux/skbuff.h:1296 [inline]
>  kcm_sendmsg+0x1d3c/0x2124 net/kcm/kcmsock.c:783
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  sock_sendmsg+0x220/0x2c0 net/socket.c:768
>  splice_to_socket+0x7cc/0xd58 fs/splice.c:889
>  do_splice_from fs/splice.c:941 [inline]
>  direct_splice_actor+0xec/0x1d8 fs/splice.c:1164
>  splice_direct_to_actor+0x438/0xa0c fs/splice.c:1108
>  do_splice_direct_actor fs/splice.c:1207 [inline]
>  do_splice_direct+0x1e4/0x304 fs/splice.c:1233
>  do_sendfile+0x460/0xb3c fs/read_write.c:1295
>  __do_sys_sendfile64 fs/read_write.c:1362 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1348 [inline]
>  __arm64_sys_sendfile64+0x160/0x3b4 fs/read_write.c:1348
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> 
> Freed by task 6167:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x40/0x78 mm/kasan/common.c:68
>  kasan_save_free_info+0x5c/0x74 mm/kasan/generic.c:640
>  poison_slab_object+0x124/0x18c mm/kasan/common.c:241
>  __kasan_slab_free+0x3c/0x78 mm/kasan/common.c:257
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2121 [inline]
>  slab_free mm/slub.c:4299 [inline]
>  kmem_cache_free+0x15c/0x3d4 mm/slub.c:4363
>  kfree_skbmem+0x10c/0x19c
>  __kfree_skb net/core/skbuff.c:1109 [inline]
>  kfree_skb_reason+0x240/0x6f4 net/core/skbuff.c:1144
>  kfree_skb include/linux/skbuff.h:1244 [inline]
>  kcm_release+0x104/0x4c8 net/kcm/kcmsock.c:1685
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xa4/0x1e8 net/socket.c:1421
>  __fput+0x30c/0x738 fs/file_table.c:376
>  ____fput+0x20/0x30 fs/file_table.c:404
>  task_work_run+0x230/0x2e0 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x618/0x1f64 kernel/exit.c:871
>  do_group_exit+0x194/0x22c kernel/exit.c:1020
>  get_signal+0x1500/0x15ec kernel/signal.c:2893
>  do_signal+0x23c/0x3b44 arch/arm64/kernel/signal.c:1249
>  do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> 
> The buggy address belongs to the object at ffff0000ced0fc80
>  which belongs to the cache skbuff_head_cache of size 240
> The buggy address is located 0 bytes inside of
>  freed 240-byte region [ffff0000ced0fc80, ffff0000ced0fd70)
> 
> The buggy address belongs to the physical page:
> page:00000000d35f4ae4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10ed0f
> flags: 0x5ffc00000000800(slab|node=0|zone=2|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 05ffc00000000800 ffff0000c1cbf640 fffffdffc3423100 dead000000000004
> raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff0000ced0fb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff0000ced0fc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
> >ffff0000ced0fc80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff0000ced0fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>  ffff0000ced0fd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> ==================================================================
> Unable to handle kernel paging request at virtual address dfff800000000001
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000001] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 6167 Comm: syz-executor329 Tainted: G    B              6.8.0-rc5-syzkaller-g9abbc24128bc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __skb_unlink include/linux/skbuff.h:2369 [inline]
> pc : __skb_dequeue include/linux/skbuff.h:2385 [inline]
> pc : __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
> pc : __skb_queue_purge include/linux/skbuff.h:3181 [inline]
> pc : kcm_release+0x1a4/0x4c8 net/kcm/kcmsock.c:1691
> lr : __skb_unlink include/linux/skbuff.h:2368 [inline]
> lr : __skb_dequeue include/linux/skbuff.h:2385 [inline]
> lr : __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
> lr : __skb_queue_purge include/linux/skbuff.h:3181 [inline]
> lr : kcm_release+0x1a0/0x4c8 net/kcm/kcmsock.c:1691
> sp : ffff800097a775e0
> x29: ffff800097a77600 x28: 1fffe0001b4b0051 x27: 1fffe0001b4b0053
> x26: dfff800000000000 x25: 0000000000000008 x24: 02a800ec00001817
> x23: ffff0000ced0fc80 x22: ffff0000da580298 x21: ffff0000da580288
> x20: ffff0000da580000 x19: 0000000000000000 x18: 1fffe00036804796
> x17: ffff80008ec8d000 x16: ffff80008ac97900 x15: ffff600019da1f90
> x14: 1fffe00019da1f90 x13: 00000000000000fa x12: fffffffffffffffe
> x11: ffff600019da1f90 x10: 1fffe00019da1f91 x9 : ffff800093475840
> x8 : 0000000000000001 x7 : 0000000000000000 x6 : ffff800080297af0
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000010
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ced0fc80
> Call trace:
>  __skb_unlink include/linux/skbuff.h:2369 [inline]
>  __skb_dequeue include/linux/skbuff.h:2385 [inline]
>  __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
>  __skb_queue_purge include/linux/skbuff.h:3181 [inline]
>  kcm_release+0x1a4/0x4c8 net/kcm/kcmsock.c:1691
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xa4/0x1e8 net/socket.c:1421
>  __fput+0x30c/0x738 fs/file_table.c:376
>  ____fput+0x20/0x30 fs/file_table.c:404
>  task_work_run+0x230/0x2e0 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x618/0x1f64 kernel/exit.c:871
>  do_group_exit+0x194/0x22c kernel/exit.c:1020
>  get_signal+0x1500/0x15ec kernel/signal.c:2893
>  do_signal+0x23c/0x3b44 arch/arm64/kernel/signal.c:1249
>  do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> Code: f94006f8 91002279 9776b98f d343ff28 (387a6908) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	f94006f8 	ldr	x24, [x23, #8]
>    4:	91002279 	add	x25, x19, #0x8
>    8:	9776b98f 	bl	0xfffffffffddae644
>    c:	d343ff28 	lsr	x8, x25, #3
> * 10:	387a6908 	ldrb	w8, [x8, x26] <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD

diff --git a/include/net/kcm.h b/include/net/kcm.h
index 90279e5e09a5..441e993be634 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -70,6 +70,7 @@ struct kcm_sock {
 	struct work_struct tx_work;
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
+	struct mutex tx_mutex;
 	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2f191e50d4fc..d4118c796290 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -755,6 +755,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		  !(msg->msg_flags & MSG_MORE) : !!(msg->msg_flags & MSG_EOR);
 	int err = -EPIPE;
 
+	mutex_lock(&kcm->tx_mutex);
 	lock_sock(sk);
 
 	/* Per tcp_sendmsg this should be in poll */
@@ -926,6 +927,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	KCM_STATS_ADD(kcm->stats.tx_bytes, copied);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return copied;
 
 out_error:
@@ -951,6 +953,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		sk->sk_write_space(sk);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return err;
 }
 
@@ -1204,6 +1207,7 @@ static void init_kcm_sock(struct kcm_sock *kcm, struct kcm_mux *mux)
 	spin_unlock_bh(&mux->lock);
 
 	INIT_WORK(&kcm->tx_work, kcm_tx_work);
+	mutex_init(&kcm->tx_mutex);
 
 	spin_lock_bh(&mux->rx_lock);
 	kcm_rcv_ready(kcm);

