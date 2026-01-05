Return-Path: <netdev+bounces-247140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA5CF4E3A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F5E13007915
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35163203A1;
	Mon,  5 Jan 2026 17:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E26309DDB
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632674; cv=none; b=L0+Sbx3fL2qSO0eRQR1ee4T1UyuuvsojRWN4nISndWECWWXoZTWSdokoJh4Ui1okZ5yizitQNB4bMmYcbvwY8jWZDKSAcI9oOVkF/AkRTrhfRKWfmmMjyQ3HvTWtsx/Bbh1yX3tqEBpFCj5D2ZPC2AgSrDtfytqq0q7wUIgVwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632674; c=relaxed/simple;
	bh=GdThU3VdKDF6aV4OhYoSpZ4s/M9akpL9NNTerk91V+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r8c0Ni8FXmglVDzIvBKWc+l82aCgvJEIxMLXk6KvfLHyDopoVb41kW9XCoCxM4kA+/Nmt2GzVd8l73nhc5e69pLYc4XHLUpKfbGgH1hooeX8Z3VNm9WJkGMZphfRgi8HbRlyjHVfrlGxUSpwT+vRpPwA81UO0+53fXMfxgxrPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-657486eb435so131985eaf.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767632670; x=1768237470;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMPA9gqwfTiHuo6LEbsVH/x5u4ldW/IcO1ua47o1a5g=;
        b=Wx5zalmOMSHnZs5ClfssbACwrey5ecmJcDJRl6kphXBAh5FCyVY/mX63XaaGYJwuBB
         0eDicJiOxLXYJF64EJazAOElI211DzLajkGhDkL8Ny5g0cJzVq1SWG6utGkVGroPdjgw
         2+LYaypp5699z0u/hgnFg148t1ryl7jjNcTQf5SNMESp2nTkS4ICK/Vz9KiJEMGHRQz0
         W5OTybcxO0DH6Q2jkeTjX84fJ/UF/ssgh6guMfK3rlGGRPfeHtj1OyGKF7y7vlYKhKDN
         rWxy3QTvD/oxTyNts4BIG/SKlOcDhC/XoRReZ3t7h5DSjCB4gWMgVFyb8fOdYrux5Wsb
         mjqA==
X-Forwarded-Encrypted: i=1; AJvYcCWPgSINooaqbIx+NT0nFMSYpIqtCUX/9y+Ow2Kaz5NiMEFSGyQGk7FtbEb2YL5By+Uugip0bD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBYOnUnjyKb8wP1/mx9rTqCvmkypRgYsrWfCLqsyTHuVJE91K
	4aktobNkZAtakOofC2MRTySUXkbKYjcS5Hs0l+Bv8MRrYy7mDayGzSpj5tIYD+YKW1usxJj2ovs
	DNl/VAyxTafCRFFqYxftBakINy/cfESwFb2J+pGd/eCcVaT86DtHHWU1i6Uo=
X-Google-Smtp-Source: AGHT+IGTS9b4c4WEHYlMjmRwpIP6Fc9raMM2foPlzXHXbN6a+E3FWvE6oujni3ld0Hisg9t2IC+QKTkv6s0ywzsPuJ0qZTiBVrOX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:807:b0:659:9a49:8f13 with SMTP id
 006d021491bc7-65f47a14e2emr69756eaf.36.1767632669962; Mon, 05 Jan 2026
 09:04:29 -0800 (PST)
Date: Mon, 05 Jan 2026 09:04:29 -0800
In-Reply-To: <000000000000dbcd0f061f911231@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695bef1d.050a0220.318c5c.012b.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_scan_done
From: syzbot <syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	lizhi.xu@windriver.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3609fa95fb0f Merge tag 'devicetree-fixes-for-6.19-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dac074580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=189dcafc06865d38178d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135c2f92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175c2f92580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e4b2b971f67c/disk-3609fa95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b03d2a13efd/vmlinux-3609fa95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2727d816c6d5/bzImage-3609fa95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: net/wireless/scan.c:1194 at cfg80211_scan_done+0x2d5/0x460 net/wireless/scan.c:1193, CPU#0: kworker/u8:15/3576
Modules linked in:
CPU: 0 UID: 0 PID: 3576 Comm: kworker/u8:15 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:cfg80211_scan_done+0x2d5/0x460 net/wireless/scan.c:1193
Code: 75 7b 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 7a 8a 9c f7 90 0f 0b 90 e9 25 fe ff ff e8 6c 8a 9c f7 90 <0f> 0b 90 e9 db fe ff ff e8 5e 8a 9c f7 48 8d 3d f7 43 c7 04 67 48
RSP: 0018:ffffc9000d2e78e0 EFLAGS: 00010293
RAX: ffffffff8a2321c4 RBX: ffff88802e603618 RCX: ffff88803083dac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000d2e79a8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1db66ef R12: ffff88802e603600
R13: ffff88802e603678 R14: dffffc0000000000 R15: ffff888031c10860
FS:  0000000000000000(0000) GS:ffff888126cef000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff386e7408 CR3: 000000000d3a8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __ieee80211_scan_completed+0x550/0xb20 net/mac80211/scan.c:505
 cfg80211_wiphy_work+0x2ab/0x450 net/wireless/core.c:438
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

