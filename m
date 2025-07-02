Return-Path: <netdev+bounces-203097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB7AF081F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15182188398B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7254758;
	Wed,  2 Jul 2025 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qjUMay8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDE134CB
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420638; cv=none; b=YQsPDLJ0vFLo9g/41t5/uCfiKXjV3+LhBhmLCd0I0sHRYn/COprFerYwwd4oY/Qg5i6crPxWAliMEY9tWbMa2wkkKRAuH01WZ2leSvK7D9uEPfqHyXCAmOrb5rI8XvboJTupOBqU0c30ICCzWuF0ffwkJOZf+R+tR7bz00LF2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420638; c=relaxed/simple;
	bh=aXMltUif3/Tt0bzSuk/GyhAmdMlJxITxE0Hg378kuYI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=byGj08vPwguwhPcQ/cn2QGWwef1NokswlvAKytQ3jOJTjDtgW5tTC3vH+f3sAXI2lhWieQwvsD3/oa1Km2gKcKMPtcM1q8jUKoqyfbmdLwQbSxnkirzwwzMWpRUxjOZeQrUPre2PaJRPiUNRmAtpON/QVPSatvJHq7GvxWaKsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qjUMay8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74b537e8d05so76882b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 18:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751420636; x=1752025436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QNW4tMnWCcpcJB/iAL3iBGg/d0YW5C8bj3zT9ZX4CLc=;
        b=4qjUMay8gMhM5rJP+yvyEbs3DfloNJr1AedKKMJ0e2NKqwOMEONn8xsfrs2/PAb0Zr
         llqZkW0OUNUvpbtQm0BPRktsny9IxtQAGnk3xJf752cHO7sQR1C2r5A6zppJk5wroZbd
         a80t5/bG9vEDpFA+8TO1vAspgGHxLGn3tvu42fxLyTOZCsVKAOeOZS1dCfqPY4iawjg7
         Q/4lvId19MLTumgdRLF2cki4jkZmyqR2CXsFqnLdnLBuGtkZ73Dfwtd+BVkrsodD2Bwq
         ACenLnNu9rNvccc5DG0nHXDda1H5Zj+kRyPAwFg+yS0Wc1v1p9uBYjaV05ZC4UBM+OqN
         YI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751420636; x=1752025436;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNW4tMnWCcpcJB/iAL3iBGg/d0YW5C8bj3zT9ZX4CLc=;
        b=CUEi4NL0LhkyHm7P64kgpWsc5pqG6UBvShagCKzggUQ1tnkUgA4uhy2oEqoFyou9Ku
         NnX7AyCMmAcKpigX8vnqr4CYJI/fbiywVaRkkeTSrKYkUW09x7caCuWA3Y/NI0Fs+ncT
         dGBFZiI5uQ2POR0tKloWkC4BC4gs9AL/f3L4S7Xdozll2dh1plCGWrdno37o/W8cfrrp
         ToReMTP+tjOD5n5e0eaM8LfJqJfiTMzpxty92mLh9BkQnLzWI+a91rv7FknZ9CNRj0VR
         AJzyZ8HR+ZGNNnO9jmUJU+7ZJbp/TvknfBdbxjsUbNaXoBIGoOWqBd+JKhlcgp5R+uSk
         eDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjVpu0hAmk70uxRJe1Id++rkmPHm/9PVbXHzD0/HJ7X/0xmdgOpoWEd8gUx7i+jW4BffuvrDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73n09+j1gZ3mGy+EeEXtw3z2bQOH2CGAJpSk0aP9OzSu6VDsy
	/rbSyL+cr9/pRDvCsEdqZzxbi3joNAu3q1nEiPwgaTsY39NkUzDTYy23TyjmIlw+kDxZPFnG3jH
	qH2r0ZQ==
X-Google-Smtp-Source: AGHT+IEMHVUL5aM4Xq8RS+pZ7XWnytgDkzFbRxqgLgnA/m9aLixIyklKd1j8FCUSszzE2yUOGAWznMOSs5Y=
X-Received: from pgac24.prod.google.com ([2002:a05:6a02:2958:b0:b2c:4fb0:bc64])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748f:b0:1f5:619a:7f4c
 with SMTP id adf61e73a8af0-222d7f06890mr2089192637.29.1751420635804; Tue, 01
 Jul 2025 18:43:55 -0700 (PDT)
