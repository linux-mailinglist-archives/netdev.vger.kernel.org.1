Return-Path: <netdev+bounces-293707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFEAHYFxHWrFawkAu9opvQ
	(envelope-from <netdev+bounces-293707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:48:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6BA61E916
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ED6B3016809
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B8359A6D;
	Mon,  1 Jun 2026 11:47:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F53546D9
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314449; cv=none; b=agEOohOVF6HPIVJ2n8AaU3kO9yAe2NeVdysCQzMvKbBeufN9C4zg0bsW6ASrt+gFqoqNsZMxtvb6+wKh+vQFGicZSgc5TNiy78BjlopFN0hpFyImrK3meCq+1ox+0+GxH/OgLnqWBETTFbg/WmnYLm38pSYkZCpjA4jj6yBROpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314449; c=relaxed/simple;
	bh=Qqyr6FAacKw7J1RhYLjYqhqlQ2ntrXbi0b1wv+1zrMc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PS/ZFDx7UsRl9N8xTYXkGlsoFeOCrNcWS4nmOLP7aljJxBh3jSPUgBKGv7gnTB4EMlSwjav1R9mUCoNOVWu4Uhm7SAOfIeItrYC6TDxe6gF+Fi7eUcxhHGtYNLiYuKGajYW9RMGkaMcFgQwjlA5KGi4QqNQFihE4k3NQ8QrMAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e60b15b7dbso16783458a34.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780314446; x=1780919246;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjQsbguA7MtAUcpY+JLOi0qz9r9pfTNnJyoO8Ib7PVQ=;
        b=mCU+kDQSCnSFFLK3Z9SdO/58fAEQGdHg5VVIsH2f7/w0kiR4k209Bu7hQpmw+Mtclx
         RL745dGTz1ow/USD8p0LfZsv8jYucC5WZWtCEzjyJuprk/n1jv2jQp1seAiWT4EVtNqy
         ZBB//VYZBNpYkSLGQ3vddC+7XQuHMcClg1HpXvEJAN6OTQEPt376kHRAFnR9FzRnRf8q
         0Wa4WSwtzyCe3Xjdx9GmuZIqw5PqR/zlKIajCpadz2vzyFTXy+/vCWk0+xxmoBh5A6Kl
         fT+zDwWqePNs+Z7nNZNKj8QjZM/YXYyKRcRc8t7HK0hEJXHpUjNwpsk9BVkn39RP0lC9
         XqoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2/2PRGbTE45kph2IfZELNDmYNBHij58PHv31NlIUqklbGYi41Dhv6+ncEAczHLvyYD0x2F2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dEMWQ8DJwsU1BP0wTxBZTN+eUjNtlr1xB2NZyez0VslKfXf5
	S+aSPjYCHuIBzM6tBp7RNeje0FDUjh20i6XhdYsvpe/HNqZLxBSM79AfUlGTlkNemABMLq4TJte
	xQ4XxSyQW6Odtvmp1Q7joifwK4/HaVrJihkNJkxyYWO/oaP/Bohi+iQt8poI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8187:b0:694:8d2e:390e with SMTP id
 006d021491bc7-69e04456877mr5723114eaf.39.1780314446592; Mon, 01 Jun 2026
 04:47:26 -0700 (PDT)
Date: Mon, 01 Jun 2026 04:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1d714e.c1435f33.295d1e.2a35.GAE@google.com>
Subject: [syzbot] [net?] KASAN: use-after-free Read in filemap_map_pages
From: syzbot <syzbot+b72767277f29b6407083@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8d24a1331e060dda];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-293707-lists,netdev=lfdr.de,b72767277f29b6407083];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlegroups.com:email,appspotmail.com:email,goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: DA6BA61E916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    d60ec36cab33 Merge tag 'mm-hotfixes-stable-2026-05-25-16-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124501ec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d24a1331e060dda
dashboard link: https://syzkaller.appspot.com/bug?extid=b72767277f29b6407083
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/864236422e21/disk-d60ec36c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/858219f0a900/vmlinux-d60ec36c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/809d091c238e/bzImage-d60ec36c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b72767277f29b6407083@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ptep_get include/linux/pgtable.h:461 [inline]
BUG: KASAN: use-after-free in filemap_map_order0_folio mm/filemap.c:3856 [inline]
BUG: KASAN: use-after-free in filemap_map_pages+0xc7a/0x2100 mm/filemap.c:3932
Read of size 8 at addr ffff88807bed6d50 by task syz.1.7707/30545

