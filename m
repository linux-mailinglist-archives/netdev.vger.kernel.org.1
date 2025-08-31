Return-Path: <netdev+bounces-218542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08BB3D16E
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 10:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B12A7A896A
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772D2451F0;
	Sun, 31 Aug 2025 08:44:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9821B9C1
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756629847; cv=none; b=KI6T36BfM6l37KWW45ot7Wx4pAzIleC3pa89ozUy98u+FSw+u7ahD3H7oRGw17Bz1zxHc6HX8mA3qjChl0nJ3BYzbcZFAsxB9xila7tqs1bUOCI1FTRM48gBfCsgyJ4QAdIjKv4Ix+2RXOXQPZQSoKaVsu5X9YY7CGaU06OeEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756629847; c=relaxed/simple;
	bh=8SIaP6jgAU1GRrIwVhqhSLqz06aDypvcPsEdLhs2AdA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=geRqacW9eILXnJwYvpqVdZtWpW68Ur09sMC3fTuDbD+Mk3I9h3vVmdOPeXnSF8kD5djQOilJUWlgLEQLhqyTy47TerARgiOfQ7J0j6BnWepoeGMnqh5JAoR49Paa4eM4JbTD+K4mS5RIMEVjp/R5jHh/q7tchcbtixEE4KjRNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88714e1fd48so226571539f.0
        for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 01:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756629845; x=1757234645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+vIXQl+vKZNuMf8TrWAiZ/L8nDzp53gg9EKRtUQLAw=;
        b=TEJzeu8BtqI4NZun8LT1k975hfFBhVVGGewgJNiWkcJWBmz2U961nFQXDME1FyR43R
         KlbezXcYsdO9sGkiUjc84E8vySwiArTS7nrAbiFgTxwrRe8Suie/fkbki9/VjGeWfTX0
         umxg89FdXAEk9RFg8L1MJ9vpT49QTTKwgyAMKO38w3ylu/X9aR+txsH0BPvPhilcQ1w3
         koTHlQ5lxWHIxyYnv+fQdPhnxXeeEo8Axn+l+9lWhRSxI7VXuxcgS0nVf15C4lAcc9va
         2rj6ZapHivU38NY89MTo6Li4i3OVhBTe4GFiBUrmxLWz91JltcJN94FXAZe0K+M+NIfL
         fwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfTbT1riY5j3Srti4nyiDBRuoZcu3E9BdDfDHi4CQjG1m8m1BlL4MURV9vP5vnmRwu5HlkOSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUYDzuIweac1HBhuwDXflImU0MdEeEX5Dy2PAuxg/ZULD4uH7
	yzVUcIf798DvRwTPL2ETB/PH5UGX7+smpn8PnhUT8+Vgp4Rx1FSWeLjLNEj3bY8RsmlOR8UCVB1
	ofMjZZ9eaNnca65n+9Tea/FiIZIOtaJQLdPHrUwrDS7ad7xkDsPPNN6KCp/k=
X-Google-Smtp-Source: AGHT+IHY/SH7NKEUgcBCjXFl6fIg01ixAxiBt9+LRncmvgqCYjMWnR/RjCnDoTemO/Lg78FXYavCXSlDTvYQgaBlF6oNyAy8HHLa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:3f3:dd9a:63da with SMTP id
 e9e14a558f8ab-3f3fd18b31dmr100586795ab.0.1756629845056; Sun, 31 Aug 2025
 01:44:05 -0700 (PDT)
Date: Sun, 31 Aug 2025 01:44:05 -0700
In-Reply-To: <20250831081933.6215-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b40b55.a70a0220.1c57d1.030a.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] WARNING in nfc_rfkill_set_block
From: syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
To: hdanton@sina.com, krzk@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ysk@kzalloc.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in call_timer_fn

------------[ cut here ]------------
workqueue: cannot queue hci_cmd_timeout on wq hci0
WARNING: CPU: 1 PID: 29 at kernel/workqueue.c:2256 __queue_work+0x2e5/0x1010 kernel/workqueue.c:2254
Modules linked in:
CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__queue_work+0x2e5/0x1010 kernel/workqueue.c:2254
Code: 42 80 3c 28 00 74 08 48 89 ef e8 16 a1 93 00 48 8b 75 00 49 81 c6 68 01 00 00 48 c7 c7 60 ed 09 8b 4c 89 f2 e8 ac 3c f9 ff 90 <0f> 0b 90 90 e9 f2 fe ff ff e8 0d 6a 34 00 eb 2e e8 06 6a 34 00 e9
RSP: 0018:ffffc90000a3f828 EFLAGS: 00010046
RAX: d228e4afda57de00 RBX: 0000000000000000 RCX: ffff88801ca99dc0
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: ffff888028754998 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: ffffed1017124863 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88803d644168 R15: ffff88801ca9a8cc
FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31e63fff CR3: 00000000281de000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1793 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x709/0x970 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         c8bc81a5 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ccc1f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17122242580000


