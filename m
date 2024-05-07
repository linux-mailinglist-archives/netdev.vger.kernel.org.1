Return-Path: <netdev+bounces-94216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9E8BEA0F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD1C28A883
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FDC54BD7;
	Tue,  7 May 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QMPpaXAI"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB6B672
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101687; cv=none; b=dpZ2pMCz3FXBCr8O7bnBYyx82WLd0rVQh4Qvuyk5vcPECwW9Ith2ReQD+HE/2oLAgLkqj7F5XzLVTsq2p4OeEDXyHzoHu0tDvXrhVvZYv8j0wOmM+50M14KxAgPuO6GAVIlpdEOsULCB8MElQPQwkNBO5/alcjxrdBNN9m7BsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101687; c=relaxed/simple;
	bh=bxDlMxmCH6b2hBPOXs1EL21rlE/oN+aUsNCfIcrKq3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5Ul/TJ5CguGmk0cSu8HqiQEPedQXOZsjWxeU6JdOle4LHl+9XHufGYf6tEMAH31fhoRKSf1/qOmVugA6zl3/FwFMn+38T0PmjWwSaIDaOhzQxorssBhKijDL0EddpknfR1n26gcZtQNGbkU4p+PZ8UfViS9Uo/927L0II/dEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QMPpaXAI; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s4NoW-00E0tB-7S; Tue, 07 May 2024 18:37:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=F04AcBy1Pd/jLAYjBaLGqkdXOv0I0FRSRZQ8T3DeSQ8=; b=QMPpaXAIoHoW4
	J1NagTh/fD8BmERNIlvZqoQzeZeqXuGcWkbdkQ4hX3BpZwmf1j2BjhnGeYhdMsWDolscG6wxIKiRo
	hdSVdqXFb5gHbTA11TDWwPVgZxWZM11dTuqST5bbTaJ+DELHYZEB/k9k2v+ChfcvxIyJ27iNiF5v2
	aZ1pjPAQH0xzpwEwTvcunH9M2OzGF/9eaqc5UsAViOVn96aLElJ2pUU5DxvJ4S/AlFgNojDEKYg3W
	O0MOBhUxN5TWhp9X+KLrZxyXKFIRx/XB6gvrw3ny7yxlVGUBVSWtQi5DyTX0boXNNDAfnVqOXgYJR
	7UnSDlm89CtacMxVU9Siw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s4NoV-0006IS-Fg; Tue, 07 May 2024 18:37:11 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s4NoS-002kRz-MG; Tue, 07 May 2024 18:37:08 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next] af_unix: Fix garbage collector racing against send() MSG_OOB
Date: Tue,  7 May 2024 18:29:33 +0200
Message-ID: <20240507163653.1131444-1-mhal@rbox.co>
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

queue_oob                       unix_gc
---------                       -------

unix_state_lock(u)
if (u->oob_sbk)
  consume_skb(u->oob_skb)
  // oob_skb refcnt == 1
				skb_queue_splice(u->queue, hitlist)
				if (u->oob_skb) {
				  kfree_skb(u->oob_skb)
				  // oob_skb refcnt == 0, but in hitlist (!)
				  u->oob_skb = NULL
				}
u->oob_skb = skb
skb_queue(u->queue, skb)
unix_state_unlock(u)

