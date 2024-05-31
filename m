Return-Path: <netdev+bounces-99656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A88D5AB8
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7181F235B1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0DC80C1D;
	Fri, 31 May 2024 06:48:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFE28DA0
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138113; cv=none; b=gyvE67zThMIFR+hjg5qcVE7X17iXRZ6Qbnr5RcKg1g8Lg4+7HY572XvXjXlS8BQu5B9ZWY0pcmtNZm4ArnUGXsXadCx+Bmy9fKK/ERgdG5tg/5QYF/QCOfy0rkaYuo5RTVRKoXz+X3w6I1lwXaJ53uI4kaoDOPTuFf/CW7OnXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138113; c=relaxed/simple;
	bh=qivUw7f0iVhUehwdSWwvcJpdzxYS2h3SyJlIKeuqBww=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nk0WqobQLrB3aKntc0IoNb333jFzoELXUg5NA5ZbACGvt60Ky4+5wNSwJ/rEfF4S+zfRsK1WgrWpjmajTggEr2wNn6Fz68lcdc4AdDNdwc3bPnFeCVUx8UwlKDbGnFG+T7JqONuJw/0FGRF7AWEI2wPyr4jVVeeYjeGcgxZlf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eac3b73a53so197038639f.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138112; x=1717742912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPZc/5ish8L/JwOZvC7ChlN8WdWLFQ894K+NxOgkXEc=;
        b=DxU61iLMs53gOloSrLupAVjJRIt0jZsCLFY62w1uXdcO0KRsZRvqu5mZQSlJ026F1d
         6EYMskdVOgPPXFxHnFDxjHREX82bWrzvLe3WJMe731LAfUVqOtXDIVSAcJ5XeNwWjaMl
         ES9zsW12dFNDFXLmAyXCXyoPDWK2qhYgKNOeZ7lXYM9qO5McUOlQXhrsAQ7L9pp3YUee
         f1dXBD2jjT801flXh9dMXu6m2mLu5R0LklIkIKYBXLje3LWGJ9nGUXMRKoQSK9G1HqOv
         ZuSmZwck/uT4K4D9Z00bUCUI52HFF1uPsr+C9AX7bKvOpiUV9GKf8L75wEl7dAMpi+IK
         JeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWufaPbiRdEtRG93iW7/fpovuH6O4Rqxx0cQJJYoveBa2ZSCAiBO/BK2QTr5yURUfmILniP50zrGmD1gWpiYuholOcQ6YBH
X-Gm-Message-State: AOJu0YywAwz63pitDSaingzFN9q7ETWWwf9zihloAd1Jh2lHaTsEnFev
	+ZlxRrXscxqezpelNDsgnXN4dSf5qH6VJDsMukEySHRuH92xL2c5Yga8+8yjwPDv5m2etbwJ4AQ
	7+0tLgtzP2c9x4MiPT764LtNYoz6ohLpnQA5Yg/NNgmZL2rf8wbPzBYs=
X-Google-Smtp-Source: AGHT+IEc3P5LtBhsqyNjS5ws4um1Pv4U75o5yh/t8TKdP+IHi8wJygRfnfgtlKQFplWF8SecCX5sGnC2Nrl36l7oIgQ88z22P+sY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:292b:b0:488:d489:3963 with SMTP id
 8926c6da1cb9f-4b541f5aae1mr6890173.1.1717138111779; Thu, 30 May 2024 23:48:31
 -0700 (PDT)
Date: Thu, 30 May 2024 23:48:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ee1580619ba5fb4@google.com>
Subject: [syzbot] Monthly net report (May 2024)
From: syzbot <syzbot+listce1365cc6514a1f8f55f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 18 new issues were detected and 7 were fixed.
In total, 94 issues are still open and 1447 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  27358   Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  4787    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<3>  3655    Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<4>  2060    Yes   WARNING in skb_ensure_writable
                   https://syzkaller.appspot.com/bug?extid=0c4150bff9fff3bf023c
<5>  1243    Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<6>  1214    Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<7>  1067    Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<8>  990     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<9>  807     Yes   possible deadlock in sock_map_delete_elem
                   https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
<10> 791     No    INFO: task hung in addrconf_dad_work (4)
                   https://syzkaller.appspot.com/bug?extid=46af9e85f01be0118283

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

