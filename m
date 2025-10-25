Return-Path: <netdev+bounces-232945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC55C0A0F2
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 01:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E0DA4E2C7C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 23:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A32D8393;
	Sat, 25 Oct 2025 23:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB412D6E58
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761433822; cv=none; b=QLo0D7L8NVxMBthrkF3CbwDqAL4AXBHE64RiRIRfKp98uDAZgPUsu2jtim166Xbp+mN4mKdgjEYndQuqxwkc1iaKZ9u7MBdcvH/JsFoTFivjtuaQ48uN04zhjEiE0ZsBz5vnfzN560q/fu/IGRHXdrX9k7QlX/aEYib6A0JUrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761433822; c=relaxed/simple;
	bh=HgP0JxQhguFuQse3i7FxTXubdqwzrgViL6HPeixiCpw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I2o+UPhr0JUzzdzED/JjZN7YhGBZHvZEJ81mtj/FwPHMh31kJ8EnFLY6jxfluD5Ca5D8/Ko6V+eCKS5d5TDWxjWG+jKL34UPkg2sCdBXKNyrCHQQLRdkiGry1Lansr3tcALdLfXzV1PvJPnlX94FLzXxhtJ1IiT1hipmunyTRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so365228539f.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 16:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761433819; x=1762038619;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGp8qhqndkykSdYuj4OJK+N2vs9KHeMNRBnchdAt6ww=;
        b=bB9kcL5Jz8qUvPtWFoh1CFPmUTVYNKCYueWw1TScaU+LNYD3OJZ/7qgHI1IZ83evkw
         /26hLMq343pLdVxrYiSY0ZfHIxVd+C7PG+ZyFoMH9Bbs0Iw7+8CaIpwkCqBPnNxLRaAB
         WgYTvKOBuQ44MlCcsYO/WLi9tbljpBsUe3dxXCOnt+sxKSIG0qWhJUZNOwBPJDiOLXz5
         QqejWYF8CAaZHOc6PDBOA7DfG63kVJjj8nc98WwUOnAq5xY0GpO66WuTYZEVvnCOQKBi
         a5olDfIzYlAWfUuE24ZXVvBFGhanXx+/xwPxnFUZiZ4rHbFIxlz/bP/juCM4swiyxX3W
         R8zg==
X-Forwarded-Encrypted: i=1; AJvYcCUfb5BijPLn0glim2ZEDeOyF0l0Ct5N/oT9bO4HNQS1KzeRLQMpXzkP74Qd+TjDD0DYfOTRdVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGL0ct4UUWEBM+xfNmrhU43GdeQNEV2tdTtEB0ygMjWi/jpzSS
	Iq/JBDLBsK3QDkUcz9ThepzVsbm8fJgCSqilMfFSwzbhXZEW3q/E9yoWG1pfLqy0ulkXZUoSvC+
	dHzGGKNEwnrSPq8TYCpPvcuU+wlq0AUoLxp4AE2HVyf9LEWlMq8iJpuBkXxY=
X-Google-Smtp-Source: AGHT+IH1oSFHZ9iz19tyAUfvgSs1fiLqpb0XJcqyhxQwT+/QY6HVV+80+m77yoqKrsg8KVY1AJp4S8CaRyLGwkDj/xKZDmjVaYox
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc5:b0:430:b6a3:53ae with SMTP id
 e9e14a558f8ab-430c5307332mr467556875ab.30.1761433819519; Sat, 25 Oct 2025
 16:10:19 -0700 (PDT)
Date: Sat, 25 Oct 2025 16:10:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fd58db.050a0220.32483.0009.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel NULL pointer dereference
 in pc_clock_gettime
From: syzbot <syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b98c94eed4a9 arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1337c258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=c8c0e7ccabd456541612
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c82e514449b/disk-b98c94ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a322ed38c368/vmlinux-b98c94ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/059db7d7114e/Image-b98c94ee.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 128
EXT4-fs (loop5): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 r/w without journal. Quota mode: none.
Unable to handle kernel NULL pointer dereference at virtual 
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001274b4000
[0000000000000000] pgd=0800000119171403, p4d=0800000119171403, pud=080000010c419403, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 9258 Comm: syz.5.429 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400805 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=-c)
pc : 0x0
lr : ptp_clock_gettime+0xa4/0xb8 drivers/ptp/ptp_clock.c:118
sp : ffff80009c077c70
x29: ffff80009c077c70 x28: ffff0000fabb8000 x27: fffffffffffffffb
x26: 1fffe0001f577000 x25: ffff80008aedca60 x24: ffff80009c077ce0
x23: dfff800000000000 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000cc206400 x19: ffff80009c077d00 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800082de95c8 x15: 0000000000000001
x14: 1fffe0001996ac19 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000080000 x10: 00000000000000eb x9 : ffff8000a5059000
x8 : 0000000000000000 x7 : ffff800080653180 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008ae046c4
x2 : 0000000000000001 x1 : ffff80009c077d00 x0 : ffff0000cc206400
Call trace:
 0x0 (P)
 pc_clock_gettime+0x148/0x1a8 kernel/time/posix-clock.c:258
 __do_sys_clock_gettime kernel/time/posix-timers.c:1144 [inline]
 __se_sys_clock_gettime kernel/time/posix-timers.c:1134 [inline]
 __arm64_sys_clock_gettime+0x1b4/0x248 kernel/time/posix-timers.c:1134
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x1e0/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
---[ end trace 0000000000000000 ]---


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

