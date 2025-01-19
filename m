Return-Path: <netdev+bounces-159656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA937A16405
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 22:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE6E7A268D
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1A1DF73A;
	Sun, 19 Jan 2025 21:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7F19E99A
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737322885; cv=none; b=JWGmFGK+Qbq+wIY4nFw2h0KL00Etg0h7sCn2ydDwzRFizaIRyhoqABRT4297VcE8gqOvskBa9BBJcYO9irN4oD77svgdJwNg3djipQpTFaOsoBe05wp5mZHwe3lj+9gLrbw3KlxIpRsQK6awTLbuOxDdZ9MYToTcMSaHLNcqG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737322885; c=relaxed/simple;
	bh=9bTIuPIrcXZdpwp3r7z35PA1+vLuJuCCh6OoRrns2Vc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xb5FU5G0M4ZwE/eQ5uomr4TycauRU8Ts2HLwjYBtfPqbHzulC+Oevj0/weqF10FCP27Mp1JADpN3wsMbCvXZRZTEad7ofkWyPbmdOE+laX+a1l53Rzq97McfxLUIAGcrmg+e7CigITmTUIIDRfbXqQ/28GABq7MR/QNeScowM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-851a991cf8bso210904339f.0
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 13:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737322883; x=1737927683;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLkLKP4qiOGdIVw6XBrXEzKeEzrfv2Lm9845lBhwEX8=;
        b=V4NIsWax6eDM239sJ+Yn34dVSjlJ2mJcCfEuUS0PofBJ+URK4xY2i9axR8kO1Zh/0N
         CxIc7ELmptqLR3dWNsFdbfkfDpGTiH9mSUHEdJI0mWPHKn+ZSTR3nODCVHEmzASbQY3W
         FQabebJwRQ16Z5WJQsmGpezZP2g/p26ZmzV+KVyCzVk4J9K/R44GsLtAaGagqn/7okZR
         nBnGWPRPvTqqt5gAo1yXjTIVfkF98DAZ7dF/qXc11NTQ0EMFy9trI5W0LmA0u9AEsBtW
         q8VdBUfSTQs0iXR+jXrTCUy4xdE3THrCBdieBqlazH6rb9XL02CHZRma64idumrpmZEZ
         Txxw==
X-Forwarded-Encrypted: i=1; AJvYcCXppuKsgscxqy3TNEjVlVUo0ERCfmhsSAWXlXr5hftcGPqrV6HAUIFI64SGUTnw7TCxrRQgVo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmGRjYmGk3F0y3N9bxee7IiKbNmm0K9JDcxyAdgdwhm1iTbFi
	nFTznxkc2x47oecMP/DArhDt6CQVEVuSLWH7K9X5zNk9Wug1sUv0XITaoj98BpqbL1MuWmdxOWb
	30N4blDnhgqDqF6Sp4XioXWG3RCMVkcx5Y8A5rYrvDXmtr8ubJlZxICY=
X-Google-Smtp-Source: AGHT+IGqKcpAhmDcabHPm4QfooXMUk2p+gqshZM2puSNzjDw4TpFZO11+yixVhsBrC4TtOELnjg2wwsq8/q/l+Kk2uGU9/UXaZsG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0c:b0:3ce:7faa:3d3f with SMTP id
 e9e14a558f8ab-3cf747c7ad2mr74169755ab.3.1737322883252; Sun, 19 Jan 2025
 13:41:23 -0800 (PST)
Date: Sun, 19 Jan 2025 13:41:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678d7183.050a0220.303755.005f.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tdls_build_mgmt_packet_data
From: syzbot <syzbot+e55106f8389651870be0@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    619f0b6fad52 Merge tag 'seccomp-v6.13-rc8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fb49df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=e55106f8389651870be0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-619f0b6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f181fafa1b35/vmlinux-619f0b6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/174e5d6e6837/bzImage-619f0b6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e55106f8389651870be0@syzkaller.appspotmail.com

mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5320 at net/mac80211/tdls.c:611 ieee80211_tdls_add_setup_cfm_ies net/mac80211/tdls.c:611 [inline]
WARNING: CPU: 0 PID: 5320 at net/mac80211/tdls.c:611 ieee80211_tdls_add_ies net/mac80211/tdls.c:762 [inline]
WARNING: CPU: 0 PID: 5320 at net/mac80211/tdls.c:611 ieee80211_tdls_build_mgmt_packet_data+0x329c/0x4080 net/mac80211/tdls.c:984
Modules linked in:
CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted 6.13.0-rc7-syzkaller-00043-g619f0b6fad52 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_tdls_add_setup_cfm_ies net/mac80211/tdls.c:611 [inline]
RIP: 0010:ieee80211_tdls_add_ies net/mac80211/tdls.c:762 [inline]
RIP: 0010:ieee80211_tdls_build_mgmt_packet_data+0x329c/0x4080 net/mac80211/tdls.c:984
Code: f5 ff ff e8 16 6e 4a f6 90 0f 0b 90 4c 8b 7c 24 10 e9 7e fe ff ff e8 03 6e 4a f6 90 0f 0b 90 e9 70 fe ff ff e8 f5 6d 4a f6 90 <0f> 0b 90 e9 62 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c c7
RSP: 0018:ffffc9000d47f0c0 EFLAGS: 00010287
RAX: ffffffff8b55147b RBX: ffff888040d3cd80 RCX: 0000000000100000
RDX: ffffc9000e5d2000 RSI: 00000000000002e3 RDI: 00000000000002e4
RBP: ffffc9000d47f260 R08: ffffffff901983b7 R09: 1ffffffff2033076
R10: dffffc0000000000 R11: fffffbfff2033077 R12: dffffc0000000000
R13: 0000000000000017 R14: 0000000000000000 R15: ffff88803f0f5c80
FS:  00007f0f00e996c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200021c0 CR3: 0000000040622000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_tdls_prep_mgmt_packet+0x3b6/0x860 net/mac80211/tdls.c:1058
 ieee80211_tdls_mgmt+0x8cf/0x10a0 net/mac80211/tdls.c:1299
 rdev_tdls_mgmt net/wireless/rdev-ops.h:926 [inline]
 nl80211_tdls_mgmt+0x4d8/0x770 net/wireless/nl80211.c:12540
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0efff85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f00e99038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0f00175fa0 RCX: 00007f0efff85d29
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000009
RBP: 00007f0f00001b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0f00175fa0 R15: 00007ffe23266438
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

