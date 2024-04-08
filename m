Return-Path: <netdev+bounces-85869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508AA89CA35
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074AE288E04
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDAF1428F0;
	Mon,  8 Apr 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LkFSk7Wb"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970863CB
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595768; cv=none; b=Ar7FbRCQWhW2Xf+kkBTCQWGWv6CmqMpf/YtdIySutPJj67isBGgYanyq4keNlxCckOX1TidFa8xY+zvQGpjRnt2Bdl1gbPfVIsikg4Z4Uuj3XmnicCU1CQTer6LvqDs6sidVWEtVGYSprd8IYN2WS2Z6fwDKIXntCDPEoGOM9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595768; c=relaxed/simple;
	bh=pO+bfXkqjCSC9tLmpX91pLiQOioUFPYf3yLErm3o7NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rq4VqAyAMmWs7vPt45/xKlv+WlRmpqFWKa7yDGB5wmJCyfCpCbLGjVjjGSwDWJJzeMIVOFHhMRmwx2ZRW8vNKvjJf3YFuZBooP6w8BEQRnDsuDQgBB9YHpSDaOJYbH9LjW4vL9+YMSc84CfjlWMhyUdJfUO3furqRdSikJzsx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LkFSk7Wb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1rtrdG-00BV9r-QT; Mon, 08 Apr 2024 18:14:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=gO5wrN39D0wMh6nZiER2K6wwXC70Uuyn0cBroCSVsTA=; b=LkFSk7WbK7R4q
	xLMdvlsF2qqaOBJHr1lXf4au/QL9jYy6jSE6rmnx1zS4hLyU/uQrUuoam5GBHMGfT0f6/qu7H6I3Q
	oSAY+FnuKXRGdg6o5oMFfWogqfTKUTLfkJ18APU9G0ZA7ddeq68F5sg4VlgZ2/SPdg9WnjOME3xBI
	4yKegzHNqvFqkAA1gR/CGrIZnn7nkOQEKxuAwA+BmnUs8JUDlyWg6OSB/bpX/v/mKxuErcWJV2vFu
	othCJ5nK8aRBXa6yBimOsLAXeTpZuyLR4eljj/iXcehFBEfGljXzWIEabuxS92sukS88oqbQYucfn
	ZDDuC77ULNXi7gVS2GLkg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1rtrdF-00056l-MS; Mon, 08 Apr 2024 18:14:05 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1rtrd2-00Gq8Q-Um; Mon, 08 Apr 2024 18:13:53 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 0/2] af_unix: Garbage collector vs connect() race condition
Date: Mon,  8 Apr 2024 17:58:44 +0200
Message-ID: <20240408161336.612064-1-mhal@rbox.co>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Garbage collector does not take into account the risk of embryo getting
enqueued during the garbage collection. If such embryo has a peer that
carries SCM_RIGHTS, two consecutive passes of scan_children() may see a
different set of children. Leading to an incorrectly elevated inflight
count, and then a dangling pointer within the gc_inflight_list.

sockets are AF_UNIX/SOCK_STREAM
S is an unconnected socket
L is a listening in-flight socket bound to addr, not in fdtable
V's fd will be passed via sendmsg(), gets inflight count bumped

connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
----------------	-------------------------	-----------

NS = unix_create1()
skb1 = sock_wmalloc(NS)
L = unix_find_other(addr)
unix_state_lock(L)
unix_peer(S) = NS
			// V count=1 inflight=0

 			NS = unix_peer(S)
 			skb2 = sock_alloc()
			skb_queue_tail(NS, skb2[V])

			// V became in-flight
			// V count=2 inflight=1

			close(V)

			// V count=1 inflight=1
			// GC candidate condition met

						for u in gc_inflight_list:
						  if (total_refs == inflight_refs)
						    add u to gc_candidates

						// gc_candidates={L, V}

						for u in gc_candidates:
						  scan_children(u, dec_inflight)

						// embryo (skb1) was not
						// reachable from L yet, so V's
						// inflight remains unchanged
__skb_queue_tail(L, skb1)
unix_state_unlock(L)
						for u in gc_candidates:
						  if (u.inflight)
						    scan_children(u, inc_inflight_move_tail)

						// V count=1 inflight=2 (!)

The idea behind the patch is to unix_state_lock()/unlock() L during the
gc_candidates selection. That would guarantee either connect() has
concluded, or - if we raced it - parallel sendmsg() with SCM_RIGHTS could
not happen as we are already holding the unix_gc_lock.

Running the reproducer with mdelay(1) stuffed in unix_stream_connect()
results in immediate splats:

