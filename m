Return-Path: <netdev+bounces-207019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97925B05446
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0424E788F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE42550CF;
	Tue, 15 Jul 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjjSfm8h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088782741C6
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567258; cv=none; b=SXOGTOZGjXOb6Upv7qvoF5IzmbbhG3h2sFOigib8VNcIay7Q3WS0CClwbrdi2cK2XsOr5rq7iZVWOR9ZqtQgQAp87bMbmYI8tVH3oPKfXhGb1Alq7JBp5Eo7d3gUeKBSQWYkdLTyuHcdQd9+fuL5dxDsorluKg5StoRAmlF/30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567258; c=relaxed/simple;
	bh=vvEV9AGMWDVula8eIbEWTUIPHY3pwQ1Udwoo3CWwGqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOPrZxd+BiDrHaV+AXK9dXhaXX5YFFLvO5yqot0o3KbW1A7U4WQxngQ9zvGw4fGHuwf0WgDABqahdXpgls16BltqBxByyCGcuIZd20AOG6+Ta/6nrSZ7IyMjJMLJBcRPSi5qSX6oZS37m8mPXaGThMlEqcEf2xrgmVKmk0oXxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjjSfm8h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752567256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KtmJq5SLHjTBciIhRXS4fbE2xHHV6Dpl7qEaO9Jok7Y=;
	b=NjjSfm8h5FdUk6fx6j0HcKIveOmkIuu54aUzVqSpagfWD8Mig1I+UHFhAK4lthqsZafEwA
	+eN+qkOSejTn7VL2EuCSzpc/dACi6A5fiBRYJFLttNToC2TbUjy1eiiyYiHK0ZT2TJ8Ho3
	03ktWmqbzRH+Z1WjKwxwzKsWkwwRuV0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-VC6-odmvPjeAJldSEb3EFQ-1; Tue,
 15 Jul 2025 04:14:10 -0400
X-MC-Unique: VC6-odmvPjeAJldSEb3EFQ-1
X-Mimecast-MFC-AGG-ID: VC6-odmvPjeAJldSEb3EFQ_1752567248
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6AA319560A2;
	Tue, 15 Jul 2025 08:14:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3BCA1800285;
	Tue, 15 Jul 2025 08:14:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] tcp: fix UaF in tcp_prune_ofo_queue()
Date: Tue, 15 Jul 2025 10:13:58 +0200
Message-ID: <b78d2d9bdccca29021eed9a0e7097dd8dc00f485.1752567053.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The CI reported a UaF in tcp_prune_ofo_queue():

BUG: KASAN: slab-use-after-free in tcp_prune_ofo_queue+0x55d/0x660
Read of size 4 at addr ffff8880134729d8 by task socat/20348

CPU: 0 UID: 0 PID: 20348 Comm: socat Not tainted 6.16.0-rc5-virtme #1 PREEMPT(full)
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0x82/0xd0
 print_address_description.constprop.0+0x2c/0x400
 print_report+0xb4/0x270
 kasan_report+0xca/0x100
 tcp_prune_ofo_queue+0x55d/0x660
 tcp_try_rmem_schedule+0x855/0x12e0
 tcp_data_queue+0x4dd/0x2260
 tcp_rcv_established+0x5e8/0x2370
 tcp_v4_do_rcv+0x4ba/0x8c0
 __release_sock+0x27a/0x390
 release_sock+0x53/0x1d0
 tcp_sendmsg+0x37/0x50
 sock_write_iter+0x3c1/0x520
 vfs_write+0xc09/0x1210
 ksys_write+0x183/0x1d0
 do_syscall_64+0xc1/0x380
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf73ef2337
Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffd4f924708 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcf73ef2337
RDX: 0000000000002000 RSI: 0000555f11d1a000 RDI: 0000000000000008
RBP: 0000555f11d1a000 R08: 0000000000002000 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000008
R13: 0000000000002000 R14: 0000555ee1a44570 R15: 0000000000002000
 </TASK>

Allocated by task 20348:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x59/0x70
 kmem_cache_alloc_node_noprof+0x110/0x340
 __alloc_skb+0x213/0x2e0
 tcp_collapse+0x43f/0xff0
 tcp_try_rmem_schedule+0x6b9/0x12e0
 tcp_data_queue+0x4dd/0x2260
 tcp_rcv_established+0x5e8/0x2370
 tcp_v4_do_rcv+0x4ba/0x8c0
 __release_sock+0x27a/0x390
 release_sock+0x53/0x1d0
 tcp_sendmsg+0x37/0x50
 sock_write_iter+0x3c1/0x520
 vfs_write+0xc09/0x1210
 ksys_write+0x183/0x1d0
 do_syscall_64+0xc1/0x380
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 20348:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x38/0x50
 kmem_cache_free+0x149/0x330
 tcp_prune_ofo_queue+0x211/0x660
 tcp_try_rmem_schedule+0x855/0x12e0
 tcp_data_queue+0x4dd/0x2260
 tcp_rcv_established+0x5e8/0x2370
 tcp_v4_do_rcv+0x4ba/0x8c0
 __release_sock+0x27a/0x390
 release_sock+0x53/0x1d0
 tcp_sendmsg+0x37/0x50
 sock_write_iter+0x3c1/0x520
 vfs_write+0xc09/0x1210
 ksys_write+0x183/0x1d0
 do_syscall_64+0xc1/0x380
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888013472900
 which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 216 bytes inside of
 freed 232-byte region [ffff888013472900, ffff8880134729e8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13472
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88800198fb40 ffffea0000347b10 ffffea00004f5290
raw: 0000000000000000 0000000000120012 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88800198fb40 ffffea0000347b10 ffffea00004f5290
head: 0000000000000000 0000000000120012 00000000f5000000 0000000000000000
head: 0080000000000001 ffffea00004d1c81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888013472880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888013472900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888013472980: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
                                                    ^
 ffff888013472a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888013472a80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb

Indeed tcp_prune_ofo_queue() is reusing the skb dropped a few lines
above. The caller wants to enqueue 'in_skb', lets check space vs the
latter.

Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Only build tested: I would appreciate an additional pair of eyes...
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c5baace4b7b..672cbfbdcec1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5517,7 +5517,7 @@ static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb)
 		tcp_drop_reason(sk, skb, SKB_DROP_REASON_TCP_OFO_QUEUE_PRUNE);
 		tp->ooo_last_skb = rb_to_skb(prev);
 		if (!prev || goal <= 0) {
-			if (tcp_can_ingest(sk, skb) &&
+			if (tcp_can_ingest(sk, in_skb) &&
 			    !tcp_under_memory_pressure(sk))
 				break;
 			goal = sk->sk_rcvbuf >> 3;
-- 
2.50.0


