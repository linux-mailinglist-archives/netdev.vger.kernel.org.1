Return-Path: <netdev+bounces-180784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A34A827F3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D9C8C23EF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB925D908;
	Wed,  9 Apr 2025 14:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07E1A239F
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209152; cv=none; b=ZQHL+r03t0UGdezysLkMyYcfkByHrGNJwUl88hj0D13GSuLC2wFl/YC5GcZ3O+Ca8NOaTtfQLWzavx3n9egt69ELikYcEYNrNz2X7h2HdvzrU1pTrqwvhGklj7HaMuLeHtNkWJpiQoe2LnJqwauDmY9zd0TWkUXMw52cHtpztEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209152; c=relaxed/simple;
	bh=HuiEp+9QHj6PTNBdnkm5x4zYQBreulDB2Wg2oZqnIdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qKccPpzYFuUmxY6OLQX+JQxe+PpBPvlSvNb8X1GZ/QunoqQz6gkfuzcCrUjrzHdh5NK6SbV9D7VmIswu5XEHfdj+qmDve1Ov+oH3ZX/F5G9WERYFhq8oQ57BJhMbqsF5avXACkP7arPBIDc2cOL8GcFJX7KezvSsoUnr/qI6uFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso8307295ab.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 07:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209149; x=1744813949;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1zaeuHbhS5F7qKe4+xVWwP5j3MS9s5Jd50ybDTISJc=;
        b=pm+1FzuKNjjXywunjgDCZRml/JgrCgpUh+/OloyrQeD/H3qdEUNzoEEoliwcJIHqX/
         +OIm5lXgNUI4/NSHqvr8deK9hCzH2DzH7cS/8ApET6/tayJGc/YhWqD/AjQ6HoKkg8Xr
         DfvzFZ6/sXbKU4iSB77Jcae8Z5NTbU+32XObOieklop82PPQUBIY2Az2OmiV5QK9KjTX
         sa7PXFMRlK8mhvOD1mJRKJ/LKzkm2cj7li0BvQpO0bfH9wt81T59ejCSyeNKYbaA3K3b
         ALw/jv1MqgSChqG9S8aZ78sy5syMPNLNxzBWeNUfBRYmprgWSal5ZSaa6v+Zd6+EHEMh
         gTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSoBhQtICO8bT0fANHzIwO9fUg8UCnSHZppdAiLORu3aKUeavQbfcrzPRXU7fzt1i13pF9uNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SBfwruPImYv+ZEBQdoIUkurWMoYRyDNQvSBVmVYwKNM+XWyg
	/HBrwaiTOgli6jHr2Aa9DAGp11tpOmUpNrGUMe+KN77thW4mikMAlD8CYI4a5SZ6x7ssWOtllnV
	yswJSjzerRDX5dElvf49ri+CTIsHSVobUZo3jFdTSJ0ZZobIKoq3uGxg=
X-Google-Smtp-Source: AGHT+IFEosU1M9V36tUakIkmCYwraiqzePN5cuZuIqi47BPRqD5pWtHWGRbPHQe2mdTGfgx18w0cTqWq+D/Bca7BX5/2LU+I0mMv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d76bc2e9a3mr25448065ab.8.1744209149572; Wed, 09 Apr 2025
 07:32:29 -0700 (PDT)
Date: Wed, 09 Apr 2025 07:32:29 -0700
In-Reply-To: <67d99951.050a0220.3d01d1.013e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f684fd.050a0220.25d1c8.0005.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in udp_tunnel_update_gro_rcv
From: syzbot <syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    420aabef3ab5 net: Drop unused @sk of __skb_try_recv_from_q..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14c92c04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169eb23f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17abfb4c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e407e3b3a07/disk-420aabef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08826ad1cf0b/vmlinux-420aabef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df2ffedb4e99/bzImage-420aabef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5837 at net/ipv4/udp_offload.c:123 udp_tunnel_update_gro_rcv+0x28d/0x4c0 net/ipv4/udp_offload.c:123
Modules linked in:
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor850 Not tainted 6.14.0-syzkaller-13320-g420aabef3ab5 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:udp_tunnel_update_gro_rcv+0x28d/0x4c0 net/ipv4/udp_offload.c:123
Code: 00 00 e8 c6 5a 2f f7 48 c1 e5 04 48 8d b5 20 53 c7 9a ba 10 00 00 00 4c 89 ff e8 ce 87 99 f7 e9 ce 00 00 00 e8 a4 5a 2f f7 90 <0f> 0b 90 e9 de fd ff ff bf 01 00 00 00 89 ee e8 cf 5e 2f f7 85 ed
RSP: 0018:ffffc90003effa88 EFLAGS: 00010293
RAX: ffffffff8a93fc9c RBX: 0000000000000000 RCX: ffff8880306f9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8a93fabe R09: 1ffffffff20bfb2e
R10: dffffc0000000000 R11: fffffbfff20bfb2f R12: ffff88814ef21738
R13: dffffc0000000000 R14: ffff88814ef21778 R15: 1ffff11029de42ef
FS:  0000000000000000(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04eec760d0 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_cleanup_gro include/net/udp_tunnel.h:205 [inline]
 udpv6_destroy_sock+0x212/0x270 net/ipv6/udp.c:1829
 sk_common_release+0x71/0x2e0 net/core/sock.c:3896
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1391
 __fput+0x3e9/0x9f0 fs/file_table.c:465
 task_work_run+0x251/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa11/0x27f0 kernel/exit.c:953
 do_group_exit+0x207/0x2c0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04eebfac79
Code: Unable to access opcode bytes at 0x7f04eebfac4f.
RSP: 002b:00007fffdcaa34a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04eebfac79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f04eec75270 R08: ffffffffffffffb8 R09: 00007fffdcaa36c8
R10: 0000200000000000 R11: 0000000000000246 R12: 00007f04eec75270
R13: 0000000000000000 R14: 00007f04eec75cc0 R15: 00007f04eebcca70
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

