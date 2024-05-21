Return-Path: <netdev+bounces-97363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D38CB0B9
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6AB1F2347D
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2FD762E0;
	Tue, 21 May 2024 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCOoIxTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF71E87C
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302983; cv=none; b=Sk85vVpRUYDHEPj4q2JVqst4NqI60C5sbWdCJqh9jnqGZr8Z0QTVu/wSHCqQAD9HHWaVVcAUwWl2wA3jkUYveER/TP4ddrzK3SebbGfV7yh9SqszRoKryLuc2qIuW2TxkvPhXhxaIRfsggp6cZiG59DDGXjhVYhB2Enz+4XIJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302983; c=relaxed/simple;
	bh=kc5w2PkHZ9cvU/u/JPzujA+YKbOvjeKG2iVe07fS000=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jupOGHMHkmDMhTn8eRKYeQftgbdnaKbI8cOJDS4uselnk+iNf0G2Xqg9eUgAsH0ZibAEaBcHBxpd++5FxHwLkVNreeNJx18B/o+7P2SG/SNXhhQLlkEMSM7cXuWuLE28QzEhMFmVcHX4jVkU797Af32bAWRu3DiUQiR0Wj72hYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCOoIxTe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4f2b1c997so412941b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302981; x=1716907781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gElkWZYoiosZEVwshbfNZwy0DCArJyB+G3iEWleFK4g=;
        b=CCOoIxTeQGouXO6gBRou2QfhyiO/I6h5tRongw9bqMormtfNCub5nyup8BwvKpbdFb
         X0TEF+EkEpCzMQsr8IvNdrMx5l5lr6ysSKAoSEOvTDNg3xFqC/Aar4JVAfX0l/T0xrce
         sk51n5HS/BZKUrsi+EMSkB5hRC07hFsMMRA8ZWtmgts8ZCZTX0HNGrSiVlm3AzujkS2h
         +AxVnlz+LF8fQQqfGX260f/91lz0idIn8BUyxy3LgPfJaksxFGDNlYYKJWp2xfOapW1w
         vpFVeHB6yxQtCZwsXRWkHPMuKKNptEvIFFKjYGFA0msDFlGP8/NJBcJbKPWRU2SDAUwG
         1cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302981; x=1716907781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gElkWZYoiosZEVwshbfNZwy0DCArJyB+G3iEWleFK4g=;
        b=mRr/nEIgEce1+S97zj319ice5EaRvLqWcy7nHM5BfEkqFHJ8oF/+Pe6Y1qQtFmF3M6
         CTl9vgB2ex4GmAtR+vMKgucKNULAWSqKeB1IIjQ7i5PzpOVM6P9mce4pqLPuCHkTXBAB
         CceSPw1STokiYHJcGVjO76jDF483kWvlWmo/BkzvLb3xAi6o77cY1oxUIhBvscatHiJg
         O0gkWLKOVXlLFImUBTJjTm9OIWY5tX4PeU5u4YCBzNqf7kO2SWs7u+2dawUq2I6JMiGt
         kKvjE+jb7JLczYsCkWuen4QOfVKlwLuGdSHEbMAxdyf9IfSOS2pyd5s8gP1SHO7NVVA6
         xQaA==
X-Gm-Message-State: AOJu0YwNFa+Xtf5kz+PkKvsv5XPeVn9kFcT0YCEjlJ72BTme8JlkGchd
	XJhDKqbUxGQ+m4X0bh7yE+tnz4KniSMH6TaplEO31q3LeEcpnk+3
X-Google-Smtp-Source: AGHT+IHQo/MenlCpuZlSxD/r8lum4MnGbuSx76VXxA+r3QsMEdbcmSwFqFJjKMjsEt1hAlIoxUHFsQ==
X-Received: by 2002:a05:6a00:1824:b0:6ec:ff1b:aa0b with SMTP id d2e1a72fcca58-6f4e02d3698mr35147450b3a.18.1716302981355;
        Tue, 21 May 2024 07:49:41 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66691sm21539834b3a.16.2024.05.21.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:49:40 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Subject: [PATCH net] Revert "rds: tcp: Fix use-after-free of net in reqsk_timer_handler()."
Date: Tue, 21 May 2024 22:49:30 +0800
Message-Id: <20240521144930.23805-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This reverts commit 2a750d6a5b365265dbda33330a6188547ddb5c24.

Syzbot[1] reported the drecrement of reference count hits leaking memory.

If we failed in setup_net() and try to undo the setup process, the
reference now is 1 which shouldn't be decremented. However, it happened
actually.

After applying this patch which allows us to check the reference first,
it will not hit zero anymore in tcp_twsk_purge() without calling
inet_twsk_purge() one more time.

[1]
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
 inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
 inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
 tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
 tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
 setup_net+0x714/0xb40 net/core/net_namespace.c:375
 copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x419/0x970 kernel/fork.c:3323
 __do_sys_unshare kernel/fork.c:3394 [inline]
 __se_sys_unshare kernel/fork.c:3392 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56d7c7cee9

Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in reqsk_timer_handler().")
Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2eca27bdcb48ed330251
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
The reverted patch trying to solve another issue causes unexpected error as above. I
think that issue can be properly analyzed and handled later. So can we revert it first?
---
 net/ipv4/tcp_minisocks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b93619b2384b..46e6f9db4227 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -399,6 +399,10 @@ void tcp_twsk_purge(struct list_head *net_exit_list)
 			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
 			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo);
 		} else if (!purged_once) {
+			/* The last refcount is decremented in tcp_sk_exit_batch() */
+			if (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) == 1)
+				continue;
+
 			inet_twsk_purge(&tcp_hashinfo);
 			purged_once = true;
 		}
-- 
2.37.3


