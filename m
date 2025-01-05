Return-Path: <netdev+bounces-155265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BDEA01924
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45471628D2
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF5126C0D;
	Sun,  5 Jan 2025 11:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541361DA21
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736075188; cv=none; b=vCkcutI/Yc500J9jXxNtAYkNOEmGJ8C0uf0jD5El4toS8JeRdhr7ldXI7Dc4K877D0T9VyoRsIQW94Y0VkwcLhrc4uCaTP14ihWhlVFDzuZocv5a1xjAYBe9SqF8geMe8CgQdzu1H2Zi9LNBo4i/5+ZKxH/LONVggK8IZ45HfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736075188; c=relaxed/simple;
	bh=M+hyUBGCb9zAbHFHwy6LxvoR24ECard84HuXfXjwtVw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ey0phy2P72VQaPAfVmn/vD92edrJV5FPn1nlVWnjuSqBAUzY+1hSzEDuVrbaV7PrXC9KoUHiCsDcczu8GLBDDY8uUBTbQT+n+9Zz3sTl97SULNkbyfPKO+5QXYMrfuWWyquWKZpbkJplHbNv23HbXy6WXqLFv31vFb1u/SDP8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so132104775ab.3
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 03:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736075185; x=1736679985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZBGNpHam0AzUR5+sMhqnkIQU6qgmO8Mms//N3JFtyA=;
        b=IHo/1ficCLTWenZrGnusLfedQPB80E+Ql4c3Wan65Xpsg5coG2oEk6ax0G51aWZMHX
         KQMwRNfHcvlGk15IfORQnM+eI6J70stBcMhk0mz7mki1uiL/FBr8aSID9bV9MFPNZY22
         oK6fb9EUcqY9rTItxdLXEBiPkI0MJGIK3VD7bX+0lBzElv1ssXAQ/AAX7yZxHSaES7Fs
         uqGu75IUhdMiesk6WH7OggyNoknkNXhAsbEvYM7vUl5LKYHHgpat1X1NiIjPOboWIu8r
         T8mgox/dqBYHVIdYxaRBB/2Hwi6sQpgyvQI2VSBJRbHv7o80Uje4/w/D7oMI4Axxt6ag
         DLag==
X-Forwarded-Encrypted: i=1; AJvYcCXPDinzgB1bgKs5J9TltSY1qjYspWXFMCVegDZoj82F7GK6UadSg2oZXoDqWnzm6xJKxjfCYwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoX3NZs+GWPboK21Bku/qS+6GeSwSoxtARqv4xX70Fu6c3ZspO
	SGbuj3uk4LprwpyXrxUMCoDqyUF8dqT7Q0lBfa6P0IlEMzZnldSisKToHWw25taNQ3LkU7l0Oy6
	jt3o3uvSCgGDjS60zgcAEBN1tBT3PV+lr+KQU0kYIwvselUh9pChp4YA=
X-Google-Smtp-Source: AGHT+IGa7pmYpmUu08FFyn8XBPRjawz5IWvpXCqhqWcu67N2Thj+F3II7u9f2ea7jfC7Isi3uXA2DUo6HQ+/STREq/Y5ItQte9eo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:7a68:44e2 with SMTP id
 e9e14a558f8ab-3c2d48a3763mr421606935ab.15.1736075185430; Sun, 05 Jan 2025
 03:06:25 -0800 (PST)
Date: Sun, 05 Jan 2025 03:06:25 -0800
In-Reply-To: <00000000000062a2960621a49519@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677a67b1.050a0220.380ff0.000f.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_rx_list (3)
From: syzbot <syzbot+b4aa2b672b18f1d4dc5f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cf96f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc863cc90857c683
dashboard link: https://syzkaller.appspot.com/bug?extid=b4aa2b672b18f1d4dc5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1773aedf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127a5418580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ab751705.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c985fcba8fed/vmlinux-ab751705.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3aa019bd3c16/bzImage-ab751705.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4aa2b672b18f1d4dc5f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 34 at net/mac80211/rx.c:5382 ieee80211_rx_list+0x15e0/0x2970 net/mac80211/rx.c:5382
Modules linked in:
CPU: 3 UID: 0 PID: 34 Comm: ksoftirqd/3 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_rx_list+0x15e0/0x2970 net/mac80211/rx.c:5382
Code: f6 51 5b fe 48 85 c0 0f 85 0a 01 00 00 e8 68 8c f0 f6 48 89 df e8 c0 f4 5a fe e8 5b 8c f0 f6 e9 d1 ee ff ff e8 51 8c f0 f6 90 <0f> 0b 90 e9 d8 ee ff ff e8 43 8c f0 f6 44 89 ef e8 db 69 d3 ff 31
RSP: 0018:ffffc900006dfb18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8aa97661
RDX: ffff88801defc880 RSI: ffffffff8aa989bf RDI: 0000000000000001
RBP: ffff88802e33eb40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888030b1b0c8
R13: ffff88802e33ec18 R14: ffff888030b18e40 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b88c6c8 CR3: 000000002ceaa000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_rx_napi+0xdd/0x400 net/mac80211/rx.c:5492
 ieee80211_rx include/net/mac80211.h:5166 [inline]
 ieee80211_handle_queued_frames+0xd5/0x130 net/mac80211/main.c:441
 tasklet_action_common+0x251/0x3f0 kernel/softirq.c:811
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 run_ksoftirqd kernel/softirq.c:950 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:942
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

