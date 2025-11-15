Return-Path: <netdev+bounces-238871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBFCC60A42
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 337544E1103
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE83090CC;
	Sat, 15 Nov 2025 18:59:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFD302149
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763233162; cv=none; b=cvk4O4iq1DMKRcSJxNhY1aUZNtrqYTMFzQljcblCY4CUZP3Pw6XrBBsbJl2oir0YusREHJr0MqtnlurqCvUTY9kpEx0+1K3xjpce8jg5qYHV7PBENASomJSPOWXAJpVxY+OdkPZ9tSr35yQTimW+oyWDVAsmoVB8J7QrMIBGnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763233162; c=relaxed/simple;
	bh=e/LG2V68qjr6KYs1x+hk24Fd2s7sou2OoKXylbs/Xqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LyDYSiljywPEcQNDgLyIpT7ok9195x/MJbmiVUbgLLJgpcudDOo76mKzLO/KHom0NXXhHweUrHNXVnJjzVaRYZQR6aWCTvcekuE/6NC4DXgsnujaMiOnNMig+5snZwfGhhQS7ukzWplJ+qD5fE3XYzobztxKqYL453qgnkqYoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-948c64d216cso299604839f.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 10:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763233160; x=1763837960;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrPZGbyCBd7pxlNyCqNfhdlpQ1jsL6PNLDxiOB2ByCU=;
        b=Kru6HXcpLtB2cHVkiqexoaBT2xSf/IdFMJju4kmoQGSB6ytr6g5W+mI6kwMIPFAHwf
         Fl/tFFHi6gsWOyaYm10PUCpqusG2G0AP7D5lWK9ndTEIV5/bLtnhUpAC1p+zbq8ic58u
         nE/ZSekgt8I6txY00LCreQ3foha7kFqLIWapcOsPoXQP7T10xolXwtbk7ygt2/ZMFYEC
         slLzex+d1HuELG9fQxsUK5L0O+aPryrron39Ej8JKjSEk/Y4lKw6dOiBweFbqHuZDH1Z
         mzT0ACEbmUceSUr99MNuBEUM1akPi4uvLcSdbFP5DfJCw5CaJxLGNHkDuPoFvyoozxJx
         6o0A==
X-Forwarded-Encrypted: i=1; AJvYcCWAnKIcMN3u1JAFkZICyCr1owlsmopUYAvOrtmQfqCXwT5LhW9uHjS5O0TqatxMVWbrIC8GDAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwEZBrcgfhEb+mowbTkrY4fSbPr2C18WiQd3XJ8GdCn5Z7Ic4
	AC960FQ3T+Rasp1aKV9q08WuFSatOOtdVW1A+gBCcRBiY+BfLbRbfXwKl4y0PHKFncb6l0QGIib
	PBAqnva8xgo6MjnDRgiFanO0Rva9FgM5H9vr1laIGAxRzq/oKRs3J1pU/w0A=
X-Google-Smtp-Source: AGHT+IGIvtH7/W2TzbqSnewRt4yal/nomyGfj2RzYewF4jvQdhiNwfk/CchVrF7sKV3yjwCUgoVZbp0XeVLoZaJzFRI0IV2rDvCY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1947:b0:434:78d0:86a6 with SMTP id
 e9e14a558f8ab-4348c954efbmr107252825ab.30.1763233160379; Sat, 15 Nov 2025
 10:59:20 -0800 (PST)
Date: Sat, 15 Nov 2025 10:59:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6918cd88.050a0220.1c914e.0045.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in ip6_pol_route (2)
From: syzbot <syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a0892d2836e Merge tag 'pci-v6.18-fixes-5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b9a658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/168b5b7f897a/disk-7a0892d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d6e756ca306/vmlinux-7a0892d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d497b0a7a1f5/bzImage-7a0892d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/ipv6/route.c:1473!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 9293 Comm: kworker/0:9 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
RIP: 0010:rt6_make_pcpu_route net/ipv6/route.c:1473 [inline]
RIP: 0010:ip6_pol_route+0x117d/0x1180 net/ipv6/route.c:2305
Code: ab f8 e9 f4 fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 03 fb ff ff 48 89 df e8 ae 04 ab f8 e9 f6 fa ff ff e8 b4 44 49 f8 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
RSP: 0018:ffffc90004a073c0 EFLAGS: 00010293
RAX: ffffffff8975687c RBX: ffff888126df7000 RCX: ffff888024dd1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004a074d0 R08: ffffe8ffffc4cdd7 R09: 1ffffd1ffff899ba
R10: dffffc0000000000 R11: fffff91ffff899bb R12: ffff88823bf78f00
R13: ffffffff89755862 R14: dffffc0000000000 R15: 0000607ed8e55dd0
FS:  0000000000000000(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdadd5ac18 CR3: 00000000370c4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 pol_lookup_func include/net/ip6_fib.h:617 [inline]
 fib6_rule_lookup+0x1fc/0x6f0 net/ipv6/fib6_rules.c:120
 ip6_route_output_flags_noref net/ipv6/route.c:2684 [inline]
 ip6_route_output_flags+0x364/0x5d0 net/ipv6/route.c:2696
 ip6_dst_lookup_tail+0x299/0x1510 net/ipv6/ip6_output.c:1169
 ip6_dst_lookup_flow+0x47/0xe0 net/ipv6/ip6_output.c:1272
 send6+0x4ce/0x8d0 drivers/net/wireguard/socket.c:139
 wg_socket_send_skb_to_peer+0x128/0x200 drivers/net/wireguard/socket.c:178
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1c8/0x7c0 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rt6_make_pcpu_route net/ipv6/route.c:1473 [inline]
RIP: 0010:ip6_pol_route+0x117d/0x1180 net/ipv6/route.c:2305
Code: ab f8 e9 f4 fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 03 fb ff ff 48 89 df e8 ae 04 ab f8 e9 f6 fa ff ff e8 b4 44 49 f8 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
RSP: 0018:ffffc90004a073c0 EFLAGS: 00010293
RAX: ffffffff8975687c RBX: ffff888126df7000 RCX: ffff888024dd1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004a074d0 R08: ffffe8ffffc4cdd7 R09: 1ffffd1ffff899ba
R10: dffffc0000000000 R11: fffff91ffff899bb R12: ffff88823bf78f00
R13: ffffffff89755862 R14: dffffc0000000000 R15: 0000607ed8e55dd0
FS:  0000000000000000(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdadd5ac18 CR3: 00000000370c4000 CR4: 00000000003526f0


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

