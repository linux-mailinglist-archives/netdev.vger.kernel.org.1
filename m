Return-Path: <netdev+bounces-67906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56BB8454EC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149681C23DE6
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FE15B0FE;
	Thu,  1 Feb 2024 10:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09815AABD
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782347; cv=none; b=nBIWzCWvMkeGkbfnMzKu6la3l6m2g0va5UCnC68lljCXF7HbtQx/rJiPb2OBOl6hr/FAG1BnhJ2W4z62wit5cypN94yXDN3v9gTApRHGItvPwD28pHOXtYxBdgrzdN4SwqJd5/INr9e8b4KSuUO+gD7AjAKsfAC3Tv7477r+/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782347; c=relaxed/simple;
	bh=0hkGTq+IfUCvwYmNvyoNZ0aTtPEQahj/pe57w9qIgMk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cUiypNH9sR1e0HJhACbSjmmiO936zMPFUey3mlR9Q2JJJfsh9lAzHaNbHe5/kly50ojcquTJP9QTBbFmsqNDbA8QLB9h/dbGmusgocNhLSSA5jT1IcoY5bt00KhUziLe1lX//1731j7R2Rz+vPbNkVN2vXXHw1jHd8KMGFlcbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bfffd9b47fso55617339f.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 02:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782345; x=1707387145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Asvm9Ng9v04fcnG9TARg/mgu5KJMM7tuU6wye4lAsNY=;
        b=ir1uTi0xpciN5LMYBeQNwna8+XvciWotDCAxa8vvxnZEYwuUqwxeIO5vtDeXc3vleB
         GwrnicpMkJidqfSex0zKsBQHLIobIjZPf6UKrFIaaUu+3eHIf173jHi3soGqqruU1F/T
         E5kQ7HJZdVGMBDfHIrc4FyBnYhnBldYyuRLwllFDZtlszOI/BKSg2F2pTJ90mqlIRwYY
         cFAwUPt6xJKUE4WrxKAV63/eyGMaU0GTI88NZnPHetb5Ir0kQw1cKbshDkHtSQtBlfNO
         zByp1bHgurep1t7ruQZsJmTTk9MhWYge1jkn2Kt7xqQfMixR6+4RKHUMwcK+PEfeqRKP
         cBtA==
X-Gm-Message-State: AOJu0Yx5eeadP6v2ceV+m7PobRuCSJ4/pFwutNC2cbcg1PyWqNLYJkU6
	mswvwCSglxw7+agSQSaKxEnA2nQZAXzTOBp/l3aac8PMxcnV5R6hUaexRpoMF/gMkopq8gL3+Ey
	5DpYit1IA5eaSxdvP/HiXX9Q4ajZo6C334fd9+TPewXeej8v2l/fs7zU=
X-Google-Smtp-Source: AGHT+IHPOwfpLUsGJ/kYBOjvVxEPaanltLISeaZxKkJShYH6tg0o8LqNJReL0ZqbXA22eXjJF9PUJevPkLA+oEfj6Q05uMppTIZz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:363:9211:a723 with SMTP id
 i12-20020a056e021b0c00b003639211a723mr377330ilv.2.1706782345179; Thu, 01 Feb
 2024 02:12:25 -0800 (PST)
Date: Thu, 01 Feb 2024 02:12:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064b78606104f3b91@google.com>
Subject: [syzbot] [net?] [s390?] KCSAN: data-race in __sys_connect / smc_switch_to_fallback
From: syzbot <syzbot+ab2213db98841b6ead07@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4854cf9c61d0 Merge tag 'mips-fixes_6.8_1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149d01efe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1bd33f45956bbc2
dashboard link: https://syzkaller.appspot.com/bug?extid=ab2213db98841b6ead07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e44f160651d1/disk-4854cf9c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6a2062d07e6/vmlinux-4854cf9c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d179908ef3c/bzImage-4854cf9c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab2213db98841b6ead07@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __sys_connect / smc_switch_to_fallback

write to 0xffff88812a230bc8 of 8 bytes by task 1831 on cpu 1:
 smc_switch_to_fallback+0x453/0x740 net/smc/af_smc.c:924
 smc_sendmsg+0xd6/0x330 net/smc/af_smc.c:2772
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x1e9/0x270 net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffff88812a230bc8 of 8 bytes by task 1833 on cpu 0:
 sock_from_file net/socket.c:514 [inline]
 __sys_connect_file net/socket.c:2037 [inline]
 __sys_connect+0x11d/0x1b0 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x41/0x50 net/socket.c:2072
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0xffff8881293bc000 -> 0xffff8881293bf400

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1833 Comm: syz-executor.0 Not tainted 6.8.0-rc1-syzkaller-00385-g4854cf9c61d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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

