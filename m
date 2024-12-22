Return-Path: <netdev+bounces-153979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890AF9FA8B3
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 00:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB8A7A01C8
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 23:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D918C031;
	Sun, 22 Dec 2024 23:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC71DFF8
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734911723; cv=none; b=b0LrF0WnbMW2DGGNwDE9cTjOJ3OCclnKvwmE0Jp10XZqw1pxys6UXvcNSVAVSanPcEMuZ6Uq1+yA6VYH5tnqib9EoIJmAxFRpD56ewDFYYSJjuXWQ1nnJZU9DZzGaoYIDdRhbEQSy/WC/bCkeBFol+FqE51bgTxWuXAQvXQ4HeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734911723; c=relaxed/simple;
	bh=3jES76ghuwcKgjQWXl3znPXljQomYvXzFp2ea8SNS/4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hhEDhQAztMPIF0ghWnlaQbmR0M23OLN7z8RUsFN3hdQHWWqsKqDnE54DU6DMxph45wuphAWt7NG4SF6wM03tqW7AOwN7wft3mX1OLND6C51My6jhGABJa6oDEhx0u411x//cp/0B/Qslk6VsCfVeHLDtCGDBD+VpBg14rGXz84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so61238005ab.2
        for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 15:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734911721; x=1735516521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XEfUiCWTdjfEDBb+3Klu13mqoKYsVj++5zC5UiO6l4=;
        b=o9sdtCujXnEXrri3ZqpVLvEDI2EAhR7pXDPaZZpLwnwG+rOOZ/A+7kB9Zz0riY0PQV
         yPZ9YpkG55q2AWnyO/QEfUGdzYEzcNAj3vwOKtZf750/yLKlBCIleyjHgKFKl3K2eo0t
         /ZitzWZb7Y2tTZdWWhQ25ihO6mUGFQGnffTvSKKaNqDCxac7ukmBEBYKfu9LJ6l7WIg6
         chKUFBTDvSVROY43Pdu15EKxhnWs/K06DgYF21CUFIlvhjh4hyQAER00j9xbOUfa8RIo
         HqN4tm8At2zLvXnNL4gkt3P0MkMBS5So+x2dcGVlm0iDoWnctx7Ipe0zk79gy8hU+Gtc
         bvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV64J5vhbZu8g5Jvf3LEm9kqcT9ksTebunkVgJV1HdoKFLa5VovBDZPoKzP3SCoZ3TwgMPkglo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGLEYD+nkn1/H9l9D8QqvkFqt3Ckl6SRWfoGxtrcR0jlgBNCZ
	0z5cxUusS/9/41EGqF+EoqsttmqZECcWG+kCnpI6jYqkVz+SQ9DYjJd8ImomU1iCPzH6wb5QvLs
	IQH3i4qHMPV8MjM8HMeO8L0feq8pQsDCHLg8l2cFUrrrj/yEVVrFIK4I=
X-Google-Smtp-Source: AGHT+IGCGcvwSUusj5gvGzq2GbdCO+sZdqqOlFIpC7HjMzw99X8rDSDme5f5SQnOH/5EKrbwIZfzXGCofVWCV3mMSlhZsJaBVIog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2c:b0:3a7:6f5a:e5c7 with SMTP id
 e9e14a558f8ab-3c2d14d23d2mr88935825ab.4.1734911720791; Sun, 22 Dec 2024
 15:55:20 -0800 (PST)
Date: Sun, 22 Dec 2024 15:55:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6768a6e8.050a0220.2f3838.000f.GAE@google.com>
Subject: [syzbot] [intel-wired-lan?] WARNING in e1000_rx_checksum
From: syzbot <syzbot+1bd718f8eea824d2d157@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c061cf420ded Merge tag 'trace-v6.13-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dfc2df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1586bab1323870
dashboard link: https://syzkaller.appspot.com/bug?extid=1bd718f8eea824d2d157
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c061cf42.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac4941665683/vmlinux-c061cf42.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d5addcac95a/bzImage-c061cf42.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1bd718f8eea824d2d157@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 29 at ./include/linux/skbuff.h:5126 skb_checksum_none_assert include/linux/skbuff.h:5126 [inline]
WARNING: CPU: 1 PID: 29 at ./include/linux/skbuff.h:5126 e1000_rx_checksum.constprop.0+0x176/0x1e0 drivers/net/ethernet/intel/e1000/e1000_main.c:3954
Modules linked in:
CPU: 1 UID: 0 PID: 29 Comm: ksoftirqd/1 Not tainted 6.13.0-rc3-syzkaller-00062-gc061cf420ded #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_checksum_none_assert include/linux/skbuff.h:5126 [inline]
RIP: 0010:e1000_rx_checksum.constprop.0+0x176/0x1e0 drivers/net/ethernet/intel/e1000/e1000_main.c:3954
Code: 00 00 00 00 fc ff df 80 3c 02 00 75 76 48 83 85 b0 04 00 00 01 5b 5d 41 5c 41 5d 41 5e 41 5f e9 20 7b 3b fb e8 1b 7b 3b fb 90 <0f> 0b 90 e9 e7 fe ff ff e8 0d 7b 3b fb 48 8d bd a8 04 00 00 48 b8
RSP: 0018:ffffc900006878e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffffff865e991c
RDX: ffff88801deb8000 RSI: ffffffff865e9a35 RDI: 0000000000000001
RBP: ffff888108168d80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000020 R11: 0000000000000000 R12: ffff88805120a140
R13: 0000000000000020 R14: ffff88805120a1c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdcc27d098 CR3: 0000000046c5e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 e1000_clean_jumbo_rx_irq+0xf3e/0x28c0 drivers/net/ethernet/intel/e1000/e1000_main.c:4275
 e1000_clean+0x9d6/0x2700 drivers/net/ethernet/intel/e1000/e1000_main.c:3807
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6883
 napi_poll net/core/dev.c:6952 [inline]
 net_rx_action+0xa94/0x1010 net/core/dev.c:7074
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 run_ksoftirqd kernel/softirq.c:950 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:942
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

