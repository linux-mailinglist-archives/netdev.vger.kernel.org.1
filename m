Return-Path: <netdev+bounces-178857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA5A79387
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB6516D8BF
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9905115CD46;
	Wed,  2 Apr 2025 17:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1542A8C
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613224; cv=none; b=pd0LWb1De+Fh6A5XoeO0j02kerVOw81OezHEHeeZVSGtz9AYZ9awljIdsaV79S5f0i+roWA3v71h3X/fvY8V5aoe9XpwpCkZKozxDy5YlJkTNiUTwvFElKzMyDsK8jny+5DLSP1lTg15IK+/o304yG48pB6zb92X4s0Z1iw3J/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613224; c=relaxed/simple;
	bh=ccLcUgTmXjIF27X8UBrYDxtVpq6fiXDVnXWWX0MuuNA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Toh5MkTuRRyBTLKNDb5TMWi1Z/wSYWTQKhDAtb1LEW3QrvhznPoCD4p0W+OqWITC6YnVdo3o7iDKYkZzY/+mlX+IkKKy3dEaJanNoWwxiGePdyKxo/nAzyHUlIxRE913A9Po0pTa4PW7zsp9ePw+CzmnzuztR+8gmdAXPvqHh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d43d333855so992105ab.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 10:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743613222; x=1744218022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJNKc9NNH1K50V9qxLmrz9u3644fP6bUwf045zuQrTg=;
        b=A3cAidDDGTT4T67EJVPricbSra6rqRGWWefbGKh2yzRnogTsv5zQwtq+5bc44rU43P
         RjfGlybTRWAJ10gW6dzi17RpscIqa2DUOJoVKYiIe6rwsM24/Khon602DrepWwd/idvn
         CfzUsbSYbNmo1KkOFxRqVF34ARyMgFMIoUhC6xAV4iRJGEg6kIB/OT6HH5gGzAx+ndsg
         KbywzTQLNbQfCaw74jEWhRxDHnRZUZqb522XYPkCmRh18AtjoIQpmwxW3XzjnGH15qcb
         hJLRtAZhl4Rk1B4rQ0P+d69yPCjhaL7u0R4Tsti2vq3qViJdWcQuhomAhVWbNd7yH1Tu
         HSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2wG2c16VSKutJNQSB9ifZUldKP2K0+EiTDdZPsNVzpKzFTl0Dxix7xWZRvyFPNHAdGL33rfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwpKIJIGma7Aq8wwUBnAU+SZdwj0KvwnPjI/wjvt+Nu/Zcf2S
	x4NVVyUX7gDu8bQvv7/KWG+cWrPwK89Xz5i06IEf+YLa+HIN34eOXl5gsHhTEXlbYWjmlAgGBHJ
	GAbxYVQ5ry+HPs5jBy3E71Mxs0AH+/4wNCjmETMXcBgya//Q9FahvpwA=
X-Google-Smtp-Source: AGHT+IGxSNbnqTBLFnrEbvRwIqRe3FFuMnpSpt7E64gLr1K/192bq0FwSFPJF2TFBbkRbbLOpeesUQ4xc5vqlVuQeMeLFhx12Jv8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:34a0:b0:3d3:fdb8:1799 with SMTP id
 e9e14a558f8ab-3d6d5549646mr40250905ab.22.1743613222110; Wed, 02 Apr 2025
 10:00:22 -0700 (PDT)
Date: Wed, 02 Apr 2025 10:00:22 -0700
In-Reply-To: <67e6b3e8.050a0220.2f068f.0079.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ed6d26.050a0220.297a31.001d.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in dev_xdp_install
From: syzbot <syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, hawk@kernel.org, 
	horms@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, song@kernel.org, stfomichev@gmail.com, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    acc4d5ff0b61 Merge tag 'net-6.15-rc0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124f9404580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=410c49aba9aeb859
dashboard link: https://syzkaller.appspot.com/bug?extid=08936936fe8132f91f1a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109b7c3f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103fa178580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-acc4d5ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aad60517b1c2/vmlinux-acc4d5ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27bf64833684/bzImage-acc4d5ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 5936 at ./include/net/netdev_lock.h:54 netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
WARNING: CPU: 3 PID: 5936 at ./include/net/netdev_lock.h:54 dev_xdp_install+0x610/0x9b0 net/core/dev.c:9911
Modules linked in:
CPU: 3 UID: 0 PID: 5936 Comm: syz-executor652 Not tainted 6.14.0-syzkaller-12456-gacc4d5ff0b61 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
RIP: 0010:dev_xdp_install+0x610/0x9b0 net/core/dev.c:9911
Code: 8d bc 24 30 0d 00 00 be ff ff ff ff e8 b9 0d 28 02 31 ff 89 c5 89 c6 e8 4e f4 71 f8 85 ed 0f 85 59 fb ff ff e8 01 f9 71 f8 90 <0f> 0b 90 e9 4b fb ff ff e8 f3 f8 71 f8 49 8d bc 24 30 0d 00 00 be
RSP: 0018:ffffc900031d7950 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802ab20cc5 RCX: ffffffff89494752
RDX: ffff88802a4b2440 RSI: ffffffff8949475f RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802ab20000
R13: ffffffff87119240 R14: ffffc90000a26000 R15: 0000000000000002
FS:  0000555586ae1380(0000) GS:ffff8880d6cbb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000140 CR3: 0000000030ae2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_xdp_attach+0x6d1/0x16a0 net/core/dev.c:10094
 dev_xdp_attach_link net/core/dev.c:10113 [inline]
 bpf_xdp_link_attach+0x2c5/0x680 net/core/dev.c:10287
 link_create kernel/bpf/syscall.c:5418 [inline]
 __sys_bpf+0x19ef/0x4d80 kernel/bpf/syscall.c:5904
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5939
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa71b995919
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc061aef48 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa71b995919
RDX: 0000000000000040 RSI: 0000200000000200 RDI: 000000000000001c
RBP: 0000000000000000 R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

