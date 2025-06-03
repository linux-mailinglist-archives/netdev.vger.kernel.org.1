Return-Path: <netdev+bounces-194763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB5ACC50C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0642918940C9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9B22E3FC;
	Tue,  3 Jun 2025 11:10:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF722A804
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949036; cv=none; b=d/64XRxMjjKndNW7kSlPZcnGQeAbaV4sA+CM2XjS6cUBJYA23eSYH/G7nNTPb4l8vwxWNLeeH4fZqtVzvXotr+4bi2YaAx5eMDoIqHHc4ba5gtChGwnIDCb96PbL8fq2DjD6CFcd/cEWoN6y+OFCrkDGvfrGq84dxPpFVYAuAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949036; c=relaxed/simple;
	bh=BNCUlxhZ6MRKA6nV8I3BNSL71w9PIu3On7WkBXlGqmI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cMZJ3gvL8XhnCS+m9cPSBrXgF+WvbPLmwOLC/zfoqNjbh+tQjfbfZTBAXkSrv3n4aBofkJGsjgsJpXlmMWaM+U4/FOk99cgcT9f89MoP0zWL07agzMBZrVGSsd0TDyz4w0RKftWGJHGh5LZKAf8yfgJibc7pBGIu5UuHARjQ7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddb8522720so12630135ab.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949034; x=1749553834;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjqkPKKfGL6UKsOz6tntxTAr4cz7BoNXJ9xOc8bK7zE=;
        b=OYiw5CJXwGuyQSDmdkNfSRdMzf3jK6useyVGXeuKnESYxSHI2VhUU6+77hq2LdmoqK
         Oh/hXqyqAW4kRV9StmRMX1INyo2lg2nnKZ/pdFWWGKas20BZMnioEoAemr4g6ZZ0ul6r
         PpCEZOiyJDjXu/FRkPsvKy9DDLzzVsjwKelTOrxynxS7W/H5iOJrbFjwJfZ/cMQjouvm
         4iLEDLDC1UpZxi1co4s5Lo8vf+XcM2zj368UThRT47wjVqCwnI/6yjFFxD2FuKj+Qsf/
         PSlDAGDZbe2O946AmT8CxFhae9GyZ4uxz+q/mKL7UlakKBoPc/WpdHyJeMNc+1H/WNI4
         JMsw==
X-Forwarded-Encrypted: i=1; AJvYcCVI2vUA/qKrkgRlbBGsGvdbCqlSO1bUXvljb4YI6sM51ZmmflRKQ3qAtATKzCkkemh5lXfq2zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV78+Aj8/cGx/0UsLrVMwuV4W7++e3TF7qfoL0HmsU9euCbA/u
	GlAhSt0oiO6ArLp8WyZL3S8FYQ760oBlIMgYllPvDwjQLscuzd7c99N1XyiBDjSpDsGI18/GCFn
	4aESp3hRtlxAnITi5pK+ddYgakvRT0p2vF8+PUAKyOj2Hhu4+F06dTSpw33U=
X-Google-Smtp-Source: AGHT+IFOJwmyjFxjskp3g2tFSkQuJwlZqA7Cg9uOzjOV9WdxsZ9HH3JUzqmOqVCwd/tIakPEIcqnTkKGYBJD3XLsIE5lBANmjWzD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380d:b0:3dc:76c6:436f with SMTP id
 e9e14a558f8ab-3dda3394b74mr118384375ab.21.1748949033940; Tue, 03 Jun 2025
 04:10:33 -0700 (PDT)
Date: Tue, 03 Jun 2025 04:10:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ed829.a00a0220.d8eae.006c.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in __igmp_group_dropped
From: syzbot <syzbot+b7da0e231ae4e5a9917f@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d00a83477e7a Merge tag 'input-for-v6.16-rc0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f0dc82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4df26174733e11f3
dashboard link: https://syzkaller.appspot.com/bug?extid=b7da0e231ae4e5a9917f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d00a8347.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ac727dc51c3/vmlinux-d00a8347.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8981faa6f0a2/bzImage-d00a8347.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7da0e231ae4e5a9917f@syzkaller.appspotmail.com

bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 0 UID: 0 PID: 6857 Comm: kworker/u32:24 Not tainted 6.15.0-syzkaller-10954-gd00a83477e7a #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:read_pnet include/net/net_namespace.h:409 [inline]
RIP: 0010:dev_net include/linux/netdevice.h:2713 [inline]
RIP: 0010:__igmp_group_dropped+0xcd/0xe80 net/ipv4/igmp.c:1298
Code: 3c 02 00 0f 85 10 0c 00 00 4d 8b 2c 24 e8 cb 5b 80 01 48 b8 00 00 00 00 00 fc ff df 49 8d bd 08 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 0b 00 00 48 8d bb db 00 00 00 4d 8b bd 08 01
RSP: 0018:ffffc9000408f5d8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888062ee0600 RCX: ffffffff89fda2e7
RDX: 0000000000000021 RSI: ffffffff89fd05dc RDI: 0000000000000108
RBP: 1ffff92000811ebe R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888053fdf000
R13: 0000000000000000 R14: 0000000000000001 R15: ffff88802bef0418
FS:  0000000000000000(0000) GS:ffff8880d6765000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 000000000e382000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 igmp_group_dropped net/ipv4/igmp.c:1335 [inline]
 ip_mc_down+0xc0/0x3c0 net/ipv4/igmp.c:1829
 inetdev_event+0x3b2/0x18a0 net/ipv4/devinet.c:1642
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 dev_close_many+0x319/0x630 net/core/dev.c:1785
 unregister_netdevice_many_notify+0x578/0x26f0 net/core/dev.c:12046
 ops_exit_rtnl_list net/core/net_namespace.c:188 [inline]
 ops_undo_list+0x8fc/0xab0 net/core/net_namespace.c:249
 cleanup_net+0x408/0x890 net/core/net_namespace.c:686
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:read_pnet include/net/net_namespace.h:409 [inline]
RIP: 0010:dev_net include/linux/netdevice.h:2713 [inline]
RIP: 0010:__igmp_group_dropped+0xcd/0xe80 net/ipv4/igmp.c:1298
Code: 3c 02 00 0f 85 10 0c 00 00 4d 8b 2c 24 e8 cb 5b 80 01 48 b8 00 00 00 00 00 fc ff df 49 8d bd 08 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 0b 00 00 48 8d bb db 00 00 00 4d 8b bd 08 01
RSP: 0018:ffffc9000408f5d8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888062ee0600 RCX: ffffffff89fda2e7
RDX: 0000000000000021 RSI: ffffffff89fd05dc RDI: 0000000000000108
RBP: 1ffff92000811ebe R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888053fdf000
R13: 0000000000000000 R14: 0000000000000001 R15: ffff88802bef0418
FS:  0000000000000000(0000) GS:ffff8880d6965000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000003233b000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 02                	cmp    $0x2,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	85 10                	test   %edx,(%rax)
   6:	0c 00                	or     $0x0,%al
   8:	00 4d 8b             	add    %cl,-0x75(%rbp)
   b:	2c 24                	sub    $0x24,%al
   d:	e8 cb 5b 80 01       	call   0x1805bdd
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	49 8d bd 08 01 00 00 	lea    0x108(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 db 0b 00 00    	jne    0xc0f
  34:	48 8d bb db 00 00 00 	lea    0xdb(%rbx),%rdi
  3b:	4d                   	rex.WRB
  3c:	8b                   	.byte 0x8b
  3d:	bd                   	.byte 0xbd
  3e:	08 01                	or     %al,(%rcx)


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

