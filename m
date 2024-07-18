Return-Path: <netdev+bounces-112109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81216935142
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED941F21DE7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7714533D;
	Thu, 18 Jul 2024 17:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC414535B
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721323771; cv=none; b=EgPiYX5RzCBfbDj/8U3gY7Pjg1dlyeCxaIHGtPLGA3asppgdTGtr47dosjKk/i+/mTibtot+C4lMYlBTFQzr7+V8Z28NaaG13l2WaCMUBmT5UA3KpB5+/9Ea4VPd1HQFmTh/HLF2bP9tphrwfiBDv6HeOTkS4Pg8TiWeAt54FyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721323771; c=relaxed/simple;
	bh=Me+zMtshmruILAJekqfPLJtdDLKanWL4ysXOljsidMM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uOLzl0dYiNPIxgtsbBs7/7OahPqgVogFJpLXp3YpiktOorqo1b9Tzoq5jxGx8I5eDoKirhusFwyI1JzITcqStHea5ZDyGYdksbTRSMMyn/fhXEfI6ect4T0kth9pR63wukEx/z4sswgV5lOZYjYgsNY2ypPUaTURHNP9MJoK1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-802d5953345so147911439f.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721323769; x=1721928569;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI6B+T6B6Yllk4n4lA/+kUOT7tKQRBNZs27asQNbJRk=;
        b=tCdemxjmSdxGxT5Tq/iFZjE2JwApghzjjGSgTZcCKkCjhTkuR0cQP77sBbZ71ubIiZ
         dgWABVinurQuvww3DaDhZwx4ZzT3uRlFtrDebi9qORhYqIYs3DeMIGL8iivLcdPQUPIq
         xXit/H03XiGgI9GXluncksx9iDwKPG/y1OSM8nKYIWzO5YWGkJUEonf+JH5m/4metG0H
         h48TfTeapa+xMTF068cI+ZXpXwh1oow56Xg7VgxdA35HY84rRjFEipEM8MZVjSBfyVlD
         RDpw1Ru2wkdROw+ZJyVWfcuB7RwoqX7B0XA3JlDL0piLh3amE3ybbYqIndbgdpRH2q93
         A/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWsPCaw/7Oqdcv83vlgoGQra9fAELZiKFexUl2zOdHD4NotY2Uf5TWegtw2kau/RgQdwvuLYy7Ivf0zxr9nIyo+R5y0Z0Wp
X-Gm-Message-State: AOJu0YwmbVKKkNq/30el5vqm30ElVCCc5Sm0/i9H2nkgYrmmZFOl93p8
	aG6j44EalSm4m0ov8Rl0HE4ciY12IcOtofQyGTRLxwnduDRp9bi1jE31hH9bnHYjMvZDh9HnuZE
	4APSt2MMcnFbns4ZTMo3T2muAWL6UDzoECxCAL/kWg2h7JD2kzorwCM0=
X-Google-Smtp-Source: AGHT+IERgHkd4uuoZ+3Je2Bx9HBGOS8T1yx931DaNK/jipVmfOTjBPpZ1rECyeaZyHUrMuyZnUOUzjyo8T/ubuuUb+p32FE0mk8b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c04:b0:809:9052:663b with SMTP id
 ca18e2360f4ac-81710040ec1mr5068439f.1.1721323769504; Thu, 18 Jul 2024
 10:29:29 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:29:29 -0700
In-Reply-To: <000000000000fdef8706191a3f7b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3354f061d88ebca@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
From: syzbot <syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17a2f61d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3bdd09ea2371c89
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14608749980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178b9195980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9690deac1819/disk-51835949.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54d261dbb3f0/vmlinux-51835949.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e61465cd524f/bzImage-51835949.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com

------------[ cut here ]------------
no supported rates for sta (null) (0xffffffff, band 0) in rate_mask 0x0 with flags 0x0
WARNING: CPU: 0 PID: 956 at net/mac80211/rate.c:385 __rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Modules linked in:
CPU: 0 PID: 956 Comm: kworker/u8:6 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:__rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Code: 8b 14 24 0f 85 de 01 00 00 8b 0a 48 c7 c7 60 91 e2 8c 48 8b 74 24 10 44 89 f2 44 8b 44 24 1c 44 8b 4c 24 0c e8 98 47 5b f6 90 <0f> 0b 90 90 e9 71 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c db
RSP: 0018:ffffc9000438f4c0 EFLAGS: 00010246
RAX: 2943e4de4f1a2b00 RBX: 000000000000000c RCX: ffff8880210a1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801f2367a8 R08: ffffffff815878a2 R09: fffffbfff1c39d94
R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 0000000000000800
R13: 000000000000000c R14: 00000000ffffffff R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066a010 CR3: 000000007f050000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rate_control_send_low+0x1a8/0x770 net/mac80211/rate.c:405
 rate_control_get_rate+0x20e/0x5e0 net/mac80211/rate.c:921
 ieee80211_tx_h_rate_ctrl+0xc88/0x1a10 net/mac80211/tx.c:763
 invoke_tx_handlers_late+0xb3/0x18e0 net/mac80211/tx.c:1848
 ieee80211_tx+0x2e3/0x470 net/mac80211/tx.c:1969
 __ieee80211_tx_skb_tid_band+0x4e2/0x610 net/mac80211/tx.c:6101
 ieee80211_tx_skb_tid_band net/mac80211/ieee80211_i.h:2297 [inline]
 ieee80211_handle_roc_started+0x267/0x440 net/mac80211/offchannel.c:248
 _ieee80211_start_next_roc+0x7a1/0xb00 net/mac80211/offchannel.c:381
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

