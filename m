Return-Path: <netdev+bounces-203487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C1AF60D4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89665189BA8A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD71309A74;
	Wed,  2 Jul 2025 18:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1816248F54
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479950; cv=none; b=HVyl+v7dZYjog3w/2GV4O6WiSvmh49NBtc3r7T79MfBeRT6tv85ooVjjTbpfXPVHwLnJnuf+zzdwsDni8gLUr+fz4hw0JDfKTV06JunNmjt1jJH71zh2i4q8fD/wDi8F0+43uGLYygJql/uN0QeL0d1wqAsq5PDglUtxdUNbD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479950; c=relaxed/simple;
	bh=Zad38nzaTXnlIB9t3kVegOD+rpkWkXtCsqGNoSAM0n0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BYYfsrBs/EXjtbZu130p4Co86JsUBT2cfQzO6wWZFQ2YmOONqnCs054GYqksi9BWAp3uKV/wMHN/lgRvHzoFEqboBsTJjiwXWmjf6dgmChBbmqtSIXhxFvzSn4pa31hFVPDJBqW5wnQEpD5nIIBKidH+uCTQ/fiVRTu9HlwuRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3df6030ea2fso90270045ab.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 11:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751479948; x=1752084748;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBfvFmvsf3LIHe+Hry49mvAEy5mJzGYi8mtnkVLU1Yw=;
        b=qaPt7dpqpTL7jFDaG+sL7wMgTVhxBvhPEj/pg1NFcDQ0Iboylt4UW+Gp6Au+4Vvkrn
         x+QzESUyKd+n82aR/SBnVoThjW2B01fso5GnwuIdu6cvUvnbSgTOVWCxjocjW4SW2Z1g
         m7LN5ZRbUEedOU9Uj46AQtYMQps6DlwwYADREMOBh/uq48lA08PkSZG0NS3sySflnVlG
         XRD30rHyYnepVbih9Hq5QflFQzHBo8ckF0E6VUkG+ys1nX7mJ/eh/p3meOmvZpHG5vcF
         Z20EIOwoXCYD5mISfg+5DloaT97Ztpx08LQauJ1ojoGr6eA6L4R3OpcuBbROJTdnjG8p
         rKuA==
X-Forwarded-Encrypted: i=1; AJvYcCVGdYa89plxIHW69Ro7i0m8IigvyzvTPSP0lMd83X1XIEfzabMc81PTj31lK0DrjeTKQPRwASU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/flMVj0VQQRojamJtwJTFTL3b/07W3XAAbXt+hPeIzYAJ38RO
	CW55vcf7Zh3zos++3xUTe2GwRae0lsN95LJkYBF4l4NCKW7QDMfBklc4sQ+PrSWH0OSNL6OVQe0
	9d6PyMKoaEgZcLd+ehkV9LrUXb8isVgU2bzeN5QvKWO6WkCsmGA+cwYP6OCg=
X-Google-Smtp-Source: AGHT+IGLFDNn2+1XNe1R6gSea+qf7wQhz2Ew0d5xMoJYu/LipF1INzw8i0E+4/XUKn9oACUYS7nRZgdje7key4mk7XXtJdbWbdoM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1748:b0:3dc:79e5:e696 with SMTP id
 e9e14a558f8ab-3e05c9a1beamr499565ab.11.1751479947999; Wed, 02 Jul 2025
 11:12:27 -0700 (PDT)
Date: Wed, 02 Jul 2025 11:12:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6865768b.a70a0220.5d25f.049a.GAE@google.com>
Subject: [syzbot] [net?] BUG: stack guard page was hit in sock_close
From: syzbot <syzbot+aee2beeb9db53317291f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0b3b7b22dfa Linux 6.16-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d413d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2b65db779ece75e
dashboard link: https://syzkaller.appspot.com/bug?extid=aee2beeb9db53317291f
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d0b3b7b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e546c41cb65b/vmlinux-d0b3b7b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/416735071679/bzImage-d0b3b7b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aee2beeb9db53317291f@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc9000d66fff8 (stack is ffffc9000d670000..ffffc9000d678000)
Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5322 Comm: syz.0.0 Not tainted 6.16.0-rc4-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:clip_push+0x5/0x720 net/atm/clip.c:191
Code: e0 8f aa 8c e8 1c ad 5b fa eb ae 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 20 48 89 f3 49 89 fd 48 bd 00
RSP: 0018:ffffc9000d670000 EFLAGS: 00010246
RAX: 1ffff1100235a4a5 RBX: ffff888011ad2508 RCX: ffff8880003c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888037f01000
RBP: dffffc0000000000 R08: ffffffff8fa104f7 R09: 1ffffffff1f4209e
R10: dffffc0000000000 R11: ffffffff8a99b300 R12: ffffffff8a99b300
R13: ffff888037f01000 R14: ffff888011ad2500 R15: ffff888037f01578
FS:  000055557ab6d500(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d66fff8 CR3: 0000000043172000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 vcc_destroy_socket net/atm/common.c:183 [inline]
 vcc_release+0x157/0x460 net/atm/common.c:205
 __sock_release net/socket.c:647 [inline]
 sock_close+0xc0/0x240 net/socket.c:1391
 __fput+0x449/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff31c98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb5aa1f78 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000012747 RCX: 00007ff31c98e929
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ff31cbb7ba0 R08: 0000000000000001 R09: 0000000db5aa226f
R10: 00007ff31c7ff030 R11: 0000000000000246 R12: 00007ff31cbb608c
R13: 00007ff31cbb6080 R14: ffffffffffffffff R15: 00007fffb5aa2090
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:clip_push+0x5/0x720 net/atm/clip.c:191
Code: e0 8f aa 8c e8 1c ad 5b fa eb ae 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 20 48 89 f3 49 89 fd 48 bd 00
RSP: 0018:ffffc9000d670000 EFLAGS: 00010246
RAX: 1ffff1100235a4a5 RBX: ffff888011ad2508 RCX: ffff8880003c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888037f01000
RBP: dffffc0000000000 R08: ffffffff8fa104f7 R09: 1ffffffff1f4209e
R10: dffffc0000000000 R11: ffffffff8a99b300 R12: ffffffff8a99b300
R13: ffff888037f01000 R14: ffff888011ad2500 R15: ffff888037f01578
FS:  000055557ab6d500(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d66fff8 CR3: 0000000043172000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	e0 8f                	loopne 0xffffff91
   2:	aa                   	stos   %al,%es:(%rdi)
   3:	8c e8                	mov    %gs,%eax
   5:	1c ad                	sbb    $0xad,%al
   7:	5b                   	pop    %rbx
   8:	fa                   	cli
   9:	eb ae                	jmp    0xffffffb9
   b:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  12:	00 00 00
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	f3 0f 1e fa          	endbr64
  29:	55                   	push   %rbp
* 2a:	41 57                	push   %r15 <-- trapping instruction
  2c:	41 56                	push   %r14
  2e:	41 55                	push   %r13
  30:	41 54                	push   %r12
  32:	53                   	push   %rbx
  33:	48 83 ec 20          	sub    $0x20,%rsp
  37:	48 89 f3             	mov    %rsi,%rbx
  3a:	49 89 fd             	mov    %rdi,%r13
  3d:	48                   	rex.W
  3e:	bd                   	.byte 0xbd


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

