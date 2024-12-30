Return-Path: <netdev+bounces-154551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C183C9FE90E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB14188057E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B51ACEAC;
	Mon, 30 Dec 2024 16:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD419ABA3
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735575985; cv=none; b=m8wxG0z3n3yTTNKZ7QO4US+pqhw/Ki7pVgo76ayInYoH0THRuRIJo56FeuVAHAuehBqU94Pd3wQU30/ct+9dh7Rgt5B1Xa/hOmzB/Ro7S10a9yXqGW4aLQ7XIb/4sx60mc3XMllShl9YEkJBdSXknlbQW3pRnpzTYVxErQKwCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735575985; c=relaxed/simple;
	bh=0j71JIev1gT//tyrLdvhftjOAVmUhKvI9fWTLTuRV3A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RKlmZtyQJXBFq1hXFmAQx6LDeCxdoyMNge/5shqj7OMgYPToeMHk9CIWJRvHop5E3OM4r4xm6850b2opOXmXPYHHQ8LJ0AbfC+h106J/cekyBg0yETnN/TuIMLtU47PniXLNXaQXEgkogftTduP6fZ1FxLntdMRH3JA3IbL/dFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so195463925ab.0
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735575982; x=1736180782;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKYwuq+nJf43XqEgILqK8OgaVYV6+L34frL2cwj3pi4=;
        b=O4msonTBRpr43Vyw5QYUkltHOgzKgtMqoFGzdg1d0rj92bnaqSFK86eloYW79MttQC
         gxrFdGIFC4nIJ/czYoQeI6+zonADg0oXplYWnORmgyHcfKnT7Dru8ZUJnOm3crUTp6za
         jc5XVhmJtzvICcRBs+3LFoBQpmRprvfXMjExTVZl9NCbyYTyz+EAsSrsnznkHp3Jqfaf
         8aj2J8jBSiQMAjBHsjvKo3APU8YxYMkYAOrqxPx5UZAkf1mSWYtGHYnG3yfTi3cDgknz
         MhVQvejsSK1batTSn9g83dkDQGLjn3DJB8wAztVYlub8hF6sDnPQZ98qT/OKaskTTWVw
         oZJA==
X-Forwarded-Encrypted: i=1; AJvYcCU9zvX6Dyo6qVb3cGuO7hR+4tWC6t5imKuSJQBs3KVgdfdfQ6XLVebUUWxX1lQQ1m3aNubkZVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IkNDHv4bOtLnLRFuggCIv5DwJ6J6ySqpn+lmCs2jQN6JN254
	STg2rWUqO7iJ8lnXUAMBqZ/AKbJD2fsNipnnayAKj6kudZw8d0Z1dxpAK1LiYKghRvOSdLavo55
	skD2HNkHNi+DD6wa2MzFXEErC8gpvXsXNW5uAucxOpdXi2J+QvfUenY0=
X-Google-Smtp-Source: AGHT+IFoZLWvD9mmxDM8avnpI9ZQ9l3AGHquZRnZp2n9j3MSFs00NiCT2HRE6tLVe/hB3Cv0kqonmih2k6ooLxkOGWzLXbuJmbuE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:3a7:7e0f:777d with SMTP id
 e9e14a558f8ab-3c2d2d50ddemr240386055ab.11.1735575982584; Mon, 30 Dec 2024
 08:26:22 -0800 (PST)
Date: Mon, 30 Dec 2024 08:26:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6772c9ae.050a0220.2f3838.04c7.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in ila_nf_input
From: syzbot <syzbot+47e761d22ecf745f72b9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d6ef8b40d075 Merge tag 'sound-6.13-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b2d018580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=47e761d22ecf745f72b9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121492c4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3c180522af9/disk-d6ef8b40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3cdc58d90ea0/vmlinux-d6ef8b40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/553cec07cad4/bzImage-d6ef8b40.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47e761d22ecf745f72b9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rht_key_hashfn include/linux/rhashtable.h:159 [inline]
BUG: KASAN: slab-use-after-free in __rhashtable_lookup.constprop.0+0x426/0x550 include/linux/rhashtable.h:604
Read of size 4 at addr ffff888028f40008 by task dhcpcd/5501

