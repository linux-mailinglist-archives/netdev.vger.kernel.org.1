Return-Path: <netdev+bounces-195937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC4AD2D5A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456553A2B7D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEBC22DFBB;
	Tue, 10 Jun 2025 05:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F674380
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533671; cv=none; b=NENKjtkfKWVAjxWJEMeLypuR4hu0vxaPNX2Vv7y3c1Mh+z/0qupvtKXgrFp3yHURgWdS+j7zEx7pqoWHGmTNDdmtHzkFuxfGYRk28Ipu3iIOYdt2vK5d/W75WhHEkmLVmFD6plihYqPMBjOvL/Pfs/Ru0y9vq5X4k8GzAmBFrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533671; c=relaxed/simple;
	bh=6VpSJdtEcbSZD/yxb26OOPCCIpSkZN67BQVPKGQlZIo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iynYntCuaD5lZO2zG3Ly9+TElaTy6uWYeyWgLv0W4axYsHLfxaLaysjbfwcdWhaXKzapmvhsRu4PrgkG/OrFgOOdTjwSl8r9muhF9BQMruHkqiH+tRDTS6kTK2x5N/6AxkEml1uda2FUr64npALeMrCfE2uilBMs0DVf7B5M8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddcf82bb53so35509105ab.3
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 22:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749533669; x=1750138469;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2tWxx97yjd6EFTVe2WqV87uIDmULQzWW3ARBLyYjVM=;
        b=OBUzuK9JMRxlXi72sVFUvmPYpZRAFZfc3oTrZrpfQmj1eqMnY2REwNpm+YmbqSP9n6
         q8sz1qbCr7NWVlp0QEZ/Ctip9R5LvO2ERfBNQkEhfBnaTsLVhjrxKsGZGwZXuJbXE+L7
         ClZT4NRHah91KWl8Ndf1I8eqxeBsXLNddKAhh55EAd6omJlJGtO7pA7BLYNj7Wb+Cl1E
         ptH1RQTgKin70YaD511RyyVT75/7w9+gWKs6qiccJmYoXxGIFkd8Myf1WHHL1mDPcy0t
         hTtxOiz+d3uckt9Ik568SR9T7Z2Hz+NJ8yVzwBU2YpGHcbYfKvmG/rYFts3txpH16jyk
         Sp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/I3i++4+oAvjN75lMq4KnjOYT6LMWNYjt4xG05DlIpNSZUcdl3UF/OtIJwd64mrWO655dguU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDzJl8pJZLl5B32qaLM7DfBkUMTQM7ow6boZvOlEaw+BavLh5
	u/T95SzY72RC/+zvuwcocGXLDxy/3BSditItkrk/L0ZN3rl7B+CXiU8JRdMoLSSwuSRQkBCGcom
	wKQLc2Kq3QGysE/LgpOF0zGjqu3g4+M8WWkTT+5UeY0k/uznKsrcsJSvshk0=
X-Google-Smtp-Source: AGHT+IHT21MMtg7vGd8ZxPnNFR06hYm+XDG6JfDX4V57TJ4+220OFGCMrBByrZ0PdMo0kSgfEqx0zGJJxqkuRkugBcS7X5Bxt6FJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3788:b0:3dd:d995:5a97 with SMTP id
 e9e14a558f8ab-3ddd9955a9fmr101569795ab.12.1749533669237; Mon, 09 Jun 2025
 22:34:29 -0700 (PDT)
Date: Mon, 09 Jun 2025 22:34:29 -0700
In-Reply-To: <6824d064.a70a0220.3e9d8.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6847c3e5.050a0220.33aa0e.0305.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __linkwatch_run_queue
From: syzbot <syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    19272b37aa4f Linux 6.16-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11458d70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f8ce980f626e3f9
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec2f6a450f0b54af8c8
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14af5a0c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-19272b37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d42ad978905/vmlinux-19272b37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a19eed32f09/Image-19272b37.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __linkwatch_run_queue+0x180/0x2b8 net/core/link_watch.c:244
Read at addr faf00000113fca2d by task kworker/u8:2/40
Pointer tag: [fa], memory tag: [fe]

CPU: 0 UID: 0 PID: 40 Comm: kworker/u8:2 Not tainted 6.16.0-rc1-syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound linkwatch_event
Call trace:
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x108/0x630 mm/kasan/report.c:521
 kasan_report+0x88/0xac mm/kasan/report.c:634
 report_tag_fault arch/arm64/mm/fault.c:332 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:344 [inline]
 __do_kernel_fault+0x170/0x1c8 arch/arm64/mm/fault.c:386
 do_bad_area arch/arm64/mm/fault.c:486 [inline]
 do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:843
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:919
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:455
 el1h_64_sync_handler+0xa4/0x120 arch/arm64/kernel/entry-common.c:533
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
 __linkwatch_run_queue+0x180/0x2b8 net/core/link_watch.c:244 (P)
 linkwatch_event+0x30/0x40 net/core/link_watch.c:304
 process_one_work+0x178/0x2cc kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x250/0x358 kernel/workqueue.c:3402
 kthread+0x130/0x1fc kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

Freed by task 12:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:47
 save_stack_info+0x40/0x158 mm/kasan/tags.c:106
 kasan_save_free_info+0x18/0x24 mm/kasan/tags.c:147
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x74/0x8c mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0xfc/0x30c mm/slub.c:4842
 kvfree+0x3c/0x4c mm/slub.c:5058
 netdev_release+0x30/0x44 net/core/net-sysfs.c:2231
 device_release+0x34/0x90 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0xa4/0x114 lib/kobject.c:737
 netdev_run_todo+0x1f0/0x5a0 net/core/dev.c:11412
 rtnl_unlock+0x10/0x1c net/core/rtnetlink.c:157
 default_device_exit_batch+0x320/0x394 net/core/dev.c:12645
 ops_exit_list net/core/net_namespace.c:206 [inline]
 ops_undo_list+0x10c/0x23c net/core/net_namespace.c:253
 cleanup_net+0x1f8/0x3d0 net/core/net_namespace.c:686
 process_one_work+0x178/0x2cc kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x250/0x358 kernel/workqueue.c:3402
 kthread+0x130/0x1fc kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

The buggy address belongs to the object at fff00000113fc000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 2605 bytes inside of
 4096-byte region [fff00000113fc000, fff00000113fd000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xfaf00000113fc000 pfn:0x513f8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:fdf000001128ff81
flags: 0x1ffc00000000240(workingset|head|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
page_type: f5(slab)
raw: 01ffc00000000240 fdf0000003008000 ffffc1ffc0488e10 ffffc1ffc044f810
raw: faf00000113fc000 0000000000080004 00000000f5000000 fdf000001128ff81
head: 01ffc00000000240 fdf0000003008000 ffffc1ffc0488e10 ffffc1ffc044f810
head: faf00000113fc000 0000000000080004 00000000f5000000 fdf000001128ff81
head: 01ffc00000000003 ffffc1ffc044fe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 fff00000113fc800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 fff00000113fc900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>fff00000113fca00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                         ^
 fff00000113fcb00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 fff00000113fcc00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

