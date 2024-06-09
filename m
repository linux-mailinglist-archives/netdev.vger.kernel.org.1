Return-Path: <netdev+bounces-102100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62094901685
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24721F2133D
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D84501B;
	Sun,  9 Jun 2024 15:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A041CD3C
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947989; cv=none; b=fkwOCzNMFEHHGwzupyI7q7Y/u5IGFewQzxADwMmucWvtyBE2XEMFbxg/fgsaEjD8QNd1yyi8sCxBOQZzGTg2NoXOM2BnRhYvvBCI9h1iXZdCnd/MkKiM1kUozo6XGqjZfipuNeFZQxaC9oPbj4nziD5x5N96Bv3lfgz73D3Ko/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947989; c=relaxed/simple;
	bh=BmR7WGyngT9D2Icit299gpJRLMzYonWCQtwfVW6NHFE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WUA8/+roQ80g9VoYwkqBquUJbipHGY2cGFEceQkiN36reNSPOUopQctGs51IuwzemssQ21RX1uMNHjudOZFhfHgNSzTRFSoS4XKj+7kDp1z8R1UAR128mlvQe5BFIX87A87C2N4ZVrhpugEDcfEXHEQ5a4beTldXeg63DLUX7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eaa9ddad99so485366339f.2
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 08:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717947987; x=1718552787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGit8253DSuMkPy55Ebot61PeCnbx0vhheDOMbFFV8U=;
        b=p4+2H2kgtBLpChjppA8LWC0wP8myJIc+9tHBreFAFZyLrGx7uW5ML8FZJitP2DSOyx
         KXqXF5rf87A6hXQSSvdI3810WzQKVvwRIgsBwy+c0/zA6Sh1g+HTmwoT9sjXq5PQ3/2u
         9KWiN7O3ZXiim1LekRkRocBozlDbAcUM5CpSnjKS/qHBc6pdFA3ZakxKsAmllTQzGJkE
         76Kq+DgXBcf+FX6x0RrbhuJoLMtzBYQqIaNT1buxZGtlJ7EGGKwVQ9UVgXzlclif/r9F
         sRQfEt29CXrGxzDSDq6ITy/TXA76mMeoxCmQvVi6Ph134H/VxioYVMISx0w4/+pkrHkt
         tLag==
X-Forwarded-Encrypted: i=1; AJvYcCXVxfZHs/YGzfuKnp82hcNljXaTX0XsVsVvIb36ST5K9nC6Wcn4WsbvJwjDP/TsJiVSASKXMxevZBmY1HH5FvNPRMptwQ0F
X-Gm-Message-State: AOJu0Yz87lZsEkI/qz6d7LMTwYKkQtcFVe1PAwwyvbTS/g4ODqey9hZ5
	ITQuqaQdbclIWK0eUyinCc2DvFdiWEbLk8W3wzfL5cvFe31Brp0srOdC/PCCO/uVezE47ej3d3E
	CBMzeBiyj0nw/qhqauJYMmKCa3gP73atYsXzKCoq2pQ4mJymEilHAY1g=
X-Google-Smtp-Source: AGHT+IEkxBf+V7HQlCwDG4kWqFebf6MZ3K2ZkCXklEgKHjKu0dwxDTezgVuEKTVJaIA3qmNbNCysmSjKr6Zxp4CktewCwjv1ZhFP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:375:a40f:97d1 with SMTP id
 e9e14a558f8ab-375a40f9ce4mr633875ab.4.1717947987316; Sun, 09 Jun 2024
 08:46:27 -0700 (PDT)
Date: Sun, 09 Jun 2024 08:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086e896061a76efd0@google.com>
Subject: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in cfg80211_wext_siwscan
From: syzbot <syzbot+161cd7b97ad2b6e21fb6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    234cb065ad82 Add linux-next specific files for 20240605
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=160c62ce980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc762e458631913
dashboard link: https://syzkaller.appspot.com/bug?extid=161cd7b97ad2b6e21fb6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0492dc0386a/disk-234cb065.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/490224339088/vmlinux-234cb065.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5843c0673606/bzImage-234cb065.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+161cd7b97ad2b6e21fb6@syzkaller.appspotmail.com

warning: `syz-executor.4' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3461:8
index 33 is out of range for type 'struct iw_freq[32]'
CPU: 1 PID: 7326 Comm: syz-executor.4 Tainted: G        W          6.10.0-rc2-next-20240605-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 cfg80211_wext_siwscan+0x56d/0x10d0 net/wireless/scan.c:3461
 ioctl_standard_iw_point+0x788/0xcb0 net/wireless/wext-core.c:867
 ioctl_standard_call+0xc7/0x290 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x58e/0x640 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x15f/0x270 net/wireless/wext-core.c:1077
 sock_ioctl+0x17f/0x8e0 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f14b5e7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14b6be20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f14b5fb3f80 RCX: 00007f14b5e7cee9
RDX: 0000000020000000 RSI: 0000000000008b18 RDI: 0000000000000005
RBP: 00007f14b5eda6fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f14b5fb3f80 R15: 00007ffc59f64db8
 </TASK>
---[ end trace ]---


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