$ ./tools/testing/selftests/net/af_unix/gc_vs_connect
running
[   47.019387] WARNING: CPU: 3 PID: 12 at net/unix/garbage.c:284 __unix_gc+0x473/0x4a0
[   47.019405] Modules linked in: 9p netfs kvm_intel kvm 9pnet_virtio 9pnet i2c_piix4 zram crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel virtio_blk serio_raw fuse qemu_fw_cfg virtio_console
[   47.019419] CPU: 3 PID: 12 Comm: kworker/u32:1 Not tainted 6.9.0-rc2nokasan+ #1
[   47.019421] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   47.019422] Workqueue: events_unbound __unix_gc
[   47.019424] RIP: 0010:__unix_gc+0x473/0x4a0
[   47.019425] Code: 8d bb d0 f9 ff ff 48 0f ba 73 58 01 0f b6 83 e2 f9 ff ff 31 d2 48 c7 c6 a0 c3 de 81 3c 0a 74 18 e8 e2 f8 ff ff e9 96 fd ff ff <0f> 0b e9 ef fb ff ff 0f 0b e9 39 fc ff ff e8 5a fa ff ff e9 7e fd
[   47.019427] RSP: 0018:ffffc9000006bd90 EFLAGS: 00010297
[   47.019429] RAX: 0000000000000002 RBX: ffff888109459680 RCX: 000000003342a6b0
[   47.019430] RDX: 0000000000000001 RSI: ffffffff82634e8c RDI: ffffffff83161740
[   47.019431] RBP: ffffc9000006be40 R08: 00000000000003d7 R09: 00000000000003d7
[   47.019432] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff831610e0
[   47.019433] R13: ffff888109459cb0 R14: ffffc9000006bd90 R15: ffffffff831616c0
[   47.019434] FS:  0000000000000000(0000) GS:ffff88842fb80000(0000) knlGS:0000000000000000
[   47.019435] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.019436] CR2: 000055c16e3893b8 CR3: 0000000002e37000 CR4: 0000000000750ef0
[   47.019438] PKRU: 55555554
[   47.019439] Call Trace:
[   47.019440]  <TASK>
[   47.019442]  ? __warn+0x88/0x180
[   47.019445]  ? __unix_gc+0x473/0x4a0
[   47.019447]  ? report_bug+0x189/0x1c0
[   47.019451]  ? handle_bug+0x38/0x70
[   47.019453]  ? exc_invalid_op+0x13/0x60
[   47.019454]  ? asm_exc_invalid_op+0x16/0x20
[   47.019460]  ? __unix_gc+0x473/0x4a0
[   47.019464]  ? lock_acquire+0xd5/0x2c0
[   47.019466]  ? lock_release+0x133/0x290
[   47.019471]  process_one_work+0x215/0x700
[   47.019473]  ? move_linked_works+0x70/0xa0
[   47.019477]  worker_thread+0x1ca/0x3b0
[   47.019479]  ? rescuer_thread+0x340/0x340
[   47.019480]  kthread+0xdd/0x110
[   47.019482]  ? kthread_complete_and_exit+0x20/0x20
[   47.019485]  ret_from_fork+0x2d/0x50
[   47.019487]  ? kthread_complete_and_exit+0x20/0x20
[   47.019489]  ret_from_fork_asm+0x11/0x20
[   47.019495]  </TASK>
[   47.019496] irq event stamp: 446769
[   47.019497] hardirqs last  enabled at (446775): [<ffffffff81199a69>] console_unlock+0xf9/0x120
[   47.019499] hardirqs last disabled at (446780): [<ffffffff81199a4e>] console_unlock+0xde/0x120
[   47.019501] softirqs last  enabled at (444340): [<ffffffff810fcd73>] __irq_exit_rcu+0x93/0x100
[   47.019504] softirqs last disabled at (444333): [<ffffffff810fcd73>] __irq_exit_rcu+0x93/0x100
[   47.019505] ---[ end trace 0000000000000000 ]---
...
[   47.019555] list_add corruption. prev->next should be next (ffffffff83161710), but was ffff888109459cb0. (prev=ffff888109459cb0).
[   47.019572] kernel BUG at lib/list_debug.c:32!
[   47.019654] invalid opcode: 0000 [#1] PREEMPT SMP
[   47.019676] CPU: 0 PID: 1057 Comm: gc_vs_connect Tainted: G        W          6.9.0-rc2nokasan+ #1
[   47.019698] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   47.019720] RIP: 0010:__list_add_valid_or_report+0x70/0x90
[   47.019743] Code: 98 ff 0f 0b 48 89 c1 48 c7 c7 90 1a 72 82 e8 77 ed 98 ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 e8 1a 72 82 e8 60 ed 98 ff <0f> 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 40 1b 72 82 e8 49 ed 98
[   47.019766] RSP: 0018:ffffc9000125fba8 EFLAGS: 00010286
[   47.019790] RAX: 0000000000000075 RBX: ffff888109459680 RCX: 0000000000000000
[   47.019814] RDX: 0000000000000002 RSI: ffffffff82667570 RDI: 00000000ffffffff
[   47.019838] RBP: ffff8881067bc400 R08: 0000000000000000 R09: 0000000000000003
[   47.019861] R10: ffffc9000125fa78 R11: ffffffff82f571e8 R12: ffff888109459cb0
[   47.019883] R13: ffff888109459cb0 R14: ffff88810945ad00 R15: 0000000000000000
[   47.019906] FS:  00007fba6fde1680(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
[   47.019928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.019949] CR2: 00007fba6fc5ac80 CR3: 0000000104819000 CR4: 0000000000750ef0
[   47.019972] PKRU: 55555554
[   47.019993] Call Trace:
[   47.020014]  <TASK>
[   47.020034]  ? die+0x32/0x80
[   47.020056]  ? do_trap+0xd5/0x100
[   47.020078]  ? __list_add_valid_or_report+0x70/0x90
[   47.020100]  ? __list_add_valid_or_report+0x70/0x90
[   47.020122]  ? do_error_trap+0x81/0x110
[   47.020144]  ? __list_add_valid_or_report+0x70/0x90
[   47.020166]  ? exc_invalid_op+0x4c/0x60
[   47.020189]  ? __list_add_valid_or_report+0x70/0x90
[   47.020211]  ? asm_exc_invalid_op+0x16/0x20
[   47.020237]  ? __list_add_valid_or_report+0x70/0x90
[   47.020355]  ? __list_add_valid_or_report+0x70/0x90
[   47.020424]  unix_inflight+0x6a/0xf0
[   47.020483]  unix_scm_to_skb+0xe4/0x160
[   47.020518]  unix_stream_sendmsg+0x174/0x630
[   47.020573]  __sock_sendmsg+0x38/0x70
[   47.020635]  ____sys_sendmsg+0x237/0x2a0
[   47.020694]  ? import_iovec+0x16/0x20
[   47.020754]  ___sys_sendmsg+0x86/0xd0
[   47.020791]  ? find_held_lock+0x2b/0x80
[   47.021011]  ? lock_release+0x133/0x290
[   47.021467]  ? __fget_files+0xca/0x180
[   47.021564]  __sys_sendmsg+0x47/0x80
[   47.021663]  do_syscall_64+0x94/0x180
[   47.021751]  ? do_syscall_64+0xa1/0x180
[   47.021812]  ? do_syscall_64+0xa1/0x180
[   47.021864]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   47.021890] RIP: 0033:0x7fba6fd15dbb
[   47.021917] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 69 2c f7 ff 8b 55 ec 48 8b 75 f0 41 89 c0 8b 7d f8 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 48 89 45 f8 e8 c1 2c f7 ff 48 8b
[   47.021948] RSP: 002b:00007ffc1aa77410 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
[   47.021974] RAX: ffffffffffffffda RBX: 00007ffc1aa775c8 RCX: 00007fba6fd15dbb
[   47.022000] RDX: 0000000000000000 RSI: 00005625cb5df0e0 RDI: 0000000000000003
[   47.022025] RBP: 00007ffc1aa77430 R08: 0000000000000000 R09: 0000000000001033
[   47.022050] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
[   47.022076] R13: 0000000000000000 R14: 00007fba6fe2c000 R15: 00005625cb5dedd8
[   47.022103]  </TASK>
[   47.022127] Modules linked in: 9p netfs kvm_intel kvm 9pnet_virtio 9pnet i2c_piix4 zram crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel virtio_blk serio_raw fuse qemu_fw_cfg virtio_console
[   47.022209] ---[ end trace 0000000000000000 ]---
[   47.022233] RIP: 0010:__list_add_valid_or_report+0x70/0x90
[   47.022258] Code: 98 ff 0f 0b 48 89 c1 48 c7 c7 90 1a 72 82 e8 77 ed 98 ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 e8 1a 72 82 e8 60 ed 98 ff <0f> 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 40 1b 72 82 e8 49 ed 98
[   47.022284] RSP: 0018:ffffc9000125fba8 EFLAGS: 00010286
[   47.022308] RAX: 0000000000000075 RBX: ffff888109459680 RCX: 0000000000000000
[   47.022332] RDX: 0000000000000002 RSI: ffffffff82667570 RDI: 00000000ffffffff
[   47.022356] RBP: ffff8881067bc400 R08: 0000000000000000 R09: 0000000000000003
[   47.022406] R10: ffffc9000125fa78 R11: ffffffff82f571e8 R12: ffff888109459cb0
[   47.022451] R13: ffff888109459cb0 R14: ffff88810945ad00 R15: 0000000000000000
[   47.022517] FS:  00007fba6fde1680(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
[   47.022606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.022653] CR2: 00007fba6fc5ac80 CR3: 0000000104819000 CR4: 0000000000750ef0
[   47.022698] PKRU: 55555554
[   47.022764] note: gc_vs_connect[1057] exited with preempt_count 1

Michal Luczaj (2):
  af_unix: Fix garbage collector racing against connect()
  af_unix: Add GC race reproducer + slow down unix_stream_connect()

 net/unix/af_unix.c                            |   2 +
 net/unix/garbage.c                            |  20 ++-
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/gc_vs_connect.c     | 158 ++++++++++++++++++
 4 files changed, 178 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/gc_vs_connect.c

-- 
2.44.0


