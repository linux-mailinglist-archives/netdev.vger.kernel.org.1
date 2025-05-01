Return-Path: <netdev+bounces-187226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5166AA5DAC
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFAB1BC3846
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE4224237;
	Thu,  1 May 2025 11:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164821B9E4
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098200; cv=none; b=llNxg6vhZkegG/DJM20FcnhSVy9uefGNtBRbOPWH1y5A7bwwhVgEVeB51ocUwSCkqeA/nHu+4OPN0VqX0cWPlom36szrfd9WwZpS20kIuAwJI263a3l2+GXYqxHuD2oXAZnroB4n13RdOE0cUgPnj2760qv5f63d6Mzs8yxOk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098200; c=relaxed/simple;
	bh=4gTKdtljQPBiO3aRC+hgpLo5zZXVfa0Lh/S514uSFGE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f6lnuE61u/zZS69HvdSPN1ztQXYADOegyqRNHKANnX2PPudLbMw03hlmwUTY8637Xp8Wp6q6GMHi7LBe9aV7LL2ESpSa7RTN1iGD2sx0I0AMTjFh5zuGl1L/unO0wzBkcByNfyqP9ih7ah27tWIEKVsf10iOOaIbnoCNOJrfyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d586b968cfso15272875ab.1
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 04:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746098198; x=1746702998;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXNiIzTTjG23gteaOvGMvdaSZc5YQCbG/bQ1e4duVaY=;
        b=HNyfph+cLveNMa2vhampH4Nc/tGELnL49B8AklEl1H78ioe7NZo05NujjZX6P7ps0A
         sgayNgDIwyRcpS2T2erBTQJ0ejXTR3rC8UAHRd5FRtHB0W6iJBPQhn7h8x+5slBa+x0L
         p9quj+oZDfpu98UupsAgL427QbElveuMvfyl9MuKxDZkv9mON5oGGkICBcUaaEgw//J/
         kf8uGF216nApKDynyF81PrOEXK65DcmGjQz6JLaX2EmEi4KezCTI9AIHWmOME0sJkZEY
         2SEaYduNOr7GAHQGd+y3GnK1spGUyGugvXCnFJNQd2cM0mrRvsKfS8Ziy+bKxT8RaJq2
         zcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOITagKK1W2U+IbXsdGan61DssV6dLR5omupP38s0SNjmtSt051OyyPfrspC8ygqzlG9++mR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18L21BVCERW25bmIJEGAAgfzk/tEEyumTWgZPpPuRuaJ5RVeI
	2jYwwURj37qrRwAZ/JNpemBhllHg4a0yG70eCi7NXV1/qyaH73zxgQX8C2FoYdXMYE7D4V2uDpV
	jse9fhBYB05PmtzM5qmZRf/oBiLe7XqelzLOjD8jVEeGhpRLVn917JXk=
X-Google-Smtp-Source: AGHT+IHdn86pmaJ9xL44LNSpIuC6C1sHAsBEPzi2hlAjzwtJssgMTUOO29OxNrY15iYLuJ62IfaKnkT/rVCZSHX2GpndscLjXib5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca49:0:b0:3d8:2023:d057 with SMTP id
 e9e14a558f8ab-3d967fc2bb1mr59242905ab.11.1746098197823; Thu, 01 May 2025
 04:16:37 -0700 (PDT)
Date: Thu, 01 May 2025 04:16:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68135815.050a0220.3a872c.0010.GAE@google.com>
Subject: [syzbot] [net?] WARNING in rt6_multipath_rebalance (2)
From: syzbot <syzbot+d842f24c4e2bae159341@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc17b4b9c332 Merge branch 'io_uring-zcrx-fix-selftests-and..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=125b8374580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e367ce4a19f69ba
dashboard link: https://syzkaller.appspot.com/bug?extid=d842f24c4e2bae159341
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e09cf367bdd/disk-cc17b4b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ab63344d74c/vmlinux-cc17b4b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14915e0e32b3/bzImage-cc17b4b9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d842f24c4e2bae159341@syzkaller.appspotmail.com

batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
------------[ cut here ]------------
WARNING: CPU: 0 PID: 36 at net/ipv6/route.c:4822 rt6_multipath_rebalance+0x455/0x8b0 net/ipv6/route.c:4822
Modules linked in:
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.15.0-rc3-syzkaller-00584-gcc17b4b9c332 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Workqueue: netns cleanup_net
RIP: 0010:rt6_multipath_rebalance+0x455/0x8b0 net/ipv6/route.c:4822
Code: ff ff 44 89 e1 80 e1 07 38 c1 0f 8c 85 fe ff ff 4c 89 e7 e8 2d a0 13 f8 e9 78 fe ff ff e8 e3 aa b1 f7 eb 05 e8 dc aa b1 f7 90 <0f> 0b 90 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc90000ad6ee0 EFLAGS: 00010293
RAX: ffffffff8a0e129d RBX: ffff88802f515000 RCX: ffff8881412d9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200015add4 R12: ffff88802f5150de
R13: ffff88802f515090 R14: 0000000000000000 R15: 1ffff11005ea2a12
FS:  0000000000000000(0000) GS:ffff8881260c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94077eeb68 CR3: 000000000dd36000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fib6_ifdown+0x401/0x4c0 net/ipv6/route.c:4942
 fib6_clean_node+0x24a/0x590 net/ipv6/ip6_fib.c:2249
 fib6_walk_continue+0x678/0x910 net/ipv6/ip6_fib.c:2174
 fib6_walk+0x149/0x290 net/ipv6/ip6_fib.c:2222
 fib6_clean_tree net/ipv6/ip6_fib.c:2302 [inline]
 __fib6_clean_all+0x234/0x380 net/ipv6/ip6_fib.c:2318
 rt6_sync_down_dev net/ipv6/route.c:4970 [inline]
 rt6_disable_ip+0x120/0x720 net/ipv6/route.c:4975
 addrconf_ifdown+0x15d/0x1880 net/ipv6/addrconf.c:3854
 addrconf_notify+0x1bc/0x1010 net/ipv6/addrconf.c:-1
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2266 [inline]
 call_netdevice_notifiers net/core/dev.c:2280 [inline]
 dev_close_many+0x29c/0x410 net/core/dev.c:1783
 unregister_netdevice_many_notify+0x834/0x2320 net/core/dev.c:12006
 unregister_netdevice_many net/core/dev.c:12099 [inline]
 default_device_exit_batch+0x819/0x890 net/core/dev.c:12601
 ops_exit_list net/core/net_namespace.c:206 [inline]
 ops_undo_list+0x522/0x990 net/core/net_namespace.c:253
 cleanup_net+0x4c5/0x8a0 net/core/net_namespace.c:686
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

