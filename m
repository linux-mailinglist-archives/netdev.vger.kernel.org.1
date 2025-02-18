Return-Path: <netdev+bounces-167350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA40A39DDA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA05188B19A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344F2698BC;
	Tue, 18 Feb 2025 13:46:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24A269897
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886386; cv=none; b=crRXtIcQfn+vbpDwZWf9QDuuF/CSj1SOsrTC5HziMHEs0a6CRimr/jWYXeNoa5DffBpQknPIOB0NWr0+NFCBtZsSMfqVDlbJvPRFl8YeN/SDWB69uTaK5xxQyqw2Oipi3061fj8l8HFbp0h095NH3JgZMp/EVuAC+Au86Z5BnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886386; c=relaxed/simple;
	bh=il08OLKjKuHNV8BTSYpPsn4tJgo+kR2RqcDKWXGg2gQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uwb5MEvj/MKeyuap7sC+z1ne6CeMCcniBHFfwXVDV+gL5Y7jqGpl1cV/zkO0FvYH7XrUPjCsNrzFZfBgsfNkV2WVJ+iJALhBlegh586qynQBDAXeq8MZsz7iP3VR4QNfMwayOot5kj6pY3O/fgKaM906nJo81FHT+clmDzzxGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8559792ada5so287077939f.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 05:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886384; x=1740491184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wlp3UV1yF73fleHjaJzrNOPIjk7ttS5DgEpGbxNngV8=;
        b=dToVSsd5VVaaacLHXTz0FDQkgGGFsJwhEPSfq4JsnQZBKuvAqMigqmUHNYfmtDEvs5
         BeXv1fitQ0FGmXBbpj4nuTkZkFXZi9GuhUfP1FRHKe9Ezv+PVL9auW+4cXqvz6cjed7P
         EbWQZKCIHl2KIp3H0sKbWl5BAUs954YZZg3B7Pd+XECQuZlM5KPHaYHgmKM0erSYzTJh
         5MTeHhCItNPRI7N7SRBPubCEK53m8ONXBfLMKHmUftG+C1AQGJ9rRmlnYJf2dz1oN1XI
         aCcPHX0dj0bYYE2DiAi9En4RNH7wNrQ+WccXpKi8iG2P6h8i83E5IbQCB7hPazBFVUxt
         vflw==
X-Forwarded-Encrypted: i=1; AJvYcCWz1YtqJQ0nexoXlODV4uMGhpNALbbnvNg3TE8sNJ1AF8/cYEzaZPpVT8VSgH53S++keinGr0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILBN+NPQ5DMLuaWlOJdGtiTixYUemiQMB8Hn39ca2X4QLM+Rz
	Zg0CmvPm1fHpMTQehRfTukRegHTnxGC2Nvh7+oi4fM0avsWoLclNB2cUbiNwP2qESAPPbyXruyC
	esJTsCfKKzhcctrC2hCoqd3pTKFcOUcLDlYVcXt3KNDp76ZyqgqaZWAE=
X-Google-Smtp-Source: AGHT+IHRF8HXAs3t/VFjdcyM1iNnTahzHbeP27tXqsh2vjEjukNWoxag3AddLmPmeC5h3wzJiZW/36N7QYTboy/DfaVCT+iKPIxD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1686:b0:855:2f41:f85a with SMTP id
 ca18e2360f4ac-8557a13f969mr1345339839f.9.1739886383740; Tue, 18 Feb 2025
 05:46:23 -0800 (PST)
Date: Tue, 18 Feb 2025 05:46:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b48f2f.050a0220.173698.0063.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_addr_send_ack
From: syzbot <syzbot+cd3ce3d03a3393ae9700@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad1b832bf1cf Merge tag 'devicetree-fixes-for-6.14-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13798898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e55cabe422b4fcaf
dashboard link: https://syzkaller.appspot.com/bug?extid=cd3ce3d03a3393ae9700
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9de6d97a8d34/disk-ad1b832b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/258463d6a9b5/vmlinux-ad1b832b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0449b94f00a/bzImage-ad1b832b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd3ce3d03a3393ae9700@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.0.205'.
netlink: 8 bytes leftover after parsing attributes in process `syz.0.205'.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 sock_owned_by_me include/net/sock.h:1711 [inline]
WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 msk_owned_by_me net/mptcp/protocol.h:363 [inline]
WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 mptcp_pm_nl_addr_send_ack+0x57c/0x610 net/mptcp/pm_netlink.c:788
Modules linked in:
CPU: 0 UID: 0 PID: 6693 Comm: syz.0.205 Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:sock_owned_by_me include/net/sock.h:1711 [inline]
RIP: 0010:msk_owned_by_me net/mptcp/protocol.h:363 [inline]
RIP: 0010:mptcp_pm_nl_addr_send_ack+0x57c/0x610 net/mptcp/pm_netlink.c:788
Code: 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ca 7b d3 f5 eb b9 e8 c3 7b d3 f5 90 0f 0b 90 e9 dd fb ff ff e8 b5 7b d3 f5 90 <0f> 0b 90 e9 3e fb ff ff 44 89 f1 80 e1 07 38 c1 0f 8c eb fb ff ff
RSP: 0000:ffffc900034f6f60 EFLAGS: 00010283
RAX: ffffffff8bee3c2b RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc90004d42000 RSI: 000000000000a407 RDI: 000000000000a408
RBP: ffffc900034f7030 R08: ffffffff8bee37f6 R09: 0100000000000000
R10: dffffc0000000000 R11: ffffed100bcc62e4 R12: ffff88805e6316e0
R13: ffff88805e630c00 R14: dffffc0000000000 R15: ffff88805e630c00
FS:  00007f7e9a7e96c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fd18ff8 CR3: 0000000032c24000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mptcp_pm_remove_addr+0x103/0x1d0 net/mptcp/pm.c:59
 mptcp_pm_remove_anno_addr+0x1f4/0x2f0 net/mptcp/pm_netlink.c:1486
 mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_netlink.c:1518 [inline]
 mptcp_pm_nl_del_addr_doit+0x118d/0x1af0 net/mptcp/pm_netlink.c:1629
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb1f/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2573
 ___sys_sendmsg net/socket.c:2627 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7e9998cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7e9a7e9038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7e99ba5fa0 RCX: 00007f7e9998cde9
RDX: 000000002000c094 RSI: 0000400000000000 RDI: 0000000000000007
RBP: 00007f7e99a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7e99ba5fa0 R15: 00007fff49231088
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