Tell GC to remove oob_skb under unix_state_lock().

Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
[   10.959053] refcount_t: underflow; use-after-free.
[   10.959072] WARNING: CPU: 0 PID: 711 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
[   10.959077] Modules linked in: 9p netfs kvm_intel kvm 9pnet_virtio 9pnet i2c_piix4 zram crct10dif_pclmul crc32_pclmul crc32c_intel virtio_blk ghash_clmulni_intel serio_raw fuse qemu_fw_cfg virtio_console
[   10.959092] CPU: 0 PID: 711 Comm: kworker/0:3 Not tainted 6.9.0-rc6nokasan+ #7
[   10.959094] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   10.959095] Workqueue: events delayed_fput
[   10.959098] RIP: 0010:refcount_warn_saturate+0xba/0x110
[   10.959100] Code: 01 01 e8 79 d7 86 ff 0f 0b c3 cc cc cc cc 80 3d a7 e1 cd 01 00 75 85 48 c7 c7 d0 c0 a2 82 c6 05 97 e1 cd 01 01 e8 56 d7 86 ff <0f> 0b c3 cc cc cc cc 80 3d 85 e1 cd 01 00 0f 85 5e ff ff ff 48 c7
[   10.959102] RSP: 0018:ffffc90000477ce8 EFLAGS: 00010296
[   10.959104] RAX: 0000000000000026 RBX: ffff88812d102440 RCX: 0000000000000000
[   10.959105] RDX: 0000000000000002 RSI: 0000000000000027 RDI: 00000000ffffffff
[   10.959106] RBP: 0000000000000300 R08: 0000000000000000 R09: 0000000000000003
[   10.959107] R10: ffffc90000477ba0 R11: ffffffff833591e8 R12: ffff88812d1026dc
[   10.959108] R13: ffff88812d102c68 R14: 0000000000000001 R15: ffff88812d102ac0
[   10.959109] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
[   10.959110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.959111] CR2: 00007f158e949900 CR3: 0000000003238000 CR4: 0000000000750ef0
[   10.959114] PKRU: 55555554
[   10.959115] Call Trace:
[   10.959116]  <TASK>
[   10.959118]  ? __warn+0x88/0x180
[   10.959121]  ? refcount_warn_saturate+0xba/0x110
[   10.959123]  ? report_bug+0x18d/0x1c0
[   10.959128]  ? handle_bug+0x3c/0x80
[   10.959130]  ? exc_invalid_op+0x13/0x60
[   10.959132]  ? asm_exc_invalid_op+0x16/0x20
[   10.959137]  ? refcount_warn_saturate+0xba/0x110
[   10.959139]  ? refcount_warn_saturate+0xba/0x110
[   10.959141]  sock_wfree+0xcf/0x300
[   10.959144]  unix_destruct_scm+0x77/0x90
[   10.959147]  skb_release_head_state+0x20/0x60
[   10.959149]  kfree_skb_reason+0x53/0x1e0
[   10.959152]  unix_release_sock+0x255/0x560
[   10.959155]  unix_release+0x2e/0x40
[   10.959156]  __sock_release+0x3a/0xc0
[   10.959159]  sock_close+0x14/0x20
[   10.959161]  __fput+0x9a/0x2d0
[   10.959163]  delayed_fput+0x1f/0x30
[   10.959165]  process_one_work+0x217/0x700
[   10.959167]  ? move_linked_works+0x70/0xa0
[   10.959170]  worker_thread+0x1ca/0x3b0
[   10.959173]  ? __pfx_worker_thread+0x10/0x10
[   10.959175]  kthread+0xdd/0x110
[   10.959176]  ? __pfx_kthread+0x10/0x10
[   10.959178]  ret_from_fork+0x2d/0x50
[   10.959181]  ? __pfx_kthread+0x10/0x10
[   10.959182]  ret_from_fork_asm+0x1a/0x30
[   10.959187]  </TASK>
[   10.959188] irq event stamp: 47083
[   10.959189] hardirqs last  enabled at (47089): [<ffffffff811c5a5d>] console_unlock+0xfd/0x130
[   10.959192] hardirqs last disabled at (47094): [<ffffffff811c5a42>] console_unlock+0xe2/0x130
[   10.959193] softirqs last  enabled at (46644): [<ffffffff81f1ed8f>] unix_release_sock+0x12f/0x560
[   10.959194] softirqs last disabled at (46642): [<ffffffff81f1ed6b>] unix_release_sock+0x10b/0x560

 include/net/af_unix.h |  1 +
 net/unix/garbage.c    | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b6eedf7650da..6791c660b5ca 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -103,6 +103,7 @@ enum unix_socket_lock_class {
 	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
 			     * candidates to close a small race window.
 			     */
+	U_LOCK_GC_OOB, /* freeing oob_skb during GC. */
 };
 
 static inline void unix_state_lock_nested(struct sock *sk,
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d76450133e4f..f2098653aef8 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -357,11 +357,10 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
 		u = edge->predecessor;
 		queue = &u->sk.sk_receive_queue;
 
-		spin_lock(&queue->lock);
-
 		if (u->sk.sk_state == TCP_LISTEN) {
 			struct sk_buff *skb;
 
+			spin_lock(&queue->lock);
 			skb_queue_walk(queue, skb) {
 				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
 
@@ -370,18 +369,21 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
 				skb_queue_splice_init(embryo_queue, hitlist);
 				spin_unlock(&embryo_queue->lock);
 			}
+			spin_unlock(&queue->lock);
 		} else {
+			spin_lock(&queue->lock);
 			skb_queue_splice_init(queue, hitlist);
+			spin_unlock(&queue->lock);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+			unix_state_lock_nested(&u->sk, U_LOCK_GC_OOB);
 			if (u->oob_skb) {
 				kfree_skb(u->oob_skb);
 				u->oob_skb = NULL;
 			}
+			unix_state_unlock(&u->sk);
 #endif
 		}
-
-		spin_unlock(&queue->lock);
 	}
 }
 
-- 
2.45.0


