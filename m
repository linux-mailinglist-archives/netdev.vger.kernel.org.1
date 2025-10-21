Return-Path: <netdev+bounces-231158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A97BF5C7E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766793BECF1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092F932C931;
	Tue, 21 Oct 2025 10:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB932C301
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042604; cv=none; b=Dn9Z4PX1CrSCPRkpSLb/MVuPwdzjo3eP29HCPgf7Vyem/P6ygvAFbRQ2xnDjylM2MooitaH+KzzZppoBiiLs+56vojXpCuZB8S6NtfLiR3p/uoNGNtjsGxGAO0xv27ieGgPyhJUpg0vjKhZrI1yvQTSuz4Qua0l85oVPQjaSU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042604; c=relaxed/simple;
	bh=ba92ZCaLSrFbTakAqUS+7a9wqQ6yNp8OihEI0CLwPVk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWTeUn92r1L0N2KZpG8Aykz70X0U3daVjcJkmQShKKCtT00h7hrU7MhND34lDp02zl5YsCsIdGjNQnkNCewPxsxpAUf9sCSDq4t5PjPVLb1dyyprSDzf3xaX7ITJ3KJrk3EErO6jMPmXU712U9u+yJngl6IE/4OlKoSpMrnIBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940123e842bso730281539f.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042602; x=1761647402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXSxkzjbwtGmJhGcySsnjpN4sygoTHK1MyL+PLfqk9s=;
        b=JxjSyHp98B3eFGS+Dg91iiI7iaywX92T+6E/BBVNbgw8TzJ7RNbLuOVkBy0TQZBLB6
         XB5N4cnC27H0+1OG7rJPI0vMc57zGeGxgfJNehX46GOy1ERsxxLT5HvXuTC9GZ6E/PlQ
         qBl3pWErKFxFplC3xjd0ZTsSQJ83hzeHALZ8QsyPW7rlGu5ucN4mjV71VbMQYq4v4R1L
         oggvi94bOeFzU/duzSJBmCXiPI6jtE4ZH77JCQi/CbrCIFXpb/De4Tq91UdXs+duWKpa
         1vNHr6pSJ8Su5JsNLH1cJl3ZCnCKmsm1zclC6Hq641zckYPBvzkkV3uIFCzeB4a3/ADr
         eHTA==
X-Forwarded-Encrypted: i=1; AJvYcCU3qpLYnpnxJ4Y/9vP4XlPa4DKMDAzIB6ImZ035GcMGdd0CISdZytjYGFs8kWtuogDuQKTCtFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2knMFdHaLewIZp372M/WaXRLy1WdWWsREVRsqHlo+tnu5X7p
	bpBC9J91IAr4jnPrKmCatBFWe8AgPPb/d6zldqVQ0MpmSZ/fRHHUP1VpF4kpPBiaHr6Oo5dQQPv
	uexHe2nD3DOFEv9nmzLc9WwIi1LGJNdSEJbZcwGT5GBs9Bdg8cOEXOnx1HPo=
X-Google-Smtp-Source: AGHT+IG06J3L1XW+DZ5LbGn7uIFP7KU+5mmoBslNxd/mYtvcjn7tb7bHBFtCd6Q7iYtLJtff3ds5pJwk+L2+RZmZcUkSq3Vot/jX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c05:b0:940:f0a7:30d7 with SMTP id
 ca18e2360f4ac-940f0a7354emr90628639f.15.1761042602505; Tue, 21 Oct 2025
 03:30:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:30:02 -0700
In-Reply-To: <u6mwe4gtor7cgqece6ctyabmlxcaxn7t2yk7k3xivifwxreu65@z5tjmfkoami7>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f760aa.050a0220.346f24.000d.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in vsock_linger

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6384 is trying to acquire lock:
ffff888055028b18 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
ffff888055028b18 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1080

but task is already holding lock:
ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (vsock_register_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
       vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1592
       __sys_connect_file+0x141/0x1a0 net/socket.c:2102
       __sys_connect+0x13b/0x160 net/socket.c:2121
       __do_sys_connect net/socket.c:2127 [inline]
       __se_sys_connect net/socket.c:2124 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2124
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_VSOCK){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1080
       virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
       virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
       vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
       vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1592
       __sys_connect_file+0x141/0x1a0 net/socket.c:2102
       __sys_connect+0x13b/0x160 net/socket.c:2121
       __do_sys_connect net/socket.c:2127 [inline]
       __se_sys_connect net/socket.c:2124 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2124
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(vsock_register_mutex);
                               lock(sk_lock-AF_VSOCK);
                               lock(vsock_register_mutex);
  lock(sk_lock-AF_VSOCK);

 *** DEADLOCK ***

1 lock held by syz.0.17/6384:
 #0: ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469

stack backtrace:
CPU: 1 UID: 0 PID: 6384 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
 lock_sock include/net/sock.h:1679 [inline]
 vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1080
 virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
 virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
 vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
 vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1592
 __sys_connect_file+0x141/0x1a0 net/socket.c:2102
 __sys_connect+0x13b/0x160 net/socket.c:2121
 __do_sys_connect net/socket.c:2127 [inline]
 __se_sys_connect net/socket.c:2124 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2124
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f300598efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3006912038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3005be5fa0 RCX: 00007f300598efc9
RDX: 0000000000000010 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f3005a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3005be6038 R14: 00007f3005be5fa0 R15: 00007ffdba0a0048
 </TASK>


Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162a5492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a04e7c580000


