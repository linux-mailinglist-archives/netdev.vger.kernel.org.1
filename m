Return-Path: <netdev+bounces-83420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF989236D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6492B1F23DD1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208BB39FEB;
	Fri, 29 Mar 2024 18:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667CAD2D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737452; cv=none; b=rr5CenBfLQ+PB2Ug+l4j/QgwVn7XN5SGojsLQ+NnAUy0uYFnbdPScCxrOBgk9n+ISr5tWysd4udLIuma80TEM/eUonCVhcXXnviEZ0D55OsyrIEtb0OMA8xWfTcVN7wjgkKePR3lnKNZz7rH/S/mbr8q220YqQqFoZXBZo/RD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737452; c=relaxed/simple;
	bh=F2gfhsww7XTA3P50A1RX32InMlF8Q/9z+ZW7DdeTxgM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qmGl26BHCWX8kZUgRqnlvOJQogEHx79OC/kor4CDeymctE5U58mFvQfX5rB1JS94z0Ti25efL6iISUpBU47HfdT8FbN84vofg7i3DS9PBfJn5vv6LWhyio4X2d33LOPvQF2FHFnbSM0mbTLV3AZnyt7/U3IsFtaLN5dGbYsLl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-368a41081baso20444075ab.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737450; x=1712342250;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLH3G/wi97DU/DtrnW/ODIbuNOVKTyxl862AdQPOt0k=;
        b=jLLvjeXu09W0RBg3M5fdpJBnHz655u9c5HCkmRiqfIF3o7qrjX0G0RQ5Hv2DKZi2N0
         GzY4fLTHGAcZZKKLLzNAwk6arDQO3QPJgapk0PPvSZk/Y5//flAsgBQicIPEVzZWDn45
         XRwWkD+ODqH+WR1k1VT9J15dh0p8YsjJnBZDs/yBhZ/kjkcHYFa0NfmiywEeXoOggEM+
         VDjr6t67u5XKwuCifhIAir3ZPN6emjS1u8B3JYLKDjRxvFYFHo5yAYYa1ah+bCQsvAI9
         XuVShbVzfWINxyYKh0sYR0EqxoqQI86UHEuP0r+jaJe1liXbn0Im2m41SPXC1rHBw0ix
         bTeA==
X-Forwarded-Encrypted: i=1; AJvYcCWnjQMiEs1fn40GMJStxa8SJtARmjiF0gobm1c6/JVKJhVMZfYWlsR5dGtPvkiPcMXrfhRWaStjake8Gq6xKPG35vA+J3o5
X-Gm-Message-State: AOJu0YyxTTH4SUlICL4wdTcgkaKu6812vUJujfE16UtGFblskpB0gmHs
	+BoFhnqymcz7ElBUGfPUQGCPBBf4OUz0gb5gt128kYgSJ8ss8PaKbPVfGjD1nN2aeKIT6KDAgjR
	+KOAJRZTfCakiylqXMA7QV+5EUJgCFU+f1iXv5fYuJboTQv50MxZxEhU=
X-Google-Smtp-Source: AGHT+IFRfpXx1VnfI0V7Zv8tfOUmGGmfvDvfktxzjg0GMDbH6xeORJdCTMoNoHwSU1EO7q6fta4nRuojWuGCc7GjOPpRVjDT3z+b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c267:0:b0:368:9839:d232 with SMTP id
 h7-20020a92c267000000b003689839d232mr182469ild.4.1711737449863; Fri, 29 Mar
 2024 11:37:29 -0700 (PDT)
Date: Fri, 29 Mar 2024 11:37:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5ee120614d0eef8@google.com>
Subject: [syzbot] Monthly net report (Mar 2024)
From: syzbot <syzbot+liste7bfc894f5476da05e96@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 25 new issues were detected and 14 were fixed.
In total, 83 issues are still open and 1401 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5716    Yes   WARNING in rxrpc_alloc_data_txbuf
                   https://syzkaller.appspot.com/bug?extid=150fa730f40bce72aa05
<2>  4782    Yes   WARNING in sock_map_delete_elem
                   https://syzkaller.appspot.com/bug?extid=2f4f478b78801c186d39
<3>  4300    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<4>  3586    Yes   WARNING in sock_hash_delete_elem
                   https://syzkaller.appspot.com/bug?extid=1c04a1e4ae355870dc7a
<5>  981     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<6>  896     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<7>  684     Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<8>  509     No    possible deadlock in __lock_task_sighand (2)
                   https://syzkaller.appspot.com/bug?extid=34267210261c2cbba2da
<9>  378     Yes   KMSAN: uninit-value in nci_rx_work
                   https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
<10> 323     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

