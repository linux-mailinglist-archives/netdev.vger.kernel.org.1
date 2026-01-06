Return-Path: <netdev+bounces-247427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752ECF9EC6
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1498C3011B34
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC03236C5AB;
	Tue,  6 Jan 2026 17:58:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14236C0D3
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722301; cv=none; b=md1TzR0IAHlqH+eQW5QHOTwrkEvvEM/Dq3u7MQhJvGez53aq/5lONcChYaNlvFJWtR1AphraEICli2cXsElEdnRrtk4FuPQ/Et2CkE5Zucgw8/M/nKe38sNWbmFO6SnoKoU7IP8JQW+tMJIKigK6EaBfTF2JnHL4XypBlm6UjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722301; c=relaxed/simple;
	bh=GeC1wzz/BzCh5VKa8RqtZPht6cwTpf4rZvYlLULCZK4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AFr68XS65/a4fHySz661nuxgs6wzMEw37TGnx2tFiDn8gJa+1wIrRV/v/jMgnflaysDeCqPCNgFrjzDwSMJsiIcll5xCSp6LlOU7K9bKaDZr/rJhMNBwDa9k6TF4l1cgLdwjmdDh5X9cnDu2IoLX9Fr5mSITqY4bKHBzkQ6edjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65f540eb569so349642eaf.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 09:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767722298; x=1768327098;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecILTXmNBy0fKgfOs0SfQqMPjlEgpuJmc2Q1J1Cy+xc=;
        b=uG3+jFzUXxkefIL9ma+q989rjIU8AgtNg+NbhYxSHuqkC8nYHAxUs7w1/3LoHPX9Y4
         E4FQj+voRnLoTPukcC1556rqO5IsjFyiXXy8pVHCiEseVsQhSreXe7G+efGOwtada7GW
         TXICDx1PPdKoHZLVPjzzi0jUQ6CLeTHrKDFBvtje/T82IrdeYWjuzg1LyYURHxNZr4dC
         7fcrJP3W2zSFiIPBwr39cTXF18iugWAliggLIHNKKUtezyodwDEMA/tP14s+qmvzTFhn
         rPpCBGjxEHmIUnj8xMYSSaByi2cufG7tfoHbx10Jy4B74hLnzmFB1gxnk51NeSBUj8du
         7Kag==
X-Forwarded-Encrypted: i=1; AJvYcCX0CCbu+rXP8kTy4tTBDlN/Sy/MLUtR/rCgpDRhwHfxl3+o7h6oVoio3AGHVkY/uDPwHk8t3Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQI1N/hZ3gB+I7kkTItVs+Ka4NnPH2ysoGNJgWU8J1pDbJiEt
	mmEEFbZK5TOSf7Zx5Q1iS4E0RmTYKWt+u+UpvN8GlHnjkhjt6qOvmJYQ5IF6HkVJSsoLn9G4WKM
	1NBdLbvWWTaLEF2rsp5/QGFJL5u/zGcNkfN7JIwsvwclQpwU0/g1Lm6mJJUg=
X-Google-Smtp-Source: AGHT+IEQaMRGbleLYFukob6W8d4VCSrye5DcebU6+jNelexNLG0eN0NqeSgQswP2srZB7bzOVmbreeeNhKrrUK9gsmknxf8e+c/d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1517:b0:65e:eec4:70d5 with SMTP id
 006d021491bc7-65f479a5a40mr2304074eaf.8.1767722298753; Tue, 06 Jan 2026
 09:58:18 -0800 (PST)
Date: Tue, 06 Jan 2026 09:58:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695d4d3a.050a0220.1c677c.0349.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in fib6_add_rt2node (2)
From: syzbot <syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1d528e794f3d Merge branch 'bpf-fix-bpf_d_path-helper-proto..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=159c51c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1
dashboard link: https://syzkaller.appspot.com/bug?extid=cb809def1baaac68ab92
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139c51c2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b2961a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aec210aa3af6/disk-1d528e79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7d58dbcc713/vmlinux-1d528e79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c22e61a8447d/bzImage-1d528e79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/ipv6/ip6_fib.c:1217!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6010 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:fib6_add_rt2node+0x3433/0x3470 net/ipv6/ip6_fib.c:1217
Code: ff ff 48 8b 4c 24 08 80 e1 07 80 c1 03 38 c1 0f 8c a4 f9 ff ff 48 8b 7c 24 08 e8 08 4d 28 f8 e9 95 f9 ff ff e8 0e 64 c2 f7 90 <0f> 0b 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fa ff ff 4c 89 ff
RSP: 0018:ffffc900030a7660 EFLAGS: 00010293
RAX: ffffffff89fee772 RBX: 0000000000000001 RCX: ffff88807a2abd00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc900030a7850 R08: ffffc900030a7910 R09: 0000000000000050
R10: 0000000000000000 R11: fffff52000614f24 R12: ffff888074779818
R13: ffff888074779800 R14: dffffc0000000000 R15: 0000000000000002
FS:  000055556dfd5500(0000) GS:ffff8881260b1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000074636000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 fib6_add+0x8da/0x18a0 net/ipv6/ip6_fib.c:1532
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3946
 ipv6_route_ioctl+0x35c/0x480 net/ipv6/route.c:4571
 inet6_ioctl+0x219/0x280 net/ipv6/af_inet6.c:577
 sock_do_ioctl+0xdc/0x300 net/socket.c:1245
 sock_ioctl+0x576/0x790 net/socket.c:1366
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf1918f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe117d8c08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbf193e5fa0 RCX: 00007fbf1918f749
RDX: 0000200000000000 RSI: 000000000000890b RDI: 0000000000000007
RBP: 00007fbf19213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbf193e5fa0 R14: 00007fbf193e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fib6_add_rt2node+0x3433/0x3470 net/ipv6/ip6_fib.c:1217
Code: ff ff 48 8b 4c 24 08 80 e1 07 80 c1 03 38 c1 0f 8c a4 f9 ff ff 48 8b 7c 24 08 e8 08 4d 28 f8 e9 95 f9 ff ff e8 0e 64 c2 f7 90 <0f> 0b 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fa ff ff 4c 89 ff
RSP: 0018:ffffc900030a7660 EFLAGS: 00010293
RAX: ffffffff89fee772 RBX: 0000000000000001 RCX: ffff88807a2abd00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc900030a7850 R08: ffffc900030a7910 R09: 0000000000000050
R10: 0000000000000000 R11: fffff52000614f24 R12: ffff888074779818
R13: ffff888074779800 R14: dffffc0000000000 R15: 0000000000000002
FS:  000055556dfd5500(0000) GS:ffff8881260b1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000074636000 CR4: 00000000003526f0


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

