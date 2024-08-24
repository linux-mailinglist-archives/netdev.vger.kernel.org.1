Return-Path: <netdev+bounces-121658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20B95DF17
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E7B21A2A
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F32AE93;
	Sat, 24 Aug 2024 16:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DD4A07
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724518103; cv=none; b=ZXE1vgsYmEQAdIcOF4+EoGhGUyIMBaA8Nqy3PCGuUvDkKV0izLtdpLLVxIPAfh5z/ryVosnpiOyoe7x20t7NligN2c5EJSpC88Ddt7knUQ2Chznx/J/YAbd4PyVVcZRnTZF8qgDewbA0PgjQBkhFyfrhHuwYNOx7yQkaS/Giibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724518103; c=relaxed/simple;
	bh=h6WzL9If4cMinJSYJ1LeP1Z0oDudGPJ5BK2udcK5KyM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aTEj0GXiX4lfndaLolH/no0kEmuDOfqkUTIv4mrqgyCThB9xkwyV6ze1/DdzFl0rkxQbdNrmfh6ADLrD9wbZMq6hHBR6y5TVtUfMT+aKCOwIGUJZf/7jbb1wkv2HdLnhauOsKyw/ZPW60D1c+MQD1AZHl5tl2biWVEjqCv7R72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso308697439f.0
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 09:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724518100; x=1725122900;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjy+7n3uJXEZ7Kfucu9znJa5/9sqx4pB74fbJ+U9CGw=;
        b=MCXB4/Snp1xxIQRnP0sawNMcqDbs/JIYYr4EQTLmV1HEa8NXVMqelG7XBrTWKfeUpo
         oNkdj40gT+HY/9YLhkObH9hT4DozElVMFgH22wkBZyW6iTUQ7OLcmSws+7ar65quZBgc
         /qOyoOj+FU4XBKIsiGSPImz+UcOS5wxjtRpXXlySwFBiN60xKUNFy92EMSo3VfA5/s51
         PkeVwvHzJt1sfL+I1/F43vJjUFFwxnFpAEYqDIJ0tEFMQcTJyZioPDYoS4KFV3GscQYQ
         iTq5gbGVeZfKlOtt3GBYCxDLrld7+NUahS+B6kiV/T57oLGtPcOMg5da8JiErte5mQEG
         zDuA==
X-Forwarded-Encrypted: i=1; AJvYcCWlcKwqn6E3eetkwKcdXWuG+fWU1W8LVt2no3uwFQ8hem+i9DneAdrml+FSEv9YTSmW4DTg+t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI++ft8Y7IiOwE1Cc7ybx/eoCcrpx9C88y3BR+dyA5xRO1HfpK
	8gLN5gZetGj4IpVKYTMaGRkZOXhYG/EEsvAR1iqv4+5cyYk8w8XHvQpfL4SqYuxzj732miEGPE5
	rZuXwUFD8lQ1HnvWVdBNwxgEof837LU/7A3F/cSm1EiW2Brszvc2tNWw=
X-Google-Smtp-Source: AGHT+IH4Iv41psv2WljBsb9ObXqn0j2nEi7jnKQIsqxHXZryIdbVlc5M0LeXmlZoBSyIVJPYVTvozQ07dylLKufzr1HMlm91Tbob
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1d5d:b0:4ce:8f9d:30fb with SMTP id
 8926c6da1cb9f-4ce8f9d465emr45999173.6.1724518100484; Sat, 24 Aug 2024
 09:48:20 -0700 (PDT)
Date: Sat, 24 Aug 2024 09:48:20 -0700
In-Reply-To: <00000000000039e8e1061bc7f16f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9d5c4062070a857@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1214fd05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e70233980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a44815980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8864ed10d80d/disk-d2bafcf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6165bc385834/vmlinux-d2bafcf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83bf9db2da50/bzImage-d2bafcf2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc4-syzkaller-00255-gd2bafcf224f3 #0 Not tainted
------------------------------------------------------
syz-executor266/5220 is trying to acquire lock:
ffff888017752958 (sk_lock-AF_INET){+.+.}-{0:0}, at: do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078

but task is already holding lock:
ffffffff8fa72248 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_vlan_by_tcpsk+0x399/0x4e0 net/smc/smc_core.c:1853
       __smc_connect+0x2a4/0x1890 net/smc/af_smc.c:1522
       smc_connect+0x868/0xde0 net/smc/af_smc.c:1702
       __sys_connect_file net/socket.c:2061 [inline]
       __sys_connect+0x2df/0x310 net/socket.c:2078
       __do_sys_connect net/socket.c:2088 [inline]
       __se_sys_connect net/socket.c:2085 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2085
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(sk_lock-AF_INET);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

1 lock held by syz-executor266/5220:
 #0: ffffffff8fa72248 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077

stack backtrace:
CPU: 1 UID: 0 PID: 5220 Comm: syz-executor266 Not tainted 6.11.0-rc4-syzkaller-00255-gd2bafcf224f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 lock_sock_nested+0x48/0x100 net/core/sock.c:3543
 do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
 ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9dbe0ada79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf0f564e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9dbe0ada79
RDX: 0000000000000023 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f9dbe1205f0 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

