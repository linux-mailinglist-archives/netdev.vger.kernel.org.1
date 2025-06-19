Return-Path: <netdev+bounces-199309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD2ADFC43
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739B4179131
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7623C8BE;
	Thu, 19 Jun 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e88L9YN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020623C4FB
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306505; cv=none; b=uTck5PwbdPDl2OH4Hayovx5PVQQOFGyxVTGthMfR7dW3tIgJynKYfMPr492IpsrWKXwmTd8VnwabK9phRY3TwHVPpjGrmyuuuvWj8rS7w9AucwhXqZqoeJv/La9yaN9Hi9+5p02fa51QTo6wynkgrzWoWdRxT286B0oJqefwkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306505; c=relaxed/simple;
	bh=Y/HaYlA9kZbBTwXr0Lw/Il5ljmSBiATFRPnZhIhMtTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+deSrlue+bhSvf+1yayTvzJL4F5aaq0z+be3Y3kS5ddaEjMEfAo4wzrDU/4VC/vm66H+Kiq2Ae7e7M9ofFyA2JzZjrao2EFmcxkRh93zcLjkqzqQHSU5nD6C4y4eBsOXt7k/2eF3JtZZ1lsjLwlnwhhClhwpU25DIEbPD3nYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e88L9YN8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236377f00a1so3259005ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750306502; x=1750911302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wk9Nupygj9cICBNy/EsfOv9bcU/X31yWRKSzV4Eoec=;
        b=e88L9YN8ZL8noMOhRfRENfLGl51F0g9Bi2VZgBYbctgMBLTXthB4NhyKbtfAHAKcVz
         mIrvEk9xGleBdmO0+IgZH/TXjzzpIBhR+L5K+UUX05zKRCXeWPi1OC3cN4JQ8jWPWSfc
         q+fFnsOAqrshxGYBdalcTPmPVrHbCUi3ZYv9V/3lR5NnV9pF7rf6M+nysbUvZ0pjkXOV
         GVZ0tR7r+PDo5w8YExyTmZzd5HVhWWaBjgJEoyxFnSSersJbaYC3eqQwQi7YRJG4EFZ5
         vcisu02hqNxeY1+G2k477I5/qhN7J/6/4pNwqBbZbHU58DdgyvX25B4o8TBMIulnzT11
         EdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750306502; x=1750911302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wk9Nupygj9cICBNy/EsfOv9bcU/X31yWRKSzV4Eoec=;
        b=PaEELUocKtFLhuySsaUn3lRqWZ0FOf46cvMnDlZr4+gnZxsoCd9a/XqN8OEy3yfOek
         bJeWXXtHECQXDVQkYXV7xFaK63Nd6Xnd1px1Mh5DozCf7m8MZWikAaFFpaRWk5ssT5Ds
         x4Qw4OxNGVFOImP7DigAueuWNd3M8b5FvK7Kfp/1TMWoOwk/gt9KTw5kA4t43JfuMUku
         okwM3yuu+vcNEn5uheZeJ0b64jBBizk8G7G38zeP1XoW00Z/dEwDJ5HEJyFmJHPJUtQH
         61iTCp+9PxsJOwWw9WqY8xY8H4yMq/4FZ3TeJkbQKOH7Z8JI4wGvHlO8pwaoCdMy0exq
         05vg==
X-Forwarded-Encrypted: i=1; AJvYcCXkC14mtRSOyJEN0lT/adAapQx+/uUd+OVLpPc/FquujATEda4dXBc+JOf4/JzGd2r/36MqsLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPEhsqz0z5iL5TFAPTdpk76WLG/HZRXEST102gANIkNe2Y9ZB
	Pc+PLgsvPKuurO4yIyC587fvCosLUCd9P+1YbC0vtp63choAnOmve50=
X-Gm-Gg: ASbGnctv4iJtB+URhC0PWwmvZS8zS38AzrlUoKBhgcCpjXy1C6J5ZNW6FkEhLVSNCAm
	KEOVGty5JItuPLE+THwCr3gu7cBysCtXL4Z2SfSbdlBQIJM+Ao8B7vGqt0bCb/J9AUBSoFvp5Ed
	fWDVEXDwEpDU1fZyMrsDa1EFQNdfaiyV3i70PhRE2FZc+Glp1DI8PoxTApiDFE/6MEvJ0n/PTd0
	vOURoLb2P8mMizNtfoheoFAtDIRJ9IZ6bqlA/l6QrVCOf+5GSSw6Y1xK2rDJmi2zBLUT5aQQ4+L
	mVXaJXH6lI4IjVbxqxa3vda9dkipTlY9IW2QK0g=
