Return-Path: <netdev+bounces-234116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B1C1CB9F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B4458402E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6388A3546FF;
	Wed, 29 Oct 2025 18:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0F2F8BC0
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761014; cv=none; b=CI/opdlii6hg8rdd55ESm02HQHGD78kXeYZraTreNnCxVA/riU+bs9ND56tU40QPjarmmBZkKIqxPl8GNYkg/kA3ZtjVOicrZvmIjJsspEnKXTxcxX/WpaxdChRXXz2hLEwghNepeqFutOME2rldWlE3R1X9vDls2ycLuuBExWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761014; c=relaxed/simple;
	bh=syqo7xCuXUYrqut5p8BBEanGYt8ZtnsUm4qRlabrwco=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qge6BbTbbeOaxaEeie0U0FX3PQJsHgyoNl2vitqk4iejQOju9XeImDoZeXk2zHYJHz4XsznWCnHKs7mm+IuXNlWyFYVHOyeURw+KjNyR6jdjJzMZHcbPuCcE5+YoQ/IUip1z5gjlHY4Kd/gTOb54F8S+IoB732mwAadcG5f3Exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43300f41682so1014515ab.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 11:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761011; x=1762365811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jECNCXKfYRDxfdNyvFJKOWdk9c6wb6d7+f4Gyt+JTNQ=;
        b=Tfo1X79YR/pBNE5aQXzYce4einqZAXBZt9+82z8928j54plEK7jsCIaR4MQssGW1vd
         FNjrKYXGAS4HdhrFEcRXh5EfHnG+ORB4NHz+qgkeuVCeRIh0Mi78GG+C7T+GvCcuvXjr
         9+vQipqpeyCoHjSAGzabqDwcXAci5Ll7wZYLp+9aR3bM5Q8BocaHa9Enr6fTqtJ3pjkU
         IeCbuQ+BsWcf/oh3u4afQyN7RnbfbQq1BPCIaJk9ECrXfMKRLqMVAsFNoNGN5SBtlGid
         TJtn8PLTryC0EhW+cEUtgEOgwPVvIjtVUT5InKvcZDOqdkHqrae94NgA1Hk/bEavcEG1
         atCA==
X-Forwarded-Encrypted: i=1; AJvYcCU667Lje2jMQ2sq3JevoCxs0nIMgMoty8lCdd1SP0ZNEWsENyk5GRgZzeBM5Q+bw68yTcKN/hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEDhtsCFWQs90PnG5kiVloKt3cIpoHAZmfxHZsr6x6JiIQGmx
	Mq0sY0F2YrJyCGtR43MH8OliO1ZJrA04zi6imAZm2HmOoMzi4ezB+tEblnN2vRc2P3RdtVuXwUq
	XzIqr7SNco73isoUTa5P0RcvDIZHcCnYbT0nEJnuAd/4vI3yINsF7XyBOmy8=
X-Google-Smtp-Source: AGHT+IGjjScvaZdUlvuzShIZdlgiBoqfNig3J+Ddu9saSgtyIVixyMSUgpMK292LoYOesfx22ZRpn+tuHMuONI7l3xxBdvNCclqy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c04:b0:430:d5b8:6160 with SMTP id
 e9e14a558f8ab-432f907430dmr50783115ab.29.1761761011589; Wed, 29 Oct 2025
 11:03:31 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:03:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690256f3.050a0220.32483.0219.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel NULL pointer dereference
 in pc_clock_settime
From: syzbot <syzbot+a546141ca6d53b90aba3@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b98c94eed4a9 arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11260e14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=a546141ca6d53b90aba3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c82e514449b/disk-b98c94ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a322ed38c368/vmlinux-b98c94ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/059db7d7114e/Image-b98c94ee.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a546141ca6d53b90aba3@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereferenc
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000133ddc000
[0000000000000000] pgd=0800000105883403, p4d=0800000105883403, pud=0800000127709403, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 7008 Comm: syz.4.69 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400805 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=-c)
pc : 0x0
lr : ptp_clock_settime+0x148/0x264 drivers/ptp/ptp_clock.c:107
sp : ffff8000a2957c40
x29: ffff8000a2957c40 x28: ffff0000cbad5c40 x27: 00000000fffffffb
x26: 1fffe0001975ab88 x25: 000000003b9aca00 x24: dfff800000000000
x23: 00000001ed5d7404 x22: 0000000000989680 x21: 0000000000000000
x20: ffff0000cca30600 x19: ffff8000a2957d00 x18: 00000000ffffffff
x17: ffff800093305000 x16: ffff800082de95c8 x15: 0000000000000001
x14: 1ffff0001452af70 x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001452af71 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000000 x7 : ffff8000877add70 x6 : 0000000000000000
x5 : ffff800093586d90 x4 : 0000000000000002 x3 : ffff80008adffef8
x2 : 0000000000000001 x1 : ffff8000a2957d00 x0 : ffff0000cca30600
Call trace:
 0x0 (P)
 pc_clock_settime+0x224/0x298 kernel/time/posix-clock.c:304
 __do_sys_clock_settime kernel/time/posix-timers.c:1131 [inline]
 __se_sys_clock_settime kernel/time/posix-timers.c:1115 [inline]
 __arm64_sys_clock_settime+0x208/0x254 kernel/time/posix-timers.c:1115
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

