Return-Path: <netdev+bounces-163968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E95A2C338
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AE1188C480
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC31DF247;
	Fri,  7 Feb 2025 13:05:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A42417C9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933524; cv=none; b=PTW5GdF1Z5bNcJXhasIBUosK+QoC83RnFsX2F3+dgq8VqgSk7loBZGP+r7dC1XqZEsIGnkewvclVjr1QaCn1vji4VJ6bqQTPyWyTW6hiIkpOh9p/OxzH9K+zuaHplt5VXg+4JivkPBGnLCWkhiZhipEO8qGRhW/GSJ0CAVqrMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933524; c=relaxed/simple;
	bh=/3TUutAEsyiEiao1f5FuJ2MBJPxkW4v41kYmALIyI0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YwHQCnPJkB3t5ptEeVfzfcdNdnLhGeyetUUPKvsKa8youPh0Eo4WAOrH4IDQaoXpiLat3Q7HuNOm2PRXRCSSVNjSfevby/WXxGBDBNYnBv1poZ66tTkD4rZ7jZfg61QkHzoMyTGHA/hL1OvyGbLLteJC8CqnK9OZT6S7aqPeePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cf6ceaccdbso13771245ab.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738933523; x=1739538323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiVOJOpa7LbU2POENlx9r029/9cBmYAxUUpk+kw3rJE=;
        b=C5xjFdp5bhBCzLP0h5ic6Y797q4jvcl9gXzTT5oC5oUmUTFcql88jVtmAya9nAVYZx
         fxURnOERnne9bHPTd/PLk53yOh31OWSudGClXQqWCas3dPsHq/1b9tHZ9sPwZYVN0Xf3
         /mscrhG+OI1jvY1M1tF2yPOVfSpEWWNZvQug/06Yd/CHzUuXgcxxLvAY2LWf/3bQJ3Iy
         oFVsPejMwnWXVwsRuVnBUqSvwWGi8tt+ewRbVU0YMD/qUUgn7CIT57xYMqdpyDKeUEoO
         cBrdl6REh9Ziu23/8zjn1C5kuaCNe16y2e2dahz5DwjJYDSEJK5Xt/WpMAX+pv4MX9sb
         C8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWrE5HoWYDbVQBSCdklzCpYg0GCmue74D5yPdCoGGMjSNCdZXz39F9z963cQor8mTqyYMiS1mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmxMMMf3QHXvK2+6SDlpBCzcpFcK+U1FUnbqPIO13NdKoI+ny
	3jyCd16oUO6hPR1ondACph2whe84kOmTuxejLVbaAzo015eS+9SW9gO7r3AUj3p1LeLcI6ymNFE
	rRTK8Vn4e5L0QYHac2sGXfI3BvHjxbkIvq8XetK0AVT7RDg5mLEU8leU=
X-Google-Smtp-Source: AGHT+IG0tuY2b6nMAOLuwu6yK48ezZCBaK2ZBL+1JMYx0HTn541i6zfsmHzkEyOTjECukRqzo4b1KBq2R0zJRhzdL0+U7VRNyorx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3cf:fd28:852 with SMTP id
 e9e14a558f8ab-3d13dd0280fmr28382165ab.3.1738933522772; Fri, 07 Feb 2025
 05:05:22 -0800 (PST)
Date: Fri, 07 Feb 2025 05:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a60512.050a0220.2b1e6.0024.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Feb 2025)
From: syzbot <syzbot+list9ffec93ebc4680dc8d34@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 192     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 20      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 11      No    WARNING in __dev_change_net_namespace (3)
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

