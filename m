Return-Path: <netdev+bounces-293311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOMaAv+GGmo35QgAu9opvQ
	(envelope-from <netdev+bounces-293311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:43:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227B60B7AE
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0603E302167C
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E43803C7;
	Sat, 30 May 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sl68/YLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662637FF49
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780123383; cv=none; b=T0DSppq6TDDxpjkOgaNhIerwKzHxk0i5Upro7ApgKRBNWTbOCGftKz/XMEAxAv/NhXzTWhnrRnf8Ppd3Vv6TnIqtZuLINYZZw6q6BKCxFj5Tc4VDdzYax6NLq2gp1BJj5yHJxBR7quA+cITZWnutapUoKPUI4wop+Dpfw0RZisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780123383; c=relaxed/simple;
	bh=Gm7E/qN7Mm4NFiedRBa8s7HFggRwtXnXY4yoAuN7FFQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V2GY3HR8VYcFwBf3/iCd/Gt3iIaBMimAeSY4xh4wl2gfqAr2EoJ74l7V2J/tqSPVCxwATxaBk2FMLYli4TPLqQm5Ow+PPr1q0jlamdeccqHUD3ASYhD2Vn8srSfOz5T2XoS8HkgEe8HQ1S4tpcIZENisKHSTkIq31rXJ29xGEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sl68/YLE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf11699875so25751505ad.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780123381; x=1780728181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Atve8R+wL0MQUyEhaP7ysWXVXQQXF6kgIBj5kWK4vL0=;
        b=Sl68/YLEGDPMigxmSMQlvdSVXHf8q3JXfxfDxJp64bOyEtIRpo2KUbbA7crhfo/gx/
         UQG4GgSmQDATDOqStDQOJR31JXynS7C+n6AzCKTcHNtA42Bq/p8/uH0eyxOybZG3zukY
         /S79O7Hc9EHwaESpLgdlGHVzPIqYc1tXxXRvXEkwJnpeMBlgQNvm7MVi1HAFl6vFjjHz
         FnlviieCq96ASt/kU2Z3iDO+4bN28qZ/22rwD/g8cyzu4bViJ06C79qsbaD5ZsuF/XGA
         D9Axz+R8ilR3aklZ5ortKUrFJG7U5BG4zNVHaKCDuGBzXg4n6ePUOp1EYM+nBHimBxq0
         uDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780123381; x=1780728181;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Atve8R+wL0MQUyEhaP7ysWXVXQQXF6kgIBj5kWK4vL0=;
        b=ZibGh4cvjY8k+g2EH9tlC9kVJBoNIr80mipmtk48UbxhP2jcaHNZYiSvJRSd3u8JUL
         iU989qUzQgrhs068xxT8thCjt17z7oJFEKcMbazfLRlQDddzVWi+3IuFeY6pIlkFnWWF
         UkveijiuQLJzyQwpv/r+tapFUHs0X2Q4GorgTIXwlUqqvXfLEw1qlg/JWX6HOLwsrIQP
         mNVN8kSLRPVkVCgPjkus0iMsv9lgBitJdqeYb1FAQsyg0M/A+8NwpV9vxl/yL628Vz3C
         OHBH7Dcui74l3F96Mmgs2KI5bSGA6OMKkBepqNo75Z5JKdbJzxpWcPYqAGg1FYJurhUQ
         zIhg==
X-Forwarded-Encrypted: i=1; AFNElJ8rrTSa22gw9Zs3+w3mmlh3bgWnxLU7iL/uz3PkwpIudtRbReF+pl1gu8hAHQYp8FQ+3vAbEt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzntFc1oR4jsLCmPP/kUfRgMZXJW1MB0X1WmzHl7l87t8aT8zEg
	SAqkdYlMI2zqm6JC/pOpqJavdGCwvvVAjPuipt7R0FfFaMd7nX7FZZOpzr4xLNMxsz9WR+spqrI
	DQ+Wv5g==
X-Received: from plem12.prod.google.com ([2002:a17:902:e40c:b0:2bc:db94:6f34])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2acd:b0:2b2:4bbc:14b0
 with SMTP id d9443c01a7336-2bf20533582mr61071385ad.20.1780123381401; Fri, 29
 May 2026 23:43:01 -0700 (PDT)
Date: Sat, 30 May 2026 06:42:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260530064300.340793-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] hsr: Remove WARN_ONCE() in hsr_addr_is_self().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Arvid Brodin <arvid.brodin@alten.se>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+652670cf249077eb498b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,alten.se,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293311-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,652670cf249077eb498b];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0227B60B7AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported the warning [0] in hsr_addr_is_self(),
whose assumption is simply wrong.

