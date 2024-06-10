Return-Path: <netdev+bounces-102164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B84901B89
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3671C2113E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD4B1C6AF;
	Mon, 10 Jun 2024 07:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F541BF2A
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003254; cv=none; b=XKBfGRHBoyvR7ney9xGYRsCyX+c4Qm9NXhJFTY1JlLeiGf7lHZabEWJcQQjlDETrqnNyGcvY5rw6qLyDKe63907C6EnaULhufPl7u+2D+bh754jp8E5EYn8EsiY6+1WAt53KVPOdoWkZ2vpJLGysHEbF+7/jnP46a6IPcBwspwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003254; c=relaxed/simple;
	bh=RaHyHSxriqBbzMxLUty0EheUNUvcvMTdWobKqxk4+xE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J0EvK3ajNd0r5ukRcRsDdwyLSl8p7mIRVxspJvlHoVPRGadDJ1hFdDaZbqwqHc1Tv/qngYetqm1ITJdd+LNcseTucF3Fg5dFG3I8XlFe7EfH8TmzQ9E0QpNkTT6kQbqOl2v9DxEiVrhQI2+avwf+6UWkS0EAl+smSsX21Kkivf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3745fb76682so44607325ab.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 00:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718003252; x=1718608052;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOWDa8s7scwwzepO7HM8stjaYWxEuHOf7DjzQ2t/x20=;
        b=qfu6Pfxd1uLqqPmy4uGmVef18hTy/3h9Uc4pKN5ftue3crzZgbKCAS2FczUl1wqS54
         NNlh2apGLbNO45UUjvxD9t/7YMTYaBjfnH1uSkWTtILa17vctJanU8YremHk4MObh9Dh
         qGNYC18/sLU22NmD2jaCiRXgNYVJnt6p5xa0gw3KHGdDSD2OvWDEt6L7MKbPYDdVYMIU
         Zmkwxn2C3krzVQXZ9nIIh+odOC1rosimIURvl97EWXBZsj0ITNhU6S/Bsdp1gf6KN7rt
         E0K90oRD9rAquunM4HbIQzza5k0HCq51Ym4H1jl9vUWpPwICjkARne4yJ5fTN6lr/8+X
         TOqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpSNBwBJAtueBk8Mb63aYUjLGg8dnnPGwjQbzd6NR9DFxtaUKK06Mo+V0XeH3xTciGvUGKiKrdzfnsOA8sJVXvFN4ci4fZ
X-Gm-Message-State: AOJu0YxG4K9FewL17pewTkDkq1VMr8h76d7n4BXgl9vmwqCmn6I6fRpY
	vnOjsd+DjESvd2rXqzplvqvOXWttTqCUB8wmBa3lO4HH/e0u+JVkWnuqpQR0zoz3sGrnrgeMoGT
	X/LWiquoxtOOXQSbvRrn3hMk2gU85q2JZV8rTEl1sQzXq5uAMCHi8zKY=
X-Google-Smtp-Source: AGHT+IE2s84k+Qu3XNTICX1W0U0I076P1nY/KKjv8VFmf3d/qG9B0njUo8HMbxxfLpWDKLhXtSEGe0SLsTxUzC+wpEV7bO4IC+Ox
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:375:a50d:7f2d with SMTP id
 e9e14a558f8ab-375a50d8283mr2045565ab.1.1718003252146; Mon, 10 Jun 2024
 00:07:32 -0700 (PDT)
Date: Mon, 10 Jun 2024 00:07:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009140e4061a83cda3@google.com>
Subject: [syzbot] [net?] WARNING in bond_xdp_get_xmit_slave (2)
From: syzbot <syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com>
To: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com, 
	j.vosburgh@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f8f0de9d58d9 Merge branch 'mlx5-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1638d2ce980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3fd9f91ee48/disk-f8f0de9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f0153e67f84/vmlinux-f8f0de9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6abab02f18cf/bzImage-f8f0de9d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com

bond9: Unknown bonding mode 6 for xdp xmit
------------[ cut here ]------------
WARNING: CPU: 1 PID: 14901 at drivers/net/bonding/bond_main.c:5502 bond_xdp_get_xmit_slave+0x519/0x690 drivers/net/bonding/bond_main.c:5502
Modules linked in:
CPU: 1 PID: 14901 Comm: syz-executor.1 Not tainted 6.10.0-rc1-syzkaller-00179-gf8f0de9d58d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:bond_xdp_get_xmit_slave+0x519/0x690 drivers/net/bonding/bond_main.c:5502
Code: be 69 13 00 00 48 c7 c2 a0 73 54 8c e8 d0 35 1e fb eb 98 e8 69 96 41 fb 4c 89 e7 48 c7 c6 80 94 54 8c 89 da e8 48 50 31 05 90 <0f> 0b 90 eb a6 e8 4d 96 41 fb 48 85 db 74 0a e8 43 96 41 fb e9 72
RSP: 0018:ffffc9000da6f6c8 EFLAGS: 00010246
RAX: 2059da9abcd8c700 RBX: 0000000000000006 RCX: 2059da9abcd8c700
RDX: ffffc9001616c000 RSI: 0000000000002218 RDI: 0000000000002219
RBP: ffff888056026038 R08: ffffffff8176812c R09: fffffbfff1c3998c
R10: dffffc0000000000 R11: fffffbfff1c3998c R12: ffff888057b5c000
R13: ffff888057b5c000 R14: ffff888057b5cca0 R15: dffffc0000000000
FS:  00007f8b32a0a6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30d22000 CR3: 00000000629b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xdp_master_redirect+0x104/0x250 net/core/filter.c:4317
 bpf_prog_run_xdp include/net/xdp.h:518 [inline]
 xdp_test_run_batch net/bpf/test_run.c:313 [inline]
 bpf_test_run_xdp_live+0x15eb/0x1e60 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0x80e/0x11b0 net/bpf/test_run.c:1275
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4291
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b31c7cf69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b32a0a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f8b31db4050 RCX: 00007f8b31c7cf69
RDX: 0000000000000050 RSI: 0000000020000040 RDI: 000000000000000a
RBP: 00007f8b31cda6fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f8b31db4050 R15: 00007fff9cacb078
 </TASK>


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

