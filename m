Return-Path: <netdev+bounces-85942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2C189CF21
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3C428445D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3713719B;
	Tue,  9 Apr 2024 00:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66056382
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620897; cv=none; b=Sofg+7sHRfhFm4eVXuFk/bMB1OqUfuLwVqofk68GeiZKJNpuvuH5dfJ+lqo95TTaYSYIPUlsr8SbwtC3WgfcRI/TZFKfcqVdPzwuOHtFoOMRfy5FgsYE9oaMJ5YaExPaa6f8z8Xk6i51gEe2JWLvDQwEu/VHRdcCCn7Q4NG89UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620897; c=relaxed/simple;
	bh=3voE6CPaxkY+iWi5FLW6Jx+FisQflngU8sSDOJcMLF0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iWwOjq81he6Qs2uG+0H/0TqohKoONKVfhGkOOUNE05eCjA/2EgNGaXOQqyXoHuLzpQuzmDLRLRCfdXjaKBdsEJH/jHsYv9Lsh3DIzfQDsibejE9H8fKWieg07fvHX3R6k2k9BSwBaG5Ri69jUhsJHkz3f+KMMMyLrqc3k69Yc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc74ea9c20so594643539f.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 17:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712620894; x=1713225694;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyYAqFUZdXsMjhaAEjBagjDEFe+wEMpPEHgURXo3AOU=;
        b=N60G9xrIELjEN9RraX0gTsgOwqNJqipSRWtBIjNQeqd5SOP49XyVIAxYPW/sKKoFYY
         3wzBlW4+Y7xTkM/s+XLjlMQgL1gxWAfUi1khA8NCi7dnYofopBBoWdY2g0AyoqQmcjF1
         NDBkRqC2wEcDpaZNztqmTvtKB2yoAw49XRbfGMYNqftnGPJLp9T/OvltNl7kNJoXhiZo
         Xa5OkC//dK89Il+oOdQb5VBPIQdL+xNqenlSYmQe3Z7YwojIaukWRiHcKQ8M4eeOKzNf
         TrubWGAOhp6VWlxQJvB/2t/l0tb3WGKiyfqQRpVN3cmFn6dhiLvlnPChcvr2VRj5t/s3
         QHrA==
X-Forwarded-Encrypted: i=1; AJvYcCV26XgZd8Cs1DRUc/XoPeG+wiSF38GDHXM2NtVn8ybdJHStyqjtrTAnHImkPzoAczf+oVLRl0gjF1IyQN9FuvSKl6yJHtkT
X-Gm-Message-State: AOJu0YzMLZKZJOpw5Fncl95lfug3Xni87Emh106bWAvUVKvNaJr4j5wf
	NEZZxOAEALZ16ky15B2fa8oNJH3+lXSyqcuvNzPE7ahd2uyfBBmRXnJMPWykGpAziEy7pKJjur8
	hcg5EjnsnURV2LR3/KPCntWM1U8sbDwr07JHYJRNxaN0+LW/1jANPPFk=
X-Google-Smtp-Source: AGHT+IGQYzW6ougw4l1ajcrWrIuF2lFcE+k6qVPMRd3DcXGN34DcVGdqKFrXq+QUy3hk/Z/+IJiAsRJueSiCRpc6qdPLu1dqsibA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:369:f750:5bf1 with SMTP id
 k9-20020a056e021a8900b00369f7505bf1mr604446ilv.5.1712620894604; Mon, 08 Apr
 2024 17:01:34 -0700 (PDT)
Date: Mon, 08 Apr 2024 17:01:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ee21406159ea06a@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in sock_map_close
From: syzbot <syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=164811f6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=07a2e4a1a57118ef7355
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600ac05180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150ac5a1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5259 at net/core/sock_map.c:1654 sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1654
Modules linked in:
CPU: 0 PID: 5259 Comm: syz-executor257 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1654
Code: df e8 52 4d 98 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 39 4d 98 f8 4c 8b 23 eb 89 e8 af 05 35 f8 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc90004c5fda8 EFLAGS: 00010293
RAX: ffffffff895feac1 RBX: ffffffff948b2be0 RCX: ffff888023278000
RDX: 0000000000000000 RSI: ffffffff8baac220 RDI: ffffffff8bfec6e0
RBP: 0000000000000000 R08: ffffffff92cc759f R09: 1ffffffff2598eb3
R10: dffffc0000000000 R11: fffffbfff2598eb4 R12: ffffffff895fe820
R13: ffff8880222bc000 R14: ffff8880222bc000 R15: ffffffff895fe850
FS:  0000555569b3e380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007dc22000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unix_release+0x85/0xc0 net/unix/af_unix.c:1048
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x429/0x8a0 fs/file_table.c:423
 __do_sys_close fs/open.c:1557 [inline]
 __se_sys_close fs/open.c:1542 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1542
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f3e539366a0
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d 01 8a 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffc63195558 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f3e539366a0
RDX: 0000000000000010 RSI: 0000000020000f40 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000069b3f610 R09: 0000000069b3f610
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

