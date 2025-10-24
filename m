Return-Path: <netdev+bounces-232720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FCC08392
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 00:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A754E2329
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019129B79B;
	Fri, 24 Oct 2025 22:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD1246781
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343292; cv=none; b=LIbNUMPrbFoRgGegtjcZlxBzooS1I6RpfWtE5iKdqZtWLvGjxei8323xKDoKIDCbU+NVayzAqv18/CtBTVXcM6GDquekQaGBtHFhv/1eNtWOMF6Aa/YgeaCeRMRoYHjMTqlY01NWCGNsPU8wDxsTybTi4upkHhN2r2VR9NbMJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343292; c=relaxed/simple;
	bh=1+RxdBhXqCRYxIEiRu8Nj+l7pDdIZ9+V2r2q8ywYKdw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fOXZjEw3LqIAhz65XeQssKCddb1euDffqoNr3kkOdvgNWpW42PiUcHfC1CHO/o7nOH16qxr7c9xjxUswZnbof1X3ST2uhHpZXQnaVKSzC7IR8WVVz8ThzdHRV7y8HX1lkd3w03eqo0a8bZw/CFzLP0bJTUSuSswrb0rIyNVquEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430bee303f7so79934575ab.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761343290; x=1761948090;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUCgFKQ1deCUxSkq6GncvFXwTaWjl9UIO9Kgvm6UiOc=;
        b=uXeXb8XuxMZevViZSNkCFfOWVkIznqGuiVgSQTLxYl/+VsYwft7jXJZ3O/1crn+VjK
         7nHjdHfO3JFJ830DCmTqxnzqHVMOK/6+xamYEAe9Mkd4E5jTpk/0HqXDUX91YoXxU9sx
         yueeq6qBQ3qb+uXnmyifGsgEnqtBLBBjGSX5Sv77XuSAAL7rJEDld+GgDrtUH/GnXtMS
         nztlt5E+HdTlAkQvjIEM/OyBsAFqNJxVtTnVFz0nVgfKNA/mzqnvHwPaL/nVrCC5hSRy
         aJivy9FAWkPUSDD3j3Wh36DZHfgEc7c2REKX/FAlHC7kHsJuQM7jZTBoVUlI0sFl+d+j
         HOIw==
X-Forwarded-Encrypted: i=1; AJvYcCWHoEqFJZYxzBFfE+T804Rl1qaqo8RZAlQtkRrAeBTGYi7bAO3rdMpXgBPCqtlLTzoKoHzjtxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEutzOnnQMpesFDYX+a+Q5/RQwkRzSz6UjwU3ZV3pYETciSsc7
	1x4U7JyeUdbAF/YJVgpf+w66eff/1ppvAmYLhzpL/u86MyxuK0J7Qdzj+bY9zWFvmYT8j1VVJlo
	v/YGUqwRkfSxeoRLS33VgS6eaVUKL17jBCopFtHmZJtqgUkYiLL+qt+PNlXg=
X-Google-Smtp-Source: AGHT+IEfCFHWwryFgS+JMTQ6+X4H+mgo+SItZPEyAkRlE+PlHkPotFDZEaLijKcgbHrFyNNEIm43V7bQmqByTeLF0ChU8hm9n2Sw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d93:b0:430:bf60:6b01 with SMTP id
 e9e14a558f8ab-430c5268fccmr399575195ab.19.1761343289569; Fri, 24 Oct 2025
 15:01:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:01:29 -0700
In-Reply-To: <68ec1f21.050a0220.ac43.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbf739.a70a0220.3bf6c6.01a9.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8ce93aabbf75 bpf: Conditionally include dynptr copy kfuncs
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=126853e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14218be2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17104258580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a42c2608bb7/disk-8ce93aab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/84ea41a9a1bb/vmlinux-8ce93aab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/94fb843154da/bzImage-8ce93aab.xz

The issue was bisected to:

commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Fri Jul 4 14:54:33 2025 +0000

    xfrm: delete x->tunnel as we delete x

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b49734580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b49734580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b49734580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
Fixes: b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 36 at net/xfrm/xfrm_state.c:3306 xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3306
Modules linked in:
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: netns cleanup_net
RIP: 0010:xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3306
Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 bb ca 3a f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 09 b8 1a f8 e8 84 15 d5 f7 90 <0f> 0b 90 e9 fd fd ff ff e8 76 15 d5 f7 90 0f 0b 90 e9 60 fe ff ff
RSP: 0018:ffffc90000ac7878 EFLAGS: 00010293
RAX: ffffffff89eaee7c RBX: ffff888027f82480 RCX: ffff888143ab9e40
RDX: 0000000000000000 RSI: ffffffff8d70bc9a RDI: ffffffff8bbf0460
RBP: ffffc90000ac7990 R08: ffffffff8f7cd477 R09: 1ffffffff1ef9a8e
R10: dffffc0000000000 R11: fffffbfff1ef9a8f R12: ffffffff8f3c6100
R13: 1ffff92000158f3c R14: ffff888027f83940 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88812613e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa946164f98 CR3: 0000000030606000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4354
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:252
 cleanup_net+0x4d8/0x820 net/core/net_namespace.c:695
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

