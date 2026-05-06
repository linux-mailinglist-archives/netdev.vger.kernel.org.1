Return-Path: <netdev+bounces-284720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6gKNKvPm+mlIUAMAu9opvQ
	(envelope-from <netdev+bounces-284720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BAA4D6E68
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D1953004923
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AADF346760;
	Wed,  6 May 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ukh5HSID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CC270540
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050799; cv=none; b=AbJCaespj4d2ws0yXaAqnHmbLBmPsgPgL1j8crxMh9G4uVbfZoQAOioUObwScOQTZzycJl5EbgtQgTknL+FSdDsqiRSGxcOGjeB38g4YtItlNclLpgNnLZANtThExJKM+XuNrz1nUBaBvoU42ZLi5wlm6V0QXqM+dft/9oA+4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050799; c=relaxed/simple;
	bh=J5E0Z9EfzX69aBt+O2QjZkhOuiGsptGo9y8y8l9QZns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UuWc2UXE4OwGhh7iyrYFGH3PJMTtAOCFAr4e5CoaHlK74yBIPZDXqmff+B4cMuN80Cdp4RfR9QH3h2znpAttWPWYw0rDth1+MyJXaWWLeOY+fx3wxr+OiyI9/tQig45DxOzAxZs/XwwWrfQuWx30cxQltBzLrucVunFhNMlMD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ukh5HSID; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2d83e7461so113032375ad.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778050797; x=1778655597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WJUsARZvVwbWMC3vo755HAyzMP2leXxye2JnHo/ZcMY=;
        b=Ukh5HSIDEJkLKFDYskkB2tOWF2yoFk2R/c+iUkkyFTfHoDnfbV8EYbU00cQTwm+czH
         yhbmd6cCBuk4i3cqHseoFBBTsoRbqdLv6R02LjZVQsVrF1grmw8LjkhRnHQSLi7OnGUS
         Nbb7/N4B9+Oe0q4fHELt6DaIy7MxczJXN2Fnx0eUrKLaVVLL9Ba//M14wXFX3a+g5kDO
         U12mQhbkjbi0IW0RXThT/oHd5Q9Em3d+NQAh2F4dBA/K8H1CJpqoMTsVZPDRE2KRQYBC
         7x0VgQD6wiOH6vf6M0gyLLq7zfde2iLvHNbvhh8j8WZ9f3Bpp1NWFmQidrQs6mbLMRLR
         wMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050797; x=1778655597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJUsARZvVwbWMC3vo755HAyzMP2leXxye2JnHo/ZcMY=;
        b=QOXAS3syxejX776ZhUVwuTUer1p2rE4AW9Klnz2nTX2Ha3sZ9eEWw1qDCPkvQ7B7Rm
         PY+Fh4Kd11bXDkjMM/hgqu327jR+Nn6eSVwhtWL7qJzmMC5cIggd2LYeihIvN1iEt26R
         8EKdf3B/GdrhTEmMwwAFZZuJxYi5rojLhVCqnpWQ1Q3eVD4E0bHLfxN5WaD4++YRxgvk
         2Y5IAC3ZYFaIE49+5c4PgA+GeReViDE6S9FdGG19HU8TM/9eqLUOUwEFvWw5t3O2JjHX
         Z15UNffGxM8DLwUl4IOTYJD22IqdeWKdm1ghBkdap7Jxkai9pE8MzhWO7UcPch+tzDsr
         0Cng==
X-Forwarded-Encrypted: i=1; AFNElJ8VSBEFcTyJ6/K3kMVBbMni99AxKOFpY3aavoO0oDClo7ciaRb2lsWNr6jdYqAaXOCqN8e+Z5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+8wYfChDGDFgiwEw2EKBnbNWa8Q4oqiU3Y+pPTMggSfPHrbm
	RFPiw1PQXRAIS/MioQgUMOKrSTvCOi6a4Jq6V2uRxvT0hjjUzGZRnpIe8SGcPkobs+CODNvjvVe
	Mlux/7g==
X-Received: from plbll14.prod.google.com ([2002:a17:903:90e:b0:2ba:2916:59da])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:390d:b0:2ba:7181:7059
 with SMTP id d9443c01a7336-2ba798a9773mr21301225ad.27.1778050796946; Tue, 05
 May 2026 23:59:56 -0700 (PDT)
Date: Wed,  6 May 2026 06:59:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506065955.1695753-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipmr: Call ipmr_fib_lookup() under RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 28BAA4D6E68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284720-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,googlegroups.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlegroups.com:email]