CPU: 1 UID: 0 PID: 5501 Comm: dhcpcd Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 rht_key_hashfn include/linux/rhashtable.h:159 [inline]
 __rhashtable_lookup.constprop.0+0x426/0x550 include/linux/rhashtable.h:604
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 ila_lookup_wildcards net/ipv6/ila/ila_xlat.c:127 [inline]
 ila_xlat_addr net/ipv6/ila/ila_xlat.c:652 [inline]
 ila_nf_input+0x1ee/0x620 net/ipv6/ila/ila_xlat.c:185
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xbb/0x200 net/netfilter/core.c:626
 nf_hook.constprop.0+0x42e/0x750 include/linux/netfilter.h:269
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ipv6_rcv+0xa4/0x680 net/ipv6/ip6_input.c:309
 __netif_receive_skb_one_core+0x12e/0x1e0 net/core/dev.c:5672
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5785
 process_backlog+0x443/0x15f0 net/core/dev.c:6117
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6883
 napi_poll net/core/dev.c:6952 [inline]
 net_rx_action+0xa94/0x1010 net/core/dev.c:7074
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 e6 91 59 f6 48 89 df e8 1e 11 5a f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 45 01 4b f6 65 8b 05 b6 24 e7 74 85 c0 74 16 5b
RSP: 0018:ffffc900034378e0 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff888030daec40 RCX: 1ffffffff2039431
RDX: 0000000000000000 RSI: ffffffff8b4cd280 RDI: ffffffff8bb17000
RBP: 0000000000000282 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff901ce3d7 R11: 0000000000000004 R12: ffff888034fccbc0
R13: ffff888030daec40 R14: 1ffff92000686f31 R15: ffff888034fcca40
 sock_def_readable+0x15f/0x610 net/core/sock.c:3453
 unix_dgram_sendmsg+0xf47/0x1940 net/unix/af_unix.c:2167
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 sock_write_iter+0x4fe/0x5b0 net/socket.c:1147
 do_iter_readv_writev+0x532/0x7f0 fs/read_write.c:820
 vfs_writev+0x363/0xdd0 fs/read_write.c:1050
 do_writev+0x297/0x340 fs/read_write.c:1096
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f29650f6e03
Code: 89 c7 48 89 44 24 08 e8 6a f2 f9 ff 48 8b 44 24 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 6d 48 8b 15 f6 5f 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffe3c2abb38 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f29650286c0 RCX: 00007f29650f6e03
RDX: 0000000000000002 RSI: 00007ffe3c2abb80 RDI: 000000000000000b
RBP: 00007ffe3c2cbee8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3c2bbd34 R14: 0000000000000030 R15: 0000000000000000
 </TASK>

Allocated by task 12687:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 tomoyo_realpath_from_path+0xbf/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2ad/0x3c0 security/tomoyo/file.c:771
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0x84/0x1e0 security/security.c:3105
 do_dentry_open+0x57e/0x1ea0 fs/open.c:928
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12687:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 tomoyo_realpath_from_path+0x1b7/0x710 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2ad/0x3c0 security/tomoyo/file.c:771
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0x84/0x1e0 security/security.c:3105
 do_dentry_open+0x57e/0x1ea0 fs/open.c:928
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888028f40000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 8 bytes inside of
 freed 4096-byte region [ffff888028f40000, ffff888028f41000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28f40
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a3d001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12687, tgid 12687 (udevd), ts 418533816857, free_ts 418533016660
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 e6 91 59 f6       	call   0xf65991f9
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 1e 11 5a f6       	call   0xf65a1139
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 23                	jne    0x46
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 37                	jne    0x61
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 45 01 4b f6       	call   0xf64b0179
  34:	65 8b 05 b6 24 e7 74 	mov    %gs:0x74e724b6(%rip),%eax        # 0x74e724f1
  3b:	85 c0                	test   %eax,%eax
  3d:	74 16                	je     0x55
  3f:	5b                   	pop    %rbx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