X-Google-Smtp-Source: AGHT+IEwKH9vHtF7f8/l7eww++WKpJ7R+nzgzsy34rkLwNYFyVNUcCUTjuW1GrrGI5yBdVfnT8gvzQ==
X-Received: by 2002:a17:903:1ac4:b0:234:c5c1:9b73 with SMTP id d9443c01a7336-2366b1379b3mr299998285ad.36.1750306502436;
        Wed, 18 Jun 2025 21:15:02 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781b1sm109928585ad.89.2025.06.18.21.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 21:15:02 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 net 1/4] af_unix: Don't leave consecutive consumed OOB skbs.
Date: Wed, 18 Jun 2025 21:13:55 -0700
Message-ID: <20250619041457.1132791-2-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619041457.1132791-1-kuni1840@gmail.com>
References: <20250619041457.1132791-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Jann Horn reported a use-after-free in unix_stream_read_generic().

The following sequences reproduce the issue:

  $ python3
  from socket import *
  s1, s2 = socketpair(AF_UNIX, SOCK_STREAM)
  s1.send(b'x', MSG_OOB)
  s2.recv(1, MSG_OOB)     # leave a consumed OOB skb
  s1.send(b'y', MSG_OOB)
  s2.recv(1, MSG_OOB)     # leave a consumed OOB skb
  s1.send(b'z', MSG_OOB)
  s2.recv(1)              # recv 'z' illegally
  s2.recv(1, MSG_OOB)     # access 'z' skb (use-after-free)

Even though a user reads OOB data, the skb holding the data stays on
the recv queue to mark the OOB boundary and break the next recv().

After the last send() in the scenario above, the sk2's recv queue has
2 leading consumed OOB skbs and 1 real OOB skb.

Then, the following happens during the next recv() without MSG_OOB

  1. unix_stream_read_generic() peeks the first consumed OOB skb
  2. manage_oob() returns the next consumed OOB skb
  3. unix_stream_read_generic() fetches the next not-yet-consumed OOB skb
  4. unix_stream_read_generic() reads and frees the OOB skb

, and the last recv(MSG_OOB) triggers KASAN splat.

The 3. above occurs because of the SO_PEEK_OFF code, which does not
expect unix_skb_len(skb) to be 0, but this is true for such consumed
OOB skbs.

  while (skip >= unix_skb_len(skb)) {
    skip -= unix_skb_len(skb);
    skb = skb_peek_next(skb, &sk->sk_receive_queue);
    ...
  }

In addition to this use-after-free, there is another issue that
ioctl(SIOCATMARK) does not function properly with consecutive consumed
OOB skbs.

So, nothing good comes out of such a situation.

Instead of complicating manage_oob(), ioctl() handling, and the next
ECONNRESET fix by introducing a loop for consecutive consumed OOB skbs,
let's not leave such consecutive OOB unnecessarily.

Now, while receiving an OOB skb in unix_stream_recv_urg(), if its
previous skb is a consumed OOB skb, it is freed.

[0]:
BUG: KASAN: slab-use-after-free in unix_stream_read_actor (net/unix/af_unix.c:3027)
Read of size 4 at addr ffff888106ef2904 by task python3/315

