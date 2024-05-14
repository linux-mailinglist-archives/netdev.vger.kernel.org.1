Return-Path: <netdev+bounces-96320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F48C4F4D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8936B1C211C2
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31D13E3EB;
	Tue, 14 May 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pwwVVuuL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EABA64CCC
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681668; cv=none; b=roPR4dqNSm7rlFzZrFL/WIjzyXkbeYlWQZ7WiigaoSBoMjE6ofdpVU3UmhyTPh9UhiWdInSpQ/cCLg8IecK3L0arIuYvPNg1SyzThgxjxugbjRTcUboVHtnJwDKV0cEuQFBq9QIkZJ38Jln0lZhKs3ZcDzTV+Z5uZB+URreUZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681668; c=relaxed/simple;
	bh=bNtDU03a3v5G0GdtsFJG7yzeyOpgxV3v9BfTR1Z+az8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qci4vs3oN9qLGhLE0GOCWzY3eCU7prQVrpOyJCS62lJ0eiHo8KVEjci9AcuLScMEOrGKf/UE2LcsibtMALoMHdDVW0mjvYE/FxnmSA/LnM/PWlPmspxqIf8V77uxAH5PGGZjguOL+9hrdCTKEvWr34hg+91iVbdP5ay0JN++56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pwwVVuuL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s6pAH-00EQDJ-Mh; Tue, 14 May 2024 12:13:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Jep7rVpfKnWdGgRck8zcllYxioJ8DAwieJDcV63yyiY=; b=pwwVVuuLC/U8Ce5GPVyjuAN7q3
	WFZGNiBXWt7PlRIje9mCsNjOGxPkPDjhyvVLjyPYW0PGC1XLoN/t+B7BP1qc/UgcicunM0l/0D6/U
	hjmHSJpwZffrWxqte2tmLH2LtapzeBPVkz2QYP8vU1k3Q1mWXpdl5qosDju28NCH80rJMA1O8tECt
	0y2OquR2qZ37hzOHEgF1csDd3R4rpM4MivdHpRo+WAIx0/BYyxeT+oQ2rZnz5XLY+YnOeiGBf6XLb
	dH1eTejU9q07h2xEdKceM0vInKborn+yTBPePhqtr2CG6cBD+Mhpvms6ILxpXw2tKU1c0tYMOywPj
	+110J62Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s6pAG-000603-D6; Tue, 14 May 2024 12:13:44 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s6pAA-00AJe3-3D; Tue, 14 May 2024 12:13:38 +0200
Message-ID: <6915a10c-cc57-4a68-9f91-a5efdf42091d@rbox.co>
Date: Tue, 14 May 2024 12:13:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH v4 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Billy Jheng Bing-Jhong <billy@starlabs.sg>
References: <20240514025250.12604-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240514025250.12604-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/24 04:52, Kuniyuki Iwashima wrote:
> ...
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0104be9d4704..b87e48e2b51b 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -342,10 +342,12 @@ static void __unix_gc(struct work_struct *work)
>  		scan_children(&u->sk, inc_inflight, &hitlist);
>  
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +		spin_lock(&u->sk.sk_receive_queue.lock);
>  		if (u->oob_skb) {
> -			kfree_skb(u->oob_skb);
> +			WARN_ON_ONCE(skb_unref(u->oob_skb));
>  			u->oob_skb = NULL;
>  		}
> +		spin_unlock(&u->sk.sk_receive_queue.lock);
>  #endif
>  	}

I've realised this part of GC is broken for embryos. And adding a rq lock
here turns a warning into a possible deadlock, so below is my attempt at
fixing the underlying problem.

It's based it on top of your patch, so should I post it now or wait until
your patch lands in net?
---
Subject: [PATCH] af_unix: Fix garbage collection of embryos carrying
 OOB/SCM_RIGHTS

GC attempts to explicitly drop oob_skb before purging the hit list. The
problem is with embryos: instead of trying to kfree_skb(u->oob_skb) of an
embryo socket, GC goes for its parent-listener socket, which never carries
u->oob_skb. Effectively oob_skb is removed from the receive queue, but
remains reachable via u->oob_skb.

Tell GC to dispose the right socket's oob_skb.

