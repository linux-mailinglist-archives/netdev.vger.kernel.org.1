Return-Path: <netdev+bounces-84878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772EB89883F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD27B2E78E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F7126F02;
	Thu,  4 Apr 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTUGywXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B89763F4
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234846; cv=none; b=L9+fs9VAaYgJGRCdGjzJt5CyV0wA0QLEjKfl3MCldETai23MKefMcUXKOY2K/9yd8YWrexku3/UQPHR5vgoqfTZLFGRzCuA2PhEQKKNrh9KkA/qTz+a9ZIG2LfsN/RpSsklNQZ6C4Sg+jlOMT2mlW70SZXFezXYPH2XZQ+tG18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234846; c=relaxed/simple;
	bh=6vPwNnUm5wuszzwF3/evPWmXn7z7IG8kXOsBsz0DM3U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N9Vy3M8WIEuVP5VZFv2ePcEyVl6VCRWtKQdtRwdLLA9b3LFImMmO95N/Kl0SW+obd9WQVziooEbzK1eGqEDbNzpmPHrR9yr+DzyWK5vqz3R+m9hOUBSKtwivzwIu4iQ20kEH/3gHDrIxgP/X8bGr+TMAygzSpcdB1JeE7N7HqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTUGywXd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-617bd0cf61fso6830657b3.3
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712234844; x=1712839644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rdveWuoQPuCrzsfRXyCupWB141FzfSWpZKcqBv79Nsg=;
        b=tTUGywXdrvORw85yqzjXSxDRHkD5kbOx3QnaaOM5bm3KiL5O/ZPgcBG0p7W1iru+lX
         jshu+LNTu6VSmXQqonklkxPAIGvtHhuUy+6bcQVuxxH2aNR+LbhIkWdnIIJeaykWFq3O
         +fEtymQP1HYHtzaehHZmkbX+/W7U5llt9OYSV7ux/tYzw/wWo52txCzb0NTkF+n1jl3d
         dZaIgflqTXVI5ppzuQq8AdcqoIuYqwC3q7awXtJV8ywb+aYF6N3y+RucyLxrFcoaHc7V
         fpxMG/Nxs1nthWl8lifu6UcHmvYiObHYbrxoC8NlIN+V88GKWFpPZjCaEdVt6q0/ePEo
         pwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234844; x=1712839644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdveWuoQPuCrzsfRXyCupWB141FzfSWpZKcqBv79Nsg=;
        b=hhq8l985IKDMbalZxk5EhSSkaewaKB7/oX5GOwNj26aNXNepP5rXlvJwVQd6k9i++J
         C7i/VXkssu3CLhCYbvajM6HgF0aEpvf+20x0+0WIaKTgZAtBBdNpWOT7Nb44RRxyNtRn
         Zyhu15FP4JXvckqR2VIHL6tESwgNJGAPJlV60de0ck4lEgXLazUGeLCE2eGzV4cxLk/W
         tGUJJ5NP9C50Z+ufS9wCJWEF1u/ewRWksRcfk7E+0/VrCJosIECkfYZ3jMKGNnZV2B6X
         WJXcfp8v8GUWx3AFJX5uwx0LpdXop5EfV3RBk1YWFMNnA9vgy0bX7uZpOrxCYVP++wq0
         7H3w==
X-Gm-Message-State: AOJu0YyW+ar77Vr9V4d2bO3Wbj4VzJddjbUK8a7Pc4xA0llbIDubj9ep
	ZymjgFLPxBgGqntFJm11CJS/LZtAm0iqrnPUCBb+o5z21jBGzRh33WHjOT+Y0XQGwGjBusEeo6c
	xyS4jnPWtUQ==
X-Google-Smtp-Source: AGHT+IFO+JRVGYl9OmjhcAndcYTpXEYeF2mL/4Wm2MkAAZ0zDuz58o78Rrf+qKBgWVFdRGlqUDCS2zVr1f/u6g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102b:b0:dcc:6065:2b3d with SMTP
 id x11-20020a056902102b00b00dcc60652b3dmr607745ybt.8.1712234844323; Thu, 04
 Apr 2024 05:47:24 -0700 (PDT)
Date: Thu,  4 Apr 2024 12:47:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404124723.2429464-1-edumazet@google.com>
Subject: [PATCH net] Bluetooth: validate setsockopt(RFCOMM_LM) user input
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported rfcomm_sock_setsockopt_old() is copying data without
checking user input length.

 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
 BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
 BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064

CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
  copy_from_sockptr include/linux/sockptr.h:55 [inline]
  rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
  rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
  do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f36ff898dc9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe010c2208 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f36ff898dc9
RDX: 0000000000000003 RSI: 0000000000000012 RDI: 0000000000000006
RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000555567399338
R13: 000000000000000e R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5064:
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

The buggy address belongs to the object at ffff8880209a8bc0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff8880209a8bc0, ffff8880209a8bc2)

The buggy address belongs to the physical page:
page:ffffea0000826a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x209a8
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41280 ffffea000081fb80 dead000000000002
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 9917548498, free_ts 0
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
  __kmalloc+0x2e5/0x4a0 mm/slub.c:3979
  kmalloc_array include/linux/slab.h:665 [inline]
  kcalloc include/linux/slab.h:696 [inline]
  group_cpus_evenly+0x294/0x5f0 lib/group_cpus.c:365
  blk_mq_map_queues+0x4c/0x3e0 block/blk-mq-cpumap.c:23
  blk_mq_alloc_tag_set+0x7ac/0xf40 block/blk-mq.c:4521
  nbd_dev_add+0x367/0xc80 drivers/block/nbd.c:1831
  nbd_init+0x224/0x2e0 drivers/block/nbd.c:2593
  do_one_initcall+0x238/0x830 init/main.c:1241
  do_initcall_level+0x157/0x210 init/main.c:1303
  do_initcalls+0x3f/0x80 init/main.c:1319
  kernel_init_freeable+0x435/0x5d0 init/main.c:1550
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880209a8a80: 06 fc fc fc 06 fc fc fc 06 fc fc fc 07 fc fc fc
 ffff8880209a8b00: fa fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
>ffff8880209a8b80: fa fc fc fc fa fc fc fc 02 fc fc fc fa fc fc fc
                                           ^
 ffff8880209a8c00: 00 fc fc fc 00 fc fc fc 00 fc fc fc 05 fc fc fc
 ffff8880209a8c80: 05 fc fc fc 05 fc fc fc fa fc fc fc 00 fc fc fc

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com> (supporter:BLUETOOTH SUBSYSTEM)
Cc: linux-bluetooth@vger.kernel.org
---
 net/bluetooth/rfcomm/sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b54e8a530f55a1ff9547a2a5546db34059ebd672..39155b41e9d781a4099bb7b7f29bb53d8fc63e9e 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -629,6 +629,10 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
+		if (optlen < sizeof(u32)) {
+			err = -EINVAL;
+			break;
+		}
 		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
-- 
2.44.0.478.gd926399ef9-goog


