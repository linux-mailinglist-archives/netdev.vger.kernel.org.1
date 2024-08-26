Return-Path: <netdev+bounces-121806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E591795EC55
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C581F2119B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE913D630;
	Mon, 26 Aug 2024 08:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E013AD22
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662227; cv=none; b=kQmlI35CtCNnPBuj3KjTqgODXnNSUNj13fsvAirNdyGrECZx+/53H1gLvu0/jKQBSLWdxEJr0zfAJYD9jFeX+e+JKQtdj8BrJPeZNEkTJ2wp3XH0JMM69zsvfJIvRchKMmv0Z4Vj84EI9hMr4PYPYAXXVaj3uM/Lt+IOJTa9zBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662227; c=relaxed/simple;
	bh=/8OMjyMKP32nyWD3bY4RtK1OkgExk79WkqrxLQh+NS0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LEYsHspyxv7odGDA4+vrImncSCYHEa46VCCc7hIjJKu/XNw6P7V2v1vdz+IAfRPQNZxIkPwKsIUqF1k7yPa+n2Jhb6XOirJbSinBN/mwayKoFTmZBBvY0luKgzqMz3FetSf3OQVfWlK+aZqmZrOtmqXxYjXt9tZZC02qboVRyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d47fe875cso53866245ab.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662225; x=1725267025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXoA7V26Vu1+mpFmGXBjVYRi2S3dGlbEwoJSJ9UDrig=;
        b=t6uGvcX+tIB8zdjnyWMZg9a2YPoOgeiCoOSYwT8XZECMCVwoZYn3jhcWLe2DAFMRlA
         ZLame00nprR8vje3J0wSUIo7e9p0hWVthHVAMN9IfURRHqdqUFaFjuFRHG/T95kB7VK6
         ADm1QRlG87r1Wap0ulkc4dX4NLIZfTM7kQfrUxjzgCAJujUyzbFA7sshTqmSEmXLtUxx
         NM9OeKk1eKo9Crb9AM/lHETN6itwATtweSmBDhJx6oR3ZBj89MUftI05eyBqHp4WrjUy
         hlavnffsXmuXj3Q7vTBmH8NEaK6p0tLZ71JDbdIEy3VjVuHb+cBvbV90wus0uChMs5M1
         eh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXn8H1iEUHOc/SYmPDsBHoREgNqApBG6fi9jdjGuFx1qJsLnIn4IPOIoMcab9ShRHBvKUtivH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrg1WlzWgYWoM9WlDd9572KIubIObl1BZMRfUVVsLMsSNoadu
	HnsTtOioJZ1nYHKmQJ23OZ1ir2E64c/YqLePvGGsAtDBaccn+MH8sKA1f8WEl5Z7DkL/KCyQHCM
	ZqhFPbULNH8rlR/iAf1Jcv2TzNqIp+hHjIbWq5Tsb2a2wNY4bu9tScVA=
X-Google-Smtp-Source: AGHT+IEV++OBemK7/oFbA+zcWD9z7Jd4TCNWsuVgFp+gXUej/hQrOCotr3aDAFXs7fQWo0SESxSbW4xwFzd/0chZe4t8TncsWIYw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:39a:e900:7e3e with SMTP id
 e9e14a558f8ab-39e3c9f0512mr10870965ab.3.1724662224873; Mon, 26 Aug 2024
 01:50:24 -0700 (PDT)
Date: Mon, 26 Aug 2024 01:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045769206209237db@google.com>
Subject: [syzbot] [net?] WARNING: lock held when returning to user space in ethnl_act_cable_test
From: syzbot <syzbot+c641161e97237326ea74@syzkaller.appspotmail.com>
To: andrew@lunn.ch, christophe.leroy@csgroup.eu, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux@treblig.org, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9db28bb09f4 Merge branch 'net-redundant-judgments'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115eb015980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=c641161e97237326ea74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d2d609980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1741fbf5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/585e02f7fe7b/disk-f9db28bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9faf5d24900/vmlinux-f9db28bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9df5868ea4f/bzImage-f9db28bb.xz

The issue was bisected to:

commit 3688ff3077d3f334cee1d4b61d8bfb6a9508c2d2
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Wed Aug 21 15:10:05 2024 +0000

    net: ethtool: cable-test: Target the command to the requested PHY

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146fcd8d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166fcd8d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=126fcd8d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")

================================================
WARNING: lock held when returning to user space!
6.11.0-rc4-syzkaller-00565-gf9db28bb09f4 #0 Not tainted
------------------------------------------------
syz-executor124/5240 is leaving the kernel with locks still held!
1 lock held by syz-executor124/5240:
 #0: ffffffff8fc84b88 (rtnl_mutex){+.+.}-{3:3}, at: ethnl_act_cable_test+0x187/0x3f0 net/ethtool/cabletest.c:74


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

