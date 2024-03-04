Return-Path: <netdev+bounces-76957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4532486FAA5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F211C20D41
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72923134C5;
	Mon,  4 Mar 2024 07:23:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C9134B4
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537006; cv=none; b=cPVb6gmdp6cJ/bjLo6P2r/YaOfdUdRrvR/ecOf7hUi51aIyVyjGbsf2SZT+q4OJdQoDklIQQRvFRlcH6aT5a193PD2OlkSIQauu+UDlQjhoCMl/L25NiG6k64jFvvseG0dyEf4b3eWmXUKtOh92XMx1LHuFhAufU9j17wLJ2/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537006; c=relaxed/simple;
	bh=uZVPkag5AAXBeA+sFAklmErR3BGsvvJg/HeilNA4UWc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e+er5/of1qoYHrVNQXvqEl0bO/20KAs8s/AFWBiAEjXnUrgAiLp+rVJslWNTdIUAcH60/ew6ONQhe9/etzX1mIKrKLqdAz0TNb1b4BE4Qp+5nnnVPuP7a8NZ0VXpvlsDSUYpVixPmeeJ8Nt3LE1Wg5/dB61P+xdCOK+xNnu09lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8440b33b6so126799539f.1
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 23:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709537004; x=1710141804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tpG0eDwWW5kcoi19UELPjP4fL+iOhGGTyJmkrVdifU=;
        b=f+h1bmCuzCz6+hL9Q0k211TxTApIjy5jsYmvsDdtmc4N+0JddPWTMAKfq5BT2pqxo6
         CacH5cc4zNf7N9yXUbPW/0/RYlD7d6kHPtf7GtRlNNDLiniyl+Y3JNDn9WupdYfIgbCi
         Wr0eE8Yz1Co3rIzu8FcZ0ZJl2zSrH0VURXUAjLYGNX3llNq5LPv8naN7QbLbujJP1k6v
         hAciIl+TiRtLjxYfFKc3JIMNzlbc2TYY/oHqa4QyNmU0x+fkIYbt+oMhPiNX3QsPmJkc
         bv2eaC+jFLIO4cMKQHjnjts1XYzZ5H7BEw53Xsd0NtCWBKt8XEutQES0J5NHCaRKQaIC
         UWYg==
X-Forwarded-Encrypted: i=1; AJvYcCWonENaMZdgWbfpsy2ttKkMoTX73poaRY/tZqPaOPv/GvewiTBNGbS7nyh7s7aohQcbdZ22IQRWc/hByDEOEJyfFOu2CKLy
X-Gm-Message-State: AOJu0YytGqXjdDAqer0dsniHUuMYCgqGWftEVCsWVs5TwYDL6mA2bYe7
	lyuDoovLkYlLVm5kOoDT6/qhkMBXKmPtC6ni/0aSnvHwCcA05HNf0eObg8GhwePkivMrJZfp3dk
	JeOxZyqAFvgubBF2Y+asCKFRbm7wzMnnGNFHrdqxtKuI2tded/rMq03A=
X-Google-Smtp-Source: AGHT+IFjA7/eq7vxEVBVY5D06vCo1DteiS6LkpGXtmk3Tly1vrk328qEQjpu/DZfM2joVCaFNCyjlUKyQSgAds0XeYOjkSA+zkN1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:365:26e3:6e48 with SMTP id
 j29-20020a056e02219d00b0036526e36e48mr664367ila.0.1709537004058; Sun, 03 Mar
 2024 23:23:24 -0800 (PST)
Date: Sun, 03 Mar 2024 23:23:24 -0800
In-Reply-To: <000000000000b18c2406124b652e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db848a0612d09997@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_amsdu_to_8023s
From: syzbot <syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    58c806d867bf Merge tag 'phy-fixes2-6.8' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12374c96180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=d050d437fe47d479d210
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14227612180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134411a2180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2b0ed9886ae/disk-58c806d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/372dff1b6033/vmlinux-58c806d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2b87ebe3e7b/bzImage-58c806d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_amsdu_to_8023s+0x8c1/0x2d40 net/wireless/util.c:856
 ieee80211_amsdu_to_8023s+0x8c1/0x2d40 net/wireless/util.c:856
 __ieee80211_rx_h_amsdu+0x91a/0x13b0 net/mac80211/rx.c:3047
 ieee80211_rx_h_amsdu net/mac80211/rx.c:3133 [inline]
 ieee80211_rx_handlers+0x571a/0x10c40 net/mac80211/rx.c:4141
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4185 [inline]
 ieee80211_prepare_and_rx_handle+0x5640/0x9690 net/mac80211/rx.c:5033
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5239 [inline]
 ieee80211_rx_list+0x642c/0x65d0 net/mac80211/rx.c:5410
 ieee80211_rx_napi+0x84/0x3e0 net/mac80211/rx.c:5433
 ieee80211_rx include/net/mac80211.h:4983 [inline]
 ieee80211_tasklet_handler+0x19f/0x330 net/mac80211/main.c:318
 tasklet_action_common+0x391/0xd30 kernel/softirq.c:780
 tasklet_action+0x26/0x30 kernel/softirq.c:805
 __do_softirq+0x1b7/0x7c5 kernel/softirq.c:553
 run_ksoftirqd+0x24/0x40 kernel/softirq.c:921
 smpboot_thread_fn+0x558/0xa60 kernel/smpboot.c:164
 kthread+0x3ed/0x550 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

Local variable hdr created at:
 ieee80211_amsdu_to_8023s+0x5b/0x2d40 net/wireless/util.c:832
 __ieee80211_rx_h_amsdu+0x91a/0x13b0 net/mac80211/rx.c:3047

CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.8.0-rc6-syzkaller-00278-g58c806d867bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

