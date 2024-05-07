Return-Path: <netdev+bounces-94219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763128BEA16
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D71028ABA2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508154BEA;
	Tue,  7 May 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hoL9p2h1"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3415C9
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101756; cv=none; b=EieKsJnYEQsiUOd0G9fFC9IgNhe01R1pa8AR6QsOn42MFUKBYDqU6jp7s9QQpPxDv+Ywcd0pKWqJZ/KJedWK7EvTdS05wiOjwpkQs02u/DKiVdSNYg1kjfFGKN2EvfXuJWe8WZpzshivIzMFEOCz5tjzfSRv2KOR+tCFN/U+W5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101756; c=relaxed/simple;
	bh=7Ywxle/IdVuKbCud3elxnOSIN2DQcpfBYUDA0hefwPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2V2on84yIYp15tdLA94gt//ubNoxAdZKb6GMD7eCUYDbJuhkq8wAfGGcONs2G0yDU8W2ax4YdUsj8C0k6Xspo9jM9mCKvl9RvWW+9cMG5zbTtFqDIlOLRo9k/FRil7128GbagMR8tuzwaC+QdWAMSwKM5v5DRDs6NmpIzE8qcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hoL9p2h1; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s4Nnq-00E6Gl-Ou; Tue, 07 May 2024 18:36:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=csw213AowSw0WUKsb3QbE0MBVrCFHPrDpo1TIQOirBQ=; b=hoL9p2h1j1X0K
	u88PfOSCHw5MZfBI8+HjZqSi2LNIzIR/p2J4Bh/bZ9RQLBV+n8PvkYQlx/aaNfngI1xBGbx+T5dmX
	8kawWI67pI1btp1qLoMaTe0BlEEWlVLHT6VCw3ELu+ZzTiRD/HvLkZEXoImXzWx+ieUAwfoRcqTIo
	KPNQfgAkYHXyFlCwKIrfn9MEueh1P5/3EJlHRedVeL+gdiJRYkcXJ/JXwof0yPqAYmASy+6RDdpZm
	G6NoSZ9vCMU2kajs8ArsU4QcfdjyeRpMqwjz5Qvbi6slGxVSy3oakfksCs5j5LKQQ99nQvfFTKLIR
	TwADI9UEMysNM9hTQiJnQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s4Nnk-0007x5-OC; Tue, 07 May 2024 18:36:24 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s4NnU-0033tc-FD; Tue, 07 May 2024 18:36:08 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net] af_unix: Fix garbage collector racing against send() MSG_OOB
Date: Tue,  7 May 2024 18:29:29 +0200
Message-ID: <20240507163545.1131404-1-mhal@rbox.co>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Garbage collector takes care to explicitly drop oob_skb references before
purging the hit list. However, it does not account for a race: another
oob_skb might get assigned through in-flight socket's peer.

a/A and b/B are peers; A and B have been close()d and form an (OOB)
in-flight cycle:

	a -- A <-> B -- b

When A's and B's queues are about to be collected, their peers are still
reachable. User can send another OOB packet:

queue_oob			unix_gc
---------			-------

unix_state_lock(u)
if (u->oob_sbk)
  consume_skb(u->oob_skb)
  // oob_skb refcnt == 1
				scan_children(&u->sk, inc_inflight, &hitlist)
				if (u->oob_skb) {
				  kfree_skb(u->oob_skb)
				  // oob_skb refcnt == 0, but in hitlist (!)
				  u->oob_skb = NULL
				}
u->oob_skb = skb
skb_queue(u->queue, skb)
unix_state_unlock(u)

Tell GC to remove oob_skb under unix_state_lock().

