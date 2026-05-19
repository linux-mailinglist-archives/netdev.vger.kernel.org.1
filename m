Return-Path: <netdev+bounces-289558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAFUOnqiDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4655834AB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD796300EF4B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E43C48AE0B;
	Tue, 19 May 2026 17:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8B369D60
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212911; cv=none; b=jOg/5JyWy0EbEw77NvHdmTAIVreZe5FJbRFtvHGDo38zVNjc5f0ZEEPA4ilFExxkPEELc8iKL+C+jxDicyJpXwTQMEcN/NlVwkWxuFDcUUpgVC8nRhXzEtO7sGrHfb3Ubcu4ZKLeL/jjLQlAZ9RZkmhXEHdmfwkq7g9Jbp08M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212911; c=relaxed/simple;
	bh=A9rsfwSVuTK4gzeo6TjY/7NMRBQ5pj3eDQozOfXaeVM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CJfPxZqlVCaZUt+KMxWst5G8cAHuPrHB5psQI5gI7vDasHtIiEQ2Hm7n488TSxA6HSldiEhkjXqozai5D626AtWuiMnsLqRCiz7WDcwE5RqYtXkH6VjrqPtsUd4nXQ5/qXEBWroJIZzAeJHHi/f6bBoZx2nZSAnfWwNvdl4PxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6961bda4505so5231898eaf.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779212906; x=1779817706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyzXa+K2vsir/tubM2vb6rWH3jVVR92MHKmuZBwzfjc=;
        b=IQDhA1v72hGhq2XoNFtIcNR+UVp7LeoZ2K7LRanm5z4MDAIpHSqiU7dqcD4NXhOcna
         RerxFQwG/YVB2K0FS0x0RQtEWyszZAD5aHlJSP69UcpZCIacJMGawmtNK4P1RO8aePEZ
         NFs+uE8DSfFM9DJtRUxzO75Pn70pvmuRGaVqhy5rMmdy6rB/aVx3sXpy9htHsTmX/R/J
         2fbm08nsphweTxXGQH6TiUwL6jDrpmqSHHkfmdCY5WCf/rBmokXLyxwn5AlHEqqX7gH8
         +ywoHLjUT3IjpDCUFODKzPXBVwdmKZWd+8w0Z/86yVbxPv1P4XQnBRKMvhlhmC8GH32u
         pdtA==
X-Forwarded-Encrypted: i=1; AFNElJ9XGN5oXr7HlUOvYu2TELBrmgMhvnZHmd5B8a1Ur3GdRMlaA5Fulei9qLdKhLNKk1o2tzdAlIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbH38GSrYO7V7fpMQvVySoBZEa2bIghy/3jqcwPNz8bgdoU5z
	UbwQQLYUYYyL5v8dl0WZDTd56ADUg9P8o+c7P0E5/MmHJiOVuLvMcx4Y/Z62LRq9GiMRJ8JhF5M
	gXvfFIlFz4t/zSkqfTabW9MWnjLIWkAs+NyPy8iZTSj/NAGEbKEGcHdsXL1c=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e909:0:b0:696:77e2:a83 with SMTP id
 006d021491bc7-69c9bfd297cmr13035882eaf.53.1779212905858; Tue, 19 May 2026
 10:48:25 -0700 (PDT)
Date: Tue, 19 May 2026 10:48:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0ca269.a70a0220.1a69d3.0014.GAE@google.com>
Subject: [syzbot] [net?] WARNING in stack_depot_save_flags (2)
From: syzbot <syzbot+1827030ed7bc886dd0a5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,googlegroups.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-289558-lists,netdev=lfdr.de,1827030ed7bc886dd0a5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 4B4655834AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    70eda68668d1 Merge tag 'hid-for-linus-2026051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13291bce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
dashboard link: https://syzkaller.appspot.com/bug?extid=1827030ed7bc886dd0a5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-70eda686.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c7af75df257/vmlinux-70eda686.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8cc495201bd/bzImage-70eda686.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1827030ed7bc886dd0a5@syzkaller.appspotmail.com

