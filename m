Return-Path: <netdev+bounces-202603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BC4AEE555
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF22189F18D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2DB293B53;
	Mon, 30 Jun 2025 17:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C859D292B42
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303263; cv=none; b=THaTaOONmdQoqUZ0/AbgxU8Gco9yCdfSQOzBxWlHY6is2FbZBfJLAgCz45dL70zFgDpTXor/4Hjgzyb0AISHd+DWPKJZKSChc5jWNIWxd/NEFx09XnqgdXi4uoN5p9vKdoVtaKsXzUFZdPrhsJLpNHNnowLxvN8cclmstxNSos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303263; c=relaxed/simple;
	bh=c3JLAcs7m9aTtuXVUB+C3D0BVbgAzHP8C3+vbqYZodk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RfEy/vmcoOz+Chmgk5Mn+vuBtaHWuSCYVq26a3+0I0a0gI0lDGtp+I6B6iK3f064177gcYtBajcnU4Rvfc2nYolyBs63qtiY2ZicKtszvxnSvDGNoNMQfHJUZ1a6PyaN7zLZ3k/2IwgVTH/R0kGliBa/wYPM1u6LCXGGzR93+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3df393bf5f2so25288765ab.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303261; x=1751908061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eVH34/JyElyGCncpABHXHf6kfIN2WmIJvCTUgA3HEQ=;
        b=HVQc5DnTm/CzfhIfyNOrx0my3HP5BnnSMCtlf3QVS9q19eWwKshOafTG00ywmZ158T
         pSio6vjsooftelvHIhYUreUstFkx2qEds0dePgQUuoYWJbWqb0unpJDoQLHWi2zHaN8l
         bVsDeM0ScyNs/VR3Y3jdsZ95OtysN1pSFBHOIAHIRnJqLrW6qG/T2FR6emCWH/UOOLEz
         ct8maK/+0wUK0RX+rRoP3NK7Vn1CVk2i6Oet3z4AWdV8yQF6cjClEj+aBZ35RZrb3b42
         J5Uull1wndYjgK7DNvaFqDB0mkOr+b37ThNJQ6BQobH1XvfD+3PBL5Z3NV1pL0XmQpt+
         L42g==
X-Forwarded-Encrypted: i=1; AJvYcCUNLgyhtWjkTrlxHbyBFJSczVVfAqVE45HwYMagMW9KmsIKeBBiEmexwJS3xiG6MKN/dVWVdgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzY+1hZ5oh7bbXO4j47Ylrg4lIqMz4FYWssZTqMlOaQBNL3D+
	lATac3ZBvJZiTxMn52Bv42EJNeU1A+hsUb+zLez1NShWgz2in2unmousDRxCIqbH89xvsvoLtsy
	hAd2BZQ5My9AzYv+edFjlEQQ6nEXpshx+nzO/yAANBO3qUtwKFbXNq4Qtx4k=
X-Google-Smtp-Source: AGHT+IFnc7V73z7h/yTZD0NLdobDmnUYkaIBhp0J7a3EbG/eiKtDvFtwI3av4DgI57JfmgOGsh/VTEJ+bL5aJvfAIgeVVThTd/4T
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3df:3ab2:cc7c with SMTP id
 e9e14a558f8ab-3df4abae83emr151790175ab.13.1751303260942; Mon, 30 Jun 2025
 10:07:40 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:07:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6862c45c.a70a0220.3b7e22.10aa.GAE@google.com>
Subject: [syzbot] [batman?] KMSAN: uninit-value in batadv_mcast_mla_update
From: syzbot <syzbot+1daa6a8aecb922ad3c30@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee88bddf7f2f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b1db70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595d344ff0b23ac5
dashboard link: https://syzkaller.appspot.com/bug?extid=1daa6a8aecb922ad3c30
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/405f6113ec86/disk-ee88bddf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57f4fa239393/vmlinux-ee88bddf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32892fe29e1c/bzImage-ee88bddf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1daa6a8aecb922ad3c30@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in batadv_mcast_mla_is_duplicate net/batman-adv/multicast.c:347 [inline]
BUG: KMSAN: uninit-value in batadv_mcast_mla_tt_retract net/batman-adv/multicast.c:692 [inline]
BUG: KMSAN: uninit-value in __batadv_mcast_mla_update net/batman-adv/multicast.c:920 [inline]
BUG: KMSAN: uninit-value in batadv_mcast_mla_update+0x35f4/0x4f80 net/batman-adv/multicast.c:948
 batadv_mcast_mla_is_duplicate net/batman-adv/multicast.c:347 [inline]
 batadv_mcast_mla_tt_retract net/batman-adv/multicast.c:692 [inline]
 __batadv_mcast_mla_update net/batman-adv/multicast.c:920 [inline]
 batadv_mcast_mla_update+0x35f4/0x4f80 net/batman-adv/multicast.c:948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3321
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3402
 kthread+0xd5c/0xf00 kernel/kthread.c:464
 ret_from_fork+0x1e3/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __kmalloc_cache_noprof+0x7f7/0xed0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 batadv_mcast_mla_meshif_get_ipv6 net/batman-adv/multicast.c:477 [inline]
 batadv_mcast_mla_meshif_get net/batman-adv/multicast.c:535 [inline]
 __batadv_mcast_mla_update net/batman-adv/multicast.c:911 [inline]
 batadv_mcast_mla_update+0x1c17/0x4f80 net/batman-adv/multicast.c:948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3321
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3402
 kthread+0xd5c/0xf00 kernel/kthread.c:464
 ret_from_fork+0x1e3/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

CPU: 1 UID: 0 PID: 68 Comm: kworker/u8:4 Tainted: G        W           6.16.0-rc3-syzkaller-00072-gee88bddf7f2f #0 PREEMPT(undef) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: bat_events batadv_mcast_mla_update
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

