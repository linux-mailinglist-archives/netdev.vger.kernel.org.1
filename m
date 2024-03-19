Return-Path: <netdev+bounces-80670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D5880474
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 19:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BBF1C21AE3
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B372C85A;
	Tue, 19 Mar 2024 18:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DF2BAEA
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871943; cv=none; b=DSm7C9H17Vb2EAtH62v9T6hBMe71oHtt+RloX7tHCnbWrU0wbPc2lL8aYPW/95xf9PW+NB+dLyq6CWB7HoA1TCHbv6ZZI/Vz/P7oII/7jRwh86zHBzm1sbQbqwhknh522kY3DKrrB7dGkm13Ibm6XsSj7qt4EKworEQOC1VK494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871943; c=relaxed/simple;
	bh=8CwvOpkzHWi5sDEiBu4yO13qK3DYHyI818weqm9THfY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X4JkLzTSIQ+tVzS+tQgnUtY2FXAACq/Ikv8GgKaX91l7x8cSft3fYFzMwHeVXREyZ5hPDoVDuLUt19EVNZLV7K29pfg06uWdQWIDcQqAxAevFJIB+j3eFJg/80FtjtGwO/v04iUGo4PWMtMEP0FYCxSViVyuWUwMhuiaePGgcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso408083539f.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871941; x=1711476741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUl8KngKDhKat2ID3WrGzxmO4pwALhdfll2XNSs2Xd8=;
        b=qvDIcy4dfl/S/wSp3pC57jAWQPhy7XIjDLiMt0zsBTEvpnAtm+YEd176yxJ2H5mfbo
         YNqV/vENTrFsUHoQSj1KT1rAAhNlhzDyRTRsVDb+a2MtDtExAKBIyabExydw77nXjO/v
         0lj6lTJG6zQIXScZiYr8EsFe2yEZ6vbSAA/7P4IfbEj3aaR4wNtYPR93z6YF51nla6pv
         2tEpnyeYUnjJ1896iMVFQwgqDr6noCTQGjaLGREyjSNwt6gJDS3zRerGkwenl8kpZcWr
         V7V4+bEpHPqTVfihwxseCiexGT4hfMQKroZnk3TmSiooRTP4lSq4KxdVXPSzHHDtK16u
         ncDw==
X-Forwarded-Encrypted: i=1; AJvYcCXPuY3ygNTGaXEZTBbzi889Ism4LxaGTRP5r0la8kefQkl6a/Ct6tvfvCKGYSxCI1lr9DIjWFVvDlMcvXUudKzat6G8pbgz
X-Gm-Message-State: AOJu0YxhnNeY4/et9KBNSTayxC9QxNPyfkeNj+AY1ns6lWJ0hbzRKTJU
	jHdcafwA36ycoH2O4q6K5NfLjN4I0lyCrDAzU90O2LFKLAaLFpwSn15uKSW44HBneMdkHRq+0FC
	QoIbJXoeVVvHrBAlGU8rdno9EZTX8BZvktfL8GKPKVOoG4F06C5lIsXA=
X-Google-Smtp-Source: AGHT+IHMVS2mCLbNF2hdzoCk8GpLFWyRFSX1ZPuWPNcY8kCgzSWWzeStiW6AYWuYmGmqcqZcY80wuhTt/0Tm5wb/HVekb4fvy3gb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1693:b0:7cc:ce74:4293 with SMTP id
 s19-20020a056602169300b007ccce744293mr171278iow.0.1710871940020; Tue, 19 Mar
 2024 11:12:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:12:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dc8e00614076ab6@google.com>
Subject: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
From: syzbot <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0740b6427e90 Merge branch 'bpf-arena-followups'
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fed769180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=33f4297b5f927648741a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1763a479180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c38711180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e6e9f97566/disk-0740b642.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78476a588b62/vmlinux-0740b642.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50cd6fab9ead/bzImage-0740b642.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:7190:12
index -1 is out of range for type 'u8[8]' (aka 'unsigned char[8]')
CPU: 0 PID: 5071 Comm: syz-executor474 Not tainted 6.8.0-syzkaller-05226-g0740b6427e90 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
 check_stack_range_initialized+0x1668/0x19a0 kernel/bpf/verifier.c:7190
 check_helper_mem_access+0x2eb/0xfa0 kernel/bpf/verifier.c:7294
 check_helper_call+0x263c/0x7220 kernel/bpf/verifier.c:10252
 do_check+0x9e29/0x10530 kernel/bpf/verifier.c:17801
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20500
 do_check_main kernel/bpf/verifier.c:20591 [inline]
 bpf_check+0x136ab/0x19010 kernel/bpf/verifier.c:21261
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f8416194629
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc6f0fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffdc6f0ff88 RCX: 00007f8416194629
RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f8416207610 R08: 0000000000000000 R09: 00007ffdc6f0ff88
R10: 00000000fffffff8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdc6f0ff78 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

