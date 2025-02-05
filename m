Return-Path: <netdev+bounces-162972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121EBA28A9C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E3188173E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3644F22E3E8;
	Wed,  5 Feb 2025 12:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60322E3F3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759472; cv=none; b=dV7vCyUqMd73JqWemEu9Jca4jdTcIZfFBE0NftFZhciMebaqMaxSOLlkbXHR5GYwJL8GegqvLlU77Rf84QRWFYGSWY/k0E7EAcg4KKPN4rDlAvOeWzbd1MoGx0RCNP4ZYCOlxEV8OMt4UyMyENBqMhYaCIOrAXbRekKobsHswTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759472; c=relaxed/simple;
	bh=E+Chp3s8bUKJbJTwjy0HsljKNa1akEZPbSJwFVSx0U4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OUQ1rusLGqpj/EMMFGC8pKIxcxOWUSaEPm+g+n3iW2Zyy2xlojYBAOff0xCSn53Cc2DpFe9TH7qV+AWhyy1ryFoLowwXsDWhMDbqjcKTlIGTdBsfnFCDiTcYd1u3Azb4E1tAoNMgKW0Ct6aMflY6BELeUzSm3Us6IFWj5Nf8m+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce7b6225aeso117726975ab.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 04:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759469; x=1739364269;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ge22AivEZoY/4Tv/E+lBQ1CqAf41hkW39t6YWMYZZRk=;
        b=TpJhY/PAmWk+yBzskmcdwth5IKhvafslTe8affOJT13uvYSWo1AJ2oZ4ymA8nPmY0H
         F8KweS4j5k+juA4OYSQUr4w+0kLHhfD+03drOQjA3MMiDwYovitck2VjWVjbLimBjoQL
         kmz+J7T1H/IDadhko3IoIYN00rra2TQm/+O0BZLZy/kjklhAB3SNU4lXu53N8Yhfjg9n
         nmA+XQavqSzd6gSDIxV3AO6IFkJtHQp1LfdMJQ/hn5esqhil0Ri4yl+mQfopxf4LCFFf
         SuRX2lCrti/6TAj8g9Q2gCOxAxYoT1NeT59V/hxmK65ZlrIFWuVEWChh6wp4jNULtELS
         j/2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ92hPl0lGW4hz6LidFbQQLWWQfMJNfNG1uVPwGbbbCtH2AVeF4YyVqg5ay/eU0U62diroG3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzI2gIkXwJQENfIa6aKZ4crbR9WIUqz178+k6EdJBQBxf5YFJ
	Rn4hlN2BAsIwAGCQ+bg1JyPqyTk7XCg4rUHau7kBRNqZPpsFT3lksLn5o+YtUjT2DLjMo7sAHu+
	Wu/0RmriLpz56dKo3YRfcVGHWE3pVTFHQPo2LTVuzoGejbI2NWPjuQJk=
X-Google-Smtp-Source: AGHT+IEpRMR4/QWV3lJbVI70WEuPYeZmtAsmp7udihbvd3N1hnfw2jaJ5AE9gCojOSkyOYWw4yvLtYr1nPYogFm6xoFJIHtIvvJ+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:3cf:c8bf:3b8a with SMTP id
 e9e14a558f8ab-3d04f419163mr27575035ab.7.1738759469649; Wed, 05 Feb 2025
 04:44:29 -0800 (PST)
Date: Wed, 05 Feb 2025 04:44:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a35d2d.050a0220.50516.0054.GAE@google.com>
Subject: [syzbot] Monthly net report (Feb 2025)
From: syzbot <syzbot+list0b88770b4dd3d4e4c89e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 10 new issues were detected and 7 were fixed.
In total, 138 issues are still open and 1579 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  257940  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  46041   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  20019   Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<4>  10645   Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<5>  7383    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<6>  6432    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<7>  6150    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  4524    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<9>  3096    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<10> 2826    Yes   possible deadlock in sockopt_lock_sock
                   https://syzkaller.appspot.com/bug?extid=819a360379cf16b5f0d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

