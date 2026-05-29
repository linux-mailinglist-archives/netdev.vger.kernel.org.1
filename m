Return-Path: <netdev+bounces-292928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBhzBRrvGGo/pAgAu9opvQ
	(envelope-from <netdev+bounces-292928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:42:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE75FC123
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE2630760B7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC435E1C5;
	Fri, 29 May 2026 01:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59A35E1DB
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018888; cv=none; b=k9Gwjv88CfqXFK5K+CKLQgmrA1QJbwMQ7Q+iLh7bQ5djAKiwaIW8mX2GxV8DPmGbpkOdSKxsKNF7mdgd+XG6V8aozwX/t6aDP/eaDfzDHWBUaMEI19/fPIyXKiaYzjmNA1UGCZ978V84dx+5Z8EzWd2oN2R4oogKXZMYjVbzMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018888; c=relaxed/simple;
	bh=120bVSQLdPnl7gzjI00muoHs/i0ZIQoj5jR62It2T+0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gZ30Y31ZgLrWE/IIURk1IS3Xw+WunIDfYYWlOhWX2cSfakbI65GD8n8NpctsUKiZXigKK1DLNEKaNKujLkuv22cB/3bqUMJGr3QK/HPScStT1AujK0P9FobRov/98P25xIYmWB+NnnwZB44qhehMkcN7kxPrOaCkr3MUr54s1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-43a5232c87eso6868983fac.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780018885; x=1780623685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBCnZ43C3H+9ncA/RoRecjFYPKsKHr1k7V623+sXjgo=;
        b=J4ZS7xrai7MdT3LO1j0D8nkPNvhC5jjoi0EWPn9MQGmU34/+6IJjlUyXfwo98APOoJ
         C++HuYNuUT9miUWN+fSynttsQWeBWSUuIz31v5ZzxNBSaYl+v3mm6KClp1lsi3sHS8xc
         oLa1CA4XL8wYyFFJyV8tu/xm5/2onaG0iOptjYOmHcR68k4fYWdzc6nfi+Cf3p7iqbl1
         hCfKmZNJlJ2OrVQoApTKCzuYzcqimXXmbsZGz8Ncdv4WBywp0wizkXVYDYbsJzPsieNB
         r6ODxZHlinSTN+0d8BRmF6Btvqdv+7KwL4glawupaHXTUsSuW2KtCNwaT/awYbY1KOvY
         Ul1g==
X-Forwarded-Encrypted: i=1; AFNElJ9zH0eI1vgDvj9K3nVB9VdrSWLkxM3toIhT4Zz4sqDsqRplnvTO/Iutjns0IRwsS9C8hHszoXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KXlnD0bFw9pmtfmddCk+oHJ+d8UNHbUgKRiT2aHUVrX70jGv
	tcNi+8Tk76E5jeLjX3O+zkXZ3EMF5PSsRd0jAA9bWBU32y2h2GcwVl+MuRzYI524lBGeryEj3ph
	uZmod3MxMS7xsa5p9KoPXoCZPlhMznKjo5wFjORvk9xIppoxhwT68D1cdwsg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168d:b0:69d:9e9d:b000 with SMTP id
 006d021491bc7-69e03ef9ad8mr519546eaf.23.1780018885631; Thu, 28 May 2026
 18:41:25 -0700 (PDT)
Date: Thu, 28 May 2026 18:41:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a18eec5.9a649fcc.180209.0002.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_link_info_changed (3)
From: syzbot <syzbot+c4686c3eb8b64032618f@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e327ee9a867dd6b9];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292928-lists,netdev=lfdr.de,c4686c3eb8b64032618f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,appspotmail.com:email,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 5FDE75FC123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    4cbfe4502e3d Merge tag 'v7.1-rc5-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bb6d96580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e327ee9a867dd6b9
dashboard link: https://syzkaller.appspot.com/bug?extid=c4686c3eb8b64032618f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4cbfe450.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae30bc5ef3ba/vmlinux-4cbfe450.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2547601acb10/bzImage-4cbfe450.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4686c3eb8b64032618f@syzkaller.appspotmail.com

------------[ cut here ]------------
changed & (BSS_CHANGED_BEACON | BSS_CHANGED_BEACON_ENABLED) && sdata->vif.type != NL80211_IFTYPE_AP && sdata->vif.type != NL80211_IFTYPE_ADHOC && sdata->vif.type != NL80211_IFTYPE_MESH_POINT && sdata->vif.type != NL80211_IFTYPE_OCB
WARNING: net/mac80211/driver-ops.c:468 at drv_link_info_changed+0x583/0x880 net/mac80211/driver-ops.c:468, CPU#3: syz.5.1844/11254
Modules linked in:
CPU: 3 UID: 0 PID: 11254 Comm: syz.5.1844 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:drv_link_info_changed+0x583/0x880 net/mac80211/driver-ops.c:468
Code: 00 48 89 74 24 10 e8 3c 3d 0f f7 48 8d 3d 75 29 ef 05 48 8b 74 24 10 44 89 f2 67 48 0f b9 3a e9 ae fc ff ff e8 1e 3d 0f f7 90 <0f> 0b 90 e9 bf fe ff ff e8 10 3d 0f f7 90 0f 0b 90 e9 b1 fe ff ff
RSP: 0018:ffffc900065bee48 EFLAGS: 00010287
RAX: 000000000000096f RBX: ffff8880277d4e40 RCX: ffffc90007392000
RDX: 0000000000080000 RSI: ffffffff8af974c2 RDI: ffff88802aa42500
RBP: 0000000000000200 R08: 0000000000000005 R09: 000000000000000b
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88805f010f20 R14: 0000000000000200 R15: ffff8880277d6b78
FS:  00007fae699f66c0(0000) GS:ffff8880d666a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000044d79000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_link_info_change_notify+0x24b/0x3c0 net/mac80211/main.c:427
 ieee80211_offchannel_stop_vifs+0x328/0x5c0 net/mac80211/offchannel.c:122
 ieee80211_start_sw_scan net/mac80211/scan.c:583 [inline]
 __ieee80211_start_scan+0xfb6/0x1af0 net/mac80211/scan.c:882
 ieee80211_scan+0x4f8/0x6e0 net/mac80211/cfg.c:3343
 rdev_scan+0x148/0x370 net/wireless/rdev-ops.h:467
 cfg80211_scan+0x4dd/0x5d0 net/wireless/scan.c:1077
 cfg80211_conn_scan+0x70e/0xfc0 net/wireless/sme.c:134
 cfg80211_sme_connect net/wireless/sme.c:629 [inline]
 cfg80211_connect+0x17fe/0x1fe0 net/wireless/sme.c:1527
 nl80211_connect+0x17d3/0x2260 net/wireless/nl80211.c:13745
 genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae6b79ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae699f6028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fae6ba15fa0 RCX: 00007fae6b79ce59
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007fae6b832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae6ba16038 R14: 00007fae6ba15fa0 R15: 00007ffc87f56808
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

