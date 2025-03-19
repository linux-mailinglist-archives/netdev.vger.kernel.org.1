Return-Path: <netdev+bounces-176296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55BA69AD2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CD2189D839
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2521577D;
	Wed, 19 Mar 2025 21:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E5214A71
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419652; cv=none; b=OuBQYpTkJ6d2mVeQrDA1+JCAWzC1Cn1bHCdos7tzyWc/9dDZfMw51cfTK0aQY4FFqbZQoY0mg9ekbzrAjl9YQz+0NPbPqsu7Rhbg+Z7WKshfqtXwHswmt3c0auxUqQ+elwhGWpi/EmX/M+/jp/kpJnlxq0JXtr5et2kSJ51y/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419652; c=relaxed/simple;
	bh=yG4T9nNH2N5xGMJjilcN5AZWkftQcmaDCs0H6C9F1GM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X/1ehCGCSMYUHQ1kg65kNha1Y1uVlqbsp4xQUiGtZXmD7y4X99DuXsjLG2EbXoNuBjcPYQzNKY4UfMXWVWWQupZqF6NUcfzsUfD0pEhNfOCxfN0iznlIsykWu12/0odt6UYbp+ih3Dy98cJv02bGZw9IO7iCR8DSREJmZw3i0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so2582415ab.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419650; x=1743024450;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qY/nusyBLkaT+7tx8zhuJubwT7+e+QzAs+yIBZGHAEo=;
        b=ZeBeBoVqZ1nUJ5IXo+dZKAzJAamW7D1kwqUwHNi3/8akh1Dn+2lhpJCm0LHqimOCP3
         hsJmyT59eYfUt/MSZZxsSey15zib3SpzSUypn8kTDHe+zBWCP90LZdWPsqVvcHxuCNRv
         SM8qWaibTHth0G2tV6uECgDaLuAnbILJZeXas25V+QDjp7USkrYHUP8OWrcjJOleJgtQ
         MBq2R1EG1DqIWWWNl31ZkVJrqGVbbxeoF7Lgr7NEapciaGmkF9TSt7N56W2RDBJehJjn
         Z0rBmsQKZfQ5rNoaBksbH/TdjqD1x+RQ7uhnfzPQPZDgEIbm44v7t0iJWaTIr8cSr9nQ
         8P8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo9rhhrZyPHz3jvv1ETZKDMuub7rgxkYQWaQ3vXWAxI3jlHcPXiE1qCMA1YlQt+o0+10mFjsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvvTyAMgROBdKJiU8vZATANpNn6AtVQ6AY6O7XmvJ7exYRxWf
	ecIaLOsSWEYmB9UvXA6lXQFMxGQ99irTuBECZnceWNSIothi6ZXie2ap5txAbt/85BzdFw35QOA
	JQb2y8HFaQkfk5TsV3/+Sb9oOsXYGgSGev3aJShOn2sJhWGMomUdvhEE=
X-Google-Smtp-Source: AGHT+IE8+/yGNnZ1gsnCXBWXO6rvHzVfh87XxnxS3QI8gA8r0RYh5t2hFpcauWtsyJIY5pvRkv0BZ78LcCMD7zMENYvg56eUi9dX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d04:b0:3d4:2306:6d6 with SMTP id
 e9e14a558f8ab-3d586bfec38mr41382085ab.21.1742419650004; Wed, 19 Mar 2025
 14:27:30 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67db36c1.050a0220.2ca2c6.01ef.GAE@google.com>
Subject: [syzbot] Monthly hams report (Mar 2025)
From: syzbot <syzbot+list33bbae2fb714b9ee1117@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3367    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 219     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<3> 175     No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<4> 63      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

