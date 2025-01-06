Return-Path: <netdev+bounces-155395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0DA02265
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52EB1884F51
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B791DACBE;
	Mon,  6 Jan 2025 10:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1291DA61B
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157690; cv=none; b=A9IsneSfuYTwOrRnFVsZbDL250mcfT0vrSP4M+CacbZIFzV0RormM5h48sIUgUqlhsONOIhHYZrRLoK5MXeSfSAfdOjpjY+aK9eQAXq8+Xi7h+CLJjdUbIWboIF8UDDRqSaDfGyMQecTTaO4KFP3oIRJBHLCNVGtDP5qm55n2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157690; c=relaxed/simple;
	bh=B4hcu4qSMKw6wTvQOQZ3ExSjrz3ew2Gg0BTF5PBEYXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PaULBOsTW2wFYeouuDVZI/NvSTkpz/bBzTDkXfUV1qbvzytRIFzPKBokxsSKlIrMEmuoa7A9a4bV47humPLzFjmbWserFqHAxRuGf5N5I7CWomeNYcxFI9CsRqMCT7Tg30SLZ34W9EnBtY1cnJSlHkGy+8cCJgeEfhu6WhEoFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so249859945ab.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 02:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157687; x=1736762487;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nyQChLfc2rRmD19C005Kj5s85iS+jkHjFNjrcXSQoU=;
        b=m7wBEWok3UG1hBc8PdrNbb5/5HHd2JFZvJ+yJAdlgOCSo7HvAXNzyP9981Jw7y+T7X
         ix5QjY2Y8a0AdNJK3OxxyZkT8rIs7VtR3r05UV//TQZXWzyFvBnP8I1zvUyFy6WA86tK
         aA1MmNnYaoVVLC/avctFavFYAgfPg2Ad5WuUpTbSbpm/u3+6KqT4X5h1FvKovkKzPWOr
         uKNrVd16ttjsYK8usoZ3O9unmZLL6/lDxoQbGWCF/KSdhmJxUZuLR04VwR9d8Wt/zoMA
         MJzO76QqmRijLba9xBRWlh7zX2R4eSYarMacK+gzKKYQBZqJqvuOCZnphP3BgZajZLgw
         RgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4u2WvrKomSJcGCeDmibFvU+Sd8If2AgiHQWnw212JAZKp5C9z/QX9G0Fho+e7ySkvlcGJn6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGz3qAZFI/a5r77x96O+VHaumMIxoTWpOzVMMCSnwJjXJTBrwW
	zfiCNACszwimppELwyfRMIStdk+Xh2zR5EIXeyxpdUj4uDW94jH1OCmpb+VxfnauwrEd5uIjmPk
	p62uiQZz2cVRxz8INhMphljPMwPoElhclaXa7GFfMrJNB2X5J+pwA5to=
X-Google-Smtp-Source: AGHT+IFc9/3KMt1+SouyypFx6UZx2zpPwZ+5Bgb24cbcGp0TiJLydBhm8qNT76Z1soomj6hz7jahQ2MZPKmojNPHh6Dv+SXrpqDo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2c:b0:3a7:6f5a:e5c7 with SMTP id
 e9e14a558f8ab-3c2d14d23d2mr459723015ab.4.1736157686811; Mon, 06 Jan 2025
 02:01:26 -0800 (PST)
Date: Mon, 06 Jan 2025 02:01:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677ba9f6.050a0220.a40f5.0007.GAE@google.com>
Subject: [syzbot] Monthly net report (Jan 2025)
From: syzbot <syzbot+list9a8edca6d28b0c252332@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 11 new issues were detected and 9 were fixed.
In total, 130 issues are still open and 1564 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  247132  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  39131   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  13861   Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<4>  7883    Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<5>  7045    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<6>  6197    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<7>  6103    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  3994    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<9>  3062    No    possible deadlock in do_ipv6_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=3433b5cb8b2b70933f8d
<10> 2582    Yes   possible deadlock in sockopt_lock_sock
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

