Return-Path: <netdev+bounces-206566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753A8B037D6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1457189B19E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641B2356CE;
	Mon, 14 Jul 2025 07:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B941233723
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477816; cv=none; b=YsoY1U5RgfebRAr5/7enpZvGhdHVSAK9ZCKWVZAHuAg9i5NYcfPIRNsP5AKCQoprMbiK222pOP//E/FByeNET7h53BadTlBaUxaufF4+MmbffZGL7Fl0+EAjX9eTqP+anGuLgBTXpVx2oJ8qv+phyz3lCxC65V+GWjuJAzbRjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477816; c=relaxed/simple;
	bh=aZKjbtCAQigI5/O0O1r4+Zx0ym0okO/flZnq49hBEjY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HVQ//sksNmG01sA1O2U8T74aTLrAlADeMBci0cS4l6cWi97kUW/rsfkayfsl/3UT22clp3utYp/nEJpKm/mh61MQ/16//unlOxrjLU0HDL1i8s62uOoukbfnlY/yBXfazvs2DM7z2AZ4yLuEJUmRNnCwMdAj/cHn4h3sTG3EpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df6030ea24so37940775ab.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 00:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477814; x=1753082614;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zqd881VU4OBARGjxBc24r4Dp24qLDZb8tBPUqpl9hD4=;
        b=i27MUkYdwXtrgI11P4XaoeXLUiiQUI6rS9HC4vD6GaBJ3O/VvgOO5vtvchMlOfQ5gp
         YGCpkRIOKWV23BKMXvgbWJGFVb7qikFCZthqAwqFikCuhx8sMtINxZjg3qJwuMJCKc4n
         HQhdyFxjcFVYgj9PUjUOH5w4nJXiPQixrVRi7g9MaQyBvaJyXPIcuNzWGjQQeLfgFTmB
         DJmaYb6yYvtz3oiFTn0KbywTWemyGVq9k4A2VSaybNS1k7l3dzZ1IXWodS6XcGBm4FyM
         pk2dYyKW78UwXewgRUhF1hjzAkTWUtRj6CXlvFn8P9AxQHmZEA7kCFXPtnv3FJAj7z76
         /0wg==
X-Forwarded-Encrypted: i=1; AJvYcCXchwBxnecDtZegoxCUX3TsgIaenkcvG6rBKMQHanD736bP4axSdWB0QLu1nLXsWjrn5cXtNCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9SlX4oWNqSqJQ53Enla9p4S5qRDIIv7oOItAp/DCgcWsGgF1P
	ISwoMk6P4NdK8fQfuW2/BtKMEzylYoYxRGhmil1kvlTicmrUG1Xt6yPTbqAXL58f//XNKcnKe5R
	TMokl07arTEsjAfqXC5GoBPBhOkf47WiQ4xlCWf7lsdhQqcx+LXyzVE8eq0U=
X-Google-Smtp-Source: AGHT+IG9dmvIk+gwWywd1I+AytjFzJANqvTfLyf5ysuoMlpZh38uUuDJnU75yenNWCt0ZJBcO6Pdz0prdkKbalO5Dkjw8FeIoDHQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ef:b0:3dd:babf:9b00 with SMTP id
 e9e14a558f8ab-3e253253e62mr118120825ab.1.1752477814567; Mon, 14 Jul 2025
 00:23:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:23:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b076.a70a0220.3b380f.0050.GAE@google.com>
Subject: [syzbot] Monthly net report (Jul 2025)
From: syzbot <syzbot+list776d4b005768e196a1af@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 13 new issues were detected and 12 were fixed.
In total, 140 issues are still open and 1626 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  350506  Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<2>  12874   Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<3>  9216    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<4>  7829    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<5>  7302    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<6>  3260    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<7>  2611    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<8>  1817    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<9>  1580    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<10> 1492    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

