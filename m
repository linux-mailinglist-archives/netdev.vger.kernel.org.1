Return-Path: <netdev+bounces-218288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636F9B3BC77
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B52A188B7CF
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3993631A07F;
	Fri, 29 Aug 2025 13:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E572EE26D
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473753; cv=none; b=p+jdGpW+mfJyQRJVM4XdQ6iA9Jr+B5qi1YIywB0t4sCmJr3M3XHyxH3VmN19G6PjDGzmaTmthjNN1ykaUFvjtAV39fqO+55NJ5eMyCcRT6wCJuxeSgn0Pr4xyfOJA2pIS6MN4MWSLVvlQCNIwlGqvO1qJe2sFF+EM0Or3oJPerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473753; c=relaxed/simple;
	bh=dF8o7y6dl4+JnyO9dE1Udt1otgaXHZOQv0HSPVpJmEw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YXSMGM4P7ciWqwfq0tY7lLKE6WGvtTF5IxhIw2yVovqEbvHa7jODvaNBWBCC2uGAtA46PXjmUR46ha8JrsdRnYhQW1HlDT4HiD1S0lFBmGElcfHEUwuCjkRvYFih2irNj0CoQRXf5hy3pBoN+XDob+vlj8uPIn0b7+8yw0MkKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8870314a3afso193249539f.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 06:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756473750; x=1757078550;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDAZdlJt3qT79STyvS1hlaICocSeAh5xbgbdDljA5ks=;
        b=IWHSZTTMO5OA2DEAaMPfikXHhrHQQIH2EsDjLGSXrxsXmiUdTDS38TKTfXB2bdyjwo
         0LAnZKkwgV99trQUIxvFxgIuG9S5+4RiUlZve7A6xqfghFgxhtPIf7xwI9J+1b9uwsF1
         a+LxEU25wuSUeScK7nZhZJKmNdrakufRAVKmjR8Hbq1xw5sc3T+EcY4InE35fp3NaUzn
         xvqnL3T8Xgh/jcNzKU9QrivVJInzdD1JFOTyogIYwmrTuLVDtntuAmIr+JhtCtHg84j5
         R/+BhaEggzEcJgotU+8+TWLWN9ZGnlKVLSV3gMHYnCGFPPlIP3UO93D8hCRDC+MY6vGR
         GQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhK0UWYamKfnY973RSIIXiRsUnA/AmHj9bTghx6uWKaIgkxwg5qLMj4+PlCRGZk8rwjpVRnf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDg0k26MenEl76Y5MPPf2P0FjuMgNe44lGrzPIbKVNAmpMJ5E
	22S30cqm8ZZDhgO20OnYIIzFNAnk4xi7wBy0uWWBRqPk6Ia/YLqOb9Npx6X84e/xXSTHYHlREc2
	ejh8llO3Fp9FqZeZFDUOy130zDXSpAmyPgHE46fNEFtnRzsPReIrzTSPzcjI=
X-Google-Smtp-Source: AGHT+IHqmTnM8uXeRk/Ah/oFyiW5/RhN5JM4sYIaIubGwHhZSFgk0akvubyrQZiCzZawkWAUt58OpVXHNswCj/gG12fjE8jp8Qy5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0f:b0:3eb:8e5a:8fd7 with SMTP id
 e9e14a558f8ab-3eb8e5a9145mr297977055ab.11.1756473750663; Fri, 29 Aug 2025
 06:22:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 06:22:30 -0700
In-Reply-To: <68adf6fa.a70a0220.3cafd4.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b1a996.a70a0220.f8cc2.00ee.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in est_timer
From: syzbot <syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d67262580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=72db9ee39db57c3fecc5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1141c262580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f69262580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cdf0bbb7922b/disk-07d9df80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1975bf771ed/vmlinux-07d9df80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/942416e1bedd/bzImage-07d9df80.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16 at ./include/linux/seqlock.h:221 __seqprop_assert include/linux/seqlock.h:221 [inline]
WARNING: CPU: 0 PID: 16 at ./include/linux/seqlock.h:221 est_timer+0x6dc/0x9f0 net/core/gen_estimator.c:93
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__seqprop_assert include/linux/seqlock.h:221 [inline]
RIP: 0010:est_timer+0x6dc/0x9f0 net/core/gen_estimator.c:93
Code: ff c7 42 80 3c 23 00 74 08 4c 89 f7 e8 7d 35 41 f9 4d 89 3e 42 80 3c 23 00 0f 85 54 ff ff ff e9 57 ff ff ff e8 95 fd e1 f8 90 <0f> 0b 90 e9 63 fd ff ff 44 89 e1 80 e1 07 38 c1 0f 8c 65 fa ff ff
RSP: 0018:ffffc900001577a0 EFLAGS: 00010246
RAX: ffffffff88dc5ebb RBX: 0000000000000001 RCX: ffff88801ae85940
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: ffffc900001578b0 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: fffff5200002af0a R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888027ab4e68
FS:  0000000000000000(0000) GS:ffff8881268c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000005840 CR3: 000000003732e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