Date: Wed,  2 Jul 2025 01:43:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702014350.692213-1-kuniyu@google.com>
Subject: [PATCH v1 net] tipc: Fix use-after-free in tipc_conn_close().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ying Xue <ying.xue@windriver.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, 
	syzbot+d333febcf8f4bc5f6110@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a null-ptr-deref in tipc_conn_close() during netns
dismantle. [0]

tipc_topsrv_stop() iterates tipc_net(net)->topsrv->conn_idr and calls
tipc_conn_close() for each tipc_conn.

The problem is that tipc_conn_close() is called after releasing the
IDR lock.

At the same time, there might be tipc_conn_recv_work() running and it
could call tipc_conn_close() for the same tipc_conn and release its
last ->kref.

Once we release the IDR lock in tipc_topsrv_stop(), there is no
guarantee that the tipc_conn is alive.

Let's hold the ref before releasing the lock and put the ref after
tipc_conn_close() in tipc_topsrv_stop().

[0]:
BUG: KASAN: use-after-free in tipc_conn_close+0x122/0x140 net/tipc/topsrv.c:165
Read of size 8 at addr ffff888099305a08 by task kworker/u4:3/435

CPU: 0 PID: 435 Comm: kworker/u4:3 Not tainted 4.19.204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fc/0x2ef lib/dump_stack.c:118
 print_address_description.cold+0x54/0x219 mm/kasan/report.c:256
 kasan_report_error.cold+0x8a/0x1b9 mm/kasan/report.c:354
 kasan_report mm/kasan/report.c:412 [inline]
 __asan_report_load8_noabort+0x88/0x90 mm/kasan/report.c:433
 tipc_conn_close+0x122/0x140 net/tipc/topsrv.c:165
 tipc_topsrv_stop net/tipc/topsrv.c:701 [inline]
 tipc_topsrv_exit_net+0x27b/0x5c0 net/tipc/topsrv.c:722
 ops_exit_list+0xa5/0x150 net/core/net_namespace.c:153
 cleanup_net+0x3b4/0x8b0 net/core/net_namespace.c:553
 process_one_work+0x864/0x1570 kernel/workqueue.c:2153
 worker_thread+0x64c/0x1130 kernel/workqueue.c:2296
 kthread+0x33f/0x460 kernel/kthread.c:259
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:415

Allocated by task 23:
 kmem_cache_alloc_trace+0x12f/0x380 mm/slab.c:3625
 kmalloc include/linux/slab.h:515 [inline]
 kzalloc include/linux/slab.h:709 [inline]
 tipc_conn_alloc+0x43/0x4f0 net/tipc/topsrv.c:192
 tipc_topsrv_accept+0x1b5/0x280 net/tipc/topsrv.c:470
 process_one_work+0x864/0x1570 kernel/workqueue.c:2153
 worker_thread+0x64c/0x1130 kernel/workqueue.c:2296
 kthread+0x33f/0x460 kernel/kthread.c:259
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:415

Freed by task 23:
 __cache_free mm/slab.c:3503 [inline]
 kfree+0xcc/0x210 mm/slab.c:3822
 tipc_conn_kref_release net/tipc/topsrv.c:150 [inline]
 kref_put include/linux/kref.h:70 [inline]
 conn_put+0x2cd/0x3a0 net/tipc/topsrv.c:155
 process_one_work+0x864/0x1570 kernel/workqueue.c:2153
 worker_thread+0x64c/0x1130 kernel/workqueue.c:2296
 kthread+0x33f/0x460 kernel/kthread.c:259
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:415

The buggy address belongs to the object at ffff888099305a00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 512-byte region [ffff888099305a00, ffff888099305c00)
The buggy address belongs to the page:
page:ffffea000264c140 count:1 mapcount:0 mapping:ffff88813bff0940 index:0x0
flags: 0xfff00000000100(slab)
raw: 00fff00000000100 ffffea00028b6b88 ffffea0002cd2b08 ffff88813bff0940
raw: 0000000000000000 ffff888099305000 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888099305900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888099305980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888099305a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888099305a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888099305b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: c5fa7b3cf3cb ("tipc: introduce new TIPC server infrastructure")
Reported-by: syzbot+d333febcf8f4bc5f6110@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=27169a847a70550d17be
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/tipc/topsrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 8ee0c07d00e9..ffe577bf6b51 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -704,8 +704,10 @@ static void tipc_topsrv_stop(struct net *net)
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
 		if (con) {
+			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
 			tipc_conn_close(con);
+			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
 		}
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


