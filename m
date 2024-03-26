Return-Path: <netdev+bounces-82231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23788CC94
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557601F80AF3
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318B13CA97;
	Tue, 26 Mar 2024 19:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C31CD21
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479688; cv=none; b=llKi6ybvXNP6qqdeUfJK3kAij+oIo7pchBQN7ZMbwoPcZR3FdiXJgndhYjOZg9Pv2qN3OxjIgXoNx+g8uMOZaJgS4/j6RUOgO44dF68x5gw1CIUptyknrV/RRj9VAhH4kKHdnL/rZreE/Vk75yr8u21X1L07ud4yuHSFQxOihhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479688; c=relaxed/simple;
	bh=uDnkpd/E/ZhmQfliHxZR4eUNWh0TyWgHVUFDClOx2JU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b3IMtnCWkYbrRjF6630CEwEohOv/8Ek6xB7zlYDnj6/4yOyc2ifUb+zMYp0yg6VggNCpVq6Yp73LzInFBGMYHS9CougfvxjuYF61pnEGySjirIc+mgJgkYbbR8X501vsoRLhwJBwzXtrLVu/Mi2ll0uf3tMgksYOMnyajJTWcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso667138439f.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 12:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479684; x=1712084484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBk5YLO78C1e6LbeCVC01y3eo+IPlOg2beyEL4ZeIME=;
        b=BgAdUDvvcgeFRXCEbRv1jKykjuOKWMvsq5qAaS41oDVr+0p76cpfdgHdnQ0wW4G0Tg
         cGFH4mHetM5eB0aL77tM8ueHo+4jxGGWtBiAK3Y8uTF05YGSE/7cg6XUsnCkHiuPDiNb
         rjgheDUzrXo3PgclPgAJWnyvB0kLeVcTMM9K2A91aPq+PMU8HchVJESpXH+JWQLslcrC
         JTAatw1gIp5a1OMleydmGPkjGr1eyXPiyGzIxJ1Sk1QmGaZzsZGPHz6fPJAcXWVECl3V
         dMrGAdUo6lnSS4sSjByDA47PYMcaSidYEuk5lf0gZwxyMbIo++PNfkGYyv9cnW96o1SI
         E3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWhyRDo4xUDQnyK89xDftX/CGtyZCN0Ojlmt37TuwiOtTCIqZt+sjQ8e/TNyjy5idbZEZlIlmWfwBQvJvAyfH+/1prbohEW
X-Gm-Message-State: AOJu0Yw/lQKQDt8oISuQF2XybQYlkfR43fdCJZj//wCitBp5QACpnEmP
	hfR55JitG2vKzOwRCNBDWKk3tqXo6dJe+YqCKM/q3DcoXL3KUIPFfPsD70RU+IkXHMjldzQtifr
	YhA1M5VMXdnoOoXFisMIfFk5CxJtmlt66vMrTmW8P1Fz2myn7i7D5GAU=
X-Google-Smtp-Source: AGHT+IEA7+UbnRTVERv929IpFZrxKhJAXUoAMW6jMh7SWxzc6Ouqkc9645DBkDDpwh22vhZ94UGSZi9rV/JfdjW5wmWbqUh5iH1X
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13d0:b0:47c:16cc:5780 with SMTP id
 i16-20020a05663813d000b0047c16cc5780mr622804jaj.5.1711479684342; Tue, 26 Mar
 2024 12:01:24 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:01:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a042d7061494ea83@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sk_psock_drop
From: syzbot <syzbot+59286e53e6c7d1921164@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15a444b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=59286e53e6c7d1921164
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59286e53e6c7d1921164@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05271-gf99c5f563c17 #0 Not tainted
------------------------------------------------------
syz-executor.4/21268 is trying to acquire lock:
ffff88802248b238 (&psock->ingress_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802248b238 (&psock->ingress_lock){+...}-{2:2}, at: sk_psock_stop net/core/skmsg.c:802 [inline]
ffff88802248b238 (&psock->ingress_lock){+...}-{2:2}, at: sk_psock_drop+0x2fb/0x500 net/core/skmsg.c:846

but task is already holding lock:
ffff88802c949620 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802c949620 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&htab->buckets[i].lock){+.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
       0xffffffffa000095f
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x291/0x380 mm/slub.c:4396
       sk_psock_cork_free include/linux/skmsg.h:430 [inline]
       sk_psock_stop+0xc5/0x110 net/core/skmsg.c:804
       sock_map_close+0x1b2/0x2d0 net/core/sock_map.c:1645
       inet_release+0x17d/0x200 net/ipv4/af_inet.c:437
       __sock_release net/socket.c:659 [inline]
       sock_close+0xbc/0x240 net/socket.c:1421
       __fput+0x429/0x8a0 fs/file_table.c:423
       __do_sys_close fs/open.c:1557 [inline]
       __se_sys_close fs/open.c:1542 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1542
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&psock->ingress_lock){+...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sk_psock_stop net/core/skmsg.c:802 [inline]
       sk_psock_drop+0x2fb/0x500 net/core/skmsg.c:846
       sock_hash_delete_elem+0x27e/0x300 net/core/sock_map.c:943
       map_delete_elem+0x464/0x5e0 kernel/bpf/syscall.c:1696
       __sys_bpf+0x598/0x810 kernel/bpf/syscall.c:5622
       __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               lock(&psock->ingress_lock);
                               lock(&htab->buckets[i].lock);
  lock(&psock->ingress_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.4/21268:
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: map_delete_elem+0x388/0x5e0 kernel/bpf/syscall.c:1695
 #1: ffff88802c949620 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff88802c949620 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

stack backtrace:
CPU: 1 PID: 21268 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sk_psock_stop net/core/skmsg.c:802 [inline]
 sk_psock_drop+0x2fb/0x500 net/core/skmsg.c:846
 sock_hash_delete_elem+0x27e/0x300 net/core/sock_map.c:943
 map_delete_elem+0x464/0x5e0 kernel/bpf/syscall.c:1696
 __sys_bpf+0x598/0x810 kernel/bpf/syscall.c:5622
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f008787dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f00885cd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f00879abf80 RCX: 00007f008787dda9
RDX: 0000000000000020 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f00878ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f00879abf80 R15: 00007fff30ed4838
 </TASK>


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

