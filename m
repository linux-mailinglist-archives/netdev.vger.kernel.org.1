Return-Path: <netdev+bounces-221067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B41B4A12B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38684E7120
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9EB2FFDEB;
	Tue,  9 Sep 2025 05:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF542FFDC6
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394814; cv=none; b=BIrykqO8csyi3kagO7D/UJDH0//u2FvQbhx1pUyAKUpsQvr17AeHxcto6LMl5q/nWNMwYoCuS4qIMIjaksBnGThiHZezeLC2Rs9DVehMr3WyD+FZr3Po5acl69j1f4PxplQRLEkZmGBGHlTipWvxa3+1OhSYU0P2Qly3ojwgCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394814; c=relaxed/simple;
	bh=qHBwNJiEIrhAZSsXUk5F3O1/3DlTmok1+B3EGO2k+9o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UMPTFB2aoiIwe3RgYougZ5MwcwVkFSn81UP0Fds3Ke0KUWOBlVtQxg4v0OBz39g7c0NngLZPzQqZwLUZ861nidIi/8aursj0QpJ+DLtRhEXdGt3CAzlG2JtwGlU9xCvZALnLfdSqOhJ1pyUCxMGSsYBbkz8ITAR4K7IrMGSZ8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8877b84553dso260466839f.2
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 22:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394812; x=1757999612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5peZDX8n96leXmY4994Qh1nagNgXKKzgkojoG9FJrE=;
        b=J2LmXwNUMBIG9yhptJ+mzCHuPTxiIUSAgSBkCOKV18VxSpjJkF0AgnjeXU40ScUmFT
         ptjn7bV5Xr7cr8UW+p63j92qr02HG4fMVDPO7mdz9Dh3yCuZ+rxwDaQeVTfu8+eIAHfU
         5mfvt/531Xwc5fvjVonyTa5tGf3BH7JTu1V+FWydX2VsYRDjTELN0pq2JMfp3MG9i6mH
         +kbJr8lcmOfo41sJZqezc1vMF65ThGctnEwI+tjI8z/grc8rOfoGj45cSCoaSp3EVB34
         riXJvtmtXjUgQlWkOFNGJuifboxI/Tdy3nLFVLenOh+hSA9fJGNKE6aJ1nZhhVxjuPqq
         3zRw==
X-Forwarded-Encrypted: i=1; AJvYcCW0ywrB1rESHLXom4Qj6tUMFlq38h2VJhPxwqexwmivFacQr9TT2/5tFYnQNwm8xiiY/xOWmSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSMv3abHzgsNj3G/XmhltzVGm1GDCAOepfdfAHxjS29Jt5XAc
	U+hlPXh/jDj9gTsAqBZplKPckYDaV+NK5udE827FOeb5vA49KSH6KZgrgHoxEKknIdJjh2S7Cyf
	ohivo7XTlaFYWZD1FrI4Hm+GHSiPT8NNzZehwguBPPqUCC0U8O1MI+WlwpW0=
X-Google-Smtp-Source: AGHT+IHzavfrAlBXO5FpzJmMgsLXa1kd+8/ge+pWP6Ec0BswrfdfQswCRq5zCRd1BnH+AP3XtF7CkkYzPn9lcZCV0VwzcSMz9IZ6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218e:b0:3f0:40fd:9d1c with SMTP id
 e9e14a558f8ab-3fd7f6657bdmr151260385ab.9.1757394811938; Mon, 08 Sep 2025
 22:13:31 -0700 (PDT)
Date: Mon, 08 Sep 2025 22:13:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bfb77b.a00a0220.eb3d.003f.GAE@google.com>
Subject: [syzbot] [bridge?] [netfilter?] WARNING in br_nf_local_in
From: syzbot <syzbot+aa8e2b2bfec0dd8e7e81@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, fw@strlen.de, horms@kernel.org, idosch@nvidia.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08b06c30a445 Merge tag 'v6.17-rc4-ksmbd-fix' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e3087c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=aa8e2b2bfec0dd8e7e81
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-08b06c30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e152fe53de2/vmlinux-08b06c30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a1bd9f48488/bzImage-08b06c30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa8e2b2bfec0dd8e7e81@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 8841 at net/bridge/br_netfilter_hooks.c:630 br_nf_local_in+0x714/0x7f0 net/bridge/br_netfilter_hooks.c:630
Modules linked in:
CPU: 3 UID: 0 PID: 8841 Comm: syz.0.801 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:br_nf_local_in+0x714/0x7f0 net/bridge/br_netfilter_hooks.c:630
Code: 12 f7 4b f7 90 0f 0b 90 e9 e1 fb ff ff e8 04 f7 4b f7 be 03 00 00 00 48 89 ef e8 87 e8 73 fa e9 39 fa ff ff e8 ed f6 4b f7 90 <0f> 0b 90 e9 dc fd ff ff 4c 89 f7 e8 2c 56 b2 f7 e9 48 f9 ff ff 4c
RSP: 0018:ffffc9000500efc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8a6f9520
RDX: ffff8880255b4880 RSI: ffffffff8a6f9743 RDI: 0000000000000001
RBP: ffff88803a6b2900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: ffff88803a6b29c0 R14: 0000000000000000 R15: ffff88803608d874
FS:  00007faf552176c0(0000) GS:ffff8880d69b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faf55216f98 CR3: 000000001fa82000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xbe/0x200 net/netfilter/core.c:623
 nf_hook.constprop.0+0x3e7/0x6b0 include/linux/netfilter.h:273
 NF_HOOK include/linux/netfilter.h:316 [inline]
 br_pass_frame_up+0x307/0x490 net/bridge/br_input.c:70
 br_handle_frame_finish+0xf5a/0x1ca0 net/bridge/br_input.c:227
 br_nf_hook_thresh+0x307/0x410 net/bridge/br_netfilter_hooks.c:1170
 br_nf_pre_routing_finish+0x8a1/0x1810 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 br_nf_pre_routing+0xf7b/0x15b0 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:283 [inline]
 br_handle_frame+0xad5/0x14b0 net/bridge/br_input.c:434
 __netif_receive_skb_core.constprop.0+0xa22/0x48c0 net/core/dev.c:5878
 __netif_receive_skb_one_core+0xb0/0x1e0 net/core/dev.c:5989
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6104
 netif_receive_skb_internal net/core/dev.c:6190 [inline]
 netif_receive_skb+0x137/0x7b0 net/core/dev.c:6249
 tun_rx_batched.isra.0+0x3ee/0x740 drivers/net/tun.c:1509
 tun_get_user+0x28e4/0x3ce0 drivers/net/tun.c:1950
 tun_chr_write_iter+0xdc/0x210 drivers/net/tun.c:1996
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf5438d69f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007faf55217000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faf545c5fa0 RCX: 00007faf5438d69f
RDX: 000000000000002a RSI: 0000200000000000 RDI: 00000000000000c8
RBP: 00007faf54411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000002a R11: 0000000000000293 R12: 0000000000000000
R13: 00007faf545c6038 R14: 00007faf545c5fa0 R15: 00007fffb9e76588
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