------------[ cut here ]------------
Stack depot reached limit capacity
WARNING: lib/stackdepot.c:302 at depot_init_pool lib/stackdepot.c:302 [inline], CPU#0: kworker/u32:17/13749
WARNING: lib/stackdepot.c:302 at depot_pop_free_pool lib/stackdepot.c:371 [inline], CPU#0: kworker/u32:17/13749
WARNING: lib/stackdepot.c:302 at depot_alloc_stack lib/stackdepot.c:462 [inline], CPU#0: kworker/u32:17/13749
WARNING: lib/stackdepot.c:302 at stack_depot_save_flags+0x9a2/0x9d0 lib/stackdepot.c:706, CPU#0: kworker/u32:17/13749
Modules linked in:
CPU: 0 UID: 0 PID: 13749 Comm: kworker/u32:17 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:depot_init_pool lib/stackdepot.c:302 [inline]
RIP: 0010:depot_pop_free_pool lib/stackdepot.c:371 [inline]
RIP: 0010:depot_alloc_stack lib/stackdepot.c:462 [inline]
RIP: 0010:stack_depot_save_flags+0x9a2/0x9d0 lib/stackdepot.c:706
Code: 0b 90 eb bf 48 85 ed 74 c6 48 89 2d a0 de 17 16 48 89 ea 31 ed e9 0b ff ff ff 39 c1 72 1f 48 85 d2 74 20 48 8d 3d ae e6 b3 0b <67> 48 0f b9 3a 45 31 f6 48 85 ed 0f 85 37 fa ff ff eb 92 90 0f 0b
RSP: 0018:ffffc900000072e0 EFLAGS: 00010086
RAX: 0000000000002000 RBX: 0000000000000000 RCX: 0000000000002000
RDX: ffff8880460f8000 RSI: ffffffff8defc944 RDI: ffffffff90e25c00
RBP: 0000000000000000 R08: 000000001c62ad74 R09: 000000002f4d0daf
R10: 0000000000000150 R11: 0000000000000000 R12: ffffc90000007338
R13: 0000000000000025 R14: ffff88816d70daf0 R15: ffff88816d70daf0
FS:  0000000000000000(0000) GS:ffff8880d6370000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555c1b6ff300 CR3: 000000000e596000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 kasan_save_stack+0x3f/0x50 mm/kasan/common.c:58
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6250 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6377
 kfree_skbmem+0x19a/0x210 net/core/skbuff.c:1137
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x10f/0x1b0 net/core/skbuff.c:1241
 packet_rcv+0x16c/0x17b0 net/packet/af_packet.c:2224
 dev_queue_xmit_nit+0x6fc/0xa60 net/core/dev.c:2606
 xmit_one net/core/dev.c:3884 [inline]
 dev_hard_start_xmit+0x2fc/0x7a0 net/core/dev.c:3904
 __dev_queue_xmit+0x1baa/0x4950 net/core/dev.c:4870
 lapb_data_transmit+0x96/0xc0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0xce/0x3a0 net/lapb/lapb_out.c:149
 lapb_send_control+0x1ce/0x330 net/lapb/lapb_subr.c:251
 lapb_establish_data_link+0xeb/0x110 net/lapb/lapb_out.c:163
 lapb_state3_machine net/lapb/lapb_in.c:445 [inline]
 lapb_data_input+0xc45/0x19d0 net/lapb/lapb_in.c:550
 lapb_data_received+0x65/0xf0 net/lapb/lapb_iface.c:399
 lapbeth_rcv+0x3a6/0x6e0 drivers/net/wan/lapbether.c:142
 __netif_receive_skb_one_core+0x1b2/0x1e0 net/core/dev.c:6202
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6315
 process_backlog+0x37a/0x1580 net/core/dev.c:6666
 __napi_poll.constprop.0+0xaf/0x450 net/core/dev.c:7733
 napi_poll net/core/dev.c:7796 [inline]
 net_rx_action+0xa40/0xf20 net/core/dev.c:7953
 handle_softirqs+0x1ea/0xa00 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xac/0xe0 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_purge_outstanding_packets+0xc0/0x290 net/batman-adv/send.c:1110
 batadv_hardif_disable_interface.cold+0x316/0x80b net/batman-adv/hard-interface.c:847
 batadv_meshif_destroy_netlink+0x79/0x150 net/batman-adv/mesh-interface.c:1093
 default_device_exit_batch+0x70c/0xc10 net/core/dev.c:13071
 ops_exit_list net/core/net_namespace.c:205 [inline]
 ops_undo_list+0x363/0xab0 net/core/net_namespace.c:252
 cleanup_net+0x499/0x920 net/core/net_namespace.c:702
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	0b 90 eb bf 48 85    	or     -0x7ab74015(%rax),%edx
   6:	ed                   	in     (%dx),%eax
   7:	74 c6                	je     0xffffffcf
   9:	48 89 2d a0 de 17 16 	mov    %rbp,0x1617dea0(%rip)        # 0x1617deb0
  10:	48 89 ea             	mov    %rbp,%rdx
  13:	31 ed                	xor    %ebp,%ebp
  15:	e9 0b ff ff ff       	jmp    0xffffff25
  1a:	39 c1                	cmp    %eax,%ecx
  1c:	72 1f                	jb     0x3d
  1e:	48 85 d2             	test   %rdx,%rdx
  21:	74 20                	je     0x43
  23:	48 8d 3d ae e6 b3 0b 	lea    0xbb3e6ae(%rip),%rdi        # 0xbb3e6d8
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	45 31 f6             	xor    %r14d,%r14d
  32:	48 85 ed             	test   %rbp,%rbp
  35:	0f 85 37 fa ff ff    	jne    0xfffffa72
  3b:	eb 92                	jmp    0xffffffcf
  3d:	90                   	nop
  3e:	0f 0b                	ud2


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

