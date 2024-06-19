Return-Path: <netdev+bounces-104686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0E90E07C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7B61F2285A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F5628;
	Wed, 19 Jun 2024 00:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C51196
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755882; cv=none; b=ElNzRiafTIMXyaYz4oiz/pdct5SqDGY8Et4SlKn5QEqQytU16UL8lr2EZDbQhLDAFumuOdgKjdAEepfKqXnmsVsxh+8wXgAlCYBoyMurSEzZj2bxkAVAFjSMXKFUXGxUrj4PYDTZvojCGZnfLBeH/hlVwYZOuwL1Ol3Llbxpg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755882; c=relaxed/simple;
	bh=zUk4PJQj040+altTZQi2P9xGOdiRD/LpLPND1/EIfQE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Se6NnpUNZj6zItNrEteKht5fwFpL7G1N0mihSPNIih4NPWsKqmweml1TZbHnQ3YCy/fH0vCFe1gul+/oYSXSt0BqNtQ3U5NglY5Nszkb1hTlaS9Cmig4SMErDTAAGQWL5vCyiPjIJ3PmPWDBXjQ7oRkbTFaGCwgvc72rYrGDziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so806999339f.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 17:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718755880; x=1719360680;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXevxKNM8dWqLihLY7avM1/no8pefWJwTC3rupvj+TI=;
        b=HCEELChEl1Dv+TACNaV20HkbAxxNFhtnqYuUpnJ559Apvp1p+J45aMhYUcnYa9wQ61
         PgpiuqplRHgESHYuvdUvp++b3o6Y9ubhdnej/hrh4Qg9MUsK9alfCYRSRfkiDmAsWRHF
         qBBrN7l/xrAZrq0wU76T4oo+dYBO9GDC6pIE9NujeqVUZjdPJe2OtFs+rIQ2Sg2Rwjy6
         t/w0aOCvjTWI4rdRrWgb5LUaFaEZrTJp2YsX35+PE+IwAZAd010ZxvRtwH9QMIM0L6Ws
         /CW+tc0R83ASWuOuNxh+JdH+gf1h3lavF6s/rgg3VzmAi5OsHtad0PEaHhmhHLzebzGW
         EBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7tNKqS6JkXlx4ZEKSzHVVZ5W3bV1saE/STk35piqbBR606m5jkBS3eTmTR7ysnAYKunZojyb8WS1hdevPWYukMZeyRG2R
X-Gm-Message-State: AOJu0YzyCuOkO+rfVhKdsEDBvxrNaqxOARkHdCQLuAbDCGEgZ99ojpGs
	2RZeE1UKNrOrBZT1YmjaytpmSawIih6qXcg0aZPQBGkvgV6Ik1OgHs3je+pElonPZlcIfIPrL+F
	0rTp4OTlJ65SWxLeuVAd8Cipr4MS8zdMSm8FEGjF1igegq1JVUi2IK4s=
X-Google-Smtp-Source: AGHT+IFHaOVDQCA7cLz/diVjEC310AujbXQfgMqkJKgZXogK4WkdNQ3r+IwuHk/Nn//3yAdo/EWp8nQiCEwifxVbQ02O5y7z2sMT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:890c:b0:4b9:ad20:521d with SMTP id
 8926c6da1cb9f-4b9ad205468mr30266173.1.1718755880145; Tue, 18 Jun 2024
 17:11:20 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:11:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b123a6061b33099c@google.com>
Subject: [syzbot] [netfilter?] net-next test error: WARNING: suspicious RCU
 usage in corrupted
From: syzbot <syzbot+6c048081aec46ad4ddf5@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4314175af496 Merge branch 'net-smc-IPPROTO_SMC'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f4852e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7266aeba025a54a4
dashboard link: https://syzkaller.appspot.com/bug?extid=6c048081aec46ad4ddf5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/48b3722e2009/disk-4314175a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2297abec79e7/vmlinux-4314175a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e99b4419b68/bzImage-4314175a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c048081aec46ad4ddf5@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.10.0-rc3-syzkaller-00696-g4314175af496 #0 Not tainted
-----------------------------
net/netfilter/ipset/ip_set_core.c:1200 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:3/51:
 #0: ffff888015edd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015edd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90000bb7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90000bb7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5db650 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594

stack backtrace:
CPU: 0 PID: 51 Comm


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

