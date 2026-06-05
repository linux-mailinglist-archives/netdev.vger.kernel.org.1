Return-Path: <netdev+bounces-295908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6CKdCXgBI2pjgQEAu9opvQ
	(envelope-from <netdev+bounces-295908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:03:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8741A649FF4
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:03:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295908-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295908-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15E25308A4D4
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000336A36E;
	Fri,  5 Jun 2026 16:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98732F39AB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:58:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678708; cv=none; b=G+QyWowTD+HXTu5gzy75BEiduH/NJnuPmXL3jRhWGeoDuhbuTr9hbZZCrywdHi8iIINPud5UnBjPN016TgBypF0+DGlmKzViEmtsNsMYIpRrM2gCiJwFf4EKNxgEzsYLyGUTLFK8AhOx/tbpYLAfb+2O1UNpcTlYNgI0ZfPmABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678708; c=relaxed/simple;
	bh=GIUaScalfrmR0APxMsbvRbijzzxjbRe3Dv6Z84yaP1E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jSdXlsc2gh6eXrZqGIQKROMqXOQXvs2M3UWa9G7J3aNVMDxRoqtP29XUFbF90lNI7dz7+5Zyy/RjdSpqB5O9FMQg9rn0vLGWeJXmKAq+pgdolnf0fWDP1kIfawQKJEX7a6+lB9efVex1yiFZg4uTRGjYp5JHusBUzaFSnVyAHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-43d33c10c62so2357603fac.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 09:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780678705; x=1781283505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmst1QGiEErj6eYelafDa0+cdHvsg0Afv0a+dUCPKK0=;
        b=q6cszOPGLFZclqc7gF+OBoZPDrJ9WO6UZyhlEi7bAUwXQ5FnxKhPd/O07flrLO/s8C
         iUZjigPJxNBvX2NwTK6P0xbUGPU1UasTjX4IddhLpalNDEJ0zfLua/43OxplwPdKR7Fw
         I+VrDWJixPL6lSzLGG9uR98GMKlm29agraZiOfy45TEVOkReQgzz7CKvVNxhAavxyQ+I
         6KCbB3qwqL8BhHOHAiyS0dEq/cUHkS1HqM5dKLXm7cus4eKqVuufuLdsb4usv9fi0rmx
         +e5LAenNZ1mLeHh1lno65LNnjRN6tvol6QjpptBebsDfk9m7idXX9QNsg+r86+uuYdtM
         xsiA==
X-Forwarded-Encrypted: i=1; AFNElJ+QTt6d/x3fiLAI7H+wkbcOgYw/SUObkpvrcjUPZi+piyjHSpC7F87ccyvGbvCr/wOT/jvakQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye070mA/0lpWURywhezKFBYaizRbTUCPUJoZm5HXsVfmKxFwyE
	Wc1lqg95T2X4IBn31QVj04JEHsuk97kcLfZ9rcMeCVjz/t7yZ9AfpEdszSp4EFbro0liZSrpU05
	0//XAnQiSnOdFy6x0U2/ufc9cqdfY591f4yCBhJxPPEjDD+H7HP9G/cOs2Bk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f027:b0:69e:3563:4424 with SMTP id
 006d021491bc7-69e68b72196mr2438741eaf.24.1780678705635; Fri, 05 Jun 2026
 09:58:25 -0700 (PDT)
Date: Fri, 05 Jun 2026 09:58:25 -0700
In-Reply-To: <69de2bee.a00a0220.475f0.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a230031.39669fcc.2372e3.0003.GAE@google.com>
Subject: Re: [syzbot] [bridge?] KASAN: use-after-free Read in qdisc_pkt_len_segs_init
From: syzbot <syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com, 
	jiayuan.chen@linux.dev, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pshelar@nicira.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com, tom@herbertland.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295908-lists,netdev=lfdr.de,83181a31faf9455499c5];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bridge@lists.linux.dev,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:idosch@nvidia.com,m:jiayuan.chen@linux.dev,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:pshelar@nicira.com,m:razor@blackwall.org,m:syzkaller-bugs@googlegroups.com,m:tom@herbertland.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,vger.kernel.org:from_smtp,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8741A649FF4

syzbot has found a reproducer for the following issue on:

HEAD commit:    4aacf509e537 net: mv643xx: fix OF node refcount
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15b8fdd2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04
dashboard link: https://syzkaller.appspot.com/bug?extid=83181a31faf9455499c5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a6da86580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a3c0ae580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7559c887601e/disk-4aacf509.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/185ea069b480/vmlinux-4aacf509.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4285524349b9/bzImage-4aacf509.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __tcp_hdrlen include/linux/tcp.h:31 [inline]
BUG: KASAN: use-after-free in qdisc_pkt_len_segs_init+0x7f8/0xa30 net/core/dev.c:4140
Read of size 2 at addr ffff88817cd41734 by task syz.0.17/5856

CPU: 0 UID: 0 PID: 5856 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __tcp_hdrlen include/linux/tcp.h:31 [inline]
 qdisc_pkt_len_segs_init+0x7f8/0xa30 net/core/dev.c:4140
 __dev_queue_xmit+0x29a/0x3950 net/core/dev.c:4782
 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 hsr_xmit net/hsr/hsr_forward.c:440 [inline]
 hsr_forward_do net/hsr/hsr_forward.c:581 [inline]
 hsr_forward_skb+0x167e/0x2ab0 net/hsr/hsr_forward.c:743
 hsr_handle_frame+0x6b8/0xa50 net/hsr/hsr_slave.c:81
 __netif_receive_skb_core+0x98f/0x3170 net/core/dev.c:6089
 __netif_receive_skb_list_core+0x24d/0x810 net/core/dev.c:6277
 __netif_receive_skb_list net/core/dev.c:6344 [inline]
 netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6435
 gro_normal_list include/net/gro.h:523 [inline]
 gro_flush_normal include/net/gro.h:531 [inline]
 napi_complete_done+0x299/0x730 net/core/dev.c:6803
 gro_cell_poll+0x5a9/0x5d0 net/core/gro_cells.c:74
 __napi_poll+0xae/0x340 net/core/dev.c:7733
 napi_poll net/core/dev.c:7796 [inline]
 net_rx_action+0x627/0xf70 net/core/dev.c:7953
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 tun_rx_batched+0x617/0x790 drivers/net/tun.c:-1
 tun_get_user+0x2bbc/0x43e0 drivers/net/tun.c:1955
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2001
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe91fb9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda826a2e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe91fe15fa0 RCX: 00007fe91fb9ce59
RDX: 000000000000007a RSI: 00002000000002c0 RDI: 0000000000000005
RBP: 00007fe91fc32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe91fe15fac R14: 00007fe91fe15fa0 R15: 00007fe91fe15fa0
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17cd41
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000000 ffffea0005f35048 ffffea0005f35048 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88817cd41600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88817cd41680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88817cd41700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff88817cd41780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88817cd41800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

