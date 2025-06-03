Return-Path: <netdev+bounces-194760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1EEACC501
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9087F16DB84
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7915722F765;
	Tue,  3 Jun 2025 11:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7622D9ED
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948969; cv=none; b=fa5RApOTvJWnbT1mE7VJ/uPvk0JUkgBEMFEqX1Nk1JJrLBqfP3oxh4bwZVYn7lvJLIHlSw3OYnxAi3in9J2chJy/kwNg2/at3U05EBW4k/Rb7OkMD5ICMK+h0GqvdobywUELr0ZQNmp6IRffmShcZ67KYHdVDBQKrWP0JU3WDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948969; c=relaxed/simple;
	bh=Rv2DcUOMh/OOq0NVXmg5y9WTm4mKlajuz38i0rSffE4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sGAI+FgwANaHeabN0uuvfAJ7aeTs7hzcshWWr/RSB6LBZfaz2I7C2nTd0pGjP5+B/YMnowbzGoig9u00RhJLW6OCl7L3383DlyzG4AttbZhfSwk3bRr+TYRWKHtKiz+MG+BgCrjLBoogD+YVSbPlB58gDT/gxK/uX9kW4A/76Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddb4dcebfaso23470805ab.1
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948966; x=1749553766;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVsBRpkTaXZOT7rXqN2VUsYsfXJ42a/7qddm1oG+iXw=;
        b=RrON/DNlaTvKbl0y0KKQ3UhiI3eQo3K3LPhXk/lv1h0TQNz0CB7tUEBZbAbr0kaOCF
         4xO/Ml3nRIiHWmq+PyqrhGvFiWBMP99JqAJ5E1RqICf6ejWiF7IJN5FzRfTE9Ex99Mg6
         E6g64QdIet/7YHiE8XcE3FEAupcdZtSptbTq6UcdlUJeH6vYTJMiRpcZhOi9/dotO0Je
         RrV08slxbfYwHvTWjKezV5s4i0WmbJj+UdaQgbULiPmqLHrb3gBE2bSy8SuGz30PO4Eg
         w3sOEw7Bogs21FeV9H9GHdlTbZ4cpAG2oS8bhMaWJ4HZxQKhJy6cqerScGgTLk7gxw4c
         Tevg==
X-Forwarded-Encrypted: i=1; AJvYcCXI1jJFs0S7kXMWrv7Iokzj2RM0OpuiNNNeQJZld/10vGEDuKUCTmaWeG1eV3EVIHQEwMGAKSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+jFoh1zLaa4Tv4VIEH2K93wuKmQBNVwLwKqcTbTrMLFZP8SM
	eLc6+hjVr56ouQ9CxkdaXTiGx7T3dfRRyLxpxcG8RbPapB7+QoPifskwvCowwKcvpPVHHm1/Scj
	yNUBOrlynOIgNPJQuOdAFsBwn0WZB3I8kiGaMu4BGR7KElQ3pWSxO6vpOj90=
X-Google-Smtp-Source: AGHT+IEZXF8AqLcPv4hVkFQswPo5IFmFr6IjI+BQejdBksxHfu30XQhfu0DwpOvsBT7R4yIz48AR8Tl2EwYVeCv1BnKReyVMZ+mQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1606:b0:3dc:79e5:e696 with SMTP id
 e9e14a558f8ab-3dd99bf6d82mr169835725ab.11.1748948966663; Tue, 03 Jun 2025
 04:09:26 -0700 (PDT)
Date: Tue, 03 Jun 2025 04:09:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ed7e6.a00a0220.d8eae.006a.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in sk_skb_reason_drop (2)
From: syzbot <syzbot+43060000c399ac5661c1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feacb1774bd5 Merge tag 'sched_ext-for-6.16' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138bfbf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fab6c0cdf4e7c7d8
dashboard link: https://syzkaller.appspot.com/bug?extid=43060000c399ac5661c1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/13170f121f0c/disk-feacb177.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c38ba3fb72d/vmlinux-feacb177.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4109204e310f/bzImage-feacb177.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43060000c399ac5661c1@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 6377 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 6377 Comm: kworker/u8:14 Not tainted 6.15.0-syzkaller-03589-gfeacb1774bd5 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 08 b5 e6 fc 84 db 0f 85 66 ff ff ff e8 1b ba e6 fc c6 05 3c 2f 9a 0b 01 90 48 c7 c7 e0 ab f4 8b e8 97 ed a5 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 f8 b9 e6 fc 0f b6 1d 17 2f 9a 0b 31
RSP: 0018:ffffc90003e8f798 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817aa8e8
RDX: ffff888026190000 RSI: ffffffff817aa8f5 RDI: 0000000000000001
RBP: ffffe8ffffc5f3ee R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000000 R14: ffffe8ffffc5f3ee R15: ffffe8ffffc5f30a
FS:  0000000000000000(0000) GS:ffff888124aa5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b6de1ed58 CR3: 0000000030c1b000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 skb_unref include/linux/skbuff.h:1249 [inline]
 __sk_skb_reason_drop net/core/skbuff.c:1185 [inline]
 sk_skb_reason_drop+0x183/0x1a0 net/core/skbuff.c:1213
 kfree_skb_reason include/linux/skbuff.h:1279 [inline]
 kfree_skb include/linux/skbuff.h:1288 [inline]
 gro_cleanup+0x8c/0x330 net/core/gro.c:815
 __netif_napi_del_locked+0x2f5/0x490 net/core/dev.c:7301
 __netif_napi_del include/linux/netdevice.h:2876 [inline]
 gro_cells_destroy net/core/gro_cells.c:117 [inline]
 gro_cells_destroy+0x132/0x540 net/core/gro_cells.c:106
 unregister_netdevice_many_notify+0x1821/0x26f0 net/core/dev.c:11994
 unregister_netdevice_many net/core/dev.c:12036 [inline]
 default_device_exit_batch+0x853/0xaf0 net/core/dev.c:12530
 ops_exit_list+0x12b/0x180 net/core/net_namespace.c:177
 cleanup_net+0x5c1/0xb30 net/core/net_namespace.c:654
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