Yi Lai reported RCU splat in reg_vif_xmit() below. [0]

When CONFIG_IP_MROUTE_MULTIPLE_TABLES=n, ipmr_fib_lookup()
uses rcu_dereference() without explicit rcu_read_lock().

Although rcu_read_lock_bh() is already held by the caller
__dev_queue_xmit(), lockdep requires explicit rcu_read_lock()
for rcu_dereference().

Let's move up rcu_read_lock() in reg_vif_xmit() to
cover ipmr_fib_lookup().

[0]:
WARNING: suspicious RCU usage
7.1.0-rc2-next-20260504-9d0d467c3572 #1 Not tainted
 -----------------------------
net/ipv4/ipmr.c:329 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz.2.17/1779:
 #0: ffffffff87896440 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #0: ffffffff87896440 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:891 [inline]
 #0: ffffffff87896440 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x239/0x4140 net/core/dev.c:4792
 #1: ffff88801a199d18 (_xmit_PIMREG#2){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
 #1: ffff88801a199d18 (_xmit_PIMREG#2){+...}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4795 [inline]
 #1: ffff88801a199d18 (_xmit_PIMREG#2){+...}-{3:3}, at: __dev_queue_xmit+0x1d5d/0x4140 net/core/dev.c:4865

stack backtrace:
CPU: 1 UID: 0 PID: 1779 Comm: syz.2.17 Not tainted 7.1.0-rc2-next-20260504-9d0d467c3572 #1 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x121/0x150 lib/dump_stack.c:120
 dump_stack+0x19/0x20 lib/dump_stack.c:129
 lockdep_rcu_suspicious+0x15b/0x1f0 kernel/locking/lockdep.c:6878
 ipmr_fib_lookup net/ipv4/ipmr.c:329 [inline]
 reg_vif_xmit+0x2ee/0x3c0 net/ipv4/ipmr.c:540
 __netdev_start_xmit include/linux/netdevice.h:5382 [inline]
 netdev_start_xmit include/linux/netdevice.h:5391 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x170/0x700 net/core/dev.c:3905
 __dev_queue_xmit+0x1df1/0x4140 net/core/dev.c:4871
 dev_queue_xmit include/linux/netdevice.h:3423 [inline]
 packet_xmit+0x252/0x370 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x39ad/0x5650 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:797 [inline]
 __sock_sendmsg net/socket.c:812 [inline]
 ____sys_sendmsg+0xa21/0xba0 net/socket.c:2716
 ___sys_sendmsg+0x121/0x1c0 net/socket.c:2770
 __sys_sendmsg+0x177/0x220 net/socket.c:2802
 __do_sys_sendmsg net/socket.c:2807 [inline]
 __se_sys_sendmsg net/socket.c:2805 [inline]
 __x64_sys_sendmsg+0x80/0xc0 net/socket.c:2805
 x64_sys_call+0x1d9c/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc1/0x1020 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f37e563ee5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe5caa7fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000005c5fa0 RCX: 00007f37e563ee5d
RDX: 0000000000000000 RSI: 00002000000012c0 RDI: 0000000000000004
RBP: 00000000005c5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000005c5fac R15: 00000000005c5fa0
 </TASK>

Fixes: b3b6babf4751 ("ipmr: Free mr_table after RCU grace period.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Yi Lai <yi1.lai@intel.com>
Closes: https://lore.kernel.org/netdev/afrY34dLXNUboevf@ly-workstation/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 05fb6eefe0be..2628cd3a93a6 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -537,15 +537,16 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 	};
 	int err;
 
+	rcu_read_lock();
 	err = ipmr_fib_lookup(net, &fl4, &mrt);
 	if (err < 0) {
+		rcu_read_unlock();
 		kfree_skb(skb);
 		return err;
 	}
 
 	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 	DEV_STATS_INC(dev, tx_packets);
-	rcu_read_lock();
 
 	/* Pairs with WRITE_ONCE() in vif_add() and vif_delete() */
 	ipmr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
-- 
2.54.0.545.g6539524ca2-goog


