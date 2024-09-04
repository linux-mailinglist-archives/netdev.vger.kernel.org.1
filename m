Return-Path: <netdev+bounces-125237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C077B96C630
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752052857F1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E41E1330;
	Wed,  4 Sep 2024 18:19:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2A1DA319
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473967; cv=none; b=jhrhXfAppk89i542DRt0a2nNwXNGGfKng6/9uyhlvxHaWPG7jvFLUIqzhpuPH04ZgAvwp2DKfCq56oWl2Efq2J3aZ5ap0s/W/jfYgTmaEbxRzQ45q6oq5do4jHxarQ6gwjCYZK1/x5FjReEdbE0fsfRAkmorkGpMXkWgwvRMB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473967; c=relaxed/simple;
	bh=iFdWUqlGV2PDlljSJX1oZOqtXgVX67X7LRHepQPiK80=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QW2v2C24jZ1ljbKx1GDfs6sJDatyYG2jpOjGEAeQWFcLSzu4RM7wriyiiaBAM/hyPYEm+O0nw+BobmsJ3NnMtJ3fdb77Z3pDAokjWoyLwyn0xjqkYr5RYoch6bgn9ImFYm6FNVfLk7l7XNbhFkrTK+Bt1k4/y9NDslOnsXcO75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a36f1515cso665074739f.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 11:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473965; x=1726078765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5v8ecZ4KHwCQtLG0DSvxND0b9364kC606ptb+L6Bap0=;
        b=unGr/Cqvc22LCzt10PH5tN1UHZ7H+8AV1DCF5EKL6AfHiU1QCtz/svsgsrpiAmzsWW
         zsvItO0tW2aiPhBCS9grDwGCKWCOgQukm+AzpzE0xtPpDfEwLFB6fLulRNFjKpOB7J55
         7piLpT4Jh1IXwHY7DNkKxJTroL1E+ibqTnv7blNPAMtaUdF0ptO06LVfyITy8YYZYi2R
         Figau8spWmuk695FsD3vHHzzPwCWBvm/qoHzBnaQvZD5kTYDSC/9P0Dxi7z0ZB81R1QJ
         CvVJPQE2i1w0HH6YsfYXNI9INyVO/ysTXO69m5iyn1VRmNkPmJLLNmIIUFvXsE3ePu6I
         N3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUzV4/RtmbyvMCBDP6fC0Tt8xDH7dwc0UFMGsCPTRYa3oreL+u1lyDr3vH6MqrFoEAoU8A9Pnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR65aZkmrAYPl1gFl3QYWKB95WBErgq4mjxiMGfbGgrJrnqQWD
	PUPu4wb8NVJXHeZLizYFuK/6tt4IgfWkW3oDk1sf2krg5McGEtsgV7g9SM+iBanQDlQIEM+Ltg3
	lcs1OrHVye1wykDj6nDaiE5lFn9Zwp8Cri5+RZ5tpCVm8/UrJc5iNhcw=
X-Google-Smtp-Source: AGHT+IF4tLwBuxUrjxjTyFAWaKoWUwEq8Sq5BeP/Yu6wo4u0ow6AM38DImsgwGvv+js/+VpjQtAZTQT+XdcRSyT2lv93PqkArAa9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4118:b0:4c0:a90d:4a7c with SMTP id
 8926c6da1cb9f-4d017f16606mr1050332173.6.1725473965104; Wed, 04 Sep 2024
 11:19:25 -0700 (PDT)
Date: Wed, 04 Sep 2024 11:19:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c274f106214f3631@google.com>
Subject: [syzbot] [net?] WARNING in __dev_queue_xmit (4)
From: syzbot <syzbot+1a3986bbd3169c307819@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43db1e03c086 Merge tag 'for-6.10/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161fbc31980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=1a3986bbd3169c307819
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e4f459980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12272ea5980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-43db1e03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e968f44e2ed/vmlinux-43db1e03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b371a4faf10a/bzImage-43db1e03.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a3986bbd3169c307819@syzkaller.appspotmail.com

