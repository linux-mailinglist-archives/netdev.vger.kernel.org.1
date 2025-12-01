Return-Path: <netdev+bounces-242878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A3C95979
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D1B3A1CE7
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4718787A;
	Mon,  1 Dec 2025 02:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA32AD00
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556348; cv=none; b=n5NA7Ba83M1PnqYl8bw1WyJ3yzwE41Q8vhl42rwkEe/llfgur3ULbhpo5K2myoI1g8BeLZQ4b1xzmaDCT0lgbv8k8NniN6qbcMZ3IFf1/Ouaiov0W2qEowpWmH8+IneJJ/JDxHZj7hLrs4domRxg6UBS7t0AEvdKc+yiI3gWgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556348; c=relaxed/simple;
	bh=i+kwUzgEmc26CQBw7pdjwReX7JrLVaeG6NmqYHHo7hA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pqUYRTSU8+VloRpWy2yM0ilLi4vuZmjogiFAneQzFtmSAqKb+dairvXvdV15myLWvwR2hOzaN5I6jYjNLo9GsqaW9/DStX9HzcgsAMgz7eaQKooJB1L6ZbWsUnC2sTxP9T0xaRaZrv0fehQXKq8g76ffCa/+Tv/cpfvpeIEsNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43300f41682so23195415ab.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 18:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556346; x=1765161146;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Aa7TmcvGyNIx9pldfhA8GwF9CpERVegDJ3Pj1q1Og=;
        b=aRqP+nEctdHdwrLEaB9JhphsqVGICU7l+5Xv98ktqHtbSdMWhj0CoECuQtoUd45mvV
         lG9cydJ9QmFVmfel2x+/y3doGDSiLDIVPvMH4MlXtp/CIYuMNMxdmVllfoL7WiShPYZx
         fbwQ4JPohnegeZv4pzcZ6vkozHa0To0ZtPWuWNU5OgoyViHYLIHxWKW0nEqZ3YnzQ/t9
         pGFoaOQMLawnnbJONsLsIg5zD2zI+5GTEexQDi3JqC+UbQYNszhTYetT1pkxmnOBNXCJ
         vN411IZ/5C/l2d+BYluKypEVka2mW5pV1zqtdjx69bcJ8XE6XlAPBmk0C8Fy9zcm/eg1
         W6gw==
X-Forwarded-Encrypted: i=1; AJvYcCUEW/j52IrCeHxZhFTGJWtq8VxUzk5iJx/rpqtlpfBWrNnBaeH/xHX3FciA1JzTFvE0V1nxBLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1frCX99jOgyG54zv3brIT1ajlXBSBaWaO64vH4Sa4VHpKQuhP
	yYWDZ8egYAnmXygLt4xz5KxMlN0MChRZx+bfw0IJnyB0PidaxookbrwwNSBALWXlGXW3WC1N31p
	KyYj95ozcmzZ/FCfbjBUAkJaHxwlUKhR8z6j5H2oah6Hb1aj5OLwdxOI1k9E=
X-Google-Smtp-Source: AGHT+IGJw7gLZkoJDa2ZuiPEoq8Y1mPuFfG1/Td2PnE4zu5oY8Lvhl15V1PriBUqTgQyJNx8v3tIvhP2FR5FzpcAtVDXTlsrcXCh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:433:7688:a6ea with SMTP id
 e9e14a558f8ab-435b98d0114mr267060065ab.25.1764556345816; Sun, 30 Nov 2025
 18:32:25 -0800 (PST)
Date: Sun, 30 Nov 2025 18:32:25 -0800
In-Reply-To: <6918cd88.050a0220.1c914e.0045.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692cfe39.a70a0220.2ea503.00ac.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in ip6_pol_route (2)
From: syzbot <syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e69c7c175115 Merge tag 'timers_urgent_for_v6.18_rc8' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fe98c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38a0c4cddc846161
dashboard link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ab4192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fe98c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ba30df3c7a5/disk-e69c7c17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/794674f290bd/vmlinux-e69c7c17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/872c0363d566/bzImage-e69c7c17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/ipv6/route.c:1473!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6073 Comm: syz.2.34 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:rt6_make_pcpu_route net/ipv6/route.c:1473 [inline]
RIP: 0010:ip6_pol_route+0x117d/0x1180 net/ipv6/route.c:2305
Code: aa f8 e9 f4 fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 03 fb ff ff 48 89 df e8 9e cf aa f8 e9 f6 fa ff ff e8 64 0d 49 f8 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
RSP: 0018:ffffc9000407f5a0 EFLAGS: 00010293
RAX: ffffffff89759fdc RBX: ffff888126ef4000 RCX: ffff88802ea13c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000407f6b0 R08: ffffe8ffffd488af R09: 1ffffd1ffffa9115
R10: dffffc0000000000 R11: fffff91ffffa9116 R12: ffff888031da18c0
R13: ffffffff89758fc2 R14: dffffc0000000000 R15: 0000607ed8e548a8
FS:  0000555563d45500(0000) GS:ffff888126ef4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8a8bbe1760 CR3: 0000000031586000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 pol_lookup_func include/net/ip6_fib.h:617 [inline]
 fib6_rule_lookup+0x1fc/0x6f0 net/ipv6/fib6_rules.c:120
 ip6_route_output_flags_noref net/ipv6/route.c:2684 [inline]
 ip6_route_output_flags+0x364/0x5d0 net/ipv6/route.c:2696
 ip6_route_output include/net/ip6_route.h:93 [inline]
 ip6_dst_lookup_tail+0x1ae/0x1510 net/ipv6/ip6_output.c:1141
 ip6_dst_lookup_flow+0x47/0xe0 net/ipv6/ip6_output.c:1272
 tcp_v6_connect+0xbdb/0x18a0 net/ipv6/tcp_ipv6.c:281
 __inet_stream_connect+0x2ae/0xe70 net/ipv4/af_inet.c:679
 inet_stream_connect+0x66/0xa0 net/ipv4/af_inet.c:750
 __sys_connect_file net/socket.c:2102 [inline]
 __sys_connect+0x323/0x450 net/socket.c:2121
 __do_sys_connect net/socket.c:2127 [inline]
 __se_sys_connect net/socket.c:2124 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2124
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b578bf749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb60b5268 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f7b57b15fa0 RCX: 00007f7b578bf749
RDX: 000000000000001c RSI: 0000200000000200 RDI: 0000000000000003
RBP: 00007f7b57943f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7b57b15fa0 R14: 00007f7b57b15fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rt6_make_pcpu_route net/ipv6/route.c:1473 [inline]
RIP: 0010:ip6_pol_route+0x117d/0x1180 net/ipv6/route.c:2305
Code: aa f8 e9 f4 fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 03 fb ff ff 48 89 df e8 9e cf aa f8 e9 f6 fa ff ff e8 64 0d 49 f8 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
RSP: 0018:ffffc9000407f5a0 EFLAGS: 00010293
RAX: ffffffff89759fdc RBX: ffff888126ef4000 RCX: ffff88802ea13c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000407f6b0 R08: ffffe8ffffd488af R09: 1ffffd1ffffa9115
R10: dffffc0000000000 R11: fffff91ffffa9116 R12: ffff888031da18c0
R13: ffffffff89758fc2 R14: dffffc0000000000 R15: 0000607ed8e548a8
FS:  0000555563d45500(0000) GS:ffff888126ef4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f53a449f358 CR3: 0000000031586000 CR4: 00000000003526f0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

