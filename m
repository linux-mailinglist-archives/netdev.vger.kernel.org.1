Return-Path: <netdev+bounces-275215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE5pGiYn0Gko4AYAu9opvQ
	(envelope-from <netdev+bounces-275215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 056413983F4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BC1D30066A9
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23D3B3885;
	Fri,  3 Apr 2026 20:46:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41023D7FB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249186; cv=none; b=GoXATxJvbvoSCTU1Vpc4M+9KC78XCcr5lUk6o8Pfn4lBu8eLjJb6/Sjx7d5IFZWhODI/TmHDa2vJQttIRSSvIlcsK6Y301ouJMqRMv0y6DC0ySs7USCP8l5oJjRlikAzHgb4/gvIAtXrAZYgBYlA2qIPJbZjg5SBvOT9sMHYB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249186; c=relaxed/simple;
	bh=ya8mIEi/lOzbAAv9vNueo7lkjuUjA9tBA2hrrpB0r9c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nn1bxmPprF9ZQaiGQKlsRwEruVTMmt3vXP1sbzLci8dCBcsVFuW+n2F3KgparZdGI/9nXGIXKANDwGEMQSiQKbu/M17q2Jrt2XqQIkdaSvDYGBcbMe714WQAWyrnU1l/sZY4u8gqIPHZmzGBgWjI43HK9hHXTaNoa1LIJoe6Y/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-41c471678c4so3186973fac.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775249184; x=1775853984;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwihP8VSD5VEOSh/pvXoSKE8nmgjfZs35QdENxNc5QI=;
        b=HaRb1jK7e0rDcth9fPMpYou7bL3IQgOMoFDYcoylkixjj/7zCH+fGI9QTXNaFttmIR
         An15gJkU7iNp3BwN3gyhovoz2LpBgTQfDFyOPg20GxgqL3OCllhyFlr0s3QsRlbaIgAi
         NlmcfgypGWJpj6SMBe3prWGaKSXQGdoVb/Mj3TifVzJqL5JjyUsmjEcDPOrUOcTML6On
         Z5QYo8ZoB1HXOmxeyXdHFeWngD3DXWxxfLCzWBUQJ72tlrZE4jl213l6VlxKuEVPEzkK
         aHkSukOycKvp5ANhItroeFFxmAJwqpkyM9iCPQD6EQO7jH/wQvlUl1CBEvtxkTlHknQv
         ueKA==
X-Forwarded-Encrypted: i=1; AJvYcCV1CHskLF6e40hYugN/r0MtPEQVPSZ49H9GPrEhQXY1CX4UH4uU6DRTuR1WcWR43QOrJcGKtxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG25Jb+BlU4MVXT62sGdd9+HM6YrulijdRaJkg5AxsekM4Wk9i
	+UNRl7SKfbBJEc+eVtTFhInH8TD9Q3TvfbzDvMjJkQcySMMM00lLRPjWswhXxjf/ce5hs3agp8t
	j7XQQrv0+2HVRO5XdVw5n0CouuS3+4v0L7V/JnliVKyXbkATGrienw/8uS6c=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:818a:b0:67d:e140:344a with SMTP id
 006d021491bc7-68220c3f586mr2682669eaf.40.1775249183975; Fri, 03 Apr 2026
 13:46:23 -0700 (PDT)
Date: Fri, 03 Apr 2026 13:46:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d0271f.050a0220.182279.0019.GAE@google.com>
Subject: [syzbot] [netfilter?] KCSAN: data-race in hash_ipportnet6_add / hash_ipportnet6_head
From: syzbot <syzbot+421c5f3ff8e9493084d9@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275215-lists,netdev=lfdr.de,421c5f3ff8e9493084d9];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 056413983F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    2d1373e4246d Merge tag 'for-7.0-rc4-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12df3d52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=421c5f3ff8e9493084d9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2aee7aa6da1/disk-2d1373e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6cbfa1602880/vmlinux-2d1373e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52fe8db03e03/bzImage-2d1373e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+421c5f3ff8e9493084d9@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in hash_ipportnet6_add / hash_ipportnet6_head

read-write to 0xffff888181583b19 of 1 bytes by task 29523 on cpu 1:
 hash_ipportnet6_add+0xa12/0x1900 net/netfilter/ipset/ip_set_hash_gen.h:965
 hash_ipportnet6_uadt+0x7c1/0x900 net/netfilter/ipset/ip_set_hash_ipportnet.c:504
 call_ad+0x231/0x640 net/netfilter/ipset/ip_set_core.c:1751
 ip_set_ad+0x5c0/0x690 net/netfilter/ipset/ip_set_core.c:1841
 ip_set_uadd+0x41/0x50 net/netfilter/ipset/ip_set_core.c:1864
 nfnetlink_rcv_msg+0x509/0x5d0 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x123/0x220 net/netlink/af_netlink.c:2550
 nfnetlink_rcv+0x167/0x1720 net/netfilter/nfnetlink.c:669
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5c0/0x690 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x5c8/0x6f0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x563/0x5b0 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888181583b19 of 1 bytes by task 29539 on cpu 0:
 hash_ipportnet6_ext_size net/netfilter/ipset/ip_set_hash_gen.h:823 [inline]
 hash_ipportnet6_head+0x28f/0x790 net/netfilter/ipset/ip_set_hash_gen.h:1275
 ip_set_dump_do+0xa34/0xb00 net/netfilter/ipset/ip_set_core.c:1651
 netlink_dump+0x455/0x8a0 net/netlink/af_netlink.c:2325
 netlink_recvmsg+0x420/0x550 net/netlink/af_netlink.c:1976
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0xf5/0x120 net/socket.c:1100
 ____sys_recvmsg+0xf5/0x280 net/socket.c:2812
 ___sys_recvmsg+0x11f/0x3b0 net/socket.c:2854
 do_recvmmsg+0x1ef/0x560 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0xe5/0x170 net/socket.c:3039
 x64_sys_call+0x80f/0x3020 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x05 -> 0x06

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 29539 Comm: syz.4.6655 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
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

