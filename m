Return-Path: <netdev+bounces-204223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110AAF99FA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E046F1C82B04
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16512DE704;
	Fri,  4 Jul 2025 17:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4912D8384
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651071; cv=none; b=Eqi7tvn5GmKL6hJceafdBnE8Xbp34B/u8KOBobOqAm3iN7iAkCzhRuMcnj8Wl5b6uqNSvTMT3T3WlTjhF+ozqxV2ZiNDGIBBJiUK4r83oh/9efw72liqK2EVUKeNYpfvN4YdgLWclnEJoQybnvpVctofSp9ZBVX/VLUjR/GfnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651071; c=relaxed/simple;
	bh=+XClgXfK5539UpfpVJ0FXUXY6s0Q6GsORz9dYVHVAt0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RpqISjN2Wdq4r2DaIV6gbLRRdF6NdO11MzdMHK/+zqISgOvLDRiDfvXqHZilR1uhcUX6fFaDcNRzUVm2idoJcRnPa/XqZOQbvZnKYxhMD2oLhub9/LUNKqTYG8Y1dzNGQS8kubMS7mbR4XmLwQWKJ19Qx8XdffLRlOaYkF6ZRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso93802739f.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 10:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751651069; x=1752255869;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6reEAjZbC0EFOta4hsE/f6/3JFK1KtUWT6rEBCyeXtM=;
        b=U2yKWQ41o4DLJDuDgAVTPZJiRdn+nh6J7i+dykzZC30LrGhYVJTJJPMOgY47LzVJoz
         V7nGyY8tx9Yx8LQVEZJM0IJPSB1/Te84tc2E+t/32dArbDDgCjnAqX9eQ9WCX6Xfisvu
         eVaGKbBzLF4CVsbKuBsDscGTfWDu4Z0gORKXM0TkcA1QnecDCCai24LXarSYWgsEVhrR
         s3ZqaDSugKIH3g4Rv2gae9m4CESRiCVon0UUENxHQlV9gXZS5yw2HPkEvlC1+HrVazXI
         pXzAyuj+5uqwXf1kGoFW5jcFOHz18ODXa25tCSYPe6dEOzYNFEQugX7BwZkrSM4cEcgJ
         p6yA==
X-Forwarded-Encrypted: i=1; AJvYcCV2x/1D9MyptKsaakTgzYW1Nj07Rt/zg3Ou3zOkgAmIJwlwbgI35jbVpaLS+1mu3WhAnH9WrXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxzXpTfWssLQwjPzeGTh/i8IkFyghgJB9OgKtuaal/9N2DBrn
	RlMJF6+Hw+jWSfrqC4glmH6tbMMUM8/FO47cNJLH2UF9+4FH2ITWyjGFM3kLHHNw9/eEXylQOaS
	yNpR2453rcZU4/ozbmNl1o5tGbZckaqA4hGUEay3Xs8OZX+tmUzXiEqpW0H0=
X-Google-Smtp-Source: AGHT+IGxnkF+jK9kcfbeYVAYPmNFQGpp0HxbAR/UMkQSYP3VAXKmHVJI7VOExp4skgFZmmGT0iL2Btc8ZkLaAqmbYCZ6V27EfVd8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2591:b0:3df:3222:278e with SMTP id
 e9e14a558f8ab-3e136ea4bf6mr30724205ab.1.1751651069283; Fri, 04 Jul 2025
 10:44:29 -0700 (PDT)
Date: Fri, 04 Jul 2025 10:44:29 -0700
In-Reply-To: <682602fd.a00a0220.a2f23.01d0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686812fd.a00a0220.c7b3.0020.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in mac80211_hwsim_sta_rc_update
From: syzbot <syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4c06e63b9203 Merge tag 'for-6.16-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f94582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=c0472dd80bb8f668625f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f66c8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12497ebc580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4c06e63b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff61efc838cb/vmlinux-4c06e63b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dea44d0d14bb/bzImage-4c06e63b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com

------------[ cut here ]------------
intf 08:02:11:00:00:01 [link=0]: bad STA 00:00:00:ff:ff:ff bandwidth 20 MHz (0) > channel config 10 MHz (7)
WARNING: CPU: 0 PID: 176 at drivers/net/wireless/virtual/mac80211_hwsim.c:2653 mac80211_hwsim_sta_rc_update+0x6f5/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2650
Modules linked in:
CPU: 0 UID: 0 PID: 176 Comm: kworker/u4:4 Not tainted 6.16.0-rc4-syzkaller-00123-g4c06e63b9203 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:mac80211_hwsim_sta_rc_update+0x6f5/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2650
Code: 71 17 00 00 48 c7 c7 c0 ae 2d 8c 48 8b 74 24 28 89 ea 48 8b 4c 24 10 41 89 d8 45 89 f9 41 56 50 e8 d0 df 8f fa 48 83 c4 10 90 <0f> 0b 90 90 e9 0c ff ff ff e8 2d 37 cc fa 90 0f 0b 90 e9 fe fe ff
RSP: 0018:ffffc90001a07768 EFLAGS: 00010282
RAX: 2b7aa56dabf85f00 RBX: 0000000000000014 RCX: ffff888000b5a440
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffff88801fc24293 R09: 1ffff11003f84852
R10: dffffc0000000000 R11: ffffed1003f84853 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000007 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808d21c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffec31d80b8 CR3: 000000001216d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mac80211_hwsim_sta_add+0xa3/0x310 drivers/net/wireless/virtual/mac80211_hwsim.c:2670
 drv_sta_add net/mac80211/driver-ops.h:466 [inline]
 drv_sta_state+0x8be/0x1840 net/mac80211/driver-ops.c:155
 sta_info_insert_drv_state net/mac80211/sta_info.c:775 [inline]
 sta_info_insert_finish net/mac80211/sta_info.c:883 [inline]
 sta_info_insert_rcu+0xd32/0x1940 net/mac80211/sta_info.c:960
 ieee80211_ocb_finish_sta net/mac80211/ocb.c:102 [inline]
 ieee80211_ocb_work+0x31f/0x580 net/mac80211/ocb.c:136
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

