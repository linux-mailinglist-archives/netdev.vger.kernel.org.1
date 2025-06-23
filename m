Return-Path: <netdev+bounces-200152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E38AE36D5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF983A7800
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B11F8BBD;
	Mon, 23 Jun 2025 07:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B011E411C
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663887; cv=none; b=YJiC1DdCLtJTg68tHKc1QTzZz1uoIxsHm+LiMVjyQ5nN9kP4KEayNuLmipzisQ0j1vCAVVFIE+Ow5WjrgZv6XnixBPASi5ZWBZRtSD8K1itiA7yElDJBwWUpjdQDz3KrdO1MNT4ZAWujArZRZusrgXyTquP1J+UF/StQ1KvNS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663887; c=relaxed/simple;
	bh=c0L5Ic9p78fz8025vT4Q+4lIQmNaESDGFZ91EYVrIm0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ebZfTb6fTsfurwQwan+jB7BMLZbcTnARZpeFTRuf7as62ieNowucpu/Qu/v7f9Ejr1TLWqWeXEzinFLHiogKPKNr/IztZ1L+Vrzx9qBU7ioI20t3Mh1etVVkgPcQzaFodB3Ny6dr3CywcmNToeVPr7s4XXHcXr76fpMJgRw7SNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddbec809acso40753715ab.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750663885; x=1751268685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7N6CFb8geC7GFaDZTPC3hB0Jfnej5N6iNsLrQHnvBDM=;
        b=HcVExaPh48iQ0v5Se15WEGJ/mq9bzS1jW1zzM1arSOCdKNG6od8uHcVAfi5rHUN3wz
         oYx+CqTM8JbKzsE+pheXPvBMKXQt1RuBT+t8T8KVll8zv8botx+T/ZJ3ew8tK2nFrzq3
         Idn6CrVCVaKttAhDm3GTFSCwd+V/yb2W91qyE4LPhi5jLsUYzaRA7TPKYPl/Sx1QYjY6
         LYJgxsW45E3GnRWMWHfnAihQRt2MdkI7OxGZunvkswPIxSBQQ6MY8aapW60WIEhQe2qw
         Lk/0fUY40AcHgOVcMuXaV2JF9tuiKHIPn6ZGRBCL5PmyUNAYdo4kR/cDCt3c/zb1L0VP
         BIBw==
X-Forwarded-Encrypted: i=1; AJvYcCXiJsF5QjxvI+99YqHbOj2HQq2O7xV2LZwApUfJIbnnpBtprSrYNPXwX+olQ0x2nP6qBjP73OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANc5mZO+Hnz/vhtm+LClxfm0Rm/IksvahNcZ0c0cgQRZETDRR
	44fwSf1nSjNqbis2H759+80HjxSsj0D6ehNqGdccq8PIMN+zLtI2FmG1LGpGMMFKO70UUJ+rv/i
	KDRRC+w7b5KuWe/feJZHl9a8JlNbUvIZSjLELbVaAAyC7ZFzxCOwnvp5ZakM=
X-Google-Smtp-Source: AGHT+IGC099jadcheZ5mK3WjDhzyW1CBvRHM0bX6E/FnAGPCVWbJoaBDP8C50TaB62x1Y8doz7+TLDaj5ky8vooUeYMc9chkmT03
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3782:b0:3dc:7fa4:834 with SMTP id
 e9e14a558f8ab-3de38cb06a0mr116323135ab.15.1750663885509; Mon, 23 Jun 2025
 00:31:25 -0700 (PDT)
Date: Mon, 23 Jun 2025 00:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685902cd.a00a0220.2e5631.000f.GAE@google.com>
Subject: [syzbot] Monthly hams report (Jun 2025)
From: syzbot <syzbot+list3771629df5fd7b67abcc@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1256    Yes   KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<2> 321     No    KASAN: slab-use-after-free Read in rose_timer_expiry (3)
                  https://syzkaller.appspot.com/bug?extid=942297eecf7d2d61d1f1
<3> 268     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 112     No    possible deadlock in serial8250_handle_irq
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