Fixes: aa82ac51d633 ("af_unix: Drop oob_skb ref before purging queue in GC.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
[   16.320707] WARNING: CPU: 7 PID: 552 at net/unix/garbage.c:369 __unix_gc+0x4be/0x4d0
[   16.320712] Modules linked in: 9p netfs kvm_intel kvm 9pnet_virtio 9pnet i2c_piix4 zram crct10dif_pclmul crc32_pclmul crc32c_intel virtio_blk ghash_clmulni_intel serio_raw fuse qemu_fw_cfg virtio_console
[   16.320726] CPU: 7 PID: 552 Comm: kworker/u32:8 Not tainted 6.9.0-rc7nokasan+ #12
[   16.320728] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   16.320729] Workqueue: events_unbound __unix_gc
[   16.320731] RIP: 0010:__unix_gc+0x4be/0x4d0
[   16.320733] Code: c0 b5 f1 81 3c 0a 74 18 e8 7f f8 ff ff e9 92 fd ff ff 0f 0b e9 bc fb ff ff 0f 0b e9 06 fc ff ff e8 07 fa ff ff e9 7a fd ff ff <0f> 0b e9 3b ff ff ff e8 e6 01 11 00 66 0f 1f 44 00 00 90 90 90 90
[   16.320735] RSP: 0018:ffffc9000143fd90 EFLAGS: 00010283
[   16.320737] RAX: ffff8881054576b0 RBX: ffffffff83563070 RCX: 0000000053568fdc
[   16.320738] RDX: 0000000000000001 RSI: ffffffff8293c754 RDI: ffffffff835636c0
[   16.320739] RBP: ffffc9000143fe40 R08: 00000000000003c3 R09: 00000000000003c3
[   16.320740] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000143fdb0
[   16.320741] R13: ffffffff835636a0 R14: ffffc9000143fd90 R15: ffff8881054576b0
[   16.320742] FS:  0000000000000000(0000) GS:ffff88842fd80000(0000) knlGS:0000000000000000
[   16.320743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.320744] CR2: 0000559764faa540 CR3: 0000000003238000 CR4: 0000000000750ef0
[   16.320747] PKRU: 55555554
[   16.320748] Call Trace:
[   16.320749]  <TASK>
[   16.320751]  ? __warn+0x88/0x180
[   16.320755]  ? __unix_gc+0x4be/0x4d0
[   16.320757]  ? report_bug+0x18d/0x1c0
[   16.320760]  ? handle_bug+0x3c/0x80
[   16.320762]  ? exc_invalid_op+0x13/0x60
[   16.320764]  ? asm_exc_invalid_op+0x16/0x20
[   16.320769]  ? __unix_gc+0x4be/0x4d0
[   16.320775]  process_one_work+0x217/0x700
[   16.320778]  ? move_linked_works+0x70/0xa0
[   16.320781]  worker_thread+0x1ca/0x3b0
[   16.320784]  ? __pfx_worker_thread+0x10/0x10
[   16.320786]  kthread+0xdd/0x110
[   16.320787]  ? __pfx_kthread+0x10/0x10
[   16.320789]  ret_from_fork+0x2d/0x50
[   16.320792]  ? __pfx_kthread+0x10/0x10
[   16.320793]  ret_from_fork_asm+0x1a/0x30
[   16.320799]  </TASK>
[   16.320800] irq event stamp: 24197
[   16.320801] hardirqs last  enabled at (24203): [<ffffffff811c5b7d>] console_unlock+0xfd/0x130
[   16.320803] hardirqs last disabled at (24208): [<ffffffff811c5b62>] console_unlock+0xe2/0x130
[   16.320804] softirqs last  enabled at (21512): [<ffffffff81117e51>] __irq_exit_rcu+0xa1/0x110
[   16.320806] softirqs last disabled at (21505): [<ffffffff81117e51>] __irq_exit_rcu+0xa1/0x110

 include/net/af_unix.h | 1 +
 net/unix/garbage.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 3dee0b2721aa..a125bf1c1bb9 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -88,6 +88,7 @@ enum unix_socket_lock_class {
 	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
 			     * candidates to close a small race window.
 			     */
+	U_LOCK_GC_OOB, /* freeing oob_skb during GC. */
 };
 
 static inline void unix_state_lock_nested(struct sock *sk,
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0104be9d4704..9b0070589282 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -342,10 +342,12 @@ static void __unix_gc(struct work_struct *work)
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		unix_state_lock_nested(&u->sk, U_LOCK_GC_OOB);
 		if (u->oob_skb) {
 			kfree_skb(u->oob_skb);
 			u->oob_skb = NULL;
 		}
+		unix_state_unlock(&u->sk);
 #endif
 	}
 
-- 
2.45.0