hsr->self_node is cleared in hsr_del_self_node(), which
is called from hsr_dellink().

Since dev->rtnl_link_ops->dellink() is called before
unregister_netdevice_many(), there is a window when
user can find the device but without hsr->self_node.

Let's remove WARN_ONCE() in hsr_addr_is_self().

[0]:
HSR: No self node
WARNING: net/hsr/hsr_framereg.c:39 at hsr_addr_is_self+0x211/0x3f0 net/hsr/hsr_framereg.c:39, CPU#0: syz.4.16848/17220
Modules linked in:
CPU: 0 UID: 0 PID: 17220 Comm: syz.4.16848 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:hsr_addr_is_self+0x211/0x3f0 net/hsr/hsr_framereg.c:39
Code: 33 2f 41 0f b7 dd 89 ee 09 de 31 ff e8 c8 b4 c6 f6 09 dd 74 54 e8 0f b0 c6 f6 31 ed eb 53 e8 06 b0 c6 f6 48 8d 3d 2f 50 9c 04 <67> 48 0f b9 3a 31 ed eb 42 e8 c1 13 1f 00 89 c5 31 ff 89 c6 e8 96
RSP: 0018:ffffc900041c70e0 EFLAGS: 00010283
RAX: ffffffff8afdc6ca RBX: ffffffff8afdc4e6 RCX: 0000000000080000
RDX: ffffc90010493000 RSI: 0000000000000948 RDI: ffffffff8f9a1700
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc900041c71e8 R11: fffff52000838e3f R12: dffffc0000000000
R13: ffff888041f9e3c0 R14: ffff888086ee3802 R15: 0000000000000000
FS:  00007f6fe985d6c0(0000) GS:ffff888126176000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f80bd437dac CR3: 0000000025096000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_local_dest net/hsr/hsr_forward.c:592 [inline]
 fill_frame_info net/hsr/hsr_forward.c:728 [inline]
 hsr_forward_skb+0xa11/0x2a80 net/hsr/hsr_forward.c:739
 hsr_dev_xmit+0x253/0x370 net/hsr/hsr_device.c:236
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x2df/0x860 net/core/dev.c:3904
 __dev_queue_xmit+0x1428/0x3900 net/core/dev.c:4870
 neigh_output include/net/neighbour.h:556 [inline]
 ip_finish_output2+0xcec/0x10b0 net/ipv4/ip_output.c:237
 ip_send_skb net/ipv4/ip_output.c:1510 [inline]
 ip_push_pending_frames+0x8b/0x110 net/ipv4/ip_output.c:1530
 raw_sendmsg+0x1547/0x1a50 net/ipv4/raw.c:659
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x7da/0x9c0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6feb62ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fe985d028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6feb8a6090 RCX: 00007f6feb62ce59
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f6feb6c2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6feb8a6128 R14: 00007f6feb8a6090 R15: 00007ffcf01cc488
 </TASK>

Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Reported-by: syzbot+652670cf249077eb498b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a1a861e.b111c304.35cd64.0016.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
targeting net-next since there is no real bug.
---
 net/hsr/hsr_framereg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index b514e43766ef..a28dfd8490c5 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -35,10 +35,8 @@ bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 
 	rcu_read_lock();
 	sn = rcu_dereference(hsr->self_node);
-	if (!sn) {
-		WARN_ONCE(1, "HSR: No self node\n");
+	if (!sn)
 		goto out;
-	}
 
 	if (ether_addr_equal(addr, sn->macaddress_A) ||
 	    ether_addr_equal(addr, sn->macaddress_B))
-- 
2.54.0.823.g6e5bcc1fc9-goog


