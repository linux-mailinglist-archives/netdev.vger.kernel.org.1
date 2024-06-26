Return-Path: <netdev+bounces-106771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E27917952
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC38B22F6A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D90158842;
	Wed, 26 Jun 2024 07:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960A1FBB
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385586; cv=none; b=dFL0NLZ4SdBAPR8HDJfBkMavaRsbu2ToYuZN4mGzjI0OzlE04rPlot+/dhMR637CjdlFviWR8Jq1zD40vwBbdmXGnZBEnMKtwJmUel2Xnu+6P4GKtNG52EcPVb02qeDA3LTYLbK2ns9oLLEc2+29818O0cLDuS2ITKLhsGgYUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385586; c=relaxed/simple;
	bh=K/sjZ0bsXnct0B50cerx4h07K2GOyv5awZbjTVtnqgQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dfd3hNSBJ7abvp/GPACHTZL8IrshWSg6wxFBKdBD25yHJsjGQqEjw9GK2mmm6j2Ohhzu+WGONEWG8Maz1F/t85ncABdu4pwzMmhx0qRnzMeW9z0FlxxUlCXIsiFXAh6Fs/dkFqzB9l6wbnQ97DHfA+tFY8HbkO4lqUC0t9PfoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so951286539f.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719385583; x=1719990383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vkKthIaUSztvZd85keMWza9SGdaYFVhOD50Bc8I1kY=;
        b=CR3VPMfIBZ/vwefLCU6aM5qinMbj1bJ9eksABt+JB42YGlFkCdQrURlHyCM29VHkiY
         s8D5fYnyMFd00P0YFeVHsc5Kgz8qBsDKhKot51TJvG3U3Sz5vFSUpPkn2YReAIieLKSG
         bXKxQ20EFI+o0iguMb56rYJzueJ5byw8HHLfs/YR57KNR6fjirUwE32Tqh72ABmyBLO6
         SjWarMj2XgH8DQWvmYk0BWr0ixZ6nH6/AtJ57B0ZoRfgBXQ4IEIeovDrWRxyXMFjWxr/
         6O7x5jz/VWB5FhJ0psPUU1fA3SSjpnusRBY8mT3cR7SH8gOG3liubWoJj2DXQmWf928D
         /dmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMTLF3H/sWBHuGduGQECivDxNp0v+BJG9OMXk0rzjM33Tz4SKmPF525UaRuABXwYiTwbs/oHuW7+16yQWMOM+wwz4e7Ktf
X-Gm-Message-State: AOJu0YxPXEUPcli1rOqqLT+pAyBbKonNZpjfv/1XSGVYq4dLG35a35eo
	UPjFS9HuCKN4Hd5tWt9aY8es2Eqs3O0XzHyIY0uRiKkAszSjluZrciP3jtjMU9Gsq3dckEFn5zP
	1YBZSoLSFrJCLlmBeLEgMAhRG6OSA3y0adjvz0DQ7K7UoAdbFNUHP3uY=
X-Google-Smtp-Source: AGHT+IHTuHPzxdzSZvKKq4zzo6UrPecfuVVV9bSpX+Sb0vpmECpQo6ODFwF7qRxi+Islf9MC6GHfMrbXeWN06pMq1EeECTXgLPJL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2504:b0:4b0:b123:d9d with SMTP id
 8926c6da1cb9f-4b9efc75e9amr721991173.5.1719385583623; Wed, 26 Jun 2024
 00:06:23 -0700 (PDT)
Date: Wed, 26 Jun 2024 00:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1b4a1061bc5a659@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_rx_list (2)
From: syzbot <syzbot+1d516edf1e74469ba5d3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    626737a5791b Merge tag 'pinctrl-v6.10-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fc4151980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bd7d605618e43de
dashboard link: https://syzkaller.appspot.com/bug?extid=1d516edf1e74469ba5d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d143806a3cf/disk-626737a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f234013cac68/vmlinux-626737a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/707d3018b571/bzImage-626737a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d516edf1e74469ba5d3@syzkaller.appspotmail.com

netlink: 4 bytes leftover after parsing attributes in process `syz.4.3539'.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 17793 at net/mac80211/rx.c:5345 ieee80211_rx_list+0x14c7/0x2e90 net/mac80211/rx.c:5345
Modules linked in:
CPU: 1 PID: 17793 Comm: syz.4.3539 Not tainted 6.10.0-rc5-syzkaller-00012-g626737a5791b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:ieee80211_rx_list+0x14c7/0x2e90 net/mac80211/rx.c:5345
Code: 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e ca 19 00 00 8b 53 70 4c 89 ee 48 89 ef e8 a4 da fd ff e9 fa ef ff ff e8 fa 0d 30 f7 90 <0f> 0b 90 e9 15 ec ff ff e8 ec 0d 30 f7 90 0f 0b 90 e9 f3 ef ff ff
RSP: 0018:ffffc9000313eba0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc9000e382000
RDX: 0000000000040000 RSI: ffffffff8a5dd5e6 RDI: 0000000000000005
RBP: ffff88806a8ec8c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88806a8ec8c0
R13: ffff88806a8ec998 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f8b5207c6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3a3a0f9d58 CR3: 000000006ff3c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_rx_napi+0xdd/0x400 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_handle_queued_frames+0xd5/0x130 net/mac80211/main.c:437
 ieee80211_stop_device+0x1e/0xe0 net/mac80211/util.c:1570
 ieee80211_do_stop+0x18bd/0x2200 net/mac80211/iface.c:706
 ieee80211_stop+0x11e/0x6b0 net/mac80211/iface.c:765
 __dev_close_many+0x1c5/0x310 net/core/dev.c:1556
 __dev_close net/core/dev.c:1568 [inline]
 __dev_change_flags+0x4dc/0x720 net/core/dev.c:8779
 dev_change_flags+0x8f/0x160 net/core/dev.c:8853
 do_setlink+0x1a42/0x3ff0 net/core/rtnetlink.c:2900
 ?


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

