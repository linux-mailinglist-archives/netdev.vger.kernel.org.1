Return-Path: <netdev+bounces-278429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFzPBmAs3mm1ogkAu9opvQ
	(envelope-from <netdev+bounces-278429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:00:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5B3F9BD1
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76D9130693DD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A13D75C8;
	Tue, 14 Apr 2026 11:58:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241983CF689
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167920; cv=none; b=dggr42wK+LGqI5q9EvZpmtFThI2Ecvwz4wmO4zaQ0JKtoC8qCnN9MQox/JIodw9/J6jZcyFWpFgD8FTQxQes+CNiVvQVcmEmIIJx4UNl9moSiX3nSjFW/j7gEiKcn7/svaHOoVq4uoZJOQcabvRY1Spzz9zI/OtNb8ps8Y0ETfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167920; c=relaxed/simple;
	bh=2HaJ7C6Eo6NfwcJIzimyysjHzA/pc/i0mLTwBqWk98U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VdwyKHOAbgq6dZ7+WBELdyf1u8ncoiRrO39CDAiiTEbV6C0jppqY4ZVwYowg6xSo26w4dPG0BF0JV35D2V7jRcBaUl0fR8lasrvj7yxMIVOIcw0qH/PY6acjdNG4hVcLA0Git5gqbi5WH1Z54/R/YI6ZM9O2qPgiAsHHm+EC3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6861462170aso10699031eaf.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 04:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776167918; x=1776772718;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCbszGg/pu29m3RS9h0lC44Y5Fgpvv9Jr9lX3YF0Ay4=;
        b=EQC/3YhX/D8gD8Dx2KZdR0AJZu9LmdfPv4dsfk32mt7W3aTG8Ky9qycFaTuW9YPNwh
         7xwVawW9bcyNE/YM2LGaSGYbqeMMbzDTzWJPgvqz8S+WFmZZY8LKazrPLt3vXuGB6Pej
         zclXITFHgV1cfQalLDz+S1O4kqq1CuSC0NkJT4X2Gv39Oz2zcIfcLlAJqKgtko7uwZe0
         MD2zts5R6f8re6S4Ibs7aeLB2RzlHlibI4cBNKoj8EMZJ2X11Zr1R4k5pIJTEuKCLaJ+
         VVMYpaAFQjP1hFcmu60VTIpMgPbFC9+Of//+dm0PAvDtec7mtMiLk58yqF4jM26TgZBV
         X7aQ==
X-Forwarded-Encrypted: i=1; AFNElJ98re07sy+U75YmaHme+gdmeJMTiOboZOLQW/LFgCTnbve+/13oBl51Bpm/hH7KC7/A6BJpkfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgUgk8d+nJg8tNXkbwu8Mm+Ji4bSMB3/kE0IDqHry3l3Zw3uq
	FIXbcJ0G68IzUJoiPc1FMbcBf2TiLKhbY6d53EAxyvKbxaz0rh4uq15xhUtDxq8CXhIimog0odN
	KVTx9K7Q0Z6MTI7nrkP1NxHDzuxEr/DH5RJkmRscX8pPHsmJBBhaFFJRn+s4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2907:b0:682:3fc6:5581 with SMTP id
 006d021491bc7-68be5778213mr8828186eaf.7.1776167918128; Tue, 14 Apr 2026
 04:58:38 -0700 (PDT)
Date: Tue, 14 Apr 2026 04:58:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69de2bee.a00a0220.475f0.0041.GAE@google.com>
Subject: [syzbot] [bridge?] KASAN: use-after-free Read in qdisc_pkt_len_segs_init
From: syzbot <syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=229411a0a13ccb7d];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-278429-lists,netdev=lfdr.de,83181a31faf9455499c5];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: B1F5B3F9BD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    17ad4759a082 Merge branch 'wangxun-improvement'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1505dcd2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=229411a0a13ccb7d
dashboard link: https://syzkaller.appspot.com/bug?extid=83181a31faf9455499c5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b67be09d914c/disk-17ad4759.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20a2548795c3/vmlinux-17ad4759.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29e723395cef/bzImage-17ad4759.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __tcp_hdrlen include/linux/tcp.h:31 [inline]
BUG: KASAN: use-after-free in qdisc_pkt_len_segs_init+0x7f8/0xa30 net/core/dev.c:4146
Read of size 2 at addr ffff88815ace2434 by task syz.2.24/6033

CPU: 0 UID: 0 PID: 6033 Comm: syz.2.24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __tcp_hdrlen include/linux/tcp.h:31 [inline]
 qdisc_pkt_len_segs_init+0x7f8/0xa30 net/core/dev.c:4146
 sch_handle_ingress net/core/dev.c:4483 [inline]
 __netif_receive_skb_core+0x13bd/0x31a0 net/core/dev.c:6065
 __netif_receive_skb_list_core+0x24d/0x810 net/core/dev.c:6289
 __netif_receive_skb_list net/core/dev.c:6356 [inline]
 netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6447
 gro_normal_list include/net/gro.h:523 [inline]
 gro_flush_normal include/net/gro.h:531 [inline]
 napi_complete_done+0x299/0x730 net/core/dev.c:6815
 gro_cell_poll+0x5a9/0x5d0 net/core/gro_cells.c:74
 __napi_poll+0xae/0x340 net/core/dev.c:7742
 napi_poll net/core/dev.c:7805 [inline]
 net_rx_action+0x627/0xf70 net/core/dev.c:7962
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 tun_rx_batched+0x617/0x790 drivers/net/tun.c:-1
 tun_get_user+0x2aeb/0x3ed0 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f177e39c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f177f1e3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f177e616180 RCX: 00007f177e39c819
RDX: 000000000000fdef RSI: 00002000000002c0 RDI: 0000000000000003
RBP: 00007f177e432c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f177e616218 R14: 00007f177e616180 R15: 00007ffee7d40588
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15ace2
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000000 ffffea00056b3888 ffffea00056b3888 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88815ace2300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88815ace2380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88815ace2400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff88815ace2480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88815ace2500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