Fixes: aa82ac51d633 ("af_unix: Drop oob_skb ref before purging queue in GC.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
from array import array
from socket import *

addr = 'unix-oob-splat'
lis = socket(AF_UNIX, SOCK_STREAM)
lis.bind(addr)
lis.listen(1)

s = socket(AF_UNIX, SOCK_STREAM)
s.connect(addr)
scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
s.sendmsg([b'x'], [scm], MSG_OOB)
lis.close()

[   22.208683] WARNING: CPU: 2 PID: 546 at net/unix/garbage.c:371 __unix_gc+0x50e/0x520
[   22.208687] Modules linked in: 9p netfs kvm_intel kvm 9pnet_virtio 9pnet i2c_piix4 zram crct10dif_pclmul crc32_pclmul crc32c_intel virtio_blk ghash_clmulni_intel serio_raw fuse qemu_fw_cfg virtio_console
[   22.208701] CPU: 2 PID: 546 Comm: kworker/u32:5 Not tainted 6.9.0-rc7nokasan+ #28
[   22.208703] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   22.208704] Workqueue: events_unbound __unix_gc
[   22.208706] RIP: 0010:__unix_gc+0x50e/0x520
[   22.208708] Code: 83 fa 01 0f 84 07 fe ff ff 85 d2 0f 8f 01 fe ff ff be 03 00 00 00 e8 f1 f7 9a ff e9 f2 fd ff ff e8 b7 f9 ff ff e9 28 fd ff ff <0f> 0b e9 07 ff ff ff e8 36 0a 1a 00 66 0f 1f 44 00 00 90 90 90 90
[   22.208710] RSP: 0018:ffffc9000051fd90 EFLAGS: 00010283
[   22.208712] RAX: ffff88810b316f30 RBX: ffffffff83563230 RCX: 0000000000000001
[   22.208713] RDX: 0000000000000001 RSI: ffffffff82956cfb RDI: ffffffff83563880
[   22.208714] RBP: ffffc9000051fe38 R08: 00000000cba2db62 R09: 00000000000003e5
[   22.208715] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000051fdb0
[   22.208716] R13: ffff88810b316a00 R14: ffffc9000051fd90 R15: ffffffff83563860
[   22.208717] FS:  0000000000000000(0000) GS:ffff88842fb00000(0000) knlGS:0000000000000000
[   22.208718] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.208719] CR2: 0000557b30b7406c CR3: 000000011e5be000 CR4: 0000000000750ef0
[   22.208722] PKRU: 55555554
[   22.208723] Call Trace:
[   22.208724]  <TASK>
[   22.208725]  ? __warn.cold+0xb1/0x13e
[   22.208728]  ? __unix_gc+0x50e/0x520
[   22.208730]  ? report_bug+0xe6/0x170
[   22.208733]  ? handle_bug+0x3c/0x80
[   22.208735]  ? exc_invalid_op+0x13/0x60
[   22.208737]  ? asm_exc_invalid_op+0x16/0x20
[   22.208741]  ? __unix_gc+0x50e/0x520
[   22.208747]  process_one_work+0x21f/0x590
[   22.208750]  ? move_linked_works+0x70/0xa0
[   22.208753]  worker_thread+0x1bf/0x3d0
[   22.208756]  ? __pfx_worker_thread+0x10/0x10
[   22.208757]  kthread+0xdd/0x110
[   22.208759]  ? __pfx_kthread+0x10/0x10
[   22.208761]  ret_from_fork+0x2d/0x50
[   22.208763]  ? __pfx_kthread+0x10/0x10
[   22.208765]  ret_from_fork_asm+0x1a/0x30
[   22.208770]  </TASK>
[   22.208771] irq event stamp: 198563
[   22.208772] hardirqs last  enabled at (198569): [<ffffffff811b617d>] console_unlock+0x10d/0x140
[   22.208775] hardirqs last disabled at (198574): [<ffffffff811b6162>] console_unlock+0xf2/0x140
[   22.208777] softirqs last  enabled at (196450): [<ffffffff81110f4d>] __irq_exit_rcu+0x9d/0x100
[   22.208778] softirqs last disabled at (196445): [<ffffffff81110f4d>] __irq_exit_rcu+0x9d/0x100

 net/unix/garbage.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index b87e48e2b51b..beecd0bfbf48 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -170,10 +170,11 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			/* Process the descriptors of this socket */
 			int nfd = UNIXCB(skb).fp->count;
 			struct file **fp = UNIXCB(skb).fp->fp;
+			struct unix_sock *u;
 
 			while (nfd--) {
 				/* Get the socket the fd matches if it indeed does so */
-				struct unix_sock *u = unix_get_socket(*fp++);
+				u = unix_get_socket(*fp++);
 
 				/* Ignore non-candidates, they could have been added
 				 * to the queues after starting the garbage collection
@@ -187,6 +188,14 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			if (hit && hitlist != NULL) {
 				__skb_unlink(skb, &x->sk_receive_queue);
 				__skb_queue_tail(hitlist, skb);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+				u = unix_sk(x);
+				if (u->oob_skb == skb) {
+					WARN_ON_ONCE(skb_unref(u->oob_skb));
+					u->oob_skb = NULL;
+				}
+#endif
 			}
 		}
 	}
@@ -338,19 +347,9 @@ static void __unix_gc(struct work_struct *work)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link) {
+	list_for_each_entry(u, &gc_candidates, link)
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-		spin_lock(&u->sk.sk_receive_queue.lock);
-		if (u->oob_skb) {
-			WARN_ON_ONCE(skb_unref(u->oob_skb));
-			u->oob_skb = NULL;
-		}
-		spin_unlock(&u->sk.sk_receive_queue.lock);
-#endif
-	}
-
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
-- 
2.45.0

