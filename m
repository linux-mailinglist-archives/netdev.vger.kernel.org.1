Return-Path: <netdev+bounces-149897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656C69E8086
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5806A163CA0
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11114A4E1;
	Sat,  7 Dec 2024 16:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75657145B0F
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733587948; cv=none; b=DgF/1vA2Iktzeh2REPB2Vp5XWrdZx/5k7DIzWhHYfsbK6uNvj3M/+UiB1mlLfvQHVsTzaZ8B864P0sJqKumZ7bbk5iKPETwD4DuHOTtRSNdvQ0m8bGojV+gooAXD/4+RNYiKgfqFJmuBcAPpBuwpV1gSfuvy84nmOXeFMhXyCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733587948; c=relaxed/simple;
	bh=BM0qNEKyoqiw5u8Eq/oGv7Qwv3jU51gvmnBUjHvD21M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MX3TLUEa/MBUwBB8xnhvKQIeDNHGvlt1xZaMTtuGkLHkuFCcQqpNnDfXoyG9MTKwIIJFR/W/bDg5xDPiSxAsT1gowKPICzHI/KUDjWwD5Jh9h9S+dHUYE2FEeU581iJanH3YhGZiTeuPruuUseZX+rGxhQWy3e5mazBUwBgFsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843e91a4b37so319192239f.3
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 08:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733587946; x=1734192746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrkbXyO1gWQb08Qbhw9tuE++tiqxf0uwJSolasA1Xvo=;
        b=Q9/jZT+601MRO/Tyvc9XpNXS56uPcdyFI/GICU2z4/mhZE29zYLMga4JYl2JMm52Di
         gx9ps22cB7lFgnkweumOHcrhi7bWqZm6TiFtGKdUy7GMl9geCz1koknXyMRwftucyAsx
         d2hzucdSikjpTqyc++qnCcIVChNi4BYQsU7MAsM4/PwuFhtGA6YSTYN/RHSnlhErP7sG
         sfjpgH970AKLcNVFuTFcMA8ko8kULBYWtMnEeJv32ASEmm//D6wpe4WzeXQjtxwIhrgY
         LG/fsnpRtZsVTZl7Cxi3vQI1/aJZ8GLLw6FQ7sY3BW1MZAyOqvuaDnzOITbPuY7CES6s
         c9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUkix8O6qse09777jp2fJhQaqa+i4hE8zmHuLVU18A/HFStN/KvIUM7xkfykWJJbJMYvBPfnRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhShPbNWGpHCvc0ipjIoYFxZp9f9A9N5a8jik2TrksG0unDGd8
	izUkhJA2qeccmyEoEPjyj7V/vak/nMMtFbcfzWWllAIxLr3VcxyVA/zOi3V0IbM09MpaIoxBaCC
	+W5U6vok+dHYy+WQ0nN0VSfnFSvxLyiWWj6JvqfmtTpdBKRg16XyVIgE=
X-Google-Smtp-Source: AGHT+IEZvxHxO79IMt43jnaEdxnKpXMfM/Z9I2CvNRBeP7EJ7AX8ZUHeQbrJi/5uV4buEbpFDP73/EVVEsOs/FkrIU3QxTpW4/wp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3a811d915demr65071415ab.7.1733587946625; Sat, 07 Dec 2024
 08:12:26 -0800 (PST)
Date: Sat, 07 Dec 2024 08:12:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675473ea.050a0220.a30f1.015a.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Dec 2024)
From: syzbot <syzbot+list298a2131cad081a6c900@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 2 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 120     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 4       No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 4       No    WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

