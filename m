Return-Path: <netdev+bounces-142228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C69BDE72
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DA51C21FFC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC07B15C138;
	Wed,  6 Nov 2024 06:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7D36D
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730872824; cv=none; b=k0TgJfB2Xg7AedWvY1GW04BXOdsJ2+33aqCSyWmJpSuzV/Q+IQTC6yxxYbw0VYXiHF6VUxUgBGvdHDVtlj2y1DpHhvgDeqeE0bCdolRoaLPCMtithjzTo8uBCEExChrNpVquGGORFB02ePyRuIKcluxV9/i3/Q2vbm0veMZ+xIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730872824; c=relaxed/simple;
	bh=s9umxTpIEgS1TLgVZGWJVb+LCetzSUKIX+lrzpEhlik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ROY2f9uf/+BVME5uVbQGFCmTFxe2Xf+IggPdB7/Zytj03KGaxFljjRoWqLh/trgXp0JyTA2LTqwFThciychn7J6e3Igv2WO5iJrSiKPaKnJFj7kN1Pq3iQefNK0PIbJIbfRGcAv7J6CQQjcd5nY9yGG0wW6q+/o/sW6vpJ8ljQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab3d46472so641983539f.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 22:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730872822; x=1731477622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mUNiSzm/EPVVXf3yFKOFvSnpCui6+HkIjt8CExUaUk=;
        b=gdl4s9D++YLpac+8bKXjL8rpR9Rzy0t/s0bmK4IO2ky5xzRAhnjSYyz1ZdwVb/NVXU
         R/+wz/uy6cQ0b4dxLz6r6stXMHmvtOeN8TKooJspHQzwP6Z3biQf4qaC285xSl81FTnb
         knaCajScgyflpg3TVGYF+ISxyZ9ymjRLCDaWpJZze0VR9QKQ8ob8vuQk7x90UcPhhkaf
         98WjuoaN5I7AWM9jsfnWxpL1Ry0NASQyen3q94SgkkuQ3MS9vmP1BptG5/ev7UBDc30p
         Jiac1IW3zkypXDPnM2c4Z4tjC3/Ui42/fDu430E6iECtxVCOs6drVkQhlyaVAnrBLUB0
         RzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkHNUNSTpgswT/nZhybMKWB2m+nrzo5NX/rpytVFwPVD2iZ6I7kj9/+FWRQcLNStA4+rRv/l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEnQIWUP6lNdDkN02p+hcMadh1dQb+fZ6zc0hLNdeZ68BH7DE
	X6cyqVm58t0DsMlXuT5TzoGsjCn3f9KWyrfI38v6Ck7gs5nl6FfDiDSwwkuSViGswd8/Sj2Qtzb
	gO0eimsg/4PYWc6ZZxkYYp1wwMkPrEncetYLRMFRaCRapq+rvYsf6VQc=
X-Google-Smtp-Source: AGHT+IG7Nm49PeCxp8fmzPzpfk0wGM8g1MclwazrmHIc3Hl21NU/Mq2uYwlggh4iECnweQH2ewwDcAOlKyuYnu0MuMEdHvkpqKXC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:3a6:b783:3c06 with SMTP id
 e9e14a558f8ab-3a6b7833e0amr162559935ab.19.1730872822105; Tue, 05 Nov 2024
 22:00:22 -0800 (PST)
Date: Tue, 05 Nov 2024 22:00:22 -0800
In-Reply-To: <0000000000005423e30621f745ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b05f6.050a0220.2edce.151e.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in l2tp_exit_net
From: syzbot <syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, guohui.study@gmail.com, 
	horms@kernel.org, jchapman@katalix.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ccb35037c48a Merge branch 'net-lan969x-add-vcap-functional..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16674f40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a36a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c339ec95c42/disk-ccb35037.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/328f6f24277e/vmlinux-ccb35037.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0473d4109fcb/bzImage-ccb35037.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com

bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1153 at net/l2tp/l2tp_core.c:1881 l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
Modules linked in:
CPU: 1 UID: 0 PID: 1153 Comm: kworker/u8:5 Not tainted 6.12.0-rc5-syzkaller-01164-gccb35037c48a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: netns cleanup_net
RIP: 0010:l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
Code: 0f 0b 90 e9 3b ff ff ff e8 b8 31 a5 f6 eb 05 e8 b1 31 a5 f6 90 0f 0b 90 e9 7a ff ff ff e8 a3 31 a5 f6 eb 05 e8 9c 31 a5 f6 90 <0f> 0b 90 eb b5 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004177a98 EFLAGS: 00010293
RAX: ffffffff8aefa87d RBX: ffff888076669088 RCX: ffff8880277abc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90004177bb0 R08: ffffffff8bc11bb6 R09: 1ffffffff203a5d5
R10: dffffc0000000000 R11: fffffbfff203a5d6 R12: dffffc0000000000
R13: 1ffffffff1fdb678 R14: ffff888076669130 R15: ffff888076669040
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffca636d388 CR3: 0000000026e10000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:633
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