CPU: 2 UID: 0 PID: 315 Comm: python3 Not tainted 6.16.0-rc1-00407-gec315832f6f9 #8 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:122)
 print_report (mm/kasan/report.c:409 mm/kasan/report.c:521)
 kasan_report (mm/kasan/report.c:636)
 unix_stream_read_actor (net/unix/af_unix.c:3027)
 unix_stream_read_generic (net/unix/af_unix.c:2708 net/unix/af_unix.c:2847)
 unix_stream_recvmsg (net/unix/af_unix.c:3048)
 sock_recvmsg (net/socket.c:1063 (discriminator 20) net/socket.c:1085 (discriminator 20))
 __sys_recvfrom (net/socket.c:2278)
 __x64_sys_recvfrom (net/socket.c:2291 (discriminator 1) net/socket.c:2287 (discriminator 1) net/socket.c:2287 (discriminator 1))
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f8911fcea06
Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
RSP: 002b:00007fffdb0dccb0 EFLAGS: 00000202 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 00007fffdb0dcdc8 RCX: 00007f8911fcea06
RDX: 0000000000000001 RSI: 00007f8911a5e060 RDI: 0000000000000006
RBP: 00007fffdb0dccd0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000202 R12: 00007f89119a7d20
R13: ffffffffc4653600 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 315:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1))
 __kasan_slab_alloc (mm/kasan/common.c:348)
 kmem_cache_alloc_node_noprof (./include/linux/kasan.h:250 mm/slub.c:4148 mm/slub.c:4197 mm/slub.c:4249)
 __alloc_skb (net/core/skbuff.c:660 (discriminator 4))
 alloc_skb_with_frags (./include/linux/skbuff.h:1336 net/core/skbuff.c:6668)
 sock_alloc_send_pskb (net/core/sock.c:2993)
 unix_stream_sendmsg (./include/net/sock.h:1847 net/unix/af_unix.c:2256 net/unix/af_unix.c:2418)
 __sys_sendto (net/socket.c:712 (discriminator 20) net/socket.c:727 (discriminator 20) net/socket.c:2226 (discriminator 20))
 __x64_sys_sendto (net/socket.c:2233 (discriminator 1) net/socket.c:2229 (discriminator 1) net/socket.c:2229 (discriminator 1))
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Freed by task 315:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1))
 kasan_save_free_info (mm/kasan/generic.c:579 (discriminator 1))
 __kasan_slab_free (mm/kasan/common.c:271)
 kmem_cache_free (mm/slub.c:4643 (discriminator 3) mm/slub.c:4745 (discriminator 3))
 unix_stream_read_generic (net/unix/af_unix.c:3010)
 unix_stream_recvmsg (net/unix/af_unix.c:3048)
 sock_recvmsg (net/socket.c:1063 (discriminator 20) net/socket.c:1085 (discriminator 20))
 __sys_recvfrom (net/socket.c:2278)
 __x64_sys_recvfrom (net/socket.c:2291 (discriminator 1) net/socket.c:2287 (discriminator 1) net/socket.c:2287 (discriminator 1))
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

The buggy address belongs to the object at ffff888106ef28c0
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 68 bytes inside of
 freed 224-byte region [ffff888106ef28c0, ffff888106ef29a0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888106ef3cc0 pfn:0x106ef2
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff8881001d28c0 ffffea000422fe00 0000000000000004
raw: ffff888106ef3cc0 0000000080190010 00000000f5000000 0000000000000000
head: 0200000000000040 ffff8881001d28c0 ffffea000422fe00 0000000000000004
head: ffff888106ef3cc0 0000000080190010 00000000f5000000 0000000000000000
head: 0200000000000001 ffffea00041bbc81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888106ef2800: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff888106ef2880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888106ef2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888106ef2980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888106ef2a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
---
 net/unix/af_unix.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 22e170fb5dda..5392aa53cbc8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2680,11 +2680,11 @@ struct unix_stream_read_state {
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 {
+	struct sk_buff *oob_skb, *read_skb = NULL;
 	struct socket *sock = state->socket;
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
 	int chunk = 1;
-	struct sk_buff *oob_skb;
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
@@ -2699,9 +2699,16 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	oob_skb = u->oob_skb;
 
-	if (!(state->flags & MSG_PEEK))
+	if (!(state->flags & MSG_PEEK)) {
 		WRITE_ONCE(u->oob_skb, NULL);
 
+		if (oob_skb->prev != (struct sk_buff *)&sk->sk_receive_queue &&
+		    !unix_skb_len(oob_skb->prev)) {
+			read_skb = oob_skb->prev;
+			__skb_unlink(read_skb, &sk->sk_receive_queue);
+		}
+	}
+
 	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
@@ -2712,6 +2719,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_unlock(&u->iolock);
 
+	consume_skb(read_skb);
+
 	if (chunk < 0)
 		return -EFAULT;
 
-- 
2.49.0


