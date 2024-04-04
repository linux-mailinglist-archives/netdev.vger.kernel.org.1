Return-Path: <netdev+bounces-85013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61389898F91
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 22:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8EB1F237AD
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02013777D;
	Thu,  4 Apr 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeGXMVLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B21332A1
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262462; cv=none; b=OPCEVhNMU2C+OUkX8zMuTZPjMh3Ki0kS8YQCIbZn+p8nyhnsw2EC5e6xRySlg3LjuHfG4zD3LiSo37Zq7bLfrmzTrxMy6nj0vO0RcIjZK+CMC9tluudXDpUtcQAjje8UrlRvzVqe7m5mnKafKsDOy5OsTuIhlIU3VSPx5sBBxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262462; c=relaxed/simple;
	bh=jnYnc9fQiqTmQLr667aj2yTZQgalzNe6PFEVgGL4JCw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ouLz74MaJJiL00bl7umk3J9gLCCYYC/QABkMIwfw1JIsEDbYsL7kVB0yzoQL3W7DJkCRALWB/djfw+Wj2hUVvvJ9NMUgnviHdRTgrobtl1SONXiPezfUmSlAxnJoxIzLfhgDhIjzxHYSeyqewe5pytb26I2zqY9AZAft0HDfveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeGXMVLb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so22618927b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712262460; x=1712867260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HS7xvLLouAUDC8YTZsz0MgD+VCfep0tJs8jMsbn1Dc4=;
        b=jeGXMVLboLz7qkAEQhkiX98uhNb/VMA/c+tFaCbyk7gigMiVKFRoiu06TPr8rFBPSi
         rZU5bJGn+t8QEahjYy+veGgaXr8lsM3nq6KnC7BtVst9kg5lzRcRRh0NdMPZNG0pmR7p
         tf2YnwTzBK00aWzoKCqNGtO4D+h7fMP37fGjQypcDZCxQD+lTSGPy3jLG1Q2JkUdtJQE
         bwqaRfxiX6wGxeAQ1qT7yODQ5WFPbnQnculH36WhJX1iV1mw699AtF6daKtgI76Z9N1g
         qebkD33Z7ne+6CM9DmErw19+jQ6xkBfCpnrxvCgxTUx0lHdK/WNyPgX3Gj+Cx3ASi5vF
         6DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712262460; x=1712867260;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS7xvLLouAUDC8YTZsz0MgD+VCfep0tJs8jMsbn1Dc4=;
        b=ugIRvcpTKMk3zd9p9dXfCRm5x06oKBVIv/qHmBcGO0V9b6CnIc+yu/2dUIkr8FPQ6V
         zEtkH0dozi/R3bXPUk4LmWGnLaB/eKLA7M16E/sZECMg08MnzW2TUyBpNQsFkRaTIqaL
         wTdmeOLmSSUbsraLsPGgzpkNr3Zb4IXGxVm5HpImSzZp0I/2/wawAIJ1DpdMbi9d6XCl
         nNRv+lhzr5l3Y/VZzlV67Jk27jguNrVqQ0ZcAAo1zpwc3SoIttupTfImXXuhF2RPP45Q
         eTZ4PV+lnm699NfYCinogghlGmpNh7IYYIr3SNCiJEdd6gL7ABm+lZTVygiDUkECDWiW
         RODQ==
X-Gm-Message-State: AOJu0YxFE0VNDHkEjWmShoQ6P6/IqLkowl1JvXdgT9zrgT7Q1ziL54Xu
	7LNd5FVRcyxcyGqLJtgPi/rzwnmS92xZJ5wbU+Bm9xPm70wL7k+J7CtcctnR17i5r6NpoKDxiW2
	4pfdkFOMIGQ==
X-Google-Smtp-Source: AGHT+IHkvbcMA+i+fihLFGd/m7QttznHQJmzRO+onCACyZBH1ypC1tLYy6/t/7kmcDLQAVOOMScsdLLYVnZL/A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18c4:b0:dc6:d1d7:d03e with SMTP
 id ck4-20020a05690218c400b00dc6d1d7d03emr68019ybb.8.1712262460096; Thu, 04
 Apr 2024 13:27:40 -0700 (PDT)
Date: Thu,  4 Apr 2024 20:27:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404202738.3634547-1-edumazet@google.com>
Subject: [PATCH net] xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot reported an illegal copy in xsk_setsockopt() [1]

Make sure to validate setsockopt() @optlen parameter.

[1]

 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/s=
ockptr.h:49 [inline]
 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.=
h:55 [inline]
 BUG: KASAN: slab-out-of-bounds in xsk_setsockopt+0x909/0xa40 net/xdp/xsk.c=
