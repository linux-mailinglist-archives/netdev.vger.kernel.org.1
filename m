Return-Path: <netdev+bounces-154397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CBA9FD842
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869EB3A2095
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 23:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23641581F8;
	Fri, 27 Dec 2024 23:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C5C8DF
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735341863; cv=none; b=CldSNhPzSwDsGVWCovFLitqk+Dsx8yfYmNhbc06SOtUxmcyLYeUdhuvMULsWRN6k3LWQ9KznN4ElnsjGTBP83a8tZQ2MVkzygnWkSK6Q1TZeKi/kr+pcED4I6mqP2W1cQ+OZ5+BbeM7bDQQg2KC0v+CEsG5rIfCGRsTtwW5Fl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735341863; c=relaxed/simple;
	bh=M+YozeL6DVYW5Flk3Y+Z9EiQorq9bFgeH0WS/KPKYuI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HRdzXcH4VQgJMMZHC6xAbhqjFIUuhTcCxnlRCj9HJcAYWLVn0g88S9LIgYj4nhTJ1GoFn7i0Q7JclPIMpHybJY+mBz95xBCGhzJO5CdU8Cn/6/bs4CTRDhBGSqJkLCpQhYfU2Gh8XjSbVqroQiU4oTerFFzEhgCgLe0uidxVQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a91a13f63fso67417835ab.3
        for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 15:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735341861; x=1735946661;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsJg0jXDx0+seS2f8q7EVn00bGiS4KfVPGbA/5g7GGw=;
        b=JrOnjmUXAnzJX0CsCNHGTEE+PLt/6mC0iulEo+ux3Q3ThQa3P9ijtX4b7OeO+dfMmq
         TT+8xSnq0iT6skd3D0/FuhLuelmXTTKDlsTJ2Yf/IlWAB1CxEYrNZ/urxStyPdciPjb/
         7LNqIEIv+IFZzzjIOCnHk9L6ea/4Qzz6kuStjX7oPbrQ/mCDQ5vMRi1oe06HXpgloMa8
         lknxDiUFbiLsRXZ+CMVFs/qXG/t+btG0+yA/4Qc+VZ4EK4eYFwmRQJugzhXjB+lVd+EL
         no3t87xqNlthM4NGDavksVAtL/BW83B/TG7hsN4MuHNLYW2EAZtCy0ZdHbW21jfwMFCu
         6gdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt8f3wfgcni+PTx/mx7XeOx7ByTN/SZkalQasd28bi0+rUDNb8+elt5K6HERi5hFB0R1qoNW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJ2wYJvr2kXF96GeGVXLuklrLB4QKXO7JVSietY0ekHOeK7Lp
	B9BG7dXKOQdXL8/jJi1KgYADIQGk48lMvclq6p/Pp960UGnaooLgMkgvmX3InFLATSNc8rSvXpw
	/jxjFqPto6TapsmteJ2txXvdj2Qm9ZfXUcM2LXlZI8YefDLR7gOwe79Y=
X-Google-Smtp-Source: AGHT+IGHLZ5OMP9KdesG9+vOWaLuQy01V5AudpKIS0EmUmmnd4H4m9tIed9rgtL6J51SfBf8fw+igOQzuhraUClYp4vZ4ept4RjF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a10:b0:3a7:e0c0:5f0d with SMTP id
 e9e14a558f8ab-3c2d1b9b8c6mr284047145ab.3.1735341861320; Fri, 27 Dec 2024
 15:24:21 -0800 (PST)
Date: Fri, 27 Dec 2024 15:24:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676f3725.050a0220.2f3838.048f.GAE@google.com>
Subject: [syzbot] Monthly ppp report (Dec 2024)
From: syzbot <syzbot+list22d02f3844aa036afc46@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ppp maintainers/developers,

This is a 31-day syzbot report for the ppp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ppp

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 13 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 126     No    INFO: task hung in ppp_exit_net (4)
                  https://syzkaller.appspot.com/bug?extid=32bd764abd98eb40dea8
<2> 71      Yes   inconsistent lock state in valid_state (4)
                  https://syzkaller.appspot.com/bug?extid=d43eb079c2addf2439c3
<3> 1       No    KMSAN: uninit-value in ppp_asynctty_receive (2)
                  https://syzkaller.appspot.com/bug?extid=6aa334c974508e74bc25

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

