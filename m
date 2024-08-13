Return-Path: <netdev+bounces-117951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E498950065
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140591F22DA8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E53170A0C;
	Tue, 13 Aug 2024 08:52:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A514F9EF
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539152; cv=none; b=JOU+SkJKzFXoC2089TRbsFvqTS5XQ2N3ClC1smfJpiEc9sHJCU3VdqNiNlISJK8BSxa5BrNIMyHqH0P7G6QY/8Xim+zKvl5u/6CnxkJgh/U64PyzOXcsSt17iS+VwDDTyYO7aZYZh69BpUML3YbbSrqB3RmNH2nASClxlzclhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539152; c=relaxed/simple;
	bh=+Bcb6kT/l2Wr3hUWpbLYOMKyWvb3o/8lV+uOqYxaksI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VuJSxOu2TKgYF1O60OlsUVOo7mmshXG60mHdjjgi9ZcA4o56RFT7ZVhrMCUnVJuwC7nrEY+j1PflPxgD/JTY+66216fwvxsIc88wONKwcwaKa93pQ7J44se1Zwqd7OWihdlByQL+LAIqAwKaDG8hsmE5w1Pue34gaXULN0UtS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3962d4671c7so66973975ab.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539150; x=1724143950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1M4yZgZM5ECQ9txdRioj02m3GqqcYjRV1W6THARg06I=;
        b=QD3pU/TvVpY1VsO8iW5cyq0p8fZZvw1975ALxaWRc3L/hgwRxq59Gyf6SEI7f2OKz9
         gfRYkwsmkifsv0JQL/Ne3S4W9/7LMYSN3+P95PKnL2+knXw21iG3eeHP0E53qrN+RBed
         HvWYKSggvMRAo5QIF+qanF4nXTblZvyIwZlmhcjbeRHbXXXS5MJVZ6g9LjqukS6xDJYF
         e037p/s+W1xac+tZqI0J2KlWpttU+pejB19OHQr9TixfuCk0Q4rErhj9bCq20+UEcSYP
         EBibayzz7TvinzG9L2rNrGyXTEk+U89sSVkfS5pv0jmTMvf4obCCBHekHkZ6pKjFqBQz
         Y2bA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/iU4gyaRDL5LC9J6QN+0V5jtQbt1L4z6zFNgEbMFWV0K03KZKj+H7VhWYnjhsStzSujtHcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb52s3AV4WBwY9JjR26ogfoBG7vL7c8z8bwfpv9zyf9hUkKFf
	uITnD6nAew9JbV7EAJFvLZcGYcO6RIJiSS3Nh9aLAZ30nzh1t8UjHvTx2eyUL7vqk9nA8s2uieO
	pjgAqL7QY5p89UNK/eFfNnyLxMEkZ5BLBnjhRk39+NQHGdUXeWdzkAMs=
X-Google-Smtp-Source: AGHT+IFfTNImxWMbZM+Pv1Wbn2yHaBKHKtF6QkwAUOtHkkrR7ePkWDuEDg/w2rtuNeuVCzVS63WUHXQIJ11y0A8LXBwKfXTq+hpG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c565:0:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-39c477c14f5mr2134065ab.1.1723539149773; Tue, 13 Aug 2024
 01:52:29 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:52:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c76df0061f8cba62@google.com>
Subject: [syzbot] Monthly hams report (Aug 2024)
From: syzbot <syzbot+list1dc52af7778b04ad1d14@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 270     Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 257     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 32      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302
<4> 20      No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<5> 9       Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

