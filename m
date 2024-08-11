Return-Path: <netdev+bounces-117446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18194DFBD
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 04:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B0E1C20F12
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8AC156;
	Sun, 11 Aug 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dPmxWnF9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125EEAE9;
	Sun, 11 Aug 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343361; cv=none; b=cOv3H2yULO8TTsSqbSQxgNtPLwFQBYpELHK6Jwkdei94Yk170HCH5b0mu6OED7+LWxL9AaCGwFIxfPpmFDVAf55NRqzn08eVDz0pWG7IYVB0q+OF0pgzE0VQIZn6TYGOMCfyxzk4JC0IYWCQEsNMu0azGJUmbT0aXu1RuGiqbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343361; c=relaxed/simple;
	bh=v8DKufYxmvvofkx61tKbc1KHfldXx+dNvYdZCdEItBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIRWWCExKCpHLY5pQkwGb0cGYTToKlayvebU6sHzpw6bhMInffYHgfBI69BwogMtftOUzXche8YgNAOU47QRM+VWIxTIbSSQydsovXgVs6ueqirgaZZVHkCJqmUqYDxTd8zJdg+9v4RMknp4LA8rGFREwLKpYB2XDXLmuohOro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dPmxWnF9; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723343360; x=1754879360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xgpc/ewvthV9SRC6DKDl1eQo8LCztM7G1We/se5LPgc=;
  b=dPmxWnF9k5RGtxrMW+UDUbVOBzrYn21TV7M34HB9ygvmoWcJ9NrdKzJ9
   fB5ooswS6sB00EpjuTQFdsdCKPpomrGptW37SrwxPnKkwaRVJit65sC79
   sERDJ/1J52zJtT3q1VtfKOKO+qJOQMbeVBgR7YEx9dXb4AAs1iF8dcupY
   A=;
X-IronPort-AV: E=Sophos;i="6.09,280,1716249600"; 
   d="scan'208";a="224626329"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 02:29:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:14817]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.236:2525] with esmtp (Farcaster)
 id 743dee70-45fb-4acf-8969-fb2a636c50f4; Sun, 11 Aug 2024 02:29:15 +0000 (UTC)
X-Farcaster-Flow-ID: 743dee70-45fb-4acf-8969-fb2a636c50f4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 02:29:15 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 02:29:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Date: Sat, 10 Aug 2024 19:29:03 -0700
Message-ID: <20240811022903.49188-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0000000000003a5292061f5e4e19@google.com>
References: <0000000000003a5292061f5e4e19@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
Date: Sat, 10 Aug 2024 18:29:20 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    33e02dc69afb Merge tag 'sound-6.10-rc1' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=117f3182980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ea26396ff85d23a8929
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-33e02dc6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/573c88ac3233/vmlinux-33e02dc6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/760a52b9a00a/bzImage-33e02dc6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> refcount_t: decrement hit 0; leaking memory.
> WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31

Eric, this is the weird report I was talking about at netdevconf :)

It seems refcount_dec(&tw->tw_dr->tw_refcount) is somehow done earlier
than refcount_inc().

I started to see the same splat at a very low rate after consuming
commit b334b924c9b7 ("net: tcp/dccp: prepare for tw_timer un-pinning").

The commit a bit deferred refcount_inc(tw_refcount) after the hash dance,
so twsk is now visible before tw_dr->tw_refcount is incremented.

I came up with the diff below but was suspecting a bug in another place,
possibly QEMU, so I haven't posted the diff officially.

refcount_inc() was actually deferred, but it's still under an ehash lock,
and inet_twsk_deschedule_put() must be serialised with the same ehash
lock.  Even inet_twsk_kill() performs the ehash lock dance before calling
refcount_dec().

So, it should be impossible that refcount_inc() is not visible after double
lock/unlock and before refcount_dec(), so this report looks bogus to me :S

---8<---
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 337390ba85b4..c3b2f0426e01 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -115,6 +115,8 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
+	refcount_inc(&tw->tw_dr->tw_refcount);
+
 	/* Step 1: Put TW into bind hash. Original socket stays there too.
 	   Note, that any socket with inet->num != 0 MUST be bound in
 	   binding cache, even if it is closed.
@@ -301,7 +303,6 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 		__NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILLED :
 						     LINUX_MIB_TIMEWAITED);
 		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
-		refcount_inc(&tw->tw_dr->tw_refcount);
 	} else {
 		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
 	}
---8<---


> Modules linked in:
> CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> Code: 8b e8 37 85 cf fc 90 0f 0b 90 90 e9 c3 fe ff ff e8 68 34 0d fd c6 05 0d 81 4c 0b 01 90 48 c7 c7 20 2b 8f 8b e8 14 85 cf fc 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 e2 e8 68 fd e9 44 fe ff ff
> RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
> RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
> RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
> R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
> FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  __refcount_dec include/linux/refcount.h:336 [inline]
>  refcount_dec include/linux/refcount.h:351 [inline]
>  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
>  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
>  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
>  tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
>  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
>  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
>  setup_net+0x714/0xb40 net/core/net_namespace.c:375
>  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
>  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
>  ksys_unshare+0x419/0x970 kernel/fork.c:3323
>  __do_sys_unshare kernel/fork.c:3394 [inline]
>  __se_sys_unshare kernel/fork.c:3392 [inline]
>  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f56d7c7cee9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f56d897c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 00007f56d7dac1f0 RCX: 00007f56d7c7cee9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000042000000
> RBP: 00007f56d7cc949e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007f56d7dac1f0 R15: 00007ffe66454be8
>  </TASK>
> 

