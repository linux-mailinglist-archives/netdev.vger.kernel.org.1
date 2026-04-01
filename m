Return-Path: <netdev+bounces-274123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOzPOpIlzWlkaQYAu9opvQ
	(envelope-from <netdev+bounces-274123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:02:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6637BC53
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7233010D9D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32843D4E1;
	Wed,  1 Apr 2026 13:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFE43CEE4
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051428; cv=none; b=CuG7lxJhPOOveK81nDDs/B82JbyNXKcV2VaOL8lvTGdBtaPdjulrU+6b41q8PxYutyJgkcrqgY58Vafa26559lJSSW2CLTWKbflJo55ZPjjNDWFRrQNJ0jWTfPuW1LfEFKrWIjREpzKyFVqbrRzX+yTvB41vFynG0XLdbBBIQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051428; c=relaxed/simple;
	bh=xd6U/I/Yed2sSzsVfusznvBRiNJS07JJARkeXc8xb3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hBRZ2h2hF0hID9mMtwHffIXob/+mNzQsPpzBJkBEKDNg91Lbs3z1t3Uj/kHPtqp0rkwbgPhxmAum1wqV0HCKuvZytolulN7mvyoCEjVbss6affiJ9zuO94VDLdb7m+vSYF0LpFN5kLme/K5wGQMYSSMVJCZYNDShMEnl7P/TNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-67c2f9da04eso20570982eaf.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051426; x=1775656226;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGkbonhZvJQJC8go0Pn1ZnXhQLkMT9VufR7fyz4cgEE=;
        b=lALLg664mfciL+8ics9HkHV8IlMOPTFHND/2kuZ2YNwFG4eJCOcfBWFpt3acQJQu/h
         S3JiV8RnWTtZ+HeSelMWM9jUnHDfxUNBdsgOA4Y7LibqaD3jLOIRvu3Tnwwj7/6Ltu/e
         AGWtC0jwDy+j2PZscGbJhgHfXTFGZe0SId7/8QIB0da39uh1b9YKlGTsdsrMxF0oPFXs
         YqkNyccGTEB2+OFMGRtTCsqfyTy6TWZs1HE3KPBXTjecTusAD6zbB4WqANsH09cvCEED
         1Ukrl0bi46wtleJBA3UyVe/PRWsKA9Un7SS6BoLuBx5BPxQIDmQAofDT+lfcRsYgeiCS
         PPsg==
X-Forwarded-Encrypted: i=1; AJvYcCVdcQLFP5PPUGiqy0OVWVsouKOesnJf9EnHfCLppJ/U8k5L1+mgglrQwXCbAyUkSkykUxRTSIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabOZgEOKiEC7Ja0BU4HAqTAjUEwHbA6W9Ylc/ChT8ze8rZEpz
	mRGK9FD/hSTV7sEkh2tusSeqggZXQ5NU27O24OG4MkIJWeOetsaJz9z8NA/CBkzIQqGVWMa67jh
	o3F+wFuV9okH+/eRggHC/07VqhpW5vDpzPQ9q/L7tNH4EDkZkuL4nLD1q7ik=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c95:b0:67d:ee07:32dc with SMTP id
 006d021491bc7-67fabbd3b7dmr1815614eaf.6.1775051425977; Wed, 01 Apr 2026
 06:50:25 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:50:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cd22a1.050a0220.70c3a.0002.GAE@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in ip6gre_header
From: syzbot <syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274123-lists,netdev=lfdr.de,d8c285748fa7292580a9];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 9BE6637BC53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    cf0d9080c6f7 Merge branch 'net-hsr-subsystem-cleanups-and-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1760a360580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9
dashboard link: https://syzkaller.appspot.com/bug?extid=d8c285748fa7292580a9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e438d2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117f19ca580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4271eafdaa2c/disk-cf0d9080.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/984de2c215cb/vmlinux-cf0d9080.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e03ead684811/bzImage-cf0d9080.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in ip6gre_header+0x5bf/0x860 net/ipv6/ip6_gre.c:1400
Read of size 16 at addr ffffffff8c6c4380 by task dhcpcd/5489

CPU: 0 UID: 0 PID: 5489 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 ip6gre_header+0x5bf/0x860 net/ipv6/ip6_gre.c:1400
 bond_header_create+0x1ce/0x300 drivers/net/bonding/bond_main.c:1524
 dev_hard_header include/linux/netdevice.h:3449 [inline]
 lapbeth_data_transmit+0x218/0x2e0 drivers/net/wan/lapbether.c:258
 lapb_data_transmit+0x90/0xb0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0x163/0x200 net/lapb/lapb_out.c:149
 lapb_establish_data_link+0x89/0xe0 net/lapb/lapb_out.c:-1
 lapb_device_event+0x4e1/0x670 net/lapb/lapb_iface.c:-1
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2285 [inline]
 call_netdevice_notifiers net/core/dev.c:2299 [inline]
 __dev_notify_flags+0x1a9/0x310 net/core/dev.c:9830
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9859
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 devinet_ioctl+0x9f2/0x1b30 net/ipv4/devinet.c:1199
 inet_ioctl+0x42a/0x560 net/ipv4/af_inet.c:1011
 sock_do_ioctl+0x101/0x320 net/socket.c:1247
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1368
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb458496378
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 49 3a 0d
RSP: 002b:00007ffdede01158 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007fb458496378
RDX: 00007ffdede11350 RSI: 0000000000008914 RDI: 0000000000000012
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdede214f0
R13: 00007fb458396708 R14: 0000000000000028 R15: 0000000000008914
 </TASK>

The buggy address belongs to the variable:
 bcast_addr+0x0/0x20

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xc6c4
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea000031b108 ffffea000031b108 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8c6c4280: 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00 06 f9 f9 f9
 ffffffff8c6c4300: f9 f9 f9 f9 00 00 00 00 00 02 f9 f9 f9 f9 f9 f9
>ffffffff8c6c4380: 06 f9 f9 f9 00 00 00 00 00 06 f9 f9 f9 f9 f9 f9
                   ^
 ffffffff8c6c4400: 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
 ffffffff8c6c4480: 00 05 f9 f9 f9 f9 f9 f9 00 00 00 00 00 06 f9 f9
==================================================================


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