warning: `syz-executor452' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5199 at kernel/softirq.c:362 __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Modules linked in:
CPU: 1 PID: 5199 Comm: syz-executor452 Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Code: 00 e8 01 91 0b 00 e8 ec 30 43 00 fb 65 8b 05 8c dd b1 7e 85 c0 74 52 5b 5d c3 cc cc cc cc 65 8b 05 ce 8c b0 7e 85 c0 75 9e 90 <0f> 0b 90 eb 98 e8 f3 2e 43 00 eb 99 48 89 ef e8 a9 0e 1a 00 eb a2
RSP: 0018:ffffc900032af368 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 1ffffffff1fc96eb
RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffff88c4e35d
RBP: ffffffff88c4e35d R08: 0000000000000000 R09: fffffbfff1fc9092
R10: ffffffff8fe48497 R11: 000000000000001d R12: ffff888021f9e000
R13: ffff888021f9e100 R14: ffff88801c1e40b8 R15: ffff88801c1e4000
FS:  0000555593697380(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555638997000 CR3: 0000000026c08000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:851 [inline]
 __dev_queue_xmit+0x872/0x4130 net/core/dev.c:4420
 dev_queue_xmit include/linux/netdevice.h:3095 [inline]
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:307 [inline]
 __netlink_deliver_tap net/netlink/af_netlink.c:325 [inline]
 netlink_deliver_tap+0xa7d/0xd90 net/netlink/af_netlink.c:338
 __netlink_sendskb net/netlink/af_netlink.c:1279 [inline]
 netlink_broadcast_deliver net/netlink/af_netlink.c:1412 [inline]
 do_one_broadcast net/netlink/af_netlink.c:1499 [inline]
 netlink_broadcast_filtered+0x938/0xf10 net/netlink/af_netlink.c:1544
 nlmsg_multicast_filtered include/net/netlink.h:1125 [inline]
 genlmsg_multicast_netns_filtered include/net/genetlink.h:491 [inline]
 genlmsg_multicast_netns include/net/genetlink.h:508 [inline]
 nl80211_frame_tx_status+0xa6d/0xd00 net/wireless/nl80211.c:18952
 ieee80211_report_ack_skb net/mac80211/status.c:645 [inline]
 ieee80211_report_used_skb+0x1241/0x21c0 net/mac80211/status.c:778
 ieee80211_free_txskb+0x23/0x40 net/mac80211/status.c:1291
 ieee80211_do_stop+0xd5d/0x2200 net/mac80211/iface.c:650
 ieee80211_runtime_change_iftype net/mac80211/iface.c:1873 [inline]
 ieee80211_if_change_type+0x360/0x790 net/mac80211/iface.c:1911
 ieee80211_change_iface+0xa5/0x500 net/mac80211/cfg.c:219
 rdev_change_virtual_intf net/wireless/rdev-ops.h:74 [inline]
 cfg80211_change_iface+0x586/0xdd0 net/wireless/util.c:1215
 cfg80211_wext_siwmode+0x222/0x2b0 net/wireless/wext-compat.c:67
 ioctl_standard_call+0xd0/0x210 net/wireless/wext-core.c:1045
 wireless_process_ioctl+0x4e3/0x5e0 net/wireless/wext-core.c:983
 wext_ioctl_dispatch net/wireless/wext-core.c:1016 [inline]
 wext_ioctl_dispatch net/wireless/wext-core.c:1004 [inline]
 wext_handle_ioctl+0x23d/0x2c0 net/wireless/wext-core.c:1077
 sock_ioctl+0x3ac/0x6c0 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff609c12199
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc08407c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff609c5f48b RCX: 00007ff609c12199
RDX: 0000000020000000 RSI: 0000000000008b06 RDI: 0000000000000003
RBP: 00007ff609c5f469 R08: 00007ffdc08408f8 R09: 00007ffdc08408f8
R10: 00007ffdc08408f8 R11: 0000000000000246 R12: 00007ff609c5f429
R13: 0000000000000031 R14: 0000000000000047 R15: 0000000000000004
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