CPU: 1 UID: 0 PID: 30545 Comm: syz.1.7707 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 ptep_get include/linux/pgtable.h:461 [inline]
 filemap_map_order0_folio mm/filemap.c:3856 [inline]
 filemap_map_pages+0xc7a/0x2100 mm/filemap.c:3932
 do_fault_around mm/memory.c:5867 [inline]
 do_read_fault mm/memory.c:5900 [inline]
 do_fault mm/memory.c:6043 [inline]
 do_pte_missing+0x1f38/0x33f0 mm/memory.c:4566
 handle_pte_fault mm/memory.c:6427 [inline]
 __handle_mm_fault mm/memory.c:6565 [inline]
 handle_mm_fault+0x1bf2/0x3170 mm/memory.c:6734
 do_user_addr_fault+0x75b/0x1340 arch/x86/mm/fault.c:1385
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0010:rep_movs_alternative+0x30/0x90 arch/x86/lib/copy_user_64.S:60
Code: 83 f9 08 73 25 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 <48> 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08
RSP: 0000:ffffc9000cb978b8 EFLAGS: 00050206
RAX: 00007ffffffff001 RBX: 000000000000001c RCX: 000000000000001c
RDX: 0000000000000001 RSI: 00000000800bcae0 RDI: ffffc9000cb97940
RBP: ffffc9000cb979d0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52001972f2b R12: dffffc0000000000
R13: ffffc9000cb97c80 R14: ffffc9000cb97940 R15: 00000000800bcae0
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:185 [inline]
 _copy_from_user+0x7a/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:223 [inline]
 get_compat_msghdr+0xb3/0x4c0 net/compat.c:91
 recvmsg_copy_msghdr net/socket.c:2882 [inline]
 ___sys_recvmsg+0x1dd/0x590 net/socket.c:2956
 do_recvmmsg+0x3a5/0x800 net/socket.c:3047
 __sys_recvmmsg+0x1a5/0x290 net/socket.c:3129
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xbf/0xe0 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x229/0x6e0 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fa501c
Code: 90 85 d2 74 0a 89 ce 81 e6 ff 0f 00 00 89 32 85 c0 74 05 c1 e9 0c 89 08 31 c0 5e 5d c3 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
RSP: 002b:00000000f544550c EFLAGS: 00000206 ORIG_RAX: 0000000000000151
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00000000800000c0
RDX: 0000000000010106 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x121f pfn:0x7bed6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f0(buddy)
raw: 00fff00000000000 ffffea0000fea188 ffffea0002346808 0000000000000000
raw: 000000000000121f 0000000000000000 00000000f0000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x140cc2(GFP_HIGHUSER|__GFP_COMP), pid 29415, tgid 29414 (syz.1.7355), ts 1634224509357, free_ts 1634614223058
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x2593/0x2610 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
 alloc_pages_mpol+0x235/0x490 mm/mempolicy.c:2490
 alloc_frozen_pages_noprof mm/mempolicy.c:2561 [inline]
 alloc_pages_noprof+0xac/0x2a0 mm/mempolicy.c:2581
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2591
 filemap_alloc_folio_noprof+0x111/0x470 mm/filemap.c:1014
 filemap_create_folio mm/filemap.c:2612 [inline]
 filemap_get_pages+0x819/0x1ef0 mm/filemap.c:2702
 filemap_read+0x447/0x1230 mm/filemap.c:2806
 __kernel_read+0x504/0x9b0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
 ima_calc_file_hash+0x446/0x860 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x51d/0x9c0 security/integrity/ima/ima_api.c:300
 process_measurement+0x12cd/0x1c80 security/integrity/ima/ima_main.c:425
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xb3/0x260 security/security.c:2755
page last free pid 29415 tgid 29414 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 free_unref_folios+0xd9f/0x14c0 mm/page_alloc.c:2999
 folios_put_refs+0x9ff/0xb40 mm/swap.c:1008
 folio_batch_release include/linux/folio_batch.h:101 [inline]
 truncate_inode_pages_range+0x3dd/0xe30 mm/truncate.c:408
 evict+0x631/0xb10 fs/inode.c:843
 __dentry_kill+0x1a2/0x690 fs/dcache.c:718
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1195
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1222
 shrink_dcache_tree+0xe9/0x5d0 fs/dcache.c:-1
 do_one_tree fs/dcache.c:1721 [inline]
 shrink_dcache_for_umount+0xa8/0x1f0 fs/dcache.c:1738
 generic_shutdown_super+0x6f/0x2d0 fs/super.c:624
 kill_anon_super+0x3b/0x70 fs/super.c:1292
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x70f/0x22c0 kernel/exit.c:976
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1119

Memory state around the buggy address:
 ffff88807bed6c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807bed6c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88807bed6d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff88807bed6d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807bed6e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
----------------
Code disassembly (best guess):
   0:	83 f9 08             	cmp    $0x8,%ecx
   3:	73 25                	jae    0x2a
   5:	85 c9                	test   %ecx,%ecx
   7:	74 0f                	je     0x18
   9:	8a 06                	mov    (%rsi),%al
   b:	88 07                	mov    %al,(%rdi)
   d:	48 ff c7             	inc    %rdi
  10:	48 ff c6             	inc    %rsi
  13:	48 ff c9             	dec    %rcx
  16:	75 f1                	jne    0x9
  18:	c3                   	ret
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  24:	00 00 00
  27:	0f 1f 00             	nopl   (%rax)
* 2a:	48 8b 06             	mov    (%rsi),%rax <-- trapping instruction
  2d:	48 89 07             	mov    %rax,(%rdi)
  30:	48 83 c6 08          	add    $0x8,%rsi
  34:	48 83 c7 08          	add    $0x8,%rdi
  38:	83 e9 08             	sub    $0x8,%ecx
  3b:	74 db                	je     0x18
  3d:	83 f9 08             	cmp    $0x8,%ecx


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