:1420
Read of size 4 at addr ffff888028c6cde3 by task syz-executor.0/7549

CPU: 0 PID: 7549 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe=
46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 03/27/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
  copy_from_sockptr include/linux/sockptr.h:55 [inline]
  xsk_setsockopt+0x909/0xa40 net/xdp/xsk.c:1420
  do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fb40587de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb40665a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fb4059abf80 RCX: 00007fb40587de69
RDX: 0000000000000005 RSI: 000000000000011b RDI: 0000000000000006
RBP: 00007fb4058ca47a R08: 0000000000000002 R09: 0000000000000000
R10: 0000000020001980 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb4059abf80 R15: 00007fff57ee4d08
 </TASK>

Allocated by task 7549:
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
  kasan_kmalloc include/linux/kasan.h:211 [inline]
  __do_kmalloc_node mm/slub.c:3966 [inline]
  __kmalloc+0x233/0x4a0 mm/slub.c:3979
  kmalloc include/linux/slab.h:632 [inline]
  __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
  do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff888028c6cde0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff888028c6cde0, ffff888028c6cde2)

The buggy address belongs to the physical page:
page:ffffea0000a31b00 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0xffff888028c6c9c0 pfn:0x28c6c
anon flags: 0xfff00000000800(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41280 0000000000000000 dead000000000001
raw: ffff888028c6c9c0 0000000080800057 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(G=
FP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 6648, tgid 6644 (syz-executor.0), =
ts 133906047828, free_ts 133859922223
  set_page_owner include/linux/page_owner.h:31 [inline]
  post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
  prep_new_page mm/page_alloc.c:1540 [inline]
  get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
  __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
  __alloc_pages_node include/linux/gfp.h:238 [inline]
  alloc_pages_node include/linux/gfp.h:261 [inline]
  alloc_slab_page+0x5f/0x160 mm/slub.c:2175
  allocate_slab mm/slub.c:2338 [inline]
  new_slab+0x84/0x2f0 mm/slub.c:2391
  ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
  __slab_alloc mm/slub.c:3610 [inline]
  __slab_alloc_node mm/slub.c:3663 [inline]
  slab_alloc_node mm/slub.c:3835 [inline]
  __do_kmalloc_node mm/slub.c:3965 [inline]
  __kmalloc_node+0x2db/0x4e0 mm/slub.c:3973
  kmalloc_node include/linux/slab.h:648 [inline]
  __vmalloc_area_node mm/vmalloc.c:3197 [inline]
  __vmalloc_node_range+0x5f9/0x14a0 mm/vmalloc.c:3392
  __vmalloc_node mm/vmalloc.c:3457 [inline]
  vzalloc+0x79/0x90 mm/vmalloc.c:3530
  bpf_check+0x260/0x19010 kernel/bpf/verifier.c:21162
  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 6650 tgid 6647 stack trace:
  reset_page_owner include/linux/page_owner.h:24 [inline]
  free_pages_prepare mm/page_alloc.c:1140 [inline]
  free_unref_page_prepare+0x95d/0xa80 mm/page_alloc.c:2346
  free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2532
  release_pages+0x2117/0x2400 mm/swap.c:1042
  tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
  tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
  tlb_flush_mmu+0x34d/0x4e0 mm/mmu_gather.c:300
  tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:392
  exit_mmap+0x4b6/0xd40 mm/mmap.c:3300
  __mmput+0x115/0x3c0 kernel/fork.c:1345
  exit_mm+0x220/0x310 kernel/exit.c:569
  do_exit+0x99e/0x27e0 kernel/exit.c:865
  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
  get_signal+0x176e/0x1850 kernel/signal.c:2907
  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
  exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
  __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
  syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:212
  do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffff888028c6cc80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff888028c6cd00: fa fc fc fc fa fc fc fc 00 fc fc fc 06 fc fc fc
>ffff888028c6cd80: fa fc fc fc fa fc fc fc fa fc fc fc 02 fc fc fc
                                                       ^
 ffff888028c6ce00: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff888028c6ce80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc

Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Bj=C3=B6rn T=C3=B6pel" <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: bpf@vger.kernel.org
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3404d076a8a3e6a9f43dfca301d3e00078afb934..727aa20be4bde8dc63a544a44a5=
cdeb19cac7dcb 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1417,6 +1417,8 @@ static int xsk_setsockopt(struct socket *sock, int le=
vel, int optname,
 		struct xsk_queue **q;
 		int entries;
=20
+		if (optlen < sizeof(entries))
+			return -EINVAL;
 		if (copy_from_sockptr(&entries, optval, sizeof(entries)))
 			return -EFAULT;
=20
--=20
2.44.0.478.gd926399ef9-goog


