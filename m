Return-Path: <netdev+bounces-202373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F77DAED96F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F681189A9CC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D12254865;
	Mon, 30 Jun 2025 10:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062A253B59
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278238; cv=none; b=U3Y+Air4RVE9XmhM8VZx8BEOSk1wUYwtLbaOlJcHL8st6I0BeG1ElAZgvTkYBl+auIjGFjA4Wpzfh37RUsBmTW+wVn8pY2RFUoUdjPWNJ4mjbedTtI56iDXlmHeKG5d6LP5zPVab6bAnV8uirF1UIFcPu14T26IR/7MiQFaE+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278238; c=relaxed/simple;
	bh=q+GSaN66P/hAbaEd0dbJ3bzboSnxohFm4lWe1BgqdKA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qa5ryw4DTqiLep/UvLWEer82FCP8xmmJcpRso/qf5pC8Sl1vYCIATq9XVjPuSdSkUaTTwOhvCnbZRYjQMw3Gh28UnWGKvj74uEdTDo+v6qUixrkfRzn7cWTEXbDxGTOhZjNMLJ2xQBc/PR2DfeuIfVw2Knw2tDqXdh0jX3wyB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so20754075ab.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278235; x=1751883035;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYZYzPhKsFZqh+UEh+ih+pVdEdOtXAWoeXoCZUGdQ2M=;
        b=J6i8t8/goCeL0eO2uSOArfDA53WfNBUFp4LYzrn5QHG0Y/5ZAbL7MTrXqpcxGTolSs
         Fl8tGDfspTOM8pSeZp1KPRlCWGQ0QRsJ0+FxCmzx5BfwdgPRR7+RT8Pn75yfYnsqqX2/
         SZkJuzlj6BQUqVH4XHOSi6aWWWnD2N3ZRg++m4Zx6Ob15AF3Hi+ZhqrTsBJ/gT+bsRAU
         0ojTv8rhmN3XUbHZnjweyQ9fvm1UobYtncVojNZhdV6IMG0KzPqsINoRtw5FLIElSrqk
         eeTTljDDdaBRziUNRyJXsh9jNPxrcBgcKJPJedN1kpNnzqj4+W0vdtO0njcWMlve0irk
         TCCA==
X-Forwarded-Encrypted: i=1; AJvYcCXp3PAe4GHKis5LRdBb/TH/sIBbw4jpvi+oJfcLR/5Ion3WcObGjLjV6iB/3AmHgPWkNWMmayE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPG9fymWQnv0PppbECYM21gd+qopG0ghfkgQ486F4E7+AMA6mc
	pxdea4w8ngee//dJDeZ2UZe+qLygj4/6p2hvEO0M8BhaTIn83/eyeIUD84EjK/XRSWcLyc1s8pb
	TkIwELl2aK7tHR6Yw9OvJwXb47hsKsf6A/d4NzqOqMSFpV/Pfb3X8cfJ3prM=
X-Google-Smtp-Source: AGHT+IHz5oO5qpbyZBE/sAkrgQEjJ+W7LQ5l+8B8YQm3F/RkV34pJsh1ifMkIJnT3F+aTwJzUkH72FqcP2eRPFrNzWu8M2aWQYDC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d85:b0:3df:2a58:381a with SMTP id
 e9e14a558f8ab-3df4ab2c75dmr153922205ab.3.1751278235044; Mon, 30 Jun 2025
 03:10:35 -0700 (PDT)
Date: Mon, 30 Jun 2025 03:10:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6862629b.a70a0220.2f4de1.0029.GAE@google.com>
Subject: [syzbot] Monthly tipc report (Jun 2025)
From: syzbot <syzbot+list277ba083797cba9f1423@syzkaller.appspotmail.com>
To: jmaloy@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello tipc maintainers/developers,

This is a 31-day syzbot report for the tipc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/tipc

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 84 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 668     Yes   INFO: rcu detected stall in corrupted (4)
                  https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<2> 95      Yes   BUG: soft lockup in do_sock_setsockopt
                  https://syzkaller.appspot.com/bug?extid=10a41dc44eef71aa9450
<3> 10      No    general protection fault in tipc_udp_nl_dump_remoteip (3)
                  https://syzkaller.appspot.com/bug?extid=a9a9a6bca76550defd42

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

