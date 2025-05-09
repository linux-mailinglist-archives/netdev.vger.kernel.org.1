Return-Path: <netdev+bounces-189356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3FAAB1D90
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C62E1B65C3B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91F254B0E;
	Fri,  9 May 2025 20:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B12356B1
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820829; cv=none; b=j3ePu2bqhixgqlPue3ax7NRO0i5eN1g/7zKh3k7nvGdaRHoNKZd+XkbosyOb+2DhGiY9RF8k68ZXKGQb7gsnqOC2zAYJoEDrVJEXdZHGIv3t/cPBv0M3KZ6Nu2ff0sBCH00onOp+llpLwCEuXZevNlKbnogELQTGh5g3XAePmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820829; c=relaxed/simple;
	bh=2aZJi90JXyrvmkIK5CBaOEyHjcCKQqsSifXJYutTtDA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bmrlba1xvN1lpm81aUCv0sw9hp1lhlMRBH4o34O2Svrljzr5IS0Yjyi/eNuD6XlYEv4K8Q7DxeV/8giyF/UDQwK9P1KaOtOjbsMmq3wS6IwtR0UcfGpvfMCxSJdXSihCMtFOaytPCisZEwf6fMaQW63mkK/JqXWnWoiVOic6bMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85db3356bafso434667439f.3
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 13:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820827; x=1747425627;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCQtphB0FemzCy19IwV6cQERYXbXPlbaTZmPEyFJTGI=;
        b=cBC2n2lvKYId4bv73mvVYn2xXZnSEQU/gF+ld2VeugdCIMTZaihqCQflte3iQI1xAg
         3GNtyaXyb8ORPRrrn9l5Yhwmz1xaS+lgpiuJXdGLgXmCqfQZE6pcFJkFFqJQQsifbLrc
         +/yMq1ff9FShXg4nraNUZg8dMMolOqhe6V1NQcs0g90tWES7oGNg86MZrdyn7mXJCLzz
         TDZ2XnpezDJK4DK/q+vLnlAWdsPD2ENwe2gp0zBW99HgCRKP47lzNSqTEevT3ipBmfvS
         3L3O1dUfhCVbccOLPe6nyDy5gNJx6WU0GjEgW1kKz4PiFvNMnQNGfCmS+eY2RrQ0CIQG
         pQGw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ucfq9diB2i3BhoIY9ATWTLNkPySnWMMKzNbEYQwH94D4YN7qAp4uIRaYCI8OiKb5OvUyaF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJdcPKCaM6R1WM0eLTGL4omSjPF0k8sIT+Rv04L0ALYtPg+yk
	zTz+MiCYdLTLTxzM9S1fwmZxkJkzI4sxSCviwY5ML/3Rryqn2og0aIHVhgMdy2Hh7ms0f7qx6PS
	sqoJpe8RR/dFAk3xmYXCqaSPkQKKT200Al5/SH3r/KNXIEqf6wylNEs4=
X-Google-Smtp-Source: AGHT+IFS1QqSUbqR7M7CBn7/jSPir9EcUhhf7mriUS+G5//b7VHIh2HGn9UpRPzgIvf03d2pRHHD+iUCvyv3SGjcENr4tG5dY9JM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3425:b0:867:d48:342b with SMTP id
 ca18e2360f4ac-867636223a2mr517642539f.11.1746820827029; Fri, 09 May 2025
 13:00:27 -0700 (PDT)
Date: Fri, 09 May 2025 13:00:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681e5edb.050a0220.a19a9.013e.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __ipv6_dev_mc_inc (2)
From: syzbot <syzbot+3735d5f00e991698985a@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02ddfb981de8 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149d2cf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9dc42c34a3f5c357
dashboard link: https://syzkaller.appspot.com/bug?extid=3735d5f00e991698985a
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ca57f5a3f77/disk-02ddfb98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f23cbc11e68/vmlinux-02ddfb98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73e63afac354/bzImage-02ddfb98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3735d5f00e991698985a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __ipv6_dev_mc_inc+0x4f0/0x1640 net/ipv6/mcast.c:966
 __ipv6_dev_mc_inc+0x4f0/0x1640 net/ipv6/mcast.c:966
 ipv6_dev_mc_inc+0x38/0x50 net/ipv6/mcast.c:997
 addrconf_join_solict net/ipv6/addrconf.c:2242 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:4100 [inline]
 addrconf_dad_work+0x401/0x1d10 net/ipv6/addrconf.c:4228
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb97/0x1d90 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:464
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Local variable maddr.i.i created at:
 addrconf_join_solict net/ipv6/addrconf.c:2236 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:4100 [inline]
 addrconf_dad_work+0x244/0x1d10 net/ipv6/addrconf.c:4228
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb97/0x1d90 kernel/workqueue.c:3319

CPU: 1 UID: 0 PID: 3845 Comm: kworker/u8:19 Not tainted 6.15.0-rc3-syzkaller-00094-g02ddfb981de8 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: ipv6_addrconf addrconf_dad_work
=====================================================


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

