Return-Path: <netdev+bounces-285565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMGOMKsu/WlIYgAAu9opvQ
	(envelope-from <netdev+bounces-285565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 02:30:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D44F07B1
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D01E2300A586
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9149C1891A9;
	Fri,  8 May 2026 00:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA11171BB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778200230; cv=none; b=XKzcnIcydIcMJS2CvsGU/xEMsvBG74lfW8ZnLZz91kQUa/BYU4+9JKj8Xt0xpeGx7e1rEeKbdEbwn8tEhEEHUKsJt3LtJIH2eiLIOMA1arAwy36blEydSo5GieRHobakuBiAX/NoXyHXiX7E+v2XcHSrdsuCFjDJdFSays04o68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778200230; c=relaxed/simple;
	bh=jKrNWM4sTl/fN6pwMtPOkS6bJ/8RKqOpQAKAIXdpwPU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hzoEmOlGvfRi3/QcRpILijewrp3PN7LdKjKcwws3jb8H0lIOJy0ed5P6LqBp6fJCviOIQCxi0SbBpsuSsDV/7r7MEp8dx75ElCXcwGFbCj6em38D95kl1w3t+qKpLReXm7n2zgdPZJKRYIXyV3ZfSK994SdMyjluvvw0tMrGTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7d496d080d8so2134245a34.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 17:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778200228; x=1778805028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIkD2xwrP+8INnxczVEjgjkxbUkaCe5PiDLA5paCELc=;
        b=N8XO8JZOssB0fym/Kxk7fqkwomiCck4r74vPfuYn74bWyGraO2RSd9bp8QjCzlWyk4
         dA+vx1G5qrH6gQ5xLtoE+rPyHk4LFAvNMSUk+vGTAce27rkLePNYShrGOxT2XYMZLxpd
         Bze4tIjntobjk+7HOrWhqMqF1qMHYBUlUAHMvSYv8QbFma0YauKL03pGSDBmzQoKfOwd
         bGgB3M4SbWr85/n98TQIl3AU+KRKSMh1kLN4gICQO+ATicMtf7m0+/fkUaJZ7wyUrabI
         tvx/8D2CoC3FMK7ezf6oncmL1ttMtSNoQQPA5nLYuXeBF0wUCURQm8qbSj9TCxz2QN4i
         EMEg==
X-Forwarded-Encrypted: i=1; AFNElJ+I8U3Nq7jm+ZBCCEJ8EhB/hp4IDnAEgfybjs1e4ckCxo4tRmT0PHgcH6wkalSEpw/fEDIfBKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtEzrITIdJcU01Gy8PeiugzY2t4/ICLKoXAPuCr/8Y4CLmmkT
	s9D7PUh2Ost5zdRJnvY1DDfgleCqy08QDSSSmw3Dil4XSIdKBzXVbgpDyVmjZ9QhqInMCQudDrY
	2hbrOp2AaY5uoZ3XjPqKZlPTJa616AZM66YKi+fS74s2fe9L0D4mBtfQdTyQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:604:b0:67e:1be2:59e1 with SMTP id
 006d021491bc7-69998cbca0dmr5705143eaf.18.1778200227797; Thu, 07 May 2026
 17:30:27 -0700 (PDT)
Date: Thu, 07 May 2026 17:30:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69fd2ea3.170a0220.25a3d6.0008.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in wiphy_register (5)
From: syzbot <syzbot+2002864e6c6895cb0ac3@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C78D44F07B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285565-lists,netdev=lfdr.de,2002864e6c6895cb0ac3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2281958e6007 Merge tag 'wireless-next-2026-05-06' of https..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=139f656a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035
dashboard link: https://syzkaller.appspot.com/bug?extid=2002864e6c6895cb0ac3
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1452fb48580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179f656a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4df17f60254b/disk-2281958e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e93157edd25/vmlinux-2281958e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60dbf6a0a81c/bzImage-2281958e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2002864e6c6895cb0ac3@syzkaller.appspotmail.com

------------[ cut here ]------------
(wiphy->interface_modes & BIT(NL80211_IFTYPE_NAN_DATA)) && (!wiphy->nan_capa.phy.ht.ht_supported || wiphy->n_radio > 1)
WARNING: net/wireless/core.c:885 at wiphy_register+0x58a/0x2fe0 net/wireless/core.c:884, CPU#0: syz.0.17/5835
Modules linked in:
CPU: 0 UID: 0 PID: 5835 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:wiphy_register+0x58a/0x2fe0 net/wireless/core.c:884
Code: 00 00 e8 49 8f d4 f6 90 0f 0b 90 e9 67 0a 00 00 e8 3b 8f d4 f6 e9 59 0a 00 00 e8 31 8f d4 f6 e9 eb 00 00 00 e8 27 8f d4 f6 90 <0f> 0b 90 e9 45 0a 00 00 44 89 f8 24 06 0f b6 d8 31 ff 89 de e8 0d
RSP: 0018:ffffc90003236860 EFLAGS: 00010293
RAX: ffffffff8af13fe2 RBX: 0000000000000004 RCX: ffff88802ed60000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc900032369f0 R08: ffff8880582b0faf R09: 1ffff1100b0561f5
R10: dffffc0000000000 R11: ffffed100b0561f6 R12: ffff8880582b0740
R13: dffffc0000000000 R14: ffffffff8d002990 R15: ffff8880582b0804
FS:  0000555593855500(0000) GS:ffff888125289000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007eff2e872700 CR3: 0000000075672000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_register_hw+0x3c53/0x4910 net/mac80211/main.c:1627
 mac80211_hwsim_new_radio+0x3327/0x57e0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:6047
 hwsim_new_radio_nl+0xe20/0x26e0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:6832
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7eff2e99cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd72c5edf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007eff2ec15fa0 RCX: 00007eff2e99cdd9
RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007eff2ea32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007eff2ec15fac R14: 00007eff2ec15fa0 R15: 00007eff2ec15fa0
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

